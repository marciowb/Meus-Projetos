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

unit cxSchedulerRecurrenceEditor;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus,
  dxCore, cxStyles, cxGraphics, cxEdit, cxControls,
  cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  ComCtrls, cxLookAndFeelPainters, cxButtons, cxCheckBox, cxRadioGroup,
  cxSpinEdit, cxTimeEdit, cxGroupBox, cxSchedulerStorage, cxLookAndFeels,
  cxSchedulerUtils, cxDateUtils, cxSchedulerEventEditor;

type

  { TcxSchedulerCustomRecurrenceEventEditor }

  TcxSchedulerCustomRecurrenceEventEditor = class(TcxSchedulerCustomEditorForm)
  private
    FNeedCheckLossOfExceptions: Boolean;
    procedure SetNeedCheckLossOfExceptions(AValue: Boolean);
  protected
    procedure SaveChanges; virtual;
  public
    constructor CreateEx(AEvent: TcxSchedulerControlEvent); override;

    property NeedCheckLossOfExceptions: Boolean read FNeedCheckLossOfExceptions write SetNeedCheckLossOfExceptions;
  end;

  { TcxSchedulerRecurrenceEventEditor }

  TcxSchedulerRecurrenceEventEditorForm = class(TcxSchedulerCustomRecurrenceEventEditor)
    gbTime: TcxGroupBox;
    lbStart: TLabel;
    lbEnd: TLabel;
    teStart: TcxTimeEdit;
    teEnd: TcxTimeEdit;
    gbPattern: TcxGroupBox;
    Bevel1: TBevel;
    rbDaily: TcxRadioButton;
    rbWeekly: TcxRadioButton;
    rbMonthly: TcxRadioButton;
    rbYearly: TcxRadioButton;
    lbOfEvery: TLabel;
    lbMonths: TLabel;
    lbOfEvery1: TLabel;
    lbMonths1: TLabel;
    rbDay: TcxRadioButton;
    rbThe: TcxRadioButton;
    cbWeek: TcxComboBox;
    cbDay: TcxComboBox;
    lbWeeksOn: TLabel;
    lbRecurEvery: TLabel;
    cbDayOfWeek1: TcxCheckBox;
    cbDayOfWeek2: TcxCheckBox;
    cbDayOfWeek3: TcxCheckBox;
    cbDayOfWeek4: TcxCheckBox;
    cbDayOfWeek5: TcxCheckBox;
    cbDayOfWeek6: TcxCheckBox;
    cbDayOfWeek7: TcxCheckBox;
    lbOf: TLabel;
    rbEvery1: TcxRadioButton;
    rbThe1: TcxRadioButton;
    cbMonths: TcxComboBox;
    cbWeek1: TcxComboBox;
    cbDay1: TcxComboBox;
    cbMonths1: TcxComboBox;
    rbEvery: TcxRadioButton;
    rbEveryWeekday: TcxRadioButton;
    gbRange: TcxGroupBox;
    lbStart1: TLabel;
    lbOccurrences: TLabel;
    deStart: TcxDateEdit;
    rbNoEndDate: TcxRadioButton;
    rbEndAfter: TcxRadioButton;
    rbEndBy: TcxRadioButton;
    deEndBy: TcxDateEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    btnRemove: TcxButton;
    lbDay: TLabel;
    meDay: TcxMaskEdit;
    meNumOfWeek: TcxMaskEdit;
    meNumMonth1: TcxMaskEdit;
    meNumMonth: TcxMaskEdit;
    meDayOfMonth: TcxMaskEdit;
    meEndAfter: TcxMaskEdit;
    meNumOfDay: TcxMaskEdit;
    lbDuration: TLabel;
    cbDuration: TcxComboBox;
    pnlDaily: TcxGroupBox;
    pnlWeekly: TcxGroupBox;
    pnlMonthly: TcxGroupBox;
    pnlYearly: TcxGroupBox;
    pnlPeriodicity: TcxGroupBox;
    procedure SelectPeriodicityClick(Sender: TObject);
    procedure meEndAfterPropertiesChange(Sender: TObject);
    procedure deEndByPropertiesChange(Sender: TObject);
    procedure rbNoEndDateClick(Sender: TObject);
    procedure meEndAfterExit(Sender: TObject);
    procedure ValidateNumber(Sender: TObject);
    procedure meDayPropertiesChange(Sender: TObject);
    procedure rbEveryWeekdayClick(Sender: TObject);
    procedure SetDayRadioButtonChecked(Sender: TObject);
    procedure SetTheRadioButtonChecked(Sender: TObject);
    procedure deStartPropertiesEditValueChanged(Sender: TObject);
    procedure DoChange(Sender: TObject);
    procedure cbMonthsPropertiesChange(Sender: TObject);
    procedure cbWeek1PropertiesChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure deEndByPropertiesEditValueChanged(Sender: TObject);
    procedure meEndAfterPropertiesEditValueChanged(Sender: TObject);
    procedure cbDurationPropertiesPopup(Sender: TObject);
    procedure cbDurationPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EndTimeChanged(Sender: TObject);
    procedure StartTimeChanged(Sender: TObject);
  private
    FLocked: Boolean;
    procedure CheckViewRecurrence(AResetPattern: Boolean);
    procedure FillDays;
    procedure FillMonths;
    procedure FillWeeks;
    function GetActivePattern: TcxRecurrence;
    function GetRecurrenceInfo: TcxSchedulerEventRecurrenceInfo;
    function GetDayOfWeekIndex: Integer;
    function GetMonthIndex: Integer;
    function GetNumber(const S: string): Integer;
    function GetWeekIndex: Integer;
    function GetCurrentDuration: TDateTime;
    function IsValidDailyPattern: Boolean;
    function IsValidMonthlyPattern: Boolean;
    function IsValidWeeklyPattern: Boolean;
    function IsValidYearlyPattern: Boolean;
    procedure ResetDailyTab;
    procedure ResetMonthlyTab;
    procedure ResetWeeklyTab;
    procedure ResetYearlyTab;
    procedure SelectDaysOfWeek(ADays: TDays);
    procedure SetActivePattern(Value: TcxRecurrence);
    procedure SetDailyPatternFromEvent;
    procedure SetDateWithoutChangeEvent(AEdit: TcxDateEdit; ADate: TDateTime);
    procedure SetItemIndexWithoutChangeEvent(AEdit: TcxComboBox; AIndex: Integer);
    procedure SetMonthlyPatternFromEvent;
    procedure SetPatternFromEvent;
    procedure SetTextWithoutChangeEvent(AEdit: TcxCustomMaskEdit; const AText: string);
    procedure SetTimeWithoutChangeEvent(AEdit: TcxTimeEdit; ATime: TDateTime);
    procedure SetupDaysOfWeek;
    procedure SetWeeklyPatternFromEvent;
    procedure SetYearlyPatternFromEvent;
  protected
    procedure ApplyChanges; override;
    function CheckLostExceptions: Boolean;
    procedure FillCombos; virtual;

    function GetFormColor: TColor; override;
    function GetRecurrenceInfoValidStatus: TcxRecurrenceValidStatus;
    procedure InitializeControls; override;
    function IsValid: Boolean;
    procedure LoadEventValuesIntoControls; override;
    procedure SaveEvent(AEvent: TcxSchedulerControlEvent);
    procedure SaveRecurrenceInfo(AInfo: TcxSchedulerEventRecurrenceInfo); virtual;
    procedure SaveDailyParams(AInfo: TcxSchedulerEventRecurrenceInfo);
    procedure SaveWeeklyParams(AInfo: TcxSchedulerEventRecurrenceInfo);
    procedure SaveMonthlyParams(AInfo: TcxSchedulerEventRecurrenceInfo);
    procedure SaveYearlyParams(AInfo: TcxSchedulerEventRecurrenceInfo);
    procedure SetCaptions; virtual;
    procedure SetEndAfter;
    procedure SetEndDate;
    procedure SetEventRecurrenceFinish;
    procedure SetReadOnly(AValue: Boolean); override;
    procedure UpdateDuration;
    procedure UpdateEventValuesFromControls; override;
    procedure UpdateRange;

    property ActivePattern: TcxRecurrence read GetActivePattern write SetActivePattern;
    property Info: TcxSchedulerEventRecurrenceInfo read GetRecurrenceInfo;
    property Locked: Boolean read FLocked write FLocked;
  public
    property Event;
    property Modified;
    property NeedCheckLossOfExceptions;
    property ReadOnly;
  end;

  TcxSchedulerRecurrenceEventEditor = TcxSchedulerRecurrenceEventEditorForm; //workaround for Delphi 2005

  TcxSchedulerRecurrenceEventEditorClass = class of TcxSchedulerCustomRecurrenceEventEditor;

implementation

uses
  Variants, DateUtils, cxSchedulerStrs, cxClasses, cxSchedulerDialogs;

{$R *.dfm}

function cxDayTypeFromType(AIndex: Integer): TcxDayType;
begin
  if AIndex < 0 then AIndex := 0;
  Inc(AIndex);
  if AIndex >= Byte(cxdtSaturday) then
    Result := cxdtSaturday
  else
    Result := TcxDayType(AIndex);
end;

function cxDayNumberFromRange(AIndex: Integer): Integer;
begin
  Result := AIndex + 1;
end;

{ TcxSchedulerCustomRecurrenceEventEditor }

constructor TcxSchedulerCustomRecurrenceEventEditor.CreateEx(
  AEvent: TcxSchedulerControlEvent);
begin
  inherited CreateEx(AEvent);
  FNeedCheckLossOfExceptions := (Event.Pattern <> nil) and Event.Pattern.HasExceptions;
end;

procedure TcxSchedulerCustomRecurrenceEventEditor.SaveChanges;
begin
  Event.EventType := etPattern;
  if Event.Pattern = nil then
    FModified := True;
  UpdateEventValuesFromControls;
end;

procedure TcxSchedulerCustomRecurrenceEventEditor.SetNeedCheckLossOfExceptions(
  AValue: Boolean);
begin
  FNeedCheckLossOfExceptions := FNeedCheckLossOfExceptions and AValue;
end;

{ TcxSchedulerRecurrenceEventEditor }

procedure TcxSchedulerRecurrenceEventEditorForm.SelectPeriodicityClick(
  Sender: TObject);
begin
  if Locked then Exit;
  CheckViewRecurrence(True);
  ActivePattern := TcxRecurrence(TcxRadioButton(Sender).Tag);
end;

procedure TcxSchedulerRecurrenceEventEditorForm.ApplyChanges;
begin
  case ModalResult of
    mrOk:
      if not ReadOnly then
        SaveChanges;
    mrAbort:
      begin
        if not IsInternalActivation and (Event.Pattern <> nil) then
          Event.Pattern.DeleteExceptions;
        Event.EventType := etNone;
        FModified := True;
      end;
    mrCancel:
      begin
        if (Event.Source = nil) and (Event.EventType <> etPattern) then
          Event.EventType := etNone;
        FModified := False;  
      end;
  end;
end;

function TcxSchedulerRecurrenceEventEditorForm.CheckLostExceptions: Boolean;
begin
  Result := not FNeedCheckLossOfExceptions or
    (MessageDlg(cxGetResourceString(@scxConfirmLostExceptions), mtWarning, [mbOK, mbCancel], 0) = mrOk);
end;

procedure TcxSchedulerRecurrenceEventEditorForm.FillCombos;
begin
  cxComboBoxPopulateWithTimeIntervals(cbDuration);
  FillDays;
  FillMonths;
  FillWeeks;
end;

function TcxSchedulerRecurrenceEventEditorForm.GetFormColor: TColor;
begin
  Result := teStart.Style.LookAndFeel.Painter.DefaultSchedulerControlColor;
end;

function TcxSchedulerRecurrenceEventEditorForm.GetRecurrenceInfoValidStatus: TcxRecurrenceValidStatus;
var
  AEvent: TcxSchedulerControlEvent;
begin
  AEvent := TcxSchedulerControlEvent.Create(Event.Storage);
  try
    SaveEvent(AEvent);
    AEvent.EventType := etPattern;
    Result := AEvent.RecurrenceInfo.GetValidStatus;
  finally
    AEvent.Free;
  end;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.InitializeControls;
begin
  SetCaptions;
  FillCombos;
  teStart.Properties.Use24HourFormat := Is24HourTimeFormat;
  teEnd.Properties.Use24HourFormat := Is24HourTimeFormat;
end;

function TcxSchedulerRecurrenceEventEditorForm.IsValid: Boolean;
begin
  case ActivePattern of
    cxreDaily:
      Result := IsValidDailyPattern;
    cxreWeekly:
      Result := IsValidWeeklyPattern;
    cxreMonthly:
      Result := IsValidMonthlyPattern;
    else //cxreYearly
      Result := IsValidYearlyPattern;
  end;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.LoadEventValuesIntoControls;
begin
  FLocked := True;
  teStart.Time := TimeOf(Event.Start);
  teEnd.Time := TimeOf(Event.Finish);
  cbDuration.Text := cxMinutesToTextProc(Round(Event.Duration / MinuteToTime));

  SetDateWithoutChangeEvent(deStart, DateOf(Event.Start));
  SetPatternFromEvent;
  SetEventRecurrenceFinish;
  FLocked := False;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SaveEvent(
  AEvent: TcxSchedulerControlEvent);
begin
  if AEvent <> Event then
    AEvent.Assign(Event);
  SaveRecurrenceInfo(AEvent.RecurrenceInfo);
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SaveRecurrenceInfo(
  AInfo: TcxSchedulerEventRecurrenceInfo);
var
  AStart, AFinish: TDateTime;
begin
  AStart := deStart.Date + teStart.Time;
  AFinish := AStart + GetCurrentDuration;
  //correct event time
  with AInfo.Event do
  begin
    AllDayEvent := (TimeOf(AStart) = 0) and (TimeOf(AFinish) = 0) and (AFinish - AStart >= 1);
    Start := AStart;
    Finish := AFinish;
  end;

  AInfo.Recurrence := ActivePattern;
  if rbNoEndDate.Checked then
    AInfo.Count := -1
  else if rbEndAfter.Checked then
    AInfo.Count := GetNumber(meEndAfter.Text)
  else
  begin
    AInfo.Count := 0;
    AInfo.Finish := deEndBy.Date;
  end;
  case ActivePattern of
    cxreDaily:   SaveDailyParams(AInfo);
    cxreWeekly:  SaveWeeklyParams(AInfo);
    cxreMonthly: SaveMonthlyParams(AInfo);
    cxreYearly:  SaveYearlyParams(AInfo);
  end;
  if not Locked then
    AInfo.Validate;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SaveDailyParams(
  AInfo: TcxSchedulerEventRecurrenceInfo);
begin
  if rbEvery.Checked then
  begin
    AInfo.DayType := cxdtEveryDay;
    AInfo.Periodicity := GetNumber(meDay.Text);
  end
  else
  begin
    AInfo.DayType := cxdtWeekDay;
    AInfo.Periodicity := 1;
  end;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SaveWeeklyParams(
  AInfo: TcxSchedulerEventRecurrenceInfo);

  procedure Check(ACheckBox: TcxCheckBox; var AOccurDays: TDays);
  begin
    if ACheckBox.Checked then
      Include(AOccurDays, TDay(ACheckBox.Tag - 1));
  end;

var
  AOccurDays: TDays;
begin
  AInfo.Periodicity := GetNumber(meNumOfWeek.Text);
  AOccurDays := [];
  Check(cbDayOfWeek1, AOccurDays);
  Check(cbDayOfWeek2, AOccurDays);
  Check(cbDayOfWeek3, AOccurDays);
  Check(cbDayOfWeek4, AOccurDays);
  Check(cbDayOfWeek5, AOccurDays);
  Check(cbDayOfWeek6, AOccurDays);
  Check(cbDayOfWeek7, AOccurDays);
  AInfo.OccurDays := AOccurDays;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SaveMonthlyParams(
  AInfo: TcxSchedulerEventRecurrenceInfo);
begin
  if rbDay.Checked then
  begin
    AInfo.DayType := cxdtDay;
    AInfo.DayNumber := GetNumber(meNumOfDay.Text);
    AInfo.Periodicity := GetNumber(meNumMonth.Text);;
  end
  else
  begin
    AInfo.DayType := cxDayTypeFromType(cbDay.ItemIndex);
    AInfo.DayNumber := cxDayNumberFromRange(cbWeek.ItemIndex);
    AInfo.Periodicity := GetNumber(meNumMonth1.Text);
  end;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SaveYearlyParams(
  AInfo: TcxSchedulerEventRecurrenceInfo);
begin
  if rbEvery1.Checked then
  begin
    AInfo.DayType := cxdtDay;
    AInfo.Periodicity := cbMonths.ItemIndex + 1;
    AInfo.DayNumber := GetNumber(meDayOfMonth.Text);
  end
  else
  begin
    AInfo.DayType := cxDayTypeFromType(cbDay1.ItemIndex);
    AInfo.DayNumber := cxDayNumberFromRange(cbWeek1.ItemIndex);
    AInfo.Periodicity := cbMonths1.ItemIndex + 1;
  end;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SetCaptions;
begin
  Caption := cxGetResourceString(@scxRecurrenceCaption);
  // time
  gbTime.Caption := cxGetResourceString(@scxEventTime);
  lbStart.Caption := cxGetResourceString(@scxStart);
  lbEnd.Caption := cxGetResourceString(@scxEnd);
  lbDuration.Caption := cxGetResourceString(@scxDuration);
  // pattern
  gbPattern.Caption := cxGetResourceString(@scxRecurrencePattern);
  rbDaily.Caption := cxGetResourceString(@scxDaily);
  rbWeekly.Caption := cxGetResourceString(@scxWeekly);
  rbMonthly.Caption := cxGetResourceString(@scxMonthly);
  rbYearly.Caption := cxGetResourceString(@scxYearly);
  // daily
  rbEvery.Caption := cxGetResourceString(@scxEvery);
  rbEveryWeekday.Caption := cxGetResourceString(@scxEveryWeekDay);
  lbDay.Caption := cxGetResourceString(@scxDay1);
  // weekly
  lbRecurEvery.Caption := cxGetResourceString(@scxRecurEvery);
  lbWeeksOn.Caption := cxGetResourceString(@scxWeeksOn);
  SetupDaysOfWeek;
  // mothly
  lbOfEvery.Caption := cxGetResourceString(@scxOfEvery);
  lbOfEvery1.Caption := lbOfEvery.Caption;
  lbMonths.Caption := cxGetResourceString(@scxMonths);
  lbMonths1.Caption := lbMonths.Caption;
  rbDay.Caption := cxGetResourceString(@scxDay);
  rbThe.Caption := cxGetResourceString(@scxThe);
  // yearly
  rbEvery1.Caption := rbEvery.Caption;
  rbThe1.Caption := rbThe.Caption;
  lbOf.Caption := cxGetResourceString(@scxOf);
  // range of recurrence
  gbRange.Caption := cxGetResourceString(@scxRangeOfRecurrence);
  lbStart1.Caption := cxGetResourceString(@scxStart1);
  rbNoEndDate.Caption := cxGetResourceString(@scxNoEndDate);
  rbEndAfter.Caption := cxGetResourceString(@scxEndAfter);
  rbEndBy.Caption := cxGetResourceString(@scxEndBy);
  lbOccurrences.Caption := cxGetResourceString(@scxOccurences);
  // buttons
  btnOk.Caption := cxGetResourceString(@scxOk);
  btnCancel.Caption := cxGetResourceString(@scxCancel);
  btnRemove.Caption := cxGetResourceString(@scxRemoveRecur);
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SetEndAfter;
var
  ACount: Integer;
  AEvent: TcxSchedulerControlEvent;
begin
  AEvent := TcxSchedulerControlEvent.Create(Event.Storage);
  try
    SaveEvent(AEvent);
    with TcxSchedulerOccurrenceCalculator.Create(AEvent, 0, cxMaxDate) do
    try
      ACount := GetOccurrenceCount(deEndBy.Date + TimeOf(teEnd.Time));
    finally
      Free;
    end;
  finally
    AEvent.Free;
  end;
  if ACount < 1 then
    ACount := 1;
  SetTextWithoutChangeEvent(meEndAfter, IntToStr(ACount));
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SetEndDate;
var
  ADate: TDateTime;
  AEvent: TcxSchedulerControlEvent;
begin
  AEvent := TcxSchedulerControlEvent.Create(Event.Storage);
  try
    AEvent.MoveTo(Event.Start);
    SaveEvent(AEvent);
    AEvent.RecurrenceInfo.Count := GetNumber(meEndAfter.Text);
    ADate := AEvent.RecurrenceInfo.GetEndDate;
  finally
    AEvent.Free;
  end;
  SetDateWithoutChangeEvent(deEndBy, ADate);
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SetEventRecurrenceFinish;
var
  ACount: Integer;
  AEvent: TcxSchedulerControlEvent;
begin
  AEvent := TcxSchedulerControlEvent.Create(Event.Storage);
  try
    SaveEvent(AEvent);
    with TcxSchedulerOccurrenceCalculator.Create(AEvent, 0, cxMaxDate) do
    try
      ACount := Info.Count;
      if ACount < 0 then ACount := 10;
      if ACount > 0 then
      begin
        if Info.Count < 0 then
          rbNoEndDate.Checked := True
        else
          rbEndAfter.Checked := True;
        CalcOccurrence(ACount);
        SetDateWithoutChangeEvent(deEndBy, DateOf(OccurrenceStart));
      end
      else
      begin
        rbEndBy.Checked := True;
        SetDateWithoutChangeEvent(deEndBy, DateOf(Info.Finish));
        ACount := GetOccurrenceCount(Info.Finish);
        if ACount < 1 then ACount := 1;
      end;
      SetTextWithoutChangeEvent(meEndAfter, IntToStr(ACount));
    finally
      Free;
    end;
  finally
    AEvent.Free;
  end;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SetReadOnly(
  AValue: Boolean);
begin
  inherited;
  gbTime.Enabled := not AValue;
  gbPattern.Enabled := not AValue;
  gbRange.Enabled := not AValue;
  btnCancel.Enabled := not AValue;
  btnRemove.Enabled := not AValue;
  NeedCheckLossOfExceptions := not ReadOnly;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.UpdateDuration;
var
  ADuration: TDateTime;
begin
  ADuration := DateOf(GetCurrentDuration) + (teEnd.Time - teStart.Time);
  if ADuration < 0 then ADuration := ADuration + 1;
  SetTextWithoutChangeEvent(cbDuration, cxMinutesToTextProc(Round(ADuration / MinuteToTime)));
end;

procedure TcxSchedulerRecurrenceEventEditorForm.UpdateEventValuesFromControls;
begin
  SaveEvent(Event);
  Event.Finish := Event.Start + GetCurrentDuration;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.UpdateRange;
begin
  if rbEndBy.Checked then
    SetEndAfter
  else
    SetEndDate;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.CheckViewRecurrence(AResetPattern: Boolean);
begin
  if AResetPattern then
  begin
    if rbDaily.Checked then
      ResetDailyTab;
    if rbWeekly.Checked then
      ResetWeeklyTab;
    if rbMonthly.Checked then
      ResetMonthlyTab;
    if rbYearly.Checked then
      ResetYearlyTab;
  end;
  pnlDaily.Visible := rbDaily.Checked;
  pnlWeekly.Visible := rbWeekly.Checked;
  pnlMonthly.Visible := rbMonthly.Checked;
  pnlYearly.Visible := rbYearly.Checked;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.FillDays;
var
  S: TStrings;
  I: Integer;
begin
  S := cbDay.Properties.Items;
  S.BeginUpdate;
  try
    S.Add(cxGetResourceString(@scxDay1));
    S.Add(cxGetResourceString(@scxWeekday));
    S.Add(cxGetResourceString(@scxWeekendday));
    for I := 1 to 7 do
      S.Add(dxFormatSettings.LongDayNames[I]);
  finally
    S.EndUpdate;
  end;
  cbDay1.Properties.Items.Assign(S);
end;

procedure TcxSchedulerRecurrenceEventEditorForm.FillMonths;
var
  S: TStrings;
  I: Integer;
begin
  S := cbMonths.Properties.Items;
  S.BeginUpdate;
  try
    for I := 1 to 12 do
      S.Add(dxFormatSettings.LongMonthNames[I]);
  finally
    S.EndUpdate;
  end;
  cbMonths1.Properties.Items.Assign(S);
end;

procedure TcxSchedulerRecurrenceEventEditorForm.FillWeeks;
var
  S: TStrings;
  I: Integer;
begin
  S := cbWeek.Properties.Items;
  S.BeginUpdate;
  try
    for I := 0 to 4 do
      S.Add(cxGetResourceString(sRangeNames[I]));
  finally
    S.EndUpdate;
  end;
  cbWeek1.Properties.Items.Assign(S);
end;

function TcxSchedulerRecurrenceEventEditorForm.GetActivePattern: TcxRecurrence;
begin
  if rbDaily.Checked then
    Result := cxreDaily
  else
    if rbWeekly.Checked then
      Result := cxreWeekly
    else
      if rbMonthly.Checked then
        Result := cxreMonthly
      else
        Result := cxreYearly;
end;

function TcxSchedulerRecurrenceEventEditorForm.GetRecurrenceInfo: TcxSchedulerEventRecurrenceInfo;
begin
  Result := Event.RecurrenceInfo;
end;

function TcxSchedulerRecurrenceEventEditorForm.GetDayOfWeekIndex: Integer;
begin
  Result := DayOfWeek(Info.Start) + 2;
end;

function TcxSchedulerRecurrenceEventEditorForm.GetMonthIndex: Integer;
begin
  Result := MonthOf(Info.Start) - 1;
end;

function TcxSchedulerRecurrenceEventEditorForm.GetNumber(const S: string): Integer;
begin
  Result := StrToIntDef(Trim(S), 1);
end;

function TcxSchedulerRecurrenceEventEditorForm.GetWeekIndex: Integer;
var
  Y, M, D: Word;
begin
  DecodeDate(Info.Start, Y, M, D);
  Result := D div 7;
end;

function TcxSchedulerRecurrenceEventEditorForm.GetCurrentDuration: TDateTime;
var
  AMinutes: Integer;
begin
  if cxTextToMinutesProc(cbDuration.Text, AMinutes) then
    Result := AMinutes * MinuteToTime
  else
    Result := Event.Duration;
end;

function TcxSchedulerRecurrenceEventEditorForm.IsValidDailyPattern: Boolean;
begin
  Result := GetNumber(meDay.Text) >= 1;
  if not Result then
  begin
    ActiveControl := meDay;
    Exit;
  end;
end;

function TcxSchedulerRecurrenceEventEditorForm.IsValidMonthlyPattern: Boolean;
begin
  Result := False;
  if not GetNumber(meNumOfDay.Text) in [1..31] then
  begin
    ActiveControl := meNumOfDay;
    Exit;
  end;
  if GetNumber(meNumMonth.Text) < 1 then
  begin
    ActiveControl := meNumMonth;
    Exit;
  end;
  if GetNumber(meNumMonth1.Text) < 1 then
  begin
    ActiveControl := meNumMonth1;
    Exit;
  end;
  Result := True;
end;

function TcxSchedulerRecurrenceEventEditorForm.IsValidWeeklyPattern: Boolean;
begin
  Result := False;
  if GetNumber(meNumOfWeek.Text) < 1 then
  begin
    ActiveControl := meNumOfWeek;
    Exit;
  end;
  if not (cbDayOfWeek1.Checked or cbDayOfWeek2.Checked or
    cbDayOfWeek3.Checked or cbDayOfWeek4.Checked or cbDayOfWeek5.Checked or
    cbDayOfWeek6.Checked or cbDayOfWeek7.Checked) then
  begin
    ActiveControl := cbDayOfWeek1;
    Exit;
  end;
  Result := True;
end;

function TcxSchedulerRecurrenceEventEditorForm.IsValidYearlyPattern: Boolean;
var
  ADay: Integer;
begin
  ADay := GetNumber(meDayOfMonth.Text);
  Result := (ADay >=1) and (ADay <= DaysPerMonth(2000, cbMonths.ItemIndex + 1));
  if not Result then
    ActiveControl := meDayOfMonth;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.ResetDailyTab;
begin
  SetTextWithoutChangeEvent(meDay, '1');
  rbEvery.Checked := True;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.ResetMonthlyTab;
begin
  SetTextWithoutChangeEvent(meNumOfDay, IntToStr(DayOf(Info.Start)));
  SetTextWithoutChangeEvent(meNumMonth, '1');
  SetTextWithoutChangeEvent(meNumMonth1, '1');
  cbWeek.ItemIndex := GetWeekIndex;
  cbDay.ItemIndex := GetDayOfWeekIndex;
  rbDay.Checked := True;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.ResetWeeklyTab;
begin
  SetTextWithoutChangeEvent(meNumOfWeek, '1');
  SelectDaysOfWeek([TDay(DayOfWeek(Info.Start) - 1)]);
end;

procedure TcxSchedulerRecurrenceEventEditorForm.ResetYearlyTab;
begin
  cbDay1.ItemIndex := GetDayOfWeekIndex;
  meDayOfMonth.Text := IntToStr(DayOf(Info.Start));
  cbWeek1.ItemIndex := GetWeekIndex;
  cbMonths.ItemIndex := GetMonthIndex;
  cbMonths1.ItemIndex := GetMonthIndex;
  rbEvery1.Checked := True;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SelectDaysOfWeek(ADays: TDays);

  procedure Check(ACheckBox: TcxCheckBox);
  begin
    ACheckBox.Checked := TDay(ACheckBox.Tag - 1) in ADays;
  end;

begin
  Check(cbDayOfWeek1);
  Check(cbDayOfWeek2);
  Check(cbDayOfWeek3);
  Check(cbDayOfWeek4);
  Check(cbDayOfWeek5);
  Check(cbDayOfWeek6);
  Check(cbDayOfWeek7);
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SetActivePattern(
  Value: TcxRecurrence);
begin
  UpdateRange;
  FModified := True;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SetDailyPatternFromEvent;
begin
  rbDaily.Checked := True;
  CheckViewRecurrence(False);
  if Info.DayType = cxdtWeekDay then
  begin
    rbEveryWeekday.Checked := True;
    SetTextWithoutChangeEvent(meDay, '1');
  end
  else
  begin
    rbEvery.Checked := True;
    SetTextWithoutChangeEvent(meDay, IntToStr(Info.Periodicity));
  end;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SetDateWithoutChangeEvent(
  AEdit: TcxDateEdit; ADate: TDateTime);
var
  AOnChange, AOnEditValueChanged: TNotifyEvent;
begin
  AOnChange := AEdit.Properties.OnChange;
  AOnEditValueChanged := AEdit.Properties.OnEditValueChanged;
  AEdit.Properties.OnChange := nil;
  AEdit.Properties.OnEditValueChanged := nil;
  AEdit.Date := ADate;
  AEdit.Properties.OnChange := AOnChange;
  AEdit.Properties.OnEditValueChanged := AOnEditValueChanged;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SetItemIndexWithoutChangeEvent(
  AEdit: TcxComboBox; AIndex: Integer);
var
  AOnChange: TNotifyEvent;
begin
  AOnChange := AEdit.Properties.OnChange;
  AEdit.Properties.OnChange := nil;
  AEdit.ItemIndex := AIndex;
  AEdit.Properties.OnChange := AOnChange;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SetMonthlyPatternFromEvent;
var
  AType: TcxDayType;
  ANum: Integer;
begin
  rbMonthly.Checked := True;
  CheckViewRecurrence(False);
  AType := Info.DayType;
  if AType = cxdtDay then
  begin
    rbDay.Checked := True;
    SetTextWithoutChangeEvent(meNumOfDay, IntToStr(Info.DayNumber));
    SetTextWithoutChangeEvent(meNumMonth, IntToStr(Info.Periodicity));
  end
  else
  begin
    rbThe.Checked := True;
    SetTextWithoutChangeEvent(meNumMonth1, IntToStr(Info.Periodicity));
    ANum := Info.DayNumber;
    if Integer(AType) >= 1 then Dec(Byte(AType));
    SetItemIndexWithoutChangeEvent(cbWeek, ANum - 1);
    SetItemIndexWithoutChangeEvent(cbDay, Byte(AType));
  end;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SetPatternFromEvent;
begin
  ActivePattern := Info.Recurrence;
  case Info.Recurrence of
    cxreDaily:   SetDailyPatternFromEvent;
    cxreWeekly:  SetWeeklyPatternFromEvent;
    cxreMonthly: SetMonthlyPatternFromEvent;
    cxreYearly:  SetYearlyPatternFromEvent;
  end;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SetupDaysOfWeek;

  procedure SetDayCheckBox(ACheck: TcxCheckBox);
  var
    AIndex: Integer;
  begin
    AIndex := ACheck.Tag;
    Inc(AIndex, TcxSchedulerDateTimeHelper.StartOfWeek);
    if AIndex > 7 then Dec(AIndex, 7);
    ACheck.Caption := dxFormatSettings.LongDayNames[AIndex];
    ACheck.Tag := AIndex;
  end;

begin
  SetDayCheckBox(cbDayOfWeek1);
  SetDayCheckBox(cbDayOfWeek2);
  SetDayCheckBox(cbDayOfWeek3);
  SetDayCheckBox(cbDayOfWeek4);
  SetDayCheckBox(cbDayOfWeek5);
  SetDayCheckBox(cbDayOfWeek6);
  SetDayCheckBox(cbDayOfWeek7);
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SetTextWithoutChangeEvent(
  AEdit: TcxCustomMaskEdit; const AText: string);
var
  AOnChange, AOnEditValueChanged: TNotifyEvent;
  AOnValidate: TcxEditValidateEvent;
begin
  AOnChange := AEdit.Properties.OnChange;
  AOnEditValueChanged := AEdit.Properties.OnEditValueChanged;
  AOnValidate := AEdit.Properties.OnValidate;
  AEdit.Properties.OnChange := nil;
  AEdit.Properties.OnEditValueChanged := nil;
  AEdit.Text := AText;
  AEdit.Properties.OnChange := AOnChange;
  AEdit.Properties.OnEditValueChanged := AOnEditValueChanged;
  AEdit.Properties.OnValidate := AOnValidate;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SetTimeWithoutChangeEvent(
  AEdit: TcxTimeEdit; ATime: TDateTime);
var
  AOnChange, AOnEditValueChanged: TNotifyEvent;
  AOnValidate: TcxEditValidateEvent;
begin
  AOnChange := AEdit.Properties.OnChange;
  AOnEditValueChanged := AEdit.Properties.OnEditValueChanged;
  AOnValidate := AEdit.Properties.OnValidate;
  AEdit.Properties.OnChange := nil;
  AEdit.Properties.OnEditValueChanged := nil;
  AEdit.Time := ATime;
  AEdit.Properties.OnChange := AOnChange;
  AEdit.Properties.OnEditValueChanged := AOnEditValueChanged;
  AEdit.Properties.OnValidate := AOnValidate;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SetWeeklyPatternFromEvent;
begin
  rbWeekly.Checked := True;
  CheckViewRecurrence(False);
  meNumOfWeek.Text := IntToStr(Info.Periodicity);
  if Event.IsRecurring and (Event.RecurrenceInfo.GetValidStatus = rvsValid) then
    SelectDaysOfWeek(Info.OccurDays)
  else
    SelectDaysOfWeek([TDay(DayOfWeek(Event.Start) - 1)]);
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SetYearlyPatternFromEvent;
var
  AType: TcxDayType;
  ANum: Integer;
begin
  rbYearly.Checked := True;
  CheckViewRecurrence(False);
  AType := Info.DayType;
  ANum := Info.DayNumber;
  if AType = cxdtDay then
  begin
    rbEvery1.Checked := True;
    cbMonths.ItemIndex := Info.Periodicity - 1;
    SetTextWithoutChangeEvent(meDayOfMonth, IntToStr(ANum));
  end
  else
  begin
    rbThe1.Checked := True;
    cbMonths1.ItemIndex := Info.Periodicity - 1;
    if Integer(AType) >= 1 then Dec(Byte(AType));
    SetItemIndexWithoutChangeEvent(cbWeek1, ANum - 1);
    SetItemIndexWithoutChangeEvent(cbDay1, Byte(AType));
  end;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.meEndAfterPropertiesChange(
  Sender: TObject);
begin
  rbEndAfter.Checked := True;
  FModified := True;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.deEndByPropertiesChange(
  Sender: TObject);
begin
  rbEndBy.Checked := True;
  FModified := True;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.rbNoEndDateClick(
  Sender: TObject);
begin
  SetTextWithoutChangeEvent(meEndAfter, '10');
  SetEndDate;
  FModified := True;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.meEndAfterExit(
  Sender: TObject);
begin
  ValidateNumber(Sender);
  SetEndDate;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.ValidateNumber(
  Sender: TObject);
begin
  with TcxMaskEdit(Sender) do
  begin
    if GetNumber(Text) <= 0 then
    begin
      MessageDlg(cxGetResourceString(@scxInvalidNumber), mtError, [mbOK], 0);
      Text := '1';
    end
    else
      Text := IntToStr(GetNumber(Text));
  end;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.meDayPropertiesChange(
  Sender: TObject);
begin
  rbEvery.Checked := True;
  FModified := True;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.rbEveryWeekdayClick(
  Sender: TObject);
begin
  SetTextWithoutChangeEvent(meDay, '1');
  FModified := True;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SetDayRadioButtonChecked(
  Sender: TObject);
begin
  rbDay.Checked := True;
  FModified := True;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.SetTheRadioButtonChecked(
  Sender: TObject);
begin
  rbThe.Checked := True;
  FModified := True;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.deStartPropertiesEditValueChanged(
  Sender: TObject);
begin
  UpdateRange;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.DoChange(Sender: TObject);
begin
  FModified := True;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.cbMonthsPropertiesChange(
  Sender: TObject);
begin
  rbEvery1.Checked := True;
  FModified := True;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.cbWeek1PropertiesChange(
  Sender: TObject);
begin
  rbThe1.Checked := True;
  FModified := True;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.btnOkClick(Sender: TObject);
begin
  if ReadOnly then
    ModalResult := mrOk
  else
  begin
    if IsValid then
    begin
      case GetRecurrenceInfoValidStatus of
        rvsValid:
          if CheckLostExceptions then
            ModalResult := mrOk;
        rvsReplaceOccurrenceDate:
          if CheckLostExceptions and (MessageDlg(Format(cxGetResourceString(@scxReplaceOccurrenceDate),
            [meNumOfDay.Text]), mtWarning, [mbOK,mbCancel], 0) = mrOk) then ModalResult := mrOk;
        rvsInvalidDuration:
          MessageDlg(cxGetResourceString(@scxInvalidRecurrenceDuration), mtWarning, [mbOK], 0);
        else
          MessageDlg(cxGetResourceString(@scxWrongPattern), mtWarning, [mbOK], 0);
       end
    end
    else
      MessageDlg(cxGetResourceString(@scxWrongPattern), mtWarning, [mbOK], 0);
  end;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.deEndByPropertiesEditValueChanged(
  Sender: TObject);
begin
  if Locked then Exit;
  SetEndAfter;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.meEndAfterPropertiesEditValueChanged(
  Sender: TObject);
begin
  if Locked then Exit;
  SetEndDate;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.cbDurationPropertiesPopup(
  Sender: TObject);
var
  AMinutes: Integer;
  AText: string;
begin
  AText := cbDuration.Text;
  if cxTextToMinutesProc(AText, AMinutes) then
  begin
    cbDuration.Text := cxMinutesToTextProc(AMinutes);
    cbDuration.EditModified := not SameText(AText, cbDuration.Text);
    cxComboBoxCaretToEnd(cbDuration);
    cxComboBoxSetNearestTimeInterval(cbDuration, AMinutes);
  end;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.cbDurationPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  AMinutes: Integer;
begin
  Error := not cxTextToMinutesProc(VarToStr(DisplayValue), AMinutes);
  if not Error then
  begin
    DisplayValue := cxMinutesToTextProc(AMinutes);
    cxComboBoxCaretToEnd(TcxComboBox(Sender));
    SetTimeWithoutChangeEvent(teEnd, TimeOf(teStart.Time + AMinutes * MinuteToTime));
  end
  else
    ErrorText := cxGetResourceString(@scxInvalidNumber);
end;

procedure TcxSchedulerRecurrenceEventEditorForm.EndTimeChanged(
  Sender: TObject);
begin
  UpdateDuration;
end;

procedure TcxSchedulerRecurrenceEventEditorForm.StartTimeChanged(
  Sender: TObject);
begin
  SetTimeWithoutChangeEvent(teEnd, TimeOf(teStart.Time + GetCurrentDuration));
end;

end.
