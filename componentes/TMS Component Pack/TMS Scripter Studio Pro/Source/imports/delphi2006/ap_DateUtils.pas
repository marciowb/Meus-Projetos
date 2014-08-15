{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_DateUtils;

interface

uses
  SysUtils,
  Math,
  Types,
  DateUtils,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatDateUtilsLibrary = class(TatScripterLibrary)
    procedure __DateOf(AMachine: TatVirtualMachine);
    procedure __TimeOf(AMachine: TatVirtualMachine);
    procedure __IsInLeapYear(AMachine: TatVirtualMachine);
    procedure __IsPM(AMachine: TatVirtualMachine);
    procedure __IsValidDate(AMachine: TatVirtualMachine);
    procedure __IsValidTime(AMachine: TatVirtualMachine);
    procedure __IsValidDateTime(AMachine: TatVirtualMachine);
    procedure __IsValidDateDay(AMachine: TatVirtualMachine);
    procedure __IsValidDateWeek(AMachine: TatVirtualMachine);
    procedure __IsValidDateMonthWeek(AMachine: TatVirtualMachine);
    procedure __WeeksInYear(AMachine: TatVirtualMachine);
    procedure __WeeksInAYear(AMachine: TatVirtualMachine);
    procedure __DaysInYear(AMachine: TatVirtualMachine);
    procedure __DaysInAYear(AMachine: TatVirtualMachine);
    procedure __DaysInMonth(AMachine: TatVirtualMachine);
    procedure __DaysInAMonth(AMachine: TatVirtualMachine);
    procedure __Today(AMachine: TatVirtualMachine);
    procedure __Yesterday(AMachine: TatVirtualMachine);
    procedure __Tomorrow(AMachine: TatVirtualMachine);
    procedure __IsToday(AMachine: TatVirtualMachine);
    procedure __IsSameDay(AMachine: TatVirtualMachine);
    procedure __YearOf(AMachine: TatVirtualMachine);
    procedure __MonthOf(AMachine: TatVirtualMachine);
    procedure __WeekOf(AMachine: TatVirtualMachine);
    procedure __DayOf(AMachine: TatVirtualMachine);
    procedure __HourOf(AMachine: TatVirtualMachine);
    procedure __MinuteOf(AMachine: TatVirtualMachine);
    procedure __SecondOf(AMachine: TatVirtualMachine);
    procedure __MilliSecondOf(AMachine: TatVirtualMachine);
    procedure __StartOfTheYear(AMachine: TatVirtualMachine);
    procedure __EndOfTheYear(AMachine: TatVirtualMachine);
    procedure __StartOfAYear(AMachine: TatVirtualMachine);
    procedure __EndOfAYear(AMachine: TatVirtualMachine);
    procedure __StartOfTheMonth(AMachine: TatVirtualMachine);
    procedure __EndOfTheMonth(AMachine: TatVirtualMachine);
    procedure __StartOfAMonth(AMachine: TatVirtualMachine);
    procedure __EndOfAMonth(AMachine: TatVirtualMachine);
    procedure __StartOfTheWeek(AMachine: TatVirtualMachine);
    procedure __EndOfTheWeek(AMachine: TatVirtualMachine);
    procedure __StartOfAWeek(AMachine: TatVirtualMachine);
    procedure __EndOfAWeek(AMachine: TatVirtualMachine);
    procedure __StartOfTheDay(AMachine: TatVirtualMachine);
    procedure __EndOfTheDay(AMachine: TatVirtualMachine);
    procedure __StartOfADay(AMachine: TatVirtualMachine);
    procedure __EndOfADay(AMachine: TatVirtualMachine);
    procedure __MonthOfTheYear(AMachine: TatVirtualMachine);
    procedure __WeekOfTheYear(AMachine: TatVirtualMachine);
    procedure __DayOfTheYear(AMachine: TatVirtualMachine);
    procedure __HourOfTheYear(AMachine: TatVirtualMachine);
    procedure __MinuteOfTheYear(AMachine: TatVirtualMachine);
    procedure __SecondOfTheYear(AMachine: TatVirtualMachine);
    procedure __MilliSecondOfTheYear(AMachine: TatVirtualMachine);
    procedure __WeekOfTheMonth(AMachine: TatVirtualMachine);
    procedure __DayOfTheMonth(AMachine: TatVirtualMachine);
    procedure __HourOfTheMonth(AMachine: TatVirtualMachine);
    procedure __MinuteOfTheMonth(AMachine: TatVirtualMachine);
    procedure __SecondOfTheMonth(AMachine: TatVirtualMachine);
    procedure __MilliSecondOfTheMonth(AMachine: TatVirtualMachine);
    procedure __DayOfTheWeek(AMachine: TatVirtualMachine);
    procedure __HourOfTheWeek(AMachine: TatVirtualMachine);
    procedure __MinuteOfTheWeek(AMachine: TatVirtualMachine);
    procedure __SecondOfTheWeek(AMachine: TatVirtualMachine);
    procedure __MilliSecondOfTheWeek(AMachine: TatVirtualMachine);
    procedure __HourOfTheDay(AMachine: TatVirtualMachine);
    procedure __MinuteOfTheDay(AMachine: TatVirtualMachine);
    procedure __SecondOfTheDay(AMachine: TatVirtualMachine);
    procedure __MilliSecondOfTheDay(AMachine: TatVirtualMachine);
    procedure __MinuteOfTheHour(AMachine: TatVirtualMachine);
    procedure __SecondOfTheHour(AMachine: TatVirtualMachine);
    procedure __MilliSecondOfTheHour(AMachine: TatVirtualMachine);
    procedure __SecondOfTheMinute(AMachine: TatVirtualMachine);
    procedure __MilliSecondOfTheMinute(AMachine: TatVirtualMachine);
    procedure __MilliSecondOfTheSecond(AMachine: TatVirtualMachine);
    procedure __WithinPastYears(AMachine: TatVirtualMachine);
    procedure __WithinPastMonths(AMachine: TatVirtualMachine);
    procedure __WithinPastWeeks(AMachine: TatVirtualMachine);
    procedure __WithinPastDays(AMachine: TatVirtualMachine);
    procedure __WithinPastHours(AMachine: TatVirtualMachine);
    procedure __WithinPastMinutes(AMachine: TatVirtualMachine);
    procedure __WithinPastSeconds(AMachine: TatVirtualMachine);
    procedure __WithinPastMilliSeconds(AMachine: TatVirtualMachine);
    procedure __YearsBetween(AMachine: TatVirtualMachine);
    procedure __MonthsBetween(AMachine: TatVirtualMachine);
    procedure __WeeksBetween(AMachine: TatVirtualMachine);
    procedure __DaysBetween(AMachine: TatVirtualMachine);
    procedure __HoursBetween(AMachine: TatVirtualMachine);
    procedure __MinutesBetween(AMachine: TatVirtualMachine);
    procedure __SecondsBetween(AMachine: TatVirtualMachine);
    procedure __MilliSecondsBetween(AMachine: TatVirtualMachine);
    procedure __YearSpan(AMachine: TatVirtualMachine);
    procedure __MonthSpan(AMachine: TatVirtualMachine);
    procedure __WeekSpan(AMachine: TatVirtualMachine);
    procedure __DaySpan(AMachine: TatVirtualMachine);
    procedure __HourSpan(AMachine: TatVirtualMachine);
    procedure __MinuteSpan(AMachine: TatVirtualMachine);
    procedure __SecondSpan(AMachine: TatVirtualMachine);
    procedure __MilliSecondSpan(AMachine: TatVirtualMachine);
    procedure __IncYear(AMachine: TatVirtualMachine);
    procedure __IncWeek(AMachine: TatVirtualMachine);
    procedure __IncDay(AMachine: TatVirtualMachine);
    procedure __IncHour(AMachine: TatVirtualMachine);
    procedure __IncMinute(AMachine: TatVirtualMachine);
    procedure __IncSecond(AMachine: TatVirtualMachine);
    procedure __IncMilliSecond(AMachine: TatVirtualMachine);
    procedure __EncodeDateTime(AMachine: TatVirtualMachine);
    procedure __DecodeDateTime(AMachine: TatVirtualMachine);
    procedure __EncodeDateWeek(AMachine: TatVirtualMachine);
    procedure __DecodeDateWeek(AMachine: TatVirtualMachine);
    procedure __EncodeDateDay(AMachine: TatVirtualMachine);
    procedure __DecodeDateDay(AMachine: TatVirtualMachine);
    procedure __EncodeDateMonthWeek(AMachine: TatVirtualMachine);
    procedure __DecodeDateMonthWeek(AMachine: TatVirtualMachine);
    procedure __TryEncodeDateTime(AMachine: TatVirtualMachine);
    procedure __TryEncodeDateWeek(AMachine: TatVirtualMachine);
    procedure __TryEncodeDateDay(AMachine: TatVirtualMachine);
    procedure __TryEncodeDateMonthWeek(AMachine: TatVirtualMachine);
    procedure __RecodeYear(AMachine: TatVirtualMachine);
    procedure __RecodeMonth(AMachine: TatVirtualMachine);
    procedure __RecodeDay(AMachine: TatVirtualMachine);
    procedure __RecodeHour(AMachine: TatVirtualMachine);
    procedure __RecodeMinute(AMachine: TatVirtualMachine);
    procedure __RecodeSecond(AMachine: TatVirtualMachine);
    procedure __RecodeMilliSecond(AMachine: TatVirtualMachine);
    procedure __RecodeDate(AMachine: TatVirtualMachine);
    procedure __RecodeTime(AMachine: TatVirtualMachine);
    procedure __RecodeDateTime(AMachine: TatVirtualMachine);
    procedure __TryRecodeDateTime(AMachine: TatVirtualMachine);
    procedure __CompareDateTime(AMachine: TatVirtualMachine);
    procedure __SameDateTime(AMachine: TatVirtualMachine);
    procedure __CompareDate(AMachine: TatVirtualMachine);
    procedure __SameDate(AMachine: TatVirtualMachine);
    procedure __CompareTime(AMachine: TatVirtualMachine);
    procedure __SameTime(AMachine: TatVirtualMachine);
    procedure __NthDayOfWeek(AMachine: TatVirtualMachine);
    procedure __DecodeDayOfWeekInMonth(AMachine: TatVirtualMachine);
    procedure __EncodeDayOfWeekInMonth(AMachine: TatVirtualMachine);
    procedure __TryEncodeDayOfWeekInMonth(AMachine: TatVirtualMachine);
    procedure __InvalidDateTimeError(AMachine: TatVirtualMachine);
    procedure __InvalidDateWeekError(AMachine: TatVirtualMachine);
    procedure __InvalidDateDayError(AMachine: TatVirtualMachine);
    procedure __InvalidDateMonthWeekError(AMachine: TatVirtualMachine);
    procedure __InvalidDayOfWeekInMonthError(AMachine: TatVirtualMachine);
    procedure __DateTimeToJulianDate(AMachine: TatVirtualMachine);
    procedure __JulianDateToDateTime(AMachine: TatVirtualMachine);
    procedure __TryJulianDateToDateTime(AMachine: TatVirtualMachine);
    procedure __DateTimeToModifiedJulianDate(AMachine: TatVirtualMachine);
    procedure __ModifiedJulianDateToDateTime(AMachine: TatVirtualMachine);
    procedure __TryModifiedJulianDateToDateTime(AMachine: TatVirtualMachine);
    procedure __DateTimeToUnix(AMachine: TatVirtualMachine);
    procedure __UnixToDateTime(AMachine: TatVirtualMachine);
    procedure __GetApproxDaysPerMonth(AMachine: TatVirtualMachine);
    procedure __SetApproxDaysPerMonth(AMachine: TatVirtualMachine);
    procedure __GetApproxDaysPerYear(AMachine: TatVirtualMachine);
    procedure __SetApproxDaysPerYear(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatDateUtilsLibrary.__DateOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.DateOf(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__TimeOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.TimeOf(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__IsInLeapYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.IsInLeapYear(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__IsPM(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.IsPM(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__IsValidDate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.IsValidDate(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__IsValidTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.IsValidTime(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__IsValidDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.IsValidDateTime(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),VarToInteger(GetInputArg(6)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__IsValidDateDay(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.IsValidDateDay(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__IsValidDateWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.IsValidDateWeek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__IsValidDateMonthWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.IsValidDateMonthWeek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__WeeksInYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.WeeksInYear(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__WeeksInAYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.WeeksInAYear(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__DaysInYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.DaysInYear(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__DaysInAYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.DaysInAYear(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__DaysInMonth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.DaysInMonth(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__DaysInAMonth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.DaysInAMonth(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__Today(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.Today;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__Yesterday(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.Yesterday;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__Tomorrow(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.Tomorrow;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__IsToday(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.IsToday(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__IsSameDay(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.IsSameDay(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__YearOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.YearOf(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MonthOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MonthOf(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__WeekOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.WeekOf(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__DayOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.DayOf(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__HourOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.HourOf(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MinuteOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MinuteOf(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__SecondOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.SecondOf(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MilliSecondOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MilliSecondOf(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__StartOfTheYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.StartOfTheYear(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__EndOfTheYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.EndOfTheYear(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__StartOfAYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.StartOfAYear(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__EndOfAYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.EndOfAYear(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__StartOfTheMonth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.StartOfTheMonth(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__EndOfTheMonth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.EndOfTheMonth(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__StartOfAMonth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.StartOfAMonth(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__EndOfAMonth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.EndOfAMonth(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__StartOfTheWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.StartOfTheWeek(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__EndOfTheWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.EndOfTheWeek(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__StartOfAWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
2: AResult := DateUtils.StartOfAWeek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
3: AResult := DateUtils.StartOfAWeek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__EndOfAWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
2: AResult := DateUtils.EndOfAWeek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
3: AResult := DateUtils.EndOfAWeek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__StartOfTheDay(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.StartOfTheDay(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__EndOfTheDay(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.EndOfTheDay(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__StartOfADay(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.StartOfADay(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__EndOfADay(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.EndOfADay(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MonthOfTheYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MonthOfTheYear(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__WeekOfTheYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.WeekOfTheYear(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__DayOfTheYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.DayOfTheYear(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__HourOfTheYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.HourOfTheYear(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MinuteOfTheYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MinuteOfTheYear(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__SecondOfTheYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.SecondOfTheYear(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MilliSecondOfTheYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MilliSecondOfTheYear(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__WeekOfTheMonth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.WeekOfTheMonth(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__DayOfTheMonth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.DayOfTheMonth(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__HourOfTheMonth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.HourOfTheMonth(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MinuteOfTheMonth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MinuteOfTheMonth(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__SecondOfTheMonth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.SecondOfTheMonth(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MilliSecondOfTheMonth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MilliSecondOfTheMonth(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__DayOfTheWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.DayOfTheWeek(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__HourOfTheWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.HourOfTheWeek(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MinuteOfTheWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MinuteOfTheWeek(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__SecondOfTheWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.SecondOfTheWeek(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MilliSecondOfTheWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MilliSecondOfTheWeek(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__HourOfTheDay(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.HourOfTheDay(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MinuteOfTheDay(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MinuteOfTheDay(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__SecondOfTheDay(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.SecondOfTheDay(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MilliSecondOfTheDay(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MilliSecondOfTheDay(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MinuteOfTheHour(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MinuteOfTheHour(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__SecondOfTheHour(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.SecondOfTheHour(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MilliSecondOfTheHour(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MilliSecondOfTheHour(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__SecondOfTheMinute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.SecondOfTheMinute(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MilliSecondOfTheMinute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MilliSecondOfTheMinute(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MilliSecondOfTheSecond(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MilliSecondOfTheSecond(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__WithinPastYears(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.WithinPastYears(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__WithinPastMonths(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.WithinPastMonths(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__WithinPastWeeks(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.WithinPastWeeks(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__WithinPastDays(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.WithinPastDays(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__WithinPastHours(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.WithinPastHours(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__WithinPastMinutes(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.WithinPastMinutes(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__WithinPastSeconds(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.WithinPastSeconds(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__WithinPastMilliSeconds(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.WithinPastMilliSeconds(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__YearsBetween(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.YearsBetween(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MonthsBetween(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MonthsBetween(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__WeeksBetween(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.WeeksBetween(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__DaysBetween(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.DaysBetween(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__HoursBetween(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.HoursBetween(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MinutesBetween(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MinutesBetween(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__SecondsBetween(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.SecondsBetween(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MilliSecondsBetween(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.MilliSecondsBetween(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__YearSpan(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.YearSpan(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MonthSpan(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.MonthSpan(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__WeekSpan(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.WeekSpan(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__DaySpan(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.DaySpan(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__HourSpan(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.HourSpan(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MinuteSpan(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.MinuteSpan(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__SecondSpan(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.SecondSpan(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__MilliSecondSpan(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.MilliSecondSpan(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__IncYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := DateUtils.IncYear(GetInputArg(0));
2: AResult := DateUtils.IncYear(GetInputArg(0),VarToInteger(GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__IncWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := DateUtils.IncWeek(GetInputArg(0));
2: AResult := DateUtils.IncWeek(GetInputArg(0),VarToInteger(GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__IncDay(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := DateUtils.IncDay(GetInputArg(0));
2: AResult := DateUtils.IncDay(GetInputArg(0),VarToInteger(GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__IncHour(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := DateUtils.IncHour(GetInputArg(0));
2: AResult := DateUtils.IncHour(GetInputArg(0),VarToInteger(GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__IncMinute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := DateUtils.IncMinute(GetInputArg(0));
2: AResult := DateUtils.IncMinute(GetInputArg(0),VarToInteger(GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__IncSecond(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := DateUtils.IncSecond(GetInputArg(0));
2: AResult := DateUtils.IncSecond(GetInputArg(0),VarToInteger(GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__IncMilliSecond(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := DateUtils.IncMilliSecond(GetInputArg(0));
2: AResult := DateUtils.IncMilliSecond(GetInputArg(0),VarToInteger(GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__EncodeDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.EncodeDateTime(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),VarToInteger(GetInputArg(6)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__DecodeDateTime(AMachine: TatVirtualMachine);
  var
  Param1: Word;
  Param2: Word;
  Param3: Word;
  Param4: Word;
  Param5: Word;
  Param6: Word;
  Param7: Word;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
Param4 := VarToInteger(GetInputArg(4));
Param5 := VarToInteger(GetInputArg(5));
Param6 := VarToInteger(GetInputArg(6));
Param7 := VarToInteger(GetInputArg(7));
    DateUtils.DecodeDateTime(GetInputArg(0),Param1,Param2,Param3,Param4,Param5,Param6,Param7);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
    SetInputArg(4,Integer(Param4));
    SetInputArg(5,Integer(Param5));
    SetInputArg(6,Integer(Param6));
    SetInputArg(7,Integer(Param7));
  end;
end;

procedure TatDateUtilsLibrary.__EncodeDateWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
2: AResult := DateUtils.EncodeDateWeek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
3: AResult := DateUtils.EncodeDateWeek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__DecodeDateWeek(AMachine: TatVirtualMachine);
  var
  Param1: Word;
  Param2: Word;
  Param3: Word;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
    DateUtils.DecodeDateWeek(GetInputArg(0),Param1,Param2,Param3);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatDateUtilsLibrary.__EncodeDateDay(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.EncodeDateDay(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__DecodeDateDay(AMachine: TatVirtualMachine);
  var
  Param1: Word;
  Param2: Word;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
    DateUtils.DecodeDateDay(GetInputArg(0),Param1,Param2);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatDateUtilsLibrary.__EncodeDateMonthWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.EncodeDateMonthWeek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__DecodeDateMonthWeek(AMachine: TatVirtualMachine);
  var
  Param1: Word;
  Param2: Word;
  Param3: Word;
  Param4: Word;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
Param4 := VarToInteger(GetInputArg(4));
    DateUtils.DecodeDateMonthWeek(GetInputArg(0),Param1,Param2,Param3,Param4);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatDateUtilsLibrary.__TryEncodeDateTime(AMachine: TatVirtualMachine);
  var
  Param7: TDateTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param7 := GetInputArg(7);
AResult := DateUtils.TryEncodeDateTime(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),VarToInteger(GetInputArg(6)),Param7);
    ReturnOutputArg(AResult);
    SetInputArg(7,Param7);
  end;
end;

procedure TatDateUtilsLibrary.__TryEncodeDateWeek(AMachine: TatVirtualMachine);
  var
  Param2: TDateTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
case InputArgCount of
3: AResult := DateUtils.TryEncodeDateWeek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
4: AResult := DateUtils.TryEncodeDateWeek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2,VarToInteger(GetInputArg(3)));
end;
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatDateUtilsLibrary.__TryEncodeDateDay(AMachine: TatVirtualMachine);
  var
  Param2: TDateTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := DateUtils.TryEncodeDateDay(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatDateUtilsLibrary.__TryEncodeDateMonthWeek(AMachine: TatVirtualMachine);
  var
  Param4: TDateTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := GetInputArg(4);
AResult := DateUtils.TryEncodeDateMonthWeek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),Param4);
    ReturnOutputArg(AResult);
    SetInputArg(4,Param4);
  end;
end;

procedure TatDateUtilsLibrary.__RecodeYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.RecodeYear(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__RecodeMonth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.RecodeMonth(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__RecodeDay(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.RecodeDay(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__RecodeHour(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.RecodeHour(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__RecodeMinute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.RecodeMinute(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__RecodeSecond(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.RecodeSecond(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__RecodeMilliSecond(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.RecodeMilliSecond(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__RecodeDate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.RecodeDate(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__RecodeTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.RecodeTime(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__RecodeDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.RecodeDateTime(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),VarToInteger(GetInputArg(6)),VarToInteger(GetInputArg(7)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__TryRecodeDateTime(AMachine: TatVirtualMachine);
  var
  Param8: TDateTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param8 := GetInputArg(8);
AResult := DateUtils.TryRecodeDateTime(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),VarToInteger(GetInputArg(6)),VarToInteger(GetInputArg(7)),Param8);
    ReturnOutputArg(AResult);
    SetInputArg(8,Param8);
  end;
end;

procedure TatDateUtilsLibrary.__CompareDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.CompareDateTime(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__SameDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.SameDateTime(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__CompareDate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.CompareDate(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__SameDate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.SameDate(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__CompareTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.CompareTime(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__SameTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.SameTime(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__NthDayOfWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.NthDayOfWeek(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__DecodeDayOfWeekInMonth(AMachine: TatVirtualMachine);
  var
  Param1: Word;
  Param2: Word;
  Param3: Word;
  Param4: Word;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
Param4 := VarToInteger(GetInputArg(4));
    DateUtils.DecodeDayOfWeekInMonth(GetInputArg(0),Param1,Param2,Param3,Param4);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatDateUtilsLibrary.__EncodeDayOfWeekInMonth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.EncodeDayOfWeekInMonth(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__TryEncodeDayOfWeekInMonth(AMachine: TatVirtualMachine);
  var
  Param4: TDateTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := GetInputArg(4);
AResult := DateUtils.TryEncodeDayOfWeekInMonth(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),Param4);
    ReturnOutputArg(AResult);
    SetInputArg(4,Param4);
  end;
end;

procedure TatDateUtilsLibrary.__InvalidDateTimeError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      7: DateUtils.InvalidDateTimeError(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),VarToInteger(GetInputArg(6)));
      8: DateUtils.InvalidDateTimeError(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),VarToInteger(GetInputArg(6)),GetInputArg(7));
    end;
  end;
end;

procedure TatDateUtilsLibrary.__InvalidDateWeekError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DateUtils.InvalidDateWeekError(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatDateUtilsLibrary.__InvalidDateDayError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DateUtils.InvalidDateDayError(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatDateUtilsLibrary.__InvalidDateMonthWeekError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DateUtils.InvalidDateMonthWeekError(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatDateUtilsLibrary.__InvalidDayOfWeekInMonthError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DateUtils.InvalidDayOfWeekInMonthError(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatDateUtilsLibrary.__DateTimeToJulianDate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.DateTimeToJulianDate(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__JulianDateToDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.JulianDateToDateTime(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__TryJulianDateToDateTime(AMachine: TatVirtualMachine);
  var
  Param1: TDateTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := DateUtils.TryJulianDateToDateTime(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatDateUtilsLibrary.__DateTimeToModifiedJulianDate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.DateTimeToModifiedJulianDate(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__ModifiedJulianDateToDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.ModifiedJulianDateToDateTime(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__TryModifiedJulianDateToDateTime(AMachine: TatVirtualMachine);
  var
  Param1: TDateTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := DateUtils.TryModifiedJulianDateToDateTime(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatDateUtilsLibrary.__DateTimeToUnix(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DateUtils.DateTimeToUnix(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__UnixToDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DateUtils.UnixToDateTime(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDateUtilsLibrary.__GetApproxDaysPerMonth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(DateUtils.ApproxDaysPerMonth);
  end;
end;

procedure TatDateUtilsLibrary.__SetApproxDaysPerMonth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DateUtils.ApproxDaysPerMonth:=GetInputArg(0);
  end;
end;

procedure TatDateUtilsLibrary.__GetApproxDaysPerYear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(DateUtils.ApproxDaysPerYear);
  end;
end;

procedure TatDateUtilsLibrary.__SetApproxDaysPerYear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DateUtils.ApproxDaysPerYear:=GetInputArg(0);
  end;
end;

procedure TatDateUtilsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('DateOf',1,tkVariant,nil,__DateOf,false,0);
    DefineMethod('TimeOf',1,tkVariant,nil,__TimeOf,false,0);
    DefineMethod('IsInLeapYear',1,tkVariant,nil,__IsInLeapYear,false,0);
    DefineMethod('IsPM',1,tkVariant,nil,__IsPM,false,0);
    DefineMethod('IsValidDate',3,tkVariant,nil,__IsValidDate,false,0);
    DefineMethod('IsValidTime',4,tkVariant,nil,__IsValidTime,false,0);
    DefineMethod('IsValidDateTime',7,tkVariant,nil,__IsValidDateTime,false,0);
    DefineMethod('IsValidDateDay',2,tkVariant,nil,__IsValidDateDay,false,0);
    DefineMethod('IsValidDateWeek',3,tkVariant,nil,__IsValidDateWeek,false,0);
    DefineMethod('IsValidDateMonthWeek',4,tkVariant,nil,__IsValidDateMonthWeek,false,0);
    DefineMethod('WeeksInYear',1,tkInteger,nil,__WeeksInYear,false,0);
    DefineMethod('WeeksInAYear',1,tkInteger,nil,__WeeksInAYear,false,0);
    DefineMethod('DaysInYear',1,tkInteger,nil,__DaysInYear,false,0);
    DefineMethod('DaysInAYear',1,tkInteger,nil,__DaysInAYear,false,0);
    DefineMethod('DaysInMonth',1,tkInteger,nil,__DaysInMonth,false,0);
    DefineMethod('DaysInAMonth',2,tkInteger,nil,__DaysInAMonth,false,0);
    DefineMethod('Today',0,tkVariant,nil,__Today,false,0);
    DefineMethod('Yesterday',0,tkVariant,nil,__Yesterday,false,0);
    DefineMethod('Tomorrow',0,tkVariant,nil,__Tomorrow,false,0);
    DefineMethod('IsToday',1,tkVariant,nil,__IsToday,false,0);
    DefineMethod('IsSameDay',2,tkVariant,nil,__IsSameDay,false,0);
    DefineMethod('YearOf',1,tkInteger,nil,__YearOf,false,0);
    DefineMethod('MonthOf',1,tkInteger,nil,__MonthOf,false,0);
    DefineMethod('WeekOf',1,tkInteger,nil,__WeekOf,false,0);
    DefineMethod('DayOf',1,tkInteger,nil,__DayOf,false,0);
    DefineMethod('HourOf',1,tkInteger,nil,__HourOf,false,0);
    DefineMethod('MinuteOf',1,tkInteger,nil,__MinuteOf,false,0);
    DefineMethod('SecondOf',1,tkInteger,nil,__SecondOf,false,0);
    DefineMethod('MilliSecondOf',1,tkInteger,nil,__MilliSecondOf,false,0);
    DefineMethod('StartOfTheYear',1,tkVariant,nil,__StartOfTheYear,false,0);
    DefineMethod('EndOfTheYear',1,tkVariant,nil,__EndOfTheYear,false,0);
    DefineMethod('StartOfAYear',1,tkVariant,nil,__StartOfAYear,false,0);
    DefineMethod('EndOfAYear',1,tkVariant,nil,__EndOfAYear,false,0);
    DefineMethod('StartOfTheMonth',1,tkVariant,nil,__StartOfTheMonth,false,0);
    DefineMethod('EndOfTheMonth',1,tkVariant,nil,__EndOfTheMonth,false,0);
    DefineMethod('StartOfAMonth',2,tkVariant,nil,__StartOfAMonth,false,0);
    DefineMethod('EndOfAMonth',2,tkVariant,nil,__EndOfAMonth,false,0);
    DefineMethod('StartOfTheWeek',1,tkVariant,nil,__StartOfTheWeek,false,0);
    DefineMethod('EndOfTheWeek',1,tkVariant,nil,__EndOfTheWeek,false,0);
    DefineMethod('StartOfAWeek',3,tkVariant,nil,__StartOfAWeek,false,1);
    DefineMethod('EndOfAWeek',3,tkVariant,nil,__EndOfAWeek,false,1);
    DefineMethod('StartOfTheDay',1,tkVariant,nil,__StartOfTheDay,false,0);
    DefineMethod('EndOfTheDay',1,tkVariant,nil,__EndOfTheDay,false,0);
    DefineMethod('StartOfADay',3,tkVariant,nil,__StartOfADay,false,0);
    DefineMethod('EndOfADay',3,tkVariant,nil,__EndOfADay,false,0);
    DefineMethod('MonthOfTheYear',1,tkInteger,nil,__MonthOfTheYear,false,0);
    DefineMethod('WeekOfTheYear',1,tkInteger,nil,__WeekOfTheYear,false,0);
    DefineMethod('DayOfTheYear',1,tkInteger,nil,__DayOfTheYear,false,0);
    DefineMethod('HourOfTheYear',1,tkInteger,nil,__HourOfTheYear,false,0);
    DefineMethod('MinuteOfTheYear',1,tkInteger,nil,__MinuteOfTheYear,false,0);
    DefineMethod('SecondOfTheYear',1,tkInteger,nil,__SecondOfTheYear,false,0);
    DefineMethod('MilliSecondOfTheYear',1,tkVariant,nil,__MilliSecondOfTheYear,false,0);
    DefineMethod('WeekOfTheMonth',1,tkInteger,nil,__WeekOfTheMonth,false,0);
    DefineMethod('DayOfTheMonth',1,tkInteger,nil,__DayOfTheMonth,false,0);
    DefineMethod('HourOfTheMonth',1,tkInteger,nil,__HourOfTheMonth,false,0);
    DefineMethod('MinuteOfTheMonth',1,tkInteger,nil,__MinuteOfTheMonth,false,0);
    DefineMethod('SecondOfTheMonth',1,tkInteger,nil,__SecondOfTheMonth,false,0);
    DefineMethod('MilliSecondOfTheMonth',1,tkInteger,nil,__MilliSecondOfTheMonth,false,0);
    DefineMethod('DayOfTheWeek',1,tkInteger,nil,__DayOfTheWeek,false,0);
    DefineMethod('HourOfTheWeek',1,tkInteger,nil,__HourOfTheWeek,false,0);
    DefineMethod('MinuteOfTheWeek',1,tkInteger,nil,__MinuteOfTheWeek,false,0);
    DefineMethod('SecondOfTheWeek',1,tkInteger,nil,__SecondOfTheWeek,false,0);
    DefineMethod('MilliSecondOfTheWeek',1,tkInteger,nil,__MilliSecondOfTheWeek,false,0);
    DefineMethod('HourOfTheDay',1,tkInteger,nil,__HourOfTheDay,false,0);
    DefineMethod('MinuteOfTheDay',1,tkInteger,nil,__MinuteOfTheDay,false,0);
    DefineMethod('SecondOfTheDay',1,tkInteger,nil,__SecondOfTheDay,false,0);
    DefineMethod('MilliSecondOfTheDay',1,tkInteger,nil,__MilliSecondOfTheDay,false,0);
    DefineMethod('MinuteOfTheHour',1,tkInteger,nil,__MinuteOfTheHour,false,0);
    DefineMethod('SecondOfTheHour',1,tkInteger,nil,__SecondOfTheHour,false,0);
    DefineMethod('MilliSecondOfTheHour',1,tkInteger,nil,__MilliSecondOfTheHour,false,0);
    DefineMethod('SecondOfTheMinute',1,tkInteger,nil,__SecondOfTheMinute,false,0);
    DefineMethod('MilliSecondOfTheMinute',1,tkInteger,nil,__MilliSecondOfTheMinute,false,0);
    DefineMethod('MilliSecondOfTheSecond',1,tkInteger,nil,__MilliSecondOfTheSecond,false,0);
    DefineMethod('WithinPastYears',3,tkVariant,nil,__WithinPastYears,false,0);
    DefineMethod('WithinPastMonths',3,tkVariant,nil,__WithinPastMonths,false,0);
    DefineMethod('WithinPastWeeks',3,tkVariant,nil,__WithinPastWeeks,false,0);
    DefineMethod('WithinPastDays',3,tkVariant,nil,__WithinPastDays,false,0);
    DefineMethod('WithinPastHours',3,tkVariant,nil,__WithinPastHours,false,0);
    DefineMethod('WithinPastMinutes',3,tkVariant,nil,__WithinPastMinutes,false,0);
    DefineMethod('WithinPastSeconds',3,tkVariant,nil,__WithinPastSeconds,false,0);
    DefineMethod('WithinPastMilliSeconds',3,tkVariant,nil,__WithinPastMilliSeconds,false,0);
    DefineMethod('YearsBetween',2,tkInteger,nil,__YearsBetween,false,0);
    DefineMethod('MonthsBetween',2,tkInteger,nil,__MonthsBetween,false,0);
    DefineMethod('WeeksBetween',2,tkInteger,nil,__WeeksBetween,false,0);
    DefineMethod('DaysBetween',2,tkInteger,nil,__DaysBetween,false,0);
    DefineMethod('HoursBetween',2,tkVariant,nil,__HoursBetween,false,0);
    DefineMethod('MinutesBetween',2,tkVariant,nil,__MinutesBetween,false,0);
    DefineMethod('SecondsBetween',2,tkVariant,nil,__SecondsBetween,false,0);
    DefineMethod('MilliSecondsBetween',2,tkVariant,nil,__MilliSecondsBetween,false,0);
    DefineMethod('YearSpan',2,tkVariant,nil,__YearSpan,false,0);
    DefineMethod('MonthSpan',2,tkVariant,nil,__MonthSpan,false,0);
    DefineMethod('WeekSpan',2,tkVariant,nil,__WeekSpan,false,0);
    DefineMethod('DaySpan',2,tkVariant,nil,__DaySpan,false,0);
    DefineMethod('HourSpan',2,tkVariant,nil,__HourSpan,false,0);
    DefineMethod('MinuteSpan',2,tkVariant,nil,__MinuteSpan,false,0);
    DefineMethod('SecondSpan',2,tkVariant,nil,__SecondSpan,false,0);
    DefineMethod('MilliSecondSpan',2,tkVariant,nil,__MilliSecondSpan,false,0);
    DefineMethod('IncYear',2,tkVariant,nil,__IncYear,false,1);
    DefineMethod('IncWeek',2,tkVariant,nil,__IncWeek,false,1);
    DefineMethod('IncDay',2,tkVariant,nil,__IncDay,false,1);
    DefineMethod('IncHour',2,tkVariant,nil,__IncHour,false,1);
    DefineMethod('IncMinute',2,tkVariant,nil,__IncMinute,false,1);
    DefineMethod('IncSecond',2,tkVariant,nil,__IncSecond,false,1);
    DefineMethod('IncMilliSecond',2,tkVariant,nil,__IncMilliSecond,false,1);
    DefineMethod('EncodeDateTime',7,tkVariant,nil,__EncodeDateTime,false,0);
    DefineMethod('DecodeDateTime',8,tkNone,nil,__DecodeDateTime,false,0).SetVarArgs([1,2,3,4,5,6,7]);
    DefineMethod('EncodeDateWeek',3,tkVariant,nil,__EncodeDateWeek,false,1);
    DefineMethod('DecodeDateWeek',4,tkNone,nil,__DecodeDateWeek,false,0).SetVarArgs([1,2,3]);
    DefineMethod('EncodeDateDay',2,tkVariant,nil,__EncodeDateDay,false,0);
    DefineMethod('DecodeDateDay',3,tkNone,nil,__DecodeDateDay,false,0).SetVarArgs([1,2]);
    DefineMethod('EncodeDateMonthWeek',4,tkVariant,nil,__EncodeDateMonthWeek,false,0);
    DefineMethod('DecodeDateMonthWeek',5,tkNone,nil,__DecodeDateMonthWeek,false,0).SetVarArgs([1,2,3,4]);
    DefineMethod('TryEncodeDateTime',8,tkVariant,nil,__TryEncodeDateTime,false,0).SetVarArgs([7]);
    DefineMethod('TryEncodeDateWeek',4,tkVariant,nil,__TryEncodeDateWeek,false,1).SetVarArgs([2]);
    DefineMethod('TryEncodeDateDay',3,tkVariant,nil,__TryEncodeDateDay,false,0).SetVarArgs([2]);
    DefineMethod('TryEncodeDateMonthWeek',5,tkVariant,nil,__TryEncodeDateMonthWeek,false,0).SetVarArgs([4]);
    DefineMethod('RecodeYear',2,tkVariant,nil,__RecodeYear,false,0);
    DefineMethod('RecodeMonth',2,tkVariant,nil,__RecodeMonth,false,0);
    DefineMethod('RecodeDay',2,tkVariant,nil,__RecodeDay,false,0);
    DefineMethod('RecodeHour',2,tkVariant,nil,__RecodeHour,false,0);
    DefineMethod('RecodeMinute',2,tkVariant,nil,__RecodeMinute,false,0);
    DefineMethod('RecodeSecond',2,tkVariant,nil,__RecodeSecond,false,0);
    DefineMethod('RecodeMilliSecond',2,tkVariant,nil,__RecodeMilliSecond,false,0);
    DefineMethod('RecodeDate',4,tkVariant,nil,__RecodeDate,false,0);
    DefineMethod('RecodeTime',5,tkVariant,nil,__RecodeTime,false,0);
    DefineMethod('RecodeDateTime',8,tkVariant,nil,__RecodeDateTime,false,0);
    DefineMethod('TryRecodeDateTime',9,tkVariant,nil,__TryRecodeDateTime,false,0).SetVarArgs([8]);
    DefineMethod('CompareDateTime',2,tkEnumeration,nil,__CompareDateTime,false,0);
    DefineMethod('SameDateTime',2,tkVariant,nil,__SameDateTime,false,0);
    DefineMethod('CompareDate',2,tkEnumeration,nil,__CompareDate,false,0);
    DefineMethod('SameDate',2,tkVariant,nil,__SameDate,false,0);
    DefineMethod('CompareTime',2,tkEnumeration,nil,__CompareTime,false,0);
    DefineMethod('SameTime',2,tkVariant,nil,__SameTime,false,0);
    DefineMethod('NthDayOfWeek',1,tkInteger,nil,__NthDayOfWeek,false,0);
    DefineMethod('DecodeDayOfWeekInMonth',5,tkNone,nil,__DecodeDayOfWeekInMonth,false,0).SetVarArgs([1,2,3,4]);
    DefineMethod('EncodeDayOfWeekInMonth',4,tkVariant,nil,__EncodeDayOfWeekInMonth,false,0);
    DefineMethod('TryEncodeDayOfWeekInMonth',5,tkVariant,nil,__TryEncodeDayOfWeekInMonth,false,0).SetVarArgs([4]);
    DefineMethod('InvalidDateTimeError',8,tkNone,nil,__InvalidDateTimeError,false,1);
    DefineMethod('InvalidDateWeekError',3,tkNone,nil,__InvalidDateWeekError,false,0);
    DefineMethod('InvalidDateDayError',2,tkNone,nil,__InvalidDateDayError,false,0);
    DefineMethod('InvalidDateMonthWeekError',4,tkNone,nil,__InvalidDateMonthWeekError,false,0);
    DefineMethod('InvalidDayOfWeekInMonthError',4,tkNone,nil,__InvalidDayOfWeekInMonthError,false,0);
    DefineMethod('DateTimeToJulianDate',1,tkVariant,nil,__DateTimeToJulianDate,false,0);
    DefineMethod('JulianDateToDateTime',1,tkVariant,nil,__JulianDateToDateTime,false,0);
    DefineMethod('TryJulianDateToDateTime',2,tkVariant,nil,__TryJulianDateToDateTime,false,0).SetVarArgs([1]);
    DefineMethod('DateTimeToModifiedJulianDate',1,tkVariant,nil,__DateTimeToModifiedJulianDate,false,0);
    DefineMethod('ModifiedJulianDateToDateTime',1,tkVariant,nil,__ModifiedJulianDateToDateTime,false,0);
    DefineMethod('TryModifiedJulianDateToDateTime',2,tkVariant,nil,__TryModifiedJulianDateToDateTime,false,0).SetVarArgs([1]);
    DefineMethod('DateTimeToUnix',1,tkVariant,nil,__DateTimeToUnix,false,0);
    DefineMethod('UnixToDateTime',1,tkVariant,nil,__UnixToDateTime,false,0);
    DefineProp('ApproxDaysPerMonth',tkVariant,__GetApproxDaysPerMonth,__SetApproxDaysPerMonth,nil,false,0);
    DefineProp('ApproxDaysPerYear',tkVariant,__GetApproxDaysPerYear,__SetApproxDaysPerYear,nil,false,0);
    AddConstant('DaysPerWeek',DaysPerWeek);
    AddConstant('WeeksPerFortnight',WeeksPerFortnight);
    AddConstant('MonthsPerYear',MonthsPerYear);
    AddConstant('YearsPerDecade',YearsPerDecade);
    AddConstant('YearsPerCentury',YearsPerCentury);
    AddConstant('YearsPerMillennium',YearsPerMillennium);
    AddConstant('DayMonday',DayMonday);
    AddConstant('DayTuesday',DayTuesday);
    AddConstant('DayWednesday',DayWednesday);
    AddConstant('DayThursday',DayThursday);
    AddConstant('DayFriday',DayFriday);
    AddConstant('DaySaturday',DaySaturday);
    AddConstant('DaySunday',DaySunday);
    AddConstant('OneHour',OneHour);
    AddConstant('OneMinute',OneMinute);
    AddConstant('OneSecond',OneSecond);
    AddConstant('OneMillisecond',OneMillisecond);
    AddConstant('RecodeLeaveFieldAsIs',RecodeLeaveFieldAsIs);
  end;
end;

class function TatDateUtilsLibrary.LibraryName: string;
begin
  result := 'DateUtils';
end;

initialization
  RegisterScripterLibrary(TatDateUtilsLibrary, True);

{$WARNINGS ON}

end.

