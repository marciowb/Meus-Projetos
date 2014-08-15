{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       WebCalendar Control                                         }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit cxWebCalendar;

{$I cxVer.inc}

interface

uses
  Classes, Types, TypInfo,
  cxWebIntf, cxWebRender, cxWebStdCtrls, cxWebControls, cxWebUtils, cxWebTypes,
  cxWebClasses, cxWebImgList, cxWebScriptFactory, cxWebGraphics, cxWebColors;

type
  TcxMonthButton = (mbPrev, mbNext);
  TcxWebDate = TDateTime;

  TcxWebDayOfWeek = 0..6;
  TcxWebDay = (dSunday, dMonday, dTuesday, dWednesday, dThursday, dFriday, dSaturday);
  TcxWebDays = set of TcxWebDay;
  TcxWebDayNameFormat = (dfFull, dfShort, dfFirstLetter, dfFirstTwoLetters);
  TcxWebMonthNameFormat = (mfFull, mfShort);
  TcxFirstDayOfWeek = (dowSunday, dowMonday, dowTuesday, dowWednesday, dowThursday,
      dowFriday, dowSaturday, dowLocaleDefault);

  TcxSelectDayEvent = procedure(Sender: TObject; ADate: TcxWebDate) of object;
  TcxChangeMonthEvent = procedure(Sender: TObject; AMonth: Word) of object;
  TcxValidateDateEvent = procedure(Sender: TObject; ADate: TcxWebDate; var Valid: Boolean) of object;

  TcxWebArrayWeekDays = array[1..7] of string;
  TcxWebArrayMonthes = array[1..12] of string;


  TcxCustomWebCalendar = class;
  TcxCalendarSheet = class(TObject)
  private
    FCalendar: TcxCustomWebCalendar;
    FDate: TcxWebDate;
    FDays: TStrings;
    FStartOfWeek: Integer;
    FEndOfWeek: Integer;

    function GetDayCount: Integer;
    function GetDate(Index: Integer): TcxWebDate;
    function GetDay(Index: Integer): Integer;
    function GetMonth: Word;
    function GetYear: Word;
    procedure SetDate(Value: TcxWebDate);
    procedure SetStartOfWeek(Value: Integer);
  protected
    function IsSelectedDay(Index: Integer): Boolean;
    function IsOtherMonthDay(Index: Integer): Boolean;
    procedure UpdateSheet; virtual;

    property Calendar: TcxCustomWebCalendar read FCalendar;
  public
    constructor Create(ACalendar: TcxCustomWebCalendar);
    destructor Destroy; override;

    property Date: TcxWebDate read FDate write SetDate;
    property Dates[Index: Integer]: TcxWebDate read GetDate;
    property DayCount: Integer read GetDayCount;
    property Days[Index: Integer]: Integer read GetDay;
    property Month: Word read GetMonth;
    property EndOfWeek: Integer read FEndOfWeek;
    property StartOfWeek: Integer read FStartOfWeek write SetStartOfWeek;
    property Year: Word read GetYear;
  end;


  TcxWebCalendarEvent = (ceOnSelectDay, ceOnShiftMonth);

  TcxWebCalendarEventsHelper = class(TcxWebScriptEventsHelper)
  protected
    function EventName(const AEvent: Integer): string; override;
    function EventProcParams(const AEvent: Integer): string; override;
    function ScriptObject: string; override;
  public
    function EventTypeInfo: PTypeInfo; override;
  end;

  TcxCustomWebCalendar = class(TcxWebControl)
  private
    FCalendarSheet: TcxCalendarSheet;
    FSelectedDate: TcxWebDate;
    FForcePostBack: Boolean;
    FCellSpacing: Integer;
    FCellPadding: Integer;
    FDayHeaderAlignment: TcxWebHorzAlignment;
    FDayNameFormat: TcxWebDayNameFormat;
    FFirstDayOfWeek: TcxFirstDayOfWeek;
    FImages: TcxWebImageList;
    FMonthNameFormat: TcxWebMonthNameFormat;
    FNextMonthImageIndex: Integer;
    FNextMonthText: string;
    FPrevMonthImageIndex: Integer;
    FPrevMonthText: string;
    FShowMonthPictures: Boolean;
    FShowYear: Boolean;
    FShowTodayLink: Boolean;
    FDayHeaderStyle: TcxWebStyles;
    FOtherMonthDayStyle: TcxWebStyles;
    FTitleStyle: TcxWebStyles;
    FTodayPanelStyle: TcxWebStyles;
    FSelectedStyle: TcxWebStyles;

    FOnSelectDay: TcxSelectDayEvent;
    FOnNextMonthSelect: TcxChangeMonthEvent;
    FOnPrevMonthSelect: TcxChangeMonthEvent;
    FOnValidateDate: TcxValidateDateEvent;

    function GetDaysOfWeekNames(Index: Integer): string;
    function GetMonthNames(Index: Integer): string;
    function GetDayHeaderStyles: TcxWebStyles;
    function GetOtherMonthDayStyle: TcxWebStyles;
    function GetTitleStyle: TcxWebStyles;
    function GetTodayPanelStyle: TcxWebStyles;
    function GetSelectedStyle: TcxWebStyles;
    procedure SetDayHeaderStyles(AValue: TcxWebStyles);
    procedure SetOtherMonthDayStyle(AValue: TcxWebStyles);
    procedure SetTitleStyle(AValue: TcxWebStyles);
    procedure SetTodayPanelStyle(AValue: TcxWebStyles);
    procedure SetSelectedStyle(AValue: TcxWebStyles);

    procedure SetDayHeaderAlignment(AValue: TcxWebHorzAlignment);
    procedure SetDayNameFormat(AValue: TcxWebDayNameFormat);
    procedure SetFirstDayOfWeek(AValue: TcxFirstDayOfWeek);
    procedure SetImages(Value: TcxWebImageList);
    procedure SetMonthNameFormat(AValue: TcxWebMonthNameFormat);
    procedure SetSelectedDate(const Value: TcxWebDate);
    { Actions }
    procedure NextMonth(const AParameters: TcxActionParameters);
    procedure PrevMonth(const AParameters: TcxActionParameters);
    procedure SelectDay(const AParameters: TcxActionParameters);
    procedure TodayDate(const AParameters: TcxActionParameters);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { IcxWebProvidersSupport}
    procedure ImplGetProviders(AList: TList); override;
    { Sizes }
    function GetMinHeight: Integer; override;
    function GetMinWidth: Integer; override;
    { actions }
    procedure RegisterActions; override;
    { events }
    function GetWebEventsHelper: TcxWebCalendarEventsHelper;
    class function GetWebEventsHelperClass: TcxWebEventsHelperClass; override;
    property WebEventsHelper: TcxWebCalendarEventsHelper read GetWebEventsHelper;
    { renderers}
    procedure RegisterRenderers; override;
    { scripts }
    procedure ScriptsSubscription; override;
    { values }
    procedure DoSetValues; override;
    procedure RegisterValues; override;

    function DateToWebString(ADate: TcxWebDate): string;
    function WebStringToDate(AString: string): TcxWebDate;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property CalendarSheet: TcxCalendarSheet read FCalendarSheet;
    property DaysOfWeekNames[Index: Integer]: string read GetDaysOfWeekNames;
    property MonthNames[Index: Integer]: string read GetMonthNames;
    property SelectedDate: TcxWebDate read FSelectedDate write SetSelectedDate;
  published
    property CellPadding: Integer read FCellPadding write FCellPadding;
    property CellSpacing: Integer read FCellSpacing write FCellSpacing;
    property DayHeaderAlignment: TcxWebHorzAlignment read FDayHeaderAlignment write SetDayHeaderAlignment
      default whalRight;
    property DayHeaderStyle: TcxWebStyles read GetDayHeaderStyles write SetDayHeaderStyles;
    property DayNameFormat: TcxWebDayNameFormat read FDayNameFormat write SetDayNameFormat default dfFirstTwoLetters;
    property FirstDayOfWeek: TcxFirstDayOfWeek read FFirstDayOfWeek write SetFirstDayOfWeek;
    property ForcePostBack: Boolean read FForcePostBack write FForcePostBack default False;
    property Height;
    property Images: TcxWebImageList read FImages write SetImages;
    property MonthNameFormat: TcxWebMonthNameFormat read FMonthNameFormat write SetMonthNameFormat default mfFull;
    property NextMonthImageIndex: Integer read FNextMonthImageIndex write FNextMonthImageIndex default -1;
    property NextMonthText: string read FNextMonthText write FNextMonthText;
    property OtherMonthDayStyle: TcxWebStyles read GetOtherMonthDayStyle write SetOtherMonthDayStyle;
    property PopupMenu;
    property PopupShowingType;
    property PrevMonthImageIndex: Integer read FPrevMonthImageIndex write FPrevMonthImageIndex default -1;
    property PrevMonthText: string read FPrevMonthText write FPrevMonthText;
    property SelectedStyle: TcxWebStyles read GetSelectedStyle write SetSelectedStyle;
    property ShowYear: Boolean read FShowYear write FShowYear;
    property ShowMonthPictures: Boolean read FShowMonthPictures write FShowMonthPictures;
    property ShowTodayLink: Boolean read FShowTodayLink write FShowTodayLink;
    property Styles;
    property TitleStyle: TcxWebStyles read GetTitleStyle write SetTitleStyle;
    property TodayPanelStyle: TcxWebStyles read GetTodayPanelStyle write SetTodayPanelStyle;
    property Width;

    property OnSelectDay: TcxSelectDayEvent read FOnSelectDay write FOnSelectDay;
    property OnNextMonthSelect: TcxChangeMonthEvent read FOnNextMonthSelect write FOnNextMonthSelect;
    property OnPrevMonthSelect: TcxChangeMonthEvent read FOnPrevMonthSelect write FOnPrevMonthSelect;
    property OnValidateDate: TcxValidateDateEvent read FOnValidateDate write FOnValidateDate;
  end;

  TcxCustomWebCalendarRenderer = class(TcxWebControlRenderer)
  private
    function GetCalendarSheet: TcxCalendarSheet;
    function GetWebCalendar: TcxCustomWebCalendar;

    function GetTopBorderColor: TcxWebColor;
    function GetRightBorderColor: TcxWebColor;
    function GetBottomBorderColor: TcxWebColor;
    function GetLeftBorderColor: TcxWebColor;
    function GetSelectionStyleBorderColor: TcxWebColor;
    function GetDayHeaderDefaultStyleShading: TcxWebColor;
    function GetTitleDefaultStyleShadingColor: TcxWebColor;
    function GetTodayPanelDefaultStyleShadingColor: TcxWebColor;
    function GetDayHeaderDefaultStyleBordersTopColor: TcxWebColor;
    function GetDayHeaderDefaultStyleBordersTopWidth: Integer;
    function GetSelectedDefaultStyleBordersWidth: Integer;
    function GetSelectedDefaultStyleShadingColor: TcxWebColor;
    function GetBordersBottomWidth: Integer;
    function GetBordersLeftWidth: Integer;
    function GetBordersRightWidth: Integer;
    function GetBordersTopWidth: Integer;
    function GetShadingColor: TcxWebColor;
    function GetDayHeaderDefaultStyleBordersBottomColor: TcxWebColor;
    function GetDayHeaderDefaultStyleBordersBottomWidth: Integer;
    procedure WriteDayHeaderDefaultStyleFont;
    procedure WriteDefaultStyleFont;
    procedure WriteOtherMonthDayDefaultStyleFont;
    procedure WriteSelectedDefaultStyleFont;
    procedure WriteTitleDefaultStyleFont;
    procedure WriteTodayPanelDefaultStyleFont;

    function HeaderText: string;
  protected
    procedure WriteButtonHint(AButton: TcxMonthButton); virtual;
    procedure WriteButtonAction(AButton: TcxMonthButton); virtual;
    procedure WriteDayAction(AIndex: Integer); virtual;
    procedure WriteButtonImage(AButton: TcxMonthButton); virtual;
    procedure WriteCalendar; virtual;
    procedure WriteCalendarAttributes; virtual;
    procedure WriteCalendarSheet; virtual;
    procedure WriteDayCell(ADayIndex: Integer); virtual;
    procedure WriteDaysOfWeek; virtual;
    procedure WriteHeader; virtual;
    procedure WritePrevMonthButton; virtual;
    procedure WriteNextMonthButton; virtual;
    procedure WriteStartSelectCell; virtual;
    procedure WriteEndSelectCell; virtual;
    procedure WriteStartNoSelectCell; virtual;
    procedure WriteEndNoSelectCell; virtual;
    procedure WriteTodayLink; virtual;
    procedure WriteTodayPanel; virtual;

    function CreationProc: string; virtual;
    function ShiftMonthScriptProc: string; virtual;
    function SelectDayScriptProc: string; virtual;
    function TodayLinkScriptProc: string; virtual;
    function ForcePostBack: Boolean; virtual;

    property CalendarSheet: TcxCalendarSheet read GetCalendarSheet;
  public
    class procedure GetScriptFiles(AList: TStrings); override;
    procedure WriteHiddenFormElements; override;
    procedure WriteHTML; override;
    procedure WriteScripts; override;

    property WebCalendar: TcxCustomWebCalendar read GetWebCalendar;
  end;

  TcxCustomWebCalendarNS4Renderer = class(TcxCustomWebCalendarRenderer)
  protected
    procedure WriteButtonAction(AButton: TcxMonthButton); override;
    procedure WriteDayCell(ADayIndex: Integer); override;
    procedure WriteTodayLink; override;
    function ForcePostBack: Boolean; override;
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
  end;

  TcxCustomWebCalendarOperaRenderer = class(TcxCustomWebCalendarRenderer)
  protected
    function ForcePostBack: Boolean; override;
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
  end;

  TcxWebCalendar = class(TcxCustomWebCalendar)
  published
    property SelectedDate;
  end;

implementation

uses SysUtils, DateUtils,
  {$IFDEF VCL}
  Windows,
  {$ELSE}
  Libc,
  {$ENDIF}
  cxWebConsts;

const
  cxWebCalendarImgs: array[TcxMonthButton] of string =
    (scxcMonthLeftImageName, scxcMonthRightImageName);
  cxWebCalendarImgHints: array[TcxMonthButton] of string =
    ('Prev month', 'Next month');
  cxWebCalendarImgActions: array[TcxMonthButton] of string =
    ('PREVMONTH', 'NEXTMONTH');
  cxWebCalendarImgClientActions: array[TcxMonthButton] of string =
    ('%s(''%s'', -1)', '%s(''%s'', 1)');

  scxMonthIDPostfix = '_c_month'; // Do not localize
  scxSheetIDPostfix = '_c_sheet'; // Do not localize
  scxDayIDPostfix = '_c_day'; // Do not localize
  scxInputName = '__cxwebcalendar_selectedday'; // Do not localize
  scxCtrlDateInputName = '__cxwebcalendar_ctrlday'; // Do not localize

{ TcxCalendarSheet }

constructor TcxCalendarSheet.Create(ACalendar: TcxCustomWebCalendar);
begin
  FCalendar := ACalendar;
  FDays := TStringList.Create;

  StartOfWeek := 7;

  FDate := Calendar.SelectedDate;
  UpdateSheet;
end;

destructor TcxCalendarSheet.Destroy;
begin
  FDays.Free;
end;

function TcxCalendarSheet.IsSelectedDay(Index: Integer): Boolean;
begin
  Result := SameDate(Calendar.SelectedDate, Dates[Index]);
end;

function TcxCalendarSheet.IsOtherMonthDay(Index: Integer): Boolean;
begin
  Result := Boolean(FDays.Objects[Index]);
end;

procedure TcxCalendarSheet.UpdateSheet;
var
  I: Integer;
  StartDay, StartDayOfWeek, EndDay, EndDayOfWeek, DaysInPrevMonth: Word;
begin
  FDays.Clear;
  StartDay := 1;
  EndDay := DaysInAMonth(Year, Month);
  StartDayOfWeek := DayOfTheWeek(EncodeDate(Year, Month, StartDay));
  EndDayOfWeek := DayOfTheWeek(EncodeDate(Year, Month, EndDay));
  if Month - 1 > 0 then
    DaysInPrevMonth := DaysInAMonth(Year, Month - 1)
  else DaysInPrevMonth := DaysInAMonth(Year - 1, 12);

  if StartDayOfWeek > 6 then StartDayOfWeek := 0;
  if StartDayOfWeek <> StartOfWeek then
    for I := 6 downto 0 do
    begin
      if StartDayOfWeek = StartOfWeek then
        FDays.AddObject(IntToStr(DaysInPrevMonth - I), TObject(True))
      else Inc(StartDayOfWeek);
      if StartDayOfWeek > 6 then StartDayOfWeek := 0;
    end;
  for I := StartDay to EndDay do
  begin
    FDays.AddObject(IntToStr(I), TObject(False));
  end;
  if EndDayOfWeek > 6 then EndDayOfWeek := 0;
  if EndDayOfWeek <> EndOfWeek then
    for I := 1 to 7 do
    begin
      FDays.AddObject(IntToStr(I), TObject(True));
      Inc(EndDayOfWeek);
      if EndDayOfWeek > 6 then EndDayOfWeek := 0;
      if EndDayOfWeek = EndOfWeek then break;
    end;
end;

function TcxCalendarSheet.GetDayCount: Integer;
begin
  Result := FDays.Count;
end;

function TcxCalendarSheet.GetDate(Index: Integer): TcxWebDate;
begin
  if IsOtherMonthDay(Index) then
  begin
    if Days[Index] < 7 then
    begin
      if Month + 1 < 13 then
        Result := EncodeDate(Year, Month + 1, Days[Index])
      else Result := EncodeDate(Year + 1, 1, Days[Index])
    end
    else
    begin
      if Month - 1 > 0 then
        Result := EncodeDate(Year, Month - 1, Days[Index])
      else Result := EncodeDate(Year - 1, 12, Days[Index]);        
    end;
  end
  else Result := EncodeDate(Year, Month, Days[Index]);
end;

function TcxCalendarSheet.GetDay(Index: Integer): Integer;
begin
  Result := StrToInt(FDays[Index]);
end;

function TcxCalendarSheet.GetMonth: Word;
begin
  Result := MonthOfTheYear(FDate);
end;

function TcxCalendarSheet.GetYear: Word;
begin
  Result := YearOf(FDate);
end;

procedure TcxCalendarSheet.SetDate(Value: TcxWebDate);
begin
  if FDate <> Value then
  begin
    FDate := Value;
    UpdateSheet;
  end;
end;

procedure TcxCalendarSheet.SetStartOfWeek(Value: Integer);
begin
  if (Value < 0) or (Value > 6) then
  begin
    {$IFDEF MSWINDOWS}
    {$WARN SYMBOL_PLATFORM OFF}
    FStartOfWeek := StrToInt(GetLocaleStr(GetThreadLocale, LOCALE_IFIRSTDAYOFWEEK, '0')) + 1;
    {$WARN SYMBOL_PLATFORM ON}
    {$ENDIF}
    {$IFDEF LINUX}
//    FStartOfWeek := Ord(nl_langinfo(_NL_TIME_FIRST_WEEKDAY)[0]); TODO
    FStartOfWeek := 0;
    {$ENDIF}
    if FStartOfWeek > 6 then
      FStartOfWeek := 0;
  end
  else FStartOfWeek := Value;

  FEndOfWeek := FStartOfWeek - 1;
  if FEndOfWeek < 0 then FEndOfWeek := 6;

  UpdateSheet;
end;

{ TcxWebCalendarEventsHelper }

function TcxWebCalendarEventsHelper.EventName(const AEvent: Integer): string;
const
  cxHTMLEvent: array[TcxWebCalendarEvent] of string = ('OnSelectDay', 'OnShiftMonth');
begin
  Result := cxHTMLEvent[TcxWebCalendarEvent(AEvent)];
end;

function TcxWebCalendarEventsHelper.EventProcParams(const AEvent: Integer): string;
const
  cxHTMLEventProcParams: array[TcxWebCalendarEvent] of string =
    ('(Sender, ADate)', '(Sender, Offset)');
begin
  Result := cxHTMLEventProcParams[TcxWebCalendarEvent(AEvent)];
end;

function TcxWebCalendarEventsHelper.ScriptObject: string;
begin
  Result := '_Calendar';
end;

function TcxWebCalendarEventsHelper.EventTypeInfo: PTypeInfo;
begin
  Result := TypeInfo(TcxWebCalendarEvent);
end;

{ TcxWenCalendar }

constructor TcxCustomWebCalendar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Height := 170;
  Width := 200;
  FSelectedDate := Now;
  FCalendarSheet := TcxCalendarSheet.Create(Self);
  FirstDayOfWeek := dowLocaleDefault;

  FNextMonthText := 'Next';
  FNextMonthImageIndex := -1;
  FPrevMonthText := 'Prev';
  FPrevMonthImageIndex := -1;
  FDayNameFormat := dfFirstTwoLetters;
  FShowYear := True;
end;

destructor TcxCustomWebCalendar.Destroy;
begin
  FDayHeaderStyle.Free;
  FOtherMonthDayStyle.Free;
  FTitleStyle.Free;
  FSelectedStyle.Free;
  FTodayPanelStyle.Free;

  FCalendarSheet.Free;
  inherited Destroy;
end;

function TcxCustomWebCalendar.GetDaysOfWeekNames(Index: Integer): string;
begin
  case DayNameFormat of
  dfFull:
    Result := LongDayNames[Index];
  dfShort:
    Result := ShortDayNames[Index];
  dfFirstLetter:
    Result := Copy(WideString(LongDayNames[Index]), 1, 1);
  dfFirstTwoLetters:
    Result := Copy(WideString(LongDayNames[Index]), 1, 1) + Copy(WideString(LongDayNames[Index]), 2, 1);
  end;

end;

function TcxCustomWebCalendar.GetMonthNames(Index: Integer): string;
begin
  case MonthNameFormat of
  mfFull:
    Result := LongMonthNames[Index];
  mfShort:
    Result := ShortMonthNames[Index];
  end;
end;

procedure TcxCustomWebCalendar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
  if not IsDestroying and (AComponent is TcxWebStyleItem) then
  begin
    if DayHeaderStyle <> nil then
      DayHeaderStyle.Notification(AComponent, Operation);
    if OtherMonthDayStyle <> nil then
      OtherMonthDayStyle.Notification(AComponent, Operation);
    if SelectedStyle <> nil then
      SelectedStyle.Notification(AComponent, Operation);
    if TitleStyle <> nil then
      TitleStyle.Notification(AComponent, Operation);
  end;
end;

procedure TcxCustomWebCalendar.ImplGetProviders(AList: TList);
begin
  inherited ImplGetProviders(AList);
  AddStylesToProviderList(AList, [DayHeaderStyle, OtherMonthDayStyle, SelectedStyle, TitleStyle]);
end;

function TcxCustomWebCalendar.GetMinHeight: Integer;
var
  DayLines: Integer;
begin
  if CalendarSheet <> nil then
    DayLines := CalendarSheet.DayCount
  else DayLines := 5;
  Result := 1 * 20 + 1 * 20 + (DayLines div 7) * 20; // TODO: get height of header, daysofweek and sheet
end;

function TcxCustomWebCalendar.GetMinWidth: Integer;
begin
  Result := 7 * 20; // TODO: get column width
end;

procedure TcxCustomWebCalendar.RegisterActions;
begin
  WebActionsHelper.RegisterAction('', SelectDay);
  WebActionsHelper.RegisterAction('NEXTMONTH', NextMonth);
  WebActionsHelper.RegisterAction('PREVMONTH', PrevMonth);
  WebActionsHelper.RegisterAction('SELECTDAY', SelectDay);
  WebActionsHelper.RegisterAction('TODAY', TodayDate);
end;

function TcxCustomWebCalendar.GetWebEventsHelper: TcxWebCalendarEventsHelper;
begin
  Result := inherited GetWebEventsHelper as TcxWebCalendarEventsHelper;
end;

class function TcxCustomWebCalendar.GetWebEventsHelperClass: TcxWebEventsHelperClass;
begin
  Result := TcxWebCalendarEventsHelper;
end;

procedure TcxCustomWebCalendar.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxCustomWebCalendarRenderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebCalendarNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebCalendarOperaRenderer);
end;

procedure TcxCustomWebCalendar.ScriptsSubscription;
begin
  inherited;
  WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
end;

procedure TcxCustomWebCalendar.SelectDay(const AParameters: TcxActionParameters);
var
  ADate: TcxWebDate;
  AValid: Boolean;
begin
  ADate := WebStringToDate(AParameters.ParamString);
  AValid := True;
  if Assigned(FOnValidateDate) then FOnValidateDate(Self, ADate, AValid);
  if AValid then
  begin
    SelectedDate := ADate;
    if Assigned(FOnSelectDay) then FOnSelectDay(Self, FSelectedDate);
  end;
end;

procedure TcxCustomWebCalendar.TodayDate(const AParameters: TcxActionParameters);
var
  AValid: Boolean;
begin
  AValid := True;
  if Assigned(FOnValidateDate) then FOnValidateDate(Self, Now, AValid);
  if AValid then
  begin
    SelectedDate := Now;
    if Assigned(FOnSelectDay) then FOnSelectDay(Self, FSelectedDate);
  end;
end;

procedure TcxCustomWebCalendar.NextMonth(const AParameters: TcxActionParameters);
begin
  CalendarSheet.Date := IncMonth(CalendarSheet.Date);
  if Assigned(FOnNextMonthSelect) then
    FOnNextMonthSelect(Self, CalendarSheet.Month);
end;

procedure TcxCustomWebCalendar.PrevMonth(const AParameters: TcxActionParameters);
begin
  CalendarSheet.Date := IncMonth(CalendarSheet.Date, -1);
  if Assigned(FOnPrevMonthSelect) then
    FOnPrevMonthSelect(Self, CalendarSheet.Month);
end;

function TcxCustomWebCalendar.DateToWebString(ADate: TcxWebDate): string;
var
  Year, Month, Day: Word;
begin
  DecodeDate(ADate, Year, Month, Day);
  Result := Format('%d:%d:%d', [Year, Month, Day]);
end;

function TcxCustomWebCalendar.WebStringToDate(AString: string): TcxWebDate;
var
  Year, Month, Day: Word;
begin
  try
    Year := StrToInt(GetActionParameter(AString, 0));
    Month := StrToInt(GetActionParameter(AString, 1));
    Day := StrToInt(GetActionParameter(AString, 2));
    Result := EncodeDate(Year, Month, Day);
  except
    Result := 0;
  end;
end;

procedure TcxCustomWebCalendar.DoSetValues;
begin
  SelectedDate := WebStringToDate(WebValuesHelper.Values.Values[Name + scxInputName]);
  CalendarSheet.Date := WebStringToDate(WebValuesHelper.Values.Values[Name + scxCtrlDateInputName]);
end;

procedure TcxCustomWebCalendar.RegisterValues;
begin
  inherited;
  WebValuesHelper.RegisterValue(Name + scxInputName, DateToWebString(SelectedDate));
  WebValuesHelper.RegisterValue(Name + scxCtrlDateInputName, DateToWebString(CalendarSheet.Date));
end;

function TcxCustomWebCalendar.GetDayHeaderStyles: TcxWebStyles;
begin
  if FDayHeaderStyle = nil then
    FDayHeaderStyle := TcxWebStyles.Create(Self);
  Result := FDayHeaderStyle;
end;

procedure TcxCustomWebCalendar.SetDayHeaderStyles(AValue: TcxWebStyles);
begin
  FDayHeaderStyle.Assign(AValue);
end;

procedure TcxCustomWebCalendar.SetDayHeaderAlignment(AValue: TcxWebHorzAlignment);
begin
  if FDayHeaderAlignment <> AValue then
  begin
    FDayHeaderAlignment := AValue;
  end;
end;

procedure TcxCustomWebCalendar.SetDayNameFormat(AValue: TcxWebDayNameFormat);
begin
  if FDayNameFormat <> AValue then
  begin
    FDayNameFormat := AValue;
  end;
end;

procedure TcxCustomWebCalendar.SetFirstDayOfWeek(AValue: TcxFirstDayOfWeek);
begin
  if FFirstDayOfWeek <> AValue then
  begin
    FFirstDayOfWeek := AValue;
    if CalendarSheet <> nil then
      CalendarSheet.StartOfWeek := Integer(AValue);
  end;
end;

procedure TcxCustomWebCalendar.SetImages(Value: TcxWebImageList);
begin
  if FImages <> Value then
  begin
    if Assigned(FImages) then
    begin
      FImages.RemoveFreeNotification(Self);
      FImages.UnregisterClient(Self);
    end;
    FImages := Value;
    if Assigned(FImages) then
    begin
      FImages.RegisterClient(Self);
      FImages.FreeNotification(Self);
    end;
  end;
end;

function TcxCustomWebCalendar.GetOtherMonthDayStyle: TcxWebStyles;
begin
  if FOtherMonthDayStyle = nil then
    FOtherMonthDayStyle := TcxWebStyles.Create(Self);
  Result := FOtherMonthDayStyle;
end;

procedure TcxCustomWebCalendar.SetOtherMonthDayStyle(AValue: TcxWebStyles);
begin
  FOtherMonthDayStyle.Assign(AValue);
end;

function TcxCustomWebCalendar.GetTitleStyle: TcxWebStyles;
begin
  if FTitleStyle = nil then
    FTitleStyle := TcxWebStyles.Create(Self);
  Result := FTitleStyle;
end;

function TcxCustomWebCalendar.GetTodayPanelStyle: TcxWebStyles;
begin
  if FTodayPanelStyle = nil then
    FTodayPanelStyle := TcxWebStyles.Create(Self);
  Result := FTodayPanelStyle;
end;

procedure TcxCustomWebCalendar.SetTitleStyle(AValue: TcxWebStyles);
begin
  FTitleStyle.Assign(AValue);
end;

procedure TcxCustomWebCalendar.SetTodayPanelStyle(AValue: TcxWebStyles);
begin
  FTodayPanelStyle.Assign(AValue);
end;

procedure TcxCustomWebCalendar.SetMonthNameFormat(AValue: TcxWebMonthNameFormat);
begin
  if FMonthNameFormat <> AValue then
  begin
    FMonthNameFormat := AValue;
  end;
end;

function TcxCustomWebCalendar.GetSelectedStyle: TcxWebStyles;
begin
  if FSelectedStyle = nil then
    FSelectedStyle := TcxWebStyles.Create(Self);
  Result := FSelectedStyle;
end;

procedure TcxCustomWebCalendar.SetSelectedStyle(AValue: TcxWebStyles);
begin
  FSelectedStyle.Assign(AValue);
end;

procedure TcxCustomWebCalendar.SetSelectedDate(const Value: TcxWebDate);
begin
  FSelectedDate := Value;
  CalendarSheet.Date := Value;
end;

{ TcxCustomWebCalendarRenderer }

function TcxCustomWebCalendarRenderer.GetCalendarSheet: TcxCalendarSheet;
begin
  Result := WebCalendar.CalendarSheet;
end;

function TcxCustomWebCalendarRenderer.GetWebCalendar: TcxCustomWebCalendar;
begin
  Result := Component as TcxCustomWebCalendar;
end;

function TcxCustomWebCalendarRenderer.GetTopBorderColor: TcxWebColor;
begin
 if (WebCalendar.Styles.Default <> nil) and
   (wbavColor in WebCalendar.Styles.Default.Style.Borders.Top.AssignedValues) then
   Result := WebCalendar.Styles.Default.Style.Borders.Top.Color
 else Result := clWebBlack;
end;

function TcxCustomWebCalendarRenderer.GetRightBorderColor: TcxWebColor;
begin
 if (WebCalendar.Styles.Default <> nil) and
   (wbavColor in WebCalendar.Styles.Default.Style.Borders.Right.AssignedValues)  then
   Result := WebCalendar.Styles.Default.Style.Borders.Right.Color
 else Result := clWebBlack;
end;

function TcxCustomWebCalendarRenderer.GetBottomBorderColor: TcxWebColor;
begin
 if (WebCalendar.Styles.Default <> nil) and
   (wbavColor in WebCalendar.Styles.Default.Style.Borders.Bottom.AssignedValues) then
   Result := WebCalendar.Styles.Default.Style.Borders.Bottom.Color
 else Result := clWebBlack;
end;

function TcxCustomWebCalendarRenderer.GetLeftBorderColor: TcxWebColor;
begin
 if (WebCalendar.Styles.Default <> nil) and
   (wbavColor in WebCalendar.Styles.Default.Style.Borders.Left.AssignedValues) then
   Result := WebCalendar.Styles.Default.Style.Borders.Left.Color
 else Result := clWebBlack;
end;

procedure TcxCustomWebCalendarRenderer.WriteDayHeaderDefaultStyleFont;
begin
  if WebCalendar.DayHeaderStyle.Default <> nil then
    WebCalendar.DayHeaderStyle.Default.Style.Font.WriteHTML(HTMLTextBuilder);
end;

function TcxCustomWebCalendarRenderer.GetSelectionStyleBorderColor: TcxWebColor;
begin
 if (WebCalendar.SelectedStyle.Default <> nil) and
   WebCalendar.SelectedStyle.Default.Style.Borders.SameColors and
   (wbavColor in WebCalendar.SelectedStyle.Default.Style.Borders.Top.AssignedValues) then
   Result := WebCalendar.SelectedStyle.Default.Style.Borders.Color
 else Result := clWebRed;
end;

function TcxCustomWebCalendarRenderer.GetDayHeaderDefaultStyleShading: TcxWebColor;
begin
 if (WebCalendar.DayHeaderStyle.Default <> nil) and
   (wsavColor in WebCalendar.DayHeaderStyle.Default.Style.Shading.AssignedValues) then
   Result := WebCalendar.DayHeaderStyle.Default.Style.Shading.Color
 else Result := clWebGray;
end;

function TcxCustomWebCalendarRenderer.GetTitleDefaultStyleShadingColor: TcxWebColor;
begin
 if (WebCalendar.TitleStyle.Default <> nil) and
   (wsavColor in WebCalendar.TitleStyle.Default.Style.Shading.AssignedValues) then
   Result := WebCalendar.TitleStyle.Default.Style.Shading.Color
 else Result := TcxWebColor($EEEEEE);
end;

function TcxCustomWebCalendarRenderer.GetTodayPanelDefaultStyleShadingColor: TcxWebColor;
begin
 if (WebCalendar.TodayPanelStyle.Default <> nil) and
   (wsavColor in WebCalendar.TodayPanelStyle.Default.Style.Shading.AssignedValues) then
   Result := WebCalendar.TodayPanelStyle.Default.Style.Shading.Color
 else Result := TcxWebColor($EEEEEE);
end;

procedure TcxCustomWebCalendarRenderer.WriteTitleDefaultStyleFont;
begin
  if WebCalendar.TitleStyle.Default <> nil then
    WebCalendar.TitleStyle.Default.Style.Font.WriteHTML(HTMLTextBuilder);
end;

procedure TcxCustomWebCalendarRenderer.WriteTodayPanelDefaultStyleFont;
begin
  if WebCalendar.TodayPanelStyle.Default <> nil then
    WebCalendar.TodayPanelStyle.Default.Style.Font.WriteHTML(HTMLTextBuilder);
end;

function TcxCustomWebCalendarRenderer.GetDayHeaderDefaultStyleBordersTopColor: TcxWebColor;
begin
 if (WebCalendar.DayHeaderStyle.Default <> nil) and
    (wbavColor in WebCalendar.DayHeaderStyle.Default.Style.Borders.Top.AssignedValues) then
   Result := WebCalendar.DayHeaderStyle.Default.Style.Borders.Top.Color
 else Result := clWebLightGrey;
end;

function TcxCustomWebCalendarRenderer.GetDayHeaderDefaultStyleBordersTopWidth: Integer;
begin
 if (WebCalendar.DayHeaderStyle.Default <> nil) and
    (wbavWidth in WebCalendar.DayHeaderStyle.Default.Style.Borders.Top.AssignedValues) then
   Result := WebCalendar.DayHeaderStyle.Default.Style.Borders.Top.Width
 else Result := 1;
end;

procedure TcxCustomWebCalendarRenderer.WriteOtherMonthDayDefaultStyleFont;
begin
  if WebCalendar.OtherMonthDayStyle.Default <> nil then
    WebCalendar.OtherMonthDayStyle.Default.Style.Font.WriteHTML(HTMLTextBuilder);
end;

procedure TcxCustomWebCalendarRenderer.WriteDefaultStyleFont;
begin
  if WebCalendar.Styles.Default <> nil then
    WebCalendar.Styles.Default.Style.Font.WriteHTML(HTMLTextBuilder);
end;

function TcxCustomWebCalendarRenderer.GetSelectedDefaultStyleBordersWidth: Integer;
begin
 if (WebCalendar.SelectedStyle.Default <> nil) and
   WebCalendar.SelectedStyle.Default.Style.Borders.SameWidths and
   (wbavWidth in WebCalendar.SelectedStyle.Default.Style.Borders.Top.AssignedValues) then
   Result := WebCalendar.SelectedStyle.Default.Style.Borders.Width
 else Result := 1;
end;

function TcxCustomWebCalendarRenderer.GetSelectedDefaultStyleShadingColor: TcxWebColor;
begin
 if (WebCalendar.SelectedStyle.Default <> nil) and
   (wsavColor in WebCalendar.SelectedStyle.Default.Style.Shading.AssignedValues) then
   Result := WebCalendar.SelectedStyle.Default.Style.Shading.Color
 else Result := clWebLightGrey;
end;

procedure TcxCustomWebCalendarRenderer.WriteSelectedDefaultStyleFont;
begin
  if WebCalendar.SelectedStyle.Default <> nil then
    WebCalendar.SelectedStyle.Default.Style.Font.WriteHTML(HTMLTextBuilder);
end;

function TcxCustomWebCalendarRenderer.GetBordersBottomWidth: Integer;
begin
 if (WebCalendar.Styles.Default <> nil) and
   (wbavWidth in WebCalendar.Styles.Default.Style.Borders.Bottom.AssignedValues) then
   Result := WebCalendar.Styles.Default.Style.Borders.Bottom.Width
 else Result := 1;
end;

function TcxCustomWebCalendarRenderer.GetBordersLeftWidth: Integer;
begin
 if (WebCalendar.Styles.Default <> nil) and
   (wbavWidth in WebCalendar.Styles.Default.Style.Borders.Left.AssignedValues) then
   Result := WebCalendar.Styles.Default.Style.Borders.Left.Width
 else Result := 1;
end;

function TcxCustomWebCalendarRenderer.GetBordersRightWidth: Integer;
begin
 if (WebCalendar.Styles.Default <> nil) and
   (wbavWidth in WebCalendar.Styles.Default.Style.Borders.Right.AssignedValues) then
   Result := WebCalendar.Styles.Default.Style.Borders.Right.Width
 else Result := 1;
end;

function TcxCustomWebCalendarRenderer.GetBordersTopWidth: Integer;
begin
 if (WebCalendar.Styles.Default <> nil) and
   (wbavWidth in WebCalendar.Styles.Default.Style.Borders.Top.AssignedValues) then
   Result := WebCalendar.Styles.Default.Style.Borders.Top.Width
 else Result := 1;
end;

function TcxCustomWebCalendarRenderer.GetShadingColor: TcxWebColor;
begin
 if (WebCalendar.Styles.Default <> nil) and
   (wsavColor in WebCalendar.Styles.Default.Style.Shading.AssignedValues) then
   Result := WebCalendar.Styles.Default.Style.Shading.Color
 else Result := clWebWhite;
end;

function TcxCustomWebCalendarRenderer.GetDayHeaderDefaultStyleBordersBottomColor: TcxWebColor;
begin
 if (WebCalendar.DayHeaderStyle.Default <> nil) and
   (wbavColor in WebCalendar.DayHeaderStyle.Default.Style.Borders.Bottom.AssignedValues) then
   Result := WebCalendar.DayHeaderStyle.Default.Style.Borders.Bottom.Color
 else Result := clWebGray;
end;

function TcxCustomWebCalendarRenderer.GetDayHeaderDefaultStyleBordersBottomWidth: Integer;
begin
 if (WebCalendar.DayHeaderStyle.Default <> nil) and
   (wbavWidth in WebCalendar.DayHeaderStyle.Default.Style.Borders.Bottom.AssignedValues) then
   Result := WebCalendar.DayHeaderStyle.Default.Style.Borders.Bottom.Width
 else Result := 1;
end;

procedure TcxCustomWebCalendarRenderer.WriteHTML;
begin
  WriteCalendar;
end;

class procedure TcxCustomWebCalendarRenderer.GetScriptFiles(AList: TStrings);
begin
  AList.Add(scxCommonScriptName);
  AList.Add(scxCalendarScriptName);
end;

procedure TcxCustomWebCalendarRenderer.WriteHiddenFormElements;
begin
  WriteHiddenField(WebCalendar.Name + scxInputName,
      WebCalendar.DateToWebString(WebCalendar.SelectedDate));
  WriteHiddenField(WebCalendar.Name + scxCtrlDateInputName,
      WebCalendar.DateToWebString(WebCalendar.CalendarSheet.Date));
end;

procedure TcxCustomWebCalendarRenderer.WriteScripts;
var
  I: Integer;
  Year, Month, Day: Word;
  AMonthes: string;
begin
  WriteEventsScript;
  for I := 1 to 12 do
  begin
    AMonthes := AMonthes + Format('"%s"', [WebCalendar.MonthNames[I]]);
    if I <> 12 then AMonthes := AMonthes + ', ';
  end;
  AMonthes := Format('[%s]', [AMonthes]);
  DecodeDate(WebCalendar.CalendarSheet.Date, Year, Month, Day);
  HTMLTextBuilder.WriteText(Format('var ctrlDate = new Date(%d, %d, %d);', [Year, Month - 1, Day]));
  DecodeDate(WebCalendar.SelectedDate, Year, Month, Day);
  HTMLTextBuilder.WriteText(Format('var selDate = new Date(%d, %d, %d);', [Year, Month - 1, Day]));
  HTMLTextBuilder.WriteText(Format('var _Calendar = %s();', [CreationProc]));
  HTMLTextBuilder.WriteText(Format('  _Calendar.Name = "%s";', [WebCalendar.Name]));
  HTMLTextBuilder.WriteText('  _Calendar.Date = new Date(ctrlDate);');
  HTMLTextBuilder.WriteText('  _Calendar.SelectedDate = new Date(selDate);');
  if not ForcePostBack then
  begin
    if not (Assigned(WebCalendar.OnSelectDay) or Assigned(WebCalendar.FOnValidateDate)) then
      HTMLTextBuilder.WriteText('  _Calendar.AssignOnSelectDay = false;');
    if not Assigned(WebCalendar.OnNextMonthSelect) then
      HTMLTextBuilder.WriteText('  _Calendar.AssignOnNextMonth = false;');
    if not Assigned(WebCalendar.OnPrevMonthSelect) then
      HTMLTextBuilder.WriteText('  _Calendar.AssignOnPrevMonth = false;');
    HTMLTextBuilder.WriteText(Format('  _Calendar.WeekStart = %d;', [CalendarSheet.StartOfWeek]));
    HTMLTextBuilder.WriteText(Format('  _Calendar.WeekEnd = %d;', [CalendarSheet.EndOfWeek]));
    HTMLTextBuilder.WriteText(Format('  _Calendar.Monthes = %s;', [AMonthes]));
    HTMLTextBuilder.WriteText(Format('  _Calendar.Painter.MonthIDPostfix = "%s";', [scxMonthIDPostfix]));
    HTMLTextBuilder.WriteText(Format('  _Calendar.Painter.SheetIDPostfix = "%s";', [scxSheetIDPostfix]));
    HTMLTextBuilder.WriteText(Format('  _Calendar.Painter.DayIDPostfix = "%s";', [scxDayIDPostfix]));
    HTMLTextBuilder.DisableValidation := True;
    HTMLTextBuilder.WriteText('  _Calendar.Painter.StartSheet = ''', True, False);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable, False, False);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    HTMLTextBuilder.WriteAttribute(aCellpadding, WebCalendar.CellPadding);
    HTMLTextBuilder.WriteAttribute(aCellspacing, WebCalendar.CellSpacing);
    HTMLTextBuilder.WriteAttribute(aWidth, '100%');
    HTMLTextBuilder.WriteText(''';', False, True);
    HTMLTextBuilder.WriteText('  _Calendar.Painter.StartSelect = ''', True, False);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable, False, False);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(GetSelectionStyleBorderColor));
    HTMLTextBuilder.WriteAttribute(aCellpadding, GetSelectedDefaultStyleBordersWidth);
    HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
    HTMLTextBuilder.WriteAttribute(aWidth, '100%');
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, False, False);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
    HTMLTextBuilder.WriteAttribute(aAlign, 'center');
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable, False, False);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    HTMLTextBuilder.WriteAttribute(aBgcolor, 'white');
    HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
    HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
    HTMLTextBuilder.WriteAttribute(aWidth, '100%');
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, False, False);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
    HTMLTextBuilder.WriteAttribute(aAlign, 'center');
    HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(GetSelectedDefaultStyleShadingColor));
    HTMLTextBuilder.WriteAttribute(aStyle, '');
    WriteSelectedDefaultStyleFont;
    HTMLTextBuilder.WriteText(''';', False, True);
    HTMLTextBuilder.WriteText('  _Calendar.Painter.DayStyleHTML = ''', True, False);
    WriteDefaultStyleFont;
    HTMLTextBuilder.WriteText(''';', False, True);
    HTMLTextBuilder.WriteText('  _Calendar.Painter.DayOtherStyleHTML = ''', True, False);
    WriteOtherMonthDayDefaultStyleFont;
    HTMLTextBuilder.WriteText(''';', False, True);
    HTMLTextBuilder.DisableValidation := False;
    HTMLTextBuilder.WriteText(Format('  _Calendar.SelectDateProc = "%s";', [SelectDayScriptProc]));
    HTMLTextBuilder.WriteText(Format('  _Calendar.ShiftMonthProc = "%s";', [ShiftMonthScriptProc]));
    HTMLTextBuilder.WriteText(Format('  _Calendar.DateFormat = "%s";', [ShortDateFormat]));
    HTMLTextBuilder.WriteText(Format('  _Calendar.DateSeparator = "%s";', [DateSeparator]));
    HTMLTextBuilder.WriteText(Format('  _Calendar.ShowYear = %s;', [cxWebUtils.BoolToStr(WebCalendar.ShowYear)]));
    HTMLTextBuilder.WriteText('  _Calendar.FillSheet();');
  end;
  WriteEvents;
end;

procedure TcxCustomWebCalendarRenderer.WriteDaysOfWeek;
var
  I, DayIndex: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, WebCalendar.CellPadding);
  HTMLTextBuilder.WriteAttribute(aCellspacing, WebCalendar.CellSpacing);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(GetDayHeaderDefaultStyleShading));
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);

  DayIndex := CalendarSheet.StartOfWeek + 1;
  for I := 1 to 7 do
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
    HTMLTextBuilder.WriteAttribute(aAlign, cxWebHorzAlignment[WebCalendar.DayHeaderAlignment]);
    WriteDayHeaderDefaultStyleFont;
    HTMLTextBuilder.WriteText(WebCalendar.DaysOfWeekNames[DayIndex], False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
    Inc(DayIndex);
    if DayIndex > 7 then Dec(DayIndex, 7);
  end;

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
end;

procedure TcxCustomWebCalendarRenderer.WriteStartSelectCell;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(GetSelectionStyleBorderColor));
  HTMLTextBuilder.WriteAttribute(aCellpadding, GetSelectedDefaultStyleBordersWidth);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'white');
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(GetSelectedDefaultStyleShadingColor));
  WriteSelectedDefaultStyleFont;
end;

procedure TcxCustomWebCalendarRenderer.WriteButtonHint(AButton: TcxMonthButton);
begin
  HTMLTextBuilder.WriteAttribute(aAlt, cxWebCalendarImgHints[AButton]);
  if WebCalendar.ShowHint then
    HTMLTextBuilder.WriteAttribute(aTitle, cxWebCalendarImgHints[AButton]);
end;

procedure TcxCustomWebCalendarRenderer.WriteButtonAction(AButton: TcxMonthButton);
begin
  if ForcePostBack then
    HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:__doPostBack(''%s'', ''%s'');',
        [WebCalendar.Name, cxWebCalendarImgActions[AButton]]))
  else HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:' + cxWebCalendarImgClientActions[AButton],
    [ShiftMonthScriptProc, WebCalendar.Name]));
end;

procedure TcxCustomWebCalendarRenderer.WriteDayAction(AIndex: Integer);
begin
  if ForcePostBack then
    HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:__doPostBack(''%s'', ''SELECTDAY:%s'')',
        [WebCalendar.Name, WebCalendar.DateToWebString(CalendarSheet.Dates[AIndex])]))
  else
   HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:%s(''%s'', %u)',
        [SelectDayScriptProc, WebCalendar.Name, AIndex]));
end;

procedure TcxCustomWebCalendarRenderer.WriteButtonImage(AButton: TcxMonthButton);
begin
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
  HTMLTextBuilder.WriteAttribute(aSrc, QualifyImageFileName(cxWebCalendarImgs[AButton]));
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  WriteButtonHint(AButton);
end;

procedure TcxCustomWebCalendarRenderer.WriteCalendar;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  WriteCalendarAttributes;
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aWidth, WebCalendar.Width);
  

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(GetTopBorderColor));
  HTMLTextBuilder.WriteAttribute(aColspan, 3);
  WriteInvisibleImage(WebCalendar.Height, GetBordersTopWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(GetLeftBorderColor));
  WriteInvisibleImage(GetBordersLeftWidth, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(GetShadingColor));
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');

  WriteHeader;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, 3000);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');

  WriteDaysOfWeek;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor,
      cxWebColorToWebString(GetDayHeaderDefaultStyleBordersBottomColor));
  WriteInvisibleImage(1, GetDayHeaderDefaultStyleBordersBottomWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);

  WriteCalendarSheet;
  WriteTodayPanel;

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(GetRightBorderColor));
  WriteInvisibleImage(GetBordersRightWidth, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(GetBottomBorderColor));
  HTMLTextBuilder.WriteAttribute(aColspan, 3);
  WriteInvisibleImage(1, GetBordersBottomWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxCustomWebCalendarRenderer.WriteCalendarAttributes;
begin
  WriteID;
  WriteHint;
  WritePopupMenu;
  WriteAttributes;
  WritePosition;
  WriteZIndex;
  WriteAttributes;
  WriteStyleAttributes;
end;

procedure TcxCustomWebCalendarRenderer.WriteCalendarSheet;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aId, WebCalendar.Name + scxSheetIDPostfix);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, WebCalendar.CellPadding);
  HTMLTextBuilder.WriteAttribute(aCellspacing, WebCalendar.CellSpacing);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  for I := 0 to WebCalendar.CalendarSheet.DayCount - 1 do
  begin
    if (I mod 7) = 0 then
      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
    WriteDayCell(I);
    if (I + 1) mod 7 = 0 then
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
end;

procedure TcxCustomWebCalendarRenderer.WriteHeader;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(GetTitleDefaultStyleShadingColor));
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteTitleDefaultStyleFont;
  WritePrevMonthButton;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aId, WebCalendar.Name + scxMonthIDPostfix);
  WriteTitleDefaultStyleFont;
  HTMLTextBuilder.WriteText(HeaderText, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aAlign, 'right');
  WriteTitleDefaultStyleFont;
  WriteNextMonthButton;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(GetDayHeaderDefaultStyleBordersTopColor));
  WriteInvisibleImage(1, GetDayHeaderDefaultStyleBordersTopWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
end;

procedure TcxCustomWebCalendarRenderer.WriteDayCell(ADayIndex: Integer);

  procedure WriteDayTitle;
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
    if CalendarSheet.IsOtherMonthDay(ADayIndex) then
      WriteOtherMonthDayDefaultStyleFont
    else WriteDefaultStyleFont;
    WriteDayAction(ADayIndex);
    HTMLTextBuilder.WriteText(IntToStr(DayOf(CalendarSheet.Dates[ADayIndex])), False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);
  end;

begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aId, WebCalendar.Name + scxDayIDPostfix + IntToStr(ADayIndex));
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aWidth, 3000);

  if CalendarSheet.IsSelectedDay(ADayIndex) then
  begin
    WriteStartSelectCell;
    WriteDayTitle;
    WriteEndSelectCell;
  end
  else
  begin
    WriteStartNoSelectCell;
    WriteDayTitle;
    WriteEndNoSelectCell;
  end;

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
end;

procedure TcxCustomWebCalendarRenderer.WriteEndSelectCell;
begin
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxCustomWebCalendarRenderer.WriteStartNoSelectCell;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aCellpadding, GetSelectedDefaultStyleBordersWidth);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
end;

procedure TcxCustomWebCalendarRenderer.WriteEndNoSelectCell;
begin
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxCustomWebCalendarRenderer.WriteTodayLink;
begin
  if ForcePostBack then
    HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:__doPostBack(''%s'', ''TODAY'')',
      [WebCalendar.Name]))
  else HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:%s(''%s'')',
    [TodayLinkScriptProc, WebCalendar.Name]));
end;

procedure TcxCustomWebCalendarRenderer.WriteTodayPanel;
begin
  if WebCalendar.ShowTodayLink then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
    HTMLTextBuilder.WriteAttribute(aAlign, 'center');
    HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(GetTodayPanelDefaultStyleShadingColor));
    WriteTodayPanelDefaultStyleFont;
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA);
    WriteTodayPanelDefaultStyleFont;
    WriteTodayLink;
    HTMLTextBuilder.WriteText('Today', False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagA);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  end;
end;

function TcxCustomWebCalendarRenderer.CreationProc: string;
begin
  Result := 'CreateCalendar';
end;

function TcxCustomWebCalendarRenderer.ShiftMonthScriptProc: string;
begin
  Result := 'CalendarShiftMonth'
end;

function TcxCustomWebCalendarRenderer.SelectDayScriptProc: string;
begin
  Result := 'CalendarSelectDay';
end;

function TcxCustomWebCalendarRenderer.TodayLinkScriptProc: string;
begin
  Result := 'CalendarSelectToday';
end;

function TcxCustomWebCalendarRenderer.ForcePostBack: Boolean;
begin
  Result := WebCalendar.ForcePostBack;
end;

procedure TcxCustomWebCalendarRenderer.WritePrevMonthButton;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
  WriteTitleDefaultStyleFont;
  WriteButtonAction(mbPrev);

  if WebCalendar.ShowMonthPictures then
  begin
    if (WebCalendar.Images <> nil) and WebCalendar.Images.ValidIndex(WebCalendar.PrevMonthImageIndex) then
      WebCalendar.Images.Images[WebCalendar.PrevMonthImageIndex].WriteHTML(HTMLTextBuilder)
    else WriteButtonImage(mbPrev);
  end
  else HTMLTextBuilder.WriteText(WebCalendar.PrevMonthText, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);
end;

procedure TcxCustomWebCalendarRenderer.WriteNextMonthButton;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
  WriteTitleDefaultStyleFont;
  WriteButtonAction(mbNext);

  if WebCalendar.ShowMonthPictures then
  begin
    if (WebCalendar.Images <> nil) and WebCalendar.Images.ValidIndex(WebCalendar.NextMonthImageIndex) then
      WebCalendar.Images.Images[WebCalendar.NextMonthImageIndex].WriteHTML(HTMLTextBuilder)
    else WriteButtonImage(mbNext);
  end
  else HTMLTextBuilder.WriteText(WebCalendar.NextMonthText, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);
end;

function TcxCustomWebCalendarRenderer.HeaderText: string;
begin
  Result := WebCalendar.MonthNames[CalendarSheet.Month];
  if WebCalendar.ShowYear then
    Result := Result + '&nbsp;' + IntToStr(CalendarSheet.Year);
end;

{ TcxCustomWebCalendarNS4Renderer }

procedure TcxCustomWebCalendarNS4Renderer.WriteButtonAction(AButton: TcxMonthButton);
begin
  HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:__doPostBack(''%s'', ''%s'');',
        [WebCalendar.Name, cxWebCalendarImgActions[AButton]]));
end;

procedure TcxCustomWebCalendarNS4Renderer.WriteDayCell(ADayIndex: Integer);

  procedure WriteDayTitle;
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, True, False);
    HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:__doPostBack(''%s'', ''SELECTDAY:%s'')',
        [WebCalendar.Name, WebCalendar.DateToWebString(CalendarSheet.Dates[ADayIndex])]));
    HTMLTextBuilder.WriteText(IntToStr(DayOf(CalendarSheet.Dates[ADayIndex])), False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, True);
  end;

begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aId, WebCalendar.Name + scxDayIDPostfix + IntToStr(ADayIndex));

  if CalendarSheet.IsSelectedDay(ADayIndex) then
  begin
    WriteStartSelectCell;
    WriteDayTitle;
    WriteEndSelectCell;
  end
  else WriteDayTitle;

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
end;

procedure TcxCustomWebCalendarNS4Renderer.WriteTodayLink;
begin
  HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:__doPostBack(''%s'', ''TODAY'')',
    [WebCalendar.Name]));
end;

function TcxCustomWebCalendarNS4Renderer.ForcePostBack: Boolean;
begin
  Result := True;
end;

class function TcxCustomWebCalendarNS4Renderer.IsBrowserSupported(
  AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS4;
end;

{ TcxCustomWebCalendarOperaRenderer }

function TcxCustomWebCalendarOperaRenderer.ForcePostBack: Boolean;
begin
  Result := True;
end;

class function TcxCustomWebCalendarOperaRenderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserOpera;
end;

initialization
  RegisterClasses([TcxWebCalendar]);

end.
