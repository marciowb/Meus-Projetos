{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid                                           }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
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

unit cxGridCustomView;

{$I cxGridVer.inc}

interface

uses
  Windows, Messages,
  Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls,
  dxMessages, cxClasses, cxControls, cxGraphics, cxLookAndFeelPainters, cxStyles, cxStorage,
  cxGridCommon,
  cxCustomData, cxData;

const
  htError = -1;
  htNone = 0;

  bbCustomFirst = 0;
  bbBackground = bbCustomFirst;
  bbCustomLast = bbBackground;

  vsCustomFirst = 0;
  vsBackground = vsCustomFirst;
  vsCustomLast = vsBackground;

type
  TcxCustomGridDragAndDropObjectClass = class of TcxCustomGridDragAndDropObject;
  TcxCustomGridController = class;
  TcxCustomGridPainter = class;
  TcxCustomGridViewData = class;
  TcxCustomGridCellViewInfo = class;
  TcxCustomGridViewInfo = class;
  TcxCustomGridViewInfoCache = class;
  TcxGridSite = class;
  TcxCustomGridView = class;

  { change }

  TcxCustomGridViewChange = class(TcxCustomGridChange)
  private
    FGridView: TcxCustomGridView;
  public
    constructor Create(AGridView: TcxCustomGridView); virtual;
    property GridView: TcxCustomGridView read FGridView write FGridView;
    function IsEqual(AChange: TcxCustomGridChange): Boolean; override;
  end;

  TcxGridControlFocusChange = class(TcxCustomGridViewChange)
  public
    procedure Execute; override;
  end;

  { hit tests }

  TcxCustomGridHitTestClass = class of TcxCustomGridHitTest;

  TcxCustomGridHitTest = class
  private
    FPos: TPoint;
    FViewInfo: TcxCustomGridCellViewInfo;
  protected
    class function GetHitTestCode: Integer; virtual;
    procedure Init(const APos: TPoint);
  public
    class function Cursor: TCursor; virtual;
    function DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass; virtual;
    class function HitTestCode: Integer;
    class function Instance(const APos: TPoint): TcxCustomGridHitTest;
    property Pos: TPoint read FPos;
    property ViewInfo: TcxCustomGridCellViewInfo read FViewInfo write FViewInfo;
  end;

  TcxGridNoneHitTest = class(TcxCustomGridHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxCustomGridViewHitTest = class(TcxCustomGridHitTest)
  private
    FGridView: TcxCustomGridView;
  public
    property GridView: TcxCustomGridView read FGridView write FGridView;
  end;

  TcxGridViewNoneHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  { handlers }

  TcxGridViewHandler = class(TcxInterfacedPersistent)
  private
    FGridView: TcxCustomGridView;
    function GetControl: TcxControl;
    function GetController: TcxCustomGridController;
    function GetDataController: TcxCustomDataController;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
    function GetPainter: TcxCustomGridPainter;
    function GetSite: TcxGridSite;
    function GetViewData: TcxCustomGridViewData;
    function GetViewInfo: TcxCustomGridViewInfo;
  protected
    property Control: TcxControl read GetControl;
    property Controller: TcxCustomGridController read GetController;
    property DataController: TcxCustomDataController read GetDataController;
    property ViewData: TcxCustomGridViewData read GetViewData;
  public
    constructor Create(AGridView: TcxCustomGridView); reintroduce; virtual;
    procedure BeginUpdate;
    procedure EndUpdate;
    property GridView: TcxCustomGridView read FGridView;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
    property Painter: TcxCustomGridPainter read GetPainter;
    property Site: TcxGridSite read GetSite;
    property ViewInfo: TcxCustomGridViewInfo read GetViewInfo;
  end;

  TcxCustomGridDragAndDropObject = class(TcxDragAndDropObject)
  private
    function GetController: TcxCustomGridController;
    function GetGridView: TcxCustomGridView;
    function GetViewInfo: TcxCustomGridViewInfo;
  protected
    procedure AfterDragAndDrop(Accepted: Boolean); override;
    procedure AfterPaint; virtual;
    procedure BeforePaint; virtual;
    property Controller: TcxCustomGridController read GetController;
    property ViewInfo: TcxCustomGridViewInfo read GetViewInfo;
  public
    SourcePoint: TPoint;
    procedure Init(const P: TPoint; AParams: TcxCustomGridHitTest); virtual;
    property GridView: TcxCustomGridView read GetGridView;
  end;

  TcxCustomGridControllerClass = class of TcxCustomGridController;

  TcxCustomGridController = class(TcxGridViewHandler, IcxMouseTrackingCaller)
  private
    FHintTextRect: TRect;
    FHintWindow: THintWindow;
    FIsDblClick: Boolean;
    function GetDragAndDropObject: TcxCustomGridDragAndDropObject;
    function GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
    function GetIsDragging: Boolean;
    function GetMouseCaptureViewInfo: TcxCustomGridCellViewInfo;
    procedure SetDragAndDropObjectClass(Value: TcxDragAndDropObjectClass);
    procedure SetMouseCaptureViewInfo(Value: TcxCustomGridCellViewInfo);
  protected
    { IcxMouseTrackingCaller }
    procedure MouseLeave; virtual;

    procedure AfterPaint; virtual;
    procedure BeforeKillFocus; virtual;
    procedure BeforePaint; virtual;
    function CanHandleHitTest(AHitTest: TcxCustomGridHitTest): Boolean; virtual;
    procedure DetailFocused(ADetail: TcxCustomGridView); virtual;
    procedure DoEnter; virtual;
    procedure DoExit; virtual;
    function GetDesignHitTest(AHitTest: TcxCustomGridHitTest): Boolean; virtual;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; virtual;
    function IsPixelScrollBar(AKind: TScrollBarKind): Boolean; virtual;
    function MayFocus: Boolean; virtual;
    procedure RemoveFocus; virtual;
    procedure SetFocus; virtual;

    property DragAndDropObject: TcxCustomGridDragAndDropObject read GetDragAndDropObject;
    property IsDragging: Boolean read GetIsDragging;
  public
    destructor Destroy; override;
    procedure ControlFocusChanged; virtual;
    procedure DesignerModified;
    procedure DoCancelMode; virtual;
    procedure DoControlFocusChanged;
    function GetCursor(X, Y: Integer): TCursor; virtual;
    function HasFocusedControls: Boolean; virtual;
    //function CanDrag(X, Y: Integer): Boolean; dynamic;
    //function GetDragObjectClass: TDragControlObjectClass; dynamic;

    procedure InitScrollBarsParameters; virtual;
    function IsDataFullyVisible(AIsCallFromMaster: Boolean = False): Boolean; virtual;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
      var AScrollPos: Integer); virtual;
    procedure SetScrollBarInfo(AScrollBarKind: TScrollBarKind;
      AMin, AMax, AStep, APage, APos: Integer; AAllowShow, AAllowHide: Boolean);
    procedure UpdateScrollBars;

    procedure BeginDragAndDrop; virtual;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); virtual;
    procedure EndDragAndDrop(Accepted: Boolean); virtual;
    function StartDragAndDrop(const P: TPoint): Boolean; virtual;

    procedure BeforeStartDrag; virtual;
    function CanDrag(X, Y: Integer): Boolean; virtual;
    procedure DragDrop(Source: TObject; X, Y: Integer); virtual;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); virtual;
    procedure EndDrag(Target: TObject; X, Y: Integer); virtual;
    procedure StartDrag(var DragObject: TDragObject); virtual;

    // hints
    procedure HideHint;
    function GetHintWindowClass: THintWindowClass; virtual;
    procedure ShowHint(const AHintAreaBounds, ATextRect: TRect; const AText: string;
      AIsHintMultiLine: Boolean; AFont: TFont);
    property HintWindow: THintWindow read FHintWindow;

    procedure DoKeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure KeyPress(var Key: Char); virtual;
    procedure KeyUp(var Key: Word; Shift: TShiftState); virtual;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;

    procedure WndProc(var Message: TMessage); virtual;

    {procedure BeginCellMouseTracking(AViewInfo: TcxCustomGridCellViewInfo);
    procedure EndCellMouseTracking(AViewInfo: TcxCustomGridCellViewInfo);}

    property DragAndDropObjectClass: TcxDragAndDropObjectClass read GetDragAndDropObjectClass
      write SetDragAndDropObjectClass;
    property IsDblClick: Boolean read FIsDblClick;
    property MouseCaptureViewInfo: TcxCustomGridCellViewInfo read GetMouseCaptureViewInfo
      write SetMouseCaptureViewInfo;
  end;

  IcxCustomGridDataController = interface
    ['{B9ABDC6B-1A4A-4F11-A629-09B6FB9FB4BA}']
    procedure GetFakeComponentLinks(AList: TList);
    function GetGridView: TcxCustomGridView;
    property GridView: TcxCustomGridView read GetGridView;
  end;

  TcxCustomGridCellPainterClass = class of TcxCustomGridCellPainter;

  TcxCustomGridCellPainter = class
  private
    FCanvas: TcxCanvas;
    FViewInfo: TcxCustomGridCellViewInfo;
    function GetIsMainCanvasInUse: Boolean;
  protected
    procedure AfterPaint; virtual;
    procedure BeforePaint; virtual;
    procedure DrawBackground; virtual;
    function DrawBackgroundHandler(ACanvas: TcxCanvas; const ABounds: TRect): Boolean; virtual;
    procedure DrawBorder(ABorder: TcxBorder); virtual;
    procedure DrawBorders; virtual;
    procedure DrawContent; virtual;
    procedure DrawText; virtual;
    function ExcludeFromClipRect: Boolean; virtual;
    function NeedsPainting: Boolean; virtual;
    procedure Paint; virtual;
    property Canvas: TcxCanvas read FCanvas;
    property IsMainCanvasInUse: Boolean read GetIsMainCanvasInUse;
    property ViewInfo: TcxCustomGridCellViewInfo read FViewInfo;
  public
    constructor Create(ACanvas: TcxCanvas; AViewInfo: TcxCustomGridCellViewInfo); virtual;
    procedure MainPaint; virtual;
  end;

  TcxCustomGridPainterClass = class of TcxCustomGridPainter;

  TcxCustomGridPainter = class(TcxGridViewHandler)
  private
    FBackgroundRegion: TcxRegion;
    FBeforePaintClipRegion: TcxRegion;
    function GetCanvas: TcxCanvas;
  protected
    procedure DrawBackground; virtual;
    procedure PaintAfter; virtual;
    procedure PaintBefore; virtual;
    procedure PaintContent; virtual;
    property Canvas: TcxCanvas read GetCanvas;
  public
    procedure DrawFocusRect(const R: TRect; AHideFocusRect: Boolean); virtual;
    procedure ExcludeFromBackground(const R: TRect);
    procedure Paint;
    procedure Invalidate; overload;
    procedure Invalidate(const R: TRect); overload;
  end;

  TcxCustomGridViewDataClass = class of TcxCustomGridViewData;

  TcxCustomGridViewData = class(TcxGridViewHandler)
  public
    property DataController;
  end;

  TcxGridSiteClass = class of TcxGridSite;

  TcxGridSite = class(TcxControl)
  private
    FSize: TPoint;
    FViewInfo: TcxCustomGridViewInfo;
    function GetContainer: TcxControl;
    function GetController: TcxCustomGridController;
    function GetGridView: TcxCustomGridView;
    function GetPainter: TcxCustomGridPainter;
    procedure SendKeyDownNotification(const Message: TWMKeyDown);
    procedure CMBoundsChanged(var Message: TMessage); message DXM_BOUNDSCHANGED;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure CNSysKeyDown(var Message: TWMKeyDown); message CN_SYSKEYDOWN;
  protected
    function AllowAutoDragAndDropAtDesignTime(X, Y: Integer;
      Shift: TShiftState): Boolean; override;
    function AllowDragAndDropWithoutFocus: Boolean; override;
    procedure BeforeMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure BoundsChanged; override;
    function CanDrag(X, Y: Integer): Boolean; override;
    procedure DoCancelMode; override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure FocusChanged; override;
    function FocusWhenChildIsClicked(AChild: TControl): Boolean; override;
    function GetCursor(X, Y: Integer): TCursor; override;
    function GetDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean; override;
    function GetIsDesigning: Boolean; override;
    function GetIsFocused: Boolean; override;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; override;
    function IsPixelScrollBar(AKind: TScrollBarKind): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    function MayFocus: Boolean; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure RequestAlign; override;
    procedure SetParent(AParent: TWinControl); override;
    procedure WndProc(var Message: TMessage); override;

    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;

    function GetHScrollBarBounds: TRect; override;
    procedure InitScrollBarsParameters; override;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
      var AScrollPos: Integer); override;
    procedure UpdateScrollBars; override;

    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    function StartDragAndDrop(const P: TPoint): Boolean; override;

    procedure CancelPostBoundsChanged;
    procedure InitTabStop(AParent: TWinControl);
    procedure PostBoundsChanged;
    procedure UpdateSize;

    property Controller: TcxCustomGridController read GetController;
    property Painter: TcxCustomGridPainter read GetPainter;
  public
    constructor Create(AViewInfo: TcxCustomGridViewInfo); reintroduce; virtual;
    destructor Destroy; override;
    procedure BeginDragAndDrop; override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure SetFocus; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;

    property Container: TcxControl read GetContainer;
    property GridView: TcxCustomGridView read GetGridView;
    property Keys; //!!!
    property MouseCapture;
    property ViewInfo: TcxCustomGridViewInfo read FViewInfo;
  end;

  TcxCustomGridCellViewInfoClass = class of TcxCustomGridCellViewInfo;

  TcxCustomGridCellViewInfo = class(TObject, IUnknown, IcxMouseCaptureObject,
    IcxMouseTrackingCaller)
  private
    FCalculated: Boolean;
    FCalculatingParams: Boolean;
    FContentBounds: TRect;
    FAlignmentHorz: TAlignment;
    FAlignmentVert: TcxAlignmentVert;
    FBorders: TcxBorders;
    FIsDestroying: Boolean;
    FParamsCalculated: Boolean;
    FState: TcxGridCellState;
    FText: string;
    FVisible: Boolean;
    function GetBorderSize(AIndex: TcxBorder): Integer;
    function GetContentBounds: TRect;
    function GetTextAreaHeight: Integer;
    function GetTextAreaWidth: Integer;
    function GetTextHeight: Integer;
    function GetTextWidth: Integer;
    procedure SetState(Value: TcxGridCellState);
  protected
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { IcxMouseCaptureObject }
    procedure DoCancelMode; virtual;
    { IcxMouseTrackingCaller }
    procedure MouseLeave; virtual;

    procedure AfterCalculateBounds(var ABounds: TRect); virtual;
    procedure AfterCustomDraw(ACanvas: TcxCanvas); virtual;
    procedure BeforeCustomDraw(ACanvas: TcxCanvas); virtual;
    procedure BeforeStateChange; virtual;
    function CalculateContentBounds: TRect; virtual;
    procedure CalculateParams;
    function CalculateHeight: Integer; virtual; abstract;
    function CalculateWidth: Integer; virtual; abstract;
    procedure Click; virtual;
    function CustomDraw(ACanvas: TcxCanvas): Boolean; virtual;
    function CustomDrawBackground(ACanvas: TcxCanvas): Boolean; virtual;
    procedure Destroying;
    procedure DoCalculateParams; virtual;
    function DoCustomDraw(ACanvas: TcxCanvas): Boolean; virtual;
    function DoCustomDrawBackground(ACanvas: TcxCanvas): Boolean; virtual;
    function GetAlignmentHorz: TAlignment; virtual;
    function GetAlignmentVert: TcxAlignmentVert; virtual;
    function GetBackgroundBitmap: TBitmap; virtual;
    function GetBorderBounds(AIndex: TcxBorder): TRect; virtual;
    function GetBorderColor(AIndex: TcxBorder): TColor; virtual; abstract;
    function GetBorders: TcxBorders; virtual;
    function GetBorderWidth(AIndex: TcxBorder): Integer; virtual; abstract;
    function GetCanvas: TcxCanvas; virtual; abstract;
    class function GetCellHeight(ATextHeight: Integer;
      ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer; virtual;
    function GetContentHeight: Integer; virtual;
    function GetContentWidth: Integer; virtual;
    function GetControl: TcxControl; virtual;
    function GetHeight: Integer; virtual;
    function GetHitTestClass: TcxCustomGridHitTestClass; virtual; abstract;
    function GetHotTrack: Boolean; virtual;
    function GetIsCheck: Boolean; virtual;
    function GetMouseCapture: Boolean; virtual;
    function GetMultiLine: Boolean; virtual;
    function GetMultiLinePainting: Boolean; virtual;
    function GetPainterClass: TcxCustomGridCellPainterClass; virtual;
    function GetShowEndEllipsis: Boolean; virtual;
    function GetText: string; virtual;
    function GetTextAreaBounds: TRect; virtual;
    function GetTextAttributes(AForPainting: Boolean): Integer;
    function GetTextCellHeight(AGridViewInfo: TcxCustomGridViewInfo;
      ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer; virtual;
    function GetTransparent: Boolean; virtual;
    procedure GetViewParams(var AParams: TcxViewParams); virtual;
    function GetVisible: Boolean; virtual;
    function GetWidth: Integer; virtual;
    function HasCustomDraw: Boolean; virtual;
    function HasCustomDrawBackground: Boolean; virtual;
    function HasMouse(AHitTest: TcxCustomGridHitTest): Boolean; virtual;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); virtual;
    function InvalidateOnStateChange: Boolean; virtual;
    procedure Offset(DX, DY: Integer); virtual;
    procedure RestoreParams(const AParams: TcxViewParams); virtual;
    procedure SaveParams(out AParams: TcxViewParams); virtual;
    procedure SetMouseCapture(Value: Boolean); virtual;
    procedure SetWidth(Value: Integer); virtual;
    procedure StateChanged; virtual;

    property BorderWidth[AIndex: TcxBorder]: Integer read GetBorderWidth;
    property CalculatingParams: Boolean read FCalculatingParams;
    property Canvas: TcxCanvas read GetCanvas;
    property Control: TcxControl read GetControl;
    property HotTrack: Boolean read GetHotTrack;
    property IsCheck: Boolean read GetIsCheck;
    property IsDestroying: Boolean read FIsDestroying;
    property ShowEndEllipsis: Boolean read GetShowEndEllipsis;
  public
    Bounds: TRect;
    MultiLine: Boolean;
    MultiLinePainting: Boolean;
    Params: TcxViewParams;

    constructor Create;
    destructor Destroy; override;
    procedure AfterRecalculation; virtual;
    procedure BeforeRecalculation; virtual;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); overload; virtual;
    procedure Calculate(const ABounds: TRect); overload; virtual;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; virtual;
    procedure Invalidate; virtual;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; virtual;
    function MouseMove(AHitTest: TcxCustomGridHitTest; AShift: TShiftState): Boolean; virtual;
    function MouseUp(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; virtual;
    procedure DoOffset(DX, DY: Integer);
    procedure Paint(ACanvas: TcxCanvas = nil); virtual;
    procedure Recalculate;
    procedure ResetContentBounds;

    property AlignmentHorz: TAlignment read FAlignmentHorz write FAlignmentHorz;
    property AlignmentVert: TcxAlignmentVert read FAlignmentVert write FAlignmentVert;
    property BackgroundBitmap: TBitmap read GetBackgroundBitmap;
    property BorderBounds[AIndex: TcxBorder]: TRect read GetBorderBounds;
    property BorderColor[AIndex: TcxBorder]: TColor read GetBorderColor;
    property BorderSize[AIndex: TcxBorder]: Integer read GetBorderSize;
    property Borders: TcxBorders read FBorders write FBorders;
    property Calculated: Boolean read FCalculated write FCalculated;
    property ContentBounds: TRect read GetContentBounds;
    property ContentHeight: Integer read GetContentHeight;
    property ContentWidth: Integer read GetContentWidth;
    property Height: Integer read GetHeight;
    property MouseCapture: Boolean read GetMouseCapture write SetMouseCapture;
    property State: TcxGridCellState read FState write SetState;
    property Text: string read FText write FText;
    property TextAreaHeight: Integer read GetTextAreaHeight;
    property TextAreaWidth: Integer read GetTextAreaWidth;
    property TextHeight: Integer read GetTextHeight;
    property TextWidth: Integer read GetTextWidth;
    property TextAreaBounds: TRect read GetTextAreaBounds;
    property Transparent: Boolean read GetTransparent;
    property Visible: Boolean read GetVisible write FVisible;
    property Width: Integer read GetWidth write SetWidth;
  end;

  TcxCustomGridViewCellViewInfo = class(TcxCustomGridCellViewInfo)
  private
    FGridViewInfo: TcxCustomGridViewInfo;
    function GetController: TcxCustomGridController;
    function GetGridView: TcxCustomGridView;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
  protected
    procedure AfterCalculateBounds(var ABounds: TRect); override;
    function EmulateMouseMoveAfterCalculate: Boolean; virtual;
    function GetCanvas: TcxCanvas; override;
    function GetControl: TcxControl; override;
    function HasMouse(AHitTest: TcxCustomGridHitTest): Boolean; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;

    function CanShowHint: Boolean; virtual;
    procedure CheckHint(AHitTest: TcxCustomGridHitTest);
    function GetBoundsForHint: TRect; virtual;
    function NeedShowHint(const AMousePos: TPoint; out AHintText: TCaption;
      out AIsHintMultiLine: Boolean; out ATextRect: TRect): Boolean; virtual;
      
    property Controller: TcxCustomGridController read GetController;
  public
    constructor Create(AGridViewInfo: TcxCustomGridViewInfo);
    destructor Destroy; override;
    procedure Invalidate; override;
    function MouseMove(AHitTest: TcxCustomGridHitTest; AShift: TShiftState): Boolean; override;
    property GridView: TcxCustomGridView read GetGridView;
    property GridViewInfo: TcxCustomGridViewInfo read FGridViewInfo;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
  end;

  TcxCustomGridViewInfoClass = class of TcxCustomGridViewInfo;

  TcxCustomGridViewInfo = class(TcxGridViewHandler)
  private
    FActiveViewInfos: TList;
    FBounds: TRect;
    FClientBounds: TRect;
    FClientBoundsAssigned: Boolean;
    FIsCalculating: Boolean;
    FIsInternalUse: Boolean;
    FLock: TRTLCriticalSection;
    FMousePos: TPoint;
    FSite: TcxGridSite;
    FSizeCalculating: Boolean;
    FVisibilityChanging: Boolean;

    function GetCalculated: Boolean;
    function GetCanvas: TcxCanvas;
    function GetClientBounds: TRect;
    function GetClientHeight: Integer;
    function GetClientWidth: Integer;
    //function GetIsCalculating: Boolean;
    function GetIsInternalUseValue: Boolean;
    procedure SetClientBounds(const Value: TRect);
  protected
    procedure CreateViewInfos; virtual;
    procedure DestroyViewInfos(AIsRecreating: Boolean); virtual;
    procedure RecreateViewInfos; virtual;

    procedure CreateSite;
    procedure DestroySite;
    function GetSiteClass: TcxGridSiteClass; virtual;
    function GetSiteParent: TWinControl;

    procedure AddActiveViewInfo(AViewInfo: TObject);
    function IsViewInfoActive(AViewInfo: TObject): Boolean;
    procedure RemoveActiveViewInfo(AViewInfo: TObject);

    procedure AddScrollBarHeight(var AHeight: Integer);
    procedure AfterCalculating; virtual;
    procedure BeforeCalculating; virtual;
    procedure Calculate; virtual;
    function CalculateClientBounds: TRect; virtual;
    procedure CalculateHeight(const AMaxSize: TPoint; var AHeight: Integer;
      var AFullyVisible: Boolean); virtual;
    procedure CalculateWidth(const AMaxSize: TPoint; var AWidth: Integer); virtual;
    procedure ControlFocusChanged; virtual;
    function GetAllowBoundsChangedNotification: Boolean; virtual;
    function GetBackgroundBitmap: TBitmap; virtual;
    function GetBackgroundColor: TColor; virtual;
    //function GetContentBounds: TRect; virtual;
    procedure GetHScrollBarBounds(var ABounds: TRect); virtual;
    function GetIsInternalUse: Boolean; virtual;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); virtual;
    procedure UpdateMousePos;
    procedure VisibilityChanged(AVisible: Boolean); virtual;

    property AllowBoundsChangedNotification: Boolean read GetAllowBoundsChangedNotification;
    property ClientBoundsAssigned: Boolean read FClientBoundsAssigned write FClientBoundsAssigned;
    property SizeCalculating: Boolean read FSizeCalculating;
    property VisibilityChanging: Boolean read FVisibilityChanging;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;
    procedure BeforeDestruction; override;
    procedure DoVisibilityChanged(AVisible: Boolean);
    function GetFontHeight(AFont: TFont): Integer;
    procedure GetHeight(const AMaxSize: TPoint; var AHeight: Integer;
      var AFullyVisible: Boolean);
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; overload; virtual;
    function GetHitTest(X, Y: Integer): TcxCustomGridHitTest; overload; virtual;
    procedure GetWidth(const AMaxSize: TPoint; var AWidth: Integer);
    procedure MainCalculate(const ABounds: TRect);
    procedure Recalculate;

    property BackgroundColor: TColor read GetBackgroundColor;
    property BackgroundBitmap: TBitmap read GetBackgroundBitmap;
    property Bounds: TRect read FBounds;
    property Calculated: Boolean read GetCalculated;
    property Canvas: TcxCanvas read GetCanvas;
    property ClientBounds: TRect read GetClientBounds write SetClientBounds;
    property ClientHeight: Integer read GetClientHeight;
    property ClientWidth: Integer read GetClientWidth;
    //property ContentBounds: TRect read GetContentBounds;
    property IsCalculating: Boolean read FIsCalculating;
    property IsInternalUse: Boolean read GetIsInternalUseValue write FIsInternalUse;
    property MousePos: TPoint read FMousePos;
    property Site: TcxGridSite read FSite;
  end;

  TcxCustomGridViewInfoCacheItemClass = class of TcxCustomGridViewInfoCacheItem;

  TcxCustomGridViewInfoCacheItem = class
  private
    FIndex: Integer;
    FOwner: TcxCustomGridViewInfoCache;
  protected
    property Index: Integer read FIndex;
    property Owner: TcxCustomGridViewInfoCache read FOwner;
  public
    constructor Create(AOwner: TcxCustomGridViewInfoCache; AIndex: Integer); virtual;
    procedure UnassignValues(AKeepMaster: Boolean); virtual;
  end;

  TcxCustomGridViewInfoCacheClass = class of TcxCustomGridViewInfoCache;

  TcxCustomGridViewInfoCache = class(TcxGridViewHandler)
  private
    FItems: TList;
    FUnassigningValues: Boolean;
    function GetCount: Integer;
    function GetInternalItem(Index: Integer): TcxCustomGridViewInfoCacheItem;
    function GetItem(Index: Integer): TcxCustomGridViewInfoCacheItem;
    procedure SetCount(Value: Integer);
    procedure DestroyItems;
  protected
    function GetItemClass: TcxCustomGridViewInfoCacheItemClass; virtual;
    property InternalItems[Index: Integer]: TcxCustomGridViewInfoCacheItem read GetInternalItem;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;
    procedure UnassignValues(AKeepMaster: Boolean = False); virtual;
    property Count: Integer read GetCount write SetCount;
    property Items[Index: Integer]: TcxCustomGridViewInfoCacheItem read GetItem; default;
  end;

  { custom view }

  TcxCustomGridOptions = class(TPersistent)
  private
    FGridView: TcxCustomGridView;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
  protected
    procedure LayoutChanged;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); virtual;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
  public
    constructor Create(AGridView: TcxCustomGridView); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property GridView: TcxCustomGridView read FGridView;
  end;

  {4}
  TcxCustomGridBackgroundBitmapsClass = class of TcxCustomGridBackgroundBitmaps;

  TcxCustomGridBackgroundBitmaps = class(TcxCustomGridOptions)
  private
    FItems: TList;
    function GetCount: Integer;
    procedure BitmapChanged(Sender: TObject);
  protected
    function GetBitmapStyleIndex(Index: Integer): Integer; virtual;
    function GetDefaultBitmap(Index: Integer): TBitmap; virtual;
    function GetValue(Index: Integer): TBitmap;
    procedure SetValue(Index: Integer; Value: TBitmap);
    property Count: Integer read GetCount;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetBitmap(Index: Integer): TBitmap; virtual;
    property Values[Index: Integer]: TBitmap read GetValue write SetValue; default;
  published
    property Background: TBitmap index bbBackground read GetValue write SetValue;
  end;

  TcxCustomGridOptionsSelectionClass = class of TcxCustomGridOptionsSelection;

  TcxCustomGridOptionsSelection = class(TcxCustomGridOptions);

  TcxCustomGridOptionsViewClass = class of TcxCustomGridOptionsView;

  TcxCustomGridOptionsView = class(TcxCustomGridOptions)
  private
    function GetScrollBars: TScrollStyle;
    procedure SetScrollBars(Value: TScrollStyle);
  public
    procedure Assign(Source: TPersistent); override;
  published
    property ScrollBars: TScrollStyle read GetScrollBars write SetScrollBars default ssBoth;
  end;

  TcxCustomGridStyles = class(TcxStyles)
  private
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
  protected
    procedure Changed(AIndex: Integer); override;
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
    procedure GetFakeComponentLinks(AList: TList); virtual;
    function GetGridView: TcxCustomGridView; virtual; abstract;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
  public
    property GridView: TcxCustomGridView read GetGridView;
  end;

  TcxCustomGridViewStylesClass = class of TcxCustomGridViewStyles;

  TcxCustomGridViewStyles = class(TcxCustomGridStyles)
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
    function GetGridView: TcxCustomGridView; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Background: TcxStyle index vsBackground read GetValue write SetValue;
    property StyleSheet;
  end;

  TcxGridStorageOption = (gsoUseFilter, gsoUseSummary);
  TcxGridStorageOptions = set of TcxGridStorageOption;
  TcxGridViewChangeKind = (vcName{, vsRemoved});

  TcxGridCellCustomDrawEvent = procedure(Sender: TcxCustomGridView; ACanvas: TcxCanvas;
    AViewInfo: TcxCustomGridCellViewInfo; var ADone: Boolean) of object;

  TcxCustomGridViewClass = class of TcxCustomGridView;

  TcxCustomGridView = class(TcxControlChildComponent, IcxStoredObject, IcxStoredParent)
  private
    FAssigningPattern: Boolean;
    FBackgroundBitmaps: TcxCustomGridBackgroundBitmaps;
    FClones: TList;
    FController: TcxCustomGridController;
    FDataController: TcxCustomDataController;
    FLevel: TComponent;
    FListenerLinks: TList;
    FOptionsList: TList;
    FOptionsSelection: TcxCustomGridOptionsSelection;
    FOptionsView: TcxCustomGridOptionsView;
    FPainter: TcxCustomGridPainter;
    FPatternGridView: TcxCustomGridView;
    FRepository: TComponent;  {5}
    FStorageControl: TcxControl;
    FStorageOptions: TcxGridStorageOptions;
    FStoringName: string;
    FStyles: TcxCustomGridStyles;
    FViewData: TcxCustomGridViewData;
    FViewInfo: TcxCustomGridViewInfo;
    FViewInfoCache: TcxCustomGridViewInfoCache;
    FSubClassEvents: TNotifyEvent;

    function GetClone(Index: Integer): TcxCustomGridView;
    function GetCloneCount: Integer;
    function GetDragMode: TDragMode;
    function GetFocused: Boolean;
    function GetIsDetail: Boolean;
    function GetIsMaster: Boolean;
    function GetIsPattern: Boolean;
    function GetIsStoringNameMode: Boolean;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
    function GetMasterGridView: TcxCustomGridView;
    function GetMasterGridRecordIndex: Integer;
    function GetMasterRecordIndex: Integer;
    function GetOnDblClick: TNotifyEvent;
    function GetOnDragDrop: TDragDropEvent;
    function GetOnDragOver: TDragOverEvent;
    function GetOnEndDrag: TEndDragEvent;
    function GetOnKeyDown: TKeyEvent;
    function GetOnKeyPress: TKeyPressEvent;
    function GetOnKeyUp: TKeyEvent;
    function GetOnMouseDown: TMouseEvent;
    function GetOnMouseMove: TMouseMoveEvent;
    function GetOnMouseUp: TMouseEvent;
    function GetOnMouseWheel: TMouseWheelEvent;
    function GetOnMouseWheelDown: TMouseWheelUpDownEvent;
    function GetOnMouseWheelUp: TMouseWheelUpDownEvent;
    function GetOnStartDrag: TStartDragEvent;
    function GetPatternGridView: TcxCustomGridView;
    function GetSite: TcxGridSite;
    procedure SetBackgroundBitmaps(Value: TcxCustomGridBackgroundBitmaps);
    procedure SetDragMode(Value: TDragMode);
    procedure SetFocused(Value: Boolean);
    procedure SetOnDblClick(Value: TNotifyEvent);
    procedure SetOnDragDrop(Value: TDragDropEvent);
    procedure SetOnDragOver(Value: TDragOverEvent);
    procedure SetOnEndDrag(Value: TEndDragEvent);
    procedure SetOnKeyDown(Value: TKeyEvent);
    procedure SetOnKeyPress(Value: TKeyPressEvent);
    procedure SetOnKeyUp(Value: TKeyEvent);
    procedure SetOnMouseDown(Value: TMouseEvent);
    procedure SetOnMouseMove(Value: TMouseMoveEvent);
    procedure SetOnMouseUp(Value: TMouseEvent);
    procedure SetOnMouseWheel(Value: TMouseWheelEvent);
    procedure SetOnMouseWheelDown(Value: TMouseWheelUpDownEvent);
    procedure SetOnMouseWheelUp(Value: TMouseWheelUpDownEvent);
    procedure SetOnStartDrag(Value: TStartDragEvent);
    procedure SetOptionsSelection(Value: TcxCustomGridOptionsSelection);
    procedure SetOptionsView(Value: TcxCustomGridOptionsView);
    procedure SetStyles(Value: TcxCustomGridStyles);

    procedure ClearListenerLinks;
  protected
    // IcxStoredObject
    function GetObjectName: string; virtual;
    function GetProperties(AProperties: TStrings): Boolean; virtual;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); virtual;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); virtual;
    // IcxStoredParent
    function CreateChild(const AObjectName, AClassName: string): TObject; virtual;
    procedure DeleteChild(const AObjectName: string; AObject: TObject); virtual;
    procedure IcxStoredParent.GetChildren = GetStoredChildren;
    procedure GetStoredChildren(AChildren: TStringList); virtual;

    procedure GetFakeComponentLinks(AList: TList); override;
    function GetIsDestroying: Boolean; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetControl(Value: TcxControl); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure Updated; override;
    procedure Updating; override;

    procedure CreateHandlers; virtual;
    procedure DestroyHandlers; virtual;
    procedure InitDataController; virtual;

    procedure CreateOptions; virtual;
    procedure DestroyOptions; virtual;

    procedure AddOptions(AOptions: TcxCustomGridOptions);
    procedure RemoveOptions(AOptions: TcxCustomGridOptions);
    procedure NotifyOptions(AComponent: TComponent; AOperation: TOperation);

    procedure AddClone(AClone: TcxCustomGridView);
    procedure RemoveClone(AClone: TcxCustomGridView);

    procedure AddListenerLink(ALink: Pointer);
    procedure RemoveListenerLink(ALink: Pointer);

    procedure AssignPattern(APattern: TcxCustomGridView);

    procedure BeforeAssign(ASource: TcxCustomGridView); virtual;
    procedure DoAssign(ASource: TcxCustomGridView); virtual;
    procedure AfterAssign(ASource: TcxCustomGridView); virtual;

    //procedure BeforeLevelChange; virtual;
    function CanFocus: Boolean; virtual;
    function CanTabStop: Boolean; virtual;
    procedure DetailVisibleChanged(ADetailLevel: TComponent;
      APrevVisibleDetailCount, AVisibleDetailCount: Integer); virtual;
    function GetChangeable: Boolean; virtual;
    function GetCustomVisible(ALevelVisible: Boolean): Boolean; virtual;
    function GetIsControlFocused: Boolean; virtual;
    function GetResizeOnBoundsChange: Boolean; virtual;
    function GetVisible: Boolean; virtual;
    procedure Init; virtual;
    function IsDetailVisible(AGridView: TcxCustomGridView): Boolean; virtual;
    procedure FocusChanged(AFocused: Boolean); virtual;
    procedure LoadingComplete; virtual;
    procedure LookAndFeelChanged; virtual;
    procedure NotifyControl(AChangeKind: TcxGridViewChangeKind);
    procedure RestoringComplete; virtual;
    procedure SetLevel(Value: TComponent); virtual;
    procedure SetTabStop(Value: Boolean); virtual;
    procedure UpdateControl(AInfo: TcxUpdateControlInfo); virtual;

    function GetControllerClass: TcxCustomGridControllerClass; virtual; abstract;
    function GetDataControllerClass: TcxCustomDataControllerClass; virtual; abstract;
    function GetPainterClass: TcxCustomGridPainterClass; virtual; abstract;
    function GetViewDataClass: TcxCustomGridViewDataClass; virtual; abstract;
    function GetViewInfoCacheClass: TcxCustomGridViewInfoCacheClass; virtual;
    function GetViewInfoClass: TcxCustomGridViewInfoClass; virtual; abstract;

    function GetBackgroundBitmapsClass: TcxCustomGridBackgroundBitmapsClass; virtual;
    function GetOptionsSelectionClass: TcxCustomGridOptionsSelectionClass; virtual;
    function GetOptionsViewClass: TcxCustomGridOptionsViewClass; virtual;
    function GetStylesClass: TcxCustomGridViewStylesClass; virtual;

    property AssigningPattern: Boolean read FAssigningPattern;
    property BackgroundBitmaps: TcxCustomGridBackgroundBitmaps read FBackgroundBitmaps
      write SetBackgroundBitmaps;  {4}
    property Changeable: Boolean read GetChangeable;
    property IsStoringNameMode: Boolean read GetIsStoringNameMode;
    property OptionsSelection: TcxCustomGridOptionsSelection read FOptionsSelection
      write SetOptionsSelection;
    property OptionsView: TcxCustomGridOptionsView read FOptionsView write SetOptionsView;
    property ResizeOnBoundsChange: Boolean read GetResizeOnBoundsChange;
    property Styles: TcxCustomGridStyles read FStyles write SetStyles;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    function HasAsClone(AGridView: TcxCustomGridView): Boolean;
    function HasAsMaster(AGridView: TcxCustomGridView): Boolean;
    procedure Invalidate(AHardUpdate: Boolean = False);
    procedure RestoreDefaults; virtual;
    procedure SetParentComponent(Value: TComponent); override;

    procedure BeginUpdate;
    procedure CancelUpdate;
    function Changed(AGridChange: TObject): Boolean;
    procedure EndUpdate;

    procedure BoundsChanged(AUpdateSelfOnly: Boolean = False; AKeepMaster: Boolean = False); virtual;
    procedure LayoutChanged(AUpdateSelfOnly: Boolean = True);
    function SizeChanged(AUpdateSelfOnly: Boolean = False; AKeepMaster: Boolean = False): Boolean;
    procedure ViewChanged; overload;
    procedure ViewChanged(const AUpdateRect: TRect); overload;

    procedure RestoreFromIniFile(AStorageName: string; AChildrenCreating: Boolean = False;
      AChildrenDeleting: Boolean = False; AOptions: TcxGridStorageOptions = [];
      const ARestoreViewName: string = '');
    procedure RestoreFromRegistry(AStorageName: string; AChildrenCreating: Boolean = False;
      AChildrenDeleting: Boolean = False; AOptions: TcxGridStorageOptions = [];
      const ARestoreViewName: string = '');
    procedure RestoreFromStream(AStream: TStream; AChildrenCreating: Boolean = False;
      AChildrenDeleting: Boolean = False; AOptions: TcxGridStorageOptions = [];
      const ARestoreViewName: string = '');
    procedure StoreToIniFile(AStorageName: string; AReCreate: Boolean = True;
      AOptions: TcxGridStorageOptions = []; const ASaveViewName: string = '');
    procedure StoreToRegistry(AStorageName: string; AReCreate: Boolean = True;
      AOptions: TcxGridStorageOptions = []; const ASaveViewName: string = '');
    procedure StoreToStream(AStream: TStream; AOptions: TcxGridStorageOptions = [];
      const ASaveViewName: string = '');

    property Focused: Boolean read GetFocused write SetFocused;
    property StorageOptions: TcxGridStorageOptions read FStorageOptions write FStorageOptions;
    property StoringName: string read FStoringName write FStoringName;
    property TabStop: Boolean write SetTabStop;

    property CloneCount: Integer read GetCloneCount;
    property Clones[Index: Integer]: TcxCustomGridView read GetClone;
    property IsControlFocused: Boolean read GetIsControlFocused;
    property IsDetail: Boolean read GetIsDetail;
    property IsMaster: Boolean read GetIsMaster;
    property IsPattern: Boolean read GetIsPattern;
    property Level: TComponent read FLevel;  // TcxGridLevel
    property MasterGridView: TcxCustomGridView read GetMasterGridView;
    property MasterGridRecordIndex: Integer read GetMasterGridRecordIndex;
    property MasterRecordIndex: Integer read GetMasterRecordIndex;
    property PatternGridView: TcxCustomGridView read GetPatternGridView;
    property Repository: TComponent read FRepository write FRepository;  {5}

    property Controller: TcxCustomGridController read FController;
    property DataController: TcxCustomDataController read FDataController;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
    property Painter: TcxCustomGridPainter read FPainter;
    property Site: TcxGridSite read GetSite;
    property StorageControl: TcxControl read FStorageControl;
    property ViewData: TcxCustomGridViewData read FViewData;
    property ViewInfo: TcxCustomGridViewInfo read FViewInfo;
    property ViewInfoCache: TcxCustomGridViewInfoCache read FViewInfoCache;
    property Visible: Boolean read GetVisible;
  published
    property DataControllerEvents: TNotifyEvent read FSubClassEvents write FSubClassEvents;
    property DragMode: TDragMode read GetDragMode write SetDragMode default dmManual;
    property StylesEvents: TNotifyEvent read FSubClassEvents write FSubClassEvents;
    property OnDblClick: TNotifyEvent read GetOnDblClick write SetOnDblClick;
    property OnDragDrop: TDragDropEvent read GetOnDragDrop write SetOnDragDrop;
    property OnDragOver: TDragOverEvent read GetOnDragOver write SetOnDragOver;
    property OnEndDrag: TEndDragEvent read GetOnEndDrag write SetOnEndDrag;
    property OnKeyDown: TKeyEvent read GetOnKeyDown write SetOnKeyDown;
    property OnKeyPress: TKeyPressEvent read GetOnKeyPress write SetOnKeyPress;
    property OnKeyUp: TKeyEvent read GetOnKeyUp write SetOnKeyUp;
    property OnMouseDown: TMouseEvent read GetOnMouseDown write SetOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read GetOnMouseMove write SetOnMouseMove;
    property OnMouseUp: TMouseEvent read GetOnMouseUp write SetOnMouseUp;
    property OnMouseWheel: TMouseWheelEvent read GetOnMouseWheel write SetOnMouseWheel;
    property OnMouseWheelDown: TMouseWheelUpDownEvent read GetOnMouseWheelDown write SetOnMouseWheelDown;
    property OnMouseWheelUp: TMouseWheelUpDownEvent read GetOnMouseWheelUp write SetOnMouseWheelUp;
    property OnStartDrag: TStartDragEvent read GetOnStartDrag write SetOnStartDrag;
  end;

var
  cxGridRegisteredViews: TcxRegisteredClasses;

function GetParentGridView(AControl: TControl): TcxCustomGridView;

implementation

uses
  SysUtils, cxGrid, cxGridLevel;

type
{$IFNDEF DELPHI6}
  PPointer = ^Pointer;
{$ENDIF}
  THintWindowAccess = class(THintWindow);
  TcxCustomGridAccess = class(TcxCustomGrid);
  TcxGridViewRepositoryAccess = class(TcxGridViewRepository);

{ TGridHitTests }

type
  TGridHitTests = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetInstance(AClass: TcxCustomGridHitTestClass): TcxCustomGridHitTest;
    function GetItem(Index: Integer): TcxCustomGridHitTest;
  protected
    function GetObjectByClass(AClass: TcxCustomGridHitTestClass): TcxCustomGridHitTest;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxCustomGridHitTest read GetItem;
  public
    constructor Create;
    destructor Destroy; override;
    property Instances[AClass: TcxCustomGridHitTestClass]: TcxCustomGridHitTest read GetInstance; default;
  end;

var
  GridHitTests: TGridHitTests;

constructor TGridHitTests.Create;
begin
  inherited;
  FItems := TList.Create;
end;

destructor TGridHitTests.Destroy;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].Free;
  FItems.Free;
  inherited;
end;

function TGridHitTests.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TGridHitTests.GetInstance(AClass: TcxCustomGridHitTestClass): TcxCustomGridHitTest;
begin
  Result := GetObjectByClass(AClass);
  if Result = nil then
  begin
    Result := AClass.Create;
    FItems.Add(Result);
  end;  
end;

function TGridHitTests.GetItem(Index: Integer): TcxCustomGridHitTest;
begin
  Result := FItems[Index];
end;

function TGridHitTests.GetObjectByClass(AClass: TcxCustomGridHitTestClass): TcxCustomGridHitTest;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I];
    if Result.ClassType = AClass then Exit;
  end;
  Result := nil;
end;

{ TcxCustomGridViewChange }

constructor TcxCustomGridViewChange.Create(AGridView: TcxCustomGridView);
begin
  inherited Create;
  FGridView := AGridView;
end;

function TcxCustomGridViewChange.IsEqual(AChange: TcxCustomGridChange): Boolean;
begin
  Result := inherited IsEqual(AChange) and
    (FGridView = TcxCustomGridViewChange(AChange).GridView);
end;

{ TcxGridControlFocusChange }

procedure TcxGridControlFocusChange.Execute;
begin
  if GridView.Changeable then
    GridView.Controller.ControlFocusChanged;
end;

{ TcxCustomGridHitTest }

class function TcxCustomGridHitTest.GetHitTestCode: Integer;
begin
  Result := htError;
end;

procedure TcxCustomGridHitTest.Init(const APos: TPoint);
begin
  FPos := APos;
end;

class function TcxCustomGridHitTest.Cursor: TCursor;
begin
  Result := crDefault;
end;

function TcxCustomGridHitTest.DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass;
begin
  Result := nil;
end;

class function TcxCustomGridHitTest.HitTestCode: Integer;
begin
  Result := GetHitTestCode;
end;

class function TcxCustomGridHitTest.Instance(const APos: TPoint): TcxCustomGridHitTest;
begin
  Result := GridHitTests.Instances[Self];
  Result.Init(APos);
end;

{ TcxGridHitTestNone }

class function TcxGridNoneHitTest.GetHitTestCode: Integer;
begin
  Result := htNone;
end;

{ TcxGridViewNoneHitTest }

class function TcxGridViewNoneHitTest.GetHitTestCode: Integer;
begin
  Result := htNone;
end;

{ TcxGridViewHandler }

constructor TcxGridViewHandler.Create(AGridView: TcxCustomGridView);
begin
  inherited Create(nil);
  FGridView := AGridView;
end;

function TcxGridViewHandler.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := FGridView.LookAndFeelPainter;
end;

function TcxGridViewHandler.GetControl: TcxControl;
begin
  Result := FGridView.Control;
end;

function TcxGridViewHandler.GetController: TcxCustomGridController;
begin
  Result := FGridView.Controller;
end;

function TcxGridViewHandler.GetDataController: TcxCustomDataController;
begin
  Result := FGridView.DataController;
end;

function TcxGridViewHandler.GetPainter: TcxCustomGridPainter;
begin
  Result := FGridView.Painter;
end;

function TcxGridViewHandler.GetSite: TcxGridSite;
begin
  Result := FGridView.Site;
end;

function TcxGridViewHandler.GetViewData: TcxCustomGridViewData;
begin
  Result := FGridView.ViewData;
end;

function TcxGridViewHandler.GetViewInfo: TcxCustomGridViewInfo;
begin
  Result := FGridView.ViewInfo;
end;

procedure TcxGridViewHandler.BeginUpdate;
begin
  FGridView.BeginUpdate;
end;

procedure TcxGridViewHandler.EndUpdate;
begin
  FGridView.EndUpdate;
end;

{ TcxCustomGridDragAndDropObject }

function TcxCustomGridDragAndDropObject.GetController: TcxCustomGridController;
begin
  Result := GridView.Controller;
end;

function TcxCustomGridDragAndDropObject.GetGridView: TcxCustomGridView;
begin
  Result := TcxGridSite(Control).GridView;
end;

function TcxCustomGridDragAndDropObject.GetViewInfo: TcxCustomGridViewInfo;
begin
  Result := GridView.ViewInfo;
end;

procedure TcxCustomGridDragAndDropObject.AfterDragAndDrop(Accepted: Boolean);
begin
  inherited;
  if Accepted then Controller.DesignerModified;
end;

procedure TcxCustomGridDragAndDropObject.AfterPaint;
begin
  Dirty := False;
end;

procedure TcxCustomGridDragAndDropObject.BeforePaint;
begin
  Dirty := True;
end;

procedure TcxCustomGridDragAndDropObject.Init(const P: TPoint; AParams: TcxCustomGridHitTest);
begin
  SourcePoint := P;
end;

{ TcxCustomGridController }

destructor TcxCustomGridController.Destroy;
begin
  HideHint;
  inherited;
end;

function TcxCustomGridController.GetDragAndDropObject: TcxCustomGridDragAndDropObject;
begin
  Result := Site.DragAndDropObject as TcxCustomGridDragAndDropObject;
end;

function TcxCustomGridController.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  Result := Site.DragAndDropObjectClass;
end;

function TcxCustomGridController.GetIsDragging: Boolean;
begin
  Result := Site.DragAndDropState = ddsInProcess;
end;

function TcxCustomGridController.GetMouseCaptureViewInfo: TcxCustomGridCellViewInfo;
begin
  if Site.MouseCaptureObject is TcxCustomGridCellViewInfo then
    Result := TcxCustomGridCellViewInfo(Site.MouseCaptureObject)
  else
    Result := nil;
end;

procedure TcxCustomGridController.SetDragAndDropObjectClass(Value: TcxDragAndDropObjectClass);
begin
  Site.DragAndDropObjectClass := Value;
end;

procedure TcxCustomGridController.SetMouseCaptureViewInfo(Value: TcxCustomGridCellViewInfo);
begin
  Site.MouseCaptureObject := Value;
end;

procedure TcxCustomGridController.MouseLeave;
begin
  HideHint;
end;

procedure TcxCustomGridController.AfterPaint;
begin
  if IsDragging then
    DragAndDropObject.AfterPaint;
end;

procedure TcxCustomGridController.BeforeKillFocus;
begin
end;

procedure TcxCustomGridController.BeforePaint;
begin
  if IsDragging then
    DragAndDropObject.BeforePaint;
end;

function TcxCustomGridController.CanHandleHitTest(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := not (AHitTest is TcxCustomGridViewHitTest) or
    (TcxCustomGridViewHitTest(AHitTest).GridView = FGridView);
end;

procedure TcxCustomGridController.DetailFocused(ADetail: TcxCustomGridView);
begin
end;

procedure TcxCustomGridController.DoEnter;
begin
end;

procedure TcxCustomGridController.DoExit;
begin
end;

function TcxCustomGridController.GetDesignHitTest(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := AHitTest.DragAndDropObjectClass <> nil;
end;

function TcxCustomGridController.GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind;
begin
  Result := mwskNone;
end;

function TcxCustomGridController.IsPixelScrollBar(AKind: TScrollBarKind): Boolean;
begin
  Result := False;
end;

function TcxCustomGridController.MayFocus: Boolean;
begin
  Result := True;
end;

procedure TcxCustomGridController.RemoveFocus;
begin
  BeforeKillFocus;
  GridView.TabStop := False;
  if not GridView.Visible then
  begin
    Site.Parent := nil;
  end;  
end;

procedure TcxCustomGridController.SetFocus;
begin
  GridView.TabStop := True;
  ViewInfo.DoVisibilityChanged(True);
  if Control.IsFocused and Site.CanFocusEx then
    Site.SetFocus;
  with GridView do
    if IsDetail then
      MasterGridView.Controller.DetailFocused(GridView);
end;

procedure TcxCustomGridController.ControlFocusChanged;
begin
  ViewInfo.ControlFocusChanged;
end;

procedure TcxCustomGridController.DesignerModified;
begin
  Site.Modified;
end;

procedure TcxCustomGridController.DoCancelMode;
begin
end;

procedure TcxCustomGridController.DoControlFocusChanged;
begin                                       
  GridView.Changed(TcxGridControlFocusChange.Create(GridView));
end;

function TcxCustomGridController.GetCursor(X, Y: Integer): TCursor;
var
  AHitTest: TcxCustomGridHitTest;
begin
  AHitTest := ViewInfo.GetHitTest(Point(X, Y));
  if CanHandleHitTest(AHitTest) then
    Result := AHitTest.Cursor
  else
    Result := TcxGridViewNoneHitTest.Cursor;
end;

function TcxCustomGridController.HasFocusedControls: Boolean;
begin
  Result := False;
end;

{function TcxCustomGridController.CanDrag(X, Y: Integer): Boolean;
begin
  Result := False;
end;

function TcxCustomGridController.GetDragObjectClass: TDragControlObjectClass;
begin
  Result := TcxDragControlObject;
end;}

procedure TcxCustomGridController.InitScrollBarsParameters;
begin
end;

function TcxCustomGridController.IsDataFullyVisible(AIsCallFromMaster: Boolean = False): Boolean;
begin
  Result := True;
end;

procedure TcxCustomGridController.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
end;

procedure TcxCustomGridController.SetScrollBarInfo(AScrollBarKind: TScrollBarKind;
  AMin, AMax, AStep, APage, APos: Integer; AAllowShow, AAllowHide: Boolean);
begin
  Site.SetScrollBarInfo(AScrollBarKind, AMin, AMax, AStep, APage, APos, AAllowShow, AAllowHide);
end;

procedure TcxCustomGridController.UpdateScrollBars;
begin
  Site.UpdateScrollBars;
end;

procedure TcxCustomGridController.BeginDragAndDrop;
begin
end;

procedure TcxCustomGridController.DragAndDrop(const P: TPoint; var Accepted: Boolean);
begin
end;

procedure TcxCustomGridController.EndDragAndDrop(Accepted: Boolean);
begin
end;

function TcxCustomGridController.StartDragAndDrop(const P: TPoint): Boolean;
var
  AHitTest: TcxCustomGridHitTest;
begin
  AHitTest := ViewInfo.GetHitTest(P);
  Result := CanHandleHitTest(AHitTest);
  if Result then
  begin
    Result := AHitTest.DragAndDropObjectClass <> nil;
    if Result then
    begin
      DragAndDropObjectClass := AHitTest.DragAndDropObjectClass;
      DragAndDropObject.Init(P, AHitTest);
    end;
  end;
end;

procedure TcxCustomGridController.BeforeStartDrag;
begin
end;

function TcxCustomGridController.CanDrag(X, Y: Integer): Boolean;
begin
  Result := True;
end;

procedure TcxCustomGridController.DragDrop(Source: TObject; X, Y: Integer);
begin
end;

procedure TcxCustomGridController.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
end;

procedure TcxCustomGridController.EndDrag(Target: TObject; X, Y: Integer);
begin
end;

procedure TcxCustomGridController.StartDrag(var DragObject: TDragObject);
begin
end;

procedure TcxCustomGridController.HideHint;
begin
  EndMouseTracking(Self);
  FreeAndNil(FHintWindow);
end;

function TcxCustomGridController.GetHintWindowClass: THintWindowClass;
begin
  Result := HintWindowClass;
end;

procedure TcxCustomGridController.ShowHint(const AHintAreaBounds, ATextRect: TRect;
 const AText: string; AIsHintMultiLine: Boolean; AFont: TFont);

  function GetHintWindowRect: TRect;

    function GetMaxTextWidth: Integer;
    begin
      if AIsHintMultiLine then
        Result := ATextRect.Right - ATextRect.Left
      else
        Result := MaxInt div 20;
    end;

    function GetTextRectOffset: TPoint;
    const
      TextOffset: TPoint = (X: 2; Y: 2);
    begin
      with FHintWindow, ClientToScreen(Point(0, 0)) do
      begin
        Result.X := X - Left + TextOffset.X;
        Result.Y := Y - Top + TextOffset.Y;
      end;
    end;

    procedure CheckBoundsOnDesktop;
    var
      R: TRect;
    begin
      R := GetDesktopWorkArea(Result.TopLeft);
      with Result do
      begin
        if Right > R.Right then
          OffsetRect(Result, R.Right - Right, 0);
        if Bottom > R.Bottom then
          OffsetRect(Result, 0, R.Bottom - Bottom);
        if Left < R.Left then
          OffsetRect(Result, R.Left - Left, 0);
        if Top < R.Top then
          OffsetRect(Result, 0, R.Top - Top);
      end;
    end;

  begin
    Result := FHintWindow.CalcHintRect(GetMaxTextWidth, AText, nil);
    with Result do
    begin
      Inc(Right, -6);
      Inc(Bottom, -2);
    end;
    with Site.ClientToScreen(ATextRect.TopLeft) do
      OffsetRect(Result, X, Y);
    with GetTextRectOffset do
      InflateRect(Result, X, Y);
    CheckBoundsOnDesktop;
    Dec(Result.Bottom, 4);
  end;

begin
  if FHintWindow = nil then
  begin
    FHintWindow := GetHintWindowClass.Create(nil);
    FHintWindow.Color := Application.HintColor;
  end
  else
  begin
    if (THintWindowAccess(FHintWindow).Caption = AText) and
      CompareMem(@FHintTextRect, @ATextRect, SizeOf(TRect)) then
      Exit;
    EndMouseTracking(Self);
  end;
  FHintTextRect := ATextRect;
  THintWindowAccess(FHintWindow).Canvas.Font := AFont;
  FHintWindow.ActivateHint(GetHintWindowRect, AText);
  BeginMouseTracking(Site, AHintAreaBounds, Self);
end;

procedure TcxCustomGridController.DoKeyDown(var Key: Word; Shift: TShiftState);
begin
  KeyDown(Key, Shift);
end;

procedure TcxCustomGridController.KeyDown(var Key: Word; Shift: TShiftState);
begin
end;

procedure TcxCustomGridController.KeyPress(var Key: Char);
begin
end;

procedure TcxCustomGridController.KeyUp(var Key: Word; Shift: TShiftState);
begin
end;

procedure TcxCustomGridController.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
begin
  FIsDblClick := ssDouble in Shift;
  AHitTest := ViewInfo.GetHitTest(X, Y);
  if AHitTest.ViewInfo <> nil then
    AHitTest.ViewInfo.MouseDown(AHitTest, Button, Shift);
end;

procedure TcxCustomGridController.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
begin                      
  AHitTest := ViewInfo.GetHitTest(X, Y);
  if MouseCaptureViewInfo <> nil then
    MouseCaptureViewInfo.MouseMove(AHitTest, Shift)
  else
    if AHitTest.ViewInfo <> nil then
      AHitTest.ViewInfo.MouseMove(AHitTest, Shift);
end;

procedure TcxCustomGridController.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
begin
  AHitTest := ViewInfo.GetHitTest(X, Y);
  if MouseCaptureViewInfo <> nil then
    MouseCaptureViewInfo.MouseUp(AHitTest, Button, Shift)
  else
    if AHitTest.ViewInfo <> nil then
      AHitTest.ViewInfo.MouseUp(AHitTest, Button, Shift);
end;

procedure TcxCustomGridController.WndProc(var Message: TMessage);
begin
end;

{procedure TcxCustomGridController.BeginCellMouseTracking(AViewInfo: TcxCustomGridCellViewInfo);
begin
  BeginMouseTracking(Site, AViewInfo.Bounds, AViewInfo);
end;

procedure TcxCustomGridController.EndCellMouseTracking(AViewInfo: TcxCustomGridCellViewInfo);
begin
  EndMouseTracking(AViewInfo);
end;}

{ TcxCustomGridCellPainter }

constructor TcxCustomGridCellPainter.Create(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomGridCellViewInfo);
begin
  inherited Create;
  FCanvas := ACanvas;
  FViewInfo := AViewInfo;
end;

function TcxCustomGridCellPainter.GetIsMainCanvasInUse: Boolean;
begin
  Result := FCanvas = FViewInfo.Canvas;
end;

procedure TcxCustomGridCellPainter.AfterPaint;
begin
end;

procedure TcxCustomGridCellPainter.BeforePaint;
begin
end;

procedure TcxCustomGridCellPainter.DrawBackground;
begin  {4}
  with Canvas, ViewInfo do
    if not Transparent then
    begin
      Brush.Color := Params.Color;
      FillRect(ContentBounds);
    end
    else
      if BackgroundBitmap <> nil then
        FillRect(ContentBounds, BackgroundBitmap)
end;

function TcxCustomGridCellPainter.DrawBackgroundHandler(ACanvas: TcxCanvas;
  const ABounds: TRect): Boolean;
begin  {4}
  Result := ViewInfo.BackgroundBitmap <> nil;
  if Result then
    ACanvas.FillRect(ABounds, ViewInfo.BackgroundBitmap);
end;

procedure TcxCustomGridCellPainter.DrawBorder(ABorder: TcxBorder);
begin
  with Canvas do
  begin
    SetBrushColor(ViewInfo.BorderColor[ABorder]);
    FillRect(ViewInfo.BorderBounds[ABorder]);
  end;
end;

procedure TcxCustomGridCellPainter.DrawBorders;
var
  ABorder: TcxBorder;
begin
  for ABorder := Low(ABorder) to High(ABorder) do
    if ABorder in ViewInfo.Borders then
      DrawBorder(ABorder);
end;

procedure TcxCustomGridCellPainter.DrawContent;
{var
  R: TRect;}
begin
  if not ViewInfo.DoCustomDrawBackground(Canvas) then
    DrawBackground;
  DrawText;
  {with Canvas, ViewInfo do
    if Text <> '' then
    begin
      R := TextAreaBounds;  // can call font change
      Font := Params.Font;
      Font.Color := Params.TextColor;
      Brush.Style := bsClear;
      DrawText(Text, R, GetTextAttributes);
      Brush.Style := bsSolid;
    end;}
end;

procedure TcxCustomGridCellPainter.DrawText;
var
  R: TRect;
begin
  with Canvas, ViewInfo do
    if Text <> '' then
    begin
      R := TextAreaBounds;  // can call font change
      Font := Params.Font;
      Font.Color := Params.TextColor;
      Brush.Style := bsClear;
      DrawText(Text, R, GetTextAttributes(True));
      Brush.Style := bsSolid;
    end;
end;

function TcxCustomGridCellPainter.ExcludeFromClipRect: Boolean;
begin
  Result := False;
end;

function TcxCustomGridCellPainter.NeedsPainting: Boolean;
begin
  Result := Canvas.RectVisible(ViewInfo.Bounds);
end;

procedure TcxCustomGridCellPainter.Paint;
var
  ASavedParams: TcxViewParams;
begin
  ViewInfo.SaveParams(ASavedParams);
  try
    if not ViewInfo.DoCustomDraw(Canvas) then
      DrawContent;
  finally
    ViewInfo.RestoreParams(ASavedParams);
  end;
  DrawBorders;
end;

procedure TcxCustomGridCellPainter.MainPaint;
begin
  if not NeedsPainting then Exit;
  BeforePaint;
  Paint;
  AfterPaint;
  if ExcludeFromClipRect then
    Canvas.ExcludeClipRect(ViewInfo.Bounds);
end;

{ TcxCustomGridPainter }

function TcxCustomGridPainter.GetCanvas: TcxCanvas;
begin
  Result := ViewInfo.Canvas;
end;

procedure TcxCustomGridPainter.DrawBackground;

  procedure DrawBackgroundUsingBrush;
  begin
    with Canvas do
    begin
      Brush.Color := ViewInfo.BackgroundColor;
      FillRgn(Handle, FBackgroundRegion.Handle, Brush.Handle);
    end;
  end;

  procedure DrawBackgroundUsingBitmap;
  var
    AClipRegion: TcxRegion;
  begin
    with Canvas do
    begin
      AClipRegion := GetClipRegion;
      SetClipRegion(FBackgroundRegion, roIntersect, False);
      FillRect(ViewInfo.Bounds, ViewInfo.BackgroundBitmap);
      SetClipRegion(AClipRegion, roSet);
    end;  
  end;

begin
  if ViewInfo.BackgroundBitmap = nil then
    DrawBackgroundUsingBrush
  else
    DrawBackgroundUsingBitmap;  {4}
  FreeAndNil(FBackgroundRegion);
  Canvas.ExcludeClipRect(ViewInfo.Bounds);
end;

procedure TcxCustomGridPainter.PaintAfter;
begin
  DrawBackground;
  Canvas.SetClipRegion(FBeforePaintClipRegion, roSet);
  Controller.AfterPaint;
end;

procedure TcxCustomGridPainter.PaintBefore;
begin
  Controller.BeforePaint;
  FBeforePaintClipRegion := Canvas.GetClipRegion;
  FBackgroundRegion := TcxRegion.Create(ViewInfo.Bounds);
end;

procedure TcxCustomGridPainter.PaintContent;
begin
end;

procedure TcxCustomGridPainter.DrawFocusRect(const R: TRect; AHideFocusRect: Boolean);
begin
  if GridView.IsControlFocused then
    Canvas.DrawFocusRect(R)
  else
    if not AHideFocusRect then
      with Canvas, R do
      begin
        InvertRect(Rect(Left, Top, Right, Top + 1));
        InvertRect(Rect(Left, Bottom - 1, Right, Bottom));
        InvertRect(Rect(Left, Top + 1, Left + 1, Bottom - 1));
        InvertRect(Rect(Right - 1, Top + 1, Right, Bottom - 1));
      end;
end;

procedure TcxCustomGridPainter.ExcludeFromBackground(const R: TRect);
begin
  FBackgroundRegion.Combine(TcxRegion.Create(R), roSubtract);
end;

procedure TcxCustomGridPainter.Paint;

//var i,ft,lt:integer;

begin   {3}

  //ft:=gettickcount;
  {for i:=1 to 10 do
  begin}

  PaintBefore;
  PaintContent;
  PaintAfter;

  {windows.SelectClipRgn(canvas.Handle, 0);
  end;}
  {lt:=gettickcount;
  application.MainForm.caption := inttostr(lt-ft);}

end;

procedure TcxCustomGridPainter.Invalidate;
begin
  Site.Invalidate;
end;

procedure TcxCustomGridPainter.Invalidate(const R: TRect);
begin
  Site.InvalidateRect(R, False);
end;

{ TcxGridSite }

constructor TcxGridSite.Create(AViewInfo: TcxCustomGridViewInfo);
begin
  FViewInfo := AViewInfo;
  inherited Create(nil);
  ControlStyle := ControlStyle + [csNoDesignVisible];
  Keys := [kArrows, kChars];
  ParentColor := False;
{$IFDEF USETCXSCROLLBAR}
  HScrollBar.UnlimitedTracking := True;
  VScrollBar.UnlimitedTracking := True;
{$ENDIF}
end;

destructor TcxGridSite.Destroy;
begin
  CancelPostBoundsChanged;
  //!!!!FViewInfo.FSite := nil; should always be nil here already;
  inherited;
end;

function TcxGridSite.GetContainer: TcxControl;
begin
  Result := GridView.Control;
end;

function TcxGridSite.GetController: TcxCustomGridController;
begin
  Result := GridView.Controller;
end;

function TcxGridSite.GetGridView: TcxCustomGridView;
begin
  Result := FViewInfo.GridView;
end;

function TcxGridSite.GetPainter: TcxCustomGridPainter;
begin
  Result := GridView.Painter;
end;

procedure TcxGridSite.SendKeyDownNotification(const Message: TWMKeyDown);
begin
  TcxCustomGrid(GridView.Control).SendNotifications(gnkKeyDown, @Message);
end;

procedure TcxGridSite.CMBoundsChanged(var Message: TMessage);
var
  AMsg: TMsg;
begin
  while PeekMessage(AMsg, Handle, DXM_BOUNDSCHANGED, DXM_BOUNDSCHANGED, PM_REMOVE) do;
  GridView.BoundsChanged(True, True);
end;

procedure TcxGridSite.CNKeyDown(var Message: TWMKeyDown);
begin
  SendKeyDownNotification(Message);
  if Message.Result = 0 then
    inherited;
end;

procedure TcxGridSite.CNSysKeyDown(var Message: TWMKeyDown);
begin
  SendKeyDownNotification(Message);
  if Message.Result = 0 then
    inherited;
end;

function TcxGridSite.AllowAutoDragAndDropAtDesignTime(X, Y: Integer;
  Shift: TShiftState): Boolean;
begin
  Result := False;
end;

function TcxGridSite.AllowDragAndDropWithoutFocus: Boolean;
begin
  if TcxCustomGridAccess(GridView.Control).IsPopupControl then  {8}
    Result := True
  else
    Result := inherited AllowDragAndDropWithoutFocus;
end;

procedure TcxGridSite.BeforeMouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if HandleAllocated then
    Controller.MouseDown(Button, Shift, X, Y);
end;

procedure TcxGridSite.BoundsChanged;
var
  APrevSize: TPoint;

  function AllowNotification: Boolean;
  var
    AGridView: TcxCustomGridView;
  begin
    AGridView := GridView;
    repeat
      Result := AGridView.ViewInfo.AllowBoundsChangedNotification;
      AGridView := AGridView.MasterGridView;
    until not Result or (AGridView = nil);
  end;

begin
  APrevSize := FSize;
  UpdateSize;
  if ((APrevSize.X <> 0) or (APrevSize.Y <> 0)) and
    ((APrevSize.X <> FSize.X) or (APrevSize.Y <> FSize.Y)) then
    if AllowNotification then
      GridView.BoundsChanged(True)
    else
      if UpdatingScrollBars then PostBoundsChanged;
  {if AllowNotification and
    ((APrevSize.X <> 0) or (APrevSize.Y <> 0)) and
    ((APrevSize.X <> FSize.X) or (APrevSize.Y <> FSize.Y)) then
    GridView.BoundsChanged(True);}
  inherited;
end;

function TcxGridSite.CanDrag(X, Y: Integer): Boolean;
begin
  Result := inherited CanDrag(X, Y) {and not Container.IsDesigning }and
    Controller.CanDrag(X, Y);
end;

procedure TcxGridSite.DoCancelMode;
begin
  inherited;
  Controller.DoCancelMode;
end;

procedure TcxGridSite.DoEnter;
begin
  inherited;
  Controller.DoEnter;
end;

procedure TcxGridSite.DoExit;
begin
  Controller.DoExit;
  inherited;
end;

procedure TcxGridSite.FocusChanged;
var
  ALink: TcxObjectLink;
begin
  ALink := cxAddObjectLink(Self);
  try
    inherited;
    if IsFocused then
      GridView.Focused := True;
    if ALink.Ref = nil then Exit;
    TcxCustomGridAccess(Container).UpdateFocusing(GridView.IsControlFocused);
  finally
    cxRemoveObjectLink(ALink);
  end;
end;

function TcxGridSite.FocusWhenChildIsClicked(AChild: TControl): Boolean;
begin
  Result := inherited FocusWhenChildIsClicked(AChild) and not Container.IsFocused;
end;

function TcxGridSite.GetCursor(X, Y: Integer): TCursor;
begin
  Result := Controller.GetCursor(X, Y);
  if Result = crDefault then
    Result := inherited GetCursor(X, Y);
end;

function TcxGridSite.GetDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean;
var
  AHitTest: TcxCustomGridHitTest;
begin
  Result := inherited GetDesignHitTest(X, Y, Shift);
  if not Result and (ssLeft in Shift) then
  begin
    AHitTest := ViewInfo.GetHitTest(X, Y);
    Result := Controller.GetDesignHitTest(AHitTest);
  end;
end;

function TcxGridSite.GetIsDesigning: Boolean;
begin
  Result := Container.IsDesigning;
end;

function TcxGridSite.GetIsFocused: Boolean;
begin
  Result :=
    (GridView.Control <> nil) and TcxCustomGridAccess(GridView.Control).IsPopupControl or {8}
    inherited GetIsFocused or Controller.HasFocusedControls;
end;

function TcxGridSite.GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind;
begin
  Result := Controller.GetMouseWheelScrollingKind;
end;

function TcxGridSite.IsPixelScrollBar(AKind: TScrollBarKind): Boolean;
begin
  Result := Controller.IsPixelScrollBar(AKind);
end;

procedure TcxGridSite.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  Controller.DoKeyDown(Key, Shift);
  if Key = VK_APPS then
    TcxCustomGrid(GridView.Control).SendNotifications(gnkContextMenu, Pointer(True));
end;

procedure TcxGridSite.KeyPress(var Key: Char);
begin
  inherited;
  Controller.KeyPress(Key);
end;

procedure TcxGridSite.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  Controller.KeyUp(Key, Shift);
end;

function TcxGridSite.MayFocus: Boolean;
begin
  Result := inherited MayFocus and Controller.MayFocus;
end;

procedure TcxGridSite.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if DragAndDropState = ddsNone then
    Controller.MouseMove(Shift, X, Y);
end;

procedure TcxGridSite.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if DragAndDropState = ddsNone then
  begin
    Controller.MouseUp(Button, Shift, X, Y);
    inherited;
  end
  else
  begin
    inherited;
    Controller.MouseUp(Button, Shift, X, Y);
  end;
  if Button = mbRight then
    TcxCustomGrid(GridView.Control).SendNotifications(gnkContextMenu, Pointer(False));
end;

procedure TcxGridSite.Paint;
begin
  if not FViewInfo.IsCalculating and (Left <> cxGridInvisibleCoordinate) then
    Painter.Paint;
end;

procedure TcxGridSite.RequestAlign;
begin
end;

procedure TcxGridSite.SetParent(AParent: TWinControl);
begin
  if Parent <> AParent then
  begin
    if AParent <> nil then
      LookAndFeel.MasterLookAndFeel := TcxCustomGrid(GridView.Control).LookAndFeel;
    InitTabStop(AParent);
    if (AParent = nil) and GridView.Focused and Parent.CanFocus then
      Parent.SetFocus;
  end;
  inherited;
end;

procedure TcxGridSite.WndProc(var Message: TMessage);
begin
  Controller.WndProc(Message);
  inherited WndProc(Message);
end;

procedure TcxGridSite.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  Controller.EndDrag(Target, X, Y);
  inherited;
end;

procedure TcxGridSite.DoStartDrag(var DragObject: TDragObject);
begin
  Controller.BeforeStartDrag;
  inherited;
  Controller.StartDrag(DragObject);
end;

procedure TcxGridSite.DragOver(Source: TObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
  inherited;
  Controller.DragOver(Source, X, Y, State, Accept);
end;

function TcxGridSite.GetHScrollBarBounds: TRect;
begin
  Result := inherited GetHScrollBarBounds;
  ViewInfo.GetHScrollBarBounds(Result);
end;

procedure TcxGridSite.InitScrollBarsParameters;
begin
  Controller.InitScrollBarsParameters;
end;

procedure TcxGridSite.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
  Controller.Scroll(AScrollBarKind, AScrollCode, AScrollPos);
end;

procedure TcxGridSite.UpdateScrollBars;
begin
  if not FViewInfo.IsCalculating then inherited;
end;

procedure TcxGridSite.DragAndDrop(const P: TPoint; var Accepted: Boolean);
begin
  inherited;
  Controller.DragAndDrop(P, Accepted);
end;

procedure TcxGridSite.EndDragAndDrop(Accepted: Boolean);
begin
  Controller.EndDragAndDrop(Accepted);
  inherited;
end;

function TcxGridSite.StartDragAndDrop(const P: TPoint): Boolean;
begin
  Result := Controller.StartDragAndDrop(P);
end;

procedure TcxGridSite.CancelPostBoundsChanged;
begin
end;

procedure TcxGridSite.InitTabStop(AParent: TWinControl);
begin
  if (AParent <> nil) and (GridView.Level <> nil) then
    GridView.TabStop := TcxGridLevel(GridView.Level).IsTop;
end;

procedure TcxGridSite.PostBoundsChanged;     
begin
  if HandleAllocated then
    PostMessage(Handle, DXM_BOUNDSCHANGED, 0, 0);
end;

procedure TcxGridSite.UpdateSize;
begin
  FSize := ClientBounds.BottomRight;
end;

procedure TcxGridSite.BeginDragAndDrop;
begin
  Controller.BeginDragAndDrop;
  inherited;
end;

procedure TcxGridSite.DragDrop(Source: TObject; X, Y: Integer);
begin
  Controller.DragDrop(Source, X, Y);
  inherited;
end;

function TcxGridSite.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or
    GridView.Focused and GridView.DataController.ExecuteAction(Action);
end;

procedure TcxGridSite.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  APrevWidth, APrevHeight: Integer;
begin
  APrevWidth := Width;
  APrevHeight := Height;
  inherited;
  if (Width <> APrevWidth) or (Height <> APrevHeight) then
    UpdateSize;
end;

procedure TcxGridSite.SetFocus;
var
  ALink: TcxObjectLink;
begin
  ALink := cxAddObjectLink(Self);
  try
    if not GridView.Focused then
      TcxCustomGrid(Container).FocusedView.Controller.BeforeKillFocus;
    if ALink.Ref = nil then Exit;
    inherited;
  finally
    cxRemoveObjectLink(ALink);
  end;
end;

function TcxGridSite.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or
    GridView.Focused and GridView.DataController.UpdateAction(Action);
end;

{ TcxCustomGridCellViewInfo }

constructor TcxCustomGridCellViewInfo.Create;
begin
  inherited;
  FVisible := True;
end;

destructor TcxCustomGridCellViewInfo.Destroy;
begin
  Destroying;
  MouseCapture := False;
  State := gcsNone;
  inherited;
end;

function TcxCustomGridCellViewInfo.GetBorderSize(AIndex: TcxBorder): Integer;
begin
  if AIndex in Borders then
    Result := BorderWidth[AIndex]
  else
    Result := 0;
end;

function TcxCustomGridCellViewInfo.GetContentBounds: TRect;
begin
  if IsRectEmpty(FContentBounds) then
    FContentBounds := CalculateContentBounds;
  Result := FContentBounds;
end;

function TcxCustomGridCellViewInfo.GetTextAreaHeight: Integer;
begin
  Result := TextHeight;
  GetCellTextAreaSize(Result);
end;

function TcxCustomGridCellViewInfo.GetTextAreaWidth: Integer;
begin
  Result := TextWidth;
  GetCellTextAreaSize(Result);
end;

function TcxCustomGridCellViewInfo.GetTextHeight: Integer;
var
  R: TRect;
begin
  CalculateParams;
  R := TextAreaBounds;
  Canvas.Font := Params.Font;
  Canvas.TextExtent(Text, R, GetTextAttributes(False));
  Result := R.Bottom - R.Top;
end;

function TcxCustomGridCellViewInfo.GetTextWidth: Integer;
begin
  CalculateParams;
  Canvas.Font := Params.Font;
  Result := Canvas.TextWidth(Text);
end;

procedure TcxCustomGridCellViewInfo.SetState(Value: TcxGridCellState);
begin
  if FState <> Value then
  begin
    BeforeStateChange;
    FState := Value;
    StateChanged;
  end;
end;

function TcxCustomGridCellViewInfo.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

function TcxCustomGridCellViewInfo._AddRef: Integer;
begin
  Result := -1;
end;

function TcxCustomGridCellViewInfo._Release: Integer;
begin
  Result := -1;
end;

procedure TcxCustomGridCellViewInfo.DoCancelMode;
begin
  State := gcsNone;
end;

procedure TcxCustomGridCellViewInfo.MouseLeave;
begin
  if not MouseCapture and (FState = gcsSelected) then State := gcsNone;
end;

procedure TcxCustomGridCellViewInfo.AfterCalculateBounds(var ABounds: TRect);
begin
end;

procedure TcxCustomGridCellViewInfo.AfterCustomDraw(ACanvas: TcxCanvas);
begin
  with ACanvas do
  begin
    Params.Color := Brush.Color;
    Params.Font := Font;
    Params.TextColor := Font.Color;
  end;
end;

procedure TcxCustomGridCellViewInfo.BeforeCustomDraw(ACanvas: TcxCanvas);
begin
  with ACanvas do
  begin
    Brush.Color := Params.Color;
    Font := Params.Font;
    Font.Color := Params.TextColor;
  end;
end;

procedure TcxCustomGridCellViewInfo.BeforeStateChange;
begin
end;

function TcxCustomGridCellViewInfo.CalculateContentBounds: TRect;
var
  ABorder: TcxBorder;
  ABorderSize: Integer;
begin
  Result := Bounds;
  for ABorder := Low(ABorder) to High(ABorder) do
  begin
    ABorderSize := BorderSize[ABorder];
    with Result do
      case ABorder of
        bLeft:
          Inc(Left, ABorderSize);
        bTop:
          Inc(Top, ABorderSize);
        bRight:
          Dec(Right, ABorderSize);
        bBottom:
          Dec(Bottom, ABorderSize);
      end;
  end;
end;

procedure TcxCustomGridCellViewInfo.CalculateParams;
begin
  if FParamsCalculated or FCalculatingParams then Exit;
  FCalculatingParams := True;
  try
    DoCalculateParams;
  finally
    FCalculatingParams := False;
    FParamsCalculated := True;
  end;
end;

procedure TcxCustomGridCellViewInfo.Click;
begin
end;

function TcxCustomGridCellViewInfo.CustomDraw(ACanvas: TcxCanvas): Boolean;
begin
  Result := False;
end;

function TcxCustomGridCellViewInfo.CustomDrawBackground(ACanvas: TcxCanvas): Boolean;
begin
  Result := False;
end;

procedure TcxCustomGridCellViewInfo.Destroying;
begin
  FIsDestroying := True;
end;

procedure TcxCustomGridCellViewInfo.DoCalculateParams;
begin
  AlignmentHorz := GetAlignmentHorz;
  AlignmentVert := GetAlignmentVert;
  GetViewParams(Params);
  Borders := GetBorders;
  Text := GetText;
  MultiLine := GetMultiLine;
  MultiLinePainting := GetMultiLinePainting;
  Width := CalculateWidth;
end;

function TcxCustomGridCellViewInfo.DoCustomDraw(ACanvas: TcxCanvas): Boolean;
begin
  Result := HasCustomDraw;
  if Result then
  begin
    BeforeCustomDraw(ACanvas);
    Result := CustomDraw(ACanvas);
    if not Result then
      AfterCustomDraw(ACanvas);
  end;
end;

function TcxCustomGridCellViewInfo.DoCustomDrawBackground(ACanvas: TcxCanvas): Boolean;
begin
  Result := HasCustomDrawBackground;
  if Result then
  begin
    BeforeCustomDraw(ACanvas);
    Result := CustomDrawBackground(ACanvas);
    if not Result then
      AfterCustomDraw(ACanvas);
  end;
end;

function TcxCustomGridCellViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := taLeftJustify;
end;

function TcxCustomGridCellViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := vaTop;
end;

function TcxCustomGridCellViewInfo.GetBackgroundBitmap: TBitmap;
begin  {4}
  Result := nil;
end;

function TcxCustomGridCellViewInfo.GetBorderBounds(AIndex: TcxBorder): TRect;
begin
  Result := ContentBounds;
  with Result do
  begin
    case AIndex of
      bLeft:
        begin
          Right := Left;
          Dec(Left, BorderWidth[AIndex]);
        end;
      bTop:
        begin
          Bottom := Top;
          Dec(Top, BorderWidth[AIndex]);
        end;
      bRight:
        begin
          Left := Right;
          Inc(Right, BorderWidth[AIndex]);
        end;
      bBottom:
        begin
          Top := Bottom;
          Inc(Bottom, BorderWidth[AIndex]);
        end;
    end;
    if AIndex in [bLeft, bRight] then
    begin
      if bTop in Borders then
        Dec(Top, BorderWidth[bTop]);
      if bBottom in Borders then
        Inc(Bottom, BorderWidth[bBottom]);
    end;
  end;
end;

function TcxCustomGridCellViewInfo.GetBorders: TcxBorders;
begin
  Result := [];
end;

class function TcxCustomGridCellViewInfo.GetCellHeight(ATextHeight: Integer;
  ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer;
begin
  Result := ATextHeight;
  GetCellTextAreaSize(Result);
end;

function TcxCustomGridCellViewInfo.GetContentHeight: Integer;
begin
  with ContentBounds do
    Result := Bottom - Top;
end;

function TcxCustomGridCellViewInfo.GetContentWidth: Integer;
begin
  with ContentBounds do
    Result := Right - Left;
end;

function TcxCustomGridCellViewInfo.GetControl: TcxControl;
begin
  if (Canvas.Canvas is TControlCanvas) and
    (TControlCanvas(Canvas.Canvas).Control is TcxControl) then
      Result := TControlCanvas(Canvas.Canvas).Control as TcxControl
  else
    Result := nil;
end;

function TcxCustomGridCellViewInfo.GetHeight: Integer;
begin
  with Bounds do
    Result := Bottom - Top;
end;

function TcxCustomGridCellViewInfo.GetHotTrack: Boolean;
begin
  Result := False;
end;

function TcxCustomGridCellViewInfo.GetIsCheck: Boolean;
begin
  Result := False;
end;

function TcxCustomGridCellViewInfo.GetMouseCapture: Boolean;
begin
  if Control = nil then
    Result := False
  else
    Result := Control.MouseCaptureObject = Self;
end;

function TcxCustomGridCellViewInfo.GetMultiLine: Boolean;
begin
  Result := False;
end;

function TcxCustomGridCellViewInfo.GetMultiLinePainting: Boolean;
begin                 
  Result := MultiLine;
end;

function TcxCustomGridCellViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxCustomGridCellPainter;
end;

function TcxCustomGridCellViewInfo.GetShowEndEllipsis: Boolean;
begin
  Result := False;
end;

function TcxCustomGridCellViewInfo.GetText: string;
begin
  Result := '';
end;

function TcxCustomGridCellViewInfo.GetTextAreaBounds: TRect;
begin
  Result := ContentBounds;
  InflateRect(Result, -cxGridCellTextOffset, -cxGridCellTextOffset);
end;

function TcxCustomGridCellViewInfo.GetTextAttributes(AForPainting: Boolean): Integer;
const
  AlignmentsHorz: array[TAlignment] of Integer =
    (cxAlignLeft, cxAlignRight, cxAlignHCenter);
  AlignmentsVert: array[TcxAlignmentVert] of Integer =
    (cxAlignTop, cxAlignBottom, cxAlignVCenter);
  MultiLines: array[Boolean] of Integer = (cxSingleLine, cxWordBreak);
  ShowEndEllipsises: array[Boolean] of Integer = (0, cxShowEndEllipsis);
begin
  Result :=
    AlignmentsHorz[AlignmentHorz] or AlignmentsVert[AlignmentVert] or
    MultiLines[AForPainting and MultiLinePainting or not AForPainting and MultiLine] or
    ShowEndEllipsises[ShowEndEllipsis];
end;

function TcxCustomGridCellViewInfo.GetTextCellHeight(AGridViewInfo: TcxCustomGridViewInfo;
  ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer;
begin
  CalculateParams;
  if MultiLine then
    Result := TextHeight
  else
    Result := AGridViewInfo.GetFontHeight(Params.Font);
  Result := GetCellHeight(Result, ALookAndFeelPainter);
end;

function TcxCustomGridCellViewInfo.GetTransparent: Boolean;
begin                               {4}
  Result := BackgroundBitmap <> nil;
end;

procedure TcxCustomGridCellViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
end;

function TcxCustomGridCellViewInfo.GetVisible: Boolean;
begin
  Result := FVisible;
end;

function TcxCustomGridCellViewInfo.GetWidth: Integer;
begin
  with Bounds do
    Result := Right - Left;
end;

function TcxCustomGridCellViewInfo.HasCustomDraw: Boolean;
begin
  Result := False;
end;

function TcxCustomGridCellViewInfo.HasCustomDrawBackground: Boolean;
begin
  Result := False;
end;

function TcxCustomGridCellViewInfo.HasMouse(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := AHitTest is GetHitTestClass;
end;

procedure TcxCustomGridCellViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  AHitTest.ViewInfo := Self;
end;

function TcxCustomGridCellViewInfo.InvalidateOnStateChange: Boolean;
begin
  Result := True;
end;

procedure TcxCustomGridCellViewInfo.Offset(DX, DY: Integer);
begin  {2}
  OffsetRect(Bounds, DX, DY);
  if not IsRectEmpty(FContentBounds) then
    OffsetRect(FContentBounds, DX, DY);
end;

procedure TcxCustomGridCellViewInfo.RestoreParams(const AParams: TcxViewParams);
begin
  Params := AParams;
end;

procedure TcxCustomGridCellViewInfo.SaveParams(out AParams: TcxViewParams);
begin
  AParams := Params;
end;

procedure TcxCustomGridCellViewInfo.SetMouseCapture(Value: Boolean);
begin
  if (Control <> nil) and (MouseCapture <> Value) then
    if Value then
      Control.MouseCaptureObject := Self
    else
      Control.MouseCaptureObject := nil;
end;

procedure TcxCustomGridCellViewInfo.SetWidth(Value: Integer);
begin
  with Bounds do
    Right := Left + Value;
end;

procedure TcxCustomGridCellViewInfo.StateChanged;
begin
  if InvalidateOnStateChange then Invalidate;
  case State of
    gcsNone:
      EndMouseTracking(Self);
    gcsSelected:
      if Control <> nil then
        BeginMouseTracking(Control, Bounds, Self);
  end;
end;

procedure TcxCustomGridCellViewInfo.AfterRecalculation;
begin
end;

procedure TcxCustomGridCellViewInfo.BeforeRecalculation;
begin
  FParamsCalculated := False;
end;

procedure TcxCustomGridCellViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  CalculateParams;
  if AWidth = -1 then AWidth := CalculateWidth;
  if AHeight = -1 then AHeight := CalculateHeight;
  with Bounds do
  begin
    Left := ALeftBound;
    Top := ATopBound;
    Right := Left + AWidth;
    Bottom := Top + AHeight;
  end;
  AfterCalculateBounds(Bounds);
  FCalculated := True;
end;

procedure TcxCustomGridCellViewInfo.Calculate(const ABounds: TRect);
begin
  with ABounds do
    Calculate(Left, Top, Right - Left, Bottom - Top);
end;

function TcxCustomGridCellViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  if PtInRect(Bounds, P) and (GetHitTestClass <> nil) then
  begin
    Result := GetHitTestClass.Instance(P);
    InitHitTest(Result);
  end
  else
    Result := nil;
end;

procedure TcxCustomGridCellViewInfo.Invalidate;
begin
  if Control <> nil then
    Control.InvalidateRect(Bounds, False);
end;

function TcxCustomGridCellViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  Result := False;
  if (AButton = mbLeft) and HotTrack then
  begin
    if IsCheck then
      case FState of
        gcsSelected:
          State := gcsPressed;
        gcsPressed:
          State := gcsSelected;
      end
    else
      State := gcsPressed;
    Result := True;
  end;
end;

function TcxCustomGridCellViewInfo.MouseMove(AHitTest: TcxCustomGridHitTest;
  AShift: TShiftState): Boolean;
begin
  Result := False;
  if HotTrack then
    if IsCheck then
      if State <> gcsPressed then
      begin
        State := gcsSelected;
        Result := True;
      end
      else
    else
    begin
      if HasMouse(AHitTest) then
        if MouseCapture then
          State := gcsPressed
        else
          State := gcsSelected
      else
        if MouseCapture then
          State := gcsSelected
        else
          State := gcsNone;
      Result := True;
    end;
end;

function TcxCustomGridCellViewInfo.MouseUp(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  Result := False;
  if not IsCheck then
  begin
    Result := State = gcsPressed;
    State := gcsNone;
    if Result then Click;
  end;
end;

procedure TcxCustomGridCellViewInfo.DoOffset(DX, DY: Integer);
begin
  Offset(DX, DY);
  State := gcsNone;
  MouseLeave;
end;

procedure TcxCustomGridCellViewInfo.Paint(ACanvas: TcxCanvas = nil);
begin
  {if ACanvas = nil then ACanvas := Canvas;
  if Visible and ACanvas.RectVisible(Bounds) and (GetPainterClass <> nil) then
  begin
    with GetPainterClass.Create(ACanvas, Self) do
      try
        MainPaint;
      finally
        Free;
      end;
  end;}
  if Visible and (GetPainterClass <> nil) then
  begin
    if ACanvas = nil then ACanvas := Canvas;
    with GetPainterClass.Create(ACanvas, Self) do
      try
        MainPaint;
      finally
        Free;
      end;
  end;
end;

procedure TcxCustomGridCellViewInfo.Recalculate;
begin
  BeforeRecalculation;
  Calculate(Bounds);
end;

procedure TcxCustomGridCellViewInfo.ResetContentBounds;
begin
  SetRectEmpty(FContentBounds);
end;

{ TcxCustomGridViewCellViewInfo }

constructor TcxCustomGridViewCellViewInfo.Create(AGridViewInfo: TcxCustomGridViewInfo);
begin
  inherited Create;
  FGridViewInfo := AGridViewInfo;
end;

destructor TcxCustomGridViewCellViewInfo.Destroy;
begin
  FGridViewInfo.RemoveActiveViewInfo(Self);
  inherited;
end;

function TcxCustomGridViewCellViewInfo.GetController: TcxCustomGridController;
begin
  Result := GridView.Controller;
end;

function TcxCustomGridViewCellViewInfo.GetGridView: TcxCustomGridView;
begin
  Result := FGridViewInfo.GridView;
end;

function TcxCustomGridViewCellViewInfo.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := FGridViewInfo.LookAndFeelPainter;
end;

function TcxCustomGridViewCellViewInfo.GetCanvas: TcxCanvas;
begin
  Result := FGridViewInfo.Canvas;
end;

procedure TcxCustomGridViewCellViewInfo.AfterCalculateBounds(var ABounds: TRect);
var
  AHitTest: TcxCustomGridHitTest;
begin
  inherited;
  if EmulateMouseMoveAfterCalculate and
    HotTrack and PtInRect(Bounds, GridViewInfo.MousePos) then
  begin
    AHitTest := GetHitTestClass.Instance(GridViewInfo.MousePos);
    InitHitTest(AHitTest);
    MouseMove(AHitTest, []);
  end;
end;

function TcxCustomGridViewCellViewInfo.EmulateMouseMoveAfterCalculate: Boolean;
begin
  Result := False;
end;

function TcxCustomGridViewCellViewInfo.GetControl: TcxControl;
begin
  Result := GridView.Site;
end;

function TcxCustomGridViewCellViewInfo.HasMouse(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := inherited HasMouse(AHitTest) and
    (TcxCustomGridViewHitTest(AHitTest).GridView = GridView);
end;

procedure TcxCustomGridViewCellViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  GridViewInfo.InitHitTest(AHitTest);
end;

function TcxCustomGridViewCellViewInfo.CanShowHint: Boolean;
begin                          {9}
  Result := False;
end;

procedure TcxCustomGridViewCellViewInfo.CheckHint(AHitTest: TcxCustomGridHitTest);
var
  AHintText: TCaption;
  AIsHintMultiLine: Boolean;
  ATextRect: TRect;
begin    {9}
  if NeedShowHint(AHitTest.Pos, AHintText, AIsHintMultiLine, ATextRect) then
    Controller.ShowHint(GetBoundsForHint, ATextRect, AHintText, AIsHintMultiLine, Params.Font)
  else
    Controller.HideHint;
end;

function TcxCustomGridViewCellViewInfo.GetBoundsForHint: TRect;
begin
  Result := ContentBounds;
end;

function TcxCustomGridViewCellViewInfo.NeedShowHint(const AMousePos: TPoint;
  out AHintText: TCaption; out AIsHintMultiLine: Boolean; out ATextRect: TRect): Boolean;
begin
  Result := False;
end;

procedure TcxCustomGridViewCellViewInfo.Invalidate;
begin
  if IsDestroying then Exit;
  CalculateParams;
  GridView.ViewChanged(Bounds);
end;

function TcxCustomGridViewCellViewInfo.MouseMove(AHitTest: TcxCustomGridHitTest;
  AShift: TShiftState): Boolean;
begin
  Result := inherited MouseMove(AHitTest, AShift);
  if CanShowHint then
    CheckHint(AHitTest); {9}
end;

{ TcxCustomGridViewInfo }

constructor TcxCustomGridViewInfo.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  InitializeCriticalSection(FLock);
  FActiveViewInfos := TList.Create;
  CreateSite;
  CreateViewInfos;
end;

destructor TcxCustomGridViewInfo.Destroy;
begin
  DestroySite;
  FreeAndNil(FActiveViewInfos);
  DeleteCriticalSection(FLock);
  inherited;
end;

function TcxCustomGridViewInfo.GetCalculated: Boolean;
begin
  Result := not IsRectEmpty(Bounds);
end;

function TcxCustomGridViewInfo.GetCanvas: TcxCanvas;
begin
  Result := FSite.ActiveCanvas;
end;

function TcxCustomGridViewInfo.GetClientBounds: TRect;
begin
  if FClientBoundsAssigned then
    Result := FClientBounds
  else
    Result := CalculateClientBounds;
end;

function TcxCustomGridViewInfo.GetClientHeight: Integer;
begin
  with ClientBounds do
    Result := Bottom - Top;
end;

function TcxCustomGridViewInfo.GetClientWidth: Integer;
begin
  with ClientBounds do
    Result := Right - Left;
end;

{function TcxCustomGridViewInfo.GetIsCalculating: Boolean;
begin
  Result := FIsCalculating or
    GridView.IsDetail and GridView.MasterGridView.ViewInfo.IsCalculating;
end;}

function TcxCustomGridViewInfo.GetIsInternalUseValue: Boolean;
begin
  Result := GetIsInternalUse or
    GridView.IsDetail and
    (GridView.MasterGridView.ViewInfo <> nil) and
    GridView.MasterGridView.ViewInfo.IsInternalUse;
end;

procedure TcxCustomGridViewInfo.SetClientBounds(const Value: TRect);
begin
  FClientBounds := Value;
  FClientBoundsAssigned := True;
end;

procedure TcxCustomGridViewInfo.CreateViewInfos;
begin
end;

procedure TcxCustomGridViewInfo.DestroyViewInfos(AIsRecreating: Boolean);
begin
end;

procedure TcxCustomGridViewInfo.RecreateViewInfos;
begin
  FClientBoundsAssigned := False;
  DestroyViewInfos(True);
  CreateViewInfos;
end;

procedure TcxCustomGridViewInfo.CreateSite;
begin
  FSite := GetSiteClass.Create(Self);
end;

procedure TcxCustomGridViewInfo.DestroySite;
begin
  FreeAndNil(FSite);
end;

function TcxCustomGridViewInfo.GetSiteClass: TcxGridSiteClass;
begin
  Result := TcxGridSite;
end;

function TcxCustomGridViewInfo.GetSiteParent: TWinControl;
begin
  if GridView.IsDetail then
    Result := GridView.MasterGridView.Site
  else
    Result := Control;
end;

procedure TcxCustomGridViewInfo.AddActiveViewInfo(AViewInfo: TObject);
begin
  FActiveViewInfos.Add(AViewInfo);
end;

function TcxCustomGridViewInfo.IsViewInfoActive(AViewInfo: TObject): Boolean;
begin
  Result := FActiveViewInfos.IndexOf(AViewInfo) <> -1;
end;

procedure TcxCustomGridViewInfo.RemoveActiveViewInfo(AViewInfo: TObject);
begin
  FActiveViewInfos.Remove(AViewInfo);
end;

procedure TcxCustomGridViewInfo.AddScrollBarHeight(var AHeight: Integer);
begin
  if Site.HScrollBarVisible then
    Inc(AHeight, Site.HScrollBar.Height);
end;

procedure TcxCustomGridViewInfo.AfterCalculating;
begin
  if not IsInternalUse then Controller.UpdateScrollBars;
end;

procedure TcxCustomGridViewInfo.BeforeCalculating;
begin
  UpdateMousePos;
end;

procedure TcxCustomGridViewInfo.Calculate;
begin
end;

function TcxCustomGridViewInfo.CalculateClientBounds: TRect;
begin
  Result := Bounds;
end;

procedure TcxCustomGridViewInfo.CalculateHeight(const AMaxSize: TPoint;
  var AHeight: Integer; var AFullyVisible: Boolean);
begin
  AddScrollBarHeight(AHeight);
end;

procedure TcxCustomGridViewInfo.CalculateWidth(const AMaxSize: TPoint; var AWidth: Integer);
begin
  if Site.VScrollBarVisible then
    Inc(AWidth, Site.VScrollBar.Width);
  if AWidth > AMaxSize.X then AWidth := AMaxSize.X;
end;

procedure TcxCustomGridViewInfo.ControlFocusChanged;
begin
end;

function TcxCustomGridViewInfo.GetAllowBoundsChangedNotification: Boolean;
begin
  Result := not IsCalculating and not VisibilityChanging;
end;

function TcxCustomGridViewInfo.GetBackgroundBitmap: TBitmap;
begin       {4}
  Result := GridView.BackgroundBitmaps.GetBitmap(bbBackground);
end;

function TcxCustomGridViewInfo.GetBackgroundColor: TColor;
var
  AParams: TcxViewParams;
begin
  GridView.Styles.GetViewParams(vsBackground, nil, nil, AParams);
  Result := AParams.Color;
end;

procedure TcxCustomGridViewInfo.GetHScrollBarBounds(var ABounds: TRect);
begin
end;

function TcxCustomGridViewInfo.GetIsInternalUse: Boolean;
begin
  Result := FIsInternalUse;
end;

procedure TcxCustomGridViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  (AHitTest as TcxCustomGridViewHitTest).GridView := GridView;
end;

procedure TcxCustomGridViewInfo.UpdateMousePos;
begin
  if FSite.Left = cxGridInvisibleCoordinate then Exit;
  if FSite.HandleAllocated and not GridView.Control.IsDesigning then
    FMousePos := FSite.ScreenToClient(GetMouseCursorPos)
  else
    FMousePos := Point(MaxInt, MaxInt);
end;

procedure TcxCustomGridViewInfo.VisibilityChanged(AVisible: Boolean);
begin
  UpdateMousePos;
  if AVisible then
  begin
    FSite.Parent := GetSiteParent;
  end
  else
    if (Control = nil) or GridView.IsDestroying or
      not FSite.IsFocused and ((TcxCustomGrid(Control).FocusedView = nil) or
        not FSite.ContainsControl(TcxCustomGrid(Control).FocusedView.Site)) then
    begin
      FSite.Parent := nil;
    end
    else
      FSite.Left := cxGridInvisibleCoordinate;
end;

procedure TcxCustomGridViewInfo.BeforeDestruction;
begin
  inherited;
  DestroyViewInfos(False);
end;

procedure TcxCustomGridViewInfo.DoVisibilityChanged(AVisible: Boolean);
begin
  if not IsInternalUse and not FSizeCalculating then
  begin
    FVisibilityChanging := True;
    try
      VisibilityChanged(AVisible and GridView.Visible);
    finally
      FVisibilityChanging := False;
    end;
  end;
end;

function TcxCustomGridViewInfo.GetFontHeight(AFont: TFont): Integer;
begin
  Canvas.Font := AFont;
  Result := Canvas.TextHeight('Qq');
end;

procedure TcxCustomGridViewInfo.GetHeight(const AMaxSize: TPoint; var AHeight: Integer;
  var AFullyVisible: Boolean);
begin
  FSizeCalculating := True;
  CalculateHeight(AMaxSize, AHeight, AFullyVisible);
  FSizeCalculating := False;
end;

function TcxCustomGridViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  Result := TcxGridViewNoneHitTest.Instance(P);
  InitHitTest(Result);
end;

function TcxCustomGridViewInfo.GetHitTest(X, Y: Integer): TcxCustomGridHitTest;
begin
  Result := GetHitTest(Point(X, Y));
end;

procedure TcxCustomGridViewInfo.GetWidth(const AMaxSize: TPoint; var AWidth: Integer);
begin
  FSizeCalculating := True;
  CalculateWidth(AMaxSize, AWidth);
  FSizeCalculating := False;
end;

procedure TcxCustomGridViewInfo.MainCalculate(const ABounds: TRect);

//var ft,lt,i:integer;

begin
  if FIsCalculating {or GridView.IsPattern} then Exit;
  {3}

  {ft:=gettickcount;
  //for i:=1 to 1 + 9 * ord(not isinternaluse) do
  begin}

  BeforeCalculating;
  FIsCalculating := True;
  try
    FSite.BoundsRect := ABounds;
    FBounds := FSite.ClientBounds;
    Calculate;
  finally
    FIsCalculating := False;
    AfterCalculating;
    DoVisibilityChanged(True);
  end;
  {
  end;
  lt:=gettickcount;
  if not isinternaluse then
  application.MainForm.Caption := inttostr(lt-ft);
  }
end;

procedure TcxCustomGridViewInfo.Recalculate;
begin
  MainCalculate(FSite.BoundsRect);
end;

{ TcxCustomGridViewInfoCacheItem }

constructor TcxCustomGridViewInfoCacheItem.Create(AOwner: TcxCustomGridViewInfoCache;
  AIndex: Integer);
begin
  inherited Create;
  FIndex := AIndex;
  FOwner := AOwner;
end;

procedure TcxCustomGridViewInfoCacheItem.UnassignValues(AKeepMaster: Boolean);
begin
end;

{ TcxCustomGridViewInfoCache }

constructor TcxCustomGridViewInfoCache.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FItems := TList.Create;
end;

destructor TcxCustomGridViewInfoCache.Destroy;
begin
  DestroyItems;
  FItems.Free;
  inherited;
end;

function TcxCustomGridViewInfoCache.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxCustomGridViewInfoCache.GetInternalItem(Index: Integer): TcxCustomGridViewInfoCacheItem;
begin
  Result := FItems[Index];
end;

function TcxCustomGridViewInfoCache.GetItem(Index: Integer): TcxCustomGridViewInfoCacheItem;
begin
  Result := InternalItems[Index];
  if Result = nil then
  begin
    Result := GetItemClass.Create(Self, Index);
    FItems[Index] := Result;
  end;
end;

procedure TcxCustomGridViewInfoCache.SetCount(Value: Integer);
begin
  DestroyItems;
  FItems.Count := Value;
end;

procedure TcxCustomGridViewInfoCache.DestroyItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do TObject(FItems[I]).Free;
  FItems.Clear;
end;

function TcxCustomGridViewInfoCache.GetItemClass: TcxCustomGridViewInfoCacheItemClass;
begin
  Result := TcxCustomGridViewInfoCacheItem;
end;

procedure TcxCustomGridViewInfoCache.UnassignValues(AKeepMaster: Boolean = False);

  procedure ProcessItems;
  var
    I: Integer;
    AItem: TcxCustomGridViewInfoCacheItem;
  begin
    for I := 0 to Count - 1 do
    begin
      AItem := InternalItems[I];
      if AItem <> nil then AItem.UnassignValues(AKeepMaster);
    end;
  end;

  procedure ProcessMasterItems;
  var
    AGridView: TcxCustomGridView;
    AGridRecordIndex: Integer;
  begin
    AGridView := GridView;
    while AGridView.IsDetail do
    begin
      AGridRecordIndex := AGridView.MasterGridRecordIndex;
      AGridView := AGridView.MasterGridView;
      if AGridRecordIndex <> -1 then
        AGridView.ViewInfoCache[AGridRecordIndex].UnassignValues(False);
    end;
  end;

begin
  if FUnassigningValues then Exit;
  FUnassigningValues := True;
  try
    ProcessItems;
    if not AKeepMaster then ProcessMasterItems;
  finally
    FUnassigningValues := False;
  end;
end;

{ TcxCustomGridOptions }

constructor TcxCustomGridOptions.Create(AGridView: TcxCustomGridView);
begin
  inherited Create;
  FGridView := AGridView;
  FGridView.AddOptions(Self);
end;

destructor TcxCustomGridOptions.Destroy;
begin
  FGridView.RemoveOptions(Self);
  inherited;
end;

function TcxCustomGridOptions.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := FGridView.LookAndFeelPainter;
end;

procedure TcxCustomGridOptions.LayoutChanged;
begin
  GridView.LayoutChanged;
end;

procedure TcxCustomGridOptions.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
end;

procedure TcxCustomGridOptions.Assign(Source: TPersistent);
begin
  if not (Source is TcxCustomGridOptions) then
    inherited;
end;

{ TcxCustomGridBackgroundBitmaps }

constructor TcxCustomGridBackgroundBitmaps.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FItems := TList.Create;
end;

destructor TcxCustomGridBackgroundBitmaps.Destroy;

  procedure ClearItems;
  var
    I: Integer;
  begin
    for I := 0 to Count - 1 do
      if FItems[I] <> nil then TBitmap(FItems[I]).Free;
  end;

begin
  ClearItems;
  FItems.Free;
  inherited;
end;

function TcxCustomGridBackgroundBitmaps.GetCount: Integer;
begin
  Result := FItems.Count;
end;

procedure TcxCustomGridBackgroundBitmaps.BitmapChanged(Sender: TObject);
begin
  GridView.LayoutChanged;
end;

function TcxCustomGridBackgroundBitmaps.GetBitmapStyleIndex(Index: Integer): Integer;
begin
  if Index = bbBackground then
    Result := vsBackground
  else
    Result := -1;
end;

function TcxCustomGridBackgroundBitmaps.GetDefaultBitmap(Index: Integer): TBitmap;
var
  AStyleIndex: Integer;
begin
  AStyleIndex := GetBitmapStyleIndex(Index);
  if AStyleIndex = -1 then
    Result := nil
  else
    Result := GridView.Styles.GetBitmap(AStyleIndex);
end;

function TcxCustomGridBackgroundBitmaps.GetValue(Index: Integer): TBitmap;
begin
  if Index >= Count then
    FItems.Count := Index + 1;
  if FItems[Index] = nil then
  begin
    FItems[Index] := TBitmap.Create;
    TBitmap(FItems[Index]).OnChange := BitmapChanged;
  end;
  Result := TBitmap(FItems[Index]);
end;

procedure TcxCustomGridBackgroundBitmaps.SetValue(Index: Integer; Value: TBitmap);
begin
  Values[Index].Assign(Value);
end;

procedure TcxCustomGridBackgroundBitmaps.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridBackgroundBitmaps then
    with TcxCustomGridBackgroundBitmaps(Source) do
      Self.Background := Background;
  inherited;
end;

function TcxCustomGridBackgroundBitmaps.GetBitmap(Index: Integer): TBitmap;
begin
  Result := Values[Index];
  if Result.Empty then
    Result := GetDefaultBitmap(Index);
end;

{ TcxCustomGridOptionsView }

function TcxCustomGridOptionsView.GetScrollBars: TScrollStyle;
begin
  Result := GridView.Site.ScrollBars;
end;

procedure TcxCustomGridOptionsView.SetScrollBars(Value: TScrollStyle);
begin
  GridView.Site.ScrollBars := Value;
end;

procedure TcxCustomGridOptionsView.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridOptionsView then
    with TcxCustomGridOptionsView(Source) do
      Self.ScrollBars := ScrollBars;
  inherited;
end;

{ TcxCustomGridStyles }

function TcxCustomGridStyles.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := GridView.LookAndFeelPainter;
end;

procedure TcxCustomGridStyles.Changed(AIndex: Integer);
begin
  inherited;
  if GridView <> nil then
    with GridView do
    begin
      UpdateFakeLinks;
      SizeChanged;
    end;
end;

procedure TcxCustomGridStyles.GetDefaultViewParams(Index: Integer; AData: TObject;
  out AParams: TcxViewParams);
var
  AGrid: TcxCustomGrid;
begin
  inherited;
  AGrid := TcxCustomGrid(GridView.Control);
  if AGrid = nil then
    AParams.Font := GridView.Painter.Canvas.Font
  else
    AParams.Font := AGrid.Font;
end;

procedure TcxCustomGridStyles.GetFakeComponentLinks(AList: TList);
var
  I: Integer;
  AOwner: TComponent;
begin
  for I := 0 to Count - 1 do
  begin
    AOwner := Items[I].Item.Owner;
    if (AOwner <> GridView.Owner) and (AList.IndexOf(AOwner) = -1) then
      AList.Add(AOwner);
  end;
end;

{ TcxCustomGridViewStyles }

procedure TcxCustomGridViewStyles.GetDefaultViewParams(Index: Integer; AData: TObject;
  out AParams: TcxViewParams);
begin
  inherited;
  with AParams, LookAndFeelPainter do
    case Index of
      vsBackground:
        Color := DefaultContentColor;
    end;
end;

function TcxCustomGridViewStyles.GetGridView: TcxCustomGridView;
begin
  if GetOwner is TcxCustomGridView then
    Result := TcxCustomGridView(GetOwner)
  else
    Result := nil;
end;

procedure TcxCustomGridViewStyles.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxCustomGridViewStyles then
    with TcxCustomGridViewStyles(Source) do
      Self.Background := Background;
end;

{ TcxCustomGridView }

constructor TcxCustomGridView.Create(AOwner: TComponent);
begin
  inherited;
  FListenerLinks := TList.Create;
  FClones := TList.Create;
  CreateOptions;
  CreateHandlers;
end;

destructor TcxCustomGridView.Destroy;
begin
  Focused := False;
  if not IsPattern and (PatternGridView <> nil) then
    PatternGridView.RemoveClone(Self); 
  if (FLevel <> nil) and (TcxGridLevel(FLevel).GridView = Self) then
    TcxGridLevel(FLevel).GridView := nil;
  if FRepository <> nil then
    TcxGridViewRepositoryAccess(FRepository).RemoveItem(Self);  {5}
  DestroyHandlers;
  DestroyOptions;
  FClones.Free;
  ClearListenerLinks;
  FListenerLinks.Free;
  inherited;
end;

function TcxCustomGridView.GetClone(Index: Integer): TcxCustomGridView;
begin
  Result := TcxCustomGridView(FClones[Index]);
end;

function TcxCustomGridView.GetCloneCount: Integer;
begin
  Result := FClones.Count;
end;

function TcxCustomGridView.GetDragMode: TDragMode;
begin
  Result := Site.DragMode;
end;

function TcxCustomGridView.GetFocused: Boolean;
begin
  Result := (Control <> nil){5} and (TcxCustomGrid(Control).FocusedView = Self);
end;

function TcxCustomGridView.GetIsDetail: Boolean;
begin
  Result := DataController.IsDetailMode;
end;

function TcxCustomGridView.GetIsMaster: Boolean;
begin
  Result := (FLevel <> nil) and TcxGridLevel(FLevel).IsMaster;
end;

function TcxCustomGridView.GetIsPattern: Boolean;
begin
  Result := {(Level = nil) or }DataController.IsPattern;
end;

function TcxCustomGridView.GetIsStoringNameMode: Boolean;
begin
  Result := FStoringName <> '';
end;

function TcxCustomGridView.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  if Control = nil then
    Result := TcxStandardLookAndFeelPainter
  else
    Result := TcxCustomGrid(Control).LookAndFeel.Painter;
end;

function TcxCustomGridView.GetMasterGridView: TcxCustomGridView;
var
  AIDataController: IcxCustomGridDataController;
begin
  if IsDetail then
  begin
    DataController.GetMasterDataController.GetInterface(IcxCustomGridDataController, AIDataController);
    Result := AIDataController.GridView;
  end  
  else
    Result := nil;
end;

function TcxCustomGridView.GetMasterGridRecordIndex: Integer;
begin
  if MasterRecordIndex <> -1 then
    Result := MasterGridView.DataController.GetRowIndexByRecordIndex(MasterRecordIndex, False)
  else
    Result := -1;
end;

function TcxCustomGridView.GetMasterRecordIndex: Integer;
begin
  Result := DataController.GetMasterRecordIndex;
end;

function TcxCustomGridView.GetOnDblClick: TNotifyEvent;
begin
  Result := Site.OnDblClick;
end;

function TcxCustomGridView.GetOnDragDrop: TDragDropEvent;
begin
  Result := Site.OnDragDrop;
end;

function TcxCustomGridView.GetOnDragOver: TDragOverEvent;
begin
  Result := Site.OnDragOver;
end;

function TcxCustomGridView.GetOnEndDrag: TEndDragEvent;
begin
  Result := Site.OnEndDrag;
end;

function TcxCustomGridView.GetOnKeyDown: TKeyEvent;
begin
  Result := Site.OnKeyDown;
end;

function TcxCustomGridView.GetOnKeyPress: TKeyPressEvent;
begin
  Result := Site.OnKeyPress;
end;

function TcxCustomGridView.GetOnKeyUp: TKeyEvent;
begin
  Result := Site.OnKeyUp;
end;

function TcxCustomGridView.GetOnMouseDown: TMouseEvent;
begin
  Result := Site.OnMouseDown;
end;

function TcxCustomGridView.GetOnMouseMove: TMouseMoveEvent;
begin
  Result := Site.OnMouseMove;
end;

function TcxCustomGridView.GetOnMouseUp: TMouseEvent;
begin
  Result := Site.OnMouseUp;
end;

function TcxCustomGridView.GetOnMouseWheel: TMouseWheelEvent;
begin
  Result := Site.OnMouseWheel;
end;

function TcxCustomGridView.GetOnMouseWheelDown: TMouseWheelUpDownEvent;
begin
  Result := Site.OnMouseWheelDown;
end;

function TcxCustomGridView.GetOnMouseWheelUp: TMouseWheelUpDownEvent;
begin
  Result := Site.OnMouseWheelUp;
end;

function TcxCustomGridView.GetOnStartDrag: TStartDragEvent;
begin
  Result := Site.OnStartDrag;
end;

function TcxCustomGridView.GetPatternGridView: TcxCustomGridView;
begin
  Result := FPatternGridView;
  if Result = nil then Result := Self;
end;

function TcxCustomGridView.GetSite: TcxGridSite;
begin
  if FViewInfo = nil then
    Result := nil
  else
    Result := FViewInfo.Site;
end;

procedure TcxCustomGridView.SetBackgroundBitmaps(Value: TcxCustomGridBackgroundBitmaps);
begin
  FBackgroundBitmaps.Assign(Value);
end;

procedure TcxCustomGridView.SetDragMode(Value: TDragMode);
begin
  Site.DragMode := Value;
end;

procedure TcxCustomGridView.SetFocused(Value: Boolean);
begin
  if Focused <> Value then
    with TcxCustomGrid(Control) do
      if Value then
        FocusedView := Self
      else
        FocusedView := nil;
end;

procedure TcxCustomGridView.SetOnDblClick(Value: TNotifyEvent);
begin
  Site.OnDblClick := Value;
end;

procedure TcxCustomGridView.SetOnDragDrop(Value: TDragDropEvent);
begin
  Site.OnDragDrop := Value;
end;

procedure TcxCustomGridView.SetOnDragOver(Value: TDragOverEvent);
begin
  Site.OnDragOver := Value;
end;

procedure TcxCustomGridView.SetOnEndDrag(Value: TEndDragEvent);
begin
  Site.OnEndDrag := Value;
end;

procedure TcxCustomGridView.SetOnKeyDown(Value: TKeyEvent);
begin
  Site.OnKeyDown := Value;
end;

procedure TcxCustomGridView.SetOnKeyPress(Value: TKeyPressEvent);
begin
  Site.OnKeyPress := Value;
end;

procedure TcxCustomGridView.SetOnKeyUp(Value: TKeyEvent);
begin
  Site.OnKeyUp := Value;
end;

procedure TcxCustomGridView.SetOnMouseDown(Value: TMouseEvent);
begin
  Site.OnMouseDown := Value;
end;

procedure TcxCustomGridView.SetOnMouseMove(Value: TMouseMoveEvent);
begin
  Site.OnMouseMove := Value;
end;

procedure TcxCustomGridView.SetOnMouseUp(Value: TMouseEvent);
begin
  Site.OnMouseUp := Value;
end;

procedure TcxCustomGridView.SetOnMouseWheel(Value: TMouseWheelEvent);
begin
  Site.OnMouseWheel := Value;
end;

procedure TcxCustomGridView.SetOnMouseWheelDown(Value: TMouseWheelUpDownEvent);
begin
  Site.OnMouseWheelDown := Value;
end;

procedure TcxCustomGridView.SetOnMouseWheelUp(Value: TMouseWheelUpDownEvent);
begin
  Site.OnMouseWheelUp := Value;
end;

procedure TcxCustomGridView.SetOnStartDrag(Value: TStartDragEvent);
begin
  Site.OnStartDrag := Value;
end;

procedure TcxCustomGridView.SetOptionsSelection(Value: TcxCustomGridOptionsSelection);
begin
  FOptionsSelection.Assign(Value);
end;

procedure TcxCustomGridView.SetOptionsView(Value: TcxCustomGridOptionsView);
begin
  FOptionsView.Assign(Value);
end;

procedure TcxCustomGridView.SetStyles(Value: TcxCustomGridStyles);
begin
  FStyles.Assign(Value);
end;

procedure TcxCustomGridView.ClearListenerLinks;
var
  I: Integer;
begin
  for I := FListenerLinks.Count - 1 downto 0 do
  begin
    PPointer(FListenerLinks[I])^ := nil;
    RemoveListenerLink(FListenerLinks[I]);
  end;  
end;

function TcxCustomGridView.GetObjectName: string;
begin
  if IsStoringNameMode then
    Result := FStoringName
  else
    Result := Name;
end;

function TcxCustomGridView.GetProperties(AProperties: TStrings): Boolean;
begin
  Result := True;
end;

procedure TcxCustomGridView.GetPropertyValue(const AName: string; var AValue: Variant);
begin
end;

procedure TcxCustomGridView.SetPropertyValue(const AName: string; const AValue: Variant);
begin
end;

function TcxCustomGridView.CreateChild(const AObjectName, AClassName: string): TObject;
begin
  Result := nil;
end;

procedure TcxCustomGridView.DeleteChild(const AObjectName: string; AObject: TObject);
begin
  AObject.Free;
end;

procedure TcxCustomGridView.GetStoredChildren(AChildren: TStringList);
begin
end;

procedure TcxCustomGridView.GetFakeComponentLinks(AList: TList);
var
  AIDataController: IcxCustomGridDataController;
begin
  inherited;
  FDataController.GetInterface(IcxCustomGridDataController, AIDataController);
  AIDataController.GetFakeComponentLinks(AList);
  FStyles.GetFakeComponentLinks(AList);
end;

function TcxCustomGridView.GetIsDestroying: Boolean;
begin
  Result := inherited GetIsDestroying or
    IsDetail and MasterGridView.IsDestroying;
end;

procedure TcxCustomGridView.Loaded;
begin
  inherited;
  LoadingComplete;
  DataController.Loaded;
  Init;
end;

procedure TcxCustomGridView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  NotifyOptions(AComponent, Operation);
end;

procedure TcxCustomGridView.SetControl(Value: TcxControl);
begin
  if Control <> Value then
  begin
    if Control <> nil then
    begin
      TcxCustomGridAccess(Control).RemoveFontListener(FStyles);  {5}
      if Site <> nil then
        Control.RemoveComponent(Site);
    end;
    inherited;
    if Control <> nil then
    begin
      if (FStorageControl = nil) and (FRepository = nil) then
        FStorageControl := Value;
      Control.InsertComponent(Site);
      TcxCustomGridAccess(Control).AddFontListener(FStyles);
    end;
  end;  
end;

procedure TcxCustomGridView.SetName(const NewName: TComponentName);
begin
  inherited;
  NotifyControl(vcName);
end;

procedure TcxCustomGridView.Updated;
begin
  inherited;
  EndUpdate;
end;

procedure TcxCustomGridView.Updating;
begin
  BeginUpdate;
  inherited;
end;

procedure TcxCustomGridView.CreateHandlers;
begin
  FController := GetControllerClass.Create(Self);
  FDataController := GetDataControllerClass.Create(Self);
  InitDataController;
  FPainter := GetPainterClass.Create(Self);
  FViewData := GetViewDataClass.Create(Self);
  FViewInfo := GetViewInfoClass.Create(Self);
  FViewInfoCache := GetViewInfoCacheClass.Create(Self);
end;

procedure TcxCustomGridView.DestroyHandlers;
begin 
  FDataController.Free;
  FDataController := nil;
  FreeAndNil(FViewInfoCache);
  if Control <> nil then
    Control.RemoveComponent(Site);  {5}
  FViewInfo.Free;
  FViewInfo := nil;
  FreeAndNil(FViewData);
  FreeAndNil(FPainter);
  FreeAndNil(FController);
end;

procedure TcxCustomGridView.InitDataController;
begin
  FDataController.OnUpdateControl := UpdateControl;
end;

procedure TcxCustomGridView.CreateOptions;
begin
  FOptionsList := TList.Create;
  FBackgroundBitmaps := GetBackgroundBitmapsClass.Create(Self);
  FOptionsSelection := GetOptionsSelectionClass.Create(Self);
  FOptionsView := GetOptionsViewClass.Create(Self);
  FStyles := GetStylesClass.Create(Self);
end;

procedure TcxCustomGridView.DestroyOptions;
begin
  if Control <> nil then  {5}
    TcxCustomGridAccess(Control).RemoveFontListener(FStyles);
  FreeAndNil(FStyles);
  FreeAndNil(FOptionsView);
  FreeAndNil(FOptionsSelection);
  FreeAndNil(FBackgroundBitmaps);
  FreeAndNil(FOptionsList);
end;

procedure TcxCustomGridView.AddOptions(AOptions: TcxCustomGridOptions);
begin
  FOptionsList.Add(AOptions);
end;

procedure TcxCustomGridView.RemoveOptions(AOptions: TcxCustomGridOptions);
begin
  FOptionsList.Remove(AOptions);
end;

procedure TcxCustomGridView.NotifyOptions(AComponent: TComponent;
  AOperation: TOperation);
var
  I: Integer;
begin
  if FOptionsList = nil then Exit;
  for I := 0 to FOptionsList.Count - 1 do
    TcxCustomGridOptions(FOptionsList[I]).Notification(AComponent, AOperation);
end;

procedure TcxCustomGridView.AddClone(AClone: TcxCustomGridView);
begin
  FClones.Add(AClone);
  AClone.FPatternGridView := Self;
end;

procedure TcxCustomGridView.RemoveClone(AClone: TcxCustomGridView);
begin
  FClones.Remove(AClone);
  AClone.FPatternGridView := nil;
end;

procedure TcxCustomGridView.AddListenerLink(ALink: Pointer);
begin
  FListenerLinks.Add(ALink);
end;

procedure TcxCustomGridView.RemoveListenerLink(ALink: Pointer);
begin
  FListenerLinks.Remove(ALink);
end;

procedure TcxCustomGridView.AssignPattern(APattern: TcxCustomGridView);
begin
  FAssigningPattern := True;
  try
    Assign(APattern);
  finally
    FAssigningPattern := False;
  end;
end;

procedure TcxCustomGridView.BeforeAssign(ASource: TcxCustomGridView);
begin
  DataController.Assign(ASource.DataController);
end;

procedure TcxCustomGridView.DoAssign(ASource: TcxCustomGridView);
begin
  with ASource do
  begin
    Self.BackgroundBitmaps := BackgroundBitmaps;
    Self.DragMode := DragMode;
    Self.OptionsSelection := OptionsSelection;
    Self.OptionsView := OptionsView;
    Self.Styles := Styles;
    Self.OnDblClick := OnDblClick;
    Self.OnDragDrop := OnDragDrop;
    Self.OnDragOver := OnDragOver;
    Self.OnEndDrag := OnEndDrag;
    Self.OnKeyDown := OnKeyDown;
    Self.OnKeyPress := OnKeyPress;
    Self.OnKeyUp := OnKeyUp;
    Self.OnMouseDown := OnMouseDown;
    Self.OnMouseMove := OnMouseMove;
    Self.OnMouseUp := OnMouseUp;
    Self.OnMouseWheel := OnMouseWheel;
    Self.OnMouseWheelDown := OnMouseWheelDown;
    Self.OnMouseWheelUp := OnMouseWheelUp;
    Self.OnStartDrag := OnStartDrag;
    Self.Init;
  end
end;

procedure TcxCustomGridView.AfterAssign(ASource: TcxCustomGridView);
begin
  DataController.Assign(ASource.DataController);
end;

{procedure TcxCustomGridView.BeforeLevelChange;
begin
end;}

function TcxCustomGridView.CanFocus: Boolean;
begin
  Result := GetCustomVisible((FLevel <> nil) and TcxGridLevel(FLevel).CanBeVisible);
end;

function TcxCustomGridView.CanTabStop: Boolean;
begin
  Result := TcxCustomGridAccess(Control).TabStop;
end;

procedure TcxCustomGridView.DetailVisibleChanged(ADetailLevel: TComponent;
  APrevVisibleDetailCount, AVisibleDetailCount: Integer);
begin
end;

function TcxCustomGridView.GetChangeable: Boolean;
begin
  Result := (Visible or IsPattern) and (Control <> nil);
end;

function TcxCustomGridView.GetCustomVisible(ALevelVisible: Boolean): Boolean;
begin
  Result := ALevelVisible and
    not IsPattern and (not IsDetail or MasterGridView.IsDetailVisible(Self));
end;

function TcxCustomGridView.GetIsControlFocused: Boolean;
begin
  Result := Control.IsFocused;  {3}
end;

function TcxCustomGridView.GetResizeOnBoundsChange: Boolean;
begin
  Result := False;
end;

function TcxCustomGridView.GetVisible: Boolean;
begin
  Result := not IsDestroying and
    GetCustomVisible((FLevel <> nil) and TcxGridLevel(FLevel).ActuallyVisible);
end;

procedure TcxCustomGridView.Init;
begin
end;

function TcxCustomGridView.IsDetailVisible(AGridView: TcxCustomGridView): Boolean;
begin
  Result := False;
end;

procedure TcxCustomGridView.FocusChanged(AFocused: Boolean);
begin
  if AFocused then
  begin
    DataController.SetFocus;
    Controller.SetFocus;
  end
  else
    Controller.RemoveFocus;
end;

procedure TcxCustomGridView.LoadingComplete;
begin
  SizeChanged;
end;

procedure TcxCustomGridView.LookAndFeelChanged;
var
  I: Integer;
begin
  for I := 0 to CloneCount - 1 do
    Clones[I].LookAndFeelChanged;
end;

procedure TcxCustomGridView.NotifyControl(AChangeKind: TcxGridViewChangeKind);
begin
  if Control <> nil then
    TcxCustomGridAccess(Control).ViewChanged(Self, AChangeKind);
end;

procedure TcxCustomGridView.RestoringComplete;
begin
end;

procedure TcxCustomGridView.SetLevel(Value: TComponent);
begin
  if FLevel <> Value then
  begin
    //BeforeLevelChange;
    FLevel := Value;
    Site.InitTabStop(Site.Parent);
  end;
end;

procedure TcxCustomGridView.SetTabStop(Value: Boolean);
begin
  Site.TabStop := Value and CanTabStop;
end;

procedure TcxCustomGridView.UpdateControl(AInfo: TcxUpdateControlInfo);
begin
end;

function TcxCustomGridView.GetViewInfoCacheClass: TcxCustomGridViewInfoCacheClass;
begin
  Result := TcxCustomGridViewInfoCache;
end;

function TcxCustomGridView.GetBackgroundBitmapsClass: TcxCustomGridBackgroundBitmapsClass;
begin  {4}
  Result := TcxCustomGridBackgroundBitmaps;
end;

function TcxCustomGridView.GetOptionsSelectionClass: TcxCustomGridOptionsSelectionClass;
begin
  Result := TcxCustomGridOptionsSelection;
end;

function TcxCustomGridView.GetOptionsViewClass: TcxCustomGridOptionsViewClass;
begin
  Result := TcxCustomGridOptionsView;
end;

function TcxCustomGridView.GetStylesClass: TcxCustomGridViewStylesClass;
begin
  Result := TcxCustomGridViewStyles;
end;

procedure TcxCustomGridView.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridView then
  begin
    BeginUpdate;
    try
      BeforeAssign(TcxCustomGridView(Source));
      DoAssign(TcxCustomGridView(Source));
      AfterAssign(TcxCustomGridView(Source));
    finally
      EndUpdate;
    end;
  end
  else
    inherited;
end;

function TcxCustomGridView.GetParentComponent: TComponent;
begin                     {5}
  Result := FStorageControl;
  if Result = nil then
    Result := FRepository;
end;

function TcxCustomGridView.HasParent: Boolean;
begin                     {5}
  Result := (FStorageControl <> nil) or (FRepository <> nil);
end;

function TcxCustomGridView.HasAsClone(AGridView: TcxCustomGridView): Boolean;
begin
  Result := FClones.IndexOf(AGridView) <> -1;
end;

function TcxCustomGridView.HasAsMaster(AGridView: TcxCustomGridView): Boolean;
begin
  Result := (MasterGridView = AGridView) or
    (MasterGridView <> nil) and MasterGridView.HasAsMaster(AGridView);
end;

procedure TcxCustomGridView.Invalidate(AHardUpdate: Boolean = False);
var
  I: Integer;
begin
  if IsPattern then
    for I := 0 to CloneCount - 1 do
      Clones[I].Invalidate(AHardUpdate)
  else
    if AHardUpdate then
      LayoutChanged
    else
      ViewChanged;
end;

procedure TcxCustomGridView.RestoreDefaults;
begin
end;

procedure TcxCustomGridView.SetParentComponent(Value: TComponent);
begin     {5}
  inherited;
  if Value is TcxGridViewRepository then
    TcxGridViewRepositoryAccess(Value).AddItem(Self);
end;

procedure TcxCustomGridView.BeginUpdate;
begin
  if Control <> nil then  {5}
    TcxCustomGrid(Control).BeginUpdate;
  DataController.BeginUpdate;
end;

procedure TcxCustomGridView.CancelUpdate;
begin
  DataController.EndUpdate;
  if Control <> nil then  {5}
    TcxCustomGrid(Control).CancelUpdate;
end;

function TcxCustomGridView.Changed(AGridChange: TObject): Boolean;
begin
  Result := True;
  if IsLoading or IsDestroying {or IsPattern} or FViewInfo.IsCalculating then
  begin
    AGridChange.Free;
    Result := False;
  end
  else
    if Control = nil{5} then
      try
        with AGridChange as TcxCustomGridChange do  {7}
        begin
          Control := nil;
          Execute;
        end
      finally
        AGridChange.Free;
      end
    else
      TcxCustomGrid(Control).Changed(AGridChange as TcxCustomGridChange);
end;

procedure TcxCustomGridView.EndUpdate;
begin
  try
    if DataController <> nil then
      DataController.EndUpdate;
  finally
    if Control <> nil then  {5}
      TcxCustomGrid(Control).EndUpdate;
  end;    
end;

procedure TcxCustomGridView.BoundsChanged(AUpdateSelfOnly: Boolean = False;
  AKeepMaster: Boolean = False);
begin
  if ResizeOnBoundsChange then
    SizeChanged(AUpdateSelfOnly, AKeepMaster)
  else
    LayoutChanged(AUpdateSelfOnly);
end;

procedure TcxCustomGridView.LayoutChanged(AUpdateSelfOnly: Boolean = True);

  function GetParameter: TcxCustomGridView;
  begin
    if AUpdateSelfOnly then
      Result := Self
    else
      Result := nil;
  end;

begin
  Changed(TcxGridLayoutChange.Create(GetParameter));
end;

function TcxCustomGridView.SizeChanged(AUpdateSelfOnly: Boolean = False;
  AKeepMaster: Boolean = False): Boolean;
begin
  Result := Changed(TcxGridSizeChange.Create(Self,
    AUpdateSelfOnly or (Control = nil){7}, AKeepMaster));
end;

procedure TcxCustomGridView.ViewChanged;
begin
  Changed(TcxGridViewChange.Create(Self));
end;

procedure TcxCustomGridView.ViewChanged(const AUpdateRect: TRect);
begin
  if not IsRectEmpty(AUpdateRect) then
    Changed(TcxGridViewChange.Create(Self, AUpdateRect));
end;

procedure TcxCustomGridView.RestoreFromIniFile(AStorageName: string;
  AChildrenCreating, AChildrenDeleting: Boolean; AOptions: TcxGridStorageOptions;
  const ARestoreViewName: string);
var
  AStorage: TcxStorage;
  AModes: TcxStorageModes;
begin
  FStoringName := ARestoreViewName;
  AStorage := TcxStorage.Create(AStorageName);
  try
    if not IsStoringNameMode then
      AStorage.NamePrefix := Owner.Name;
    FStorageOptions := AOptions;
    AModes := [];
    if AChildrenCreating then
      Include(AModes, smChildrenCreating);
    if AChildrenDeleting then
      Include(AModes, smChildrenDeleting);
    AStorage.Modes := AModes;
    BeginUpdate;
    try
      AStorage.RestoreFromIni(Self);
      RestoringComplete;
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomGridView.RestoreFromRegistry(AStorageName: string;
  AChildrenCreating, AChildrenDeleting: Boolean; AOptions: TcxGridStorageOptions;
  const ARestoreViewName: string);
var
  AStorage: TcxStorage;
  AModes: TcxStorageModes;
begin
  FStoringName := ARestoreViewName;
  AStorage := TcxStorage.Create(AStorageName);
  try
    if not IsStoringNameMode then
      AStorage.NamePrefix := Owner.Name;
    FStorageOptions := AOptions;
    AModes := [];
    if AChildrenCreating then
      Include(AModes, smChildrenCreating);
    if AChildrenDeleting then
      Include(AModes, smChildrenDeleting);
    AStorage.Modes := AModes;
    BeginUpdate;
    try
      AStorage.RestoreFromRegistry(Self);
      RestoringComplete;
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomGridView.RestoreFromStream(AStream: TStream;
  AChildrenCreating, AChildrenDeleting: Boolean; AOptions: TcxGridStorageOptions;
  const ARestoreViewName: string);
var
  AStorage: TcxStorage;
  AModes: TcxStorageModes;
begin
  FStoringName := ARestoreViewName;
  AStorage := TcxStorage.Create(AStream);
  try
    if not IsStoringNameMode then
      AStorage.NamePrefix := Owner.Name;
    FStorageOptions := AOptions;
    AModes := [];
    if AChildrenCreating then
      Include(AModes, smChildrenCreating);
    if AChildrenDeleting then
      Include(AModes, smChildrenDeleting);
    AStorage.Modes := AModes;
    BeginUpdate;
    try
      AStorage.RestoreFromStream(Self);
      RestoringComplete;
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomGridView.StoreToIniFile(AStorageName: string; AReCreate: Boolean;
  AOptions: TcxGridStorageOptions; const ASaveViewName: string);
var
  AStorage: TcxStorage;
begin
  FStoringName := ASaveViewName;
  AStorage := TcxStorage.Create(AStorageName);
  try
    FStorageOptions := AOptions;
    if ASaveViewName = '' then
      AStorage.NamePrefix := Owner.Name;
    AStorage.ReCreate := AReCreate;
    AStorage.StoreToIni(Self);
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomGridView.StoreToRegistry(AStorageName: string; AReCreate: Boolean;
  AOptions: TcxGridStorageOptions; const ASaveViewName: string);
var
  AStorage: TcxStorage;
begin
  FStoringName := ASaveViewName;
  AStorage := TcxStorage.Create(AStorageName);
  try
    FStorageOptions := AOptions;
    if ASaveViewName = '' then
      AStorage.NamePrefix := Owner.Name;
    AStorage.ReCreate := AReCreate;
    AStorage.StoreToRegistry(Self);
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomGridView.StoreToStream(AStream: TStream; AOptions: TcxGridStorageOptions;
  const ASaveViewName: string);
var
  AStorage: TcxStorage;
begin
  FStoringName := ASaveViewName;
  AStorage := TcxStorage.Create(AStream);
  try
    FStorageOptions := AOptions;
    if ASaveViewName = '' then
      AStorage.NamePrefix := Owner.Name;
    AStorage.StoreToStream(Self);
  finally
    AStorage.Free;
  end;
end;

{ functions }

function GetParentGridView(AControl: TControl): TcxCustomGridView;
begin
  while (AControl <> nil) and not (AControl is TcxGridSite) do
    AControl := AControl.Parent;
  if AControl = nil then
    Result := nil
  else
    Result := TcxGridSite(AControl).GridView;
end;

initialization
  GridHitTests := TGridHitTests.Create;
  cxGridRegisteredViews := TcxRegisteredClasses.Create(True);

finalization
  FreeAndNil(cxGridRegisteredViews);
  FreeAndNil(GridHitTests);

end.
