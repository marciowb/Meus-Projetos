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

unit dxSkinsForm;

interface

{$I cxVer.inc}

uses
  Types, Windows, Classes, SysUtils, Messages, Forms, Graphics, Controls,
  MultiMon, ShellApi, cxLookAndFeelPainters, cxClasses, StdCtrls, ExtCtrls, FlatSB, Math,
  cxDWMAPI, dxCore, dxMessages, cxGraphics, cxControls, cxGeometry, cxContainer,
  dxSkinsLookAndFeelPainter, dxSkinsCore, cxScrollBar, cxLookAndFeels, dxUxTheme, dxSkinInfo;

const
  dxSkinFormTextOffset = 5;
  dxSkinIconSpacing = 2;
  IsDesigning: Boolean = False;

type
  TdxSkinForm = class;
  TdxSkinFormController = class;
  TdxSkinFormNonClientAreaInfo = class;
  TdxSkinFormPainter = class;
  TdxSkinFormIconInfo = class;
  TdxSkinFormIconInfoList = class;

  TdxSkinFormCorner = (sfcLeftTop, sfcRightTop, sfcLeftBottom, sfcRightBottom);

  TdxScrollAreaElement = (saeHorzScroll, saeVertScroll, saeSizeGrip);
  TdxScrollAreaElements = set of TdxScrollAreaElement;
  TdxSkinFormScrollBar = saeHorzScroll..saeVertScroll;

  TdxSkinFormEvent = procedure(Sender: TObject; AForm: TCustomForm;
    var ASkinName: string; var UseSkin: Boolean) of object;
  TdxSkinControlEvent = procedure(Sender: TObject; AControl: TWinControl;
    var UseSkin: Boolean) of object;
  TdxSkinPopupSysMenuEvent = procedure (Sender: TObject; AForm: TCustomForm; ASysMenu: HMENU) of object;

  { TdxSkinController }

  TdxSkinController = class(TcxLookAndFeelController)
  private
    FOnPopupSysMenu: TdxSkinPopupSysMenuEvent;
    FOnSkinControl: TdxSkinControlEvent;
    FOnSkinForm: TdxSkinFormEvent;
    function GetUseSkins: Boolean;
    procedure SetUseSkins(Value: Boolean);
  protected
    procedure DoPopupSystemMenu(AForm: TCustomForm; ASysMenu: HMENU); virtual;
    function DoSkinControl(AControl: TWinControl): Boolean; virtual;
    function DoSkinForm(AForm: TCustomForm): TdxSkinLookAndFeelPainterClass; virtual;
    function DoSkinFormEx(AForm: TCustomForm; var ASkinName: string;
      var AUseSkin: Boolean): TdxSkinLookAndFeelPainterClass; virtual;
    procedure Loaded; override;
    procedure MasterLookAndFeelChanged(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues); override;
    procedure MasterLookAndFeelDestroying(Sender: TcxLookAndFeel); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Refresh(AControl: TWinControl = nil);
    procedure Reset; override;
    class function GetFormSkin(AForm: TCustomForm; var ASkinName: string): Boolean;
  published
    property Kind;
    property NativeStyle;
    property SkinName;
    property UseSkins: Boolean read GetUseSkins write SetUseSkins default True;
    property OnPopupSysMenu: TdxSkinPopupSysMenuEvent read FOnPopupSysMenu write FOnPopupSysMenu;
    property OnSkinControl: TdxSkinControlEvent read FOnSkinControl write FOnSkinControl;
    property OnSkinForm: TdxSkinFormEvent read FOnSkinForm write FOnSkinForm;
  end;

  { TdxSkinWinController }

  TdxSkinWinController = class(TcxIUnknownObject, IcxMouseTrackingCaller)
  private
    FHandle: HWND;
    FLookAndFeelPainter: TdxSkinLookAndFeelPainterClass;
    FMaster: TdxSkinWinController;
    FWinControl: TWinControl;
    FWindowProcObject: TcxWindowProcLinkedObject;
    function GetHasVirtualChilds: Boolean;
    function GetIsHooked: Boolean;
    function GetIsMDIClient: Boolean;
    function GetLookAndFeelPainter: TdxSkinLookAndFeelPainterClass;
    procedure SetHandle(AHandle: HWND);
  protected
    function GetIsSkinUsed: Boolean; virtual;
    function GetMaster(AHandle: HWND): TdxSkinWinController; virtual;
    function GetUseSkinForControl: Boolean; virtual;
    function IsHookAvailable: Boolean; virtual;
    procedure DefWndProc(var AMessage); virtual;
    procedure HookWndProc; virtual;
    procedure InitializePainter; virtual;
    procedure MasterDestroyed; virtual;
    procedure RedrawWindow(AUpdateNow: Boolean);
    procedure UnHookWndProc; virtual;
    procedure WndProc(var AMessage: TMessage); virtual;
    { IcxMouseTrackingCaller }
    procedure MouseLeave; virtual;
  public
    constructor Create(AHandle: HWND); virtual;
    destructor Destroy; override;

    class function IsMDIChildWindow(AHandle: HWND): Boolean; virtual;
    class function IsMDIClientWindow(AHandle: HWND): Boolean; virtual;
    class function IsMessageDlgWindow(AHandle: HWND): Boolean; virtual;
    class function IsSkinActive(AHandle: HWND): Boolean;
    class procedure FinalizeEngine(AHandle: HWND);
    class procedure InitializeEngine(AHandle: HWND);

    function GetSkinName(var ASkinName: string): Boolean;
    procedure Refresh; virtual;
    procedure RefreshController; virtual;
    procedure Update; virtual;

    property Handle: HWND read FHandle write SetHandle;
    property HasVirtualChilds: Boolean read GetHasVirtualChilds;
    property IsHooked: Boolean read GetIsHooked;
    property IsMDIClient: Boolean read GetIsMDIClient;
    property IsSkinUsed: Boolean read GetIsSkinUsed;
    property LookAndFeelPainter: TdxSkinLookAndFeelPainterClass read GetLookAndFeelPainter;
    property Master: TdxSkinWinController read FMaster;
    property WinControl: TWinControl read FWinControl;
  end;

  TdxSkinWinControllerClass = class of TdxSkinWinController;
  TdxSkinGetControllerClassForWindowProc = function (AWnd: HWND): TdxSkinWinControllerClass;
 
  { TdxSkinFormController }

  TdxSkinFormController = class(TdxSkinWinController)
  private
    FForceRedraw: Boolean;
    FHasRegion: Boolean;
    FLockRedrawCount: Integer;
    FPainter: TdxSkinFormPainter;
    FSkinForm: TdxSkinForm;
    FViewInfo: TdxSkinFormNonClientAreaInfo;
    function GetForm: TCustomForm;
    function GetIconHot: TdxSkinFormIconInfo;
    function GetIconPressed: TdxSkinFormIconInfo;
  protected
    function GetIsSkinUsed: Boolean; override;
    function IsHookAvailable: Boolean; override;
    procedure CalculateViewInfo; virtual;
    procedure CheckWindowRgn; virtual;
    procedure DoPopupSystemMenu(AForm: TCustomForm; ASysMenu: HMENU);
    procedure DrawWindowBackground(DC: HDC); virtual;
    procedure DrawWindowBorder(DC: HDC = 0); virtual;
    procedure DrawWindowScrollArea(DC: HDC = 0); virtual;
    procedure FlushWindowRgn(ARedraw: Boolean = True); virtual;
    procedure InitializeMessageForm; virtual;
    procedure InitializePainter; override;
    procedure InvalidateBorders;
    function HandleInternalMessages(var AMessage: TMessage): Boolean; virtual;
    function HandleWindowMessage(var AMessage: TMessage): Boolean; virtual;
    function RefreshOnMouseEvent(AForceRefresh: Boolean = False): Boolean;
    procedure MouseLeave; override;
    procedure RefreshOnSystemMenuShown;
    procedure UnHookWndProc; override;
    procedure UpdateViewInfoState;
    //
    procedure AfterWndProc(var AMessage: TMessage);
    procedure BeforeWndProc(var AMessage: TMessage);
    procedure DefWndProc(var AMessage); override;
    // Redraw
    procedure LockRedraw;
    procedure PostRedraw;
    procedure UnlockRedraw;
    // Menu
    procedure ShowSystemMenu(const P: TPoint;
      const AExcludeRect: TRect; ABottomAlign: Boolean = False); overload;
    procedure ShowSystemMenu(const P: TPoint); overload;
    procedure ShowSystemMenu; overload;
    //
    procedure WMActivate(var Message: TMessage); virtual;
    function WMContextMenu(var Message: TWMContextMenu): Boolean; virtual;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); virtual;
    procedure WMInitMenu(var Message: TWMInitMenu); virtual;
    procedure WMNCActivate(var Message: TWMNCActivate); virtual;
    procedure WMNCButtonDown(var Message: TWMNCHitMessage); virtual;
    procedure WMNCCalcSize(var Message: TWMNCCALCSIZE); virtual;
    function WMNCHitTest(var Message: TWMNCHitTest): Boolean; virtual;
    function WMNCLButtonUp(var Message: TWMNCHitMessage): Boolean; virtual;
    procedure WMNCMouseMove(var Message: TWMNCHitMessage);
    procedure WMNCPaint(var Message: TWMNCPaint); virtual;
    procedure WMPaint(var Message: TWMPaint); virtual;
    procedure WMPrint(var Message: TWMPrint); virtual;
    procedure WMSetText(var Message: TWMSetText); virtual;
    procedure WMSize(var Message: TWMSize); virtual;
    procedure WMSysCommand(var Message: TWMSysCommand); virtual;
    procedure WMSysMenu(var Message: TMessage); virtual;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); virtual;
    procedure WndProc(var AMessage: TMessage); override;
  public
    constructor Create(AHandle: HWND); override;
    constructor CreateEx(ASkinForm: TdxSkinForm);  
    destructor Destroy; override;
    procedure Refresh; override;
    procedure RefreshController; override;

    property ForceRedraw: Boolean read FForceRedraw write FForceRedraw;
    property Form: TCustomForm read GetForm;
    property HasRegion: Boolean read FHasRegion write FHasRegion;
    property IconHot: TdxSkinFormIconInfo read GetIconHot;
    property IconPressed: TdxSkinFormIconInfo read GetIconPressed;
    property Painter: TdxSkinFormPainter read FPainter;
    property SkinForm: TdxSkinForm read FSkinForm;
    property ViewInfo: TdxSkinFormNonClientAreaInfo read FViewInfo;
  end;

  { TdxSkinFormIconInfo }

  TdxSkinFormIconInfo = class(TObject)
  private
    FBounds: TRect;
    FHitBounds: TRect;
    FIconType: TdxSkinFormIcon;
    FOwner: TdxSkinFormIconInfoList;
    FState: TdxSkinElementState;
    function GetCommand: Integer;
    function GetEnabled: Boolean;
    function GetHitTest: Integer;
    function GetNonClientAreaInfo: TdxSkinFormNonClientAreaInfo;
  public
    constructor Create(AType: TdxSkinFormIcon; AOwner: TdxSkinFormIconInfoList); virtual;
    function CalculateState: TdxSkinElementState;
    //
    property Bounds: TRect read FBounds write FBounds;
    property Command: Integer read GetCommand;
    property Enabled: Boolean read GetEnabled;
    property HitBounds: TRect read FHitBounds write FHitBounds;
    property HitTest: Integer read GetHitTest;
    property IconType: TdxSkinFormIcon read FIconType;
    property NonClientAreaInfo: TdxSkinFormNonClientAreaInfo read GetNonClientAreaInfo;
    property Owner: TdxSkinFormIconInfoList read FOwner;
    property State: TdxSkinElementState read FState write FState;
  end;

  { TdxSkinFormIconInfoList }

  TdxSkinFormIconInfoList = class(TcxObjectList)
  private
    FIconHot: TdxSkinFormIconInfo;
    FIconPressed: TdxSkinFormIconInfo;
    FNonClientAreaInfo: TdxSkinFormNonClientAreaInfo;
    function GetItem(Index: Integer): TdxSkinFormIconInfo;
  public
    constructor Create(ANonClientInfo: TdxSkinFormNonClientAreaInfo); virtual;
    function Add(AIcon: TdxSkinFormIcon): TdxSkinFormIconInfo;
    function CalculateStates(const P: TPoint): Boolean;
    function Find(AIcon: TdxSkinFormIcon; out AInfo: TdxSkinFormIconInfo): Boolean;
    function HitTest(const P: TPoint): TdxSkinFormIconInfo; overload;
    function HitTest(const P: TPoint; out AInfo: TdxSkinFormIconInfo): Boolean; overload;
    procedure Validate(const AIcons: TdxSkinFormIcons);
    //
    property IconHot: TdxSkinFormIconInfo read FIconHot;
    property IconPressed: TdxSkinFormIconInfo read FIconPressed;
    property Items[Index: Integer]: TdxSkinFormIconInfo read GetItem; default;
    property NonClientAreaInfo: TdxSkinFormNonClientAreaInfo read FNonClientAreaInfo;
  end;

  { TdxSkinFormNonClientAreaInfo }

  TdxSkinFormNonClientAreaInfo = class(TObject)
  private
    FClientOffset: Integer;
    FClientRect: TRect;
    FController: TdxSkinFormController;
    FExStyle: Integer;
    FIconInfoList: TdxSkinFormIconInfoList;
    FNonClientMetrics: TNonClientMetrics;
    FSizeType: Integer;
    FStyle: Integer;
    FSupressed: Boolean;
    FSystemMenu: HMENU;
    FThemeActive: Boolean;
    FThemeActiveAssigned: Boolean;
    FWindowRect: TRect;
    function GetBorderBounds(ASide: TcxBorder): TRect;
    function GetButtonPressed: Boolean;
    function GetCaptionBounds: TRect;
    function GetCaptionContentOffset: TRect;
    function GetCaptionElement: TdxSkinElement;
    function GetCaptionIconSize(AIcon: TdxSkinFormIcon): TSize;
    function GetCaptionTextColor: TColor;
    function GetClientRectOnClient: TRect;
    function GetContentRect: TRect;
    function GetHandle: HWND;
    function GetHasBorder: Boolean;
    function GetHasCaption: Boolean;
    function GetHasCaptionTextShadow: Boolean;
    function GetHasClientEdge: Boolean;
    function GetHasMenu: Boolean;
    function GetHasParent: Boolean;
    function GetHasSizeConstraints: Boolean;
    function GetIsAlphaBlendUsed: Boolean;
    function GetIsChild: Boolean;
    function GetIsDialog: Boolean;
    function GetIsIconic: Boolean;
    function GetIsSizeBox: Boolean;
    function GetIsZoomed: Boolean;
    function GetNativeBorderWidth: Boolean;
    function GetNeedCheckNonClientSize: Boolean;
    function GetScreenRect: TRect;
    function GetScrollAreaBounds(AItem: TdxScrollAreaElement): TRect;
    function GetScrollBarInfo(AScrollBar: TdxSkinFormScrollBar): TScrollBarInfo;
    function GetScrollBarPartBounds(AScrollBar: TdxSkinFormScrollBar; APart: TcxScrollBarPart): TRect;
    function GetScrollBarPartState(AScrollBar: TdxSkinFormScrollBar; APart: TcxScrollBarPart): TcxButtonState;
    function GetSizeArea(ASide: TcxBorder): TRect;
    function GetSizeCorners(ACorner: TdxSkinFormCorner): TRect;
    function GetSkinBorderWidth(ASide: TcxBorder): Integer;
    function GetSuppressFactor: Single;
    function GetSystemBorderWidths: TRect;
    function GetSystemSizeFrame: TSize;
    function GetThemeActive: Boolean;
    function GetToolWindow: Boolean;
    function GetWindowState: TWindowState;
    procedure SetActive(AActive: Boolean);
    procedure SetSizeType(AValue: Integer);
    procedure SetUpdateRgn(ARgn: HRGN);
  protected
    FActive: Boolean;
    FBorderBounds: array[TcxBorder] of TRect;
    FBorderWidths: TRect;
    FCaption: string;
    FCaptionFont: TFont;
    FCaptionTextBounds: TRect;
    FCaptionTextColor: array[Boolean] of TColor;
    FCaptionTextShadowColor: TColor;
    FClientBounds: TRect;
    FClientEdgeSize: TSize;
    FHasMenu: Boolean;
    FIsMDIChild: Boolean;
    FIsMDIClient: Boolean;
    FMenuBarHeight: Integer;
    FMenuSeparatorBounds: TRect;
    FPainter: TcxCustomLookAndFeelPainterClass;
    FPainterInfo: TdxSkinLookAndFeelPainterInfo;
    FScrollAreaBounds: array[TdxScrollAreaElement] of TRect;
    FScrollAreaElements: TdxScrollAreaElements;
    FScrollBarPartBounds: array[TdxSkinFormScrollBar, TcxScrollBarPart] of TRect;
    FScrollBarPartState: array[TdxSkinFormScrollBar, TcxScrollBarPart] of TcxButtonState;
    FScrollBarsInfo: array[TdxSkinFormScrollBar] of TScrollBarInfo;
    FSizeFrame: TSize;
    FSysMenuIcon: HICON;
    FTrackedScrollBar: TdxScrollAreaElement;
    FUpdateRgn: HRGN;
    FWindowBounds: TRect;
    procedure CalculateBordersInfo; virtual;
    procedure CalculateBorderWidths; virtual;
    procedure CalculateCaptionIconsInfo; virtual;
    function CalculateCaptionButtonSize(const ACaptionRect: TRect; AElement: TdxSkinElement): TSize; virtual;
    function CalculateCaptionHeight: Integer; virtual;
    function CalculateCaptionIconsHeight: Integer; virtual;
    function CalculateCaptionTextHeight: Integer; virtual;
    procedure CalculateFontInfo;
    procedure CalculateFrameSizes; virtual;
    function CalculateMargins: TRect; virtual;
    function CalculateMenuBarHeight: Integer; virtual;
    function CalculateMenuIconSize(AToolWindow: Boolean): TSize; virtual;
    procedure CalculateScrollArea; virtual;
    procedure CalculateScrollBarPartInfo(AScrollBar: TdxSkinFormScrollBar;
      Pos1, Pos2: Integer; APart: TcxScrollBarPart);
    procedure CalculateScrollBarPartsInfo; virtual;
    procedure CalculateWindowInfo; virtual;
    function GetBorderRect(ASide: TcxBorder; const ABounds, AWidths: TRect): TRect;
    function GetIcons: TdxSkinFormIcons; virtual;
    function GetIsMenuCommandEnabled(AMenuCommandId: Integer): Boolean;
    function GetMDIClientDrawRgn: HRGN; virtual;
    function GetSysMenuIcon: HICON; virtual;
    function InternalGetScrollBarInfo(AScrollBar: TdxSkinFormScrollBar): TScrollBarInfo;
    procedure MousePressed(APressed: Boolean);
    function UpdateCaptionIconStates: Boolean;
    procedure UpdateCaption(const ANewText: string);
    // System Menu
    procedure BuildSystemMenu(ASysMenu: THandle);
    procedure DestroyStandardMenu;
    procedure LoadStandardMenu;
    procedure ModifySystemMenu(ASysMenu: THandle);
    procedure ResetSystemMenu;
  public
    constructor Create(AController: TdxSkinFormController); virtual;
    destructor Destroy; override;
    procedure Calculate(AUpdateRgn: HRGN); virtual;
    function ClientToScreen(const P: TPoint): TPoint; overload;
    function ClientToScreen(const R: TRect): TRect; overload;
    function CreateDrawRgn: HRGN; virtual;
    function GetHitTest(AHitPoint: TPoint; AHitTest: Integer = 0): Integer;
    function GetScrollBarHitTest(var AScrollBar: TdxSkinFormScrollBar; var APart: TcxScrollBarPart): Boolean;
    function ScreenToClient(const P: TSmallPoint): TPoint; overload;
    function ScreenToClient(const P: TPoint): TPoint; overload;
    function ScreenToClient(const R: TRect): TRect; overload;
    procedure UpdateFormCaption;

    property Active: Boolean read FActive write SetActive;
    property BorderBounds[ASide: TcxBorder]: TRect read GetBorderBounds;
    property BorderWidths: TRect read FBorderWidths;
    property ButtonPressed: Boolean read GetButtonPressed;
    property Caption: string read FCaption;
    property CaptionFont: TFont read FCaptionFont;
    property CaptionElement: TdxSkinElement read GetCaptionElement;
    property CaptionTextBounds: TRect read FCaptionTextBounds;
    property CaptionTextColor: TColor read GetCaptionTextColor;
    property CaptionTextShadowColor: TColor read FCaptionTextShadowColor write FCaptionTextShadowColor;
    property ClientBounds: TRect read FClientBounds;
    property ClientEdgeSize: TSize read FClientEdgeSize;
    property ClientRect: TRect read FClientRect;
    property ClientRectOnClient: TRect read GetClientRectOnClient;
    property ClientOffset: Integer read FClientOffset;
    property ContentRect: TRect read GetContentRect;
    property Controller: TdxSkinFormController read FController;
    property ExStyle: Integer read FExStyle;
    property Handle: HWND read GetHandle;
    property HasBorder: Boolean read GetHasBorder;
    property HasCaption: Boolean read GetHasCaption;
    property HasCaptionTextShadow: Boolean read GetHasCaptionTextShadow;
    property HasClientEdge: Boolean read GetHasClientEdge;
    property HasMenu: Boolean read GetHasMenu;
    property HasParent: Boolean read GetHasParent;
    property HasSizeConstraints: Boolean read GetHasSizeConstraints;
    property IconInfoList: TdxSkinFormIconInfoList read FIconInfoList;
    property Icons: TdxSkinFormIcons read GetIcons;
    property IsAlphaBlendUsed: Boolean read GetIsAlphaBlendUsed;
    property IsChild: Boolean read GetIsChild;
    property IsDialog: Boolean read GetIsDialog;
    property IsIconic: Boolean read GetIsIconic;
    property IsMDIChild: Boolean read FIsMDIChild;
    property IsMDIClient: Boolean read FIsMDIClient;
    property IsSizebox: Boolean read GetIsSizeBox;
    property IsZoomed: Boolean read GetIsZoomed;
    property MenuBarHeight: Integer read FMenuBarHeight;
    property MenuSeparatorBounds: TRect read FMenuSeparatorBounds;
    property NativeBorderWidth: Boolean read GetNativeBorderWidth;
    property NeedCheckNonClientSize: Boolean read GetNeedCheckNonClientSize;
    property NonClientMetrics: TNonClientMetrics read FNonClientMetrics;
    property Painter: TcxCustomLookAndFeelPainterClass read FPainter;
    property PainterInfo: TdxSkinLookAndFeelPainterInfo read FPainterInfo;
    property ScreenRect: TRect read GetScreenRect;
    property ScrollAreaBounds[AItem: TdxScrollAreaElement]: TRect read GetScrollAreaBounds;
    property ScrollAreaElements: TdxScrollAreaElements read FScrollAreaElements;
    property ScrollBarInfo[AScrollBar: TdxSkinFormScrollBar]: TScrollBarInfo read GetScrollBarInfo;
    property ScrollBarPartBounds[AScrollBar: TdxSkinFormScrollBar; APart: TcxScrollBarPart]: TRect read GetScrollBarPartBounds;
    property ScrollBarPartState[AScrollBar: TdxSkinFormScrollBar; APart: TcxScrollBarPart]: TcxButtonState read GetScrollBarPartState;
    property SizeArea[ASide: TcxBorder]: TRect read GetSizeArea;
    property SizeCorners[ACorner: TdxSkinFormCorner]: TRect read GetSizeCorners;
    property SizeFrame: TSize read FSizeFrame;
    property SizeType: Integer read FSizeType write SetSizeType;
    property SkinBorderWidth[ASide: TcxBorder]: Integer read GetSkinBorderWidth;
    property Style: Integer read FStyle;
    property SuppressFactor: Single read GetSuppressFactor;
    property Supressed: Boolean read FSupressed;
    property SysMenuIcon: HICON read FSysMenuIcon;
    property SystemBorderWidths: TRect read GetSystemBorderWidths;
    property SystemMenu: HMENU read FSystemMenu;
    property SystemSizeFrame: TSize read GetSystemSizeFrame;
    property ThemeActive: Boolean read GetThemeActive;
    property ThemeActiveAssigned: Boolean read FThemeActiveAssigned write FThemeActiveAssigned;
    property ToolWindow: Boolean read GetToolWindow;
    property TrackedScrollBar: TdxScrollAreaElement read FTrackedScrollBar write FTrackedScrollBar;
    property UpdateRgn: HRGN read FUpdateRgn write SetUpdateRgn;
    property WindowBounds: TRect read FWindowBounds;
    property WindowRect: TRect read FWindowRect;
    property WindowState: TWindowState read GetWindowState;
  end;

  { TdxSkinFormPainter }

  TdxSkinFormPainter = class(TObject)
  private
    FBackgroundCache: TdxSkinElementCache;
    FBaseCanvas: TCanvas;
    FBordersCache: array[TcxBorder] of TdxSkinElementCache;
    FCanvas: TcxCanvas;
    FDC: HDC;
    FIconsCache: array[TdxSkinFormIcon] of TdxSkinElementCache;
    FNeedRelease: Boolean;
    FPainter: TcxCustomLookAndFeelPainterClass;
    FPainterInfo: TdxSkinLookAndFeelPainterInfo;
    FViewInfo: TdxSkinFormNonClientAreaInfo;
    function GetActive: Boolean;
    function GetFormContent: TdxSkinElement;
    function GetIconElement(AIcon: TdxSkinFormIcon): TdxSkinElement;
    function GetIsBordersThin: Boolean;
  protected
    procedure CreateCacheInfos;
    procedure DrawBackground(DC: HDC; const R: TRect); virtual;
    procedure DrawCaptionText(DC: HDC; R: TRect; const AText: string); virtual;
    procedure DrawScrollAreaElements(DC: HDC); virtual;
    procedure DrawScrollBar(DC: HDC; AScrollBar: TdxSkinFormScrollBar; const R: TRect); virtual;
    procedure DrawSizeGrip(DC: HDC; const R: TRect);
    procedure DrawWindowCaption(DC: HDC; const R: TRect; AElement: TdxSkinElement); virtual;
    procedure DrawWindowCaptionBackground(DC: HDC; const R: TRect; AElement: TdxSkinElement); virtual;
    procedure DrawWindowCaptionText(DC: HDC; R: TRect); virtual;
    procedure DrawWindowIcon(DC: HDC; AIconInfo: TdxSkinFormIconInfo); overload;
    procedure DrawWindowIcon(DC: HDC; const R: TRect; AIcon: TdxSkinFormIcon;
      AElement: TdxSkinElement; AElementState: TdxSkinElementState); overload; virtual;
    procedure FreeCacheInfos;
    procedure InternalDrawBorder(DC: HDC; const R: TRect; ASide: TcxBorder;
      AFillBackground: Boolean);
    procedure InternalDrawBorders;
    procedure InternalDrawCaption(const R: TRect; AElement: TdxSkinElement);
    procedure InternalDrawThinBorders;
  public
    constructor Create(AViewInfo: TdxSkinFormNonClientAreaInfo); virtual;
    destructor Destroy; override;
    procedure BeginPaint(ADestDC: HDC = 0);
    procedure DrawClientOffsetArea; virtual;
    procedure DrawMDIClientEdgeArea; virtual;
    procedure DrawMenuSeparator; virtual;
    procedure DrawWindowBackground; virtual;
    procedure DrawWindowBorder; virtual;
    procedure DrawWindowScrollArea; virtual;
    procedure EndPaint;
    procedure FlushCache;
    function IsRectVisible(const R: TRect): Boolean;
    function SelectDC(DC: HDC): Integer;

    property Active: Boolean read GetActive;
    property Canvas: TcxCanvas read FCanvas;
    property FormContent: TdxSkinElement read GetFormContent;
    property IconElements[AIcon: TdxSkinFormIcon]: TdxSkinElement read GetIconElement;
    property IsBordersThin: Boolean read GetIsBordersThin;
    property Painter: TcxCustomLookAndFeelPainterClass read FPainter;
    property PainterInfo: TdxSkinLookAndFeelPainterInfo read FPainterInfo;
    property ViewInfo: TdxSkinFormNonClientAreaInfo read FViewInfo;
  end;

  { TdxSkinCustomControlViewInfo }

  TdxSkinCustomControlViewInfo = class(TObject)
  private
    FController: TdxSkinWinController;
    function GetClientRect: TRect;
    function GetIsEnabled: Boolean;
    function GetIsFocused: Boolean;
    function GetIsMouseAtControl: Boolean;
  public
    constructor Create(AController: TdxSkinWinController); virtual;
    property ClientRect: TRect read GetClientRect;
    property Controller: TdxSkinWinController read FController;
    property IsEnabled: Boolean read GetIsEnabled;
    property IsFocused: Boolean read GetIsFocused;
    property IsMouseAtControl: Boolean read GetIsMouseAtControl;
  end;
  TdxSkinCustomControlViewInfoClass = class of TdxSkinCustomControlViewInfo;

  { TdxSkinForm }

  TdxSkinForm = class(TForm)
  private
    FController: TdxSkinFormController;
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DefaultWndProc(var Message: TMessage);
    procedure DestroyWindowHandle; override;
    procedure FinalizeController;
    procedure InitializeController;
    procedure WndProc(var Message: TMessage); override;

    property Controller: TdxSkinFormController read FController;
  end;

  { TdxSkinFormHelper }

  TdxSkinFormHelper = class(TObject)
  public
    class function CanUseSkin(AForm: TCustomForm): Boolean;
    class function GetActiveMDIChild(AHandle: HWND): TCustomForm;
    class function GetClientOffset(AHandle: HWND): Integer;
    class function GetForm(AHandle: HWND): TCustomForm;
    class function GetZoomedMDIChild(AHandle: HWND): TCustomForm;
    class function HasClientEdge(AHandle: HWND): Boolean;
    class function IsAlphaBlendUsed(AHandle: HWND): Boolean;
  end;

  { TdxSkinButtonViewInfo }

  TdxSkinButtonViewInfo = class(TdxSkinCustomControlViewInfo)
  private
    FActive: Boolean;
    FCaption: string;
    FState: TcxButtonState;
    function GetIsDefault: Boolean;
    function GetIsPressed: Boolean;
    function GetWordWrap: Boolean;
    procedure SetActive(AActive: Boolean);
    procedure SetState(AState: TcxButtonState);
  protected
    procedure CMFocusChanged(var Message: TCMFocusChanged);
    procedure UpdateButtonState;
  public
    constructor Create(AController: TdxSkinWinController); override;

    property Active: Boolean read FActive write SetActive;
    property Caption: string read FCaption;
    property IsDefault: Boolean read GetIsDefault;
    property IsPressed: Boolean read GetIsPressed;
    property State: TcxButtonState read FState write SetState;
    property WordWrap: Boolean read GetWordWrap;
  end;

  { TdxSkinCustomPainter }

  TdxSkinCustomControlPainter = class(TObject)
  private
    FCanvas: TCanvas;
    FcxCanvas: TcxCanvas;
    FDC: HDC;
    FNeedRelease: Boolean;
    FViewInfo: TdxSkinCustomControlViewInfo;
    function GetController: TdxSkinWinController;
    function GetPainter: TcxCustomLookAndFeelPainterClass;
  protected
    procedure BeginPaint(DC: HDC = 0);
    procedure EndPaint;
    //
    property NeedRelease: Boolean read FNeedRelease;
  public
    constructor Create(AViewInfo: TdxSkinCustomControlViewInfo);
    destructor Destroy; override;
    procedure DrawBackground;
    procedure DrawButton(const ACaption: string; const R: TRect;
      AState: TcxButtonState; AWordWrap: Boolean; AFont: TFont);
    procedure DrawFocus(const R: TRect);
    
    property Canvas: TcxCanvas read FcxCanvas;
    property Controller: TdxSkinWinController read GetController;
    property Painter: TcxCustomLookAndFeelPainterClass read GetPainter;
    property ViewInfo: TdxSkinCustomControlViewInfo read FViewInfo;
  end;

  { TdxSkinCustomController }

  TdxSkinCustomController = class(TdxSkinWinController)
  private
    FPainter: TdxSkinCustomControlPainter;
    FViewInfo: TdxSkinCustomControlViewInfo;
  protected
    class function GetViewInfoClass: TdxSkinCustomControlViewInfoClass; virtual;
    function GetMaster(AHandle: HWND): TdxSkinWinController; override;
    procedure InitializePainter; override;
    procedure WndProc(var AMessage: TMessage); override;
    // Messages
    function WMEraseBk(var AMessage: TWMEraseBkgnd): Boolean; virtual;
    function WMPaint(var AMessage: TWMPaint): Boolean; virtual;
  public
    constructor Create(AHandle: HWND); override;
    destructor Destroy; override;
    procedure DrawBackground(DC: HDC = 0);
    procedure DrawContent(DC: HDC = 0); virtual;
    
    property Painter: TdxSkinCustomControlPainter read FPainter;
    property ViewInfo: TdxSkinCustomControlViewInfo read FViewInfo;
  end;

  { TdxSkinButtonController }

  TdxSkinButtonController = class(TdxSkinCustomController)
  protected
    function GetViewInfo: TdxSkinButtonViewInfo;
    class function GetViewInfoClass: TdxSkinCustomControlViewInfoClass; override;
    procedure MouseLeave; override;
    procedure WndProc(var AMessage: TMessage); override;
  public
    procedure DrawContent(DC: HDC = 0); override;
    
    property ViewInfo: TdxSkinButtonViewInfo read GetViewInfo;
  end;

  { TdxSkinPanelController }

  TdxSkinPanelController = class(TdxSkinCustomController)
  private
    FPainting: Boolean;
  protected
    function WMEraseBk(var AMessage: TWMEraseBkgnd): Boolean; override;
    function WMPaint(var AMessage: TWMPaint): Boolean; override;
    function WMPrintClient(var AMessage: TWMPrintClient): Boolean; virtual;
    procedure InternalDrawBackground(APanel: TCustomPanel; const R: TRect);
    procedure WndProc(var AMessage: TMessage); override;
  public
    procedure DrawContent(DC: HDC = 0); override;
  end;

  { TdxSkinFrameController }

  TdxSkinFrameController = class(TdxSkinFormController)
  private
    function GetIsTransparent: Boolean;
  protected
    function GetMaster(AHandle: HWND): TdxSkinWinController; override;
    procedure DrawWindowBackground(DC: HDC); override;
    procedure InitializePainter; override;
    procedure WMWindowPosChanged(var Message: TWMWindowPosMsg); override;
    //
    property IsTransparent: Boolean read GetIsTransparent;
  end;

var
  dxSkinControllersList: TList;
  dxSkinGetControllerClassForWindowProc: TdxSkinGetControllerClassForWindowProc;

function dxSkinGetControllerClassForWindow(AWnd: HWND): TdxSkinWinControllerClass;
implementation

const
  SC_TITLEDBLCLICK = 61490; 
{$IFNDEF DELPHI7}
  ICON_SMALL2 = 2;

  WM_NCMOUSELEAVE     = $02A2;
  WM_NCMOUSEHOVER     = $02A0;
{$ENDIF}
  WM_NCUAHDRAWCAPTION = $00AE;
  WM_NCUAHDRAWFRAME   = $00AF;
  WM_SYNCPAINT        = $0088;
  WM_SYSMENU          = $313;

  // hittests
  CornerHitTests: array[TdxSkinFormCorner] of DWORD =
    (HTTOPLEFT, HTTOPRIGHT, HTBOTTOMLEFT, HTBOTTOMRIGHT);
  ResizeHitTests: array[TcxBorder] of DWORD =
    (HTLEFT, HTTOP, HTRIGHT, HTBOTTOM);

const
  CaptionFlags = DT_VCENTER or DT_SINGLELINE or DT_EDITCONTROL or
    DT_END_ELLIPSIS or DT_NOPREFIX;
  FrameStates: array[Boolean] of TdxSkinElementState = (esActiveDisabled, esActive);

type

  { TdxSkinWinControllerHelper }

  TdxSkinWinControllerHelper = class(TObject)
  private
    FHandle: HWND;
  protected
    procedure InternalInitializeEngine(AHandle: HWND);
    procedure WndProc(var AMsg: TMessage);
  public
    constructor Create;
    destructor Destroy; override;
    procedure ChildChanged(AHandle: HWND);
    procedure FinalizeEngine(AHandle: HWND);
    procedure InitializeEngine(AHandle: HWND);
    
    property Handle: HWND read FHandle;
  end;

  { TdxSkinFormControllers }

  TdxSkinFormControllers = class(TcxObjectList)
  private
    function GetItem(Index: Integer): TdxSkinWinController;
  public
    function GetControllerByControl(AControl: TWinControl): TdxSkinWinController;
    function GetControllerByHandle(AHandle: HWND): TdxSkinWinController;
    procedure MasterDestroyed(AMaster: TdxSkinWinController);
    procedure Refresh(AControl: TWinControl = nil);
    //
    property Items[Index: Integer]: TdxSkinWinController read GetItem; default;
  end;

var
  FormControllers: TdxSkinFormControllers;
  SkinHelper: TdxSkinWinControllerHelper;
  WndProcHookHandle: HHOOK;

type
  TControlAccess = class(TControl);
  TCustomFormAccess = class(TCustomForm);
  TCustomFrameAccess = class(TCustomFrame);
  TCustomLabelAccess = class(TCustomLabel);
  TCustomPanelAccess = class(TCustomPanel);

function SetWindowInvisibleStyle(AWnd: HWND): Cardinal;
begin
  Result := GetWindowLong(AWnd, GWL_STYLE);
  SetWindowLong(AWnd, GWL_STYLE, Result and not WS_VISIBLE);
end;

procedure RestoreWindowStyles(AWnd: HWND; AStyles: Cardinal);
begin
  SetWindowLong(AWnd, GWL_STYLE, AStyles);
end;

function CanUseSkinForControl(AControl: TWinControl): Boolean;
var
  AIndex: Integer;
  ASkinController: TdxSkinController;
begin
  Result := cxUseSkins and Assigned(AControl);
  if Assigned(AControl) then
  begin
    for AIndex := dxSkinControllersList.Count - 1 downto 0 do
    begin
      ASkinController := TdxSkinController(dxSkinControllersList[AIndex]);
      if not (csDestroying in ASkinController.ComponentState) then
      begin
        Result := ASkinController.DoSkinControl(AControl);
        if Result then Break;
      end;
    end;
  end;
end;

function GetWindowCaption(AWnd: HWND): string;
var
  AControl: TControl;
  L: Integer;
begin
  AControl := FindControl(AWnd);
  if AControl <> nil then // todo: bug with Delphi2007
    Result := TControlAccess(AControl).Caption
  else
  begin
    L := SendMessage(AWnd, WM_GETTEXTLENGTH, 0, 0);
    SetLength(Result, L);
    if L > 0 then
      SendMessage(AWnd, WM_GETTEXT, L + 1, Integer(@Result[1]));
  end;
end;

function GetWindowClass(AWnd: HWND): string;
var
  AClassName: array[Byte] of Char;
begin
  if GetClassName(AWnd, @AClassName[0], 256) > 0 then
    Result := AClassName
  else
    Result := '';  
end;

procedure RefreshControllers(AControl: TWinControl = nil);
begin
  if not (csDestroying in Application.ComponentState) then
  begin
    if FormControllers <> nil then
      FormControllers.Refresh(AControl);
  end;
end;

{ TdxSkinForm }

procedure TdxSkinForm.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited CreateWindowHandle(Params);
  InitializeController;
end;

procedure TdxSkinForm.DestroyWindowHandle;
begin
  FinalizeController;
  inherited DestroyWindowHandle;
end;

procedure TdxSkinForm.DefaultWndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
end;

procedure TdxSkinForm.FinalizeController;
begin
  if Controller <> nil then
  begin
    FormControllers.Remove(Controller);
    FreeAndNil(FController);
  end;
end;

procedure TdxSkinForm.InitializeController;
begin
  FController := TdxSkinFormController.CreateEx(Self);
  FormControllers.Add(Controller);
  Controller.InitializePainter;
  Controller.Update;
  PostMessage(Handle, DXM_SKINS_POSTCHECKRGN, 0, 0);
end;

procedure TdxSkinForm.WndProc(var Message: TMessage);
begin
  if Message.Msg = DXM_SKINS_HASOWNSKINENGINE then
    Message.Result := 1
  else
    if (Controller = nil) or (Controller.Handle = 0) then
      DefaultWndProc(Message)
    else
      Controller.WndProc(Message);
end;

{ TdxSkinWinController }

constructor TdxSkinWinController.Create(AHandle: HWND);
begin
  Handle := AHandle;
end;

destructor TdxSkinWinController.Destroy;
begin
  MasterDestroyed;
  EndMouseTracking(Self);
  Handle := 0;
  inherited Destroy;
end;

class procedure TdxSkinWinController.InitializeEngine(AHandle: HWND);
var
  ANewController: TdxSkinWinController;
begin
  ANewController := FormControllers.GetControllerByHandle(AHandle);
  if ANewController = nil then
  begin
    ANewController := FormControllers.GetControllerByControl(FindControl(AHandle));
    if ANewController <> nil then
      ANewController.Handle := AHandle
    else
    begin
      ANewController := Self.Create(AHandle);
      ANewController.FMaster := ANewController.GetMaster(AHandle);
      FormControllers.Add(ANewController);
    end;
    ANewController.InitializePainter;
    ANewController.Update;
  end;
end;

class procedure TdxSkinWinController.FinalizeEngine(AHandle: HWND);
var
  AController: TdxSkinWinController;
begin
  AController := FormControllers.GetControllerByHandle(AHandle);
  if Assigned(AController) then
    FormControllers.FreeAndRemove(AController);
end;

class function TdxSkinWinController.IsMDIChildWindow(AHandle: HWND): Boolean;
var
  AControl: TWinControl;
begin
  AControl := FindControl(AHandle);
  Result := (AControl is TCustomForm) and
    (TCustomFormAccess(AControl).FormStyle = fsMDIChild);
end;

class function TdxSkinWinController.IsMDIClientWindow(AHandle: HWND): Boolean;
begin
  Result := AnsiSameText(GetWindowClass(AHandle), 'MDICLIENT');
end;

class function TdxSkinWinController.IsSkinActive(AHandle: HWND): Boolean;
var
  AController: TdxSkinWinController;
begin
  AController := FormControllers.GetControllerByHandle(AHandle);
  Result := Assigned(AController) and AController.IsSkinUsed;
end;

class function TdxSkinWinController.IsMessageDlgWindow(AHandle: HWND): Boolean;
var
  AWindowClass: string;
begin
  AWindowClass := GetWindowClass(AHandle);
  Result := SameText(AWindowClass, 'TMessageForm') or SameText(AWindowClass, 'TForm');
end;

function TdxSkinWinController.GetHasVirtualChilds: Boolean;
var
  AControl: TWinControl;
  I: Integer;
begin
  AControl := WinControl;
  Result := False;
  if Assigned(AControl) then
    for I := 0 to AControl.ControlCount - 1 do
    begin
      Result := not (AControl.Controls[I] is TWinControl);
      if Result then
        Break;
    end;    
end;

function TdxSkinWinController.GetIsHooked: Boolean;
begin
  Result := (Handle <> 0) and Assigned(FWindowProcObject);
end;

function TdxSkinWinController.GetIsMDIClient: Boolean;
begin
  Result := Assigned(FMaster);
end;

function TdxSkinWinController.GetLookAndFeelPainter: TdxSkinLookAndFeelPainterClass;
begin
  Result := FLookAndFeelPainter;
  if Master <> nil then
    Result := Master.LookAndFeelPainter;
end;

procedure TdxSkinWinController.SetHandle(AHandle: HWND);
begin
  UnHookWndProc;
  FHandle := AHandle;
  FWinControl := FindControl(Handle);
  Update;
end;

function TdxSkinWinController.GetIsSkinUsed: Boolean;
begin
  Result := LookAndFeelPainter <> nil;
end;

function TdxSkinWinController.GetMaster(AHandle: HWND): TdxSkinWinController;
begin
  Result := nil;
  if IsMDIClientWindow(AHandle) then
    Result := FormControllers.GetControllerByHandle(GetParent(AHandle));
end;

function TdxSkinWinController.GetUseSkinForControl: Boolean;
begin
  Result := CanUseSkinForControl(WinControl);
end;

function TdxSkinWinController.IsHookAvailable: Boolean;
begin
  Result := IsSkinUsed;
end;

procedure TdxSkinWinController.DefWndProc(var AMessage);
begin
  if FWindowProcObject <> nil then
    FWindowProcObject.DefaultProc(TMessage(AMessage));
end;

procedure TdxSkinWinController.HookWndProc;
begin
  UnHookWndProc;
  if (Handle <> 0) and IsHookAvailable then
  begin
    if FWinControl = nil then
      FWindowProcObject := cxWindowProcController.Add(Handle, WndProc)
    else
      FWindowProcObject := cxWindowProcController.Add(FWinControl, WndProc);
  end;
end;

procedure TdxSkinWinController.InitializePainter;
begin
  // nothing to do
end;

procedure TdxSkinWinController.MasterDestroyed;
begin
  FormControllers.MasterDestroyed(Self);
end;

procedure TdxSkinWinController.RedrawWindow(AUpdateNow: Boolean);
var
  AFlags: Integer;
const
  DefaultFlags = RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN;
begin
  if Handle = 0 then Exit;
  AFlags := DefaultFlags;
  if AUpdateNow then
    AFlags := AFlags or RDW_UPDATENOW;
  Windows.RedrawWindow(Handle, nil, 0, AFlags);
end;

procedure TdxSkinWinController.UnHookWndProc;
begin
  if IsHooked then
    cxWindowProcController.Remove(FWindowProcObject);
end;

procedure TdxSkinWinController.WndProc(var AMessage: TMessage);
begin
  DefWndProc(AMessage);
end;

function TdxSkinWinController.GetSkinName(var ASkinName: string): Boolean;
begin
  Result := GetExtendedStylePainters.GetNameByPainter(FLookAndFeelPainter, ASkinName);
end;

procedure TdxSkinWinController.Refresh;
const
  Flags = SWP_FRAMECHANGED or SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE or
    SWP_NOZORDER;
begin
  if Handle <> 0 then
    SetWindowPos(Handle, 0, 0, 0, 0, 0, Flags);
end;

procedure TdxSkinWinController.RefreshController;
begin
  FLookAndFeelPainter := nil;
  FMaster := GetMaster(Handle);
end;

procedure TdxSkinWinController.Update;
begin
  HookWndProc;
  Refresh;
  RedrawWindow(HasVirtualChilds);
end;

procedure TdxSkinWinController.MouseLeave;
begin
end;

{ TdxSkinController }

constructor TdxSkinController.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if dxSkinControllersList <> nil then
    dxSkinControllersList.Add(Self);
  Refresh;
end;

destructor TdxSkinController.Destroy;
begin
  Refresh;
  if dxSkinControllersList <> nil then
    dxSkinControllersList.Remove(Self);
  inherited Destroy;
end;

procedure TdxSkinController.Refresh(AControl: TWinControl = nil);
begin
  RefreshControllers(AControl);
end;

procedure TdxSkinController.Reset;
begin
  inherited Reset;
  UseSkins := cxDefaultUseSkins;
end;

class function TdxSkinController.GetFormSkin(AForm: TCustomForm; var ASkinName: string): Boolean;
var
  AController: TdxSkinWinController;
begin
  AController := FormControllers.GetControllerByHandle(AForm.Handle);
  Result := Assigned(AController) and AController.GetSkinName(ASkinName);
end;

procedure TdxSkinController.DoPopupSystemMenu(AForm: TCustomForm; ASysMenu: HMENU);
begin
  if Assigned(AForm) then
  begin
    if Assigned(OnPopupSysMenu) then
      OnPopupSysMenu(Self, AForm, ASysMenu);
  end;
end;

function TdxSkinController.DoSkinControl(AControl: TWinControl): Boolean;
var
  AUseSkin: Boolean;
begin
  Result := AControl <> nil;
  if Result then
  begin
    AUseSkin := True;
    if Assigned(OnSkinControl) then
      OnSkinControl(Self, AControl, AUseSkin);
    Result := AUseSkin
  end
end;

function TdxSkinController.DoSkinForm(AForm: TCustomForm): TdxSkinLookAndFeelPainterClass;
var
  ASkinName: string;
  AUseSkin: Boolean;
begin
  if TdxSkinFormHelper.CanUseSkin(AForm) then
  begin
    ASkinName := SkinName;
    AUseSkin := UseSkins and not NativeStyle;
    Result := DoSkinFormEx(AForm, ASkinName, AUseSkin);
  end
  else
  begin
    AUseSkin := False;
    ASkinName := '';
    Result := nil;
  end;
end;

function TdxSkinController.DoSkinFormEx(AForm: TCustomForm;
  var ASkinName: string; var AUseSkin: Boolean): TdxSkinLookAndFeelPainterClass;
var
  APainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := nil;
  if Assigned(AForm) then
  begin
    if Assigned(OnSkinForm) then
      OnSkinForm(Self, AForm, ASkinName, AUseSkin);
    if AUseSkin and (ASkinName <> '') and
      GetExtendedStylePainters.GetPainterByName(ASkinName, APainter) and
      (APainter.InheritsFrom(TdxSkinLookAndFeelPainter))
    then
      Result := TdxSkinLookAndFeelPainterClass(APainter);
  end;
end;

procedure TdxSkinController.Loaded;
begin
  inherited Loaded;
  Refresh;
end;

procedure TdxSkinController.MasterLookAndFeelChanged(
  Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
begin
  inherited MasterLookAndFeelChanged(Sender, AChangedValues);
  Refresh;
end;

procedure TdxSkinController.MasterLookAndFeelDestroying(Sender: TcxLookAndFeel);
begin
  inherited MasterLookAndFeelDestroying(Sender);
  Refresh;
end;

function TdxSkinController.GetUseSkins: Boolean;
begin
  Result := cxUseSkins;
end;

procedure TdxSkinController.SetUseSkins(Value: Boolean);
begin
  if Value <> UseSkins then
  begin
    cxLookAndFeels.cxUseSkins := Value;
    RootLookAndFeel.Refresh;
    Refresh;
  end;
end;

{ TdxSkinFormController }

constructor TdxSkinFormController.Create(AHandle: HWND);
begin
  inherited Create(AHandle);
  FViewInfo := TdxSkinFormNonClientAreaInfo.Create(Self);
  FPainter := TdxSkinFormPainter.Create(FViewInfo);
  if IsMessageDlgWindow(AHandle) then
    PostMessage(AHandle, DXM_SKINS_POSTMSGFORMINIT, 0, 0);
end;

constructor TdxSkinFormController.CreateEx(ASkinForm: TdxSkinForm);
begin
  FSkinForm := ASkinForm;
  Create(ASkinForm.Handle);
end;

destructor TdxSkinFormController.Destroy;
begin
  Handle := 0;
  cxClearObjectLinks(Self);
  FreeAndNil(FPainter);
  FreeAndNil(FViewInfo);
  inherited Destroy;
end;

procedure TdxSkinFormController.RefreshController;
var
  ASkinController: TdxSkinController;
  ASkinName: string;
  AUseSkin: Boolean;
  I: Integer;
begin
  inherited RefreshController;
  ViewInfo.UpdateFormCaption; 

  for I := dxSkinControllersList.Count - 1 downto 0 do
  begin
    ASkinController := TdxSkinController(dxSkinControllersList[I]);
    if csDestroying in ASkinController.ComponentState then
      Continue;

    if FLookAndFeelPainter = nil then
      FLookAndFeelPainter := ASkinController.DoSkinForm(Form)
    else
      if TdxSkinFormHelper.CanUseSkin(Form) then
      begin
        AUseSkin := GetSkinName(ASkinName);
        FLookAndFeelPainter := ASkinController.DoSkinFormEx(Form, ASkinName, AUseSkin);
      end
      else
        FLookAndFeelPainter := nil;
  end;
end;

procedure TdxSkinFormController.Refresh;
begin
  inherited Refresh;
  if Assigned(Painter) then
    Painter.FlushCache;
  if Handle <> 0 then
  begin
    if IsSkinUsed then
    begin
      UpdateViewInfoState;
      CalculateViewInfo;
      CheckWindowRgn;
    end
    else
      FlushWindowRgn(False);
  end;
end;

procedure TdxSkinFormController.UnHookWndProc;
begin
  if IsHooked then
    ViewInfo.BuildSystemMenu(GetSystemMenu(Handle, False));
  inherited UnHookWndProc;
end;

procedure TdxSkinFormController.UpdateViewInfoState;
const
  WindowState: array[Boolean] of Integer = (0, SIZE_MAXIMIZED);
begin
  ViewInfo.SizeType := WindowState[ViewInfo.IsZoomed];
  ViewInfo.ResetSystemMenu;
  CheckWindowRgn;
end;

procedure TdxSkinFormController.DefWndProc(var AMessage);
begin
  if SkinForm = nil then
    inherited DefWndProc(AMessage)
  else
    SkinForm.DefaultWndProc(TMessage(AMessage));
end;

procedure TdxSkinFormController.DoPopupSystemMenu(AForm: TCustomForm; ASysMenu: HMENU);
var
  I: Integer;
begin
  for I := 0 to dxSkinControllersList.Count - 1 do
    TdxSkinController(dxSkinControllersList[I]).DoPopupSystemMenu(AForm, ASysMenu);
end;

procedure TdxSkinFormController.DrawWindowBackground(DC: HDC);
begin
  Painter.BeginPaint(DC);
  try
    Painter.DrawWindowBackground;
  finally
    Painter.EndPaint;
  end;
end;

procedure TdxSkinFormController.DrawWindowBorder(DC: HDC = 0);
begin
  Painter.BeginPaint(DC);
  try
    Painter.DrawWindowBorder;
  finally
    Painter.EndPaint;
  end;
end;

procedure TdxSkinFormController.DrawWindowScrollArea(DC: HDC = 0);
begin
  Painter.BeginPaint(DC);
  try
    Painter.DrawWindowScrollArea;
  finally
    Painter.EndPaint;
  end;
end;

procedure TdxSkinFormController.CalculateViewInfo;
begin
  ViewInfo.Calculate(0);
end;

procedure TdxSkinFormController.CheckWindowRgn;
var
  ARegion, AScreenRegion: HRGN;
begin
  if ViewInfo.HasBorder then
  begin
    ARegion := CreateRectRgnIndirect(ViewInfo.WindowBounds);
    if ViewInfo.IsZoomed and not (ViewInfo.HasSizeConstraints or ViewInfo.HasParent) then
    begin
      AScreenRegion := CreateRectRgnIndirect(
        cxRectOffset(ViewInfo.ScreenRect, ViewInfo.WindowRect.TopLeft, False));
      CombineRgn(ARegion, ARegion, AScreenRegion, RGN_AND);
      DeleteObject(AScreenRegion);
    end;
    SetWindowRgn(Handle, ARegion, True);
    HasRegion := True;
  end
  else
    FlushWindowRgn;
end;

procedure TdxSkinFormController.FlushWindowRgn(ARedraw: Boolean = True);
begin
  if HasRegion then
  begin
    HasRegion := False;
    SetWindowRgn(Handle, 0, False);
    if ARedraw then
      PostRedraw;
  end;
end;

procedure TdxSkinFormController.InitializeMessageForm;
var
  I: Integer;
  AForm: TCustomForm;
begin
  AForm := Form;
  for I := AForm.ControlCount - 1 downto 0 do
  begin
    if AForm.Controls[I] is TCustomLabel then
      TCustomLabelAccess(AForm.Controls[I]).Transparent := True;
  end;    
end;

procedure TdxSkinFormController.InitializePainter;
var
  ASkinName: string;
  AUseSkin: Boolean;
  I: Integer;
begin
  if Form = nil then
    Exit;

  for I := 0 to dxSkinControllersList.Count - 1 do
    with TdxSkinController(dxSkinControllersList[I]) do
    begin
      if I = 0 then
      begin
        FLookAndFeelPainter := DoSkinForm(Form);
        AUseSkin := FLookAndFeelPainter <> nil;
      end
      else
      begin
        AUseSkin := GetFormSkin(Form, ASkinName);
        FLookAndFeelPainter := DoSkinFormEx(Form, ASkinName, AUseSkin);
      end;
      if FLookAndFeelPainter <> nil then
        Break;
    end;
end;

procedure TdxSkinFormController.InvalidateBorders;
begin
  CalculateViewInfo;
  DrawWindowBorder;
end;

function TdxSkinFormController.HandleInternalMessages(var AMessage: TMessage): Boolean;
begin
  Result := True;
  case AMessage.Msg of
    DXM_SKINS_CHILDCHANGED:
      begin
        ViewInfo.UpdateFormCaption;
        DrawWindowBorder;
      end;
    DXM_SKINS_POSTREDRAW:
      RedrawWindow(False);
    DXM_SKINS_POSTCHECKRGN:
      UpdateViewInfoState
  else
    Result := False;
  end;
end;

function TdxSkinFormController.HandleWindowMessage(var AMessage: TMessage): Boolean;
begin
  Result := True;
  if ForceRedraw then
  begin
    DrawWindowBorder;
    ForceRedraw := False;
  end;
  case AMessage.Msg of
    WM_CONTEXTMENU:
      Result := WMContextMenu(TWMContextMenu(AMessage));
    WM_NCCALCSIZE:
      WMNCCalcSize(TWMNCCalcSize(AMessage));
    WM_NCMOUSEMOVE:
      WMNCMouseMove(TWMNCHitMessage(AMessage));
    WM_NCACTIVATE:
      WMNCActivate(TWMNCActivate(AMessage));
    WM_NCUAHDRAWFRAME, WM_NCUAHDRAWCAPTION, WM_SYNCPAINT:
      DrawWindowBorder;
    WM_NCLBUTTONDOWN, WM_NCLBUTTONDBLCLK:
      WMNCButtonDown(TWMNCHitMessage(AMessage));
    WM_NCLBUTTONUP:
      Result := WMNCLButtonUp(TWMNCHitMessage(AMessage));
    WM_NCPAINT:
      WMNCPaint(TWMNCPaint(AMessage));
    WM_NCHITTEST:
      Result := WMNCHitTest(TWMNCHitTest(AMessage));
    WM_ERASEBKGND:
      WMEraseBkgnd(TWMEraseBkgnd(AMessage));
    WM_SYSMENU:
      WMSysMenu(AMessage);
    WM_SYSCOMMAND:
      WMSysCommand(TWMSysCommand(AMessage));
    WM_INITMENU:
      WMInitMenu(TWMInitMenu(AMessage));
    WM_ACTIVATE, WM_MOUSEACTIVATE:
      WMActivate(AMessage);
    $3F:
      begin
        DefWndProc(AMessage);
        Refresh;
      end;
    else
      Result := HandleInternalMessages(AMessage);
  end;
end;

function TdxSkinFormController.IsHookAvailable: Boolean;
begin
  Result := inherited IsHookAvailable and (SkinForm = nil);
end;

procedure TdxSkinFormController.LockRedraw;
begin
  Inc(FLockRedrawCount);
  if FLockRedrawCount = 1 then
    DefWindowProc(Handle, WM_SETREDRAW, 0, 0);
end;

procedure TdxSkinFormController.PostRedraw;
begin
  PostMessage(Handle, DXM_SKINS_POSTREDRAW, 0, 0);
end;

function TdxSkinFormController.RefreshOnMouseEvent(AForceRefresh: Boolean = False): Boolean;
var
  APart: TcxScrollBarPart;
  AScrollBar: TdxSkinFormScrollBar;
begin
  with ViewInfo do
  begin
    Result := UpdateCaptionIconStates;
    if Assigned(IconHot) then
      BeginMouseTracking(nil, ClientToScreen(IconHot.Bounds), Self)
    else
      if GetScrollBarHitTest(AScrollBar, APart) then
      begin
        Result := not IsMouseTracking(Self);
        BeginMouseTracking(nil, ClientToScreen(ScrollBarPartBounds[AScrollBar, APart]), Self)
      end
      else
      begin
        Result := Result or IsMouseTracking(Self);
        EndMouseTracking(Self);
      end;
  end;
  if Result or AForceRefresh then
    InvalidateBorders;
end;

procedure TdxSkinFormController.RefreshOnSystemMenuShown;
begin
  if IsWin2K or ViewInfo.NativeBorderWidth then
    PostRedraw;
end;

procedure TdxSkinFormController.UnlockRedraw;
begin
  Dec(FLockRedrawCount);
  if FLockRedrawCount = 0 then
    DefWindowProc(Handle, WM_SETREDRAW, 1, 0);
end;

procedure TdxSkinFormController.ShowSystemMenu(
  const P: TPoint; const AExcludeRect: TRect; ABottomAlign: Boolean);
const
  AlignMap: array[Boolean] of Integer = (TPM_TOPALIGN, TPM_BOTTOMALIGN);
var
  ACommand: LongWord;
  AParams: TTPMParams;
begin
  RefreshOnSystemMenuShown;
  ZeroMemory(@AParams, SizeOf(AParams));
  AParams.cbSize := SizeOf(AParams);
  AParams.rcExclude := AExcludeRect;
  ACommand := LongWord(TrackPopupMenuEx(GetSystemMenu(Handle, False),
    TPM_RETURNCMD or TPM_LEFTALIGN or AlignMap[ABottomAlign], P.X, P.Y, Handle, @AParams));
  PostMessage(Handle, WM_SYSCOMMAND, ACommand, 0);
end;

procedure TdxSkinFormController.ShowSystemMenu(const P: TPoint);
begin
  ShowSystemMenu(P, cxNullRect);
end;

procedure TdxSkinFormController.ShowSystemMenu;
var
  R: TRect;
begin
  if ViewInfo.IsIconic then
    R := ViewInfo.WindowRect
  else
  begin
    R := ViewInfo.ClientToScreen(ViewInfo.GetCaptionBounds);
    Inc(R.Bottom, ViewInfo.GetCaptionContentOffset.Bottom);
  end;
  ShowSystemMenu(Point(R.Left, R.Bottom),
    Rect(Screen.DesktopRect.Left, R.Top, Screen.DesktopRect.Right, R.Bottom),
    ViewInfo.IsIconic);
end;

procedure TdxSkinFormController.AfterWndProc(var AMessage: TMessage);
begin
  case AMessage.Msg of
    WM_PRINT:
      WMPrint(TWMPrint(AMessage));
    WM_SIZE:
      WMSize(TWMSize(AMessage));
    WM_WINDOWPOSCHANGED:
      WMWindowPosChanged(TWMWindowPosMsg(AMessage));
    WM_DESTROY, WM_MDIDESTROY:
      if AMessage.WParam = 0 then
      begin
        FLookAndFeelPainter := nil;
        UnHookWndProc;
      end;
    WM_VSCROLL, WM_HSCROLL:
      begin
        UnlockRedraw;
        RedrawWindow(True);
        LockRedraw;
      end;
  end;
end;

procedure TdxSkinFormController.BeforeWndProc(var AMessage: TMessage);
begin
  case AMessage.Msg of
    WM_PAINT:
      WMPaint(TWMPaint(AMessage));
    WM_EXITMENULOOP, WM_QUERYOPEN:
      ViewInfo.ResetSystemMenu;
    WM_SHOWWINDOW:
      PostMessage(Handle, DXM_SKINS_POSTREDRAW, 0, 0);
    WM_NCCREATE:
      begin
        FlushWindowRgn;
        CalculateViewInfo;
      end;
    WM_VSCROLL, WM_HSCROLL:
      if TWMScroll(AMessage).ScrollCode = SB_THUMBTRACK then
        ViewInfo.TrackedScrollBar := TdxScrollAreaElement(AMessage.Msg - WM_HSCROLL)
      else
        ViewInfo.TrackedScrollBar := saeSizeGrip;
  end;
end;

procedure TdxSkinFormController.WMActivate(var Message: TMessage);
var
  AObjectLink: TcxObjectLink;
begin
  AObjectLink := cxAddObjectLink(Self);
  try
    DefWndProc(Message);
    if Assigned(AObjectLink.Ref) then
      DrawWindowBorder;
  finally
    cxRemoveObjectLink(AObjectLink);
  end;
end;

function TdxSkinFormController.WMContextMenu(var Message: TWMContextMenu): Boolean;
begin
  case ViewInfo.GetHitTest(SmallPointToPoint(Message.Pos)) of
    HTCAPTION, HTSYSMENU:
      begin
        Result := True;
        ShowSystemMenu(SmallPointToPoint(Message.Pos));
        Message.Result := 0;
      end;
    else
      Result := False;
  end;
end;

procedure TdxSkinFormController.WMEraseBkgnd(var Message: TWMEraseBkgnd);
var
  ASaveIndex: Integer;
begin
  if Message.DC <> 0 then
  begin
    ASaveIndex := SaveDC(Message.DC);
    try
      DrawWindowBackground(Message.DC);
      Message.Result := 1;
    finally
      RestoreDC(Message.DC, ASaveIndex);
    end;
  end;
end;

procedure TdxSkinFormController.WMInitMenu(var Message: TWMInitMenu);
var
  AStyles: Integer;
begin
  Message.Menu := GetSystemMenu(Handle, False);
  AStyles := SetWindowInvisibleStyle(Handle);
  try
    ViewInfo.BuildSystemMenu(Message.Menu);
    DoPopupSystemMenu(Form, Message.Menu);
    DefWndProc(Message);
  finally
    RestoreWindowStyles(Handle, AStyles);
  end;
end;

procedure TdxSkinFormController.WMNCActivate(var Message: TWMNCActivate);
var
  AChildForm: TCustomForm;
  AStyles: DWORD;
begin
  ViewInfo.Active := Message.Active;
  if ViewInfo.IsChild then
  begin
    AStyles := SetWindowInvisibleStyle(Handle);
    Message.Result := DefWindowProc(Handle, WM_NCACTIVATE, TMessage(Message).WParam, 0);
    RestoreWindowStyles(Handle, AStyles);
  end
  else
    Message.Result := 1;

  AChildForm := TdxSkinFormHelper.GetActiveMDIChild(Handle);
  if Assigned(AChildForm) then
    AChildForm.Perform(WM_NCACTIVATE, TMessage(Message).WParam, 0);
  DrawWindowBorder;
end;

procedure TdxSkinFormController.WMNCButtonDown(var Message: TWMNCHitMessage);
var
  ALink: TcxObjectLink;
  ALocked: Boolean;
begin
  ALink := cxAddObjectLink(Self);
  try
    ForceRedraw := True;
    ViewInfo.MousePressed(True);
    ViewInfo.UpdateCaptionIconStates;
    ALocked := Message.HitTest in [HTHSCROLL, HTVSCROLL];
    if ALocked then
      LockRedraw;
    if (IconPressed = nil) or (IconPressed.IconType = sfiMenu) then
      DefWndProc(Message);

    if Assigned(ALink.Ref) then
    begin
      if ALocked then
        UnlockRedraw;
      RefreshOnMouseEvent(True);
      DrawWindowBorder;
    end;  
  finally
    cxRemoveObjectLink(ALink);
  end;
  Message.Result := 0;
end;

procedure TdxSkinFormController.WMNCCalcSize(var Message: TWMNCCalcSize);
var
  R: TRect;
begin
  R := Message.CalcSize_Params^.rgrc[0];
  DefWndProc(Message);
  CalculateViewInfo;
  if Message.CalcValidRects and ViewInfo.NeedCheckNonClientSize then
    Message.CalcSize_Params^.rgrc[0] := cxRectContent(R, ViewInfo.CalculateMargins);
end;

function TdxSkinFormController.WMNCHitTest(var Message: TWMNCHitTest): Boolean;
begin
  Message.Result := ViewInfo.GetHitTest(SmallPointToPoint(Message.Pos), Message.Result);
  Result := (Message.Result <> HTNOWHERE) and (Message.Result <> HTSYSMENU);
end;

function TdxSkinFormController.WMNCLButtonUp(var Message: TWMNCHitMessage): Boolean;
var
  APressedIcon: TdxSkinFormIconInfo;
begin
  APressedIcon := nil;
  if IconPressed = IconHot then
    APressedIcon := IconPressed;
  ViewInfo.MousePressed(False);
  RefreshOnMouseEvent(True);
  Result := Assigned(APressedIcon);
  if Result and APressedIcon.Enabled then
  begin
    Result := APressedIcon.IconType <> sfiHelp;
    if Result then
      SendMessage(Handle, WM_SYSCOMMAND, APressedIcon.Command, 0);
  end;
end;

procedure TdxSkinFormController.WMNCMouseMove(var Message: TWMNCHitMessage);
begin
  if not RefreshOnMouseEvent then
  begin
    Message.HitTest := 0;
    DefWndProc(Message);
    DrawWindowBorder;
  end;
end;

procedure TdxSkinFormController.WMNCPaint(var Message: TWMNCPaint);
var
  AFrameRgn, AWindowRgn: HRgn;
begin
  InvalidateBorders;
  if ViewInfo.HasMenu or ViewInfo.IsMDIClient then
  begin
    AFrameRgn := ViewInfo.CreateDrawRgn;
    AWindowRgn := CreateRectRgnIndirect(ViewInfo.WindowRect);
    CombineRgn(AWindowRgn, AWindowRgn, AFrameRgn, RGN_XOR);
    DeleteObject(AFrameRgn);
    if Message.RGN <> 1 then
    begin
      CombineRgn(AWindowRgn, AWindowRgn, Message.RGN, RGN_AND);
      DeleteObject(Message.RGN);
    end;
    Message.RGN := AWindowRgn;
    DefWndProc(Message);
    DeleteObject(AWindowRgn);
  end;
  Message.RGN := 1;
  Message.Result := 0;
end;

procedure TdxSkinFormController.WMPaint(var Message: TWMPaint);
begin
  ViewInfo.CalculateScrollArea;
  if ViewInfo.ScrollAreaElements <> [] then
    DrawWindowScrollArea;
end;

procedure TdxSkinFormController.WMPrint(var Message: TWMPrint);
begin
  if (Message.Flags and PRF_CHECKVISIBLE = 0) or IsWindowVisible(Handle) then
  begin
    if Message.Flags and PRF_NONCLIENT <> 0 then
      DrawWindowBorder(Message.DC);
  end;
end;

procedure TdxSkinFormController.WMSetText(var Message: TWMSetText);
begin
  DefWndProc(Message);
  ViewInfo.UpdateFormCaption;
  Refresh;
end;

procedure TdxSkinFormController.WMSize(var Message: TWMSize);
begin
  if ViewInfo.SizeType = SIZE_MAXIMIZED then
    PostRedraw;
  ViewInfo.SizeType := Message.SizeType;
end;

procedure TdxSkinFormController.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  if (Message.WindowPos^.flags and SWP_NOSIZE = 0) or
     (Message.WindowPos^.flags and SWP_NOMOVE = 0)
  then
  begin
    CalculateViewInfo;
    CheckWindowRgn;
  end;
end;

procedure TdxSkinFormController.WMSysCommand(var Message: TWMSysCommand);
var
  ACommand: Integer;
  ALink: TcxObjectLink;
begin
  ALink := cxAddObjectLink(Self);
  try
    RefreshOnSystemMenuShown;
    ACommand := Message.CmdType and $FFF0;
    if (ACommand = SC_KEYMENU) and (Message.Key = $20) then
    begin
      LockWindowUpdate(Handle);
      DefWndProc(Message);
      LockWindowUpdate(0);
    end
    else
      DefWndProc(Message);
    if Assigned(ALink.Ref) then
      DrawWindowBorder;
  finally
    cxRemoveObjectLink(ALink);
  end;
end;

procedure TdxSkinFormController.WMSysMenu(var Message: TMessage);
begin
  if IsWindowEnabled(Handle) then //B136020
  begin
    DoPopupSystemMenu(Form, Message.LParam);
    ShowSystemMenu(GetMouseCursorPos);
  end;
  Message.Result := 0;
end;

procedure TdxSkinFormController.MouseLeave;
begin
  UnlockRedraw;
  RefreshOnMouseEvent(True);
  UpdateWindow(Handle);
  LockRedraw;
end;

function TdxSkinFormController.GetForm: TCustomForm;
begin
  if SkinForm = nil then
    Result := TdxSkinFormHelper.GetForm(Handle)
  else
    Result := SkinForm;
end;

function TdxSkinFormController.GetIconHot: TdxSkinFormIconInfo;
begin
  Result := ViewInfo.IconInfoList.IconHot;
end;

function TdxSkinFormController.GetIconPressed: TdxSkinFormIconInfo;
begin
  Result := ViewInfo.IconInfoList.IconPressed;
end;

function TdxSkinFormController.GetIsSkinUsed: Boolean;
begin
  Result := inherited GetIsSkinUsed and (ViewInfo <> nil);
end;

procedure TdxSkinFormController.WndProc(var AMessage: TMessage);
begin
  case AMessage.Msg of
    WM_SETTEXT:
      WMSetText(TWMSetText(AMessage));
    WM_THEMECHANGED:
      ViewInfo.ThemeActiveAssigned := False;
    DXM_SKINS_POSTMSGFORMINIT:
      InitializeMessageForm;
  else
    if (dxWMSetSkinnedMessage > 0) and (AMessage.Msg = dxWMSetSkinnedMessage) then
    begin
      RefreshController;
      Refresh;
    end
    else
      if not IsSkinUsed then
        DefWndProc(AMessage)
      else
        if not HandleWindowMessage(AMessage) then
        begin
          BeforeWndProc(AMessage);
          DefWndProc(AMessage);
          AfterWndProc(AMessage);
        end;
  end;
end;

{ TdxSkinFormHelper }

class function TdxSkinFormHelper.CanUseSkin(AForm: TCustomForm): Boolean;
begin
  Result := Assigned(AForm) and (SendMessage(AForm.Handle, dxWMGetSkinnedMessage, 0, 0) = 0);
end;

class function TdxSkinFormHelper.GetActiveMDIChild(AHandle: HWND): TCustomForm;
var
  ACustomForm: TCustomFormAccess;
begin
  Result := nil;
  ACustomForm := TCustomFormAccess(GetForm(AHandle));
  if (ACustomForm <> nil) and (ACustomForm.FormStyle = fsMDIForm) then
    if ACustomForm.ActiveMDIChild <> nil then
      Result := ACustomForm.ActiveMDIChild;
end;

class function TdxSkinFormHelper.GetClientOffset(AHandle: HWND): Integer;
var
  ACustomForm: TCustomFormAccess;
begin
  ACustomForm := TCustomFormAccess(GetForm(AHandle));
  if ACustomForm = nil then
    Result := 0
  else
    Result := ACustomForm.BorderWidth;
end;

class function TdxSkinFormHelper.GetForm(AHandle: HWND): TCustomForm;
var
  AControl: TWinControl;
begin
  AControl := FindControl(AHandle);
  if AControl is TCustomForm then
    Result := TCustomForm(AControl)
  else
    Result := nil;
end;

class function TdxSkinFormHelper.GetZoomedMDIChild(AHandle: HWND): TCustomForm;
var
  AActiveChild: TCustomForm;
begin
  AActiveChild := GetActiveMDIChild(AHandle);
  if Assigned(AActiveChild) and IsZoomed(AActiveChild.Handle) then
    Result := AActiveChild
  else
    Result := nil;
end;

class function TdxSkinFormHelper.HasClientEdge(AHandle: HWND): Boolean;
begin
  Result := GetWindowLong(AHandle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE <> 0;
end;

class function TdxSkinFormHelper.IsAlphaBlendUsed(AHandle: HWND): Boolean;
begin
  Result := GetWindowLong(AHandle, GWL_EXSTYLE) and WS_EX_LAYERED <> 0;
  AHandle := GetParent(AHandle);
  if TdxSkinWinController.IsMDIClientWindow(AHandle) then
    Result := GetWindowLong(GetParent(AHandle), GWL_EXSTYLE) and WS_EX_LAYERED <> 0;
end;

{ TdxSkinFormIconInfo }

constructor TdxSkinFormIconInfo.Create(AType: TdxSkinFormIcon; AOwner: TdxSkinFormIconInfoList);
begin
  inherited Create;
  FOwner := AOwner;
  FIconType := AType;
end;

function TdxSkinFormIconInfo.CalculateState: TdxSkinElementState;
const
  PressedStateMap: array[Boolean] of TdxSkinElementState = (esHot, esPressed);
begin
  if not NonClientAreaInfo.Active then
    Result := esActiveDisabled
  else
    //#AI: Check Enabled state only for HotIcon, flicks under win2k otherwise
    if (Owner.IconHot = Self) and Enabled then
      Result := PressedStateMap[(Owner.IconPressed = Self) and NonClientAreaInfo.ButtonPressed]
    else
      Result := esNormal;
end;

function TdxSkinFormIconInfo.GetCommand: Integer;
const
  CommandMap: array[TdxSkinFormIcon] of Integer =
    (SC_DEFAULT, SC_CONTEXTHELP, SC_MINIMIZE, SC_MAXIMIZE, SC_RESTORE, SC_CLOSE);
begin
  Result := CommandMap[IconType];
end;

function TdxSkinFormIconInfo.GetEnabled: Boolean;
begin
  case IconType of
    sfiClose:
      Result := NonClientAreaInfo.GetIsMenuCommandEnabled(SC_CLOSE);
    sfiMinimize:
      Result := NonClientAreaInfo.Style and WS_MINIMIZEBOX = WS_MINIMIZEBOX;
    sfiMaximize:
      Result := NonClientAreaInfo.Style and WS_MAXIMIZEBOX = WS_MAXIMIZEBOX;
    else
      Result := True;
  end;
end;

function TdxSkinFormIconInfo.GetHitTest: Integer;
const
  HitTestMap: array[TdxSkinFormIcon] of Integer =
    (HTSYSMENU, HTHELP, HTMINBUTTON, HTMAXBUTTON, HTMAXBUTTON, HTCLOSE);
begin
  Result := HitTestMap[IconType];
end;

function TdxSkinFormIconInfo.GetNonClientAreaInfo: TdxSkinFormNonClientAreaInfo;
begin
  Result := Owner.NonClientAreaInfo;
end;

{ TdxSkinFormIconInfoList }

constructor TdxSkinFormIconInfoList.Create(ANonClientInfo: TdxSkinFormNonClientAreaInfo);
begin
  inherited Create;
  FNonClientAreaInfo := ANonClientInfo;
end;

function TdxSkinFormIconInfoList.Add(AIcon: TdxSkinFormIcon): TdxSkinFormIconInfo;
begin
  if not Find(AIcon, Result) then
  begin
    Result := TdxSkinFormIconInfo.Create(AIcon, Self);
    inherited Add(Result);
  end;
end;

function TdxSkinFormIconInfoList.CalculateStates(const P: TPoint): Boolean;
var
  AIconInfo: TdxSkinFormIconInfo;
  AState: TdxSkinElementState;
  I: Integer;
begin
  Result := False;
  FIconHot := HitTest(P);
  for I := 0 to Count - 1 do
  begin
    AIconInfo := Items[I];
    AState := AIconInfo.CalculateState;
    Result := Result or (AState <> AIconInfo.State);
    AIconInfo.State := AState;
  end;
end;

function TdxSkinFormIconInfoList.Find(
  AIcon: TdxSkinFormIcon; out AInfo: TdxSkinFormIconInfo): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
  begin
    Result := Items[I].IconType = AIcon;
    if Result then
    begin
      AInfo := Items[I];
      Break;
    end;
  end;
end;

function TdxSkinFormIconInfoList.HitTest(const P: TPoint): TdxSkinFormIconInfo;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
  begin
    if PtInRect(Items[I].HitBounds, P) then
    begin
      Result := Items[I];
      Break;
    end;
  end;
end;

function TdxSkinFormIconInfoList.HitTest(const P: TPoint; out AInfo: TdxSkinFormIconInfo): Boolean;
begin
  AInfo := HitTest(P);
  Result := Assigned(AInfo);
end;

procedure TdxSkinFormIconInfoList.Validate(const AIcons: TdxSkinFormIcons);
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
  begin
    if not (Items[I].IconType in AIcons) then
      FreeAndDelete(I);
  end;
end;

function TdxSkinFormIconInfoList.GetItem(Index: Integer): TdxSkinFormIconInfo;
begin
  Result := TdxSkinFormIconInfo(inherited Items[Index]);
end;

{ TdxSkinFormNonClientAreaInfo }

constructor TdxSkinFormNonClientAreaInfo.Create(AController: TdxSkinFormController);
begin
  FController := AController;
  FCaptionFont := TFont.Create;
  FTrackedScrollBar := saeSizeGrip;
  FIconInfoList := TdxSkinFormIconInfoList.Create(Self);
  UpdateFormCaption;
  FActive := True;
end;

destructor TdxSkinFormNonClientAreaInfo.Destroy;
begin
  DestroyStandardMenu;
  UpdateRgn := 0;
  FreeAndNil(FCaptionFont);
  FreeAndNil(FIconInfoList);
  inherited Destroy;
end;

procedure TdxSkinFormNonClientAreaInfo.Calculate(AUpdateRgn: HRGN);
begin
{$IFDEF DELPHI14}
  FNonClientMetrics.cbSize := TNonClientMetrics.SizeOf;
{$ELSE}
  FNonClientMetrics.cbSize := SizeOf(TNonClientMetrics);
{$ENDIF}
  SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @FNonClientMetrics, 0);
  FIsMDIChild := TdxSkinFormController.IsMDIChildWindow(Handle);
  FIsMDIClient := TdxSkinFormController.IsMDIClientWindow(Handle);
  FHasMenu := IsMenu(GetMenu(Handle)) and not FIsMDIChild;
  FPainter := Controller.LookAndFeelPainter;
  GetExtendedStylePainters.GetPainterData(Painter, FPainterInfo);
  CalculateFrameSizes;
  CalculateWindowInfo;
  CalculateFontInfo;
  CalculateBorderWidths;
  CalculateBordersInfo;
  CalculateCaptionIconsInfo;
  CalculateScrollArea;
end;

function TdxSkinFormNonClientAreaInfo.ClientToScreen(const P: TPoint): TPoint;
begin
  Result := cxPointOffset(P, WindowRect.TopLeft);
end;

function TdxSkinFormNonClientAreaInfo.ClientToScreen(const R: TRect): TRect;
begin
  Result := cxRectOffset(R, WindowRect.TopLeft);
end;

function TdxSkinFormNonClientAreaInfo.CreateDrawRgn: HRGN;
var
  ARgn: HRgn;
  ASide: TcxBorder;
  AItem: TdxScrollAreaElement;
begin
  Result := CreateRectRgnIndirect(cxNullRect);
  for ASide := Low(TcxBorder) to High(TcxBorder) do
  begin
    if cxRectIsEmpty(BorderBounds[ASide]) then Continue;
    ARgn := CreateRectRgnIndirect(ClientToScreen(BorderBounds[ASide]));
    CombineRgn(Result, Result, ARgn, RGN_OR);
    DeleteObject(ARgn);
  end;
  if IsMDIClient then
  begin
    ARgn := GetMDIClientDrawRgn;
    CombineRgn(Result, Result, ARgn, RGN_OR);
    DeleteObject(ARgn);
  end;
  if HasMenu then
  begin
    ARgn := CreateRectRgnIndirect(ClientToScreen(MenuSeparatorBounds));
    CombineRgn(Result, Result, ARgn, RGN_OR);
    DeleteObject(ARgn);
  end;
  for AItem := Low(TdxScrollAreaElement) to High(TdxScrollAreaElement) do
    if AItem in FScrollAreaElements then
    begin
      ARgn := CreateRectRgnIndirect(ClientToScreen(ScrollAreaBounds[AItem]));
      CombineRgn(Result, Result, ARgn, RGN_OR);
      DeleteObject(ARgn);
    end;
end;

function TdxSkinFormNonClientAreaInfo.GetHitTest(AHitPoint: TPoint; AHitTest: Integer = 0): Integer;
var
  ASide: TcxBorder;
  AIconInfo: TdxSkinFormIconInfo;
  ACorner: TdxSkinFormCorner;
begin
  Result := AHitTest;
  AHitPoint := ScreenToClient(AHitPoint);
  if IsSizebox and not IsZoomed then
  begin
    for ACorner := sfcLeftTop to sfcRightBottom do
      if (Result = HTNOWHERE) and PtInRect(SizeCorners[ACorner], AHitPoint) then
        Result := CornerHitTests[ACorner];
    for ASide := bLeft to bBottom do
      if (Result = HTNOWHERE) and PtInRect(SizeArea[ASide], AHitPoint) then
        Result := ResizeHitTests[ASide];
  end;
  if (Result = HTNOWHERE) and PtInRect(BorderBounds[bTop], AHitPoint) then
  begin
    if IconInfoList.HitTest(AHitPoint, AIconInfo) then
      Result := AIconInfo.HitTest
    else
      Result := HTCAPTION;
  end;
end;

function TdxSkinFormNonClientAreaInfo.GetScrollBarHitTest(
  var AScrollBar: TdxSkinFormScrollBar; var APart: TcxScrollBarPart): Boolean;
var
  APoint: TPoint;
  AItem: TdxSkinFormScrollBar;
  APartItem: TcxScrollBarPart; 
begin
  Result := False;
  APoint := ScreenToClient(GetMouseCursorPos);
  for AItem := saeHorzScroll to saeVertScroll do
  begin
    if not (AItem in ScrollAreaElements) or
      not PtInRect(ScrollAreaBounds[AItem], APoint) then Continue;
    AScrollBar := AItem;
    for APartItem := sbpLineUp to sbpPageDown do
    begin
      Result  := (ScrollBarPartState[AItem, APartItem] <> cxbsDefault) and
        PtInRect(ScrollBarPartBounds[AItem, APartItem], APoint);
      if Result then
      begin
        APart := APartItem;
        Exit;
      end; 
    end;
  end;
end;

function TdxSkinFormNonClientAreaInfo.ScreenToClient(const P: TSmallPoint): TPoint;
begin
  Result := ScreenToClient(SmallPointToPoint(P));
end;

function TdxSkinFormNonClientAreaInfo.ScreenToClient(const P: TPoint): TPoint;
begin
  Result := cxPointOffset(P, cxPointInvert(WindowRect.TopLeft));
end;

function TdxSkinFormNonClientAreaInfo.ScreenToClient(const R: TRect): TRect;
begin
  Result := cxRectOffset(R, cxPointInvert(WindowRect.TopLeft));
end;

procedure TdxSkinFormNonClientAreaInfo.CalculateBordersInfo;
var
  ASide: TcxBorder;
begin
  for ASide := Low(TcxBorder) to High(TcxBorder) do
    FBorderBounds[ASide] := GetBorderRect(ASide, WindowBounds, BorderWidths);
end;

procedure TdxSkinFormNonClientAreaInfo.CalculateBorderWidths;
begin
  FBorderWidths := cxNullRect;
  if IsIconic then
    FBorderWidths.Top := cxRectHeight(WindowBounds)
  else
  begin
    if HasBorder then
    begin
      FBorderWidths := PainterInfo.FormBorderWidths[not ToolWindow];
      if NativeBorderWidth then
      begin
        FBorderWidths.Left := Min(FBorderWidths.Left, SystemBorderWidths.Left);
        FBorderWidths.Right := Min(FBorderWidths.Right, SystemBorderWidths.Right);
        FBorderWidths.Bottom := Min(FBorderWidths.Bottom, SystemBorderWidths.Bottom);
      end;
    end;
    FBorderWidths.Top := CalculateCaptionHeight;
    if HasMenu then
    begin
      FMenuSeparatorBounds := cxRectContent(WindowBounds, BorderWidths);
      FMenuSeparatorBounds := cxRectSetHeight(FMenuSeparatorBounds, 1);
    end;
  end;
end;

function TdxSkinFormNonClientAreaInfo.CalculateCaptionButtonSize(
  const ACaptionRect: TRect; AElement: TdxSkinElement): TSize;

  function CalculateProportionalKoeff(AElement: TdxSkinElement): Single;
  var
    ASize: TSize;
  begin
    if Assigned(AElement) then
      ASize := AElement.MinSize.Size
    else
      ASize := cxNullSize;

    if ASize.cy > 0 then
      Result := ASize.cx / ASize.cy
    else
      Result := 1;
  end;

begin
  Result.cy := cxRectHeight(ACaptionRect);
  Result.cx := Round(Result.cy * CalculateProportionalKoeff(AElement));
  if Assigned(AElement) and (AElement.Image.Stretch = smNoResize) then
  begin
    Dec(Result.cx, Integer(Odd(Result.cx + AElement.Image.Size.cx)));
    Dec(Result.cy, Integer(Odd(Result.cy + AElement.Image.Size.cy)));
  end;
end;

function TdxSkinFormNonClientAreaInfo.CalculateCaptionHeight: Integer;
begin
  if not HasCaption then
    Result := 0
  else
    if NativeBorderWidth then
      Result := SystemBorderWidths.Top - WindowBounds.Top
    else
      Result := cxMarginsHeight(CaptionElement.ContentOffset.Rect) +
        Max(CalculateCaptionTextHeight, CalculateCaptionIconsHeight);
end;

function TdxSkinFormNonClientAreaInfo.CalculateCaptionIconsHeight: Integer;
var
  AElement: TdxSkinElement;
  AIcon: TdxSkinFormIcon;
  AIcons: TdxSkinFormIcons;
begin
  Result := 0;
  AIcons := Icons;
  for AIcon := Low(TdxSkinFormIcon) to High(TdxSkinFormIcon) do
  begin
    if AIcon in Icons then
    begin
      if AIcon = sfiMenu then
        Result := Max(Result, CalculateMenuIconSize(ToolWindow).cy)
      else
      begin
        AElement := PainterInfo.FormIcons[not ToolWindow, AIcon];
        if Assigned(AElement) then
          Result := Max(Result, AElement.MinSize.Height);
      end;
    end;
  end;
end;

function TdxSkinFormNonClientAreaInfo.CalculateCaptionTextHeight: Integer;
begin
  Result := cxTextHeight(FCaptionFont);
end;

function TdxSkinFormNonClientAreaInfo.CalculateMenuBarHeight: Integer;
var
  AMenu: HMENU;
  R: TRect;
begin
  Result := 0;
  AMenu := GetMenu(Handle);
  if (AMenu <> 0) and (GetMenuItemCount(AMenu) > 0) then
  begin
    GetMenuItemRect(Handle, AMenu, 0, R);
    Result := R.Top;
    GetMenuItemRect(Handle, AMenu, GetMenuItemCount(AMenu) - 1, R);
    Result := R.Bottom - Result;
  end;
end;

function TdxSkinFormNonClientAreaInfo.CalculateMenuIconSize(AToolWindow: Boolean): TSize;
var
  ASysIconSize: Integer;
begin
  if AToolWindow then
    ASysIconSize := GetSystemMetrics(SM_CYSMCAPTION) - 2 * GetSystemMetrics(SM_CYEDGE)
  else
    ASysIconSize := GetSystemMetrics(SM_CYSMICON);

  Result := cxSize(ASysIconSize, ASysIconSize);
end;

procedure TdxSkinFormNonClientAreaInfo.CalculateCaptionIconsInfo;

  function CalculateCaptionIconBounds(AIcon: TdxSkinFormIcon; var R: TRect): TRect;
  begin
    Result := R;
    if AIcon = sfiMenu then
    begin
      Result.Right := Result.Left + GetCaptionIconSize(AIcon).cx;
      R.Left := Result.Right;
    end
    else
    begin
      Result.Left := Result.Right - GetCaptionIconSize(AIcon).cx;
      R.Right := Result.Left - dxSkinIconSpacing;
    end;
  end;

  procedure AddCaptionIcon(AIcon: TdxSkinFormIcon; var R: TRect);
  var
    AInfo: TdxSkinFormIconInfo;
  begin
    if AIcon in Icons then
    begin
      AInfo := IconInfoList.Add(AIcon);
      AInfo.HitBounds := CalculateCaptionIconBounds(AIcon, R);
      AInfo.Bounds := cxRectCenter(AInfo.HitBounds, GetCaptionIconSize(AIcon));
      if IsZoomed then
      begin
        AInfo.FHitBounds.Top := Min(AInfo.HitBounds.Top, SystemSizeFrame.cy);
        if AIcon = sfiMenu then
          AInfo.FHitBounds.Left := Min(AInfo.HitBounds.Left, SystemSizeFrame.cx);
      end;
    end;
  end;

var
  R: TRect;
begin
  R := GetCaptionBounds;
  IconInfoList.Validate(Icons);
  // Don't change order
  AddCaptionIcon(sfiMenu, R);
  AddCaptionIcon(sfiClose, R);
  AddCaptionIcon(sfiMaximize, R);
  AddCaptionIcon(sfiRestore, R);
  AddCaptionIcon(sfiMinimize, R);
  AddCaptionIcon(sfiHelp, R);
  Dec(R.Right, dxSkinFormTextOffset);
  Inc(R.Left, GetCaptionContentOffset.Left);
  FCaptionTextBounds := cxRectCenter(R, cxRectWidth(R), CalculateCaptionTextHeight);
  UpdateCaptionIconStates;
end;

procedure TdxSkinFormNonClientAreaInfo.CalculateFontInfo;
begin
  if ToolWindow then
    FCaptionFont.Handle := CreateFontIndirect(NonClientMetrics.lfSmCaptionFont)
  else
  begin
    FCaptionFont.Handle := CreateFontIndirect(NonClientMetrics.lfCaptionFont);
    if PainterInfo <> nil then
      FCaptionFont.Size := FCaptionFont.Size + (PainterInfo.FormCaptionDelta - 1);
  end;
  FCaptionTextShadowColor := clBtnShadow;
  FCaptionTextColor[True] := GetSysColor(COLOR_CAPTIONTEXT);
  FCaptionTextColor[False] := GetSysColor(COLOR_INACTIVECAPTIONTEXT);
  if PainterInfo <> nil then
  begin
    FCaptionTextColor[True] := PainterInfo.FormFrames[True, bTop].TextColor;
    if PainterInfo.FormTextShadowColor <> nil then
      FCaptionTextShadowColor := PainterInfo.FormTextShadowColor.Value;
    if PainterInfo.FormInactiveColor <> nil then
      FCaptionTextColor[False] := PainterInfo.FormInactiveColor.Value
    else
      FCaptionTextColor[False] := FCaptionTextColor[True];
  end;
end;

procedure TdxSkinFormNonClientAreaInfo.CalculateFrameSizes;
begin
  if HasClientEdge then
    FClientEdgeSize := Size(GetSystemMetrics(SM_CXEDGE), GetSystemMetrics(SM_CYEDGE))
  else
    FClientEdgeSize := cxNullSize;

  if HasBorder then
    FSizeFrame := Size(
      PainterInfo.FormBorderWidths[not ToolWindow].Bottom,
      PainterInfo.FormBorderWidths[not ToolWindow].Right)
  else
    FSizeFrame := cxNullSize;

  FSupressed := NativeBorderWidth;
  if Supressed then
  begin
    FSizeFrame.cx := Min(SizeFrame.cx, SystemSizeFrame.cx);
    FSizeFrame.cy := Min(SizeFrame.cy, SystemSizeFrame.cy);
  end;
end;

function TdxSkinFormNonClientAreaInfo.CalculateMargins: TRect;
begin
  Result := BorderWidths;
  Inc(Result.Bottom, ClientOffset);
  Inc(Result.Left, ClientOffset);
  Inc(Result.Right, ClientOffset);
  Inc(Result.Top, ClientOffset);
  if saeVertScroll in ScrollAreaElements then
    Inc(Result.Right, GetSystemMetrics(SM_CXVSCROLL));
  if saeHorzScroll in ScrollAreaElements then
    Inc(Result.Bottom, GetSystemMetrics(SM_CYHSCROLL));
  if IsZoomed and IsSizebox then
  begin
    Inc(Result.Top, SystemSizeFrame.cy - SizeFrame.cy);
    Inc(Result.Left, SystemSizeFrame.cx - SizeFrame.cx);
    Inc(Result.Right, SystemSizeFrame.cx - SizeFrame.cx);
    Inc(Result.Bottom, SystemSizeFrame.cy - SizeFrame.cy);
  end;
end;

procedure TdxSkinFormNonClientAreaInfo.CalculateScrollArea;
const
  BothScrollBars = [saeHorzScroll, saeVertScroll];
begin
  FScrollAreaElements := [];
  FillChar(FScrollAreaBounds, SizeOf(FScrollAreaBounds), 0);
  if UsecxScrollBars then
  begin
    FScrollBarsInfo[saeHorzScroll] := InternalGetScrollBarInfo(saeHorzScroll);
    FScrollBarsInfo[saeVertScroll] := InternalGetScrollBarInfo(saeVertScroll);
    if Style and WS_HSCROLL = WS_HSCROLL then
    begin
      Include(FScrollAreaElements, saeHorzScroll);
      FScrollAreaBounds[saeHorzScroll] := cxRectSetTop(ClientBounds,
        ClientBounds.Bottom, GetSystemMetrics(SM_CYHSCROLL));
    end;
    if Style and WS_VSCROLL = WS_VSCROLL then
    begin
      Include(FScrollAreaElements, saeVertScroll);
      FScrollAreaBounds[saeVertScroll] := cxRectSetLeft(ClientBounds,
        ClientBounds.Right, GetSystemMetrics(SM_CXVSCROLL));
    end;
    if BothScrollBars * ScrollAreaElements = BothScrollBars then
    begin
      Include(FScrollAreaElements, saeSizeGrip);
      FScrollAreaBounds[saeHorzScroll].Right := FScrollAreaBounds[saeVertScroll].Left;
      FScrollAreaBounds[saeVertScroll].Bottom := FScrollAreaBounds[saeHorzScroll].Top;
      FScrollAreaBounds[saeSizeGrip] := cxRect(ClientBounds.BottomRight,
        Point(FScrollAreaBounds[saeVertScroll].Right, FScrollAreaBounds[saeHorzScroll].Bottom));
    end;
    CalculateScrollBarPartsInfo;
  end;
end;

procedure TdxSkinFormNonClientAreaInfo.CalculateScrollBarPartInfo(
  AScrollBar: TdxSkinFormScrollBar; Pos1, Pos2: Integer; APart: TcxScrollBarPart);
var
  P: TPoint;
  AState: Integer;
const
  Part2StateIndex: array[TcxScrollBarPart] of Integer = (0, 1, 5, 3, 2, 4);
begin
  AState := ScrollBarInfo[AScrollBar].rgState[Part2StateIndex[APart]];
  FScrollBarPartState[AScrollBar, APart] := cxbsDefault;
  if AState and STATE_SYSTEM_INVISIBLE = STATE_SYSTEM_INVISIBLE then Exit;
  FScrollBarPartState[AScrollBar, APart] := cxbsNormal;
  FScrollBarPartBounds[AScrollBar, APart] := ScrollAreaBounds[AScrollBar];
  P := ScreenToClient(GetMouseCursorPos);
  if (Pos1 <> Pos2) and (Pos1 <> -1) then
  begin
    if AScrollBar = saeHorzScroll then
      FScrollBarPartBounds[AScrollBar, APart] :=
        cxRectSetXPos(FScrollBarPartBounds[AScrollBar, APart], Pos1, Pos2)
    else
      FScrollBarPartBounds[AScrollBar, APart] :=
        cxRectSetYPos(FScrollBarPartBounds[AScrollBar, APart], Pos1, Pos2);
  end;
  if ((APart = sbpThumbnail) and (AScrollBar = TrackedScrollBar)) or
    (AState and STATE_SYSTEM_PRESSED = STATE_SYSTEM_PRESSED)
  then
    FScrollBarPartState[AScrollBar, APart] := cxbsPressed
  else
    if AState and STATE_SYSTEM_UNAVAILABLE = STATE_SYSTEM_UNAVAILABLE then
      FScrollBarPartState[AScrollBar, APart] := cxbsDisabled
    else
      if (AState and STATE_SYSTEM_HOTTRACKED = STATE_SYSTEM_HOTTRACKED) or
         PtInRect(FScrollBarPartBounds[AScrollBar, APart], P) then
      begin
        FScrollBarPartState[AScrollBar, APart] := cxbsHot;
        if ButtonPressed and PtInRect(FScrollBarPartBounds[AScrollBar, APart], P) then
          FScrollBarPartState[AScrollBar, APart] := cxbsPressed;
      end;
end;

procedure TdxSkinFormNonClientAreaInfo.CalculateScrollBarPartsInfo;
var
  R: TRect;
  AScrollBar: TdxSkinFormScrollBar;
begin
  for AScrollBar := saeHorzScroll to saeVertScroll do
  begin
    if not (AScrollBar in ScrollAreaElements) then Continue;
    R := ScrollAreaBounds[AScrollBar];
    if AScrollBar = saeVertScroll then
      R := cxRectSetXPos(R, R.Top, R.Bottom);
    with ScrollBarInfo[AScrollBar] do
    begin
      CalculateScrollBarPartInfo(AScrollBar, R.Left,
        R.Left + dxyLineButton, sbpLineUp);
      CalculateScrollBarPartInfo(AScrollBar, R.Right - dxyLineButton,
        R.Right, sbpLineDown);
      CalculateScrollBarPartInfo(AScrollBar, R.Left + xyThumbTop,
        R.Left + xyThumbBottom, sbpThumbnail);
      CalculateScrollBarPartInfo(AScrollBar, R.Left + dxyLineButton,
        R.Left + xyThumbTop, sbpPageUp);
      CalculateScrollBarPartInfo(AScrollBar, R.Left + xyThumbBottom,
        R.Right - dxyLineButton, sbpPageDown);
    end
  end;
end;

procedure TdxSkinFormNonClientAreaInfo.CalculateWindowInfo;
var
  APoint: TPoint;
begin
  APoint := cxNullPoint;
  FStyle := GetWindowLong(Handle, GWL_STYLE);
  FExStyle := GetWindowLong(Handle, GWL_EXSTYLE);
  FClientRect := cxGetClientRect(Handle);
  FWindowRect := cxGetWindowRect(Handle);
  Windows.ClientToScreen(Handle, APoint);
  OffsetRect(FClientRect, APoint.X, APoint.Y);
  FClientOffset := TdxSkinFormHelper.GetClientOffset(Handle);
  FClientBounds := cxRectOffset(ClientRect, WindowRect.TopLeft, False);
  FWindowBounds := cxRectOffset(WindowRect, WindowRect.TopLeft, False);
  if NativeBorderWidth then
    InflateRect(FWindowBounds,
      Min(0, SizeFrame.cx - SystemSizeFrame.cx),
      Min(0, SizeFrame.cy - SystemSizeFrame.cy));
  FSysMenuIcon := GetSysMenuIcon;
  FMenuBarHeight := CalculateMenuBarHeight;
end;

function TdxSkinFormNonClientAreaInfo.GetBorderRect(
  ASide: TcxBorder; const ABounds, AWidths: TRect): TRect;
begin
  Result := ABounds;
  case ASide of
    bLeft:
      Result.Right := Result.Left + AWidths.Left;
    bTop:
      Result.Bottom := Result.Top + AWidths.Top;
    bRight:
      Result.Left := Result.Right - AWidths.Right;
    bBottom:
      Result.Top := Result.Bottom - AWidths.Bottom;
  end;
end;

function TdxSkinFormNonClientAreaInfo.GetIcons: TdxSkinFormIcons;
const
  MaximizeMenuIcons: array[Boolean] of TdxSkinFormIcon = (sfiMaximize, sfiRestore);
  MimizeMenuIcons: array[Boolean] of TdxSkinFormIcon = (sfiMinimize, sfiRestore);
  SysMenuIcons: array[Boolean] of TdxSkinFormIcons =
    ([sfiMenu, sfiClose], [sfiClose]);
begin
  Result := [];
  if Style and WS_SYSMENU = WS_SYSMENU then
    Result := SysMenuIcons[ToolWindow or IsDialog];
  if Style and WS_MINIMIZEBOX = WS_MINIMIZEBOX then
    Include(Result, MimizeMenuIcons[IsIconic]);
  if Style and WS_MAXIMIZEBOX = WS_MAXIMIZEBOX then
    Include(Result, MaximizeMenuIcons[IsZoomed]);
  if IsDialog and (ExStyle and WS_EX_CONTEXTHELP = WS_EX_CONTEXTHELP) then
    Include(Result, sfiHelp);
end;

function TdxSkinFormNonClientAreaInfo.GetIsMenuCommandEnabled(AMenuCommandId: Integer): Boolean;
var
  AMenu: HMENU;
  AMenuItemInfo: TMenuItemInfo;
begin
  AMenu := GetSystemMenu(Handle, False);
  ZeroMemory(@AMenuItemInfo, SizeOf(AMenuItemInfo));
  AMenuItemInfo.cbSize := SizeOf(AMenuItemInfo);
  AMenuItemInfo.fMask := MIIM_STATE;
  if GetMenuItemInfo(AMenu, AMenuCommandId, False, AMenuItemInfo) then
    Result := AMenuItemInfo.fState and MF_GRAYED = 0
  else
    Result := True;
end;

function TdxSkinFormNonClientAreaInfo.GetMDIClientDrawRgn: HRGN;
var
  ARgn: HRGN;
  R: TRect;
begin
  R := WindowRect;
  Result := CreateRectRgnIndirect(R);
  InflateRect(R, -ClientEdgeSize.cx, -ClientEdgeSize.cy);
  ARgn := CreateRectRgnIndirect(R);
  CombineRgn(Result, Result, ARgn, RGN_XOR);
  DeleteObject(ARgn);   
end;

function TdxSkinFormNonClientAreaInfo.GetSysMenuIcon: HIcon;
var
  wParam: Integer;
begin
  wParam := Byte(not ToolWindow);
  if IsWinXPOrLater then
    wParam := ICON_SMALL2;
  Result := DefWindowProc(Handle, WM_GETICON, wParam, 0);
end;

function TdxSkinFormNonClientAreaInfo.InternalGetScrollBarInfo(
  AScrollBar: TdxSkinFormScrollBar): TScrollBarInfo;
const
  ScrollBarOBJIDs: array[Boolean] of DWORD = (OBJID_HSCROLL, OBJID_VSCROLL);
var
  AScrollInfo: TScrollInfo; 
begin
  FillChar(Result, SizeOf(TScrollBarInfo), 0);
  if AScrollBar <> saeSizeGrip then
  begin
    Result.cbSize := SizeOf(TScrollBarInfo);
    if TrackedScrollBar <> AScrollBar then
      cxGetScrollBarInfo(Handle, Integer(ScrollBarOBJIDs[AScrollBar = saeVertScroll]), Result)
    else
    begin
      FillChar(AScrollInfo, SizeOf(AScrollInfo), 0);
      AScrollInfo.cbSize := SizeOf(AScrollInfo);
      AScrollInfo.fMask := SIF_TRACKPOS or SIF_POS;
      GetScrollInfo(Handle, Integer(AScrollBar), AScrollInfo);
      Controller.LockRedraw;
      try
        SetScrollPos(Handle, Integer(AScrollBar), AScrollInfo.nTrackPos, False);
        cxGetScrollBarInfo(Handle, Integer(ScrollBarOBJIDs[AScrollBar = saeVertScroll]), Result);
        SetScrollPos(Handle, Integer(AScrollBar), AScrollInfo.nPos, False);
      finally
        Controller.UnlockRedraw;
      end;
    end;
  end;
end;

procedure TdxSkinFormNonClientAreaInfo.BuildSystemMenu(ASysMenu: THandle);
begin
  LoadStandardMenu;
  DeleteMenu(ASysMenu, 0, MF_BYPOSITION);
  cxMoveMenuItems(GetSubMenu(SystemMenu, 0), ASysMenu);
  ModifySystemMenu(ASysMenu);
end;

procedure TdxSkinFormNonClientAreaInfo.DestroyStandardMenu;
begin
  if FSystemMenu <> 0 then
  begin
    DestroyMenu(FSystemMenu);
    FSystemMenu := 0;
  end;
end;

procedure TdxSkinFormNonClientAreaInfo.LoadStandardMenu;
const
  SysMenuTypes: array[Boolean] of TcxSystemMenuType = (smSystem, smChild);
begin
  DestroyStandardMenu;
  FSystemMenu := cxLoadSysMenu(SysMenuTypes[IsMDIChild]);
end;

procedure TdxSkinFormNonClientAreaInfo.ModifySystemMenu(ASysMenu: THandle);
var
  ABorderIcons: TBorderIcons;
begin
  if HasBorder then
  begin
    ABorderIcons := [];
    if Style and WS_SYSMENU <> 0 then
      Include(ABorderIcons, biSystemMenu);
    if Style and WS_MAXIMIZEBOX <> 0 then
      Include(ABorderIcons, biMaximize);
    if Style and WS_MINIMIZEBOX <> 0 then
      Include(ABorderIcons, biMinimize);
    if ExStyle and WS_EX_CONTEXTHELP <> 0 then
      Include(ABorderIcons, biHelp);
    cxModifySystemMenu(ASysMenu, Handle, IsDialog, ABorderIcons, WindowState);
  end;
end;

procedure TdxSkinFormNonClientAreaInfo.ResetSystemMenu;
begin
  GetSystemMenu(Handle, True); // Win2k redrawing bug
  if IsMDIChild then // #AI: for correct mdi buttons drawing on main menu bar
    BuildSystemMenu(GetSystemMenu(Handle, False));
end;

procedure TdxSkinFormNonClientAreaInfo.UpdateCaption(const ANewText: string);
begin
  FCaption := ANewText;
  if IsMDIChild then
    SkinHelper.ChildChanged(Handle);
end;

function TdxSkinFormNonClientAreaInfo.UpdateCaptionIconStates: Boolean;
begin
  Result := IconInfoList.CalculateStates(ScreenToClient(GetMouseCursorPos));
end;

procedure TdxSkinFormNonClientAreaInfo.MousePressed(APressed: Boolean);
begin
  //todo: refactor
  if not (APressed and IconInfoList.HitTest(ScreenToClient(GetMouseCursorPos), IconInfoList.FIconPressed)) then
    IconInfoList.FIconPressed := nil;
end;

function TdxSkinFormNonClientAreaInfo.GetContentRect: TRect;
begin
  Result := cxRectContent(WindowBounds, BorderWidths);
end;

function TdxSkinFormNonClientAreaInfo.GetBorderBounds(ASide: TcxBorder): TRect;
begin
  Result := FBorderBounds[ASide];
end;

function TdxSkinFormNonClientAreaInfo.GetButtonPressed: Boolean;
begin
  Result := GetMouseKeys and MK_LBUTTON = MK_LBUTTON;
end;

function TdxSkinFormNonClientAreaInfo.GetCaptionBounds: TRect;
begin
  Result := GetCaptionContentOffset;
  Result.Left := SkinBorderWidth[bLeft];
  Result := cxRectContent(BorderBounds[bTop], Result);
  Inc(Result.Top, Byte(ToolWindow));
end;

function TdxSkinFormNonClientAreaInfo.GetCaptionContentOffset: TRect;
begin
  if CaptionElement = nil then
    Result := cxNullRect
  else
    Result := CaptionElement.ContentOffset.Rect;

  if Assigned(CaptionElement) and Supressed and HasCaption then
  begin
    Result.Top := Trunc(Result.Top / SuppressFactor);
    Result.Bottom := Trunc(Result.Bottom / SuppressFactor);
    Result.Left := Trunc(Result.Left / SuppressFactor);
    Result.Right := Trunc(Result.Right / SuppressFactor);
  end;

  if IsZoomed then
  begin
    Result.Left := Max(Result.Left, SizeFrame.cx);
    Result.Right := Max(Result.Right, SizeFrame.cx);
    Result.Top := Max(Result.Top, SizeFrame.cy);
  end;
end;

function TdxSkinFormNonClientAreaInfo.GetCaptionElement: TdxSkinElement;
begin
  Result := PainterInfo.FormFrames[not ToolWindow, bTop];
end;

function TdxSkinFormNonClientAreaInfo.GetCaptionIconSize(AIcon: TdxSkinFormIcon): TSize;
begin
  if AIcon = sfiMenu then
    Result := CalculateMenuIconSize(ToolWindow)
  else
    Result := CalculateCaptionButtonSize(GetCaptionBounds,
      PainterInfo.FormIcons[not ToolWindow, AIcon]);
end;

function TdxSkinFormNonClientAreaInfo.GetCaptionTextColor: TColor;
begin
  Result := FCaptionTextColor[Active];
end;

function TdxSkinFormNonClientAreaInfo.GetHandle: HWND;
begin
  Result := Controller.Handle;
end;

function TdxSkinFormNonClientAreaInfo.GetClientRectOnClient: TRect;
begin
  Result := cxRectOffset(ClientRect, cxPointInvert(ClientRect.TopLeft));
end; 

function TdxSkinFormNonClientAreaInfo.GetHasBorder: Boolean;
begin
  Result := Style and WS_BORDER = WS_BORDER;
end;

function TdxSkinFormNonClientAreaInfo.GetHasCaption: Boolean;
begin
  Result := Style and WS_CAPTION = WS_CAPTION;
end;

function TdxSkinFormNonClientAreaInfo.GetHasCaptionTextShadow: Boolean;
begin
  Result := Active and not ToolWindow and (CaptionTextShadowColor <> clNone) and
    (CaptionTextShadowColor <> clDefault);
end;

function TdxSkinFormNonClientAreaInfo.GetHasClientEdge: Boolean;
begin
  Result := TdxSkinFormHelper.HasClientEdge(Handle);
end;

function TdxSkinFormNonClientAreaInfo.GetHasMenu: Boolean;
begin
  Result := FHasMenu;
end;

function TdxSkinFormNonClientAreaInfo.GetHasParent: Boolean;
begin
  Result := GetParent(Handle) <> 0;
end;

function TdxSkinFormNonClientAreaInfo.GetHasSizeConstraints: Boolean;
begin
  Result := False;
  if Assigned(Controller.Form) then
  begin
    with Controller.Form.Constraints do
      Result := (MinHeight <> 0) or (MinWidth <> 0) or (MaxHeight <> 0) or (MaxWidth <> 0);
  end;
end;

function TdxSkinFormNonClientAreaInfo.GetIsAlphaBlendUsed: Boolean;
begin
  Result := TdxSkinFormHelper.IsAlphaBlendUsed(Handle);
end;

function TdxSkinFormNonClientAreaInfo.GetIsChild: Boolean;
begin
  Result := Style and WS_CHILD = WS_CHILD;
end;

function TdxSkinFormNonClientAreaInfo.GetIsDialog: Boolean;
begin
  Result := ExStyle and WS_EX_DLGMODALFRAME = WS_EX_DLGMODALFRAME;
end;

function TdxSkinFormNonClientAreaInfo.GetIsIconic: Boolean;
begin
  Result := Style and WS_ICONIC = WS_ICONIC;
end;

function TdxSkinFormNonClientAreaInfo.GetIsSizeBox: Boolean;
begin
  Result := Style and WS_SIZEBOX = WS_SIZEBOX;
end;

function TdxSkinFormNonClientAreaInfo.GetIsZoomed: Boolean;
begin
  Result := Style and WS_MAXIMIZE = WS_MAXIMIZE;
end;

function TdxSkinFormNonClientAreaInfo.GetNativeBorderWidth: Boolean;
begin
  Result := IsZoomed or FHasMenu or FIsMDIClient or not ThemeActive;
end;

function TdxSkinFormNonClientAreaInfo.GetNeedCheckNonClientSize: Boolean;
begin
  Result := HasBorder and not (NativeBorderWidth or
    IsZoomed and TdxSkinFormController.IsMDIChildWindow(Handle));
end;

function TdxSkinFormNonClientAreaInfo.GetScreenRect: TRect;
var
  AMonitor: TMonitor;
begin
  AMonitor := Screen.MonitorFromWindow(Handle);
  if AMonitor = nil then
    Result := Screen.DesktopRect
  else
    Result := AMonitor.BoundsRect;
end;

function TdxSkinFormNonClientAreaInfo.GetScrollAreaBounds(
  AItem: TdxScrollAreaElement): TRect;
begin
  Result := FScrollAreaBounds[AItem];
end;

function TdxSkinFormNonClientAreaInfo.GetScrollBarInfo(
  AScrollBar: TdxSkinFormScrollBar): TScrollBarInfo;
begin
  Result := FScrollBarsInfo[AScrollBar];
end;

function TdxSkinFormNonClientAreaInfo.GetScrollBarPartBounds(
  AScrollBar: TdxSkinFormScrollBar; APart: TcxScrollBarPart): TRect;
begin
  Result := FScrollBarPartBounds[AScrollBar, APart];
end;

function TdxSkinFormNonClientAreaInfo.GetScrollBarPartState(
  AScrollBar: TdxSkinFormScrollBar; APart: TcxScrollBarPart): TcxButtonState;
begin
  Result := FScrollBarPartState[AScrollBar, APart];
end;

function TdxSkinFormNonClientAreaInfo.GetSizeArea(ASide: TcxBorder): TRect;
begin
  Result := WindowBounds;
  if ASide in [bLeft, bRight] then
    Inc(Result.Top, BorderWidths.Top);
  with SizeFrame do
    Result := GetBorderRect(ASide, Result, Rect(cx, cy, cx, cy));
end;

function TdxSkinFormNonClientAreaInfo.GetSizeCorners(
  ACorner: TdxSkinFormCorner): TRect;
var
  ASize: TSize; 
begin
  Result := WindowBounds;
  ASize := SizeFrame;
  if ACorner in [sfcLeftTop, sfcLeftBottom] then
    Result.Right := Result.Left + ASize.cx
  else
    Result.Left := Result.Right - ASize.cx;
  if ACorner in [sfcLeftTop, sfcRightTop] then
    Result.Bottom := Result.Top + BorderWidths.Top
  else
    Result.Top := Result.Bottom - ASize.cy;
end;

function TdxSkinFormNonClientAreaInfo.GetSkinBorderWidth(ASide: TcxBorder): Integer;
var
  AElement: TdxSkinElement;
begin
  Result := 0;
  AElement := PainterInfo.FormFrames[not ToolWindow, ASide];
  if Assigned(AElement) then
  begin
    if ASide in [bLeft, bRight] then
      Result := Max(AElement.Size.cx, AElement.MinSize.Width)
    else
      Result := Max(AElement.Size.cy, AElement.MinSize.Height);
  end;
end;

function TdxSkinFormNonClientAreaInfo.GetSuppressFactor: Single;
var
  ACaptionElement: TdxSkinElement;
  ACaptionHeight: Integer;
begin
  ACaptionHeight := CalculateCaptionHeight;
  ACaptionElement := PainterInfo.FormFrames[not ToolWindow, bTop];
  if not Supressed or (ACaptionElement = nil) or
    (ACaptionHeight = 0) or ACaptionElement.Image.Empty
  then
    Result := 1
  else
    Result := ACaptionElement.Size.cy / ACaptionHeight;
end;

function TdxSkinFormNonClientAreaInfo.GetSystemBorderWidths: TRect;
var
  AFrameSize: Integer;
begin
  AFrameSize := ClientRect.Left - WindowRect.Left - ClientOffset;
  Result := Rect(AFrameSize, 0, AFrameSize, AFrameSize);
  Result.Top := ClientRect.Top - WindowRect.Top - ClientOffset;
  if HasMenu and (MenuBarHeight > 0) then
    Dec(Result.Top, MenuBarHeight + ClientEdgeSize.cy);
end;

function TdxSkinFormNonClientAreaInfo.GetSystemSizeFrame: TSize;
begin
  Result := cxNullSize;
  if HasBorder then
  begin
    Result := cxSize(GetSystemMetrics(SM_CXSIZEFRAME), GetSystemMetrics(SM_CYSIZEFRAME));
    if not IsSizeBox then
    begin
      Dec(Result.cx, NonClientMetrics.iBorderWidth);
      Dec(Result.cy, NonClientMetrics.iBorderWidth);
    end;
  end;
end;

function TdxSkinFormNonClientAreaInfo.GetThemeActive: Boolean;
begin
  if not ThemeActiveAssigned then
  begin
    FThemeActive := IsThemeActive;
    ThemeActiveAssigned := True;
  end;
  Result := FThemeActive;
end;

function TdxSkinFormNonClientAreaInfo.GetToolWindow: Boolean;
begin
  Result := ExStyle and WS_EX_TOOLWINDOW = WS_EX_TOOLWINDOW;
end;

function TdxSkinFormNonClientAreaInfo.GetWindowState: TWindowState;
begin
  Result := wsNormal;
  if IsZoomed then
    Result := wsMaximized;
  if IsIconic then
    Result := wsMinimized;
end;

procedure TdxSkinFormNonClientAreaInfo.SetActive(AActive: Boolean);
begin
  if FActive <> AActive then
  begin
    FActive := AActive;
    UpdateCaptionIconStates;
  end;
end;

procedure TdxSkinFormNonClientAreaInfo.SetSizeType(AValue: Integer);
begin
  if AValue <> FSizeType then
  begin
    if IsMDIChild and (SizeType = SIZE_MAXIMIZED) then
      ResetSystemMenu;
    FSizeType := AValue;
  end;
end;

procedure TdxSkinFormNonClientAreaInfo.SetUpdateRgn(ARgn: HRGN);
begin
  if FUpdateRgn <> 0 then
    DeleteObject(FUpdateRgn);
  FUpdateRgn := ARgn;
  if FUpdateRgn <> 0 then
    OffsetRgn(FUpdateRgn, -WindowRect.Left, -WindowRect.Top);
end;

procedure TdxSkinFormNonClientAreaInfo.UpdateFormCaption;
begin
  UpdateCaption(GetWindowCaption(Handle));
end;

{ TdxSkinFormPainter }

constructor TdxSkinFormPainter.Create(AViewInfo: TdxSkinFormNonClientAreaInfo);
begin
  FViewInfo := AViewInfo;
  FBaseCanvas := TCanvas.Create;
  FCanvas := TcxCanvas.Create(FBaseCanvas);
  CreateCacheInfos;
end;

destructor TdxSkinFormPainter.Destroy;
begin
  FreeCacheInfos;
  FCanvas.Free;
  FBaseCanvas.Free;
  inherited Destroy;
end;

procedure TdxSkinFormPainter.CreateCacheInfos;
var
  AIcon: TdxSkinFormIcon;
  ASide: TcxBorder;
begin
  for ASide := Low(TcxBorder) to High(TcxBorder) do
    FBordersCache[ASide] := TdxSkinElementCache.Create;
  for AIcon := Low(TdxSkinFormIcon) to High(TdxSkinFormIcon) do
    FIconsCache[AIcon] := TdxSkinElementCache.Create;
  FBackgroundCache := TdxSkinElementCache.Create;
end;

procedure TdxSkinFormPainter.FreeCacheInfos;
var
  AIcon: TdxSkinFormIcon;
  ASide: TcxBorder;
begin
  for ASide := Low(TcxBorder) to High(TcxBorder) do
    FreeAndNil(FBordersCache[ASide]);
  for AIcon := Low(TdxSkinFormIcon) to High(TdxSkinFormIcon) do
    FreeAndNil(FIconsCache[AIcon]);
  FreeAndNil(FBackgroundCache);
end;

procedure TdxSkinFormPainter.BeginPaint(ADestDC: HDC = 0);
const
  Flags = DCX_CACHE or DCX_CLIPSIBLINGS or DCX_WINDOW or DCX_VALIDATE;
begin
  FPainter := ViewInfo.Painter;
  FPainterInfo := ViewInfo.PainterInfo;
  FDC := ADestDC;
  FNeedRelease := ADestDC = 0;
  if FNeedRelease then
    FDC := GetDCEx(ViewInfo.Handle, 0, Flags);
  FBaseCanvas.Handle := FDC;
end;

procedure TdxSkinFormPainter.DrawClientOffsetArea;
var
  R: TRect;
begin
  if (ViewInfo.ClientOffset > 0) and not ViewInfo.IsIconic then
  begin
    Canvas.SaveClipRegion;
    try
      R := ViewInfo.ContentRect;
      InflateRect(R, -ViewInfo.ClientOffset, -ViewInfo.ClientOffset);
      Canvas.ExcludeClipRect(R);
      DrawBackground(Canvas.Handle, ViewInfo.ContentRect);
    finally
      Canvas.RestoreClipRegion;
    end;
  end;
end;

procedure TdxSkinFormPainter.DrawMDIClientEdgeArea;
begin
  if ViewInfo.IsMDIClient and ViewInfo.HasClientEdge then
  begin
    Canvas.SaveClipRegion;
    try
      Canvas.ExcludeClipRect(cxRectInflate(ViewInfo.WindowBounds,
        -ViewInfo.ClientEdgeSize.cx, -ViewInfo.ClientEdgeSize.cy));
      FormContent.Draw(Canvas.Handle, ViewInfo.WindowBounds);
    finally
      Canvas.RestoreClipRegion;
    end;
  end;
end;

procedure TdxSkinFormPainter.DrawMenuSeparator;
begin
  if ViewInfo.HasMenu and not ViewInfo.IsIconic then
    FillRect(Canvas.Handle, ViewInfo.MenuSeparatorBounds, GetSysColorBrush(COLOR_MENU));
end;

procedure TdxSkinFormPainter.DrawWindowBackground;
var
  R: TRect;
begin
  if PainterInfo <> nil then
  begin
    Canvas.SaveState;
    try
      R := cxRectOffset(ViewInfo.ClientRect,
        cxPointInvert(ViewInfo.WindowRect.TopLeft));
      MoveWindowOrg(Canvas.Handle, -R.Left, -R.Top);
      DrawBackground(Canvas.Handle, R);
    finally
      Canvas.RestoreState;
    end;
  end;
end;

procedure TdxSkinFormPainter.DrawWindowBorder;
begin
  DrawMDIClientEdgeArea;
  DrawClientOffsetArea;
  InternalDrawCaption(ViewInfo.BorderBounds[bTop],
    PainterInfo.FormFrames[not ViewInfo.ToolWindow, bTop]);
  InternalDrawBorders;
  DrawMenuSeparator;
  DrawWindowScrollArea;
end;

procedure TdxSkinFormPainter.DrawWindowScrollArea;
begin
  if not ViewInfo.IsIconic and (ViewInfo.ScrollAreaElements <> []) then
    DrawScrollAreaElements(Canvas.Handle);
end;

procedure TdxSkinFormPainter.EndPaint;
begin
  if FNeedRelease then
    ReleaseDC(ViewInfo.Handle, FDC);
  FBaseCanvas.Handle := 0;
end;

procedure TdxSkinFormPainter.DrawBackground(DC: HDC; const R: TRect);

  function DoIntersectClipRect(const R: TRect): Boolean;
  begin
    Result := IntersectClipRect(DC, R.Left, R.Top, R.Right, R.Bottom) <> NULLREGION;
  end;

var
  ASavedIndex: Integer;
begin
  ASavedIndex := SaveDC(DC);
  try
    if DoIntersectClipRect(ViewInfo.ContentRect) and DoIntersectClipRect(R) then
    begin
      if FormContent.Image.Empty then
        FormContent.Draw(DC, ViewInfo.ContentRect)
      else
        FBackgroundCache.DrawEx(DC, FormContent, ViewInfo.ContentRect);
    end;
  finally
    RestoreDC(DC, ASavedIndex);
  end;
end;

procedure TdxSkinFormPainter.DrawCaptionText(DC: HDC; R: TRect; const AText: string);
begin
{$IFDEF DELPHI12}
  cxDrawText(DC, AText, R, CaptionFlags);
{$ELSE}
  if not IsWinNT then
    cxDrawText(DC, AText, R, CaptionFlags)
  else
    DrawTextW(DC, PWideChar(dxStringToWideString(AText)), -1, R, CaptionFlags);
{$ENDIF}
end;

procedure TdxSkinFormPainter.DrawScrollAreaElements(DC: HDC);
var
  AElement: TdxScrollAreaElement;
begin
  for AElement := Low(TdxScrollAreaElement) to High(TdxScrollAreaElement) do
  begin
    if AElement in ViewInfo.ScrollAreaElements then
    begin
      if AElement = saeSizeGrip then
        DrawSizeGrip(DC, ViewInfo.ScrollAreaBounds[AElement])
      else
        DrawScrollBar(DC, AElement, ViewInfo.ScrollAreaBounds[AElement]);
    end;
  end;
end;

procedure TdxSkinFormPainter.DrawScrollBar(
  DC: HDC; AScrollBar: TdxSkinFormScrollBar; const R: TRect);
var
  AMemBitmap: HBITMAP;
  AMemDC: HDC;
  APart: TcxScrollBarPart;
begin
  AMemDC := CreateCompatibleDC(0);
  try
    SelectDC(AMemDC);
    AMemBitmap := CreateCompatibleBitmap(DC, cxRectWidth(R), cxRectHeight(R));
    AMemBitmap := SelectObject(AMemDC, AMemBitmap);
    SetWindowOrgEx(AMemDC, R.Left, R.Top, nil);
    DrawBackground(Canvas.Handle, R);
    Painter.DrawScrollBarBackground(Canvas, R, AScrollBar = saeHorzScroll);
    for APart := Low(TcxScrollBarPart) to High(TcxScrollBarPart) do
      with ViewInfo do
      begin
        if ScrollBarPartState[AScrollBar, APart] = cxbsDefault then Continue;
        Painter.DrawScrollBarPart(Canvas, AScrollBar = saeHorzScroll,
          ScrollBarPartBounds[AScrollBar, APart], APart, ScrollBarPartState[AScrollBar, APart]);
      end;
    cxBitBlt(DC, AMemDC, R, R.TopLeft, SRCCOPY);
    AMemBitmap := SelectObject(AMemDC, AMemBitmap);
    DeleteObject(AMemBitmap);
  finally
    DeleteDC(AMemDC)
  end;
end;

procedure TdxSkinFormPainter.DrawSizeGrip(DC: HDC; const R: TRect);
begin
  DrawBackground(DC, R);
  Painter.DrawSizeGrip(Canvas, R, clNone);
end;

procedure TdxSkinFormPainter.DrawWindowCaption(
  DC: HDC; const R: TRect; AElement: TdxSkinElement);
var
  I: Integer;
begin
  DrawWindowCaptionBackground(DC, R, AElement);
  DrawWindowCaptionText(DC, ViewInfo.CaptionTextBounds);
  for I := 0 to ViewInfo.IconInfoList.Count - 1 do
    DrawWindowIcon(DC, ViewInfo.IconInfoList[I]);
end;

procedure TdxSkinFormPainter.DrawWindowCaptionBackground(DC: HDC;
  const R: TRect; AElement: TdxSkinElement);
var
  R1: TRect;
begin
  R1 := R;
  if ViewInfo.IsIconic then
  begin
    InternalDrawBorder(DC, R1, bBottom, ViewInfo.IsAlphaBlendUsed);
    Dec(R1.Bottom);
  end;
  FBordersCache[bTop].DrawEx(DC, dxSkinCheckSkinElement(AElement), R1,
    FrameStates[ViewInfo.Active]);
end;

procedure TdxSkinFormPainter.DrawWindowCaptionText(DC: HDC; R: TRect);
var
  APrevColor: TColor;
  APrevFont: HFONT;
  APrevTransparent: Integer;
begin
  if Length(ViewInfo.Caption) > 0 then
  begin
    APrevFont := SelectObject(DC, ViewInfo.CaptionFont.Handle);
    APrevTransparent := SetBkMode(DC, Transparent);
    if ViewInfo.HasCaptionTextShadow then
    begin
      APrevColor := SetTextColor(DC, ColorToRGB(ViewInfo.CaptionTextShadowColor));
      cxDrawText(DC, ViewInfo.Caption, R, CaptionFlags);
      SetTextColor(DC, APrevColor);
    end;
    OffsetRect(R, -1, -1);
    APrevColor := SetTextColor(DC, ColorToRGB(ViewInfo.CaptionTextColor));
    DrawCaptionText(DC, R, ViewInfo.Caption);
    SetBkMode(DC, APrevTransparent);
    SelectObject(DC, APrevFont);
    SetTextColor(DC, APrevColor);
  end;
end;

procedure TdxSkinFormPainter.DrawWindowIcon(DC: HDC; AIconInfo: TdxSkinFormIconInfo);
begin
  DrawWindowIcon(DC, AIconInfo.Bounds, AIconInfo.IconType,
    PainterInfo.FormIcons[not ViewInfo.ToolWindow, AIconInfo.IconType],
    AIconInfo.State);
end;

procedure TdxSkinFormPainter.DrawWindowIcon(DC: HDC; const R: TRect;
  AIcon: TdxSkinFormIcon; AElement: TdxSkinElement; AElementState: TdxSkinElementState);
begin
  if ((AIcon = sfiMenu) and (ViewInfo.SysMenuIcon = 0)) or
    ((AIcon <> sfiMenu) and (AElement = nil)) then Exit;

  if RectVisible(DC, R) then
  begin
    if AElement = nil then
      DrawIconEx(DC, R.Left, R.Top, ViewInfo.SysMenuIcon,
        R.Right - R.Left, R.Bottom - R.Top, 0, 0, DI_NORMAL)
    else
    begin
      FIconsCache[AIcon].CheckCacheState(AElement, R, AElementState, 0);
      FIconsCache[AIcon].Draw(DC, R);
    end;
  end;
end;

procedure TdxSkinFormPainter.FlushCache;
var
  AIcon: TdxSkinFormIcon;
  ASide: TcxBorder;
begin
  for ASide := Low(TcxBorder) to High(TcxBorder) do
    FBordersCache[ASide].Flush;
  for AIcon := Low(TdxSkinFormIcon) to High(TdxSkinFormIcon) do
    FIconsCache[AIcon].Flush;
  FBackgroundCache.Flush;
end;

procedure TdxSkinFormPainter.InternalDrawBorder(DC: HDC; const R: TRect;
  ASide: TcxBorder; AFillBackground: Boolean);

  function GetBorderRect(const R: TRect): TRect;
  begin
    Result := R;
    if IsBordersThin then
      case ASide of
        bLeft:
          Result.Right := Result.Left + ViewInfo.GetSkinBorderWidth(ASide);
        bRight:
          Result.Left := Result.Right - ViewInfo.GetSkinBorderWidth(ASide);
        bBottom:
          Result.Top := Result.Bottom - ViewInfo.GetSkinBorderWidth(ASide);
      end;
  end;

  procedure DrawBorderElement(DC: HDC; const R: TRect);
  begin
    FBordersCache[ASide].DrawEx(DC,
      PainterInfo.FormFrames[not ViewInfo.ToolWindow, ASide], R,
      FrameStates[Active]);
  end;

var
  ACachedDC: HDC;
  AMemBmp: HBitmap;
  R1: TRect;
begin
  if not AFillBackground then
    DrawBorderElement(DC, R)
  else
  begin
    R1 := R;
    OffsetRect(R1, -R1.Left, -R1.Top);
    ACachedDC := CreateCompatibleDC(Canvas.Handle);
    AMemBmp := CreateCompatibleBitmap(Canvas.Handle, R1.Right, R1.Bottom);
    AMemBmp := SelectObject(ACachedDC, AMemBmp);
    FormContent.Draw(ACachedDC, R1, 0, FrameStates[Active]);
    DrawBorderElement(ACachedDC, GetBorderRect(R1));
    BitBlt(DC, R.Left, R.Top, R1.Right, R1.Bottom, ACachedDC, 0, 0, SRCCOPY);
    AMemBMP := SelectObject(ACachedDC, AMemBmp);
    DeleteObject(AMemBmp);
    DeleteDC(ACachedDC);
  end;
end;

procedure TdxSkinFormPainter.InternalDrawBorders;
var
  AIsAlphaBlendUsed: Boolean;
  ASide: TcxBorder;
  R: TRect;
begin
  if IsBordersThin then
  begin
    InternalDrawThinBorders;
    Exit;
  end;

  AIsAlphaBlendUsed := ViewInfo.IsAlphaBlendUsed;
  for ASide := Low(TcxBorder) to High(TcxBorder) do
  begin
    R := ViewInfo.BorderBounds[ASide];
    if (ASide <> bTop) and IsRectVisible(R) and not cxRectIsEmpty(R) then
    begin
      if ASide in [bLeft, bRight] then
      begin
        R.Top := ViewInfo.BorderBounds[bTop].Bottom;
        R.Bottom := ViewInfo.BorderBounds[bBottom].Top;
      end;
      InternalDrawBorder(Canvas.Handle, R, ASide, AIsAlphaBlendUsed);
    end;
  end;
end;

procedure TdxSkinFormPainter.InternalDrawCaption(const R: TRect;
  AElement: TdxSkinElement);
var
  ACachedDC: HDC;
  AMemBmp: HBitmap;
begin
  ACachedDC := CreateCompatibleDC(Canvas.Handle);
  AMemBmp := CreateCompatibleBitmap(Canvas.Handle, R.Right, R.Bottom);
  AMemBmp := SelectObject(ACachedDC, AMemBmp); 
  DrawWindowCaption(ACachedDC, R, AElement);
  BitBlt(Canvas.Handle, 0, 0, R.Right, R.Bottom, ACachedDC, 0, 0, SRCCOPY);
  AMemBMP := SelectObject(ACachedDC, AMemBmp);
  DeleteObject(AMemBmp);
  DeleteDC(ACachedDC);
end;

procedure TdxSkinFormPainter.InternalDrawThinBorders;
var
  ASide: TcxBorder;
  R: TRect;
begin
  InternalDrawBorder(Canvas.Handle, ViewInfo.BorderBounds[bBottom], bBottom, True);
  for ASide := Low(TcxBorder) to High(TcxBorder) do
    if ASide in [bLeft, bRight] then
    begin
      R := ViewInfo.BorderBounds[ASide];
      if IsRectVisible(R) and not cxRectIsEmpty(R) then
      begin
        R.Top := ViewInfo.BorderBounds[bTop].Bottom;
        R.Bottom := ViewInfo.WindowBounds.Bottom - ViewInfo.SkinBorderWidth[bBottom];
        InternalDrawBorder(Canvas.Handle, R, ASide, True);
      end;
    end;
end;

function TdxSkinFormPainter.IsRectVisible(const R: TRect): Boolean;
begin
  with FViewInfo do
    Result := (FUpdateRgn = 0) or RectInRegion(FUpdateRgn, R);
  if Result then
    Result := Canvas.RectVisible(R);
end;

function TdxSkinFormPainter.SelectDC(DC: HDC): Integer;
begin
  Result := Canvas.Handle;
  Canvas.Canvas.Handle := DC; 
end;

function TdxSkinFormPainter.GetActive: Boolean;
begin
  Result := ViewInfo.Active;
end;

function TdxSkinFormPainter.GetFormContent: TdxSkinElement;
begin
  Result := dxSkinCheckSkinElement(PainterInfo.FormContent);
end;

function TdxSkinFormPainter.GetIconElement(AIcon: TdxSkinFormIcon): TdxSkinElement;
begin
  Result := PainterInfo.FormIcons[ViewInfo.ToolWindow, AIcon];
end;

function TdxSkinFormPainter.GetIsBordersThin: Boolean;
var
  ASide: TcxBorder;
begin
  Result := False;
  for ASide := Low(TcxBorder) to High(TcxBorder) do
    Result := Result or (ViewInfo.SkinBorderWidth[ASide] < 3);
end;

{ TdxSkinButtonPainter }

constructor TdxSkinCustomControlPainter.Create(AViewInfo: TdxSkinCustomControlViewInfo);
begin
  inherited Create;
  FViewInfo := AViewInfo;
  FCanvas := TCanvas.Create;
  FcxCanvas := TcxCanvas.Create(FCanvas);
end;

destructor TdxSkinCustomControlPainter.Destroy;
begin
  FViewInfo := nil;
  FreeAndNil(FcxCanvas);
  FreeAndNil(FCanvas);
  inherited Destroy;  
end;

function TdxSkinCustomControlPainter.GetController: TdxSkinWinController;
begin
  Result := ViewInfo.Controller;
end;

function TdxSkinCustomControlPainter.GetPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := Controller.LookAndFeelPainter;
end;

procedure TdxSkinCustomControlPainter.BeginPaint(DC: HDC = 0);
const
  Flags = DCX_CACHE or DCX_CLIPSIBLINGS or DCX_WINDOW or DCX_VALIDATE;
begin
  FNeedRelease := DC = 0;
  if NeedRelease then
    DC := GetDCEx(Controller.Handle, 0, Flags);
  FDC := DC;
  Canvas.Canvas.Handle := FDC;
end;

procedure TdxSkinCustomControlPainter.EndPaint;
begin
  Canvas.Canvas.Handle := 0;
  if NeedRelease then
    ReleaseDC(Controller.Handle, FDC);
end;

procedure TdxSkinCustomControlPainter.DrawBackground;
var
  AControl: TWinControl;
begin
  AControl := Controller.WinControl;
  if AControl <> nil then
    cxDrawTransparentControlBackground(AControl, Canvas, ViewInfo.ClientRect);
end;

procedure TdxSkinCustomControlPainter.DrawButton(const ACaption: string;
  const R: TRect; AState: TcxButtonState; AWordWrap: Boolean; AFont: TFont);

  procedure DrawButtonText(const R: TRect; AFlags: Integer; ATextColor: TColor);
  begin
    Canvas.Font := AFont;
    Canvas.Font.Color := ATextColor;
    Canvas.DrawText(ACaption, R, AFlags, True);
  end;

const
  TextAlignFlagsMap: array[Boolean] of Integer = (cxSingleLine, cxWordBreak);
var
  AFlags: Integer;
begin
  Painter.DrawButton(Canvas, R, '', AState, False, clDefault, clDefault, False);
  if Length(ACaption) > 0 then
  begin
    Canvas.Brush.Style := bsClear;
    AFlags := cxAlignCenter or cxShowPrefix or TextAlignFlagsMap[AWordWrap];
    if AState = cxbsDisabled then
      DrawButtonText(R, AFlags, clBtnHighlight);
    DrawButtonText(R, AFlags, Painter.ButtonSymbolColor(AState));
  end;
end;

procedure TdxSkinCustomControlPainter.DrawFocus(const R: TRect);
begin
  Canvas.Brush.Style := bsSolid;
  Canvas.DrawFocusRect(R);
end;

{ TdxSkinCustomControlViewInfo }

constructor TdxSkinCustomControlViewInfo.Create(AController: TdxSkinWinController);
begin
  FController := AController;
end;

function TdxSkinCustomControlViewInfo.GetClientRect: TRect;
begin
  Result := cxGetWindowRect(Controller.Handle);
  OffsetRect(Result, -Result.Left, -Result.Top);
end;

function TdxSkinCustomControlViewInfo.GetIsEnabled: Boolean;
begin
  Result := IsWindowEnabled(Controller.Handle);
end;

function TdxSkinCustomControlViewInfo.GetIsFocused: Boolean;
begin
  Result := GetFocus = Controller.Handle;
end;

function TdxSkinCustomControlViewInfo.GetIsMouseAtControl: Boolean;
begin
  Result := WindowFromPoint(GetMouseCursorPos) = FController.Handle;
end;

{ TdxSkinButtonViewInfo }

constructor TdxSkinButtonViewInfo.Create(AController: TdxSkinWinController);
begin
  inherited Create(AController);
  FCaption := GetWindowCaption(Controller.Handle);
  UpdateButtonState;
end;

procedure TdxSkinButtonViewInfo.CMFocusChanged(var Message: TCMFocusChanged);
begin
  if Message.Sender is TButton then
    Active := Message.Sender = Controller.WinControl
  else
    Active := IsDefault;
end;

function TdxSkinButtonViewInfo.GetIsDefault: Boolean;
begin
  Result := (Controller.WinControl as TButton).Default;
end;

function TdxSkinButtonViewInfo.GetIsPressed: Boolean;
begin
  Result := SendMessage(Controller.Handle, BM_GETSTATE, 0, 0) and BST_PUSHED <> 0;
end;

function TdxSkinButtonViewInfo.GetWordWrap: Boolean;
begin
  Result := GetWindowLong(Controller.Handle, GWL_STYLE) and BS_MULTILINE <> 0;
end;

procedure TdxSkinButtonViewInfo.SetActive(AActive: Boolean);
begin
  if AActive <> FActive then
  begin
    FActive := AActive;
    UpdateButtonState;
  end;
end;

procedure TdxSkinButtonViewInfo.SetState(AState: TcxButtonState);
var
  ANewState: TcxButtonState;
begin
  if IsEnabled then
    ANewState := AState
  else
    ANewState := cxbsDisabled;

  if ANewState <> FState then
  begin
    FState := ANewState;
    if Controller.IsSkinUsed then
      Controller.RedrawWindow(True);
  end;
end;

procedure TdxSkinButtonViewInfo.UpdateButtonState;
const
  DefaultStatesMap: array[Boolean] of TcxButtonState = (cxbsNormal, cxbsDefault);
var
  AState: TcxButtonState;
begin
  AState := DefaultStatesMap[Active];
  if IsMouseAtControl then
    AState := cxbsHot;
  if IsPressed then
    AState := cxbsPressed; 
  State := AState;
end;

{ TdxSkinButtonController }

function TdxSkinButtonController.GetViewInfo: TdxSkinButtonViewInfo;
begin
  Result := TdxSkinButtonViewInfo(inherited ViewInfo);
end;

class function TdxSkinButtonController.GetViewInfoClass: TdxSkinCustomControlViewInfoClass;
begin
  Result := TdxSkinButtonViewInfo;
end;

procedure TdxSkinButtonController.DrawContent(DC: HDC = 0);
begin
  Painter.BeginPaint(DC);
  try
    Painter.DrawBackground;
    with TdxSkinButtonViewInfo(ViewInfo) do
    begin
      Painter.DrawButton(Caption, ClientRect, State, WordWrap,
        TControlAccess(WinControl).Font);
      if IsFocused then
        Painter.DrawFocus(cxRectInflate(ClientRect, -4, -4));
    end;
  finally
    Painter.EndPaint;
  end;
end;

procedure TdxSkinButtonController.MouseLeave;
begin
  inherited MouseLeave;
  ViewInfo.UpdateButtonState;
end;

procedure TdxSkinButtonController.WndProc(var AMessage: TMessage);
const
  AStates: array[Boolean] of TcxButtonState = (cxbsDisabled, cxbsNormal);
begin
  if AMessage.Msg = CM_FOCUSCHANGED then
    ViewInfo.CMFocusChanged(TCMFocusChanged(AMessage));
  inherited WndProc(AMessage);
  case AMessage.Msg of
    WM_ENABLE, BM_SETSTATE, WM_MOUSELEAVE,
    WM_MOUSEMOVE, CM_MOUSELEAVE, WM_MOUSEHOVER:
      ViewInfo.UpdateButtonState;
    WM_UPDATEUISTATE:
      if IsSkinUsed and (AMessage.WParamLo in [UIS_SET, UIS_CLEAR]) then
        DrawContent;
    WM_SETTEXT:
      begin
        ViewInfo.FCaption := TWMSetText(AMessage).Text;
        if IsSkinUsed then
          DrawContent;
      end;
  end;
end;

{ TdxSkinCustomController }

constructor TdxSkinCustomController.Create(AHandle: HWND);
begin
  inherited Create(AHandle);
  FViewInfo := GetViewInfoClass.Create(Self);
  FPainter := TdxSkinCustomControlPainter.Create(FViewInfo);
end;

destructor TdxSkinCustomController.Destroy;
begin
  FreeAndNil(FViewInfo);
  FreeAndNil(FPainter);
  inherited Destroy;
end;

procedure TdxSkinCustomController.DrawBackground(DC: HDC = 0);
begin
  Painter.BeginPaint(DC);
  try
    Painter.DrawBackground;
  finally
    Painter.EndPaint;
  end;
end;

procedure TdxSkinCustomController.DrawContent(DC: HDC = 0);
begin
end;

class function TdxSkinCustomController.GetViewInfoClass: TdxSkinCustomControlViewInfoClass;
begin
  Result := TdxSkinCustomControlViewInfo;
end;

function TdxSkinCustomController.GetMaster(AHandle: HWND): TdxSkinWinController;
var
  AParent: TCustomForm;
begin
  Result := nil;
  if Assigned(WinControl) then
  begin
    AParent := GetParentForm(WinControl);
    if Assigned(AParent) and GetUseSkinForControl then
      Result := FormControllers.GetControllerByHandle(AParent.Handle)
  end;
end;

procedure TdxSkinCustomController.InitializePainter;
begin
  // nothing to do
end;

function TdxSkinCustomController.WMEraseBk(var AMessage: TWMEraseBkgnd): Boolean;
begin
  AMessage.Result := 1;
  Result := True;
end;

function TdxSkinCustomController.WMPaint(var AMessage: TWMPaint): Boolean;
var
  APaintStruct: TPaintStruct;
  ADC: HDC;
begin
  Result := True;
  if AMessage.DC <> 0 then
    DrawContent(AMessage.DC)
  else
  begin
    ADC := BeginPaint(Handle, APaintStruct);
    try
      DrawContent(ADC);
    finally
      EndPaint(Handle, APaintStruct);
    end;
  end;
end;

procedure TdxSkinCustomController.WndProc(var AMessage: TMessage);
var
  AHandled: Boolean;
begin
  AHandled := False;
  if IsSkinUsed then
  begin
    case AMessage.Msg of
      WM_ERASEBKGND:
        AHandled := WMEraseBk(TWMEraseBkgnd(AMessage));
      WM_PAINT:
        AHandled := WMPaint(TWMPaint(AMessage));
    end;
  end;
  if not AHandled then
    inherited WndProc(AMessage);
end;

{ TdxSkinPanelController }

procedure TdxSkinPanelController.DrawContent(DC: HDC = 0);
const
  Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  AControl: TControl;
  R: TRect;
begin
  AControl := WinControl;
  if Assigned(AControl) and (AControl is TCustomPanel) then
  begin
    Painter.BeginPaint(DC);
    try
      R := ViewInfo.ClientRect;
      InternalDrawBackground(TCustomPanel(AControl), R);
      with TCustomPanelAccess(AControl) do
      begin
        Painter.Canvas.Brush.Style := bsClear;
        Painter.Canvas.Font := Font;
        if (Font.Color = clWindowText) and (Painter.Painter.PanelTextColor <> clDefault) then
          Painter.Canvas.Font.Color := Painter.Painter.PanelTextColor;
        cxDrawText(Painter.Canvas.Handle, Caption, R,
          DrawTextBiDiModeFlags(DT_EXPANDTABS or DT_SINGLELINE or DT_VCENTER or
          Alignments[Alignment]));
        Painter.Canvas.Brush.Style := bsSolid;
        PaintControls(Painter.Canvas.Handle, nil);
      end;
    finally
      Painter.EndPaint;
    end;
  end;
end;

procedure TdxSkinPanelController.InternalDrawBackground(APanel: TCustomPanel; const R: TRect);
begin
  with TCustomPanelAccess(APanel) do
  begin
    if csParentBackground in ControlStyle then
      cxDrawTransparentControlBackground(APanel, Painter.Canvas, R, False)
    else
      if Color = clBtnFace then
        Painter.Painter.DrawPanelContent(Painter.Canvas, R, False)
      else
        Painter.Painter.DrawPanelBackground(Painter.Canvas, APanel, R, Color);

    if (BevelOuter <> bvNone) or (BevelInner <> bvNone) then
      Painter.Painter.DrawPanelBorders(Painter.Canvas, R);
  end;
end;

function TdxSkinPanelController.WMEraseBk(var AMessage: TWMEraseBkgnd): Boolean;
begin
  Result := False;
end;

function TdxSkinPanelController.WMPaint(var AMessage: TWMPaint): Boolean;
begin
  Result := False;
  if not FPainting then
  begin
    FPainting := True;
    try
      Result := inherited WMPaint(AMessage);
    finally
      FPainting := False;
    end;
  end;
end;

function TdxSkinPanelController.WMPrintClient(var AMessage: TWMPrintClient): Boolean;
begin
  Result := (AMessage.Result <> 1) and
    ((AMessage.Flags and PRF_CHECKVISIBLE = 0) or IsWindowVisible(Handle)) and
    WMPaint(TWMPaint(AMessage));
end;

procedure TdxSkinPanelController.WndProc(var AMessage: TMessage);
var
  AHandled: Boolean;
begin
  AHandled := False;
  if IsSkinUsed then
  begin
    case AMessage.Msg of
      CM_COLORCHANGED:
        RedrawWindow(False);
      WM_PRINTCLIENT:
        AHandled := WMPrintClient(TWMPrintClient(AMessage));
    end;
  end;
  if not AHandled then
    inherited WndProc(AMessage);
end;

{ TdxSkinFrameController }

procedure TdxSkinFrameController.DrawWindowBackground(DC: HDC);
begin
  if not IsTransparent then
    inherited DrawWindowBackground(DC)
  else
  begin
    Painter.BeginPaint(DC);
    try
      cxDrawTransparentControlBackground(
        WinControl, Painter.Canvas, ViewInfo.ClientBounds, False);
    finally
      Painter.EndPaint;
    end;
  end;
end;

function TdxSkinFrameController.GetIsTransparent: Boolean;
begin
  Result := Assigned(WinControl) and (csParentBackground in WinControl.ControlStyle);
end;

function TdxSkinFrameController.GetMaster(AHandle: HWND): TdxSkinWinController;
var
  AParent: TCustomForm;
begin
  Result := nil;
  if Assigned(WinControl) then
  begin
    AParent := GetParentForm(WinControl);
    if Assigned(AParent) and GetUseSkinForControl then
      Result := FormControllers.GetControllerByHandle(AParent.Handle)
  end;
end;

procedure TdxSkinFrameController.InitializePainter;
begin
  // nothing to do
end;

procedure TdxSkinFrameController.WMWindowPosChanged(var Message: TWMWindowPosMsg);
begin
  inherited WMWindowPosChanged(Message);
  if IsTransparent then
  begin
    if (Message.WindowPos^.flags and SWP_NOSIZE = 0) or
       (Message.WindowPos^.flags and SWP_NOMOVE = 0)
    then
      PostRedraw;
  end;
end;

{ TdxSkinWinControllerHelper }

constructor TdxSkinWinControllerHelper.Create;
begin
  FHandle := {$IFDEF DELPHI6}Classes.{$ENDIF}AllocateHWnd(WndProc);
end;

destructor TdxSkinWinControllerHelper.Destroy;
begin
  {$IFDEF DELPHI6}Classes.{$ENDIF}DeallocateHWnd(FHandle);
  inherited Destroy;
end;

procedure TdxSkinWinControllerHelper.ChildChanged(AHandle: HWND);
begin
  AHandle := GetParent(AHandle);
  if (AHandle <> 0) and AnsiSameText(GetWindowClass(AHandle), 'MDICLIENT') then
  begin
    AHandle := GetParent(AHandle);
    if AHandle <> 0 then
      PostMessage(AHandle, DXM_SKINS_CHILDCHANGED, 0, 0);
  end;
end;

procedure TdxSkinWinControllerHelper.FinalizeEngine(AHandle: HWND);
begin
  TdxSkinWinController.FinalizeEngine(AHandle);
  SkinHelper.ChildChanged(AHandle);
end;

procedure TdxSkinWinControllerHelper.InitializeEngine(AHandle: HWND);
begin
  if SendMessage(AHandle, DXM_SKINS_HASOWNSKINENGINE, 0, 0) = 0 then
  begin
    if {$IFNDEF DELPHI12} IsWindowUnicode(AHandle) or {$ENDIF} // note: try to detect TntControls
      TdxSkinFormController.IsMDIClientWindow(AHandle)
    then
      PostMessage(SkinHelper.Handle, DXM_SKINS_POSTCREATE, 0, AHandle)
    else
      InternalInitializeEngine(AHandle);
  end;
end;

procedure TdxSkinWinControllerHelper.InternalInitializeEngine(AHandle: HWND);

  function IsAnotherApplicatonWindow(AWnd: HWND): Boolean;
  var
    AProcessId: Cardinal;
  begin
    GetWindowThreadProcessId(AWnd, @AProcessId);
    Result := (AWnd = 0) or (AProcessId <> GetCurrentProcessId);
  end;

  function GetSkinClassForWindow(AWnd: HWND): TdxSkinWinControllerClass;
  begin
    Result := nil;
    if not IsAnotherApplicatonWindow(AWnd) then
      Result := dxSkinGetControllerClassForWindowProc(AWnd);
  end;

var
  ASkinClass: TdxSkinWinControllerClass;
begin
  ASkinClass := GetSkinClassForWindow(AHandle);
  if ASkinClass <> nil then
  begin
    ASkinClass.InitializeEngine(AHandle);
    PostMessage(AHandle, DXM_SKINS_POSTCHECKRGN, 0, 0);
  end;
end;

procedure TdxSkinWinControllerHelper.WndProc(var AMsg: TMessage);
begin
  if AMsg.Msg = DXM_SKINS_POSTCREATE then
    InternalInitializeEngine(AMsg.LParam)
  else
    AMsg.Result := DefWindowProc(Handle, AMsg.Msg, AMsg.WParam, AMsg.LParam);
end;

{ TdxSkinFormControllers }

procedure TdxSkinFormControllers.MasterDestroyed(AMaster: TdxSkinWinController);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    if Items[I].FMaster = AMaster then
      Items[I].FMaster := nil;
  end;
end;

procedure TdxSkinFormControllers.Refresh(AControl: TWinControl = nil);

  function CanRefresh(AController: TdxSkinWinController): Boolean;
  begin
    Result := (AControl = nil) or (AController.WinControl = AControl);
  end;

  procedure DoRefresh(AController: TdxSkinWinController);
  begin
    if CanRefresh(AController) then
      AController.RefreshController;
  end;

  procedure DoUpdate(AController: TdxSkinWinController);
  begin
    if CanRefresh(AController) then
      AController.Update;
  end;

var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    DoRefresh(Items[I]);
  for I := 0 to Count - 1 do
    DoUpdate(Items[I]);
end;

function TdxSkinFormControllers.GetControllerByControl(AControl: TWinControl): TdxSkinWinController;
var
  I: Integer;
begin
  Result := nil;
  if AControl <> nil then
  begin
    for I := 0 to Count - 1 do
      if Items[I].WinControl = AControl then
      begin
        Result := Items[I];
        Break;
      end;
  end;
end;

function TdxSkinFormControllers.GetControllerByHandle(AHandle: HWND): TdxSkinWinController;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].Handle = AHandle then
    begin
      Result := Items[I];
      Break;
    end;
end;

function TdxSkinFormControllers.GetItem(Index: Integer): TdxSkinWinController;
begin
  Result := TdxSkinWinController(inherited Items[Index]);
end;

//

function dxSkinGetControllerClassForWindow(AWnd: HWND): TdxSkinWinControllerClass;
var
  AControl: TControl;
begin
  Result := nil;
  if TdxSkinWinController.IsMDIClientWindow(AWnd) then
    Result := TdxSkinFormController
  else
  begin
    AControl := FindControl(AWnd);
    if AControl <> nil then
    begin
      if AControl is TCustomForm then
        Result := TdxSkinFormController;
      if AControl is TCustomFrame then
        Result := TdxSkinFrameController;
      if SameText(AControl.ClassName, 'TButton') then
        Result := TdxSkinButtonController;
      if SameText(AControl.ClassName, 'TPanel') then
        Result := TdxSkinPanelController;
    end;
  end;
end;

function dxSkinsWndProcHook(Code: Integer; wParam: WParam; lParam: LParam): LRESULT; stdcall;
var
  AMsg: PCWPStruct;
begin
  AMsg := PCWPStruct(lParam);
  Result := CallNextHookEx(WndProcHookHandle, Code, wParam, lParam);
  if IsDesigning then Exit;
  case AMsg.message of
    WM_CHILDACTIVATE, WM_MDIACTIVATE:
      SkinHelper.ChildChanged(AMsg.hwnd);

    WM_CREATE, WM_MDICREATE:
      SkinHelper.InitializeEngine(AMsg.hwnd);

    WM_DESTROY, WM_MDIDESTROY:
      if AMsg.wParam = 0 then
        SkinHelper.FinalizeEngine(AMsg.hwnd);
  end;
end;

var
  SetScrollInfo: function(hWnd: HWND; BarFlag: Integer;
    const ScrollInfo: TScrollInfo; Redraw: BOOL): Integer; stdcall;
  SetScrollPos: function (hWnd: HWND; nBar, nPos: Integer;
    bRedraw: BOOL): Integer stdcall;

function My_SetScrollPos(hWnd: HWND; nBar, nPos: Integer;
  bRedraw: BOOL): Integer; stdcall;
begin
  bRedraw := bRedraw and not TdxSkinFormController.IsSkinActive(hWnd);
  Result := SetScrollPos(hWnd, nBar, nPos, bRedraw);
end;

function My_SetScrollInfo(hWnd: HWND; BarFlag: Integer;
  const ScrollInfo: TScrollInfo; Redraw: BOOL): Integer; stdcall;
begin
  Redraw := Redraw and not TdxSkinFormController.IsSkinActive(hWnd);
  Result := SetScrollInfo(hWnd, BarFlag, ScrollInfo, Redraw);
end;

procedure RegisterAssistants;
begin
  SetScrollPos := FlatSB_SetScrollPos;
  SetScrollInfo := FlatSB_SetScrollInfo;
  FlatSB_SetScrollPos := My_SetScrollPos;
  FlatSB_SetScrollInfo := My_SetScrollInfo;
  dxSkinControllersList := TList.Create;
  SkinHelper := TdxSkinWinControllerHelper.Create;
  SetHook(WndProcHookHandle, WH_CALLWNDPROC, dxSkinsWndProcHook);
  FormControllers := TdxSkinFormControllers.Create;
end;

procedure UnregisterAssistants;
begin
  FlatSB_SetScrollPos := SetScrollPos;
  FlatSB_SetScrollInfo := SetScrollInfo;
  ReleaseHook(WndProcHookHandle);
  FormControllers.Clear; // destroy all active controllers
  FreeAndNil(dxSkinControllersList);
  FreeAndNil(FormControllers);
  FreeAndNil(SkinHelper);
end;

initialization
  dxSkinGetControllerClassForWindowProc := dxSkinGetControllerClassForWindow;
  RegisterAssistants;

finalization
  UnregisterAssistants;
  
end.

