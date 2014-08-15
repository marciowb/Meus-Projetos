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

unit cxSchedulerUtils;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Types, DateUtils,
{$ENDIF}
  Classes, Windows, Forms, SysUtils, Registry, Controls, Graphics, ImgList,
  cxGraphics, cxGeometry, cxStyles, cxLookAndFeels, cxLookAndFeelPainters,
  dxOffice11, cxDateUtils, cxSchedulerStrs;

const
  // icons
  rcClockIndex      = 0;
  rcRecurrenceIndex = rcClockIndex + 2;
  rcBellIndex       = rcRecurrenceIndex + 2;

  // date time
  Is24HourTimeFormat: Boolean = True;
  HourToTime   = (MinsPerHour * SecsPerMin * MSecsPerSec) / MSecsPerDay;
  MinuteToTime = (SecsPerMin * MSecsPerSec) / MSecsPerDay;
  SecondToTime = MSecsPerSec / MSecsPerDay;

  cxHalfHour = 30 * MinuteToTime;
  cxTime8AM  = 8 * HourToTime;

  MinsPerWeek = MinsPerDay * DaysPerWeek;

  EventLabelColors: array[0..10] of TColor = (clDefault, $8496FC, $E49E84,
    $64DEA4, $D4E6E4, $74B6FC, $F4EE84, $84CED4, $F4A6C4, $C4CEA4, $74E6FC);

  ComboBoxTimeIntervals: array[1..25] of record P: Pointer; M: Integer end = (
    (P: @scxTime0m;  M: 0),
    (P: @scxTime5m;  M: 5),
    (P: @scxTime10m; M: 10),
    (P: @scxTime15m; M: 15),
    (P: @scxTime20m; M: 20),
    (P: @scxTime30m; M: 30),
    (P: @scxTime1h;  M: MinsPerHour),
    (P: @scxTime2h;  M: 2 * MinsPerHour),
    (P: @scxTime3h;  M: 3 * MinsPerHour),
    (P: @scxTime4h;  M: 4 * MinsPerHour),
    (P: @scxTime5h;  M: 5 * MinsPerHour),
    (P: @scxTime6h;  M: 6 * MinsPerHour),
    (P: @scxTime7h;  M: 7 * MinsPerHour),
    (P: @scxTime8h;  M: 8 * MinsPerHour),
    (P: @scxTime9h;  M: 9 * MinsPerHour),
    (P: @scxTime10h; M: 10 * MinsPerHour),
    (P: @scxTime11h; M: 11 * MinsPerHour),
    (P: @scxTime12h; M: 12 * MinsPerHour),
    (P: @scxTime18h; M: 18 * MinsPerHour),
    (P: @scxTime1d;  M: MinsPerDay),
    (P: @scxTime2d;  M: 2 * MinsPerDay),
    (P: @scxTime3d;  M: 3 * MinsPerDay),
    (P: @scxTime4d;  M: 4 * MinsPerDay),
    (P: @scxTime1w;  M: MinsPerWeek),
    (P: @scxTime2w;  M: 2 * MinsPerWeek)
  );

  sMinutePluralNames: array[Boolean] of Pointer = (@scxSuffixMinute, @scxSuffixMinutes);
  sHourPluralNames: array[Boolean] of Pointer = (@scxSuffixHour, @scxSuffixHours);
  sDayPluralNames: array[Boolean] of Pointer = (@scxSuffixDay, @scxSuffixDays);
  sWeekPluralNames: array[Boolean] of Pointer = (@scxSuffixWeek, @scxSuffixWeeks);

  cxEventImagesGap = 1;
  
type
  TcxStartOfWeek = (swSystem, swSunday, swMonday, swTuesday, swWednesday,
    swThursday, swFriday, swSaturday);

  EcxScheduler = class(Exception);

  TcxDayOfWeek = 0..6;

  { TcxTZIField }

  TcxTZIField = packed record
    Bias: LongInt;
    StandardBias: LongInt;
    DaylightBias: LongInt;
    StandardDate: TSystemTime;
    DaylightDate: TSystemTime;
  end;

  { TcxTimeZoneInformation }

  TcxTimeZoneInformation = record
    Display: Widestring;
    StandardName: Widestring;
    DaylightName: Widestring;
    Index: Integer;
    MapId: string;
    TZI: TcxTZIField;
  end;

  TSchedulerResourceColor = (
    srcMinorNonWorkTimeSeparator, srcMajorNonWorkTimeSeparator,
    srcMinorWorkTimeSeparator, srcMajorWorkTimeSeparator,
    srcNonWorkTime, srcWorkTime);

  TcxSchedulerResourceColors = array[TSchedulerResourceColor] of TColor;

  { TcxSchedulerDateTimeHelper }

  TcxSchedulerDateTimeHelper = class
  protected
    // time zone info
    class function CheckTimeIndex(const AIndex: Integer): Integer;
    class function cxTZInfoToTZInfo(const AInfo: TcxTimeZoneInformation): TTimeZoneInformation;
    class function TZInfoTocxTZInfo(const AInfo: TTimeZoneInformation): TcxTimeZoneInformation;
    class function GetIs24HourTimeFormat: Boolean; virtual;
    class procedure InitTimeZoneInformation;
    class procedure ReadTimeZoneInfoFromRegistry(
      ARegistry: TRegistry; out AInfo: TcxTimeZoneInformation);
    class procedure RefreshDateInformation;
    class procedure RetrieveStartOfWeek;
    // system initialization
    class procedure InitSchedulerDateTimeSystem; virtual;
    class procedure DoneSchedulerDateSystem; virtual;
  public
    // time zone conversion
    class function ConvertToAnotherTimeZone(const ADateTime: TDateTime;
      ATimeZone, ANextTimeZone: Integer): TDateTime;
    class function ConvertToGlobalTime(
      const ADateTime: TDateTime; ATimeZone: Integer = -1): TDateTime; virtual;
    class function ConvertToLocalTime(
      const ADateTime: TDateTime; ATimeZone: Integer = -1): TDateTime; virtual;
    class function CurrentTimeZone: Integer; virtual;
    class function TimeZoneCount: Integer; virtual;
    class function TimeZoneBias(AIndex: Integer): TDateTime; virtual;
    class function TimeZoneInfo(AIndex: Integer): TcxTimeZoneInformation; virtual;

    // datetime to string conversion
    class function DateToLongDateStr(ADate: TDateTime): string; virtual;
    class function DayToStr(const ADate: TDateTime; AFormat: Integer; ACompressed: Boolean): string; virtual;
    class function DayToStrFormatCount: Integer; virtual;
    class function HourToStr(const ATime: TDateTime): string; virtual;
    class function MonthYearToStr(AMonth, AYear: Integer): string; virtual;
    class function TimeToStr(const ATime: TDateTime): string; virtual;

    // get time constant list
    class procedure Refresh; virtual;
    class procedure FillAdvanceStrings(AStrings: TStrings); virtual;

    // system constants
    class function StartOfWeek: Integer; virtual;
    class function WorkDays: TDays; virtual;
    class function WorkFinish: TDateTime; virtual;
    class function WorkStart: TDateTime; virtual;
    class function TimeAMString: string; virtual;
    class function TimePMString: string; virtual;

    // misc. date time routines
    class procedure IncMonth(var AYear, AMonth, ADay: Word; ANumberOfMonths: Integer = 1);
    class function Intersect(const AStart, AFinish, AStart1, AFinish1: TDateTime): Boolean;
    class function IsFreeTime(const ADateTime: TDateTime; AWorkDays: TDays;
      const AWorkStart, AWorkFinish: TDateTime): Boolean;
    class function IsOddMonth(const ADate: TDateTime): Boolean;
    class function IsWeekEnd(const ADate: TDateTime; AWorkDays: TDays): Boolean;
    class function IsWeeksFull(const AStartDate, AEndDate: TDateTime): Boolean;
    class function RoundTime(const ADateTime: TDateTime): TDateTime; virtual;
    class function WeekCount(const AStart, AFinish: TDateTime): Integer;
  end;

  TcxSchedulerDateTimeHelperClass = class of TcxSchedulerDateTimeHelper;

  { TcxSchedulerPainterHelper }

  TcxSchedulerPainterHelper = class
  protected
    class procedure CreateStateBrushes;
    class procedure DrawClockLine(ACanvas: TcxCanvas;
      const ATime, ATimePerCircle, ARadius, XC, YC: Integer);
    class procedure DrawShadowLine(ACanvas: TcxCanvas; ABuffer: TBitmap;
      const ALeft, ATop, ALength: Integer; AVisibleRect: TRect; AIsRight: Boolean); virtual;
    class procedure FreeStateBrushes;
    class function GetColorValue(AColor: TColor; ALightValue: Integer): TColor; virtual;
    class procedure GetShadowValue(var APixel: TRGBTriple; const Alpha: Double); virtual;
    class procedure GetResourceColors(AColor: TColor; out AResourceColors: TcxSchedulerResourceColors); virtual;
    class function GetResourceStream(const AResName: string): TMemoryStream;
    class procedure InitCachedColors(AColor: TColor; out AColors: TcxSchedulerResourceColors); virtual;
    // system initialization
    class procedure InitSchedulerGraphics; virtual;
    class procedure FreeSchedulerGraphics; virtual;
  public
    class procedure DrawClock(ACanvas: TcxCanvas; const ARect: TRect;
      AHour, AMinute: Word; const AViewParams: TcxViewParams); overload;
    class procedure DrawClock(ACanvas: TcxCanvas; const ARect: TRect; ATime: TDateTime;
      const AViewParams: TcxViewParams); overload;
    class procedure DrawGradientRect(ACanvas: TcxCanvas;
      AStartColor: TColor; const ARect: TRect);
    class procedure DrawIcon(ACanvas: TcxCanvas; const R: TRect; AIndex: Integer); overload;
    class procedure DrawIcon(ACanvas: TcxCanvas; const R: TRect; AIndex: Integer;
      const AViewParams: TcxViewParams; AIsTransparent: Boolean); overload;
    class procedure DrawShadow(ACanvas: TcxCanvas;
      const ARect, AVisibleRect: TRect; ABuffer: TBitmap); virtual;
    class procedure DrawState(ACanvas: TcxCanvas; R: TRect;
      AState: Integer; ABorders: TcxBorders = []; ABorderColor: TColor = clBlack);
    class function ExcludeBorders(const ARect: TRect;
      ABorders: TcxBorders; ABorderSize: Integer = 1): TRect;
    class function GetContentColor(AResourceColor: Integer; AIsWorkTime: Boolean): TColor;
    class function GetResourceContentColor(AResourceIndex: Integer): TColor;
    class function GetSeparatorColor(const AResourceColor: Integer;
      AIsHourSeparator, AIsWorkTime: Boolean): TColor;
    class function IconsWidth: Integer;
    class function IconsHeight: Integer;
    class function IncludeBorders(const ARect: TRect;
      ABorders: TcxBorders; ABorderSize: Integer = 1): TRect;
    class procedure InitStyle(AStyle: TcxStyle; const AResName: string;
      AGraphicClass: TGraphicClass);
    class function LoadGraphic(ABitmap: TBitmap; const AResName: string;
      AGraphicClass: TGraphicClass): Boolean;
    class function LoadImages(AWidth, AHeight: Integer; const AResName: string;
      AHasPalette: Boolean = False; AHasTransparent: Boolean = True): TImageList;
    class function MoreButtonHeight: Integer;
    class function MoreButtonWidth: Integer;
    class function ShadowSize: Integer;
    class function TextHeight(AFont: TFont): Integer;
    class function TextWidth(AFont: TFont; const AText: string): Integer;
   end;

  TcxSchedulerPainterHelperClass = class of TcxSchedulerPainterHelper;

  { TcxSchedulerHelpersFactory }

  TcxSchedulerHelpersFactory = class
  protected
    class procedure Done; virtual;
    class procedure Init; virtual;
    class procedure LoadCursors;
  public
    class function PainterHelperClass: TcxSchedulerPainterHelperClass; virtual;
    class function DateTimeHelperClass: TcxSchedulerDateTimeHelperClass; virtual;
  end;

  TcxSchedulerHelpersFactoryClass = class of TcxSchedulerHelpersFactory;

  { TcxSchedulerObjectList }

  TcxSchedulerObjectList = class(TList)
  private
    function GetItem(AIndex: Integer): TObject;
  public
    destructor Destroy; override;
    procedure Clear; override;
    property Items[Index: Integer]: TObject read GetItem;
  end;

  { TcxSchedulerDateList }

  TcxSchedulerDateList = class(TList)
  private
    FChanged: Boolean;
    function GetChanged: Boolean;
    function GetItem(AIndex: Integer): TDateTime;
    procedure SetItem(AIndex: Integer; const AValue: TDateTime);
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
  {$IFNDEF DELPHI6}
    procedure Assign(ASource: TList);
  {$ENDIF}
    function Add(ADate: TDateTime): Integer; reintroduce;
    function AddEx(ADate: TDateTime): Integer;
    function ExistDate(ADate: TDateTime): Boolean;
    function IndexOf(ADate: TDateTime): Integer; reintroduce;
    property Items[Index: Integer]: TDateTime read GetItem write SetItem; default;
    property Changed: Boolean read GetChanged write FChanged;
  end;

  { TcxSchedulerTimeRange }

  TcxSchedulerTimeRange = class(TCollectionItem)
  protected
    FFinish: TDateTime;
    FStart: TDateTime;
    function GetDuration: TDateTime;
  public
    property Duration: TDateTime read GetDuration;
    property Finish: TDateTime read FFinish;
    property Start: TDateTime read FStart;
  end;

  { TcxSchedulerTimeRanges}

  TcxSchedulerTimeRanges = class(TCollection)
  private
    function GetItem(AIndex: Integer): TcxSchedulerTimeRange;
  protected
    FOwner: TObject;
  public
    constructor CreateEx(AOwner: TObject);
    function Add(const AStart, AFinish: TDateTime): TcxSchedulerTimeRange;
    property Items[Index: Integer]: TcxSchedulerTimeRange read GetItem; default;
  end;

  { TcxSchedulerEventLabel }

  TcxSchedulerEventLabel = class(TCollectionItem)
  private
    FCaption: string;
    FColor: TColor;
    FOriginalIndex: Integer;
    function GetCaption: string;
    function GetColor: TColor;
    procedure SetCaption(const AValue: string);
    procedure SetColor(AValue: TColor);
  public
    constructor Create(Collection: TCollection); override;

    property Caption: string read GetCaption write SetCaption;
    property Color: TColor read GetColor write SetColor;
  end;

  { TcxSchedulerEventLabels }

  TcxSchedulerEventLabels = class(TCollection)
  private
    FImages: TImageList;
    function GetItem(AIndex: Integer): TcxSchedulerEventLabel;
  protected
    procedure CreateDefaultItems;
    procedure Update(Item: TCollectionItem); override;
    procedure UpdateImageList;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(AColor: TColor; const ACaption: string): TcxSchedulerEventLabel;
    function IndexOfColor(AColor: TColor): Integer;

    property Items[Index: Integer]: TcxSchedulerEventLabel read GetItem; default;
    property Images: TImageList read FImages;
  end;

  TcxMinutesToTextProc = function (AMinutes: Integer): string;
  TcxTextToMinutesProc = function (const AText: string; out AMinutes: Integer): Boolean;

function GetNearestDivider(ANum, ADenom, AMinDenom, AMaxDenom: Integer): Integer;

function cxCompareDates(Item1, Item2: Pointer): Integer;

procedure cxSchedulerError(const ADescription: string); overload;
procedure cxSchedulerError(const ADescription: string; Args: array of const); overload;

function cxMinutesToText(AMinutes: Integer): string;
function cxTextToMinutes(const AText: string; out AMinutes: Integer): Boolean;

const
  DateTimeHelper : TcxSchedulerDateTimeHelperClass = TcxSchedulerDateTimeHelper;
  cxMinutesToTextProc: TcxMinutesToTextProc = cxMinutesToText;
  cxTextToMinutesProc: TcxTextToMinutesProc = cxTextToMinutes;

  PredefinedResourceColors: array[0..11] of TcxSchedulerResourceColors =
  (($B1E4F3, $98D0EA, $C7EFFF, $A2DBF6, $BCF4FF, $D5FFFF),
   ($FF6E03, $F5BFA0, $FCE5D1, $FADAC4, $F5BFA0, $FEECDD),
   ($8ACBA8, $68B48C, $B4E4CD, $A2D1BA, $97D4B3, $BCECD5),
   ($B59380, $987461, $DBC9C1, $CCAFA1, $BF9E8B, $E6D8CF),
   ($957CB4, $7A659C, $C7BDDA, $ABA3C5, $A186BE, $D6CBE3),
   ($9CA87B, $808E54, $C3CAAE, $ADB691, $A7B189, $D1D6C1),
   ($71A7EB, $4783CA, $A3C4EE, $76A6E1, $7FB4F7, $AED0FA),
   ($8381D2, $6564B3, $BDBBE9, $A6A4DE, $8E8CDD, $C9C8EF),
   ($7A8A81, $596466, $BFCFC4, $A9B5AC, $849689, $CBD8D0),
   ($BBBA00, $999700, $E3E290, $CCCB54, $C8C700, $ECECA8),
   ($C2889B, $9B6376, $E6C7D2, $D8A9B9, $CF94A8, $ECD5DD),
   ($BDBDBD, $797979, $CCCCCC, $B1B1B1, $CCCCCC, $E6E6E6));

  ResourceColorIntensityValues: array[TSchedulerResourceColor] of Integer =
    (80, 65, 85, 70, 90, 100);

var
  EventImages: TCustomImageList;
  MenuImages: TCustomImageList;
  MoreEventButtonGlyphs: TCustomImageList;
  TimeLinePatterns: TCustomImageList;
  StateBrushes: array[0..7] of TBrush;
  SchedulerHelpersFactory: TcxSchedulerHelpersFactoryClass;
  EventLabels: TcxSchedulerEventLabels;
  DefaultTimeZoneInfo: TcxTimeZoneInformation;

implementation

uses
  Math, CommCtrl, dxCore, cxClasses, cxControls, cxLibraryConsts;

type
  TcxPaletteChangedNotifier = class(TcxSystemPaletteChangedNotifier)
  protected
    procedure DoChanged; override;
  end;

const
  cxShadowSize = 5;

var
  PaletteChangedListener: TcxPaletteChangedNotifier;

  // date time sytem variables
  PrevTimeZone: Integer;
  PrevNextTimeZone: Integer;
  TimeZoneDeltaBias: Double;
  ACurrentTimeZone: Integer;
  TimeZoneInformations: array of TcxTimeZoneInformation;
  // first day of week
  SystemStartOfWeek: TcxDayOfWeek;
  LongDateOrder: Integer;
  LongDayMonthFormat: string;
  DayMonthFormats: array[0..4] of string;

  // graphics variables
  PrevColorData: TcxSchedulerResourceColors;
  PrevFontHandle: HFont;
  PrevFontHeight: Integer;
  PrevResourceColor: TColor;

{$R cxScheduler.res}

function GetNearestDivider(ANum, ADenom, AMinDenom, AMaxDenom: Integer): Integer;
begin
  Result := Max(ADenom, AMinDenom);
  Result := Min(Result, AMaxDenom);
  if ANum mod Result <> 0 then
  begin
    if (ANum mod Result) > (Result / 2) then
      while ANum mod Result <> 0 do Inc(Result)
    else
      while ANum mod Result <> 0 do Dec(Result);
  end;
  Result := Min(ADenom, AMaxDenom);
end;

function cxCompareDates(Item1, Item2: Pointer): Integer;
begin
  Result := Integer(Item1) - Integer(Item2);
end;

procedure cxSchedulerError(const ADescription: string); overload;
begin
  cxSchedulerError(ADescription, []);
end;

procedure cxSchedulerError(const ADescription: string; Args: array of const);
begin
  raise EcxScheduler.CreateFmt(ADescription, Args);
end;

function cxMinutesToText(AMinutes: Integer): string;
var
  W: Integer;
begin
  if (AMinutes >= MinsPerWeek) and ((AMinutes mod MinsPerWeek) = 0) then
  begin
    W := AMinutes div MinsPerWeek;
    Result := Format('%d %s', [W, cxGetResourceString(sWeekPluralNames[W <> 1])]);
  end
  else
    if (AMinutes >= MinsPerDay) and ((AMinutes * 100 mod MinsPerDay) = 0) then
      Result := Format('%s %s', [FloatToStr(AMinutes / MinsPerDay),
        cxGetResourceString(sDayPluralNames[AMinutes <> MinsPerDay])])
    else
      if (AMinutes >= MinsPerHour) and ((AMinutes * 10 mod MinsPerHour) = 0) then
        Result := Format('%s %s', [FloatToStr(AMinutes / MinsPerHour),
          cxGetResourceString(sHourPluralNames[AMinutes <> MinsPerHour])])
      else
        Result := Format('%d %s', [AMinutes,
          cxGetResourceString(sMinutePluralNames[AMinutes <> 1])]);
end;

function cxTextToMinutes(const AText: string; out AMinutes: Integer): Boolean;
var
  ACode, APos, I: Integer;
  AValue: Extended;
  S: string;

  function CheckMeasureUnits(const AName1, AName2: string): Boolean;
  begin
    Result := ((Length(S) = 1) and SameText(S, AName1[1]) or SameText(S, AName2[1])) or
      (SameText(S, AName1) or SameText(S, AName2));
  end;

begin
  Result := True;
  S := Trim(AText);
  for I := 1 to Length(S) do
    if S[I] = DecimalSeparator then S[I] := '.';
  Val(S, AValue, ACode);
  if ACode = 0 then
  begin
    AMinutes := Abs(Round(AValue));
    Exit;
  end;
  if ACode > 1 then
  begin
    APos := ACode;
    Val(Copy(S, 1, APos - 1), AValue, ACode);
    S := Trim(Copy(S, APos, Length(S)));
    if CheckMeasureUnits(cxGetResourceString(sMinutePluralNames[True]),
      cxGetResourceString(sMinutePluralNames[False])) then
      AMinutes := Round(AValue)
    else
      if CheckMeasureUnits(cxGetResourceString(sHourPluralNames[True]),
        cxGetResourceString(sHourPluralNames[False])) then
          AMinutes := Round(AValue * MinsPerHour)
      else
        if CheckMeasureUnits(cxGetResourceString(sDayPluralNames[True]),
          cxGetResourceString(sDayPluralNames[False])) then
            AMinutes := Round(AValue * MinsPerDay)
        else
          if CheckMeasureUnits(cxGetResourceString(sWeekPluralNames[True]),
            cxGetResourceString(sWeekPluralNames[False])) then
              AMinutes := Round(AValue * MinsPerWeek)
          else
            AMinutes := Round(AValue);
    AMinutes := Abs(AMinutes);
  end
  else
    Result := False;
end;

{ TcxSchedulerDateTimeHelper }

class function TcxSchedulerDateTimeHelper.ConvertToAnotherTimeZone(
  const ADateTime: TDateTime; ATimeZone, ANextTimeZone: Integer): TDateTime;
begin
  if (ATimeZone <> PrevTimeZone) or (ANextTimeZone <> PrevNextTimeZone) then
  begin
    TimeZoneDeltaBias := ConvertToLocalTime(
      ConvertToGlobalTime(ADateTime, ATimeZone), ANextTimeZone) - ADateTime;
    PrevTimeZone := ATimeZone;
    PrevNextTimeZone := ANextTimeZone;
  end;
  Result := ADateTime;
  if (TimeZoneDeltaBias < 0) and (Result < 1) then
    Result := Result + 1;
  Result := Result + TimeZoneDeltaBias;
end;

class function TcxSchedulerDateTimeHelper.ConvertToGlobalTime(
  const ADateTime: TDateTime; ATimeZone: Integer = -1): TDateTime;
begin
  Result := ADateTime + TimeZoneBias(CheckTimeIndex(ATimeZone));
end;

class function TcxSchedulerDateTimeHelper.ConvertToLocalTime(
  const ADateTime: TDateTime; ATimeZone: Integer = -1): TDateTime;
begin
  Result := ADateTime - TimeZoneBias(CheckTimeIndex(ATimeZone));
end;

class function TcxSchedulerDateTimeHelper.CurrentTimeZone: Integer;
begin
  Result := ACurrentTimeZone;
end;

procedure CutLeftYear(var S: string);
var
  F: Boolean;
  I, Pos: Integer;
begin
  Pos := 0;
  F := False;
  for I := 1 to Length(S) do
    if S[I] = '''' then
      F := not F
    else
      if not F and (UpCase(S[I]) in ['D', 'M']) then
      begin
        Pos := I;
        break;
      end;
  if Pos > 0 then
    Delete(S, 1, I - 1);
end;

procedure CutRightYear(var S: string);
var
  F: Boolean;
  I, Pos: Integer;
begin
  Pos := 0;
  F := False;
  for I := Length(S) downto 1 do
    if S[I] = '''' then
      F := not F
    else
      if not F and (UpCase(S[I]) in ['D', 'M']) then
      begin
        Pos := I;
        break;
      end;
  if Pos > 0 then
    S := Copy(S, 1, Pos);
end;

function GetShortestFormat: string;
var
  I: Integer;
begin
  Result := ShortDateFormat;
  if Result = '' then Exit;
  if UpCase(Result[1]) = 'Y' then
    CutLeftYear(Result)
  else
    CutRightYear(Result);
  I := Pos('mm', LowerCase(Result));
  if I > 0 then
    Delete(Result, I, 1);
  I := Pos('dd', LowerCase(Result));
  if I > 0 then
    Delete(Result, I, 1);
end;

procedure CutMonth(var S: string; AStartIndex: Integer);

  procedure CutLeftMonth(var S: string);
  var
    F: Boolean;
    I, Pos: Integer;
  begin
    Pos := 0;
    F := False;
    for I := AStartIndex + 3 to Length(S) do
      if S[I] = '''' then
        F := not F
      else
        if not F and (UpCase(S[I]) = 'D') then
        begin
          Pos := I;
          break;
        end;
    if Pos > 0 then
      Delete(S, AStartIndex, Pos - AStartIndex);
  end;

  procedure CutRightMonth(var S: string);
  var
    F: Boolean;
    I, Pos: Integer;
  begin
    Pos := 0;
    F := False;
    for I := AStartIndex - 1 downto 1 do
      if S[I] = '''' then
        F := not F
      else
        if not F and (UpCase(S[I]) <> ' ') then
        begin
          Pos := I;
          break;
        end;
    if Pos > 0 then
      Delete(S, I + 1, AStartIndex - I + 3);
  end;

begin
  if LongDateOrder = 1 then
    CutRightMonth(S)
  else
    CutLeftMonth(S);
end;

procedure GetDayMonthFormats;
var
  S: string;
  I: Integer;
  Index: Integer;
begin
  S := LongDayMonthFormat;
  Index := 0;
  DayMonthFormats[0] := S;
  DayMonthFormats[1] := GetShortestFormat;
  DayMonthFormats[2] := DayMonthFormats[1];
  DayMonthFormats[3] := DayMonthFormats[1];
  DayMonthFormats[4] := DayMonthFormats[1];
  I := Pos('mmmm', LowerCase(S));
  if I > 0 then
  begin
    Delete(S, I, 1);
    Inc(Index);
    DayMonthFormats[Index] := S;
  end;
  I := Pos('dddd', LowerCase(S));
  if I > 0 then
  begin
    Delete(S, I, 1);
    Inc(Index);
    DayMonthFormats[Index] := S;
  end;
  I := Pos('mmm', LowerCase(S));
  if I > 0 then
  begin
    CutMonth(S, I);
    Inc(Index);
    DayMonthFormats[Index] := S;
  end;
end;

class function TcxSchedulerDateTimeHelper.DateToLongDateStr(
  ADate: TDateTime): string;
begin
  Result := cxDateUtils.DateToLongDateStr(ADate);
end;

class function TcxSchedulerDateTimeHelper.DayToStr(
  const ADate: TDateTime; AFormat: Integer; ACompressed: Boolean): string;
var
  AYear, AMonth, ADay: Word;
begin
  if ACompressed then
  begin
    DecodeDate(ADate, AYear, AMonth, ADay);
    ADay := DayOfWeek(ADate);
    Result := IntToStr(DayOf(ADate));
    case AFormat of
      0:
        Result := LongDayNames[ADay] + '/'+
          LongDayNames[DayOfWeek(ADate + 1)] + ' ' + Result;
      1:
        Result := ShortDayNames[ADay] + '/'+
          ShortDayNames[DayOfWeek(ADate + 1)] + ' ' + Result;
    else
      Result := Result + '/' + IntToStr(DayOf(ADate + 1));
    end;
  end
  else
    if not cxGetDateFormat(ADate, Result, 0, DayMonthFormats[AFormat]) then
      Result := DateToStr(ADate);
end;

class function TcxSchedulerDateTimeHelper.DayToStrFormatCount: Integer;
begin
  Result := 5;
end;

class function TcxSchedulerDateTimeHelper.HourToStr(const ATime: TDateTime): string;
var
  IsPM: Boolean;
  H, M, S: Word;
begin
  DecodeTime(ATime, H, M, S, S);
  Result := '';
  if not Is24HourTimeFormat then
  begin
    Result := ':' + FormatFloat('00', M);
    IsPM := H >= 12;
    if IsPM then Dec(H, 12);
    if (H = 0) then
    begin
      if not IsPM then
        Result := '12 ' + AnsiLowerCase(TimeAMString)
      else
        Result := '12 ' + AnsiLowerCase(TimePMString);
    end
    else
      Result := FormatFloat('0', H) + ':' + FormatFloat('00', M);
  end
  else
    Result := FormatFloat('00', H) + ':' + FormatFloat('00', M);
end;

class function TcxSchedulerDateTimeHelper.MonthYearToStr(
  AMonth, AYear: Integer): string;
begin
  if LongDateOrder < 2 then
    Result := LongMonthNames[AMonth] + ' ' + IntToStr(AYear)
  else
    Result := IntToStr(AYear) + ' ' + LongMonthNames[AMonth];
end;

class procedure TcxSchedulerDateTimeHelper.Refresh;
begin
  GetFormatSettings;
  RetrieveStartOfWeek;
  RefreshDateInformation;
  Is24HourTimeFormat := GetIs24HourTimeFormat;
end;

class procedure TcxSchedulerDateTimeHelper.FillAdvanceStrings(AStrings: TStrings);
begin
  if AStrings = nil then Exit;
  AStrings.BeginUpdate;
  try
    AStrings.Clear;
    AStrings.AddObject(cxGetResourceString(@scxTime0m), Pointer(0));
    AStrings.AddObject(cxGetResourceString(@scxTime5m), Pointer(5));
    AStrings.AddObject(cxGetResourceString(@scxTime10m), Pointer(10));
    AStrings.AddObject(cxGetResourceString(@scxTime15m), Pointer(15));
    AStrings.AddObject(cxGetResourceString(@scxTime20m), Pointer(20));
    AStrings.AddObject(cxGetResourceString(@scxTime30m), Pointer(30));
    AStrings.AddObject(cxGetResourceString(@scxTime1h), Pointer(1 * 60));
    AStrings.AddObject(cxGetResourceString(@scxTime2h), Pointer(2 * 60));
    AStrings.AddObject(cxGetResourceString(@scxTime3h), Pointer(3 * 60));
    AStrings.AddObject(cxGetResourceString(@scxTime4h), Pointer(4 * 60));
    AStrings.AddObject(cxGetResourceString(@scxTime5h), Pointer(5 * 60));
    AStrings.AddObject(cxGetResourceString(@scxTime6h), Pointer(6 * 60));
    AStrings.AddObject(cxGetResourceString(@scxTime7h), Pointer(7 * 60));
    AStrings.AddObject(cxGetResourceString(@scxTime8h), Pointer(8 * 60));
    AStrings.AddObject(cxGetResourceString(@scxTime9h), Pointer(9 * 60));
    AStrings.AddObject(cxGetResourceString(@scxTime10h), Pointer(10 * 60));
    AStrings.AddObject(cxGetResourceString(@scxTime11h), Pointer(11 * 60));
    AStrings.AddObject(cxGetResourceString(@scxTime12h), Pointer(12 * 60));
    AStrings.AddObject(cxGetResourceString(@scxTime18h), Pointer(18 * 60));
    AStrings.AddObject(cxGetResourceString(@scxTime1d), Pointer(1 * 24 * 60));
    AStrings.AddObject(cxGetResourceString(@scxTime2d), Pointer(2 * 24 * 60));
    AStrings.AddObject(cxGetResourceString(@scxTime3d), Pointer(3 * 24 * 60));
    AStrings.AddObject(cxGetResourceString(@scxTime4d), Pointer(4 * 24 * 60));
    AStrings.AddObject(cxGetResourceString(@scxTime1w), Pointer(1 * 7 * 24 * 60));
    AStrings.AddObject(cxGetResourceString(@scxTime2w), Pointer(2 * 7 * 24 * 60));
  finally
    AStrings.EndUpdate;
  end;
end;

class procedure TcxSchedulerDateTimeHelper.IncMonth(
  var AYear, AMonth, ADay: Word; ANumberOfMonths: Integer = 1);
begin
  IncAMonth(AYear, AMonth, ADay, ANumberOfMonths);
end;

class function TcxSchedulerDateTimeHelper.Intersect(
  const AStart, AFinish, AStart1, AFinish1: TDateTime): Boolean;
begin
  Result := ((AStart1 > AStart) and (AStart1 <= AFinish)) or
    ((AFinish1 > AStart) and (AFinish1 <= AFinish));
end;

class function TcxSchedulerDateTimeHelper.IsFreeTime(
  const ADateTime: TDateTime; AWorkDays: TDays;
  const AWorkStart, AWorkFinish: TDateTime): Boolean;
var
  AHour: Word;
begin
  AHour := HourOf(ADateTime);
  Result := IsWeekEnd(ADateTime, AWorkDays) or
    (AHour < AWorkStart) or (AHour > AWorkFinish);
end;

class function TcxSchedulerDateTimeHelper.IsOddMonth(
  const ADate: TDateTime): Boolean;
begin
  Result := Odd(MonthOf(ADate));
end;

class function TcxSchedulerDateTimeHelper.IsWeekEnd(
  const ADate: TDateTime; AWorkDays: TDays): Boolean;
var
  ADay: Word;
begin
  ADay := DayOfTheWeek(ADate);
  if ADay > 6 then ADay := 0;
  Result := not (TDay(ADay) in AWorkDays);
end;

class function TcxSchedulerDateTimeHelper.IsWeeksFull(
  const AStartDate, AEndDate: TDateTime): Boolean;
begin
  Result := (DayOfWeek(AStartDate) = 1) and (DayOfWeek(AEndDate) = 7);
end;

class function TcxSchedulerDateTimeHelper.StartOfWeek: Integer;
begin
  Result := SystemStartOfWeek;
end;

class function TcxSchedulerDateTimeHelper.TimeAMString: string;
begin
  Result := SysUtils.TimeAMString;
end;

class function TcxSchedulerDateTimeHelper.TimePMString: string;
begin
  Result := SysUtils.TimePMString;
end;

class function TcxSchedulerDateTimeHelper.TimeToStr(
  const ATime: TDateTime): string;
var
  APos: Integer;
begin
  Result := AnsiLowerCase(FormatDateTime('t', ATime));
  repeat
    APos := Pos(' ', Result);
    if APos > 0 then
      Delete(Result, APos, 1);
  until APos = 0;
end;

class function TcxSchedulerDateTimeHelper.TimeZoneCount: Integer;
begin
  Result := Length(TimeZoneInformations);
end;

class function TcxSchedulerDateTimeHelper.TimeZoneBias(AIndex: Integer): TDateTime;
begin
  if AIndex = -1 then
    AIndex := CurrentTimeZone;
  Result := TimeZoneInfo(AIndex).TZI.Bias * MinuteToTime;
end;

class function TcxSchedulerDateTimeHelper.TimeZoneInfo(AIndex: Integer): TcxTimeZoneInformation;
begin
  if (AIndex >= 0) and (AIndex < Length(TimeZoneInformations)) then
    Result := TimeZoneInformations[AIndex]
  else
    Result := DefaultTimeZoneInfo;
end;

class function TcxSchedulerDateTimeHelper.RoundTime(
  const ADateTime: TDateTime): TDateTime;
var
  H, M, S, MS: Word;
begin
  Result := DateTimeToTimeStamp(ADateTime).Date - DateDelta;
  DecodeTime(ADateTime, H, M, S, MS);
  if Result < 0 then
    Result := Result - (H * HourToTime + M * MinuteToTime)
  else
    Result := Result +  H * HourToTime + M * MinuteToTime;
end;

class function TcxSchedulerDateTimeHelper.WeekCount(
  const AStart, AFinish: TDateTime): Integer;
var
  C: Integer;
begin
  //DELPHI8! check Trunc(AFinish)
  C := Trunc(AFinish) - Trunc(AStart);
  Result := C div 7;
  if (C mod 7) <> 0 then Inc(Result);
end;

class function TcxSchedulerDateTimeHelper.WorkDays: TDays;
begin
  Result := [dMonday..dFriday];
end;

class function TcxSchedulerDateTimeHelper.WorkFinish: TDateTime;
begin
  Result := EncodeTime(17, 0, 0, 0);
end;

class function TcxSchedulerDateTimeHelper.WorkStart: TDateTime;
begin
  Result := EncodeTime(8, 0, 0, 0);
end;

class function TcxSchedulerDateTimeHelper.CheckTimeIndex(
  const AIndex: Integer): Integer;
begin
  Result := AIndex;
  if AIndex = -1 then
    Result := CurrentTimeZone;
end;

class function TcxSchedulerDateTimeHelper.cxTZInfoToTZInfo(
  const AInfo: TcxTimeZoneInformation): TTimeZoneInformation;
begin
  FillChar(Result, SizeOf(Result), 0);
  Result.Bias := AInfo.TZI.Bias;
  Result.StandardBias := AInfo.TZI.StandardBias;
  Result.DaylightBias := AInfo.TZI.DaylightBias;
  Result.StandardDate := AInfo.TZI.StandardDate;
  Result.DaylightDate := AInfo.TZI.DaylightDate;
  Move(AInfo.StandardName[1], Result.StandardName, Length(AInfo.StandardName) shl 1);
  Move(AInfo.DaylightName[1], Result.DaylightName, Length(AInfo.DaylightName) shl 1);
end;

class function TcxSchedulerDateTimeHelper.TZInfoTocxTZInfo(
  const AInfo: TTimeZoneInformation): TcxTimeZoneInformation;
begin
  FillChar(Result, SizeOf(Result), 0);
  Result.TZI.Bias := AInfo.Bias;
  Result.TZI.StandardBias := AInfo.StandardBias;
  Result.TZI.DaylightBias := AInfo.DaylightBias;
  Result.TZI.StandardDate := AInfo.StandardDate;
  Result.TZI.DaylightDate := AInfo.DaylightDate;
  Result.StandardName := AInfo.StandardName;
  Result.DaylightName := AInfo.DaylightName;
end;

class function TcxSchedulerDateTimeHelper.GetIs24HourTimeFormat: Boolean; 
begin
  Result := Pos('H', GetLocaleStr(GetThreadLocale, LOCALE_STIMEFORMAT, '')) <> 0;
end;

class procedure TcxSchedulerDateTimeHelper.InitTimeZoneInformation;
var
  I: Integer;
  ARegistry: TRegistry;
  ASubKeys: TStringList;
  ATimeZoneInfo, ACurTimeZoneInfo: TTimeZoneInformation;
const
  AKeys: array[Boolean] of string =
    ('SOFTWARE\Microsoft\Windows\CurrentVersion\Time Zones',
     'SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones');
begin
  ARegistry := TRegistry.Create(KEY_READ);
  try
    GetTimeZoneInformation(ACurTimeZoneInfo);
    DefaultTimeZoneInfo := TZInfoTocxTZInfo(ACurTimeZoneInfo);
    ARegistry.RootKey := HKEY_LOCAL_MACHINE;
    if ARegistry.OpenKeyReadOnly(AKeys[IsWinNT]) and ARegistry.HasSubKeys then
    begin
      ASubKeys := TStringList.Create;
      try
        ARegistry.GetKeyNames(ASubKeys);
        ARegistry.CloseKey;
        SetLength(TimeZoneInformations, ASubKeys.Count);
        for I := 0 to ASubKeys.Count - 1 do
          if ARegistry.OpenKeyReadOnly(AKeys[IsWinNT] + '\' + ASubKeys[I]) then
          begin
            ReadTimeZoneInfoFromRegistry(ARegistry, TimeZoneInformations[I]);
            ARegistry.CloseKey;
            ATimeZoneInfo := cxTZInfoToTZInfo(TimeZoneInformations[I]);
            if CompareMem(@ATimeZoneInfo, @ACurTimeZoneInfo,
              SizeOf(ATimeZoneInfo.Bias) + SizeOf(ATimeZoneInfo.StandardName)) then
              ACurrentTimeZone := I;
          end;
      finally
        ASubKeys.Free;
      end;
    end;
  finally
    ARegistry.Free;
  end;
end;

class procedure TcxSchedulerDateTimeHelper.ReadTimeZoneInfoFromRegistry(
  ARegistry: TRegistry; out AInfo: TcxTimeZoneInformation);
begin
  if ARegistry.ValueExists('Display') then
    AInfo.Display := ARegistry.ReadString('Display');
  if ARegistry.ValueExists('Std') then
    AInfo.StandardName := ARegistry.ReadString('Std');
  if ARegistry.ValueExists('Dlt') then
    AInfo.DaylightName := ARegistry.ReadString('Dlt');
  if ARegistry.ValueExists('MapID') then
    AInfo.MapID := ARegistry.ReadString('MapID');
  if ARegistry.ValueExists('Index') then
    AInfo.Index := ARegistry.ReadInteger('Index');
  if ARegistry.ValueExists('TZI') then
    ARegistry.ReadBinaryData('TZI', AInfo.TZI, SizeOf(AInfo.TZI));
end;

{$WARNINGS OFF}

function GetLongDayMonthFormat: string;
var
  L: Integer;
begin
  Result := LongDateFormat;
  L := StrToIntDef(GetLocaleStr(GetThreadLocale, LOCALE_ILDATE, '0'), 0);
  if L < 2 then
    CutRightYear(Result)
  else
    CutLeftYear(Result);
end;

class procedure TcxSchedulerDateTimeHelper.RefreshDateInformation;
var
  DefaultLCID: LCID;
  I, Day: Integer;
begin
  DefaultLCID := GetUserDefaultLCID;
  for I := 1 to 12 do
  begin
    ShortMonthNames[I] :=
      GetLocaleStr(DefaultLCID, LOCALE_SABBREVMONTHNAME1 + I - 1, ShortMonthNames[I]);
    LongMonthNames[I] :=
      GetLocaleStr(DefaultLCID, LOCALE_SMONTHNAME1 + I - 1, LongMonthNames[I]);
  end;
  for I := 1 to 7 do
  begin
    Day := I - 2;
    if Day = -1 then Day := 6;
    ShortDayNames[I] :=
      GetLocaleStr(DefaultLCID, LOCALE_SABBREVDAYNAME1 + Day, ShortDayNames[I]);
    LongDayNames[I] :=
      GetLocaleStr(DefaultLCID, LOCALE_SDAYNAME1 + Day, LongDayNames[I]);
  end;
  GetFormatSettings;
  LongDateOrder := StrToIntDef(GetLocaleStr(GetThreadLocale, LOCALE_ILDATE, '1'), 1);
  LongDayMonthFormat := GetLongDayMonthFormat;
  GetDayMonthFormats;
end;

{$WARNINGS ON}

class procedure TcxSchedulerDateTimeHelper.RetrieveStartOfWeek;
begin
  SystemStartOfWeek := StrToInt(GetLocaleStr(GetUserDefaultLCID, LOCALE_IFIRSTDAYOFWEEK, '0')) + 1;
  if SystemStartOfWeek > 6 then
    SystemStartOfWeek := 0;
end;

class procedure TcxSchedulerDateTimeHelper.InitSchedulerDateTimeSystem;
begin
  GetFormatSettings;
  DateTimeHelper.InitTimeZoneInformation;
  Refresh;
end;

class procedure TcxSchedulerDateTimeHelper.DoneSchedulerDateSystem;
begin
  SetLength(TimeZoneInformations, 0);
end;

{ TcxSchedulerPainterHelper }

class procedure TcxSchedulerPainterHelper.DrawClock(ACanvas: TcxCanvas;
  const ARect: TRect; AHour, AMinute: Word; const AViewParams: TcxViewParams);
var
  AfterNoon: Boolean;
  XC, YC: Integer;
const
  ArrowColor: array[Boolean] of TColor = (clBlack, clWhite);
begin
  XC := (ARect.Left + ARect.Right) div 2;
  YC := (ARect.Top + ARect.Bottom) div 2;
  AfterNoon := AHour >= 12;
  if AfterNoon then Dec(AHour, 12);
  DrawIcon(ACanvas, ARect, rcClockIndex + Byte(AfterNoon), AViewParams,  True);
  ACanvas.Pen.Color := ArrowColor[AfterNoon];
  AHour := AHour * 2;
  if AMinute >= 30 then
    Inc(AHour);
  if AMinute > 45 then
    Inc(AHour);
  DrawClockLine(ACanvas, AHour, 24, 5, XC, YC);
  DrawClockLine(ACanvas, AMinute, 60, 8, XC, YC);
end;

class procedure TcxSchedulerPainterHelper.DrawClock(ACanvas: TcxCanvas;
  const ARect: TRect; ATime: TDateTime; const AViewParams: TcxViewParams);
var
  H, M, S, MS: Word;
begin
  DecodeTime(ATime, H, M, S, MS);
  DrawClock(ACanvas, ARect, H, M, AViewParams);
end;

class procedure TcxSchedulerPainterHelper.DrawGradientRect(
  ACanvas: TcxCanvas; AStartColor: TColor; const ARect: TRect);
begin
  FillGradientRect(ACanvas.Handle, ExcludeBorders(ARect, [bBottom]),
    AStartColor, dxOffice11SelectedDownColor1, False);
  ACanvas.FrameRect(ARect, dxOffice11SelectedDownColor2, 1, [bBottom]);
end;

class procedure TcxSchedulerPainterHelper.DrawIcon(
  ACanvas: TcxCanvas; const R: TRect; AIndex: Integer);
begin
  if ((R.Right - R.Left) < IconsWidth) or
    ((R.Bottom - R.Top) < IconsHeight) then Exit;
  EventImages.DrawingStyle := dsTransparent;
  EventImages.Draw(ACanvas.Canvas, R.Left, R.Top, AIndex);
end;

class procedure TcxSchedulerPainterHelper.DrawIcon(
  ACanvas: TcxCanvas; const R: TRect; AIndex: Integer;
  const AViewParams: TcxViewParams; AIsTransparent: Boolean);
begin
  if not AIsTransparent then
    ACanvas.FillRect(R, AViewParams);
  DrawIcon(ACanvas, R, AIndex);
end;

class procedure TcxSchedulerPainterHelper.DrawShadow(
  ACanvas: TcxCanvas; const ARect, AVisibleRect: TRect; ABuffer: TBitmap);
begin
  ACanvas.Brush.Color := clBtnShadow;
  if (ARect.Bottom - ARect.Top) > cxShadowSize then
    DrawShadowLine(ACanvas, ABuffer, ARect.Right,
      ARect.Top, ARect.Bottom - ARect.Top + ShadowSize - 1, AVisibleRect, True);
  if (ARect.Right - ARect.Left) > cxShadowSize then
    DrawShadowLine(ACanvas, ABuffer, ARect.Left,
      ARect.Bottom, ARect.Right - ARect.Left + ShadowSize, AVisibleRect, False);
end;

class procedure TcxSchedulerPainterHelper.DrawState(ACanvas: TcxCanvas;
  R: TRect; AState: Integer; ABorders: TcxBorders = []; ABorderColor: TColor = clBlack);
begin
  AState := Max(0, Min(AState, High(StateBrushes)));
  if R.Top = R.Bottom then
  begin
    R := ExcludeBorders(R, ABorders);
    ACanvas.Pen.Style := psSolid;
    ACanvas.Pen.Color := clBlack;
    ACanvas.Brush := StateBrushes[AState];
    ACanvas.Polygon([Point(R.Left, R.Top), Point(R.Right, R.Top),
      Point(R.Right, R.Top + R.Right - R.Left)]);
  end
  else
  begin
    ACanvas.FrameRect(R, ABorderColor, 1, ABorders);
    ACanvas.Brush := StateBrushes[AState];
    ACanvas.FillRect(ExcludeBorders(R, ABorders));
  end;
end;

class function TcxSchedulerPainterHelper.ExcludeBorders(const ARect: TRect;
  ABorders: TcxBorders; ABorderSize: Integer = 1): TRect;
begin
  Result := ARect;
  Inc(Result.Left, ABorderSize * Byte(bLeft in ABorders));
  Inc(Result.Top, ABorderSize * Byte(bTop in ABorders));
  Dec(Result.Right, ABorderSize * Byte(bRight in ABorders));
  Dec(Result.Bottom, ABorderSize * Byte(bBottom in ABorders));
end;

class function TcxSchedulerPainterHelper.GetContentColor(
  AResourceColor: Integer; AIsWorkTime: Boolean): TColor;
var
  AColors: TcxSchedulerResourceColors;
begin
  TcxSchedulerPainterHelper.GetResourceColors(AResourceColor, AColors);
  if AIsWorkTime then
    Result := AColors[srcWorkTime]
  else
    Result := AColors[srcNonWorkTime];
end;

class function TcxSchedulerPainterHelper.GetResourceContentColor(
  AResourceIndex: Integer): TColor;
begin
  Result := PredefinedResourceColors[AResourceIndex mod
    Length(PredefinedResourceColors)][High(TcxSchedulerResourceColors)];
end;

class function TcxSchedulerPainterHelper.GetSeparatorColor(
  const AResourceColor: Integer; AIsHourSeparator, AIsWorkTime: Boolean): TColor;
var
  AColors: TcxSchedulerResourceColors;
begin
  TcxSchedulerPainterHelper.GetResourceColors(AResourceColor, AColors);
  Result := AColors[TSchedulerResourceColor(Byte(AIsWorkTime) * 2 + Byte(AIsHourSeparator))];
end;

class function TcxSchedulerPainterHelper.IconsWidth: Integer;
begin
  Result := 17;
end;

class function TcxSchedulerPainterHelper.IconsHeight: Integer;
begin
  Result := 17;
end;

class function TcxSchedulerPainterHelper.IncludeBorders(const ARect: TRect;
  ABorders: TcxBorders; ABorderSize: Integer = 1): TRect;
begin
  Result := ARect;
  Dec(Result.Left, ABorderSize * Byte(bLeft in ABorders));
  Dec(Result.Top, ABorderSize * Byte(bTop in ABorders));
  Inc(Result.Right, ABorderSize * Byte(bRight in ABorders));
  Inc(Result.Bottom, ABorderSize * Byte(bBottom in ABorders));
end;

class procedure TcxSchedulerPainterHelper.InitStyle(
  AStyle: TcxStyle; const AResName: string; AGraphicClass: TGraphicClass);
begin
  if LoadGraphic(AStyle.Bitmap, AResName, AGraphicClass) then
    AStyle.AssignedValues := AStyle.AssignedValues + [svBitmap]
  else
  begin
    AStyle.Bitmap.FreeImage;
    AStyle.AssignedValues := AStyle.AssignedValues - [svBitmap];
  end;
end;

class function TcxSchedulerPainterHelper.LoadGraphic(ABitmap: TBitmap;
  const AResName: string; AGraphicClass: TGraphicClass): Boolean;
var
  AGraphic: TGraphic;
  AStream: TMemoryStream;
begin
  AStream := GetResourceStream(AResName);
  Result := False;
  if AStream <> nil then
  try
    AGraphic := AGraphicClass.Create;
    try
      AGraphic.LoadFromStream(AStream);
      ABitmap.Width := AGraphic.Width;
      ABitmap.Height := AGraphic.Height;
      ABitmap.Canvas.Draw(0, 0, AGraphic);
    finally
      AGraphic.Free;
    end;
    Result := True;
  finally
    AStream.Free;
  end;
end;

class function TcxSchedulerPainterHelper.LoadImages(AWidth, AHeight: Integer;
  const AResName: string; AHasPalette: Boolean = False; AHasTransparent: Boolean = True): TImageList;
const
  Transparents: array[Boolean] of DWORD = (CLR_NONE, CLR_DEFAULT);
begin
  Result := TImageList.CreateSize(AWidth, AHeight);
  if AHasPalette then
    Result.Handle := ImageList_LoadImage(HInstance, PAnsiChar(AResName), AWidth,
      16, Transparents[AHasTransparent], IMAGE_BITMAP, LR_CREATEDIBSECTION)
  else
    Result.Handle := ImageList_LoadImage(HInstance, PAnsiChar(AResName), AWidth,
      16, CLR_NONE, IMAGE_BITMAP, LR_DEFAULTCOLOR);
end;

class function TcxSchedulerPainterHelper.MoreButtonHeight: Integer;
begin
  Result := 8;
end;

class function TcxSchedulerPainterHelper.MoreButtonWidth: Integer;
begin
  Result := 20;
end;

class function TcxSchedulerPainterHelper.ShadowSize: Integer;
begin
  Result := 5;
end;

class function TcxSchedulerPainterHelper.TextHeight(AFont: TFont): Integer;
begin
  if PrevFontHandle = AFont.Handle then
    Result := PrevFontHeight
  else
  begin
    Result := cxTextHeight(AFont);
    PrevFontHeight := Result;
    PrevFontHandle := AFont.Handle;
  end;
end;

class function TcxSchedulerPainterHelper.TextWidth(
  AFont: TFont; const AText: string): Integer;
begin
  Result := cxTextWidth(AFont, AText);
end;

class procedure TcxSchedulerPainterHelper.GetResourceColors(
  AColor: TColor; out AResourceColors: TcxSchedulerResourceColors);
var
  AIndex: Integer;
begin
  if (AColor = clWindow) or (ColorToRgb(AColor) <> PrevResourceColor) then
  begin
    AIndex := High(PredefinedResourceColors);
    if AColor = clWindow then
      AIndex := 1
    else
    begin
      AColor := ColorToRgb(AColor);
      while AIndex >= 0 do
      begin
        if PredefinedResourceColors[AIndex, High(TcxSchedulerResourceColors)] = AColor then
          Break
        else
          Dec(AIndex);
      end;
    end;
    if AIndex >= 0 then
      PrevColorData := PredefinedResourceColors[AIndex]
    else
      InitCachedColors(AColor, PrevColorData);
  end;
  PrevResourceColor := ColorToRgb(AColor);
  AResourceColors := PrevColorData;
end;

class function TcxSchedulerPainterHelper.GetResourceStream(
  const AResName: string): TMemoryStream;
var
  ASize: Integer;
  AHandle: HGLOBAL;
  AResInfo: HRSRC;
  AResPtr: Pointer;
  AResInstance: Integer;
begin
  Result := nil;
  AResInstance := FindResourceHInstance(hInstance);
  AResInfo := FindResource(AResInstance, PChar(AResName), RT_RCDATA);
  ASize := SizeOfResource(AResInstance, AResInfo);
  if (AResInfo <> 0) and (ASize <> 0) then
  begin
    Result := TMemoryStream.Create;
    AHandle := LoadResource(AResInstance, AResInfo);
    AResPtr := LockResource(AHandle);
    Result.WriteBuffer(AResPtr^, ASize);
    Result.Position := 0;
  end;
end;

class procedure TcxSchedulerPainterHelper.CreateStateBrushes;
var
  I: Integer;
const
  AColors: array[0..4] of TColor =
    (clWhite, clWhite, clBlue, clPurple, clWhite);
  ABrushNames: array[0..7] of string =
  ('', 'CXTENTATIVE', '', '', '', 'CXTENTATIVEBW', 'CXBUSYBW', 'CXOUTOFOFFICEBW');

begin
  for I := 0 to 7 do
  begin
    StateBrushes[I] := TBrush.Create;
    if I in [1, 5..7] then
    begin
      StateBrushes[I].Bitmap := TBitmap.Create;
      StateBrushes[I].Bitmap.Handle := LoadBitmap(hInstance, PChar(ABrushNames[I]));
    end
    else
      StateBrushes[I].Color := AColors[I];
  end;
end;

class procedure TcxSchedulerPainterHelper.DrawClockLine(ACanvas: TcxCanvas;
  const ATime, ATimePerCircle, ARadius, XC, YC: Integer);
var
  X, Y: Integer;
  A, C, S: Extended;
begin
  A := Pi / 2 - (ATime *  2 * Pi) / ATimePerCircle;
  SinCos(A, S, C);
  X := XC + Trunc(ARadius * C);
  Y := YC - Trunc(ARadius * S);
  ACanvas.MoveTo(XC, YC);
  ACanvas.LineTo(X, Y);
end;

function cxInRange(Value: Integer; AMin, AMax: Integer): Boolean;
begin
  Result := (Value >= AMin) and (Value <= AMax);
end;

class procedure TcxSchedulerPainterHelper.DrawShadowLine(ACanvas: TcxCanvas;
  ABuffer: TBitmap; const ALeft, ATop, ALength: Integer;
  AVisibleRect: TRect; AIsRight: Boolean);
type
  PRGBArray = ^TRGBArray;
  TRGBArray = array[0..0] of TRGBTriple;
var
  ASize: TSize;
  X, Y: Integer;
  APixels: PRGBArray;
  AOrg: TPoint;
const
  SphericAlpha: array[0..cxShadowSize - 1, 0..cxShadowSize - 1] of Double =
   ((0.95, 0.96, 0.98, 0.99, 1.00),
    (0.85, 0.89, 0.95, 0.98, 1.00),
    (0.71, 0.78, 0.89, 0.96, 0.99),
    (0.61, 0.71, 0.85, 0.95, 0.99),
    (0.56, 0.67, 0.83, 0.95, 0.99));
  LinearAlpha: array[0..cxShadowSize - 1] of Double =
    (0.56, 0.67, 0.83, 0.95, 0.99);
begin
  AOrg := cxPointInvert(ACanvas.WindowOrg);
  Inc(AOrg.Y, ATop);
  Inc(AOrg.X, ALeft);
  AVisibleRect := cxRectOffset(AVisibleRect, cxPointInvert(AOrg));
  if AIsRight then
    ASize := cxSize(ShadowSize, ALength)
  else
    ASize := cxSize(ALength, ShadowSize);
  for Y := 0 to ASize.Cy - 1 do
  begin
    if not cxInRange(AOrg.Y + Y, 0, ABuffer.Height - 1) then Continue;
    APixels  := ABuffer.Scanline[AOrg.Y + Y];
    for X := 0 to ASize.Cx - 1 do
    begin
      if not cxRectPtIn(AVisibleRect, AVisibleRect.Left, Y) then Continue;
      if AIsRight then
      begin
        if Y < cxShadowSize then
          GetShadowValue(APixels^[X + AOrg.X], SphericAlpha[Y, X])
        else
          if Y > (ASize.Cy - cxShadowSize) then
            GetShadowValue(APixels^[X + AOrg.X], SphericAlpha[ASize.Cy - 1 - Y, X])
          else
            GetShadowValue(APixels^[X + AOrg.X], LinearAlpha[X]);
      end
      else
      begin
        if X < cxShadowSize then
          GetShadowValue(APixels^[X + AOrg.X], SphericAlpha[X, Y])
        else
          if X < (ASize.Cx - cxShadowSize) then
            GetShadowValue(APixels^[X + AOrg.X], LinearAlpha[Y]);
      end;
    end;
  end;
end;

class procedure TcxSchedulerPainterHelper.FreeStateBrushes;
var
  I: Integer;
  ABitmap: TBitmap;
begin
  for I := 0 to High(StateBrushes) do
  begin
    ABitmap := StateBrushes[I].Bitmap;
    StateBrushes[I].Bitmap := nil;
    FreeAndNil(StateBrushes[I]);
    ABitmap.Free;
  end;
end;

class function TcxSchedulerPainterHelper.GetColorValue(
  AColor: TColor; ALightValue: Integer): TColor;
begin
  Result := Rgb(
    MulDiv(GetRValue(AColor), ALightValue, 100),
    MulDiv(GetGValue(AColor), ALightValue, 100),
    MulDiv(GetBValue(AColor), ALightValue, 100));
end;

class procedure TcxSchedulerPainterHelper.GetShadowValue(
  var APixel: TRGBTriple; const Alpha: Double);
begin
  APixel.rgbtRed := Round(APixel.rgbtRed * Alpha);
  APixel.rgbtGreen := Round(APixel.rgbtGreen * Alpha);
  APixel.rgbtBlue := Round(APixel.rgbtBlue * Alpha);
end;

class procedure TcxSchedulerPainterHelper.InitCachedColors(
  AColor: TColor; out AColors: TcxSchedulerResourceColors);
var
  I: TSchedulerResourceColor;
begin
  for I := Low(TSchedulerResourceColor) to High(TSchedulerResourceColor) do
    AColors[I] := GetColorValue(AColor, ResourceColorIntensityValues[I]);
end;                                                                      

class procedure TcxSchedulerPainterHelper.InitSchedulerGraphics;
begin
  CreateStateBrushes;
  PrevResourceColor := PredefinedResourceColors[0, srcMajorWorkTimeSeparator];
  PrevColorData := PredefinedResourceColors[0];
  TimeLinePatterns := TcxSchedulerPainterHelper.LoadImages(
    12, 12, 'CXTIMELINEPATTERNS');
  MoreEventButtonGlyphs := TcxSchedulerPainterHelper.LoadImages(
    MoreButtonWidth, MoreButtonHeight, 'CXMOREEVENTS');
  MenuImages := TcxSchedulerPainterHelper.LoadImages(
    16, 16, 'CXSCHEDULERMENUIMAGES', True);
  EventImages := TcxSchedulerPainterHelper.LoadImages(
    17, 17, 'CXSCHEDULEREVENTICONS', True);
end;

class procedure TcxSchedulerPainterHelper.FreeSchedulerGraphics;
begin
  FreeStateBrushes;
  TimeLinePatterns.Free;
  EventImages.Free;
  MoreEventButtonGlyphs.Free;
  MenuImages.Free;
end;

{ TcxSchedulerHelpersFactory }

class function TcxSchedulerHelpersFactory.DateTimeHelperClass: TcxSchedulerDateTimeHelperClass;
begin
  Result := DateTimeHelper;
end;

class function TcxSchedulerHelpersFactory.PainterHelperClass: TcxSchedulerPainterHelperClass;
begin
  Result := TcxSchedulerPainterHelper;
end;

class procedure TcxSchedulerHelpersFactory.Done;
begin
  PaletteChangedListener.Free;
  PainterHelperClass.FreeSchedulerGraphics;
  DateTimeHelperClass.DoneSchedulerDateSystem;
end;

class procedure TcxSchedulerHelpersFactory.Init;
begin
  LoadCursors;
  PainterHelperClass.InitSchedulerGraphics;
  DateTimeHelperClass.InitSchedulerDateTimeSystem;
  if PaletteChangedListener = nil then
  begin
    PaletteChangedListener := TcxPaletteChangedNotifier.Create(True);
    PaletteChangedListener.DoChanged;
  end;
end;

class procedure TcxSchedulerHelpersFactory.LoadCursors;
begin
  Screen.Cursors[crSchedulerCopyEvent] := LoadCursor(HInstance, 'CXSDCOPYEVENT');
  Screen.Cursors[crSchedulerMoveEvent] := LoadCursor(HInstance, 'CXSDMOVEEVENT');
  Screen.Cursors[crSchedulerHorzSplit] := LoadCursor(HInstance, 'CXSDHORZSPLIT');
  Screen.Cursors[crSchedulerVertSplit] := LoadCursor(HInstance, 'CXSDVERTSPLIT');
  Screen.Cursors[crSchedulerSplitAll]  := LoadCursor(HInstance, 'CXSDSPLITALL');
  Screen.Cursors[crSchedulerVertResize] := LoadCursor(HInstance, 'CXSDVERTRESIZE');
  Screen.Cursors[crSchedulerHorzResize] := LoadCursor(HInstance, 'CXSDHORZRESIZE');
  Screen.Cursors[crCalendarMirrorArrow] := LoadCursor(HInstance, 'CXCALENDARMIRRORARROW');
end;

{ TcxPaletteChangedNotifier }

procedure TcxPaletteChangedNotifier.DoChanged;
var
  I: TSchedulerResourceColor;
begin
  inherited DoChanged;
  PrevResourceColor := clNone;
  for I := srcMinorNonWorkTimeSeparator to srcMajorWorkTimeSeparator do
    PredefinedResourceColors[1, I] := ColorToRgb(clBtnShadow);
  PredefinedResourceColors[1, srcWorkTime] := ColorToRgb(clWindow);
  PredefinedResourceColors[1, srcNonWorkTime] := ColorToRgb(clBtnFace);
end;

{ TcxSchedulerObjectList }

destructor TcxSchedulerObjectList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TcxSchedulerObjectList.Clear;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    Items[I].Free;
  inherited Clear; 
end;

function TcxSchedulerObjectList.GetItem(AIndex: Integer): TObject;
begin
  Result := List^[AIndex];
end;

{ TcxSchedulerDateList }

{$IFNDEF DELPHI6}
procedure TcxSchedulerDateList.Assign(ASource: TList);
var
  I: Integer; 
begin
  if ASource = nil then Exit;
  Clear;
  Capacity := ASource.Capacity;
  for I := 0 to ASource.Count - 1 do
    inherited Add(ASource[I]);
end;
{$ENDIF}

function TcxSchedulerDateList.Add(ADate: TDateTime): Integer;
begin
  //DELPHI8! check Trunc(ADate)
  Result := inherited Add(Pointer(Trunc(ADate)));
  if Count > 1 then Sort(cxCompareDates);
end;

function TcxSchedulerDateList.AddEx(ADate: TDateTime): Integer;
begin
  Result := inherited Add(Pointer(Trunc(ADate)));
end;

function TcxSchedulerDateList.ExistDate(ADate: TDateTime): Boolean;
begin
  Result := IndexOf(ADate) >= 0;
end;

function TcxSchedulerDateList.IndexOf(ADate: TDateTime): Integer;
begin
  //DELPHI8! check Trunc(ADate)
  Result := inherited IndexOf(Pointer(Trunc(ADate)));
end;

procedure TcxSchedulerDateList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if (Action = lnAdded) or (Action = lnDeleted) then
    FChanged := True;
end;

function TcxSchedulerDateList.GetChanged: Boolean;
begin
  Result := FChanged;
  FChanged := False;
end;

function TcxSchedulerDateList.GetItem(AIndex: Integer): TDateTime;
begin
  Result := Integer(inherited Items[AIndex]);
end;

procedure TcxSchedulerDateList.SetItem(
  AIndex: Integer; const AValue: TDateTime);
begin
  //DELPHI8! check Trunc(AValue)
  inherited Items[AIndex] := Pointer(Trunc(AValue));
end;

{ TcxSchedulerTimeRange }

function TcxSchedulerTimeRange.GetDuration: TDateTime;
begin
  Result := FFinish - FStart;
end;

{ TcxSchedulerTimeRanges }

constructor TcxSchedulerTimeRanges.CreateEx(AOwner: TObject);
begin
  inherited Create(TcxSchedulerTimeRange);
  FOwner := AOwner;
end;

function TcxSchedulerTimeRanges.GetItem(AIndex: Integer): TcxSchedulerTimeRange;
begin
  Result := TcxSchedulerTimeRange(inherited Items[AIndex]);
end;

function TcxSchedulerTimeRanges.Add(const AStart, AFinish: TDateTime): TcxSchedulerTimeRange;
begin
  Result := TcxSchedulerTimeRange(inherited Add);
  Result.FStart := AStart;
  Result.FFinish := AFinish;
end;

{ TcxSchedulerEventLabel }

constructor TcxSchedulerEventLabel.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FOriginalIndex := -1;
end;

function TcxSchedulerEventLabel.GetCaption: string;
begin
  if FOriginalIndex < 0 then
    Result := FCaption
  else
    Result := cxGetResourceString(sEventLabelCaptions[FOriginalIndex]);
end;

function TcxSchedulerEventLabel.GetColor: TColor;
begin
  if FOriginalIndex < 0 then
    Result := FColor
  else
    Result := EventLabelColors[FOriginalIndex];
end;

procedure TcxSchedulerEventLabel.SetCaption(const AValue: string);
begin
  if FCaption <> AValue then
  begin
    if FOriginalIndex < 0 then
      FCaption := AValue
    else
      cxSetResourceString(sEventLabelCaptions[FOriginalIndex], AValue);
    Changed(False);
  end;
end;

procedure TcxSchedulerEventLabel.SetColor(AValue: TColor);
begin
  if FColor <> AValue then
  begin
    if FOriginalIndex < 0 then
      FColor := AValue
    else
      EventLabelColors[FOriginalIndex] := AValue;
    Changed(False);
  end;
end;

{ TcxSchedulerEventLabels }

constructor TcxSchedulerEventLabels.Create;
begin
  inherited Create(TcxSchedulerEventLabel);
  FImages := TImageList.Create(nil);
  CreateDefaultItems;
end;

destructor TcxSchedulerEventLabels.Destroy;
begin
  FImages.Free;
  inherited Destroy;
end;

function TcxSchedulerEventLabels.Add(AColor: TColor;
  const ACaption: string): TcxSchedulerEventLabel;
begin
  Result := TcxSchedulerEventLabel(inherited Add);
  Result.Caption := ACaption;
  Result.Color := AColor;
end;

function TcxSchedulerEventLabels.IndexOfColor(AColor: TColor): Integer;
var
  I: Integer;
begin
  Result := -1;
  AColor := ColorToRGB(AColor);
  for I := 0 to EventLabels.Count - 1 do
    if AColor = ColorToRGB(Items[I].Color) then
    begin
      Result := I;
      break;
    end;
end;

procedure TcxSchedulerEventLabels.CreateDefaultItems;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to 10 do
      TcxSchedulerEventLabel.Create(Self).FOriginalIndex := I;
  finally
    EndUpdate;
  end;
end;

procedure TcxSchedulerEventLabels.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  UpdateImageList;
end;

procedure TcxSchedulerEventLabels.UpdateImageList;
var
  I: Integer;
  B: TBitmap;
  AColor: TColor;
begin
  Images.Clear;
  B := TBitmap.Create;
  B.Width := 16;
  B.Height := 16;
  try
    for I := 0 to Count - 1 do
    begin
      B.Canvas.Brush.Color := clOlive;
      B.Canvas.FillRect(Rect(0, 0, 16, 16));
      AColor := Items[I].Color;
      if (AColor = clDefault) or (AColor = clNone) then AColor := clWindow;
      B.Canvas.Brush.Color := AColor;
      B.Canvas.Pen.Color := clBlack;
      B.Canvas.Rectangle(Rect(1, 1, 16, 16));
      Images.AddMasked(B, clOlive);
    end;
  finally
    B.Free;
  end;
end;

function TcxSchedulerEventLabels.GetItem(
  AIndex: Integer): TcxSchedulerEventLabel;
begin
  Result := TcxSchedulerEventLabel(inherited Items[AIndex]);
end;

initialization
  SchedulerHelpersFactory := TcxSchedulerHelpersFactory;
  SchedulerHelpersFactory.Init;
  EventLabels := TcxSchedulerEventLabels.Create;

finalization
  SchedulerHelpersFactory.Done;
  EventLabels.Free;

end.

