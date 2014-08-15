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

unit cxScheduler;

{$I cxVer.inc}

interface

uses
  {$IFDEF DELPHI6} DateUtils, {$ENDIF} cxGraphics, cxDateUtils, cxSchedulerUtils,
  cxSchedulerStorage, cxSchedulerCustomControls, cxSchedulerCustomResourceView,
  cxSchedulerDayView, cxSchedulerWeekView, cxSchedulerDateNavigator, Classes;

type
  { TcxScheduler }

  TcxScheduler = class(TcxCustomScheduler, IUnknown, IcxSchedulerCommonViewItemsPainter)
  private
    FDateNavigatorEvents: TNotifyEvent;
    FIsSelectionValidated: Boolean;
    FViewDay: TcxSchedulerDayView;
    FViewWeek: TcxSchedulerWeekView;
    FViewWeeks: TcxSchedulerWeeksView;
    FOnCustomDrawBackground: TcxSchedulerCustomDrawBackgroundEvent;
    FOnCustomDrawButton: TcxSchedulerCustomDrawButtonEvent;
    FOnCustomDrawContent: TcxSchedulerCustomDrawContentEvent;
    FOnCustomDrawDayHeader: TcxSchedulerCustomDrawDayHeaderEvent;
    FOnCustomDrawEvent: TcxSchedulerCustomDrawEventEvent;
    FOnCustomDrawGroupSeparator: TcxSchedulerCustomDrawGroupSeparatorEvent;
    FOnCustomDrawResourceHeader: TcxSchedulerCustomDrawResourceHeaderEvent;
    FViewDayEvents: TNotifyEvent;
    function GetDateNavigator: TcxSchedulerDateNavigator;
    procedure SetDateNavigator(AValue: TcxSchedulerDateNavigator);
    procedure SetViewDay(AValue: TcxSchedulerDayView);
    procedure SetViewWeek(AValue: TcxSchedulerWeekView);
    procedure SetViewWeeks(AValue: TcxSchedulerWeeksView);
  protected
    // IcxSchedulerCommonViewItemsPainter
    procedure DoCustomDrawBackground(
      AViewInfo: TcxSchedulerBackgroundCellViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawButton(
      AViewInfo: TcxSchedulerMoreEventsButtonViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawContent(
      AViewInfo: TcxSchedulerContentCellViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawDayHeader(
      AViewInfo: TcxSchedulerDayHeaderCellViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawEvent(
      AViewInfo: TcxSchedulerEventCellViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawGroupSeparator(
      AViewInfo: TcxSchedulerGroupSeparatorCellViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawResourceHeader(
      AViewInfo: TcxSchedulerHeaderCellViewInfo; var ADone: Boolean); virtual;
    // layout
    function GetProperties(AProperties: TStrings): Boolean; override;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); override;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); override;

    function CreateDateNavigator: TcxSchedulerCustomDateNavigator; override;
    function CreateDefaultView: TcxSchedulerCustomView; override;
    function CreateViewDay: TcxSchedulerDayView; virtual;
    function CreateViewWeek: TcxSchedulerWeekView; virtual;
    function CreateViewWeeks: TcxSchedulerWeeksView; virtual;
    procedure CreateSubClasses; override;
    procedure DateNavigatorSelectionChanged; override;
    function GetNextView(AView: TcxSchedulerCustomView): TcxSchedulerCustomView; override;
    procedure SetCurrentView(AView: TcxSchedulerCustomView); override;
    procedure SynchronizeVisibleDays; override;
    procedure UpdateEventsCache(ACheckDaysInterval: Boolean); override;
    procedure ValidateSelection(ASelection: TcxSchedulerDateList); override;
    procedure ValidateWeekDays(ASaveWeekCount: Boolean = False);
  public
    function GoToDate(ADate: TDateTime; AViewMode: TcxSchedulerViewMode = vmDay): Boolean; override;
    procedure SelectDays(const AStartDay, AFinishDay: TDateTime; AsDays: Boolean = False); overload; virtual;
    procedure SelectDays(ASelection: TcxSchedulerDateList; AsDays: Boolean = False); overload; virtual;
    procedure SelectDays(const ASelection: array of TDateTime; AsDays: Boolean = False); overload; virtual;
    procedure SelectWorkDays(const AWeekDate: TDateTime);
  published
    property DateNavigator: TcxSchedulerDateNavigator read GetDateNavigator write SetDateNavigator;
    property ViewDay: TcxSchedulerDayView read FViewDay write SetViewDay;
    property ViewWeek: TcxSchedulerWeekView read FViewWeek write SetViewWeek;
    property ViewWeeks: TcxSchedulerWeeksView read FViewWeeks write SetViewWeeks;

    property OnCustomDrawBackground: TcxSchedulerCustomDrawBackgroundEvent read FOnCustomDrawBackground write FOnCustomDrawBackground;
    property OnCustomDrawButton: TcxSchedulerCustomDrawButtonEvent read FOnCustomDrawButton write FOnCustomDrawButton;
    property OnCustomDrawContent: TcxSchedulerCustomDrawContentEvent read FOnCustomDrawContent write FOnCustomDrawContent;
    property OnCustomDrawDayHeader: TcxSchedulerCustomDrawDayHeaderEvent read FOnCustomDrawDayHeader write FOnCustomDrawDayHeader;
    property OnCustomDrawEvent: TcxSchedulerCustomDrawEventEvent read FOnCustomDrawEvent write FOnCustomDrawEvent;
    property OnCustomDrawGroupSeparator: TcxSchedulerCustomDrawGroupSeparatorEvent read FOnCustomDrawGroupSeparator write FOnCustomDrawGroupSeparator;
    property OnCustomDrawResourceHeader: TcxSchedulerCustomDrawResourceHeaderEvent read FOnCustomDrawResourceHeader write FOnCustomDrawResourceHeader;
    // derived properties and events
    property Align;
    property Anchors;
  {$IFDEF DELPHI6}
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BorderWidth;
  {$ENDIF}
    property BorderStyle;
    property ContentPopupMenu;
    property Constraints;
    property ControlBox;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property EventOperations;
    property EventPopupMenu;
    property Font;
    property LookAndFeel;
    property OptionsCustomize;
    property OptionsView;
    property ParentFont;
    property PopupMenu;
    property ShowHint;
    property Storage;
    property Styles;
    property TabOrder;
    property TabStop;
    property Visible;
    //events
    property OnAfterDragEvent;
    property OnAfterEditing;
    property OnAfterSizingEvent;
    property OnBeforeDeleting;
    property OnBeforeDragEvent;
    property OnBeforeEditing;
    property OnBeforeSizingEvent;
    property OnCanShowView;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnEventSelectionChanged;
    property OnGetEventDisplayText;
    property OnGetEventEditProperties;
    property OnGetEventHintText;
    property OnInitEdit;
    property OnIsWorkTime;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnLayoutChanged;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnSelectionChanged;
    property OnViewTypeChanged;
    //nested events
    property DateNavigatorEvents: TNotifyEvent read FDateNavigatorEvents write FDateNavigatorEvents;
    property ViewDayEvents: TNotifyEvent read FViewDayEvents write FViewDayEvents;
  end;

function cxCompareSchedulerControlEvents(
  AEvent1, AEvent2: TcxSchedulerControlEvent): Integer;

implementation

uses
  SysUtils;

function cxCompareSchedulerControlEvents(
  AEvent1, AEvent2: TcxSchedulerControlEvent): Integer;
var
  AAllDay1, AAllDay2: Boolean;
begin
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
          if AEvent1.RecordIndex < AEvent2.RecordIndex then
            Result := -1
          else
            if AEvent1.RecordIndex > AEvent2.RecordIndex then
              Result := 1
            else
              Result := 0;
end;

{ TcxScheduler }

function TcxScheduler.GoToDate(ADate: TDateTime; AViewMode:
  TcxSchedulerViewMode = vmDay): Boolean;

  procedure SelectMonth;
  var
    I, AYear, AMonth, ADay: Word;
    AStart: TDateTime;
  begin
    DecodeDate(ADate, AYear, AMonth, ADay);
    AStart := EncodeDate(AYear, AMonth, 1);
    for I := 0 to DaysPerMonth(AYear, AMonth) - 1 do
      SelectedDays.Add(AStart + I);
    ValidateWeekDays;
  end;

  function UpdateView(AView: TcxSchedulerCustomView): Boolean;
  begin
    if (ADate < DateNavigator.FirstDate) or (ADate > DateNavigator.LastDate) then
      DateNavigator.FirstDate := ADate;
    if AView.Active then
      AView.Refresh
    else
      AView.Active := True;
    Result := AView.Active;
  end;

begin
  DateNavigator.BeginUpdate;
  try
    SelectedDays.Clear;
    case AViewMode of
      vmDay, vmWeek:
        begin
          SelectedDays.Add(ADate);
          if AViewMode = vmDay then
            Result := UpdateView(ViewDay)
          else
            Result := UpdateView(ViewWeek);
        end;
      vmMonth:
        begin
          SelectMonth;
          Result := UpdateView(ViewWeeks);
        end;
    else
      SelectWorkDays(ADate);
      Result := UpdateView(ViewDay);
    end;
  finally
    SynchronizeVisibleDays;
    DateNavigator.Refresh;
    DateNavigator.EndUpdate;
  end;
end;

procedure TcxScheduler.SelectDays(const AStartDay, AFinishDay: TDateTime;
   AsDays: Boolean = False);
var
  I: Integer;
begin
  SelectedDays.Clear;
  //DELPHI8! check Trunc(AStartDay)
  for I := Trunc(AStartDay) to Trunc(AFinishDay) do
    SelectedDays.Add(I);
  SelectDays(SelectedDays, AsDays);
end;

procedure TcxScheduler.SelectDays(
  ASelection: TcxSchedulerDateList; AsDays: Boolean = False);
var
  I: Integer;
begin
  DateNavigator.BeginUpdate;
  try
    if ASelection <> SelectedDays then
      SelectedDays.Assign(ASelection);
    SelectedDays.Sort(cxCompareDates);
    if SelectedDays.Count = 0 then
      SelectedDays.Add(Date);
    I := 1;
    while I < (ASelection.Count - 1) do
    begin
      if ASelection[I] = ASelection[I - 1] then
        ASelection.Delete(I)
      else
        Inc(I)
    end;
    AsDays := AsDays and (ASelection.Count < 14);
    if not AsDays then
    begin
      ValidateWeekDays;
      DateNavigator.SelectionIsWeeks := True;
    end
    else
      DateNavigator.SelectionIsWeeks := False;
    FIsSelectionValidated := True;
    ValidateSelection(SelectedDays);
  finally
    DateNavigator.EndUpdate;
  end;
end;

procedure TcxScheduler.SelectDays(const ASelection: array of TDateTime;
  AsDays: Boolean = False);
var
  I: Integer; 
  AList: TcxSchedulerDateList;
begin
  AList := TcxSchedulerDateList.Create;
  try
    for I := Low(ASelection) to High(ASelection) do
      AList.Add(ASelection[I]);
    if AList.Count = 0 then
      AList.Add(Date);
    SelectDays(AList, AsDays);
  finally
    AList.Free;
  end;
end;

procedure TcxScheduler.SelectWorkDays(const AWeekDate: TDateTime);
const
  ConvertTable: array[1..7] of TDay = (dMonday, dTuesday, dWednesday, dThursday,
    dFriday, dSaturday, dSunday);
var
  AYear, AWeek, AWeekDay: Word;
  ADay: TDay;
  I, ADaysDiff: Integer;
  AStartWeek: TDateTime;
begin
  ViewDay.Active := True;
  DecodeDateWeek(AWeekDate, AYear, AWeek, AWeekDay);
  ADay := ConvertTable[AWeekDay];
  ADaysDiff := Ord(ADay) - Ord(StartOfWeek);
  if ADaysDiff >= 0 then
    AStartWeek := AWeekDate - ADaysDiff
  else
    AStartWeek := AWeekDate - (ADaysDiff + 7);
  ADay := ConvertTable[DayOfTheWeek(AStartWeek)];
  SelectedDays.Clear;
  for I := 1 to 7 do
  begin
    if ADay in OptionsView.WorkDays then
      SelectedDays.Add(AStartWeek);
    if ADay < dSaturday then
      Inc(ADay)
    else
      ADay := dSunday;
    AStartWeek := AStartWeek + 1;
  end;
  SelectDays(SelectedDays, True)
end;

procedure TcxScheduler.DoCustomDrawBackground(
  AViewInfo: TcxSchedulerBackgroundCellViewInfo; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawBackground) then
    FOnCustomDrawBackground(CurrentView, Canvas, AViewInfo, ADone);
end;

procedure TcxScheduler.DoCustomDrawButton(
  AViewInfo: TcxSchedulerMoreEventsButtonViewInfo; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawButton) then
    FOnCustomDrawButton(CurrentView, Canvas, AViewInfo, ADone);
end;

procedure TcxScheduler.DoCustomDrawContent(
  AViewInfo: TcxSchedulerContentCellViewInfo; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawContent) then
    FOnCustomDrawContent(CurrentView, Canvas, AViewInfo, ADone);
end;

procedure TcxScheduler.DoCustomDrawDayHeader(
  AViewInfo: TcxSchedulerDayHeaderCellViewInfo; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawDayHeader) then
    FOnCustomDrawDayHeader(CurrentView, Canvas, AViewInfo, ADone);
end;

procedure TcxScheduler.DoCustomDrawEvent(
  AViewInfo: TcxSchedulerEventCellViewInfo; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawEvent) and Assigned(AViewInfo.Event) then
    FOnCustomDrawEvent(CurrentView, Canvas, AViewInfo, ADone);
end;

procedure TcxScheduler.DoCustomDrawGroupSeparator(
  AViewInfo: TcxSchedulerGroupSeparatorCellViewInfo; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawGroupSeparator) then
    FOnCustomDrawGroupSeparator(CurrentView, Canvas, AViewInfo, ADone);
end;

procedure TcxScheduler.DoCustomDrawResourceHeader(
  AViewInfo: TcxSchedulerHeaderCellViewInfo; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawResourceHeader) then
    FOnCustomDrawResourceHeader(CurrentView, Canvas, AViewInfo, ADone);
end;

function TcxScheduler.GetProperties(AProperties: TStrings): Boolean;
begin
  Result := inherited GetProperties(AProperties);
  if CurrentView.Active then
    AProperties.Add('View');
end;

procedure TcxScheduler.GetPropertyValue(const AName: string;
  var AValue: Variant);
begin
  inherited GetPropertyValue(AName, AValue);
  if (AName = 'View') and CurrentView.Active then
  begin
    if CurrentView = ViewDay then
      AValue := 0
    else
      if CurrentView = ViewWeek then
        AValue := 1
      else
        if CurrentView = ViewWeeks then
          AValue := 2
  end;
end;

procedure TcxScheduler.SetPropertyValue(const AName: string;
  const AValue: Variant);
begin
  inherited SetPropertyValue(AName, AValue);
  if (AName = 'View') and CurrentView.Active then
  begin
    DateNavigator.BeginUpdate;
    try
      if AValue = 0 then
        ViewDay.Active := True
      else
      begin
        if AValue = 1 then
          ViewWeek.Active := True
        else
          if AValue = 2 then
            ViewWeeks.Active := True;
        ValidateWeekDays(True);
      end;
    finally
      DateNavigator.EndUpdate;
    end;
  end;
end;

function TcxScheduler.CreateDateNavigator: TcxSchedulerCustomDateNavigator;
begin
  Result := TcxSchedulerDateNavigator.Create(Self);
end;

function TcxScheduler.CreateDefaultView: TcxSchedulerCustomView;
begin
  Result := FViewDay;
end;

function TcxScheduler.CreateViewDay: TcxSchedulerDayView;
begin
  Result := TcxSchedulerDayView.Create(Self);
end;

function TcxScheduler.CreateViewWeek: TcxSchedulerWeekView;
begin
  Result := TcxSchedulerWeekView.Create(Self);
end;

function TcxScheduler.CreateViewWeeks: TcxSchedulerWeeksView;
begin
  Result := TcxSchedulerWeeksView.Create(Self);
end;

procedure TcxScheduler.CreateSubClasses;
begin
  FViewDay := CreateViewDay;
  FViewWeek := CreateViewWeek;
  FViewWeeks := CreateViewWeeks;
  inherited CreateSubClasses;
end;

procedure TcxScheduler.DateNavigatorSelectionChanged;
begin
  if not (cfViewValid in ControlFlags) then Exit;
  if DateNavigator.SelectionIsWeeks then
  begin
    if SelectedDays.Count >= 14 then
      ViewWeeks.Active := True
    else
      ViewWeek.Active := True
  end
  else
    ViewDay.Active := True;
  FullRefresh;
end;

function TcxScheduler.GetNextView(
  AView: TcxSchedulerCustomView): TcxSchedulerCustomView;
begin
  Result := FViewWeek;
  if (AView = FViewWeek) and FViewWeeks.CanShow then
    Result := FViewWeeks
  else
    if not FViewWeek.CanShow or (AView = FViewWeek) then
    begin
      if AView <> FViewDay then
        Result := FViewDay
      else
        Result := FViewWeeks;
    end;
end;

procedure TcxScheduler.SetCurrentView(AView: TcxSchedulerCustomView);
begin
  inherited SetCurrentView(AView);
end;

procedure TcxScheduler.SynchronizeVisibleDays;
var
  ADate: TDateTime;
begin
  if SelectedDays.Count = 0 then
    SelectedDays.Add(Date);
  if CurrentView = ViewWeek then
  begin
    ADate := SelectedDays[0];
    SelectedDays.Clear;
    SelectedDays.Add(ADate);
  end;
  SelectDays(SelectedDays, CurrentView = ViewDay);
  inherited SynchronizeVisibleDays;
end;

procedure TcxScheduler.UpdateEventsCache(ACheckDaysInterval: Boolean);
begin
  inherited UpdateEventsCache(ACheckDaysInterval);
  EventList.Sort(TcxCompareEventsProc(@cxCompareSchedulerControlEvents));
end;

procedure TcxScheduler.ValidateSelection(ASelection: TcxSchedulerDateList);
begin
  if not FIsSelectionValidated then
  begin
    FIsSelectionValidated := True;
    SelectDays(ASelection, (CurrentView = ViewDay) or (SelectedDays.Count = 1));
  end
  else
  begin
    FIsSelectionValidated := False;
    inherited ValidateSelection(ASelection);
  end;
end;

procedure TcxScheduler.ValidateWeekDays(ASaveWeekCount: Boolean = False);
var
  I, J, AWeekCount: Integer;
  ADate: TDateTime;
  AWeeks: TcxSchedulerDateList;
  AYear, APrevYear, AWeek, APrevWeek, AWeekDay: Word;
begin
  AWeekCount := SelectedDays.Count div 7;
  if AWeekCount = 0 then Inc(AWeekCount);
  AWeeks := TcxSchedulerDateList.Create;
  try
    APrevYear := 0;
    APrevWeek := 0;
    for I := 0 to SelectedDays.Count - 1 do
    begin
      DecodeDateWeek(SelectedDays[I] + 1 - Byte(StartOfWeek), AYear, AWeek, AWeekDay);
      if (AYear <> APrevYear) or (AWeek <> APrevWeek) then
      begin
        APrevYear := AYear;
        APrevWeek := AWeek;
        AWeeks.Add(EncodeDateWeek(AYear, AWeek, 1) - 1);
      end;
    end;
    SelectedDays.Clear;
    for I := 0 to AWeeks.Count - 1 do
    begin
      if ASaveWeekCount and (I = AWeekCount) then break;
      ADate := AWeeks[I];
      for J := 0 to 6 do
        SelectedDays.Add(ADate + J + Byte(StartOfWeek));
    end;
  finally
    AWeeks.Free;
  end;
end;

function TcxScheduler.GetDateNavigator: TcxSchedulerDateNavigator;
begin
  Result := TcxSchedulerDateNavigator(inherited DateNavigator);
end;

procedure TcxScheduler.SetDateNavigator(AValue: TcxSchedulerDateNavigator);
begin
  DateNavigator.Assign(AValue);
end;

procedure TcxScheduler.SetViewDay(AValue: TcxSchedulerDayView);
begin
  FViewDay.Assign(AValue);
end;

procedure TcxScheduler.SetViewWeek(AValue: TcxSchedulerWeekView);
begin
  FViewWeeks.Assign(AValue);
end;

procedure TcxScheduler.SetViewWeeks(AValue: TcxSchedulerWeeksView);
begin
  FViewWeek.Assign(AValue);
end;

end.
