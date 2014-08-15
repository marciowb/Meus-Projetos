{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{                   ExpressScheduler                                 }
{                                                                    }
{       Copyright (c) 2003-2010 Developer Express Inc.               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSCHEDULER AND ALL ACCOMPANYING }
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

unit cxSchedulerCustomControls;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}  
  Types,
{$ENDIF}
  Classes, SysUtils, Windows, Messages, Forms, StdCtrls, Controls, Graphics,
  cxControls, Math, cxGraphics, cxGeometry, cxLookAndFeels, cxLookAndFeelPainters,
  cxFormats, cxSchedulerUtils, cxSchedulerStorage, cxStyles, cxClasses, cxEdit,
  cxDateUtils, ExtCtrls, Menus, cxStorage, cxTextEdit;

const
  // resize bitmap capacity
  cxSizeDelta = 32;

  //hittest codes
  //base class
  htcControl  = $0;
  htcTime     = $1;
  //custom viewinfo
  htcResource = $2;

  // style indexes
  cxcsBackground      = 0;
  cxcsContent         = 1;
  cxcsEvent           = 2;
  cxcsGroupSeparator  = 3;
  cxcsDayHeader       = 4;
  cxcsSelection       = 5;
  cxcsHSplitter       = 6;
  cxcsVSplitter       = 7;
  cxcsResourceHeader  = 8;
  cxcsMaxValue        = cxcsResourceHeader;
  // for PS
  cxcsSchedulerStyleFirst = cxcsBackground;
  cxcsSchedulerStyleLast  = cxcsMaxValue;

  // default property values
  cxDefaultSchedulerHeight     = 250;
  cxDefaultSchedulerWidth      = 350;
  cxDefaultSplitterWidth       = 5;
  cxDefaultGroupSeparatorWidth = 11;

  // minimal property values
  cxMinSplitterWidth   = 3;

  // hint timings
  cxscWaitForHideHint: Integer = 5000;
  cxscWaitForShowHint: Integer = 1000;
  cxscMinHintWindth: Integer = 150;

type
  TcxCustomScheduler = class;

  TcxSchedulerSubControl = class;
  TcxSchedulerSubControlController = class;
  TcxSchedulerSubControlHitTest = class;
  TcxSchedulerSubControlPainter = class;
  TcxSchedulerSubControlViewInfo = class;
  TcxSchedulerSplitter = class;
  TcxSchedulerStyles = class;
  // popup menus
  TcxSchedulerContentPopupMenu = class;
  TcxSchedulerEventPopupMenu = class;

  TcxSchedulerViewController = class;
  TcxSchedulerCustomView = class;
  TcxSchedulerCustomViewClass = class of TcxSchedulerCustomView;
  TcxSchedulerCustomViewViewInfo = class;
  TcxDragHelper = class;
  TcxDragEventHelper = class;
  TcxEventSizingHelper = class;
  TcxSchedulerCustomDateNavigator = class;

  TcxControlFlag = (cfInvalidLayout, cfLocked, cfImageValid, cfViewValid);
  TcxControlFlags = set of TcxControlFlag;

  TcxSchedulerSplitterKind = (skHorizontal, skVertical);
  TcxSchedulerViewPosition = (vpRight, vpLeft);

  TcxSchedulerGroupingKind = (gkDefault, gkNone, gkByDate, gkByResource);
  TcxSchedulerViewMode = (vmDay, vmWeek, vmMonth, vmWorkWeek);

  TcxOnDeleteEventFunc = function (AEvent: TcxSchedulerControlEvent): Boolean of object;

  { TcxSchedulerSubControl }

  TcxSchedulerSubControl = class(TPersistent)
  private
    FCanvas: TcxCanvas;
    FController: TcxSchedulerSubControlController;
    FCursor: TCursor;
    FHeight: Integer;
    FHitTest: TcxSchedulerSubControlHitTest;
    FLeft: Integer;
    FPainter: TcxSchedulerSubControlPainter;
    FScheduler: TcxCustomScheduler;
    FTop: Integer;
    FViewInfo: TcxSchedulerSubControlViewInfo;
    FVisible: Boolean;
    FWidth: Integer;
  {$IFNDEF DEBUGPAINT}
    function GetBitmap: TBitmap;
  {$ENDIF}
    function GetBottom: Integer;
    function GetBounds: TRect;
    function GetDateTimeHelperClass: TcxSchedulerDateTimeHelperClass;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
    function GetPainterHelperClass: TcxSchedulerPainterHelperClass;
    function GetRight: Integer;
    function GetStyles: TcxSchedulerStyles;
    procedure InternalSetBounds(const AValue: TRect);
    procedure SetBottom(const Value: Integer);
    procedure SetHeight(AValue: Integer);
    procedure SetLeft(AValue: Integer);
    procedure SetRight(Value: Integer);
    procedure SetTop(AValue: Integer);
    procedure SetVisible(AValue: Boolean);
    procedure SetWidth(AValue: Integer);
  protected
    // store interface
    procedure GetProperties(AProperties: TStrings); virtual;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); virtual;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); virtual;
    //
    function AllowDesignHitTest(X, Y: Integer; AShift: TShiftState): Boolean; virtual;
    procedure BoundsChanged; virtual;
    procedure CalculateViewInfo; virtual; 
    function CanCapture(const APoint: TPoint): Boolean; virtual;
    procedure Changed; virtual;
    function CreateController: TcxSchedulerSubControlController; virtual;
    function CreateHitTest: TcxSchedulerSubControlHitTest; virtual;
    function CreatePainter: TcxSchedulerSubControlPainter; virtual;
    function CreateViewInfo: TcxSchedulerSubControlViewInfo; virtual;

    procedure CreateSubClasses; virtual;
    procedure DestroySubClasses; virtual;
    procedure DoBeforeMouseDown(AButton: TMouseButton; AShift: TShiftState; X, Y: Integer);
    procedure DoCancelMode; virtual;
    procedure DoLayoutChanged; virtual;
    procedure DoMouseDown(AButton: TMouseButton; AShift: TShiftState; X, Y: Integer);
    procedure DoMouseMove(AShift: TShiftState; X, Y: Integer);
    procedure DoMouseUp(AButton: TMouseButton; AShift: TShiftState; X, Y: Integer);
    procedure DoPaint; virtual;
    procedure FormatChanged; virtual;
    function GetClientRect: TRect; virtual;
    function GetOwner: TPersistent; override;
    function GetHScrollBarBounds: TRect; virtual;
    function GetSizeGripBounds: TRect; virtual;
    function GetStartOfWeek: TDay; virtual;
    function GetVScrollBarBounds: TRect; virtual;
    procedure InitScrollBarsParameters; virtual;
    procedure MousePositionChanged(var X, Y: Integer);
    procedure Notification(AComponent: TComponent; Operation: TOperation); virtual;
    procedure Paint;
    procedure PeriodChanged; virtual;
    procedure SetScrollBarInfo(AScrollBarKind: TScrollBarKind;
      AMin, AMax, AStep, APage, APos: Integer; AAllowShow, AAllowHide: Boolean);
    procedure VisibleChanged; virtual;

    property Canvas: TcxCanvas read FCanvas;
  {$IFNDEF DEBUGPAINT}
    property Bitmap: TBitmap read GetBitmap;
  {$ENDIF}
    property Bottom: Integer read GetBottom write SetBottom;
    property ClientRect: TRect read GetClientRect;
    property Controller: TcxSchedulerSubControlController read FController;
    property Cursor: TCursor read FCursor write FCursor;
    property DateTimeHelper: TcxSchedulerDateTimeHelperClass read GetDateTimeHelperClass;
    property HitTest: TcxSchedulerSubControlHitTest read FHitTest;
    property Left: Integer read FLeft write SetLeft;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
    property Painter: TcxSchedulerSubControlPainter read FPainter;
    property PainterHelper: TcxSchedulerPainterHelperClass read GetPainterHelperClass;
    property Right: Integer read GetRight write SetRight;
    property Scheduler: TcxCustomScheduler read FScheduler;
    property StartOfWeek: TDay read GetStartOfWeek;
    property Styles: TcxSchedulerStyles read GetStyles;
    property Top: Integer read FTop write SetTop;
    property ViewInfo: TcxSchedulerSubControlViewInfo read FViewInfo;
    property Visible: Boolean read FVisible write SetVisible;
  public
    constructor Create(AOwner: TcxCustomScheduler); virtual;
    destructor Destroy; override;
    procedure Invalidate;
    procedure InvalidateRect(const ARect: TRect);
    procedure LayoutChanged;
    procedure Refresh;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);

    property Bounds: TRect read GetBounds write InternalSetBounds;
    property Height: Integer read FHeight write SetHeight;
    property Width: Integer read FWidth write SetWidth;
  end;

  { TcxSchedulerSubControlController }

  TcxSchedulerSubControlController = class(TcxIUnknownObject)
  private
    FOwner: TcxSchedulerSubControl;
    function GetHitTest: TcxSchedulerSubControlHitTest;
    function GetStartOfWeek: TDay;
  protected
    // drag'n'drop
    procedure BeginDragAndDrop; virtual;
    function CanDrag(X, Y: Integer): Boolean; virtual;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); virtual;
    procedure DragDrop(Source: TObject; X, Y: Integer); virtual;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); virtual;
    procedure EndDrag(Target: TObject; X, Y: Integer); virtual;
    procedure EndDragAndDrop(Accepted: Boolean); virtual;
    function GetDragAndDropObjectClass: TcxDragAndDropObjectClass; virtual;
    procedure StartDrag(var DragObject: TDragObject); virtual;
    function StartDragAndDrop(const P: TPoint): Boolean; virtual;
    // virtuals
    procedure BeforeMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure DoCancelMode; virtual;
    function GetCursor(X, Y: Integer): TCursor; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure KeyPress(var Key: Char); virtual;
    procedure KeyUp(var Key: Word; Shift: TShiftState); virtual;
    procedure MouseEnter; virtual;
    procedure MouseLeave; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure Reset; virtual;
  public
    constructor Create(AOwner: TcxSchedulerSubControl); virtual;

    property HitTest: TcxSchedulerSubControlHitTest read GetHitTest;
    property Owner: TcxSchedulerSubControl read FOwner;
    property StartOfWeek: TDay read GetStartOfWeek;
  end;

  { TcxSchedulerSubControlHitTest }

  TcxSchedulerSubControlHitTest = class
  private
    FOwner: TcxSchedulerSubControl;
    FHitPoint: TPoint;
    function GetPosValue(AIndex: Integer): Integer;
    function GetScheduler: TcxCustomScheduler;
    procedure SetHitPoint(const APoint: TPoint);
    procedure SetPosValue(AIndex, AValue: Integer);
  protected
    FTime: TDateTime;
    Flags: Int64;
    procedure Clear; virtual;
    procedure DoCalculate; virtual;
    function GetBitState(AIndex: Integer): Boolean;
    function GetMaskState(AMask: Integer): Boolean;
    function GetMaskStateEx(AMask: Integer): Boolean;
    procedure SetBitState(AIndex: Integer; AValue: Boolean);
    procedure SetMaskState(AMask: Integer; AValue: Boolean);
    property Owner: TcxSchedulerSubControl read FOwner;
    property Scheduler: TcxCustomScheduler read GetScheduler;
  public
    constructor Create(AOwner: TcxSchedulerSubControl); virtual;
    destructor Destroy; override;
    procedure Recalculate;
    
    property HitPoint: TPoint read FHitPoint write SetHitPoint;
    property HitX: Integer index 0 read GetPosValue write SetPosValue;
    property HitY: Integer index 1 read GetPosValue write SetPosValue;
    property HitAtControl: Boolean index htcControl read GetBitState;
    property HitAtTime: Boolean index htcTime read GetBitState;
    property Time: TDateTime read FTime;
  end;

  { TcxSchedulerSubControlPainter }

  TcxSchedulerSubControlPainter = class
  private
    FOwner: TcxSchedulerSubControl;
  {$IFNDEF DEBUGPAINT}
    function GetBitmap: TBitmap;
  {$ENDIF}
    function GetCanvas: TcxCanvas;
    function GetViewInfo: TcxSchedulerSubControlViewInfo;
  protected
    property Owner: TcxSchedulerSubControl read FOwner;
    property ViewInfo: TcxSchedulerSubControlViewInfo read GetViewInfo;
  public
    constructor Create(AOwner: TcxSchedulerSubControl); virtual;
    procedure Paint; virtual;

    property Canvas: TcxCanvas read GetCanvas;
  {$IFNDEF DEBUGPAINT}
    property Bitmap: TBitmap read GetBitmap;
  {$ENDIF}
  end;

  { TcxSchedulerSubControlViewInfo }

  TcxSchedulerSubControlViewInfo = class
  private
    FOwner: TcxSchedulerSubControl;
    function GetDateTimeHelperClass: TcxSchedulerDateTimeHelperClass;
    function GetDefaultFont: TFont;
    function GetIsSchedulerCreated: Boolean;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
    function GetPainterHelperClass: TcxSchedulerPainterHelperClass;
    function GetStyles: TcxSchedulerStyles;
  protected
    FBounds: TRect;
    procedure AfterCalculate; virtual;
    procedure Clear; virtual;
    procedure DoCalculate; virtual;
    function GetBounds: TRect; virtual;

    property DateTimeHelper: TcxSchedulerDateTimeHelperClass read GetDateTimeHelperClass;
    property DefaultFont: TFont read GetDefaultFont;
    property IsSchedulerCreated: Boolean read GetIsSchedulerCreated;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
    property Bounds: TRect read FBounds;
    property Owner: TcxSchedulerSubControl read FOwner;
    property PainterHelper: TcxSchedulerPainterHelperClass read GetPainterHelperClass;
    property Styles: TcxSchedulerStyles read GetStyles;
  public
    constructor Create(AOwner: TcxSchedulerSubControl); virtual;
    procedure Calculate; virtual;
  end;

  { TcxSchedulerControlBox }

  TcxSchedulerControlBox = class(TcxSchedulerSubControl)
  private
    FContainer: TWinControl;
    FControlAlign: TAlign;
    FControlParent: TWinControl;
    FControlRect: TRect;
    FControl: TControl;
    FViewParams: TcxViewParams;
    procedure RestorePosition;
    procedure SetControl(AValue: TControl);
    procedure StorePosition;
  protected
    // store interface
    procedure GetProperties(AProperties: TStrings); override;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); override;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); override;
    //
    procedure BoundsChanged; override;
    function CreateWndContainerControl: TWinControl; virtual;
    procedure DoPaint; override;
    procedure DoLayoutChanged; override;
    function HasAsParent(AValue: TControl): Boolean;
    procedure VisibleChanged; override;
    
    property ViewParams: TcxViewParams read FViewParams;
  public
    constructor Create(AOwner: TcxCustomScheduler); override;
    procedure Assign(Source: TPersistent); override;
    
    property Container: TWinControl read FContainer;
    property Height;
    property Width;
  published
    property Control: TControl read FControl write SetControl;
    property Visible default True;
  end;

  { TcxSchedulerSplitterController }

  TcxSchedulerSplitterController = class(TcxSchedulerSubControlController)
  private
    FHitPoint: TPoint;
    FPrevInvertRect: TRect;
    FPrevRect: TRect;
    FSaveKeyboardListener: TcxSchedulerSubControl;
    FSizingBoundsRect: TRect;
    FStartBounds: TRect;
    FScreenCanvasClipRect: TRect;
    function GetDrawClipRect: TRect;
    function GetHorzSizingRect(const P: TPoint): TRect;
    function GetScheduler: TcxCustomScheduler;
    function GetScreenOffset: TPoint;
    function GetSplitter: TcxSchedulerSplitter;
    function GetVertSizingRect(const P: TPoint): TRect;
    procedure SetHorzBounds(var R: TRect);
    procedure SetHorzDelta(ADelta: Integer);
    procedure SetVertBounds(var R: TRect);
    procedure SetVertDelta(ADelta: Integer);
  protected
    // override
    procedure DoCancelMode; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    // methods
    procedure DrawInvertRect(const R: TRect);
    procedure EraseInvertRect;
    function GetMonthSize: TSize;
    function GetOwnerMousePos(X, Y: Integer): TPoint;
    function GetSizingBoundsRect: TRect;
    function GetSizingIncrement: Integer;
    function GetSizingRect(const P: TPoint): TRect;
    procedure InvertRect(ACanvas: TcxCanvas; R: TRect);
    function IsIntegralSizing: Boolean;
    function IsDynamicUpdate: Boolean;
    procedure SetSizeDelta(ADelta: Integer);
    procedure UpdateSizing(const R: TRect);

    property Scheduler: TcxCustomScheduler read GetScheduler;
    property ScreenCanvasClipRect: TRect read FScreenCanvasClipRect;
    property ScreenOffset: TPoint read GetScreenOffset;
    property SizingBoundsRect: TRect read FSizingBoundsRect;
    property Splitter: TcxSchedulerSplitter read GetSplitter;
  end;

  { TcxSchedulerSplitter }

  TcxSchedulerSplitter = class(TcxSchedulerSubControl)
  private
    FKind: TcxSchedulerSplitterKind;
    FViewParams: TcxViewParams;
  protected
    function AllowDesignHitTest(X, Y: Integer; AShift: TShiftState): Boolean; override;
    function CreateController: TcxSchedulerSubControlController; override;
    procedure DoLayoutChanged; override;
    procedure DoPaint; override;
    procedure SetKind(AKind: TcxSchedulerSplitterKind); virtual;
    procedure UpdateCursor;

    property ViewParams: TcxViewParams read FViewParams;
  public
    property Kind: TcxSchedulerSplitterKind read FKind;
  end;

  { TcxSchedulerOptionsData }

  TcxSchedulerEventOperations = class(TPersistent)
  private
    FScheduler: TcxCustomScheduler;
    FCreating: Boolean;
    FDeleting: Boolean;
    FDialogEditing: Boolean;
    FDialogShowing: Boolean;
    FInplaceEditing: Boolean;
    FMoving: Boolean;
    FMovingBetweenResources: Boolean;
    FReadOnly: Boolean;
    FRecurrence: Boolean;
    FSizing: Boolean;
    function GetCreating: Boolean;
    function GetCreatingStored: Boolean;
    function GetDeleting: Boolean;
    function GetDeletingStored: Boolean;
    function GetDialogEditing: Boolean;
    function GetDialogEditingStored: Boolean;
    function GetInplaceEditing: Boolean;
    function GetInplaceEditingStored: Boolean;
    function GetMoving: Boolean;
    function GetMovingBetweenResources: Boolean;
    function GetMovingBetweenResourcesStored: Boolean;
    function GetMovingStored: Boolean;
    function GetSizing: Boolean;
    function GetSizingStored: Boolean;
  protected
    function GetOwner: TPersistent; override;

    property Scheduler: TcxCustomScheduler read FScheduler;
  public
    constructor Create(AOwner: TcxCustomScheduler); virtual;
    procedure Assign(Source: TPersistent); override;
  published
    property Creating: Boolean
      read GetCreating write FCreating stored GetCreatingStored;
    property Deleting: Boolean
      read GetDeleting write FDeleting stored GetDeletingStored;
    property DialogEditing: Boolean
      read GetDialogEditing write FDialogEditing stored GetDialogEditingStored;
    property DialogShowing: Boolean read FDialogShowing write FDialogShowing default True;
    property InplaceEditing: Boolean
      read GetInplaceEditing write FInplaceEditing stored GetInplaceEditingStored;
    property MovingBetweenResources: Boolean
      read GetMovingBetweenResources write FMovingBetweenResources
      stored GetMovingBetweenResourcesStored;
    property Moving: Boolean
      read GetMoving write FMoving stored GetMovingStored;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property Recurrence: Boolean read FRecurrence write FRecurrence default True;
    property Sizing: Boolean read GetSizing write FSizing stored GetSizingStored;
  end;

  { TcxSchedulerOptionsCustomize }

  TcxSchedulerOptionsCustomize = class(TPersistent)
  private
    FControlsSizing: Boolean;
    FDynamicSizing: Boolean;
    FIntegralSizing: Boolean;
    FScheduler: TcxCustomScheduler;
    procedure SetControlsSizing(AValue: Boolean);
    procedure SetIntegralSizing(AValue: Boolean);
  protected
    procedure Changed; virtual;
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TcxCustomScheduler); virtual;
    procedure Assign(Source: TPersistent); override;

    property Scheduler: TcxCustomScheduler read FScheduler;
  published
    property ControlsSizing: Boolean read FControlsSizing write SetControlsSizing default True;
    property DynamicSizing: Boolean read FDynamicSizing write FDynamicSizing default False;
    property IntegralSizing: Boolean read FIntegralSizing write SetIntegralSizing default True;
  end;

  { TcxSchedulerOptionsView }

  TcxSchedulerOptionsView = class(TPersistent)
  private
    FActualStartOfWeek: TDay;
    FDayBorderColor: TColor;
    FShowEventsWithoutResource: Boolean;
    FGroupSeparatorWidth: Integer;
    FGroupingKind: TcxSchedulerGroupingKind;
    FHideSelection: Boolean;
    FHorzSplitterWidth: Integer;
    FHotTrack: Boolean;
    FRotateResourceCaptions: Boolean;
    FScheduler: TcxCustomScheduler;
    FShowAdditionalTimeZone: Boolean;
    FShowHints: Boolean;
    FStartOfWeek: TcxStartOfWeek;
    FTimeZoneLabels: array[0..1] of string;
    FTimeZones: array[0..1] of Integer;
    FVertSplitterWidth: Integer;
    FViewPosition: TcxSchedulerViewPosition;
    FWorkDays: TDays;
    FWorkFinish: TTime;
    FWorkStart: TTime;
    function GetDateTimeHelperClass: TcxSchedulerDateTimeHelperClass;
    function GetTimeZone(AIndex: Integer): Integer;
    function GetTimeZoneLabel(AIndex: Integer): string;
    procedure SetDayBorderColor(AValue: TColor);
    procedure SetShowEventsWithoutResource(AValue: Boolean);
    procedure SetGroupSeparatorWidth(AValue: Integer);
    procedure SetGroupingKind(AValue: TcxSchedulerGroupingKind);
    procedure SetHideSelection(AValue: Boolean);
    procedure SetHorzSplitterWidth(AValue: Integer);
    procedure SetRotateResourceCaptions(AValue: Boolean);
    procedure SetShowAdditionalTimeZone(AValue: Boolean);
    procedure SetSplitterWidth(AValue: Integer; var AWidth: Integer);
    procedure SetStartOfWeek(AValue: TcxStartOfWeek);
    procedure SetTimeZone(AIndex, AValue: Integer);
    procedure SetTimeZoneLabel(AIndex: Integer; const AValue: string);
    procedure SetVertSplitterWidth(AValue: Integer);
    procedure SetViewPosition(AValue: TcxSchedulerViewPosition);
    procedure SetWorkDays(AValue: TDays);
    procedure SetWorkFinish(AValue: TTime);
    procedure SetWorkStart(AValue: TTime);
    function IsTimeZoneLabelStored(AIndex: Integer): Boolean;
  protected
    procedure CalculateActualStartOfWeek;
    procedure Changed; virtual;
    function GetOwner: TPersistent; override;
    function IsWorkDaysStored: Boolean;
    function IsWorkFinishStored: Boolean;
    function IsWorkStartStored: Boolean;
    function IsWorkTime(const ADateTime: TDateTime): Boolean;

    property DateTimeHelper: TcxSchedulerDateTimeHelperClass read GetDateTimeHelperClass;
    property HotTrack: Boolean read FHotTrack write FHotTrack default False;//True;
  public
    constructor Create(AOwner: TcxCustomScheduler); virtual;
    procedure Assign(Source: TPersistent); override;

    property ActualStartOfWeek: TDay read FActualStartOfWeek;
    property Scheduler: TcxCustomScheduler read FScheduler;
  published
    property AdditionalTimeZone: Integer index 0 read GetTimeZone write SetTimeZone default -1;
    property AdditionalTimeZoneLabel: string index 0 read GetTimeZoneLabel write SetTimeZoneLabel stored IsTimeZoneLabelStored;
    property CurrentTimeZone: Integer index 1 read GetTimeZone write SetTimeZone default -1;
    property CurrentTimeZoneLabel: string index 1 read GetTimeZoneLabel write SetTimeZoneLabel stored IsTimeZoneLabelStored;
    property DayBorderColor: TColor read FDayBorderColor write SetDayBorderColor default clDefault;
    property ShowEventsWithoutResource: Boolean read FShowEventsWithoutResource write SetShowEventsWithoutResource default False;
    property GroupSeparatorWidth: Integer read FGroupSeparatorWidth write SetGroupSeparatorWidth default cxDefaultGroupSeparatorWidth;
    property GroupingKind: TcxSchedulerGroupingKind read FGroupingKind write SetGroupingKind default gkDefault;
    property HideSelection: Boolean read  FHideSelection write SetHideSelection default False;
    property HorzSplitterWidth: Integer read FHorzSplitterWidth write SetHorzSplitterWidth default cxDefaultSplitterWidth;
    property RotateResourceCaptions: Boolean read FRotateResourceCaptions write SetRotateResourceCaptions default True;
    property ShowAdditionalTimeZone: Boolean read FShowAdditionalTimeZone write SetShowAdditionalTimeZone default False;
    property ShowHints: Boolean read FShowHints write FShowHints default True;
    property StartOfWeek: TcxStartOfWeek read FStartOfWeek write SetStartOfWeek default swSystem;
    property VertSplitterWidth: Integer read FVertSplitterWidth write SetVertSplitterWidth default cxDefaultSplitterWidth;
    property ViewPosition: TcxSchedulerViewPosition read FViewPosition write SetViewPosition default vpLeft;
    property WorkDays: TDays read FWorkDays write SetWorkDays stored IsWorkDaysStored;
    property WorkFinish: TTime read FWorkFinish write SetWorkFinish stored IsWorkFinishStored;
    property WorkStart: TTime read FWorkStart write SetWorkStart stored IsWorkStartStored;
  end;

  { TcxSchedulerViewHitTest }

  TcxEventDragKind = (edkNone, edkEventDragRect, edkMoveEvent, edkResizeStart, edkResizeEnd);

  TcxSchedulerViewHitTest = class(TcxSchedulerSubControlHitTest)
  private
    function GetHitAtEvent: Boolean;
  protected
    FNeedShowHint: Boolean;
    FEventBounds: TRect;
    FResource: TcxSchedulerStorageResourceItem;
    procedure Clear; override;
    function GetHitEvent: TcxSchedulerControlEvent; virtual;
    property NeedShowHint: Boolean read FNeedShowHint;
  public
    function GetDragKind: TcxEventDragKind; virtual;

    property HitAtEvent: Boolean read GetHitAtEvent;
    property HitAtResource: Boolean index htcResource read GetBitState;
    property Event: TcxSchedulerControlEvent read GetHitEvent;
    property Resource: TcxSchedulerStorageResourceItem read FResource;
  end;

  { TcxSchedulerEditController }

  TcxSchedulerEditController = class
  private
    FEdit: TcxCustomEdit;
    FEditData: TcxCustomEditData;
    FEditDate: TDateTime;
    FEditList: TcxInplaceEditList;
    FEditProperties: TcxCustomEditProperties;
    FEditResource: TcxSchedulerStorageResourceItem;
    FEvent: TcxSchedulerControlEvent;
    FFocused: Boolean;
    FIsEditing: Boolean;
    FIsNewEvent: Boolean;
    FOwner: TcxCustomScheduler;
    function CanAccept: Boolean;
    function GetController: TcxSchedulerViewController;
    function GetEditVisible: Boolean;
    function GetView: TcxSchedulerCustomView;
    procedure SetEditVisible(Value: Boolean);
  protected
    function GetEditRect(var R: TRect; const ADate: TDateTime;
      AResource: TcxSchedulerStorageResourceItem; AMakeVisible: Boolean = False): Boolean; virtual;
    procedure EditAfterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure EditExit(Sender: TObject); virtual;
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure EditKeyPress(Sender: TObject; var Key: Char); virtual;
    procedure EditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure EditPostEditValue(Sender: TObject); virtual;
    function InitEdit(AEvent: TcxSchedulerControlEvent): Boolean; virtual;
    function IsKeyForControl(var AKey: Word; Shift: TShiftState): Boolean; virtual;
    procedure PrepareEdit(AEdit: TcxCustomEdit); virtual;

    property EditProperties: TcxCustomEditProperties read FEditProperties;
    property EditData: TcxCustomEditData read FEditData;
    property Event: TcxSchedulerControlEvent read FEvent;
  public
    constructor Create(AOwner: TcxCustomScheduler); virtual;
    destructor Destroy; override;
    procedure Activate(AEvent: TcxSchedulerControlEvent); overload;
    procedure Activate(AEvent: TcxSchedulerControlEvent; const APos: TPoint; AShift: TShiftState); overload;
    procedure Activate(AEvent: TcxSchedulerControlEvent; Key: Char); overload;
    procedure CloseEdit(Accepted: Boolean); virtual;
    procedure Init(const AEditDate: TDateTime;
      AResource: TcxSchedulerStorageResourceItem; AIsNewEvent: Boolean = False);
    procedure UpdateEdit; virtual;
    procedure UpdateValue; virtual;
    
    property Controller: TcxSchedulerViewController read GetController;
    property Edit: TcxCustomEdit read FEdit;
    property EditVisible: Boolean read GetEditVisible write SetEditVisible;
    property Focused: Boolean read FFocused write FFocused;
    property IsEditing: Boolean read FIsEditing;
    property Scheduler: TcxCustomScheduler read FOwner;
    property View: TcxSchedulerCustomView read GetView;
  end;

  { TcxSchedulerViewNavigation }

  TcxSchedulerViewNavigation = class
  private
    FView: TcxSchedulerCustomView;
    function GetScheduler: TcxCustomScheduler;
    function GetSelAnchor: TDateTime;
    function GetSelRealStart: TDateTime;
    function GetSelFinish: TDateTime;
    function GetSelResource: TcxSchedulerStorageResourceItem;
    function GetSelStart: TDateTime;
    function GetTimeIncrement: TDateTime;
  protected
    FCurrentAnchor: TDateTime;
    FCurrentResource: TcxSchedulerStorageResourceItem;
    FShift: TShiftState;
    procedure DoKeyDown(var AKey: Word; AShift: TShiftState); virtual;
    function IsKeyNavigation(var AKey: Word; AShift: TShiftState): Boolean; virtual;
    function IsSingleLine: Boolean;
    function GetResourceItem: TcxSchedulerStorageResourceItem; virtual;
    procedure KeyDown(var AKey: Word; AShift: TShiftState); virtual;
    procedure ReplaceDate(ADate: TDateTime; AResource: TcxSchedulerStorageResourceItem = nil);
  public
    constructor Create(AView: TcxSchedulerCustomView);
    procedure CheckSelection;
    procedure ReplaceSelParams(const ASelStart, ASelFinish: TDateTime); overload;
    procedure ReplaceSelParams(const ASelStart, ASelFinish: TDateTime;
      AResource: TcxSchedulerStorageResourceItem); overload;
    procedure SetSelAnchor(const Anchor: TDateTime; AShift: TShiftState); overload;
    procedure SetSelAnchor(const Anchor: TDateTime; AShift: TShiftState;
      AResource: TcxSchedulerStorageResourceItem); overload;
    procedure ValidateSelection(var ASelStart, ASelFinish: TDateTime;
      var AResource: TcxSchedulerStorageResourceItem); virtual;

    property SelAnchor: TDateTime read GetSelAnchor;
    property SelFinish: TDateTime read GetSelFinish;
    property SelRealStart: TDateTime read GetSelRealStart;
    property SelResource: TcxSchedulerStorageResourceItem read GetSelResource;
    property SelStart: TDateTime read GetSelStart;
    property Scheduler: TcxCustomScheduler read GetScheduler;
    property TimeIncrement: TDateTime read GetTimeIncrement;
    property View: TcxSchedulerCustomView read FView;
  end;

  { TcxSchedulerViewController }

  TcxSchedulerViewController = class(TcxSchedulerSubControlController)
  private
    FEditShowingTimer: TTimer;
    FEditShowingTimerItem: TcxSchedulerControlEvent;
    FDragEventHelper: TcxDragEventHelper;
    FDragEvent: TcxSchedulerControlEvent;
    FDragKind: TcxEventDragKind;
    FLockShowEditorOnMouseClick: Boolean;
    FNavigation: TcxSchedulerViewNavigation;
    FStartDragFlags: Int64;
    FStartDragHitTime: TDateTime;
    FStartDragResource: TcxSchedulerStorageResourceItem;
    procedure EditShowingTimerHandler(Sender: TObject);
    function GetHitTest: TcxSchedulerViewHitTest;
//    function GetHotTrackController: TcxSchedulerHotTrackController;
    function GetEditController: TcxSchedulerEditController;
    function GetIsEditing: Boolean;
    function GetScheduler: TcxCustomScheduler;
    function GetView: TcxSchedulerCustomView;
    procedure ShowEventEditor(AEvent: TcxSchedulerControlEvent);
    procedure StartEditShowingTimer(AEvent: TcxSchedulerControlEvent);
    procedure StopEditShowingTimer;
  protected
    FStartSelAnchor: TDateTime;
    FBeforeFocusedEvent: TcxSchedulerControlEvent;
    procedure BeforeMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure CancelScroll; virtual;
    function CanDrag(X, Y: Integer): Boolean; override;
    procedure CheckOpenInplaceEditorOnMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure CheckScrolling(const APos: TPoint); virtual;
    procedure CloseInplaceEdit;
    function CreateDragEventHelper: TcxDragEventHelper; virtual;
    function CreateNavigation: TcxSchedulerViewNavigation; virtual;
    function CreateResizeEventHelper: TcxEventSizingHelper; virtual;
    procedure DoCancelMode; override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    procedure EndDrag(Target: TObject; X, Y: Integer); override;
    function GetDragAndDropObjectClass: TcxDragAndDropObjectClass; override;
    function GetResourceReadOnly: Boolean;
    function IsCaptionAvailable: Boolean;
    function IsDragOperation: Boolean;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
//    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
//    procedure MouseEnter; override;
//    procedure MouseLeave; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure RecreateNavigation;
    procedure StartDrag(var DragObject: TDragObject); override;
    function StartDragAndDrop(const P: TPoint): Boolean; override;
    procedure SyncEventSelection(AEvent: TcxSchedulerControlEvent); virtual;
    procedure UnselectEvents;
    procedure UpdateEventSelection(AEvent: TcxSchedulerControlEvent;
      Button: TMouseButton; Shift: TShiftState);

    property EditController: TcxSchedulerEditController read GetEditController;
    property DragEventHelper: TcxDragEventHelper read FDragEventHelper;
    property HitTest: TcxSchedulerViewHitTest read GetHitTest;
//    property HotTrackController: TcxSchedulerHotTrackController read GetHotTrackController;
    property View: TcxSchedulerCustomView read GetView;
  public
    constructor Create(AOwner: TcxSchedulerSubControl); override;
    destructor Destroy; override;
    function CanCreateEventUsingDialog: Boolean; virtual;
    function CanCreateEventUsingInplaceEdit: Boolean; virtual;
    function CanEditEvent(AEvent: TcxSchedulerControlEvent; AInplace: Boolean): Boolean; virtual;
    function CanShowEventDialog: Boolean; virtual;
    procedure DeleteSelectedEvents;
    function IsEventEditing(AEvent: TcxSchedulerControlEvent; AResource: TcxSchedulerStorageResourceItem): Boolean;
    procedure SelectSingleEvent(AEvent: TcxSchedulerControlEvent; ADate: TDateTime; AMakeVisible: Boolean = True);

    property DragEvent: TcxSchedulerControlEvent read FDragEvent;
    property DragKind: TcxEventDragKind read FDragKind;
    property IsEditing: Boolean read GetIsEditing;
    property Navigation: TcxSchedulerViewNavigation read FNavigation;
    property Scheduler: TcxCustomScheduler read GetScheduler;
    property StartDragFlags: Int64 read FStartDragFlags;
    property StartDragHitTime: TDateTime read FStartDragHitTime;
    property StartDragResource: TcxSchedulerStorageResourceItem read FStartDragResource;
  end;

  { TcxDragHelper }

  TcxDragHelper = class
  private
    FScheduler: TcxCustomScheduler;
    function GetController: TcxSchedulerViewController;
    function GetEvents: TcxSchedulerCachedEventList;
    function GetHitTest: TcxSchedulerViewHitTest;
  protected
    FPrevHitFlags: Int64;
    FPrevHitTime: TDateTime;
    FPrevHitResource: TcxSchedulerStorageResourceItem;
    FStartHitTime: TDateTime;
    FStartHitFlags: Int64;
    FStartResource: TcxSchedulerStorageResourceItem;
    // virtuals
    procedure BeginDrag; virtual;
    procedure DragOver(const P: TPoint; State: TDragState; var Accepted: Boolean); virtual;
    procedure EndDrag(Accepted: Boolean); virtual;
    function GetOriginHitTestMask: Int64; virtual;
    procedure GetOriginState; virtual;
    function HasChangedState: Boolean; virtual;
    function IsAtOrigin: Boolean; virtual;
    function IsShowResources: Boolean;
    function IsValidTime: Boolean; virtual;
    procedure RefreshCurrentView; virtual;
    procedure SetSelection; virtual;
    procedure UpdateState; virtual;

    property Controller: TcxSchedulerViewController read GetController;
    property Events: TcxSchedulerCachedEventList read GetEvents;
    property HitTest: TcxSchedulerViewHitTest read GetHitTest;
    property Scheduler: TcxCustomScheduler read FScheduler;
  public
    constructor Create(AScheduler: TcxCustomScheduler); virtual;
  end;

  { TcxDragEventHelper }

  TcxSchedulerDragObject = class(TcxDragControlObject)
  private
    FUseInternalCursors: Boolean;
  protected
    function GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor; override;
  public
    constructor Create(AControl: TControl); override;
  end;

  TcxDragEventHelper = class(TcxDragHelper)
  private
    FDragObject: TDragObject;
    FInNavigator: Boolean;
    FSaveCursor: TCursor;
    function GetClones: TcxSchedulerFilteredEventList;
    function GetDateNavigator: TcxSchedulerCustomDateNavigator;
    function GetViewInfo: TcxSchedulerCustomViewViewInfo;
  protected
    FPrevIsDragCopy: Boolean;
    procedure ApplyChanges; virtual;
    procedure BeginDrag; override;
    procedure CheckAccepted(var Accepted: Boolean); virtual;
    procedure CheckVisibility(Accepted: Boolean);
    procedure CorrectAllDayEventProperty; virtual;
    procedure DragOver(const P: TPoint; State: TDragState; var Accepted: Boolean); override;
    procedure EndDrag(Accepted: Boolean); override;
    function GetClonesVisible(Accepted: Boolean): Boolean; virtual;
    function GetIsDragCopy: Boolean; virtual;
    procedure GetOriginState; override;
    function GetSourcesVisible(Accepted: Boolean): Boolean; virtual;
    function HasChangedState: Boolean; override;
    function IsValidNavigatorDate: Boolean; virtual;
    function IsValidTime: Boolean; override;
    procedure PrepareClones;
    procedure ProcessDateNavigator;
    procedure RestoreAllDayProperties;
    procedure SetSelection; override;
    procedure UpdateClones; virtual;
    procedure UpdateClonesTime; virtual;
    procedure UpdateDateNavigator(var Accepted: Boolean); virtual;
    procedure UpdateEventProperties; virtual;
    procedure UpdateState; override;

    property Clones: TcxSchedulerFilteredEventList read GetClones;
    property DateNavigator: TcxSchedulerCustomDateNavigator read GetDateNavigator;
    property DragObject: TDragObject read FDragObject;
    property InNavigator: Boolean read FInNavigator;
    property IsDragCopy: Boolean read GetIsDragCopy;
    property ViewInfo: TcxSchedulerCustomViewViewInfo read GetViewInfo;
  end;

  { TcxEventSizingHelper }

  TcxEventSizingHelper = class(TcxDragHelper)
  private
    function GetEvent: TcxSchedulerControlEvent;
    function GetHitTest: TcxSchedulerViewHitTest;
  protected
    procedure BeginDrag; override;
    procedure DragOver(const P: TPoint; State: TDragState; var Accepted: Boolean); override;
    procedure EndDrag(Accepted: Boolean); override;
    function GetDragCursor(Accepted: Boolean): TCursor; virtual;
    function IsValidTime: Boolean; override;
    // Event handling
    procedure CalcAllDayEvent; virtual;
    function GetFinishTime: TDateTime; virtual;
    function GetStartTime: TDateTime; virtual;
    procedure UpdateEventBounds; virtual;

    property Event: TcxSchedulerControlEvent read GetEvent;
    property HitTest: TcxSchedulerViewHitTest read GetHitTest;
  end;

  { TcxSchedulerDragAndDropObject }

  TcxSchedulerDragAndDropObject = class(TcxDragAndDropObject)
  private
    FSizingHelper: TcxEventSizingHelper;
    FScheduler: TcxCustomScheduler;
    function GetController: TcxSchedulerViewController;
    function GetHitTest: TcxSchedulerViewHitTest;
  protected
    procedure BeginDragAndDrop; override;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    function GetDragAndDropCursor(Accepted: Boolean): TCursor; override;
  public
    constructor Create(AControl: TcxControl); override;

    property Controller: TcxSchedulerViewController read GetController;
    property SizingHelper: TcxEventSizingHelper read FSizingHelper;
    property HitTest: TcxSchedulerViewHitTest read GetHitTest;
    property Scheduler: TcxCustomScheduler read FScheduler;
  end;

  { TcxSchedulerHintController }

  TcxSchedulerHintController = class
  protected
    FAutoHide: Boolean;
    FHintWindow: THintWindow;
    FOwner: TcxCustomScheduler;
    FHintFlags: Integer;
    FHintRect: TRect;
    FHintText: string;
    FTimer: TTimer;
    procedure CheckHintClass;
    procedure HideHint; virtual;
    procedure ShowHint; virtual;
    procedure StartHideHintTimer;
    procedure StartShowHintTimer;
    procedure StopTimer;
    procedure TimerHandler(Sender: TObject);
  public
    constructor Create(AOwner: TcxCustomScheduler); virtual;
    destructor Destroy; override;
    procedure Activate(const AHintRect: TRect;
      const AHintText: string; AImmediateHint: Boolean = False); virtual;
    function CalcHintRect(AMaxWidth: Integer;
      const AHintText: string; AFlags: Integer): TRect;
    procedure Hide;
    procedure Reset;
    property Scheduler: TcxCustomScheduler read FOwner;
  end;

  { TcxSchedulerEventHitTestController }

  TcxSchedulerEventHitTestController = class
  private
    function GetHintController: TcxSchedulerHintController;
    function GetHitTest: TcxSchedulerViewHitTest;
  protected
    FOwner: TcxCustomScheduler;
    FPrevHintEvent: TcxSchedulerControlEvent;
  public
    constructor Create(AOwner: TcxCustomScheduler); virtual;
    procedure MouseMove(X, Y: Integer; AShift: TShiftState); virtual;
    property HitTest: TcxSchedulerViewHitTest read GetHitTest;
    property HintController: TcxSchedulerHintController read GetHintController;
    property Scheduler: TcxCustomScheduler read FOwner;
  end;

  { TcxSchedulerCustomView }

  TcxSchedulerCustomView = class(TcxSchedulerSubControl)
  private
    FCanShow: Boolean;
    function GetActive: Boolean;
    function GetCanShow: Boolean;
    function GetController: TcxSchedulerViewController;
    function GetDragCloneEventList: TcxSchedulerFilteredEventList;
    function GetEventList: TcxSchedulerCachedEventList;
    function GetHitTest: TcxSchedulerViewHitTest;
    function GetOptionsView: TcxSchedulerOptionsView;
    function GetResources: TcxSchedulerStorageResourceItems;
    function GetSelectedDays: TcxSchedulerDateList;
    function GetWorkDays: TDays;
    function GetWorkFinish: TDateTime;
    function GetWorkStart: TDateTime;
    procedure SetActive(AValue: Boolean);
    procedure SetCanShow(AValue: Boolean);
  protected
    function CreateController: TcxSchedulerSubControlController; override;
    function CreateHitTest: TcxSchedulerSubControlHitTest; override;
    procedure DateChanged; virtual;
    procedure DoLayoutChanged; override;
    function DoShowPopupMenu(X, Y: Integer): Boolean; virtual;
    function EventContentSelected(AEvent: TcxSchedulerControlEvent): Boolean; virtual;
    function GetClientRect: TRect; override;
    function GetDateOffset: Integer;
    function GetGroupingKind: TcxSchedulerGroupingKind; virtual;
    function GetHScrollBarBounds: TRect; override;
    function GetEditRectForEvent(AEvent: TcxSchedulerControlEvent;
      const ADate: TDateTime; AResource: TcxSchedulerStorageResourceItem): TRect; virtual;
    function GetEditStyle(AEvent: TcxSchedulerControlEvent): TcxCustomEditStyle; virtual;
    function GetEditProperties(AEvent: TcxSchedulerControlEvent): TcxCustomEditProperties; virtual;
    function GetEventVisibility(AEvent: TcxSchedulerControlEvent): Boolean; virtual;
    function GetFirstVisibleDate: TDateTime; virtual;
    function GetLastVisibleDate: TDateTime; virtual;
    function GetSizeGripBounds: TRect; override;
    function GetTimeIncrement: TDateTime; virtual;
    function GetVScrollBarBounds: TRect; override;
    function GetVisibleDaysRange: Integer; virtual;
    procedure InitEventBySelectedPeriod(AEvent: TcxSchedulerEvent; AllDay: Boolean;
      ARecurrence: Boolean; AInplaceEditing: Boolean); virtual;
    function IsAllDaySelection: Boolean;
    function IsDayView: Boolean; virtual;
    function IsShowResources: Boolean; virtual;
    function IsWorkTime(AResourceItem: TcxSchedulerStorageResourceItem; const ADateTime: TDateTime): Boolean;
    procedure MakeEventVisible(AEvent: TcxSchedulerControlEvent;
      const ADate: TDateTime; AResource: TcxSchedulerStorageResourceItem); virtual;
    procedure PeriodChanged; override;
    procedure Scroll(AScrollBarKind: TScrollBarKind;
      AScrollCode: TScrollCode; var AScrollPos: Integer); virtual;
    procedure ScrollSelectedDays(AScrollDelta: Integer); overload; virtual;
    procedure ScrollSelectedDays(AForward: Boolean;
      ANeedDate: TDateTime; AIsByPage: Boolean); overload; virtual;
    procedure ScrollVisibleDays(AScrollUp: Boolean); virtual;
    procedure TimeChanged; virtual;
    procedure VisibleChanged; override;
    // hint
    procedure HideHintOnScroll; virtual;
    procedure ShowHintOnScroll(const ADate: TDateTime); virtual;

    property Controller: TcxSchedulerViewController read GetController;
    property EventList: TcxSchedulerCachedEventList read GetEventList;
    property OptionsView: TcxSchedulerOptionsView read GetOptionsView;
    property Resources: TcxSchedulerStorageResourceItems read GetResources;
    property WorkDays: TDays read GetWorkDays;
    property WorkStart: TDateTime read GetWorkStart;
    property WorkFinish: TDateTime read GetWorkFinish;
  public
    constructor Create(AOwner: TcxCustomScheduler); override;
    procedure Assign(Source: TPersistent); override;

    property Active: Boolean read GetActive write SetActive default False;
    property CanShow: Boolean read GetCanShow write SetCanShow default True;
    property DragCloneEventList: TcxSchedulerFilteredEventList read GetDragCloneEventList;
    property FirstVisibleDate: TDateTime read GetFirstVisibleDate;
    property HitTest: TcxSchedulerViewHitTest read GetHitTest;
    property LastVisibleDate: TDateTime read GetLastVisibleDate;
    property SelectedDays: TcxSchedulerDateList read GetSelectedDays;
    property StartOfWeek;
  end;

  { TcxSchedulerCustomViewViewInfo }

  TcxSchedulerCustomViewViewInfo = class(TcxSchedulerSubControlViewInfo)
  protected
    FEvents: TcxSchedulerCachedEventList;
    FSelectedDays: TcxSchedulerDateList;
    function GetSchedulerEventsList: TcxSchedulerCachedEventList;
    function DoGetEventDisplayText(AEvent: TcxSchedulerControlEvent): string; virtual;
    procedure SetEventsVisibility(AShowSources, AShowClones: Boolean;
      AForceRepaint: Boolean = False); virtual;
    property Events: TcxSchedulerCachedEventList read FEvents;
    property SelectedDays: TcxSchedulerDateList read FSelectedDays;
  end;

  { TcxSchedulerCustomDataNavigator }

  TcxSchedulerCustomDateNavigator = class(TcxSchedulerSubControl)
  private
    FLockCount: Integer;
    FSaveRealFirstDate: TDateTime;
    FSaveRealLastDate: TDateTime;
    FSaveSelectionList: TcxSchedulerDateList;
    function GetEventDays: TcxSchedulerDateList;
  protected
    FSavedSize: TSize;
    procedure CheckSizes; virtual; abstract;
    procedure CheckChanges; virtual;
    procedure DoPeriodChangedEvent; virtual; abstract;
    procedure DoSelectionChangedEvent; virtual; abstract;
    procedure DoScrollSelection(AForward: Boolean; ANeedDate: TDateTime; AIsByPage: Boolean); overload; virtual; abstract;
    procedure DoScrollSelection(AScrollDelta: Integer); overload; virtual; abstract;
    function GetMonthSize: TSize; virtual;
    function GetSelection: TcxSchedulerDateList; virtual;
    function GetShowDatesContainingEventsInBold: Boolean; virtual; abstract;
    function GetRealFirstDate: TDateTime; virtual; abstract;
    function GetRealLastDate: TDateTime; virtual; abstract;
    procedure PeriodChanged; override;
    procedure SaveSize;
    procedure SaveState; virtual;
    procedure ScrollSelection(AForward: Boolean; ANeedDate: TDateTime; AIsByPage: Boolean); overload;
    procedure ScrollSelection(AScrollDelta: Integer); overload; 
    procedure SetIntegralSizes; virtual; abstract;
    procedure UpdateDragging; virtual; abstract;
    procedure UpdateSelection; virtual; abstract;

    property EventDays: TcxSchedulerDateList read GetEventDays;
  public
    constructor Create(AOwner: TcxCustomScheduler); override;
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure CancelUpdates;
    procedure EndUpdate;
  end;

  { IcxSchedulerStylesAdapter }

  IcxSchedulerStylesAdapter = interface
  ['{0BFEA90D-0CE8-4ED1-88E8-71A3396186F3}']
    function GetContentParams(const ADateTime: TDateTime;
      AResource: TcxSchedulerStorageResourceItem): TcxViewParams; overload;
    function GetContentParams(const ADateTime: TDateTime; ALightColor: Boolean;
      AResource: TcxSchedulerStorageResourceItem): TcxViewParams; overload;
    function GetDayHeaderParams(const ADateTime: TDateTime): TcxViewParams;
    function GetEventParams(AEvent: TcxSchedulerEvent): TcxViewParams;
    function GetResourceHeaderParams(AResource: TcxSchedulerStorageResourceItem): TcxViewParams;
    // hard style
    function GetDayHeaderStyle: TcxStyle;
    function GetResourceHeaderStyle: TcxStyle;
  end;

  { TcxSchedulerStyles }

  TcxSchedulerOnGetDayHeaderStyleEvent = procedure(Sender: TObject;
    const ADate: TDateTime; var AStyle: TcxStyle) of object;
  TcxSchedulerOnGetResourceHeaderStyleEvent = procedure(Sender: TObject;
    AResource: TcxSchedulerStorageResourceItem; var AStyle: TcxStyle) of object;
  TcxSchedulerOnGetContentStyleEvent = procedure(Sender: TObject;
    AResource: TcxSchedulerStorageResourceItem; const ADateTime: TDateTime;
    var AStyle: TcxStyle) of object;
  TcxSchedulerOnGetEventStyleEvent = procedure(Sender: TObject;
    AEvent: TcxSchedulerEvent; var AStyle: TcxStyle) of object;

  TcxSchedulerStyles = class(TcxStyles, IcxSchedulerStylesAdapter)
  private
    FScheduler: TcxCustomScheduler;
    FOnGetContentStyle: TcxSchedulerOnGetContentStyleEvent;
    FOnGetDayHeaderStyle: TcxSchedulerOnGetDayHeaderStyleEvent;
    FOnGetEventStyle: TcxSchedulerOnGetEventStyleEvent;
    FOnGetResourceHeaderStyle: TcxSchedulerOnGetResourceHeaderStyleEvent;
    function GetPainter: TcxCustomLookAndFeelPainterClass;
    function GetPainterHelperClass: TcxSchedulerPainterHelperClass;
    function GetResources: TcxSchedulerStorageResourceItems;
  protected
    procedure Changed(AIndex: Integer); override;

    function EventContentSelected(AEvent: TcxSchedulerControlEvent): Boolean;
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;

    // IcxSchedulerStylesAdapter
    function GetDayHeaderStyle: TcxStyle;
    function GetEventParams(AEvent: TcxSchedulerEvent): TcxViewParams;
    function GetResourceHeaderStyle: TcxStyle;

    property Painter: TcxCustomLookAndFeelPainterClass read GetPainter;
    property PainterHelper: TcxSchedulerPainterHelperClass read GetPainterHelperClass;
    property Resources: TcxSchedulerStorageResourceItems read GetResources;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    function GetBackgroundParams: TcxViewParams;
    function GetContentParams(const ADateTime: TDateTime; AResource: TcxSchedulerStorageResourceItem = nil): TcxViewParams; overload;
    function GetContentParams(const ADateTime: TDateTime; ALightColor: Boolean; AResource: TcxSchedulerStorageResourceItem = nil): TcxViewParams; overload;
    function GetDayHeaderParams(const ADate: TDateTime): TcxViewParams;
    function GetGroupSeparatorParams: TcxViewParams;
    function GetResourceHeaderParams(AResource: TcxSchedulerStorageResourceItem): TcxViewParams;
    function GetSelectionParams: TcxViewParams;
    function GetSplitterParams(AKind: TcxSchedulerSplitterKind): TcxViewParams;
    function GetEventContentParams(AEvent: TcxSchedulerEvent): TcxViewParams;
    function IsEventStyleAssigned(AEvent: TcxSchedulerEvent): Boolean;
    // define colors functions
    property Scheduler: TcxCustomScheduler read FScheduler;
  published
    property Background: TcxStyle index cxcsBackground read GetValue write SetValue;
    property Content: TcxStyle index cxcsContent read GetValue write SetValue;
    property Event: TcxStyle index cxcsEvent read GetValue write SetValue;
    property GroupSeparator: TcxStyle index cxcsGroupSeparator read GetValue write SetValue;
    property DayHeader: TcxStyle index cxcsDayHeader read GetValue write SetValue;
    property HorzSplitter: TcxStyle index cxcsHSplitter read GetValue write SetValue;
    property ResourceHeader: TcxStyle index cxcsResourceHeader read GetValue write SetValue;
    property Selection: TcxStyle index cxcsSelection read GetValue write SetValue;
    property VertSplitter: TcxStyle index cxcsVSplitter read GetValue write SetValue;

    property OnGetContentStyle: TcxSchedulerOnGetContentStyleEvent read FOnGetContentStyle write FOnGetContentStyle;
    property OnGetDayHeaderStyle: TcxSchedulerOnGetDayHeaderStyleEvent read FOnGetDayHeaderStyle write FOnGetDayHeaderStyle;
    property OnGetEventStyle: TcxSchedulerOnGetEventStyleEvent read FOnGetEventStyle write FOnGetEventStyle;
    property OnGetResourceHeaderStyle: TcxSchedulerOnGetResourceHeaderStyleEvent read FOnGetResourceHeaderStyle write FOnGetResourceHeaderStyle;
  end;

  { TcxCustomScheduler }

  TcxSchedulerCanShowViewEvent = procedure(Sender: TObject;
    AView: TcxSchedulerCustomView; var Allow: Boolean) of object;
  TcxSchedulerGetEventEditPropertiesEvent = procedure(Sender: TObject;
    AEvent: TcxSchedulerControlEvent; var AProperties: TcxCustomEditProperties) of object;
  TcxSchedulerGetEventText = procedure(Sender: TObject;
    AEvent: TcxSchedulerControlEvent; var AText: string) of object;
  TcxSchedulerInitEditEvent = procedure(Sender: TObject; AEdit: TcxCustomEdit) of object;
  TcxSchedulerViewTypeChangedEvent = procedure(Sender: TObject;
    APrevView, ANewView: TcxSchedulerCustomView) of object;
  TcxSchedulerIsWorkTimeEvent = procedure(Sender: TObject; AResource: TcxSchedulerStorageResourceItem;
    const ATime: TDateTime; var AIsWork: Boolean) of object;

  TcxSchedulerBeforeDeleting = procedure (Sender: TcxCustomScheduler;
    AEvent: TcxSchedulerControlEvent; var Allow: Boolean) of object;
  TcxSchedulerBeforeDragEvent = procedure (Sender: TcxCustomScheduler;
    AEvent: TcxSchedulerControlEvent; X, Y: Integer; var Allow: Boolean) of object;
  TcxSchedulerBeforeEditing = procedure (Sender: TcxCustomScheduler;
    AEvent: TcxSchedulerControlEvent; AInplace: Boolean; var Allow: Boolean) of object;
  TcxSchedulerAfterDragEvent = procedure (Sender: TcxCustomScheduler;
    Target: TObject; X, Y: Integer; var Accept: Boolean) of object;
  TcxSchedulerBeforeSizingEvent = procedure (Sender: TcxCustomScheduler;
    AEvent: TcxSchedulerControlEvent; X, Y: Integer; var Allow: Boolean) of object;
  TcxSchedulerAfterSizingEvent = procedure (Sender: TcxCustomScheduler;
    X, Y: Integer; var Accept: Boolean) of object;
  TcxSchedulerAfterEditing = procedure (Sender: TcxCustomScheduler;
    AEvent: TcxSchedulerControlEvent) of object;

  TcxSchedulerEventSelectionChangedEvent = procedure (Sender: TcxCustomScheduler;
    AEvent: TcxSchedulerControlEvent) of object;

  TcxCustomScheduler = class(TcxControl,
    IcxSchedulerStorageListener,
    IcxFormatControllerListener,
    IcxFormatControllerListener2,
    IcxStoredObject)
  private
    FActiveControl: TcxSchedulerSubControl;
    FAligningSubControls: Boolean;
    FBackground: TcxSchedulerSubControl;
  {$IFNDEF DEBUGPAINT}
    FBitmap: TBitmap;
    FBitmapCanvas: TcxCanvas;
  {$ENDIF}
    FBoundsChanging: Boolean;
    FCanModified: Boolean;
    FCanvas: TcxCanvas;
    FCaptureControl: TcxSchedulerSubControl;
    FContentPopupMenu: TcxSchedulerContentPopupMenu;
    FContentPopupMenuEvents: TNotifyEvent;
    FControlBox: TcxSchedulerControlBox;
    FControlFlags: TcxControlFlags;
    FCurrentView: TcxSchedulerCustomView;
    FDateNavigator: TcxSchedulerCustomDateNavigator;
    FDefaultProperties: TcxCustomEditProperties;
    FEditController: TcxSchedulerEditController;
    FEditStyle: TcxCustomEditStyle;
    FEventDays: TcxSchedulerDateList;
    FEventHitTestController: TcxSchedulerEventHitTestController;
    FEventList: TcxSchedulerCachedEventList;
    FEventOperations: TcxSchedulerEventOperations;
    FEventPopupMenu: TcxSchedulerEventPopupMenu;
    FEventPopupMenuEvents: TNotifyEvent;
    FHintController: TcxSchedulerHintController;
    FHorzSplitter: TcxSchedulerSplitter;
    FHorzSplitterShowing: Boolean;
    FIsDragCanceled: Boolean;
    FKeyboardListener: TcxSchedulerSubControl;
    FLockCount: Integer;
    FLockRefresh: Integer;
    FOnInitEdit: TcxSchedulerInitEditEvent;
    FOptionsCustomize: TcxSchedulerOptionsCustomize;
    FOptionsView: TcxSchedulerOptionsView;
    FPrevBounds: TRect;
    FPrevCopyDragDrop: Boolean;
    FPrevMousePos: TPoint;
    FSelectedDays: TcxSchedulerDateList;
    FSelFinish: TDateTime;
    FSelResource: TcxSchedulerStorageResourceItem;
    FSelStart: TDateTime;
    FStorage: TcxCustomSchedulerStorage;
    FStoringName: string;
    FStyles: TcxSchedulerStyles;
    FStylesEvents: TNotifyEvent;
    FSubControls: TList;
    FSubControlsCreated: Boolean;
    FTextEditProperties: TcxTextEditProperties;
    FVertSplitter: TcxSchedulerSplitter;
    FVertSplitterShowing: Boolean;
    FVisibleChangedCount: Integer;
    FUpdateTimeTimer: TTimer;
    FOnAfterDragEvent: TcxSchedulerAfterDragEvent;
    FOnAfterEditing: TcxSchedulerAfterEditing;
    FOnAfterSizingEvent: TcxSchedulerAfterSizingEvent;
    FOnBeforeDeleting: TcxSchedulerBeforeDeleting;
    FOnBeforeDragEvent: TcxSchedulerBeforeDragEvent;
    FOnBeforeEditing: TcxSchedulerBeforeEditing;
    FOnBeforeSizingEvent: TcxSchedulerBeforeSizingEvent;
    FOnCanShowView: TcxSchedulerCanShowViewEvent;
    FOnGetEventDisplayText: TcxSchedulerGetEventText;
    FOnEventSelectionChanged: TcxSchedulerEventSelectionChangedEvent;
    FOnGetEventEditProperties: TcxSchedulerGetEventEditPropertiesEvent;
    FOnGetEventHintText: TcxSchedulerGetEventText;
    FOnIsWorkTime: TcxSchedulerIsWorkTimeEvent;
    FOnLayoutChanged: TNotifyEvent;
    FOnSelectionChanged: TNotifyEvent;
    FOnViewTypeChanged: TcxSchedulerViewTypeChangedEvent;
    procedure CalcHorzSplitterBounds(AByDateNavigator: Boolean);
    procedure CalcVertSplitterBounds;
    procedure CheckHorzSplitterBounds;
    procedure CheckSplittersVisibilityChanging;
    procedure CreateUpdateTimeTimer;
    function GetActiveHitTest: TcxSchedulerSubControlHitTest;
    function GetCaptureControl: TcxSchedulerSubControl;
    function GetCaptureController: TcxSchedulerSubControlController;
    function GetSelectedEventCount: Integer;
    function GetSelectedEvent(AIndex: Integer): TcxSchedulerControlEvent;
    function GetSelFinish: TDateTime;
    function GetSelStart: TDateTime;
    function GetIsDynamicUpdate: Boolean;
    function GetStartOfWeek: TDay;
    function GetStorageActive: Boolean;
    function GetStorageValid: Boolean;
    function GetSubControl(AIndex: Integer): TcxSchedulerSubControl;
    function GetSubControlCount: Integer;
    function GetVisibleEventCount: Integer;
    function GetVisibleEvent(AIndex: Integer): TcxSchedulerControlEvent;
    procedure InitEventBySelection(AEvent: TcxSchedulerEvent;
      AllDay: Boolean; ARecurrence: Boolean; AInplaceEditing: Boolean);
    function IsHorzSplitterVisible: Boolean;
    function IsVertSplitterVisible: Boolean;
    procedure SetCaptureControl(AValue: TcxSchedulerSubControl);
    procedure SetContentPopupMenu(AValue: TcxSchedulerContentPopupMenu);
    procedure SetControlBox(AValue: TcxSchedulerControlBox);
    procedure SetEventOperations(AValue: TcxSchedulerEventOperations);
    procedure SetEventPopupMenu(AValue: TcxSchedulerEventPopupMenu);
    procedure SetOptionsCustomize(AValue: TcxSchedulerOptionsCustomize);
    procedure SetOptionsView(AValue: TcxSchedulerOptionsView);
    procedure SetStyles(AValue: TcxSchedulerStyles);
    procedure SetStorage(AValue: TcxCustomSchedulerStorage);
    procedure UpdateAlignByDateNavigatorOrControlBox(AByDateNavigator: Boolean);
    procedure UpdateAlignByView;
    procedure UpdateControlsBoundsOnHorzSplitterShowing;
    procedure UpdateControlsBoundsOnVertSplitterShowing;
    procedure UpdateCurrentViewBounds;
    procedure UpdateInvisibleSplitterBounds;
    procedure UpdateTimeHandler(Sender: TObject);
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMTimeChange(var Message: TWMTimeChange); message WM_TIMECHANGE;
    procedure ReadSelectionData(AReader: TReader);
    procedure ReadSplittersData(AStream: TStream);
    procedure WriteSelectionData(AWriter: TWriter);
    procedure WriteSplittersData(AStream: TStream);
  protected
    // IcxSchedulerStorageListener
    procedure StorageChanged(Sender: TObject);
    procedure StorageRemoved(Sender: TObject);
    // IcxFormatControllerListener
    procedure DoStartOfWeekChanged(AOldStartOfWeek, ANewStartOfWeek: TDay); virtual;
    procedure FormatChanged; virtual;
    // IcxFormatControllerListener2
    procedure TimeChanged;
    // IcxStoredObject
    function GetObjectName: string; virtual;
    function GetProperties(AProperties: TStrings): Boolean; virtual;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); virtual;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); virtual;
    // from TControl
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    // methods
    procedure AlignSubControls(Sender: TcxSchedulerSubControl = nil); virtual;
    procedure BoundsChanged; override;
    function CanModified: Boolean; virtual;  
    function CanShowEventDialog: Boolean;
    function CreateBackground: TcxSchedulerSubControl; virtual;
    function CreateContentPopupMenu: TcxSchedulerContentPopupMenu; virtual;
    function CreateControlBox: TcxSchedulerControlBox; virtual;
    function CreateDateNavigator: TcxSchedulerCustomDateNavigator; virtual;
    function CreateDefaultView: TcxSchedulerCustomView; virtual;
    function CreateDefaultEditProperties: TcxCustomEditProperties; virtual;
    function CreateEditController: TcxSchedulerEditController; virtual;
    function CreateEventHitTestController: TcxSchedulerEventHitTestController; virtual;
    function CreateEventList: TcxSchedulerCachedEventList; virtual;
    function CreateEventOperations: TcxSchedulerEventOperations; virtual;
    function CreateEventPopupMenu: TcxSchedulerEventPopupMenu; virtual;
    function CreateHintController: TcxSchedulerHintController; virtual;
    function CreateOptionsCustomize: TcxSchedulerOptionsCustomize; virtual;
    function CreateOptionsView: TcxSchedulerOptionsView; virtual;
    function CreateSplitter(AKind: TcxSchedulerSplitterKind): TcxSchedulerSplitter; virtual;
    function CreateStyles: TcxSchedulerStyles; virtual;
    procedure CreateSubClasses; virtual;
    procedure DateNavigatorSelectionChanged; virtual;
    procedure DblClick; override;
    procedure DestroySubClasses; virtual;
    procedure DoAfterDragEvent(Target: TObject; X, Y: Integer; var Accept: Boolean); virtual;
    procedure DoAfterEditing(AEvent: TcxSchedulerControlEvent); virtual;
    procedure DoAfterSizingEvent(X, Y: Integer; var Accept: Boolean); virtual;
    function DoBeforeDeleting(AEvent: TcxSchedulerControlEvent): Boolean; virtual;
    function DoBeforeDragEvent(AEvent: TcxSchedulerControlEvent; X, Y: Integer): Boolean; virtual;
    function DoBeforeEditing(AEvent: TcxSchedulerControlEvent; AInplace: Boolean): Boolean; virtual;
    function DoBeforeSizingEvent(AEvent: TcxSchedulerControlEvent; X, Y: Integer): Boolean; virtual;
    procedure DoCalculateLayout(AControl: TcxSchedulerSubControl); virtual;
    procedure DoCancelMode; override;
    procedure DoControllerReset(AControl: TcxSchedulerSubControl); virtual;
    procedure DoCreateEventUsingInplaceEdit(AKey: Char = #0); virtual;
    procedure DoEventSelectionChanged(AEvent: TcxSchedulerControlEvent);
    procedure DoGetEventDisplayText(AEvent: TcxSchedulerControlEvent; var AText: string); virtual;
    procedure DoGetEventEditProperties(AEvent: TcxSchedulerControlEvent; var AProperties: TcxCustomEditProperties); virtual;
    procedure DoHitTestRecalculate(AControl: TcxSchedulerSubControl); virtual;
    procedure DoInitEdit(AEdit: TcxCustomEdit); virtual;
    function DoIsWorkTime(AResourceItem: TcxSchedulerStorageResourceItem; const ADateTime: TDateTime): Boolean;
    procedure DoCanShowView(AView: TcxSchedulerCustomView; var Allow: Boolean); virtual;
    procedure DoLayoutChanged; virtual;
    procedure DoLayoutChangedEvent; virtual;
    procedure DoSelectionChanged; virtual;
    function DoShowPopupMenu(AMenu: TComponent; X, Y: Integer): Boolean; override;
    procedure DoViewTypeChanged(ANewView: TcxSchedulerCustomView); virtual;
    procedure DoUpdateTime; virtual;
    procedure DragCanceled; override;
    procedure FontChanged; override;
    procedure FocusChanged; override;
    function GetClientBounds: TRect; override;
    function GetControlCanvas: TcxCanvas;
    function GetControlFromPoint(const APoint: TPoint): TcxSchedulerSubControl; virtual;
    function GetCursor(X, Y: Integer): TCursor; override;
    function GetDateTimeHelper: TcxSchedulerDateTimeHelperClass; virtual;
    function GetDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean; override;
    function GetEventHintText(AEvent: TcxSchedulerControlEvent): string; virtual;
    function GetHScrollBarBounds: TRect; override;
    function GetIsLocked: Boolean; virtual;
    function GetNextView(AView: TcxSchedulerCustomView): TcxSchedulerCustomView; virtual;
    function GetPainterHelper: TcxSchedulerPainterHelperClass; virtual;
    function GetSizeGripBounds: TRect; override;
    function GetTimeBias: Double; virtual;
    function GetVScrollBarBounds: TRect; override;
    function HasResources: Boolean;
    procedure InitControl; override;
    procedure InitScrollBarsParameters; override;
    procedure InternalDeleteEvent(AEvent: TcxSchedulerControlEvent; AIgnoreRecurring: Boolean);
    procedure InternalDeleteSelectedEvents(AForceDelete, ACheckReadOnly: Boolean);
    function IsViewAtLeft: Boolean;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues); override;
    procedure LockUpdateChanged(ALocking: Boolean); virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseLeave(AControl: TControl); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure PeriodChanged; virtual;
    procedure RemoveSubControl(AControl: TcxSchedulerSubControl);
    procedure ReplaceSelParams(ASelStart, ASelFinish: TDateTime;
      AResource: TcxSchedulerStorageResourceItem); virtual;
    procedure Scroll(AScrollBarKind: TScrollBarKind;
      AScrollCode: TScrollCode; var AScrollPos: Integer); override;
    procedure SetCurrentView(AView: TcxSchedulerCustomView); virtual;
    procedure SubControlAdd(AControl: TcxSchedulerSubControl);
    procedure SubControlRemove(AControl: TcxSchedulerSubControl);
    procedure SynchronizeVisibleDays; virtual;
    procedure UpdateEventsCache(ACheckDaysInterval: Boolean); virtual;
    procedure ValidateSelection(ASelection: TcxSchedulerDateList); virtual;
    procedure ValidateState;
    procedure ViewVisibleChanged(AView: TcxSchedulerCustomView); virtual;
    function VisibleGroupingKind: TcxSchedulerGroupingKind;
    // drag'n'drop support
    function CanDrag(X, Y: Integer): Boolean; override;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    function GetDragAndDropObjectClass: TcxDragAndDropObjectClass; override;
    function GetDragObjectClass: TDragControlObjectClass; override;
    function StartDragAndDrop(const P: TPoint): Boolean; override;

    property Background: TcxSchedulerSubControl read FBackground;
  {$IFNDEF DEBUGPAINT}
    property Bitmap: TBitmap read FBitmap;
    property BitmapCanvas: TcxCanvas read FBitmapCanvas;
  {$ENDIF}
    property Canvas: TcxCanvas read FCanvas;
    property Capture: TcxSchedulerSubControl read GetCaptureControl write SetCaptureControl;
    property CaptureController: TcxSchedulerSubControlController read GetCaptureController;
    property ControlFlags: TcxControlFlags read FControlFlags write FControlFlags;
    property DefaultProperties: TcxCustomEditProperties read FDefaultProperties;
    property EditController: TcxSchedulerEditController read FEditController;
    property EditStyle: TcxCustomEditStyle read FEditStyle; //remove to EditingController
    property EventHitTestController: TcxSchedulerEventHitTestController read FEventHitTestController write FEventHitTestController;
    property EventList: TcxSchedulerCachedEventList read FEventList;
    property HintController: TcxSchedulerHintController read FHintController;
    property HorzSplitter: TcxSchedulerSplitter read FHorzSplitter;
    property IsDragCanceled: Boolean read FIsDragCanceled;
    property IsDynamicUpdate: Boolean read GetIsDynamicUpdate;
    property IsLocked: Boolean read GetIsLocked;
    property KeyboardListener: TcxSchedulerSubControl read FKeyboardListener write FKeyboardListener;
    property LockCount: Integer read FLockCount;
    property PainterHelper: TcxSchedulerPainterHelperClass read GetPainterHelper;
    property ParentFont default False;
    property StartOfWeek: TDay read GetStartOfWeek;
    property StorageActive: Boolean read GetStorageActive;
    property StorageValid: Boolean read GetStorageValid;
    property SubControlCount: Integer read GetSubControlCount;
    property SubControls[Index: Integer]: TcxSchedulerSubControl read GetSubControl;
    property VertSplitter: TcxSchedulerSplitter read FVertSplitter;
    property DragMode default dmAutomatic;
    property BorderStyle default cxcbsDefault;

    property OnAfterDragEvent: TcxSchedulerAfterDragEvent read FOnAfterDragEvent write FOnAfterDragEvent;
    property OnAfterEditing: TcxSchedulerAfterEditing read FOnAfterEditing write FOnAfterEditing;
    property OnAfterSizingEvent: TcxSchedulerAfterSizingEvent read FOnAfterSizingEvent write FOnAfterSizingEvent;
    property OnBeforeDeleting: TcxSchedulerBeforeDeleting read FOnBeforeDeleting write FOnBeforeDeleting;
    property OnBeforeDragEvent: TcxSchedulerBeforeDragEvent read FOnBeforeDragEvent write FOnBeforeDragEvent;
    property OnBeforeEditing: TcxSchedulerBeforeEditing read FOnBeforeEditing write FOnBeforeEditing;
    property OnBeforeSizingEvent: TcxSchedulerBeforeSizingEvent read FOnBeforeSizingEvent write FOnBeforeSizingEvent;
    property OnCanShowView: TcxSchedulerCanShowViewEvent read FOnCanShowView write FOnCanShowView;
    property OnEventSelectionChanged: TcxSchedulerEventSelectionChangedEvent read FOnEventSelectionChanged write FOnEventSelectionChanged;
    property OnGetEventDisplayText: TcxSchedulerGetEventText read FOnGetEventDisplayText write FOnGetEventDisplayText;
    property OnGetEventHintText: TcxSchedulerGetEventText read FOnGetEventHintText write FOnGetEventHintText;
    property OnGetEventEditProperties: TcxSchedulerGetEventEditPropertiesEvent read FOnGetEventEditProperties write FOnGetEventEditProperties;
    property OnInitEdit: TcxSchedulerInitEditEvent read FOnInitEdit write FOnInitEdit;
    property OnIsWorkTime: TcxSchedulerIsWorkTimeEvent read FOnIsWorkTime write FOnIsWorkTime;
    property OnLayoutChanged: TNotifyEvent read FOnLayoutChanged write FOnLayoutChanged;
    property OnSelectionChanged: TNotifyEvent read FOnSelectionChanged write FOnSelectionChanged;
    property OnViewTypeChanged: TcxSchedulerViewTypeChangedEvent read FOnViewTypeChanged write FOnViewTypeChanged;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeginUpdate;

    procedure CreateEventUsingDialog(AllDay: Boolean = False; ARecurrence: Boolean = False); virtual;
    procedure CreateEventUsingInplaceEdit;
    procedure DeleteEvent(AEvent: TcxSchedulerControlEvent); virtual;
    procedure DeleteSelectedEvents(ACheckReadOnly: Boolean = True);
    procedure EditEventUsingDialog(AEvent: TcxSchedulerControlEvent;
      ACheckReadOnly: Boolean = True; AForcePatternEditing: Boolean = False);
    procedure EditEventUsingInplaceEdit(AEvent: TcxSchedulerControlEvent);

    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure EndUpdate;
    function GoToDate(ADate: TDateTime; AViewMode: TcxSchedulerViewMode = vmDay): Boolean; virtual;
    procedure FullRefresh; virtual;
    procedure LayoutChanged;
    procedure MakeEventVisible(AEvent: TcxSchedulerControlEvent;
      const ADate: TDateTime = NullDate; AResource: TcxSchedulerStorageResourceItem = nil);
    procedure SelectEvent(AEvent: TcxSchedulerControlEvent; AShift: TShiftState = []);
    procedure SelectTime(const ASelStart, ASelFinish: TDateTime;
      AResource: TcxSchedulerStorageResourceItem);
    procedure UnselectEvents;
    // store/load
    procedure RestoreFromIniFile(const AStorageName: string; ARestoreResources: Boolean = True);
    procedure RestoreFromRegistry(const AStorageName: string; ARestoreResources: Boolean = True);
    procedure RestoreFromStream(AStream: TStream; ARestoreResources: Boolean = True);
    procedure StoreToIniFile(const AStorageName: string; AReCreate: Boolean = True; AStoreResources: Boolean = True);
    procedure StoreToRegistry(const AStorageName: string; AReCreate: Boolean = True; AStoreResources: Boolean = True);
    procedure StoreToStream(AStream: TStream; AStoreResources: Boolean = True);

    property ActiveHitTest: TcxSchedulerSubControlHitTest read GetActiveHitTest;
    property Color;
    property ContentPopupMenu: TcxSchedulerContentPopupMenu read FContentPopupMenu write SetContentPopupMenu;
    property ControlBox: TcxSchedulerControlBox read FControlBox write SetControlBox;
    property CurrentView: TcxSchedulerCustomView read FCurrentView write SetCurrentView;
    property DateNavigator: TcxSchedulerCustomDateNavigator read FDateNavigator;
    property DateTimeHelper: TcxSchedulerDateTimeHelperClass read GetDateTimeHelper;
    property EventDays: TcxSchedulerDateList read FEventDays;
    property EventOperations: TcxSchedulerEventOperations read FEventOperations write SetEventOperations;
    property EventPopupMenu: TcxSchedulerEventPopupMenu read FEventPopupMenu write SetEventPopupMenu;
    property OptionsCustomize: TcxSchedulerOptionsCustomize read FOptionsCustomize write SetOptionsCustomize;
    property OptionsView: TcxSchedulerOptionsView read FOptionsView write SetOptionsView;
    property SelectedDays: TcxSchedulerDateList read FSelectedDays;
    property SelectedEventCount: Integer read GetSelectedEventCount;
    property SelectedEvents[Index: Integer]: TcxSchedulerControlEvent read GetSelectedEvent;
    property SelFinish: TDateTime read GetSelFinish;
    property SelResource: TcxSchedulerStorageResourceItem read FSelResource;
    property SelStart: TDateTime read GetSelStart;
    property Storage: TcxCustomSchedulerStorage read FStorage write SetStorage;
    property StoringName: string read FStoringName write FStoringName;
    property Styles: TcxSchedulerStyles read FStyles write SetStyles;
    property VisibleEventCount: Integer read GetVisibleEventCount;
    property VisibleEvents[AIndex: Integer]: TcxSchedulerControlEvent read GetVisibleEvent;
    property TabStop default True;
    property Font;
  published
    property StylesEvents: TNotifyEvent read FStylesEvents write FStylesEvents;
    property ContentPopupMenuEvents: TNotifyEvent read FContentPopupMenuEvents write FContentPopupMenuEvents;
    property EventPopupMenuEvents: TNotifyEvent read FEventPopupMenuEvents write FEventPopupMenuEvents;
  end;

  { TcxSchedulerPopupMenu }

  TcxSchedulerPopupMenu = class(TPersistent)
  private
    FScheduler: TcxCustomScheduler;
    FPopupMenu: TComponent;
    FInternalMenu: TPopupMenu;
    FUseBuiltInPopupMenu: Boolean;
    function GetRoot: TMenuItem;
    procedure SetPopupMenu(const Value: TComponent);
  protected
    function AddValidSeparator(AOwner: TMenuItem): TMenuItem;
    procedure CreateInternalMenu;
    procedure CreateItems; virtual;
    function CreateSeparator(AOwner: TMenuItem): TMenuItem;
    function CreateSubItem(AOwner: TMenuItem; const ACaption: string; ACommand: Integer = -1;
      AImageIndex: Integer = -1; AEnabled: Boolean = True; AChecked: Boolean = False): TMenuItem;
    procedure DoExecute(ACommand: Integer); virtual;
    function DoOnClick(ACommand: Integer): Boolean; virtual;
    function DoOnPopup: Boolean; virtual;
    procedure ExecuteCommand(ACommand: Integer);
    function FindItemByCommand(AOwnerItem: TMenuItem; ACommand: Integer): TMenuItem;
    function IsValidCommand(ACommand: Integer): Boolean; virtual;
    procedure OnItemClickHandler(Sender: TObject);
    function Storage: TcxCustomSchedulerStorage;

    property InternalMenu: TPopupMenu read FInternalMenu;
    property Root: TMenuItem read GetRoot;
  public
    constructor Create(AScheduler: TcxCustomScheduler); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Popup(X, Y: Integer): Boolean; virtual;

    property Scheduler: TcxCustomScheduler read FScheduler;
  published
    property PopupMenu: TComponent read FPopupMenu write SetPopupMenu;
    property UseBuiltInPopupMenu: Boolean read FUseBuiltInPopupMenu write FUseBuiltInPopupMenu default True;
  end;

  { TcxSchedulerCustomContentPopupMenu }

  TcxSchedulerCustomContentPopupMenu = class(TcxSchedulerPopupMenu)
  private
    FNewID: Integer;
    FAllDayID: Integer;
    FReccurenceID: Integer;
  protected
    function CanCreateEvent: Boolean;
    procedure CreateNewEventItems(ANew, AllDay, AReccurence: Boolean;
      ANewID, AllDayID, AReccurenceID: Integer);
    procedure DoExecute(ACommand: Integer); override;
  public
    constructor Create(AScheduler: TcxCustomScheduler); override;
  end;

  { TcxSchedulerContentPopupMenu }

  TcxSchedulerContentPopupMenuItem = (cpmiNewEvent, cpmiNewAllDayEvent,
    cpmiNewReccuringEvent, cpmiToday, cpmiGoToDate, cpmiGoToThisDay, cpmiResourcesLayout);
  TcxSchedulerContentPopupMenuItems = set of TcxSchedulerContentPopupMenuItem;

  TcxSchedulerContentPopupMenuPopupEvent = procedure (Sender: TcxSchedulerContentPopupMenu;
    ABuiltInMenu: TPopupMenu; var AHandled: Boolean) of object;
  TcxSchedulerContentPopupMenuClickEvent = procedure (Sender: TcxSchedulerContentPopupMenu;
    AItem: TcxSchedulerContentPopupMenuItem; var AHandled: Boolean) of object;

  TcxSchedulerContentPopupMenu = class(TcxSchedulerCustomContentPopupMenu)
  private
    FItems: TcxSchedulerContentPopupMenuItems;
    FSavedDate: TDateTime;
    FOnPopup: TcxSchedulerContentPopupMenuPopupEvent;
    FOnClick: TcxSchedulerContentPopupMenuClickEvent;
    procedure CreateGoToThisDayItem;
  protected
    procedure CreateItems; override;
    procedure DoExecute(ACommand: Integer); override;
    function DoOnClick(ACommand: Integer): Boolean; override;
    function DoOnPopup: Boolean; override;
    function IsValidCommand(ACommand: Integer): Boolean; override;
  public
    constructor Create(AScheduler: TcxCustomScheduler); override;
    procedure Assign(Source: TPersistent); override;
    procedure Execute(AItem: TcxSchedulerContentPopupMenuItem);
    function GetMenuItem(AItem: TcxSchedulerContentPopupMenuItem): TMenuItem;
  published
    property Items: TcxSchedulerContentPopupMenuItems
      read FItems write FItems default [cpmiNewEvent, cpmiNewAllDayEvent,
        cpmiNewReccuringEvent, cpmiToday, cpmiGoToDate, cpmiGoToThisDay,
        cpmiResourcesLayout];
    property PopupMenu;
    property UseBuiltInPopupMenu;

    property OnClick: TcxSchedulerContentPopupMenuClickEvent read FOnClick write FOnClick;
    property OnPopup: TcxSchedulerContentPopupMenuPopupEvent read FOnPopup write FOnPopup;
  end;

  { TcxSchedulerEventPopupMenu }

  TcxSchedulerEventPopupMenuItem = (epmiOpen, epmiEditSeries,
    epmiShowTimeAs, epmiLabel, epmiDelete);
  TcxSchedulerEventPopupMenuItems = set of TcxSchedulerEventPopupMenuItem;

  TcxSchedulerEventPopupMenuPopupEvent = procedure (Sender: TcxSchedulerEventPopupMenu;
    ABuiltInMenu: TPopupMenu; var AHandled: Boolean) of object;
  TcxSchedulerEventPopupMenuClickEvent = procedure (Sender: TcxSchedulerEventPopupMenu;
    AItem: TcxSchedulerEventPopupMenuItem; ASubItemIndex: Integer;
    var AHandled: Boolean) of object;

  TcxSchedulerEventPopupMenu = class(TcxSchedulerPopupMenu)
  private
    FEvent: TcxSchedulerControlEvent;
    FItems: TcxSchedulerEventPopupMenuItems;
    FOnPopup: TcxSchedulerEventPopupMenuPopupEvent;
    FOnClick: TcxSchedulerEventPopupMenuClickEvent;
    procedure CreateDeleteItem;
    procedure CreateLabelItems;
    procedure CreateTimeItems;
    function GetCommand(AItem: TcxSchedulerEventPopupMenuItem;
      ASubItemIndex: Integer): Integer;
    function CanEdit: Boolean;
    function GetEvent: TcxSchedulerControlEvent;
    procedure UnpackCommand(ACommand: Integer;
      out AItem: TcxSchedulerEventPopupMenuItem; out ASubItemIndex: Integer);
  protected
    procedure CreateItems; override;
    procedure DoExecute(ACommand: Integer); override;
    function DoOnClick(ACommand: Integer): Boolean; override;
    function DoOnPopup: Boolean; override;
    function IsValidCommand(ACommand: Integer): Boolean; override;
    procedure SetEventLabelColor(AColor: Integer);
    procedure SetEventState(AState: Integer);
  public
    constructor Create(AScheduler: TcxCustomScheduler); override;
    procedure Assign(Source: TPersistent); override;
    function GetMenuItem(AItem: TcxSchedulerEventPopupMenuItem;
      ASubItemIndex: Integer = -1): TMenuItem;
    property Event: TcxSchedulerControlEvent read FEvent;
  published
    property Items: TcxSchedulerEventPopupMenuItems
      read FItems write FItems default [epmiOpen, epmiEditSeries,
        epmiShowTimeAs, epmiLabel, epmiDelete];
    property PopupMenu;
    property UseBuiltInPopupMenu;
    
    property OnClick: TcxSchedulerEventPopupMenuClickEvent read FOnClick write FOnClick;
    property OnPopup: TcxSchedulerEventPopupMenuPopupEvent read FOnPopup write FOnPopup;
  end;

function IsHeaderEvent(AEvent: TcxSchedulerEvent): Boolean;

implementation

uses
{$IFDEF DELPHI6}
  DateUtils, Variants,
{$ENDIF}
  cxLibraryConsts, cxVariants, cxSchedulerDialogs, cxMemo, cxSchedulerStrs,
  cxSchedulerRecurrenceSelectionDialog;

const
  EventContentColors: array[Boolean] of TColor = (clWindow, clWhite);
  EditStartChars = [#8, #13, ^V, ^X, #32..#255];

type
  TcxCustomEditAccess = class(TcxCustomEdit);

function IsHeaderEvent(AEvent: TcxSchedulerEvent): Boolean;
begin
  Result := AEvent.AllDayEvent or (AEvent.Duration >= 1);
end;

{ TcxSchedulerSubControl }

constructor TcxSchedulerSubControl.Create(
  AOwner: TcxCustomScheduler);
begin
  FScheduler := AOwner;
  FVisible := True;
  CreateSubClasses;
  FCursor := crDefault;
  Scheduler.SubControlAdd(Self);
end;

destructor TcxSchedulerSubControl.Destroy;
begin
  DestroySubClasses;
  Scheduler.SubControlRemove(Self);
  inherited Destroy;
end;

procedure TcxSchedulerSubControl.Invalidate;
begin
  InvalidateRect(ClientRect);
end;

procedure TcxSchedulerSubControl.InvalidateRect(
  const ARect: TRect);
begin
  Scheduler.InvalidateRect(cxRectOffset(ARect, Left, Top), False);
  Exclude(Scheduler.FControlFlags, cfImageValid);
end;

procedure TcxSchedulerSubControl.LayoutChanged;
begin
  FCanvas := Scheduler.FCanvas;
  if not Visible then ViewInfo.Clear;
  if not Visible or (Controller = nil) then Exit;
  Exclude(Scheduler.FControlFlags, cfImageValid);
  Controller.Reset;
  DoLayoutChanged;
  HitTest.Recalculate;
  Invalidate;
end;

procedure TcxSchedulerSubControl.Refresh;
begin
  LayoutChanged;
end;

procedure TcxSchedulerSubControl.SetBounds(  
  ALeft, ATop, AWidth, AHeight: Integer);
begin
  if (ALeft <> FLeft) or (ATop <> FTop) or (AWidth <> FWidth) or
    (AHeight <> FHeight) then
  begin
    FLeft := ALeft;
    FTop := ATop;
    FWidth := AWidth;
    FHeight := AHeight;
    BoundsChanged;
  end;
end;

procedure TcxSchedulerSubControl.GetProperties(AProperties: TStrings);
begin
end;

procedure TcxSchedulerSubControl.GetPropertyValue(const AName: string;
  var AValue: Variant);
begin
end;

procedure TcxSchedulerSubControl.SetPropertyValue(const AName: string;
  const AValue: Variant);
begin
end;

function TcxSchedulerSubControl.AllowDesignHitTest(
  X, Y: Integer; AShift: TShiftState): Boolean;
begin
  MousePositionChanged(X, Y);
  Result := False;
end;

procedure TcxSchedulerSubControl.BoundsChanged;
begin
  Scheduler.AlignSubControls(Self);
  Changed;
end;

procedure TcxSchedulerSubControl.CalculateViewInfo;
begin
  ViewInfo.Calculate;
end;

function TcxSchedulerSubControl.CanCapture(
  const APoint: TPoint): Boolean;
begin
  Result := Visible and cxRectPtIn(Bounds, APoint);
end;

procedure TcxSchedulerSubControl.Changed;
begin
  Scheduler.LayoutChanged;
end;

function TcxSchedulerSubControl.CreateController: TcxSchedulerSubControlController;
begin
  Result := TcxSchedulerSubControlController.Create(Self);
end;

function TcxSchedulerSubControl.CreateHitTest: TcxSchedulerSubControlHitTest;
begin
  Result := TcxSchedulerSubControlHitTest.Create(Self);
end;

function TcxSchedulerSubControl.CreatePainter: TcxSchedulerSubControlPainter;
begin
  Result := TcxSchedulerSubControlPainter.Create(Self);
end;

function TcxSchedulerSubControl.CreateViewInfo: TcxSchedulerSubControlViewInfo;
begin
  Result := TcxSchedulerSubControlViewInfo.Create(Self);
end;

procedure TcxSchedulerSubControl.CreateSubClasses;
begin
  FViewInfo := CreateViewInfo;
  FHitTest := CreateHitTest;
  FController := CreateController;
  FPainter := CreatePainter;
end;

procedure TcxSchedulerSubControl.DestroySubClasses;
begin
  FPainter.Free;
  FHitTest.Free;
  FController.Free;
  FViewInfo.Free;
end;

procedure TcxSchedulerSubControl.DoBeforeMouseDown(AButton: TMouseButton;
  AShift: TShiftState; X, Y: Integer);
begin
  MousePositionChanged(X, Y);
  Controller.BeforeMouseDown(AButton, AShift, X, Y);
end;

procedure TcxSchedulerSubControl.DoCancelMode;
begin
  Mouse.Capture := 0;
end;

procedure TcxSchedulerSubControl.DoLayoutChanged;
begin
  CalculateViewInfo;
end;

procedure TcxSchedulerSubControl.DoMouseDown(
  AButton: TMouseButton; AShift: TShiftState; X, Y: Integer);
begin
  MousePositionChanged(X, Y);
  Controller.MouseDown(AButton, AShift, X, Y);
end;

procedure TcxSchedulerSubControl.DoMouseMove(
  AShift: TShiftState; X, Y: Integer);
begin
  MousePositionChanged(X, Y);
  Controller.MouseMove(AShift, X, Y);
end;

procedure TcxSchedulerSubControl.DoMouseUp(
  AButton: TMouseButton; AShift: TShiftState; X, Y: Integer);
begin
  MousePositionChanged(X, Y);
  Controller.MouseUp(AButton, AShift, X, Y);
end;

procedure TcxSchedulerSubControl.DoPaint;
var
  AClipRgn: TcxRegion;
begin
  AClipRgn := Canvas.GetClipRegion;
  Canvas.IntersectClipRect(ClientRect);
  Painter.Paint;
  Canvas.SetClipRegion(AClipRgn, roSet);
end;

procedure TcxSchedulerSubControl.FormatChanged;
begin
end;

function TcxSchedulerSubControl.GetClientRect: TRect;
begin
  Result := cxRectBounds(0, 0, FWidth, FHeight);
end;

function TcxSchedulerSubControl.GetOwner: TPersistent;
begin
  Result := FScheduler;
end;

function TcxSchedulerSubControl.GetHScrollBarBounds: TRect;
begin
  Result := cxNullRect;
end;

function TcxSchedulerSubControl.GetSizeGripBounds: TRect;
begin
  Result := cxNullRect;
end;

function TcxSchedulerSubControl.GetStartOfWeek: TDay;
begin
  Result := Scheduler.OptionsView.ActualStartOfWeek;
end;

function TcxSchedulerSubControl.GetVScrollBarBounds: TRect;
begin
  Result := cxNullRect;
end;

procedure TcxSchedulerSubControl.InitScrollBarsParameters;
begin
end;

procedure TcxSchedulerSubControl.MousePositionChanged(
  var X, Y: Integer);
begin
  Dec(X, FLeft);
  Dec(Y, FTop);
  HitTest.HitPoint := cxPoint(X, Y);
end;

procedure TcxSchedulerSubControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
end;

procedure TcxSchedulerSubControl.Paint;
var
  ASavePos: TPoint;
begin
  if not Visible or cxRectIsEmpty(Bounds) then Exit;
  ASavePos := Canvas.WindowOrg;
  Canvas.WindowOrg := cxPoint(-Left, -Top);
  try
    DoPaint;
  finally
    Canvas.WindowOrg := ASavePos;
  end;
end;

procedure TcxSchedulerSubControl.PeriodChanged;
begin
  Scheduler.PeriodChanged;
end;

procedure TcxSchedulerSubControl.SetScrollBarInfo(
  AScrollBarKind: TScrollBarKind; AMin, AMax, AStep, APage, APos: Integer;
  AAllowShow, AAllowHide: Boolean);
begin
  Scheduler.SetScrollBarInfo(AScrollBarKind, AMin, AMax,
    AStep, APage, APos, AAllowShow and Visible, AAllowHide);
end;

procedure TcxSchedulerSubControl.VisibleChanged;
begin
  Scheduler.AlignSubControls(Self);
  Changed;
end;

function TcxSchedulerSubControl.GetBottom: Integer;
begin
  Result := FTop + FHeight;
end;

{$IFNDEF DEBUGPAINT}
function TcxSchedulerSubControl.GetBitmap: TBitmap;
begin
  Result := Scheduler.FBitmap;
end;
{$ENDIF}

function TcxSchedulerSubControl.GetBounds: TRect;
begin
  Result := cxRectBounds(FLeft, FTop, FWidth, FHeight);
end;

function TcxSchedulerSubControl.GetDateTimeHelperClass: TcxSchedulerDateTimeHelperClass;
begin
  Result := Scheduler.DateTimeHelper;
end;

function TcxSchedulerSubControl.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := Scheduler.LookAndFeelPainter;
end;

function TcxSchedulerSubControl.GetPainterHelperClass: TcxSchedulerPainterHelperClass;
begin
  Result := Scheduler.PainterHelper;
end;

function TcxSchedulerSubControl.GetRight: Integer;
begin
  Result := FLeft + FWidth;
end;

function TcxSchedulerSubControl.GetStyles: TcxSchedulerStyles;
begin
  Result := Scheduler.Styles;
end;

procedure TcxSchedulerSubControl.InternalSetBounds(const AValue: TRect);
begin
  SetBounds(AValue.Left, AValue.Top, AValue.Right - AValue.Left,
    AValue.Bottom - AValue.Top);
end;

procedure TcxSchedulerSubControl.SetBottom(const Value: Integer);
begin
  InternalSetBounds(cxRectSetBottom(Bounds, Value));
end;

procedure TcxSchedulerSubControl.SetHeight(AValue: Integer);
begin
  SetBounds(FLeft, FTop, FWidth, AValue);
end;

procedure TcxSchedulerSubControl.SetLeft(AValue: Integer);
begin
  SetBounds(AValue, FTop, FWidth, FHeight);
end;

procedure TcxSchedulerSubControl.SetRight(Value: Integer);
begin
  InternalSetBounds(cxRectSetRight(Bounds, Value));
end;

procedure TcxSchedulerSubControl.SetTop(AValue: Integer);
begin
  SetBounds(FLeft, AValue, FWidth, FHeight);
end;

procedure TcxSchedulerSubControl.SetVisible(
  AValue: Boolean);
begin
  if AValue <> FVisible then
  begin
    FVisible := AValue;
    VisibleChanged;
  end;
end;

procedure TcxSchedulerSubControl.SetWidth(AValue: Integer);
begin
  SetBounds(FLeft, FTop, AValue, FHeight);
end;

{ TcxSchedulerSubControlController }

constructor TcxSchedulerSubControlController.Create(
  AOwner: TcxSchedulerSubControl);
begin
  FOwner := AOwner;
end;

procedure TcxSchedulerSubControlController.BeginDragAndDrop;
begin
end;

function TcxSchedulerSubControlController.CanDrag(
  X, Y: Integer): Boolean;
begin
  Result := False;
end;

procedure TcxSchedulerSubControlController.DragAndDrop(
  const P: TPoint; var Accepted: Boolean);
begin
end;

procedure TcxSchedulerSubControlController.DragDrop(
  Source: TObject; X, Y: Integer);
begin
end;

procedure TcxSchedulerSubControlController.DragOver(
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := False;
end;

procedure TcxSchedulerSubControlController.EndDrag(
  Target: TObject; X, Y: Integer);
begin
end;

procedure TcxSchedulerSubControlController.EndDragAndDrop(
  Accepted: Boolean);
begin
end;

function TcxSchedulerSubControlController.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  Result := nil;
end;

procedure TcxSchedulerSubControlController.StartDrag(
  var DragObject: TDragObject);
begin
end;

function TcxSchedulerSubControlController.StartDragAndDrop(
  const P: TPoint): Boolean;
begin
  Result := False;
end;

procedure TcxSchedulerSubControlController.BeforeMouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TcxSchedulerSubControlController.DoCancelMode;
begin
end;

function TcxSchedulerSubControlController.GetCursor(
  X, Y: Integer): TCursor;
begin
  Result := Owner.Cursor;
end;

procedure TcxSchedulerSubControlController.KeyDown(       
  var Key: Word; Shift: TShiftState);
begin
end;

procedure TcxSchedulerSubControlController.KeyPress(
  var Key: Char);
begin
end;

procedure TcxSchedulerSubControlController.KeyUp(
  var Key: Word; Shift: TShiftState);
begin
end;

procedure TcxSchedulerSubControlController.MouseEnter;
begin
end;

procedure TcxSchedulerSubControlController.MouseLeave;
begin
end;

procedure TcxSchedulerSubControlController.MouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TcxSchedulerSubControlController.MouseMove(
  Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TcxSchedulerSubControlController.MouseUp(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TcxSchedulerSubControlController.Reset;
begin
end;

function TcxSchedulerSubControlController.GetHitTest: TcxSchedulerSubControlHitTest;
begin
  Result := Owner.HitTest;
end;

function TcxSchedulerSubControlController.GetStartOfWeek: TDay;
begin
  Result := Owner.StartOfWeek;
end;

{ TcxSchedulerSubControlHitTest }

constructor TcxSchedulerSubControlHitTest.Create(
  AOwner: TcxSchedulerSubControl);
begin
  FOwner := AOwner;
end;

destructor TcxSchedulerSubControlHitTest.Destroy;
begin
  inherited Destroy;
end;

procedure TcxSchedulerSubControlHitTest.Recalculate;
begin
  DoCalculate;
end;

procedure TcxSchedulerSubControlHitTest.Clear;
begin
  Flags := 0;
  FTime := NullDate;
end;

procedure TcxSchedulerSubControlHitTest.DoCalculate;        
begin
  Clear;
  SetBitState(htcControl, cxRectPtIn(Owner.Bounds,
    cxPointOffset(HitPoint, Owner.Left, Owner.Top)));
end;

function TcxSchedulerSubControlHitTest.GetBitState(
  AIndex: Integer): Boolean;
begin
  Result := (Flags and (1 shl AIndex)) <> 0
end;

function TcxSchedulerSubControlHitTest.GetMaskState(
  AMask: Integer): Boolean;
begin
  Result := Flags and AMask = AMask;
end;

function TcxSchedulerSubControlHitTest.GetMaskStateEx(
  AMask: Integer): Boolean;
begin
  Result := Flags and AMask <> 0;
end;

procedure TcxSchedulerSubControlHitTest.SetBitState(
  AIndex: Integer; AValue: Boolean);
begin
  if AValue then
    Flags := Flags or (1 shl AIndex)
  else
    Flags := Flags and not (1 shl AIndex);
end;

procedure TcxSchedulerSubControlHitTest.SetMaskState(
  AMask: Integer; AValue: Boolean);
begin
  if AValue then
    Flags := Flags or AMask
  else
    Flags := Flags and not AMask;
end;

function TcxSchedulerSubControlHitTest.GetPosValue(
  AIndex: Integer): Integer;
begin
  Result := cxPointGetItem(FHitPoint, AIndex);
end;

function TcxSchedulerSubControlHitTest.GetScheduler: TcxCustomScheduler;
begin
  Result := FOwner.FScheduler;
end;

procedure TcxSchedulerSubControlHitTest.SetHitPoint(
  const APoint: TPoint);
begin
  FHitPoint := APoint;
  Recalculate;
end;

procedure TcxSchedulerSubControlHitTest.SetPosValue(
  AIndex, AValue: Integer);
begin
  FHitPoint := cxPointReplaceItem(FHitPoint, AIndex, AValue);
  Recalculate;
end;

{ TcxSchedulerSubControlPainter }

constructor TcxSchedulerSubControlPainter.Create(
  AOwner: TcxSchedulerSubControl);
begin
  FOwner := AOwner;
end;

procedure TcxSchedulerSubControlPainter.Paint;
begin
end;

{$IFNDEF DEBUGPAINT}
function TcxSchedulerSubControlPainter.GetBitmap: TBitmap;
begin
  Result := FOwner.Bitmap;
end;
{$ENDIF}

function TcxSchedulerSubControlPainter.GetCanvas: TcxCanvas;
begin
  Result := FOwner.FCanvas;
end;

function TcxSchedulerSubControlPainter.GetViewInfo: TcxSchedulerSubControlViewInfo;
begin
  Result := Owner.ViewInfo;
end;

{ TcxSchedulerSubControlViewInfo }

constructor TcxSchedulerSubControlViewInfo.Create(
  AOwner: TcxSchedulerSubControl);
begin
  FOwner := AOwner;
end;

procedure TcxSchedulerSubControlViewInfo.Calculate;
begin
  if not IsSchedulerCreated then Exit;
  FBounds := GetBounds;
  Clear;
  DoCalculate;
  AfterCalculate;
end;

procedure TcxSchedulerSubControlViewInfo.AfterCalculate;
begin
end;

procedure TcxSchedulerSubControlViewInfo.Clear;
begin
end;

procedure TcxSchedulerSubControlViewInfo.DoCalculate;
begin
end;

function TcxSchedulerSubControlViewInfo.GetBounds: TRect;
begin
  Result := Owner.ClientRect;
end;

function TcxSchedulerSubControlViewInfo.GetDateTimeHelperClass: TcxSchedulerDateTimeHelperClass;
begin
  Result := Owner.DateTimeHelper;
end;

function TcxSchedulerSubControlViewInfo.GetDefaultFont: TFont;
begin
  Result := Owner.Scheduler.Font;
end;

function TcxSchedulerSubControlViewInfo.GetIsSchedulerCreated: Boolean;
begin
  Result := Owner.Scheduler.FSubControlsCreated;
end;

function TcxSchedulerSubControlViewInfo.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := Owner.Scheduler.LookAndFeelPainter;
end;

function TcxSchedulerSubControlViewInfo.GetPainterHelperClass: TcxSchedulerPainterHelperClass;
begin
  Result := Owner.PainterHelper;
end;

function TcxSchedulerSubControlViewInfo.GetStyles: TcxSchedulerStyles;
begin
  Result := Owner.Styles; 
end;

type
  TContainer = class(TWinControl)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TContainer }

constructor TContainer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csAcceptsControls] + [csNoDesignVisible];
  Visible := False;
  TabStop := False;
end;

procedure TContainer.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_CHILD or WS_CLIPCHILDREN or WS_CLIPSIBLINGS;
    ExStyle := WS_EX_CONTROLPARENT;
    WindowClass.Style := CS_DBLCLKS;
  end;
end;

{ TcxSchedulerControlBox }

constructor TcxSchedulerControlBox.Create(AOwner: TcxCustomScheduler);
begin
  inherited Create(AOwner);
  FContainer := CreateWndContainerControl;
end;

procedure TcxSchedulerControlBox.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerControlBox then
    with TcxSchedulerControlBox(Source) do
    begin
      Self.Control := Control;
      Self.Visible := Visible;
    end
    else inherited Assign(Source);
end;

function TcxSchedulerControlBox.HasAsParent(
  AValue: TControl): Boolean;
var
  AParent: TWinControl;
begin
  Result := False;
  AParent := Scheduler;
  while not Result and (AParent <> nil) do
  begin
    Result := AValue = AParent;
    AParent := AParent.Parent;
  end;
end;

procedure TcxSchedulerControlBox.VisibleChanged;
begin
  FContainer.Visible := Visible;
  inherited VisibleChanged;
end;

procedure TcxSchedulerControlBox.DoLayoutChanged;
begin
  FViewParams := Styles.GetBackgroundParams;
  inherited DoLayoutChanged;
end;

procedure TcxSchedulerControlBox.GetProperties(AProperties: TStrings);
begin
  if Scheduler.DateNavigator.Visible then Exit;
  AProperties.Add('DNWidth');
end;

procedure TcxSchedulerControlBox.GetPropertyValue(const AName: string;
  var AValue: Variant);
begin
  if Scheduler.DateNavigator.Visible then Exit;
  if AName = 'DNWidth' then
    AValue := Width
end;

procedure TcxSchedulerControlBox.SetPropertyValue(const AName: string;
  const AValue: Variant);
begin
  if Scheduler.DateNavigator.Visible then Exit;
  if AName = 'DNWidth' then
  begin
    Scheduler.DateNavigator.Width := AValue;
    Scheduler.DateNavigator.DoLayoutChanged;   
    Width := AValue;
  end;
end;

procedure TcxSchedulerControlBox.BoundsChanged;
begin
  FContainer.BoundsRect := Bounds;
  inherited BoundsChanged;
  FContainer.Update;
end;

function TcxSchedulerControlBox.CreateWndContainerControl: TWinControl;
begin
  Result := TContainer.Create(Scheduler);
  Result.Parent := Scheduler;
end;

procedure TcxSchedulerControlBox.DoPaint;
begin
  Canvas.FillRect(ClientRect, ViewParams);
end;

procedure TcxSchedulerControlBox.RestorePosition;
begin
  if (FControl = nil) or
    (csDestroying in Control.ComponentState) then Exit;
  Control.RemoveFreeNotification(Scheduler);
  Control.Align := FControlAlign;
  Control.Parent := FControlParent;
  Control.BoundsRect := FControlRect;
end;

procedure TcxSchedulerControlBox.SetControl(
  AValue: TControl);
begin
  if HasAsParent(AValue) then Exit;
  if FControl <> AValue then
  begin
    RestorePosition;
    FControl := AValue;
    StorePosition;
    FContainer.BoundsRect := Bounds;
    FContainer.Visible := Visible and (Control <> nil);
    Changed;
  end
  else
    FContainer.Visible := False;
end;

procedure TcxSchedulerControlBox.StorePosition;
begin
  if Control = nil then Exit;
  FControlAlign := Control.Align;
  FControlParent := Control.Parent;
  FControlRect := Control.BoundsRect;
  Control.FreeNotification(Scheduler);
  Control.Parent := FContainer;
  Control.Align := alClient;
end;

{ TcxSchedulerSplitterController }

procedure TcxSchedulerSplitterController.DoCancelMode;
begin
  EraseInvertRect;
  Scheduler.FCaptureControl := nil;
  Scheduler.FKeyboardListener := FSaveKeyboardListener;
end;

procedure TcxSchedulerSplitterController.KeyDown(var Key: Word;
  Shift: TShiftState);
begin
  if Scheduler.OptionsCustomize.ControlsSizing and Scheduler.IsDragCanceled then
  begin
    DoCancelMode;
    Mouse.Capture := 0;
  end;
end;

procedure TcxSchedulerSplitterController.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Scheduler.OptionsCustomize.ControlsSizing and (ssLeft in Shift) then
  begin
    FSaveKeyboardListener := Scheduler.KeyboardListener;
    Scheduler.KeyboardListener := Splitter;
    FHitPoint := GetOwnerMousePos(X, Y);
    FStartBounds := Splitter.Bounds;
    FSizingBoundsRect := GetSizingBoundsRect;
    FScreenCanvasClipRect := GetDrawClipRect;
    if not IsDynamicUpdate then
    begin
      Scheduler.Update; //force repaint before on-screen drawing
      DrawInvertRect(FStartBounds);
    end;
    FPrevRect := FStartBounds;
  end;
end;

procedure TcxSchedulerSplitterController.MouseMove(Shift: TShiftState;
  X, Y: Integer);
var
  R: TRect;
begin
  if not Scheduler.OptionsCustomize.ControlsSizing or
    (Scheduler.CaptureController <> Self) or Scheduler.IsLocked then Exit;
  R := GetSizingRect(GetOwnerMousePos(X, Y));
  if not cxRectIsEqual(R, FPrevRect) then
  begin
    if IsDynamicUpdate then
      UpdateSizing(R)
    else
      DrawInvertRect(R);
    FPrevRect := R;
  end;
end;

procedure TcxSchedulerSplitterController.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if not Scheduler.OptionsCustomize.ControlsSizing then Exit;
  Scheduler.KeyboardListener := FSaveKeyboardListener;
  EraseInvertRect;
  UpdateSizing(GetSizingRect(GetOwnerMousePos(X, Y)));
end;

procedure TcxSchedulerSplitterController.DrawInvertRect(const R: TRect);
var
  Temp: TRect;
  AOffset: TPoint;
  ACanvas: TcxCanvas;
begin
  if not cxRectIsEmpty(FPrevInvertRect) and cxRectIntersect(Temp, R, FPrevInvertRect) then
  begin
    SubtractRect(FPrevInvertRect, FPrevInvertRect, Temp);
    SubtractRect(Temp, R, Temp);
  end
  else
    Temp := R;
  AOffset := ScreenOffset;
  ACanvas := TcxScreenCanvas.Create;
  InvertRect(ACanvas, cxRectOffset(FPrevInvertRect, AOffset));
  InvertRect(ACanvas, cxRectOffset(Temp, AOffset));
  ACanvas.Free;
  FPrevInvertRect := R;
end;

procedure TcxSchedulerSplitterController.EraseInvertRect;
var
  ACanvas: TcxCanvas;
begin
  if cxRectIsEmpty(FPrevInvertRect) then Exit;
  ACanvas := TcxScreenCanvas.Create;
  InvertRect(ACanvas, cxRectOffset(FPrevInvertRect, ScreenOffset));
  FPrevInvertRect := cxNullRect;
  ACanvas.Free;
end;

function TcxSchedulerSplitterController.GetMonthSize: TSize;
begin
  Result := Scheduler.DateNavigator.GetMonthSize;
end;

function TcxSchedulerSplitterController.GetOwnerMousePos(X, Y: Integer): TPoint;
begin
  Result := cxPoint(X + Owner.Bounds.Left, Y + Owner.Bounds.Top);
end;

function TcxSchedulerSplitterController.GetSizingBoundsRect: TRect;
begin
  Result := Scheduler.ClientBounds;
  if Splitter.Kind = skHorizontal then
    SetVertBounds(Result)
  else
    SetHorzBounds(Result);
end;

function TcxSchedulerSplitterController.GetSizingIncrement: Integer;
begin
  if not IsIntegralSizing then
    Result := 1
  else
    if Splitter.Kind = skVertical then
      Result := GetMonthSize.cx
    else
      Result := GetMonthSize.cy;
end;

function TcxSchedulerSplitterController.GetSizingRect(const P: TPoint): TRect;
begin
  if Splitter.Kind = skHorizontal then
    Result := GetVertSizingRect(P)
  else
    Result := GetHorzSizingRect(P);
  with SizingBoundsRect do
  begin
    if Result.Left < Left then
      Result := cxRectSetLeft(Result, Left);
    if Result.Top < Top then
      Result := cxRectSetTop(Result, Top);
    if Result.Right > Right then
      Result := cxRectSetRight(Result, Right);
    if Result.Bottom > Bottom then
      Result := cxRectSetBottom(Result, Bottom);
  end;
end;

procedure TcxSchedulerSplitterController.InvertRect(ACanvas: TcxCanvas;
  R: TRect);
begin
  if cxRectIsEmpty(R) then Exit;
  if Splitter.Kind = skHorizontal then
  begin
    R.Left := Max(R.Left, ScreenCanvasClipRect.Left);
    R.Right := Min(R.Right, ScreenCanvasClipRect.Right);
  end
  else
  begin
    R.Top := Max(R.Top, ScreenCanvasClipRect.Top);
    R.Bottom := Min(R.Bottom, ScreenCanvasClipRect.Bottom);
  end;
  if not cxRectIsEmpty(R) then
    ACanvas.InvertRect(R);
end;

function TcxSchedulerSplitterController.IsIntegralSizing: Boolean;
begin
  Result := Scheduler.OptionsCustomize.IntegralSizing;
end;

function TcxSchedulerSplitterController.IsDynamicUpdate: Boolean;
begin
  Result := Scheduler.IsDynamicUpdate; 
end;

procedure TcxSchedulerSplitterController.SetSizeDelta(ADelta: Integer);
begin
  if Splitter.Kind = skHorizontal then
    SetVertDelta(ADelta)
  else
    SetHorzDelta(ADelta);
end;

procedure TcxSchedulerSplitterController.UpdateSizing(const R: TRect);

  function GetDelta: Integer;
  begin
    if Splitter.Kind = skHorizontal then
      Result := Splitter.Top - R.Top
    else
      Result := Splitter.Left - R.Left;
  end;

var
  ADelta: Integer;
begin
  ADelta := GetDelta;
  if ADelta <> 0 then
  begin
    SetSizeDelta(ADelta);
    if IsDynamicUpdate then
      Scheduler.Update;
    Scheduler.DateNavigator.SaveSize;
  end;
end;

function TcxSchedulerSplitterController.GetDrawClipRect: TRect;
var
  AParent: TControl;
  R: TRect;
begin
  with Scheduler do
  begin
    Result := cxRectOffset(ClientBounds, ClientToScreen(cxNullPoint));
    AParent := Parent;
  end;
  while AParent <> nil do
  begin
    R := cxRectOffset(AParent.ClientRect, AParent.ClientOrigin);
    if AParent.Parent <> nil then
      cxRectOffset(R, AParent.ClientToScreen(cxNullPoint));
    cxRectIntersect(Result, Result, R);
    AParent := AParent.Parent;
  end;
end;

function TcxSchedulerSplitterController.GetHorzSizingRect(
  const P: TPoint): TRect;
var
  AStep, ANewPos: Integer;
begin
  AStep := GetSizingIncrement;
  ANewPos := FStartBounds.Left - Round((FHitPoint.X - P.X) / AStep) * AStep;
  Result := cxRectSetLeft(FStartBounds, ANewPos);
end;

function TcxSchedulerSplitterController.GetScheduler: TcxCustomScheduler;
begin
  Result := Owner.Scheduler;
end;

function TcxSchedulerSplitterController.GetScreenOffset: TPoint;
begin
  Result := Scheduler.ClientToScreen(cxNullPoint);
end;

function TcxSchedulerSplitterController.GetSplitter: TcxSchedulerSplitter;
begin
  Result := TcxSchedulerSplitter(inherited Owner);
end;

function TcxSchedulerSplitterController.GetVertSizingRect(
  const P: TPoint): TRect;
var
  AStep, ANewPos: Integer;
begin
  AStep := GetSizingIncrement;
  ANewPos := FStartBounds.Top - Round((FHitPoint.Y - P.Y) / AStep) * AStep;
  Result := cxRectSetTop(FStartBounds, ANewPos);
end;

procedure TcxSchedulerSplitterController.SetHorzBounds(var R: TRect);
var
  W: Integer;
begin
  W := ((R.Right - R.Left - Splitter.Width) div GetMonthSize.cx) *
    GetMonthSize.cx + Splitter.Width;
  if Scheduler.IsViewAtLeft then
  begin
    if IsIntegralSizing then
      R.Left := R.Right - W;
    Dec(R.Right, GetMonthSize.cx);
  end
  else
  begin
    if IsIntegralSizing then
      R.Right := R.Left + W;
    Inc(R.Left, GetMonthSize.cx);
  end;
end;

procedure TcxSchedulerSplitterController.SetHorzDelta(ADelta: Integer);
begin
  with Scheduler do
  begin
    if IsViewAtLeft then
      CurrentView.Width := CurrentView.Width - ADelta
    else
      DateNavigator.Width := DateNavigator.Width - ADelta;
  end;
end;

procedure TcxSchedulerSplitterController.SetVertBounds(var R: TRect);
begin
  if IsIntegralSizing then
    R.Bottom := R.Top + ((R.Bottom - R.Top - Splitter.Height) div GetMonthSize.cy) *
     GetMonthSize.cy + Splitter.Height;
  Inc(R.Top, GetMonthSize.cy);
end;

procedure TcxSchedulerSplitterController.SetVertDelta(ADelta: Integer);
begin
  with Scheduler.DateNavigator do
    Height := Height - ADelta;
end;

{ TcxSchedulerSplitter }

function TcxSchedulerSplitter.AllowDesignHitTest(
  X, Y: Integer; AShift: TShiftState): Boolean;
begin
  Result := True;   
end;

function TcxSchedulerSplitter.CreateController: TcxSchedulerSubControlController;
begin
  Result := TcxSchedulerSplitterController.Create(Self);
end;

procedure TcxSchedulerSplitter.DoLayoutChanged;
begin
  FViewParams := Styles.GetSplitterParams(Kind);
  inherited DoLayoutChanged;
end;

procedure TcxSchedulerSplitter.DoPaint;
begin
  LookAndFeelPainter.DrawSchedulerSplitterBorder(Canvas, ClientRect,
    ViewParams, Kind = skHorizontal);
end;

procedure TcxSchedulerSplitter.UpdateCursor;
const
  Cursors: array[TcxSchedulerSplitterKind] of TCursor = (
    crSchedulerVertSplit, crSchedulerHorzSplit);
begin
  if Scheduler.OptionsCustomize.ControlsSizing then
    Cursor := Cursors[Kind]
  else
    Cursor := crDefault;
end;

procedure TcxSchedulerSplitter.SetKind(AKind: TcxSchedulerSplitterKind);
begin
  FKind := AKind;
  UpdateCursor;
end;

{ TcxSchedulerEventOperations }

constructor TcxSchedulerEventOperations.Create(
  AOwner: TcxCustomScheduler);
begin
  FScheduler := AOwner;
  FCreating := True;
  FDeleting := True;
  FDialogEditing := True;
  FDialogShowing := True;
  FInplaceEditing := True;
  FMoving := True;
  FMovingBetweenResources := True;
  FReadOnly := False;
  FRecurrence := True;
  FSizing := True;
end;

procedure TcxSchedulerEventOperations.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerEventOperations then
    with TcxSchedulerEventOperations(Source) do
    begin
      Self.FCreating := FCreating;
      Self.FDeleting := FDeleting;
      Self.FDialogEditing := FDialogEditing;
      Self.FDialogShowing := FDialogShowing;
      Self.FInplaceEditing := FInplaceEditing;
      Self.FMoving := FMoving;
      Self.FMovingBetweenResources := FMovingBetweenResources;
      Self.FReadOnly := FReadOnly;
      Self.FRecurrence := FRecurrence;
      Self.FSizing := FSizing;
    end
  else
    inherited Assign(Source);
end;

function TcxSchedulerEventOperations.GetOwner: TPersistent;
begin
  Result := FScheduler;
end;

function TcxSchedulerEventOperations.GetCreating: Boolean;
begin
  Result := not FReadOnly and FCreating;
end;

function TcxSchedulerEventOperations.GetCreatingStored: Boolean;
begin
  Result := not (FReadOnly or FCreating);
end;

function TcxSchedulerEventOperations.GetDeleting: Boolean;
begin
  Result := not FReadOnly and FDeleting;
end;

function TcxSchedulerEventOperations.GetDeletingStored: Boolean;
begin
  Result := not (FReadOnly or FDeleting);
end;

function TcxSchedulerEventOperations.GetDialogEditing: Boolean;
begin
  Result := not FReadOnly and FDialogEditing;
end;

function TcxSchedulerEventOperations.GetDialogEditingStored: Boolean;
begin
  Result := not (FReadOnly or FDialogEditing);
end;

function TcxSchedulerEventOperations.GetInplaceEditing: Boolean;
begin
  Result := not FReadOnly and FInplaceEditing;
end;

function TcxSchedulerEventOperations.GetInplaceEditingStored: Boolean;
begin
  Result := not (FReadOnly or FInplaceEditing);
end;

function TcxSchedulerEventOperations.GetMoving: Boolean;
begin
  Result := not FReadOnly and FMoving;
end;

function TcxSchedulerEventOperations.GetMovingBetweenResources: Boolean;
begin
  Result := not FReadOnly and FMovingBetweenResources;
end;

function TcxSchedulerEventOperations.GetMovingBetweenResourcesStored: Boolean;
begin
  Result := not (FReadOnly or FMovingBetweenResources);
end;

function TcxSchedulerEventOperations.GetMovingStored: Boolean;
begin
  Result := not (FReadOnly or FMoving);
end;

function TcxSchedulerEventOperations.GetSizing: Boolean;
begin
  Result := not FReadOnly and FSizing;
end;

function TcxSchedulerEventOperations.GetSizingStored: Boolean;
begin
  Result := not (FReadOnly or FSizing);
end;

{ TcxSchedulerOptionsCustomize }

constructor TcxSchedulerOptionsCustomize.Create(
  AOwner: TcxCustomScheduler);
begin
  FScheduler := AOwner;
  FControlsSizing := True;
  FIntegralSizing := True;
end;

procedure TcxSchedulerOptionsCustomize.Assign(Source: TPersistent);
var
  ASourceOptionsCustomize: TcxSchedulerOptionsCustomize;
begin
  if Source is TcxSchedulerOptionsCustomize then
  begin
    ASourceOptionsCustomize := TcxSchedulerOptionsCustomize(Source);
    FControlsSizing := ASourceOptionsCustomize.ControlsSizing;
    FDynamicSizing := ASourceOptionsCustomize.DynamicSizing;
    IntegralSizing := ASourceOptionsCustomize.IntegralSizing;
  end
  else
    inherited Assign(Source);
end;

procedure TcxSchedulerOptionsCustomize.Changed;
begin
  FScheduler.LayoutChanged;
end;

function TcxSchedulerOptionsCustomize.GetOwner: TPersistent;
begin
  Result := FScheduler;
end;

procedure TcxSchedulerOptionsCustomize.SetControlsSizing(AValue: Boolean);
begin
  FControlsSizing := AValue;
  Scheduler.HorzSplitter.UpdateCursor;
  Scheduler.VertSplitter.UpdateCursor;
end;

procedure TcxSchedulerOptionsCustomize.SetIntegralSizing(AValue: Boolean);
begin
  if AValue <> FIntegralSizing then
  begin
    FIntegralSizing := AValue;
    if AValue then
      Scheduler.DateNavigator.SetIntegralSizes;
    Changed;
  end;
end;

{ TcxSchedulerOptionsView }

constructor TcxSchedulerOptionsView.Create(
  AOwner: TcxCustomScheduler);
begin
  FTimeZones[0] := -1;
  FTimeZones[1] := -1;
  FDayBorderColor := clDefault; 
  FGroupSeparatorWidth := cxDefaultGroupSeparatorWidth;
  FScheduler := AOwner;
  FHorzSplitterWidth := cxDefaultSplitterWidth;
  FVertSplitterWidth := cxDefaultSplitterWidth;
  FHideSelection := False;
  FHotTrack := False; //for the next version True;
  FRotateResourceCaptions := True;
  FWorkDays := DateTimeHelper.WorkDays;
  FStartOfWeek := swSystem;
  CalculateActualStartOfWeek;
  FWorkFinish := DateTimeHelper.WorkFinish;
  FWorkStart := DateTimeHelper.WorkStart;
  FViewPosition := vpLeft;
  ShowHints := True;
end;

procedure TcxSchedulerOptionsView.Assign(
  Source: TPersistent);
var
  AItem: Integer;
  ASourceOptionsView: TcxSchedulerOptionsView;
begin
  if Source is TcxSchedulerOptionsView then
  begin
    ASourceOptionsView := TcxSchedulerOptionsView(Source);
    for AItem := 0 to 1 do
    begin
      FTimeZones[AItem] := ASourceOptionsView.FTimeZones[AItem];
      FTimeZoneLabels[AItem] := ASourceOptionsView.FTimeZoneLabels[AItem];
    end;
    FDayBorderColor := ASourceOptionsView.DayBorderColor;
    FGroupingKind := ASourceOptionsView.FGroupingKind;
    FGroupSeparatorWidth := ASourceOptionsView.FGroupSeparatorWidth;
    FHideSelection := ASourceOptionsView.HideSelection;
    FHorzSplitterWidth := ASourceOptionsView.FHorzSplitterWidth;
    FHotTrack := ASourceOptionsView.HotTrack;
    FRotateResourceCaptions := ASourceOptionsView.RotateResourceCaptions;
    FShowHints := ASourceOptionsView.ShowHints;
    FVertSplitterWidth := ASourceOptionsView.FVertSplitterWidth;
    FViewPosition := ASourceOptionsView.ViewPosition;
    FWorkDays := ASourceOptionsView.WorkDays;
    FWorkFinish := ASourceOptionsView.WorkFinish;
    FWorkStart := ASourceOptionsView.WorkStart;
  end
  else
    inherited Assign(Source);
end;

procedure TcxSchedulerOptionsView.CalculateActualStartOfWeek;
begin
  if FStartOfWeek = swSystem then
    FActualStartOfWeek := TDay(DateTimeHelper.StartOfWeek)
  else
    FActualStartOfWeek := TDay(Pred(FStartOfWeek));
end;

procedure TcxSchedulerOptionsView.Changed;
begin
  Scheduler.LayoutChanged;
end;

function TcxSchedulerOptionsView.GetOwner: TPersistent;
begin
  Result := FScheduler;
end;

function TcxSchedulerOptionsView.IsWorkDaysStored: Boolean;
begin
  Result := FWorkDays <> DateTimeHelper.WorkDays;
end;

function TcxSchedulerOptionsView.IsWorkFinishStored: Boolean;
begin
  Result := FWorkFinish <> DateTimeHelper.WorkFinish;
end;

function TcxSchedulerOptionsView.IsWorkStartStored: Boolean;
begin
  Result := FWorkStart <> DateTimeHelper.WorkStart;
end;

function TcxSchedulerOptionsView.IsWorkTime(
  const ADateTime: TDateTime): Boolean;
begin
  Result := (TDay(DayOfWeek(ADateTime) - 1) in WorkDays) and
    ((DateTimeHelper.RoundTime(TimeOf(ADateTime)) >= WorkStart) and
     (DateTimeHelper.RoundTime(TimeOf(ADateTime)) < WorkFinish));
end;

function TcxSchedulerOptionsView.GetDateTimeHelperClass: TcxSchedulerDateTimeHelperClass;
begin
  Result := Scheduler.DateTimeHelper;
end;

function TcxSchedulerOptionsView.GetTimeZone(
  AIndex: Integer): Integer;
begin
  Result := FTimeZones[AIndex];
  if (Result < 0) or (Result >= DateTimeHelper.TimeZoneCount) then
    Result := -1;
end;

function TcxSchedulerOptionsView.GetTimeZoneLabel(
  AIndex: Integer): string;
begin
  Result := FTimeZoneLabels[AIndex];
end;

procedure TcxSchedulerOptionsView.SetDayBorderColor(AValue: TColor);
begin
  if AValue <> FDayBorderColor then
  begin
    FDayBorderColor := AValue;
    Changed; 
  end;
end;

procedure TcxSchedulerOptionsView.SetShowEventsWithoutResource(
  AValue: Boolean);
begin
  if AValue <> FShowEventsWithoutResource then
  begin
    FShowEventsWithoutResource := AValue;
    Scheduler.FullRefresh;
  end;
end;

procedure TcxSchedulerOptionsView.SetGroupSeparatorWidth(
  AValue: Integer);
begin
  FGroupSeparatorWidth := Max(0, AValue);
  Changed;
end;

procedure TcxSchedulerOptionsView.SetGroupingKind(
  AValue: TcxSchedulerGroupingKind);
begin
  if FGroupingKind <> AValue then
  begin
    FGroupingKind := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerOptionsView.SetHideSelection(AValue: Boolean);
begin
  if FHideSelection <> AValue then
  begin
    FHideSelection := AValue;
    Changed; 
  end;
end;

procedure TcxSchedulerOptionsView.SetHorzSplitterWidth(AValue: Integer);
begin
  SetSplitterWidth(AValue, FHorzSplitterWidth);
end;

procedure TcxSchedulerOptionsView.SetRotateResourceCaptions(AValue: Boolean);
begin
  if AValue <> FRotateResourceCaptions then
  begin
    FRotateResourceCaptions := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerOptionsView.SetShowAdditionalTimeZone(AValue: Boolean);
begin
  if FShowAdditionalTimeZone <> AValue then
  begin
    FShowAdditionalTimeZone := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerOptionsView.SetSplitterWidth(
  AValue: Integer; var AWidth: Integer);
begin
  AValue := Max(AValue, cxMinSplitterWidth);
  if AValue <> AWidth then
  begin
    AWidth := AValue;
    Changed;
  end;                                
end;

procedure TcxSchedulerOptionsView.SetStartOfWeek(AValue: TcxStartOfWeek);
var
  AOldActualValue: TDay;
begin
  if AValue <> FStartOfWeek then
  begin
    FStartOfWeek := AValue;
    AOldActualValue := ActualStartOfWeek;
    CalculateActualStartOfWeek;
    if not Scheduler.IsLoading then
      Scheduler.DoStartOfWeekChanged(AOldActualValue, ActualStartOfWeek);
  end;
end;

procedure TcxSchedulerOptionsView.SetTimeZone(
  AIndex, AValue: Integer);
begin
  AValue := Max(Min(AValue, DateTimeHelper.TimeZoneCount - 1), -1);
  if AValue <> FTimeZones[AIndex] then
  begin
    FTimeZones[AIndex] := AValue;
    Scheduler.FullRefresh;
  end;
end;

procedure TcxSchedulerOptionsView.SetTimeZoneLabel(
  AIndex: Integer; const AValue: string);
begin
  if AValue <> FTimeZoneLabels[AIndex] then
  begin
    FTimeZoneLabels[AIndex] := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerOptionsView.SetVertSplitterWidth(AValue: Integer);
begin
  SetSplitterWidth(AValue, FVertSplitterWidth);
end;

procedure TcxSchedulerOptionsView.SetViewPosition(
  AValue: TcxSchedulerViewPosition);
begin
  if AValue <> FViewPosition then
  begin
    FViewPosition := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerOptionsView.SetWorkDays(AValue: TDays);
begin
  if AValue <> FWorkDays then
  begin
    FWorkDays := AValue;
    Scheduler.PeriodChanged;
  end;
end;

procedure TcxSchedulerOptionsView.SetWorkFinish(AValue: TTime);
begin
  if AValue <> FWorkFinish then
  begin
    FWorkFinish := DateTimeHelper.RoundTime(AValue);
    Scheduler.PeriodChanged;
  end;
end;

procedure TcxSchedulerOptionsView.SetWorkStart(AValue: TTime);
begin
  if AValue <> FWorkStart then
  begin
    FWorkStart := DateTimeHelper.RoundTime(AValue);
    Scheduler.PeriodChanged;
  end;
end;

function TcxSchedulerOptionsView.IsTimeZoneLabelStored(
  AIndex: Integer): Boolean;
begin
  Result := FTimeZoneLabels[AIndex] <> '';
end;

{ TcxSchedulerViewHitTest }

function TcxSchedulerViewHitTest.GetDragKind: TcxEventDragKind;
begin
  Result := edkNone;
end;                                      

procedure TcxSchedulerViewHitTest.Clear;
begin
  inherited Clear;
  FNeedShowHint := False; 
  FTime := NullDate;
end;

function TcxSchedulerViewHitTest.GetHitEvent: TcxSchedulerControlEvent;
begin
  Result := nil;
end;

function TcxSchedulerViewHitTest.GetHitAtEvent: Boolean;
begin
  Result := Event <> nil;
end;

{ TcxDragHelper }

constructor TcxDragHelper.Create(AScheduler: TcxCustomScheduler);
begin
  FScheduler := AScheduler;
  BeginDrag;
end;

procedure TcxDragHelper.BeginDrag;
begin
  //FLockShowEditorOnMouseClick := DragKind = edkMoveEvent;
  GetOriginState;
end;

procedure TcxDragHelper.DragOver(const P: TPoint; State: TDragState;
  var Accepted: Boolean);
begin
end;

procedure TcxDragHelper.EndDrag(Accepted: Boolean);
begin
end;

function TcxDragHelper.GetOriginHitTestMask: Int64;
const
  Mask = 1 shl htcControl;
begin
  Result := Mask;
end;

procedure TcxDragHelper.GetOriginState;
begin
  with Controller do
  begin
    FStartHitFlags := StartDragFlags and GetOriginHitTestMask;
    FStartHitTime := StartDragHitTime;
    FStartResource := StartDragResource;
  end;
  FPrevHitTime := FStartHitTime;
  FPrevHitFlags := FStartHitFlags;
  FPrevHitResource := FStartResource;
end;

function TcxDragHelper.HasChangedState: Boolean;
begin
  with HitTest do
    Result := (FPrevHitFlags <> (Flags and GetOriginHitTestMask)) or
      (HitAtTime and (FPrevHitTime <> Time)) or
      (HitAtResource and (FPrevHitResource <> Resource));
end;

function TcxDragHelper.IsAtOrigin: Boolean;
begin
  with HitTest do
  begin
    Result := (FStartHitFlags = (Flags and GetOriginHitTestMask)) and
      (Controller.StartDragHitTime = Time);
    if Result and IsShowResources then
      Result := HitAtResource and (FStartResource = Resource);
  end;
end;

function TcxDragHelper.IsShowResources: Boolean;
begin
  Result := Scheduler.CurrentView.IsShowResources;
end;

function TcxDragHelper.IsValidTime: Boolean;
begin
  Result := HitTest.HitAtTime;
end;

procedure TcxDragHelper.RefreshCurrentView;
begin
  Scheduler.CurrentView.Refresh;
end;

procedure TcxDragHelper.SetSelection;
begin
  Controller.SyncEventSelection(Controller.DragEvent);
end;

procedure TcxDragHelper.UpdateState;
begin
  with HitTest do
  begin
    FPrevHitFlags := Flags and GetOriginHitTestMask;
    FPrevHitTime := Time;
    FPrevHitResource := Resource;
  end;
end;

function TcxDragHelper.GetController: TcxSchedulerViewController;
begin
  Result := Scheduler.CurrentView.Controller;
end;

function TcxDragHelper.GetEvents: TcxSchedulerCachedEventList;
begin
  Result := Scheduler.EventList;
end;

function TcxDragHelper.GetHitTest: TcxSchedulerViewHitTest;
begin
  Result := Scheduler.CurrentView.HitTest;
end;

{ TcxSchedulerDragObject}

constructor TcxSchedulerDragObject.Create(AControl: TControl);
begin
  inherited Create(AControl);
  FUseInternalCursors := (Control is TcxCustomScheduler) and
    (TcxCustomScheduler(Control).DragCursor = crDrag);
end;

function TcxSchedulerDragObject.GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor;
begin
  if Accepted and FUseInternalCursors then
  begin
    if TcxCustomScheduler(Control).IsCopyDragDrop then
      Result := crSchedulerCopyEvent
    else
      Result := crSchedulerMoveEvent;
  end
  else
    Result := inherited GetDragCursor(Accepted, X, Y);
end;

{ TcxDragEventHelper }

procedure TcxDragEventHelper.ApplyChanges;
begin
  UpdateEventProperties;
  if IsValidNavigatorDate then
    ProcessDateNavigator;
  SetSelection;
  Events.PostClones(IsDragCopy)
end;

procedure TcxDragEventHelper.BeginDrag;
begin
  inherited BeginDrag;
  FSaveCursor := Scheduler.DragCursor;
  PrepareClones;
  Events.AlwaysShowSelectedEvent := False;
  CheckVisibility(True);
end;

procedure TcxDragEventHelper.CheckVisibility(Accepted: Boolean);
begin
  Inc(Scheduler.FLockRefresh);
  try
    Events.AlwaysShowSelectedEvent := not Accepted or not HitTest.HitAtTime;
    ViewInfo.SetEventsVisibility(GetSourcesVisible(Accepted),
      GetClonesVisible(Accepted), True);
  finally
    Dec(Scheduler.FLockRefresh);
  end;
end;

procedure TcxDragEventHelper.CheckAccepted(var Accepted: Boolean);

  function CanMoveBetweenResources: Boolean;
  var
    AResource: TcxSchedulerStorageResourceItem;
  begin
    AResource := HitTest.Resource;
    Result := (FStartResource = AResource) or
      (Scheduler.EventOperations.MovingBetweenResources and
       ((AResource = nil) or not AResource.ReadOnly));
  end;

var
  P: TPoint;
begin
  if not Accepted then Exit;
  P := Scheduler.ScreenToClient(GetMouseCursorPos);
  if Scheduler.ControlBox.Visible and cxRectPtIn(Scheduler.ControlBox.Bounds, P) then Exit;
  Accepted := False;
  if cxRectPtIn(Scheduler.CurrentView.Bounds, P) then
  begin
    Accepted := HitTest.HitAtTime;
    if Accepted and IsShowResources and HitTest.HitAtResource and
      not CanMoveBetweenResources then Accepted := False;
  end;
  UpdateDateNavigator(Accepted);
end;

procedure TcxDragEventHelper.CorrectAllDayEventProperty;
var
  I: Integer;
begin
  if IsValidNavigatorDate then
    RestoreAllDayProperties
  else
    for I := 0 to Clones.Count - 1 do
      with Clones[I] do
      begin
        AllDayEvent := AllDayEvent and (not IsHeaderEvent(Source) or Source.AllDayEvent);
        if not AllDayEvent and (Duration > 1) then
          MoveTo(DateOf(Start) + TimeOf(Source.Start));
      end;
end;

procedure TcxDragEventHelper.DragOver(const P: TPoint; State: TDragState;
  var Accepted: Boolean);
begin
  CheckAccepted(Accepted);
  if Accepted and (HasChangedState or (State in [dsDragLeave, dsDragEnter])) then
  begin
    Accepted := IsValidTime and ({$IFDEF DELPHI6}DragObject.Dropped{$ELSE}DragObject.Cancelling{$ENDIF} or (State <> dsDragLeave));
    if Accepted then
      UpdateClones;
  end;
  CheckVisibility(Accepted);
  if State <> dsDragLeave then
    Controller.CheckScrolling(P)
  else
    Controller.CancelScroll;
end;

procedure TcxDragEventHelper.EndDrag(Accepted: Boolean);
begin
  Controller.CancelScroll;
  Scheduler.DragCursor := FSaveCursor;
  with Scheduler do
  begin
    Accepted := Accepted and IsValidTime and not (IsAtOrigin and not IsDragCopy);
    if Accepted and (IsValidNavigatorDate or HitTest.HitAtControl) then
    begin
      UpdateClones;
      ApplyChanges;
    end
    else FullRefresh;
    DateNavigator.Controller.DoCancelMode;
  end;
  RefreshCurrentView;
end;

function TcxDragEventHelper.GetClonesVisible(Accepted: Boolean): Boolean;
begin
  if FInNavigator and Accepted then
    Result := False
  else
    Result := Accepted and not (IsAtOrigin and not IsDragCopy);
end;

function TcxDragEventHelper.GetIsDragCopy: Boolean;
begin
  Result := Scheduler.IsCopyDragDrop;
end;

procedure TcxDragEventHelper.GetOriginState;
begin
  inherited GetOriginState;
  FInNavigator := False;
  FPrevIsDragCopy := IsDragCopy;
end;

function TcxDragEventHelper.GetSourcesVisible(Accepted: Boolean): Boolean;
begin
  Result := not Accepted or (FInNavigator or IsAtOrigin or IsDragCopy);
end;

function TcxDragEventHelper.HasChangedState: Boolean;
begin
  Result := inherited HasChangedState or (FPrevIsDragCopy <> IsDragCopy);
end;

function TcxDragEventHelper.IsValidNavigatorDate: Boolean;
begin
  Result := FInNavigator and DateNavigator.HitTest.HitAtTime;
end;

function TcxDragEventHelper.IsValidTime: Boolean;
begin
  Result := HitTest.HitAtTime or IsValidNavigatorDate;
end;

procedure TcxDragEventHelper.PrepareClones;
var
  I: Integer;
  AEvent: TcxSchedulerControlEvent;
  AResource, ADragEventResource: TcxSchedulerStorageResourceItem;
begin
  ADragEventResource := Controller.DragEvent.GetResourceItem;
  for I := Events.Selection.Count - 1 downto 0 do
  begin
    AEvent := Events.Selection.Items[I];
    AResource := AEvent.GetResourceItem;
    if IsShowResources and (AResource <> nil) and (AResource <> ADragEventResource) then
      Events.Selection.Add(AEvent, [ssCtrl]);
  end;
  Events.CreateClones;
end;

procedure TcxDragEventHelper.ProcessDateNavigator;
var
  I: Integer;
  AEvent: TcxSchedulerControlEvent;
  ADate: TDateTime;
begin
  ADate := DateNavigator.HitTest.Time;
  for I := 0 to Clones.Count - 1 do
  begin
    AEvent := Clones[I];
    AEvent.MoveTo(TimeOf(AEvent.Source.Start) + ADate);
  end;
end;

procedure TcxDragEventHelper.RestoreAllDayProperties;
var
  I: Integer;
begin
  for I := 0 to Clones.Count - 1 do
    with Clones[I] do AllDayEvent := Source.AllDayEvent;
end;

procedure TcxDragEventHelper.SetSelection;
var
  I: Integer;
  AEvent: TcxSchedulerControlEvent;
begin
  for I := 0 to Clones.Count - 1 do
  begin
    AEvent := Clones[I];
    if AEvent.Source = Controller.DragEvent then
      Controller.SyncEventSelection(AEvent);
  end;
end;

procedure TcxDragEventHelper.UpdateClones;
var
  I: Integer;
  AResource: TcxSchedulerStorageResourceItem;
begin
  with HitTest do
    if HitAtResource then
      AResource := Resource
    else
      AResource := FStartResource;
  for I := 0 to Clones.Count - 1 do
    if not VarIsNull(Clones[I].ResourceID) and (AResource <> nil) then
      Clones[I].ResourceID := AResource.ResourceID;
  if HitTest.HitAtTime and not FInNavigator then
    UpdateClonesTime;
end;

procedure TcxDragEventHelper.UpdateClonesTime;
begin
end;

procedure TcxDragEventHelper.UpdateDateNavigator(var Accepted: Boolean);
begin
  with DateNavigator do
  begin
    if not Visible then Exit;
    HitTest.HitPoint := cxPointOffset(Scheduler.ScreenToClient(GetMouseCursorPos),
      -Left, -Top);
    FInNavigator := HitTest.HitAtControl;
    if FInNavigator then
      Accepted := HitTest.HitAtTime;
    UpdateDragging;
  end;
end;

procedure TcxDragEventHelper.UpdateEventProperties;
begin
  CorrectAllDayEventProperty;
end;

procedure TcxDragEventHelper.UpdateState;
begin
  inherited UpdateState;
  FPrevIsDragCopy := IsDragCopy;
end;

function TcxDragEventHelper.GetClones: TcxSchedulerFilteredEventList;
begin
  Result := Scheduler.EventList.Clones;
end;

function TcxDragEventHelper.GetDateNavigator: TcxSchedulerCustomDateNavigator;
begin
  Result := Scheduler.DateNavigator;
end;

function TcxDragEventHelper.GetViewInfo: TcxSchedulerCustomViewViewInfo;
begin
  Result := TcxSchedulerCustomViewViewInfo(Scheduler.CurrentView.ViewInfo);
end;

{ TcxSchedulerEditController }

constructor TcxSchedulerEditController.Create(AOwner: TcxCustomScheduler);
begin
  FOwner := AOwner;
  FEditList := TcxInplaceEditList.Create(AOwner);
end;

destructor TcxSchedulerEditController.Destroy;
begin
  CloseEdit(False);
  FEditList.Free;
  inherited Destroy;
end;

procedure TcxSchedulerEditController.Activate(
  AEvent: TcxSchedulerControlEvent);
begin
  if InitEdit(AEvent) then
    FEdit.Activate(FEditData);
end;

procedure TcxSchedulerEditController.Activate(
  AEvent: TcxSchedulerControlEvent; const APos: TPoint; AShift: TShiftState);
begin
  if InitEdit(AEvent) then
    FEdit.ActivateByMouse(AShift, APos.X, APos.Y, FEditData);
end;

procedure TcxSchedulerEditController.Activate(
  AEvent: TcxSchedulerControlEvent; Key: Char);
begin
  if InitEdit(AEvent) then
    FEdit.ActivateByKey(Key, FEditData);
end;

procedure TcxSchedulerEditController.CloseEdit(Accepted: Boolean);

  function IsDataRefreshing: Boolean;
  begin
    Result := Scheduler.FLockRefresh > 0;
  end;

begin
  if not IsEditing then Exit;
  FIsEditing := False;
  FFocused := False;
  try
    if not IsDataRefreshing then
      if Accepted and CanAccept then
      begin
        if not FEdit.Deactivate then raise EAbort.Create('');
        UpdateValue;
        Scheduler.EventList.PostEvent(Event);
        Scheduler.SetFocus;
      end
      else
      begin
        if FIsNewEvent then
        begin
          Event.Source.Delete;
          FEvent := nil;
        end;
        Scheduler.FullRefresh;
      end;
  finally
    FEdit.Parent := nil;
    FEdit := nil;
    FreeAndNil(FEditData);
    Scheduler.DoAfterEditing(Event);
    FIsNewEvent := False;
    FEvent := nil;
    if not IsDataRefreshing then
      Scheduler.CurrentView.Refresh;
  end;
end;

procedure TcxSchedulerEditController.Init(const AEditDate: TDateTime;
  AResource: TcxSchedulerStorageResourceItem; AIsNewEvent: Boolean = False);
begin
  FEditDate := DateOf(AEditDate);
  FEditResource := AResource;
  FIsNewEvent := AIsNewEvent;
end;

procedure TcxSchedulerEditController.UpdateEdit;
var
  R: TRect; 
begin
  if not IsEditing then Exit;
  if GetEditRect(R, FEditDate, FEditResource) then
  begin
    FEdit.BoundsRect := R;
    FEdit.Visible := True;
  end
  else
    FEdit.Visible := False;
  FEdit.EditValue := FEvent.Caption;
end;

procedure TcxSchedulerEditController.UpdateValue;
begin
  if (FEdit <> nil) and  FEdit.EditModified then
  begin
    FEdit.ValidateEdit(True);
    FEvent.Caption := FEdit.EditValue;
  end;
end;

function TcxSchedulerEditController.GetEditRect(var R: TRect;
  const ADate: TDateTime; AResource: TcxSchedulerStorageResourceItem;
  AMakeVisible: Boolean = False): Boolean;
begin
  Scheduler.MakeEventVisible(Event, ADate, AResource);
  with Scheduler.CurrentView do
    R := cxRectOffset(GetEditRectForEvent(Event, ADate, AResource), Bounds.TopLeft);
  Result := not cxRectIsEmpty(R);
end;

procedure TcxSchedulerEditController.EditAfterKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if IsKeyForControl(Key, Shift) then
  begin
    Scheduler.SetFocus;
    CloseEdit(True);
  end;
end;

procedure TcxSchedulerEditController.EditExit(Sender: TObject);
begin
  if IsEditing then CloseEdit(True);
end;

procedure TcxSchedulerEditController.EditKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if IsKeyForControl(Key, Shift) then
  begin
    CloseEdit(Key <> VK_ESCAPE);
    Scheduler.SetFocus;
  end;
  if Assigned(Scheduler.OnKeyDown) then
    Scheduler.OnKeyDown(Scheduler, Key, Shift);
end;

procedure TcxSchedulerEditController.EditKeyPress(
  Sender: TObject; var Key: Char);
begin
  if Assigned(Scheduler.OnKeyPress) then
    Scheduler.OnKeyPress(Scheduler, Key);
end;

procedure TcxSchedulerEditController.EditKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Assigned(Scheduler.OnKeyUp) then
    Scheduler.OnKeyUp(Scheduler, Key, Shift);
end;

procedure TcxSchedulerEditController.EditPostEditValue(Sender: TObject);
begin
  UpdateValue;
end;

function TcxSchedulerEditController.InitEdit(
  AEvent: TcxSchedulerControlEvent): Boolean;
var
  R: TRect; 
begin
  Result := False;
  if AEvent = nil then Exit;
  if IsEditing then
  begin
    if FEvent = AEvent then
    begin
      UpdateValue;
      UpdateEdit;
    end
    else
      CloseEdit(True);
    Exit;
  end;
  FIsEditing := False;
  FEvent := AEvent;
  Controller.SelectSingleEvent(AEvent, NullDate, False);
  if not (Scheduler.DoBeforeEditing(AEvent, True) and
    GetEditRect(R, FEditDate, FEditResource, True)) then Exit;
  Scheduler.DoGetEventEditProperties(Event, FEditProperties);
  FEdit := FEditList.GetEdit(EditProperties);
  Result :=  FEdit <> nil;
  if not Result then Exit;
  FIsEditing := True;
  PrepareEdit(FEdit);
  if FIsEditing then
    Scheduler.CurrentView.Refresh;
end;

function TcxSchedulerEditController.IsKeyForControl(
  var AKey: Word; Shift: TShiftState): Boolean;
begin
  Result := (AKey = VK_TAB) or (AKey = VK_ESCAPE) or (AKey = VK_RETURN);
end;

procedure TcxSchedulerEditController.PrepareEdit(AEdit: TcxCustomEdit);
var
  R: TRect;
  AParams: TcxViewParams;
begin
  FFocused := True;
  FEdit.Visible := GetEditRect(R, FEditDate, FEditResource);
  FEdit.BoundsRect := R;
  FEdit.Parent := Scheduler;
  FEdit.EditValue := FEvent.Caption;
  with TcxCustomEditAccess(FEdit) do
  begin
    OnAfterKeyDown := EditAfterKeyDown;
    OnExit := EditExit;
    OnKeyDown := EditKeyDown;
    OnKeyPress := EditKeyPress;
    OnKeyUp := EditKeyUp;
    OnPostEditValue := EditPostEditValue;
    AParams := Scheduler.Styles.GetEventContentParams(Event);
    Color := AParams.Color;
    Font := AParams.Font;
    Font.Color := AParams.TextColor;
  end;
  Scheduler.DoInitEdit(FEdit);
end;

function TcxSchedulerEditController.CanAccept: Boolean;
begin
  Result := not Scheduler.IsDestroying and (FEdit.EditModified or FIsNewEvent);
end;

function TcxSchedulerEditController.GetController: TcxSchedulerViewController;
begin
  Result := View.Controller;
end;

function TcxSchedulerEditController.GetEditVisible: Boolean;
begin
  Result := IsEditing and FEdit.Visible;
end;

function TcxSchedulerEditController.GetView: TcxSchedulerCustomView;
begin
  Result := Scheduler.CurrentView;
end;

procedure TcxSchedulerEditController.SetEditVisible(Value: Boolean);
begin
  if not IsEditing then Exit;
  if Value <> EditVisible then
  begin
    FEdit.Visible := Value;
    UpdateEdit;
  end;
end;

{ TcxSchedulerViewNavigation }

constructor TcxSchedulerViewNavigation.Create(
  AView: TcxSchedulerCustomView);
begin
  FView := AView;
end;

procedure TcxSchedulerViewNavigation.CheckSelection;
begin
  with Scheduler do
    Self.ValidateSelection(FSelStart, FSelFinish, FSelResource);
end;

procedure TcxSchedulerViewNavigation.ReplaceSelParams(
  const ASelStart, ASelFinish: TDateTime);
begin
  ReplaceSelParams(ASelStart, ASelFinish, GetResourceItem);
end;

procedure TcxSchedulerViewNavigation.ReplaceSelParams(
  const ASelStart, ASelFinish: TDateTime; AResource: TcxSchedulerStorageResourceItem);
begin
  Scheduler.ReplaceSelParams(ASelStart, ASelFinish, AResource);
end;

procedure TcxSchedulerViewNavigation.SetSelAnchor(
  const Anchor: TDateTime; AShift: TShiftState);
begin
  SetSelAnchor(Anchor, AShift, SelResource);
end;

procedure TcxSchedulerViewNavigation.SetSelAnchor(
  const Anchor: TDateTime; AShift: TShiftState;
  AResource: TcxSchedulerStorageResourceItem);
var
  APrevSelResource: TObject;
  APrevSelStart, APrevSelFinish: TDateTime;

  procedure StoreSelection;
  begin
    with Scheduler do
    begin
      APrevSelResource := SelResource;
      APrevSelStart := SelStart;
      APrevSelFinish := SelFinish;
    end;
  end;

  function NeedUpdateOnMouseAction: Boolean;
  begin
    with Scheduler do
      Result := (ssLeft in AShift) and ((SelResource <> APrevSelResource) or
        (SelStart <> APrevSelStart) or (SelFinish <> APrevSelFinish));
  end;

begin
  StoreSelection;
  if not (ssShift in AShift) or (AResource <> SelResource) then
    Scheduler.ReplaceSelParams(Anchor, Anchor, AResource)
  else
    Scheduler.ReplaceSelParams(Scheduler.FSelStart, Anchor, AResource);
  if NeedUpdateOnMouseAction then
    View.LayoutChanged;
end;

procedure TcxSchedulerViewNavigation.ValidateSelection(var ASelStart,
  ASelFinish: TDateTime; var AResource: TcxSchedulerStorageResourceItem);
begin
end;

procedure TcxSchedulerViewNavigation.DoKeyDown(
  var AKey: Word; AShift: TShiftState);
begin
  Scheduler.BeginUpdate;
  try
    FCurrentAnchor := SelAnchor;
    FCurrentResource := SelResource;
    FShift := AShift;
    KeyDown(AKey, AShift);
    Scheduler.LayoutChanged;
  finally
    Scheduler.EndUpdate;
  end;
end;

function TcxSchedulerViewNavigation.IsKeyNavigation(
  var AKey: Word; AShift: TShiftState): Boolean;
begin
  Result := (AKey = VK_UP) or (AKey = VK_DOWN) or (AKey = VK_Next) or
    (AKey = VK_Prior) or (AKey = VK_Left) or (AKey = VK_Right) or
      (AKey = VK_Home) or (AKey = VK_End);
end;

function TcxSchedulerViewNavigation.IsSingleLine: Boolean;
begin
  Result := TimeOf(Abs(Scheduler.FSelStart -
    Scheduler.FSelFinish)) <= View.GetTimeIncrement; 
end;

function TcxSchedulerViewNavigation.GetResourceItem: TcxSchedulerStorageResourceItem;
begin
  Result := nil;
end;

procedure TcxSchedulerViewNavigation.KeyDown(var AKey: Word; AShift: TShiftState);
begin
end;

procedure TcxSchedulerViewNavigation.ReplaceDate(
  ADate: TDateTime; AResource: TcxSchedulerStorageResourceItem);
begin
  if AResource = nil then
    AResource := SelResource;
  with Scheduler do
  begin
    ADate := ADate - DateOf(FSelFinish);
    ReplaceSelParams(FSelStart + ADate, FSelFinish + ADate, AResource);
  end; 
end;

function TcxSchedulerViewNavigation.GetScheduler: TcxCustomScheduler;
begin
  Result := View.Scheduler;
end;

function TcxSchedulerViewNavigation.GetSelAnchor: TDateTime;
begin
  Result := Scheduler.FSelFinish
end;

function TcxSchedulerViewNavigation.GetSelRealStart: TDateTime;
begin
  Result := Scheduler.FSelStart;
end;

function TcxSchedulerViewNavigation.GetSelFinish: TDateTime;
begin
  Result := Max(Scheduler.FSelFinish, Scheduler.FSelStart);
end;

function TcxSchedulerViewNavigation.GetSelResource: TcxSchedulerStorageResourceItem;
begin
  Result := Scheduler.SelResource;
  end;

function TcxSchedulerViewNavigation.GetSelStart: TDateTime;
begin
  Result := Min(Scheduler.FSelFinish, Scheduler.FSelStart);
end;

function TcxSchedulerViewNavigation.GetTimeIncrement: TDateTime;
begin
  Result := View.GetTimeIncrement;
end;

{ TcxSchedulerViewController }

constructor TcxSchedulerViewController.Create(AOwner: TcxSchedulerSubControl);
begin
  inherited Create(AOwner);
  FNavigation := CreateNavigation;
end;

destructor TcxSchedulerViewController.Destroy;
begin
  FNavigation.Free;
  inherited Destroy;
end;

function TcxSchedulerViewController.CanCreateEventUsingDialog: Boolean;
begin
  with Scheduler.EventOperations do
    Result := Scheduler.StorageActive and CanShowEventDialog and Creating and
      DialogEditing and not GetResourceReadOnly;
end;

function TcxSchedulerViewController.CanCreateEventUsingInplaceEdit: Boolean;
begin
  with Scheduler.EventOperations do
    Result := Scheduler.StorageActive and Creating and InplaceEditing and
      not GetResourceReadOnly and IsCaptionAvailable and (Scheduler.SelectedEventCount = 0);
end;

function TcxSchedulerViewController.CanEditEvent(
  AEvent: TcxSchedulerControlEvent; AInplace: Boolean): Boolean;
begin
  with Scheduler.EventOperations do
  begin
    if AInplace then
      Result := InplaceEditing and IsCaptionAvailable
    else
      Result := DialogEditing and DialogShowing;
  end;
  Result := Result and (AEvent <> nil);
  if AInplace and Result then
    Result :=  not AEvent.ReadOnly;
end;

function TcxSchedulerViewController.CanShowEventDialog: Boolean;
begin
  Result := Scheduler.EventOperations.DialogShowing and
    Assigned(cxEventEditorClass);
end;

procedure TcxSchedulerViewController.DeleteSelectedEvents;
begin
  Scheduler.InternalDeleteSelectedEvents(False, True);
end;

function TcxSchedulerViewController.IsEventEditing(
  AEvent: TcxSchedulerControlEvent; AResource: TcxSchedulerStorageResourceItem): Boolean;
begin
  Result := IsEditing and (EditController.Event = AEvent) and
    (EditController.FEditResource = AResource);
end;

procedure TcxSchedulerViewController.SelectSingleEvent(
  AEvent: TcxSchedulerControlEvent; ADate: TDateTime; AMakeVisible: Boolean = True);
begin
  if AMakeVisible then View.MakeEventVisible(AEvent, ADate, nil);
  Scheduler.EventList.Selection.Add(AEvent, []);
end;

procedure TcxSchedulerViewController.BeforeMouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  StopEditShowingTimer;
  Scheduler.HintController.Hide;
  if Button <> mbLeft then Exit;
  FDragKind := HitTest.GetDragKind;
  if DragKind <> edkNone then
  begin
    CloseInplaceEdit;
    FDragEvent         := HitTest.Event;
    FStartDragHitTime  := HitTest.Time;
    FStartDragFlags    := HitTest.Flags;
    FStartDragResource := HitTest.Resource;
  end;
end;

procedure TcxSchedulerViewController.CancelScroll;
begin
end;

function TcxSchedulerViewController.CanDrag(X, Y: Integer): Boolean;
begin
  Result := (DragKind in [edkEventDragRect, edkMoveEvent]);
  if Result then
  begin
    if Scheduler.EventList.Selection.IsSelected(DragEvent) then
      Result := Scheduler.DoBeforeDragEvent(DragEvent, X, Y)
    else
    begin
      Result := False;
      SendMessage(Scheduler.Handle, WM_CANCELMODE, 0, 0);
    end;
  end;
end;

procedure TcxSchedulerViewController.CheckOpenInplaceEditorOnMouseUp(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  AEvent: TcxSchedulerControlEvent;
begin
  if FLockShowEditorOnMouseClick then Exit;
  if (HitTest.HitAtEvent and (HitTest.Event = FBeforeFocusedEvent)) and (Button = mbLeft) and
  ([ssShift, ssCtrl] * Shift = []) and not (FDragKind in [edkResizeStart, edkResizeEnd]) then
  begin
    AEvent := HitTest.Event;
    if cxRectPtIn(View.GetEditRectForEvent(AEvent, DateOf(HitTest.Time),
      HitTest.Resource), X, Y) and CanEditEvent(AEvent, True) then
    begin
      EditController.Init(HitTest.Time, HitTest.Resource);
      StartEditShowingTimer(AEvent);
    end;
  end;
  FLockShowEditorOnMouseClick := False;
  FBeforeFocusedEvent := nil;
end;

procedure TcxSchedulerViewController.CheckScrolling(
  const APos: TPoint);
begin
end;

procedure TcxSchedulerViewController.CloseInplaceEdit;
begin
  if EditController.IsEditing then
  begin
    EditController.CloseEdit(True);
    HitTest.Recalculate;
  end;
end;

function TcxSchedulerViewController.CreateResizeEventHelper: TcxEventSizingHelper;
begin
  Result := TcxEventSizingHelper.Create(Scheduler);
end;

function TcxSchedulerViewController.CreateDragEventHelper: TcxDragEventHelper;
begin
  Result := TcxDragEventHelper.Create(Scheduler);
end;

function TcxSchedulerViewController.CreateNavigation: TcxSchedulerViewNavigation;
begin
  Result := TcxSchedulerViewNavigation.Create(View);
end;

procedure TcxSchedulerViewController.DoCancelMode;
begin
  inherited DoCancelMode;
//  HotTrackController.SetViewInfo(cxInvalidPoint, nil);
  FLockShowEditorOnMouseClick := False;
end;

procedure TcxSchedulerViewController.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  P: TPoint;
begin
  if Assigned(DragEventHelper) and Accept then
  begin
    Owner.MousePositionChanged(X, Y);
    P := cxPoint(X, Y);
    HitTest.HitPoint := P;
    DragEventHelper.DragOver(P, State, Accept);
    DragEventHelper.UpdateState;
  end;
end;

procedure TcxSchedulerViewController.EndDrag(Target: TObject; X, Y: Integer);
var
  Accepted: Boolean;
  APos: TPoint;
begin
  if Assigned(DragEventHelper) then
  try
    APos := Scheduler.ScreenToClient(GetMouseCursorPos);
    Owner.MousePositionChanged(APos.X, APos.Y);
    HitTest.HitPoint := APos;
    Accepted := not Scheduler.IsDragCanceled;
    if Accepted then
      Scheduler.DoAfterDragEvent(Target, APos.X, APos.Y, Accepted);
    FDragEventHelper.EndDrag(Accepted);
  finally  
    FreeAndNil(FDragEventHelper);
  end;
end;

function TcxSchedulerViewController.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  Result := TcxSchedulerDragAndDropObject;
end;

function TcxSchedulerViewController.GetResourceReadOnly: Boolean;
begin
  with Scheduler do
    Result :=  not StorageValid or
      ((SelResource <> nil) and SelResource.ReadOnly) or
      ((Storage.ResourceCount > 0) and ((SelResource = nil) and not OptionsView.ShowEventsWithoutResource));
end;

function TcxSchedulerViewController.IsCaptionAvailable: Boolean;
begin
  Result := Scheduler.StorageValid and Scheduler.Storage.IsCaptionAvailable;
end;

function TcxSchedulerViewController.IsDragOperation: Boolean;
begin
  Result := Scheduler.Dragging or (Scheduler.DragAndDropState <> ddsNone);
end;

procedure TcxSchedulerViewController.KeyDown(
  var Key: Word; Shift: TShiftState);
var
  I, SelectedIndex: Integer;
begin
  if View.Active and not EditController.IsEditing then
  begin
    if Navigation.IsKeyNavigation(Key, Shift) then
    begin
      Scheduler.BeginUpdate;
      try
        UnselectEvents;
        Navigation.DoKeyDown(Key, Shift);
      finally
        Scheduler.EndUpdate;
      end;
    end;
    case Key of
      VK_ESCAPE:
        if Scheduler.CaptureController = Self then
          UnselectEvents;
      VK_DELETE:
        DeleteSelectedEvents;
      VK_TAB:
        with Scheduler do
        begin
          if EventList.Count <> 0 then
          begin
            SelectedIndex := -1;
            for I := 0 to EventList.Count - 1 do
              if EventList[I].Selected then
                SelectedIndex := I;
            Inc(SelectedIndex);
            while (SelectedIndex < EventList.Count) and
              not CurrentView.GetEventVisibility(EventList[SelectedIndex]) do Inc(SelectedIndex);
            if SelectedIndex < EventList.Count then
              SelectSingleEvent(EventList[SelectedIndex], NullDate)
            else
              UnselectEvents;
            CurrentView.Refresh;
          end;
        end;
    end;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TcxSchedulerViewController.KeyPress(var Key: Char);
var
  AEvent: TcxSchedulerControlEvent;
begin
  with Scheduler do
  begin
    if IsLocked or not StorageActive or GetResourceReadOnly then Exit;
    if Key in EditStartChars then
    begin
      if Key = #13 then
      begin
        if SelectedEventCount > 0 then
        begin
          AEvent := SelectedEvents[SelectedEventCount - 1];
          if CanShowEventDialog then
            EditEventUsingDialog(AEvent);
        end
        else
        begin
          if CanCreateEventUsingInplaceEdit then
            CreateEventUsingInplaceEdit
          else
            if CanCreateEventUsingDialog then
              CreateEventUsingDialog;
        end;
      end
      else
        if CanCreateEventUsingInplaceEdit then
          DoCreateEventUsingInplaceEdit(Key);
    end;
  end;
end;

procedure TcxSchedulerViewController.MouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  AEvent: TcxSchedulerControlEvent;
begin
  CloseInplaceEdit;
  if HitTest.HitAtEvent then
  begin
    AEvent := HitTest.Event;
    FBeforeFocusedEvent := AEvent;
    UpdateEventSelection(AEvent, Button, Shift);
    if Shift = [ssLeft, ssDouble] then
      ShowEventEditor(AEvent)
    else
      View.Refresh;
  end
  else
    if Button = mbLeft then
    begin
      UnselectEvents;
      if HitTest.HitAtTime then
      begin
        FStartSelAnchor := HitTest.Time;
        Navigation.SetSelAnchor(HitTest.Time, Shift, HitTest.Resource);
        if (Shift = [ssLeft, ssDouble]) and CanCreateEventUsingDialog then
          Scheduler.CreateEventUsingDialog;
      end;
    end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TcxSchedulerViewController.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Accepted: Boolean;
  P: TPoint;
begin
  inherited MouseMove(Shift, X, Y);
  if DragEventHelper <> nil then
  begin
    P := cxPoint(X, Y);
    Accepted := cxRectPtIn(View.Bounds, P);
    DragEventHelper.DragOver(P, dsDragMove, Accepted);
    DragEventHelper.UpdateState;
  end;
  if (ssLeft in Shift) and not EditController.IsEditing  then
  begin
    if (DragKind in [edkNone]) and HitTest.HitAtTime then
    begin
      if Navigation.SelResource = HitTest.Resource then
      begin
        if FStartSelAnchor <> NullDate then
          Scheduler.FSelStart := FStartSelAnchor;
        Navigation.SetSelAnchor(HitTest.Time, [ssShift] + Shift)
      end
      else
        Navigation.SetSelAnchor(Scheduler.FSelStart, [ssShift] + Shift);
    end;
  end;
end;

procedure TcxSchedulerViewController.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  CheckOpenInplaceEditorOnMouseUp(Button, Shift, X, Y);
  FStartSelAnchor := NullDate;
  FDragKind := edkNone;
end;

procedure TcxSchedulerViewController.RecreateNavigation;
begin
  FNavigation.Free;
  FNavigation := CreateNavigation;
  FNavigation.CheckSelection;
end;

procedure TcxSchedulerViewController.StartDrag(var DragObject: TDragObject);
begin
  FDragEventHelper := CreateDragEventHelper;
  if FDragEventHelper <> nil then
    FDragEventHelper.FDragObject := DragObject;
end;

function TcxSchedulerViewController.StartDragAndDrop(const P: TPoint): Boolean;
begin
  Result := (DragKind in [edkResizeStart, edkResizeEnd]) and
    Scheduler.DoBeforeSizingEvent(DragEvent, P.X, P.Y);
end;

procedure TcxSchedulerViewController.SyncEventSelection(
  AEvent: TcxSchedulerControlEvent);
begin
  if View.GetTimeIncrement = 1 then
    Scheduler.ReplaceSelParams(DateOf(AEvent.Start),
      DateOf(AEvent.Finish) - Byte(AEvent.AllDayEvent or
      (TimeOf(AEvent.Finish) = 0)) * View.GetTimeIncrement, AEvent.GetResourceItem)
  else
    Scheduler.ReplaceSelParams(AEvent.Start,
      AEvent.Finish - View.GetTimeIncrement, AEvent.GetResourceItem);
end;

procedure TcxSchedulerViewController.UnselectEvents;
begin
  Scheduler.UnselectEvents
end;

procedure TcxSchedulerViewController.UpdateEventSelection(
  AEvent: TcxSchedulerControlEvent; Button: TMouseButton; Shift: TShiftState);
begin
  if AEvent = nil then Exit;
  with Scheduler.EventList.Selection do
    if (Button = mbRight) and (Shift * [ssCtrl, ssShift] <> [])then
    begin
      if not IsSelected(AEvent) then
        Add(AEvent, [ssCtrl]);
    end
    else
      Add(AEvent, Shift);
  SyncEventSelection(AEvent);
end;

procedure TcxSchedulerViewController.EditShowingTimerHandler(Sender: TObject);
begin
  StopEditShowingTimer;
  EditController.Activate(FEditShowingTimerItem);
end;

function TcxSchedulerViewController.GetHitTest: TcxSchedulerViewHitTest;
begin
  Result := View.HitTest;
end;

function TcxSchedulerViewController.GetEditController: TcxSchedulerEditController;
begin
  Result := Scheduler.EditController;
end;

function TcxSchedulerViewController.GetIsEditing: Boolean;
begin
  Result := EditController.IsEditing;
end;

function TcxSchedulerViewController.GetScheduler: TcxCustomScheduler;
begin
  Result := Owner.Scheduler;
end;

function TcxSchedulerViewController.GetView: TcxSchedulerCustomView;
begin
  Result := TcxSchedulerCustomView(inherited Owner);
end;

procedure TcxSchedulerViewController.ShowEventEditor(
  AEvent: TcxSchedulerControlEvent);
begin
  StopEditShowingTimer;
  if CanShowEventDialog then
    Scheduler.EditEventUsingDialog(AEvent);
end;

procedure TcxSchedulerViewController.StartEditShowingTimer(
  AEvent: TcxSchedulerControlEvent);
begin
  StopEditShowingTimer;
  FEditShowingTimerItem := AEvent;
  FEditShowingTimer := TTimer.Create(nil);
  FEditShowingTimer.Interval := GetDblClickInterval;
  FEditShowingTimer.OnTimer := EditShowingTimerHandler;
end;

procedure TcxSchedulerViewController.StopEditShowingTimer;
begin
  FreeAndNil(FEditShowingTimer);
end;

{ TcxEventSizingHelper }

procedure TcxEventSizingHelper.BeginDrag;
begin
  inherited BeginDrag;
  if IsValidTime then
    UpdateEventBounds;
end;

procedure TcxEventSizingHelper.DragOver(const P: TPoint;
  State: TDragState; var Accepted: Boolean);
begin
  Accepted := IsValidTime;
  if HasChangedState and Accepted then
    UpdateEventBounds;
  Controller.CheckScrolling(P);
end;

procedure TcxEventSizingHelper.EndDrag(Accepted: Boolean);
begin
  if Accepted then
  begin
    SetSelection;
    Events.PostEvent(Event);
  end
  else
    Scheduler.FullRefresh;
end;

function TcxEventSizingHelper.GetDragCursor(Accepted: Boolean): TCursor;
//const
//  Cursors: array[Boolean] of TCursor = (crNoDrop, crSchedulerHorzResize);
begin
  Result := crSchedulerHorzResize;
//  Result := Cursors[Accepted];
end;

function TcxEventSizingHelper.IsValidTime: Boolean;
begin
  with HitTest do
    Result := HitAtTime and (not HitAtResource or (FStartResource = Resource));
end;

procedure TcxEventSizingHelper.CalcAllDayEvent;
begin
end;

function TcxEventSizingHelper.GetFinishTime: TDateTime;
begin
  Result := HitTest.Time;
end;

function TcxEventSizingHelper.GetStartTime: TDateTime;
begin
  Result := HitTest.Time;
end;

procedure TcxEventSizingHelper.UpdateEventBounds;
var
  AValue: TDateTime;
begin
  CalcAllDayEvent;
  case Controller.DragKind of
    edkResizeStart:
      begin
        AValue := GetStartTime;
        if AValue > Event.Finish - Ord(Event.AllDayEvent) then
          AValue := Event.Finish - Ord(Event.AllDayEvent);
        Event.Start := AValue;
      end;
    edkResizeEnd:
      begin
        AValue := GetFinishTime;
        if AValue < Event.Start then
          AValue := Event.Start;
        Event.Finish := AValue + Ord(Event.AllDayEvent);
      end;
  end;
  RefreshCurrentView;
end;

function TcxEventSizingHelper.GetEvent: TcxSchedulerControlEvent;
begin
  Result := TcxSchedulerViewController(Controller).DragEvent;
end;

function TcxEventSizingHelper.GetHitTest: TcxSchedulerViewHitTest;
begin
  Result := TcxSchedulerViewHitTest(inherited HitTest);
end;

{ TcxSchedulerDragAndDropObject }

constructor TcxSchedulerDragAndDropObject.Create(AControl: TcxControl);
begin
  inherited Create(AControl);
  FScheduler := AControl as TcxCustomScheduler;
end;

procedure TcxSchedulerDragAndDropObject.BeginDragAndDrop;
begin
  inherited BeginDragAndDrop;
  FSizingHelper := Controller.CreateResizeEventHelper;
end;

procedure TcxSchedulerDragAndDropObject.DragAndDrop(const P: TPoint;
  var Accepted: Boolean);
var
  AP: TPoint;
begin
  if Assigned(FSizingHelper) then
  begin
    AP := P;
    Controller.Owner.MousePositionChanged(AP.X, AP.Y);
    HitTest.HitPoint := AP;
    SizingHelper.DragOver(AP, dsDragMove, Accepted);
    SizingHelper.UpdateState;
  end;
  inherited DragAndDrop(P, Accepted);
end;

procedure TcxSchedulerDragAndDropObject.EndDragAndDrop(Accepted: Boolean);
var
  AP: TPoint;
begin
  if Assigned(SizingHelper) then
  try
    AP := CurMousePos;
    Controller.Owner.MousePositionChanged(AP.X, AP.Y);
    HitTest.HitPoint := AP;
    if Accepted then
      Scheduler.DoAfterSizingEvent(AP.X, AP.Y, Accepted);
    SizingHelper.EndDrag(Accepted);
  finally
    FreeAndNil(FSizingHelper);
  end;
  inherited EndDragAndDrop(Accepted);
end;

function TcxSchedulerDragAndDropObject.GetController: TcxSchedulerViewController;
begin
  Result := FScheduler.CurrentView.Controller;
end;

function TcxSchedulerDragAndDropObject.GetDragAndDropCursor(
  Accepted: Boolean): TCursor;
begin
  if Assigned(FSizingHelper) then
    Result := SizingHelper.GetDragCursor(Accepted)
  else
    Result := inherited GetDragAndDropCursor(Accepted);
end;

function TcxSchedulerDragAndDropObject.GetHitTest: TcxSchedulerViewHitTest;
begin
  Result := FScheduler.CurrentView.HitTest;
end;

{ TcxSchedulerHintController }

constructor TcxSchedulerHintController.Create(AOwner: TcxCustomScheduler);
begin
  FOwner := AOwner;
  FTimer := TTimer.Create(nil);
  FTimer.Enabled := False;
  FTimer.OnTimer := TimerHandler;
  FHintWindow := HintWindowClass.Create(nil);
end;

destructor TcxSchedulerHintController.Destroy;
begin
  Hide;
  FreeAndNil(FTimer);
  FreeAndNil(FHintWindow);
  inherited Destroy;
end;

procedure TcxSchedulerHintController.Activate(const AHintRect: TRect;
  const AHintText: string; AImmediateHint: Boolean = False);
begin
  Hide;
  FHintText := AHintText;
  FHintRect := AHintRect;
  FAutoHide := not AImmediateHint;
  if AImmediateHint then
    ShowHint
  else
    StartShowHintTimer;
end;

function TcxSchedulerHintController.CalcHintRect(AMaxWidth: Integer;
  const AHintText: string; AFlags: Integer): TRect;
begin
  CheckHintClass;
  FHintFlags := AFlags;
  Result := FHintWindow.CalcHintRect(AMaxWidth, AHintText, nil);
end;

procedure TcxSchedulerHintController.Hide;
begin
  HideHint;
end;

procedure TcxSchedulerHintController.Reset;
begin
  Hide;
end;

procedure TcxSchedulerHintController.CheckHintClass;
begin
  if FHintWindow.ClassType <> HintWindowClass then
  begin
    FHintWindow.Free;
    FHintWindow := HintWindowClass.Create(nil);
  end;
end;

procedure TcxSchedulerHintController.HideHint;
begin
  StopTimer;
  FHintWindow.Hide;
  ShowWindow(FHintWindow.Handle, SW_HIDE); //MUST USE ShowWindow - WIN32 BUG
end;

procedure TcxSchedulerHintController.ShowHint;
begin
  HideHint;
  if not Scheduler.OptionsView.ShowHints then Exit;
  CheckHintClass;
  FHintWindow.Color := clInfoBk;
  with GetMouseCursorPos do
  begin
    if FAutoHide then
    begin
      FHintRect := cxRectOffset(FHintRect, X, Y);
      if FHintFlags and cxAlignRight = cxAlignRight then
        FHintRect := cxRectSetRight(FHintRect, X);
      if FHintFlags and cxAlignBottom = cxAlignBottom then
        FHintRect := cxRectSetTop(FHintRect, Y + cxGetCursorSize.cy);
    end;
  end;
  FHintWindow.ActivateHint(FHintRect, FHintText);
  if FAutoHide then
    StartHideHintTimer;
end;

procedure TcxSchedulerHintController.StartHideHintTimer;
begin
  FTimer.Tag := 0;
  FTimer.Interval := cxscWaitForHideHint;
  FTimer.Enabled := True;
end;

procedure TcxSchedulerHintController.StartShowHintTimer;
begin
  FTimer.Tag := 1;
  FTimer.Interval := cxscWaitForShowHint;
  FTimer.Enabled := True;
end;

procedure TcxSchedulerHintController.StopTimer;
begin
  FTimer.Enabled := False;
end;

procedure TcxSchedulerHintController.TimerHandler(Sender: TObject);
begin
  if FTimer.Tag = 0 then
    HideHint
  else
    ShowHint;
end;

{ TcxSchedulerEventHitTestController }

constructor TcxSchedulerEventHitTestController.Create(
  AOwner: TcxCustomScheduler);
begin
  FOwner := AOwner;
end;

procedure TcxSchedulerEventHitTestController.MouseMove(
  X, Y: Integer; AShift: TShiftState);
var
  R: TRect;
  AHintText: string;
begin
  if Scheduler.IsDesigning then Exit;
  if (ssLeft in AShift) or not HitTest.HitAtEvent then
  begin
    HintController.HideHint;
    if not HitTest.HitAtEvent then
      FPrevHintEvent := nil;
  end;
  if HitTest.HitAtEvent and (FPrevHintEvent <> HitTest.Event) then
  begin
    if HitTest.NeedShowHint then
    begin
      FPrevHintEvent := HitTest.Event;
      AHintText := Scheduler.GetEventHintText(FPrevHintEvent);
      R := HintController.CalcHintRect(Max(cxscMinHintWindth,
        cxRectWidth(HitTest.FEventBounds)), AHintText, cxAlignBottom);
      HintController.Activate(R, AHintText);
    end;
    if Scheduler.OptionsView.HotTrack then
      Scheduler.CurrentView.InvalidateRect(HitTest.FEventBounds);
  end;
end;

function TcxSchedulerEventHitTestController.GetHintController: TcxSchedulerHintController;
begin
  Result := Scheduler.HintController;
end;

function TcxSchedulerEventHitTestController.GetHitTest: TcxSchedulerViewHitTest;
begin
  Result := Scheduler.CurrentView.HitTest;
end;

{ TcxSchedulerCustomView }

constructor TcxSchedulerCustomView.Create(AOwner: TcxCustomScheduler);
begin
  inherited Create(AOwner);
  FVisible := False; 
  FCanShow := True;
end;

procedure TcxSchedulerCustomView.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerCustomView then
    with TcxSchedulerCustomView(Source) do
    begin
      Self.CanShow := CanShow;
      Self.Active := Active;
    end;
  inherited Assign(Source);
end;

function TcxSchedulerCustomView.CreateController: TcxSchedulerSubControlController;
begin
  Result := TcxSchedulerViewController.Create(Self); 
end;

function TcxSchedulerCustomView.CreateHitTest: TcxSchedulerSubControlHitTest;
begin
  Result := TcxSchedulerViewHitTest.Create(Self);
end;

procedure TcxSchedulerCustomView.DateChanged;
begin
  Refresh;
end;

procedure TcxSchedulerCustomView.DoLayoutChanged;
begin
  TcxSchedulerCustomViewViewInfo(ViewInfo).FSelectedDays := Scheduler.SelectedDays;
  TcxSchedulerCustomViewViewInfo(ViewInfo).FEvents := Scheduler.EventList;
  inherited DoLayoutChanged;
  Scheduler.UpdateScrollBars;
end;

function TcxSchedulerCustomView.DoShowPopupMenu(X, Y: Integer): Boolean;
begin
  Result := False;
end;

function TcxSchedulerCustomView.EventContentSelected(
  AEvent: TcxSchedulerControlEvent): Boolean;
begin
  Result := True; 
end;

function TcxSchedulerCustomView.GetClientRect: TRect;
begin
  Result := inherited GetClientRect;
  if Scheduler.HScrollBarVisible then
    Dec(Result.Bottom, Scheduler.HScrollBar.Height);
  if Scheduler.VScrollBarVisible then
    Dec(Result.Right, Scheduler.VScrollBar.Width);
end;

function TcxSchedulerCustomView.GetDateOffset: Integer;
begin
  Result := 1 - Ord(OptionsView.ActualStartOfWeek);
end;

function TcxSchedulerCustomView.GetGroupingKind: TcxSchedulerGroupingKind;
begin
  Result := gkNone;
end;

function TcxSchedulerCustomView.GetHScrollBarBounds: TRect;
begin
  Result := ClientRect;
  Result.Top := Result.Bottom;
  Result.Bottom := Result.Top + Scheduler.HScrollBar.Height;
  OffsetRect(Result, Bounds.Left, Bounds.Top);
end;

function TcxSchedulerCustomView.GetEditRectForEvent(
  AEvent: TcxSchedulerControlEvent; const ADate: TDateTime;
  AResource: TcxSchedulerStorageResourceItem): TRect; 
begin
  Result := cxNullRect;
end;

function TcxSchedulerCustomView.GetEditStyle(
  AEvent: TcxSchedulerControlEvent): TcxCustomEditStyle;
begin
  Result := Scheduler.EditStyle;
end;

function TcxSchedulerCustomView.GetEditProperties(
  AEvent: TcxSchedulerControlEvent): TcxCustomEditProperties;
begin
  Scheduler.DoGetEventEditProperties(AEvent, Result);
end;

function TcxSchedulerCustomView.GetEventVisibility(
  AEvent: TcxSchedulerControlEvent): Boolean;
begin
  Result := False; 
end;

function TcxSchedulerCustomView.GetFirstVisibleDate: TDateTime;
begin
  if SelectedDays.Count = 0 then
    Result := Date
  else
    Result := Integer(SelectedDays.First)
end;

function TcxSchedulerCustomView.GetLastVisibleDate: TDateTime;
begin
  if SelectedDays.Count = 0 then
    Result := Date
  else
    Result := Integer(SelectedDays.Last)
end;

function TcxSchedulerCustomView.GetSizeGripBounds: TRect;
begin
  with Result do
  begin
    Left := Scheduler.VScrollBar.Left;
    Right := Left + Scheduler.VScrollBar.Width;
    Top := Scheduler.HScrollBar.Top;
    Bottom := Top + Scheduler.HScrollBar.Height;
  end;
  OffsetRect(Result, Bounds.Left, Bounds.Top);
end;

function TcxSchedulerCustomView.GetTimeIncrement: TDateTime;
begin
  Result := 1;
end;

function TcxSchedulerCustomView.GetVScrollBarBounds: TRect;
begin
  Result := ClientRect;
  Result.Left := Result.Right;
  Result.Right := Result.Left + Scheduler.VScrollBar.Width;
  OffsetRect(Result, Bounds.Left, Bounds.Top);
end;

function TcxSchedulerCustomView.GetVisibleDaysRange: Integer;
begin
  Result := 31;
end;

procedure TcxSchedulerCustomView.InitEventBySelectedPeriod(
  AEvent: TcxSchedulerEvent; AllDay: Boolean; ARecurrence: Boolean;
  AInplaceEditing: Boolean);
var
  AIsAllDaySelection: Boolean;
begin
  AIsAllDaySelection := IsAllDaySelection;
  AEvent.Start := Scheduler.SelStart;
  AEvent.AllDayEvent := AllDay or AIsAllDaySelection;
  if AllDay and not AIsAllDaySelection then
    AEvent.Finish := DateOf(Scheduler.SelFinish) + 1
  else
    AEvent.Finish := Scheduler.SelFinish;
end;

function TcxSchedulerCustomView.IsAllDaySelection: Boolean;
var
  AStart, AFinish, H, M, S, MS: Word;
begin
  if DateOf(Scheduler.SelFinish - Scheduler.SelStart) >= 1 then
  begin
    DecodeTime(Scheduler.SelStart, H, M, S, MS);
    AStart := H * 60 + M;
    DecodeTime(Scheduler.SelFinish, H, M, S, MS);
    AFinish := H * 60 + M;
    Result := (AStart = 0) and (AFinish = 0);
  end
  else
    Result := False;
end;

function TcxSchedulerCustomView.IsDayView: Boolean;
begin
  Result := False;
end;

function TcxSchedulerCustomView.IsShowResources: Boolean;
begin
  Result := Scheduler.HasResources;
end;

function TcxSchedulerCustomView.IsWorkTime(
  AResourceItem: TcxSchedulerStorageResourceItem; 
  const ADateTime: TDateTime): Boolean;
begin
  Result := Scheduler.DoIsWorkTime(AResourceItem, ADateTime);
end;

procedure TcxSchedulerCustomView.MakeEventVisible(
  AEvent: TcxSchedulerControlEvent; const ADate: TDateTime;
  AResource: TcxSchedulerStorageResourceItem);
begin
end;

procedure TcxSchedulerCustomView.PeriodChanged;
begin
  Scheduler.ValidateSelection(SelectedDays);
end;

procedure TcxSchedulerCustomView.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
  if AScrollBarKind = sbHorizontal then
    Scheduler.HScrollBar.Position := AScrollPos
  else
    Scheduler.VScrollBar.Position := AScrollPos;
end;

procedure TcxSchedulerCustomView.ScrollSelectedDays(AScrollDelta: Integer);
begin
  Scheduler.DateNavigator.ScrollSelection(AScrollDelta);
end;

procedure TcxSchedulerCustomView.ScrollSelectedDays(AForward: Boolean;
  ANeedDate: TDateTime; AIsByPage: Boolean);
begin
  Scheduler.DateNavigator.ScrollSelection(AForward, ANeedDate, AIsByPage);
end;

procedure TcxSchedulerCustomView.ScrollVisibleDays(
  AScrollUp: Boolean);
begin
end;

procedure TcxSchedulerCustomView.TimeChanged;
begin
end;

procedure TcxSchedulerCustomView.VisibleChanged;
begin
  if Visible and not CanShow then
    Visible := False
  else
    Scheduler.ViewVisibleChanged(Self)
end;

procedure TcxSchedulerCustomView.HideHintOnScroll;
begin
  Scheduler.HintController.HideHint;
end;

procedure TcxSchedulerCustomView.ShowHintOnScroll(const ADate: TDateTime);
var
  R: TRect;
  AHintText: string;
begin
  AHintText := DateTimeToStr(ADate);
  R := Scheduler.HintController.CalcHintRect(cxscMinHintWindth, AHintText, cxAlignRight);
  with Scheduler.ClientToScreen(Point(Scheduler.VScrollBar.Left, 0)) do
  begin
    R := cxRectSetRight(R, X - 5);
    R := cxRectSetTop(R, GetMouseCursorPos.Y - cxGetCursorSize.cy div 2 - 1);
  end;
  Scheduler.HintController.Activate(R, AHintText, True);
end;

function TcxSchedulerCustomView.GetActive: Boolean;
begin
  Result := Visible;
end;

function TcxSchedulerCustomView.GetCanShow: Boolean;
begin
  Result := FCanShow;
  Scheduler.DoCanShowView(Self, Result);
end;

function TcxSchedulerCustomView.GetController: TcxSchedulerViewController;
begin
  Result := TcxSchedulerViewController(inherited Controller);
end;

function TcxSchedulerCustomView.GetDragCloneEventList: TcxSchedulerFilteredEventList;
begin
  if Assigned(Controller.DragEventHelper) then
    Result := Scheduler.EventList.Clones
  else
    Result := nil;
end;

function TcxSchedulerCustomView.GetEventList: TcxSchedulerCachedEventList;
begin
  Result := Scheduler.EventList;
end;

function TcxSchedulerCustomView.GetHitTest: TcxSchedulerViewHitTest;
begin
  Result := TcxSchedulerViewHitTest(inherited HitTest);
end;

function TcxSchedulerCustomView.GetSelectedDays: TcxSchedulerDateList;
begin
  Result := Scheduler.SelectedDays
end;

function TcxSchedulerCustomView.GetOptionsView: TcxSchedulerOptionsView;
begin
  Result := Scheduler.OptionsView;
end;

function TcxSchedulerCustomView.GetResources: TcxSchedulerStorageResourceItems;
begin
  if Scheduler.StorageValid then
    Result := Scheduler.Storage.Resources.ResourceItems
  else
    Result := nil;
end;

function TcxSchedulerCustomView.GetWorkDays: TDays;
begin
  Result := OptionsView.WorkDays;
end;

function TcxSchedulerCustomView.GetWorkFinish: TDateTime;
begin
  Result := OptionsView.WorkFinish;
end;

function TcxSchedulerCustomView.GetWorkStart: TDateTime;
begin
  Result := OptionsView.WorkStart;
end;

procedure TcxSchedulerCustomView.SetActive(AValue: Boolean);
begin
  Visible := FCanShow and AValue;
end;

procedure TcxSchedulerCustomView.SetCanShow(AValue: Boolean);
begin
  if FCanShow <> AValue then
  begin
    FCanShow := AValue;
    if not AValue then
      Visible := False
    else
    begin
      if not Scheduler.CurrentView.Visible then
        Visible := True;
      Changed;
    end;
  end;
end;

{ TcxSchedulerCustomViewViewInfo }

function TcxSchedulerCustomViewViewInfo.DoGetEventDisplayText(
  AEvent: TcxSchedulerControlEvent): string;
begin
  Owner.Scheduler.DoGetEventDisplayText(AEvent, Result);
end;

function TcxSchedulerCustomViewViewInfo.GetSchedulerEventsList: TcxSchedulerCachedEventList;
begin
  Result := Owner.Scheduler.EventList;
end;

procedure TcxSchedulerCustomViewViewInfo.SetEventsVisibility(
  AShowSources, AShowClones: Boolean; AForceRepaint: Boolean = False);
begin
end;

{ TcxSchedulerCustomDataNavigator }

constructor TcxSchedulerCustomDateNavigator.Create(
  AOwner: TcxCustomScheduler);
begin
  inherited Create(AOwner);
  FSaveSelectionList := TcxSchedulerDateList.Create;
end;

destructor TcxSchedulerCustomDateNavigator.Destroy;
begin
  FSaveSelectionList.Free;
  inherited Destroy;
end;

procedure TcxSchedulerCustomDateNavigator.BeginUpdate;
begin
  if FLockCount = 0 then
    SaveState;
  Inc(FLockCount);
end;

procedure TcxSchedulerCustomDateNavigator.CancelUpdates;
begin
  FLockCount := 0;
end;

procedure TcxSchedulerCustomDateNavigator.EndUpdate;
begin
  Dec(FLockCount);
  if FLockCount <= 0 then
  begin
    FLockCount := 0;
    CheckChanges;
  end;
end;                              

procedure TcxSchedulerCustomDateNavigator.CheckChanges;
var
  I: Integer;
  ACallEvent: Boolean;
begin
  if (FSaveRealFirstDate <> GetRealFirstDate) or (FSaveRealLastDate <> GetRealLastDate) then
    DoPeriodChangedEvent;
  GetSelection.Changed := False;
  ACallEvent := GetSelection.Count <> FSaveSelectionList.Count;
  if not ACallEvent then
    for I := 0 to FSaveSelectionList.Count - 1 do
      if FSaveSelectionList[I] <> GetSelection[I] then
      begin
        ACallEvent := True;
        break;
      end;
  if ACallEvent then
    DoSelectionChangedEvent;
  SaveState;
end;

function TcxSchedulerCustomDateNavigator.GetMonthSize: TSize;
begin
  Result := cxNullSize;
end;

function TcxSchedulerCustomDateNavigator.GetSelection: TcxSchedulerDateList;
begin
  Result := Scheduler.SelectedDays;
end;

procedure TcxSchedulerCustomDateNavigator.PeriodChanged;
begin
  Scheduler.DateNavigatorSelectionChanged;
end;

procedure TcxSchedulerCustomDateNavigator.SaveSize;
begin
  FSavedSize := cxSize(Width, Height);
end;

procedure TcxSchedulerCustomDateNavigator.SaveState;
begin
  FSaveSelectionList.Assign(GetSelection);
  FSaveRealFirstDate := GetRealFirstDate;
  FSaveRealLastDate := GetRealLastDate;
end;

procedure TcxSchedulerCustomDateNavigator.ScrollSelection(AForward: Boolean;
  ANeedDate: TDateTime; AIsByPage: Boolean);
begin
  BeginUpdate;
  try
    DoScrollSelection(AForward, ANeedDate, AIsByPage);
  finally
    EndUpdate;
  end;
end;

procedure TcxSchedulerCustomDateNavigator.ScrollSelection(AScrollDelta: Integer);
begin
  BeginUpdate;
  try
    DoScrollSelection(AScrollDelta);
  finally
    EndUpdate;
  end;
end;

function TcxSchedulerCustomDateNavigator.GetEventDays: TcxSchedulerDateList;
begin
  Result := Scheduler.EventDays;
end;

{ TcxSchedulerStyles }

constructor TcxSchedulerStyles.Create(AOwner: TPersistent);
begin
  if AOwner is TcxCustomScheduler then
    FScheduler := TcxCustomScheduler(AOwner);
  inherited Create(AOwner);
end;

procedure TcxSchedulerStyles.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TcxSchedulerStyles then
  begin
    for I := 0 to cxcsMaxValue do
      SetValue(I, TcxSchedulerStyles(Source).GetValue(I))
  end;
  inherited Assign(Source);
end;

function TcxSchedulerStyles.GetBackgroundParams: TcxViewParams;
begin
  GetDefaultViewParams(cxcsBackground, nil, Result);
  CombineParamsWithStyle(Background, [], Result);
end;

function TcxSchedulerStyles.GetContentParams(const ADateTime: TDateTime;
  AResource: TcxSchedulerStorageResourceItem = nil): TcxViewParams;
begin
  Result := GetContentParams(
    ADateTime, Scheduler.DoIsWorkTime(AResource, ADateTime), AResource);
end;

function TcxSchedulerStyles.GetContentParams(const ADateTime: TDateTime;
  ALightColor: Boolean; AResource: TcxSchedulerStorageResourceItem = nil): TcxViewParams;
var
  AStyle: TcxStyle;
begin
  GetDefaultViewParams(cxcsContent, AResource, Result);
  CombineParamsWithStyle(Content, [], Result);
  if Assigned(FOnGetContentStyle) then
  begin
    AStyle := nil;
    FOnGetContentStyle(Scheduler, AResource, ADateTime, AStyle);
    if AStyle <> nil then
      CombineParamsWithStyle(AStyle, [], Result);
  end;
  Result.Color := PainterHelper.GetContentColor(Result.Color, ALightColor);
end;

function TcxSchedulerStyles.GetEventContentParams(
  AEvent: TcxSchedulerEvent): TcxViewParams;
var
  AStyle: TcxStyle;
begin
  GetDefaultViewParams(cxcsEvent, AEvent, Result);
  CombineParamsWithStyle(Content, [cxStyles.svColor], Result);
  CombineParamsWithStyle(Event, [], Result);
  if (AEvent <> nil) and EventContentSelected(TcxSchedulerControlEvent(AEvent)) then
    CombineParamsWithStyle(Selection, [], Result);
  if Assigned(OnGetEventStyle) then
  begin
    AStyle := nil;
    OnGetEventStyle(Scheduler, AEvent, AStyle);
    CombineParamsWithStyle(AStyle, [], Result);
  end;
end;

function TcxSchedulerStyles.IsEventStyleAssigned(
  AEvent: TcxSchedulerEvent): Boolean;
var
  AStyle: TcxStyle;
begin
  Result := (AEvent.LabelColor <> clDefault) or (Event <> nil);
  if not Result and Assigned(FOnGetEventStyle) then
  begin
    AStyle := nil;
    FOnGetEventStyle(Scheduler, AEvent, AStyle);
    Result := AStyle <> nil;
  end;
end;

function TcxSchedulerStyles.GetDayHeaderParams(
  const ADate: TDateTime): TcxViewParams;
var
  AStyle: TcxStyle;
begin
  //DELPHI8! check Trunc(ADate)
  GetDefaultViewParams(cxcsDayHeader, Pointer(Trunc(ADate)), Result);
  CombineParamsWithStyle(DayHeader, [], Result);
  if Assigned(FOnGetDayHeaderStyle) then
  begin
    AStyle := nil;
    FOnGetDayHeaderStyle(Scheduler, ADate, AStyle);
    CombineParamsWithStyle(AStyle, [], Result)
  end;
end;

function TcxSchedulerStyles.GetGroupSeparatorParams: TcxViewParams;
begin
  GetDefaultViewParams(cxcsGroupSeparator, nil, Result);
  CombineParamsWithStyle(GroupSeparator, [], Result);
end;

function TcxSchedulerStyles.GetResourceHeaderParams(
  AResource: TcxSchedulerStorageResourceItem): TcxViewParams;
var
  AStyle: TcxStyle;
begin
  GetDefaultViewParams(cxcsResourceHeader, AResource, Result);
  CombineParamsWithStyle(ResourceHeader, [], Result);
  if Assigned(FOnGetResourceHeaderStyle) then
  begin
    AStyle := nil;
    FOnGetResourceHeaderStyle(Scheduler, AResource, AStyle);
    CombineParamsWithStyle(AStyle, [], Result);
  end;
end;

function TcxSchedulerStyles.GetSplitterParams(
  AKind: TcxSchedulerSplitterKind): TcxViewParams;
var
  AIndex: Integer;
begin
  AIndex := cxcsHSplitter + Byte(AKind);
  GetDefaultViewParams(AIndex, nil, Result);
  CombineParamsWithStyle(GetValue(AIndex), [], Result);
end;

function TcxSchedulerStyles.GetSelectionParams: TcxViewParams;
begin
  GetDefaultViewParams(cxcsSelection, nil, Result);
  CombineParamsWithStyle(Selection, [], Result);
end;

procedure TcxSchedulerStyles.Changed(AIndex: Integer);
begin
  inherited Changed(AIndex);
  if GetOwner is TcxCustomScheduler then
  begin
    Scheduler.DateNavigator.CheckSizes;
    Scheduler.LayoutChanged;
  end;
end;

function TcxSchedulerStyles.EventContentSelected(
  AEvent: TcxSchedulerControlEvent): Boolean;
begin
  Result := AEvent.Selected and not (Scheduler.EditController.Event = AEvent) and
    Scheduler.CurrentView.EventContentSelected(AEvent);
end;

procedure TcxSchedulerStyles.GetDefaultViewParams(
  Index: Integer; AData: TObject; out AParams: TcxViewParams);
var
  AEvent: TcxSchedulerControlEvent;
  ASelected: Boolean;
begin
  AParams.Bitmap := nil;
  AParams.Font := Scheduler.Font;
  AParams.TextColor := AParams.Font.Color;
  AParams.Color := Scheduler.Color;
  case Index of
    cxcsDayHeader, cxcsResourceHeader:
      begin
        AParams.Color := Painter.DefaultHeaderColor;
        AParams.TextColor := Painter.DefaultHeaderTextColor;
      end;
    cxcsBackground:
      begin
        AParams.Color := Painter.DefaultSchedulerBackgroundColor;
        AParams.TextColor := Painter.DefaultSchedulerTextColor;
      end;
    cxcsContent:
      begin
        AParams.Color := Painter.DefaultSchedulerViewContentColor;
        if AData <> nil then
        begin
          AParams.Color := Resources[TcxSchedulerStorageResourceItem(AData).Index].Color;
          if AParams.Color = clDefault then
            AParams.Color := PainterHelper.GetResourceContentColor(
              TcxSchedulerStorageResourceItem(AData).Index);
        end;
        AParams.TextColor := Painter.DefaultSchedulerViewTextColor;
      end;
    cxcsSelection:
      begin
        AParams.Color := clHighLight;
        AParams.TextColor := clHighLightText;
      end;
    cxcsHSplitter, cxcsVSplitter, cxcsGroupSeparator:
        AParams.Color := Painter.DefaultSchedulerControlColor;
    cxcsEvent:
      if AData <> nil then 
      begin
        AEvent := TcxSchedulerControlEvent(AData);
        ASelected := EventContentSelected(AEvent);
        if (AEvent.LabelColor = clDefault) or ASelected then
        begin
          if ASelected then
          begin
            AParams.Color := GetSelectionParams.Color;
            AParams.TextColor := GetSelectionParams.TextColor;
          end
          else
            AParams.Color := EventContentColors[AEvent.AllDayEvent or (AEvent.Duration >= 1)];
        end
        else
          AParams.Color := AEvent.LabelColor;
      end;
  end;
end;

function TcxSchedulerStyles.GetDayHeaderStyle: TcxStyle;
begin
  Result := DayHeader;
end;

function TcxSchedulerStyles.GetEventParams(AEvent: TcxSchedulerEvent): TcxViewParams;
begin
  Result := GetEventContentParams(AEvent);
end;

function TcxSchedulerStyles.GetResourceHeaderStyle: TcxStyle;
begin
  Result := ResourceHeader;
end;

function TcxSchedulerStyles.GetPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := Scheduler.LookAndFeelPainter;
end;

function TcxSchedulerStyles.GetPainterHelperClass: TcxSchedulerPainterHelperClass;
begin
  Result := Scheduler.PainterHelper
end;

function TcxSchedulerStyles.GetResources: TcxSchedulerStorageResourceItems;
begin
  Result := Scheduler.CurrentView.Resources;
end;

{ TcxCustomScheduler }

constructor TcxCustomScheduler.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Color := clBtnFace;
  ParentFont := False;
  Font.Name := 'Tahoma';
  Keys := [kAll, kArrows, kChars, kTab];
  BeginUpdate;
  SetBounds(0, 0, cxDefaultSchedulerWidth, cxDefaultSchedulerHeight);
  FSubControls := TList.Create;
{$IFNDEF DEBUGPAINT}
  FBitmap := TBitmap.Create;
  FBitmap.PixelFormat := pf24Bit;
  FBitmapCanvas := TcxCanvas.Create(FBitmap.Canvas);
{$ENDIF}
  CreateSubClasses;
  FBackground := CreateBackground;
  FSubControlsCreated := True;
  BorderStyle := cxcbsDefault;
  EndUpdate;
  DragMode := dmAutomatic;
  cxFormatController.AddListener(Self);
end;

destructor TcxCustomScheduler.Destroy;
begin
  cxFormatController.RemoveListener(Self);
  FSubControlsCreated := False;
  Storage := nil;
  DestroySubClasses;
  while SubControlCount > 0 do
    SubControls[0].Free;
  FSubControls.Free;
{$IFNDEF DEBUGPAINT}
  FBitmapCanvas.Free;
  FBitmap.Free;
{$ENDIF}
  inherited Destroy;
end;

procedure TcxCustomScheduler.BeginUpdate;
begin
  Inc(FLockCount);
  Include(FControlFlags, cfLocked);
  LockUpdateChanged(True);
end;

procedure TcxCustomScheduler.CreateEventUsingDialog(AllDay: Boolean = False;
  ARecurrence: Boolean = False);
var
  AModified: Boolean;
  AEvent: TcxSchedulerControlEvent;
begin
  if not StorageActive then Exit;
  AEvent := TcxSchedulerControlEvent.Create(Storage);
  EditController.FFocused := True;
  try
    InitEventBySelection(AEvent, AllDay, ARecurrence, False);
    if DoBeforeEditing(AEvent, False) then
    begin
      if cxShowEventEditor(AEvent, LookAndFeel, ARecurrence, AModified, False,
        False, EventOperations.Recurrence, nil, ARecurrence, GetTimeBias) then
      DoAfterEditing(nil);
    end
  finally
    AEvent.Free;
    EditController.FFocused := False;
  end;
end;

procedure TcxCustomScheduler.CreateEventUsingInplaceEdit;
begin
  DoCreateEventUsingInplaceEdit;
end;

procedure TcxCustomScheduler.DeleteEvent(AEvent: TcxSchedulerControlEvent);
begin
  if not StorageActive or (AEvent = nil) or not EventOperations.Deleting or
    AEvent.ReadOnly then Exit;
  InternalDeleteEvent(AEvent, False);
end;

procedure TcxCustomScheduler.DeleteSelectedEvents(
  ACheckReadOnly: Boolean = True);
begin
  if StorageActive then
    InternalDeleteSelectedEvents(True, ACheckReadOnly);
end;

procedure TcxCustomScheduler.EditEventUsingDialog(
  AEvent: TcxSchedulerControlEvent; ACheckReadOnly: Boolean = True;
  AForcePatternEditing: Boolean = False);
var
  AReadOnly, AModified: Boolean;
begin
  if (AEvent = nil) or not StorageActive or (cxEventEditorClass = nil) or
    not DoBeforeEditing(AEvent, False) then Exit;
  AReadOnly := ACheckReadOnly and
    (not CurrentView.Controller.CanEditEvent(AEvent, False) or AEvent.ReadOnly);
  EditController.FFocused := True;
  try
    if cxShowEventEditor(AEvent, LookAndFeel, False, AModified, AReadOnly,
      EventOperations.Deleting, EventOperations.Recurrence,
      DoBeforeDeleting, AForcePatternEditing, GetTimeBias) and AModified then
        DoAfterEditing(AEvent);
  finally
    EditController.FFocused := False; 
  end;
end;

procedure TcxCustomScheduler.EditEventUsingInplaceEdit(
  AEvent: TcxSchedulerControlEvent);
begin
  if (AEvent = nil) or not StorageActive then Exit;
  if CanFocusEx then
  begin
    SetFocus;
    EditController.Activate(AEvent);
  end;
end;

procedure TcxCustomScheduler.DragDrop(
  Source: TObject; X, Y: Integer);
begin
  inherited DragDrop(Source, X, Y);
  CaptureController.DragDrop(Source, X, Y);
end;

procedure TcxCustomScheduler.EndUpdate;
begin
  LockUpdateChanged(False);
  Dec(FLockCount);
  if FLockCount = 0 then
  begin
    Exclude(FControlFlags, cfLocked);
    if cfInvalidLayout in FControlFlags then
    begin
      Exclude(FControlFlags, cfInvalidLayout);
      LayoutChanged;
    end;
  end;
end;

function TcxCustomScheduler.GoToDate(ADate: TDateTime;
  AViewMode: TcxSchedulerViewMode = vmDay): Boolean;
begin
  if ADate = NullDate then
    Result := False
  else
  begin
    FSelectedDays.Clear;
    FSelectedDays.Add(ADate);
    CurrentView.PeriodChanged;
    Result := True;
  end;
end;

procedure TcxCustomScheduler.FullRefresh;
begin
  Inc(FLockRefresh);
  try
    UpdateEventsCache(FLockRefresh <> 1); 
    LayoutChanged;
  finally
    Dec(FLockRefresh);
  end;
end;

procedure TcxCustomScheduler.LayoutChanged;
begin
  if IsLocked or IsLoading or IsDestroying or not HandleAllocated then
    Include(FControlFlags, cfInvalidLayout)
  else
  begin
    Exclude(FControlFlags, cfImageValid);
    if CurrentView.Visible and not CurrentView.CanShow then
      CurrentView.Visible := False;
    AlignSubControls;
    if not (cfViewValid in FControlFlags) then
      SynchronizeVisibleDays;
    DoLayoutChanged;
    Exclude(FControlFlags, cfInvalidLayout);
    UpdateScrollBars;
  end;
  if not FBoundsChanging and CanModified then
    Modified;
  Invalidate;
end;

procedure TcxCustomScheduler.MakeEventVisible(
  AEvent: TcxSchedulerControlEvent; const ADate: TDateTime = NullDate;
  AResource: TcxSchedulerStorageResourceItem = nil);
begin
  CurrentView.MakeEventVisible(AEvent, ADate, AResource);
end;

procedure TcxCustomScheduler.SelectEvent(
  AEvent: TcxSchedulerControlEvent; AShift: TShiftState = []);
begin
  EventList.Selection.Add(AEvent, AShift);
  if not IsLocked then
    CurrentView.Refresh;
end;

procedure TcxCustomScheduler.SelectTime(const ASelStart,
  ASelFinish: TDateTime; AResource: TcxSchedulerStorageResourceItem);
begin
  if DateTimeHelper.RoundTime(Abs(ASelStart - ASelFinish)) <= CurrentView.GetTimeIncrement then
    ReplaceSelParams(ASelStart, ASelStart, AResource)
  else
    ReplaceSelParams(ASelStart, (ASelFinish - CurrentView.GetTimeIncrement), AResource);
  LayoutChanged;
end;

procedure TcxCustomScheduler.UnselectEvents;
begin
  if EventList.Selection.Count = 0 then Exit;
  EventList.Selection.Clear;
  CurrentView.LayoutChanged;
end;

procedure TcxCustomScheduler.RestoreFromIniFile(const AStorageName: string;
  ARestoreResources: Boolean = True);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStorageName);
  try
    BeginUpdate;
    try
      AStorage.RestoreFromIni(Self);
      if ARestoreResources and HasResources then
        AStorage.RestoreFromIni(Storage.Resources);
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomScheduler.RestoreFromRegistry(const AStorageName: string;
  ARestoreResources: Boolean = True);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStorageName);
  try
    BeginUpdate;
    try
      AStorage.RestoreFromRegistry(Self);
      if ARestoreResources and HasResources then
        AStorage.RestoreFromRegistry(Storage.Resources);
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomScheduler.RestoreFromStream(AStream: TStream;
  ARestoreResources: Boolean = True);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStream);
  try
    BeginUpdate;
    try
      AStorage.RestoreFromStream(Self);
      if ARestoreResources and HasResources then
        AStorage.RestoreFromStream(Storage.Resources);
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomScheduler.StoreToIniFile(const AStorageName: string;
  AReCreate: Boolean = True; AStoreResources: Boolean = True);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStorageName);
  try
    BeginUpdate;
    try
      AStorage.ReCreate := ARecreate;
      AStorage.StoreToIni(Self);
      AStorage.ReCreate := False;
      if AStoreResources and HasResources then
        AStorage.StoreToIni(Storage.Resources);
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomScheduler.StoreToRegistry(const AStorageName: string;
  AReCreate: Boolean = True; AStoreResources: Boolean = True);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStorageName);
  try
    BeginUpdate;
    try
      AStorage.ReCreate := ARecreate;
      AStorage.StoreToRegistry(Self);
      AStorage.ReCreate := False;
      if AStoreResources and HasResources then
        AStorage.StoreToRegistry(Storage.Resources);
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomScheduler.StoreToStream(AStream: TStream;
  AStoreResources: Boolean = True);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStream);
  try
    BeginUpdate;
    try
      AStorage.StoreToStream(Self);
      AStorage.ReCreate := False;
      if AStoreResources and HasResources then
        AStorage.StoreToStream(Storage.Resources);
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomScheduler.AlignControls(AControl: TControl; var Rect: TRect);
begin
end;

procedure TcxCustomScheduler.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Splitters', ReadSplittersData, WriteSplittersData, True);
  Filer.DefineProperty('Selection', ReadSelectionData, WriteSelectionData,
    (FSelectedDays.Count > 1) or (SelectedDays[0] <> Date));
end;

procedure TcxCustomScheduler.GetChildren(
  Proc: TGetChildProc; Root: TComponent);
begin
  inherited GetChildren(Proc, Root);
  if ControlBox.Control <> nil then
    Proc(ControlBox.Control);
end;

procedure TcxCustomScheduler.Notification(
  AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
begin
  inherited Notification(AComponent, Operation);
  if not IsDestroying and FSubControlsCreated then
  begin
    if Operation = opRemove then
    begin
      if AComponent = ControlBox.Control then
        ControlBox.Control := nil;
      if AComponent = ContentPopupMenu.PopupMenu then
        ContentPopupMenu.PopupMenu := nil;
      if AComponent = EventPopupMenu.PopupMenu then
        EventPopupMenu.PopupMenu := nil;
    end;
    for I := 0 to SubControlCount - 1 do
      SubControls[I].Notification(AComponent, Operation);
  end;
end;

procedure TcxCustomScheduler.AlignSubControls(
  Sender: TcxSchedulerSubControl = nil);
begin
  if FAligningSubControls or IsLoading or not FSubControlsCreated then Exit;
  FAligningSubControls := True;
  try
    CheckSplittersVisibilityChanging;
    if (Sender = DateNavigator) or (Sender = ControlBox) then
      UpdateAlignByDateNavigatorOrControlBox(Sender = DateNavigator)
    else
      if Sender = CurrentView then
        UpdateAlignByView
      else
      begin
        if DateNavigator.Visible then
          UpdateAlignByDateNavigatorOrControlBox(True)
        else
          if ControlBox.Visible then
            UpdateAlignByDateNavigatorOrControlBox(False)
          else
            UpdateAlignByView;
      end;
    FullRefresh;
  finally
    FAligningSubControls := False;
  end;
end;

procedure TcxCustomScheduler.BoundsChanged;
begin
  FBoundsChanging := True;
  Include(FControlFlags, cfLocked);
  try
  {$IFNDEF DEBUGPAINT}
    if ((FBitmap.Width < Width) or ((FBitmap.Width - Width) > cxSizeDelta)) or
      ((FBitmap.Height < Height) or ((FBitmap.Height - Height) > cxSizeDelta)) then
    begin
      FBitmap.Width := (Width div cxSizeDelta + 1) * cxSizeDelta;
      FBitmap.Height := (Height div cxSizeDelta + 1) * cxSizeDelta;
    end;
  {$ENDIF}  
    if not (IsLoading or IsDestroying) and EditController.IsEditing then
      CurrentView.Controller.CloseInplaceEdit;
    inherited BoundsChanged;
    AlignSubControls;
    UpdateInvisibleSplitterBounds;
    FPrevBounds := ClientBounds;
  finally
    Exclude(FControlFlags, cfLocked);
    LayoutChanged;
    FBoundsChanging := False;
  end;
end;

function TcxCustomScheduler.CanShowEventDialog: Boolean;
begin
  Result := CurrentView.Controller.CanShowEventDialog;
end;

function TcxCustomScheduler.CanModified: Boolean;
begin
  Result := FCanModified;
end;

function TcxCustomScheduler.CreateBackground: TcxSchedulerSubControl;
begin
  Result := TcxSchedulerSubControl.Create(Self);
end;

function TcxCustomScheduler.CreateContentPopupMenu: TcxSchedulerContentPopupMenu;
begin
  Result := TcxSchedulerContentPopupMenu.Create(Self);
end;

function TcxCustomScheduler.CreateControlBox: TcxSchedulerControlBox;
begin
  Result := TcxSchedulerControlBox.Create(Self)
end;

function TcxCustomScheduler.CreateDateNavigator: TcxSchedulerCustomDateNavigator;
begin
  Result := nil;
end;

function TcxCustomScheduler.CreateDefaultView: TcxSchedulerCustomView;
begin
  Result := nil;
end;

function TcxCustomScheduler.CreateDefaultEditProperties: TcxCustomEditProperties;
begin
  Result := TcxMemoProperties.Create(Self);
end;

function TcxCustomScheduler.CreateEditController: TcxSchedulerEditController;
begin
  Result := TcxSchedulerEditController.Create(Self);
end;

function TcxCustomScheduler.CreateEventHitTestController: TcxSchedulerEventHitTestController;
begin
  Result := TcxSchedulerEventHitTestController.Create(Self);
end;

function TcxCustomScheduler.CreateEventList: TcxSchedulerCachedEventList;
begin
  Result := TcxSchedulerCachedEventList.Create;
  Result.Selection.OnEventSelectionChanged := DoEventSelectionChanged;
end;

function TcxCustomScheduler.CreateEventOperations: TcxSchedulerEventOperations;
begin
  Result := TcxSchedulerEventOperations.Create(Self);
end;

function TcxCustomScheduler.CreateEventPopupMenu: TcxSchedulerEventPopupMenu;
begin
  Result := TcxSchedulerEventPopupMenu.Create(Self);
end;

function TcxCustomScheduler.CreateHintController: TcxSchedulerHintController;
begin
  Result := TcxSchedulerHintController.Create(Self);
end;

function TcxCustomScheduler.CreateOptionsCustomize: TcxSchedulerOptionsCustomize;
begin
  Result := TcxSchedulerOptionsCustomize.Create(Self);
end;

function TcxCustomScheduler.CreateOptionsView: TcxSchedulerOptionsView;
begin
  Result := TcxSchedulerOptionsView.Create(Self);
end;

function TcxCustomScheduler.CreateSplitter(
  AKind: TcxSchedulerSplitterKind): TcxSchedulerSplitter;
begin
  Result := TcxSchedulerSplitter.Create(Self);
  Result.SetKind(AKind);
end;

function TcxCustomScheduler.CreateStyles: TcxSchedulerStyles;
begin
  Result := TcxSchedulerStyles.Create(Self);
end;

procedure TcxCustomScheduler.CreateSubClasses;
begin
  FTextEditProperties := TcxTextEditProperties.Create(Self);
  FEventHitTestController := CreateEventHitTestController;
  FHintController := CreateHintController;
  FEditController := CreateEditController;
  FEditStyle := TcxCustomEditStyle.Create(Self, True);
  FDefaultProperties := TcxMemoProperties.Create(Self);
  FEventList := CreateEventList;

  FEventDays := TcxSchedulerDateList.Create;
  FSelectedDays := TcxSchedulerDateList.Create;
  FSelectedDays.Add(Date);
  FStyles := CreateStyles;
  FEventOperations := CreateEventOperations;
  FOptionsCustomize := CreateOptionsCustomize;
  FOptionsView := CreateOptionsView;
  // subcontrols
  FControlBox := CreateControlBox;
  FDateNavigator := CreateDateNavigator;
  // this order
  FVertSplitter := CreateSplitter(skVertical);
  FHorzSplitter := CreateSplitter(skHorizontal);
  // view
  FCurrentView := CreateDefaultView;
  FCurrentView.Visible := True;
  // popups
  FContentPopupMenu := CreateContentPopupMenu;
  FEventPopupMenu := CreateEventPopupMenu;
  CreateUpdateTimeTimer;
end;

procedure TcxCustomScheduler.DateNavigatorSelectionChanged;
begin
  if not (cfViewValid in FControlFlags) then Exit;
  Exclude(FControlFlags, cfViewValid);
  PeriodChanged;
end;

procedure TcxCustomScheduler.DblClick;
var
  P: TPoint;
begin
  P := ScreenToClient(GetMouseCursorPos);
  if FActiveControl <> nil then
    FActiveControl.MousePositionChanged(P.X, P.Y);
  inherited DblClick;
end;

procedure TcxCustomScheduler.DestroySubClasses;
begin
  FEditController.Free;
  FEventHitTestController.Free;
  FUpdateTimeTimer.Free;
  FContentPopupMenu.Free;
  FEventPopupMenu.Free;
  FEventOperations.Free;
  FEventList.Free;
  FEventDays.Free;
  FOptionsCustomize.Free;
  FOptionsView.Free;
  FStyles.Free;
  FSelectedDays.Free;
  FEditStyle.Free;
  FDefaultProperties.Free;
  FTextEditProperties.Free;
  FHintController.Free;
end;

procedure TcxCustomScheduler.DoAfterDragEvent(Target: TObject;
  X, Y: Integer; var Accept: Boolean);
begin
  if Assigned(FOnAfterDragEvent) then
    FOnAfterDragEvent(Self, Target, X, Y, Accept);
end;

procedure TcxCustomScheduler.DoAfterEditing(AEvent: TcxSchedulerControlEvent);
begin
  if Assigned(FOnAfterEditing) then
    FOnAfterEditing(Self, AEvent);
end;

procedure TcxCustomScheduler.DoAfterSizingEvent(X, Y: Integer;
  var Accept: Boolean);
begin
  if Assigned(FOnAfterSizingEvent) then
    FOnAfterSizingEvent(Self, X, Y, Accept);
end;

function TcxCustomScheduler.DoBeforeDeleting(
  AEvent: TcxSchedulerControlEvent): Boolean;
begin
  Result := True;
  if Assigned(FOnBeforeDeleting) then
    FOnBeforeDeleting(Self, AEvent, Result);
end;

function TcxCustomScheduler.DoBeforeDragEvent(
  AEvent: TcxSchedulerControlEvent; X, Y: Integer): Boolean;
begin
  Result := True;
  if Assigned(FOnBeforeDragEvent) then
    FOnBeforeDragEvent(Self, AEvent, X, Y, Result);
end;

function TcxCustomScheduler.DoBeforeEditing(
  AEvent: TcxSchedulerControlEvent; AInplace: Boolean): Boolean;
begin
  Result := True;
  if Assigned(FOnBeforeEditing) then
    FOnBeforeEditing(Self, AEvent, AInplace, Result);
end;

function TcxCustomScheduler.DoBeforeSizingEvent(
  AEvent: TcxSchedulerControlEvent; X, Y: Integer): Boolean;
begin
  Result := True;
  if Assigned(FOnBeforeSizingEvent) then
    FOnBeforeSizingEvent(Self, AEvent, X, Y, Result);
end;

procedure TcxCustomScheduler.DoCalculateLayout(
  AControl: TcxSchedulerSubControl);
begin
  AControl.LayoutChanged;
end;

procedure TcxCustomScheduler.DoCancelMode;
begin
  if FCaptureControl <> nil then
    FCaptureControl.Controller.DoCancelMode;
  FCaptureControl := nil;
end;

procedure TcxCustomScheduler.DoControllerReset(
  AControl: TcxSchedulerSubControl);
begin
  AControl.Controller.Reset;
end;

procedure TcxCustomScheduler.DoCreateEventUsingInplaceEdit(
  AKey: Char = #0);
var
  I: Integer;
  AEvent: TcxSchedulerEvent;
  AControlEvent: TcxSchedulerControlEvent;
begin
  if not StorageActive then Exit;
  AEvent := Storage.CreateEvent;
  InitEventBySelection(AEvent, False, False, True);
  AEvent.MoveTo(AEvent.Start + GetTimeBias);
  AEvent.Post;
  for I := 0 to EventList.Count - 1 do
  begin
    AControlEvent := EventList[I];
    if AControlEvent.Source = AEvent then
    begin
      EditController.Init(SelStart, SelResource, True);
      if AKey = #0 then
        EditController.Activate(AControlEvent)
      else
        EditController.Activate(AControlEvent, AKey);
      if not EditController.IsEditing then
        AEvent.Delete;
      Exit;
    end;
  end;
end;

procedure TcxCustomScheduler.DoEventSelectionChanged(
  AEvent: TcxSchedulerControlEvent);
begin
  if Assigned(FOnEventSelectionChanged) then
    FOnEventSelectionChanged(Self, AEvent);
end;

procedure TcxCustomScheduler.DoGetEventDisplayText(
  AEvent: TcxSchedulerControlEvent; var AText: string);
begin
  AText := AEvent.Caption;
  if Assigned(FOnGetEventDisplayText) then
    FOnGetEventDisplayText(Self, AEvent, AText);
end;

procedure TcxCustomScheduler.DoGetEventEditProperties(
  AEvent: TcxSchedulerControlEvent; var AProperties: TcxCustomEditProperties);
begin
  if not CurrentView.IsDayView or (AEvent.Duration >= 1) or AEvent.AllDayEvent then
    AProperties := FTextEditProperties
  else
    AProperties := DefaultProperties;
  if Assigned(OnGetEventEditProperties) then
  begin
    OnGetEventEditProperties(Self, AEvent, AProperties);
    if AProperties = nil then
      AProperties := DefaultProperties;
  end;
end;

procedure TcxCustomScheduler.DoHitTestRecalculate(
  AControl: TcxSchedulerSubControl);
begin
  AControl.Controller.HitTest.Recalculate;
end;

procedure TcxCustomScheduler.DoInitEdit(AEdit: TcxCustomEdit);
begin
  if Assigned(FOnInitEdit) then
    FOnInitEdit(Self, AEdit);
end;

function TcxCustomScheduler.DoIsWorkTime(
  AResourceItem: TcxSchedulerStorageResourceItem; const ADateTime: TDateTime): Boolean;
begin
  Result := OptionsView.IsWorkTime(ADateTime);
  if Assigned(FOnIsWorkTime) then
    FOnIsWorkTime(Self, AResourceItem, ADateTime, Result);
end;

procedure TcxCustomScheduler.DoLayoutChanged;
var
  I: Integer;
begin
  FCanvas := GetControlCanvas;
  for I := 0 to FSubControls.Count - 1 do
    SubControls[I].LayoutChanged;
  UpdateScrollBars;
  DoLayoutChangedEvent;
end;

procedure TcxCustomScheduler.DoLayoutChangedEvent;
begin
  if Assigned(FOnLayoutChanged) then
    FOnLayoutChanged(Self);
end;

procedure TcxCustomScheduler.DoCanShowView(
  AView: TcxSchedulerCustomView; var Allow: Boolean);
begin
  if Assigned(FOnCanShowView) then
    FOnCanShowView(Self, AView, Allow);
end;

procedure TcxCustomScheduler.DoSelectionChanged;
begin
  if Assigned(FOnSelectionChanged) then
    FOnSelectionChanged(Self);
end;

function TcxCustomScheduler.DoShowPopupMenu(AMenu: TComponent;
  X, Y: Integer): Boolean;
begin
  with CurrentView do
    Result := Visible and cxRectPtIn(Bounds, ScreenToClient(cxPoint(X, Y))) and
      DoShowPopupMenu(X, Y);
  if not Result then
    Result := inherited DoShowPopupMenu(AMenu, X, Y);
end;

procedure TcxCustomScheduler.DoViewTypeChanged(
  ANewView: TcxSchedulerCustomView);
begin
  if Assigned(FOnViewTypeChanged) then
    FOnViewTypeChanged(Self, FCurrentView, ANewView);
end;

procedure TcxCustomScheduler.DoUpdateTime;
begin
  if not FSubControlsCreated or not HandleAllocated then Exit;
  if CurrentView.Visible then
    CurrentView.DateChanged;
  if DateNavigator.Visible then
    DateNavigator.Refresh;
end;

procedure TcxCustomScheduler.DragCanceled;
begin
  FIsDragCanceled := True;
end;

procedure TcxCustomScheduler.FontChanged;
begin
  BeginUpdate;
  if not IsLoading and FSubControlsCreated then
    DateNavigator.SetIntegralSizes;
  inherited FontChanged;
  LayoutChanged;
  EndUpdate;
end;

function TcxCustomScheduler.GetClientBounds: TRect;
begin
  Result := GetBounds;
  InflateRect(Result, -BorderSize, -BorderSize);
end;

procedure TcxCustomScheduler.FocusChanged;
begin
  if OptionsView.HideSelection and not EditController.Focused then
  begin
    if (CurrentView <> nil) and CurrentView.Visible then
      CurrentView.Refresh;
    if DateNavigator.Visible then
      DateNavigator.Refresh;
  end;
  inherited FocusChanged;
end;

function TcxCustomScheduler.GetControlCanvas: TcxCanvas;
begin
{$IFDEF DEBUGPAINT}
  Result := inherited Canvas
{$ELSE}
  Result := FBitmapCanvas;
{$ENDIF}
end;

function TcxCustomScheduler.GetControlFromPoint(
  const APoint: TPoint): TcxSchedulerSubControl;
var
  I: Integer;
begin
  Result := Background;
  for I := 0 to SubControlCount - 1 do
    if SubControls[I].CanCapture(APoint) then
    begin
      Result := SubControls[I];
      Break;
    end;
end;

function TcxCustomScheduler.GetCursor(
  X, Y: Integer): TCursor;
begin
  Result := crDefault;
  if not IsDesigning then
    Result := GetControlFromPoint(cxPoint(X, Y)).Controller.GetCursor(X, Y);
  if Result = crDefault then
    Result := inherited GetCursor(X, Y);
end;

function TcxCustomScheduler.GetDateTimeHelper: TcxSchedulerDateTimeHelperClass;
begin
  Result := cxSchedulerUtils.DateTimeHelper;
end;

function TcxCustomScheduler.GetDesignHitTest(
  X, Y: Integer; Shift: TShiftState): Boolean;
begin
  Result := inherited GetDesignHitTest(X, Y, Shift);
  if not Result then
  begin
    Result := Capture.AllowDesignHitTest(X, Y, Shift);
    if not Result then
      Result := GetControlFromPoint(cxPoint(X, Y)).AllowDesignHitTest(X, Y, Shift);
  end;
end;

function TcxCustomScheduler.GetEventHintText(
  AEvent: TcxSchedulerControlEvent): string;
begin
  Result := AEvent.Caption;
  with DateTimeHelper do
    Result := TimeToStr(AEvent.Start) + '-' + TimeToStr(AEvent.Finish) + ' ' + Result;
  if Assigned(FOnGetEventHintText) then
    FOnGetEventHintText(Self, AEvent, Result);
end;

function TcxCustomScheduler.GetHScrollBarBounds: TRect;
begin
  Result := CurrentView.GetHScrollBarBounds;
end;

function TcxCustomScheduler.GetIsLocked: Boolean;
begin
  Result := cfLocked in FControlFlags;
end;

function TcxCustomScheduler.GetNextView(
  AView: TcxSchedulerCustomView): TcxSchedulerCustomView;
begin
  Result := AView; 
end;

function TcxCustomScheduler.GetPainterHelper: TcxSchedulerPainterHelperClass;
begin
  Result := TcxSchedulerPainterHelper;
end;

function TcxCustomScheduler.GetSizeGripBounds: TRect;
begin
  Result := CurrentView.GetSizeGripBounds;
end;

function TcxCustomScheduler.GetTimeBias: Double;
begin
  Result := 0;
  if StorageValid then
  begin
    with DateTimeHelper do
    begin
      Result := TimeZoneBias(CurrentTimeZone);
      if not Storage.StoreUsingGlobalTime then;
        Result := TimeZoneBias(OptionsView.CurrentTimeZone) - Result;
    end;
  end; 
end;

function TcxCustomScheduler.GetVScrollBarBounds: TRect;
begin
  Result := CurrentView.GetVScrollBarBounds;
end;

function TcxCustomScheduler.HasResources: Boolean;
begin
  Result := (Storage <> nil) and (Storage.ResourceCount > 0);
end;

procedure TcxCustomScheduler.InitControl;
begin
  inherited InitControl;
  if not IsLoading and OptionsCustomize.IntegralSizing then
    DateNavigator.SetIntegralSizes;
end;

procedure TcxCustomScheduler.InitScrollBarsParameters;
begin
  CurrentView.InitScrollBarsParameters;
end;

procedure TcxCustomScheduler.InternalDeleteEvent(AEvent: TcxSchedulerControlEvent;
  AIgnoreRecurring: Boolean);
var
  ADeleteOccurrence: Boolean;
begin
  if not DoBeforeDeleting(AEvent) then Exit;
  if not AIgnoreRecurring and AEvent.IsRecurring then
  begin
    if cxShowRecurrenceSelectionDialog(AEvent, rsmDeleting,
      LookAndFeel, ADeleteOccurrence) then
      if ADeleteOccurrence then
        AEvent.Delete
      else
        AEvent.Pattern.Delete;
  end
  else
    AEvent.Delete;
end;

procedure TcxCustomScheduler.InternalDeleteSelectedEvents(AForceDelete, ACheckReadOnly: Boolean);
var
  I, AIndex, ACount: Integer;
  AEvent: TcxSchedulerControlEvent;
  ASelectedIDs: array of Variant;

  procedure GetSelection;
  var
    I: Integer;
  begin
    SetLength(ASelectedIDs, SelectedEventCount);
    for I := 0 to SelectedEventCount - 1 do
      ASelectedIDs[I] := SelectedEvents[I].ID;
  end;

  function GetIndexOfID(const AID: Variant): Integer;
  begin
    for Result := 0 to High(ASelectedIDs) do
      if VarEquals(AID, ASelectedIDs[Result]) then Exit;
    Result := -1;
  end;

  procedure DeleteIDByIndex(AIndex: Integer);
  var
    I: Integer;
  begin
    for I := AIndex + 1 to High(ASelectedIDs) do
      ASelectedIDs[I - 1] := ASelectedIDs[I];
    SetLength(ASelectedIDs, Length(ASelectedIDs) - 1);
  end;

begin
  GetSelection;
  if AForceDelete then
    BeginUpdate;
  ACount := 0;
  try
    while ACount <> SelectedEventCount do
    begin
      ACount := SelectedEventCount;
      for I := 0 to ACount - 1 do
      begin
        AEvent := SelectedEvents[I];
        AIndex := GetIndexOfID(AEvent.ID);
        if AIndex >= 0 then
        begin
          DeleteIDByIndex(AIndex);
          if not AForceDelete then
            DeleteEvent(AEvent)
          else
            if not (ACheckReadOnly and AEvent.ReadOnly) then
              InternalDeleteEvent(AEvent, True);
          if ACount <> SelectedEventCount then break;
        end;
      end;
    end;
  finally
    SetLength(ASelectedIDs, 0);
    if AForceDelete then
      EndUpdate;
  end;
end;

function TcxCustomScheduler.IsViewAtLeft: Boolean;
begin
  Result := OptionsView.ViewPosition = vpLeft;
end;

procedure TcxCustomScheduler.KeyDown(
  var Key: Word; Shift: TShiftState);
begin
  if KeyboardListener <> nil then
    KeyboardListener.Controller.KeyDown(Key, Shift)
  else
    CurrentView.Controller.KeyDown(Key, Shift);
  inherited KeyDown(Key, Shift);
end;

procedure TcxCustomScheduler.KeyPress(var Key: Char);
begin
  if KeyboardListener <> nil then
    KeyboardListener.Controller.KeyPress(Key)
  else
    CurrentView.Controller.KeyPress(Key);
  inherited KeyPress(Key);
end;

procedure TcxCustomScheduler.KeyUp(
  var Key: Word; Shift: TShiftState);
begin
  if KeyboardListener <> nil then
    KeyboardListener.Controller.KeyUp(Key, Shift)
  else
    CurrentView.Controller.KeyUp(Key, Shift);
  inherited KeyUp(Key, Shift);
end;

procedure TcxCustomScheduler.Loaded;
begin
  inherited Loaded;
  if not OptionsCustomize.IntegralSizing then
  begin
    if IsViewAtLeft then
      DateNavigator.FSavedSize.cx := ClientBounds.Right - VertSplitter.Right
    else
      DateNavigator.FSavedSize.cx := VertSplitter.Left - ClientBounds.Left;
    DateNavigator.FSavedSize.cy := HorzSplitter.Top -  ClientBounds.Top;
  end;
  DateNavigator.CheckSizes;
  FullRefresh;
end;

procedure TcxCustomScheduler.LockUpdateChanged(
  ALocking: Boolean);
begin
end;

procedure TcxCustomScheduler.LookAndFeelChanged(
  Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
begin
  inherited LookAndFeelChanged(Sender, AChangedValues);
  LayoutChanged;
end;

procedure TcxCustomScheduler.MouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FPrevMousePos := cxInvalidPoint;
  FActiveControl := GetControlFromPoint(cxPoint(X, Y));
  Capture := FActiveControl;
  Capture.DoBeforeMouseDown(Button, Shift, X, Y);
  inherited MouseDown(Button, Shift, X, Y);
  Capture.DoMouseDown(Button, Shift, X, Y);
end;

procedure TcxCustomScheduler.MouseLeave(AControl: TControl);
begin
  inherited MouseLeave(AControl);
  FActiveControl := nil;
end;

procedure TcxCustomScheduler.MouseMove(
  Shift: TShiftState; X, Y: Integer);
begin
  if (FPrevMousePos.X = X) and (FPrevMousePos.Y = Y) then Exit;
  FPrevMousePos := cxPoint(X, Y);
  FActiveControl := FCaptureControl;
  if FActiveControl = nil then
    FActiveControl := GetControlFromPoint(cxPoint(X, Y));
  FActiveControl.DoMouseMove(Shift, X, Y);
  inherited MouseMove(Shift, X, Y);
  if OptionsView.HotTrack or OptionsView.ShowHints then
  begin
    CurrentView.MousePositionChanged(X, Y);
    if (ssLeft in Shift) and not CurrentView.HitTest.HitAtControl and (FSelStart <> FSelFinish) then
    begin
      ReplaceSelParams(FSelStart, FSelStart, FSelResource);
      CurrentView.Refresh;
    end;
    EventHitTestController.MouseMove(X, Y, Shift);
  end;
end;

procedure TcxCustomScheduler.MouseUp(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  Capture.DoMouseUp(Button, Shift, X, Y);
  Capture := nil;
end;

procedure TcxCustomScheduler.Paint;
var
  I: Integer;
begin
  if IsLoading then Exit; 
{$IFNDEF DEBUGPAINT}
  if not (cfImageValid in FControlFlags) then
{$ELSE}
  GdiSetBatchLimit(1);
{$ENDIF}
  begin
    Canvas.Canvas.Lock;
    try
      SelectClipRgn(GetControlCanvas.Handle, 0);
      if BorderStyle = cxcbsDefault then
      begin
        LookAndFeelPainter.DrawSchedulerBorder(GetControlCanvas, Bounds);
        GetControlCanvas.IntersectClipRect(ClientBounds);
      end;
      for I := 0 to SubControlCount - 1 do
        if SubControls[I] <> FBackground then
          SubControls[I].Paint;
      Include(FControlFlags, cfImageValid);
    finally
      Canvas.Canvas.Unlock;
    end;
  end;
{$IFNDEF DEBUGPAINT}
  BitBlt(inherited Canvas.Handle, 0, 0, Width,
    Height, BitmapCanvas.Handle, 0, 0, SRCCOPY);
{$ENDIF}
  FCanModified := True;
end;

procedure TcxCustomScheduler.PeriodChanged;
begin
  FullRefresh;
  DateNavigator.DoPeriodChangedEvent;
end;

procedure TcxCustomScheduler.RemoveSubControl(
  AControl: TcxSchedulerSubControl);
begin
  if (FSubControls.Remove(AControl) <> -1) and not IsDestroying then
  begin
    LayoutChanged;
    if Capture = AControl then
      Capture := nil;
  end;
end;

procedure TcxCustomScheduler.ReplaceSelParams(ASelStart, ASelFinish: TDateTime;
  AResource: TcxSchedulerStorageResourceItem);
begin
  with DateTimeHelper do
  begin
    if (FSelResource <> AResource) or (FSelStart <> RoundTime(ASelStart)) or
      (FSelFinish <> RoundTime(ASelFinish)) then
    begin
      FSelResource :=  AResource;
      FSelStart := RoundTime(ASelStart);
      FSelFinish := RoundTime(ASelFinish);
      DoSelectionChanged;
    end;
  end;
end;

procedure TcxCustomScheduler.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
  if EditController.IsEditing then Exit;
  CurrentView.Scroll(AScrollBarKind, AScrollCode, AScrollPos);
end;

procedure TcxCustomScheduler.SetCurrentView(
  AView: TcxSchedulerCustomView);
begin
  if (AView <> nil) and (AView.Scheduler = Self) then
    FCurrentView := AView;
end;

procedure TcxCustomScheduler.SubControlAdd(
  AControl: TcxSchedulerSubControl);
begin
  FSubControls.Add(AControl);
  LayoutChanged;
end;

procedure TcxCustomScheduler.SubControlRemove(
  AControl: TcxSchedulerSubControl);
begin
  FSubControls.Remove(AControl);
  LayoutChanged;
end;

procedure TcxCustomScheduler.SynchronizeVisibleDays;
begin
  Include(FControlFlags, cfViewValid);
end;

procedure TcxCustomScheduler.UpdateEventsCache(
  ACheckDaysInterval: Boolean);
var
  AStart, AFinish: TDateTime;
begin
  CurrentView.Controller.CloseInplaceEdit;
  if not StorageValid then
  begin
    FreeAndNil(FEventList);
    FEventList := CreateEventList;
  end;
  FEventList.TimeZone := OptionsView.CurrentTimeZone;
  FEventList.ShowEventsWithoutResource := OptionsView.ShowEventsWithoutResource or
    (VisibleGroupingKind = gkNone);
  AStart := Min(CurrentView.FirstVisibleDate, DateNavigator.GetRealFirstDate)
    - CurrentView.GetVisibleDaysRange;
  AFinish := Max(CurrentView.LastVisibleDate, DateNavigator.GetRealLastDate)
    + CurrentView.GetVisibleDaysRange;
  if ACheckDaysInterval and (AStart >= EventList.Start) and
    (AFinish <= EventList.Finish) then Exit;
  FEventList.SelStart := SelectedDays[0] - 7;
  FEventList.SelFinish := SelectedDays[SelectedDays.Count - 1] + 7;
  if StorageValid then
    Storage.GetEvents(FEventList, AStart, AFinish);
  FEventDays.Clear;
  if DateNavigator.GetShowDatesContainingEventsInBold then
    FEventList.ExtractUsedDays(FEventDays); 
end;

procedure TcxCustomScheduler.ValidateSelection(
  ASelection: TcxSchedulerDateList);
begin
  DateNavigator.UpdateSelection;
end;

procedure TcxCustomScheduler.ValidateState;
var
  AIsLocked: Boolean;
begin
  AIsLocked := cfLocked in FControlFlags;
  if cfInvalidLayout in FControlFlags then
  try
    LayoutChanged;
  finally
    FControlFlags := [];
    if AIsLocked then
      FControlFlags := [cfLocked];
  end;
end;

procedure TcxCustomScheduler.ViewVisibleChanged(
  AView: TcxSchedulerCustomView);
begin
  Exclude(FControlFlags, cfViewValid);
  if FVisibleChangedCount = 0 then
    DateNavigator.BeginUpdate;
  Inc(FVisibleChangedCount);
  try
    if AView.Visible and (CurrentView <> AView) then
    begin
     CurrentView.Visible := False;
     DoViewTypeChanged(AView);
     CurrentView := AView;
    end
    else
      if not FCurrentView.Visible and (FVisibleChangedCount = 1)  then
        GetNextView(FCurrentView).Visible := True;
  finally
    Dec(FVisibleChangedCount);
    if FVisibleChangedCount = 0 then
    begin
      AlignSubControls;
      LayoutChanged;
      DateNavigator.EndUpdate;
    end;
  end;
end;

function TcxCustomScheduler.VisibleGroupingKind: TcxSchedulerGroupingKind;
var
  I, C: Integer;
begin
  Result := CurrentView.GetGroupingKind;
  C := 0;
  if HasResources then
  begin
    for I := 0 to Storage.ResourceCount - 1 do
      if Storage.Resources.ResourceItems[I].Visible then Inc(C);
  end;
  if C = 0 then
    Result := gkNone
  else
    if Result = gkDefault then
      Result := gkByResource;
end;

function TcxCustomScheduler.CanDrag(X, Y: Integer): Boolean;
begin
  Result := inherited CanDrag(X, Y) and not IsDesigning and
    CaptureController.CanDrag(X, Y);
end;

procedure TcxCustomScheduler.DoEndDrag(
  Target: TObject; X, Y: Integer);
begin
  CaptureController.EndDrag(Target, X, Y);
  inherited DoEndDrag(Target, X, Y);
  Capture := nil;
end;

procedure TcxCustomScheduler.DoStartDrag(
  var DragObject: TDragObject);
begin
  FIsDragCanceled := False;
  inherited DoStartDrag(DragObject);
  CaptureController.StartDrag(DragObject);
end;

procedure TcxCustomScheduler.DragAndDrop(
  const P: TPoint; var Accepted: Boolean);
begin
  inherited DragAndDrop(P, Accepted);
  CaptureController.DragAndDrop(P, Accepted);
end;

procedure TcxCustomScheduler.DragOver(
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  AAccept, ACopyDragDrop: Boolean;
  AControl: TcxSchedulerSubControl;
begin
  ACopyDragDrop := IsCopyDragDrop;
  if State <> dsDragMove then
    FPrevMousePos := cxInvalidPoint
  else
    if (FPrevMousePos.X = X) and (FPrevMousePos.Y = Y) and (FPrevCopyDragDrop = ACopyDragDrop) then
      Exit
    else
      FPrevMousePos := cxPoint(X, Y);
  if not Dragging then
  begin
    AControl := GetControlFromPoint(Point(X, Y));
    if AControl <> nil then
    begin
      SetCaptureControl(AControl);
      AControl.MousePositionChanged(X, Y);
    end;
  end;
  AAccept := Accept and (DragMode = dmAutomatic);
  inherited DragOver(Source, X, Y, State, Accept);
  if not Assigned(OnDragOver) then Accept := AAccept;
  CaptureController.DragOver(Source, X, Y, State, Accept);
  FPrevCopyDragDrop := ACopyDragDrop;
end;

procedure TcxCustomScheduler.EndDragAndDrop(
  Accepted: Boolean);
begin
  inherited EndDragAndDrop(Accepted);
  CaptureController.EndDragAndDrop(Accepted);
end;

function TcxCustomScheduler.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  Result := CaptureController.GetDragAndDropObjectClass;
end;

function TcxCustomScheduler.GetDragObjectClass: TDragControlObjectClass;
begin
  Result := TcxSchedulerDragObject;
end;

function TcxCustomScheduler.StartDragAndDrop(
  const P: TPoint): Boolean;
begin
  Result := CaptureController.StartDragAndDrop(P)
end;

// IcxSchedulerStorageListener
procedure TcxCustomScheduler.StorageChanged(Sender: TObject);
begin
  FullRefresh;
end;

procedure TcxCustomScheduler.StorageRemoved(Sender: TObject);
begin
  CurrentView.Controller.CloseInplaceEdit;
  FStorage.RemoveListener(Self);
  FStorage := nil;
  LayoutChanged;
end;

// IcxFormatControllerListener
procedure TcxCustomScheduler.DoStartOfWeekChanged(
  AOldStartOfWeek, ANewStartOfWeek: TDay);
var
  I, ADelta: Integer;
begin
  ADelta := Ord(ANewStartOfWeek) - Ord(AOldStartOfWeek);
  if (ADelta <> 0) and not CurrentView.IsDayView then
  begin
    for I := 0 to SelectedDays.Count - 1 do
      SelectedDays[I] := SelectedDays[I] + ADelta;
  end;
  OptionsView.CalculateActualStartOfWeek;
  FullRefresh;
end;

procedure TcxCustomScheduler.FormatChanged;
var
  I: Integer;
begin
  if DateTimeHelper <> nil then DateTimeHelper.Refresh;
  if OptionsView.StartOfWeek = swSystem then
    DoStartOfWeekChanged(OptionsView.ActualStartOfWeek,
      TDay(DateTimeHelper.StartOfWeek))
  else
  begin
    for I := 0 to SubControlCount - 1 do
      SubControls[I].FormatChanged;
    FullRefresh;
  end;
end;

// IcxFormatControllerListener2
procedure TcxCustomScheduler.TimeChanged;
begin
  DoUpdateTime;
end;

// IcxStoredObject
function TcxCustomScheduler.GetObjectName: string;
begin
  if FStoringName <> '' then
    Result := FStoringName
  else
    Result := Name;
end;

function TcxCustomScheduler.GetProperties(AProperties: TStrings): Boolean;
var
  I: Integer;
begin
  AProperties.Add('SelectedDayCount');
  for I := 0 to SubControlCount - 1 do
    SubControls[I].GetProperties(AProperties);
  Result := True;
end;

procedure TcxCustomScheduler.GetPropertyValue(const AName: string;
  var AValue: Variant);
var
  I: Integer;
begin
  if AName = 'SelectedDayCount' then
    AValue := SelectedDays.Count
  else
    for I := 0 to SubControlCount - 1 do
      SubControls[I].GetPropertyValue(AName, AValue);
end;

procedure TcxCustomScheduler.SetPropertyValue(const AName: string;
  const AValue: Variant);
var
  I: Integer;
  ADate: TDateTime;
begin
  if AName = 'SelectedDayCount' then
  begin
    SelectedDays.Clear;
    ADate := Date;
    for I := 0 to Min(Max(AValue - 1, 0), 41) do
      SelectedDays.Add(ADate + I);
  end
  else
    for I := 0 to SubControlCount - 1 do
      SubControls[I].SetPropertyValue(AName, AValue);
end;

procedure TcxCustomScheduler.CalcHorzSplitterBounds(
  AByDateNavigator: Boolean);
begin
  if not FHorzSplitter.Visible or FHorzSplitterShowing then Exit;
  if AByDateNavigator then
    FHorzSplitter.Bounds := cxRectSetTop(DateNavigator.Bounds,
      DateNavigator.Bottom, OptionsView.HorzSplitterWidth)
  else
    FHorzSplitter.Bounds := cxRectSetBottom(ControlBox.Bounds,
      ControlBox.Top, OptionsView.HorzSplitterWidth);
end;

procedure TcxCustomScheduler.CalcVertSplitterBounds;
var
  R: TRect;
begin
  if not FVertSplitter.Visible or FVertSplitterShowing then Exit;
  if DateNavigator.Visible then
    R := DateNavigator.Bounds
  else
    R := ControlBox.Bounds;
  if IsViewAtLeft then
    R := cxRectSetRight(ClientBounds, R.Left, OptionsView.VertSplitterWidth)
  else
    R := cxRectSetLeft(ClientBounds, R.Right, OptionsView.VertSplitterWidth);
  FVertSplitter.Bounds := R;
end;

procedure TcxCustomScheduler.CheckHorzSplitterBounds;
var
  R: TRect;
begin
  R := FHorzSplitter.Bounds;
  if IsVertSplitterVisible then
  begin
    if IsViewAtLeft then
    begin
      R.Left := FVertSplitter.Right;
      R.Right := ClientBounds.Right;
    end
    else
    begin
      R.Left := ClientBounds.Left;
      R.Right := FVertSplitter.Left;
    end
  end
  else
  begin
    R.Left := ClientBounds.Left;
    R.Right := ClientBounds.Right;
  end;
  FHorzSplitter.Bounds := cxRectSetHeight(R, OptionsView.HorzSplitterWidth);
end;

procedure TcxCustomScheduler.CheckSplittersVisibilityChanging;
begin
  FVertSplitterShowing := not FVertSplitter.Visible and IsVertSplitterVisible;
  if FVertSplitterShowing then
    UpdateControlsBoundsOnVertSplitterShowing;
  FVertSplitter.Visible := IsVertSplitterVisible;
  FHorzSplitterShowing := not FHorzSplitter.Visible and IsHorzSplitterVisible;
  if FHorzSplitterShowing then
    UpdateControlsBoundsOnHorzSplitterShowing;
  FHorzSplitter.Visible := IsHorzSplitterVisible;
end;

procedure TcxCustomScheduler.CreateUpdateTimeTimer;
begin
  FUpdateTimeTimer := TTimer.Create(nil);
  FUpdateTimeTimer.Interval := 60 * 1000; //one minute
  FUpdateTimeTimer.OnTimer := UpdateTimeHandler;
end;

function TcxCustomScheduler.GetActiveHitTest: TcxSchedulerSubControlHitTest;
var
  AControl: TcxSchedulerSubControl;
  APos: TPoint;
begin
  if (FActiveControl <> nil) and (FCaptureControl = nil) then
    Result := FActiveControl.HitTest
  else
  begin
    APos := ScreenToClient(GetMouseCursorPos);
    AControl := GetControlFromPoint(APos);
    if AControl = Background then
      Result := nil
    else
    begin
      AControl.MousePositionChanged(APos.X, APos.Y);
      Result := AControl.HitTest;
    end;
  end;
end;

function TcxCustomScheduler.GetCaptureControl: TcxSchedulerSubControl;
begin
  Result := FCaptureControl;
  if FCaptureControl = nil then
    Result := Background;
end;

function TcxCustomScheduler.GetCaptureController: TcxSchedulerSubControlController;
begin
  Result := Capture.Controller;
end;

function TcxCustomScheduler.GetSelectedEventCount: Integer;
begin
  Result := EventList.Selection.Count;
end;

function TcxCustomScheduler.GetSelectedEvent(
  AIndex: Integer): TcxSchedulerControlEvent;
begin
  Result := EventList.Selection[AIndex]
end;

function TcxCustomScheduler.GetSelFinish: TDateTime;
begin                       
  Result := Max(FSelStart, FSelFinish);
  Result := DateTimeHelper.RoundTime(Result + CurrentView.GetTimeIncrement);
end;

function TcxCustomScheduler.GetSelStart: TDateTime;
begin
  Result := Min(FSelStart, FSelFinish);
end;

function TcxCustomScheduler.GetIsDynamicUpdate: Boolean;
begin
  Result := OptionsCustomize.DynamicSizing and not IsDesigning;
end;

function TcxCustomScheduler.GetStartOfWeek: TDay;
begin
  Result := OptionsView.ActualStartOfWeek;
end;

function TcxCustomScheduler.GetStorageActive: Boolean;
begin
  Result := (FStorage <> nil) and FStorage.IsActive;
end;

function TcxCustomScheduler.GetStorageValid: Boolean;
begin
  Result := FStorage <> nil;
end;

function TcxCustomScheduler.GetSubControl(
  AIndex: Integer): TcxSchedulerSubControl;
begin
  Result := TcxSchedulerSubControl(FSubControls[AIndex])
end;

function TcxCustomScheduler.GetSubControlCount: Integer;
begin
  Result := FSubControls.Count;
end;

function TcxCustomScheduler.GetVisibleEventCount: Integer;
begin
  Result := EventList.Count; 
end;

function TcxCustomScheduler.GetVisibleEvent(
  AIndex: Integer): TcxSchedulerControlEvent;
begin
  Result := EventList[AIndex];
end;

procedure TcxCustomScheduler.InitEventBySelection(
  AEvent: TcxSchedulerEvent; AllDay: Boolean;
  ARecurrence: Boolean; AInplaceEditing: Boolean);
const
  States: array[Boolean] of Byte = (tlsBusy, tlsFree);
begin
  if SelResource <> nil then
    AEvent.ResourceID := SelResource.ResourceID;
  CurrentView.InitEventBySelectedPeriod(AEvent, AllDay, ARecurrence, AInplaceEditing);
  AEvent.State := States[AEvent.AllDayEvent];
end;

function TcxCustomScheduler.IsHorzSplitterVisible: Boolean;
begin
  Result := DateNavigator.Visible and ControlBox.Visible;
end;

function TcxCustomScheduler.IsVertSplitterVisible: Boolean;
begin
  Result := CurrentView.Visible and
    (DateNavigator.Visible or ControlBox.Visible);
end;

procedure TcxCustomScheduler.SetCaptureControl(
  AValue: TcxSchedulerSubControl);
begin
  if FCaptureControl <> AValue then
  begin
    CaptureController.DoCancelMode;
    FCaptureControl := AValue;
  end;
end;

procedure TcxCustomScheduler.SetContentPopupMenu(
  AValue: TcxSchedulerContentPopupMenu);
begin
  FContentPopupMenu.Assign(AValue);
end;

procedure TcxCustomScheduler.SetControlBox(
  AValue: TcxSchedulerControlBox);
begin
  FControlBox.Assign(AValue);
end;

procedure TcxCustomScheduler.SetEventOperations(
  AValue: TcxSchedulerEventOperations);
begin
  FEventOperations.Assign(AValue);
end;

procedure TcxCustomScheduler.SetEventPopupMenu(
  AValue: TcxSchedulerEventPopupMenu);
begin
  FEventPopupMenu.Assign(AValue);
end;

procedure TcxCustomScheduler.SetOptionsCustomize(
  AValue: TcxSchedulerOptionsCustomize);
begin
  FOptionsCustomize.Assign(AValue);
end;

procedure TcxCustomScheduler.SetOptionsView(
  AValue: TcxSchedulerOptionsView);
begin
  FOptionsView.Assign(AValue);
end;

procedure TcxCustomScheduler.SetStorage(
  AValue: TcxCustomSchedulerStorage);
begin
  if FStorage <> AValue then
  begin
    if FStorage <> nil then
      FStorage.RemoveListener(Self);
    FStorage := AValue;
    if FStorage <> nil then
      FStorage.AddListener(Self);
    FullRefresh;
  end;
end;

procedure TcxCustomScheduler.SetStyles(
  AValue: TcxSchedulerStyles);
begin
  FStyles.Assign(AValue);
end;

procedure TcxCustomScheduler.UpdateAlignByDateNavigatorOrControlBox(
  AByDateNavigator: Boolean);

  procedure CalcSlaveControlBounds(ASlave, AMaster: TcxSchedulerSubControl);
  var
    R: TRect;
  begin
    if not ASlave.Visible then Exit;
    R := ClientBounds;
    R.Left := AMaster.Left;
    R.Right := AMaster.Right;
    if IsHorzSplitterVisible then
      if ASlave = DateNavigator then
        R.Bottom := FHorzSplitter.Top
      else
        R.Top := FHorzSplitter.Bottom;
    ASlave.Bounds := R;
  end;

  procedure CalcMasterControlBounds(AMaster: TcxSchedulerSubControl);
  var
    R: TRect;
  begin
    if not AMaster.Visible then Exit;
    R := AMaster.Bounds;
    if not IsVertSplitterVisible then
    begin
      R.Left := ClientBounds.Left;
      R.Right := ClientBounds.Right;
    end
    else
      if IsViewAtLeft then
        R := cxRectSetRight(R, ClientBounds.Right)
      else
        R := cxRectSetLeft(R, ClientBounds.Left);
    if not IsHorzSplitterVisible then
      if AMaster = DateNavigator then
        R.Bottom := ClientBounds.Bottom
      else
        R.Top := ClientBounds.Top;
    if AMaster = DateNavigator then
      R := cxRectSetTop(R, ClientBounds.Top)
    else
      R := cxRectSetBottom(R, ClientBounds.Bottom);
    AMaster.Bounds := R;
  end;

var
  ASlave, AMaster: TcxSchedulerSubControl;
begin
  if AByDateNavigator then
  begin
    AMaster := DateNavigator;
    ASlave := ControlBox;
  end
  else
  begin
    AMaster := ControlBox;
    ASlave := DateNavigator;
  end;
  CalcMasterControlBounds(AMaster);
  if AMaster.Visible then
    CalcHorzSplitterBounds(AByDateNavigator);
  CalcSlaveControlBounds(ASlave, AMaster);
  CalcVertSplitterBounds;
  UpdateCurrentViewBounds;
end;

procedure TcxCustomScheduler.UpdateAlignByView;

  procedure CalcControlBounds(AControl: TcxSchedulerSubControl);
  var
    R: TRect;
  begin
    if not AControl.Visible then Exit;
    R := ClientBounds;
    if IsHorzSplitterVisible then
      if AControl = DateNavigator then
        R.Bottom := FHorzSplitter.Top
      else
        R.Top := FHorzSplitter.Bottom;
    if IsVertSplitterVisible then
      if IsViewAtLeft then
        R.Left := FVertSplitter.Right
      else
        R.Right := FVertSplitter.Left;
    AControl.Bounds := R;
  end;

  procedure CheckVertSplitterBounds;
  var
    R: TRect;
  begin
    if not IsVertSplitterVisible then Exit;
    R := CurrentView.Bounds;
    if IsViewAtLeft then
      R := cxRectSetLeft(R, R.Right, OptionsView.VertSplitterWidth)
    else
      R := cxRectSetRight(R, R.Left, OptionsView.VertSplitterWidth);
    FVertSplitter.Bounds := R;
  end;

  procedure CheckCurrentViewBounds;
  begin
    if not IsVertSplitterVisible then
      UpdateCurrentViewBounds;
    if not IsViewAtLeft then
      CurrentView.Right := ClientBounds.Right;
  end;

begin
  CheckCurrentViewBounds;
  CheckVertSplitterBounds;
  CalcControlBounds(DateNavigator);
  CalcControlBounds(ControlBox);
  CalcHorzSplitterBounds(DateNavigator.Visible);
end;

procedure TcxCustomScheduler.UpdateControlsBoundsOnHorzSplitterShowing;
var
  R: TRect;
begin
  CheckHorzSplitterBounds;
  R := DateNavigator.Bounds;
  R.Top := ClientBounds.Top;
  R.Bottom := FHorzSplitter.Top;
  DateNavigator.Bounds := R;
  R.Top := FHorzSplitter.Bottom;
  R.Bottom := ClientBounds.Bottom;
  ControlBox.Bounds := R;
end;

procedure TcxCustomScheduler.UpdateControlsBoundsOnVertSplitterShowing;
var
  R: TRect;
begin
  CheckHorzSplitterBounds;
  FVertSplitter.Width := OptionsView.VertSplitterWidth;
  R := ClientBounds;
  if IsViewAtLeft then
  begin
    R.Right := FVertSplitter.Left;
    CurrentView.Bounds := R;
    R := DateNavigator.Bounds;
    R.Left := FVertSplitter.Right;
    R.Right := ClientBounds.Right;
  end
  else
  begin
    R.Left := FVertSplitter.Right;
    CurrentView.Bounds := R;
    R := DateNavigator.Bounds;
    R.Left := ClientBounds.Left;
    R.Right := FVertSplitter.Left;
  end;
  DateNavigator.Bounds := R;
  R.Top := ControlBox.Bounds.Top;
  R.Bottom := ClientBounds.Bottom;
  ControlBox.Bounds := R;
end;

procedure TcxCustomScheduler.UpdateCurrentViewBounds;
var
  R: TRect;
begin
  if not CurrentView.Visible then Exit;
  R := ClientBounds;
  if IsViewAtLeft and IsVertSplitterVisible then
    R.Right := FVertSplitter.Left;
  if not IsViewAtLeft and IsVertSplitterVisible then
    R.Left := FVertSplitter.Right;
  CurrentView.Bounds := R;
end;

procedure TcxCustomScheduler.UpdateInvisibleSplitterBounds;
begin
  if not (FSubControlsCreated and HandleAllocated) then Exit;
  FAligningSubControls := True;
  try
    if not HorzSplitter.Visible and IsViewAtLeft then
      HorzSplitter.Right := ClientBounds.Right;
    if not VertSplitter.Visible then
    begin
      if IsViewAtLeft then
        VertSplitter.Left := VertSplitter.Left + (ClientBounds.Right - FPrevBounds.Right);
      VertSplitter.Height := ClientHeight;
    end;
  finally
    FAligningSubControls := False;
  end;
end;

procedure TcxCustomScheduler.UpdateTimeHandler(Sender: TObject);
begin
  CurrentView.TimeChanged;
end;

procedure TcxCustomScheduler.WMCancelMode(var Message: TWMCancelMode);
begin
  FIsDragCanceled := True;
  try
    inherited;
  finally
    FIsDragCanceled := False;
  end;
end;

procedure TcxCustomScheduler.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
  ACursor: TCursor;
begin
  ACursor := crDefault;
  P := ScreenToClient(GetMouseCursorPos);
  if IsDesigning and (DragAndDropState = ddsNone) and GetDesignHitTest(P.X, P.Y, [ssLeft]) then
    ACursor := GetControlFromPoint(P).Controller.GetCursor(P.X, P.Y);
  if ACursor <> crDefault then
    SetCursor(Screen.Cursors[ACursor])
  else
    inherited;
end;

procedure TcxCustomScheduler.WMTimeChange(var Message: TWMTimeChange);
begin
  DoUpdateTime;
  Message.Result := 0;
end;

procedure TcxCustomScheduler.ReadSelectionData(AReader: TReader);
var
  I: Integer;
begin
  FSelectedDays.Count := AReader.ReadInteger and $FF;
  for I := 0 to FSelectedDays.Count - 1 do
    FSelectedDays[I] := Date + I;
end;

procedure TcxCustomScheduler.ReadSplittersData(AStream: TStream);
var
  R: TRect;
begin
  BeginUpdate;
  try
    AStream.Read(R, SizeOf(R));
    HorzSplitter.Bounds := R;
    AStream.Read(R, SizeOf(R));
    VertSplitter.Bounds := R;
    LayoutChanged;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomScheduler.WriteSelectionData(AWriter: TWriter);
begin
  AWriter.WriteInteger(FSelectedDays.Count);
end;

procedure TcxCustomScheduler.WriteSplittersData(AStream: TStream);
var
  R: TRect;
begin
  R := HorzSplitter.Bounds;
  AStream.Write(R, SizeOf(R));
  R := VertSplitter.Bounds;
  AStream.Write(R, SizeOf(R));
end;

{ TcxSchedulerPopupMenu }

constructor TcxSchedulerPopupMenu.Create(
  AScheduler: TcxCustomScheduler);
begin
  FScheduler := AScheduler;
  FUseBuiltInPopupMenu := True;
end;

destructor TcxSchedulerPopupMenu.Destroy;
begin
  PopupMenu := nil;
  FreeAndNil(FInternalMenu);
  inherited Destroy;
end;

procedure TcxSchedulerPopupMenu.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerPopupMenu then
  begin
    PopupMenu := TcxSchedulerPopupMenu(Source).PopupMenu;
    UseBuiltInPopupMenu := TcxSchedulerPopupMenu(Source).UseBuiltInPopupMenu;
  end;
end;

function TcxSchedulerPopupMenu.AddValidSeparator(AOwner: TMenuItem): TMenuItem;
begin
  if AOwner.Count > 0 then
    Result := CreateSeparator(AOwner)
  else
    Result := nil
end;

procedure TcxSchedulerPopupMenu.CreateInternalMenu;
begin
  FreeAndNil(FInternalMenu);
  FInternalMenu := TPopupMenu.Create(nil);
  FInternalMenu.Images := MenuImages;
  CreateItems;
end;

procedure TcxSchedulerPopupMenu.CreateItems;
begin
end;

function TcxSchedulerPopupMenu.CreateSeparator(AOwner: TMenuItem): TMenuItem;
begin
  Result := CreateSubItem(AOwner, '-');
end;

function TcxSchedulerPopupMenu.CreateSubItem(
  AOwner: TMenuItem; const ACaption: string; ACommand: Integer = -1;
  AImageIndex: Integer = -1; AEnabled: Boolean = True; AChecked: Boolean = False): TMenuItem;
begin
  Result := TMenuItem.Create(nil);
  Result.Caption := ACaption;
  Result.Enabled := AEnabled;
  Result.ImageIndex := AImageIndex;
  Result.Checked := AChecked;
  Result.Tag := ACommand;
  Result.OnClick := OnItemClickHandler;
  AOwner.Add(Result);
end;

procedure TcxSchedulerPopupMenu.DoExecute(ACommand: Integer);
begin
end;

function TcxSchedulerPopupMenu.DoOnClick(ACommand: Integer): Boolean;
begin
  Result := False;
end;

function TcxSchedulerPopupMenu.DoOnPopup: Boolean;
begin
  Result := False;
end;

procedure TcxSchedulerPopupMenu.ExecuteCommand(ACommand: Integer);
begin
  if IsValidCommand(ACommand) and not DoOnClick(ACommand) then
    DoExecute(ACommand);
end;

function TcxSchedulerPopupMenu.FindItemByCommand(AOwnerItem: TMenuItem;
  ACommand: Integer): TMenuItem;
var
  I: Integer;
begin
  Result := nil;
  if (InternalMenu = nil) or (AOwnerItem = nil) then Exit;
  with AOwnerItem do
    for I := 0 to Count - 1 do
      if (Items[I].Tag = Ord(ACommand)) and (Items[I].Caption <> '-') then
      begin
        Result := Items[I];
        system.Break;
      end;
end;

function TcxSchedulerPopupMenu.IsValidCommand(ACommand: Integer): Boolean;
begin
  Result := True;
end;

function TcxSchedulerPopupMenu.Popup(X, Y: Integer): Boolean;
begin
  CreateInternalMenu;
  Result := DoOnPopup;
  if not Result then
  begin
    if UseBuiltInPopupMenu then
      Result := ShowPopupMenu(Scheduler, FInternalMenu, X, Y)
    else
      Result := ShowPopupMenu(Scheduler, FPopupMenu, X, Y);
  end;
end;

procedure TcxSchedulerPopupMenu.OnItemClickHandler(Sender: TObject);
begin
  if Sender is TComponent then
    ExecuteCommand(TComponent(Sender).Tag);
end;

function TcxSchedulerPopupMenu.Storage: TcxCustomSchedulerStorage;
begin
  Result := Scheduler.Storage;
end;

function TcxSchedulerPopupMenu.GetRoot: TMenuItem;
begin
  Result := FInternalMenu.Items;
end;

procedure TcxSchedulerPopupMenu.SetPopupMenu(const Value: TComponent);
begin
  if FPopupMenu <> Value then
  begin
    if (FPopupMenu <> nil) and not (csDestroying in FPopupMenu.ComponentState) then
      FPopupMenu.RemoveFreeNotification(Scheduler);
    FPopupMenu := Value;
    if FPopupMenu <> nil then
      FPopupMenu.FreeNotification(Scheduler);
  end;
end;

{ TcxSchedulerCustomContentPopupMenu }

constructor TcxSchedulerCustomContentPopupMenu.Create(
  AScheduler: TcxCustomScheduler);
begin
  inherited Create(AScheduler);
  FNewID := -1;
  FAllDayID := -1;
  FReccurenceID := -1;
end;

function TcxSchedulerCustomContentPopupMenu.CanCreateEvent: Boolean;
begin
  Result := Scheduler.CurrentView.Controller.CanCreateEventUsingDialog;
end;

procedure TcxSchedulerCustomContentPopupMenu.CreateNewEventItems(ANew,
  AllDay, AReccurence: Boolean; ANewID, AllDayID, AReccurenceID: Integer);
var
  AEnabled: Boolean;
begin
  AEnabled := CanCreateEvent;
  if ANew then
  begin
    CreateSubItem(Root, cxGetResourceString(@scxpmNewEvent),
      ANewID, 2, AEnabled);
    FNewID := ANewID;
  end;
  if AllDay then
  begin
    CreateSubItem(Root, cxGetResourceString(@scxpmNewAllDayEvent),
      AllDayID, -1, AEnabled);
    FAllDayID := AllDayID;
  end;
  if Scheduler.StorageActive and Storage.IsRecurrenceAvailable and
    AReccurence and Scheduler.EventOperations.Recurrence then
  begin
    CreateSubItem(Root, cxGetResourceString(@scxpmNewRecurringEvent),
      AReccurenceID, 3, AEnabled);
    FReccurenceID := AReccurenceID;
  end;
  AddValidSeparator(Root);
end;

procedure TcxSchedulerCustomContentPopupMenu.DoExecute(ACommand: Integer);
begin
  if ACommand <> -1 then
  begin
    if ACommand = FNewID then
      Scheduler.CreateEventUsingDialog
    else if ACommand = FAllDayID then
      Scheduler.CreateEventUsingDialog(True)
    else if ACommand = FReccurenceID then
      Scheduler.CreateEventUsingDialog(False, True);
  end;
end;

{ TcxSchedulerContentPopupMenu }

constructor TcxSchedulerContentPopupMenu.Create(
  AScheduler: TcxCustomScheduler);
begin
  inherited Create(AScheduler);
  FItems := [cpmiNewEvent, cpmiNewAllDayEvent, cpmiNewReccuringEvent,
    cpmiToday, cpmiGoToDate, cpmiGoToThisDay, cpmiResourcesLayout];
end;

procedure TcxSchedulerContentPopupMenu.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxSchedulerContentPopupMenu then
  begin
    Items := TcxSchedulerContentPopupMenu(Source).Items;
    OnClick := TcxSchedulerContentPopupMenu(Source).OnClick;
    OnPopup := TcxSchedulerContentPopupMenu(Source).OnPopup;
  end;
end;

procedure TcxSchedulerContentPopupMenu.Execute(
  AItem: TcxSchedulerContentPopupMenuItem);
begin
  ExecuteCommand(Ord(AItem));
end;

function TcxSchedulerContentPopupMenu.GetMenuItem(
  AItem: TcxSchedulerContentPopupMenuItem): TMenuItem;
begin
  Result := FindItemByCommand(Root, Ord(AItem));
end;

procedure TcxSchedulerContentPopupMenu.CreateItems;
begin
  CreateNewEventItems(cpmiNewEvent in FItems, cpmiNewAllDayEvent in FItems,
    cpmiNewReccuringEvent in FItems, Ord(cpmiNewEvent), Ord(cpmiNewAllDayEvent),
    Ord(cpmiNewReccuringEvent));
  CreateGoToThisDayItem;
  if cpmiToday in FItems then
    CreateSubItem(Root, cxGetResourceString(@scxpmToday), Ord(cpmiToday));
  if cpmiGoToDate in FItems then
    CreateSubItem(Root, cxGetResourceString(@scxpmGoToDate), Ord(cpmiGoToDate));
  if (cpmiResourcesLayout in FItems) and Scheduler.CurrentView.IsShowResources then
  begin
    AddValidSeparator(Root);
    CreateSubItem(Root, cxGetResourceString(@scxpmResourcesLayout), Ord(cpmiResourcesLayout));
  end;
end;

procedure TcxSchedulerContentPopupMenu.DoExecute(ACommand: Integer);
var
  ADate: TDateTime;
  AViewMode: TcxSchedulerViewMode;
begin
  case ACommand of
    Ord(cpmiNewEvent), Ord(cpmiNewAllDayEvent), Ord(cpmiNewReccuringEvent):
      inherited DoExecute(ACommand);
    Ord(cpmiResourcesLayout):
      cxShowResourcesLayoutEditor(Scheduler.Storage, Scheduler.LookAndFeel);
    Ord(cpmiGoToThisDay):
      Scheduler.GoToDate(FSavedDate);
    Ord(cpmiToday):
      Scheduler.GoToDate(Date);
    Ord(cpmiGoToDate):
      begin
        if Scheduler.SelectedDays.Count > 0 then
          ADate := Scheduler.SelectedDays[0]
        else
          ADate := Date;
        if cxShowGoToDateDialog(Scheduler, Scheduler.LookAndFeel, ADate, AViewMode) then
          Scheduler.GoToDate(ADate, AViewMode);
      end;
  end;
end;

function TcxSchedulerContentPopupMenu.DoOnClick(ACommand: Integer): Boolean;
begin
  Result := False;
  if Assigned(FOnClick) then
    FOnClick(Self, TcxSchedulerContentPopupMenuItem(ACommand), Result);
end;

function TcxSchedulerContentPopupMenu.DoOnPopup: Boolean;
begin
  Result := False;
  if Assigned(FOnPopup) then
    FOnPopup(Self, InternalMenu, Result);
end;

function TcxSchedulerContentPopupMenu.IsValidCommand(
  ACommand: Integer): Boolean;
begin
  Result := (ACommand >= Ord(cpmiNewEvent)) and (ACommand <= Ord(cpmiResourcesLayout));
end;

procedure TcxSchedulerContentPopupMenu.CreateGoToThisDayItem;
var
  AItem: TMenuItem;
begin
  if (cpmiGoToThisDay in FItems) and not Scheduler.CurrentView.IsDayView then
  begin
    AItem := CreateSubItem(Root, cxGetResourceString(@scxpmGotoThisDay), Ord(cpmiGoToThisDay));
    AItem.Enabled := Scheduler.ActiveHitTest.HitAtTime;
    if AItem.Enabled then
      FSavedDate := Scheduler.ActiveHitTest.Time;
  end;
end;

{ TcxSchedulerEventPopupMenu }

constructor TcxSchedulerEventPopupMenu.Create(
  AScheduler: TcxCustomScheduler);
begin
  inherited Create(AScheduler);
  FItems := [epmiOpen, epmiEditSeries, epmiShowTimeAs, epmiLabel, epmiDelete];
end;

procedure TcxSchedulerEventPopupMenu.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxSchedulerEventPopupMenu then
  begin
    Items := TcxSchedulerEventPopupMenu(Source).Items;
    OnClick := TcxSchedulerEventPopupMenu(Source).OnClick;
    OnPopup := TcxSchedulerEventPopupMenu(Source).OnPopup;
  end;
end;

procedure TcxSchedulerEventPopupMenu.CreateItems;

  function GetEditEnabled: Boolean;
  begin
    Result := (Event <> nil) and Scheduler.CanShowEventDialog;
  end;

begin
  FEvent := GetEvent;
  if epmiOpen in Items then
    CreateSubItem(Root, cxGetResourceString(@scxpmOpen), Ord(epmiOpen)).Enabled :=
      GetEditEnabled;
  if (epmiEditSeries in Items) and (Event <> nil) and (Event.EventType <> etNone) then
    CreateSubItem(Root, cxGetResourceString(@scxpmEditSeries), Ord(epmiEditSeries), 8).Enabled :=
      GetEditEnabled;
  if Items * [epmiLabel, epmiShowTimeAs] <> [] then
    AddValidSeparator(Root);
  CreateTimeItems;
  CreateLabelItems;
  CreateDeleteItem;
end;

procedure TcxSchedulerEventPopupMenu.DoExecute(ACommand: Integer);
begin
  case ACommand of
    Ord(epmiOpen):
      Scheduler.EditEventUsingDialog(Event);
    Ord(epmiEditSeries):
      Scheduler.EditEventUsingDialog(Event, True, True);
    Ord(epmiDelete):
      Scheduler.InternalDeleteSelectedEvents(False, True);
    10..13:
      SetEventState(ACommand - 10);
    20..30:
      SetEventLabelColor(EventLabelColors[ACommand - 20]);
  end;
end;

function TcxSchedulerEventPopupMenu.DoOnClick(ACommand: Integer): Boolean;
var
  AItem: TcxSchedulerEventPopupMenuItem;
  ASubItemIndex: Integer;
begin
  Result := False;
  UnpackCommand(ACommand, AItem, ASubItemIndex);
  if Assigned(FOnClick) then
    FOnClick(Self, AItem, ASubItemIndex, Result);
end;

function TcxSchedulerEventPopupMenu.DoOnPopup: Boolean;
begin
  Result := False;
  if Assigned(FOnPopup) then
    FOnPopup(Self, InternalMenu, Result);
end;

function TcxSchedulerEventPopupMenu.GetMenuItem(
  AItem: TcxSchedulerEventPopupMenuItem; ASubItemIndex: Integer = -1): TMenuItem;
begin
  Result := FindItemByCommand(Root, Ord(AItem));
  if Result <> nil then
  begin
    if (AItem = epmiLabel) and (ASubItemIndex in [0..10]) then
      Result := FindItemByCommand(Result, ASubItemIndex + 20)
    else
      if (AItem = epmiShowTimeAs) and (ASubItemIndex in [0..3]) then
        Result := FindItemByCommand(Result, ASubItemIndex + 10)
  end;
end;

function TcxSchedulerEventPopupMenu.IsValidCommand(
  ACommand: Integer): Boolean;
begin
  Result := (ACommand >= Ord(epmiOpen)) and (ACommand <= Ord(epmiDelete)) or
   (ACommand in [20..30]) or //Label
   (ACommand in [10..13]);   //TimeLine
end;

procedure TcxSchedulerEventPopupMenu.SetEventLabelColor(AColor: Integer);
begin
  if Event = nil then Exit;
  if Event.EventType = etOccurrence then
    Event.Pattern.LabelColor := AColor
  else
    Event.Source.LabelColor := AColor;
end;

procedure TcxSchedulerEventPopupMenu.SetEventState(AState: Integer);
begin
  if Event = nil then Exit;
  Event.State := AState;
  Scheduler.EventList.PostEvent(Event);
end;

procedure TcxSchedulerEventPopupMenu.CreateDeleteItem;

  function CanDelete: Boolean;
  var
    I: Integer;
  begin
    with Scheduler do
    begin
      Result := EventOperations.Deleting;
      if Result then
      begin
        for I := 0 to SelectedEventCount - 1 do
          if not SelectedEvents[I].ReadOnly then
            Exit;
        Result := False;
      end;
    end;
  end;

begin
  if epmiDelete in Items then
  begin
    AddValidSeparator(Root);
    CreateSubItem(Root, cxGetResourceString(@scxpmDelete), Ord(epmiDelete), 10).Enabled := CanDelete;
  end;
end;

procedure TcxSchedulerEventPopupMenu.CreateLabelItems;
var
  AOwner: TMenuItem;
  I: Integer;

  function GetColorChecked(AIndex: Integer): Boolean;
  begin
    if Event = nil then
      Result := False
    else
      Result := Event.LabelColor = EventLabelColors[AIndex];
  end;

  procedure CreateEventColorItem(const ACaption: string; AIndex: Integer);
  var
    AChecked: Boolean;
  begin
    AChecked := GetColorChecked(AIndex);
    CreateSubItem(AOwner, ACaption, GetCommand(epmiLabel, AIndex), AIndex + 11,
      CanEdit, AChecked).Default := AChecked;
  end;

begin
  if not (epmiLabel in Items) or not Scheduler.StorageActive or
    not Storage.IsLabelColorAvailable then Exit;
  AOwner := CreateSubItem(Root, cxGetResourceString(@scxpmLabel), Ord(epmiLabel));
  //label colors
  CreateEventColorItem(cxGetResourceString(@scxEventLabelNone), 0);
  CreateSeparator(AOwner);
  for I := 1 to 10 do
    CreateEventColorItem(cxGetResourceString(sEventLabelCaptions[I]), I);
end;

procedure TcxSchedulerEventPopupMenu.CreateTimeItems;
var
  AOwner: TMenuItem;

  function GetTimeLineChecked(AIndex: Integer): Boolean;
  begin
    if Event = nil then
      Result := False
    else
      Result := Integer(Event.State) = AIndex;
  end;

  procedure CreateTimeLineItem(const ACaption: string; AIndex: Integer);
  var
    AChecked: Boolean;
  begin
    AChecked := GetTimeLineChecked(AIndex);
    CreateSubItem(AOwner, ACaption, GetCommand(epmiShowTimeAs, AIndex), AIndex,
      CanEdit, AChecked).Default := AChecked;
  end;

begin
  if not (epmiShowTimeAs in Items) or not Scheduler.StorageActive or
    not Storage.IsStateAvailable then Exit;
  AOwner := CreateSubItem(Root, cxGetResourceString(@scxpmShowTimeAs), Ord(epmiShowTimeAs));
  AOwner.SubMenuImages := TimeLinePatterns;
  // TimeLine styles
  CreateTimeLineItem(cxGetResourceString(@scxpmFree), 0);
  CreateTimeLineItem(cxGetResourceString(@scxpmTentative), 1);
  CreateTimeLineItem(cxGetResourceString(@scxpmBusy), 2);
  CreateTimeLineItem(cxGetResourceString(@scxpmOutOfOffice), 3);
end;

function TcxSchedulerEventPopupMenu.GetCommand(
  AItem: TcxSchedulerEventPopupMenuItem; ASubItemIndex: Integer): Integer;
begin
  Result := Ord(AItem);
  case AItem of
    epmiShowTimeAs:
      if (ASubItemIndex >= 0) and (ASubItemIndex <= 3) then
        Result := 10 + ASubItemIndex;
    epmiLabel:
      if (ASubItemIndex >= 0) and (ASubItemIndex <= 10) then
        Result := 20 + ASubItemIndex;
  end;
end;

function TcxSchedulerEventPopupMenu.CanEdit: Boolean;
begin
  Result := (Event <> nil) and not Event.ReadOnly;
end;

function TcxSchedulerEventPopupMenu.GetEvent: TcxSchedulerControlEvent;
begin
  with Scheduler.EventList.Selection do
  begin
    if Count = 1 then
      Result := Items[0]
    else
      Result := nil;
  end;
end;

procedure TcxSchedulerEventPopupMenu.UnpackCommand(ACommand: Integer;
  out AItem: TcxSchedulerEventPopupMenuItem; out ASubItemIndex: Integer);
begin
  AItem := epmiOpen;
  ASubItemIndex := -1;
  if not IsValidCommand(ACommand) then Exit;
  if ACommand in [20..30] then
  begin
    AItem := epmiLabel;
    ASubItemIndex := ACommand - 20;
  end
  else
    if ACommand in [10..13] then
    begin
      AItem := epmiShowTimeAs;
      ASubItemIndex := ACommand - 10;
    end
    else
      AItem := TcxSchedulerEventPopupMenuItem(ACommand);
end;

end.

