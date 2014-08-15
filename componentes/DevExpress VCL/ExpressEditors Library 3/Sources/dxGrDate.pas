
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express popup date edit                                     }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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

unit dxGrDate;

interface

{$I dxEdVer.inc}

uses
  Windows, Messages, Classes, Controls, Graphics, Forms, dxCntner;

var
  sdxGridDatePopupToday: string;  //'Today'
  sdxGridDatePopupClear: string;  //'Clear'

type
  TDayOfWeek = 0..6;
  TDay = (dSunday, dMonday, dTuesday, dWednesday, dThursday, dFriday, dSaturday);
  TDays = set of TDay;

  TCustomdxCalendar = class(TdxInplacePopupControl)
  private
    FDragDate: TDateTime;
    FFlat: Boolean;
    FFirstDate: TDateTime;
    FSelStart: TDateTime;
    FSelFinish: TDateTime;

    FOnDateTimeChanged: TNotifyEvent;

    procedure SetFlat(Value: Boolean);

    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
    function GetRealFirstDate: TDateTime; virtual;
    function GetRealLastDate: TDateTime; virtual;
    function GetLastDate: TDateTime; virtual; abstract;
    function GetSelStart: TDateTime; virtual;
    function GetSelFinish: TDateTime; virtual;
    procedure SetFirstDate(Value: TDateTime); virtual;
    procedure SetSelStart(Value: TDateTime); virtual;
    procedure SetSelFinish(Value: TDateTime); virtual;

    procedure CheckFirstDate; virtual; abstract;
    procedure DoDateTimeChanged; dynamic;
    procedure DoInternalSelectPeriod(ADate: TDateTime);
    function PosToDateTime(P: TPoint): TDateTime; virtual; abstract;

    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    property RealFirstDate: TDateTime read GetRealFirstDate;
    property RealLastDate: TDateTime read GetRealLastDate;
  public
    constructor Create(AOwner: TComponent); override;

    property Flat: Boolean read FFlat write SetFlat default True;
    property FirstDate: TDateTime read FFirstDate write SetFirstDate;
    property LastDate: TDateTime read GetLastDate;
    property SelStart: TDateTime read GetSelStart write SetSelStart;
    property SelFinish: TDateTime read GetSelFinish write SetSelFinish;
    property OnDateTimeChanged: TNotifyEvent read FOnDateTimeChanged
      write FOnDateTimeChanged;
  end;

  TdxGridDatePopup = class(TCustomdxCalendar)
  private
    FColCount: Integer;
    FRowCount: Integer;
    FColWidth, FSideWidth,
      FRowHeight, FHeaderHeight, FDaysOfWeekHeight: Integer;
    FTodayButtonWidth, FClearButtonWidth, FButtonsOffset, FButtonsHeight,
      FButtonsRegionHeight: Integer;
    FListBox: TWinControl;
    FListBoxDelta: Integer;
    FTimer: UINT;
    FTodayButtonActive, FTodayButtonPressed: Boolean;
    FClearButtonActive, FClearButtonPressed: Boolean;

    procedure CheckSelection(MarginDate: TDateTime);
    function ColOfDate(ADate: TDateTime): Integer;
    function GetHeaderRect: TRect;
    function GetInternalRect: TRect;
    function GetLeftArrowRect: TRect;
    function GetRightArrowRect: TRect;
    function GetMonthNameRect: TRect;
    function GetTodayButtonRect: TRect;
    function GetClearButtonRect: TRect;
    function GetShowButtonsArea: Boolean;
    procedure FreeTimer;
    procedure RepaintTodayButton;
    procedure RepaintClearButton;

    procedure WMDestroy(var Message: TMessage); message WM_DESTROY;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
    function GetRealFirstDate: TDateTime; override;
    function GetRealLastDate: TDateTime; override;
    function GetLastDate: TDateTime; override;
    procedure SetFirstDate(Value: TDateTime); override;
    procedure SetSelFinish(Value: TDateTime); override;
    procedure StepToPast;
    procedure StepToFuture;
    procedure CheckFirstDate; override;
    function PosToDateTime(P: TPoint): TDateTime; override;

    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint; override;

    property ColCount: Integer read FColCount;
    property RowCount: Integer read FRowCount;
    property ShowButtonsArea: Boolean read GetShowButtonsArea;
  public
    ShowTodayButton, ShowClearButton: Boolean;
    constructor Create(AOwner: TComponent); override;
    procedure HidePopup(ByMouse: Boolean); override;
    procedure SetSize;
    function GetWidth: Integer;
    function GetHeight: Integer;
    property Font;
  end;

var
  // first day of week
  StartOfWeek: TDayOfWeek;

const
  NullDate = -700000;

function DateOf(ADateTime: TDateTime): Integer;
function TimeOf(ADateTime: TDateTime): TDateTime;
procedure RetrieveStartOfWeek;

implementation

uses
  SysUtils, Buttons, dxEdStr;

const
  ADateNavigatorTime = 170;

procedure RetrieveStartOfWeek;
begin
  {$IFDEF DELPHI6}
    {$IFDEF MSWINDOWS}
      {$WARN SYMBOL_PLATFORM OFF}
    {$ENDIF}
  {$ENDIF}
  StartOfWeek := StrToInt(GetLocaleStr(GetThreadLocale, LOCALE_IFIRSTDAYOFWEEK, '0')) + 1;
  {$IFDEF DELPHI6}
    {$IFDEF MSWINDOWS}
      {$WARN SYMBOL_PLATFORM ON}
    {$ENDIF}
  {$ENDIF}
  if StartOfWeek > 6 then StartOfWeek := 0;
end;

procedure DecMonth(var AYear, AMonth: Word);
begin
  if AMonth = 1 then
  begin
    Dec(AYear);
    AMonth := 12;
  end
  else Dec(AMonth);
end;

procedure IncMonth(var AYear, AMonth: Word);
begin
  if AMonth = 12 then
  begin
    Inc(AYear);
    AMonth := 1;
  end
  else Inc(AMonth);
end;

procedure ChangeMonth(var AYear, AMonth: Word; Delta: Integer);
var
  Month: Integer;
begin
  Inc(AYear, Delta div 12);
  Month := AMonth;
  Inc(Month, Delta mod 12);
  if Month < 1 then
  begin
    Dec(AYear);
    Month := 12 + Month;
  end;
  if Month > 12 then
  begin
    Inc(AYear);
    Month := Month - 12;
  end;
  AMonth := Month;
end;

function GetDateElement(ADate: TDateTime; Index: Integer): Integer;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(ADate, AYear, AMonth, ADay);
  case Index of
    1: Result := AYear;
    2: Result := AMonth;
    3: Result := ADay;
    else Result := -1;
  end;
end;

function IsLeapYear(AYear: Integer): Boolean;
begin
  Result := (AYear mod 4 = 0) and ((AYear mod 100 <> 0) or (AYear mod 400 = 0));
end;

function DaysPerMonth(AYear, AMonth: Integer): Integer;
const
  DaysInMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result := DaysInMonth[AMonth];
  if (AMonth = 2) and IsLeapYear(AYear) then Inc(Result);
end;

function CheckDay(AYear, AMonth, ADay: Integer): Integer;
begin
  if ADay < 1 then Result := 1
  else
    if ADay > DaysPerMonth(AYear, AMonth) then
      Result := DaysPerMonth(AYear, AMonth)
    else Result := ADay;
end;

function DateOf(ADateTime: TDateTime): Integer;
begin
  Result := Trunc(ADateTime + (2 * Byte(ADateTime >= 0) - 1) * 1E-11);
end;

function TimeOf(ADateTime: TDateTime): TDateTime;
var
  Hour, Min, Sec, MSec: Word;
begin
  DecodeTime(ADateTime, Hour, Min, Sec, MSec);
  Result := EncodeTime(Hour, Min, Sec, MSec);
end;

{ TAMonthListBox }

type
  TAMonthListBox = class(TCustomControl)
  private
    FTopDate: TDateTime;
    FItemHeight: Integer;
    FItemIndex: Integer;
    FItems: TStrings;
    FTimer: UINT;
    FTimerId: UINT;

    procedure FreeTimer;

    function GetDate: TDateTime;
    procedure SetItemIndex(Value: Integer);
    procedure SetTopDate(Value: TDateTime);

    procedure WMDestroy(var Message: TMessage); message WM_DESTROY;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;

    property ItemHeight: Integer read FItemHeight;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property Items: TStrings read FItems;
    property TopDate: TDateTime read FTopDate write SetTopDate;
  public
    constructor Create(AOwner: TComponent); override;

    property Date: TDateTime read GetDate;
  end;

constructor TAMonthListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTopDate := NullDate;
end;

procedure TAMonthListBox.FreeTimer;
begin
  if FTimer > 0 then
  begin
    KillTimer(Handle, FTimerId);
    FTimer := 0;
  end;
end;

function TAMonthListBox.GetDate: TDateTime;
var
  Year, Month, Day: Word;
begin
  if ItemIndex = -1 then Result := NullDate
  else
  begin
    DecodeDate(TopDate, Year, Month, Day);
    ChangeMonth(Year, Month, ItemIndex);
    Result := EncodeDate(Year, Month, 1);
  end;  
end;

procedure TAMonthListBox.SetItemIndex(Value: Integer);
var
  PrevItemIndex: Integer;

  procedure InvalidateItemRect(Index: Integer);
  var
    R: TRect;
  begin
    if Index = -1 then Exit;
    with R do
    begin
      Left := 0;
      Top := Index * ItemHeight;
      Right := ClientWidth;
      Bottom := Top + ItemHeight;
    end;
    InvalidateRect(Handle, @R, False);
  end;

begin
  if FItemIndex <> Value then
  begin
    PrevItemIndex := FItemIndex;
    FItemIndex := Value;
    InvalidateItemRect(PrevItemIndex);
    InvalidateItemRect(FItemIndex);
  end;
end;

procedure TAMonthListBox.SetTopDate(Value: TDateTime);
begin
  if FTopDate <> Value then
  begin
    FTopDate := Value;
    Repaint;
  end;
end;

procedure TAMonthListBox.WMDestroy(var Message: TMessage);
begin
  FreeTimer;
  inherited;
end;

procedure TAMonthListBox.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TAMonthListBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Canvas.Font.Assign(Font);
  with TdxGridDatePopup(Parent) do
  begin
    FItemHeight := FHeaderHeight - 2;
    Self.Width := 2 * GetSystemMetrics(SM_CXBORDER) + 6 * FColWidth;
    Self.Height := 2 * GetSystemMetrics(SM_CYBORDER) + 7 * ItemHeight;
  end;
end;

procedure TAMonthListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP or WS_BORDER;
    ExStyle := WS_EX_TOPMOST;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
  end;
end;

procedure AMonthListBoxTimerProc(Wnd: HWND; Msg: UINT; idEvent: UINT;
  Time: DWORD); stdcall;
var
  AControl: TAMonthListBox;
  Year, Month, Day: Word;
begin
  AControl := TAMonthListBox(FindControl(Wnd));
  with AControl do
  begin
    DecodeDate(TopDate, Year, Month, Day);
    ChangeMonth(Year, Month, 2 * Integer(idEvent > 5) - 1);
    TopDate := EncodeDate(Year, Month, 1);
  end;
end;

procedure TAMonthListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
const
  Times: array[1..4] of UINT = (500, 250, 100, 50);
var
  Delta, Sign: Integer;
  NewTimerId: UINT;
begin
  if PtInRect(ClientRect, Point(X, Y)) then
  begin
    FreeTimer;
    ItemIndex := Y div ItemHeight;
  end
  else
  begin
    ItemIndex := -1;
    if Y < 0 then Delta := Y
    else
      if Y >= ClientHeight then
        Delta := 1 + Y - ClientHeight
      else Exit;
    Sign := Delta div Abs(Delta);
    NewTimerId := Sign + Delta div 12;
    if Abs(NewTimerId) > 4 then
      NewTimerId := Sign * 4;
    NewTimerId := NewTimerId + 5;
    if (FTimer = 0) or (NewTimerId <> FTimerId) then
    begin
      FreeTimer;
      FTimerId := NewTimerId;
      FTimer := SetTimer(Handle, FTimerId, Times[Abs(FTimerId - 5)],
        @AMonthListBoxTimerProc);
    end;
  end;    
end;

procedure TAMonthListBox.Paint;
const
  Colors: array[Boolean] of TColor = (clWindow, clWindowText);
var
  I: Integer;
  Year, Month, Day: Word;
  Selected: Boolean;
  Rect: TRect;
  S: string;
begin
  DecodeDate(TopDate, Year, Month, Day);
  with Rect do
  begin
    Left := 0;
    Top := 0;
    Right := ClientWidth;
    Bottom := ItemHeight;
  end;
  for I := 0 to 6 do
  begin
    Selected := I = ItemIndex;
    with Canvas do
    begin
      Font.Color := Colors[not Selected];
      Brush.Color := Colors[Selected];
      Windows.FillRect(Handle, Rect, Brush.Handle);
      S := LongMonthNames[Month] + ' ' + IntToStr(Year);
      DrawText(Handle, PChar(S), Length(S), Rect,
        DT_SINGLELINE or DT_NOCLIP or DT_CENTER or DT_VCENTER);
    end;
    IncMonth(Year, Month);
    OffsetRect(Rect, 0, ItemHeight);
  end;
end;

{ TCustomdxCalendar }

constructor TCustomdxCalendar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csDoubleClicks];
  FFlat := True;
  FFirstDate := Date;
  FSelStart := FFirstDate;
  FSelFinish := FSelStart;
end;

procedure TCustomdxCalendar.SetFlat(Value: Boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    RecreateWnd;
  end;
end;

procedure TCustomdxCalendar.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

function TCustomdxCalendar.GetRealFirstDate: TDateTime;
begin
  Result := FirstDate;
end;

function TCustomdxCalendar.GetRealLastDate: TDateTime;
begin
  Result := LastDate;
end;

function TCustomdxCalendar.GetSelStart: TDateTime;
begin
  if (FSelStart < FSelFinish) or (FSelFinish = NullDate) then Result := FSelStart
  else Result := FSelFinish;
end;

function TCustomdxCalendar.GetSelFinish: TDateTime;
begin
  if FSelStart < FSelFinish then Result := FSelFinish
  else Result := FSelStart;
end;

procedure TCustomdxCalendar.SetFirstDate(Value: TDateTime);
begin
  if FFirstDate <> Value then
  begin
    FFirstDate := Value;
  end;
end;

procedure TCustomdxCalendar.SetSelStart(Value: TDateTime);
begin
  FSelStart := Value;
  FSelFinish := NullDate;
  SelFinish := Value;
end;

procedure TCustomdxCalendar.SetSelFinish(Value: TDateTime);
var
  OldSelFinish: TDateTime;
begin
  if FSelFinish <> Value then
  begin
    CheckFirstDate;
    OldSelFinish := FSelFinish;
    FSelFinish := Value;
    if FSelFinish <> OldSelFinish then
    begin
      CheckFirstDate;
      Repaint;
    end;
  end;
end;

procedure TCustomdxCalendar.DoDateTimeChanged;
begin
  if Assigned(FOnDateTimeChanged) then FOnDateTimeChanged(Self);
end;

procedure TCustomdxCalendar.DoInternalSelectPeriod(ADate: TDateTime);
var
  PrevSelFinish: TDateTime;
begin
  if (SelFinish <> ADate) and (ADate <> NullDate) then
  begin
    PrevSelFinish := FSelFinish;
    SelFinish := ADate;
    if FSelFinish = PrevSelFinish then Repaint;
  end;  
end;

procedure TCustomdxCalendar.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    Style := Style or WS_CLIPCHILDREN;
end;

procedure TCustomdxCalendar.CreateWnd;
begin
  inherited CreateWnd;
  SendMessage(Handle, CM_FONTCHANGED, 0, 0);
end;

procedure TCustomdxCalendar.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ADate: TDateTime;
begin
  if ssDouble in Shift then Exit;
  inherited MouseDown(Button, Shift, X, Y);
  ADate := PosToDateTime(Point(X, Y));
  if Button = mbLeft then
  begin
    FDragDate := SelStart;
    if ADate <> NullDate then SelStart := ADate;
  end;  
end;

procedure TCustomdxCalendar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ADate: TDateTime;
begin
  ADate := NullDate;
  if ssLeft in Shift then
    ADate := PosToDateTime(Point(X, Y));
  inherited MouseMove(Shift, X, Y);
  if ssLeft in Shift then
    if ADate <> NullDate then SelFinish := ADate
    else
      if not PtInRect(ClientRect, Point(X, Y)) then
        DoInternalSelectPeriod(FDragDate);
  Update;
end;

procedure TCustomdxCalendar.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if not (ssDouble in Shift) and PtInRect(ClientRect, Point(X, Y)) then
    DoDateTimeChanged;
end;

{ TdxGridDatePopup }

constructor TdxGridDatePopup.Create(AOwner: TComponent);
var
  Year, Month, Day: Word;
begin
  inherited Create(AOwner);
  DecodeDate(FFirstDate, Year, Month, Day);
  FFirstDate := EncodeDate(Year, Month, 1);
  Width := 20;
  Height := 20;
  FColCount := 1;
  FRowCount := 1;
  ShowTodayButton := True;
  FIsPopupControl := True;
end;

procedure TdxGridDatePopup.CheckSelection(MarginDate: TDateTime);
begin
  Repaint;
end;

function TdxGridDatePopup.ColOfDate(ADate: TDateTime): Integer;
begin
  Result := DayOfWeek(ADate) - StartOfWeek - 1;
  if Result < 0 then Inc(Result, 7);
end;

function TdxGridDatePopup.GetHeaderRect: TRect;
begin
  with Result do
  begin
    Left := 0;
    Top := 0;
    Right := ClientWidth;
    Bottom := Top + FHeaderHeight;
  end;
end;

function TdxGridDatePopup.GetInternalRect: TRect;
begin
  with Result do
  begin
    Left := 0;
    Top := FHeaderHeight + Byte(not FFlat);
    Right := ClientWidth;
    Bottom := Top + FDaysOfWeekHeight + 6 * FRowHeight + 1;
  end;
end;

function TdxGridDatePopup.GetLeftArrowRect: TRect;
begin
  SetRect(Result, 1, 1, FColWidth - 1, FHeaderHeight - 1);
end;

function TdxGridDatePopup.GetRightArrowRect: TRect;
begin
  SetRect(Result, ClientWidth - FColWidth, 1,
    ClientWidth - 1 - Byte(not FFlat), FHeaderHeight - 1);
end;

function TdxGridDatePopup.GetMonthNameRect: TRect;
begin
  Result := GetInternalRect;
  with Result do
  begin
    Inc(Left, FColWidth);
    Dec(Right, FColWidth + Byte(not FFlat));
    Bottom := Top - Byte(not FFlat) - 1;
    Top := Bottom - (FHeaderHeight - 2);
  end;
end;

function TdxGridDatePopup.GetTodayButtonRect: TRect;
begin
  Result :=
    Bounds(
      (ClientWidth - FTodayButtonWidth - Byte(ShowClearButton) * FClearButtonWidth) div
       (3 - Byte(not ShowClearButton)),
      ClientHeight - FButtonsRegionHeight + FButtonsOffset,
      FTodayButtonWidth, FButtonsHeight);
end;

function TdxGridDatePopup.GetClearButtonRect: TRect;
begin
  Result :=
    Bounds(ClientWidth - FClearButtonWidth -
      (ClientWidth - Byte(ShowTodayButton) * FTodayButtonWidth - FClearButtonWidth) div
       (3 - Byte(not ShowTodayButton)),
      ClientHeight - FButtonsRegionHeight + FButtonsOffset,
      FClearButtonWidth, FButtonsHeight);
end;

function TdxGridDatePopup.GetShowButtonsArea: Boolean;
begin
  Result := ShowTodayButton or ShowClearButton;
end;

procedure TdxGridDatePopup.FreeTimer;
begin
  if FTimer > 0 then
  begin
    KillTimer(Handle, FTimer);
    FTimer := 0;
  end;
end;

procedure TdxGridDatePopup.RepaintTodayButton;
var
  R: TRect;
begin
  R := GetTodayButtonRect;
  InvalidateRect(Handle, @R, False);
end;

procedure TdxGridDatePopup.RepaintClearButton;
var
  R: TRect;
begin
  R := GetClearButtonRect;
  InvalidateRect(Handle, @R, False);
end;

procedure TdxGridDatePopup.WMDestroy(var Message: TMessage);
begin
  FreeTimer;
  inherited;
end;

procedure TdxGridDatePopup.WMSize(var Message: TWMSize);
begin
  inherited;
  SetSize;
end;

procedure TdxGridDatePopup.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Canvas.Font.Assign(Font);
  FColWidth := 3 * Canvas.TextWidth('0');
  FSideWidth := 2 * Canvas.TextWidth('0');
  FRowHeight := Canvas.TextHeight('0') + 2;
  FHeaderHeight := FRowHeight + 2 + Byte(FFlat);
  FDaysOfWeekHeight := FRowHeight + 1;
  FTodayButtonWidth := Canvas.TextWidth(sdxGridDatePopupToday) +
    FColWidth;
  FClearButtonWidth := Canvas.TextWidth(sdxGridDatePopupClear) +
    FColWidth;
  FButtonsOffset := Font.Size div 2;
  FButtonsHeight := MulDiv(Canvas.TextHeight('Wg'), 20, 13);
  FButtonsRegionHeight := FButtonsOffset + FButtonsHeight +
    Font.Size * 3 div 4;
  SendMessage(Handle, WM_SIZE, 0, 0);
end;

function TdxGridDatePopup.GetRealFirstDate: TDateTime;
var
  ACol: Integer;
begin
  Result := FirstDate;
  ACol := ColOfDate(FirstDate);
  if ACol = 0 then
    Result := Result - 7
  else
    Result := Result - ACol;
end;

function TdxGridDatePopup.GetRealLastDate: TDateTime;
var
  Year, Month, Day: Word;
  ACol: Integer;
begin
  Result := LastDate;
  DecodeDate(Result, Year, Month, Day);
  ACol := ColOfDate(EncodeDate(Year, Month, 1));
  Result := Result + 6 * 7 - DaysPerMonth(Year, Month) - ACol;
  if ACol = 0 then Result := Result - 7; 
end;

function TdxGridDatePopup.GetLastDate: TDateTime;
var
  Year, Month, Day: Word;
begin
  DecodeDate(FirstDate, Year, Month, Day);
  Result := EncodeDate(Year, Month, DaysPerMonth(Year, Month));
end;

procedure TdxGridDatePopup.SetFirstDate(Value: TDateTime);
begin
  Value := DateOf(Value) - (GetDateElement(Value, 3) - 1);
  inherited SetFirstDate(Value);
end;

procedure TdxGridDatePopup.SetSelFinish(Value: TDateTime);
begin
  if FSelFinish <> Value then
  begin
    FSelStart := Value;
    inherited SetSelFinish(Value);
  end;
end;

procedure TdxGridDatePopup.StepToPast;
var
  Year, Month, Day: Word;
begin
  DecodeDate(FirstDate, Year, Month, Day);
  DecMonth(Year, Month);
  FirstDate := EncodeDate(Year, Month, 1);
  if SelStart > LastDate then
    CheckSelection(LastDate)
  else Repaint;
end;

procedure TdxGridDatePopup.StepToFuture;
var
  Year, Month, Day: Word;
begin
  DecodeDate(FirstDate, Year, Month, Day);
  IncMonth(Year, Month);
  FirstDate := EncodeDate(Year, Month, 1);
  if SelStart < FirstDate then
    CheckSelection(FirstDate)
  else Repaint;
end;

procedure TdxGridDatePopup.CheckFirstDate;
var
  Year, Month, Day: Word;
begin
  if FSelStart < RealFirstDate then
  begin
    DecodeDate(FSelStart, Year, Month, Day);
    ChangeMonth(Year, Month, -1{(ColCount * RowCount - 1)});
    FirstDate := EncodeDate(Year, Month, CheckDay(Year, Month, Day));
  end;
  if FSelStart > RealLastDate then
    FirstDate := DateOf(FSelStart);
end;

function TdxGridDatePopup.PosToDateTime(P: TPoint): TDateTime;
var
  ACol, ARow, X, Y: Integer;
  R: TRect;
  Year, Month, Day, AYear, AMonth: Word;
  ADate: TDateTime;
begin
  if PtInRect(ClientRect, P) then
  begin
    ACol := P.X div (ClientWidth div ColCount);
    ARow := P.Y div (ClientHeight div RowCount);
    R := GetInternalRect;
    with R do
    begin
      Inc(Top, FDaysOfWeekHeight);
      Inc(Left, FSideWidth);
      Dec(Right, FSideWidth);
      Bottom := Top + 6 * FRowHeight;
      if PtInRect(R, P) then
      begin
        Dec(P.X, Left);
        Dec(P.Y, Top);
        X := P.X div FColWidth;
        Y := P.Y div FRowHeight;
        DecodeDate(FirstDate, Year, Month, Day);
        ChangeMonth(Year, Month, ARow * ColCount + ACol);
        ADate := EncodeDate(Year, Month, 1);
        Result := ADate - ColOfDate(ADate) + Y * 7 + X;
        if (ACol + ARow = 0) and (ColOfDate(FirstDate) = 0) then
          Result := Result - 7;
        DecodeDate(Result, AYear, AMonth, Day);
        if ((Result < ADate) and (ACol + ARow > 0)) or
          ((Result >= ADate + DaysPerMonth(Year, Month)) and
           not ((ACol = ColCount - 1) and (ARow = RowCount - 1))) then
          Result := NullDate;
      end
      else Result := NullDate;
    end;
  end
  else Result := NullDate;
end;

procedure TdxGridDatePopup.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
  end;
end;

procedure TdxGridDatePopup.KeyDown(var Key: Word; Shift: TShiftState);
var
  AYear, AMonth, ADay: Word;

  procedure MoveByMonth(AForward: Boolean);
  begin
    DecodeDate(SelStart, AYear, AMonth, ADay);
    if AForward then
      IncMonth(AYear, AMonth)
    else
      DecMonth(AYear, AMonth);
    ADay := CheckDay(AYear, AMonth, ADay);
    SelStart := EncodeDate(AYear, AMonth, ADay);
  end;

begin
  inherited KeyDown(Key, Shift);
  case Key of
    VK_ESCAPE, VK_F4: HidePopup(False);
    VK_RETURN:
      if FListBox = nil then
      begin
        HidePopup(False);
        if Key = VK_RETURN then DoDateTimeChanged;
      end;
    VK_LEFT: SelStart := SelStart - 1;
    VK_RIGHT: SelStart := SelStart + 1;
      VK_UP:
        if Shift = [ssAlt] then HidePopup(False)
        else SelStart := SelStart - 7;
      VK_DOWN:
        if Shift = [ssAlt] then HidePopup(False)
        else SelStart := SelStart + 7;
    VK_HOME:
      if Shift = [ssCtrl] then
        SelStart := SelStart - (GetDateElement(SelStart, 3) - 1)
      else
        SelStart := SelStart - ColOfDate(SelStart);
    VK_END:
      if Shift = [ssCtrl] then
      begin
        DecodeDate(SelStart, AYear, AMonth, ADay);
        SelStart := SelStart + (DaysPerMonth(AYear, AMonth) - ADay)
      end
      else SelStart := SelStart + (6 - ColOfDate(SelStart));
    VK_PRIOR: MoveByMonth(False);
    VK_NEXT: MoveByMonth(True)
  end;
end;

procedure ADateNavigatorTimerProc(Wnd: HWND; Msg: UINT; idEvent: UINT;
  Time: DWORD); stdcall;
var
  AControl: TdxGridDatePopup;
  P: TPoint;
begin
  AControl := TdxGridDatePopup(FindControl(Wnd));
  GetCursorPos(P);
  P := AControl.ScreenToClient(P);
  with AControl do
    case idEvent of
      1: if PtInRect(GetLeftArrowRect, P) then StepToPast;
      2: if PtInRect(GetRightArrowRect, P) then StepToFuture;
    end;
end;

procedure TdxGridDatePopup.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Col, Row: Integer;
  Year, Month, Day: Word;
  R: TRect;
begin
  if Button = mbLeft then
    if ShowTodayButton and PtInRect(GetTodayButtonRect, Point(X, Y)) then
    begin
      FTodayButtonActive := True;
      FTodayButtonPressed := True;
      RepaintTodayButton;
      Exit;
    end
    else
      if ShowClearButton and PtInRect(GetClearButtonRect, Point(X, Y)) then
      begin
        FClearButtonActive := True;
        FClearButtonPressed := True;
        RepaintClearButton;
        Exit;
      end
      else
        if ShowButtonsArea and (Y >= ClientHeight - FButtonsRegionHeight) then
          Exit;
  inherited MouseDown(Button, Shift, X, Y);
  if Button = mbLeft then
  begin
    Col := X div (ClientWidth div ColCount);
    Row := Y div (ClientHeight div RowCount);
    if PtInRect(GetMonthNameRect, Point(X, Y)) then
    begin  // show month's list box
      FListBoxDelta := Row * ColCount + Col;
      FListBox := TAMonthListBox.Create(Self);
      FListBox.Visible := False;
      FListBox.Parent := Self;
      DecodeDate(FirstDate, Year, Month, Day);
      ChangeMonth(Year, Month, FListBoxDelta - 3);
      R := GetMonthNameRect;
      MapWindowPoints(Handle, 0, R, 2);
      with TAMonthListBox(FListBox) do
      begin
        Font.Assign(Self.Font);
        SendMessage(Handle, CM_FONTCHANGED, 0, 0);
        TopDate := EncodeDate(Year, Month, 1);
        Left := (R.Left + R.Right - Width) div 2;
        Top := (R.Top + R.Bottom) div 2 - Height div 2;
        ShowWindow(Handle, SW_SHOWNOACTIVATE);
      end;
    end
    else
      if PtInRect(GetLeftArrowRect, Point(X, Y)) then
      begin  // shift by month to past
        StepToPast;
        if FTimer = 0 then
          FTimer := SetTimer(Handle, 1, ADateNavigatorTime,
            @ADateNavigatorTimerProc);
      end
      else
        if PtInRect(GetRightArrowRect, Point(X, Y)) then
        begin  // shift by month to future
          StepToFuture;
          if FTimer = 0 then
            FTimer := SetTimer(Handle, 2, ADateNavigatorTime,
              @ADateNavigatorTimerProc);
        end;
  end;
end;

procedure TdxGridDatePopup.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
begin
  if FTimer > 0 then Exit;
  if FListBox <> nil then
  begin
    P := Point(X, Y);
    MapWindowPoints(Handle, FListBox.Handle, P, 1);
    TAMonthListBox(FListBox).MouseMove(Shift, P.X, P.Y);
    Exit;
  end;
  if FTodayButtonActive then
  begin
    if FTodayButtonPressed <> PtInRect(GetTodayButtonRect, Point(X, Y)) then
    begin
      FTodayButtonPressed := not FTodayButtonPressed;
      RepaintTodayButton;
    end;
    Exit;
  end;
  if FClearButtonActive then
  begin
    if FClearButtonPressed <> PtInRect(GetClearButtonRect, Point(X, Y)) then
    begin
      FClearButtonPressed := not FClearButtonPressed;
      RepaintClearButton;
    end;
    Exit;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TdxGridDatePopup.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  ADate: TDateTime;
  Year, Month, Day: Word;
begin
  if FTimer > 0 then
  begin
    FreeTimer;
    Exit;
  end;
  if FListBox <> nil then
  begin
    ADate := TAMonthListBox(FListBox).Date;
    FListBox.Free;
    FListBox := nil;
    if ADate <> NullDate then
    begin
      DecodeDate(ADate, Year, Month, Day);
      ChangeMonth(Year, Month, -FListBoxDelta);
      FirstDate := EncodeDate(Year, Month, 1);
      if SelStart < FirstDate then
        CheckSelection(FirstDate)
      else
        if SelStart > LastDate then
          CheckSelection(LastDate)
        else Repaint;
    end;
    Exit;
  end;
  if FTodayButtonActive then
  begin
    FTodayButtonActive := False;
    if FTodayButtonPressed then SelStart := Date
    else Exit;
  end;
  if FClearButtonActive then
  begin
    FClearButtonActive := False;
    if FClearButtonPressed then SelStart := NullDate
    else Exit;
  end;
  if HandleAllocated and PtInRect(ClientRect, Point(X, Y)) then HidePopup(False);
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TdxGridDatePopup.Paint;
const
  FontColors: array[Boolean] of Integer = (COLOR_WINDOWTEXT, COLOR_HIGHLIGHTTEXT);
  BrushColors: array[Boolean, Boolean] of TColor =
    ((clWindow, clHighlight), (clWindow, clBtnFace));
var
  I, J, ArrowHeight: Integer;
  Region, Rgn: HRGN;
  CurDate, ALastDate: TDateTime;

  procedure ExcludeRect(const R: TRect);
  begin
    Rgn := CreateRectRgnIndirect(R);
    CombineRgn(Region, Region, Rgn, RGN_DIFF);
    DeleteObject(Rgn);
  end;

  procedure DrawArrow(const R: TRect; LeftArrow: Boolean);
  var
    X, Sign: Integer;
    P: array[1..3] of TPoint;
    Rgn: HRGN;
  begin
    with Canvas, R do
    begin
      if LeftArrow then X := Left - 1
      else X := Right;
      Sign := 2 * Byte(LeftArrow) - 1;
      P[1] := Point(X + Sign * (FSideWidth - 1), (Top + Bottom - ArrowHeight) div 2);
      P[2] := Point(P[1].X, P[1].Y + ArrowHeight - 1);
      P[3] := Point(P[1].X - Sign * ArrowHeight div 2, P[1].Y + ArrowHeight div 2);
      Pen.Color := clBtnText;
      Brush.Color := clBtnText;
      Polygon(P);
      // exclude arrow area from clipregion
      if LeftArrow then
      begin
        Inc(P[1].X);
        Inc(P[2].X);
      end
      else Inc(P[3].X);
      Dec(P[1].Y);
      Inc(P[2].Y);
      Rgn := CreatePolygonRgn(P, 3, WINDING);
      ExtSelectClipRgn(Handle, Rgn, RGN_DIFF);
      DeleteObject(Rgn);
    end;
  end;

  procedure DrawMonth(Col, Row: Integer);
  var
    Size: TSize;
    R, TextR, SideR: TRect;
    I, J, DayBase, CurDay, ADaysPerMonth: Integer;
    Year, Month, Day: Word;
    ADate, DateBase: TDateTime;
    S: string;
    Selected: Boolean;
  begin
    DecodeDate(FirstDate, Year, Month, Day);
    ChangeMonth(Year, Month, Row * ColCount + Col);
    with Canvas do
    begin
      R := GetInternalRect;
      with R do
        ExcludeRect(Rect(Left + FSideWidth, Top, Right - FSideWidth, Bottom - 1));
      // draw header's frame
      TextR := GetHeaderRect;
      with TextR do ArrowHeight := (Bottom - Top) div 2;
      if not Odd(ArrowHeight) then Inc(ArrowHeight);
      if not FFlat then InflateRect(TextR, 0, 1);
      ExcludeRect(TextR);
      if not FFlat then InflateRect(TextR, 0, -1);
      Brush.Color := clBtnFace;
      Pen.Color := clBtnText;
      if not FFlat then
        with TextR do
        begin
          MoveToEx(Handle, Left, Bottom, nil);
          Windows.LineTo(Handle, Right, Bottom);
          if Col = ColCount - 1 then
          begin
            MoveToEx(Handle, Right - 1, Top, nil);
            Windows.LineTo(Handle, Right - 1, Bottom);
            Dec(TextR.Right);
          end;
        end;
      DrawEdge(Handle, TextR, BDR_RAISEDINNER, BF_TOP or BF_BOTTOM or
        Byte(Col = 0) * BF_LEFT or Byte(Col = ColCount - 1) * BF_RIGHT);
      if Col < ColCount - 1 then
        with TextR do
        begin
          SideR := Rect(Right - 1, Top + 2, Right + 1, Bottom - 2);
          DrawEdge(Handle, SideR, EDGE_ETCHED, BF_LEFT);
          with SideR do
          begin
            Windows.FillRect(Handle, Rect(Left, Top - 1, Right, Top), Brush.Handle);
            Windows.FillRect(Handle, Rect(Left, Bottom, Right, Bottom + 1), Brush.Handle);
          end;
        end;
      InflateRect(TextR, -1, -1);
      // draw arrows
      if Row = 0 then
      begin
        if Col = 0 then DrawArrow(TextR, True);
        if Col = ColCount - 1 then DrawArrow(TextR, False);
      end;
      // write month's and year's names
      S := LongMonthNames[Month] + ' ' + IntToStr(Year);
      GetTextExtentPoint32(Handle, PChar(S), Length(S), Size);
      SetTextColor(Handle, GetSysColor(COLOR_BTNTEXT));
      Brush.Color := clBtnFace;
      with TextR do
        ExtTextOut(Handle, (Left + Right - Size.cX) div 2, (Top + Bottom - Size.cY) div 2,
          ETO_CLIPPED or ETO_OPAQUE, @TextR, PChar(S), Length(S), nil);
      // write first letters of day's names
      Brush.Color := clWindow;
      with TextR do
      begin
        Left := R.Left + FSideWidth;
        Right := R.Right - FSideWidth;
        Top := R.Top;
        Bottom := Top + FDaysOfWeekHeight - 2;
        Windows.FillRect(Handle, Rect(Left - 8, Top, Left, Bottom + 2), Brush.Handle);
        Windows.FillRect(Handle, Rect(Right, Top, Right + 8, Bottom + 2), Brush.Handle);
        Pen.Color := clBtnShadow;
        MoveToEx(Handle, Left, Bottom, nil);
        Windows.LineTo(Handle, Right, Bottom);
        Pen.Color := clWindow;
        MoveToEx(Handle, Left, Bottom + 1, nil);
        Windows.LineTo(Handle, Right, Bottom + 1);
        Right := Left;
      end;
      for I := 0 to 6 do
      begin
        with TextR do
        begin
          Left := Right;
          Right := Left + FColWidth;
        end;
        J := StartOfWeek + 1 + I;
        if J > 7 then Dec(J, 7);
        S := {$IFDEF DELPHI3}WideString{$ENDIF}(ShortDayNames[J])[1];
        GetTextExtentPoint32(Handle, PChar(S), Length(S), Size);
        with TextR do
          ExtTextOut(Handle, Right - 3 - Size.cX, (Top + Bottom - Size.cY) div 2,
            ETO_OPAQUE, @TextR, PChar(S), Length(S), nil);
      end;
      // write numbers of days
      DateBase := EncodeDate(Year, Month, 1) - 1;
      DayBase := 1 - ColOfDate(DateBase + 1);
      if (DayBase = 1) and (Col + Row = 0) then Dec(DayBase, 7);
      ADaysPerMonth := DaysPerMonth(Year, Month);
      for I := 0 to 6 do
        for J := 0 to 5 do
        begin
          with TextR do
          begin
            Left := R.Left + FSideWidth + I * FColWidth;
            Top := R.Top + FDaysOfWeekHeight + J * FRowHeight;
            Right := Left + FColWidth;
            Bottom := Top + FRowHeight;
          end;

          CurDay := DayBase + J * 7 + I;
          if (CurDay < 1) and (Col + Row <> 0) or
            (CurDay > ADaysPerMonth) and ((Col <> ColCount - 1) or (Row <> RowCount - 1)) then
            ADate := NullDate
          else
            ADate := DateBase + CurDay;
          Selected := (ADate >= SelStart) and (ADate <= SelFinish);

          if ADate = NullDate then
          begin
            Brush.Color := clWindow;
            Windows.FillRect(Handle, TextR, Brush.Handle);
            Continue;
          end;

          SideR := TextR;
          // draw frame around current date
          Brush.Color := BrushColors[FFlat, Selected];
          if ADate = CurDate then
          begin
            Pen.Color := clMaroon;
            with TextR do
              Polyline([Point(Left, Bottom - 1), Point(Left, Top),
                Point(Right - 1, Top), Point(Right - 1, Bottom - 1),
                Point(Left, Bottom - 1)]);
            InflateRect(TextR, -1, -1);
          end;
          // draw text of day's number
          if not Selected and
            (((ADate < FirstDate) and (Col + Row = 0)) or
             ((ADate > ALastDate) and
              (Col = ColCount - 1) and (Row = RowCount - 1))) then
            SetTextColor(Handle, GetSysColor(COLOR_GRAYTEXT))
          else
            SetTextColor(Handle, GetSysColor(FontColors[Selected]));

          S := IntToStr(GetDateElement(ADate, 3));
          GetTextExtentPoint32(Handle, PChar(S), Length(S), Size);
          with SideR do
            ExtTextOut(Handle,
              Right - 3 - Size.cX, (Top + Bottom - Size.cY) div 2,
              ETO_OPAQUE, @TextR, PChar(S), Length(S), nil);
        end;
    end;
  end;

  procedure DrawButton(R: TRect; ACaption: string; Pressed: Boolean);
  var
    Size: TSize;
  begin
    ExcludeRect(R);
    with Canvas, R do
    begin
      if Pressed then
        DrawFrameControl(Handle, R, DFC_BUTTON, DFCS_BUTTONPUSH or DFCS_PUSHED)
      else
      begin
        Pen.Color := clBtnText;
        MoveToEx(Handle, Left, Bottom - 1, nil);
        Windows.LineTo(Handle, Right - 1, Bottom - 1);
        Windows.LineTo(Handle, Right - 1, Top);
        Pen.Color := clBtnFace;
        Windows.LineTo(Handle, Left, Top);
        Windows.LineTo(Handle, Left, Bottom - 1);
        Pen.Color := clBtnShadow;
        MoveToEx(Handle, Left + 1, Bottom - 2, nil);
        Windows.LineTo(Handle, Right - 2, Bottom - 2);
        Windows.LineTo(Handle, Right - 2, Top + 1);
        Pen.Color := clBtnHighlight;
        Windows.MoveToEx(Handle, Left + 1, Bottom - 3, nil);
        Windows.LineTo(Handle, Left + 1, Top + 1);
        Windows.LineTo(Handle, Right - 2, Top + 1);
        SetPixel(Handle, Right - 2, Top + 1, GetSysColor(COLOR_BTNFACE));
      end;
      // draw button's caption
      InflateRect(R, -2, -2);
      Brush.Color := clBtnFace;
      SetTextColor(Handle, GetSysColor(COLOR_BTNTEXT));
      GetTextExtentPoint32(Handle, PChar(ACaption), Length(ACaption), Size);
      ExtTextOut(Handle, (Left + Right - Size.cX) div 2 + Byte(Pressed),
        (Top + Bottom - Size.cY) div 2 + Byte(Pressed), ETO_CLIPPED or ETO_OPAQUE, @R,
        PChar(ACaption), Length(ACaption), nil);
    end;
  end;

begin
  CurDate := Date;
  ALastDate := LastDate;
  Region := CreateRectRgnIndirect(ClientRect);
  with Canvas do
  begin
    for I := 0 to RowCount - 1 do
      for J := 0 to ColCount - 1 do DrawMonth(J, I);
    if ShowButtonsArea then
    begin
      Pen.Color := clBtnShadow;
      MoveTo(FSideWidth, ClientHeight - FButtonsRegionHeight - 1);
      LineTo(ClientWidth - FSideWidth, PenPos.Y);
      with PenPos do
        ExcludeRect(Rect(FSideWidth, Y, X, Y + 1));
      // draw today and clear buttons
      if ShowTodayButton then
        DrawButton(GetTodayButtonRect, sdxGridDatePopupToday,
          FTodayButtonActive and FTodayButtonPressed);
      if ShowClearButton then
        DrawButton(GetClearButtonRect, sdxGridDatePopupClear,
          FClearButtonActive and FClearButtonPressed);
    end;
    Brush.Color := clWindow;
    PaintRgn(Handle, Region);
    DeleteObject(Region);
  end;
end;

procedure TdxGridDatePopup.HidePopup(ByMouse: Boolean);
begin
  if IsWindowVisible(Handle) then
  begin
    if GetCapture = Handle then ReleaseCapture;
    FreeTimer;
    if FListBox <> nil then
    begin
      FListBox.Free;
      FListBox := nil;
    end;
    FTodayButtonActive := False;
    FClearButtonActive := False;
  end;  
  inherited HidePopup(ByMouse);
end;

procedure TdxGridDatePopup.SetSize;
begin
  Width := GetWidth;
  Height := GetHeight;
end;

function TdxGridDatePopup.GetWidth: Integer;
var
  WR, CR: TRect;
begin
  GetWindowRect(Handle, WR);
  OffsetRect(WR, -WR.Left, -WR.Top);
  Windows.GetClientRect(Handle, CR);
  Result := WR.Right - CR.Right + 2 * FSideWidth + 7 * FColWidth;
end;

function TdxGridDatePopup.GetHeight: Integer;
var
  WR, CR: TRect;
begin
  GetWindowRect(Handle, WR);
  OffsetRect(WR, -WR.Left, -WR.Top);
  Windows.GetClientRect(Handle, CR);
  Result := WR.Bottom - CR.Bottom +
    FHeaderHeight + Byte(not FFlat) + FDaysOfWeekHeight + 6 * FRowHeight + 1;
  if ShowButtonsArea then
    Inc(Result, FButtonsRegionHeight);
end;

{$IFNDEF DELPHI3}
const
  LOCALE_IFIRSTDAYOFWEEK          = $0000100C;   { first day of week specifier }
{$ENDIF}

initialization
  sdxGridDatePopupToday := LoadStr(dxSDatePopupToday);
  sdxGridDatePopupClear := LoadStr(dxSDatePopupClear);

  RetrieveStartOfWeek;

end.
