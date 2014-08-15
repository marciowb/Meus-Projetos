
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressCoreLibrary                                           }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSCORELIBRARY AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
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

unit dxCore;

{$I cxVer.inc}

interface

uses
  Windows, Classes, SysUtils, Variants, Contnrs, Graphics;

const
  dxBuildNumber = 54;
  dxUnicodePrefix: Word = $FEFF;

type
{$IFNDEF DELPHI12}
  TBytes = array of Byte;
  TRecordBuffer = PAnsiChar;
  TValueBuffer = Pointer;
{$ENDIF}
  TRects = array of TRect;
  TRGBColors = array of TRGBQuad;

  TdxCorner = (coTopLeft, coTopRight, coBottomLeft, coBottomRight);

  IdxLocalizerListener = interface
  ['{2E98333B-1A56-4599-8A85-C2540E182032}']
    procedure TranslationChanged;
  end;

  TdxAnsiCharSet = set of AnsiChar;

  { TdxStream }

  TdxStream = class(TStream)
  private
    FIsUnicode: Boolean;
    FStream: TStream;
  protected
  {$IFDEF DELPHI7}
    function GetSize: Int64; override;
  {$ENDIF}
  public
    constructor Create(AStream: TStream); virtual;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;

    property IsUnicode: Boolean read FIsUnicode;
    property Stream: TStream read FStream;
  end;

  TdxProductResourceStrings = class;

  TdxAddResourceStringsProcedure = procedure(AProduct: TdxProductResourceStrings);

  TdxProductResourceStrings = class
  private
    FName: string;
    FInitializeProc: TdxAddResourceStringsProcedure;
    FResStringNames: TStrings;

    function GetNames(AIndex: Integer): string;
    function GetResStringsCount: Integer;
    procedure SetTranslation(AIndex: Integer);
    function GetValues(AIndex: Integer): string;
    procedure InitializeResStringNames;
  protected
    procedure Translate;
  public
    constructor Create(const AName: string; AInitializeProc: TdxAddResourceStringsProcedure); virtual;
    destructor Destroy; override;
    procedure Add(const AResStringName: string; AResStringAddr: Pointer);
    procedure Clear;
    function GetIndexByName(const AName: string): Integer;

    property Name: string read FName;
    property Names[AIndex: Integer]: string read GetNames;
    property ResStringsCount: Integer read GetResStringsCount;
    property Values[AIndex: Integer]: string read GetValues;
  end;

  TdxLocalizationTranslateResStringEvent = procedure(const AResStringName: string; AResString: Pointer) of object;

  TdxResourceStringsRepository = class
  private
    FListeners: TList;
    FProducts: TObjectList;
    FOnTranslateResString: TdxLocalizationTranslateResStringEvent;

    function GetProducts(AIndex: Integer): TdxProductResourceStrings;
    function GetProductsCount: Integer;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure AddListener(AListener: IdxLocalizerListener);
    procedure RemoveListener(AListener: IdxLocalizerListener);
    procedure NotifyListeners;

    procedure RegisterProduct(const AProductName: string; AAddStringsProc: TdxAddResourceStringsProcedure);
    function GetProductIndexByName(const AName: string): Integer;
    function GetOriginalValue(const AName: string): string;
    procedure Translate;
    procedure UnRegisterProduct(const AProductName: string);

    property Products[Index: Integer]: TdxProductResourceStrings read GetProducts;
    property ProductsCount: Integer read GetProductsCount;
    property OnTranslateResString: TdxLocalizationTranslateResStringEvent read FOnTranslateResString write FOnTranslateResString;
  end;

  TDayArray = array[1..7] of string;
  TMonthArray = array[1..12] of string;

  TdxFormatSettings = class
  private
    function GetLongDayNames(AIndex: Integer): string; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetLongMonthNames(AIndex: Integer): string; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetShortDayNames(AIndex: Integer): string; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetShortMonthNames(AIndex: Integer): string; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetCurrencyDecimals: Byte; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetCurrencyFormat: Byte; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetCurrencyString: string; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetDateSeparator: Char; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetDecimalSeparator: Char; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetListSeparator: Char; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetLongDateFormat: string; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetLongTimeFormat: string; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetNegCurrFormat: Byte; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetShortDateFormat: string; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetShortTimeFormat: string; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetThousandSeparator: Char; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetTimeAMString: string; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetTimePMString: string; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetTimeSeparator: Char; {$IFDEF DELPHI9} inline; {$ENDIF}
    procedure SetThousandSeparator(AValue: Char); {$IFDEF DELPHI9} inline; {$ENDIF}
    procedure SetDecimalSeparator(AValue: Char); {$IFDEF DELPHI9} inline; {$ENDIF}
    procedure SetCurrencyDecimals(AValue: Byte); {$IFDEF DELPHI9} inline; {$ENDIF}
    procedure SetCurrencyString(AValue: string); {$IFDEF DELPHI9} inline; {$ENDIF}
    procedure SetShortDateFormat(AValue: string); {$IFDEF DELPHI9} inline; {$ENDIF}
  public
    property CurrencyFormat: Byte read GetCurrencyFormat;
    property NegCurrFormat: Byte read GetNegCurrFormat;
    property ThousandSeparator: Char read GetThousandSeparator write SetThousandSeparator;
    property DecimalSeparator: Char read GetDecimalSeparator write SetDecimalSeparator;
    property CurrencyDecimals: Byte read GetCurrencyDecimals write SetCurrencyDecimals;
    property DateSeparator: Char read GetDateSeparator;
    property TimeSeparator: Char read GetTimeSeparator;
    property ListSeparator: Char read GetListSeparator;
    property CurrencyString: string read GetCurrencyString write SetCurrencyString;
    property ShortDateFormat: string read GetShortDateFormat write SetShortDateFormat;
    property LongDateFormat: string read GetLongDateFormat;
    property TimeAMString: string read GetTimeAMString;
    property TimePMString: string read GetTimePMString;
    property ShortTimeFormat: string read GetShortTimeFormat;
    property LongTimeFormat: string read GetLongTimeFormat;
    property ShortMonthNames[AIndex: Integer]: string read GetShortMonthNames;
    property LongMonthNames[AIndex: Integer]: string read GetLongMonthNames;
    property ShortDayNames[AIndex: Integer]: string read GetShortDayNames;
    property LongDayNames[AIndex: Integer]: string read GetLongDayNames;
//    property TwoDigitYearCenturyWindow: Word;
  end;

  EdxException = class(Exception);

  EdxTestException = class(EdxException);
  procedure dxTestCheck(AValue: WordBool; AMessage: string);

// string functions
function dxBinToHex(const ABuffer: AnsiString): AnsiString; overload;
function dxBinToHex(const ABuffer: PAnsiChar; ABufSize: Integer): AnsiString; overload;
function dxHexToBin(const AText: AnsiString): AnsiString; overload;
function dxHexToBin(const AText: PAnsiChar): AnsiString; overload;
function dxHexToByte(const AHex: string): Byte;
function dxCharCount(const S: string): Integer; {$IFDEF DELPHI9} inline;{$ENDIF}
function dxCharInSet(C: Char; const ACharSet: TdxAnsiCharSet): Boolean; {$IFDEF DELPHI9} inline;{$ENDIF}
function dxStringSize(const S: string): Integer; {$IFDEF DELPHI9} inline;{$ENDIF}

function dxAnsiIsAlpha(Ch: AnsiChar): Boolean;
function dxCharIsAlpha(Ch: Char): Boolean;
function dxWideIsAlpha(Ch: WideChar): Boolean;
function dxAnsiIsNumeric(Ch: AnsiChar): Boolean;
function dxCharIsNumeric(Ch: Char): Boolean;
function dxWideIsNumeric(Ch: WideChar): Boolean;

function dxGetCodePageFromCharset(ACharset: Integer): Integer;
function dxGetStringTypeA(Locale: LCID; dwInfoType: DWORD; const lpSrcStr: PAnsiChar;
  cchSrc: Integer; var lpCharType): BOOL;
function dxGetStringTypeW(dwInfoType: DWORD; const lpSrcStr: PWideChar;
  cchSrc: Integer; var lpCharType): BOOL;
function dxGetAnsiCharCType1(Ch: AnsiChar): Word;
function dxGetWideCharCType1(Ch: WideChar): Word;

// string conversions
function dxAnsiStringToWideString(const ASource: AnsiString; ACodePage: Cardinal = CP_ACP;
  ASrcLength: Integer = -1): WideString;
function dxWideStringToAnsiString(const ASource: WideString; ACodePage: Cardinal = CP_ACP;
  ASrcLength: Integer = -1): AnsiString;

function dxAnsiStringToString(const S: AnsiString; ACodePage: Integer = CP_ACP): string; {$IFDEF DELPHI9} inline;{$ENDIF}
function dxStringToAnsiString(const S: string; ACodePage: Integer = CP_ACP): AnsiString; {$IFDEF DELPHI9} inline;{$ENDIF}

function dxShortStringToString(const S: ShortString): string; {$IFDEF DELPHI9} inline;{$ENDIF}
function dxStringToShortString(const S: string): ShortString; {$IFDEF DELPHI9} inline;{$ENDIF}

function dxStringToWideString(const S: string; ACodePage: Integer = CP_ACP): WideString; {$IFDEF DELPHI9} inline;{$ENDIF}
function dxWideStringToString(const S: WideString; ACodePage: Integer = CP_ACP): string; {$IFDEF DELPHI9} inline;{$ENDIF}

function dxVariantToString(const V: Variant): string;
function dxVariantToAnsiString(const V: Variant): AnsiString;
function dxVariantToWideString(const V: Variant): WideString;

function dxVarIsBlob(const V: Variant): Boolean;

function dxConcatenateStrings(const AStrings: array of PChar): string;
procedure dxStringToBytes(const S: string; var Buf);

function dxUTF8StringToAnsiString(const S: UTF8String): AnsiString;
function dxUTF8StringToWideString(const S: UTF8String): WideString;
function dxAnsiStringToUTF8String(const S: AnsiString): UTF8String;
function dxWideStringToUTF8String(const S: WideString): UTF8String;

// streaming
function dxIsUnicodeStream(AStream: TStream): Boolean;
procedure dxWriteStandardEncodingSignature(AStream: TStream);
procedure dxWriteStreamType(AStream: TStream);

function dxReadStr(Stream: TStream; AIsUnicode: Boolean): string;
procedure dxWriteStr(Stream: TStream; const S: string);

function dxResourceStringsRepository: TdxResourceStringsRepository;

// graphic functions
function dxColorToRGBQuad(AColor: TColor; AReserved: Byte = 0): TRGBQuad;
function cxGetBitmapPixelFormat(ABitmap: TBitmap): Integer;
procedure dxFillBitmapInfoHeader(out AHeader: TBitmapInfoHeader; ABitmap: TBitmap; ATopDownDIB: WordBool); overload;
procedure dxFillBitmapInfoHeader(out AHeader: TBitmapInfoHeader; AWidth, AHeight: Integer; ATopDownDIB: WordBool); overload;
function GetBitmapBits(ABitmap: TBitmap; var AColors: TRGBColors; ATopDownDIB: Boolean): Boolean;
procedure GetBitmapBitsByScanLine(ABitmap: TBitmap; var AColors: TRGBColors);
procedure SetBitmapBits(ABitmap: TBitmap; const AColors: TRGBColors; ATopDownDIB: Boolean);
function dxIsAlphaUsed(ABitmap: TBitmap): Boolean;

// memory functions
procedure cxZeroMemory(ADestination: Pointer; ACount: Integer);
function cxAllocMem(Size: Cardinal): Pointer;
procedure cxFreeMem(P: Pointer);
procedure dxFillChar(var ADest; Count: Integer; const APattern: Char);

procedure cxCopyData(ASource, ADestination: Pointer; ACount: Integer); overload;
procedure cxCopyData(ASource, ADestination: Pointer; ASourceOffSet, ADestinationOffSet, ACount: Integer); overload;
function ReadBoolean(ASource: Pointer; AOffset: Integer = 0): WordBool;
function ReadByte(ASource: Pointer; AOffset: Integer = 0): Byte;
function ReadInteger(ASource: Pointer; AOffset: Integer = 0): Integer;
function ReadPointer(ASource: Pointer): Pointer;
function ReadWord(ASource: Pointer; AOffset: Integer = 0): Word;
procedure WriteBoolean(ADestination: Pointer; AValue: WordBool; AOffset: Integer = 0);
procedure WriteByte(ADestination: Pointer; AValue: Byte; AOffset: Integer = 0);
procedure WriteInteger(ADestination: Pointer; AValue: Integer; AOffset: Integer = 0);
procedure WritePointer(ADestination: Pointer; AValue: Pointer);
procedure WriteWord(ADestination: Pointer; AValue: Word; AOffset: Integer = 0);

function ReadBufferFromStream(AStream: TStream; ABuffer: Pointer; Count: Integer): Boolean;
function ReadStringFromStream(AStream: TStream; out AValue: AnsiString): Longint;
function WriteBufferToStream(AStream: TStream; ABuffer: Pointer; ACount: Longint): Longint;
function WriteCharToStream(AStream: TStream; AValue: AnsiChar): Longint;
function WriteDoubleToStream(AStream: TStream; AValue: Double): Longint;
function WriteIntegerToStream(AStream: TStream; AValue: Integer): Longint;
function WriteSmallIntToStream(AStream: TStream; AValue: SmallInt): Longint;
function WriteStringToStream(AStream: TStream; const AValue: AnsiString): Longint;

procedure ExchangeLongWords(var AValue1, AValue2);
procedure Shift(var P: Pointer; AOffset: Integer);

procedure dxCompressStream(ASourceStream, ADestStream: TStream; ACompressMethod: Byte; ASize: Integer = 0);
procedure dxDecompressStream(ASourceStream, ADestStream: TStream);

// locale functions
function dxElfHash(const S: AnsiString; ALangID: Cardinal = CP_ACP): Integer; overload;
function dxElfHash(const S: WideString; ALangID: Cardinal = CP_ACP): Integer; overload;
function dxElfHash(P: PWideChar; ALength: Integer; ALangID: Cardinal = CP_ACP): Integer; overload;
function dxElfHash(P: PWideChar; ALength: Integer; AUpperCaseBuffer: PWideChar;
  AUpperCaseBufferLength: Integer; ALangID: Cardinal = CP_ACP): Integer; overload;

function dxGetLocaleInfo(ALocale, ALocaleType: Integer; const ADefaultValue: string = ''): string;
function dxGetLocalStartOfWeek: Integer;

// date functions
// StartOfWeek: 0..6 - 0 = Sunday, 6 = Saturday
function dxGetStartOfWeek: Word;
function dxGetAssignedStartOfWeek: Boolean;
procedure dxResetAssignedStartOfWeek;
procedure dxSetStartOfWeek(AValue: Word);

var
// platform info
  IsWin9X: Boolean;
  IsWin95, IsWin98, IsWinMe: Boolean;

  IsWinNT: Boolean;
  IsWin2K, IsWin2KOrLater: Boolean;
  IsWinXP, IsWinXPOrLater: Boolean;
  IsWin2KOrXP: Boolean;

  IsWinVista, IsWinVistaOrLater: Boolean;
  IsWinSeven: Boolean;

  IsWOW64: Boolean;

// FormatSettings
  dxFormatSettings: TdxFormatSettings;

implementation

uses StrUtils;

type
  TdxStreamHeader = array[0..5] of AnsiChar;

const
  StreamFormatANSI: TdxStreamHeader = 'DXAFMT';
  StreamFormatUNICODE: TdxStreamHeader = 'DXUFMT';

var
  FdxResourceStringsRepository: TdxResourceStringsRepository;

function GetStringTypeW(dwInfoType: DWORD; const lpSrcStr: PWideChar;
  cchSrc: Integer; var lpCharType): BOOL; stdcall; external kernel32 name 'GetStringTypeW';

function GetStringTypeA(ALocale: Cardinal; dwInfoType: DWORD; const lpSrcStr: PAnsiChar;
  cchSrc: Integer; var lpCharType): BOOL; stdcall; external kernel32 name 'GetStringTypeA';


function dxBinToHex(const ABuffer: AnsiString): AnsiString;
begin
  Result := dxBinToHex(PAnsiChar(ABuffer), Length(ABuffer));
end;

function dxBinToHex(const ABuffer: PAnsiChar; ABufSize: Integer): AnsiString;
begin
  SetLength(Result, ABufSize * 2);
  BinToHex(ABuffer, PAnsiChar(Result), ABufSize);
end;

function dxHexToBin(const AText: AnsiString): AnsiString;
begin
  Result := dxHexToBin(PAnsiChar(AText));
end;

function dxHexToBin(const AText: PAnsiChar): AnsiString;
begin
  SetLength(Result, Length(AText) div 2);
  HexToBin(AText, PAnsiChar(Result), Length(Result));
end;

function dxHexToByte(const AHex: string): Byte;
var
  S: string;
begin
  S := DupeString('0', 2 - Length(AHex)) + AHex;
  HexToBin(PChar(S), @Result, SizeOf(Result));
end;

function dxCharCount(const S: string): Integer;
begin
{$IFDEF DELPHI12}
  Result := ElementToCharLen(S, Length(S));
{$ELSE}
  Result := ByteToCharLen(S, Length(S));
{$ENDIF}
end;

function dxCharInSet(C: Char; const ACharSet: TdxAnsiCharSet): Boolean;
begin
  {$IFDEF DELPHI12}
    Result := CharInSet(C, ACharSet);
  {$ELSE}
    Result := C in ACharSet;
  {$ENDIF}
end;

function dxStringSize(const S: string): Integer;
begin
  Result := Length(S) * SizeOf(Char);
end;

function dxAnsiIsAlpha(Ch: AnsiChar): Boolean;
begin
  Result := dxGetAnsiCharCType1(Ch) and C1_ALPHA > 0;
end;

function dxCharIsAlpha(Ch: Char): Boolean;
begin
  Result := {$IFDEF DELPHI12}dxWideIsAlpha{$ELSE}dxAnsiIsAlpha{$ENDIF}(Ch);
end;

function dxWideIsAlpha(Ch: WideChar): Boolean;
begin
  Result := dxGetWideCharCType1(Ch) and C1_ALPHA > 0;
end;

function dxAnsiIsNumeric(Ch: AnsiChar): Boolean;
begin
  Result := dxGetAnsiCharCType1(Ch) and C1_DIGIT > 0;
end;

function dxCharIsNumeric(Ch: Char): Boolean;
begin
  Result := {$IFDEF DELPHI12}dxWideIsNumeric{$ELSE}dxAnsiIsNumeric{$ENDIF}(Ch);
end;

function dxWideIsNumeric(Ch: WideChar): Boolean;
begin
  Result := dxGetWideCharCType1(Ch) and C1_DIGIT > 0;
end;

function dxGetCodePageFromCharset(ACharset: Integer): Integer;
begin
  if (ACharset = DEFAULT_CHARSET) or (ACharset = ANSI_CHARSET) then //speedup
  begin
    Result := 0;
    Exit;
  end;
  case ACharset of
    THAI_CHARSET:
      Result := 874;
    SHIFTJIS_CHARSET:
      Result := 932;
    GB2312_CHARSET:
      Result := 936;
    HANGEUL_CHARSET, JOHAB_CHARSET:
      Result := 949;
    CHINESEBIG5_CHARSET:
      Result := 950;
    EASTEUROPE_CHARSET:
      Result := 1250;
    RUSSIAN_CHARSET:
      Result := 1251;
    GREEK_CHARSET:
      Result := 1253;
    TURKISH_CHARSET:
      Result := 1254;
    HEBREW_CHARSET:
      Result := 1255;
    ARABIC_CHARSET:
      Result := 1256;
    BALTIC_CHARSET:
      Result := 1257;
  else
    Result := 0;
  end;
end;

function dxGetStringTypeA(Locale: LCID; dwInfoType: DWORD; const lpSrcStr: PAnsiChar;
  cchSrc: Integer; var lpCharType): BOOL;
begin
  Result := GetStringTypeA(Locale, dwInfoType, lpSrcStr, cchSrc, lpCharType);
end;

function dxGetStringTypeW(dwInfoType: DWORD; const lpSrcStr: PWideChar;
  cchSrc: Integer; var lpCharType): BOOL;
begin
  Result := GetStringTypeW(dwInfoType, lpSrcStr, cchSrc, lpCharType);
end;

function dxGetAnsiCharCType1(Ch: AnsiChar): Word;
begin
  if not dxGetStringTypeA(GetThreadLocale, CT_CTYPE1, @Ch, 1, Result) then
    Result := 0;
end;

function dxGetWideCharCType1(Ch: WideChar): Word;
begin
  if not dxGetStringTypeW(CT_CTYPE1, @Ch, 1, Result) then
    Result := 0;
end;

function dxAnsiStringToWideString(const ASource: AnsiString; ACodePage: Cardinal = CP_ACP;
  ASrcLength: Integer = -1): WideString;
const
  ConversionFlags: array[Boolean] of Integer = (MB_PRECOMPOSED, 0);
var
  ADestLength: Integer;
begin
  Result := '';
  if ASource = '' then Exit;
  if not IsWinNT and (ACodePage = CP_UTF8) then //CP_UTF8 not supported on Windows 95
    {$IFDEF DELPHI12}
      Result := UTF8ToString(ASource)
    {$ELSE}
      Result := UTF8Decode(ASource)
    {$ENDIF}
  else
  begin
    if ASrcLength < 0 then
      ASrcLength := Length(ASource);
    ADestLength := MultiByteToWideChar(ACodePage, 0, PAnsiChar(ASource), ASrcLength, nil, 0);
    SetLength(Result, ADestLength);
    MultiByteToWideChar(ACodePage, ConversionFlags[ACodePage = CP_UTF8],
      PAnsiChar(ASource), ASrcLength, PWideChar(Result), ADestLength);
  end;
end;

function dxWideStringToAnsiString(const ASource: WideString; ACodePage: Cardinal = CP_ACP;
  ASrcLength: Integer = -1): AnsiString;
var
  ADestLength: Integer;
begin
  Result := '';
  if ASource = '' then Exit;
  if not IsWinNT and (ACodePage = CP_UTF8) then //CP_UTF8 not supported on Windows 95
      Result := UTF8Encode(ASource)
  else
  begin
    if ASrcLength < 0 then
      ASrcLength := Length(ASource);
    ADestLength := WideCharToMultiByte(ACodePage, 0, PWideChar(ASource), ASrcLength, nil, 0, nil, nil);
    SetLength(Result, ADestLength);
    WideCharToMultiByte(ACodePage, 0, PWideChar(ASource), ASrcLength, PAnsiChar(Result), ADestLength, nil, nil);
  end;
end;

function dxAnsiStringToString(const S: AnsiString; ACodePage: Integer = CP_ACP): string;
begin
  Result := {$IFDEF DELPHI12} dxAnsiStringToWideString(S, ACodePage) {$ELSE} S {$ENDIF};
end;

function dxStringToAnsiString(const S: string; ACodePage: Integer = CP_ACP): AnsiString;
begin
  Result := {$IFDEF DELPHI12} dxWideStringToAnsiString(S, ACodePage) {$ELSE} S {$ENDIF};
end;

function dxShortStringToString(const S: ShortString): string;
begin
  Result := {$IFDEF DELPHI12}UTF8ToString{$ENDIF}(S);
end;

function dxStringToShortString(const S: string): ShortString;
begin
  Result := {$IFDEF DELPHI12}UTF8EncodeToShortString{$ENDIF}(S);
end;

function dxStringToWideString(const S: string; ACodePage: Integer = CP_ACP): WideString;
begin
  Result := {$IFDEF DELPHI12} S {$ELSE} dxAnsiStringToWideString(S, ACodePage) {$ENDIF};
end;

function dxWideStringToString(const S: WideString; ACodePage: Integer = CP_ACP): string;
begin
  Result := {$IFDEF DELPHI12} S {$ELSE} dxWideStringToAnsiString(S, ACodePage) {$ENDIF};
end;

function dxVariantToString(const V: Variant): string;
begin
  Result := {$IFDEF DELPHI12}dxVariantToWideString{$ELSE}dxVariantToAnsiString{$ENDIF}(V);
end;

function dxVariantToAnsiString(const V: Variant): AnsiString;
var
  ASize: Integer;
begin
  if VarIsArray(V) and (VarArrayDimCount(V) = 1) then
  begin
    ASize := VarArrayHighBound(V, 1) - VarArrayLowBound(V, 1) + 1;
    SetLength(Result, ASize);
    Move(VarArrayLock(V)^, Result[1], ASize);
    VarArrayUnlock(V);
  end
  else
    if VarType(V) = varString then
      Result := AnsiString(TVarData(V).VString)
    else
      Result := dxStringToAnsiString(VarToStr(V))
end;

function dxVariantToWideString(const V: Variant): WideString;
begin
  if VarIsStr(V) then
    Result := VarToStr(V)
  else
    Result := dxAnsiStringToString(dxVariantToAnsiString(V));
end;

function dxVarIsBlob(const V: Variant): Boolean;
begin
  Result := VarIsStr(V) or (VarIsArray(V) and (VarArrayDimCount(V) = 1));
end;

function dxConcatenateStrings(const AStrings: array of PChar): string;
var
  I: Integer;
begin
  for I := 0 to High(AStrings) - 1 do
    Result := Result + AStrings[I];
end;

procedure dxStringToBytes(const S: string; var Buf);
begin
  if Length(S) > 0 then
    Move(S[1], Buf, dxStringSize(S));
end;

function dxUTF8StringToAnsiString(const S: UTF8String): AnsiString;
begin
  Result := {$IFDEF DELPHI12}dxWideStringToAnsiString{$ENDIF}(Utf8ToAnsi(S));
end;

function dxUTF8StringToWideString(const S: UTF8String): WideString;
begin
  Result := {$IFDEF DELPHI12}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(S);
end;

function dxAnsiStringToUTF8String(const S: AnsiString): UTF8String;
begin
  Result := UTF8Encode({$IFDEF DELPHI12}dxAnsiStringToWideString{$ENDIF}(S));
end;

function dxWideStringToUTF8String(const S: WideString): UTF8String;
begin
  Result := UTF8Encode(S);
end;

function dxIsUnicodeStream(AStream: TStream): Boolean;
var
  B: TdxStreamHeader;
begin
  Result := False;
  if (AStream.Size - AStream.Position) >= SizeOf(TdxStreamHeader) then
  begin
    AStream.ReadBuffer(B, SizeOf(TdxStreamHeader));
    Result := B = StreamFormatUNICODE;
    if not Result and (B <> StreamFormatANSI) then
      AStream.Position := AStream.Position - SizeOf(TdxStreamHeader);
  end;
end;

procedure dxWriteStandardEncodingSignature(AStream: TStream);
begin
{$IFDEF DELPHI12}
  AStream.WriteBuffer(dxUnicodePrefix, SizeOf(dxUnicodePrefix));
{$ENDIF}
end;

procedure dxWriteStreamType(AStream: TStream);
begin
{$IFNDEF STREAMANSIFORMAT}
  {$IFDEF DELPHI12}
     AStream.WriteBuffer(StreamFormatUNICODE, SizeOf(TdxStreamHeader));
  {$ELSE}
     AStream.WriteBuffer(StreamFormatANSI, SizeOf(TdxStreamHeader));
  {$ENDIF}
{$ENDIF}
end;

function dxReadStr(Stream: TStream; AIsUnicode: Boolean): string;
var
  L: Word;
  SA: AnsiString;
  SW: WideString;
begin
  Stream.ReadBuffer(L, SizeOf(Word));
  if AIsUnicode then
  begin
    SetLength(SW, L);
    if L > 0 then Stream.ReadBuffer(SW[1], L * 2);
    Result := SW;
  end
  else
  begin
    SetLength(SA, L);
    if L > 0 then Stream.ReadBuffer(SA[1], L);
  {$IFDEF DELPHI12}
    Result := UTF8ToWideString(SA);
  {$ELSE}
    Result := SA;
  {$ENDIF}
  end;
end;

procedure dxWriteStr(Stream: TStream; const S: string);
var
  L: Integer;
{$IFDEF STREAMANSIFORMAT}
  SA: AnsiString;
{$ENDIF}
begin
  L := Length(S);
  if L > $FFFF then L := $FFFF;
  Stream.WriteBuffer(L, SizeOf(Word));
  if L > 0 then
  begin
  {$IFDEF STREAMANSIFORMAT}
    {$IFDEF DELPHI12}
      SA := UTF8Encode(S);
    {$ELSE}
      SA := S;
    {$ENDIF}
    Stream.WriteBuffer(SA[1], L);
  {$ELSE}
    Stream.WriteBuffer(S[1], L * SizeOf(Char));
  {$ENDIF}
  end;
end;

function dxResourceStringsRepository: TdxResourceStringsRepository;
begin
  if FdxResourceStringsRepository = nil then
    FdxResourceStringsRepository := TdxResourceStringsRepository.Create;
  Result := FdxResourceStringsRepository;
end;

function InternalGetDIB(ABitmap: TBitmap; const AColors: TRGBColors; ATopDownDIB: WordBool): Boolean;
var
  ADC: HDC;
  ABitmapInfo: TBitmapInfo;
begin
  if (ABitmap.Width <> 0) and (ABitmap.Height <> 0) then
  begin
    dxFillBitmapInfoHeader(ABitmapInfo.bmiHeader, ABitmap, ATopDownDIB);
    ADC := CreateCompatibleDC(0);
    try
      Result := GetDIBits(ADC, ABitmap.Handle, 0, ABitmap.Height, AColors, ABitmapInfo, DIB_RGB_COLORS) <> 0;
    finally
      DeleteDC(ADC);
    end;
  end
  else
    Result := False;
end;

function InternalSetDIB(ABitmap: TBitmap; const AColors: TRGBColors; ATopDownDIB: WordBool): Boolean;
var
  ADC: HDC;
  ABitmapInfo: TBitmapInfo;
begin
  if (ABitmap.Width <> 0) and (ABitmap.Height <> 0) then
  begin
    dxFillBitmapInfoHeader(ABitmapInfo.bmiHeader, ABitmap, ATopDownDIB);
    ADC := CreateCompatibleDC(0);
    try
      Result := SetDIBits(ADC, ABitmap.Handle, 0, ABitmap.Height, AColors, ABitmapInfo, DIB_RGB_COLORS) <> 0;
    finally
      DeleteDC(ADC);
    end;
  end
  else
    Result := False;
end;

function dxColorToRGBQuad(AColor: TColor; AReserved: Byte = 0): TRGBQuad;
type
  TRGBA = packed record
    R: Byte;
    G: Byte;
    B: Byte;
    A: Byte;
  end;
var
  ATemp: TRGBA;
begin
  DWORD(ATemp) := ColorToRGB(AColor);
  Result.rgbBlue := ATemp.B;
  Result.rgbRed := ATemp.R;
  Result.rgbGreen := ATemp.G;
  Result.rgbReserved := AReserved;
end;

function cxGetBitmapPixelFormat(ABitmap: TBitmap): Integer;
const
  ABitCounts: array [pf1Bit..pf32Bit] of Byte = (1,4,8,16,16,24,32);
begin
  case ABitmap.PixelFormat of
    pf1bit..pf32Bit: Result := ABitCounts[ABitmap.PixelFormat]
  else
    Result := GetDeviceCaps(ABitmap.Canvas.Handle, BITSPIXEL);
  end;
end;

procedure dxFillBitmapInfoHeader(out AHeader: TBitmapInfoHeader; ABitmap: TBitmap; ATopDownDIB: WordBool);
begin
  dxFillBitmapInfoHeader(AHeader, ABitmap.Width, ABitmap.Height, ATopDownDIB);
end;

procedure dxFillBitmapInfoHeader(out AHeader: TBitmapInfoHeader; AWidth, AHeight: Integer; ATopDownDIB: WordBool);
begin
  cxZeroMemory(@AHeader, SizeOf(AHeader));
  AHeader.biSize := SizeOf(TBitmapInfoHeader);
  AHeader.biWidth := AWidth;
  if ATopDownDIB then
    AHeader.biHeight := -AHeight
  else
    AHeader.biHeight := AHeight;
  AHeader.biPlanes := 1;
  AHeader.biBitCount := 32;
  AHeader.biCompression := BI_RGB;
end;

function GetBitmapBits(ABitmap: TBitmap; var AColors: TRGBColors; ATopDownDIB: Boolean): Boolean;
begin
  SetLength(AColors, ABitmap.Width * ABitmap.Height);
  Result := InternalGetDIB(ABitmap, AColors, ATopDownDIB);
end;

procedure GetBitmapBitsByScanLine(ABitmap: TBitmap; var AColors: TRGBColors);
var
  AIndex: Integer;
  AQuad: PRGBQuad;
  I, J: Integer;
begin
  // todo: try to get bitmap bits if GetDIBits fail
  if ABitmap.PixelFormat = pf32bit then
  begin
    if Length(AColors) <> ABitmap.Width * ABitmap.Height then
      SetLength(AColors, ABitmap.Width * ABitmap.Height);
    AIndex := 0;
    for J := 0 to ABitmap.Height - 1 do
    begin
      AQuad := ABitmap.ScanLine[J];
      for I := 0 to ABitmap.Width - 1 do
      begin
        AColors[AIndex] := AQuad^;
        Inc(AQuad);
        Inc(AIndex);
      end;
    end;
  end;
end;

procedure SetBitmapBits(ABitmap: TBitmap; const AColors: TRGBColors; ATopDownDIB: Boolean);
begin
  InternalSetDIB(ABitmap, AColors, ATopDownDIB);
end;

function dxIsAlphaUsed(ABitmap: TBitmap): Boolean;

  function InternalIsBitmapAlphaUsed: Boolean;
  var
    AColors: TRGBColors;
    I: Integer;
  begin
    Result := False;
    GetBitmapBits(ABitmap, AColors, False);
    for I := Low(AColors) to High(AColors) do
    begin
      Result := AColors[I].rgbReserved <> 0;
      if Result then
        Break;
    end;
  end;

begin
  Result := (cxGetBitmapPixelFormat(ABitmap) >= 32) and InternalIsBitmapAlphaUsed;
end;

procedure cxZeroMemory(ADestination: Pointer; ACount: Integer);
begin
  ZeroMemory(ADestination, ACount);
end;

function cxAllocMem(Size: Cardinal): Pointer;
begin
  GetMem(Result, Size);
  cxZeroMemory(Result, Size);
end;

procedure cxFreeMem(P: Pointer);
begin
  FreeMem(P);
end;

procedure dxFillChar(var ADest; Count: Integer; const APattern: Char);
{$IFDEF DELPHI12}
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    PWordArray(@ADest)^[I] := Word(APattern);
{$ELSE}
begin
  FillChar(ADest, Count, APattern);
{$ENDIF}
end;

procedure cxCopyData(ASource, ADestination: Pointer; ACount: Integer);
begin
  Move(ASource^, ADestination^, ACount);
end;

procedure cxCopyData(ASource, ADestination: Pointer; ASourceOffSet, ADestinationOffSet, ACount: Integer);
begin
  if ASourceOffSet > 0 then
    Shift(ASource, ASourceOffSet);
  if ADestinationOffSet > 0 then
    Shift(ADestination, ADestinationOffSet);
  cxCopyData(ASource, ADestination, ACount);
end;

function ReadBoolean(ASource: Pointer; AOffset: Integer = 0): WordBool;
begin
  cxCopyData(ASource, @Result, AOffset, 0, SizeOf(WordBool));
end;

function ReadByte(ASource: Pointer; AOffset: Integer = 0): Byte;
begin
  cxCopyData(ASource, @Result, AOffset, 0, SizeOf(Byte));
end;

function ReadInteger(ASource: Pointer; AOffset: Integer = 0): Integer;
begin
  cxCopyData(ASource, @Result, AOffset, 0, SizeOf(Integer));
end;

function ReadPointer(ASource: Pointer): Pointer;
begin
  Result := Pointer(ASource^);
end;

function ReadWord(ASource: Pointer; AOffset: Integer = 0): Word;
begin
  cxCopyData(ASource, @Result, AOffset, 0, SizeOf(Word));
end;

procedure WriteBoolean(ADestination: Pointer; AValue: WordBool; AOffset: Integer = 0);
begin
  cxCopyData(@AValue, ADestination, 0, AOffset, SizeOf(WordBool));
end;

procedure WriteByte(ADestination: Pointer; AValue: Byte; AOffset: Integer = 0);
begin
  cxCopyData(@AValue, ADestination, 0, AOffset, SizeOf(Byte));
end;

procedure WriteInteger(ADestination: Pointer; AValue: Integer; AOffset: Integer = 0);
begin
  cxCopyData(@AValue, ADestination, 0, AOffset, SizeOf(Integer));
end;

procedure WritePointer(ADestination: Pointer; AValue: Pointer);
begin
  Pointer(ADestination^) := AValue;
end;

procedure WriteWord(ADestination: Pointer; AValue: Word; AOffset: Integer = 0);
begin
  cxCopyData(@AValue, ADestination, 0, AOffset, SizeOf(Word));
end;

function ReadBufferFromStream(AStream: TStream; ABuffer: Pointer; Count: Integer): Boolean;
begin
  Result := AStream.Read(ABuffer^, Count) = Count;
end;

function ReadStringFromStream(AStream: TStream; out AValue: AnsiString): Longint;
begin
  SetLength(AValue, AStream.Size);
  Result := AStream.Read(AValue[1], AStream.Size);
end;

function WriteBufferToStream(AStream: TStream; ABuffer: Pointer; ACount: Longint): Longint;
var
  AData: TBytes;
begin
  SetLength(AData, ACount);
  if ABuffer <> nil then
    cxCopyData(ABuffer, AData, ACount);

  Result := AStream.Write(AData[0], ACount);
end;

function WriteCharToStream(AStream: TStream; AValue: AnsiChar): Longint;
begin
  Result := AStream.Write(AValue, 1);
end;

function WriteDoubleToStream(AStream: TStream; AValue: Double): Longint;
begin
  Result := AStream.Write(AValue, SizeOf(Double));
end;

function WriteIntegerToStream(AStream: TStream; AValue: Integer): Longint;
begin
  Result := AStream.Write(AValue, SizeOf(Integer));
end;

function WriteSmallIntToStream(AStream: TStream; AValue: SmallInt): Longint;
begin
  Result := AStream.Write(AValue, SizeOf(SmallInt));
end;

function WriteStringToStream(AStream: TStream; const AValue: AnsiString): Longint;
begin
  Result := AStream.Write(PAnsiChar(AValue)^, Length(AValue));
end;

procedure ExchangeLongWords(var AValue1, AValue2);
var
  ATempValue: LongWord;
begin
  ATempValue := LongWord(AValue1);
  LongWord(AValue1) := LongWord(AValue2);
  LongWord(AValue2) := ATempValue;
end;

procedure Shift(var P: Pointer; AOffset: Integer);
begin
  P := Pointer(Integer(P) + AOffset);
end;

type
  TSeekMode = (smDup, smUnique);
const
  AModeMap: array[Boolean] of TSeekMode = (smDup, smUnique);
  AModeMask: array[TSeekMode] of Byte = (0, 128);

function ReadStreamByte(AStream: TStream; AMaxPos: Integer; var AByte: Byte): Boolean;
begin
  Result := AStream.Position < AMaxPos;
  if Result then
    AStream.Read(AByte, SizeOf(Byte));
end;

procedure WriteStreamByte(AStream: TStream; AByte: Byte);
begin
  AStream.Write(AByte, SizeOf(Byte));
end;

function CompareBlock(ABlock1, ABlock2: TBytes): Boolean;
begin
  Result := (Length(ABlock1) = Length(ABlock2)) and CompareMem(ABlock1, ABlock2, Length(ABlock1));
end;

function ReadStreamBlock(AStream: TStream; AMaxPos: Integer; var ABlock: TBytes; ABlockSize: Integer): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to ABlockSize - 1 do
    Result := Result and ReadStreamByte(AStream, AMaxPos, ABlock[I]);
end;

procedure WriteStreamBlock(AStream: TStream; ABlock: TBytes; ABlockSize: Integer);
var
  I: Integer;
begin
  for I := 0 to ABlockSize - 1 do
    WriteStreamByte(AStream, ABlock[I]);
end;

procedure dxCompressStream(ASourceStream, ADestStream: TStream; ACompressMethod: Byte; ASize: Integer);

  procedure CompressByBlock(ASourceStream, ADestStream: TStream; ASize, ABlockSize: Integer);

    function GetCounter(ASeekBlock: TBytes; AMode: TSeekMode; AMaxPos: Integer): Integer;
    var
      ABlock: TBytes;
    begin
      Result := 1;
      SetLength(ABlock, ABlockSize);
      while (Result < 125) and ReadStreamBlock(ASourceStream, AMaxPos, ABlock, ABlockSize) do
      begin
        if (AMode = smDup) and CompareBlock(ABlock, ASeekBlock) or (AMode = smUnique) and not CompareBlock(ABlock, ASeekBlock) then
          Inc(Result)
        else
        begin
          if AMode = smUnique then
            Dec(Result);
          Break;
        end;
        cxCopyData(ABlock, ASeekBlock, ABlockSize);
      end;
    end;

  var
    AReadBlock1, AReadBlock2: TBytes;
    ACounter, AReadedCount: Integer;
    AStreamPos, AMaxPos: Integer;
    AMode: TSeekMode;
  begin
    AMaxPos := ASourceStream.Position + ASize;

    SetLength(AReadBlock1, ABlockSize);
    SetLength(AReadBlock2, ABlockSize);

    while ReadStreamBlock(ASourceStream, AMaxPos, AReadBlock1, ABlockSize) do
    begin
      AReadedCount := ABlockSize;
      AStreamPos := ASourceStream.Position - ABlockSize;
      if ReadStreamBlock(ASourceStream, AMaxPos, AReadBlock2, ABlockSize) then
      begin
        Inc(AReadedCount, ABlockSize);
        AMode := AModeMap[(AReadedCount = ABlockSize) or not CompareBlock(AReadBlock1, AReadBlock2)];
        ASourceStream.Position := ASourceStream.Position - (AReadedCount - ABlockSize);
        ACounter := GetCounter(AReadBlock1, AMode, AMaxPos);
      end
      else
      begin
        AMode := smUnique;
        ACounter := 1;
      end;

      WriteStreamByte(ADestStream, ACounter or AModeMask[AMode]);
      case AMode of
        smUnique:
          begin
            ASourceStream.Position := AStreamPos;
            ADestStream.CopyFrom(ASourceStream, ACounter * ABlockSize);
          end;
        smDup:
          WriteStreamBlock(ADestStream, AReadBlock1, ABlockSize);
      end;
      ASourceStream.Position := AStreamPos + ACounter * ABlockSize;
    end;
  end;

var
  ABlockSize, AShift: Byte;
  APrevPosition: Integer;
begin
  if ASize = 0 then
    ASize := ASourceStream.Size - ASourceStream.Position;
  APrevPosition := ADestStream.Position;
  ADestStream.Position := ADestStream.Position + SizeOf(Integer);
  WriteStreamByte(ADestStream, ACompressMethod);
  if (ACompressMethod >= 1) and (ACompressMethod <= 4) then
  begin
    ABlockSize := ACompressMethod;
    AShift := ASize mod ABlockSize;
    WriteStreamByte(ADestStream, AShift);
    if AShift > 0 then
      ADestStream.CopyFrom(ASourceStream, AShift);
    CompressByBlock(ASourceStream, ADestStream, ASize - AShift, ABlockSize);
  end
  else
{    if ACompressMethod = 5 then
    begin

    end;
    else
    }
      ADestStream.CopyFrom(ASourceStream, ASize);
  ASize := ADestStream.Position - APrevPosition;
  ADestStream.Position := APrevPosition;
  ADestStream.Write(ASize, SizeOf(ASize));
  ADestStream.Position := APrevPosition + ASize;
end;

procedure dxDecompressStream(ASourceStream, ADestStream: TStream);

  procedure DecompressByBlock(ASourceStream, ADestStream: TStream; ASize, ABlockSize: Integer);
  var
    ACode: Byte;
    AReadBlob: TBytes;
    AMaxPos: Integer;
    I: Integer;
    ACounter: Integer;
  begin
    AMaxPos := ASourceStream.Position + ASize;

    SetLength(AReadBlob, ABlockSize);

    while ReadStreamByte(ASourceStream, AMaxPos, ACode) do
    begin
      ACounter := ACode and 127;
      if (ACode and AModeMask[smUnique]) <> 0 then
        ADestStream.CopyFrom(ASourceStream, ACounter * ABlockSize)
      else
      begin
        ReadStreamBlock(ASourceStream, AMaxPos, AReadBlob, ABlockSize);
        for I := 0 to ACounter - 1 do
          WriteStreamBlock(ADestStream, AReadBlob, ABlockSize);
      end;
    end;
  end;

var
  ASize: Integer;
  ACompressMethod, AShift: Byte;
begin
  ASourceStream.Read(ASize, SizeOf(ASize));
  ASourceStream.Read(ACompressMethod, SizeOf(ACompressMethod));
  if (ACompressMethod >= 1) and (ACompressMethod <= 4) then
  begin
    ASourceStream.Read(AShift, SizeOf(AShift));
    if AShift > 0 then
      ADestStream.CopyFrom(ASourceStream, AShift);
    DecompressByBlock(ASourceStream, ADestStream, ASize - 6 - AShift, ACompressMethod);
  end
  else
    ADestStream.CopyFrom(ASourceStream, ASize - 5);
end;

function dxElfHash(const S: AnsiString; ALangID: Cardinal = CP_ACP): Integer;
begin
  Result := dxElfHash(dxAnsiStringToWideString(S, ALangID), ALangID);
end;

function dxElfHash(const S: WideString; ALangID: Cardinal = CP_ACP): Integer;
begin
  Result := dxElfHash(PWideChar(S), Length(S), ALangID);
end;

function dxElfHash(P: PWideChar; ALength: Integer; ALangID: Cardinal = CP_ACP): Integer;
var
  ATempBuffer: PWideChar;
begin
  ATempBuffer := AllocMem((ALength + 1) * SizeOf(WideChar));
  try
    Result := dxElfHash(P, ALength, ATempBuffer, ALength + 1, ALangID);
  finally
    FreeMem(ATempBuffer);
  end;
end;

function dxElfHash(P: PWideChar; ALength: Integer; AUpperCaseBuffer: PWideChar;
  AUpperCaseBufferLength: Integer; ALangID: Cardinal = CP_ACP): Integer;
var
  I: Integer;
begin
  Result := 0;
  if AUpperCaseBuffer <> nil then
  begin
    LCMapStringW(ALangID, LCMAP_UPPERCASE, P, ALength + 1, AUpperCaseBuffer, AUpperCaseBufferLength);
    P := AUpperCaseBuffer;
  end;
  while P^ <> #$00 do
  begin
    Result := (Result shl 4) + Ord(P^);
    I := Result and $F0000000;
    if (I <> 0) then
      Result := Result xor (I shr 24);
    Result := Result and (not I);
    Inc(P);
  end;
end;

function dxGetLocaleInfo(ALocale, ALocaleType: Integer; const ADefaultValue: string = ''): string;
var
  ABuffer: string;
  ABufferSize: Integer;
begin
  ABufferSize := GetLocaleInfo(ALocale, ALocaleType, nil, 0);
  if ABufferSize = 0 then
    Result := ADefaultValue
  else
  begin
    SetLength(ABuffer, ABufferSize);
    GetLocaleInfo(ALocale, ALocaleType, PChar(ABuffer), ABufferSize);
    Result := Copy(ABuffer, 1, ABufferSize - 1)
  end;
end;

function dxGetLocalStartOfWeek: Integer;
begin
  Result := StrToInt(dxGetLocaleInfo(GetThreadLocale, LOCALE_IFIRSTDAYOFWEEK, '0')) + 1;
  if Result > 6 then
    Result := 0;
end;

var
  FStartOfWeek: Word;
  FAssignedStartOfWeek: Boolean;

function dxGetStartOfWeek: Word;
begin
  if FAssignedStartOfWeek then
    Result := FStartOfWeek
  else
    Result := dxGetLocalStartOfWeek;
end;

function dxGetAssignedStartOfWeek: Boolean;
begin
  Result := FAssignedStartOfWeek;
end;

procedure dxResetAssignedStartOfWeek;
begin
  FAssignedStartOfWeek := False;
end;

procedure dxSetStartOfWeek(AValue: Word);
begin
  if AValue in [0..6] then
  begin
    FStartOfWeek := AValue;
    FAssignedStartOfWeek := True;
  end;
end;

{ TdxStream }

constructor TdxStream.Create(AStream: TStream);
begin
  FIsUnicode := dxIsUnicodeStream(AStream);
  FStream := AStream;
end;

{$IFDEF DELPHI7}
function TdxStream.GetSize: Int64;
begin
  Result := FStream.Size;
end;
{$ENDIF}

function TdxStream.Read(var Buffer; Count: Longint): Longint;
begin
  Result := FStream.Read(Buffer, Count);
end;

function TdxStream.Seek(Offset: Longint; Origin: Word): Longint;
begin
  Result := FStream.Seek(Offset, Origin);
end;

function TdxStream.Write(const Buffer; Count: Longint): Longint;
begin
  Result := FStream.Write(Buffer, Count);
end;

{ TdxProductResourceStrings }

constructor TdxProductResourceStrings.Create(const AName: string; AInitializeProc: TdxAddResourceStringsProcedure);
begin
  FName := AName;
  FResStringNames := TStringList.Create;
  TStringList(FResStringNames).Sorted := True;
  FInitializeProc := AInitializeProc;
  InitializeResStringNames;
end;

destructor TdxProductResourceStrings.Destroy;
begin
  FInitializeProc := nil;
  FResStringNames.Free;
end;

procedure TdxProductResourceStrings.Add(const AResStringName: string; AResStringAddr: Pointer);
begin
  FResStringNames.AddObject(AResStringName, AResStringAddr);
end;

procedure TdxProductResourceStrings.Clear;
begin
  FResStringNames.Clear;
end;

function TdxProductResourceStrings.GetIndexByName(const AName: string): Integer;
begin
  if not TStringList(FResStringNames).Find(AName, Result) then
    Result := -1;
end;

procedure TdxProductResourceStrings.Translate;
var
  I: Integer;
begin
  for I := 0 to ResStringsCount - 1 do
    SetTranslation(I);
end;

function TdxProductResourceStrings.GetNames(AIndex: Integer): string;
begin
  Result := FResStringNames[AIndex];
end;

function TdxProductResourceStrings.GetResStringsCount: Integer;
begin
  Result := FResStringNames.Count;
end;

procedure TdxProductResourceStrings.SetTranslation(AIndex: Integer);
begin
  dxResourceStringsRepository.OnTranslateResString(Names[AIndex], FResStringNames.Objects[AIndex]);
end;

function TdxProductResourceStrings.GetValues(AIndex: Integer): string;
begin
  Result := LoadResString(PResStringRec(FResStringNames.Objects[AIndex]));
end;

procedure TdxProductResourceStrings.InitializeResStringNames;
begin
  if Assigned(FInitializeProc) then
    FInitializeProc(Self);
end;

{ TdxResourceStringsRepository }

constructor TdxResourceStringsRepository.Create;
begin
  FProducts := TObjectList.Create;
  FListeners := TList.Create;
end;

destructor TdxResourceStringsRepository.Destroy;
begin
  FListeners.Free;
  FProducts.Free;
end;

procedure TdxResourceStringsRepository.AddListener(AListener: IdxLocalizerListener);
begin
  if FListeners.IndexOf(Pointer(AListener)) = -1 then
    FListeners.Add(Pointer(AListener));
end;

procedure TdxResourceStringsRepository.RemoveListener(AListener: IdxLocalizerListener);
begin
  FListeners.Remove(Pointer(AListener));
end;

procedure TdxResourceStringsRepository.NotifyListeners;
var
  I: Integer;
begin
  for I := 0 to FListeners.Count - 1 do
    IdxLocalizerListener(FListeners[I]).TranslationChanged;
end;

procedure TdxResourceStringsRepository.RegisterProduct(const AProductName: string; AAddStringsProc: TdxAddResourceStringsProcedure);
begin
  FProducts.Add(TdxProductResourceStrings.Create(AProductName, AAddStringsProc));
end;

function TdxResourceStringsRepository.GetProductIndexByName(const AName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to ProductsCount - 1 do
    if Products[I].Name = AName then
    begin
      Result := I;
      Break;
    end;
end;

function TdxResourceStringsRepository.GetOriginalValue(const AName: string): string;
var
  I, AIndex: Integer;
begin
  Result := '';
  for I := 0 to ProductsCount - 1 do
  begin
    AIndex := Products[I].GetIndexByName(AName);
    if AIndex <> -1 then
    begin
      Result := Products[I].Values[AIndex];
      Break;
    end;
  end;
end;

procedure TdxResourceStringsRepository.Translate;
var
  I: Integer;
begin
  if Assigned(FOnTranslateResString) then
  begin
    for I := 0 to ProductsCount - 1 do
      Products[I].Translate;
  end;
end;

procedure TdxResourceStringsRepository.UnRegisterProduct(const AProductName: string);
var
  AIndex: Integer;
begin
  AIndex := GetProductIndexByName(AProductName);
  if AIndex <> -1 then
    FProducts.Delete(AIndex);
end;

function TdxResourceStringsRepository.GetProducts(AIndex: Integer): TdxProductResourceStrings;
begin
  Result := TdxProductResourceStrings(FProducts[AIndex]);
end;

function TdxResourceStringsRepository.GetProductsCount: Integer;
begin
  Result := FProducts.Count;
end;

{ TdxFormatSettings }

function TdxFormatSettings.GetLongDayNames(AIndex: Integer): string;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.LongDayNames[AIndex];
{$ELSE}
  Result := SysUtils.LongDayNames[AIndex];
{$ENDIF}
end;

function TdxFormatSettings.GetLongMonthNames(AIndex: Integer): string;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.LongMonthNames[AIndex];
{$ELSE}
  Result := SysUtils.LongMonthNames[AIndex];
{$ENDIF}
end;

function TdxFormatSettings.GetShortDayNames(AIndex: Integer): string;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.ShortDayNames[AIndex];
{$ELSE}
  Result := SysUtils.ShortDayNames[AIndex];
{$ENDIF}
end;

function TdxFormatSettings.GetShortMonthNames(AIndex: Integer): string;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.ShortMonthNames[AIndex];
{$ELSE}
  Result := SysUtils.ShortMonthNames[AIndex];
{$ENDIF}
end;

function TdxFormatSettings.GetCurrencyDecimals: Byte;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.CurrencyDecimals;
{$ELSE}
  Result := SysUtils.CurrencyDecimals;
{$ENDIF}
end;

function TdxFormatSettings.GetCurrencyFormat: Byte;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.CurrencyFormat;
{$ELSE}
  Result := SysUtils.CurrencyFormat;
{$ENDIF}
end;

function TdxFormatSettings.GetCurrencyString: string;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.CurrencyString;
{$ELSE}
  Result := SysUtils.CurrencyString;
{$ENDIF}
end;

function TdxFormatSettings.GetDateSeparator: Char;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.DateSeparator;
{$ELSE}
  Result := SysUtils.DateSeparator;
{$ENDIF}
end;

function TdxFormatSettings.GetDecimalSeparator: Char;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.DecimalSeparator;
{$ELSE}
  Result := SysUtils.DecimalSeparator;
{$ENDIF}
end;

function TdxFormatSettings.GetListSeparator: Char;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.ListSeparator;
{$ELSE}
  Result := SysUtils.ListSeparator;
{$ENDIF}
end;

function TdxFormatSettings.GetLongDateFormat: string;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.LongDateFormat;
{$ELSE}
  Result := SysUtils.LongDateFormat;
{$ENDIF}
end;

function TdxFormatSettings.GetLongTimeFormat: string;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.LongTimeFormat;
{$ELSE}
  Result := SysUtils.LongTimeFormat;
{$ENDIF}
end;

function TdxFormatSettings.GetNegCurrFormat: Byte;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.NegCurrFormat;
{$ELSE}
  Result := SysUtils.NegCurrFormat;
{$ENDIF}
end;

function TdxFormatSettings.GetShortDateFormat: string;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.ShortDateFormat;
{$ELSE}
  Result := SysUtils.ShortDateFormat;
{$ENDIF}
end;

function TdxFormatSettings.GetShortTimeFormat: string;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.ShortTimeFormat;
{$ELSE}
  Result := SysUtils.ShortTimeFormat;
{$ENDIF}
end;

function TdxFormatSettings.GetThousandSeparator: Char;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.ThousandSeparator;
{$ELSE}
  Result := SysUtils.ThousandSeparator;
{$ENDIF}
end;

function TdxFormatSettings.GetTimeAMString: string;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.TimeAMString;
{$ELSE}
  Result := SysUtils.TimeAMString;
{$ENDIF}
end;

function TdxFormatSettings.GetTimePMString: string;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.TimePMString;
{$ELSE}
  Result := SysUtils.TimePMString;
{$ENDIF}
end;

function TdxFormatSettings.GetTimeSeparator: Char;
begin
{$IFDEF DELPHI15}
  Result := FormatSettings.TimeSeparator;
{$ELSE}
  Result := SysUtils.TimeSeparator;
{$ENDIF}
end;

procedure TdxFormatSettings.SetThousandSeparator(AValue: Char);
begin
{$IFDEF DELPHI15}
  FormatSettings.TimeSeparator := AValue;
{$ELSE}
  SysUtils.TimeSeparator := AValue;
{$ENDIF}
end;

procedure TdxFormatSettings.SetDecimalSeparator(AValue: Char);
begin
{$IFDEF DELPHI15}
  FormatSettings.DecimalSeparator := AValue;
{$ELSE}
  SysUtils.DecimalSeparator := AValue;
{$ENDIF}
end;

procedure TdxFormatSettings.SetCurrencyDecimals(AValue: Byte);
begin
{$IFDEF DELPHI15}
  FormatSettings.CurrencyDecimals := AValue;
{$ELSE}
  SysUtils.CurrencyDecimals := AValue;
{$ENDIF}
end;

procedure TdxFormatSettings.SetCurrencyString(AValue: string);
begin
{$IFDEF DELPHI15}
  FormatSettings.CurrencyString := AValue;
{$ELSE}
  SysUtils.CurrencyString := AValue;
{$ENDIF}
end;

procedure TdxFormatSettings.SetShortDateFormat(AValue: string);
begin
{$IFDEF DELPHI15}
  FormatSettings.ShortDateFormat := AValue;
{$ELSE}
  SysUtils.ShortDateFormat := AValue;
{$ENDIF}
end;

procedure dxTestCheck(AValue: WordBool; AMessage: string);
begin
// do nothing
end;

type
  TIsWow64Process = function (AHandle: THandle; AWow64Process: PBOOL): BOOL; stdcall;

procedure InitPlatformInfo;
var
  AIsWow64Process: TIsWow64Process;
  AIsWow64: BOOL;
begin
  IsWin9X := Win32Platform = VER_PLATFORM_WIN32_WINDOWS;

  IsWin95 := IsWin9X and (Win32MinorVersion = 0);
  IsWin98 := IsWin9X and (Win32MinorVersion = 10);
  IsWinMe := IsWin9X and (Win32MinorVersion = 90);

  IsWinNT := Win32Platform = VER_PLATFORM_WIN32_NT;

  IsWin2K := IsWinNT and (Win32MajorVersion = 5) and (Win32MinorVersion = 0);
  IsWin2KOrLater := IsWinNT and (Win32MajorVersion >= 5);
  IsWinXP := IsWinNT and (Win32MajorVersion = 5) and (Win32MinorVersion > 0);
  IsWinXPOrLater := IsWinNT and (Win32MajorVersion >= 5) and not IsWin2K;
  IsWin2KOrXP := IsWin2K or IsWinXP;

  IsWinVista := IsWinNT and (Win32MajorVersion = 6);
  IsWinVistaOrLater := IsWinNT and (Win32MajorVersion >= 6);
  IsWinSeven := IsWinNT and (Win32MajorVersion = 6) and (Win32MinorVersion = 1);

  // IsWow64Process
  AIsWow64Process := GetProcAddress(GetModuleHandle(kernel32), 'IsWow64Process');
  if Assigned(AIsWow64Process) and AIsWow64Process(GetCurrentProcess, @AIsWow64) then
    IsWow64 := AIsWow64
  else
    IsWow64 := False;
end;

initialization
  InitPlatformInfo;
  FStartOfWeek := dxGetLocalStartOfWeek;

finalization
  FreeAndNil(FdxResourceStringsRepository);

end.
