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

unit cxSchedulerYearView;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Types, DateUtils,
{$ENDIF}
  Windows, Forms, Classes, SysUtils, Math, StdCtrls, Graphics,
  Controls, cxControls, cxGraphics, cxStyles, cxGeometry,
  cxLookAndFeelPainters, cxSchedulerCustomControls, cxSchedulerCustomResourceView,
  cxSchedulerUtils, cxSchedulerStorage, cxSchedulerStrs, cxDateUtils;

const
  cxMaxSelectedDaysCount         = 20;
  MaxYearViewWeekDays            = 37;
  cxYearViewScrollCurrentYearPos = 10;
  cxYearViewScrollMaxPos         = 21;
  cxYearViewScrollMinPos         = 0;

  cxcsMonthHeader                = 0;
  cxcsUnusedContent              = 1;
  cxcsMaxYearViewStyle           = cxcsUnusedContent;

  // hittests
  htcYear                        = $11;
  htcMonth                       = $12;

type
  TcxSchedulerYearView = class;
  TcxSchedulerYearViewViewInfo = class;
  TcxSchedulerYearViewNavigation = class;
  TcxSchedulerMonthHeaderCellViewInfo = class;
  TcxSchedulerYearViewStyles = class;
  TcxSchedulerYearViewContentCellViewInfo = class;

  { TcxSchedulerYearViewController }

  TcxSchedulerYearViewController = class(TcxSchedulerCustomResourceViewController)
  protected
    function CreateDragEventHelper: TcxDragEventHelper; override;
    function CreateNavigation: TcxSchedulerViewNavigation; override;
    function CreateResizeEventHelper: TcxEventSizingHelper; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  end;

  { TcxSchedulerYearViewHitTest }
  
  TcxSchedulerYearViewHitTest = class(TcxSchedulerCustomResourceViewHitTest)
  public
    property HitAtYear: Boolean index htcYear read GetBitState;
    property HitAtMonth: Boolean index htcMonth read GetBitState;
  end;

  { IcxSchedulerYearViewAdapter }

  IcxSchedulerYearViewAdapter = interface
  ['{7B39CB3C-256E-4269-9B24-5A59BC3D868D}']
    function GetMonthCount: Integer;
    function GetFirstMonth: Integer;
    function GetShowMonthHeaders: Boolean; 
    function GetShowWeekDayHeaders: Boolean;
    function GetStartDayIndex: Integer;
    function GetDayCountPerPage: Integer;
  end;

  { TcxSchedulerYearViewPainter }

  TcxSchedulerYearViewPainter = class(TcxSchedulerCustomViewPainter)
   private
     function GetViewInfo: TcxSchedulerYearViewViewInfo;
   public
     procedure Paint; override;
     property ViewInfo: TcxSchedulerYearViewViewInfo read GetViewInfo;
  end;

  { TcxSchedulerYearViewEventCellViewInfo }

  TcxSchedulerYearViewEventCellViewInfo = class(TcxSchedulerEventCellViewInfo)
  protected
    procedure CalculateBorders; override;
    procedure CalculateCaptions; override;
    procedure CalculateEventTimeVisibility; override;
    function CanAutoHideStandardImages: Boolean; override;
    function GetForceShowClockInHeaderEvent: Boolean; override;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
  end;

  { TcxSchedulerYearViewViewInfo }

  TcxSchedulerYearViewViewInfo = class(TcxSchedulerCustomResourceViewViewInfo)
  private
    function GetDaysCell(AIndex: Integer): TcxSchedulerYearViewContentCellViewInfo;
    function GetDaysCellCount: Integer;
    function GetMonthBounds(AIndex: Integer): TRect;
    function GetYearView: TcxSchedulerYearView;
  protected
    FContentFont: TFont;
    FContentSmallFont: TFont;
    FDayCells: TList;
    FDayTextHeight: Integer;
    FMonthHeaderCells: TcxSchedulerViewInfoCellList;
    FMonthHeaderWidth: Integer;
    FShowMonthHeaders: Boolean;
    FStartDayIndex: Integer;
    FMaxYearViewWeekDays: Integer;
    FMaxEventsCount: Integer; 
    FYear: Word;
    FYearViewExtraAdapter: IcxSchedulerYearViewAdapter;
    YearStart: Integer;
    YearFinish: Integer;
    procedure AddEventButtons(APlace: TcxSchedulerEventPlace);
    procedure AddEventForCalculation(ABuilder: TcxSchedulerEventLayoutBuilder;
      AEvent: TcxSchedulerControlEvent);
    procedure AddEventToYearView(APlace: TcxSchedulerEventPlace);
    function AddMonthHeader(AYear: Integer; AMonth: Integer;
      ARect: TRect): TcxSchedulerMonthHeaderCellViewInfo;
    function AddWeekDayHeader(AWeekDay: Integer;
      ARect: TRect): TcxSchedulerWeekDayHeaderCellViewInfo;
    function AddYearViewContentCell(ARect: TRect; ADate: TDate; ASelected: Boolean;
      AParams: TcxViewParams; AColIndex: Integer): TcxSchedulerYearViewContentCellViewInfo;
    procedure CalculateContentCellMonthParams(AMonth: Integer;
      out AMonthBounds: TRect; out AStartOfMonth: TDate;
      out AStartMonthColumn, ADaysPerMonth: Integer);
    procedure CalculateContentCells; virtual;
    procedure CalculateDaysHeader; virtual;
    procedure CalculateEventsViewInfo; virtual;
    procedure CalculateMetrics; override;
    procedure CalculateMonthHeaderWidth;
    procedure CalculateMonthsHeader; virtual;
    procedure Clear; override;
    function ContentCellClass: TcxSchedulerContentCellViewInfoClass; override;
    function CreateEventCellViewInfo(AViewData: TcxSchedulerEventViewData): TcxSchedulerEventCellViewInfo; override;
    procedure DoCalculate; override;
    function GetMonthColumnDate(AStartOfMonth: TDateTime;
      ADaysPerMonth, AStartMonthColumn, AColumn: Integer): TDateTime;
    function GetSmallFont(const AParams: TcxViewParams): TFont;
    function IsEventVisible(AEvent: TcxSchedulerControlEvent): Boolean;
    procedure PrepareSmallContentFont;

    // page splitting
    function GetFirstMonth: Integer; virtual;
    function GetMonthCountPerPage: Integer; virtual;

    property FirstMonth: Integer read GetFirstMonth;
    property MonthCountPerPage: Integer read GetMonthCountPerPage;
  public
    constructor Create(AOwner: TcxSchedulerSubControl); override;
    destructor Destroy; override;
    procedure CalculateHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
    procedure UpdateSelection;

    property DaysCellCount: Integer read GetDaysCellCount;
    property DaysCells[AIndex: Integer]: TcxSchedulerYearViewContentCellViewInfo read GetDaysCell;
    property MonthBounds[AIndex: Integer]: TRect read GetMonthBounds;
    property MonthHeaderCells: TcxSchedulerViewInfoCellList read FMonthHeaderCells;
    property View: TcxSchedulerYearView read GetYearView;
    property Year: Word read FYear;
  end;

  { TcxSchedulerYearViewNavigation }

  TcxSchedulerYearViewNavigation = class(TcxSchedulerCustomResourceViewNavigation)
  private
    FCanChangeSelection: Boolean;
    FSaveSelFinish: TDateTime;
    FSaveSelStart: TDateTime;
    function GetYearView: TcxSchedulerYearView;
    function GetYearViewInfo: TcxSchedulerYearViewViewInfo;
  protected
    function ContentCell(AIndex: Integer): TcxSchedulerYearViewContentCellViewInfo;
    procedure DoKeyDown(var AKey: Word; AShift: TShiftState); override;
    procedure GotoCornerCell(AGotoEnd: Boolean); virtual;
    procedure GotoNextCellHorz(AGotoNext: Boolean); virtual;
    procedure GotoNextCellVert(AGoForward: Boolean); virtual;
    procedure GotoNextPage(AGotoForward: Boolean); virtual;
  public
    procedure KeyDown(var AKey: Word; AShift: TShiftState); override;
    procedure ValidateSelection(var ASelStart, ASelFinish: TDateTime;
      var AResource: TcxSchedulerStorageResourceItem); override;

    property View: TcxSchedulerYearView read GetYearView;
    property ViewInfo: TcxSchedulerYearViewViewInfo read GetYearViewInfo;
  end;

  { TcxSchedulerMonthHeaderCellViewInfo }

  TcxSchedulerMonthHeaderCellViewInfo = class(TcxSchedulerDayHeaderCellViewInfo)
  private
    FMonth: Integer;
    FYear: Integer;
    procedure SetMonth(AValue: Integer);
    procedure SetYear(AValue: Integer);
  protected
    FColStart: Integer;
    procedure CalculateDisplayText; virtual;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
  public
    property Month: Integer read FMonth write SetMonth;
    property Year: Integer read FYear write SetYear;
  end;

  { TcxSchedulerYearViewContentCellViewInfo }

  TcxSchedulerYearViewContentCellViewInfo = class(TcxSchedulerMonthDayContentCellViewInfo)
  protected
    FColIndex: Integer;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
  end;

  { TcxYearViewDragEventHelper }

  TcxYearViewDragEventHelper = class(TcxDragEventHelper)
  protected
    procedure UpdateViewClonesTime; override;
  end;

  { TcxYearViewEventSizing }

  TcxYearViewEventSizing = class(TcxEventSizingHelper)
  protected
    procedure UpdateEventBounds; override;
  end;

  { TcxSchedulerYearViewStyles }

  TcxSchedulerYearViewGetUnusedContentStyleEvent = procedure(Sender: TcxSchedulerYearView;
    AYear, AMonth, ADayOfWeek: Integer; var AStyle: TcxStyle) of object;
  TcxSchedulerYearViewGetMonthHeaderStyleEvent = procedure(Sender: TcxSchedulerYearView;
    AYear, AMonth: Integer; var AStyle: TcxStyle) of object;

  TcxSchedulerYearViewStyles = class(TcxStyles)
  private
    FScheduler: TcxCustomScheduler;
    FYearView: TcxSchedulerYearView;
    FOnGetMonthHeaderStyle: TcxSchedulerYearViewGetMonthHeaderStyleEvent;
    FOnGetUnusedContentStyle: TcxSchedulerYearViewGetUnusedContentStyleEvent;
    function GetPainter: TcxCustomLookAndFeelPainterClass;
  protected
    procedure Changed(AIndex: Integer); override;
    procedure GetDefaultViewParams(Index: Integer; AData: TObject;
      out AParams: TcxViewParams); override;
    property Painter: TcxCustomLookAndFeelPainterClass read GetPainter;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    function GetMonthHeaderParams(AYear, AMonth: Integer): TcxViewParams;
    function GetUnusedContentParams(
      AYear, AMonth, ADayOfWeek: Integer): TcxViewParams;

    property Scheduler: TcxCustomScheduler read FScheduler;
    property YearView: TcxSchedulerYearView read FYearView;
  published
    property MonthHeader: TcxStyle index cxcsMonthHeader read GetValue write SetValue;
    property UnusedContent: TcxStyle index cxcsUnusedContent read GetValue write SetValue;
    property OnGetMonthHeaderStyle: TcxSchedulerYearViewGetMonthHeaderStyleEvent read FOnGetMonthHeaderStyle write FOnGetMonthHeaderStyle;
    property OnGetUnusedContentStyle: TcxSchedulerYearViewGetUnusedContentStyleEvent read FOnGetUnusedContentStyle write FOnGetUnusedContentStyle;
  end;

  { TcxSchedulerYearView }

  TcxSchedulerYearView = class(TcxSchedulerCustomResourceView)
  private
    FAllDayEventsOnly: Boolean;
    FMaxSelectedDaysCount: Integer;
    FStyles: TcxSchedulerYearViewStyles;
    function GetHitTest: TcxSchedulerYearViewHitTest;
    function GetYear: Word;
    procedure SetAllDayEventsOnly(AValue: Boolean);
    procedure SetMaxSelectedDaysCount(AValue: Integer);
    procedure SetStyles(AValue: TcxSchedulerYearViewStyles);
    procedure SetYear(AValue: Word);
  protected
    procedure CreateSubClasses; override;
    procedure DestroySubClasses; override;
    function CanDeactivateOnDateNavigatorSelectionChange: Boolean; override;
    function CanSelectPeriod: Boolean; override;
    function CreateController: TcxSchedulerSubControlController; override;
    function CreateHitTest: TcxSchedulerSubControlHitTest; override;
    function CreatePainter: TcxSchedulerSubControlPainter; override;
    function CreateStyles: TcxSchedulerYearViewStyles; virtual;
    function CreateViewInfo: TcxSchedulerSubControlViewInfo; override;
    function GetCompressWeekEnd: Boolean; override;
    function GetGroupingKind: TcxSchedulerGroupingKind; override;
    function GetFirstVisibleDate: TDateTime; override;
    function GetLastVisibleDate: TDateTime; override;
    function GetScrollPos: Integer; virtual;
    function GetVisibleDaysRange: Integer; override;
    procedure InitScrollBarsParameters; override;
    procedure MakeEventVisible(AEvent: TcxSchedulerControlEvent;
      const ADate: TDateTime; AResource: TcxSchedulerStorageResourceItem); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Scroll(AScrollBarKind: TScrollBarKind;
      AScrollCode: TScrollCode; var AScrollPos: Integer); override;
    procedure SelectedDaysChanged; override;
  public
    procedure Assign(Source: TPersistent); override;

    property HitTest: TcxSchedulerYearViewHitTest read GetHitTest;
    property Year: Word read GetYear write SetYear;
  published
    property Active;
    property AllDayEventsOnly: Boolean read FAllDayEventsOnly write SetAllDayEventsOnly default False;
    property MaxSelectedDaysCount: Integer read FMaxSelectedDaysCount write SetMaxSelectedDaysCount default 0;
    property Styles: TcxSchedulerYearViewStyles read FStyles write SetStyles;
  end;

implementation

const
  DayInc: array[Boolean] of Integer = (-1, 1);

{ TcxSchedulerYearViewController }

function TcxSchedulerYearViewController.CreateDragEventHelper: TcxDragEventHelper;
begin
  Result := TcxYearViewDragEventHelper.Create(Scheduler);
end;

function TcxSchedulerYearViewController.CreateNavigation: TcxSchedulerViewNavigation;
begin
  Result := TcxSchedulerYearViewNavigation.Create(View);
end;

function TcxSchedulerYearViewController.CreateResizeEventHelper: TcxEventSizingHelper;
begin
  Result := TcxYearViewEventSizing.Create(Scheduler);
end;

procedure TcxSchedulerYearViewController.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if View.Active and not EditController.IsEditing and
    TcxSchedulerYearViewNavigation(Navigation).IsKeyNavigation(Key, Shift) then
    TcxSchedulerYearViewNavigation(Navigation).DoKeyDown(Key, Shift)
  else
    inherited KeyDown(Key, Shift);
end;

{ TcxSchedulerYearViewPainter }

procedure TcxSchedulerYearViewPainter.Paint;
begin
  inherited Paint;
  ViewInfo.MonthHeaderCells.Draw(Canvas, DrawHeaderCell);
  ViewInfo.DayHeaderCells.Draw(Canvas, DrawHeaderCell);
  ViewInfo.ContentCells.Draw(Canvas, DrawContentCell);
  ViewInfo.EventCells.Draw(Canvas, DrawEventCell);
  ViewInfo.Buttons.Draw(Canvas, DrawButtonCell);
end;

function TcxSchedulerYearViewPainter.GetViewInfo: TcxSchedulerYearViewViewInfo;
begin
  Result := TcxSchedulerYearViewViewInfo(inherited ViewInfo);
end;

{ TcxSchedulerYearViewEventCellViewInfo }

procedure TcxSchedulerYearViewEventCellViewInfo.CalculateBorders;
begin
  if ViewData.ContentFinish < EventFinish then
    Exclude(FBorders, bRight);
  if ViewData.ContentStart > EventStart then
    Exclude(FBorders, bLeft);
end;

procedure TcxSchedulerYearViewEventCellViewInfo.CalculateCaptions;
begin
end;

procedure TcxSchedulerYearViewEventCellViewInfo.CalculateEventTimeVisibility;
var
  B: Boolean;
begin
  B := IsHeaderEvent and not Event.AllDayEvent;
  ViewData.ShowStartTime := B and (TimeOf(Event.Start) <> 0) and
    (EventStart > ViewData.ContentStart);
  ViewData.ShowFinishTime := B and (TimeOf(Event.Finish) <> 0) and
    (EventFinish < ViewData.ContentFinish);
end;

function TcxSchedulerYearViewEventCellViewInfo.CanAutoHideStandardImages: Boolean;
begin
  Result := True;
end;

function TcxSchedulerYearViewEventCellViewInfo.GetForceShowClockInHeaderEvent: Boolean;
begin
  Result := False;
end;

procedure TcxSchedulerYearViewEventCellViewInfo.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  inherited InitHitTest(AHitTest);
  InitHitTestForHorzEvent(AHitTest);
end;

{ TcxSchedulerYearViewViewInfo }

constructor TcxSchedulerYearViewViewInfo.Create(
  AOwner: TcxSchedulerSubControl);
begin
  inherited Create(AOwner);
  FContentSmallFont := TFont.Create;
  FDayCells := TList.Create;
  FDayCells.Capacity := 444;
  FMonthHeaderCells := TcxSchedulerViewInfoCellList.Create;
  FCells.Add(FMonthHeaderCells);
end;

destructor TcxSchedulerYearViewViewInfo.Destroy;
begin
  FContentSmallFont.Free;
  FDayCells.Free;
  inherited Destroy;
end;

procedure TcxSchedulerYearViewViewInfo.CalculateHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  if not MonthHeaderCells.CalculateHitTest(AHitTest) then
    inherited CalculateHitTest(AHitTest);
end;

procedure TcxSchedulerYearViewViewInfo.UpdateSelection;
var
  I: Integer;
  ACell: TcxSchedulerMonthDayContentCellViewInfo;
begin
  with View.Controller.Navigation do
  begin
    Self.FSelStart := DateTimeHelper.RoundTime(Min(SelStart, SelFinish));
    Self.FSelFinish := DateTimeHelper.RoundTime(Max(SelStart, SelFinish));
  end;
  for I := 0 to ContentCells.Count - 1 do
  begin
    ACell := TcxSchedulerMonthDayContentCellViewInfo(ContentCells[I]);
    if (ACell.TimeStart <> NullDate) and ACell.UpdateSelection(not HideSelection and
      (ACell.TimeStart >= SelStart) and (ACell.TimeStart <= SelFinish)) then
      View.InvalidateRect(ACell.Bounds);
  end;
end;

procedure TcxSchedulerYearViewViewInfo.AddEventButtons(
  APlace: TcxSchedulerEventPlace);
var
  I: Integer;
begin
  for I := APlace.ColStart to APlace.ColFinish do
    if DaysCells[I].LineCount = 0 then
    begin
      AddButton(DaysCells[I].Bounds, DaysCells[I].TimeStart, -1, True);
      DaysCells[I].LineCount := 1;
    end; 
end;

procedure TcxSchedulerYearViewViewInfo.AddEventForCalculation(
  ABuilder: TcxSchedulerEventLayoutBuilder; AEvent: TcxSchedulerControlEvent);
var
  AStart, AFinish: TDateTime;
  AOfs, I, AStartIndex, AFinishIndex: Integer;
  AStartDay: TcxSchedulerYearViewContentCellViewInfo;
begin
  if (FYearViewExtraAdapter = nil) then
  begin
    AStart := Max(YearStart, AEvent.Start);
    AFinish := Min(YearFinish, AEvent.Finish);
    AOfs := DayOfTheYear(EncodeDate(Year, FirstMonth, 1));
    I := DayOfTheYear(AStart) - AOfs;
    AFinishIndex := Max(DayOfTheYear(AFinish) - 1 - AOfs, I);
    while (AFinishIndex < (DaysCellCount - 1)) and
      AEvent.IsDayEvent(DaysCells[AFinishIndex + 1].TimeStart) do Inc(AFinishIndex);
  end
  else
  begin
    I := 0;
    while (I < DaysCellCount) and not AEvent.IsDayEvent(DaysCells[I].TimeStart) do
      Inc(I);
    if I = DaysCellCount then Exit;
    AFinishIndex := I;
    while (AFinishIndex < DaysCellCount) and
      AEvent.IsDayEvent(DaysCells[AFinishIndex].TimeStart) do Inc(AFinishIndex);
    Dec(AFinishIndex);
  end;
  while I <= AFinishIndex do
  begin
    AStartIndex := I;
    AStartDay := DaysCells[I];
    while (I <= AFinishIndex) and (AStartDay.Bounds.Top = DaysCells[I].Bounds.Top) do
      Inc(I);
    ABuilder.AddEventPlace(AEvent, AStartIndex, I - 1, 1, TObject(MonthOf(AStartDay.DateTime)));
  end;
end;

procedure TcxSchedulerYearViewViewInfo.AddEventToYearView(
  APlace: TcxSchedulerEventPlace);
var
  ABounds: TRect;
  AViewData: TcxSchedulerEventViewData;
  AStart, AFinish: TDateTime;
begin
  ABounds := MonthBounds[Integer(APlace.Resource)];
  with DaysCells[APlace.ColStart] do 
  begin
    AStart := TimeStart;
    ABounds.Left := Bounds.Left + cxTextOffset;
  end;
  with DaysCells[APlace.ColFinish] do 
  begin
    AFinish := TimeFinish;
    ABounds.Right := Bounds.Right - cxTextOffset - 1;
  end;
  ABounds.Top := ABounds.Top + APlace.LineStart * (ContentLineHeight + cxTextOffset);
  ABounds.Bottom := ABounds.Top + ContentLineHeight;
  OffsetRect(ABounds, 0, FDayTextHeight);
  AViewData := CreateEventViewData(TcxSchedulerControlEvent(APlace.Event),
    ABounds, AStart, AFinish, nil);
  AViewData.VisibleRect := MonthBounds[Integer(APlace.Resource)];
  Dec(AViewData.VisibleRect.Bottom, cxTextOffset);
  if AViewData.Bounds.Bottom > AViewData.VisibleRect.Bottom then
  begin
    //todo: lcm if not AViewData.Event.IsClone then
      AddEventButtons(APlace);
    AViewData.Free
  end
  else
    AddEventCell(AViewData);
end;

function TcxSchedulerYearViewViewInfo.AddMonthHeader(AYear: Integer;
  AMonth: Integer; ARect: TRect): TcxSchedulerMonthHeaderCellViewInfo;
var
  AParams: TcxViewParams;
begin
  AParams := View.Styles.GetMonthHeaderParams(AYear, AMonth);
  CreateCellInstance(TcxSchedulerMonthHeaderCellViewInfo, ARect,
    AParams, Result);
  Result.Month := AMonth;
  Result.Year := AYear;
  Result.RotateHeader := True;
  MonthHeaderCells.Add(Result);
end;

function TcxSchedulerYearViewViewInfo.AddWeekDayHeader(AWeekDay: Integer;
  ARect: TRect): TcxSchedulerWeekDayHeaderCellViewInfo;
begin
  Inc(AWeekDay, Integer(View.StartOfWeek));
  if AWeekDay >= 7 then Dec(AWeekDay, 7);
  CreateCellInstance(TcxSchedulerWeekDayHeaderCellViewInfo, ARect,
    StylesAdapter.GetDayHeaderParams(AWeekDay),
    Result);
  Result.DateTime := AWeekDay;
  DayHeaderCells.Add(Result);
end;

function TcxSchedulerYearViewViewInfo.AddYearViewContentCell(
  ARect: TRect; ADate: TDate; ASelected: Boolean;
  AParams: TcxViewParams; AColIndex: Integer): TcxSchedulerYearViewContentCellViewInfo;
var
  AColor: TColor;
begin
  CreateCellInstance(TcxSchedulerYearViewContentCellViewInfo,
    ARect, AParams, Result);
  Result.FSmallFont := True;
  Result.SmallTextFont := GetSmallFont(AParams);
  if ADate <> NullDate then
  begin
    Result.SetTime(ADate, ADate + 1);
    Result.SetContentState(True, ASelected, FDayTextHeight - cxTextOffset, FSelectionParams);
    AColor := StylesAdapter.GetContentParams(ADate, True, nil).Color;
    Result.Color := PainterHelper.GetContentColor(AColor,
      View.IsWorkTime(nil, ADate + View.WorkStart));
    FDayCells.Add(Result);
  end;
  Result.LineCount := 0;
  Result.FColIndex := AColIndex;
  ContentCells.Add(Result);
end;

procedure TcxSchedulerYearViewViewInfo.CalculateContentCellMonthParams(
  AMonth: Integer; out AMonthBounds: TRect; out AStartOfMonth: TDate;
  out AStartMonthColumn, ADaysPerMonth: Integer);
begin
  AMonthBounds := FMonthHeaderCells[AMonth + 1].Bounds;
  AStartOfMonth := EncodeDate(Year, AMonth + FirstMonth, 1);
  AStartMonthColumn := DayOfWeek(AStartOfMonth) - 1;
  Dec(AStartMonthColumn, Integer(View.GetStartOfWeek));
  if AStartMonthColumn < 0 then
    Inc(AStartMonthColumn, 7);
  ADaysPerMonth := DaysPerMonth(Year, AMonth + FirstMonth);
  TcxSchedulerMonthHeaderCellViewInfo(FMonthHeaderCells[AMonth + 1]).FColStart := AStartMonthColumn;
end;

procedure TcxSchedulerYearViewViewInfo.CalculateContentCells;
var
  I, J: Integer;
  R, DayBounds, MonthBounds: TRect;
  AStartOfMonth, ADate: TDate;
  ACell: TcxSchedulerYearViewContentCellViewInfo;
  AStartMonthColumn, ADaysPerMonth: Integer;
  ASelected: Boolean;
  AParams: TcxViewParams;
begin
  FMaxEventsCount := 0;
  for I := 0 to MonthCountPerPage - 1 do
  begin
    CalculateContentCellMonthParams(I, MonthBounds, AStartOfMonth,
      AStartMonthColumn, ADaysPerMonth);
    for J := 0 to FMaxYearViewWeekDays - 1 do
    begin
      DayBounds := DayHeaderCells[J].Bounds;
      R := Rect(DayBounds.Left, MonthBounds.Top,
        DayBounds.Right, MonthBounds.Bottom);
      ADate := GetMonthColumnDate(AStartOfMonth, ADaysPerMonth,
        AStartMonthColumn, J + FStartDayIndex);
      ASelected := not HideSelection and
        (ADate >= SelStart) and (ADate <= SelFinish);
      if ADate = NullDate then
        AParams := View.Styles.GetUnusedContentParams(FYear, (I + FirstMonth),
          (Byte(View.OptionsView.ActualStartOfWeek) + J + FStartDayIndex) mod 7)
      else
        AParams := GetContentParams(ADate, nil);
      ACell := AddYearViewContentCell(R, ADate, ASelected, AParams, J);
      FMaxEventsCount := Max(FMaxEventsCount, (R.Bottom - R.Top) div FContentLineHeight + 1); 
      if I < MonthCountPerPage then
        ACell.Borders := [bBottom, bRight]
      else
        ACell.Borders := [bRight];
    end;
  end;
end;

procedure TcxSchedulerYearViewViewInfo.CalculateDaysHeader;
var
  R: TRect;
  I, W: Integer;
begin
  W := Bounds.Right - Bounds.Left - FMonthHeaderWidth + 1;
  R := cxRectSetHeight(Bounds, FDayHeaderHeight);
  for I := 0 to FMaxYearViewWeekDays - 1 do
  begin
    R.Left := FMonthHeaderWidth + MulDiv(W, I, FMaxYearViewWeekDays);
    R.Right := FMonthHeaderWidth + MulDiv(W, I + 1, FMaxYearViewWeekDays);
    AddWeekDayHeader(((I + FStartDayIndex) mod 7), R);
  end;
  ProcessCheckBorders(DayHeaderCells, True, [nLeft]);
  ProcessDateToDisplayText(True);
end;

procedure TcxSchedulerYearViewViewInfo.CalculateEventsViewInfo;
var
  I: Integer;
  AEvent: TcxSchedulerControlEvent;
  ABuilder: TcxSchedulerEventLayoutBuilder;
begin
  ABuilder := TcxSchedulerEventLayoutBuilder.Create;
  try
    for I := 0 to Events.AbsoluteCount - 1 do
    begin
      AEvent := Events.AbsoluteItems[I];
      if IsEventVisible(AEvent) then
        AddEventForCalculation(ABuilder, AEvent);
    end;
    ABuilder.Calculate;
    for I := 0 to DaysCellCount - 1 do
      DaysCells[I].LineCount := 0;
    for I := ABuilder.EventPlaceCount - 1 downto 0 do
      AddEventToYearView(ABuilder.EventPlaces[I]);
  finally
    ABuilder.Free;
  end;
end;

procedure TcxSchedulerYearViewViewInfo.CalculateMetrics;
begin
  inherited CalculateMetrics;
  if FYearViewExtraAdapter = nil then
    FYear := View.Year
  else
    FYear := YearOf(SelectedDays[0]);
  FDayTextHeight := Round(FContentFontHeight * 2 / 3);
end;

procedure TcxSchedulerYearViewViewInfo.CalculateMonthHeaderWidth;
var
  I: Integer;
  AFont: TFont;
  AStyle: TcxStyle;
begin
  if not FShowMonthHeaders then
  begin
    FMonthHeaderWidth := 0;
    Exit; 
  end;
  AStyle := View.Styles.MonthHeader;
  if (AStyle <> nil) and (cxStyles.svFont in AStyle.AssignedValues) then
    AFont := AStyle.Font
  else
    AFont := DefaultFont;
  FMonthHeaderWidth := cxTextWidth(AFont, 'WWWW') + 4 * cxTextOffset;
  for I := 1 to 12 do
    FMonthHeaderWidth := Max(FMonthHeaderWidth,
      cxTextWidth(AFont, LongMonthNames[I]) + 4 * cxTextOffset);
end;

procedure TcxSchedulerYearViewViewInfo.CalculateMonthsHeader;
var
  R: TRect;
  I, H: Integer;
begin
  CalculateMonthHeaderWidth;
  H := Bounds.Bottom - Bounds.Top - FDayHeaderHeight;
  R := cxRectSetHeight(cxRectSetWidth(Bounds, FMonthHeaderWidth),
    FDayHeaderHeight);
  AddMonthHeader(FYear, 0, R).RotateHeader := False;
  for I := 0 to MonthCountPerPage - 1 do
  begin
    R.Top := MulDiv(H, I, MonthCountPerPage) + FDayHeaderHeight;
    R.Bottom := MulDiv(H, I + 1, MonthCountPerPage) + FDayHeaderHeight;
    AddMonthHeader(FYear, I + FirstMonth, R);
  end;
  ProcessCheckBorders(MonthHeaderCells, True, [], []);
end;

procedure TcxSchedulerYearViewViewInfo.Clear;
begin
  FDayCells.Clear;
  FMonthHeaderCells.Clear;
  inherited Clear;
end;

function TcxSchedulerYearViewViewInfo.ContentCellClass: TcxSchedulerContentCellViewInfoClass;
begin
  Result := TcxSchedulerYearViewContentCellViewInfo;
end;

function TcxSchedulerYearViewViewInfo.CreateEventCellViewInfo(
  AViewData: TcxSchedulerEventViewData): TcxSchedulerEventCellViewInfo;
begin
  Result := TcxSchedulerYearViewEventCellViewInfo.Create(AViewData);
end;

procedure TcxSchedulerYearViewViewInfo.DoCalculate;
var
  ADate: TDateTime; 
begin
  ADate := SelectedDays[0];
  SelectedDays.Clear;
  SelectedDays.Add(ADate);
  PrepareSmallContentFont;
  FStartDayIndex := 0;
  FShowMonthHeaders := True;
  FMaxYearViewWeekDays := MaxYearViewWeekDays;
  Supports(TObject(Adapter), IcxSchedulerYearViewAdapter, FYearViewExtraAdapter);
  try
    inherited DoCalculate;
    if FYearViewExtraAdapter <> nil then
    begin
      if not FYearViewExtraAdapter.GetShowWeekDayHeaders then
        FDayHeaderHeight := 0;
      FShowMonthHeaders := FYearViewExtraAdapter.GetShowMonthHeaders;
      FStartDayIndex := FYearViewExtraAdapter.GetStartDayIndex;
      FMaxYearViewWeekDays := FYearViewExtraAdapter.GetDayCountPerPage;
    end;
    YearStart  := Trunc(EncodeDate(Year, 1, 1));
    YearFinish := Trunc(EndOfTheYear(YearStart));
    CalculateMonthsHeader;
    CalculateDaysHeader;
    CalculateContentCells;
    CalculateEventsViewInfo;
  finally
    FYearViewExtraAdapter := nil;
  end;
end;

function TcxSchedulerYearViewViewInfo.GetMonthColumnDate(
  AStartOfMonth: TDateTime;
  ADaysPerMonth, AStartMonthColumn, AColumn: Integer): TDateTime;
begin
  Result := NullDate;
  Dec(AColumn, AStartMonthColumn);
  if (AColumn >= 0) and (AColumn < ADaysPerMonth) then
    Result := AStartOfMonth + AColumn;
end;

function TcxSchedulerYearViewViewInfo.GetSmallFont(const AParams: TcxViewParams): TFont;
begin
  if AParams.Font = FContentFont then
    Result := FContentSmallFont
  else
    Result := nil;
end;

function TcxSchedulerYearViewViewInfo.GetFirstMonth: Integer;
begin
  if FYearViewExtraAdapter = nil then
    Result := 1
  else
    Result := FYearViewExtraAdapter.GetFirstMonth;
end;

function TcxSchedulerYearViewViewInfo.GetMonthCountPerPage: Integer;
begin
  if FYearViewExtraAdapter = nil then
    Result := 12
  else
    Result := FYearViewExtraAdapter.GetMonthCount;
end;

function TcxSchedulerYearViewViewInfo.IsEventVisible(
  AEvent: TcxSchedulerControlEvent): Boolean;
begin
  Result := not View.AllDayEventsOnly or (AEvent.AllDayEvent or (AEvent.Duration > 1));
  if Result then
    Result := (DateOf(AEvent.Start) <= YearFinish) and (AEvent.Finish > YearStart);
end;

procedure TcxSchedulerYearViewViewInfo.PrepareSmallContentFont;
begin
  FContentFont := StylesAdapter.GetContentParams(NullDate, Nil).Font;
  FContentSmallFont.Assign(FContentFont);
  FContentSmallFont.Size := Round(FContentFont.Size * 2 / 3);
end;

function TcxSchedulerYearViewViewInfo.GetDaysCell(
  AIndex: Integer): TcxSchedulerYearViewContentCellViewInfo;
begin
  Result := TcxSchedulerYearViewContentCellViewInfo(FDayCells.List^[AIndex])
end;

function TcxSchedulerYearViewViewInfo.GetDaysCellCount: Integer;
begin
  Result := FDayCells.Count;
end;

function TcxSchedulerYearViewViewInfo.GetMonthBounds(AIndex: Integer): TRect;
begin
  Result := MonthHeaderCells[AIndex - FirstMonth + 1].Bounds;
  Result.Left := Result.Right;
  Result.Right := Bounds.Right;
end;

function TcxSchedulerYearViewViewInfo.GetYearView: TcxSchedulerYearView;
begin
  Result := TcxSchedulerYearView(inherited View);
end;

{ TcxSchedulerYearViewNavigation }

procedure TcxSchedulerYearViewNavigation.KeyDown(var AKey: Word;
  AShift: TShiftState);
begin
  FCurrentAnchor := Min(Max(FCurrentAnchor, View.FirstVisibleDate),
    View.LastVisibleDate);
  FCanChangeSelection := True;
  case AKey of
    VK_Left, VK_Right:
      GotoNextCellHorz(AKey = VK_RIGHT);
    VK_UP, VK_DOWN:
      GotoNextCellVert(AKey = VK_DOWN);
    VK_HOME, VK_END:
      GotoCornerCell(AKey = VK_END);
    VK_NEXT, VK_PRIOR:
      GotoNextPage(AKey = VK_NEXT);
  end;
  SetSelAnchor(FCurrentAnchor, AShift);
  if YearOf(FCurrentAnchor) <> ViewInfo.Year then
    View.Year := YearOf(FCurrentAnchor);
end;

procedure TcxSchedulerYearViewNavigation.ValidateSelection(
  var ASelStart, ASelFinish: TDateTime;
  var AResource: TcxSchedulerStorageResourceItem);
begin
  AResource := nil;
  FCanChangeSelection := FCanChangeSelection or View.HitTest.HitAtTime;
  if not FCanChangeSelection then
  begin
    ASelStart := FSaveSelStart;
    ASelFinish := FSaveSelFinish;
  end;
  ASelStart := Min(Max(ASelStart, View.FirstVisibleDate), View.LastVisibleDate);
  ASelFinish := Min(Max(ASelFinish, View.FirstVisibleDate), View.LastVisibleDate);
  if (View.MaxSelectedDaysCount > 0) then
    ASelFinish := Max(Min(ASelFinish, ASelStart + View.MaxSelectedDaysCount - 1),
      ASelStart - View.MaxSelectedDaysCount + 1);
  FSaveSelFinish := ASelFinish;
  FSaveSelStart := ASelStart;
  FCanChangeSelection := False;
end;

function TcxSchedulerYearViewNavigation.ContentCell(
  AIndex: Integer): TcxSchedulerYearViewContentCellViewInfo;
begin
  Result := TcxSchedulerYearViewContentCellViewInfo(ViewInfo.ContentCells.List^[AIndex]);
end;

procedure TcxSchedulerYearViewNavigation.DoKeyDown(
  var AKey: Word; AShift: TShiftState);
var
  APrevCurrentAnchor: TDateTime;
begin
  if Scheduler.SelectedEventCount > 0 then
    Scheduler.UnselectEvents;
  FCurrentAnchor := SelAnchor;
  FCurrentResource := SelResource;
  APrevCurrentAnchor := FCurrentAnchor;
  FShift := AShift;
  KeyDown(AKey, AShift);
  if YearOf(APrevCurrentAnchor) = YearOf(FCurrentAnchor) then
    ViewInfo.UpdateSelection;
end;

procedure TcxSchedulerYearViewNavigation.GotoCornerCell(AGotoEnd: Boolean);
var
  AMonth, AYear, ADay: Word;
begin
  if ssCtrl in FShift then
  begin
    if AGotoEnd then
      FCurrentAnchor := View.LastVisibleDate
    else
      FCurrentAnchor := View.FirstVisibleDate;
  end
  else
  begin
    DecodeDate(FCurrentAnchor, AYear, AMonth, ADay);
    if AGotoEnd then
      FCurrentAnchor := EncodeDate(AYear, AMonth, DaysPerMonth(AYear, AMonth))
    else
      FCurrentAnchor := EncodeDate(AYear, AMonth, 1);
  end;
end;

procedure TcxSchedulerYearViewNavigation.GotoNextCellHorz(AGotoNext: Boolean);
begin
  FCurrentAnchor := FCurrentAnchor + DayInc[AGotoNext];
  if YearOf(FCurrentAnchor) <> View.Year then
    View.Year := YearOf(FCurrentAnchor);
end;

procedure TcxSchedulerYearViewNavigation.GotoNextCellVert(AGoForward: Boolean);
var
  AYear, AMonth, ADay: Word;
  AIndex, AColIndex: Integer;
begin
  DecodeDate(FCurrentAnchor, AYear, AMonth, ADay);
  IncAMonth(AYear, AMonth, ADay, DayInc[AGoForward]);
  if AYear = ViewInfo.Year then
  begin
    AIndex := ViewInfo.FContentCells.IndexOf(ViewInfo.DaysCells[DayOfTheYear(FCurrentAnchor) - 1]);
    AColIndex := ContentCell(AIndex).FColIndex;
    AIndex := AIndex + DayInc[AGoForward];
    while ContentCell(AIndex).FColIndex <> AColIndex do
      Inc(AIndex, DayInc[AGoForward]);
    while ContentCell(AIndex).TimeStart = NullDate do
      Inc(AIndex, DayInc[AColIndex < 20]);
    FCurrentAnchor := ContentCell(AIndex).TimeStart;
  end
  else
    FCurrentAnchor := EncodeDate(AYear, AMonth, ADay);
end;

procedure TcxSchedulerYearViewNavigation.GotoNextPage(AGotoForward: Boolean);
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(FCurrentAnchor, AYear, AMonth, ADay);
  AYear := AYear + DayInc[AGotoForward];
  If (ADay = 29) and (AMonth = 2) then Dec(ADay);
  View.Year := AYear;
  FCurrentAnchor := EncodeDate(AYear, AMonth, ADay);
end;

function TcxSchedulerYearViewNavigation.GetYearView: TcxSchedulerYearView;
begin
  Result := TcxSchedulerYearView(inherited View);
end;

function TcxSchedulerYearViewNavigation.GetYearViewInfo: TcxSchedulerYearViewViewInfo;
begin
  Result := TcxSchedulerYearViewViewInfo(inherited ViewInfo);
end;

{ TcxSchedulerMonthHeaderCellViewInfo }

procedure TcxSchedulerMonthHeaderCellViewInfo.CalculateDisplayText;
begin
  DateTime := NullDate;
  if FMonth = 0 then
    DisplayText := IntToStr(FYear)
  else
    DisplayText := LongMonthNames[FMonth];
end;

procedure TcxSchedulerMonthHeaderCellViewInfo.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  if FMonth = 0 then
    TcxSchedulerYearViewHitTest(AHitTest).SetHitTime(htcYear, EncodeDate(Year, 1, 1))
  else
    TcxSchedulerYearViewHitTest(AHitTest).SetHitTime(htcMonth, EncodeDate(Year, FMonth, 1));
end;

procedure TcxSchedulerMonthHeaderCellViewInfo.SetMonth(AValue: Integer);
begin
  FMonth := AValue;
  CalculateDisplayText;
end;

procedure TcxSchedulerMonthHeaderCellViewInfo.SetYear(AValue: Integer);
begin
  FYear := AValue;
  CalculateDisplayText;
end;

{ TcxSchedulerYearViewContentCellViewInfo }

procedure TcxSchedulerYearViewContentCellViewInfo.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  if Self.TimeStart <> NullDate then
    inherited InitHitTest(AHitTest);
end;

{ TcxYearViewDragEventHelper }

procedure TcxYearViewDragEventHelper.UpdateViewClonesTime;
var
  I: Integer;
  ANewStart, ADelta: TDateTime;
  AShift: TDateTime;
  View: TcxSchedulerYearView;
begin
  View := TcxSchedulerYearViewViewInfo(ViewInfo).GetYearView;
  AShift := HitTest.Time - Controller.StartDragHitTime;
  for I := 0 to Clones.Count - 1 do
  begin
    ANewStart := AShift + Clones[I].Source.Start;
    ADelta := Max(0, View.GetFirstVisibleDate - DateOf(ANewStart));
    if ADelta = 0 then
    begin
      ADelta := Min(0, View.GetLastVisibleDate - DateOf(ANewStart) -
        DateOf(Clones[I].Duration) + Ord(Clones[I].AllDayEvent));
    end;
    Clones[I].MoveTo(ANewStart + ADelta);
  end;
end;

{ TcxYearViewEventSizing }

procedure TcxYearViewEventSizing.UpdateEventBounds;
begin
  if Event.AllDayEvent then
    inherited UpdateEventBounds
  else
  begin
    if Controller.DragKind = edkResizeStart then
    begin
      Event.AllDayEvent := TimeOf(Event.Finish) = 0;
      Event.Start := HitTest.Time;
    end
    else
    begin
      Event.AllDayEvent := TimeOf(Event.Start) = 0;
      if Event.AllDayEvent then
        Event.Finish := HitTest.Time
      else
        Event.Finish := HitTest.Time + 1;
    end;
    CheckEventState(Event);
    RefreshCurrentView;
  end;
end;

{ TcxSchedulerYearViewStyles }

constructor TcxSchedulerYearViewStyles.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FYearView := TcxSchedulerYearView(GetOwner);
  FScheduler := FYearView.Scheduler;
  BitmapInViewParams := True;
end;

procedure TcxSchedulerYearViewStyles.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TcxSchedulerYearViewStyles then
    for I := 0 to cxcsMaxYearViewStyle do
      SetValue(I, TcxSchedulerYearViewStyles(Source).GetValue(I));
  inherited Assign(Source);
end;

function TcxSchedulerYearViewStyles.GetMonthHeaderParams(
  AYear, AMonth: Integer): TcxViewParams;
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetMonthHeaderStyle) then
    FOnGetMonthHeaderStyle(YearView, AYear, AMonth, AStyle);
  GetViewParams(cxcsMonthHeader, nil, AStyle, Result);
end;

function TcxSchedulerYearViewStyles.GetUnusedContentParams(
  AYear, AMonth, ADayOfWeek: Integer): TcxViewParams;
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetUnusedContentStyle) then
    FOnGetUnusedContentStyle(YearView, AYear, AMonth, ADayOfWeek, AStyle);
  GetViewParams(cxcsUnusedContent, Pointer(ADayOfWeek), AStyle, Result);
  with YearView do
  begin
    if (AStyle = nil) or not (svColor in AStyle.AssignedValues) then
    begin
      Result.Color := PainterHelper.GetContentColor(Result.Color,
         TDay(ADayOfWeek) in OptionsView.WorkDays);
    end;
  end;
end;

procedure TcxSchedulerYearViewStyles.Changed(AIndex: Integer);
begin
  inherited Changed(AIndex);
  FYearView.Refresh;
end;

procedure TcxSchedulerYearViewStyles.GetDefaultViewParams(Index: Integer;
  AData: TObject; out AParams: TcxViewParams);
begin
  AParams.Bitmap := nil;
  AParams.Font := Scheduler.Font;
  AParams.TextColor := clBlack;
  AParams.Color := Scheduler.Color;
  case Index of
    cxcsUnusedContent:
      begin
        with FYearView do
        begin
          AParams.Color := PainterHelper.GetContentColor(
            clBtnFace, TDay(Integer(AData) - 1) in OptionsView.WorkDays);
        end;
      end;
    cxcsMonthHeader:
      begin
        AParams.Color := Painter.DefaultHeaderColor;
        AParams.TextColor := Painter.DefaultHeaderTextColor;
      end;
  end;
end;

function TcxSchedulerYearViewStyles.GetPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := FYearView.LookAndFeelPainter;
end;

{ TcxSchedulerYearView }

procedure TcxSchedulerYearView.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerYearView then
    with TcxSchedulerYearView(Source) do
    begin
      Self.FMaxSelectedDaysCount := FMaxSelectedDaysCount;
      Self.FAllDayEventsOnly := FAllDayEventsOnly;
      Self.FStyles.Assign(FStyles);
    end;
  inherited Assign(Source);
end;

procedure TcxSchedulerYearView.CreateSubClasses;
begin
  FStyles := CreateStyles;
  inherited CreateSubClasses;
end;

procedure TcxSchedulerYearView.DestroySubClasses;
begin
  inherited DestroySubClasses;
  FStyles.Free;
end;

function TcxSchedulerYearView.CanDeactivateOnDateNavigatorSelectionChange: Boolean;
begin
  Result := False;
end;

function TcxSchedulerYearView.CanSelectPeriod: Boolean;
begin
  Result := False;
end;

function TcxSchedulerYearView.CreateController: TcxSchedulerSubControlController;
begin
  Result := TcxSchedulerYearViewController.Create(Self);
end;

function TcxSchedulerYearView.CreateHitTest: TcxSchedulerSubControlHitTest;
begin
  Result := TcxSchedulerYearViewHitTest.Create(Self);
end;

function TcxSchedulerYearView.CreatePainter: TcxSchedulerSubControlPainter;
begin
  Result := TcxSchedulerYearViewPainter.Create(Self);
end;

function TcxSchedulerYearView.CreateStyles: TcxSchedulerYearViewStyles;
begin
  Result := TcxSchedulerYearViewStyles.Create(Self);
end;

function TcxSchedulerYearView.CreateViewInfo: TcxSchedulerSubControlViewInfo;
begin
  Result := TcxSchedulerYearViewViewInfo.Create(Self);
end;

function TcxSchedulerYearView.GetCompressWeekEnd: Boolean;
begin
  Result := False;
end;

function TcxSchedulerYearView.GetGroupingKind: TcxSchedulerGroupingKind;
begin
  Result := gkNone;
end;

function TcxSchedulerYearView.GetFirstVisibleDate: TDateTime;
begin
  Result := EncodeDate(Year, 1, 1);
end;

function TcxSchedulerYearView.GetLastVisibleDate: TDateTime;
begin
  Result := EncodeDate(Year, 12, 31);
end;

function TcxSchedulerYearView.GetScrollPos: Integer;
begin
  Result := Max(cxYearViewScrollMinPos,
    Min(cxYearViewScrollMaxPos,
    (Year - YearOf(Now) + cxYearViewScrollCurrentYearPos)));
end;

function TcxSchedulerYearView.GetVisibleDaysRange: Integer;
begin
  Result := Trunc(GetLastVisibleDate - GetFirstVisibleDate);
end;

procedure TcxSchedulerYearView.InitScrollBarsParameters;
var
  APos: Integer;
begin
  inherited InitScrollBarsParameters;
  APos := GetScrollPos;
  SetScrollBarInfo(sbVertical, cxYearViewScrollMinPos, cxYearViewScrollMaxPos,
    1, 1, APos, True, True);
end;

procedure TcxSchedulerYearView.MakeEventVisible(AEvent: TcxSchedulerControlEvent;
  const ADate: TDateTime; AResource: TcxSchedulerStorageResourceItem);
begin
  if (ADate <> NullDate) and (YearOf(ADate) <> Year) then
  begin
    Year := YearOf(ADate);
    LayoutChanged;
  end;
end;

procedure TcxSchedulerYearView.Notification(AComponent: TComponent;
  Operation: TOperation); 
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent = Styles.UnusedContent then
      Styles.UnusedContent := nil;
    if AComponent = Styles.MonthHeader then
      Styles.MonthHeader := nil;
  end;
end;

procedure TcxSchedulerYearView.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);
var
  AYear: Integer;
begin
  HideHintOnScroll(AScrollCode);
  AYear := YearOf(Now) - cxYearViewScrollCurrentYearPos + AScrollPos;
  case AScrollCode of
    scTrack:
      begin
        ShowHintOnScroll(IntToStr(AYear), sbHorizontal);
        Exit;
      end;
    scPosition:
      Year := AYear;
    scLineUp, scPageUp:
      Year := Year - 1;
    scLineDown, scPageDown:
      Year := Year + 1;
  end;
  AScrollPos := GetScrollPos;
end;

procedure TcxSchedulerYearView.SelectedDaysChanged;
begin
  if SelectedDays.Count > 0 then
    Year := YearOf(SelectedDays[0]);
end;

function TcxSchedulerYearView.GetHitTest: TcxSchedulerYearViewHitTest;
begin
  Result := TcxSchedulerYearViewHitTest(inherited HitTest);
end;

function TcxSchedulerYearView.GetYear: Word;
begin
  Result := YearOf(inherited GetFirstVisibleDate);
end;

procedure TcxSchedulerYearView.SetAllDayEventsOnly(AValue: Boolean);
begin
  if FAllDayEventsOnly <> AValue then
  begin
    FAllDayEventsOnly := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerYearView.SetMaxSelectedDaysCount(
  AValue: Integer);
begin
  AValue := Max(0, AValue);
  if AValue <> FMaxSelectedDaysCount then
  begin
    FMaxSelectedDaysCount := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerYearView.SetStyles(AValue: TcxSchedulerYearViewStyles);
begin
  FStyles.Assign(AValue);
end;

procedure TcxSchedulerYearView.SetYear(AValue: Word);
begin
  if AValue <> Year then
  begin
    Scheduler.DateNavigator.BeginUpdate;
    try
      SelectedDays.Clear;
      SelectedDays.Add(EncodeDate(AValue, 1, 1));
      UpdateDateNavigatorSelection;
      Changed;
    finally
      Scheduler.DateNavigator.EndUpdate;
    end;
  end;
end;

end.
