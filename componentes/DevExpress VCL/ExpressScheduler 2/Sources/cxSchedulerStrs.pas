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

unit cxSchedulerStrs;

{$I cxVer.inc}

interface

resourcestring
  scxUntitledEvent = 'Untitled event';

  scxVertical   = 'Vertical';
  scxHorizontal = 'Horizontal';
  scxTimeGrid   = 'TimeGrid';

  scxMinute  = 'Minute';
  scxMinutes = 'Minutes';
  scxHour    = 'Hour';
  scxHours   = 'Hours';
  scxOneDay  = 'One day';

  // dialogs constants
  scxDeleteRecurringEventDescription = 'is a recurring event. Do you want to delete only this occurrence or the series?';
  scxEditRecurringEventDescription   = 'is a recurring event. Do you want to open only this occurrence or the series?';

  scxGoToDateDialogCaption     = 'Go To Date';
  scxDeleteTypeDialogCaption   = 'Confirm Delete';
  scxDeleteTypeOccurrenceLabel = 'Delete this occurrence';
  scxDeleteTypeSeriesLabel     = 'Delete the series';
  scxEditTypeDialogCaption     = 'Open Recurring Item';
  scxEditTypeOccurrenceLabel   = 'Open this occurrence';
  scxEditTypeSeriesLabel       = 'Open the series';

  scxExitConfirmation  = 'Do you want to save changes?';
  scxDeleteConfirmation= 'This item has been changed. Are you sure you want to delete it?';
  scxWrongTimeBounds   = 'The end date you entered occurs before the start date.';
  scxWrongPattern      = 'The recurrence pattern is not valid.';
  scxReplaceOccurrenceDate = 'Some months have fewer than %s days. For these months, the occurrence will fall on the last day of the month.';
  scxInvalidRecurrenceDuration = 'The duration of the event must be shorter than how frequently it occurs. ' +
    'Shorten the duration, or change the recurrence pattern in the Recurrence dialog box.';
  scxConfirmLostExceptions = 'Any exceptions associated with this recurring event will be lost. Is this OK?';
  scxInvalidNumber      = 'You must enter a valid number.';
  scxNoAvailableFreeTime = 'No free time is available.';

  scxEvent             = 'Event';
  scxUntitled          = 'Untitled';

  scxNoneEvent         = 'simple event';
  scxRecurrenceEvent   = 'recurrence event';
  scxExceptionEvent    = 'exception event';
  scxOccurenceEvent    = 'occurence event';

  scxAdd               = '&Add';
  scxEdit              = '&Edit';
  scxDelete            = '&Delete';
  scxRecurrence        = '&Recurrence';

  scxDate              = '&Date:';
  scxShowIn            = '&Show in:';
  scxDayCalendar       = 'Day Calendar';
  scxWeekCalendar      = 'Week Calendar';
  scxMonthCalendar     = 'Month Calendar';
  scxWorkWeekCalendar  = 'Work Week Calendar';

  scxEventsConflict    = 'Conflicts with another event in your schedule.';
  scxResource          = 'Resource';
  scxSubject           = '&Subject:';
  scxLocation          = '&Location:';
  scxLabel             = 'La&bel:';
  scxStartTime         = 'S&tart time:';
  scxEndTime           = '&End time:';
  scxAllDayEvent       = '&All day event';
  scxRecurrenceLabel   = 'Recurrence:';

  scxReminder          = 'Reminder:';
  scxShowTimeAs        = 'Sho&w time as:';

  scxSuffixMinute      = 'minute';
  scxSuffixMinutes     = 'minutes';
  scxSuffixHour        = 'hour';
  scxSuffixHours       = 'hours';
  scxSuffixDay         = 'day';
  scxSuffixDays        = 'days';
  scxSuffixWeek        = 'week';
  scxSuffixWeeks       = 'weeks';

  scxBusy              = 'Busy';
  scxFree              = 'Free';
  scxTentative         = 'Tentative';
  scxOutOfOffice       = 'Out of office';

  scxRecurrenceCaption = 'Event recurrence';
  scxEventTime         = ' Event time ';
  scxRecurrencePattern = ' Recurrence pattern ';
  scxRangeOfRecurrence = ' Range of recurrence ';
  scxStart             = '&Start:';
  scxStart1            = 'S&tart:';
  scxEnd               = '&End:';
  scxDuration          = 'D&uration:';
  // Pattern
  scxDaily             = '&Daily';
  scxWeekly            = '&Weekly';
  scxQuarterly         = '&Quarterly';
  scxMonthly           = '&Monthly';
  scxYearly            = '&Yearly';
  // daily
  scxEvery             = 'E&very';
  scxEveryWeekDay      = 'Every wee&kday';
  scxDays              = 'day(s)';
  // weekly
  scxWeeksOn           = 'week(s) on:';
  scxRecurEvery        = 'Rec&ur every';
  //monthly
  scxOfEvery           = 'of every';
  scxMonths            = 'month(s)';
  // yearly
  scxThe               = 'T&he';
  scxOf                = 'of';

  // other
  scxFirst             = 'first';
  scxSecond            = 'second';
  scxThird             = 'third';
  scxFourth            = 'fourth';
  scxLast              = 'last';
  scxDay               = 'D&ay';
  scxDay1              = 'day';
  scxWeekday           = 'weekday';
  scxWeekendday        = 'weekend day';
  scxNoEndDate         = '&No end date';
  scxEndAfter          = 'End a&fter:';
  scxEndBy             = 'End &by:';
  scxOccurences        = 'occurrences';

  // buttons
  scxFindAvailableTime = 'Find available time';
  scxOk                = '&OK';
  scxCancel            = '&Cancel';
  scxClose             = '&Close';
  scxDown              = '&Down';
  scxRemoveRecur       = '&Remove recurrence';
  scxUp                = '&Up';
  //
  scxResourceLayoutCaption = 'Resources layout editor';

  // popup menu resources
  scxpmNewEvent          = '&New Event';
  scxpmNewAllDayEvent    = 'New All Day &Event';
  scxpmNewRecurringEvent = 'New &Recurring Event';
  scxpmToday             = 'T&oday';
  scxpmGotoThisDay       = 'Go to This &Day';
  scxpmGoToDate          = 'Go &to Date...';
  scxpmResourcesLayout   = 'Resources layout editor...';

  // for event
  scxpmOpen              = '&Open';
  scxpmEditSeries        = 'Edit Se&ries';
  scxpmShowTimeAs        = 'S&how Time As';
  scxpmDelete            = '&Delete';
  scxpmFree              = '&Free';
  scxpmTentative         = '&Tentative';
  scxpmBusy              = '&Busy';
  scxpmOutOfOffice       = '&Out of Office';
  scxpmLabel             = '&Label';

  // event label captions
  scxEventLabelNone      = 'None';
  scxEventLabel0         = 'Important';
  scxEventLabel1         = 'Business';
  scxEventLabel2         = 'Personal';
  scxEventLabel3         = 'Vacation';
  scxEventLabel4         = 'Must Attend';
  scxEventLabel5         = 'Travel Required';
  scxEventLabel6         = 'Needs Preparation';
  scxEventLabel7         = 'Birthday';
  scxEventLabel8         = 'Anniversary';
  scxEventLabel9         = 'Phone Call';

  // for time ruler menu items
  scxpmTimeZone          = 'Chan&ge Time Zone';
  scxpm60Minutes         = '6&0 Minutes';
  scxpm30Minutes         = '&30 Minutes';
  scxpm15Minutes         = '&15 Minutes';
  scxpm10Minutes         = '10 &Minutes';
  scxpm6Minutes          = '&6 Minutes';
  scxpm5Minutes          = '&5 Minutes';

  //navigator hints
  scxFirstButtonHint     = 'First Resource';
  scxPrevPageButtonHint  = 'Previous Page';
  scxPrevButtonHint      = 'Previous Resource';
  scxNextButtonHint      = 'Next Resource';
  scxNextPageButtonHint  = 'Next Page';
  scxLastButtonHint      = 'Last Resource';
  scxShowMoreResourcesButtonHint  = 'Show More Resources';
  scxShowFewerResourcesButtonHint = 'Show Fewer Resources';

  //for reminder
  scxrCaptionReminder  = '1 Reminder';
  scxrCaptionReminders = '%d Reminders';
  scxrDismissButton    = '&Dismiss';
  scxrDismissAllButton = 'Dismiss &All';
  scxrDueIn            = 'Due in';
  scxrOpenItemButton   = '&Open Item';
  scxrSnoozeButton     = '&Snooze';
  scxrSubject          = 'Subject';
  scxrSnoozeLabel      = '&Snooze';
  scxrSelected         = '%d reminders are selected';
  scxrStartTime        = 'Start time: %s';

  // time
  scxTime0m     = '0 minutes';
  scxTime5m     = '5 minutes';
  scxTime10m    = '10 minutes';
  scxTime15m    = '15 minutes';
  scxTime20m    = '20 minutes';
  scxTime30m    = '30 minutes';
  scxTime1h     = '1 hour';
  scxTime2h     = '2 hours';
  scxTime3h     = '3 hours';
  scxTime4h     = '4 hours';
  scxTime5h     = '5 hours';
  scxTime6h     = '6 hours';
  scxTime7h     = '7 hours';
  scxTime8h     = '8 hours';
  scxTime9h     = '9 hours';
  scxTime10h    = '10 hours';
  scxTime11h    = '11 hours';
  scxTime12h    = '12 hours';
  scxTime18h    = '18 hours';
  scxTime1d     = '1 day';
  scxTime2d     = '2 days';
  scxTime3d     = '3 days';
  scxTime4d     = '4 days';
  scxTime1w     = '1 week';
  scxTime2w     = '2 weeks';
  // advance time
  scxAdvance0h  = '0 hours before start';
  scxAdvance5m  = '5 minutes before start';
  scxAdvance10m = '10 minutes before start';
  scxAdvance15m = '15 minutes before start';

  // for export

  secxExportStorageInvalid = 'Storage not assigned';

  // card field names
  
  secxYes         = 'Yes';
  secxNo          = 'No';
  secxSubject     = 'Subject';
  secxLocation    = 'Location';
  secxDescription = 'Description';
  secxAllDay      = 'All day';
  secxStart       = 'Start';
  secxFinish      = 'Finish';
  secxState       = 'State';
  secxReminder    = 'Reminder';

  // table fields

  secxStartDate          = 'StartDate';
  secxStartTime          = 'StartTime';
  secxEndDate            = 'EndDate';
  secxEndTime            = 'EndTime';
  secxAlldayevent        = 'Alldayevent';
  secxReminderonoff      = 'Reminderonoff';
  secxReminderDate       = 'ReminderDate';
  secxReminderTime       = 'ReminderTime';
  secxMeetingOrganizer   = 'MeetingOrganizer';
  secxRequiredAttendees  = 'RequiredAttendees';
  secxOptionalAttendees  = 'OptionalAttendees';
  secxMeetingResources   = 'MeetingResources';
  secxBillingInformation = 'BillingInformation';
  secxCategories         = 'Categories';
  secxMileage            = 'Mileage';
  secxPriority           = 'Priority';
  secxPrivate            = 'Private';
  secxSensitivity        = 'Sensitivity';
  secxShowtimeas         = 'Showtimeas';

  secxNormal             = 'Normal';

  // storage
  scxRequiredFieldsNeeded = 'The following required fields'#13#10'%sare not assigned!';
  scxInvalidFieldName = 'Invalid field name';
  scxInvalidCustomField = 'Invalid custom field';

const
  sRangeNames: array[0..4] of Pointer =
    (@scxFirst, @scxSecond, @scxThird, @scxFourth, @scxLast);
  sDayNames: array [0..9] of string =
    (scxDay, scxWeekday, scxWeekendday, '', '', '', '', '', '', '');
  sEventLabelCaptions: array[0..10] of Pointer = (
    @scxEventLabelNone, @scxEventLabel0, @scxEventLabel1, @scxEventLabel2,
    @scxEventLabel3, @scxEventLabel4, @scxEventLabel5, @scxEventLabel6,
    @scxEventLabel7, @scxEventLabel8, @scxEventLabel9);

procedure cxSchedulerInitStrings;

implementation

uses
  dxCore, SysUtils;

procedure cxSchedulerInitStrings;
var
  I: Integer;
begin
  for I := 1 to 7 do
    sDayNames[2 + I] := dxFormatSettings.LongDayNames[I];
end;

initialization
  cxSchedulerInitStrings;

end.
