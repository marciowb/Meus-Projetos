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
  Windows, Controls, ImgList,
{$IFDEF DELPHI6}
  DateUtils, Types,
{$ENDIF}
  cxGraphics, cxDateUtils, cxSchedulerUtils,
  cxSchedulerStorage, cxSchedulerCustomControls, cxSchedulerCustomResourceView,
  cxSchedulerDayView, cxSchedulerWeekView, cxSchedulerDateNavigator, Classes,
  cxSchedulerGanttView, cxSchedulerTimeGridView, cxSchedulerYearView;

type

  { TcxScheduler }

  TcxSchedulerInitEventImages = procedure (Sender: TcxCustomScheduler;
    AEvent: TcxSchedulerControlEvent; AImages: TcxSchedulerEventImages) of object;

  TcxScheduler = class(TcxCustomScheduler, IUnknown, IcxSchedulerCommonViewItemsPainter, IcxSchedulerEventImages)
  private
    FDateNavigatorEvents: TNotifyEvent;
    FIsSelectionValidated: Boolean;
    FViewDay: TcxSchedulerDayView;
    FViewGantt: TcxSchedulerGanttView;
    FViewTimeGrid: TcxSchedulerTimeGridView;
    FViewWeek: TcxSchedulerWeekView;
    FViewWeeks: TcxSchedulerWeeksView;
    FViewYear: TcxSchedulerYearView;
    FOnCustomDrawBackground: TcxSchedulerCustomDrawBackgroundEvent;
    FOnCustomDrawButton: TcxSchedulerCustomDrawButtonEvent;
    FOnCustomDrawContent: TcxSchedulerCustomDrawContentEvent;
    FOnCustomDrawDayHeader: TcxSchedulerCustomDrawDayHeaderEvent;
    FOnCustomDrawEvent: TcxSchedulerCustomDrawEventEvent;
    FOnCustomDrawGroupSeparator: TcxSchedulerCustomDrawGroupSeparatorEvent;
    FOnCustomDrawNavigationButton: TcxSchedulerCustomDrawNavigationButtonEvent;
    FOnCustomDrawResourceHeader: TcxSchedulerCustomDrawResourceHeaderEvent;
    FOnInitEventImages: TcxSchedulerInitEventImages;
    FViewDayEvents: TNotifyEvent;
    FViewGanttEvents: TNotifyEvent;
    FViewTimeGridEvents: TNotifyEvent;
    FViewYearEvents: TNotifyEvent;
    function GetDateNavigator: TcxSchedulerDateNavigator;
    procedure SetDateNavigator(AValue: TcxSchedulerDateNavigator);
    procedure SetViewDay(AValue: TcxSchedulerDayView);
    procedure SetViewGantt(AValue: TcxSchedulerGanttView);
    procedure SetViewTimeGrid(AValue: TcxSchedulerTimeGridView);
    procedure SetViewWeek(AValue: TcxSchedulerWeekView);
    procedure SetViewWeeks(AValue: TcxSchedulerWeeksView);
    procedure SetViewYear(AValue: TcxSchedulerYearView);
    // read/write
    procedure ReadSplittersData(AStream: TStream);
    procedure WriteSplittersData(AStream: TStream);
    procedure ReadStoredClientBounds(AStream: TStream);
    procedure WriteStoredClientBounds(AStream: TStream);
  protected
    procedure DefineProperties(Filer: TFiler); override;
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
    procedure DoCustomDrawNavigationButton(
      AViewInfo: TcxSchedulerContentNavigationButtonViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawResourceHeader(
      AViewInfo: TcxSchedulerHeaderCellViewInfo; var ADone: Boolean); virtual;
    function HasCustomDrawGroupSeparator: Boolean;
    function HasCustomDrawResourceHeader: Boolean;
    // IcxSchedulerEventImages
    procedure DoInitEventImages(AEvent: TcxSchedulerControlEvent;
      AImages: TcxSchedulerEventImages); virtual;
    function GetImages: TCustomImageList; virtual;
    function SupportEventImages: Boolean; virtual;
    // layout
    function GetProperties(AProperties: TStrings): Boolean; override;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); override;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); override;

    function CreateDateNavigator: TcxSchedulerCustomDateNavigator; override;
    function CreateDefaultView: TcxSchedulerCustomView; override;
    function CreateViewDay: TcxSchedulerDayView; virtual;
    function CreateViewGantt: TcxSchedulerGanttView; virtual;
    function CreateViewTimeGrid: TcxSchedulerTimeGridView; virtual;
    function CreateViewWeek: TcxSchedulerWeekView; virtual;
    function CreateViewWeeks: TcxSchedulerWeeksView; virtual;
    function CreateViewYear: TcxSchedulerYearView; virtual;
    procedure CreateSubClasses; override;
    procedure DateNavigatorSelectionChanged; override;
    function GetNextView(AView: TcxSchedulerCustomView): TcxSchedulerCustomView; override;
    procedure SetCurrentView(AView: TcxSchedulerCustomView); override;
    procedure SynchronizeVisibleDays; override;
    procedure UpdateEventsCache(ACheckDaysInterval: Boolean); override;
    function UpdateView(AView: TcxSchedulerCustomView): Boolean;
    procedure ValidateSelection(ASelection: TcxSchedulerDateList); override;
    procedure ValidateWeekDays(ASaveWeekCount: Boolean = False);
  public
    function GoToDate(ADate: TDateTime): Boolean; override;
    function GoToDate(ADate: TDateTime; AViewMode: TcxSchedulerViewMode): Boolean; overload; override;
    procedure SelectDays(const AStartDay, AFinishDay: TDateTime; AsDays: Boolean = False); overload; virtual;
    procedure SelectDays(ASelection: TcxSchedulerDateList; AsDays: Boolean = False); overload; virtual;
    procedure SelectDays(const ASelection: array of TDateTime; AsDays: Boolean = False); overload; virtual;
    procedure SelectWorkDays(const AWeekDate: TDateTime);
  published
    property DateNavigator: TcxSchedulerDateNavigator read GetDateNavigator write SetDateNavigator;
    property ViewDay: TcxSchedulerDayView read FViewDay write SetViewDay;
    property ViewGantt: TcxSchedulerGanttView read FViewGantt write SetViewGantt;
    property ViewTimeGrid: TcxSchedulerTimeGridView read FViewTimeGrid write SetViewTimeGrid;
    property ViewWeek: TcxSchedulerWeekView read FViewWeek write SetViewWeek;
    property ViewWeeks: TcxSchedulerWeeksView read FViewWeeks write SetViewWeeks;
    property ViewYear: TcxSchedulerYearView read FViewYear write SetViewYear;

    property OnCustomDrawBackground: TcxSchedulerCustomDrawBackgroundEvent read FOnCustomDrawBackground write FOnCustomDrawBackground;
    property OnCustomDrawButton: TcxSchedulerCustomDrawButtonEvent read FOnCustomDrawButton write FOnCustomDrawButton;
    property OnCustomDrawContent: TcxSchedulerCustomDrawContentEvent read FOnCustomDrawContent write FOnCustomDrawContent;
    property OnCustomDrawDayHeader: TcxSchedulerCustomDrawDayHeaderEvent read FOnCustomDrawDayHeader write FOnCustomDrawDayHeader;
    property OnCustomDrawEvent: TcxSchedulerCustomDrawEventEvent read FOnCustomDrawEvent write FOnCustomDrawEvent;
    property OnCustomDrawGroupSeparator: TcxSchedulerCustomDrawGroupSeparatorEvent read FOnCustomDrawGroupSeparator write FOnCustomDrawGroupSeparator;
    property OnCustomDrawResourceHeader: TcxSchedulerCustomDrawResourceHeaderEvent read FOnCustomDrawResourceHeader write FOnCustomDrawResourceHeader;
    property OnInitEventImages: TcxSchedulerInitEventImages read FOnInitEventImages write FOnInitEventImages;
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
    property DialogsLookAndFeel;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property EventImages;
    property EventOperations;
    property EventPopupMenu;
    property Font;
    property LookAndFeel;
    property OptionsBehavior;
    property OptionsCustomize;
    property OptionsView;
    property ParentFont;
    property PopupMenu;
    property ResourceNavigator;
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
    property OnFirstVisibleResourceChanged;
    property OnGetEventDisplayText;
    property OnGetEventEditProperties;
    property OnGetEventHintText;
    property OnInitEdit;
    property OnIsWorkTime;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnLayoutChanged;
    property OnMoreEventsButtonClick;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnNavigationButtonClick;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnSelectionChanged;
    property OnScaleScroll;
    property OnShowDateHint;
    property OnViewTypeChanged;
    //nested events
    property DateNavigatorEvents: TNotifyEvent read FDateNavigatorEvents write FDateNavigatorEvents;
    property ViewDayEvents: TNotifyEvent read FViewDayEvents write FViewDayEvents;
    property ViewGanttEvents: TNotifyEvent read FViewGanttEvents write FViewGanttEvents; 
    property ViewTimeGridEvents:  TNotifyEvent read FViewTimeGridEvents write FViewTimeGridEvents;
    property ViewYearEvents: TNotifyEvent read FViewYearEvents write FViewYearEvents;
  end;

implementation         

uses
  SysUtils;

{ TcxScheduler }

function TcxScheduler.GoToDate(ADate: TDateTime): Boolean;
begin
  Result := True;
  DateNavigator.BeginUpdate;
  try
    if SelectedDays.IndexOf(ADate) <> -1 then Exit;
    if SelectedDays.Count = 0 then
      SelectedDays.Add(Date);
    SelectedDays.ShiftPeriod(ADate - SelectedDays[0]);
    if ViewWeek.Active or ViewWeeks.Active then
      ValidateWeekDays(True)
    else
      if CurrentView is TcxSchedulerTimeGridView then
        TcxSchedulerTimeGridView(CurrentView).VisibleStart := SelectedDays[0];
    UpdateView(CurrentView);
    DateNavigator.Refresh;
  finally
    DateNavigator.EndUpdate;
  end;
  FullRefresh;
end;

function TcxScheduler.GoToDate(ADate: TDateTime; AViewMode:
  TcxSchedulerViewMode): Boolean;

  procedure SelectMonth;
  var
    I, AYear, AMonth, ADay: Word;
    AStart: TDateTime;
  begin
    DecodeDate(ADate, AYear, AMonth, ADay);
    AStart := EncodeDate(AYear, AMonth, 1);
    for I := 0 to DaysPerMonth(AYear, AMonth) - 1 do
      SelectedDays.Add(AStart + I - Integer(OptionsView.ActualStartOfWeek));
    ValidateWeekDays;
  end;

begin
  DateNavigator.BeginUpdate;
  try
    SelectedDays.Clear;
    DateNavigator.SelectionIsWeeks := AViewMode in [vmWeek, vmMonth];
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
  FullRefresh;
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

procedure TcxScheduler.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Splitters', ReadSplittersData, WriteSplittersData, True);
  Filer.DefineBinaryProperty('StoredClientBounds', ReadStoredClientBounds, WriteStoredClientBounds, True);
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
  if HasCustomDrawGroupSeparator then
    FOnCustomDrawGroupSeparator(CurrentView, Canvas, AViewInfo, ADone);
end;

procedure TcxScheduler.DoCustomDrawNavigationButton(
  AViewInfo: TcxSchedulerContentNavigationButtonViewInfo; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawNavigationButton) then
    FOnCustomDrawNavigationButton(CurrentView, Canvas, AViewInfo, ADone);
end;

procedure TcxScheduler.DoCustomDrawResourceHeader(
  AViewInfo: TcxSchedulerHeaderCellViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawResourceHeader then
    FOnCustomDrawResourceHeader(CurrentView, Canvas, AViewInfo, ADone);
end;

function TcxScheduler.HasCustomDrawGroupSeparator: Boolean;
begin
  Result := Assigned(FOnCustomDrawGroupSeparator);
end;

function TcxScheduler.HasCustomDrawResourceHeader: Boolean;
begin
  Result := Assigned(FOnCustomDrawResourceHeader);
end;

procedure TcxScheduler.DoInitEventImages(AEvent: TcxSchedulerControlEvent;
  AImages: TcxSchedulerEventImages);
begin
  if Assigned(FOnInitEventImages) then
    FOnInitEventImages(Self, AEvent, AImages);
end;

function TcxScheduler.GetImages: TCustomImageList;
begin
  Result := EventImages;
end;

function TcxScheduler.SupportEventImages: Boolean;
begin
  Result := Assigned(FOnInitEventImages);
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
        else
          if CurrentView = ViewTimeGrid then
            AValue := 3
          else
            if CurrentView = ViewYear then
              AValue := 4

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
        if (AValue = 1) or (AValue = 2) then
        begin
          if AValue = 1 then
            ViewWeek.Active := True
          else
            if AValue = 2 then
              ViewWeeks.Active := True;
          ValidateWeekDays(True);
        end
        else
          if AValue = 3 then
            ViewTimeGrid.Active := True
          else
            if AValue = 4 then
              ViewYear.Active := True
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

function TcxScheduler.CreateViewGantt: TcxSchedulerGanttView;
begin
  Result := TcxSchedulerGanttView.Create(Self);
end;

function TcxScheduler.CreateViewTimeGrid: TcxSchedulerTimeGridView;
begin
  Result := TcxSchedulerTimeGridView.Create(Self);
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

function TcxScheduler.CreateViewYear: TcxSchedulerYearView; 
begin
  Result := TcxSchedulerYearView.Create(Self);
end;

procedure TcxScheduler.CreateSubClasses;
begin
  FViewDay := CreateViewDay;
  FViewGantt := CreateViewGantt;
  FViewTimeGrid := CreateViewTimeGrid;
  FViewWeek := CreateViewWeek;
  FViewWeeks := CreateViewWeeks;
  FViewYear := CreateViewYear;
  inherited CreateSubClasses;
end;

procedure TcxScheduler.DateNavigatorSelectionChanged;
begin
  if not (cfViewValid in ControlFlags) then Exit;
  try
    if CanDeactivateOnSelectionChanged(CurrentView) then
    begin
      if DateNavigator.SelectionIsWeeks then
      begin
        if SelectedDays.Count >= 14 then
          ViewWeeks.Active := True
        else
          ViewWeek.Active := True
      end
      else
        ViewDay.Active := True;
    end
    else
      SelectedDaysChanged(CurrentView);
  finally
    FullRefresh;
  end;
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
  SelectDays(SelectedDays, (CurrentView = ViewDay) or
    (CurrentView = ViewTimeGrid) or (CurrentView = ViewYear));
  inherited SynchronizeVisibleDays;
end;

procedure TcxScheduler.UpdateEventsCache(ACheckDaysInterval: Boolean);
begin
  inherited UpdateEventsCache(ACheckDaysInterval);
  EventList.Sort(TcxCompareEventsProc(@cxCompareSchedulerControlEvents));
end;

function TcxScheduler.UpdateView(AView: TcxSchedulerCustomView): Boolean;
var
  ADate: TDateTime;
begin
  ADate := SelectedDays[0];
  if ViewYear.Active then
    AView.Active := True;
  if (ADate < DateNavigator.FirstDate) or (ADate > DateNavigator.LastDate) then
    DateNavigator.FirstDate := ADate;
  if AView.Active then
    AView.Refresh
  else
    AView.Active := True;
  Result := AView.Active;
end;

procedure TcxScheduler.ValidateSelection(ASelection: TcxSchedulerDateList);
begin
  if not FIsSelectionValidated then
  begin
    FIsSelectionValidated := True;
    SelectDays(ASelection, (CurrentView = ViewDay) or (CurrentView = ViewYear) or
      (CurrentView = ViewTimeGrid) or (SelectedDays.Count = 1));
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

procedure TcxScheduler.SetViewGantt(AValue: TcxSchedulerGanttView);
begin
  FViewGantt.Assign(AValue);
end;

procedure TcxScheduler.SetViewTimeGrid(AValue: TcxSchedulerTimeGridView);
begin
  FViewTimeGrid.Assign(AValue);
end;

procedure TcxScheduler.SetViewWeek(AValue: TcxSchedulerWeekView);
begin
  FViewWeeks.Assign(AValue);
end;

procedure TcxScheduler.SetViewWeeks(AValue: TcxSchedulerWeeksView);
begin
  FViewWeek.Assign(AValue);
end;

procedure TcxScheduler.SetViewYear(AValue: TcxSchedulerYearView);
begin
  FViewYear.Assign(AValue);
end;

procedure TcxScheduler.ReadSplittersData(AStream: TStream);
var
  R: TRect;
begin
  AStream.Read(R, SizeOf(R));
  HorzSplitter.Bounds := R;
  AStream.Read(R, SizeOf(R));
  VertSplitter.Bounds := R;
end;

procedure TcxScheduler.WriteSplittersData(AStream: TStream);
var
  R: TRect;
begin
  R := HorzSplitter.Bounds;
  AStream.Write(R, SizeOf(R));
  R := VertSplitter.Bounds;
  AStream.Write(R, SizeOf(R));
end;

procedure TcxScheduler.ReadStoredClientBounds(AStream: TStream);
begin
  AStream.Read(FStoredClientBounds, SizeOf(FStoredClientBounds));
end;

procedure TcxScheduler.WriteStoredClientBounds(AStream: TStream);
var
  R: TRect;
begin
  R := ClientBounds;
  AStream.Write(R, SizeOf(R));
end;

end.
