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

unit cxSchedulerDayView;

{$I cxVer.inc}

interface

uses
  Windows, Forms, Classes, SysUtils, Math, StdCtrls, Graphics, {$IFDEF DELPHI6}DateUtils, {$ENDIF}
  Controls, ExtCtrls, cxControls, cxGraphics, cxStyles, cxGeometry, Menus,
  cxLookAndFeelPainters, cxSchedulerCustomControls, cxSchedulerCustomResourceView,
  cxSchedulerUtils, cxSchedulerStorage, cxSchedulerStrs;

const
  cxDefaultTimeScale = 30;
  cxScrollInterval   = 25;
  cxScrollZoneSize   = 10;

  cxcsHeaderContainer         = 0;
  cxcsSelectedHeaderContainer = 1;
  cxcsTimeLine                = 2;
  cxcsTimeRuler               = 3;
  cxcsMaxDayViewValue         = cxcsTimeRuler;
  //for PS
  cxcsDayViewStyleFirst = cxcsHeaderContainer;
  cxcsDayViewStyleLast = cxcsMaxDayViewValue;

type
  TcxSchedulerDayViewViewInfo = class;
  TcxEventLayoutInfo = class;
  TcxCalculateEventLayout = class;
  TcxSchedulerDayViewHitTest = class;
  TcxSchedulerDayViewController = class;
  TcxSchedulerTimeRulerPopupMenu = class;

  IcxSchedulerTimeRulerParams = interface
  ['{FEAA09ED-8FE1-4968-9BCB-0FC26B13A391}']
    function GetTimeRulerParams: TcxViewParams; 
  end;

  { TcxSchedulerDayViewStyles }

  TcxSchedulerDayViewStyles = class(TcxStyles)
  private
    FScheduler: TcxCustomScheduler;
    function GetPainter: TcxCustomLookAndFeelPainterClass;
  protected
    procedure Changed(AIndex: Integer); override;
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
    property Painter: TcxCustomLookAndFeelPainterClass read GetPainter;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    function GetHeaderContainerParams(const ADate: TDateTime;
      AResource: TcxSchedulerStorageResourceItem; ASelected: Boolean): TcxViewParams;
    function GetTimeRulerParams: TcxViewParams;
    function GetTimeLineParams: TcxViewParams;
    // define colors functions
    property Scheduler: TcxCustomScheduler read FScheduler;
  published
    property HeaderContainer: TcxStyle index cxcsHeaderContainer read GetValue write SetValue;
    property SelectedHeaderContainer: TcxStyle index cxcsSelectedHeaderContainer read GetValue write SetValue;
    property TimeLine: TcxStyle index cxcsTimeLine read GetValue write SetValue;
    property TimeRuler: TcxStyle index cxcsTimeRuler read GetValue write SetValue;
  end;

  { TcxSchedulerDayView }

  TcxSchedulerCustomDrawContainerEvent = procedure(Sender: TObject;
    ACanvas: TcxCanvas; AViewInfo: TcxSchedulerContainerCellViewInfo; var ADone: Boolean) of object;
  TcxSchedulerCustomDrawTimeRulerEvent = procedure(Sender: TObject;
    ACanvas: TcxCanvas; AViewInfo: TcxSchedulerTimeRulerCellViewInfo; var ADone: Boolean) of object;

  TcxSchedulerDayView = class(TcxSchedulerCustomResourceView)
  private
    FAutoContentHeight: Boolean;
    FEventShadows: Boolean;
    FStyles: TcxSchedulerDayViewStyles;
    FTimeRulerPopupMenu: TcxSchedulerTimeRulerPopupMenu;
    FTimeScale: Integer;
    FOnCustomDrawContainer: TcxSchedulerCustomDrawContainerEvent;
    FOnCustomDrawTimeRuler: TcxSchedulerCustomDrawTimeRulerEvent;
    function GetHitTest: TcxSchedulerDayViewHitTest;
    function GetViewInfo: TcxSchedulerDayViewViewInfo;
    procedure SetAutoContentHeight(AValue: Boolean);
    procedure SetEventShadows(AValue: Boolean);
    procedure SetStyles(AValue: TcxSchedulerDayViewStyles);
    procedure SetTimeRulerPopupMenu(AValue: TcxSchedulerTimeRulerPopupMenu);
    procedure SetTimeScale(AValue: Integer);
  protected
    // store interface
    procedure GetProperties(AProperties: TStrings); override;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); override;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); override;
    //
    procedure CreateSubClasses; override;
    procedure DestroySubClasses; override;
    function CreateController: TcxSchedulerSubControlController; override;
    function CreateHitTest: TcxSchedulerSubControlHitTest; override;
    function CreatePainter: TcxSchedulerSubControlPainter; override;
    function CreateStyles: TcxSchedulerDayViewStyles; virtual;
    function CreateTimeRulerPopupMenu: TcxSchedulerTimeRulerPopupMenu; virtual;
    function CreateViewAdapter: TcxCustomResourceViewAdapter; override;
    function CreateViewInfo: TcxSchedulerSubControlViewInfo; override;
    procedure DoCustomDrawContainer(ACell: TcxSchedulerContainerCellViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawTimeRuler(ACell: TcxSchedulerTimeRulerCellViewInfo; var ADone: Boolean); virtual;
    function DoShowPopupMenu(X, Y: Integer): Boolean; override;
    function EventContentSelected(AEvent: TcxSchedulerControlEvent): Boolean; override;
    function GetTimeIncrement: TDateTime; override;
    function IsDayView: Boolean; override;
    procedure MakeEventVisible(AEvent: TcxSchedulerControlEvent; const ADate: TDateTime;
      AResource: TcxSchedulerStorageResourceItem); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ScrollVisibleDays(AScrollUp: Boolean); override;
    procedure TimeChanged; override;
    procedure VisibleChanged; override;

    property ViewInfo: TcxSchedulerDayViewViewInfo read GetViewInfo;
  public
    constructor Create(AOwner: TcxCustomScheduler); override;
    procedure Assign(Source: TPersistent); override;
    procedure MakeWorkTimeVisible;

    property HitTest: TcxSchedulerDayViewHitTest read GetHitTest;
    property Scheduler;
    property WorkDays;
    property WorkStart;
    property WorkFinish;
  published
    property CanShow; //before active
    property Active;
    property AutoContentHeight: Boolean read FAutoContentHeight write SetAutoContentHeight default False;
    property EventShadows: Boolean read FEventShadows write SetEventShadows default True;
    property GroupingKind;
    property Styles: TcxSchedulerDayViewStyles read FStyles write SetStyles;
    property TimeRulerPopupMenu: TcxSchedulerTimeRulerPopupMenu read FTimeRulerPopupMenu write SetTimeRulerPopupMenu;
    property TimeScale: Integer read FTimeScale write SetTimeScale default cxDefaultTimeScale;

    property OnCustomDrawContainer: TcxSchedulerCustomDrawContainerEvent read FOnCustomDrawContainer write FOnCustomDrawContainer;
    property OnCustomDrawTimeRuler: TcxSchedulerCustomDrawTimeRulerEvent read FOnCustomDrawTimeRuler write FOnCustomDrawTimeRuler;

  end;

  { TcxSchedulerDayViewAdapter }
  
  TcxSchedulerDayViewAdapter = class(TcxCustomResourceViewAdapter)
  protected
    FTopIndex: Integer;
    procedure Store; override;
    procedure Restore; override;
  end;

  { TcxSchedulerDayViewViewInfo }

  TcxSchedulerDayViewViewInfo = class(TcxSchedulerCustomResourceViewViewInfo)
  private
    function GetAutoHeight: Boolean;
    function GetColumnInGroup: Integer;
    function GetContentHeight: Integer;
    function GetDayView: TcxSchedulerDayView;
    function GetGroupCount: Integer;
    function GetPrintRowCount: Integer;
    function GetLinePerHour: Integer;
    procedure SetLargeFont(AFont: TFont);
  protected
    FAdditionalTimeZone: Integer;
    FBackground: TcxSchedulerBackgroundCellViewInfo;
    FColCount: Integer;
    FContentOffset: Integer;
    FCurrentTimeZone: Integer;
    FEventLayout: TcxCalculateEventLayout;
    FHeaderLineCount: Integer;
    FHeaderLineHeight: Integer;
    FHeaderOffsetLeft: Integer;
    FIsContainerSelected: Boolean;
    FLargeFont: TFont;
    FPrintStartRow: Integer;
    FPrintFinishRow: Integer;
    FRowCount: Integer;
    FTimeRulerCells: TcxSchedulerViewInfoCellList;
    FTopIndex: Integer;
    FTimeScale: Integer;
    FUnusedRowCount: Integer;
    FVisibleRowCount: Integer;
    function AddContentCell(const ARect: TRect; const AStart, AFinish: TDateTime;
      AResourceIndex: Integer): TcxSchedulerContentCellViewInfo; override;
    procedure AddContainerCell(AColumn: Integer; const ABounds: TRect);
    procedure AddHeaderContainerEvent(AEvent: TcxSchedulerControlEvent;
      AContainer: TcxSchedulerContainerCellViewInfo; AColIndex: Integer);
    procedure AddMoreEventsButton(const AIndex, ARowIndex: Integer; AIsTop: Boolean);
    procedure CalculateBackground; virtual;
    procedure CalculateContent; virtual;
    procedure CalculateEvents; virtual;
    procedure CalculateEventsForColumn(AIndex: Integer;
      AContainer: TcxSchedulerContainerCellViewInfo; AEvents: TcxSchedulerEventList); virtual;
    procedure CalculateHeaderEvents; virtual;
    procedure CalculateHeaderLineCount;
    procedure CalculateHeaders; virtual;
    procedure CalculateMetrics; override;
    procedure CalculateMetricsForPrinting;
    procedure CalculatePrintRows;
    procedure CalculateTimeLine; virtual;
    procedure CalculateUnusedRowCount;
    function CheckDisplayRows(var AStartRow, AFinishRow: Integer): Boolean;
    procedure CheckEventRowsVisibility(AEvent: TcxSchedulerControlEvent;
      AStartRow, AFinishRow: Integer);
    procedure Clear; override;
    function CreateContentEventViewData(AEventInfo: TcxEventLayoutInfo;
      AResource: TcxSchedulerResourceViewInfo): TcxSchedulerEventViewData;
    function CreateHeaderEventViewData(AEvent: TcxSchedulerControlEvent; const ABounds: TRect;
      const AStart, AFinish: TDateTime; AResource: TcxSchedulerResourceViewInfo): TcxSchedulerEventViewData;
    function CreateEventLayout: TcxCalculateEventLayout; virtual;
    procedure DoCalculate; override;
    procedure ExtractEvents(ASource, ADest: TcxSchedulerEventList; AIndex: Integer);
    function GetContentParams(const ATime: TDateTime;
      AResource: TcxSchedulerResourceViewInfo): TcxViewParams; override;
    function GetColumnDate(AIndex: Integer): TDateTime;
    function GetColumnResource(AIndex: Integer): TcxSchedulerResourceViewInfo;
    function GetColumnResourceIndex(AIndex: Integer): Integer;
    function GetContainer(AIndex: Integer): TcxSchedulerContainerCellViewInfo; virtual;
    function GetContainerCount: Integer; virtual;
    function GetDayHeaderHeight: Integer; override;
    function GetEventSlotDisplayText(AEvent: TcxSchedulerControlEvent): string;
    function GetTimeLineParams: TcxViewParams; override;
    function GetTimeRulerParams: TcxViewParams;
    function GetTimeRow(const ATime: TDateTime; AIsStart: Boolean): Integer;
    function GetRowTime(AColumn, ARow: Integer): TDateTime;
    function IsColumnEvent(AEvent: TcxSchedulerEvent; AIndex: Integer; IsHeaderEvent: Boolean): Boolean;
    function IsContainerSelected(AResource: TcxSchedulerStorageResourceItem; ADate: TDateTime): Boolean;
    function IsEventVisible(AEvent: TcxSchedulerEvent): Boolean; overload;
    function IsEventVisible(var AStartRow, AStopRow: Integer): Boolean; overload;
    function IsHourVisible(AIndex: Integer): Boolean;
    function IsRowVisible(AIndex: Integer): Boolean;
    procedure MakeTimeVisible(const ATime: TDateTime); override;
    procedure OnClickMoreButton(Sender: TcxSchedulerMoreEventsButtonViewInfo); override;
    procedure SetColumnTimeLineStyle(AViewInfo: TcxSchedulerEventCellViewInfo; AColIndex: Integer);

    property ColCount: Integer read FColCount;
    property ColumnInGroup: Integer read GetColumnInGroup;
    property ContainerCount: Integer read GetContainerCount;
    property Containers[AIndex: Integer]: TcxSchedulerContainerCellViewInfo read GetContainer;
    property GroupCount: Integer read GetGroupCount;
  public
    constructor Create(AOwner: TcxSchedulerSubControl); override;
    destructor Destroy; override;
    procedure CalculateHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
    procedure InitScrollBarsParameters; override;
    procedure ScrollVertical(AScrollCode: TScrollCode; var AScrollPos: Integer); override;

    property AutoHeight: Boolean read GetAutoHeight;
    property Background: TcxSchedulerBackgroundCellViewInfo read FBackground;
    property ContentHeight: Integer read GetContentHeight;
    property DayView: TcxSchedulerDayView read GetDayView;
    property HeaderContainerCells: TcxSchedulerViewInfoCellList read FHeaderContainerCells;
    property HeaderLineHeight: Integer read FHeaderLineHeight;
    property LargeFont: TFont read FLargeFont write SetLargeFont;
    property LinePerHour: Integer read GetLinePerHour;
    property PrintRowCount: Integer read GetPrintRowCount;
    property PrintFinishRow: Integer read FPrintFinishRow;
    property PrintStartRow: Integer read FPrintStartRow;
    property TimeScale: Integer read FTimeScale;
    property TimeRulerCells: TcxSchedulerViewInfoCellList read FTimeRulerCells;
    property TopIndex: Integer read FTopIndex;
    property UnusedRowCount: Integer read FUnusedRowCount;
    property VisibleRowCount: Integer read FVisibleRowCount;
  end;

  { TcxSchedulerDayViewHitTest }

  TcxSchedulerDayViewHitTest = class(TcxSchedulerCustomResourceViewHitTest)
  private
    function GetContainerCell: TcxSchedulerContainerCellViewInfo;
    function GetTimeRulerCell: TcxSchedulerTimeRulerCellViewInfo;
  public
    property ContainerCell: TcxSchedulerContainerCellViewInfo read GetContainerCell;
    property HitAtContainer: Boolean index htcContainer read GetBitState;
    property HitAtTimeRuler: Boolean index htcTimeRuler read GetBitState;
    property TimeRulerCell: TcxSchedulerTimeRulerCellViewInfo read GetTimeRulerCell;
    property HitAtTimeZoneLabel;
    property TimeZone; 
  end;

  { TcxDayViewDragEventHelper }

  TcxDayViewDragEventHelper = class(TcxDragEventHelper)
  private
    FStartInHeader: Boolean;
    function GetController: TcxSchedulerDayViewController;
    function GetHitTest: TcxSchedulerDayViewHitTest;
  protected
    function GetOriginHitTestMask: Int64; override;
    procedure GetOriginState; override;
    function InHeader: Boolean; virtual;
    function IsAtOrigin: Boolean; override;
    procedure SetCloneEventsTimeDelta(AStart, ACurrent: TDateTime; AInHeader: Boolean);
    procedure UpdateClonesTime; override;
    procedure UpdateEventProperties; override;
    procedure UpdateEventStates;

    property Controller: TcxSchedulerDayViewController read GetController;
    property HitTest: TcxSchedulerDayViewHitTest read GetHitTest;
  end;

  { TcxDayViewEventSizing }

  TcxDayViewEventSizing = class(TcxEventSizingHelper)
  private
    FFixedBoundTime: TDateTime;
    function GetController: TcxSchedulerDayViewController;
    function GetHitTest: TcxSchedulerDayViewHitTest;
  protected
    function GetDragCursor(Accepted: Boolean): TCursor; override;
    function GetOriginHitTestMask: Int64; override;
    // Event handling
    procedure CalcAllDayEvent; override;
    function GetFinishTime: TDateTime; override;
    procedure GetOriginState; override;
    function GetSizingTime: TDateTime;
    function GetStartTime: TDateTime; override;

    property Controller: TcxSchedulerDayViewController read GetController;
    property HitTest: TcxSchedulerDayViewHitTest read GetHitTest;
  end;

  { TcxSchedulerDayNavigation }

  TcxSchedulerDayNavigation = class(TcxSchedulerCustomResourceViewNavigation)
  private
    function GetDayView: TcxSchedulerDayView;
    function GetSelectedDays: TcxSchedulerDateList;
    function GetViewInfo: TcxSchedulerDayViewViewInfo;
  protected
    FSelRow: Integer;
    function ColCount: Integer;
    procedure DoNextColumn(AGoToNext: Boolean; AColumn: Integer;
      const ATime: TDateTime; AResource: TcxSchedulerStorageResourceItem); virtual;
    function DoNextPage(AGoForward: Boolean; var ATime: TDateTime;
      var AResource: TcxSchedulerStorageResourceItem): Boolean; virtual;
    function GetColumnByDate(const ADate: TDateTime; AResource: TObject): Integer;
    function GetColumnDate(AColumn: Integer): TDateTime;
    function GetColumnResource(AColumn: Integer): TcxSchedulerStorageResourceItem;
    function GetRowTime(const ARow: Integer; AFinish: Boolean = False): TDateTime;
    function GetTimeRow(const ATime: TDateTime): Integer;
  public
    procedure KeyDown(var AKey: Word; AShift: TShiftState); override;
    procedure ValidateSelection(var ASelStart, ASelFinish: TDateTime;
      var AResource: TcxSchedulerStorageResourceItem); override;
      
    property DayView: TcxSchedulerDayView read GetDayView;
    property SelectedDays: TcxSchedulerDateList read GetSelectedDays; 
    property ViewInfo: TcxSchedulerDayViewViewInfo read GetViewInfo;
  end;

  { TcxSchedulerDayViewController }

  TcxSchedulerDayViewController = class(TcxSchedulerCustomResourceViewController)
  private
    FPos: TPoint;
    FTimer: TTimer;
    procedure CheckUpdateEventBounds;
    function GetHitTest: TcxSchedulerDayViewHitTest;
    function GetViewInfo: TcxSchedulerDayViewViewInfo;
  protected
    FIsEditingBeforeMouseDown: Boolean;
    procedure BeforeMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure CancelScroll; override;
    procedure CheckScrolling(const APos: TPoint); override;
    procedure CheckTimeRulerTime;
    function CreateDragEventHelper: TcxDragEventHelper; override;
    function CreateNavigation: TcxSchedulerViewNavigation; override;
    function CreateResizeEventHelper: TcxEventSizingHelper; override;
    procedure InitTimer(AllowStart: Boolean; AScrollCode: TScrollCode); virtual;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure OnTimer(Sender: TObject); virtual;

    property HitTest: TcxSchedulerDayViewHitTest read GetHitTest;
    property ViewInfo: TcxSchedulerDayViewViewInfo read GetViewInfo;
  public
    constructor Create(AOwner: TcxSchedulerSubControl); override;
    destructor Destroy; override;
  end;

  { TcxSchedulerDayViewPainter }

  TcxSchedulerDayViewPainter = class(TcxSchedulerCustomViewPainter)
  private
    function GetView: TcxSchedulerDayView;
    function GetViewInfo: TcxSchedulerDayViewViewInfo;
  protected
    procedure DrawContainerCell(AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean); virtual;
    procedure DrawDayViewEventCell(AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean); virtual;
    procedure DrawTimeRulerCell(AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean); virtual;
  public
    procedure Paint; override;
    
    property View: TcxSchedulerDayView read GetView;
    property ViewInfo: TcxSchedulerDayViewViewInfo read GetViewInfo;
  end;

  { TcxEventLayoutInfo }

  TcxEventLayoutInfo = class
  private
  protected
    ColStart, ColEnd, ColCount: Integer;
    Event: TcxSchedulerControlEvent;
    FDisplayRect: TRect;
    FFinishTime: TDateTime;
    FStartTime: TDateTime;
    IsBreakEvent: Boolean; 
    RowCount: Integer;
    StartRow, StopRow: Integer;
    function ShadowSize: Integer;
    procedure CalculateDisplayRect(AWidth, ARowHeight: Integer);
    procedure CalculateTimes(const ADate: TDateTime; AScale: Integer);
  public
    constructor Create(AEvent: TcxSchedulerControlEvent;
      const ADate: TDateTime; AScale: Integer); virtual;
      
    property DisplayRect: TRect read FDisplayRect;
    property Finish: TDateTime read FFinishTime;
    property Start: TDateTime read FStartTime;
  end;

  { TcxCalculateEventLayout }

  TcxCalculateEventLayout = class(TList)
  private
    FDate: TDateTime;
    FLeft: Integer;
    FRowHeight: Integer;
    FTimeScale: Integer;
    FTop: Integer;
    FWidth: Integer;
    function GetInfo(AIndex: Integer): TcxEventLayoutInfo;
  protected
    FViewInfo: TcxSchedulerDayViewViewInfo; 
    procedure CalculateColCount(AInfo: TcxEventLayoutInfo); virtual;
    procedure CalculateColEnd(AInfo: TcxEventLayoutInfo); virtual;
    procedure CalculateColStart(AInfo: TcxEventLayoutInfo; AIndex: Integer); virtual;
    function CreateEventInfo(AEvent: TcxSchedulerControlEvent): TcxEventLayoutInfo;
    function Intersect(AInfo1, AInfo2: TcxEventLayoutInfo): Boolean;
    procedure SetColCount(AInfo: TcxEventLayoutInfo);
  public
    procedure Add(AEvent: TcxSchedulerControlEvent);
    procedure Calculate;
    procedure Clear; override;
    procedure SetParams(const ADate: TDateTime; ATimeScale, ARowHeight: Integer;
      ALeft, ATop, AWidth: Integer);
      
    property Date: TDateTime read FDate write FDate;
    property Infos[Index: Integer]: TcxEventLayoutInfo read GetInfo;
    property Left: Integer read FLeft;
    property RowHeight: Integer read FRowHeight;
    property TimeScale: Integer read FTimeScale;
    property Top: Integer read FTop;
    property Width: Integer read FWidth;
  end;

  { TcxSchedulerTimeRulerPopupMenu }

  TcxSchedulerTimeRulerPopupMenuItem = (rpmiNewEvent, rpmiNewAllDayEvent,
    rpmiNewReccuringEvent, rpmi60min, rpmi30min, rpmi15min, rpmi10min,
    rpmi6min, rpmi5min);
  TcxSchedulerTimeRulerPopupMenuItems = set of TcxSchedulerTimeRulerPopupMenuItem;

  TcxSchedulerTimeRulerPopupMenuPopupEvent = procedure (
    Sender: TcxSchedulerTimeRulerPopupMenu; ABuiltInMenu: TPopupMenu;
    var AHandled: Boolean) of object;
  TcxSchedulerTimeRulerPopupMenuClickEvent = procedure (
    Sender: TcxSchedulerTimeRulerPopupMenu;
    AItem: TcxSchedulerTimeRulerPopupMenuItem; var AHandled: Boolean) of object;

  TcxSchedulerTimeRulerPopupMenu = class(TcxSchedulerCustomContentPopupMenu)
  private
    FItems: TcxSchedulerTimeRulerPopupMenuItems;
    FOnPopup: TcxSchedulerTimeRulerPopupMenuPopupEvent;
    FOnClick: TcxSchedulerTimeRulerPopupMenuClickEvent;
    function GetDayView: TcxSchedulerDayView;
  protected
    procedure CreateItems; override;
    procedure DoExecute(ACommand: Integer); override;
    function DoOnClick(ACommand: Integer): Boolean; override;
    function DoOnPopup: Boolean; override;
    function IsValidCommand(ACommand: Integer): Boolean; override;

    property DayView: TcxSchedulerDayView read GetDayView;
  public
    constructor Create(AScheduler: TcxCustomScheduler); override;
    procedure Assign(Source: TPersistent); override;
    procedure Execute(AItem: TcxSchedulerTimeRulerPopupMenuItem);
    function GetMenuItem(AItem: TcxSchedulerTimeRulerPopupMenuItem): TMenuItem;
  published
    property Items: TcxSchedulerTimeRulerPopupMenuItems
      read FItems write FItems default [rpmiNewEvent, rpmiNewAllDayEvent,
        rpmiNewReccuringEvent, rpmi60min, rpmi30min, rpmi15min, rpmi10min,
        rpmi6min, rpmi5min];
    property PopupMenu;
    property UseBuiltInPopupMenu;
    
    property OnClick: TcxSchedulerTimeRulerPopupMenuClickEvent read FOnClick write FOnClick;
    property OnPopup: TcxSchedulerTimeRulerPopupMenuPopupEvent read FOnPopup write FOnPopup;
  end;

implementation

uses
  cxDateUtils, cxClasses, cxLibraryConsts;

const
  RulerScales: array[0..5] of Integer = (60, 30, 15, 10, 6, 5);

function GetTimeMinutes(const ATime: TDateTime): Integer;
var
  H, M, S, MS: Word;
begin
  DecodeTime(ATime, H, M, S, MS);
  Result := H * 60 + M;
end;

{ TcxSchedulerDayViewStyles }

constructor TcxSchedulerDayViewStyles.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FScheduler := TcxSchedulerDayView(GetOwner).Scheduler;
end;

procedure TcxSchedulerDayViewStyles.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TcxSchedulerDayViewStyles then
  begin
    for I := 0 to cxcsMaxDayViewValue do
      SetValue(I, TcxSchedulerDayViewStyles(Source).GetValue(I))
  end;
  inherited Assign(Source);
end;

procedure TcxSchedulerDayViewStyles.Changed(AIndex: Integer);
begin
  TcxSchedulerDayView(GetOwner).Refresh;
end;

procedure TcxSchedulerDayViewStyles.GetDefaultViewParams(Index: Integer;
  AData: TObject; out AParams: TcxViewParams);
begin
  AParams.Bitmap := nil;
  AParams.Font := Scheduler.Font;
  AParams.TextColor := clBlack;
  AParams.Color := Scheduler.Color;
  case Index of
    cxcsHeaderContainer:
      begin
        AParams.Color := Painter.DefaultHeaderBackgroundColor;
        AParams.TextColor := Painter.DefaultHeaderBackgroundTextColor;
      end;
    cxcsSelectedHeaderContainer:
      begin
        AParams.Color := Painter.DefaultContentColor;
        AParams.TextColor := Painter.DefaultContentTextColor;
      end;
    cxcsTimeLine:
      begin
        AParams.Color := clWhite;
        AParams.TextColor := clBtnText;
      end;
    cxcsTimeRuler:
      begin
        AParams.Color := Painter.DefaultSchedulerControlColor;
        AParams.TextColor := Painter.DefaultHeaderTextColor;
      end;
  end;
end;

function TcxSchedulerDayViewStyles.GetHeaderContainerParams(
  const ADate: TDateTime; AResource: TcxSchedulerStorageResourceItem;
  ASelected: Boolean): TcxViewParams;
begin
  GetDefaultViewParams(cxcsHeaderContainer + Byte(ASelected), nil, Result);
  CombineParamsWithStyle(GetValue(cxcsHeaderContainer + Byte(ASelected)), [], Result);
end;

function TcxSchedulerDayViewStyles.GetTimeLineParams: TcxViewParams;
begin
  GetDefaultViewParams(cxcsTimeLine, nil, Result);
  CombineParamsWithStyle(TimeLine, [], Result);
  Result.TextColor := Scheduler.OptionsView.DayBorderColor;
  if Result.TextColor = clDefault then
    Result.TextColor := clWindowText;
end;

function TcxSchedulerDayViewStyles.GetTimeRulerParams: TcxViewParams;
begin
  GetDefaultViewParams(cxcsTimeRuler, nil, Result);
  CombineParamsWithStyle(TimeRuler, [], Result);
end;

function TcxSchedulerDayViewStyles.GetPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := TcxSchedulerDayView(GetOwner).LookAndFeelPainter;
end;

//procedures
function cxCompareTime(const ATime1, ATime2: TDateTime): Integer;
begin
  Result := 0;
  if ATime1 < ATime2 then
    Result := -1
  else
    if ATime1 > ATime2 then
      Result := 1;
end;

function cxCompareButtons(AItem1, AItem2: TcxSchedulerMoreEventsButtonViewInfo): Integer;
begin
  Result := Byte(AItem1 <> nil) - Byte(AItem2 <> nil);
  if Result = 0 then
    Result := Byte(not AItem1.IsDown) - Byte(not AItem2.IsDown);
  if Result = 0 then
  begin
    if AItem1.IsDown then
      Result := cxCompareTime(AItem1.DateTime, AItem2.DateTime)
    else
      Result := cxCompareTime(AItem2.DateTime, AItem1.DateTime)
  end;
end;

function cxCompareEventViewInfoOrders(
  AInfo1, AInfo2: TcxSchedulerEventCellViewInfo): Integer;
var
  AAllDay1, AAllDay2: Boolean;
  AEvent1, AEvent2: TcxSchedulerEvent;
begin
  Result := Byte(AInfo2.Visible) - Byte(AInfo1.Visible);
  if Result = 0 then
    Result := Byte(AInfo1.Selected) - Byte(AInfo2.Selected);
  if Result = 0 then
    Result := Byte(AInfo2.Hidden) - Byte(AInfo1.Hidden);
  if Result = 0 then
  begin
    AEvent1 := AInfo1.Event;
    AEvent2 := AInfo2.Event;
    AAllDay1 := AEvent1.AllDayEvent or (AEvent1.Duration >= 1);
    AAllDay2 := AEvent2.AllDayEvent or (AEvent2.Duration >= 1);
    Result := Byte(AAllDay2) - Byte(AAllDay1);
    if Result <> 0 then Exit;
    if AEvent1.Start < AEvent2.Start then
      Result := -1
    else
      if AEvent1.Start > AEvent2.Start then
        Result := 1
      else
        if AEvent1.Finish > AEvent2.Finish then
          Result := -1
        else
          if AEvent1.Finish < AEvent2.Finish then
            Result := 1
          else
            Result := 0;
  end;
end;

{ TcxEventLayoutInfo }

constructor TcxEventLayoutInfo.Create(AEvent: TcxSchedulerControlEvent;
  const ADate: TDateTime; AScale: Integer);
var
  AFinish: Integer;
begin
  Event := AEvent;
  AFinish := Round(TimeOf(Event.Finish) / MinuteToTime);
  StartRow := Round(TimeOf(AEvent.Start) / MinuteToTime) div AScale;
  StopRow := AFinish div AScale;
  if (StopRow <> StartRow) and (AFinish mod AScale = 0) then
    Dec(StopRow);

  if DateOf(Event.Start) <> DateOf(Event.Finish) then
  begin
    if DateOf(ADate) = DateOf(Event.Start) then
      StopRow := 24 * 60 div AScale - 1
    else
      StartRow := 0;
  end;
  IsBreakEvent := (StopRow = 24 * 60 div AScale - 1);
end;

function TcxEventLayoutInfo.ShadowSize: Integer;
begin
  Result := TcxSchedulerPainterHelper.ShadowSize;
end;

procedure TcxEventLayoutInfo.CalculateDisplayRect(
  AWidth, ARowHeight: Integer);
begin
  FDisplayRect := Rect(MulDiv(AWidth, ColStart, ColCount), StartRow * ARowHeight,
    MulDiv(AWidth, ColEnd, ColCount) - ShadowSize, (StopRow + 1) * ARowHeight + Byte(IsBreakEvent));
end;

procedure TcxEventLayoutInfo.CalculateTimes(
  const ADate: TDateTime; AScale: Integer);
begin
  FFinishTime := ADate + (StopRow + 1) * AScale * MinuteToTime;
  FStartTime := ADate + StartRow * AScale * MinuteToTime;
end;

{ TcxCalculateEventLayout }

procedure TcxCalculateEventLayout.Add(AEvent: TcxSchedulerControlEvent);
var
  AEventInfo: TcxEventLayoutInfo;
begin
  AEventInfo := CreateEventInfo(AEvent);
  if AEventInfo <> nil then
    inherited Add(AEventInfo);
end;

procedure TcxCalculateEventLayout.Calculate;
var
  I: Integer;
  AInfo: TcxEventLayoutInfo;
begin
  for I := 0 to Count - 1 do
  begin
    AInfo := Infos[I];
    CalculateColCount(AInfo);
    CalculateColStart(AInfo, I);
    SetColCount(AInfo);
  end;
  // Find ColEnd for events
  for I := 0 to Count - 1 do
    CalculateColEnd(Infos[I]);
  for I := 0 to Count - 1 do
  begin
    AInfo := Infos[I];
    AInfo.CalculateDisplayRect(FWidth, FRowHeight);
    OffsetRect(AInfo.FDisplayRect, Left, Top - Byte(not FViewInfo.HasVisibleBounds));
    AInfo.CalculateTimes(FDate, FTimeScale);
  end;
end;

procedure TcxCalculateEventLayout.Clear;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    Infos[I].Free;
  inherited Clear;
end;

procedure TcxCalculateEventLayout.SetParams(const ADate: TDateTime;
  ATimeScale, ARowHeight: Integer; ALeft, ATop, AWidth: Integer);
begin
  FDate := ADate;
  FTimeScale := ATimeScale;
  FRowHeight := ARowHeight;
  FLeft := ALeft;
  FTop := ATop;
  FWidth := AWidth;
end;

procedure TcxCalculateEventLayout.CalculateColCount(
  AInfo: TcxEventLayoutInfo);
var
  I, J: Integer;
begin
  for I := AInfo.StartRow to AInfo.StopRow do
  begin
    AInfo.ColEnd := 0;
    for J := 0 to Count - 1 do
      if (I >= Infos[J].StartRow) and (I <= Infos[J].StopRow) then
        Inc(AInfo.ColEnd);
    if AInfo.ColCount < AInfo.ColEnd then
      AInfo.ColCount := AInfo.ColEnd;
  end;
end;

procedure TcxCalculateEventLayout.CalculateColEnd(
  AInfo: TcxEventLayoutInfo);
var
  I: Integer;
  AEventInfo: TcxEventLayoutInfo;
begin
  AInfo.ColEnd := AInfo.ColCount;
  for I := 0 to Count - 1 do
  begin
    AEventInfo := Infos[I];
    if (AEventInfo.ColStart > AInfo.ColStart) and
       (AEventInfo.ColStart < AInfo.ColEnd) and Intersect(AInfo, AEventInfo) then
    begin
      AInfo.ColEnd := AEventInfo.ColStart;
      if AInfo.ColEnd = AInfo.ColStart + 1 then Break;
    end;
  end;
end;

procedure TcxCalculateEventLayout.CalculateColStart(
  AInfo: TcxEventLayoutInfo; AIndex: Integer);
var
  I: Integer;
begin
  repeat
    AInfo.ColEnd := AInfo.ColStart;
    for I := AIndex - 1 downto 0 do
      if (Infos[I].ColStart = AInfo.ColStart) and Intersect(Infos[I], AInfo) then
      begin
        Inc(AInfo.ColStart);
        Break;
      end;
  until (AInfo.ColStart = AInfo.ColEnd) or (AInfo.ColStart = (AInfo.ColCount - 1));
end;

function TcxCalculateEventLayout.CreateEventInfo(
  AEvent: TcxSchedulerControlEvent): TcxEventLayoutInfo;
begin
  Result := TcxEventLayoutInfo.Create(AEvent, FDate, FTimeScale);
  with FViewInfo do 
    if HasVisibleBounds and not IsEventVisible(Result.StartRow, Result.StopRow) then
      FreeAndNil(Result);
end;

function TcxCalculateEventLayout.Intersect(
  AInfo1, AInfo2: TcxEventLayoutInfo): Boolean;
begin
  Result := (AInfo1.StartRow <= AInfo2.StopRow) and
    (AInfo2.StartRow <= AInfo1.StopRow);
end;

procedure TcxCalculateEventLayout.SetColCount(
  AInfo: TcxEventLayoutInfo);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    if (Infos[I].ColCount < AInfo.ColCount) and Intersect(Infos[I], AInfo) then
    begin
      Infos[I].ColCount := AInfo.ColCount;
      SetColCount(Infos[I]);
    end;
  end;
end;

function TcxCalculateEventLayout.GetInfo(
  AIndex: Integer): TcxEventLayoutInfo;
begin
  Result := TcxEventLayoutInfo(List^[AIndex]);
end;

{ TcxSchedulerDayView }

constructor TcxSchedulerDayView.Create(AOwner: TcxCustomScheduler);
begin
  inherited Create(AOwner);
  FTimeScale := cxDefaultTimeScale;
  FEventShadows := True;
end;

procedure TcxSchedulerDayView.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerDayView then
  begin
    FEventShadows := TcxSchedulerDayView(Source).FEventShadows; 
    FTimeScale := TcxSchedulerDayView(Source).FTimeScale;
    TimeRulerPopupMenu := TcxSchedulerDayView(Source).TimeRulerPopupMenu;
  end;
  inherited Assign(Source);
end;

procedure TcxSchedulerDayView.MakeWorkTimeVisible;
begin
  if Visible then
    ViewInfo.FTopIndex := (HourOf(WorkStart) * 60 + MinuteOf(WorkStart)) div TimeScale; 
end;

procedure TcxSchedulerDayView.GetProperties(AProperties: TStrings);
begin
  inherited GetProperties(AProperties);
  AProperties.Add('TimeScale')
end;

procedure TcxSchedulerDayView.GetPropertyValue(const AName: string;
  var AValue: Variant);
begin
  inherited GetPropertyValue(AName, AValue);
  if AName = 'TimeScale' then
    AValue := TimeScale;
end;

procedure TcxSchedulerDayView.SetPropertyValue(const AName: string;
  const AValue: Variant);
begin
  inherited SetPropertyValue(AName, AValue);
  if AName = 'TimeScale' then
    TimeScale := AValue;
end;

procedure TcxSchedulerDayView.CreateSubClasses;
begin
  FStyles := CreateStyles;
  inherited CreateSubClasses;
  FTimeRulerPopupMenu := CreateTimeRulerPopupMenu;
end;

procedure TcxSchedulerDayView.DestroySubClasses;
begin
  FTimeRulerPopupMenu.Free;
  inherited DestroySubClasses;
  FStyles.Free;
end;

function TcxSchedulerDayView.CreateController: TcxSchedulerSubControlController;
begin
  Result := TcxSchedulerDayViewController.Create(Self);
end;

function TcxSchedulerDayView.CreateHitTest: TcxSchedulerSubControlHitTest;
begin
  Result := TcxSchedulerDayViewHitTest.Create(Self);
end;

function TcxSchedulerDayView.CreatePainter: TcxSchedulerSubControlPainter;
begin
  Result := TcxSchedulerDayViewPainter.Create(Self);
end;

function TcxSchedulerDayView.CreateStyles: TcxSchedulerDayViewStyles;
begin
  Result := TcxSchedulerDayViewStyles.Create(Self);
end;

function TcxSchedulerDayView.CreateTimeRulerPopupMenu: TcxSchedulerTimeRulerPopupMenu;
begin
  Result := TcxSchedulerTimeRulerPopupMenu.Create(Scheduler);
end;

function TcxSchedulerDayView.CreateViewAdapter: TcxCustomResourceViewAdapter;
begin
  Result := TcxSchedulerDayViewAdapter.Create(Self);
end;

function TcxSchedulerDayView.CreateViewInfo: TcxSchedulerSubControlViewInfo;
begin
  Result := TcxSchedulerDayViewViewInfo.Create(Self);
end;

procedure TcxSchedulerDayView.DoCustomDrawContainer(
  ACell: TcxSchedulerContainerCellViewInfo; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawContainer) then
    FOnCustomDrawContainer(Self, Canvas, ACell, ADone);
end;

procedure TcxSchedulerDayView.DoCustomDrawTimeRuler(
  ACell: TcxSchedulerTimeRulerCellViewInfo; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawTimeRuler) then
    FOnCustomDrawTimeRuler(Self, Canvas, ACell, ADone);
end;

function TcxSchedulerDayView.DoShowPopupMenu(X, Y: Integer): Boolean;
begin
  if HitTest.HitAtTimeRuler then
    Result := TimeRulerPopupMenu.Popup(X, Y)
  else
    Result := inherited DoShowPopupMenu(X, Y);
end;

function TcxSchedulerDayView.EventContentSelected(
  AEvent: TcxSchedulerControlEvent): Boolean;
begin
  Result := AEvent.AllDayEvent or (AEvent.Duration >= 1);
end;

function TcxSchedulerDayView.GetTimeIncrement: TDateTime;
begin
  Result := TimeOf(TimeScale * MinuteToTime);
end;

function TcxSchedulerDayView.IsDayView: Boolean;
begin
  Result := True;
end;

procedure TcxSchedulerDayView.MakeEventVisible(AEvent: TcxSchedulerControlEvent;
  const ADate: TDateTime; AResource: TcxSchedulerStorageResourceItem); 
var
  I, DH: Integer;
  R, R1: TRect;
  AViewInfo: TcxSchedulerEventCellViewInfo;
begin
  // if Event date out of bounds then need scroll
  if Visible and AEvent.AllDayEvent or (AEvent.Duration >= 1) then Exit;
  for I := 0 to 1 do
  begin
    if FindEventViewInfo(AEvent, ADate, AResource, AViewInfo) and
      not AViewInfo.Hidden then
    begin
      if not AViewInfo.Visible then
        DH := ViewInfo.GetTimeRow(AViewInfo.ContentStart, True)
      else
      begin
        DH := 0;
        R := AViewInfo.Bounds;
        R1 := AViewInfo.ClipRect;
        if cxRectIsEqual(R, R1) then Exit;
        if R.Top < R1.Top then
          DH := (R.Top - R1.Top) div ViewInfo.FContentLineHeight
        else
          if (I = 0) and (R.Bottom > R1.Bottom) then
            DH := (R.Bottom - R1.Bottom) div ViewInfo.FContentLineHeight;
        Inc(DH, ViewInfo.FTopIndex);
      end;
      if ViewInfo.FTopIndex <> DH then
      begin
        ViewInfo.FTopIndex := DH;
        LayoutChanged;
      end;
    end;
  end;
end;

procedure TcxSchedulerDayView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = TimeRulerPopupMenu.PopupMenu) then
    TimeRulerPopupMenu.PopupMenu := nil;
end;

procedure TcxSchedulerDayView.ScrollVisibleDays(AScrollUp: Boolean);
begin
  ScrollSelectedDays(Byte(AScrollUp) * 2 - 1);
end;

procedure TcxSchedulerDayView.TimeChanged;
begin
  Invalidate; 
end;

procedure TcxSchedulerDayView.VisibleChanged;
begin
  MakeWorkTimeVisible;
  inherited VisibleChanged;
end;

function TcxSchedulerDayView.GetHitTest: TcxSchedulerDayViewHitTest;
begin
  Result := TcxSchedulerDayViewHitTest(inherited HitTest);
end;

function TcxSchedulerDayView.GetViewInfo: TcxSchedulerDayViewViewInfo;
begin
  Result := TcxSchedulerDayViewViewInfo(inherited ViewInfo)
end;

procedure TcxSchedulerDayView.SetAutoContentHeight(AValue: Boolean);
begin
  if AValue <> FAutoContentHeight then
  begin
    FAutoContentHeight := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerDayView.SetEventShadows(AValue: Boolean);
begin
  if AValue <> FEventShadows then
  begin
    FEventShadows := AValue;
    Changed; 
  end;
end;

procedure TcxSchedulerDayView.SetStyles(AValue: TcxSchedulerDayViewStyles);
begin
  FStyles.Assign(AValue);
end;

procedure TcxSchedulerDayView.SetTimeRulerPopupMenu(
  AValue: TcxSchedulerTimeRulerPopupMenu);
begin
  FTimeRulerPopupMenu.Assign(AValue);
end;

procedure TcxSchedulerDayView.SetTimeScale(
  AValue: Integer);
begin
  AValue := Min(60, Max(5, AValue));
  AValue := 60 div Max(1, 60 div AValue);
  if AValue <> FTimeScale then
  begin
    FTimeScale := AValue;
    MakeWorkTimeVisible;
    Refresh;
  end;
end;

{ TcxSchedulerDayViewAdapter }
  
procedure TcxSchedulerDayViewAdapter.Store;
begin
  FTopIndex := TcxSchedulerDayViewViewInfo(ViewInfo).FTopIndex;
end;

procedure TcxSchedulerDayViewAdapter.Restore;
begin
  TcxSchedulerDayViewViewInfo(ViewInfo).FTopIndex := FTopIndex;
end;

{ TcxSchedulerDayViewViewInfo }

constructor TcxSchedulerDayViewViewInfo.Create(
  AOwner: TcxSchedulerSubControl);
begin
  inherited Create(AOwner);
  FLargeFont := TFont.Create;
  FTimeRulerCells := TcxSchedulerViewInfoCellList.Create;
  FCells.Insert(1, FTimeRulerCells);
end;

destructor TcxSchedulerDayViewViewInfo.Destroy;
begin
  FBackground.Free;
  FLargeFont.Free;
  inherited Destroy;
end;

procedure TcxSchedulerDayViewViewInfo.CalculateHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  inherited CalculateHitTest(AHitTest);
  TimeRulerCells.CalculateHitTest(AHitTest);
end;

procedure TcxSchedulerDayViewViewInfo.InitScrollBarsParameters;
begin
  if (FVisibleRowCount = 0) or (FVisibleRowCount >= FRowCount) or
     (cxRectWidth(Bounds) <= 0) then
    DayView.SetScrollBarInfo(sbVertical, 0, 2, 1, 1, 0, False, True)
  else
    DayView.SetScrollBarInfo(sbVertical, 0, FRowCount - 2, 1,
      FVisibleRowCount, TopIndex, True, True);
end;

procedure TcxSchedulerDayViewViewInfo.ScrollVertical(
  AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
  if not (AScrollCode in [scPosition, scTrack]) then
    AScrollPos := TopIndex;
  case AScrollCode of
    scLineUp:
      Dec(AScrollPos, 1);
    scLineDown:
      Inc(AScrollPos, 1);
    scPageUp:
      Dec(AScrollPos, VisibleRowCount);
    scPageDown:
      Inc(AScrollPos, VisibleRowCount);
    scTop:
      AScrollPos := 0;
    scBottom:
      AScrollPos := FRowCount;
  end;
  if AScrollPos + VisibleRowCount >= (FRowCount - 1) then
    AScrollPos := FRowCount - VisibleRowCount - 1;
  if AScrollPos < 0 then
    AScrollPos := 0;
  if FTopIndex <> AScrollPos then
  begin
    FTopIndex := AScrollPos;
    DayView.LayoutChanged;
    AScrollPos := FTopIndex;
  end;
end;

function TcxSchedulerDayViewViewInfo.AddContentCell(
  const ARect: TRect; const AStart, AFinish: TDateTime;
  AResourceIndex: Integer): TcxSchedulerContentCellViewInfo;
var
  R: TRect;
  P: TcxViewParams;
begin
  R := Bounds;
  R.Top := FContentOffset;
  if cxRectIntersect(R, ARect) then
    P := GetContentParams(AStart, Resources[AResourceIndex])
  else
    FillChar(P, SizeOf(P), 0);
  CreateCellInstance(ContentCellClass, ARect, R, P, Result);
  Result.SetTime(AStart, AFinish);
  AssignResourceID(Result, AResourceIndex);
  ContentCells.Add(Result);
end;

procedure TcxSchedulerDayViewViewInfo.AddContainerCell(
  AColumn: Integer; const ABounds: TRect);
var
  ACell: TcxSchedulerContainerCellViewInfo;
  AParams: TcxViewParams;
  ASelected: Boolean;
  AResource: TcxSchedulerStorageResourceItem;
  ADate: TDateTime;
begin
  ADate := GetColumnDate(AColumn);
  AResource := GetResourceItemByIndex(GetColumnResourceIndex(AColumn));
  ASelected := IsContainerSelected(AResource, ADate);
  AParams := DayView.Styles.GetHeaderContainerParams(ADate, AResource, ASelected);
  CreateCellInstance(TcxSchedulerContainerCellViewInfo, ABounds, AParams, ACell);
  ACell.DateTime := ADate;
  ACell.Selected := ASelected;
  AssignResourceID(ACell, GetColumnResourceIndex(AColumn));
  Inc(AColumn);
  if (AColumn = FColCount) or (HasSeparator and (GroupingKind <> gkNone) and
    (AColumn mod ColumnInGroup = 0)) then
    ACell.Borders := [bBottom]
  else
    ACell.Borders := [bBottom, bRight];
  if HasVisibleBounds and (AColumn = FColCount) then
    ACell.Borders := [bBottom, bRight];
  FHeaderContainerCells.Add(ACell);
end;

procedure TcxSchedulerDayViewViewInfo.AddHeaderContainerEvent(
  AEvent: TcxSchedulerControlEvent;
  AContainer: TcxSchedulerContainerCellViewInfo; AColIndex: Integer);
var
  AHeight, I, J, ATop, ALine: Integer;
  ABounds: TRect;
  ACell: TcxSchedulerEventCellViewInfo;
  ANextContainer: TcxSchedulerContainerCellViewInfo;
begin
  ANextContainer := AContainer;
  ALine := AContainer.LineCount + 1;
  J := AColIndex;
  for I := AColIndex + 1 to ContainerCount - 1 do
    if IsColumnEvent(AEvent, I, True) and (AContainer.Resource = GetColumnResource(I)) then
    begin
      J := I;
      ANextContainer := Containers[I];
      ANextContainer.LineCount := ALine;
    end
    else
      Break;
  AHeight := FHeaderLineHeight + cxTextOffset;
  ATop := Bounds.Top + DayHeaderHeight + FResourceHeaderHeight * Byte(GroupingKind <> gkNone);
  ABounds := Rect(AContainer.Bounds.Left + cxTextOffset * 2,
                  ATop + cxTextOffset + AContainer.LineCount * AHeight,
                  ANextContainer.Bounds.Right - cxTextOffset * 2 - Byte(bRight in ANextContainer.Borders),
                  ATop + (AContainer.LineCount + 1) * AHeight );
  AContainer.LineCount := ALine;
  ACell := AddEventCell(CreateHeaderEventViewData(AEvent, ABounds,
    AContainer.DateTime, ANextContainer.DateTime + 1, AContainer.Resource));
  if not (AEvent.AllDayEvent and AEvent.IsClone) then
    for I := AColIndex to J do
      SetColumnTimeLineStyle(ACell, I);
end;

procedure TcxSchedulerDayViewViewInfo.AddMoreEventsButton(
  const AIndex, ARowIndex: Integer; AIsTop: Boolean);
var
  R: TRect;
begin
  R := Bounds;
  R.Top := FContentOffset;
  R.Right := FHeaderOffsetLeft;
  AddButton(R, ARowIndex / FRowCount, AIndex, not AIsTop)
end;

procedure TcxSchedulerDayViewViewInfo.CalculateBackground;

  procedure CreateBackgroundCell(const ABounds: TRect);
  begin
    if ABounds.Top < ABounds.Bottom then
    begin
      CreateCellInstance(TcxSchedulerBackgroundCellViewInfo, ABounds,
        Styles.GetBackgroundParams, FBackground);
      FBackground.Borders := [bTop];
    end;
  end;

  procedure CreateBackgroundCellSlots(const ABounds: TRect);
  var
    R: TRect;
    AEventIndex, I, J, K: Integer;
    AEvent: TcxSchedulerControlEvent;
    ASlot: TcxSchedulerBackgroundSlotCellViewInfo;
  const
    ABorders: array[Boolean] of TcxBorders = ([bRight, bTop], [bTop]);
  begin
    if ABounds.Top >= ABounds.Bottom then Exit;
    TcxSchedulerTimeRulerCellViewInfo(
      TimeRulerCells[TimeRulerCells.Count - 1]).SetBottom(ABounds.Top);
    for J := -1 to ColCount - 1 do
    begin
      for I := 0 to UnusedRowCount - 1 do
      begin
        R := cxRectSetTop(ABounds, ABounds.Top +
          I * FContentLineHeight, FContentLineHeight);
        if J = -1 then
          R.Right := FHeaderOffsetLeft
        else
          with GetContainer(J) do
            R := cxRectSetLeft(R, Bounds.Left, cxRectWidth(Bounds));
        if J = ColCount - 1 then Dec(R.Right);
        ASlot := AddBackgroundSlot(R, ABorders[J = ColCount - 1], IntToStr(I));
        if J >= 0 then
        begin
          AEventIndex := 0;
          for K := 0 to Events.Count - 1 do
          begin
            AEvent := Events[K];
            if IsColumnEvent(AEvent, J, False) and not IsEventVisible(AEvent) then
            begin
              if AEventIndex = I then
              begin
                ASlot.DisplayText := GetEventSlotDisplayText(AEvent);
                Break;
              end;
              Inc(AEventIndex);
            end;
          end;
        end;
      end;
    end;
  end;

var
  R: TRect;
begin
  FreeAndNil(FBackground);
  if AutoHeight and not HasVisibleBounds then Exit;
  R := Bounds;
  if HasVisibleBounds then
  begin
    R.Top := FContentOffset + (PrintFinishRow - PrintStartRow + 1) * FContentLineHeight;
    CreateBackgroundCellSlots(R);
  end
  else
  begin
    R.Top := FContentOffset + FRowCount * FContentLineHeight;
    CreateBackgroundCell(R);
  end;
end;

procedure TcxSchedulerDayViewViewInfo.CalculateContent;
var
  I, J: Integer;
  ACell: TcxSchedulerContentCellViewInfo;
  AColor: TColor;
  ARect, ABounds: TRect;
  AIndex: Integer;
  AResource: TcxSchedulerStorageResourceItem;
begin
  ABounds := Bounds;
  ABounds.TopLeft := Point(FHeaderOffsetLeft, FContentOffset);
  for I := 0 to FColCount - 1 do
  begin
    AIndex := GetColumnResourceIndex(I);
    AResource := GetResourceItemByIndex(AIndex);
    AColor := StylesAdapter.GetContentParams(GetColumnDate(I), True, AResource).Color;
    ARect := cxRectSetTop(Containers[I].Bounds,
      ABounds.Top - TopIndex * ContentLineHeight, ContentLineHeight);
    if not HasVisibleBounds then
    begin
      if (ColumnInGroup > 1) or ((ColumnInGroup = 1) and (DayView.OptionsView.GroupSeparatorWidth = 0))  then
      begin
        if (I + 1) mod ColumnInGroup <> 0 then
          Dec(ARect.Right, 1);
        if ((I mod ColumnInGroup > 0) or not HasSeparator) then
          Dec(ARect.Left);
      end;
    end;
    for J := 0 to FRowCount - 1 do
    begin
      if IsRowVisible(J) then
      begin
        ACell := AddContentCell(ARect, GetRowTime(I, J), GetRowTime(I, J + 1), AIndex);
        ACell.Borders := []; 
        if I = 0 then
          ACell.TimeLineBorders := [bRight];
        if HasSeparator and (I mod ColumnInGroup = 0) then
          ACell.TimeLineBorders := ACell.TimeLineBorders *
            LookAndFeelPainter.HeaderBorders([nLeft]);
        ACell.ShowTimeLine := True;
        if HasVisibleBounds and (I < (FColCount - 1)) then
          ACell.Borders := [bRight];
        if not HasVisibleBounds or (J <> PrintFinishRow) then
          ACell.Borders := ACell.Borders + [bBottom];
        ACell.BorderColor := PainterHelper.GetSeparatorColor(
          AColor, (J + 1) mod LinePerHour = 0, DayView.IsWorkTime(AResource, ACell.TimeStart));
        ACell.TimeLineParams := DayView.Styles.GetTimeLineParams;
      end;
      OffsetRect(ARect, 0, FContentLineHeight);
    end;
  end;
end;

procedure TcxSchedulerDayViewViewInfo.CalculateEvents;
var
  I: Integer;
  AList: TcxSchedulerEventList;
  AContainer: TcxSchedulerContainerCellViewInfo;
begin
  AList := TcxSchedulerEventList.Create;
  try
    for I := 0 to ContainerCount - 1 do
    begin
      AContainer := Containers[I];
      // for source events
      AList.Clear;
      ExtractEvents(Events, AList, I);
      CalculateEventsForColumn(I, AContainer, AList);
      // for clones
      AList.Clear;
      ExtractEvents(Events.Clones, AList, I);
      CalculateEventsForColumn(I, AContainer, AList);
    end;
  finally
    AList.Free;
  end;
end;

procedure TcxSchedulerDayViewViewInfo.CalculateEventsForColumn(AIndex: Integer;
  AContainer: TcxSchedulerContainerCellViewInfo; AEvents: TcxSchedulerEventList);
var
  I: Integer;
  AViewData: TcxSchedulerEventViewData;
  AInfo: TcxEventLayoutInfo;
begin
  if AEvents.Count = 0 then Exit;
  FEventLayout.Clear;
  I := Byte(((AIndex mod ColumnInGroup <> 0) or not HasSeparator) and not (ColCount = 1));
  FEventLayout.SetParams(DateOf(AContainer.DateTime), TimeScale,
    FContentLineHeight, AContainer.Bounds.Left - I, FContentOffset -
    TopIndex * FContentLineHeight, cxRectWidth(AContainer.Bounds));
  for I := 0 to AEvents.Count - 1 do
    FEventLayout.Add(TcxSchedulerControlEvent(AEvents[I]));
  FEventLayout.Calculate;
  for I := 0 to FEventLayout.Count - 1 do
  begin
    AInfo := FEventLayout.Infos[I];
    CheckEventRowsVisibility(AInfo.Event, AInfo.StartRow, AInfo.StopRow + 1);
    AViewData := CreateContentEventViewData(AInfo, AContainer.Resource);
    if HasVisibleBounds and (FColCount > 1) then
      if (AIndex mod ColumnInGroup > 0) or ((ColumnInGroup = 1) and
      (DayView.OptionsView.GroupSeparatorWidth = 0)) then
        OffsetRect(AViewData.Bounds, 1, 0);
    AViewData.DrawShadows := DayView.EventShadows;
    AddEventCell(AViewData);
  end;
end;

procedure TcxSchedulerDayViewViewInfo.CalculateHeaderEvents;
var
  I, J: Integer;
begin
  for I := 0 to ContainerCount - 1 do
    for J := 0 to Events.AbsoluteCount - 1 do
    begin
      if IsColumnEvent(Events.AbsoluteItems[J], I, True) and ((I = 0) or
         (GetColumnResourceIndex(I) <> GetColumnResourceIndex(I - 1)) or
          not IsColumnEvent(Events.AbsoluteItems[J], I - 1, True)) then
        AddHeaderContainerEvent(Events.AbsoluteItems[J], Containers[I], I);
    end;
end;

procedure TcxSchedulerDayViewViewInfo.CalculateHeaderLineCount;
var
  I, J, ALineCount, ANextLineCount: Integer;
  AEvent: TcxSchedulerControlEvent;
begin
  FHeaderLineCount := 1;
  ANextLineCount := 0;
  for I := 0 to FColCount - 1 do
  begin
    ALineCount := ANextLineCount;
    ANextLineCount := 0;
    for J := 0 to Events.AbsoluteCount - 1 do
    begin
      AEvent := Events.AbsoluteItems[J];
      if IsColumnEvent(AEvent, I, True) then
      begin
        if FHideClones and AEvent.IsClone then
          Continue
        else
        begin
          if (I = 0) or not IsColumnEvent(AEvent, I - 1, True) then
            Inc(ALineCount);
          if  (I < (FColCount - 1)) and IsColumnEvent(AEvent, I + 1, True) then
            ANextLineCount := ALineCount;
        end;
      end;
    end;
    FHeaderLineCount := Max(FHeaderLineCount, ALineCount);
  end;
end;

procedure TcxSchedulerDayViewViewInfo.CalculateHeaders;
var
  I, J, W: Integer;
  AHeaderBounds, AGroupBounds: TRect;
const
  ANeighbors: array[TcxSchedulerGroupingKind, 0..1] of TcxNeighbors =
    (([], []), ([], []), ([nTop], []), ([], [nTop]));
begin
  AGroupBounds := cxRectSetHeight(Bounds, Byte(GroupByResource) * FResourceHeaderHeight +
    Byte(GroupByDate) * DayHeaderHeight);
  AHeaderBounds := cxRectSetTop(Bounds, AGroupBounds.Bottom,
    Byte(GroupByDate) * FResourceHeaderHeight + Byte(not GroupByDate) * DayHeaderHeight);
  W := Bounds.Right - FHeaderOffsetLeft - (GroupCount - 1) * SeparatorWidth;
  for I := 0 to GroupCount - 1 do
  begin
    AGroupBounds.Left := MulDiv(W, I, GroupCount) + FHeaderOffsetLeft + SeparatorWidth * I;
    AGroupBounds.Right := MulDiv(W, I + 1, GroupCount) + FHeaderOffsetLeft + SeparatorWidth * I;
    for J := 0 to ColumnInGroup - 1 do
    begin
      AHeaderBounds.Left := AGroupBounds.Left +
        MulDiv(cxRectWidth(AGroupBounds), J, ColumnInGroup);
      AHeaderBounds.Right := AGroupBounds.Left +
        MulDiv(cxRectWidth(AGroupBounds), J + 1, ColumnInGroup);
      if GroupByDate then
        AddResourceHeader(J, AHeaderBounds).DateTime :=
          GetColumnDate(I * ColumnInGroup + J)
      else
        AddDayHeader(GetColumnDate(I * ColumnInGroup + J), AHeaderBounds,
          GetColumnResourceIndex(I * ColumnInGroup + J));
      AddContainerCell(I * ColumnInGroup + J,
        cxRectSetTop(AHeaderBounds, Bounds.Top, FContentOffset - Bounds.Top));
    end;
    if GroupByResource then
      AddResourceHeader(I, AGroupBounds)
    else
      if GroupByDate then
        AddDayHeader(Days[I], AGroupBounds, -1);
    if HasSeparator then AddGroupVertSeparator(AGroupBounds.Right);
  end;
  ProcessCheckBorders(ResourceHeaderCells, False, ANeighbors[GroupingKind, 0]);
  ProcessDateToDisplayText(True);
  ProcessCheckBorders(DayHeaderCells, False, ANeighbors[GroupingKind, 1]);
end;

procedure TcxSchedulerDayViewViewInfo.CalculateMetrics;

   function GetExtraContentOffset: Integer;
   begin
     Result := FHeaderLineCount * (FContentLineHeight + cxTextOffset) + 1;
     if AutoHeight or (FVisibleRowCount < FRowCount +  FHeaderLineCount) then
       Inc(Result, ContentHeight - FVisibleRowCount * FContentLineHeight);
   end;

begin
  inherited CalculateMetrics;
  FHeaderLineHeight := FContentLineHeight;
  FAdditionalTimeZone := -1;
  FCurrentTimeZone := DayView.OptionsView.CurrentTimeZone;
  if FCurrentTimeZone = -1 then
    FCurrentTimeZone := DayView.DateTimeHelper.CurrentTimeZone;
  if DayView.OptionsView.ShowAdditionalTimeZone then
  begin
    FAdditionalTimeZone := DayView.OptionsView.AdditionalTimeZone;
    if FAdditionalTimeZone = -1 then
      FAdditionalTimeZone := DayView.DateTimeHelper.CurrentTimeZone;
  end;
  FColCount := DayCount;
  if GroupingKind <> gkNone then
    FColCount := FColCount * ResourceCount;
  CalculateHeaderLineCount;
  LargeFont := GetTimeRulerParams.Font;
  CalculateHeaderLineCount;
  if not HasVisibleBounds then
  begin
    FTimeScale := DayView.TimeScale;
    FRowCount := 24 * 60 div TimeScale;
    FContentOffset := DayHeaderHeight + cxTextOffset +
      Byte(GroupingKind <> gkNone) * FResourceHeaderHeight;
  end
  else
    CalculateMetricsForPrinting;
  FVisibleRowCount := Max(1, ContentHeight div FContentLineHeight);
  if HasVisibleBounds then Exit;
  if AutoHeight and (FVisibleRowCount > (FRowCount +  FHeaderLineCount)) then
  begin
    FContentLineHeight := ContentHeight div (FRowCount + FHeaderLineCount);
    FVisibleRowCount := FRowCount + FHeaderLineCount;
  end;
  Inc(FContentOffset, GetExtraContentOffset);
  FVisibleRowCount := Min(FRowCount, Max(1, ContentHeight div FContentLineHeight));
  while (FTopIndex > 0) and ((FTopIndex + FVisibleRowCount) > (FRowCount - 1)) do
    Dec(FTopIndex);
end;

procedure TcxSchedulerDayViewViewInfo.CalculateMetricsForPrinting;
var
  AContentHeight: Integer;
  HeightAdjusted: Boolean;
begin
  FContentOffset := Byte(GroupingKind <> gkNone) *
    FResourceHeaderHeight * Byte(ResourceCount >= 1) +
    FHeaderLineCount * (FHeaderLineHeight + cxTextOffset) + cxTextOffset;
  if (GroupingKind = gkByResource) or (SelectedDays.Count > 1) then
    Inc(FContentOffset, DayHeaderHeight);
  CalculateUnusedRowCount;
  FTimeScale := DayView.TimeScale;
  AContentHeight := Bounds.Bottom - Bounds.Top - FContentOffset;
  HeightAdjusted := AContentHeight < FContentLineHeight;
  while not HeightAdjusted do
  begin
    CalculatePrintRows;
    FTopIndex := PrintStartRow;
    HeightAdjusted := AContentHeight >= FContentLineHeight * PrintRowCount;
    if not HeightAdjusted then
    begin
      if FTimeScale < 60 then
        FTimeScale := FTimeScale * 2
      else
        if UnusedRowCount > 0 then
          Dec(FUnusedRowCount)
        else
          Break;
    end;
  end;
  CalculatePrintRows;
  if HeightAdjusted then
  begin
    FContentLineHeight := AContentHeight div PrintRowCount;
    Inc(FContentOffset, AContentHeight - FContentLineHeight * PrintRowCount);
  end;
end;

procedure TcxSchedulerDayViewViewInfo.CalculatePrintRows;

  function GetTimeRow(ATime: TDateTime; IsFinish: Boolean): Integer;
  begin
    Result := HourOf(ATime) * 60 + MinuteOf(ATime);
    if IsFinish and (Result mod FTimeScale <> 0) then
      Result := Result div FTimeScale + 1
    else
      Result := Result div FTimeScale - Byte(IsFinish);
  end;

begin
  FRowCount := 24 * 60 div FTimeScale;
  FPrintStartRow := GetTimeRow(PrintFrom, False);
  FPrintFinishRow := GetTimeRow(PrintTo, True);
end;

procedure TcxSchedulerDayViewViewInfo.CalculateTimeLine;
var
  ABounds, R: TRect;
  I: Integer;
  AViewParams: TcxViewParams;
  ACommonCell, ARulerCell: TcxSchedulerTimeRulerCellViewInfo;
begin
  R := cxRectSetTop(Bounds, FContentOffset);
  AViewParams := GetTimeRulerParams;
  FHeaderOffsetLeft := R.Left + TcxSchedulerTimeRulerCellViewInfo.CalculateWidth(
    1 + Byte(FAdditionalTimeZone >= 0), LinePerHour, AViewParams.Font, LargeFont);
  R.Right := FHeaderOffsetLeft;
  // add common area
  CreateCellInstance(TcxSchedulerTimeRulerCellViewInfo,
    cxRectSetTop(R, 0, R.Top), AViewParams, ACommonCell);
  ACommonCell.Calculate(DayView.OptionsView.CurrentTimeZoneLabel,
    DayView.OptionsView.AdditionalTimeZoneLabel, FCurrentTimeZone, FAdditionalTimeZone);
  // add ruler cells
  R := cxRectSetTop(R, R.Top - TopIndex * FContentLineHeight,
    LinePerHour * FContentLineHeight);
  ABounds := Bounds;
  ABounds.Top := FContentOffset;
  FTimeRulerCells.Add(ACommonCell);
  for I := 0 to 23 do
  begin
    if IsHourVisible(I) then
    begin
      CreateCellInstance(TcxSchedulerTimeRulerCellViewInfo, R,
        ABounds, AViewParams, ARulerCell);
      ARulerCell.Calculate(I, LinePerHour, FCurrentTimeZone,
        FAdditionalTimeZone, LargeFont);
      FTimeRulerCells.Add(ARulerCell);
    end;
    R := cxRectSetTop(R, R.Bottom);
  end; 
end;

procedure TcxSchedulerDayViewViewInfo.CalculateUnusedRowCount;
var
  I, J: Integer;
  AEvent: TcxSchedulerEvent;
  AColRowCount: Integer;
begin
  FUnusedRowCount := 3;
  for I := 0 to ColCount - 1 do
  begin
    AColRowCount := 0;
    for J := 0 to Events.Count - 1 do
    begin
      AEvent := Events[J];
      if IsColumnEvent(AEvent, I, False) and not IsEventVisible(AEvent) then
        Inc(AColRowCount);
    end;
    FUnusedRowCount := Max(FUnusedRowCount, AColRowCount);
  end;
end;

procedure TcxSchedulerDayViewViewInfo.Clear;
begin
  inherited Clear;
  FTimeRulerCells.Clear;
end;

function TcxSchedulerDayViewViewInfo.CheckDisplayRows(
  var AStartRow, AFinishRow: Integer): Boolean;
begin
  Result := not HasVisibleBounds or ((AStartRow <= PrintFinishRow) and
    (PrintStartRow <= AFinishRow));
  if Result then
  begin
    AStartRow := Max(AStartRow, PrintStartRow);
    AFinishRow := Min(AFinishRow, PrintFinishRow);
  end;
end;

procedure TcxSchedulerDayViewViewInfo.CheckEventRowsVisibility(
  AEvent: TcxSchedulerControlEvent; AStartRow, AFinishRow: Integer);
begin
  if AStartRow < FTopIndex then
    AddMoreEventsButton(-1, AStartRow, True);
  if (AFinishRow > (FTopIndex + VisibleRowCount)) then
  begin
    if AFinishRow < FRowCount then
      AddMoreEventsButton(-1, AFinishRow, False)
    else
      if AStartRow > (FTopIndex + VisibleRowCount) then
        AddMoreEventsButton(-1, AStartRow, False);
  end;
end;

procedure TcxSchedulerDayViewViewInfo.DoCalculate;
begin
  if HasVisibleBounds then Inc(FBounds.Right);
  FEventLayout := CreateEventLayout;
  inherited DoCalculate;
  with DayView.Scheduler do
  begin
    FIsContainerSelected := (GetTimeMinutes(SelFinish) = 0) and
      (GetTimeMinutes(SelStart) = 0);
  end;
  try
    CalculateTimeLine;
    CalculateHeaders;
    CalculateContent;
    CalculateEvents;
    CalculateHeaderEvents;
    CalculateBackground;
  finally
    FEventLayout.Free;
    FButtons.Sort(TListSortCompare(@cxCompareButtons));
    FEventCells.Sort(TListSortCompare(@cxCompareEventViewInfoOrders));
  end;
end;

function TcxSchedulerDayViewViewInfo.CreateContentEventViewData(
  AEventInfo: TcxEventLayoutInfo; AResource: TcxSchedulerResourceViewInfo): TcxSchedulerEventViewData;
begin
  Result := CreateEventViewData(AEventInfo.Event,
    AEventInfo.DisplayRect, AEventInfo.Start, AEventInfo.Finish, AResource);
  Result.VisibleRect.TopLeft := Point(FHeaderOffsetLeft, FContentOffset);
  Result.ShowTimeLine := True;
end;

function TcxSchedulerDayViewViewInfo.CreateHeaderEventViewData(
  AEvent: TcxSchedulerControlEvent; const ABounds: TRect;
  const AStart, AFinish: TDateTime; AResource: TcxSchedulerResourceViewInfo): TcxSchedulerEventViewData;
begin
  Result := CreateEventViewData(AEvent, ABounds, AStart, AFinish, AResource);
  Result.VisibleRect := cxRect(FHeaderOffsetLeft, DayHeaderHeight,
    Bounds.Right, FContentOffset);
  Result.ShowTimeLine := False;
end;

function TcxSchedulerDayViewViewInfo.CreateEventLayout: TcxCalculateEventLayout;
begin
  Result := TcxCalculateEventLayout.Create;
  Result.FViewInfo := Self;
end;

procedure TcxSchedulerDayViewViewInfo.ExtractEvents(
  ASource, ADest: TcxSchedulerEventList; AIndex: Integer);
var
  I: Integer;
begin
  for I := 0 to ASource.Count - 1 do
    if IsColumnEvent(ASource[I], AIndex, False) then
      ADest.Add(ASource[I]);
end;

function TcxSchedulerDayViewViewInfo.GetContentParams(const ATime: TDateTime;
  AResource: TcxSchedulerResourceViewInfo): TcxViewParams;
begin
  Result := inherited GetContentParams(ATime, AResource);
  if not HiddenSelection and not FIsContainerSelected and IsTimeSelected(ATime, AResource) then
    Result := GetSelectionParams(Result);
end;

function TcxSchedulerDayViewViewInfo.GetColumnDate(
  AIndex: Integer): TDateTime;
begin
  if GroupingKind = gkByDate then
    AIndex := AIndex div ResourceCount
  else
    if GroupingKind = gkByResource then
      AIndex := AIndex mod DayCount;
  Result := Days[AIndex];
end;

function TcxSchedulerDayViewViewInfo.GetColumnResource(
  AIndex: Integer): TcxSchedulerResourceViewInfo;
begin
  Result := Resources[GetColumnResourceIndex(AIndex)];
end;

function TcxSchedulerDayViewViewInfo.GetColumnResourceIndex(
  AIndex: Integer): Integer;
begin
  Result := -1;
  if ResourceCount > 0 then
  begin
    if GroupingKind = gkByDate then
      Result := AIndex mod ResourceCount
    else
      if GroupingKind = gkByResource then
        Result := AIndex div DayCount;
  end;
end;

function TcxSchedulerDayViewViewInfo.GetContainer(
  AIndex: Integer): TcxSchedulerContainerCellViewInfo;
begin
  Result := TcxSchedulerContainerCellViewInfo(HeaderContainerCells[AIndex]);
end;

function TcxSchedulerDayViewViewInfo.GetContainerCount: Integer;
begin
  Result := HeaderContainerCells.Count;
end;

function TcxSchedulerDayViewViewInfo.GetDayHeaderHeight: Integer;
begin
  Result := inherited GetDayHeaderHeight;
  if (SelectedDays.Count = 1) and HasVisibleBounds and (GroupingKind <> gkByResource) then
    Result := 0;
end;

function TcxSchedulerDayViewViewInfo.GetEventSlotDisplayText(
  AEvent: TcxSchedulerControlEvent): string;
begin
  Result := DoGetEventDisplayText(AEvent);
  with DateTimeHelper do
  begin
    Result := TimeToStr(AEvent.Start) + '-' +
      TimeToStr(AEvent.Finish) + ' ' + Result;
  end;
end;

function TcxSchedulerDayViewViewInfo.GetTimeLineParams: TcxViewParams;
begin
  Result := DayView.Styles.GetTimeLineParams;
end;

function TcxSchedulerDayViewViewInfo.GetTimeRulerParams: TcxViewParams;
var
  AIntf: IcxSchedulerTimeRulerParams;
begin
  if Supports(StylesAdapter, IcxSchedulerTimeRulerParams, AIntf) then
    Result := AIntf.GetTimeRulerParams
  else
    Result := DayView.Styles.GetTimeRulerParams;
end;

function TcxSchedulerDayViewViewInfo.GetTimeRow(
  const ATime: TDateTime; AIsStart: Boolean): Integer;
var
  ACount: Double;
begin
  ACount := Min(FRowCount - 1,
    TimeOf(ATime) / MinuteToTime / TimeScale);
  Result := Round(ACount);
  if not AIsStart and (TimeOf(ACount) = 0) then
    Dec(Result);
end;

function TcxSchedulerDayViewViewInfo.GetRowTime(
  AColumn, ARow: Integer): TDateTime;
begin
  Result := GetColumnDate(AColumn) + (ARow * TimeScale) * MinuteToTime;
end;

function TcxSchedulerDayViewViewInfo.IsColumnEvent(AEvent: TcxSchedulerEvent;
  AIndex: Integer; IsHeaderEvent: Boolean): Boolean;
begin
  Result := AEvent.IsDayEvent(GetColumnDate(AIndex)) and
    (IsHeaderEvent = (AEvent.AllDayEvent or (AEvent.Duration >= 1)));
  if Result then
    Result := AEvent.IsResourceEvent(GetResourceItemByIndex(
      GetColumnResourceIndex(AIndex)), ShowEventsWithoutResource);
end;

function TcxSchedulerDayViewViewInfo.IsContainerSelected(
  AResource: TcxSchedulerStorageResourceItem; ADate: TDateTime): Boolean;
begin
  Result := False;
  with DayView.Scheduler do
  begin
    if SelectedEventCount > 0 then Exit;
    if (AResource = SelResource) and (DateOf(ADate + 1) <= DateOf(SelFinish)) then
    begin
      if DateOf(ADate) > DateOf(SelStart) then
        Result := True
      else
        Result := (DateOf(ADate) = DateOf(SelStart)) and
          (GetTimeMinutes(SelStart) = 0);
    end;
  end;
  Result := Result and CanSelected;
end;

function TcxSchedulerDayViewViewInfo.IsEventVisible(
  AEvent: TcxSchedulerEvent): Boolean;
begin
  Result := (TimeOf(AEvent.Start) <= PrintTo) and (TimeOf(AEvent.Finish) >= PrintFrom);
end;

function TcxSchedulerDayViewViewInfo.IsEventVisible(
  var AStartRow, AStopRow: Integer): Boolean;
begin
  Result := (AStopRow >= PrintStartRow) and (AStartRow <= PrintFinishRow);
  if Result then
  begin
    AStopRow := Min(PrintFinishRow, AStopRow);
    AStartRow := Max(PrintStartRow, AStartRow);
  end;
end;

function TcxSchedulerDayViewViewInfo.IsHourVisible(AIndex: Integer): Boolean;
begin
  Result := not HasVisibleBounds or ((PrintStartRow div LinePerHour <= AIndex) and
    (AIndex <= PrintFinishRow div LinePerHour));
end;

function TcxSchedulerDayViewViewInfo.IsRowVisible(AIndex: Integer): Boolean;
begin
  Result := not HasVisibleBounds or
    ((AIndex >= PrintStartRow) and (AIndex <= PrintFinishRow));
end;

procedure TcxSchedulerDayViewViewInfo.MakeTimeVisible(
  const ATime: TDateTime);
var
  ARow: Integer;
begin
  ARow := GetTimeRow(ATime, True);
  if (ARow < FTopIndex) or (ARow >= (FTopIndex + VisibleRowCount)) then
  begin
    if ARow < FTopIndex then
      FTopIndex := ARow
    else
      FTopIndex := Max(0, (ARow + 1) - VisibleRowCount);
  end;
end;

procedure TcxSchedulerDayViewViewInfo.OnClickMoreButton(
  Sender: TcxSchedulerMoreEventsButtonViewInfo);
var
  ARow: Integer;
begin
  ARow := Min(FRowCount, Max(0, Round(Sender.DateTime * FRowCount)));
  if not Sender.IsDown then
    FTopIndex := ARow
  else
    FTopIndex := Max(0, ARow - VisibleRowCount);
  View.LayoutChanged;
end;

procedure TcxSchedulerDayViewViewInfo.SetColumnTimeLineStyle(
  AViewInfo: TcxSchedulerEventCellViewInfo; AColIndex: Integer);
var
  ACell: TcxSchedulerContentCellViewInfo;
  I, AOffset, StartRow, StopRow, ACount: Integer;
begin
  if AViewInfo.Event.Start <= GetColumnDate(AColIndex) then
    StartRow := 0
  else
    StartRow := GetTimeRow(AViewInfo.Event.Start, True);
  if (AViewInfo.Event.Finish - 1) >= GetColumnDate(AColIndex) then
    StopRow := FRowCount - 1
  else
    StopRow := GetTimeRow(AViewInfo.Event.Finish, False);
  AOffset := 0;
  if HasVisibleBounds then
  begin
    ACount := PrintFinishRow - PrintStartRow + 1;
    if (StartRow > PrintFinishRow) or (StopRow < PrintStartRow) then Exit;
    StartRow := Max(0, StartRow - PrintStartRow);
    StopRow := Min(PrintFinishRow - StartRow, StopRow - PrintStartRow);
    AOffset := PrintStartRow;
  end
  else
    ACount := FRowCount;
  Inc(StartRow, AColIndex * ACount);
  Inc(StopRow, AColIndex * ACount);
  Dec(AOffset, AColIndex * ACount);
  for I := StartRow to StopRow do
  begin
    if not IsRowVisible(I + AOffset) then Continue;
    ACell := TcxSchedulerContentCellViewInfo(ContentCells[I]);
    if ACell.TimeEvent = nil then
      ACell.TimeEvent := AViewInfo;
  end;
end;

function TcxSchedulerDayViewViewInfo.GetAutoHeight: Boolean;
begin
  Result := DayView.AutoContentHeight or HasVisibleBounds;
end;

function TcxSchedulerDayViewViewInfo.GetColumnInGroup: Integer;
begin
  Result := DayCount;
  if GroupingKind = gkByDate then
    Result := ResourceCount;
end;

function TcxSchedulerDayViewViewInfo.GetContentHeight: Integer;
begin
  Result := Bounds.Bottom - FContentOffset;
end;

function TcxSchedulerDayViewViewInfo.GetDayView: TcxSchedulerDayView;
begin
  Result := TcxSchedulerDayView(Owner);
end;

function TcxSchedulerDayViewViewInfo.GetGroupCount: Integer;
begin
  if GroupingKind = gkByDate then
    Result := DayCount
  else
    if GroupingKind = gkByResource then
      Result := ResourceCount
    else
      Result := 1;
end;

function TcxSchedulerDayViewViewInfo.GetPrintRowCount: Integer;
begin
  Result := FPrintFinishRow - FPrintStartRow + UnusedRowCount + 1;
end;

function TcxSchedulerDayViewViewInfo.GetLinePerHour: Integer;
begin
  Result := 60 div TimeScale;
end;

procedure TcxSchedulerDayViewViewInfo.SetLargeFont(AFont: TFont);
begin
  FLargeFont.Assign(AFont);
  FLargeFont.Size := AFont.Size * 2;
end;

{ TcxSchedulerDayViewHitTest }

function TcxSchedulerDayViewHitTest.GetContainerCell: TcxSchedulerContainerCellViewInfo;
begin
  if HitAtContainer then
    Result := TcxSchedulerContainerCellViewInfo(FHitObject)
  else
    Result := nil;
end;

function TcxSchedulerDayViewHitTest.GetTimeRulerCell: TcxSchedulerTimeRulerCellViewInfo;
begin
  if HitAtTimeRuler then
    Result := TcxSchedulerTimeRulerCellViewInfo(FHitObject)
  else
    Result := nil;
end;

{ TcxDayViewDragEventHelper }

function TcxDayViewDragEventHelper.GetOriginHitTestMask: Int64;
const
  Mask = (1 shl htcControl) or (1 shl htcDayHeader) or (1 shl htcTimeRuler)
    or (1 shl htcContainer) or (1 shl htcContent);
begin
  Result := Mask;
end;

procedure TcxDayViewDragEventHelper.GetOriginState;
begin
  inherited GetOriginState;
  FStartInHeader := FStartHitFlags and (1 shl htcContainer) <> 0;
end;

function TcxDayViewDragEventHelper.InHeader: Boolean;
begin
  with HitTest do
    Result := HitAtDayHeader or HitAtContainer;
end;

function TcxDayViewDragEventHelper.IsAtOrigin: Boolean;
begin
  Result := inherited IsAtOrigin or
    ((FStartInHeader and InHeader) and (Controller.StartDragHitTime = HitTest.Time) and
    ((FStartResource = nil) or (FStartResource = HitTest.Resource)));
end;

procedure TcxDayViewDragEventHelper.SetCloneEventsTimeDelta(AStart, ACurrent: TDateTime;
  AInHeader: Boolean);
var
  I: Integer;
  ADelta: TDateTime;
begin
  for I := 0 to Clones.Count - 1 do
  begin
    with Clones[I] do
    begin
      AllDayEvent := AInHeader;
      if AInHeader then
      begin
        ADelta := DateOf(AStart) - DateOf(ACurrent);
        if not IsHeaderEvent(Source) then
          Duration := 1
        else
          Duration := Source.Duration;
        MoveTo(DateOf(Source.Start) - ADelta);
      end
      else
        if not IsHeaderEvent(Source) then
        begin
          Duration := Source.Duration;
          MoveTo(Source.Start - (AStart - ACurrent));
        end
        else
        begin
          Duration := cxHalfHour;
          MoveTo(ACurrent);
        end;
    end;
  end;
end;

procedure TcxDayViewDragEventHelper.UpdateClonesTime;
begin
  with HitTest do
  begin
    if HitAtTimeRuler then
      // correct event's times
      SetCloneEventsTimeDelta(Controller.StartDragHitTime,
        DateOf(Controller.StartDragHitTime) + Time, False)
    else
      SetCloneEventsTimeDelta(Controller.StartDragHitTime, Time, InHeader);
  end;
end;

procedure TcxDayViewDragEventHelper.UpdateEventProperties;
begin
  inherited UpdateEventProperties;
  UpdateEventStates;
end;

procedure TcxDayViewDragEventHelper.UpdateEventStates;
const
  States: array[Boolean] of Byte = (tlsBusy, tlsFree);
var
  I: Integer;
  AEvent: TcxSchedulerControlEvent;
begin
  for I := 0 to Clones.Count - 1 do
  begin
    AEvent := Clones[I];
    if (AEvent.AllDayEvent <> AEvent.Source.AllDayEvent) and
       ((AEvent.AllDayEvent and (AEvent.Source.State = tlsBusy)) or
        (not AEvent.AllDayEvent and (AEvent.Source.State = tlsFree))) then
      AEvent.State := States[AEvent.AllDayEvent];
  end;
end;

function TcxDayViewDragEventHelper.GetController: TcxSchedulerDayViewController;
begin
  Result := TcxSchedulerDayViewController(inherited Controller);
end;

function TcxDayViewDragEventHelper.GetHitTest: TcxSchedulerDayViewHitTest;
begin
  Result := TcxSchedulerDayViewHitTest(inherited HitTest);
end;

{ TcxDayViewEventSizing }

function TcxDayViewEventSizing.GetDragCursor(Accepted: Boolean): TCursor;
const
  Cursors: array[Boolean] of TCursor = (crSchedulerVertResize,
    crSchedulerHorzResize);
begin
  Result := Cursors[IsHeaderEvent(Event) and HitTest.HitAtContainer];
end;

function TcxDayViewEventSizing.GetOriginHitTestMask: Int64;
const
  Mask = (1 shl htcControl) or (1 shl htcDayHeader) or (1 shl htcTimeRuler)
    or (1 shl htcContainer) or (1 shl htcContent);
begin
  Result := Mask;
end;

procedure TcxDayViewEventSizing.CalcAllDayEvent;
begin
  with Event do
  begin
    AllDayEvent := (HitTest.HitAtContainer or (TimeOf(GetSizingTime) = 0)) and
      (Source.AllDayEvent or (TimeOf(FFixedBoundTime) = 0));
    if Controller.DragKind = edkResizeStart then
      Finish := FFixedBoundTime
    else
      Start := FFixedBoundTime;
  end;
end;

function TcxDayViewEventSizing.GetFinishTime: TDateTime;
begin
  Result := HitTest.Time;
  if HitTest.HitAtTimeRuler then
    Result := Result + DateOf(Event.Finish)
  else
    if HitTest.HitAtContent then
      Result := Result +
        TcxSchedulerDayView(Scheduler.CurrentView).TimeScale * MinuteToTime
    else
      if (Controller.DragKind = edkResizeEnd) and not Event.AllDayEvent and
        HitTest.HitAtContainer and (TimeOf(Result) = 0) then Result := Result + 1;
end;

procedure TcxDayViewEventSizing.GetOriginState;
begin
  inherited GetOriginState;
  with Event do
  begin
    if Controller.DragKind = edkResizeStart then
      FFixedBoundTime := Finish
    else
      FFixedBoundTime := Start;
  end;
end;

function TcxDayViewEventSizing.GetSizingTime: TDateTime;
begin
  if Controller.DragKind = edkResizeStart then
    Result := GetStartTime
  else
    Result := GetFinishTime;
end;

function TcxDayViewEventSizing.GetStartTime: TDateTime;
begin
  Result := HitTest.Time;
  if HitTest.HitAtTimeRuler then
    Result := Result + DateOf(Event.Start);
end;

function TcxDayViewEventSizing.GetController: TcxSchedulerDayViewController;
begin
  Result := TcxSchedulerDayViewController(inherited Controller);
end;

function TcxDayViewEventSizing.GetHitTest: TcxSchedulerDayViewHitTest;
begin
  Result := TcxSchedulerDayViewHitTest(inherited HitTest);
end;

{ TcxSchedulerDayNavigation }

procedure TcxSchedulerDayNavigation.KeyDown(
  var AKey: Word; AShift: TShiftState);
var
  ATime, ATimeDelta: TDateTime;
begin
  FSelRow := GetTimeRow(FCurrentAnchor);
  ATime := DateOf(FCurrentAnchor);
  ATimeDelta := 0;
  case AKey of
    VK_UP:
    begin
      if FSelRow = 0 then
        Exit
      else
        ATimeDelta := GetRowTime(FSelRow - 1);
    end;
    VK_DOWN:
    begin
      if FSelRow >= ViewInfo.FRowCount - 1 then
        Exit
      else
        ATimeDelta := GetRowTime(FSelRow + 1);
    end;
    VK_HOME:
      if not (ssCtrl in AShift) then
        ATimeDelta := TimeOf(DayView.WorkStart);
    VK_END:
    begin
      if ssCtrl in AShift then
        ATimeDelta := 1 - DayView.GetTimeIncrement
      else
        ATimeDelta := TimeOf(DayView.WorkFinish) - DayView.GetTimeIncrement;
    end;
    VK_LEFT, VK_RIGHT:
    begin
      DoNextColumn(AKey = VK_RIGHT, GetColumnByDate(ATime, ResourceObject),
        ATime, FCurrentResource);
      Exit;
    end; 
    VK_NEXT, VK_PRIOR:
      if not DoNextPage(AKey = VK_NEXT, ATime, FCurrentResource) then Exit;
  end;
  ATime := ATime + ATimeDelta;
  ViewInfo.MakeTimeVisible(ATime);
  SetSelAnchor(ATime, AShift, FCurrentResource);
end;

procedure TcxSchedulerDayNavigation.ValidateSelection(var ASelStart,
  ASelFinish: TDateTime; var AResource: TcxSchedulerStorageResourceItem);
var
  I: Integer; 
  AStart, AFinish, ADate: TDateTime;
begin
  inherited ValidateSelection(ASelStart, ASelFinish, AResource);
  AStart := DateOf(Min(ASelFinish, ASelStart));
  AFinish := DateOf(Max(ASelFinish, ASelStart));
  for I := 0 to ViewInfo.DayCount - 1 do
  begin
    ADate := ViewInfo.Days[I];
    if (ADate >= AStart) and (ADate <= AFinish) then Exit
  end;
  ASelFinish := GetColumnDate(0) + TimeOf(ASelFinish);
  ASelStart := ASelFinish;
end;

function TcxSchedulerDayNavigation.ColCount: Integer;
begin
  Result := ViewInfo.ColCount;
end;

procedure TcxSchedulerDayNavigation.DoNextColumn(AGoToNext: Boolean; AColumn: Integer;
  const ATime: TDateTime; AResource: TcxSchedulerStorageResourceItem);
const
  AColInc: array[Boolean] of Integer = (-1, 1);
begin
  if (AGoToNext and (AColumn = ColCount - 1)) or
     (not AGoToNext and (AColumn = 0)) then
  begin
    DayView.ScrollVisibleDays(not AGoToNext);
    ReplaceDate(ATime + AColInc[AGoToNext], GetColumnResource(AColumn));
  end
  else
  begin
    Inc(AColumn, AColInc[AGoToNext]);
    if (AResource <> GetColumnResource(AColumn)) then
      ReplaceDate(GetColumnDate(AColumn), GetColumnResource(AColumn))
    else
      if not (ssShift in FShift) then
        ReplaceDate(GetColumnDate(AColumn), GetColumnResource(AColumn))
      else
        SetSelAnchor(GetColumnDate(AColumn) + TimeOf(FCurrentAnchor), FShift, AResource);
  end;
end;

function TcxSchedulerDayNavigation.DoNextPage(AGoForward: Boolean;
  var ATime: TDateTime; var AResource: TcxSchedulerStorageResourceItem): Boolean;
var
  ARow: Integer;
begin
  if AGoForward then
    Result := FSelRow < (ViewInfo.FRowCount - 1)
  else
    Result := FSelRow > 0;
  if Result then
  begin
    if AGoForward then
    begin
      ARow := Min(FSelRow + ViewInfo.VisibleRowCount, ViewInfo.FRowCount - 1);
      ViewInfo.FTopIndex := Min(ViewInfo.FTopIndex + ViewInfo.VisibleRowCount,
        ViewInfo.FRowCount - 1)
    end
    else
    begin
      ARow := Max(0, FSelRow - ViewInfo.VisibleRowCount);
      ViewInfo.FTopIndex := Max(0, ViewInfo.FTopIndex - ViewInfo.VisibleRowCount);
    end;
    ATime := ATime + GetRowTime(ARow);
  end;
end;

function TcxSchedulerDayNavigation.GetColumnByDate(
  const ADate: TDateTime; AResource: TObject): Integer;
begin
  for Result := 0 to ViewInfo.ColCount - 1 do
    with ViewInfo do
    begin
      if (GetColumnDate(Result) >= DateOf(ADate)) and
        (GetColumnResource(Result) = AResource) then Exit;
    end;
  Result := 0;
end;

function TcxSchedulerDayNavigation.GetColumnDate(AColumn: Integer): TDateTime;
begin
  Result := ViewInfo.GetColumnDate(AColumn);
end;

function TcxSchedulerDayNavigation.GetColumnResource(
  AColumn: Integer): TcxSchedulerStorageResourceItem;
begin
  Result := GetResourceFromViewInfo(ViewInfo.Containers[AColumn].Resource);
end;

function TcxSchedulerDayNavigation.GetRowTime(
  const ARow: Integer; AFinish: Boolean = False): TDateTime;
begin
  Result := RoundTime((ARow + Byte(AFinish)) * DayView.TimeScale * MinuteToTime);
end;

function TcxSchedulerDayNavigation.GetTimeRow(const ATime: TDateTime): Integer;
begin
  Result := ViewInfo.GetTimeRow(ATime, True);
end;

function TcxSchedulerDayNavigation.GetDayView: TcxSchedulerDayView;
begin
  Result := ViewInfo.DayView;
end;

function TcxSchedulerDayNavigation.GetSelectedDays: TcxSchedulerDateList;
begin
  Result := ViewInfo.SelectedDays;
end;

function TcxSchedulerDayNavigation.GetViewInfo: TcxSchedulerDayViewViewInfo;
begin
  Result := TcxSchedulerDayViewViewInfo(inherited ViewInfo);
end;

{ TcxSchedulerDayViewController }

constructor TcxSchedulerDayViewController.Create(
  AOwner: TcxSchedulerSubControl);
begin
  inherited Create(AOwner);
  FTimer := TTimer.Create(nil);
end;

destructor TcxSchedulerDayViewController.Destroy;
begin
  FTimer.Free;
  inherited Destroy;
end;

procedure TcxSchedulerDayViewController.BeforeMouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FIsEditingBeforeMouseDown := IsEditing;
  inherited BeforeMouseDown(Button, Shift, X, Y);
  if HitTest.HitAtTimeRuler then
    HitTest.SetHitTime(htcTime, TimeOf(HitTest.Time) + DateOf(DateOf(Navigation.SelAnchor)));
end;

procedure TcxSchedulerDayViewController.CancelScroll;
begin
  InitTimer(False, scEndScroll);
end;

procedure TcxSchedulerDayViewController.CheckScrolling(const APos: TPoint);
var
  ACanScroll: Boolean;
  AScrollCode: TScrollCode;
  R: TRect;
begin
  R := ViewInfo.Bounds;
  R.Top := ViewInfo.FContentOffset;
  FPos := APos;
  ACanScroll := cxRectPtIn(R, APos);
  AScrollCode := TScrollCode(FTimer.Tag);
  if (APos.Y >= R.Top) and (APos.Y < (R.Top + cxScrollZoneSize)) then
    AScrollCode := scLineUp
  else
    if (APos.Y < R.Bottom) and (APos.Y >= (R.Bottom - cxScrollZoneSize)) then
      AScrollCode := scLineDown
    else
      ACanScroll := False;
  if (ACanScroll <> FTimer.Enabled) or (Integer(AScrollCode) <> FTimer.Tag) then
    InitTimer(ACanScroll, AScrollCode);
end;

procedure TcxSchedulerDayViewController.CheckTimeRulerTime;
begin
  if HitTest.HitAtTime and HitTest.HitAtTimeRuler and (DragEventHelper = nil) then
    HitTest.SetHitTime(htcTime, DateOf(Navigation.SelAnchor) + TimeOf(HitTest.Time));
end;

function TcxSchedulerDayViewController.CreateDragEventHelper: TcxDragEventHelper;
begin
  Result := TcxDayViewDragEventHelper.Create(Scheduler);
end;

function TcxSchedulerDayViewController.CreateNavigation: TcxSchedulerViewNavigation;
begin
  Result := TcxSchedulerDayNavigation.Create(View);
end;

function TcxSchedulerDayViewController.CreateResizeEventHelper: TcxEventSizingHelper;
begin
  Result := TcxDayViewEventSizing.Create(Scheduler);
end;

procedure TcxSchedulerDayViewController.InitTimer(
  AllowStart: Boolean; AScrollCode: TScrollCode);
begin
  if AllowStart and FIsEditingBeforeMouseDown then
  begin
    FIsEditingBeforeMouseDown := False;
    AllowStart := False;
  end;
  if not AllowStart then
    FTimer.OnTimer := nil
  else
    FTimer.OnTimer := OnTimer;
  FTimer.Enabled := AllowStart;
  FTimer.Interval := cxScrollInterval;
  FTimer.Tag := Integer(AScrollCode);
end;

procedure TcxSchedulerDayViewController.MouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and (DragKind in [edkNone]) and HitTest.HitAtContainer and
   not HitTest.HitAtDayHeader and not HitTest.HitAtEvent then
  begin
    CloseInplaceEdit;
    UnselectEvents;
    with HitTest.ContainerCell do
    begin
      Navigation.ReplaceSelParams(DateTime, DateTime + 1 - Navigation.TimeIncrement, HitTest.Resource);
      FStartSelAnchor := DateTime - Navigation.TimeIncrement;
    end;
    if (Shift = [ssLeft, ssDouble]) and CanCreateEventUsingDialog then
      Scheduler.CreateEventUsingDialog
    else
      View.Refresh;
  end
  else
  begin
    if HitTest.HitAtTimeRuler then
      HitTest.SetHitTime(htcTime, TimeOf(HitTest.Time) + DateOf(DateOf(Navigation.SelAnchor)));
    inherited MouseDown(Button, Shift, X, Y);
  end;
end;

procedure TcxSchedulerDayViewController.MouseMove(
  Shift: TShiftState; X, Y: Integer);
var
  AStart, AFinish: TDateTime;
begin
  CheckTimeRulerTime;
  if (ssLeft in Shift) and (DragKind in [edkNone]) and HitTest.HitAtContainer and
   not HitTest.HitAtDayHeader then
  begin
    InitTimer(False, scEndScroll);
    AStart := DateOf(Navigation.SelRealStart);
    AFinish := HitTest.ContainerCell.DateTime;
    HitTest.SetBitState(htcTime, False);
    HitTest.SetBitState(htcContainer, False);
    if Navigation.SelResource = HitTest.Resource then
    begin
      if AFinish >= AStart then
        Navigation.ReplaceSelParams(AStart, AFinish + 1 - Navigation.TimeIncrement)
      else
        Navigation.ReplaceSelParams(AStart + 1 - Navigation.TimeIncrement, AFinish);
    end
    else
      Navigation.ReplaceSelParams(AStart, AStart + 1 - Navigation.TimeIncrement,
        Navigation.SelResource);
    View.Refresh;
    Exit;
  end;
  inherited MouseMove(Shift, X, Y);
  if not (ssLeft in Shift) then Exit;
  if ssLeft in Shift then
    CheckScrolling(cxPoint(X, Y))
  else
    CancelScroll;
end;

procedure TcxSchedulerDayViewController.MouseUp(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CancelScroll;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TcxSchedulerDayViewController.OnTimer(Sender: TObject);

  function GetShiftState: TShiftState;
  const
    Buttons: array[Boolean] of Integer = (VK_LBUTTON, VK_RBUTTON);
  begin
    Result := [];
    if GetAsyncKeyState(Buttons[GetSystemMetrics(SM_SWAPBUTTON) <> 0]) < 0 then
      Include(Result, ssLeft);
    if GetAsyncKeyState(VK_CONTROL) < 0 then
      Include(Result, ssCtrl);
  end;

var
  APos: Integer;
  AShift: TShiftState;
begin
  AShift := GetShiftState;
  if not (ssLeft in AShift) then
  begin
    CancelScroll;
    SetCaptureControl(nil);
  end
  else
  begin
    APos := ViewInfo.FTopIndex;
    ViewInfo.ScrollVertical(TScrollCode(FTimer.Tag), APos);
    MouseMove(AShift, FPos.X, FPos.Y);
    if (DragKind in [edkResizeStart, edkResizeEnd]) then
      CheckUpdateEventBounds;
  end;
end;

procedure TcxSchedulerDayViewController.CheckUpdateEventBounds;
var
  ASizingHelper: TcxEventSizingHelper;
begin
  if (Scheduler.DragAndDropState = ddsInProcess) and
     (Scheduler.DragAndDropObject is TcxSchedulerDragAndDropObject) then
  begin
    ASizingHelper := TcxSchedulerDragAndDropObject(Scheduler.DragAndDropObject).SizingHelper;
    if ASizingHelper is TcxDayViewEventSizing then
      TcxDayViewEventSizing(ASizingHelper).UpdateEventBounds;
  end;
end;

function TcxSchedulerDayViewController.GetHitTest: TcxSchedulerDayViewHitTest;
begin
  Result := TcxSchedulerDayView(View).HitTest;
end;

function TcxSchedulerDayViewController.GetViewInfo: TcxSchedulerDayViewViewInfo;
begin
  Result := TcxSchedulerDayView(View).ViewInfo;
end;

{ TcxSchedulerDayViewPainter }

procedure TcxSchedulerDayViewPainter.Paint;
begin
  inherited Paint;
  ViewInfo.ContentCells.Draw(Canvas, DrawContentCell);
  ViewInfo.HeaderContainerCells.Draw(Canvas, DrawContainerCell);
  ViewInfo.EventCells.Draw(Canvas, DrawDayViewEventCell);
  ViewInfo.ResourceHeaderCells.Draw(Canvas, DrawResourceHeaderCell);
  ViewInfo.GroupSeparatorCells.Draw(Canvas, DrawGroupSeparatorCell);
  ViewInfo.DayHeaderCells.Draw(Canvas, DrawHeaderCell);
  ViewInfo.TimeRulerCells.Draw(Canvas, DrawTimeRulerCell);
  ViewInfo.Buttons.Draw(Canvas, DrawButtonCell);
  DrawBackgroundCell(ViewInfo.Background);
end;

procedure TcxSchedulerDayViewPainter.DrawContainerCell(
  AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean);
begin
  View.DoCustomDrawContainer(
    TcxSchedulerContainerCellViewInfo(AItem), ADone);
end;

procedure TcxSchedulerDayViewPainter.DrawDayViewEventCell(
  AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean);
begin
  DrawEventCell(AItem, ADone);
end;

procedure TcxSchedulerDayViewPainter.DrawTimeRulerCell(
  AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean);
begin
  View.DoCustomDrawTimeRuler(
    TcxSchedulerTimeRulerCellViewInfo(AItem), ADone);
end;

function TcxSchedulerDayViewPainter.GetView: TcxSchedulerDayView;
begin
  Result := ViewInfo.DayView;
end;

function TcxSchedulerDayViewPainter.GetViewInfo: TcxSchedulerDayViewViewInfo;
begin
  Result := TcxSchedulerDayViewViewInfo(inherited ViewInfo);
end;

{ TcxSchedulerTimeRulerPopupMenu }

constructor TcxSchedulerTimeRulerPopupMenu.Create(
  AScheduler: TcxCustomScheduler);
begin
  inherited Create(AScheduler);
  FItems := [rpmiNewEvent, rpmiNewAllDayEvent, rpmiNewReccuringEvent, rpmi60min,
    rpmi30min, rpmi15min, rpmi10min, rpmi6min, rpmi5min];
end;

procedure TcxSchedulerTimeRulerPopupMenu.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxSchedulerTimeRulerPopupMenu then
  begin
    Items := TcxSchedulerTimeRulerPopupMenu(Source).Items;
    OnClick := TcxSchedulerTimeRulerPopupMenu(Source).OnClick;
    OnPopup := TcxSchedulerTimeRulerPopupMenu(Source).OnPopup;
  end;
end;

procedure TcxSchedulerTimeRulerPopupMenu.Execute(
  AItem: TcxSchedulerTimeRulerPopupMenuItem);
begin
  ExecuteCommand(Ord(AItem));
end;

function TcxSchedulerTimeRulerPopupMenu.GetMenuItem(
  AItem: TcxSchedulerTimeRulerPopupMenuItem): TMenuItem;
begin
  Result := FindItemByCommand(Root, Ord(AItem));
end;

procedure TcxSchedulerTimeRulerPopupMenu.CreateItems;

  function GetChecked(ACommand: Integer): Boolean;
  var
    AIndex: Integer;
  begin
    Result := False;
    AIndex := ACommand - Ord(rpmi60min);
    if (AIndex < 0) or (AIndex > 5) then Exit;
    Result := DayView.TimeScale = RulerScales[AIndex];
  end;

  procedure CreateRulerItem(const ACaption: string;
    AItem: TcxSchedulerTimeRulerPopupMenuItem);
  var
    ACommand: Integer;
  begin
    if AItem in Items then
    begin
      ACommand := Ord(AItem);
      CreateSubItem(Root, ACaption, ACommand, -1, True, GetChecked(ACommand));
    end;
  end;

begin
  CreateNewEventItems(rpmiNewEvent in FItems, rpmiNewAllDayEvent in FItems,
    rpmiNewReccuringEvent in FItems, Ord(rpmiNewEvent), Ord(rpmiNewAllDayEvent),
    Ord(rpmiNewReccuringEvent));
  if Items * [rpmi60min, rpmi30min, rpmi15min, rpmi10min, rpmi6min, rpmi5min] <> [] then
  begin
    AddValidSeparator(Root);
    CreateRulerItem(cxGetResourceString(@scxpm60Minutes), rpmi60min);
    CreateRulerItem(cxGetResourceString(@scxpm30Minutes), rpmi30min);
    CreateRulerItem(cxGetResourceString(@scxpm15Minutes), rpmi15min);
    CreateRulerItem(cxGetResourceString(@scxpm10Minutes), rpmi10min);
    CreateRulerItem(cxGetResourceString(@scxpm6Minutes), rpmi6min);
    CreateRulerItem(cxGetResourceString(@scxpm5Minutes), rpmi5min);
  end;
end;

procedure TcxSchedulerTimeRulerPopupMenu.DoExecute(ACommand: Integer);
var
  AIndex: Integer;
begin
  if ACommand in [Ord(rpmiNewEvent), Ord(rpmiNewAllDayEvent), Ord(rpmiNewReccuringEvent)] then
    inherited DoExecute(ACommand)
  else
  begin
    AIndex := ACommand - Ord(rpmi60min);
    if AIndex in [0..5] then
      DayView.TimeScale := RulerScales[AIndex];
  end;
end;

function TcxSchedulerTimeRulerPopupMenu.DoOnClick(
  ACommand: Integer): Boolean;
begin
  Result := False;
  if Assigned(FOnClick) then
    FOnClick(Self, TcxSchedulerTimeRulerPopupMenuItem(ACommand), Result);
end;

function TcxSchedulerTimeRulerPopupMenu.DoOnPopup: Boolean;
begin
  Result := False;
  if Assigned(FOnPopup) then
    FOnPopup(Self, InternalMenu, Result);
end;

function TcxSchedulerTimeRulerPopupMenu.IsValidCommand(
  ACommand: Integer): Boolean;
begin
  Result := (ACommand >= Ord(rpmiNewEvent)) and (ACommand <= Ord(rpmi5min));
end;

function TcxSchedulerTimeRulerPopupMenu.GetDayView: TcxSchedulerDayView;
begin
  Result := Scheduler.CurrentView as TcxSchedulerDayView;
end;

end.

