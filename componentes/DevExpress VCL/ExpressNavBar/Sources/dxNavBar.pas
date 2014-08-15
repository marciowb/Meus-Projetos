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

unit dxNavBar;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Types, 
{$ENDIF}
  Classes, IniFiles, Registry, Windows, Messages, Graphics, Controls, Forms, ImgList, StdCtrls, ExtCtrls, 
  cxScrollBar, cxClasses, cxControls, dxThemeManager, cxLookAndFeels, cxLibraryConsts,
  dxNavBarBase, dxNavBarCollns, dxNavBarStyles;

type
  TdxCustomNavBar = class;
  TdxNavBarViewInfo = class;
  TdxNavBarGroupViewInfo = class;
  TdxNavBarPainter = class;

  TdxNavBarObjectState = (sActive, sDisabled, sExpanded, sHotTracked, sPressed, sSelected, sSpecial);
  TdxNavBarObjectStates = set of TdxNavBarObjectState;

  TdxNavBarLinkViewInfo = class
  private
    FGroupViewInfo: TdxNavBarGroupViewInfo;
    FNavBar: TdxCustomNavBar;
    FPainter: TdxNavBarPainter;
    FViewInfo: TdxNavBarViewInfo;
    FLink: TdxNavBarItemLink;
    FItem: TdxNavBarItem;
    FFont: TFont;

    function GetState: TdxNavBarObjectStates;
  protected
    FRect: TRect;
    FImageRect: TRect;
    FImageVisible: Boolean;
    FCaptionRect: TRect;
    FCaptionVisible: Boolean;
  public
    constructor Create(AGroupViewInfo: TdxNavBarGroupViewInfo; ALink: TdxNavBarItemLink; ACaptionVisible, AImageVisisble: Boolean);
    destructor Destroy; override;

    procedure CalculateBounds(X, Y: Integer); virtual;
    procedure CorrectBounds(dX, dY: Integer); virtual;

    function GetCaptionHeight: Integer; virtual;
    function GetDrawEdgeFlag: Integer; virtual;
    function GetImageHeight: Integer; virtual;
    function GetImageWidth: Integer; virtual;
    function IsCaptionVisible: Boolean;
    function IsImageVisible: Boolean;

    // Style attributes
    function StyleItem: TdxNavBarStyleItem; virtual;
    function Style: TdxBaseNavBarStyle; virtual;
    function Font: TFont; virtual;
    function FontColor: TColor; virtual;
    function ImageIndex: Integer; virtual;
    function ImageList: TCustomImageList; virtual;
    // Rectangles
    function IsWholeVisible: Boolean;
    function SelectionRect: TRect; virtual;
    property Rect: TRect read FRect;
    property CaptionRect: TRect read FCaptionRect;
    property ImageRect: TRect read FImageRect;

    property Link: TdxNavBarItemLink read FLink;
    property Item: TdxNavBarItem read FItem;
    property GroupViewInfo: TdxNavBarGroupViewInfo read FGroupViewInfo;
    property NavBar: TdxCustomNavBar read FNavBar;
    property Painter: TdxNavBarPainter read FPainter;
    property State: TdxNavBarObjectStates read GetState;
    property ViewInfo: TdxNavBarViewInfo read FViewInfo;
  end;
  TdxNavBarLinkViewInfoClass = class of TdxNavBarLinkViewInfo;

  TdxNavBarGroupViewInfo = class
  private
    FViewInfo: TdxNavBarViewInfo;
    FItems: TList;
    FGroup: TdxNavBarGroup;
    FNavBar: TdxCustomNavBar;
    FPainter: TdxNavBarPainter;
    FCaptionVisible: Boolean;
    FItemsVisible: Boolean;

    function GetControl: TdxNavBarGroupControl;
    function GetControlBackColor: TColor;
    function GetControlBackColor2: TColor;
    function GetControlRect: TRect;
    function GetItemCount: Integer;
    function GetItem(Index: Integer): TdxNavBarLinkViewInfo;
    function GetState: TdxNavBarObjectStates;
    function IsDefaultControlStyle: Boolean;
  protected
    FCaptionFont: TFont;
    FCaptionRect: TRect;
    FCaptionImageRect: TRect;
    FCaptionSignRect: TRect;
    FCaptionTextRect: TRect;
    FItemsRect: TRect;
    FRect: TRect;

    procedure AddLink(AViewInfo: TdxNavBarViewInfo; ALink: TdxNavBarItemLink; ACaptionVisible, AImageVisisble: Boolean);
    procedure ClearItems;

    procedure AdjustControlBounds; virtual;
  public
    constructor Create(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup; ACaptionVisible, AItemsVisible: Boolean);
    destructor Destroy; override;
    // Calculation
    procedure CreateInfo; virtual;
    procedure CalculateBounds(X, Y: Integer); virtual;
    procedure CorrectBounds(dX, dY: Integer); virtual;
    procedure CorrectActiveGroupBounds(dX, dY: Integer); virtual;

    function GetLinkViewInfoByLink(ALink: TdxNavBarItemLink): TdxNavBarLinkViewInfo;
    function IndexOfLinkViewInfo(AViewInfo: TdxNavBarLinkViewInfo): Integer;

    function GetCaptionHeight: Integer; virtual;
    function GetDrawEdgeFlag: Integer; virtual;
    function GetImageHeight: Integer; virtual;
    function GetImageWidth: Integer; virtual;
    function IsCaptionVisible: Boolean;
    function IsCaptionImageVisible: Boolean;
    function IsCaptionSignVisible: Boolean;
    function IsCaptionUseSmallImages: Boolean;
    function IsItemsVisible: Boolean;
    function IsLinksUseSmallImages: Boolean;
    function IsViewAsIconView: Boolean;
    // Styles attributes
    function BorderColor: TColor; virtual;
    function BgImage: TPicture; virtual;
    function BgBackColor: TColor; virtual;
    function BgBackColor2: TColor; virtual;
    function BgAlphaBlend: Byte; virtual;
    function BgAlphaBlend2: Byte; virtual;
    function BgGradientMode: TdxBarStyleGradientMode; virtual;
    function CaptionStyleItem: TdxNavBarStyleItem; virtual;
    function CaptionStyle: TdxBaseNavBarStyle; virtual;
    function CaptionImage: TPicture; virtual;
    function CaptionBorderColor: TColor; virtual;
    function CaptionBackColor: TColor; virtual;
    function CaptionBackColor2: TColor; virtual;
    function CaptionAlphaBlend: Byte; virtual;
    function CaptionAlphaBlend2: Byte; virtual;
    function CaptionGradientMode: TdxBarStyleGradientMode; virtual;
    function CaptionFont: TFont; virtual;
    function CaptionFontColor: TColor; virtual;
    function CaptionSignColor: TColor; virtual;
    function CaptionHAlignment: TdxBarStyleHAlignment; virtual;
    function CaptionVAlignment: TdxBarStyleVAlignment; virtual;
    function ControlImage: TPicture; virtual;
    function ControlBackColor: TColor; virtual;
    function ControlBackColor2: TColor; virtual;
    function ControlAlphaBlend: Byte; virtual;
    function ControlAlphaBlend2: Byte; virtual;
    function ControlGradientMode: TdxBarStyleGradientMode; virtual;
    function ImageIndex: Integer; virtual;
    function ImageList: TCustomImageList; virtual;
    // Rectangles
    property CaptionRect: TRect read FCaptionRect;
    property CaptionImageRect: TRect read FCaptionImageRect;
    property CaptionSignRect: TRect read FCaptionSignRect;
    property CaptionTextRect: TRect read FCaptionTextRect;
    property ControlRect: TRect read GetControlRect;
    property ItemsRect: TRect read FItemsRect;
    property Rect: TRect read FRect;

    property Control: TdxNavBarGroupControl read GetControl;
    property ItemCount: Integer read GetItemCount;
    property Items[Index: Integer]: TdxNavBarLinkViewInfo read GetItem;
    property Group: TdxNavBarGroup read FGroup;
    property NavBar: TdxCustomNavBar read FNavBar;
    property Painter: TdxNavBarPainter read FPainter;
    property State: TdxNavBarObjectStates read GetState;
    property ViewInfo: TdxNavBarViewInfo read FViewInfo;
  end;
  TdxNavBarGroupViewInfoClass = class of TdxNavBarGroupViewInfo;

  TdxNavBarViewInfo = class
  private
    FPainter: TdxNavBarPainter;
    FNavBar: TdxCustomNavBar;
    FGroups: TList;
    FHeaderFont: TFont;
    FTopScrollButtonRect: TRect;
    FBottomScrollButtonRect: TRect;
    FHintRect: TRect;
    FHintText: string;

    function GetGroupCount: Integer;
    function GetGroup(Index: Integer): TdxNavBarGroupViewInfo;
    function GetBottomScrollButtonState: TdxNavBarObjectStates;
    function GetTopScrollButtonState: TdxNavBarObjectStates;
  protected
    // Colors
    procedure CreateColors; virtual;
    procedure RefreshColors; virtual;
    procedure ReleaseColors; virtual;

    function ClientHeight: Integer;
    function ClientWidth: Integer;
    function GetSpaceBetweenGroups: Integer;
    function GetLargeImageHeight: Integer;
    function GetLargeImageWidth: Integer;
    function GetSmallImageHeight: Integer;
    function GetSmallImageWidth: Integer;

    class function GetGroupBorderWidth: Integer; virtual;
    class function GetGroupCaptionHeightAddon: Integer; virtual;
    class function GetGroupCaptionTextIndent: Integer; virtual;
    class function GetGroupCaptionImageIndent: Integer; virtual;
    class function GetGroupSeparatorWidth: Integer; virtual;
    class function GetGroupCaptionSignSize: Integer; virtual;
    class function GetGroupHorizontalEdge: Integer; virtual;
    class function GetGroupCaptionSeparatorWidth: Integer; virtual;
    class function GetLinksLargeSeparatorWidth: Integer; virtual;
    class function GetLinksSmallSeparatorWidth: Integer; virtual;
    class function GetLinksIconViewSeparatorWidth: Integer; virtual;
    class function GetLinksImageVerticalEdge: Integer; virtual;
    class function GetLinksImageHorizontalEdge: Integer; virtual;
    class function GetDragArrowHeight: Integer; virtual;
    class function GetDragArrowWidth: Integer; virtual;
    class function GetHeaderHeightAddon: Integer; virtual;
    class function GetScrollButtonVerticalEdge: Integer; virtual;
    class function GetScrollButtonHorizontalEdge: Integer; virtual;
    class function GetScrollButtonVerticalSize: Integer; virtual;
    class function GetScrollButtonHorizontalSize: Integer; virtual;

    function CanHasActiveGroup: Boolean; virtual;
    function CanHasSpecialGroup: Boolean; virtual;
    function CanHasScrollButtonInGroupCaption: Boolean; virtual;
    function CanHasImageInGroupCaption: Boolean; virtual;
    function CanHasSignInGroupCaption: Boolean; virtual;
    function CanHasGroupViewAsIconView: Boolean; virtual;
    function CanHasGroupWithNoCaption: Boolean; virtual;
    function CanHasVisibleItemsInGroup(AGroup: TdxNavBarGroup): Boolean; virtual;
    function CanGroupCaptionBoundsByImage: Boolean; virtual;
    function CanGroupsUseLargeImages: Boolean; virtual;
    function CanLinksUseLargeImages: Boolean; virtual;
    function CanSelectLinkByRect: Boolean; virtual;

    procedure AddGroup(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup; ACaptionVisible, AItemsVisible: Boolean);
    procedure RemoveGroup(AGroupViewInfo: TdxNavBarGroupViewInfo);
    procedure ClearGroups;

    procedure AdjustControlsBounds; virtual;
    function GetBoundsUpdateType: TdxNavBarChangeType; virtual;
    function GetTopScrollButtonRect: TRect; virtual;
    function GetBottomScrollButtonRect: TRect; virtual;
    procedure RecalculateHint; virtual;
    function GetHintRect: TRect; virtual;
    function GetHintText: string; virtual;
    function GetGroupHintRect(AGroup: TdxNavBarGroup): TRect; virtual;
    function GetGroupHintText(AGroup: TdxNavBarGroup): string; virtual;
    function GetLinkHintRect(ALink: TdxNavBarItemLink): TRect; virtual;
    function GetLinkHintText(ALink: TdxNavBarItemLink): string; virtual;

    function IsGroupActive(AGroup: TdxNavBarGroup): Boolean; virtual;
    procedure DoGroupActiveToggle(AGroup: TdxNavBarGroup); virtual;
    procedure DoGroupActivate(AGroup: TdxNavBarGroup); virtual;
    procedure DoGroupDeactivate(AGroup: TdxNavBarGroup); virtual;
    procedure DoShowPopupMenu(X, Y: Integer); virtual;
    procedure MakeLinkVisible(ALink: TdxNavBarItemLink); virtual;
    procedure MakeGroupVisible(AGroup: TdxNavBarGroup); virtual;
  public
    constructor Create(APainter: TdxNavBarPainter); virtual;
    destructor Destroy; override;
    // Calculation
    procedure CreateInfo; virtual;
    procedure CalculateBounds; virtual;
    procedure CalculateScrollButtonsBounds; virtual;
    procedure ClearRects; virtual;
    // Styles attributes
    function BgImage: TPicture; virtual;
    function BgBackColor: TColor; virtual;
    function BgBackColor2: TColor; virtual;
    function BgAlphaBlend: Byte; virtual;
    function BgAlphaBlend2: Byte; virtual;
    function BgGradientMode: TdxBarStyleGradientMode; virtual;
    function BorderColor: TColor; virtual;
    function BottomScrollButtonStyleItem: TdxNavBarStyleItem; virtual;
    function BottomScrollButtonStyle: TdxBaseNavBarStyle; virtual;
    function BottomScrollButtonImage: TPicture; virtual;
    function BottomScrollButtonBackColor: TColor; virtual;
    function BottomScrollButtonBackColor2: TColor; virtual;
    function BottomScrollButtonAlphaBlend: Byte; virtual;
    function BottomScrollButtonAlphaBlend2: Byte; virtual;
    function BottomScrollButtonGradientMode: TdxBarStyleGradientMode; virtual;
    function TopScrollButtonStyleItem: TdxNavBarStyleItem; virtual;
    function TopScrollButtonStyle: TdxBaseNavBarStyle; virtual;
    function TopScrollButtonImage: TPicture; virtual;
    function TopScrollButtonBackColor: TColor; virtual;
    function TopScrollButtonBackColor2: TColor; virtual;
    function TopScrollButtonAlphaBlend: Byte; virtual;
    function TopScrollButtonAlphaBlend2: Byte; virtual;
    function TopScrollButtonGradientMode: TdxBarStyleGradientMode; virtual;
    function HintImage: TPicture; virtual;
    function HintBackColor: TColor; virtual;
    function HintBackColor2: TColor; virtual;
    function HintAlphaBlend: Byte; virtual;
    function HintAlphaBlend2: Byte; virtual;
    function HintGradientMode: TdxBarStyleGradientMode; virtual;
    function HintFont: TFont; virtual;
    function DragDropItemTargetBackColor: TColor; virtual;
    function DragDropGroupTargetBackColor: TColor; virtual;
    function DragDropGroupTargetBackColor2: TColor; virtual;
    function DragDropGroupTargetAlphaBlend: Byte; virtual;
    function DragDropGroupTargetAlphaBlend2: Byte; virtual;
    function DragDropGroupTargetGradient: TdxBarStyleGradientMode; virtual;
    function HeaderImage: TPicture; virtual;
    function HeaderBackColor: TColor; virtual;
    function HeaderBackColor2: TColor; virtual;
    function HeaderAlphaBlend: Byte; virtual;
    function HeaderAlphaBlend2: Byte; virtual;
    function HeaderGradientMode: TdxBarStyleGradientMode; virtual;
    function HeaderFont: TFont; virtual;
    function HeaderFontColor: TColor; virtual;
    function HeaderHAlignment: TdxBarStyleHAlignment; virtual;
    function HeaderVAlignment: TdxBarStyleVAlignment; virtual;
    function HeaderDrawEdgeFlag: Integer;
    function OverflowPanelImage: TPicture; virtual;
    function OverflowPanelBackColor: TColor; virtual;
    function OverflowPanelBackColor2: TColor; virtual;
    function OverflowPanelAlphaBlend: Byte; virtual;
    function OverflowPanelAlphaBlend2: Byte; virtual;
    function OverflowPanelGradientMode: TdxBarStyleGradientMode; virtual;
    function OverflowPanelFont: TFont; virtual;
    function OverflowPanelFontColor: TColor; virtual;
    function SplitterBackColor: TColor; virtual;
    function SplitterBackColor2: TColor; virtual;
    function SplitterAlphaBlend: Byte; virtual;
    function SplitterAlphaBlend2: Byte; virtual;
    function SplitterGradientMode: TdxBarStyleGradientMode; virtual;
    // Default styles
    procedure AssignDefaultBackgroundStyle; virtual;
    procedure AssignDefaultButtonStyle; virtual;
    procedure AssignDefaultButtonPressedStyle; virtual;
    procedure AssignDefaultButtonHotTrackedStyle; virtual;
    procedure AssignDefaultGroupControlStyle; virtual;
    procedure AssignDefaultGroupBackgroundStyle; virtual;
    procedure AssignDefaultGroupHeaderStyle; virtual;
    procedure AssignDefaultGroupHeaderActiveStyle; virtual;
    procedure AssignDefaultGroupHeaderActiveHotTrackedStyle; virtual;
    procedure AssignDefaultGroupHeaderActivePressedStyle; virtual;
    procedure AssignDefaultGroupHeaderHotTrackedStyle; virtual;
    procedure AssignDefaultGroupHeaderPressedStyle; virtual;
    procedure AssignDefaultHintStyle; virtual;
    procedure AssignDefaultItemStyle; virtual;
    procedure AssignDefaultItemDisabledStyle; virtual;
    procedure AssignDefaultItemHotTrackedStyle; virtual;
    procedure AssignDefaultItemPressedStyle; virtual;
    procedure AssignDefaultDropTargetGroupStyle; virtual;
    procedure AssignDefaultDropTargetLinkStyle; virtual;
    procedure AssignDefaultNavigationPaneHeaderStyle; virtual;
    // Groups
    function ActiveGroupViewInfo: TdxNavBarGroupViewInfo; 
    function GetGroupViewInfoByGroup(AGroup: TdxNavBarGroup): TdxNavBarGroupViewInfo;
    function GetLinkViewInfoByLink(ALink: TdxNavBarItemLink): TdxNavBarLinkViewInfo;
    function IndexOfGroupViewInfo(AViewInfo: TdxNavBarGroupViewInfo): Integer;
    // Hit tests
    function GetGroupViewInfoAtCaptionPos(pt: TPoint): TdxNavBarGroupViewInfo; virtual;
    function GetGroupAtCaptionPos(pt: TPoint): TdxNavBarGroup;
    function GetGroupViewInfoAtItemsPos(pt: TPoint): TdxNavBarGroupViewInfo; virtual;
    function GetGroupAtItemsPos(pt: TPoint): TdxNavBarGroup;
    function GetLinkViewInfoAtPos(pt: TPoint): TdxNavBarLinkViewInfo; virtual;
    function GetLinkAtPos(pt: TPoint): TdxNavBarItemLink;
    function GetLinkViewInfoAtSelectedPos(pt: TPoint): TdxNavBarLinkViewInfo; virtual;
    function GetLinkAtSelectedPos(pt: TPoint): TdxNavBarItemLink;
    function GetViewInfoAtDragPosition(pt: TPoint; var ItemGroup: TdxNavBarGroupViewInfo;
        var Item1, Item2: TdxNavBarLinkViewInfo): Integer; virtual;
    function GetViewInfoAtDragPositionWhenIconView(pt: TPoint; var ItemGroup: TdxNavBarGroupViewInfo;
        var Item1, Item2: TdxNavBarLinkViewInfo): Integer; virtual;
    function GetLinksAtDragPosition(pt: TPoint; var ItemGroup: TdxNavBarGroup;
        var Item1, Item2: TdxNavBarItemLink): Integer;
    function IsPtNavigationPaneHeader(pt: TPoint): Boolean; virtual;
    function IsPtNavigationPaneSplitter(pt: TPoint): Boolean; virtual;
    function IsPtNavigationPaneOverflowPanel(pt: TPoint): Boolean; virtual;
    function IsPtIncNavigationPaneOverflowPanelItemCount(pt: TPoint): Boolean; virtual;
    function IsPtDecNavigationPaneOverflowPanelItemCount(pt: TPoint): Boolean; virtual;
    function IsPtNavigationPaneOverflowPanelSign(pt: TPoint): Boolean; virtual;
    function GetNavigationPaneOverflowPanelItemIndexAtPos(pt: TPoint): Integer; virtual;
    function GetNavigationPaneOverflowPanelGroupAtPos(pt: TPoint): TdxNavBarGroup; virtual;
    // Scroll buttons
    function IsTopScrollButtonVisible: Boolean;
    function IsBottomScrollButtonVisible: Boolean;
    function IsPtTopScrollButton(pt: TPoint): Boolean;
    function IsPtBottomScrollButton(pt: TPoint): Boolean;
    property TopScrollButtonRect: TRect read FTopScrollButtonRect;
    property BottomScrollButtonRect: TRect read FBottomScrollButtonRect;
    property TopScrollButtonState: TdxNavBarObjectStates read GetTopScrollButtonState;
    property BottomScrollButtonState: TdxNavBarObjectStates read GetBottomScrollButtonState;
    // Hint
    function HintDelay: Integer; virtual;
    property HintRect: TRect read FHintRect;
    property HintText: string read FHintText;

    property GroupCount: Integer read GetGroupCount;
    property Groups[Index: Integer]: TdxNavBarGroupViewInfo read GetGroup;
    property NavBar: TdxCustomNavBar read FNavBar;
    property Painter: TdxNavBarPainter read FPainter;
  end;
  TdxNavBarViewInfoClass = class of TdxNavBarViewInfo;

  TdxBaseImagePainter = class
  protected
    class procedure InternalDrawImage(ACanvas: TCanvas; AImageList: TCustomImageList;
        AImageIndex: Integer; ARect: TRect; AEnabled: Boolean); virtual;
  public
    class procedure DrawImage(ACanvas: TCanvas; AImageList: TCustomImageList;
        AImageIndex: Integer; ARect: TRect; AEnabled: Boolean = True);
    class function IsValidImage(AImageList: TCustomImageList;AImageIndex: Integer): Boolean;
  end;
  TdxBaseImagePainterClass = class of TdxBaseImagePainter;

  TdxBaseSelectionPainter = class
  protected
    class procedure InternalDrawSelection(ACanvas: TCanvas; ARect: TRect;
        ABackColor: TColor; AState: TdxNavBarObjectStates); virtual;
  public
    class procedure DrawSelection(ACanvas: TCanvas; ARect: TRect;
        ABackColor: TColor; AState: TdxNavBarObjectStates);
  end;
  TdxBaseSelectionPainterClass = class of TdxBaseSelectionPainter;

  TdxBaseBackgroundPainter = class
  protected
    class procedure InternalDrawBackground(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AEraseBackground: Boolean; ABackgroundColor: TColor;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode); virtual;
  public
    class procedure DrawBackground(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AEraseBackground: Boolean; ABackgroundColor: TColor;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode);
  end;
  TdxBaseBackgroundPainterClass = class of TdxBaseBackgroundPainter;

  TdxBaseGroupBackgroundPainter = class
  protected
    class procedure InternalDrawBackground(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode); virtual;
  public
    class procedure DrawBackground(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode);
  end;
  TdxBaseGroupBackgroundPainterClass = class of TdxBaseGroupBackgroundPainter;

  TdxBaseGroupBorderPainter = class
  protected
    class procedure InternalDrawBorder(ACanvas: TCanvas; ARect: TRect; AColor: TColor; AWithCaption: Boolean); virtual;
  public
    class procedure DrawBorder(ACanvas: TCanvas; ARect: TRect; AColor: TColor; AWithCaption: Boolean);
  end;
  TdxBaseGroupBorderPainterClass = class of TdxBaseGroupBorderPainter;

  TdxBaseSignPainter = class
  protected
    class procedure InternalDrawSign(ACanvas: TCanvas; ARect: TRect;
        AForeColor, ABackColor1, ABackColor2: TColor; AState: TdxNavBarObjectStates); virtual;
  public
    class procedure DrawSign(ACanvas: TCanvas; ARect: TRect;
        AForeColor, ABackColor1, ABackColor2: TColor; AState: TdxNavBarObjectStates);
  end;
  TdxBaseSignPainterClass = class of TdxBaseSignPainter;

  TdxBaseHintPainter = class
  protected
    class procedure InternalDrawHint(ACanvas: TCanvas; ARect: TRect; AHint: string;
        APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode; AFont: TFont); virtual;
  public
    class procedure DrawHint(ACanvas: TCanvas; ARect: TRect; AHint: string;
        APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode; AFont: TFont);
  end;
  TdxBaseHintPainterClass = class of TdxBaseHintPainter;

  TdxBaseButtonPainter = class
  protected
    class procedure InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
        AState: TdxNavBarObjectStates); virtual;
  public
    class procedure DrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
        AState: TdxNavBarObjectStates);
  end;
  TdxBaseButtonPainterClass = class of TdxBaseButtonPainter;

  TdxBaseScrollButtonsPainter = class
  protected
    class procedure InternalDrawBottomButton(ACanvas: TCanvas; ARect: TRect;
        AButtonPainterClass: TdxBaseButtonPainterClass; AColor1, AColor2: TColor;
        AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
        ABorderColor: TColor; AState: TdxNavBarObjectStates); virtual;
    class procedure InternalDrawTopButton(ACanvas: TCanvas; ARect: TRect;
        AButtonPainterClass: TdxBaseButtonPainterClass; AColor1, AColor2: TColor;
        AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
        ABorderColor: TColor; AState: TdxNavBarObjectStates); virtual;
  public
    class procedure DrawBottomButton(ACanvas: TCanvas; ARect: TRect;
        AButtonPainterClass: TdxBaseButtonPainterClass; AColor1, AColor2: TColor;
        AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
        ABorderColor: TColor; AState: TdxNavBarObjectStates);
    class procedure DrawTopButton(ACanvas: TCanvas; ARect: TRect;
        AButtonPainterClass: TdxBaseButtonPainterClass; AColor1, AColor2: TColor;
        AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
        ABorderColor: TColor; AState: TdxNavBarObjectStates);
  end;
  TdxBaseScrollButtonsPainterClass = class of TdxBaseScrollButtonsPainter;

  TdxBaseDropTargetLinkPainter = class
  protected
    class procedure InternalDrawTargetLink(ACanvas: TCanvas;
        pt1, pt2, pt3, pt4, pt5, pt6: TPoint; AColor: TColor); virtual;
  public
    class procedure DrawTargetLink(ACanvas: TCanvas;
        pt1, pt2, pt3, pt4, pt5, pt6: TPoint; AColor: TColor);
  end;
  TdxBaseDropTargetLinkPainterClass = class of TdxBaseDropTargetLinkPainter;

  TdxBaseDropTargetGroupPainter = class
  protected
    class procedure InternalDrawTargetGroup(ACanvas: TCanvas; ARect: TRect;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode); virtual;
  public
    class procedure DrawTargetGroup(ACanvas: TCanvas; ARect: TRect;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode);
  end;
  TdxBaseDropTargetGroupPainterClass = class of TdxBaseDropTargetGroupPainter;

  TdxNavBarPainter = class(TPersistent)
  private
    FNeedRecreateViewInfo: Boolean;
    FNeedRecalculateViewInfo: Boolean;
    FNeedRedrawCanvas: Boolean;
    FNavBar: TdxCustomNavBar;
    FViewInfo: TdxNavBarViewInfo;
  protected
    function GetMasterLookAndFeel: TcxLookAndFeel; virtual;
    procedure CheckDrawParamChanges;
    // View infos
    function CreateViewInfo: TdxNavBarViewInfo; virtual;
    function CreateGroupViewInfo(AViewInfo: TdxNavBarViewInfo; AGroup:
      TdxNavBarGroup; ACaptionVisible, AItemsVisible: Boolean): TdxNavBarGroupViewInfo; virtual;
    function CreateLinkViewInfo(AViewInfo: TdxNavBarGroupViewInfo; ALink: TdxNavBarItemLink;
      ACaptionVisible, AImageVisisble: Boolean): TdxNavBarLinkViewInfo; virtual;
    function GetOwner: TPersistent; override;
    function IsViewInfoValid: Boolean;
    // Painters
    class function BackgroundPainterClass: TdxBaseBackgroundPainterClass; virtual;
    class function ButtonPainterClass: TdxBaseButtonPainterClass; virtual;
    class function DropTargetGroupPainterClass: TdxBaseDropTargetGroupPainterClass; virtual;
    class function DropTargetLinkPainterClass: TdxBaseDropTargetLinkPainterClass; virtual;
    class function GroupBackgroundPainterClass: TdxBaseGroupBackgroundPainterClass; virtual;
    class function GroupBorderPainterClass: TdxBaseGroupBorderPainterClass; virtual;
    class function ImagePainterClass: TdxBaseImagePainterClass; virtual;
    class function ScrollButtonsPainterClass: TdxBaseScrollButtonsPainterClass; virtual;
    class function SelectionPainterClass: TdxBaseSelectionPainterClass; virtual;
    class function SignPainterClass: TdxBaseSignPainterClass; virtual;
  public
    constructor Create(ANavBar: TdxCustomNavBar); virtual;
    destructor Destroy; override;

    function Canvas: TCanvas;
    function DC: HDC;
    function HintWindowCanvas: TCanvas;
    function HintWindowDC: HDC;
    // Drawing
    procedure DrawNavBarControl; virtual;
    procedure DrawBackground; virtual;
    procedure DrawGroup(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupBackground(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupBorder(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupCaption(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupCaptionButton(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupCaptionText(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupCaptionImage(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupCaptionSign(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupControl(ACanvas: TCanvas; ARect: TRect; AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawGroupItems(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawItem(ALinkViewInfo: TdxNavBarLinkViewInfo); virtual;
    procedure DrawItemCaption(ALinkViewInfo: TdxNavBarLinkViewInfo); virtual;
    procedure DrawItemImage(ALinkViewInfo: TdxNavBarLinkViewInfo); virtual;
    procedure DrawItemSelection(ALinkViewInfo: TdxNavBarLinkViewInfo); virtual;
    procedure DrawItemsRect(AGroupViewInfo: TdxNavBarGroupViewInfo); virtual;
    procedure DrawScrollButtons; virtual;
    procedure DrawBottomScrollButton; virtual;
    procedure DrawTopScrollButton; virtual;
    procedure DrawDropTargetGroupSelection; virtual;
    procedure DrawDropTargetLinkSelection; virtual;
    procedure DrawHintWindow; virtual;
    procedure DrawGroupHintWindow; virtual;
    procedure DrawLinkHintWindow; virtual;

    procedure InvalidateViewInfo(AType: TdxNavBarChangeType);
    procedure InvalidateScrollButtons;
    procedure Paint;

    property NavBar: TdxCustomNavBar read FNavBar;
    property ViewInfo: TdxNavBarViewInfo read FViewInfo;
  end;
  TdxNavBarPainterClass = class of TdxNavBarPainter;

  TdxNavBarDragDropFlag = (fAllowDragLink, fAllowDropLink, fAllowDragGroup, fAllowDropGroup);
  TdxNavBarDragDropFlags = set of TdxNavBarDragDropFlag;
  TdxNavBarGroupEvent = procedure(Sender: TObject; AGroup: TdxNavBarGroup) of object;
  TdxNavBarGroupChangingEvent = procedure(Sender: TObject; ANewGroup: TdxNavBarGroup; var AAllowChange: Boolean) of object;
  TdxNavBarLinkEvent = procedure(Sender: TObject; ALink: TdxNavBarItemLink) of object;
  TdxNavBarCustomDrawEvent = procedure(Sender: TObject; ACanvas: TCanvas;
      AViewInfo: TdxNavBarViewInfo; var AHandled: Boolean) of object;
  TdxNavBarCustomDrawGroupEvent = procedure(Sender: TObject; ACanvas: TCanvas;
      AViewInfo: TdxNavBarGroupViewInfo; var AHandled: Boolean) of object;
  TdxNavBarCustomDrawGroupHintEvent = procedure(Sender: TObject; ACanvas: TCanvas;
      AGroup: TdxNavBarGroup; AHint: string; R: TRect; var AHandled: Boolean) of object;
  TdxNavBarCustomDrawLinkEvent = procedure(Sender: TObject; ACanvas: TCanvas;
      AViewInfo: TdxNavBarLinkViewInfo; var AHandled: Boolean) of object;
  TdxNavBarCustomDrawLinkHintEvent = procedure(Sender: TObject; ACanvas: TCanvas;
      ALink: TdxNavBarItemLink; AHint: string; R: TRect; var AHandled: Boolean) of object;
  TdxNavBarCalcGroupHintRectEvent = procedure(Sender: TObject; AGroup: TdxNavBarGroup;
      AViewInfo: TdxNavBarViewInfo; var R: TRect) of object;
  TdxNavBarCalcLinkHintRectEvent = procedure(Sender: TObject; ALink: TdxNavBarItemLink;
      AViewInfo: TdxNavBarViewInfo; var R: TRect) of object;
  TdxNavBarCalcGroupClientHeightEvent = procedure(Sender: TObject; AViewInfo: TdxNavBarGroupViewInfo;
      var AHeight: Integer) of object;
  TdxNavBarGetGroupHintEvent = procedure(Sender: TObject; AGroup: TdxNavBarGroup;
      var AHint: string) of object;
  TdxNavBarGetLinkHintEvent = procedure(Sender: TObject; ALink: TdxNavBarItemLink;
      var AHint: string) of object;

  TAbstractcxNavBarDesigner = class;
  TdxNavBarHintWindow = class;
  TdxNavBarScrollBar = class;

  TdxCustomNavBar = class(TCustomPanel)
  private
    FActiveGroup: TdxNavBarGroup;
    FActiveGroupIndex: Integer;
    FAllowSelectLinks: Boolean;
    FCanvasBitmap: TBitmap;
    FDefaultStyles: TdxNavBarDefaultStyles;
    FDesigner: TAbstractcxNavBarDesigner;
    FDragCopyCursor: TCursor;
    FDragDropFlags: TdxNavBarDragDropFlags;
    FDragObject: TDragControlObject;
    FEachGroupHasSelectedLink: Boolean;
    FHintWindow: TdxNavBarHintWindow;
    FHintWindowShowing: Boolean;
    FHotTrackedGroupCursor: TCursor;
    FHotTrackedLinkCursor: TCursor;
    FGroups: TdxNavBarGroups;
    FItems: TdxNavBarItems;
    FLargeChangeLink: TChangeLink;
    FLargeImages: TCustomImageList;
    FNavigationPaneOverflowPanelUseSmallImages: Boolean;
    FNavigationPaneMaxVisibleGroups: Integer;
    FPainter: TdxNavBarPainter;
    FScrollBar: TdxNavBarScrollBar;
    FShowGroupCaptions: Boolean;
    FShowGroupsHint: Boolean;
    FShowNavigationPaneOverflowPanelHints: Boolean;
    FShowLinksHint: Boolean;
    FShowSpecialGroup: Boolean;
    FSmallChangeLink: TChangeLink;
    FSmallImages: TCustomImageList;
    FSpaceBetweenGroups: Integer;
    FStyleBackground: TdxNavBarStyleItem;
    FStyleHint: TdxNavBarStyleItem;
    FStyleDropTargetGroup: TdxNavBarStyleItem;
    FStyleDropTargetLink: TdxNavBarStyleItem;
    FStyleButton: TdxNavBarStyleItem;
    FStyleButtonHotTracked: TdxNavBarStyleItem;
    FStyleButtonPressed: TdxNavBarStyleItem;
    FStyleNavigationPaneHeader: TdxNavBarStyleItem;
    FStyles: TdxNavBarStyles;
    FThemeNotificator: TdxThemeChangedNotificator;
    FUpdateLock: Integer;
    FView: Integer;

    FOnActiveGroupChanged: TNotifyEvent;
    FOnActiveGroupChanging: TdxNavBarGroupChangingEvent;
    FOnCalcGroupHintRect: TdxNavBarCalcGroupHintRectEvent;
    FOnCalcGroupClientHeight: TdxNavBarCalcGroupClientHeightEvent;
    FOnCalcLinkHintRect: TdxNavBarCalcLinkHintRectEvent;
    FOnCalcNavigationPaneOverflowPanelHintRect: TdxNavBarCalcGroupHintRectEvent;
    FOnCustomDrawBackground: TdxNavBarCustomDrawEvent;
    FOnCustomDrawGroupCaption: TdxNavBarCustomDrawGroupEvent;
    FOnCustomDrawGroupClientBackground: TdxNavBarCustomDrawGroupEvent;
    FOnCustomDrawGroupClientForeground: TdxNavBarCustomDrawGroupEvent;
    FOnCustomDrawGroupHint: TdxNavBarCustomDrawGroupHintEvent;
    FOnCustomDrawLink: TdxNavBarCustomDrawLinkEvent;
    FOnCustomDrawLinkHint: TdxNavBarCustomDrawLinkHintEvent;
    FOnCustomDrawBottomScrollButton: TdxNavBarCustomDrawEvent;
    FOnCustomDrawTopScrollButton: TdxNavBarCustomDrawEvent;
    FOnCustomDrawNavigationPaneHeader: TdxNavBarCustomDrawEvent;
    FOnCustomDrawNavigationPaneSplitter: TdxNavBarCustomDrawEvent;
    FOnCustomDrawNavigationPaneOverflowPanel: TdxNavBarCustomDrawEvent;
    FOnCustomDrawNavigationPaneOverflowPanelHint: TdxNavBarCustomDrawGroupHintEvent;
    FOnGetGroupHint: TdxNavBarGetGroupHintEvent;
    FOnGetLinkHint: TdxNavBarGetLinkHintEvent;
    FOnGroupClick: TdxNavBarGroupEvent;
    FOnGroupHotTrack: TdxNavBarGroupEvent;
    FOnGroupPress: TdxNavBarGroupEvent;
    FOnLinkClick: TdxNavBarLinkEvent;
    FOnLinkHotTrack: TdxNavBarLinkEvent;
    FOnLinkPress: TdxNavBarLinkEvent;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;

    FActivateGroupTimer: TcxTimer;
    FHintTimer: TcxTimer;
    FScrollTimer: TcxTimer;
    
    FActiveGroupCandidate: TdxNavBarGroup;
    FEnableDragging: Boolean;
    FEnableSplitterDragging: Boolean;
    FSourcePoint: TPoint;
    FSourceShift: TShiftState;
    FSourceGroup: TdxNavBarGroup;
    FSourceLink: TdxNavBarItemLink;
    FTargetPoint: TPoint;
    FHotTrackedGroup: TdxNavBarGroup;
    FHotTrackedLink: TdxNavBarItemLink;
    FPressedGroup: TdxNavBarGroup;
    FPressedLink: TdxNavBarItemLink;
    FNavigationPaneOverflowPanelHotTrackedIndex: Integer;
    FNavigationPaneOverflowPanelPressedIndex: Integer;
    FNavigationPaneOverflowPanelSignHotTracked: Boolean;
    FNavigationPaneOverflowPanelSignPressed: Boolean;
    FScrollButtonDownIsDown: Boolean;
    FScrollButtonUpIsDown: Boolean;

    function GetActiveGroup: TdxNavBarGroup;
    function GetActiveGroupIndex: Integer;
    function GetNavigationPaneOverflowPanelItemCount: Integer;
    function GetEnableDragging: Boolean;
    function GetPainter: TdxNavBarPainter;
    function GetScrollPosition: Integer;
    function GetSourceGroup: TdxNavBarGroup;
    function GetSourceLink: TdxNavBarItemLink;
    function GetSourceItem: TdxNavBarItem;
    function GetTargetGroup: TdxNavBarGroup;
    function GetTargetLink1: TdxNavBarItemLink;
    function GetTargetLink2: TdxNavBarItemLink;
    function GetTargetLinkIndex: Integer;
    function GetViewInfo: TdxNavBarViewInfo;
    function GetViewStyle: TdxNavBarPainter;
    function GetVisibleGroupCount: Integer;
    procedure SetActiveGroup(Value: TdxNavBarGroup);
    procedure SetActiveGroupIndex(Value: Integer);
    procedure SetAllowSelectLinks(const Value: Boolean);
    procedure SetDefaultStyles(const Value: TdxNavBarDefaultStyles);
    procedure SetEachGroupHasSelectedLink(const Value: Boolean);
    procedure SetLargeImages(const Value: TCustomImageList);
    procedure SetNavigationPaneOverflowPanelUseSmallImages(const Value: Boolean);
    procedure SetNavigationPaneMaxVisibleGroups(Value: Integer);
    procedure SetShowGroupCaptions(const Value: Boolean);
    procedure SetShowSpecialGroup(const Value: Boolean);
    procedure SetSmallImages(const Value: TCustomImageList);
    procedure SetSpaceBetweenGroups(Value: Integer);
    procedure SetStyleBackground(const Value: TdxNavBarStyleItem);
    procedure SetStyleHint(const Value: TdxNavBarStyleItem);
    procedure SetStyleDropTargetGroup(const Value: TdxNavBarStyleItem);
    procedure SetStyleDropTargetLink(const Value: TdxNavBarStyleItem);
    procedure SetStyleButton(const Value: TdxNavBarStyleItem);
    procedure SetStyleButtonHotTracked(const Value: TdxNavBarStyleItem);
    procedure SetStyleButtonPressed(const Value: TdxNavBarStyleItem);
    procedure SetStyleNavigationPaneHeader(const Value: TdxNavBarStyleItem);
    procedure SetView(Value: Integer);
    procedure SetViewStyle(Value: TdxNavBarPainter);

    procedure DragDone;
    function IsAllowDragLink: Boolean;
    function IsAllowDropLink: Boolean;
    function IsAllowDragGroup: Boolean;
    function IsAllowDropGroup: Boolean;
    // Notifications
    procedure OnGroupsChanged(Sender: TObject; AItem: TcxComponentCollectionItem;
      AAction: TcxComponentCollectionNotification);
    procedure OnItemsChanged(Sender: TObject; AItem: TcxComponentCollectionItem;
      AAction: TcxComponentCollectionNotification);
    procedure OnStylesChanged(Sender: TObject; AItem: TcxComponentCollectionItem;
      AAction: TcxComponentCollectionNotification);

    procedure OnDefaultStylesChanged(Sender: TObject; AType: TdxNavBarChangeType);
    procedure OnImagesChanged(Sender: TObject);
    procedure OnLinksChanged(Sender: TObject; ALink: TdxNavBarItemLink);
    procedure OnThemeChanged;
    // Timers
    procedure DoActivateGroupTimer(Sender: TObject);
    procedure DoScrollTimer(Sender: TObject);
    procedure DoHintTimer(Sender: TObject);
    // Messages
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMCreate(var Msg: TWMCreate); message WM_CREATE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure WndProc(var Message: TMessage); override;

    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint): Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseEnter; dynamic;
    procedure MouseLeave; dynamic;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DoStartDrag(var DragObject: TDragObject); override;

    procedure DoActiveGroupChanged; virtual;
    procedure DoActiveGroupChanging(ANewGroup: TdxNavBarGroup; var AAllowChange: Boolean);
    procedure DoGroupDragDrop(Group: TdxNavBarGroup); virtual;
    procedure DoGroupDragOver(Group: TdxNavBarGroup; var Accept: Boolean); virtual;
    procedure DoGroupHotTrack(Group: TdxNavBarGroup); virtual;
    procedure DoGroupMouseDown(Group: TdxNavBarGroup); virtual;
    procedure DoGroupMouseUp(Group: TdxNavBarGroup); virtual;
    procedure DoLinkDragDrop(Link: TdxNavBarItemLink); virtual;
    procedure DoLinkDragOver(Link: TdxNavBarItemLink; var Accept: Boolean); virtual;
    procedure DoLinkHotTrack(Link: TdxNavBarItemLink); virtual;
    procedure DoLinkMouseDown(Link: TdxNavBarItemLink); virtual;
    procedure DoLinkMouseUp(Link: TdxNavBarItemLink); virtual;
    procedure DoItemDragDrop(Item: TdxNavBarItem); virtual;
    procedure DoItemDragOver(Item: TdxNavBarItem; var Accept: Boolean); virtual;
    procedure DoBottomScrollButtonDown; virtual;
    procedure DoBottomScrollButtonUp; virtual;
    procedure DoTopScrollButtonDown; virtual;
    procedure DoTopScrollButtonUp; virtual;
    procedure DoNavigationPaneOverflowPanelHintsActivate; virtual;
    procedure DoGroupHintActivate; virtual;
    procedure DoLinkHintActivate; virtual;
    procedure DoHintActivate;
    procedure DoHintDeactivate; virtual;
    procedure DoOverflowPanelMouseDown; virtual;
    procedure DoOverflowPanelMouseMove; virtual;
    procedure DoOverflowPanelMouseUp; virtual;
    procedure DoSplitterMouseDown; virtual;
    procedure DoSplitterDrag; virtual;
    procedure DoSplitterMouseUp; virtual;
    procedure DoUpdateScrollBarStyle; virtual;
    function GetClientRect: TRect; override;
    procedure Scroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    // Painting
    procedure Paint; override;
    procedure InvalidateScrollButtons;
    // Load/Save layout
    procedure LoadFromRegIni(AStorage: TCustomIniFile; LoadStyles: Boolean); virtual;
    procedure SaveToRegIni(AStorage: TCustomIniFile; SaveStyles: Boolean); virtual;

    function CreatePainter: TdxNavBarPainter; virtual;
    function GetGroupClass: TdxNavBarGroupClass; virtual;
    function GetItemClass: TdxNavBarItemClass; virtual;
    property CanvasBitmap: TBitmap read FCanvasBitmap;
    property UpdateLock: Integer read FUpdateLock;      
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DeSelectLinks;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;

    procedure InitiateAction; override;
    procedure Invalidate; override;
    procedure InvalidateAll(AType: TdxNavBarChangeType); overload;
    procedure InvalidateAll(AItem: TcxComponentCollectionItem;
      AAction: TcxComponentCollectionNotification); overload;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    // Layout store/restore
    procedure AssignDefaultStyles;
    procedure LoadFromIniFile(AFileName: string; LoadStyles: Boolean = True);
    procedure LoadFromRegistry(ARegistryPath: string; LoadStyles: Boolean = True);
    procedure LoadFromStream(AStream: TStream; LoadStyles: Boolean = True);
    procedure SaveToIniFile(AFileName: string; SaveStyles: Boolean = True);
    procedure SaveToRegistry(ARegistryPath: string; SaveStyles: Boolean = True);
    procedure SaveToStream(AStream: TStream; SaveStyles: Boolean = True);
    // ViewInfo
    function GetGroupAtCaptionPos(pt: TPoint): TdxNavBarGroup;
    function GetGroupAtItemsPos(pt: TPoint): TdxNavBarGroup;
    function GetLinkAtPos(pt: TPoint): TdxNavBarItemLink;
    function GetLinkAtSelectedPos(pt: TPoint): TdxNavBarItemLink;
    function IsPtTopScrollButton(pt: TPoint): Boolean;
    function IsPtBottomScrollButton(pt: TPoint): Boolean;
    function IsTopScrollButtonVisible: Boolean;
    function IsBottomScrollButtonVisible: Boolean;
    function IsPtNavigationPaneHeader(pt: TPoint): Boolean;
    function IsPtNavigationPaneSplitter(pt: TPoint): Boolean;
    function IsPtNavigationPaneOverflowPanel(pt: TPoint): Boolean;
    // Groups and links visibility
    procedure MakeLinkVisible(ALink: TdxNavBarItemLink);
    procedure MakeGroupVisible(AGroup: TdxNavBarGroup);
    // Updates lock
    procedure BeginUpdate;
    procedure EndUpdate;
    // NavigationPane
    function CanDecNavigationPaneOverflowPanelItemCount: Boolean;
    function CanIncNavigationPaneOverflowPanelItemCount: Boolean;
    procedure DoDecNavigationPaneOverflowPanelItemCount;
    procedure DoIncNavigationPaneOverflowPanelItemCount;
    // Designer
    procedure DesignerModified;
    procedure DesignerUpdate(AItem: TComponent);

    property Painter: TdxNavBarPainter read GetPainter;
    property ViewInfo: TdxNavBarViewInfo read GetViewInfo;

    property EnableDragging: Boolean read GetEnableDragging;
    property EnableSplitterDragging: Boolean read FEnableSplitterDragging;
    property ScrollBar: TdxNavBarScrollBar read FScrollBar;
    property SourcePoint: TPoint read FSourcePoint;
    property SourceGroup: TdxNavBarGroup read GetSourceGroup;
    property SourceLink: TdxNavBarItemLink read GetSourceLink;
    property SourceItem: TdxNavBarItem read GetSourceItem;
    property TargetPoint: TPoint read FTargetPoint;
    property TargetGroup: TdxNavBarGroup read GetTargetGroup;
    property TargetLink1: TdxNavBarItemLink read GetTargetLink1;
    property TargetLink2: TdxNavBarItemLink read GetTargetLink2;
    property TargetLinkIndex: Integer read GetTargetLinkIndex;
    property HintWindow: TdxNavBarHintWindow read FHintWindow;
    property HintWindowShowing: Boolean read FHintWindowShowing;
    property HotTrackedGroup: TdxNavBarGroup read FHotTrackedGroup;
    property HotTrackedLink: TdxNavBarItemLink read FHotTrackedLink;
    property PressedGroup: TdxNavBarGroup read FPressedGroup;
    property PressedLink: TdxNavBarItemLink read FPressedLink;
    property NavigationPaneOverflowPanelItemCount: Integer read GetNavigationPaneOverflowPanelItemCount;
    property NavigationPaneOverflowPanelHotTrackedIndex: Integer read FNavigationPaneOverflowPanelHotTrackedIndex;
    property NavigationPaneOverflowPanelPressedIndex: Integer read FNavigationPaneOverflowPanelPressedIndex;
    property NavigationPaneOverflowPanelNavigationPaneSignHotTracked: Boolean read FNavigationPaneOverflowPanelSignHotTracked;
    property NavigationPaneOverflowPanelSignPressed: Boolean read FNavigationPaneOverflowPanelSignPressed;
    property NavigationPaneOverflowPanelSignHotTracked: Boolean read FNavigationPaneOverflowPanelSignHotTracked;
    property ScrollButtonDownIsDown: Boolean read FScrollButtonDownIsDown;
    property ScrollButtonUpIsDown: Boolean read FScrollButtonUpIsDown;
    property ScrollPosition: Integer read GetScrollPosition;

    property ActiveGroupIndex: Integer read GetActiveGroupIndex write SetActiveGroupIndex;
    property ActiveGroup: TdxNavBarGroup read GetActiveGroup write SetActiveGroup;
    property AllowSelectLinks: Boolean read FAllowSelectLinks write SetAllowSelectLinks default False;
    property DefaultStyles: TdxNavBarDefaultStyles read FDefaultStyles write SetDefaultStyles;
    property Designer: TAbstractcxNavBarDesigner read FDesigner;
    property DragCopyCursor: TCursor read FDragCopyCursor write FDragCopyCursor;
    property DragDropFlags: TdxNavBarDragDropFlags read FDragDropFlags write FDragDropFlags;
    property EachGroupHasSelectedLink: Boolean read FEachGroupHasSelectedLink write SetEachGroupHasSelectedLink default False;
    property HotTrackedGroupCursor: TCursor read FHotTrackedGroupCursor write FHotTrackedGroupCursor;
    property HotTrackedLinkCursor: TCursor read FHotTrackedLinkCursor write FHotTrackedLinkCursor;
    property Groups: TdxNavBarGroups read FGroups;
    property Items: TdxNavBarItems read FItems;
    property LargeImages: TCustomImageList read FLargeImages write SetLargeImages;
    property NavigationPaneMaxVisibleGroups: Integer read FNavigationPaneMaxVisibleGroups write SetNavigationPaneMaxVisibleGroups default -1;
    property NavigationPaneOverflowPanelUseSmallImages: Boolean read FNavigationPaneOverflowPanelUseSmallImages write SetNavigationPaneOverflowPanelUseSmallImages default True;
    property ShowGroupCaptions: Boolean read FShowGroupCaptions write SetShowGroupCaptions default True;
    property ShowGroupsHint: Boolean read FShowGroupsHint write FShowGroupsHint default False;
    property ShowLinksHint: Boolean read FShowLinksHint write FShowLinksHint default False;
    property ShowNavigationPaneOverflowPanelHints: Boolean read FShowNavigationPaneOverflowPanelHints write FShowNavigationPaneOverflowPanelHints default True;
    property ShowSpecialGroup: Boolean read FShowSpecialGroup write SetShowSpecialGroup default False;
    property SmallImages: TCustomImageList read FSmallImages write SetSmallImages;
    property SpaceBetweenGroups: Integer read FSpaceBetweenGroups write SetSpaceBetweenGroups default 0;
    property StyleBackground: TdxNavBarStyleItem read FStyleBackground write SetStyleBackground;
    property StyleHint: TdxNavBarStyleItem read FStyleHint write SetStyleHint;
    property StyleDropTargetGroup: TdxNavBarStyleItem read FStyleDropTargetGroup write SetStyleDropTargetGroup;
    property StyleDropTargetLink: TdxNavBarStyleItem read FStyleDropTargetLink write SetStyleDropTargetLink;
    property StyleButton: TdxNavBarStyleItem read FStyleButton write SetStyleButton;
    property StyleButtonHotTracked: TdxNavBarStyleItem read FStyleButtonHotTracked write SetStyleButtonHotTracked;
    property StyleButtonPressed: TdxNavBarStyleItem read FStyleButtonPressed write SetStyleButtonPressed;
    property StyleNavigationPaneHeader: TdxNavBarStyleItem read FStyleNavigationPaneHeader write SetStyleNavigationPaneHeader;
    property Styles: TdxNavBarStyles read FStyles;
    property View: Integer read FView write SetView;
    property ViewStyle: TdxNavBarPainter read GetViewStyle write SetViewStyle;
    property VisibleGroupCount: Integer read GetVisibleGroupCount;

    property OnActiveGroupChanged: TNotifyEvent read FOnActiveGroupChanged write FOnActiveGroupChanged;
    property OnActiveGroupChanging: TdxNavBarGroupChangingEvent read FOnActiveGroupChanging write FOnActiveGroupChanging;
    property OnCalcGroupClientHeight: TdxNavBarCalcGroupClientHeightEvent read FOnCalcGroupClientHeight write FOnCalcGroupClientHeight;
    property OnCalcGroupHintRect: TdxNavBarCalcGroupHintRectEvent read FOnCalcGroupHintRect write FOnCalcGroupHintRect;
    property OnCalcLinkHintRect: TdxNavBarCalcLinkHintRectEvent read FOnCalcLinkHintRect write FOnCalcLinkHintRect;
    property OnCalcNavigationPaneOverflowPanelHintRect: TdxNavBarCalcGroupHintRectEvent read FOnCalcNavigationPaneOverflowPanelHintRect write FOnCalcNavigationPaneOverflowPanelHintRect;
    property OnCustomDrawBackground: TdxNavBarCustomDrawEvent read FOnCustomDrawBackground write FOnCustomDrawBackground;
    property OnCustomDrawGroupCaption: TdxNavBarCustomDrawGroupEvent read FOnCustomDrawGroupCaption write FOnCustomDrawGroupCaption;
    property OnCustomDrawGroupClientBackground: TdxNavBarCustomDrawGroupEvent read FOnCustomDrawGroupClientBackground write FOnCustomDrawGroupClientBackground;
    property OnCustomDrawGroupClientForeground: TdxNavBarCustomDrawGroupEvent read FOnCustomDrawGroupClientForeground write FOnCustomDrawGroupClientForeground;
    property OnCustomDrawGroupHint: TdxNavBarCustomDrawGroupHintEvent read FOnCustomDrawGroupHint write FOnCustomDrawGroupHint;
    property OnCustomDrawLink: TdxNavBarCustomDrawLinkEvent read FOnCustomDrawLink write FOnCustomDrawLink;
    property OnCustomDrawLinkHint: TdxNavBarCustomDrawLinkHintEvent read FOnCustomDrawLinkHint write FOnCustomDrawLinkHint;
    property OnCustomDrawBottomScrollButton: TdxNavBarCustomDrawEvent read FOnCustomDrawBottomScrollButton write FOnCustomDrawBottomScrollButton;
    property OnCustomDrawTopScrollButton: TdxNavBarCustomDrawEvent read FOnCustomDrawTopScrollButton write FOnCustomDrawTopScrollButton;
    property OnCustomDrawNavigationPaneHeader: TdxNavBarCustomDrawEvent read FOnCustomDrawNavigationPaneHeader write FOnCustomDrawNavigationPaneHeader;
    property OnCustomDrawNavigationPaneSplitter: TdxNavBarCustomDrawEvent read FOnCustomDrawNavigationPaneSplitter write FOnCustomDrawNavigationPaneSplitter;
    property OnCustomDrawNavigationPaneOverflowPanel: TdxNavBarCustomDrawEvent read FOnCustomDrawNavigationPaneOverflowPanel write FOnCustomDrawNavigationPaneOverflowPanel;
    property OnCustomDrawNavigationPaneOverflowPanelHint: TdxNavBarCustomDrawGroupHintEvent read FOnCustomDrawNavigationPaneOverflowPanelHint write FOnCustomDrawNavigationPaneOverflowPanelHint;
    property OnGetGroupHint: TdxNavBarGetGroupHintEvent read FOnGetGroupHint write FOnGetGroupHint;
    property OnGetLinkHint: TdxNavBarGetLinkHintEvent read FOnGetLinkHint write FOnGetLinkHint;
    property OnGroupClick: TdxNavBarGroupEvent read FOnGroupClick write FOnGroupClick;
    property OnGroupHotTrack: TdxNavBarGroupEvent read FOnGroupHotTrack write FOnGroupHotTrack;
    property OnGroupPress: TdxNavBarGroupEvent read FOnGroupPress write FOnGroupPress;
    property OnLinkClick: TdxNavBarLinkEvent read FOnLinkClick write FOnLinkClick;
    property OnLinkHotTrack: TdxNavBarLinkEvent read FOnLinkHotTrack write FOnLinkHotTrack;
    property OnLinkPress: TdxNavBarLinkEvent read FOnLinkPress write FOnLinkPress;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;

    property DragCursor;
  published
    property Align;
    property Anchors;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property Enabled;
    property Font;
    property Locked;
    property PopupMenu;
    property Visible;

    property OnContextPopup;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TdxNavBarDragObject = class
  private
    FNavBar: TdxCustomNavBar;
    FSourceGroup: TdxNavBarGroup;
    FSourceLink: TdxNavBarItemLink;
    FSourceItem: TdxNavBarItem;
    FTargetGroup: TdxNavBarGroup;
    FTargetLink1: TdxNavBarItemLink;
    FTargetLink2: TdxNavBarItemLink;
    FTargetLinkIndex: Integer;
    function GetSourceItem: TdxNavBarItem;
  protected
    procedure UpdateTargets; virtual;
  public
    constructor Create(ANavBar: TdxCustomNavBar;
      var DragObject: TDragObject {deprecated}; ASourceGroup: TdxNavBarGroup;
      ASourceLink: TdxNavBarItemLink; ASourceItem: TdxNavBarItem);
    property NavBar: TdxCustomNavBar read FNavBar;
    property SourceGroup: TdxNavBarGroup read FSourceGroup;
    property SourceLink: TdxNavBarItemLink read FSourceLink;
    property SourceItem: TdxNavBarItem read GetSourceItem;
    property TargetGroup: TdxNavBarGroup read FTargetGroup;
    property TargetLink1: TdxNavBarItemLink read FTargetLink1;
    property TargetLink2: TdxNavBarItemLink read FTargetLink2;
    property TargetLinkIndex: Integer read FTargetLinkIndex;
  end;

  TdxNavBarScrollBar = class
  private
    FKind: TScrollBarKind;
    FParent: TWinControl;
    FScrollBar: TcxScrollBar;
    FScrollInfo: TScrollInfo;
    FVisible: Boolean;

    FLargeChange: Integer;
    FSmallChange: Integer;

    FOnScroll: TScrollEvent;

    procedure CorrectPos(var APos: Integer; AMin, AMax, APageSize: Integer);
    function GetHandle: THandle;
    function GetHeight: Integer;
    function GetMax: Integer;
    function GetMin: Integer;
    function GetPageSize: Integer;
    function GetPosition: Integer;
    function GetWidth: Integer;
    procedure SetMax(const Value: Integer);
    procedure SetMin(const Value: Integer);
    procedure SetPageSize(const Value: Integer);
    procedure SetPosition(const Value: Integer);
    procedure SetVisible(const Value: Boolean);
  protected
    procedure Reset;
    procedure Scroll(Sender: TObject; AScrollCode: TScrollCode; var AScrollPos: Integer);
    property Handle: THandle read GetHandle;
    property ScrollBar: TcxScrollBar read FScrollBar;
  public
    constructor Create(AParent: TWinControl; AKind: TScrollBarKind);
    destructor Destroy; override;
    procedure SetScrollParams(AMin, AMax, APosition, APageSize: Integer; ARedraw: Boolean = True);

    property Height: Integer read GetHeight;
    property Max: Integer read GetMax write SetMax;
    property Min: Integer read GetMin write SetMin;
    property PageSize: Integer read GetPageSize write SetPageSize;
    property Position: Integer read GetPosition write SetPosition;
    property Visible: Boolean read FVisible write SetVisible;
    property Width: Integer read GetWidth;

    property LargeChange: Integer read FLargeChange write FLargeChange;
    property SmallChange: Integer read FSmallChange write FSmallChange;
    property OnScroll: TScrollEvent read FOnScroll write FOnScroll;
  end;

  TdxNavBarHintWindow = class(TCustomControl)
  private
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
  public
    procedure ActivateHint(Rect: TRect; const AHint: string);
    function NavBar: TdxCustomNavBar;
  end;

  TAbstractcxNavBarDesigner = class
  private
    FNavBar: TdxCustomNavBar;
  protected
    procedure Modified; virtual; abstract;
    procedure Update(AItem: TComponent); virtual; abstract;
  public
    constructor Create(ANavBar: TdxCustomNavBar);
    destructor Destroy; override;

    procedure BeginUpdate; virtual; abstract;
    procedure CancelUpdate; virtual; abstract;
    procedure EndUpdate; virtual; abstract;

    property NavBar: TdxCustomNavBar read FNavBar;
  end;

  TdxNavBar = class(TdxCustomNavBar)
  published
    property ActiveGroupIndex;
    property AllowSelectLinks;
    property DefaultStyles;
    property DragCopyCursor;
    property DragCursor;
    property DragDropFlags;
    property EachGroupHasSelectedLink;
    property HotTrackedGroupCursor;
    property HotTrackedLinkCursor;
    property LargeImages;
    property NavigationPaneMaxVisibleGroups;
    property NavigationPaneOverflowPanelUseSmallImages;
    property ShowGroupCaptions;
    property ShowGroupsHint;
    property ShowLinksHint;
    property ShowNavigationPaneOverflowPanelHints;
    property ShowSpecialGroup;
    property SmallImages;
    property SpaceBetweenGroups;
    property StyleBackground;
    property StyleHint;
    property StyleDropTargetGroup;
    property StyleDropTargetLink;
    property StyleButton;
    property StyleButtonHotTracked;
    property StyleButtonPressed;
    property StyleNavigationPaneHeader;
    property View;
    property ViewStyle;

    property OnActiveGroupChanged;
    property OnActiveGroupChanging;
    property OnCalcGroupClientHeight;
    property OnCalcGroupHintRect;
    property OnCalcNavigationPaneOverflowPanelHintRect;
    property OnCalcLinkHintRect;
    property OnCustomDrawBackground;
    property OnCustomDrawGroupCaption;
    property OnCustomDrawGroupClientBackground;
    property OnCustomDrawGroupClientForeground;
    property OnCustomDrawGroupHint;
    property OnCustomDrawLink;
    property OnCustomDrawLinkHint;
    property OnCustomDrawBottomScrollButton;
    property OnCustomDrawTopScrollButton;
    property OnCustomDrawNavigationPaneHeader;
    property OnCustomDrawNavigationPaneSplitter;
    property OnCustomDrawNavigationPaneOverflowPanel;
    property OnCustomDrawNavigationPaneOverflowPanelHint;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnGetGroupHint;
    property OnGetLinkHint;
    property OnGroupClick;
    property OnGroupHotTrack;
    property OnGroupPress;
    property OnLinkClick;
    property OnLinkHotTrack;
    property OnLinkPress;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnStartDrag;
  end;

var
  dxNavBarDragObject: TdxNavBarDragObject;
  DrawIconsAsEnabled: Boolean;

implementation

{$R *.res}

uses
  Consts, Math, SysUtils, 
  dxCore, dxUxTheme, cxGraphics, cxGeometry,
  dxNavBarConsts, dxNavBarGraphics,
  dxNavBarViewsFact, dxNavBarBaseViews, dxNavBarXPViews,
  dxNavBarOfficeViews, dxNavBarOffice11Views,
  dxNavBarVSToolBoxViews, dxNavBarExplorerViews;

{ TdxNavBarLinkViewInfo }

constructor TdxNavBarLinkViewInfo.Create(AGroupViewInfo: TdxNavBarGroupViewInfo; ALink: TdxNavBarItemLink;
  ACaptionVisible, AImageVisisble: Boolean);
begin
  inherited Create;
  FGroupViewInfo := AGroupViewInfo;
  FViewInfo := FGroupViewInfo.ViewInfo;
  FPainter := FViewInfo.Painter;
  FNavBar := FViewInfo.NavBar;
  FLink := ALink;
  FItem := FLink.Item;
  FCaptionVisible := ACaptionVisible;
  FImageVisible := AImageVisisble;

  FFont := TFont.Create;
end;

destructor TdxNavBarLinkViewInfo.Destroy;
begin
  FFont.Free;
  inherited;
end;

function TdxNavBarLinkViewInfo.ImageIndex: Integer;
begin
  if GroupViewInfo.IsLinksUseSmallImages then
    Result := Item.SmallImageIndex
  else Result := Item.LargeImageIndex;
end;

function TdxNavBarLinkViewInfo.ImageList: TCustomImageList;
begin
  if GroupViewInfo.IsLinksUseSmallImages then
    Result := NavBar.SmallImages
  else Result := NavBar.LargeImages;
end;

function TdxNavBarLinkViewInfo.IsWholeVisible: Boolean;
begin
  Result := PtInRect(GroupViewInfo.ItemsRect, Rect.TopLeft) and
    PtInRect(GroupViewInfo.ItemsRect, Rect.BottomRight); 
end;

function TdxNavBarLinkViewInfo.SelectionRect: TRect;
begin
  Result := ImageRect;
  InflateRect(Result, 2, 2)
end;

function TdxNavBarLinkViewInfo.GetCaptionHeight: Integer;
begin
  Result := 4;
  Inc(Result, GetFontHeight(Font));
end;

function TdxNavBarLinkViewInfo.GetDrawEdgeFlag: Integer;
begin
  if GroupViewInfo.IsLinksUseSmallImages then
    Result := DT_LEFT or DT_VCENTER or DT_SINGLELINE
  else Result := DT_CENTER or DT_WORDBREAK;
end;

function TdxNavBarLinkViewInfo.GetImageHeight: Integer;
begin
  if GroupViewInfo.IsLinksUseSmallImages then
    Result := ViewInfo.GetSmallImageHeight
  else Result := ViewInfo.GetLargeImageHeight;
end;

function TdxNavBarLinkViewInfo.GetImageWidth: Integer;
begin
  if GroupViewInfo.IsLinksUseSmallImages then
    Result := ViewInfo.GetSmallImageWidth
  else Result := ViewInfo.GetLargeImageWidth;
end;

function TdxNavBarLinkViewInfo.IsCaptionVisible: Boolean;
begin
  Result := FCaptionVisible and (FCaptionRect.Left > FRect.Left) and (FCaptionRect.Right < FRect.Right);
end;

function TdxNavBarLinkViewInfo.IsImageVisible: Boolean;
begin
  Result := FImageVisible and (FImageRect.Left > FRect.Left) and (FImageRect.Right < FRect.Right);
end;

function TdxNavBarLinkViewInfo.StyleItem: TdxNavBarStyleItem;
begin
  if sDisabled in State then
    Result := Item.StyleDisabled
  else if sPressed in State then
    Result := Item.StylePressed
  else if sHotTracked in State then
    Result := Item.StyleHotTracked
  else Result := Item.Style;
end;

function TdxNavBarLinkViewInfo.Style: TdxBaseNavBarStyle;
begin
  if sDisabled in State then
    Result := NavBar.DefaultStyles.ItemDisabled
  else if sPressed in State then
    Result := NavBar.DefaultStyles.ItemPressed
  else if sHotTracked in State then
    Result := NavBar.DefaultStyles.ItemHotTracked
  else Result := NavBar.DefaultStyles.Item;
end;

function TdxNavBarLinkViewInfo.Font: TFont;
begin
  Result := FFont;
  if (StyleItem <> nil) and (savFont in StyleItem.Style.AssignedValues) then
    Result.Assign(StyleItem.Style.Font)
  else Result.Assign(Style.Font);
end;

function TdxNavBarLinkViewInfo.FontColor: TColor;
begin
  Result := Font.Color;
end;

procedure TdxNavBarLinkViewInfo.CalculateBounds(X, Y: Integer);
var
  AHeight: Integer;
begin
  if GroupViewInfo.IsViewAsIconView then
  begin
    FImageRect.Top := Y + ViewInfo.GetLinksImageHorizontalEdge;
    FImageRect.Left := X + ViewInfo.GetLinksImageVerticalEdge;
    FImageRect.Bottom := FImageRect.Top + GetImageHeight;
    FImageRect.Right := FImageRect.Left + GetImageWidth;
    FRect.Left := X;
    FRect.Top := Y;
    FRect.Bottom := FImageRect.Bottom + ViewInfo.GetLinksImageVerticalEdge;
    FRect.Right := FImageRect.Right + ViewInfo.GetLinksImageHorizontalEdge;
    SetRectEmpty(FCaptionRect);
  end
  else if GroupViewInfo.IsLinksUseSmallImages then
  begin
    FImageRect.Top := Y + ViewInfo.GetLinksSmallSeparatorWidth div 2;
    FImageRect.Left := X + ViewInfo.GetLinksImageVerticalEdge;
    FImageRect.Bottom := FImageRect.Top + GetImageHeight;
    FImageRect.Right := FImageRect.Left + GetImageWidth;
    FCaptionRect.Top := FImageRect.Top + (FImageRect.Bottom - FImageRect.Top) div 2 - GetCaptionHeight div 2;
    FCaptionRect.Left := FImageRect.Right + ViewInfo.GetLinksImageVerticalEdge;
    FCaptionRect.Bottom := FCaptionRect.Top + GetCaptionHeight;
    FCaptionRect.Right := ViewInfo.ClientWidth - 1 - X;
    NavBar.Painter.Canvas.Font := Font;
    cxDrawText(NavBar.Painter.DC, Item.Caption, FCaptionRect, GetDrawEdgeFlag or DT_CALCRECT);
    if FCaptionRect.Right > ViewInfo.ClientWidth - 1 - X then
      FCaptionRect.Right := ViewInfo.ClientWidth - 1 - X;
    FRect.Left := X;
    FRect.Top := Y;
    FRect.Right := ViewInfo.ClientWidth - 1 - X;
    if FImageRect.Bottom > FCaptionRect.Bottom then
      FRect.Bottom := FImageRect.Bottom + ViewInfo.GetLinksSmallSeparatorWidth div 2
    else FRect.Bottom := FCaptionRect.Bottom + ViewInfo.GetLinksSmallSeparatorWidth div 2;
  end
  else
  begin
    FImageRect.Top := Y + ViewInfo.GetLinksLargeSeparatorWidth div 2;
    FImageRect.Left := (ViewInfo.ClientWidth div 2) - (ViewInfo.GetLargeImageWidth div 2);
    FImageRect.Bottom := FImageRect.Top + GetImageHeight;
    FImageRect.Right := FImageRect.Left + GetImageWidth;
    FCaptionRect.Top := FImageRect.Bottom + ViewInfo.GetLinksImageHorizontalEdge;
    FCaptionRect.Left := X;
    FCaptionRect.Bottom := FCaptionRect.Top + GetCaptionHeight;
    FCaptionRect.Right := ViewInfo.ClientWidth - 1 - X;
    NavBar.Painter.Canvas.Font := Font;
    AHeight := cxDrawText(NavBar.Painter.DC, Item.Caption, FCaptionRect, GetDrawEdgeFlag or DT_CALCRECT);
    OffSetRect(FCaptionRect, (ViewInfo.ClientWidth - 2 * X - (FCaptionRect.Right - FCaptionRect.Left)) div 2, 0);
    FCaptionRect.Bottom := FCaptionRect.Top + AHeight;
    FRect.Left := X;
    FRect.Top := Y;
    FRect.Right := ViewInfo.ClientWidth - 1 - X;
    FRect.Bottom := FCaptionRect.Bottom + ViewInfo.GetLinksLargeSeparatorWidth div 2;
  end;
end;

procedure TdxNavBarLinkViewInfo.CorrectBounds(dX, dY: Integer);
begin
  OffsetRect(FRect, dX, dY);
  OffsetRect(FImageRect, dX, dY);
  OffsetRect(FCaptionRect, dX, dY);
end;

function TdxNavBarLinkViewInfo.GetState: TdxNavBarObjectStates;
begin
  Result := [];
  if not Item.Enabled then
    Result := Result + [sDisabled];
  if NavBar.PressedLink = Link then
    Result := Result + [sPressed];
  if Link.IsSelected then
    Result := Result + [sSelected];
  if NavBar.HotTrackedLink = Link then
    Result := Result + [sHotTracked];
end;

{ TdxNavBarGroupViewInfo }

constructor TdxNavBarGroupViewInfo.Create(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup;
  ACaptionVisible, AItemsVisible: Boolean);
begin
  inherited Create;
  FViewInfo := AViewInfo;
  FPainter := FViewInfo.Painter;
  FNavBar := FViewInfo.NavBar;
  FGroup := AGroup;
  FCaptionVisible := ACaptionVisible;
  FItemsVisible := AItemsVisible;

  FCaptionFont := TFont.Create;
  FItems := TList.Create;
  CreateInfo;
end;

destructor TdxNavBarGroupViewInfo.Destroy;
begin
  FCaptionFont.Free;
  ClearItems;
  FItems.Free;
  inherited Destroy;
end;

function TdxNavBarGroupViewInfo.GetLinkViewInfoByLink(ALink: TdxNavBarItemLink): TdxNavBarLinkViewInfo;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ItemCount - 1 do
    if Items[I].Link = ALink then
    begin
      Result := Items[I];
      break;
    end;
end;

function TdxNavBarGroupViewInfo.IndexOfLinkViewInfo(AViewInfo: TdxNavBarLinkViewInfo): Integer;
begin
  Result := FItems.IndexOf(AViewInfo);
end;

function TdxNavBarGroupViewInfo.BorderColor: TColor;
begin
  Result := CaptionBackColor2;
end;

function TdxNavBarGroupViewInfo.BgImage: TPicture;
begin
  if (Group.StyleBackground <> nil) and (savImage in Group.StyleBackground.Style.AssignedValues) then
    Result := Group.StyleBackground.Style.Image
  else Result := NavBar.DefaultStyles.GroupBackground.Image;
end;

function TdxNavBarGroupViewInfo.BgBackColor: TColor;
begin
  if (Group.StyleBackground <> nil) and (savBackColor in Group.StyleBackground.Style.AssignedValues) then
    Result := Group.StyleBackground.Style.BackColor
  else Result := NavBar.DefaultStyles.GroupBackground.BackColor;
end;

function TdxNavBarGroupViewInfo.BgBackColor2: TColor;
begin
  if (Group.StyleBackground <> nil) and (savBackColor2 in Group.StyleBackground.Style.AssignedValues) then
    Result := Group.StyleBackground.Style.BackColor2
  else Result := NavBar.DefaultStyles.GroupBackground.BackColor2;
end;

function TdxNavBarGroupViewInfo.BgAlphaBlend: Byte;
begin
  if (Group.StyleBackground <> nil) and (savAlphaBlending in Group.StyleBackground.Style.AssignedValues) then
    Result := Group.StyleBackground.Style.AlphaBlending
  else Result := NavBar.DefaultStyles.GroupBackground.AlphaBlending;
end;

function TdxNavBarGroupViewInfo.BgAlphaBlend2: Byte;
begin
  if (Group.StyleBackground <> nil) and (savAlphaBlending2 in Group.StyleBackground.Style.AssignedValues) then
    Result := Group.StyleBackground.Style.AlphaBlending2
  else Result := NavBar.DefaultStyles.GroupBackground.AlphaBlending2;
end;

function TdxNavBarGroupViewInfo.BgGradientMode: TdxBarStyleGradientMode;
begin
  if (Group.StyleBackground <> nil) and (savGradientMode in Group.StyleBackground.Style.AssignedValues) then
    Result := Group.StyleBackground.Style.GradientMode
  else Result := NavBar.DefaultStyles.GroupBackground.GradientMode;
end;

function TdxNavBarGroupViewInfo.CaptionStyleItem: TdxNavBarStyleItem;
begin
  if (sActive in State) or (sSpecial in State) then
  begin
    if sPressed in State then
      Result := Group.StyleHeaderActivePressed
    else if sHotTracked in State then
      Result := Group.StyleHeaderActiveHotTracked
    else Result := Group.StyleHeaderActive;
  end
  else if sPressed in State then
    Result := Group.StyleHeaderPressed
  else if sHotTracked in State then
    Result := Group.StyleHeaderHotTracked
  else Result := Group.StyleHeader;
end;

function TdxNavBarGroupViewInfo.CaptionStyle: TdxBaseNavBarStyle;
begin
  if (sActive in State) or (sSpecial in State) then
  begin
    if sPressed in State then
      Result := NavBar.DefaultStyles.GroupHeaderActivePressed
    else if sHotTracked in State then
      Result := NavBar.DefaultStyles.GroupHeaderActiveHotTracked
    else Result := NavBar.DefaultStyles.GroupHeaderActive;
  end
  else if sPressed in State then
    Result := NavBar.DefaultStyles.GroupHeaderPressed
  else if sHotTracked in State then
    Result := NavBar.DefaultStyles.GroupHeaderHotTracked
  else Result := NavBar.DefaultStyles.GroupHeader;
end;

function TdxNavBarGroupViewInfo.CaptionImage: TPicture;
begin
  if (CaptionStyleItem <> nil) and (savImage in CaptionStyleItem.Style.AssignedValues) then
    Result := CaptionStyleItem.Style.Image
  else Result := CaptionStyle.Image;
end;

function TdxNavBarGroupViewInfo.CaptionBorderColor: TColor;
begin
  Result := clNone;
end;

function TdxNavBarGroupViewInfo.CaptionBackColor: TColor;
begin
  if (CaptionStyleItem <> nil) and (savBackColor in CaptionStyleItem.Style.AssignedValues) then
    Result := CaptionStyleItem.Style.BackColor
  else Result := CaptionStyle.BackColor;
end;

function TdxNavBarGroupViewInfo.CaptionBackColor2: TColor;
begin
  if (CaptionStyleItem <> nil) and (savBackColor2 in CaptionStyleItem.Style.AssignedValues) then
    Result := CaptionStyleItem.Style.BackColor2
  else Result := CaptionStyle.BackColor2;
end;

function TdxNavBarGroupViewInfo.CaptionAlphaBlend: Byte;
begin
  if (CaptionStyleItem <> nil) and (savAlphaBlending in CaptionStyleItem.Style.AssignedValues) then
    Result := CaptionStyleItem.Style.AlphaBlending
  else Result := CaptionStyle.AlphaBlending;
end;

function TdxNavBarGroupViewInfo.CaptionAlphaBlend2: Byte;
begin
  if (CaptionStyleItem <> nil) and (savAlphaBlending2 in CaptionStyleItem.Style.AssignedValues) then
    Result := CaptionStyleItem.Style.AlphaBlending2
  else Result := CaptionStyle.AlphaBlending2;
end;

function TdxNavBarGroupViewInfo.CaptionGradientMode: TdxBarStyleGradientMode;
begin
  if (CaptionStyleItem <> nil) and (savGradientMode in CaptionStyleItem.Style.AssignedValues) then
    Result := CaptionStyleItem.Style.GradientMode
  else Result := CaptionStyle.GradientMode;
end;

function TdxNavBarGroupViewInfo.CaptionFont: TFont;
begin
  Result := FCaptionFont;
  if (CaptionStyleItem <> nil) and (savFont in CaptionStyleItem.Style.AssignedValues) then
    Result.Assign(CaptionStyleItem.Style.Font)
  else Result.Assign(CaptionStyle.Font);
end;

function TdxNavBarGroupViewInfo.CaptionFontColor: TColor;
begin
  Result := CaptionFont.Color;
end;

function TdxNavBarGroupViewInfo.CaptionSignColor: TColor;
begin
  Result := CaptionFontColor;
end;

function TdxNavBarGroupViewInfo.CaptionHAlignment: TdxBarStyleHAlignment;
begin
  if (CaptionStyleItem <> nil) and (savHAlignment in CaptionStyleItem.Style.AssignedValues) then
    Result := CaptionStyleItem.Style.HAlignment
  else Result := CaptionStyle.HAlignment;
end;

function TdxNavBarGroupViewInfo.CaptionVAlignment: TdxBarStyleVAlignment;
begin
  if (CaptionStyleItem <> nil) and (savVAlignment in CaptionStyleItem.Style.AssignedValues) then
    Result := CaptionStyleItem.Style.VAlignment
  else Result := CaptionStyle.VAlignment;
end;

function TdxNavBarGroupViewInfo.ControlImage: TPicture;
begin
  if (Group.StyleControl <> nil) and (savImage in Group.StyleControl.Style.AssignedValues) then
    Result := Group.StyleControl.Style.Image
  else Result := NavBar.DefaultStyles.GroupControl.Image;
end;

function TdxNavBarGroupViewInfo.ControlBackColor: TColor;
begin
  if IsDefaultControlStyle then
    Result := BgBackColor
  else Result := GetControlBackColor;
end;

function TdxNavBarGroupViewInfo.ControlBackColor2: TColor;
begin
  if IsDefaultControlStyle then
    Result := BgBackColor2
  else Result := GetControlBackColor2;
end;

function TdxNavBarGroupViewInfo.ControlAlphaBlend: Byte;
begin
  if IsDefaultControlStyle then
    Result := BgAlphaBlend
  else if (Group.StyleControl <> nil) and (savAlphaBlending in Group.StyleControl.Style.AssignedValues) then
    Result := Group.StyleControl.Style.AlphaBlending
  else Result := NavBar.DefaultStyles.GroupControl.AlphaBlending;
end;

function TdxNavBarGroupViewInfo.ControlAlphaBlend2: Byte;
begin
  if IsDefaultControlStyle then
    Result := BgAlphaBlend2
  else if (Group.StyleControl <> nil) and (savAlphaBlending2 in Group.StyleControl.Style.AssignedValues) then
    Result := Group.StyleControl.Style.AlphaBlending2
  else Result := NavBar.DefaultStyles.GroupControl.AlphaBlending2;
end;

function TdxNavBarGroupViewInfo.ControlGradientMode: TdxBarStyleGradientMode;
begin
  if IsDefaultControlStyle then
    Result := BgGradientMode
  else if (Group.StyleControl <> nil) and (savGradientMode in Group.StyleControl.Style.AssignedValues) then
    Result := Group.StyleControl.Style.GradientMode
  else Result := NavBar.DefaultStyles.GroupControl.GradientMode;
end;

function TdxNavBarGroupViewInfo.ImageIndex: Integer;
begin
  if IsCaptionUseSmallImages then
    Result := Group.SmallImageIndex
  else Result := Group.LargeImageIndex;
end;

function TdxNavBarGroupViewInfo.ImageList: TCustomImageList;
begin
  if IsCaptionUseSmallImages then
    Result := NavBar.SmallImages
  else Result := NavBar.LargeImages;
end;

function TdxNavBarGroupViewInfo.GetCaptionHeight: Integer;
begin
  Result := ViewInfo.GetGroupCaptionHeightAddon;
  Inc(Result, GetFontHeight(CaptionFont));
end;

function TdxNavBarGroupViewInfo.GetDrawEdgeFlag: Integer;
const
  dxHAlignment: array[TdxBarStyleHAlignment] of Integer = (DT_LEFT, DT_CENTER, DT_RIGHT);
  dxVAlignment: array[TdxBarStyleVAlignment] of Integer = (DT_TOP, DT_VCENTER, DT_BOTTOM);
begin
  Result := dxHAlignment[CaptionHAlignment] or dxVAlignment[CaptionVAlignment] or
    DT_SINGLELINE or DT_END_ELLIPSIS;
end;

function TdxNavBarGroupViewInfo.GetImageHeight: Integer;
begin
  if IsCaptionUseSmallImages then
    Result := ViewInfo.GetSmallImageHeight
  else Result := ViewInfo.GetLargeImageHeight;
end;

function TdxNavBarGroupViewInfo.GetImageWidth: Integer;
begin
  if IsCaptionUseSmallImages then
    Result := ViewInfo.GetSmallImageWidth
  else Result := ViewInfo.GetLargeImageWidth;
end;

function TdxNavBarGroupViewInfo.IsCaptionVisible: Boolean;
begin
  Result := FCaptionVisible and NavBar.ShowGroupCaptions and
    (Group.ShowCaption or not ViewInfo.CanHasGroupWithNoCaption);
end;

function TdxNavBarGroupViewInfo.IsCaptionImageVisible: Boolean;
begin
  Result := ViewInfo.CanHasImageInGroupCaption and
    (FCaptionImageRect.Left >= FCaptionRect.Left) and
    (FCaptionImageRect.Right <= FCaptionRect.Right) and
    (not ViewInfo.CanHasSignInGroupCaption or
    (FCaptionImageRect.Right < FCaptionSignRect.Left));
end;

function TdxNavBarGroupViewInfo.IsCaptionSignVisible: Boolean;
begin
  Result := ViewInfo.CanHasSignInGroupCaption and
    (FCaptionSignRect.Left >= FCaptionRect.Left) and
    (FCaptionSignRect.Right <= FCaptionRect.Right)
end;

function TdxNavBarGroupViewInfo.IsCaptionUseSmallImages: Boolean;
begin
  Result := not ViewInfo.CanGroupsUseLargeImages or Group.UseSmallImages;
end;

function TdxNavBarGroupViewInfo.IsItemsVisible: Boolean;
begin
  Result := FItemsVisible and ViewInfo.CanHasVisibleItemsInGroup(Group);
end;

function TdxNavBarGroupViewInfo.IsLinksUseSmallImages: Boolean;
begin
  Result := not ViewInfo.CanLinksUseLargeImages or Group.LinksUseSmallImages;
end;

function TdxNavBarGroupViewInfo.IsViewAsIconView: Boolean;
begin
  Result := ViewInfo.CanHasGroupViewAsIconView and Group.ShowAsIconView;
end;

procedure TdxNavBarGroupViewInfo.AdjustControlBounds;
begin
  if Group.Control = nil then exit;
  if IsItemsVisible and Group.ShowControl then
    Group.Control.AdjustControl(ControlRect, True)
  else Group.Control.AdjustControl(CaptionRect, False);
end;

procedure TdxNavBarGroupViewInfo.CreateInfo;
var
  I: Integer;
begin
  ClearItems;
  if IsItemsVisible and (Control = nil) then
    for I := 0 to Group.LinkCount - 1 do
      if (Group.Links[I].Item <> nil) and Group.Links[I].Item.Visible then
        AddLink(ViewInfo, Group.Links[I], True, True);
end;

procedure TdxNavBarGroupViewInfo.CalculateBounds(X, Y: Integer);

  function HasScrollButtonInGroupCaption: Boolean;
  var
    AActiveIndex, AIndex: Integer;
  begin
    AIndex := ViewInfo.IndexOfGroupViewInfo(Self);
    AActiveIndex := ViewInfo.IndexOfGroupViewInfo(ViewInfo.ActiveGroupViewInfo);
    Result := ViewInfo.CanHasScrollButtonInGroupCaption and
      ((AIndex = AActiveIndex) or (AIndex = AActiveIndex + 1));
  end;

  procedure CalcImageRect;
  var
    ADelta, AHeightAddon: Integer;
  begin
    if ViewInfo.CanHasImageInGroupCaption then
    begin
      FCaptionImageRect.Left := FCaptionRect.Left + ViewInfo.GetGroupCaptionImageIndent;
      FCaptionImageRect.Bottom := FCaptionRect.Bottom;
      FCaptionImageRect.Right := FCaptionImageRect.Left + GetImageWidth;
      FCaptionImageRect.Top := FCaptionImageRect.Bottom - GetImageHeight;
      if ViewInfo.CanGroupCaptionBoundsByImage then
        AHeightAddon := ViewInfo.GetGroupCaptionHeightAddon
      else
        AHeightAddon := 0;
      if FCaptionImageRect.Top - 2 * AHeightAddon < FCaptionRect.Top then
      begin
        ADelta := FCaptionRect.Top + 2 * AHeightAddon - FCaptionImageRect.Top;
        Inc(FCaptionRect.Bottom, ADelta);
        Inc(FCaptionTextRect.Bottom, ADelta);
        if not ViewInfo.CanGroupCaptionBoundsByImage then
        begin
          Inc(FCaptionRect.Top, ADelta);
          Inc(FCaptionTextRect.Top, ADelta);
        end;
        OffsetRect(FCaptionImageRect, 0, ADelta - AHeightAddon);
      end
      else
      begin
        ADelta := cxRectHeight(FCaptionRect) div 2 - GetImageWidth div 2;
        OffsetRect(FCaptionImageRect, 0, -ADelta);
      end;
      FCaptionTextRect.Left := FCaptionImageRect.Right + ViewInfo.GetGroupCaptionTextIndent;
    end
    else
      FCaptionImageRect := cxNullRect;
  end;

  procedure CalcSignRect;
  var
    ADelta: Integer;
  begin
    if ViewInfo.CanHasSignInGroupCaption then
    begin
      ADelta := (cxRectHeight(FCaptionRect) - ViewInfo.GetGroupCaptionSignSize) div 2;
      FCaptionSignRect.Top := FCaptionRect.Top + ADelta + 1;
      FCaptionSignRect.Bottom := FCaptionSignRect.Top + ViewInfo.GetGroupCaptionSignSize;
      FCaptionSignRect.Right := FCaptionRect.Right - ADelta;
      FCaptionSignRect.Left := FCaptionSignRect.Right - ViewInfo.GetGroupCaptionSignSize;
      FCaptionTextRect.Right := FCaptionSignRect.Left - ADelta;//TODO
    end
    else
      FCaptionSignRect := cxNullRect;
  end;

  procedure CalcCaptionRect;
  begin
    FCaptionRect.Left := X;
    FCaptionRect.Top := Y;
    FCaptionRect.Right := ViewInfo.ClientWidth - X;
    if HasScrollButtonInGroupCaption then
      FCaptionRect.Right := FCaptionRect.Right - GetCaptionHeight - 2;

    if IsCaptionVisible then
    begin
      FCaptionRect.Bottom := Y + GetCaptionHeight;
      FCaptionTextRect := FCaptionRect;
      InflateRect(FCaptionTextRect, -2, -1);
      CalcImageRect;
      CalcSignRect;
    end
    else
      FCaptionRect.Bottom := FCaptionRect.Top;
  end;

  procedure CalcClientRect;
  var
    I: Integer;
    ItemStartX, ItemStartY, AItemsRectBottom, AClientHeight: Integer;
  begin
    FRect.TopLeft := FCaptionRect.TopLeft;
    FRect.Right := ViewInfo.ClientWidth - X;
    if IsItemsVisible then
    begin
      if Control <> nil then
      begin
        FRect.Bottom := FCaptionRect.Bottom + Control.OriginalHeight;
        Inc(FRect.Bottom, 2 * ViewInfo.GetGroupBorderWidth);
      end
      else
      begin
        AItemsRectBottom := FCaptionRect.Bottom + ViewInfo.GetGroupCaptionSeparatorWidth;
        ItemStartX := X;
        ItemStartY := AItemsRectBottom;
        for I := 0 to ItemCount - 1 do
        begin
          Items[I].CalculateBounds(ItemStartX, ItemStartY);
          if IsViewAsIconView then
          begin
            if (Items[I].Rect.Right > FCaptionRect.Right) and (I > 0) then
            begin
              ItemStartX := X;
              ItemStartY := Items[I].Rect.Bottom;
              Items[I].CalculateBounds(ItemStartX, ItemStartY);
            end;
            ItemStartX := Items[I].Rect.Right;
          end
          else
            ItemStartY := Items[I].Rect.Bottom;
          AItemsRectBottom := Items[I].Rect.Bottom;
        end;
        FRect.Bottom := AItemsRectBottom + ViewInfo.GetGroupCaptionSeparatorWidth;
      end;
    end
    else
      FRect.Bottom := FCaptionRect.Bottom;
    if Group.Expanded and Assigned(NavBar.OnCalcGroupClientHeight) then
    begin
      AClientHeight := cxRectHeight(FRect) - cxRectHeight(FCaptionRect);
      NavBar.OnCalcGroupClientHeight(NavBar, Self, AClientHeight);
      FRect.Bottom := FRect.Top + AClientHeight + cxRectHeight(FCaptionRect);
    end;
  end;

  procedure CalcItemsRect;
  begin
    FItemsRect.Left := FCaptionRect.Left;
    FItemsRect.Top := FCaptionRect.Bottom;
    FItemsRect.BottomRight := FRect.BottomRight;
  end;

begin
  CalcCaptionRect;
  CalcClientRect;
  CalcItemsRect;
end;

procedure TdxNavBarGroupViewInfo.CorrectBounds(dX, dY: Integer);
var
  I: Integer;
begin
  OffsetRect(FCaptionRect, dX, dY);
  OffsetRect(FRect, dX, dY);
  OffsetRect(FItemsRect, dX, dY);
  OffsetRect(FCaptionTextRect, dX, dY);
  OffsetRect(FCaptionImageRect, dX, dY);
  OffsetRect(FCaptionSignRect, dX, dY);
  for I := 0 to ItemCount - 1 do
    Items[I].CorrectBounds(dX, dY);
end;

procedure TdxNavBarGroupViewInfo.CorrectActiveGroupBounds(dX, dY: Integer);
var
  I, OffsetY: Integer;
  ALinkViewInfo: TdxNavBarLinkViewInfo;
begin
  FRect.Right := FRect.Right + dX;
  FRect.Bottom := FRect.Bottom + dY;
  FItemsRect.Right := FItemsRect.Right + dX;
  FItemsRect.Bottom := FItemsRect.Bottom + dY;
  OffsetY := 0;
  for I := 0 to Group.TopVisibleLinkIndex - 1 do
  begin
    ALinkViewInfo := ViewInfo.GetLinkViewInfoByLink(Group.Links[I]);
    if ALinkViewInfo <> nil then
      Inc(OffsetY, ALinkViewInfo.Rect.Bottom - ALinkViewInfo.Rect.Top);
  end;
  for I := 0 to ItemCount - 1 do
    Items[I].CorrectBounds(0, - OffsetY);
end;

function TdxNavBarGroupViewInfo.GetControl: TdxNavBarGroupControl;
begin
  if Group.ShowControl then
    Result := Group.Control
  else Result := nil;
end;

function TdxNavBarGroupViewInfo.GetControlBackColor: TColor;
begin
  if (Group.StyleControl <> nil) and (savBackColor in Group.StyleControl.Style.AssignedValues) then
    Result := Group.StyleControl.Style.BackColor
  else Result := NavBar.DefaultStyles.GroupControl.BackColor;
end;

function TdxNavBarGroupViewInfo.GetControlBackColor2: TColor;
begin
  if (Group.StyleControl <> nil) and (savBackColor2 in Group.StyleControl.Style.AssignedValues) then
    Result := Group.StyleControl.Style.BackColor2
  else Result := NavBar.DefaultStyles.GroupControl.BackColor2;
end;

function TdxNavBarGroupViewInfo.GetControlRect: TRect;
begin
  Result := ItemsRect;
  InflateRect(Result, -ViewInfo.GetGroupBorderWidth, -ViewInfo.GetGroupBorderWidth);
  if IsCaptionVisible then Result.Top := CaptionRect.Bottom;
end;

function TdxNavBarGroupViewInfo.GetItemCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxNavBarGroupViewInfo.GetItem(Index: Integer): TdxNavBarLinkViewInfo;
begin
  Result := TdxNavBarLinkViewInfo(FItems.Items[Index]);
end;

function TdxNavBarGroupViewInfo.GetState: TdxNavBarObjectStates;
begin
  Result := [];
  if Group = NavBar.PressedGroup then
    Result := Result + [sPressed];
  if Group = NavBar.HotTrackedGroup then
    Result := Result + [sHotTracked];
  if Group.Expanded then
    Result := Result + [sExpanded];
  if (Group = NavBar.ActiveGroup) and ViewInfo.CanHasActiveGroup then
    Result := Result + [sActive];
  if (Group = NavBar.ActiveGroup) and ViewInfo.CanHasSpecialGroup and NavBar.ShowSpecialGroup then
    Result := Result + [sSpecial];
end;

function TdxNavBarGroupViewInfo.IsDefaultControlStyle: Boolean;
begin
  Result := (GetControlBackColor = clNone) or (GetControlBackColor2 = clNone);
end;

procedure TdxNavBarGroupViewInfo.AddLink(AViewInfo: TdxNavBarViewInfo; ALink: TdxNavBarItemLink; ACaptionVisible, AImageVisisble: Boolean);
begin
  FItems.Add(Painter.CreateLinkViewInfo(self, ALink, ACaptionVisible, AImageVisisble));
end;

procedure TdxNavBarGroupViewInfo.ClearItems;
var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do Items[I].Free;
  FItems.Clear;
end;

{ TdxNavBarViewInfo }

constructor TdxNavBarViewInfo.Create(APainter: TdxNavBarPainter);
begin
  inherited Create;
  FPainter := APainter;
  FNavBar := FPainter.NavBar;
  FGroups := TList.Create;
  FHeaderFont := TFont.Create;
  CreateColors;
end;

destructor TdxNavBarViewInfo.Destroy;
begin
  ReleaseColors;
  FHeaderFont.Free;
  ClearGroups;
  FGroups.Free;
  inherited Destroy;
end;

function TdxNavBarViewInfo.ActiveGroupViewInfo: TdxNavBarGroupViewInfo;
begin
  if (NavBar.ActiveGroup <> nil) then
    Result := GetGroupViewInfoByGroup(NavBar.ActiveGroup)
  else Result := nil;
end;

function TdxNavBarViewInfo.GetGroupViewInfoByGroup(AGroup: TdxNavBarGroup): TdxNavBarGroupViewInfo;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to GroupCount - 1 do
    if Groups[I].Group = AGroup then
    begin
      Result := Groups[I];
      break;
    end;
end;

function TdxNavBarViewInfo.GetLinkViewInfoByLink(ALink: TdxNavBarItemLink): TdxNavBarLinkViewInfo;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to GroupCount - 1 do
  begin
    Result := Groups[I].GetLinkViewInfoByLink(ALink);
    if Result <> nil then break;
  end;
end;

function TdxNavBarViewInfo.IndexOfGroupViewInfo(AViewInfo: TdxNavBarGroupViewInfo): Integer;
begin
  Result := FGroups.IndexOf(AViewInfo);
end;

function TdxNavBarViewInfo.GetGroupViewInfoAtCaptionPos(pt: TPoint): TdxNavBarGroupViewInfo;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to GroupCount - 1 do
    if ptInRect(Groups[I].CaptionRect, pt) then
    begin
      Result := Groups[I];
      break;
    end;
end;

function TdxNavBarViewInfo.GetGroupAtCaptionPos(pt: TPoint): TdxNavBarGroup;
var
  AViewInfo: TdxNavBarGroupViewInfo;
begin
  AViewInfo := GetGroupViewInfoAtCaptionPos(pt);
  if (AViewInfo <> nil) and (AViewInfo.Group <> nil) and
    not (csDestroying in AViewInfo.Group.ComponentState) then
    Result := AViewInfo.Group
  else Result := nil;
end;

function TdxNavBarViewInfo.GetGroupViewInfoAtItemsPos(pt: TPoint): TdxNavBarGroupViewInfo;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to GroupCount - 1 do
    if ptInRect(Groups[I].Rect, pt) and not ptInRect(Groups[I].CaptionRect, pt) then
    begin
      Result := Groups[I];
      break;
    end;
end;

function TdxNavBarViewInfo.GetGroupAtItemsPos(pt: TPoint): TdxNavBarGroup;
var
  AViewInfo: TdxNavBarGroupViewInfo;
begin
  AViewInfo := GetGroupViewInfoAtItemsPos(pt);
  if (AViewInfo <> nil) and (AViewInfo.Group <> nil) and
    not (csDestroying in AViewInfo.Group.ComponentState) then
    Result := AViewInfo.Group
  else Result := nil;
end;

function TdxNavBarViewInfo.GetLinkViewInfoAtPos(pt: TPoint): TdxNavBarLinkViewInfo;
var
  I: Integer;
  AGroupViewInfo: TdxNavBarGroupViewInfo;
begin
  Result := nil;
  AGroupViewInfo := GetGroupViewInfoAtItemsPos(pt);
  if AGroupViewInfo <> nil then
    for I := 0 to AGroupViewInfo.ItemCount - 1 do
      if ptInRect(AGroupViewInfo.Items[I].Rect, pt) then
      begin
        Result := AGroupViewInfo.Items[I];
        break;
      end;
end;

function TdxNavBarViewInfo.GetLinkAtPos(pt: TPoint): TdxNavBarItemLink;
var
  AViewInfo: TdxNavBarLinkViewInfo;
begin
  AViewInfo := GetLinkViewInfoAtPos(pt);
  if (AViewInfo <> nil) and (AViewInfo.Link <> nil) and
    (AViewInfo.Link.Group <> nil) and (AViewInfo.Link.Item <> nil) then
    Result := AViewInfo.Link
  else Result := nil;
end;

function TdxNavBarViewInfo.GetLinkViewInfoAtSelectedPos(pt: TPoint): TdxNavBarLinkViewInfo;
var
  I: Integer;
  R: TRect;
  AGroupViewInfo: TdxNavBarGroupViewInfo;
begin
  Result := nil;
  if not (IsPtBottomScrollButton(pt) or IsPtTopScrollButton(pt)) then
  begin
    AGroupViewInfo := GetGroupViewInfoAtItemsPos(pt);
    if AGroupViewInfo <> nil then
      for I := 0 to AGroupViewInfo.ItemCount - 1 do
      begin
        if CanSelectLinkByRect then
        begin
          if ptInRect(AGroupViewInfo.Items[I].Rect, pt) then
          begin
            Result := AGroupViewInfo.Items[I];
            break;
          end;
        end
        else
        begin
          R := AGroupViewInfo.Items[I].CaptionRect;
          if AGroupViewInfo.IsLinksUseSmallImages then
            R.Left := AGroupViewInfo.Items[I].ImageRect.Right
          else R.Top := AGroupViewInfo.Items[I].ImageRect.Bottom;
          if ptInRect(AGroupViewInfo.Items[I].ImageRect, pt) or ptInRect(R, pt) then
          begin
            Result := AGroupViewInfo.Items[I];
            break;
          end;
        end;
      end;
  end;
end;

function TdxNavBarViewInfo.GetLinkAtSelectedPos(pt: TPoint): TdxNavBarItemLink;
var
  AViewInfo: TdxNavBarLinkViewInfo;
begin
  AViewInfo := GetLinkViewInfoAtSelectedPos(pt);
  if (AViewInfo <> nil) and (AViewInfo.Link <> nil) and
    (AViewInfo.Link.Group <> nil) and (AViewInfo.Link.Item <> nil) then
    Result := AViewInfo.Link
  else Result := nil;
end;

function TdxNavBarViewInfo.GetViewInfoAtDragPosition(pt: TPoint; var ItemGroup: TdxNavBarGroupViewInfo;
    var Item1, Item2: TdxNavBarLinkViewInfo): Integer;
var
  Index: Integer;
  ALinkViewInfo: TdxNavBarLinkViewInfo;
begin
  ItemGroup := nil;
  Item1 := nil;
  Item2 := nil;
  ItemGroup := GetGroupViewInfoAtItemsPos(pt);
  if ItemGroup <> nil then
  begin
    if ItemGroup.IsViewAsIconView then
      Result := GetViewInfoAtDragPositionWhenIconView(pt, ItemGroup, Item1, Item2)
    else
    begin
      ALinkViewInfo := GetLinkViewInfoAtPos(pt);
      if ALinkViewInfo <> nil then
      begin
        Index := ItemGroup.IndexOfLinkViewInfo(ALinkViewInfo);
        if (ALinkViewInfo.Rect.Top + (ALinkViewInfo.Rect.Bottom - ALinkViewInfo.Rect.Top) div 2) > pt.y then
        begin
          if Index > 0 then
            Item1 := ItemGroup.Items[Index - 1];
          Item2 := ALinkViewInfo
        end
        else
        begin
          Item1 := ALinkViewInfo;
          if Index < ItemGroup.ItemCount - 1 then
            Item2 := ItemGroup.Items[Index + 1];
        end;
      end
      else
      begin
        if ItemGroup.ItemCount > 0 then
        begin
          if pt.Y < ItemGroup.Items[0].Rect.Top then
            Item2 := ItemGroup.Items[0]
          else Item1 := ItemGroup.Items[ItemGroup.ItemCount - 1];
        end;
      end;
      if (Item1 <> nil) and (Item2 <> nil) then
        Result := Item2.Link.Index
      else if Item1 <> nil then
        Result := ItemGroup.Group.LinkCount
      else Result := 0;
    end;
  end
  else
  begin
    ItemGroup := GetGroupViewInfoAtCaptionPos(pt);
    if ItemGroup <> nil then
    begin
      if ItemGroup.ItemCount > 0 then
        Item2 := ItemGroup.Items[0];
      Result := 0;
    end
    else Result := -1;
  end;
end;

function TdxNavBarViewInfo.GetViewInfoAtDragPositionWhenIconView(pt: TPoint; var ItemGroup: TdxNavBarGroupViewInfo;
    var Item1, Item2: TdxNavBarLinkViewInfo): Integer;
var
  I, Index: Integer;
  ALinkViewInfo: TdxNavBarLinkViewInfo;
begin
  ItemGroup := nil;
  Item1 := nil;
  Item2 := nil;
  ItemGroup := GetGroupViewInfoAtItemsPos(pt);
  if ItemGroup <> nil then
  begin
    ALinkViewInfo := GetLinkViewInfoAtPos(pt);
    if ALinkViewInfo <> nil then
    begin
      Index := ItemGroup.IndexOfLinkViewInfo(ALinkViewInfo);
      if (ALinkViewInfo.Rect.Left + (ALinkViewInfo.Rect.Right - ALinkViewInfo.Rect.Left) div 2) > pt.x then
      begin
        if Index > 0 then
          Item1 := ItemGroup.Items[Index - 1];
        Item2 := ALinkViewInfo
      end
      else
      begin
        Item1 := ALinkViewInfo;
        if Index < ItemGroup.ItemCount - 1 then
          Item2 := ItemGroup.Items[Index + 1];
      end;
    end
    else
    begin
      if ItemGroup.ItemCount > 0 then
      begin
        if pt.Y < ItemGroup.Items[0].Rect.Top then
          Item2 := ItemGroup.Items[0]
        else if pt.Y > ItemGroup.Items[ItemGroup.ItemCount - 1].Rect.Top then
          Item1 := ItemGroup.Items[ItemGroup.ItemCount - 1]
        else for I := 0 to ItemGroup.ItemCount - 1 do
          if (pt.y > ItemGroup.Items[I].Rect.Top) and (pt.y < ItemGroup.Items[I].Rect.Bottom) then
          begin
            if pt.x > ItemGroup.Items[I].Rect.Right then
            begin
              Item1 := ItemGroup.Items[I];
              if I < ItemGroup.ItemCount - 1 then
                Item2 := ItemGroup.Items[I + 1];
            end
            else if pt.x < ItemGroup.Items[I].Rect.Right then
            begin
              Item2 := ItemGroup.Items[I];
              if I > 0 then
                Item1 := ItemGroup.Items[I - 1];
            end
          end;
      end;
    end;
    if (Item1 <> nil) and (Item2 <> nil) then
      Result := Item2.Link.Index
    else if Item1 <> nil then
      Result := ItemGroup.Group.LinkCount
    else Result := 0;
  end
  else Result := -1;
end;

function TdxNavBarViewInfo.GetLinksAtDragPosition(pt: TPoint; var ItemGroup: TdxNavBarGroup;
    var Item1, Item2: TdxNavBarItemLink): Integer;
var
  AGroupViewInfo: TdxNavBarGroupViewInfo;
  ALinkViewInfo1, ALinkViewInfo2: TdxNavBarLinkViewInfo;
begin
  Result := GetViewInfoAtDragPosition(pt, AGroupViewInfo, ALinkViewInfo1, ALinkViewInfo2);
  if (AGroupViewInfo <> nil) and (AGroupViewInfo.Group <> nil) and
    not (csDestroying in AGroupViewInfo.Group.ComponentState) then
    ItemGroup := AGroupViewInfo.Group
  else ItemGroup := nil;
  if (ALinkViewInfo1 <> nil) and (ALinkViewInfo1.Link <> nil) and
    (ALinkViewInfo1.Link.Group <> nil) and ((ALinkViewInfo1.Link.Item <> nil)) then
    Item1 := ALinkViewInfo1.Link
  else Item1 := nil;
  if (ALinkViewInfo2 <> nil) and (ALinkViewInfo2.Link <> nil) and
    (ALinkViewInfo2.Link.Group <> nil) and ((ALinkViewInfo2.Link.Item <> nil)) then
    Item2 := ALinkViewInfo2.Link
  else Item2 := nil;
end;

function TdxNavBarViewInfo.IsPtIncNavigationPaneOverflowPanelItemCount(pt: TPoint): Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.IsPtDecNavigationPaneOverflowPanelItemCount(pt: TPoint): Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.IsPtNavigationPaneOverflowPanelSign(pt: TPoint): Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.GetNavigationPaneOverflowPanelItemIndexAtPos(pt: TPoint): Integer;
begin
  Result := -1;
end;

function TdxNavBarViewInfo.GetNavigationPaneOverflowPanelGroupAtPos(pt: TPoint): TdxNavBarGroup;
begin
  Result := nil;
end;

function TdxNavBarViewInfo.IsTopScrollButtonVisible: Boolean;
begin
  Result := (FTopScrollButtonRect.Top <> FTopScrollButtonRect.Bottom) and
      (FTopScrollButtonRect.Left <> FTopScrollButtonRect.Right);
end;

function TdxNavBarViewInfo.IsBottomScrollButtonVisible: Boolean;
begin
  Result := (FBottomScrollButtonRect.Top <> FBottomScrollButtonRect.Bottom) and
      (FBottomScrollButtonRect.Left <> FBottomScrollButtonRect.Right);
end;

function TdxNavBarViewInfo.IsPtTopScrollButton(pt: TPoint): Boolean;
begin
  Result := PtInRect(FTopScrollButtonRect, pt);
end;

function TdxNavBarViewInfo.IsPtBottomScrollButton(pt: TPoint): Boolean;
begin
  Result := PtInRect(FBottomScrollButtonRect, pt);
end;

function TdxNavBarViewInfo.IsPtNavigationPaneHeader(pt: TPoint): Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.IsPtNavigationPaneSplitter(pt: TPoint): Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.IsPtNavigationPaneOverflowPanel(pt: TPoint): Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.BgImage: TPicture;
begin
  if (NavBar.StyleBackground <> nil) and (savImage in NavBar.StyleBackground.Style.AssignedValues) then
    Result := NavBar.StyleBackground.Style.Image
  else Result := NavBar.DefaultStyles.Background.Image;
end;

function TdxNavBarViewInfo.BgBackColor: TColor;
begin
  if (NavBar.StyleBackground <> nil) and (savBackColor in NavBar.StyleBackground.Style.AssignedValues) then
    Result := NavBar.StyleBackground.Style.BackColor
  else Result := NavBar.DefaultStyles.Background.BackColor;
end;

function TdxNavBarViewInfo.BgBackColor2: TColor;
begin
  if (NavBar.StyleBackground <> nil) and (savBackColor2 in NavBar.StyleBackground.Style.AssignedValues) then
    Result := NavBar.StyleBackground.Style.BackColor2
  else Result := NavBar.DefaultStyles.Background.BackColor2;
end;

function TdxNavBarViewInfo.BgAlphaBlend: Byte;
begin
  if (NavBar.StyleBackground <> nil) and (savAlphaBlending in NavBar.StyleBackground.Style.AssignedValues) then
    Result := NavBar.StyleBackground.Style.AlphaBlending
  else Result := NavBar.DefaultStyles.Background.AlphaBlending;
end;

function TdxNavBarViewInfo.BgAlphaBlend2: Byte;
begin
  if (NavBar.StyleBackground <> nil) and (savAlphaBlending2 in NavBar.StyleBackground.Style.AssignedValues) then
    Result := NavBar.StyleBackground.Style.AlphaBlending2
  else Result := NavBar.DefaultStyles.Background.AlphaBlending2;
end;

function TdxNavBarViewInfo.BgGradientMode: TdxBarStyleGradientMode;
begin
  if (NavBar.StyleBackground <> nil) and (savGradientMode in NavBar.StyleBackground.Style.AssignedValues) then
    Result := NavBar.StyleBackground.Style.GradientMode
  else Result := NavBar.DefaultStyles.Background.GradientMode;
end;

function TdxNavBarViewInfo.BorderColor: TColor;
begin
  Result := clNone;
end;

function TdxNavBarViewInfo.BottomScrollButtonStyleItem: TdxNavBarStyleItem;
begin
  if NavBar.ScrollButtonUpIsDown then
    Result := NavBar.StyleButtonPressed
  else if IsPtBottomScrollButton(NavBar.TargetPoint) then
    Result := NavBar.StyleButtonHotTracked
  else Result := NavBar.StyleButton;
end;

function TdxNavBarViewInfo.BottomScrollButtonStyle: TdxBaseNavBarStyle;
begin
  if NavBar.ScrollButtonUpIsDown then
    Result := NavBar.DefaultStyles.ButtonPressed
  else if IsPtBottomScrollButton(NavBar.TargetPoint) then
    Result := NavBar.DefaultStyles.ButtonHotTracked
  else Result := NavBar.DefaultStyles.Button;
end;

function TdxNavBarViewInfo.BottomScrollButtonImage: TPicture;
begin
  if (BottomScrollButtonStyleItem <> nil) and (savImage in BottomScrollButtonStyleItem.Style.AssignedValues) then
    Result := BottomScrollButtonStyleItem.Style.Image
  else Result := BottomScrollButtonStyle.Image;
end;

function TdxNavBarViewInfo.BottomScrollButtonBackColor: TColor;
begin
  if (BottomScrollButtonStyleItem <> nil) and (savBackColor in BottomScrollButtonStyleItem.Style.AssignedValues) then
    Result := BottomScrollButtonStyleItem.Style.BackColor
  else Result := BottomScrollButtonStyle.BackColor;
end;

function TdxNavBarViewInfo.BottomScrollButtonBackColor2: TColor;
begin
  if (BottomScrollButtonStyleItem <> nil) and (savBackColor2 in BottomScrollButtonStyleItem.Style.AssignedValues) then
    Result := BottomScrollButtonStyleItem.Style.BackColor2
  else Result := BottomScrollButtonStyle.BackColor2;
end;

function TdxNavBarViewInfo.BottomScrollButtonAlphaBlend: Byte;
begin
  if (BottomScrollButtonStyleItem <> nil) and (savAlphaBlending in BottomScrollButtonStyleItem.Style.AssignedValues) then
    Result := BottomScrollButtonStyleItem.Style.AlphaBlending
  else Result := BottomScrollButtonStyle.AlphaBlending;
end;

function TdxNavBarViewInfo.BottomScrollButtonAlphaBlend2: Byte;
begin
  if (BottomScrollButtonStyleItem <> nil) and (savAlphaBlending2 in BottomScrollButtonStyleItem.Style.AssignedValues) then
    Result := BottomScrollButtonStyleItem.Style.AlphaBlending2
  else Result := BottomScrollButtonStyle.AlphaBlending2;
end;

function TdxNavBarViewInfo.BottomScrollButtonGradientMode: TdxBarStyleGradientMode;
begin
  if (BottomScrollButtonStyleItem <> nil) and (savGradientMode in BottomScrollButtonStyleItem.Style.AssignedValues) then
    Result := BottomScrollButtonStyleItem.Style.GradientMode
  else Result := BottomScrollButtonStyle.GradientMode;
end;

function TdxNavBarViewInfo.TopScrollButtonStyleItem: TdxNavBarStyleItem;
begin
  if NavBar.ScrollButtonUpIsDown then
    Result := NavBar.StyleButtonPressed
  else if IsPtTopScrollButton(NavBar.TargetPoint) then
    Result := NavBar.StyleButtonHotTracked
  else Result := NavBar.StyleButton;
end;

function TdxNavBarViewInfo.TopScrollButtonStyle: TdxBaseNavBarStyle;
begin
  if NavBar.ScrollButtonUpIsDown then
    Result := NavBar.DefaultStyles.ButtonPressed
  else if IsPtTopScrollButton(NavBar.TargetPoint) then
    Result := NavBar.DefaultStyles.ButtonHotTracked
  else Result := NavBar.DefaultStyles.Button;
end;

function TdxNavBarViewInfo.TopScrollButtonImage: TPicture;
begin
  if (TopScrollButtonStyleItem <> nil) and (savImage in TopScrollButtonStyleItem.Style.AssignedValues) then
    Result := TopScrollButtonStyleItem.Style.Image
  else Result := TopScrollButtonStyle.Image;
end;

function TdxNavBarViewInfo.TopScrollButtonBackColor: TColor;
begin
  if (TopScrollButtonStyleItem <> nil) and (savBackColor in TopScrollButtonStyleItem.Style.AssignedValues) then
    Result := TopScrollButtonStyleItem.Style.BackColor
  else Result := TopScrollButtonStyle.BackColor;
end;

function TdxNavBarViewInfo.TopScrollButtonBackColor2: TColor;
begin
  if (TopScrollButtonStyleItem <> nil) and (savBackColor2 in TopScrollButtonStyleItem.Style.AssignedValues) then
    Result := TopScrollButtonStyleItem.Style.BackColor2
  else Result := TopScrollButtonStyle.BackColor2;
end;

function TdxNavBarViewInfo.TopScrollButtonAlphaBlend: Byte;
begin
  if (TopScrollButtonStyleItem <> nil) and (savAlphaBlending in TopScrollButtonStyleItem.Style.AssignedValues) then
    Result := TopScrollButtonStyleItem.Style.AlphaBlending
  else Result := TopScrollButtonStyle.AlphaBlending;
end;

function TdxNavBarViewInfo.TopScrollButtonAlphaBlend2: Byte;
begin
  if (TopScrollButtonStyleItem <> nil) and (savAlphaBlending2 in TopScrollButtonStyleItem.Style.AssignedValues) then
    Result := TopScrollButtonStyleItem.Style.AlphaBlending2
  else Result := TopScrollButtonStyle.AlphaBlending2;
end;

function TdxNavBarViewInfo.TopScrollButtonGradientMode: TdxBarStyleGradientMode;
begin
  if (TopScrollButtonStyleItem <> nil) and (savGradientMode in TopScrollButtonStyleItem.Style.AssignedValues) then
    Result := TopScrollButtonStyleItem.Style.GradientMode
  else Result := TopScrollButtonStyle.GradientMode;
end;

function TdxNavBarViewInfo.HintImage: TPicture;
begin
  if (NavBar.StyleHint <> nil) and (savImage in NavBar.StyleHint.Style.AssignedValues) then
    Result := NavBar.StyleHint.Style.Image
  else Result := NavBar.DefaultStyles.Hint.Image
end;

function TdxNavBarViewInfo.HintBackColor: TColor;
begin
  if (NavBar.StyleHint <> nil) and (savBackColor in NavBar.StyleHint.Style.AssignedValues) then
    Result := NavBar.StyleHint.Style.BackColor
  else Result := NavBar.DefaultStyles.Hint.BackColor;
end;

function TdxNavBarViewInfo.HintBackColor2: TColor;
begin
  if (NavBar.StyleHint <> nil) and (savBackColor2 in NavBar.StyleHint.Style.AssignedValues) then
    Result := NavBar.StyleHint.Style.BackColor2
  else Result := NavBar.DefaultStyles.Hint.BackColor2;
end;

function TdxNavBarViewInfo.HintAlphaBlend: Byte;
begin
  if (NavBar.StyleHint <> nil) and (savAlphaBlending in NavBar.StyleHint.Style.AssignedValues) then
    Result := NavBar.StyleHint.Style.AlphaBlending
  else Result := NavBar.DefaultStyles.Hint.AlphaBlending;
end;

function TdxNavBarViewInfo.HintAlphaBlend2: Byte;
begin
  if (NavBar.StyleHint <> nil) and (savAlphaBlending2 in NavBar.StyleHint.Style.AssignedValues) then
    Result := NavBar.StyleHint.Style.AlphaBlending2
  else Result := NavBar.DefaultStyles.Hint.AlphaBlending2;
end;

function TdxNavBarViewInfo.HintGradientMode: TdxBarStyleGradientMode;
begin
  if (NavBar.StyleHint <> nil) and (savGradientMode in NavBar.StyleHint.Style.AssignedValues) then
    Result := NavBar.StyleHint.Style.GradientMode
  else Result := NavBar.DefaultStyles.Hint.GradientMode;
end;

function TdxNavBarViewInfo.HintFont: TFont;
begin
  if (NavBar.StyleHint <> nil) and (savFont in NavBar.StyleHint.Style.AssignedValues) then
    Result := NavBar.StyleHint.Style.Font
  else Result := NavBar.DefaultStyles.Hint.Font;
end;

function TdxNavBarViewInfo.DragDropItemTargetBackColor: TColor;
begin
  if (NavBar.StyleDropTargetLink <> nil) and (savBackColor in NavBar.StyleDropTargetLink.Style.AssignedValues) then
    Result := NavBar.StyleDropTargetLink.Style.BackColor
  else Result := NavBar.DefaultStyles.DropTargetLink.BackColor;
end;

function TdxNavBarViewInfo.DragDropGroupTargetBackColor: TColor;
begin
  if (NavBar.StyleDropTargetGroup <> nil) and (savBackColor in NavBar.StyleDropTargetGroup.Style.AssignedValues) then
    Result := NavBar.StyleDropTargetGroup.Style.BackColor
  else Result := NavBar.DefaultStyles.DropTargetGroup.BackColor;
end;

function TdxNavBarViewInfo.DragDropGroupTargetBackColor2: TColor;
begin
  if (NavBar.StyleDropTargetGroup <> nil) and (savBackColor2 in NavBar.StyleDropTargetGroup.Style.AssignedValues) then
    Result := NavBar.StyleDropTargetGroup.Style.BackColor2
  else Result := NavBar.DefaultStyles.DropTargetGroup.BackColor2;
end;

function TdxNavBarViewInfo.DragDropGroupTargetAlphaBlend: Byte;
begin
  if (NavBar.StyleDropTargetGroup <> nil) and (savAlphaBlending in NavBar.StyleDropTargetGroup.Style.AssignedValues) then
    Result := NavBar.StyleDropTargetGroup.Style.AlphaBlending
  else Result := NavBar.DefaultStyles.DropTargetGroup.AlphaBlending;
end;

function TdxNavBarViewInfo.DragDropGroupTargetAlphaBlend2: Byte;
begin
  if (NavBar.StyleDropTargetGroup <> nil) and (savAlphaBlending2 in NavBar.StyleDropTargetGroup.Style.AssignedValues) then
    Result := NavBar.StyleDropTargetGroup.Style.AlphaBlending2
  else   Result := NavBar.DefaultStyles.DropTargetGroup.AlphaBlending2;
end;

function TdxNavBarViewInfo.DragDropGroupTargetGradient: TdxBarStyleGradientMode;
begin
  if (NavBar.StyleDropTargetGroup <> nil) and (savGradientMode in NavBar.StyleDropTargetGroup.Style.AssignedValues) then
    Result := NavBar.StyleDropTargetGroup.Style.GradientMode
  else Result := NavBar.DefaultStyles.DropTargetGroup.GradientMode;
end;

function TdxNavBarViewInfo.HeaderImage: TPicture;
begin
  if (NavBar.StyleNavigationPaneHeader <> nil) and (savImage in NavBar.StyleNavigationPaneHeader.Style.AssignedValues) then
    Result := NavBar.StyleNavigationPaneHeader.Style.Image
  else Result := NavBar.DefaultStyles.NavigationPaneHeader.Image
end;

function TdxNavBarViewInfo.HeaderBackColor: TColor;
begin
  if (NavBar.StyleNavigationPaneHeader <> nil) and (savBackColor in NavBar.StyleNavigationPaneHeader.Style.AssignedValues) then
    Result := NavBar.StyleNavigationPaneHeader.Style.BackColor
  else Result := NavBar.DefaultStyles.NavigationPaneHeader.BackColor;
end;

function TdxNavBarViewInfo.HeaderBackColor2: TColor;
begin
  if (NavBar.StyleNavigationPaneHeader <> nil) and (savBackColor2 in NavBar.StyleNavigationPaneHeader.Style.AssignedValues) then
    Result := NavBar.StyleNavigationPaneHeader.Style.BackColor2
  else Result := NavBar.DefaultStyles.NavigationPaneHeader.BackColor2;
end;

function TdxNavBarViewInfo.HeaderAlphaBlend: Byte;
begin
  if (NavBar.StyleNavigationPaneHeader <> nil) and (savAlphaBlending in NavBar.StyleNavigationPaneHeader.Style.AssignedValues) then
    Result := NavBar.StyleNavigationPaneHeader.Style.AlphaBlending
  else Result := NavBar.DefaultStyles.NavigationPaneHeader.AlphaBlending;
end;

function TdxNavBarViewInfo.HeaderAlphaBlend2: Byte;
begin
  if (NavBar.StyleNavigationPaneHeader <> nil) and (savAlphaBlending2 in NavBar.StyleNavigationPaneHeader.Style.AssignedValues) then
    Result := NavBar.StyleNavigationPaneHeader.Style.AlphaBlending2
  else   Result := NavBar.DefaultStyles.NavigationPaneHeader.AlphaBlending2;
end;

function TdxNavBarViewInfo.HeaderGradientMode: TdxBarStyleGradientMode;
begin
  if (NavBar.StyleNavigationPaneHeader <> nil) and (savGradientMode in NavBar.StyleNavigationPaneHeader.Style.AssignedValues) then
    Result := NavBar.StyleNavigationPaneHeader.Style.GradientMode
  else Result := NavBar.DefaultStyles.NavigationPaneHeader.GradientMode;
end;

function TdxNavBarViewInfo.HeaderFont: TFont;
begin
  Result := FHeaderFont;
  if (NavBar.StyleNavigationPaneHeader <> nil) and (savFont in NavBar.StyleNavigationPaneHeader.Style.AssignedValues) then
    Result.Assign(NavBar.StyleNavigationPaneHeader.Style.Font)
  else
    Result.Assign(NavBar.DefaultStyles.NavigationPaneHeader.Font);
end;

function TdxNavBarViewInfo.HeaderFontColor: TColor;
begin
  Result := HeaderFont.Color;
end;

function TdxNavBarViewInfo.HeaderHAlignment: TdxBarStyleHAlignment;
begin
  if (NavBar.StyleNavigationPaneHeader <> nil) and (savHAlignment in NavBar.StyleNavigationPaneHeader.Style.AssignedValues) then
    Result := NavBar.StyleNavigationPaneHeader.Style.HAlignment
  else Result := NavBar.DefaultStyles.NavigationPaneHeader.HAlignment;
end;

function TdxNavBarViewInfo.HeaderVAlignment: TdxBarStyleVAlignment;
begin
  if (NavBar.StyleNavigationPaneHeader <> nil) and (savVAlignment in NavBar.StyleNavigationPaneHeader.Style.AssignedValues) then
    Result := NavBar.StyleNavigationPaneHeader.Style.VAlignment
  else Result := NavBar.DefaultStyles.NavigationPaneHeader.VAlignment;
end;

function TdxNavBarViewInfo.HeaderDrawEdgeFlag: Integer;
const
  dxHAlignment: array[TdxBarStyleHAlignment] of Integer = (DT_LEFT, DT_CENTER, DT_RIGHT);
  dxVAlignment: array[TdxBarStyleVAlignment] of Integer = (DT_TOP, DT_VCENTER, DT_BOTTOM);
begin
  Result := dxHAlignment[HeaderHAlignment] or dxVAlignment[HeaderVAlignment] or
    DT_SINGLELINE or DT_END_ELLIPSIS;
end;

function TdxNavBarViewInfo.OverflowPanelImage: TPicture;
begin
  Result := NavBar.DefaultStyles.GroupHeader.Image;
end;

function TdxNavBarViewInfo.OverflowPanelBackColor: TColor;
begin
  Result := NavBar.DefaultStyles.GroupHeader.BackColor;
end;

function TdxNavBarViewInfo.OverflowPanelBackColor2: TColor;
begin
  Result := NavBar.DefaultStyles.GroupHeader.BackColor2;
end;

function TdxNavBarViewInfo.OverflowPanelAlphaBlend: Byte;
begin
  Result := NavBar.DefaultStyles.GroupHeader.AlphaBlending;
end;

function TdxNavBarViewInfo.OverflowPanelAlphaBlend2: Byte;
begin
  Result := NavBar.DefaultStyles.GroupHeader.AlphaBlending2;
end;

function TdxNavBarViewInfo.OverflowPanelGradientMode: TdxBarStyleGradientMode;
begin
  Result := NavBar.DefaultStyles.GroupHeader.GradientMode;
end;

function TdxNavBarViewInfo.OverflowPanelFont: TFont;
begin
  Result := NavBar.DefaultStyles.GroupHeader.Font;
end;

function TdxNavBarViewInfo.OverflowPanelFontColor: TColor;
begin
  Result := NavBar.DefaultStyles.GroupHeader.Font.Color;
end;

function TdxNavBarViewInfo.SplitterBackColor: TColor;
begin
  Result := HeaderBackColor;
end;

function TdxNavBarViewInfo.SplitterBackColor2: TColor;
begin
  Result := HeaderBackColor2;
end;

function TdxNavBarViewInfo.SplitterAlphaBlend: Byte;
begin
  Result := HeaderAlphaBlend;
end;

function TdxNavBarViewInfo.SplitterAlphaBlend2: Byte;
begin
  Result := HeaderAlphaBlend2;
end;

function TdxNavBarViewInfo.SplitterGradientMode: TdxBarStyleGradientMode;
begin
  Result := HeaderGradientMode;
end;

procedure TdxNavBarViewInfo.AssignDefaultBackgroundStyle;
begin
  NavBar.DefaultStyles.Background.ResetValues;
  NavBar.DefaultStyles.Background.BackColor := clAppWorkSpace;
  NavBar.DefaultStyles.Background.BackColor2 := clAppWorkSpace;
end;

procedure TdxNavBarViewInfo.AssignDefaultButtonStyle;
begin
  NavBar.DefaultStyles.Button.ResetValues;
  NavBar.DefaultStyles.Button.BackColor := clBtnFace;
  NavBar.DefaultStyles.Button.BackColor2 := clBtnFace;
end;

procedure TdxNavBarViewInfo.AssignDefaultButtonPressedStyle;
begin
  NavBar.DefaultStyles.ButtonPressed.Assign(NavBar.DefaultStyles.Button);
end;

procedure TdxNavBarViewInfo.AssignDefaultButtonHotTrackedStyle;
begin
  NavBar.DefaultStyles.ButtonHotTracked.Assign(NavBar.DefaultStyles.Button);
end;

procedure TdxNavBarViewInfo.AssignDefaultGroupControlStyle;
begin
  NavBar.DefaultStyles.GroupControl.ResetValues;
  NavBar.DefaultStyles.GroupControl.BackColor := clNone;
  NavBar.DefaultStyles.GroupControl.BackColor2 := clNone;
end;

procedure TdxNavBarViewInfo.AssignDefaultGroupBackgroundStyle;
begin
  NavBar.DefaultStyles.GroupBackground.ResetValues;
  NavBar.DefaultStyles.GroupBackground.BackColor := clAppWorkSpace;
  NavBar.DefaultStyles.GroupBackground.BackColor2 := clAppWorkSpace;
end;

procedure TdxNavBarViewInfo.AssignDefaultGroupHeaderStyle;
begin
  NavBar.DefaultStyles.GroupHeader.ResetValues;
  NavBar.DefaultStyles.GroupHeader.BackColor := clBtnFace;
  NavBar.DefaultStyles.GroupHeader.BackColor2 := clBtnFace;
  NavBar.DefaultStyles.GroupHeader.Font.Color := clBtnText;
  NavBar.DefaultStyles.GroupHeader.HAlignment := haCenter;
end;

procedure TdxNavBarViewInfo.AssignDefaultGroupHeaderActiveStyle;
begin
  NavBar.DefaultStyles.GroupHeaderActive.Assign(NavBar.DefaultStyles.GroupHeader);
end;

procedure TdxNavBarViewInfo.AssignDefaultGroupHeaderActiveHotTrackedStyle;
begin
  NavBar.DefaultStyles.GroupHeaderActiveHotTracked.Assign(NavBar.DefaultStyles.GroupHeaderActive);
end;

procedure TdxNavBarViewInfo.AssignDefaultGroupHeaderActivePressedStyle;
begin
  NavBar.DefaultStyles.GroupHeaderActivePressed.Assign(NavBar.DefaultStyles.GroupHeaderActive);
end;

procedure TdxNavBarViewInfo.AssignDefaultGroupHeaderHotTrackedStyle;
begin
  NavBar.DefaultStyles.GroupHeaderHotTracked.Assign(NavBar.DefaultStyles.GroupHeader);
end;

procedure TdxNavBarViewInfo.AssignDefaultGroupHeaderPressedStyle;
begin
  NavBar.DefaultStyles.GroupHeaderPressed.Assign(NavBar.DefaultStyles.GroupHeader);
end;

procedure TdxNavBarViewInfo.AssignDefaultHintStyle;
begin
  NavBar.DefaultStyles.Hint.ResetValues;
  NavBar.DefaultStyles.Hint.BackColor := clInfoBk;
  NavBar.DefaultStyles.Hint.BackColor2 := clInfoBk;
  NavBar.DefaultStyles.Hint.Font.Color := clInfoText;
  NavBar.DefaultStyles.Hint.HAlignment := haCenter;
end;

procedure TdxNavBarViewInfo.AssignDefaultItemStyle;
begin
  NavBar.DefaultStyles.Item.ResetValues;
  NavBar.DefaultStyles.Item.Font.Color := clBtnHighlight;
  NavBar.DefaultStyles.Item.HAlignment := haCenter;
end;

procedure TdxNavBarViewInfo.AssignDefaultItemDisabledStyle;
begin
  NavBar.DefaultStyles.ItemDisabled.Assign(NavBar.DefaultStyles.Item);
  NavBar.DefaultStyles.ItemDisabled.Font.Color := clBtnText;
end;

procedure TdxNavBarViewInfo.AssignDefaultItemHotTrackedStyle;
begin
  NavBar.DefaultStyles.ItemHotTracked.Assign(NavBar.DefaultStyles.Item);
end;

procedure TdxNavBarViewInfo.AssignDefaultItemPressedStyle;
begin
  NavBar.DefaultStyles.ItemPressed.Assign(NavBar.DefaultStyles.Item);
end;

procedure TdxNavBarViewInfo.AssignDefaultDropTargetGroupStyle;
begin
  NavBar.DefaultStyles.DropTargetGroup.ResetValues;
  NavBar.DefaultStyles.DropTargetGroup.BackColor := clHighlight;
  NavBar.DefaultStyles.DropTargetGroup.BackColor2 := clHighlight;
  NavBar.DefaultStyles.DropTargetGroup.AlphaBlending := 60;
  NavBar.DefaultStyles.DropTargetGroup.AlphaBlending2 := 60;
end;

procedure TdxNavBarViewInfo.AssignDefaultDropTargetLinkStyle;
begin
  NavBar.DefaultStyles.DropTargetLink.ResetValues;
  NavBar.DefaultStyles.DropTargetLink.BackColor := clBlack;
end;

procedure TdxNavBarViewInfo.AssignDefaultNavigationPaneHeaderStyle;
begin
  NavBar.DefaultStyles.NavigationPaneHeader.ResetValues;
end;

function TdxNavBarViewInfo.GetLargeImageHeight: Integer;
begin
  if (NavBar.LargeImages <> nil) then
    Result := NavBar.LargeImages.Height
  else Result := dxNavBarDefaultLargeImageHeight;
end;

function TdxNavBarViewInfo.GetLargeImageWidth: Integer;
begin
  if (NavBar.LargeImages <> nil) then
    Result := NavBar.LargeImages.Width
  else Result := dxNavBarDefaultLargeImageWidth;
end;

function TdxNavBarViewInfo.GetSmallImageHeight: Integer;
begin
  if (NavBar.SmallImages <> nil) then
    Result := NavBar.SmallImages.Height
  else Result := dxNavBarDefaultSmallImageHeight;
end;

function TdxNavBarViewInfo.GetSmallImageWidth: Integer;
begin
  if (NavBar.SmallImages <> nil) then
    Result := NavBar.SmallImages.Width
  else Result := dxNavBarDefaultSmallImageWidth;
end;

procedure TdxNavBarViewInfo.CreateColors;
begin
end;

procedure TdxNavBarViewInfo.RefreshColors;
begin
end;

procedure TdxNavBarViewInfo.ReleaseColors;
begin
end;

function TdxNavBarViewInfo.ClientHeight: Integer;
begin
  Result := NavBar.ClientHeight;
end;

function TdxNavBarViewInfo.ClientWidth: Integer;
begin
  Result := NavBar.ClientWidth;
end;

function TdxNavBarViewInfo.GetSpaceBetweenGroups: Integer;
begin
  if NavBar.SpaceBetweenGroups > 0 then
    Result := NavBar.SpaceBetweenGroups
  else Result := GetGroupSeparatorWidth;
end;

class function TdxNavBarViewInfo.GetGroupBorderWidth: Integer;
begin
  Result := 0;
end;

class function TdxNavBarViewInfo.GetGroupCaptionHeightAddon: Integer;
begin
  Result := 6;
end;

class function TdxNavBarViewInfo.GetGroupCaptionTextIndent: Integer;
begin
  Result := 4;
end;

class function TdxNavBarViewInfo.GetGroupCaptionImageIndent: Integer;
begin
  Result := 0;
end;

class function TdxNavBarViewInfo.GetGroupSeparatorWidth: Integer;
begin
  Result := 0;
end;

class function TdxNavBarViewInfo.GetGroupCaptionSignSize: Integer;
begin
  Result := 16;
end;

class function TdxNavBarViewInfo.GetGroupHorizontalEdge: Integer;
begin
  Result := 0;
end;

class function TdxNavBarViewInfo.GetGroupCaptionSeparatorWidth: Integer;
begin
  Result := 8;
end;

class function TdxNavBarViewInfo.GetLinksLargeSeparatorWidth: Integer;
begin
  Result := 6;
end;

class function TdxNavBarViewInfo.GetLinksSmallSeparatorWidth: Integer;
begin
  Result := 6;
end;

class function TdxNavBarViewInfo.GetLinksIconViewSeparatorWidth: Integer;
begin
  Result := 4;
end;

class function TdxNavBarViewInfo.GetLinksImageVerticalEdge: Integer;
begin
  Result := 4;
end;

class function TdxNavBarViewInfo.GetLinksImageHorizontalEdge: Integer;
begin
  Result := 4;
end;

class function TdxNavBarViewInfo.GetDragArrowHeight: Integer;
begin
  Result := 8;
end;

class function TdxNavBarViewInfo.GetDragArrowWidth: Integer;
begin
  Result := 6;
end;

class function TdxNavBarViewInfo.GetHeaderHeightAddon: Integer;
begin
  Result := 8;
end;

class function TdxNavBarViewInfo.GetScrollButtonVerticalEdge: Integer;
begin
  Result := 6;
end;

class function TdxNavBarViewInfo.GetScrollButtonHorizontalEdge: Integer;
begin
  Result := 6;
end;

class function TdxNavBarViewInfo.GetScrollButtonVerticalSize: Integer;
begin
  Result := 16;
end;

class function TdxNavBarViewInfo.GetScrollButtonHorizontalSize: Integer;
begin
  Result := 16;
end;

function TdxNavBarViewInfo.CanHasActiveGroup: Boolean;
begin
  Result := True;
end;

function TdxNavBarViewInfo.CanHasSpecialGroup: Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.CanHasScrollButtonInGroupCaption: Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.CanHasImageInGroupCaption: Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.CanHasSignInGroupCaption: Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.CanHasGroupViewAsIconView: Boolean;
begin
  Result := True;
end;

function TdxNavBarViewInfo.CanHasGroupWithNoCaption: Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.CanHasVisibleItemsInGroup(AGroup: TdxNavBarGroup): Boolean;
begin
  Result := AGroup = NavBar.ActiveGroup;
end;

function TdxNavBarViewInfo.CanGroupCaptionBoundsByImage: Boolean;
begin
  Result := False;
end;

function TdxNavBarViewInfo.CanGroupsUseLargeImages: Boolean;
begin
  Result := True;
end;

function TdxNavBarViewInfo.CanLinksUseLargeImages: Boolean;
begin
  Result := True;
end;

function TdxNavBarViewInfo.CanSelectLinkByRect: Boolean;
begin
  Result := False;
end;

procedure TdxNavBarViewInfo.RecalculateHint;
begin
  FHintText := '';
  SetRectEmpty(FHintRect);
  FHintText := GetHintText;
  FHintRect := GetHintRect;
end;

function TdxNavBarViewInfo.GetHintRect: TRect;
var
  AGroup: TdxNavBarGroup;
  ALink: TdxNavBarItemLink;
begin
  SetRectEmpty(Result);
  AGroup := GetGroupAtCaptionPos(NavBar.TargetPoint);
  if AGroup <> nil then
    Result := GetGroupHintRect(AGroup)
  else
  begin
    ALink := GetLinkAtSelectedPos(NavBar.TargetPoint);
    if ALink <> nil then
      Result := GetLinkHintRect(ALink);
  end;
end;

function TdxNavBarViewInfo.GetHintText: string;
var
  AGroup: TdxNavBarGroup;
  ALink: TdxNavBarItemLink;
begin
  Result := '';
  AGroup := GetGroupAtCaptionPos(NavBar.TargetPoint);
  if AGroup <> nil then
    Result := GetGroupHintText(AGroup)
  else
  begin
    ALink := GetLinkAtSelectedPos(NavBar.TargetPoint);
    if ALink <> nil then
      Result := GetLinkHintText(ALink);
  end;
end;

function TdxNavBarViewInfo.GetGroupHintRect(AGroup: TdxNavBarGroup): TRect;
var
  pt: TPoint;
begin
  Painter.HintWindowCanvas.Font := HintFont;
  Result := Rect(0, 0, ClientWidth, 0);
  cxDrawText(Painter.HintWindowDC, HintText, Result, DT_CALCRECT or DT_LEFT or
    DT_WORDBREAK or DT_NOPREFIX);
  Inc(Result.Right, dxNavBarHintWindowSizeCorrection);
  Inc(Result.Bottom, dxNavBarHintWindowSizeCorrection);
  if Assigned(NavBar.OnCalcGroupHintRect) then
    NavBar.OnCalcGroupHintRect(NavBar, AGroup, Self, Result);
  pt := NavBar.ClientToScreen(NavBar.TargetPoint);
  OffsetRect(Result, pt.X + 20, pt.Y);
end;

function TdxNavBarViewInfo.GetLinkHintRect(ALink: TdxNavBarItemLink): TRect;
var
  pt: TPoint;
begin
  Painter.HintWindowCanvas.Font := HintFont;
  Result := Rect(0, 0, ClientWidth, 0);
  cxDrawText(Painter.HintWindowDC, HintText, Result, DT_CALCRECT or DT_LEFT or
    DT_WORDBREAK or DT_NOPREFIX);
  Inc(Result.Right, dxNavBarHintWindowSizeCorrection);
  Inc(Result.Bottom, dxNavBarHintWindowSizeCorrection);
  if Assigned(NavBar.OnCalcLinkHintRect) then
    NavBar.OnCalcLinkHintRect(NavBar, ALink, Self, Result);
  pt := NavBar.ClientToScreen(NavBar.TargetPoint);
  OffsetRect(Result, pt.X + 20, pt.Y);
end;

function TdxNavBarViewInfo.GetGroupHintText(AGroup: TdxNavBarGroup): string;
begin
  Result := AGroup.Hint;
  if Assigned(NavBar.OnGetGroupHint) then
    NavBar.OnGetGroupHint(NavBar, AGroup, Result);
  Result := GetShortHint(Result);
end;

function TdxNavBarViewInfo.GetLinkHintText(ALink: TdxNavBarItemLink): string;
begin
  Result := ALink.Item.Hint;
  if Assigned(NavBar.OnGetLinkHint) then
    NavBar.OnGetLinkHint(NavBar, ALink, Result);
  Result := GetShortHint(Result);
end;

function TdxNavBarViewInfo.HintDelay: Integer;
begin
  Result := dxNavBarHintShowingInterval;
end;

procedure TdxNavBarViewInfo.DoGroupActiveToggle(AGroup: TdxNavBarGroup);
begin
  if IsGroupActive(AGroup) then
    DoGroupDeactivate(AGroup)
  else DoGroupActivate(AGroup);
end;

procedure TdxNavBarViewInfo.DoGroupActivate(AGroup: TdxNavBarGroup);
begin
end;

procedure TdxNavBarViewInfo.DoGroupDeactivate(AGroup: TdxNavBarGroup);
begin
end;

procedure TdxNavBarViewInfo.DoShowPopupMenu(X, Y: Integer);
begin
end;

function TdxNavBarViewInfo.IsGroupActive(AGroup: TdxNavBarGroup): Boolean;
begin
  Result := False;
end;

procedure TdxNavBarViewInfo.MakeLinkVisible(ALink: TdxNavBarItemLink);
begin
end;

procedure TdxNavBarViewInfo.MakeGroupVisible(AGroup: TdxNavBarGroup);
begin
end;

procedure TdxNavBarViewInfo.AdjustControlsBounds;
var
  I: Integer;
  AGroup: TdxNavBarGroup;
  AViewInfo: TdxNavBarGroupViewInfo;
  R: TRect;
begin
  for I := 0 to NavBar.Groups.Count - 1 do
  begin
    AGroup := NavBar.Groups[I];
    AViewInfo := GetGroupViewInfoByGroup(AGroup);
    if AViewInfo <> nil then
        AViewInfo.AdjustControlBounds
    else if AGroup.Control <> nil then
    begin
      R := NavBar.BoundsRect;
      OffsetRect(R, -R.Left, -R.Top);
      AGroup.Control.AdjustControl(R, False);
    end;
  end;
end;

function TdxNavBarViewInfo.GetBoundsUpdateType: TdxNavBarChangeType;
begin
  Result := doRecalc;
end;

procedure TdxNavBarViewInfo.CreateInfo;
var
  I: Integer;
begin
  ClearGroups;
  if NavBar.ShowGroupCaptions then
  begin
    for I := 0 to NavBar.Groups.Count - 1 do
      if NavBar.Groups[I].Visible then
        AddGroup(Self, NavBar.Groups[I], True, True);
  end
  else if NavBar.ActiveGroup <> nil then
    AddGroup(Self, NavBar.ActiveGroup, True, True);
end;

procedure TdxNavBarViewInfo.CalculateBounds;
var
  I, Y: Integer;
begin
  ClearRects;
  Y := GetSpaceBetweenGroups;
  for I := 0 to GroupCount - 1 do
  begin
    Groups[I].CalculateBounds(GetGroupHorizontalEdge, Y);
    Y := Groups[I].Rect.Bottom + GetSpaceBetweenGroups;
  end;
end;

procedure TdxNavBarViewInfo.CalculateScrollButtonsBounds;
begin
  if ActiveGroupViewInfo = nil then exit;
  FTopScrollButtonRect := GetTopScrollButtonRect;
  FBottomScrollButtonRect := GetBottomScrollButtonRect;
end;

procedure TdxNavBarViewInfo.ClearRects;
begin
  SetRectEmpty(FTopScrollButtonRect);
  SetRectEmpty(FBottomScrollButtonRect);
  SetRectEmpty(FHintRect);
end;

function TdxNavBarViewInfo.GetTopScrollButtonRect: TRect;
begin
  SetRectEmpty(Result);
  if not (sDisabled in TopScrollButtonState) then
  begin
    Result := ActiveGroupViewInfo.ItemsRect;
    Result.Left := Result.Right - GetScrollButtonHorizontalSize;
    Result.Bottom := Result.Top + GetScrollButtonVerticalSize;
    OffSetRect(Result, - GetScrollButtonHorizontalEdge, GetScrollButtonVerticalEdge);
  end;
end;

function TdxNavBarViewInfo.GetBottomScrollButtonRect: TRect;
begin
  SetRectEmpty(Result);
  if not (sDisabled in BottomScrollButtonState) then
  begin
    Result := ActiveGroupViewInfo.ItemsRect;
    Result.Left := Result.Right - GetScrollButtonHorizontalSize;
    Result.Bottom := Result.Top + GetScrollButtonVerticalSize;
    OffSetRect(Result, - GetScrollButtonHorizontalEdge, - GetScrollButtonVerticalEdge);
    OffSetRect(Result, 0, ActiveGroupViewInfo.ItemsRect.Bottom -
        ActiveGroupViewInfo.ItemsRect.Top - GetScrollButtonVerticalSize);
  end;
end;

function TdxNavBarViewInfo.GetGroupCount: Integer;
begin
  Result := FGroups.Count;
end;

function TdxNavBarViewInfo.GetGroup(Index: Integer): TdxNavBarGroupViewInfo;
begin
  Result := TdxNavBarGroupViewInfo(FGroups.Items[Index]);
end;

procedure TdxNavBarViewInfo.AddGroup(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup; ACaptionVisible, AItemsVisible: Boolean);
begin
  FGroups.Add(Painter.CreateGroupViewInfo(AViewInfo, AGroup, ACaptionVisible, AItemsVisible));
end;

procedure TdxNavBarViewInfo.RemoveGroup(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  FGroups.Remove(AGroupViewInfo);
end;

procedure TdxNavBarViewInfo.ClearGroups;
var
  I: Integer;
begin
  for I := 0 to GroupCount - 1 do Groups[I].Free;
  FGroups.Clear;
end;

function TdxNavBarViewInfo.GetBottomScrollButtonState: TdxNavBarObjectStates;
begin
  Result := [];
  if NavBar.ScrollButtonDownIsDown then
    Result := Result + [sPressed];
  if not ((ActiveGroupViewInfo <> nil) and (ActiveGroupViewInfo.ItemCount > 0) and
    (ActiveGroupViewInfo.Items[ActiveGroupViewInfo.ItemCount - 1].Rect.Bottom >
    ActiveGroupViewInfo.Rect.Bottom) and
    (ActiveGroupViewInfo.Group.TopVisibleLinkIndex < ActiveGroupViewInfo.ItemCount - 1)) then
    Result := Result + [sDisabled];
  if IsPtBottomScrollButton(NavBar.TargetPoint) then
    Result := Result + [sHotTracked];
end;

function TdxNavBarViewInfo.GetTopScrollButtonState: TdxNavBarObjectStates;
begin
  Result := [];
  if NavBar.ScrollButtonUpIsDown then
    Result := Result + [sPressed];
  if not ((ActiveGroupViewInfo <> nil) and (ActiveGroupViewInfo.ItemCount > 0) and
    (ActiveGroupViewInfo.Group.TopVisibleLinkIndex > 0)) then
    Result := Result + [sDisabled];
  if IsPtTopScrollButton(NavBar.TargetPoint) then
    Result := Result + [sHotTracked];
end;

{ TdxBaseImagePainter }

class procedure TdxBaseImagePainter.DrawImage(ACanvas: TCanvas;
  AImageList: TCustomImageList; AImageIndex: Integer; ARect: TRect; AEnabled: Boolean);
begin
  InternalDrawImage(ACanvas, AImageList, AImageIndex, ARect, AEnabled);
end;

class function TdxBaseImagePainter.IsValidImage(AImageList: TCustomImageList;AImageIndex: Integer): Boolean;
begin
  Result := (AImageList <> nil) and (0 <= AImageIndex) and (AImageIndex < AImageList.Count);
end;

class procedure TdxBaseImagePainter.InternalDrawImage(ACanvas: TCanvas;
  AImageList: TCustomImageList; AImageIndex: Integer; ARect: TRect; AEnabled: Boolean);
begin
end;

{ TdxBaseSelectionPainter }

class procedure TdxBaseSelectionPainter.DrawSelection(ACanvas: TCanvas;
  ARect: TRect; ABackColor: TColor; AState: TdxNavBarObjectStates);
begin
  InternalDrawSelection(ACanvas, ARect, ABackColor, AState);
end;

class procedure TdxBaseSelectionPainter.InternalDrawSelection(
  ACanvas: TCanvas; ARect: TRect; ABackColor: TColor;
  AState: TdxNavBarObjectStates);
begin

end;

{ TdxBaseBackgroundPainter }

class procedure TdxBaseBackgroundPainter.DrawBackground(ACanvas: TCanvas; ARect: TRect;
  APicture: TPicture; AEraseBackground: Boolean; ABackgroundColor: TColor;
  AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode);
begin
  InternalDrawBackground(ACanvas, ARect, APicture, AEraseBackground, ABackgroundColor,
    AColor1, AColor2, AAlphaBlend1, AAlphaBlend2, AGradientMode);
end;

class procedure TdxBaseBackgroundPainter.InternalDrawBackground(ACanvas: TCanvas; ARect: TRect;
  APicture: TPicture; AEraseBackground: Boolean; ABackgroundColor: TColor;
  AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode);
begin

end;

{ TdxBaseGroupBackgroundPainter }

class procedure TdxBaseGroupBackgroundPainter.InternalDrawBackground(ACanvas: TCanvas; ARect:
  TRect; APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode);
begin
end;

class procedure TdxBaseGroupBackgroundPainter.DrawBackground(ACanvas: TCanvas;
  ARect: TRect; APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode);
begin
  InternalDrawBackground(ACanvas, ARect, APicture, AColor1, AColor2,
    AAlphaBlend1, AAlphaBlend2, AGradientMode);
end;

{ TdxBaseGroupBorderPainter }

class procedure TdxBaseGroupBorderPainter.InternalDrawBorder(ACanvas: TCanvas;
  ARect: TRect; AColor: TColor; AWithCaption: Boolean);
begin
end;

class procedure TdxBaseGroupBorderPainter.DrawBorder(ACanvas: TCanvas;
  ARect: TRect; AColor: TColor; AWithCaption: Boolean);
begin
  InternalDrawBorder(ACanvas, ARect, AColor, AWithCaption);
end;

{ TdxBaseSignPainter }

class procedure TdxBaseSignPainter.DrawSign(ACanvas: TCanvas; ARect: TRect;
  AForeColor, ABackColor1, ABackColor2: TColor; AState: TdxNavBarObjectStates);
begin
  InternalDrawSign(ACanvas, ARect, AForeColor, ABackColor1, ABackColor2, AState);
end;

class procedure TdxBaseSignPainter.InternalDrawSign(ACanvas: TCanvas; ARect: TRect;
  AForeColor, ABackColor1, ABackColor2: TColor; AState: TdxNavBarObjectStates);
begin

end;

{ TdxBaseHintPainter }

class procedure TdxBaseHintPainter.DrawHint(ACanvas: TCanvas; ARect: TRect;
  AHint: string; APicture: TPicture; AColor1, AColor2: TColor;
  AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
  AFont: TFont);
begin
  InternalDrawHint(ACanvas, ARect, AHint, APicture, AColor1, AColor2,
    AAlphaBlend1, AAlphaBlend2, AGradientMode, AFont);
end;

class procedure TdxBaseHintPainter.InternalDrawHint(ACanvas: TCanvas;
  ARect: TRect; AHint: string; APicture: TPicture; AColor1,
  AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode; AFont: TFont);
begin

end;

{ TdxBaseButtonPainter }

class procedure TdxBaseButtonPainter.DrawButton(ACanvas: TCanvas;
  ARect: TRect; APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1,
  AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
  ABorderColor: TColor; AState: TdxNavBarObjectStates);
begin
  InternalDrawButton(ACanvas, ARect, APicture, AColor1, AColor2,
    AAlphaBlend1, AAlphaBlend2, AGradientMode, ABorderColor, AState);
end;

class procedure TdxBaseButtonPainter.InternalDrawButton(ACanvas: TCanvas;
  ARect: TRect; APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1,
  AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
  ABorderColor: TColor; AState: TdxNavBarObjectStates);
begin

end;

{ TdxBaseScrollButtonsPainter }

class procedure TdxBaseScrollButtonsPainter.DrawBottomButton(
  ACanvas: TCanvas; ARect: TRect;
  AButtonPainterClass: TdxBaseButtonPainterClass; AColor1, AColor2: TColor;
  AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
  ABorderColor: TColor; AState: TdxNavBarObjectStates);
begin
  InternalDrawBottomButton(ACanvas, ARect, AButtonPainterClass, AColor1, AColor2,
    AAlphaBlend1, AAlphaBlend2, AGradientMode, ABorderColor, AState);
end;

class procedure TdxBaseScrollButtonsPainter.DrawTopButton(ACanvas: TCanvas;
  ARect: TRect; AButtonPainterClass: TdxBaseButtonPainterClass; AColor1,
  AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
  ABorderColor: TColor; AState: TdxNavBarObjectStates);
begin
  InternalDrawTopButton(ACanvas, ARect, AButtonPainterClass, AColor1, AColor2,
    AAlphaBlend1, AAlphaBlend2, AGradientMode, ABorderColor, AState);
end;

class procedure TdxBaseScrollButtonsPainter.InternalDrawBottomButton(
  ACanvas: TCanvas; ARect: TRect;
  AButtonPainterClass: TdxBaseButtonPainterClass; AColor1, AColor2: TColor;
  AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
  ABorderColor: TColor; AState: TdxNavBarObjectStates);
begin

end;

class procedure TdxBaseScrollButtonsPainter.InternalDrawTopButton(
  ACanvas: TCanvas; ARect: TRect;
  AButtonPainterClass: TdxBaseButtonPainterClass; AColor1, AColor2: TColor;
  AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
  ABorderColor: TColor; AState: TdxNavBarObjectStates);
begin

end;

{ TdxBaseDropTargetLinkPainter }

class procedure TdxBaseDropTargetLinkPainter.DrawTargetLink(
  ACanvas: TCanvas; pt1, pt2, pt3, pt4, pt5, pt6: TPoint; AColor: TColor);
begin
  InternalDrawTargetLink(ACanvas, pt1, pt2, pt3, pt4, pt5, pt6, AColor);
end;

class procedure TdxBaseDropTargetLinkPainter.InternalDrawTargetLink(
  ACanvas: TCanvas; pt1, pt2, pt3, pt4, pt5, pt6: TPoint; AColor: TColor);
begin

end;

{ TdxBaseDropTargetGroupPainter }

class procedure TdxBaseDropTargetGroupPainter.DrawTargetGroup(ACanvas: TCanvas;
  ARect: TRect; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode);
begin
  InternalDrawTargetGroup(ACanvas, ARect, AColor1, AColor2,
    AAlphaBlend1, AAlphaBlend2, AGradientMode);
end;

class procedure TdxBaseDropTargetGroupPainter.InternalDrawTargetGroup(
  ACanvas: TCanvas; ARect: TRect; AColor1, AColor2: TColor; AAlphaBlend1,
  AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode);
begin

end;

{ TdxNavBarPainter }

constructor TdxNavBarPainter.Create(ANavBar: TdxCustomNavBar);
begin
  inherited Create;
  FNavBar := ANavBar;
  FViewInfo := CreateViewInfo;

  FNeedRecreateViewInfo := True;
  FNeedRecalculateViewInfo := True;
  FNeedRedrawCanvas := True;
end;

destructor TdxNavBarPainter.Destroy;
begin
  FViewInfo.Free;
  inherited;
end;

function TdxNavBarPainter.Canvas: TCanvas;
begin
  Result := NavBar.CanvasBitmap.Canvas;
end;

function TdxNavBarPainter.DC: HDC;
begin
  Result := Canvas.Handle;
end;

function TdxNavBarPainter.HintWindowCanvas: TCanvas;
begin
  Result := NavBar.HintWindow.Canvas;
end;

function TdxNavBarPainter.HintWindowDC: HDC;
begin
  Result := HintWindowCanvas.Handle;
end;

procedure TdxNavBarPainter.InvalidateViewInfo(AType: TdxNavBarChangeType);
begin
  if AType = doRecreate then
  begin
    FNeedRecreateViewInfo := True;
    FNeedRecalculateViewInfo := True;
  end
  else if AType = doRecalc then
    FNeedRecalculateViewInfo := True;
  FNeedRedrawCanvas := True;
end;

procedure TdxNavBarPainter.Paint;
{var
  I: Integer;}
begin
  CheckDrawParamChanges;
{  for I := 0 to ViewInfo.GroupCount - 1 do
    if (ViewInfo.Groups[I].Control <> nil) and ViewInfo.Groups[I].Control.Visible and
      (ViewInfo.Groups[I].ControlRect.Bottom > ViewInfo.Groups[I].ControlRect.Top) then
        with ViewInfo.Groups[I].ControlRect do
          ExcludeClipRect(NavBar.Canvas.Handle, Left, Top, Right, Bottom);}
  BitBlt(NavBar.Canvas.Handle, 0, 0, ViewInfo.ClientWidth, ViewInfo.ClientHeight, DC, 0, 0, SRCCOPY);
  SelectClipRgn(DC, 0);
end;

procedure TdxNavBarPainter.InvalidateScrollButtons;
begin
  if ViewInfo.IsTopScrollButtonVisible then
    Windows.InvalidateRect(NavBar.Handle, @ViewInfo.TopScrollButtonRect, True);
  if ViewInfo.IsBottomScrollButtonVisible then
    Windows.InvalidateRect(NavBar.Handle, @ViewInfo.BottomScrollButtonRect, True);
end;

function TdxNavBarPainter.CreateViewInfo: TdxNavBarViewInfo;
begin
  Result := TdxNavBarViewInfo.Create(Self);
end;

function TdxNavBarPainter.CreateGroupViewInfo(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup;
  ACaptionVisible, AItemsVisible: Boolean): TdxNavBarGroupViewInfo;
begin
  Result := TdxNavBarGroupViewInfo.Create(AViewInfo, AGroup, ACaptionVisible, AItemsVisible);
end;

function TdxNavBarPainter.CreateLinkViewInfo(AViewInfo: TdxNavBarGroupViewInfo; ALink: TdxNavBarItemLink;
  ACaptionVisible, AImageVisisble: Boolean): TdxNavBarLinkViewInfo;
begin
  Result := TdxNavBarLinkViewInfo.Create(AViewInfo, ALink, ACaptionVisible, AImageVisisble);
end;

function TdxNavBarPainter.GetMasterLookAndFeel: TcxLookAndFeel;
begin
  Result := nil;
end;

procedure TdxNavBarPainter.CheckDrawParamChanges;
begin
  if NavBar.UpdateLock = 0 then
  begin
    if NavBar.CanvasBitmap.Width = 0 then
      NavBar.CanvasBitmap.Width := NavBar.ClientWidth;
    if NavBar.CanvasBitmap.Height = 0 then
      NavBar.CanvasBitmap.Height := NavBar.ClientHeight;

    if FNeedRecreateViewInfo then ViewInfo.CreateInfo;
    if FNeedRecalculateViewInfo then ViewInfo.CalculateBounds;
    if FNeedRedrawCanvas then DrawNavBarControl;
  end;
  FNeedRecreateViewInfo := False;
  FNeedRecalculateViewInfo := False;
  FNeedRedrawCanvas := False;
end;

function TdxNavBarPainter.GetOwner: TPersistent;
begin
  Result := FNavBar;
end;

function TdxNavBarPainter.IsViewInfoValid: Boolean;
begin
  Result := not FNeedRecalculateViewInfo;
end;

class function TdxNavBarPainter.BackgroundPainterClass: TdxBaseBackgroundPainterClass;
begin
  Result := TdxBaseBackgroundPainter;
end;

class function TdxNavBarPainter.GroupBackgroundPainterClass: TdxBaseGroupBackgroundPainterClass;
begin
  Result := TdxBaseGroupBackgroundPainter;
end;

class function TdxNavBarPainter.GroupBorderPainterClass: TdxBaseGroupBorderPainterClass;
begin
  Result := TdxBaseGroupBorderPainter;
end;

class function TdxNavBarPainter.ButtonPainterClass: TdxBaseButtonPainterClass;
begin
  Result := TdxBaseButtonPainter;
end;

class function TdxNavBarPainter.DropTargetGroupPainterClass: TdxBaseDropTargetGroupPainterClass;
begin
  Result := TdxBaseDropTargetGroupPainter;
end;

class function TdxNavBarPainter.DropTargetLinkPainterClass: TdxBaseDropTargetLinkPainterClass;
begin
  Result := TdxBaseDropTargetLinkPainter;
end;

class function TdxNavBarPainter.ScrollButtonsPainterClass: TdxBaseScrollButtonsPainterClass;
begin
  Result := TdxBaseScrollButtonsPainter;
end;

class function TdxNavBarPainter.ImagePainterClass: TdxBaseImagePainterClass;
begin
  Result := TdxBaseImagePainter;
end;

class function TdxNavBarPainter.SelectionPainterClass: TdxBaseSelectionPainterClass;
begin
  Result := TdxBaseSelectionPainter;
end;

class function TdxNavBarPainter.SignPainterClass: TdxBaseSignPainterClass;
begin
  Result := TdxBaseSignPainter;
end;

procedure TdxNavBarPainter.DrawNavBarControl;
var
  I: Integer;
  AHandled: Boolean;
begin
  AHandled := False;
  if Assigned(NavBar.OnCustomDrawBackground) then
    NavBar.OnCustomDrawBackground(NavBar, Canvas, ViewInfo, AHandled);
  if not AHandled then DrawBackground;
  for I := 0 to ViewInfo.GroupCount - 1 do
    if RectVisible(Canvas.Handle, ViewInfo.Groups[I].Rect) then
      DrawGroup(ViewInfo.Groups[I]);
  DrawScrollButtons;
  DrawDropTargetGroupSelection;
  DrawDropTargetLinkSelection;
end;

procedure TdxNavBarPainter.DrawBackground;
begin
  with ViewInfo do
    BackgroundPainterClass.DrawBackground(Canvas, NavBar.ClientRect, BgImage, True, NavBar.Color,
        BgBackColor, BgBackColor2, BgAlphaBlend, BgAlphaBlend2,
        BgGradientMode);
end;

procedure TdxNavBarPainter.DrawDropTargetGroupSelection;
var
  AGroupViewInfo: TdxNavBarGroupViewInfo;
begin
  if not NavBar.EnableDragging or (NavBar.SourceGroup = nil) or
    not (fAllowDropGroup in NavBar.DragDropFlags) then exit;
  AGroupViewInfo := ViewInfo.GetGroupViewInfoAtCaptionPos(NavBar.TargetPoint);
  if AGroupViewInfo = nil then
    AGroupViewInfo := ViewInfo.GetGroupViewInfoAtItemsPos(NavBar.TargetPoint);
  if (AGroupViewInfo <> nil) and (AGroupViewInfo.Group <> NavBar.SourceGroup) then
    with ViewInfo do
    DropTargetGroupPainterClass.DrawTargetGroup(Canvas, AGroupViewInfo.CaptionRect,
        DragDropGroupTargetBackColor, DragDropGroupTargetBackColor2,
        DragDropGroupTargetAlphaBlend, DragDropGroupTargetAlphaBlend2,
        DragDropGroupTargetGradient);
end;

procedure TdxNavBarPainter.DrawDropTargetLinkSelection;
var
  lpt1, lpt2, lapt1, lapt2, lapt3, rapt1, rapt2, rapt3: TPoint;
  Item1, Item2: TdxNavBarLinkViewInfo;
  ItemGroup: TdxNavBarGroupViewInfo;
begin
  if not NavBar.EnableDragging or ((NavBar.SourceLink = nil) and (NavBar.SourceItem = nil)) or
    not (fAllowDropLink in NavBar.DragDropFlags) then exit;
  ViewInfo.GetViewInfoAtDragPosition(NavBar.TargetPoint, ItemGroup, Item1, Item2);
  if (Item1 <> nil) and (NavBar.SourceItem = nil) and (Item1.Link = NavBar.SourceLink) then exit;
  if (Item2 <> nil) and (NavBar.SourceItem = nil) and (Item2.Link = NavBar.SourceLink) then exit;

  if (Item1 <> nil) or (Item2 <> nil) then
  begin
    if Item1 <> nil then
    begin
      if not ItemGroup.IsViewAsIconView then
      begin
        lpt1.x := Item1.Rect.Left;
        lpt1.y := Item1.Rect.Bottom;
      end
      else
      begin
        lpt1.x := Item1.Rect.Right;
        lpt1.y := Item1.Rect.Top;
      end;
      lpt2 := Item1.Rect.BottomRight;
    end
    else
    begin
      lpt1 := Item2.Rect.TopLeft;
      if not ItemGroup.IsViewAsIconView then
      begin
        lpt2.x := Item2.Rect.Right;
        lpt2.y := Item2.Rect.Top;
      end
      else
      begin
        lpt2.x := Item2.Rect.Left;
        lpt2.y := Item2.Rect.Bottom;
      end;
    end;
    if PtInRect(ItemGroup.ItemsRect, lpt1) and PtInRect(ItemGroup.ItemsRect, lpt2) then
    begin
      if not ItemGroup.IsViewAsIconView then
      begin
        lapt1.x := lpt1.x + ViewInfo.GetDragArrowWidth;
        lapt1.y := lpt1.y;
        lapt2.x := lpt1.x;
        if Item1 <> nil then
          lapt2.y := lpt1.y - ViewInfo.GetDragArrowHeight div 2
        else lapt2.y := lpt1.y;
        lapt3.x := lpt1.x;
        if Item2 <> nil then
          lapt3.y := lpt1.y + ViewInfo.GetDragArrowHeight div 2
        else lapt3.y := lpt1.y;
        rapt1.x := lapt1.x + (ItemGroup.Rect.Right - ItemGroup.Rect.Left) - 1 - 2 * ViewInfo.GetDragArrowWidth;
        rapt1.y := lapt1.y;
        rapt2.x := lapt2.x + (ItemGroup.Rect.Right - ItemGroup.Rect.Left) - 1;
        rapt2.y := lapt2.y;
        rapt3.x := lapt3.x + (ItemGroup.Rect.Right - ItemGroup.Rect.Left) - 1;
        rapt3.y := lapt3.y;
        DropTargetLinkPainterClass.DrawTargetLink(Canvas, lapt1, lapt2, lapt3, rapt1, rapt2, rapt3,
          ViewInfo.DragDropItemTargetBackColor);
      end
      else DropTargetLinkPainterClass.DrawTargetLink(Canvas, lpt1, lpt1, lpt1, lpt2, lpt2, lpt2,
        ViewInfo.DragDropItemTargetBackColor);
    end;
  end;

end;

procedure TdxNavBarPainter.DrawHintWindow;
begin
  if NavBar.HotTrackedGroup <> nil then
    DrawGroupHintWindow
  else if NavBar.HotTrackedLink <> nil then
    DrawLinkHintWindow;
end;

procedure TdxNavBarPainter.DrawGroupHintWindow;
var
  AHandled: Boolean;
begin
  AHandled := False;
  if Assigned(NavBar.OnCustomDrawGroupHint) then
    NavBar.OnCustomDrawGroupHint(NavBar, HintWindowCanvas, NavBar.HotTrackedGroup,
      ViewInfo.HintText, NavBar.HintWindow.ClientRect, AHandled);
  if not AHandled then
    with ViewInfo do
      TdxNavBarHintPainter.DrawHint(HintWindowCanvas, NavBar.HintWindow.ClientRect,
          ViewInfo.HintText, HintImage, HintBackColor, HintBackColor2,
          HintAlphaBlend, HintAlphaBlend2, HintGradientMode, HintFont);
end;

procedure TdxNavBarPainter.DrawLinkHintWindow;
var
  AHandled: Boolean;
begin
  AHandled := False;
  if Assigned(NavBar.OnCustomDrawLinkHint) then
    NavBar.OnCustomDrawLinkHint(NavBar, HintWindowCanvas, NavBar.HotTrackedLink,
      ViewInfo.HintText, NavBar.HintWindow.ClientRect, AHandled);
  if not AHandled then
    with ViewInfo do
      TdxNavBarHintPainter.DrawHint(HintWindowCanvas, NavBar.HintWindow.ClientRect,
          ViewInfo.HintText, HintImage, HintBackColor, HintBackColor2,
          HintAlphaBlend, HintAlphaBlend2, HintGradientMode, HintFont);
end;

procedure TdxNavBarPainter.DrawGroup(AGroupViewInfo: TdxNavBarGroupViewInfo);
var
  AHandled: Boolean;
begin
  DrawItemsRect(AGroupViewInfo);
  if AGroupViewInfo.IsCaptionVisible then
  begin
    AHandled := False;
    if Assigned(NavBar.OnCustomDrawGroupCaption) then
      NavBar.OnCustomDrawGroupCaption(NavBar, Canvas, AGroupViewInfo, AHandled);
    if not AHandled then DrawGroupCaption(AGroupViewInfo);
  end;
end;

procedure TdxNavBarPainter.DrawGroupBackground(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  with AGroupViewInfo do
    GroupBackgroundPainterClass.DrawBackground(Canvas, ItemsRect, BgImage,
      BgBackColor, BgBackColor2, BgAlphaBlend, BgAlphaBlend2, BgGradientMode);
end;

procedure TdxNavBarPainter.DrawGroupBorder(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  if not ViewInfo.IsGroupActive(AGroupViewInfo.Group) then exit;
  with AGroupViewInfo do
    GroupBorderPainterClass.DrawBorder(Canvas, ItemsRect, BorderColor, IsCaptionVisible);
end;

procedure TdxNavBarPainter.DrawGroupCaption(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  DrawGroupCaptionButton(AGroupViewInfo);
  DrawGroupCaptionText(AGroupViewInfo);
  if AGroupViewInfo.IsCaptionImageVisible then
    DrawGroupCaptionImage(AGroupViewInfo);
  if AGroupViewInfo.IsCaptionSignVisible then
    DrawGroupCaptionSign(AGroupViewInfo);
end;

procedure TdxNavBarPainter.DrawGroupCaptionButton(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  with AGroupViewInfo do
    ButtonPainterClass.DrawButton(Canvas, CaptionRect, CaptionImage,
      CaptionBackColor, CaptionBackColor2, CaptionAlphaBlend, CaptionAlphaBlend2,
      CaptionGradientMode, CaptionBorderColor, State);
end;

procedure TdxNavBarPainter.DrawGroupCaptionText(AGroupViewInfo: TdxNavBarGroupViewInfo);
var
  R: TRect;
begin
  with AGroupViewInfo do
  begin
    R := CaptionTextRect;
    Canvas.Brush.Style := bsClear;
    Canvas.Font := CaptionFont;
    Canvas.Font.Color := CaptionFontColor;
    cxDrawText(DC, Group.Caption, R, GetDrawEdgeFlag);
  end;
end;

procedure TdxNavBarPainter.DrawGroupCaptionImage(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  with AGroupViewInfo do
    ImagePainterClass.DrawImage(Canvas, ImageList, ImageIndex, CaptionImageRect);
end;

procedure TdxNavBarPainter.DrawGroupCaptionSign(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  if AGroupViewInfo.Group.ShowExpandButton then
    with AGroupViewInfo do
      SignPainterClass.DrawSign(Canvas, CaptionSignRect, CaptionSignColor,
        CaptionBackColor, CaptionBackColor2, State);
end;

procedure TdxNavBarPainter.DrawGroupControl(ACanvas: TCanvas; ARect: TRect; AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  with AGroupViewInfo do
    GroupBackgroundPainterClass.DrawBackground(ACanvas, ARect, ControlImage,
      ControlBackColor, ControlBackColor2, ControlAlphaBlend, ControlAlphaBlend2,
      ControlGradientMode);
end;

procedure TdxNavBarPainter.DrawGroupItems(AGroupViewInfo: TdxNavBarGroupViewInfo);
var
  I: Integer;
  ALinkViewInfo: TdxNavBarLinkViewInfo;
begin
  for I := 0 to AGroupViewInfo.ItemCount - 1 do
  begin
    ALinkViewInfo := AGroupViewInfo.Items[I];
    if ALinkViewInfo.Rect.Top < AGroupViewInfo.ItemsRect.Top then continue;
    if ALinkViewInfo.Rect.Top > AGroupViewInfo.ItemsRect.Bottom then continue;
    if ALinkViewInfo.Rect.Bottom > AGroupViewInfo.ItemsRect.Bottom then
      ExcludeClipRect(DC, ALinkViewInfo.Rect.Left, AGroupViewInfo.ItemsRect.Bottom,
        ALinkViewInfo.Rect.Right, ALinkViewInfo.Rect.Bottom);
    DrawItem(ALinkViewInfo);
    SelectClipRgn(DC, 0);
  end;
end;

procedure TdxNavBarPainter.DrawItem(ALinkViewInfo: TdxNavBarLinkViewInfo);
var
  AHandled: Boolean;
begin
  AHandled := False;
  if Assigned(NavBar.OnCustomDrawLink) then
    NavBar.OnCustomDrawLink(NavBar, Canvas, ALinkViewInfo, AHandled);
  if not AHandled then
  begin
    DrawItemSelection(ALinkViewInfo);
    if (ALinkViewInfo.ImageList <> nil) and (0 <= ALinkViewInfo.ImageIndex) and
      (ALinkViewInfo.ImageIndex < ALinkViewInfo.ImageList.Count) then
    begin
      if ALinkViewInfo.IsImageVisible then
        DrawItemImage(ALinkViewInfo);
    end;
    DrawItemCaption(ALinkViewInfo);
  end;
end;

procedure TdxNavBarPainter.DrawItemCaption(ALinkViewInfo: TdxNavBarLinkViewInfo);
var
  R: TRect;
  Flag: Integer;
begin
  with ALinkViewInfo do
  begin
    R := CaptionRect;
    Flag := GetDrawEdgeFlag or DT_END_ELLIPSIS;
    if R.Left < Rect.Left then
      R.Left := Rect.Left;
    if R.Right > Rect.Right then
      R.Right := Rect.Right;
    Canvas.Brush.Style := bsClear;
    Canvas.Font := Font;
    Canvas.Font.Color := FontColor;
    cxDrawText(DC, Item.Caption, R, Flag);
  end;
end;

procedure TdxNavBarPainter.DrawItemImage(ALinkViewInfo: TdxNavBarLinkViewInfo);
begin
  with ALinkViewInfo do
    ImagePainterClass.DrawImage(Canvas, ImageList, ImageIndex, ImageRect, ALinkViewInfo.Item.Enabled);
end;

procedure TdxNavBarPainter.DrawItemSelection(ALinkViewInfo: TdxNavBarLinkViewInfo);
begin
  if not ALinkViewInfo.Item.Enabled then exit;
  with ALinkViewInfo do
    SelectionPainterClass.DrawSelection(Canvas, SelectionRect, GroupViewInfo.BgBackColor, State);
end;

procedure TdxNavBarPainter.DrawItemsRect(AGroupViewInfo: TdxNavBarGroupViewInfo);
var
  AHandled: Boolean;
begin
  AHandled := False;
  if Assigned(NavBar.OnCustomDrawGroupClientBackground) then
    NavBar.OnCustomDrawGroupClientBackground(NavBar, Canvas, AGroupViewInfo, AHandled);
  if not AHandled then
  begin
    DrawGroupBackground(AGroupViewInfo);
    DrawGroupBorder(AGroupViewInfo);
  end;
  if AGroupViewInfo.Control = nil then
  begin
    AHandled := False;
    if Assigned(NavBar.OnCustomDrawGroupClientForeground) then
      NavBar.OnCustomDrawGroupClientForeground(NavBar, Canvas, AGroupViewInfo, AHandled);
    if not AHandled then DrawGroupItems(AGroupViewInfo);
  end;
end;

procedure TdxNavBarPainter.DrawScrollButtons;
var
  AHandled: Boolean;
begin
  if ViewInfo.IsTopScrollButtonVisible then
  begin
    AHandled := False;
    if Assigned(NavBar.OnCustomDrawTopScrollButton) then
      NavBar.OnCustomDrawTopScrollButton(NavBar, Canvas, ViewInfo, AHandled);
    if not AHandled then DrawTopScrollButton;
  end;
  if ViewInfo.IsBottomScrollButtonVisible then
  begin
    AHandled := False;  
    if Assigned(NavBar.OnCustomDrawBottomScrollButton) then
      NavBar.OnCustomDrawBottomScrollButton(NavBar, Canvas, ViewInfo, AHandled);
    if not AHandled then DrawBottomScrollButton;
  end;
end;

procedure TdxNavBarPainter.DrawBottomScrollButton;
begin
  with ViewInfo do
  begin
    ScrollButtonsPainterClass.DrawBottomButton(Canvas, BottomScrollButtonRect,
      ButtonPainterClass, BottomScrollButtonBackColor, BottomScrollButtonBackColor2,
      BottomScrollButtonAlphaBlend, BottomScrollButtonAlphaBlend2, BottomScrollButtonGradientMode,
      BorderColor, BottomScrollButtonState);
    with BottomScrollButtonRect do
      ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
  end;
end;

procedure TdxNavBarPainter.DrawTopScrollButton;
begin
  with ViewInfo do
  begin
    ScrollButtonsPainterClass.DrawTopButton(Canvas, TopScrollButtonRect,
      ButtonPainterClass, TopScrollButtonBackColor, TopScrollButtonBackColor2,
      TopScrollButtonAlphaBlend, TopScrollButtonAlphaBlend2, TopScrollButtonGradientMode,
      BorderColor, TopScrollButtonState);
    with TopScrollButtonRect do
      ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
  end;
end;

{ TdxCustomNavBar }

constructor TdxCustomNavBar.Create(AOwner: TComponent);

  function InternalCreateTimer(AInterval: Integer; AOnTimer: TNotifyEvent): TcxTimer;
  begin
    Result := TcxTimer.Create(Self);
    Result.Enabled := False;
    Result.Interval := AInterval;
    Result.OnTimer := AOnTimer;
  end;

begin
  inherited Create(AOwner);
  FCanvasBitmap := TBitmap.Create;
  FScrollBar := TdxNavBarScrollBar.Create(Self, sbVertical);
  FScrollBar.OnScroll := Scroll;

  FActivateGroupTimer := InternalCreateTimer(dxNavBarActivateGroupInterval, DoActivateGroupTimer);
  FScrollTimer := InternalCreateTimer(dxNavBarScrollInterval, DoScrollTimer);
  FHintTimer := InternalCreateTimer(dxNavBarHintShowingInterval, DoHintTimer);

  FGroups := TdxNavBarGroups.Create(Self, GetGroupClass);
  FGroups.OnChange := OnGroupsChanged;
  FGroups.OnLinksChange := OnLinksChanged;
  FItems := TdxNavBarItems.Create(Self, GetItemClass);
  FItems.OnChange := OnItemsChanged;
  FStyles := TdxNavBarStyles.Create(Self, TdxNavBarStyleItem);
  FStyles.OnChange := OnStylesChanged;
  FDefaultStyles := TdxNavBarDefaultStyles.Create(Self);
  FDefaultStyles.OnChange := OnDefaultStylesChanged;

  FLargeChangeLink := TChangeLink.Create;
  FSmallChangeLink := TChangeLink.Create;
  FLargeChangeLink.OnChange := OnImagesChanged;
  FSmallChangeLink.OnChange := OnImagesChanged;
  FThemeNotificator := TdxThemeChangedNotificator.Create;
  FThemeNotificator.OnThemeChanged := OnThemeChanged;
  FHintWindow := TdxNavBarHintWindow.Create(Self);
  FHintWindowShowing := False;

  DragCursor := dxNavBarDragCursor;
  FDragCopyCursor := dxNavBarDragCopyCursor;
  FDragDropFlags := [fAllowDragLink, fAllowDropLink, fAllowDragGroup, fAllowDropGroup];
  FHotTrackedGroupCursor := crDefault;
  FHotTrackedLinkCursor := dxNavBarLinksCursor;
  FShowGroupCaptions := True;
  FShowNavigationPaneOverflowPanelHints := True;
  FNavigationPaneOverflowPanelHotTrackedIndex := -1;
  FNavigationPaneOverflowPanelPressedIndex := -1;
  FNavigationPaneOverflowPanelUseSmallImages := True;
  FNavigationPaneMaxVisibleGroups := -1;

  BevelInner := bvNone;
  BevelOuter := bvNone;
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption]  + [csActionClient];
  Height := 300;
  Width := 150;

  AssignDefaultStyles;
end;

destructor TdxCustomNavBar.Destroy;
begin
  FreeAndNil(FActivateGroupTimer);
  FreeAndNil(FScrollTimer);
  FreeAndNil(FHintTimer);

  FreeAndNil(FScrollBar);

  FreeAndNil(FThemeNotificator);
  FreeAndNil(FHintWindow);
  FreeAndNil(FSmallChangeLink);
  FreeAndNil(FLargeChangeLink);

  FreeAndNil(FStyles);
  FreeAndNil(FItems);
  FreeAndNil(FGroups);
  FreeAndNil(FDefaultStyles);

  FreeAndNil(FDesigner);
  FreeAndNil(FPainter);
  FreeAndNil(FCanvasBitmap);
  inherited;
end;

procedure TdxCustomNavBar.DeSelectLinks;
var
  I: Integer;
begin
  for I := 0 to Groups.Count - 1 do
    Groups[I].SelectedLinkIndex := -1;
end;

procedure TdxCustomNavBar.DragDrop(Source: TObject; X, Y: Integer);
begin
  if FPressedGroup <> nil then
  begin
    FPressedGroup := nil;
    InvalidateAll(doRedraw);
  end;
  if FPressedLink <> nil then
  begin
    FPressedLink := nil;
    InvalidateAll(doRedraw);
  end;
  FTargetPoint := Point(X, Y);
  FHotTrackedLink := GetLinkAtSelectedPos(FTargetPoint);
  FHotTrackedGroup := GetGroupAtCaptionPos(FTargetPoint);
  if dxNavBarDragObject <> nil then
  begin
    dxNavBarDragObject.UpdateTargets;
    if (SourceItem <> nil) and IsAllowDropLink then
      DoItemDragDrop(SourceItem)
    else if (SourceLink <> nil) and IsAllowDropLink then
      DoLinkDragDrop(SourceLink)
    else if (SourceGroup <> nil) and IsAllowDropGroup then
      DoGroupDragDrop(SourceGroup)
  end;
  inherited DragDrop(Source, X, Y);
  DragDone;
end;

procedure TdxCustomNavBar.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  ABoundsChanged: Boolean;
begin
  ABoundsChanged := (ALeft <> Left) or (ATop <> Top) or (AWidth <> Width) or (AHeight <> Height);
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if ABoundsChanged and (CanvasBitmap <> nil) and HandleAllocated then
  begin
    if CanvasBitmap.Width <= ClientWidth then
      CanvasBitmap.Width := ClientWidth + 10;
    if CanvasBitmap.Height <= ClientHeight then
      CanvasBitmap.Height := ClientHeight + 10;
    InvalidateAll(ViewInfo.GetBoundsUpdateType);
  end;
end;

procedure TdxCustomNavBar.Loaded;
begin
  inherited;
  if (0 <= FActiveGroupIndex) and (FActiveGroupIndex < Groups.Count) then
    FActiveGroup := Groups[FActiveGroupIndex];
  DefaultStyles.AssignDefaultValues(True);
  InvalidateAll(doRecreate);
end;

procedure TdxCustomNavBar.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    Style := Style or WS_CLIPCHILDREN;
end;

procedure TdxCustomNavBar.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited CreateWindowHandle(Params);
  ScrollBar.Reset;
end;

procedure TdxCustomNavBar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent = FHotTrackedGroup then FHotTrackedGroup := nil;
    if AComponent = FPressedGroup then FPressedGroup := nil;
    if AComponent = FActiveGroup then ActiveGroup := nil;
    if (AComponent = LargeImages) then LargeImages := nil;
    if (AComponent = SmallImages) then SmallImages := nil;
    if (AComponent = StyleBackground) then StyleBackground := nil;
    if (AComponent = StyleHint) then StyleHint := nil;
    if (AComponent = StyleDropTargetGroup) then StyleDropTargetGroup := nil;
    if (AComponent = StyleDropTargetLink) then StyleDropTargetLink := nil;
    if (AComponent = StyleButton) then StyleButton := nil;
    if (AComponent = StyleButtonHotTracked) then StyleButtonHotTracked := nil;
    if (AComponent = StyleButtonPressed) then StyleButtonPressed := nil;
    if (AComponent = StyleNavigationPaneHeader) then StyleNavigationPaneHeader := nil;
  end;
end;

procedure TdxCustomNavBar.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to Groups.Count - 1 do
    if Groups[I].Owner = Root then
      Proc(Groups[I]);
  for I := 0 to Items.Count - 1 do
    if Items[I].Owner = Root then
      Proc(Items[I]);
  for I := 0 to Styles.Count - 1 do
    if Styles[I].Owner = Root then
      Proc(Styles[I]);
  for I := 0 to Groups.Count - 1 do
    if (Groups[I].Control <> nil) and (Groups[I].Control.Owner = Root) then
      Proc(Groups[I].Control);
end;

procedure TdxCustomNavBar.SetName(const NewName: TComponentName);
var
  OldName, NewItemName: string;
  I, L: Integer;

  procedure UpdateName(AComponent: TComponent);
  begin
    NewItemName := AComponent.Name;
    if Pos(OldName, NewItemName) = 1 then
    begin
      Delete(NewItemName, 1, L);
      Insert(Name, NewItemName, 1);
      try
        AComponent.Name := NewItemName;
      except
        on EComponentError do ; {Ignore rename errors }
      end;
    end;
  end;

begin
  OldName := Name;
  L := Length(OldName);
  inherited;
  if (csDesigning in ComponentState) then
  begin
    if Designer <> nil then Designer.BeginUpdate;
    try
      for I := 0 to Groups.Count - 1 do
         UpdateName(Groups[I]);
      for I := 0 to Items.Count - 1 do
         UpdateName(Items[I]);
      for I := 0 to Styles.Count - 1 do
         UpdateName(Styles[I]);
    finally
      if Designer <> nil then Designer.EndUpdate;
    end;
  end;
end;

procedure TdxCustomNavBar.WndProc(var Message: TMessage);
begin
  if (FHintWindowShowing) then
    with Message do
      if ((Msg >= WM_KEYFIRST) and (Msg <= WM_KEYLAST)) or
        ((Msg = CM_ACTIVATE) or (Msg = CM_DEACTIVATE)) or
        (Msg = CM_APPKEYDOWN) or (Msg = CM_APPSYSCOMMAND) or
        (Msg = WM_COMMAND) or ((Msg > WM_MOUSEMOVE) and
        (Msg <= WM_MOUSELAST)) or (Msg = WM_NCMOUSEMOVE) then
         DoHintDeactivate;
  inherited WndProc(Message);
end;

function TdxCustomNavBar.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint): Boolean;

const
  AScrollCodes: array[Boolean, Boolean] of TScrollCode = ((scLineUp, scPageUp), (scLineDown, scPageDown));

  function IsScrollBarsPresent(AControl: TWinControl): Boolean;
  var
    AScrollInfo: TScrollInfo;
  begin
    ZeroMemory(@AScrollInfo, SizeOf(TScrollInfo));
    AScrollInfo.fMask := SIF_ALL;
    AScrollInfo.cbSize := SizeOf(TScrollInfo);
    GetScrollInfo(AControl.Handle, SB_VERT, AScrollInfo);
    Result := (AScrollInfo.nPage > 0) and (AScrollInfo.nMax >= Integer(AScrollInfo.nPage));
  end;

var
  AScrollPos: Integer;
  AControl: TWinControl;
  AMessage: TWMMouseWheel;
  AWindowRect: TRect;
begin              
  Result := False;
  GetWindowRect(Handle, AWindowRect);
  if PtInRect(AWindowRect, Mouse.CursorPos) and ScrollBar.Visible then
  begin
    AControl := FindControl(WindowFromPoint(Mouse.CursorPos));
    if (AControl <> nil) and (AControl <> Self) and IsScrollBarsPresent(AControl) then
    begin
      AMessage.Msg := WM_MOUSEWHEEL;
      AMessage.Keys := ShiftStateToKeys(Shift);
      AMessage.WheelDelta := WheelDelta;
      AMessage.Pos := PointToSmallPoint(MousePos);

      AControl.DefaultHandler(AMessage);
      Result := AMessage.Result = 1;
    end;

    if not Result then
    begin
      AScrollPos := ScrollBar.Position;
      ScrollBar.Scroll(ScrollBar, AScrollCodes[WheelDelta < 0, ssCtrl in Shift], AScrollPos);
      Result := True;
    end;
  end;
end;

procedure TdxCustomNavBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  AGroup: TdxNavBarGroup;
  ALink: TdxNavBarItemLink;
begin
  DoHintDeactivate;
  SetFocus;
  inherited  MouseDown(Button, Shift, X, Y);
  FSourceShift := Shift;
  if ssLeft in FSourceShift then
  begin
    FSourcePoint := Point(X, Y);
    if IsPtTopScrollButton(FSourcePoint) then
      DoTopScrollButtonDown
    else if IsPtBottomScrollButton(FSourcePoint) then
      DoBottomScrollButtonDown
    else if IsPtNavigationPaneSplitter(FSourcePoint) then
      DoSplitterMouseDown
    else if IsPtNavigationPaneOverflowPanel(FSourcePoint) then
      DoOverflowPanelMouseDown
    else
    begin
      AGroup := GetGroupAtCaptionPos(FSourcePoint);
      if AGroup <> nil then
        DoGroupMouseDown(AGroup);
      ALink := GetLinkAtSelectedPos(FSourcePoint);
      if ALink <> nil then
        DoLinkMouseDown(ALink);
    end;
  end
  else if (FHotTrackedGroup <> nil) or (FHotTrackedLink <> nil) or (NavigationPaneOverflowPanelHotTrackedIndex > -1) then
  begin
    FNavigationPaneOverflowPanelHotTrackedIndex := -1;
    FHotTrackedGroup := nil;
    FHotTrackedLink := nil;
    InvalidateAll(doRedraw);
  end;
end;

procedure TdxCustomNavBar.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if EnableDragging then exit;
  inherited  MouseUp(Button, Shift, X, Y);
  FSourcePoint := Point(X, Y);
  if EnableSplitterDragging then
    DoSplitterMouseUp
  else if IsPtTopScrollButton(FSourcePoint) or ScrollButtonUpIsDown then
    DoTopScrollButtonUp
  else if IsPtBottomScrollButton(FSourcePoint) or ScrollButtonDownIsDown then
    DoBottomScrollButtonUp
  else if IsPtNavigationPaneOverflowPanel(FSourcePoint) or (NavigationPaneOverflowPanelPressedIndex > -1) or
    NavigationPaneOverflowPanelSignPressed then DoOverflowPanelMouseUp
  else
  begin
    FScrollButtonDownIsDown := False;
    FScrollButtonUpIsDown := False;
    if FSourceGroup <> nil then
      DoGroupMouseUp(FSourceGroup);
    if FSourceLink <> nil then
      DoLinkMouseUp(FSourceLink);
  end;
  FSourceShift := [];
end;

procedure TdxCustomNavBar.MouseEnter;
begin
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
  InvalidateAll(doRedraw);
end;

procedure TdxCustomNavBar.MouseLeave;
begin
  DoHintDeactivate;
  FTargetPoint := cxInvalidPoint;
  FPressedGroup := nil;
  FPressedLink := nil;
  FHotTrackedGroup := nil;
  FHotTrackedLink := nil;
  FNavigationPaneOverflowPanelHotTrackedIndex := -1;
  FNavigationPaneOverflowPanelSignHotTracked := False;
  if dxNavBarDragObject <> nil then
    dxNavBarDragObject.UpdateTargets;
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
  InvalidateAll(doRecalc);
end;

procedure TdxCustomNavBar.MouseMove(Shift: TShiftState; X, Y: Integer);

  function IsDragBegining: Boolean;
  begin
    Result := (Abs(FSourcePoint.X - X)  > 3) or (Abs(FSourcePoint.Y - Y)  > 3);
  end;

  function CanDrag: Boolean;
  begin
    Result := (IsAllowDragGroup and (FSourceGroup <> nil)) or
      (IsAllowDragLink and (FSourceLink <> nil) and FSourceLink.Item.Enabled);
  end;
  
var
  ALink: TdxNavBarItemLink;
  AGroup: TdxNavBarGroup;
begin
  FTargetPoint := Point(X, Y);
  if not Painter.IsViewInfoValid then
    Exit;
  if IsTopScrollButtonVisible or IsBottomScrollButtonVisible then
    InvalidateScrollButtons;
  if EnableSplitterDragging then
    DoSplitterDrag
  else if CanDrag and IsDragBegining then
  begin
    FSourceShift := [];
    FEnableDragging := True;
    DragMode := dmAutomatic;
    BeginDrag(True);
  end
  else
  begin
    inherited MouseMove(Shift, X, Y);
    if FSourceShift * Shift = [] then
    begin
      ALink := GetLinkAtSelectedPos(FTargetPoint);
      if ALink <> FHotTrackedLink then
        DoLinkHotTrack(ALink);
      AGroup := GetGroupAtCaptionPos(FTargetPoint);
      if AGroup <> FHotTrackedGroup then
        DoGroupHotTrack(AGroup);
      if IsPtNavigationPaneOverflowPanel(FTargetPoint) or (NavigationPaneOverflowPanelHotTrackedIndex > -1) or
        NavigationPaneOverflowPanelSignHotTracked then DoOverflowPanelMouseMove;
    end;
  end;
end;

procedure TdxCustomNavBar.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := False;
  FTargetPoint := Point(X, Y);
  FScrollButtonDownIsDown := False;
  FScrollButtonUpIsDown := False;
  if FPressedGroup <> nil then
  begin
    FPressedGroup := nil;
    InvalidateAll(doRedraw);
  end;
  if FPressedLink <> nil then
  begin
    FPressedLink := nil;
    InvalidateAll(doRedraw);
  end;
  if IsTopScrollButtonVisible or IsBottomScrollButtonVisible then
    InvalidateScrollButtons;
  if dxNavBarDragObject <> nil then
  begin
    dxNavBarDragObject.UpdateTargets;
    if (SourceItem <> nil) and IsAllowDropLink then
      DoItemDragOver(SourceItem, Accept)
    else if (SourceLink <> nil) and IsAllowDropLink then
      DoLinkDragOver(SourceLink, Accept)
    else if (SourceGroup <> nil) and IsAllowDropGroup then
      DoGroupDragOver(SourceGroup, Accept);
  end;
  if Assigned(OnDragOver) then
    OnDragOver(Self, Source, X, Y, State, Accept);
end;

procedure TdxCustomNavBar.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  inherited DoEndDrag(Target, X, Y);
  FreeAndNil(FDragObject);
  DragDone;
end;

type
  TdxDragObject = class(TDragControlObject)
  protected
    function GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor; override;
  end;

function TdxDragObject.GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor;
var
  Wnd: TWinControl;
begin
  Wnd := FindVCLWindow(Point(X, Y));
  if Accepted and (Wnd is TdxCustomNavBar) then
  begin
    if dxNavBarDragObject.SourceItem <> nil then
      Result := TdxCustomNavBar(Wnd).DragCopyCursor
    else Result := TdxCustomNavBar(Wnd).DragCursor;
 end
 else Result := inherited GetDragCursor(Accepted, X, Y);
end;

procedure TdxCustomNavBar.DoStartDrag(var DragObject: TDragObject);
begin
  if dxNavBarDragObject = nil then
    dxNavBarDragObject := TdxNavBarDragObject.Create(Self, DragObject {deprecated}, FSourceGroup, FSourceLink, nil);
  FDragObject := TdxDragObject.Create(Self);
  DragObject := FDragObject;
  DoLinkHotTrack(nil);
  DoGroupHotTrack(nil);
  inherited DoStartDrag(DragObject);
end;

procedure TdxCustomNavBar.DoActivateGroupTimer(Sender: TObject);
var
  Group: TdxNavBarGroup;
begin
  Group := ViewInfo.GetGroupAtCaptionPos(FTargetPoint);
  if Group = FActiveGroupCandidate then
      ViewInfo.DoGroupActivate(Group);
  FActivateGroupTimer.Enabled := False;
end;

procedure TdxCustomNavBar.DoScrollTimer(Sender: TObject);
begin
  FScrollButtonUpIsDown := IsPtTopScrollButton(TargetPoint);
  FScrollButtonDownIsDown := IsPtBottomScrollButton(TargetPoint);
  if ScrollButtonUpIsDown or ScrollButtonDownIsDown then
  begin
   if ScrollButtonUpIsDown and not (sDisabled in ViewInfo.TopScrollButtonState) then
      ActiveGroup.TopVisibleLinkIndex:= ActiveGroup.TopVisibleLinkIndex - 1;
    if ScrollButtonDownIsDown and not (sDisabled in ViewInfo.BottomScrollButtonState) then
      ActiveGroup.TopVisibleLinkIndex := ActiveGroup.TopVisibleLinkIndex + 1;
  end
  else FScrollTimer.Enabled := False;
end;

procedure TdxCustomNavBar.DoHintTimer(Sender: TObject);
begin
  ViewInfo.RecalculateHint;
  if ViewInfo.HintText <> '' then
  begin
    HintWindow.ActivateHint(ViewInfo.HintRect, ViewInfo.HintText);
    FHintWindowShowing := True;
  end;
  FHintTimer.Enabled := False;
end;

procedure TdxCustomNavBar.DoGroupDragDrop(Group: TdxNavBarGroup);
begin
  if TargetGroup <> nil then
    Group.Index := TargetGroup.Index;
end;

procedure TdxCustomNavBar.DoGroupDragOver(Group: TdxNavBarGroup; var Accept: Boolean);
begin
  Accept := (Group <> TargetGroup) and (TargetGroup <> nil);
  InvalidateAll(doRedraw);
end;

procedure TdxCustomNavBar.DoGroupHotTrack(Group: TdxNavBarGroup);
begin
  DoHintDeactivate;
  if FHotTrackedGroup <> nil then
    InvalidateAll(doRecalc);
  FHotTrackedGroup := Group;
  DoGroupHintActivate;
  if FHotTrackedGroup <> nil then
    InvalidateAll(doRecalc);
  if Assigned(FOnGroupHotTrack) then
    FOnGroupHotTrack(Self, FHotTrackedGroup);
end;

procedure TdxCustomNavBar.DoGroupMouseDown(Group: TdxNavBarGroup);
begin
  FSourceGroup := Group;
  FPressedGroup := Group;
  if Assigned(FOnGroupPress) then
    FOnGroupPress(Self, FPressedGroup);
  InvalidateAll(doRecalc);
end;

procedure TdxCustomNavBar.DoGroupMouseUp(Group: TdxNavBarGroup);
begin
  FSourceGroup := nil;
  if Assigned(Group.OnClick) then
    Group.OnClick(Group)
  else if Assigned(FOnGroupClick) then
    FOnGroupClick(Self, Group);
  ViewInfo.DoGroupActiveToggle(Group);
  FPressedGroup := nil;
  InvalidateAll(doRecalc);
end;

procedure TdxCustomNavBar.DoLinkDragDrop(Link: TdxNavBarItemLink);
var
  AIndex: Integer;
  ASourceLink: TdxNavBarItemLink;
begin
  AIndex := TargetLinkIndex;
  if AIndex > -1 then
  begin
    if (TargetGroup = Link.Group) and (AIndex > Link.Index) then Dec(AIndex);
    if Link.Group <> TargetGroup then
    begin
      Link.Group.SelectedLinkIndex := -1;
      ASourceLink := TargetGroup.CreateLink(Link.Item);
      ASourceLink.Index := AIndex;
      Link.Group.RemoveLink(Link.Index);
    end
    else ASourceLink := Link;
    ASourceLink.Index := AIndex;
    InvalidateAll(doRedraw);
  end;
end;

procedure TdxCustomNavBar.DoLinkDragOver(Link: TdxNavBarItemLink; var Accept: Boolean);
var
  Group: TdxNavBarGroup;
begin
  Accept := True;
  if IsPtTopScrollButton(TargetPoint) or IsPtBottomScrollButton(TargetPoint) then
    FScrollTimer.Enabled := True
  else
  begin
    Group := ViewInfo.GetGroupAtCaptionPos(FTargetPoint);
    if Group <> nil then
    begin
      FActivateGroupTimer.Enabled := False;
      FActiveGroupCandidate := Group;
      FActivateGroupTimer.Enabled := True;
    end;
    Accept := (TargetGroup <> nil) and (TargetLink1 <> Link) and (TargetLink2 <> Link);
    InvalidateAll(doRedraw);
  end;
end;

procedure TdxCustomNavBar.DoLinkHotTrack(Link: TdxNavBarItemLink);
begin
  DoHintDeactivate;
  if FHotTrackedLink <> nil then
    InvalidateAll(doRecalc);
  FHotTrackedLink := Link;
  DoLinkHintActivate;
  if FHotTrackedLink <> nil then
    InvalidateAll(doRecalc);
  if Assigned(FOnLinkHotTrack) then
    FOnLinkHotTrack(Self, FHotTrackedLink);
end;

procedure TdxCustomNavBar.DoLinkMouseDown(Link: TdxNavBarItemLink);
begin
  FSourceLink := Link;
  if (Link.Group.SelectedLinkIndex > -1) then
    InvalidateAll(doRecalc);
  if (Link.Item <> nil) and Link.Item.Enabled then
  begin
    FPressedLink := Link;
    if Assigned(FOnLinkPress) then
      FOnLinkPress(Self, FPressedLink);
    InvalidateAll(doRecalc);
  end;
end;

procedure TdxCustomNavBar.DoLinkMouseUp(Link: TdxNavBarItemLink);
begin
  FSourceLink := nil;
  if (Link.Item <> nil) and Link.Item.Enabled then
  begin
    if Assigned(Link.Item.OnClick) then
      Link.Item.OnClick(Link.Item)
    else
      if Link.Item.Action <> nil then
        Link.Item.ActionLink.Execute{$IFDEF DELPHI6}(Link.Item){$ENDIF}
      else
        if Assigned(OnLinkClick) then
          OnLinkClick(Self, Link);
    if (FPressedLink <> nil) and AllowSelectLinks then
      Link.Group.SelectedLinkIndex := FPressedLink.Index;
    FPressedLink := nil;
    InvalidateAll(doRecalc);
  end;
end;

procedure TdxCustomNavBar.DoItemDragDrop(Item: TdxNavBarItem);
begin
  if TargetGroup <> nil then
  begin
    with TargetGroup.CreateLink(Item) do
      Index := TargetLinkIndex;
  end;
end;

procedure TdxCustomNavBar.DoItemDragOver(Item: TdxNavBarItem; var Accept: Boolean);
var
  Group: TdxNavBarGroup;
begin
  Accept := True;
  if IsPtTopScrollButton(FTargetPoint) or IsPtBottomScrollButton(FTargetPoint) then
    FScrollTimer.Enabled := True
  else
  begin
    Group := GetGroupAtCaptionPos(FTargetPoint);
    if Group <> nil then
    begin
      FActivateGroupTimer.Enabled := False;
      FActiveGroupCandidate := Group;
      FActivateGroupTimer.Enabled := True;
    end;
    Accept := TargetGroup <> nil;
    InvalidateAll(doRedraw);
  end;
end;

procedure TdxCustomNavBar.DoBottomScrollButtonDown;
begin
  if not (sDisabled in ViewInfo.BottomScrollButtonState) then
  begin
    FScrollButtonUpIsDown := False;
    FScrollButtonDownIsDown := True;
    FScrollTimer.Enabled := True;
    if ActiveGroup <> nil then
      ActiveGroup.TopVisibleLinkIndex := ActiveGroup.TopVisibleLinkIndex + 1;
    InvalidateScrollButtons;
  end;
end;

procedure TdxCustomNavBar.DoBottomScrollButtonUp;
begin
  FScrollButtonDownIsDown := False;
  FScrollTimer.Enabled := False;
  InvalidateScrollButtons;
end;

procedure TdxCustomNavBar.DoTopScrollButtonDown;
begin
  if not (sDisabled in ViewInfo.TopScrollButtonState) then
  begin
    FScrollButtonDownIsDown := False;
    FScrollButtonUpIsDown := True;
    FScrollTimer.Enabled := True;
    if ActiveGroup <> nil then
      ActiveGroup.TopVisibleLinkIndex := ActiveGroup.TopVisibleLinkIndex - 1;
    InvalidateScrollButtons;
  end;
end;

procedure TdxCustomNavBar.DoTopScrollButtonUp;
begin
  FScrollButtonUpIsDown := False;
  FScrollTimer.Enabled := False;
  InvalidateScrollButtons;
end;

procedure TdxCustomNavBar.DoNavigationPaneOverflowPanelHintsActivate;
begin
  if not EnableDragging and ShowNavigationPaneOverflowPanelHints and (NavigationPaneOverflowPanelSignHotTracked or
    (NavigationPaneOverflowPanelHotTrackedIndex > -1)) then
    DoHintActivate;
end;

procedure TdxCustomNavBar.DoGroupHintActivate;
begin
  if not EnableDragging and ShowGroupsHint and (HotTrackedGroup <> nil) then
    DoHintActivate;
end;

procedure TdxCustomNavBar.DoLinkHintActivate;
begin
  if not EnableDragging and ShowLinksHint and (HotTrackedLink <> nil) then
    DoHintActivate;
end;

procedure TdxCustomNavBar.DoHintActivate;
begin
  if Application.Active then
    FHintTimer.Enabled := True;
end;

procedure TdxCustomNavBar.DoHintDeactivate;
begin
  FHintTimer.Enabled := False;
  if IsWindowVisible(FHintWindow.Handle) then
    ShowWindow(FHintWindow.Handle, SW_HIDE);
  FHintWindowShowing := False;
end;

procedure TdxCustomNavBar.DoOverflowPanelMouseDown;
var
  AIndex: Integer;
begin
  AIndex := ViewInfo.GetNavigationPaneOverflowPanelItemIndexAtPos(FSourcePoint);
  if AIndex > -1 then
  begin
    FNavigationPaneOverflowPanelPressedIndex := AIndex;
    InvalidateAll(doRedraw);
  end
  else if ViewInfo.IsPtNavigationPaneOverflowPanelSign(FSourcePoint) then
  begin
    FNavigationPaneOverflowPanelSignPressed := True;
    InvalidateAll(doRedraw);
  end;
end;

procedure TdxCustomNavBar.DoOverflowPanelMouseMove;
var
  AIndex: Integer;
  AHot: Boolean;
begin
  AIndex := ViewInfo.GetNavigationPaneOverflowPanelItemIndexAtPos(FTargetPoint);
  if NavigationPaneOverflowPanelHotTrackedIndex <> AIndex then
  begin
    DoHintDeactivate;
    FNavigationPaneOverflowPanelHotTrackedIndex := AIndex;
    DoNavigationPaneOverflowPanelHintsActivate;
    InvalidateAll(doRedraw);
  end;
  AHot := ViewInfo.IsPtNavigationPaneOverflowPanelSign(FTargetPoint);
  if NavigationPaneOverflowPanelSignHotTracked <> AHot then
  begin
    DoHintDeactivate;
    FNavigationPaneOverflowPanelSignHotTracked := AHot;
    DoNavigationPaneOverflowPanelHintsActivate;
    InvalidateAll(doRedraw);
  end;
end;

procedure TdxCustomNavBar.DoOverflowPanelMouseUp;
var
  pt: TPoint;
begin
  if (ViewInfo.GetNavigationPaneOverflowPanelItemIndexAtPos(FTargetPoint) = NavigationPaneOverflowPanelPressedIndex) and
    (NavigationPaneOverflowPanelPressedIndex > -1) then
    ActiveGroup := ViewInfo.GetNavigationPaneOverflowPanelGroupAtPos(FTargetPoint);
  if ViewInfo.IsPtNavigationPaneOverflowPanelSign(FTargetPoint) and FNavigationPaneOverflowPanelSignPressed then
  begin
    FNavigationPaneOverflowPanelSignHotTracked := False;
    pt := ClientToScreen(FTargetPoint);
    FNavigationPaneOverflowPanelSignPressed := False;
    FNavigationPaneOverflowPanelSignHotTracked := True;
    InvalidateAll(doRedraw);
    ViewInfo.DoShowPopupMenu(pt.X, pt.Y);
  end;
  FNavigationPaneOverflowPanelPressedIndex := -1;
  FNavigationPaneOverflowPanelSignPressed := False;
  FNavigationPaneOverflowPanelSignHotTracked := False;
  InvalidateAll(doRedraw);
end;

procedure TdxCustomNavBar.DoSplitterMouseDown;
begin
  FEnableSplitterDragging := True;
end;

procedure TdxCustomNavBar.DoSplitterDrag;
begin
  if CanDecNavigationPaneOverflowPanelItemCount and
    ViewInfo.IsPtDecNavigationPaneOverflowPanelItemCount(TargetPoint) then
    DoDecNavigationPaneOverflowPanelItemCount
  else
    if CanIncNavigationPaneOverflowPanelItemCount and
      ViewInfo.IsPtIncNavigationPaneOverflowPanelItemCount(TargetPoint) then
      DoIncNavigationPaneOverflowPanelItemCount;
end;

procedure TdxCustomNavBar.DoSplitterMouseUp;
begin
  FEnableSplitterDragging := False;
end;

procedure TdxCustomNavBar.DoUpdateScrollBarStyle;
begin
  with FScrollBar.ScrollBar do
  begin
    if View in [dxNavBarXP1View, dxNavBarXP2View, dxNavBarXPExplorerBarView,
      dxNavBarAdvExplorerBarView]
    then
      LookAndFeel.NativeStyle := True
    else
    begin
      LookAndFeel.NativeStyle := False;
      case View of
        dxNavBarBaseView:
          LookAndFeel.Kind := lfStandard;
        dxNavBarOffice1View, dxNavBarOffice2View, dxNavBarOffice3View, dxNavBarFlatView:
          LookAndFeel.Kind := lfFlat;
        dxNavBarUltraFlatExplorerView, dxNavBarExplorerBarView:
          LookAndFeel.Kind := lfUltraFlat;
        dxNavBarOffice11TaskPaneView, dxNavBarOffice11NavigatorPaneView:
          LookAndFeel.Kind := lfOffice11;
        dxNavBarSkinExplorerBarView:
          if Painter.GetMasterLookAndFeel <> nil then
            LookAndFeel.MasterLookAndFeel := Painter.GetMasterLookAndFeel;
      end;
    end;
  end;    
end;

function TdxCustomNavBar.GetClientRect: TRect;
begin
  Result := inherited GetClientRect;
  if FScrollBar.Visible then
    if FScrollBar.FKind = sbVertical then
      Result.Right := Result.Right - FScrollBar.Width
    else
      Result.Bottom := Result.Bottom - FScrollBar.Height;
end;

procedure TdxCustomNavBar.Scroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
  InvalidateAll(doRecalc);
  Update;
end;

procedure TdxCustomNavBar.DesignerModified;
begin
  if Designer <> nil then
    Designer.Modified;
end;

procedure TdxCustomNavBar.DesignerUpdate(AItem: TComponent);
begin
  if Designer <> nil then
    Designer.Update(AItem);
end;

procedure TdxCustomNavBar.OnGroupsChanged(Sender: TObject; AItem: TcxComponentCollectionItem;
  AAction: TcxComponentCollectionNotification);
begin
  if csDestroying in ComponentState then Exit;
  if NavigationPaneMaxVisibleGroups <> -1 then
    InvalidateAll(doRecreate)
  else
    InvalidateAll(AItem, AAction);
  if AAction = ccnChanged then //#DG ?
    DesignerModified;
end;

procedure TdxCustomNavBar.OnItemsChanged(Sender: TObject; AItem: TcxComponentCollectionItem;
  AAction: TcxComponentCollectionNotification);
begin
  InvalidateAll(AItem, AAction);
  if AAction = ccnChanged then //#DG ?
    DesignerModified;
end;

procedure TdxCustomNavBar.OnStylesChanged(Sender: TObject; AItem: TcxComponentCollectionItem;
  AAction: TcxComponentCollectionNotification);
begin
  InvalidateAll(doRecreate);
  if AAction = ccnChanged then //#DG ?
    DesignerModified;
end;

procedure TdxCustomNavBar.OnDefaultStylesChanged(Sender: TObject; AType: TdxNavBarChangeType);
begin
  InvalidateAll(doRecreate);
  DesignerModified;
end;

procedure TdxCustomNavBar.OnImagesChanged(Sender: TObject);
begin
  InvalidateAll(doRecreate);
end;

procedure TdxCustomNavBar.OnLinksChanged(Sender: TObject; ALink: TdxNavBarItemLink);
begin
  if FHotTrackedLink = ALink then
    FHotTrackedLink := nil;
  if FPressedLink = ALink then
    FPressedLink := nil;
end;

procedure TdxCustomNavBar.OnThemeChanged;
begin
  ViewInfo.RefreshColors;
  InvalidateAll(doRecreate);
end;

procedure TdxCustomNavBar.DoActiveGroupChanged;
begin
  if ([csDestroying, csLoading] * ComponentState = []) and Assigned(OnActiveGroupChanged) then
    OnActiveGroupChanged(Self);
end;

procedure TdxCustomNavBar.DoActiveGroupChanging(ANewGroup: TdxNavBarGroup; var AAllowChange: Boolean);
begin
  if ([csDestroying, csLoading] * ComponentState = []) and Assigned(OnActiveGroupChanging) then
    OnActiveGroupChanging(Self, ANewGroup, AAllowChange);
end;

procedure TdxCustomNavBar.Paint;
begin
  Painter.Paint;
end;

procedure TdxCustomNavBar.InitiateAction;
begin
  inherited;
  Groups.InitiateActions;
end;

procedure TdxCustomNavBar.Invalidate;
begin
  if FPainter <> nil then
    Painter.InvalidateViewInfo(doRedraw);
  inherited;
end;

procedure TdxCustomNavBar.InvalidateAll(AType: TdxNavBarChangeType);
begin
  if csDestroying in ComponentState then exit;
  if FPainter <> nil then
    Painter.InvalidateViewInfo(AType);
  if HandleAllocated then
  begin
    if AType = doRecreate then
      RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ALLCHILDREN);
    Invalidate;
  end;
end;

procedure TdxCustomNavBar.InvalidateAll(AItem: TcxComponentCollectionItem;
  AAction: TcxComponentCollectionNotification);

  function GetUpdateType(AItem: TcxComponentCollectionItem;
    AAction: TcxComponentCollectionNotification): TdxNavBarChangeType;
  begin
    if (AItem <> nil) and (AAction = ccnChanged) then
      Result := doRecalc
    else
      Result := doRecreate;
  end;

begin
  InvalidateAll(GetUpdateType(AItem, AAction));
end;

procedure TdxCustomNavBar.InvalidateScrollButtons;
begin
  if csDestroying in ComponentState then exit;
  Painter.InvalidateViewInfo(doRedraw);
  if HandleAllocated then Painter.InvalidateScrollButtons;
end;

procedure TdxCustomNavBar.LoadFromRegIni(AStorage: TCustomIniFile; LoadStyles: Boolean);

  procedure ReadStyle(AIndex: Integer);
  var
    ASection, ABuffer, AText: string;
    AStream: TStringStream;
    AGraphicClass: TGraphicClass;
    AGraphic: TGraphic;
    AStyleItem: TdxNavBarStyleItem;
  begin
    with AStorage do
    begin
      ASection := 'Style' + IntToStr(AIndex);
      AStyleItem := Styles.Add;
      with AStyleItem.Style do
      begin
        BackColor := ReadInteger(ASection, 'BackColor', BackColor);
        BackColor2 := ReadInteger(ASection, 'BackColor2', BackColor2);
        AlphaBlending := ReadInteger(ASection, 'AlphaBlending', AlphaBlending);
        AlphaBlending2 := ReadInteger(ASection, 'AlphaBlending2', AlphaBlending2);
        Font.Charset := ReadInteger(ASection, 'FontCharset', Font.Charset);
        Font.Color := ReadInteger(ASection, 'FontColor', Font.Color);
        Font.Height :=ReadInteger(ASection, 'FontHeight', Font.Height);
        Font.Name := ReadString(ASection, 'FontName', Font.Name);
        Font.Pitch := TFontPitch(ReadInteger(ASection, 'FontPitch', Integer(Font.Pitch)));
        Font.Size := ReadInteger(ASection, 'FontSize', Font.Size);
        if ReadBool(ASection, 'FontStyleBold', fsBold in Font.Style) then
          Font.Style := Font.Style + [fsBold];
        if ReadBool(ASection, 'FontStyleItalic', fsItalic in Font.Style) then
          Font.Style := Font.Style + [fsItalic];
        if ReadBool(ASection, 'FontStyleUnderline', fsUnderline in Font.Style) then
          Font.Style := Font.Style + [fsUnderline];
        if ReadBool(ASection, 'FontStyleStrikeOut', fsStrikeOut in Font.Style) then
          Font.Style := Font.Style + [fsStrikeOut];
        GradientMode := TdxBarStyleGradientMode(ReadInteger(ASection, 'GradientMode', Integer(GradientMode)));
        if ValueExists(ASection, 'Image') then
        begin
          AText := ReadString(ASection, 'Image', '');
          SetLength(ABuffer, Length(AText) div 2);
          HexToBin(PChar(AText), PChar(ABuffer), Length(AText) div 2);
          AStream := TStringStream.Create(ABuffer);
          try
            AStream.Position := 0;
            AGraphicClass := TGraphicClass(GetClass(ReadString(ASection, 'ImageClass', '')));
            if AGraphicClass <> nil then
            begin
              AGraphic := AGraphicClass.Create;
              try
                AGraphic.LoadFromStream(AStream);
                Image.Graphic := AGraphic;
              finally
                AGraphic.Free;
              end;
            end;
          finally
            AStream.Free;
          end;
        end;
        HAlignment := TdxBarStyleHAlignment(ReadInteger(ASection, 'HAlignment', Integer(HAlignment)));
        VAlignment := TdxBarStyleVAlignment(ReadInteger(ASection, 'VAlignment', Integer(VAlignment)));
        AStyleItem.Tag := ReadInteger(ASection, 'Tag', AStyleItem.Tag);
      end;
    end;
  end;

  function GetCustomItem(ACollection: TdxNavBarCustomItems; const ASection: string): TdxNavBarCustomItem;
  var
    AItemIdentifier: string;
  begin
    Result := nil;
    AItemIdentifier := AStorage.ReadString(ASection, 'Name', '');
    if AItemIdentifier <> '' then
      Result := TdxNavBarCustomItem(ACollection.ItemByName(AItemIdentifier))
    else
    begin
      AItemIdentifier := AStorage.ReadString(ASection, 'Caption', '');
      if AItemIdentifier <> '' then
        Result := ACollection.ItemByCaption(AItemIdentifier);
    end;
    if Result = nil then
      Result := ACollection.Add;
  end;

  procedure ReadItem(AIndex: Integer);
  var
    AItem: TdxNavBarItem;
    ASection: string;
  begin
    ASection := 'Item' + IntToStr(AIndex);
    AItem := TdxNavBarItem(GetCustomItem(Items, ASection));
    AItem.Caption := AStorage.ReadString(ASection, 'Caption', AItem.Caption);
    AItem.Enabled := AStorage.ReadBool(ASection, 'Enabled', AItem.Enabled);
    AItem.Hint := AStorage.ReadString(ASection, 'Hint', AItem.Hint);
    AItem.LargeImageIndex := AStorage.ReadInteger(ASection, 'LargeImageIndex',
      AItem.LargeImageIndex);
    AItem.SmallImageIndex := AStorage.ReadInteger(ASection, 'SmallImageIndex',
      AItem.SmallImageIndex);
    if LoadStyles and (Styles.Count > 0) then
    begin
      if AStorage.ValueExists(ASection, 'StyleStyleIndex') then
        AItem.Style := Styles[AStorage.ReadInteger(ASection, 'StyleStyleIndex', 0)];
      if AStorage.ValueExists(ASection, 'StyleDisabledStyleIndex') then
        AItem.StyleDisabled := Styles[AStorage.ReadInteger(ASection, 'StyleDisabledStyleIndex', 0)];
      if AStorage.ValueExists(ASection, 'StyleHotTrackedStyleIndex') then
        AItem.StyleHotTracked := Styles[AStorage.ReadInteger(ASection, 'StyleHotTrackedStyleIndex', 0)];
      if AStorage.ValueExists(ASection, 'StylePressedStyleIndex') then
        AItem.StylePressed := Styles[AStorage.ReadInteger(ASection, 'StylePressedStyleIndex', 0)];
    end;
    AItem.Tag := AStorage.ReadInteger(ASection, 'Tag', AItem.Tag);
    AItem.Visible := AStorage.ReadBool(ASection, 'Visible', AItem.Visible);
  end;
  
  procedure ReadGroup(AIndex: Integer);
  var
    J, ALinkCount: Integer;
    ASection: string;
    AGroup: TdxNavBarGroup;
    AUseControl: Boolean;
    AControlName: string;
    AControl: TCustomControl;
    AItemIndex: Integer;
  begin
    ASection := 'Group' + IntToStr(AIndex);
    AGroup := TdxNavBarGroup(GetCustomItem(Groups, ASection));
    with AGroup do
    begin
      Caption := AStorage.ReadString(ASection, 'Caption', Caption);
      Expanded := AStorage.ReadBool(ASection, 'Expanded', Expanded);
      Hint := AStorage.ReadString(ASection, 'Hint', Hint);
      LargeImageIndex := AStorage.ReadInteger(ASection, 'LargeImageIndex', LargeImageIndex);
      LinksUseSmallImages := AStorage.ReadBool(ASection, 'LinksUseSmallImages', LinksUseSmallImages);
      ClearLinks;
      ALinkCount := AStorage.ReadInteger(ASection, 'LinkCount', 0);
      for J := 0 to ALinkCount - 1 do
      begin
        AItemIndex :=
          AStorage.ReadInteger(ASection, 'Link' + IntToStr(J) + 'ItemIndex', -1);
        if (AItemIndex >= 0) and (AItemIndex < Items.Count) then
          CreateLink(Items[AItemIndex]);
      end;
      SelectedLinkIndex := AStorage.ReadInteger(ASection, 'SelectedLinkIndex', SelectedLinkIndex);
      ShowAsIconView := AStorage.ReadBool(ASection, 'ShowAsIconView', ShowAsIconView);
      ShowExpandButton := AStorage.ReadBool(ASection, 'ShowExpandButton', ShowExpandButton);
      SmallImageIndex := AStorage.ReadInteger(ASection, 'SmallImageIndex', SmallImageIndex);
      if LoadStyles and (Styles.Count > 0) then
      begin
        if AStorage.ValueExists(ASection, 'StyleBackgroundStyleIndex') then
          StyleBackground := Styles[AStorage.ReadInteger(ASection, 'StyleBackgroundStyleIndex', 0)];
        if AStorage.ValueExists(ASection, 'StyleHeaderStyleIndex') then
          StyleHeader := Styles[AStorage.ReadInteger(ASection, 'StyleHeaderStyleIndex', 0)];
        if AStorage.ValueExists(ASection, 'StyleHeaderActiveStyleIndex') then
          StyleHeaderActive := Styles[AStorage.ReadInteger(ASection, 'StyleHeaderActiveStyleIndex', 0)];
        if AStorage.ValueExists(ASection, 'StyleHeaderHotTrackedStyleIndex') then
          StyleHeaderHotTracked := Styles[AStorage.ReadInteger(ASection, 'StyleHeaderHotTrackedStyleIndex', 0)];
        if AStorage.ValueExists(ASection, 'StyleHeaderPressedStyleIndex') then
          StyleHeaderPressed := Styles[AStorage.ReadInteger(ASection, 'StyleHeaderPressedStyleIndex', 0)];
      end;
      Tag := AStorage.ReadInteger(ASection, 'Tag', Tag);
      TopVisibleLinkIndex := AStorage.ReadInteger(ASection, 'TopVisibleLinkIndex', TopVisibleLinkIndex);
      UseSmallImages := AStorage.ReadBool(ASection, 'UseSmallImages', UseSmallImages);
      Visible := AStorage.ReadBool(ASection, 'Visible', Visible);

      AUseControl := AStorage.ReadBool(ASection, 'UseControl', UseControl);
      if AUseControl then
      begin
        AControlName := AStorage.ReadString(ASection, 'ControlName', '');
        AControl := TCustomControl(Owner.FindComponent(AControlName));
        if AControl is TdxNavBarGroupControl then
        begin
          AGroup.AcceptControl(AControl as TdxNavBarGroupControl);
          UseControl := AUseControl;
          ShowControl := AStorage.ReadBool(ASection, 'ShowControl', ShowControl);
        end;
      end;
    end;
    AGroup.Index := AIndex;
  end;

var
  AActiveGroupIndex, ACount, I: Integer;
  AGroupControl: TdxNavBarGroupControl;
  AGroupControls: TList;
begin
  View := AStorage.ReadInteger('Layout', 'View', View);

  if LoadStyles and AStorage.ValueExists('Layout', 'StyleCount') then
  begin
    Styles.Clear;
    ACount := AStorage.ReadInteger('Layout', 'StyleCount', Styles.Count);
    for I := 0 to ACount - 1 do
      ReadStyle(I);
  end;

  if AStorage.ValueExists('Layout', 'ItemCount') then
  begin
    ACount := AStorage.ReadInteger('Layout', 'ItemCount', Items.Count);
    for I := 0 to ACount - 1 do
      ReadItem(I);
  end;

  if AStorage.ValueExists('Layout', 'GroupCount') then
  begin
    AGroupControls := TList.Create;
    try
      for I := 0 to Groups.Count - 1 do
      begin
        if Groups[I].UseControl and (Groups[I].Control <> nil) then
        begin
          AGroupControls.Add(Groups[I].Control);
          Groups[I].ReleaseControl;
        end;
      end;
      ACount := AStorage.ReadInteger('Layout', 'GroupCount', Groups.Count);
      for I := 0 to ACount - 1 do
        ReadGroup(I);
      for I := 0 to AGroupControls.Count - 1 do
      begin
        AGroupControl := TdxNavBarGroupControl(AGroupControls[I]);
        if AGroupControl.Group = nil then
          AGroupControl.Free;
      end;
    finally
      AGroupControls.Free;
    end;
  end;
  AActiveGroupIndex := AStorage.ReadInteger('Layout', 'ActiveGroup', ActiveGroupIndex);
  if (0 <= AActiveGroupIndex) and (AActiveGroupIndex < Groups.Count) then
    ActiveGroupIndex := AActiveGroupIndex;
  NavigationPaneMaxVisibleGroups := AStorage.ReadInteger('Layout',
    'NavigationPaneMaxVisibleGroups', NavigationPaneMaxVisibleGroups);

  if LoadStyles and (Styles.Count > 0) then
  begin
    if AStorage.ValueExists('Layout', 'StyleBackgroundStyleIndex') then
      StyleBackground := Styles[AStorage.ReadInteger('Layout', 'StyleBackgroundStyleIndex', 0)];
    if AStorage.ValueExists('Layout', 'StyleButtonStyleIndex') then
      StyleButton := Styles[AStorage.ReadInteger('Layout', 'StyleButtonStyleIndex', 0)];
    if AStorage.ValueExists('Layout', 'StyleButtonHotTrackedStyleIndex') then
      StyleButtonHotTracked := Styles[AStorage.ReadInteger('Layout', 'StyleButtonHotTrackedStyleIndex', 0)];
    if AStorage.ValueExists('Layout', 'StyleButtonPressedStyleIndex') then
      StyleButtonPressed := Styles[AStorage.ReadInteger('Layout', 'StyleButtonPressedStyleIndex', 0)];
    if AStorage.ValueExists('Layout', 'StyleDropTargetGroupStyleIndex') then
      StyleDropTargetGroup := Styles[AStorage.ReadInteger('Layout', 'StyleDropTargetGroupStyleIndex', 0)];
    if AStorage.ValueExists('Layout', 'StyleDropTargetLinkStyleIndex') then
      StyleDropTargetLink := Styles[AStorage.ReadInteger('Layout', 'StyleDropTargetLinkStyleIndex', 0)];
    if AStorage.ValueExists('Layout', 'StyleHintStyleIndex') then
      StyleHint := Styles[AStorage.ReadInteger('Layout', 'StyleHintPressedStyleIndex', 0)];
    if AStorage.ValueExists('Layout', 'StyleNavigationPaneHeaderStyleIndex') then
      StyleNavigationPaneHeader := Styles[AStorage.ReadInteger('Layout', 'StyleNavigationPaneHeaderStyleIndex', 0)];
  end;
end;

procedure TdxCustomNavBar.SaveToRegIni(AStorage: TCustomIniFile; SaveStyles: Boolean);

  procedure WriteStyle(AStyleItem: TdxNavBarStyleItem);
  var
    ASection, AText: string;
    AStream: TStringStream;
  begin
    with AStorage do
    begin
      ASection := 'Style' + IntToStr(AStyleItem.Index);
      with AStyleItem.Style do
      begin
        if savBackColor in AssignedValues then
          WriteInteger(ASection, 'BackColor', BackColor);
        if savBackColor2 in AssignedValues then
          WriteInteger(ASection, 'BackColor2', BackColor2);
        if savAlphaBlending in AssignedValues then
          WriteInteger(ASection, 'AlphaBlending', AlphaBlending);
        if savAlphaBlending2 in AssignedValues then
          WriteInteger(ASection, 'AlphaBlending2', AlphaBlending2);
        if savFont in AssignedValues then
        begin
          WriteInteger(ASection, 'FontCharset', Integer(Font.Charset));
          WriteInteger(ASection, 'FontColor', Font.Color);
          WriteInteger(ASection, 'FontHeight', Font.Height);
          WriteString(ASection, 'FontName', Font.Name);
          WriteInteger(ASection, 'FontPitch', Integer(Font.Pitch));
          WriteInteger(ASection, 'FontSize', Font.Size);
          WriteBool(ASection, 'FontStyleBold', fsBold in Font.Style);
          WriteBool(ASection, 'FontStyleItalic', fsItalic in Font.Style);
          WriteBool(ASection, 'FontStyleUnderline', fsUnderline in Font.Style);
          WriteBool(ASection, 'FontStyleStrikeOut', fsStrikeOut in Font.Style);
        end;
        if savGradientMode in AssignedValues then
          WriteInteger(ASection, 'GradientMode', Integer(GradientMode));
        if (savImage in AssignedValues) and (Image.Graphic <> nil) and
          not Image.Graphic.Empty then
        begin
          AStream := TStringStream.Create('');
          try
            Image.Graphic.SaveToStream(AStream);
            AStream.Position := 0;
            SetLength(AText, Length(AStream.DataString) * 2);
            BinToHex(PChar(AStream.DataString), PChar(AText), Length(AStream.DataString));
            WriteString(ASection, 'ImageClass', Image.Graphic.ClassName);
            WriteString(ASection, 'Image', AText);
          finally
            AStream.Free;
          end;
        end;
        if savHAlignment in AssignedValues then
          WriteInteger(ASection, 'HAlignment', Integer(HAlignment));
        if savVAlignment in AssignedValues then
          WriteInteger(ASection, 'VAlignment', Integer(VAlignment));
        WriteInteger(ASection, 'Tag', AStyleItem.Tag);
      end;
    end;
  end;
  
  procedure WriteItem(AItem: TdxNavBarItem);
  var
    ASection: string;
  begin
    ASection := 'Item' + IntToStr(AItem.Index);
    AStorage.WriteString(ASection, 'Caption', AItem.Caption);
    AStorage.WriteBool(ASection, 'Enabled', AItem.Enabled);
    AStorage.WriteString(ASection, 'Hint', AItem.Hint);
    AStorage.WriteInteger(ASection, 'LargeImageIndex', AItem.LargeImageIndex);
    AStorage.WriteString(ASection, 'Name', AItem.Name);
    AStorage.WriteInteger(ASection, 'SmallImageIndex', AItem.SmallImageIndex);
    if SaveStyles and (Styles.Count > 0) then
    begin
      if AItem.Style <> nil then
        AStorage.WriteInteger(ASection, 'StyleStyleIndex', AItem.Style.Index);
      if AItem.StyleDisabled <> nil then
        AStorage.WriteInteger(ASection, 'StyleDisabledStyleIndex', AItem.StyleDisabled.Index);
      if AItem.StyleHotTracked <> nil then
        AStorage.WriteInteger(ASection, 'StyleHotTrackedStyleIndex', AItem.StyleHotTracked.Index);
      if AItem.StylePressed <> nil then
        AStorage.WriteInteger(ASection, 'StylePressedStyleIndex', AItem.StylePressed.Index);
    end;
    AStorage.WriteInteger(ASection, 'Tag', AItem.Tag);
    AStorage.WriteBool(ASection, 'Visible', AItem.Visible);
  end;
  
  procedure WriteGroup(AGroup: TdxNavBarGroup);
  var
    J: Integer;
    ASection: string;
  begin
    with AStorage do
    begin
      ASection := 'Group' + IntToStr(AGroup.Index);
      with AGroup do
      begin
        WriteString(ASection, 'Caption', Caption);
        WriteBool(ASection, 'Expanded', Expanded);
        WriteString(ASection, 'Hint', Hint);
        WriteInteger(ASection, 'LargeImageIndex', LargeImageIndex);
        WriteInteger(ASection, 'LinkCount', LinkCount);
        for J := 0 to LinkCount - 1 do
          if Links[J].Item <> nil then
            WriteInteger(ASection, 'Link' + IntToStr(J) + 'ItemIndex', Links[J].Item.Index);
        WriteBool(ASection, 'LinksUseSmallImages', LinksUseSmallImages);
        WriteString(ASection, 'Name', Name);
        WriteInteger(ASection, 'SelectedLinkIndex', SelectedLinkIndex);
        WriteBool(ASection, 'ShowControl', ShowControl);
        WriteBool(ASection, 'ShowAsIconView', ShowAsIconView);
        WriteBool(ASection, 'ShowExpandButton', ShowExpandButton);
        WriteInteger(ASection, 'SmallImageIndex', SmallImageIndex);
        if SaveStyles and (Styles.Count > 0) then
        begin
          if StyleBackground <> nil then
            WriteInteger(ASection, 'StyleBackgroundStyleIndex', StyleBackground.Index);
          if StyleHeader <> nil then
            WriteInteger(ASection, 'StyleHeaderStyleIndex', StyleHeader.Index);
          if StyleHeaderActive <> nil then
            WriteInteger(ASection, 'StyleHeaderActiveStyleIndex', StyleHeaderActive.Index);
          if StyleHeaderHotTracked <> nil then
            WriteInteger(ASection, 'StyleHeaderHotTrackedStyleIndex', StyleHeaderHotTracked.Index);
          if StyleHeaderPressed <> nil then
            WriteInteger(ASection, 'StyleHeaderPressedStyleIndex', StyleHeaderPressed.Index);
        end;
        WriteInteger(ASection, 'Tag', Tag);
        WriteInteger(ASection, 'TopVisibleLinkIndex', TopVisibleLinkIndex);
        WriteBool(ASection, 'UseSmallImages', UseSmallImages);
        WriteBool(ASection, 'Visible', Visible);

        WriteBool(ASection, 'UseControl', UseControl);
        if UseControl then
        begin
          WriteBool(ASection, 'ShowControl', ShowControl);
          if Control <> nil then
            WriteString(ASection, 'ControlName', Control.Name);
        end;
      end;
    end;
  end;
  
var
  I: Integer;
  ASections: TStringList;
begin
  with AStorage do
  begin
    ASections := TStringList.Create;
    try
      ReadSections(ASections);
      for I := 0 to ASections.Count - 1 do
        if (Pos('Layout', ASections[I]) > 0) or (Pos('Group', ASections[I]) > 0) or
          (Pos('Item', ASections[I]) > 0) or (Pos('Style', ASections[I]) > 0) then
        EraseSection(ASections[I]);
    finally
      ASections.Free;
    end;

    WriteInteger('Layout', 'View', View);
    if SaveStyles then
    begin
      WriteInteger('Layout', 'StyleCount', Styles.Count);
      for I := 0 to Styles.Count - 1 do
        WriteStyle(Styles[I]);
    end;
    WriteInteger('Layout', 'ItemCount', Items.Count);
    for I := 0 to Items.Count - 1 do
      WriteItem(Items[I]);
    WriteInteger('Layout', 'GroupCount', Groups.Count);
    for I := 0 to Groups.Count - 1 do
      WriteGroup(Groups[I]);
    if SaveStyles and (Styles.Count > 0) then
    begin
      if StyleBackground <> nil then
        WriteInteger('Layout', 'StyleBackgroundStyleIndex', StyleBackground.Index);
      if StyleButton <> nil then
        WriteInteger('Layout', 'StyleButtonStyleIndex', StyleButton.Index);
      if StyleButtonHotTracked <> nil then
        WriteInteger('Layout', 'StyleButtonHotTrackedStyleIndex', StyleButtonHotTracked.Index);
      if StyleButtonPressed <> nil then
        WriteInteger('Layout', 'StyleButtonPressedStyleIndex', StyleButtonPressed.Index);
      if StyleDropTargetGroup <> nil then
        WriteInteger('Layout', 'StyleDropTargetGroupStyleIndex', StyleDropTargetGroup.Index);
      if StyleDropTargetLink <> nil then
        WriteInteger('Layout', 'StyleDropTargetLinkStyleIndex', StyleDropTargetLink.Index);
      if StyleHint <> nil then
        WriteInteger('Layout', 'StyleHintStyleIndex', StyleHint.Index);
      if StyleNavigationPaneHeader <> nil then
        WriteInteger('Layout', 'StyleNavigationPaneHeaderStyleIndex', StyleNavigationPaneHeader.Index);
    end;
    WriteInteger('Layout', 'ActiveGroup', ActiveGroupIndex);
    WriteInteger('Layout', 'NavigationPaneMaxVisibleGroups', NavigationPaneMaxVisibleGroups);
  end;
end;

function TdxCustomNavBar.CreatePainter: TdxNavBarPainter;
begin
  Result := dxNavBarViewsFactory.PainterClasses[FView].Create(Self);
end;

function TdxCustomNavBar.GetGroupClass: TdxNavBarGroupClass;
begin
  Result := TdxNavBarGroup;
end;

function TdxCustomNavBar.GetItemClass: TdxNavBarItemClass;
begin
  Result := TdxNavBarItem;
end;

function TdxCustomNavBar.GetActiveGroup: TdxNavBarGroup;
var
  I: Integer;
  AGroup: TdxNavBarGroup;
begin
  if (Groups = nil) or (Groups.Count = 0) then
    Result := nil
  else if (FActiveGroup = nil) or not FActiveGroup.Visible then
  begin
    AGroup := nil;
    for I := 0 to Groups.Count - 1 do
      if Groups[I].Visible then
      begin
        AGroup := Groups[I];
        break;
      end;
    if FActiveGroup = nil then
      FActiveGroup := AGroup;
    Result := AGroup;
  end
  else Result := FActiveGroup;
end;

function TdxCustomNavBar.GetActiveGroupIndex: Integer;
begin
  if ActiveGroup <> nil then
    Result := ActiveGroup.Index
  else Result := -1;
end;

function TdxCustomNavBar.GetNavigationPaneOverflowPanelItemCount: Integer;
begin
  if csLoading in ComponentState then
    Result := 0
  else
    if NavigationPaneMaxVisibleGroups = -1 then
      Result := 0
    else
      Result := Max(0, VisibleGroupCount - NavigationPaneMaxVisibleGroups);
end;

function TdxCustomNavBar.GetEnableDragging: Boolean;
begin
  Result := (dxNavBarDragObject <> nil) or FEnableDragging;
end;

function TdxCustomNavBar.GetPainter: TdxNavBarPainter;
begin
  if FPainter = nil then
    FPainter := CreatePainter;
  Result := FPainter;
end;

function TdxCustomNavBar.GetScrollPosition: Integer;
begin
  if (FScrollBar <> nil) and FScrollBar.Visible then
    Result := FScrollBar.Position
  else Result := 0;
end;

function TdxCustomNavBar.GetSourceGroup: TdxNavBarGroup;
begin
  if EnableDragging and (dxNavBarDragObject <> nil) then
    Result := dxNavBarDragObject.SourceGroup
  else Result := FSourceGroup;
end;

function TdxCustomNavBar.GetSourceLink: TdxNavBarItemLink;
begin
  if EnableDragging and (dxNavBarDragObject <> nil) then
    Result := dxNavBarDragObject.SourceLink
  else Result := FSourceLink;
end;

function TdxCustomNavBar.GetSourceItem: TdxNavBarItem;
begin
  if EnableDragging and (dxNavBarDragObject <> nil) then
    Result := dxNavBarDragObject.SourceItem
  else Result := nil;
end;

function TdxCustomNavBar.GetTargetGroup: TdxNavBarGroup;
begin
  if dxNavBarDragObject <> nil then
    Result := dxNavBarDragObject.TargetGroup
  else Result := nil;
end;

function TdxCustomNavBar.GetTargetLink1: TdxNavBarItemLink;
begin
  if dxNavBarDragObject <> nil then
    Result := dxNavBarDragObject.TargetLink1
  else Result := nil;
end;

function TdxCustomNavBar.GetTargetLink2: TdxNavBarItemLink;
begin
  if dxNavBarDragObject <> nil then
    Result := dxNavBarDragObject.TargetLink2
  else Result := nil;
end;

function TdxCustomNavBar.GetTargetLinkIndex: Integer;
begin
  if dxNavBarDragObject <> nil then
    Result := dxNavBarDragObject.TargetLinkIndex
  else Result := -1;
end;

function TdxCustomNavBar.GetViewInfo: TdxNavBarViewInfo;
begin
  if Painter <> nil then
    Result := Painter.ViewInfo
  else Result := nil;
end;

function TdxCustomNavBar.GetViewStyle: TdxNavBarPainter;
begin
  Result := FPainter; 
end;

function TdxCustomNavBar.GetVisibleGroupCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Groups.Count - 1 do
    if Groups[I].Visible then Inc(Result);
end;

procedure TdxCustomNavBar.SetActiveGroup(Value: TdxNavBarGroup);
var
  AAllowChanging: Boolean;
begin
  if FActiveGroup <> Value then
  begin
    AAllowChanging := True;
    DoActiveGroupChanging(Value, AAllowChanging);
    if AAllowChanging then
    begin
      FActiveGroup := Value;
      InvalidateAll(doRecreate);
      DoActiveGroupChanged;
    end;
  end;
end;

procedure TdxCustomNavBar.SetActiveGroupIndex(Value: Integer);
begin
  if not (csLoading in ComponentState) then
  begin
    if (0 <= Value) and (Value < Groups.Count) then
      ActiveGroup := Groups[Value];
  end
  else FActiveGroupIndex := Value;
end;

procedure TdxCustomNavBar.SetAllowSelectLinks(const Value: Boolean);
begin
  if FAllowSelectLinks <> Value then
  begin
    FAllowSelectLinks := Value;
    if not FAllowSelectLinks then DeSelectLinks;
    InvalidateAll(doRedraw);
  end;
end;

procedure TdxCustomNavBar.SetDefaultStyles(const Value: TdxNavBarDefaultStyles);
begin
  FDefaultStyles.Assign(Value);
end;

procedure TdxCustomNavBar.SetEachGroupHasSelectedLink(const Value: Boolean);
begin
  if FEachGroupHasSelectedLink <> Value then
  begin
    FEachGroupHasSelectedLink := Value;
    if not FEachGroupHasSelectedLink then DeSelectLinks;
    InvalidateAll(doRedraw);
  end;
end;

procedure TdxCustomNavBar.SetLargeImages(const Value: TCustomImageList);
begin
  cxSetImageList(Value, FLargeImages, FLargeChangeLink, Self);
end;

procedure TdxCustomNavBar.SetNavigationPaneOverflowPanelUseSmallImages(const Value: Boolean);
begin
  if FNavigationPaneOverflowPanelUseSmallImages <> Value then
  begin
    FNavigationPaneOverflowPanelUseSmallImages := Value;
    InvalidateAll(doRecreate);
  end;
end;

procedure TdxCustomNavBar.SetNavigationPaneMaxVisibleGroups(Value: Integer);
begin
  if Value < -1 then Value := -1;
  if FNavigationPaneMaxVisibleGroups <> Value then
  begin
    FNavigationPaneMaxVisibleGroups := Value;
    InvalidateAll(doRecreate);
  end;
end;

procedure TdxCustomNavBar.SetShowGroupCaptions(const Value: Boolean);
begin
  if FShowGroupCaptions <> Value then
  begin
    FShowGroupCaptions := Value;
    InvalidateAll(doRecreate);
  end;
end;

procedure TdxCustomNavBar.SetShowSpecialGroup(const Value: Boolean);
begin
  if FShowSpecialGroup <> Value then
  begin
    FShowSpecialGroup := Value;
    InvalidateAll(doRecreate);
  end;
end;

procedure TdxCustomNavBar.SetSmallImages(const Value: TCustomImageList);
begin
  cxSetImageList(Value, FSmallImages, FSmallChangeLink, Self);
end;

procedure TdxCustomNavBar.SetSpaceBetweenGroups(Value: Integer);
begin
  if FSpaceBetweenGroups <> Value then
  begin
    if Value < 0 then Value := 0;
    FSpaceBetweenGroups := Value;
    InvalidateAll(doRecalc);
  end;
end;

procedure TdxCustomNavBar.SetStyleBackground(const Value: TdxNavBarStyleItem);
begin
  if FStyleBackground <> Value then
  begin
    FStyleBackground := Value;
    InvalidateAll(doRecreate);
  end;
end;

procedure TdxCustomNavBar.SetStyleHint(const Value: TdxNavBarStyleItem);
begin
  if FStyleHint <> Value then
  begin
    FStyleHint := Value;
    InvalidateAll(doRecreate);
  end;
end;

procedure TdxCustomNavBar.SetStyleDropTargetGroup(const Value: TdxNavBarStyleItem);
begin
  if FStyleDropTargetGroup <> Value then
  begin
    FStyleDropTargetGroup := Value;
    InvalidateAll(doRecreate);
  end;
end;

procedure TdxCustomNavBar.SetStyleDropTargetLink(const Value: TdxNavBarStyleItem);
begin
  if FStyleDropTargetLink <> Value then
  begin
    FStyleDropTargetLink := Value;
    InvalidateAll(doRecreate);
  end;
end;

procedure TdxCustomNavBar.SetStyleButton(const Value: TdxNavBarStyleItem);
begin
  if FStyleButton <> Value then
  begin
    FStyleButton := Value;
    InvalidateAll(doRecreate);
  end;
end;

procedure TdxCustomNavBar.SetStyleButtonHotTracked(const Value: TdxNavBarStyleItem);
begin
  if FStyleButtonHotTracked <> Value then
  begin
    FStyleButtonHotTracked := Value;
    InvalidateAll(doRecreate);
  end;
end;

procedure TdxCustomNavBar.SetStyleButtonPressed(const Value: TdxNavBarStyleItem);
begin
  if FStyleButtonPressed <> Value then
  begin
    FStyleButtonPressed := Value;
    InvalidateAll(doRecreate);
  end;
end;

procedure TdxCustomNavBar.SetStyleNavigationPaneHeader(const Value: TdxNavBarStyleItem);
begin
  if FStyleNavigationPaneHeader <> Value then
  begin
    FStyleNavigationPaneHeader := Value;
    InvalidateAll(doRecreate);
  end;
end;

procedure TdxCustomNavBar.SetView(Value: Integer);
begin
  if FView <> Value then
  begin
    Value := Min(Max(Value, 0), dxNavBarViewsFactory.Count - 1);
    FView := Value;
    FPainter.Free;
    FPainter := CreatePainter;
    if ScrollBar <> nil then
      ScrollBar.Visible := False;
    AssignDefaultStyles;
    InvalidateAll(doRecreate);
    DesignerUpdate(nil);
    DoUpdateScrollBarStyle;
  end;
end;

procedure TdxCustomNavBar.SetViewStyle(Value: TdxNavBarPainter);
begin
  if Value = nil then
    SetView(0)
  else
  begin
    FreeAndNil(FPainter);
    FPainter := Value;
    AssignDefaultStyles;
    InvalidateAll(doRecreate);
    DesignerUpdate(nil);
  end;
end;

procedure TdxCustomNavBar.AssignDefaultStyles;
begin
  if csLoading in ComponentState then exit;
  DefaultStyles.AssignDefaultValues(False);
  InvalidateAll(doRecalc);
end;

procedure TdxCustomNavBar.LoadFromIniFile(AFileName: string; LoadStyles: Boolean = True);
var
  AStream: TFileStream;
begin
  if AFileName = '' then exit;
{$IFDEF DELPHI6}
  AStream := TFileStream.Create(AFileName, fmOpenRead, fmShareDenyWrite);
{$ELSE}
  AStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
{$ENDIF}
  try
    LoadFromStream(AStream, LoadStyles);
  finally
    AStream.Free;
  end;
end;

procedure TdxCustomNavBar.LoadFromRegistry(ARegistryPath: string; LoadStyles: Boolean = True);
var
  Storage: TRegistryIniFile;
begin
  if ARegistryPath = '' then exit;
  Storage := TRegistryIniFile.Create(ARegistryPath);
  try
    LoadFromRegIni(Storage, LoadStyles);
  finally
    Storage.Free;
  end;
end;

procedure TdxCustomNavBar.LoadFromStream(AStream: TStream; LoadStyles: Boolean = True);
var
  Storage: TMemIniFile;
  AStrings: TStringList;
begin
  Storage := TMemIniFile.Create('');
  AStrings := TStringList.Create;
  try
    AStrings.LoadFromStream(AStream);
    Storage.SetStrings(AStrings);
    LoadFromRegIni(Storage, LoadStyles);
  finally
    AStrings.Free;
    Storage.Free;
  end;
end;

procedure TdxCustomNavBar.SaveToIniFile(AFileName: string; SaveStyles: Boolean = True);
var
  AStream: TFileStream;
begin
  if AFileName = '' then Exit;
{$IFDEF DELPHI6}
  AStream := TFileStream.Create(AFileName, fmCreate, fmShareExclusive);
{$ELSE}
  AStream := TFileStream.Create(AFileName, fmCreate or fmShareExclusive);
{$ENDIF}
  try
    SaveToStream(AStream, SaveStyles);
  finally
    AStream.Free;
  end;
end;

procedure TdxCustomNavBar.SaveToRegistry(ARegistryPath: string; SaveStyles: Boolean = True);
var
  Storage: TRegistryIniFile;
begin
  if ARegistryPath = '' then exit;
  Storage := TRegistryIniFile.Create(ARegistryPath);
  try
    SaveToRegIni(Storage, SaveStyles);
  finally
    Storage.Free;
  end;
end;

procedure TdxCustomNavBar.SaveToStream(AStream: TStream; SaveStyles: Boolean = True);
var
  Storage: TMemIniFile;
  AStrings: TStringList;
begin
  Storage := TMemIniFile.Create('');
  AStrings := TStringList.Create;
  try
    SaveToRegIni(Storage, SaveStyles);
    Storage.GetStrings(AStrings);
    AStrings.SaveToStream(AStream);
  finally
    AStrings.Free;
    Storage.Free;
  end;
end;

function TdxCustomNavBar.GetGroupAtCaptionPos(pt: TPoint): TdxNavBarGroup;
begin
  Result := ViewInfo.GetGroupAtCaptionPos(pt);
end;

function TdxCustomNavBar.GetGroupAtItemsPos(pt: TPoint): TdxNavBarGroup;
begin
  Result := ViewInfo.GetGroupAtItemsPos(pt);
end;

function TdxCustomNavBar.GetLinkAtPos(pt: TPoint): TdxNavBarItemLink;
begin
  Result := ViewInfo.GetLinkAtPos(pt);
end;

function TdxCustomNavBar.GetLinkAtSelectedPos(pt: TPoint): TdxNavBarItemLink;
begin
  Result := ViewInfo.GetLinkAtSelectedPos(pt);
end;

function TdxCustomNavBar.IsPtTopScrollButton(pt: TPoint): Boolean;
begin
  Result := ViewInfo.IsPtTopScrollButton(pt);
end;

function TdxCustomNavBar.IsPtBottomScrollButton(pt: TPoint): Boolean;
begin
  Result := ViewInfo.IsPtBottomScrollButton(pt);
end;

function TdxCustomNavBar.IsTopScrollButtonVisible: Boolean;
begin
  Result := ViewInfo.IsTopScrollButtonVisible;
end;

function TdxCustomNavBar.IsBottomScrollButtonVisible: Boolean;
begin
  Result := ViewInfo.IsBottomScrollButtonVisible;
end;

function TdxCustomNavBar.IsPtNavigationPaneHeader(pt: TPoint): Boolean;
begin
  Result := ViewInfo.IsPtNavigationPaneHeader(pt);
end;

function TdxCustomNavBar.IsPtNavigationPaneSplitter(pt: TPoint): Boolean;
begin
  Result := ViewInfo.IsPtNavigationPaneSplitter(pt);
end;

function TdxCustomNavBar.IsPtNavigationPaneOverflowPanel(pt: TPoint): Boolean;
begin
  Result := ViewInfo.IsPtNavigationPaneOverflowPanel(pt);
end;

procedure TdxCustomNavBar.MakeLinkVisible(ALink: TdxNavBarItemLink);
begin
  ViewInfo.MakeLinkVisible(ALink);
end;

procedure TdxCustomNavBar.MakeGroupVisible(AGroup: TdxNavBarGroup);
begin
  ViewInfo.MakeGroupVisible(AGroup);
end;

procedure TdxCustomNavBar.BeginUpdate;
begin
  Inc(FUpdateLock);
end;

procedure TdxCustomNavBar.EndUpdate;
begin
  Dec(FUpdateLock);
  if FUpdateLock = 0 then InvalidateAll(doRecreate);
end;

function TdxCustomNavBar.CanDecNavigationPaneOverflowPanelItemCount: Boolean;
begin
  Result := ShowGroupCaptions and (NavigationPaneOverflowPanelItemCount > 0);
end;

function TdxCustomNavBar.CanIncNavigationPaneOverflowPanelItemCount: Boolean;
begin
  Result := ShowGroupCaptions and (NavigationPaneOverflowPanelItemCount < VisibleGroupCount);
end;

procedure TdxCustomNavBar.DoDecNavigationPaneOverflowPanelItemCount;
begin
  if NavigationPaneMaxVisibleGroups = VisibleGroupCount - 1 then
    NavigationPaneMaxVisibleGroups := -1
  else
    NavigationPaneMaxVisibleGroups := NavigationPaneMaxVisibleGroups + 1;
end;

procedure TdxCustomNavBar.DoIncNavigationPaneOverflowPanelItemCount;
begin
  if (NavigationPaneMaxVisibleGroups = -1) or
    (NavigationPaneMaxVisibleGroups > VisibleGroupCount) then
    NavigationPaneMaxVisibleGroups := VisibleGroupCount - 1
  else
    NavigationPaneMaxVisibleGroups := NavigationPaneMaxVisibleGroups - 1;
end;

procedure TdxCustomNavBar.DragDone;
begin
  dxNavBarDragObject.Free;
  dxNavBarDragObject := nil;
  FEnableDragging := False;
  DragMode := dmManual;
  FSourceGroup := nil;
  FSourceLink := nil;
end;

function TdxCustomNavBar.IsAllowDragLink: Boolean;
begin
  Result := fAllowDragLink in FDragDropFlags;
end;

function TdxCustomNavBar.IsAllowDropLink: Boolean;
begin
  Result := fAllowDropLink in FDragDropFlags;
end;

function TdxCustomNavBar.IsAllowDragGroup: Boolean;
begin
  Result := fAllowDragGroup in FDragDropFlags;
end;

function TdxCustomNavBar.IsAllowDropGroup: Boolean;
begin
  Result := fAllowDropGroup in FDragDropFlags;
end;

procedure TdxCustomNavBar.CMMouseEnter(var Message: TMessage);
begin
  MouseEnter;
end;

procedure TdxCustomNavBar.CMMouseLeave(var Message: TMessage);
begin
  MouseLeave;
end;

procedure TdxCustomNavBar.CMSysColorChange(var Message: TMessage);
begin
  ViewInfo.RefreshColors;
  InvalidateAll(doRedraw);
end;

procedure TdxCustomNavBar.WMVScroll(var Message: TWMVScroll);
var
  AScrollPos: Integer;
begin
  inherited;
  AScrollPos := Message.Pos;
  ScrollBar.Scroll(ScrollBar, TScrollCode(Message.ScrollCode), AScrollPos);
end;

procedure TdxCustomNavBar.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TdxCustomNavBar.WMSetCursor(var Msg: TWMSetCursor);

  function IsNavPaneHot: Boolean;
  begin
    Result := (FNavigationPaneOverflowPanelHotTrackedIndex <> -1) or NavigationPaneOverflowPanelSignHotTracked;
  end;

begin
  if (EnableSplitterDragging or IsPtNavigationPaneSplitter(TargetPoint)) and ShowGroupCaptions then
    SetCursor(Screen.Cursors[crSizeNS])
  else if IsNavPaneHot then
    SetCursor(Screen.Cursors[FHotTrackedGroupCursor])
  else if FHotTrackedGroup <> nil then
    SetCursor(Screen.Cursors[FHotTrackedGroupCursor])
  else if (HotTrackedLink <> nil) and (HotTrackedLink.Item.Enabled) then
    SetCursor(Screen.Cursors[HotTrackedLinkCursor])
  else inherited;
end;

procedure TdxCustomNavBar.WMCreate(var Msg: TWMCreate);
begin
  inherited;
  InvalidateAll(doRecreate);
end;

{ TdxNabBarDragObject }

constructor TdxNavBarDragObject.Create(ANavBar: TdxCustomNavBar;
    var DragObject: TDragObject {deprecated};
    ASourceGroup: TdxNavBarGroup; ASourceLink: TdxNavBarItemLink; ASourceItem: TdxNavBarItem);
begin
  inherited Create;
  FNavBar := ANavBar;
  FSourceLink := ASourceLink;
  FSourceGroup := ASourceGroup;
  FSourceItem := ASourceItem;
end;

procedure TdxNavBarDragObject.UpdateTargets;
begin
  if SourceGroup <> nil then
  begin
    FTargetGroup := NavBar.ViewInfo.GetGroupAtCaptionPos(NavBar.TargetPoint);
    if FTargetGroup = nil then
      FTargetGroup := NavBar.ViewInfo.GetGroupAtItemsPos(NavBar.TargetPoint);
  end
  else if (SourceLink <> nil) or (SourceItem <> nil) then
    FTargetLinkIndex := NavBar.ViewInfo.GetLinksAtDragPosition(NavBar.TargetPoint,
      FTargetGroup, FTargetLink1, FTargetLink2);
end;

function TdxNavBarDragObject.GetSourceItem: TdxNavBarItem;
begin
  if FSourceItem <> nil then
    Result := FSourceItem
  else if (GetKeyState(VK_CONTROL) < 0) and (FSourceLink <> nil) then
    Result := FSourceLink.Item
  else Result := nil;
end;

{ TdxNavBarScrollBar }

constructor TdxNavBarScrollBar.Create(AParent: TWinControl; AKind: TScrollBarKind);
begin
  inherited Create;
  FParent := AParent;
  FScrollBar := TcxScrollBar.Create(nil);
  FScrollBar.ControlStyle := FScrollBar.ControlStyle + [csNoDesignVisible];
  FScrollBar.Parent := FParent;
  FScrollBar.Kind := AKind;
  FScrollBar.OnScroll := Scroll;
  Reset;
  FKind := AKind;
end;

destructor TdxNavBarScrollBar.Destroy;
begin
  FreeAndNil(FScrollBar);
  inherited Destroy;
end;

procedure TdxNavBarScrollBar.SetScrollParams(AMin, AMax, APosition, APageSize: Integer; ARedraw:
  Boolean = True);
var
  AClientRect: TRect;
begin
  if (AMax < AMin) or (AMax < APageSize) then
    raise EInvalidOperation.Create(SScrollBarRange);

  CorrectPos(APosition, AMin, AMax, APageSize);
  AClientRect := FParent.ClientRect;
  with AClientRect do
    if FScrollBar.Kind = sbVertical then
      FScrollBar.SetBounds(Right, 0, Self.Width, Bottom - Top)
    else
      FScrollBar.SetBounds(Left, Bottom, Right - Left, Self.Height);

  if (Min <> AMin) or (Max <> AMax) or (PageSize <> APageSize) or (Position <> APosition) then
  begin
    FScrollInfo.nMin := AMin;
    FScrollInfo.nMax := AMax;
    FScrollInfo.nPage := APageSize;
    FScrollInfo.nPos := APosition;
    with FScrollInfo do
      FScrollBar.SetScrollParams(nMin, nMax, APosition, APageSize, ARedraw);
    FLargeChange := FScrollInfo.nPage;
  end;
end;

procedure TdxNavBarScrollBar.Reset;
begin
  ZeroMemory(@FScrollInfo, FScrollInfo.cbSize);
  FScrollInfo.cbSize := SizeOf(FScrollInfo);
  FScrollInfo.fMask := SIF_ALL;
  FScrollInfo.nMax := 100;
  FScrollBar.Visible := False;
  FVisible := False;
end;

procedure TdxNavBarScrollBar.Scroll(Sender: TObject; AScrollCode: TScrollCode; var AScrollPos: Integer);

  procedure DoScroll(AScrollCode: TScrollCode; var AScrollPos: Integer);
  begin
    if Assigned(OnScroll) then
      OnScroll(Self, AScrollCode, AScrollPos);
  end;

var
  ANewPos: Integer;
begin
  ANewPos := Position;
  case AScrollCode of
    scLineUp: Dec(ANewPos, SmallChange);
    scLineDown: Inc(ANewPos, SmallChange);
    scPageUp: Dec(ANewPos, LargeChange);
    scPageDown: Inc(ANewPos, LargeChange);
    scPosition, scTrack: ANewPos := AScrollPos;
    scTop: ANewPos := Min;
    scBottom: ANewPos := Max;
  end;
  Position := ANewPos;
  AScrollPos := ANewPos;
  DoScroll(AScrollCode, AScrollPos);
end;

procedure TdxNavBarScrollBar.CorrectPos(var APos: Integer;  AMin, AMax, APageSize: Integer);
begin
  if APos < AMin then
    APos := AMin;
  if APos > AMax - APageSize then
    APos := AMax - APageSize;
end;

function TdxNavBarScrollBar.GetHandle: THandle;
begin
  if FParent.HandleAllocated then
   Result := FParent.Handle
  else
    Result := 0;
end;

function TdxNavBarScrollBar.GetHeight: Integer;
begin
  Result := FParent.ClientHeight;
end;

function TdxNavBarScrollBar.GetMax: Integer;
begin
  Result := FScrollInfo.nMax;
end;

function TdxNavBarScrollBar.GetMin: Integer;
begin
  Result := FScrollInfo.nMin;
end;

function TdxNavBarScrollBar.GetPageSize: Integer;
begin
  Result := FScrollInfo.nPage
end;

function TdxNavBarScrollBar.GetPosition: Integer;
begin
  Result := FScrollInfo.nPos;
end;

function TdxNavBarScrollBar.GetWidth: Integer;
begin
  Result := GetSystemMetrics(SM_CXVSCROLL);
end;

procedure TdxNavBarScrollBar.SetMax(const Value: Integer);
begin
  SetScrollParams(Min, Value, Position, PageSize);
end;

procedure TdxNavBarScrollBar.SetMin(const Value: Integer);
begin
  SetScrollParams(Value, Max, Position, PageSize);
end;

procedure TdxNavBarScrollBar.SetPageSize(const Value: Integer);
begin
  SetScrollParams(Min, Max, Position, Value);
end;

procedure TdxNavBarScrollBar.SetPosition(const Value: Integer);
begin
  SetScrollParams(Min, Max, Value, PageSize);
end;

procedure TdxNavBarScrollBar.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    FScrollBar.Visible := Value;
  end;
end;

{ TdxNavBarHintWindow }

procedure TdxNavBarHintWindow.ActivateHint(Rect: TRect; const AHint: string);
begin
  Caption := AHint;
  UpdateBoundsRect(Rect);
  if Rect.Top + Height > Screen.DesktopHeight then
    Rect.Top := Screen.DesktopHeight - Height;
  if Rect.Left + Width > Screen.DesktopWidth then
    Rect.Left := Screen.DesktopWidth - Width;
  if Rect.Left < Screen.DesktopLeft then Rect.Left := Screen.DesktopLeft;
  if Rect.Bottom < Screen.DesktopTop then Rect.Bottom := Screen.DesktopTop;
  SetWindowPos(Handle, HWND_TOPMOST, Rect.Left, Rect.Top, Width, Height,
    SWP_NOACTIVATE);
  ShowWindow(Handle, SW_SHOWNOACTIVATE);
  Invalidate;
end;

function TdxNavBarHintWindow.NavBar: TdxCustomNavBar;
begin
  if Owner is TdxCustomNavBar then
    Result := Owner as TdxCustomNavBar
  else Result := nil;
end;

procedure TdxNavBarHintWindow.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TdxNavBarHintWindow.WMNCHitTest(var Message: TWMNCHitTest);
begin
  Message.Result := HTTRANSPARENT;
end;

procedure TdxNavBarHintWindow.CreateParams(var Params: TCreateParams);
{$IFNDEF DELPHI7}
const
  CS_DROPSHADOW = $20000;
{$ENDIF}
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    if NewStyleControls then ExStyle := WS_EX_TOOLWINDOW;
    if IsWinXPOrLater then
      WindowClass.Style := WindowClass.style or CS_DROPSHADOW;
    AddBiDiModeExStyle(ExStyle);
  end;
end;

procedure TdxNavBarHintWindow.Paint;
begin
  if NavBar <> nil then
    NavBar.Painter.DrawHintWindow
  else inherited Paint;
end;

{ TAbstractcxNavBarDesigner }

constructor TAbstractcxNavBarDesigner.Create(ANavBar: TdxCustomNavBar);
begin
  inherited Create;
  FNavBar := ANavBar;
  if FNavBar <> nil then
    FNavBar.FDesigner := Self;
end;

destructor TAbstractcxNavBarDesigner.Destroy;
begin
  if NavBar <> nil then
    NavBar.FDesigner := nil;
  inherited Destroy;
end;

initialization
  RegisterClasses([TdxNavBar]);
  dxNavBarDragObject := nil;
  Screen.Cursors[dxNavBarDragCursor] := LoadCursor(HInstance, 'dxNavBarDragCursor');
  Screen.Cursors[dxNavBarDragCopyCursor] := LoadCursor(HInstance, 'dxNavBarDragCopyCursor');
  Screen.Cursors[dxNavBarLinksCursor] := LoadCursor(HInstance, 'dxNavBarLinksCursor');

finalization
  DestroyCursor(Screen.Cursors[dxNavBarLinksCursor]);
  DestroyCursor(Screen.Cursors[dxNavBarDragCopyCursor]);
  DestroyCursor(Screen.Cursors[dxNavBarDragCursor]);

end.
