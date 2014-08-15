
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
  Windows, Messages, Classes, Controls, Forms, Graphics, ImgList, SysUtils,
  dxCore, cxClasses, cxControls, cxContainer, cxGraphics, cxLookAndFeels, cxPCGoDialog;

type
  TcxPCRectCorrection = record
    dLeft, dTop, dRight, dBottom: Integer;
  end;

  TcxPCOption = (pcoAlwaysShowGoDialogButton, pcoCloseButton,
    pcoFixedTabWidthWhenRotated, pcoGoDialog, pcoGradient,
    pcoGradientClientArea, pcoNoArrows, pcoRedrawOnResize, pcoSort,
    pcoTopToBottomText, pcoUsePageColorForTab);
  TcxPCOptions = set of TcxPCOption;
  
const
  cxPCEmptyRectCorrection: TcxPCRectCorrection =
    (dLeft: 0; dTop: 0; dRight: 0; dBottom: 0);

  TabsContainerOffset = 2;
  TabsContainerBaseWidth = 3;

  cxPCNoStyle = -1;
  cxPCDefaultStyle = 0;
  cxPCDefaultStyleName = 'Default';

  cxPCDefaultOptions = [pcoAlwaysShowGoDialogButton, pcoGradient,
    pcoGradientClientArea, pcoRedrawOnResize];

type
  TcxPCStyleID = -1 .. High(Integer);
  TcxPCStandardStyle = (tsTabs, tsButtons, tsFlatButtons);

  TcxTabPosition = (tpTop, tpBottom, tpLeft, tpRight);

  TcxTabSlantKind = (skCutCorner, skSlant);
  TcxTabSlantPosition = (spLeft, spRight);
  TcxTabSlantPositions = set of TcxTabSlantPosition;

  TcxCustomTabControl = class;
  TcxTab = class;
  TcxTabSheet = class;

  TcxDrawTabEvent = procedure(AControl: TcxCustomTabControl; ATab: TcxTab;
    var DefaultDraw: Boolean) of object;
  TcxDrawTabExEvent = procedure(AControl: TcxCustomTabControl; ATab: TcxTab;
    Font: TFont) of object;
  TcxGetTabImageEvent = procedure(Sender: TObject; TabIndex: Integer;
    var ImageIndex: Integer) of object;
  TcxPageChangingEvent = procedure(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean) of object;
  TcxPCCanCloseEvent = procedure(Sender: TObject; var ACanClose: Boolean) of object;
  TcxTabChangedEvent = procedure(Sender: TObject; TabID: Integer) of object;
  TcxTabChangingEvent = procedure(Sender: TObject; var AllowChange: Boolean) of object;

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

  TcxPCTabPosition = record
    TabNormalPosition: TPoint;
    TabNormalWidth: Integer; // Height is in TcxTabs
    TabRectCorrection: TcxPCRectCorrection;
  end;

  TcxPCIndexInterval = record
    Left, Right: Integer;
  end;
  TcxPCLineIndexBoundsArray = array of TcxPCIndexInterval;

  TcxPCTabIndex = Integer;

  TcxPCTabPropertyChanged = (tpcNotSpecified, tpcColor, tpcEnabled, tpcFocused,
    tpcHighlighted, tpcHotTrack, tpcIsMainTab, tpcLayout, tpcPressed,
    tpcSelected, tpcTracking);

  TcxPCTabNotification = (tnDeleting);

  TcxPCOutTabImageAndTextData = record
    TabImageRect: TRect;
    TabTextRect: TRect;
    TabVisibleIndex: Integer;
  end;

  TcxPCImageListRotatedImagesElement = record
    BackgroundColor: TColor;
    Bitmap: TBitmap;
    IsBackgroundColorSpecified: Boolean;
  end;
  TcxPCImageListRotatedImagesElementArray =
    array of TcxPCImageListRotatedImagesElement;

  TcxTabs = class;
  TcxTabSlants = class;

  TcxTab = class(TPersistent)
  private
    FCaption: string; // type of TStrings' item
    FColor: TColor;
    FEnabled: Boolean;
    FHighlighted: Boolean;
    FImageIndex: TImageIndex;
    FIndex: Integer;
    FObject: TObject;
    FPaintBitmap: TBitmap;
    FRow: Integer;
    FSelected: Boolean;
    FTabPosition: TcxPCTabPosition;
    FTabs: TcxTabs;
    FVerticalTextBitmap: TBitmap;
    FVisible: Boolean;
    FVisibleRow: Integer;
    function GetFullRect: TRect;
    function GetHotTrack: Boolean;
    function GetImageIndex: TImageIndex;
    function GetIsMainTab: Boolean;
    function GetNormalLongitudinalSize: Integer;
    function GetNormalRect: TRect;
    function GetPaintingPosition: TcxTabPosition;
    function GetPaintingPositionIndex: Integer;
    function GetParentControl: TcxCustomTabControl;
    function GetPressed: Boolean;
    function GetRealEnabled: Boolean;
    function GetRealVisible: Boolean;
    function GetTracking: Boolean;
    function GetVisibleIndex: Integer;
    function GetVisibleRect: TRect;
    procedure InternalSetCaption(const Value: string);
    function IsImageIndexStored: Boolean;
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
    procedure ValidateImageIndex;
    property NormalLongitudinalSize: Integer read GetNormalLongitudinalSize;
    property ParentControl: TcxCustomTabControl read GetParentControl;
    property Tabs: TcxTabs read FTabs;
    property VerticalTextBitmap: TBitmap read FVerticalTextBitmap;
  public
    constructor Create(ATabs: TcxTabs; AIndex: Integer);
    destructor Destroy; override;
    procedure InitializePaintBitmap;
    procedure ResetPaintBitmap;
    procedure ResetVerticalTextBitmap;
    property FullRect: TRect read GetFullRect;
    property HotTrack: Boolean read GetHotTrack;
    property Index: Integer read FIndex;
    property IsMainTab: Boolean read GetIsMainTab;
    property NormalRect: TRect read GetNormalRect;
    property PaintBitmap: TBitmap read FPaintBitmap;
    property PaintingPosition: TcxTabPosition read GetPaintingPosition;
    property PaintingPositionIndex: Integer read GetPaintingPositionIndex;
    property Pressed: Boolean read GetPressed;
    property RealEnabled: Boolean read GetRealEnabled;
    property RealVisible: Boolean read GetRealVisible;
    property Tracking: Boolean read GetTracking;
    property VisibleIndex: Integer read GetVisibleIndex;
    property VisibleRect: TRect read GetVisibleRect;
    property VisibleRow: Integer read FVisibleRow;
  published
    property Caption: string read FCaption write SetCaption;
    property Color: TColor read FColor write SetColor default clDefault;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Highlighted: Boolean read FHighlighted write SetHighlighted;
    property ImageIndex: TImageIndex
      read GetImageIndex write SetImageIndex stored IsImageIndexStored;
    property Selected: Boolean read FSelected write SetSelected;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  TcxTabs = class(TStrings)
  private
    FNotification: Boolean;
    FParent: TcxCustomTabControl;
    FTabNormalHeight: Integer;
    FTabsItemA: array of TcxTab;
    FUpdating: Boolean;
    function GetTab(TabIndex: Integer): TcxTab;
    function GetVisibleTab(TabVisibleIndex: Integer): TcxTab;
    procedure SetTab(Index: Integer; const Value: TcxTab);
    function GetVisibleTabsCount: Integer;
  protected
    function Get(Index: Integer): string; override;
    function GetCount: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure Put(Index: Integer; const S: string); override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;

    procedure Changed(AVisibleIndex: Integer = -1; ATabPropertyChanged: TcxPCTabPropertyChanged = tpcLayout);
    procedure Notify(Index: Integer; Action: TcxPCTabNotification); virtual;
    class procedure OutError(SourceMethodName: TCaption; Index: Integer); virtual;
    procedure SetHotTrack(VisibleIndex: Integer);
    procedure SetMainTab;
    procedure SetTracking(NewTracking: Integer);
    procedure UpdateTabIndexes(FirstIndex, LastIndex: Integer);
    procedure ValidateImageIndexes;
    property Parent: TcxCustomTabControl read FParent;
  public
    constructor Create(AParent: TcxCustomTabControl);
    destructor Destroy; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure Move(CurIndex, NewIndex: Integer); override;
    procedure ResetTabVerticalTextBitmaps;

    property TabNormalHeight: Integer read FTabNormalHeight;
    property Tabs[TabIndex: Integer]: TcxTab read GetTab write SetTab; default;
    property VisibleTabsCount: Integer read GetVisibleTabsCount;
    property VisibleTabs[TabVisibleIndex: Integer]: TcxTab read GetVisibleTab;
  end;

  TcxVisibleTabList = class
  private
    FParent: TcxCustomTabControl;
    TabIndexA: array of TcxPCTabIndex;
    function GetCount: Integer;
    function GetTab(TabVisibleIndex: Integer): TcxTab;
    procedure OutError(SourceMethodName: TCaption; Msg: string);
  public
    constructor Create(AParent: TcxCustomTabControl);
    destructor Destroy; override;

    function FindVisibleTab(TabIndex: TcxPCTabIndex; var TabVisibleIndex: Integer): Boolean;
    procedure HideTab(TabIndex: TcxPCTabIndex);
    procedure ShowTab(TabIndex: TcxPCTabIndex);
    procedure Update;
    function TabVisibleIndexOf(TabIndex: TcxPCTabIndex): Integer;

    property Count: Integer read GetCount;
    property Tabs[TabVisibleIndex: Integer]: TcxTab read GetTab; default;
  end;

  TcxPCPainterParentInfo = class
  private
    FParent: TcxCustomTabControl;
    function GetActivePage: TcxTabSheet;
    function GetCanvas: TcxCanvas;
    function GetFont: TFont;
    function GetIsTabsContainer: Boolean;
    function GetTabPosition: TcxTabPosition;
    function GetNavigatorPositione: TcxPCNavigatorPosition;
    function GetMultiLine: Boolean;
    function GetNavigatorButtonState(
      Index: TcxPCNavigatorButton): TcxPCNavigatorButtonState;
    function GetVisibleTab(TabVisibleIndex: Integer): TcxTab;
    function GetTabHeight: Smallint;
    function GetTabsOnBothSides: Boolean;
    function GetTabWidth: Smallint;
    function GetMainTabVisibleIndex: Integer;
    function GetOptions: TcxPCOptions;
    function GetPageColor(ATabVisibleIndex: Integer): TColor;
    function GetPage(ATabVisibleIndex: Integer): TcxTabSheet;
    function GetRaggedRight: Boolean;
    function GetTabColor(ATabVisibleIndex: Integer): TColor;
    function GetTabSlants: TcxTabSlants;
    function GetNavigatorButtons: TcxPCNavigatorButtons;
    function GetHeight: Integer;
    function GetWidth: Integer;
    function GetExtendedBottomOrRightTabsRect: TRect;
    function GetExtendedTopOrLeftTabsRect: TRect;
    function GetRowCount: Integer;
    function GetScrollOpposite: Boolean;
    function GetTopOrLeftPartRowCount: Integer;
    function GetColor: TColor;
    function GetHideTabs: Boolean;
    function GetShowFrame: Boolean;
    function GetRotate: Boolean;
    function GetImageBorder: Integer;
  protected
    property Pages[ATabVisibleIndex: Integer]: TcxTabSheet read GetPage;
  public
    constructor Create(AParent: TcxCustomTabControl);
    property ActivePage: TcxTabSheet read GetActivePage; 
    property Canvas: TcxCanvas read GetCanvas;
    property Color: TColor read GetColor;
    property ExtendedBottomOrRightTabsRect: TRect read GetExtendedBottomOrRightTabsRect;
    property ExtendedTopOrLeftTabsRect: TRect read GetExtendedTopOrLeftTabsRect;
    property Font: TFont read GetFont;
    property Height: Integer read GetHeight;
    property HideTabs: Boolean read GetHideTabs;
    property ImageBorder: Integer read GetImageBorder;
    property IsTabsContainer: Boolean read GetIsTabsContainer;
    property MainTabVisibleIndex: Integer read GetMainTabVisibleIndex;
    property MultiLine: Boolean read GetMultiLine;
    property NavigatorButtonsState[Index: TcxPCNavigatorButton]: TcxPCNavigatorButtonState read GetNavigatorButtonState;
    property NavigatorButtons: TcxPCNavigatorButtons read GetNavigatorButtons;
    property NavigatorPosition: TcxPCNavigatorPosition read GetNavigatorPositione;
    property Options: TcxPCOptions read GetOptions;
    property PageColors[ATabVisibleIndex: Integer]: TColor read GetPageColor;
    property RaggedRight: Boolean read GetRaggedRight;
    property Rotate: Boolean read GetRotate;
    property RowCount: Integer read GetRowCount;
    property ScrollOpposite: Boolean read GetScrollOpposite;
    property ShowFrame: Boolean read GetShowFrame;
    property TabColors[ATabVisibleIndex: Integer]: TColor read GetTabColor;
    property TabHeight: Smallint read GetTabHeight;
    property TabPosition: TcxTabPosition read GetTabPosition;
    property TabSlants: TcxTabSlants read GetTabSlants;
    property TabsOnBothSides: Boolean read GetTabsOnBothSides;
    property TabWidth: Smallint read GetTabWidth;
    property TopOrLeftPartRowCount: Integer read GetTopOrLeftPartRowCount;
    property VisibleTabs[TabVisibleIndex: Integer]: TcxTab read GetVisibleTab;
    property Width: Integer read GetWidth;
  end;

  TcxPCCustomPainter = class
  private
    FParentInfo: TcxPCPainterParentInfo;
    FParentControl: TcxCustomTabControl;
    function GetDisabledTextFaceColor: TColor;
    function GetDisabledTextShadowColor: TColor;
    function GetHighlightedTabBodyColor: TColor;
    procedure PrepareTabControlImagesBitmapBackground(ABitmap: TBitmap);
  protected
    FOutTabImageAndTextData: TcxPCOutTabImageAndTextData;
    class function AllowRotate: Boolean; virtual;
    function CalculateTabNormalWidth(Tab: TcxTab): Integer; virtual; abstract;
    procedure CorrectTabRect(TabVisibleIndex: Integer; var TabRectCorrection: TcxPCRectCorrection); virtual;
    function CreateNewTabVerticalTextBitmap(TabVisibleIndex: Integer): TBitmap;
    procedure DirectionalPolyline(const R: TRect; APoints: array of TPoint;
      ATabPosition: TcxTabPosition; AColor: TColor);
    function DoCustomDraw(TabVisibleIndex: Integer): Boolean;
    procedure DrawNativeTabBackground(DC: HDC; ATab: TcxTabSheet); virtual;
    procedure DrawTabImageAndText(ATab: TcxTab; ATabVisibleIndex: Integer); virtual;
    procedure ExcludeTabContentClipRegion(ATabVisibleIndex: Integer);
    procedure FillDisplayRect; virtual;
    procedure FillTabPaneContent; virtual;
    function GetButtonsDistance(AButton1, AButton2: TcxPCNavigatorButton): Integer; virtual;
    function GetButtonsRegionFromTabsOffset: Integer; virtual;
    function GetButtonsRegionHOffset: Integer; virtual;
    function GetButtonsRegionWOffset: Integer; virtual;
    function GetClientColor: TColor; virtual;
    function GetClientRect: TRect;
    function GetClientRectOffset: TRect; virtual;
    function GetDefaultClientColor: TColor; virtual;
    function GetDisplayRect: TRect;
    function GetDisplayRectOffset: TRect; virtual;
    function GetDrawImageOffset(TabVisibleIndex: Integer): TRect; virtual; abstract;
    function GetDrawImageWithoutTextWOffset(TabVisibleIndex: Integer): TcxPCWOffset; virtual; abstract;
    function GetDrawTextHOffset(TabVisibleIndex: Integer): TRect; virtual; abstract;

    function GetExtendedRect(const ARect, AExtension: TRect; ATabPosition: TcxTabPosition): TRect;
    function GetFrameWidth: Integer; virtual;

    procedure AfterPaintTab(ATabVisibleIndex: Integer); virtual;
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
    function GetTabClipRgn(ATabVisibleIndex: Integer): TcxRegion; virtual;
    function GetTabClipRgnOperation(ATabVisibleIndex: Integer): TcxRegionOperation; virtual;
    function GetTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset; virtual; abstract;
    procedure GetTabNativePartAndState(ATabVisibleIndex: Integer;
      out PartId, StateId: Integer); virtual;
    function GetTabNativeState(ATabVisibleIndex: Integer): Integer;
    function GetTabRotatedImageSize: TSize;
    function GetTabsContainerOffsets: TRect; virtual;
    function GetTabsNormalDistance: TcxPCDistance; virtual;
    function GetTabsPosition(NavigatorButtons: TcxPCNavigatorButtons): TcxPCTabsPosition; virtual; abstract;
    function GetTabVerticalTextBitmap(TabVisibleIndex: Integer): TBitmap;
    function GetTextColor(ATabVisibleIndex: Integer): TColor; virtual;
    function GetTooNarrowTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset; virtual; abstract;
    procedure Init; virtual;
    procedure InternalDrawText(ACanvas: TCanvas; const ACaption: string;
      ARect: TRect; ATabVisibleIndex: Integer); virtual;
    procedure InternalInvalidateRect(Rect: TRect);
    procedure InternalPaint; virtual;
    procedure InternalPolyLine(const APoints: array of TPoint; AColor: TColor;
      ACanvas: TCanvas = nil);
    procedure InternalPrepareOutTabImageAndTextData(ATabVisibleIndex: Integer;
      var AImageRect, ATextRect: TRect); virtual; abstract;
    procedure InternalResetClipRegion;
    function InternalSetClipRect(ClipR: TRect; IntersectWithCurrentClipRegion: Boolean = True): Boolean;
    procedure InvalidateTabExtendedTabsRect(TabVisibleIndex: Integer);
    procedure InvalidateTabRect(ATabVisibleIndex: Integer); virtual;
    function IsAssignedImages: Boolean;
    function IsCustomDraw: Boolean;
    function IsEnableHotTrack: Boolean; virtual;
    function IsNativePainting: Boolean; virtual;
    function IsOverButton(X, Y: Integer; var Button: TcxPCNavigatorButton): Boolean; virtual; abstract;
    function IsOverTab(TabVisibleIndex: Integer; X, Y: Integer): Boolean; virtual;
    function IsTabHasImage(ATabVisibleIndex: Integer): Boolean;
    function IsTabBorderThick(ATabVisibleIndex: Integer): Boolean; virtual; abstract;
    function IsTabTransparent(ATabVisibleIndex: Integer): Boolean; virtual;
    function NeedDisabledTextShadow: Boolean; virtual;
    function NeedDoubleBuffer: Boolean; virtual;
    function NeedRedrawOnResize: Boolean; virtual;
    function NeedShowFrame: Boolean; virtual;
    procedure Paint; virtual;
    procedure PaintButtonsRegion; virtual; abstract;
    procedure PaintClientArea; virtual;
    procedure PaintFrame; virtual; abstract;
    procedure PaintTabsRegion; virtual; abstract;
    procedure PrepareTabCanvasFont(ATab: TcxTab; ACanvas: TcxCanvas);
    procedure PrepareDrawTabContentBitmapBackground(ABitmap: TBitmap;
      const ABitmapPos: TPoint; ATabVisibleIndex: Integer); virtual;
    procedure RepaintButton(Button: TcxPCNavigatorButton; OldButtonState: TcxPCNavigatorButtonState); virtual;
    procedure RepaintButtonsRegion; virtual;
    procedure RepaintTab(TabVisibleIndex: Integer; TabPropertyChanged: TcxPCTabPropertyChanged); virtual;
    procedure RotatePoint(const R: TRect; var P: TPoint;
      ATabPosition: TcxTabPosition);
    procedure RotatePolyline(const R: TRect; var APoints: array of TPoint;
      ATabPosition: TcxTabPosition);
    procedure StandardPainterPrepareOutTabImageAndTextData(TabVisibleIndex: Integer);

    procedure SaveClipRgn;
    procedure RestoreClipRgn;

    property DisabledTextFaceColor: TColor read GetDisabledTextFaceColor;
    property DisabledTextShadowColor: TColor read GetDisabledTextShadowColor;
    property HighlightedTabBodyColor: TColor read GetHighlightedTabBodyColor;

    property ParentControl: TcxCustomTabControl read FParentControl;
    property ParentInfo: TcxPCPainterParentInfo read FParentInfo;
  public
    constructor Create(AParent: TcxCustomTabControl); virtual;
    destructor Destroy; override;

    function CalculateTabNormalHeight: Integer; virtual; abstract;
    function GetGoDialogButtonBounds: TRect; virtual; abstract;
    class function GetStandardStyle: TcxPCStandardStyle; virtual;
    class function GetStyleID: TcxPCStyleID; virtual;
    class function GetStyleName: TCaption; virtual;
    class function HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean; virtual;
    class function IsDefault(ALookAndFeel: TcxLookAndFeel): Boolean; virtual;
    class function IsMainTabBoundWithClient: Boolean; virtual;
    class function IsMultiSelectionAccepted: Boolean; virtual;
    class function IsStandardStyle: Boolean; virtual;
    class function IsTabPressable: Boolean; virtual;
  end;

  TcxPCPainterClass = class of TcxPCCustomPainter;

  TcxPCImageListPrepareBitmapBackgroundEvent = procedure(ABitmap: TBitmap) of object;

  TcxPCImageList = class
  private
    FBaseImageChangeLink: TChangeLink;
    FBaseImages: TCustomImageList;
    FFreeNotificator: TcxFreeNotificator;
    FImageRotationAngle: TcxRotationAngle;
    FParent: TcxCustomTabControl;
    FRotatedImages: TcxPCImageListRotatedImagesElementArray;
    FOnChange: TNotifyEvent;
    FOnPrepareBitmapBackground: TcxPCImageListPrepareBitmapBackgroundEvent;
    procedure BaseImageListChange(Sender: TObject);
    procedure Change;
    procedure ClearRotatedImages;
    procedure DoPrepareBitmapBackground(ABitmap: TBitmap);
    procedure FreeNotification(AComponent: TComponent);
    class procedure OutError(SourceMethodName, Msg: TCaption);
    procedure RotateImage(Index: Integer; BackgroundColor: TColor; Enabled: Boolean);
    procedure RotateImages;
    procedure SetImageRotationAngle(const Value: TcxRotationAngle);
    procedure SetBaseImages(const Value: TCustomImageList);
    function GetBaseImageSize: TSize;
    function GetRotatedImageSize: TSize;
  public
    constructor Create(AParent: TcxCustomTabControl);
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; X, Y, Index: Integer; BackgroundColor: TColor;
      Enabled: Boolean = True);

    property BaseImages: TCustomImageList read FBaseImages write SetBaseImages;
    property BaseImageSize: TSize read GetBaseImageSize;
    property ImageRotationAngle: TcxRotationAngle read FImageRotationAngle write SetImageRotationAngle default ra0;
    property RotatedImageSize: TSize read GetRotatedImageSize;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnPrepareBitmapBackground: TcxPCImageListPrepareBitmapBackgroundEvent
      read FOnPrepareBitmapBackground write FOnPrepareBitmapBackground;
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

  { TcxCustomTabControl }

  TcxCustomTabControl = class(TcxControl, IdxSkinSupport)
  private
    FChangeEventLockCount: Integer;
    FClientRect: TRect;
    FExtendedBottomOrRightTabsRect: TRect;
    FExtendedTopOrLeftTabsRect: TRect;
    FFirstVisibleTab, FLastVisibleTab: Integer;
    FFocusable: Boolean;
    FHideTabs: Boolean;
    FHotTrack: Boolean;
    FHotTrackNavigatorButton: TcxPCNavigatorButtonIndex;
    FHotTrackTabVisibleIndex: Integer;
    FImageBorder: Integer;
    FImages: TcxPCImageList;
    FIsClientRectLoaded: Boolean;
    FIsLastTabFullyVisible: Boolean;
    FIsTabsContainer: Boolean;
    FMainTabVisibleIndex: Integer;
    FMaxRotatedTabWidth: Integer;
    FMaxTabCaptionWidth: Integer;
    FMultiLine: Boolean;
    FMultiSelect: Boolean;
    FOptions: TcxPCOptions;
    FOwnerDraw: Boolean;
    FPainter: TcxPCCustomPainter;
    FRaggedRight: Boolean;
    FRotate: Boolean;
    FRowCount: Integer;
    FRowHeight: Integer;
    FScrollOpposite: Boolean;
    FShowFrame: Boolean;
    FStyle: TcxPCStyleID;
    FTabCaptionAlignment: TAlignment;
    FTabIndex: Integer;
    FTabPosition: TcxTabPosition;
    FTabs: TcxTabs;
    FTabSize: TSmallPoint;
    FTabSlants: TcxTabSlants;
    FTabsPosition: TcxPCTabsPosition;
    FTimer: TcxTimer;
    FTopOrLeftPartRowCount: Integer;
    FTracking: Integer;
    FUpdating: Boolean;
    FVisibleTabList: TcxVisibleTabList;

    FPressedTabVisibleIndex: Integer;
    FMouseDownTabVisibleIndex: Integer;
    
    FNavigatorButtons: TcxPCNavigatorButtons;
    FNavigatorButtonStates: array[TcxPCNavigatorButton] of TcxPCNavigatorButtonState;
    FNavigatorPosition: TcxPCNavigatorPosition;
    FPressedNavigatorButton: TcxPCNavigatorButtonIndex;

    FGoDialog: TcxPCGoDialog;
    FIsGoDialogShowing: Boolean;
    FGoDialogJustClosed: Boolean;

    FOnCanClose: TcxPCCanCloseEvent;
    FOnChange: TNotifyEvent;
    FOnChanging: TcxTabChangingEvent;
    FOnDrawTab: TcxDrawTabEvent;
    FOnDrawTabEx: TcxDrawTabExEvent;
    FOnGetImageIndex: TcxGetTabImageEvent;

    procedure ArrowButtonClick(NavigatorButton: TcxPCNavigatorButton);
    procedure Calculate;
    procedure CalculateLongitudinalTabPositions;
    procedure CalculateRowHeight;
    procedure CalculateRowPositions;
    procedure CalculateTabNormalSize(Tab: TcxTab);
    procedure CalculateTabNormalSizes;
    function CanMouseWheel(const AMouseScreenPos: TPoint): Boolean;
    function CanPressButton(AButton: TcxPCNavigatorButton): Boolean;
    procedure CloseButtonClick;
    procedure CorrectMaxRotatedTabWidth;
    procedure CorrectTabRect(TabVisibleIndex: Integer);
    procedure CreateGoDialog;
    procedure CreateTimer;
    procedure DoDrawTabEx(ATabVisibleIndex: Integer; AFont: TFont);
    function GetDisplayRect: TRect;
    function GetImages: TCustomImageList;
    function GetLineWidth(const ALineIndexBoundsA: TcxPCLineIndexBoundsArray;
      ALineNumber, ATabsDistance: Integer): Integer;
    function GetMainTabIndex: Integer;
    function GetMaxRotatedTabWidth: Integer;
    function GetNavigatorButton(NavigatorButtonIndex: TcxPCNavigatorButtonIndex): TcxPCNavigatorButton;
    function GetNavigatorButtons(OnlyObligatoryButtons: Boolean): TcxPCNavigatorButtons;
    function GetOptions: TcxPCOptions;
    function GetPageClientRect: TRect;
    function GetPageClientRectOffset: TRect;
    function GetStyle: TcxPCStyleID;
    function GetTabExtendedTabsRect(TabVisibleIndex: Integer): TRect;
    function GetTabsTab(TabIndex: Integer): TcxTab;
    procedure InitializeLineBoundsA(var ALineIndexBoundsA: TcxPCLineIndexBoundsArray; AFirstIndex, ALastIndex: Integer);
    function InternalGetClientRect: TRect;
    function InternalGetShiftState: TShiftState;
    procedure InternalInvalidateRect(Rect: TRect);
    function IsTooSmallControlSize: Boolean;
    function PassDesignMouseEvent(X, Y: Integer): Boolean;
    procedure PlaceVisibleTabsOnRows(ATabsWidth, ATabsDistance: Integer);
    procedure PrepareImagesBitmapBackground(ABitmap: TBitmap);
    procedure RearrangeRows;
    procedure ReadClientRectBottom(Reader: TReader);
    procedure ReadClientRectLeft(Reader: TReader);
    procedure ReadClientRectRight(Reader: TReader);
    procedure ReadClientRectTop(Reader: TReader);
    procedure RepaintTab(TabVisibleIndex: Integer; TabPropertyChanged: TcxPCTabPropertyChanged);
    procedure SelectTab(ATabVisibleIndex: Integer; AAddToSelected: Boolean);
    procedure SetHideTabs(const Value: Boolean);
    procedure SetHotTrack(Value: Boolean);
    procedure SetImageBorder(const Value: Integer);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetIsTabsContainer(Value: Boolean);
    procedure SetMaxRotatedTabWidth(Value: Integer);
    procedure SetMultiLine(const Value: Boolean);
    procedure SetMultiSelect(const Value: Boolean);
    procedure SetNavigatorPosition(const Value: TcxPCNavigatorPosition);
    procedure SetOptions(Value: TcxPCOptions);
    procedure SetOwnerDraw(const Value: Boolean);
    procedure SetRaggedRight(const Value: Boolean);
    procedure SetRotate(const Value: Boolean);
    procedure SetScrollOpposite(const Value: Boolean);
    procedure SetShowFrame(const Value: Boolean);
    procedure SetStyle(const Value: TcxPCStyleID);
    procedure SetTabCaptionAlignment(Value: TAlignment);
    procedure SetTabHeight(const Value: Smallint);
    procedure SetTabIndex(Value: Integer);
    procedure SetTabPosition(const Value: TcxTabPosition);
    procedure SetTabs(const Value: TcxTabs);
    procedure SetTabSlants(Value: TcxTabSlants);
    procedure SetTabsTab(TabIndex: Integer; const Value: TcxTab);
    procedure SetTabWidth(const Value: Smallint);
    procedure SynchronizeHotTrackStates(Shift: TShiftState);
    procedure SynchronizeNavigatorButtons;
    procedure SynchronizeTabImagesRotationAngle;
    procedure TabSlantsChanged(Sender: TObject);
    procedure TimerEventHandler(Sender: TObject);
    procedure UpdateButtonsState;
    procedure UpdateTabPosition(ANavigatorButtons: TcxPCNavigatorButtons);
    procedure WriteClientRectBottom(Writer: TWriter);
    procedure WriteClientRectLeft(Writer: TWriter);
    procedure WriteClientRectRight(Writer: TWriter);
    procedure WriteClientRectTop(Writer: TWriter);
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMParentColorChanged(var Message: TMessage); message CM_PARENTCOLORCHANGED;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMPrintClient(var Message: TWMPrintClient); message WM_PRINTCLIENT;
  protected
    procedure AdjustClientRect(var Rect: TRect); override;
    function CanFocusOnClick: Boolean; override;
    procedure ChangeScale(M, D: Integer); override;
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
    procedure MouseLeave(AControl: TControl); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    function CanTabClick(ATabVisibleIndex: Integer): Boolean;
    procedure TabDown(ATabVisibleIndex: Integer; AShift: TShiftState);
    procedure TabUp(ATabVisibleIndex: Integer; AShift: TShiftState);
    procedure TabClick(Sender: TObject; ATabVisibleIndex: Integer; AShift: TShiftState); virtual;

    procedure AfterPaintTab(ACanvas: TcxCanvas; ATab: TcxTab;
      AImageAndTextData: TcxPCOutTabImageAndTextData); virtual;
    function DoCanClose: Boolean; virtual;
    procedure DoClose; virtual;
    procedure EraseBackground(DC: HDC); virtual;
    function HandleDialogChar(Key: Integer): Boolean; virtual;
    function HasBackground: Boolean; override;
    function CanChange(NewTabIndex: Integer): Boolean; dynamic;
    function CanShowTab(TabIndex: Integer): Boolean; virtual;
    procedure Change; dynamic;
    procedure CorrectFirstVisibleTab(TabVisibleIndex: Integer);
    procedure DoShowGoDialog; virtual;
    procedure DrawTab(TabIndex: Integer; const Rect: TRect; Active: Boolean); virtual;
    function GetActivePage: TcxTabSheet; virtual;
    function GetImageIndex(ATabIndex: Integer): Integer; virtual;
    function GetPage(ATabIndex: Integer): TcxTabSheet; virtual;
    procedure GoDialogClickEventHandler(ATabControlItemIndex: Integer); virtual;
    procedure HideGoDialog(ATabControlItemIndex: Integer);
    procedure ImageListChange(Sender: TObject); virtual;
    function InternalKeyDown(var Key: Word; Shift: TShiftState): Boolean; virtual;
    function IsChangeEventLocked: Boolean;
    procedure LockChangeEvent(ALock: Boolean);
    class procedure OutError(SourceMethodName: TCaption; Msg: TCaption);
    procedure PrepareTabCanvasFont(ATab: TcxTab; ACanvas: TcxCanvas); virtual;
    procedure RequestLayout; dynamic;
    procedure SetDefaultStyle;
    procedure SetModified;
    procedure ShowGoDialog;
    function TabIndexTabMustBeVisible: Boolean; virtual;
    procedure UpdateTabImages;

    property DisplayRect: TRect read GetDisplayRect;
    property FirstVisibleTab: Integer read FFirstVisibleTab write FFirstVisibleTab;
    property Focusable: Boolean read FFocusable write FFocusable default True;
    property HideTabs: Boolean read FHideTabs write SetHideTabs default False;
    property HotTrack: Boolean read FHotTrack write SetHotTrack default False;
    property ImageBorder: Integer read FImageBorder write SetImageBorder default 0;
    property Images: TCustomImageList read GetImages write SetImages;
    property IsTabsContainer: Boolean read FIsTabsContainer
      write SetIsTabsContainer default False;
    property MainTabIndex: Integer read GetMainTabIndex;
    property MaxRotatedTabWidth: Integer read GetMaxRotatedTabWidth
      write SetMaxRotatedTabWidth default 0;
    property MultiLine: Boolean read FMultiLine write SetMultiLine default False;
    property MultiSelect: Boolean read FMultiSelect write SetMultiSelect default False;
    property NavigatorPosition: TcxPCNavigatorPosition read FNavigatorPosition
      write SetNavigatorPosition default npRightTop;
    property Options: TcxPCOptions read GetOptions write SetOptions
      default cxPCDefaultOptions;
    property OwnerDraw: Boolean read FOwnerDraw write SetOwnerDraw default False;
    property PageClientRect: TRect read GetPageClientRect;
    property PageClientRectOffset: TRect read GetPageClientRectOffset;
    property RaggedRight: Boolean read FRaggedRight write SetRaggedRight default False;
    property Rotate: Boolean read FRotate write SetRotate default False;
    property ScrollOpposite: Boolean read FScrollOpposite
      write SetScrollOpposite default False;
    property ShowFrame: Boolean read FShowFrame write SetShowFrame default False;
    property Style: TcxPCStyleID read GetStyle write SetStyle default cxPCDefaultStyle;
    property TabCaptionAlignment: TAlignment read FTabCaptionAlignment
      write SetTabCaptionAlignment default taCenter;
    property TabHeight: Smallint read FTabSize.Y write SetTabHeight default 0;
    property TabIndex: Integer read FTabIndex write SetTabIndex default -1;
    property TabPosition: TcxTabPosition read FTabPosition write SetTabPosition
      default tpTop;
    property TabSlants: TcxTabSlants read FTabSlants write SetTabSlants;
    property TabsTabs[TabIndex: Integer]: TcxTab read GetTabsTab write SetTabsTab;
    property TabWidth: Smallint read FTabSize.X write SetTabWidth default 0;
    property VisibleTabList: TcxVisibleTabList read FVisibleTabList;
    property OnCanClose: TcxPCCanCloseEvent read FOnCanClose write FOnCanClose;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChanging: TcxTabChangingEvent read FOnChanging write FOnChanging;
    property OnDrawTab: TcxDrawTabEvent read FOnDrawTab write FOnDrawTab;
    property OnDrawTabEx: TcxDrawTabExEvent read FOnDrawTabEx write FOnDrawTabEx;
    property OnGetImageIndex: TcxGetTabImageEvent read FOnGetImageIndex write FOnGetImageIndex;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanFocus: Boolean; override;
    function GetOptimalSize: Integer;
    procedure GetTabOrderList(List: TList); override;

    function IndexOfTabAt(X, Y: Integer): Integer;
    function VisibleIndexOfTabAt(X, Y: Integer): Integer;

    procedure ScrollTabs(Delta: Integer);
    procedure SetStandardStyle(StandardStyle: TcxPCStandardStyle);
    procedure SetStyleByStyleName(StyleName: TCaption);
    property LookAndFeel;
    property Painter: TcxPCCustomPainter read FPainter;
    property ParentBackground;
    property RowCount: Integer read FRowCount;
    property Tabs: TcxTabs read FTabs write SetTabs;
    property TabStop default True;
    property TopOrLeftPartRowCount: Integer read FTopOrLeftPartRowCount;
  end;

  { TcxPageControl }

  TcxPageControl = class(TcxCustomTabControl)
  private
    FActivePage: TcxTabSheet;
    FActivePageSetting: Boolean;
    FNewDockSheet: TcxTabSheet;
    FPageInserting: Boolean;
    FPages: TList;
    FUndockingPage: TcxTabSheet;
    FOnPageChanging: TcxPageChangingEvent;
    procedure ChangeActivePage(APage: TcxTabSheet);
    function GetActivePageIndex: Integer;
    function GetDockClientFromPoint(P: TPoint): TControl;
    function GetPageCount: Integer;
    function GetTabCount: Integer;
    procedure InsertPage(APage: TcxTabSheet);
    procedure RemovePage(APage: TcxTabSheet);
    procedure SetActivePage(APage: TcxTabSheet);
    procedure SetActivePageIndex(Value: Integer);
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure CMDockNotification(var Message: TCMDockNotification); message CM_DOCKNOTIFICATION;
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
    procedure CMUnDockClient(var Message: TCMUnDockClient); message CM_UNDOCKCLIENT;
  protected
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    function CanChange(NewTabIndex: Integer): Boolean; override;
    procedure Change; override;
    procedure DoAddDockClient(Client: TControl; const ARect: TRect); override;
    function DockClient(DockSource: TDragDockObject;
      MousePos: TPoint): Integer; virtual;
    procedure DoClose; override;
    procedure DockOver(Source: TDragDockObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean); override;
    procedure DoRemoveDockClient(Client: TControl); override;
    function GetActivePage: TcxTabSheet; override;
    function GetPage(ATabIndex: Integer): TcxTabSheet; override;
    procedure GetSiteInfo(Client: TControl; var InfluenceRect: TRect;
      MousePos: TPoint; var CanDock: Boolean); override;
    procedure ImageListChange(Sender: TObject); override;
    procedure Loaded; override;
    procedure RequestLayout; override;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure ShowControl(AControl: TControl); override;
    function TabIndexTabMustBeVisible: Boolean; override;
    function UndockClient(NewTarget, Client: TControl): Boolean;
      virtual;
    function DoUnDock(NewTarget: TWinControl; Client: TControl): Boolean; override;
  {$IFNDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}
    function CanChangeActivePage(NewPage: TcxTabSheet): Boolean; dynamic;
    procedure ControlChange(Inserting: Boolean; Child: TControl); virtual;
    function GetPageFromDockClient(Client: TControl): TcxTabSheet;
    procedure PageChange; dynamic;
    procedure PageChanging(NewPage: TcxTabSheet; var AllowChange: Boolean);
    procedure UpdateActivePage; virtual;
    procedure UpdateTab(APage: TcxTabSheet);
    procedure UpdateTabs;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
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
    property ActivePage: TcxTabSheet read FActivePage write SetActivePage;
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
    property HideTabs;
    property HotTrack;
    property ImageBorder;
    property Images;
    property LookAndFeel;
    property MaxRotatedTabWidth;
    property MultiLine;
    property NavigatorPosition;
    property Options;
    property OwnerDraw;
    property ParentBackground;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RaggedRight;
    property Rotate;
    property ScrollOpposite;
    property ShowFrame;
    property ShowHint;
    property Style;
    property TabHeight;
    property TabOrder;
    property TabPosition;
    property TabSlants;
    property TabStop;    
    property TabWidth;
    property Visible;
    property OnCanClose;
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
    property OnMouseMove;
    property OnMouseUp;
    property OnPageChanging: TcxPageChangingEvent read FOnPageChanging
      write FOnPageChanging;
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
  public
    property DisplayRect;
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
    property HideTabs;
    property HotTrack;
    property ImageBorder;
    property Images;
    property LookAndFeel;
    property MaxRotatedTabWidth;
    property MultiLine;
    property MultiSelect;
    property NavigatorPosition;
    property Options;
    property OwnerDraw;
    property ParentBackground;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RaggedRight;
    property Rotate;
    property ScrollOpposite;
    property ShowFrame;
    property ShowHint;
    property Style;
    property TabHeight;
    property TabIndex;
    property TabOrder;
    property TabPosition;
    property Tabs;
    property TabSlants;
    property TabStop;
    property TabWidth;
    property Visible;
    property OnCanClose;
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
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

procedure CorrectRect(var Rect: TRect; RectCorrection: TcxPCRectCorrection);
function DistanceGetter(const Distance: TcxPCDistance; const LongitudinalDistance: Boolean): Integer;
function GetButtonCount(NavigatorButtons: TcxPCNavigatorButtons): Integer;
function GetTextRotationAngle(TabControl: TcxCustomTabControl): TcxRotationAngle;
procedure InitializeLineBoundsArray(TabControl: TcxCustomTabControl;
  var LineIndexBoundsA: TcxPCLineIndexBoundsArray);
procedure InitializeVisibleTabRange(TabControl: TcxCustomTabControl;
  var FirstIndex, LastIndex: Integer);
function InternalGetTextRotationAngle(TabControl: TcxCustomTabControl): TcxRotationAngle;
function InternalIsVerticalText(TabControl: TcxCustomTabControl): Boolean;
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
function TextSize(ATab: TcxTab; const AText: string; AFont: TFont = nil): TSize;
procedure ValidateRect(var R: TRect);

function GetPCStyleName(AStyleID: TcxPCStyleID): string;

var
  TabScrollingDelay: Integer = 150;
  TabScrollingStartDelay: Integer = 300;

implementation

uses
  Math, cxPCConsts, cxPCPainters, cxPCPaintersFactory, dxThemeConsts, dxThemeManager, dxUxTheme;

var
  FBackgroundBitmap: TBitmap = nil;

procedure CorrectRect(var Rect: TRect; RectCorrection: TcxPCRectCorrection);
begin
  Inc(Rect.Top, RectCorrection.dTop);
  Inc(Rect.Bottom, RectCorrection.dBottom);
  Inc(Rect.Left, RectCorrection.dLeft);
  Inc(Rect.Right, RectCorrection.dRight);
end;

function DistanceGetter(const Distance: TcxPCDistance; const LongitudinalDistance: Boolean): Integer;
begin
  if LongitudinalDistance then
    Result := Distance.dw
  else
    Result := Distance.dh;
end;

function GetButtonCount(NavigatorButtons: TcxPCNavigatorButtons): Integer;
var
  NavigatorButton: TcxPCNavigatorButton;
begin
  Result := 0;
  for NavigatorButton := Low(TcxPCNavigatorButton) to High(TcxPCNavigatorButton) do
    if NavigatorButton in NavigatorButtons then
      Inc(Result);
end;

function GetControlRect(AControl: TControl): TRect;
begin
  Result := Rect(0, 0, AControl.Width, AControl.Height);
end;

function GetTextRotationAngle(TabControl: TcxCustomTabControl): TcxRotationAngle;
begin
  if IsVerticalText(TabControl) then
    if pcoTopToBottomText in TabControl.Options then
      Result := raMinus90
    else
      Result := raPlus90
  else
    Result := ra0;
end;

procedure InitializeLineBoundsArray(TabControl: TcxCustomTabControl; var LineIndexBoundsA: TcxPCLineIndexBoundsArray);
var
  LineCount, I: Integer;
  FirstIndex, LastIndex: Integer;
begin
  SetLength(LineIndexBoundsA, TabControl.RowCount);
  if TabControl.RowCount = 0 then
    Exit;
  for LineCount := 0 to TabControl.RowCount - 1 do
    LineIndexBoundsA[LineCount].Left := -1;
  InitializeVisibleTabRange(TabControl, FirstIndex, LastIndex);
  for I := FirstIndex to LastIndex do
    with LineIndexBoundsA[TabControl.FVisibleTabList[I].VisibleRow] do
      if Left = -1 then
      begin
        Left := I;
        Right := I;
      end
      else
      begin
        if I < Left then
          Left := I;
        if I > Right
          then Right := I;
      end;
end;

procedure InitializeVisibleTabRange(TabControl: TcxCustomTabControl; var FirstIndex,
  LastIndex: Integer);
begin
  if TabControl.MultiLine then
  begin
    FirstIndex := 0;
    LastIndex := TabControl.FVisibleTabList.Count - 1;
  end
  else
  begin
    FirstIndex := TabControl.FFirstVisibleTab;
    if TabControl.FFirstVisibleTab = -1 then
      LastIndex := -2
    else
      LastIndex := TabControl.FLastVisibleTab;
  end;
end;

function InternalGetTextRotationAngle(TabControl: TcxCustomTabControl): TcxRotationAngle;
begin
  if TabControl.Painter.IsNativePainting then
    Result := ra0
  else
    Result := GetTextRotationAngle(TabControl);
end;

function InternalIsVerticalText(TabControl: TcxCustomTabControl): Boolean;
begin
  Result := not TabControl.Painter.IsNativePainting and
    IsVerticalText(TabControl);
end;

function InternalGetCursorPos: TPoint;
begin
  GetCursorPos(Result);
end;

function IsBottomToTopAlignment(TabControl: TcxCustomTabControl): Boolean;
begin
  with TabControl do
  begin
    Result := (TabPosition in [tpLeft, tpRight]) and (not Rotate) and
      not(pcoTopToBottomText in Options);
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
    Result := (TabPosition in [tpTop, tpBottom]) and Rotate and
      (pcoTopToBottomText in Options);
  end;
end;

function IsVerticalText(TabControl: TcxCustomTabControl): Boolean;
begin
  with TabControl do
  begin
    Result := (TabPosition in [tpLeft, tpRight]) and (not Rotate);
    Result := Result or (TabPosition in [tpTop, tpBottom]) and Rotate;
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

procedure PrepareBitmap(ABitmap: TBitmap; AParametersSource: TcxCanvas;
  ASize: TSize; ABackgroundColor: TColor);
begin
  ABitmap.Width := ASize.cx;
  ABitmap.Height := ASize.cy;
  with ABitmap.Canvas do
  begin
    Font.Assign(AParametersSource.Font);
    Pen := AParametersSource.Pen;

    Brush := AParametersSource.Brush;
    Brush.Color := ABackgroundColor;
    Brush.Style := bsSolid;
    FillRect(Rect(0, 0, ABitmap.Width, ABitmap.Height));
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

function TextSize(ATab: TcxTab; const AText: string; AFont: TFont = nil): TSize;
begin
  if AFont = nil then
    ATab.ParentControl.PrepareTabCanvasFont(ATab, cxScreenCanvas)
  else
    cxScreenCanvas.Font := AFont;
  Result := cxTextSize(cxScreenCanvas.Handle, AText);
  cxScreenCanvas.Dormant;
end;

procedure ValidateRect(var R: TRect);
begin
  with R do
  begin
    if Right < Left then
      Right := Left;
    if Bottom < Top then
      Bottom := Top;
  end;
end;

function VerifyImageList(Images: TCustomImageList): Boolean;
begin
  Result := (Images <> nil) and (Images.Count > 0);
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
  if Assigned(FOnChange) then
    FOnChange(Self);
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

{ TcxCustomTabControl }

procedure TcxCustomTabControl.ArrowButtonClick(
  NavigatorButton: TcxPCNavigatorButton);
var
  SpecialAlignment: Boolean;
  Direction: Integer;
begin
  if FNavigatorButtonStates[NavigatorButton] = nbsDisabled then Exit;
  SpecialAlignment := IsRightToLeftAlignment(Self) or IsBottomToTopAlignment(Self);
  if (SpecialAlignment and (NavigatorButton = nbTopLeft)) or
     ((not SpecialAlignment) and (NavigatorButton = nbBottomRight)) then
    Direction := 1
  else
    Direction := -1;
  Inc(FFirstVisibleTab, Direction);
  RequestLayout;
end;

procedure TcxCustomTabControl.Calculate;

var
  cTabsDistance: Integer; // c - longitudinal coordinate

  function InitializeVariables: Boolean;
  begin
    FNavigatorButtons := [];
    SynchronizeNavigatorButtons;
    FTabsPosition := FPainter.GetTabsPosition([]);
    Result := FTabsPosition.NormalRowWidth > 0;
    if not Result then Exit;
    cTabsDistance := DistanceGetter(FPainter.GetTabsNormalDistance, not Rotate{along "c" axis});
  end;

  procedure MultiLineCalculate;
  begin
    if not InitializeVariables then Exit;

    PlaceVisibleTabsOnRows(FTabsPosition.NormalRowWidth, cTabsDistance);
    CalculateLongitudinalTabPositions;
    CalculateRowHeight;
    RearrangeRows;
  end;

  procedure NotMultiLineCalculate;

    procedure SetTabRows;
    var
      FirstIndex, LastIndex, I: Integer;
    begin
      InitializeVisibleTabRange(Self, FirstIndex, LastIndex);
      for I := FirstIndex to LastIndex do
        with FVisibleTabList[I] do
        begin
          FRow := 0;
          FVisibleRow := 0;
        end;
    end;

  begin
    FRowCount := 1;
    FTopOrLeftPartRowCount := IfThen(TabPosition in [tpTop, tpLeft], 1, 0);
    CalculateLongitudinalTabPositions;
    if IsTooSmallControlSize then Exit;
    SetTabRows;
    CalculateRowHeight;
    CalculateRowPositions;
  end;

  procedure ResetControlInternalVariables;
  var
    VisibleTabCount: Integer;

    procedure ValidateTabVisibleIndex(var TabVisibleIndex: Integer);
    begin
      if TabVisibleIndex >= VisibleTabCount then
        TabVisibleIndex := -1;
    end;

  begin
    VisibleTabCount := FVisibleTabList.Count;

    FExtendedBottomOrRightTabsRect := cxEmptyRect;
    FExtendedTopOrLeftTabsRect := cxEmptyRect;

    if (FFirstVisibleTab = -1) and (VisibleTabCount > 0) then
      FFirstVisibleTab := 0;
    if FFirstVisibleTab >= VisibleTabCount then
      FFirstVisibleTab := VisibleTabCount - 1;
    FLastVisibleTab := FFirstVisibleTab;

    ValidateTabVisibleIndex(FHotTrackTabVisibleIndex);
    ValidateTabVisibleIndex(FMainTabVisibleIndex);
    ValidateTabVisibleIndex(FPressedTabVisibleIndex);

    FRowCount := 0;

    if FTabIndex >= Tabs.Count then
      FTabIndex := Tabs.Count - 1;

    FTopOrLeftPartRowCount := 0;
  end;

begin
  ResetControlInternalVariables;
  if FVisibleTabList.Count = 0 then
  begin
    InitializeVariables;
    Exit;
  end;
  CalculateTabNormalSizes;
  if MultiLine then
    MultiLineCalculate
  else
    NotMultiLineCalculate;
end;

procedure TcxCustomTabControl.CalculateLongitudinalTabPositions;

  procedure InternalCalculateLongitudinalTabPositions(
    AFirstIndex, ALastIndex: Integer; ACalculateAll: Boolean = False; Row: Integer = 0);
  var
    I: Integer;
    ALineStartPosition, ALineFinishPosition: Integer;
    ATabStartPosition, ATabFinishPosition, ATabWidth: Integer;
    ADistanceBetweenTabs: Integer;
    AIsY: Boolean;
    ASign: Integer;
  begin
    AIsY := TabPosition in [tpLeft, tpRight];
    ALineStartPosition := PointGetter(FTabsPosition.NormalTabsRect.TopLeft, AIsY);
    ASign := 1;
    if IsRightToLeftAlignment(Self) or IsBottomToTopAlignment(Self) then
    begin
      ALineFinishPosition := -ALineStartPosition;
      Inc(ALineStartPosition, FTabsPosition.NormalRowWidth - 1);
      ASign := -1;
    end
    else
      ALineFinishPosition := ALineStartPosition + FTabsPosition.NormalRowWidth - 1;
    ADistanceBetweenTabs := DistanceGetter(FPainter.GetTabsNormalDistance, not Rotate);

    ATabStartPosition := ALineStartPosition;
    ATabFinishPosition := ATabStartPosition;
    for I := AFirstIndex to ALastIndex do
    begin
      FLastVisibleTab := I;
      ATabWidth := FVisibleTabList[I].NormalLongitudinalSize;
      ATabFinishPosition := ATabStartPosition + (ATabWidth - 1) * ASign;
      with FVisibleTabList[I] do
        if ASign > 0 then
          PointSetter(FTabPosition.TabNormalPosition, AIsY, ATabStartPosition)
        else
          PointSetter(FTabPosition.TabNormalPosition, AIsY, ATabFinishPosition);

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

    UpdateTabPosition(GetNavigatorButtons(True));
    if IsTooSmallControlSize then Exit;
    InternalCalculateLongitudinalTabPositions(FFirstVisibleTab, FVisibleTabList.Count - 1, True);

    if not FIsLastTabFullyVisible then
    begin
      FFirstVisibleTab := APrevFirstVisibleTab;

      UpdateTabPosition(GetNavigatorButtons(False));
      if IsTooSmallControlSize then Exit;

      InternalCalculateLongitudinalTabPositions(FFirstVisibleTab, FVisibleTabList.Count - 1);

      if FIsLastTabFullyVisible then
        while FFirstVisibleTab > 0 do
        begin
          Dec(FFirstVisibleTab);
          InternalCalculateLongitudinalTabPositions(FFirstVisibleTab, FVisibleTabList.Count - 1);
          if not FIsLastTabFullyVisible then
          begin
            Inc(FFirstVisibleTab);
            InternalCalculateLongitudinalTabPositions(FFirstVisibleTab, FVisibleTabList.Count - 1);
            Break;
          end;
        end;
    end;
    SynchronizeNavigatorButtons;
    UpdateButtonsState;
  end;

  procedure MultiLineCalculateLongitudinalTabPositions;
  var
    LineFreeSpaceWidth, LineFreeSpaceWidthRest, TotalTabsNormalWidth: Integer;
    LineIndexBoundsA: TcxPCLineIndexBoundsArray;

    procedure StretchTabWidths(Row: Integer);
    var
      I: Integer;
      dTabNormalWidth: Integer;
    begin
      LineFreeSpaceWidthRest := LineFreeSpaceWidth;
      for I := LineIndexBoundsA[Row].Left to LineIndexBoundsA[Row].Right do
      begin
        with FVisibleTabList[I].FTabPosition do
        begin
          if I = LineIndexBoundsA[Row].Right then
            dTabNormalWidth := LineFreeSpaceWidthRest
          else
            dTabNormalWidth := TabNormalWidth * LineFreeSpaceWidth div TotalTabsNormalWidth;
          Dec(LineFreeSpaceWidthRest, dTabNormalWidth);
        end;
        with FVisibleTabList[I] do
          Inc(FTabPosition.TabNormalWidth, dTabNormalWidth);
      end;
    end;

  var
    Row: Integer;
    ToStretchTabs: Boolean;
    ADistanceBetweenTabs: Integer;
  begin
    UpdateTabPosition([]);
    if IsTooSmallControlSize then Exit;
    InitializeLineBoundsA(LineIndexBoundsA, 0, FVisibleTabList.Count - 1);
    ToStretchTabs := not(Rotate or RaggedRight);
    ADistanceBetweenTabs := DistanceGetter(FPainter.GetTabsNormalDistance, not Rotate);
    for Row := 0 to RowCount - 1 do
    begin
      if ToStretchTabs then
      begin
        TotalTabsNormalWidth := GetLineWidth(LineIndexBoundsA, Row, 0);
        LineFreeSpaceWidth := FTabsPosition.NormalRowWidth - GetLineWidth(LineIndexBoundsA, Row, ADistanceBetweenTabs);
        if LineFreeSpaceWidth > 0 then StretchTabWidths(Row);
      end;
      InternalCalculateLongitudinalTabPositions(LineIndexBoundsA[Row].Left, LineIndexBoundsA[Row].Right, False, Row);
    end;
  end;

  procedure SetLongitudinalExtendedTabsRectsBounds;
  begin
    if TabPosition in [tpTop, tpBottom] then
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
  if FVisibleTabList.Count = 0 then
    Exit;
  if FRowCount > 1(*MultiLine*) then
    MultiLineCalculateLongitudinalTabPositions
  else
    NotMultiLineCalculateLongitudinalTabPositions;
  if not IsTooSmallControlSize then
    SetLongitudinalExtendedTabsRectsBounds;
end;

procedure TcxCustomTabControl.CalculateRowHeight;

  function GetMaxWidthTabVisibleIndex: Integer;
  var
    AFirstIndex, ALastIndex, AMaxTabWidth, I: Integer;
  begin
    Result := -1;
    AMaxTabWidth := 0;
    if pcoFixedTabWidthWhenRotated in Options then
    begin
      AFirstIndex := 0;
      ALastIndex := FVisibleTabList.Count - 1;
    end
    else
      InitializeVisibleTabRange(Self, AFirstIndex, ALastIndex);
    for I := AFirstIndex to ALastIndex do
      with FVisibleTabList[I].FTabPosition do
        if TabNormalWidth > AMaxTabWidth then
        begin
          AMaxTabWidth := TabNormalWidth;
          Result := I;
        end;
  end;

var
  AMaxWidthTabVisibleIndex: Integer;
  ATab: TcxTab;
begin
  if Rotate then
  begin
    AMaxWidthTabVisibleIndex := GetMaxWidthTabVisibleIndex;
    if AMaxWidthTabVisibleIndex <> -1 then
    begin
      ATab := FVisibleTabList[AMaxWidthTabVisibleIndex];
      FMaxTabCaptionWidth := TextSize(ATab, ATab.Caption).cx;
      FRowHeight := ATab.FTabPosition.TabNormalWidth;
    end
    else
    begin
      FMaxTabCaptionWidth := 0;
      FRowHeight := 0;
    end;
    if (MaxRotatedTabWidth > 0) and
      (MaxRotatedTabWidth >= FPainter.GetMinTabNormalWidth(-1)) and
      (FRowHeight > MaxRotatedTabWidth) then
        FRowHeight := MaxRotatedTabWidth;
  end
  else
    FRowHeight := Tabs.FTabNormalHeight;
end;

procedure TcxCustomTabControl.CalculateRowPositions;
var
  // c - diametrical coordinate
  cNormalTopBorder, cNormalBottomBorder: Integer;
  cExtendedTopBorder, cExtendedBottomBorder: Integer;
  cTabsDistance: Integer;
  cIsY: Boolean;

  procedure InitializeVariables;
  begin
    cTabsDistance := DistanceGetter(FPainter.GetTabsNormalDistance, Rotate);
    cIsY := TabPosition in [tpTop, tpBottom];
    with FTabsPosition.NormalTabsRect do
    begin
      cNormalTopBorder := PointGetter(TopLeft, cIsY);
      cNormalBottomBorder := PointGetter(BottomRight, cIsY);
    end;
    with FTabsPosition.ExtendedTabsRect do
    begin
      cExtendedTopBorder := PointGetter(TopLeft, cIsY);
      cExtendedBottomBorder := PointGetter(BottomRight, cIsY);
    end;
  end;

  procedure SetDiametricalExtendedTabsRectsBorders;

    procedure SetInternalBorders;
    var
      Border: Integer;
      BottomOrRightPartRowCount: Integer;
    begin
      with FTabsPosition do
      begin
// ExtendedTopOrLeftTabsRectBottomOrRightBorder
        Border := cNormalTopBorder + FTopOrLeftPartRowCount * (FRowHeight + cTabsDistance);
        Dec(Border, cTabsDistance);
        Inc(Border, ExtendedTopOrLeftTabsRectBottomOrRightBorderOffset);

        if Border > cExtendedBottomBorder then Border := cExtendedBottomBorder;
        RectSetter(FExtendedTopOrLeftTabsRect, False, cIsY, Border);

// ExtendedBottomOrRightTabsRectTopOrLeftBorder
        BottomOrRightPartRowCount := RowCount - FTopOrLeftPartRowCount;
        Border := cNormalBottomBorder - BottomOrRightPartRowCount * (FRowHeight + cTabsDistance);
        Inc(Border, cTabsDistance);
        Inc(Border, ExtendedBottomOrRightTabsRectTopOrLeftBorderOffset);

        if Border < cExtendedTopBorder then Border := cExtendedTopBorder;
        RectSetter(FExtendedBottomOrRightTabsRect, True, cIsY, Border);
      end;
    end;

    procedure CorrectSecondaryBorder;
    var
      SecondaryBorderBound: Integer;
    begin
      if TabPosition in [tpTop, tpLeft] then
      begin
        SecondaryBorderBound := PointGetter(FExtendedTopOrLeftTabsRect.BottomRight, cIsY) + FTabsPosition.MinDistanceBetweenTopOrLeftAndBottomOrRightExtendedTabsRects;
        SecondaryBorderBound := Min(SecondaryBorderBound, cExtendedBottomBorder);
        if PointGetter(FExtendedBottomOrRightTabsRect.TopLeft, cIsY) < SecondaryBorderBound then
          RectSetter(FExtendedBottomOrRightTabsRect, True, cIsY, SecondaryBorderBound);
      end
      else
      begin
        SecondaryBorderBound := PointGetter(FExtendedBottomOrRightTabsRect.TopLeft, cIsY) - FTabsPosition.MinDistanceBetweenTopOrLeftAndBottomOrRightExtendedTabsRects;
        SecondaryBorderBound := Max(SecondaryBorderBound, cExtendedTopBorder);
        if PointGetter(FExtendedTopOrLeftTabsRect.BottomRight, cIsY) > SecondaryBorderBound then
          RectSetter(FExtendedTopOrLeftTabsRect, False, cIsY, SecondaryBorderBound);
      end;
    end;

  begin
    RectSetter(FExtendedTopOrLeftTabsRect, True, cIsY, cExtendedTopBorder);
    RectSetter(FExtendedBottomOrRightTabsRect, False, cIsY, cExtendedBottomBorder);
    SetInternalBorders;
    if (FTopOrLeftPartRowCount <> 0) and (FTopOrLeftPartRowCount <> FRowCount) then
      CorrectSecondaryBorder;
  end;

var
  I: Integer;
  c: Integer;
begin
  InitializeVariables;
  for I := 0 to FVisibleTabList.Count - 1 do
    with FVisibleTabList[I] do
    begin
      if FVisibleRow < FTopOrLeftPartRowCount then
        c := cNormalTopBorder + FVisibleRow * (FRowHeight + cTabsDistance)
      else
      begin
        c := cNormalBottomBorder - (RowCount - FVisibleRow) * FRowHeight;
        Dec(c, (RowCount - 1 - FVisibleRow) * cTabsDistance);
      end;
      PointSetter(FTabPosition.TabNormalPosition, cIsY, c);
    end;
  SetDiametricalExtendedTabsRectsBorders;
end;

procedure TcxCustomTabControl.CalculateTabNormalSize(Tab: TcxTab);
begin
  Tab.FTabPosition.TabNormalWidth := FPainter.CalculateTabNormalWidth(Tab);
end;

procedure TcxCustomTabControl.CalculateTabNormalSizes;
var
  I: Integer;
  Tab: TcxTab;
begin
  if Tabs.Count = 0 then
    OutError('CalculateTabNormalSizes', scxPCTabCountEqualsZero);
  Tabs.FTabNormalHeight := FPainter.CalculateTabNormalHeight;
  for I := 0 to Tabs.Count - 1 do
  begin
    Tab := TabsTabs[I];
    if Tab.Visible then
      Tab.FTabPosition.TabNormalWidth := FPainter.CalculateTabNormalWidth(Tab)
    else
      Tab.FTabPosition.TabNormalWidth := 0;
  end;
end;

function TcxCustomTabControl.CanMouseWheel(const AMouseScreenPos: TPoint): Boolean;
var
  R: TRect;
begin
  Result := False;
  if not MultiLine and (FFirstVisibleTab >= 0) then
  begin
    R := FVisibleTabList[FFirstVisibleTab].FullRect;
    with ScreenToClient(AMouseScreenPos) do
      if (TabPosition in [tpTop, tpBottom]) and (Y >= R.Top) and (Y < R.Bottom) or
          (TabPosition in [tpLeft, tpRight]) and (X >= R.Left) and (X < R.Right) then
        Result := True;
  end;
end;

function TcxCustomTabControl.CanPressButton(AButton: TcxPCNavigatorButton): Boolean;
var
  SpecialAlignment: Boolean;
begin
  Result := True;
  case AButton of
    nbTopLeft, nbBottomRight:
      begin
        SpecialAlignment := IsRightToLeftAlignment(Self) or IsBottomToTopAlignment(Self);
        if (SpecialAlignment and (AButton = nbTopLeft)) or
           ((not SpecialAlignment) and (AButton = nbBottomRight)) then
          Result := (FLastVisibleTab < FVisibleTabList.Count - 1) or
            not FIsLastTabFullyVisible and (FLastVisibleTab <> FFirstVisibleTab)
        else
          Result := FFirstVisibleTab > 0;
      end;
    nbClose:
      Result := FMainTabVisibleIndex >= 0;
  end;
end;

procedure TcxCustomTabControl.CloseButtonClick;
begin
  if DoCanClose then
    DoClose;
end;

procedure TcxCustomTabControl.CorrectMaxRotatedTabWidth;
var
  AMinTabNormalWidth: Integer;
begin
  if FMaxRotatedTabWidth > 0 then
  begin
    AMinTabNormalWidth := FPainter.GetMinTabNormalWidth(-1);
    if FMaxRotatedTabWidth < AMinTabNormalWidth then
      FMaxRotatedTabWidth := AMinTabNormalWidth;
  end;
end;

procedure TcxCustomTabControl.CorrectTabRect(TabVisibleIndex: Integer);
begin
  with FVisibleTabList[TabVisibleIndex] do
    FPainter.CorrectTabRect(TabVisibleIndex, FTabPosition.TabRectCorrection);
end;

procedure TcxCustomTabControl.CreateGoDialog;
begin
  if not IsDesigning then
  begin
    FGoDialog := TcxPCGoDialog.Create(Self);
    FGoDialog.OnClick := GoDialogClickEventHandler;
  end;
end;

procedure TcxCustomTabControl.CreateTimer;
begin
  if FTimer = nil then
  begin
    FTimer := TcxTimer.Create(Self);
    FTimer.OnTimer := TimerEventHandler;
  end;
  FTimer.Interval := TabScrollingStartDelay;
  FTimer.Enabled := True;
end;

function TcxCustomTabControl.GetDisplayRect: TRect;
begin
  Result := PageClientRect;
end;

function TcxCustomTabControl.GetImages: TCustomImageList;
begin
  Result := FImages.BaseImages;
end;

function TcxCustomTabControl.GetLineWidth(
  const ALineIndexBoundsA: TcxPCLineIndexBoundsArray;
  ALineNumber, ATabsDistance: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  with ALineIndexBoundsA[ALineNumber] do
  begin
    for I := Left to Right do
      Inc(Result, FVisibleTabList[I].NormalLongitudinalSize);
    Inc(Result, (Right - Left) * ATabsDistance);
  end;
end;

function TcxCustomTabControl.GetMainTabIndex: Integer;
begin
  Result := -1;
  if FMainTabVisibleIndex <> -1 then
    Result := FVisibleTabList[FMainTabVisibleIndex].Index;
end;

function TcxCustomTabControl.GetMaxRotatedTabWidth: Integer;
begin
  CorrectMaxRotatedTabWidth;
  Result := FMaxRotatedTabWidth;
end;

function TcxCustomTabControl.GetNavigatorButton(
  NavigatorButtonIndex: TcxPCNavigatorButtonIndex): TcxPCNavigatorButton;
var
  FirstNavigatorButton, LastNavigatorButton, NavigatorButton: TcxPCNavigatorButton;
begin
  Result := Low(TcxPCNavigatorButton);
  FirstNavigatorButton := Low(TcxPCNavigatorButton);
  LastNavigatorButton := High(NavigatorButton);
  for NavigatorButton := FirstNavigatorButton to LastNavigatorButton do
    if NavigatorButton in NavigatorButtonIndex then
    begin
      Result := NavigatorButton;
      Break;
    end;
end;

function TcxCustomTabControl.GetNavigatorButtons(OnlyObligatoryButtons: Boolean): TcxPCNavigatorButtons;
begin
  Result := [];
  if MultiLine then
    Exit;
  if pcoCloseButton in Options then
    Include(Result, nbClose);
  if not OnlyObligatoryButtons and not (pcoNoArrows in Options) then
    Result := Result + [nbTopLeft, nbBottomRight];
  if (pcoGoDialog in Options) and
    (not OnlyObligatoryButtons or (pcoAlwaysShowGoDialogButton in Options)) then
      Include(Result, nbGoDialog);
end;

function TcxCustomTabControl.GetOptions: TcxPCOptions;
begin
  Result := FOptions;
end;

function TcxCustomTabControl.GetPageClientRect: TRect;
begin
  Result := FPainter.GetClientRect;
end;

function TcxCustomTabControl.GetPageClientRectOffset: TRect;
begin
  Result := FPainter.GetClientRectOffset;
end;

function TcxCustomTabControl.GetStyle: TcxPCStyleID;
begin
  Result := FStyle;
end;

function TcxCustomTabControl.GetTabExtendedTabsRect(TabVisibleIndex: Integer): TRect;
begin
  if FVisibleTabList[TabVisibleIndex].VisibleRow < TopOrLeftPartRowCount then
    Result := FExtendedTopOrLeftTabsRect
  else
    Result := FExtendedBottomOrRightTabsRect
end;

function TcxCustomTabControl.GetTabsTab(TabIndex: Integer): TcxTab;
begin
  Result := Tabs.Tabs[TabIndex];
end;

procedure TcxCustomTabControl.InitializeLineBoundsA(var ALineIndexBoundsA: TcxPCLineIndexBoundsArray; AFirstIndex, ALastIndex: Integer);
var
  I, ALineIndex: Integer;
  AFirstRow, ARowCount: Integer;
begin
  AFirstRow := FVisibleTabList[AFirstIndex].FRow;
  ARowCount := FVisibleTabList[ALastIndex].FRow - AFirstRow + 1;
  SetLength(ALineIndexBoundsA, ARowCount);
  ALineIndex := 0;
  ALineIndexBoundsA[0].Left := AFirstIndex;
  for I := AFirstIndex to ALastIndex do
    if FVisibleTabList[I].FRow - AFirstRow > ALineIndex then
    begin
      ALineIndexBoundsA[ALineIndex].Right := I - 1;
      Inc(ALineIndex);
      ALineIndexBoundsA[ALineIndex].Left := I;
    end;
  ALineIndexBoundsA[ALineIndex].Right := ALastIndex;
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
    Result := DisplayRect;
    ValidateRect(Result);
  end;
end;

function TcxCustomTabControl.InternalGetShiftState: TShiftState;
var
  AKeyState: TKeyBoardState;
begin
  GetKeyboardState(AKeyState);
  Result := KeyboardStateToShiftState(AKeyState);
end;

procedure TcxCustomTabControl.InternalInvalidateRect(Rect: TRect);
begin
  InvalidateRect(Rect, False);
end;

function TcxCustomTabControl.IsTooSmallControlSize: Boolean;
begin
  Result := FTabsPosition.NormalRowWidth <= 0;
end;

function TcxCustomTabControl.PassDesignMouseEvent(X, Y: Integer): Boolean;
var
  NavigatorButton: TcxPCNavigatorButton;
  PressedTabVisibleIndex: Integer;
begin
  Result := FPainter.IsOverButton(X, Y, NavigatorButton) and not (NavigatorButton in [nbGoDialog, nbClose]);
  if not Result then
  begin
    PressedTabVisibleIndex := VisibleIndexOfTabAt(X, Y);
    Result := (PressedTabVisibleIndex <> -1) and (PressedTabVisibleIndex <> FMainTabVisibleIndex);
  end;
end;

procedure TcxCustomTabControl.PlaceVisibleTabsOnRows(ATabsWidth, ATabsDistance: Integer);

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
    ACurrentRow := FVisibleTabList[ALineBoundsA[0].Left].FRow;
    for ARow := 0 to Length(ALineBoundsA) - 1 do
    begin
      for I := ALineBoundsA[ARow].Left to ALineBoundsA[ARow].Right do
        FVisibleTabList[I].FRow := ACurrentRow;
      Inc(ACurrentRow);
    end;
  end;

  procedure ImproveTabsLayout(AFirstIndex, ALastIndex: Integer);
  var
    ALineIndexBoundsA: TcxPCLineIndexBoundsArray;
  begin
    if Rotate and RaggedRight then Exit;
    InitializeLineBoundsA(ALineIndexBoundsA, AFirstIndex, ALastIndex);
    InternalImproveTabsLayout(ALineIndexBoundsA);
    AcceptImprovements(ALineIndexBoundsA);
  end;

var
  AFirstIndex: Integer;
  c: Integer;
  I: Integer;
  ATab: TcxTab;
begin
  FRowCount := 1;
  AFirstIndex := 0;
  c := 0;
  for I := 0 to FVisibleTabList.Count - 1 do
  begin
    ATab := FVisibleTabList[I];
    if ATab.NormalLongitudinalSize >= ATabsWidth then
    begin
      if c <> 0 then
      begin
        Inc(FRowCount);
        c := 0;
      end;
      if (I > AFirstIndex{guarantees that FVisibleTabList[AFirstIndex].FRow had been set}) and
        ((FRowCount - 1) - FVisibleTabList[AFirstIndex].FRow > 1) then
        ImproveTabsLayout(AFirstIndex, I - 1);
      AFirstIndex := I + 1;
      if (not Rotate) and (ATabsWidth > FPainter.GetMinTabNormalWidth(I)) then
        ATab.FTabPosition.TabNormalWidth := ATabsWidth;
      ATab.FRow := FRowCount - 1;
      if I <> FVisibleTabList.Count - 1 then
        Inc(FRowCount);
    end
    else
      if c + ATab.NormalLongitudinalSize > ATabsWidth then
      begin
        Inc(FRowCount);
        ATab.FRow := FRowCount - 1;
        c := ATab.NormalLongitudinalSize + ATabsDistance;
      end else
      begin
        ATab.FRow := FRowCount - 1;
        Inc(c, ATab.NormalLongitudinalSize + ATabsDistance);
      end;
  end;
  if (FVisibleTabList.Count - 1 > AFirstIndex) and ((FRowCount - 1) - FVisibleTabList[AFirstIndex].FRow > 0) then
    ImproveTabsLayout(AFirstIndex, FVisibleTabList.Count - 1);
end;

procedure TcxCustomTabControl.PrepareImagesBitmapBackground(ABitmap: TBitmap);
begin
  Painter.PrepareTabControlImagesBitmapBackground(ABitmap);
end;

procedure TcxCustomTabControl.RearrangeRows;

  function IsRowNumbersCorrectionNeeded: Boolean;
  begin
    if TabPosition in [tpBottom, tpTop] then
    begin
      Result := Rotate and not(pcoTopToBottomText in Options);
      if TabPosition = tpBottom then Result := not Result;
    end else
    begin
      Result := (not Rotate) and (pcoTopToBottomText in Options);
      if TabPosition = tpRight then Result := not Result;
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
      for I := 0 to FVisibleTabList.Count - 1 do
        with FVisibleTabList[I] do
          FVisibleRow := RowCount - 1 - FRow
    else
      for I := 0 to FVisibleTabList.Count - 1 do
        with FVisibleTabList[I] do
          FVisibleRow := FRow;
  end;

  procedure ConvertRelativeNumbersToConvenientNumbers;
  var
    I: Integer;
  begin
    if TabPosition in [tpRight, tpBottom] then
    begin
      for I := 0 to FVisibleTabList.Count - 1 do
        with FVisibleTabList[I] do
          FVisibleRow := RowCount - 1 - FVisibleRow;
      FTopOrLeftPartRowCount := FRowCount - FTopOrLeftPartRowCount;
    end
  end;

var
  I: Integer;
  dRow: Integer;
  ARelativeTopPartRowCount: Integer;
begin
  ConvertRowNumbersToNumbersRelativeToTabPosition;
  ARelativeTopPartRowCount := RowCount;

  if FMainTabVisibleIndex <> -1 then
    if ScrollOpposite then
      ARelativeTopPartRowCount := FVisibleTabList[FMainTabVisibleIndex].FVisibleRow + 1
    else
      if FPainter.IsMainTabBoundWithClient then
      begin
        dRow := RowCount - 1 - FVisibleTabList[FMainTabVisibleIndex].FVisibleRow;
        for I := 0 to FVisibleTabList.Count - 1 do
          with FVisibleTabList[I] do
            if RowCount = 0 then
              FVisibleRow := 0
            else
              FVisibleRow := (FVisibleRow + dRow) mod RowCount;
      end;

  FTopOrLeftPartRowCount := ARelativeTopPartRowCount;
  ConvertRelativeNumbersToConvenientNumbers;
  CalculateRowPositions;
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

procedure TcxCustomTabControl.RepaintTab(TabVisibleIndex: Integer; TabPropertyChanged: TcxPCTabPropertyChanged);
begin
  FPainter.RepaintTab(TabVisibleIndex, TabPropertyChanged);
end;

procedure TcxCustomTabControl.SelectTab(ATabVisibleIndex: Integer; AAddToSelected: Boolean);
var
  ALink: TcxObjectLink;
begin
  ALink := cxAddObjectLink(Self);
  try
    if MultiSelect and FPainter.IsMultiSelectionAccepted and AAddToSelected then
    begin
      if ATabVisibleIndex = FMainTabVisibleIndex then
        TabIndex := -1
      else
        FVisibleTabList[ATabVisibleIndex].Selected := not FVisibleTabList[ATabVisibleIndex].Selected;
    end
    else
    begin
      TabIndex := FVisibleTabList[ATabVisibleIndex].Index;
      if ALink.Ref <> nil then
        SetModified;
    end;
  finally
    cxRemoveObjectLink(ALink);
  end;
end;

procedure TcxCustomTabControl.SetHideTabs(const Value: Boolean);
begin
  if Value <> FHideTabs then
  begin
    FHideTabs := Value;
    Invalidate;
    Realign;
  end;
end;

procedure TcxCustomTabControl.SetHotTrack(Value: Boolean);
begin
  if Value <> FHotTrack then
  begin
    FHotTrack := Value;
    SynchronizeHotTrackStates(InternalGetShiftState);
  end;
end;

procedure TcxCustomTabControl.SetImageBorder(const Value: Integer);
begin
  if (Value >= 0) and (Value <> FImageBorder) then
  begin
    FImageBorder := Value;
    if FVisibleTabList.Count > 0 then RequestLayout;
  end;
end;

procedure TcxCustomTabControl.SetImages(const Value: TCustomImageList);
begin
  FImages.BaseImages := Value;
end;

procedure TcxCustomTabControl.SetIsTabsContainer(Value: Boolean);
begin
  if Value <> FIsTabsContainer then
  begin
    FIsTabsContainer := Value;
    RequestLayout;
  end;
end;

procedure TcxCustomTabControl.SetMaxRotatedTabWidth(Value: Integer);
begin
  if Value < 0 then
    Value := 0;
  if (Value > 0) and (Value < FPainter.GetMinTabNormalWidth(-1)) then
    Value := FPainter.GetMinTabNormalWidth(-1);
  if Value <> FMaxRotatedTabWidth then
  begin
    FMaxRotatedTabWidth := Value;
    if Rotate and (FVisibleTabList.Count > 0) then RequestLayout;
  end;
end;

procedure TcxCustomTabControl.SetMultiLine(const Value: Boolean);
begin
  if Value <> FMultiLine then
  begin
    FMultiLine := Value;
    RequestLayout;
  end;
end;

procedure TcxCustomTabControl.SetMultiSelect(const Value: Boolean);
begin
  FMultiSelect := Value;
end;

procedure TcxCustomTabControl.SetNavigatorPosition(
  const Value: TcxPCNavigatorPosition);
begin
  if Value <> FNavigatorPosition then
  begin
    FNavigatorPosition := Value;
    RequestLayout;
  end;
end;

procedure TcxCustomTabControl.SetOptions(Value: TcxPCOptions);
const
  GraphicOptions: TcxPCOptions = [pcoGradient, pcoGradientClientArea,
    pcoUsePageColorForTab];
  LayoutOptions: TcxPCOptions = [
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
    if AChangedOptions * LayoutOptions <> [] then
      RequestLayout
    else
      if AChangedOptions * GraphicOptions <> [] then
        Invalidate;
  end;
end;

procedure TcxCustomTabControl.SetOwnerDraw(const Value: Boolean);
begin
  if Value <> FOwnerDraw then
  begin
    FOwnerDraw := Value;
    Invalidate;
  end;
end;

procedure TcxCustomTabControl.SetRaggedRight(const Value: Boolean);
begin
  if Value <> FRaggedRight then
  begin
    FRaggedRight := Value;
    if MultiLine then
      RequestLayout;
  end;
end;

procedure TcxCustomTabControl.SetRotate(const Value: Boolean);
begin
  if not FPainter.AllowRotate and Value then
    raise EdxException.Create(Format(scxPCAllowRotateError, [FPainter.GetStyleName]));
  if Value <> FRotate then
  begin
    FRotate := Value;
    RequestLayout;
  end;
end;

procedure TcxCustomTabControl.SetScrollOpposite(const Value: Boolean);
begin
  if Value <> FScrollOpposite then
  begin
    FScrollOpposite := Value;
    if MultiLine then
      if FMainTabVisibleIndex <> -1 then
      begin
        RearrangeRows;
        Realign;
        Invalidate;
      end
      else
        Realign;
  end;
end;

procedure TcxCustomTabControl.SetShowFrame(const Value: Boolean);
begin
  if Value <> FShowFrame then
  begin
    FShowFrame := Value;
    RequestLayout;
  end;
end;

procedure TcxCustomTabControl.SetStyle(const Value: TcxPCStyleID);
var
  NewPainterClass: TcxPCPainterClass;
begin
  if Value = cxPCDefaultStyle then
  begin
    FStyle := cxPCDefaultStyle;
    SetDefaultStyle;
  end
  else
  begin
    if Style = Value then
      Exit;
    NewPainterClass := PaintersFactory.GetPainterClass(Value);
    if NewPainterClass = nil then
      Exit;
    FStyle := Value;
    if (FPainter = nil) or (NewPainterClass <> FPainter.ClassType) then
    begin
      PaintersFactory.FreePainterInstance(FPainter);
      FPainter := PaintersFactory.GetPainterInstance(NewPainterClass, Self);
      if Rotate and not FPainter.AllowRotate then
        Rotate := False;
      DoubleBuffered := FPainter.NeedDoubleBuffer;
      Tabs.ResetTabVerticalTextBitmaps;
      RequestLayout;
      InvalidateWithChildren;
    end;
  end;
end;

procedure TcxCustomTabControl.SetTabCaptionAlignment(Value: TAlignment);
begin
  if Value <> FTabCaptionAlignment then
  begin
    FTabCaptionAlignment := Value;
    RequestLayout;
  end;
end;

procedure TcxCustomTabControl.SetTabHeight(const Value: Smallint);
begin
  if Value <> FTabSize.Y then
  begin
    FTabSize.Y := Value;
    RequestLayout;
  end;
end;

procedure TcxCustomTabControl.SetTabIndex(Value: Integer);

  procedure UnselectTabs;
  var
    I: Integer;
  begin
    FTabIndex := -1;
    Tabs.SetMainTab;
    for I := 0 to Tabs.Count - 1 do
      TabsTabs[I].Selected := False;
  end;

begin
  if IsLoading then
  begin
    FTabIndex := Value;
    Exit;
  end;
  if (Value <> -1) and (Value < 0) or (Value >= Tabs.Count) then Exit;
  if (Value <> -1) and TabIndexTabMustBeVisible and (not TabsTabs[Value].Visible) then Value := -1;
  if Value = FTabIndex then Exit;
  if not CanChange(Value) then Exit;

  UnselectTabs;
  Tabs.SetTracking(-1);
  FTabIndex := Value;
  Tabs.SetMainTab;

  if (FMainTabVisibleIndex <> -1) and not MultiLine then
    CorrectFirstVisibleTab(FMainTabVisibleIndex);

  if MultiLine then
  begin
    RearrangeRows;
    Realign;
    Invalidate;
  end
  else
//    if Value <> -1 then
    RequestLayout;
  UpdateButtonsState;
  SynchronizeHotTrackStates(InternalGetShiftState);

  Change;
end;

procedure TcxCustomTabControl.SetTabPosition(const Value: TcxTabPosition);
begin
  if Value <> FTabPosition then
  begin
    FTabPosition := Value;
    RequestLayout;
  end;
end;

procedure TcxCustomTabControl.SetTabs(const Value: TcxTabs);
begin
  FTabs.Assign(Value);
end;

procedure TcxCustomTabControl.SetTabSlants(Value: TcxTabSlants);
begin
  FTabSlants.Assign(Value);
end;

procedure TcxCustomTabControl.SetTabsTab(TabIndex: Integer;
  const Value: TcxTab);
begin
  Tabs.Tabs[TabIndex] := Value;
end;

procedure TcxCustomTabControl.SetTabWidth(const Value: Smallint);
begin
  if Value <> FTabSize.X then
  begin
    FTabSize.X := Value;
    RequestLayout;
  end;
end;

procedure TcxCustomTabControl.SynchronizeHotTrackStates(Shift: TShiftState);

  procedure ChangeHotTrackNavigatorButton(NewHotTrackNavigatorButton: TcxPCNavigatorButtonIndex);
  var
    OldHotTrackNavigatorButton: TcxPCNavigatorButtonIndex;
    NavigatorButton: TcxPCNavigatorButton;
  begin
    OldHotTrackNavigatorButton := FHotTrackNavigatorButton;
    FHotTrackNavigatorButton := NewHotTrackNavigatorButton;
    if OldHotTrackNavigatorButton <> [] then
    begin
      NavigatorButton := GetNavigatorButton(OldHotTrackNavigatorButton);
      FNavigatorButtonStates[NavigatorButton] := nbsNormal;
      FPainter.RepaintButton(NavigatorButton, nbsHotTrack);
    end;
    if NewHotTrackNavigatorButton <> [] then
    begin
      NavigatorButton := GetNavigatorButton(NewHotTrackNavigatorButton);
      FNavigatorButtonStates[NavigatorButton] := nbsHotTrack;
      FPainter.RepaintButton(NavigatorButton, nbsNormal);
    end;
  end;

var
  MousePos: TPoint;
  NewHotTrackTabVisibleIndex: Integer;
  NewHotTrackNavigatorButton: TcxPCNavigatorButtonIndex;
  NavigatorButton: TcxPCNavigatorButton;
begin
  if [csDesigning, csLoading, csDestroying] * ComponentState <> [] then Exit;
  if not HandleAllocated then Exit;
  if FIsGoDialogShowing then Exit;
  MousePos := ScreenToClient(InternalGetCursorPos);

  NewHotTrackTabVisibleIndex := -1;
  NewHotTrackNavigatorButton := [];
  if (HotTrack or Painter.IsEnableHotTrack) and Enabled then
    if not (ssLeft in Shift) and FPainter.IsOverButton(MousePos.X, MousePos.Y, NavigatorButton) and
       (not (FNavigatorButtonStates[NavigatorButton] in [nbsDisabled, nbsPressed])) then
      NewHotTrackNavigatorButton := [NavigatorButton]
    else
      if not (ssLeft in Shift) or not Painter.IsTabPressable then
      begin
        NewHotTrackTabVisibleIndex := VisibleIndexOfTabAt(MousePos.X, MousePos.Y);
        if (NewHotTrackTabVisibleIndex <> -1) and (not FVisibleTabList[NewHotTrackTabVisibleIndex].Enabled) then
          NewHotTrackTabVisibleIndex := -1;
      end;
  if NewHotTrackNavigatorButton <> FHotTrackNavigatorButton then
    ChangeHotTrackNavigatorButton(NewHotTrackNavigatorButton);
  Tabs.SetHotTrack(NewHotTrackTabVisibleIndex);
end;

procedure TcxCustomTabControl.SynchronizeNavigatorButtons;
begin
  if (FHotTrackNavigatorButton <> []) and
     (FHotTrackNavigatorButton * FNavigatorButtons = []) then
  begin
    FNavigatorButtonStates[GetNavigatorButton(FHotTrackNavigatorButton)] := nbsNormal;
    FHotTrackNavigatorButton := [];
  end;

  if (FPressedNavigatorButton <> []) and
     (FPressedNavigatorButton * FNavigatorButtons = []) then
  begin
    FNavigatorButtonStates[GetNavigatorButton(FPressedNavigatorButton)] := nbsNormal;
    FPressedNavigatorButton := [];
  end;
end;

procedure TcxCustomTabControl.SynchronizeTabImagesRotationAngle;
var
  ATextRotationAngle: TcxRotationAngle;
begin
  ATextRotationAngle := InternalGetTextRotationAngle(Self);
  if VerifyImageList(Images) then
    FImages.ImageRotationAngle := ATextRotationAngle;
end;

procedure TcxCustomTabControl.TabSlantsChanged(Sender: TObject);
begin
  RequestLayout;  
end;

procedure TcxCustomTabControl.TimerEventHandler(Sender: TObject);
begin
  FTimer.Interval := TabScrollingDelay;
  if FPressedNavigatorButton <> [] then
  begin
    ArrowButtonClick(GetNavigatorButton(FPressedNavigatorButton));
    if FPressedNavigatorButton <> [] then Exit;
  end;
  FTimer.Enabled := False;
end;

procedure TcxCustomTabControl.UpdateButtonsState;

  procedure InternalUpdateButtonState(AButton: TcxPCNavigatorButton);
  var
    ANewButtonState, APrevButtonState: TcxPCNavigatorButtonState;
  begin
    if not (AButton in FNavigatorButtons) then
      Exit;
    APrevButtonState := FNavigatorButtonStates[AButton];
    ANewButtonState := APrevButtonState;
    if CanPressButton(AButton) then
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
        FHotTrackNavigatorButton := [];
        FPressedNavigatorButton := [];
      end;
      FNavigatorButtonStates[AButton] := ANewButtonState;
      FPainter.RepaintButton(AButton, APrevButtonState);
      SynchronizeHotTrackStates(InternalGetShiftState);
    end;
  end;

var
  AButton: TcxPCNavigatorButton;
begin
  for AButton := Low(TcxPCNavigatorButton) to High(TcxPCNavigatorButton) do
    if AButton <> nbGoDialog then
      InternalUpdateButtonState(AButton);
end;

procedure TcxCustomTabControl.UpdateTabPosition(ANavigatorButtons: TcxPCNavigatorButtons);
begin
  FNavigatorButtons := ANavigatorButtons;
  FTabsPosition := FPainter.GetTabsPosition(ANavigatorButtons);
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
    if InternalKeyDown(Message.CharCode, KeyDataToShiftState(Message.KeyData)) then
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
  Tabs.ResetTabVerticalTextBitmaps;
  Invalidate;
end;

procedure TcxCustomTabControl.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  SynchronizeHotTrackStates(InternalGetShiftState);
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
  FVisibleTabList := TcxVisibleTabList.Create(Self);
  Width := 289;

  Height := 193;

  FFirstVisibleTab := -1;
  FLastVisibleTab := -1;

  FFocusable := True;
  FHotTrackNavigatorButton := [];
  FHotTrackTabVisibleIndex := -1;
  FImageBorder := 0;
  FIsGoDialogShowing := False;

  FNavigatorPosition := npRightTop;
  FPressedNavigatorButton := [];
  FPressedTabVisibleIndex := -1;
  FMouseDownTabVisibleIndex := -1;
  FMainTabVisibleIndex := -1;
  FOptions := cxPCDefaultOptions;
  FTabCaptionAlignment := taCenter;
  FTabIndex := -1;
  FTabSlants := TcxTabSlants.Create(Self);
  FTabSlants.OnChange := TabSlantsChanged;
  FTimer := nil;
  FTracking := -1;
  FUpdating := False;
  TabStop := True;

  FImages := TcxPCImageList.Create(Self);
  FImages.OnChange := ImageListChange;
  FImages.OnPrepareBitmapBackground := PrepareImagesBitmapBackground;
  FTabs := TcxTabs.Create(Self);
  Style := cxPCDefaultStyle;

  CreateGoDialog;
end;

destructor TcxCustomTabControl.Destroy;
begin
  FreeAndNil(FTabSlants);
  FreeAndNil(FTimer);
  FreeAndNil(FGoDialog);
  FImages.Free;
  FTabs.Free;
  PaintersFactory.FreePainterInstance(FPainter);
  FVisibleTabList.Free;
  inherited Destroy;
end;

function TcxCustomTabControl.CanFocus: Boolean;
begin
  Result := inherited CanFocus and FFocusable;
end;

function TcxCustomTabControl.GetOptimalSize: Integer;
var
  ADistanceBetweenTabs, ATabFinishPosition, ATabStartPosition, ATabWidth, I: Integer;
  AIsY: Boolean;
  ALineFinishPosition, ALineStartPosition: Integer;
begin
  Result := 0;
  if VisibleTabList.Count = 0 then
    Exit;
  CalculateTabNormalSizes;
  UpdateTabPosition(GetNavigatorButtons(True));

  AIsY := TabPosition in [tpLeft, tpRight];
  ALineStartPosition := PointGetter(FTabsPosition.NormalTabsRect.TopLeft, AIsY);
  ALineFinishPosition := ALineStartPosition + FTabsPosition.NormalRowWidth - 1;
  ADistanceBetweenTabs := DistanceGetter(FPainter.GetTabsNormalDistance, not Rotate);

  ATabStartPosition := ALineStartPosition;
  ATabFinishPosition := ATabStartPosition;
  for I := 0 to VisibleTabList.Count - 1 do
  begin
    ATabWidth := FVisibleTabList[I].NormalLongitudinalSize;
    ATabFinishPosition := ATabStartPosition + ATabWidth - 1;
    ATabStartPosition := ATabFinishPosition + 1 + ADistanceBetweenTabs;
  end;
  FIsLastTabFullyVisible := (ATabFinishPosition <= ALineFinishPosition);

  if TabPosition in [tpTop, tpBottom] then
    Result := ATabFinishPosition + 1 + (Width - 1 - ALineFinishPosition)
  else
    Result := ATabFinishPosition + 1 + (Height - 1 - ALineFinishPosition);
end;

procedure TcxCustomTabControl.GetTabOrderList(List: TList);
begin
  inherited GetTabOrderList(List);
  if not FFocusable then
    List.Remove(Self);
end;

function TcxCustomTabControl.IndexOfTabAt(X, Y: Integer): Integer;
begin
  Result := VisibleIndexOfTabAt(X, Y);
  if Result <> -1 then
    Result := VisibleTabList[Result].Index;
end;

function TcxCustomTabControl.VisibleIndexOfTabAt(X, Y: Integer): Integer;
var
  AFirstIndex, ALastIndex, I: Integer;
begin
  Result := -1;
  InitializeVisibleTabRange(Self, AFirstIndex, ALastIndex);
  for I := AFirstIndex to ALastIndex do
    with FVisibleTabList[I] do
      if PtInRect(VisibleRect, Point(X, Y)) and FPainter.IsOverTab(I, X, Y) then
      begin
        Result := I;
        Break;
      end;
end;

procedure TcxCustomTabControl.ScrollTabs(Delta: Integer);
var
  I: Integer;
begin
  if not FMultiLine then
  begin
    for I := 0 to Abs(Delta) - 1 do
      if Delta < 0 then
        ArrowButtonClick(nbTopLeft)
      else
        ArrowButtonClick(nbBottomRight);
  end;
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
  begin
    FStyle := cxPCDefaultStyle;
    SetDefaultStyle;
  end
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

function TcxCustomTabControl.CanFocusOnClick: Boolean;
var
  ATabIndex: Integer;
begin
  Result := inherited CanFocusOnClick;
  if Result then
  begin
    with ScreenToClient(GetMouseCursorPos) do
      ATabIndex := VisibleIndexOfTabAt(X, Y);
    Result := (ATabIndex <> -1) and (VisibleTabList.Tabs[ATabIndex].Index = TabIndex);
  end;
end;

procedure TcxCustomTabControl.ChangeScale(M, D: Integer);
begin
  FClientRect.Left := MulDiv(FClientRect.Left, M, D);
  FClientRect.Top := MulDiv(FClientRect.Top, M, D);
  FClientRect.Right := MulDiv(FClientRect.Right, M, D);
  FClientRect.Bottom := MulDiv(FClientRect.Bottom, M, D);
  inherited;
end;

procedure TcxCustomTabControl.AfterPaintTab(ACanvas: TcxCanvas; ATab: TcxTab;
  AImageAndTextData: TcxPCOutTabImageAndTextData);
begin
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

function TcxCustomTabControl.DoCanClose: Boolean;
begin
  Result := True;
  if Assigned(FOnCanClose) then
    FOnCanClose(Self, Result);
end;

procedure TcxCustomTabControl.DoClose;
begin
  Tabs.Delete(TabIndex);
  Change;
end;

procedure TcxCustomTabControl.DoDrawTabEx(ATabVisibleIndex: Integer;
  AFont: TFont);
begin
  if Assigned(FOnDrawTabEx) then
    FOnDrawTabEx(Self, VisibleTabList[ATabVisibleIndex], AFont);
end;

function TcxCustomTabControl.DoMouseWheelDown(Shift: TShiftState;
   MousePos: TPoint): Boolean;
begin
  Result := CanMouseWheel(MousePos);
  if Result then
    ScrollTabs(1);
end;

function TcxCustomTabControl.DoMouseWheelUp(Shift: TShiftState;
   MousePos: TPoint): Boolean;
begin
  Result := CanMouseWheel(MousePos);
  if Result then
    ScrollTabs(-1);
end;

procedure TcxCustomTabControl.EraseBackground(DC: HDC);
begin
  Canvas.SaveDC;
  try
    Canvas.Canvas.Handle := DC;
    Painter.FillTabPaneContent;
  finally
    Canvas.RestoreDC;
  end;
end;

procedure TcxCustomTabControl.FocusChanged;
begin
  inherited FocusChanged;
  if not IsDestroying and (FMainTabVisibleIndex <> -1) and
    FVisibleTabList[FMainTabVisibleIndex].RealVisible then
      FPainter.RepaintTab(FMainTabVisibleIndex, tpcFocused);
end;

procedure TcxCustomTabControl.FontChanged;
begin
  inherited FontChanged;
  RequestLayout;
end;

function TcxCustomTabControl.HandleDialogChar(Key: Integer): Boolean;
var
  I: Integer;
  Tab: TcxTab;
begin
  Result := False;
  for I := 0 to Tabs.Count - 1 do
  begin
    Tab := TabsTabs[I];
    if IsAccel(Key, Tab.Caption) and CanShowTab(I) and inherited CanFocus then
    begin
      Result := True;
      TabIndex := Tab.Index;
      Break;
    end;
  end;
end;

function TcxCustomTabControl.HasBackground: Boolean;
begin
  Result := False;
end;

procedure TcxCustomTabControl.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  InternalKeyDown(Key, Shift);
end;

procedure TcxCustomTabControl.Loaded;
var
  OldTabIndex: Integer;
begin
  inherited Loaded;
  Tabs.Changed;
  if TabIndex <> -1 then
  begin
    OldTabIndex := FTabIndex;
    FTabIndex := -1;
    LockChangeEvent(True);
    try
      TabIndex := OldTabIndex;
    finally
      LockChangeEvent(False);
    end;
  end;
end;

procedure TcxCustomTabControl.LookAndFeelChanged(Sender: TcxLookAndFeel;
  AChangedValues: TcxLookAndFeelValues);
begin
  inherited LookAndFeelChanged(Sender, AChangedValues);
  SetDefaultStyle;
  RequestLayout;
  if lfvNativeStyle in AChangedValues then
    InvalidateWithChildren;
end;

procedure TcxCustomTabControl.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

  procedure NavigatorButtonDown(ANavigatorButton: TcxPCNavigatorButton);
  var
    APrevButtonState: TcxPCNavigatorButtonState;
  begin
    APrevButtonState := FNavigatorButtonStates[ANavigatorButton];
    if APrevButtonState in [nbsPressed, nbsDisabled] then Exit;

    FNavigatorButtonStates[ANavigatorButton] := nbsPressed;
    FPressedNavigatorButton := [ANavigatorButton];
    FPainter.RepaintButton(ANavigatorButton, APrevButtonState);

    if ANavigatorButton in [nbTopLeft, nbBottomRight] then
    begin
      ArrowButtonClick(ANavigatorButton);
      if FPressedNavigatorButton = [ANavigatorButton] then
        CreateTimer;
    end;
  end;

var
  ANavigatorButton: TcxPCNavigatorButton;
  AGoDialogJustClosed: Boolean;
begin
  AGoDialogJustClosed := FGoDialogJustClosed;
  FGoDialogJustClosed := False;
  inherited MouseDown(Button, Shift, X, Y);
  if not IsDesigning and (HideTabs or (Button <> mbLeft)) then
    Exit;

  SynchronizeHotTrackStates(Shift);

  if FPainter.IsOverButton(X, Y, ANavigatorButton) then
  begin
    if not AGoDialogJustClosed or (ANavigatorButton <> nbGoDialog) then
      NavigatorButtonDown(ANavigatorButton)
  end
  else
    TabDown(VisibleIndexOfTabAt(X, Y), Shift);
end;

procedure TcxCustomTabControl.MouseLeave(AControl: TControl);
begin
  inherited MouseLeave(AControl);
  if not FIsGoDialogShowing then
    SynchronizeHotTrackStates([]);
end;

procedure TcxCustomTabControl.MouseMove(Shift: TShiftState; X, Y: Integer);

  procedure ReleaseNavigatorButton;
  var
    NavigatorButton, NavigatorButton1: TcxPCNavigatorButton;
  begin
    if FTimer <> nil then
    begin
      FTimer.Enabled := False;
      for NavigatorButton := nbTopLeft to nbBottomRight do
        if FNavigatorButtonStates[NavigatorButton] = nbsPressed then
        begin
          if FPainter.IsOverButton(X, Y, NavigatorButton1) and
             (NavigatorButton = NavigatorButton1) and (HotTrack or Painter.IsEnableHotTrack) then
            FNavigatorButtonStates[NavigatorButton] := nbsHotTrack
          else
            FNavigatorButtonStates[NavigatorButton] := nbsNormal;
          UpdateButtonsState;
          FPainter.RepaintButtonsRegion;
        end;
    end;
  end;

var
  NavigatorButton: TcxPCNavigatorButton;
  TabVisibleIndex: Integer;
  OldPressedTabVisibleIndex: Integer;
  IsOverNavigatorButton: Boolean;
  PressedNavigatorButton: TcxPCNavigatorButton;
begin
  inherited MouseMove(Shift, X, Y);
  if HideTabs then Exit;
  if FIsGoDialogShowing then Exit;

  IsOverNavigatorButton := FPainter.IsOverButton(X, Y, NavigatorButton);
  if (IsOverNavigatorButton and (FPressedNavigatorButton <> [NavigatorButton])) or
     (not IsOverNavigatorButton) then
    if FPressedNavigatorButton <> [] then
    begin
      if FTimer <> nil then
        FTimer.Enabled := False;
      PressedNavigatorButton := GetNavigatorButton(FPressedNavigatorButton);
      FNavigatorButtonStates[PressedNavigatorButton] := nbsNormal;
      FPressedNavigatorButton := [];
      FPainter.RepaintButton(PressedNavigatorButton, nbsPressed);
    end;

  TabVisibleIndex := VisibleIndexOfTabAt(X, Y);
  if (TabVisibleIndex <> FPressedTabVisibleIndex) and
     (FPressedTabVisibleIndex <> -1) then
  begin
    OldPressedTabVisibleIndex := FPressedTabVisibleIndex;
    FPressedTabVisibleIndex := -1;
    FPainter.RepaintTab(OldPressedTabVisibleIndex, tpcPressed);
  end;

  SynchronizeHotTrackStates(Shift);
end;

procedure TcxCustomTabControl.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

  procedure NavigatorButtonUp(NavigatorButton: TcxPCNavigatorButton);
  var
    ACloseButtonClicked: Boolean;
    AOldButtonState: TcxPCNavigatorButtonState;
  begin
    if FTimer <> nil then FTimer.Enabled := False;
    AOldButtonState := FNavigatorButtonStates[NavigatorButton];
    if AOldButtonState = nbsDisabled then Exit;
    if (not IsDesigning) and (NavigatorButton = nbGoDialog) and
       (FPressedNavigatorButton = [nbGoDialog]) then
      ShowGoDialog
    else
    begin
      ACloseButtonClicked := (not IsDesigning) and (NavigatorButton = nbClose) and
       (FPressedNavigatorButton = [nbClose]);

      if AOldButtonState = nbsPressed then FPressedNavigatorButton := [];
      FNavigatorButtonStates[NavigatorButton] := nbsNormal;
      FPainter.RepaintButton(NavigatorButton, AOldButtonState);
      SynchronizeHotTrackStates(Shift);

      if ACloseButtonClicked then
        CloseButtonClick;
    end;
  end;

var
  NavigatorButton: TcxPCNavigatorButton;
begin
  inherited MouseUp(Button, Shift, X, Y);
  if HideTabs or (Button <> mbLeft) or FIsGoDialogShowing then
    Exit;

  if FPainter.IsOverButton(X, Y, NavigatorButton) then
    NavigatorButtonUp(NavigatorButton)
  else
    TabUp(VisibleIndexOfTabAt(X, Y), Shift);
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
  FPainter.SaveClipRgn;
  try
    FPainter.Paint;
  finally
    FPainter.RestoreClipRgn;
  end;
end;

procedure TcxCustomTabControl.Resize;
begin
  RequestLayout;
  Realign;
  inherited Resize;
end;

function TcxCustomTabControl.CanChange(NewTabIndex: Integer): Boolean;
begin
  Result := True;
  if Assigned(FOnChanging) and not IsChangeEventLocked then
    FOnChanging(Self, Result);
end;

function TcxCustomTabControl.CanShowTab(TabIndex: Integer): Boolean;
begin
  Result := TabsTabs[TabIndex].Visible and TabsTabs[TabIndex].RealEnabled;
end;

procedure TcxCustomTabControl.Change;
begin
  if Assigned(FOnChange) and not IsChangeEventLocked then
    FOnChange(Self);
end;

procedure TcxCustomTabControl.CorrectFirstVisibleTab(
  TabVisibleIndex: Integer);

var
  c: Integer;
  ADistanceBetweenTabs: Integer;
begin
  if TabVisibleIndex < FFirstVisibleTab then
    FFirstVisibleTab := TabVisibleIndex
  else if (TabVisibleIndex = FLastVisibleTab) and FIsLastTabFullyVisible then
    Exit
  else if TabVisibleIndex >= FLastVisibleTab then
  begin
    UpdateTabPosition(FNavigatorButtons);
    ADistanceBetweenTabs := DistanceGetter(FPainter.GetTabsNormalDistance, not Rotate);
    if IsTooSmallControlSize then
      FFirstVisibleTab := TabVisibleIndex
    else
    begin
      c := FVisibleTabList[TabVisibleIndex].NormalLongitudinalSize;
      FFirstVisibleTab := TabVisibleIndex;
      while (c + ADistanceBetweenTabs < FTabsPosition.NormalRowWidth) and (FFirstVisibleTab > 0) do
      begin
        Dec(FFirstVisibleTab);
        Inc(c, ADistanceBetweenTabs);
        Inc(c, FVisibleTabList[FFirstVisibleTab].NormalLongitudinalSize);
        if c > FTabsPosition.NormalRowWidth then Inc(FFirstVisibleTab);
      end;
    end;
  end;
end;

procedure TcxCustomTabControl.DoShowGoDialog;
begin
  FGoDialog.Popup(pcoSort in Options);
  HideGoDialog(-1);
end;

procedure TcxCustomTabControl.DrawTab(TabIndex: Integer; const Rect: TRect;
  Active: Boolean);
begin
end;

function TcxCustomTabControl.GetActivePage: TcxTabSheet;
begin
  Result := nil;
end;

function TcxCustomTabControl.GetImageIndex(ATabIndex: Integer): Integer;
begin
  Result := TabsTabs[ATabIndex].FImageIndex;
  if Assigned(OnGetImageIndex) then
    OnGetImageIndex(Self, ATabIndex, Result);
  if Result < 0 then
    Result := -1;
  if (Images = nil) or (Images.Width <= 0) or (Images.Height <= 0) or
      (Result >= Images.Count) then
    Result := -1;
end;

function TcxCustomTabControl.GetPage(ATabIndex: Integer): TcxTabSheet;
begin
  Result := nil;
end;

procedure TcxCustomTabControl.GoDialogClickEventHandler(ATabControlItemIndex: Integer);
begin
  HideGoDialog(ATabControlItemIndex);
end;

procedure TcxCustomTabControl.HideGoDialog(ATabControlItemIndex: Integer);
begin
  if IsMessageInQueue(Handle, WM_LBUTTONDOWN) or IsMessageInQueue(Handle, WM_LBUTTONDBLCLK) then
    FGoDialogJustClosed := True;

  FIsGoDialogShowing := False;

  FNavigatorButtonStates[nbGoDialog] := nbsNormal;
  FPressedNavigatorButton := [];
  FPainter.RepaintButton(nbGoDialog, nbsPressed);

  if ATabControlItemIndex <> -1 then
    TabIndex := ATabControlItemIndex;

  SynchronizeHotTrackStates(InternalGetShiftState);
end;

procedure TcxCustomTabControl.ImageListChange(Sender: TObject);
begin
  RequestLayout;
end;

function TcxCustomTabControl.InternalKeyDown(var Key: Word;
  Shift: TShiftState): Boolean;

  function GetCorrectedDelta(Delta: Integer): Integer;
  var
    SpecialAlignment: Boolean;
  begin
    SpecialAlignment := IsRightToLeftAlignment(Self) or IsBottomToTopAlignment(Self);
    if (SpecialAlignment and (Delta = -1)) or
       ((not SpecialAlignment) and (Delta = 1)) then
      Result := 1
    else
      Result := -1;
  end;

  procedure ChangeTabIndex(TabVisibleIndex: Integer);
  begin
    if TabVisibleIndex <> FMainTabVisibleIndex then
      TabIndex := FVisibleTabList[TabVisibleIndex].Index;
  end;

  function GetNearestEnabledVisibleTabVisibleIndex(CurrentTabVisibleIndex,
    Delta: Integer; Cycle: Boolean): Integer;
  var
    I: Integer;
    VisibleTabCount: Integer;
  begin
    Result := -1;
    VisibleTabCount := FVisibleTabList.Count;
    I := CurrentTabVisibleIndex;
    repeat
      if FVisibleTabList[I].RealEnabled then Break
      else
      begin
        Inc(I, Delta);
        if ((I < 0) or (I >= VisibleTabCount)) then
          if not Cycle then
            Exit
          else
            if I < 0 then I := VisibleTabCount - 1
            else I := 0;
      end;
    until I = CurrentTabVisibleIndex;
    if FVisibleTabList[I].RealEnabled then
      Result := I;
  end;

var
  Delta: Integer;
  Cycle: Boolean;
  TabVisibleIndex: Integer;
  VisibleTabCount: Integer;
begin
  Result := False;
  VisibleTabCount := FVisibleTabList.Count;
  if HideTabs or (VisibleTabCount = 0) then Exit;
  if (Shift = [ssAlt]) or (Shift = [ssAlt, ssShift]) then Exit;

  Cycle := False;
  Delta := 0;
  TabVisibleIndex := -1;
  case Key of
    VK_TAB:
      if ssCtrl in Shift then
      begin
        Cycle := True;
        if ssShift in Shift then
          Delta := -1
        else
          Delta := 1;
      end;
    VK_RIGHT, VK_DOWN:
      Delta := 1;
    VK_LEFT, VK_UP:
      Delta := -1;
    VK_HOME, VK_END:
      begin
        if Key = VK_HOME then Delta := -1
        else Delta := 1;
        Delta := GetCorrectedDelta(Delta);
        if Delta = 1 then
          TabVisibleIndex := VisibleTabCount - 1
        else
          TabVisibleIndex := 0;
        Delta := -Delta;
      end;
    VK_RETURN, VK_SPACE:
      if FTracking <> -1 then
      begin
        TabIndex := FVisibleTabList[FTracking].Index;
        Result := True;
      end;
  end;

  if Delta = 0 then
    Exit;
  Result := True;

  if TabVisibleIndex = -1 then
  begin
    Delta := GetCorrectedDelta(Delta);
    if FTracking <> -1 then
      TabVisibleIndex := FTracking + Delta
    else if FMainTabVisibleIndex <> -1 then
      TabVisibleIndex := FMainTabVisibleIndex + Delta
    else
      if Delta = 1 then TabVisibleIndex := 0
      else TabVisibleIndex := VisibleTabCount - 1;

    if TabVisibleIndex < 0 then
      if Cycle then TabVisibleIndex := VisibleTabCount - 1
      else Exit;
    if TabVisibleIndex >= VisibleTabCount then
      if Cycle then TabVisibleIndex := 0
      else Exit;
  end;

  TabVisibleIndex := GetNearestEnabledVisibleTabVisibleIndex(TabVisibleIndex, Delta, Cycle);

  if TabVisibleIndex <> -1 then
    if (not FPainter.IsTabPressable) or (Key = VK_TAB) then
      ChangeTabIndex(TabVisibleIndex)
    else
      Tabs.SetTracking(TabVisibleIndex);
end;

function TcxCustomTabControl.IsChangeEventLocked: Boolean;
begin
  Result := (FChangeEventLockCount > 0) or IsLoading;
end;

procedure TcxCustomTabControl.LockChangeEvent(ALock: Boolean);
begin
  if ALock then
    Inc(FChangeEventLockCount)
  else
    if FChangeEventLockCount > 0 then
      Dec(FChangeEventLockCount);
end;

class procedure TcxCustomTabControl.OutError(SourceMethodName: TCaption; Msg: TCaption);
begin
  raise EdxException.Create('TcxCustomTabControl.' + SourceMethodName + ': ' + Msg);
end;

procedure TcxCustomTabControl.PrepareTabCanvasFont(ATab: TcxTab; ACanvas: TcxCanvas);
begin
  ACanvas.Font := Font;
  ACanvas.Font.Color := Painter.GetTextColor(ATab.VisibleIndex);
  DoDrawTabEx(ATab.VisibleIndex, ACanvas.Font);
end;

procedure TcxCustomTabControl.RequestLayout;
var
  APrevMainTabVisibleIndex: Integer;
begin
  if IsLoading or FUpdating then Exit;
  FUpdating := True;
  try
    APrevMainTabVisibleIndex := FMainTabVisibleIndex;
    if FMainTabVisibleIndex >= VisibleTabList.Count then
      FMainTabVisibleIndex := -1;

    Painter.Init;
    CorrectMaxRotatedTabWidth;

    Tabs.ResetTabVerticalTextBitmaps;
    Calculate;
    Tabs.ValidateImageIndexes;
    SynchronizeTabImagesRotationAngle;
    Realign;
    Invalidate;

    FMainTabVisibleIndex := APrevMainTabVisibleIndex;
    Tabs.SetMainTab;

    SynchronizeHotTrackStates(InternalGetShiftState);
  finally
    FUpdating := False;
  end;
end;

procedure TcxCustomTabControl.SetDefaultStyle;
var
  AStyleID: TcxPCStyleID;
begin
  if Style <> cxPCDefaultStyle then Exit;
  AStyleID := PaintersFactory.GetStyleID(LookAndFeel);
  if AStyleID = cxPCNoStyle then
    Style := PaintersFactory.GetDefaultStyleID(LookAndFeel)
  else
    Style := AStyleID;
  FStyle := cxPCDefaultStyle;
end;

procedure TcxCustomTabControl.SetModified;
begin
  if not IsLoading then
    Modified;
end;

procedure TcxCustomTabControl.ShowGoDialog;
begin
  FIsGoDialogShowing := True;
  DoShowGoDialog;
end;

function TcxCustomTabControl.CanTabClick(ATabVisibleIndex: Integer): Boolean;
begin
  Result := (ATabVisibleIndex <> -1) and (FVisibleTabList[ATabVisibleIndex].RealEnabled or IsDesigning);
end;

procedure TcxCustomTabControl.TabDown(ATabVisibleIndex: Integer; AShift: TShiftState);
begin
  FMouseDownTabVisibleIndex := ATabVisibleIndex;
  if CanTabClick(ATabVisibleIndex) then
    with FVisibleTabList[ATabVisibleIndex] do
    begin
      if FPainter.IsTabPressable and not IsDesigning then
      begin
        FPressedTabVisibleIndex := ATabVisibleIndex;
        FPainter.RepaintTab(ATabVisibleIndex, tpcPressed);
      end
      else
        SelectTab(ATabVisibleIndex, ssCtrl in AShift);
    end;
end;

procedure TcxCustomTabControl.TabUp(ATabVisibleIndex: Integer; AShift: TShiftState);
begin
  if CanTabClick(ATabVisibleIndex) then
    with FVisibleTabList[ATabVisibleIndex] do
    begin
      if FPainter.IsTabPressable and not IsDesigning and
         (ATabVisibleIndex = FPressedTabVisibleIndex) then
      begin
        if FPressedTabVisibleIndex <> -1 then
        begin
          FPressedTabVisibleIndex := -1;
          FPainter.RepaintTab(ATabVisibleIndex, tpcPressed);
        end;
        SelectTab(ATabVisibleIndex, ssCtrl in AShift);
      end;

      SynchronizeHotTrackStates(AShift);
      
      if FMouseDownTabVisibleIndex = ATabVisibleIndex then
        TabClick(Self, ATabVisibleIndex, AShift);
    end;
  FMouseDownTabVisibleIndex := -1;
end;

procedure TcxCustomTabControl.TabClick(Sender: TObject; ATabVisibleIndex: Integer; AShift: TShiftState);
begin
// do nothing
end;

function TcxCustomTabControl.TabIndexTabMustBeVisible: Boolean;
begin
  Result := False;
end;

procedure TcxCustomTabControl.UpdateTabImages;
var
  I: Integer;
begin
  for I := 0 to FTabs.Count - 1 do
    TabsTabs[I].ImageIndex := GetImageIndex(I);
  Invalidate;
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

{ TcxPCImageList }

constructor TcxPCImageList.Create(AParent: TcxCustomTabControl);
begin
  inherited Create;
  FParent := AParent;

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
  ClearRotatedImages;
  inherited Destroy;
end;

procedure TcxPCImageList.Draw(Canvas: TCanvas; X, Y,
  Index: Integer; BackgroundColor: TColor; Enabled: Boolean = True);
var
  Bitmap: TBitmap;
begin
  if not VerifyImageList(BaseImages) then
    OutError('Draw', scxPCNoBaseImages);
  if (Index < 0) or (Index >= BaseImages.Count) then
    OutError('Draw', Format(scxPCImageListIndexError, [Index, BaseImages.Count - 1]));

  if ImageRotationAngle = ra0 then
  begin
    if FParent.Painter.IsNativePainting then
      BaseImages.Draw(Canvas, X, Y, Index, Enabled)
    else
    begin
      Bitmap := TBitmap.Create;
      try
        PrepareBitmap(Bitmap, FParent.Canvas, BaseImageSize, BackgroundColor);
        DoPrepareBitmapBackground(Bitmap);
        BaseImages.Draw(Bitmap.Canvas, 0, 0, Index, Enabled);
        Canvas.Draw(X, Y, Bitmap);
      finally
        Bitmap.Free;
      end
    end;
  end else
  begin
    RotateImage(Index, BackgroundColor, Enabled);
    Canvas.Draw(X, Y, FRotatedImages[Index].Bitmap);
  end;
end;

procedure TcxPCImageList.BaseImageListChange(Sender: TObject);
begin
  RotateImages;
  Change;
end;

procedure TcxPCImageList.Change;
begin
  if Assigned(OnChange) then
    OnChange(Self);
end;

procedure TcxPCImageList.ClearRotatedImages;
var
  I: Integer;
begin
  for I := 0 to Length(FRotatedImages) - 1 do
    FRotatedImages[I].Bitmap.Free;
  FRotatedImages := nil;
end;

procedure TcxPCImageList.DoPrepareBitmapBackground(ABitmap: TBitmap);
begin
  if Assigned(FOnPrepareBitmapBackground) then
    FOnPrepareBitmapBackground(ABitmap);
end;

function TcxPCImageList.GetBaseImageSize: TSize;
begin
  if (BaseImages = nil) or (BaseImages.Width <= 0) or (BaseImages.Height <= 0) then
    Result := Size(0, 0)
  else
    Result := Size(BaseImages.Width, BaseImages.Height);
end;

function TcxPCImageList.GetRotatedImageSize: TSize;
begin
  Result := GetBaseImageSize;
  if ImageRotationAngle <> ra0 then
    Result := Size(Result.cy, Result.cx);
end;

procedure TcxPCImageList.FreeNotification(AComponent: TComponent);
begin
  if AComponent = BaseImages then
    BaseImages := nil;
end;

class procedure TcxPCImageList.OutError(SourceMethodName, Msg: TCaption);
begin
  raise EdxException.Create('TcxPCImageList.' + SourceMethodName + ': ' + Msg);
end;

procedure TcxPCImageList.RotateImage(Index: Integer;
  BackgroundColor: TColor; Enabled: Boolean);
var
  E: TcxPCImageListRotatedImagesElement;
begin
  E := FRotatedImages[Index];
  if (E.IsBackgroundColorSpecified) and (E.BackgroundColor = BackgroundColor) then Exit;
  E.BackgroundColor := BackgroundColor;
  E.IsBackgroundColorSpecified := True;

  with E.Bitmap, E.Bitmap.Canvas do
  begin
    Width := BaseImages.Width;
    Height := BaseImages.Height;
    Brush.Style := bsSolid;
    Brush.Color := BackgroundColor;
    FillRect(Rect(0, 0, Width, Height));
    if FParent.Painter.IsNativePainting then
      Transparent := True;
    DoPrepareBitmapBackground(E.Bitmap);
    BaseImages.Draw(Canvas, 0, 0, Index, Enabled);
    FParent.Canvas.RotateBitmap(E.Bitmap, ImageRotationAngle);
  end;
end;

procedure TcxPCImageList.RotateImages;
var
  I: Integer;
begin
  if FImageRotationAngle = ra0 then Exit;
  if not VerifyImageList(FBaseImages) then Exit;

  ClearRotatedImages;
  SetLength(FRotatedImages, BaseImages.Count);
  for I := 0 to BaseImages.Count - 1 do
  begin
    FRotatedImages[I].IsBackgroundColorSpecified := False;
    FRotatedImages[I].Bitmap := TBitmap.Create;
    FRotatedImages[I].Bitmap.PixelFormat := pf32bit;
    FRotatedImages[I].Bitmap.HandleType := bmDDB;
  end;
end;

procedure TcxPCImageList.SetBaseImages(
  const Value: TCustomImageList);
begin
  cxSetImageList(Value, FBaseImages, FBaseImageChangeLink, FFreeNotificator);
end;

procedure TcxPCImageList.SetImageRotationAngle(
  const Value: TcxRotationAngle);
begin
  begin
    FImageRotationAngle := Value;
    BaseImageListChange(BaseImages);
  end;
end;

{ TcxPageControl }

constructor TcxPageControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPages := TList.Create;
end;

destructor TcxPageControl.Destroy;
var
  I: Integer;
begin
  for I := 0 to PageCount - 1 do
    with Pages[I] do
    begin
      FPageControl := nil;
      FTab := nil;
    end;
  FPages.Free;
  inherited Destroy;
end;

function TcxPageControl.FindNextPage(ACurrentPage: TcxTabSheet; AGoForward,
  ACheckTabAccessibility: Boolean): TcxTabSheet;
begin
  Result := FindNextPageEx(ACurrentPage, AGoForward, ACheckTabAccessibility, True);
end;

function TcxPageControl.FindNextPageEx(ACurrentPage: TcxTabSheet;
  AGoForward, ACheckTabAccessibility, ACircular: Boolean): TcxTabSheet;

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
      if not ACheckTabAccessibility or Pages[APageIndex].TabVisible and Pages[APageIndex].Enabled then
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

function TcxPageControl.CanChange(NewTabIndex: Integer): Boolean;
begin
  Result := inherited CanChange(NewTabIndex);
  if Result and (NewTabIndex <> -1) then
    Result := CanChangeActivePage(Pages[NewTabIndex]);
end;

procedure TcxPageControl.Change;
begin
  LockChangeEvent(True);
  try
    UpdateActivePage;
  finally
    LockChangeEvent(False);
  end;
  inherited Change;
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

procedure TcxPageControl.DoClose;
begin
  ActivePage.Free;
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
  Result := ActivePage;
end;

function TcxPageControl.GetPage(ATabIndex: Integer): TcxTabSheet;
begin
  Result := TcxTabSheet(FPages[ATabIndex]);
end;

procedure TcxPageControl.GetSiteInfo(Client: TControl;
  var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
begin
  CanDock := GetPageFromDockClient(Client) = nil;
  inherited GetSiteInfo(Client, InfluenceRect, MousePos, CanDock);
end;

procedure TcxPageControl.ImageListChange(Sender: TObject);
var
  I: Integer;
begin
  if FPageInserting or IsDestroying then
    Exit;

  for I := 0 to PageCount - 1 do
    Pages[I].FTab.ImageIndex := Pages[I].ImageIndex;
  inherited ImageListChange(Sender);
end;

procedure TcxPageControl.Loaded;
begin
  inherited Loaded;
  UpdateTabs;
  if (not IsDesigning) and (ActivePage <> nil) and (not ActivePage.Enabled) then
    ActivePage := nil;
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

function TcxPageControl.TabIndexTabMustBeVisible: Boolean;
begin
  Result := True;
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

function TcxPageControl.CanChangeActivePage(NewPage: TcxTabSheet): Boolean;
begin
  Result := True;
  PageChanging(NewPage, Result);
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

procedure TcxPageControl.PageChange;
begin
  inherited Change;
end;

procedure TcxPageControl.PageChanging(NewPage: TcxTabSheet;
  var AllowChange: Boolean);
begin
  if Assigned(FOnPageChanging) and not IsChangeEventLocked then
    FOnPageChanging(Self, NewPage, AllowChange);
end;

procedure TcxPageControl.UpdateActivePage;
begin
  if TabIndex = -1 then
    ActivePage := nil
  else
    ActivePage := Pages[TabIndex];
end;

procedure TcxPageControl.UpdateTab(APage: TcxTabSheet);
begin
  if [csLoading, csDestroying] * ComponentState <> [] then Exit;
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

procedure TcxPageControl.UpdateTabs;
var
  I: Integer;
begin
  for I := 0 to PageCount - 1 do
    UpdateTab(Pages[I]);
end;

procedure TcxPageControl.ChangeActivePage(APage: TcxTabSheet);
var
  ANewActiveControl: TWinControl;
  AParentForm: TCustomForm;
begin
  if FActivePage <> APage then
  begin
    if not CanChangeActivePage(APage) then
      Exit;

    AParentForm := GetParentForm(Self);
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
      if APage.Enabled and Visible and Enabled and Parent.CanFocus then
        ANewActiveControl := APage
      else
        ANewActiveControl := Self;
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
    PageChange;
    if (AParentForm <> nil) and (FActivePage <> nil) and
    (AParentForm.ActiveControl = FActivePage) then
       FActivePage.SelectFirst;

    SetModified;
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
  AVisibleTabIndex, I: Integer;
begin
  Result := nil;
  if DockSite then
  begin
    AVisibleTabIndex := VisibleIndexOfTabAt(P.X, P.Y);
    if AVisibleTabIndex >= 0 then
    begin
      APage := nil;
      for I := 0 to PageCount - 1 do
        if Pages[I].TabIndex = AVisibleTabIndex then
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

function TcxPageControl.GetPageCount: Integer;
begin
  Result := FPages.Count;
end;

function TcxPageControl.GetTabCount: Integer;
begin
  Result := FVisibleTabList.Count;
end;

procedure TcxPageControl.InsertPage(APage: TcxTabSheet);
var
  PageIndex: Integer;
begin
  if CanAllocateHandle(Self) then
    HandleNeeded;
  FPageInserting := True;
  try
    PageIndex := FPages.Add(APage);
    APage.SetParentPageControl(Self);
    Tabs.Add(APage.Caption);
  finally
    FPageInserting := False;
  end;
  APage.FTab := Tabs.Tabs[PageIndex];
  UpdateTab(APage);
end;

procedure TcxPageControl.RemovePage(APage: TcxTabSheet);

  function InternalFindNextPage(ACurrentPage: TcxTabSheet; AGoForward,
    ACheckTabAccessibility: Boolean): TcxTabSheet;
  begin
    Result := FindNextPageEx(ACurrentPage, AGoForward, ACheckTabAccessibility, False);
    if Result = nil then
      Result := FindNextPageEx(ACurrentPage, not AGoForward, ACheckTabAccessibility, False);
  end;

var
  ANextPage: TcxTabSheet;
begin
  ANextPage := InternalFindNextPage(APage, True, not IsDesigning);
  if ANextPage = APage then
    ANextPage := nil;

  Tabs.Delete(FPages.Remove(APage));
  APage.FTab := nil;
  FTabIndex := -1;
  FMainTabVisibleIndex := -1;
  ActivePage := ANextPage;
  APage.SetParentPageControl(nil);
end;

procedure TcxPageControl.SetActivePage(APage: TcxTabSheet);
begin
  if FActivePageSetting or IsDestroying or (APage <> nil) and (APage.PageControl <> Self) then
    Exit;
  ChangeActivePage(APage);
  if ActivePage = APage then
  begin
    LockChangeEvent(True);
    FActivePageSetting := True;
    try
      if (APage <> nil) and APage.TabVisible then
        TabIndex := APage.FTab.Index
      else
        TabIndex := -1;
    finally
      FActivePageSetting := False;
      LockChangeEvent(False);
    end;
  end;
end;

procedure TcxPageControl.SetActivePageIndex(Value: Integer);
begin
  if (Value >= 0) and (Value < PageCount) then
    ActivePage := Pages[Value]
  else
    ActivePage := nil;
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

{ TcxPCCustomPainter }

constructor TcxPCCustomPainter.Create(
  AParent: TcxCustomTabControl);
begin
  inherited Create;
  FParentControl := AParent;
  FParentInfo := TcxPCPainterParentInfo.Create(AParent);
end;

destructor TcxPCCustomPainter.Destroy;
begin
  FreeAndNil(FParentInfo);
  inherited;
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

procedure TcxPCCustomPainter.CorrectTabRect(TabVisibleIndex: Integer;
  var TabRectCorrection: TcxPCRectCorrection);
begin
  TabRectCorrection := cxPCEmptyRectCorrection;
end;

function TcxPCCustomPainter.CreateNewTabVerticalTextBitmap(
  TabVisibleIndex: Integer): TBitmap;
begin
  with ParentControl.FVisibleTabList[TabVisibleIndex] do
  begin
    FVerticalTextBitmap := TBitmap.Create;
    Result := FVerticalTextBitmap;
  end;
end;

procedure TcxPCCustomPainter.DirectionalPolyline(const R: TRect;
  APoints: array of TPoint; ATabPosition: TcxTabPosition; AColor: TColor);
begin
  RotatePolyline(R, APoints, ATabPosition);
  InternalPolyLine(APoints, AColor);
end;

function TcxPCCustomPainter.DoCustomDraw(TabVisibleIndex: Integer): Boolean;
begin
  Result := True;
  ParentControl.OnDrawTab(ParentControl, ParentInfo.VisibleTabs[TabVisibleIndex],
    Result);
  Result := not Result;
end;

procedure TcxPCCustomPainter.DrawNativeTabBackground(DC: HDC; ATab: TcxTabSheet);
begin
end;

procedure TcxPCCustomPainter.DrawTabImageAndText(ATab: TcxTab; ATabVisibleIndex: Integer);

  procedure InitializeBitmap(ABitmap: TBitmap; S: TCaption; R: TRect;
    AEnabled: Boolean; ABackgroundColor: TColor);
  var
    ATextRect: TRect;
  begin
    if IsNativePainting then
      ABitmap.Canvas.Font := ParentInfo.Canvas.Font
    else
      PrepareBitmap(ABitmap, ParentInfo.Canvas, Size(R.Right - R.Left,
        R.Bottom - R.Top), ABackgroundColor);
    PrepareDrawTabContentBitmapBackground(ABitmap, FOutTabImageAndTextData.TabTextRect.TopLeft,
      ATabVisibleIndex);
    ATextRect := R;
    if not IsNativePainting then
      OffsetRect(ATextRect, -ATextRect.Left, -ATextRect.Top);

    with ABitmap.Canvas do
    begin
      Brush.Style := bsClear;
      if not AEnabled then
      begin
        Font.Color := DisabledTextFaceColor;
        if NeedDisabledTextShadow then
        begin
          OffsetRect(ATextRect, 1, 1);
          InternalDrawText(ABitmap.Canvas, S, ATextRect, ATabVisibleIndex);
          OffsetRect(ATextRect, -1, -1);
          Font.Color := DisabledTextShadowColor;
        end;
      end;
      InternalDrawText(ABitmap.Canvas, S, ATextRect, ATabVisibleIndex);
    end;
  end;

  procedure OutVerticalText(ACaption: TCaption; const R: TRect;
    AEnabled: Boolean; ABackgroundColor: TColor);
  var
    ABitmap: TBitmap;
  begin
    ABitmap := GetTabVerticalTextBitmap(ATabVisibleIndex);
    if ABitmap = nil then
    begin
      ABitmap := CreateNewTabVerticalTextBitmap(ATabVisibleIndex);
      ABitmap.PixelFormat := pf32bit;
      ABitmap.HandleType := bmDDB;
      InitializeBitmap(ABitmap, ACaption, Rect(R.Top, R.Left, R.Bottom, R.Right),
        AEnabled, ABackgroundColor); // Rotated rectangle
      ParentInfo.Canvas.RotateBitmap(ABitmap, GetTextRotationAngle(ParentControl));
    end;
    if IsNativePainting then
      ATab.PaintBitmap.Canvas.Draw(R.Left, R.Top, ABitmap)
    else
      ParentInfo.Canvas.Draw(R.Left, R.Top, ABitmap);
  end;

  procedure OutHorizontalText(ACaption: TCaption; const R: TRect;
    AEnabled: Boolean; ABackgroundColor: TColor);
  var
    ABitmap: TBitmap;
  begin
    if IsNativePainting then
      InitializeBitmap(ATab.PaintBitmap, ACaption, R, AEnabled, ABackgroundColor)
    else
    begin
      ABitmap := TBitmap.Create;
      try
        ABitmap.PixelFormat := pf32bit;
        ABitmap.HandleType := bmDDB;
        InitializeBitmap(ABitmap, ACaption, R, AEnabled, ABackgroundColor);
        ParentInfo.Canvas.Draw(R.Left, R.Top, ABitmap);
      finally
        ABitmap.Free;
      end;
    end;
  end;

var
  IsTabEnabled: Boolean;
  TabImageIndex: TImageIndex;
  ABackgroundColor: TColor;
begin
  FOutTabImageAndTextData.TabVisibleIndex := ATabVisibleIndex;
  PrepareTabCanvasFont(ATab, ParentInfo.Canvas);
  StandardPainterPrepareOutTabImageAndTextData(ATabVisibleIndex);
  ABackgroundColor := GetTabBodyColor(ATabVisibleIndex);

  with FOutTabImageAndTextData do
  begin
    IsTabEnabled := ATab.RealEnabled;
    TabImageIndex := ParentControl.GetImageIndex(ATab.Index);
    if TabImageIndex <> -1 then
      if IsNativePainting then
        ParentControl.FImages.Draw(ATab.PaintBitmap.Canvas, TabImageRect.Left,
          TabImageRect.Top, TabImageIndex, ABackgroundColor, IsTabEnabled)
      else
      begin
        ParentControl.FImages.Draw(ParentInfo.Canvas.Canvas, TabImageRect.Left,
          TabImageRect.Top, TabImageIndex, ABackgroundColor, IsTabEnabled);
      end;

    if ATab.Caption <> '' then
    begin
      if InternalIsVerticalText(ParentControl) then
        OutVerticalText(ATab.Caption, TabTextRect, IsTabEnabled, ABackgroundColor)
      else
        OutHorizontalText(ATab.Caption, TabTextRect, IsTabEnabled, ABackgroundColor);
    end;
  end;
  ExcludeTabContentClipRegion(ATabVisibleIndex);
end;

procedure TcxPCCustomPainter.ExcludeTabContentClipRegion(ATabVisibleIndex: Integer);
var
  AContentRgn: TcxRegion;
begin
  if IsNativePainting then
    Exit;

  AContentRgn := TcxRegion.Create(FOutTabImageAndTextData.TabTextRect);
  AContentRgn.Combine(TcxRegion.Create(FOutTabImageAndTextData.TabImageRect), roAdd);
  AContentRgn.Combine(GetTabClipRgn(ATabVisibleIndex), roIntersect);
  ParentInfo.Canvas.SetClipRegion(AContentRgn, roSubtract);
end;

procedure TcxPCCustomPainter.FillDisplayRect;
begin
  ParentInfo.Canvas.Brush.Style := bsSolid;
  ParentInfo.Canvas.Brush.Color := GetClientColor;
  ParentInfo.Canvas.FillRect(GetClientRect);
end;

procedure TcxPCCustomPainter.FillTabPaneContent;
begin
  FillDisplayRect;
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
  if (ParentInfo.ActivePage <> nil) and not ParentInfo.ActivePage.ParentColor then
    Result := ParentInfo.ActivePage.Color
  else
    Result := GetDefaultClientColor;
end;

function TcxPCCustomPainter.GetClientRect: TRect;
begin
  Result := GetExtendedRect(GetControlRect(ParentControl),
    GetClientRectOffset, ParentInfo.TabPosition);
  ValidateRect(Result);
end;

function TcxPCCustomPainter.GetClientRectOffset: TRect;
begin
  Result := GetDisplayRectOffset;
  if NeedShowFrame then
    OffsetRect(Result, GetFrameWidth, GetFrameWidth);
end;

function TcxPCCustomPainter.GetDefaultClientColor: TColor;
begin
  Result := ParentInfo.Color;
end;

function TcxPCCustomPainter.GetDisplayRect: TRect;
begin
  Result := GetExtendedRect(GetControlRect(ParentControl),
    GetDisplayRectOffset, ParentInfo.TabPosition);
  ValidateRect(Result);
end;

function TcxPCCustomPainter.GetDisplayRectOffset: TRect;
begin
  Result := cxEmptyRect;
  if ParentInfo.HideTabs or (ParentInfo.RowCount = 0) then
    Exit;
  case ParentInfo.TabPosition of
    tpTop:
      begin
        Result.Top := ParentInfo.ExtendedTopOrLeftTabsRect.Bottom;
        if ParentInfo.TopOrLeftPartRowCount <> ParentInfo.RowCount then
          Result.Bottom := ParentInfo.Height - ParentInfo.ExtendedBottomOrRightTabsRect.Top;
      end;
    tpLeft:
      begin
        Result.Top := ParentInfo.ExtendedTopOrLeftTabsRect.Right;
        if ParentInfo.TopOrLeftPartRowCount <> ParentInfo.RowCount then
          Result.Bottom := ParentInfo.Width - ParentInfo.ExtendedBottomOrRightTabsRect.Left;
      end;
    tpBottom:
      begin
        if ParentControl.IsTooSmallControlSize then
          Result.Top := ParentInfo.ExtendedTopOrLeftTabsRect.Top
        else
          Result.Top := ParentInfo.Height - ParentInfo.ExtendedBottomOrRightTabsRect.Top;
        if ParentInfo.TopOrLeftPartRowCount <> 0 then
          Result.Bottom := ParentInfo.ExtendedTopOrLeftTabsRect.Bottom;
      end;
    tpRight:
      begin
        if ParentControl.IsTooSmallControlSize then
          Result.Top := ParentInfo.ExtendedTopOrLeftTabsRect.Left
        else
          Result.Top := ParentInfo.Width - ParentInfo.ExtendedBottomOrRightTabsRect.Left;
        if ParentInfo.TopOrLeftPartRowCount <> 0 then
          Result.Bottom := ParentInfo.ExtendedTopOrLeftTabsRect.Right;
      end;
  end;
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

procedure TcxPCCustomPainter.PrepareTabControlImagesBitmapBackground(ABitmap: TBitmap);
begin
  with FOutTabImageAndTextData do
    PrepareDrawTabContentBitmapBackground(ABitmap, TabImageRect.TopLeft, TabVisibleIndex);
end;

procedure TcxPCCustomPainter.AfterPaintTab(ATabVisibleIndex: Integer);
begin
  ParentControl.AfterPaintTab(ParentInfo.Canvas, ParentInfo.VisibleTabs[ATabVisibleIndex],
    FOutTabImageAndTextData);
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
  for I := 0 to ParentControl.VisibleTabList.Count - 1 do
  begin
    ATextHeight := TextSize(ParentInfo.VisibleTabs[I], 'Zg').cy;
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
    if ParentInfo.IsTabsContainer then
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
  Result := ParentControl.FImages.BaseImageSize;
end;

function TcxPCCustomPainter.GetTabColor(ATabVisibleIndex: Integer): TColor;
begin
  Result := ParentInfo.TabColors[ATabVisibleIndex];
end;

function TcxPCCustomPainter.GetTabClipRgn(ATabVisibleIndex: Integer): TcxRegion;
begin
  Result := TcxRegion.Create(ParentInfo.VisibleTabs[ATabVisibleIndex].VisibleRect);
end;

function TcxPCCustomPainter.GetTabClipRgnOperation(ATabVisibleIndex: Integer): TcxRegionOperation;
begin
  Result := roIntersect;
end;

procedure TcxPCCustomPainter.GetTabNativePartAndState(ATabVisibleIndex: Integer;
  out PartId, StateId: Integer);
begin
  PartId := 0;
  StateId := 0;
end;

function TcxPCCustomPainter.GetTabNativeState(ATabVisibleIndex: Integer): Integer;
var
  ATab: TcxTab;
begin
  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
  if ATab.IsMainTab then
    Result := TIS_SELECTED
  else
    if ATab.HotTrack then
      Result := TIS_HOT
    else
      Result := TIS_NORMAL;
end;

function TcxPCCustomPainter.GetTabRotatedImageSize: TSize;
begin
  Result := ParentControl.FImages.RotatedImageSize;
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

function TcxPCCustomPainter.GetTabVerticalTextBitmap(
  TabVisibleIndex: Integer): TBitmap;
begin
  Result := ParentInfo.VisibleTabs[TabVisibleIndex].VerticalTextBitmap;
end;

function TcxPCCustomPainter.GetTextColor(ATabVisibleIndex: Integer): TColor;
var
  ATab: TcxTab;
begin
  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
  if ATab.Highlighted then
    Result := GetHighlightedTextColor(ATabVisibleIndex, ParentInfo.Font.Color)
  else
    if ATab.HotTrack then
      Result := GetHotTrackColor
  else
    Result := clBtnText;
end;

procedure TcxPCCustomPainter.Init;
begin
end;

procedure TcxPCCustomPainter.InternalPaint;

  function IsTabsRectVisible: Boolean;
  var
    r1, r2, r3, r4: TRect;
    AControlRect, ADisplayRect: TRect;
  begin
    AControlRect := GetControlRect(ParentControl);
    ADisplayRect := GetDisplayRect;
    r1 := AControlRect;
    r1.Right := ADisplayRect.Left;
    r2 := AControlRect;
    r2.Bottom := ADisplayRect.Top;
    r3 := AControlRect;
    r3.Left := ADisplayRect.Right;
    r4 := AControlRect;
    r4.Top := ADisplayRect.Bottom;
    Result := RectVisible(ParentInfo.Canvas.Handle, r1) or
      RectVisible(ParentInfo.Canvas.Handle, r2) or
      RectVisible(ParentInfo.Canvas.Handle, r3) or
      RectVisible(ParentInfo.Canvas.Handle, r4);
  end;

begin
  if not ParentInfo.HideTabs then
  begin
    PaintButtonsRegion;
    if IsTabsRectVisible then
      PaintTabsRegion;
  end;
  PaintClientArea;
end;

procedure TcxPCCustomPainter.InternalDrawText(ACanvas: TCanvas;
  const ACaption: string; ARect: TRect; ATabVisibleIndex: Integer);
var
  APartId, AStateId: Integer;
begin
  if IsNativePainting and ParentInfo.VisibleTabs[ATabVisibleIndex].RealEnabled and
    AreVisualStylesAvailable then
  begin
    GetTabNativePartAndState(ATabVisibleIndex, APartId, AStateId);
    DrawThemeText(OpenTheme(totTab), ACanvas.Handle, APartId,
      AStateId, ACaption, -1, DT_SINGLELINE or DT_END_ELLIPSIS, 0, ARect);
  end
  else
    cxDrawText(ACanvas.Handle, ACaption, ARect, DT_SINGLELINE or DT_END_ELLIPSIS);
end;

procedure TcxPCCustomPainter.InternalInvalidateRect(Rect: TRect);
begin
  ParentControl.InternalInvalidateRect(Rect);
end;

procedure TcxPCCustomPainter.InternalPolyLine(const APoints: array of TPoint;
  AColor: TColor; ACanvas: TCanvas = nil);
var
  ALastPoint: TPoint;
begin
  if ACanvas = nil then
    ACanvas := ParentInfo.Canvas.Canvas;
  ACanvas.Pen.Color := AColor;
  ACanvas.Polyline(APoints);
  ALastPoint := APoints[High(APoints)];
  ACanvas.Polyline([ALastPoint, Point(ALastPoint.X + 1, ALastPoint.Y + 1)]);
end;

procedure TcxPCCustomPainter.InternalResetClipRegion;
begin
  RestoreClipRgn;
end;

function TcxPCCustomPainter.InternalSetClipRect(ClipR: TRect;
  IntersectWithCurrentClipRegion: Boolean = True): Boolean;
begin
  Result := False;
  if IsRectEmpty(ClipR) then Exit;
  with ParentInfo.Canvas do
  begin
    if IntersectWithCurrentClipRegion and
      (not Windows.RectVisible(Handle, ClipR)) then Exit;
    SaveClipRgn;
    if IntersectWithCurrentClipRegion then
      IntersectClipRect(ClipR)
    else
      SetClipRegion(TcxRegion.Create(ClipR), roSet);
  end;
  Result := True;
end;

procedure TcxPCCustomPainter.InvalidateTabExtendedTabsRect(TabVisibleIndex: Integer);
var
  TabExtendedRect: TRect;
begin
  with ParentControl do
  begin
    TabExtendedRect := GetTabExtendedTabsRect(TabVisibleIndex);
    InternalInvalidateRect(TabExtendedRect);
  end;
end;

procedure TcxPCCustomPainter.InvalidateTabRect(ATabVisibleIndex: Integer);
begin
  ParentControl.InternalInvalidateRect(ParentInfo.VisibleTabs[ATabVisibleIndex].VisibleRect);
end;

function TcxPCCustomPainter.IsAssignedImages: Boolean;
begin
  Result := GetTabBaseImageSize.cx > 0;
end;

function TcxPCCustomPainter.IsCustomDraw: Boolean;
begin
  Result := ParentControl.OwnerDraw and Assigned(ParentControl.OnDrawTab);
end;

function TcxPCCustomPainter.IsEnableHotTrack: Boolean;
begin
  Result := IsNativePainting;
end;

function TcxPCCustomPainter.IsNativePainting: Boolean;
begin
  Result := False;
end;

function TcxPCCustomPainter.IsOverTab(TabVisibleIndex: Integer; X,
  Y: Integer): Boolean;
begin
  Result := True;
end;

function TcxPCCustomPainter.IsTabHasImage(ATabVisibleIndex: Integer): Boolean;
begin
  Result := IsAssignedImages and (ParentInfo.VisibleTabs[ATabVisibleIndex].ImageIndex >= 0);
end;

function TcxPCCustomPainter.IsTabTransparent(ATabVisibleIndex: Integer): Boolean;
begin
  Result := False;
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
  Result := ParentInfo.ShowFrame;
end;

procedure TcxPCCustomPainter.Paint;
begin
  InternalPaint;
end;

procedure TcxPCCustomPainter.PaintClientArea;
begin
  if NeedShowFrame then
    PaintFrame;
  FillDisplayRect;
  ParentInfo.Canvas.ExcludeClipRect(GetDisplayRect);
end;

procedure TcxPCCustomPainter.PrepareTabCanvasFont(ATab: TcxTab; ACanvas: TcxCanvas);
begin
  ParentControl.PrepareTabCanvasFont(ATab, ACanvas);
end;

procedure TcxPCCustomPainter.PrepareDrawTabContentBitmapBackground(
  ABitmap: TBitmap; const ABitmapPos: TPoint; ATabVisibleIndex: Integer);
begin
end;

procedure TcxPCCustomPainter.RepaintButton(
  Button: TcxPCNavigatorButton; OldButtonState: TcxPCNavigatorButtonState);
begin
end;

procedure TcxPCCustomPainter.RepaintButtonsRegion;
begin
end;

procedure TcxPCCustomPainter.RepaintTab(TabVisibleIndex: Integer;
  TabPropertyChanged: TcxPCTabPropertyChanged);
begin
end;

procedure TcxPCCustomPainter.RestoreClipRgn;
begin
  ParentInfo.Canvas.RestoreClipRegion;
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

procedure TcxPCCustomPainter.SaveClipRgn;
begin
  ParentInfo.Canvas.SaveClipRegion;
end;

procedure TcxPCCustomPainter.StandardPainterPrepareOutTabImageAndTextData(
  TabVisibleIndex: Integer);
var
  AHasImages, ATabHasImage: Boolean;
  ImageRect, TextRect: TRect;
  Tab: TcxTab;

  procedure CorrectTabContentHOffset(var ADrawOffset: TRect);

    procedure CorrectNonpressableTabContentHOffset(var ADrawOffset: TRect);
    begin
      if ParentInfo.Rotate then
      begin
        ADrawOffset.Top := 0;
        ADrawOffset.Bottom := 0;
      end;
    end;

    procedure CorrectPressableTabContentHOffset(var ADrawOffset: TRect);
    begin
      if InternalGetTextRotationAngle(ParentControl) = raMinus90 then
      begin
        if not IsTabBorderThick(TabVisibleIndex) then
        begin
          Inc(ADrawOffset.Top);
          Dec(ADrawOffset.Bottom);
        end;
      end
      else
        if IsTabBorderThick(TabVisibleIndex) then
        begin
          Inc(ADrawOffset.Top);
          Dec(ADrawOffset.Bottom);
        end;
    end;

  begin
    if IsTabPressable then
      CorrectPressableTabContentHOffset(ADrawOffset)
    else
      CorrectNonpressableTabContentHOffset(ADrawOffset);
  end;

  procedure CalculateImageHPosition;
  var
    ADrawImageOffset: TRect;
    ATempVar: Integer;
    TextRotationAngle: TcxRotationAngle;
    ImageSize: TSize;
  begin
    if not ATabHasImage then
      Exit;

    ADrawImageOffset := GetDrawImageOffset(TabVisibleIndex);
    CorrectTabContentHOffset(ADrawImageOffset);
    if IsMainTabBoundWithClient and (Tab.PaintingPositionIndex in [5, 7, 10]) then
    begin
      ATempVar := ADrawImageOffset.Top;
      ADrawImageOffset.Top := ADrawImageOffset.Bottom;
      ADrawImageOffset.Bottom := ATempVar;
    end; 
    ImageSize := GetTabRotatedImageSize;
    if IsNativePainting then
      with Tab.FullRect do
        if IsVerticalText(ParentControl) then
          ImageRect := Rect(0, 0, Bottom - Top, Right - Left)
        else
          ImageRect := Rect(0, 0, Right - Left, Bottom - Top)
    else
      ImageRect := Tab.FullRect;
    TextRotationAngle := InternalGetTextRotationAngle(ParentControl);
    with ImageRect do
      case TextRotationAngle of
        ra0:
          begin
            Inc(Top, ADrawImageOffset.Top);
            Dec(Bottom, ADrawImageOffset.Bottom);
            Top := Top + (Bottom - Top - ImageSize.cy) div 2;
            Bottom := Top + ImageSize.cy;
          end;
        raPlus90:
          begin
            Inc(Left, ADrawImageOffset.Top);
            Dec(Right, ADrawImageOffset.Bottom);
            Left := Left + (Right - Left - ImageSize.cx) div 2;
            Right := Left + ImageSize.cx;
          end;
        raMinus90:
          begin
            Inc(Left, ADrawImageOffset.Bottom);
            Dec(Right, ADrawImageOffset.Top);
            Right := Right - (Right - Left - ImageSize.cx) div 2;
            Left := Right - ImageSize.cx;
          end;
      end;
  end;

  procedure CalculateTextHPosition;
  var
    ADrawTextOffset: TRect;
    ATempVar: Integer;
    ATextHeight: Integer;
  begin
    if Tab.Caption = '' then
      Exit;
    if IsNativePainting then
      with Tab.FullRect do
        if IsVerticalText(ParentControl) then
          TextRect := Rect(0, 0, Bottom - Top, Right - Left)
        else
          TextRect := Rect(0, 0, Right - Left, Bottom - Top)
    else
      TextRect := Tab.FullRect;

    ADrawTextOffset := GetDrawTextHOffset(TabVisibleIndex);
    CorrectTabContentHOffset(ADrawTextOffset);

    if IsMainTabBoundWithClient and (Tab.PaintingPositionIndex in [5, 7, 10]) then
    begin
      ATempVar := ADrawTextOffset.Top;
      ADrawTextOffset.Top := ADrawTextOffset.Bottom;
      ADrawTextOffset.Bottom := ATempVar;
    end;
    if AHasImages then
      Inc(ADrawTextOffset.Left, ParentInfo.ImageBorder);
    ATextHeight := ParentInfo.Canvas.TextHeight('Zg');
    with TextRect do
      case InternalGetTextRotationAngle(ParentControl) of
        ra0:
          begin
            Inc(Top, ADrawTextOffset.Top);
            Dec(Bottom, ADrawTextOffset.Bottom);
            Top := Top + (Bottom - Top - ATextHeight) div 2;
            Bottom := Top + ATextHeight;
          end;
        raPlus90:
          begin
            Inc(Left, ADrawTextOffset.Top);
            Dec(Right, ADrawTextOffset.Bottom);
            Left := Left + (Right - Left - ATextHeight) div 2;
            Right := Left + ATextHeight;
          end;
        raMinus90:
          begin
            Inc(Left, ADrawTextOffset.Bottom);
            Dec(Right, ADrawTextOffset.Top);
            Right := Right - (Right - Left - ATextHeight) div 2;
            Left := Right - ATextHeight;
          end;
      end;
  end;

  procedure CorrectTabContentWOffset(var AOffset: TcxPCWOffset; AIsCentering: Boolean);
  var
    ATempVar: Integer;
  begin
    if IsNativePainting and (Tab.PaintingPositionIndex in [2, 9, 12]) then
    begin
      ATempVar := AOffset.Left;
      AOffset.Left := AOffset.Right;
      AOffset.Right := ATempVar;
    end;

    if not IsTabPressable then
      Exit;

    if InternalGetTextRotationAngle(ParentControl) = raPlus90 then
    begin
      if AIsCentering then
      begin
        if IsTabBorderThick(TabVisibleIndex) then
        begin
          Dec(AOffset.Left);
          Inc(AOffset.Right);
        end;
      end
      else
        if IsTabBorderThick(TabVisibleIndex) then
        begin
          Dec(AOffset.Left);
          Inc(AOffset.Right);
        end;
    end
    else
      if IsTabBorderThick(TabVisibleIndex) then
      begin
        Inc(AOffset.Left);
        Dec(AOffset.Right);
      end;
  end;

  procedure CalculateImageWPosition;
  var
    ADrawImageOffset: TcxPCWOffset;
    AImageSize: TSize;
    AImageRect: TRect;
    ATextRotationAngle: TcxRotationAngle;
  begin
    AImageSize := GetTabBaseImageSize;
    if IsNativePainting then
      with Tab.FullRect do
        if IsVerticalText(ParentControl) then
          AImageRect := Rect(0, 0, Bottom - Top, Right - Left)
        else
          AImageRect := Rect(0, 0, Right - Left, Bottom - Top)
    else
      AImageRect := Tab.FullRect;
    ATextRotationAngle := InternalGetTextRotationAngle(ParentControl);
    ADrawImageOffset := GetDrawImageWithoutTextWOffset(TabVisibleIndex);
    CorrectTabContentWOffset(ADrawImageOffset, True);
    with AImageRect do
      case ATextRotationAngle of
        ra0:
          begin
            Inc(AImageRect.Left, ADrawImageOffset.Left);
            Dec(AImageRect.Right, ADrawImageOffset.Right);
            begin
              ImageRect.Left := Left + (Right - Left - AImageSize.cx) div 2;
              ImageRect.Right := ImageRect.Left + AImageSize.cx;
            end;
          end;
        raPlus90:
          begin
            Dec(AImageRect.Bottom, ADrawImageOffset.Left);
            Inc(AImageRect.Top, ADrawImageOffset.Right);
            if IsTabPressable then
            begin
              ImageRect.Top := Top + (Bottom - Top - AImageSize.cx) div 2;
              ImageRect.Bottom := ImageRect.Top + AImageSize.cx;
            end
            else
            begin
              ImageRect.Bottom := Bottom - (Bottom - Top - AImageSize.cx) div 2;
              ImageRect.Top := ImageRect.Bottom - AImageSize.cx;
            end;
          end;
        raMinus90:
          begin
            Inc(AImageRect.Top, ADrawImageOffset.Left);
            Dec(AImageRect.Bottom, ADrawImageOffset.Right);
            ImageRect.Top := Top + (Bottom - Top - AImageSize.cx) div 2;
            ImageRect.Bottom := ImageRect.Top + AImageSize.cx;
          end;
      end;
  end;

  procedure CalculateImageAndTextWPositions;

    function GetContentWOffset(ATabWidth, AContentWidth: Integer): Integer;
    var
      ACaptionAlignment: TAlignment;
    begin
      if not ParentInfo.Rotate or (ParentInfo.TabWidth > 0) or (ParentControl.MaxRotatedTabWidth > 0) then
        ACaptionAlignment := taCenter
      else
        ACaptionAlignment := ParentControl.TabCaptionAlignment;
      case ACaptionAlignment of
        taLeftJustify:
          Result := (ATabWidth - ParentControl.FMaxTabCaptionWidth) div 2;
        taRightJustify:
          Result := (ATabWidth - ParentControl.FMaxTabCaptionWidth) div 2 +
            ParentControl.FMaxTabCaptionWidth - AContentWidth;
      else
        Result := (ATabWidth - AContentWidth) div 2;
      end;
    end;

  var
    AContentWidth, W: Integer;
    AImageSize: TSize;
    ATabContentWOffset: TcxPCWOffset;
    AIsTabTooNarrow: Boolean;
    AVisibleTextWidth: Integer;
    R: TRect;

    procedure CalculateVisibleTextWidth;
    var
      ATempRect: TRect;
      L: Integer;
      S: string;
    begin
      ATempRect := Rect(0, 0, W - AContentWidth, 0);
      S := Tab.Caption;
      L := Length(S);
      SetLength(S, L + Length('....'));
      S[L + 1] := #0;
      DrawText(ParentInfo.Canvas.Handle, PChar(S), -1,
        ATempRect, DT_SINGLELINE or DT_CALCRECT or DT_END_ELLIPSIS or DT_MODIFYSTRING);
      SetLength(S, StrLen(PChar(S)));
      AVisibleTextWidth := ATempRect.Right;
      if (AVisibleTextWidth > W - AContentWidth) or (S = '&...') then
        AVisibleTextWidth := 0;
    end;

    procedure InternalCalculateImageAndTextWPositions;
    var
      AImageTextDistance: Integer;
    begin
      if AContentWidth <= 0 then
      begin
        ImageRect := cxEmptyRect;
        TextRect := cxEmptyRect;
        Exit;
      end;

      AImageTextDistance := GetImageTextDistance(TabVisibleIndex);
      case InternalGetTextRotationAngle(ParentControl) of
        ra0:
          begin
            Inc(R.Left, ATabContentWOffset.Left);
            if not AIsTabTooNarrow and not (AHasImages and ParentInfo.Rotate) then
              Inc(R.Left, GetContentWOffset(W, AContentWidth));
            if ATabHasImage then
            begin
              ImageRect.Left := R.Left + ParentInfo.ImageBorder;
              ImageRect.Right := ImageRect.Left + AImageSize.cx;
            end;
            if AHasImages and ParentInfo.Rotate or ATabHasImage then
              Inc(R.Left, ParentInfo.ImageBorder * 2 + AImageSize.cx + AImageTextDistance);

            if not AIsTabTooNarrow and AHasImages and ParentInfo.Rotate then
              Inc(R.Left, GetContentWOffset(R.Right - R.Left - ATabContentWOffset.Right, AVisibleTextWidth));
            TextRect.Left := R.Left;
            TextRect.Right := TextRect.Left + AVisibleTextWidth;
          end;
        raPlus90:
          begin
            Dec(R.Bottom, ATabContentWOffset.Left);
            if not AIsTabTooNarrow and not (AHasImages and ParentInfo.Rotate) then
              Dec(R.Bottom, GetContentWOffset(W, AContentWidth));
            if ATabHasImage then
            begin
              ImageRect.Bottom := R.Bottom - ParentInfo.ImageBorder;
              ImageRect.Top := ImageRect.Bottom - AImageSize.cx;
            end;
            if AHasImages and ParentInfo.Rotate or ATabHasImage then
              Dec(R.Bottom, ParentInfo.ImageBorder * 2 + AImageSize.cx + AImageTextDistance);

            if not AIsTabTooNarrow and AHasImages and ParentInfo.Rotate then
              Dec(R.Bottom, GetContentWOffset(R.Bottom - R.Top - ATabContentWOffset.Right, AVisibleTextWidth));
            TextRect.Bottom := R.Bottom;
            TextRect.Top := TextRect.Bottom - AVisibleTextWidth;
          end;
        raMinus90:
          begin
            Inc(R.Top, ATabContentWOffset.Left);
            if not AIsTabTooNarrow and not (AHasImages and ParentInfo.Rotate) then
              Inc(R.Top, GetContentWOffset(W, AContentWidth));
            if ATabHasImage then
            begin
              ImageRect.Top := R.Top + ParentInfo.ImageBorder;
              ImageRect.Bottom := ImageRect.Top + AImageSize.cx;
            end;
            if AHasImages and ParentInfo.Rotate or ATabHasImage then
              Inc(R.Top, ParentInfo.ImageBorder * 2 + AImageSize.cx + AImageTextDistance);

            if not AIsTabTooNarrow and AHasImages and ParentInfo.Rotate then
              Inc(R.Top, GetContentWOffset(R.Bottom - R.Top - ATabContentWOffset.Right, AVisibleTextWidth));
            TextRect.Top := R.Top;
            TextRect.Bottom := TextRect.Top + AVisibleTextWidth;
          end;
      end;
    end;

  begin
    if IsNativePainting then
      with Tab.FullRect do
        if IsVerticalText(ParentControl) then
          R := Rect(0, 0, Bottom - Top, Right - Left)
        else
          R := Rect(0, 0, Right - Left, Bottom - Top)
    else
      R := Tab.FullRect;
    if InternalIsVerticalText(ParentControl) then
      W := R.Bottom - R.Top
    else
      W := R.Right - R.Left;
    ATabContentWOffset := GetTabContentWOffset(TabVisibleIndex);
    CorrectTabContentWOffset(ATabContentWOffset, AHasImages);
    if IsTabPressable and AHasImages and (GetTextRotationAngle(ParentControl) = raPlus90) then
    begin
      Inc(ATabContentWOffset.Left);
      Dec(ATabContentWOffset.Right);
    end;
    Dec(W, ATabContentWOffset.Left + ATabContentWOffset.Right);
    AContentWidth := 0;
    if AHasImages and ParentInfo.Rotate or ATabHasImage then
    begin
      AImageSize := GetTabBaseImageSize;
      AContentWidth := AImageSize.cx + 2 * ParentInfo.ImageBorder + GetImageTextDistance(TabVisibleIndex);
    end;

    AIsTabTooNarrow := TextSize(Tab, Tab.Caption, ParentInfo.Canvas.Font).cx > W - AContentWidth;
    if AIsTabTooNarrow then
    begin
      Inc(W, ATabContentWOffset.Left + ATabContentWOffset.Right);
      ATabContentWOffset := GetTooNarrowTabContentWOffset(TabVisibleIndex);
      CorrectTabContentWOffset(ATabContentWOffset, AHasImages);
      if IsTabPressable and AHasImages and (GetTextRotationAngle(ParentControl) = raPlus90) then
      begin
        Inc(ATabContentWOffset.Left);
        Dec(ATabContentWOffset.Right);
      end;
      Dec(W, ATabContentWOffset.Left + ATabContentWOffset.Right);
    end;

    CalculateVisibleTextWidth;
    Inc(AContentWidth, AVisibleTextWidth);

    InternalCalculateImageAndTextWPositions;
  end;

  procedure CalculateWPositions;
  begin
    if ATabHasImage and (Tab.Caption = '') then
      CalculateImageWPosition;
    if Tab.Caption <> '' then
      CalculateImageAndTextWPositions;
  end;

begin
  Tab := ParentInfo.VisibleTabs[TabVisibleIndex];
  AHasImages := IsAssignedImages;
  ATabHasImage := IsTabHasImage(TabVisibleIndex);
  if not ATabHasImage then
    ImageRect := cxEmptyRect;
  if Tab.Caption = '' then
    TextRect := cxEmptyRect;
  CalculateImageHPosition;
  CalculateTextHPosition;
  CalculateWPositions;
  InternalPrepareOutTabImageAndTextData(TabVisibleIndex, ImageRect, TextRect);
end;

{ TcxPCPainterParentInfo }

constructor TcxPCPainterParentInfo.Create(
  AParent: TcxCustomTabControl);
begin
  inherited Create;
  FParent := AParent;
end;

function TcxPCPainterParentInfo.GetActivePage: TcxTabSheet;
begin
  Result := FParent.GetActivePage;
end;

function TcxPCPainterParentInfo.GetCanvas: TcxCanvas;
begin
  Result := FParent.Canvas;
end;

function TcxPCPainterParentInfo.GetFont: TFont;
begin
  Result := FParent.Font;
end;

function TcxPCPainterParentInfo.GetIsTabsContainer: Boolean;
begin
  Result := FParent.IsTabsContainer;
end;

function TcxPCPainterParentInfo.GetColor: TColor;
begin
  Result := FParent.Color;
end;

function TcxPCPainterParentInfo.GetExtendedBottomOrRightTabsRect: TRect;
begin
  Result := FParent.FExtendedBottomOrRightTabsRect;
end;

function TcxPCPainterParentInfo.GetExtendedTopOrLeftTabsRect: TRect;
begin
  Result := FParent.FExtendedTopOrLeftTabsRect;
end;

function TcxPCPainterParentInfo.GetHeight: Integer;
begin
  Result := FParent.Height;
end;

function TcxPCPainterParentInfo.GetHideTabs: Boolean;
begin
  Result := FParent.HideTabs;
end;

function TcxPCPainterParentInfo.GetImageBorder: Integer;
begin
  Result := FParent.ImageBorder;
end;

function TcxPCPainterParentInfo.GetMainTabVisibleIndex: Integer;
begin
  Result := FParent.FMainTabVisibleIndex;
end;

function TcxPCPainterParentInfo.GetMultiLine: Boolean;
begin
  Result := FParent.MultiLine;
end;

function TcxPCPainterParentInfo.GetNavigatorButtons: TcxPCNavigatorButtons;
begin
  Result := FParent.FNavigatorButtons;
end;

function TcxPCPainterParentInfo.GetNavigatorButtonState(
  Index: TcxPCNavigatorButton): TcxPCNavigatorButtonState;
begin
  Result := FParent.FNavigatorButtonStates[Index];
end;

function TcxPCPainterParentInfo.GetNavigatorPositione: TcxPCNavigatorPosition;
begin
  Result := FParent.NavigatorPosition;
end;

function TcxPCPainterParentInfo.GetOptions: TcxPCOptions;
begin
  Result := FParent.Options;
end;

function TcxPCPainterParentInfo.GetPageColor(ATabVisibleIndex: Integer): TColor;
var
  ATabSheet: TcxTabSheet;
begin
  ATabSheet := Pages[ATabVisibleIndex];
  if ATabSheet <> nil then
    Result := ATabSheet.Color
  else
    Result := FParent.Color;
end;

function TcxPCPainterParentInfo.GetPage(ATabVisibleIndex: Integer): TcxTabSheet;
begin
  Result := FParent.GetPage(VisibleTabs[ATabVisibleIndex].Index);
end;

function TcxPCPainterParentInfo.GetRaggedRight: Boolean;
begin
  Result := FParent.RaggedRight;
end;

function TcxPCPainterParentInfo.GetTabColor(ATabVisibleIndex: Integer): TColor;
var
  ATabSheet: TcxTabSheet;
begin
  ATabSheet := Pages[ATabVisibleIndex];
  Result := VisibleTabs[ATabVisibleIndex].Color;
  if (Result = clDefault) and (ATabSheet <> nil) and
    ((pcoUsePageColorForTab in Options) or FParent.Painter.AlwaysColoredTabs) and
    not ATabSheet.ParentColor then
      Result := ATabSheet.Color;
end;

function TcxPCPainterParentInfo.GetTabSlants: TcxTabSlants;
begin
  Result := FParent.TabSlants;
end;

function TcxPCPainterParentInfo.GetRotate: Boolean;
begin
  Result := FParent.Rotate;
end;

function TcxPCPainterParentInfo.GetRowCount: Integer;
begin
  Result := FParent.RowCount;
end;

function TcxPCPainterParentInfo.GetScrollOpposite: Boolean;
begin
  Result := FParent.ScrollOpposite;
end;

function TcxPCPainterParentInfo.GetShowFrame: Boolean;
begin
  Result := FParent.ShowFrame;
end;

function TcxPCPainterParentInfo.GetTabHeight: Smallint;
begin
  Result := FParent.TabHeight;
end;

function TcxPCPainterParentInfo.GetTabsOnBothSides: Boolean;
begin
  Result := (TabPosition in [tpTop, tpLeft]) and (TopOrLeftPartRowCount <> RowCount) or
    (TabPosition in [tpBottom, tpRight]) and (TopOrLeftPartRowCount <> 0);
end;

function TcxPCPainterParentInfo.GetTabPosition: TcxTabPosition;
begin
  Result := FParent.TabPosition;
end;

function TcxPCPainterParentInfo.GetTabWidth: Smallint;
begin
  Result := FParent.TabWidth;
end;

function TcxPCPainterParentInfo.GetTopOrLeftPartRowCount: Integer;
begin
  Result := FParent.TopOrLeftPartRowCount;
end;

function TcxPCPainterParentInfo.GetVisibleTab(
  TabVisibleIndex: Integer): TcxTab;
begin
  Result := FParent.FVisibleTabList[TabVisibleIndex];
end;

function TcxPCPainterParentInfo.GetWidth: Integer;
begin
  Result := FParent.Width;
end;

{ TcxVisibleTabList }

constructor TcxVisibleTabList.Create(AParent: TcxCustomTabControl);
begin
  inherited Create;
  FParent := AParent;
  TabIndexA := nil;
end;

destructor TcxVisibleTabList.Destroy;
begin
  TabIndexA := nil;
  inherited;
end;

function TcxVisibleTabList.GetCount: Integer;
begin
  Result := Length(TabIndexA);
end;

function TcxVisibleTabList.GetTab(TabVisibleIndex: Integer): TcxTab;
begin
  if (TabVisibleIndex < 0) or (TabVisibleIndex >= Count) then
    if Count = 0 then
      OutError('GetTab', scxPCVisibleTabListEmpty)
    else
      OutError('GetTab', Format(scxPCTabVisibleIndexOutsOfBounds, [TabVisibleIndex, Count - 1]));
  Result := FParent.TabsTabs[TabIndexA[TabVisibleIndex]];
end;

function TcxVisibleTabList.FindVisibleTab(TabIndex: TcxPCTabIndex; var TabVisibleIndex: Integer): Boolean;
var
  FirstIndex, LastIndex, MiddleIndex: Integer;
begin
  Result := False;
  TabVisibleIndex := 0;
  if (TabIndexA = nil) or (Length(TabIndexA) = 0) then Exit;

  FirstIndex := 0;
  Result := True;
  if TabIndex = TabIndexA[0] then Exit;
  Result := False;
  if TabIndex < TabIndexA[0] then Exit;

  LastIndex := Count - 1;
  TabVisibleIndex := LastIndex;
  Result := True;
  if TabIndex = TabIndexA[LastIndex] then Exit;
  Inc(TabVisibleIndex);
  Result := False;
  if TabIndex > TabIndexA[LastIndex] then Exit;

  while LastIndex - FirstIndex > 1 do
  begin
    MiddleIndex := (FirstIndex + LastIndex) div 2;
    if TabIndex = TabIndexA[MiddleIndex] then
    begin
      TabVisibleIndex := MiddleIndex;
      Result := True;
      Exit;
    end;
    if TabIndex < TabIndexA[MiddleIndex] then LastIndex := MiddleIndex
    else FirstIndex := MiddleIndex;
  end;
  TabVisibleIndex := LastIndex;
end;

procedure TcxVisibleTabList.HideTab(TabIndex: TcxPCTabIndex);
var
  TabVisibleIndex: Integer;
  OldCount: Integer;
begin
  if FindVisibleTab(TabIndex, TabVisibleIndex) then
  begin
    OldCount := Count;
    if TabVisibleIndex <> OldCount - 1 then
      Move(TabIndexA[TabVisibleIndex + 1], TabIndexA[TabVisibleIndex],
        (OldCount - TabVisibleIndex - 1) * SizeOf(TcxPCTabIndex));
    SetLength(TabIndexA, OldCount - 1);
  end;
end;

procedure TcxVisibleTabList.OutError(SourceMethodName: TCaption; Msg: string);
begin
  raise EdxException.Create('TcxVisibleTabList.' + SourceMethodName + ': ' + Msg);
end;

procedure TcxVisibleTabList.ShowTab(TabIndex: TcxPCTabIndex);
var
  TabVisibleIndex: Integer;
  OldCount: Integer;
begin
  if not FindVisibleTab(TabIndex, TabVisibleIndex) then
  begin
    OldCount := Count;
    SetLength(TabIndexA, OldCount + 1);
    if TabVisibleIndex <> OldCount then
      Move(TabIndexA[TabVisibleIndex], TabIndexA[TabVisibleIndex + 1],
        (OldCount - TabVisibleIndex) * SizeOf(TcxPCTabIndex));
    TabIndexA[TabVisibleIndex] := TabIndex;
  end;
end;

procedure TcxVisibleTabList.Update;
var
  VisibleTabCount: Integer;
  I, TabCount: TcxPCTabIndex;
begin
  with FParent.Tabs do
  begin
    VisibleTabCount := 0;
    TabCount := Count;
    for I := 0 to TabCount - 1 do
      if Tabs[I].Visible then Inc(VisibleTabCount);
    SetLength(TabIndexA, VisibleTabCount);

    VisibleTabCount := 0;
    for I := 0 to TabCount - 1 do
      if Tabs[I].Visible then
      begin
        TabIndexA[VisibleTabCount] := I;
        Inc(VisibleTabCount);
      end;
  end;
end;

function TcxVisibleTabList.TabVisibleIndexOf(TabIndex: TcxPCTabIndex): Integer;
begin
  if not FindVisibleTab(TabIndex, Result) then Result := -1;
end;

{ TcxTab }

constructor TcxTab.Create(ATabs: TcxTabs; AIndex: Integer);
begin
  inherited Create;
  FIndex := AIndex;
  FTabs := ATabs;

  FColor := clDefault;
  FEnabled := True;
  FImageIndex := AIndex;
  FVisible := True;
end;

destructor TcxTab.Destroy;
begin
  FTabs.Notify(Index, tnDeleting);
  FreeAndNil(FVerticalTextBitmap);
  FreeAndNil(FPaintBitmap);
  with ParentControl do
    if (FTracking <> -1) and (FTracking = VisibleIndex) then
      FTracking := -1;
  inherited;
end;

procedure TcxTab.InitializePaintBitmap;
begin
  if FPaintBitmap = nil then
    FPaintBitmap := TcxBitmap.CreateSize(0, 0, pf32bit);
end;

procedure TcxTab.ResetPaintBitmap;
begin
  FreeAndNil(FPaintBitmap);
end;

procedure TcxTab.ResetVerticalTextBitmap;
begin
  FreeAndNil(FVerticalTextBitmap);
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
  Tabs.Changed(VisibleIndex, ATabPropertyChanged);
end;

procedure TcxTab.ValidateImageIndex;
begin
  if FImageIndex = -1 then
    Exit;
  if RealVisible then
    Changed(tpcNotSpecified);
end;

function TcxTab.GetFullRect: TRect;
begin
  Result := NormalRect;
  ParentControl.CorrectTabRect(VisibleIndex);
  CorrectRect(Result, FTabPosition.TabRectCorrection);
end;

function TcxTab.GetHotTrack: Boolean;
var
  HotTrackTabVisibleIndex: Integer;
begin
  HotTrackTabVisibleIndex := ParentControl.FHotTrackTabVisibleIndex;
  Result := (HotTrackTabVisibleIndex <> -1) and (HotTrackTabVisibleIndex = VisibleIndex);
end;

function TcxTab.GetImageIndex: TImageIndex;
begin
  Result := ParentControl.GetImageIndex(Index);
end;

function TcxTab.GetIsMainTab: Boolean;
begin
  Result := Index = ParentControl.MainTabIndex;
end;

function TcxTab.GetNormalLongitudinalSize: Integer;
begin
  if ParentControl.Rotate then Result := Tabs.FTabNormalHeight
  else Result := FTabPosition.TabNormalWidth;
end;

function TcxTab.GetNormalRect: TRect;
begin
  Result.Left := FTabPosition.TabNormalPosition.X;
  Result.Top := FTabPosition.TabNormalPosition.Y;
  if IsVerticalText(ParentControl) then
  begin
    Result.Right := Result.Left + Tabs.TabNormalHeight;
    if ParentControl.Rotate then
      Result.Bottom := Result.Top + ParentControl.FRowHeight
    else
      Result.Bottom := Result.Top + FTabPosition.TabNormalWidth;
  end
  else
  begin
    if ParentControl.Rotate then
      Result.Right := Result.Left + ParentControl.FRowHeight
    else
      Result.Right := Result.Left + FTabPosition.TabNormalWidth;
    Result.Bottom := Result.Top + Tabs.TabNormalHeight;
  end;
end;

function TcxTab.GetPaintingPosition: TcxTabPosition;
var
  IsY: Boolean;
begin
  with ParentControl do
  begin
    IsY := TabPosition in [tpTop, tpBottom];
    if VisibleRow < TopOrLeftPartRowCount then
      if IsY then Result := tpTop
      else Result := tpLeft
    else
      if IsY then Result := tpBottom
      else Result := tpRight;
  end;
end;

function TcxTab.GetPaintingPositionIndex: Integer;
const
  APaintingPositionIndexMap: array [TcxTabPosition, TcxRotationAngle] of Integer = (
    (1, 2, 3, 0),
    (10, 11, 12, 0),
    (6, 4, 5, 0),
    (9, 7, 8, 0)
  );
begin
  Result := APaintingPositionIndexMap[PaintingPosition, GetTextRotationAngle(ParentControl)];
end;

function TcxTab.GetParentControl: TcxCustomTabControl;
begin
  Result := Tabs.Parent;
end;

function TcxTab.GetPressed: Boolean;
var
  PressedTabVisibleIndex: Integer;
begin
  PressedTabVisibleIndex := ParentControl.FPressedTabVisibleIndex;
  Result := (PressedTabVisibleIndex <> -1) and (PressedTabVisibleIndex = VisibleIndex);
end;

function TcxTab.GetRealEnabled: Boolean;
begin
  Result := ParentControl.Enabled and Enabled;
end;

function TcxTab.GetRealVisible: Boolean;
begin
  Result := not IsRectEmpty(VisibleRect)
end;

function TcxTab.GetTracking: Boolean;
begin
  with ParentControl do
    Result := (FTracking <> -1) and (FTracking = VisibleIndex);
end;

function TcxTab.GetVisibleIndex: Integer;
begin
  Result := ParentControl.FVisibleTabList.TabVisibleIndexOf(Index);
end;

function TcxTab.GetVisibleRect: TRect;
var
  ATabVisibleIndex: Integer;
begin
  Result := cxEmptyRect;
  if not Visible then
    Exit;
  with ParentControl do
  begin
    ATabVisibleIndex := VisibleIndex;
    if (not MultiLine) and
       ((ATabVisibleIndex < FFirstVisibleTab) or
        (ATabVisibleIndex > FLastVisibleTab)) then
      Exit;
    if VisibleRow < TopOrLeftPartRowCount then
      IntersectRect(Result, FullRect, FExtendedTopOrLeftTabsRect)
    else
      IntersectRect(Result, FullRect, FExtendedBottomOrRightTabsRect);
  end;
end;

procedure TcxTab.InternalSetCaption(const Value: string);
begin
  FCaption := Value;
end;

function TcxTab.IsImageIndexStored: Boolean;
begin
  Result := FImageIndex <> Index;
end;

procedure TcxTab.SetCaption(const Value: string);
var
  OldTabNormalWidth: Integer;
  TabLayoutChanged: Boolean;
  OldRealVisible: Boolean;
  OldRowHeight: Integer;
begin
  if Value <> FCaption then
    with FTabPosition do
    begin
      if not Visible then
      begin
        InternalSetCaption(Value);
        Exit;
      end;

      OldRealVisible := RealVisible;
      OldTabNormalWidth := TabNormalWidth;
      OldRowHeight := ParentControl.FRowHeight;

      InternalSetCaption(Value);
      ParentControl.CalculateTabNormalSize(Self);

      if ParentControl.Rotate then
      begin
        ParentControl.CalculateRowHeight;
        TabLayoutChanged := ParentControl.FRowHeight <> OldRowHeight;
      end
      else
        TabLayoutChanged := TabNormalWidth <> OldTabNormalWidth;

      if TabLayoutChanged then
        Changed(tpcLayout)
      else
        if OldRealVisible then Changed(tpcNotSpecified);
    end;
end;

procedure TcxTab.SetColor(Value: TColor);
begin
  if Value <> FColor then
  begin
    FColor := Value;
    if RealVisible then
      Changed(tpcColor);
  end;
end;

procedure TcxTab.SetEnabled(const Value: Boolean);
var
  OldRealVisible: Boolean;
begin
  if Value <> FEnabled then
  begin
    OldRealVisible := RealVisible;
    FEnabled := Value;
    if OldRealVisible or RealVisible then
      Changed(tpcEnabled);
  end;
end;

procedure TcxTab.SetHighlighted(const Value: Boolean);
var
  OldRealVisible: Boolean;
begin
  if Value <> FHighlighted then
  begin
    OldRealVisible := RealVisible;
    FHighlighted := Value;
    if OldRealVisible or RealVisible then
      Changed(tpcHighlighted);
  end;
end;

procedure TcxTab.SetImageIndex(Value: TImageIndex);
begin
  if Value < 0 then
    Value := -1;
  if Value <> FImageIndex then
  begin
    FImageIndex := Value;
    if not ParentControl.IsLoading and RealVisible then
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
      if Tabs.Tabs[I].Selected then
        Inc(Result);
  end;

var
  OldRealVisible: Boolean;
begin
  if Value <> FSelected then
  begin
    if csLoading in ParentControl.ComponentState then
    begin
      FSelected := Value;
      Exit;
    end;

    with ParentControl do
    begin
      if not FPainter.IsMultiSelectionAccepted then
      begin
        if Value and (Index <> TabIndex) then Exit;
      end else
        if Value and (GetSelectedTabCount > 0) and (not MultiSelect) then
          MultiSelect := True;
      OldRealVisible := RealVisible;
      FSelected := Value;
      if OldRealVisible or RealVisible then
        Self.Changed(tpcSelected);
    end;
  end;
end;

procedure TcxTab.SetVisible(const Value: Boolean);
var
  OldRealVisible: Boolean;
  IsTabIndexCorrectionNeeded: Boolean;
begin
  if Value <> FVisible then
    with ParentControl do
      if Value then
      begin
        FVisibleTabList.ShowTab(Index);
        FVisible := Value;
        Self.Changed(tpcLayout);
      end else
      begin
        IsTabIndexCorrectionNeeded := TabIndexTabMustBeVisible and (Index = TabIndex);
        OldRealVisible := RealVisible;
        FVisibleTabList.HideTab(Index);
        FVisible := Value;
        if OldRealVisible or MultiLine then
          Self.Changed(tpcLayout)
        else
          Calculate;
        if IsTabIndexCorrectionNeeded then
          if FMainTabVisibleIndex <> -1 then
            TabIndex := FVisibleTabList[FMainTabVisibleIndex].Index;
      end;
end;

{ TcxTabs }

constructor TcxTabs.Create(AParent: TcxCustomTabControl);
begin
  inherited Create;
  FTabsItemA := nil;
  FNotification := False;
  FParent := AParent;
  FUpdating := False;
end;

procedure TcxTabs.Delete(Index: Integer);
var
  NewTabCount: Integer;
begin
  if FUpdating then Exit;
  FUpdating := True;
  try
    if not FNotification then
    begin
      if (Index < 0) or (Index >= Count) then
        OutError('Delete', Index);
      FTabsItemA[Index].Free;
    end;
    NewTabCount := Count - 1;
    if Index < NewTabCount then
    begin
      System.Move(FTabsItemA[Index + 1], FTabsItemA[Index],
        (NewTabCount - Index) * SizeOf(TcxTab));
      UpdateTabIndexes(Index, NewTabCount - 1);
    end;
    SetLength(FTabsItemA, NewTabCount);

    Changed;
  finally
    FUpdating := False;
  end;
end;

destructor TcxTabs.Destroy;
begin
  Clear;
  inherited;
end;

function TcxTabs.Get(Index: Integer): string;
begin
  if (Index < 0) or (Index >= Count) then
    OutError('Get', Index);
  Result := FTabsItemA[Index].FCaption;
end;

function TcxTabs.GetCount: Integer;
begin
  Result := Length(FTabsItemA);
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
  if (TabIndex < 0) or (TabIndex >= Count) then
    OutError('GetTab', TabIndex);
  Result := FTabsItemA[TabIndex];
end;

function TcxTabs.GetVisibleTab(TabVisibleIndex: Integer): TcxTab;
var
  VisibleTabCount: Integer;
begin
  VisibleTabCount := Parent.FVisibleTabList.Count;
  if (TabVisibleIndex < 0) or (TabVisibleIndex >= VisibleTabCount) then
    raise EdxException.Create('TcxTabs.GetVisibleTab: ' + Format(scxPCTabVisibleIndexOutsOfBounds,
      [TabVisibleIndex, VisibleTabCount]));
  Result := Parent.FVisibleTabList[TabVisibleIndex];
end;

procedure TcxTabs.Insert(Index: Integer; const S: string);
var
  OldTabCount: Integer;
begin
  if (Index < 0) or (Index > Count) then
    OutError('Insert', Index);
  OldTabCount := Count;
  SetLength(FTabsItemA, OldTabCount + 1);
  if Index <> OldTabCount then
    System.Move(FTabsItemA[Index], FTabsItemA[Index + 1],
      (OldTabCount - Index) * SizeOf(TcxTab));
  FTabsItemA[Index] := TcxTab.Create(Self, Index);
  UpdateTabIndexes(Index + 1, OldTabCount);
  FTabsItemA[Index].InternalSetCaption(S);

  with Parent do
    if not (csLoading in ComponentState) and (FTabIndex = -1) then
      if Self.Count = 1 then FTabIndex := 0;

  Changed;
end;

procedure TcxTabs.Move(CurIndex, NewIndex: Integer);

  procedure CopyArray(AFromIndex, AToIndex, ACount: Integer);
  begin
    System.Move(FTabsItemA[AFromIndex], FTabsItemA[AToIndex], ACount * SizeOf(TcxTab));
  end;

var
  AcxTab: TcxTab;
begin
  if CurIndex <> NewIndex then
  begin
    AcxTab := FTabsItemA[CurIndex];
    if CurIndex > NewIndex then
      CopyArray(NewIndex, NewIndex + 1, CurIndex - NewIndex)
    else
      CopyArray(CurIndex + 1, CurIndex, NewIndex - CurIndex);
    FTabsItemA[NewIndex] := AcxTab;
    if CurIndex > NewIndex then
      UpdateTabIndexes(NewIndex, CurIndex)
    else
      UpdateTabIndexes(CurIndex, NewIndex);

    Changed;
  end;
end;

procedure TcxTabs.Notify(Index: Integer; Action: TcxPCTabNotification);
begin
  FNotification := True;
  try
    if Action = tnDeleting then
      Delete(Index);
  finally
    FNotification := False;
  end;
end;

class procedure TcxTabs.OutError(SourceMethodName: TCaption; Index: Integer);
begin
  raise EdxException.Create('TcxTabs.' + SourceMethodName + ': ' + Format(scxPCTabIndexError, [Index]));
end;

procedure TcxTabs.ResetTabVerticalTextBitmaps;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Tabs[I].ResetVerticalTextBitmap;
end;

procedure TcxTabs.Changed(AVisibleIndex: Integer = -1;
  ATabPropertyChanged: TcxPCTabPropertyChanged = tpcLayout);
begin
  if (AVisibleIndex = -1) and (ATabPropertyChanged = tpcLayout) then
    Parent.FVisibleTabList.Update;
  if (UpdateCount = 0) and ([csLoading, csDestroying] * Parent.ComponentState = []) then
  begin
    if (AVisibleIndex = -1) or (ATabPropertyChanged = tpcLayout) then
      Parent.RequestLayout
    else
      Parent.RepaintTab(AVisibleIndex, ATabPropertyChanged);
  end;
end;

procedure TcxTabs.Clear;
var
  I, TabCount: Integer;
begin
  TabCount := Count;
  if TabCount > 0 then
  begin
    for I := TabCount - 1 downto 0 do
      FTabsItemA[I].Free;
    FTabsItemA := nil;
    Changed;
  end;
end;

procedure TcxTabs.SetHotTrack(VisibleIndex: Integer);
var
  OldHotTrackTabVisibleIndex: Integer;
begin
  with Parent do
  begin
    if FHotTrackTabVisibleIndex = VisibleIndex then Exit;
    OldHotTrackTabVisibleIndex := FHotTrackTabVisibleIndex;
    FHotTrackTabVisibleIndex := VisibleIndex;
    if OldHotTrackTabVisibleIndex <> -1 then
      Self.Changed(OldHotTrackTabVisibleIndex, tpcHotTrack);
    if FHotTrackTabVisibleIndex <> -1 then
      Self.Changed(FHotTrackTabVisibleIndex, tpcHotTrack);
  end;
end;

procedure TcxTabs.SetMainTab;
var
  OldMainTabVisibleIndex: Integer;
begin
  with Parent do
  begin
    OldMainTabVisibleIndex := FMainTabVisibleIndex;
    if OldMainTabVisibleIndex >= FVisibleTabList.Count then
      OldMainTabVisibleIndex := -1;

    if FTabIndex = -1 then FMainTabVisibleIndex := -1
    else
      with FVisibleTabList do
        if not FindVisibleTab(FTabIndex, FMainTabVisibleIndex) and (FMainTabVisibleIndex = Count) then
          FMainTabVisibleIndex := Count - 1;

    if FMainTabVisibleIndex = OldMainTabVisibleIndex then Exit;
    if OldMainTabVisibleIndex <> -1 then
      Self.Changed(OldMainTabVisibleIndex, tpcIsMainTab);
    if FMainTabVisibleIndex <> -1 then
      Self.Changed(FMainTabVisibleIndex, tpcIsMainTab);

    UpdateButtonsState;
  end;
end;

procedure TcxTabs.SetTab(Index: Integer; const Value: TcxTab);
begin
  if (Index < 0) or (Index >= Count) then
    OutError('SetTab', Index);
  FTabsItemA[Index].Assign(Value);
end;

function TcxTabs.GetVisibleTabsCount: Integer;
begin
  Result := Parent.FVisibleTabList.Count;
end;

procedure TcxTabs.SetTracking(NewTracking: Integer);
var
  OldTracking: Integer;
begin
  with Parent do
  begin
    OldTracking := FTracking;
    if OldTracking >= FVisibleTabList.Count then
      OldTracking := -1;

    if (NewTracking < 0) or (NewTracking >= FVisibleTabList.Count) then
      NewTracking := -1;
    FTracking := NewTracking;

    if FTracking = OldTracking then Exit;
    if OldTracking <> -1 then
      Self.Changed(OldTracking, tpcTracking);
    if FTracking <> -1 then
      Self.Changed(FTracking, tpcTracking);

    if (FTracking <> -1) and not Multiline then
      begin
        CorrectFirstVisibleTab(FTracking);
        RequestLayout;
        SynchronizeHotTrackStates(InternalGetShiftState);
      end;
  end;
end;

procedure TcxTabs.UpdateTabIndexes(FirstIndex, LastIndex: Integer);
var
  I: Integer;
begin
  for I := FirstIndex to LastIndex do
    FTabsItemA[I].FIndex := I;
end;

procedure TcxTabs.ValidateImageIndexes;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    FTabsItemA[I].ValidateImageIndex;
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
    FPageControl.RemovePage(Self);
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
  if Assigned(FOnHide) then FOnHide(Self);
end;

procedure TcxTabSheet.DoShow;
begin
  if Assigned(FOnShow) then FOnShow(Self);
end;

procedure TcxTabSheet.EnabledChanged;
begin
  PagePropertyChanged;
end;

procedure TcxTabSheet.PagePropertyChanged;
begin
  if PageControl <> nil then
    PageControl.UpdateTab(Self);
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
begin
  if PageControl <> nil then
  begin
    if Painter.IsNativePainting then
      Painter.DrawNativeTabBackground(Message.DC, Self)
    else
    begin
      ASavedDC := SaveDC(Message.DC);
      try
        OffsetWindowOrgEx(Message.DC, Left, Top, nil);
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
    Result := PageControl.FPages.IndexOf(Self);
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
    if FPageControl <> nil then FPageControl.RemovePage(Self);
    if Value <> nil then
    begin
      Value.InsertPage(Self);
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
    PageControl.FPages.Move(AOldPageIndex, Value);
    PageControl.Tabs.Move(AOldPageIndex, Value);
    FTab := PageControl.Tabs.Tabs[Value];
    PageControl.UpdateTab(Self);
    PageControl.LockChangeEvent(True);
    try
      PageControl.TabIndex := PageControl.ActivePageIndex;
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

initialization

finalization
  FreeAndNil(FBackgroundBitmap);

end.
