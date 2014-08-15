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

unit cxSchedulerWeekView;

{$I cxVer.inc}

interface

uses
  Windows, Forms, Classes, cxClasses, SysUtils, Graphics, cxGraphics,
  cxDateUtils, Controls, cxControls, cxSchedulerCustomControls, Math, StdCtrls,
  cxLookAndFeelPainters, cxGeometry, cxSchedulerStorage, cxSchedulerUtils,
  {$IFDEF DELPHI6} DateUtils, {$ENDIF} cxStyles, cxSchedulerCustomResourceView;

type
  TcxSchedulerCustomWeekView = class;
  TcxSchedulerWeekViewViewInfo = class;
  TcxSchedulerWeeksViewViewInfo = class;
  TcxSchedulerCustomWeekViewNavigation = class; 

  { TcxSchedulerCustomWeekViewController }

  TcxSchedulerCustomWeekViewController = class(TcxSchedulerCustomResourceViewController)
  private
    function GetNavigation: TcxSchedulerCustomWeekViewNavigation;
  protected
    function CreateDragEventHelper: TcxDragEventHelper; override;
    function CreateNavigation: TcxSchedulerViewNavigation; override;
    function CreateResizeEventHelper: TcxEventSizingHelper; override;
  public
    property Navigation: TcxSchedulerCustomWeekViewNavigation read GetNavigation;
  end;

  { TcxCustomWeekViewDragEventHelper }

  TcxCustomWeekViewDragEventHelper = class(TcxDragEventHelper)
  protected
    procedure CorrectAllDayEventProperty; override;
    procedure UpdateClonesTime; override;
  end;

  { TcxCustomWeekViewEventSizing }

  TcxCustomWeekViewEventSizing = class(TcxEventSizingHelper)
  protected
    procedure UpdateEventBounds; override;
  end;

  { TcxSchedulerCustomWeekView }

  TcxSchedulerCustomWeekView = class(TcxSchedulerCustomResourceView)
  private
    FCompressWeekEnd: Boolean;
    function GetController: TcxSchedulerCustomWeekViewController;
    function GetScrollPos(const ADatePos: TDateTime; ACheckBounds: Boolean = True): Integer;
    procedure SetCompressWeekEnd(const AValue: Boolean);
  protected
    FWeeks: TcxSchedulerDateList;
    function CheckDate(const ADate: TDateTime): Integer;
    function CreateController: TcxSchedulerSubControlController; override;
    function CreateNavigation: TcxSchedulerViewNavigation; virtual;
    function CreatePainter: TcxSchedulerSubControlPainter; override;
    function GetCompressWeekEnd: Boolean; override;
    function GetFirstVisibleDate: TDateTime; override;
    function GetLastVisibleDate: TDateTime; override;
    function GetMaxScrollPos: Integer; virtual;
    function GetMinScrollPos: Integer; virtual;
    function GetWeekCount: Integer;
    function GetStartOfWeek: TDay; override;
    procedure InitEventBySelectedPeriod(AEvent: TcxSchedulerEvent;
      AllDay: Boolean; ARecurrence: Boolean; AInplaceEditing: Boolean); override;
    procedure InitScrollBarsParameters; override;
    procedure Scroll(AScrollBarKind: TScrollBarKind;
      AScrollCode: TScrollCode; var AScrollPos: Integer); override;

    property Controller: TcxSchedulerCustomWeekViewController read GetController;
    property CompressWeekEnd: Boolean read FCompressWeekEnd write SetCompressWeekEnd default True;
    property WeekCount: Integer read GetWeekCount;
  public
    constructor Create(AOwner: TcxCustomScheduler); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property FirstVisibleDate;
    property LastVisibleDate;
    property StartOfWeek;
  end;

  { TcxSchedulerCustomWeekViewNavigation }

  TcxSchedulerCustomWeekViewNavigation = class(TcxSchedulerCustomResourceViewNavigation)
  private
    function GetCompress: Boolean;
    function GetFirstVisibleDate: TDateTime;
    function GetLastVisibleDate: TDateTime;
    function GetView: TcxSchedulerCustomWeekView;
    function GetWeeks: TcxSchedulerDateList;
  protected
    FYear: Word;
    FWeekOfYear: Word;
    FWeekIndex: Integer;
    FDayOfWeek: Word;
    IsFirstWeek, IsLastWeek: Boolean;
    function GetWeekStart(AIndex: Integer): TDateTime;
    procedure GotoCornerCell(AGotoEnd: Boolean); virtual;
    procedure GotoNextCellHorz(AGotoNext: Boolean); virtual;
    procedure GotoNextCellVert(AGotoDown: Boolean); virtual;
    procedure GotoNextPage(AGotoForward: Boolean); virtual;
  public
    procedure ValidateSelection(var ASelStart, ASelFinish: TDateTime;
      var AResource: TcxSchedulerStorageResourceItem); override;
    procedure KeyDown(var AKey: Word; AShift: TShiftState); override;
    property Compress: Boolean read GetCompress;
    property FirstVisibleDate: TDateTime read GetFirstVisibleDate;
    property LastVisibleDate: TDateTime read GetLastVisibleDate;
    property View: TcxSchedulerCustomWeekView read GetView;
    property Weeks: TcxSchedulerDateList read GetWeeks;
  end;

  { TcxSchedulerWeekView }

  TcxSchedulerWeekView = class(TcxSchedulerCustomWeekView)
  private
    function GetViewInfo: TcxSchedulerWeekViewViewInfo;
  protected
    function CreateNavigation: TcxSchedulerViewNavigation; override;
    function CreateViewInfo: TcxSchedulerSubControlViewInfo; override;
    function GetCompressWeekEnd: Boolean; override;
    property ViewInfo: TcxSchedulerWeekViewViewInfo read GetViewInfo;
  public
    property SelectedDays;
    property WorkDays;
    property WorkFinish;
    property WorkStart;
  published
    property CanShow;
    property Active;
    property CompressWeekEnd;
    property GroupingKind;
    property ShowEndTime;
    property ShowTimeAsClock;
  end;

  { TcxSchedulerWeekViewNavigation }

  TcxSchedulerWeekViewNavigation = class(TcxSchedulerCustomWeekViewNavigation)
  private
    function GetViewInfo: TcxSchedulerWeekViewViewInfo;
  protected
    procedure GotoNextCellHorz(AGotoNext: Boolean); override;
    procedure GotoNextCellVert(AGotoDown: Boolean); override;
  public
    property ViewInfo: TcxSchedulerWeekViewViewInfo read GetViewInfo;
  end;

  { TcxSchedulerWeeksView }

  TcxSchedulerWeeksView = class(TcxSchedulerCustomWeekView)
  private
    function GetViewInfo: TcxSchedulerWeeksViewViewInfo;
  protected
    function CreateNavigation: TcxSchedulerViewNavigation; override;
    function CreateViewInfo: TcxSchedulerSubControlViewInfo; override;
    function GetMaxScrollPos: Integer; override;
    function GetMinScrollPos: Integer; override;

    property ViewInfo: TcxSchedulerWeeksViewViewInfo read GetViewInfo;
  public
    property SelectedDays;
    property WeekCount;
    property WorkDays;
    property WorkFinish;
    property WorkStart;
  published
    property CanShow;
    property Active;
    property CompressWeekEnd;
    property GroupingKind;
    property ShowEndTime;
    property ShowTimeAsClock;
  end;

  { TcxSchedulerWeeksViewNavigation }

  TcxSchedulerWeeksViewNavigation = class(TcxSchedulerCustomWeekViewNavigation)
  private
    function GetViewInfo: TcxSchedulerWeeksViewViewInfo;
  protected
    procedure GotoNextCellHorz(AGotoNext: Boolean); override;
    procedure GotoNextPage(AGotoForward: Boolean); override;
  public
    property ViewInfo: TcxSchedulerWeeksViewViewInfo read GetViewInfo;
  end;

  { TcxSchedulerWeekViewViewInfo }

  TcxSchedulerWeekViewViewInfo = class(TcxSchedulerCustomResourceViewViewInfo)
  private
    function GetDayCell(ADay: Integer): TcxSchedulerContentCellViewInfo;
    function GetDayCellCount: Integer;
    function GetRotateCaptions: Boolean;
    function GetStartDate(AWeek: Integer): TDateTime;
    function GetView: TcxSchedulerWeekView;
    function GetWeeks: TcxSchedulerDateList;
  protected
    FDayHeaderOffsetTop: Integer;
    FHeaderOffsetLeft: Integer;
    FPrintedMonth: Word;
    FPrintExactlyOneMonth: Boolean;
    FResourceHeaderWidth: Integer;
    FRowCols: Integer;
    FRowColsStart: Integer;
    FWeekEndCells: Integer;
    function AddContentCell(const ARect: TRect; const AStart, AFinish: TDateTime;
      AResourceIndex: Integer): TcxSchedulerContentCellViewInfo; override;
    procedure AddDayCellEvent(AEvent: TcxSchedulerControlEvent;
      ADay: TcxSchedulerContentCellViewInfo; AIndex: Integer);
    function AddWeekDayHeader(AWeekDay: Integer; ALeft, ARight: Integer): TcxSchedulerWeekDayHeaderCellViewInfo;
    procedure CalculateDaysLayout; virtual;
    procedure CalculateDaysLayoutForResource(const ABounds: TRect; AResourceIndex: Integer); virtual;
    procedure CalculateDaysLayoutForDates(const ABounds: TRect; AResourceIndex: Integer); virtual;
    procedure CalculateEventsViewInfo; virtual;
    procedure CalculateGroupByDateForResource(const ABounds: TRect; AResourceIndex: Integer); virtual;
    procedure CalculateHeaderViewInfo; virtual;
    procedure CalculateMetrics; override;
    procedure CalculatePrintRowCols; virtual;
    procedure CalculateStartFinishCellIndexes; virtual;
    procedure CalculateWeekDates;
    procedure CalculateWeekDisplayRectsHorz(const AStartDate: TDateTime; AResourceID: Integer;
      {const }ABounds: TRect; AIsTopWeek, AIsLastWeek: Boolean); virtual;
    procedure CalculateWeekDisplayRectsVert(const AStartDate: TDateTime; AResourceID: Integer;
      const ABounds: TRect; AddBorders: TcxBorders = []); virtual;
    function CanEventVisible(AEvent: TcxSchedulerControlEvent): Boolean;
    function CanVisibleNextLine(ADay: TcxSchedulerContentCellViewInfo; ALine: Integer = -1): Boolean;
    procedure CheckHeaderBorders; virtual;
    function CompressWeekEnd: Boolean; virtual;
    function ContentCellClass: TcxSchedulerContentCellViewInfoClass; override;
    procedure DoCalculate; override;
    function GetContentParams(const ATime: TDateTime; AResource: TcxSchedulerResourceViewInfo): TcxViewParams; override;
    function GetDayCellContentHeight(ADay: TcxSchedulerContentCellViewInfo): Integer; virtual;
    function GetDayCellHeaderHeight: Integer; virtual;
    function IsCalculateHeaderFirst: Boolean; virtual;
    function IsCellEvent(AEvent: TcxSchedulerControlEvent;
      ACell: TcxSchedulerContentCellViewInfo): Boolean;
    function IsSingleLine(ADay1, ADay2: TcxSchedulerContentCellViewInfo): Boolean;
    function IsTimeSelected(ATime: TDateTime; AResource: TObject): Boolean; override;
    procedure OnClickMoreButton(Sender: TcxSchedulerMoreEventsButtonViewInfo); override;
    procedure ProcessGroupByDate; virtual;
    procedure ProcessGroupByNone; virtual;
    procedure ProcessGroupByResource; virtual;

    property DayCellCount: Integer read GetDayCellCount;
    property DayCells[ADay: Integer]: TcxSchedulerContentCellViewInfo read GetDayCell;
    property RowCols: Integer read FRowCols;
    property RowColsStart: Integer read FRowColsStart;
    property Weeks: TcxSchedulerDateList read GetWeeks;
    property WeekEndCells: Integer read FWeekEndCells;
  public
    procedure ScrollVertical(AScrollCode: TScrollCode; var AScrollPos: Integer); override;
    property PrintExactlyOneMonth: Boolean read FPrintExactlyOneMonth;
    property PrintedMonth: Word read FPrintedMonth;
    property StartDates[AWeek: Integer]: TDateTime read GetStartDate;
    property ResourceHeaderWidth: Integer read FResourceHeaderWidth;
    property RotateCaptions: Boolean read GetRotateCaptions;
    property View: TcxSchedulerWeekView read GetView;
  end;

  { TcxSchedulerWeeksViewViewInfo }

  TcxSchedulerWeeksViewViewInfo = class(TcxSchedulerWeekViewViewInfo)
  protected
    FContentOffset: Integer;
    procedure CalculateDaysLayoutForResource(const ABounds: TRect; AResourceIndex: Integer); override;
    procedure CalculateGroupByDateForResource(const ABounds: TRect; AResourceIndex: Integer); override;
    procedure CalculateHeaderViewInfo; override;
    procedure CheckHeaderBorders; override;
    function CompressWeekEnd: Boolean; override;
    function ContentCellClass: TcxSchedulerContentCellViewInfoClass; override;
    function GetContentParams(const ATime: TDateTime; AResource: TcxSchedulerResourceViewInfo): TcxViewParams; override;
    function GetDayCellHeaderHeight: Integer; override;
    function IsCalculateHeaderFirst: Boolean; override;
    procedure ProcessGroupByNone; override;
    procedure ProcessGroupByResource; override;
  end;

  { TcxSchedulerWeekViewPainter }

  TcxSchedulerWeekViewPainter = class(TcxSchedulerCustomViewPainter)
  private
    function GetViewInfo: TcxSchedulerWeekViewViewInfo;
  public
    procedure Paint; override;
    
    property ViewInfo: TcxSchedulerWeekViewViewInfo read GetViewInfo;
  end;

implementation

uses
  cxSchedulerDateNavigator;

type
  TcxSchedulerDaysRect = array[0..6] of TRect;
  TcxSchedulerDaysBorders = array[0..6] of TcxBorders;

const
  WeekViewDayBorders: TcxSchedulerDaysBorders =(
    [bTop, bRight], [bTop, bRight], [bTop, bRight],
    [bTop], [bTop], [bTop], [bTop]);
  DayInc: array[Boolean] of Integer = (-1, 1);

{ TcxSchedulerCustomWeekViewController }

function TcxSchedulerCustomWeekViewController.CreateDragEventHelper: TcxDragEventHelper;
begin
  Result := TcxCustomWeekViewDragEventHelper.Create(Scheduler);
end;

function TcxSchedulerCustomWeekViewController.CreateNavigation: TcxSchedulerViewNavigation;
begin
  Result := TcxSchedulerCustomWeekView(View).CreateNavigation;
end;

function TcxSchedulerCustomWeekViewController.CreateResizeEventHelper: TcxEventSizingHelper;
begin
  Result := TcxCustomWeekViewEventSizing.Create(Scheduler);
end;

function TcxSchedulerCustomWeekViewController.GetNavigation: TcxSchedulerCustomWeekViewNavigation;
begin
  Result := TcxSchedulerCustomWeekViewNavigation(inherited Navigation);
end;

{cxCustomWeekViewDragEventHelper }

procedure TcxCustomWeekViewDragEventHelper.CorrectAllDayEventProperty;
begin
  RestoreAllDayProperties;
end;

procedure TcxCustomWeekViewDragEventHelper.UpdateClonesTime;
var
  I: Integer;
  ADelta: TDateTime;
begin
  if HitTest.HitAtTime and not InNavigator then
  begin
    ADelta := Controller.StartDragHitTime - HitTest.Time;
    for I := 0 to Clones.Count - 1 do
      with Clones[I] do
        MoveTo(Source.Start - ADelta);
  end;
end;

{ TcxCustomWeekViewEventSizing }

procedure TcxCustomWeekViewEventSizing.UpdateEventBounds;
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
    RefreshCurrentView;
  end;
end;

{ TcxSchedulerCustomWeekView }

constructor TcxSchedulerCustomWeekView.Create(AOwner: TcxCustomScheduler);
begin
  inherited Create(AOwner);
  FCompressWeekEnd := True;
  FWeeks := TcxSchedulerDateList.Create;
end;

destructor TcxSchedulerCustomWeekView.Destroy;
begin
  FWeeks.Free;
  inherited Destroy;
end;

procedure TcxSchedulerCustomWeekView.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerCustomWeekView then
    CompressWeekEnd := TcxSchedulerCustomWeekView(Source).FCompressWeekEnd;
  inherited Assign(Source);
end;

function TcxSchedulerCustomWeekView.CheckDate(
  const ADate: TDateTime): Integer;
begin
  //DELPHI8! check Trunc(ADate)
  Result := Trunc(ADate);
  if DayOfWeek(ADate) <> (1 + Byte(CompressWeekEnd)) then
    Result := Result - DayOfWeek(ADate) + 1 + Byte(CompressWeekEnd);
end;

function TcxSchedulerCustomWeekView.CreateController: TcxSchedulerSubControlController;
begin
  Result := TcxSchedulerCustomWeekViewController.Create(Self);
end;

function TcxSchedulerCustomWeekView.CreateNavigation: TcxSchedulerViewNavigation;
begin
  Result := TcxSchedulerCustomWeekViewNavigation.Create(Self);
end;

function TcxSchedulerCustomWeekView.CreatePainter: TcxSchedulerSubControlPainter;
begin
  Result := TcxSchedulerWeekViewPainter.Create(Self);
end;

function TcxSchedulerCustomWeekView.GetCompressWeekEnd: Boolean;
begin
  Result := CompressWeekEnd;
end;

function TcxSchedulerCustomWeekView.GetFirstVisibleDate: TDateTime;
begin
  Result := inherited GetFirstVisibleDate;
  if GetCompressWeekEnd then
    Result := Result + GetDateOffset;
end;

function TcxSchedulerCustomWeekView.GetLastVisibleDate: TDateTime;
begin
  Result := inherited GetLastVisibleDate;
  if GetCompressWeekEnd then
    Result := Result + GetDateOffset;
end;

function TcxSchedulerCustomWeekView.GetMaxScrollPos: Integer;
begin
  Result := 25;
end;

function TcxSchedulerCustomWeekView.GetMinScrollPos: Integer;
begin
  Result := -25;
end;

function TcxSchedulerCustomWeekView.GetWeekCount: Integer;
begin
  Result := Max(1, SelectedDays.Count div 7);
end;

function TcxSchedulerCustomWeekView.GetStartOfWeek: TDay;
begin
  if GetCompressWeekEnd then
    Result := dMonday
  else
    Result := inherited GetStartOfWeek;
end;

procedure TcxSchedulerCustomWeekView.InitEventBySelectedPeriod(
  AEvent: TcxSchedulerEvent; AllDay: Boolean; ARecurrence: Boolean;
  AInplaceEditing: Boolean);
var
  AStart, AFinish: TDateTime;
begin
  AStart := Scheduler.SelStart;
  AFinish := Scheduler.SelFinish;
  AEvent.AllDayEvent := AllDay or (AFinish - AStart > 1) or (AInplaceEditing and not ARecurrence);
  if not AEvent.AllDayEvent then
  begin
    AStart := AStart + cxTime8AM;
    AFinish := (AFinish - 1) + cxTime8AM + cxHalfHour;
  end;
  AEvent.Start := AStart;
  AEvent.Finish := AFinish;
end;

procedure TcxSchedulerCustomWeekView.InitScrollBarsParameters;
begin
  SetScrollBarInfo(sbVertical, GetMinScrollPos, GetMaxScrollPos,
    1, WeekCount, GetScrollPos(FirstVisibleDate), True, True);
end;

procedure TcxSchedulerCustomWeekView.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);
var
  ANewSelDate: TDateTime;
  ADelta: Integer;
begin
  HideHintOnScroll; 
  if (AScrollBarKind = sbHorizontal) or (AScrollCode = scEndScroll) then Exit;
  ADelta := GetScrollPos(FirstVisibleDate, False);
  if not (AScrollCode in [scPosition, scTrack]) then
    AScrollPos := ADelta;
  ANewSelDate := Controller.Navigation.SelStart;
  case AScrollCode of
    scLineUp, scLineDown:
    begin
      Inc(AScrollPos, DayInc[AScrollCode <> scLineUp]);
      ANewSelDate := ANewSelDate + DayInc[AScrollCode <> scLineUp] * 7;
    end;
    scPageUp, scPageDown:
    begin
      Inc(AScrollPos, DayInc[AScrollCode <> scPageUp] * WeekCount);
      with Controller.Navigation do
        ANewSelDate := ANewSelDate + DayInc[AScrollCode <> scPageUp] * Weeks.Count * 7;
    end;
    scTop:
      AScrollPos := -GetMinScrollPos;
    scBottom:
      AScrollPos := GetMaxScrollPos;
  end;
  ADelta := ADelta - AScrollPos;
  if ADelta <> 0 then
  begin
    ScrollSelectedDays(ADelta);
    AScrollPos := GetScrollPos(FirstVisibleDate);
  end;
  if AScrollCode = scTrack then
    ShowHintOnScroll(FirstVisibleDate);
  with Scheduler do
    SelectTime(ANewSelDate, ANewSelDate, SelResource);
end;

function TcxSchedulerCustomWeekView.GetController: TcxSchedulerCustomWeekViewController;
begin
  Result := TcxSchedulerCustomWeekViewController(inherited Controller);
end;

function TcxSchedulerCustomWeekView.GetScrollPos(
  const ADatePos: TDateTime; ACheckBounds: Boolean = True): Integer;
begin
  Result := Round(ADatePos - CheckDate(Date)) div 7;
  if ACheckBounds then
  begin
    if Result < GetMinScrollPos then
      Result := GetMinScrollPos;
    if Result > GetMaxScrollPos then
      Result := GetMaxScrollPos;
  end;
end;

procedure TcxSchedulerCustomWeekView.SetCompressWeekEnd(
  const AValue: Boolean);
begin
  if FCompressWeekEnd <> AValue then
  begin
    FCompressWeekEnd := AValue;
    LayoutChanged;
  end;
end;

{ TcxSchedulerCustomWeekViewNavigation }

procedure TcxSchedulerCustomWeekViewNavigation.KeyDown(
  var AKey: Word; AShift: TShiftState);
var
  APos: Integer;
begin
  DecodeDateWeek(FCurrentAnchor + 1 - Byte(View.StartOfWeek),
    FYear, FWeekOfYear, FDayOfWeek);
  Dec(FDayOfWeek);
  FWeekIndex := Max(0, Weeks.IndexOf(Trunc(EncodeDateWeek(FYear, FWeekOfYear, 1))));
  IsFirstWeek := (FWeekIndex = 0) and IsFirstResource;
  IsLastWeek := (FWeekIndex = Weeks.Count - 1) and IsLastResource;
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
  APos := View.GetScrollPos(View.FirstVisibleDate, False);
  if (ssShift in FShift) and ((FCurrentResource <> SelResource) or
    (DateOf(FCurrentAnchor) < FirstVisibleDate) or (DateOf(FCurrentAnchor) > LastVisibleDate)) then
    Exit
  else
    if DateOf(FCurrentAnchor) < FirstVisibleDate then
    begin
      View.Scroll(sbVertical, scLineUp, APos);
      SetSelAnchor(FCurrentAnchor, [], FCurrentResource);
    end
    else
      if DateOf(FCurrentAnchor) > LastVisibleDate then
      begin
        View.Scroll(sbVertical, scLineDown, APos);
        SetSelAnchor(FCurrentAnchor, [], FCurrentResource);
      end
      else
        SetSelAnchor(FCurrentAnchor, FShift, FCurrentResource);
end;

procedure TcxSchedulerCustomWeekViewNavigation.ValidateSelection(
  var ASelStart, ASelFinish: TDateTime;
  var AResource: TcxSchedulerStorageResourceItem);
begin
  inherited ValidateSelection(ASelStart, ASelFinish, AResource);
  if (DateOf(ASelFinish) < FirstVisibleDate) or (DateOf(ASelFinish) > LastVisibleDate) then
  begin
    ASelFinish := FirstVisibleDate;
    ASelStart := ASelFinish;
  end
end;

function TcxSchedulerCustomWeekViewNavigation.GetWeekStart(AIndex: Integer): TDateTime;
begin
  Result := Weeks[FWeekIndex];
  if not View.GetCompressWeekEnd then
    Result := Result - View.GetDateOffset;
end;

procedure TcxSchedulerCustomWeekViewNavigation.GotoCornerCell(
  AGotoEnd: Boolean);
begin
  if ssCtrl in FShift then
  begin
    if AGotoEnd then
      FCurrentAnchor := LastVisibleDate
    else
      FCurrentAnchor := FirstVisibleDate;
  end
  else
  begin
    FCurrentAnchor := GetWeekStart(FWeekIndex);
    if AGotoEnd then
      FCurrentAnchor := FCurrentAnchor + 6;
  end;
end;

procedure TcxSchedulerCustomWeekViewNavigation.GotoNextCellHorz(
  AGotoNext: Boolean);
begin
  FCurrentAnchor := FCurrentAnchor + DayInc[AGoToNext];
end;

procedure TcxSchedulerCustomWeekViewNavigation.GotoNextCellVert(
  AGotoDown: Boolean);
begin
  Inc(FWeekIndex, DayInc[AGotoDown]);
  if (FWeekIndex >= 0) and (FWeekIndex < Weeks.Count) then
    FCurrentAnchor := GetWeekStart(FWeekIndex)
  else
    if AGotoDown then
    begin
      if IsLastWeek then
        FCurrentAnchor := LastVisibleDate + 1
      else
        if FWeekIndex = Weeks.Count then
        begin
          FCurrentAnchor := FirstVisibleDate;
          FCurrentResource := GetNextResource(True)
        end
    end
    else
    begin
      if IsFirstWeek then
        FCurrentAnchor := FirstVisibleDate - 7
      else
        if FWeekIndex <= 0 then
        begin
          FCurrentAnchor := LastVisibleDate - 7 + 1;
          FCurrentResource := GetNextResource(False);
        end
    end;
  FCurrentAnchor := FCurrentAnchor + FDayOfWeek;
end;

procedure TcxSchedulerCustomWeekViewNavigation.GotoNextPage(
  AGotoForward: Boolean);
begin
  if not (ssShift in FShift) then
  begin
    FCurrentAnchor := FCurrentAnchor + DayInc[AGotoForward] * Weeks.Count * 7;
    View.ScrollSelectedDays(DayInc[not AGotoForward] * Weeks.Count);
  end
  else
  begin
    if AGotoForward then
      FCurrentAnchor := LastVisibleDate
    else
      FCurrentAnchor := FirstVisibleDate;
  end;
end;

function TcxSchedulerCustomWeekViewNavigation.GetCompress: Boolean;
begin
  Result := View.GetCompressWeekEnd;
end;

function TcxSchedulerCustomWeekViewNavigation.GetFirstVisibleDate: TDateTime;
begin
  Result := View.FirstVisibleDate;
end;

function TcxSchedulerCustomWeekViewNavigation.GetLastVisibleDate: TDateTime;
begin
  Result := View.LastVisibleDate;
end;

function TcxSchedulerCustomWeekViewNavigation.GetView: TcxSchedulerCustomWeekView;
begin
  Result := TcxSchedulerCustomWeekView(inherited View);
end;

function TcxSchedulerCustomWeekViewNavigation.GetWeeks: TcxSchedulerDateList;
begin
  Result := View.FWeeks;
end;

{ TcxSchedulerWeekView }

function TcxSchedulerWeekView.CreateNavigation: TcxSchedulerViewNavigation;
begin
  Result := TcxSchedulerWeekViewNavigation.Create(Self);
end;

function TcxSchedulerWeekView.CreateViewInfo: TcxSchedulerSubControlViewInfo;
begin
  Result := TcxSchedulerWeekViewViewInfo.Create(Self);
end;

function TcxSchedulerWeekView.GetCompressWeekEnd: Boolean;
begin
  Result := ViewInfo.CompressWeekEnd;
end;

function TcxSchedulerWeekView.GetViewInfo: TcxSchedulerWeekViewViewInfo;
begin
  Result := TcxSchedulerWeekViewViewInfo(inherited ViewInfo);
end;

{ TcxSchedulerWeekViewNavigation }

procedure TcxSchedulerWeekViewNavigation.GotoNextCellHorz(AGotoNext: Boolean);
const
  DateInc: array[Boolean, 0..6] of Integer =
    ((-4, -4, -4, -3, -3, -3, -4), (3, 3, 3, 4, 4, 4, 3));
begin
  if GroupingKind <> gkByDate then
  begin
    FCurrentAnchor := FCurrentAnchor + DateInc[AGotoNext, FDayOfWeek];
    if (AGotoNext and not IsLastWeek and (FDayOfWeek in [3..6])) or
      (not AGotoNext and not IsFirstWeek and (FDayOfWeek in [0..2])) then
    begin
      FCurrentAnchor := FCurrentAnchor - DayInc[AGotoNext] * 7;
      FCurrentResource := GetNextResource(AGotoNext);
    end;
  end
  else
    inherited GoToNextCellHorz(AGotoNext);
end;

procedure TcxSchedulerWeekViewNavigation.GotoNextCellVert(AGotoDown: Boolean);
begin
  if GroupingKind <> gkByDate then
    inherited GotoNextCellHorz(AGotoDown)
  else
    inherited GotoNextCellVert(AGotoDown)
end;

function TcxSchedulerWeekViewNavigation.GetViewInfo: TcxSchedulerWeekViewViewInfo;
begin
  Result := TcxSchedulerWeekViewViewInfo(inherited ViewInfo);
end;

{ TcxSchedulerWeeksView }

function TcxSchedulerWeeksView.CreateNavigation: TcxSchedulerViewNavigation;
begin
  Result := TcxSchedulerWeeksViewNavigation.Create(Self);
end;

function TcxSchedulerWeeksView.CreateViewInfo: TcxSchedulerSubControlViewInfo;
begin
  Result := TcxSchedulerWeeksViewViewInfo.Create(Self);
end;

function TcxSchedulerWeeksView.GetMaxScrollPos: Integer;
begin
  Result := 51;
end;

function TcxSchedulerWeeksView.GetMinScrollPos: Integer;
begin
  Result := -51;
end;

function TcxSchedulerWeeksView.GetViewInfo: TcxSchedulerWeeksViewViewInfo;
begin
  Result := TcxSchedulerWeeksViewViewInfo(inherited ViewInfo);
end;

{ TcxSchedulerWeeksViewNavigation }

procedure TcxSchedulerWeeksViewNavigation.GotoNextCellHorz(AGotoNext: Boolean);
begin
  if ViewInfo.GroupByResource then
  begin
    if (AGoToNext and (FDayOfWeek = 6) and not IsLastResource) or
       (not AGoToNext and (FDayOfWeek = 0) and not IsFirstResource) then
    begin
      if not AGoToNext then
        FCurrentAnchor := FCurrentAnchor + 6 
      else
        FCurrentAnchor := GetWeekStart(FWeekIndex);
      FCurrentResource := GetNextResource(AGoToNext);
      Exit;
   end;
  end;
  inherited GotoNextCellHorz(AGotoNext);
end;

procedure TcxSchedulerWeeksViewNavigation.GotoNextPage(AGotoForward: Boolean);
begin
  if not (ssShift in FShift) then
  begin
    FCurrentAnchor := FCurrentAnchor + DayInc[AGotoForward] * Weeks.Count * 7;
    View.ScrollSelectedDays(DayInc[not AGotoForward] * Weeks.Count);
  end
  else
  begin
    if AGotoForward then
      FCurrentAnchor := LastVisibleDate
    else
      FCurrentAnchor := FirstVisibleDate;
  end;
end;

function TcxSchedulerWeeksViewNavigation.GetViewInfo: TcxSchedulerWeeksViewViewInfo;
begin
  Result := TcxSchedulerWeeksViewViewInfo(inherited ViewInfo);
end;

{ TcxSchedulerWeekViewViewInfo }

procedure TcxSchedulerWeekViewViewInfo.ScrollVertical(
  AScrollCode: TScrollCode; var AScrollPos: Integer);
var
  ADelta: Integer;
begin
  ADelta := View.GetScrollPos(StartDates[0], False);
  if not (AScrollCode in [scPosition, scTrack]) then
    AScrollPos := ADelta;
  case AScrollCode of
    scLineUp:
      Dec(AScrollPos, 1);
    scLineDown:
      Inc(AScrollPos, 1);
    scPageUp:
      Dec(AScrollPos, Weeks.Count);
    scPageDown:
      Inc(AScrollPos, Weeks.Count);
    scTop:
      AScrollPos := -View.GetMinScrollPos;
    scBottom:
      AScrollPos := View.GetMaxScrollPos;
  end;
  ADelta := ADelta - AScrollPos;
  if ADelta <> 0 then
  begin
    View.ScrollSelectedDays(ADelta);
    View.LayoutChanged;
    AScrollPos := View.GetScrollPos(StartDates[0]);
  end;
end;

function TcxSchedulerWeekViewViewInfo.AddContentCell(const ARect: TRect;
  const AStart, AFinish: TDateTime; AResourceIndex: Integer): TcxSchedulerContentCellViewInfo;
begin
  Result := inherited AddContentCell(ARect, AStart, AFinish, AResourceIndex);
  Result.DontPrint := PrintExactlyOneMonth and (MonthOf(AStart) <> PrintedMonth);
end;

procedure TcxSchedulerWeekViewViewInfo.AddDayCellEvent(
  AEvent: TcxSchedulerControlEvent;
  ADay: TcxSchedulerContentCellViewInfo; AIndex: Integer);
var
  AHeight, I: Integer;
  ABounds: TRect;
  ACell: TcxSchedulerEventCellViewInfo;
  ACheckedDay, ANextDay: TcxSchedulerContentCellViewInfo;
  AViewData: TcxSchedulerEventViewData;
var
  ALineCount: Integer;
begin
  ANextDay := ADay;
  if not CanEventVisible(AEvent) then Exit;
  ALineCount := ADay.LineCount + 1;
  for I := AIndex + 1 to DayCellCount - 1 do
  begin
    ACheckedDay := DayCells[I];
    if IsCellEvent(AEvent, ACheckedDay) and IsSingleLine(ACheckedDay, ADay) then
    begin
      if CanVisibleNextLine(ACheckedDay, ADay.LineCount) then
      begin
        ANextDay := ACheckedDay;
        ACheckedDay.LineCount := ALineCount;
      end
      else
        AddButton(ACheckedDay.Bounds, ACheckedDay.TimeStart, -1, True);
    end
    else
      Break;
  end;
  if not CanVisibleNextLine(ADay) then
  begin
    AddButton(ADay.Bounds, ADay.TimeStart, -1, True);
    Exit;
  end;
  AHeight := FContentLineHeight + cxTextOffset;
  ABounds := Rect(ADay.Bounds.Left + cxTextOffset + Byte(bLeft in ADay.Borders),
    ADay.Bounds.Top + GetDayCellHeaderHeight + ADay.LineCount * AHeight,
    ANextDay.Bounds.Right - cxTextOffset - Byte(bRight in ANextDay.Borders),
    ADay.Bounds.Top + GetDayCellHeaderHeight + (ADay.LineCount + 1) * AHeight);
  OffsetRect(ABounds, 0, cxTextOffset);
  Dec(ABounds.Bottom, cxTextOffset);
  ADay.LineCount := ALineCount;
  AViewData := CreateEventViewData(AEvent, ABounds, ADay.TimeStart, ANextDay.TimeFinish, ADay.Resource);
  AViewData.VisibleRect := Bounds;
  AViewData.VisibleRect.Bottom := ADay.Bounds.Bottom - cxTextOffset;
  AViewData.VisibleRect.Top := ADay.Bounds.Top + GetDayCellHeaderHeight + cxTextOffset;
  if AEvent.Selected then
    with Styles.GetSelectionParams do 
    begin
      AViewData.ViewParams.Color := Color;
      AViewData.ViewParams.TextColor := TextColor;
      AViewData.ViewParams.Font := Font;
    end;
  ACell := AddEventCell(AViewData);
  if not (AEvent.AllDayEvent or (AEvent.Duration >= 1)) then
  begin
    ACell.Transparent := not (AEvent.Selected or Styles.IsEventStyleAssigned(AEvent));
    ACell.Borders := [];
  end;
  if not ACell.Visible then
    AddButton(ADay.Bounds, ADay.TimeStart, -1, True);
end;

function TcxSchedulerWeekViewViewInfo.AddWeekDayHeader(             
  AWeekDay: Integer; ALeft, ARight: Integer): TcxSchedulerWeekDayHeaderCellViewInfo;
begin
  Inc(AWeekDay, Integer(View.StartOfWeek));
  if AWeekDay >= 7 then Dec(AWeekDay, 7);
  CreateCellInstance(TcxSchedulerWeekDayHeaderCellViewInfo, cxRect(ALeft, FDayHeaderOffsetTop,
    ARight, FDayHeaderOffsetTop + FDayHeaderHeight),
      StylesAdapter.GetDayHeaderParams(View.FirstVisibleDate + AWeekDay), Result);
  if CompressWeekEnd and (AWeekDay >= 6) then
    Result.DateTime := 8
  else
    Result.DateTime := AWeekDay;
  DayHeaderCells.Add(Result);
end;

procedure TcxSchedulerWeekViewViewInfo.CalculateDaysLayout;
begin
  if GroupByResource then
    ProcessGroupByResource
  else
    if GroupByDate then
      ProcessGroupByDate
    else
      ProcessGroupByNone;
end;

procedure TcxSchedulerWeekViewViewInfo.CalculateDaysLayoutForResource(
  const ABounds: TRect; AResourceIndex: Integer);
const
  AddBorders: array[Boolean] of TcxBorders = ([bRight], []);
begin
  CalculateWeekDisplayRectsVert(StartDates[0], AResourceIndex, ABounds,
    AddBorders[HasSeparator or (AResourceIndex = (ResourceCount - 1))]);
end;

procedure TcxSchedulerWeekViewViewInfo.CalculateDaysLayoutForDates(
  const ABounds: TRect; AResourceIndex: Integer);
begin
  
end;

procedure TcxSchedulerWeekViewViewInfo.CalculateEventsViewInfo;
var
  I, J: Integer;
  ADay, APrevDay: TcxSchedulerContentCellViewInfo;
  AEvent: TcxSchedulerControlEvent;
begin
  APrevDay := nil;
  for I := 0 to DayCellCount - 1 do
  begin
    ADay := DayCells[I];
    for J := 0 to Events.AbsoluteCount - 1 do
    begin
      AEvent := Events.AbsoluteItems[J];
      if IsCellEvent(AEvent, ADay) then
      begin
        if (not IsSingleLine(APrevDay, ADay) or not IsCellEvent(AEvent, APrevDay)) then
          AddDayCellEvent(AEvent, ADay, I)
      end;
    end;
    APrevDay := ADay;
  end;
end;

procedure TcxSchedulerWeekViewViewInfo.CalculateGroupByDateForResource(
  const ABounds: TRect; AResourceIndex: Integer);
begin
  CalculateWeekDisplayRectsHorz(StartDates[0], AResourceIndex, ABounds, True, True);
end;

procedure TcxSchedulerWeekViewViewInfo.CalculateHeaderViewInfo;
var
  R: TRect;
  I, AIndex: Integer;
  ACell: TcxSchedulerContentCellViewInfo;
  AHeader: TcxSchedulerDayHeaderCellViewInfo;
const
  ANeighbors: array[Boolean] of TcxNeighbors = ([], [nLeft]);
begin
  if GroupByDate then
    for I := 0 to RowCols - 1 do
    begin
      ACell := DayCells[I];
      AHeader := AddWeekDayHeader(I + RowColsStart, ACell.Bounds.Left, ACell.Bounds.Right);
      AHeader.Compressed := (I = 5) and CompressWeekEnd;
    end
  else
  begin
    AIndex := Byte(ResourceCount > 0) - 1;
    for I := 0 to ContentCells.Count - 1 do
    begin
      ACell := TcxSchedulerContentCellViewInfo(ContentCells[I]);
      R := cxRectSetHeight(ACell.Bounds, FDayHeaderHeight);
      OffsetRect(R, 0, 1);
      if HasVisibleBounds then
      begin
        Inc(R.Right);
        OffsetRect(R, 0, -1);
      end;
      if not HasSeparator or ((I mod 7) <= 2) then Dec(R.Right);
      with AddDayHeader(ACell.TimeStart, R, AIndex) do
      begin
        AlignHorz := taRightJustify;
        Selected := IsTimeSelected(DateTime, Resource);
        if Selected and not HideSelection then
        begin
          SelectionColor := FSelectionParams.Color;
          SelectionTextColor := FSelectionParams.TextColor;
        end; 
      end;
      if (I + 1) mod 7 = 0 then Inc(AIndex);
    end;
  end;
  ProcessDateToDisplayText(True);
end;

procedure TcxSchedulerWeekViewViewInfo.CalculateMetrics;
var
  I: Integer;
  AStyle: TcxStyle;
  AFont: TFont;
begin
  inherited CalculateMetrics;
  FDayHeaderOffsetTop := Bounds.Top;
  FHeaderOffsetLeft := Bounds.Left;
  FResourceHeaderWidth := FResourceHeaderHeight;
  if GroupByDate and not RotateCaptions then
  begin
    AStyle := StylesAdapter.GetResourceHeaderStyle;
    if (AStyle <> nil) and (cxStyles.svFont in AStyle.AssignedValues) then
      AFont := AStyle.Font
    else
      AFont := DefaultFont;
    for I := 0 to ResourceCount - 1 do
      FResourceHeaderWidth := Max(FResourceHeaderWidth,
        PainterHelper.TextWidth(AFont, ResourceCaptions[I]) + cxTextOffset * 3);
  end;
  Weeks.Clear;
  CalculatePrintRowCols;
  CalculateWeekDates;
end;

procedure TcxSchedulerWeekViewViewInfo.CalculatePrintRowCols;
begin
  FWeekEndCells := Byte(not PrintWeekEnds) * (Byte(not CompressWeekEnd) + 1);
  FRowColsStart := 0;
  FRowCols := 7 - Byte(CompressWeekEnd) - FWeekEndCells; 
  CalculateStartFinishCellIndexes;
end;

procedure TcxSchedulerWeekViewViewInfo.CalculateStartFinishCellIndexes;
begin
  if PagesPerWeek = 1 then Exit;
  if PrimaryPage then
    FRowCols := 3
  else
  begin
    FRowColsStart := 3;
    FRowCols := FRowCols - FRowColsStart;
  end;
end;

procedure TcxSchedulerWeekViewViewInfo.CalculateWeekDates;
var
  I, ADate: Integer;
  AYear, APrevYear, AWeek, APrevWeek, AWeekDay: Word;
begin
  APrevYear := 0;
  APrevWeek := 0;
  for I := 0 to DayCount - 1 do
  begin
    DecodeDateWeek(Days[I] + View.GetDateOffset, AYear, AWeek, AWeekDay);
    if (AYear <> APrevYear) or (AWeek <> APrevWeek) then
    begin
      APrevYear := AYear;
      APrevWeek := AWeek;
      //DELPHI8! check Trunc(EncodeDateWeek(AYear, AWeek, 1))
      ADate := Trunc(EncodeDateWeek(AYear, AWeek, 1));
      Weeks.Add(ADate);
    end;
  end;
end;

procedure TcxSchedulerWeekViewViewInfo.CalculateWeekDisplayRectsHorz(
  const AStartDate: TDateTime; AResourceID: Integer;
  {const }ABounds: TRect; AIsTopWeek, AIsLastWeek: Boolean);
var
  I, J, W: Integer;
  ARects: TcxSchedulerDaysRect;
  ACellBorders: TcxBorders;
const
  ABorders: array[Boolean] of TcxBorders = ([bTop, bRight], [bTop]);
begin
  W := ABounds.Right - ABounds.Left;
  for I := 0 to RowCols - 1 do
  begin
    J := I + RowColsStart;
    ARects[J] := cxRect(ABounds.Left + MulDiv(W, I, RowCols),
      ABounds.Top - 1, ABounds.Left + MulDiv(W, I + 1, RowCols), ABounds.Bottom);
    if CompressWeekEnd and (J = 5) then
      cxRectSplitVert(ARects[5], ARects[5], ARects[6]);
  end;
  for I := 0 to RowCols - 1 + Byte(CompressWeekEnd) * Byte(PrintWeekEnds) do
  begin
    ACellBorders := ABorders[(I >= (RowCols - 1)) and (HasSeparator or (AResourceID = (ResourceCount - 1)))];
    if AIsTopWeek and (I <> RowCols) then
      Exclude(ACellBorders, bTop);
    if AIsLastWeek and not HasSeparator and (I <> RowCols - 1) and (AResourceID <> ResourceCount - 1) then
      Include(ACellBorders, bBottom);
    J := I + RowColsStart;
    AddContentCell(ARects[J], AStartDate + J,
      AStartDate + J + 1, AResourceID).Borders := ACellBorders;
  end;
end;

procedure TcxSchedulerWeekViewViewInfo.CalculateWeekDisplayRectsVert(
  const AStartDate: TDateTime; AResourceID: Integer;
  const ABounds: TRect; AddBorders: TcxBorders = []);
var
  R: TRect;
  I, J: Integer;
  ARects: TcxSchedulerDaysRect;
  ASize: TSize;
begin
  FillChar(ARects, SizeOf(ARects), 0);
  ASize := cxRectSize(ABounds);
  for I := 0 to 2 do
  begin
    R := cxRect(ABounds.Left, ABounds.Top + MulDiv(ASize.CY, I, 3),
      ABounds.Right, ABounds.Top + MulDiv(ASize.CY, I + 1, 3));
    if PagesPerWeek = 1 then
      cxRectSplitHorz(R, ARects[I], ARects[I + 3])
    else
    begin
      ARects[I] := R;
      ARects[I + 3] := R;
    end;
  end;
  cxRectSplitVert(ARects[5], ARects[5], ARects[6]);
  for I := 0 to RowCols do
  begin
    J := RowColsStart + I;
    AddContentCell(ARects[J], AStartDate + J, AStartDate + J + 1,
      AResourceID).Borders := WeekViewDayBorders[J] + AddBorders;
  end;
end;

function TcxSchedulerWeekViewViewInfo.CanEventVisible(
  AEvent: TcxSchedulerControlEvent): Boolean;
begin
  Result := not (AEvent.IsClone and FHideClones);
end;

function TcxSchedulerWeekViewViewInfo.CanVisibleNextLine(
  ADay: TcxSchedulerContentCellViewInfo; ALine: Integer = -1): Boolean;
begin
  if ALine = -1 then
    ALine := ADay.LineCount;
  Result := (GetDayCellContentHeight(ADay))  >=
    (ALine + 1) * FContentLineHeight;
end;

procedure TcxSchedulerWeekViewViewInfo.CheckHeaderBorders;
var
  I: Integer; 
const
  ANeigbors: array[Boolean] of TcxNeighbors =
    ([], [nTop]);
  ADayHeader: array[Boolean] of TcxNeighbors =
    ([], [nLeft]);
  ABorders: array[Boolean] of TcxBorders =
    ([], [bBottom]);
begin
  ProcessCheckBorders(DayHeaderCells, GroupingKind = gkByDate,
    ANeigbors[not GroupByDate] + ADayHeader[GroupByDate]);
  ProcessCheckBorders(ResourceHeaderCells, False, [], ABorders[GroupByResource]);
  if not GroupByDate then
  begin
    if GroupByResource then
      with TcxSchedulerDayHeaderCellViewInfo(ResourceHeaderCells[0]) do
        Borders := Borders - [bLeft];
    for I := 0 to DayHeaderCells.Count - 1 do
      with TcxSchedulerDayHeaderCellViewInfo(DayHeaderCells[I]) do
        Borders := [bBottom, bTop] * LookAndFeelPainter.HeaderBorders([nTop]);
  end;
end;

function TcxSchedulerWeekViewViewInfo.ContentCellClass: TcxSchedulerContentCellViewInfoClass;
begin
  if GroupByDate then
    Result := TcxSchedulerMonthDayContentCellViewInfo
  else
    Result := inherited ContentCellClass;
end;

function TcxSchedulerWeekViewViewInfo.CompressWeekEnd: Boolean;
begin
  if GroupByDate then
    Result := View.CompressWeekEnd
  else
    Result := True;
end;

procedure TcxSchedulerWeekViewViewInfo.DoCalculate;
begin
  inherited DoCalculate;
  FPrintExactlyOneMonth := Adapter.PrintExactlyOneMonth;
  if FPrintExactlyOneMonth then
    FPrintedMonth := MonthOf(Days[DayCount div 2]);
  if IsCalculateHeaderFirst then
  begin
    CalculateHeaderViewInfo;
    CalculateDaysLayout;
  end
  else
  begin
    CalculateDaysLayout;
    CalculateHeaderViewInfo;
  end;
  CalculateEventsViewInfo;
  CheckHeaderBorders;
end;

function TcxSchedulerWeekViewViewInfo.GetContentParams(
  const ATime: TDateTime; AResource: TcxSchedulerResourceViewInfo): TcxViewParams;
begin
  if AResource = nil then
    Result := StylesAdapter.GetContentParams(ATime, True, nil)
  else
    Result := StylesAdapter.GetContentParams(ATime, True, AResource.ResourceItem);
end;

function TcxSchedulerWeekViewViewInfo.GetDayCellContentHeight(
  ADay: TcxSchedulerContentCellViewInfo): Integer;
begin
  Result := cxRectHeight(PainterHelper.ExcludeBorders(ADay.Bounds,
    ADay.Borders)) - GetDayCellHeaderHeight - cxTextOffset;
end;

function TcxSchedulerWeekViewViewInfo.GetDayCellHeaderHeight: Integer;
begin
  if GroupByDate then
    Result := cxTextOffset + FContentLineHeight
  else
    Result := FDayHeaderHeight + cxTextOffset;
end;

function TcxSchedulerWeekViewViewInfo.IsCalculateHeaderFirst: Boolean;
begin
  Result := False;
end;

function TcxSchedulerWeekViewViewInfo.IsCellEvent(
  AEvent: TcxSchedulerControlEvent; ACell: TcxSchedulerContentCellViewInfo): Boolean;
begin
  Result := (ACell <> nil) and AEvent.IsDayEvent(ACell.TimeStart);
  if Result and (GroupingKind <> gkNone) then
    Result := AEvent.IsResourceEvent(ACell.Resource.ResourceItem, ShowEventsWithoutResource);
  if Result and PrintExactlyOneMonth then
    Result := MonthOf(ACell.TimeStart) = PrintedMonth; 
end;

function TcxSchedulerWeekViewViewInfo.IsSingleLine(
  ADay1, ADay2: TcxSchedulerContentCellViewInfo): Boolean;
begin
  Result := (ADay1 <> nil) and (ADay2 <> nil) and
    (ADay1.Bounds.Top = ADay2.Bounds.Top);
end;

function TcxSchedulerWeekViewViewInfo.IsTimeSelected(
  ATime: TDateTime; AResource: TObject): Boolean;
begin
  ATime := DateTimeHelper.RoundTime(ATime);
  Result := not HideSelection and (AResource = FSelResource) and
    (ATime >= SelStart) and (ATime <= SelFinish);
  Result := Result and CanSelected; 
end;

procedure TcxSchedulerWeekViewViewInfo.OnClickMoreButton(
  Sender: TcxSchedulerMoreEventsButtonViewInfo);
begin
  SelectedDays.Clear;
  SelectedDays.Add(Sender.DateTime);
  View.PeriodChanged;
end;

procedure TcxSchedulerWeekViewViewInfo.ProcessGroupByDate;
var
  I, H: Integer;
  ABounds: TRect;
  APrevMonth: Integer;
  ACell: TcxSchedulerHeaderCellViewInfo;
  AContentCell: TcxSchedulerMonthDayContentCellViewInfo;
begin
  ABounds := Bounds;
  Inc(ABounds.Left, ResourceHeaderWidth);
  H := cxRectHeight(ABounds) - DayHeaderHeight -
    SeparatorWidth * (ResourceCount - 1);
  AddResourceHeader(-1, cxRectSetSize(Bounds, ResourceHeaderWidth, DayHeaderHeight));
  for I := 0 to ResourceCount - 1 do
  begin
    ABounds.Top := Bounds.Top + DayHeaderHeight +
      MulDiv(H, I, ResourceCount) + SeparatorWidth * I + 1;
    ABounds.Bottom := Bounds.Top + DayHeaderHeight +
      MulDiv(H, I + 1, ResourceCount) + SeparatorWidth * I;
    CalculateGroupByDateForResource(ABounds, I);
    if I < (ResourceCount - 1) then
      AddGroupHorzSeparator(ABounds.Bottom);
    Dec(ABounds.Top);
    ACell := AddResourceHeader(I, cxRectSetWidth(ABounds,
      Bounds.Left, ResourceHeaderWidth));
    ACell.RotateText := RotateCaptions;
    ACell.RotateHeader := True;
  end;
  APrevMonth := -1;
  for I := 0 to ContentCells.Count - 1 do
  begin
    AContentCell := TcxSchedulerMonthDayContentCellViewInfo(ContentCells[I]);
    AContentCell.SetContentState(APrevMonth = MonthOf(AContentCell.TimeStart),
      IsTimeSelected(AContentCell.TimeStart, AContentCell.Resource),
      FContentLineHeight - cxTextOffset, FSelectionParams);
    APrevMonth := MonthOf(AContentCell.TimeStart);
  end;
end;

procedure TcxSchedulerWeekViewViewInfo.ProcessGroupByNone;
begin
  CalculateWeekDisplayRectsVert(StartDates[0], -1, Bounds);
end;

procedure TcxSchedulerWeekViewViewInfo.ProcessGroupByResource;
var
  I, W: Integer;
  ABounds: TRect;
  ACell: TcxSchedulerHeaderCellViewInfo;
begin
  ABounds := Bounds;
  W := ABounds.Right - ABounds.Left - SeparatorWidth * (ResourceCount - 1);
  Inc(ABounds.Top, ResourceHeaderHeight);
  for I := 0 to ResourceCount - 1 do
  begin
    ABounds.Left := MulDiv(W, I, ResourceCount) + SeparatorWidth * I;
    ABounds.Right := MulDiv(W, I + 1, ResourceCount) + SeparatorWidth * I;
    CalculateDaysLayoutForResource(ABounds, I);
    if I < (ResourceCount - 1) then
      AddGroupVertSeparator(ABounds.Right);
    ACell := AddResourceHeader(I, cxRectSetTop(ABounds, Bounds.Top, ResourceHeaderHeight));
    ACell.Borders := LookAndFeelPainter.HeaderBorders([nLeft, nRight, nBottom]);
    if not (bLeft in ACell.Borders) then
      ACell.Borders := ACell.Borders - [bRight, bBottom];
  end;
end;

function TcxSchedulerWeekViewViewInfo.GetDayCell(
  ADay: Integer): TcxSchedulerContentCellViewInfo;
begin
  Result := TcxSchedulerContentCellViewInfo(ContentCells[ADay]);
end;

function TcxSchedulerWeekViewViewInfo.GetDayCellCount: Integer;
begin
  Result := ContentCells.Count;
end;

function TcxSchedulerWeekViewViewInfo.GetRotateCaptions: Boolean;
begin
  Result := View.OptionsView.RotateResourceCaptions;
end;

function TcxSchedulerWeekViewViewInfo.GetStartDate(AWeek: Integer): TDateTime;
begin
  Result := Weeks[AWeek];
  if not CompressWeekEnd then
    Result := Result - View.GetDateOffset;
end;

function TcxSchedulerWeekViewViewInfo.GetView: TcxSchedulerWeekView;
begin
  Result := TcxSchedulerWeekView(inherited View);
end;

function TcxSchedulerWeekViewViewInfo.GetWeeks: TcxSchedulerDateList;
begin
  Result := View.FWeeks;
end;

{ TcxSchedulerWeeksViewViewInfo }

procedure TcxSchedulerWeeksViewViewInfo.CalculateDaysLayoutForResource(
  const ABounds: TRect; AResourceIndex: Integer);
var
  R: TRect;
  I, H, ATop, APrevMonth: Integer;
  ACell: TcxSchedulerMonthDayContentCellViewInfo;
begin
  ATop := ABounds.Top;
  if not GroupByDate then
    Inc(ATop, FDayHeaderHeight);
  H := ABounds.Bottom - ATop;
  for I := 0 to Weeks.Count - 1 do
  begin
    R := cxRect(ABounds.Left, ATop + MulDiv(H, I, Weeks.Count),
      ABounds.Right, ATop + MulDiv(H, I + 1, Weeks.Count));
    if I > 0 then Inc(R.Top);
    CalculateWeekDisplayRectsHorz(StartDates[I], AResourceIndex, R, I = 0, I = Weeks.Count - 1);
  end;
  APrevMonth := -1;
  for I := 0 to ContentCells.Count - 1 do
  begin
    ACell := TcxSchedulerMonthDayContentCellViewInfo(ContentCells[I]);
    ACell.SetContentState(APrevMonth = MonthOf(ACell.TimeStart),
      IsTimeSelected(ACell.TimeStart, ACell.Resource),
      FContentLineHeight - cxTextOffset, FSelectionParams);
    APrevMonth := MonthOf(ACell.TimeStart);
  end;
end;

procedure TcxSchedulerWeeksViewViewInfo.CalculateGroupByDateForResource(
  const ABounds: TRect; AResourceIndex: Integer);
begin
  CalculateDaysLayoutForResource(ABounds, AResourceIndex);
end;

procedure TcxSchedulerWeeksViewViewInfo.CalculateHeaderViewInfo;
var
  I, W: Integer;
begin
  if GroupByResource then Exit;
  if GroupByDate then
    FHeaderOffsetLeft := ResourceHeaderWidth + Bounds.Left;
  W := Bounds.Right - FHeaderOffsetLeft;
  for I := 0 to RowCols - 1 do
  begin
    AddWeekDayHeader(I + RowColsStart, MulDiv(W, I, RowCols) + FHeaderOffsetLeft,
      MulDiv(W, I + 1, RowCols) + FHeaderOffsetLeft);
  end;
  ProcessDateToDisplayText(True);
  FContentOffset := FDayHeaderHeight;
end;

procedure TcxSchedulerWeeksViewViewInfo.CheckHeaderBorders;
const
  ANeigbors: array[Boolean] of TcxNeighbors =
    ([], [nTop]);
begin
  ProcessCheckBorders(DayHeaderCells, False, ANeigbors[GroupByResource]);
  ProcessCheckBorders(ResourceHeaderCells, False);
  if not GroupByDate or not (bLeft in LookAndFeelPainter.HeaderBorders([nLeft])) then
  begin
    with TcxSchedulerHeaderCellViewInfo(DayHeaderCells[0]) do
      Borders := Borders - [bLeft];
    if GroupByResource then
      with TcxSchedulerDayHeaderCellViewInfo(ResourceHeaderCells[0]) do
        Borders := Borders - [bLeft];
  end;
end;

function TcxSchedulerWeeksViewViewInfo.CompressWeekEnd: Boolean;
begin
  Result := View.CompressWeekEnd;
end;

function TcxSchedulerWeeksViewViewInfo.ContentCellClass: TcxSchedulerContentCellViewInfoClass;
begin
  Result := TcxSchedulerMonthDayContentCellViewInfo;
end;

function TcxSchedulerWeeksViewViewInfo.GetContentParams(
  const ATime: TDateTime; AResource: TcxSchedulerResourceViewInfo): TcxViewParams;
begin
  if AResource = nil then
    Result := StylesAdapter.GetContentParams(ATime, not Odd(MonthOf(ATime)), nil)
  else
    Result := StylesAdapter.GetContentParams(ATime, not Odd(MonthOf(ATime)),
       AResource.ResourceItem);
end;

function TcxSchedulerWeeksViewViewInfo.GetDayCellHeaderHeight: Integer;
begin
  Result := cxTextOffset + FContentLineHeight;
end;

function TcxSchedulerWeeksViewViewInfo.IsCalculateHeaderFirst: Boolean;
begin
  Result := True;
end;

procedure TcxSchedulerWeeksViewViewInfo.ProcessGroupByNone;
begin
  CalculateDaysLayoutForResource(Bounds, -1);
end;

procedure TcxSchedulerWeeksViewViewInfo.ProcessGroupByResource;
var
  I, J, W: Integer;
  ACell: TcxSchedulerHeaderCellViewInfo;
begin
  inherited ProcessGroupByResource;
  Inc(FDayHeaderOffsetTop, FResourceHeaderHeight);
  for J := 0 to ResourceHeaderCells.Count - 1 do
  begin
    ACell := TcxSchedulerHeaderCellViewInfo(ResourceHeaderCells[J]);
    W := cxRectWidth(ACell.Bounds);
    for I := 0 to RowCols - 1 do
      AddWeekDayHeader(I + RowColsStart, MulDiv(W, I, RowCols) + ACell.Bounds.Left,
        MulDiv(W, I + 1, RowCols) +  + ACell.Bounds.Left).Resource := ACell.Resource;
    ProcessDateToDisplayText(True);
  end;
end;

{ TcxSchedulerWeekViewPainter }

procedure TcxSchedulerWeekViewPainter.Paint;
begin
  inherited Paint;
  ViewInfo.ContentCells.Draw(Canvas, DrawContentCell);
  ViewInfo.DayHeaderCells.Draw(Canvas, DrawHeaderCell);
  ViewInfo.ResourceHeaderCells.Draw(Canvas, DrawResourceHeaderCell);
  ViewInfo.GroupSeparatorCells.Draw(Canvas, DrawGroupSeparatorCell);
  ViewInfo.EventCells.Draw(Canvas, DrawEventCell);
  ViewInfo.Buttons.Draw(Canvas, DrawButtonCell);
end;

function TcxSchedulerWeekViewPainter.GetViewInfo: TcxSchedulerWeekViewViewInfo;
begin
  Result := TcxSchedulerWeekViewViewInfo(inherited ViewInfo);
end;

end.
