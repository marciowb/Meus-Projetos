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

unit cxSchedulerOutlookExchange;

{$I cxVer.inc}

interface

uses
  cxSchedulerStorage;

type
  TcxAcceptEventExportFunc = function(AEvent: TcxSchedulerEvent): Boolean;
  TcxAcceptAppointmentItemImportFunc = function(const AppointmentItem: OleVariant): Boolean;
  TcxEventToAppointmentItemProc = procedure(AEvent: TcxSchedulerEvent; const AppointmentItem: OleVariant);
  TcxAppointmentItemToEventProc = procedure(const AppointmentItem: OleVariant; AEvent: TcxSchedulerEvent);

procedure cxSchedulerExportToOutlook(AStorage: TcxCustomSchedulerStorage;
  AcceptFunc: TcxAcceptEventExportFunc = nil;
  AConvertProc: TcxEventToAppointmentItemProc = nil);

procedure cxSchedulerImportFromOutlook(AStorage: TcxCustomSchedulerStorage;
  AcceptFunc: TcxAcceptAppointmentItemImportFunc = nil;
  AConvertProc: TcxAppointmentItemToEventProc = nil);

implementation

uses
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  ComObj, cxClasses, cxDateUtils;

const
  olFolderCalendar  = $00000009;
  olAppointmentItem = $00000001;

  //recurrence
  olRecursDaily    = $00000000;
  olRecursWeekly   = $00000001;
  olRecursMonthly  = $00000002;
  olRecursMonthNth = $00000003;
  olRecursYearly   = $00000005;
  olRecursYearNth  = $00000006;

  // Constants for enum OlDaysOfWeek
  olSunday     = $00000001;
  olMonday     = $00000002;
  olTuesday    = $00000004;
  olWednesday  = $00000008;
  olThursday   = $00000010;
  olFriday     = $00000020;
  olSaturday   = $00000040;
  olWeekDay    = 62;
  olWeekEndDay = 65;
  olEveryDay   = 127;

  // Constants for enum OlBusyStatus
  olFree        = $00000000;
  olTentative   = $00000001;
  olBusy        = $00000002;
  olOutOfOffice = $00000003;

  scxOutlookApp = 'outlook.application';
  scxNameSpace  = 'MAPI';

function GetAllDayEvent(const AppointmentItem: OleVariant): Boolean;
var
  ARecurrencePattern: OleVariant;
begin
  Result := AppointmentItem.AllDayEvent;
  if Result then
  begin
    if AppointmentItem.IsRecurring then
    begin
      ARecurrencePattern := AppointmentItem.GetRecurrencePattern;
      if Integer(ARecurrencePattern.RecurrenceType) in
        [olRecursMonthly, olRecursMonthNth, olRecursYearly, olRecursYearNth] then
      begin
        Result := (TimeOf(ARecurrencePattern.StartTime) = 0) and
          (TimeOf(ARecurrencePattern.EndTime) = 0);
      end;
    end;
  end;
end;

procedure SetupEventInfo(AEvent: TcxSchedulerEvent; const AppointmentItem: OleVariant);
begin
  with AEvent do
  begin
    AllDayEvent := GetAllDayEvent(AppointmentItem);
    Start := AppointmentItem.Start;
    Finish := AppointmentItem.End;
    Caption := AppointmentItem.Subject;
    Message := AppointmentItem.Body;
    State := AppointmentItem.BusyStatus;
    Location := AppointmentItem.Location;
    //for next version
    //Reminder := AppointmentItem.ReminderSet;
    //ReminderTime := AppointmentItem.ReminderMinutesBeforeStart;
  end;
end;

function GetDaysOfWeekFromMask(AMask: Integer): TDays;
var
  I: Integer;
begin
  Result := [];
  for I := 0 to 6 do
    if (1 shl I) and AMask <> 0 then
      Include(Result, TDay(I));
end;

function GetMaskFromDaysOfWeek(ADays: TDays): Integer;
var
  I: TDay;
begin
  Result := 0;
  for I := dSunday to dSaturday do
    if I in ADays then
      Result := Result or (1 shl Ord(I));
end;

function GetDayTypeFromMask(AMask: Integer): TcxDayType;
begin
  case AMask of
    olSunday : Result := cxdtSunday;
    olMonday : Result := cxdtMonday;
    olTuesday : Result := cxdtTuesday;
    olWednesday : Result := cxdtWednesday;
    olThursday: Result := cxdtThursday;
    olFriday: Result := cxdtFriday;
    olSaturday: Result := cxdtSaturday;
    olWeekDay  : Result := cxdtWeekDay;
    olWeekEndDay: Result := cxdtWeekEndDay;
  else
    Result := cxdtEveryDay;
  end;
end;

procedure CheckRecurrenceExceptions(
  AEvent: TcxSchedulerEvent;
  const ARecurrencePattern: OleVariant;
  AcceptFunc: TcxAcceptAppointmentItemImportFunc;
  AConvertProc: TcxAppointmentItemToEventProc);
const
  ExceptionType: array[Boolean] of TcxEventType = (etCustom, etException);
var
  I: Integer;
  AException: OleVariant;
  ADeleted: Boolean;
  AOccurrence: TcxSchedulerEvent;
begin
  for I := 1 to ARecurrencePattern.Exceptions.Count do
  begin
    AException := ARecurrencePattern.Exceptions.Item(I);
    ADeleted := AException.Deleted;
    if not ADeleted and Assigned(AcceptFunc) and not
      AcceptFunc(AException.AppointmentItem) then continue;
    AOccurrence := AEvent.Storage.CreateOccurrence(AEvent,
      AException.OriginalDate, ExceptionType[ADeleted]);
    if not ADeleted then
    begin
      SetupEventInfo(AOccurrence, AException.AppointmentItem);
      if Assigned(AConvertProc) then
        AConvertProc(AException.AppointmentItem, AOccurrence);
    end;
    AOccurrence.Post;
  end;
end;

procedure SetupEventRecurrenceInfo(AEvent: TcxSchedulerEvent; const ARecurrencePattern: OleVariant);
var
  AType, AInterval: Integer;
  ADate: TDateTime;
begin
  AEvent.EventType := etPattern;
  ADate := ARecurrencePattern.PatternStartDate;
  if not AEvent.AllDayEvent then
    ADate := ADate + ARecurrencePattern.StartTime;
  AEvent.RecurrenceInfo.Start := ADate;
  if ARecurrencePattern.NoEndDate then
    AEvent.RecurrenceInfo.Count := -1
  else
  begin
    //AEvent.RecurrenceInfo.Count := 0;
    ADate := ARecurrencePattern.PatternEndDate;
    if not AEvent.AllDayEvent then
      ADate := ADate + ARecurrencePattern.EndTime;
    AEvent.RecurrenceInfo.Finish := ADate;
    AEvent.RecurrenceInfo.Count := ARecurrencePattern.Occurrences;
  end;
  AType := ARecurrencePattern.RecurrenceType;
  case AType of
    olRecursDaily:
      begin
        AEvent.RecurrenceInfo.Recurrence := cxreDaily;
        AEvent.RecurrenceInfo.DayType := cxdtEveryDay;
        AEvent.RecurrenceInfo.Periodicity := ARecurrencePattern.Interval;
      end;
    olRecursWeekly:
      begin
        AInterval := ARecurrencePattern.Interval;
        if AInterval = 0 then
        begin
          AEvent.RecurrenceInfo.Recurrence := cxreDaily;
          AEvent.RecurrenceInfo.DayType := cxdtWeekDay;
        end
        else
        begin
          AEvent.RecurrenceInfo.Recurrence := cxreWeekly;
          AEvent.RecurrenceInfo.Periodicity := AInterval;
        end;
        AEvent.RecurrenceInfo.OccurDays :=
          GetDaysOfWeekFromMask(ARecurrencePattern.DayOfWeekMask);
      end;
    olRecursMonthly:
      begin
        AEvent.RecurrenceInfo.DayType := cxdtDay;
        AEvent.RecurrenceInfo.Recurrence := cxreMonthly;
        AEvent.RecurrenceInfo.Periodicity := ARecurrencePattern.Interval;
        AEvent.RecurrenceInfo.DayNumber := ARecurrencePattern.DayOfMonth
      end;
    olRecursMonthNth:
      begin
        AEvent.RecurrenceInfo.DayType := GetDayTypeFromMask(ARecurrencePattern.DayOfWeekMask);
        AEvent.RecurrenceInfo.Recurrence := cxreMonthly;
        AEvent.RecurrenceInfo.Periodicity := ARecurrencePattern.Interval;
        AEvent.RecurrenceInfo.DayNumber := ARecurrencePattern.Instance;
      end;
    olRecursYearly:
      begin
        AEvent.RecurrenceInfo.DayType := cxdtDay;
        AEvent.RecurrenceInfo.Recurrence := cxreYearly;
        AEvent.RecurrenceInfo.Periodicity := ARecurrencePattern.MonthOfYear;
        AEvent.RecurrenceInfo.DayNumber := ARecurrencePattern.DayOfMonth
      end;
    olRecursYearNth:
      begin
        AEvent.RecurrenceInfo.DayType := GetDayTypeFromMask(ARecurrencePattern.DayOfWeekMask);
        AEvent.RecurrenceInfo.Recurrence := cxreYearly;
        AEvent.RecurrenceInfo.Periodicity := ARecurrencePattern.MonthOfYear;
        AEvent.RecurrenceInfo.DayNumber := ARecurrencePattern.Instance;
      end;
  end;
end;

procedure cxSchedulerImportFromOutlook(AStorage: TcxCustomSchedulerStorage;
  AcceptFunc: TcxAcceptAppointmentItemImportFunc = nil;
  AConvertProc: TcxAppointmentItemToEventProc = nil);
var
  I: Integer;
  AOutlookApp, ANameSpace, AFolderCalendar, AppointmentItem, ARecurrencePattern: OleVariant;
  AWasCreated: Boolean;
  AEvent: TcxSchedulerEvent;
  Accept: Boolean;

  procedure PostEvent;
  begin
    if Assigned(AConvertProc) then
      AConvertProc(AppointmentItem, AEvent);
    AEvent.Post;
  end;

begin
  if AStorage = nil then Exit;
  AWasCreated := False;
  try
    AOutlookApp := GetActiveOleObject(scxOutlookApp);
  except
    AOutlookApp := CreateOleObject(scxOutlookApp);
    AWasCreated := True;
  end;
  try
    ANameSpace := AOutlookApp.GetNamespace(scxNameSpace);
    AFolderCalendar := ANameSpace.GetDefaultFolder(olFolderCalendar);
    for I := 1 to AFolderCalendar.Items.Count do
    begin
      AppointmentItem := AFolderCalendar.Items(I);
      Accept := not Assigned(AcceptFunc) or AcceptFunc(AppointmentItem);
      if Accept then
      begin
        AEvent := AStorage.CreateEvent;
        SetupEventInfo(AEvent, AppointmentItem);
        if AppointmentItem.IsRecurring then
        begin
          ARecurrencePattern := AppointmentItem.GetRecurrencePattern;
          SetupEventRecurrenceInfo(AEvent, ARecurrencePattern);
          PostEvent;
          CheckRecurrenceExceptions(AEvent, ARecurrencePattern, AcceptFunc, AConvertProc);
        end
        else
          PostEvent;
      end;
    end;
  finally
    if AWasCreated then
      AOutlookApp := Unassigned;
  end;
end;

function GetMaskFromDayType(ADayType: TcxDayType): Integer;
const
  Masks: array[TcxDayType] of Byte = (olEveryDay, olEveryDay, olWeekDay,
    olWeekEndDay, olSunday, olMonday, olTuesday, olWednesday, olThursday,
    olFriday, olSaturday);
begin
  Result := Masks[ADayType];
end;

procedure SetupAppointmentItemInfo(AppointmentItem: OleVariant;
  const AEvent: TcxSchedulerEvent);
begin
  with AEvent do
  begin
    AppointmentItem.AllDayEvent := AllDayEvent;
    AppointmentItem.Start := Start;
    AppointmentItem.End := Finish;
    AppointmentItem.Subject := Caption;
    AppointmentItem.Body := Message;
    AppointmentItem.BusyStatus := State;
    AppointmentItem.Location := Location;
    //for next version
    //AppointmentItem.ReminderMinutesBeforeStart := ReminderTime;
    AppointmentItem.ReminderSet := False;//Reminder;
  end;
end;

function GetOccurrenceOriginalStart(AEvent: TcxSchedulerEvent): TDateTime;
begin
  with TcxSchedulerOccurrenceCalculator.Create(AEvent.Pattern, 0, 0) do
  try
    CalcOccurrence(AEvent.RecurrenceIndex + 1);
    Result := OccurrenceStart;
  finally
    Free;
  end;
end;

procedure UpdateAppointmentItem(AEvent: TcxSchedulerEvent;
  const AppointmentItem: OleVariant; AConvertProc: TcxEventToAppointmentItemProc);
begin
  if Assigned(AConvertProc) then
    AConvertProc(AEvent, AppointmentItem);
  try
    AppointmentItem.Save;
  except
  end;
end;

procedure CheckRecurrencePatternExceptions(const ARecurrencePattern: OleVariant;
  ARecurrenceInfo: TcxSchedulerEventRecurrenceInfo;
  AcceptFunc: TcxAcceptEventExportFunc;
  AConvertProc: TcxEventToAppointmentItemProc);
var
  I: Integer;
  AEvent: TcxSchedulerEvent;
  AppointmentItem: OleVariant;
begin
  with ARecurrenceInfo.Event.GetRecurrenceChain do
  try
    for I := 0 to Count - 1 do
    begin
      AEvent := Items[I];
      try
        AppointmentItem := ARecurrencePattern.GetOccurrence(GetOccurrenceOriginalStart(AEvent));
        if AEvent.EventType = etException then
          AppointmentItem.Delete
        else
          if (AEvent.EventType = etCustom) and (not Assigned(AcceptFunc) or AcceptFunc(AEvent)) then
          begin
            SetupAppointmentItemInfo(AppointmentItem, AEvent);
            UpdateAppointmentItem(AEvent, AppointmentItem, AConvertProc);
          end;
      except
      end;
    end;
  finally
    Free;
  end;
end;

procedure SetAppointmentItemRecurrence(const ARecurrencePattern: OleVariant;
  AEvent: TcxSchedulerEvent);
begin
  with AEvent.RecurrenceInfo do
  begin
    ARecurrencePattern.PatternStartDate := DateOf(AEvent.Start);
    ARecurrencePattern.StartTime := TimeOf(AEvent.Start);
    ARecurrencePattern.EndTime := TimeOf(AEvent.Finish);
    case Recurrence of
      cxreDaily:
        begin
          if DayType = cxdtEveryDay then
          begin
            ARecurrencePattern.RecurrenceType := olRecursDaily;
            ARecurrencePattern.Interval := Periodicity;
          end
          else
            if DayType = cxdtWeekDay then
            begin
              ARecurrencePattern.RecurrenceType := olRecursWeekly;
              ARecurrencePattern.DayOfWeekMask := olWeekDay;
            end;
        end;
      cxreWeekly:
        begin
          ARecurrencePattern.RecurrenceType := olRecursWeekly;
          ARecurrencePattern.DayOfWeekMask := GetMaskFromDaysOfWeek(OccurDays);
          ARecurrencePattern.Interval := Periodicity;
        end;
      cxreMonthly:
        begin
          if DayType = cxdtDay then
          begin
            ARecurrencePattern.RecurrenceType := olRecursMonthly;
            ARecurrencePattern.DayOfMonth := DayNumber;
            ARecurrencePattern.Interval := Periodicity;
          end
          else
          begin
            ARecurrencePattern.RecurrenceType := olRecursMonthNth;
            ARecurrencePattern.Interval := Periodicity;
            ARecurrencePattern.DayOfWeekMask := GetMaskFromDayType(DayType);
            ARecurrencePattern.Instance := DayNumber;
          end;
        end;
      cxreYearly:
        begin
          if DayType = cxdtDay then
          begin
            ARecurrencePattern.RecurrenceType := olRecursYearly;
            ARecurrencePattern.DayOfMonth := DayNumber;
            ARecurrencePattern.MonthOfYear := Periodicity;
          end
          else
          begin
            ARecurrencePattern.RecurrenceType := olRecursYearNth;
            ARecurrencePattern.MonthOfYear := Periodicity;
            ARecurrencePattern.DayOfWeekMask := GetMaskFromDayType(DayType);
            ARecurrencePattern.Instance := DayNumber;
          end;
        end;
    end;
    if Count = -1 then
      ARecurrencePattern.NoEndDate := True
    else
      if Count = 0 then
        ARecurrencePattern.PatternEndDate := Finish
      else
        ARecurrencePattern.Occurrences := Count;
  end;
end;

procedure cxSchedulerExportToOutlook(AStorage: TcxCustomSchedulerStorage;
  AcceptFunc: TcxAcceptEventExportFunc = nil;
  AConvertProc: TcxEventToAppointmentItemProc = nil);
var
  I: Integer;
  AOutlookApp, ANameSpace, AFolderCalendar, AppointmentItem, ARecurrencePattern: OleVariant;
  Accept, AWasCreated: Boolean;
  AEvent: TcxSchedulerEvent;
begin
  if AStorage = nil then Exit;
  AWasCreated := False;
  try
    AOutlookApp := GetActiveOleObject(scxOutlookApp);
  except
    AOutlookApp := CreateOleObject(scxOutlookApp);
    AWasCreated := True;
  end;
  AStorage.BeginUpdate;
  try
    ANameSpace := AOutlookApp.GetNamespace(scxNameSpace);
    AFolderCalendar := ANameSpace.GetDefaultFolder(olFolderCalendar);
    for I := 0 to AStorage.EventCount - 1 do
    begin
      AEvent := AStorage.Events[I];
      if AEvent.EventType in [etNone, etPattern] then
      begin
        Accept := not Assigned(AcceptFunc) or AcceptFunc(AEvent);
        if not Accept then continue;
        AppointmentItem := AOutlookApp.CreateItem(olAppointmentItem);
        SetupAppointmentItemInfo(AppointmentItem, AEvent);
        if AEvent.IsRecurring then
        begin
          ARecurrencePattern := AppointmentItem.GetRecurrencePattern;
          SetAppointmentItemRecurrence(ARecurrencePattern, AEvent);
          if Assigned(AConvertProc) then
            AConvertProc(AEvent, AppointmentItem);
          UpdateAppointmentItem(AEvent, AppointmentItem, AConvertProc);
          CheckRecurrencePatternExceptions(ARecurrencePattern,
            AEvent.RecurrenceInfo, AcceptFunc, AConvertProc);
        end
        else
          UpdateAppointmentItem(AEvent, AppointmentItem, AConvertProc);
      end;
    end;
  finally
    AStorage.EndUpdate;
    if AWasCreated then
      AOutlookApp := Unassigned;
  end;
end;

end.
