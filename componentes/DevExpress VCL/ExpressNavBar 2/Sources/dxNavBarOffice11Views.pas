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

unit dxNavBarOffice11Views;

{$I cxVer.inc}

interface

uses
  Windows, Classes, Graphics, Menus, ImgList, Contnrs, Forms, Controls,
  dxCore,
  dxNavBar, dxNavBarBase, dxNavBarStyles, dxNavBarCustomPainters, dxNavBarBaseViews,
  dxNavBarOfficeViews, dxNavBarExplorerViews, dxNavBarCollns, cxAccessibility,
  cxContainer, cxControls, cxGraphics;

const
  nbOverflowPanelSign = 0;
  nbOverflowPanelItem = 1;
  nbHeaderSign = 2;
  nbSplitter = 3;
  nbItemPanelCollapseItem = 4;
  nbItemPanelCollapseBar = 5;

type
  TdxNavBarNavigationPaneViewInfo = class;
  TdxNavBarNavigationPanePainter = class;

  { TdxNavBarOffice11ExplorerBar }

  TdxNavBarOffice11LinkViewInfo = class(TdxNavBarExplorerBarLinkViewInfo)
  public
    function FontColor: TColor; override;
  end;

  TdxNavBarOffice11GroupViewInfo = class(TdxNavBarExplorerBarGroupViewInfo)
  private
    function IsDefaultBgColor: Boolean;
    function IsDefaultCaptionColor: Boolean;
  public
    function BorderColor: TColor; override;
    function BgBackColor: TColor; override;
    function BgBackColor2: TColor; override;
    function BgAlphaBlend: Byte; override;
    function BgAlphaBlend2: Byte; override;
    function BgGradientMode: TdxBarStyleGradientMode; override;
    function CaptionBackColor: TColor; override;
    function CaptionBackColor2: TColor; override;
    function CaptionAlphaBlend: Byte; override;
    function CaptionAlphaBlend2: Byte; override;
    function CaptionGradientMode: TdxBarStyleGradientMode; override;
    function CaptionFontColor: TColor; override;
  end;

  TdxNavBarOffice11ViewInfo = class(TdxNavBarExplorerBarViewInfo)
  private
    function IsDefaultBgColor: Boolean;
  protected
    procedure CreateColors; override;
    procedure RefreshColors; override;
    procedure ReleaseColors; override;

    function GetGroupEdges: TPoint; override;
    function GetGroupSeparatorWidth: Integer; override;
    function GetLinksImageEdges: TRect; override;
  public
    function BgBackColor: TColor; override;
    function BgBackColor2: TColor; override;
    function BgAlphaBlend: Byte; override;
    function BgAlphaBlend2: Byte; override;
    function BgGradientMode: TdxBarStyleGradientMode; override;

    procedure AssignDefaultBackgroundStyle; override;
    procedure AssignDefaultGroupBackgroundStyle; override;
    procedure AssignDefaultGroupHeaderStyle; override;
    procedure AssignDefaultGroupHeaderActiveStyle; override;
    procedure AssignDefaultItemStyle; override;
  end;

  TdxNavBarOffice11Painter = class(TdxNavBarExplorerBarPainter)
  protected
    class function GetViewInfoClass: TdxNavBarViewInfoClass; override;
    class function GetGroupViewInfoClass: TdxNavBarGroupViewInfoClass; override;
    class function GetLinkViewInfoClass: TdxNavBarLinkViewInfoClass; override;

    class function ButtonPainterClass: TdxNavBarCustomButtonPainterClass; override;
    class function SignPainterClass: TdxNavBarCustomSignPainterClass; override;
  end;

  TdxNavBarOffice11SignPainter = class(TdxNavBarExplorerBarSignPainter)
  protected
    class procedure PrepareBitmap(ACanvas: TCanvas; ABitmap: TBitmap;
      ABackColor1, ABackColor2: TColor; AState: TdxNavBarObjectStates);
    class procedure InternalDrawSign(ACanvas: TCanvas; ARect: TRect;
      AForeColor, ABackColor1, ABackColor2: TColor; AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarOffice11ExplorerBarGroupViewInfo = class(TdxNavBarExplorerBarGroupViewInfo)
  private
    function IsDefaultCaptionColor: Boolean;
  public
    function CaptionBorderColor: TColor; override;
    function CaptionBackColor: TColor; override;
    function CaptionBackColor2: TColor; override;
    function CaptionAlphaBlend: Byte; override;
    function CaptionAlphaBlend2: Byte; override;
    function CaptionGradientMode: TdxBarStyleGradientMode; override;
  end;

  TdxNavBarOffice11ExplorerBarViewInfo = class(TdxNavBarExplorerBarViewInfo)
  protected
    procedure CreateColors; override;
    procedure RefreshColors; override;
    procedure ReleaseColors; override;

    function CanSelectLinkByRect: Boolean; override;
    function GetGroupBorderOffsets: TRect; override;
    function GetGroupCaptionHeightAddon: Integer; override;
    class function GetGroupCaptionImageIndent: Integer; override;
    function GetGroupEdges: TPoint; override;
    function GetGroupSeparatorWidth: Integer; override;
  public
    procedure AssignDefaultBackgroundStyle; override;
    procedure AssignDefaultButtonStyle; override;
    procedure AssignDefaultGroupBackgroundStyle; override;
    procedure AssignDefaultGroupHeaderStyle; override;
    procedure AssignDefaultItemStyle; override;
    procedure AssignDefaultItemDisabledStyle; override;
    procedure AssignDefaultNavigationPaneHeaderStyle; override;
  end;

  TdxNavBarOffice11ExplorerBarControllerState = (ecsOverSizeGrip);
  TdxNavBarOffice11ExplorerBarControllerStates = set of TdxNavBarOffice11ExplorerBarControllerState;

  TdxNavBarOffice11ExplorerBarController = class(TdxNavBarExplorerBarController)
  private
    FInternalState: TdxNavBarOffice11ExplorerBarControllerStates;
    function GetMouseOverSizeGrip: Boolean;
    procedure SetMouseOverSizeGrip(AValue: Boolean);
    property MouseOverSizeGrip: Boolean read GetMouseOverSizeGrip write SetMouseOverSizeGrip;
  protected
    procedure DoMouseDown(AButton: TMouseButton; AShift: TShiftState; const APoint: TPoint); override;
    procedure DoMouseMove(AShift: TShiftState; const APoint: TPoint); override;
    function GetCursor: HIcon; override;
  end;

  TdxNavBarOffice11ExplorerBarPainter = class(TdxNavBarExplorerBarPainter)
  protected
    class function GetViewInfoClass: TdxNavBarViewInfoClass; override;
    class function GetGroupViewInfoClass: TdxNavBarGroupViewInfoClass; override;
    function GetControllerClass: TdxNavBarControllerClass; override;

    class function SignPainterClass: TdxNavBarCustomSignPainterClass; override;
  public
    procedure DrawNavBarControl; override;
    procedure DrawGroupControlSplitter(AGroupViewInfo: TdxNavBarExplorerBarGroupViewInfo); override;
  end;

  TdxNavBarOffice11ExplorerBarSignPainter = class(TdxNavBarExplorerBarSignPainter)
  protected
    class procedure DrawSignSelection(ACanvas: TCanvas; ARect: TRect; AForeColor,
      ABackColor1, ABackColor2: TColor; AState: TdxNavBarObjectStates); override;
  end;

  { TdxNavBarNavigationPane }

  TdxNavBarNavigationPaneGroupViewInfo = class(TdxNavBarGroupViewInfo)
  private
    function IsDefaultCaptionColor: Boolean;
  public
    function CaptionBorderColor: TColor; override;
    function CaptionBackColor: TColor; override;
    function CaptionBackColor2: TColor; override;
    function CaptionAlphaBlend: Byte; override;
    function CaptionAlphaBlend2: Byte; override;
    function CaptionGradientMode: TdxBarStyleGradientMode; override;
  end;

  TdxNavBarOffice11NavPaneGroupViewInfo = class(TdxNavBarNavigationPaneGroupViewInfo);

  TdxNavBarOffice11NavPaneLinkViewInfo = class(TdxNavBarOffice3LinkViewInfo)
  public
    function SeparatorColor: TColor; override;
  end;

  TdxNavBarNavigationPaneCustomViewInfo = class(TdxNavBarCustomViewInfo)
  private
    FViewInfo: TdxNavBarViewInfo;
    function GetViewInfo: TdxNavBarNavigationPaneViewInfo;
    function GetPainter: TdxNavBarNavigationPanePainter;
  protected
    property ViewInfo: TdxNavBarNavigationPaneViewInfo read GetViewInfo;
    property Painter: TdxNavBarNavigationPanePainter read GetPainter;
  public
    constructor Create(AViewInfo: TdxNavBarViewInfo); virtual;
  end;

  TdxNavBarOverflowPanelViewInfoItem = class
  public
    Group: TdxNavBarGroup;
    Rect: TRect;
    SelectionRect: TRect;
  end;

  TdxNavBarOverflowPanelViewInfo = class(TdxNavBarNavigationPaneCustomViewInfo)
  private
    FIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    FItems: TList;
    FRect: TRect;
    FSignRect: TRect;
    FVisibleItemCount: Integer;

    procedure ClearRects;
    procedure ClearItems;
    procedure OffsetElements(AHeightDifference: Integer);

    function GetIAccessibilityHelper: IdxNavBarAccessibilityHelper;

    function AddItem: TdxNavBarOverflowPanelViewInfoItem;
    function GetItemCount: Integer;
    function GetItems(AIndex: Integer): TdxNavBarOverflowPanelViewInfoItem;
  protected
    function GetAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass; virtual;

    function GetHeight: Integer; virtual;
    function GetImageHeight: Integer;
    function GetImageWidth: Integer;
    function GetImageList: TCustomImageList;
    function GetImageIndex(AGroup: TdxNavBarGroup): Integer;
    function GetItemIndexAtPos(const pt: TPoint): Integer;
    function GetItemSelectionWidth: Integer;
    function GetGroupAtPos(const pt: TPoint): TdxNavBarGroup;

    // Calculation
    procedure CalculateBounds(X, Y: Integer);

    // Conditions
    function IsVisible: Boolean;

    // Indents
    function GetImageWidthAddon: Integer; virtual;
    function GetSignWidth: Integer; virtual;
    function GetHeightAddon: Integer; virtual;
    function GetPopupMenuImageIndent: Integer; virtual;
    function GetPopupMenuTextIndent: Integer; virtual;
    function GetSeparator: Integer; virtual;

    function GetClientOffset: TRect; virtual;

    property ItemCount: Integer read GetItemCount;
    property Items[AIndex: Integer]: TdxNavBarOverflowPanelViewInfoItem read GetItems;
  public
    constructor Create(AViewInfo: TdxNavBarViewInfo); override;
    destructor Destroy; override;

    property Rect: TRect read FRect; 
  end;
  TdxNavBarOverflowPanelViewInfoClass = class of TdxNavBarOverflowPanelViewInfo;

  TdxNavBarItemPanelViewInfoItem = class
  private
    function GetCaption: string;
  protected
    procedure OffsetRects(dX, dY: Integer);
  public
    Index: Integer;
    ItemLink: TdxNavBarItemLink;
    Font: TFont;
    Rect: TRect;
    TextRect: TRect;
    ImageRect: TRect;
    ImageList: TCustomImageList;
    ImageIndex: Integer;

    property Caption: string read GetCaption;
  end;

  TdxNavBarItemPanelViewInfo = class(TdxNavBarNavigationPaneCustomViewInfo)
  private
    FIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    FCollapseBarGroup: TdxNavBarGroup;
    FCollapseBarRect: TRect;
    FRect: TRect;
    FActiveGroupViewInfo: TdxNavBarGroupViewInfo;
    FItems: TObjectList;

    FIsCollapseMode: Boolean; //#DG TODO:

    function GetCollapseBarIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    function GetIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    function GetItemCount: Integer;
    function GetItemIAccessibilityHelper(AIndex: Integer): IdxNavBarAccessibilityHelper;
    function GetItems(AIndex: Integer): TdxNavBarItemPanelViewInfoItem;
    procedure SetActiveGroupViewInfo(AValue: TdxNavBarGroupViewInfo);

    function AddItem: TdxNavBarItemPanelViewInfoItem;
    procedure ClearItems;
    procedure CreateItems;
  protected
    function GetMinHeight: Integer;

    procedure CalculateBounds(var X, Y: Integer);
    procedure CorrectBounds(AHeightDifference: Integer);
    function GetCollapseBarFont: TFont;
    function GetCollapseBarText: string;
    function GetItemFont(AIndex: Integer): TFont;
    function GetItemIndexAtPos(const pt: TPoint): Integer;

    function GetCollapseBarCaptionIndent: Integer;

    function GetAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass; virtual;

    property IAccessibilityHelper: IdxNavBarAccessibilityHelper
      read GetIAccessibilityHelper;
    property ActiveGroupViewInfo: TdxNavBarGroupViewInfo read FActiveGroupViewInfo write SetActiveGroupViewInfo;
    property CollapseBarFont: TFont read GetCollapseBarFont;
    property CollapseBarText: string read GetCollapseBarText;
    property CollapseBarRect: TRect read FCollapseBarRect;
    property ItemCount: Integer read GetItemCount;
    property Items[AIndex: Integer]: TdxNavBarItemPanelViewInfoItem read GetItems;
    property Rect: TRect read FRect;
  public
    constructor Create(AViewInfo: TdxNavBarViewInfo); override;
    destructor Destroy; override;

    property CollapseBarIAccessibilityHelper: IdxNavBarAccessibilityHelper
      read GetCollapseBarIAccessibilityHelper;
    property ItemIAccessibilityHelpers[AIndex: Integer]: IdxNavBarAccessibilityHelper
      read GetItemIAccessibilityHelper;
  end;

  TdxNavBarNavigationPaneViewInfo = class(TdxNavBarOffice3ViewInfo)
  private
    FActiveGroupCaptionPanelIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    FSizeGripRect: TRect;
    FHeaderRect: TRect;
    FHeaderSignIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    FHeaderSignRect: TRect;
    FHeaderTextRect: TRect;

    FOverflowPanelViewInfo: TdxNavBarOverflowPanelViewInfo;
    FItemPanelViewInfo: TdxNavBarItemPanelViewInfo;

    FSplitterRect: TRect;
    FPopupMenu: TPopupMenu;
    FImageList: TImageList;

    FMaxImageSize: TSize;
    FMaxImageSizeCalculated: Boolean;
    FImageHeightPeer: Boolean;

    function GetPainter: TdxNavBarNavigationPanePainter;

    function GetActiveGroupCaptionPanelIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    function GetHeaderSignIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    function GetOverflowPanelIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    function GetOverflowPanelSignIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    function GetOverflowPanelItemIAccessibilityHelper(AIndex: Integer): IdxNavBarAccessibilityHelper;
    function GetNavPanePartIAccessibilityHelper(const APart: TdxNavBarPart): IdxNavBarAccessibilityHelper;

    function GetSmallImagesCount: Integer;

    // OverflowPanel
    function GetOverflowPanelItemCount: Integer;
    function GetOverflowPanelItems(AIndex: Integer): TdxNavBarOverflowPanelViewInfoItem;
    function GetOverflowPanelRect: TRect;
    function GetOverflowPanelSignRect: TRect;
    function GetOverflowPanelVisibleItemCount: Integer;

    function IsActiveGroupVisible: Boolean;
    function IsGroupReflectionNeeded: Boolean;
    function GetRealGroupStartIndex: Integer;
    function GetRealGroupCount: Integer;

    function IsDefaultHeaderColor: Boolean;
    function IsDefaultOverflowPanelColor: Boolean;
    function IsDefaultBottomScrollButtonColor: Boolean;
    function IsDefaultTopScrollButtonColor: Boolean;
    procedure RecreateImageList;
    // Menu items
    procedure DoMoreButtonsClick(Sender: TObject);
    procedure DoFewerButtonsClick(Sender: TObject);
    procedure DoAddRemoveButtonsClick(Sender: TObject);
    procedure DoHiddenGroupClick(Sender: TObject);
    procedure DoMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
    procedure DoDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      Selected: Boolean);
  protected
    procedure CreateColors; override;
    procedure RefreshColors; override;
    procedure ReleaseColors; override;

    // Sizes
    function GetGroupEdges: TPoint; override;
    function GetGroupSeparatorWidth: Integer; override;
    function GetGroupBorderOffsets: TRect; override;
    class function GetGroupCaptionImageIndent: Integer; override;
    function GetGroupCaptionHeightAddon: Integer; override;
    function GetGroupHeaderTextIndent: Integer; virtual;
    function GetHeaderClientOffset: TRect; virtual;
    function GetHeaderSignIndents: TRect; virtual;
    function GetNavBarCollapsedWidth: Integer; override;
    function GetNavBarMinExpandedWidth: Integer; override;

    // Conditions
    function CanCollapse: Boolean; override;
    function CanHasGroupViewAsIconView: Boolean; override;
    function CanHasImageInGroupCaption: Boolean; override;
    function CanGroupCaptionBoundsByImage: Boolean; override;
    function IsBottomBorderNeeded: Boolean;
    function IsHeaderVisible: Boolean;
    function IsSplitterVisible: Boolean;
    function IsTopBorderNeeded: Boolean;

    // Correction
    procedure CorrectBounds; override;

    // Calculations
    procedure DoCreateGroupsInfo; override;
    procedure DoCalculateBounds(X, Y: Integer); override;

    function GetItemPanelRect: TRect;

    function GetBoundsUpdateType: TdxNavBarChangeType; override;

    function GetActiveGroupCaptionPanelAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass; virtual;
    function GetHeaderSignAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass; virtual;
    function GetOverflowPanelViewInfoClass: TdxNavBarOverflowPanelViewInfoClass; virtual;
  public
    constructor Create(APainter: TdxNavBarPainter); override;
    destructor Destroy; override;

    procedure CreateInfo; override;
    procedure CreateItemPanelViewInfo;
    procedure CreateOverflowPanelInfo(AItemCount: Integer; AClearOld: Boolean); virtual;
    procedure CalculateSizeGripBounds; virtual;
    procedure CalculateHeaderBounds(var X, Y: Integer); virtual;
    procedure CalculateMaxImageSize; virtual;
    procedure CalculateSplitterBounds(var X, Y: Integer); virtual;
    procedure ClearRects; override;

    function GetHeaderHeight: Integer; virtual;
    function GetGripSize: Integer; virtual;
    function GetSplitterHeight: Integer; virtual;

    function GetGroupViewInfoAtItemsPos(const pt: TPoint): TdxNavBarGroupViewInfo; override;
    function GetViewInfoAtDragPosition(const pt: TPoint; var ItemGroup: TdxNavBarGroupViewInfo;
        var Item1, Item2: TdxNavBarLinkViewInfo): Integer; override;

    function IsPtIncNavigationPaneOverflowPanelItemCount(const pt: TPoint): Boolean;
    function IsPtDecNavigationPaneOverflowPanelItemCount(const pt: TPoint): Boolean;
    function IsPtNavigationPaneHeader(const pt: TPoint): Boolean;
    function IsPtNavigationPaneHeaderSign(const pt: TPoint): Boolean;
    function IsPtNavigationPaneOverflowPanel(const pt: TPoint): Boolean;
    function IsPtNavigationPaneOverflowPanelSign(const pt: TPoint): Boolean;
    function IsPtNavigationPaneSplitter(const pt: TPoint): Boolean;
    function IsPtNavigationPaneItemPanel(const pt: TPoint): Boolean;

    procedure DoShowPopupMenu(const APoint: TPoint);
    procedure DoUpdatePopupMenu; virtual;

    function FindGroupWithAccel(AKey: Word): TdxNavBarGroup; override;
    function FindLinkWithAccel(AKey: Word): TdxNavBarItemLink; override;
    function GetLinkAtPos(const pt: TPoint): TdxNavBarItemLink; override;

    function BorderWidth: Integer; virtual;
    function BorderColor: TColor; override;
    function CollapseBarFontColor: TColor; virtual;

    function BottomScrollButtonBackColor: TColor; override;
    function BottomScrollButtonBackColor2: TColor; override;
    function BottomScrollButtonAlphaBlend: Byte; override;
    function BottomScrollButtonAlphaBlend2: Byte; override;
    function BottomScrollButtonGradientMode: TdxBarStyleGradientMode; override;
    function TopScrollButtonBackColor: TColor; override;
    function TopScrollButtonBackColor2: TColor; override;
    function TopScrollButtonAlphaBlend: Byte; override;
    function TopScrollButtonAlphaBlend2: Byte; override;
    function TopScrollButtonGradientMode: TdxBarStyleGradientMode; override;
    function HeaderBackColor: TColor; override;
    function HeaderBackColor2: TColor; override;
    function HeaderAlphaBlend: Byte; override;
    function HeaderAlphaBlend2: Byte; override;
    function HeaderGradientMode: TdxBarStyleGradientMode; override;
    function HeaderFontColor: TColor; override;
    function OverflowPanelBackColor: TColor; override;
    function OverflowPanelBackColor2: TColor; override;
    function OverflowPanelAlphaBlend: Byte; override;
    function OverflowPanelAlphaBlend2: Byte; override;
    function OverflowPanelGradientMode: TdxBarStyleGradientMode; override;
    function SplitterBackColor: TColor; override;
    function SplitterBackColor2: TColor; override;
    function SplitterGradientMode: TdxBarStyleGradientMode; override;

    procedure AssignDefaultBackgroundStyle; override;
    procedure AssignDefaultButtonStyle; override;
    procedure AssignDefaultGroupBackgroundStyle; override;
    procedure AssignDefaultGroupHeaderStyle; override;
    procedure AssignDefaultGroupHeaderActiveStyle; override;
    procedure AssignDefaultGroupHeaderHotTrackedStyle; override;
    procedure AssignDefaultGroupHeaderPressedStyle; override;
    procedure AssignDefaultItemStyle; override;
    procedure AssignDefaultItemDisabledStyle; override;
    procedure AssignDefaultNavigationPaneHeaderStyle; override;

    property HeaderRect: TRect read FHeaderRect;
    property HeaderSignRect: TRect read FHeaderSignRect;
    property ItemPanelRect: TRect read GetItemPanelRect;

    property OverflowPanelItemCount: Integer read GetOverflowPanelItemCount;
    property OverflowPanelItems[Index: Integer]: TdxNavBarOverflowPanelViewInfoItem read GetOverflowPanelItems;
    property OverflowPanelRect: TRect read GetOverflowPanelRect;
    property OverflowPanelSignRect: TRect read GetOverflowPanelSignRect;
    property OverflowPanelVisibleItemCount: Integer read GetOverflowPanelVisibleItemCount;

    property SizeGripRect: TRect read FSizeGripRect;
    property SplitterRect: TRect read FSplitterRect;

    property ActiveGroupCaptionPanelIAccessibilityHelper: IdxNavBarAccessibilityHelper
      read GetActiveGroupCaptionPanelIAccessibilityHelper;
    property ImageList: TImageList read FImageList;
    property ItemPanelViewInfo: TdxNavBarItemPanelViewInfo read FItemPanelViewInfo;
    property PopupMenu: TPopupMenu read FPopupMenu;
    property Painter: TdxNavBarNavigationPanePainter read GetPainter;

    property NavPanePartIAccessibilityHelpers[const APart: TdxNavBarPart]: IdxNavBarAccessibilityHelper
      read GetNavPanePartIAccessibilityHelper;
    property OverflowPanelSignIAccessibilityHelper: IdxNavBarAccessibilityHelper
      read GetOverflowPanelSignIAccessibilityHelper;
    property OverflowPanelIAccessibilityHelper: IdxNavBarAccessibilityHelper
      read GetOverflowPanelIAccessibilityHelper;
    property HeaderSignIAccessibilityHelper: IdxNavBarAccessibilityHelper
      read GetHeaderSignIAccessibilityHelper;
  end;

  TdxNavBarOffice11NavPaneViewInfo = class(TdxNavBarNavigationPaneViewInfo);

  TdxNavBarPopupControlViewInfo = class(TdxNavBarNavigationPaneCustomViewInfo)
  private
    FRect: TRect;

    function GetClientRect: TRect;
  protected
    procedure CalculateBounds(AClientWidth: Integer); virtual;
    function CalculatePosition: TPoint; virtual;
    function GetBorderOffsets: TRect; virtual;
    function GetMaxHeight: Integer; virtual;
    function GetMinWidth: Integer; virtual;
    function IsPtSizeGrip(const pt: TPoint): Boolean; virtual;
  public
    property ClientRect: TRect read GetClientRect;
    property Rect: TRect read FRect;
  end;
  TdxNavBarPopupControlViewInfoClass = class of TdxNavBarPopupControlViewInfo;

  TdxNavBarPopupControlState = (pcsSizing, pcsOverSizeGrip);
  TdxNavBarPopupControlStates = set of TdxNavBarPopupControlState;

  TdxNavBarPopupControl = class(TcxCustomPopupWindow)
  private
    FCapturePointOffset: Integer;
    FNavBar: TdxCustomNavBar;
    FOriginalWidth: Integer;
    FInnerControl: TdxCustomNavBar; // TdxNavBarPopupInnerControl
    FInternalState: TdxNavBarPopupControlStates;
    FSizeFrame: TcxSizeFrame;
    FViewInfo: TdxNavBarPopupControlViewInfo;

    procedure CreateViewInfo;
    function GetPainter: TdxNavBarNavigationPanePainter;
    procedure SetNewWidth(AWidth: Integer);

    function GetMouseOverSizeGrip: Boolean;
    procedure SetMouseOverSizeGrip(AValue: Boolean);

    property MouseOverSizeGrip: Boolean read GetMouseOverSizeGrip write SetMouseOverSizeGrip;
  protected
    function NeedAdjustWidth: Boolean;
    function CalculatePosition: TPoint; override;
    procedure CalculateSize; override;
    procedure BeginResize(AControl: TControl; AButton: TMouseButton; AShift: TShiftState; const APoint: TPoint);
    procedure EndResize(ACancel: Boolean = False);
    procedure DoShowed; override;
    procedure DrawSizeFrame(const R: TRect);
    procedure InitPopup; override;
    procedure Paint; override;
    procedure RefreshPopupWindow;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    function NeedIgnoreMouseMessageAfterCloseUp(AWnd: THandle; AMsg: Cardinal;
      AShift: TShiftState; const APos: TPoint): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(ANavBar: TdxCustomNavBar); reintroduce; virtual;
    destructor Destroy; override;
    procedure CloseUp; override;
    procedure Popup(AFocusedControl: TWinControl); override;

    property Painter: TdxNavBarNavigationPanePainter read GetPainter;
    property ViewInfo: TdxNavBarPopupControlViewInfo read FViewInfo;
  end;

  { TdxNavBarNavigationPaneController }

  TdxNavBarNavPanePartState = (oisNormal, oisHot, oisPressed, oisChecked, oisHotCheck, oisDroppedDown);

  TdxNavBarNavigationPaneController = class(TdxNavBarNavigationBarController)
  private
    FPopupControl: TdxNavBarPopupControl;

    FDroppedDownPart: TdxNavBarPart;

    procedure CalcOverflowPanelHintRect(AItem: TObject; var ARect: TRect);
    procedure ChangeNavBarCollapseState;

    function IsAnyItemHotTracked: Boolean;
    function IsPopupControlExists: Boolean;
    function IsPopupControlVisible: Boolean;
    function IsPopupJustClosed: Boolean;
    function IsOverflowPanelGroupHotTracked: Boolean;
    function GetNavPanePartState(const APart: TdxNavBarPart): TdxNavBarNavPanePartState;
    function GetOriginalWidth: Integer;
    function GetViewInfo: TdxNavBarNavigationPaneViewInfo;

    function GetOverflowPanelGroup(AIndex: Integer): TdxNavBarGroup;

    procedure SetDroppedDownPart(APart: TdxNavBarPart);
    procedure SetOriginalWidth(AValue: Integer);

    property OverflowPanelGroup[AIndex: Integer]: TdxNavBarGroup read GetOverflowPanelGroup;
  protected
    function CanFocusOnClick(const APoint: TPoint): Boolean; override;
    function GetCursor: HIcon; override;
    function GetPartAtPos(const APoint: TPoint): TdxNavBarPart; override;

    procedure DoClick(const APart: TdxNavBarPart); override;
    procedure DoCheckBounds(var ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure DoMouseDown(AButton: TMouseButton; AShift: TShiftState; const APoint: TPoint); override;
    procedure DoMouseMove(AShift: TShiftState; const APoint: TPoint); override;
    procedure DoMouseLeave; override;
    procedure DoSetHotPart(const APart: TdxNavBarPart); override;
    procedure DoSetPressedPart(const APart: TdxNavBarPart); override;

    procedure DoShowHint(var AHintInfo: THintInfo); override;
    procedure DoShowOverflowPanelHint(var AHintInfo: THintInfo); virtual;
    function GetNavPaneItemHintRect(const ACursorPos: TPoint): TRect; virtual;
    function GetNavPaneItemHintText: string; virtual;
    function GetNavPaneItemHintCursorRect: TRect; virtual;

    procedure DoOverflowPanelItemClick;
    procedure DoOverflowPanelSignClick;
    procedure DoHeaderSignClick;
    procedure DoCollapseBarClick;
    procedure DoCollapseItemClick;
    procedure DoSplitterDrag(const APoint: TPoint);

    function Collapsible: Boolean;
    function Collapsed: Boolean;
    procedure CollapseStateChaged(Sender: TObject);

    property OriginalWidth: Integer read GetOriginalWidth write SetOriginalWidth;
    property PopupControl: TdxNavBarPopupControl read FPopupControl;
  public
    constructor Create(ANavBar: TdxCustomNavBar); override;
    destructor Destroy; override;

    procedure ClosePopupControl;
    procedure ShowPopupControl;

    property DroppedDownPart: TdxNavBarPart read FDroppedDownPart write SetDroppedDownPart;
    property ViewInfo: TdxNavBarNavigationPaneViewInfo read GetViewInfo;
  end;

  TdxNavBarNavigationPanePainter = class(TdxNavBarOffice3Painter)
  private
    function GetController: TdxNavBarNavigationPaneController;
    function GetOverflowPanelViewInfo: TdxNavBarOverflowPanelViewInfo;
    function GetViewInfo: TdxNavBarNavigationPaneViewInfo;

    procedure DrawItemPanelPartFocusRect(const APartRect: TRect);
    procedure DrawVertivalText(AFont: TFont; const AText: string; const ARect: TRect; AState: TdxNavBarNavPanePartState);
    procedure DrawOverflowPanelItemBackground(ACanvas: TCanvas; AState: TdxNavBarNavPanePartState; const ARect: TRect); overload;
    procedure DrawOverflowPanelItemBackground(ACanvas: TCanvas; const APart: TdxNavBarPart; const ARect: TRect); overload;
  protected
    function CreatePopupControlViewInfo: TdxNavBarPopupControlViewInfo;
    class function ButtonPainterClass: TdxNavBarCustomButtonPainterClass; override;
    class function GetViewInfoClass: TdxNavBarViewInfoClass; override;
    class function GetGroupViewInfoClass: TdxNavBarGroupViewInfoClass; override;
    function GetControllerClass: TdxNavBarControllerClass; override;
    class function GetPopupControlViewInfoClass: TdxNavBarPopupControlViewInfoClass; virtual;

    function GetNavPanePartState(const APart: TdxNavBarPart): TdxNavBarNavPanePartState;

    procedure DoDrawHeader; virtual;
    procedure DoDrawOverflowPanel; virtual;
    procedure DoDrawSplitter; virtual;
  public
    procedure DrawNavBarControl; override;
    procedure DrawGroupCaption(AGroupViewInfo: TdxNavBarGroupViewInfo); override;
    procedure DrawSizeGrip(ACanvas: TCanvas; const ARect: TRect); virtual;
    procedure DrawHintWindow(AHintWindow: TdxNavBarHintWindow); override;
    procedure DrawItemPanel; virtual;
    procedure DrawItemsRect(AGroupViewInfo: TdxNavBarGroupViewInfo); override;
    procedure DrawGroupCaptionButton(AGroupViewInfo: TdxNavBarGroupViewInfo); override;
    procedure DrawCollapseBar(AItemPanelViewInfo: TdxNavBarItemPanelViewInfo); virtual;
    procedure DrawCollapseElementBackground(const ARect: TRect; AState: TdxNavBarNavPanePartState); virtual;
    procedure DrawCollapseItem(AItemViewInfo: TdxNavBarItemPanelViewInfoItem; AState: TdxNavBarNavPanePartState); virtual;
    procedure DrawBorder; virtual;
    procedure DrawHeader; virtual;
    procedure DrawHeaderBackground; virtual;
    procedure DrawHeaderSign; virtual;
    procedure DrawHeaderText; virtual;
    procedure DrawOverflowPanel; virtual;
    procedure DrawOverflowPanelBackground; virtual;
    procedure DrawOverflowPanelSign; virtual;
    procedure DrawOverflowPanelItems; virtual;
    procedure DrawOverflowPanelHintWindow(ACanvas: TCanvas; const ARect: TRect); virtual;
    procedure DrawPopupControl(ACanvas: TcxCanvas; AViewInfo: TdxNavBarPopupControlViewInfo); virtual;
    procedure DrawSplitter; virtual;
    procedure DrawSplitterSign; virtual;
    procedure DrawPopupMenuItem(ACanvas: TCanvas; ARect: TRect; AImageList: TCustomImageList;
      AImageIndex: Integer; AText: string; State: TdxNavBarObjectStates); virtual;

    property Controller: TdxNavBarNavigationPaneController read GetController;
    property OverflowPanelViewInfo: TdxNavBarOverflowPanelViewInfo read GetOverflowPanelViewInfo;
    property ViewInfo: TdxNavBarNavigationPaneViewInfo read GetViewInfo;
  end;

  TdxNavBarNavigationPaneButtonPainter = class(TdxNavBarCustomButtonPainter)
  protected
    class procedure InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
      AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
      AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
      AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarOffice11NavPaneButtonPainter = class(TdxNavBarNavigationPaneButtonPainter);

  TdxNavBarOffice11NavPanePainter = class(TdxNavBarNavigationPanePainter)
  protected
    class function GetGroupViewInfoClass: TdxNavBarGroupViewInfoClass; override;
    class function GetLinkViewInfoClass: TdxNavBarLinkViewInfoClass; override;
    class function GetViewInfoClass: TdxNavBarViewInfoClass; override;
    class function ButtonPainterClass: TdxNavBarCustomButtonPainterClass; override;
  end;

  TdxNavBarOffice11NavPaneGroupButtonPainter = class(TdxNavBarCustomButtonPainter)
  protected
    class procedure InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
      AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
      AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
      AState: TdxNavBarObjectStates); override;
  end;

  { TdxNavBarItemCollectionItemAccessibilityHelper }

  TdxNavBarItemCollectionItemAccessibilityHelper = class(TdxNavBarCustomAccessibilityHelper)
  private
    FItemIndex: Integer;
  public
    property ItemIndex: Integer read FItemIndex write FItemIndex;
  end;

  TdxNavBarItemCollectionItemAccessibilityHelperClass = class of TdxNavBarItemCollectionItemAccessibilityHelper;

  { TdxNavBarItemCollectionAccessibilityHelper }

  TdxNavBarItemCollectionAccessibilityHelper = class(TdxNavBarCustomAccessibilityHelper)
  private
    FItemIAccessibilityHelpers: TInterfaceList;
    function GetItemIAccessibilityHelper(AIndex: Integer): IdxNavBarAccessibilityHelper;
    function GetItemIAccessibilityHelperCount: Integer;
    procedure SetItemIAccessibilityHelperCount(Value: Integer);
  protected
    function GetChild(AIndex: Integer): TcxAccessibilityHelper; override;
    function GetChildCount: Integer; override;

    function GetActualItemCount: Integer; virtual; abstract;
    function GetItemAccessibilityHelperClass: TdxNavBarItemCollectionItemAccessibilityHelperClass; virtual; abstract;
    function IsContainer: Boolean; override;
  public
    constructor Create(AOwnerObject: TObject;
      AOwnerObjectControl: TWinControl); override;
    destructor Destroy; override;

    procedure CheckItemIAccessibilityHelperCount;

    property ItemIAccessibilityHelperCount: Integer
      read GetItemIAccessibilityHelperCount;
    property ItemIAccessibilityHelpers[AIndex: Integer]: IdxNavBarAccessibilityHelper
      read GetItemIAccessibilityHelper;
  end;

  TdxNavBarNavigationPaneOverflowPanelAccessibilityHelper = class(TdxNavBarItemCollectionAccessibilityHelper)
  private
    FSignIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    function GetSignIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    function GetViewInfo: TdxNavBarOverflowPanelViewInfo;
  protected
    function GetChild(AIndex: Integer): TcxAccessibilityHelper; override;
    function GetChildCount: Integer; override;
    function GetParent: TcxAccessibilityHelper; override;
    function GetState(
      AChildID: TcxAccessibleSimpleChildElementID): Integer; override;

    function GetActualItemCount: Integer; override;
    function GetBounds: TRect; override;
    function GetItemAccessibilityHelperClass: TdxNavBarItemCollectionItemAccessibilityHelperClass; override;
    function GetSignAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass; virtual;

    property ViewInfo: TdxNavBarOverflowPanelViewInfo read GetViewInfo;
  public
    destructor Destroy; override;

    property SignIAccessibilityHelper: IdxNavBarAccessibilityHelper
      read GetSignIAccessibilityHelper;
  end;

  TdxNavBarNavigationPaneOverflowPanelItemAccessibilityHelper = class(TdxNavBarItemCollectionItemAccessibilityHelper)
  private
    function GetGroup: TdxNavBarGroup;
    function GetViewInfo: TdxNavBarNavigationPaneViewInfo;
  protected
    function GetParent: TcxAccessibilityHelper; override;
    function GetState(
      AChildID: TcxAccessibleSimpleChildElementID): Integer; override;

    procedure Click(AKey: Word); override;
    function GetBounds: TRect; override;
    function IsClickKey(AKey: Word): Boolean; override;
    function IsContainer: Boolean; override;

    property Group: TdxNavBarGroup read GetGroup;
    property ViewInfo: TdxNavBarNavigationPaneViewInfo read GetViewInfo;
  end;

  TdxNavBarNavigationPaneOverflowPanelSignAccessibilityHelper = class(TdxNavBarCustomAccessibilityHelper)
  private
    function GetViewInfo: TdxNavBarNavigationPaneViewInfo;
  protected
    function GetParent: TcxAccessibilityHelper; override;
    function GetState(
      AChildID: TcxAccessibleSimpleChildElementID): Integer; override;

    procedure Click(AKey: Word); override;
    function GetBounds: TRect; override;
    function IsClickKey(AKey: Word): Boolean; override;
    function IsContainer: Boolean; override;

    property ViewInfo: TdxNavBarNavigationPaneViewInfo read GetViewInfo;
  end;

  { TdxNavBarNavigationPaneActiveGroupCaptionPanelAccessibilityHelper }

  TdxNavBarNavigationPaneActiveGroupCaptionPanelAccessibilityHelper = class(TdxNavBarCustomAccessibilityHelper)
  private
    function GetGroupViewInfo: TdxNavBarGroupViewInfo;
    function GetNavBar: TdxCustomNavBar;
    function GetNavBarViewInfo: TdxNavBarNavigationPaneViewInfo;
  protected
    function GetParent: TcxAccessibilityHelper; override;
    function GetState(
      AChildID: TcxAccessibleSimpleChildElementID): Integer; override;

    function CanBeFocusedByDefault: Boolean; override;
    function GetAssociatedObject: TdxNavBarCustomAccessibilityHelper; override;
    function GetBounds: TRect; override;
    function IsContainer: Boolean; override;

    property NavBar: TdxCustomNavBar read GetNavBar;
    property NavBarViewInfo: TdxNavBarNavigationPaneViewInfo read GetNavBarViewInfo;
    property GroupViewInfo: TdxNavBarGroupViewInfo read GetGroupViewInfo;
  end;

  { TdxNavBarNavigationPaneHeaderSignAccessibilityHelper }

  TdxNavBarNavigationPaneHeaderSignAccessibilityHelper = class(TdxNavBarCustomAccessibilityHelper)
  private
    function GetViewInfo: TdxNavBarNavigationPaneViewInfo;
  protected
    function GetParent: TcxAccessibilityHelper; override;
    function GetState(
      AChildID: TcxAccessibleSimpleChildElementID): Integer; override;

    procedure Click(AKey: Word); override;
    function GetBounds: TRect; override;
    function IsClickKey(AKey: Word): Boolean; override;
    function IsContainer: Boolean; override;

    property ViewInfo: TdxNavBarNavigationPaneViewInfo read GetViewInfo;
  end;

  { TdxNavBarItemPanelAccessibilityHelper }

  TdxNavBarItemPanelAccessibilityHelper = class(TdxNavBarItemCollectionAccessibilityHelper)
  private
    FCollapseBarIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    function GetCollapseBarIAccessibilityHelper: IdxNavBarAccessibilityHelper;
    function GetViewInfo: TdxNavBarItemPanelViewInfo;
  protected
    function GetChild(AIndex: Integer): TcxAccessibilityHelper; override;
    function GetChildCount: Integer; override;
    function GetParent: TcxAccessibilityHelper; override;
    function GetState(
      AChildID: TcxAccessibleSimpleChildElementID): Integer; override;

    function GetActualItemCount: Integer; override;
    function GetBounds: TRect; override;
    function GetCollapseBarAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass; virtual;
    function GetItemAccessibilityHelperClass: TdxNavBarItemCollectionItemAccessibilityHelperClass; override;

    property ViewInfo: TdxNavBarItemPanelViewInfo read GetViewInfo;
  public
    destructor Destroy; override;

    property CollapseBarIAccessibilityHelper: IdxNavBarAccessibilityHelper
      read GetCollapseBarIAccessibilityHelper;
  end;

  { TdxNavBarItemPanelCollapseBarAccessibilityHelper }

  TdxNavBarItemPanelCollapseBarAccessibilityHelper = class(TdxNavBarCustomAccessibilityHelper)
  private
    function GetViewInfo: TdxNavBarItemPanelViewInfo;
  protected
    function GetParent: TcxAccessibilityHelper; override;
    function GetState(
      AChildID: TcxAccessibleSimpleChildElementID): Integer; override;

    function CanBeFocusedByDefault: Boolean; override;
    procedure Click(AKey: Word); override;
    function GetBounds: TRect; override;
    function IsClickKey(AKey: Word): Boolean; override;
    function IsContainer: Boolean; override;

    property ViewInfo: TdxNavBarItemPanelViewInfo read GetViewInfo;
  end;

  { TdxNavBarItemPanelItemAccessibilityHelper }

  TdxNavBarItemPanelItemAccessibilityHelper = class(TdxNavBarItemCollectionItemAccessibilityHelper)
  private
    function GetViewInfo: TdxNavBarItemPanelViewInfo;
  protected
    function GetParent: TcxAccessibilityHelper; override;
    function GetState(
      AChildID: TcxAccessibleSimpleChildElementID): Integer; override;

    function CanBeFocusedByDefault: Boolean; override;
    procedure Click(AKey: Word); override;
    function GetBounds: TRect; override;
    function IsClickKey(AKey: Word): Boolean; override;
    function IsContainer: Boolean; override;

    property ViewInfo: TdxNavBarItemPanelViewInfo read GetViewInfo;
  end;

implementation

uses
{$IFDEF DELPHI6}
   Types,
{$ENDIF}
  SysUtils, CommCtrl, Math,
  cxClasses, cxGeometry, cxLookAndFeels, dxOffice11,
  dxNavBarConsts, dxNavBarGraphics, dxNavBarViewsFact, dxThemeManager, dxUxTheme,
  dxNavBarAccessibility;

type
  TdxCustomNavBarAccess = class(TdxCustomNavBar);
  TdxNavBarControllerAccess = class(TdxNavBarController);
  TdxNavBarItemAccess = class(TdxNavBarItem);
  TdxNavBarPainterAccess = class(TdxNavBarPainter);

{ TdxNavBarOffice11LinkViewInfo }

function TdxNavBarOffice11LinkViewInfo.FontColor: TColor;
begin
  Result := Font.Color;
  if Result = clNone then
    Result := dxOffice11LinkFontColor;
end;

{ TdxNavBarOffice11GroupViewInfo }

function TdxNavBarOffice11GroupViewInfo.BorderColor: TColor;
begin
  if IsDefaultCaptionColor then
    Result := dxOffice11GroupBorderColor
  else
    Result := inherited BorderColor;
end;

function TdxNavBarOffice11GroupViewInfo.BgAlphaBlend: Byte;
begin
  if IsDefaultBgColor then
    Result := 255
  else
    Result := inherited BgAlphaBlend;
end;

function TdxNavBarOffice11GroupViewInfo.BgAlphaBlend2: Byte;
begin
  if IsDefaultBgColor then
    Result := 255
  else
    Result := inherited BgAlphaBlend2;
end;

function TdxNavBarOffice11GroupViewInfo.BgBackColor: TColor;
begin
  if IsDefaultBgColor then
    Result := dxOffice11GroupBackgroundColor1
  else
    Result := inherited BgBackColor;
end;

function TdxNavBarOffice11GroupViewInfo.BgBackColor2: TColor;
begin
  if IsDefaultBgColor then
    Result := dxOffice11GroupBackgroundColor2
  else
    Result := inherited BgBackColor2;
end;

function TdxNavBarOffice11GroupViewInfo.BgGradientMode: TdxBarStyleGradientMode;
begin
  if IsDefaultBgColor then
    Result := gmVertical
  else
    Result := inherited BgGradientMode;
end;

function TdxNavBarOffice11GroupViewInfo.CaptionAlphaBlend: Byte;
begin
  if IsDefaultCaptionColor then
    Result := 255
  else
    Result := inherited CaptionAlphaBlend;
end;

function TdxNavBarOffice11GroupViewInfo.CaptionAlphaBlend2: Byte;
begin
  if IsDefaultCaptionColor then
    Result := 255
  else
    Result := inherited CaptionAlphaBlend2;
end;

function TdxNavBarOffice11GroupViewInfo.CaptionBackColor: TColor;
begin
  if IsDefaultCaptionColor then
    Result := dxOffice11GroupCaptionColor1
  else
    Result := inherited CaptionBackColor;
end;

function TdxNavBarOffice11GroupViewInfo.CaptionBackColor2: TColor;
begin
  if IsDefaultCaptionColor then
    Result := dxOffice11GroupCaptionColor2
  else
    Result := inherited CaptionBackColor2;
end;

function TdxNavBarOffice11GroupViewInfo.CaptionGradientMode: TdxBarStyleGradientMode;
begin
  if IsDefaultCaptionColor then
    Result := gmHorizontal
  else
    Result := inherited CaptionGradientMode;
end;

function TdxNavBarOffice11GroupViewInfo.CaptionFontColor: TColor;
begin
  Result := inherited CaptionFontColor;
  if Result = clNone then
    Result := dxOffice11GroupFontColor;
end;

function TdxNavBarOffice11GroupViewInfo.IsDefaultBgColor: Boolean;
begin
  Result := (inherited BgBackColor = clNone) or (inherited BgBackColor2 = clNone);
end;

function TdxNavBarOffice11GroupViewInfo.IsDefaultCaptionColor: Boolean;
begin
  Result := (inherited CaptionBackColor = clNone) or (inherited CaptionBackColor2 = clNone);
end;

{ TdxNavBarOffice11ViewInfo }

function TdxNavBarOffice11ViewInfo.BgAlphaBlend: Byte;
begin
  if IsDefaultBgColor then
    Result := 255
  else Result := inherited BgAlphaBlend;
end;

function TdxNavBarOffice11ViewInfo.BgAlphaBlend2: Byte;
begin
  if IsDefaultBgColor then
    Result := 255
  else Result := inherited BgAlphaBlend2;
end;

function TdxNavBarOffice11ViewInfo.BgBackColor: TColor;
begin
  if IsDefaultBgColor then
    Result := dxOffice11BackgroundColor1
  else Result := inherited BgBackColor;
end;

function TdxNavBarOffice11ViewInfo.BgBackColor2: TColor;
begin
  if IsDefaultBgColor then
    Result := dxOffice11BackgroundColor2
  else Result := inherited BgBackColor2;
end;

function TdxNavBarOffice11ViewInfo.BgGradientMode: TdxBarStyleGradientMode;
begin
  if IsDefaultBgColor then
    Result := gmVertical
  else Result := inherited BgGradientMode;
end;

procedure TdxNavBarOffice11ViewInfo.AssignDefaultBackgroundStyle;
begin
  NavBar.DefaultStyles.Background.ResetValues;
  NavBar.DefaultStyles.Background.BackColor := clNone;
  NavBar.DefaultStyles.Background.BackColor2 := clNone;
end;

procedure TdxNavBarOffice11ViewInfo.AssignDefaultGroupBackgroundStyle;
begin
  NavBar.DefaultStyles.GroupBackground.ResetValues;
  NavBar.DefaultStyles.GroupBackground.BackColor := clNone;
  NavBar.DefaultStyles.GroupBackground.BackColor2 := clNone;
end;

procedure TdxNavBarOffice11ViewInfo.AssignDefaultGroupHeaderStyle;
begin
  NavBar.DefaultStyles.GroupHeader.ResetValues;
  NavBar.DefaultStyles.GroupHeader.BackColor := clNone;
  NavBar.DefaultStyles.GroupHeader.BackColor2 := clNone;
  NavBar.DefaultStyles.GroupHeader.Font.Color := clNone;
  NavBar.DefaultStyles.GroupHeader.Font.Size := 10;
  NavBar.DefaultStyles.GroupHeader.Font.Style := [fsBold];
end;

procedure TdxNavBarOffice11ViewInfo.AssignDefaultGroupHeaderActiveStyle;
begin
  NavBar.DefaultStyles.GroupHeaderActive.Assign(NavBar.DefaultStyles.GroupHeader);
end;

procedure TdxNavBarOffice11ViewInfo.AssignDefaultItemStyle;
begin
  NavBar.DefaultStyles.Item.ResetValues;
  NavBar.DefaultStyles.Item.Font.Color := clNone;
  NavBar.DefaultStyles.Item.HAlignment := haCenter;
end;

procedure TdxNavBarOffice11ViewInfo.CreateColors;
begin
  dxNavBarGraphics.CreateOffice11Colors;
end;

procedure TdxNavBarOffice11ViewInfo.RefreshColors;
begin
  dxNavBarGraphics.RefreshOffice11Colors;
end;

procedure TdxNavBarOffice11ViewInfo.ReleaseColors;
begin
  dxNavBarGraphics.ReleaseOffice11Colors;
end;

function TdxNavBarOffice11ViewInfo.GetGroupEdges: TPoint;
begin
  Result := cxPoint(10, 4);
end;

function TdxNavBarOffice11ViewInfo.GetGroupSeparatorWidth: Integer;
begin
  Result := 4;
end;

function TdxNavBarOffice11ViewInfo.GetLinksImageEdges: TRect;
begin
  Result := cxRect(4, 4, 4, 4);
end;

function TdxNavBarOffice11ViewInfo.IsDefaultBgColor: Boolean;
begin
  Result := (inherited BgBackColor = clNone) or (inherited BgBackColor2 = clNone)
end;

{ TdxNavBarOffice11Painter }

class function TdxNavBarOffice11Painter.SignPainterClass: TdxNavBarCustomSignPainterClass;
begin
  Result := TdxNavBarOffice11SignPainter;
end;

class function TdxNavBarOffice11Painter.GetViewInfoClass: TdxNavBarViewInfoClass;
begin
  Result := TdxNavBarOffice11ViewInfo;
end;

class function TdxNavBarOffice11Painter.GetGroupViewInfoClass: TdxNavBarGroupViewInfoClass;
begin
  Result := TdxNavBarOffice11GroupViewInfo;
end;

class function TdxNavBarOffice11Painter.GetLinkViewInfoClass: TdxNavBarLinkViewInfoClass;
begin
  Result := TdxNavBarOffice11LinkViewInfo;
end;

class function TdxNavBarOffice11Painter.ButtonPainterClass: TdxNavBarCustomButtonPainterClass;
begin
  Result := TdxNavBarAdvExplorerButtonPainter;
end;

{ TdxNavBarOffice11ExplorerBarGroupViewInfo }

function TdxNavBarOffice11ExplorerBarGroupViewInfo.CaptionBorderColor: TColor;
begin
  Result := dxOffice11NavPaneBorder;
end;

function TdxNavBarOffice11ExplorerBarGroupViewInfo.CaptionBackColor: TColor;
begin
  if not IsDefaultCaptionColor then
    Result := inherited CaptionBackColor
  else
    Result := dxOffice11NavPaneGroupCaptionColor1;
  exit;
    if sActive in State then
    begin
      if sHotTracked in State then
        Result := dxOffice11NavPaneGroupCaptionPressedHotColor1
      else
        Result := dxOffice11NavPaneGroupCaptionPressedColor1;
    end
    else
      if sHotTracked in State then
        Result := dxOffice11NavPaneGroupCaptionHotColor1
      else
        Result := dxOffice11NavPaneGroupCaptionColor1;
end;

function TdxNavBarOffice11ExplorerBarGroupViewInfo.CaptionBackColor2: TColor;
begin
  if not IsDefaultCaptionColor then
    Result := inherited CaptionBackColor2
  else
    Result := dxOffice11NavPaneGroupCaptionColor2;
  Exit;
    if sActive in State then
    begin
      if sHotTracked in State then
        Result := dxOffice11NavPaneGroupCaptionPressedHotColor2
      else
        Result := dxOffice11NavPaneGroupCaptionPressedColor2;
    end
    else
      if sHotTracked in State then
        Result := dxOffice11NavPaneGroupCaptionHotColor2
      else
        Result := dxOffice11NavPaneGroupCaptionColor2;
end;

function TdxNavBarOffice11ExplorerBarGroupViewInfo.CaptionAlphaBlend: Byte;
begin
  if not IsDefaultCaptionColor then
    Result := inherited CaptionAlphaBlend
  else Result := 255;
end;

function TdxNavBarOffice11ExplorerBarGroupViewInfo.CaptionAlphaBlend2: Byte;
begin
  if not IsDefaultCaptionColor then
    Result := inherited CaptionAlphaBlend2
  else Result := 255;
end;

function TdxNavBarOffice11ExplorerBarGroupViewInfo.CaptionGradientMode: TdxBarStyleGradientMode;
begin
  if not IsDefaultCaptionColor then
    Result := inherited CaptionGradientMode
  else Result := gmVertical;
end;

function TdxNavBarOffice11ExplorerBarGroupViewInfo.IsDefaultCaptionColor: Boolean;
begin
  Result := (inherited CaptionBackColor = clNone) or (inherited CaptionBackColor2 = clNone);
end;

{ TdxNavBarOffice11ExplorerBarViewInfo }

procedure TdxNavBarOffice11ExplorerBarViewInfo.AssignDefaultBackgroundStyle;
begin
  NavBar.DefaultStyles.Background.ResetValues;
  NavBar.DefaultStyles.Background.BackColor := clWindow;
  NavBar.DefaultStyles.Background.BackColor2 := clWindow;
end;

procedure TdxNavBarOffice11ExplorerBarViewInfo.AssignDefaultButtonStyle;
begin
  NavBar.DefaultStyles.Button.ResetValues;
  NavBar.DefaultStyles.Button.BackColor := clNone;
  NavBar.DefaultStyles.Button.BackColor2 := clNone;
end;

procedure TdxNavBarOffice11ExplorerBarViewInfo.AssignDefaultGroupBackgroundStyle;
begin
  NavBar.DefaultStyles.GroupBackground.ResetValues;
  NavBar.DefaultStyles.GroupBackground.BackColor := clWindow;
  NavBar.DefaultStyles.GroupBackground.BackColor2 := clWindow;
end;

procedure TdxNavBarOffice11ExplorerBarViewInfo.AssignDefaultGroupHeaderStyle;
begin
  NavBar.DefaultStyles.GroupHeader.ResetValues;
  NavBar.DefaultStyles.GroupHeader.BackColor := clNone;
  NavBar.DefaultStyles.GroupHeader.BackColor2 := clNone;
  NavBar.DefaultStyles.GroupHeader.Font.Style := [fsBold];
end;

procedure TdxNavBarOffice11ExplorerBarViewInfo.AssignDefaultItemStyle;
begin
  NavBar.DefaultStyles.Item.ResetValues;
  NavBar.DefaultStyles.Item.Font.Color := clWindowText;
  NavBar.DefaultStyles.Item.HAlignment := haCenter;
end;

procedure TdxNavBarOffice11ExplorerBarViewInfo.AssignDefaultItemDisabledStyle;
begin
  NavBar.DefaultStyles.ItemDisabled.Assign(NavBar.DefaultStyles.Item);
  NavBar.DefaultStyles.ItemDisabled.Font.Color := clGrayText;
end;

procedure TdxNavBarOffice11ExplorerBarViewInfo.AssignDefaultNavigationPaneHeaderStyle;
begin
  NavBar.DefaultStyles.NavigationPaneHeader.ResetValues;
  NavBar.DefaultStyles.NavigationPaneHeader.BackColor := clNone;
  NavBar.DefaultStyles.NavigationPaneHeader.BackColor2 := clNone;
  NavBar.DefaultStyles.NavigationPaneHeader.Font.Color := clNone;
  NavBar.DefaultStyles.NavigationPaneHeader.Font.Name := 'Arial';
  NavBar.DefaultStyles.NavigationPaneHeader.Font.Size := 11;
  NavBar.DefaultStyles.NavigationPaneHeader.Font.Style := [fsBold];
end;

procedure TdxNavBarOffice11ExplorerBarViewInfo.CreateColors;
begin
  CreateOffice11NavPaneColors;
end;

procedure TdxNavBarOffice11ExplorerBarViewInfo.RefreshColors;
begin
  RefreshOffice11NavPaneColors;
end;

procedure TdxNavBarOffice11ExplorerBarViewInfo.ReleaseColors;
begin
  ReleaseOffice11NavPaneColors;
end;

function TdxNavBarOffice11ExplorerBarViewInfo.CanSelectLinkByRect: Boolean;
begin
  Result := True;
end;

function TdxNavBarOffice11ExplorerBarViewInfo.GetGroupBorderOffsets: TRect;
begin
  Result := cxNullRect;
end;

function TdxNavBarOffice11ExplorerBarViewInfo.GetGroupCaptionHeightAddon: Integer;
begin
  Result := 6;
end;

class function TdxNavBarOffice11ExplorerBarViewInfo.GetGroupCaptionImageIndent: Integer;
begin
  Result := 2;
end;

function TdxNavBarOffice11ExplorerBarViewInfo.GetGroupEdges: TPoint;
begin
  Result := cxPoint(0, 0);
end;

function TdxNavBarOffice11ExplorerBarViewInfo.GetGroupSeparatorWidth: Integer;
begin
  Result := 0;
end;

{ TdxNavBarOffice11ExplorerBarController }

procedure TdxNavBarOffice11ExplorerBarController.DoMouseDown(AButton: TMouseButton; AShift: TShiftState; const APoint: TPoint);
begin
  if MouseOverSizeGrip then
    TdxNavBarGroupControl(FNavBar.Parent).BeginResize(FNavBar, AButton, AShift, APoint)
  else
    inherited;
end;

procedure TdxNavBarOffice11ExplorerBarController.DoMouseMove(AShift: TShiftState; const APoint: TPoint);
begin
  MouseOverSizeGrip := (FNavBar.Parent is TdxNavBarGroupControl) and
    TdxNavBarGroupControl(FNavBar.Parent).IsOnPopupControl and
    not (FNavBar.IsPtBottomScrollButton(APoint) or FNavBar.IsPtTopScrollButton(APoint)) and
    cxRectPtIn(TdxNavBarGroupControl(FNavBar.Parent).GetSizeGripRect(FNavBar), APoint);
  if not MouseOverSizeGrip then
    inherited;
end;

function TdxNavBarOffice11ExplorerBarController.GetCursor: HIcon;
begin
  if MouseOverSizeGrip then
    Result := Screen.Cursors[crSizeWE]
  else
    Result := inherited GetCursor;
end;

function TdxNavBarOffice11ExplorerBarController.GetMouseOverSizeGrip: Boolean;
begin
  Result := ecsOverSizeGrip in FInternalState;
end;

procedure TdxNavBarOffice11ExplorerBarController.SetMouseOverSizeGrip(AValue: Boolean);
begin
  if MouseOverSizeGrip <> AValue then
    if AValue then
      Include(FInternalState, ecsOverSizeGrip)
    else
      Exclude(FInternalState, ecsOverSizeGrip);
end;

{ TdxNavBarOffice11ExplorerBarPainter }

procedure TdxNavBarOffice11ExplorerBarPainter.DrawNavBarControl;
begin
  inherited;
  if (NavBar.Parent is TdxNavBarGroupControl) and
    TdxNavBarGroupControl(NavBar.Parent).IsOnPopupControl then
    TdxNavBarGroupControl(NavBar.Parent).DrawSizeGrip(Canvas, TdxNavBarGroupControl(NavBar.Parent).GetSizeGripRect(NavBar));
end;

procedure TdxNavBarOffice11ExplorerBarPainter.DrawGroupControlSplitter(AGroupViewInfo: TdxNavBarExplorerBarGroupViewInfo);
var
  APoint: TPoint;
begin
  with AGroupViewInfo do
    ButtonPainterClass.DrawButton(Canvas, SplitterRect, CaptionImage,
      CaptionBackColor, CaptionBackColor2, CaptionAlphaBlend, CaptionAlphaBlend2,
      CaptionGradientMode, CaptionBorderColor, State);
  if dxOffice11NavPaneSplitterBitmap <> nil then
  begin
    APoint := cxRectCenter(AGroupViewInfo.SplitterRect, dxOffice11NavPaneSplitterBitmap.Width, dxOffice11NavPaneSplitterBitmap.Height).TopLeft;
    if APoint.X > AGroupViewInfo.SplitterRect.Left then
      Canvas.Draw(APoint.X, APoint.Y, dxOffice11NavPaneSplitterBitmap);
  end;
end;

class function TdxNavBarOffice11ExplorerBarPainter.GetViewInfoClass: TdxNavBarViewInfoClass;
begin
  Result := TdxNavBarOffice11ExplorerBarViewInfo;
end;

class function TdxNavBarOffice11ExplorerBarPainter.GetGroupViewInfoClass: TdxNavBarGroupViewInfoClass;
begin
  Result := TdxNavBarOffice11ExplorerBarGroupViewInfo;
end;

function TdxNavBarOffice11ExplorerBarPainter.GetControllerClass: TdxNavBarControllerClass;
begin
  Result := TdxNavBarOffice11ExplorerBarController;
end;

class function TdxNavBarOffice11ExplorerBarPainter.SignPainterClass: TdxNavBarCustomSignPainterClass;
begin
  Result := TdxNavBarOffice11ExplorerBarSignPainter;
end;

{ TdxNavBarOffice11ExplorerBarSignPainter }

class procedure TdxNavBarOffice11ExplorerBarSignPainter.DrawSignSelection(ACanvas: TCanvas; ARect: TRect; AForeColor,
  ABackColor1, ABackColor2: TColor; AState: TdxNavBarObjectStates);
begin
end;

{ TdxNavBarNavigationPane }

function TdxNavBarNavigationPaneGroupViewInfo.CaptionBorderColor: TColor;
begin
  Result := dxOffice11NavPaneBorder;
end;

function TdxNavBarNavigationPaneGroupViewInfo.CaptionBackColor: TColor;
begin
  if not IsDefaultCaptionColor then
    Result := inherited CaptionBackColor
  else
    if sActive in State then
    begin
      if sHotTracked in State then
        Result := dxOffice11NavPaneGroupCaptionPressedHotColor1
      else
        Result := dxOffice11NavPaneGroupCaptionPressedColor1;
    end
    else
      if sHotTracked in State then
        Result := dxOffice11NavPaneGroupCaptionHotColor1
      else
        Result := dxOffice11NavPaneGroupCaptionColor1;
end;

function TdxNavBarNavigationPaneGroupViewInfo.CaptionBackColor2: TColor;
begin
  if not IsDefaultCaptionColor then
    Result := inherited CaptionBackColor2
  else
    if sActive in State then
    begin
      if sHotTracked in State then
        Result := dxOffice11NavPaneGroupCaptionPressedHotColor2
      else
        Result := dxOffice11NavPaneGroupCaptionPressedColor2;
    end
    else
      if sHotTracked in State then
        Result := dxOffice11NavPaneGroupCaptionHotColor2
      else
        Result := dxOffice11NavPaneGroupCaptionColor2;
end;

function TdxNavBarNavigationPaneGroupViewInfo.CaptionAlphaBlend: Byte;
begin
  if not IsDefaultCaptionColor then
    Result := inherited CaptionAlphaBlend
  else Result := 255;
end;

function TdxNavBarNavigationPaneGroupViewInfo.CaptionAlphaBlend2: Byte;
begin
  if not IsDefaultCaptionColor then
    Result := inherited CaptionAlphaBlend2
  else Result := 255;
end;

function TdxNavBarNavigationPaneGroupViewInfo.CaptionGradientMode: TdxBarStyleGradientMode;
begin
  if not IsDefaultCaptionColor then
    Result := inherited CaptionGradientMode
  else Result := gmVertical;
end;

function TdxNavBarNavigationPaneGroupViewInfo.IsDefaultCaptionColor: Boolean;
begin
  Result := (inherited CaptionBackColor = clNone) or (inherited CaptionBackColor2 = clNone);
end;

{ TdxNavBarOffice11NavPaneLinkViewInfo }

function TdxNavBarOffice11NavPaneLinkViewInfo.SeparatorColor: TColor;
begin
  Result := ViewInfo.BorderColor;
end;

{ TdxNavBarNavigationPaneCustomViewInfo }

constructor TdxNavBarNavigationPaneCustomViewInfo.Create(AViewInfo: TdxNavBarViewInfo);
begin
  inherited Create;
  FViewInfo := AViewInfo;
  FPainter := FViewInfo.Painter;
  FNavBar := FViewInfo.NavBar;
end;

function TdxNavBarNavigationPaneCustomViewInfo.GetViewInfo: TdxNavBarNavigationPaneViewInfo;
begin
  Result := TdxNavBarNavigationPaneViewInfo(FViewInfo);
end;

function TdxNavBarNavigationPaneCustomViewInfo.GetPainter: TdxNavBarNavigationPanePainter;
begin
  Result := TdxNavBarNavigationPanePainter(inherited Painter);
end;

{ TdxNavBarOverflowPanelViewInfo }

constructor TdxNavBarOverflowPanelViewInfo.Create(AViewInfo: TdxNavBarViewInfo);
begin
  inherited;
  FItems := TObjectList.Create;
end;

destructor TdxNavBarOverflowPanelViewInfo.Destroy;
begin
  ClearItems;
  FreeAndNil(FItems);
  NavBarAccessibleObjectOwnerObjectDestroyed(FIAccessibilityHelper);
  inherited;
end;

function TdxNavBarOverflowPanelViewInfo.GetAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass;
begin
  Result := TdxNavBarNavigationPaneOverflowPanelAccessibilityHelper;
end;

procedure TdxNavBarOverflowPanelViewInfo.CalculateBounds(X, Y: Integer);

  procedure CalculateItemRects(const AItemsRect: TRect);
  var
    I, AStartPos, ASelectionWidth: Integer;
    APlaceCount: Integer;
    ASelectionRect, AItemRect: TRect;
  begin
    ASelectionWidth := GetItemSelectionWidth;
    APlaceCount := cxRectWidth(AItemsRect) div ASelectionWidth;
    FVisibleItemCount := Min(APlaceCount, ItemCount);

    AStartPos := AItemsRect.Right - FVisibleItemCount * ASelectionWidth;

    ASelectionRect := cxRect(0, 0, ASelectionWidth, cxRectHeight(AItemsRect));
    OffsetRect(ASelectionRect, AStartPos, AItemsRect.Top);

    AItemRect := cxRect(0, 0, ASelectionWidth, GetImageHeight);
    OffsetRect(AItemRect, AStartPos, AItemsRect.Top +
      (cxRectHeight(AItemsRect) - GetImageHeight) div 2);
    InflateRect(AItemRect, -GetImageWidthAddon, 0);

    for I := 0 to FVisibleItemCount - 1 do
    begin
      Items[I].SelectionRect := ASelectionRect;
      OffsetRect(Items[I].SelectionRect, ASelectionWidth * I, 0);
      Items[I].Rect := AItemRect;
      OffsetRect(Items[I].Rect, ASelectionWidth * I, 0);
    end;
  end;

var
  AClientRect, AItemsRect: TRect;
begin
  if not IsVisible then
    Exit;

  FRect := Bounds(X, Y, ViewInfo.ClientWidth - 2*X, GetHeight);

  AClientRect := cxRectContent(FRect, GetClientOffset);
  FSignRect := AClientRect;
  FSignRect.Left := FSignRect.Right - GetSignWidth;

  if ViewInfo.Painter.Controller.Collapsed then
    AItemsRect := cxNullRect
  else
  begin
    AItemsRect := AClientRect;
    AItemsRect.Right := FSignRect.Left - GetSeparator;
  end;
  CalculateItemRects(AItemsRect);
end;

function TdxNavBarOverflowPanelViewInfo.IsVisible: Boolean;
begin
  Result := NavBar.OptionsView.NavigationPane.ShowOverflowPanel;
end;

function TdxNavBarOverflowPanelViewInfo.GetHeight: Integer;

  function GetHeight: Integer;
  begin
    Result := GetImageHeight;
    if ViewInfo.FImageHeightPeer then
      Result := Max(ViewInfo.FMaxImageSize.cy, Result)
  end;

begin
  if not IsVisible then
    Result := 0
  else
    Result := GetHeight + GetHeightAddon;
end;

function TdxNavBarOverflowPanelViewInfo.GetImageHeight: Integer;
begin
  if NavBar.NavigationPaneOverflowPanelUseSmallImages then
    Result := ViewInfo.GetSmallImageHeight
  else
    Result := ViewInfo.GetLargeImageHeight;
end;

function TdxNavBarOverflowPanelViewInfo.GetImageWidth: Integer;
begin
  if NavBar.NavigationPaneOverflowPanelUseSmallImages then
    Result := ViewInfo.GetSmallImageWidth
  else
    Result := ViewInfo.GetLargeImageWidth;
end;

function TdxNavBarOverflowPanelViewInfo.GetImageList: TCustomImageList;
begin
  if NavBar.NavigationPaneOverflowPanelUseSmallImages then
    Result := NavBar.SmallImages
  else
    Result := NavBar.LargeImages;
end;

function TdxNavBarOverflowPanelViewInfo.GetImageIndex(AGroup: TdxNavBarGroup): Integer;
begin
  if NavBar.NavigationPaneOverflowPanelUseSmallImages then
    Result := AGroup.SmallImageIndex
  else
    Result := AGroup.LargeImageIndex;
end;

function TdxNavBarOverflowPanelViewInfo.GetItemIndexAtPos(const pt: TPoint): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FVisibleItemCount - 1 do
    if PtInRect(Items[I].SelectionRect, pt) then
    begin
      Result := I;
      Break;
    end;
end;

function TdxNavBarOverflowPanelViewInfo.GetItemSelectionWidth: Integer;
begin
  Result := GetImageWidth + 2 * GetImageWidthAddon;
end;

function TdxNavBarOverflowPanelViewInfo.GetGroupAtPos(const pt: TPoint): TdxNavBarGroup;
var
  AIndex: Integer;
begin
  AIndex := GetItemIndexAtPos(pt);
  if AIndex >= 0 then
  begin
    Result := Items[AIndex].Group;
    if (Result <> nil) and (csDestroying in Result.ComponentState) then
      Result := nil;
  end
  else
    Result := nil;
end;

function TdxNavBarOverflowPanelViewInfo.GetHeightAddon: Integer;
begin
  Result := 8;
end;

function TdxNavBarOverflowPanelViewInfo.GetImageWidthAddon: Integer;
begin
  Result := 3;
end;

function TdxNavBarOverflowPanelViewInfo.GetPopupMenuImageIndent: Integer;
begin
  Result := 3;
end;

function TdxNavBarOverflowPanelViewInfo.GetPopupMenuTextIndent: Integer;
begin
  Result := 4;
end;

function TdxNavBarOverflowPanelViewInfo.GetSignWidth: Integer;
begin
  Result := 18;
end;

function TdxNavBarOverflowPanelViewInfo.GetSeparator: Integer;
begin
  Result := 0;
end;

function TdxNavBarOverflowPanelViewInfo.GetClientOffset: TRect;
begin
  Result := cxNullRect;
  Result := cxRectOffset(Result, 0, ViewInfo.BorderWidth);
end;

procedure TdxNavBarOverflowPanelViewInfo.ClearRects;
begin
  SetRectEmpty(FRect);
  SetRectEmpty(FSignRect);
end;

procedure TdxNavBarOverflowPanelViewInfo.ClearItems;
begin
  FVisibleItemCount := 0;
  FItems.Clear;
end;

procedure TdxNavBarOverflowPanelViewInfo.OffsetElements(AHeightDifference: Integer);
var
  I: Integer;
begin
  if not IsVisible then
    Exit;
  OffsetRect(FRect, 0, AHeightDifference);
  OffsetRect(FSignRect, 0, AHeightDifference);
  for I := 0 to FVisibleItemCount - 1 do
  begin
    OffsetRect(Items[I].Rect, 0, AHeightDifference);
    OffsetRect(Items[I].SelectionRect, 0, AHeightDifference);
  end;
end;

function TdxNavBarOverflowPanelViewInfo.GetIAccessibilityHelper: IdxNavBarAccessibilityHelper;
begin
  if FIAccessibilityHelper = nil then
    FIAccessibilityHelper := NavBarGetAccessibilityHelper(
      GetAccessibilityHelperClass.Create(Self, NavBar));
  Result := FIAccessibilityHelper;
end;

function TdxNavBarOverflowPanelViewInfo.AddItem: TdxNavBarOverflowPanelViewInfoItem;
begin
  Result := TdxNavBarOverflowPanelViewInfoItem.Create;
  FItems.Insert(0, Result);
end;

function TdxNavBarOverflowPanelViewInfo.GetItemCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxNavBarOverflowPanelViewInfo.GetItems(AIndex: Integer): TdxNavBarOverflowPanelViewInfoItem;
begin
  Result := TdxNavBarOverflowPanelViewInfoItem(FItems[AIndex]);
end;

{ TdxNavBarItemPanelViewInfoItem }

procedure TdxNavBarItemPanelViewInfoItem.OffsetRects(dX, dY: Integer);
begin
  Rect := cxRectOffset(Rect, dX, dY);
  TextRect := cxRectOffset(TextRect, dX, dY);
  ImageRect := cxRectOffset(ImageRect, dX, dY);
end;

function TdxNavBarItemPanelViewInfoItem.GetCaption: string;
begin
  Result := ItemLink.Item.Caption;
end;

{ TdxNavBarItemPanelViewInfo }

constructor TdxNavBarItemPanelViewInfo.Create(AViewInfo: TdxNavBarViewInfo);
begin
  inherited;
  FItems := TObjectList.Create;
  NavBar.IAccessibilityHelper.AttachChild(IAccessibilityHelper);
end;

destructor TdxNavBarItemPanelViewInfo.Destroy;
begin
  if not (csDestroying in NavBar.ComponentState) then
    NavBar.IAccessibilityHelper.DetachChild(IAccessibilityHelper);
  NavBarAccessibleObjectOwnerObjectDestroyed(FIAccessibilityHelper);
  FreeAndNil(FItems);
  inherited;
end;

function TdxNavBarItemPanelViewInfo.GetMinHeight: Integer;
begin
  if FIsCollapseMode then
    Result := cxTextWidth(CollapseBarFont, CollapseBarText) + GetCollapseBarCaptionIndent * 2
  else
    Result := ViewInfo.GetActiveGroupMinHeight;
end;

procedure TdxNavBarItemPanelViewInfo.CalculateBounds(var X, Y: Integer);

   procedure CalculateItemRects(ARect: TRect);
   var
     I: Integer;
     AItem: TdxNavBarItemPanelViewInfoItem;
     ATextWidth, AIndent: Integer;
     AImageSize: TSize;
   begin
     for I := 0 to ItemCount - 1 do
     begin
       AItem := Items[I];
       AIndent := ViewInfo.GetGroupCaptionImageIndent;
       ATextWidth := cxTextWidth(AItem.Font, AItem.Caption);
       AItem.TextRect := cxRect(ARect.Left, ARect.Bottom, ARect.Right, ARect.Bottom + ATextWidth + AIndent * 2);

       if IsImageAssigned(AItem.ImageList, AItem.ImageIndex) then
         AImageSize := Size(ViewInfo.GetSmallImageWidth, ViewInfo.GetSmallImageHeight)
       else
         AImageSize := cxNullSize;
       AItem.ImageRect := cxRectCenter(cxRect(ARect.Left, AItem.TextRect.Bottom, ARect.Right, AItem.TextRect.Bottom + AImageSize.cy), AImageSize);

       AItem.Rect := cxRect(ARect.Left, AItem.TextRect.Top, ARect.Right, AItem.ImageRect.Bottom);
       if IsImageAssigned(AItem.ImageList, AItem.ImageIndex) then
         AItem.Rect.Bottom := AItem.Rect.Bottom + AIndent;

       ARect.Bottom := AItem.Rect.Bottom;
     end;
   end;

begin
  if (FActiveGroupViewInfo <> nil) and not FIsCollapseMode then
  begin
    FActiveGroupViewInfo.CalculateBounds(X, Y);
    FRect := FActiveGroupViewInfo.Rect;
  end
  else
  begin
    FRect := Bounds(X, Y, ViewInfo.ClientWidth - 2*X, GetMinHeight);
    Y := FRect.Bottom;
  end;
  if FIsCollapseMode then
  begin
    FCollapseBarRect := FRect;
    CalculateItemRects(FCollapseBarRect);
  end
  else
    FCollapseBarRect := cxNullRect;
end;

procedure TdxNavBarItemPanelViewInfo.CorrectBounds(AHeightDifference: Integer);
var
  I, ALastVisibleIndex: Integer;
begin
  FRect.Bottom := FRect.Bottom + AHeightDifference;
  if (FActiveGroupViewInfo <> nil) and not FIsCollapseMode then
    FActiveGroupViewInfo.CorrectActiveGroupBounds(0, AHeightDifference);
  if FIsCollapseMode then
  begin
    ALastVisibleIndex := -1;
    for I := 0 to ItemCount - 1 do
    begin
      if cxRectHeight(Items[I].Rect) <= AHeightDifference then
      begin
        AHeightDifference := AHeightDifference - cxRectHeight(Items[I].Rect);
        ALastVisibleIndex := I;
      end
      else
        Break;
    end;
    for I := ItemCount - 1 downto ALastVisibleIndex + 1 do
      FItems.Delete(I);
    FCollapseBarRect.Bottom := FCollapseBarRect.Bottom + AHeightDifference;
    for I := 0 to ItemCount - 1 do
      Items[I].OffsetRects(0, AHeightDifference);
    (IAccessibilityHelper.GetHelper as TdxNavBarItemPanelAccessibilityHelper).CheckItemIAccessibilityHelperCount;
  end;
end;

function TdxNavBarItemPanelViewInfo.GetCollapseBarFont: TFont;
begin
  Result := ViewInfo.HeaderFont;
end;

function TdxNavBarItemPanelViewInfo.GetCollapseBarText: string;
begin
  if NavBar.OptionsView.NavigationPane.ShowActiveGroupCaptionWhenCollapsed and
    (FCollapseBarGroup <> nil) then
    Result :=  FCollapseBarGroup.Caption
  else
    Result := cxGetResourceString(@sdxNavigationPaneCollapseBar);
end;

function TdxNavBarItemPanelViewInfo.GetItemFont(AIndex: Integer): TFont;
begin
  Result := NavBar.DefaultStyles.Item.Font;
end;

function TdxNavBarItemPanelViewInfo.GetItemIndexAtPos(const pt: TPoint): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to ItemCount - 1 do
    if PtInRect(Items[I].Rect, pt) then
    begin
      Result := I;
      Break;
    end;
end;

function TdxNavBarItemPanelViewInfo.GetCollapseBarCaptionIndent: Integer;
begin
  Result := GetRevisedValue(4);
end;

function TdxNavBarItemPanelViewInfo.GetAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass;
begin
  Result := TdxNavBarItemPanelAccessibilityHelper;
end;

function TdxNavBarItemPanelViewInfo.GetCollapseBarIAccessibilityHelper: IdxNavBarAccessibilityHelper;
begin
  Result := (IAccessibilityHelper.GetHelper as TdxNavBarItemPanelAccessibilityHelper).CollapseBarIAccessibilityHelper;
end;

function TdxNavBarItemPanelViewInfo.GetIAccessibilityHelper: IdxNavBarAccessibilityHelper;
begin
  if FIAccessibilityHelper = nil then
    FIAccessibilityHelper := NavBarGetAccessibilityHelper(
      GetAccessibilityHelperClass.Create(Self, NavBar));
  Result := FIAccessibilityHelper;
end;

function TdxNavBarItemPanelViewInfo.GetItemCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxNavBarItemPanelViewInfo.GetItemIAccessibilityHelper(
  AIndex: Integer): IdxNavBarAccessibilityHelper;
begin
  Result := (IAccessibilityHelper.GetHelper as TdxNavBarItemPanelAccessibilityHelper).ItemIAccessibilityHelpers[AIndex];
end;

function TdxNavBarItemPanelViewInfo.GetItems(AIndex: Integer): TdxNavBarItemPanelViewInfoItem;
begin
  Result := TdxNavBarItemPanelViewInfoItem(FItems[AIndex]);
end;

procedure TdxNavBarItemPanelViewInfo.SetActiveGroupViewInfo(AValue: TdxNavBarGroupViewInfo);
begin
  FActiveGroupViewInfo := AValue;
end;

function TdxNavBarItemPanelViewInfo.AddItem: TdxNavBarItemPanelViewInfoItem;
begin
  Result := TdxNavBarItemPanelViewInfoItem.Create;
  Result.Index := FItems.Add(Result);
end;

procedure TdxNavBarItemPanelViewInfo.ClearItems;
begin
  FItems.Clear;
end;

procedure TdxNavBarItemPanelViewInfo.CreateItems;
var
  I: Integer;
  APanelItem: TdxNavBarItemPanelViewInfoItem;
  ALink: TdxNavBarItemLink;
begin
  ClearItems;
  if FIsCollapseMode and (FCollapseBarGroup <> nil) then
  begin
    for I := 0 to FCollapseBarGroup.LinkCount - 1 do
    begin
      ALink := FCollapseBarGroup.Links[I];
      if ALink.CanSelect and ALink.Item.Visible then
      begin
        APanelItem := AddItem;
        APanelItem.ItemLink := ALink;
        APanelItem.Font := GetItemFont(I);
        APanelItem.ImageList := NavBar.SmallImages;
        APanelItem.ImageIndex := APanelItem.ItemLink.Item.SmallImageIndex;
      end;
    end;
  end;
end;

{ TdxNavBarOffice11NavPanelViewInfo }

constructor TdxNavBarNavigationPaneViewInfo.Create(APainter: TdxNavBarPainter);
begin
  inherited;
  FOverflowPanelViewInfo := GetOverflowPanelViewInfoClass.Create(Self);
  FItemPanelViewInfo := TdxNavBarItemPanelViewInfo.Create(Self);
  FImageList := TImageList.Create(NavBar);
  FPopupMenu := TPopupMenu.Create(NavBar);
  APainter.NavBar.IAccessibilityHelper.AttachChild(
    ActiveGroupCaptionPanelIAccessibilityHelper);
  APainter.NavBar.IAccessibilityHelper.AttachChild(
    HeaderSignIAccessibilityHelper);
  APainter.NavBar.IAccessibilityHelper.AttachChild(
    OverflowPanelIAccessibilityHelper);
end;

destructor TdxNavBarNavigationPaneViewInfo.Destroy;
begin
  if not (csDestroying in NavBar.ComponentState) then
  begin
    NavBar.IAccessibilityHelper.DetachChild(ActiveGroupCaptionPanelIAccessibilityHelper);
    NavBar.IAccessibilityHelper.DetachChild(HeaderSignIAccessibilityHelper);
    NavBar.IAccessibilityHelper.DetachChild(OverflowPanelIAccessibilityHelper);
  end;
  NavBarAccessibleObjectOwnerObjectDestroyed(FActiveGroupCaptionPanelIAccessibilityHelper);
  NavBarAccessibleObjectOwnerObjectDestroyed(FHeaderSignIAccessibilityHelper);
  FPopupMenu.Free;
  FImageList.Free;
  FreeAndnil(FItemPanelViewInfo);
  FreeAndnil(FOverflowPanelViewInfo);
  inherited;
end;

function TdxNavBarNavigationPaneViewInfo.FindGroupWithAccel(AKey: Word): TdxNavBarGroup;
var
  AIndex: Integer;
  AGroup: TdxNavBarGroup;
begin
  Result := inherited FindGroupWithAccel(AKey);
  if (Result = nil) and (FOverflowPanelViewInfo.IsVisible) and not Painter.Controller.Collapsed then
    for AIndex := 0 to FOverflowPanelViewInfo.ItemCount - 1 do
    begin
      AGroup := FOverflowPanelViewInfo.Items[AIndex].Group;
      if IsAccel(AKey, AGroup.Caption) then
      begin
        Result := AGroup;
        Break;
      end
    end;
end;

function TdxNavBarNavigationPaneViewInfo.FindLinkWithAccel(AKey: Word): TdxNavBarItemLink;
var
  AIndex: Integer;
  AItemPanelViewInfoItem: TdxNavBarItemPanelViewInfoItem;
begin
  Result := inherited FindLinkWithAccel(AKey);
  if Result = nil then
    for AIndex := 0 to FItemPanelViewInfo.ItemCount - 1 do
    begin
      AItemPanelViewInfoItem := FItemPanelViewInfo.Items[AIndex];
      if IsAccel(AKey, AItemPanelViewInfoItem.Caption) then
      begin
        Result := AItemPanelViewInfoItem.ItemLink;
        Break;
      end
    end;
end;

function TdxNavBarNavigationPaneViewInfo.GetLinkAtPos(const pt: TPoint): TdxNavBarItemLink;
var
  APart: TdxNavBarPart;
begin
  if Painter.Controller.Collapsed then
  begin
    APart := Painter.Controller.GetPartAtPos(pt);
    if APart.MajorPartIndex = nbItemPanelCollapseItem then
      Result := ItemPanelViewInfo.Items[APart.MinorPartIndex].ItemLink
    else
      if Painter.Controller.DroppedDownPart.MajorPartIndex = nbItemPanelCollapseBar then
        Result := Painter.Controller.PopupControl.FInnerControl.GetLinkAtPos(pt)
      else
        Result := nil;
  end
  else
    Result := inherited GetLinkAtPos(pt);
end;

function TdxNavBarNavigationPaneViewInfo.BorderWidth: Integer;
begin
  Result := 1;
end;

function TdxNavBarNavigationPaneViewInfo.BorderColor: TColor;
begin
  Result := dxOffice11NavPaneBorder;
end;

function TdxNavBarNavigationPaneViewInfo.CollapseBarFontColor: TColor;
begin
  Result := BorderColor;
end;

function TdxNavBarNavigationPaneViewInfo.BottomScrollButtonBackColor: TColor;
begin
  if not IsDefaultBottomScrollButtonColor then
    Result := inherited BottomScrollButtonBackColor
  else if sPressed in BottomScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionPressedColor1
  else if sActive in BottomScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionPressedColor2
  else if sHotTracked in BottomScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionHotColor1
  else Result := dxOffice11NavPaneGroupCaptionColor1;
end;

function TdxNavBarNavigationPaneViewInfo.BottomScrollButtonBackColor2: TColor;
begin
  if not IsDefaultBottomScrollButtonColor then
    Result := inherited BottomScrollButtonBackColor2
  else if sPressed in BottomScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionPressedColor2
  else if sActive in BottomScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionPressedColor1
  else if sHotTracked in BottomScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionHotColor2
  else Result := dxOffice11NavPaneGroupCaptionColor2;
end;

function TdxNavBarNavigationPaneViewInfo.BottomScrollButtonAlphaBlend: Byte;
begin
  if not IsDefaultBottomScrollButtonColor then
    Result := inherited BottomScrollButtonAlphaBlend
  else Result := 255;
end;

function TdxNavBarNavigationPaneViewInfo.BottomScrollButtonAlphaBlend2: Byte;
begin
  if not IsDefaultBottomScrollButtonColor then
    Result := inherited BottomScrollButtonAlphaBlend2
  else Result := 255;
end;

function TdxNavBarNavigationPaneViewInfo.BottomScrollButtonGradientMode: TdxBarStyleGradientMode;
begin
  if not IsDefaultBottomScrollButtonColor then
    Result := inherited BottomScrollButtonGradientMode
  else Result := gmVertical;
end;

function TdxNavBarNavigationPaneViewInfo.TopScrollButtonBackColor: TColor;
begin
  if not IsDefaultTopScrollButtonColor then
    Result := inherited TopScrollButtonBackColor
  else if sPressed in TopScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionPressedColor1
  else if sActive in TopScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionPressedColor2
  else if sHotTracked in TopScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionHotColor1
  else Result := dxOffice11NavPaneGroupCaptionColor1;
end;

function TdxNavBarNavigationPaneViewInfo.TopScrollButtonBackColor2: TColor;
begin
  if not IsDefaultTopScrollButtonColor then
    Result := inherited TopScrollButtonBackColor2
  else if sPressed in TopScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionPressedColor2
  else if sActive in TopScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionPressedColor1
  else if sHotTracked in TopScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionHotColor2
  else Result := dxOffice11NavPaneGroupCaptionColor2;
end;

function TdxNavBarNavigationPaneViewInfo.TopScrollButtonAlphaBlend: Byte;
begin
  if not IsDefaultTopScrollButtonColor then
    Result := inherited TopScrollButtonAlphaBlend
  else Result := 255;
end;

function TdxNavBarNavigationPaneViewInfo.TopScrollButtonAlphaBlend2: Byte;
begin
  if not IsDefaultTopScrollButtonColor then
    Result := inherited TopScrollButtonAlphaBlend2
  else Result := 255;
end;

function TdxNavBarNavigationPaneViewInfo.TopScrollButtonGradientMode: TdxBarStyleGradientMode;
begin
  if not IsDefaultTopScrollButtonColor then
    Result := inherited TopScrollButtonGradientMode
  else Result := gmVertical;
end;

function TdxNavBarNavigationPaneViewInfo.HeaderBackColor: TColor;
begin
  if not IsDefaultHeaderColor then
    Result := inherited HeaderBackColor
  else Result := dxOffice11NavPaneHeaderColor1;
end;

function TdxNavBarNavigationPaneViewInfo.HeaderBackColor2: TColor;
begin
  if not IsDefaultHeaderColor then
    Result := inherited HeaderBackColor2
  else Result := dxOffice11NavPaneHeaderColor2;
end;

function TdxNavBarNavigationPaneViewInfo.HeaderAlphaBlend: Byte;
begin
  if not IsDefaultHeaderColor then
    Result := inherited HeaderAlphaBlend
  else Result := 255;
end;

function TdxNavBarNavigationPaneViewInfo.HeaderAlphaBlend2: Byte;
begin
  if not IsDefaultHeaderColor then
    Result := inherited HeaderAlphaBlend2
  else Result := 255;
end;

function TdxNavBarNavigationPaneViewInfo.HeaderGradientMode: TdxBarStyleGradientMode;
begin
  if not IsDefaultHeaderColor then
    Result := inherited HeaderGradientMode
  else Result := gmVertical;
end;

function TdxNavBarNavigationPaneViewInfo.HeaderFontColor: TColor;
begin
  Result := inherited HeaderFontColor;
  if Result = clNone then
    Result := dxOffice11NavPaneHeaderFontColor;
end;

function TdxNavBarNavigationPaneViewInfo.OverflowPanelBackColor: TColor;
begin
  if not IsDefaultOverflowPanelColor then
    Result := inherited OverflowPanelBackColor
  else Result := dxOffice11NavPaneGroupCaptionColor1;
end;

function TdxNavBarNavigationPaneViewInfo.OverflowPanelBackColor2: TColor;
begin
  if not IsDefaultOverflowPanelColor then
    Result := inherited OverflowPanelBackColor2
  else Result := dxOffice11NavPaneGroupCaptionColor2;
end;

function TdxNavBarNavigationPaneViewInfo.OverflowPanelAlphaBlend: Byte;
begin
  if not IsDefaultOverflowPanelColor then
    Result := inherited OverflowPanelAlphaBlend
  else Result := 255;
end;

function TdxNavBarNavigationPaneViewInfo.OverflowPanelAlphaBlend2: Byte;
begin
  if not IsDefaultOverflowPanelColor then
    Result := inherited OverflowPanelAlphaBlend2
  else Result := 255;
end;

function TdxNavBarNavigationPaneViewInfo.OverflowPanelGradientMode: TdxBarStyleGradientMode;
begin
  if not IsDefaultOverflowPanelColor then
    Result := inherited OverflowPanelGradientMode
  else Result := gmVertical;
end;

function TdxNavBarNavigationPaneViewInfo.SplitterBackColor: TColor;
begin
  if XPScheme = schUnknown then
    Result := dxOffice11NavPaneSplitterColor1
  else
    Result := inherited SplitterBackColor;
end;

function TdxNavBarNavigationPaneViewInfo.SplitterBackColor2: TColor;
begin
  if XPScheme = schUnknown then
    Result := dxOffice11NavPaneSplitterColor2
  else
    Result := inherited SplitterBackColor2;
end;

function TdxNavBarNavigationPaneViewInfo.SplitterGradientMode: TdxBarStyleGradientMode;
begin
  if XPScheme = schUnknown then
    Result := gmVertical
  else
    Result := inherited SplitterGradientMode;
end;

procedure TdxNavBarNavigationPaneViewInfo.AssignDefaultBackgroundStyle;
begin
  NavBar.DefaultStyles.Background.ResetValues;
  NavBar.DefaultStyles.Background.BackColor := clWindow;
  NavBar.DefaultStyles.Background.BackColor2 := clWindow;
end;

procedure TdxNavBarNavigationPaneViewInfo.AssignDefaultButtonStyle;
begin
  NavBar.DefaultStyles.Button.ResetValues;
  NavBar.DefaultStyles.Button.BackColor := clNone;
  NavBar.DefaultStyles.Button.BackColor2 := clNone;
end;

procedure TdxNavBarNavigationPaneViewInfo.AssignDefaultGroupBackgroundStyle;
begin
  NavBar.DefaultStyles.GroupBackground.ResetValues;
  NavBar.DefaultStyles.GroupBackground.BackColor := clWindow;
  NavBar.DefaultStyles.GroupBackground.BackColor2 := clWindow;
end;

procedure TdxNavBarNavigationPaneViewInfo.AssignDefaultGroupHeaderStyle;
begin
  NavBar.DefaultStyles.GroupHeader.ResetValues;
  NavBar.DefaultStyles.GroupHeader.BackColor := clNone;
  NavBar.DefaultStyles.GroupHeader.BackColor2 := clNone;
  NavBar.DefaultStyles.GroupHeader.Font.Style := [fsBold];
end;

procedure TdxNavBarNavigationPaneViewInfo.AssignDefaultGroupHeaderActiveStyle;
begin
  inherited;
  if IsHighContrastWhite then
    NavBar.DefaultStyles.GroupHeaderActive.Font.Color := clHighlightText;
end;

procedure TdxNavBarNavigationPaneViewInfo.AssignDefaultGroupHeaderHotTrackedStyle;
begin
  inherited;
  if IsHighContrastWhite then
    NavBar.DefaultStyles.GroupHeaderHotTracked.Font.Color := clHighlightText;
end;

procedure TdxNavBarNavigationPaneViewInfo.AssignDefaultGroupHeaderPressedStyle;
begin
  inherited;
  if IsHighContrastWhite then
    NavBar.DefaultStyles.GroupHeaderPressed.Font.Color := clHighlightText;
end;

procedure TdxNavBarNavigationPaneViewInfo.AssignDefaultItemStyle;
begin
  NavBar.DefaultStyles.Item.ResetValues;
  NavBar.DefaultStyles.Item.Font.Color := clWindowText;
  NavBar.DefaultStyles.Item.HAlignment := haCenter;
end;

procedure TdxNavBarNavigationPaneViewInfo.AssignDefaultItemDisabledStyle;
begin
  NavBar.DefaultStyles.ItemDisabled.Assign(NavBar.DefaultStyles.Item);
  NavBar.DefaultStyles.ItemDisabled.Font.Color := clGrayText;
end;

procedure TdxNavBarNavigationPaneViewInfo.AssignDefaultNavigationPaneHeaderStyle;
begin
  NavBar.DefaultStyles.NavigationPaneHeader.ResetValues;
  NavBar.DefaultStyles.NavigationPaneHeader.BackColor := clNone;
  NavBar.DefaultStyles.NavigationPaneHeader.BackColor2 := clNone;
  NavBar.DefaultStyles.NavigationPaneHeader.Font.Color := clNone;
  NavBar.DefaultStyles.NavigationPaneHeader.Font.Name := 'Arial';
  NavBar.DefaultStyles.NavigationPaneHeader.Font.Size := 11;
  NavBar.DefaultStyles.NavigationPaneHeader.Font.Style := [fsBold];
end;

procedure TdxNavBarNavigationPaneViewInfo.CreateColors;
begin
  CreateOffice11NavPaneColors;
end;

procedure TdxNavBarNavigationPaneViewInfo.RefreshColors;
begin
  RefreshOffice11NavPaneColors;
end;

procedure TdxNavBarNavigationPaneViewInfo.ReleaseColors;
begin
  ReleaseOffice11NavPaneColors;
end;

function TdxNavBarNavigationPaneViewInfo.GetGroupEdges: TPoint;
begin
  Result := cxPoint(1, 0);
end;

function TdxNavBarNavigationPaneViewInfo.GetGroupSeparatorWidth: Integer;
begin
  Result := 0;
end;

function TdxNavBarNavigationPaneViewInfo.GetGroupBorderOffsets: TRect;
begin
  Result := inherited GetGroupBorderOffsets;
  if IsTopBorderNeeded then
    Result.Top := Result.Top + BorderWidth;
  if IsBottomBorderNeeded then
    Result.Bottom := Result.Bottom + BorderWidth;  
end;

class function TdxNavBarNavigationPaneViewInfo.GetGroupCaptionImageIndent: Integer;
begin
  Result := 4;
end;

function TdxNavBarNavigationPaneViewInfo.GetGroupCaptionHeightAddon: Integer;
begin
  Result := 4;
end;

function TdxNavBarNavigationPaneViewInfo.GetGroupHeaderTextIndent: Integer;
begin
  Result := GetGroupCaptionTextIndent;
end;

function TdxNavBarNavigationPaneViewInfo.GetHeaderClientOffset: TRect;
begin
  Result := cxNullRect;
end;

function TdxNavBarNavigationPaneViewInfo.GetHeaderSignIndents: TRect;
begin
  Result := Rect(GetGroupCaptionImageIndent, 0, GetGroupCaptionImageIndent, 0);
end;

function TdxNavBarNavigationPaneViewInfo.GetNavBarCollapsedWidth: Integer;
var
  AMaxElementSize: Integer;
begin
  CalculateMaxImageSize;
  with FOverflowPanelViewInfo do
    AMaxElementSize := Max((GetGroupCaptionImageIndent) * 2 + FMaxImageSize.cx,
      GetSignWidth + GetClientOffset.Left + GetClientOffset.Right);
  AMaxElementSize := Max(AMaxElementSize, GetGroupCaptionSignSize.cx +
    GetHeaderClientOffset.Left + GetHeaderClientOffset.Right);
  Result := AMaxElementSize + GetGroupEdges.X * 2;
end;

function TdxNavBarNavigationPaneViewInfo.GetNavBarMinExpandedWidth: Integer;
begin
  Result := GetNavBarCollapsedWidth * 2
end;

function TdxNavBarNavigationPaneViewInfo.GetHeaderHeight: Integer;
begin
  if not IsHeaderVisible then
    Result := 0
  else
  begin
    Result := GetHeaderHeightAddon;
    Inc(Result, Max(cxScreenCanvas.FontHeight(HeaderFont), GetGroupCaptionSignSize.cy));
  end;
end;

function TdxNavBarNavigationPaneViewInfo.GetGripSize: Integer;
begin
  if TdxCustomNavBarAccess(NavBar).IsInternal then
    Result := 15
  else
    Result := 0;
end;

function TdxNavBarNavigationPaneViewInfo.GetSplitterHeight: Integer;
begin
  if not IsSplitterVisible then
    Result := 0
  else
    Result := 7;
end;

function TdxNavBarNavigationPaneViewInfo.CanCollapse: Boolean;
begin
  Result := True;
end;

function TdxNavBarNavigationPaneViewInfo.CanHasGroupViewAsIconView: Boolean;
begin
  Result := False;
end;

function TdxNavBarNavigationPaneViewInfo.CanHasImageInGroupCaption: Boolean;
begin
  Result := True;
end;

function TdxNavBarNavigationPaneViewInfo.CanGroupCaptionBoundsByImage: Boolean;
begin
  Result := True;
end;

function TdxNavBarNavigationPaneViewInfo.IsBottomBorderNeeded: Boolean;
begin
  Result := not IsGroupReflectionNeeded;
end;

function TdxNavBarNavigationPaneViewInfo.IsHeaderVisible: Boolean;
begin
  Result := NavBar.OptionsView.NavigationPane.ShowHeader;
end;

function TdxNavBarNavigationPaneViewInfo.IsSplitterVisible: Boolean;
begin
  Result := FOverflowPanelViewInfo.IsVisible;
end;

function TdxNavBarNavigationPaneViewInfo.IsTopBorderNeeded: Boolean;
begin
  Result := not IsHeaderVisible;
end;

procedure TdxNavBarNavigationPaneViewInfo.DoCreateGroupsInfo;

  procedure CheckFocusedAccessibleObject;
  var
    AFocusedAccessibleObject: IdxNavBarAccessibilityHelper;
  begin
    AFocusedAccessibleObject := TdxCustomNavBarAccess(NavBar).FocusedAccessibleObject;
    if (AFocusedAccessibleObject <> nil) and (NavBar.ActiveGroup <> nil) and
      (AFocusedAccessibleObject.GetHelper = NavBar.ActiveGroup.CaptionPanelIAccessibilityHelper.GetHelper) then
        TdxCustomNavBarAccess(NavBar).FocusedAccessibleObject := ActiveGroupCaptionPanelIAccessibilityHelper;
  end;

var
  I: Integer;
begin
  if IsActiveGroupVisible then
    AddGroup(Self, NavBar.ActiveGroup, False, True);

  if IsGroupReflectionNeeded then
    for I := 0 to NavBar.Groups.Count - 1 do
      if NavBar.Groups[I].Visible then
        AddGroup(Self, NavBar.Groups[I], True, False);
  CheckFocusedAccessibleObject;
end;

procedure TdxNavBarNavigationPaneViewInfo.DoCalculateBounds(X, Y: Integer);
var
  I: Integer;
begin
  FMaxImageSizeCalculated := False;
  CalculateMaxImageSize;
  CalculateHeaderBounds(X, Y);
  FItemPanelViewInfo.CalculateBounds(X, Y);
  CalculateSplitterBounds(X, Y);
  for I := GetRealGroupStartIndex to GroupCount - 1 do
    Groups[I].CalculateBounds(X, Y);
end;

function TdxNavBarNavigationPaneViewInfo.GetItemPanelRect: TRect;
begin
  Result := FItemPanelViewInfo.FRect;
end;

function TdxNavBarNavigationPaneViewInfo.GetBoundsUpdateType: TdxNavBarChangeType;
begin
  Result := doRecreate;
end;

function TdxNavBarNavigationPaneViewInfo.GetActiveGroupCaptionPanelAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass;
begin
  Result := TdxNavBarNavigationPaneActiveGroupCaptionPanelAccessibilityHelper;
end;

function TdxNavBarNavigationPaneViewInfo.GetHeaderSignAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass;
begin
  Result := TdxNavBarNavigationPaneHeaderSignAccessibilityHelper;
end;

function TdxNavBarNavigationPaneViewInfo.GetOverflowPanelViewInfoClass: TdxNavBarOverflowPanelViewInfoClass;
begin
  Result := TdxNavBarOverflowPanelViewInfo;
end;

procedure TdxNavBarNavigationPaneViewInfo.CreateInfo;
var
  AOverflowPanelItemCount: Integer;
begin
  inherited;
  if NavBar.ShowGroupCaptions then
    AOverflowPanelItemCount := NavBar.NavigationPaneOverflowPanelItemCount
  else AOverflowPanelItemCount := 0;
  CreateOverflowPanelInfo(AOverflowPanelItemCount, True);
  CreateItemPanelViewInfo;
end;

procedure TdxNavBarNavigationPaneViewInfo.CreateItemPanelViewInfo;
begin
  FItemPanelViewInfo.ActiveGroupViewInfo := ActiveGroupViewInfo;
  FItemPanelViewInfo.FIsCollapseMode := Painter.Controller.Collapsed;
  FItemPanelViewInfo.FCollapseBarGroup := NavBar.ActiveGroup;
  FItemPanelViewInfo.CreateItems;
end;

procedure TdxNavBarNavigationPaneViewInfo.CreateOverflowPanelInfo(AItemCount: Integer; AClearOld: Boolean);
var
  I: Integer;
  AItem: TdxNavBarOverflowPanelViewInfoItem;
begin
  if AClearOld then
    FOverflowPanelViewInfo.ClearItems;
  if not FOverflowPanelViewInfo.IsVisible then Exit;
  for I := GroupCount - 1 downto GetRealGroupStartIndex do
  begin
    if OverflowPanelItemCount >= AItemCount then
      Break;
    AItem := FOverflowPanelViewInfo.AddItem;
    AItem.Group := Groups[I].Group;
    RemoveGroup(Groups[I]);
  end;
end;

procedure TdxNavBarNavigationPaneViewInfo.CalculateSizeGripBounds;
begin
  FSizeGripRect.Right := ClientWidth;
  FSizeGripRect.Left := FSizeGripRect.Right - GetGripSize;
  FSizeGripRect.Bottom := ClientHeight;
  FSizeGripRect.Top := FSizeGripRect.Bottom - GetGripSize;
end;

procedure TdxNavBarNavigationPaneViewInfo.CalculateHeaderBounds(var X, Y: Integer);
begin
  if IsHeaderVisible then
  begin
    FHeaderRect := Bounds(X, Y, ClientWidth - 2*X , GetHeaderHeight);
    FHeaderTextRect := cxRectContent(FHeaderRect, GetHeaderClientOffset);

    if Painter.Controller.Collapsible then
    begin
      FHeaderSignRect := FHeaderTextRect;
      Dec(FHeaderSignRect.Right, GetHeaderSignIndents.Right);
      FHeaderSignRect.Left := FHeaderSignRect.Right - GetGroupCaptionSignSize.cx;
      FHeaderTextRect.Right := FHeaderSignRect.Left - GetHeaderSignIndents.Left;
      FHeaderSignRect := cxRectCenter(FHeaderSignRect, GetGroupCaptionSignSize);
    end
    else
      FHeaderSignRect := cxNullRect;
    Y := FHeaderRect.Bottom + GetSpaceBetweenGroups;
  end
  else
  begin
    SetRectEmpty(FHeaderTextRect);
    SetRectEmpty(FHeaderSignRect);
  end;
end;

procedure TdxNavBarNavigationPaneViewInfo.CalculateMaxImageSize;

  function GetGroupViewInfo(AList: TList; AIndex: Integer): TdxNavBarGroupViewInfo;
  begin
    Result := TdxNavBarGroupViewInfo(AList[AIndex]);
  end;

var
  I: Integer;
  AList: TObjectList;
begin
  if FMaxImageSizeCalculated then Exit;
  AList := TObjectList.Create;
  try
    FMaxImageSize := Size(FOverflowPanelViewInfo.GetImageWidth, FOverflowPanelViewInfo.GetImageHeight);

    for I := 0 to NavBar.Groups.Count - 1 do
      AList.Add(Painter.CreateGroupViewInfo(Self, NavBar.Groups[I], True, False));

    FImageHeightPeer := AList.Count > 0;
    for I := 0 to AList.Count - 1 do
    begin
      FImageHeightPeer := FImageHeightPeer and (GetGroupViewInfo(AList, 0).GetImageHeight = GetGroupViewInfo(AList, I).GetImageHeight);
      FMaxImageSize.cx := Max(FMaxImageSize.cx, GetGroupViewInfo(AList, I).GetImageWidth);
      FMaxImageSize.cy := Max(FMaxImageSize.cy, GetGroupViewInfo(AList, I).GetImageHeight);
    end;
  finally
    AList.Free;
  end;
  FMaxImageSizeCalculated := True;
end;

procedure TdxNavBarNavigationPaneViewInfo.CalculateSplitterBounds(var X, Y: Integer);
begin
  if not IsSplitterVisible then
    Exit;
 
  FSplitterRect := Bounds(X, Y, ClientWidth - 2*X, GetSplitterHeight);
  Y := FSplitterRect.Bottom + GetSpaceBetweenGroups;
end;

procedure TdxNavBarNavigationPaneViewInfo.ClearRects;
begin
  inherited;
  FOverflowPanelViewInfo.ClearRects;
  SetRectEmpty(FHeaderRect);
  SetRectEmpty(FSizeGripRect);
  SetRectEmpty(FSplitterRect);
end;

procedure TdxNavBarNavigationPaneViewInfo.CorrectBounds;

  procedure CalcHeightDifference(out AShortage, AHeightDifference: Integer);
  var
    AAvailableHeight, ARequiredHeight, AMinHeight: Integer;
  begin
    AAvailableHeight := ClientHeight - FOverflowPanelViewInfo.GetHeight;
    if GetRealGroupCount = 0 then
      Dec(AAvailableHeight, GetSplitterHeight);
    AMinHeight := FItemPanelViewInfo.GetMinHeight;
    if GroupCount > 0 then
      ARequiredHeight := Groups[GroupCount - 1].Rect.Bottom
    else
      ARequiredHeight := HeaderRect.Bottom + AMinHeight;
    AHeightDifference := AAvailableHeight - ARequiredHeight;
    if AHeightDifference < AMinHeight - cxRectHeight(FItemPanelViewInfo.FRect) then // if AHeightDifference < 0
    begin
      AShortage := AMinHeight - cxRectHeight(FItemPanelViewInfo.FRect) - AHeightDifference;
      AHeightDifference := AMinHeight - cxRectHeight(FItemPanelViewInfo.FRect);
    end
    else
      AShortage := 0;
  end;

  procedure CorrectOverflowPanel(AShortage: Integer; var AHeightDifference: Integer);

    procedure CorrectOverflowPanelBounds;
    var
      X, Y: Integer;
    begin
      X := SplitterRect.Left;
      if (GetRealGroupCount = 0) or not NavBar.ShowGroupCaptions then
        Y := SplitterRect.Bottom
      else
        Y := Groups[GroupCount - 1].Rect.Bottom;
      FOverflowPanelViewInfo.CalculateBounds(X, Y);
    end;

    procedure RemoveExcessGroups(var AOverflowPanelGroupCount: Integer);
    var
      I: Integer;
    begin
      for I := GroupCount - 1 downto GetRealGroupStartIndex do
      begin
        if AShortage <= 0 then
          Break;
        Dec(AShortage, cxRectHeight(Groups[I].Rect));
        Inc(AOverflowPanelGroupCount);
      end;
      Inc(AHeightDifference, -AShortage);
    end;

  var
    AGroupCount: Integer;
  begin
    if not FOverflowPanelViewInfo.IsVisible then
      Exit;
    AGroupCount := NavBar.NavigationPaneOverflowPanelItemCount;
    if not NavBar.ShowGroupCaptions then
      AGroupCount := GroupCount - 1
    else
      if AShortage > 0 then
        RemoveExcessGroups(AGroupCount);

    CreateOverflowPanelInfo(AGroupCount, False);
    CorrectOverflowPanelBounds;
  end;

  procedure OffsetElements(AHeightDifference: Integer);
  var
    I: Integer;
  begin

    for I := GetRealGroupStartIndex to GroupCount - 1 do
      Groups[I].CorrectBounds(0, AHeightDifference);

    OffsetRect(FSplitterRect, 0, AHeightDifference);
    FOverflowPanelViewInfo.OffsetElements(AHeightDifference);
  end;

  procedure CorrectBoundsWithActiveGroup;
  var
    AHeightDifference, AShortage: Integer;
  begin
    CalcHeightDifference(AShortage, AHeightDifference);
    CorrectOverflowPanel(AShortage, AHeightDifference);
    FItemPanelViewInfo.CorrectBounds(AHeightDifference);
    OffsetElements(AHeightDifference);
  end;

begin
  CorrectBoundsWithActiveGroup;
  CalculateScrollButtonsBounds;
  CalculateSizeGripBounds;
end;

function TdxNavBarNavigationPaneViewInfo.GetGroupViewInfoAtItemsPos(const pt: TPoint): TdxNavBarGroupViewInfo;
begin
  Result := inherited GetGroupViewInfoAtItemsPos(pt);
  if (Result = ActiveGroupViewInfo) and (NavBar.SourceGroup <> nil) then
    Result := nil;
end;

function TdxNavBarNavigationPaneViewInfo.GetViewInfoAtDragPosition(const pt: TPoint;
  var ItemGroup: TdxNavBarGroupViewInfo; var Item1, Item2: TdxNavBarLinkViewInfo): Integer;
begin
  Result := inherited GetViewInfoAtDragPosition(pt, ItemGroup, Item1, Item2);
  if (ItemGroup <> nil) and (GroupCount > 0) and (ItemGroup <> Groups[0]) and
    (NavBar.ActiveGroup = ItemGroup.Group) then
  begin
    ItemGroup := Groups[0];
    Item1 := nil;
    if ItemGroup.ItemCount > 0 then
      Item2 := ItemGroup.Items[0]
    else Item2 := nil;
    Result := 0;
  end;
end;

function TdxNavBarNavigationPaneViewInfo.IsPtIncNavigationPaneOverflowPanelItemCount(const pt: TPoint): Boolean;
begin
  if GetRealGroupCount > 0 then
    Result := pt.Y > SplitterRect.Top + cxRectHeight(SplitterRect) div 2 + cxRectHeight(Groups[GetRealGroupStartIndex].Rect)
  else
    Result := pt.Y > SplitterRect.Top + cxRectHeight(SplitterRect) div 2 + 20;
end;

function TdxNavBarNavigationPaneViewInfo.IsPtDecNavigationPaneOverflowPanelItemCount(const pt: TPoint): Boolean;
begin
  if GetRealGroupCount > 0 then
    Result := pt.Y < SplitterRect.Top + cxRectHeight(SplitterRect) div 2 - cxRectHeight(Groups[GetRealGroupStartIndex].Rect)
  else
    Result := pt.Y < SplitterRect.Top + cxRectHeight(SplitterRect) div 2 - 20;
end;

function TdxNavBarNavigationPaneViewInfo.IsPtNavigationPaneHeader(const pt: TPoint): Boolean;
begin
  Result := PtInRect(FHeaderRect, pt);
end;

function TdxNavBarNavigationPaneViewInfo.IsPtNavigationPaneHeaderSign(const pt: TPoint): Boolean;
begin
  Result := PtInRect(FHeaderSignRect, pt);
end;

function TdxNavBarNavigationPaneViewInfo.IsPtNavigationPaneOverflowPanel(const pt: TPoint): Boolean;
begin
  Result := PtInRect(OverflowPanelRect, pt);
end;

function TdxNavBarNavigationPaneViewInfo.IsPtNavigationPaneOverflowPanelSign(const pt: TPoint): Boolean;
begin
  Result := PtInRect(OverflowPanelSignRect, pt);
end;

function TdxNavBarNavigationPaneViewInfo.IsPtNavigationPaneSplitter(const pt: TPoint): Boolean;
begin
  Result := PtInRect(FSplitterRect, pt);
end;

function TdxNavBarNavigationPaneViewInfo.IsPtNavigationPaneItemPanel(const pt: TPoint): Boolean;
begin
  Result := PtInRect(FItemPanelViewInfo.FRect, pt);
end;

procedure TdxNavBarNavigationPaneViewInfo.DoShowPopupMenu(const APoint: TPoint);
begin
  DoUpdatePopupMenu;
  PopupMenu.Popup(APoint.X, APoint.Y);
end;

procedure TdxNavBarNavigationPaneViewInfo.DoUpdatePopupMenu;

  function AddItem(AParentItem: TMenuItem; ACaption: string;
    AEnabled: Boolean = True; AOnClick: TNotifyEvent = nil;
    AImageIndex: Integer = -1; AChecked: Boolean = False): TMenuItem;
  begin
    Result := TMenuItem.Create(PopupMenu);
    Result.Caption := ACaption;
    Result.OnDrawItem := DoDrawItem;
    if ACaption <> '-' then
    begin
      Result.OnMeasureItem := DoMeasureItem;
      Result.OnClick := AOnClick;
      Result.Checked := AChecked;
      Result.Enabled := AEnabled;
      Result.ImageIndex := AImageIndex;
    end;
    AParentItem.Add(Result);
  end;

  procedure AssignImage(AImageList: TImageList; ASourceBitmap: TBitmap);
  var
    ABitmap: TBitmap;
    ASideSize: Integer;
    AStretchRect: TRect;
    AMaskColor: TColor;
  begin
    if AImageList.BkColor = clNone then
      AMaskColor := clFuchsia
    else
      AMaskColor := AImageList.BkColor;
    ABitmap := cxCreateBitmap(AImageList.Width, AImageList.Height);
    try
      ASideSize := Min(ABitmap.Width, ABitmap.Height);
      AStretchRect.Left := (ABitmap.Width - ASideSize) div 2;
      AStretchRect.Right := AStretchRect.Left + ASideSize;
      AStretchRect.Top := (ABitmap.Height - ASideSize) div 2;
      AStretchRect.Bottom := AStretchRect.Top + ASideSize;
      ABitmap.Canvas.Brush.Color := AMaskColor;
      ABitmap.Canvas.FillRect(Rect(0, 0, ABitmap.Width, ABitmap.Height));
      ABitmap.Canvas.StretchDraw(AStretchRect, ASourceBitmap);
      AImageList.AddMasked(ABitmap, AMaskColor);
    finally
      ABitmap.Free;
    end;
  end;

  function GetImageIndex(AGroup: TdxNavBarGroup; ADefaultImageIndex: Integer): Integer;
  begin
    if IsImageAssigned(NavBar.SmallImages, AGroup.SmallImageIndex) then
      Result := AGroup.SmallImageIndex
    else
      Result := ADefaultImageIndex;
  end;

  procedure CreateGroupList(AParentMenuItem: TMenuItem; ADefaultImageIndex: Integer);
  var
    I: Integer;
    AItem: TMenuItem;
  begin
    for I := 0 to NavBar.Groups.Count - 1 do
    begin
      if NavBar.Groups[I].VisibleForCustomization then
      begin
        AItem := AddItem(AParentMenuItem, NavBar.Groups[I].Caption, True, DoAddRemoveButtonsClick,
          GetImageIndex(NavBar.Groups[I], ADefaultImageIndex), NavBar.Groups[I].Visible);
      {$IFDEF DELPHI6}
        AItem.AutoCheck := True;
      {$ENDIF};
        AItem.Tag := I;
      end;
    end;
  end;

  procedure CreateHiddenGroupList(AParentMenuItem: TMenuItem; ADefaultImageIndex: Integer);
  var
    I: Integer;
  begin
    AddItem(AParentMenuItem, '-');
    for I := OverflowPanelVisibleItemCount to OverflowPanelItemCount - 1 do
      AddItem(AParentMenuItem, OverflowPanelItems[I].Group.Caption, True, DoHiddenGroupClick,
        GetImageIndex(OverflowPanelItems[I].Group, ADefaultImageIndex),
        NavBar.ActiveGroup = OverflowPanelItems[I].Group).Tag := Integer(OverflowPanelItems[I].Group);
  end;

var
  AImageCount: Integer;
  AParentMenuItem: TMenuItem;
begin
  RecreateImageList;

  if NavBar.SmallImages <> nil then
  begin
    ImageList.Width := NavBar.SmallImages.Width;
    ImageList.Height := NavBar.SmallImages.Height;
  end;

  AImageCount := GetSmallImagesCount;
  AssignImage(ImageList, dxOffice11NavPaneArrowUpBitmap);
  AssignImage(ImageList, dxOffice11NavPaneArrowDownBitmap);
  AssignImage(ImageList, dxOffice11NavPaneDefaultSmallBitmap);

  PopupMenu.Items.Clear;
  PopupMenu.Images := ImageList;

  AddItem(PopupMenu.Items, cxGetResourceString(@sdxNavBarOffice11ShowMoreButtons),
    NavBar.CanDecNavigationPaneOverflowPanelItemCount, DoMoreButtonsClick, AImageCount);
  AddItem(PopupMenu.Items, cxGetResourceString(@sdxNavBarOffice11ShowFewerButtons),
    NavBar.CanIncNavigationPaneOverflowPanelItemCount, DoFewerButtonsClick, AImageCount + 1);
  if NavBar.OptionsBehavior.NavigationPane.AllowCustomizing then
  begin
    AParentMenuItem := AddItem(PopupMenu.Items,
      cxGetResourceString(@sdxNavBarOffice11AddRemoveButtons), NavBar.Groups.Count > 0);
    CreateGroupList(AParentMenuItem, AImageCount + 2);
  end;
  CreateHiddenGroupList(PopupMenu.Items, AImageCount + 2);
end;

function TdxNavBarNavigationPaneViewInfo.IsDefaultHeaderColor: Boolean;
begin
  Result := (inherited HeaderBackColor = clNone) or (inherited HeaderBackColor2 = clNone);
end;

function TdxNavBarNavigationPaneViewInfo.IsDefaultOverflowPanelColor: Boolean;
begin
  Result := (inherited OverflowPanelBackColor = clNone) or (inherited OverflowPanelBackColor2 = clNone);
end;

function TdxNavBarNavigationPaneViewInfo.IsDefaultBottomScrollButtonColor: Boolean;
begin
  Result := (inherited BottomScrollButtonBackColor = clNone) or (inherited BottomScrollButtonBackColor2 = clNone);
end;

function TdxNavBarNavigationPaneViewInfo.IsDefaultTopScrollButtonColor: Boolean;
begin
  Result := (inherited TopScrollButtonBackColor = clNone) or (inherited TopScrollButtonBackColor2 = clNone);
end;

procedure TdxNavBarNavigationPaneViewInfo.RecreateImageList;
begin
  FImageList.Free;
  FImageList := TImageList.Create(NavBar);
end;

function TdxNavBarNavigationPaneViewInfo.GetPainter: TdxNavBarNavigationPanePainter;
begin
  Result := TdxNavBarNavigationPanePainter(inherited Painter);
end;

function TdxNavBarNavigationPaneViewInfo.GetActiveGroupCaptionPanelIAccessibilityHelper: IdxNavBarAccessibilityHelper;
begin
  if FActiveGroupCaptionPanelIAccessibilityHelper = nil then
    FActiveGroupCaptionPanelIAccessibilityHelper := NavBarGetAccessibilityHelper(
      GetActiveGroupCaptionPanelAccessibilityHelperClass.Create(Self, NavBar));
  Result := FActiveGroupCaptionPanelIAccessibilityHelper;
end;

function TdxNavBarNavigationPaneViewInfo.GetHeaderSignIAccessibilityHelper: IdxNavBarAccessibilityHelper;
begin
  if FHeaderSignIAccessibilityHelper = nil then
    FHeaderSignIAccessibilityHelper := NavBarGetAccessibilityHelper(
      GetHeaderSignAccessibilityHelperClass.Create(Self, NavBar));
  Result := FHeaderSignIAccessibilityHelper;
end;

function TdxNavBarNavigationPaneViewInfo.GetNavPanePartIAccessibilityHelper(
  const APart: TdxNavBarPart): IdxNavBarAccessibilityHelper;
begin
  case APart.MajorPartIndex of
    nbOverflowPanelItem: Result := GetOverflowPanelItemIAccessibilityHelper(APart.MinorPartIndex);
    nbOverflowPanelSign: Result := OverflowPanelSignIAccessibilityHelper;
    nbHeaderSign: Result := HeaderSignIAccessibilityHelper;

    nbItemPanelCollapseItem: Result :=  FItemPanelViewInfo.ItemIAccessibilityHelpers[APart.MinorPartIndex];
    nbItemPanelCollapseBar: Result := FItemPanelViewInfo.CollapseBarIAccessibilityHelper;
  end;
end;

function TdxNavBarNavigationPaneViewInfo.GetOverflowPanelIAccessibilityHelper: IdxNavBarAccessibilityHelper;
begin
  Result := FOverflowPanelViewInfo.GetIAccessibilityHelper;
end;

procedure TdxNavBarNavigationPaneViewInfo.DoMoreButtonsClick(Sender: TObject);
begin
  NavBar.DoDecNavigationPaneOverflowPanelItemCount;
end;

procedure TdxNavBarNavigationPaneViewInfo.DoFewerButtonsClick(Sender: TObject);
begin
  NavBar.DoIncNavigationPaneOverflowPanelItemCount;
end;

procedure TdxNavBarNavigationPaneViewInfo.DoAddRemoveButtonsClick(Sender: TObject);
var
  AMenuItem: TMenuItem;
  AGroup: TdxNavBarGroup;
begin
  AMenuItem := Sender as TMenuItem;
{$IFNDEF DELPHI6}
  AMenuItem.Checked := not AMenuItem.Checked;
{$ENDIF}
  AGroup := NavBar.Groups[AMenuItem.Tag];
  AGroup.Visible := AMenuItem.Checked;
end;

procedure TdxNavBarNavigationPaneViewInfo.DoHiddenGroupClick(Sender: TObject);
begin
  NavBar.ActiveGroup := TdxNavBarGroup(TMenuItem(Sender).Tag);
end;

procedure TdxNavBarNavigationPaneViewInfo.DoDrawItem(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
var
  AMenuItem: TMenuItem;
  AState: TdxNavBarObjectStates;
  AImageList: TCustomImageList;
  AImageIndex: Integer;
begin
  AMenuItem := Sender as TMenuItem;
  AState := [];
  if Selected then
    Include(AState, sSelected);
  if AMenuItem.Checked then
    Include(AState, sActive);
  if not AMenuItem.Enabled then
    Include(AState, sDisabled);

  AImageIndex := AMenuItem.ImageIndex;
  if IsImageAssigned(NavBar.SmallImages, AImageIndex) then
    AImageList := NavBar.SmallImages
  else
  begin
    AImageList := ImageList;
    Dec(AImageIndex, GetSmallImagesCount);
  end;
  (Painter as TdxNavBarNavigationPanePainter).DrawPopupMenuItem(ACanvas, ARect,
    AImageList, AImageIndex, AMenuItem.Caption, AState);
end;

procedure TdxNavBarNavigationPaneViewInfo.DoMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
begin
  Height := 2 * FOverflowPanelViewInfo.GetPopupMenuImageIndent + GetSmallImageHeight;
end;

function TdxNavBarNavigationPaneViewInfo.GetOverflowPanelItemCount: Integer;
begin
  Result := FOverflowPanelViewInfo.ItemCount;
end;

function TdxNavBarNavigationPaneViewInfo.GetOverflowPanelItems(AIndex: Integer): TdxNavBarOverflowPanelViewInfoItem;
begin
  Result := FOverflowPanelViewInfo.Items[AIndex];
end;

function TdxNavBarNavigationPaneViewInfo.GetOverflowPanelVisibleItemCount: Integer;
begin
  Result := FOverflowPanelViewInfo.FVisibleItemCount;
end;

function TdxNavBarNavigationPaneViewInfo.GetOverflowPanelRect: TRect;
begin
  Result := FOverflowPanelViewInfo.FRect;
end;

function TdxNavBarNavigationPaneViewInfo.GetOverflowPanelSignRect: TRect;
begin
  Result := FOverflowPanelViewInfo.FSignRect;
end;

function TdxNavBarNavigationPaneViewInfo.GetOverflowPanelSignIAccessibilityHelper: IdxNavBarAccessibilityHelper;
begin
  Result := (OverflowPanelIAccessibilityHelper.GetHelper as TdxNavBarNavigationPaneOverflowPanelAccessibilityHelper).SignIAccessibilityHelper;
end;

function TdxNavBarNavigationPaneViewInfo.GetOverflowPanelItemIAccessibilityHelper(AIndex: Integer): IdxNavBarAccessibilityHelper;
begin
  Result := (OverflowPanelIAccessibilityHelper.GetHelper as TdxNavBarNavigationPaneOverflowPanelAccessibilityHelper).ItemIAccessibilityHelpers[AIndex]
end;

function TdxNavBarNavigationPaneViewInfo.IsActiveGroupVisible: Boolean;
begin
  Result := not Painter.Controller.Collapsed and (NavBar.ActiveGroup <> nil) and NavBar.ActiveGroup.Visible;
end;

function TdxNavBarNavigationPaneViewInfo.IsGroupReflectionNeeded: Boolean;
begin
  Result := FOverflowPanelViewInfo.IsVisible or
    NavBar.OptionsView.Common.ShowGroupCaptions;
end;

function TdxNavBarNavigationPaneViewInfo.GetRealGroupStartIndex: Integer;
begin
  if IsActiveGroupVisible then
    Result := 1
  else
    Result := 0;
end;

function TdxNavBarNavigationPaneViewInfo.GetRealGroupCount: Integer;
begin
  Result := GroupCount - GetRealGroupStartIndex;
end;

function TdxNavBarNavigationPaneViewInfo.GetSmallImagesCount: Integer;
begin
  if NavBar.SmallImages <> nil then
    Result := NavBar.SmallImages.Count
  else
    Result := 0;
end;

{ TdxNavBarPopupControlViewInfo }

procedure TdxNavBarPopupControlViewInfo.CalculateBounds(AClientWidth: Integer);
var
  X, Y: Integer;
  AActiveGroupViewInfo: TdxNavBarGroupViewInfo;
begin
  AActiveGroupViewInfo := TdxNavBarGroupViewInfo.Create(ViewInfo, NavBar.ActiveGroup, False, True);
  try
    X := 0;
    Y := 0;
    AActiveGroupViewInfo.CalculateBounds(X, Y);
    FRect := cxRectSetHeight(AActiveGroupViewInfo.Rect,
      cxRectHeight(AActiveGroupViewInfo.Rect) + GetBorderOffsets.Top + GetBorderOffsets.Bottom);
    FRect := cxRectSetWidth(FRect,
      AClientWidth + GetBorderOffsets.Left + GetBorderOffsets.Right);
    if (AActiveGroupViewInfo.Control <> nil) or (cxRectHeight(FRect) > GetMaxHeight) then
      FRect := cxRectSetHeight(FRect, GetMaxHeight);
  finally
    FreeAndNil(AActiveGroupViewInfo);
  end;
end;

function TdxNavBarPopupControlViewInfo.CalculatePosition: TPoint;
begin
  Result := NavBar.ClientToScreen(cxPoint(NavBar.Width - ViewInfo.BorderWidth,
    cxRectHeight(ViewInfo.HeaderRect) - 1));
end;

function TdxNavBarPopupControlViewInfo.GetBorderOffsets: TRect;
begin
  Result := cxRect(2, 2, 2, 2);
end;

function TdxNavBarPopupControlViewInfo.GetMaxHeight: Integer;
begin
  Result := NavBar.ClientHeight - ViewInfo.GetHeaderHeight * 2;
end;

function TdxNavBarPopupControlViewInfo.GetMinWidth: Integer;
begin
  Result := ViewInfo.GetNavBarMinExpandedWidth + GetBorderOffsets.Left + GetBorderOffsets.Right;
end;

function TdxNavBarPopupControlViewInfo.IsPtSizeGrip(const pt: TPoint): Boolean;
begin
  Result := (pt.X >= cxRectWidth(FRect) - GetBorderOffsets.Right);
end;

function TdxNavBarPopupControlViewInfo.GetClientRect: TRect;
begin
  Result := cxRectContent(FRect, GetBorderOffsets);
end;

type
  TdxNavBarPopupInnerControl = class(TdxCustomNavBar)
  private
    FNavBar: TdxCustomNavBar;
    procedure AcceptActiveGroupControl(ASource, ADestination: TdxCustomNavBar);
    procedure AssignGroupProperties(ASource, ADestination: TdxCustomNavBar);
    procedure CloneActiveGroupLinks(ASource, ADestination: TdxCustomNavBar);
    procedure SynchronizeActiveGroupLinks;
  protected
    procedure UpdateData;
    procedure UpdateOriginalData;
    function IsInternal: Boolean; override;
  public
    constructor Create(APopupControl: TdxNavBarPopupControl); reintroduce; virtual;
    function GetLinkAtPos(const pt: TPoint): TdxNavBarItemLink; override;
  end;

  TdxNavBarPopupInnerControlControllerState = (icsOverSizeGrip);
  TdxNavBarPopupInnerControlControllerStates = set of TdxNavBarPopupInnerControlControllerState;

  TdxNavBarPopupInnerControlController = class(TdxNavBarNavigationPaneController)
  private
    FInternalState: TdxNavBarPopupInnerControlControllerStates;
    function GetNavBar: TdxNavBarPopupInnerControl;
    function GetMouseOverSizeGrip: Boolean;
    function GetViewInfo: TdxNavBarOffice11NavPaneViewInfo;
    procedure SetMouseOverSizeGrip(AValue: Boolean);
    property MouseOverSizeGrip: Boolean read GetMouseOverSizeGrip write SetMouseOverSizeGrip;
  protected
    procedure DoLinkClick(ANavBar: TdxCustomNavBar; ALink: TdxNavBarItemLink); override;
    procedure DoMouseDown(AButton: TMouseButton; AShift: TShiftState; const APoint: TPoint); override;
    procedure DoMouseMove(AShift: TShiftState; const APoint: TPoint); override;
    function GetCursor: HIcon; override;

    property NavBar: TdxNavBarPopupInnerControl read GetNavBar;
    property ViewInfo: TdxNavBarOffice11NavPaneViewInfo read GetViewInfo;
  end;

{ TdxNavBarPopupInnerControl }

constructor TdxNavBarPopupInnerControl.Create(APopupControl: TdxNavBarPopupControl);
begin
  inherited Create(APopupControl);
  FNavBar := APopupControl.FNavBar;
  OptionsView.NavigationPane.ShowHeader := False;
  OptionsView.NavigationPane.ShowOverflowPanel := False;
end;

function TdxNavBarPopupInnerControl.GetLinkAtPos(const pt: TPoint): TdxNavBarItemLink;
begin
  Result := inherited GetLinkAtPos(ScreenToClient(FNavBar.ClientToScreen(pt)));
  if Result <> nil then
    Result := TdxNavBarItemLink(Result.Data);
end;

procedure TdxNavBarPopupInnerControl.UpdateData;
begin
  View := FNavBar.View;
  ViewStyle.Assign(FNavBar.ViewStyle);
  AllowSelectLinks := FNavBar.AllowSelectLinks;
  OptionsStyle := FNavBar.OptionsStyle;
  OptionsImage := FNavBar.OptionsImage;
  BeginUpdate;
  try
    Items.Assign(FNavBar.Items);
    ActiveGroup.ClearLinks;
    CloneActiveGroupLinks(FNavBar, Self);
    AssignGroupProperties(FNavBar, Self);
  finally
    EndUpdate;
  end;
  Font := FNavBar.Font;
  TabStop := FNavBar.TabStop and not (Groups[0].UseControl and Groups[0].ShowControl);
end;

procedure TdxNavBarPopupInnerControl.UpdateOriginalData;
begin
  FNavBar.BeginUpdate;
  try
    SynchronizeActiveGroupLinks;
    AssignGroupProperties(Self, FNavBar);
  finally
    FNavBar.EndUpdate;
  end;
end;

function TdxNavBarPopupInnerControl.IsInternal: Boolean;
begin
  Result := True;
end;

procedure TdxNavBarPopupInnerControl.AcceptActiveGroupControl(ASource, ADestination: TdxCustomNavBar);

  procedure AllocateHandles(AControl: TWinControl);
  var
    I: Integer;
  begin
    AControl.HandleNeeded;
    for I := 0 to AControl.ControlCount - 1 do
      if AControl.Controls[I] is TWinControl then
        AllocateHandles(TWinControl(AControl.Controls[I]));
  end;

var
  AControl: TdxNavBarGroupControl;
  ASourceGroup, ADestinationGroup: TdxNavBarGroup;
begin
  ASourceGroup := ASource.ActiveGroup;
  ADestinationGroup := ADestination.ActiveGroup;
  AControl := ASourceGroup.Control;
  AControl.Group := ADestinationGroup;
  AControl.Visible := False;
  AControl.Parent := ADestination;
  ADestinationGroup.AcceptControl(AControl);
  ADestinationGroup.UseControl := True;
  ADestinationGroup.ShowControl := ASourceGroup.ShowControl;
  if ASource = Self then
  begin
    ASourceGroup.ReleaseControl;
    AControl.Group := ADestinationGroup;
    ASourceGroup.UseControl := False;
    AllocateHandles(AControl);
  end;
end;

procedure TdxNavBarPopupInnerControl.AssignGroupProperties(ASource, ADestination: TdxCustomNavBar);
var
  ASourceGroup, ADestinationGroup: TdxNavBarGroup;
begin
  ASourceGroup := ASource.ActiveGroup;
  ADestinationGroup := ADestination.ActiveGroup;
  if ASourceGroup = FNavBar.ActiveGroup then
  begin
    ADestinationGroup.CustomStyles := ASourceGroup.CustomStyles;
    ADestinationGroup.LinksUseSmallImages := ASourceGroup.LinksUseSmallImages;
    ADestinationGroup.ShowAsIconView := ASourceGroup.ShowAsIconView;
  end;
  if ASourceGroup.UseControl then
    AcceptActiveGroupControl(ASource, ADestination);
  ADestinationGroup.SelectedLinkIndex := ASourceGroup.SelectedLinkIndex;
  ADestinationGroup.OnSelectedLinkChanged := ASourceGroup.OnSelectedLinkChanged;
  ADestinationGroup.OnTopVisibleLinkChanged := ASourceGroup.OnTopVisibleLinkChanged;
  ASourceGroup.OnSelectedLinkChanged := nil;
  ASourceGroup.OnTopVisibleLinkChanged := nil;
end;

procedure TdxNavBarPopupInnerControl.CloneActiveGroupLinks(ASource, ADestination: TdxCustomNavBar);
var
  I: Integer;
  ASourceLink, ADestinationLink: TdxNavBarItemLink;
begin
  for I := 0 to ASource.ActiveGroup.LinkCount - 1 do
  begin
    ASourceLink := ASource.ActiveGroup.Links[I];
    ADestinationLink := ADestination.ActiveGroup.CreateLink(ADestination.Items[ASourceLink.Item.Index]);
    if ASource = FNavBar then
      ADestinationLink.Data := Integer(ASourceLink);
  end;
end;

procedure TdxNavBarPopupInnerControl.SynchronizeActiveGroupLinks;
var
  I: Integer;
  ASourceLink, ADestinationLink: TdxNavBarItemLink;
  ASourceGroup, ADestinationGroup: TdxNavBarGroup;
begin
  ASourceGroup := ActiveGroup;
  ADestinationGroup := FNavBar.ActiveGroup;
  for I := 0 to ASourceGroup.LinkCount - 1 do
  begin
    ASourceLink := ASourceGroup.Links[I];
    ADestinationLink := TdxNavBarItemLink(ASourceGroup.Links[I].Data);
    if ADestinationLink = nil then
      ASourceLink.Data := Integer(ADestinationGroup.CreateLink(Items[ASourceLink.Item.Index]));
  end;
  for I := 0 to ASourceGroup.LinkCount - 1 do
  begin
    ASourceLink := ASourceGroup.Links[I];
    ADestinationLink := TdxNavBarItemLink(ASourceGroup.Links[I].Data);
    ADestinationLink.Index := ASourceLink.Index;
  end;
  for I := ADestinationGroup.LinkCount - 1 downto ASourceGroup.LinkCount do
    ADestinationGroup.RemoveLink(I);
end;

{ TdxNavBarPopupInnerControlController }

procedure TdxNavBarPopupInnerControlController.DoLinkClick(ANavBar: TdxCustomNavBar; ALink: TdxNavBarItemLink);
begin
  ALink.Selected := NavBar.AllowSelectLinks;
  ALink := TdxNavBarItemLink(ALink.Data);
  ANavBar := NavBar.FNavBar;
  TdxNavBarNavigationPaneController(ANavBar.Painter.Controller).ClosePopupControl;
  inherited;
end;

procedure TdxNavBarPopupInnerControlController.DoMouseDown(AButton: TMouseButton; AShift: TShiftState; const APoint: TPoint);
begin
  if MouseOverSizeGrip then
    TdxNavBarPopupControl(NavBar.Parent).BeginResize(NavBar, AButton, AShift, APoint)
  else
    inherited;
end;

procedure TdxNavBarPopupInnerControlController.DoMouseMove(AShift: TShiftState; const APoint: TPoint);
begin
  MouseOverSizeGrip := not (NavBar.IsPtBottomScrollButton(APoint) or NavBar.IsPtTopScrollButton(APoint)) and
    cxRectPtIn(ViewInfo.SizeGripRect, APoint);
  if not MouseOverSizeGrip then
    inherited;
end;

function TdxNavBarPopupInnerControlController.GetCursor: HIcon;
begin
  if MouseOverSizeGrip then
    Result := Screen.Cursors[crSizeWE]
  else
    Result := inherited GetCursor;
end;

function TdxNavBarPopupInnerControlController.GetNavBar: TdxNavBarPopupInnerControl;
begin
  Result := TdxNavBarPopupInnerControl(FNavBar);
end;

function TdxNavBarPopupInnerControlController.GetMouseOverSizeGrip: Boolean;
begin
  Result := icsOverSizeGrip in FInternalState;
end;

function TdxNavBarPopupInnerControlController.GetViewInfo: TdxNavBarOffice11NavPaneViewInfo;
begin
  Result := TdxNavBarOffice11NavPaneViewInfo(inherited ViewInfo);
end;

procedure TdxNavBarPopupInnerControlController.SetMouseOverSizeGrip(AValue: Boolean);
begin
  if MouseOverSizeGrip <> AValue then
    if AValue then
      Include(FInternalState, icsOverSizeGrip)
    else
      Exclude(FInternalState, icsOverSizeGrip);
end;

{ TdxNavBarPopupControl }

constructor TdxNavBarPopupControl.Create(ANavBar: TdxCustomNavBar);
begin
  inherited Create(ANavBar);
  CaptureFocus := True;
  FNavBar := ANavBar;
  FOriginalWidth := Painter.Controller.OriginalWidth;
end;

destructor TdxNavBarPopupControl.Destroy;
begin
  FreeAndNil(FInnerControl);
  inherited;
end;

procedure TdxNavBarPopupControl.CloseUp;
begin
  TdxNavBarPopupInnerControl(FInnerControl).UpdateOriginalData;
  if pcsSizing in FInternalState then
    EndResize(True);
  FreeAndNil(FViewInfo);
  ActiveControl := nil;
  inherited;
end;

procedure TdxNavBarPopupControl.Popup(AFocusedControl: TWinControl);
begin
  CreateViewInfo;
  inherited;
end;

function TdxNavBarPopupControl.NeedAdjustWidth: Boolean;
begin
  Result := FNavBar.OptionsBehavior.NavigationPane.AdjustWidthByPopup;
end;

function TdxNavBarPopupControl.CalculatePosition: TPoint;
begin
  Result := FViewInfo.CalculatePosition;
end;

procedure TdxNavBarPopupControl.CalculateSize;
begin
  FViewInfo.CalculateBounds(FOriginalWidth);
  Width := cxRectWidth(FViewInfo.FRect);
  Height := cxRectHeight(FViewInfo.FRect);
  FInnerControl.Width := cxRectWidth(FViewInfo.ClientRect);
  FInnerControl.Height := cxRectHeight(FViewInfo.ClientRect);
end;

procedure TdxNavBarPopupControl.BeginResize(AControl: TControl; AButton: TMouseButton; AShift: TShiftState; const APoint: TPoint);
var
  ARealPoint: TPoint;
begin
  SetCaptureControl(Self);
  if AControl <> Self then
    ARealPoint := dxNavBarCollns.ClientToParent(AControl, APoint, Self)
  else
    ARealPoint := APoint;
  FCapturePointOffset := Width - ARealPoint.X;
  Include(FInternalState, pcsSizing);
  DrawSizeFrame(BoundsRect);
end;

procedure TdxNavBarPopupControl.EndResize(ACancel: Boolean = False);
begin
  SetCaptureControl(nil);
  Exclude(FInternalState, pcsSizing);
  if not ACancel then
    SetNewWidth(cxRectWidth(FSizeFrame.BoundsRect));
  DrawSizeFrame(cxEmptyRect);
end;

procedure TdxNavBarPopupControl.DoShowed;
begin
  inherited DoShowed;
  if FInnerControl.Groups[0].UseControl and FInnerControl.Groups[0].ShowControl then
  begin
    TdxNavBarPainterAccess(FInnerControl.Painter).CheckDrawParamChanges;
    ActiveControl := FindNextControl(nil, True, True, False);
  end;
end;

procedure TdxNavBarPopupControl.DrawSizeFrame(const R: TRect);
var
  ABorderWidth: Integer;
begin
  if not IsRectEmpty(R) then
  begin
    ABorderWidth := 1;
    if FSizeFrame = nil then
      FSizeFrame := TcxSizeFrame.Create(ABorderWidth);
    FSizeFrame.Show;
    FSizeFrame.DrawSizeFrame(R);
  end
  else
    FreeAndNil(FSizeFrame);
end;

procedure TdxNavBarPopupControl.InitPopup;
begin
  if FInnerControl = nil then
  begin
    FInnerControl := TdxNavBarPopupInnerControl.Create(Self);
    FInnerControl.Parent := Self;
    FInnerControl.Groups.Add;                             /////-> InnerControl
    FInnerControl.ShowGroupCaptions := False;             /////-> InnerControl
  end;
  FInnerControl.Left := ViewInfo.GetBorderOffsets.Left;
  FInnerControl.Top := ViewInfo.GetBorderOffsets.Top;
  TdxNavBarPopupInnerControl(FInnerControl).UpdateData;
  if NeedAdjustWidth then
    FOriginalWidth := Painter.Controller.OriginalWidth;
end;

procedure TdxNavBarPopupControl.Paint;
begin
  FViewInfo.Painter.DrawPopupControl(Canvas, FViewInfo);
end;

procedure TdxNavBarPopupControl.RefreshPopupWindow;
begin
  CalculateSize;
  Refresh;
end;

procedure TdxNavBarPopupControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //inherited;
  if (GetCaptureControl <> nil) and ViewInfo.IsPtSizeGrip(cxPoint(X, Y)) then
    BeginResize(Self, Button, Shift, cxPoint(X, Y));
end;

procedure TdxNavBarPopupControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if pcsSizing in FInternalState then
    EndResize;
end;

procedure TdxNavBarPopupControl.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
 // inherited;
  if not (pcsSizing in FInternalState) then
    MouseOverSizeGrip := ViewInfo.IsPtSizeGrip(Point(X, Y))
  else
    if X + FCapturePointOffset > ViewInfo.GetMinWidth then
      DrawSizeFrame(cxRectSetWidth(BoundsRect, X + FCapturePointOffset));
end;

function TdxNavBarPopupControl.NeedIgnoreMouseMessageAfterCloseUp(AWnd: THandle; AMsg: Cardinal;
  AShift: TShiftState; const APos: TPoint): Boolean;
begin
  Result := True;
end;

procedure TdxNavBarPopupControl.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    if pcsSizing in FInternalState then
      EndResize(True)
    else
      CloseUp
  else
    inherited;
end;

procedure TdxNavBarPopupControl.CreateViewInfo;
begin
  FViewInfo := Painter.CreatePopupControlViewInfo;
end;

function TdxNavBarPopupControl.GetPainter: TdxNavBarNavigationPanePainter;
begin
  Result := TdxNavBarNavigationPanePainter(FNavBar.Painter);
end;

procedure TdxNavBarPopupControl.SetNewWidth(AWidth: Integer);
begin
  FOriginalWidth := FOriginalWidth + AWidth - Width;
  if NeedAdjustWidth then
    Painter.Controller.OriginalWidth := FOriginalWidth;
  RefreshPopupWindow;
end;

function TdxNavBarPopupControl.GetMouseOverSizeGrip: Boolean;
begin
  Result := pcsOverSizeGrip in FInternalState;
end;

procedure TdxNavBarPopupControl.SetMouseOverSizeGrip(AValue: Boolean);
begin
  if MouseOverSizeGrip <> AValue then
    if AValue then
    begin
      Include(FInternalState, pcsOverSizeGrip);
      Cursor := crSizeWE;
    end
    else
    begin
      Exclude(FInternalState, pcsOverSizeGrip);
      Cursor := crDefault;
    end;
end;

{ TdxNavBarNavigationPaneController }

constructor TdxNavBarNavigationPaneController.Create(ANavBar: TdxCustomNavBar);
begin
  inherited;
  TdxCustomNavBarAccess(ANavBar).OnCollapseStateChanged := CollapseStateChaged;
  FDroppedDownPart := dxNavBarPart(nbNone);
end;

destructor TdxNavBarNavigationPaneController.Destroy;
begin
  TdxCustomNavBarAccess(FNavBar).OnCollapseStateChanged := nil;
  FreeAndNil(FPopupControl);
  inherited;
end;

procedure TdxNavBarNavigationPaneController.ClosePopupControl;
begin
  if IsPopupControlVisible then
    PopupControl.CloseUp;
end;

procedure TdxNavBarNavigationPaneController.ShowPopupControl;

  procedure InternalShowPopup;
  begin
    if FNavBar.ActiveGroup <> nil then
    begin
      if not IsPopupControlExists then
        FPopupControl := TdxNavBarPopupControl.Create(FNavBar);
      FPopupControl.OwnerBounds := FNavBar.BoundsRect;
      FPopupControl.OwnerParent := FNavBar.Parent;
      FPopupControl.Popup(nil);
    end;
  end;

var
  ALinkSelf: TcxObjectLink;
begin
  if not IsPopupControlVisible then
  begin
    DroppedDownPart := dxNavBarPart(nbItemPanelCollapseBar);
    ALinkSelf := cxAddObjectLink(Self);
    try
      InternalShowPopup;
      if ALinkSelf.Ref <> nil then
        DroppedDownPart := dxNavBarPart(nbNone);
    finally
      cxRemoveObjectLink(ALinkSelf);
    end;    
  end;
end;

procedure TdxNavBarNavigationPaneController.DoClick(const APart: TdxNavBarPart);
begin
  case HotPart.MajorPartIndex of
    nbOverflowPanelItem: DoOverflowPanelItemClick;
    nbOverflowPanelSign: DoOverflowPanelSignClick;
    nbHeaderSign:
      begin
        DoHeaderSignClick;
        HotPart := dxNavBarPart(nbNone);
      end;
    nbItemPanelCollapseBar: DoCollapseBarClick;
    nbItemPanelCollapseItem: DoCollapseItemClick;
  else
    inherited;
  end;
end;

procedure TdxNavBarNavigationPaneController.DoCheckBounds(var ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  if AWidth <> FNavBar.Width then
    if Collapsed then
      if AWidth >= ViewInfo.GetNavBarMinExpandedWidth then
      begin
        OriginalWidth := AWidth;
        ChangeNavBarCollapseState;
      end
      else
        AWidth := ViewInfo.GetNavBarCollapsedWidth
    else
      if AWidth < ViewInfo.GetNavBarMinExpandedWidth then
        ChangeNavBarCollapseState;
end;

procedure TdxNavBarNavigationPaneController.DoMouseDown(AButton: TMouseButton; AShift: TShiftState; const APoint: TPoint);

  function IsPressedPartDetermined: Boolean;
  begin
    Result := ssLeft in AShift;
    if Result then
    begin
      PressedPart := GetPartAtPos(APoint);
      Result := not IsdxNavBarPartsEqual(PressedPart, dxNavBarPart(nbNone));
    end;
  end;

begin
  if not IsPopupJustClosed and not IsPressedPartDetermined then
    inherited;
end;

procedure TdxNavBarNavigationPaneController.DoMouseMove(AShift: TShiftState; const APoint: TPoint);
begin
  HotPart := GetPartAtPos(APoint);
  if PressedPart.MajorPartIndex = nbSplitter then
    DoSplitterDrag(APoint)
  else
    inherited;
end;

procedure TdxNavBarNavigationPaneController.DoMouseLeave;
begin
  HotPart := dxNavBarPart(nbNone);
  inherited;
end;

procedure TdxNavBarNavigationPaneController.DoSetHotPart(const APart: TdxNavBarPart);
begin
  InvalidateAll(doRedraw);
end;

procedure TdxNavBarNavigationPaneController.DoSetPressedPart(const APart: TdxNavBarPart);
begin
  InvalidateAll(doRedraw);
end;

procedure TdxNavBarNavigationPaneController.DoShowHint(var AHintInfo: THintInfo);
begin
  if IsAnyItemHotTracked then
  begin
    if NavBar.ShowNavigationPaneOverflowPanelHints then
      DoShowOverflowPanelHint(AHintInfo);
  end
  else
    inherited;
end;

procedure TdxNavBarNavigationPaneController.DoShowOverflowPanelHint(var AHintInfo: THintInfo);
begin
  ViewInfo.HintText := GetNavPaneItemHintText;
  ViewInfo.HintRect := GetNavPaneItemHintRect(AHintInfo.CursorPos);
  AHintInfo.CursorRect := GetNavPaneItemHintCursorRect;
end;

function TdxNavBarNavigationPaneController.GetNavPaneItemHintRect(const ACursorPos: TPoint): TRect;
var
  ANavBarItem: TObject;
begin
  case HotPart.MajorPartIndex of
    nbOverflowPanelItem: ANavBarItem := ViewInfo.OverflowPanelItems[HotPart.MinorPartIndex].Group;
    nbItemPanelCollapseItem: ANavBarItem := ViewInfo.ItemPanelViewInfo.Items[HotPart.MinorPartIndex].ItemLink.Item;
  else
    ANavBarItem := nil;
  end;
  Result := GetItemHintRect(ANavBarItem, CalcOverflowPanelHintRect);
end;

function TdxNavBarNavigationPaneController.GetNavPaneItemHintText: string;
begin
  case HotPart.MajorPartIndex of
    nbOverflowPanelItem:
      Result := RemoveAccelChars(ViewInfo.OverflowPanelItems[HotPart.MinorPartIndex].Group.Caption, False);
    nbOverflowPanelSign:
      Result := cxGetResourceString(@sdxNavigationPaneOverflowPanelCustomizeHint);
    nbHeaderSign:
      if Collapsed then
        Result := cxGetResourceString(@sdxNavigationPaneExpandNavPaneSignHint)
      else
        Result := cxGetResourceString(@sdxNavigationPaneMinimizeNavPaneSignHint);
    nbItemPanelCollapseItem:
      Result := RemoveAccelChars(GetLinkHintText(ViewInfo.ItemPanelViewInfo.Items[HotPart.MinorPartIndex].ItemLink), False);
    nbItemPanelCollapseBar:
      Result := cxGetResourceString(@sdxNavigationPaneCollapseBarHint);
  else
    Result := '';
  end;
end;

function TdxNavBarNavigationPaneController.GetNavPaneItemHintCursorRect: TRect;
begin
  case HotPart.MajorPartIndex of
    nbOverflowPanelItem: Result := ViewInfo.OverflowPanelItems[HotPart.MinorPartIndex].SelectionRect;
    nbOverflowPanelSign: Result := ViewInfo.OverflowPanelSignRect;
    nbHeaderSign: Result := ViewInfo.HeaderSignRect;
    nbItemPanelCollapseItem: Result := ViewInfo.ItemPanelViewInfo.Items[HotPart.MinorPartIndex].Rect;
    nbItemPanelCollapseBar: Result := ViewInfo.ItemPanelViewInfo.CollapseBarRect;
  else
    Result := cxNullRect;
  end;
end;

procedure TdxNavBarNavigationPaneController.DoOverflowPanelItemClick;
begin
  FNavBar.ActiveGroup := OverflowPanelGroup[HotPart.MinorPartIndex]
end;

procedure TdxNavBarNavigationPaneController.DoOverflowPanelSignClick;
var
  APoint: TPoint;
begin
  APoint.Y := cxRectCenter(ViewInfo.OverflowPanelSignRect).Y;
  APoint.X := ViewInfo.OverflowPanelSignRect.Right;
  DroppedDownPart := dxNavBarPart(nbOverflowPanelSign);
  ViewInfo.DoShowPopupMenu(FNavBar.ClientToScreen(APoint));
  DroppedDownPart := dxNavBarPart(nbNone);
  HotPart := GetPartAtPos(GetMouseCursorPos);
end;

procedure TdxNavBarNavigationPaneController.DoHeaderSignClick;
begin
  ChangeNavBarCollapseState;
end;

procedure TdxNavBarNavigationPaneController.DoCollapseBarClick;
begin
  ShowPopupControl;
end;

procedure TdxNavBarNavigationPaneController.DoCollapseItemClick;
begin
  DoLinkClick(NavBar, ViewInfo.FItemPanelViewInfo.Items[HotPart.MinorPartIndex].ItemLink);
end;

procedure TdxNavBarNavigationPaneController.DoSplitterDrag(const APoint: TPoint);
begin
  if FNavBar.CanDecNavigationPaneOverflowPanelItemCount and
    ViewInfo.IsPtDecNavigationPaneOverflowPanelItemCount(APoint) then
    FNavBar.DoDecNavigationPaneOverflowPanelItemCount
  else
    if FNavBar.CanIncNavigationPaneOverflowPanelItemCount and
      ViewInfo.IsPtIncNavigationPaneOverflowPanelItemCount(APoint) then
      FNavBar.DoIncNavigationPaneOverflowPanelItemCount;
end;

function TdxNavBarNavigationPaneController.CanFocusOnClick(const APoint: TPoint): Boolean;
begin
  Result := not ViewInfo.IsPtNavigationPaneSplitter(APoint) and inherited CanFocusOnClick(APoint);
end;

function TdxNavBarNavigationPaneController.GetCursor: HIcon;

  function InternalGetCursor(const APart: TdxNavBarPart; out ACursor: HIcon): Boolean;
  begin
    Result := not IsdxNavBarPartsEqual(APart, dxNavBarPart(nbNone));
    if IsdxNavBarPartsEqual(APart, dxNavBarPart(nbSplitter)) then
      if FNavBar.ShowGroupCaptions then
        ACursor := Screen.Cursors[crSizeNS]
      else
        ACursor := 0
    else
      ACursor := Screen.Cursors[FNavBar.HotTrackedGroupCursor];
  end;

begin
  if not (InternalGetCursor(PressedPart, Result) or
    InternalGetCursor(GetPartAtPos(NavBar.ScreenToClient(GetMouseCursorPos)), Result)) then
    Result := inherited GetCursor;
end;

function TdxNavBarNavigationPaneController.Collapsible: Boolean;
begin
  Result := FNavBar.OptionsBehavior.NavigationPane.Collapsible;
end;

function TdxNavBarNavigationPaneController.Collapsed: Boolean;
begin
  Result := FNavBar.OptionsBehavior.NavigationPane.Collapsed;
end;

procedure TdxNavBarNavigationPaneController.CollapseStateChaged(Sender: TObject);
begin
  ClosePopupControl;
end;

procedure TdxNavBarNavigationPaneController.CalcOverflowPanelHintRect(AItem: TObject; var ARect: TRect);
begin
  if Assigned(NavBar.OnCalcNavigationPaneOverflowPanelHintRect) then
    NavBar.OnCalcNavigationPaneOverflowPanelHintRect(NavBar, TdxNavBarGroup(AItem), ViewInfo, ARect);
end;

procedure TdxNavBarNavigationPaneController.ChangeNavBarCollapseState;
begin
  FNavBar.OptionsBehavior.NavigationPane.Collapsed := not Collapsed;
end;

function TdxNavBarNavigationPaneController.IsAnyItemHotTracked: Boolean;
begin
  Result := not IsdxNavBarPartsEqual(GetPartAtPos(NavBar.ScreenToClient(GetMouseCursorPos)),
    dxNavBarPart(nbNone));
end;

function TdxNavBarNavigationPaneController.IsPopupControlExists: Boolean;
begin
  Result := FPopupControl <> nil;
end;

function TdxNavBarNavigationPaneController.IsPopupControlVisible: Boolean;
begin
  Result := IsPopupControlExists and FPopupControl.Visible;
end;

function TdxNavBarNavigationPaneController.IsPopupJustClosed: Boolean;
begin
  Result := IsPopupControlExists and FPopupControl.JustClosed;
end;

function TdxNavBarNavigationPaneController.IsOverflowPanelGroupHotTracked: Boolean;
begin
  Result := HotPart.MajorPartIndex = nbOverflowPanelItem;
end;

function TdxNavBarNavigationPaneController.GetNavPanePartState(const APart: TdxNavBarPart): TdxNavBarNavPanePartState;
var
  AGroup: TdxNavBarGroup;
begin
  if APart.MajorPartIndex = nbOverflowPanelItem then
    AGroup := OverflowPanelGroup[APart.MinorPartIndex]
  else
    AGroup := nil;

  if (AGroup <> nil) and (FNavBar.ActiveGroup = AGroup) then
  begin
    if IsdxNavBarPartsEqual(HotPart, APart) and (IsdxNavBarPartsEqual(PressedPart, dxNavBarPart(nbNone)) or IsdxNavBarPartsEqual(PressedPart, APart)) then
      Result := oisHotCheck
    else
      Result := oisChecked
  end
  else
    if IsdxNavBarPartsEqual(FDroppedDownPart, APart) then
      Result := oisDroppedDown
    else
      if IsdxNavBarPartsEqual(PressedPart, APart) then
        if IsdxNavBarPartsEqual(HotPart, APart) then
          Result := oisPressed
        else
            Result := oisNormal
      else
        if IsdxNavBarPartsEqual(HotPart, APart) and IsdxNavBarPartsEqual(PressedPart, dxNavBarPart(nbNone)) then
          Result := oisHot
        else
          Result := oisNormal;
end;

function TdxNavBarNavigationPaneController.GetOriginalWidth: Integer;
begin
  Result := TdxCustomNavBarAccess(FNavBar).OriginalWidth;
end;

function TdxNavBarNavigationPaneController.GetPartAtPos(const APoint: TPoint): TdxNavBarPart;
begin
  Result.MinorPartIndex := ViewInfo.FOverflowPanelViewInfo.GetItemIndexAtPos(APoint);
  if (Result.MinorPartIndex <> nbNone) then
    Result.MajorPartIndex := nbOverflowPanelItem
  else
    if ViewInfo.IsPtNavigationPaneOverflowPanelSign(APoint) then
      Result.MajorPartIndex := nbOverflowPanelSign
    else
      if ViewInfo.IsPtNavigationPaneHeaderSign(APoint) then
        Result.MajorPartIndex := nbHeaderSign
      else
        if ViewInfo.IsPtNavigationPaneSplitter(APoint) then
          Result.MajorPartIndex := nbSplitter
        else
          if Collapsed and ViewInfo.IsPtNavigationPaneItemPanel(APoint) then
          begin
            Result.MinorPartIndex := ViewInfo.FItemPanelViewInfo.GetItemIndexAtPos(APoint);
            if Result.MinorPartIndex <> nbNone then
              Result.MajorPartIndex := nbItemPanelCollapseItem
            else
              Result.MajorPartIndex := nbItemPanelCollapseBar;
          end
          else
            Result := inherited GetPartAtPos(APoint);
end;

function TdxNavBarNavigationPaneController.GetViewInfo: TdxNavBarNavigationPaneViewInfo;
begin
  Result := TdxNavBarNavigationPaneViewInfo(inherited ViewInfo);
end;

function TdxNavBarNavigationPaneController.GetOverflowPanelGroup(AIndex: Integer): TdxNavBarGroup;
begin
  Result := ViewInfo.FOverflowPanelViewInfo.Items[AIndex].Group;
end;

procedure TdxNavBarNavigationPaneController.SetDroppedDownPart(APart: TdxNavBarPart);
begin
  if not IsdxNavBarPartsEqual(FDroppedDownPart, APart) then
  begin
    FDroppedDownPart := APart;
    InvalidateAll(doRedraw);
  end;
end;

procedure TdxNavBarNavigationPaneController.SetOriginalWidth(AValue: Integer);
begin
  TdxCustomNavBarAccess(FNavBar).OriginalWidth := AValue;
end;

{ TdxNavBarNavigationPanePainter }

procedure TdxNavBarNavigationPanePainter.DrawNavBarControl;
begin
  inherited DrawNavBarControl;
  DrawHeader;
  DrawItemPanel;
  DrawOverflowPanel;
  DrawSplitter;
  DrawBorder;
  if TdxCustomNavBarAccess(NavBar).IsInternal then
    DrawSizeGrip(Canvas, ViewInfo.SizeGripRect);
end;

procedure TdxNavBarNavigationPanePainter.DrawGroupCaption(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  DrawGroupCaptionButton(AGroupViewInfo);
  if not Controller.Collapsed then
    DrawGroupCaptionText(AGroupViewInfo);
  if AGroupViewInfo.IsCaptionImageVisible then
    DrawGroupCaptionImage(AGroupViewInfo);
end;

procedure TdxNavBarNavigationPanePainter.DrawSizeGrip(ACanvas: TCanvas; const ARect: TRect);
const
  ASpace = 4;
  ALineCount = 3;
var
  I: Integer;
  AStartPoint: TPoint;
begin
  ACanvas.Pen.Color := clBlack;
  AStartPoint := cxRectOffset(ARect, -ViewInfo.BorderWidth, -ViewInfo.BorderWidth).BottomRight;
  Dec(AStartPoint.Y);
  for I := 0 to ALineCount - 1 do
    with AStartPoint do
    begin
      ACanvas.MoveTo(X - ASpace * (I + 1), Y);
      ACanvas.LineTo(X, Y - ASpace* (I + 1));
    end;
end;

procedure TdxNavBarNavigationPanePainter.DrawHintWindow(AHintWindow: TdxNavBarHintWindow);
begin
  if Controller.IsAnyItemHotTracked then
    DrawOverflowPanelHintWindow(AHintWindow.Canvas, AHintWindow.ClientRect)
  else
    inherited;
end;

procedure TdxNavBarNavigationPanePainter.DrawItemPanel;
var
  I: Integer;
begin
  if Controller.Collapsed then
  begin
    DrawCollapseBar(ViewInfo.FItemPanelViewInfo);
    for I := 0 to ViewInfo.FItemPanelViewInfo.ItemCount - 1 do
      DrawCollapseItem(ViewInfo.FItemPanelViewInfo.Items[I], GetNavPanePartState(dxNavBarPart(nbItemPanelCollapseItem, I)));
  end;
end;

procedure TdxNavBarNavigationPanePainter.DrawItemsRect(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  if not AGroupViewInfo.IsCaptionVisible then
    inherited;
end;

procedure TdxNavBarNavigationPanePainter.DrawGroupCaptionButton(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  with AGroupViewInfo do
    TdxNavBarOffice11NavPaneGroupButtonPainter.DrawButton(Canvas, CaptionRect, CaptionImage,
      CaptionBackColor, CaptionBackColor2, CaptionAlphaBlend, CaptionAlphaBlend2,
      CaptionGradientMode, CaptionBorderColor, State);
end;

procedure TdxNavBarNavigationPanePainter.DrawCollapseBar(AItemPanelViewInfo: TdxNavBarItemPanelViewInfo);
var
  AState: TdxNavBarNavPanePartState;
begin
  AState := GetNavPanePartState(dxNavBarPart(nbItemPanelCollapseBar));
  DrawCollapseElementBackground(AItemPanelViewInfo.CollapseBarRect, AState);
  DrawVertivalText(AItemPanelViewInfo.CollapseBarFont, AItemPanelViewInfo.CollapseBarText, AItemPanelViewInfo.CollapseBarRect, AState);
  if AItemPanelViewInfo.CollapseBarIAccessibilityHelper.IsFocused then
    DrawItemPanelPartFocusRect(AItemPanelViewInfo.CollapseBarRect);
end;

procedure TdxNavBarNavigationPanePainter.DrawCollapseElementBackground(const ARect: TRect; AState: TdxNavBarNavPanePartState);
begin
  case AState of
    oisNormal:
      begin
        Canvas.Brush.Color := GetMiddleRGB(ViewInfo.OverflowPanelBackColor, ViewInfo.OverflowPanelBackColor2, 50);
        Canvas.FillRect(ARect);
      end;
  else
    DrawOverflowPanelItemBackground(Canvas, AState, ARect);
  end;
  cxCanvas.FrameRect(ARect, clBlack, 1, [bBottom]);
end;

procedure TdxNavBarNavigationPanePainter.DrawCollapseItem(AItemViewInfo: TdxNavBarItemPanelViewInfoItem; AState: TdxNavBarNavPanePartState);
begin
  DrawCollapseElementBackground(AItemViewInfo.Rect, AState);
  DrawVertivalText(AItemViewInfo.Font, AItemViewInfo.Caption, AItemViewInfo.TextRect, AState);
  if ImagePainterClass.IsValidImage(AItemViewInfo.ImageList, AItemViewInfo.ImageIndex) then
    ImagePainterClass.DrawImage(Canvas, AItemViewInfo.ImageList, AItemViewInfo.ImageIndex, AItemViewInfo.ImageRect);
  if ViewInfo.ItemPanelViewInfo.ItemIAccessibilityHelpers[AItemViewInfo.Index].IsFocused then
    DrawItemPanelPartFocusRect(AItemViewInfo.Rect);
end;

procedure TdxNavBarNavigationPanePainter.DrawBorder;
var
  ABorderRect: TRect;
begin
  with cxCanvas do
  begin
    SaveClipRegion;
    try
      ABorderRect := cxRectBounds(0, 0, ViewInfo.ClientWidth, ViewInfo.ClientHeight);
      SetClipRegion(TcxRegion.Create(cxRectInflate(ABorderRect, - ViewInfo.BorderWidth, - ViewInfo.BorderWidth)),
        roSubtract);
      FillRect(ABorderRect, ViewInfo.BorderColor);
    finally
      RestoreClipRegion;
    end;
  end;
end;

procedure TdxNavBarNavigationPanePainter.DrawHeader;
var
  AHandled: Boolean;
begin
  if not ViewInfo.IsHeaderVisible then Exit;
  AHandled := False;
  if Assigned(NavBar.OnCustomDrawNavigationPaneHeader) then
    NavBar.OnCustomDrawNavigationPaneHeader(NavBar, Canvas, ViewInfo, AHandled);
  if not AHandled then
    DoDrawHeader;
end;

procedure TdxNavBarNavigationPanePainter.DrawHeaderBackground;
var
  R: TRect;
begin
  R := ViewInfo.HeaderRect;
  Inc(R.Top);
  with ViewInfo do
    BackgroundPainterClass.DrawBackground(Canvas, R, HeaderImage, False, clNone,
      HeaderBackColor, HeaderBackColor2, HeaderAlphaBlend, HeaderAlphaBlend2,
      OverflowPanelGradientMode);
end;

procedure TdxNavBarNavigationPanePainter.DrawHeaderSign;
const
  AStateMap: array[Boolean] of TdxNavBarObjectStates = ([sExpanded], []);
var
  ACanvas: TcxCanvas;
  ABitmap: TcxBitmap;
  ASignColor: TColor;
begin
  ABitmap := TcxBitmap.CreateSize(ViewInfo.FHeaderSignRect);
  try
    ACanvas := ABitmap.cxCanvas;

    case GetNavPanePartState(dxNavBarPart(nbHeaderSign)) of
      oisNormal:
        begin
          ASignColor := ViewInfo.HeaderFontColor;
          ACanvas.CopyRect(ABitmap.ClientRect, Canvas, ViewInfo.FHeaderSignRect);
        end;
    else
      if IsHighContrastWhite then
        ASignColor := clHighlightText
      else
        ASignColor := clBlack;
      DrawOverflowPanelItemBackground(ACanvas.Canvas, dxNavBarPart(nbHeaderSign), ABitmap.ClientRect);
    end;

    ABitmap.Rotate(raMinus90);
    TdxNavBarOffice11ExplorerBarSignPainter.DrawSign(ACanvas.Canvas, ABitmap.ClientRect,
      ASignColor, clNone, clNone, AStateMap[Controller.Collapsed]);
    ABitmap.Rotate(raPlus90);

    with ViewInfo.FHeaderSignRect.TopLeft do
      Canvas.Draw(X, Y, ABitmap);
  finally
    ABitmap.Free;
  end;
end;

procedure TdxNavBarNavigationPanePainter.DrawHeaderText;
var
  R: TRect;
  AText: string;
begin
  with ViewInfo do
  begin
    if (NavBar.ActiveGroup <> nil) and NavBar.ActiveGroup.Visible then
    begin
      AText := RemoveAccelChars(NavBar.ActiveGroup.Caption);
      R := FHeaderTextRect;
      Inc(R.Left, ViewInfo.GetGroupHeaderTextIndent);
      Canvas.Font := HeaderFont;
      Canvas.Font.Color := HeaderFontColor;
      cxDrawText(Canvas, AText, R, HeaderDrawEdgeFlag or DT_NOPREFIX);
    end;
  end;
end;

procedure TdxNavBarNavigationPanePainter.DrawOverflowPanel;
var
  AHandled: Boolean;
begin
  if not OverflowPanelViewInfo.IsVisible then Exit;
  AHandled := False;
  if Assigned(NavBar.OnCustomDrawNavigationPaneOverflowPanel) then
    NavBar.OnCustomDrawNavigationPaneOverflowPanel(NavBar, Canvas, ViewInfo, AHandled);
  if not AHandled then
    DoDrawOverflowPanel;
end;

procedure TdxNavBarNavigationPanePainter.DrawOverflowPanelBackground;
begin
  with ViewInfo do
    TdxNavBarOffice11NavPaneGroupButtonPainter.DrawButton(Canvas, OverflowPanelRect, OverflowPanelImage,
      OverflowPanelBackColor, OverflowPanelBackColor2, OverflowPanelAlphaBlend,
      OverflowPanelAlphaBlend2, OverflowPanelGradientMode, BorderColor, []);
end;

procedure TdxNavBarNavigationPanePainter.DrawOverflowPanelSign;
var
  R: TRect;
begin
  if dxOffice11NavPaneOverflowPanelBitmap <> nil then
  begin
    R := ViewInfo.OverflowPanelSignRect;
    if R.Left > ViewInfo.OverflowPanelRect.Left then
    begin
      DrawOverflowPanelItemBackground(Canvas, dxNavBarPart(nbOverflowPanelSign), R);

      with cxRectCenter(R, dxOffice11NavPaneOverflowPanelBitmap.Width, dxOffice11NavPaneOverflowPanelBitmap.Height).TopLeft do
        Canvas.Draw(X, Y, dxOffice11NavPaneOverflowPanelBitmap);
//      if ViewInfo.OverflowPanelSignIAccessibilityHelper.IsFocused then
//      begin
//        R := Bounds(X, Y, dxOffice11NavPaneOverflowPanelBitmap.Width,
//          dxOffice11NavPaneOverflowPanelBitmap.Height);
//        InflateRect(R, 1, 1);
//        DrawSolidFocusRect(R, clBlack);
//      end;
    end;
  end;
end;

procedure TdxNavBarNavigationPanePainter.DrawOverflowPanelItems;
var
  I: Integer;
  AGroup: TdxNavBarGroup;
  R: TRect;
begin
  for I := 0 to ViewInfo.OverflowPanelVisibleItemCount - 1 do
  begin
    R := ViewInfo.OverflowPanelItems[I].SelectionRect;
    DrawOverflowPanelItemBackground(Canvas, dxNavBarPart(nbOverflowPanelItem, I), R);

    R := ViewInfo.OverflowPanelItems[I].Rect;
    AGroup := ViewInfo.OverflowPanelItems[I].Group;
    if ImagePainterClass.IsValidImage(ViewInfo.FOverflowPanelViewInfo.GetImageList, ViewInfo.FOverflowPanelViewInfo.GetImageIndex(AGroup)) then
      ImagePainterClass.DrawImage(Canvas, ViewInfo.FOverflowPanelViewInfo.GetImageList, ViewInfo.FOverflowPanelViewInfo.GetImageIndex(AGroup), R)
    else
      if NavBar.NavigationPaneOverflowPanelUseSmallImages then
        Canvas.Draw(R.Left, R.Top, dxOffice11NavPaneDefaultSmallBitmap)
      else
        Canvas.Draw(R.Left, R.Top, dxOffice11NavPaneDefaultLargeBitmap);
//    if ViewInfo.OverflowPanelItemIAccessibilityHelpers[I].IsFocused then
//    begin
//      InflateRect(R, 1, 1);
//      DrawSolidFocusRect(R, clBlack);
//    end;
  end;
end;

procedure TdxNavBarNavigationPanePainter.DrawOverflowPanelHintWindow(ACanvas: TCanvas; const ARect: TRect);
var
  AHandled: Boolean;
  AGroup: TdxNavBarGroup;
begin
  AHandled := False;
  if Assigned(NavBar.OnCustomDrawNavigationPaneOverflowPanelHint) then
  begin
    if Controller.IsOverflowPanelGroupHotTracked then
      AGroup := ViewInfo.OverflowPanelItems[Controller.HotPart.MinorPartIndex].Group
    else
      AGroup := nil;
    NavBar.OnCustomDrawNavigationPaneOverflowPanelHint(NavBar, ACanvas, AGroup,
      NavBar.ViewInfo.HintText, ARect, AHandled);
  end;
  if not AHandled then
    with ViewInfo do
      TdxNavBarCustomHintPainter.DrawHint(ACanvas, ARect,
        ViewInfo.HintText, HintImage, HintBackColor, HintBackColor2,
        HintAlphaBlend, HintAlphaBlend2, HintGradientMode, HintFont);
end;

procedure TdxNavBarNavigationPanePainter.DrawPopupControl(ACanvas: TcxCanvas; AViewInfo: TdxNavBarPopupControlViewInfo);
begin
  ACanvas.FrameRect(AViewInfo.FRect, ViewInfo.BorderColor);
  ACanvas.SaveClipRegion;
  try
    ACanvas.ExcludeClipRect(AViewInfo.ClientRect);
    ACanvas.FillRect(cxRectInflate(AViewInfo.FRect, -1, -1), $EEC6A9);
  finally
    ACanvas.RestoreClipRegion;
  end;
end;

procedure TdxNavBarNavigationPanePainter.DrawSplitter;
var
  AHandled: Boolean;
begin
  if not ViewInfo.IsSplitterVisible then Exit;
  AHandled := False;
  if Assigned(NavBar.OnCustomDrawNavigationPaneSplitter) then
    NavBar.OnCustomDrawNavigationPaneSplitter(NavBar, Canvas, ViewInfo, AHandled);
  if not AHandled then
    DoDrawSplitter;
end;

procedure TdxNavBarNavigationPanePainter.DrawSplitterSign;
var
  APoint: TPoint;
begin
  if dxOffice11NavPaneSplitterBitmap <> nil then
  begin
    APoint := cxRectCenter(ViewInfo.SplitterRect, dxOffice11NavPaneSplitterBitmap.Width, dxOffice11NavPaneSplitterBitmap.Height).TopLeft;
    if APoint.X > ViewInfo.OverflowPanelRect.Left then
      Canvas.Draw(APoint.X, APoint.Y, dxOffice11NavPaneSplitterBitmap);
  end;
end;

procedure TdxNavBarNavigationPanePainter.DrawPopupMenuItem(ACanvas: TCanvas; ARect: TRect; AImageList: TCustomImageList;
  AImageIndex: Integer; AText: string; State: TdxNavBarObjectStates);
var
  R: TRect;
begin
  BackgroundPainterClass.DrawBackground(ACanvas, ARect, nil, False, clNone,
    clMenu, clMenu, 255, 255, gmVertical);
  R := ARect;
  R.Right := R.Left + 2 * ViewInfo.FOverflowPanelViewInfo.GetPopupMenuImageIndent + ViewInfo.GetSmallImageWidth;
  BackgroundPainterClass.DrawBackground(ACanvas, R, nil, False, clNone, dxOffice11NavPaneGroupCaptionColor1,
    dxOffice11NavPaneGroupCaptionColor2, 255, 255, gmHorizontal);

  if AText <> '-' then
  begin
    InflateRect(R, -1, -1);
    if sSelected in State then
    begin
      ButtonPainterClass.DrawButton(ACanvas, ARect, nil, dxOffice11NavPaneGroupCaptionHotColor1,
        dxOffice11NavPaneGroupCaptionHotColor2, 255, 255, gmVertical, dxOffice11NavPaneBorder, []);
      if sActive in State then
        ButtonPainterClass.DrawButton(ACanvas, R, nil, dxOffice11NavPaneGroupCaptionPressedColor1,
          dxOffice11NavPaneGroupCaptionPressedColor2, 255, 255, gmVertical, dxOffice11NavPaneBorder, []);
    end
    else
      if sActive in State then
        ButtonPainterClass.DrawButton(ACanvas, R, nil, dxOffice11NavPaneGroupCaptionHotColor1,
          dxOffice11NavPaneGroupCaptionHotColor1, 255, 255, gmVertical, dxOffice11NavPaneBorder, []);

    InflateRect(R,  1 - ViewInfo.FOverflowPanelViewInfo.GetPopupMenuImageIndent, 1 - ViewInfo.FOverflowPanelViewInfo.GetPopupMenuImageIndent);
    AImageList.Draw(ACanvas, R.Left, R.Top, AImageIndex, not (sDisabled in State));

    R := ARect;
    R.Left := R.Left + 2 * ViewInfo.FOverflowPanelViewInfo.GetPopupMenuImageIndent + ViewInfo.GetSmallImageWidth + ViewInfo.FOverflowPanelViewInfo.GetPopupMenuTextIndent;
    if sDisabled in State then
      ACanvas.Font.Color := clGrayText
    else
      if (sSelected in State) and IsHighContrastWhite then
        ACanvas.Font.Color := clHighlightText
      else
        ACanvas.Font.Color := clMenuText;
    cxDrawText(ACanvas, AText, R, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
  end
  else
  begin
    ACanvas.Pen.Color := Dark(dxOffice11NavPaneGroupCaptionColor2, 80);
    ACanvas.MoveTo(R.Right + cxRectWidth(R) div 2, R.Top + cxRectHeight(ARect) div 2);
    ACanvas.LineTo(ARect.Right, R.Top + cxRectHeight(ARect) div 2);
  end;
end;

function TdxNavBarNavigationPanePainter.CreatePopupControlViewInfo: TdxNavBarPopupControlViewInfo;
begin
  Result := GetPopupControlViewInfoClass.Create(NavBar.ViewInfo);
end;

class function TdxNavBarNavigationPanePainter.ButtonPainterClass: TdxNavBarCustomButtonPainterClass;
begin
  Result := TdxNavBarNavigationPaneButtonPainter;
end;

class function TdxNavBarNavigationPanePainter.GetViewInfoClass: TdxNavBarViewInfoClass;
begin
  Result := TdxNavBarNavigationPaneViewInfo;
end;

class function TdxNavBarNavigationPanePainter.GetGroupViewInfoClass: TdxNavBarGroupViewInfoClass;
begin
  Result := TdxNavBarNavigationPaneGroupViewInfo;
end;

function TdxNavBarNavigationPanePainter.GetControllerClass: TdxNavBarControllerClass;
begin
  if TdxCustomNavBarAccess(NavBar).IsInternal then
    Result := TdxNavBarPopupInnerControlController
  else
    Result := TdxNavBarNavigationPaneController;
end;

class function TdxNavBarNavigationPanePainter.GetPopupControlViewInfoClass: TdxNavBarPopupControlViewInfoClass;
begin
  Result := TdxNavBarPopupControlViewInfo;
end;

function TdxNavBarNavigationPanePainter.GetNavPanePartState(const APart: TdxNavBarPart): TdxNavBarNavPanePartState;
begin
  Result := Controller.GetNavPanePartState(APart);
  if (Result = oisNormal) and ViewInfo.NavPanePartIAccessibilityHelpers[APart].IsPressed then
    Result := oisPressed;
  if (Result = oisNormal) and
    (APart.MajorPartIndex in [nbOverflowPanelSign, nbOverflowPanelItem, nbHeaderSign]) and
    ViewInfo.NavPanePartIAccessibilityHelpers[APart].IsFocused then
      Result := oisHot;
end;

procedure TdxNavBarNavigationPanePainter.DoDrawHeader;
begin
  DrawHeaderBackground;
  if not Controller.Collapsed then
    DrawHeaderText;
  if Controller.Collapsible then
    DrawHeaderSign;
end;

procedure TdxNavBarNavigationPanePainter.DoDrawOverflowPanel;
begin
  DrawOverflowPanelBackground;
  DrawOverflowPanelSign;
  DrawOverflowPanelItems;
end;

procedure TdxNavBarNavigationPanePainter.DoDrawSplitter;
var
  R: TRect;
begin
  with ViewInfo do
  begin
    Canvas.Brush.Color := clWhite;
    R := SplitterRect;
    Canvas.FillRect(Rect(R.Left, R.Top, R.Right, R.Top + 1));
    Inc(R.Top);
    BackgroundPainterClass.DrawBackground(Canvas, R, nil, False, clNone,
      SplitterBackColor, SplitterBackColor2, SplitterAlphaBlend, SplitterAlphaBlend2,
      SplitterGradientMode);
  end;
  DrawSplitterSign;
end;

function TdxNavBarNavigationPanePainter.GetViewInfo: TdxNavBarNavigationPaneViewInfo;
begin
  if inherited ViewInfo is TdxNavBarNavigationPaneViewInfo then
    Result := inherited ViewInfo as TdxNavBarNavigationPaneViewInfo
  else Result := nil;
end;

function TdxNavBarNavigationPanePainter.GetController: TdxNavBarNavigationPaneController;
begin
  Result := TdxNavBarNavigationPaneController(inherited Controller);
end;

function TdxNavBarNavigationPanePainter.GetOverflowPanelViewInfo: TdxNavBarOverflowPanelViewInfo;
begin
  Result := ViewInfo.FOverflowPanelViewInfo;
end;

procedure TdxNavBarNavigationPanePainter.DrawItemPanelPartFocusRect(
  const APartRect: TRect);
begin
  DrawSolidFocusRect(cxRectInflate(APartRect, -1, -0, -1, -1),
    ViewInfo.HeaderFontColor);
end;

procedure TdxNavBarNavigationPanePainter.DrawVertivalText(AFont: TFont; const AText: string; const ARect: TRect; AState: TdxNavBarNavPanePartState);
begin
  cxCanvas.Font := AFont;
  cxDrawText(cxCanvas, AText, ARect, DT_CENTER or DT_VCENTER or DT_CENTER or DT_SINGLELINE, ViewInfo.CollapseBarFontColor, raPlus90);
end;

procedure TdxNavBarNavigationPanePainter.DrawOverflowPanelItemBackground(ACanvas: TCanvas; AState: TdxNavBarNavPanePartState; const ARect: TRect);
var
  AColor1, AColor2: TColor;
begin
  case AState of
    oisPressed, oisHotCheck, oisDroppedDown:
      begin
        AColor1 := dxOffice11NavPaneGroupCaptionPressedHotColor1;
        AColor2 := dxOffice11NavPaneGroupCaptionPressedHotColor2;
      end;
    oisChecked:
      begin
        AColor1 := dxOffice11NavPaneGroupCaptionPressedColor1;
        AColor2 := dxOffice11NavPaneGroupCaptionPressedColor2;
      end;
    oisHot:
      begin
        AColor1 := dxOffice11NavPaneGroupCaptionHotColor1;
        AColor2 := dxOffice11NavPaneGroupCaptionHotColor2;
      end;
  else {oisNormal}
    AColor1 := clNone;
    AColor2 := clNone;
  end;

  if (AColor1 <> clNone) and (AColor2 <> clNone) then
    BackgroundPainterClass.DrawBackground(ACanvas, ARect, nil, False, clNone,
      AColor1, AColor2, 255, 255, gmVertical);
end;

procedure TdxNavBarNavigationPanePainter.DrawOverflowPanelItemBackground(ACanvas: TCanvas; const APart: TdxNavBarPart; const ARect: TRect);
begin
  DrawOverflowPanelItemBackground(ACanvas, GetNavPanePartState(APart), ARect);
end;

{ TdxNavBarNavigationPaneButtonPainter }

class procedure TdxNavBarNavigationPaneButtonPainter.InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
  AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
  AState: TdxNavBarObjectStates);
begin
  inherited;
  with TcxCanvas.Create(ACanvas) do
  begin
    FrameRect(ARect, ABorderColor);
    Free;
  end;
end;

{ TdxNavBarOffice11NavPanePainter }

class function TdxNavBarOffice11NavPanePainter.GetGroupViewInfoClass: TdxNavBarGroupViewInfoClass;
begin
  Result := TdxNavBarOffice11NavPaneGroupViewInfo;
end;

class function TdxNavBarOffice11NavPanePainter.GetLinkViewInfoClass: TdxNavBarLinkViewInfoClass;
begin
  Result := TdxNavBarOffice11NavPaneLinkViewInfo;
end;

class function TdxNavBarOffice11NavPanePainter.GetViewInfoClass: TdxNavBarViewInfoClass;
begin
  Result := TdxNavBarOffice11NavPaneViewInfo;
end;

class function TdxNavBarOffice11NavPanePainter.ButtonPainterClass: TdxNavBarCustomButtonPainterClass;
begin
  Result := TdxNavBarOffice11NavPaneButtonPainter;
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
  inherited InternalDrawButton(ACanvas, ABackgroundRect, APicture, AColor1, AColor2,
    AAlphaBlend1, AAlphaBlend2, AGradientMode, ABorderColor, AState);
  ACanvas.Pen.Color := ColorToRGB(ABorderColor);
  ACanvas.Pen.Style := psSolid;
  ACanvas.Pen.Width := 1;
  ACanvas.MoveTo(ARect.Left, ARect.Top);
  ACanvas.LineTo(ARect.Right, ARect.Top);
end;

{ TdxNavBarOffice11SignPainter }

class procedure TdxNavBarOffice11SignPainter.PrepareBitmap(ACanvas: TCanvas;
  ABitmap: TBitmap; ABackColor1, ABackColor2: TColor; AState: TdxNavBarObjectStates);
var
  ABitmapColors: TRGBColors;
  ATransparentColor, APixelColor: COLORREF;
  AMinValue, AMaxValue, AValue: Byte;
  I, J: Integer;
begin
  if sExpanded in AState then
    ABitmap.Assign(dxOffice11CaptionCollapseSignBitmap)
  else
    ABitmap.Assign(dxOffice11CaptionExpandSignBitmap);

  GetBitmapBits(ABitmap, ABitmapColors, True);

  RGBQuadToColorRef(ABitmapColors[0], ATransparentColor);

  AMaxValue := 1;
  AMinValue := 255;
  for I := 0 to ABitmap.Width - 1 do
    for J := 0 to ABitmap.Height - 1 do
    begin
      RGBQuadToColorRef(ABitmapColors[J * ABitmap.Width + I], APixelColor);
      if (APixelColor <> ATransparentColor) and (APixelColor <> 0{mark}) then
      begin
        AValue := GetRValue(APixelColor);
        AMaxValue := Max(AMaxValue, AValue);
        AMinValue := Min(AMinValue, AValue);
      end;
    end;

  for I := 0 to ABitmap.Width - 1 do
    for J := 0 to ABitmap.Height - 1 do
    begin
      RGBQuadToColorRef(ABitmapColors[J * ABitmap.Width + I], APixelColor);
      if (APixelColor <> ATransparentColor) and (APixelColor <> 0{mark}) then
      begin
        AValue := GetRValue(APixelColor);
        APixelColor := GetMiddleRGB(ColorToRGB(ABackColor1), ColorToRGB(ABackColor2),
          MulDiv(AValue - AMinValue, 100, AMaxValue - AMinValue));
        ColorRefToRGBQuad(APixelColor, ABitmapColors[J * ABitmap.Width + I]);
      end;
    end;

  SetBitmapBits(ABitmap, ABitmapColors, True);
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

{ TdxNavBarItemCollectionAccessibilityHelper }

constructor TdxNavBarItemCollectionAccessibilityHelper.Create(
  AOwnerObject: TObject; AOwnerObjectControl: TWinControl);
begin
  inherited Create(AOwnerObject, AOwnerObjectControl);
  FItemIAccessibilityHelpers := TInterfaceList.Create;
end;

destructor TdxNavBarItemCollectionAccessibilityHelper.Destroy;
begin
  SetItemIAccessibilityHelperCount(0);
  FreeAndNil(FItemIAccessibilityHelpers);
  inherited Destroy;
end;

procedure TdxNavBarItemCollectionAccessibilityHelper.CheckItemIAccessibilityHelperCount;
begin
  SetItemIAccessibilityHelperCount(GetActualItemCount);
end;

function TdxNavBarItemCollectionAccessibilityHelper.GetChild(
  AIndex: Integer): TcxAccessibilityHelper;
begin
  if AIndex < inherited GetChildCount then
    Result := inherited GetChild(AIndex)
  else
  begin
    Dec(AIndex, inherited GetChildCount);
    CheckItemIAccessibilityHelperCount;
    Result := ItemIAccessibilityHelpers[AIndex].GetHelper;
  end;
end;

function TdxNavBarItemCollectionAccessibilityHelper.GetChildCount: Integer;
begin
  Result := inherited GetChildCount;
  CheckItemIAccessibilityHelperCount;
  Inc(Result, ItemIAccessibilityHelperCount);
end;

function TdxNavBarItemCollectionAccessibilityHelper.IsContainer: Boolean;
begin
  Result := True;
end;

function TdxNavBarItemCollectionAccessibilityHelper.GetItemIAccessibilityHelper(
  AIndex: Integer): IdxNavBarAccessibilityHelper;
begin
  CheckItemIAccessibilityHelperCount;
  Result := FItemIAccessibilityHelpers[AIndex] as IdxNavBarAccessibilityHelper;
end;

function TdxNavBarItemCollectionAccessibilityHelper.GetItemIAccessibilityHelperCount: Integer;
begin
  CheckItemIAccessibilityHelperCount;
  Result := FItemIAccessibilityHelpers.Count;
end;

procedure TdxNavBarItemCollectionAccessibilityHelper.SetItemIAccessibilityHelperCount(
  Value: Integer);
var
  AIAccessibilityHelper: IdxNavBarAccessibilityHelper;
  I: Integer;
begin
  if FItemIAccessibilityHelpers.Count <> Value then
    if FItemIAccessibilityHelpers.Count < Value then
      for I := 1 to Value - FItemIAccessibilityHelpers.Count do
      begin
        AIAccessibilityHelper := NavBarGetAccessibilityHelper(GetItemAccessibilityHelperClass.Create(Self,
          OwnerObjectControl));
        (AIAccessibilityHelper.GetHelper as TdxNavBarItemCollectionItemAccessibilityHelper).ItemIndex :=
          FItemIAccessibilityHelpers.Count;
        FItemIAccessibilityHelpers.Add(AIAccessibilityHelper);
      end
    else
      for I := FItemIAccessibilityHelpers.Count - 1 downto Value do
      begin
        AIAccessibilityHelper := FItemIAccessibilityHelpers[I] as IdxNavBarAccessibilityHelper;
        NavBarAccessibleObjectOwnerObjectDestroyed(AIAccessibilityHelper);
        FItemIAccessibilityHelpers.Delete(I);
      end;
end;

{ TdxNavBarNavigationPaneOverflowPanelAccessibilityHelper }

destructor TdxNavBarNavigationPaneOverflowPanelAccessibilityHelper.Destroy;
begin
  NavBarAccessibleObjectOwnerObjectDestroyed(FSignIAccessibilityHelper);
  inherited Destroy;
end;

function TdxNavBarNavigationPaneOverflowPanelAccessibilityHelper.GetChild(
  AIndex: Integer): TcxAccessibilityHelper;
begin
  if AIndex < inherited GetChildCount then
    Result := inherited GetChild(AIndex)
  else
    Result := SignIAccessibilityHelper.GetHelper;
end;

function TdxNavBarNavigationPaneOverflowPanelAccessibilityHelper.GetChildCount: Integer;
begin
  Result := inherited GetChildCount + 1;
end;

function TdxNavBarNavigationPaneOverflowPanelAccessibilityHelper.GetParent: TcxAccessibilityHelper;
begin
  Result := ViewInfo.NavBar.IAccessibilityHelper.GetHelper;
end;

function TdxNavBarNavigationPaneOverflowPanelAccessibilityHelper.GetState(
  AChildID: TcxAccessibleSimpleChildElementID): Integer;
begin
  Result := Parent.States[cxAccessibleObjectSelfID];
  if not ViewInfo.IsVisible then
    Result := Result or cxSTATE_SYSTEM_INVISIBLE;
end;

function TdxNavBarNavigationPaneOverflowPanelAccessibilityHelper.GetActualItemCount: Integer;
begin
  Result := ViewInfo.ItemCount;
end;

function TdxNavBarNavigationPaneOverflowPanelAccessibilityHelper.GetBounds: TRect;
begin
  Result := ViewInfo.FRect;
end;

function TdxNavBarNavigationPaneOverflowPanelAccessibilityHelper.GetItemAccessibilityHelperClass: TdxNavBarItemCollectionItemAccessibilityHelperClass;
begin
  Result := TdxNavBarNavigationPaneOverflowPanelItemAccessibilityHelper;
end;

function TdxNavBarNavigationPaneOverflowPanelAccessibilityHelper.GetSignAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass;
begin
  Result := TdxNavBarNavigationPaneOverflowPanelSignAccessibilityHelper;
end;

function TdxNavBarNavigationPaneOverflowPanelAccessibilityHelper.GetSignIAccessibilityHelper: IdxNavBarAccessibilityHelper;
begin
  if FSignIAccessibilityHelper = nil then
    FSignIAccessibilityHelper := NavBarGetAccessibilityHelper(
      GetSignAccessibilityHelperClass.Create(Self, OwnerObjectControl));
  Result := FSignIAccessibilityHelper;
end;

function TdxNavBarNavigationPaneOverflowPanelAccessibilityHelper.GetViewInfo: TdxNavBarOverflowPanelViewInfo;
begin
  Result := TdxNavBarOverflowPanelViewInfo(FOwnerObject);
end;

{ TdxNavBarNavigationPaneOverflowPanelItemAccessibilityHelper }

function TdxNavBarNavigationPaneOverflowPanelItemAccessibilityHelper.GetParent: TcxAccessibilityHelper;
begin
  Result := TcxAccessibilityHelper(FOwnerObject);
end;

function TdxNavBarNavigationPaneOverflowPanelItemAccessibilityHelper.GetState(
  AChildID: TcxAccessibleSimpleChildElementID): Integer;
begin
  Result := Parent.States[cxAccessibleObjectSelfID];
  if ItemIndex >= ViewInfo.OverflowPanelVisibleItemCount then
    Result := Result or cxSTATE_SYSTEM_INVISIBLE;
end;

procedure TdxNavBarNavigationPaneOverflowPanelItemAccessibilityHelper.Click(
  AKey: Word);
begin
  inherited Click(AKey);
  TdxCustomNavBarAccess(OwnerObjectControl).DoGroupMouseUp(Group);
end;

function TdxNavBarNavigationPaneOverflowPanelItemAccessibilityHelper.GetBounds: TRect;
begin
  Result := ViewInfo.OverflowPanelItems[ItemIndex].SelectionRect;
end;

function TdxNavBarNavigationPaneOverflowPanelItemAccessibilityHelper.IsClickKey(
  AKey: Word): Boolean;
begin
  Result := inherited IsClickKey(AKey) or (AKey in [VK_RETURN, VK_SPACE]);
end;

function TdxNavBarNavigationPaneOverflowPanelItemAccessibilityHelper.IsContainer: Boolean;
begin
  Result := False;
end;

function TdxNavBarNavigationPaneOverflowPanelItemAccessibilityHelper.GetGroup: TdxNavBarGroup;
begin
  Result := ViewInfo.OverflowPanelItems[ItemIndex].Group;
end;

function TdxNavBarNavigationPaneOverflowPanelItemAccessibilityHelper.GetViewInfo: TdxNavBarNavigationPaneViewInfo;
begin
  Result := TdxNavBarNavigationPaneOverflowPanelAccessibilityHelper(FOwnerObject).ViewInfo.ViewInfo;
end;

{ TdxNavBarNavigationPaneOverflowPanelSignAccessibilityHelper }

function TdxNavBarNavigationPaneOverflowPanelSignAccessibilityHelper.GetParent: TcxAccessibilityHelper;
begin
  Result := TcxAccessibilityHelper(FOwnerObject);
end;

function TdxNavBarNavigationPaneOverflowPanelSignAccessibilityHelper.GetState(
  AChildID: TcxAccessibleSimpleChildElementID): Integer;
begin
  Result := Parent.States[cxAccessibleObjectSelfID];
end;

// IdxNavBarAccessibilityHelper
procedure TdxNavBarNavigationPaneOverflowPanelSignAccessibilityHelper.Click(
  AKey: Word);
begin
  inherited Click(AKey);
  ViewInfo.DoShowPopupMenu(cxRectCenter(GetScreenBounds(cxAccessibleObjectSelfID)));
end;

function TdxNavBarNavigationPaneOverflowPanelSignAccessibilityHelper.GetBounds: TRect;
begin
  Result := ViewInfo.OverflowPanelSignRect;
end;

function TdxNavBarNavigationPaneOverflowPanelSignAccessibilityHelper.IsClickKey(
  AKey: Word): Boolean;
begin
  Result := inherited IsClickKey(AKey) or (AKey in [VK_RETURN, VK_SPACE]);
end;

function TdxNavBarNavigationPaneOverflowPanelSignAccessibilityHelper.IsContainer: Boolean;
begin
  Result := False;
end;

function TdxNavBarNavigationPaneOverflowPanelSignAccessibilityHelper.GetViewInfo: TdxNavBarNavigationPaneViewInfo;
begin
  Result := TdxNavBarNavigationPaneOverflowPanelAccessibilityHelper(FOwnerObject).ViewInfo.ViewInfo;
end;

{ TdxNavBarNavigationPaneActiveGroupCaptionPanelAccessibilityHelper }

function TdxNavBarNavigationPaneActiveGroupCaptionPanelAccessibilityHelper.GetParent: TcxAccessibilityHelper;
begin
  Result := NavBar.IAccessibilityHelper.GetHelper;
end;

function TdxNavBarNavigationPaneActiveGroupCaptionPanelAccessibilityHelper.GetState(
  AChildID: TcxAccessibleSimpleChildElementID): Integer;
begin
  Result := Parent.States[cxAccessibleObjectSelfID];
  if (NavBar.ActiveGroup = nil) or not NavBar.ActiveGroup.Visible or
    not NavBar.ShowGroupCaptions or (GroupViewInfo = nil) then
      Result := Result or cxSTATE_SYSTEM_INVISIBLE or cxSTATE_SYSTEM_UNAVAILABLE;
end;

function TdxNavBarNavigationPaneActiveGroupCaptionPanelAccessibilityHelper.CanBeFocusedByDefault: Boolean;
begin
  Result := True;
end;

function TdxNavBarNavigationPaneActiveGroupCaptionPanelAccessibilityHelper.GetAssociatedObject: TdxNavBarCustomAccessibilityHelper;
begin
  if Visible then
    Result := NavBar.ActiveGroup.CaptionPanelIAccessibilityHelper.GetNavBarHelper
  else
    Result := nil;
end;

function TdxNavBarNavigationPaneActiveGroupCaptionPanelAccessibilityHelper.GetBounds: TRect;
begin
  Result := GroupViewInfo.Rect;
end;

function TdxNavBarNavigationPaneActiveGroupCaptionPanelAccessibilityHelper.IsContainer: Boolean;
begin
  Result := False;
end;

function TdxNavBarNavigationPaneActiveGroupCaptionPanelAccessibilityHelper.GetGroupViewInfo: TdxNavBarGroupViewInfo;
var
  I: Integer;
begin
// Requires
  Assert(NavBar.ActiveGroup <> nil);
//
  Result := nil;
  for I := NavBarViewInfo.GetRealGroupStartIndex to NavBarViewInfo.GroupCount - 1 do
    if NavBar.ViewInfo.Groups[I].Group = NavBar.ActiveGroup then
    begin
      Result := NavBar.ViewInfo.Groups[I];
      Break;
    end;
end;

function TdxNavBarNavigationPaneActiveGroupCaptionPanelAccessibilityHelper.GetNavBar: TdxCustomNavBar;
begin
  Result := TdxNavBarOffice11NavPaneViewInfo(FOwnerObject).NavBar;
end;

function TdxNavBarNavigationPaneActiveGroupCaptionPanelAccessibilityHelper.GetNavBarViewInfo: TdxNavBarNavigationPaneViewInfo;
begin
  Result := TdxNavBarNavigationPaneViewInfo(NavBar.ViewInfo);
end;

{ TdxNavBarNavigationPaneHeaderSignAccessibilityHelper }

function TdxNavBarNavigationPaneHeaderSignAccessibilityHelper.GetParent: TcxAccessibilityHelper;
begin
  Result := TdxCustomNavBar(OwnerObjectControl).IAccessibilityHelper.GetHelper;
end;

function TdxNavBarNavigationPaneHeaderSignAccessibilityHelper.GetState(
  AChildID: TcxAccessibleSimpleChildElementID): Integer;
begin
  Result := Parent.States[cxAccessibleObjectSelfID];
  if not ViewInfo.Painter.Controller.Collapsible then
    Result := Result or cxSTATE_SYSTEM_INVISIBLE or cxSTATE_SYSTEM_UNAVAILABLE;
end;

procedure TdxNavBarNavigationPaneHeaderSignAccessibilityHelper.Click(AKey: Word);
begin
  inherited Click(AKey);
  ViewInfo.Painter.Controller.DoHeaderSignClick;
end;

function TdxNavBarNavigationPaneHeaderSignAccessibilityHelper.GetBounds: TRect;
begin
  Result := ViewInfo.HeaderSignRect;
end;

function TdxNavBarNavigationPaneHeaderSignAccessibilityHelper.IsClickKey(
  AKey: Word): Boolean;
begin
  Result := inherited IsClickKey(AKey) or (AKey in [VK_RETURN, VK_SPACE]);
end;

function TdxNavBarNavigationPaneHeaderSignAccessibilityHelper.IsContainer: Boolean;
begin
  Result := False;
end;

function TdxNavBarNavigationPaneHeaderSignAccessibilityHelper.GetViewInfo: TdxNavBarNavigationPaneViewInfo;
begin
  Result := TdxNavBarNavigationPaneViewInfo(FOwnerObject);
end;

{ TdxNavBarItemPanelAccessibilityHelper }

destructor TdxNavBarItemPanelAccessibilityHelper.Destroy;
begin
  NavBarAccessibleObjectOwnerObjectDestroyed(FCollapseBarIAccessibilityHelper);
  inherited Destroy;
end;

function TdxNavBarItemPanelAccessibilityHelper.GetChild(
  AIndex: Integer): TcxAccessibilityHelper;
begin
  if AIndex < inherited GetChildCount then
    Result := inherited GetChild(AIndex)
  else
    Result := CollapseBarIAccessibilityHelper.GetHelper;
end;

function TdxNavBarItemPanelAccessibilityHelper.GetChildCount: Integer;
begin
  Result := inherited GetChildCount + 1;
end;

function TdxNavBarItemPanelAccessibilityHelper.GetParent: TcxAccessibilityHelper;
begin
  Result := ViewInfo.NavBar.IAccessibilityHelper.GetHelper;
end;

function TdxNavBarItemPanelAccessibilityHelper.GetState(
  AChildID: TcxAccessibleSimpleChildElementID): Integer;
begin
  Result := Parent.States[cxAccessibleObjectSelfID];
  if not ViewInfo.Painter.Controller.Collapsed then
    Result := Result or cxSTATE_SYSTEM_INVISIBLE;
end;

function TdxNavBarItemPanelAccessibilityHelper.GetActualItemCount: Integer;
begin
  Result := ViewInfo.ItemCount;
end;

function TdxNavBarItemPanelAccessibilityHelper.GetBounds: TRect;
begin
  Result := ViewInfo.Rect;
end;

function TdxNavBarItemPanelAccessibilityHelper.GetCollapseBarAccessibilityHelperClass: TdxNavBarCustomAccessibilityHelperClass;
begin
  Result := TdxNavBarItemPanelCollapseBarAccessibilityHelper;
end;

function TdxNavBarItemPanelAccessibilityHelper.GetItemAccessibilityHelperClass: TdxNavBarItemCollectionItemAccessibilityHelperClass;
begin
  Result := TdxNavBarItemPanelItemAccessibilityHelper;
end;

function TdxNavBarItemPanelAccessibilityHelper.GetCollapseBarIAccessibilityHelper: IdxNavBarAccessibilityHelper;
begin
  if FCollapseBarIAccessibilityHelper = nil then
    FCollapseBarIAccessibilityHelper := NavBarGetAccessibilityHelper(
      GetCollapseBarAccessibilityHelperClass.Create(Self, OwnerObjectControl));
  Result := FCollapseBarIAccessibilityHelper;
end;

function TdxNavBarItemPanelAccessibilityHelper.GetViewInfo: TdxNavBarItemPanelViewInfo;
begin
  Result := TdxNavBarItemPanelViewInfo(FOwnerObject);
end;

{ TdxNavBarItemPanelCollapseBarAccessibilityHelper }

function TdxNavBarItemPanelCollapseBarAccessibilityHelper.GetParent: TcxAccessibilityHelper;
begin
  Result := TcxAccessibilityHelper(FOwnerObject);
end;

function TdxNavBarItemPanelCollapseBarAccessibilityHelper.GetState(
  AChildID: TcxAccessibleSimpleChildElementID): Integer;
begin
  Result := Parent.States[cxAccessibleObjectSelfID];
end;

function TdxNavBarItemPanelCollapseBarAccessibilityHelper.CanBeFocusedByDefault: Boolean;
begin
  Result := True;
end;

procedure TdxNavBarItemPanelCollapseBarAccessibilityHelper.Click(AKey: Word);
begin
  inherited Click(AKey);
  ViewInfo.Painter.Controller.ShowPopupControl;
end;

function TdxNavBarItemPanelCollapseBarAccessibilityHelper.GetBounds: TRect;
begin
  Result := ViewInfo.CollapseBarRect;
end;

function TdxNavBarItemPanelCollapseBarAccessibilityHelper.IsClickKey(
  AKey: Word): Boolean;
begin
  Result := inherited IsClickKey(AKey) or (AKey in [VK_RETURN, VK_SPACE]);
end;

function TdxNavBarItemPanelCollapseBarAccessibilityHelper.IsContainer: Boolean;
begin
  Result := False;
end;

function TdxNavBarItemPanelCollapseBarAccessibilityHelper.GetViewInfo: TdxNavBarItemPanelViewInfo;
begin
  Result := TdxNavBarItemPanelAccessibilityHelper(FOwnerObject).ViewInfo;
end;

{ TdxNavBarItemPanelItemAccessibilityHelper }

function TdxNavBarItemPanelItemAccessibilityHelper.GetParent: TcxAccessibilityHelper;
begin
  Result := TcxAccessibilityHelper(FOwnerObject);
end;

function TdxNavBarItemPanelItemAccessibilityHelper.GetState(
  AChildID: TcxAccessibleSimpleChildElementID): Integer;
begin
  Result := Parent.States[cxAccessibleObjectSelfID];
end;

function TdxNavBarItemPanelItemAccessibilityHelper.CanBeFocusedByDefault: Boolean;
begin
  Result := True;
end;

procedure TdxNavBarItemPanelItemAccessibilityHelper.Click(AKey: Word);
begin
  inherited Click(AKey);
  TdxNavBarControllerAccess(ViewInfo.Painter.Controller).DoLinkClick(ViewInfo.NavBar,
    ViewInfo.Items[ItemIndex].ItemLink);
end;

function TdxNavBarItemPanelItemAccessibilityHelper.GetBounds: TRect;
begin
  Result := ViewInfo.Items[ItemIndex].Rect;
end;

function TdxNavBarItemPanelItemAccessibilityHelper.IsClickKey(
  AKey: Word): Boolean;
begin
  Result := inherited IsClickKey(AKey) or (AKey in [VK_RETURN, VK_SPACE]);
end;

function TdxNavBarItemPanelItemAccessibilityHelper.IsContainer: Boolean;
begin
  Result := False;
end;

function TdxNavBarItemPanelItemAccessibilityHelper.GetViewInfo: TdxNavBarItemPanelViewInfo;
begin
  Result := TdxNavBarItemPanelAccessibilityHelper(FOwnerObject).ViewInfo;
end;

initialization
  RegisterView(dxNavBarOffice11TaskPaneView, 'Office11TaskPaneView', TdxNavBarOffice11Painter);
  RegisterView(dxNavBarOffice11ExplorerBarView, 'Office11ExplorerBarView', TdxNavBarOffice11ExplorerBarPainter);
  RegisterView(dxNavBarOffice11NavigatorPaneView, 'Office11NavigationPaneView', TdxNavBarOffice11NavPanePainter);

finalization
  UnRegisterView(dxNavBarOffice11TaskPaneView);
  UnRegisterView(dxNavBarOffice11ExplorerBarView);
  UnRegisterView(dxNavBarOffice11NavigatorPaneView);

end.
