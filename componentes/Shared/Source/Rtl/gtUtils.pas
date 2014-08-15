{******************************************************************************}
{                                                                              }
{  Gnostice Shared Visual Component Library                                    }
{                                                                              }
{  Copyright © 2002-2008 Gnostice Information Technologies Private Limited     }
{  http://www.gnostice.com                                                     }
{                                                                              }
{******************************************************************************}
{$I ..\gtSharedDefines.inc}

unit gtUtils;

interface

uses Windows, SysUtils, Graphics, StdCtrls, Controls, Classes, SyncObjs;

const
  { Default word delimiters are any character except the core alphanumerics. }
  WordDelimiters: set of AnsiChar = [#0..#255] - ['a'..'z','A'..'Z','1'..'9','0'];

var
  LockDecimalSep: TCriticalSection;

type
  THackWinControl = class(TWinControl);

  TgtByteArray = array of Byte;

  TStringSeachOption = (soDown, soMatchCase, soWholeWord);
  TStringSearchOptions = set of TStringSeachOption;

  TgtRect = record
    Left,
    Top,
    Right,
    Bottom: Double;
  end;

// Conditional Routines
function IfThen(AValue: Boolean; const ATrue: Integer;
  const AFalse: Integer = 0): Integer; overload;
function IfThen(AValue: Boolean; const ATrue: Int64;
  const AFalse: Int64 = 0): Int64; overload;
function IfThen(AValue: Boolean; const ATrue: Double;
  const AFalse: Double = 0.0): Double; overload;
function IfThen(AValue: Boolean; const ATrue: String;
  const AFalse: String = ''): String; overload;

// String Handling Routines
function RightStr(const AText: String; const ACount: Integer): String;
function LeftStr(const AText: String; const ACount: Integer): String;
function MidStr(const AText: String;
   const AStart, ACount: Integer): String;
function PosEx(const SubStr, S: String; Offset: Cardinal = 1): Integer;
function SearchBuf(Buf: PChar; BufLen: Integer; SelStart, SelLength: Integer;
  SearchString: String; Options: TStringSearchOptions = [soDown]): PChar;
function TryStrToInt(const S: String; out Value: Integer): Boolean;
function ReplaceString(const S, OldPattern, NewPattern: WideString): WideString;
  overload;
function ReplaceStringPos(const S: String;
   Offset: Integer; OldPattern, NewPattern: String): String;
function AnsiContainsText(const AText, ASubText: String): Boolean;

procedure FreeAndNil(var Obj);
function TextSize(const Text: String; AFont: TFont): TSize;

function ColorToPDFColor(AColor: TColor): String;
function ColorBGRToRGB(AColor: TColor): String;

procedure CheckSysColor(var Color: TColor);

procedure SetControlsEnabled(AControl: TWinControl; AState: Boolean);

// Unit Conversion Functions.
function DegreesToRadians(Degrees: Extended): Extended;
function PixelsToPoints(X: Extended): Extended;
function PointsToPixels(X: Extended): Extended;
function RadiansToDegrees(Radians: Extended): Extended;

// Conversion Routines
function IsHex(AString: String): Boolean;
function IsOctal(AString: String): Boolean;
function GetHexOfStr(AString: AnsiString): AnsiString;	
{$IFNDEF gtDelphi6Up}
procedure BinToHex(Buffer, Text: PChar; BufSize: Integer);
{$ENDIF}
function HexToByteArray(AHex: String): TgtByteArray;
function HexToByteValue(AHex: String; out AByte: Byte): Integer;
function HexToByteString(AHex: String): String;
procedure OctalToByteValue(AOctal: String; out AByte: Byte);
procedure EscapeStringToByteArray(AEscapeString: AnsiString;
  var AByte: array of Byte);
procedure EscapeStringToString(AEscapeString: String; var AString: String);
function StringToEscapeString(AString: String): String;
function ConvertTabsToSpaces(Str: String; Fonts: TFont; TabsStops: TStringList): String;

// Float to String Locale
function FloatToStrLocale(Value: Double):String;
function FloatToStrFLocale(Value: Extended; Format: TFloatFormat;
  Precision, Digits: Integer): String;
// String to Float Locale
function StrToFloatLocale(AString: String):Double;

function gtRect(Left, Top, Right, Bottom: Double): TgtRect; overload;
function gtRect(ARect: TgtRect; AFactor: Double): TgtRect; overload;
function gtRect(ARect: TgtRect; AXFactor, AYFactor: Double): TgtRect; overload;

// Font Charsets collection
procedure GetSupportedCharSets(const FaceName: String; CharSets: TList);

implementation
uses
  Math, gtConsts, Forms;

type
  TNewTextMetricEx = packed record
    NewTextMetric: TNewTextMetric;
    FontSignature: TFontSignature
  end;

(*----------------------------------------------------------------------------*)

function EnumFontFamExProc(const EnumLogFontEx: TEnumLogFontEx;
  const NewTextMetricEx: TNewTextMetricEx;
  FontType: Integer;
  lParam: TList): Integer; stdcall;
var
  LI: Integer;
begin
  LI := EnumLogFontEx.elfLogFont.lfCharSet;
  case (LI) of
    ANSI_CHARSET, SYMBOL_CHARSET, SHIFTJIS_CHARSET, HANGEUL_CHARSET,
    GB2312_CHARSET, CHINESEBIG5_CHARSET, OEM_CHARSET, JOHAB_CHARSET,
    HEBREW_CHARSET, ARABIC_CHARSET, GREEK_CHARSET, TURKISH_CHARSET,
    VIETNAMESE_CHARSET, THAI_CHARSET, EASTEUROPE_CHARSET, RUSSIAN_CHARSET,
    MAC_CHARSET, BALTIC_CHARSET:
    begin
      if (lParam.IndexOf(TObject(LI)) = -1) then
        lParam.Add(TObject(LI));
    end;
  end;
  Result := 1;
end;

procedure GetSupportedCharSets(const FaceName: String; CharSets: TList);
var
  DC: THandle;
  LogFont: TLogFont;
   {$IFDEF gtDelphi2009Up}
    LWideString: WideString;
    I: Integer;
  {$ENDIF}
begin
  DC := GetDC(GetDesktopWindow);
  if DC <> 0 then
    try
      FillChar(LogFont, SizeOf(LogFont), 0);
      {$IFDEF gtDelphi2009Up}
      LWideString := FaceName;
      for I := 0 to Length(LWideString) - 1 do
        LogFont.lfFaceName[I] := LWideString[I + 1];
      {$ELSE}
        Move(FaceName[1], LogFont.lfFaceName, Length(FaceName));
      {$ENDIF}
      LogFont.lfCharSet := DEFAULT_CHARSET;
      EnumFontFamiliesEx(DC, LogFont, @EnumFontFamExProc, lParam(CharSets), 0);
    finally
      ReleaseDC(GetDesktopWindow, DC)
    end
end;

(*----------------------------------------------------------------------------*)

function GetHexOfStr(AString: AnsiString): AnsiString;
begin
  Result := '';
  SetLength(Result, Length(AString)*2);
  BinToHex(PAnsiChar(AString), PAnsiChar(Result), Length(AString));
end;

(*----------------------------------------------------------------------------*)

function ColorToPDFColor(AColor: TColor): String;
	function PDFColor(HexCode: String): String;
	begin
    CheckSysColor(AColor);
		Result := Format('%1.4f',
			[StrToIntDef('$' + HexCode, 0) / 255]);
		if DecimalSeparator <> '.' then
			Result := ReplaceString(Result, DecimalSeparator, '.');
	end;

begin
	Result := Copy(IntToHex(ColorToRGB(AColor), 8), 3, 6);
	Result :=
    PDFColor(Copy(Result, 5, 2)) + ' ' +
    PDFColor(Copy(Result, 3, 2)) + ' ' +
		PDFColor(Copy(Result, 1, 2));
end;

(*----------------------------------------------------------------------------*)

function TextSize(const Text: String; AFont: TFont): TSize;
var
	DC: HDC;
	SaveFont: HFont;
  LSize: Tsize;
begin
	DC := GetDC(0);
	SaveFont := SelectObject(DC, AFont.Handle);
	GetTextExtentPoint32(DC, PChar(Text), Length(Text), LSize);
	SelectObject(DC, SaveFont);
	ReleaseDC(0, DC);
  Result := LSize;
end;

(*----------------------------------------------------------------------------*)

function RightStr(const AText: String; const ACount: Integer): String;
begin
  Result := Copy(WideString(AText), Length(WideString(AText)) + 1 - ACount, ACount);
end;

(*----------------------------------------------------------------------------*)

function LeftStr(const AText: String; const ACount: Integer): String;
begin
  Result := Copy(WideString(AText), 1, ACount);
end;

(*----------------------------------------------------------------------------*)

function MidStr(const AText: String; const AStart, ACount: Integer): String;
begin
  Result := Copy(WideString(AText), AStart, ACount);
end;

(*----------------------------------------------------------------------------*)

function PosEx(const SubStr, S: String; Offset: Cardinal = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;

(*----------------------------------------------------------------------------*)

function SearchBuf(Buf: PChar; BufLen: Integer; SelStart, SelLength: Integer;
  SearchString: String; Options: TStringSearchOptions): PChar;
var
  SearchCount, I: Integer;
  C: Char;
  Direction: Shortint;
  ShadowMap: array[0..256] of Char;
  CharMap: array [Char] of Char absolute ShadowMap;

  function FindNextWordStart(var BufPtr: PChar): Boolean;
  begin                   { (True XOR N) is equivalent to (not N) }
                          { (False XOR N) is equivalent to (N)    }
     { When Direction is forward (1), skip non delimiters, then skip delimiters. }
     { When Direction is backward (-1), skip delims, then skip non delims }
    {$IFDEF gtDelphi2009Up}
        while (SearchCount > 0) and
          ((Direction = 1) xor Sysutils.CharInSet(BufPtr^,WordDelimiters)) do
     {$ELSE}
    while (SearchCount > 0) and
          ((Direction = 1) xor (BufPtr^ in WordDelimiters)) do
    {$ENDIF}
    begin
      Inc(BufPtr, Direction);
      Dec(SearchCount);
    end;
    {$IFDEF gtDelphi2009Up}
    while (SearchCount > 0) and
          ((Direction = -1) xor Sysutils.CharInSet(BufPtr^, WordDelimiters)) do
    {$ELSE}
    while (SearchCount > 0) and
          ((Direction = -1) xor (BufPtr^ in WordDelimiters)) do
    {$ENDIF}
    begin
      Inc(BufPtr, Direction);
      Dec(SearchCount);
    end;
    Result := SearchCount > 0;
    if Direction = -1 then
    begin   { back up one Char, to leave ptr on first non delim }
      Dec(BufPtr, Direction);
      Inc(SearchCount);
    end;
  end;

begin
  Result := nil;
  if BufLen <= 0 then Exit;
  if soDown in Options then
  begin
    Direction := 1;
    Inc(SelStart, SelLength);  { start search past end of selection }
    SearchCount := BufLen - SelStart - Length(SearchString) + 1;
    if SearchCount < 0 then Exit;
    if Longint(SelStart) + SearchCount > BufLen then Exit;
  end
  else
  begin
    Direction := -1;
    Dec(SelStart, Length(SearchString));
    SearchCount := SelStart + 1;
  end;
  if (SelStart < 0) or (SelStart > BufLen) then Exit;
  Result := @Buf[SelStart];

  { Using a Char map array is faster than calling AnsiUpper on every character }
  for C := Low(CharMap) to High(CharMap) do
    CharMap[C] := C;
  { Since CharMap is overlayed onto the ShadowMap and ShadowMap is 1 byte longer,
    we can use that extra byte as a guard NULL }
  ShadowMap[256] := #0;

  if not (soMatchCase in Options) then
  begin
{$IFDEF MSWINDOWS}
    AnsiUpperBuff(PAnsiChar(@CharMap), sizeof(CharMap));
    AnsiUpperBuff(@SearchString[1], Length(SearchString));
{$ENDIF}
{$IFDEF LINUX}
    AnsiStrUpper(@CharMap[#1]);
    SearchString := AnsiUpperCase(SearchString);
{$ENDIF}
  end;

  while SearchCount > 0 do
  begin
    if (soWholeWord in Options) and (Result <> @Buf[SelStart]) then
      if not FindNextWordStart(Result) then Break;
    I := 0;
    while (CharMap[Result[I]] = SearchString[I+1]) do
    begin
      Inc(I);
      if I >= Length(SearchString) then
      begin
      {$IFDEF gtDelphi2009Up}
       if (not (soWholeWord in Options)) or
           (SearchCount = 0) or
           SysUtils.CharInSet(Result[I],WordDelimiters) then
      {$ELSE}
        if (not (soWholeWord in Options)) or
           (SearchCount = 0) or
           (Result[I] in WordDelimiters) then
      {$ENDIF}
          Exit;
        Break;
      end;
    end;
    Inc(Result, Direction);
    Dec(SearchCount);
  end;
  Result := nil;
end;

(*----------------------------------------------------------------------------*)

function TryStrToInt(const S: String; out Value: Integer): Boolean;
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;

(*----------------------------------------------------------------------------*)

function ReplaceString(const S, OldPattern, NewPattern: WideString): WideString;
var
  I: Integer;
  SearchStr, Str, OldPat: WideString;
begin
  Result := '';
  if S <> '' then
  if IsDBCSLeadByte(Byte(S[1])) then
  begin
    SearchStr := AnsiUpperCase(S);
    OldPat := AnsiUpperCase(OldPattern);
    Str := S;
    Result := '';
    while SearchStr <> '' do
    begin
      I := AnsiPos(OldPat, SearchStr);
      if I = 0 then
      begin
        Result := Result + Str;
        Break;
      end;
      Result := Result + Copy(Str, 1, I - 1) + NewPattern;
      Str := Copy(Str, I + Length(OldPattern), MaxInt);
      SearchStr := Copy(SearchStr, I + Length(OldPat), MaxInt);
    end;
  end
  else
  begin
    SearchStr := AnsiUpperCase(S);
    OldPat := AnsiUpperCase(OldPattern);
    Str := S;
    Result := '';
    while SearchStr <> '' do
    begin
      I := AnsiPos(OldPat, SearchStr);
      if I = 0 then
      begin
        Result := Result + Str;
        Break;
      end;
      Result := Result + Copy(Str, 1, I - 1) + NewPattern;
      Str := Copy(Str, I + Length(OldPattern), MaxInt);
      SearchStr := Copy(SearchStr, I + Length(OldPat), MaxInt);
    end;
  end;
end;

(*----------------------------------------------------------------------------*)

function ReplaceStringPos(const S: String; Offset: Integer;
  OldPattern, NewPattern: String): String;
var
  I: Integer;
  SearchStr, Str, OldPat: String;
begin
  SearchStr := AnsiUpperCase(S);
  OldPat := AnsiUpperCase(OldPattern);
  Str := S;
  Result := '';

  Result := Copy(Str, 1, Offset-1);
  Str := Copy(Str, Offset, MaxInt);
  SearchStr := AnsiUpperCase(Str);

  I := AnsiPos(OldPat, SearchStr);
  if I = 0 then
  begin
    Result := Result + Str;
    Exit;
  end;
  Result := Result + Copy(Str, 1, I - 1) + NewPattern;
  Result := Result + Copy(Str, I+Length(OldPattern), MaxInt);
end;

(*----------------------------------------------------------------------------*)

function AnsiContainsText(const AText, ASubText: String): Boolean;
begin
  Result := AnsiPos(AnsiUppercase(ASubText), AnsiUppercase(AText)) > 0;
end;

(*----------------------------------------------------------------------------*)
{$IFNDEF gtDelphi6Up}
procedure BinToHex(Buffer, Text: PChar; BufSize: Integer);
const
  Convert: array[0..15] of Char = '0123456789ABCDEF';
var
  I: Integer;
begin
  for I := 0 to BufSize - 1 do
  begin
    Text[0] := Convert[Byte(Buffer[I]) shr 4];
    Text[1] := Convert[Byte(Buffer[I]) and $F];
    Inc(Text, 2);
  end;
end;
{$ENDIF}
(*----------------------------------------------------------------------------*)

function StringToEscapeString(AString: String): String;
var
  LI, Tabs, Rem, Pos, I, Count: Integer;
  TempStr: String;
begin
  Tabs := 8;
  Count := 8;
  Result := '';
  TempStr := '';
  for LI := 1 to Length(AString) do
  begin
    case AString[LI] of
      '(':
        begin
          Result := Result + '\(';
          Count := Count - 1;
        end;
      ')':
        begin
          Result := Result + '\)';
          Count := Count - 1;
        end;
      '\':
        begin
          Result := Result + '\\';
          Count := Count - 1;
        end;
      #13:
        begin
         Result := Result + '\r';
         Count := Count - 1;
        end;
      #10:
        begin
          Result := Result + '\n';
          Count := Count - 1;
        end;
      #9 :
        begin
          Rem := 8 - Count;
          Pos := Tabs - Rem;
          for I := LI to (LI + Pos -1) do
          begin
            TempStr := TempStr + ' ';
            Count := Count - 1;
          end;
          Result := Result + TempStr;
          TempStr := '';
        end;
      #8 : Result := Result + '\b';
      #12: Result := Result + '\f';
      else
      begin
        Result := Result + AString[LI];
        Count := Count - 1;
      end;
    end;
    if (Count = 0) then
      Count := 8;
  end;
end;

(*----------------------------------------------------------------------------*)

function GetCountOfSpaces(Spaces: Double; SingleSpaces: Double; UseDefault: Boolean): integer;
var
  Time: Integer;
begin
  if not UseDefault then
    Time := round(Spaces / (double(SingleSpaces) / round(CPixelsPerInch)))
  else
    Time := Floor(Spaces / SingleSpaces);
  Result := Time;
end;

(*----------------------------------------------------------------------------*)

function GetRemainingSpaces(DataWidths: Double; TabSpaces: Double): double;
var
  Spaces, Extras: Double;
begin
  if (DataWidths > TabSpaces) then
  begin
    Extras := DataWidths - TabSpaces;
    while Extras > TabSpaces do
      Extras := Extras - TabSpaces;
    Spaces := TabSpaces - Extras;
  end
  else
    Spaces := TabSpaces - DataWidths;
  Result := Spaces;
end;

(*----------------------------------------------------------------------------*)

function ConvertTabsToSpaces(Str: String; Fonts: TFont; TabsStops: TStringList): String;
var
  UseDefaultTab, IsVisited: Boolean;
  L, N, LI, Times, T, K: Integer;
  Space, Extra, DataWidth, SingleSpace, TabSpace, Diff, PrevTab: Double;
  Data: String;
begin
  Data := '';
  UseDefaultTab := False;
  IsVisited := False;
  L := 0;
  T := 0;
  K := 0;
  PrevTab := 0.0;
  Diff := 0.0;
  Space := 0.0;

  N := TabsStops.Count;
  Result := '';
  for LI := 1 to Length(Str)do
  begin
    if Str[LI] = #9 then
    begin
      DataWidth := TextSize(Data, Fonts).cx;
      SingleSpace := TextSize(' ', Fonts).cx;
      // Conversion of Tab Value from Inches to Pixels
      TabSpace := (2.083 / 32) * Fonts.Size * CPixelsPerInch;
      // For none specified in the TStringlist
      if N = 0 then
      begin
        UseDefaultTab := True;
        Space := GetRemainingSpaces(DataWidth, TabSpace);
      end
      else if N = 1 then
      begin
        // For only 1 no. in TStringList
        if ((Double(DataWidth) / round(CPixelsPerInch)) >
           (StrToFloat(TabsStops.Strings[0]) / 25400))  then
        begin
          Extra := (Double(DataWidth) / round(CPixelsPerInch)) -
                   (StrToFloat(TabsStops.Strings[0]) / 25400);
          while Extra > (StrToFloat(TabsStops.Strings[0]) / 25400) do
            Extra := Extra - (StrToFloat(TabsStops.Strings[0]) / 25400);
          Space := (StrToFloat(TabsStops.Strings[0]) / 25400) - Extra;
        end
        else
          Space := (StrToFloat(TabsStops.Strings[0]) / 25400) -
          (Double(DataWidth) / round(CPixelsPerInch));
      end
      else
      begin
        // For more than 1 entries in TSringList
        if L < N then
        begin
          T := L;
          Diff := (StrToFloat(TabsStops.Strings[L]) / 25400) - PrevTab;
        end;
        if ((L+1) < N) then
        begin
          if ((Double(DataWidth) / round(CPixelsPerInch)) > Diff) then
          begin
            Extra := (Double(DataWidth) / round(CPixelsPerInch));
            while Extra > Diff do
            begin
              Extra := Extra - Diff;
              PrevTab := (StrToFloat(TabsStops.Strings[L]) / 25400);
              if (((L+1) <= N) and (L = T)) then
              begin
                L := L + 1;
                T := L;
                Diff := (StrToFloat(TabsStops.Strings[L]) / 25400) - PrevTab;
                Space := Diff - Extra;
              end
              else
              begin
                UseDefaultTab := True;
                Space := GetRemainingSpaces(DataWidth, TabSpace);
              end;
            end;
            PrevTab := (StrToFloat(TabsStops.Strings[L]) / 25400);
            if (((L+1) <= N) and (L = T)) then
            begin
              L := L + 1;
            end
            else
            begin
              UseDefaultTab := True;
              Space := GetRemainingSpaces(DataWidth, TabSpace);
            end;
          end
          else
          begin
            Space := Diff - (Double(DataWidth) / round(CPixelsPerInch));
            PrevTab := (StrToFloat(TabsStops.Strings[L]) / 25400);
            if (((L+1) <= N) and (L = T)) then
            begin
              L := L + 1;
            end
            else
            begin
              UseDefaultTab := True;
              Space := GetRemainingSpaces(DataWidth, TabSpace);
            end;
          end;
        end
        else
        begin
          if ((L = N) or (L = (N-1)))then
          begin
            K := K + 1;
            if IsVisited then
            begin
              UseDefaultTab := True;
              Space := GetRemainingSpaces(DataWidth, TabSpace);
            end
            else
            begin
              Space := Diff - (Double(DataWidth) / round(CPixelsPerInch));
              if K = 2 then
                IsVisited := True
              else
                L := L + 1;
            end;
          end
          else
          begin
            UseDefaultTab := True;
            Space := GetRemainingSpaces(DataWidth, TabSpace);
          end;
        end;
      end;

      Times := GetCountOfSpaces(Space, SingleSpace, UseDefaultTab);
      Result := Result + StringOfChar(' ', Times);
      Data := '';
    end
    else
    begin
      Result := Result + Str[LI];
      Data := Data + Str[LI];
    end;
  end;
end;

(*----------------------------------------------------------------------------*)

procedure FreeAndNil(var Obj);
var
  Temp: TObject;
begin
  Temp := TObject(Obj);
  Pointer(Obj) := nil;
  Temp.Free;
end;

(*----------------------------------------------------------------------------*)

function IfThen(AValue: Boolean; const ATrue: Integer;
  const AFalse: Integer = 0): Integer;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

(*----------------------------------------------------------------------------*)

function IfThen(AValue: Boolean; const ATrue: Int64;
  const AFalse: Int64 = 0): Int64;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

(*----------------------------------------------------------------------------*)

function IfThen(AValue: Boolean; const ATrue: Double;
  const AFalse: Double = 0.0): Double; overload;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

(*----------------------------------------------------------------------------*)

function IfThen(AValue: Boolean; const ATrue: String;
  const AFalse: String = ''): String; overload;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

(*----------------------------------------------------------------------------*)

function DegreesToRadians(Degrees: Extended): Extended;
begin
	Result := Degrees * (PI / 180);
end;

(*----------------------------------------------------------------------------*)

function PixelsToPoints(X: Extended): Extended;
begin
	Result := X / CPixelsPerInch * CInchesToPoints;
end;

(*----------------------------------------------------------------------------*)

function PointsToPixels(X: Extended): Extended;
begin
  Result := X * CPointsToPixels;
end;

(*----------------------------------------------------------------------------*)

function RadiansToDegrees(Radians: Extended): Extended;
begin
	Result := Radians * (180 / PI);
end;

(*----------------------------------------------------------------------------*)

function ColorBGRToRGB(AColor: TColor): String;
begin
  CheckSysColor(AColor);
	Result := IntToHex(GetRValue(AColor), 2) +
  	IntToHex(GetGValue(AColor), 2) + IntToHex(GetBValue(AColor), 2);
end;

procedure CheckSysColor(var Color: TColor);
const
  CgtSysColor = $FF000000;
begin
  if (Color and CgtSysColor) = CgtSysColor then
  begin
    Color := Color and (not CgtSysColor);
    Color := GetSysColor(Color);
  end;
end;

(*----------------------------------------------------------------------------*)

procedure SetControlsEnabled(AControl: TWinControl; AState: Boolean);
const
	StateColor: array[Boolean] of TColor = (clInactiveBorder, clWindow);
var
	I: Integer;
begin
	with AControl do
	for I := 0 to ControlCount - 1 do
		begin
			if ((Controls[I] is TWinControl) and
					(TWinControl(Controls[I]).ControlCount > 0)) then
				SetControlsEnabled(TWinControl(Controls[I]), AState);
			if (Controls[I] is TCustomEdit) then
				THackWinControl(Controls[I]).Color := StateColor[AState]
			else if (Controls[I] is TCustomComboBox) then
				THackWinControl(Controls[I]).Color := StateColor[AState];
			Controls[I].Enabled := AState;
		end;
end;

(*----------------------------------------------------------------------------*)

function IsHex(AString: String): Boolean;
var
  LI: Integer;
  LString: String;
begin
  Result := False;
  LString := UpperCase(AString);

  for LI := 1 to Length(AString) do
    if (LString[LI] < '0') or
      ((AString[LI] > '9') and (AString[LI] < 'A')) or
      ((AString[LI] < 'A') and (AString[LI] > 'F')) then
      Exit;

  Result := True;
end;

(*----------------------------------------------------------------------------*)

function HexToByteArray(AHex: String): TgtByteArray;
var
  LS: String;
  LI, LJ, LLength: Integer;
begin
  SetLength(LS, 2);
  SetLength(Result, 0);
  LLength := Length(AHex);
  LI := 0;
  LJ := 0;
  while (LI < LLength) do
  begin
    while not (IsHex(AHex[LI])) do
      Inc(LI);
    LS[1] := AHex[LI];
    Inc(LI);

    while not (IsHex(AHex[LI])) do
      Inc(LI);
    LS[2] := AHex[LI];
    Inc(LI);
    
    SetLength(Result, Length(Result) + 1);
    if (HexToByteValue(PChar(LS), Result[LJ]) <> 0) then
      Exit;
    Inc(LJ);
  end;    
end;

(*----------------------------------------------------------------------------*)

function HexToByteValue(AHex: String; out AByte: Byte): Integer;
const
  Convert: array['0'..'f'] of SmallInt =
    ( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15);
var
  LI, LJ: Integer;
begin
  Result := -1;
  AByte := 0;
  LJ := 0;

  if not IsHex(AHex) then Exit;

  for LI := Length(AHex) downto 1 do
  begin
    AByte := AByte + Convert[AHex[LI]] * Trunc(Power(16, LJ));
    Inc(LJ);
  end;
  Result := 0;
end;

(*----------------------------------------------------------------------------*)

function HexToByteString(AHex: String): String;
var
  LI: Integer;
  LS: String;
  LByte: Byte;
begin
  SetLength(LS, 2);
  LI := 0;
  while (LI < Length(AHex)) do
  begin
    while not (IsHex(AHex[LI])) do
      Inc(LI);

    LS[1] := AHex[LI];

    Inc(LI);
    while not (IsHex(AHex[LI])) do
      Inc(LI);

    LS[2] := AHex[LI];
    Inc(LI);
    if (HexToByteValue(PChar(LS), LByte) <> 0) then
      Exit
    else
      Result := Result + Chr(LByte);
  end;
end;

(*----------------------------------------------------------------------------*)

procedure EscapeStringToByteArray(AEscapeString: AnsiString;
  var AByte: array of Byte);
var
  LI, LJ, LLength: Integer;
  LChar: AnsiString;
  LOctal: AnsiString;
  LByte: Byte;
  LIndex: Integer;
begin
  if (Length(AByte) = 0) then
    Exit;

  LIndex := 0;
  SetLength(LChar, 1);
  SetLength(LOctal, 3);
  LI := 1;
  LLength := Length(AEscapeString);
  repeat
    if (AEscapeString[LI] = '\') then
    begin
      case AEscapeString[LI + 1] of
        'n':
          begin
            LChar := LF;
            Inc(LI, 2);
          end;
        'r':
          begin
            LChar := CR;
            Inc(LI, 2);
          end;            
        't':
          begin
            LChar := Tab;
            Inc(LI, 2);
          end;
        '(':
          begin
            LChar := '(';
            Inc(LI, 2);
          end;            
        ')':
          begin
            LChar := ')';
            Inc(LI, 2);
          end;          
        '\':
          begin
            LChar := '\';
            Inc(LI, 2);
          end;
        else
        begin
        {$IFDEF gtDelphi2009Up}
          if SysUtils.CharInSet(AEscapeString[LI + 1],['0'..'8']) then
        {$ELSE}
          if AEscapeString[LI + 1] in ['0'..'8'] then
        {$ENDIF}
          begin
            Inc(LI);
            LJ := 1;
            LOctal := '';
            {$IFDEF gtDelphi2009Up}
              while SysUtils.CharInSet(AEscapeString[LI],['0'..'8']) and (LJ <= 3) do
            {$ELSE}
              while (AEscapeString[LI] in ['0'..'8']) and (LJ <= 3) do
            {$ENDIF}
            begin
              SetLength(LOctal, Length(LOctal) + 1);
              LOctal[LJ] := AEscapeString[LI];
              Inc(LJ);
              Inc(LI);
            end;
            if (LJ = 2) then
              Insert('00', LOctal, 1)
            else if (LJ = 3) then
              Insert('0', LOctal, 1);
            if (LJ > 1) then
            begin
             OctalToByteValue(String(LOctal), LByte);
              LChar := AnsiChar(LByte);
            end;
          end
          else
          begin
            LChar := AEscapeString[LI];
            Inc(LI);
          end;
        end
      end; (* End Case *)
    end
    else
    begin
      LChar := AEscapeString[LI];
      Inc(LI);
    end;
    AByte[LIndex] := Ord(LChar[1]);
    Inc(LIndex);
  until(LI > LLength);
end;

(*----------------------------------------------------------------------------*)

procedure EscapeStringToString(AEscapeString: String;
  var AString: String);
var
  LI, LJ, LLength: Integer;
  LChar: String;
  LOctal: String;
  LByte: Byte;
begin
  if AEscapeString = '' then Exit;
  SetLength(LChar, 1);
  SetLength(LOctal, 3);
  LI := 1;
  LLength := Length(AEscapeString);
  SetLength(AString, 0);
  repeat
    if (AEscapeString[LI] = '\') then
    begin
      case AEscapeString[LI + 1] of
        'n':
          begin
            LChar := LF;
            Inc(LI, 2);
          end;
        'r':
          begin
            LChar := CR;
            Inc(LI, 2);
          end;
        't':
          begin
            LChar := TAB;
            Inc(LI, 2);
          end;
        'b':
          begin
            LChar := BS;
            Inc(LI, 2);
          end;
        'f':
          begin
            LChar := FF;
            Inc(LI, 2);
          end;
        '(':
          begin
            LChar := '(';
            Inc(LI, 2);
          end;            
        ')':
          begin
            LChar := ')';
            Inc(LI, 2);
          end;
        '\':
          begin
            LChar := '\';
            Inc(LI, 2);
          end;            
        else
        begin
        {$IFDEF gtDelphi2009Up}
          if SysUtils.CharInSet(AEscapeString[LI + 1], ['0'..'8']) then
        {$ELSE}
          if AEscapeString[LI + 1] in ['0'..'8'] then
       {$ENDIF}
          begin
            Inc(LI);
            LJ := 1;
            LOctal := '';
            {$IFDEF gtDelphi2009Up}
            while SysUtils.CharInSet(AEscapeString[LI], ['0'..'8']) and
            {$ELSE}
            while (AEscapeString[LI] in ['0'..'8']) and
            {$ENDIF}
              (LJ <= 3) do
            begin
              SetLength(LOctal, Length(LOctal) + 1);
              LOctal[LJ] := AEscapeString[LI];
              Inc(LJ);
              Inc(LI);
            end;
            if (LJ = 2) then
              Insert('00', LOctal, 1)
            else if (LJ = 3) then
              Insert('0', LOctal, 1);
            if (LJ > 1) then
            begin
              OctalToByteValue(LOctal, LByte);
              LChar := Chr(LByte);
            end;
          end
          else
          begin
            LChar := AEscapeString[LI];
            Inc(LI);
          end;
        end
      end; (* End Case *)
    end
    else
    begin
      LChar := AEscapeString[LI];
      Inc(LI);
    end;
    SetLength(AString, (Length(AString) + 1));
    AString[Length(AString)] := LChar[1];
  until(LI > LLength);
end;

(*----------------------------------------------------------------------------*)

procedure OctalToByteValue(AOctal: String; out AByte: Byte);
const
  Convert: array['0'..'8'] of SmallInt = ( 0, 1, 2, 3, 4, 5, 6, 7, 8);
var
  LI, LJ: Integer;
begin
  AByte := 0;
  LJ := 0;

  if not IsOctal(AOctal) then Exit;

  for LI := Length(AOctal) downto 1 do
  begin
    AByte := AByte + Convert[AOctal[LI]] * Trunc(Power(8, LJ));
    Inc(LJ);
  end;
end;

(*----------------------------------------------------------------------------*)

function IsOctal(AString: String): Boolean;
var
  LI: Integer;
begin
  Result := False;

  for LI := 1 to Length(AString) do
    if ((AString[LI] < '0') or (AString[LI] > '8')) then
      Exit;

  Result := True;
end;

(*----------------------------------------------------------------------------*)

function FloatToStrLocale(Value: Double):String;
var
  LDesSep: Char;
begin
  LDesSep := DecimalSeparator;
  LockDecimalSep.Acquire;
  try
    DecimalSeparator := '.';
    Result := FloatToStr(Value);
    DecimalSeparator := LDesSep;
  finally
    LockDecimalSep.Release;
  end;
end;
{------------------------------------------------------------------------------}

function FloatToStrFLocale(Value: Extended; Format: TFloatFormat;
  Precision, Digits: Integer): String;
var
  LDesSep: Char;
begin
  LDesSep := DecimalSeparator;
  LockDecimalSep.Acquire;
  try
    DecimalSeparator := '.';
    Result := FloatToStrF(Value,Format,Precision,Digits);
    DecimalSeparator := LDesSep;
  finally
    LockDecimalSep.Release;
  end;
end;
{------------------------------------------------------------------------------}

function StrToFloatLocale(AString: String):Double;
var
  LDesSep: Char;
begin
  LDesSep := DecimalSeparator;
  LockDecimalSep.Acquire;
  try
    DecimalSeparator := '.';
    Result := StrToFloat(AString);
    DecimalSeparator := LDesSep;
  finally
    LockDecimalSep.Release;
  end;
end;
{------------------------------------------------------------------------------}



{ General Procedure}

function gtRect(Left, Top, Right, Bottom: Double): TgtRect;
begin
  Result.Left := Left;
  Result.Top := Top;
  Result.Right := Right;
  Result.Bottom := Bottom;
end;
{------------------------------------------------------------------------------}

function gtRect(ARect: TgtRect; AFactor: Double): TgtRect;
begin
  with ARect do
  begin
    Result.Left := Left * AFactor;
    Result.Top := Top * AFactor;
    Result.Right := Right * AFactor;
    Result.Bottom := Bottom * AFactor;
  end;
end;
{------------------------------------------------------------------------------}

function gtRect(ARect: TgtRect; AXFactor, AYFactor: Double): TgtRect;
begin
  with ARect do
  begin
    Result.Left := Left * AXFactor;
    Result.Top := Top * AYFactor;
    Result.Right := Right * AXFactor;
    Result.Bottom := Bottom * AYFactor;
  end;
end;

initialization

  LockDecimalSep := TCriticalSection.Create;

finalization
  LockDecimalSep.free;
(*----------------------------------------------------------------------------*)
end.
