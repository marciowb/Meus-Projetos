
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

unit cxPC;

{$I cxVer.inc}

interface

uses
  Windows, Messages, Classes, Controls, Forms, Graphics, ImgList, SysUtils, Contnrs,
  Menus, dxCore, cxClasses, cxControls, cxContainer, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters;

type
  TcxPCRectCorrection = record
    dLeft, dTop, dRight, dBottom: Integer;
  end;

  TcxPCOption = (pcoAlwaysShowGoDialogButton, pcoCloseButton,
    pcoFixedTabWidthWhenRotated, pcoGoDialog, pcoGradient,
    pcoGradientClientArea, pcoNoArrows, pcoRedrawOnResize, pcoSort,
    pcoTopToBottomText, pcoUsePageColorForTab);
  TcxPCOptions = set of TcxPCOption;
  TcxPCCloseButtonMode = (cbmNone, cbmActiveTab, cbmEveryTab);
  TcxPCNewButtonMode = (nbmNone, nbmTab);

const
  cxPCEmptyRectCorrection: TcxPCRectCorrection =
    (dLeft: 0; dTop: 0; dRight: 0; dBottom: 0);

  TabsContainerOffset = 2;
  TabsContainerBaseWidth = 3;

  cxPCNoStyle = -1;
  cxPCDefaultStyle = 0;
  cxPCDefaultStyleName = 'Default';

  cxPCNewButtonIndex = -2;

  cxPCDefaultOptions = [pcoAlwaysShowGoDialogButton, pcoGradient,
    pcoGradientClientArea, pcoRedrawOnResize];

  // hit test constants
  pchtNavigatorButton = 1;
  pchtTab = 2;
  pchtTabCloseButton = 3;

type
  TcxPCStyleID = -1 .. High(Integer);
  TcxPCStandardStyle = (tsTabs, tsButtons, tsFlatButtons);

  TcxTabPosition = (tpTop, tpBottom, tpLeft, tpRight);

  TcxTabSlantKind = (skCutCorner, skSlant);
  TcxTabSlantPosition = (spLeft, spRight);
  TcxTabSlantPositions = set of TcxTabSlantPosition;

  TcxCustomTabControl = class;
  TcxCustomTabControlProperties = class;
  TcxCustomTabControlPropertiesClass = class of TcxCustomTabControlProperties;
  TcxCustomTabControlController = class;
  TcxCustomTabControlHitTest = class;
  TcxTab = class;
  TcxPCNewButton = class;
  TcxTabViewInfo = class;
  TcxTabViewInfoClass = class of TcxTabViewInfo;
  TcxPageControl = class;
  TcxPCImageList = class;
  TcxTabSheet = class;

  // painters
  TcxPCCustomPainter = class;
  TcxPCPainterClass = class of TcxPCCustomPainter;

  // for cxGrid6 compatibility
  TcxPCOutTabImageAndTextData = record
    TabImageRect: TRect;
    TabTextRect: TRect;
    TabVisibleIndex: Integer;
  end;

  TcxPCPropertiesDrawTabEvent = procedure(AProperties: TcxCustomTabControlProperties; ATab: TcxTab;
    var DefaultDraw: Boolean) of object;
  TcxPCPropertiesDrawTabExEvent = procedure(AProperties: TcxCustomTabControlProperties; ATab: TcxTab;
    Font: TFont) of object;
  TcxGetTabImageEvent = procedure(Sender: TObject; TabIndex: Integer;
    var ImageIndex: Integer) of object;
  TcxPageChangingEvent = procedure(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean) of object;
  TcxPCCanCloseEventEx = procedure(Sender: TObject; ATabIndex: Integer; var ACanClose: Boolean) of object;
  TcxPCCloseEvent = procedure(Sender: TObject; ATabIndex: Integer) of object;
  TcxPCTabClickEvent = procedure(Sender: TObject; ATabVisibleIndex: Integer; AShift: TShiftState) of object;
  TcxTabChangedEvent = procedure(Sender: TObject; TabID: Integer) of object;
  TcxTabChangingEvent = procedure(Sender: TObject; var AllowChange: Boolean) of object;

  TcxTabAfterPaintEvent = procedure(ACanvas: TcxCanvas; ATab: TcxTab;
    AImageAndTextData: TcxPCOutTabImageAndTextData) of object; // for cxGrid6 compatibility

  TcxPCNavigatorButton = (nbTopLeft, nbBottomRight, nbGoDialog, nbClose);
  TcxPCNavigatorButtons = set of TcxPCNavigatorButton;
  TcxPCNavigatorButtonIndex = TcxPCNavigatorButtons;
  TcxPCNavigatorButtonState = (nbsNormal, nbsPressed, nbsHotTrack, nbsDisabled);
  TcxPCNavigatorPosition = (npLeftTop, npLeftBottom, npRightTop, npRightBottom);

  TcxPCTabsPosition = record
    ExtendedTabsRect: TRect;
    ExtendedTopOrLeftTabsRectBottomOrRightBorderOffset: Integer;
    ExtendedBottomOrRightTabsRectTopOrLeftBorderOffset: Integer;
    MinDistanceBetweenTopOrLeftAndBottomOrRightExtendedTabsRects: Integer;
    NormalRowWidth: Integer;
    NormalTabsRect: TRect;
  end;

  TcxPCWOffset = record
    Left, Right: Integer;
  end;

  TcxPCDistance = record
    dw, dh: Integer;
  end;

  TcxPCIndexInterval = record
    Left, Right: Integer;
  end;
  TcxPCLineIndexBoundsArray = array of TcxPCIndexInterval;

  TcxPCTabIndex = Integer;

  TcxPCTabPropertyChanged = (tpcNotSpecified, tpcColor, tpcEnabled, tpcFocused,
    tpcHighlighted, tpcHotTrack, tpcIsMainTab, tpcLayout, tpcPressed,
    tpcSelected, tpcTracking, tpcVisible);

  TcxPCTabNotification = (tnDeleting);

  TcxPCImageListRotatedImagesElement = record
    BackgroundColor: TColor;
    Bitmap: TcxBitmap;
    IsBackgroundColorSpecified: Boolean;
  end;
  TcxPCImageListRotatedImagesElementArray =
    array of TcxPCImageListRotatedImagesElement;

  TcxTabs = class;
  TcxTabSlants = class;

  // View Infos
  TcxTabsViewInfo = class;
  TcxCustomTabControlViewInfo = class;

  IcxControlComponentState = interface
  ['{E29BF582-E8C0-4868-A799-DB4C41AC3BC8}']
    function IsDesigning: Boolean;
    function IsDestroying: Boolean;
    function IsLoading: Boolean;
  end;

  { IcxTabControl }

  IcxTabControl = interface(IcxControlComponentState)
  ['{8C8C2262-5419-46E1-BCE0-5A5311C330A0}']
    function GetController: TcxCustomTabControlController;
    function GetPainter: TcxPCCustomPainter;
    function GetProperties: TcxCustomTabControlProperties;
    function GetViewInfo: TcxCustomTabControlViewInfo;

    function CanDrawParentBackground: Boolean;
    function GetBoundsRect: TRect;
    function GetCanvas: TcxCanvas;
    function GetControl: TWinControl;
    function GetColor: TColor;
    function GetDragAndDropObject: TcxDragAndDropObject;
    function GetDragAndDropState: TcxDragAndDropState;
    function GetFont: TFont;
    function GetLookAndFeel: TcxLookAndFeel;
    procedure InvalidateRect(const R: TRect; AEraseBackground: Boolean);
    procedure SetModified;

    function IsEnabled: Boolean;
    function IsFocused: Boolean;
    function IsParentBackground: Boolean;

    procedure RequestLayout;

    property Controller: TcxCustomTabControlController read GetController;
    property Painter: TcxPCCustomPainter read GetPainter;
    property Properties: TcxCustomTabControlProperties read GetProperties;
    property ViewInfo: TcxCustomTabControlViewInfo read GetViewInfo;
  end;

  { TcxPCCustomElementViewInfo }

  TcxPCCustomElementViewInfo = class
  private
    FBounds: TRect;
  protected
    function GetHitTest(AHitTest: TcxCustomTabControlHitTest): Boolean; virtual;
    function GetHitTestIndex: Integer; virtual; abstract;
    function GetControlViewInfo: TcxCustomTabControlViewInfo; virtual; abstract;
    function PtInElement(const APoint: TPoint): Boolean; virtual;
    procedure SetHitTest(AHitTest: TcxCustomTabControlHitTest); virtual;
  public
    property Bounds: TRect read FBounds write FBounds;
    property ControlViewInfo: TcxCustomTabControlViewInfo read GetControlViewInfo;
  end;

  {TcxPCCustomButtonViewInfo}

  TcxPCCustomButtonViewInfo = class(TcxPCCustomElementViewInfo)
  private
    FState: TcxPCNavigatorButtonState;
  protected
    procedure Invalidate; virtual;
    function GetAbsoluteBounds: TRect; virtual;
    function PtInElement(const APoint: TPoint): Boolean; override;
    procedure SetState(AValue: TcxPCNavigatorButtonState); virtual;
    property AbsoluteBounds: TRect read GetAbsoluteBounds;
  public
    destructor Destroy; override;
    property State: TcxPCNavigatorButtonState read FState write SetState;
  end;

  {TcxPCTabCloseButtonViewInfo}

   TcxPCTabCloseButtonViewInfo = class(TcxPCCustomButtonViewInfo)
   private
     FTabViewInfo: TcxTabViewInfo;
   protected
     function GetHitTestIndex: Integer; override;
     function GetAbsoluteBounds: TRect; override;
     function GetControlViewInfo: TcxCustomTabControlViewInfo; override;
   public
     constructor Create(ATabViewInfo: TcxTabViewInfo);
   end;

  { TcxPCNavigatorButtonViewInfo }

  TcxPCNavigatorButtonViewInfo = class(TcxPCCustomButtonViewInfo)
  private
    FButtonType: TcxPCNavigatorButton;
    FTabControlViewInfo: TcxCustomTabControlViewInfo;
  protected
    function GetHitTestIndex: Integer; override;
    function GetControlViewInfo: TcxCustomTabControlViewInfo; override;
  public
    constructor Create(ATabControlViewInfo: TcxCustomTabControlViewInfo;
      AButtonType: TcxPCNavigatorButton);
    destructor Destroy; override;

    property ButtonType: TcxPCNavigatorButton read FButtonType;
  end;

  { TcxTabViewInfo }

  TcxTabViewInfo = class(TcxPCCustomElementViewInfo)
  private
    FCloseButtonInfo: TcxPCTabCloseButtonViewInfo;
    FTab: TcxTab;
    FTabsViewInfo: TcxTabsViewInfo;

    FNormalPosition: TPoint;
    FNormalWidth: Integer; // Height is in TcxTabs
    FRow: Integer;
    FVisibleRow: Integer;

    FContentRect: TRect;
    FImageRect: TRect;
    FIsTextTooLong: Boolean;
    FTextRect: TRect;

    procedure TabDestroyHandler(Sender: TObject; const AEventArgs);

    function GetCanvas: TcxCanvas;
    function GetCaption: string;
    function GetCloseButtonInfo: TcxPCTabCloseButtonViewInfo;
    function GetCloseButtonRect: TRect;
    function GetColor: TColor;
    function GetContentOffset: TcxPCWOffset;
    function GetFullRect: TRect;
    function GetEnabled: Boolean;
    function GetImageAreaWidth: Integer;
    function GetIndex: Integer;
    function GetImageIndex: Integer;
    function GetNormalLongitudinalSize: Integer;
    function GetNormalRect: TRect;
    function GetPainter: TcxPCCustomPainter;
    function GetPaintingPosition: TcxTabPosition;
    function GetPaintingPositionIndex: Integer;
    function GetProperties: TcxCustomTabControlProperties;
    function GetAbsolutePartRect(const APartRect: TRect): TRect;
    function GetTabRect: TRect;
    function GetTabImageAndTextRect: TRect;
    function GetVisibleIndex: Integer;
    function GetVisibleRect: TRect;
    function IsImagesAssigned: Boolean;
    procedure SetCloseButtonRect(const Value: TRect);
  protected
    procedure PrepareCanvasFont(ACanvas: TcxCanvas);

    procedure CalculateAngleDependentPartBounds(var ACalcRect: TRect;
      const APartHeight: Integer; ADrawOffset: TRect);
    procedure CalculateCloseButtonHorizontalPosition;
    procedure CalculateCloseButtonVerticalPosition;
    procedure CalculateContentRect;
    procedure CalculateImageAndTextHorizontalPositions;
    procedure CalculateImageHorizontalPosition;
    procedure CalculateImageVerticalPosition;
    procedure CalculateIsTextTooLong;
    procedure CalculateHorizontalPositions;
    procedure CalculateTextVerticalPosition;
    function GetContentHorizontalOffset(ATabWidth, AContentWidth: Integer): Integer;

    function GetControlViewInfo: TcxCustomTabControlViewInfo; override;
    function GetScrollingArea: TRect;
    function GetHitTestIndex: Integer; override;
    function PtInElement(const APoint: TPoint): Boolean; override;
    procedure SetHitTest(AHitTest: TcxCustomTabControlHitTest); override;

    function CanClick: Boolean; virtual;
    function CanFocus: Boolean; virtual;
    function CanMultiSelect: Boolean; virtual;
    function CanSelect: Boolean; virtual;
    procedure Click(AShift: TShiftState);
    procedure DoHandleDialogChar(Key: Integer); virtual;
    procedure DoSelect(AAddToSelected: Boolean); virtual;
    procedure DoSetFocus; virtual;
    procedure DoClick(AShift: TShiftState); virtual;
    function HandleDialogChar(Key: Integer): Boolean;
    procedure Select(AAddToSelected: Boolean);
    procedure SetFocus;

    function IsNewButton: Boolean;
    function IsPressable: Boolean; virtual;

    property Canvas: TcxCanvas read GetCanvas;
    property CloseButtonRect: TRect read GetCloseButtonRect write SetCloseButtonRect;
    property NormalLongitudinalSize: Integer read GetNormalLongitudinalSize;
    property NormalPosition: TPoint read FNormalPosition write FNormalPosition;
    property NormalWidth: Integer read FNormalWidth write FNormalWidth;
  public
    constructor Create(ATab: TcxTab; ATabsViewInfo: TcxTabsViewInfo); virtual;
    destructor Destroy; override;

    function ActuallyEnabled: Boolean;
    function ActuallyVisible: Boolean;
    function HasCaption: Boolean;
    function HasCloseButton: Boolean; virtual;
    function HasImage: Boolean;
    function IsActive: Boolean;
    function IsFocused: Boolean;
    function IsHighlighted: Boolean;
    function IsHotTrack: Boolean;
    function IsMainTab: Boolean;
    function IsPressed: Boolean;
    function IsSelected: Boolean;
    function IsTracking: Boolean;
    function IsVisibleForGoDialog: Boolean; virtual;

    function IsCloseButtonPlacedFirst: Boolean;
    function GetDefinedWidth: Integer; virtual;
    function GetRelativeTextRotationAngle: TcxRotationAngle;

    procedure CalculateNormalWidth;
    procedure CalculateParts;
    procedure CorrectTabNormalWidth(var AValue: Integer); virtual;

    property Caption: string read GetCaption;
    property CloseButtonInfo: TcxPCTabCloseButtonViewInfo read GetCloseButtonInfo;
    property Color: TColor read GetColor;
    property Enabled: Boolean read GetEnabled;
    property FullRect: TRect read GetFullRect;
    property ImageIndex: Integer read GetImageIndex;
    property ImageRect: TRect read FImageRect;
    property Index: Integer read GetIndex;
    property NormalRect: TRect read GetNormalRect;
    property Painter: TcxPCCustomPainter read GetPainter;
    property PaintingPosition: TcxTabPosition read GetPaintingPosition;
    property PaintingPositionIndex: Integer read GetPaintingPositionIndex;
    property Properties: TcxCustomTabControlProperties read GetProperties;
    property Tab: TcxTab read FTab;
    property TabsViewInfo: TcxTabsViewInfo read FTabsViewInfo;
    property TextRect: TRect read FTextRect;
    property VisibleIndex: Integer read GetVisibleIndex;
    property VisibleRect: TRect read GetVisibleRect;
    property VisibleRow: Integer read FVisibleRow;
  end;

  { TcxPCNewButtonViewInfo }

  TcxPCNewButtonViewInfo = class(TcxTabViewInfo)
  private
    function GetButton: TcxPCNewButton;
  protected
    function CanClick: Boolean; override;
    function CanFocus: Boolean; override;
    function CanMultiSelect: Boolean; override;
    function CanSelect: Boolean; override;
    procedure DoClick(AShift: TShiftState); override;

    property Button: TcxPCNewButton read GetButton;
  public
    procedure CorrectTabNormalWidth(var AValue: Integer); override;
    function GetDefinedWidth: Integer; override;
    function HasCloseButton: Boolean; override;
    function IsVisibleForGoDialog: Boolean; override;
  end;

  { TcxTabsViewInfo }

  TcxTabsViewInfo = class
  private
    FControlViewInfo: TcxCustomTabControlViewInfo;
    FTabs: TcxTabs;
    FViewInfos: TObjectList;

    FNeedCheckTabIndex: Boolean;
    FNeedRecreateViewInfos: Boolean;

    FTabNormalHeight: Integer;

    procedure TabsChangedHandler(Sender: TObject; const AEventArgs);
    procedure TabsDestroyHandler(Sender: TObject; const AEventArgs);

    function GetViewInfoCount: Integer;
    function GetViewInfo(Index: Integer): TcxTabViewInfo;
  protected
    procedure AddViewInfo(AViewInfo: TcxTabViewInfo);
    function GetMaxMainTabIndex: Integer;
    function IndexOf(AViewInfo: TcxTabViewInfo): Integer;

    procedure CreateViewInfos; virtual;
    procedure DestroyViewInfos; virtual;
    procedure RecreateViewInfos;

    procedure CheckTabIndex;

    function CalculateHitTest(AHitTest: TcxCustomTabControlHitTest): Boolean;
    procedure RepaintTab(ATabVisibleIndex: Integer; ATabPropertyChanged: TcxPCTabPropertyChanged);

    function HandleDialogChar(Key: Integer): Boolean;

    property TabNormalHeight: Integer read FTabNormalHeight;
  public
    constructor Create(ATabs: TcxTabs; AControlViewInfo: TcxCustomTabControlViewInfo); virtual;
    destructor Destroy; override;

    procedure CalculateNormalSizes;
    procedure CalculateTabParts;
    function GetTabDefaultHeight: Integer; virtual;

    property ControlViewInfo: TcxCustomTabControlViewInfo read FControlViewInfo;
    property Tabs: TcxTabs read FTabs;
    property ViewInfoCount: Integer read GetViewInfoCount;
    property ViewInfos[Index: Integer]: TcxTabViewInfo read GetViewInfo; default;
  end;
  TcxTabsViewInfoClass = class of TcxTabsViewInfo;

  { TcxCustomTabControlViewInfo }

  TcxCustomTabControlViewInfo = class
  private
    FExtendedBottomOrRightTabsRect: TRect;
    FExtendedTopOrLeftTabsRect: TRect;
    FFirstVisibleTab: Integer;
    FFocusedTabVisibleIndex: Integer;
    FIControl: IcxTabControl;
    FLastVisibleTab: Integer;
    FHotTrackTabCloseButton: TcxPCTabCloseButtonViewInfo;
    FHotTrackNavigatorButton: TcxPCNavigatorButtonViewInfo;
    FHotTrackTabVisibleIndex: Integer;
    FIsLastTabFullyVisible: Boolean;
    FMainTabVisibleIndex: Integer;
    FMaxTabCaptionWidth: Integer;
    FOwner: TObject;
    FPressedNavigatorButton: TcxPCNavigatorButtonViewInfo;
    FPressedTabCloseButton: TcxPCTabCloseButtonViewInfo;
    FPressedTabVisibleIndex: Integer;
    FRowCount: Integer;
    FRowHeight: Integer;
    FTabsPosition: TcxPCTabsPosition;
    FTabsViewInfo: TcxTabsViewInfo;
    FTopOrLeftPartRowCount: Integer;
    FTrackingTabVisibleIndex: Integer;
    FUpdating: Boolean;
    FOnAfterPaintTab: TcxTabAfterPaintEvent;

    FNavigatorButtons: TcxPCNavigatorButtons;
    FNavigatorButtonInfos: TObjectList;

    function CanPressButton(AButton: TcxPCNavigatorButton): Boolean;
    function GetBoundsRect: TRect;
    function GetCanvas: TcxCanvas;
    function GetClientRect: TRect;
    function GetControlBounds: TRect;
    function GetController: TcxCustomTabControlController;
    function GetColor: TColor;
    function GetFocusedTabVisibleIndex: Integer;
    function GetFont: TFont;
    function GetHideTabs: Boolean;
    function GetHeight: Integer;
    function GetImageBorder: Integer;
    function GetLineWidth(const ALineIndexBoundsA: TcxPCLineIndexBoundsArray; ALineNumber, ATabsDistance: Integer): Integer;
    function GetMainTabIndex: Integer;
    function GetMultiLine: Boolean;
    function GetNavigatorButtonCount: Integer;
    function GetNavigatorButtonInfos(Index: Integer): TcxPCNavigatorButtonViewInfo;
    function GetNavigatorButtons: TcxPCNavigatorButtons;
    function GetNavigatorPosition: TcxPCNavigatorPosition;
    function GetOptions: TcxPCOptions;
    function GetPainter: TcxPCCustomPainter;
    function GetProperties: TcxCustomTabControlProperties;
    function GetPageClientRect: TRect;
    function GetPageClientRectOffset: TRect;
    function GetPageFrameRect: TRect;
    function GetPageFrameRectOffset: TRect;
    function GetRaggedRight: Boolean;
    function GetShowFrame: Boolean;
    function GetTabHeight: Smallint;
    function GetTabPosition: TcxTabPosition;
    function GetTabSlants: TcxTabSlants;
    function GetTabWidth: Smallint;
    function GetWidth: Integer;
    procedure RearrangeRows;
    procedure SetFocusedTabVisibleIndex(Value: Integer);
    procedure SetHotTrackTabCloseButton(const Value: TcxPCTabCloseButtonViewInfo);
    procedure SetHotTrackNavigatorButton(
      const Value: TcxPCNavigatorButtonViewInfo);
    procedure SetHotTrackTabVisibleIndex(Value: Integer);
    procedure SetMainTabVisibleIndex(Value: Integer);
    procedure SetNavigatorButtons(const Value: TcxPCNavigatorButtons);
    procedure SetPressedNavigatorButton(
      const Value: TcxPCNavigatorButtonViewInfo);
    procedure SetPressedTabCloseButton(
      const Value: TcxPCTabCloseButtonViewInfo);
    procedure SetPressedTabVisibleIndex(Value: Integer);
    procedure SetTrackingTabVisibleIndex(Value: Integer);
    procedure SynchronizeHotTrackStates(Shift: TShiftState);
    procedure UpdateButtonsState;
    procedure UpdateTabPosition(ANavigatorButtons: TcxPCNavigatorButtons);
  protected
    function GetTabViewInfo(ATab: TcxTab): TcxTabViewInfo;
    function GetTabVisibleIndex(ATab: TcxTab): Integer;

    function CanFocusOnClick(X, Y: Integer): Boolean; virtual;
    function GetPainterClass: TcxPCPainterClass; virtual;

    procedure CalculateHitTest(AHitTest: TcxCustomTabControlHitTest);
    procedure CalculateLongitudinalTabPositions;
    procedure CalculateRowHeight;
    procedure CalculateRowPositions;
    procedure DoCalculate; virtual;

    function GetTabIndex: Integer; virtual;
    procedure SetTabIndex(Value: Integer); virtual;

    procedure AfterPaintTab(ACanvas: TcxCanvas; ATab: TcxTab; AImageAndTextData: TcxPCOutTabImageAndTextData); virtual;
    function ArrowButtonClick(ANavigatorButton: TcxPCNavigatorButton): Boolean;
    procedure ElementDestroying(AElementInfo: TcxPCCustomElementViewInfo);
    procedure CorrectFirstVisibleTab(ATabVisibleIndex: Integer);
    function GetActivePageColor: TColor; virtual;
    function GetNavigatorButtonInfoByType(AType: TcxPCNavigatorButton): TcxPCNavigatorButtonViewInfo;
    function GetNextFocusedTabVisibleIndex(ACurrentTabVisibleIndex, ADelta: Integer; ACycle: Boolean; AOnlyAllowSelectedTabs: Boolean): Integer;
    function GetTabColor(ATabVisibleIndex: Integer): TColor; virtual;
    function GetTabExtendedTabsRect(ATabViewInfo: TcxTabViewInfo): TRect; overload;
    function GetTabExtendedTabsRect(ATabVisibleIndex: Integer): TRect; overload;
    function GetTabImageAreaWidth: Integer;
    function GetTabImageAreaHeight: Integer;
    procedure InitializeLineBoundsA(var ALineIndexBoundsA: TcxPCLineIndexBoundsArray; AFirstIndex, ALastIndex: Integer);
    function HasActivePage: Boolean; virtual;
    function HasBorders: Boolean; virtual;
    procedure MakeTabVisible(ATabVisibleIndex: Integer);
    procedure PlaceVisibleTabsOnRows(ATabsWidth, ATabsDistance: Integer);
    procedure RepaintTab(ATabVisibleIndex: Integer; ATabPropertyChanged: TcxPCTabPropertyChanged);
    procedure SetMainTab;
    procedure TabDown(ATabVisibleIndex: Integer; AShift: TShiftState);
    procedure TabUp(ATabVisibleIndex: Integer; AShift: TShiftState);
    function UseActivePageColor: Boolean; virtual;
    procedure DestroyTabs;

    function ActuallyRotatedTabsMaxWidth: Integer;
    function AllowHotTrack: Boolean;
    function AllowMultiSelect: Boolean;
    function CanMouseWheel(const AMousePos: TPoint): Boolean;
    function PtInTab(ATabVisibleIndex: Integer; X, Y: Integer): Boolean;
    function IsFullVisible(ATabVisibleIndex: Integer): Boolean;
    function IsSpecialAlignment: Boolean;
    function IsTooSmallControlSize: Boolean;
    function IsTabActuallyVisible(ATabViewInfo: TcxTabViewInfo): Boolean;
    function IsTabImagesAssigned: Boolean;
    function IsTabVisibleIndexValid(AIndex: Integer): Boolean;
    function PtInScrollingArea(const P: TPoint; var ADirection: Integer): Boolean;

    property Controller: TcxCustomTabControlController read GetController;
    property HotTrackNavigatorButton: TcxPCNavigatorButtonViewInfo read FHotTrackNavigatorButton
      write SetHotTrackNavigatorButton;
    property HotTrackTabCloseButton: TcxPCTabCloseButtonViewInfo read FHotTrackTabCloseButton
      write SetHotTrackTabCloseButton;
    property HotTrackTabVisibleIndex: Integer read FHotTrackTabVisibleIndex write SetHotTrackTabVisibleIndex;
    property LastVisibleTab: Integer read FLastVisibleTab write FLastVisibleTab;
    property MainTabIndex: Integer read GetMainTabIndex;
    property Owner: TObject read FOwner;
    property PageFrameRect: TRect read GetPageFrameRect;
    property PageFrameRectOffset: TRect read GetPageFrameRectOffset;
    property Painter: TcxPCCustomPainter read GetPainter;
    property PressedNavigatorButton: TcxPCNavigatorButtonViewInfo read FPressedNavigatorButton
      write SetPressedNavigatorButton;
    property PressedTabCloseButton: TcxPCTabCloseButtonViewInfo read FPressedTabCloseButton
      write SetPressedTabCloseButton;
    property PressedTabVisibleIndex: Integer read FPressedTabVisibleIndex write SetPressedTabVisibleIndex;
    property RowHeight: Integer read FRowHeight;
    property TrackingTabVisibleIndex: Integer read FTrackingTabVisibleIndex write SetTrackingTabVisibleIndex;
    property OnAfterPaintTab: TcxTabAfterPaintEvent read FOnAfterPaintTab write FOnAfterPaintTab; // for cxGrid6 compatibility
  public
    constructor Create(AOwner: TObject); virtual;
    destructor Destroy; override;

    procedure Calculate;

    function ActuallyRotate: Boolean;
    function CanDrawParentBackground: Boolean;
    function GetTabImageSize: TSize;
    function GetOptimalSize: Integer;
    function GetLookAndFeel: TcxLookAndFeel;
    function GetTextRotationAngle: TcxRotationAngle;
    function HasTabCloseButtons: Boolean;
    function IndexOfTabAt(X, Y: Integer): Integer;
    procedure InitializeLineBoundsArray(var ALineIndexBoundsA: TcxPCLineIndexBoundsArray);
    procedure InitializeVisibleTabRange(var AFirstIndex, ALastIndex: Integer);
    procedure InvalidateRect(const R: TRect; EraseBackground: Boolean);
    function IsBottomToTopAlignment: Boolean;
    function IsEnabled: Boolean;
    function IsFocused: Boolean;
    function IsNativePainting: Boolean;
    function IsRightToLeftAlignment: Boolean;
    function IsTabsContainer: Boolean;
    function IsTabsOnBothSides: Boolean;
    function IsVerticalText: Boolean;
    function ParentBackground: Boolean;
    procedure PrepareTabCanvasFont(ATabViewInfo: TcxTabViewInfo; ACanvas: TcxCanvas); virtual;
    function VisibleIndexOfTabAt(X, Y: Integer): Integer;

    property BoundsRect: TRect read GetBoundsRect;
    property Canvas: TcxCanvas read GetCanvas;
    property ClientRect: TRect read GetClientRect;
    property IControl: IcxTabControl read FIControl;
    property ControlBounds: TRect read GetControlBounds;
    property Color: TColor read GetColor;
    property FirstVisibleTab: Integer read FFirstVisibleTab write FFirstVisibleTab;
    property FocusedTabVisibleIndex: Integer read GetFocusedTabVisibleIndex write SetFocusedTabVisibleIndex;
    property Font: TFont read GetFont;
    property HideTabs: Boolean read GetHideTabs;
    property Height: Integer read GetHeight;
    property ImageBorder: Integer read GetImageBorder;
    property MainTabVisibleIndex: Integer read FMainTabVisibleIndex write SetMainTabVisibleIndex;
    property MultiLine: Boolean read GetMultiLine;
    property NavigatorButtonCount: Integer read GetNavigatorButtonCount;
    property NavigatorButtonInfoByType[AType: TcxPCNavigatorButton]: TcxPCNavigatorButtonViewInfo
      read GetNavigatorButtonInfoByType;
    property NavigatorButtonInfos [Index: Integer]: TcxPCNavigatorButtonViewInfo read GetNavigatorButtonInfos;
    property NavigatorButtons: TcxPCNavigatorButtons read GetNavigatorButtons write SetNavigatorButtons;
    property NavigatorPosition: TcxPCNavigatorPosition read GetNavigatorPosition;
    property Options: TcxPCOptions read GetOptions;
    property Properties: TcxCustomTabControlProperties read GetProperties;
    property PageClientRect: TRect read GetPageClientRect;
    property PageClientRectOffset: TRect read GetPageClientRectOffset;
    property RaggedRight: Boolean read GetRaggedRight;
    property RowCount: Integer read FRowCount;
    property ShowFrame: Boolean read GetShowFrame;
    property TabColors[ATabVisibleIndex: Integer]: TColor read GetTabColor;
    property TabHeight: Smallint read GetTabHeight;
    property TabIndex: Integer read GetTabIndex write SetTabIndex;
    property TabPosition: TcxTabPosition read GetTabPosition;
    property TabSlants: TcxTabSlants read GetTabSlants;
    property TabsViewInfo: TcxTabsViewInfo read FTabsViewInfo;
    property TabWidth: Smallint read GetTabWidth;
    property TopOrLeftPartRowCount: Integer read FTopOrLeftPartRowCount;
    property Width: Integer read GetWidth;
  end;
  TcxCustomTabControlViewInfoClass = class of TcxCustomTabControlViewInfo;

  TcxTab = class(TPersistent)
  private
    FCaption: string; // type of TStrings' item
    FColor: TColor;
    FDestroyHandlers: TcxEventHandlerCollection;
    FEnabled: Boolean;
    FImageIndex: TImageIndex;
    FObject: TObject;

    FSelected: Boolean;
    FHighlighted: Boolean;

    FTabs: TcxTabs;
    FVisible: Boolean;
    function GetFullRect: TRect;
    function GetHotTrack: Boolean;
    function GetImageIndex: TImageIndex;
    function GetIsMainTab: Boolean;
    function GetPressed: Boolean;
    function GetProperties: TcxCustomTabControlProperties;
    function GetRealVisible: Boolean;
    function GetTracking: Boolean;

    function GetControlViewInfo: TcxCustomTabControlViewInfo;
    function GetViewInfo: TcxTabViewInfo;

    function GetVisibleIndex: Integer;
    function GetVisibleRect: TRect;
    function GetVisibleRow: Integer;
    procedure InternalSetCaption(const Value: string);
    procedure SetCaption(const Value: string);
    procedure SetColor(Value: TColor);
    procedure SetEnabled(const Value: Boolean);
    procedure SetHighlighted(const Value: Boolean);
    procedure SetImageIndex(Value: TImageIndex);
    procedure SetSelected(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure Changed(ATabPropertyChanged: TcxPCTabPropertyChanged);
    procedure DoDestroy; virtual;
    function GetViewInfoClass: TcxTabViewInfoClass; virtual;
    function GetIndex: Integer; virtual;
    function IsNewButton: Boolean; virtual;

    property DestroyHandlers: TcxEventHandlerCollection read FDestroyHandlers;
    property Properties: TcxCustomTabControlProperties read GetProperties;
    property Tabs: TcxTabs read FTabs;
  public
    constructor Create(ATabs: TcxTabs); virtual;
    destructor Destroy; override;

    property Caption: string read FCaption write SetCaption;
    property Color: TColor read FColor write SetColor;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property FullRect: TRect read GetFullRect;
    property Highlighted: Boolean read FHighlighted write SetHighlighted;
    property HotTrack: Boolean read GetHotTrack;
    property ImageIndex: TImageIndex read GetImageIndex write SetImageIndex;
    property Index: Integer read GetIndex;
    property IsMainTab: Boolean read GetIsMainTab;
    property Pressed: Boolean read GetPressed;
    property RealVisible: Boolean read GetRealVisible;
    property Selected: Boolean read FSelected write SetSelected;
    property Tracking: Boolean read GetTracking;
    property Visible: Boolean read FVisible write SetVisible;
    property VisibleIndex: Integer read GetVisibleIndex;
    property VisibleRect: TRect read GetVisibleRect;
    property VisibleRow: Integer read GetVisibleRow;
  end;

  { TcxPCNewButton }

  TcxPCNewButton = class(TcxTab)
  private
    FWidth: Integer;
    procedure SetWidth(Value: Integer);
  protected
    function GetViewInfoClass: TcxTabViewInfoClass; override;
    function GetIndex: Integer; override;
    procedure DoDestroy; override;
    function IsNewButton: Boolean; override;
  public
    constructor Create(ATabs: TcxTabs); override;

    property Width: Integer read FWidth write SetWidth;
  end;
  TcxPCNewButtonClass = class of TcxPCNewButton;

  TcxTabs = class(TStrings)
  private
    FChangedHandlers: TcxEventHandlerCollection;
    FDestroyHandlers: TcxEventHandlerCollection;
    FIsTabsCleaning: Boolean;
    FNewButton: TcxPCNewButton;
    FProperties: TcxCustomTabControlProperties;
    FTabItems: TObjectList;
    function GetTab(TabIndex: Integer): TcxTab;
    function GetVisibleTab(ATabVisibleIndex: Integer): TcxTab;
    procedure SetTab(Index: Integer; const Value: TcxTab);
    function GetVisibleTabsCount: Integer;

    function GetControlViewInfo: TcxCustomTabControlViewInfo;
    function GetViewInfo: TcxTabsViewInfo;
  protected
    function Get(Index: Integer): string; override;
    function GetCount: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure Put(Index: Integer; const S: string); override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;

    procedure Changed(ATab: TcxTab = nil; ATabPropertyChanged: TcxPCTabPropertyChanged = tpcLayout);
    function GetViewInfoClass: TcxTabsViewInfoClass; virtual;
    function GetNewButtonClass: TcxPCNewButtonClass; virtual;

    procedure CreateNewButton; virtual;
    procedure DestroyNewButton; virtual;
    procedure RemoveTab(ATab: TcxTab);

    property ChangedHandlers: TcxEventHandlerCollection read FChangedHandlers;
    property DestroyHandlers: TcxEventHandlerCollection read FDestroyHandlers;
    property NewButton: TcxPCNewButton read FNewButton;
    property Properties: TcxCustomTabControlProperties read FProperties;
    property TabItems: TObjectList read FTabItems;
  public
    constructor Create(AProperties: TcxCustomTabControlProperties);
    destructor Destroy; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure Move(CurIndex, NewIndex: Integer); override;

    property Tabs[TabIndex: Integer]: TcxTab read GetTab write SetTab; default;
    property VisibleTabsCount: Integer read GetVisibleTabsCount;
    property VisibleTabs[TabVisibleIndex: Integer]: TcxTab read GetVisibleTab;
  end;

  TcxPCCustomPainter = class
  private
    FViewInfo: TcxCustomTabControlViewInfo;
    FIsDragImagePainted: Boolean;
    function GetDisabledTextFaceColor: TColor;
    function GetDisabledTextShadowColor: TColor;
    function GetHighlightedTabBodyColor: TColor;
    function GetImagePainter: TcxPCImageList;
    function GetTabViewInfo(Index: Integer): TcxTabViewInfo;
  protected
    class function AllowRotate: Boolean; virtual;
    function CalculateTabNormalWidth(ATabViewInfo: TcxTabViewInfo): Integer; virtual; abstract;
    function CanDrawParentBackground: Boolean; virtual;
    procedure CorrectTabContentVerticalOffset(ATabVisibleIndex: Integer; var ADrawOffset: TRect); virtual;
    procedure CorrectTabNormalWidth(var AValue: Integer); virtual;
    function GetDropArrowRects(ADragTabVisibleIndex, AHitTabVisibleIndex,
      ADestinationTabVisibleIndex: Integer): TRects;
    function GetTabCorrection(ATabVisibleIndex: Integer): TcxPCRectCorrection; virtual;
    procedure DirectionalPolyline(ACanvas: TcxCanvas; const R: TRect; APoints: array of TPoint;
      ATabPosition: TcxTabPosition; AColor: TColor);
    function DoCustomDraw(TabVisibleIndex: Integer): Boolean;
    procedure DoDrawBackground(ACanvas: TcxCanvas); virtual;
    procedure DrawBackground(ACanvas: TcxCanvas);
    procedure DrawFocusRect(ACanvas: TcxCanvas; ATabVisibleIndex: Integer); virtual;
    procedure DrawNativeTabBackground(DC: HDC; ATab: TcxTabSheet); virtual;
    procedure DrawTabCloseButton(ACanvas: TcxCanvas; TabVisibleIndex: Integer); virtual;
    procedure DrawTabImage(ACanvas: TcxCanvas; const ARect: TRect; AImageIndex: Integer;
      AEnabled: Boolean; AColor: TColor; ATabVisibleIndex: Integer); virtual;
    procedure DrawTabImageAndText(ACanvas: TcxCanvas; ATabVisibleIndex: Integer); virtual;
    procedure DrawTabText(ACanvas: TcxCanvas; const ARect: TRect; const AText: string;
      AEnabled: Boolean; AColor: TColor; ATabVisibleIndex: Integer); virtual;
    procedure ExcludeTabContentClipRegion(ACanvas: TcxCanvas; ATabVisibleIndex: Integer);
    procedure FillFreeSpaceArea(ACanvas: TcxCanvas; const ARect: TRect); virtual;
    procedure FillPageClientRect(ACanvas: TcxCanvas); virtual;
    procedure FillTabPaneContent(ACanvas: TcxCanvas); virtual;
    function GetButtonsDistance(AButton1, AButton2: TcxPCNavigatorButton): Integer; virtual;
    function GetButtonsRegionFromTabsOffset: Integer; virtual;
    function GetButtonsRegionHOffset: Integer; virtual;
    function GetButtonsRegionWOffset: Integer; virtual;
    function GetClientColor: TColor; virtual;
    function GetCloseButtonAreaHeight(ATabVisibleIndex: Integer): Integer; virtual;
    function GetCloseButtonAreaWidth(ATabVisibleIndex: Integer): Integer; virtual;
    function GetCloseButtonSize: TSize; virtual;
    function GetCloseButtonOffset(ATabVisibleIndex: Integer): TRect; virtual;
    function GetFillClientRect: TRect; virtual;
    function GetFreeSpaceColor: TColor; virtual;
    function GetPageBorders: TcxBorders;
    function GetPageClientRect: TRect;
    function GetPageClientRectOffset: TRect; virtual;
    function GetDefaultClientColor: TColor; virtual;
    function GetPageFrameRect: TRect; virtual;
    function GetPageFrameRectOffset: TRect; virtual;
    function GetDrawImageOffset(TabVisibleIndex: Integer): TRect; virtual; abstract;
    function GetDrawImageWithoutTextWOffset(TabVisibleIndex: Integer): TcxPCWOffset; virtual; abstract;
    function GetDrawTextHOffset(TabVisibleIndex: Integer): TRect; virtual; abstract;
    function GetLookAndFeelPainterClass: TcxCustomLookAndFeelPainterClass; virtual;

    function GetBorderWidths: TRect; virtual;
    function GetExtendedRect(const ARect, AExtension: TRect; ATabPosition: TcxTabPosition): TRect;
    function GetFrameWidth: Integer; virtual;

    procedure AfterPaintTab(ACanvas: TcxCanvas; ATabVisibleIndex: Integer); virtual;
    function AlwaysColoredTabs: Boolean; virtual;
    function GetGoDialogPosition(GoDialogSize: TSize): TPoint; virtual; abstract;
    function GetHighlightedTextColor(ATabVisibleIndex: Integer;
      ATextColor: TColor): TColor;
    function GetHotTrackColor: TColor;
    function GetImageTextDistance(ATabVisibleIndex: Integer): Integer; virtual; abstract;
    function GetMaxTabCaptionHeight: Integer;
    function GetMinTabNormalWidth(ATabVisibleIndex: Integer): Integer; virtual; abstract;
    function GetMinTabSelectionDistance: TcxPCDistance; virtual; abstract;
    function GetNativeContentOffset: TRect; virtual;
    function GetTabBaseImageSize: TSize;
    function GetTabBodyColor(TabVisibleIndex: Integer): TColor; virtual; abstract;
    function GetTabColor(ATabVisibleIndex: Integer): TColor; virtual;
    function GetTabClipRgn(ACanvas: TcxCanvas; ATabVisibleIndex: Integer): TcxRegion; virtual;
    function GetTabClipRgnOperation(ATabVisibleIndex: Integer): TcxRegionOperation; virtual;
    function GetTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset; virtual; abstract;
    function GetTabImageAreaHeight: Integer;
    function GetTabImageAreaWidth: Integer;
    procedure GetTabNativePartAndState(ATabVisibleIndex: Integer;
      out PartId, StateId: Integer); virtual;
    function GetTabNativeState(ATabVisibleIndex: Integer): Integer;
    function GetTabRotatedImageSize: TSize;
    function GetTabsContainerOffsets: TRect; virtual;
    function GetTabsNormalDistance: TcxPCDistance; virtual;
    function GetTabsPosition(NavigatorButtons: TcxPCNavigatorButtons): TcxPCTabsPosition; virtual; abstract;
    function GetTextColor(ATabVisibleIndex: Integer): TColor; virtual;
    function GetTooNarrowTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset; virtual; abstract;
    function HasActivePage: Boolean;
    procedure Init; virtual;
    procedure InternalDrawText(ACanvas: TcxCanvas; const ACaption: string;
      ARect: TRect; ATabVisibleIndex: Integer); virtual;
    procedure InternalPaint(ACanvas: TcxCanvas); virtual;
    procedure InternalPaintDragImage(ACanvas: TcxCanvas; ATabVisibleIndex: Integer); virtual; abstract;
    procedure InternalPolyLine(const APoints: array of TPoint; AColor: TColor;
      ACanvas: TcxCanvas);
    procedure InternalResetClipRegion(ACanvas: TcxCanvas);
    function InternalSetClipRect(ACanvas: TcxCanvas; ClipR: TRect; IntersectWithCurrentClipRegion: Boolean = True): Boolean;
    procedure InvalidateTabExtendedTabsRect(TabVisibleIndex: Integer);
    procedure InvalidateTabRect(ATabVisibleIndex: Integer); virtual;
    function IsAssignedImages: Boolean;
    function IsEnableHotTrack: Boolean; virtual;
    function IsNativePainting: Boolean; virtual;
    function PtInTab(TabVisibleIndex: Integer; X, Y: Integer): Boolean; virtual;
    function IsPaintHeadersAreaFirst: Boolean; virtual;
    function IsTabHasImage(ATabVisibleIndex: Integer): Boolean;
    function IsTabBorderThick(ATabVisibleIndex: Integer): Boolean; virtual; abstract;
    function IsTabTransparent(ATabVisibleIndex: Integer): Boolean; virtual;
    function IsTabsRectVisible(ACanvas: TcxCanvas): Boolean; virtual;
    function NeedDisabledTextShadow: Boolean; virtual;
    function NeedDoubleBuffer: Boolean; virtual;
    function NeedRedrawOnResize: Boolean; virtual;
    function NeedShowFrame: Boolean; virtual;
    procedure PaintButton(ACanvas: TcxCanvas; const ARect: TRect;
      AState: TcxPCNavigatorButtonState; AType: TcxPCNavigatorButton); virtual; abstract;
    procedure PaintButtonsRegion(ACanvas: TcxCanvas); virtual; abstract;
    procedure PaintDragImage(ACanvas: TcxCanvas; const R: TRect; ATabVisibleIndex: Integer);
    procedure DoPaintPageFrame(ACanvas: TcxCanvas); virtual;
    procedure PaintHeadersArea(ACanvas: TcxCanvas); virtual;
    procedure PaintPageFrame(ACanvas: TcxCanvas);
    procedure PaintTab(ACanvas: TcxCanvas; TabVisibleIndex: Integer); virtual;
    procedure PaintTabsRegion(ACanvas: TcxCanvas); virtual; abstract;
    procedure PrepareDrawTabContentBitmapBackground(ABitmap: TcxBitmap;
      const ABitmapPos: TPoint; ATabVisibleIndex: Integer); virtual;
    procedure DrawTabContentBackground(ACanvas: TcxCanvas; const ABounds: TRect; ABackgroundColor: TColor; ATabVisibleIndex: Integer); virtual;
    procedure RepaintButtonsRegion; virtual;
    procedure RepaintTab(TabVisibleIndex: Integer; TabPropertyChanged: TcxPCTabPropertyChanged); virtual;
    procedure RotatePoint(const R: TRect; var P: TPoint;
      ATabPosition: TcxTabPosition);
    procedure RotatePolyline(const R: TRect; var APoints: array of TPoint;
      ATabPosition: TcxTabPosition);
    function UseActivePageColor: Boolean;
    function UseLookAndFeelCloseButton: Boolean; virtual;

    function IsDragImagePainted: Boolean;
    procedure StartDragImagePainted;
    procedure StopDragImagePainted;

    property DisabledTextFaceColor: TColor read GetDisabledTextFaceColor;
    property DisabledTextShadowColor: TColor read GetDisabledTextShadowColor;
    property HighlightedTabBodyColor: TColor read GetHighlightedTabBodyColor;
  public
    constructor Create(AViewInfo: TcxCustomTabControlViewInfo); virtual;

    procedure Paint(ACanvas: TcxCanvas); virtual;
    procedure PaintPageClientArea(ACanvas: TcxCanvas); virtual;

    function CalculateTabNormalHeight: Integer; virtual; abstract;
    class function GetStandardStyle: TcxPCStandardStyle; virtual;
    class function GetStyleID: TcxPCStyleID; virtual;
    class function GetStyleName: TCaption; virtual;
    class function HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean; virtual;
    class function IsDefault(ALookAndFeel: TcxLookAndFeel): Boolean; virtual;
    class function IsMainTabBoundWithClient: Boolean; virtual;
    class function IsMultiSelectionAccepted: Boolean; virtual;
    class function IsStandardStyle: Boolean; virtual;
    class function IsTabPressable: Boolean; virtual;

    property ImagePainter: TcxPCImageList read GetImagePainter;
    property ViewInfo: TcxCustomTabControlViewInfo read FViewInfo;
    property TabViewInfo [Index: Integer]: TcxTabViewInfo read GetTabViewInfo;
  end;

  TcxPCImageList = class
  private
    FBaseHotImageChangeLink: TChangeLink;
    FBaseHotImages: TCustomImageList;
    FBaseImageChangeLink: TChangeLink;
    FBaseImages: TCustomImageList;
    FFreeNotificator: TcxFreeNotificator;
    FImageRotationAngle: TcxRotationAngle;
    FProperties: TcxCustomTabControlProperties;
    FOnChange: TNotifyEvent;
    procedure BaseImageListChange(Sender: TObject);
    procedure Change;
    procedure FreeNotification(AComponent: TComponent);
    class procedure OutError(SourceMethodName, Msg: TCaption);
    procedure SetBaseHotImages(const Value: TCustomImageList);
    procedure SetBaseImages(const Value: TCustomImageList);
    function GetBaseImageSize: TSize;
    function GetImages(AHot: Boolean): TCustomImageList;
    function GetRotatedImageSize: TSize;
  public
    constructor Create(AProperties: TcxCustomTabControlProperties);
    destructor Destroy; override;
    function IsImagesAssigned: Boolean;
    procedure Draw(ACanvas: TcxCanvas; X, Y, AIndex: Integer;
      ABackgroundColor: TColor; AIsNativePainting, AEnabled, AHot: Boolean);

    property BaseHotImages: TCustomImageList read FBaseHotImages write SetBaseHotImages;
    property BaseImages: TCustomImageList read FBaseImages write SetBaseImages;
    property BaseImageSize: TSize read GetBaseImageSize;
    property ImageRotationAngle: TcxRotationAngle read FImageRotationAngle write FImageRotationAngle default ra0;
    property RotatedImageSize: TSize read GetRotatedImageSize;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  { TcxTabSlants }

  TcxTabSlants = class(TPersistent)
  private
    FKind: TcxTabSlantKind;
    FOwner: TPersistent;
    FPositions: TcxTabSlantPositions;
    FOnChange: TNotifyEvent;
    procedure Changed;
    procedure SetKind(Value: TcxTabSlantKind);
    procedure SetPositions(Value: TcxTabSlantPositions);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    procedure Assign(Source: TPersistent); override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Kind: TcxTabSlantKind read FKind write SetKind default skSlant;
    property Positions: TcxTabSlantPositions read FPositions write SetPositions
      default [spLeft];
  end;

  TcxPCGoDialogClickEvent = procedure(ATabVisibleIndex: Integer) of object;

  TcxPCCustomGoDialog = class
  private
    FTabControl: IcxTabControl;
    FOnClick: TcxPCGoDialogClickEvent;
    function GetViewInfo: TcxCustomTabControlViewInfo;
  public
    constructor Create(ATabControl: IcxTabControl); virtual;
    function Popup(X, Y: Integer): Boolean; virtual; abstract;

    property TabControl: IcxTabControl read FTabControl;
    property ViewInfo: TcxCustomTabControlViewInfo read GetViewInfo;
    property OnClick: TcxPCGoDialogClickEvent read FOnClick write FOnClick;
  end;

  { TcxTabControlDragAndDropObject }

  TcxTabControlDragAndDropObject = class(TcxDragAndDropObject)
  private
    FHitTabVisibleIndex: Integer;
    FDragImage: TcxDragImage;
    FDestinationArrowFirst: TcxDragAndDropArrow;
    FDestinationArrowSecond: TcxDragAndDropArrow;
    FDestinationTabVisibleIndex: Integer;
    FIControl: IcxTabControl;
    FScrollingDirection: Integer;
    FScrollingTimer: TcxTimer;
    FDragPointOffset: TPoint;
    FTabVisibleIndex: Integer;
    function GetProperties: TcxCustomTabControlProperties;
    function GetViewInfo: TcxCustomTabControlViewInfo;
    procedure ScrollingTimerHandler(Sender: TObject);
    procedure SetDestinationTabVisibleIndex(Value: Integer);
  protected
    function GetDragAndDropCursor(Accepted: Boolean): TCursor; override;
    procedure CheckScrolling(const P: TPoint);
    procedure CreateDestinationImage;
    procedure CreateDragImage;
    procedure CreateScrollingTimer;
    procedure DestroyDestinationImage;
    procedure DestroyDragImage;
    procedure DestroyScrollingTimer;
    procedure Drop(Accepted: Boolean); virtual;
    function GetClientCursorPos: TPoint; override;
    procedure PaintDragImage;
    procedure ShowDragImage;
    property DestinationTabVisibleIndex: Integer read FDestinationTabVisibleIndex write SetDestinationTabVisibleIndex;
    property Properties: TcxCustomTabControlProperties read GetProperties;
    property ViewInfo: TcxCustomTabControlViewInfo read GetViewInfo;
  public
    constructor Create(AIControl: IcxTabControl); reintroduce; virtual;

    procedure BeginDragAndDrop; override;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    procedure Init(ATabVisibleIndex: Integer; const P: TPoint); virtual;
  end;
  TcxTabControlDragAndDropObjectClass = class of TcxTabControlDragAndDropObject;

  {TcxCustomTabControlHitTest}

  TcxCustomTabControlHitTest = class
  private
    FController: TcxCustomTabControlController;
    FHitObject: TObject;
    FFlags: Int64;
    FHitPoint: TPoint;
    FShift: TShiftState;
    function GetBitState(AIndex: Integer): Boolean;
    procedure SetBitState(AIndex: Integer; AValue: Boolean);
  protected
    procedure Clear;
    procedure Recalculate;
    procedure Update(AShift: TShiftState; const APoint: TPoint);
  public
    constructor Create(AOwner: TcxCustomTabControlController);

    property HitAtNavigatorButton: Boolean index pchtNavigatorButton read GetBitState;
    property HitAtTab: Boolean index pchtTab read GetBitState;
    property HitAtTabCloseButton: Boolean index pchtTabCloseButton read GetBitState;
    property HitObject: TObject read FHitObject write FHitObject;
    property HitPoint: TPoint read FHitPoint;
    property Shift: TShiftState read FShift;
  end;

  { TcxCustomTabControlController }

  TcxCustomTabControlController = class
  private
    FHitTest: TcxCustomTabControlHitTest;
    FOwner: TObject;
    FTimer: TcxTimer;
    FMouseDownTabVisibleIndex: Integer;

    FGoDialog: TcxPCCustomGoDialog;
    FIsGoDialogShowing: Boolean;
    FGoDialogJustClosed: Boolean;

    procedure ArrowButtonClick(ANavigatorButton: TcxPCNavigatorButton);
    procedure CloseButtonClick;
    procedure CreateTimer;
    function GetIControl: IcxTabControl;
    function GetProperties: TcxCustomTabControlProperties;
    function GetViewInfo: TcxCustomTabControlViewInfo;
    function IsScrollTimerStarted: Boolean;
    procedure StartScrollTimer;
    procedure StopScrollTimer;
    procedure TimerEventHandler(Sender: TObject);
  protected
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; virtual;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseLeave; virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;

    procedure FocusChanged; virtual;
    function HandleDialogChar(Key: Integer): Boolean; virtual;
    function KeyDown(var Key: Word; Shift: TShiftState): Boolean; virtual;

    procedure DoTabClick(ATabVisibleIndex: Integer; AShift: TShiftState); virtual;
    procedure TabClick(ATabVisibleIndex: Integer; AShift: TShiftState);
    procedure TabDown(ATabVisibleIndex: Integer; AShift: TShiftState);
    procedure TabUp(ATabVisibleIndex: Integer; AShift: TShiftState);
    procedure TabCloseButtonDown(ACloseButtonInfo: TcxPCTabCloseButtonViewInfo); virtual;
    procedure TabCloseButtonUp(ACloseButtonInfo: TcxPCTabCloseButtonViewInfo); virtual;

    //Drag and drop
    procedure EndDragAndDrop(Accepted: Boolean); virtual;
    function GetDragAndDropObjectClass: TcxTabControlDragAndDropObjectClass; virtual;
    function StartDragAndDrop(const P: TPoint): Boolean; virtual;

    procedure CreateGoDialog;
    procedure DoShowGoDialog; virtual;
    function GetClientToScreen(const APoint: TPoint): TPoint; virtual;
    function GetMouseCursorPos: TPoint; virtual;
    function GetScreenToClient(const APoint: TPoint): TPoint; virtual;
    procedure GoDialogClickEventHandler(ATabVisibleIndex: Integer); virtual;
    procedure HideGoDialog(ATabVisibleIndex: Integer);
    procedure ShowGoDialog;

    function GetControlHandle: THandle; virtual;

    property HitTest: TcxCustomTabControlHitTest read FHitTest;
    property IControl: IcxTabControl read GetIControl;
    property Owner: TObject read FOwner;
    property Properties: TcxCustomTabControlProperties read GetProperties;
    property ViewInfo: TcxCustomTabControlViewInfo read GetViewInfo;
  public
    constructor Create(AOwner: TObject); virtual;
    destructor Destroy; override;

    procedure ScrollTabs(ADelta: Integer);
  end;
  TcxCustomTabControlControllerClass = class of TcxCustomTabControlController;

  { TcxCustomTabControlProperties }

  TcxCustomTabControlPropertiesChangedType = (pctHard, pctMedium, pctLight);

  TcxCustomTabControlPropertiesChangedEvent = procedure(Sender: TObject; AType: TcxCustomTabControlPropertiesChangedType) of object;
  TcxPCPrepareTabCanvasFontEvent = procedure(ATab: TcxTab; ACanvas: TcxCanvas) of object;

  TcxPCNewEvent = procedure(Sender: TObject; AIndex: Integer) of object;

  TcxCustomTabControlProperties = class(TcxOwnedPersistent)
  private
    FActivateFocusedTab: Boolean;
    FAllowTabDragDrop: Boolean;
    FCloseButtonMode: TcxPCCloseButtonMode;
    FHideTabs: Boolean;
    FHotTrack: Boolean;
    FIsTabsContainer: Boolean;
    FImages: TcxPCImageList;
    FImageBorder: Integer;
    FMultiLine: Boolean;
    FMultiSelect: Boolean;
    FNavigatorPosition: TcxPCNavigatorPosition;
    FOptions: TcxPCOptions;
    FOwnerDraw: Boolean;
    FRaggedRight: Boolean;
    FRotate: Boolean;
    FRotatedTabsMaxWidth: Integer;
    FScrollOpposite: Boolean;
    FShowFrame: Boolean;
    FStyle: TcxPCStyleID;
    FTabCaptionAlignment: TAlignment;
    FTabIndex: Integer;
    FTabPosition: TcxTabPosition;
    FTabs: TcxTabs;
    FTabSize: TSmallPoint;
    FTabSlants: TcxTabSlants;

    FUpdateLockCount: Integer;

    FOnChange: TNotifyEvent;
    FOnChanged: TcxCustomTabControlPropertiesChangedEvent;
    FOnChanging: TcxTabChangingEvent;
    FOnStyleChanged: TNotifyEvent;

    FOnCanClose: TcxPCCanCloseEventEx;
    FOnClose: TcxPCCloseEvent;
    FOnDrawTab: TcxPCPropertiesDrawTabEvent;
    FOnDrawTabEx: TcxPCPropertiesDrawTabExEvent;
    FOnGetImageIndex: TcxGetTabImageEvent;
    FOnNew: TcxPCNewEvent;
    FOnPrepareTabCanvasFont: TcxPCPrepareTabCanvasFontEvent;
    FOnTabClick: TcxPCTabClickEvent;

    procedure TabSlantsChangedHandler(Sender: TObject);

    function GetHotImages: TCustomImageList;
    function GetImages: TCustomImageList;
    function GetNewButton: TcxPCNewButton;
    function GetNewButtonMode: TcxPCNewButtonMode;
    function GetOptions: TcxPCOptions;
    procedure SetActivateFocusedTab(Value: Boolean);
    procedure SetCloseButtonMode(const Value: TcxPCCloseButtonMode);
    procedure SetHideTabs(Value: Boolean);
    procedure SetHotImages(Value: TCustomImageList);
    procedure SetHotTrack(Value: Boolean);
    procedure SetImageBorder(Value: Integer);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetIsTabsContainer(Value: Boolean);
    procedure SetRotatedTabsMaxWidth(Value: Integer);
    procedure SetMultiLine(Value: Boolean);
    procedure SetNavigatorPosition(const Value: TcxPCNavigatorPosition);
    procedure SetNewButtonMode(Value: TcxPCNewButtonMode);
    procedure SetOptions(Value: TcxPCOptions);
    procedure SetOwnerDraw(Value: Boolean);
    procedure SetRaggedRight(Value: Boolean);
    procedure SetRotate(Value: Boolean);
    procedure SetScrollOpposite(Value: Boolean);
    procedure SetShowFrame(Value: Boolean);
    procedure SetStyle(const Value: TcxPCStyleID);
    procedure SetTabCaptionAlignment(Value: TAlignment);
    procedure SetTabHeight(Value: Smallint);
    procedure SetTabIndex(Value: Integer);
    procedure SetTabs(const Value: TcxTabs);
    procedure SetTabSlants(Value: TcxTabSlants);
    procedure SetTabPosition(Value: TcxTabPosition);
    procedure SetTabWidth(const Value: Smallint);
  protected
    function CanChange(NewTabIndex: Integer): Boolean; dynamic;
    procedure Changed(AType: TcxCustomTabControlPropertiesChangedType = pctHard);
    procedure DoChange; dynamic;
    procedure DoChanged(AType: TcxCustomTabControlPropertiesChangedType = pctHard); virtual;
    procedure DoPrepareTabCanvasFont(ATab: TcxTab; ACanvas: TcxCanvas); virtual;
    procedure DoStyleChanged;

    procedure NewButtonClick; virtual;
    procedure CloseActiveTab; virtual;
    procedure CloseTab(AIndex: Integer); virtual;
    function DoCanClose(AIndex: Integer): Boolean; virtual;
    procedure DoClose(ATabIndex: Integer); virtual;
    procedure DoCloseTab(AIndex: Integer); virtual;
    procedure DoCloseButtonClick(ATabIndex: Integer); virtual;
    procedure DoNewButtonClick(AIndex: Integer); virtual;
    procedure DoTabClick(ATabVisibleIndex: Integer; AShift: TShiftState); virtual;

    procedure MoveTab(ACurrentIndex, ANewIndex: Integer); virtual;

    procedure SetModified;

    function DoCustomDraw(TabVisibleIndex: Integer): Boolean; dynamic;
    procedure DoDrawTabEx(ATabVisibleIndex: Integer; AFont: TFont); virtual;

    function IsUpdateLocked: Boolean;

    function IsDesigning: Boolean;
    function IsDestroying: Boolean;
    function IsLoading: Boolean;

    function GetViewInfo: TcxCustomTabControlViewInfo;

    procedure ImageListChange(Sender: TObject); virtual;
    function GetImageIndex(ATab: TcxTab): Integer; virtual;
    function GetNavigatorButtons(AOnlyObligatoryButtons: Boolean): TcxPCNavigatorButtons;
    function TabIndexTabMustBeVisible: Boolean; virtual;

    property ActivateFocusedTab: Boolean read FActivateFocusedTab write SetActivateFocusedTab default True;
    property NewButtonMode: TcxPCNewButtonMode read GetNewButtonMode write SetNewButtonMode default nbmNone;
    property AllowTabDragDrop: Boolean read FAllowTabDragDrop write FAllowTabDragDrop default False;
    property CloseButtonMode: TcxPCCloseButtonMode read FCloseButtonMode write SetCloseButtonMode default cbmNone;
    property HideTabs: Boolean read FHideTabs write SetHideTabs default False;
    property HotImages: TCustomImageList read GetHotImages write SetHotImages;
    property HotTrack: Boolean read FHotTrack write SetHotTrack default False;
    property ImageBorder: Integer read FImageBorder write SetImageBorder default 0;
    property Images: TCustomImageList read GetImages write SetImages;
    property IsTabsContainer: Boolean read FIsTabsContainer write SetIsTabsContainer default False;
    property MultiLine: Boolean read FMultiLine write SetMultiLine default False;
    property MultiSelect: Boolean read FMultiSelect write FMultiSelect default False;
    property NavigatorPosition: TcxPCNavigatorPosition read FNavigatorPosition write SetNavigatorPosition default npRightTop;
    property Options: TcxPCOptions read GetOptions write SetOptions default cxPCDefaultOptions;
    property OwnerDraw: Boolean read FOwnerDraw write SetOwnerDraw default False;
    property RaggedRight: Boolean read FRaggedRight write SetRaggedRight default False;
    property Rotate: Boolean read FRotate write SetRotate default False;
    property RotatedTabsMaxWidth: Integer read FRotatedTabsMaxWidth write SetRotatedTabsMaxWidth default 0;
    property ScrollOpposite: Boolean read FScrollOpposite write SetScrollOpposite default False;
    property ShowFrame: Boolean read FShowFrame write SetShowFrame default False;
    property Style: TcxPCStyleID read FStyle write SetStyle default cxPCDefaultStyle;
    property TabCaptionAlignment: TAlignment read FTabCaptionAlignment write SetTabCaptionAlignment default taCenter;
    property TabHeight: Smallint read FTabSize.Y write SetTabHeight default 0;
    property TabIndex: Integer read FTabIndex write SetTabIndex default -1;
    property TabPosition: TcxTabPosition read FTabPosition write SetTabPosition default tpTop;
    property Tabs: TcxTabs read FTabs write SetTabs;
    property TabSlants: TcxTabSlants read FTabSlants write SetTabSlants;
    property TabWidth: Smallint read FTabSize.X write SetTabWidth default 0;

    property OnCanClose: TcxPCCanCloseEventEx read FOnCanClose write FOnCanClose;
    property OnClose: TcxPCCloseEvent read FOnClose write FOnClose;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChanged: TcxCustomTabControlPropertiesChangedEvent read FOnChanged write FOnChanged;
    property OnChanging: TcxTabChangingEvent read FOnChanging write FOnChanging;
    property OnDrawTab: TcxPCPropertiesDrawTabEvent read FOnDrawTab write FOnDrawTab;
    property OnDrawTabEx: TcxPCPropertiesDrawTabExEvent read FOnDrawTabEx write FOnDrawTabEx;
    property OnGetImageIndex: TcxGetTabImageEvent read FOnGetImageIndex write FOnGetImageIndex;
    property OnNew: TcxPCNewEvent read FOnNew write FOnNew;
    property OnStyleChanged: TNotifyEvent read FOnStyleChanged write FOnStyleChanged;
    property OnPrepareTabCanvasFont: TcxPCPrepareTabCanvasFontEvent read FOnPrepareTabCanvasFont write FOnPrepareTabCanvasFont;
    property OnTabClick: TcxPCTabClickEvent read FOnTabClick write FOnTabClick;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure EndUpdate;

    property NewButton: TcxPCNewButton read GetNewButton;
  end;

  TcxTabControlProperties = class(TcxCustomTabControlProperties)
  published
    property ActivateFocusedTab;
    property AllowTabDragDrop;
    property CloseButtonMode;
    property HideTabs;
    property HotImages;
    property HotTrack;
    property ImageBorder;
    property Images;
    property MultiLine;
    property MultiSelect;
    property NavigatorPosition;
    property NewButtonMode;
    property Options;
    property OwnerDraw;
    property RaggedRight;
    property Rotate;
    property RotatedTabsMaxWidth;
    property ScrollOpposite;
    property ShowFrame;
    property Style;
    property TabCaptionAlignment;
    property TabHeight;
    property TabIndex;
    property TabPosition;
    property Tabs;
    property TabSlants;
    property TabWidth;
  end;

  TcxDrawTabEvent = procedure(AControl: TcxCustomTabControl; ATab: TcxTab;
    var DefaultDraw: Boolean) of object;
  TcxDrawTabExEvent = procedure(AControl: TcxCustomTabControl; ATab: TcxTab;
    Font: TFont) of object;
  TcxPCCanCloseEvent = procedure(Sender: TObject; var ACanClose: Boolean) of object;

  { TcxCustomTabControl }

  TcxCustomTabControl = class(TcxControl, IcxTabControl, IcxControlComponentState,
    IcxMouseTrackingCaller2, IdxSkinSupport)
  private
    FChangeEventLockCount: Integer;
    FClientRect: TRect;
    FController: TcxCustomTabControlController;
    FFocusable: Boolean;
    FIsClientRectLoaded: Boolean;
    FPainter: TcxPCCustomPainter;
    FProperties: TcxCustomTabControlProperties;
    FViewInfo: TcxCustomTabControlViewInfo;

    FOnCanClose: TcxPCCanCloseEvent;
    FOnCanCloseEx: TcxPCCanCloseEventEx;
    FOnChange: TNotifyEvent;
    FOnChanging: TcxTabChangingEvent;
    FOnDrawTab: TcxDrawTabEvent;
    FOnDrawTabEx: TcxDrawTabExEvent;
    FOnGetImageIndex: TcxGetTabImageEvent;
    FOnNew: TcxPCNewEvent;

    function GetFirstVisibleTab: Integer;
    function GetHideTabs: Boolean;
    function GetHotTrack: Boolean;
    function GetImageBorder: Integer;
    function GetImages: TCustomImageList;
    function GetIsTabsContainer: Boolean;
    function GetMultiLine: Boolean;
    function GetMultiSelect: Boolean;
    function GetNavigatorPosition: TcxPCNavigatorPosition;
    function GetOptions: TcxPCOptions;
    function GetOwnerDraw: Boolean;
    function GetRaggedRight: Boolean;
    function GetRotate: Boolean;
    function GetMaxRotatedTabWidth: Integer;
    function GetScrollOpposite: Boolean;
    function GetShowFrame: Boolean;
    function GetTabCaptionAlignment: TAlignment;
    function GetTabHeight: Smallint;
    function GetTabIndex: Integer;
    function GetTabPosition: TcxTabPosition;
    function GetTabSlants: TcxTabSlants;
    function GetTabWidth: Smallint;
    procedure SetFirstVisibleTab(Value: Integer);
    procedure SetHideTabs(const Value: Boolean);
    procedure SetHotTrack(Value: Boolean);
    procedure SetIsTabsContainer(Value: Boolean);
    procedure SetImageBorder(const Value: Integer);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetMultiLine(const Value: Boolean);
    procedure SetMultiSelect(const Value: Boolean);
    procedure SetNavigatorPosition(const Value: TcxPCNavigatorPosition);
    procedure SetOptions(Value: TcxPCOptions);
    procedure SetOwnerDraw(const Value: Boolean);
    procedure SetRaggedRight(const Value: Boolean);
    procedure SetRotate(const Value: Boolean);
    procedure SetMaxRotatedTabWidth(Value: Integer);
    procedure SetScrollOpposite(const Value: Boolean);
    procedure SetShowFrame(const Value: Boolean);
    procedure SetTabCaptionAlignment(Value: TAlignment);
    procedure SetTabHeight(const Value: Smallint);
    procedure SetTabIndex(Value: Integer);
    procedure SetTabPosition(const Value: TcxTabPosition);
    procedure SetTabSlants(Value: TcxTabSlants);
    procedure SetTabWidth(const Value: Smallint);

    // handlers
    procedure PropertiesChangedHandler(Sender: TObject; AType: TcxCustomTabControlPropertiesChangedType);

    // other
    function GetPageClientRect: TRect;
    function GetPageClientRectOffset: TRect;
    function GetMainTabIndex: Integer;
    function GetStyle: TcxPCStyleID;
    function GetTabs: TcxTabs;
    function InternalGetClientRect: TRect;
    function PassDesignMouseEvent(X, Y: Integer): Boolean;
    procedure ReadClientRectBottom(Reader: TReader);
    procedure ReadClientRectLeft(Reader: TReader);
    procedure ReadClientRectRight(Reader: TReader);
    procedure ReadClientRectTop(Reader: TReader);
    procedure SetProperties(const Value: TcxCustomTabControlProperties);
    procedure SetStyle(const Value: TcxPCStyleID);
    procedure SetTabs(const Value: TcxTabs);
    procedure WriteClientRectBottom(Writer: TWriter);
    procedure WriteClientRectLeft(Writer: TWriter);
    procedure WriteClientRectRight(Writer: TWriter);
    procedure WriteClientRectTop(Writer: TWriter);
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMParentColorChanged(var Message: TMessage); message CM_PARENTCOLORCHANGED;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMPrintClient(var Message: TWMPrintClient); message WM_PRINTCLIENT;
  protected
    procedure AdjustClientRect(var Rect: TRect); override;
    function CanFocusOnClick(X, Y: Integer): Boolean; override;
    procedure ChangeScale(M, D: Integer); override;
    function CreateDragAndDropObject: TcxDragAndDropObject; override;
    procedure CreateHandle; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure FocusChanged; override;
    procedure FontChanged; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues); override;
    function NeedsScrollBars: Boolean; override;
    function NeedRedrawOnResize: Boolean; override;
    procedure Paint; override;
    procedure Resize; override;

    function DoMouseWheelDown(Shift: TShiftState;  MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState;  MousePos: TPoint): Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseEnter(AControl: TControl); override;
    procedure MouseLeave(AControl: TControl); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure TabClick(Sender: TObject; ATabVisibleIndex: Integer; AShift: TShiftState); virtual;

    procedure PropertiesCanCloseHandler(Sender: TObject; AIndex: Integer; var ACanClose: Boolean);
    procedure PropertiesChangeHandler(Sender: TObject);
    procedure PropertiesChangingHandler(Sender: TObject; var AllowChange: Boolean);
    procedure PropertiesDrawTabExHandler(AControl: TcxCustomTabControlProperties; ATab: TcxTab; Font: TFont);
    procedure PropertiesDrawTabHandler(AControl: TcxCustomTabControlProperties; ATab: TcxTab; var DefaultDraw: Boolean);
    procedure PropertiesGetImageIndexHandler(Sender: TObject; TabIndex: Integer; var ImageIndex: Integer);
    procedure PropertiesNewHandler(Sender: TObject; AIndex: Integer);

    procedure AfterPaintTab(ACanvas: TcxCanvas; ATab: TcxTab;
      AImageAndTextData: TcxPCOutTabImageAndTextData); virtual;
    procedure Change; virtual;
    procedure EraseBackground(DC: HDC); virtual;
    function HandleDialogChar(Key: Integer): Boolean; virtual;
    function HasBackground: Boolean; override;
    procedure DrawTab(TabIndex: Integer; const Rect: TRect; Active: Boolean); virtual;
    function GetControllerClass: TcxCustomTabControlControllerClass; virtual;
    function GetMouseCursorPos: TPoint;
    function GetPainterClass: TcxPCPainterClass;
    function GetPropertiesClass: TcxCustomTabControlPropertiesClass; virtual;
    function GetViewInfoClass: TcxCustomTabControlViewInfoClass; virtual;
    class procedure OutError(SourceMethodName: TCaption; Msg: TCaption);
    procedure PrepareTabCanvasFont(ATab: TcxTab; ACanvas: TcxCanvas); virtual;
    procedure RecreatePainter;
    procedure RequestLayout; dynamic;
    procedure SetModified;
    procedure StyleChanged(Sender: TObject);
    procedure UpdateTabImages;

    function InternalKeyDown(Key: Word; Shift: TShiftState): Boolean;
    function IsChangeEventLocked: Boolean;
    procedure LockChangeEvent(ALock: Boolean);

    //Drag and drop
    function AllowAutoDragAndDropAtDesignTime(X, Y: Integer; Shift: TShiftState): Boolean; override;
    function AllowDragAndDropWithoutFocus: Boolean; override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    function StartDragAndDrop(const P: TPoint): Boolean; override;

    // IcxTabControl
    function CanDrawParentBackground: Boolean;
    function GetBoundsRect: TRect;
    function GetCanvas: TcxCanvas;
    function GetControl: TWinControl;
    function GetController: TcxCustomTabControlController;
    function GetDragAndDropObject: TcxDragAndDropObject;
    function GetDragAndDropState: TcxDragAndDropState;
    function GetColor: TColor;
    function GetFont: TFont;
    function GetLookAndFeel: TcxLookAndFeel;
    function GetPainter: TcxPCCustomPainter;
    function GetProperties: TcxCustomTabControlProperties;
    function GetViewInfo: TcxCustomTabControlViewInfo;
    function IsEnabled: Boolean;
    function IsDesigning: Boolean;
    function IsDestroying: Boolean;
    function IsFocused: Boolean;
    function IsLoading: Boolean;
    function IsParentBackground: Boolean;

    // IcxMouseTrackingCaller2
    function PtInCaller(const P: TPoint): Boolean;
    procedure IcxMouseTrackingCaller2.MouseLeave = MouseTrackingCallerMouseLeave;
    procedure MouseTrackingCallerMouseLeave;

    property FirstVisibleTab: Integer read GetFirstVisibleTab write SetFirstVisibleTab;

    property HideTabs: Boolean read GetHideTabs write SetHideTabs stored False;
    property HotTrack: Boolean read GetHotTrack write SetHotTrack stored False;
    property IsTabsContainer: Boolean read GetIsTabsContainer write SetIsTabsContainer stored False;
    property ImageBorder: Integer read GetImageBorder write SetImageBorder stored False;
    property Images: TCustomImageList read GetImages write SetImages stored False;
    property MultiLine: Boolean read GetMultiLine write SetMultiLine stored False;
    property MultiSelect: Boolean read GetMultiSelect write SetMultiSelect stored False;
    property NavigatorPosition: TcxPCNavigatorPosition read GetNavigatorPosition write SetNavigatorPosition stored False;
    property Options: TcxPCOptions read GetOptions write SetOptions stored False;
    property OwnerDraw: Boolean read GetOwnerDraw write SetOwnerDraw stored False;
    property RaggedRight: Boolean read GetRaggedRight write SetRaggedRight stored False;
    property Rotate: Boolean read GetRotate write SetRotate stored False;
    property MaxRotatedTabWidth: Integer read GetMaxRotatedTabWidth write SetMaxRotatedTabWidth stored False;
    property ScrollOpposite: Boolean read GetScrollOpposite write SetScrollOpposite stored False;
    property ShowFrame: Boolean read GetShowFrame write SetShowFrame stored False;
    property TabCaptionAlignment: TAlignment read GetTabCaptionAlignment write SetTabCaptionAlignment stored False;
    property TabHeight: Smallint read GetTabHeight write SetTabHeight stored False;
    property TabIndex: Integer read GetTabIndex write SetTabIndex stored False;
    property TabPosition: TcxTabPosition read GetTabPosition write SetTabPosition stored False;
    property TabSlants: TcxTabSlants read GetTabSlants write SetTabSlants;
    property TabWidth: Smallint read GetTabWidth write SetTabWidth stored False;

    property OnNew: TcxPCNewEvent read FOnNew write FOnNew;
    property OnCanClose: TcxPCCanCloseEvent read FOnCanClose write FOnCanClose;
    property OnCanCloseEx: TcxPCCanCloseEventEx read FOnCanCloseEx write FOnCanCloseEx;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChanging: TcxTabChangingEvent read FOnChanging write FOnChanging;
    property OnDrawTab: TcxDrawTabEvent read FOnDrawTab write FOnDrawTab;
    property OnDrawTabEx: TcxDrawTabExEvent read FOnDrawTabEx write FOnDrawTabEx;
    property OnGetImageIndex: TcxGetTabImageEvent read FOnGetImageIndex write FOnGetImageIndex;

    property PageClientRect: TRect read GetPageClientRect;
    property PageClientRectOffset: TRect read GetPageClientRectOffset;
    property Focusable: Boolean read FFocusable write FFocusable default True;
    property MainTabIndex: Integer read GetMainTabIndex;
    property Style: TcxPCStyleID read GetStyle write SetStyle stored False;
    property Tabs: TcxTabs read GetTabs write SetTabs stored False;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanFocus: Boolean; override;
    function GetOptimalSize: Integer;
    procedure GetTabOrderList(List: TList); override;

    function IndexOfTabAt(X, Y: Integer): Integer;
    function VisibleIndexOfTabAt(X, Y: Integer): Integer;

    procedure ScrollTabs(ADelta: Integer);
    procedure SetStandardStyle(StandardStyle: TcxPCStandardStyle);
    procedure SetStyleByStyleName(StyleName: TCaption);
    property Controller: TcxCustomTabControlController read FController;
    property LookAndFeel;
    property Painter: TcxPCCustomPainter read FPainter;
    property ParentBackground;
    property Properties: TcxCustomTabControlProperties read FProperties write SetProperties;
    property TabStop default True;
    property ViewInfo: TcxCustomTabControlViewInfo read FViewInfo;
  end;

  { TcxPageControlProperties }

  TcxPageControlProperties = class(TcxCustomTabControlProperties)
  private
    FActivePage: TcxTabSheet;
    FActivePageSetting: Boolean;
    FPageInserting: Boolean;
    FPages: TList;
    FOnPageChanging: TcxPageChangingEvent;

    procedure ChangeActivePage(APage: TcxTabSheet);
    procedure UpdateTabOrders;

    function GetControl: TcxPageControl;
    function GetPageCount: Integer;
    procedure SetActivePage(APage: TcxTabSheet);
  protected
    procedure NewButtonClick; override;
    function CanChange(NewTabIndex: Integer): Boolean; override;
    procedure DoChange; override;
    procedure ImageListChange(Sender: TObject); override;
    procedure DoCloseTab(AIndex: Integer); override;
    function TabIndexTabMustBeVisible: Boolean; override;
    procedure MoveTab(ACurrentIntex, ANewIndex: Integer); override;

    function CanChangeActivePage(ANewPage: TcxTabSheet): Boolean; dynamic;
    function GetActivePage: TcxTabSheet; virtual;
    function GetPage(ATabIndex: Integer): TcxTabSheet; virtual;
    procedure DoPageChange; dynamic;
    procedure DoPageChanging(NewPage: TcxTabSheet; var AllowChange: Boolean); dynamic;

    procedure InsertPage(APage: TcxTabSheet);
    procedure RemovePage(APage: TcxTabSheet);

    procedure UpdateActivePage; virtual;
    procedure UpdateTab(APage: TcxTabSheet);
    procedure UpdateTabs;

    property Control: TcxPageControl read GetControl;
    property OnPageChanging: TcxPageChangingEvent read FOnPageChanging write FOnPageChanging;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    function FindNextPage(ACurrentPage: TcxTabSheet; AGoForward, ACheckTabAccessibility, ACircular: Boolean): TcxTabSheet;
    property PageCount: Integer read GetPageCount;
    property Pages[Index: Integer]: TcxTabSheet read GetPage;
    property TabIndex;
  published
    property ActivePage: TcxTabSheet read GetActivePage write SetActivePage;

    property ActivateFocusedTab;
    property AllowTabDragDrop;
    property CloseButtonMode;
    property HideTabs;
    property HotImages;
    property HotTrack;
    property ImageBorder;
    property Images;
    property MultiLine;
    property NavigatorPosition;
    property NewButtonMode;
    property Options; //!!! #DG
    property OwnerDraw;
    property RaggedRight;
    property Rotate;
    property RotatedTabsMaxWidth;
    property ScrollOpposite;
    property ShowFrame;
    property Style;
    property TabCaptionAlignment;
    property TabHeight;
    property TabPosition;
    property TabSlants;
    property TabWidth;
  end;

  TcxPageControlViewInfo = class(TcxCustomTabControlViewInfo)
  private
    function GetActivePage: TcxTabSheet;
    function GetProperties: TcxPageControlProperties;
  protected
    function GetActivePageColor: TColor; override;
    function GetTabColor(ATabVisibleIndex: Integer): TColor; override;
    function HasActivePage: Boolean; override;
    function UseActivePageColor: Boolean; override;
  public
    property ActivePage: TcxTabSheet read GetActivePage;
    property Properties: TcxPageControlProperties read GetProperties;
  end;

  { TcxPageControl }

  TcxPageControl = class(TcxCustomTabControl)
  private
    FNewDockSheet: TcxTabSheet;
    FUndockingPage: TcxTabSheet;
    FOnPageChanging: TcxPageChangingEvent;

    // handlers
    procedure PropertiesPageChangingHandler(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);

    function GetActivePage: TcxTabSheet;
    procedure SetActivePage(APage: TcxTabSheet);

    function GetActivePageIndex: Integer;
    function GetDockClientFromPoint(P: TPoint): TControl;
    function GetPage(Index: Integer): TcxTabSheet;
    function GetPageCount: Integer;
    function GetProperties: TcxPageControlProperties;
    function GetTabCount: Integer;
    procedure SetActivePageIndex(Value: Integer);
    procedure SetProperties(Value: TcxPageControlProperties);
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure CMDockNotification(var Message: TCMDockNotification); message CM_DOCKNOTIFICATION;
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
    procedure CMUnDockClient(var Message: TCMUnDockClient); message CM_UNDOCKCLIENT;
  protected
    // TCustomControl
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure Loaded; override;
    procedure RequestLayout; override;
  {$IFNDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}

    // TcxCustomTabControl
    function GetPropertiesClass: TcxCustomTabControlPropertiesClass; override;
    function GetViewInfoClass: TcxCustomTabControlViewInfoClass; override;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure ShowControl(AControl: TControl); override;

    // Dock
    procedure DoAddDockClient(Client: TControl; const ARect: TRect); override;
    procedure DockOver(Source: TDragDockObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    procedure DoRemoveDockClient(Client: TControl); override;
    function DoUnDock(NewTarget: TWinControl; Client: TControl): Boolean; override;
    function DockClient(DockSource: TDragDockObject; MousePos: TPoint): Integer; virtual;
    procedure GetSiteInfo(Client: TControl; var InfluenceRect: TRect;
      MousePos: TPoint; var CanDock: Boolean); override;
    function GetPageFromDockClient(Client: TControl): TcxTabSheet;
    function UndockClient(NewTarget, Client: TControl): Boolean; virtual;

    procedure ControlChange(Inserting: Boolean; Child: TControl); virtual;
  public
    constructor Create(AOwner: TComponent); override;

    function FindNextPage(ACurrentPage: TcxTabSheet;
      AGoForward, ACheckTabAccessibility: Boolean): TcxTabSheet;
    function FindNextPageEx(ACurrentPage: TcxTabSheet;
      AGoForward, ACheckTabAccessibility, ACircular: Boolean): TcxTabSheet;
  {$IFDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}
    procedure DockDrop(Source: TDragDockObject; X, Y: Integer); override;
    procedure SelectNextPage(GoForward: Boolean; CheckTabVisible: Boolean = True);
    property ActivePageIndex: Integer read GetActivePageIndex
      write SetActivePageIndex;
    property PageCount: Integer read GetPageCount;
    property Pages[Index: Integer]: TcxTabSheet read GetPage;
    property TabCount: Integer read GetTabCount;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property Color;
    property Constraints;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Focusable;
    property Font;
    property ParentBackground;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

    property Properties: TcxPageControlProperties read GetProperties write SetProperties;
    property ActivePage: TcxTabSheet read GetActivePage write SetActivePage stored False;
    property HideTabs;
    property HotTrack;
    property ImageBorder;
    property Images;
    property LookAndFeel;
    property MultiLine;
    property NavigatorPosition;
    property Options;
    property OwnerDraw;
    property RaggedRight;
    property Rotate;
    property MaxRotatedTabWidth;
    property ScrollOpposite;
    property ShowFrame;
    property Style;
    property TabHeight;
    property TabPosition;
    property TabSlants;
    property TabWidth;

    property OnNew;
    property OnCanClose;
    property OnCanCloseEx;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawTab;
    property OnDrawTabEx;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetImageIndex;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;    
    property OnMouseMove;
    property OnMouseUp;
    property OnPageChanging: TcxPageChangingEvent read FOnPageChanging write FOnPageChanging;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  TcxTabSheet = class(TCustomControl)
  private
    FHighlighted: Boolean;
    FImageIndex: TImageIndex;
    FPageControl: TcxPageControl;
    FTab: TcxTab;
    FTabVisible: Boolean;
    FOnHide: TNotifyEvent;
    FOnShow: TNotifyEvent;
    function GetPageIndex: Integer;
    function GetPainter: TcxPCCustomPainter;
    function GetTabIndex: Integer;
    procedure InternalColorChanged;
    procedure SetHighlighted(const Value: Boolean);
    procedure SetImageIndex(const Value: TImageIndex);
    procedure SetPageControl(const Value: TcxPageControl);
    procedure SetPageIndex(const Value: Integer);
    procedure SetTabVisible(const Value: Boolean);
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMInvalidate(var Message: TMessage); message CM_INVALIDATE;
    procedure CMParentColorChanged(var Message: TMessage); message CM_PARENTCOLORCHANGED;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoHide; dynamic;
    procedure DoShow; dynamic;
    procedure EnabledChanged; dynamic;
    procedure PagePropertyChanged;
    procedure SetParent(AParent: TWinControl); override;
    procedure SetParentPageControl(AParentPageControl: TcxPageControl); virtual;
    procedure ShowingChanged; dynamic;
    procedure TextChanged; dynamic;
    //
    property Painter: TcxPCCustomPainter read GetPainter;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property PageControl: TcxPageControl read FPageControl write SetPageControl;
    property TabIndex: Integer read GetTabIndex;
  published
    property BorderWidth;
    property Caption;
    property Color;
    property Constraints;
    property DragMode;
    property Enabled;
    property Font;
    property Height stored False;
    property Highlighted: Boolean read FHighlighted write SetHighlighted default False;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex default -1;
    property Left stored False;
    property PageIndex: Integer read GetPageIndex write SetPageIndex stored False;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabVisible: Boolean read FTabVisible write SetTabVisible default True;
    property Top stored False;
    property Visible stored False;
    property Width stored False;
    property OnClick;
{$IFDEF DELPHI5}
    property OnContextPopup;
{$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnStartDrag;
  end;

  { TcxTabControl }

  TcxTabControl = class(TcxCustomTabControl)
  private
    function GetProperties: TcxTabControlProperties;
    procedure SetProperties(Value: TcxTabControlProperties);
  protected
    function GetPropertiesClass: TcxCustomTabControlPropertiesClass; override;
  public
    property PageClientRect;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property Color;
    property Constraints;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Focusable;
    property Font;
    property ParentBackground;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

    property Properties: TcxTabControlProperties read GetProperties write SetProperties;
    property HideTabs;
    property HotTrack;
    property ImageBorder;
    property Images;
    property LookAndFeel;
    property MultiLine;
    property MultiSelect;
    property NavigatorPosition;
    property Options;
    property OwnerDraw;
    property RaggedRight;
    property Rotate;
    property MaxRotatedTabWidth;
    property ScrollOpposite;
    property ShowFrame;
    property Style;
    property TabHeight;
    property TabIndex;
    property TabPosition;
    property Tabs;
    property TabSlants;
    property TabWidth;

    property OnNew;
    property OnCanClose;
    property OnCanCloseEx;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawTab;
    property OnDrawTabEx;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetImageIndex;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;    
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

procedure CorrectRect(var Rect: TRect; RectCorrection: TcxPCRectCorrection);
function DistanceGetter(const Distance: TcxPCDistance; const LongitudinalDistance: Boolean): Integer;
function InternalGetTextRotationAngle(AViewInfo: TcxCustomTabControlViewInfo): TcxRotationAngle;
function InternalIsVerticalText(AViewInfo: TcxCustomTabControlViewInfo): Boolean;
function IsBottomToTopAlignment(TabControl: TcxCustomTabControl): Boolean;
function IsOneOfButtons(AButton1, AButton2, AButton: TcxPCNavigatorButton): Boolean;
function IsRightToLeftAlignment(TabControl: TcxCustomTabControl): Boolean;
function IsVerticalText(TabControl: TcxCustomTabControl): Boolean;
function PointGetter(const APoint: TPoint; AIsY: Boolean): Longint;
procedure PointSetter(var APoint: TPoint; AIsY: Boolean; AValue: Longint);
procedure RectSetter(var ARect: TRect; AIsLeftTop, AIsY: Boolean;
  AValue: Longint);
function RotateRect(const ARect: TRect; ATabPosition: TcxTabPosition): TRect;
function RotateRectBack(const ARect: TRect; ATabPosition: TcxTabPosition): TRect;
function TextSize(ATabViewInfo: TcxTabViewInfo; const AText: string; AFont: TFont = nil): TSize;
procedure ValidateRect(var R: TRect);

function GetPCStyleName(AStyleID: TcxPCStyleID): string;

var
  TabScrollingDelay: Integer = 150;
  TabScrollingStartDelay: Integer = 300;

implementation

uses
  Math, cxGeometry, dxThemeConsts, dxThemeManager, dxUxTheme,
  cxPCConsts, cxPCPainters, cxPCPaintersFactory, cxPCGoDialog, StrUtils,
  Types;

type
  TcxPCTabsChangedEventArgs = record
    Tab: TcxTab;
    PropertyChanged: TcxPCTabPropertyChanged;
  end;

var
  FBackgroundBitmap: TBitmap = nil;

procedure CorrectRect(var Rect: TRect; RectCorrection: TcxPCRectCorrection);
begin
  with RectCorrection do
    Rect := cxRectTransform(Rect, dLeft, dTop, dRight, dBottom);
end;

function DistanceGetter(const Distance: TcxPCDistance; const LongitudinalDistance: Boolean): Integer;
begin
  if LongitudinalDistance then
    Result := Distance.dw
  else
    Result := Distance.dh;
end;

function GetControlRect(AControl: TControl): TRect;
begin
  Result := Rect(0, 0, AControl.Width, AControl.Height);
end;

function InternalGetTextRotationAngle(AViewInfo: TcxCustomTabControlViewInfo): TcxRotationAngle;
begin
  if AViewInfo.IsNativePainting then
    Result := ra0
  else
    Result := AViewInfo.GetTextRotationAngle;
end;

function InternalIsVerticalText(AViewInfo: TcxCustomTabControlViewInfo): Boolean;
begin
  Result := not AViewInfo.IsNativePainting and AViewInfo.IsVerticalText;
end;

function IsBottomToTopAlignment(TabControl: TcxCustomTabControl): Boolean;
begin
  with TabControl do
  begin
    Result := (TabPosition in [tpLeft, tpRight]) and (not ViewInfo.ActuallyRotate) and
      not (pcoTopToBottomText in Options);
  end;
end;

function IsOneOfButtons(AButton1, AButton2, AButton: TcxPCNavigatorButton): Boolean;
begin
  Result := (AButton = AButton1) or (AButton = AButton2);
end;

function IsRightToLeftAlignment(TabControl: TcxCustomTabControl): Boolean;
begin
  with TabControl do
  begin
    Result := (TabPosition in [tpTop, tpBottom]) and ViewInfo.ActuallyRotate and
      (pcoTopToBottomText in Options);
  end;
end;

function IsVerticalText(TabControl: TcxCustomTabControl): Boolean;
begin
  with TabControl do
  begin
    Result := (TabPosition in [tpLeft, tpRight]) and (not ViewInfo.ActuallyRotate);
    Result := Result or (TabPosition in [tpTop, tpBottom]) and ViewInfo.ActuallyRotate;
  end;
end;

function PointGetter(const APoint: TPoint; AIsY: Boolean): Longint;
begin
  if AIsY then
    Result := APoint.Y
  else
    Result := APoint.X;
end;

procedure PointSetter(var APoint: TPoint; AIsY: Boolean; AValue: Longint);
begin
  if AIsY then
    APoint.Y := AValue
  else
    APoint.X := AValue;
end;

procedure PrepareBitmap(ABitmap: TcxBitmap; AParametersSource: TcxCanvas;
  ASize: TSize; ABackgroundColor: TColor);
begin
  ABitmap.SetSize(cxRect(ASize));
  with ABitmap.cxCanvas do
  begin
    Font.Assign(AParametersSource.Font);
    Pen := AParametersSource.Pen;

    Brush := AParametersSource.Brush;
    Brush.Color := ABackgroundColor;
    Brush.Style := bsSolid;
    FillRect(ABitmap.ClientRect);
    Brush := AParametersSource.Brush;
  end;
end;

procedure RectSetter(var ARect: TRect; AIsLeftTop, AIsY: Boolean;
  AValue: Longint);
begin
  if AIsLeftTop then
  begin
    if AIsY then
      ARect.Top := AValue
    else
      ARect.Left := AValue;
  end
  else
  begin
    if AIsY then
      ARect.Bottom := AValue
    else
      ARect.Right := AValue;
  end;
end;

function RotateRect(const ARect: TRect; ATabPosition: TcxTabPosition): TRect;
begin
  case ATabPosition of
    tpLeft: Result := Rect(ARect.Top, ARect.Right, ARect.Bottom, ARect.Left);
    tpTop: Result := ARect;
    tpRight: Result := Rect(ARect.Bottom, ARect.Left, ARect.Top, ARect.Right);
    tpBottom: Result := Rect(ARect.Right, ARect.Bottom, ARect.Left, ARect.Top);
  end;
end;

function RotateRectBack(const ARect: TRect; ATabPosition: TcxTabPosition): TRect;
begin
  case ATabPosition of
    tpLeft: Result := RotateRect(ARect, tpRight);
    tpTop: Result := ARect;
    tpRight: Result := RotateRect(ARect, tpLeft);
    tpBottom: Result := RotateRect(ARect, tpBottom);
  end;
end;

function TextSize(ATabViewInfo: TcxTabViewInfo; const AText: string; AFont: TFont = nil): TSize;
begin
  if AFont = nil then
    ATabViewInfo.PrepareCanvasFont(cxScreenCanvas)
  else
    cxScreenCanvas.Font := AFont;
  Result := cxTextSize(cxScreenCanvas.Handle, AText);
  cxScreenCanvas.Dormant;
end;

procedure ValidateRect(var R: TRect);
begin
  R.Right := Max(R.Right, R.Left);
  R.Bottom := Max(R.Bottom, R.Top);
end;

function GetPCStyleName(AStyleID: TcxPCStyleID): string;
var
  APainterClass: TcxPCPainterClass;
begin
  if AStyleID = cxPCDefaultStyle then
    Result := cxPCDefaultStyleName
  else
  begin
    APainterClass := PaintersFactory.GetPainterClass(AStyleID);
    if APainterClass = nil then
      Result := ''
    else
      Result := APainterClass.GetStyleName;
  end;
end;

{ TcxPCCustomElementViewInfo }

function TcxPCCustomElementViewInfo.GetHitTest(
  AHitTest: TcxCustomTabControlHitTest): Boolean;
begin
  Result := PtInElement(AHitTest.HitPoint);
  if Result then
    SetHitTest(AHitTest);
end;

function TcxPCCustomElementViewInfo.PtInElement(const APoint: TPoint): Boolean;
begin
  Result := cxRectPtIn(FBounds, APoint);
end;

procedure TcxPCCustomElementViewInfo.SetHitTest(AHitTest: TcxCustomTabControlHitTest);
begin
  AHitTest.SetBitState(GetHitTestIndex , True);
  AHitTest.HitObject := Self;
end;

{ TcxPCCustomButtonViewInfo }

destructor TcxPCCustomButtonViewInfo.Destroy;
begin
  ControlViewInfo.ElementDestroying(Self);
  inherited Destroy;
end;

procedure TcxPCCustomButtonViewInfo.Invalidate;
begin
  ControlViewInfo.InvalidateRect(AbsoluteBounds, False);
end;

function TcxPCCustomButtonViewInfo.GetAbsoluteBounds: TRect;
begin
  Result := Bounds;
end;

function TcxPCCustomButtonViewInfo.PtInElement(const APoint: TPoint): Boolean;
begin
  Result := cxRectPtIn(AbsoluteBounds, APoint);
end;

procedure TcxPCCustomButtonViewInfo.SetState(
  AValue: TcxPCNavigatorButtonState);
begin
  if FState <> AValue then
  begin
    FState := AValue;
    Invalidate;
  end;
end;

{ TcxPCTabCloseButtonViewInfo }

constructor TcxPCTabCloseButtonViewInfo.Create(ATabViewInfo: TcxTabViewInfo);
begin
  inherited Create;
  FTabViewInfo := ATabViewInfo;
end;

function TcxPCTabCloseButtonViewInfo.GetHitTestIndex: Integer;
begin
  Result := pchtTabCloseButton;
end;

function TcxPCTabCloseButtonViewInfo.GetAbsoluteBounds: TRect;
begin
  Result := FTabViewInfo.GetAbsolutePartRect(FBounds);
end;

function TcxPCTabCloseButtonViewInfo.GetControlViewInfo: TcxCustomTabControlViewInfo;
begin
  Result := FTabViewInfo.ControlViewInfo;
end;

{ TcxPCNavigatorButtonViewInfo }

constructor TcxPCNavigatorButtonViewInfo.Create(ATabControlViewInfo: TcxCustomTabControlViewInfo;
  AButtonType: TcxPCNavigatorButton);
begin
  inherited Create;
  FTabControlViewInfo := ATabControlViewInfo;
  FButtonType := AButtonType;
end;

destructor TcxPCNavigatorButtonViewInfo.Destroy;
begin
  if FTabControlViewInfo.Controller.HitTest.HitObject = Self then
     FTabControlViewInfo.Controller.HitTest.Clear;
  inherited Destroy;
end;

function TcxPCNavigatorButtonViewInfo.GetHitTestIndex: Integer;
begin
  Result := pchtNavigatorButton;
end;

function TcxPCNavigatorButtonViewInfo.GetControlViewInfo: TcxCustomTabControlViewInfo;
begin
  Result := FTabControlViewInfo;
end;

{ TcxTabViewInfo }

constructor TcxTabViewInfo.Create(ATab: TcxTab; ATabsViewInfo: TcxTabsViewInfo);
begin
  inherited Create;
  FTab := ATab;
  FTabsViewInfo := ATabsViewInfo;
  Tab.DestroyHandlers.Add(TabDestroyHandler);
end;

destructor TcxTabViewInfo.Destroy;
begin
  if Tab <> nil then
    Tab.DestroyHandlers.Remove(TabDestroyHandler);
  FreeAndNil(FCloseButtonInfo);
  inherited;
end;

function TcxTabViewInfo.ActuallyEnabled: Boolean;
begin
  Result := ControlViewInfo.IsEnabled and Tab.Enabled;
end;

function TcxTabViewInfo.ActuallyVisible: Boolean;
begin
  Result := ControlViewInfo.IsTabActuallyVisible(Self);
end;

function TcxTabViewInfo.CanFocus: Boolean;
begin
  Result := True;
end;

function TcxTabViewInfo.HasCaption: Boolean;
begin
  Result := Caption <> '';
end;

function TcxTabViewInfo.HasCloseButton: Boolean;
begin
  Result := (Properties.CloseButtonMode = cbmEveryTab) or
    (Properties.CloseButtonMode = cbmActiveTab) and IsActive;
end;

function TcxTabViewInfo.HasImage: Boolean;
begin
  Result := ImageIndex <> -1;
end;

function TcxTabViewInfo.IsActive: Boolean;
begin
  Result := ControlViewInfo.TabIndex = Index;
end;

function TcxTabViewInfo.IsFocused: Boolean;
begin
  Result := ControlViewInfo.FocusedTabVisibleIndex = VisibleIndex;
end;

function TcxTabViewInfo.IsHighlighted: Boolean;
begin
  Result := Tab.Highlighted; 
end;

function TcxTabViewInfo.IsHotTrack: Boolean;
begin
  Result := ControlViewInfo.HotTrackTabVisibleIndex = VisibleIndex;
end;

function TcxTabViewInfo.IsMainTab: Boolean;
begin
  Result := ControlViewInfo.MainTabVisibleIndex = VisibleIndex;
end;

function TcxTabViewInfo.IsPressed: Boolean;
begin
  Result := ControlViewInfo.PressedTabVisibleIndex = VisibleIndex;
end;

function TcxTabViewInfo.IsSelected: Boolean;
begin
  Result := Tab.Selected;
end;

function TcxTabViewInfo.IsTracking: Boolean;
begin
  Result := ControlViewInfo.TrackingTabVisibleIndex = VisibleIndex;
end;

function TcxTabViewInfo.IsVisibleForGoDialog: Boolean;
begin
  Result := True;
end;

function TcxTabViewInfo.IsCloseButtonPlacedFirst: Boolean;
begin
  Result := GetRelativeTextRotationAngle = raMinus90;
end;

function TcxTabViewInfo.GetDefinedWidth: Integer;
begin
  Result := ControlViewInfo.TabWidth;
end;

function TcxTabViewInfo.GetRelativeTextRotationAngle: TcxRotationAngle;
begin
  case PaintingPositionIndex of
    2, 9, 12: Result := raPlus90;
    3, 6, 11: Result := raMinus90;
    5, 7, 10: Result := ra180;
  else
    Result := ra0;
  end;
end;

procedure TcxTabViewInfo.CalculateNormalWidth;
begin
  FNormalWidth := Painter.CalculateTabNormalWidth(Self);
end;

procedure TcxTabViewInfo.CorrectTabNormalWidth(var AValue: Integer);
begin
  Painter.CorrectTabNormalWidth(AValue);
end;

procedure TcxTabViewInfo.CalculateParts;

  procedure ResetPartParams;
  begin
    FImageRect := cxEmptyRect;
    FTextRect := cxEmptyRect;
    CloseButtonRect := cxEmptyRect;
    FIsTextTooLong := False;
  end;

begin
  ResetPartParams;
  PrepareCanvasFont(Canvas);
  CalculateIsTextTooLong;
  CalculateContentRect;

  if HasCloseButton then
    CalculateCloseButtonVerticalPosition;
  if Painter.IsTabHasImage(VisibleIndex) then
    CalculateImageVerticalPosition;
  if HasCaption then
    CalculateTextVerticalPosition;

  CalculateHorizontalPositions;
end;

procedure TcxTabViewInfo.PrepareCanvasFont(ACanvas: TcxCanvas);
begin
  ControlViewInfo.PrepareTabCanvasFont(Self, ACanvas);
end;

procedure TcxTabViewInfo.CalculateAngleDependentPartBounds(var ACalcRect: TRect;
  const APartHeight: Integer; ADrawOffset: TRect);
begin
  Painter.CorrectTabContentVerticalOffset(VisibleIndex, ADrawOffset);
  with ACalcRect do
    case InternalGetTextRotationAngle(ControlViewInfo) of
      ra0:
        begin
          Inc(Top, ADrawOffset.Top);
          Dec(Bottom, ADrawOffset.Bottom);
          Top := Top + (Bottom - Top - APartHeight) div 2;
          Bottom := Top + APartHeight;
          if ControlViewInfo.IsNativePainting and IsMainTab and
            (GetRelativeTextRotationAngle = ra180) then
            OffsetRect(ACalcRect, 0, 1);
        end;
      raPlus90:
        begin
          Inc(Left, ADrawOffset.Top);
          Dec(Right, ADrawOffset.Bottom);
          Left := Left + (Right - Left - APartHeight) div 2;
          Right := Left + APartHeight;
        end;
      raMinus90:
        begin
          Inc(Left, ADrawOffset.Bottom);
          Dec(Right, ADrawOffset.Top);
          Right := Right - (Right - Left - APartHeight) div 2;
          Left := Right - APartHeight;
        end;
    end;
end;

procedure TcxTabViewInfo.CalculateCloseButtonHorizontalPosition;
var
  ACloseButtonRect: TRect;
  AOffsets: TRect;
  AAngle: TcxRotationAngle;
  AButtonWidth: Integer;
begin
  AOffsets := Painter.GetCloseButtonOffset(VisibleIndex);
  AAngle := InternalGetTextRotationAngle(ControlViewInfo);
  AButtonWidth := Painter.GetCloseButtonSize.cx;
  ACloseButtonRect := CloseButtonRect;
  if InternalIsVerticalText(ControlViewInfo) then
  begin
    if AAngle = raPlus90 then
      AOffsets := RotateRect(AOffsets, tpLeft)
    else
      AOffsets := RotateRect(AOffsets, tpRight);
    if IsCloseButtonPlacedFirst then
      ExchangeLongWords(AOffsets.Top, AOffsets.Bottom);
    if (AAngle = raPlus90) xor IsCloseButtonPlacedFirst then
    begin
      ACloseButtonRect.Top := FContentRect.Top + AOffsets.Top;
      ACloseButtonRect.Bottom := ACloseButtonRect.Top + AButtonWidth;
    end
    else
    begin
      ACloseButtonRect.Bottom := FContentRect.Bottom - AOffsets.Bottom;
      ACloseButtonRect.Top := ACloseButtonRect.Bottom - AButtonWidth;
    end;
  end
  else
  begin
    if IsCloseButtonPlacedFirst then
      ExchangeLongWords(AOffsets.Left, AOffsets.Right);
    if IsCloseButtonPlacedFirst then
    begin
      ACloseButtonRect.Left := FContentRect.Left + AOffsets.Left;
      ACloseButtonRect.Right := ACloseButtonRect.Left + AButtonWidth;
    end
    else
    begin
      ACloseButtonRect.Right := FContentRect.Right - AOffsets.Right;
      ACloseButtonRect.Left := ACloseButtonRect.Right - AButtonWidth;
    end;
  end;
  CloseButtonRect := ACloseButtonRect;
end;

procedure TcxTabViewInfo.CalculateCloseButtonVerticalPosition;
var
  ACloseButtonRect: TRect;
begin
  ACloseButtonRect := FContentRect;
  CalculateAngleDependentPartBounds(ACloseButtonRect, Painter.GetCloseButtonSize.cy,
    Painter.GetCloseButtonOffset(VisibleIndex));
  CloseButtonRect := ACloseButtonRect;
end;

procedure TcxTabViewInfo.CalculateContentRect;
var
  AContentOffset: TcxPCWOffset;  
begin
  FContentRect := GetTabRect;
  AContentOffset := GetContentOffset;

  case InternalGetTextRotationAngle(ControlViewInfo) of
    ra0:
      begin
        Inc(FContentRect.Left, AContentOffset.Left);
        Dec(FContentRect.Right, AContentOffset.Right);
      end;
    raMinus90:
      begin
        Inc(FContentRect.Top, AContentOffset.Left);
        Dec(FContentRect.Bottom, AContentOffset.Right);
      end;
  else // raPlus90
    Dec(FContentRect.Bottom, AContentOffset.Left);
    Inc(FContentRect.Top, AContentOffset.Right);
  end;
end;

procedure TcxTabViewInfo.CalculateImageAndTextHorizontalPositions;

  function GetVisibleTextWidth(const AAccessibleWidth: Integer): Integer;
  var
    ARect: TRect;
    ALength: Integer;
    AText: string;
  begin
    ARect := Rect(0, 0, AAccessibleWidth, 0);
    AText := Caption;
    ALength := Length(AText);
    SetLength(AText, ALength + Length('....'));
    AText[ALength + 1] := #0;
    DrawText(Canvas.Handle, PChar(AText), -1,
      ARect, DT_SINGLELINE or DT_CALCRECT or DT_END_ELLIPSIS or DT_MODIFYSTRING);
    SetLength(AText, StrLen(PChar(AText)));
    Result := ARect.Right;
    if (Result > AAccessibleWidth) or (AText = '&...') then
      Result := 0;
  end;

var
  AIsAssignedImagesAndRotate, AIsTabHasImage, AIsTabHasImageArea: Boolean;
  AImageAreaWidth, AImageTextDistance: Integer;
  AContentHorizontalOffset: Integer;
  AContentWidth: Integer;
  ATextAndImageAreaWidth: Integer;
  ATextWidth: Integer;
  AContentRect: TRect;
begin
  AContentRect := GetTabImageAndTextRect;
  AContentWidth := IfThen(InternalIsVerticalText(ControlViewInfo),
    cxRectHeight(AContentRect), cxRectWidth(AContentRect));

  AIsAssignedImagesAndRotate := IsImagesAssigned and ControlViewInfo.ActuallyRotate;
  AIsTabHasImage := HasImage;
  AIsTabHasImageArea := AIsAssignedImagesAndRotate or AIsTabHasImage;
  AImageTextDistance := IfThen(AIsTabHasImageArea, Painter.GetImageTextDistance(VisibleIndex));
  AImageAreaWidth := IfThen(AIsTabHasImageArea, GetImageAreaWidth);

  ATextWidth := GetVisibleTextWidth(AContentWidth - AImageAreaWidth - AImageTextDistance);
  ATextAndImageAreaWidth := AImageAreaWidth + AImageTextDistance + ATextWidth;

  if ATextAndImageAreaWidth <= 0 then
  begin
    FImageRect := cxEmptyRect;
    FTextRect := cxEmptyRect;
    Exit;
  end;
  AContentHorizontalOffset := IfThen(not FIsTextTooLong and not AIsAssignedImagesAndRotate,
    GetContentHorizontalOffset(AContentWidth, ATextAndImageAreaWidth));

  case InternalGetTextRotationAngle(ControlViewInfo) of
    ra0:
      begin
        Inc(AContentRect.Left, AContentHorizontalOffset);
        if AIsTabHasImage then
        begin
          FImageRect.Left := AContentRect.Left + ControlViewInfo.ImageBorder;
          FImageRect.Right := FImageRect.Left + ControlViewInfo.GetTabImageSize.cx;
        end;
        Inc(AContentRect.Left, AImageAreaWidth + AImageTextDistance);

        if not FIsTextTooLong and AIsAssignedImagesAndRotate then
          Inc(AContentRect.Left,
            GetContentHorizontalOffset(cxRectWidth(AContentRect), ATextWidth));
        FTextRect.Left := AContentRect.Left;
        FTextRect.Right := FTextRect.Left + ATextWidth;
      end;
    raPlus90:
      begin
        Dec(AContentRect.Bottom, AContentHorizontalOffset);
        if AIsTabHasImage then
        begin
          FImageRect.Bottom := AContentRect.Bottom - ControlViewInfo.ImageBorder;
          FImageRect.Top := FImageRect.Bottom - ControlViewInfo.GetTabImageSize.cx;
        end;
        Dec(AContentRect.Bottom, AImageAreaWidth + AImageTextDistance);

        if not FIsTextTooLong and AIsAssignedImagesAndRotate then
          Dec(AContentRect.Bottom,
            GetContentHorizontalOffset(cxRectHeight(AContentRect), ATextWidth));
        FTextRect.Bottom := AContentRect.Bottom;
        FTextRect.Top := FTextRect.Bottom - ATextWidth;
      end;
    raMinus90:
      begin
        Inc(AContentRect.Top, AContentHorizontalOffset);
        if AIsTabHasImage then
        begin
          FImageRect.Top := AContentRect.Top + ControlViewInfo.ImageBorder;
          FImageRect.Bottom := FImageRect.Top + ControlViewInfo.GetTabImageSize.cx;
        end;
        Inc(AContentRect.Top, AImageAreaWidth + AImageTextDistance);

        if not FIsTextTooLong and AIsAssignedImagesAndRotate then
          Inc(AContentRect.Top,
            GetContentHorizontalOffset(cxRectHeight(AContentRect), ATextWidth));
        FTextRect.Top := AContentRect.Top;
        FTextRect.Bottom := FTextRect.Top + ATextWidth;
      end;
  end;
end;

procedure TcxTabViewInfo.CalculateImageHorizontalPosition;
var
  ADrawImageOffset: TcxPCWOffset;
  AImageSize: TSize;
  AImageRect: TRect;

begin
  AImageSize := ControlViewInfo.GetTabImageSize;
  AImageRect := GetTabImageAndTextRect;
  ADrawImageOffset := Painter.GetDrawImageWithoutTextWOffset(VisibleIndex);
  with AImageRect do
    case InternalGetTextRotationAngle(ControlViewInfo) of
      ra0:
        begin
          Inc(AImageRect.Left, ADrawImageOffset.Left);
          Dec(AImageRect.Right, ADrawImageOffset.Right);
          begin
            FImageRect.Left := Left + (Right - Left - AImageSize.cx) div 2;
            FImageRect.Right := FImageRect.Left + AImageSize.cx;
          end;
        end;
      raPlus90:
        begin
          Dec(AImageRect.Bottom, ADrawImageOffset.Left);
          Inc(AImageRect.Top, ADrawImageOffset.Right);
          if Painter.IsTabPressable then
          begin
            FImageRect.Top := Top + (Bottom - Top - AImageSize.cx) div 2;
            FImageRect.Bottom := FImageRect.Top + AImageSize.cx;
          end
          else
          begin
            FImageRect.Bottom := Bottom - (Bottom - Top - AImageSize.cx) div 2;
            FImageRect.Top := FImageRect.Bottom - AImageSize.cx;
          end;
        end;
      raMinus90:
        begin
          Inc(AImageRect.Top, ADrawImageOffset.Left);
          Dec(AImageRect.Bottom, ADrawImageOffset.Right);
          FImageRect.Top := Top + (Bottom - Top - AImageSize.cx) div 2;
          FImageRect.Bottom := FImageRect.Top + AImageSize.cx;
        end;
    end;
end;

procedure TcxTabViewInfo.CalculateImageVerticalPosition;
var
  AImageSize: TSize;
begin
  AImageSize := Painter.GetTabRotatedImageSize;
  FImageRect := FContentRect;
  CalculateAngleDependentPartBounds(FImageRect, AImageSize.cy,
    Painter.GetDrawImageOffset(VisibleIndex));
end;

procedure TcxTabViewInfo.CalculateIsTextTooLong;
var
  AContentWidth: Integer;
  AOffset: TcxPCWOffset;
  ACloseButtonAreaWidth, AImageAreaWidth, AImageTextDistance: Integer;
  AIsTabHasImageArea: Boolean;
  ATabRect: TRect;
begin
  ATabRect := GetTabRect;
  AOffset := GetContentOffset;
  AContentWidth := IfThen(InternalIsVerticalText(ControlViewInfo),
    cxRectHeight(ATabRect), cxRectWidth(ATabRect));
  Dec(AContentWidth, AOffset.Left + AOffset.Right);

  AIsTabHasImageArea := HasImage or IsImagesAssigned and ControlViewInfo.ActuallyRotate;
  AImageTextDistance := IfThen(AIsTabHasImageArea, Painter.GetImageTextDistance(VisibleIndex));
  AImageAreaWidth := IfThen(AIsTabHasImageArea, GetImageAreaWidth);
  ACloseButtonAreaWidth := IfThen(HasCloseButton, Painter.GetCloseButtonAreaWidth(VisibleIndex));
  FIsTextTooLong := TextSize(Self, Caption, Canvas.Font).cx > AContentWidth - AImageAreaWidth -
    AImageTextDistance - ACloseButtonAreaWidth;
end;

procedure TcxTabViewInfo.CalculateHorizontalPositions;
begin
  if HasCloseButton then
    CalculateCloseButtonHorizontalPosition;
  if HasImage and not HasCaption then
    CalculateImageHorizontalPosition;
  if HasCaption then
    CalculateImageAndTextHorizontalPositions;
end;

procedure TcxTabViewInfo.CalculateTextVerticalPosition;
var
  ATextHeight: Integer;
begin
  ATextHeight := Canvas.TextHeight('Zg');
  FTextRect := FContentRect;
  CalculateAngleDependentPartBounds(FTextRect, ATextHeight,
    Painter.GetDrawTextHOffset(VisibleIndex));
end;

function TcxTabViewInfo.GetContentHorizontalOffset(ATabWidth,
  AContentWidth: Integer): Integer;
var
  ACaptionAlignment: TAlignment;
  AMaxTabCaptionWidth: Integer;
begin
  if not ControlViewInfo.ActuallyRotate or (GetDefinedWidth > 0) or
    (ControlViewInfo.ActuallyRotatedTabsMaxWidth > 0) then
    ACaptionAlignment := taCenter
  else
    ACaptionAlignment := Properties.TabCaptionAlignment;
  AMaxTabCaptionWidth := ControlViewInfo.FMaxTabCaptionWidth;
  case ACaptionAlignment of
    taLeftJustify:
      Result := (ATabWidth - AMaxTabCaptionWidth) div 2;
    taRightJustify:
      Result := (ATabWidth - AMaxTabCaptionWidth) div 2 +
        AMaxTabCaptionWidth - AContentWidth;
  else
    Result := (ATabWidth - AContentWidth) div 2;
  end;
end;

function TcxTabViewInfo.GetControlViewInfo: TcxCustomTabControlViewInfo;
begin
  Result := TabsViewInfo.ControlViewInfo;
end;

function TcxTabViewInfo.GetScrollingArea: TRect;
const
  AMinScrollingAreaWidth = 4;
var
  AWidth: Integer;
begin
  Result := NormalRect;
  if ControlViewInfo.FIsLastTabFullyVisible or (VisibleIndex <> ControlViewInfo.LastVisibleTab) then
  begin
    case ControlViewInfo.TabPosition of
      tpTop, tpBottom:
        begin
          AWidth := Max(cxRectWidth(Result) div 4, AMinScrollingAreaWidth);
          if ControlViewInfo.IsRightToLeftAlignment then
            Result.Left := Result.Right - AWidth
          else
            Result.Right := Result.Left + AWidth;
        end;
      tpLeft, tpRight:
        begin
          AWidth := Max(cxRectHeight(Result) div 4, AMinScrollingAreaWidth);
          if ControlViewInfo.IsBottomToTopAlignment then
            Result.Top := Result.Bottom - AWidth
          else
            Result.Bottom := Result.Top + AWidth;
        end;
    end;
  end; 
end;

function TcxTabViewInfo.GetHitTestIndex: Integer;
begin
  Result := pchtTab;
end;

function TcxTabViewInfo.PtInElement(const APoint: TPoint): Boolean;
begin
  Result := cxRectPtIn(VisibleRect, APoint) and
    ControlViewInfo.PtInTab(VisibleIndex, APoint.X, APoint.Y);
end;

procedure TcxTabViewInfo.SetHitTest(AHitTest: TcxCustomTabControlHitTest);
begin
  inherited SetHitTest(AHitTest);
  if not Properties.IsDesigning and HasCloseButton then
    CloseButtonInfo.GetHitTest(AHitTest);
end;

function TcxTabViewInfo.CanClick: Boolean;
begin
  Result := True;
end;

function TcxTabViewInfo.CanMultiSelect: Boolean;
begin
  Result := ControlViewInfo.AllowMultiSelect;
end;

function TcxTabViewInfo.CanSelect: Boolean;
begin
  Result := True;
end;

procedure TcxTabViewInfo.DoHandleDialogChar(Key: Integer);
begin
  ControlViewInfo.Controller.TabClick(VisibleIndex, []);
end;

procedure TcxTabViewInfo.DoSelect(AAddToSelected: Boolean);
begin
  if AAddToSelected and CanMultiSelect then
  begin
    if VisibleIndex = ControlViewInfo.MainTabVisibleIndex then
      ControlViewInfo.TabIndex := -1
    else
      Tab.Selected := not Tab.Selected;
  end
  else
    ControlViewInfo.TabIndex := Index;
end;

procedure TcxTabViewInfo.DoSetFocus;
begin
  ControlViewInfo.FocusedTabVisibleIndex := VisibleIndex;
end;

procedure TcxTabViewInfo.DoClick(AShift: TShiftState);
begin
  ControlViewInfo.Controller.DoTabClick(VisibleIndex, AShift);
end;

function TcxTabViewInfo.HandleDialogChar(Key: Integer): Boolean;
begin
  Result := IsAccel(Key, Caption);
  if Result then
    DoHandleDialogChar(Key);
end;

procedure TcxTabViewInfo.Select(AAddToSelected: Boolean);
begin
  if CanSelect then
    DoSelect(AAddToSelected);
end;

procedure TcxTabViewInfo.SetFocus;
begin
  if CanFocus then
    DoSetFocus;
end;

procedure TcxTabViewInfo.Click(AShift: TShiftState);
begin
  if CanClick then
    DoClick(AShift);
end;

function TcxTabViewInfo.IsNewButton: Boolean;
begin
  Result := Tab.IsNewButton;
end;

function TcxTabViewInfo.IsPressable: Boolean;
begin
  Result := ControlViewInfo.Painter.IsTabPressable;
end;

procedure TcxTabViewInfo.TabDestroyHandler(Sender: TObject; const AEventArgs);
begin
  FTab := nil;
  if IsMainTab then
    ControlViewInfo.FMainTabVisibleIndex := -1;
  if IsTracking then
    ControlViewInfo.FTrackingTabVisibleIndex := -1;
  if IsFocused then
    ControlViewInfo.FFocusedTabVisibleIndex := -1;
  TabsViewInfo.FViewInfos.Delete(VisibleIndex);
end;

function TcxTabViewInfo.GetCanvas: TcxCanvas;
begin
  Result := ControlViewInfo.Canvas;
end;

function TcxTabViewInfo.GetCaption: string;
begin
  Result := Tab.Caption;
end;

function TcxTabViewInfo.GetCloseButtonInfo: TcxPCTabCloseButtonViewInfo;
begin
  if HasCloseButton and (FCloseButtonInfo = nil) then
    FCloseButtonInfo := TcxPCTabCloseButtonViewInfo.Create(Self);
  Result := FCloseButtonInfo;
end;

function TcxTabViewInfo.GetCloseButtonRect: TRect;
begin
  if HasCloseButton then
    Result := CloseButtonInfo.Bounds
  else
    Result := cxEmptyRect;
end;

function TcxTabViewInfo.GetColor: TColor;
begin
  Result := Tab.Color;
end;

function TcxTabViewInfo.GetContentOffset: TcxPCWOffset;
begin
  if FIsTextTooLong then
    Result := Painter.GetTooNarrowTabContentWOffset(VisibleIndex)
  else
    Result := Painter.GetTabContentWOffset(VisibleIndex);
end;

function TcxTabViewInfo.GetIndex: Integer;
begin
  Result := Tab.Index;
end;

function TcxTabViewInfo.GetImageIndex: Integer;
begin
  Result := Tab.ImageIndex;
end;

function TcxTabViewInfo.GetFullRect: TRect;
begin
  Result := NormalRect;
  CorrectRect(Result, Painter.GetTabCorrection(VisibleIndex));
end;

function TcxTabViewInfo.GetEnabled: Boolean;
begin
  Result := Tab.Enabled;
end;

function TcxTabViewInfo.GetImageAreaWidth: Integer;
begin
  Result := ControlViewInfo.GetTabImageAreaWidth;
end;

function TcxTabViewInfo.GetNormalLongitudinalSize: Integer;
begin
  if ControlViewInfo.ActuallyRotate then
    Result := TabsViewinfo.TabNormalHeight
  else
    Result := FNormalWidth;
end;

function TcxTabViewInfo.GetNormalRect: TRect;
begin
  Result.Left := FNormalPosition.X;
  Result.Top := FNormalPosition.Y;
  if ControlViewInfo.IsVerticalText then
  begin
    Result.Right := Result.Left + TabsViewInfo.TabNormalHeight;
    if ControlViewInfo.ActuallyRotate then
      Result.Bottom := Result.Top + ControlViewInfo.RowHeight
    else
      Result.Bottom := Result.Top + FNormalWidth;
  end
  else
  begin
    if ControlViewInfo.ActuallyRotate then
      Result.Right := Result.Left + ControlViewInfo.RowHeight
    else
      Result.Right := Result.Left + FNormalWidth;
    Result.Bottom := Result.Top + TabsViewinfo.TabNormalHeight;
  end;
end;

function TcxTabViewInfo.GetPainter: TcxPCCustomPainter;
begin
  Result := ControlViewInfo.Painter;
end;

function TcxTabViewInfo.GetPaintingPosition: TcxTabPosition;
var
  AIsY: Boolean;
begin
  AIsY := ControlViewInfo.TabPosition in [tpTop, tpBottom];
  if VisibleRow < ControlViewInfo.TopOrLeftPartRowCount then
    if AIsY then
      Result := tpTop
    else
      Result := tpLeft
  else
    if AIsY then
      Result := tpBottom
    else
      Result := tpRight;
end;

function TcxTabViewInfo.GetPaintingPositionIndex: Integer;
const
  PaintingPositionIndexMap: array [TcxTabPosition, TcxRotationAngle] of Integer = (
//  0  +90 -90 180
    (1,  2,  3,  0),     // Top
    (10, 11, 12, 0),     // Bottom
    (6,  4,  5,  0),     // Left
    (9,  7,  8,  0)      // Right
  );
begin
  Result := PaintingPositionIndexMap[PaintingPosition, ControlViewInfo.GetTextRotationAngle];
end;

function TcxTabViewInfo.GetProperties: TcxCustomTabControlProperties;
begin
  Result := ControlViewInfo.Properties;
end;

function TcxTabViewInfo.GetAbsolutePartRect(const APartRect: TRect): TRect;
var
  ATabRect: TRect;
begin
  Result := APartRect;
  if ControlViewInfo.IsNativePainting then
  begin
    ATabRect := FullRect;
    if IsMainTab then
      ATabRect := Painter.GetExtendedRect(ATabRect, Rect(0, 0, 0, -1), PaintingPosition);
    case ControlViewInfo.GetTextRotationAngle of
      raPlus90:
        with Result do
          Result := Rect(Top, cxRectHeight(FullRect) - Right, Bottom, cxRectHeight(FullRect) - Left);
      raMinus90:
        with Result do
          Result := Rect(cxRectWidth(FullRect) - Bottom, Left, cxRectWidth(FullRect) - Top, Right);
    end;
    Result := cxRectOffset(Result, ATabRect.TopLeft);
  end;
end;

function TcxTabViewInfo.GetTabRect: TRect;
begin
  Result := FullRect;
  if ControlViewInfo.IsNativePainting then
    if ControlViewInfo.IsVerticalText then
      Result := Rect(0, 0, cxRectHeight(Result), cxRectWidth(Result))
    else
      Result := Rect(0, 0, cxRectWidth(Result), cxRectHeight(Result));
end;

function TcxTabViewInfo.GetTabImageAndTextRect: TRect;
var
  ACloseButtonAreaWidth: Integer;
  AAngle: TcxRotationAngle;
begin
  Result := FContentRect;
  ACloseButtonAreaWidth := IfThen(HasCloseButton, Painter.GetCloseButtonAreaWidth(VisibleIndex));
  AAngle := InternalGetTextRotationAngle(ControlViewInfo);
  if InternalIsVerticalText(ControlViewInfo) then
  begin
    if (AAngle = raPlus90) xor IsCloseButtonPlacedFirst then
      Inc(Result.Top, ACloseButtonAreaWidth)
    else
      Dec(Result.Bottom, ACloseButtonAreaWidth);
  end
  else
  begin
    if IsCloseButtonPlacedFirst then
      Inc(Result.Left, ACloseButtonAreaWidth)
    else
      Dec(Result.Right, ACloseButtonAreaWidth);
  end;
end;

function TcxTabViewInfo.GetVisibleIndex: Integer;
begin
  Result := TabsViewInfo.IndexOf(Self);
end;

function TcxTabViewInfo.GetVisibleRect: TRect;
begin
  if not ActuallyVisible then
    Result := cxEmptyRect
  else
    IntersectRect(Result, FullRect, ControlViewInfo.GetTabExtendedTabsRect(Self));
end;

function TcxTabViewInfo.IsImagesAssigned: Boolean;
begin
  Result := ControlViewInfo.IsTabImagesAssigned;
end;

procedure TcxTabViewInfo.SetCloseButtonRect(const Value: TRect);
begin
  if HasCloseButton then
    CloseButtonInfo.Bounds := Value;
end;

{ TcxPCNewButtonViewInfo }

function TcxPCNewButtonViewInfo.CanFocus: Boolean;
begin
  Result := not Properties.ActivateFocusedTab and ActuallyEnabled;
end;

procedure TcxPCNewButtonViewInfo.CorrectTabNormalWidth(var AValue: Integer);
begin
// do nothing
end;

function TcxPCNewButtonViewInfo.GetDefinedWidth: Integer;
begin
  Result := Button.Width;
end;

function TcxPCNewButtonViewInfo.HasCloseButton: Boolean;
begin
  Result := False;
end;

function TcxPCNewButtonViewInfo.IsVisibleForGoDialog: Boolean;
begin
  Result := False;
end;

function TcxPCNewButtonViewInfo.CanClick: Boolean;
begin
  Result := ActuallyEnabled;
end;

function TcxPCNewButtonViewInfo.CanMultiSelect: Boolean;
begin
  Result := False;
end;

function TcxPCNewButtonViewInfo.CanSelect: Boolean;
begin
  Result := False;
end;

procedure TcxPCNewButtonViewInfo.DoClick(AShift: TShiftState);
begin
  Properties.NewButtonClick;
end;

function TcxPCNewButtonViewInfo.GetButton: TcxPCNewButton;
begin
  Result := TcxPCNewButton(Tab);
end;

{ TcxTabsViewInfo }

constructor TcxTabsViewInfo.Create(ATabs: TcxTabs; AControlViewInfo: TcxCustomTabControlViewInfo);
begin
  inherited Create;
  FControlViewInfo := AControlViewInfo;
  FTabs := ATabs;
  FViewInfos := TObjectList.Create;
  CreateViewInfos;
  Tabs.ChangedHandlers.Add(TabsChangedHandler);
  Tabs.DestroyHandlers.Add(TabsDestroyHandler);
end;

destructor TcxTabsViewInfo.Destroy;
begin
  if Tabs <> nil then
  begin
    Tabs.DestroyHandlers.Remove(TabsDestroyHandler);
    Tabs.ChangedHandlers.Remove(TabsChangedHandler);
  end;
  DestroyViewInfos;
  FreeAndNil(FViewInfos);
  inherited;
end;

procedure TcxTabsViewInfo.CalculateNormalSizes;
var
  I: Integer;
begin
  FTabNormalHeight := ControlViewInfo.Painter.CalculateTabNormalHeight;
  for I := 0 to ViewInfoCount - 1 do
    ViewInfos[I].CalculateNormalWidth;
end;

procedure TcxTabsViewInfo.CalculateTabParts;
var
  I: Integer;
begin
  for I := 0 to ViewInfoCount - 1 do
    ViewInfos[I].CalculateParts;
end;

function TcxTabsViewInfo.GetTabDefaultHeight: Integer;
begin
  Result := ControlViewInfo.Properties.TabHeight;
end;

procedure TcxTabsViewInfo.AddViewInfo(AViewInfo: TcxTabViewInfo);
begin
  FViewInfos.Add(AViewInfo);
end;

function TcxTabsViewInfo.GetMaxMainTabIndex: Integer;
begin
  Result := ViewInfoCount - 1;
  while (Result > 0) and (ViewInfos[Result].Index < 0) do
    Dec(Result);
end;

function TcxTabsViewInfo.IndexOf(AViewInfo: TcxTabViewInfo): Integer;
begin
  Result := FViewInfos.IndexOf(AViewInfo);
end;

procedure TcxTabsViewInfo.CreateViewInfos;

  function CreateTabViewInfo(ATab: TcxTab): TcxTabViewInfo;
  begin
    Result := ATab.GetViewInfoClass.Create(ATab, Self);
  end;
  
var
  I: Integer;
  ATab: TcxTab;
begin
  for I := 0 to ControlViewInfo.Properties.Tabs.Count - 1 do
  begin
    ATab := ControlViewInfo.Properties.Tabs[I];
    if ATab.Visible then
      AddViewInfo(CreateTabViewInfo(ATab));
  end;
  if not ControlViewInfo.Properties.IsDesigning and ControlViewInfo.Properties.NewButton.Visible then
    AddViewInfo(CreateTabViewInfo(Tabs.NewButton));
end;

procedure TcxTabsViewInfo.DestroyViewInfos;
begin
  FViewInfos.Clear;
end;

procedure TcxTabsViewInfo.RecreateViewInfos;
begin
  if ControlViewInfo.Properties.IsUpdateLocked then
    FNeedRecreateViewInfos := True
  else
    if FNeedRecreateViewInfos then
    begin
      DestroyViewInfos;
      CreateViewInfos;
      FNeedRecreateViewInfos := False;
    end;
end;

procedure TcxTabsViewInfo.CheckTabIndex;
begin
  if FNeedCheckTabIndex then
  begin
    if ControlViewInfo.MainTabVisibleIndex <> -1 then
      ControlViewInfo.TabIndex := ViewInfos[ControlViewInfo.MainTabVisibleIndex].Index;
    FNeedCheckTabIndex := False;
  end;
end;

function TcxTabsViewInfo.CalculateHitTest(AHitTest: TcxCustomTabControlHitTest): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to ViewInfoCount - 1 do
    if ViewInfos[I].GetHitTest(AHitTest) then
    begin
      Result := True;
      Break;
    end;
end;

procedure TcxTabsViewInfo.RepaintTab(ATabVisibleIndex: Integer;
  ATabPropertyChanged: TcxPCTabPropertyChanged);
begin
  ControlViewInfo.RepaintTab(ATabVisibleIndex, ATabPropertyChanged);
end;

function TcxTabsViewInfo.HandleDialogChar(Key: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to ViewInfoCount - 1 do
  begin
    Result := ViewInfos[I].HandleDialogChar(Key);
    if Result then
      Break;
  end;
end;

procedure TcxTabsViewInfo.TabsChangedHandler(Sender: TObject; const AEventArgs);
var
  ATab: TcxTab;
  APropertyChanged: TcxPCTabPropertyChanged;
  AVisibleIndex: Integer;
begin
  ATab := TcxPCTabsChangedEventArgs(AEventArgs).Tab;
  APropertyChanged := TcxPCTabsChangedEventArgs(AEventArgs).PropertyChanged;

  if (APropertyChanged = tpcLayout) or
      ((APropertyChanged = tpcVisible) and ATab.Visible)then
    FNeedRecreateViewInfos := True;

  AVisibleIndex := ControlViewInfo.GetTabVisibleIndex(ATab);
  if (APropertyChanged = tpcVisible) and (AVisibleIndex <> -1) then
  begin
    FNeedCheckTabIndex := FNeedCheckTabIndex or
      (ControlViewInfo.Properties.TabIndexTabMustBeVisible and ViewInfos[AVisibleIndex].IsMainTab);
    FViewInfos.Delete(AVisibleIndex);
  end;

  if not Tabs.Properties.IsUpdateLocked then
  begin
    if APropertyChanged in [tpcLayout, tpcVisible] then
      ControlViewInfo.IControl.RequestLayout
    else
      if AVisibleIndex <> -1 then
        RepaintTab(AVisibleIndex, APropertyChanged);
  end;
end;

procedure TcxTabsViewInfo.TabsDestroyHandler(Sender: TObject; const AEventArgs);
begin
  FTabs := nil;
  ControlViewInfo.DestroyTabs;
end;

function TcxTabsViewInfo.GetViewInfoCount: Integer;
begin
  Result := FViewInfos.Count;
end;

function TcxTabsViewInfo.GetViewInfo(Index: Integer): TcxTabViewInfo;
begin
  Result := FViewInfos[Index] as TcxTabViewInfo;
end;

{ TcxCustomTabControlViewInfo }

constructor TcxCustomTabControlViewInfo.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  Supports(Owner, IcxTabControl, FIControl);
  FNavigatorButtonInfos := TObjectList.Create;

  FFirstVisibleTab := -1;
  FLastVisibleTab := -1;
  FTrackingTabVisibleIndex := -1;
  FFocusedTabVisibleIndex := -1;
  FHotTrackTabVisibleIndex := -1;
  FMainTabVisibleIndex := -1;
  FPressedTabVisibleIndex := -1;

  FTabsViewInfo := Properties.Tabs.GetViewInfoClass.Create(Properties.Tabs, Self);
end;

destructor TcxCustomTabControlViewInfo.Destroy;
begin
  DestroyTabs;
  FreeAndNil(FNavigatorButtonInfos);
  FIControl := nil;
  inherited;
end;

procedure TcxCustomTabControlViewInfo.Calculate;

  procedure SynchronizeTabImagesRotationAngle;
  begin
    Properties.FImages.ImageRotationAngle := InternalGetTextRotationAngle(Self);
  end;

begin
  if FUpdating then
    Exit;

  FUpdating := True;
  try
    DoCalculate;

    SynchronizeTabImagesRotationAngle;
    SynchronizeHotTrackStates(InternalGetShiftState);
  finally
    FUpdating := False;
  end;
end;

function TcxCustomTabControlViewInfo.GetPainterClass: TcxPCPainterClass;

  function GetRealStyle: TcxPCStyleID;
  var
    AStyleID: TcxPCStyleID;
  begin
    if Properties.Style <> cxPCDefaultStyle then
      Result := Properties.Style
    else
    begin
      AStyleID := PaintersFactory.GetStyleID(GetLookAndFeel);
      if AStyleID = cxPCNoStyle then
        Result := PaintersFactory.GetDefaultStyleID(GetLookAndFeel)
      else
        Result := AStyleID;
    end;
  end;

begin
  Result := PaintersFactory.GetPainterClass(GetRealStyle);
end;

procedure TcxCustomTabControlViewInfo.CalculateHitTest(AHitTest: TcxCustomTabControlHitTest);

  function CalculateNavigatorButtonsHitTest(AHitTest: TcxCustomTabControlHitTest): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to NavigatorButtonCount - 1 do
      if NavigatorButtonInfos[I].GetHitTest(AHitTest) then
      begin
        Result := True;
        Break;
      end;
  end;

begin
  if not CalculateNavigatorButtonsHitTest(AHitTest) then
    TabsViewInfo.CalculateHitTest(AHitTest);
end;

function TcxCustomTabControlViewInfo.CanFocusOnClick(X, Y: Integer): Boolean;
var
  ATabIndex: Integer;
begin
  ATabIndex := VisibleIndexOfTabAt(X, Y);
  Result := (ATabIndex <> -1) and (TabsViewInfo[ATabIndex].Index = TabIndex);
end;

procedure TcxCustomTabControlViewInfo.CalculateLongitudinalTabPositions;

  procedure InternalCalculateLongitudinalTabPositions(
    AFirstIndex, ALastIndex: Integer; ACalculateAll: Boolean = False; Row: Integer = 0);
  var
    I: Integer;
    ALineStartPosition, ALineFinishPosition: Integer;
    ATabStartPosition, ATabFinishPosition, ATabWidth: Integer;
    ADistanceBetweenTabs: Integer;
    AIsY: Boolean;
    ASign: Integer;
    APos: TPoint;
  begin
    AIsY := Properties.TabPosition in [tpLeft, tpRight];
    ALineStartPosition := PointGetter(FTabsPosition.NormalTabsRect.TopLeft, AIsY);
    ASign := 1;
    if IsRightToLeftAlignment or IsBottomToTopAlignment then
    begin
      ALineFinishPosition := -ALineStartPosition;
      Inc(ALineStartPosition, FTabsPosition.NormalRowWidth - 1);
      ASign := -1;
    end
    else
      ALineFinishPosition := ALineStartPosition + FTabsPosition.NormalRowWidth - 1;
    ADistanceBetweenTabs := DistanceGetter(Painter.GetTabsNormalDistance, not ActuallyRotate);

    ATabStartPosition := ALineStartPosition;
    ATabFinishPosition := ATabStartPosition;
    for I := AFirstIndex to ALastIndex do
    begin
      FLastVisibleTab := I;
      ATabWidth := TabsViewInfo[I].NormalLongitudinalSize;
      ATabFinishPosition := ATabStartPosition + (ATabWidth - 1) * ASign;
      APos := TabsViewInfo[I].NormalPosition;
      if ASign > 0 then
        PointSetter(APos, AIsY, ATabStartPosition)
      else
        PointSetter(APos, AIsY, ATabFinishPosition);
      TabsViewInfo[I].NormalPosition := APos;

      ATabStartPosition := ATabFinishPosition + (1 + ADistanceBetweenTabs) * ASign;
      if (ATabStartPosition * ASign > ALineFinishPosition) and (not ACalculateAll) then
        Break;
    end;
    FIsLastTabFullyVisible := (ATabFinishPosition * ASign <= ALineFinishPosition)
      and (FLastVisibleTab = ALastIndex);
  end;

  procedure NotMultiLineCalculateLongitudinalTabPositions;
  var
    APrevFirstVisibleTab: Integer;
  begin
    APrevFirstVisibleTab := FFirstVisibleTab;
    FFirstVisibleTab := 0;

    UpdateTabPosition(Properties.GetNavigatorButtons(True));
    if IsTooSmallControlSize then Exit;
    InternalCalculateLongitudinalTabPositions(FFirstVisibleTab, TabsViewInfo.ViewInfoCount - 1, True);

    if not FIsLastTabFullyVisible then
    begin
      FFirstVisibleTab := APrevFirstVisibleTab;

      UpdateTabPosition(Properties.GetNavigatorButtons(False));
      if IsTooSmallControlSize then Exit;

      InternalCalculateLongitudinalTabPositions(FFirstVisibleTab, TabsViewInfo.ViewInfoCount - 1);

      if FIsLastTabFullyVisible then
        while FFirstVisibleTab > 0 do
        begin
          Dec(FFirstVisibleTab);
          InternalCalculateLongitudinalTabPositions(FFirstVisibleTab, TabsViewInfo.ViewInfoCount - 1);
          if not FIsLastTabFullyVisible then
          begin
            Inc(FFirstVisibleTab);
            InternalCalculateLongitudinalTabPositions(FFirstVisibleTab, TabsViewInfo.ViewInfoCount - 1);
            Break;
          end;
        end;
    end;
    UpdateButtonsState;
  end;

  procedure MultiLineCalculateLongitudinalTabPositions;
  var
    ALineFreeSpaceWidth, ALineFreeSpaceWidthRest, ATotalTabsNormalWidth: Integer;
    ALineIndexBoundsA: TcxPCLineIndexBoundsArray;

    procedure StretchTabWidths(Row: Integer);
    var
      I: Integer;
      ATabNormalWidth: Integer;
    begin
      ALineFreeSpaceWidthRest := ALineFreeSpaceWidth;
      for I := ALineIndexBoundsA[Row].Left to ALineIndexBoundsA[Row].Right do
      begin
        if I = ALineIndexBoundsA[Row].Right then
          ATabNormalWidth := ALineFreeSpaceWidthRest
        else
          ATabNormalWidth := TabsViewInfo[I].NormalWidth * ALineFreeSpaceWidth div ATotalTabsNormalWidth;
        Dec(ALineFreeSpaceWidthRest, ATabNormalWidth);
        TabsViewInfo[I].NormalWidth := TabsViewInfo[I].NormalWidth  + ATabNormalWidth;
      end;
    end;

  var
    ARow: Integer;
    AToStretchTabs: Boolean;
    ADistanceBetweenTabs: Integer;
  begin
    UpdateTabPosition([]);
    if IsTooSmallControlSize then Exit;
    InitializeLineBoundsA(ALineIndexBoundsA, 0, TabsViewInfo.ViewInfoCount - 1);
    AToStretchTabs := not(ActuallyRotate or Properties.RaggedRight);
    ADistanceBetweenTabs := DistanceGetter(Painter.GetTabsNormalDistance, not ActuallyRotate);
    for ARow := 0 to RowCount - 1 do
    begin
      if AToStretchTabs then
      begin
        ATotalTabsNormalWidth := GetLineWidth(ALineIndexBoundsA, ARow, 0);
        ALineFreeSpaceWidth := FTabsPosition.NormalRowWidth - GetLineWidth(ALineIndexBoundsA, ARow, ADistanceBetweenTabs);
        if ALineFreeSpaceWidth > 0 then StretchTabWidths(ARow);
      end;
      InternalCalculateLongitudinalTabPositions(ALineIndexBoundsA[ARow].Left, ALineIndexBoundsA[ARow].Right, False, ARow);
    end;
  end;

  procedure SetLongitudinalExtendedTabsRectsBounds;
  begin
    if Properties.TabPosition in [tpTop, tpBottom] then
    begin
      with FTabsPosition do
      begin
        FExtendedBottomOrRightTabsRect.Left := ExtendedTabsRect.Left;
        FExtendedBottomOrRightTabsRect.Right := ExtendedTabsRect.Right;
        FExtendedTopOrLeftTabsRect.Left := ExtendedTabsRect.Left;
        FExtendedTopOrLeftTabsRect.Right := ExtendedTabsRect.Right;
      end;
    end else
    begin
      with FTabsPosition do
      begin
        FExtendedBottomOrRightTabsRect.Top := ExtendedTabsRect.Top;
        FExtendedBottomOrRightTabsRect.Bottom := ExtendedTabsRect.Bottom;
        FExtendedTopOrLeftTabsRect.Top := ExtendedTabsRect.Top;
        FExtendedTopOrLeftTabsRect.Bottom := ExtendedTabsRect.Bottom;
      end;
    end;
  end;

begin
  if TabsViewInfo.ViewInfoCount = 0 then
    Exit;
  if FRowCount > 1(*MultiLine*) then
    MultiLineCalculateLongitudinalTabPositions
  else
    NotMultiLineCalculateLongitudinalTabPositions;
  if not IsTooSmallControlSize then
    SetLongitudinalExtendedTabsRectsBounds;
end;

procedure TcxCustomTabControlViewInfo.CalculateRowHeight;

  function GetMaxWidthTabVisibleIndex: Integer;
  var
    AFirstIndex, ALastIndex, AMaxTabWidth, I: Integer;
  begin
    Result := -1;
    AMaxTabWidth := 0;
    if pcoFixedTabWidthWhenRotated in Properties.Options then
    begin
      AFirstIndex := 0;
      ALastIndex := TabsViewInfo.ViewInfoCount - 1;
    end
    else
      InitializeVisibleTabRange(AFirstIndex, ALastIndex);
    for I := AFirstIndex to ALastIndex do
      if TabsViewInfo[I].NormalWidth > AMaxTabWidth then
      begin
        AMaxTabWidth := TabsViewInfo[I].NormalWidth;
        Result := I;
      end;
  end;

var
  AMaxWidthTabVisibleIndex: Integer;
  ATabViewInfo: TcxTabViewInfo;
begin
  if ActuallyRotate then
  begin
    AMaxWidthTabVisibleIndex := GetMaxWidthTabVisibleIndex;
    if AMaxWidthTabVisibleIndex <> -1 then
    begin
      ATabViewInfo := TabsViewInfo[AMaxWidthTabVisibleIndex];
      FMaxTabCaptionWidth := TextSize(ATabViewInfo, ATabViewInfo.Caption).cx;
      FRowHeight := ATabViewInfo.NormalWidth;
    end
    else
    begin
      FMaxTabCaptionWidth := 0;
      FRowHeight := 0;
    end;
    if (ActuallyRotatedTabsMaxWidth > 0) and
      (ActuallyRotatedTabsMaxWidth >= Painter.GetMinTabNormalWidth(-1)) and
      (RowHeight > ActuallyRotatedTabsMaxWidth) then
        FRowHeight := ActuallyRotatedTabsMaxWidth;
  end
  else
    FRowHeight := TabsViewinfo.FTabNormalHeight;
end;

procedure TcxCustomTabControlViewInfo.CalculateRowPositions;
var
  ANormalTopBorder, ANormalBottomBorder: Integer;
  AExtendedTopBorder, AExtendedBottomBorder: Integer;
  ATabsDistance: Integer;
  AIsY: Boolean;

  procedure InitializeVariables;
  begin
    ATabsDistance := DistanceGetter(Painter.GetTabsNormalDistance, ActuallyRotate);
    AIsY := Properties.TabPosition in [tpTop, tpBottom];
    with FTabsPosition.NormalTabsRect do
    begin
      ANormalTopBorder := PointGetter(TopLeft, AIsY);
      ANormalBottomBorder := PointGetter(BottomRight, AIsY);
    end;
    with FTabsPosition.ExtendedTabsRect do
    begin
      AExtendedTopBorder := PointGetter(TopLeft, AIsY);
      AExtendedBottomBorder := PointGetter(BottomRight, AIsY);
    end;
  end;

  procedure SetDiametricalExtendedTabsRectsBorders;

    procedure SetInternalBorders;
    var
      ABorder: Integer;
      ABottomOrRightPartRowCount: Integer;
    begin
      with FTabsPosition do
      begin
// ExtendedTopOrLeftTabsRectBottomOrRightBorder
        ABorder := ANormalTopBorder + FTopOrLeftPartRowCount * (RowHeight + ATabsDistance);
        Dec(ABorder, ATabsDistance);
        Inc(ABorder, ExtendedTopOrLeftTabsRectBottomOrRightBorderOffset);

        if ABorder > AExtendedBottomBorder then ABorder := AExtendedBottomBorder;
        RectSetter(FExtendedTopOrLeftTabsRect, False, AIsY, ABorder);

// ExtendedBottomOrRightTabsRectTopOrLeftBorder
        ABottomOrRightPartRowCount := RowCount - FTopOrLeftPartRowCount;
        ABorder := ANormalBottomBorder - ABottomOrRightPartRowCount * (RowHeight + ATabsDistance);
        Inc(ABorder, ATabsDistance);
        Inc(ABorder, ExtendedBottomOrRightTabsRectTopOrLeftBorderOffset);

        if ABorder < AExtendedTopBorder then ABorder := AExtendedTopBorder;
        RectSetter(FExtendedBottomOrRightTabsRect, True, AIsY, ABorder);
      end;
    end;

    procedure CorrectSecondaryBorder;
    var
      ASecondaryBorderBound: Integer;
    begin
      if Properties.TabPosition in [tpTop, tpLeft] then
      begin
        ASecondaryBorderBound := PointGetter(FExtendedTopOrLeftTabsRect.BottomRight, AIsY) + FTabsPosition.MinDistanceBetweenTopOrLeftAndBottomOrRightExtendedTabsRects;
        ASecondaryBorderBound := Min(ASecondaryBorderBound, AExtendedBottomBorder);
        if PointGetter(FExtendedBottomOrRightTabsRect.TopLeft, AIsY) < ASecondaryBorderBound then
          RectSetter(FExtendedBottomOrRightTabsRect, True, AIsY, ASecondaryBorderBound);
      end
      else
      begin
        ASecondaryBorderBound := PointGetter(FExtendedBottomOrRightTabsRect.TopLeft, AIsY) - FTabsPosition.MinDistanceBetweenTopOrLeftAndBottomOrRightExtendedTabsRects;
        ASecondaryBorderBound := Max(ASecondaryBorderBound, AExtendedTopBorder);
        if PointGetter(FExtendedTopOrLeftTabsRect.BottomRight, AIsY) > ASecondaryBorderBound then
          RectSetter(FExtendedTopOrLeftTabsRect, False, AIsY, ASecondaryBorderBound);
      end;
    end;

  begin
    RectSetter(FExtendedTopOrLeftTabsRect, True, AIsY, AExtendedTopBorder);
    RectSetter(FExtendedBottomOrRightTabsRect, False, AIsY, AExtendedBottomBorder);
    SetInternalBorders;
    if (FTopOrLeftPartRowCount <> 0) and (FTopOrLeftPartRowCount <> FRowCount) then
      CorrectSecondaryBorder;
  end;

var
  I: Integer;
  C: Integer;
  APos: TPoint;
begin
  InitializeVariables;
  for I := 0 to TabsViewInfo.ViewInfoCount - 1 do
  begin
    if TabsViewInfo[I].VisibleRow < FTopOrLeftPartRowCount then
      C := ANormalTopBorder + TabsViewInfo[I].VisibleRow * (RowHeight + ATabsDistance)
    else
    begin
      C := ANormalBottomBorder - (RowCount - TabsViewInfo[I].VisibleRow) * RowHeight;
      Dec(C, (RowCount - 1 - TabsViewInfo[I].VisibleRow) * ATabsDistance);
    end;
    APos := TabsViewInfo[I].NormalPosition;
    PointSetter(APos, AIsY, C);
    TabsViewInfo[I].NormalPosition := APos;
  end;
  SetDiametricalExtendedTabsRectsBorders;
end;

procedure TcxCustomTabControlViewInfo.DoCalculate;
var
  ATabsDistance: Integer;
  ANeedCalculateSetTab: Boolean;
  APrevTabIndex: Integer;
  APrevMainTabVisibleIndex: Integer;

  function InitializeVariables: Boolean;
  begin
    NavigatorButtons := [];
    FTabsPosition := Painter.GetTabsPosition([]);
    Result := FTabsPosition.NormalRowWidth > 0;
    if Result then
      ATabsDistance := DistanceGetter(Painter.GetTabsNormalDistance, not ActuallyRotate);
  end;

  procedure MultiLineCalculate;
  begin
    if not InitializeVariables then Exit;

    PlaceVisibleTabsOnRows(FTabsPosition.NormalRowWidth, ATabsDistance);
    CalculateLongitudinalTabPositions;
    CalculateRowHeight;
    RearrangeRows;
  end;

  procedure NotMultiLineCalculate;

    procedure SetTabRows;
    var
      AFirstIndex, ALastIndex, I: Integer;
    begin
      InitializeVisibleTabRange(AFirstIndex, ALastIndex);
      for I := AFirstIndex to ALastIndex do
        with TabsViewInfo[I] do
        begin
          FRow := 0;
          FVisibleRow := 0;
        end;
    end;

  begin
    FRowCount := 1;
    FTopOrLeftPartRowCount := IfThen(Properties.TabPosition in [tpTop, tpLeft], 1, 0);
    CalculateLongitudinalTabPositions;
    if not IsTooSmallControlSize then
    begin
      SetTabRows;
      CalculateRowHeight;
      CalculateRowPositions;
    end;
  end;

  procedure ValidateTabVisibleIndex(var ATabVisibleIndex: Integer);
  begin
    if ATabVisibleIndex >= TabsViewInfo.ViewInfoCount then
      ATabVisibleIndex := -1;
  end;

  procedure ValidateTabIndex;
  begin
    if TabIndex >= Properties.Tabs.Count then
    begin
      Properties.BeginUpdate;
      try
        TabIndex := Properties.Tabs.Count - 1;
      finally
        Properties.CancelUpdate;
      end;
    end;
  end;

  procedure ValidateTabVisibleIndexs;
  begin
    ValidateTabIndex;
    ValidateTabVisibleIndex(FMainTabVisibleIndex);
    ValidateTabVisibleIndex(FHotTrackTabVisibleIndex);
    ValidateTabVisibleIndex(FPressedTabVisibleIndex);
    ValidateTabVisibleIndex(FFirstVisibleTab);
    if Properties.ActivateFocusedTab then
      FFocusedTabVisibleIndex := -1;
    ValidateTabVisibleIndex(FFocusedTabVisibleIndex);
    if (FFirstVisibleTab = -1) and (TabsViewInfo.ViewInfoCount > 0) then
      FFirstVisibleTab := 0;
    ValidateTabVisibleIndex(FLastVisibleTab);
  end;

  procedure ResetControlInternalVariables;
  begin
    FExtendedBottomOrRightTabsRect := cxEmptyRect;
    FExtendedTopOrLeftTabsRect := cxEmptyRect;
    FRowCount := 0;
    FTopOrLeftPartRowCount := 0;
  end;

  procedure CheckViewInfos;
  begin
    TabsViewInfo.RecreateViewInfos;
  end;

begin
  CheckViewInfos;

  APrevTabIndex := TabIndex;
  APrevMainTabVisibleIndex := MainTabVisibleIndex;
  ResetControlInternalVariables;
  ValidateTabVisibleIndexs;
  if TabsViewInfo.ViewInfoCount = 0 then
  begin
    InitializeVariables;
    TabsViewInfo.CheckTabIndex;
    Exit;
  end;
  Painter.Init;
  TabsViewInfo.CalculateNormalSizes;
  if APrevTabIndex = TabIndex then
  begin
    ANeedCalculateSetTab := (TabIndex = -1) and (MainTabVisibleIndex <> -1);
    ANeedCalculateSetTab := ANeedCalculateSetTab or
      ((TabIndex > -1) and (GetTabVisibleIndex(Properties.Tabs[TabIndex]) <> MainTabVisibleIndex));
    if ANeedCalculateSetTab then
    begin
      NavigatorButtons := Properties.GetNavigatorButtons(False);
      SetMainTab;
    end;
  end;
  FLastVisibleTab := FFirstVisibleTab;
  if Properties.MultiLine then
    MultiLineCalculate
  else
    NotMultiLineCalculate;
  FMainTabVisibleIndex := APrevMainTabVisibleIndex;
  SetMainTab;
  TabsViewInfo.CheckTabIndex;
  TabsViewInfo.CalculateTabParts;
end;

procedure TcxCustomTabControlViewInfo.AfterPaintTab(ACanvas: TcxCanvas; ATab: TcxTab;
  AImageAndTextData: TcxPCOutTabImageAndTextData);
begin
end;

function TcxCustomTabControlViewInfo.ArrowButtonClick(ANavigatorButton: TcxPCNavigatorButton): Boolean;

  function GetDirection: Integer;
  begin
    if (IsSpecialAlignment and (ANavigatorButton = nbTopLeft)) or
       ((not IsSpecialAlignment) and (ANavigatorButton = nbBottomRight)) then
      Result := 1
    else
      Result := -1;
  end;

begin
  Result := NavigatorButtonInfoByType[ANavigatorButton].State <> nbsDisabled;
  if Result then
    Inc(FFirstVisibleTab, GetDirection);
end;

procedure TcxCustomTabControlViewInfo.ElementDestroying(AElementInfo: TcxPCCustomElementViewInfo);
begin
  if Controller.HitTest.HitObject = AElementInfo then
    Controller.HitTest.Clear;
  if FPressedNavigatorButton = AElementInfo then
    FPressedNavigatorButton := nil;
  if FPressedTabCloseButton = AElementInfo then
    FPressedTabCloseButton := nil;
  if FHotTrackTabCloseButton = AElementInfo then
    FHotTrackTabCloseButton := nil;
  if FHotTrackNavigatorButton = AElementInfo then
    FHotTrackNavigatorButton := nil;
end;

procedure TcxCustomTabControlViewInfo.CorrectFirstVisibleTab(ATabVisibleIndex: Integer);
var
  C: Integer;
  ADistanceBetweenTabs: Integer;
begin
  if ATabVisibleIndex < FFirstVisibleTab then
    FFirstVisibleTab := ATabVisibleIndex
  else
    if (ATabVisibleIndex = FLastVisibleTab) and FIsLastTabFullyVisible then
      Exit
    else
      if ATabVisibleIndex >= FLastVisibleTab then
      begin
        UpdateTabPosition(FNavigatorButtons);
        ADistanceBetweenTabs := DistanceGetter(Painter.GetTabsNormalDistance, not ActuallyRotate);
        if IsTooSmallControlSize then
          FFirstVisibleTab := ATabVisibleIndex
        else
        begin
          C := TabsViewInfo[ATabVisibleIndex].NormalLongitudinalSize;
          FFirstVisibleTab := ATabVisibleIndex;
          while (C + ADistanceBetweenTabs < FTabsPosition.NormalRowWidth) and (FFirstVisibleTab > 0) do
          begin
            Dec(FFirstVisibleTab);
            Inc(C, ADistanceBetweenTabs);
            Inc(C, TabsViewInfo[FFirstVisibleTab].NormalLongitudinalSize);
            if C > FTabsPosition.NormalRowWidth then
              Inc(FFirstVisibleTab);
          end;
        end;
      end;
end;

function TcxCustomTabControlViewInfo.GetActivePageColor: TColor;
begin
  Result := clNone;
end;

function TcxCustomTabControlViewInfo.GetNavigatorButtonInfoByType(
  AType: TcxPCNavigatorButton): TcxPCNavigatorButtonViewInfo;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FNavigatorButtonInfos.Count - 1 do
    if NavigatorButtonInfos[I].ButtonType = AType then
    begin
      Result := NavigatorButtonInfos[I];
      Break;
    end;
end;

function TcxCustomTabControlViewInfo.GetNextFocusedTabVisibleIndex(ACurrentTabVisibleIndex,
  ADelta: Integer; ACycle: Boolean; AOnlyAllowSelectedTabs: Boolean): Integer;

  procedure PopulateFocusibleTabs(AList: TList);
  var
    I: Integer;
  begin
    for I := 0 to TabsViewInfo.ViewInfoCount - 1 do
      if TabsViewInfo[I].CanFocus and (not AOnlyAllowSelectedTabs or TabsViewInfo[I].CanSelect) then
        AList.Add(TabsViewInfo[I]);
  end;

  function CheckIndex(AIndex: Integer; AList: TList): Boolean;
  begin
    Result := (AIndex >= 0) and (AIndex < AList.Count);
  end;

  function GetNextIndex(var ATabVisibleIndex: Integer; AList: TList): Boolean;
  begin
    Inc(ATabVisibleIndex, ADelta);
    Result := CheckIndex(ATabVisibleIndex, AList);
    if not Result and ACycle then
    begin
      if ATabVisibleIndex < 0 then
        Inc(ATabVisibleIndex, AList.Count)
      else
        Dec(ATabVisibleIndex, AList.Count);
      Result := CheckIndex(ATabVisibleIndex, AList);
    end;
    if Result then
      ATabVisibleIndex := TcxTabViewInfo(AList[ATabVisibleIndex]).VisibleIndex;
  end;

var
  AList: TList;
  ATabVisibleIndex: Integer;
begin
  Result := -1;
  AList := TList.Create;
  try
    PopulateFocusibleTabs(AList);
    if AList.Count > 1 then
    begin
      ATabVisibleIndex := AList.IndexOf(TabsViewInfo[ACurrentTabVisibleIndex]);
      if GetNextIndex(ATabVisibleIndex, AList) then
        Result := ATabVisibleIndex;
    end;
  finally
    AList.Free;
  end;
end;

function TcxCustomTabControlViewInfo.GetTabColor(ATabVisibleIndex: Integer): TColor;
begin
  Result := TabsViewInfo[ATabVisibleIndex].Color;
end;

function TcxCustomTabControlViewInfo.GetTabExtendedTabsRect(ATabViewInfo: TcxTabViewInfo): TRect;
begin
  if ATabViewInfo.VisibleRow < FTopOrLeftPartRowCount then
    Result := FExtendedTopOrLeftTabsRect
  else
    Result := FExtendedBottomOrRightTabsRect
end;

function TcxCustomTabControlViewInfo.GetTabExtendedTabsRect(ATabVisibleIndex: Integer): TRect;
begin
  Result := GetTabExtendedTabsRect(TabsViewInfo[ATabVisibleIndex]);
end;

function TcxCustomTabControlViewInfo.GetTabImageAreaWidth: Integer;
begin
  Result := GetTabImageSize.cx + 2 * ImageBorder;
end;

function TcxCustomTabControlViewInfo.GetTabImageAreaHeight: Integer;
begin
  Result := GetTabImageSize.cy + 2 * ImageBorder;
end;

procedure TcxCustomTabControlViewInfo.InitializeLineBoundsA(var ALineIndexBoundsA:
  TcxPCLineIndexBoundsArray; AFirstIndex, ALastIndex: Integer);
var
  I, ALineIndex: Integer;
  AFirstRow, ARowCount: Integer;
begin
  AFirstRow := TabsViewInfo[AFirstIndex].FRow;
  ARowCount := TabsViewInfo[ALastIndex].FRow - AFirstRow + 1;
  SetLength(ALineIndexBoundsA, ARowCount);
  ALineIndex := 0;
  ALineIndexBoundsA[0].Left := AFirstIndex;
  for I := AFirstIndex to ALastIndex do
    if TabsViewInfo[I].FRow - AFirstRow > ALineIndex then
    begin
      ALineIndexBoundsA[ALineIndex].Right := I - 1;
      Inc(ALineIndex);
      ALineIndexBoundsA[ALineIndex].Left := I;
    end;
  ALineIndexBoundsA[ALineIndex].Right := ALastIndex;
end;

function TcxCustomTabControlViewInfo.HasActivePage: Boolean;
begin
  Result := False;
end;

function TcxCustomTabControlViewInfo.HasBorders: Boolean;
begin
  Result := True;
end;

procedure TcxCustomTabControlViewInfo.MakeTabVisible(ATabVisibleIndex: Integer);
const
  ADeltaMap: array[Boolean] of Integer = (-1, 1);
var
  ADelta: Integer;
begin
  if ATabVisibleIndex > LastVisibleTab then
    ADelta := ATabVisibleIndex - LastVisibleTab
  else
    ADelta := ATabVisibleIndex - FirstVisibleTab;
  Controller.ScrollTabs(ADelta);
  while not IsFullVisible(ATabVisibleIndex) and (ATabVisibleIndex <> FirstVisibleTab) do
    Controller.ScrollTabs(ADeltaMap[ADelta > 0]);
end;

procedure TcxCustomTabControlViewInfo.PlaceVisibleTabsOnRows(ATabsWidth, ATabsDistance: Integer);

  procedure InternalImproveTabsLayout(var ALineBoundsA: TcxPCLineIndexBoundsArray);

    function Deviation(const ALineBoundsA: TcxPCLineIndexBoundsArray; ALineIndex: Integer): Double;
    begin
      Result := Power(ATabsWidth - GetLineWidth(ALineBoundsA, ALineIndex, ATabsDistance), 2);
    end;

    function TotalDeviation(const ALineBoundsA: TcxPCLineIndexBoundsArray): Double;
    var
      I: Integer;
    begin
      Result := 0;
      for I := 0 to Length(ALineBoundsA) - 1 do
        Result := Result + Deviation(ALineBoundsA, I);
    end;

    procedure CopyBounds(var ASource, ADestination: TcxPCLineIndexBoundsArray);
    var
      I: Integer;
    begin
      if Length(ASource) <> Length(ADestination) then
        SetLength(ADestination, Length(ASource));
      for I := 0 to Length(ASource) - 1 do
        ADestination[I] := ASource[I];
    end;

    function DoBest(var ALineBoundsA: TcxPCLineIndexBoundsArray; ALineIndex: Integer; ADirection: Integer): Boolean;

      procedure DoChange(var ALineBoundsA: TcxPCLineIndexBoundsArray; ALineIndex: Integer);
      begin
        case ADirection of
          -1:
            if ALineIndex > 0 then
            begin
              Dec(ALineBoundsA[ALineIndex].Left);
              Dec(ALineBoundsA[ALineIndex - 1].Right);
            end;
          1:
            if ALineIndex < Length(ALineBoundsA) - 1 then
            begin
              Inc(ALineBoundsA[ALineIndex].Right);
              Inc(ALineBoundsA[ALineIndex + 1].Left);
            end;
        end;
      end;

    var
      APrevError, ANewError: Double;
      ATempLineBoundsA: TcxPCLineIndexBoundsArray;
    begin
      CopyBounds(ALineBoundsA, ATempLineBoundsA);
      APrevError := Deviation(ATempLineBoundsA, ALineIndex);

      DoChange(ATempLineBoundsA, ALineIndex);

      ANewError := Deviation(ATempLineBoundsA, ALineIndex);
      Result := (ANewError < APrevError) and (GetLineWidth(ATempLineBoundsA, ALineIndex, ATabsDistance) <= ATabsWidth);
      if Result then
        CopyBounds(ATempLineBoundsA, ALineBoundsA);
    end;

    function DoComplexBest(ACurrentError: Double; var ALineBoundsA: TcxPCLineIndexBoundsArray): Boolean;
    var
      I: Integer;
      ATempLineBoundsA: TcxPCLineIndexBoundsArray;
      APrevDeviation: Double;
    begin
      Result := False;
      CopyBounds(ALineBoundsA, ATempLineBoundsA);
      for I := Length(ATempLineBoundsA) - 1 downto 0 do
      begin
        repeat
          APrevDeviation := TotalDeviation(ATempLineBoundsA);
        until not DoBest(ATempLineBoundsA, I, -1) or (APrevDeviation < TotalDeviation(ATempLineBoundsA));

        if TotalDeviation(ATempLineBoundsA) < ACurrentError then
        begin
          Result := True;
          CopyBounds(ATempLineBoundsA, ALineBoundsA);
          Break;
        end;
      end;
    end;

    function DoSimpleBest(var ALineBoundsA: TcxPCLineIndexBoundsArray; ADirection: Integer): Boolean;
    var
      I: Integer;
      ATempLineBoundsA: TcxPCLineIndexBoundsArray;
      ACurrentError: Double;
    begin
      Result := False;
      ACurrentError := TotalDeviation(ALineBoundsA);
      for I := 0 to Length(ALineBoundsA) - 1 do
      begin
        CopyBounds(ALineBoundsA, ATempLineBoundsA);
        DoBest(ATempLineBoundsA, I, ADirection);
        if TotalDeviation(ATempLineBoundsA) < ACurrentError then
        begin
          Result := True;
          CopyBounds(ATempLineBoundsA, ALineBoundsA);
          Break;
        end;
      end;
    end;

    function DoTotalBest(var ALineBoundsA: TcxPCLineIndexBoundsArray): Boolean;
    var
      ACurrentError: Double;
    begin
      ACurrentError := TotalDeviation(ALineBoundsA);
      Result := DoComplexBest(ACurrentError, ALineBoundsA) or
        DoSimpleBest(ALineBoundsA, 1) or
        DoSimpleBest(ALineBoundsA, -1);
    end;

  begin
    while DoTotalBest(ALineBoundsA) do {loop};
  end;

  procedure AcceptImprovements(const ALineBoundsA: TcxPCLineIndexBoundsArray);
  var
    I, ARow, ACurrentRow: Integer;
  begin
    ACurrentRow := TabsViewInfo[ALineBoundsA[0].Left].FRow;
    for ARow := 0 to Length(ALineBoundsA) - 1 do
    begin
      for I := ALineBoundsA[ARow].Left to ALineBoundsA[ARow].Right do
        TabsViewInfo[I].FRow := ACurrentRow;
      Inc(ACurrentRow);
    end;
  end;

  procedure ImproveTabsLayout(AFirstIndex, ALastIndex: Integer);
  var
    ALineIndexBoundsA: TcxPCLineIndexBoundsArray;
  begin
    if ActuallyRotate and Properties.RaggedRight then Exit;
    InitializeLineBoundsA(ALineIndexBoundsA, AFirstIndex, ALastIndex);
    InternalImproveTabsLayout(ALineIndexBoundsA);
    AcceptImprovements(ALineIndexBoundsA);
  end;

var
  AFirstIndex: Integer;
  C: Integer;
  I: Integer;
  ATabViewInfo: TcxTabViewInfo;
begin
  FRowCount := 1;
  AFirstIndex := 0;
  C := 0;
  for I := 0 to TabsViewInfo.ViewInfoCount - 1 do
  begin
    ATabViewInfo := TabsViewInfo[I];
    if ATabViewInfo.NormalLongitudinalSize >= ATabsWidth then
    begin
      if C <> 0 then
      begin
        Inc(FRowCount);
        C := 0;
      end;
      if (I > AFirstIndex{guarantees that FVisibleTabList[AFirstIndex].FRow had been set}) and
        ((FRowCount - 1) - TabsViewInfo[AFirstIndex].FRow > 1) then
        ImproveTabsLayout(AFirstIndex, I - 1);
      AFirstIndex := I + 1;
      if (not ActuallyRotate) and (ATabsWidth > Painter.GetMinTabNormalWidth(I)) then
        ATabViewInfo.NormalWidth := ATabsWidth;
      ATabViewInfo.FRow := FRowCount - 1;
      if I <> TabsViewInfo.ViewInfoCount - 1 then
        Inc(FRowCount);
    end
    else
      if C + ATabViewInfo.NormalLongitudinalSize > ATabsWidth then
      begin
        Inc(FRowCount);
        ATabViewInfo.FRow := FRowCount - 1;
        C := ATabViewInfo.NormalLongitudinalSize + ATabsDistance;
      end
      else
      begin
        ATabViewInfo.FRow := FRowCount - 1;
        Inc(C, ATabViewInfo.NormalLongitudinalSize + ATabsDistance);
      end;
  end;
  if (TabsViewInfo.ViewInfoCount - 1 > AFirstIndex) and ((FRowCount - 1) - TabsViewInfo[AFirstIndex].FRow > 0) then
    ImproveTabsLayout(AFirstIndex, TabsViewInfo.ViewInfoCount - 1);
end;

procedure TcxCustomTabControlViewInfo.RepaintTab(ATabVisibleIndex: Integer; ATabPropertyChanged: TcxPCTabPropertyChanged);
begin
  Painter.RepaintTab(ATabVisibleIndex, ATabPropertyChanged);
end;

procedure TcxCustomTabControlViewInfo.SetMainTab;
var
  AVisibleIndex: Integer;
begin
  if TabIndex = -1 then
    MainTabVisibleIndex := -1
  else
  begin
    AVisibleIndex := GetTabVisibleIndex(Properties.Tabs[TabIndex]);
    if (AVisibleIndex = -1) then
    begin
      if FMainTabVisibleIndex > TabsViewInfo.GetMaxMainTabIndex then
        MainTabVisibleIndex := TabsViewInfo.GetMaxMainTabIndex;
    end
    else
      MainTabVisibleIndex := AVisibleIndex;
  end;
end;

procedure TcxCustomTabControlViewInfo.TabDown(ATabVisibleIndex: Integer; AShift: TShiftState);
begin
  if (ATabVisibleIndex <> -1) then
  begin
    if TabsViewInfo[ATabVisibleIndex].IsPressable and not IControl.IsDesigning then
      PressedTabVisibleIndex := ATabVisibleIndex
    else
      TabsViewInfo[ATabVisibleIndex].Select(ssCtrl in AShift);
  end;
end;

procedure TcxCustomTabControlViewInfo.TabUp(ATabVisibleIndex: Integer; AShift: TShiftState);
begin
  if (ATabVisibleIndex <> -1) and TabsViewInfo[ATabVisibleIndex].IsPressable and (ATabVisibleIndex = FPressedTabVisibleIndex) then
    PressedTabVisibleIndex := -1;
end;

function TcxCustomTabControlViewInfo.UseActivePageColor: Boolean;
begin
  Result := False;
end;

procedure TcxCustomTabControlViewInfo.DestroyTabs;
begin
  FreeAndNil(FTabsViewInfo);
end;

function TcxCustomTabControlViewInfo.ActuallyRotatedTabsMaxWidth: Integer;
begin
  Result := Properties.RotatedTabsMaxWidth;
  if Result > 0 then
    Result := Max(Result, Painter.GetMinTabNormalWidth(-1));
end;

function TcxCustomTabControlViewInfo.ActuallyRotate: Boolean;
begin
  Result := Properties.Rotate and Painter.AllowRotate;
end;

function TcxCustomTabControlViewInfo.CanDrawParentBackground: Boolean;
begin
  Result := IControl.CanDrawParentBackground;
end;

function TcxCustomTabControlViewInfo.GetTabImageSize: TSize;
begin
  Result := Properties.FImages.BaseImageSize;
end;

function TcxCustomTabControlViewInfo.AllowHotTrack: Boolean;
begin
  Result := Properties.HotTrack or Painter.IsEnableHotTrack;
end;

function TcxCustomTabControlViewInfo.AllowMultiSelect: Boolean;
begin
  Result := Properties.MultiSelect and Painter.IsMultiSelectionAccepted;
end;

function TcxCustomTabControlViewInfo.CanMouseWheel(const AMousePos: TPoint): Boolean;
var
  R: TRect;
begin
  Result := False;
  if not Properties.MultiLine and (FFirstVisibleTab >= 0) then
  begin
    R := TabsViewInfo[FFirstVisibleTab].FullRect;
    Result := (Properties.TabPosition in [tpTop, tpBottom]) and (AMousePos.Y >= R.Top) and (AMousePos.Y < R.Bottom) or
      (Properties.TabPosition in [tpLeft, tpRight]) and (AMousePos.X >= R.Left) and (AMousePos.X < R.Right);
  end;
end;

function TcxCustomTabControlViewInfo.IsEnabled: Boolean;
begin
  Result := IControl.IsEnabled;
end;

function TcxCustomTabControlViewInfo.IsFocused: Boolean;
begin
  Result := IControl.IsFocused;
end;

function TcxCustomTabControlViewInfo.PtInTab(ATabVisibleIndex: Integer; X, Y: Integer): Boolean;
begin
  Result := Painter.PtInTab(ATabVisibleIndex, X, Y);
end;

function TcxCustomTabControlViewInfo.IsFullVisible(ATabVisibleIndex: Integer): Boolean;
begin
  with TabsViewInfo[ATabVisibleIndex] do
    Result := cxRectIsEqual(FullRect, VisibleRect);
end;

function TcxCustomTabControlViewInfo.IsSpecialAlignment: Boolean;
begin
  Result := IsRightToLeftAlignment or IsBottomToTopAlignment;
end;

function TcxCustomTabControlViewInfo.IsTooSmallControlSize: Boolean;
begin
  Result := FTabsPosition.NormalRowWidth <= 0;
end;

function TcxCustomTabControlViewInfo.IsTabActuallyVisible(ATabViewInfo: TcxTabViewInfo): Boolean;
begin
  Result := (Properties.MultiLine or
    ((ATabViewInfo.VisibleIndex >= FFirstVisibleTab) and
    (ATabViewInfo.VisibleIndex <= FLastVisibleTab)));
end;

function TcxCustomTabControlViewInfo.IsTabImagesAssigned: Boolean;
begin
  Result := Properties.FImages.IsImagesAssigned;
end;

function TcxCustomTabControlViewInfo.IsTabVisibleIndexValid(AIndex: Integer): Boolean;
begin
  Result := (AIndex >= 0) and (AIndex < TabsViewInfo.ViewInfoCount);
end;

function TcxCustomTabControlViewInfo.PtInScrollingArea(const P: TPoint; var ADirection: Integer): Boolean;
var
  ATabVisibleIndex: Integer;
begin
  ATabVisibleIndex := VisibleIndexOfTabAt(P.X, P.Y);
  Result := (ATabVisibleIndex > -1);
  if Result then
  begin
    ADirection := 0;
    if (ATabVisibleIndex = FirstVisibleTab) and (FirstVisibleTab > 0) then
      ADirection := -1;
    if (ATabVisibleIndex = LastVisibleTab) and
        ((LastVisibleTab < TabsViewInfo.ViewInfoCount - 1) or not FIsLastTabFullyVisible) then
      ADirection := 1;
    Result := (ADirection <> 0) and PtInRect(TabsViewInfo[ATabVisibleIndex].GetScrollingArea, P);
  end;
end;

function TcxCustomTabControlViewInfo.GetOptimalSize: Integer;
var
  ADistanceBetweenTabs, ATabFinishPosition, ATabStartPosition, ATabWidth, I: Integer;
  AIsY: Boolean;
  ALineFinishPosition, ALineStartPosition: Integer;
begin
  Result := 0;
  if TabsViewInfo.ViewInfoCount = 0 then
    Exit;
  TabsViewInfo.CalculateNormalSizes;
  UpdateTabPosition(Properties.GetNavigatorButtons(True));

  AIsY := Properties.TabPosition in [tpLeft, tpRight];
  ALineStartPosition := PointGetter(FTabsPosition.NormalTabsRect.TopLeft, AIsY);
  ALineFinishPosition := ALineStartPosition + FTabsPosition.NormalRowWidth - 1;
  ADistanceBetweenTabs := DistanceGetter(Painter.GetTabsNormalDistance, not ActuallyRotate);

  ATabStartPosition := ALineStartPosition;
  ATabFinishPosition := ATabStartPosition;
  for I := 0 to TabsViewInfo.ViewInfoCount - 1 do
  begin
    ATabWidth := TabsViewInfo[I].NormalLongitudinalSize;
    ATabFinishPosition := ATabStartPosition + ATabWidth - 1;
    ATabStartPosition := ATabFinishPosition + 1 + ADistanceBetweenTabs;
  end;
  FIsLastTabFullyVisible := (ATabFinishPosition <= ALineFinishPosition);

  if Properties.TabPosition in [tpTop, tpBottom] then
    Result := ATabFinishPosition + 1 + (Width - 1 - ALineFinishPosition)
  else
    Result := ATabFinishPosition + 1 + (Height - 1 - ALineFinishPosition);
end;

function TcxCustomTabControlViewInfo.GetLookAndFeel: TcxLookAndFeel;
begin
  Result := IControl.GetLookAndFeel;
end;

function TcxCustomTabControlViewInfo.GetTextRotationAngle: TcxRotationAngle;
begin
  if IsVerticalText then
    if pcoTopToBottomText in Properties.Options then
      Result := raMinus90
    else
      Result := raPlus90
  else
    Result := ra0;
end;

function TcxCustomTabControlViewInfo.HasTabCloseButtons: Boolean;
begin
  Result := Properties.CloseButtonMode in [cbmEveryTab, cbmActiveTab];
end;

function TcxCustomTabControlViewInfo.IndexOfTabAt(X, Y: Integer): Integer;
begin
  Result := VisibleIndexOfTabAt(X, Y);
  if Result <> -1 then
    Result := TabsViewInfo[Result].Index;
end;

procedure TcxCustomTabControlViewInfo.InitializeLineBoundsArray(var ALineIndexBoundsA: TcxPCLineIndexBoundsArray);
var
  ALineCount, I: Integer;
  AFirstIndex, ALastIndex: Integer;
begin
  SetLength(ALineIndexBoundsA, RowCount);
  if RowCount = 0 then
    Exit;
  for ALineCount := 0 to RowCount - 1 do
    ALineIndexBoundsA[ALineCount].Left := -1;
  InitializeVisibleTabRange(AFirstIndex, ALastIndex);
  for I := AFirstIndex to ALastIndex do
    with ALineIndexBoundsA[TabsViewInfo[I].VisibleRow] do
      if Left = -1 then
      begin
        Left := I;
        Right := I;
      end
      else
      begin
        if I < Left then
          Left := I;
        if I > Right then
          Right := I;
      end;
end;

procedure TcxCustomTabControlViewInfo.InitializeVisibleTabRange(var AFirstIndex, ALastIndex: Integer);
begin
  if Properties.MultiLine then
  begin
    AFirstIndex := 0;
    ALastIndex := TabsViewInfo.ViewInfoCount - 1;
  end
  else
  begin
    AFirstIndex := FFirstVisibleTab;
    if FFirstVisibleTab = -1 then
      ALastIndex := -2
    else
      ALastIndex := FLastVisibleTab;
  end;
end;

procedure TcxCustomTabControlViewInfo.InvalidateRect(const R: TRect; EraseBackground: Boolean);
begin
  IControl.InvalidateRect(R, EraseBackground);
end;

function TcxCustomTabControlViewInfo.IsBottomToTopAlignment: Boolean;
begin
  Result := (Properties.TabPosition in [tpLeft, tpRight]) and (not ActuallyRotate) and
    not(pcoTopToBottomText in Properties.Options);
end;

function TcxCustomTabControlViewInfo.IsNativePainting: Boolean;
begin
  Result := Painter.IsNativePainting;
end;

function TcxCustomTabControlViewInfo.IsRightToLeftAlignment: Boolean;
begin
  Result := (Properties.TabPosition in [tpTop, tpBottom]) and ActuallyRotate and
    (pcoTopToBottomText in Properties.Options);
end;

function TcxCustomTabControlViewInfo.IsTabsContainer: Boolean;
begin
  Result := Properties.IsTabsContainer;
end;

function TcxCustomTabControlViewInfo.IsTabsOnBothSides: Boolean;
begin
  Result := (TabPosition in [tpTop, tpLeft]) and (TopOrLeftPartRowCount <> RowCount) or
    (TabPosition in [tpBottom, tpRight]) and (TopOrLeftPartRowCount <> 0);
end;

function TcxCustomTabControlViewInfo.IsVerticalText: Boolean;
begin
  Result := (Properties.TabPosition in [tpLeft, tpRight]) and (not ActuallyRotate);
  Result := Result or (Properties.TabPosition in [tpTop, tpBottom]) and ActuallyRotate;
end;

function TcxCustomTabControlViewInfo.ParentBackground: Boolean;
begin
  Result := IControl.IsParentBackground;
end;

procedure TcxCustomTabControlViewInfo.PrepareTabCanvasFont(ATabViewInfo: TcxTabViewInfo; ACanvas: TcxCanvas);
begin
  ACanvas.Canvas.Lock;
  try
    ACanvas.Font := IControl.GetFont;
    ACanvas.Font.Color := Painter.GetTextColor(ATabViewInfo.VisibleIndex);
    Properties.DoDrawTabEx(ATabViewInfo.VisibleIndex, ACanvas.Font);
    Properties.DoPrepareTabCanvasFont(ATabViewInfo.Tab, ACanvas);
  finally
    ACanvas.Canvas.Unlock;
  end;
end;

function TcxCustomTabControlViewInfo.VisibleIndexOfTabAt(X, Y: Integer): Integer;
var
  AFirstIndex, ALastIndex, I: Integer;
begin
  Result := -1;
  if TabsViewInfo.ViewInfoCount = 0 then
    Exit;
  InitializeVisibleTabRange(AFirstIndex, ALastIndex);
  for I := AFirstIndex to ALastIndex do
    with TabsViewInfo[I] do
      if PtInRect(VisibleRect, Point(X, Y)) and PtInTab(I, X, Y) then
      begin
        Result := I;
        Break;
      end;
end;

function TcxCustomTabControlViewInfo.CanPressButton(AButton: TcxPCNavigatorButton): Boolean;
begin
  Result := True;
  case AButton of
    nbTopLeft, nbBottomRight:
      begin
        if (IsSpecialAlignment and (AButton = nbTopLeft)) or
           ((not IsSpecialAlignment) and (AButton = nbBottomRight)) then
          Result := (FLastVisibleTab < TabsViewInfo.ViewInfoCount - 1) or
            not FIsLastTabFullyVisible and (FLastVisibleTab <> FFirstVisibleTab)
        else
          Result := FFirstVisibleTab > 0;
      end;
    nbClose:
      Result := FMainTabVisibleIndex >= 0;
  end;
end;

function TcxCustomTabControlViewInfo.GetBoundsRect: TRect;
begin
  Result := IControl.GetBoundsRect;
end;

function TcxCustomTabControlViewInfo.GetCanvas: TcxCanvas;
begin
  Result := IControl.GetCanvas;
end;

function TcxCustomTabControlViewInfo.GetClientRect: TRect;
begin
  Result := cxRectOffset(BoundsRect, BoundsRect.TopLeft, False);
end;

function TcxCustomTabControlViewInfo.GetControlBounds: TRect;
begin
  Result := Rect(0, 0, Width, Height);
end;

function TcxCustomTabControlViewInfo.GetController: TcxCustomTabControlController;
begin
  Result := IControl.Controller;
end;

function TcxCustomTabControlViewInfo.GetColor: TColor;
begin
  Result := IControl.GetColor;
  if Result = clNone then
    Result := clBtnFace;
end;

function TcxCustomTabControlViewInfo.GetFocusedTabVisibleIndex: Integer;
begin
  if FFocusedTabVisibleIndex = -1 then
    Result := MainTabVisibleIndex
  else
    Result := FFocusedTabVisibleIndex;
end;

function TcxCustomTabControlViewInfo.GetFont: TFont;
begin
  Result := IControl.GetFont;
end;

function TcxCustomTabControlViewInfo.GetHideTabs: Boolean;
begin
  Result := Properties.HideTabs;
end;

function TcxCustomTabControlViewInfo.GetHeight: Integer;
begin
  Result := cxRectHeight(BoundsRect);
end;

function TcxCustomTabControlViewInfo.GetImageBorder: Integer;
begin
  Result := Properties.ImageBorder;
end;

function TcxCustomTabControlViewInfo.GetLineWidth(const ALineIndexBoundsA: TcxPCLineIndexBoundsArray;
  ALineNumber, ATabsDistance: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  with ALineIndexBoundsA[ALineNumber] do
  begin
    for I := Left to Right do
      Inc(Result, TabsViewInfo[I].NormalLongitudinalSize);
    Inc(Result, (Right - Left) * ATabsDistance);
  end;
end;

function TcxCustomTabControlViewInfo.GetMainTabIndex: Integer;
begin
  Result := -1;
  if FMainTabVisibleIndex <> -1 then
    Result := TabsViewInfo[FMainTabVisibleIndex].Index;
end;

function TcxCustomTabControlViewInfo.GetMultiLine: Boolean;
begin
  Result := Properties.MultiLine;
end;

function TcxCustomTabControlViewInfo.GetNavigatorButtonCount: Integer;
begin
  Result := FNavigatorButtonInfos.Count;
end;

function TcxCustomTabControlViewInfo.GetNavigatorButtonInfos(
  Index: Integer): TcxPCNavigatorButtonViewInfo;
begin
  Result := TcxPCNavigatorButtonViewInfo(FNavigatorButtonInfos[Index]);
end;

function TcxCustomTabControlViewInfo.GetNavigatorButtons: TcxPCNavigatorButtons;
begin
  Result := FNavigatorButtons;
end;

function TcxCustomTabControlViewInfo.GetNavigatorPosition: TcxPCNavigatorPosition;
begin
  Result := Properties.NavigatorPosition;
end;

function TcxCustomTabControlViewInfo.GetOptions: TcxPCOptions;
begin
  Result := Properties.Options;
end;

function TcxCustomTabControlViewInfo.GetPainter: TcxPCCustomPainter;
begin
  Result := IControl.Painter;
end;

function TcxCustomTabControlViewInfo.GetProperties: TcxCustomTabControlProperties;
begin
  Result := IControl.Properties;
end;

function TcxCustomTabControlViewInfo.GetPageClientRect: TRect;
begin
  Result := Painter.GetPageClientRect;
end;

function TcxCustomTabControlViewInfo.GetPageClientRectOffset: TRect;
begin
  Result := RotateRect(Painter.GetPageClientRectOffset, TabPosition);
end;

function TcxCustomTabControlViewInfo.GetPageFrameRect: TRect;
begin
  Result := Painter.GetPageFrameRect;
end;

function TcxCustomTabControlViewInfo.GetPageFrameRectOffset: TRect;
begin
  Result := RotateRect(Painter.GetPageFrameRectOffset, TabPosition);
end;

function TcxCustomTabControlViewInfo.GetRaggedRight: Boolean;
begin
  Result := Properties.RaggedRight;
end;

function TcxCustomTabControlViewInfo.GetShowFrame: Boolean;
begin
  Result := Properties.ShowFrame;
end;

function TcxCustomTabControlViewInfo.GetTabHeight: Smallint;
begin
  Result := Properties.TabHeight;
end;

function TcxCustomTabControlViewInfo.GetTabIndex: Integer;
begin
  Result := Properties.TabIndex;
end;

function TcxCustomTabControlViewInfo.GetTabPosition: TcxTabPosition;
begin
  Result := Properties.TabPosition;
end;

function TcxCustomTabControlViewInfo.GetTabSlants: TcxTabSlants;
begin
  Result := Properties.TabSlants;
end;

function TcxCustomTabControlViewInfo.GetTabWidth: Smallint;
begin
  Result := Properties.TabWidth;
end;

function TcxCustomTabControlViewInfo.GetWidth: Integer;
begin
  Result := cxRectWidth(BoundsRect);
end;

procedure TcxCustomTabControlViewInfo.RearrangeRows;

  function IsRowNumbersCorrectionNeeded: Boolean;
  begin
    if Properties.TabPosition in [tpBottom, tpTop] then
    begin
      Result := ActuallyRotate and not(pcoTopToBottomText in Properties.Options);
      if Properties.TabPosition = tpBottom then
        Result := not Result;
    end
    else
    begin
      Result := (not ActuallyRotate) and (pcoTopToBottomText in Properties.Options);
      if Properties.TabPosition = tpRight then
        Result := not Result;
    end;
  end;

  // tpTop: top to bottom
  // tpLeft: left to right
  // tpRight: right to left
  // tpBottom: bottom to top
  procedure ConvertRowNumbersToNumbersRelativeToTabPosition;
  var
    I: Integer;
  begin
    if IsRowNumbersCorrectionNeeded then
      for I := 0 to TabsViewInfo.ViewInfoCount - 1 do
        with TabsViewInfo[I] do
          FVisibleRow := RowCount - 1 - FRow
    else
      for I := 0 to TabsViewInfo.ViewInfoCount - 1 do
        with TabsViewInfo[I] do
          FVisibleRow := FRow;
  end;

  procedure ConvertRelativeNumbersToConvenientNumbers;
  var
    I: Integer;
  begin
    if Properties.TabPosition in [tpRight, tpBottom] then
    begin
      for I := 0 to TabsViewInfo.ViewInfoCount - 1 do
        with TabsViewInfo[I] do
          FVisibleRow := RowCount - 1 - FVisibleRow;
      FTopOrLeftPartRowCount := FRowCount - FTopOrLeftPartRowCount;
    end
  end;

var
  I: Integer;
  ARow: Integer;
  ARelativeTopPartRowCount: Integer;
begin
  ConvertRowNumbersToNumbersRelativeToTabPosition;
  ARelativeTopPartRowCount := RowCount;

  if FMainTabVisibleIndex <> -1 then
    if Properties.ScrollOpposite then
      ARelativeTopPartRowCount := TabsViewInfo[FMainTabVisibleIndex].FVisibleRow + 1
    else
      if Painter.IsMainTabBoundWithClient then
      begin
        ARow := RowCount - 1 - TabsViewInfo[FMainTabVisibleIndex].FVisibleRow;
        for I := 0 to TabsViewInfo.ViewInfoCount - 1 do
          with TabsViewInfo[I] do
            if RowCount = 0 then
              FVisibleRow := 0
            else
              FVisibleRow := (FVisibleRow + ARow) mod RowCount;
      end;

  FTopOrLeftPartRowCount := ARelativeTopPartRowCount;
  ConvertRelativeNumbersToConvenientNumbers;
  CalculateRowPositions;
end;

procedure TcxCustomTabControlViewInfo.SetFocusedTabVisibleIndex(Value: Integer);
begin
  if FocusedTabVisibleIndex <> Value then
  begin
    if IsTabVisibleIndexValid(FocusedTabVisibleIndex) then
      RepaintTab(FocusedTabVisibleIndex, tpcFocused);
    FFocusedTabVisibleIndex := Value;
    if IsTabVisibleIndexValid(FFocusedTabVisibleIndex) then
    begin
      if IsFullVisible(FFocusedTabVisibleIndex) then
        RepaintTab(FFocusedTabVisibleIndex, tpcFocused)
      else
        MakeTabVisible(FFocusedTabVisibleIndex);
    end;
  end;
end;

procedure TcxCustomTabControlViewInfo.SetHotTrackTabCloseButton(
  const Value: TcxPCTabCloseButtonViewInfo);
begin
  if FHotTrackTabCloseButton <> Value then
  begin
    if FHotTrackTabCloseButton <> nil then
      FHotTrackTabCloseButton.State := nbsNormal;
    FHotTrackTabCloseButton := Value;
    if FHotTrackTabCloseButton <> nil then
      if (FHotTrackTabCloseButton = PressedTabCloseButton) then
        FHotTrackTabCloseButton.State := nbsPressed
      else
        if AllowHotTrack then
          FHotTrackTabCloseButton.State := nbsHotTrack
        else
          FHotTrackTabCloseButton.State := nbsNormal;
  end;
end;

procedure TcxCustomTabControlViewInfo.SetHotTrackNavigatorButton(
  const Value: TcxPCNavigatorButtonViewInfo);
begin
  if FHotTrackNavigatorButton <> Value then
  begin
    if HotTrackNavigatorButton <> nil then
      HotTrackNavigatorButton.State := nbsNormal;
    FHotTrackNavigatorButton := Value;
    if FHotTrackNavigatorButton <> nil then
      if (FHotTrackNavigatorButton = PressedNavigatorButton) then
        FHotTrackNavigatorButton.State := nbsPressed
      else
        if AllowHotTrack then
          FHotTrackNavigatorButton.State := nbsHotTrack
        else
          FHotTrackNavigatorButton.State := nbsNormal
  end;
end;

procedure TcxCustomTabControlViewInfo.SetHotTrackTabVisibleIndex(Value: Integer);
begin
  if HotTrackTabVisibleIndex <> Value then
  begin
    if IsTabVisibleIndexValid(FHotTrackTabVisibleIndex) then
      RepaintTab(FHotTrackTabVisibleIndex, tpcHotTrack);
    FHotTrackTabVisibleIndex := Value;
    if FHotTrackTabVisibleIndex <> -1 then
      RepaintTab(FHotTrackTabVisibleIndex, tpcHotTrack);
  end;
end;

procedure TcxCustomTabControlViewInfo.SetMainTabVisibleIndex(Value: Integer);
begin
  if FMainTabVisibleIndex <> Value then
  begin
    TrackingTabVisibleIndex := -1;
    FocusedTabVisibleIndex := -1;
    if IsTabVisibleIndexValid(FMainTabVisibleIndex) then
      RepaintTab(FMainTabVisibleIndex, tpcIsMainTab);
    FMainTabVisibleIndex := Value;
    if FMainTabVisibleIndex <> -1 then
    begin
      if not Properties.MultiLine then
        CorrectFirstVisibleTab(MainTabVisibleIndex);
      RepaintTab(FMainTabVisibleIndex, tpcIsMainTab);
    end;
    UpdateButtonsState;
  //  SynchronizeHotTrackStates(InternalGetShiftState);
  end;
end;

procedure TcxCustomTabControlViewInfo.SetNavigatorButtons(
  const Value: TcxPCNavigatorButtons);
const
  AButtonsOrder: array [Boolean, TcxPCNavigatorButton] of TcxPCNavigatorButton = (
    (nbGoDialog, nbTopLeft, nbBottomRight, nbClose),
    (nbClose, nbTopLeft, nbBottomRight, nbGoDialog));
var
  I, ANextButton: TcxPCNavigatorButton;
  AInverseOrder, AIsVertical: Boolean;

begin
  FNavigatorButtons := Value;
  FNavigatorButtonInfos.Clear;
  AIsVertical := TabPosition in [tpLeft, tpRight];
  AInverseOrder := (AIsVertical and (NavigatorPosition in [npLeftTop, npRightTop])) or
    (not AIsVertical and (NavigatorPosition in [npLeftTop, npLeftBottom]));
  for I := Low(TcxPCNavigatorButton) to High(TcxPCNavigatorButton) do
  begin
    ANextButton := AButtonsOrder[AInverseOrder, I];
    if ANextButton in FNavigatorButtons then
      FNavigatorButtonInfos.Add(TcxPCNavigatorButtonViewInfo.Create(Self, ANextButton));
  end;
end;

procedure TcxCustomTabControlViewInfo.SetPressedNavigatorButton(
  const Value: TcxPCNavigatorButtonViewInfo);
begin
  if FPressedNavigatorButton <> Value then
  begin
    if FPressedNavigatorButton <> nil then
      if AllowHotTrack and (FPressedNavigatorButton = FHotTrackNavigatorButton) then
        FPressedNavigatorButton.State := nbsHotTrack
      else
        FPressedNavigatorButton.State := nbsNormal;
    FPressedNavigatorButton := Value;
    if FPressedNavigatorButton <> nil then
      FPressedNavigatorButton.State := nbsPressed;
  end;
end;

procedure TcxCustomTabControlViewInfo.SetPressedTabCloseButton(
  const Value: TcxPCTabCloseButtonViewInfo);
begin
  if FPressedTabCloseButton <> Value then
  begin
    if FPressedTabCloseButton <> nil then
      if AllowHotTrack and (FPressedTabCloseButton = FHotTrackTabCloseButton) then
        FPressedTabCloseButton.State := nbsHotTrack
      else
        FPressedTabCloseButton.State := nbsNormal;
    FPressedTabCloseButton := Value;
    if FPressedTabCloseButton <> nil then
      FPressedTabCloseButton.State := nbsPressed;
  end;
end;

procedure TcxCustomTabControlViewInfo.SetPressedTabVisibleIndex(Value: Integer);
begin
  if PressedTabVisibleIndex <> Value then
  begin
    if PressedTabVisibleIndex <> -1 then
      RepaintTab(PressedTabVisibleIndex, tpcPressed);
    FPressedTabVisibleIndex := Value;
    if PressedTabVisibleIndex <> -1 then
      RepaintTab(PressedTabVisibleIndex, tpcPressed);
  end;
end;

procedure TcxCustomTabControlViewInfo.SetTabIndex(Value: Integer);
begin
  Properties.TabIndex := Value;
end;

procedure TcxCustomTabControlViewInfo.SetTrackingTabVisibleIndex(Value: Integer);
begin
  if TrackingTabVisibleIndex <> Value then
  begin
    if IsTabVisibleIndexValid(TrackingTabVisibleIndex) then
      RepaintTab(TrackingTabVisibleIndex, tpcTracking);
    FTrackingTabVisibleIndex := Value;
    if IsTabVisibleIndexValid(TrackingTabVisibleIndex) then
    begin
      if IsFullVisible(TrackingTabVisibleIndex) then
        RepaintTab(TrackingTabVisibleIndex, tpcTracking)
      else
        MakeTabVisible(TrackingTabVisibleIndex);
    end;
  end;
end;

procedure TcxCustomTabControlViewInfo.SynchronizeHotTrackStates(Shift: TShiftState);
var
  AMousePos: TPoint;
  ANewHotTrackTabVisibleIndex: Integer;
  ANewHotTrackNavigatorButton: TcxPCNavigatorButtonViewInfo;
  ANewHotTrackTabCloseButton: TcxPCTabCloseButtonViewInfo;
  AHitObject: TObject;
begin
  if IControl.IsDesigning or Controller.FIsGoDialogShowing then Exit;
  AMousePos := Controller.GetMouseCursorPos;
  Controller.HitTest.Update(Shift, AMousePos);

  ANewHotTrackTabVisibleIndex := -1;
  ANewHotTrackNavigatorButton := nil;
  ANewHotTrackTabCloseButton := nil;
  AHitObject := Controller.HitTest.HitObject;
  if IsEnabled and (IControl.GetDragAndDropState = ddsNone) then
    if Controller.HitTest.HitAtNavigatorButton and
       (TcxPCNavigatorButtonViewInfo(AHitObject).State <> nbsDisabled) then
      ANewHotTrackNavigatorButton := TcxPCNavigatorButtonViewInfo(AHitObject)
    else
    begin
      if AllowHotTrack then
      begin
        ANewHotTrackTabVisibleIndex := VisibleIndexOfTabAt(AMousePos.X, AMousePos.Y);
        if (ANewHotTrackTabVisibleIndex <> -1) and (not TabsViewInfo[ANewHotTrackTabVisibleIndex].Enabled) then
          ANewHotTrackTabVisibleIndex := -1;
      end;
      if Controller.HitTest.HitAtTabCloseButton then
        ANewHotTrackTabCloseButton := TcxPCTabCloseButtonViewInfo(AHitObject);
    end;
  HotTrackTabVisibleIndex := ANewHotTrackTabVisibleIndex;
  HotTrackTabCloseButton := ANewHotTrackTabCloseButton;
  HotTrackNavigatorButton := ANewHotTrackNavigatorButton;
end;

procedure TcxCustomTabControlViewInfo.UpdateButtonsState;

  procedure InternalUpdateButtonState(AButtonInfo: TcxPCNavigatorButtonViewInfo);
  var
    ANewButtonState, APrevButtonState: TcxPCNavigatorButtonState;
  begin
    APrevButtonState := AButtonInfo.State;
    ANewButtonState := APrevButtonState;
    if CanPressButton(AButtonInfo.ButtonType) then
    begin
      if APrevButtonState = nbsDisabled then
        ANewButtonState := nbsNormal;
    end
    else
      ANewButtonState := nbsDisabled;
    if ANewButtonState <> APrevButtonState then
    begin
      if ANewButtonState = nbsDisabled then
      begin
        FHotTrackNavigatorButton := nil;
        FPressedNavigatorButton := nil;
      end;
      AButtonInfo.State := ANewButtonState;
    //  SynchronizeHotTrackStates(InternalGetShiftState);
    end;
  end;

var
  I: Integer;
begin
  for I := 0 to NavigatorButtonCount - 1 do
    if NavigatorButtonInfos[I].ButtonType <> nbGoDialog then
      InternalUpdateButtonState(NavigatorButtonInfos[I]);
end;

procedure TcxCustomTabControlViewInfo.UpdateTabPosition(ANavigatorButtons: TcxPCNavigatorButtons);
begin
  NavigatorButtons := ANavigatorButtons;
  FTabsPosition := Painter.GetTabsPosition(ANavigatorButtons);
end;

function TcxCustomTabControlViewInfo.GetTabViewInfo(ATab: TcxTab): TcxTabViewInfo;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to TabsViewInfo.ViewInfoCount - 1 do
    if TabsViewInfo.ViewInfos[I].Tab = ATab then
       Result := TabsViewInfo.ViewInfos[I];
end;

function TcxCustomTabControlViewInfo.GetTabVisibleIndex(ATab: TcxTab): Integer;
var
  ATabViewInfo: TcxTabViewInfo;
begin
  ATabViewInfo := GetTabViewInfo(ATab);
  if ATabViewInfo <> nil then
    Result := ATabViewInfo.VisibleIndex
  else
    Result := -1;
end;

{ TcxTab }

constructor TcxTab.Create(ATabs: TcxTabs);
begin
  inherited Create;
  FTabs := ATabs;
  FColor := clDefault;
  FEnabled := True;
  FVisible := True;
  FImageIndex := -1;
  FDestroyHandlers := TcxEventHandlerCollection.Create;
end;

destructor TcxTab.Destroy;
begin
  DestroyHandlers.CallEvents(Self, []);
  FreeAndNil(FDestroyHandlers);
  DoDestroy;
  inherited;
end;

procedure TcxTab.AssignTo(Dest: TPersistent);
var
  DestTab: TcxTab;
begin
  if Dest is TcxTab then
  begin
    DestTab := TcxTab(Dest);
    DestTab.FCaption := Caption;
    DestTab.FEnabled := Enabled;
    DestTab.FHighlighted := Highlighted;
    DestTab.ImageIndex := ImageIndex;
    DestTab.FObject := FObject;
    DestTab.Visible := Visible;
    DestTab.Selected := Selected;
  end
  else
    inherited AssignTo(Dest);
end;

procedure TcxTab.Changed(ATabPropertyChanged: TcxPCTabPropertyChanged);
begin
  Tabs.Changed(Self, ATabPropertyChanged);
end;

procedure TcxTab.DoDestroy;
begin
  if not Tabs.FIsTabsCleaning then
    Tabs.RemoveTab(Self);
end;

function TcxTab.GetViewInfoClass: TcxTabViewInfoClass;
begin
  Result := TcxTabViewInfo;
end;

function TcxTab.IsNewButton: Boolean;
begin
  Result := False;
end;

function TcxTab.GetFullRect: TRect;
begin
  if GetViewInfo <> nil then
    Result := GetViewInfo.FullRect
  else
    Result := cxEmptyRect;
end;

function TcxTab.GetHotTrack: Boolean;
begin
  Result := (GetViewInfo <> nil) and GetViewInfo.IsHotTrack;
end;

function TcxTab.GetIndex: Integer;
begin
  Result := Tabs.TabItems.IndexOf(Self);
end;

function TcxTab.GetImageIndex: TImageIndex;
begin
  Result := Properties.GetImageIndex(Self);
end;

function TcxTab.GetIsMainTab: Boolean;
begin
  Result := (GetViewInfo <> nil) and GetViewInfo.IsMainTab;
end;

function TcxTab.GetPressed: Boolean;
begin
  Result := (GetViewInfo <> nil) and GetViewInfo.IsPressed;
end;

function TcxTab.GetProperties: TcxCustomTabControlProperties;
begin
  Result := Tabs.Properties;
end;

function TcxTab.GetRealVisible: Boolean;
begin
  Result := not IsRectEmpty(VisibleRect)
end;

function TcxTab.GetTracking: Boolean;
begin
  Result := (GetViewInfo <> nil) and GetViewInfo.IsTracking;
end;

function TcxTab.GetControlViewInfo: TcxCustomTabControlViewInfo;
begin
  Result := Tabs.GetControlViewInfo;
end;

function TcxTab.GetViewInfo: TcxTabViewInfo;
begin
  if GetControlViewInfo <> nil  then
    Result := GetControlViewInfo.GetTabViewInfo(Self)
  else
    Result := nil;
end;

function TcxTab.GetVisibleIndex: Integer;
begin
  if GetViewInfo = nil then
    Result := -1
  else
    Result := GetViewInfo.VisibleIndex;
end;

function TcxTab.GetVisibleRect: TRect;
begin
  if GetViewInfo <> nil then
    Result := GetViewInfo.VisibleRect
  else
    Result := cxEmptyRect;
end;

function TcxTab.GetVisibleRow: Integer;
begin
  Result := GetViewInfo.VisibleRow;
end;

procedure TcxTab.InternalSetCaption(const Value: string);
begin
  FCaption := Value;
end;

procedure TcxTab.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    InternalSetCaption(Value);
    Changed(tpcLayout);
  end;
end;

procedure TcxTab.SetColor(Value: TColor);
begin
  if Value <> FColor then
  begin
    FColor := Value;
    Changed(tpcColor);
  end;
end;

procedure TcxTab.SetEnabled(const Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    Changed(tpcEnabled);
  end;
end;

procedure TcxTab.SetHighlighted(const Value: Boolean);
begin
  if Value <> FHighlighted then
  begin
    FHighlighted := Value;
    Changed(tpcHighlighted);
  end;
end;

procedure TcxTab.SetImageIndex(Value: TImageIndex);
begin
  if Value < 0 then
    Value := -1;
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Changed(tpcLayout);
  end;
end;

procedure TcxTab.SetSelected(const Value: Boolean);

  function GetSelectedTabCount: Integer;
  var
    I, TabCount: Integer;
  begin
    Result := 0;
    TabCount := Tabs.Count;
    for I := 0 to TabCount - 1 do
      if Tabs[I].Selected then
        Inc(Result);
  end;

begin
  if FSelected <> Value then
  begin
    if GetViewInfo <> nil then
    begin
      if not GetViewInfo.CanMultiSelect then
      begin
        if Value and (Properties.TabIndex <> Index) then
          Exit;
      end
      else
        if Value and (GetSelectedTabCount > 0) and (not Properties.MultiSelect) then
          Properties.MultiSelect := True;

      FSelected := Value;
      Changed(tpcSelected);
    end
    else
      FSelected := Value;
  end;
end;

procedure TcxTab.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed(tpcVisible);
  end;
end;

{ TcxPCNewButton }

constructor TcxPCNewButton.Create(ATabs: TcxTabs);
begin
  inherited;
  Visible := False;
end;

function TcxPCNewButton.GetViewInfoClass: TcxTabViewInfoClass;
begin
  Result := TcxPCNewButtonViewInfo;
end;

function TcxPCNewButton.GetIndex: Integer;
begin
  Result := cxPCNewButtonIndex;
end;

procedure TcxPCNewButton.DoDestroy;
begin
// do nothing
end;

function TcxPCNewButton.IsNewButton: Boolean;
begin
  Result := True;
end;

procedure TcxPCNewButton.SetWidth(Value: Integer);
begin
  if Width <> Value then
  begin
    FWidth := Value;
    Changed(tpcLayout);
  end;
end;

{ TcxTabs }

constructor TcxTabs.Create(AProperties: TcxCustomTabControlProperties);
begin
  inherited Create;
  FChangedHandlers := TcxEventHandlerCollection.Create;
  FDestroyHandlers := TcxEventHandlerCollection.Create;
  FTabItems := TObjectList.Create;
  FProperties := AProperties;
  CreateNewButton;
end;

destructor TcxTabs.Destroy;
begin
  FDestroyHandlers.CallEvents(Self, []);
  FreeAndNil(FDestroyHandlers);
  DestroyNewButton;
  FIsTabsCleaning := True;
  FreeAndNil(FTabItems);
  FreeAndNil(FChangedHandlers);
  inherited;
end;

procedure TcxTabs.Delete(Index: Integer);
begin
  TabItems.Delete(Index);
end;

function TcxTabs.Get(Index: Integer): string;
begin
  Result := Tabs[Index].Caption;
end;

function TcxTabs.GetCount: Integer;
begin
  Result := TabItems.Count;
end;

function TcxTabs.GetObject(Index: Integer): TObject;
begin
  Result := Tabs[Index].FObject;
end;

procedure TcxTabs.Put(Index: Integer; const S: string);
begin
  Tabs[Index].Caption := S;
end;

procedure TcxTabs.PutObject(Index: Integer; AObject: TObject);
begin
  Tabs[Index].FObject := AObject;
end;

procedure TcxTabs.SetUpdateState(Updating: Boolean);
begin
  if not Updating then
    Changed;
end;

function TcxTabs.GetTab(TabIndex: Integer): TcxTab;
begin
  Result := TcxTab(TabItems[TabIndex]);
end;

function TcxTabs.GetVisibleTab(ATabVisibleIndex: Integer): TcxTab;
begin
  Result := GetViewInfo[ATabVisibleIndex].Tab;
end;

procedure TcxTabs.Insert(Index: Integer; const S: string);
begin
  BeginUpdate;
  try
    TabItems.Insert(Index, TcxTab.Create(Self));
    Tabs[Index].FImageIndex := Index;
    Tabs[Index].InternalSetCaption(S);

    if not Properties.IsLoading and (Properties.TabIndex = -1) and (Count = 1) then
      Properties.FTabIndex := 0;
  finally
    EndUpdate;
  end;
end;

procedure TcxTabs.Move(CurIndex, NewIndex: Integer);
begin
  TabItems.Move(CurIndex, NewIndex);
  Changed;
end;

procedure TcxTabs.Changed(ATab: TcxTab = nil; ATabPropertyChanged: TcxPCTabPropertyChanged = tpcLayout);
var
  AEventArgs: TcxPCTabsChangedEventArgs;
begin
  if not (Properties.IsLoading or Properties.IsDestroying) then
  begin
    AEventArgs.Tab := ATab;
    AEventArgs.PropertyChanged := ATabPropertyChanged;
    ChangedHandlers.CallEvents(Self, AEventArgs);
  end;
end;

procedure TcxTabs.Clear;
begin
  TabItems.Clear;
end;

function TcxTabs.GetViewInfoClass: TcxTabsViewInfoClass;
begin
  Result := TcxTabsViewInfo;
end;

function TcxTabs.GetNewButtonClass: TcxPCNewButtonClass;
begin
  Result := TcxPCNewButton;
end;

procedure TcxTabs.SetTab(Index: Integer; const Value: TcxTab);
begin
  Tabs[Index].Assign(Value);
end;

function TcxTabs.GetVisibleTabsCount: Integer;
begin
  Result := GetViewInfo.ViewInfoCount;
end;

function TcxTabs.GetControlViewInfo: TcxCustomTabControlViewInfo;
begin
  Result := Properties.GetViewInfo;
end;

function TcxTabs.GetViewInfo: TcxTabsViewInfo;
begin
  if GetControlViewInfo <> nil  then
    Result := GetControlViewInfo.TabsViewInfo
  else
    Result := nil;
end;

procedure TcxTabs.CreateNewButton;
begin
  FNewButton := GetNewButtonClass.Create(Self);
end;

procedure TcxTabs.DestroyNewButton;
begin
  FreeAndNil(FNewButton);
end;

procedure TcxTabs.RemoveTab(ATab: TcxTab);
begin
  TabItems.Extract(ATab);
  Changed;
end;

{ TcxPCCustomPainter }

constructor TcxPCCustomPainter.Create(
  AViewInfo: TcxCustomTabControlViewInfo);
begin
  inherited Create;
  FViewInfo := AViewInfo;
end;

function TcxPCCustomPainter.GetPageBorders: TcxBorders;
begin
  if ViewInfo.HasBorders then
    Result := cxBordersAll
  else
  begin
    Result := [];
    if ViewInfo.HideTabs or (ViewInfo.RowCount = 0) then
      Exit;
    case ViewInfo.TabPosition of
      tpTop:
        begin
          Include(Result, bTop);
          if ViewInfo.TopOrLeftPartRowCount <> ViewInfo.RowCount then
            Include(Result, bBottom);
        end;
      tpLeft:
        begin
          Include(Result, bLeft);
          if ViewInfo.TopOrLeftPartRowCount <> ViewInfo.RowCount then
            Include(Result, bRight);
        end;
      tpBottom:
        begin
          Include(Result, bBottom);
          if ViewInfo.TopOrLeftPartRowCount <> 0 then
            Include(Result, bTop);
        end;
      tpRight:
        begin
          Include(Result, bRight);
          if ViewInfo.TopOrLeftPartRowCount <> 0 then
            Include(Result, bLeft);
        end;
    end;
  end;
end;

function TcxPCCustomPainter.GetPageClientRect: TRect;
begin
  Result := GetExtendedRect(ViewInfo.ControlBounds,
    GetPageClientRectOffset, ViewInfo.TabPosition);
  ValidateRect(Result);
end;

class function TcxPCCustomPainter.GetStandardStyle: TcxPCStandardStyle;
begin
  Result := tsTabs;
end;

class function TcxPCCustomPainter.GetStyleID: TcxPCStyleID;
begin
  Result := cxPCNoStyle;
end;

class function TcxPCCustomPainter.GetStyleName: TCaption;
begin
  Result := '';
end;

class function TcxPCCustomPainter.HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean;
begin
  Result := False;
end;

class function TcxPCCustomPainter.IsDefault(ALookAndFeel: TcxLookAndFeel): Boolean;
begin
  Result := False;
end;

class function TcxPCCustomPainter.IsMainTabBoundWithClient: Boolean;
begin
  Result := True;
end;

class function TcxPCCustomPainter.IsMultiSelectionAccepted: Boolean;
begin
  Result := False;
end;

class function TcxPCCustomPainter.IsStandardStyle: Boolean;
begin
  Result := False;
end;

class function TcxPCCustomPainter.IsTabPressable: Boolean;
begin
  Result := False;
end;

class function TcxPCCustomPainter.AllowRotate: Boolean;
begin
  Result := True;
end;

function TcxPCCustomPainter.CanDrawParentBackground: Boolean;
begin
  Result := ViewInfo.CanDrawParentBackground;
end;

procedure TcxPCCustomPainter.CorrectTabContentVerticalOffset(ATabVisibleIndex: Integer; var ADrawOffset: TRect);

  procedure CorrectNonpressableTabContentVerticalOffset;
  begin
    if ViewInfo.ActuallyRotate then
    begin
      ADrawOffset.Top := 0;
      ADrawOffset.Bottom := 0;
    end;
  end;

  procedure CorrectPressableTabContentVerticalOffset;
  begin
    if (InternalGetTextRotationAngle(ViewInfo) = raMinus90) xor
      IsTabBorderThick(ATabVisibleIndex) then
    begin
      Inc(ADrawOffset.Top);
      Dec(ADrawOffset.Bottom);
    end;
  end;

begin
  if IsTabPressable then
    CorrectPressableTabContentVerticalOffset
  else
    CorrectNonpressableTabContentVerticalOffset;
  if IsMainTabBoundWithClient and (TabViewInfo[ATabVisibleIndex].GetRelativeTextRotationAngle = ra180) then
    ExchangeLongWords(ADrawOffset.Top, ADrawOffset.Bottom);
end;

procedure TcxPCCustomPainter.CorrectTabNormalWidth(var AValue: Integer);
begin
// do nothing
end;

function TcxPCCustomPainter.GetDropArrowRects(ADragTabVisibleIndex, AHitTabVisibleIndex,
  ADestinationTabVisibleIndex: Integer): TRects;
const
  DirectionMap: array [Boolean] of Integer = (-1, 1);
var
  AIsAfterInsert: Boolean;
  ANextTabVisibleIndex: Integer;
  P: TPoint;
  Y1, Y2: Integer;
  R: TRect;
  ANextRect: TRect;
  AIsNextRectValid: Boolean;
  AIndex: Integer;
begin
  AIndex := AHitTabVisibleIndex;
  ANextTabVisibleIndex := AIndex + DirectionMap[(AIndex < ADestinationTabVisibleIndex) xor
    ((AIndex = ADestinationTabVisibleIndex) and (ADragTabVisibleIndex < ADestinationTabVisibleIndex))];
  AIsAfterInsert := AIndex < ANextTabVisibleIndex;
  R := ViewInfo.TabsViewInfo[AIndex].VisibleRect;
  if ViewInfo.IsTabVisibleIndexValid(ANextTabVisibleIndex) and
      (ViewInfo.TabsViewInfo[AIndex].VisibleRow = ViewInfo.TabsViewInfo[ANextTabVisibleIndex].VisibleRow) then
    ANextRect := ViewInfo.TabsViewInfo[ANextTabVisibleIndex].VisibleRect
  else
    ANextRect := cxInvalidRect;
  AIsNextRectValid := not EqualRect(ANextRect, cxInvalidRect);
  if ViewInfo.TabPosition in [tpLeft, tpRight] then
  begin
    R := cxRectRotate(R);
    if AIsNextRectValid then
      ANextRect := cxRectRotate(ANextRect);
  end;
  Y1 := R.Top;
  Y2 := R.Bottom;
  if ViewInfo.IsRightToLeftAlignment or ViewInfo.IsBottomToTopAlignment then
  begin
    R := cxRectAdjust(cxRectInvert(R));
    if AIsNextRectValid then
      ANextRect := cxRectAdjust(cxRectInvert(ANextRect));
  end;
  if AIsAfterInsert then
    P.X := IfThen(AIsNextRectValid, Max(R.Right, ANextRect.Left), R.Right)
  else
    P.X := IfThen(AIsNextRectValid, Max(R.Left, ANextRect.Right), R.Left);
  if ViewInfo.IsRightToLeftAlignment or ViewInfo.IsBottomToTopAlignment then
    P.X := -P.X;
  P.Y := Y1;
  Result[0] := cxRect(P, P);
  InflateRect(Result[0], 1, 1);
  if ViewInfo.TabPosition in [tpLeft, tpRight] then
    Result[0] := cxRectRotate(Result[0]);
  P.Y := Y2;
  Result[1] := cxRect(P, P);
  InflateRect(Result[1], 1, 1);
  if ViewInfo.TabPosition in [tpLeft, tpRight] then
    Result[1] := cxRectRotate(Result[1]);
end;

function TcxPCCustomPainter.GetTabCorrection(ATabVisibleIndex: Integer): TcxPCRectCorrection;
begin
  Result := cxPCEmptyRectCorrection;
end;

procedure TcxPCCustomPainter.DirectionalPolyline(ACanvas: TcxCanvas; const R: TRect;
  APoints: array of TPoint; ATabPosition: TcxTabPosition; AColor: TColor);
begin
  RotatePolyline(R, APoints, ATabPosition);
  InternalPolyLine(APoints, AColor, ACanvas);
end;

function TcxPCCustomPainter.DoCustomDraw(TabVisibleIndex: Integer): Boolean;
begin
  Result := ViewInfo.Properties.DoCustomDraw(TabVisibleIndex);
end;

procedure TcxPCCustomPainter.DoDrawBackground(ACanvas: TcxCanvas);
var
  R: TRect;
begin
  R := ViewInfo.ControlBounds;
  if IsNativePainting and ViewInfo.ParentBackground then
  begin
    if CanDrawParentBackground then
      cxDrawTransparentControlBackground(ViewInfo.IControl.GetControl, ACanvas, R, False)
  end
  else
    FillFreeSpaceArea(ACanvas, R);
end;

procedure TcxPCCustomPainter.DrawBackground(ACanvas: TcxCanvas);
begin
  DoDrawBackground(ACanvas);
end;

procedure TcxPCCustomPainter.DrawFocusRect(ACanvas: TcxCanvas; ATabVisibleIndex: Integer);
begin
end;

procedure TcxPCCustomPainter.DrawNativeTabBackground(DC: HDC; ATab: TcxTabSheet);
begin
end;

procedure TcxPCCustomPainter.DrawTabCloseButton(ACanvas: TcxCanvas; TabVisibleIndex: Integer);
const
  NavigatorBtnStateToLookAndFeelBtnState: array [TcxPCNavigatorButtonState] of TcxButtonState = (
    cxbsNormal, cxbsPressed, cxbsHot, cxbsDisabled);
var
  AButtonInfo: TcxPCTabCloseButtonViewInfo;
begin
  AButtonInfo := TabViewInfo[TabVisibleIndex].CloseButtonInfo;
  if UseLookAndFeelCloseButton then
    GetLookAndFeelPainterClass.DrawSmallCloseButton(ACanvas,
      AButtonInfo.Bounds, NavigatorBtnStateToLookAndFeelBtnState[AButtonInfo.State])
  else
    PaintButton(ACanvas, AButtonInfo.Bounds, AButtonInfo.State, nbClose);
end;

procedure TcxPCCustomPainter.DrawTabImage(ACanvas: TcxCanvas; const ARect: TRect; AImageIndex: Integer;
  AEnabled: Boolean; AColor: TColor; ATabVisibleIndex: Integer);

  procedure InternalDrawImage(ADrawCanvas: TcxCanvas; AImagePos: TPoint);
  begin
    ImagePainter.Draw(ADrawCanvas, AImagePos.X, AImagePos.Y, AImageIndex,
      AColor, IsNativePainting, AEnabled, TabViewInfo[ATabVisibleIndex].IsHotTrack);
  end;

const
  ABackgroundRotateAngle: array [TcxRotationAngle] of TcxRotationAngle = (ra0, raMinus90, raPlus90, ra0);
var
  ABitmap: TcxBitmap;
  AAngle: TcxRotationAngle;
begin
    AAngle := InternalGetTextRotationAngle(ViewInfo);
    if AAngle = ra0 then
      InternalDrawImage(ACanvas, ARect.TopLeft)
    else
    begin
      ABitmap := TcxBitmap.CreateSize(ARect, pf32bit);
      try
        ABitmap.cxCanvas.WindowOrg := ARect.TopLeft;
        DrawTabContentBackground(ABitmap.cxCanvas, ARect, AColor, ATabVisibleIndex);
        ABitmap.cxCanvas.WindowOrg := cxNullPoint;
        ABitmap.Rotate(ABackgroundRotateAngle[AAngle]);
        InternalDrawImage(ABitmap.cxCanvas, cxNullPoint);
        cxBitBlt(ACanvas.Handle, ABitmap.Canvas.Handle, ARect, cxNullPoint, SRCCOPY);
      finally
        FreeAndNil(ABitmap);
      end;
    end;
end;

procedure TcxPCCustomPainter.DrawTabImageAndText(ACanvas: TcxCanvas; ATabVisibleIndex: Integer);

  function NeedDrawImage: Boolean;
  var
    ATabViewInfo: TcxTabViewInfo;
    AHasHotImage, AHasImage, AHotImagesAssigned: Boolean;
  begin
    ATabViewInfo := TabViewInfo[ATabVisibleIndex];
    AHasImage := IsImageAssigned(ViewInfo.Properties.Images, ATabViewInfo.ImageIndex);
    AHasHotImage := IsImageAssigned(ViewInfo.Properties.HotImages, ATabViewInfo.ImageIndex);
    AHotImagesAssigned := ViewInfo.Properties.HotImages <> nil;

    Result := not ATabViewInfo.IsHotTrack and AHasImage or
      ATabViewInfo.IsHotTrack and (AHotImagesAssigned and AHasHotImage or not AHotImagesAssigned and AHasImage);
  end;

var
  ATabViewInfo: TcxTabViewInfo;
  AIsTabEnabled: Boolean;
  ABackgroundColor: TColor;
begin
  ATabViewInfo := TabViewInfo[ATabVisibleIndex];
  ViewInfo.PrepareTabCanvasFont(ATabViewInfo, ACanvas);
  ABackgroundColor := GetTabBodyColor(ATabVisibleIndex);
  AIsTabEnabled := ATabViewInfo.ActuallyEnabled;
  if NeedDrawImage then
    DrawTabImage(ACanvas, ATabViewInfo.ImageRect, ATabViewInfo.ImageIndex,
      AIsTabEnabled, ABackgroundColor, ATabVisibleIndex);
  if ATabViewInfo.HasCaption then
    DrawTabText(ACanvas, ATabViewInfo.TextRect, ATabViewInfo.Caption,
      AIsTabEnabled, ABackgroundColor, ATabVisibleIndex);
  if ATabViewInfo.HasCloseButton then
    DrawTabCloseButton(ACanvas, ATabVisibleIndex);
end;

procedure TcxPCCustomPainter.DrawTabText(ACanvas: TcxCanvas; const ARect: TRect; const AText: string;
  AEnabled: Boolean; AColor: TColor; ATabVisibleIndex: Integer);
const
  ATextOffset: array [TcxRotationAngle] of TPoint = (
    (X: 1; Y: 1),
    (X: 1; Y: -1),
    (X: -1; Y: 1),
    (X: 1; Y: 1));
begin
  if not AEnabled then
  begin
    ACanvas.Font.Color := DisabledTextFaceColor;
    if NeedDisabledTextShadow then
    begin
      InternalDrawText(ACanvas, AText, cxRectOffset(ARect,
        ATextOffset[InternalGetTextRotationAngle(ViewInfo)]), ATabVisibleIndex);
      ACanvas.Font.Color := DisabledTextShadowColor;
    end;
  end;
  InternalDrawText(ACanvas, AText, ARect, ATabVisibleIndex);
end;

procedure TcxPCCustomPainter.ExcludeTabContentClipRegion(ACanvas: TcxCanvas; ATabVisibleIndex: Integer);
var
  AContentRgn: TcxRegion;
begin
  if IsNativePainting then
    Exit;

  AContentRgn := TcxRegion.Create(TabViewInfo[ATabVisibleIndex].FullRect);
  AContentRgn.Combine(GetTabClipRgn(ACanvas, ATabVisibleIndex), roIntersect);
  ACanvas.SetClipRegion(AContentRgn, roSubtract);
end;

procedure TcxPCCustomPainter.FillFreeSpaceArea(ACanvas: TcxCanvas; const ARect: TRect);
begin
  ACanvas.Brush.Style := bsSolid;
  ACanvas.FillRect(ARect, GetFreeSpaceColor);
end;

procedure TcxPCCustomPainter.FillPageClientRect(ACanvas: TcxCanvas);
begin
  ACanvas.Brush.Style := bsSolid;
  ACanvas.FillRect(GetFillClientRect, GetClientColor);
end;

procedure TcxPCCustomPainter.FillTabPaneContent(ACanvas: TcxCanvas);
begin
  FillPageClientRect(ACanvas);
end;

function TcxPCCustomPainter.GetButtonsDistance(
  AButton1, AButton2: TcxPCNavigatorButton): Integer;
begin
  Result := 0;
end;

function TcxPCCustomPainter.GetButtonsRegionFromTabsOffset: Integer;
begin
  Result := 0;
end;

function TcxPCCustomPainter.GetButtonsRegionHOffset: Integer;
begin
  Result := 0;
end;

function TcxPCCustomPainter.GetButtonsRegionWOffset: Integer;
begin
  Result := 0;
end;

function TcxPCCustomPainter.GetClientColor: TColor;
begin
  if UseActivePageColor then
    Result := ViewInfo.GetActivePageColor
  else
    Result := GetDefaultClientColor;
end;

function TcxPCCustomPainter.GetCloseButtonAreaHeight(ATabVisibleIndex: Integer): Integer;
begin
  Result := GetCloseButtonSize.cy + GetCloseButtonOffset(ATabVisibleIndex).Top +
    GetCloseButtonOffset(ATabVisibleIndex).Bottom;
end;

function TcxPCCustomPainter.GetCloseButtonAreaWidth(ATabVisibleIndex: Integer): Integer;
begin
  Result := GetCloseButtonSize.cx + GetCloseButtonOffset(ATabVisibleIndex).Left +
    GetCloseButtonOffset(ATabVisibleIndex).Right;
end;

function TcxPCCustomPainter.GetCloseButtonSize: TSize;
begin
  Result := cxSize(16, 14);
end;

function TcxPCCustomPainter.GetCloseButtonOffset(ATabVisibleIndex: Integer): TRect;
begin
  Result := cxRect(4, 2, 0, 2);
  if ATabVisibleIndex = -1 then Exit;
  Result.Top := GetDrawImageOffset(ATabVisibleIndex).Top;
  Result.Bottom := GetDrawImageOffset(ATabVisibleIndex).Bottom;
  Dec(Result.Bottom);
end;

function TcxPCCustomPainter.GetFillClientRect: TRect;
begin
  Result := GetPageClientRect;
end;

function TcxPCCustomPainter.GetFreeSpaceColor: TColor;
begin
  Result := ViewInfo.Color;
end;

function TcxPCCustomPainter.GetPageClientRectOffset: TRect;
var
  ABorders: TcxBorders;
  ABorderOffsets: TRect;
begin
  Result := GetPageFrameRectOffset;
  if NeedShowFrame then
  begin
    ABorders := GetPageBorders;
    ABorderOffsets := cxEmptyRect;
    if bLeft in ABorders then
      Inc(ABorderOffsets.Left, GetBorderWidths.Left);
    if bTop in ABorders then
      Inc(ABorderOffsets.Top, GetBorderWidths.Top);
    if bRight in ABorders then
      Inc(ABorderOffsets.Right, GetBorderWidths.Right);
    if bBottom in ABorders then
      Inc(ABorderOffsets.Bottom, GetBorderWidths.Bottom);
    ABorderOffsets := RotateRectBack(ABorderOffsets, ViewInfo.TabPosition);
    Result := cxRectTransform(Result, ABorderOffsets)
  end;
end;

function TcxPCCustomPainter.GetDefaultClientColor: TColor;
begin
  Result := ViewInfo.Color;
end;

function TcxPCCustomPainter.GetPageFrameRect: TRect;
begin
  Result := GetExtendedRect(ViewInfo.ControlBounds,
    GetPageFrameRectOffset, ViewInfo.TabPosition);
  ValidateRect(Result);
end;

function TcxPCCustomPainter.GetPageFrameRectOffset: TRect;
begin
  Result := cxEmptyRect;
  if ViewInfo.HideTabs or (ViewInfo.RowCount = 0) then
    Exit;
  case ViewInfo.TabPosition of
    tpTop:
      begin
        Result.Top := ViewInfo.FExtendedTopOrLeftTabsRect.Bottom;
        if ViewInfo.TopOrLeftPartRowCount <> ViewInfo.RowCount then
          Result.Bottom := ViewInfo.Height - ViewInfo.FExtendedBottomOrRightTabsRect.Top;
      end;
    tpLeft:
      begin
        Result.Top := ViewInfo.FExtendedTopOrLeftTabsRect.Right;
        if ViewInfo.TopOrLeftPartRowCount <> ViewInfo.RowCount then
          Result.Bottom := ViewInfo.Width - ViewInfo.FExtendedBottomOrRightTabsRect.Left;
      end;
    tpBottom:
      begin
        if ViewInfo.IsTooSmallControlSize then
          Result.Top := ViewInfo.FExtendedTopOrLeftTabsRect.Top
        else
          Result.Top := ViewInfo.Height - ViewInfo.FExtendedBottomOrRightTabsRect.Top;
        if ViewInfo.TopOrLeftPartRowCount <> 0 then
          Result.Bottom := ViewInfo.FExtendedTopOrLeftTabsRect.Bottom;
      end;
    tpRight:
      begin
        if ViewInfo.IsTooSmallControlSize then
          Result.Top := ViewInfo.FExtendedTopOrLeftTabsRect.Left
        else
          Result.Top := ViewInfo.Width - ViewInfo.FExtendedBottomOrRightTabsRect.Left;
        if ViewInfo.TopOrLeftPartRowCount <> 0 then
          Result.Bottom := ViewInfo.FExtendedTopOrLeftTabsRect.Right;
      end;
  end;
end;

function TcxPCCustomPainter.GetLookAndFeelPainterClass: TcxCustomLookAndFeelPainterClass;
begin
  Result := ViewInfo.GetLookAndFeel.Painter;
end;

function TcxPCCustomPainter.GetBorderWidths: TRect;
var
  AWidth: Integer;
begin
  AWidth := GetFrameWidth;
  Result := cxRect(AWidth, AWidth, AWidth, AWidth);
end;

function TcxPCCustomPainter.GetExtendedRect(const ARect, AExtension: TRect; ATabPosition: TcxTabPosition): TRect;
begin
  Result := ARect;
  cxGraphics.ExtendRect(Result, RotateRect(AExtension, ATabPosition));
end;

function TcxPCCustomPainter.GetFrameWidth: Integer;
begin
  Result := 0;
end;

function TcxPCCustomPainter.GetDisabledTextFaceColor: TColor;
begin
  Result := clBtnHighlight;
end;

function TcxPCCustomPainter.GetDisabledTextShadowColor: TColor;
begin
  Result := clBtnShadow;
end;

function TcxPCCustomPainter.GetHighlightedTabBodyColor: TColor;
begin
  Result := clHighlight;
end;

function TcxPCCustomPainter.GetImagePainter: TcxPCImageList;
begin
  Result :=  ViewInfo.Properties.FImages;
end;

function TcxPCCustomPainter.GetTabViewInfo(Index: Integer): TcxTabViewInfo;
begin
  Result := ViewInfo.TabsViewInfo[Index];
end;

procedure TcxPCCustomPainter.AfterPaintTab(ACanvas: TcxCanvas; ATabVisibleIndex: Integer);
var
  AImageAndTextData: TcxPCOutTabImageAndTextData;
  ATabViewInfo: TcxTabViewInfo;
begin
  ATabViewInfo := TabViewInfo[ATabVisibleIndex];
  AImageAndTextData.TabImageRect := ATabViewInfo.GetAbsolutePartRect(ATabViewInfo.ImageRect);
  AImageAndTextData.TabTextRect := ATabViewInfo.GetAbsolutePartRect(ATabViewInfo.TextRect);
  AImageAndTextData.TabVisibleIndex := ATabVisibleIndex;
  ViewInfo.AfterPaintTab(ACanvas, TabViewInfo[ATabVisibleIndex].Tab, AImageAndTextData);
end;

function TcxPCCustomPainter.AlwaysColoredTabs: Boolean;
begin
  Result := False;
end;

function TcxPCCustomPainter.GetHighlightedTextColor(ATabVisibleIndex: Integer;
  ATextColor: TColor): TColor;
var
  AColor: TColorRef;
  ATheme: TdxTheme;
begin
  if IsNativePainting then
  begin
    ATheme := OpenTheme(totTab);
    if GetThemeColor(ATheme, TABP_TABITEM, GetTabNativeState(ATabVisibleIndex), TMT_TEXTCOLOR, AColor) = S_OK then
      Result := AColor
    else
      Result := ATextColor;
  end
  else
    Result := clHighlightText;
end;

function TcxPCCustomPainter.GetHotTrackColor: TColor;
begin
  Result := GetSysColor(COLOR_HOTLIGHT)
end;

function TcxPCCustomPainter.GetMaxTabCaptionHeight: Integer;
var
  ATextHeight: Integer;
  I: Integer;
begin
  Result := 0;
  for I := 0 to ViewInfo.TabsViewInfo.ViewInfoCount - 1 do
  begin
    ATextHeight := TextSize(TabViewInfo[I], 'Zg').cy;
    if ATextHeight > Result then
      Result := ATextHeight;
  end;
end;

function TcxPCCustomPainter.GetNativeContentOffset: TRect;
var
  R: TRect;
begin
  R := Rect(0, 0, 100, 100);
  GetThemeBackgroundContentRect(OpenTheme(totTab), 0, TABP_PANE, 0, R, Result);
  Result.Right := R.Right - Result.Right;
  Result.Bottom := R.Bottom - Result.Bottom;

  if IsStandardTheme then
  begin
    if ViewInfo.IsTabsContainer then
      Result.Left := TabsContainerBaseWidth
    else
      Result.Left := Max(Result.Left, Result.Top);
    Result.Top := Result.Left;
    Result.Right := Result.Left * 2;//Max(Result.Right, Result.Bottom);
    Result.Bottom := Result.Top * 2;//Result.Right;
  end;
end;

function TcxPCCustomPainter.GetTabBaseImageSize: TSize;
begin
  Result := ViewInfo.GetTabImageSize;
end;

function TcxPCCustomPainter.GetTabColor(ATabVisibleIndex: Integer): TColor;
begin
  Result := ViewInfo.TabColors[ATabVisibleIndex];
end;

function TcxPCCustomPainter.GetTabClipRgn(ACanvas: TcxCanvas; ATabVisibleIndex: Integer): TcxRegion;
begin
  Result := TcxRegion.Create(TabViewInfo[ATabVisibleIndex].VisibleRect);
end;

function TcxPCCustomPainter.GetTabClipRgnOperation(ATabVisibleIndex: Integer): TcxRegionOperation;
begin
  Result := roIntersect;
end;

function TcxPCCustomPainter.GetTabImageAreaHeight: Integer;
begin
  Result := ViewInfo.GetTabImageAreaHeight;
end;

function TcxPCCustomPainter.GetTabImageAreaWidth: Integer;
begin
  Result := ViewInfo.GetTabImageAreaWidth;
end;

procedure TcxPCCustomPainter.GetTabNativePartAndState(ATabVisibleIndex: Integer;
  out PartId, StateId: Integer);
begin
  PartId := 0;
  StateId := 0;
end;

function TcxPCCustomPainter.GetTabNativeState(ATabVisibleIndex: Integer): Integer;
var
  ATabViewInfo: TcxTabViewInfo;
begin
  ATabViewInfo := TabViewInfo[ATabVisibleIndex];
  if ATabViewInfo.IsMainTab then
    Result := TIS_SELECTED
  else
    if ATabViewInfo.IsHotTrack then
      Result := TIS_HOT
    else
      Result := TIS_NORMAL;
end;

function TcxPCCustomPainter.GetTabRotatedImageSize: TSize;
begin
  Result := ImagePainter.RotatedImageSize;
end;

function TcxPCCustomPainter.GetTabsContainerOffsets: TRect;
begin
  Result := cxEmptyRect;
end;

function TcxPCCustomPainter.GetTabsNormalDistance: TcxPCDistance;
begin
  Result.dw := 0;
  Result.dh := 0;
end;

function TcxPCCustomPainter.GetTextColor(ATabVisibleIndex: Integer): TColor;
var
  ATabViewInfo: TcxTabViewInfo;
begin
  ATabViewInfo := TabViewInfo[ATabVisibleIndex];
  if ATabViewInfo.IsHighlighted then
    Result := GetHighlightedTextColor(ATabVisibleIndex, ViewInfo.Font.Color)
  else
    if ATabViewInfo.IsHotTrack then
      Result := GetHotTrackColor
  else
    Result := clBtnText;
end;

function TcxPCCustomPainter.HasActivePage: Boolean;
begin
  Result := ViewInfo.HasActivePage;
end;

procedure TcxPCCustomPainter.Init;
begin
end;

procedure TcxPCCustomPainter.InternalPaint(ACanvas: TcxCanvas);

  procedure DoPaintHeadersArea;
  begin
    if not ViewInfo.HideTabs then
      PaintHeadersArea(ACanvas);
  end;

begin
  if IsPaintHeadersAreaFirst then
    DoPaintHeadersArea;
  PaintPageClientArea(ACanvas);
  PaintPageFrame(ACanvas);
  if not IsPaintHeadersAreaFirst then
    DoPaintHeadersArea;
end;

procedure TcxPCCustomPainter.InternalDrawText(ACanvas: TcxCanvas;
  const ACaption: string; ARect: TRect; ATabVisibleIndex: Integer);
var
  APartId, AStateId: Integer;
begin
  if IsNativePainting and TabViewInfo[ATabVisibleIndex].ActuallyEnabled and
    AreVisualStylesAvailable then
  begin
    GetTabNativePartAndState(ATabVisibleIndex, APartId, AStateId);
    DrawThemeText(OpenTheme(totTab), ACanvas.Canvas.Handle, APartId,
      AStateId, ACaption, -1, DT_SINGLELINE or DT_END_ELLIPSIS, 0, ARect);
  end
  else
    cxDrawText(ACanvas, ACaption, ARect, DT_SINGLELINE or DT_END_ELLIPSIS, clDefault, InternalGetTextRotationAngle(ViewInfo));
end;

procedure TcxPCCustomPainter.InternalPolyLine(const APoints: array of TPoint;
  AColor: TColor; ACanvas: TcxCanvas);
var
  ALastPoint: TPoint;
begin
  ACanvas.Pen.Color := AColor;
  ACanvas.Polyline(APoints);
  ALastPoint := APoints[High(APoints)];
  ACanvas.Polyline([ALastPoint, Point(ALastPoint.X + 1, ALastPoint.Y + 1)]);
end;

procedure TcxPCCustomPainter.InternalResetClipRegion(ACanvas: TcxCanvas);
begin
  ACanvas.RestoreClipRegion;
end;

function TcxPCCustomPainter.InternalSetClipRect(ACanvas: TcxCanvas; ClipR: TRect;
  IntersectWithCurrentClipRegion: Boolean = True): Boolean;
begin
  Result := False;
  if IsRectEmpty(ClipR) then Exit;
  with ACanvas do
  begin
    if IntersectWithCurrentClipRegion and
      (not Windows.RectVisible(Handle, ClipR)) then Exit;
    SaveClipRegion;
    if IntersectWithCurrentClipRegion then
      IntersectClipRect(ClipR)
    else
      SetClipRegion(TcxRegion.Create(ClipR), roSet);
  end;
  Result := True;
end;

procedure TcxPCCustomPainter.InvalidateTabExtendedTabsRect(TabVisibleIndex: Integer);
var
  ATabExtendedRect: TRect;
begin
  with ViewInfo do
    ATabExtendedRect := GetTabExtendedTabsRect(TabVisibleIndex);
  ViewInfo.InvalidateRect(ATabExtendedRect, False);
end;

procedure TcxPCCustomPainter.InvalidateTabRect(ATabVisibleIndex: Integer);
begin
  ViewInfo.InvalidateRect(TabViewInfo[ATabVisibleIndex].VisibleRect, False);
end;

function TcxPCCustomPainter.IsAssignedImages: Boolean;
begin
  Result := ViewInfo.IsTabImagesAssigned;
end;

function TcxPCCustomPainter.IsEnableHotTrack: Boolean;
begin
  Result := IsNativePainting;
end;

function TcxPCCustomPainter.IsNativePainting: Boolean;
begin
  Result := False;
end;

function TcxPCCustomPainter.PtInTab(TabVisibleIndex: Integer; X,
  Y: Integer): Boolean;
begin
  Result := True;
end;

function TcxPCCustomPainter.IsPaintHeadersAreaFirst: Boolean;
begin
  Result := True;
end;

function TcxPCCustomPainter.IsTabHasImage(ATabVisibleIndex: Integer): Boolean;
begin
  Result := TabViewInfo[ATabVisibleIndex].HasImage;
end;

function TcxPCCustomPainter.IsTabTransparent(ATabVisibleIndex: Integer): Boolean;
begin
  Result := False;
end;

function TcxPCCustomPainter.IsTabsRectVisible(ACanvas: TcxCanvas): Boolean;
var
  r1, r2, r3, r4: TRect;
  AControlRect, AClientRect: TRect;
begin
  AControlRect := ViewInfo.ControlBounds;
  AClientRect := GetPageClientRect;
  r1 := AControlRect;
  r1.Right := AClientRect.Left;
  r2 := AControlRect;
  r2.Bottom := AClientRect.Top;
  r3 := AControlRect;
  r3.Left := AClientRect.Right;
  r4 := AControlRect;
  r4.Top := AClientRect.Bottom;
  with ACanvas do
    Result := RectVisible(r1) or
      RectVisible(r2) or
      RectVisible(r3) or
      RectVisible(r4);
end;

function TcxPCCustomPainter.NeedDisabledTextShadow: Boolean;
begin
  Result := True;
end;

function TcxPCCustomPainter.NeedDoubleBuffer: Boolean;
begin
  Result := False;
end;

function TcxPCCustomPainter.NeedRedrawOnResize: Boolean;
begin
  Result := IsNativePainting;
end;

function TcxPCCustomPainter.NeedShowFrame: Boolean;
begin
  Result := ViewInfo.ShowFrame;
end;

procedure TcxPCCustomPainter.PaintDragImage(ACanvas: TcxCanvas; const R: TRect; ATabVisibleIndex: Integer);
begin
  StartDragImagePainted;
  try
    InternalPaintDragImage(ACanvas, ATabVisibleIndex);
  finally
    StopDragImagePainted;
  end;
end;

procedure TcxPCCustomPainter.Paint(ACanvas: TcxCanvas);
begin
  InternalPaint(ACanvas);
  DrawBackground(ACanvas);
end;

procedure TcxPCCustomPainter.PaintPageClientArea(ACanvas: TcxCanvas);
begin
  FillPageClientRect(ACanvas);
  ACanvas.ExcludeClipRect(GetPageClientRect);
end;

procedure TcxPCCustomPainter.DoPaintPageFrame(ACanvas: TcxCanvas);
begin
end;

procedure TcxPCCustomPainter.PaintHeadersArea(ACanvas: TcxCanvas);
begin
  PaintButtonsRegion(ACanvas);
  if IsTabsRectVisible(ACanvas) then
    PaintTabsRegion(ACanvas);
end;

procedure TcxPCCustomPainter.PaintPageFrame(ACanvas: TcxCanvas);
begin
  if NeedShowFrame then
    DoPaintPageFrame(ACanvas);
  ACanvas.ExcludeClipRect(GetPageFrameRect);
end;

procedure TcxPCCustomPainter.PaintTab(ACanvas: TcxCanvas; TabVisibleIndex: Integer);
begin
// do nothing
end;

procedure TcxPCCustomPainter.PrepareDrawTabContentBitmapBackground(
  ABitmap: TcxBitmap; const ABitmapPos: TPoint; ATabVisibleIndex: Integer);
begin
end;

procedure TcxPCCustomPainter.DrawTabContentBackground(ACanvas: TcxCanvas;
  const ABounds: TRect; ABackgroundColor: TColor; ATabVisibleIndex: Integer);
begin
  ACanvas.FillRect(ABounds, ABackgroundColor);
end;

procedure TcxPCCustomPainter.RepaintButtonsRegion;
begin
end;

procedure TcxPCCustomPainter.RepaintTab(TabVisibleIndex: Integer;
  TabPropertyChanged: TcxPCTabPropertyChanged);
begin
end;

procedure TcxPCCustomPainter.RotatePoint(const R: TRect; var P: TPoint;
  ATabPosition: TcxTabPosition);
begin
  case ATabPosition of
    tpBottom:
      P.Y := R.Bottom - 1 - (P.Y - R.Top);
    tpLeft:
      P := Point(R.Right - 1 - (R.Bottom - 1 - P.Y), R.Bottom - 1 - (P.X - R.Left));
    tpRight:
      P := Point(R.Bottom - 1 - P.Y + R.Left, R.Bottom - 1 - (P.X - R.Left));
  end;
end;

procedure TcxPCCustomPainter.RotatePolyline(const R: TRect; var APoints: array of TPoint;
  ATabPosition: TcxTabPosition);
var
  I: Integer;
begin
  for I := 0 to High(APoints) do
    RotatePoint(R, APoints[I], ATabPosition);
end;

function TcxPCCustomPainter.UseActivePageColor: Boolean;
begin
  Result := ViewInfo.UseActivePageColor;
end;

function TcxPCCustomPainter.UseLookAndFeelCloseButton: Boolean;
begin
  Result := False;
end;

function TcxPCCustomPainter.IsDragImagePainted: Boolean;
begin
  Result := FIsDragImagePainted;
end;

procedure TcxPCCustomPainter.StartDragImagePainted;
begin
  FIsDragImagePainted := True;
end;

procedure TcxPCCustomPainter.StopDragImagePainted;
begin
  FIsDragImagePainted := False;
end;

{ TcxPCImageList }

constructor TcxPCImageList.Create(AProperties: TcxCustomTabControlProperties);
begin
  inherited Create;
  FProperties := AProperties;

  FBaseHotImageChangeLink := TChangeLink.Create;
  FBaseHotImageChangeLink.OnChange := BaseImageListChange;
  FBaseImageChangeLink := TChangeLink.Create;
  FBaseImageChangeLink.OnChange := BaseImageListChange;
  FImageRotationAngle := ra0;

  FFreeNotificator := TcxFreeNotificator.Create(nil);
  FFreeNotificator.OnFreeNotification := FreeNotification;
end;

destructor TcxPCImageList.Destroy;
begin
  FFreeNotificator.Free;
  FBaseImageChangeLink.Free;
  FBaseHotImageChangeLink.Free;
  inherited Destroy;
end;

function TcxPCImageList.IsImagesAssigned: Boolean;
begin
  Result := (FBaseImages <> nil) or (FBaseHotImages <> nil);
end;

procedure TcxPCImageList.Draw(ACanvas: TcxCanvas; X, Y, AIndex: Integer;
  ABackgroundColor: TColor; AIsNativePainting, AEnabled, AHot: Boolean);

  procedure DrawBitmap(ACanvas: TcxCanvas; X, Y: Integer);
  begin
    GetImages(AHot).Draw(ACanvas.Canvas, X, Y, AIndex, AEnabled)
  end;

  procedure DrawBitmapBackground(ABitmap: TcxBitmap);
  begin
    ABitmap.cxCanvas.CopyRect(cxRect(BaseImageSize), ACanvas.Canvas,
      cxRectOffset(cxRect(BaseImageSize), X, Y));
  end;

  function CreateRotatedBitmap: TcxBitmap;
  begin
    Result:= TcxBitmap.CreateSize(cxRect(BaseImageSize), pf32bit);
    Result.HandleType := bmDDB;
    if AIsNativePainting then
      Result.Transparent := True;
    DrawBitmapBackground(Result);
    DrawBitmap(Result.cxCanvas, 0, 0);
    Result.Rotate(ImageRotationAngle);
  end;

  procedure CheckImageIndex;
  var
    AImages: TCustomImageList;
  begin
    AImages := GetImages(AHot);
    if AImages = nil then
      OutError('Draw', scxPCNoBaseImages);
    if (AIndex < 0) or (AIndex >= AImages.Count) then
      OutError('Draw', Format(scxPCImageListIndexError, [AIndex, AImages.Count - 1]));
  end;

var
  ARotatedBitmap: TcxBitmap;
begin
  CheckImageIndex;
  if ImageRotationAngle = ra0 then
    DrawBitmap(ACanvas, X, Y)
  else
  begin
    ARotatedBitmap := CreateRotatedBitmap;
    ACanvas.Draw(X, Y, ARotatedBitmap);
    ARotatedBitmap.Free;
  end;
end;

procedure TcxPCImageList.BaseImageListChange(Sender: TObject);
begin
  Change;
end;

procedure TcxPCImageList.Change;
begin
  CallNotify(OnChange, Self);
end;

function TcxPCImageList.GetBaseImageSize: TSize;
var
  AImages: TCustomImageList;
begin
  AImages := GetImages(FBaseImages = nil);
  if AImages = nil then
    Result := cxNullSize
  else
    Result := cxSize(AImages.Width, AImages.Height);
end;

function TcxPCImageList.GetImages(AHot: Boolean): TCustomImageList;
begin
  if AHot and (FBaseHotImages <> nil) then
    Result := FBaseHotImages
  else
    Result := FBaseImages;
end;

function TcxPCImageList.GetRotatedImageSize: TSize;
begin
  Result := GetBaseImageSize;
  if ImageRotationAngle <> ra0 then
    Result := cxSize(Result.cy, Result.cx);
end;

procedure TcxPCImageList.FreeNotification(AComponent: TComponent);
begin
  if AComponent = BaseImages then
    BaseImages := nil
  else
    if AComponent = BaseHotImages then
      BaseHotImages := nil;
end;

class procedure TcxPCImageList.OutError(SourceMethodName, Msg: TCaption);
begin
  raise EdxException.Create('TcxPCImageList.' + SourceMethodName + ': ' + Msg);
end;

procedure TcxPCImageList.SetBaseHotImages(const Value: TCustomImageList);
begin
  cxSetImageList(Value, FBaseHotImages, FBaseHotImageChangeLink, FFreeNotificator);
end;

procedure TcxPCImageList.SetBaseImages(
  const Value: TCustomImageList);
begin
  cxSetImageList(Value, FBaseImages, FBaseImageChangeLink, FFreeNotificator);
end;

{ TcxTabSlants }

constructor TcxTabSlants.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
  FKind := skSlant;
  FPositions := [spLeft];
end;

procedure TcxTabSlants.Assign(Source: TPersistent);
begin
  if Source is TcxTabSlants then
  begin
    Kind := TcxTabSlants(Source).Kind;
    Positions := TcxTabSlants(Source).Positions;
  end
  else
    inherited Assign(Source);
end;

function TcxTabSlants.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TcxTabSlants.Changed;
begin
  CallNotify(FOnChange, Self);
end;

procedure TcxTabSlants.SetKind(Value: TcxTabSlantKind);
begin
  if Value <> FKind then
  begin
    FKind := Value;
    Changed;
  end;
end;

procedure TcxTabSlants.SetPositions(Value: TcxTabSlantPositions);
begin
  if Value <> FPositions then
  begin
    FPositions := Value;
    Changed;
  end;
end;

{ TcxPCCustomGoDialog }

constructor TcxPCCustomGoDialog.Create(ATabControl: IcxTabControl);
begin
  inherited Create;
  FTabControl := ATabControl;
end;

function TcxPCCustomGoDialog.GetViewInfo: TcxCustomTabControlViewInfo;
begin
  Result := TabControl.ViewInfo;
end;

{ TcxTabControlDragAndDropObject }

constructor TcxTabControlDragAndDropObject.Create(AIControl: IcxTabControl);
begin
  inherited Create(nil);
  FIControl := AIControl;
  Canvas := FIControl.GetCanvas;
  FDestinationTabVisibleIndex := -1;
  FHitTabVisibleIndex := -1;
end;

procedure TcxTabControlDragAndDropObject.BeginDragAndDrop;
begin
  inherited BeginDragAndDrop;
  CreateDragImage;
end;

procedure TcxTabControlDragAndDropObject.DragAndDrop(const P: TPoint; var Accepted: Boolean);

  function CalculateDestinationTabVisibleIndex: Integer;
  var
    AIsTop, AIsLeft: Boolean;
    AIsAfter: Boolean;
    AIsBefore: Boolean;
  begin
    FHitTabVisibleIndex := ViewInfo.VisibleIndexOfTabAt(P.X, P.Y);
    Result := FHitTabVisibleIndex;
    if (Result <> -1) and ((Result = FTabVisibleIndex) or ViewInfo.TabsViewInfo[Result].IsNewButton) then
      Result := -1;
    if (Result <> -1) then
    begin
      with ViewInfo.TabsViewInfo[Result].NormalRect do
      begin
        AIsTop := ((Top + Bottom) div 2) < P.Y;
        AIsLeft := ((Left + Right) div 2) < P.X;
      end;

      AIsAfter := (Result < FTabVisibleIndex) and (
        ((Properties.TabPosition in [tpLeft, tpRight]) and (ViewInfo.IsBottomToTopAlignment xor AIsTop)) or
        ((Properties.TabPosition in [tpTop, tpBottom]) and (ViewInfo.IsRightToLeftAlignment xor AIsLeft)));
      if AIsAfter then
        Inc(Result);

      AIsBefore := (Result > FTabVisibleIndex) and (
        ((Properties.TabPosition in [tpLeft, tpRight]) and not (ViewInfo.IsBottomToTopAlignment xor AIsTop)) or
        ((Properties.TabPosition in [tpTop, tpBottom]) and not (ViewInfo.IsRightToLeftAlignment xor AIsLeft)));
      if AIsBefore then
        Dec(Result);

      if Result = FTabVisibleIndex then
        Result := -1;
    end;
  end;
begin
  ShowDragImage;
  DestinationTabVisibleIndex := CalculateDestinationTabVisibleIndex;
  CheckScrolling(P);
  Accepted := (DestinationTabVisibleIndex <> -1) and (DestinationTabVisibleIndex <> FTabVisibleIndex);
  inherited DragAndDrop(P, Accepted);
end;

procedure TcxTabControlDragAndDropObject.EndDragAndDrop(Accepted: Boolean);
begin
  DestroyDragImage;
  DestroyDestinationImage;
  DestroyScrollingTimer;
  Drop(Accepted);
  inherited EndDragAndDrop(Accepted);
end;

procedure TcxTabControlDragAndDropObject.Init(ATabVisibleIndex: Integer; const P: TPoint);
begin
  FTabVisibleIndex := ATabVisibleIndex;
  FDragPointOffset := cxPointOffset(ViewInfo.TabsViewInfo[FTabVisibleIndex].FullRect.TopLeft, P, False);
end;

function TcxTabControlDragAndDropObject.GetDragAndDropCursor(Accepted: Boolean): TCursor;
begin
  if Accepted then
    Result := crDefault
  else
    Result := crNoDrop;
end;

procedure TcxTabControlDragAndDropObject.CheckScrolling(const P: TPoint);

  function NeedScrolling: Boolean;
  begin
    Result := not ViewInfo.MultiLine and ViewInfo.PtInScrollingArea(P, FScrollingDirection);
  end;

  procedure CheckTimer;
  begin
    if FScrollingTimer = nil then
      CreateScrollingTimer;
  end;

begin
  if NeedScrolling then
    CheckTimer
  else
    DestroyScrollingTimer;
end;

procedure TcxTabControlDragAndDropObject.CreateDestinationImage;
const
  ArrowPlaceMap: array[Boolean, Boolean] of TcxArrowPlace = ((apRight, apBottom), (apLeft, apTop));
var
  AControlOrigin: TPoint;
  R: TRects;
begin
  AControlOrigin := FIControl.Controller.GetClientToScreen(cxNullPoint);
  SetLength(R, 2);
  try
    R := ViewInfo.Painter.GetDropArrowRects(FTabVisibleIndex, FHitTabVisibleIndex, DestinationTabVisibleIndex);
    FDestinationArrowFirst := TcxDragAndDropArrow.Create(True);
    FDestinationArrowFirst.Init(AControlOrigin, cxNullRect, R[0], ArrowPlaceMap[True, ViewInfo.TabPosition in [tpTop, tpBottom]]);
    FDestinationArrowSecond := TcxDragAndDropArrow.Create(True);
    FDestinationArrowSecond.Init(AControlOrigin, cxNullRect, R[1], ArrowPlaceMap[False, ViewInfo.TabPosition in [tpTop, tpBottom]]);
    FDestinationArrowFirst.Visible := True;
    FDestinationArrowSecond.Visible := True;
  finally
    SetLength(R, 0);
  end;
end;

procedure TcxTabControlDragAndDropObject.CreateDragImage;
begin
  FDragImage := TcxDragImage.Create;
  PaintDragImage;
end;

procedure TcxTabControlDragAndDropObject.CreateScrollingTimer;
begin
  FScrollingTimer := TcxTimer.Create(nil);
  FScrollingTimer.Interval := TabScrollingStartDelay;
  FScrollingTimer.OnTimer := ScrollingTimerHandler;
end;

procedure TcxTabControlDragAndDropObject.DestroyDestinationImage;
begin
  FreeAndNil(FDestinationArrowFirst);
  FreeAndNil(FDestinationArrowSecond);
end;

procedure TcxTabControlDragAndDropObject.DestroyDragImage;
begin
  FreeAndNil(FDragImage);
end;

procedure TcxTabControlDragAndDropObject.DestroyScrollingTimer;
begin
  FreeAndNil(FScrollingTimer);
end;

procedure TcxTabControlDragAndDropObject.Drop(Accepted: Boolean);
var
  AIndex: Integer;
  ADestinationIndex: Integer;
begin
  if Accepted and (DestinationTabVisibleIndex <> -1) then
  begin
    AIndex := ViewInfo.TabsViewInfo[FTabVisibleIndex].Index;
    ADestinationIndex := ViewInfo.TabsViewInfo[DestinationTabVisibleIndex].Index;
    FIControl.Properties.BeginUpdate;
    try
      FIControl.Properties.MoveTab(AIndex, ADestinationIndex);
      FIControl.Properties.TabIndex := ADestinationIndex;
    finally
      FIControl.Properties.EndUpdate;
    end;
  end;
end;

function TcxTabControlDragAndDropObject.GetClientCursorPos: TPoint;
begin
  Result := FIControl.Controller.GetMouseCursorPos;
end;

procedure TcxTabControlDragAndDropObject.PaintDragImage;
var
  R: TRect;
begin
  R := ViewInfo.TabsViewInfo[FTabVisibleIndex].FullRect;
  FDragImage.SetBounds(0, 0, cxRectWidth(R), cxRectHeight(R));
  FDragImage.Canvas.WindowOrg := R.TopLeft;
  FDragImage.Canvas.Canvas.Lock;
  try
    ViewInfo.Painter.PaintDragImage(FDragImage.Canvas, R, FTabVisibleIndex);
  finally
    FDragImage.Canvas.Canvas.Unlock;
  end;
end;

procedure TcxTabControlDragAndDropObject.ShowDragImage;
var
  P: TPoint;
begin
  P := cxPointOffset(GetMouseCursorPos, FDragPointOffset);
  FDragImage.MoveTo(P);
  FDragImage.Show;
end;

function TcxTabControlDragAndDropObject.GetProperties: TcxCustomTabControlProperties;
begin
  Result := FIControl.Properties;
end;

function TcxTabControlDragAndDropObject.GetViewInfo: TcxCustomTabControlViewInfo;
begin
  Result := FIControl.ViewInfo;
end;

procedure TcxTabControlDragAndDropObject.ScrollingTimerHandler(Sender: TObject);
begin
  ViewInfo.FirstVisibleTab := ViewInfo.FirstVisibleTab + FScrollingDirection;
  FIControl.RequestLayout;
  
  FScrollingTimer.Interval := TabScrollingDelay;
end;

procedure TcxTabControlDragAndDropObject.SetDestinationTabVisibleIndex(Value: Integer);
begin
  if DestinationTabVisibleIndex <> Value then
  begin
    if DestinationTabVisibleIndex <> -1 then
      DestroyDestinationImage;
    FDestinationTabVisibleIndex := Value;
    if DestinationTabVisibleIndex <> -1 then
      CreateDestinationImage;
  end;
end;

{ TcxCustomTabControlHitTest }

constructor TcxCustomTabControlHitTest.Create(AOwner: TcxCustomTabControlController);
begin
  inherited Create;
  FController := AOwner;
end;

procedure TcxCustomTabControlHitTest.Clear;
begin
  FFlags := 0;
  FHitObject := nil;
end;

procedure TcxCustomTabControlHitTest.Recalculate;
begin
  Clear;
  FController.ViewInfo.CalculateHitTest(Self);
end;

procedure TcxCustomTabControlHitTest.Update(AShift: TShiftState; const APoint: TPoint);
begin
  FShift := AShift;
  FHitPoint := APoint;
  Recalculate;
end;

function TcxCustomTabControlHitTest.GetBitState(AIndex: Integer): Boolean;
begin
  Result := (FFlags and (1 shl AIndex)) <> 0;
end;

procedure TcxCustomTabControlHitTest.SetBitState(AIndex: Integer;
  AValue: Boolean);
begin
  if AValue then
    FFlags := FFlags or (1 shl AIndex)
  else
    FFlags := FFlags and not (1 shl AIndex);
end;

{ TcxCustomTabControlController }

constructor TcxCustomTabControlController.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  FHitTest := TcxCustomTabControlHitTest.Create(Self);
  FMouseDownTabVisibleIndex := -1;
  CreateGoDialog;
end;

destructor TcxCustomTabControlController.Destroy;
begin
  FreeAndNil(FTimer);
  FreeAndNil(FGoDialog);
  FreeAndNil(FHitTest);
  inherited;
end;

procedure TcxCustomTabControlController.ScrollTabs(ADelta: Integer);
var
  I: Integer;
begin
  if not Properties.MultiLine then
  begin
    for I := 0 to Abs(ADelta) - 1 do
      if ADelta < 0 then
        ArrowButtonClick(nbTopLeft)
      else
        ArrowButtonClick(nbBottomRight);
  end;
end;

function TcxCustomTabControlController.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := ViewInfo.CanMouseWheel(MousePos);
  if Result then
    ScrollTabs(1);
end;

function TcxCustomTabControlController.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := ViewInfo.CanMouseWheel(MousePos);
  if Result then
    ScrollTabs(-1);
end;

procedure TcxCustomTabControlController.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

  procedure NavigatorButtonDown(AButtonInfo: TcxPCNavigatorButtonViewInfo);
  var
    AButtonType: TcxPCNavigatorButton;
  begin
    ViewInfo.PressedNavigatorButton := AButtonInfo;
    AButtonType := AButtonInfo.ButtonType;
    if AButtonType in [nbTopLeft, nbBottomRight] then
    begin
      ArrowButtonClick(AButtonType);
      if (ViewInfo.FPressedNavigatorButton <> nil) and
        (ViewInfo.PressedNavigatorButton.ButtonType = AButtonType) then
        CreateTimer;
    end;
  end;

var
  AButtonInfo: TcxPCNavigatorButtonViewInfo;
  AGoDialogJustClosed: Boolean;
  ATabIndex: Integer;
begin
  AGoDialogJustClosed := FGoDialogJustClosed;
  FGoDialogJustClosed := False;
  if not IControl.IsDesigning and (Properties.HideTabs or (Button <> mbLeft)) then
    Exit;

  if FHitTest.HitAtNavigatorButton then
  begin
    AButtonInfo := TcxPCNavigatorButtonViewInfo(FHitTest.HitObject);
    if (not AGoDialogJustClosed or (AButtonInfo.ButtonType <> nbGoDialog)) and
      (AButtonInfo.State <> nbsDisabled) then
      NavigatorButtonDown(AButtonInfo)
  end
  else
  begin
    ATabIndex := ViewInfo.VisibleIndexOfTabAt(X, Y);
    if HitTest.HitAtTabCloseButton  then
      TabCloseButtonDown(TcxPCTabCloseButtonViewInfo(HitTest.HitObject))
    else
      TabDown(ATabIndex, Shift);
  end;
end;

procedure TcxCustomTabControlController.MouseLeave;
begin
  ViewInfo.SynchronizeHotTrackStates(InternalGetShiftState);
end;

procedure TcxCustomTabControlController.MouseMove(Shift: TShiftState; X, Y: Integer);

  procedure CheckArrowNavigatorButtonsPressed(AButtonInfo: TcxPCNavigatorButtonViewInfo);
  var
    AButtonType: TcxPCNavigatorButton;
  begin
    AButtonType := AButtonInfo.ButtonType;
    ArrowButtonClick(AButtonType);
    if (ViewInfo.PressedNavigatorButton <> nil) and
      (ViewInfo.PressedNavigatorButton.ButtonType = AButtonType) then
      CreateTimer;
  end;

  procedure CheckTabsScrolling (APrevButtonInfo: TcxPCNavigatorButtonViewInfo);
  var
    AButtonInfo: TcxPCNavigatorButtonViewInfo;
  begin
    AButtonInfo := ViewInfo.HotTrackNavigatorButton;
    if not IsScrollTimerStarted and (APrevButtonInfo <> AButtonInfo) and
      (AButtonInfo <> nil) and (AButtonInfo.ButtonType in [nbTopLeft, nbBottomRight]) and
      (AButtonInfo.State = nbsPressed) then
    CheckArrowNavigatorButtonsPressed(AButtonInfo);
  end;

var
  ATabVisibleIndex: Integer;
  APrevButtonInfo: TcxPCNavigatorButtonViewInfo;
begin
  FHitTest.Update(Shift, cxPoint(X, Y));
  if Properties.HideTabs or FIsGoDialogShowing then Exit;
  ATabVisibleIndex := ViewInfo.VisibleIndexOfTabAt(X, Y);
  if (ATabVisibleIndex <> ViewInfo.FPressedTabVisibleIndex) and
     (ViewInfo.FPressedTabVisibleIndex <> -1) then
    ViewInfo.PressedTabVisibleIndex := -1;
  APrevButtonInfo := ViewInfo.HotTrackNavigatorButton;
  ViewInfo.SynchronizeHotTrackStates(Shift);
  CheckTabsScrolling(APrevButtonInfo);
end;

procedure TcxCustomTabControlController.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  procedure DoNavigatorButtonAction(AButtonType: TcxPCNavigatorButton);
  var
    APressedButtonInfo: TcxPCNavigatorButtonViewInfo;
  begin
    APressedButtonInfo := ViewInfo.PressedNavigatorButton;
    if (APressedButtonInfo <> nil) and (APressedButtonInfo.ButtonType = AButtonType) then
      if AButtonType = nbGoDialog then
        ShowGoDialog
      else
        if AButtonType = nbClose then
          CloseButtonClick;
  end;

  procedure NavigatorButtonUp(AReleasedButtonInfo: TcxPCNavigatorButtonViewInfo);
  begin
    StopScrollTimer;
    if not IControl.IsDesigning and (AReleasedButtonInfo.State <> nbsDisabled) then
      DoNavigatorButtonAction(AReleasedButtonInfo.ButtonType);
  end;

begin
  if Properties.HideTabs or (Button <> mbLeft) or FIsGoDialogShowing then
    Exit;

  if FHitTest.HitAtNavigatorButton then
    NavigatorButtonUp(TcxPCNavigatorButtonViewInfo(FHitTest.HitObject))
  else
    if HitTest.HitAtTabCloseButton then
      TabCloseButtonUp(TcxPCTabCloseButtonViewInfo(FHitTest.HitObject))
    else
      TabUp(ViewInfo.VisibleIndexOfTabAt(X, Y), Shift);
  ViewInfo.PressedTabCloseButton := nil;
  ViewInfo.PressedNavigatorButton := nil;
end;

procedure TcxCustomTabControlController.FocusChanged;
begin
  if not IControl.IsDestroying and (ViewInfo.FocusedTabVisibleIndex <> -1) and
    ViewInfo.TabsViewInfo[ViewInfo.FocusedTabVisibleIndex].ActuallyVisible then
      ViewInfo.RepaintTab(ViewInfo.FocusedTabVisibleIndex, tpcFocused);
end;

function TcxCustomTabControlController.HandleDialogChar(Key: Integer): Boolean;
begin
  Result := ViewInfo.TabsViewInfo.HandleDialogChar(Key);
end;

function TcxCustomTabControlController.KeyDown(var Key: Word; Shift: TShiftState): Boolean;

  function GetCorrectedDelta(ADelta: Integer): Integer;
  const
    DirectionMap: array[Boolean] of Integer = (-1, 1);
  begin
    Result := ADelta * DirectionMap[not ViewInfo.IsSpecialAlignment];
  end;

  function GetNextTabVisibleIndex: Integer;
  const
    DeltaMap: array[Boolean] of Integer = (-1, 1);
  var
    ADelta: Integer;
    ACycle: Boolean;
  begin
    ACycle := False;
    ADelta := 0;
    Result := -1;
    case Key of
      VK_TAB:
        if ssCtrl in Shift then
        begin
          ACycle := True;
          ADelta := DeltaMap[not (ssShift in Shift)];
        end;
      VK_RIGHT, VK_DOWN:
        ADelta := 1;
      VK_LEFT, VK_UP:
        ADelta := -1;
      VK_HOME, VK_END:
        begin
          ADelta := DeltaMap[Key = VK_END];
          ADelta := GetCorrectedDelta(ADelta);
          if ADelta = 1 then
            Result := ViewInfo.TabsViewInfo.ViewInfoCount - 1
          else
            Result := 0;
          ADelta := -ADelta;
        end;
      VK_RETURN, VK_SPACE:
      begin
        if ViewInfo.TrackingTabVisibleIndex <> -1 then
          Result := ViewInfo.TrackingTabVisibleIndex
        else
        begin
          Result := ViewInfo.FocusedTabVisibleIndex;
          ViewInfo.FocusedTabVisibleIndex := -1;
        end;
      end;
    end;
    if ADelta <> 0 then
    begin
      if Result = -1 then
      begin
        ADelta := GetCorrectedDelta(ADelta);
        if ViewInfo.TrackingTabVisibleIndex <> -1 then
          Result := ViewInfo.TrackingTabVisibleIndex
        else
          if ViewInfo.FocusedTabVisibleIndex <> -1 then
            Result := ViewInfo.FocusedTabVisibleIndex
          else
            if ADelta = 1 then
              Result := -1
            else
              Result := ViewInfo.TabsViewInfo.ViewInfoCount;
        Result := ViewInfo.GetNextFocusedTabVisibleIndex(Result, ADelta, ACycle, Key in [VK_TAB, VK_RETURN, VK_SPACE]);
      end;
    end;
  end;

var
  ATabVisibleIndex: Integer;
begin
  Result := False;
  if Properties.HideTabs or (ViewInfo.TabsViewInfo.ViewInfoCount = 0) or
      (Shift = [ssAlt]) or (Shift = [ssAlt, ssShift]) then
    Exit;

  ATabVisibleIndex := GetNextTabVisibleIndex;

  if ATabVisibleIndex <> -1 then
  begin
    if not (ViewInfo.Painter.IsTabPressable or not Properties.ActivateFocusedTab) or (Key in [VK_TAB, VK_RETURN, VK_SPACE]) then
      TabClick(ATabVisibleIndex, [])
    else
    begin
      if not ViewInfo.Painter.IsTabPressable then
        ViewInfo.TabsViewInfo[ATabVisibleIndex].SetFocus
      else
        ViewInfo.TrackingTabVisibleIndex := ATabVisibleIndex;
    end;
    Result := True;
  end;
end;

procedure TcxCustomTabControlController.TabClick(ATabVisibleIndex: Integer; AShift: TShiftState);
begin
  if ATabVisibleIndex <> -1 then
  begin
    ViewInfo.TabsViewInfo[ATabVisibleIndex].Select(ssCtrl in AShift);
    ViewInfo.TabsViewInfo[ATabVisibleIndex].SetFocus;
    ViewInfo.TabsViewInfo[ATabVisibleIndex].Click(AShift);
  end;
end;

procedure TcxCustomTabControlController.DoTabClick(ATabVisibleIndex: Integer; AShift: TShiftState);
begin
  Properties.DoTabClick(ATabVisibleIndex, AShift);
end;

procedure TcxCustomTabControlController.TabDown(ATabVisibleIndex: Integer; AShift: TShiftState);
begin
  FMouseDownTabVisibleIndex := ATabVisibleIndex;
  ViewInfo.TabDown(ATabVisibleIndex, AShift);
end;

procedure TcxCustomTabControlController.TabUp(ATabVisibleIndex: Integer; AShift: TShiftState);
begin
  if FMouseDownTabVisibleIndex = ATabVisibleIndex then
  begin
    if ViewInfo.Painter.IsTabPressable and not IControl.IsDesigning then
      ViewInfo.TabUp(ATabVisibleIndex, AShift);
    TabClick(ATabVisibleIndex, AShift);
  end;
  FMouseDownTabVisibleIndex := -1;
end;

procedure TcxCustomTabControlController.TabCloseButtonDown(ACloseButtonInfo: TcxPCTabCloseButtonViewInfo);
begin
  if ACloseButtonInfo.State <> nbsDisabled then
    ViewInfo.PressedTabCloseButton := ACloseButtonInfo
  else
    ViewInfo.PressedTabCloseButton := nil;
end;

procedure TcxCustomTabControlController.TabCloseButtonUp(ACloseButtonInfo: TcxPCTabCloseButtonViewInfo);
begin
  if ViewInfo.PressedTabCloseButton = ACloseButtonInfo then
    Properties.DoCloseButtonClick(ACloseButtonInfo.FTabViewInfo.Index);
end;

function TcxCustomTabControlController.StartDragAndDrop(const P: TPoint): Boolean;
begin
  Result := Properties.AllowTabDragDrop and HitTest.HitAtTab and not HitTest.HitAtTabCloseButton;
  if Result then
    (IControl.GetDragAndDropObject as TcxTabControlDragAndDropObject).Init(
      TcxTabViewInfo(HitTest.HitObject).VisibleIndex, P);
end;

procedure TcxCustomTabControlController.EndDragAndDrop(Accepted: Boolean);
begin
end;

function TcxCustomTabControlController.GetDragAndDropObjectClass: TcxTabControlDragAndDropObjectClass;
begin
  Result := TcxTabControlDragAndDropObject;
end;

procedure TcxCustomTabControlController.CreateGoDialog;
begin
  if not IControl.IsDesigning then
  begin
    FGoDialog := TcxPCGoDialog.Create(IControl);
    FGoDialog.OnClick := GoDialogClickEventHandler;
  end;
end;

procedure TcxCustomTabControlController.DoShowGoDialog;
var
  P: TPoint;
begin
  P := GetClientToScreen(cxRectLeftBottom(ViewInfo.NavigatorButtonInfoByType[nbGoDialog].Bounds));
  FGoDialog.Popup(P.X, P.Y);
  HideGoDialog(-1);
end;

function TcxCustomTabControlController.GetClientToScreen(const APoint: TPoint): TPoint;
begin
  Result := APoint;
  ClientToScreen(GetControlHandle, Result);
end;

function TcxCustomTabControlController.GetMouseCursorPos: TPoint;
begin
  if GetControlHandle <> 0 then
    Result := GetScreenToClient(InternalGetCursorPos)
  else
    Result := cxInvalidPoint;
end;

function TcxCustomTabControlController.GetScreenToClient(const APoint: TPoint): TPoint;
begin
  Result := APoint;
  ScreenToClient(GetControlHandle, Result);
end;

procedure TcxCustomTabControlController.GoDialogClickEventHandler(ATabVisibleIndex: Integer);
begin
  HideGoDialog(ATabVisibleIndex);
end;

procedure TcxCustomTabControlController.HideGoDialog(ATabVisibleIndex: Integer);

  function NeedGoDialogClosed: Boolean;
  var
    AOwnerWnd: THandle;
  begin
    AOwnerWnd := GetControlHandle;
    Result := (AOwnerWnd <> 0) and (IsMessageInQueue(AOwnerWnd, WM_LBUTTONDOWN) or
      IsMessageInQueue(AOwnerWnd, WM_LBUTTONDBLCLK));
  end;

begin
  FGoDialogJustClosed := NeedGoDialogClosed;
  FIsGoDialogShowing := False;
  TabClick(ATabVisibleIndex, []);
  ViewInfo.PressedNavigatorButton := nil;
  ViewInfo.HotTrackNavigatorButton := nil;
  ViewInfo.SynchronizeHotTrackStates(InternalGetShiftState);
end;

procedure TcxCustomTabControlController.ShowGoDialog;
begin
  FIsGoDialogShowing := True;
  DoShowGoDialog;
end;

function TcxCustomTabControlController.GetControlHandle: THandle;
var
  AControl: TWinControl;
begin
  AControl := IControl.GetControl;
  if AControl.HandleAllocated then
    Result := AControl.Handle
  else
    Result := 0;
end;

procedure TcxCustomTabControlController.ArrowButtonClick(ANavigatorButton: TcxPCNavigatorButton);
var
  AButtonInfo: TcxPCNavigatorButtonViewInfo;
  AWasPressed: Boolean;
begin
  if ViewInfo.ArrowButtonClick(ANavigatorButton) then
  begin
    AWasPressed := ViewInfo.FPressedNavigatorButton <> nil;
    IControl.RequestLayout;
    if AWasPressed then
    begin
      AButtonInfo := ViewInfo.NavigatorButtonInfoByType[ANavigatorButton];
      if (AButtonInfo <> nil) and (AButtonInfo.State <> nbsDisabled) then
      begin
        ViewInfo.FHotTrackNavigatorButton := nil;
        ViewInfo.FPressedNavigatorButton := AButtonInfo;
      end;
      ViewInfo.SynchronizeHotTrackStates(InternalGetShiftState);
    end;
  end;
end;

procedure TcxCustomTabControlController.CloseButtonClick;
begin
  Properties.CloseActiveTab;
end;

procedure TcxCustomTabControlController.CreateTimer;
begin
  if FTimer = nil then
  begin
    FTimer := TcxTimer.Create(nil);
    FTimer.OnTimer := TimerEventHandler;
  end;
  FTimer.Interval := TabScrollingStartDelay;
  StartScrollTimer;
end;

function TcxCustomTabControlController.GetIControl: IcxTabControl;
begin
  Supports(Owner, IcxTabControl, Result);
end;

function TcxCustomTabControlController.GetProperties: TcxCustomTabControlProperties;
begin
  Result := IControl.Properties;
end;

function TcxCustomTabControlController.GetViewInfo: TcxCustomTabControlViewInfo;
begin
  Result := IControl.ViewInfo;
end;

function TcxCustomTabControlController.IsScrollTimerStarted: Boolean;
begin
  Result := (FTimer <> nil) and FTimer.Enabled;
end;

procedure TcxCustomTabControlController.StartScrollTimer;
begin
  if FTimer <> nil then
    FTimer.Enabled := True;
end;

procedure TcxCustomTabControlController.StopScrollTimer;
begin
  if FTimer <> nil then
    FTimer.Enabled := False;
end;

procedure TcxCustomTabControlController.TimerEventHandler(Sender: TObject);
var
  AArrowButtonInfo: TcxPCNavigatorButtonViewInfo;
begin
  FTimer.Interval := TabScrollingDelay;
  AArrowButtonInfo := ViewInfo.FPressedNavigatorButton;
  if (AArrowButtonInfo <> nil) and (AArrowButtonInfo.State = nbsPressed) then
    ArrowButtonClick(ViewInfo.FPressedNavigatorButton.ButtonType)
  else
    StopScrollTimer;
end;

{ TcxCustomTabControlProperties }

constructor TcxCustomTabControlProperties.Create(AOwner: TPersistent);
begin
  inherited;

  FOptions := cxPCDefaultOptions;
  FTabIndex := -1;
  FImageBorder := 0;
  FNavigatorPosition := npRightTop;
  FTabCaptionAlignment := taCenter;
  FActivateFocusedTab := True;

  FTabs := TcxTabs.Create(Self);

  FImages := TcxPCImageList.Create(Self);
  FImages.OnChange := ImageListChange;

  FTabSlants := TcxTabSlants.Create(Self);
  FTabSlants.OnChange := TabSlantsChangedHandler;
end;

destructor TcxCustomTabControlProperties.Destroy;
begin
  FreeAndNil(FTabSlants);
  FreeAndNil(FImages);
  FreeAndNil(FTabs);
  inherited;
end;

procedure TcxCustomTabControlProperties.Assign(Source: TPersistent);
begin
  if Source is TcxCustomTabControlProperties then
  begin
    BeginUpdate;
    try
      with Source as TcxCustomTabControlProperties do
      begin
        Self.ActivateFocusedTab := ActivateFocusedTab;
        Self.AllowTabDragDrop := AllowTabDragDrop;
        Self.HideTabs := HideTabs;
        Self.HotTrack := HotTrack;
        Self.ImageBorder := ImageBorder;
        Self.IsTabsContainer := IsTabsContainer;
        Self.MultiLine := MultiLine;
        Self.NavigatorPosition := NavigatorPosition;
        Self.NewButtonMode := NewButtonMode;
        Self.Options := Options;
        Self.OwnerDraw := OwnerDraw;
        Self.RaggedRight := RaggedRight;
        Self.Rotate := Rotate;
        Self.RotatedTabsMaxWidth := RotatedTabsMaxWidth;
        Self.ScrollOpposite := ScrollOpposite;
        Self.ShowFrame := ShowFrame;
        Self.Style := Style;
        Self.TabCaptionAlignment := TabCaptionAlignment;
        Self.TabHeight := TabHeight;
        Self.TabIndex := TabIndex;
        Self.TabPosition := TabPosition;
        Self.TabSlants := TabSlants;
        Self.TabWidth := TabWidth;
      end;
    finally
      EndUpdate;
    end;
  end
  else
    inherited;
end;

procedure TcxCustomTabControlProperties.BeginUpdate;
begin
  Inc(FUpdateLockCount);
end;

procedure TcxCustomTabControlProperties.CancelUpdate;
begin
  Dec(FUpdateLockCount);
end;

procedure TcxCustomTabControlProperties.EndUpdate;
begin
  Dec(FUpdateLockCount);
  Changed;
end;

function TcxCustomTabControlProperties.CanChange(NewTabIndex: Integer): Boolean;
begin
  Result := True;
  if Assigned(FOnChanging) and not IsUpdateLocked then
    FOnChanging(Self, Result);
end;

procedure TcxCustomTabControlProperties.DoChange;
begin
  if Assigned(FOnChange) and not IsUpdateLocked then
    FOnChange(Self);
end;

procedure TcxCustomTabControlProperties.Changed(AType: TcxCustomTabControlPropertiesChangedType = pctHard);
begin
  if not IsUpdateLocked then
    DoChanged(AType);
end;

procedure TcxCustomTabControlProperties.NewButtonClick;
begin
  DoNewButtonClick(Tabs.Add(''));
end;

procedure TcxCustomTabControlProperties.CloseActiveTab;
begin
  CloseTab(TabIndex);
end;

procedure TcxCustomTabControlProperties.CloseTab(AIndex: Integer);
begin
  if DoCanClose(AIndex) then
    DoCloseTab(AIndex)
end;

procedure TcxCustomTabControlProperties.DoChanged(AType: TcxCustomTabControlPropertiesChangedType = pctHard);
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self, AType);
end;

procedure TcxCustomTabControlProperties.DoPrepareTabCanvasFont(ATab: TcxTab; ACanvas: TcxCanvas);
begin
  if Assigned(OnPrepareTabCanvasFont) then
    OnPrepareTabCanvasFont(ATab, ACanvas);
end;

procedure TcxCustomTabControlProperties.DoClose(ATabIndex: Integer);
begin
  if Assigned(FOnClose) then
    FOnClose(Self, ATabIndex);
end;

procedure TcxCustomTabControlProperties.DoCloseButtonClick(ATabIndex: Integer);
begin
  CloseTab(ATabIndex);
end;

function TcxCustomTabControlProperties.DoCustomDraw(TabVisibleIndex: Integer): Boolean;
begin
  Result := OwnerDraw and Assigned(OnDrawTab);
  if Result then
  begin
    OnDrawTab(Self, Tabs.VisibleTabs[TabVisibleIndex], Result);
    Result := not Result;
  end;
end;

procedure TcxCustomTabControlProperties.DoStyleChanged;
begin
  if Assigned(FOnStyleChanged) then
    FOnStyleChanged(Self);
end;

procedure TcxCustomTabControlProperties.DoCloseTab(AIndex: Integer);
var
  ATab: TcxTab;
begin
  BeginUpdate;
  try
    if AIndex <> TabIndex then
      ATab := Tabs[TabIndex]
    else
      ATab := nil;
    Tabs.Delete(AIndex);
    if ATab <> nil then
      TabIndex := ATab.Index;
    DoClose(AIndex);
  finally
    EndUpdate;
  end;
  DoChange;
end;

procedure TcxCustomTabControlProperties.MoveTab(ACurrentIndex, ANewIndex: Integer);
begin
  Tabs.Move(ACurrentIndex, ANewIndex);
end;

procedure TcxCustomTabControlProperties.SetModified;
var
  AIntf: IcxTabControl;
begin
  if Supports(Owner, IcxTabControl, AIntf) then
    AIntf.SetModified;
end;

function TcxCustomTabControlProperties.DoCanClose(AIndex: Integer): Boolean;
begin
  Result := True;
  if Assigned(FOnCanClose) then
    FOnCanClose(Self, AIndex, Result);
end;

procedure TcxCustomTabControlProperties.DoDrawTabEx(ATabVisibleIndex: Integer; AFont: TFont);
begin
  if Assigned(FOnDrawTabEx) then
    FOnDrawTabEx(Self, Tabs.VisibleTabs[ATabVisibleIndex], AFont);
end;

procedure TcxCustomTabControlProperties.DoNewButtonClick(AIndex: Integer);
begin
  TabIndex := AIndex;
  if Assigned(FOnNew) then
    FOnNew(Self, AIndex);
end;

procedure TcxCustomTabControlProperties.DoTabClick(ATabVisibleIndex: Integer; AShift: TShiftState);
begin
  if Assigned(OnTabClick) then
    OnTabClick(Self, ATabVisibleIndex, AShift);
end;

function TcxCustomTabControlProperties.IsUpdateLocked: Boolean;
begin
  Result := (FUpdateLockCount > 0) or IsLoading;
end;

function TcxCustomTabControlProperties.IsDesigning: Boolean;
var
  AIntf: IcxControlComponentState;
begin
  Result := Supports(Owner, IcxControlComponentState, AIntf) and AIntf.IsDesigning;
end;

function TcxCustomTabControlProperties.IsDestroying: Boolean;
var
  AIntf: IcxControlComponentState;
begin
  Result := Supports(Owner, IcxControlComponentState, AIntf) and AIntf.IsDestroying;
end;

function TcxCustomTabControlProperties.IsLoading: Boolean;
var
  AIntf: IcxControlComponentState;
begin
  Result := Supports(Owner, IcxControlComponentState, AIntf) and AIntf.IsLoading;
end;

function TcxCustomTabControlProperties.GetViewInfo: TcxCustomTabControlViewInfo;
var
  AIntf: IcxTabControl;
begin
  if Supports(Owner, IcxTabControl, AIntf) then
    Result := AIntf.ViewInfo
  else
    Result := nil;
end;

procedure TcxCustomTabControlProperties.ImageListChange(Sender: TObject);
begin
  Changed;
end;

function TcxCustomTabControlProperties.GetImageIndex(ATab: TcxTab): Integer;
begin
  Result := ATab.FImageIndex;
  if Assigned(OnGetImageIndex) then
    OnGetImageIndex(Self, ATab.Index, Result);
  if not IsImageAssigned(Images, Result) and not IsImageAssigned(HotImages, Result) then
    Result := -1;
end;

function TcxCustomTabControlProperties.GetNavigatorButtons(AOnlyObligatoryButtons: Boolean): TcxPCNavigatorButtons;
begin
  Result := [];
  if MultiLine then
    Exit;
  if pcoCloseButton in Options then
    Include(Result, nbClose);
  if not AOnlyObligatoryButtons and not (pcoNoArrows in Options) then
    Result := Result + [nbTopLeft, nbBottomRight];
  if (pcoGoDialog in Options) and
    (not AOnlyObligatoryButtons or (pcoAlwaysShowGoDialogButton in Options)) then
      Include(Result, nbGoDialog);
end;

function TcxCustomTabControlProperties.TabIndexTabMustBeVisible: Boolean;
begin
  Result := False;
end;

procedure TcxCustomTabControlProperties.TabSlantsChangedHandler(Sender: TObject);
begin
  Changed;
end;

function TcxCustomTabControlProperties.GetNewButton: TcxPCNewButton;
begin
  Result := Tabs.NewButton;
end;

function TcxCustomTabControlProperties.GetNewButtonMode: TcxPCNewButtonMode;
const
  ResultMap: array[Boolean] of TcxPCNewButtonMode = (nbmNone, nbmTab);
begin
  Result := ResultMap[NewButton.Visible];
end;

function TcxCustomTabControlProperties.GetHotImages: TCustomImageList;
begin
  Result := FImages.BaseHotImages;
end;

function TcxCustomTabControlProperties.GetImages: TCustomImageList;
begin
  Result := FImages.BaseImages;
end;

function TcxCustomTabControlProperties.GetOptions: TcxPCOptions;
begin
  Result := FOptions;
end;

procedure TcxCustomTabControlProperties.SetActivateFocusedTab(Value: Boolean);
begin
  if FActivateFocusedTab <> Value then
  begin
    FActivateFocusedTab := Value;
    if FActivateFocusedTab then
      Changed;
  end;
end;

procedure TcxCustomTabControlProperties.SetCloseButtonMode(
  const Value: TcxPCCloseButtonMode);
begin
  if FCloseButtonMode <> Value then
  begin
    FCloseButtonMode := Value;
    Changed;
  end;
end;

procedure TcxCustomTabControlProperties.SetHideTabs(Value: Boolean);
begin
  if FHideTabs <> Value then
  begin
    FHideTabs := Value;
    Changed;
  end;
end;

procedure TcxCustomTabControlProperties.SetHotImages(Value: TCustomImageList);
begin
  FImages.BaseHotImages := Value;
end;

procedure TcxCustomTabControlProperties.SetHotTrack(Value: Boolean);
begin
  if FHotTrack <> Value then
  begin
    FHotTrack := Value;
    Changed;
  end;
end;

procedure TcxCustomTabControlProperties.SetImageBorder(Value: Integer);
begin
  if (Value >= 0) and (FImageBorder <> Value) then
  begin
    FImageBorder := Value;
    Changed;
  end;
end;

procedure TcxCustomTabControlProperties.SetImages(const Value: TCustomImageList);
begin
  FImages.BaseImages := Value;
end;

procedure TcxCustomTabControlProperties.SetIsTabsContainer(Value: Boolean);
begin
  if FIsTabsContainer <> Value then
  begin
    FIsTabsContainer := Value;
    Changed;
  end;
end;

procedure TcxCustomTabControlProperties.SetRotatedTabsMaxWidth(Value: Integer);
begin
  if Value < 0 then
    Value := 0;
  if FRotatedTabsMaxWidth <> Value then
  begin
    FRotatedTabsMaxWidth := Value;
    Changed(pctMedium);
  end;
end;

procedure TcxCustomTabControlProperties.SetMultiLine(Value: Boolean);
begin
  if MultiLine <> Value then
  begin
    FMultiLine := Value;
    Changed;
  end;
end;

procedure TcxCustomTabControlProperties.SetNavigatorPosition(const Value: TcxPCNavigatorPosition);
begin
  if FNavigatorPosition <> Value then
  begin
    FNavigatorPosition := Value;
    Changed;
  end;
end;

procedure TcxCustomTabControlProperties.SetNewButtonMode(Value: TcxPCNewButtonMode);
begin
  NewButton.Visible := Value = nbmTab;
end;

procedure TcxCustomTabControlProperties.SetOptions(Value: TcxPCOptions);
const
  GraphicOptionsMap: TcxPCOptions = [pcoGradient, pcoGradientClientArea,
    pcoUsePageColorForTab];
  LayoutOptionsMap: TcxPCOptions = [
    pcoAlwaysShowGoDialogButton, pcoCloseButton, pcoFixedTabWidthWhenRotated,
    pcoGoDialog, pcoGradient, pcoGradientClientArea, pcoNoArrows,
    pcoTopToBottomText
  ];
var
  AAddOptions, AChangedOptions, ASubOptions: TcxPCOptions;
begin
  AAddOptions := Value - FOptions;
  ASubOptions := FOptions - Value;
  AChangedOptions := AAddOptions + ASubOptions;
  if AChangedOptions <> [] then
  begin
    FOptions := Value;
    if AChangedOptions * LayoutOptionsMap <> [] then
      Changed
    else
      if AChangedOptions * GraphicOptionsMap <> [] then
        Changed(pctLight);
  end;
end;

procedure TcxCustomTabControlProperties.SetOwnerDraw(Value: Boolean);
begin
  if FOwnerDraw <> Value then
  begin
    FOwnerDraw := Value;
    Changed(pctLight);
  end;
end;

procedure TcxCustomTabControlProperties.SetRaggedRight(Value: Boolean);
begin
  if FRaggedRight <> Value then
  begin
    FRaggedRight := Value;
    if MultiLine then
      Changed;
  end;
end;

procedure TcxCustomTabControlProperties.SetRotate(Value: Boolean);
begin
  if Rotate <> Value then
  begin
    FRotate := Value;
    Changed;
  end;
end;

procedure TcxCustomTabControlProperties.SetScrollOpposite(Value: Boolean);
begin
  if FScrollOpposite <> Value then
  begin
    FScrollOpposite := Value;
    Changed;
  end;
end;

procedure TcxCustomTabControlProperties.SetShowFrame(Value: Boolean);
begin
  if FShowFrame <> Value then
  begin
    FShowFrame := Value;
    Changed;
  end;
end;

procedure TcxCustomTabControlProperties.SetStyle(
  const Value: TcxPCStyleID);
begin
  if FStyle <> Value then
  begin
    if PaintersFactory.GetPainterClass(Value) = nil then
      FStyle := cxPCDefaultStyle
    else
      FStyle := Value;
    DoStyleChanged;
  end;
end;

procedure TcxCustomTabControlProperties.SetTabCaptionAlignment(Value: TAlignment);
begin
  if FTabCaptionAlignment <> Value then
  begin
    FTabCaptionAlignment := Value;
    Changed;
  end;
end;

procedure TcxCustomTabControlProperties.SetTabHeight(Value: Smallint);
begin
  if FTabSize.Y <> Value then
  begin
    FTabSize.Y := Value;
    Changed;
  end;
end;

procedure TcxCustomTabControlProperties.SetTabIndex(Value: Integer);

  procedure UnselectTabs;
  var
    I: Integer;
  begin
    for I := 0 to Tabs.Count - 1 do
      Tabs[I].Selected := False;
  end;

begin
  if IsLoading then
  begin
    FTabIndex := Value;
    Exit;
  end;
  if (Value <> -1) and (Value < 0) or (Value >= Tabs.Count) then Exit;
  if (Value <> -1) and TabIndexTabMustBeVisible and (not Tabs[Value].Visible) then Value := -1;
  if Value = FTabIndex then Exit;
  if not CanChange(Value) then Exit;

  UnselectTabs;
  FTabIndex := Value;
  SetModified;
  Changed;
  DoChange;
end;

procedure TcxCustomTabControlProperties.SetTabs(const Value: TcxTabs);
begin
  FTabs.Assign(Value);
end;

procedure TcxCustomTabControlProperties.SetTabSlants(Value: TcxTabSlants);
begin
  FTabSlants.Assign(Value);
end;

procedure TcxCustomTabControlProperties.SetTabPosition(Value: TcxTabPosition);
begin
  if TabPosition <> Value then
  begin
    FTabPosition := Value;
    Changed;
  end;
end;

procedure TcxCustomTabControlProperties.SetTabWidth(const Value: Smallint);
begin
  if FTabSize.X <> Value then
  begin
    FTabSize.X := Value;
    Changed;
  end;
end;

{ TcxCustomTabControl }

function TcxCustomTabControl.GetPageClientRect: TRect;
begin
  Result := FPainter.GetPageClientRect;
end;

function TcxCustomTabControl.GetPageClientRectOffset: TRect;
begin
  Result := Painter.GetPageClientRectOffset;
end;

function TcxCustomTabControl.GetImages: TCustomImageList;
begin
  Result := Properties.Images;
end;

function TcxCustomTabControl.GetIsTabsContainer: Boolean;
begin
  Result := Properties.IsTabsContainer;
end;

function TcxCustomTabControl.GetMainTabIndex: Integer;
begin
  Result := ViewInfo.MainTabIndex;
end;

function TcxCustomTabControl.GetHotTrack: Boolean;
begin
  Result := Properties.HotTrack;
end;

function TcxCustomTabControl.GetImageBorder: Integer;
begin
  Result := Properties.ImageBorder;
end;

function TcxCustomTabControl.GetFirstVisibleTab: Integer;
begin
  Result := ViewInfo.FirstVisibleTab;
end;

function TcxCustomTabControl.GetHideTabs: Boolean;
begin
  Result := Properties.HideTabs;
end;

function TcxCustomTabControl.GetMaxRotatedTabWidth: Integer;
begin
  Result := Properties.RotatedTabsMaxWidth;
end;

function TcxCustomTabControl.GetOptions: TcxPCOptions;
begin
  Result := Properties.Options;
end;

function TcxCustomTabControl.GetOwnerDraw: Boolean;
begin
  Result := Properties.OwnerDraw;
end;

function TcxCustomTabControl.GetRaggedRight: Boolean;
begin
  Result := Properties.RaggedRight;
end;

function TcxCustomTabControl.GetStyle: TcxPCStyleID;
begin
  Result := Properties.Style;
end;

function TcxCustomTabControl.GetTabs: TcxTabs;
begin
  Result := Properties.Tabs;
end;

function TcxCustomTabControl.InternalGetClientRect: TRect;
begin
  if IsLoading then
    if FIsClientRectLoaded then
      Result := FClientRect
    else
      Result := GetControlRect(Self)
  else
  begin
    Result := PageClientRect;
    ValidateRect(Result);
  end;
end;

function TcxCustomTabControl.PassDesignMouseEvent(X, Y: Integer): Boolean;
begin
  Controller.HitTest.Update(InternalGetShiftState, Point(X, Y));
  Result := Controller.HitTest.HitAtNavigatorButton and
    not (TcxPCNavigatorButtonViewInfo(Controller.HitTest.HitObject).ButtonType in [nbGoDialog, nbClose]) or
    Controller.HitTest.HitAtTab and (TcxTabViewInfo(Controller.HitTest.HitObject).Index <> TabIndex);
end;

procedure TcxCustomTabControl.ReadClientRectBottom(Reader: TReader);
begin
  FClientRect.Bottom := Reader.ReadInteger;
end;

procedure TcxCustomTabControl.ReadClientRectLeft(Reader: TReader);
begin
  FClientRect.Left := Reader.ReadInteger;
end;

procedure TcxCustomTabControl.ReadClientRectRight(Reader: TReader);
begin
  FClientRect.Right := Reader.ReadInteger;
end;

procedure TcxCustomTabControl.ReadClientRectTop(Reader: TReader);
begin
  FClientRect.Top := Reader.ReadInteger;
  FIsClientRectLoaded := True;
end;

procedure TcxCustomTabControl.SetFirstVisibleTab(Value: Integer);
begin
  ViewInfo.FirstVisibleTab := Value;
end;

procedure TcxCustomTabControl.SetHideTabs(const Value: Boolean);
begin
  Properties.HideTabs := Value;
end;

procedure TcxCustomTabControl.SetHotTrack(Value: Boolean);
begin
  Properties.HotTrack := Value;
end;

procedure TcxCustomTabControl.SetImageBorder(const Value: Integer);
begin
  Properties.ImageBorder := Value;
end;

procedure TcxCustomTabControl.SetImages(const Value: TCustomImageList);
begin
  Properties.Images := Value;
end;

procedure TcxCustomTabControl.SetIsTabsContainer(Value: Boolean);
begin
  Properties.IsTabsContainer := Value;
end;

procedure TcxCustomTabControl.SetMultiLine(const Value: Boolean);
begin
  Properties.MultiLine := Value;
end;

procedure TcxCustomTabControl.SetMultiSelect(const Value: Boolean);
begin
  Properties.MultiSelect := Value;
end;

procedure TcxCustomTabControl.SetNavigatorPosition(
  const Value: TcxPCNavigatorPosition);
begin
  Properties.NavigatorPosition := Value;
end;

procedure TcxCustomTabControl.SetOptions(Value: TcxPCOptions);
begin
  Properties.Options := Value;
end;

procedure TcxCustomTabControl.SetOwnerDraw(const Value: Boolean);
begin
  Properties.OwnerDraw := Value;
end;

procedure TcxCustomTabControl.SetProperties(const Value: TcxCustomTabControlProperties);
begin
  FProperties.Assign(Value);
end;

procedure TcxCustomTabControl.SetRaggedRight(const Value: Boolean);
begin
  Properties.RaggedRight := Value;
end;

procedure TcxCustomTabControl.SetRotate(const Value: Boolean);
begin
  Properties.Rotate := Value;
end;

procedure TcxCustomTabControl.SetMaxRotatedTabWidth(Value: Integer);
begin
  Properties.RotatedTabsMaxWidth := Value;
end;

procedure TcxCustomTabControl.SetScrollOpposite(const Value: Boolean);
begin
  Properties.ScrollOpposite := Value;
end;

procedure TcxCustomTabControl.SetShowFrame(const Value: Boolean);
begin
  Properties.ShowFrame := Value;
end;

procedure TcxCustomTabControl.SetStyle(const Value: TcxPCStyleID);
begin
  Properties.Style := Value;
end;

procedure TcxCustomTabControl.SetTabCaptionAlignment(Value: TAlignment);
begin
  Properties.TabCaptionAlignment := Value;
end;

procedure TcxCustomTabControl.SetTabHeight(const Value: Smallint);
begin
  Properties.TabHeight := Value;
end;

procedure TcxCustomTabControl.SetTabIndex(Value: Integer);
begin
  Properties.TabIndex := Value;
end;

function TcxCustomTabControl.GetMultiLine: Boolean;
begin
  Result := Properties.MultiLine;
end;

function TcxCustomTabControl.GetMultiSelect: Boolean;
begin
  Result := Properties.MultiSelect;
end;

function TcxCustomTabControl.GetNavigatorPosition: TcxPCNavigatorPosition;
begin
  Result := Properties.NavigatorPosition;
end;

function TcxCustomTabControl.GetRotate: Boolean;
begin
  Result := Properties.Rotate;
end;

function TcxCustomTabControl.GetScrollOpposite: Boolean;
begin
  Result := Properties.ScrollOpposite;
end;

function TcxCustomTabControl.GetShowFrame: Boolean;
begin
  Result := Properties.ShowFrame;
end;

function TcxCustomTabControl.GetTabCaptionAlignment: TAlignment;
begin
  Result := Properties.TabCaptionAlignment;
end;

function TcxCustomTabControl.GetTabHeight: Smallint;
begin
  Result := Properties.TabHeight;
end;

function TcxCustomTabControl.GetTabIndex: Integer;
begin
  Result := Properties.TabIndex;
end;

function TcxCustomTabControl.GetTabPosition: TcxTabPosition;
begin
  Result := Properties.TabPosition;
end;

function TcxCustomTabControl.GetTabSlants: TcxTabSlants;
begin
  Result := Properties.TabSlants;
end;

function TcxCustomTabControl.GetTabWidth: Smallint;
begin
  Result := Properties.TabWidth;
end;

procedure TcxCustomTabControl.SetTabPosition(const Value: TcxTabPosition);
begin
  Properties.TabPosition := Value;
end;

procedure TcxCustomTabControl.PropertiesChangedHandler(Sender: TObject; AType: TcxCustomTabControlPropertiesChangedType);
begin
  case AType of
    pctLight:
      Invalidate;
    pctMedium:
      begin
        ViewInfo.RearrangeRows;
       // ViewInfo.SynchronizeHotTrackStates(InternalGetShiftState);
        Invalidate;
        Realign;
      end;
  else
    RequestLayout;
  end;
end;

procedure TcxCustomTabControl.SetTabs(const Value: TcxTabs);
begin
  Properties.Tabs := Value;
end;

procedure TcxCustomTabControl.SetTabSlants(Value: TcxTabSlants);
begin
  Properties.TabSlants := Value;
end;

procedure TcxCustomTabControl.SetTabWidth(const Value: Smallint);
begin
  Properties.TabWidth := Value;
end;

procedure TcxCustomTabControl.WriteClientRectBottom(Writer: TWriter);
begin
  Writer.WriteInteger(InternalGetClientRect.Bottom);
end;

procedure TcxCustomTabControl.WriteClientRectLeft(Writer: TWriter);
begin
  Writer.WriteInteger(InternalGetClientRect.Left);
end;

procedure TcxCustomTabControl.WriteClientRectRight(Writer: TWriter);
begin
  Writer.WriteInteger(InternalGetClientRect.Right);
end;

procedure TcxCustomTabControl.WriteClientRectTop(Writer: TWriter);
begin
  Writer.WriteInteger(InternalGetClientRect.Top);
end;

procedure TcxCustomTabControl.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if TMessage(Message).wParam = TMessage(Message).lParam then
    EraseBackground(Message.DC)
  else
    inherited;
end;

procedure TcxCustomTabControl.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  Message.Result := Message.Result or DLGC_WANTARROWS;
end;

procedure TcxCustomTabControl.WMPrintClient(var Message: TWMPrintClient);
begin
{$IFDEF DELPHI7}
  inherited
{$ELSE}
  if (Message.Result <> 1) and
    ((Message.Flags and PRF_CHECKVISIBLE = 0) or Visible) then
      PaintHandler(TWMPaint(Message))
  else
    inherited
{$ENDIF}
end;

procedure TcxCustomTabControl.CMDesignHitTest(
  var Message: TCMDesignHitTest);
begin
  inherited;
  with Message do
    if PassDesignMouseEvent(XPos, YPos) then Result := 1;
end;

procedure TcxCustomTabControl.CMDialogChar(var Message: TCMDialogChar);
begin
  if HandleDialogChar(Message.CharCode) then
    Message.Result := 1
  else
    inherited;
end;

procedure TcxCustomTabControl.CMDialogKey(var Message: TCMDialogKey);
begin
  if Focused or HandleAllocated and Windows.IsChild(Handle, Windows.GetFocus) then
  begin
    if Controller.KeyDown(Message.CharCode, KeyDataToShiftState(Message.KeyData)) then
    begin
      Message.Result := 1;
      Exit;
    end;
  end;
  inherited;
end;

procedure TcxCustomTabControl.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TcxCustomTabControl.CMParentColorChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

constructor TcxCustomTabControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csDoubleClicks, csOpaque{$IFDEF DELPHI7}, csParentBackground{$ENDIF}];
  Width := 289;
  Height := 193;

  FProperties := GetPropertiesClass.Create(Self);
  FProperties.OnChanged := PropertiesChangedHandler;
  FProperties.OnStyleChanged := StyleChanged;

  FProperties.OnNew := PropertiesNewHandler;
  FProperties.OnCanClose := PropertiesCanCloseHandler;
  FProperties.OnChange := PropertiesChangeHandler;
  FProperties.OnChanging := PropertiesChangingHandler;
  FProperties.OnDrawTab := PropertiesDrawTabHandler;
  FProperties.OnDrawTabEx := PropertiesDrawTabExHandler;
  FProperties.OnGetImageIndex := PropertiesGetImageIndexHandler;
  FProperties.OnTabClick := TabClick;
  FProperties.OnPrepareTabCanvasFont := PrepareTabCanvasFont;

  FController := GetControllerClass.Create(Self);
  FFocusable := True;
  TabStop := True;
  FViewInfo := GetViewInfoClass.Create(Self);
  FViewInfo.OnAfterPaintTab := AfterPaintTab;
  RecreatePainter;
end;

destructor TcxCustomTabControl.Destroy;
begin
  cxControls.EndMouseTracking(Self as IcxMouseTrackingCaller2);
  FreeAndNil(FPainter);
  FreeAndNil(FViewInfo);
  FreeAndNil(FController);
  FreeAndNil(FProperties);
  inherited Destroy;
end;

function TcxCustomTabControl.CanFocus: Boolean;
begin
  Result := inherited CanFocus and FFocusable;
end;

function TcxCustomTabControl.GetOptimalSize: Integer;
begin
  Result := ViewInfo.GetOptimalSize;
end;

procedure TcxCustomTabControl.GetTabOrderList(List: TList);
begin
  inherited GetTabOrderList(List);
  if not FFocusable then
    List.Remove(Self);
end;

function TcxCustomTabControl.IndexOfTabAt(X, Y: Integer): Integer;
begin
  Result := ViewInfo.IndexOfTabAt(X, Y);
end;

function TcxCustomTabControl.VisibleIndexOfTabAt(X, Y: Integer): Integer;
begin
  Result := ViewInfo.VisibleIndexOfTabAt(X, Y);
end;

procedure TcxCustomTabControl.ScrollTabs(ADelta: Integer);
begin
  Controller.ScrollTabs(ADelta);
end;

procedure TcxCustomTabControl.SetStandardStyle(StandardStyle: TcxPCStandardStyle);
const
  StandardStyleNameMap: array[TcxPCStandardStyle] of string = (
    'tsTabs', 'tsButtons', 'tsFlatButtons');
var
  NewPainterClass: TcxPCPainterClass;
begin
  NewPainterClass := PaintersFactory.GetPainterClass(StandardStyle);
  if NewPainterClass = nil then
    OutError('SetStandardStyle', Format(scxPCStandardStyleError, [StandardStyleNameMap[StandardStyle]]))
  else
    Style := NewPainterClass.GetStyleID;
end;

procedure TcxCustomTabControl.SetStyleByStyleName(StyleName: TCaption);
var
  NewPainterClass: TcxPCPainterClass;
begin
  if StyleName = cxPCDefaultStyleName then
    Style := cxPCDefaultStyle
  else
  begin
    NewPainterClass := PaintersFactory.GetPainterClass(StyleName);
    if NewPainterClass = nil then
      OutError('SetStyleByName', Format(scxPCStyleNameError, [StyleName]))
    else
      Style := NewPainterClass.GetStyleID;
  end;
end;

procedure TcxCustomTabControl.AdjustClientRect(var Rect: TRect);
begin
  Rect := InternalGetClientRect;
end;

function TcxCustomTabControl.CanFocusOnClick(X, Y: Integer): Boolean;
begin
  Result := inherited CanFocusOnClick(X, Y) and ViewInfo.CanFocusOnClick(X, Y);
end;

procedure TcxCustomTabControl.ChangeScale(M, D: Integer);
begin
  FClientRect.Left := MulDiv(FClientRect.Left, M, D);
  FClientRect.Top := MulDiv(FClientRect.Top, M, D);
  FClientRect.Right := MulDiv(FClientRect.Right, M, D);
  FClientRect.Bottom := MulDiv(FClientRect.Bottom, M, D);
  inherited;
end;

function TcxCustomTabControl.CreateDragAndDropObject: TcxDragAndDropObject;
begin
  Result := Controller.GetDragAndDropObjectClass.Create(Self);
end;

procedure TcxCustomTabControl.DefineProperties(Filer: TFiler);

  function IsClientRectBottomStored: Boolean;
  begin
    if Assigned(Filer.Ancestor) then
      Result := InternalGetClientRect.Bottom <>
        TcxCustomTabControl(Filer.Ancestor).InternalGetClientRect.Bottom
    else
      Result := InternalGetClientRect.Bottom <> 0;
  end;

  function IsClientRectLeftStored: Boolean;
  begin
    if Assigned(Filer.Ancestor) then
      Result := InternalGetClientRect.Left <>
        TcxCustomTabControl(Filer.Ancestor).InternalGetClientRect.Left
    else
      Result := InternalGetClientRect.Left <> 0;
  end;

  function IsClientRectRightStored: Boolean;
  begin
    if Assigned(Filer.Ancestor) then
      Result := InternalGetClientRect.Right <>
        TcxCustomTabControl(Filer.Ancestor).InternalGetClientRect.Right
    else
      Result := True;
  end;

  function IsClientRectTopStored: Boolean;
  begin
    if Assigned(Filer.Ancestor) then
      Result := InternalGetClientRect.Top <>
        TcxCustomTabControl(Filer.Ancestor).InternalGetClientRect.Top
    else
      Result := True;
  end;

begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('ClientRectBottom', ReadClientRectBottom,
    WriteClientRectBottom, IsClientRectBottomStored);
  Filer.DefineProperty('ClientRectLeft', ReadClientRectLeft,
    WriteClientRectLeft, IsClientRectLeftStored);
  Filer.DefineProperty('ClientRectRight', ReadClientRectRight,
    WriteClientRectRight, IsClientRectRightStored);
  Filer.DefineProperty('ClientRectTop', ReadClientRectTop,
    WriteClientRectTop, IsClientRectTopStored);
end;

function TcxCustomTabControl.DoMouseWheelDown(Shift: TShiftState;
   MousePos: TPoint): Boolean;
begin
  Result := Controller.DoMouseWheelDown(Shift, ScreenToClient(MousePos));
end;

function TcxCustomTabControl.DoMouseWheelUp(Shift: TShiftState;
   MousePos: TPoint): Boolean;
begin
  Result := Controller.DoMouseWheelUp(Shift, ScreenToClient(MousePos));
end;

procedure TcxCustomTabControl.AfterPaintTab(ACanvas: TcxCanvas; ATab: TcxTab;
  AImageAndTextData: TcxPCOutTabImageAndTextData);
begin
end;

procedure TcxCustomTabControl.Change;
begin
  if not IsChangeEventLocked then
    CallNotify(FOnChange, Self);
end;

procedure TcxCustomTabControl.EraseBackground(DC: HDC);
begin
  Canvas.SaveDC;
  try
    Canvas.Canvas.Handle := DC;
    Painter.FillTabPaneContent(Canvas);
  finally
    Canvas.RestoreDC;
  end;
end;

procedure TcxCustomTabControl.FocusChanged;
begin
  inherited FocusChanged;
  Controller.FocusChanged;
end;

procedure TcxCustomTabControl.FontChanged;
begin
  inherited FontChanged;
  RequestLayout;
end;

function TcxCustomTabControl.HandleDialogChar(Key: Integer): Boolean;
begin
  Result := inherited CanFocus and Controller.HandleDialogChar(Key);
end;

function TcxCustomTabControl.HasBackground: Boolean;
begin
  Result := False;
end;

procedure TcxCustomTabControl.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  Controller.KeyDown(Key, Shift);
end;

procedure TcxCustomTabControl.Loaded;
var
  AOldTabIndex: Integer;
begin
  inherited Loaded;
  Tabs.Changed;
  if TabIndex <> -1 then
  begin
    AOldTabIndex := TabIndex;
    Properties.FTabIndex := -1;
    LockChangeEvent(True);
    try
      TabIndex := AOldTabIndex;
    finally
      LockChangeEvent(False);
    end;
  end;
end;

procedure TcxCustomTabControl.LookAndFeelChanged(Sender: TcxLookAndFeel;
  AChangedValues: TcxLookAndFeelValues);
begin
  inherited LookAndFeelChanged(Sender, AChangedValues);
  RecreatePainter;
  RequestLayout;
  if lfvNativeStyle in AChangedValues then
    InvalidateWithChildren;
end;

procedure TcxCustomTabControl.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  Controller.MouseDown(Button, Shift, X, Y);
end;

procedure TcxCustomTabControl.MouseEnter(AControl: TControl);
begin
  inherited MouseEnter(AControl);
  cxControls.BeginMouseTracking(Self, Bounds, Self as IcxMouseTrackingCaller2);
end;

procedure TcxCustomTabControl.MouseLeave(AControl: TControl);
begin
  cxControls.EndMouseTracking(Self as IcxMouseTrackingCaller2);
  inherited MouseLeave(AControl);
  Controller.MouseLeave;
end;

procedure TcxCustomTabControl.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  Controller.MouseMove(Shift, X, Y);
  cxControls.BeginMouseTracking(Self, Bounds, Self as IcxMouseTrackingCaller2);
end;

procedure TcxCustomTabControl.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  Controller.MouseUp(Button, Shift, X, Y);
end;

procedure TcxCustomTabControl.TabClick(Sender: TObject; ATabVisibleIndex: Integer; AShift: TShiftState);
begin
// do nothing
end;

procedure TcxCustomTabControl.PropertiesCanCloseHandler(Sender: TObject;
   AIndex: Integer; var ACanClose: Boolean);
begin
  if Assigned(FOnCanCloseEx) then
    FOnCanCloseEx(Self, AIndex, ACanClose)
  else
    if (AIndex = TabIndex) and Assigned(FOnCanClose) then
      FOnCanClose(Self, ACanClose);
end;

procedure TcxCustomTabControl.PropertiesChangeHandler(Sender: TObject);
begin
  Change;
end;

procedure TcxCustomTabControl.PropertiesChangingHandler(Sender: TObject;
  var AllowChange: Boolean);
begin
  if Assigned(FOnChanging) and not IsChangeEventLocked then
    FOnChanging(Self, AllowChange);
end;

procedure TcxCustomTabControl.PropertiesDrawTabExHandler(
  AControl: TcxCustomTabControlProperties; ATab: TcxTab; Font: TFont);
begin
  if Assigned(FOnDrawTabEx) then
    FOnDrawTabEx(Self, ATab, Font);
end;

procedure TcxCustomTabControl.PropertiesDrawTabHandler(
  AControl: TcxCustomTabControlProperties; ATab: TcxTab;
  var DefaultDraw: Boolean);
begin
  if Assigned(FOnDrawTab) then
    FOnDrawTab(Self, ATab, DefaultDraw);
end;

procedure TcxCustomTabControl.PropertiesGetImageIndexHandler(
  Sender: TObject; TabIndex: Integer; var ImageIndex: Integer);
begin
  if Assigned(FOnGetImageIndex) then
    FOnGetImageIndex(Self, TabIndex, ImageIndex);
end;

procedure TcxCustomTabControl.PropertiesNewHandler(Sender: TObject; AIndex: Integer);
begin
  if Assigned(FOnNew) then
    FOnNew(Self, AIndex);
end;

function TcxCustomTabControl.NeedsScrollBars: Boolean;
begin
  Result := False;
end;

function TcxCustomTabControl.NeedRedrawOnResize: Boolean;
begin
  Result := (pcoRedrawOnResize in Options) and
    (Painter.NeedRedrawOnResize or cxIsVCLThemesEnabled);
end;

procedure TcxCustomTabControl.Paint;
begin
  if IsDestroying then
    Exit;
  Canvas.SaveClipRegion;
  try
    FPainter.Paint(Canvas);
  finally
    Canvas.RestoreClipRegion;
  end;
end;

procedure TcxCustomTabControl.Resize;
begin
  RequestLayout;
  Realign;
  inherited Resize;
end;

procedure TcxCustomTabControl.DrawTab(TabIndex: Integer; const Rect: TRect;
  Active: Boolean);
begin
end;

function TcxCustomTabControl.GetControllerClass: TcxCustomTabControlControllerClass;
begin
  Result := TcxCustomTabControlController;
end;

function TcxCustomTabControl.GetMouseCursorPos: TPoint;
begin
  if HandleAllocated then
    Result := ScreenToClient(InternalGetCursorPos)
  else
    Result := cxInvalidPoint;
end;

function TcxCustomTabControl.GetPainterClass: TcxPCPainterClass;
begin
  Result := ViewInfo.GetPainterClass;
end;

function TcxCustomTabControl.GetPropertiesClass: TcxCustomTabControlPropertiesClass;
begin
  Result := TcxCustomTabControlProperties;
end;

function TcxCustomTabControl.GetViewInfoClass: TcxCustomTabControlViewInfoClass;
begin
  Result := TcxCustomTabControlViewInfo;
end;

class procedure TcxCustomTabControl.OutError(SourceMethodName: TCaption; Msg: TCaption);
begin
  raise EdxException.Create('TcxCustomTabControl.' + SourceMethodName + ': ' + Msg);
end;

procedure TcxCustomTabControl.PrepareTabCanvasFont(ATab: TcxTab; ACanvas: TcxCanvas);
begin
// do nothing
end;

procedure TcxCustomTabControl.RecreatePainter;
var
  ANewPainterClass: TcxPCPainterClass;
begin
  ANewPainterClass := GetPainterClass;
  if (FPainter = nil) or (ANewPainterClass <> FPainter.ClassType) then
  begin
    FreeAndNil(FPainter);
    if ANewPainterClass = nil then
    begin
      FPainter := nil;
      OutError('GetPainterInstance', scxPCPainterClassError);
    end
    else
      FPainter := ANewPainterClass.Create(FViewInfo);
    DoubleBuffered := FPainter.NeedDoubleBuffer;
    RequestLayout;
    InvalidateWithChildren;
  end;
end;

procedure TcxCustomTabControl.RequestLayout;
begin
  if IsLoading or IsDestroying then Exit;
  ViewInfo.Calculate;
  Realign;
  Invalidate;
end;

procedure TcxCustomTabControl.SetModified;
begin
  if not IsLoading then
    Modified;
end;

procedure TcxCustomTabControl.StyleChanged(Sender: TObject);
begin
  RecreatePainter;
end;

procedure TcxCustomTabControl.UpdateTabImages;
var
  I: Integer;
begin
  for I := 0 to Tabs.Count - 1 do
    Tabs[I].ImageIndex := Properties.GetImageIndex(Tabs[I]);
  Invalidate;
end;

function TcxCustomTabControl.InternalKeyDown(Key: Word; Shift: TShiftState): Boolean;
begin
  Result := Controller.KeyDown(Key, Shift);
end;

function TcxCustomTabControl.IsChangeEventLocked: Boolean;
begin
  Result := FChangeEventLockCount > 0;
end;

procedure TcxCustomTabControl.LockChangeEvent(ALock: Boolean);
begin
  if ALock then
    Inc(FChangeEventLockCount)
  else
    Dec(FChangeEventLockCount);
end;

function TcxCustomTabControl.AllowAutoDragAndDropAtDesignTime(X, Y: Integer; Shift: TShiftState): Boolean;
begin
  Result := False;
end;

function TcxCustomTabControl.AllowDragAndDropWithoutFocus: Boolean;
begin
  Result := True;
end;

procedure TcxCustomTabControl.EndDragAndDrop(Accepted: Boolean);
begin
  Controller.EndDragAndDrop(Accepted);
  inherited EndDragAndDrop(Accepted);
end;

function TcxCustomTabControl.StartDragAndDrop(const P: TPoint): Boolean;
begin
  Result := Controller.StartDragAndDrop(P);
end;

function TcxCustomTabControl.IsLoading: Boolean;
begin
  Result := inherited IsLoading;
end;

function TcxCustomTabControl.IsParentBackground: Boolean;
begin
  Result := ParentBackground;
end;

function TcxCustomTabControl.PtInCaller(const P: TPoint): Boolean;
begin
  Result := WindowFromPoint(GetMouseCursorPos) = Handle;
end;

procedure TcxCustomTabControl.MouseTrackingCallerMouseLeave;
begin
  MouseLeave(nil);
end;

function TcxCustomTabControl.IsEnabled: Boolean;
begin
  Result := Enabled;
end;

function TcxCustomTabControl.IsDesigning: Boolean;
begin
  Result := inherited IsDesigning;
end;

function TcxCustomTabControl.IsDestroying: Boolean;
begin
  Result := inherited IsDestroying;
end;

function TcxCustomTabControl.IsFocused: Boolean;
begin
  Result := Focused;
end;

function TcxCustomTabControl.CanDrawParentBackground: Boolean;
begin
  Result := True;
end;

function TcxCustomTabControl.GetCanvas: TcxCanvas;
begin
  Result := ActiveCanvas;
end;

function TcxCustomTabControl.GetBoundsRect: TRect;
begin
  Result := BoundsRect;
end;

function TcxCustomTabControl.GetControl: TWinControl;
begin
  Result := Self;
end;

function TcxCustomTabControl.GetController: TcxCustomTabControlController;
begin
  Result := Controller;
end;

function TcxCustomTabControl.GetDragAndDropObject: TcxDragAndDropObject;
begin
  Result := DragAndDropObject;
end;

function TcxCustomTabControl.GetDragAndDropState: TcxDragAndDropState;
begin
  Result := DragAndDropState;
end;

function TcxCustomTabControl.GetColor: TColor;
begin
  Result := Color;
end;

function TcxCustomTabControl.GetFont: TFont;
begin
  Result := Font;
end;

function TcxCustomTabControl.GetLookAndFeel: TcxLookAndFeel;
begin
  Result := LookAndFeel;
end;

function TcxCustomTabControl.GetPainter: TcxPCCustomPainter;
begin
  Result := Painter;
end;

function TcxCustomTabControl.GetProperties: TcxCustomTabControlProperties;
begin
  Result := Properties;
end;

function TcxCustomTabControl.GetViewInfo: TcxCustomTabControlViewInfo;
begin
  Result := ViewInfo;
end;

procedure TcxCustomTabControl.CreateHandle;
begin
  inherited CreateHandle;
  RequestLayout;
  Realign;
end;

procedure TcxCustomTabControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params.WindowClass do
    style := style and not(CS_HREDRAW or CS_VREDRAW);
end;

{ TcxPageControlProperties }

constructor TcxPageControlProperties.Create(AOwner: TPersistent);
begin
  inherited;
  FPages := TList.Create;
end;

destructor TcxPageControlProperties.Destroy;
var
  I: Integer;
begin
  for I := 0 to PageCount - 1 do
    with Pages[I] do
    begin
      FPageControl := nil;
      FTab := nil;
    end;
  FreeAndNil(FPages);
  inherited;
end;

procedure TcxPageControlProperties.Assign(Source: TPersistent);
begin
  BeginUpdate;
  try
    if Source is TcxPageControlProperties then
    begin
      with Source as TcxPageControlProperties do
      begin
        Self.ActivePage := ActivePage;
        Self.OnPageChanging := OnPageChanging;
      end;
    end;
    inherited Assign(Source);
  finally
    EndUpdate;
  end;
end;

function TcxPageControlProperties.FindNextPage(ACurrentPage: TcxTabSheet; AGoForward, ACheckTabAccessibility, ACircular: Boolean): TcxTabSheet;

  function GetDefaultStartPageIndex: Integer;
  begin
    if AGoForward then
      Result := 0
    else
      Result := PageCount - 1;
  end;

  function IncrementIndex(var APageIndex: Integer): Boolean;
  const
    AStep: array [Boolean] of Integer = (-1, 1);
  begin
    Result := True;
    Inc(APageIndex, AStep[AGoForward]);
    if (APageIndex < 0) or (PageCount - 1 < APageIndex) then
      if ACircular then
        APageIndex := GetDefaultStartPageIndex
      else
        Result := False;
  end;

  function InternalGetNextPage(APagesCount: Integer; APageIndex: Integer): TcxTabSheet;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to APagesCount - 1 do
    begin
      if not ACheckTabAccessibility or Pages[APageIndex].TabVisible then
      begin
        Result := Pages[APageIndex];
        Break;
      end
      else
        if not IncrementIndex(APageIndex) then
          Break;
    end;
  end;

var
  APageIndex: Integer;
begin
  Result := nil;
  if PageCount <> 0 then
  begin
    APageIndex := FPages.IndexOf(ACurrentPage);
    if APageIndex = -1 then
      Result := InternalGetNextPage(PageCount, GetDefaultStartPageIndex)
    else
      if IncrementIndex(APageIndex) then
        Result := InternalGetNextPage(PageCount - 1, APageIndex);
  end;
end;

function TcxPageControlProperties.CanChange(NewTabIndex: Integer): Boolean;
begin
  Result := inherited CanChange(NewTabIndex);
  if Result and (NewTabIndex <> -1) then
    Result := CanChangeActivePage(Pages[NewTabIndex]);
end;

procedure TcxPageControlProperties.DoChange;
begin
  BeginUpdate;
  try
    UpdateActivePage;
  finally
    CancelUpdate;
  end;
  inherited;
end;

function TcxPageControlProperties.GetActivePage: TcxTabSheet;
begin
  Result := FActivePage;
end;

function TcxPageControlProperties.GetPage(ATabIndex: Integer): TcxTabSheet;
begin
  Result := TcxTabSheet(FPages[ATabIndex]);
end;

procedure TcxPageControlProperties.DoPageChange;
begin
  inherited DoChange;
end;

procedure TcxPageControlProperties.ImageListChange(Sender: TObject);
var
  I: Integer;
begin
  if FPageInserting or IsDestroying then
    Exit;

  for I := 0 to PageCount - 1 do
    Pages[I].FTab.ImageIndex := Pages[I].ImageIndex;
  inherited ImageListChange(Sender);
end;

procedure TcxPageControlProperties.NewButtonClick;
var
  APage: TcxTabSheet;
begin
  APage := TcxTabSheet.Create(nil);
  APage.PageControl := Control;
  APage.ImageIndex := APage.TabIndex;
  DoNewButtonClick(APage.TabIndex);
end;

procedure TcxPageControlProperties.DoCloseTab(AIndex: Integer);
begin
  Pages[AIndex].Free;
end;

function TcxPageControlProperties.TabIndexTabMustBeVisible: Boolean;
begin
  Result := True;
end;

procedure TcxPageControlProperties.MoveTab(ACurrentIntex, ANewIndex: Integer);
begin
  Pages[ACurrentIntex].PageIndex := ANewIndex;
end;

procedure TcxPageControlProperties.InsertPage(APage: TcxTabSheet);
var
  PageIndex: Integer;
begin
  if CanAllocateHandle(Control) then
    Control.HandleNeeded;
  FPageInserting := True;
  try
    PageIndex := FPages.Add(APage);
    APage.SetParentPageControl(Control);
    Tabs.Add(APage.Caption);
  finally
    FPageInserting := False;
  end;
  APage.FTab := Tabs[PageIndex];
  UpdateTab(APage);
end;

procedure TcxPageControlProperties.RemovePage(APage: TcxTabSheet);

  function InternalFindNextPage(ACurrentPage: TcxTabSheet; AGoForward,
    ACheckTabAccessibility: Boolean): TcxTabSheet;
  begin
    Result := FindNextPage(ACurrentPage, AGoForward, ACheckTabAccessibility, False);
    if Result = nil then
      Result := FindNextPage(ACurrentPage, not AGoForward, ACheckTabAccessibility, False);
  end;

var
  ANextPage: TcxTabSheet;
begin
  if APage = ActivePage then
  begin
    ANextPage := InternalFindNextPage(APage, True, not Control.IsDesigning);
    if ANextPage = APage then
      ANextPage := nil;
  end
  else
    ANextPage := ActivePage;

  Tabs.Delete(FPages.Remove(APage));
  APage.FTab := nil;
  FTabIndex := -1;
  ActivePage := ANextPage;
  APage.SetParentPageControl(nil);
end;

procedure TcxPageControlProperties.UpdateActivePage;
begin
  if TabIndex = -1 then
    ActivePage := nil
  else
    ActivePage := Pages[TabIndex];
end;

procedure TcxPageControlProperties.UpdateTab(APage: TcxTabSheet);
begin
  if Control.IsLoading then
    Exit;
  with APage.FTab do
  begin
    Caption := APage.Caption;
    Enabled := APage.Enabled;
    ImageIndex := APage.ImageIndex;
    Highlighted := APage.Highlighted;
    Visible := APage.TabVisible;
  end;
  if FActivePage = APage then
    if APage.TabVisible then
      TabIndex := APage.FTab.Index
    else
      TabIndex := -1;
end;

procedure TcxPageControlProperties.UpdateTabs;
var
  I: Integer;
begin
  for I := 0 to PageCount - 1 do
    UpdateTab(Pages[I]);
end;

function TcxPageControlProperties.CanChangeActivePage(ANewPage: TcxTabSheet): Boolean;
begin
  Result := True;
  DoPageChanging(ANewPage, Result);
end;

procedure TcxPageControlProperties.DoPageChanging(NewPage: TcxTabSheet; var AllowChange: Boolean);
begin
  if Assigned(FOnPageChanging) and not IsUpdateLocked then
    FOnPageChanging(Self, NewPage, AllowChange);
end;

procedure TcxPageControlProperties.ChangeActivePage(APage: TcxTabSheet);
var
  ANewActiveControl: TWinControl;
  AParentForm: TCustomForm;
begin
  if FActivePage <> APage then
  begin
    if not CanChangeActivePage(APage) then
      Exit;

    AParentForm := GetParentForm(Control);
    if (AParentForm <> nil) and (FActivePage <> nil) and
      FActivePage.ContainsControl(AParentForm.ActiveControl) then
    begin
      AParentForm.ActiveControl := FActivePage;
      if AParentForm.ActiveControl <> FActivePage then
      begin
        TabIndex := FActivePage.FTab.Index;
        Exit;
      end;
    end;

    ANewActiveControl := nil;
    if (APage <> nil) and (AParentForm <> nil) and (FActivePage <> nil) and
      (AParentForm.ActiveControl = FActivePage) then
    begin
      if Control.Visible and Control.Enabled and Control.Parent.CanFocus and APage.Enabled then
        ANewActiveControl := APage
      else
        ANewActiveControl := Control;
    end;
    if FActivePage <> nil then
      FActivePage.Visible := False;
    if APage <> nil then
    begin
      APage.BringToFront;
      APage.Visible := True;
      APage.Invalidate;
    end;
    if ANewActiveControl <> nil then
      AParentForm.ActiveControl := ANewActiveControl;
    FActivePage := APage;
    DoPageChange;
    if (AParentForm <> nil) and (FActivePage <> nil) and
    (AParentForm.ActiveControl = FActivePage) then
       FActivePage.SelectFirst;

    Control.SetModified;
  end;
end;

procedure TcxPageControlProperties.UpdateTabOrders;
var
  I: Integer;
begin
  if not IsDestroying then
  begin
    for I := 0 to PageCount - 1 do
      Pages[I].TabOrder := I;
  end;
end;

function TcxPageControlProperties.GetControl: TcxPageControl;
begin
  Result := GetOwner as TcxPageControl;
end;

function TcxPageControlProperties.GetPageCount: Integer;
begin
  Result := FPages.Count;
end;

procedure TcxPageControlProperties.SetActivePage(APage: TcxTabSheet);
begin
  if FActivePageSetting or Control.IsDestroying or (APage <> nil) and (APage.PageControl <> Control) then
    Exit;
  ChangeActivePage(APage);
  if ActivePage = APage then
  begin
    BeginUpdate;
    FActivePageSetting := True;
    try
      if (APage <> nil) and APage.TabVisible then
        TabIndex := APage.FTab.Index
      else
        TabIndex := -1;
    finally
      FActivePageSetting := False;
      EndUpdate;
    end;
  end;
end;

{ TcxPageControlViewInfo }

function TcxPageControlViewInfo.GetActivePageColor: TColor;
begin
  Result := ActivePage.Color;
end;

function TcxPageControlViewInfo.GetTabColor(ATabVisibleIndex: Integer): TColor;
var
  ATabSheet: TcxTabSheet;
begin
  Result := inherited GetTabColor(ATabVisibleIndex);
  if TabsViewInfo[ATabVisibleIndex].IsNewButton then
    Exit;
  ATabSheet := Properties.Pages[TabsViewInfo[ATabVisibleIndex].Index];
  if (Result = clDefault) and (ATabSheet <> nil) and
    ((pcoUsePageColorForTab in Properties.Options) or Painter.AlwaysColoredTabs) and
    not ATabSheet.ParentColor then
      Result := ATabSheet.Color;
end;

function TcxPageControlViewInfo.HasActivePage: Boolean;
begin
  Result := ActivePage <> nil;
end;

function TcxPageControlViewInfo.UseActivePageColor: Boolean;
begin
  Result := HasActivePage and not ActivePage.ParentColor;
end;

function TcxPageControlViewInfo.GetActivePage: TcxTabSheet;
begin
  Result := Properties.ActivePage;
end;

function TcxPageControlViewInfo.GetProperties: TcxPageControlProperties;
begin
  Result := TcxPageControlProperties(inherited GetProperties);
end;

{ TcxPageControl }

constructor TcxPageControl.Create(AOwner: TComponent);
begin
  inherited;
  Properties.OnPageChanging := PropertiesPageChangingHandler;
end;

function TcxPageControl.FindNextPage(ACurrentPage: TcxTabSheet; AGoForward,
  ACheckTabAccessibility: Boolean): TcxTabSheet;
begin
  Result := FindNextPageEx(ACurrentPage, AGoForward, ACheckTabAccessibility, True);
end;

function TcxPageControl.FindNextPageEx(ACurrentPage: TcxTabSheet;
  AGoForward, ACheckTabAccessibility, ACircular: Boolean): TcxTabSheet;
begin
  Result := Properties.FindNextPage(ACurrentPage, AGoForward, ACheckTabAccessibility, ACircular);
end;

procedure TcxPageControl.DockDrop(Source: TDragDockObject; X, Y: Integer);
begin
  if (DockClient(Source, Point(X, Y)) >= 0) and Assigned(OnDockDrop) then
    OnDockDrop(Self, Source, X, Y);
end;

procedure TcxPageControl.SelectNextPage(GoForward: Boolean; CheckTabVisible: Boolean = True);
var
  Page: TcxTabSheet;
begin
  Page := FindNextPage(ActivePage, GoForward, CheckTabVisible);
  if (Page <> nil) and (Page <> ActivePage) then
    ActivePage := Page;
end;

procedure TcxPageControl.AlignControls(AControl: TControl; var Rect: TRect);
var
  ARgn: TcxRegion;
begin
  inherited AlignControls(AControl, Rect);
  if (ActivePage <> nil) and ActivePage.HandleAllocated and
    (ActivePage.BorderWidth > 0) and Painter.IsNativePainting then
  begin
    ARgn := TcxRegion.Create(GetControlRect(ActivePage));
    try
      SendMessage(ActivePage.Handle, WM_NCPAINT, ARgn.Handle, 0);
    finally
      ARgn.Free;
    end;
  end;
end;

procedure TcxPageControl.DoAddDockClient(Client: TControl;
  const ARect: TRect);
begin
  if FNewDockSheet <> nil then Client.Parent := FNewDockSheet;
end;

function TcxPageControl.DockClient(DockSource: TDragDockObject;
  MousePos: TPoint): Integer;

  function CheckDockingControl: Boolean;
  var
    I: Integer;
  begin
    Result := True;
    for I := 0 to PageCount - 1 do
      if DockSource.Control.Parent = Pages[I] then
      begin
        Pages[I].PageIndex := PageCount - 1;
        Result := False;
        Break;
      end;
  end;

var
  ADockingControl: TControl;
begin
  Result := 0;
  if not CheckDockingControl then
    Exit;
  FNewDockSheet := TcxTabSheet.Create(Self);
  try
    try
      ADockingControl := DockSource.Control;
      if ADockingControl is TCustomForm then
        FNewDockSheet.Caption := TCustomForm(ADockingControl).Caption;
      FNewDockSheet.PageControl := Self;
      ADockingControl.Dock(Self, DockSource.DockRect);
    except
      FNewDockSheet.Free;
      raise;
    end;
    FNewDockSheet.TabVisible := ADockingControl.Visible;
    if ADockingControl.Visible then
      ActivePage := FNewDockSheet;
    ADockingControl.Align := alClient;
  finally
    FNewDockSheet := nil;
  end;
end;

procedure TcxPageControl.DockOver(Source: TDragDockObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  R: TRect;
begin
  R := cxGetWindowRect(Self);
  Source.DockRect := R;
  DoDockOver(Source, X, Y, State, Accept);
end;

procedure TcxPageControl.DoRemoveDockClient(Client: TControl);
begin
  if (FUndockingPage <> nil) and not IsDestroying then
  begin
    SelectNextPage(True);
    FUndockingPage.Free;
    FUndockingPage := nil;
  end;
end;

function TcxPageControl.GetActivePage: TcxTabSheet;
begin
  Result := Properties.ActivePage;
end;

function TcxPageControl.GetPropertiesClass: TcxCustomTabControlPropertiesClass;
begin
  Result := TcxPageControlProperties;
end;

procedure TcxPageControl.GetSiteInfo(Client: TControl;
  var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
begin
  CanDock := GetPageFromDockClient(Client) = nil;
  inherited GetSiteInfo(Client, InfluenceRect, MousePos, CanDock);
end;

function TcxPageControl.GetViewInfoClass: TcxCustomTabControlViewInfoClass;
begin
  Result := TcxPageControlViewInfo;
end;

procedure TcxPageControl.Loaded;
begin
  Properties.BeginUpdate;
  try
    inherited Loaded;
    Properties.UpdateTabs;
  finally
    Properties.EndUpdate;
  end;
end;

procedure TcxPageControl.RequestLayout;
begin
  inherited RequestLayout;
  if ActivePage <> nil then
    ActivePage.Invalidate;
end;

procedure TcxPageControl.SetChildOrder(Child: TComponent; Order: Integer);
begin
  TcxTabSheet(Child).PageIndex := Order;
end;

procedure TcxPageControl.ShowControl(AControl: TControl);
var
  Page: TcxTabSheet;
begin
  if (AControl is TcxTabSheet) then
  begin
    Page := TcxTabSheet(AControl);
    if Page.PageControl = Self then
      ActivePage := Page;
  end;
  inherited ShowControl(AControl);
end;

function TcxPageControl.UndockClient(NewTarget, Client: TControl): Boolean;
var
  APage: TcxTabSheet;
begin
  Result := True;
  APage := GetPageFromDockClient(Client);
  if APage <> nil then
  begin
    FUndockingPage := APage;
    Client.Align := alNone;
  end;
end;

procedure TcxPageControl.PropertiesPageChangingHandler(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
begin
  if Assigned(FOnPageChanging) and not IsChangeEventLocked then
    FOnPageChanging(Self, NewPage, AllowChange);
end;

function TcxPageControl.DoUnDock(NewTarget: TWinControl;
  Client: TControl): Boolean;
begin
  Result := True;
  if Assigned(OnUnDock) then
    OnUnDock(Self, Client, NewTarget, Result);
  Result := Result and UndockClient(NewTarget, Client);
end;

procedure TcxPageControl.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to PageCount - 1 do
    Proc(Pages[I]);
end;

procedure TcxPageControl.ControlChange(Inserting: Boolean; Child: TControl);
begin
  if IsDesigning and Inserting and not (Child is TcxTabSheet) then
  begin
    Child.SetBounds(Child.Left + Left, Child.Top + Top, Child.Width, Child.Height);
    Child.Parent := Parent;
  end;
end;

function TcxPageControl.GetPageFromDockClient(Client: TControl): TcxTabSheet;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to PageCount - 1 do
  begin
    if (Client.Parent = Pages[I]) and (Client.HostDockSite = Self) then
    begin
      Result := Pages[I];
      Exit;
    end;
  end;
end;

function TcxPageControl.GetActivePageIndex: Integer;
begin
  if ActivePage = nil then
    Result := -1
  else
    Result := ActivePage.PageIndex;
end;

function TcxPageControl.GetDockClientFromPoint(P: TPoint): TControl;
var
  APage: TcxTabSheet;
  ATabVisibleIndex, I: Integer;
begin
  Result := nil;
  if DockSite then
  begin
    ATabVisibleIndex := VisibleIndexOfTabAt(P.X, P.Y);
    if ATabVisibleIndex >= 0 then
    begin
      APage := nil;
      for I := 0 to PageCount - 1 do
        if Pages[I].TabIndex = ATabVisibleIndex then
        begin
          APage := Pages[I];
          Break;
        end;
      if (APage <> nil) and (APage.ControlCount > 0) then
      begin
        Result := APage.Controls[0];
        if Result.HostDockSite <> Self then
          Result := nil;
      end;
    end;
  end;
end;

function TcxPageControl.GetPage(Index: Integer): TcxTabSheet;
begin
  Result := Properties.Pages[Index];
end;

function TcxPageControl.GetPageCount: Integer;
begin
  Result := Properties.PageCount;
end;

function TcxPageControl.GetProperties: TcxPageControlProperties;
begin
  Result := inherited Properties as TcxPageControlProperties;
end;

function TcxPageControl.GetTabCount: Integer;
begin
  Result := ViewInfo.TabsViewInfo.ViewInfoCount;
end;

procedure TcxPageControl.SetActivePage(APage: TcxTabSheet);
begin
  Properties.ActivePage := APage;
end;

procedure TcxPageControl.SetActivePageIndex(Value: Integer);
begin
  if (Value >= 0) and (Value < PageCount) then
    ActivePage := Pages[Value]
  else
    ActivePage := nil;
end;

procedure TcxPageControl.SetProperties(Value: TcxPageControlProperties);
begin
  inherited Properties := Value;
end;

procedure TcxPageControl.WMLButtonDown(var Message: TWMLButtonDown);
var
  ADockClient: TControl;
begin
  inherited;
  ADockClient := GetDockClientFromPoint(SmallPointToPoint(Message.Pos));
  if ADockClient <> nil then
    ADockClient.BeginDrag(False);
end;

procedure TcxPageControl.WMLButtonDblClk(var Message: TWMLButtonDblClk);
var
  ADockClient: TControl;
begin
  inherited;
  ADockClient := GetDockClientFromPoint(SmallPointToPoint(Message.Pos));
  if ADockClient <> nil then
    ADockClient.ManualDock(nil, nil, alNone);
end;

procedure TcxPageControl.CMDockNotification(var Message: TCMDockNotification);
var
  APage: TcxTabSheet;
  I: Integer;
  S: string;
begin
  APage := GetPageFromDockClient(Message.Client);
  if APage <> nil then
    case Message.NotifyRec.ClientMsg of
      WM_SETTEXT:
        begin
          S := PChar(Message.NotifyRec.MsgLParam);
          for I := 1 to Length(S) do
            if (S[I] = #10) or (S[I] = #13) then
            begin
              SetLength(S, I - 1);
              Break;
            end;
          APage.Caption := S;
        end;
      CM_VISIBLECHANGED:
        APage.TabVisible := Boolean(Message.NotifyRec.MsgWParam);
    end;
  inherited;
end;

procedure TcxPageControl.CMControlChange(var Message: TCMControlChange);
begin
  inherited;
  ControlChange(Message.Inserting, Message.Control);
end;

procedure TcxPageControl.CMUnDockClient(var Message: TCMUnDockClient);
begin
  UndockClient(Message.NewTarget, Message.Client);
end;

{ TcxTabSheet }

constructor TcxTabSheet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  ControlStyle := ControlStyle + [csAcceptsControls, csNoDesignVisible];
  Visible := False;
  FImageIndex := -1;
  FTab := nil;
  FTabVisible := True;
  TabStop := False;
end;

destructor TcxTabSheet.Destroy;
begin
  if PageControl <> nil then
  begin
    if FPageControl.FUndockingPage = Self then FPageControl.FUndockingPage := nil;
    FPageControl.Properties.RemovePage(Self);
  end;
  inherited Destroy;
end;

procedure TcxTabSheet.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params.WindowClass do
    style := style and not(CS_HREDRAW or CS_VREDRAW);
end;

procedure TcxTabSheet.DoHide;
begin
  CallNotify(FOnHide, Self);
end;

procedure TcxTabSheet.DoShow;
begin
  CallNotify(FOnShow, Self);
end;

procedure TcxTabSheet.EnabledChanged;
begin
  PagePropertyChanged;
end;

procedure TcxTabSheet.PagePropertyChanged;
begin
  if PageControl <> nil then
    PageControl.Properties.UpdateTab(Self);
end;

procedure TcxTabSheet.SetParent(AParent: TWinControl);
begin
  if (AParent is TcxPageControl) or (AParent = nil) then
    if AParent <> FPageControl then
      PageControl := TcxPageControl(AParent)
    else
      inherited SetParent(AParent)
  else
    Abort;
end;

procedure TcxTabSheet.SetParentPageControl(AParentPageControl: TcxPageControl);
begin
  FPageControl := AParentPageControl;
  SetParent(AParentPageControl);
end;

procedure TcxTabSheet.ShowingChanged;
begin
  try
    if Showing then
      DoShow
    else
      DoHide;
  except
    Application.HandleException(Self);
  end;
end;

procedure TcxTabSheet.TextChanged;
begin
  PagePropertyChanged;
end;

procedure TcxTabSheet.WMEraseBkgnd(var Message: TWMEraseBkgnd);
var
  ASavedDC: Integer;
  APageOffset: TPoint;
begin
  if PageControl <> nil then
  begin
    if Painter.IsNativePainting then
      Painter.DrawNativeTabBackground(Message.DC, Self)
    else
    begin
      ASavedDC := SaveDC(Message.DC);
      try
        APageOffset := PageControl.PageClientRect.TopLeft;
        OffsetWindowOrgEx(Message.DC, APageOffset.X, APageOffset.Y, nil); // B158825
        PageControl.EraseBackground(Message.DC);
      finally
        RestoreDC(Message.DC, ASavedDC);
      end;
    end;
  end;
  Message.Result := 1;
end;

procedure TcxTabSheet.WMNCPaint(var Message: TWMNCPaint);
var
  ASavedDC: Integer;
  DC: HDC;
  R: TRect;
begin
  if (PageControl = nil) or not Painter.IsNativePainting then
    inherited
  else
  begin
    DC := GetWindowDC(Handle);
    try
      ASavedDC := SaveDC(DC);
      try
        R := GetControlRect(Self);
        InflateRect(R, -BorderWidth, -BorderWidth);
        with R do
          ExcludeClipRect(DC, Left, Top, Right, Bottom);
        Painter.DrawNativeTabBackground(DC, Self);
      finally
        RestoreDC(DC, ASavedDC);
      end;
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;

procedure TcxTabSheet.CMColorChanged(var Message: TMessage);
begin
  inherited;
  InternalColorChanged;
end;

procedure TcxTabSheet.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  EnabledChanged;
end;

procedure TcxTabSheet.CMInvalidate(var Message: TMessage);
begin
  if (PageControl <> nil) then
    PageControl.InvalidateControl(Self, Message.WParam = 0, PageControl.NeedRedrawOnResize);
end;

procedure TcxTabSheet.CMParentColorChanged(var Message: TMessage);
begin
  inherited;
  InternalColorChanged;
end;

procedure TcxTabSheet.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  ShowingChanged;
end;

procedure TcxTabSheet.CMTextChanged(var Message: TMessage);
begin
  inherited;
  TextChanged;
end;

function TcxTabSheet.GetPageIndex: Integer;
begin
  if PageControl = nil then
    Result := -1
  else
    Result := PageControl.Properties.FPages.IndexOf(Self);
end;

function TcxTabSheet.GetPainter: TcxPCCustomPainter;
begin
  Result := PageControl.Painter;
end;

function TcxTabSheet.GetTabIndex: Integer;
begin
  if FTab = nil then
    Result := -1
  else
    Result := FTab.VisibleIndex;
end;

procedure TcxTabSheet.InternalColorChanged;
begin
  if FTab <> nil then
    FTab.Changed(tpcLayout);
  if (BorderWidth > 0) and HandleAllocated then
    SendMessage(Handle, WM_NCPAINT, 1, 0);
  Invalidate;
end;

procedure TcxTabSheet.SetHighlighted(const Value: Boolean);
begin
  if Value <> FHighlighted then
  begin
    FHighlighted := Value;
    PagePropertyChanged;
  end;
end;

procedure TcxTabSheet.SetImageIndex(const Value: TImageIndex);
begin
  if Value <> FImageIndex then
  begin
    FImageIndex := Value;
    PagePropertyChanged;
  end;
end;

procedure TcxTabSheet.SetPageControl(const Value: TcxPageControl);
begin
  if Value <> FPageControl then
  begin
    if FPageControl <> nil then FPageControl.Properties.RemovePage(Self);
    if Value <> nil then
    begin
      Value.Properties.InsertPage(Self);
      if not(csLoading in Value.ComponentState) and (Value.ActivePage = nil) and TabVisible then
        Value.ActivePage := Self;
    end;
  end;
end;

procedure TcxTabSheet.SetPageIndex(const Value: Integer);
var
  AOldPageIndex: Integer;
begin
  if PageControl <> nil then
  begin
    if Value > PageControl.PageCount - 1 then
      raise EListError.CreateFmt(scxPCPageIndexError, [Value, PageControl.PageCount - 1]);
    AOldPageIndex := PageIndex;
    PageControl.Properties.FPages.Move(AOldPageIndex, Value);
    PageControl.Tabs.Move(AOldPageIndex, Value);
    FTab := PageControl.Tabs[Value];
    PageControl.Properties.UpdateTab(Self);
    PageControl.LockChangeEvent(True);
    try
      PageControl.TabIndex := PageControl.ActivePageIndex;
      PageControl.Properties.UpdateTabOrders;
    finally
      PageControl.LockChangeEvent(False);
    end;
  end;
end;

procedure TcxTabSheet.SetTabVisible(const Value: Boolean);
begin
  if Value <> FTabVisible then
  begin
    FTabVisible := Value;
    PagePropertyChanged;
    if Value and (PageControl <> nil) and (PageControl.PageCount = 1) and (PageControl.ActivePage = nil) then
      PageControl.ActivePage := Self;
  end;
end;

function TcxTabControl.GetPropertiesClass: TcxCustomTabControlPropertiesClass;
begin
  Result := TcxTabControlProperties;
end;

function TcxTabControl.GetProperties: TcxTabControlProperties;
begin
  Result := TcxTabControlProperties(inherited Properties);
end;

procedure TcxTabControl.SetProperties(Value: TcxTabControlProperties);
begin
  inherited Properties := Value;
end;

initialization

finalization
  FreeAndNil(FBackgroundBitmap);

end.
