{*******************************************************************}
{                                                                   }
{       Developer Express Cross platform Visual Component Library   }
{       ExpressSpreadSheet				            }
{                                                                   }
{       Copyright (c) 2001-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSPREADSHEET AND ALL           }
{   ACCOMPANYING VCL AND CLX CONTROLS AS PART OF AN EXECUTABLE      }
{   PROGRAM ONLY.                                                   }
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

unit cxSSUtils;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils, Math, Windows, Messages,
  cxSSTypes, cxSSRes, dxCore;

type
  TcxSSUtils = class
    class function CheckValue(AValue, AMin, AMax: Integer): Integer; virtual;
    class function ColumnNameByIndex(ACol: Integer;
      IsRCReferenceStyle: Boolean = False): string; virtual;
    class function ColumnIndexByName(const AName: ShortString): Integer; virtual;
    class function FormatText(const AValue: Double; AFormat: TxlsDataFormat;
      APrecision: Byte; var ATextColor: Word): string; virtual;
    class function IntersectRange(var AOutRect: TRange; ARect1, ARect2: TRange): Boolean; virtual;
    class function PointInRect(const Rect: TRect; const P: TPoint): Boolean; virtual;
    class function RowNameByIndex(ARow: Integer; IsRCReferenceStyle: Boolean = False): string; virtual;
    class function ValueInRange(AValue, AFromValue, AToValue: Integer): Boolean; virtual;
  end;

  function BoolToStr(const Value: Boolean): string;
  function cxTryDateTimeFromStr(const S: string; out ADateTime: TDateTime): Boolean;
  function cxTryStrToTime(const AStr: string; var ATime: TDateTime): Boolean;
  function cxTryStrToDate(const AStr: string; var ADate: TDateTime): Boolean;
  function cxTryStrToDateTime(const S: string; out ADateTime: TDateTime): Boolean;
  function XLSErrToStr(ACode: Byte): string;
  function StrToBool(const Value: string): Boolean;

  function cxTryStrToOrdinal(const AString: string): Boolean;
  function cxTryStrToBool(const AString: string; var Value: Boolean): Boolean; overload;
  function cxTryStrToBool(const AString: string): Boolean; overload;

  function cxTryStrToCurr(S: string; var Value: Currency): Boolean;
  function cxTryStrToFloat(const AString: string; var Value: Double): Boolean; overload;
  function cxTryStrToFloat(const AString: string): Boolean; overload;
  function cxTryStrToInt(const AString: string; var Value: Integer): Boolean; overload;
  function cxTryStrToInt(const AString: string): Boolean; overload;

  function Get8087CW: Word;
  function SetPrecisionMode(const Precision: Byte): Byte;
  function SetRoundMode(const RoundMode: Byte): Byte;

  {$IFNDEF DELPHI6}
  function TryEncodeTime(Hour, Min, Sec, MSec: Word; out Time: TDateTime): Boolean;
  function TryEncodeDate(Year, Month, Day: Word; out Date: TDateTime): Boolean;
  {$ENDIF}

  function GetLocaleStrW(Locale, LocaleType: Integer): WideString;

  procedure SetControlCodes;

var
  cxBlankCharCode: Integer;
  cxThousandCharCode: Integer;
  cxDecimalCharCode: Integer;

implementation

function BoolToStr(const Value: Boolean): string;
begin
  if Value then
    Result := sxlfTrue
  else
    Result := sxlfFalse;
end;

{$IFNDEF DELPHI6}
function DateTimeFromStr(const strIn: WideString; lcid: DWORD; dwFlags: Longint;
  out dateOut: TDateTime): HRESULT; stdcall; external 'oleaut32.dll' name 'VarDateFromStr';
{$ENDIF}

function cxTryDateTimeFromStr(const S: string; out ADateTime: TDateTime): Boolean;
begin
  {$IFNDEF DELPHI6}
  Result := DateTimeFromStr(S, $400, 0, ADateTime) = 0;
  {$ELSE}
  Result := TryStrToDate(S, ADateTime) or TryStrToTime(S, ADateTime);
  {$ENDIF}
end;

function cxTryStrToDate(const AStr: string; var ADate: TDateTime): Boolean;
begin
  ADate := 0;
  {$IFNDEF DELPHI6}
  Result := cxTryDateTimeFromStr(AStr, ADate) and (Frac(ADate) = 0);
  {$ELSE}
  Result := TryStrToDate(AStr, ADate);
  {$ENDIF}
end;

function cxTryStrToTime(const AStr: string; var ATime: TDateTime): Boolean;
begin
  ATime := 0; 
  {$IFNDEF DELPHI6}
  Result := cxTryDateTimeFromStr(AStr, ATime) and (Trunc(ATime) = 0);
  {$ELSE}
  Result := TryStrToTime(AStr, ATime);
  {$ENDIF}
end;

function cxTryStrToDateTime(const S: string; out ADateTime: TDateTime): Boolean;
var
  ADate, ATime: Double;
  ASplitPos: Integer;
  TS, S1: string;
begin
  ADateTime := 0;
  Result := cxTryStrToDate(S, TDateTime(ADateTime)) or cxTryStrToTime(S, TDateTime(ADateTime));
  TS := Trim(S);
  if (TS = '') or Result then Exit;
  ASplitPos := Pos(' ', TS);
  if ASplitPos = 0 then
    ASplitPos := Length(TS);
  try
    ATime := 0;
    S1 := Copy(TS, 1, ASplitPos);
    Result := cxTryStrToDate(S1, TDateTime(ADate)) or cxTryStrToTime(S1, TDateTime(ATime));
    Delete(TS, 1, ASplitPos);
    if (TS <> '') and Result then
    begin
      if ATime = 0 then
        Result := cxTryStrToTime(Trim(TS), TDateTime(ATime))
      else
        Result := cxTryStrToDate(Trim(TS), TDateTime(ATime));
    end;
  finally
    if Result then
      ADateTime := ADate + ATime; 
  end;
end;

function XLSErrToStr(ACode: Byte): string;
begin
  case ACode of
    0:
      Result := scxNullError;
    7:
      Result := scxDivZeroError;
    15:
      Result := scxValueError;
    23:
      Result := scxRefError;
    29:
      Result := scxNameError;
    36:
      Result := scxNumError;
    42:
      Result := scxNAError;
  else
    Result := '';
  end;
end;

function cxTryStrToOrdinal(const AString: string): Boolean;
begin
  Result := cxTryStrToBool(AString) or cxTryStrToFloat(AString) or cxTryStrToInt(AString);
end;

function StrToBool(const Value: string): Boolean;
begin
  cxTryStrToBool(Value, Result);
end;

function cxTryStrToBool(const AString: string; var Value: Boolean): Boolean;
var
  AStr: string;
begin
  AStr := AnsiUpperCase(AString);
  Value := AStr = sxlfTrue;
  Result := (AStr = sxlfTrue) or (AStr = sxlfFalse);
end;

function cxTryStrToBool(const AString: string): Boolean;
var
  AValue: Boolean;
begin
  Result := cxTryStrToBool(AString, AValue);
end;

function cxTryStrToCurr(S: string; var Value: Currency): Boolean;
var
  APos, Code: Integer;
  IntPart, FrucPart: Double;
  IsNegative: Boolean;
  HasCurrencyStr: Boolean;
  HasThousandSeparator: Boolean;

  function CheckCurrencyStr: Boolean;
  var
    CharCount: Integer;
  begin
    Result := not HasCurrencyStr and (Length(dxFormatSettings.CurrencyString) > 0);
    CharCount := 0;
    while Result and (APos <= Length(S)) do
    begin
      if CharCount < Length(dxFormatSettings.CurrencyString) then
      begin
        Result := S[APos + CharCount] = dxFormatSettings.CurrencyString[CharCount + 1];
        if Result then
          Inc(CharCount);
      end
      else
      begin
        HasCurrencyStr := CharCount = Length(dxFormatSettings.CurrencyString);
        Result := HasCurrencyStr;
        if Result then
          Inc(APos, CharCount - 1);
        Break;
      end;
    end;
  end;

  function ScanIntPart: Boolean;
  var
    NumCount: Integer;
  begin
    Result := APos <= Length(S);
    if Result then
    begin
      NumCount := 0;
      HasThousandSeparator := False;
      IntPart := 0;
      while Result and (APos <= Length(S)) do
      begin
        Code := Integer(S[APos]) - Integer('0');
        if (Code >= 0) and (Code <= 9) then
        begin
          IntPart := IntPart * 10 + Code;
          if HasThousandSeparator then Inc(NumCount);
        end
        else
        begin
          if Code = cxDecimalCharCode then
            Break
          else
            if Code = cxThousandCharCode then
            begin
              Result := not HasThousandSeparator or (NumCount = 3);
              HasThousandSeparator := True;
              NumCount := 0;
            end
            else
              Result := (Code = cxBlankCharCode) or CheckCurrencyStr;
        end;
        Inc(APos);
      end;
    end;
  end;

  function ScanFrucPart: Boolean;
  var
    C: Double;
  begin
    Result := True;
    Inc(APos);
    FrucPart := 0;
    C := 0.1;
    while Result and (APos <= Length(S)) do
    begin
      Code := Integer(S[APos]) - Integer('0');
      if (Code >= 0) and (Code <= 9) then
      begin
        FrucPart := FrucPart + Code * C;
        C := C / 10;
      end
      else
        Result := (Code = cxBlankCharCode) or
          (CheckCurrencyStr and (APos = Length(S)));
      Inc(APos);
    end;
  end;

begin
  APos := 1;
  HasCurrencyStr := False;
  IsNegative := (Length(S) > 1) and (S[1] = '(') and (S[Length(S)] = ')');
  if IsNegative then
    S := Copy(S, 2, Length(S) - 2);
  Result := ScanIntPart and ScanFrucPart and
    (((dxFormatSettings.ThousandSeparator <> '') and HasThousandSeparator) or HasCurrencyStr);
  if Result then
  begin
    try
      Value := IntPart + FrucPart;
    except  
      on EInvalidOp do
        Result := False
      else
        raise;
    end;
    if IsNegative then
      Value := -Value;
  end
  else
    Value := 0;
end;

function cxTryStrToFloat(const AString: string; var Value: Double): Boolean;
var
  L: Integer;
  ARet: Extended;
begin
  L := Length(AString);
  Result := (L >= 1) and not dxCharInSet(AString[L], ['e', 'E']) and
    TextToFloat(PChar(AString), ARet, fvExtended);
  if Result and (Abs(ARet) <= MaxDouble) then
    Value := ARet
  else
  begin
    Result := False;
    Value := 0;
  end;
end;

function cxTryStrToFloat(const AString: string): Boolean;
var
  AValue: Double;
begin
  Result := cxTryStrToFloat(AString, AValue)
end;

function cxTryStrToInt(const AString: string; var Value: Integer): Boolean;
var
  ErrCode: Integer;
  S: string;
begin
  S := Trim(AString);
  Val(S, Value, ErrCode);
  Result := ErrCode = 0;
  if not Result then Value := 0;
end;

function cxTryStrToInt(const AString: string): Boolean;
var
  AValue : Integer;
begin
  Result := cxTryStrToInt(AString, AValue);
end;

{$IFNDEF DELPHI6}
function TryEncodeDate(Year, Month, Day: Word; out Date: TDateTime): Boolean;
var
  I: Integer;
  DayTable: PDayTable;
begin
  DayTable := @MonthDays[IsLeapYear(Year)];
  Result := (Year >= 1) and (Year <= 9999) and (Month >= 1) and (Month <= 12) and
    (Day >= 1) and (Day <= DayTable^[Month]);
  if Result then
  begin
    for I := 1 to Month - 1 do Inc(Day, DayTable^[I]);
    I := Year - 1;
    Date := I * 365 + I div 4 - I div 100 + I div 400 + Day - DateDelta;
  end;
end;

function TryEncodeTime(Hour, Min, Sec, MSec: Word; out Time: TDateTime): Boolean;
begin
  Result := (Hour < 24) and (Min < 60) and (Sec < 60) and (MSec < 1000);
  if Result then
    Time := (Hour * 3600000 + Min * 60000 + Sec * 1000 + MSec) / MSecsPerDay;
end;
{$ENDIF}

function Get8087CW: Word;
asm
  PUSH    0
  FNSTCW  [ESP].Word
  POP     EAX
end;

function SetRoundMode(const RoundMode: Byte): Byte;
var
  CtlWord: Word;
begin
  CtlWord := Get8087CW;
  Set8087CW((CtlWord and $F3FF) or (Ord(RoundMode) shl 10));
  Result := (CtlWord shr 10) and 3;
end;

function SetPrecisionMode(const Precision: Byte): Byte;
var
  CtlWord: Word;
begin
  CtlWord := Get8087CW;
  Set8087CW((CtlWord and $FCFF) or (Ord(Precision) shl 8));
  Result := (CtlWord shr 8) and 3;
end;

class function TcxSSUtils.CheckValue(AValue, AMin, AMax: Integer): Integer;
begin
  if AValue <= AMin then
    Result := AMin
  else
  begin
    if AValue >= AMax then
      Result := AMax
    else
      Result := AValue;
  end;
end;

class function TcxSSUtils.ColumnNameByIndex(ACol: Integer; IsRCReferenceStyle: Boolean = False): string;
const
  DIGSTR: string[26]=('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
begin
  if not IsRCReferenceStyle then
  begin
    Result := '';
    if ACol >= 26 then
      Result := Result + ColumnNameByIndex(ACol div 26 - 1, IsRCReferenceStyle);
    Result := Result + Char(Byte('A') + ACol mod 26);
  end
  else
    Result := IntToStr(ACol + 1);
end;

class function TcxSSUtils.ColumnIndexByName(const AName: ShortString): Integer;

  function IntPower(const Base, Exp: Integer): Integer;
  var
    I: Integer;
  begin
    Result := 1;
    for I := 1 to Exp do
      Result := Result * Base;
  end;

var
  I: Integer;

begin
  Result := 0;
  for I := Length(AName) downto 1 do
    Result := Result + IntPower(26, Length(AName) - I) * (Byte(AName[I]) - Byte('A') + 1);
  Dec(Result);
end;

class function TcxSSUtils.FormatText(const AValue: Double; AFormat: TxlsDataFormat;
  APrecision: Byte; var ATextColor: Word): string;

  function FormatFloat(const AFormat: string; Value: Extended): string;
  var
    I: Integer;
  begin
    if dxFormatSettings.CurrencyString <> '$' then
    begin
      Result := '';
      for I := 1 to Length(AFormat) do
        if AFormat[I] <> '$' then
          Result := Result + AFormat[I]
        else
          Result := Result + dxFormatSettings.CurrencyString;
      Result := SysUtils.FormatFloat(Result, Value);
    end
    else
      Result := SysUtils.FormatFloat(AFormat, Value)
  end;

  function GetFreeStateFormat(AFormat: Byte): string;
  const
    AFreeStates: array[0..3, 0..2] of string =
      ((' #,##0 ', '(#,##0)', ' - '),
       (' $ #,##0 ', '$ (#,##0)', ' $ - '),
       (' #,##0.00 ', '(#,##0.00)', ' -   '),
       (' $ #,##0.00 ', ' $ (#,##0.00)', ' $ -   '));
  begin
    if AValue = 0 then
      Result := AFreeStates[AFormat, 2]
    else
      Result := FormatFloat(AFreeStates[AFormat,
        (Byte(AValue >= 0) + Byte(AValue < 0)* 2) - 1], Abs(AValue))
  end;

  function FloatToStr(AValue: Double): string;
  begin
   if (AValue < 1) and (AValue >= 0) and ((AValue - Trunc(AValue)) = 0) then
      Result := SysUtils.FloatToStr(AValue)
    else
      Result := FloatToStrF(AValue, ffFixed, 18, APrecision);
  end;

var
  ARoundMode, APrecisionMode: Byte;

const
  AFFormat: array[0..14] of string =
    ('0', '0.00', '#,##0', '#,##0.00', '$#,##0', '($#,##0)', '$#,##0.00', '($#,##0.00)',
      '0%', '0.00%', '0.00E+00', ' #,##0 ', '(#,##0)', ' #,##0.00 ', '(#,##0.00)');
  ADateFormat: array[0..5] of string =
   ('d"-"mmmm"-"yy', 'd"-"mmmm', 'mmmm"-"yy', 'h:nn am/pm', 'h:nn":"ss am/pm', 'h:nn');
begin
  ARoundMode := SetRoundMode(0);
  APrecisionMode := SetPrecisionMode(2);

  if APrecision > 8 then APrecision := 8;
  case Integer(AFormat) of
      $00:
        Result := FloatToStrF(AValue, ffGeneral, 8, APrecision);
      $01, $02, $03, $04, $0B:
        Result := FormatFloat(AFFormat[AFormat - 1], AValue);
      $05, $06:
        Result := FormatFloat(AFFormat[$4 + Byte(AValue < 0)], Abs(AValue));
      $07,$08:
        Result := FormatFloat(AFFormat[$6 + Byte(AValue < 0)], Abs(AValue));
      $09, $0A:
        Result := FormatFloat(AFFormat[AFormat - 1], AValue * 100);
      $0E:
        Result := DateToStr(AValue);
      $0F, $10, $11, $14:
        Result := FormatDateTime(ADateFormat[AFormat - $0F], AValue);
      $12, $13:
        Result := AnsiUpperCase(FormatDateTime(ADateFormat[AFormat - $0F], AValue));
      $15:
        Result := TimeToStr(AValue);
      $16:
        Result := DateToStr(AValue) + ' ' + TimeToStr(AValue);
      $25, $26:
        Result := FormatFloat(AFFormat[11 + Byte(AValue < 0)], Abs(AValue));
      $27, $28:
        Result := FormatFloat(AFFormat[13 + Byte(AValue < 0)], Abs(AValue));
      $29, $2A, $2B, $2C:
        Result := GetFreeStateFormat(AFormat - $29);
      $2D:
        Result := FormatDateTime('nn:ss', AValue);
      $2E:
        Result := IntToStr(Round(Int(AValue) * 24 + Frac(AValue) / (1 / (1 / 24)))) +
          FormatDateTime(':nn:ss', AValue);
      $2F:
        Result := FormatDateTime('nn:ss', AValue) + '.' + FormatDateTime('z', AValue);
      $30:
        Result := FormatFloat('##0.0E+0', AValue);
      $A4:
        Result := FormatDateTime(AnsiUpperCase('dd/mm/yy'), AValue);
      $A5:
        Result := FormatDateTime(AnsiUpperCase('dd.mmmm.yy'), AValue);
    else
      Result := FloatToStr(AValue);
    end;
    if (AFormat in [$6, $8, $26, $28]) and (AValue < 0) then
      ATextColor := 2;

  SetPrecisionMode(APrecisionMode);
  SetRoundMode(ARoundMode);
end;

class function TcxSSUtils.PointInRect(const Rect: TRect; const P: TPoint): Boolean;
begin
  Result := (P.X >= Rect.Left) and (P.X <= Rect.Right) and
            (P.Y >= Rect.Top) and (P.Y <= Rect.Bottom);
end;

class function TcxSSUtils.IntersectRange(var AOutRect: TRange;
  ARect1, ARect2: TRange): Boolean;

  function AddPoint(const APoint: Int64; AIncX, AIncY: Integer): Int64;
  begin
    TPoint(Result).X := TPoint(APoint).X + AIncX;
    TPoint(Result).Y := TPoint(APoint).Y + AIncY;
  end;

begin
  ARect1.BottomRight := AddPoint(ARect1.BottomRight, 1, 1);
  ARect2.BottomRight := AddPoint(ARect2.BottomRight, 1, 1);
  Result := IntersectRect(TRect(AOutRect), TRect(ARect2), TRect(ARect1));
  if Result then
    AOutRect.BottomRight := AddPoint(AOutRect.BottomRight, -1, -1)
  else
    AOutRect.BottomRight := AddPoint(AOutRect.TopLeft, -1, -1);
end;

class function TcxSSUtils.RowNameByIndex(ARow: Integer; IsRCReferenceStyle: Boolean = False): string;
begin
  Result := IntToStr(ARow + 1);
end;

class function TcxSSUtils.ValueInRange(AValue, AFromValue, AToValue: Integer): Boolean;
begin
  Result := (AValue >= AFromValue) and (AValue <= AToValue)
end;

function GetLocaleStrW(Locale, LocaleType: Integer): WideString;
var
  L: Integer;
begin
  SetLength(Result, 255);
  L := GetLocaleInfoW(Locale, LocaleType, PWideChar(Result), Length(Result));
  if L > 0 then
    SetLength(Result, L - 1)
  else
    Result := '';
end;

procedure SetControlCodes;
begin
  cxBlankCharCode := Integer(' ') -  Integer('0');
  if dxFormatSettings.DecimalSeparator = dxFormatSettings.ThousandSeparator then
    cxThousandCharCode := Integer(' ') - Integer('0')
  else
    cxThousandCharCode := Integer(dxFormatSettings.ThousandSeparator) - Integer('0');
  cxDecimalCharCode := Integer(dxFormatSettings.DecimalSeparator) - Integer('0');
end;

initialization
  SetControlCodes;
end.
