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

unit dxRibbonBackstageView;

{$I cxVer.inc}

interface

uses
  Types, Windows, Classes, SysUtils, Messages, Controls, Graphics, Math, Forms,
  cxGraphics, cxGeometry, cxControls, cxClasses, dxBar, dxRibbon, dxRibbonSkins,
  dxCore, dxMessages, dxBarStrs, StdCtrls;

const
  dxRibbonBackstageViewMinMenuWidth: Integer = 132;
  dxRibbonBackstageViewMinOwnerHeight: Integer = 400;
  dxRibbonBackstageViewMinOwnerWidth: Integer = 500;

type
  TdxRibbonBackstageViewMenuBarButton = class;
  TdxRibbonBackstageViewMenuBarControl = class;
  TdxRibbonBackstageViewMenuButton = class;
  TdxRibbonBackstageViewMenuButtons = class;
  TdxRibbonBackstageViewMenuDockControl = class;
  TdxRibbonBackstageViewMenuViewInfo = class;
  TdxRibbonBackstageViewPainter = class;
  TdxRibbonBackstageViewTabSheet = class;
  TdxRibbonBackstageViewTabSheetButtonList = class;
  TdxRibbonCustomBackstageView = class;

  TdxRibbonBackstageViewChange = (rbvcStruct, rbvcItemsData, rbvcTabsData);
  TdxRibbonBackstageViewChanges = set of TdxRibbonBackstageViewChange;
  TdxRibbonBackstageViewMenuButtonPosition = (mbpBeforeTabs, mbpAfterTabs);

  IdxRibbonBackstageViewSelectableItem = interface
  ['{D5E058AB-1C90-4D21-BE0A-EB48530EF53B}']
    procedure SelectionChanged;
  end;

  { TdxRibbonBackstageViewCustomViewInfo }

  TdxRibbonBackstageViewCustomViewInfo = class(TcxIUnknownObject)
  private
    FBackstageView: TdxRibbonCustomBackstageView;
    function GetBarManager: TdxBarManager;
  public
    constructor Create(ABackstageView: TdxRibbonCustomBackstageView); virtual;
    procedure Calculate(const ABounds: TRect); virtual; abstract;
    //
    property BackstageView: TdxRibbonCustomBackstageView read FBackstageView;
    property BarManager: TdxBarManager read GetBarManager;
  end;

  { TdxRibbonBackstageViewMenuBarAccessibilityHelper }

  TdxRibbonBackstageViewMenuBarAccessibilityHelper = class(TdxRibbonBarControlAccessibilityHelper)
  private
    FKeyTipWindowsManager: IdxBarKeyTipWindowsManager;
    function GetMenuBarControl: TdxRibbonBackstageViewMenuBarControl;
    function GetRibbon: TdxCustomRibbon;
  protected
    function AreKeyTipsSupported(out AKeyTipWindowsManager: IdxBarKeyTipWindowsManager): Boolean; override;
    procedure KeyTipsEscapeHandler; override;
  public
    property MenuBarControl: TdxRibbonBackstageViewMenuBarControl read GetMenuBarControl;
    property Ribbon: TdxCustomRibbon read GetRibbon;
  end;

  { TdxRibbonBackstageViewMenuBarControl }

  TdxRibbonBackstageViewMenuBarControl = class(TdxRibbonCustomBarControl)
  private
    function GetBackstageView: TdxRibbonCustomBackstageView;
    function GetMenuViewInfo: TdxRibbonBackstageViewMenuViewInfo;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMShowKeyTips(var Message: TMessage); message DXM_BAR_SHOWKEYTIPS;
    procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
  protected
    procedure DoBarMouseDown(Button: TMouseButton; Shift: TShiftState;
      const APoint: TPoint; AItemControl: TdxBarItemControl; APointInClientRect: Boolean); override;
    function CalcColumnItemRect(AItemLink: TdxBarItemLink; const AItemsRect: TRect): TRect; override;
    function CanDrawClippedItem(AItemRect: TRect): Boolean; override;
    procedure CalcControlsPositions; override;
    function GetAccessibilityHelperClass: TdxBarAccessibilityHelperClass; override;
    function GetCaption: TCaption; override;
    function GetItemControlOffset(AItemLink: TdxBarItemLink): Integer; override;
    function GetItemsRectOffset: TRect; override;
    function GetMaxWidth(AStyle: TdxBarDockingStyle): Integer; override;
    function GetMinWidth(AStyle: TdxBarDockingStyle): Integer; override;
    function GetNextBarControl(AForward: Boolean): TdxBarControl; override;
    function GetRibbon: TdxCustomRibbon; override;
    function HasCaptionButtons: Boolean; override;
    function IsInternal: Boolean; override;
    function NeedsMouseWheel: Boolean; override;
    procedure MakeItemControlFullyVisible(AItemControl: TdxBarItemControl); override;
    procedure SetLayeredAttributes; override;
    procedure SetMouseSelectedItem(Value: TdxBarItemControl); override;
    procedure ShowPopup(AItem: TdxBarItemControl); override;
    procedure WndProc(var Message: TMessage); override;
    //
    property BackstageView: TdxRibbonCustomBackstageView read GetBackstageView;
    property MenuViewInfo: TdxRibbonBackstageViewMenuViewInfo read GetMenuViewInfo;
  public
    function IsVertical: Boolean; override;
  end;

  { TdxRibbonBackstageViewPainter }

  TdxRibbonBackstageViewPainter = class(TObject)
  private
    FBackstageView: TdxRibbonCustomBackstageView;
    function GetSkin: IdxSkin;
    function GetTopLineSize: Integer;
  public
    constructor Create(ABackstageView: TdxRibbonCustomBackstageView);
    procedure DrawBackground(ACanvas: TcxCanvas; const R: TRect); virtual;
    procedure DrawTopLine(ACanvas: TcxCanvas; const R: TRect); virtual;
    //
    property Skin: IdxSkin read GetSkin;
    property TopLineSize: Integer read GetTopLineSize;
  end;

  { TdxRibbonBackstageViewMenuPainter }

  TdxRibbonBackstageViewMenuPainter = class(TdxBarSkinnedPainter)
  protected
    procedure DrawToolbarContentPart(ABarControl: TdxBarControl; ACanvas: TcxCanvas); override;
    procedure DrawToolbarNonContentPart(ABarControl: TdxBarControl; DC: HDC); override;
    procedure GetDisabledTextColors(ABarItemControl: TdxBarItemControl;
      ASelected: Boolean; AFlat: Boolean; var AColor1, AColor2: TColor); override;
    function GetEnabledTextColor(ABarItemControl: TdxBarItemControl;
      ASelected: Boolean; AFlat: Boolean): TColor; override;
  public
    function GetToolbarContentOffsets(ABar: TdxBar;
      ADockingStyle: TdxBarDockingStyle; AHasSizeGrip: Boolean): TRect; override;
    procedure DrawButtonBackground(const ADrawParams: TdxBarButtonLikeControlDrawParams); override;
    procedure DockControlFillBackground(ADockControl: TdxDockControl; DC: HDC;
      ADestR: TRect; ASourceR: TRect; AWholeR: TRect; ABrush: HBRUSH; AColor: TColor); override;
    procedure DrawTabButton(const ADrawParams: TdxBarButtonLikeControlDrawParams; R: TRect); virtual;
    procedure DrawTabButtonBackground(DC: HDC; R: TRect; AState: Integer); virtual;
    function MenuBarButtonContentOffset: TRect; virtual;
    function MenuBarDefaultItemHeight: Integer; virtual;
    function MenuBarItemsRectIndent: TRect; virtual;
    function TabButtonContentOffset: TRect; virtual;
    function TabButtonDefaultHeight: Integer; virtual;
    function TabButtonTextColor(AState: Integer): TColor; virtual;
  end;

  { TdxRibbonBackstageViewMenuDockControl }

  TdxRibbonBackstageViewMenuDockControl = class(TdxBarDockControl)
  private
    FMenuViewInfo: TdxRibbonBackstageViewMenuViewInfo;
    function GetBackstageView: TdxRibbonCustomBackstageView;
    function GetRibbon: TdxCustomRibbon;
  protected
    procedure CalcLayout; override;
    function CanCustomize: Boolean; override;
    function GetClientSize: Integer; override;
    function GetDockedBarControlClass: TdxBarControlClass; override;
    function GetDockingStyle: TdxBarDockingStyle; override;
    function GetMinSize: Integer; override;
    function GetPainter: TdxBarPainter; override;
    function IsDrawDesignBorder: Boolean; override;
    // IdxRibbonToolBarContainer
    function GetContainer: TObject;
    //
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
  public
    constructor Create(AMenuViewInfo: TdxRibbonBackstageViewMenuViewInfo); reintroduce;
    //
    property BackstageView: TdxRibbonCustomBackstageView read GetBackstageView;
    property MenuViewInfo: TdxRibbonBackstageViewMenuViewInfo read FMenuViewInfo;
    property Ribbon: TdxCustomRibbon read GetRibbon;
  end;

  { TdxRibbonBackstageViewTabSheetViewInfo }

  TdxRibbonBackstageViewTabSheetViewInfo = class(TObject)
  private
    FBounds: TRect;
    FTab: TdxRibbonBackstageViewTabSheet;
    function GetFrameAreaVisibleBounds: TRect;
  protected
    function GetMinHeight: Integer; virtual;
    function GetMinWidth: Integer; virtual;
  public
    constructor Create(ATab: TdxRibbonBackstageViewTabSheet); virtual;
    procedure Calculate(const R: TRect); virtual;
    procedure ValidateWindowPos(var APos: TWindowPos);
    //
    property Bounds: TRect read FBounds;
    property FrameAreaVisibleBounds: TRect read GetFrameAreaVisibleBounds;
    property MinHeight: Integer read GetMinHeight;
    property MinWidth: Integer read GetMinWidth;
    property Tab: TdxRibbonBackstageViewTabSheet read FTab;
  end;

  { TdxRibbonBackstageViewTabSheetSizeOptions }

  TdxRibbonBackstageViewTabSheetSizeOptions = class(TPersistent)
  private
    FHasChanges: Boolean;
    FMinHeight: Integer;
    FMinWidth: Integer;
    FTab: TdxRibbonBackstageViewTabSheet;
    FUpdateCount: Integer;
    function GetAutoSize: Boolean;
    procedure SetAutoSize(AValue: Boolean);
    procedure SetMinHeight(AValue: Integer);
    procedure SetMinWidth(AValue: Integer);
  protected
    procedure Changed;
  public
    constructor Create(ATab: TdxRibbonBackstageViewTabSheet); virtual;
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate;
    procedure EndUpdate;
  published
    property AutoSize: Boolean read GetAutoSize write SetAutoSize default False;
    property MinHeight: Integer read FMinHeight write SetMinHeight default 0;
    property MinWidth: Integer read FMinWidth write SetMinWidth default 0;
  end;

  { TdxRibbonBackstageViewTabSheet }

  TdxRibbonBackstageViewTabSheet = class(TcxControl)
  private
    FBackstageView: TdxRibbonCustomBackstageView;
    FKeyTip: string;
    FSizeOptions: TdxRibbonBackstageViewTabSheetSizeOptions;
    FTabVisible: Boolean;
    FViewInfo: TdxRibbonBackstageViewTabSheetViewInfo;
    function GetActive: Boolean;
    function GetCanBeActive: Boolean;
    function GetPageIndex: Integer;
    function GetPainter: TdxRibbonBackstageViewPainter;
    procedure SetActive(AValue: Boolean);
    procedure SetBackstageView(AValue: TdxRibbonCustomBackstageView);
    procedure SetKeyTip(const AValue: string);
    procedure SetPageIndex(AValue: Integer);
    procedure SetSizeOptions(AValue: TdxRibbonBackstageViewTabSheetSizeOptions);
    procedure SetTabVisible(AValue: Boolean);
  protected
    function CanResize(var NewWidth, NewHeight: Integer): Boolean; override;
    function CreateViewInfo: TdxRibbonBackstageViewTabSheetViewInfo; virtual;
    procedure Activate; virtual;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure Calculate(const R: TRect); virtual;
    procedure Changed; virtual;
    procedure Deactivate; virtual;
    procedure DrawBackground(ACanvas: TcxCanvas);
    procedure Paint; override;
    procedure RefreshNonClientArea;
    procedure SetParent(AParent: TWinControl); override;
    //
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    //
    property CanBeActive: Boolean read GetCanBeActive;
    property Painter: TdxRibbonBackstageViewPainter read GetPainter;
    property ViewInfo: TdxRibbonBackstageViewTabSheetViewInfo read FViewInfo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    //
    property BackstageView: TdxRibbonCustomBackstageView read FBackstageView write SetBackstageView;
  published
    property Active: Boolean read GetActive write SetActive default False;
    property BorderWidth;
    property Caption;
    property Enabled;
    property Height stored False;
    property KeyTip: string read FKeyTip write SetKeyTip;
    property PageIndex: Integer read GetPageIndex write SetPageIndex stored False;
    property SizeOptions: TdxRibbonBackstageViewTabSheetSizeOptions read FSizeOptions write SetSizeOptions;
    property TabVisible: Boolean read FTabVisible write SetTabVisible default True;
    property Width stored False;
    //
    property OnResize;
  end;

  { TdxRibbonBackstageViewTabSheets }

  TdxRibbonBackstageViewTabSheets = class(TcxObjectList)
  private
    function GetItem(Index: Integer): TdxRibbonBackstageViewTabSheet;
  public
    property Items[Index: Integer]: TdxRibbonBackstageViewTabSheet read GetItem; default;
  end;

  { TdxRibbonBackstageViewTabSheetButton }

  TdxRibbonBackstageViewTabSheetButton = class(TdxBarButton)
  private
    FTab: TdxRibbonBackstageViewTabSheet;
    procedure SetTab(AValue: TdxRibbonBackstageViewTabSheet);
  protected
    function GetControlClass(AIsVertical: Boolean): TdxBarItemControlClass; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure RefreshInfo;
    //
    property Tab: TdxRibbonBackstageViewTabSheet read FTab write SetTab;
  end;

  { TdxRibbonBackstageViewTabSheetButtonControl }

  TdxRibbonBackstageViewTabSheetButtonControl = class(TdxBarButtonControl)
  private
    function GetItem: TdxRibbonBackstageViewTabSheetButton;
    function GetMenuPainter: TdxRibbonBackstageViewMenuPainter;
    function GetMenuViewInfo: TdxRibbonBackstageViewMenuViewInfo;
  protected
    function CanCustomize: Boolean; override;
    procedure ActivateTab;
    procedure ControlActivate(AImmediately: Boolean; AByMouse: Boolean); override;
    procedure ControlClick(AByMouse: Boolean; AKey: Char = #0); override;
    procedure ControlUnclick(AByMouse: Boolean); override;
    procedure DoPaint(ARect: TRect; PaintType: TdxBarPaintType); override;
    function GetDefaultHeight: Integer; override;
    procedure GetFadingParams(out AFadeOutImage, AFadeInImage: TcxBitmap;
      var AFadeInAnimationFrameCount, AFadeInAnimationFrameDelay: Integer;
      var AFadeOutAnimationFrameCount, AFadeOutAnimationFrameDelay: Integer); override;
    function IsDestroyOnClick: Boolean; override;
    //
    property Item: TdxRibbonBackstageViewTabSheetButton read GetItem;
    property MenuPainter: TdxRibbonBackstageViewMenuPainter read GetMenuPainter;
    property MenuViewInfo: TdxRibbonBackstageViewMenuViewInfo read GetMenuViewInfo;
  end;

  { TdxRibbonBackstageViewTabSheetButtonList }
                           
  TdxRibbonBackstageViewTabSheetButtonList = class(TcxObjectList)
  private
    function GetItem(Index: Integer): TdxRibbonBackstageViewTabSheetButton;
  public
    function GetItemByTab(ATab: TdxRibbonBackstageViewTabSheet): TdxRibbonBackstageViewTabSheetButton;
    procedure RefreshInfo;
    procedure RemoveTab(ATab: TdxRibbonBackstageViewTabSheet);
    //
    property Items[Index: Integer]: TdxRibbonBackstageViewTabSheetButton read GetItem; default;
  end;

  { TdxRibbonBackstageViewMenuButtonList }

  TdxRibbonBackstageViewMenuButtonList = class(TcxObjectList)
  private
    function GetItem(Index: Integer): TdxRibbonBackstageViewMenuBarButton;
  public
    procedure RefreshInfo;
    //
    property Items[Index: Integer]: TdxRibbonBackstageViewMenuBarButton read GetItem; default;
  end;

  { TdxRibbonBackstageViewMenuViewInfo }

  TdxRibbonBackstageViewMenuViewInfo = class(TdxRibbonBackstageViewCustomViewInfo, IdxBarLinksOwner)
  private
    FDockControl: TdxRibbonBackstageViewMenuDockControl;
    FItemLinks: TdxBarItemLinks;
    FMenuButtonList: TdxRibbonBackstageViewMenuButtonList;
    FMinHeight: Integer;
    FMinWidth: Integer;
    FPainter: TdxRibbonBackstageViewMenuPainter;
    FTabButtonList: TdxRibbonBackstageViewTabSheetButtonList;
    function GetAccessibilityHelper: IdxBarAccessibilityHelper;
    function GetBarControl: TdxRibbonBackstageViewMenuBarControl;
    function GetIsDesigning: Boolean;
    function GetRibbon: TdxCustomRibbon;
    procedure AddButton(AButton: TdxRibbonBackstageViewMenuButton);
    procedure AddTabButton(ATab: TdxRibbonBackstageViewTabSheet);
  protected
    function CreatePainter: TdxRibbonBackstageViewMenuPainter; virtual;
    procedure CreateBarControl;
    procedure CreateViewInfoItems;
    procedure DestroyViewInfoItems;
    // IdxBarLinksOwner
    function CanContainItem(AItem: TdxBarItem; out AErrorText: string): Boolean;
    function CreateItemLinksBarControl: TCustomdxBarControl;
    function GetInstance: TComponent;
    function GetItemLinks: TdxBarItemLinks;
    function IdxBarLinksOwner.CreateBarControl = CreateItemLinksBarControl;
    //
    property IsDesigning: Boolean read GetIsDesigning;
    property MenuButtonList: TdxRibbonBackstageViewMenuButtonList read FMenuButtonList;
    property Painter: TdxRibbonBackstageViewMenuPainter read FPainter;
    property TabButtonList: TdxRibbonBackstageViewTabSheetButtonList read FTabButtonList;
  public
    constructor Create(ABackstageView: TdxRibbonCustomBackstageView); override;
    destructor Destroy; override;
    procedure Calculate(const ABounds: TRect); override;
    procedure CalculateSizes;
    procedure ClearInternalLists;
    procedure RecreateItemLinks;
    procedure RefreshMenuButtonsInfo;
    procedure RefreshTabsInfo;
    procedure UpdateFont;
    //
    property AccessibilityHelper: IdxBarAccessibilityHelper read GetAccessibilityHelper;
    property BarControl: TdxRibbonBackstageViewMenuBarControl read GetBarControl;
    property DockControl: TdxRibbonBackstageViewMenuDockControl read FDockControl;
    property ItemLinks: TdxBarItemLinks read FItemLinks;
    property MinHeight: Integer read FMinHeight;
    property MinWidth: Integer read FMinWidth;
    property Ribbon: TdxCustomRibbon read GetRibbon;
  end;

  { TdxRibbonBackstageViewDesignSelector }

  TdxRibbonBackstageViewDesignSelector = class(TcxControl)
  private
    function CreateRegion: TcxRegionHandle;
    function GetDesignRect: TRect;
    function GetSelected: Boolean;
  protected
    procedure BoundsChanged; override;
    procedure Paint; override;
    //
    property DesignRect: TRect read GetDesignRect;
    property Selected: Boolean read GetSelected;
  end;

  { TdxRibbonBackstageViewViewInfo }

  TdxRibbonBackstageViewViewInfo = class(TdxRibbonBackstageViewCustomViewInfo)
  private
    FBounds: TRect;
    FContentHeight: Integer;
    FContentWidth: Integer;
    FFrameAreaBounds: TRect;
    FMenuViewInfo: TdxRibbonBackstageViewMenuViewInfo;
    FScrollPositionX: Integer;
    FScrollPositionY: Integer;
    function GetActiveTab: TdxRibbonBackstageViewTabSheet;
    function GetContentBounds: TRect;
    function GetDesignSelectorRect: TRect;
    function GetFrameAreaVisibleBounds: TRect;
    function GetMenuBarControl: TdxBarControl;
    procedure CheckScrollPosition(var AValue: Integer; AContentSize, ADisplaySize: Integer);
    procedure SetScrollPositionX(AValue: Integer);
    procedure SetScrollPositionY(AValue: Integer);
  protected
    function CalculateFrameBounds: TRect; virtual;
    function CalculateMenuBounds: TRect; virtual;
    function CalculateMinHeight: Integer; virtual;
    function CalculateMinWidth: Integer; virtual;
    function CreateMenuViewInfo: TdxRibbonBackstageViewMenuViewInfo; virtual;
  public
    constructor Create(ABackstageView: TdxRibbonCustomBackstageView); override;
    destructor Destroy; override;
    procedure Calculate(const ABounds: TRect); override;
    function ProcessMouseWheel(ALineDown: Boolean): Boolean;
    //
    property ActiveTab: TdxRibbonBackstageViewTabSheet read GetActiveTab;
    property Bounds: TRect read FBounds;
    property ContentBounds: TRect read GetContentBounds;
    property ContentHeight: Integer read FContentHeight;
    property ContentWidth: Integer read FContentWidth;
    property DesignSelectorRect: TRect read GetDesignSelectorRect;
    property FrameAreaBounds: TRect read FFrameAreaBounds;
    property FrameAreaVisibleBounds: TRect read GetFrameAreaVisibleBounds;
    property MenuBarControl: TdxBarControl read GetMenuBarControl;
    property MenuViewInfo: TdxRibbonBackstageViewMenuViewInfo read FMenuViewInfo;
    property ScrollPositionX: Integer read FScrollPositionX write SetScrollPositionX;
    property ScrollPositionY: Integer read FScrollPositionY write SetScrollPositionY;
  end;

  { TdxRibbonBackstageViewMenuBarButton }

  TdxRibbonBackstageViewMenuBarButton = class(TdxBarButton)
  private
    FMenuButton: TdxRibbonBackstageViewMenuButton;
    procedure SetMenuButton(AValue: TdxRibbonBackstageViewMenuButton);
  protected
    function GetControlClass(AIsVertical: Boolean): TdxBarItemControlClass; override;
  public
    procedure DirectClick; override;
    procedure RefreshInfo;
    //
    property MenuButton: TdxRibbonBackstageViewMenuButton read FMenuButton write SetMenuButton;
  end;

  { TdxRibbonBackstageViewMenuBarButtonControl }

  TdxRibbonBackstageViewMenuBarButtonControl = class(TdxBarButtonControl)
  private
    function GetBackstageView: TdxRibbonCustomBackstageView;
    function GetItem: TdxRibbonBackstageViewMenuBarButton;
    function GetMenuPainter: TdxRibbonBackstageViewMenuPainter;
  protected
    function CanCustomize: Boolean; override;
    function GetDefaultHeight: Integer; override;
    function GetViewStructure: TdxBarItemControlViewStructure; override;
    procedure CalcDrawParams(AFull: Boolean = True); override;
    procedure DoPaint(ARect: TRect; PaintType: TdxBarPaintType); override;
  public
    property BackstageView: TdxRibbonCustomBackstageView read GetBackstageView;
    property Item: TdxRibbonBackstageViewMenuBarButton read GetItem;
    property MenuPainter: TdxRibbonBackstageViewMenuPainter read GetMenuPainter;
  end;

  { TdxRibbonBackstageViewMenuButton }

  TdxRibbonBackstageViewMenuButton = class(TcxInterfacedCollectionItem,
    IdxRibbonBackstageViewSelectableItem, IdxBarComponentListener)
  private
    FItem: TdxBarButton;
    FPosition: TdxRibbonBackstageViewMenuButtonPosition;
    function GetCollection: TdxRibbonBackstageViewMenuButtons;
    procedure SetItem(AValue: TdxBarButton);
    procedure SetPosition(AValue: TdxRibbonBackstageViewMenuButtonPosition);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);
    // IdxRibbonBackstageViewSelectableItem
    procedure SelectionChanged;
    // IdxBarComponentListener
    procedure IdxBarComponentListener.EnabledChanged = BarComponentChanged;
    procedure IdxBarComponentListener.Changed = BarComponentChanged;
    procedure BarComponentChanged(AComponent: TdxBarComponent);
  public
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    //
    property Collection: TdxRibbonBackstageViewMenuButtons read GetCollection;
  published
    property Item: TdxBarButton read FItem write SetItem;
    property Position: TdxRibbonBackstageViewMenuButtonPosition read FPosition write SetPosition default mbpBeforeTabs;
  end;

  { TdxRibbonBackstageViewMenuButtons }

  TdxRibbonBackstageViewMenuButtons = class(TCollection)
  private
    FBackstageView: TdxRibbonCustomBackstageView;
    function GetItem(Index: Integer): TdxRibbonBackstageViewMenuButton;
    procedure SetItem(Index: Integer; Value: TdxRibbonBackstageViewMenuButton);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
    //
    property BackstageView: TdxRibbonCustomBackstageView read FBackstageView;
  public
    constructor Create(ABackstageView: TdxRibbonCustomBackstageView);
    function Add: TdxRibbonBackstageViewMenuButton;
    function IndexOf(AItem: TdxRibbonBackstageViewMenuButton): Integer;
    function Insert(AIndex: Integer): TdxRibbonBackstageViewMenuButton;
    //
    property Items[Index: Integer]: TdxRibbonBackstageViewMenuButton read GetItem write SetItem; default;
  end;

  { TdxRibbonCustomBackstageView }

  TdxRibbonBackstageViewTabChanging = procedure (Sender: TObject;
    ANewTab: TdxRibbonBackstageViewTabSheet; var AAllowChange: Boolean) of object;

  TdxRibbonCustomBackstageView = class(TcxControl, IdxRibbonApplicationMenu,
    IdxRibbonListener, IdxRibbonBackstageViewSelectableItem, IdxRibbonMouseWheelReceiver)
  private
    FActiveTab: TdxRibbonBackstageViewTabSheet;
    FButtons: TdxRibbonBackstageViewMenuButtons;
    FChanges: TdxRibbonBackstageViewChanges;
    FDesignSelector: TdxRibbonBackstageViewDesignSelector;
    FOnCloseUp: TNotifyEvent;
    FOnPopup: TNotifyEvent;
    FOnTabChanged: TNotifyEvent;
    FOnTabChanging: TdxRibbonBackstageViewTabChanging;
    FPainter: TdxRibbonBackstageViewPainter;
    FRibbon: TdxCustomRibbon;
    FTabs: TdxRibbonBackstageViewTabSheets;
    FUpdateCount: Integer;
    FViewInfo: TdxRibbonBackstageViewViewInfo;
    function CanActivateTab(ATab: TdxRibbonBackstageViewTabSheet): Boolean;
    function GetBarManager: TdxBarManager;
    function GetMenuViewInfo: TdxRibbonBackstageViewMenuViewInfo;
    function GetTabCount: Integer;
    function GetTabs(Index: Integer): TdxRibbonBackstageViewTabSheet;
    procedure RibbonAfterChange;
    procedure RibbonBeforeChange;
    procedure SetActiveTab(AValue: TdxRibbonBackstageViewTabSheet);
    procedure SetButtons(AValue: TdxRibbonBackstageViewMenuButtons);
    procedure SetRibbon(AValue: TdxCustomRibbon);
  protected
    FDesignHelper: IcxDesignHelper;
    function CreateDesignSelector: TdxRibbonBackstageViewDesignSelector; virtual;
    function CreatePainter: TdxRibbonBackstageViewPainter; virtual;
    function CreateViewInfo: TdxRibbonBackstageViewViewInfo; virtual;
    procedure BoundsChanged; override;
    procedure Calculate; virtual;
    procedure CalculateFirstFramePosition;
    procedure Changed(const AChanges: TdxRibbonBackstageViewChanges = []); virtual;
    procedure CreateWnd; override;
    //
    procedure DoAddTab(ATab: TdxRibbonBackstageViewTabSheet);
    procedure DoRemoveTab(ATab: TdxRibbonBackstageViewTabSheet);
    procedure DoTabVisibleChanged(ATab: TdxRibbonBackstageViewTabSheet);
    function GetNextTab(AIndex: Integer): TdxRibbonBackstageViewTabSheet; overload;
    function GetNextTab(ATab: TdxRibbonBackstageViewTabSheet): TdxRibbonBackstageViewTabSheet; overload;
    procedure ValidateActiveTab;
    //
    procedure DoCloseUp;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    procedure DoPopup;
    procedure DoTabChanged;
    function DoTabChanging(ANewTab: TdxRibbonBackstageViewTabSheet): Boolean;
  {$IFNDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}
    procedure InitScrollBarsParameters; override;
    function NeedsToBringInternalControlsToFront: Boolean; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure MakeFullyVisible(R: TRect);
    procedure Paint; override;
    procedure PopupMessageLoop;
    procedure Scroll(AScrollBarKind: TScrollBarKind;
      AScrollCode: TScrollCode; var AScrollPos: Integer); override;
    procedure SystemFontChanged(Sender: TObject; const AEventArgs);
    // Design
    function IsObjectSelected(AObject: TPersistent): Boolean;
    procedure SelectObject(AObject: TPersistent);
    // IdxRibbonListener
    procedure AfterBarManagerChange;
    procedure BeforeBarManagerChange;
    // IdxRibbonApplicationMenu
    function CanShowPopup(ARibbon: TdxCustomRibbon): Boolean;
    function ClosePopup: Boolean;
    function GetOrigin(AIsClientArea: Boolean): TPoint;
    function GetRootAccessibilityHelper: IdxBarAccessibilityHelper;
    function IsPopupFrameMode: Boolean;
    function Popup(ARibbon: TdxCustomRibbon; var AClosedByEscape: Boolean): Boolean;
    procedure SelectAppMenuFirstItemControl;
    procedure ShowControl(AControl: TControl); override;
    procedure ShowKeyTips;
    procedure UpdateColorScheme;
    // IdxRibbonMouseWheelReceiver
    function CanProcessMouseWheel: Boolean;
    // IdxRibbonBackstageViewSelectableItem
    procedure SelectionChanged;
    //
    procedure CMFastCommand(var Message: TMessage); message DXM_BAR_FASTCOMMAND;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    //
    property BarManager: TdxBarManager read GetBarManager;
    property DesignSelector: TdxRibbonBackstageViewDesignSelector read FDesignSelector;
    property MenuViewInfo: TdxRibbonBackstageViewMenuViewInfo read GetMenuViewInfo;
    property Painter: TdxRibbonBackstageViewPainter read FPainter;
    property ViewInfo: TdxRibbonBackstageViewViewInfo read FViewInfo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AddTab: TdxRibbonBackstageViewTabSheet;
    procedure DeleteAllTabs;
    procedure DeleteTab(AIndex: Integer);
    procedure FullRefresh;
  {$IFDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}
    procedure BeginUpdate;
    procedure EndUpdate;
    //
    property ActiveTab: TdxRibbonBackstageViewTabSheet read FActiveTab write SetActiveTab;
    property Buttons: TdxRibbonBackstageViewMenuButtons read FButtons write SetButtons;
    property OnCloseUp: TNotifyEvent read FOnCloseUp write FOnCloseUp;
    property OnPopup: TNotifyEvent read FOnPopup write FOnPopup;
    property OnTabChanged: TNotifyEvent read FOnTabChanged write FOnTabChanged;
    property OnTabChanging: TdxRibbonBackstageViewTabChanging read FOnTabChanging write FOnTabChanging;
    property Ribbon: TdxCustomRibbon read FRibbon write SetRibbon;
    property TabCount: Integer read GetTabCount;
    property Tabs[Index: Integer]: TdxRibbonBackstageViewTabSheet read GetTabs;
  end;

  { TdxRibbonBackstageView }

  TdxRibbonBackstageView = class(TdxRibbonCustomBackstageView)
  published
    property Buttons;
    property OnCloseUp;
    property OnPopup;
    property OnTabChanged;
    property OnTabChanging;
    property Ribbon;
  end;

var
  FOnRegisterBackstageView: TcxNotifyProcedure;
  FOnUnregisterBackstageView: TcxNotifyProcedure;

implementation

uses
  cxDrawTextUtils, dxBarSkinConsts;

const
  dxBackstageViewScrollLineSize = 17;

type
  TdxBarButtonAccess = class(TdxBarButton);
  TdxBarItemControlAccess = class(TdxBarItemControl);
  TWinControlAccess = class(TWinControl);

function FindRibbon(AOwner: TComponent): TdxCustomRibbon;
var
  I: Integer;
begin
  Result := nil;
  if Assigned(AOwner) then
  begin
    for I := 0 to AOwner.ComponentCount - 1 do
      if AOwner.Components[I] is TdxCustomRibbon then
      begin
        Result := TdxCustomRibbon(AOwner.Components[I]);
        Break;
      end;
  end;
end;

procedure RegisterBackstageView(ABackstageView: TdxRibbonCustomBackstageView);
begin
  if Assigned(FOnRegisterBackstageView) then
    FOnRegisterBackstageView(ABackstageView);
end;

procedure UnregisterBackstageView(ABackstageView: TdxRibbonCustomBackstageView);
begin
  if Assigned(FOnUnregisterBackstageView) then
    FOnUnregisterBackstageView(ABackstageView);
end;

{ TdxRibbonCustomBackstageView }

constructor TdxRibbonCustomBackstageView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPainter := CreatePainter;
  FViewInfo := CreateViewInfo;
  FTabs := TdxRibbonBackstageViewTabSheets.Create;
  FButtons := TdxRibbonBackstageViewMenuButtons.Create(Self);
  if IsDesigning then
  begin
    FDesignSelector := CreateDesignSelector;
    Ribbon := FindRibbon(AOwner);
  end;
  LookAndFeel.NativeStyle := True;
  RegisterBackstageView(Self);
  SetBounds(Left, Top, 450, 300);
  Visible := IsDesigning;
end;

destructor TdxRibbonCustomBackstageView.Destroy;
begin
  UnregisterBackstageView(Self);
  ActiveTab := nil;
  DeleteAllTabs;
  Ribbon := nil;
  FreeAndNil(FTabs);
  FreeAndNil(FPainter);
  FreeAndNil(FButtons);
  FreeAndNil(FViewInfo);
  FreeAndNil(FDesignSelector);
  inherited Destroy;
end;

function TdxRibbonCustomBackstageView.AddTab: TdxRibbonBackstageViewTabSheet;
begin
  Result := TdxRibbonBackstageViewTabSheet.Create(Owner);
  Result.BackstageView := Self;
end;

procedure TdxRibbonCustomBackstageView.AfterBarManagerChange;
begin
  if BarManager <> nil then
    BarManager.SystemFontChangedHandlers.Add(SystemFontChanged);
  MenuViewInfo.CreateViewInfoItems;
end;

procedure TdxRibbonCustomBackstageView.BeforeBarManagerChange;
begin
  if BarManager <> nil then
    BarManager.SystemFontChangedHandlers.Remove(SystemFontChanged);
  MenuViewInfo.DestroyViewInfoItems;
end;

function TdxRibbonCustomBackstageView.CanProcessMouseWheel: Boolean;
begin
  Result := Enabled and Visible;
end;

function TdxRibbonCustomBackstageView.CanShowPopup(ARibbon: TdxCustomRibbon): Boolean;
begin
  Result := Assigned(Ribbon) and (ARibbon = Ribbon);
end;

function TdxRibbonCustomBackstageView.ClosePopup: Boolean;
begin
  Hide;
  Result := True;
end;

function TdxRibbonCustomBackstageView.CreateDesignSelector: TdxRibbonBackstageViewDesignSelector;
begin
  Result := TdxRibbonBackstageViewDesignSelector.Create(Self);
  Result.Parent := Self;
end;

function TdxRibbonCustomBackstageView.CreatePainter: TdxRibbonBackstageViewPainter;
begin
  Result := TdxRibbonBackstageViewPainter.Create(Self);
end;

function TdxRibbonCustomBackstageView.CreateViewInfo: TdxRibbonBackstageViewViewInfo;
begin
  Result := TdxRibbonBackstageViewViewInfo.Create(Self);
end;

function TdxRibbonCustomBackstageView.IsPopupFrameMode: Boolean;
begin
  Result := True;
end;

function TdxRibbonCustomBackstageView.Popup(
  ARibbon: TdxCustomRibbon; var AClosedByEscape: Boolean): Boolean;
var
  AForm: TCustomForm;
  ASavedBounds, R: TRect;
  ASavedConstraints: TSizeConstraints;
begin
  Result := CanShowPopup(ARibbon);
  if Result then
  begin
    ASavedConstraints := TSizeConstraints.Create(nil);
    try
      DoPopup;
      Ribbon.BringToFront;
      AForm := GetParentForm(Ribbon);
      ASavedBounds := AForm.BoundsRect;
      ASavedConstraints.Assign(AForm.Constraints);
      try
        ViewInfo.ScrollPositionX := 0;
        ViewInfo.ScrollPositionY := 0;
        AForm.Constraints.MinHeight := dxRibbonBackstageViewMinOwnerHeight;
        AForm.Constraints.MinWidth := dxRibbonBackstageViewMinOwnerWidth;
        CalculateFirstFramePosition;
        R := AForm.BoundsRect;
        BringToFront;
        Show;
        PopupMessageLoop;
      finally
        AForm.Constraints.Assign(ASavedConstraints);
        if EqualRect(AForm.BoundsRect, R) then
          AForm.BoundsRect := ASavedBounds;
        DoCloseUp;
      end;
    finally
      ASavedConstraints.Free;
    end;
  end;
end;

procedure TdxRibbonCustomBackstageView.PopupMessageLoop;
var
  AMessage: TMsg;
begin
  repeat
    case Integer(GetMessage(AMessage, 0, 0, 0)) of
      -1: Break;
       0: begin
            PostQuitMessage(AMessage.wParam);
            Break;
          end;
    end;

    if not Visible then
      PostMessage(AMessage.hwnd, AMessage.Message, AMessage.wParam, AMessage.lParam)
    else
      if (AMessage.Message = WM_KEYDOWN) and (AMessage.wParam = VK_ESCAPE) then
        ClosePopup
      else
      begin
        TranslateMessage(AMessage);
        DispatchMessage(AMessage);
      end;
  until not Visible;
end;

procedure TdxRibbonCustomBackstageView.SelectAppMenuFirstItemControl;
begin
  BarNavigationController.ChangeSelectedObject(False,
    MenuViewInfo.AccessibilityHelper.GetBarHelper.GetFirstSelectableObject);
end;

procedure TdxRibbonCustomBackstageView.SelectionChanged;
begin
  if DesignSelector <> nil then
    DesignSelector.Invalidate;
end;

procedure TdxRibbonCustomBackstageView.ShowControl(AControl: TControl);
begin
  if AControl is TdxRibbonBackstageViewTabSheet then
    TdxRibbonBackstageViewTabSheet(AControl).Active := True;
  inherited ShowControl(AControl);
end;

procedure TdxRibbonCustomBackstageView.ShowKeyTips;
begin
  BarNavigationController.SetKeyTipsShowingState(MenuViewInfo.AccessibilityHelper, '');
  SelectAppMenuFirstItemControl;
end;

procedure TdxRibbonCustomBackstageView.UpdateColorScheme;
begin
  FullRefresh;
end;

procedure TdxRibbonCustomBackstageView.BoundsChanged;
begin
  inherited BoundsChanged;
  Changed;
end;

procedure TdxRibbonCustomBackstageView.Calculate;
var
  I: Integer;
begin
  ViewInfo.Calculate(ClientBounds);
  for I := 0 to TabCount - 1 do
    Tabs[I].Calculate(ViewInfo.FrameAreaBounds);
  if DesignSelector <> nil then
  begin
    if not BarDesignController.IsDesignerModifiedLocked then
    begin
      DesignSelector.BoundsRect := ViewInfo.DesignSelectorRect;
      DesignSelector.BringToFront;
    end;
  end;
end;

function TdxRibbonCustomBackstageView.CanActivateTab(ATab: TdxRibbonBackstageViewTabSheet): Boolean;
begin
  Result := ((ATab = nil) or ATab.CanBeActive) and (IsDesigning or DoTabChanging(ATab));
end;

procedure TdxRibbonCustomBackstageView.Changed(const AChanges: TdxRibbonBackstageViewChanges);
begin
  if FUpdateCount > 0 then
    FChanges := FChanges + AChanges
  else
    if not IsDestroying and HandleAllocated then
    begin
      if rbvcStruct in AChanges then
        MenuViewInfo.RecreateItemLinks
      else
      begin
        if rbvcItemsData in AChanges then
          MenuViewInfo.RefreshMenuButtonsInfo;
        if rbvcTabsData in AChanges then
          MenuViewInfo.RefreshTabsInfo;
      end;
      Calculate;
      ValidateActiveTab;
      UpdateScrollBars;
      Invalidate;
    end;
end;

procedure TdxRibbonCustomBackstageView.CreateWnd;
begin
  inherited CreateWnd;
  FullRefresh;
end;

procedure TdxRibbonCustomBackstageView.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TdxRibbonCustomBackstageView.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
  begin
    Changed(FChanges);
    FChanges := [];
  end;
end;

procedure TdxRibbonCustomBackstageView.DeleteAllTabs;
begin
  BeginUpdate;
  try
    while TabCount > 0 do
      Tabs[TabCount - 1].Free;
  finally
    EndUpdate;
  end;
end;

procedure TdxRibbonCustomBackstageView.DeleteTab(AIndex: Integer);
begin
  Tabs[AIndex].Free;
end;

procedure TdxRibbonCustomBackstageView.DoAddTab(ATab: TdxRibbonBackstageViewTabSheet);
begin
  FTabs.Add(ATab);
  if ActiveTab = nil then
    ValidateActiveTab;
  if ActiveTab <> nil then
    ActiveTab.BringToFront;
  Changed([rbvcStruct]);
end;

procedure TdxRibbonCustomBackstageView.DoCloseUp;
begin
  CallNotify(FOnCloseUp, Self);
end;

function TdxRibbonCustomBackstageView.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
    Result := ViewInfo.ProcessMouseWheel(True);
end;

function TdxRibbonCustomBackstageView.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos);
  if not Result then
    Result := ViewInfo.ProcessMouseWheel(False);
end;

procedure TdxRibbonCustomBackstageView.DoPopup;
begin
  CallNotify(FOnPopup, Self);
end;

procedure TdxRibbonCustomBackstageView.DoRemoveTab(ATab: TdxRibbonBackstageViewTabSheet);

  function GetNewActiveTab: TdxRibbonBackstageViewTabSheet;
  begin
    if ActiveTab = ATab then
      Result := GetNextTab(ATab.PageIndex)
    else
      Result := ActiveTab;
  end;

var
  ANewActiveTab: TdxRibbonBackstageViewTabSheet;
begin
  ANewActiveTab := GetNewActiveTab;
  MenuViewInfo.TabButtonList.RemoveTab(ATab);
  FTabs.Extract(ATab);
  ActiveTab := ANewActiveTab;
  Changed([rbvcStruct]);
end;

procedure TdxRibbonCustomBackstageView.DoTabChanged;
begin
  CallNotify(OnTabChanged, Self);
end;

function TdxRibbonCustomBackstageView.DoTabChanging(ANewTab: TdxRibbonBackstageViewTabSheet): Boolean;
begin
  Result := True;
  if Assigned(OnTabChanging) then
    OnTabChanging(Self, ANewTab, Result);
end;

procedure TdxRibbonCustomBackstageView.DoTabVisibleChanged(ATab: TdxRibbonBackstageViewTabSheet);
begin
  BeginUpdate;
  try
    if not ATab.TabVisible then
      ActiveTab := GetNextTab(ATab);
    Changed([rbvcStruct, rbvcTabsData]);
  finally
    EndUpdate;
  end;
end;

procedure TdxRibbonCustomBackstageView.FullRefresh;
begin
  if HandleAllocated then
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or SWP_FRAMECHANGED);
  if ActiveTab <> nil then
    ActiveTab.RefreshNonClientArea;
  Changed([rbvcStruct, rbvcItemsData, rbvcTabsData]);
end;

procedure TdxRibbonCustomBackstageView.CalculateFirstFramePosition;
var
  R: TRect;
begin
  Align := alClient;
  //#AI: prevent from flics on first show
  //ToDo - find better solution
  R := BoundsRect;
  TWinControlAccess(Parent).AdjustClientRect(R);
  BoundsRect := R;
end;

procedure TdxRibbonCustomBackstageView.InitScrollBarsParameters;
begin
  SetScrollBarInfo(sbHorizontal, 0, ViewInfo.ContentWidth, dxBackstageViewScrollLineSize,
    cxRectWidth(ViewInfo.Bounds) + 1, ViewInfo.ScrollPositionX, True, True);
  SetScrollBarInfo(sbVertical, 0, ViewInfo.ContentHeight, dxBackstageViewScrollLineSize,
    cxRectHeight(ViewInfo.Bounds) + 1, ViewInfo.ScrollPositionY, True, True);
end;

procedure TdxRibbonCustomBackstageView.Notification(
  AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Buttons <> nil then
    Buttons.Notification(AComponent, Operation);
  if not (csDestroying in ComponentState) and (Operation = opRemove) and
    (AComponent = Ribbon) then
      Ribbon := nil;
end;

procedure TdxRibbonCustomBackstageView.MakeFullyVisible(R: TRect);

  function CalculateScrollPosition(ASourceBound1, ASourceBound2: Integer;
    ATargetBound1, ATargetBound2, APosition: Integer): Integer;
  begin
    if ATargetBound1 < ASourceBound1 then
      Result := APosition - ASourceBound1 + ATargetBound1
    else
      if ATargetBound2 > ASourceBound2 then
        Result := APosition - ASourceBound2 + ATargetBound2
      else
        Result := APosition;
  end;

begin
  ViewInfo.ScrollPositionX := CalculateScrollPosition(ViewInfo.Bounds.Left,
    ViewInfo.Bounds.Right, R.Left, R.Right, ViewInfo.ScrollPositionX);
  ViewInfo.ScrollPositionY := CalculateScrollPosition(ViewInfo.Bounds.Top,
    ViewInfo.Bounds.Bottom, R.Top, R.Bottom, ViewInfo.ScrollPositionY);
end;

function TdxRibbonCustomBackstageView.NeedsToBringInternalControlsToFront: Boolean;
begin
  Result := True;
end;

function TdxRibbonCustomBackstageView.IsObjectSelected(AObject: TPersistent): Boolean;
begin
  Result := Assigned(FDesignHelper) and FDesignHelper.IsObjectSelected(Self, AObject);
end;

procedure TdxRibbonCustomBackstageView.Paint;
begin
  Painter.DrawBackground(Canvas, ViewInfo.FrameAreaBounds);
end;

procedure TdxRibbonCustomBackstageView.Scroll(
  AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
  var AScrollPos: Integer);
begin
  case AScrollBarKind of
    sbHorizontal:
      begin
        ViewInfo.ScrollPositionX := AScrollPos;
        AScrollPos := ViewInfo.ScrollPositionX;
      end;

    sbVertical:
      begin
        ViewInfo.ScrollPositionY := AScrollPos;
        AScrollPos := ViewInfo.ScrollPositionY;
      end;
  end;
end;

procedure TdxRibbonCustomBackstageView.SelectObject(AObject: TPersistent);
begin
  if Assigned(FDesignHelper) then
    FDesignHelper.SelectObject(Self, AObject);
end;

procedure TdxRibbonCustomBackstageView.SystemFontChanged(Sender: TObject; const AEventArgs);
begin
  MenuViewInfo.UpdateFont;
  FullRefresh;
end;

procedure TdxRibbonCustomBackstageView.RibbonAfterChange;
begin
  if not IsDesigning then
    Parent := Ribbon;
  if Assigned(Ribbon) then
    Ribbon.AddListener(Self);
  AfterBarManagerChange;
end;

procedure TdxRibbonCustomBackstageView.RibbonBeforeChange;
begin
  BeforeBarManagerChange;
  if Assigned(Ribbon) then
    Ribbon.RemoveListener(Self);
end;

procedure TdxRibbonCustomBackstageView.ValidateActiveTab;
begin
  if (ActiveTab = nil) or not ActiveTab.CanBeActive then
    ActiveTab := GetNextTab(ActiveTab);
end;

procedure TdxRibbonCustomBackstageView.CMFastCommand(var Message: TMessage);
var
  AMenuButton: TdxRibbonBackstageViewMenuButton;
begin
  AMenuButton := TdxRibbonBackstageViewMenuButton(Message.LParam);
  if Buttons.IndexOf(AMenuButton) >= 0 then
  begin
    if Assigned(AMenuButton.Item) then
      TdxBarButtonAccess(AMenuButton.Item).DirectClick;
  end;
end;

procedure TdxRibbonCustomBackstageView.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  Inc(Message.CalcSize_Params^.rgrc[0].Top, Painter.TopLineSize);
end;

procedure TdxRibbonCustomBackstageView.WMNCPaint(var Message: TWMNCPaint);
var
  DC: HDC;
begin
  DC := GetDCEx(Handle, 0, DCX_CACHE or DCX_CLIPSIBLINGS or DCX_WINDOW or DCX_VALIDATE);
  try
    cxPaintCanvas.BeginPaint(DC);
    try
      Painter.DrawTopLine(cxPaintCanvas, cxRectSetHeight(ClientRect, Painter.TopLineSize));
    finally
      cxPaintCanvas.EndPaint;
    end;
  finally
    ReleaseDC(Handle, DC);
  end;
end;

function TdxRibbonCustomBackstageView.GetBarManager: TdxBarManager;
begin
  if Assigned(Ribbon) then
    Result := Ribbon.BarManager
  else
    Result := nil;
end;

procedure TdxRibbonCustomBackstageView.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to TabCount - 1 do
    Proc(Tabs[I]);
end;

function TdxRibbonCustomBackstageView.GetMenuViewInfo: TdxRibbonBackstageViewMenuViewInfo;
begin
  Result := ViewInfo.MenuViewInfo;
end;

function TdxRibbonCustomBackstageView.GetNextTab(ATab: TdxRibbonBackstageViewTabSheet): TdxRibbonBackstageViewTabSheet;
var
  AIndex: Integer;
begin
  if ATab = nil then
    AIndex := -1
  else
    AIndex := ATab.PageIndex;

  Result := GetNextTab(AIndex);
end;

function TdxRibbonCustomBackstageView.GetNextTab(AIndex: Integer): TdxRibbonBackstageViewTabSheet;
var
  I: Integer;
begin
  Result := nil;
  for I := AIndex + 1 to TabCount - 1 do
    if Tabs[I].CanBeActive then
    begin
      Result := Tabs[I];
      Exit;
    end;

  for I := AIndex - 1 downto 0 do
    if Tabs[I].CanBeActive then
    begin
      Result := Tabs[I];
      Exit;
    end;
end;

function TdxRibbonCustomBackstageView.GetOrigin(AIsClientArea: Boolean): TPoint;
begin
  Result := cxNullPoint;
end;

function TdxRibbonCustomBackstageView.GetTabs(Index: Integer): TdxRibbonBackstageViewTabSheet;
begin
  Result := FTabs[Index];
end;

function TdxRibbonCustomBackstageView.GetTabCount: Integer;
begin
  Result := FTabs.Count;
end;

function TdxRibbonCustomBackstageView.GetRootAccessibilityHelper: IdxBarAccessibilityHelper;
begin
  if Assigned(MenuViewInfo.BarControl) then
    Result := MenuViewInfo.BarControl.IAccessibilityHelper
  else
    Result := nil;
end;

procedure TdxRibbonCustomBackstageView.SetActiveTab(AValue: TdxRibbonBackstageViewTabSheet);
begin
  if (FActiveTab <> AValue) and CanActivateTab(AValue) then
  begin
    if ActiveTab <> nil then
      ActiveTab.Deactivate;
    FActiveTab := AValue;
    if ActiveTab <> nil then
      ActiveTab.Activate;
    if IsDesigning and not IsLoading then
      Modified;
    Changed([rbvcTabsData]);
    DoTabChanged;
  end;
end;

procedure TdxRibbonCustomBackstageView.SetButtons(AValue: TdxRibbonBackstageViewMenuButtons);
begin
  FButtons.Assign(AValue);
end;

procedure TdxRibbonCustomBackstageView.SetRibbon(AValue: TdxCustomRibbon);
begin
  if AValue <> FRibbon then
  begin
    RibbonBeforeChange;
    FRibbon := AValue;
    RibbonAfterChange;
    FullRefresh;
  end;
end;

{ TdxRibbonBackstageViewTabSheetSizeOptions }

constructor TdxRibbonBackstageViewTabSheetSizeOptions.Create(ATab: TdxRibbonBackstageViewTabSheet);
begin
  inherited Create;
  FTab := ATab;
end;

procedure TdxRibbonBackstageViewTabSheetSizeOptions.Assign(Source: TPersistent);
begin
  if Source is TdxRibbonBackstageViewTabSheetSizeOptions then
  begin
    BeginUpdate;
    try
      MinWidth := TdxRibbonBackstageViewTabSheetSizeOptions(Source).MinWidth;
      MinHeight := TdxRibbonBackstageViewTabSheetSizeOptions(Source).MinHeight;
      AutoSize := TdxRibbonBackstageViewTabSheetSizeOptions(Source).AutoSize;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TdxRibbonBackstageViewTabSheetSizeOptions.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TdxRibbonBackstageViewTabSheetSizeOptions.EndUpdate;
begin
  Dec(FUpdateCount);
  if (FUpdateCount = 0) and FHasChanges then
    Changed;
end;

procedure TdxRibbonBackstageViewTabSheetSizeOptions.Changed;
begin
  if FUpdateCount > 0 then
    FHasChanges := True
  else
  begin
    FHasChanges := False;
    FTab.Changed;
  end;
end;

function TdxRibbonBackstageViewTabSheetSizeOptions.GetAutoSize: Boolean;
begin
  Result := FTab.AutoSize;
end;

procedure TdxRibbonBackstageViewTabSheetSizeOptions.SetAutoSize(AValue: Boolean);
begin
  FTab.AutoSize := AValue;
end;

procedure TdxRibbonBackstageViewTabSheetSizeOptions.SetMinHeight(AValue: Integer);
begin
  AValue := Max(AValue, 0);
  if AValue <> FMinHeight then
  begin
    FMinHeight := AValue;
    Changed;
  end;
end;

procedure TdxRibbonBackstageViewTabSheetSizeOptions.SetMinWidth(AValue: Integer);
begin
  AValue := Max(AValue, 0);
  if AValue <> FMinWidth then
  begin
    FMinWidth := AValue;
    Changed;
  end;
end;

{ TdxRibbonBackstageViewTabSheet }

constructor TdxRibbonBackstageViewTabSheet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csAcceptsControls];
  FSizeOptions := TdxRibbonBackstageViewTabSheetSizeOptions.Create(Self);
  FViewInfo := CreateViewInfo;
  FTabVisible := True;
  Visible := False;
end;

destructor TdxRibbonBackstageViewTabSheet.Destroy;
begin
  FreeAndNil(FViewInfo);
  FreeAndNil(FSizeOptions);
  inherited Destroy;
end;

procedure TdxRibbonBackstageViewTabSheet.Activate;
begin
  Visible := True;
  BringToFront;
end;

procedure TdxRibbonBackstageViewTabSheet.AlignControls(AControl: TControl; var Rect: TRect);
begin
  inherited AlignControls(AControl, Rect);
  RefreshNonClientArea;
end;

procedure TdxRibbonBackstageViewTabSheet.Calculate(const R: TRect);
begin
  ViewInfo.Calculate(R);
  BoundsRect := ViewInfo.Bounds;
end;

procedure TdxRibbonBackstageViewTabSheet.Changed;
begin
  if BackstageView <> nil then
  begin
    BarDesignController.LockDesignerModified;
    try
      BackstageView.Changed([rbvcTabsData]);
    finally
      BarDesignController.UnLockDesignerModified;
    end;
  end;
end;

function TdxRibbonBackstageViewTabSheet.CanResize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := inherited CanResize(NewWidth, NewHeight);
  if Result then
  begin
    NewHeight := Max(NewHeight, ViewInfo.MinHeight);
    NewWidth := Max(NewWidth, ViewInfo.MinWidth);
  end;
end;

function TdxRibbonBackstageViewTabSheet.CreateViewInfo: TdxRibbonBackstageViewTabSheetViewInfo;
begin
  Result := TdxRibbonBackstageViewTabSheetViewInfo.Create(Self);
end;

procedure TdxRibbonBackstageViewTabSheet.Deactivate;
begin
  Visible := False;
end;

procedure TdxRibbonBackstageViewTabSheet.DrawBackground(ACanvas: TcxCanvas);
begin
  Painter.DrawBackground(ACanvas, cxRectInflate(ClientRect, BorderWidth, BorderWidth));
end;

procedure TdxRibbonBackstageViewTabSheet.Paint;
begin
  DrawBackground(Canvas);
end;

procedure TdxRibbonBackstageViewTabSheet.RefreshNonClientArea;
begin
  if (BorderWidth > 0) and HandleAllocated then
    SendMessage(Handle, WM_NCPAINT, 0, 0);
end;

procedure TdxRibbonBackstageViewTabSheet.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Changed;
end;

procedure TdxRibbonBackstageViewTabSheet.CMTextChanged(var Message: TMessage);
begin
  inherited;
  Changed;
end;

procedure TdxRibbonBackstageViewTabSheet.WMNCPaint(var Message: TWMNCPaint);
var
  DC: HDC;
  R: TRect;
begin
  if BorderWidth > 0 then
  begin
    DC := GetWindowDC(Handle);
    try
      cxPaintCanvas.BeginPaint(DC);
      try
        R := Rect(0, 0, Width, Height);
        cxPaintCanvas.ExcludeClipRect(cxRectInflate(R, -BorderWidth, -BorderWidth));
        Painter.DrawBackground(cxPaintCanvas, R);
      finally
        cxPaintCanvas.EndPaint;
      end;
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;

function TdxRibbonBackstageViewTabSheet.GetActive: Boolean;
begin
  Result := (BackstageView <> nil) and (BackstageView.ActiveTab = Self);
end;

function TdxRibbonBackstageViewTabSheet.GetCanBeActive: Boolean;
begin
  Result := IsDesigning or TabVisible and Enabled;
end;

function TdxRibbonBackstageViewTabSheet.GetPageIndex: Integer;
begin
  if BackstageView = nil then
    Result := -1
  else
    Result := BackstageView.FTabs.IndexOf(Self);
end;

function TdxRibbonBackstageViewTabSheet.GetPainter: TdxRibbonBackstageViewPainter;
begin
  Result := BackstageView.Painter;
end;

procedure TdxRibbonBackstageViewTabSheet.SetPageIndex(AValue: Integer);
begin
  if Assigned(BackstageView) and (AValue <> PageIndex) then
  begin
    if (AValue >= 0) and (AValue < BackstageView.TabCount) then
    begin
      BackstageView.FTabs.Move(PageIndex, AValue);
      BackstageView.Changed([rbvcStruct]);
    end;
  end;
end;

procedure TdxRibbonBackstageViewTabSheet.SetActive(AValue: Boolean);
begin
  if AValue and (BackstageView <> nil) then
    BackstageView.ActiveTab := Self;
end;

procedure TdxRibbonBackstageViewTabSheet.SetBackstageView(AValue: TdxRibbonCustomBackstageView);
begin
  if AValue <> BackstageView then
  begin
    if BackstageView <> nil then
      BackstageView.DoRemoveTab(Self);
    FBackstageView := AValue;
    Parent := BackstageView;
    if BackstageView <> nil then
      BackstageView.DoAddTab(Self);
  end;
end;

procedure TdxRibbonBackstageViewTabSheet.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if Assigned(ViewInfo) then
  begin
    ATop := ViewInfo.Bounds.Top;
    ALeft := ViewInfo.Bounds.Left;
    AWidth := cxRectWidth(ViewInfo.Bounds);
    AHeight := cxRectHeight(ViewInfo.Bounds);
  end;
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure TdxRibbonBackstageViewTabSheet.SetKeyTip(const AValue: string);
begin
  if AValue <> FKeyTip then
  begin
    FKeyTip := AValue;
    Changed;
  end;
end;

procedure TdxRibbonBackstageViewTabSheet.SetParent(AParent: TWinControl);
begin
  if (AParent = nil) or (AParent is TdxRibbonCustomBackstageView) then
  begin
    BackstageView := TdxRibbonCustomBackstageView(AParent);
    inherited SetParent(AParent);
  end
  else
    Abort;
end;

procedure TdxRibbonBackstageViewTabSheet.SetSizeOptions(AValue: TdxRibbonBackstageViewTabSheetSizeOptions);
begin
  FSizeOptions.Assign(AValue);
end;

procedure TdxRibbonBackstageViewTabSheet.SetTabVisible(AValue: Boolean);
begin
  if AValue <> FTabVisible then
  begin
    FTabVisible := AValue;
    if BackstageView <> nil then
      BackstageView.DoTabVisibleChanged(Self);
  end;
end;

{ TdxRibbonBackstageViewTabSheetViewInfo }

constructor TdxRibbonBackstageViewTabSheetViewInfo.Create(ATab: TdxRibbonBackstageViewTabSheet);
begin
  inherited Create;
  FTab := ATab;
end;

procedure TdxRibbonBackstageViewTabSheetViewInfo.Calculate(const R: TRect);
begin
  FBounds := R;
end;

procedure TdxRibbonBackstageViewTabSheetViewInfo.ValidateWindowPos(var APos: TWindowPos);
begin
  APos.x := Bounds.Left;
  APos.y := Bounds.Top;
  APos.cx := cxRectWidth(Bounds);
  APos.cy := cxRectHeight(Bounds);
end;

function TdxRibbonBackstageViewTabSheetViewInfo.GetFrameAreaVisibleBounds: TRect;
begin
  Result := Tab.BackstageView.ViewInfo.FrameAreaVisibleBounds;
end;

function TdxRibbonBackstageViewTabSheetViewInfo.GetMinHeight: Integer;
var
  ANewWidth, ANewHeight: Integer;
begin
  Result := cxRectHeight(FrameAreaVisibleBounds);
  if Tab.SizeOptions.MinHeight > 0 then
    Result := Max(Result, Tab.SizeOptions.MinHeight);
  if Tab.SizeOptions.AutoSize then
  begin
    Tab.CanAutoSize(ANewWidth, ANewHeight);
    Result := Max(Result, ANewHeight);
  end;
end;

function TdxRibbonBackstageViewTabSheetViewInfo.GetMinWidth: Integer;
var
  ANewWidth, ANewHeight: Integer;
begin
  Result := cxRectWidth(FrameAreaVisibleBounds);
  if Tab.SizeOptions.MinWidth > 0 then
    Result := Max(Result, Tab.SizeOptions.MinWidth);
  if Tab.SizeOptions.AutoSize then
  begin
    Tab.CanAutoSize(ANewWidth, ANewHeight);
    Result := Max(Result, ANewWidth);
  end;
end;

{ TdxRibbonBackstageViewTabSheets }

function TdxRibbonBackstageViewTabSheets.GetItem(Index: Integer): TdxRibbonBackstageViewTabSheet;
begin
  Result := TdxRibbonBackstageViewTabSheet(inherited Items[Index]);
end;

{ TdxRibbonBackstageViewMenuDockControl }

constructor TdxRibbonBackstageViewMenuDockControl.Create(
  AMenuViewInfo: TdxRibbonBackstageViewMenuViewInfo);
begin
  inherited Create(AMenuViewInfo.BackstageView);
  FMenuViewInfo := AMenuViewInfo;
end;

procedure TdxRibbonBackstageViewMenuDockControl.CalcLayout;
begin
  if Assigned(MenuViewInfo.BarControl) then
    MenuViewInfo.BarControl.BoundsRect := cxRectSetHeight(ClientRect, MenuViewInfo.MinHeight);
end;

function TdxRibbonBackstageViewMenuDockControl.CanCustomize: Boolean;
begin
  Result := False;
end;

procedure TdxRibbonBackstageViewMenuDockControl.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  Message.Result := 0;
end;

function TdxRibbonBackstageViewMenuDockControl.GetBackstageView: TdxRibbonCustomBackstageView;
begin
  Result := MenuViewInfo.BackstageView;
end;

function TdxRibbonBackstageViewMenuDockControl.GetContainer: TObject;
begin
  Result := BackstageView;
end;

function TdxRibbonBackstageViewMenuDockControl.GetClientSize: Integer;
begin
  Result := MenuViewInfo.MinWidth;
end;

function TdxRibbonBackstageViewMenuDockControl.GetDockedBarControlClass: TdxBarControlClass;
begin
  Result := TdxRibbonBackstageViewMenuBarControl;
end;

function TdxRibbonBackstageViewMenuDockControl.GetDockingStyle: TdxBarDockingStyle;
begin
  Result := dsLeft;
end;

function TdxRibbonBackstageViewMenuDockControl.GetMinSize: Integer;
begin
  Result := MenuViewInfo.MinWidth;
end;

function TdxRibbonBackstageViewMenuDockControl.GetPainter: TdxBarPainter;
begin
  Result := MenuViewInfo.Painter;
end;

function TdxRibbonBackstageViewMenuDockControl.GetRibbon: TdxCustomRibbon;
begin
  Result := MenuViewInfo.Ribbon;
end;

function TdxRibbonBackstageViewMenuDockControl.IsDrawDesignBorder: Boolean;
begin
  Result := False;
end;

{ TdxRibbonBackstageViewMenuBarAccessibilityHelper }

function TdxRibbonBackstageViewMenuBarAccessibilityHelper.AreKeyTipsSupported(
  out AKeyTipWindowsManager: IdxBarKeyTipWindowsManager): Boolean;
begin
  Result := True;
  if FKeyTipWindowsManager = nil then
    FKeyTipWindowsManager := TdxRibbonKeyTipWindows.Create(Ribbon);
  AKeyTipWindowsManager := FKeyTipWindowsManager;
end;

procedure TdxRibbonBackstageViewMenuBarAccessibilityHelper.KeyTipsEscapeHandler;
begin
  MenuBarControl.BackstageView.ClosePopup;
  PostMessage(MenuBarControl.Handle, DXM_BAR_SHOWKEYTIPS, 0, 0);
end;

function TdxRibbonBackstageViewMenuBarAccessibilityHelper.GetMenuBarControl: TdxRibbonBackstageViewMenuBarControl;
begin
  Result := TdxRibbonBackstageViewMenuBarControl(FOwnerObject);
end;

function TdxRibbonBackstageViewMenuBarAccessibilityHelper.GetRibbon: TdxCustomRibbon;
begin
  Result := MenuBarControl.Ribbon;
end;

{ TdxRibbonBackstageViewMenuBarControl }

function TdxRibbonBackstageViewMenuBarControl.CalcColumnItemRect(
  AItemLink: TdxBarItemLink; const AItemsRect: TRect): TRect;
begin
  Result := inherited CalcColumnItemRect(AItemLink, AItemsRect);
  if AItemLink.Control is TdxRibbonBackstageViewTabSheetButtonControl then
  begin
    with GetItemsRectOffset do
    begin
      Inc(Result.Right, Right);
      Dec(Result.Left, Left);
    end;
  end;
end;

procedure TdxRibbonBackstageViewMenuBarControl.CalcControlsPositions;
begin
  inherited CalcControlsPositions;
  CalcItemRects(ptMenu);
end;

function TdxRibbonBackstageViewMenuBarControl.CanDrawClippedItem(AItemRect: TRect): Boolean;
begin
  Result := True;
end;

procedure TdxRibbonBackstageViewMenuBarControl.DoBarMouseDown(
  Button: TMouseButton; Shift: TShiftState; const APoint: TPoint;
  AItemControl: TdxBarItemControl; APointInClientRect: Boolean);
begin
  if BackstageView.IsDesigning then
  begin
    if AItemControl is TdxRibbonBackstageViewMenuBarButtonControl then
      BackstageView.SelectObject(TdxRibbonBackstageViewMenuBarButtonControl(AItemControl).Item.MenuButton)
    else
      if AItemControl is TdxRibbonBackstageViewTabSheetButtonControl then
      begin
        TdxRibbonBackstageViewTabSheetButtonControl(AItemControl).Item.Tab.Active := True;
        BackstageView.SelectObject(TdxRibbonBackstageViewTabSheetButtonControl(AItemControl).Item.Tab);
      end;
  end;
  inherited DoBarMouseDown(Button, Shift, APoint, AItemControl, APointInClientRect);
end;

function TdxRibbonBackstageViewMenuBarControl.GetAccessibilityHelperClass: TdxBarAccessibilityHelperClass;
begin
  Result := TdxRibbonBackstageViewMenuBarAccessibilityHelper;
end;

function TdxRibbonBackstageViewMenuBarControl.GetBackstageView: TdxRibbonCustomBackstageView;
begin
  Result := MenuViewInfo.BackstageView;
end;

function TdxRibbonBackstageViewMenuBarControl.GetCaption: TCaption;
begin
  Result := '';
end;

function TdxRibbonBackstageViewMenuBarControl.GetMenuViewInfo: TdxRibbonBackstageViewMenuViewInfo;
begin
  Result := TdxRibbonBackstageViewMenuDockControl(DockControl).MenuViewInfo;
end;

function TdxRibbonBackstageViewMenuBarControl.GetItemControlOffset(
  AItemLink: TdxBarItemLink): Integer;
begin
  Result := inherited GetItemControlOffset(AItemLink) + 1;
end;

function TdxRibbonBackstageViewMenuBarControl.GetItemsRectOffset: TRect;
begin
  Result := MenuViewInfo.Painter.MenuBarItemsRectIndent;
end;

function TdxRibbonBackstageViewMenuBarControl.GetMaxWidth(AStyle: TdxBarDockingStyle): Integer;
begin
  Result := GetMinWidth(AStyle);
end;

function TdxRibbonBackstageViewMenuBarControl.GetMinWidth(AStyle: TdxBarDockingStyle): Integer;
var
  AControl: TdxBarItemControl;
  I: Integer;
begin
  Result := 0;
  for I := 0 to ItemLinks.CanVisibleItemCount - 1 do
  begin
    AControl := ItemLinks.CanVisibleItems[I].Control;
    if AControl <> nil then
    begin
      if not (AControl is TdxRibbonBackstageViewTabSheetButtonControl) then
        Result := Max(Result, TdxBarItemControlAccess(AControl).Width);
    end;
  end;
  with GetItemsRectOffset do
    Inc(Result, Left + Right);
  Result := Max(Result, dxRibbonBackstageViewMinMenuWidth);
end;

function TdxRibbonBackstageViewMenuBarControl.GetNextBarControl(AForward: Boolean): TdxBarControl;
begin
  Result := nil;
end;

function TdxRibbonBackstageViewMenuBarControl.GetRibbon: TdxCustomRibbon;
begin
  Result := MenuViewInfo.Ribbon;
end;

function TdxRibbonBackstageViewMenuBarControl.HasCaptionButtons: Boolean;
begin
  Result := False;
end;

function TdxRibbonBackstageViewMenuBarControl.IsInternal: Boolean;
begin
  Result := True;
end;

function TdxRibbonBackstageViewMenuBarControl.IsVertical: Boolean;
begin
  Result := False;
end;

procedure TdxRibbonBackstageViewMenuBarControl.MakeItemControlFullyVisible(AItemControl: TdxBarItemControl);
var
  R: TRect;
begin
  if DockControl <> nil then
  begin
    R := AItemControl.ViewInfo.Bounds;
    MapWindowRect(Handle, BackstageView.Handle, R);
    BackstageView.MakeFullyVisible(R);
  end;
end;

function TdxRibbonBackstageViewMenuBarControl.NeedsMouseWheel: Boolean;
begin
  Result := BackstageView.CanProcessMouseWheel;
end;

procedure TdxRibbonBackstageViewMenuBarControl.SetLayeredAttributes;
begin
  //nothing
end;

procedure TdxRibbonBackstageViewMenuBarControl.SetMouseSelectedItem(Value: TdxBarItemControl);
var
  AItem: TdxRibbonBackstageViewTabSheetButton;
begin
  if Value = nil then
  begin
    AItem := MenuViewInfo.TabButtonList.GetItemByTab(BackstageView.ActiveTab);
    if (AItem <> nil) and (AItem.LinkCount > 0) then
      Value := AItem.Links[0].Control;
  end;
  inherited SetMouseSelectedItem(Value);
end;

procedure TdxRibbonBackstageViewMenuBarControl.ShowPopup(AItem: TdxBarItemControl);
begin
  //nothing
end;

procedure TdxRibbonBackstageViewMenuBarControl.WndProc(var Message: TMessage);
begin
  if ((Message.Msg = WM_LBUTTONDOWN) or (Message.Msg = WM_LBUTTONDBLCLK)) and BackstageView.IsDesigning then
  begin
    if not IsControlMouseMsg(TWMMouse(Message)) then
    begin
      ControlState := ControlState + [csLButtonDown];
      Dispatch(Message);
      ControlState := ControlState - [csLButtonDown];
    end;
  end
  else
    inherited WndProc(Message);
end;

procedure TdxRibbonBackstageViewMenuBarControl.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  Message.Result := 1;
end;

procedure TdxRibbonBackstageViewMenuBarControl.CMShowKeyTips(var Message: TMessage);
begin
  BarNavigationController.SetKeyTipsShowingState(
    (Ribbon as IdxBarAccessibleObject).GetAccessibilityHelper, '');
end;

procedure TdxRibbonBackstageViewMenuBarControl.WMMouseWheel(var Message: TWMMouseWheel);
begin
  BackstageView.DoMouseWheel(KeysToShiftState(Message.Keys),
    Message.WheelDelta, SmallPointToPoint(Message.Pos));
  Message.Result := 1;
end;

{ TdxRibbonBackstageViewPainter }

procedure TdxRibbonBackstageViewMenuPainter.DrawButtonBackground(
  const ADrawParams: TdxBarButtonLikeControlDrawParams);
begin
  Skin.DrawBackground(ADrawParams.Canvas.Handle,
    ADrawParams.BarItemControl.ItemBounds, rbvpBackstageViewMenuItem,
    GetButtonPartState(ADrawParams, icpControl));
end;

procedure TdxRibbonBackstageViewMenuPainter.DockControlFillBackground(
  ADockControl: TdxDockControl; DC: HDC; ADestR: TRect; ASourceR: TRect;
  AWholeR: TRect; ABrush: HBRUSH; AColor: TColor);
begin
  Skin.DrawBackground(DC, AWholeR, rbvpBackstageViewMenu);
end;

procedure TdxRibbonBackstageViewMenuPainter.DrawTabButton(
  const ADrawParams: TdxBarButtonLikeControlDrawParams; R: TRect);

  function GetTextColorState(AButtonState: Integer): Integer;
  begin
    Result := AButtonState;
    if ADrawParams.IsCustomizing then
    begin
      if not ADrawParams.Enabled then
        Result := DXBAR_DISABLED;
    end;
  end;

var
  AState: Integer;
begin
  AState := GetButtonPartState(ADrawParams, icpControl);
  with ADrawParams do
    if BarItemControl.FadingElementData <> nil then
      BarItemControl.FadingElementData.DrawImage(Canvas.Handle, R)
    else
      DrawTabButtonBackground(Canvas.Handle, R, AState);

  if cpText in ADrawParams.ViewStructure then
  begin
    R := cxRectContent(R, TabButtonContentOffset);
    ADrawParams.Canvas.Font.Color := TabButtonTextColor(GetTextColorState(AState));
    cxTextOut(ADrawParams.Canvas.Handle, ADrawParams.Caption, R,
      CXTO_EDITCONTROL or CXTO_WORDBREAK or CXTO_CENTER_VERTICALLY);
  end;
end;

procedure TdxRibbonBackstageViewMenuPainter.DrawTabButtonBackground(DC: HDC; R: TRect; AState: Integer);
begin
  Skin.DrawBackground(DC, R, rbvpBackstageViewMenuTabButton, AState);
end;

procedure TdxRibbonBackstageViewMenuPainter.DrawToolbarContentPart(
  ABarControl: TdxBarControl; ACanvas: TcxCanvas);
var
  R: TRect;
begin
  ACanvas.SaveClipRegion;
  try
    R := ABarControl.DockControl.ClientRect;
    MapWindowRect(ABarControl.DockControl.Handle, ABarControl.Handle, R);
    ACanvas.IntersectClipRect(ABarControl.ClientRect);
    Skin.DrawBackground(ACanvas.Handle, R, rbvpBackstageViewMenu);
  finally
    ACanvas.RestoreClipRegion;
  end;
end;

procedure TdxRibbonBackstageViewMenuPainter.DrawToolbarNonContentPart(
  ABarControl: TdxBarControl; DC: HDC);
begin
end;

procedure TdxRibbonBackstageViewMenuPainter.GetDisabledTextColors(
  ABarItemControl: TdxBarItemControl; ASelected: Boolean; AFlat: Boolean;
  var AColor1, AColor2: TColor);
const
  StateMap: array[Boolean] of Integer = (DXBAR_DISABLED, DXBAR_ACTIVEDISABLED);
begin
  AColor1 := Skin.GetPartColor(rbvpBackstageViewMenuItem, StateMap[ASelected]);
  AColor2 := AColor1;
end;

function TdxRibbonBackstageViewMenuPainter.GetEnabledTextColor(
  ABarItemControl: TdxBarItemControl; ASelected: Boolean; AFlat: Boolean): TColor;
begin
  Result := Skin.GetPartColor(rbvpBackstageViewMenuItem);
end;

function TdxRibbonBackstageViewMenuPainter.GetToolbarContentOffsets(
  ABar: TdxBar; ADockingStyle: TdxBarDockingStyle; AHasSizeGrip: Boolean): TRect;
begin
  Result := cxNullRect;
end;

function TdxRibbonBackstageViewMenuPainter.MenuBarButtonContentOffset: TRect;
begin
  Result := Skin.GetContentOffsets(rbvpBackstageViewMenuItem);
end;

function TdxRibbonBackstageViewMenuPainter.MenuBarDefaultItemHeight: Integer;
begin
  Result := Skin.GetPartOffset(rbvpBackstageViewMenuItemHeight);
end;

function TdxRibbonBackstageViewMenuPainter.MenuBarItemsRectIndent: TRect;
begin
  Result := Skin.GetContentOffsets(rbvpBackstageViewMenu);
end;

function TdxRibbonBackstageViewMenuPainter.TabButtonContentOffset: TRect;
begin
  Result := Skin.GetContentOffsets(rbvpBackstageViewMenuTabButton);
end;

function TdxRibbonBackstageViewMenuPainter.TabButtonDefaultHeight: Integer;
begin
  Result := Skin.GetPartOffset(rbvpBackstageViewMenuTabButtonHeight);
end;

function TdxRibbonBackstageViewMenuPainter.TabButtonTextColor(AState: Integer): TColor;
begin
  Result := Skin.GetPartColor(rbvpBackstageViewMenuTabButton, AState);
end;

{ TdxRibbonBackstageViewTabSheetButton }

constructor TdxRibbonBackstageViewTabSheetButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ButtonStyle := bsChecked;
end;

procedure TdxRibbonBackstageViewTabSheetButton.RefreshInfo;
begin
  if Tab <> nil then
  begin
    Caption := Tab.Caption;
    Enabled := Tab.Enabled;
    KeyTip := Tab.KeyTip;
    Down := Tab.Active;
  end;
end;

function TdxRibbonBackstageViewTabSheetButton.GetControlClass(AIsVertical: Boolean): TdxBarItemControlClass;
begin
  Result := TdxRibbonBackstageViewTabSheetButtonControl;
end;

procedure TdxRibbonBackstageViewTabSheetButton.SetTab(AValue: TdxRibbonBackstageViewTabSheet);
begin
  FTab := AValue;
  RefreshInfo;
end;

{ TdxRibbonBackstageViewTabSheetButtonList }

function TdxRibbonBackstageViewTabSheetButtonList.GetItem(Index: Integer): TdxRibbonBackstageViewTabSheetButton;
begin
  Result := TdxRibbonBackstageViewTabSheetButton(inherited Items[Index]);
end;

function TdxRibbonBackstageViewTabSheetButtonList.GetItemByTab(
  ATab: TdxRibbonBackstageViewTabSheet): TdxRibbonBackstageViewTabSheetButton;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].Tab = ATab then
    begin
      Result := Items[I];
      Break;
    end;
end;

procedure TdxRibbonBackstageViewTabSheetButtonList.RefreshInfo;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].RefreshInfo;
end;

procedure TdxRibbonBackstageViewTabSheetButtonList.RemoveTab(ATab: TdxRibbonBackstageViewTabSheet);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if Items[I].Tab = ATab then
    begin
      FreeAndDelete(I);
      Break;
    end;
end;

{ TdxRibbonBackstageViewTabSheetButtonControl }

procedure TdxRibbonBackstageViewTabSheetButtonControl.ActivateTab;
begin
  if Enabled then
  begin
    Item.Tab.Active := True;
    Item.RefreshInfo;
    IAccessibilityHelper.Select(True);
  end;
end;

function TdxRibbonBackstageViewTabSheetButtonControl.CanCustomize: Boolean;
begin
  Result := False;
end;

procedure TdxRibbonBackstageViewTabSheetButtonControl.ControlActivate(
  AImmediately: Boolean; AByMouse: Boolean);
begin
  inherited ControlActivate(AImmediately, AByMouse);
  if not AByMouse then
    ActivateTab;
end;

procedure TdxRibbonBackstageViewTabSheetButtonControl.ControlClick(AByMouse: Boolean; AKey: Char = #0);
begin
  inherited ControlClick(AByMouse, AKey);
  ActivateTab;
end;

procedure TdxRibbonBackstageViewTabSheetButtonControl.ControlUnclick(AByMouse: Boolean);
begin
  inherited ControlUnclick(AByMouse);
  ActivateTab;
end;

procedure TdxRibbonBackstageViewTabSheetButtonControl.DoPaint(
  ARect: TRect; PaintType: TdxBarPaintType);
begin
  MenuPainter.DrawTabButton(DrawParams, ARect);
end;

function TdxRibbonBackstageViewTabSheetButtonControl.IsDestroyOnClick: Boolean;
begin
  Result := False;
end;

function TdxRibbonBackstageViewTabSheetButtonControl.GetDefaultHeight: Integer;
var
  AContentOffset: TRect;
  ASavedFont: TdxBarSavedFont;
  R: TRect;
begin
  AContentOffset := MenuPainter.TabButtonContentOffset;
  PrepareCanvasFont(0, Item.Style, ASavedFont);
  try
    R := cxRect(AContentOffset.Left, 0, MenuViewInfo.MinWidth - AContentOffset.Right, 0);
    cxTextOut(Canvas.Handle, Item.Caption, R,
      CXTO_EDITCONTROL or CXTO_CALCRECT or CXTO_WORDBREAK);
    Result := cxRectHeight(R) + AContentOffset.Top + AContentOffset.Bottom;
  finally
    RestoreCanvasFont(ASavedFont);
  end;
  Result := Max(Result, MenuPainter.TabButtonDefaultHeight);
end;

procedure TdxRibbonBackstageViewTabSheetButtonControl.GetFadingParams(
  out AFadeOutImage, AFadeInImage: TcxBitmap;
  var AFadeInAnimationFrameCount, AFadeInAnimationFrameDelay: Integer;
  var AFadeOutAnimationFrameCount, AFadeOutAnimationFrameDelay: Integer);

  function PrepareImage(const R: TRect; AState: Integer): TcxBitmap32;
  begin
    Result := TcxBitmap32.CreateSize(R, True);
    MenuPainter.DrawTabButtonBackground(Result.Canvas.Handle, R, AState);
  end;

const
  NormalMap: array[Boolean] of Integer = (DXBAR_NORMAL, DXBAR_CHECKED);
  HotMap: array[Boolean] of Integer = (DXBAR_HOT, DXBAR_HOTCHECK);
var
  R: TRect;
begin
  R := ItemBounds;
  OffsetRect(R, -R.Left, -R.Top);
  AFadeOutImage := PrepareImage(R, NormalMap[Down]);
  AFadeInImage := PrepareImage(R, HotMap[Down]);
end;

function TdxRibbonBackstageViewTabSheetButtonControl.GetItem: TdxRibbonBackstageViewTabSheetButton;
begin
  Result := TdxRibbonBackstageViewTabSheetButton(inherited Item);
end;

function TdxRibbonBackstageViewTabSheetButtonControl.GetMenuPainter: TdxRibbonBackstageViewMenuPainter;
begin
  Result := MenuViewInfo.Painter;
end;

function TdxRibbonBackstageViewTabSheetButtonControl.GetMenuViewInfo: TdxRibbonBackstageViewMenuViewInfo;
begin
  Result := Item.Tab.BackstageView.MenuViewInfo;
end;

{ TdxRibbonBackstageViewCustomViewInfo }

constructor TdxRibbonBackstageViewCustomViewInfo.Create(ABackstageView: TdxRibbonCustomBackstageView);
begin
  inherited Create;
  FBackstageView := ABackstageView;
end;

function TdxRibbonBackstageViewCustomViewInfo.GetBarManager: TdxBarManager;
begin
  Result := BackstageView.BarManager;
end;

{ TdxRibbonBackstageViewViewInfo }

constructor TdxRibbonBackstageViewViewInfo.Create(ABackstageView: TdxRibbonCustomBackstageView);
begin
  inherited Create(ABackstageView);
  FMenuViewInfo := CreateMenuViewInfo;
end;

destructor TdxRibbonBackstageViewViewInfo.Destroy;
begin
  FreeAndNil(FMenuViewInfo);
  inherited Destroy;
end;

procedure TdxRibbonBackstageViewViewInfo.Calculate(const ABounds: TRect);
begin
  FBounds := ABounds;
  MenuViewInfo.CalculateSizes;
  FContentWidth := Max(CalculateMinWidth, cxRectWidth(Bounds));
  FContentHeight := Max(CalculateMinHeight, cxRectHeight(Bounds));
  CheckScrollPosition(FScrollPositionX, ContentWidth, cxRectWidth(Bounds));
  CheckScrollPosition(FScrollPositionY, ContentHeight, cxRectHeight(Bounds));
  FFrameAreaBounds := CalculateFrameBounds;
  MenuViewInfo.Calculate(CalculateMenuBounds);
end;

function TdxRibbonBackstageViewViewInfo.CalculateFrameBounds: TRect;
begin
  Result := ContentBounds;
  Result.Left := CalculateMenuBounds.Right;
end;

function TdxRibbonBackstageViewViewInfo.CalculateMenuBounds: TRect;
begin
  Result := cxRectSetWidth(ContentBounds, MenuViewInfo.MinWidth);
  Result.Bottom := Bounds.Bottom;
end;

function TdxRibbonBackstageViewViewInfo.CalculateMinHeight: Integer;
begin
  Result := MenuViewInfo.MinHeight;
  if Assigned(ActiveTab) then
    Result := Max(Result, ActiveTab.ViewInfo.MinHeight);
end;

function TdxRibbonBackstageViewViewInfo.CalculateMinWidth: Integer;
begin
  Result := MenuViewInfo.MinWidth;
  if Assigned(ActiveTab) then
    Inc(Result, ActiveTab.ViewInfo.MinWidth);
end;

procedure TdxRibbonBackstageViewViewInfo.CheckScrollPosition(
  var AValue: Integer; AContentSize, ADisplaySize: Integer);
begin
  AValue := Max(0, Min(AValue, AContentSize - ADisplaySize));
end;

function TdxRibbonBackstageViewViewInfo.CreateMenuViewInfo: TdxRibbonBackstageViewMenuViewInfo;
begin
  Result := TdxRibbonBackstageViewMenuViewInfo.Create(BackstageView);
end;

function TdxRibbonBackstageViewViewInfo.ProcessMouseWheel(ALineDown: Boolean): Boolean;
const
  Signs: array[Boolean] of Integer = (-1, 1);
begin
  Result := ContentHeight > cxRectHeight(Bounds);
  if Result then
    ScrollPositionY := ScrollPositionY + Signs[ALineDown] *
      Mouse.WheelScrollLines * dxBackstageViewScrollLineSize;
end;

function TdxRibbonBackstageViewViewInfo.GetActiveTab: TdxRibbonBackstageViewTabSheet;
begin
  Result := BackstageView.ActiveTab;
end;

function TdxRibbonBackstageViewViewInfo.GetContentBounds: TRect;
begin
  Result := Classes.Bounds(Bounds.Left - ScrollPositionX,
    Bounds.Top - ScrollPositionY, ContentWidth, ContentHeight);
end;

function TdxRibbonBackstageViewViewInfo.GetDesignSelectorRect: TRect;
const
  SelectorOffset = 8;
  SelectorSize = 15;
begin
  Result := cxRectInflate(Bounds, -SelectorOffset, -SelectorOffset);
  Result.Left := Result.Right - SelectorSize;
  Result.Top := Result.Bottom - SelectorSize;
  if IsRectEmpty(Result) then
    Result := cxEmptyRect;
end;

function TdxRibbonBackstageViewViewInfo.GetFrameAreaVisibleBounds: TRect;
begin
  Result := Bounds;
  Result.Left := CalculateMenuBounds.Right;
end;

function TdxRibbonBackstageViewViewInfo.GetMenuBarControl: TdxBarControl;
begin
  Result := MenuViewInfo.BarControl;
end;

procedure TdxRibbonBackstageViewViewInfo.SetScrollPositionX(AValue: Integer);
begin
  CheckScrollPosition(AValue, ContentWidth, cxRectWidth(Bounds));
  if FScrollPositionX <> AValue then
  begin
    FScrollPositionX := AValue;
    BackstageView.Changed;
  end;
end;

procedure TdxRibbonBackstageViewViewInfo.SetScrollPositionY(AValue: Integer);
begin
  CheckScrollPosition(AValue, ContentHeight, cxRectHeight(Bounds));
  if FScrollPositionY <> AValue then
  begin
    FScrollPositionY := AValue;
    BackstageView.Changed;
  end;
end;

{ TdxRibbonBackstageViewMenuButton }

destructor TdxRibbonBackstageViewMenuButton.Destroy;
begin
  Item := nil;
  inherited Destroy;
end;

procedure TdxRibbonBackstageViewMenuButton.Assign(Source: TPersistent);
begin
  if Source is TdxRibbonBackstageViewMenuButton then
  begin
    Item := TdxRibbonBackstageViewMenuButton(Source).Item;
    Position := TdxRibbonBackstageViewMenuButton(Source).Position;
  end
  else
    inherited Assign(Source);
end;

procedure TdxRibbonBackstageViewMenuButton.BarComponentChanged(AComponent: TdxBarComponent);
begin
  Changed(AComponent = nil);
end;

procedure TdxRibbonBackstageViewMenuButton.SelectionChanged;
begin
  Collection.BackstageView.InvalidateWithChildren;
end;

procedure TdxRibbonBackstageViewMenuButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (AComponent = FItem) and (Operation = opRemove) then
  begin
    BarDesignController.LockDesignerModified;
    try
      FItem := nil;
      Changed(True);
    finally
      BarDesignController.UnLockDesignerModified;
    end;
  end;
end;

function TdxRibbonBackstageViewMenuButton.GetCollection: TdxRibbonBackstageViewMenuButtons;
begin
  Result := TdxRibbonBackstageViewMenuButtons(inherited Collection);
end;

procedure TdxRibbonBackstageViewMenuButton.SetItem(AValue: TdxBarButton);
begin
  if AValue <> Item then
  begin
    if Item <> nil then
    begin
      TdxBarButtonAccess(Item).RemoveChangeNotify(Self);
      Item.RemoveFreeNotification(Collection.BackstageView);
    end;
    FItem := AValue;
    if Item <> nil then
    begin
      Item.FreeNotification(Collection.BackstageView);
      TdxBarButtonAccess(Item).AddChangeNotify(Self);
    end;
    Changed(True);
  end;
end;

procedure TdxRibbonBackstageViewMenuButton.SetPosition(
  AValue: TdxRibbonBackstageViewMenuButtonPosition);
begin
  if AValue <> FPosition then
  begin
    FPosition := AValue;
    Changed(True);
  end;
end;

{ TdxRibbonBackstageViewMenuViewInfo }

constructor TdxRibbonBackstageViewMenuViewInfo.Create(ABackstageView: TdxRibbonCustomBackstageView);
begin
  inherited Create(ABackstageView);
  FMenuButtonList := TdxRibbonBackstageViewMenuButtonList.Create;
  FTabButtonList := TdxRibbonBackstageViewTabSheetButtonList.Create;
  FDockControl := TdxRibbonBackstageViewMenuDockControl.Create(Self);
  FDockControl.AllowDocking := False;
  FDockControl.Parent := BackstageView;
  FDockControl.Visible := True;
  FDockControl.Align := dalNone;
  CreateViewInfoItems;
end;

destructor TdxRibbonBackstageViewMenuViewInfo.Destroy;
begin
  DestroyViewInfoItems;
  FreeAndNil(FMenuButtonList);
  FreeAndNil(FTabButtonList);
  FreeAndNil(FDockControl);
  inherited Destroy;
end;

procedure TdxRibbonBackstageViewMenuViewInfo.AddButton(AButton: TdxRibbonBackstageViewMenuButton);
var
  AItem: TdxRibbonBackstageViewMenuBarButton;
begin
  if Assigned(AButton.Item) then
  begin
    AItem := TdxRibbonBackstageViewMenuBarButton(BarManager.AddItem(TdxRibbonBackstageViewMenuBarButton));
    BarDesignController.AddInternalItem(AItem, MenuButtonList);
    AItem.MenuButton := AButton;
    ItemLinks.Add.Item := AItem;
  end;
end;

procedure TdxRibbonBackstageViewMenuViewInfo.AddTabButton(ATab: TdxRibbonBackstageViewTabSheet);
var
  ATabButton: TdxRibbonBackstageViewTabSheetButton;
begin
  if ATab.TabVisible then
  begin
    ATabButton := TdxRibbonBackstageViewTabSheetButton(BarManager.AddItem(TdxRibbonBackstageViewTabSheetButton));
    BarDesignController.AddInternalItem(ATabButton, TabButtonList);
    ATabButton.Tab := ATab;
    ItemLinks.Add.Item := ATabButton;
  end;
end;

procedure TdxRibbonBackstageViewMenuViewInfo.Calculate(const ABounds: TRect);
begin
  DockControl.BoundsRect := ABounds;
  DockControl.UpdateDock;
  if BarControl <> nil then
  begin
    BarControl.CalcLayout;
    BarControl.Invalidate;
  end;
end;

procedure TdxRibbonBackstageViewMenuViewInfo.CalculateSizes;
begin
  if Assigned(BarControl) then
  begin
    BarControl.HandleNeeded;
    BarControl.CreateControls;
    FMinWidth := BarControl.GetMaxWidth(dsLeft);
    FMinHeight := BarControl.GetMaxHeight(dsLeft);
  end
  else
  begin
    FMinHeight := 0;
    FMinWidth := 0;
  end;
end;

function TdxRibbonBackstageViewMenuViewInfo.CanContainItem(
  AItem: TdxBarItem; out AErrorText: string): Boolean;
begin
  Result := True;
end;

function TdxRibbonBackstageViewMenuViewInfo.CreateItemLinksBarControl: TCustomdxBarControl;
begin
  Result := TdxRibbonBackstageViewMenuBarControl.Create(BarManager);
end;

function TdxRibbonBackstageViewMenuViewInfo.CreatePainter: TdxRibbonBackstageViewMenuPainter;
begin
  Result := TdxRibbonBackstageViewMenuPainter.Create(Integer(Ribbon));
end;

procedure TdxRibbonBackstageViewMenuViewInfo.CreateBarControl;
begin
  if Assigned(BarManager) then
  begin
    ItemLinks.CreateBarControl;
    BarControl.DockControl := DockControl;
    BarControl.DockingStyle := dsLeft;
    BarControl.Parent := DockControl;
    BarControl.Visible := True;
  end;
end;

procedure TdxRibbonBackstageViewMenuViewInfo.CreateViewInfoItems;
begin
  FPainter := CreatePainter;
  FItemLinks := TdxBarControlItemLinks.Create(BarManager, Self);
  DockControl.BarManager := BarManager;
  CreateBarControl;
end;

procedure TdxRibbonBackstageViewMenuViewInfo.DestroyViewInfoItems;
begin
  DockControl.BarManager := nil;
  FreeAndNil(FItemLinks);
  FreeAndNil(FPainter);
end;

function TdxRibbonBackstageViewMenuViewInfo.GetAccessibilityHelper: IdxBarAccessibilityHelper;
begin
  if Assigned(ItemLinks) then
    Result := ItemLinks.BarControl.IAccessibilityHelper
  else
    Result := nil;
end;

function TdxRibbonBackstageViewMenuViewInfo.GetInstance: TComponent;
begin
  Result := BackstageView;
end;

function TdxRibbonBackstageViewMenuViewInfo.GetItemLinks: TdxBarItemLinks;
begin
  Result := ItemLinks;
end;

function TdxRibbonBackstageViewMenuViewInfo.GetBarControl: TdxRibbonBackstageViewMenuBarControl;
begin
  Result := TdxRibbonBackstageViewMenuBarControl(ItemLinks.BarControl);
end;

function TdxRibbonBackstageViewMenuViewInfo.GetIsDesigning: Boolean;
begin
  Result := BackstageView.IsDesigning;
end;

function TdxRibbonBackstageViewMenuViewInfo.GetRibbon: TdxCustomRibbon;
begin
  Result := BackstageView.Ribbon;
end;

procedure TdxRibbonBackstageViewMenuViewInfo.ClearInternalLists;
begin
  if ItemLinks <> nil then
    ItemLinks.Clear;
  TabButtonList.Clear;
  MenuButtonList.Clear;
end;

procedure TdxRibbonBackstageViewMenuViewInfo.RecreateItemLinks;

  procedure DoAddButtons(APosition: TdxRibbonBackstageViewMenuButtonPosition);
  var
    AButton: TdxRibbonBackstageViewMenuButton;
    I: Integer;
  begin
    for I := 0 to BackstageView.Buttons.Count - 1 do
    begin
      AButton := BackstageView.Buttons[I];
      if AButton.Position = APosition then
        AddButton(AButton);
    end;
  end;

var
  I: Integer;
begin
  if Assigned(BarManager) then
  begin
    ItemLinks.BeginUpdate;
    try
      ClearInternalLists;
      DoAddButtons(mbpBeforeTabs);
      for I := 0 to BackstageView.TabCount - 1 do
        AddTabButton(BackstageView.Tabs[I]);
      DoAddButtons(mbpAfterTabs);
    finally
      ItemLinks.EndUpdate;
    end;
  end
  else
    ClearInternalLists;
end;

procedure TdxRibbonBackstageViewMenuViewInfo.RefreshMenuButtonsInfo;
begin
  MenuButtonList.RefreshInfo;
end;

procedure TdxRibbonBackstageViewMenuViewInfo.RefreshTabsInfo;
begin
  TabButtonList.RefreshInfo;
end;

procedure TdxRibbonBackstageViewMenuViewInfo.UpdateFont;
begin
  if BarControl <> nil then
    BarControl.UpdateFont;
end;

{ TdxRibbonBackstageViewMenuButtons }

constructor TdxRibbonBackstageViewMenuButtons.Create(ABackstageView: TdxRibbonCustomBackstageView);
begin
  inherited Create(TdxRibbonBackstageViewMenuButton);
  FBackstageView := ABackstageView
end;

function TdxRibbonBackstageViewMenuButtons.Add: TdxRibbonBackstageViewMenuButton;
begin
  Result := TdxRibbonBackstageViewMenuButton(inherited Add);
end;

function TdxRibbonBackstageViewMenuButtons.IndexOf(AItem: TdxRibbonBackstageViewMenuButton): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if Items[I] = AItem then
    begin
      Result := I;
      Break;
    end;
end;

function TdxRibbonBackstageViewMenuButtons.Insert(AIndex: Integer): TdxRibbonBackstageViewMenuButton;
begin
  Result := TdxRibbonBackstageViewMenuButton(inherited Insert(AIndex));
end;

function TdxRibbonBackstageViewMenuButtons.GetOwner: TPersistent;
begin
  Result := BackstageView;
end;

procedure TdxRibbonBackstageViewMenuButtons.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  if Item = nil then
    BackstageView.Changed([rbvcStruct])
  else
    BackstageView.Changed([rbvcItemsData]);
end;

procedure TdxRibbonBackstageViewMenuButtons.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].Notification(AComponent, Operation);
end;

function TdxRibbonBackstageViewMenuButtons.GetItem(Index: Integer): TdxRibbonBackstageViewMenuButton;
begin
  Result := TdxRibbonBackstageViewMenuButton(inherited GetItem(Index));
end;

procedure TdxRibbonBackstageViewMenuButtons.SetItem(
  Index: Integer; Value: TdxRibbonBackstageViewMenuButton);
begin
  inherited SetItem(Index, Value);
end;

{ TdxRibbonBackstageViewDesignSelector }

procedure TdxRibbonBackstageViewDesignSelector.BoundsChanged;
begin
  inherited BoundsChanged;
  if HandleAllocated then
    SetWindowRgn(Handle, CreateRegion, True);
end;

function TdxRibbonBackstageViewDesignSelector.CreateRegion: TcxRegionHandle;
var
  ARgn: TcxRegionHandle;
begin
  Result := CreateRectRgnIndirect(DesignRect);
  ARgn := CreateRectRgnIndirect(cxRectOffset(DesignRect, 1, 1));
  CombineRgn(Result, Result, ARgn, RGN_OR);
  DeleteObject(ARgn);
end;

procedure TdxRibbonBackstageViewDesignSelector.Paint;
begin
  cxDrawDesignRect(Canvas, DesignRect, Selected);
end;

function TdxRibbonBackstageViewDesignSelector.GetDesignRect: TRect;
begin
  Result := cxRectInflate(ClientRect, 0, 0, -1, -1);
end;

function TdxRibbonBackstageViewDesignSelector.GetSelected: Boolean;
begin
  Result := (Owner as TdxRibbonCustomBackstageView).IsObjectSelected(Owner);
end;

{ TdxRibbonBackstageViewPainter }

constructor TdxRibbonBackstageViewPainter.Create(ABackstageView: TdxRibbonCustomBackstageView);
begin
  inherited Create;
  FBackstageView := ABackstageView;
end;

procedure TdxRibbonBackstageViewPainter.DrawTopLine(ACanvas: TcxCanvas; const R: TRect);
begin
  if Skin = nil then
    ACanvas.FillRect(R, clCream)
  else
    Skin.DrawBackground(ACanvas.Handle, R, rbvpBackstageViewTopLine);
end;

procedure TdxRibbonBackstageViewPainter.DrawBackground(ACanvas: TcxCanvas; const R: TRect);
begin
  if Skin = nil then
    ACanvas.FillRect(R, clCream)
  else
    Skin.DrawBackground(ACanvas.Handle, R, rbvpBackstageView);
end;

function TdxRibbonBackstageViewPainter.GetSkin: IdxSkin;
begin
  if not Supports(FBackstageView.Ribbon, IdxSkin, Result) then
    Result := nil;
end;

function TdxRibbonBackstageViewPainter.GetTopLineSize: Integer;
begin
  if Skin = nil then
    Result := 0
  else
    Result := Skin.GetPartOffset(rbvpBackstageViewTopLine);
end;

{ TdxRibbonBackstageViewMenuBarButton }

procedure TdxRibbonBackstageViewMenuBarButton.DirectClick;
begin
  if Enabled and (MenuButton <> nil) then
  begin
    MenuButton.Collection.BackstageView.ClosePopup;
    PostMessage(MenuButton.Collection.BackstageView.Handle,
      DXM_BAR_FASTCOMMAND, 0, lParam(MenuButton));
  end;
end;

procedure TdxRibbonBackstageViewMenuBarButton.RefreshInfo;
begin
  if MenuButton <> nil then
    Assign(MenuButton.Item);
end;

function TdxRibbonBackstageViewMenuBarButton.GetControlClass(
  AIsVertical: Boolean): TdxBarItemControlClass;
begin
  Result := TdxRibbonBackstageViewMenuBarButtonControl;
end;

procedure TdxRibbonBackstageViewMenuBarButton.SetMenuButton(AValue: TdxRibbonBackstageViewMenuButton);
begin
  if FMenuButton <> AValue then
  begin
    FMenuButton := AValue;
    RefreshInfo;
  end;
end;

{ TdxRibbonBackstageViewMenuBarButtonControl }

function TdxRibbonBackstageViewMenuBarButtonControl.CanCustomize: Boolean;
begin
  Result := False;
end;

procedure TdxRibbonBackstageViewMenuBarButtonControl.CalcDrawParams(AFull: Boolean = True);
begin
  inherited CalcDrawParams(AFull);
  DrawParams.ContentOffset := MenuPainter.MenuBarButtonContentOffset;
end;

procedure TdxRibbonBackstageViewMenuBarButtonControl.DoPaint(ARect: TRect; PaintType: TdxBarPaintType);
begin
  inherited DoPaint(ARect, PaintType);
  if BackstageView.IsObjectSelected(Item.MenuButton) then
    dxBarFocusRect(Canvas.Handle, ARect);
end;

function TdxRibbonBackstageViewMenuBarButtonControl.GetBackstageView: TdxRibbonCustomBackstageView;
begin
  Result := Item.MenuButton.Collection.BackstageView;
end;

function TdxRibbonBackstageViewMenuBarButtonControl.GetDefaultHeight: Integer;
begin
  Result := Max(inherited GetDefaultHeight, MenuPainter.MenuBarDefaultItemHeight);
end;

function TdxRibbonBackstageViewMenuBarButtonControl.GetItem: TdxRibbonBackstageViewMenuBarButton;
begin
  Result := TdxRibbonBackstageViewMenuBarButton(inherited Item);
end;

function TdxRibbonBackstageViewMenuBarButtonControl.GetMenuPainter: TdxRibbonBackstageViewMenuPainter;
begin
  Result := BackstageView.MenuViewInfo.Painter;
end;

function TdxRibbonBackstageViewMenuBarButtonControl.GetViewStructure: TdxBarItemControlViewStructure;
begin
  Result := [cpIcon, cpText];
end;

{ TdxRibbonBackstageViewMenuButtonList }

function TdxRibbonBackstageViewMenuButtonList.GetItem(Index: Integer): TdxRibbonBackstageViewMenuBarButton;
begin 
  Result := TdxRibbonBackstageViewMenuBarButton(inherited Items[Index]); 
end; 

procedure TdxRibbonBackstageViewMenuButtonList.RefreshInfo;
var
  I: Integer;
begin 
  for I := 0 to Count - 1 do 
    Items[I].RefreshInfo;  
end; 

initialization
  RegisterClass(TdxRibbonBackstageViewTabSheet);
end.
