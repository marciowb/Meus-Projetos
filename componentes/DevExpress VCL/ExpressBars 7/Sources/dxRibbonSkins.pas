{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars components                                      }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
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

unit dxRibbonSkins;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ImgList, ExtCtrls, dxCore, cxClasses, cxGraphics, dxBarSkin, dxBar,
  dxBarSkinConsts, dxGDIPlusAPI, cxLookAndFeelPainters;

const
  //ribbon's form consts
  rfspActiveCaption              = 10000; //don't change order
  rfspInactiveCaption            = 10001;
  rfspActiveCaptionZoomed        = 10002;
  rfspInactiveCaptionZoomed      = 10003;
  rfspActiveCaptionLeftBorder    = 10004;
  rfspInactiveCaptionLeftBorder  = 10005;
  rfspActiveCaptionRightBorder   = 10006;
  rfspInactiveCaptionRightBorder = 10007;
  rfspActiveLeftBorder           = 10008;
  rfspInactiveLeftBorder         = 10009;
  rfspActiveRightBorder          = 10010;
  rfspInactiveRightBorder        = 10011;
  rfspActiveBottomBorder1        = 10012;
  rfspInactiveBottomBorder1      = 10013;
  rfspActiveBottomBorder2        = 10014;
  rfspInactiveBottomBorder2      = 10015;
  rfspActiveBottomBorder3        = 10016;
  rfspInactiveBottomBorder3      = 10017;
  rfspRibbonForm                 = 10018;

  //border icons
  rfspBorderIconHot              = 10020;
  rfspBorderIconPressed          = 10021;
  rfspBorderIconInactiveHot      = 10022;
  rfspMinimizeNormalIconGlyph    = 10023;
  rfspMinimizeHotIconGlyph       = 10024;
  rfspMinimizePressedIconGlyph   = 10025;
  rfspMinimizeInactiveIconGlyph  = 10026;
  rfspMaximizeNormalIconGlyph    = 10027;
  rfspMaximizeHotIconGlyph       = 10028;
  rfspMaximizePressedIconGlyph   = 10029;
  rfspMaximizeInactiveIconGlyph  = 10030;
  rfspCloseNormalIconGlyph       = 10031;
  rfspCloseHotIconGlyph          = 10032;
  rfspClosePressedIconGlyph      = 10033;
  rfspCloseInactiveIconGlyph     = 10034;
  rfspRestoreNormalIconGlyph     = 10035;
  rfspRestoreHotIconGlyph        = 10036;
  rfspRestorePressedIconGlyph    = 10037;
  rfspRestoreInactiveIconGlyph   = 10038;
  rfspHelpNormalIconGlyph        = 10039;
  rfspHelpHotIconGlyph           = 10040;
  rfspHelpPressedIconGlyph       = 10041;
  rfspHelpInactiveIconGlyph      = 10042;

  //ribbon skin consts
  rspTabNormal                   = 10043;
  rspTabHot                      = 10044;
  rspTabActive                   = 10045;
  rspTabActiveHot                = 10046;
  rspTabFocused                  = 10047;
  rspTabGroupsArea               = 10048;
  rspTabGroupsArea2              = 10049;
  rspTabSeparator                = 10050;
  
  rspQATDefaultGlyph             = 10052;
  rspQATAtBottom                 = 10053;
  rspRibbonClientTopArea         = 10054;

  rspQATNonClientLeft1Vista      = 10055;
  rspQATNonClientLeft2Vista      = 10056;
  rspQATNonClientRightVista      = 10057;
  rspQATPopup                    = 10058;

  rspQATNonClientLeft1Active     = 10059;
  rspQATNonClientLeft1Inactive   = 10060;
  rspQATNonClientLeft2Active     = 10061;
  rspQATNonClientLeft2Inactive   = 10062;
  rspQATNonClientRightActive     = 10063;
  rspQATNonClientRightInactive   = 10064;

  rspRibbonBackground            = 10065;
  rspRibbonBottomEdge            = 10066;

  rspApplicationButtonNormal     = 10067;
  rspApplicationButtonHot        = 10068;
  rspApplicationButtonPressed    = 10069;

  rspApplicationMenuBorder       = 10070;
  rspApplicationMenuContentHeader= 10071;
  rspApplicationMenuContentFooter= 10072;
  rspDropDownBorder              = 10073;
  rspMenuContent                 = 10074;
  rspMenuGlyph                   = 10075;
  rspMenuMark                    = 10076;
  rspMenuSeparatorHorz           = 10077;
  rspMenuSeparatorVert           = 10078;
  rspMenuArrowDown               = 10079;
  rspMenuArrowRight              = 10080;
  rspProgressSolidBand           = 10081;
  rspProgressDiscreteBand        = 10082;
  rspProgressSubstrate           = 10083;
  rspButtonGroupBorderLeft       = 10084;
  rspButtonGroupBorderRight      = 10085;
  rspScrollArrow                 = 10086;
  rspScreenTip                   = 10087;
  rspHelpButton                  = 10088;
  rspApplicationMenuButton       = 10089;

  rspStatusBar                   = 10090;
  rspStatusBarPanel              = 10091;
  rspStatusBarPanelLowered       = 10092;
  rspStatusBarPanelRaised        = 10093;
  rspStatusBarPanelSeparator     = 10094;
  rspStatusBarGripBackground     = 10095;
  rspStatusBarToolbarSeparator   = 10096;
  rspStatusBarSizeGripColor1     = 10098;
  rspStatusBarSizeGripColor2     = 10099;
  rspStatusBarFormLeftPart       = 10100;
  rspStatusBarFormRightPart      = 10104;
  rspStatusBarFormLeftPartDialog = 10108;
  rspStatusBarFormRightPartDialog= 10112;

  rspDropDownGalleryTopSizingBand = 10120;
  rspDropDownGalleryBottomSizingBand = 10121;
  rspDropDownGalleryTopSizeGrip  = 10122;
  rspDropDownGalleryBottomSizeGrip = 10123;
  rspDropDownGalleryVerticalSizeGrip = 10124;
  rspGalleryFilterBand           = 10125;
  rspGalleryGroupHeader          = 10126;

  //ribbon font colors
  rspFormCaptionText             = 10130;
  rspDocumentNameText            = 10131;
  rspTabHeaderText               = 10132;
  rspTabGroupText                = 10133;
  rspTabGroupHeaderText          = 10134;
  rspStatusBarText               = 10138;
  rspContextText                 = 10139;
  rspContextTextOnGlass          = 10140;
  rspContextTextShadow           = 10141;

  //context tabs
  rspContextTabNormal            = 10143;
  rspContextTabHot               = 10144;
  rspContextTabActive            = 10145;
  rspContextTabActiveHot         = 10146;
  rspContextTabFocused           = 10147;
  rspContextTabGroupsArea        = 10148;
  rspContextTabGroupsArea2       = 10149;
  rspContextTabSeparatorBegin    = 10150;
  rspContextTabSeparatorEnd      = 10151;
  rspContextBackground           = 10152;
  rspContextBackgroundGlass      = 10153;
  rspContextTabHeaderText        = 10154;

  //state's groups const
  rspQATGroupButtonActive        = 10200;
  rspQATGroupButtonInactive      = rspQATGroupButtonActive + DXBAR_STATESCOUNT;
  rspArrowDownNormal             = rspQATGroupButtonInactive + DXBAR_STATESCOUNT;
  rspMenuDetachCaptionNormal     = rspArrowDownNormal + DXBAR_STATESCOUNT;
  rspMenuCheckNormal             = rspMenuDetachCaptionNormal + DXBAR_STATESCOUNT;
  rspMenuCheckMarkNormal         = rspMenuCheckNormal + DXBAR_STATESCOUNT;
  rspMenuScrollAreaNormal        = rspMenuCheckMarkNormal + DXBAR_STATESCOUNT;

  rspCollapsedToolbarNormal = rspMenuScrollAreaNormal + DXBAR_STATESCOUNT;
  rspCollapsedToolbarGlyphBackgroundNormal = rspCollapsedToolbarNormal + DXBAR_STATESCOUNT;

  rspEditButtonNormal            = rspCollapsedToolbarGlyphBackgroundNormal + DXBAR_STATESCOUNT;

  rspSmallButtonNormal           = rspEditButtonNormal + DXBAR_STATESCOUNT;
  rspSmallButtonGlyphBackgroundNormal = rspSmallButtonNormal + DXBAR_STATESCOUNT;
  rspSmallButtonDropButtonNormal = rspSmallButtonGlyphBackgroundNormal + DXBAR_STATESCOUNT;

  rspLargeButtonNormal           = rspSmallButtonDropButtonNormal + DXBAR_STATESCOUNT;
  rspLargeButtonGlyphBackgroundNormal = rspLargeButtonNormal + DXBAR_STATESCOUNT;
  rspLargeButtonDropButtonNormal = rspLargeButtonGlyphBackgroundNormal + DXBAR_STATESCOUNT;

  rspButtonGroupNormal           = rspLargeButtonDropButtonNormal + DXBAR_STATESCOUNT;
  rspButtonGroupBorderMiddleNormal = rspButtonGroupNormal + DXBAR_STATESCOUNT;
  rspButtonGroupSplitButtonSeparatorNormal = rspButtonGroupBorderMiddleNormal + DXBAR_STATESCOUNT;

  rspToolbarNormal               = rspButtonGroupSplitButtonSeparatorNormal + DXBAR_STATESCOUNT;
  rspToolbarHeaderNormal         = rspToolbarNormal + DXBAR_STATESCOUNT;

  rspMarkArrowNormal             = rspToolbarHeaderNormal + DXBAR_STATESCOUNT;
  rspMarkTruncatedNormal         = rspMarkArrowNormal + DXBAR_STATESCOUNT;
  rspLaunchButtonBackgroundNormal= rspMarkTruncatedNormal + DXBAR_STATESCOUNT;
  rspLaunchButtonDefaultGlyphNormal = rspLaunchButtonBackgroundNormal + DXBAR_STATESCOUNT;

  rspTabScrollLeftButtonNormal   = rspLaunchButtonDefaultGlyphNormal + DXBAR_STATESCOUNT;
  rspTabScrollRightButtonNormal  = rspTabScrollLeftButtonNormal + DXBAR_STATESCOUNT;
  rspGroupScrollLeftButtonNormal = rspTabScrollRightButtonNormal + DXBAR_STATESCOUNT;
  rspGroupScrollRightButtonNormal= rspGroupScrollLeftButtonNormal + DXBAR_STATESCOUNT;

  rspInRibbonGalleryScrollBarLineUpButtonNormal = rspGroupScrollRightButtonNormal + DXBAR_STATESCOUNT;
  rspInRibbonGalleryScrollBarLineDownButtonNormal = rspInRibbonGalleryScrollBarLineUpButtonNormal + DXBAR_STATESCOUNT;
  rspInRibbonGalleryScrollBarDropDownButtonNormal = rspInRibbonGalleryScrollBarLineDownButtonNormal + DXBAR_STATESCOUNT;

  // For Ribbon 2010
  rfspCloseButtonHot               = rspInRibbonGalleryScrollBarDropDownButtonNormal + DXBAR_STATESCOUNT;
  rfspCloseButtonPressed           = rfspCloseButtonHot + 1;
  rfspCloseButtonInactiveHot       = rfspCloseButtonPressed + 1;
  rspMinimizeRibbonButtonMinimize  = rfspCloseButtonInactiveHot + 1; // 2 states
  rspMinimizeRibbonButtonRestore   = rspMinimizeRibbonButtonMinimize + 2;
  rspMinimizeRibbonButtonPin       = rspMinimizeRibbonButtonRestore + 2;
  rspItemSeparatorHorizontal       = rspMinimizeRibbonButtonPin + 2;
  rspItemSeparatorVertical         = rspItemSeparatorHorizontal + 1;
  rspMDIButtonMinimize             = rspItemSeparatorVertical + 1;
  rspMDIButtonRestore              = rspMDIButtonMinimize + 4;
  rspMDIButtonClose                = rspMDIButtonRestore + 4;
  rspTabsAreaOnGlass               = rspMDIButtonClose + 4;

  rspContextBackgroundMask         = rspTabsAreaOnGlass + 1;
  rspContextTabMaskNormal          = rspContextBackgroundMask + 1;
  rspContextTabMaskHot             = rspContextTabMaskNormal + 1;
  rspContextTabMaskActive          = rspContextTabMaskHot + 1;
  rspContextTabMaskActiveHot       = rspContextTabMaskActive + 1;
  rspContextTabMaskFocused         = rspContextTabMaskActiveHot + 1;

  // Ribbon BackstageView consts
  rbvpBackstageView               = rspContextTabMaskFocused + 1;
  rbvpBackstageViewTopLine        = rbvpBackstageView + 1;
  rbvpBackstageViewMenu           = rbvpBackstageViewTopLine + 1;
  rbvpBackstageViewMenuItem       = rbvpBackstageViewMenu + 1; // 2 states
  rbvpBackstageViewMenuItemHeight = rbvpBackstageViewMenuItem + 2;
  rbvpBackstageViewMenuTabButton  = rbvpBackstageViewMenuItemHeight + 1; // 4 states
  rbvpBackstageViewMenuTabButtonHeight = rbvpBackstageViewMenuTabButton + 4;
  rbvpBackstageViewMenuTabButtonArrow  = rbvpBackstageViewMenuTabButtonHeight + 1;

  // PinButton
  rspPinButtonGlyph = rbvpBackstageViewMenuTabButtonArrow + 1; // 2 states

  //next = rspPinButtonGlyph + 2;

type
  TdxApplicationButtonState = (absNormal, absHot, absPressed);
  TdxBorderDrawIcon = (bdiMinimize, bdiMaximize, bdiRestore, bdiClose, bdiHelp);
  TdxBorderIconState = (bisNormal, bisHot, bisPressed, bisInactive, bisHotInactive);
  TdxInRibbonGalleryScrollBarButtonKind = (gsbkLineUp, gsbkLineDown, gsbkDropDown);
  TdxRibbonMinimizeButtonGlyph = (rmbMinimize, rmbRestore, rmbPin);
  TdxRibbonTabState = (rtsNormal, rtsHot, rtsActive, rtsActiveHot, rtsFocused);
  TdxRibbonStyle = (rs2007, rs2010);

  TdxRibbonFormData = packed record
    Active: Boolean;
    Bounds: TRect;
    Border: TBorderStyle;
    Handle: HWND;
    State: TWindowState;
    Style: TFormStyle;
    DontUseAero: Boolean;
  end;

  TTwoStateArray = array[Boolean] of Integer;
  TThreeStateArray = array[0..2] of Integer;
  TFourStateArray = array[0..3] of Integer;
  TStatesArray = array[0..DXBAR_STATESCOUNT-1] of Integer;

  { TdxCustomRibbonSkin }

  TdxCustomRibbonSkin = class(TdxCustomBarSkin)
  private
    //quick access toolbar
    FQATAtTopLeft: array[Boolean] of TTwoStateArray;
    FQATAtTopRight: TTwoStateArray;
    FQATGlassAtTopLeft: array[Boolean] of Integer;
    FQATGlassAtTopRight: Integer;
    FQATAtBottom: Integer;
    //
    FApplicationMenuBorder: Integer;
    FApplicationMenuButton: Integer;
    FApplicationMenuContentFooter: Integer;
    FApplicationMenuContentHeader: Integer;
    FButtonGroup: TStatesArray;
    FDropDownBorder: Integer;
    FDropDownGalleryBottomSizeGrip: Integer;
    FDropDownGalleryTopSizeGrip: Integer;
    FDropDownGalleryVerticalSizeGrip: Integer;
    FEditButtons: TStatesArray;
    FLaunchButtonDefaultGlyphs: TStatesArray;
    FMenuContent: Integer;
    FMenuGlyph: Integer;
    FMenuMark: Integer;
    FMenuSeparatorHorz: Integer;
    FMenuSeparatorVert: Integer;
    FProgressSubstrate: Integer;
    FScrollArrow: Integer;
    FTabSeparator: Integer;

    FHelpButton: Integer;
    FPinButtonGlyphs: TTwoStateArray;
    FQATGroupButtonActive: TStatesArray;
    FQATGroupButtonInactive: TStatesArray;
    FScreenTip: Integer;

    FLowColors: Boolean;
    procedure AddTwoStateElement(ABitmap: GpBitmap; var AParts; const R, F: TRect;
      ID: Integer; AInterpolationMode: Integer = InterpolationModeNearestNeighbor);
    procedure InternalDrawSeparator(DC: HDC; const R: TRect;
      AHorizontal: Boolean; AColor1, AColor2: TColor);
    procedure LoadThreeStateArray(ABitmap: GpBitmap; R: TRect; const Fixed: TRect;
      var AStateArray: TThreeStateArray; AStartID: Integer;
      AInterpolationMode: Integer = InterpolationModeDefault);
  protected
    function GetStyle: TdxRibbonStyle; virtual;

    procedure DrawBlackArrow(DC: HDC; const R: TRect; AArrowDirection: TcxArrowDirection);
    procedure DrawDropDownGalleryVerticalSizeGrip(DC: HDC; const R: TRect);
    procedure DrawPart(DC: HDC; const R: TRect; AState: Integer); overload;
    procedure DrawPart(const AParts: TStatesArray; DC: HDC; const R: TRect; AState: Integer); overload;
    procedure DrawTabsAreaButton(DC: HDC; const R: TRect; AState: TcxButtonState); virtual;
    procedure GetApplicationMenuContentColors(
      var AInnerBorderColor, AOuterBorderColor, ASideColor: TColor); virtual;

    procedure LoadFormSkin;
    procedure LoadRibbonSkin;

    procedure LoadCommonRibbonSkinBitmap(out ABitmap: GpBitmap); virtual;
    procedure LoadCustomRibbonSkinBitmap(out ABitmap: GpBitmap); virtual; abstract;
    procedure LoadFormSkinBitmap(out ABitmap: GpBitmap); virtual; abstract;

    procedure LoadCommonControlSkinFromBitmap(ABitmap: GpBitmap); virtual;
    procedure LoadCustomControlSkinFromBitmap(ABitmap: GpBitmap); virtual;
    procedure LoadFormSkinFromBitmap(ABitmap: GpBitmap); virtual;

    procedure LoadCommonMenuParts(ABitmap: GpBitmap); virtual;
    procedure LoadCustomButtonParts(ABitmap: GpBitmap); virtual;
    procedure LoadCustomMenuParts(ABitmap: GpBitmap); virtual;
    procedure LoadCustomScreenTip(ABitmap: GpBitmap); virtual;
    procedure LoadCustomScrollArrow(ABitmap: GpBitmap); virtual;
    procedure LoadGallery(ABitmap: GpBitmap); virtual;
    procedure LoadQAT(ABitmap: GpBitmap); virtual;
    procedure LoadTab(ABitmap: GpBitmap); virtual;

    property LowColors: Boolean read FLowColors write FLowColors;
  public
    constructor Create;

    procedure LoadElementParts(ABitmap: GpBitmap;
      var AParts; const R: TRect; AID: Integer; const AFixedSize: TRect;
      const AImageIndexes: array of Byte; const APossibleStates: TdxByteSet;
      AIsTopDown: Boolean = True; AInterpolationMode: Integer = InterpolationModeDefault);

    procedure LoadBitmapFromStream(const AResName: string; out ABitmap: GpBitmap);
    procedure LoadElementPartsFromFile(const AFileName: string;
      var AParts; AID: Integer; const AFixedSize: TRect;
      const AImageIndexes: array of Byte; const APossibleStates: TdxByteSet);

    procedure DrawApplicationButton(DC: HDC; const R: TRect; AState: TdxApplicationButtonState); virtual;
    procedure DrawApplicationMenuBackground(DC: HDC; const R, AContentRect: TRect); virtual;
    procedure DrawApplicationMenuButton(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawApplicationMenuExtraPaneButton(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawApplicationMenuExtraPanePinButton(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawApplicationMenuExtraPanePinButtonGlyph(DC: HDC; const R: TRect; AChecked: Boolean); virtual;
    procedure DrawArrowDown(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawMenuArrowDown(DC: HDC; const R: TRect); virtual;
    procedure DrawMenuArrowRight(DC: HDC; const R: TRect); virtual;
    procedure DrawButtonGroup(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawButtonGroupBorderLeft(DC: HDC; const R: TRect); virtual;
    procedure DrawButtonGroupBorderMiddle(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawButtonGroupBorderRight(DC: HDC; const R: TRect); virtual;
    procedure DrawButtonGroupSplitButtonSeparator(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawCollapsedToolbarBackground(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawCollapsedToolbarGlyphBackground(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawDropDownBorder(DC: HDC; const R: TRect); virtual;
    procedure DrawDropDownGalleryBackground(DC: HDC; const R: TRect); virtual;
    procedure DrawDropDownGalleryBottomSizeGrip(DC: HDC; const R: TRect); virtual;
    procedure DrawDropDownGalleryBottomSizingBand(DC: HDC; const R: TRect); virtual;
    procedure DrawDropDownGalleryBottomVerticalSizeGrip(DC: HDC; const R: TRect); virtual;
    procedure DrawDropDownGalleryTopSizeGrip(DC: HDC; const R: TRect); virtual;
    procedure DrawDropDownGalleryTopSizingBand(DC: HDC; const R: TRect); virtual;
    procedure DrawDropDownGalleryTopVerticalSizeGrip(DC: HDC; const R: TRect); virtual;
    procedure DrawEditArrowButton(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawEditButton(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawEditEllipsisButton(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawEditSpinDownButton(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawEditSpinUpButton(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawFormBorders(DC: HDC; const ABordersWidth: TRect;
      ACaptionHeight: Integer; const AData: TdxRibbonFormData); virtual;
    procedure DrawFormBordersEx(DC: HDC; const ABordersWidth: TRect;
      ACaptionHeight, ACaptionAreaExtention: Integer; const AData: TdxRibbonFormData;
      AHasStatusBar: Boolean); virtual;
    procedure DrawFormBorderIcon(DC: HDC; const R: TRect;
      AIcon: TdxBorderDrawIcon; AState: TdxBorderIconState); virtual;
    procedure DrawFormCaption(DC: HDC; const R: TRect;
      const AData: TdxRibbonFormData; ATabHeadersAreaVisible: Boolean); virtual;
    procedure DrawFormStatusBarPart(DC: HDC; const R: TRect; AIsLeft, AIsActive, AIsRaised, AIsRectangular: Boolean); virtual;
    procedure DrawHelpButton(DC: HDC; const R: TRect; AState: TcxButtonState); virtual;
    procedure DrawHelpButtonGlyph(DC: HDC; const R: TRect; AGlyph: TBitmap); virtual;
    procedure DrawGalleryFilterBandBackground(DC: HDC; const R: TRect); virtual;
    procedure DrawGalleryGroupHeaderBackground(DC: HDC; const R: TRect); virtual;
    procedure DrawGroupScrollButton(DC: HDC; const R: TRect; ALeft: Boolean; AState: Integer); virtual;
    procedure DrawInRibbonGalleryBackground(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawInRibbonGalleryScrollBarBackground(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawInRibbonGalleryScrollBarButton(DC: HDC; const R: TRect;
      AButtonKind: TdxInRibbonGalleryScrollBarButtonKind; AState: Integer); virtual;
    procedure DrawItemSeparator(DC: HDC; const R: TRect; AHorizontal: Boolean); virtual;
    procedure DrawKeyTip(DC: HDC; const R: TRect); virtual;
    procedure DrawLargeButton(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawLargeButtonGlyphBackground(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawLargeButtonDropButton(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawLaunchButtonBackground(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawLaunchButtonDefaultGlyph(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawMDIButton(DC: HDC; const R: TRect; AButton: TdxBarMDIButton; AState: TcxButtonState); virtual;
    procedure DrawMDIButtonGlyph(DC: HDC; const R: TRect; AButton: TdxBarMDIButton; AState: TcxButtonState); virtual;
    procedure DrawMenuCheck(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawMenuCheckMark(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawMenuContent(DC: HDC; const R: TRect); virtual;
    procedure DrawMenuDetachCaption(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawMenuExtraSeparator(DC: HDC; const R: TRect; AHorizontal: Boolean); virtual;
    procedure DrawMenuGlyph(DC: HDC; const R: TRect); virtual;
    procedure DrawMenuMark(DC: HDC; const R: TRect); virtual;
    procedure DrawMenuScrollArea(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawMenuSeparatorHorz(DC: HDC; const R: TRect); virtual;
    procedure DrawMenuSeparatorVert(DC: HDC; const R: TRect); virtual;
    procedure DrawMiniToolbarBackground(DC: HDC; const R: TRect); virtual;
    procedure DrawMinimizeRibbonButton(DC: HDC;
      const R: TRect; AState: TcxButtonState; AMinimized: Boolean); virtual;
    procedure DrawMinimizeRibbonButtonGlyph(DC: HDC; const R: TRect;
      AState: TcxButtonState; AGlyph: TdxRibbonMinimizeButtonGlyph); virtual;
    procedure DrawProgressDiscreteBand(DC: HDC; const R: TRect); virtual;
    procedure DrawProgressSolidBand(DC: HDC; const R: TRect); virtual;
    procedure DrawProgressSubstrate(DC: HDC; const R: TRect); virtual;
    procedure DrawRibbonBackground(DC: HDC; const R: TRect); virtual;
    procedure DrawRibbonClientTopArea(DC: HDC; const R: TRect); virtual;
    procedure DrawRibbonTopFrameArea(DC: HDC; const R: TRect; AUseAeroGlass: Boolean); virtual;
    procedure DrawRibbonTopFrameAreaSeparator(DC: HDC; const R: TRect); virtual;
    procedure DrawScreenTip(DC: HDC; const R: TRect); virtual;
    procedure DrawScrollArrow(DC: HDC; const R: TRect); virtual;
    procedure DrawSeparatorBackground(DC: HDC; const R: TRect); virtual;
    procedure DrawSeparatorLine(DC: HDC; const R: TRect); virtual;
    procedure DrawSmallButton(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawSmallButtonDropButton(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawSmallButtonGlyphBackground(DC: HDC; const R: TRect; AState: Integer); virtual;

    procedure DrawBackstageViewBackground(DC: HDC; const R: TRect); virtual;
    procedure DrawBackstageViewMenuBackground(DC: HDC; const R: TRect); virtual;
    procedure DrawBackstageViewMenuButton(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawBackstageViewTabButton(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawBackstageViewTopLine(DC: HDC; const R: TRect); virtual;

    procedure DrawTab(DC: HDC; const R: TRect; AState: TdxRibbonTabState); virtual;
    procedure DrawTabAreaBackground(DC: HDC; const R: TRect; AActive, AUseAeroGlass: Boolean); virtual;
    procedure DrawTabGroupBackground(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawTabGroupHeaderBackground(DC: HDC; const R: TRect; AState: Integer); virtual;

    procedure DrawContextTabBackground(DC: HDC; const R: TRect; AState: TdxRibbonTabState; AColor: TColor); virtual;
    procedure DrawContextTabSeparator(DC: HDC; const R: TRect; ABeginGroup: Boolean); virtual;
    procedure DrawContextBackground(DC: HDC; const R: TRect; AColor: TColor); virtual;
    procedure DrawContextBackgroundGlass(DC: HDC; const R: TRect; AColor: TColor); virtual;

    procedure DrawMarkArrow(DC: HDC; const R: TRect; AState: Integer); virtual;
    procedure DrawMarkTruncated(DC: HDC; const R: TRect; AState: Integer); virtual;

    procedure DrawTabGroupsArea(DC: HDC; const R: TRect; AIsQATAtBottom: Boolean); virtual;
    procedure DrawContextTabGroupsArea(DC: HDC; const R: TRect; AIsQATAtBottom: Boolean); virtual;
    procedure DrawTabScrollButton(DC: HDC; const R: TRect; ALeft: Boolean; AState: Integer); virtual;
    procedure DrawTabSeparator(DC: HDC; const R: TRect; Alpha: Byte); virtual;

    procedure DrawQuickAccessToolbar(DC: HDC; const R: TRect;
      ABellow, ANonClientDraw, AHasApplicationButton, AIsActive, ADontUseAero: Boolean); virtual;
    procedure DrawQuickAccessToolbarDefaultGlyph(DC: HDC; const R: TRect); virtual;
    procedure DrawQuickAccessToolbarGroupButton(DC: HDC; const R: TRect;
      ABellow, ANonClientDraw, AIsActive: Boolean; AState: Integer); virtual;
    procedure DrawQuickAccessToolbarPopup(DC: HDC; const R: TRect); virtual;

    procedure DrawStatusBar(DC: HDC; const R: TRect); virtual;
    procedure DrawStatusBarGripBackground(DC: HDC; const R: TRect); virtual;
    procedure DrawStatusBarPanel(DC: HDC; const Bounds, R: TRect; AIsLowered: Boolean); virtual;
    procedure DrawStatusBarPanelSeparator(DC: HDC; const R: TRect); virtual;
    procedure DrawStatusBarSizeGrip(DC: HDC; const R: TRect); virtual;
    procedure DrawStatusBarToolbarSeparator(DC: HDC; const R: TRect); virtual;

    procedure AdjustQuickAccessToolbarVertical(var ABounds: TRect; ANonClientDraw, ADontUseAero: Boolean); virtual;
    function ExtendCaptionAreaOnTabs: Boolean; virtual;
    function GetApplicationMenuContentOffset(const ATabsBounds: TRect): TRect; virtual;
    function GetApplicationMenuGlyphSize: TSize; virtual;
    function GetCaptionFontSize(ACurrentFontSize: Integer): Integer; virtual;
    function GetContextFontStyle(const ACurrentFontStyle: TFontStyles): TFontStyles; virtual;
    function GetMenuSeparatorSize: Integer; virtual;
    function GetPartColor(APart: Integer; AState: Integer = 0): TColor; virtual;
    function GetPartContentOffsets(APart: Integer): TRect; virtual;
    function GetPartOffset(APart: Integer): Integer; virtual;
    function GetSkinName: string; virtual;
    function GetQuickAccessToolbarLeftIndent(AHasApplicationButton: Boolean;
      AUseAeroGlass: Boolean): Integer; virtual;
    function GetQuickAccessToolbarMarkButtonOffset(AHasApplicationButton: Boolean;
      ABelow: Boolean): Integer; virtual;
    function GetQuickAccessToolbarOverrideWidth(AHasApplicationButton: Boolean;
      AUseAeroGlass: Boolean): Integer; virtual;
    function GetQuickAccessToolbarRightIndent(AHasApplicationButton: Boolean): Integer; virtual;
    function GetStatusBarSeparatorSize: Integer; virtual;
    function GetWindowBordersWidth(AHasStatusBar: Boolean): TRect; virtual;
    function NeedDrawGroupScrollArrow: Boolean; virtual;
    //
    procedure UpdateBitsPerPixel;
    //
    property Style: TdxRibbonStyle read GetStyle;
  end;

  { TdxCustomRibbonTextureSkin }

  TdxCustomRibbonTexturedSkin = class(TdxCustomRibbonSkin)
  private
    FApplicationButton: TThreeStateArray;
    FArrowsDown: TStatesArray;
    FBorderIconGlyph: array[TdxBorderDrawIcon] of TFourStateArray;
    FBorderIcons: TThreeStateArray;
    FBottomBorderThick: array[Boolean] of TTwoStateArray;
    FBottomBorderThin: TTwoStateArray;
    FButtonGroupBorderLeft: Integer;
    FButtonGroupBorderMiddle: TStatesArray;
    FButtonGroupBorderRight: Integer;
    FButtonGroupSplitButtonSeparator: TStatesArray;
    FCaption: TTwoStateArray;
    FCaptionLeftBorder: TTwoStateArray;
    FCaptionRightBorder: TTwoStateArray;
    FCaptionZoomed: TTwoStateArray;
    FCollapsedToolbarGlyphBackgrounds: TStatesArray;
    FCollapsedToolbars: TStatesArray;
    FContextBackground: Integer;
    FContextBackgroundGlass: Integer;
    FContextTabGroupsArea: TTwoStateArray;
    FContextTabIndex: array[TdxRibbonTabState] of Integer;
    FContextTabSeparator: TTwoStateArray;
    FDropDownGalleryBottomSizingBand: Integer;
    FDropDownGalleryTopSizingBand: Integer;
    FFormStatusBarLeftParts: array[Boolean] of TFourStateArray;
    FFormStatusBarRightParts: array[Boolean] of TFourStateArray;
    FGalleryFilterBand: Integer;
    FGalleryGroupHeader: Integer;
    FGroupScrollButtons: array[Boolean] of TThreeStateArray;
    FInRibbonGalleryScrollBarDropDownButton: TStatesArray;
    FInRibbonGalleryScrollBarLineDownButton: TStatesArray;
    FInRibbonGalleryScrollBarLineUpButton: TStatesArray;
    FLargeButtonDropButtons: TStatesArray;
    FLargeButtonGlyphBackgrounds: TStatesArray;
    FLargeButtons: TStatesArray;
    FLaunchButtonBackgrounds: TStatesArray;
    FLeftBorder: TTwoStateArray;
    FMarkArrow: TStatesArray;
    FMarkTruncated: TStatesArray;
    FMenuArrowDown: Integer;
    FMenuArrowRight: Integer;
    FMenuCheck: TStatesArray;
    FMenuCheckMark: TStatesArray;
    FMenuDetachCaption: TStatesArray;
    FMenuScrollArea: TStatesArray;
    FProgressDiscreteBand: Integer;
    FProgressSolidBand: Integer;
    FQATDefaultGlyph: Integer;
    FQATPopup: Integer;
    FRibbonTopArea: Integer;
    FRightBorder: TTwoStateArray;
    FSmallButtonDropButtons: TStatesArray;
    FSmallButtonGlyphBackgrounds: TStatesArray;
    FSmallButtons: TStatesArray;
    FStatusBar: Integer;
    FStatusBarGripBackground: Integer;
    FStatusBarPanel: Integer;
    FStatusBarPanelLowered: Integer;
    FStatusBarPanelRaised: Integer;
    FStatusBarPanelSeparator: Integer;
    FStatusBarToolbarSeparator: Integer;
    FTabGroupsArea: TTwoStateArray;
    FTabIndex: array[TdxRibbonTabState] of Integer;
    FTabScrollButtons: array[Boolean] of TThreeStateArray;
    FToolbar: TStatesArray;
    FToolbarHeader: TStatesArray;
  protected
    procedure InternalDrawFormBorderIconGlyph(DC: HDC;
      const R: TRect; AIcon: TdxBorderDrawIcon; AState: TdxBorderIconState);

    procedure LoadApplicationButton(ABitmap: GpBitmap); virtual;
    procedure LoadBorderIcons(ABitmap: GpBitmap); virtual;
    procedure LoadBorderIconsGlyphs(ABitmap: GpBitmap; X, Y, AWidth, AHeight: Integer);
    procedure LoadCollapsedToolbar(ABitmap: GpBitmap); virtual;
    procedure LoadCommonButtonParts(ABitmap: GpBitmap);
    procedure LoadCommonControlSkinFromBitmap(ABitmap: GpBitmap); override;
    procedure LoadCommonMenuParts(ABitmap: GpBitmap); override;
    procedure LoadContexts(ABitmap: GpBitmap); virtual;
    procedure LoadCustomButtonParts(ABitmap: GpBitmap); override;
    procedure LoadCustomControlSkinFromBitmap(ABitmap: GpBitmap); override;
    procedure LoadCustomGroup(ABitmap: GpBitmap); virtual;
    procedure LoadCustomMenuParts(ABitmap: GpBitmap); override;
    procedure LoadFormBorders(ABitmap: GpBitmap); virtual;
    procedure LoadFormSkinFromBitmap(ABitmap: GpBitmap); override;
    procedure LoadGallery(ABitmap: GpBitmap); override;
    procedure LoadInRibbonGalleryScrollBarParts(ABitmap: GpBitmap);
    procedure LoadQAT(ABitmap: GpBitmap); override;
    procedure LoadScrollButtons(ABitmap: GpBitmap); virtual;
    procedure LoadStatusBar(ABitmap: GpBitmap); virtual;
    procedure LoadTab(ABitmap: GpBitmap); override;
  public
    procedure DrawApplicationButton(DC: HDC; const R: TRect; AState: TdxApplicationButtonState); override;
    procedure DrawArrowDown(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawButtonGroupBorderLeft(DC: HDC; const R: TRect); override;
    procedure DrawButtonGroupBorderMiddle(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawButtonGroupBorderRight(DC: HDC; const R: TRect); override;
    procedure DrawButtonGroupSplitButtonSeparator(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawCollapsedToolbarBackground(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawCollapsedToolbarGlyphBackground(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawContextBackground(DC: HDC; const R: TRect; AColor: TColor); override;
    procedure DrawContextBackgroundGlass(DC: HDC; const R: TRect; AColor: TColor); override;
    procedure DrawContextTabBackground(DC: HDC; const R: TRect; AState: TdxRibbonTabState; AColor: TColor); override;
    procedure DrawContextTabGroupsArea(DC: HDC; const R: TRect; AIsQATAtBottom: Boolean); override;
    procedure DrawContextTabSeparator(DC: HDC; const R: TRect; ABeginGroup: Boolean); override;
    procedure DrawDropDownGalleryBottomSizingBand(DC: HDC; const R: TRect); override;
    procedure DrawDropDownGalleryTopSizingBand(DC: HDC; const R: TRect); override;
    procedure DrawFormBorders(DC: HDC; const ABordersWidth: TRect;
      ACaptionHeight: Integer; const AData: TdxRibbonFormData); override;
    procedure DrawFormBorderIcon(DC: HDC; const R: TRect;
      AIcon: TdxBorderDrawIcon; AState: TdxBorderIconState); override;
    procedure DrawFormCaption(DC: HDC; const R: TRect;
      const AData: TdxRibbonFormData; ATabHeadersAreaVisible: Boolean); override;
    procedure DrawFormStatusBarPart(DC: HDC; const R: TRect; AIsLeft, AIsActive, AIsRaised, AIsRectangular: Boolean); override;
    procedure DrawGalleryFilterBandBackground(DC: HDC; const R: TRect); override;
    procedure DrawGalleryGroupHeaderBackground(DC: HDC; const R: TRect); override;
    procedure DrawGroupScrollButton(DC: HDC; const R: TRect; ALeft: Boolean; AState: Integer); override;
    procedure DrawInRibbonGalleryScrollBarButton(DC: HDC; const R: TRect;
      AButtonKind: TdxInRibbonGalleryScrollBarButtonKind; AState: Integer); override;
    procedure DrawLargeButton(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawLargeButtonDropButton(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawLargeButtonGlyphBackground(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawLaunchButtonBackground(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawLaunchButtonDefaultGlyph(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawMarkArrow(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawMarkTruncated(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawMDIButton(DC: HDC; const R: TRect; AButton: TdxBarMDIButton; AState: TcxButtonState); override;
    procedure DrawMDIButtonGlyph(DC: HDC; const R: TRect;
      AButton: TdxBarMDIButton; AState: TcxButtonState); override;
    procedure DrawMenuArrowDown(DC: HDC; const R: TRect); override;
    procedure DrawMenuArrowRight(DC: HDC; const R: TRect); override;
    procedure DrawMenuCheck(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawMenuCheckMark(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawMenuDetachCaption(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawMenuScrollArea(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawProgressDiscreteBand(DC: HDC; const R: TRect); override;
    procedure DrawProgressSolidBand(DC: HDC; const R: TRect); override;
    procedure DrawProgressSubstrate(DC: HDC; const R: TRect); override;
    procedure DrawQuickAccessToolbarDefaultGlyph(DC: HDC; const R: TRect); override;
    procedure DrawQuickAccessToolbarPopup(DC: HDC; const R: TRect); override;
    procedure DrawRibbonClientTopArea(DC: HDC; const R: TRect); override;
    procedure DrawSmallButton(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawSmallButtonDropButton(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawSmallButtonGlyphBackground(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawStatusBar(DC: HDC; const R: TRect); override;
    procedure DrawStatusBarGripBackground(DC: HDC; const R: TRect); override;
    procedure DrawStatusBarPanel(DC: HDC; const Bounds, R: TRect; AIsLowered: Boolean); override;
    procedure DrawStatusBarPanelSeparator(DC: HDC; const R: TRect); override;
    procedure DrawStatusBarToolbarSeparator(DC: HDC; const R: TRect); override;
    procedure DrawTab(DC: HDC; const R: TRect; AState: TdxRibbonTabState); override;
    procedure DrawTabGroupBackground(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawTabGroupHeaderBackground(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawTabGroupsArea(DC: HDC; const R: TRect; AIsQATAtBottom: Boolean); override;
    procedure DrawTabScrollButton(DC: HDC; const R: TRect; ALeft: Boolean; AState: Integer); override;
    function GetPartColor(APart: Integer; AState: Integer = 0): TColor; override;
  end;

  { TdxCustomRibbon2010Skin }

  TdxCustomRibbon2010Skin = class(TdxCustomRibbonTexturedSkin)
  private
    FBackstageViewBackground: Integer;
    FBackstageViewMenuBackground: Integer;
    FBackstageViewMenuButton: TTwoStateArray;
    FBackstageViewTabArrow: Integer;
    FBackstageViewTabs: TFourStateArray;
    FBackstageViewTopLine: Integer;
    FCloseButton: TThreeStateArray;
    FContextBackgroundMask: Integer;
    FContextTabMaskIndex: array[TdxRibbonTabState] of Integer;
    FItemsSeparator: TTwoStateArray;
    FMDIButtonGlyphs: array[TdxBarMDIButton] of TFourStateArray;
    FMinimizeRibbonButtonGlyph: array[TdxRibbonMinimizeButtonGlyph] of TTwoStateArray;
    FTabsAreaOnGlass: Integer;
  protected
    function GetStyle: TdxRibbonStyle; override;
    procedure DrawColoredElement(APartIndex: Integer; DC: HDC; const R: TRect; AColor: TColor);
    procedure DrawFormCaptionSeparator(DC: HDC; const R: TRect); virtual;
    //
    procedure LoadApplicationButton(ABitmap: GpBitmap); override;
    procedure LoadBackstageView(ABitmap: GpBitmap);
    procedure LoadBorderIcons(ABitmap: GpBitmap); override;
    procedure LoadCollapsedToolbar(ABitmap: GpBitmap); override;
    procedure LoadCommonControlSkinFromBitmap(ABitmap: GpBitmap); override;
    procedure LoadCommonMenuParts(ABitmap: GpBitmap); override;
    procedure LoadCommonRibbonSkinBitmap(out ABitmap: GpBitmap); override;
    procedure LoadContexts(ABitmap: GpBitmap); override;
    procedure LoadCustomControlSkinFromBitmap(ABitmap: GpBitmap); override;
    procedure LoadCustomGroup(ABitmap: GpBitmap); override;
    procedure LoadFormBorders(ABitmap: GpBitmap); override;
    procedure LoadFormSkinFromBitmap(ABitmap: GpBitmap); override;
    procedure LoadMDIButtons(ABitmap: GpBitmap); virtual;
    procedure LoadStatusBar(ABitmap: GpBitmap); override;
    procedure LoadTab(ABitmap: GpBitmap); override;
  public
    procedure DrawBackstageViewBackground(DC: HDC; const R: TRect); override;
    procedure DrawBackstageViewMenuBackground(DC: HDC; const R: TRect); override;
    procedure DrawBackstageViewMenuButton(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawBackstageViewTabButton(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawBackstageViewTopLine(DC: HDC; const R: TRect); override;

    procedure DrawContextBackground(DC: HDC; const R: TRect; AColor: TColor); override;
    procedure DrawContextBackgroundGlass(DC: HDC; const R: TRect; AColor: TColor); override;
    procedure DrawContextTabBackground(DC: HDC; const R: TRect;
      AState: TdxRibbonTabState; AColor: TColor); override;

    procedure DrawApplicationMenuBackground(DC: HDC; const R, AContentRect: TRect); override;
    procedure DrawButtonGroup(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawFormBorderIcon(DC: HDC; const R: TRect;
      AIcon: TdxBorderDrawIcon; AState: TdxBorderIconState); override;
    procedure DrawFormCaption(DC: HDC; const R: TRect;
      const AData: TdxRibbonFormData; ATabHeadersAreaVisible: Boolean); override;
    procedure DrawItemSeparator(DC: HDC; const R: TRect; AHorizontal: Boolean); override;
    procedure DrawMenuExtraSeparator(DC: HDC; const R: TRect; AHorizontal: Boolean); override;
    procedure DrawMDIButtonGlyph(DC: HDC; const R: TRect;
      AButton: TdxBarMDIButton; AState: TcxButtonState); override;
    procedure DrawMinimizeRibbonButtonGlyph(DC: HDC; const R: TRect;
      AState: TcxButtonState; AGlyph: TdxRibbonMinimizeButtonGlyph); override;
    procedure DrawQuickAccessToolbar(DC: HDC; const R: TRect;
      ABellow, ANonClientDraw, AHasApplicationButton, AIsActive, ADontUseAero: Boolean); override;
    procedure DrawRibbonTopFrameArea(DC: HDC; const R: TRect; AUseAeroGlass: Boolean); override;
    procedure DrawSeparatorLine(DC: HDC; const R: TRect); override;
    function GetApplicationMenuContentOffset(const ATabsBounds: TRect): TRect; override;
    function GetApplicationMenuGlyphSize: TSize; override;
    function GetContextFontStyle(const ACurrentFontStyle: TFontStyles): TFontStyles; override;
    function GetPartColor(APart: Integer; AState: Integer = 0): TColor; override;
    function GetPartContentOffsets(APart: Integer): TRect; override;
    function GetPartOffset(APart: Integer): Integer; override;
    function GetQuickAccessToolbarMarkButtonOffset(AHasApplicationButton, ABelow: Boolean): Integer; override;
    function GetQuickAccessToolbarOverrideWidth(AHasApplicationButton, AUseAeroGlass: Boolean): Integer; override;
    function GetWindowBordersWidth(AHasStatusBar: Boolean): TRect; override;
  end;

  { TdxBlueRibbonSkin }

  TdxBlueRibbonSkin = class(TdxCustomRibbonTexturedSkin)
  protected
    function GetDisplayName: string; override;
    procedure GetApplicationMenuContentColors(
      var AInnerBorderColor, AOuterBorderColor, ASideColor: TColor); override;
    procedure LoadCustomRibbonSkinBitmap(out ABitmap: GpBitmap); override;
    procedure LoadFormSkinBitmap(out ABitmap: GpBitmap); override;
  public
    procedure DrawRibbonTopFrameAreaSeparator(DC: HDC; const R: TRect); override;
    function GetPartColor(APart: Integer; AState: Integer = 0): TColor; override;
  end;

  { TdxBlackRibbonSkin }

  TdxBlackRibbonSkin = class(TdxCustomRibbonTexturedSkin)
  protected
    function GetDisplayName: string; override;
    procedure GetApplicationMenuContentColors(
      var AInnerBorderColor, AOuterBorderColor, ASideColor: TColor); override;
    procedure LoadCustomRibbonSkinBitmap(out ABitmap: GpBitmap); override;
    procedure LoadFormSkinBitmap(out ABitmap: GpBitmap); override;
  public
    procedure DrawRibbonTopFrameAreaSeparator(DC: HDC; const R: TRect); override;
    function GetPartColor(APart: Integer; AState: Integer = 0): TColor; override;
  end;

  { TdxSilverRibbonSkin }

  TdxSilverRibbonSkin = class(TdxBlackRibbonSkin)
  protected
    function GetDisplayName: string; override;
    procedure GetApplicationMenuContentColors(
      var AInnerBorderColor, AOuterBorderColor, ASideColor: TColor); override;
    procedure LoadCustomRibbonSkinBitmap(out ABitmap: GpBitmap); override;
    procedure LoadFormSkinBitmap(out ABitmap: GpBitmap); override;
  public
    procedure DrawRibbonTopFrameAreaSeparator(DC: HDC; const R: TRect); override;
    function GetPartColor(APart: Integer; AState: Integer = 0): TColor; override;
  end;

  { TdxBlueRibbon2010Skin }

  TdxBlueRibbon2010Skin = class(TdxCustomRibbon2010Skin)
  protected
    function GetDisplayName: string; override;
    procedure DrawFormCaptionSeparator(DC: HDC; const R: TRect); override;
    procedure GetApplicationMenuContentColors(
      var AInnerBorderColor, AOuterBorderColor, ASideColor: TColor); override;
    procedure LoadCustomRibbonSkinBitmap(out ABitmap: GpBitmap); override;
    procedure LoadFormSkinBitmap(out ABitmap: GpBitmap); override;
  public
    procedure DrawRibbonTopFrameAreaSeparator(DC: HDC; const R: TRect); override;
    procedure DrawTabAreaBackground(DC: HDC; const R: TRect; AActive, AUseAeroGlass: Boolean); override;
    function GetPartColor(APart: Integer; AState: Integer = 0): TColor; override;
  end;

  { TdxSilverRibbon2010Skin }

  TdxSilverRibbon2010Skin = class(TdxCustomRibbon2010Skin)
  protected
    function GetDisplayName: string; override;
    procedure DrawFormCaptionSeparator(DC: HDC; const R: TRect); override;
    procedure GetApplicationMenuContentColors(
      var AInnerBorderColor, AOuterBorderColor, ASideColor: TColor); override;
    procedure LoadCustomRibbonSkinBitmap(out ABitmap: GpBitmap); override;
    procedure LoadFormSkinBitmap(out ABitmap: GpBitmap); override;
  public
    function GetPartColor(APart: Integer; AState: Integer = 0): TColor; override;
    procedure DrawRibbonTopFrameAreaSeparator(DC: HDC; const R: TRect); override;
    procedure DrawTabAreaBackground(DC: HDC; const R: TRect; AActive, AUseAeroGlass: Boolean); override;
  end;

  { TdxBlackRibbon2010Skin }

  TdxBlackRibbon2010Skin = class(TdxCustomRibbon2010Skin)
  protected
    function GetDisplayName: string; override;
    procedure DrawFormCaptionSeparator(DC: HDC; const R: TRect); override;
    procedure GetApplicationMenuContentColors(
      var AInnerBorderColor, AOuterBorderColor, ASideColor: TColor); override;
    procedure LoadCustomRibbonSkinBitmap(out ABitmap: GpBitmap); override;
    procedure LoadFormSkinBitmap(out ABitmap: GpBitmap); override;
  public
    function GetPartColor(APart: Integer; AState: Integer = 0): TColor; override;
    procedure DrawMenuExtraSeparator(DC: HDC; const R: TRect; AHorizontal: Boolean); override;
    procedure DrawRibbonTopFrameAreaSeparator(DC: HDC; const R: TRect); override;
    procedure DrawTabAreaBackground(DC: HDC; const R: TRect; AActive, AUseAeroGlass: Boolean); override;
  end;

const
  dxRibbonStyleNamePrefixMap: array[TdxRibbonStyle] of string = ('2007', '2010');

function GetColorScheme(const ADisplayName: string; AStyle: TdxRibbonStyle): TdxCustomRibbonSkin; overload;
function GetColorScheme(const AName: string): TdxCustomRibbonSkin; overload;
function IsRectangularFormBottom(const AData: TdxRibbonFormData): Boolean; {$IFDEF DELPHI9} inline; {$ENDIF}
implementation

uses
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
  cxGeometry, dxOffice11, Math, cxDWMApi, dxGDIPlusClasses;

{$R 'skins.res' 'skins.rc'}

const
  DropDownGalleryVerticalSizeGripBitmapSize: TSize = (cx: 18; cy: 7);
  DefaultFixedSize: TRect = (Left: 2; Top: 2; Right: 2; Bottom: 2);

function GetColorScheme(const ADisplayName: string; AStyle: TdxRibbonStyle): TdxCustomRibbonSkin;
begin
  Result := GetColorScheme(ADisplayName + dxRibbonStyleNamePrefixMap[AStyle]);
end;

function GetColorScheme(const AName: string): TdxCustomRibbonSkin;
var
  ASkin: TdxCustomBarSkin;
  I: Integer;
begin
  Result := nil;
  for I := 0 to SkinManager.SkinCount - 1 do
  begin
    ASkin := SkinManager.Skins[I];
    if ASkin is TdxCustomRibbonSkin then
    begin
      if AnsiSameText(ASkin.Name, AName) then
      begin
        Result := TdxCustomRibbonSkin(ASkin);
        Break;
      end;
    end;
  end;
end;

function IsRectangularFormBottom(const AData: TdxRibbonFormData): Boolean;
begin
  Result := (AData.Border in [bsDialog, bsSingle, bsToolWindow]) or
    (AData.Style = fsMDIChild) or (AData.State = wsMinimized);
end;

procedure ExcludeClipRect(DC: HDC; const R: TRect);
begin
  Windows.ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
end;

procedure DrawFrame(DC: HDC; const R: TRect; AColor, ABorderColor: TColor;
  const ABorders: TcxBorders = cxBordersAll; ABorderWidth: Integer = 1);
var
  ABrush: HBRUSH;
  ABounds, ABorderBounds: TRect;
  ABorder: TcxBorder;

  function GetBorderBounds: TRect;
  begin
    Result := R;
    with Result do
      case ABorder of
        bLeft:
          begin
            Right := Left + ABorderWidth;
            Inc(ABounds.Left, ABorderWidth);
          end;
        bTop:
          begin
            Bottom := Top + ABorderWidth;
            Inc(ABounds.Top, ABorderWidth);
          end;
        bRight:
          begin
            Left := Right - ABorderWidth;
            Dec(ABounds.Right, ABorderWidth);
          end;
        bBottom:
          begin
            Top := Bottom - ABorderWidth;
            Dec(ABounds.Bottom, ABorderWidth);
          end;
      end;
  end;

begin
  if cxRectIsEmpty(R) then Exit;
  ABounds := R;
  if ABorders <> [] then
  begin
    ABrush := CreateSolidBrush(ColorToRGB(ABorderColor));
    for ABorder := Low(ABorder) to High(ABorder) do
      if ABorder in ABorders then
      begin
        ABorderBounds := GetBorderBounds;
        if not cxRectIsEmpty(ABorderBounds) then
          FillRect(DC, ABorderBounds, ABrush);
      end;
    DeleteObject(ABrush);
  end;
  if AColor <> clNone then
    FillRectByColor(DC, ABounds, AColor);
end;

procedure OutError;
begin
  raise EdxException.Create('');
end;

{ TdxCustomRibbonSkin }

constructor TdxCustomRibbonSkin.Create;
begin
  inherited Create(DisplayName + dxRibbonStyleNamePrefixMap[Style]);
  LoadFormSkin;
  LoadRibbonSkin;
  UpdateBitsPerPixel;
end;

procedure TdxCustomRibbonSkin.LoadBitmapFromStream(
  const AResName: string; out ABitmap: GpBitmap);
var
  AResStream: TStream;
begin
  AResStream := TResourceStream.Create(HInstance, AResName, RT_RCDATA);
  try
    ABitmap := dxGpGetImageFromStream(AResStream);
  finally
    AResStream.Free;
  end;
end;

procedure TdxCustomRibbonSkin.LoadElementParts(ABitmap: GpBitmap;
  var AParts; const R: TRect; AID: Integer; const AFixedSize: TRect;
  const AImageIndexes: array of Byte; const APossibleStates: TdxByteSet;
  AIsTopDown: Boolean = True; AInterpolationMode: Integer = InterpolationModeDefault);
var
  I, J, AImageIndex: Integer;
  AOffsetSize: TSize;
  ALoadRect: TRect;
begin
  J := 0;
  if AIsTopDown then
  begin
    AOffsetSize.cx := 0;
    AOffsetSize.cy := cxRectHeight(R);
  end
  else
  begin
    AOffsetSize.cx := cxRectWidth(R);
    AOffsetSize.cy := 0;
  end;
  for I := Low(TStatesArray) to High(TStatesArray) do
  begin
    if (APossibleStates = []) or (I in APossibleStates) then
    begin
      if Length(AImageIndexes) = 0 then
        AImageIndex := J
      else
        if J < Length(AImageIndexes) then
          AImageIndex := AImageIndexes[J]
        else
          AImageIndex := 0;
      ALoadRect := cxRectOffset(R, AOffsetSize.cx * AImageIndex, AOffsetSize.cy * AImageIndex);
      Inc(J);
      if cxRectIsEqual(cxEmptyRect, AFixedSize) then
        TStatesArray(AParts)[I] := AddPart1x1(ABitmap, ALoadRect, AID, '', AInterpolationMode)
      else
        TStatesArray(AParts)[I] := AddPart3x3(ABitmap, ALoadRect, AFixedSize, AID, '', AInterpolationMode);
    end;
    Inc(AID);
  end;
end;

procedure TdxCustomRibbonSkin.LoadElementPartsFromFile(const AFileName: string;
  var AParts; AID: Integer; const AFixedSize: TRect;
  const AImageIndexes: array of Byte; const APossibleStates: TdxByteSet);
var
  ABitmap: GpGraphics;
  AImageRect: TRect;
begin
  if not CheckGdiPlus then Exit;
  GdipCheck(GdipLoadImageFromFile(PWideChar(WideString(AFileName)), ABitmap));
  AImageRect.Left := 0;
  AImageRect.Top := 0;
  GdipCheck(GdipGetImageWidth(ABitmap, AImageRect.Right));
  GdipCheck(GdipGetImageHeight(ABitmap, AImageRect.Bottom));
  LoadElementParts(ABitmap, AParts, AImageRect, AID, AFixedSize, AImageIndexes,
    APossibleStates);
  GdipDisposeImage(ABitmap);
end;

//  DRAWING

procedure TdxCustomRibbonSkin.DrawApplicationButton(
  DC: HDC; const R: TRect; AState: TdxApplicationButtonState);
const
  PenColorMap: array[Boolean] of TColor = (clBtnShadow, clWhite);
  BrushColorMap: array[Boolean] of TColor = (clHighlight, clBtnFace);
  TabStateMap: array[TdxApplicationButtonState] of TdxRibbonTabState = (rtsNormal, rtsHot, rtsActive);
var
  ARect: TRect;
  AIndex: Integer;
  APen: HPEN;
  ABrush: HBRUSH;
  B: TLogBrush;
begin
  if Style = rs2010 then
    DrawTab(DC, R, TabStateMap[AState])
  else
  begin
    AIndex := SaveDC(DC);
    try
      APen := CreatePen(PS_SOLID, 3, PenColorMap[AState <> absPressed]);
      ABrush := CreateSolidBrush(BrushColorMap[AState = absNormal]);
      ARect := cxRectInflate(R, -1, -1);
      Dec(ARect.Right);
      Dec(ARect.Bottom);
      SelectObject(DC, APen);
      SelectObject(DC, ABrush);
      Ellipse(DC, ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
      DeleteObject(ABrush);
      DeleteObject(APen);
      APen := CreatePen(PS_SOLID, 1, 0);
      B.lbStyle := BS_NULL;
      B.lbColor := 0;
      B.lbHatch := 0;
      ABrush := CreateBrushIndirect(B);
      SelectObject(DC, APen);
      SelectObject(DC, ABrush);
      Ellipse(DC, ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
      DeleteObject(ABrush);
      DeleteObject(APen);
    finally
      RestoreDC(DC, AIndex);
    end;
  end;
end;

procedure TdxCustomRibbonSkin.DrawApplicationMenuButton(DC: HDC; const R: TRect; AState: Integer);
begin
  if AState = DXBAR_HOT then
    DrawSmallButton(DC, R, AState)
  else
    Parts[FApplicationMenuButton].Draw(DC, R);
end;

procedure TdxCustomRibbonSkin.DrawApplicationMenuBackground(DC: HDC; const R, AContentRect: TRect);
var
  AInnerBorderColor, AOuterBorderColor, ASideColor: TColor;
  AInnerBorderRect, AOuterBorderRect: TRect;
  R1, AHeaderRect, AFooterRect: TRect;
begin
  R1 := cxRectInflate(R, -2, -2);
  AInnerBorderRect := cxRectInflate(AContentRect, 1, 1);
  AOuterBorderRect := cxRectInflate(AInnerBorderRect, 1, 1);
  AHeaderRect := cxRectSetHeight(R1, AOuterBorderRect.Top - R1.Top);
  AFooterRect := cxRectSetTop(R1, AOuterBorderRect.Bottom, R1.Bottom - AOuterBorderRect.Bottom);

  if LowColors then
  begin
    FillRectByColor(DC, AHeaderRect, clMenu);
    FillRectByColor(DC, AFooterRect, clMenu);
    DrawFrame(DC, R, clMenu, clBlack);
  end
  else
  begin
    Parts[FApplicationMenuContentHeader].Draw(DC, AHeaderRect);
    Parts[FApplicationMenuContentFooter].Draw(DC, AFooterRect);
    Parts[FApplicationMenuBorder].Draw(DC, R);
  end;

  GetApplicationMenuContentColors(AInnerBorderColor, AOuterBorderColor, ASideColor);
  DrawFrame(DC, AInnerBorderRect, clNone, AInnerBorderColor);
  DrawFrame(DC, AOuterBorderRect, clNone, AOuterBorderColor);
  FillRectByColor(DC, Rect(AOuterBorderRect.Right, AHeaderRect.Bottom, R1.Right, AFooterRect.Top), ASideColor);
  FillRectByColor(DC, Rect(R1.Left, AHeaderRect.Bottom, AOuterBorderRect.Left, AFooterRect.Top), ASideColor);
end;

procedure TdxCustomRibbonSkin.DrawApplicationMenuExtraPaneButton(DC: HDC; const R: TRect; AState: Integer);
begin
  if AState in [DXBAR_HOT, DXBAR_HOTCHECK] then
    DrawSmallButton(DC, R, DXBAR_HOT);
end;

procedure TdxCustomRibbonSkin.DrawApplicationMenuExtraPanePinButton(
  DC: HDC; const R: TRect; AState: Integer);
begin
  DrawApplicationMenuExtraPaneButton(DC, R, AState);
  DrawApplicationMenuExtraPanePinButtonGlyph(DC, R, AState in [DXBAR_CHECKED, DXBAR_HOTCHECK]);
end;

procedure TdxCustomRibbonSkin.DrawApplicationMenuExtraPanePinButtonGlyph(
  DC: HDC; const R: TRect; AChecked: Boolean);
var
  APart: TdxSkinnedRect;
begin
  APart := Parts[FPinButtonGlyphs[AChecked]];
  APart.Draw(DC, cxRectCenter(R, APart.Size));
end;

procedure TdxCustomRibbonSkin.DrawArrowDown(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawBlackArrow(DC, R, adDown);
end;

procedure TdxCustomRibbonSkin.DrawMenuArrowDown(DC: HDC; const R: TRect);
begin
  DrawBlackArrow(DC, R, adDown);
end;

procedure TdxCustomRibbonSkin.DrawMenuArrowRight(DC: HDC; const R: TRect);
begin
  DrawBlackArrow(DC, R, adRight);
end;

procedure TdxCustomRibbonSkin.DrawButtonGroup(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(FButtonGroup, DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawButtonGroupBorderLeft(DC: HDC; const R: TRect);
begin
end;

procedure TdxCustomRibbonSkin.DrawButtonGroupBorderMiddle(DC: HDC; const R: TRect; AState: Integer);
begin
end;

procedure TdxCustomRibbonSkin.DrawButtonGroupBorderRight(DC: HDC; const R: TRect);
begin
end;

procedure TdxCustomRibbonSkin.DrawButtonGroupSplitButtonSeparator(DC: HDC; const R: TRect; AState: Integer);
begin
end;

procedure TdxCustomRibbonSkin.DrawCollapsedToolbarBackground(
  DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawCollapsedToolbarGlyphBackground(
  DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawDropDownBorder(DC: HDC; const R: TRect);
begin
  Parts[FDropDownBorder].Draw(DC, R);
end;

procedure TdxCustomRibbonSkin.DrawDropDownGalleryBackground(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, GetPartColor(DXBAR_DROPDOWNGALLERY, DXBAR_NORMAL));
end;

procedure TdxCustomRibbonSkin.DrawDropDownGalleryBottomSizeGrip(DC: HDC; const R: TRect);
var
  ARect: TRect;
begin
  ARect := cxRectInflate(R, 0, -3, -2, -1);
  ARect.Left := ARect.Right - cxRectHeight(ARect);
  Parts[FDropDownGalleryBottomSizeGrip].Draw(DC, ARect);
end;

procedure TdxCustomRibbonSkin.DrawDropDownGalleryBottomSizingBand(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, clWindow);
end;

procedure TdxCustomRibbonSkin.DrawDropDownGalleryBottomVerticalSizeGrip(DC: HDC; const R: TRect);
begin
  DrawDropDownGalleryVerticalSizeGrip(DC, Rect(R.Left, R.Top + 1, R.Right, R.Bottom));
end;

procedure TdxCustomRibbonSkin.DrawDropDownGalleryTopSizeGrip(DC: HDC; const R: TRect);
var
  ARect: TRect;
begin
  ARect := cxRectInflate(R, 0, -1, -2, -3);
  ARect.Left := ARect.Right - cxRectHeight(ARect);
  Parts[FDropDownGalleryTopSizeGrip].Draw(DC, ARect);
end;

procedure TdxCustomRibbonSkin.DrawDropDownGalleryTopSizingBand(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, clWindow);
end;

procedure TdxCustomRibbonSkin.DrawDropDownGalleryTopVerticalSizeGrip(DC: HDC; const R: TRect);
begin
  DrawDropDownGalleryVerticalSizeGrip(DC, Rect(R.Left, R.Top, R.Right, R.Bottom - 1));
end;

procedure TdxCustomRibbonSkin.DrawEditArrowButton(DC: HDC; const R: TRect; AState: Integer);
begin
  // do nothing
end;

procedure TdxCustomRibbonSkin.DrawEditButton(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(FEditButtons, DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawEditEllipsisButton(DC: HDC; const R: TRect; AState: Integer);
begin
  // do nothing
end;

procedure TdxCustomRibbonSkin.DrawEditSpinDownButton(DC: HDC; const R: TRect; AState: Integer);
begin
  // do nothing
end;

procedure TdxCustomRibbonSkin.DrawEditSpinUpButton(DC: HDC; const R: TRect; AState: Integer);
begin
  // do nothing
end;

procedure TdxCustomRibbonSkin.DrawFormBorders(DC: HDC;
  const ABordersWidth: TRect; ACaptionHeight: Integer;
  const AData: TdxRibbonFormData);
var
  R: TRect;
begin
  R := AData.Bounds;
  //R.Top := ACaptionHeight + ABordersWidth.Top;
  R.Right := R.Left + 2;
  FillRectByColor(DC, R, clBtnHighlight);
  R.Right := R.Left + ABordersWidth.Left;
  Inc(R.Left, 2);
  FillRectByColor(DC, R, clBtnFace);

  R.Right := AData.Bounds.Right;
  R.Left := R.Right - 1;
  FillRectByColor(DC, R, cl3DDkShadow);
  OffsetRect(R, -1, 0);
  FillRectByColor(DC, R, clBtnShadow);
  R.Right := AData.Bounds.Right - 2;
  R.Left := R.Right - (ABordersWidth.Right - 2);
  FillRectByColor(DC, R, clBtnFace);

  R := AData.Bounds;
  R.Top := R.Bottom - 1;
  FillRectByColor(DC, R, cl3DDkShadow);
  Dec(R.Bottom);
  R.Top := R.Bottom - ABordersWidth.Bottom;
  FillRectByColor(DC, R, clBtnFace);
end;

procedure TdxCustomRibbonSkin.DrawFormBordersEx(DC: HDC;
  const ABordersWidth: TRect; ACaptionHeight, ACaptionAreaExtention: Integer;
  const AData: TdxRibbonFormData; AHasStatusBar: Boolean);
begin
  DrawFormBorders(DC, ABordersWidth, ACaptionHeight + ACaptionAreaExtention, AData);
end;

procedure TdxCustomRibbonSkin.DrawFormBorderIcon(DC: HDC;
  const R: TRect; AIcon: TdxBorderDrawIcon; AState: TdxBorderIconState);
const
  Pushes: array[Boolean] of Integer = (0, DFCS_PUSHED);
  Buttons: array[TdxBorderDrawIcon] of Integer = (
    DFCS_CAPTIONMIN, DFCS_CAPTIONMAX, DFCS_CAPTIONRESTORE,
    DFCS_CAPTIONCLOSE, DFCS_CAPTIONHELP);
begin
  DrawFrameControl(DC, cxRect(R.Left + 1, R.Top + 2, R.Right - 1, R.Bottom),
    DFC_CAPTION, Buttons[AIcon] or Pushes[AState = bisPressed]);
end;

procedure TdxCustomRibbonSkin.DrawFormCaption(DC: HDC;
  const R: TRect; const AData: TdxRibbonFormData; ATabHeadersAreaVisible: Boolean);
var
  ARect: TRect;
begin
  if AData.State <> wsMaximized then
  begin
    ARect := R;
    ARect.Bottom := ARect.Top + 1;
    FillRectByColor(DC, ARect, clBtnHighlight);
    ExcludeClipRect(DC, ARect);
    OffsetRect(ARect, 0, 1);
    FillRectByColor(DC, ARect, clBtnFace);
    ExcludeClipRect(DC, ARect);
  end;
  if AData.Active then
    FillRectByColor(DC, R, clActiveCaption)
  else
    FillRectByColor(DC, R, clInactiveCaption);
end;

procedure TdxCustomRibbonSkin.DrawFormStatusBarPart(
  DC: HDC; const R: TRect; AIsLeft, AIsActive, AIsRaised, AIsRectangular: Boolean);
begin
  FillRectByColor(DC, R, clBtnFace);
end;

procedure TdxCustomRibbonSkin.DrawHelpButton(DC: HDC; const R: TRect; AState: TcxButtonState);
begin
  DrawTabsAreaButton(DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawHelpButtonGlyph(DC: HDC; const R: TRect; AGlyph: TBitmap);
var
  GR: TRect;
begin
  GR := cxRectBounds(R.Left, R.Top, 16, 16);
  OffsetRect(GR, (R.Right - R.Left - 16) div 2, (R.Bottom - R.Top - 16) div 2);
  Parts[FHelpButton].Draw(DC, GR);
end;

procedure TdxCustomRibbonSkin.DrawGalleryFilterBandBackground(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, clWindow);
end;

procedure TdxCustomRibbonSkin.DrawGalleryGroupHeaderBackground(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, clBtnShadow);
end;

procedure TdxCustomRibbonSkin.DrawGroupScrollButton(
  DC: HDC; const R: TRect; ALeft: Boolean; AState: Integer);
begin
  DrawFrame(DC, R, clBtnFace, clBlack);
  DrawSmallButton(DC, R, AState)
end;

procedure TdxCustomRibbonSkin.DrawInRibbonGalleryBackground(DC: HDC;
  const R: TRect; AState: Integer);
begin
  DrawFrame(DC, R, GetPartColor(DXBAR_INRIBBONGALLERY_BACKGROUND, AState),
    GetPartColor(DXBAR_INRIBBONGALLERY_BORDER, AState));
end;

procedure TdxCustomRibbonSkin.DrawInRibbonGalleryScrollBarBackground(
  DC: HDC; const R: TRect; AState: Integer);
begin
  //nothing
end;

procedure TdxCustomRibbonSkin.DrawInRibbonGalleryScrollBarButton(
  DC: HDC; const R: TRect; AButtonKind: TdxInRibbonGalleryScrollBarButtonKind;
  AState: Integer);

  procedure DrawButtonBackground(DC: HDC; const R: TRect);
  begin
    case AState of
      DXBAR_HOT, DXBAR_CHECKED, DXBAR_HOTCHECK:
        DrawFrame(DC, R, clHighlight, clWhite);
      DXBAR_PRESSED:
        DrawFrame(DC, R, clHighlight, clBtnShadow)
      else
        DrawFrame(DC, R, clBtnFace, clBtnShadow);
    end;
  end;

  procedure DrawButtonGlyph(DC: HDC; R: TRect);
  begin
    R := cxRectOffset(R, 1, 0);
    case AButtonKind of
      gsbkLineUp:
        DrawBlackArrow(DC, R, adUp);
      gsbkLineDown:
        DrawBlackArrow(DC, R, adDown);
      gsbkDropDown:
        begin
          DrawBlackArrow(DC, cxRectOffset(R, 0, 2), adDown);
          FillRectByColor(DC, cxRectInflate(cxRectSetBottom(R, R.Top, 1), 3, 0, 0, 0), clBlack);
        end;
    end;
  end;

var
  ASaveIndex: Integer;
  R1: TRect;
begin
  R1 := R;
  ASaveIndex := SaveDC(DC);
  try
    IntersectClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
    Inc(R1.Bottom, Ord(AButtonKind <> gsbkDropDown));
    DrawButtonBackground(DC, R1);
    DrawButtonGlyph(DC, cxRectCenter(R1, 4, 4));
  finally
    RestoreDC(DC, ASaveIndex);
  end;
end;

procedure TdxCustomRibbonSkin.DrawItemSeparator(DC: HDC; const R: TRect; AHorizontal: Boolean);
begin
  InternalDrawSeparator(DC, R, AHorizontal, $EBE8E6, $AAA6A2);
end;

procedure TdxCustomRibbonSkin.DrawKeyTip(DC: HDC; const R: TRect);
begin
  DrawScreenTip(DC, R);
end;

procedure TdxCustomRibbonSkin.DrawLargeButton(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawLargeButtonGlyphBackground(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawLargeButtonDropButton(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawLaunchButtonBackground(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawLaunchButtonDefaultGlyph(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawMDIButton(
  DC: HDC; const R: TRect; AButton: TdxBarMDIButton; AState: TcxButtonState);
begin
  // do nothing
end;

procedure TdxCustomRibbonSkin.DrawMDIButtonGlyph(
  DC: HDC; const R: TRect; AButton: TdxBarMDIButton; AState: TcxButtonState);
const
  Buttons: array[TdxBarMDIButton] of Integer = (
    DFCS_CAPTIONMIN, DFCS_CAPTIONRESTORE, DFCS_CAPTIONCLOSE);
  Pushes: array[Boolean] of Integer = (0, DFCS_PUSHED);
begin
  DrawFrameControl(DC, cxRect(R.Left + 1, R.Top + 3, R.Right - 1, R.Bottom - 3),
    DFC_CAPTION, Buttons[AButton] or Pushes[AState = cxbsPressed]);
end;

procedure TdxCustomRibbonSkin.DrawMenuCheck(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawMenuCheckMark(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawMenuContent(DC: HDC; const R: TRect);
begin
  Parts[FMenuContent].Draw(DC, R);
end;

procedure TdxCustomRibbonSkin.DrawMenuDetachCaption(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawMenuExtraSeparator(
  DC: HDC; const R: TRect; AHorizontal: Boolean);
begin
  InternalDrawSeparator(DC, R, AHorizontal, $F5F5F5, $D8D8D8);
end;

procedure TdxCustomRibbonSkin.DrawMenuGlyph(DC: HDC; const R: TRect);
begin
  Parts[FMenuGlyph].Draw(DC, R);
end;

procedure TdxCustomRibbonSkin.DrawMenuMark(DC: HDC; const R: TRect);
begin
  Parts[FMenuMark].Draw(DC, R);
end;

procedure TdxCustomRibbonSkin.DrawMenuSeparatorHorz(DC: HDC; const R: TRect);
begin
  Parts[FMenuSeparatorHorz].Draw(DC, R);
end;

procedure TdxCustomRibbonSkin.DrawMenuSeparatorVert(DC: HDC; const R: TRect);
begin
  Parts[FMenuSeparatorVert].Draw(DC, R);
end;

procedure TdxCustomRibbonSkin.DrawMiniToolbarBackground(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, GetPartColor(DXBAR_MINITOOLBAR_BACKGROUND));
end;

procedure TdxCustomRibbonSkin.DrawMinimizeRibbonButton(
  DC: HDC; const R: TRect; AState: TcxButtonState; AMinimized: Boolean);
begin
  DrawTabsAreaButton(DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawMinimizeRibbonButtonGlyph(DC: HDC;
  const R: TRect; AState: TcxButtonState; AGlyph: TdxRibbonMinimizeButtonGlyph);
begin
end;

procedure TdxCustomRibbonSkin.DrawMenuScrollArea(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawProgressSolidBand(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, clHighlight);
end;

procedure TdxCustomRibbonSkin.DrawProgressSubstrate(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, clBtnFace);
end;

procedure TdxCustomRibbonSkin.DrawProgressDiscreteBand(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, clHighlight);
end;

procedure TdxCustomRibbonSkin.DrawRibbonBackground(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, GetPartColor(rspRibbonBackground));
end;

procedure TdxCustomRibbonSkin.DrawRibbonClientTopArea(DC: HDC; const R: TRect);
begin
end;

procedure TdxCustomRibbonSkin.DrawRibbonTopFrameArea(
  DC: HDC; const R: TRect; AUseAeroGlass: Boolean);
begin
end;

procedure TdxCustomRibbonSkin.DrawRibbonTopFrameAreaSeparator(DC: HDC; const R: TRect);
begin
end;

procedure TdxCustomRibbonSkin.DrawSeparatorBackground(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, GetPartColor(DXBAR_SEPARATOR_BACKGROUND));
end;

procedure TdxCustomRibbonSkin.DrawSeparatorLine(DC: HDC; const R: TRect);
begin
  DrawMenuSeparatorHorz(DC, R);
end;

procedure TdxCustomRibbonSkin.DrawSmallButton(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawSmallButtonGlyphBackground(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawSmallButtonDropButton(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawScrollArrow(DC: HDC; const R: TRect);
begin
  Parts[FScrollArrow].Draw(DC, R);
end;

procedure TdxCustomRibbonSkin.DrawScreenTip(DC: HDC; const R: TRect);
begin
  Parts[FScreenTip].Draw(DC, R);
end;

procedure TdxCustomRibbonSkin.DrawBackstageViewBackground(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, GetPartColor(rbvpBackstageView));
end;

procedure TdxCustomRibbonSkin.DrawBackstageViewMenuBackground(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, $FCFCFC);
  FillRectByColor(DC, cxRectSetRight(R, R.Right, 1), $F0F0F0);
end;

procedure TdxCustomRibbonSkin.DrawBackstageViewMenuButton(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawSmallButton(DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawBackstageViewTabButton(
  DC: HDC; const R: TRect; AState: Integer);
begin
  DrawSmallButton(DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawBackstageViewTopLine(DC: HDC; const R: TRect);
begin
  DrawBackstageViewBackground(DC, R);
end;

procedure TdxCustomRibbonSkin.DrawTab(DC: HDC; const R: TRect; AState: TdxRibbonTabState);
var
  R1: TRect;
begin
  R1 := R;
  Dec(R1.Bottom);
  case AState of
    rtsNormal:
      FillRectByColor(DC, R1, clBtnFace);
    rtsActive:
      DrawFrame(DC, R1, clHighlight, clWhite, [bLeft, bTop, bRight]);
    else
      DrawFrame(DC, R1, clHighlight, clBtnFace, [bTop]);
  end;
end;

procedure TdxCustomRibbonSkin.DrawTabAreaBackground(
  DC: HDC; const R: TRect; AActive, AUseAeroGlass: Boolean);
begin
  if not AUseAeroGlass then
    DrawRibbonBackground(DC, R);
end;

procedure TdxCustomRibbonSkin.DrawTabGroupBackground(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawFrame(DC, R, clBtnFace, clBtnShadow, [bTop, bLeft, bRight])
end;

procedure TdxCustomRibbonSkin.DrawTabGroupHeaderBackground(DC: HDC; const R: TRect; AState: Integer);
var
  R1: TRect;
begin
  R1 := cxRect(R.Left + 4, R.Top, R.Right - 4, R.Top + 1);
  FillRectByColor(DC, R1, clBtnShadow);
  ExcludeClipRect(DC, R1);
  DrawFrame(DC, R, clBtnFace, clBtnShadow, [bBottom, bLeft, bRight]);
end;

procedure TdxCustomRibbonSkin.DrawContextTabBackground(
  DC: HDC; const R: TRect; AState: TdxRibbonTabState; AColor: TColor);
begin
  FillRectByColor(DC, R, AColor);
  case AState of
    rtsNormal:
      FillRectByColor(DC, R, clBtnFace);
    rtsActive:
      DrawFrame(DC, R, clHighlight, clWhite, [bLeft, bTop, bRight]);
    else
      DrawFrame(DC, R, clHighlight, clBtnFace, [bTop]);
  end;
end;

procedure TdxCustomRibbonSkin.DrawContextTabSeparator(DC: HDC; const R: TRect; ABeginGroup: Boolean);
begin
end;

procedure TdxCustomRibbonSkin.DrawContextBackground(DC: HDC; const R: TRect; AColor: TColor);
var
  ASaveIndex: Integer;
  R1: TRect;
begin
  ASaveIndex := SaveDC(DC);
  try
    R1 := cxRectInflate(R, -2, -4, -2, -2);
    FillRectByColor(DC, R1, clHighlight);
    ExcludeClipRect(DC, R1);
    FillRectByColor(DC, R, AColor);
  finally
    RestoreDC(DC, ASaveIndex)
  end;
end;

procedure TdxCustomRibbonSkin.DrawContextBackgroundGlass(DC: HDC; const R: TRect; AColor: TColor);
begin
  FillRectByColor(DC, R, clBtnFace) //Is it possible?
end;

procedure TdxCustomRibbonSkin.DrawMarkArrow(DC: HDC; const R: TRect; AState: Integer);
var
  H: Integer;
begin
  H := (R.Bottom - R.Top) div 7;
  DrawPart(DC, cxRect(R.Left + 3, R.Top + H * 3, R.Right - 3, R.Bottom - H * 2), AState);
end;

procedure TdxCustomRibbonSkin.DrawMarkTruncated(DC: HDC; const R: TRect; AState: Integer);
var
  H: Integer;
begin
  H := (R.Bottom - R.Top) div 7;
  DrawPart(DC, cxRect(R.Left + H + 1, R.Top + H * 3, R.Right - H + 1, R.Bottom - H * 2), AState);
end;

procedure TdxCustomRibbonSkin.DrawTabGroupsArea(
  DC: HDC; const R: TRect; AIsQATAtBottom: Boolean);
begin
  DrawFrame(DC, R, clBtnFace, clBtnShadow)
end;

procedure TdxCustomRibbonSkin.DrawContextTabGroupsArea(
  DC: HDC; const R: TRect; AIsQATAtBottom: Boolean);
begin
  DrawFrame(DC, R, clBtnFace, clBtnShadow)
end;

procedure TdxCustomRibbonSkin.DrawTabScrollButton(
  DC: HDC; const R: TRect; ALeft: Boolean; AState: Integer);
begin
  DrawGroupScrollButton(DC, R, ALeft, AState);
end;

procedure TdxCustomRibbonSkin.DrawTabSeparator(DC: HDC; const R: TRect; Alpha: Byte);
begin
  Parts[FTabSeparator].Draw(DC, R, Alpha);
end;

procedure TdxCustomRibbonSkin.DrawQuickAccessToolbar(DC: HDC;
  const R: TRect; ABellow, ANonClientDraw, AHasApplicationButton, AIsActive, ADontUseAero: Boolean);
var
  W, ALeftPart, ARightPart: Integer;
  AInactive: Boolean;
  R1: TRect;
begin
  if not ABellow then
  begin
    AInactive := ANonClientDraw and not AIsActive;
    W := (R.Bottom - R.Top) div 2;
    if R.Right - W - R.Left < W then Exit;
    R1 := R;
    if AHasApplicationButton then
      R1.Right := R1.Left + 15
    else
      R1.Right := R1.Left + 7;
    if ANonClientDraw and IsCompositionEnabled and not ADontUseAero then
    begin
      ALeftPart := FQATGlassAtTopLeft[AHasApplicationButton];
      ARightPart := FQATGlassAtTopRight;
    end
    else
    begin
      ALeftPart := FQATAtTopLeft[AHasApplicationButton][AInactive];
      ARightPart := FQATAtTopRight[AInactive];
    end;
    AdjustQuickAccessToolbarVertical(R1, ANonClientDraw, ADontUseAero);
    Parts[ALeftPart].Draw(DC, R1);
    R1.Left := R1.Right;
    R1.Right := R.Right - W;
    Parts[ARightPart].Draw(DC, R1);
  end
  else
    Parts[FQATAtBottom].Draw(DC, R);
end;

procedure TdxCustomRibbonSkin.DrawQuickAccessToolbarDefaultGlyph(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, clBtnFace)
end;

procedure TdxCustomRibbonSkin.DrawQuickAccessToolbarGroupButton(DC: HDC;
  const R: TRect; ABellow, ANonClientDraw, AIsActive: Boolean; AState: Integer);
begin
  if ABellow or ANonClientDraw and not AIsActive then
    DrawPart(FQATGroupButtonInactive, DC, R, AState)
  else
    DrawPart(FQATGroupButtonActive, DC, R, AState);
end;

procedure TdxCustomRibbonSkin.DrawQuickAccessToolbarPopup(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, clBtnFace);
end;

procedure TdxCustomRibbonSkin.DrawStatusBar(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, clBtnFace)
end;

procedure TdxCustomRibbonSkin.DrawStatusBarGripBackground(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, clBtnFace)
end;

procedure TdxCustomRibbonSkin.DrawStatusBarPanel(
  DC: HDC; const Bounds, R: TRect; AIsLowered: Boolean);
begin
  FillRectByColor(DC, R, clBtnFace);
end;

procedure TdxCustomRibbonSkin.DrawStatusBarPanelSeparator(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, clBtnFace);
  FillRectByColor(DC, cxRect(R.Left, R.Top + 1, R.Left + 1, R.Bottom - 1), clBtnShadow);
end;

procedure TdxCustomRibbonSkin.DrawStatusBarSizeGrip(DC: HDC; const R: TRect);
begin
  Office11DrawSizeGrip(DC, R, GetPartColor(rspStatusBarSizeGripColor1),
    GetPartColor(rspStatusBarSizeGripColor2));
end;

procedure TdxCustomRibbonSkin.DrawStatusBarToolbarSeparator(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, clBtnFace);
  FillRectByColor(DC, cxRect(R.Left, R.Top, R.Left + 1, R.Bottom - 1), clBtnShadow);
end;

procedure TdxCustomRibbonSkin.AddTwoStateElement(
  ABitmap: GpBitmap; var AParts; const R, F: TRect; ID: Integer;
  AInterpolationMode: Integer = InterpolationModeNearestNeighbor);
begin
  LoadElementParts(ABitmap, AParts, R, ID, F, [0, 1], [0, 1]);
  Parts[TTwoStateArray(AParts)[False]].InterpolationMode := AInterpolationMode;
  Parts[TTwoStateArray(AParts)[True]].InterpolationMode := AInterpolationMode;
end;

procedure TdxCustomRibbonSkin.AdjustQuickAccessToolbarVertical(
  var ABounds: TRect; ANonClientDraw, ADontUseAero: Boolean);
begin
  if ANonClientDraw then
  begin
    if IsCompositionEnabled and not ADontUseAero then
    begin
      Inc(ABounds.Top, 3);
      Dec(ABounds.Bottom, 2);
    end
    else
    begin
      Inc(ABounds.Top, 4);
      Dec(ABounds.Bottom, 3);
    end;
  end
  else
  begin
    Inc(ABounds.Top, 3);
    Dec(ABounds.Bottom, 4);
  end;
end;

function TdxCustomRibbonSkin.GetApplicationMenuContentOffset(const ATabsBounds: TRect): TRect;
begin
  Result := GetPartContentOffsets(DXBAR_APPLICATIONMENUCONTENT);
end;

function TdxCustomRibbonSkin.GetApplicationMenuGlyphSize: TSize;
begin
  Result := cxSize(42, 42);
end;

function TdxCustomRibbonSkin.GetSkinName: string;
begin
  Result := '';
end;

function TdxCustomRibbonSkin.GetCaptionFontSize(ACurrentFontSize: Integer): Integer;
begin
  Result := ACurrentFontSize;
end;

function TdxCustomRibbonSkin.GetContextFontStyle(
  const ACurrentFontStyle: TFontStyles): TFontStyles;
begin
  Result := ACurrentFontStyle;
end;

function TdxCustomRibbonSkin.GetMenuSeparatorSize: Integer;
begin
  Result := 2;
end;

function TdxCustomRibbonSkin.GetPartColor(APart: Integer; AState: Integer = 0): TColor;
begin
  Result := clDefault;
  case APart of
    DXBAR_KEYTIP_TEXTCOLOR:
      Result := clBtnText;
    DXBAR_INRIBBONGALLERY_BACKGROUND:
      Result := clBtnFace;
    DXBAR_INRIBBONGALLERY_BORDER:
      Result := clBtnShadow;
    DXBAR_GALLERYFILTERBANDTEXT:
      Result := clBtnText;
    DXBAR_DROPDOWNGALLERY:
      Result := clBtnFace;
    DXBAR_SCREENTIP_FOOTERLINE:
      Result := $DDBB9E;
    DXBAR_DATENAVIGATOR_HEADER:
      Result := $DAD5D2;
    DXBAR_SEPARATOR_BACKGROUND:
      Result := $EFE7DE;
    rspRibbonBottomEdge:
      Result := $F3E2D5;
    DXBAR_EDIT_BACKGROUND:
      Result := clBtnFace;
    rspApplicationButtonNormal..rspApplicationButtonPressed:
      Result := clBtnText;
    rspFormCaptionText, rspDocumentNameText:
      if AState = DXBAR_NORMAL then
        Result := clCaptionText
      else
        Result := clInactiveCaptionText;
    rspTabHeaderText, rspContextTabHeaderText, rspContextText, rspContextTextOnGlass:
      if AState = DXBAR_NORMAL then
        Result := clWindowText
      else
        Result := clHighlightText;
    rspContextTextShadow:
      Result := clNone;
    rspTabGroupHeaderText:
      Result := clWindowText;
    DXBAR_MENUEXTRAPANE_BUTTON_TEXTCOLOR, DXBAR_MENUEXTRAPANE_HEADER_TEXTCOLOR:
      Result := GetPartColor(DXBAR_MENUITEMTEXT, AState);
    DXBAR_GALLERYGROUPITEM_OUTERBORDER, DXBAR_GALLERYGROUPITEM_INNERBORDER:
      Result := clHighlight;
    DXBAR_MINITOOLBAR_BACKGROUND:
      Result := $F5F5F5;
    rfspRibbonForm:
      Result := clBtnShadow;
    DXBAR_MENUEDITSEPARATOR:
      case AState of
        DXBAR_ACTIVE:  Result := $85B6CA;
        DXBAR_ACTIVEDISABLED:  Result := $CDCDCD;
      end;
    DXBAR_EDIT_BORDER, DXBAR_EDIT_BUTTON_BORDER:
      case AState of
        DXBAR_NORMAL, DXBAR_DISABLED:
          Result := clBtnShadow;
        else
          Result := clWhite;
      end;

    rbvpBackstageViewMenuItem, rbvpBackstageViewMenuTabButton:
      case AState of
        DXBAR_NORMAL:
          Result := clWindowText;
        DXBAR_DISABLED, DXBAR_ACTIVEDISABLED:
          Result := clGrayText;
        else
          Result := clHighlightText;
      end;

    DXBAR_ITEMTEXT, rspTabGroupText, rspStatusBarText:
      case AState of
        DXBAR_NORMAL:
          Result := clWindowText;
        DXBAR_DISABLED:
          Result := clGrayText;
        else
          Result := clHighlightText;
      end;

    DXBAR_MENUITEMTEXT, DXBAR_GALLERYGROUPHEADERTEXT:
      case AState of
        DXBAR_NORMAL:
          Result := clMenuText;
        DXBAR_DISABLED:
          Result := clGrayText;
        else
          Result := clHighlightText;
      end;
    else
      Result := clBtnFace;
  end;
  Result := ColorToRGB(Result);
end;

function TdxCustomRibbonSkin.GetPartContentOffsets(APart: Integer): TRect;
begin
  case APart of
    DXBAR_MENUEXTRAPANE_PINBUTTON:
      Result := Rect(7, 0, 8, 0);
    DXBAR_APPLICATIONMENUBUTTON:
      Result := Rect(0, 5, 2, 5);
    DXBAR_COLLAPSEDTOOLBAR:
      Result := Rect(2, 2, 2, 2);
    DXBAR_COLLAPSEDTOOLBARGLYPHBACKGROUND:
      Result := Rect(7, 4, 7, 11);
    DXBAR_QUICKACCESSGROUPBUTTON, DXBAR_SMALLBUTTON:
      Result := Rect(3, 3, 3, 3);
    DXBAR_APPLICATIONBUTTON:
      Result := cxRect(cxGetValueCurrentDPI(3), cxGetValueCurrentDPI(5), cxGetValueCurrentDPI(4), 0);
    DXBAR_APPLICATIONMENUCONTENT:
      Result := cxRect(4, 16, 4, 29);
    DXBAR_TOOLBAR:
      Result := cxRect(2, 2, 2, 1);
    DXBAR_RIBBONTABGROUP, DXBAR_RIBBONCONTEXTTABGROUP:
      Result := cxRect(3, 3, 3, 4);
    DXBAR_QUICKACCESSTOOLBAR:
      Result := cxRect(2, 2, 2, 2);
    DXBAR_APPLICATIONBUTTONICONOFFSET:
      Result := cxRect(8, 8, 10, 10);
    rbvpBackstageViewMenuItem:
      Result := cxRect(10, 0, 0, 0);
    rbvpBackstageViewMenuTabButton:
      Result := cxRect(21, 12, 11, 12);
    rbvpBackstageViewMenu:
      Result := cxRect(6, 5, 6, 6);
    else
      Result := cxNullRect;
  end;
end;

function TdxCustomRibbonSkin.GetPartOffset(APart: Integer): Integer;
begin
  case APart of
    DXBAR_SEPARATOR_LINE:
      Result := 1;
    rspContextTabSeparatorBegin, rspContextTabSeparatorEnd:
      Result := 1;
    rbvpBackstageViewMenuTabButtonHeight:
      Result := 40;
    rbvpBackstageViewMenuItemHeight:
      Result := 25;
    DXBAR_TOOLBAR, DXBAR_TABSGROUPSOVERLAPHEIGHT:
      Result := 1;
    DXBAR_BUTTONGROUP:
      Result := 3;
    DXBAR_MENUEXTRAPANE_PINBUTTON:
      Result := Parts[FPinButtonGlyphs[False]].MinSize.cx +
        cxMarginsWidth(GetPartContentOffsets(DXBAR_MENUEXTRAPANE_PINBUTTON));
    else
      Result := 0;
  end;
end;

function TdxCustomRibbonSkin.GetQuickAccessToolbarMarkButtonOffset(
  AHasApplicationButton: Boolean; ABelow: Boolean): Integer;
begin
  if ABelow then
    Result := 5
  else
    Result := 12;
end;

function TdxCustomRibbonSkin.GetQuickAccessToolbarOverrideWidth(
  AHasApplicationButton: Boolean; AUseAeroGlass: Boolean): Integer;
begin
  if AHasApplicationButton then
    Result := 14
  else
    Result := 0;
end;

function TdxCustomRibbonSkin.GetQuickAccessToolbarLeftIndent(
  AHasApplicationButton: Boolean; AUseAeroGlass: Boolean): Integer;
begin
  Result := 0;
end;

function TdxCustomRibbonSkin.GetQuickAccessToolbarRightIndent(
  AHasApplicationButton: Boolean): Integer;
begin
  Result := 0;
end;

function TdxCustomRibbonSkin.GetStatusBarSeparatorSize: Integer;
begin
  Result := 3;
end;

function TdxCustomRibbonSkin.GetWindowBordersWidth(AHasStatusBar: Boolean): TRect;
begin
  Result := cxRect(4, 0, 4, 4);
  if AHasStatusBar then
    Result.Bottom := 1;
end;

function TdxCustomRibbonSkin.ExtendCaptionAreaOnTabs: Boolean;
begin
  Result := Style = rs2010;
end;

function TdxCustomRibbonSkin.NeedDrawGroupScrollArrow: Boolean;
begin
  Result := True;
end;

procedure TdxCustomRibbonSkin.UpdateBitsPerPixel;
var
  DC: HDC;
begin
  DC := GetDC(0);
  FLowColors := GetDeviceCaps(DC, BITSPIXEL) <= 8;
  ReleaseDC(0, DC);
end;

procedure TdxCustomRibbonSkin.LoadCommonControlSkinFromBitmap(ABitmap: GpBitmap);

  procedure AddElement(var AParts; const R, AFixedRect: TRect; ID: Integer;
    AInterpolationMode: Integer = InterpolationModeNearestNeighbor);
  begin
    LoadElementParts(ABitmap, AParts, R, ID, AFixedRect, [0], [0]);
    Parts[Integer(AParts)].InterpolationMode := AInterpolationMode;
  end;

begin
  AddElement(FQATGlassAtTopLeft[True], cxRectBounds(0, 353, 16, 26), cxRect(0, 2, 2, 2),
    rspQATNonClientLeft1Vista, InterpolationModeHighQualityBicubic);
  AddElement(FQATGlassAtTopLeft[False], cxRectBounds(34, 353, 4, 26), cxRect(3, 2, 0, 1),
    rspQATNonClientLeft2Vista, InterpolationModeHighQualityBicubic);
  AddElement(FQATGlassAtTopRight, cxRectBounds(16, 353, 18, 26), cxRect(0, 7, 15, 7),
    rspQATNonClientRightVista, InterpolationModeHighQualityBicubic);
  FHelpButton := AddPart1x1(ABitmap, cxRectBounds(42, 353, 16, 16), rspHelpButton, '', 7);
  LoadElementParts(ABitmap, FPinButtonGlyphs, cxRectBounds(89, 378, 16, 16),
    rspPinButtonGlyph, cxRect(0, 0, 15, 13), [0, 1], [0, 1], False);
  LoadCommonMenuParts(ABitmap);
end;

procedure TdxCustomRibbonSkin.LoadCustomControlSkinFromBitmap(ABitmap: GpBitmap);
begin
  LoadTab(ABitmap);
  LoadCustomButtonParts(ABitmap);
  LoadCustomMenuParts(ABitmap);
  LoadCustomScrollArrow(ABitmap);
  LoadCustomScreenTip(ABitmap);
  LoadQAT(ABitmap);
  LoadGallery(ABitmap);
end;

procedure TdxCustomRibbonSkin.LoadFormSkinFromBitmap(ABitmap: GpBitmap);
begin
  AddTwoStateElement(ABitmap, FQATAtTopLeft[True],
    cxRectBounds(0, 113, 15, 26), cxRect(13, 5, 0, 5), rspQATNonClientLeft1Active);
  AddTwoStateElement(ABitmap, FQATAtTopLeft[False],
    cxRectBounds(32, 113, 7, 26), cxRect(2, 5, 0, 5), rspQATNonClientLeft2Active);
  AddTwoStateElement(ABitmap, FQATAtTopRight,
    cxRectBounds(13, 113, 18, 26), cxRect(0, 5, 13, 5), rspQATNonClientRightActive);
end;

procedure TdxCustomRibbonSkin.DrawBlackArrow(DC: HDC; const R: TRect; AArrowDirection: TcxArrowDirection);
var
  APoints: TcxArrowPoints;
  ARgn: HRGN;
begin
  TcxCustomLookAndFeelPainter.CalculateArrowPoints(R, APoints, AArrowDirection, False, 4);
  if AArrowDirection in [adUp] then
    Dec(APoints[1].Y);
  if AArrowDirection in [adUp, adDown] then
  begin
    Dec(APoints[0].X);
    Dec(APoints[1].X);
  end;
  ARgn := CreatePolygonRgn(APoints, 3, WINDING);
  FillRgn(DC, ARgn, GetStockObject(BLACK_BRUSH));
  DeleteObject(ARgn);
end;

procedure TdxCustomRibbonSkin.DrawDropDownGalleryVerticalSizeGrip(DC: HDC; const R: TRect);
var
  ARect: TRect;
begin
  ARect := Rect(0, R.Top, 0, R.Bottom);
  ARect.Right := DropDownGalleryVerticalSizeGripBitmapSize.cx *
    cxRectHeight(ARect) div DropDownGalleryVerticalSizeGripBitmapSize.cy;
  OffsetRect(ARect, (cxRectWidth(R) - cxRectWidth(ARect)) div 2, 0);
  Parts[FDropDownGalleryVerticalSizeGrip].Draw(DC, ARect);
end;

procedure TdxCustomRibbonSkin.DrawTabsAreaButton(DC: HDC; const R: TRect; AState: TcxButtonState);
var
  APart: Integer;
begin
  case AState of
    cxbsHot:
      APart := DXBAR_HOT;
    cxbsPressed:
      APart := DXBAR_PRESSED;
    else
      APart := DXBAR_NORMAL;
  end;
  if APart <> DXBAR_NORMAL then
    DrawSmallButton(DC, R, APart);
end;

procedure TdxCustomRibbonSkin.GetApplicationMenuContentColors(
  var AInnerBorderColor, AOuterBorderColor, ASideColor: TColor);
begin
  AInnerBorderColor := $CAAF9B;
  AOuterBorderColor := clWhite;
  ASideColor := $EDD3BE;
end;

function TdxCustomRibbonSkin.GetStyle: TdxRibbonStyle;
begin
  Result := rs2007;
end;

procedure TdxCustomRibbonSkin.LoadFormSkin;
var
  ABitmap: GpBitmap;
begin
  LoadFormSkinBitmap(ABitmap);
  LoadFormSkinFromBitmap(ABitmap);
  GdipDisposeImage(ABitmap);
end;

procedure TdxCustomRibbonSkin.LoadRibbonSkin;
var
  ABitmap: GpBitmap;
begin
  LoadCommonRibbonSkinBitmap(ABitmap);
  LoadCommonControlSkinFromBitmap(ABitmap);
  GdipDisposeImage(ABitmap);
  //custom skin
  LoadCustomRibbonSkinBitmap(ABitmap);
  LoadCustomControlSkinFromBitmap(ABitmap);
  GdipDisposeImage(ABitmap);
end;

procedure TdxCustomRibbonSkin.LoadCommonRibbonSkinBitmap(out ABitmap: GpBitmap);
begin
  LoadBitmapFromStream('RIBBONCOMMON', ABitmap);
end;

procedure TdxCustomRibbonSkin.LoadCustomButtonParts(ABitmap: GpBitmap);
const
  ApplicationMenuButtonHeight = 22;
  ApplicationMenuButtonWidth  = 6;
  ButtonGroupHeight = 22;
  ButtonGroupWidth = 3;
  EditButtonHeight = 20;
  EditButtonWidth  = 12;
  LaunchButtonGlyphSize = 12;
begin
  FApplicationMenuButton := AddPart3x3(ABitmap,
    cxRectBounds(0, 250, ApplicationMenuButtonWidth, ApplicationMenuButtonHeight),
    DefaultFixedSize, rspApplicationMenuButton);
  LoadElementParts(ABitmap, FEditButtons,
    cxRectBounds(0, 116, EditButtonWidth, EditButtonHeight),
    rspEditButtonNormal, DefaultFixedSize, [0, 1, 2, 3, 4, 5, 1],
    [DXBAR_NORMAL..DXBAR_DROPPEDDOWN, DXBAR_ACTIVEDISABLED]);
  LoadElementParts(ABitmap, FButtonGroup,
    cxRectBounds(73, 0, ButtonGroupWidth, ButtonGroupHeight),
    rspButtonGroupNormal, Rect(1, 2, 1, 2), [], []);
  LoadElementParts(ABitmap, FLaunchButtonDefaultGlyphs,
    cxRectBounds(34, 249, LaunchButtonGlyphSize, LaunchButtonGlyphSize),
    rspLaunchButtonDefaultGlyphNormal, cxNullRect, [0, 1, 0, 0, 0],
    [DXBAR_NORMAL, DXBAR_DISABLED, DXBAR_HOT, DXBAR_ACTIVE, DXBAR_PRESSED], True, 5);
end;

procedure TdxCustomRibbonSkin.LoadCustomMenuParts(ABitmap: GpBitmap);
begin
  FApplicationMenuBorder := AddPart3x3(ABitmap, cxRectBounds(48, 321, 8, 8), Rect(3, 3, 3, 3), rspApplicationMenuBorder);
  FApplicationMenuContentHeader := AddPart1x1(ABitmap, cxRectBounds(57, 325, 2, 14), rspApplicationMenuContentHeader);
  FApplicationMenuContentFooter := AddPart1x1(ABitmap, cxRectBounds(62, 323, 2, 25), rspApplicationMenuContentFooter);
  FMenuMark := AddPart1x1(ABitmap, cxRectBounds(48, 277, 17, 17), rspMenuMark);
end;

procedure TdxCustomRibbonSkin.LoadCustomScrollArrow(ABitmap: GpBitmap);
begin
  FScrollArrow := AddPart1x1(ABitmap, cxRectBounds(14, 245, 5, 3), rspScrollArrow);
end;

procedure TdxCustomRibbonSkin.LoadCustomScreenTip(ABitmap: GpBitmap);
begin
  FScreenTip := AddPart3x3(ABitmap, cxRectBounds(66, 0, 6, 165), DefaultFixedSize, rspScreenTip);
end;

procedure TdxCustomRibbonSkin.LoadGallery(ABitmap: GpBitmap);
begin
  FDropDownGalleryTopSizeGrip := AddPart3x3(ABitmap, cxRectBounds(54, 423, 7, 7),
    cxEmptyRect, rspDropDownGalleryTopSizeGrip, '', InterpolationModeNearestNeighbor);
  FDropDownGalleryBottomSizeGrip := AddPart3x3(ABitmap, cxRectBounds(46, 423, 7, 7),
    cxEmptyRect, rspDropDownGalleryBottomSizeGrip, '', InterpolationModeNearestNeighbor);
  FDropDownGalleryVerticalSizeGrip := AddPart3x3(ABitmap, cxRectBounds(46, 431,
    DropDownGalleryVerticalSizeGripBitmapSize.cx, DropDownGalleryVerticalSizeGripBitmapSize.cy),
    cxEmptyRect, rspDropDownGalleryVerticalSizeGrip);
end;

procedure TdxCustomRibbonSkin.LoadQAT(ABitmap: GpBitmap);

  procedure LoadGroupButton(R: TRect; AStartID: Integer; var AStates: TFourStateArray);
  var
    I: Integer;
  begin
    for I := 0 to 3 do
    begin
      AStates[I] := AddPart3x3(ABitmap, R, cxRect(2, 2, 2, 2), AStartID + I);
      OffsetRect(R, 0, cxRectHeight(R));
    end;
  end;

begin
  FQATAtBottom := AddPart3x3(ABitmap, cxRectBounds(13, 209, 10, 26), cxRect(3, 3, 3, 3), rspQATAtBottom);
  LoadElementParts(ABitmap, FQATGroupButtonActive, cxRectBounds(0, 350, 22, 22),
    rspQATGroupButtonActive, DefaultFixedSize, [0, 3, 1, 1, 2, 2, 1],
    [DXBAR_NORMAL, DXBAR_DISABLED, DXBAR_HOT, DXBAR_ACTIVE, DXBAR_PRESSED, DXBAR_DROPPEDDOWN, DXBAR_ACTIVEDISABLED]);
  LoadElementParts(ABitmap, FQATGroupButtonInactive, cxRectBounds(23, 350, 22, 22),
    rspQATGroupButtonInactive, DefaultFixedSize, [0, 3, 1, 1, 2, 2, 1],
    [DXBAR_NORMAL, DXBAR_DISABLED, DXBAR_HOT, DXBAR_ACTIVE, DXBAR_PRESSED, DXBAR_DROPPEDDOWN, DXBAR_ACTIVEDISABLED]);
end;

procedure TdxCustomRibbonSkin.LoadTab(ABitmap: GpBitmap);
begin
  FTabSeparator := AddPart1x1(ABitmap, cxRectBounds(42, 86, 1, 22), rspTabSeparator);
end;

procedure TdxCustomRibbonSkin.DrawPart(DC: HDC; const R: TRect; AState: Integer);
begin
  case AState of
    DXBAR_HOT, DXBAR_CHECKED, DXBAR_HOTCHECK:
      DrawFrame(DC, R, clHighlight, clWhite);
    DXBAR_PRESSED:
      DrawFrame(DC, R, clHighlight, clBtnShadow)
    else
      DrawFrame(DC, R, clBtnFace, clBtnShadow);
  end
end;

procedure TdxCustomRibbonSkin.DrawPart(
  const AParts: TStatesArray; DC: HDC; const R: TRect; AState: Integer);
begin
  if AParts[AState] <> 0 then
  begin
    if LowColors then
      DrawPart(DC, R, AState)
    else
      Parts[AParts[AState]].Draw(DC, R);
  end;
end;

procedure TdxCustomRibbonSkin.InternalDrawSeparator(
  DC: HDC; const R: TRect; AHorizontal: Boolean; AColor1, AColor2: TColor);
var
  R1: TRect;
begin
  if AHorizontal then
  begin
    R1 := cxRectCenter(R, cxRectWidth(R), 1);
    FillRectByColor(DC, R1, AColor2);
    FillRectByColor(DC, cxRectOffset(R1, 0, 1), AColor1);
  end
  else
  begin
    R1 := cxRectCenter(R, 1, cxRectHeight(R));
    FillRectByColor(DC, R1, AColor1);
    FillRectByColor(DC, cxRectOffset(R1, 1, 0), AColor2);
  end;
end;

procedure TdxCustomRibbonSkin.LoadThreeStateArray(ABitmap: GpBitmap; R: TRect;
  const Fixed: TRect; var AStateArray: TThreeStateArray; AStartID: Integer;
  AInterpolationMode: Integer = InterpolationModeDefault);
var
  I: Integer;
begin
  for I := 0 to 2 do
  begin
    AStateArray[I] := AddPart3x3(ABitmap, R, Fixed, AStartID, '', AInterpolationMode);
    OffsetRect(R, 0, R.Bottom - R.Top);
    Inc(AStartID);
  end;
end;

procedure TdxCustomRibbonSkin.LoadCommonMenuParts(ABitmap: GpBitmap);
begin
  FMenuGlyph := AddPart3x3(ABitmap, cxRectBounds(14, 331, 3, 4), Rect(1, 1, 0, 1), rspMenuGlyph);
  FMenuContent := AddPart3x3(ABitmap, cxRectBounds(18, 331, 3, 4), Rect(0, 1, 1, 1), rspMenuContent);
  FMenuSeparatorHorz := AddPart1x1(ABitmap, cxRectBounds(17, 337, 4, 2), rspMenuSeparatorHorz);
  FMenuSeparatorVert := AddPart1x1(ABitmap, cxRectBounds(14, 336, 2, 2), rspMenuSeparatorVert);
  FDropDownBorder := AddPart3x3(ABitmap, cxRectBounds(28, 331, 8, 8), Rect(3, 3, 3, 3), rspDropDownBorder);
end;

{ TdxBlueRibbonSkin }

procedure TdxBlueRibbonSkin.DrawRibbonTopFrameAreaSeparator(DC: HDC; const R: TRect);
var
  R1: TRect;
begin
  R1 := R;
  Dec(R1.Bottom);
  FillRectByColor(DC, R1, $EBC3A4);
  OffsetRect(R1, 0, 1);
  FillRectByColor(DC, R1, $F3E2D5);
end;

procedure TdxBlueRibbonSkin.GetApplicationMenuContentColors(
  var AInnerBorderColor, AOuterBorderColor, ASideColor: TColor);
begin
  if LowColors then
    inherited GetApplicationMenuContentColors(AInnerBorderColor, AOuterBorderColor, ASideColor)
  else
  begin
    AInnerBorderColor := $CAAF9B;
    AOuterBorderColor := clWhite;
    ASideColor := $EDD3BE;
  end;
end;

function TdxBlueRibbonSkin.GetPartColor(APart: Integer; AState: Integer = 0): TColor;
const
  RibbonEditHotBackgroundColor = clWhite;
  RibbonEditNormalBorderColor = $DEC1AB;
  RibbonEditHotBorderColor = $E1C7B3;
  RibbonEditDisabledBorderColor = $C6BBB1;
begin
  Result := inherited GetPartColor(APart, AState);
  if LowColors then Exit;
  case APart of
    DXBAR_MENUEDITSEPARATOR:
      case AState of
        DXBAR_ACTIVE:  Result := $85B6CA;
        DXBAR_ACTIVEDISABLED:  Result := $CDCDCD;
      end;
    DXBAR_MENUITEMTEXT:
      if not (AState in [DXBAR_DISABLED, DXBAR_ACTIVEDISABLED]) then
        Result := $6E1500;
    DXBAR_EDIT_BORDER:
      case AState of
        DXBAR_NORMAL: Result := RibbonEditNormalBorderColor;
        DXBAR_HOT, DXBAR_ACTIVE, DXBAR_ACTIVEDISABLED: Result := RibbonEditHotBorderColor;
        DXBAR_DISABLED: Result := RibbonEditDisabledBorderColor;
        DXBAR_FOCUSED, DXBAR_DROPPEDDOWN: Result := RibbonEditHotBorderColor;
      end;
    DXBAR_EDIT_BACKGROUND:
      case AState of
        DXBAR_NORMAL: Result := $FBF2EA;
        DXBAR_HOT, DXBAR_ACTIVE, DXBAR_ACTIVEDISABLED: Result := RibbonEditHotBackgroundColor;
        DXBAR_DISABLED: Result := $EFEFEF;
        DXBAR_FOCUSED, DXBAR_DROPPEDDOWN: Result := RibbonEditHotBackgroundColor;
      end;
    DXBAR_EDIT_BUTTON_BORDER:
      case AState of
        DXBAR_NORMAL: Result := RibbonEditNormalBorderColor;
        DXBAR_ACTIVE: Result := $DEC7AD;
        DXBAR_HOT: Result := $99CEDB;
        DXBAR_PRESSED: Result := $45667B;
        DXBAR_DISABLED, DXBAR_ACTIVEDISABLED: Result := RibbonEditDisabledBorderColor;
        DXBAR_DROPPEDDOWN: Result := $6B99A5;
      end;
    DXBAR_SCREENTIP_FOOTERLINE:
      Result := $DDBB9E;
    DXBAR_DATENAVIGATOR_HEADER:
      Result := $DAD5D2;
    DXBAR_SEPARATOR_BACKGROUND:
      Result := $EFE7DE;
    DXBAR_INRIBBONGALLERY_BACKGROUND:
      if AState in [DXBAR_ACTIVE, DXBAR_HOT] then
        Result := $FBF3EC
      else
        Result := $F8E6D4;
    DXBAR_INRIBBONGALLERY_BORDER:
      Result := $EDD0B9;
    DXBAR_GALLERYFILTERBANDTEXT:
      if AState = DXBAR_NORMAL then
        Result := $6E1500
      else if AState = DXBAR_HOT then
        Result := $FF6600
      else
        OutError;
    rspRibbonBackground:
      Result := $FFDBBF;
    rspRibbonBottomEdge:
      Result := $F3E2D5;
    rfspRibbonForm:
      Result := $EBC3A4;
    rspFormCaptionText:
      if AState = DXBAR_NORMAL then
        Result := $AA6A3E
      else
        Result := $A0A0A0;
    rspDocumentNameText:
      if AState = DXBAR_NORMAL then
        Result := $797069
      else
        Result := $A0A0A0;
    rspTabHeaderText, rspTabGroupText:
      Result := $8B4215;
    rspTabGroupHeaderText:
      Result := $AA6A3E;
    rspStatusBarText:
      if AState in [DXBAR_NORMAL, DXBAR_HOT] then
        Result := $8B4215
      else
        Result := $8D8D8D;
    rspStatusBarSizeGripColor1:
      Result := $805D45;
    rspStatusBarSizeGripColor2:
      Result := $E8C9B1;
  end;
end;

function TdxBlueRibbonSkin.GetDisplayName: string;
begin
  Result := 'Blue';
end;

procedure TdxBlueRibbonSkin.LoadCustomRibbonSkinBitmap(out ABitmap: GpBitmap);
begin
  LoadBitmapFromStream('RIBBONBLUE', ABitmap);
end;

procedure TdxBlueRibbonSkin.LoadFormSkinBitmap(out ABitmap: GpBitmap);
begin
  LoadBitmapFromStream('FORMBLUE', ABitmap);
end;

{ TdxBlackRibbonSkin }

procedure TdxBlackRibbonSkin.DrawRibbonTopFrameAreaSeparator(DC: HDC; const R: TRect);
var
  R1: TRect;
begin
  R1 := R;
  Dec(R1.Bottom);
  FillRectByColor(DC, R1, $4F4F4F);
  OffsetRect(R1, 0, 1);
  FillRectByColor(DC, R1, $626262);
end;

procedure TdxBlackRibbonSkin.GetApplicationMenuContentColors(
  var AInnerBorderColor, AOuterBorderColor, ASideColor: TColor);
begin
  if LowColors then
    inherited GetApplicationMenuContentColors(AInnerBorderColor, AOuterBorderColor, ASideColor)
  else
  begin
    AInnerBorderColor := $414243;
    AOuterBorderColor := $716C6B;
    ASideColor := $504F4F;
  end;
end;

function TdxBlackRibbonSkin.GetPartColor(APart: Integer; AState: Integer = 0): TColor;
const
  RibbonEditHotBackgroundColor = clWhite;
  RibbonEditNormalBorderColor = $898989;
  RibbonEditHotBorderColor = $898989;
  RibbonEditDisabledBorderColor = $CCCCCC;
  RibbonItemText = $464646;
begin
  Result := inherited GetPartColor(APart, AState);
  if LowColors then Exit;
  case APart of
    DXBAR_MENUEDITSEPARATOR:
      case AState of
        DXBAR_ACTIVE:  Result := $85B6CA;
        DXBAR_ACTIVEDISABLED:  Result := $CDCDCD;
      end;
    DXBAR_MENUITEMTEXT:
      if not (AState in [DXBAR_DISABLED, DXBAR_ACTIVEDISABLED]) then
        Result := RibbonItemText;
    DXBAR_EDIT_BORDER:
      case AState of
        DXBAR_NORMAL: Result := RibbonEditNormalBorderColor;
        DXBAR_HOT, DXBAR_ACTIVE, DXBAR_ACTIVEDISABLED: Result := RibbonEditHotBorderColor;
        DXBAR_DISABLED: Result := RibbonEditDisabledBorderColor;
        DXBAR_FOCUSED, DXBAR_DROPPEDDOWN: Result := RibbonEditHotBorderColor;
      end;
    DXBAR_EDIT_BACKGROUND:
      case AState of
        DXBAR_NORMAL: Result := $E8E8E8;
        DXBAR_HOT, DXBAR_ACTIVE, DXBAR_ACTIVEDISABLED: Result := RibbonEditHotBackgroundColor;
        DXBAR_DISABLED: Result := $EFEFEF;
        DXBAR_FOCUSED, DXBAR_DROPPEDDOWN: Result := RibbonEditHotBackgroundColor;
      end;
    DXBAR_EDIT_BUTTON_BORDER:
      case AState of
        DXBAR_NORMAL: Result := RibbonEditNormalBorderColor;
        DXBAR_ACTIVE: Result := $B7B7B7;
        DXBAR_HOT: Result := $99CEDB;
        DXBAR_PRESSED: Result := $45667B;
        DXBAR_DISABLED, DXBAR_ACTIVEDISABLED: Result := RibbonEditDisabledBorderColor;
        DXBAR_DROPPEDDOWN: Result := $6B99A5;
      end;
    DXBAR_DATENAVIGATOR_HEADER:
      Result := $DAD5D2;
    DXBAR_SEPARATOR_BACKGROUND:
      Result := $EFEBEF;
    DXBAR_SCREENTIP_FOOTERLINE:
      Result := $A49991;
    DXBAR_INRIBBONGALLERY_BACKGROUND:
      if AState in [DXBAR_ACTIVE, DXBAR_HOT] then
        Result := $F7F7F7
      else
        Result := $E2E2DA;
    DXBAR_INRIBBONGALLERY_BORDER:
      Result := $ACACAC;
    DXBAR_GALLERYFILTERBANDTEXT:
      if AState = DXBAR_NORMAL then
        Result := $FFFFFF
      else if AState = DXBAR_HOT then
        Result := $32D2FF
      else
        OutError;
    rspRibbonBackground:
      Result := $535353;
    rspRibbonBottomEdge:
      Result := $626262;
    rfspRibbonForm:
      Result := $696969;
    rspFormCaptionText:
      if AState = DXBAR_NORMAL then
        Result := $FFD1AE
      else
        Result := $E1E1E1;
    rspDocumentNameText:
      if AState = DXBAR_NORMAL then
        Result := $FFFFFF
      else
        Result := $E1E1E1;
    rspTabHeaderText:
      if AState = DXBAR_ACTIVE then
        Result := clBlack
      else
        Result := $FFFFFF;
    rspTabGroupText:
      Result := RibbonItemText;
    rspTabGroupHeaderText:
      Result := $FFFFFF;
    rspStatusBarText:
      case AState of
        DXBAR_NORMAL:
          Result := $FFFFFF;
        DXBAR_HOT:
          Result := clBlack;
        else
          Result := $C2C2C2;
      end;
    rspStatusBarSizeGripColor1:
      Result := $252525;
    rspStatusBarSizeGripColor2:
      Result := $CCCCCC;
  end;
end;

function TdxBlackRibbonSkin.GetDisplayName: string;
begin
  Result := 'Black';
end;

procedure TdxBlackRibbonSkin.LoadCustomRibbonSkinBitmap(out ABitmap: GpBitmap);
begin
  LoadBitmapFromStream('RIBBONBLACK', ABitmap);
end;

procedure TdxBlackRibbonSkin.LoadFormSkinBitmap(out ABitmap: GpBitmap);
begin
  LoadBitmapFromStream('FORMBLACK', ABitmap);
end;

{ TdxSilverRibbonSkin }

procedure TdxSilverRibbonSkin.DrawRibbonTopFrameAreaSeparator(DC: HDC; const R: TRect);
var
  R1: TRect;
begin
  R1 := R;
  Dec(R1.Bottom);
  FillRectByColor(DC, R1, $808080);
  OffsetRect(R1, 0, 1);
  FillRectByColor(DC, R1, $DCE1EB);
end;

function TdxSilverRibbonSkin.GetDisplayName: string;
begin
  Result := 'Silver';
end;

procedure TdxSilverRibbonSkin.GetApplicationMenuContentColors(
  var AInnerBorderColor, AOuterBorderColor, ASideColor: TColor);
begin
  if LowColors then
    inherited GetApplicationMenuContentColors(AInnerBorderColor, AOuterBorderColor, ASideColor)
  else
  begin
    AInnerBorderColor := $B4AEA9;
    AOuterBorderColor := $FAFAFA;
    ASideColor := $D8D2CD;
  end;
end;

function TdxSilverRibbonSkin.GetPartColor(APart, AState: Integer): TColor;
const
  RibbonItemText = $5C534C;
begin
  Result := inherited GetPartColor(APart, AState);
  if LowColors then Exit;
  case APart of
    DXBAR_MENUITEMTEXT:
      if not (AState in [DXBAR_DISABLED, DXBAR_ACTIVEDISABLED]) then
        Result := RibbonItemText;
    DXBAR_INRIBBONGALLERY_BACKGROUND:
      if AState in [DXBAR_ACTIVE, DXBAR_HOT] then
        Result := $F2F1F0
      else
        Result := $ECEAE8;
    DXBAR_INRIBBONGALLERY_BORDER:
      if AState in [DXBAR_ACTIVE, DXBAR_HOT] then
        Result := $A4A4A4
      else
        Result := $B8B1A9;
    DXBAR_GALLERYFILTERBANDTEXT:
      if AState = DXBAR_NORMAL then
        Result := $FFFFFF
      else if AState = DXBAR_HOT then
        Result := $32D2FF
      else
        OutError;
    rspRibbonBackground:
      Result := $DDD4D0;
    rspRibbonBottomEdge:
      Result := $808080;
    rfspRibbonForm:
      Result := $B5AEAA;
    rspFormCaptionText:
      if AState = DXBAR_NORMAL then
        Result := $AA6E35
      else
        Result := $8A8A8A;
    rspDocumentNameText:
      if AState = DXBAR_NORMAL then
        Result := $6A625C
      else
        Result := $8A8A8A;
    rspTabHeaderText:
      Result := $595453;
    rspTabGroupText, rspTabGroupHeaderText:
      Result := RibbonItemText;
    rspStatusBarText:
      if AState in [DXBAR_NORMAL, DXBAR_HOT] then
        Result := $595453
      else
        Result := $8D8D8D;
    rspStatusBarSizeGripColor1:
      Result := $7E77670;
    rspStatusBarSizeGripColor2:
      Result := $D9D0CD;
  end;
end;

procedure TdxSilverRibbonSkin.LoadCustomRibbonSkinBitmap(out ABitmap: GpBitmap);
begin
  LoadBitmapFromStream('RIBBONSILVER', ABitmap);
end;

procedure TdxSilverRibbonSkin.LoadFormSkinBitmap(out ABitmap: GpBitmap);
begin
  LoadBitmapFromStream('FORMSILVER', ABitmap);
end;

{ TdxCustomRibbonTexturedSkin }

procedure TdxCustomRibbonTexturedSkin.DrawApplicationButton(
  DC: HDC; const R: TRect; AState: TdxApplicationButtonState);
begin
  if LowColors then
    inherited DrawApplicationButton(DC, R, AState)
  else
    Parts[FApplicationButton[Ord(AState)]].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawArrowDown(DC: HDC; const R: TRect; AState: Integer);
begin
  if LowColors then
    inherited DrawArrowDown(DC, R, AState)
  else
    DrawPart(FArrowsDown, DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawButtonGroupBorderLeft(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawButtonGroupBorderLeft(DC, R)
  else
    Parts[FButtonGroupBorderLeft].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawButtonGroupBorderMiddle(DC: HDC; const R: TRect; AState: Integer);
begin
  if LowColors then
    inherited DrawButtonGroupBorderMiddle(DC, R, AState)
  else
    DrawPart(FButtonGroupBorderMiddle, DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawButtonGroupBorderRight(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawButtonGroupBorderRight(DC, R)
  else
    Parts[FButtonGroupBorderRight].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawButtonGroupSplitButtonSeparator(
  DC: HDC; const R: TRect; AState: Integer);
begin
  if LowColors then
    inherited DrawButtonGroupSplitButtonSeparator(DC, R, AState)
  else
    DrawPart(FButtonGroupSplitButtonSeparator, DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawCollapsedToolbarBackground(
  DC: HDC; const R: TRect; AState: Integer);
begin
  if LowColors then
    inherited DrawCollapsedToolbarBackground(DC, R, AState)
  else
    case AState of
      0, 2, 3, 4:
        Parts[FCollapsedToolbars[AState]].Draw(DC, R);
      else
        Parts[FCollapsedToolbars[0]].Draw(DC, R);
    end;
end;

procedure TdxCustomRibbonTexturedSkin.DrawCollapsedToolbarGlyphBackground(
  DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(FCollapsedToolbarGlyphBackgrounds, DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawContextBackground(
  DC: HDC; const R: TRect; AColor: TColor);
begin
  if LowColors then
    inherited DrawContextBackground(DC, R, AColor)
  else
  begin
    FillRectByColor(DC, R, AColor);
    Parts[FContextBackground].Draw(DC, R);
  end;
end;

procedure TdxCustomRibbonTexturedSkin.DrawContextBackgroundGlass(
  DC: HDC; const R: TRect; AColor: TColor);
begin
  if LowColors then
    inherited DrawContextBackgroundGlass(DC, R, AColor)
  else
  begin
    dxGpFillRectByGradient(DC, R, 0, AColor, LinearGradientModeVertical, 0, 220);
    Parts[FContextBackgroundGlass].Draw(DC, R);
  end;
end;

procedure TdxCustomRibbonTexturedSkin.DrawContextTabBackground(
  DC: HDC; const R: TRect; AState: TdxRibbonTabState; AColor: TColor);
begin
  if LowColors then
    inherited DrawContextTabBackground(DC, R, AState, AColor)
  else
  begin
    dxGpFillRect(DC, R, AColor);
    Parts[FContextTabIndex[AState]].Draw(DC, R);
  end;
end;

procedure TdxCustomRibbonTexturedSkin.DrawContextTabGroupsArea(
  DC: HDC; const R: TRect; AIsQATAtBottom: Boolean);
begin
  if LowColors then
    inherited DrawContextTabGroupsArea(DC, R, AIsQATAtBottom)
  else
    Parts[FContextTabGroupsArea[AIsQATAtBottom]].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawContextTabSeparator(
  DC: HDC; const R: TRect; ABeginGroup: Boolean);
begin
  if LowColors then
    inherited DrawContextTabSeparator(DC, R, ABeginGroup)
  else
    Parts[FContextTabSeparator[ABeginGroup]].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawDropDownGalleryBottomSizingBand(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawDropDownGalleryBottomSizingBand(DC, R)
  else
    Parts[FDropDownGalleryBottomSizingBand].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawDropDownGalleryTopSizingBand(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawDropDownGalleryTopSizingBand(DC, R)
  else
    Parts[FDropDownGalleryTopSizingBand].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawFormBorders(
  DC: HDC; const ABordersWidth: TRect; ACaptionHeight: Integer;
  const AData: TdxRibbonFormData);
var
  ARectangularBottom: Boolean;
  R: TRect;
begin
  if LowColors then
    inherited DrawFormBorders(DC, ABordersWidth, ACaptionHeight, AData)
  else
  begin
    //catpion borders
    if ACaptionHeight > 0 then
    begin
      R := AData.Bounds;
      R.Bottom := ACaptionHeight;
      R.Right := R.Left + ABordersWidth.Left;
      Parts[FCaptionLeftBorder[not AData.Active]].Draw(DC, R);
      R.Right := AData.Bounds.Right;
      R.Left := R.Right - ABordersWidth.Right;
      Parts[FCaptionRightBorder[not AData.Active]].Draw(DC, R)
    end;
    ARectangularBottom := IsRectangularFormBottom(AData);
    if ABordersWidth.Bottom > 1 then
    begin
      R := AData.Bounds;
      R.Top := R.Bottom - ABordersWidth.Bottom;
      Parts[FBottomBorderThick[ARectangularBottom][not AData.Active]].Draw(DC, R);
      ExcludeClipRect(DC, R);
    end
    else
    begin
      R := AData.Bounds;
      R.Top := R.Bottom - ABordersWidth.Bottom;
      Inc(R.Left, ABordersWidth.Left);
      Dec(R.Right, ABordersWidth.Right);
      Parts[FBottomBorderThin[not AData.Active]].Draw(DC, R);
    end;
    R := AData.Bounds;
    if not ARectangularBottom then
      Dec(R.Bottom);
    R.Top := ACaptionHeight + ABordersWidth.Top;
    R.Right := R.Left + ABordersWidth.Left;
    Parts[FLeftBorder[not AData.Active]].Draw(DC, R);
    R.Right := AData.Bounds.Right;
    R.Left := R.Right - ABordersWidth.Right;
    Parts[FRightBorder[not AData.Active]].Draw(DC, R);
  end;
end;

procedure TdxCustomRibbonTexturedSkin.DrawFormBorderIcon(
  DC: HDC; const R: TRect; AIcon: TdxBorderDrawIcon; AState: TdxBorderIconState);
var
  APart: Integer;
begin
  if LowColors then
    inherited DrawFormBorderIcon(DC, R, AIcon, AState)
  else
  begin
    case AState of
      bisHot: APart := 0;
      bisPressed: APart := 1;
      bisHotInactive: APart := 2;
    else
      APart := -1;
    end;
    if APart >= 0 then
      Parts[FBorderIcons[APart]].Draw(DC, R);
    InternalDrawFormBorderIconGlyph(DC, R, AIcon, AState);
  end;
end;

procedure TdxCustomRibbonTexturedSkin.DrawFormCaption(DC: HDC;
  const R: TRect; const AData: TdxRibbonFormData; ATabHeadersAreaVisible: Boolean);
var
  ARect: TRect;
begin
  if LowColors then
    inherited DrawFormCaption(DC, R, AData, ATabHeadersAreaVisible)
  else
    if AData.State = wsMaximized then
      Parts[FCaptionZoomed[not AData.Active]].Draw(DC, R)
    else
      if AData.State = wsMinimized then
      begin
        ARect := R;
        Dec(ARect.Bottom, 1);
        Parts[FCaption[not AData.Active]].Draw(DC, ARect);
        ARect := R;
        ARect.Top := ARect.Bottom - 1;
        Parts[FBottomBorderThin[not AData.Active]].Draw(DC, ARect);
      end
      else
        Parts[FCaption[not AData.Active]].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawFormStatusBarPart(
  DC: HDC; const R: TRect; AIsLeft, AIsActive, AIsRaised, AIsRectangular: Boolean);
var
  APart: Integer;
begin
  if LowColors then
    inherited DrawFormStatusBarPart(DC, R, AIsLeft, AIsActive, AIsRaised, AIsRectangular)
  else
  begin
    APart := 0;
    Inc(APart, Ord(AIsRaised));
    Inc(APart, Ord(not AIsActive) * 2);
    if AIsLeft then
      Parts[FFormStatusBarLeftParts[AIsRectangular][APart]].Draw(DC, R)
    else
      Parts[FFormStatusBarRightParts[AIsRectangular][APart]].Draw(DC, R);
  end;
end;

procedure TdxCustomRibbonTexturedSkin.DrawGalleryFilterBandBackground(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawGalleryFilterBandBackground(DC, R)
  else
    Parts[FGalleryFilterBand].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawGalleryGroupHeaderBackground(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawGalleryGroupHeaderBackground(DC, R)
  else
    Parts[FGalleryGroupHeader].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawGroupScrollButton(
  DC: HDC; const R: TRect; ALeft: Boolean; AState: Integer);
var
  APartIndex: Integer;
begin
  if LowColors then
    inherited DrawGroupScrollButton(DC, R, ALeft, AState)
  else
  begin
    case AState of
      DXBAR_HOT: APartIndex := 1;
      DXBAR_PRESSED: APartIndex := 2;
      else
        APartIndex := 0;
    end;
    Parts[FGroupScrollButtons[ALeft][APartIndex]].Draw(DC, R);
  end;
end;

procedure TdxCustomRibbonTexturedSkin.DrawInRibbonGalleryScrollBarButton(
  DC: HDC; const R: TRect; AButtonKind: TdxInRibbonGalleryScrollBarButtonKind;
  AState: Integer);
begin
  if LowColors then
    inherited DrawInRibbonGalleryScrollBarButton(DC, R, AButtonKind, AState)
  else
    case AButtonKind of
      gsbkLineUp:
        DrawPart(FInRibbonGalleryScrollBarLineUpButton, DC, R, AState);
      gsbkLineDown:
        DrawPart(FInRibbonGalleryScrollBarLineDownButton, DC, R, AState);
      gsbkDropDown:
        DrawPart(FInRibbonGalleryScrollBarDropDownButton, DC, R, AState);
    end;
end;

procedure TdxCustomRibbonTexturedSkin.DrawLargeButton(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(FLargeButtons, DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawLargeButtonGlyphBackground(
  DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(FLargeButtonGlyphBackgrounds, DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawLargeButtonDropButton(
  DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(FLargeButtonDropButtons, DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawLaunchButtonBackground(
  DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(FLaunchButtonBackgrounds, DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawLaunchButtonDefaultGlyph(
  DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(FLaunchButtonDefaultGlyphs, DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawMarkArrow(DC: HDC; const R: TRect; AState: Integer);
var
  APart: TdxSkinnedRect;
begin
  if LowColors then
    inherited DrawMarkArrow(DC, R, AState)
  else
  begin
    APart := Parts[FMarkArrow[AState]];
    APart.Draw(DC, cxRectOffset(cxRectCenter(R, APart.Size), 0, 1));
  end;
end;

procedure TdxCustomRibbonTexturedSkin.DrawMarkTruncated(DC: HDC; const R: TRect; AState: Integer);
var
  APart: TdxSkinnedRect;
begin
  if LowColors then
    inherited DrawMarkTruncated(DC, R, AState)
  else
  begin
    APart := Parts[FMarkTruncated[AState]];
    APart.Draw(DC, cxRectCenter(R, APart.Size));
  end;
end;

procedure TdxCustomRibbonTexturedSkin.DrawMDIButton(
  DC: HDC; const R: TRect; AButton: TdxBarMDIButton; AState: TcxButtonState);
begin
  DrawTabsAreaButton(DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawMDIButtonGlyph(
  DC: HDC; const R: TRect; AButton: TdxBarMDIButton; AState: TcxButtonState);
const
  PartMap: array[TcxButtonState] of Integer = (0, 0, 1, 2, 3);
var
  AIcon: TdxBorderDrawIcon;
  GR: TRect;
begin
  if LowColors then
    inherited DrawMDIButtonGlyph(DC, R, AButton, AState)
  else
  begin
    GR := cxRectBounds(R.Left, R.Top, 9, 9);
    OffsetRect(GR, (R.Right - R.Left - 9) div 2, (R.Bottom - R.Top - 9) div 2 + 1);
    case AButton of
      mdibMinimize:
        AIcon := bdiMinimize;
      mdibRestore:
        AIcon := bdiRestore;
      else
        AIcon := bdiClose;
    end;
    Parts[FBorderIconGlyph[AIcon][PartMap[AState]]].Draw(DC, GR);
  end;
end;

procedure TdxCustomRibbonTexturedSkin.DrawMenuArrowDown(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawMenuArrowDown(DC, R)
  else
    Parts[FMenuArrowDown].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawMenuArrowRight(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawMenuArrowRight(DC, R)
  else
    Parts[FMenuArrowRight].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawMenuCheck(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(FMenuCheck, DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawMenuCheckMark(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(FMenuCheckMark, DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawMenuDetachCaption(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(FMenuDetachCaption, DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawMenuScrollArea(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(FMenuScrollArea, DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawProgressSolidBand(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawProgressSolidBand(DC, R)
  else
    Parts[FProgressSolidBand].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawProgressSubstrate(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawProgressSubstrate(DC, R)
  else
    Parts[FProgressSubstrate].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawProgressDiscreteBand(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawProgressDiscreteBand(DC, R)
  else
    Parts[FProgressDiscreteBand].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawQuickAccessToolbarDefaultGlyph(DC: HDC; const R: TRect);
begin
  if FLowColors then
    inherited DrawQuickAccessToolbarDefaultGlyph(DC, R)
  else
    Parts[FQATDefaultGlyph].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawQuickAccessToolbarPopup(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawQuickAccessToolbarPopup(DC, R)
  else
    Parts[FQATPopup].Draw(DC, R)
end;

procedure TdxCustomRibbonTexturedSkin.DrawRibbonClientTopArea(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawRibbonClientTopArea(DC, R)
  else
    Parts[FRibbonTopArea].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawSmallButton(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(FSmallButtons, DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawSmallButtonGlyphBackground(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(FSmallButtonGlyphBackgrounds, DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawSmallButtonDropButton(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawPart(FSmallButtonDropButtons, DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawStatusBar(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawStatusBar(DC, R)
  else
    Parts[FStatusBar].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawStatusBarGripBackground(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawStatusBarGripBackground(DC, R)
  else
    Parts[FStatusBarGripBackground].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawStatusBarPanel(
  DC: HDC; const Bounds, R: TRect; AIsLowered: Boolean);
begin
  if FLowColors then
    inherited DrawStatusBarPanel(DC, Bounds, R, AIsLowered)
  else
    if AIsLowered then
      Parts[FStatusBarPanelLowered].Draw(DC, R)
    else
      Parts[FStatusBarPanelRaised].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawStatusBarPanelSeparator(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawStatusBarPanelSeparator(DC, R)
  else
    Parts[FStatusBarPanelSeparator].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawStatusBarToolbarSeparator(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawStatusBarToolbarSeparator(DC, R)
  else
    Parts[FStatusBarToolbarSeparator].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawTab(DC: HDC; const R: TRect; AState: TdxRibbonTabState);
begin
  if LowColors then
    inherited DrawTab(DC, R, AState)
  else
    Parts[FTabIndex[AState]].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawTabGroupBackground(
  DC: HDC; const R: TRect; AState: Integer);
begin
  if LowColors then
    inherited DrawTabGroupBackground(DC, R, AState)
  else
    DrawPart(FToolbar, DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawTabGroupHeaderBackground(
  DC: HDC; const R: TRect; AState: Integer);
begin
  if LowColors then
    inherited DrawTabGroupHeaderBackground(DC, R, AState)
  else
    DrawPart(FToolbarHeader, DC, R, AState);
end;

procedure TdxCustomRibbonTexturedSkin.DrawTabGroupsArea(
  DC: HDC; const R: TRect; AIsQATAtBottom: Boolean);
begin
  if LowColors then
    inherited DrawTabGroupsArea(DC, R, AIsQATAtBottom)
  else
    Parts[FTabGroupsArea[AIsQATAtBottom]].Draw(DC, R);
end;

procedure TdxCustomRibbonTexturedSkin.DrawTabScrollButton(
  DC: HDC; const R: TRect; ALeft: Boolean; AState: Integer);
var
  APartIndex: Integer;
begin
  if LowColors then
    inherited DrawTabScrollButton(DC, R, ALeft, AState)
  else
  begin
    case AState of
      DXBAR_HOT:
        APartIndex := 1;
      DXBAR_PRESSED:
        APartIndex := 2;
      else
        APartIndex := 0;
    end;
    Parts[FTabScrollButtons[ALeft][APartIndex]].Draw(DC, R);
  end;
end;

function TdxCustomRibbonTexturedSkin.GetPartColor(APart: Integer; AState: Integer = 0): TColor;
begin
  Result := clDefault;
  if LowColors then
    Result := inherited GetPartColor(APart, AState)
  else
    case APart of
      rbvpBackstageView:
        Result := clWhite;
      DXBAR_KEYTIP_TEXTCOLOR:
        Result := dxBarScreenTipFontColor;
      DXBAR_GALLERYGROUPHEADERTEXT:
        Result := GetPartColor(DXBAR_MENUITEMTEXT);
      DXBAR_MENUEXTRAPANE:
        Result := $EEEAE9;
      DXBAR_MENUARROWSEPARATOR:
        Result := $BDB6A5;
      DXBAR_MENUDETACHCAPTIONAREA:
        Result := $F7F7F7;
      DXBAR_MENUEXTRAPANE_BUTTON_TEXTCOLOR, DXBAR_MENUEXTRAPANE_HEADER_TEXTCOLOR:
        Result := GetPartColor(DXBAR_MENUITEMTEXT, AState);
      DXBAR_MENUITEMTEXT, rbvpBackstageViewMenuTabButton, rbvpBackstageViewMenuItem:
        if AState in [DXBAR_DISABLED, DXBAR_ACTIVEDISABLED] then
          Result := $A7A7A7;
      DXBAR_ITEMTEXT:
        case AState of
          DXBAR_DISABLED, DXBAR_ACTIVEDISABLED:
            Result := $8D8D8D;
          else
            Result := GetPartColor(rspTabGroupText);
        end;
      DXBAR_DROPDOWNGALLERY: Result := $FAFAFA;
      DXBAR_DROPDOWNBORDER_INNERLINE: Result := $F5F5F5;
      DXBAR_GALLERYGROUPITEM_OUTERBORDER:
        case AState of
          DXBAR_HOT: Result := $3694F2;
          DXBAR_CHECKED: Result := $1048EF;
          DXBAR_HOTCHECK: Result := $3695F2;
        end;
      DXBAR_GALLERYGROUPITEM_INNERBORDER:
        case AState of
          DXBAR_HOT: Result := $94E2FF;
          DXBAR_CHECKED: Result := $94E2FF;
          DXBAR_HOTCHECK: Result := $95E3FF;
        end;
      DXBAR_MINITOOLBAR_BACKGROUND:
        Result := $F5F5F5;
      rspContextTabHeaderText:
        Result := GetPartColor(rspTabHeaderText, AState);
      rspContextTextOnGlass:
        Result := clBlack;
      rspContextText:
        Result := GetPartColor(rspTabHeaderText);
      rspContextTextShadow:
        Result := clNone;
      DXBAR_EDIT_TEXTCOLOR:
        if AState = DXBAR_DISABLED then
          Result := clGrayText
        else
          Result := clWindowText;
    end;
end;

procedure TdxCustomRibbonTexturedSkin.InternalDrawFormBorderIconGlyph(
  DC: HDC; const R: TRect; AIcon: TdxBorderDrawIcon; AState: TdxBorderIconState);
var
  AGlyph: TdxSkinnedRect;
  APart: Integer;
begin
  case AState of
    bisHot: APart := 1;
    bisPressed: APart := 2;
    bisInactive: APart := 3;
    bisHotInactive: APart := 3;
  else
    APart := 0;
  end;
  AGlyph := Parts[FBorderIconGlyph[AIcon][APart]];
  AGlyph.Draw(DC, cxRectOffset(cxRectCenter(R, AGlyph.Size), 0, 1));
end;

procedure TdxCustomRibbonTexturedSkin.LoadApplicationButton(ABitmap: GpBitmap);
begin
  LoadThreeStateArray(ABitmap, cxRectBounds(0, 166, 42, 42), cxEmptyRect,
    FApplicationButton, rspApplicationButtonNormal, InterpolationModeHighQualityBicubic);
end;

procedure TdxCustomRibbonTexturedSkin.LoadBorderIcons(ABitmap: GpBitmap);
const
  IconWidth  = 25;
  IconHeight = 25;
begin
  LoadBorderIconsGlyphs(ABitmap, 0, 0, 9, 9);
  LoadElementParts(ABitmap, FBorderIcons, cxRectBounds(25, 37, IconWidth, IconHeight),
    rfspBorderIconHot, DefaultFixedSize, [0, 1, 2], [0, 1, 2], True, InterpolationModeNearestNeighbor);
end;

procedure TdxCustomRibbonTexturedSkin.LoadBorderIconsGlyphs(
  ABitmap: GpBitmap; X, Y, AWidth, AHeight: Integer);
var
  I: TdxBorderDrawIcon;
  ID: Integer;
  R: TRect;
begin
  ID := rfspMinimizeNormalIconGlyph;
  for I := Low(TdxBorderDrawIcon) to High(TdxBorderDrawIcon) do
  begin
    R := cxRectBounds(X, Y, AWidth, AHeight);
    LoadElementParts(ABitmap, FBorderIconGlyph[I], R, ID, DefaultFixedSize,
      [0, 1, 2, 3], [0, 1, 2, 3], True, InterpolationModeNearestNeighbor);
    Inc(X, AWidth + 1);
    Inc(ID, 4);
  end;
end;

procedure TdxCustomRibbonTexturedSkin.LoadCommonButtonParts(ABitmap: GpBitmap);
const
  SmallButtonSize  = 22;
  SmallButtonGlyphBackgroundWidth = 29;
  SmallButtonDropButtonWidth = 12;

  LargeButtonWidth  = 42;
  LargeButtonHeight = 66;
  LargeButtonGlyphBackgroundWidth = 42;
  LargeButtonGlyphBackgroundHeight = 39;
  LargeButtonDropButtonWidth = 42;
  LargeButtonDropButtonHeight = 27;

  LaunchButtonWidth = 15;
  LaunchButtonHeight = 14;
begin
  LoadElementParts(ABitmap, FSmallButtons,
    cxRectBounds(99, 155, SmallButtonSize, SmallButtonSize),
    rspSmallButtonNormal, DefaultFixedSize, [0, 0, 1, 2, 2, 3, 4], DXBAR_BTN_STATES);
  LoadElementParts(ABitmap, FSmallButtonGlyphBackgrounds,
    cxRectBounds(86, 0, SmallButtonGlyphBackgroundWidth, SmallButtonSize),
    rspSmallButtonGlyphBackgroundNormal, DefaultFixedSize, [], DXBAR_BTN_STATES);
  LoadElementParts(ABitmap, FSmallButtonDropButtons,
    cxRectBounds(86, 155, SmallButtonDropButtonWidth, SmallButtonSize),
    rspSmallButtonDropButtonNormal, DefaultFixedSize, [], DXBAR_BTN_STATES);

  LoadElementParts(ABitmap, FLargeButtons,
    cxRectBounds(0, 0, LargeButtonWidth, LargeButtonHeight),
    rspLargeButtonNormal, DefaultFixedSize, [0, 0, 1, 2, 2, 3, 4], DXBAR_BTN_STATES);
  LoadElementParts(ABitmap, FLargeButtonGlyphBackgrounds,
    cxRectBounds(43, 0, LargeButtonGlyphBackgroundWidth, LargeButtonGlyphBackgroundHeight),
    rspLargeButtonGlyphBackgroundNormal, DefaultFixedSize, [0, 1, 2, 1, 3, 4], DXBAR_BTN_STATES);
  LoadElementParts(ABitmap, FLargeButtonDropButtons,
    cxRectBounds(43, 235, LargeButtonDropButtonWidth, LargeButtonDropButtonHeight),
    rspLargeButtonDropButtonNormal, DefaultFixedSize, [0, 1, 1, 2, 2, 0, 3], DXBAR_BTN_STATES);

  LoadElementParts(ABitmap, FLaunchButtonBackgrounds,
    cxRectBounds(101, 350, LaunchButtonWidth, LaunchButtonHeight),
    rspLaunchButtonBackgroundNormal, DefaultFixedSize, [0, 0, 1],
    [DXBAR_HOT, DXBAR_ACTIVE, DXBAR_PRESSED]);
end;

procedure TdxCustomRibbonTexturedSkin.LoadCommonControlSkinFromBitmap(ABitmap: GpBitmap);
begin
  inherited LoadCommonControlSkinFromBitmap(ABitmap);
  FProgressSolidBand := AddPart3x3(ABitmap, cxRectBounds(6, 344, 86, 8), DefaultFixedSize, rspProgressSolidband);
  FProgressDiscreteBand := AddPart3x3(ABitmap, cxRectBounds(0, 344, 5, 8), DefaultFixedSize, rspProgressDiscreteBand);
  FContextBackgroundGlass := AddPart3x3(ABitmap,  cxRectBounds(61, 353, 17, 25), cxRect(2, 9, 2, 1), rspContextBackgroundGlass);
  LoadCommonButtonParts(ABitmap);
end;

procedure TdxCustomRibbonTexturedSkin.LoadCommonMenuParts(ABitmap: GpBitmap);
const
  MenuCheckSize = 6;
  MenuCheckMarkSize = 20;
  MenuDetachCaptionSize = 5;
begin
  inherited LoadCommonMenuParts(ABitmap);
  LoadElementParts(ABitmap, FMenuDetachCaption,
    cxRectBounds(1, 331, MenuDetachCaptionSize, MenuDetachCaptionSize),
    rspMenuDetachCaptionNormal, DefaultFixedSize, [], [DXBAR_NORMAL, DXBAR_HOT]);
  LoadElementParts(ABitmap, FMenuCheck,
    cxRectBounds(99, 310, MenuCheckSize, MenuCheckSize),
    rspMenuCheckNormal, DefaultFixedSize, [], [DXBAR_NORMAL, DXBAR_DISABLED]);
  LoadElementParts(ABitmap, FMenuCheckMark,
    cxRectBounds(99, 266, MenuCheckMarkSize, MenuCheckMarkSize),
    rspMenuCheckMarkNormal, DefaultFixedSize, [], [DXBAR_NORMAL, DXBAR_DISABLED]);
  LoadElementParts(ABitmap, FMenuScrollArea, cxRectBounds(86, 310, 6, 12),
    rspMenuScrollAreaNormal, DefaultFixedSize, [], [DXBAR_HOT, DXBAR_PRESSED]);
  FQATDefaultGlyph := AddPart1x1(ABitmap, cxRectBounds(100, 330, 16, 16), rspQATDefaultGlyph);
end;

procedure TdxCustomRibbonTexturedSkin.LoadContexts(ABitmap: GpBitmap);
begin
  FContextBackground := AddPart3x3(ABitmap,
    cxRectBounds(25, 439, 17, 25), cxRect(2,9,2,1), rspContextBackground);
  FContextTabGroupsArea[False] := AddPart3x3(ABitmap,
    cxRectBounds(12, 250, 11, 92), cxRect(5, 17, 5, 7), rspContextTabGroupsArea);
  FContextTabGroupsArea[True] := FContextTabGroupsArea[False];
  FContextTabSeparator[False] := AddPart3x3(ABitmap,
    cxRectBounds(25, 465, 1, 16), cxNullRect, rspContextTabSeparatorBegin);
  FContextTabSeparator[True] := AddPart3x3(ABitmap,
    cxRectBounds(25, 465, 1, 16), cxNullRect, rspContextTabSeparatorEnd);
end;

procedure TdxCustomRibbonTexturedSkin.LoadCollapsedToolbar(ABitmap: GpBitmap);
const
  CollapsedToolbarWidth  = 7;
  CollapsedToolbarHeight = 85;
  CollapsedToolbarFixedSize: TRect = (Left: 3; Top: 15; Right: 3; Bottom: 3);
  CollapsedToolbarGlyphBackgroundWidth = 10;
  CollapsedToolbarGlyphBackgroundHeight = 31;
  CollapsedToolbarGlyphBackgroundFixedSize: TRect = (Left: 4; Top: 9; Right: 4; Bottom: 8);
begin
  LoadElementParts(ABitmap, FCollapsedToolbars,
    cxRectBounds(25, 0, CollapsedToolbarWidth, CollapsedToolbarHeight),
    rspCollapsedToolbarNormal, CollapsedToolbarFixedSize, [0,1,3,2],
    [DXBAR_NORMAL, DXBAR_HOT, DXBAR_ACTIVE, DXBAR_PRESSED]);
  LoadElementParts(ABitmap, FCollapsedToolbarGlyphBackgrounds,
    cxRectBounds(66, 199, CollapsedToolbarGlyphBackgroundWidth,
    CollapsedToolbarGlyphBackgroundHeight),
    rspCollapsedToolbarGlyphBackgroundNormal,
    CollapsedToolbarGlyphBackgroundFixedSize, [0,1,3,2],
    [DXBAR_NORMAL, DXBAR_HOT, DXBAR_ACTIVE, DXBAR_PRESSED]);
end;

procedure TdxCustomRibbonTexturedSkin.LoadCustomButtonParts(ABitmap: GpBitmap);
const
  ArrowDownHeight = 4;
  ArrowDownWidth = 5;
  ButtonGroupHeight = 22;
  ButtonGroupMiddleBorderWidth = 1;
  ButtonGroupWidth = 3;
  MenuArrowDownHeight = 4;
  MenuArrowDownWidth = 7;
begin
  inherited LoadCustomButtonParts(ABitmap);
  LoadElementParts(ABitmap, FArrowsDown,
    cxRectBounds(0, 237, ArrowDownWidth, ArrowDownHeight),
    rspArrowDownNormal, cxEmptyRect, [0, 1, 2, 2, 2, 2, 0, 0, 1], []);
  FMenuArrowDown := AddPart1x1(ABitmap,
    cxRectBounds(6, 245, MenuArrowDownWidth, MenuArrowDownHeight), rspMenuArrowDown);
  FMenuArrowRight := AddPart1x1(ABitmap,
    cxRectBounds(6, 237, MenuArrowDownHeight, MenuArrowDownWidth), rspMenuArrowRight);
  FButtonGroupBorderLeft := AddPart3x3(ABitmap, cxRectBounds(37, 197, 2, ButtonGroupHeight),
    Rect(0, 2, 0, 2), rspButtonGroupBorderLeft);
  FButtonGroupBorderRight := AddPart3x3(ABitmap, cxRectBounds(38, 197, 2, ButtonGroupHeight),
    Rect(0, 2, 0, 2), rspButtonGroupBorderRight);
  LoadElementParts(ABitmap, FButtonGroupBorderMiddle,
    cxRectBounds(40, 86, ButtonGroupMiddleBorderWidth, ButtonGroupHeight),
    rspButtonGroupBorderMiddleNormal, Rect(0, 2, 0, 2), [0, 1, 2, 2, 2, 2, 2, 2, 3], []);
  LoadElementParts(ABitmap, FButtonGroupSplitButtonSeparator, cxRectBounds(37, 86, 2, ButtonGroupHeight),
    rspButtonGroupSplitButtonSeparatorNormal, Rect(0, 2, 0, 2), [0, 1, 2, 2, 3, 2, 2, 2, 4], []);
end;

procedure TdxCustomRibbonTexturedSkin.LoadCustomControlSkinFromBitmap(ABitmap: GpBitmap);
begin
  inherited LoadCustomControlSkinFromBitmap(ABitmap);
  LoadCollapsedToolbar(ABitmap);
  LoadScrollButtons(ABitmap);
  LoadContexts(ABitmap);
  LoadCustomGroup(ABitmap);
  LoadStatusBar(ABitmap);

  FProgressSubstrate := AddPart3x3(ABitmap, cxRectBounds(11, 237, 7, 7), DefaultFixedSize, rspProgressSubstrate);
end;

procedure TdxCustomRibbonTexturedSkin.LoadCustomGroup(ABitmap: GpBitmap);
begin
  FTabGroupsArea[False] := AddPart3x3(ABitmap,
    cxRectBounds(13, 116, 11, 92), cxRect(5, 17, 5, 7), rspTabGroupsArea);
  FTabGroupsArea[True] := FTabGroupsArea[False];
  LoadElementParts(ABitmap, FToolbar, cxRectBounds(66, 350, 10, 20),
    rspToolbarNormal, cxRect(3, 2, 3, 0), [], [DXBAR_NORMAL, DXBAR_HOT], False);
  LoadElementParts(ABitmap, FToolbarHeader, cxRectBounds(66, 370, 10, 17),
    rspToolbarHeaderNormal, cxRect(3, 0, 3, 3), [], [DXBAR_NORMAL, DXBAR_HOT], False);
  LoadElementParts(ABitmap, FMarkArrow, cxRectBounds(36, 220, 7, 7),
    rspMarkArrowNormal, cxEmptyRect, [0, 0, 1], [DXBAR_NORMAL, DXBAR_HOT, DXBAR_PRESSED], True);
  LoadElementParts(ABitmap, FMarkTruncated, cxRectBounds(36, 234, 8, 6),
    rspMarkTruncatedNormal, cxEmptyRect, [0, 0, 1], [DXBAR_NORMAL, DXBAR_HOT, DXBAR_PRESSED], True);
end;

procedure TdxCustomRibbonTexturedSkin.LoadCustomMenuParts(ABitmap: GpBitmap);
begin
  inherited LoadCustomMenuParts(ABitmap);
  FMenuScrollArea[DXBAR_NORMAL] := AddPart3x3(ABitmap,
    cxRectBounds(20, 237, 4, 12), Rect(1, 1, 1, 1), rspMenuScrollAreaNormal);
end;

procedure TdxCustomRibbonTexturedSkin.LoadFormBorders(ABitmap: GpBitmap);
var
  R: TRect;
begin
  AddTwoStateElement(ABitmap, FCaption,
    cxRectBounds(0, 37, 14, 31), cxRect(6, 10, 6, 5), rfspActiveCaption);
  AddTwoStateElement(ABitmap, FCaptionZoomed,
    cxRectBounds(6, 37, 2, 31), cxRect(0, 10, 0, 5), rfspActiveCaptionZoomed);
  // Caption Borders
  R := cxRectBounds(0, 37, 4, 31);
  AddTwoStateElement(ABitmap, FCaptionLeftBorder, R, cxRect(0, 9, 0, 2), rfspActiveCaptionLeftBorder);
  OffsetRect(R, 10, 0);
  AddTwoStateElement(ABitmap, FCaptionRightBorder, R, cxRect(0, 9, 0, 2), rfspActiveCaptionRightBorder);
  //active border
  R := cxRectBounds(15, 37, 4, 6);
  AddTwoStateElement(ABitmap, FLeftBorder, R, cxRect(0, 0, 0, 5), rfspActiveLeftBorder);
  OffsetRect(R, 5, 0);
  AddTwoStateElement(ABitmap, FRightBorder, R, cxRect(0, 0, 0, 5), rfspActiveRightBorder);
  //bottom border
  AddTwoStateElement(ABitmap, FBottomBorderThin,
    cxRectBounds(15, 50, 2, 2), cxEmptyRect, rfspActiveBottomBorder1);
  AddTwoStateElement(ABitmap, FBottomBorderThick[False],
    cxRectBounds(40, 113, 10, 4), cxRect(4, 0, 4, 0), rfspActiveBottomBorder2);
  AddTwoStateElement(ABitmap, FBottomBorderThick[True],
    cxRectBounds(40, 121, 10, 4), cxRect(4, 0, 4, 0), rfspActiveBottomBorder3);
end;

procedure TdxCustomRibbonTexturedSkin.LoadFormSkinFromBitmap(ABitmap: GpBitmap);
begin
  inherited LoadFormSkinFromBitmap(ABitmap);
  FRibbonTopArea := AddPart3x3(ABitmap, cxRectBounds(6, 38, 2, 30), cxRect(0, 9, 0, 5), rspRibbonClientTopArea);
  LoadFormBorders(ABitmap);
  LoadBorderIcons(ABitmap);
  LoadApplicationButton(ABitmap);
end;

procedure TdxCustomRibbonTexturedSkin.LoadGallery(ABitmap: GpBitmap);
begin
  inherited LoadGallery(ABitmap);
  LoadInRibbonGalleryScrollBarParts(ABitmap);
  FGalleryFilterBand := AddPart3x3(ABitmap, cxRectBounds(7, 250, 4, 13),
    cxRectBounds(1, 1, 1, 0), rspGalleryFilterBand);
  FGalleryGroupHeader := AddPart3x3(ABitmap, cxRectBounds(0, 273, 4, 4),
    cxRectBounds(0, 0, 0, 2), rspGalleryGroupHeader);
  FDropDownGalleryTopSizingBand := AddPart3x3(ABitmap, cxRectBounds(38, 29, 4, 11),
    cxRectBounds(1, 1, 1, 1), rspDropDownGalleryTopSizingBand);
  FDropDownGalleryBottomSizingBand := AddPart3x3(ABitmap, cxRectBounds(33, 29, 4, 11),
    cxRectBounds(1, 1, 1, 1), rspDropDownGalleryBottomSizingBand);
end;

procedure TdxCustomRibbonTexturedSkin.LoadInRibbonGalleryScrollBarParts(ABitmap: GpBitmap);
const
  ScrollBarButtonWidth = 15;
  ScrollBarButtonHeight = 20;
begin
  LoadElementParts(ABitmap, FInRibbonGalleryScrollBarLineUpButton,
    cxRectBounds(78, 0, ScrollBarButtonWidth, ScrollBarButtonHeight),
    rspInRibbonGalleryScrollBarLineUpButtonNormal, DefaultFixedSize,
    [0, 3, 1, 2], [DXBAR_NORMAL, DXBAR_DISABLED, DXBAR_HOT, DXBAR_PRESSED]);
  LoadElementParts(ABitmap, FInRibbonGalleryScrollBarLineDownButton,
    cxRectBounds(78, 80, ScrollBarButtonWidth, ScrollBarButtonHeight),
    rspInRibbonGalleryScrollBarLineDownButtonNormal, DefaultFixedSize,
    [0, 3, 1, 2], [DXBAR_NORMAL, DXBAR_DISABLED, DXBAR_HOT, DXBAR_PRESSED]);
  LoadElementParts(ABitmap, FInRibbonGalleryScrollBarDropDownButton,
    cxRectBounds(78, 160, ScrollBarButtonWidth, ScrollBarButtonHeight),
    rspInRibbonGalleryScrollBarDropDownButtonNormal, DefaultFixedSize,
    [0, 3, 1, 2], [DXBAR_NORMAL, DXBAR_DISABLED, DXBAR_HOT, DXBAR_PRESSED]);
end;

procedure TdxCustomRibbonTexturedSkin.LoadQAT(ABitmap: GpBitmap);
begin
  inherited LoadQAT(ABitmap);
  FQATPopup :=  AddPart3x3(ABitmap, cxRectBounds(33, 0, 6, 28), cxRect(2, 2, 2, 2), rspQATPopup);
end;

procedure TdxCustomRibbonTexturedSkin.LoadScrollButtons(ABitmap: GpBitmap);
var
  R, FR: TRect;
begin
  FR := cxRect(3, 4, 3, 5);
  R := cxRectBounds(46, 350, 9, 24);
  LoadThreeStateArray(ABitmap, R, FR, FTabScrollButtons[True], rspTabScrollLeftButtonNormal);
  R := cxRectBounds(56, 350, 9, 24);
  LoadThreeStateArray(ABitmap, R, FR, FTabScrollButtons[False], rspTabScrollRightButtonNormal);
  R := cxRectBounds(48, 0, 8, 92);
  LoadThreeStateArray(ABitmap, R, cxRect(4, 4, 2, 4), FGroupScrollButtons[True], rspGroupScrollLeftButtonNormal);
  R := cxRectBounds(57, 0, 8, 92);
  LoadThreeStateArray(ABitmap, R, cxRect(2, 4, 4, 4), FGroupScrollButtons[False], rspGroupScrollRightButtonNormal);
end;

procedure TdxCustomRibbonTexturedSkin.LoadStatusBar(ABitmap: GpBitmap);
begin
  FStatusBar := AddPart1x3(ABitmap, cxRectBounds(42, 138, 2, 22), 2, 3, rspStatusBar);
  FStatusBarPanel := FStatusBar;
  FStatusBarPanelLowered := FStatusBar;
  FStatusBarPanelRaised := AddPart1x3(ABitmap, cxRectBounds(42, 160, 2, 22), 2, 3, rspStatusBarPanelRaised);

  FStatusBarPanelSeparator := AddPart1x3(ABitmap,
    cxRectBounds(42, 183, 3, 22), 2, 3, rspStatusBarPanelSeparator);
  FStatusBarToolbarSeparator := AddPart1x3(ABitmap,
    cxRectBounds(45, 138, 2, 22), 2, 3, rspStatusBarToolbarSeparator);
  FStatusBarGripBackground := AddPart3x3(ABitmap,
    cxRectBounds(42, 183, 5, 22), cxRect(3, 2, 0, 3), rspStatusBarGripBackground);

  LoadElementParts(ABitmap, FFormStatusBarLeftParts[False], cxRectBounds(77, 241, 4, 22),
    rspStatusBarFormLeftPart, cxRect(0, 2, 0, 3), [0, 1, 2, 3], [0, 1, 2, 3]);
  LoadElementParts(ABitmap, FFormStatusBarLeftParts[True], cxRectBounds(85, 241, 4, 22),
    rspStatusBarFormLeftPartDialog, cxRect(0, 2, 0, 3), [0, 1, 2, 3], [0, 1, 2, 3]);
  LoadElementParts(ABitmap, FFormStatusBarRightParts[False], cxRectBounds(81, 241, 4, 22),
    rspStatusBarFormRightPart, cxRect(0, 2, 0, 3), [0, 1, 2, 3], [0, 1, 2, 3]);
  LoadElementParts(ABitmap, FFormStatusBarRightParts[True], cxRectBounds(89, 241, 4, 22),
    rspStatusBarFormRightPartDialog, cxRect(0, 2, 0, 3), [0, 1, 2, 3], [0, 1, 2, 3]);
end;

procedure TdxCustomRibbonTexturedSkin.LoadTab(ABitmap: GpBitmap);
begin
  inherited LoadTab(ABitmap);
  LoadElementParts(ABitmap, FTabIndex, cxRectBounds(0, 0, 24, 23), rspTabNormal,
    cxRect(4, 4, 4, 4), [0,1,2,3,4], [0,1,2,3,4]);
  LoadElementParts(ABitmap, FContextTabIndex, cxRectBounds(0, 439, 24, 23), rspContextTabNormal,
    cxRect(5, 3, 5, 1), [0,1,2,3,4], [0,1,2,3,4]);
end;

{ TdxCustomRibbon2010Skin }

procedure TdxCustomRibbon2010Skin.DrawBackstageViewBackground(DC: HDC; const R: TRect);
var
  APart: TdxSkinnedRect;
  R1: TRect;
begin
  inherited DrawBackstageViewBackground(DC, R);
  if not LowColors then
  begin
    R1 := R;
    APart := Parts[FBackstageViewBackground];
    R1.Left := R1.Right - APart.Size.cx;
    R1.Top := R1.Bottom - APart.Size.cy;
    APart.Draw(DC, R1);
  end;
end;

procedure TdxCustomRibbon2010Skin.DrawBackstageViewMenuBackground(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawBackstageViewMenuBackground(DC, R)
  else
    Parts[FBackstageViewMenuBackground].Draw(DC, R);
end;

procedure TdxCustomRibbon2010Skin.DrawBackstageViewMenuButton(
  DC: HDC; const R: TRect; AState: Integer);
begin
  if LowColors then
    inherited DrawBackstageViewMenuButton(DC, R, AState)
  else
  begin
    case AState of
      DXBAR_HOT, DXBAR_ACTIVE, DXBAR_PRESSED:
        AState := 0;
      DXBAR_ACTIVEDISABLED:
        AState := 1;
      else
        Exit;
    end;
    Parts[FBackstageViewMenuButton[AState = 1]].Draw(DC, R);
  end;
end;

procedure TdxCustomRibbon2010Skin.DrawBackstageViewTabButton(
  DC: HDC; const R: TRect; AState: Integer);
var
  APart: TdxSkinnedRect;
  APartIndex: Integer;
  R1: TRect;
begin
  if LowColors then
  begin
    inherited DrawBackstageViewTabButton(DC, R, AState);
    Exit;
  end;

  case AState of
    DXBAR_HOT, DXBAR_ACTIVE:
      APartIndex := 0;
    DXBAR_CHECKED, DXBAR_PRESSED:
      APartIndex := 1;
    DXBAR_HOTCHECK:
      APartIndex := 2;
    DXBAR_ACTIVEDISABLED:
      APartIndex := 3;
    else
      Exit;
  end;
  if APartIndex >= 0 then
    Parts[FBackstageViewTabs[APartIndex]].Draw(DC, R);
  if APartIndex in [1, 2] then
  begin
    APart := Parts[FBackstageViewTabArrow];
    R1 := cxRectCenter(R, cxRectWidth(R), APart.Size.cy);
    APart.Draw(DC, cxRectSetRight(R1, R1.Right, APart.Size.cx));
  end;
end;

procedure TdxCustomRibbon2010Skin.DrawBackstageViewTopLine(DC: HDC; const R: TRect);
begin
  if LowColors then
    inherited DrawBackstageViewTopLine(DC, R)
  else
    Parts[FBackstageViewTopLine].Draw(DC, R);
end;

procedure TdxCustomRibbon2010Skin.DrawContextBackground(DC: HDC; const R: TRect; AColor: TColor);
var
  R1: TRect;
begin
  if LowColors then
    inherited DrawContextBackground(DC, R, AColor)
  else
  begin
    R1 := cxRectSetHeight(R, cxRectHeight(R) + 1);
    DrawColoredElement(FContextBackgroundMask, DC, R1, AColor);
    Parts[FContextBackground].Draw(DC, R1);
  end;
end;

procedure TdxCustomRibbon2010Skin.DrawContextBackgroundGlass(
  DC: HDC; const R: TRect; AColor: TColor);
var
  ASaveIndex: Integer;
begin
  ASaveIndex := SaveDC(DC);
  try
    IntersectClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
    DrawContextBackground(DC, cxRectOffset(R, 0, -1), AColor);
  finally
    RestoreDC(DC, ASaveIndex);
  end;
end;

procedure TdxCustomRibbon2010Skin.DrawContextTabBackground(
  DC: HDC; const R: TRect; AState: TdxRibbonTabState; AColor: TColor);
begin
  if LowColors then
    inherited DrawContextTabBackground(DC, R, AState, AColor)
  else
  begin
    DrawColoredElement(FContextTabMaskIndex[AState], DC, R, AColor);
    Parts[FContextTabIndex[AState]].Draw(DC, R);
  end;
end;

procedure TdxCustomRibbon2010Skin.DrawApplicationMenuBackground(DC: HDC; const R, AContentRect: TRect);
var
  ABorderRect, R1: TRect;
  AHeaderRect, AFooterRect: TRect;
  ABorderColor, ATempColor: TColor;
begin
  R1 := cxRectInflate(R, -2, -2);
  ABorderRect := cxRectInflate(AContentRect, 0, 1, 0, 1);
  AHeaderRect := cxRectSetHeight(R1, ABorderRect.Top - R1.Top);
  AFooterRect := cxRectSetTop(R1, ABorderRect.Bottom, R1.Bottom - ABorderRect.Bottom);

  if LowColors then
  begin
    FillRectByColor(DC, AHeaderRect, clMenu);
    FillRectByColor(DC, AFooterRect, clMenu);
    DrawFrame(DC, R, clMenu, clBlack);
  end
  else
  begin
    Parts[FApplicationMenuContentHeader].Draw(DC, AHeaderRect);
    Parts[FApplicationMenuContentFooter].Draw(DC, AFooterRect);
    Parts[FApplicationMenuBorder].Draw(DC, R);
  end;

  GetApplicationMenuContentColors(ATempColor, ABorderColor, ATempColor);
  DrawFrame(DC, ABorderRect, clNone, ABorderColor);
end;

procedure TdxCustomRibbon2010Skin.DrawButtonGroup(DC: HDC; const R: TRect; AState: Integer);
begin
  DrawSmallButton(DC, R, AState);
end;

procedure TdxCustomRibbon2010Skin.DrawFormBorderIcon(
  DC: HDC; const R: TRect; AIcon: TdxBorderDrawIcon; AState: TdxBorderIconState);
var
  APart: Integer;
begin
  if LowColors or (AIcon <> bdiClose) then
    inherited DrawFormBorderIcon(DC, R, AIcon, AState)
  else
  begin
    case AState of
      bisHot: APart := 0;
      bisPressed: APart := 1;
      bisHotInactive: APart := 2;
    else
      APart := -1;
    end;
    if APart >= 0 then
      Parts[FCloseButton[APart]].Draw(DC, R);
    InternalDrawFormBorderIconGlyph(DC, R, AIcon, AState);
  end;
end;

procedure TdxCustomRibbon2010Skin.DrawFormCaption(DC: HDC;
  const R: TRect; const AData: TdxRibbonFormData; ATabHeadersAreaVisible: Boolean);
begin
  inherited DrawFormCaption(DC, R, AData, ATabHeadersAreaVisible);
  if not ATabHeadersAreaVisible and (AData.State <> wsMinimized) then
    DrawFormCaptionSeparator(DC, cxRectSetBottom(R, R.Bottom, 1));
end;

procedure TdxCustomRibbon2010Skin.DrawItemSeparator(
  DC: HDC; const R: TRect; AHorizontal: Boolean);
var
  APart: TdxSkinnedRect;
  R1: TRect;
begin
  APart := Parts[FItemsSeparator[AHorizontal]];
  if AHorizontal then
    R1 := cxRectCenter(R, cxRectWidth(R), APart.Size.cy)
  else
    R1 := cxRectCenter(R, APart.Size.cx, cxRectHeight(R));
  APart.Draw(DC, R1);
end;

procedure TdxCustomRibbon2010Skin.DrawMenuExtraSeparator(
  DC: HDC; const R: TRect; AHorizontal: Boolean);
begin
  InternalDrawSeparator(DC, R, AHorizontal, clWhite, $EBDBCF);
end;

procedure TdxCustomRibbon2010Skin.DrawMDIButtonGlyph(
  DC: HDC; const R: TRect; AButton: TdxBarMDIButton; AState: TcxButtonState);
const
  PartStateMap: array[TcxButtonState] of Integer = (0, 0, 1, 2, 3);
var
  APart: TdxSkinnedRect;
begin
  APart := Parts[FMDIButtonGlyphs[AButton][PartStateMap[AState]]];
  APart.Draw(DC, cxRectCenter(R, APart.Size));
end;

procedure TdxCustomRibbon2010Skin.DrawMinimizeRibbonButtonGlyph(DC: HDC;
  const R: TRect; AState: TcxButtonState; AGlyph: TdxRibbonMinimizeButtonGlyph);
var
  APart: TdxSkinnedRect;
begin
  APart := Parts[FMinimizeRibbonButtonGlyph[AGlyph][AState = cxbsDisabled]];
  APart.Draw(DC, cxRectCenter(R, APart.Size));
end;

procedure TdxCustomRibbon2010Skin.DrawQuickAccessToolbar(DC: HDC; const R: TRect;
  ABellow, ANonClientDraw, AHasApplicationButton, AIsActive, ADontUseAero: Boolean);
begin
  inherited DrawQuickAccessToolbar(DC, R, ABellow, ANonClientDraw, False, AIsActive, ABellow);
end;

procedure TdxCustomRibbon2010Skin.DrawColoredElement(
  APartIndex: Integer; DC: HDC; const R: TRect; AColor: TColor);
var
  ABitmap: TcxBitmap32;
begin
  ABitmap := TcxBitmap32.CreateSize(R, True);
  try
    Parts[APartIndex].Draw(ABitmap.Canvas.Handle, ABitmap.ClientRect);
    cxMakeColoredBitmap(ABitmap, AColor);
    cxAlphaBlend(DC, ABitmap, R, ABitmap.ClientRect);
  finally
    ABitmap.Free;
  end;
end;

procedure TdxCustomRibbon2010Skin.DrawFormCaptionSeparator(DC: HDC; const R: TRect);
begin
end;

procedure TdxCustomRibbon2010Skin.DrawRibbonTopFrameArea(
  DC: HDC; const R: TRect; AUseAeroGlass: Boolean);
var
  R1: TRect;
begin
  if AUseAeroGlass then
  begin
    R1 := R;
    Dec(R1.Bottom);
    Parts[FTabsAreaOnGlass].Draw(DC, R1);
  end;
end;

procedure TdxCustomRibbon2010Skin.DrawSeparatorLine(DC: HDC; const R: TRect);
begin
end;

function TdxCustomRibbon2010Skin.GetApplicationMenuContentOffset(const ATabsBounds: TRect): TRect;
begin
  Result := cxRect(2, cxRectHeight(ATabsBounds) - 2, 2, 30);
end;

function TdxCustomRibbon2010Skin.GetApplicationMenuGlyphSize: TSize;
begin
  Result := cxSize(56, 25);
end;

function TdxCustomRibbon2010Skin.GetContextFontStyle(
  const ACurrentFontStyle: TFontStyles): TFontStyles;
begin
  Result := [fsBold] + ACurrentFontStyle;
end;

function TdxCustomRibbon2010Skin.GetStyle: TdxRibbonStyle;
begin
  Result := rs2010;
end;

function TdxCustomRibbon2010Skin.GetPartColor(APart: Integer; AState: Integer = 0): TColor;
begin
  Result := inherited GetPartColor(APart, AState);
  if LowColors then Exit;

  case APart of
    DXBAR_MENUEXTRAPANE:
      Result := GetPartColor(DXBAR_EDIT_BACKGROUND, DXBAR_NORMAL);
    DXBAR_DROPDOWNGALLERY:
      Result := clWhite;
    DXBAR_SEPARATOR_BACKGROUND, DXBAR_DATENAVIGATOR_HEADER:
      Result := $F5F2F0;
    DXBAR_INRIBBONGALLERY_BORDER:
      Result := GetPartColor(DXBAR_EDIT_BORDER, DXBAR_NORMAL);
    DXBAR_MENUITEMTEXT:
      if not (AState in [DXBAR_DISABLED, DXBAR_ACTIVEDISABLED]) then
        Result := $5B391E;

    rspApplicationButtonNormal..rspApplicationButtonPressed:
      Result := clWhite;
    rspFormCaptionText, rspDocumentNameText, rspTabHeaderText,
    rspTabGroupText, rspTabGroupHeaderText, rspStatusBarText:
      Result := $5B391E;
    rspContextText:
      Result := clWhite;
    rspContextTextShadow:
      Result := clGray;
    rspContextTextOnGlass:
      Result := $5B391E;

    DXBAR_EDIT_BUTTON_BORDER:
      case AState of
        DXBAR_HOT:
          Result := $54CCF0;
        DXBAR_DROPPEDDOWN, DXBAR_PRESSED:
          Result := $3888C2;
        DXBAR_DISABLED, DXBAR_ACTIVEDISABLED, DXBAR_NORMAL:
          Result := GetPartColor(DXBAR_EDIT_BACKGROUND, DXBAR_NORMAL);
        DXBAR_ACTIVE:
          Result := GetPartColor(DXBAR_EDIT_BORDER, DXBAR_ACTIVE);
      end;

    rbvpBackstageViewMenuItem:
      case AState of
        DXBAR_DISABLED, DXBAR_ACTIVEDISABLED:
          Result := $AAA6A5;
        else
          Result := clBlack;
      end;

    rbvpBackstageViewMenuTabButton:
      case AState of
        DXBAR_DISABLED, DXBAR_ACTIVEDISABLED:
          Result := $AAA6A5;
        DXBAR_HOTCHECK, DXBAR_CHECKED, DXBAR_PRESSED:
          Result := clWhite;
        else
          Result := clBlack;
      end;
  end;
end;

function TdxCustomRibbon2010Skin.GetPartContentOffsets(APart: Integer): TRect;
begin
  case APart of
    DXBAR_APPLICATIONMENUBUTTON:
       Result := Rect(0, 4, 2, 4);
    DXBAR_APPLICATIONBUTTON:
      Result := cxRect(0, 0, cxGetValueCurrentDPI(4), 0);
    DXBAR_APPLICATIONBUTTONICONOFFSET:
      Result := cxRect(12, 5, 12, 4);
    DXBAR_COLLAPSEDTOOLBAR:
      Result := cxRect(2, 2, 5, 2);
    DXBAR_COLLAPSEDTOOLBARGLYPHBACKGROUND:
      Result := Rect(7, 7, 7, 7);
    DXBAR_TOOLBAR:
      Result := cxRect(0, 3, 5, 1);
    else
      Result := inherited GetPartContentOffsets(APart);
  end;
end;

function TdxCustomRibbon2010Skin.GetPartOffset(APart: Integer): Integer;
begin
  case APart of
    DXBAR_SEPARATOR_LINE:
      Result := 0;
    rbvpBackstageViewTopLine:
      Result := 2;
    rspContextTabSeparatorBegin, rspContextTabSeparatorEnd:
      Result := 2;
    DXBAR_TOOLBAR:
      Result := 0;
    else
      Result := inherited GetPartOffset(APart);
  end;
end;

function TdxCustomRibbon2010Skin.GetQuickAccessToolbarMarkButtonOffset(
  AHasApplicationButton, ABelow: Boolean): Integer;
begin
  Result := 8;
end;

function TdxCustomRibbon2010Skin.GetQuickAccessToolbarOverrideWidth(
  AHasApplicationButton, AUseAeroGlass: Boolean): Integer;
begin
  Result := 4;
end;

function TdxCustomRibbon2010Skin.GetWindowBordersWidth(AHasStatusBar: Boolean): TRect;
begin
  Result := cxRect(8, 0, 8, 8);
end;

procedure TdxCustomRibbon2010Skin.LoadApplicationButton(ABitmap: GpBitmap);
begin
  LoadThreeStateArray(ABitmap, cxRectBounds(32, 0, 56, 24), cxRect(4, 4, 4, 4),
    FApplicationButton, rspApplicationButtonNormal, InterpolationModeHighQualityBicubic);
end;

procedure TdxCustomRibbon2010Skin.LoadBackstageView(ABitmap: GpBitmap);
begin
  FBackstageViewMenuBackground := AddPart3x3(ABitmap,
    cxRectBounds(240, 209, 17, 115), cxRect(0, 0, 7, 0), rbvpBackstageViewMenu);
  FBackstageViewTabArrow := AddPart1x1(ABitmap, cxRectBounds(175, 208, 15, 30), rbvpBackstageViewMenuTabButtonArrow);
  LoadElementParts(ABitmap, FBackstageViewTabs, cxRectBounds(163, 36, 95, 43),
    rbvpBackstageViewMenuTabButton, cxRect(0, 4, 0, 4), [0, 1, 2, 3], [0, 1, 2, 3]);
  LoadElementParts(ABitmap, FBackstageViewMenuButton, cxRectBounds(163, 208, 12, 22),
    rbvpBackstageViewMenuItem, DefaultFixedSize, [0, 1], [0, 1]);
end;

procedure TdxCustomRibbon2010Skin.LoadBorderIcons(ABitmap: GpBitmap);
begin
  LoadBorderIconsGlyphs(ABitmap, 0, 73, 13, 11);
  LoadElementParts(ABitmap, FBorderIcons, cxRectBounds(89, 0, 17, 17),
    rfspBorderIconHot, DefaultFixedSize, [0, 1, 2], [0, 1, 2], True,
    InterpolationModeNearestNeighbor);
  LoadElementParts(ABitmap, FCloseButton, cxRectBounds(107, 0, 17, 17),
    rfspCloseButtonHot, DefaultFixedSize, [0, 1, 2], [0, 1, 2], True,
    InterpolationModeNearestNeighbor);
  LoadElementParts(ABitmap, FMinimizeRibbonButtonGlyph[rmbMinimize],
    cxRectBounds(89, 58, 9, 7), rspMinimizeRibbonButtonMinimize,
    cxNullRect, [0, 1], [0, 1], True, InterpolationModeNearestNeighbor);
  LoadElementParts(ABitmap, FMinimizeRibbonButtonGlyph[rmbRestore],
    cxRectBounds(98, 58, 9, 7), rspMinimizeRibbonButtonRestore,
    cxNullRect, [0, 1], [0, 1], True, InterpolationModeNearestNeighbor);
  LoadElementParts(ABitmap, FMinimizeRibbonButtonGlyph[rmbPin],
    cxRectBounds(107, 58, 12, 9), rspMinimizeRibbonButtonPin,
    cxNullRect, [0, 1], [0, 1], True, InterpolationModeNearestNeighbor);
  LoadMDIButtons(ABitmap);
end;

procedure TdxCustomRibbon2010Skin.LoadCollapsedToolbar(ABitmap: GpBitmap);
begin
  LoadElementParts(ABitmap, FCollapsedToolbars, cxRectBounds(94, 177, 68, 68),
    rspCollapsedToolbarNormal, cxRect(0, 0, 3, 3), [0, 1, 3, 2],
    [DXBAR_NORMAL, DXBAR_HOT, DXBAR_ACTIVE, DXBAR_PRESSED]);
  LoadElementParts(ABitmap, FCollapsedToolbarGlyphBackgrounds,
    cxRectBounds(66, 199, 10, 31), rspCollapsedToolbarGlyphBackgroundNormal,
    DefaultFixedSize, [0, 1, 3, 2], [DXBAR_NORMAL, DXBAR_HOT, DXBAR_ACTIVE, DXBAR_PRESSED]);
end;

procedure TdxCustomRibbon2010Skin.LoadCommonControlSkinFromBitmap(ABitmap: GpBitmap);
begin
  inherited LoadCommonControlSkinFromBitmap(ABitmap);
  FBackstageViewBackground := AddPart1x1(ABitmap, cxRectBounds(122, 0, 348, 171), rbvpBackstageView);
  FBackstageViewTopLine := AddPart1x1(ABitmap, cxRectBounds(342, 172, 128, 2), rbvpBackstageViewTopLine);
end;

procedure TdxCustomRibbon2010Skin.LoadCommonMenuParts(ABitmap: GpBitmap);
begin
  inherited LoadCommonMenuParts(ABitmap);
  Parts[FMenuSeparatorHorz].StretchMode := srsmTile;
end;

procedure TdxCustomRibbon2010Skin.LoadCommonRibbonSkinBitmap(out ABitmap: GpBitmap);
begin
  LoadBitmapFromStream('RIBBONCOMMON2010', ABitmap);
end;

procedure TdxCustomRibbon2010Skin.LoadCustomControlSkinFromBitmap(ABitmap: GpBitmap);
begin
  inherited LoadCustomControlSkinFromBitmap(ABitmap);
  FItemsSeparator[False] := AddPart1x1(ABitmap, cxRectBounds(24, 320, 3, 22), rspItemSeparatorVertical);
  FItemsSeparator[True] := AddPart1x1(ABitmap, cxRectBounds(12, 343, 22, 3), rspItemSeparatorHorizontal);
  LoadBackstageView(ABitmap);
end;

procedure TdxCustomRibbon2010Skin.LoadContexts(ABitmap: GpBitmap);
begin
  FContextBackground := AddPart3x3(ABitmap,
    cxRectBounds(25, 439, 17, 25), cxRect(2,9,2,1), rspContextBackground);
  FContextBackgroundMask := AddPart3x3(ABitmap,
    cxRectBounds(8, 439, 17, 25), cxRect(2, 9, 2, 1), rspContextBackgroundMask);
  LoadElementParts(ABitmap, FContextTabSeparator, cxRectBounds(0, 440, 2, 16),
    rspContextTabSeparatorBegin, cxNullRect, [0, 1], [0, 1], False);
  LoadElementParts(ABitmap, FContextTabGroupsArea, cxRectBounds(12, 250, 5, 92),
    rspContextTabGroupsArea, cxRect(0, 17, 0, 7), [0, 1], [0, 1], False);
end;

procedure TdxCustomRibbon2010Skin.LoadCustomGroup(ABitmap: GpBitmap);
begin
  LoadElementParts(ABitmap, FToolbar, cxRectBounds(94, 0, 68, 68),
    rspToolbarNormal, cxRect(0, 0, 3, 0), [], [DXBAR_NORMAL, DXBAR_HOT]);
  LoadElementParts(ABitmap, FToolbarHeader, cxRectBounds(94, 136, 68, 20),
    rspToolbarHeaderNormal, cxRect(0, 0, 3, 2), [], [DXBAR_NORMAL, DXBAR_HOT]);
  LoadElementParts(ABitmap, FTabGroupsArea, cxRectBounds(13, 116, 5, 92),
    rspTabGroupsArea, cxRect(0, 17, 0, 7), [0, 1], [0, 1], False);
  LoadElementParts(ABitmap, FMarkArrow, cxRectBounds(36, 220, 7, 7),
    rspMarkArrowNormal, cxEmptyRect, [0, 0, 1], [DXBAR_NORMAL, DXBAR_HOT, DXBAR_PRESSED], True);
  LoadElementParts(ABitmap, FMarkTruncated, cxRectBounds(36, 234, 8, 6),
    rspMarkTruncatedNormal, cxEmptyRect, [0, 0, 1], [DXBAR_NORMAL, DXBAR_HOT, DXBAR_PRESSED], True);
end;

procedure TdxCustomRibbon2010Skin.LoadFormBorders(ABitmap: GpBitmap);
var
  R: TRect;
begin
  // Caption
  AddTwoStateElement(ABitmap, FCaption,
    cxRectBounds(0, 0, 14, 31), cxRect(6, 10, 6, 5), rfspActiveCaption);
  AddTwoStateElement(ABitmap, FCaptionZoomed,
    cxRectBounds(6, 0, 2, 31), cxRect(0, 10, 0, 5), rfspActiveCaptionZoomed);
  R := cxRectBounds(0, 0, 8, 31);
  AddTwoStateElement(ABitmap, FCaptionLeftBorder, R, cxRect(0, 9, 0, 2), rfspActiveCaptionLeftBorder);
  OffsetRect(R, 6, 0);
  AddTwoStateElement(ABitmap, FCaptionRightBorder, R, cxRect(0, 9, 0, 2), rfspActiveCaptionRightBorder);
  //active border
  R := cxRectBounds(15, 0, 8, 11);
  AddTwoStateElement(ABitmap, FLeftBorder, R, cxRect(0, 0, 0, 7), rfspActiveLeftBorder);
  OffsetRect(R, 8, 0);
  AddTwoStateElement(ABitmap, FRightBorder, R, cxRect(0, 0, 0, 7), rfspActiveRightBorder);
  //bottom border
  AddTwoStateElement(ABitmap, FBottomBorderThin,
    cxRectBounds(15, 23, 3, 1), cxEmptyRect, rfspActiveBottomBorder1);
  AddTwoStateElement(ABitmap, FBottomBorderThick[False],
    cxRectBounds(15, 30, 16, 8), cxRect(7, 0, 7, 0), rfspActiveBottomBorder2);
  AddTwoStateElement(ABitmap, FBottomBorderThick[True],
    cxRectBounds(15, 56, 16, 8), cxRect(7, 0, 7, 0), rfspActiveBottomBorder3);
end;

procedure TdxCustomRibbon2010Skin.LoadFormSkinFromBitmap(ABitmap: GpBitmap);
begin
  LoadFormBorders(ABitmap);
  LoadBorderIcons(ABitmap);
  //QuickAccessToolbar non-client
  FQATAtTopLeft[True][True] := AddPart3x3(ABitmap, cxRectBounds(89, 73, 5, 21), cxRect(3, 4, 0, 4), rspQATNonClientLeft1Active);
  FQATAtTopLeft[True][False] := FQATAtTopLeft[True][True];
  FQATAtTopLeft[False] := FQATAtTopLeft[True];
  FQATAtTopRight[True] := AddPart3x3(ABitmap, cxRectBounds(87, 73, 5, 21), cxRect(0, 4, 3, 4), rspQATNonClientRightActive);
  FQATAtTopRight[False] := FQATAtTopRight[True];

  FRibbonTopArea := AddPart3x3(ABitmap, cxRectBounds(6, 1, 2, 30), cxRect(0, 9, 0, 5), rspRibbonClientTopArea);
  LoadApplicationButton(ABitmap);
end;

procedure TdxCustomRibbon2010Skin.LoadMDIButtons(ABitmap: GpBitmap);
const
  OffsetMap: array[TdxBarMDIButton] of Integer = (0, 28, 70);
  PartIDMap: array[TdxBarMDIButton] of Integer =
    (rspMDIButtonMinimize, rspMDIButtonRestore, rspMDIButtonClose);
var
  AButton: TdxBarMDIButton;
begin
  for AButton := Low(AButton) to High(AButton) do
  begin
    LoadElementParts(ABitmap, FMDIButtonGlyphs[AButton],
      cxRectBounds(OffsetMap[AButton], 73, 13, 11), PartIDMap[AButton],
      cxNullRect, [0, 1, 2, 3], [0, 1, 2, 3], True, InterpolationModeNearestNeighbor);
  end;
end;

procedure TdxCustomRibbon2010Skin.LoadStatusBar(ABitmap: GpBitmap);
begin
  FStatusBar := AddPart1x3(ABitmap, cxRectBounds(198, 354, 3, 30), 2, 0, rspStatusBar);
  FStatusBarGripBackground := FStatusBar;
  FStatusBarPanelLowered := FStatusBar;
  FStatusBarPanelRaised := FStatusBar;
  FStatusBarPanel := FStatusBar;

  FStatusBarPanelSeparator := AddPart1x3(ABitmap,
    cxRectBounds(202, 354, 3, 30), 2, 0, rspStatusBarPanelSeparator);
  FStatusBarToolbarSeparator := AddPart1x3(ABitmap,
    cxRectBounds(206, 354, 3, 20), 2, 0, rspStatusBarToolbarSeparator);

  LoadElementParts(ABitmap, FFormStatusBarLeftParts[False], cxRectBounds(163, 354, 8, 22),
    rspStatusBarFormLeftPart, cxRect(0, 2, 0, 8), [0, 1, 2, 3], [0, 1, 2, 3]);
  LoadElementParts(ABitmap, FFormStatusBarRightParts[False], cxRectBounds(172, 354, 8, 22),
    rspStatusBarFormRightPart, cxRect(0, 2, 0, 8), [0, 1, 2, 3], [0, 1, 2, 3]);
  LoadElementParts(ABitmap, FFormStatusBarLeftParts[True], cxRectBounds(180, 354, 8, 22),
    rspStatusBarFormLeftPartDialog, cxRect(0, 2, 0, 8), [0, 1, 2, 3], [0, 1, 2, 3]);
  LoadElementParts(ABitmap, FFormStatusBarRightParts[True], cxRectBounds(189, 354, 8, 22),
    rspStatusBarFormRightPartDialog, cxRect(0, 2, 0, 8), [0, 1, 2, 3], [0, 1, 2, 3]);
end;

procedure TdxCustomRibbon2010Skin.LoadTab(ABitmap: GpBitmap);
begin
  LoadElementParts(ABitmap, FTabIndex, cxRectBounds(0, 0, 24, 23),
    rspTabNormal, cxRect(4, 4, 4, 4), [0, 1, 2, 3, 4], [0, 1, 2, 3, 4]);
  LoadElementParts(ABitmap, FContextTabIndex, cxRectBounds(163, 253, 36, 20),
    rspContextTabNormal, cxRect(5, 3, 5, 1), [0, 1, 2, 3, 4], [0, 1, 2, 3, 4]);
  LoadElementParts(ABitmap, FContextTabMaskIndex, cxRectBounds(199, 253, 36, 20),
    rspContextTabMaskNormal, cxRect(5, 3, 5, 1), [0, 1, 2, 3, 4], [0, 1, 2, 3, 4]);
  FTabSeparator := AddPart1x1(ABitmap, cxRectBounds(42, 86, 2, 16), rspTabSeparator);
  FTabsAreaOnGlass := AddPart3x3(ABitmap, cxRectBounds(163, 0, 95, 36),
    cxRect(42, 0, 42, 0), rspTabsAreaOnGlass, '', InterpolationModeHighQualityBicubic);
end;

{ TdxBlueRibbon2010Skin }

procedure TdxBlueRibbon2010Skin.DrawFormCaptionSeparator(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, $AD8E72);
end;

procedure TdxBlueRibbon2010Skin.DrawRibbonTopFrameAreaSeparator(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, $AD8E72);
end;

procedure TdxBlueRibbon2010Skin.DrawTabAreaBackground(
  DC: HDC; const R: TRect; AActive, AUseAeroGlass: Boolean);
const
  ColorMap: array[Boolean] of TColor = ($F7EBDF, $E8D0BD);
begin
  if LowColors then
    inherited DrawTabAreaBackground(DC, R, AActive, AUseAeroGlass)
  else
    if not AUseAeroGlass then
      FillRectByColor(DC, R, ColorMap[AActive]);
end;

procedure TdxBlueRibbon2010Skin.GetApplicationMenuContentColors(
  var AInnerBorderColor, AOuterBorderColor, ASideColor: TColor);
begin
  AInnerBorderColor := clNone;
  AOuterBorderColor := $B9AFA8;
  ASideColor := clNone;
end;

function TdxBlueRibbon2010Skin.GetDisplayName: string;
begin
  Result := 'Blue';
end;

function TdxBlueRibbon2010Skin.GetPartColor(APart: Integer; AState: Integer = 0): TColor;
begin
  Result := inherited GetPartColor(APart, AState);
  if LowColors then Exit;

  case APart of
    DXBAR_INRIBBONGALLERY_BACKGROUND:
      case AState of
        DXBAR_ACTIVE, DXBAR_HOT:
          Result := $FCF7F2
        else
          Result := $FDF5ED;
      end;
    DXBAR_EDIT_BORDER:
      case AState of
        DXBAR_NORMAL: Result := $D6C0B1;
        DXBAR_FOCUSED, DXBAR_DROPPEDDOWN, DXBAR_HOT,
        DXBAR_ACTIVE, DXBAR_ACTIVEDISABLED: Result := $D0BAAB;
        DXBAR_DISABLED: Result := $DEDDCD;
      end;
    DXBAR_EDIT_BACKGROUND:
      case AState of
        DXBAR_NORMAL: Result := $FDF5ED;
        DXBAR_FOCUSED, DXBAR_DROPPEDDOWN, DXBAR_HOT,
        DXBAR_ACTIVE, DXBAR_ACTIVEDISABLED: Result := $FCF7F2;
        DXBAR_DISABLED: Result := $FDF5ED;
      end;
    DXBAR_SCREENTIP_FOOTERLINE:
      Result := $DDBB9E;
    rspStatusBarSizeGripColor1:
      Result := $BD9D84;
    rspStatusBarSizeGripColor2:
      Result := $F1E1D4;
    rspRibbonBackground, rfspRibbonForm:
      Result := $E4CCB7;
    rspFormCaptionText, rspDocumentNameText:
      if AState <> DXBAR_NORMAL then
        Result := $A36736;
  end;
end;

procedure TdxBlueRibbon2010Skin.LoadCustomRibbonSkinBitmap(out ABitmap: GpBitmap);
begin
  LoadBitmapFromStream('RIBBONBLUE2010', ABitmap);
end;

procedure TdxBlueRibbon2010Skin.LoadFormSkinBitmap(out ABitmap: GpBitmap);
begin
  LoadBitmapFromStream('FORMBLUE2010', ABitmap);
end;

{ TdxSilverRibbon2010Skin }

procedure TdxSilverRibbon2010Skin.DrawFormCaptionSeparator(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, $928C87);
end;

procedure TdxSilverRibbon2010Skin.DrawRibbonTopFrameAreaSeparator(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, $928C87);
end;

procedure TdxSilverRibbon2010Skin.DrawTabAreaBackground(
  DC: HDC; const R: TRect; AActive, AUseAeroGlass: Boolean);
const
  ColorMap: array[Boolean] of TColor = ($FCFCFC, $E8E6E3);
begin
  if LowColors then
    inherited DrawTabAreaBackground(DC, R, AActive, AUseAeroGlass)
  else
    if not AUseAeroGlass then
      FillRectByColor(DC, R, ColorMap[AActive]);
end;

procedure TdxSilverRibbon2010Skin.GetApplicationMenuContentColors(
  var AInnerBorderColor, AOuterBorderColor, ASideColor: TColor);
begin
  AInnerBorderColor := clNone;
  AOuterBorderColor := $C6C3C0;
  ASideColor := clNone;
end;

function TdxSilverRibbon2010Skin.GetDisplayName: string;
begin
  Result := 'Silver';
end;

function TdxSilverRibbon2010Skin.GetPartColor(APart: Integer; AState: Integer = 0): TColor;
begin
  Result := inherited GetPartColor(APart, AState);
  if LowColors then Exit;

  case APart of
    DXBAR_GALLERYFILTERBANDTEXT:
      if AState = DXBAR_HOT then
        Result := $32D2FF
      else
        Result := $FFFFFF;
    DXBAR_INRIBBONGALLERY_BACKGROUND:
      Result := $FFFFFF;
    DXBAR_EDIT_BORDER:
      case AState of
        DXBAR_NORMAL: Result := $D9D6D4;
        DXBAR_FOCUSED, DXBAR_DROPPEDDOWN, DXBAR_HOT,
        DXBAR_ACTIVE, DXBAR_ACTIVEDISABLED: Result := $C4BFBB;
        DXBAR_DISABLED: Result := $EBE7E4;
      end;
    DXBAR_EDIT_BACKGROUND:
      case AState of
        DXBAR_NORMAL, DXBAR_FOCUSED, DXBAR_DROPPEDDOWN, DXBAR_HOT,
        DXBAR_ACTIVE, DXBAR_ACTIVEDISABLED: Result := $FFFFFF;
        DXBAR_DISABLED: Result := $FAFAFA;
      end;
    DXBAR_SCREENTIP_FOOTERLINE:
      Result := $BDBDBD;
    rspContextText:
      Result := clGray;
    rspContextTextShadow:
      Result := clWhite;
    rspStatusBarSizeGripColor1:
      Result := $C7BEB5;
    rspStatusBarSizeGripColor2:
      Result := $FFFFFF;
    rspRibbonBackground, rfspRibbonForm:
      Result := $F1EDE9;
    rspFormCaptionText, rspDocumentNameText:
      if AState <> DXBAR_NORMAL then
        Result := $8A8A8A;
  end;
end;

procedure TdxSilverRibbon2010Skin.LoadCustomRibbonSkinBitmap(out ABitmap: GpBitmap);
begin
  LoadBitmapFromStream('RIBBONSILVER2010', ABitmap);
end;

procedure TdxSilverRibbon2010Skin.LoadFormSkinBitmap(out ABitmap: GpBitmap);
begin
  LoadBitmapFromStream('FORMSILVER2010', ABitmap);
end;

{ TdxBlackRibbon2010Skin }

procedure TdxBlackRibbon2010Skin.DrawFormCaptionSeparator(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, $484848);
end;

procedure TdxBlackRibbon2010Skin.DrawMenuExtraSeparator(
  DC: HDC; const R: TRect; AHorizontal: Boolean);
begin
  InternalDrawSeparator(DC, R, AHorizontal, $CECECE, $ABABAB);
end;

procedure TdxBlackRibbon2010Skin.DrawRibbonTopFrameAreaSeparator(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, $484848);
end;

procedure TdxBlackRibbon2010Skin.DrawTabAreaBackground(
  DC: HDC; const R: TRect; AActive, AUseAeroGlass: Boolean);
const
  ColorMap: array[Boolean] of TColor = ($9E9E9E, $717171);
begin
  if LowColors then
    inherited DrawTabAreaBackground(DC, R, AActive, AUseAeroGlass)
  else
    if not AUseAeroGlass then
      FillRectByColor(DC, R, ColorMap[AActive]);
end;

procedure TdxBlackRibbon2010Skin.GetApplicationMenuContentColors(
  var AInnerBorderColor, AOuterBorderColor, ASideColor: TColor);
begin
  AInnerBorderColor := clNone;
  AOuterBorderColor := $ABABAB;
  ASideColor := clNone;
end;

function TdxBlackRibbon2010Skin.GetDisplayName: string;
begin
  Result := 'Black';
end;

function TdxBlackRibbon2010Skin.GetPartColor(APart: Integer; AState: Integer = 0): TColor;
begin
  Result := inherited GetPartColor(APart, AState);
  if LowColors then Exit;

  case APart of
    DXBAR_INRIBBONGALLERY_BACKGROUND:
      case AState of
        DXBAR_ACTIVE, DXBAR_HOT:
          Result := $C1C1C1
        else
          Result := $BBBBBB;
      end;

    DXBAR_GALLERYFILTERBANDTEXT:
      if AState = DXBAR_HOT then
        Result := $32D2FF
      else
        Result := $FFFFFF;

    DXBAR_EDIT_BORDER:
      case AState of
        DXBAR_NORMAL, DXBAR_FOCUSED, DXBAR_DROPPEDDOWN, DXBAR_HOT,
        DXBAR_ACTIVE, DXBAR_ACTIVEDISABLED: Result := $848484;
        DXBAR_DISABLED: Result := $A0A0A0;
      end;

    DXBAR_EDIT_BACKGROUND:
      case AState of
        DXBAR_NORMAL: Result := $C6C6C6;
        DXBAR_FOCUSED, DXBAR_DROPPEDDOWN, DXBAR_HOT,
        DXBAR_ACTIVE, DXBAR_ACTIVEDISABLED: Result := $CCCCCC;
        DXBAR_DISABLED: Result := $B6B6B6;
      end;

    rspTabHeaderText, rspContextTabHeaderText:
      case AState of
        DXBAR_ACTIVE:
          Result := clBlack;
        DXBAR_HOT:
          Result := $F0F0F0;
        else
          Result := $E2E2E2;
      end;

    rspStatusBarText:
      if AState in [DXBAR_HOT, DXBAR_CHECKED] then
        Result := clBlack
      else
        Result := $E2E2E2;

    rbvpBackstageViewMenuItem:
      case AState of
        DXBAR_DISABLED, DXBAR_ACTIVEDISABLED:
          Result := $A7A7A7;
        else
          Result := clWhite;
      end;

    rbvpBackstageViewMenuTabButton:
      case AState of
        DXBAR_DISABLED, DXBAR_ACTIVEDISABLED:
          Result := $A7A7A7;
        else
          Result := clWhite;
      end;

   DXBAR_SCREENTIP_FOOTERLINE:
      Result := $BDBDBD;
    rspStatusBarSizeGripColor1:
      Result := $1B1B1B;
    rspStatusBarSizeGripColor2:
      Result := $595959;
    rspRibbonBackground, rfspRibbonForm:
      Result := $8B8B8B;
    rspFormCaptionText, rspDocumentNameText:
      if AState <> DXBAR_NORMAL then
        Result := $D4D4D4
      else
        Result := $E2E2E2;
  end;
end;

procedure TdxBlackRibbon2010Skin.LoadCustomRibbonSkinBitmap(out ABitmap: GpBitmap);
begin
  LoadBitmapFromStream('RIBBONBLACK2010', ABitmap);
end;

procedure TdxBlackRibbon2010Skin.LoadFormSkinBitmap(out ABitmap: GpBitmap);
begin
  LoadBitmapFromStream('FORMBLACK2010', ABitmap);
end;
//

procedure CreateSkins;
begin
  if not CheckGdiPlus then Exit;
  SkinManager.AddSkin(TdxBlueRibbonSkin.Create);
  SkinManager.AddSkin(TdxBlackRibbonSkin.Create);
  SkinManager.AddSkin(TdxSilverRibbonSkin.Create);
  SkinManager.AddSkin(TdxBlueRibbon2010Skin.Create);
  SkinManager.AddSkin(TdxSilverRibbon2010Skin.Create);
  SkinManager.AddSkin(TdxBlackRibbon2010Skin.Create);
end;

procedure DestroySkins;
var
  I: Integer;
begin
  for I := SkinManager.SkinCount - 1 downto 0 do
    if SkinManager[I] is TdxCustomRibbonSkin then
      SkinManager.RemoveSkin(SkinManager[I]);
end;

initialization
  dxUnitsLoader.AddUnit(@CreateSkins, @DestroySkins);

finalization
  dxUnitsLoader.RemoveUnit(@DestroySkins);

end.
