{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressSpellChecker                                          }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSPELLCHECKER AND ALL           }
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

unit dxSpellCheckerUtils;

{$I cxVer.inc}

interface

uses
  Windows, Classes, SysUtils, cxClasses, dxCore;

type
  TdxCapitalizationType = (ctLower, ctCapitalized, ctUpper, ctMixedCapitalized, ctMixed);

  TdxSpellCheckerStrings = class(TList)
  private
    FCodePage: Cardinal;
    function GetItem(Index: Integer): PWideChar; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetText: WideString;
    procedure SetText(const AValue: WideString);
    function GetLength(Index: Integer): Integer;
  protected
    function AddRaw(AData: Pointer; ALength: Integer): PWideChar;
    function ItemLength(P: PWideChar): Integer;
  public
    constructor Create(ACodePage: Cardinal = 0);
    function Add(const S: WideString): PWideChar;
    procedure Clear; override;
    procedure LoadFromFile(const AFileName: TFileName);
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToFile(const AFileName: TFileName);
    procedure SaveToStream(AStream: TStream);

    property CodePage: Cardinal read FCodePage write FCodePage;
    property Items[Index: Integer]: PWideChar read GetItem; default;
    property Lengths[Index: Integer]: Integer read GetLength;
    property Text: WideString read GetText write SetText;
  end;

  { TdxCodePage }

  TdxSpellCheckerCodePage = class
  private
    FCode: Cardinal;
    function GetName: WideString;
  public
    constructor Create(ACode: Cardinal);

    property Code: Cardinal read FCode;
    property Name: WideString read GetName;
  end;

  { TdxSpellCheckerCodePages }

  TdxSpellCheckerCodePages = class(TcxObjectList)
  private
    function GetCode(AIndex: Integer): Cardinal;
    function GetCodeByName(const AName: WideString): Cardinal;
    function GetItem(AIndex: Integer): TdxSpellCheckerCodePage;
    function GetName(AIndex: Integer): WideString;
    function GetNameByCode(ACode: Cardinal): WideString;
  protected
    function CallbackProc(ACodePage: PWideChar): Cardinal; stdcall;
  public
    constructor Create(AOnlyInstalled: Boolean);

    procedure PopulateCodePages(AList: TStringList);

    property Code[AIndex: Integer]: Cardinal read GetCode;
    property CodeByName[const AName: WideString]: Cardinal read GetCodeByName;
    property Items[AIndex: Integer]: TdxSpellCheckerCodePage read GetItem; default;
    property Name[AIndex: Integer]: WideString read GetName;
    property NameByCode[ACode: Cardinal]: WideString read GetNameByCode;
  end;

{$IFNDEF DELPHI12}
function StrAlloc(ASize: Cardinal): PWideChar;
procedure StrDispose(S: PWideChar);
function StrCat(ADest: PWideChar; const ASource: PWideChar): PWideChar;
function StrComp(const S1, S2: PWideChar): Integer;
function StrCopy(ADest: PWideChar; const ASource: PWideChar): PWideChar;
function StrEnd(const Str: PWideChar): PWideChar;
function StrLComp(const S1, S2: PWideChar; AMaxLen: Cardinal): Integer;
function StrLCopy(ADest: PWideChar; const ASource: PWideChar; AMaxLen: Cardinal): PWideChar;
function StrLen(const Str: PWideChar): Cardinal;
function StrMove(ADest: PWideChar; const ASource: PWideChar; ACount: Cardinal): PWideChar;
function StrNew(const S: PWideChar): PWideChar;
function StrPos(const S1, S2: PWideChar): PWideChar;
function StrScan(const S: PWideChar; C: WideChar): PWideChar;
{$ENDIF}
function StrEquals(const S1, S2: PWideChar): Boolean;

function CreateAlphabetFromAnsiString(ACodePage: Cardinal;
  const AnsiAlphabet: AnsiString; ACaseSensitive: Boolean): WideString;
function CreateDefaultAlphabet(ACodePage: Cardinal; ACaseSensitive: Boolean = False): WideString;
function GetCodePageByName(AName: AnsiString): Cardinal; overload;
function GetCodePageByName(AName: PWideChar): Cardinal; overload;
function GetWideCharCount(AChar: WideChar; const S: WideString): Integer;
function GetWordCapitalizationType(const S: WideString): TdxCapitalizationType; overload;
function GetWordCapitalizationType(S: PWideChar; ALength: Integer; ALangID: LCID): TdxCapitalizationType; overload;
function IsUrl(const S: WideString): Boolean;
function LanguageToCodePage(ALanguage: Cardinal): Integer;
function WideCapitalizeCase(const S: WideString): WideString;
function WideCharInSet(C: WideChar; const ACharSet: TdxAnsiCharSet): Boolean; {$IFDEF DELPHI9} inline;{$ENDIF}
function WideIsAlphaNumeric(Ch: WideChar): Boolean;
function WideIsSpace(Ch: WideChar): Boolean; {$IFDEF DELPHI9} inline;{$ENDIF}
function WideIsUpCase(Ch: WideChar): Boolean; {$IFDEF DELPHI9} inline;{$ENDIF}
function WideIsLoCase(Ch: WideChar): Boolean; {$IFDEF DELPHI9} inline;{$ENDIF}
function WideLowCase(Ch: WideChar; ALangID: LCID): WideChar; {$IFDEF DELPHI9} inline;{$ENDIF}
function WideUpCase(Ch: WideChar; ALangID: LCID): WideChar; {$IFDEF DELPHI9} inline;{$ENDIF}
function WidePatternCase(const APattern, S: WideString): WideString;
function WidePos(const ASubStr, S: WideString): Integer;
function WideStringContainsAlpha(const S: WideString): Boolean;
function WideCharPos(Ch: WideChar; const S: WideString): Integer;
function WideStartsWith(const ASubStr, S: WideString): Boolean;
function WideEndsWith(const ASubStr, S: WideString): Boolean;
function StreamToAnsiString(AStream: TStream; APos: Integer; ASize: Integer = 0): AnsiString;
function StreamToWideString(AStream: TStream; ACodePage: Cardinal;
  APos: Integer; ASize: Integer = 0): WideString;

function dxGetCodePageName(ACodePage: Cardinal): WideString;
procedure dxPopulateCodePages(AList: TStringList; AOnlyInstalled: Boolean = True);

implementation

type
  TdxHunspellCodePage = record
    Name: AnsiString;
    CodePage: Cardinal;
    Description: AnsiString;
  end;

const
  DefaultAnsiAlphabet: AnsiString =
    '&''-ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' +
    #$8A#$8C#$8D#$8E#$8F#$92#$9A#$9C#$9D#$9E#$9F#$A1#$A2#$A3#$A5#$A6#$A8 +
    #$A9#$AB#$AC#$AE#$AF#$B1#$B2#$B3#$B6#$B8#$B9#$BB#$BC#$BE#$BF#$C0#$C1 +
    #$C2#$C3#$C4#$C5#$C6#$C7#$C8#$C9#$CA#$CB#$CC#$CD#$CE#$CF#$D0#$D1#$D2 +
    #$D3#$D4#$D5#$D6#$D7#$D8#$D9#$DA#$DB#$DC#$DD#$DE#$DF#$E0#$E1#$E2#$E3 +
    #$E4#$E5#$E6#$E7#$E8#$E9#$EA#$EB#$EC#$ED#$EE#$EF#$F0#$F1#$F2#$F3#$F4 +
    #$F5#$F6#$F7#$F8#$F9#$FA#$FB#$FC#$FD#$FE#$FF;

  TdxHunspellCodePages: array [0..17] of TdxHunspellCodePage = (
    (Name: 'UTF-8'; CodePage: 65001; Description: 'UTF-8'),
    (Name: 'ISO8859-1'; CodePage: 28591; Description: 'ISO 8859-1 Latin I'),
    (Name: 'ISO8859-2'; CodePage: 28592; Description: 'ISO 8859-2 Central Europe'),
    (Name: 'ISO8859-3'; CodePage: 28593; Description: 'ISO 8859-3 Latin 3'),
    (Name: 'ISO8859-4'; CodePage: 28594; Description: 'ISO 8859-4 Baltic'),
    (Name: 'ISO8859-5'; CodePage: 28595; Description: 'ISO 8859-5 Cyrillic'),
    (Name: 'ISO8859-6'; CodePage: 28596; Description: 'ISO 8859-6 Arabic'),
    (Name: 'ISO8859-7'; CodePage: 28597; Description: 'ISO 8859-7 Greek'),
    (Name: 'ISO8859-8'; CodePage: 28598; Description: 'ISO 8859-8 Hebrew: Visual Ordering'),
    (Name: 'ISO8859-9'; CodePage: 28599; Description: 'ISO 8859-9 Latin 5'),
    (Name: 'ISO8859-10'; CodePage: 28600; Description: 'ISO 8859-10 Latin 6'),
    (Name: 'ISO8859-13'; CodePage: 28603; Description: 'ISO 8859-13 Latin 7'),
    (Name: 'ISO8859-14'; CodePage: 28604; Description: 'ISO 8859-14 Latin 8'),
    (Name: 'ISO8859-15'; CodePage: 28605; Description: 'ISO 8859-15 Latin 9'),
    (Name: 'KOI8-R'; CodePage: 20866; Description: 'Russian - KOI8'),
    (Name: 'KOI8-U'; CodePage: 21866; Description: 'Ukrainian - KOI8-U'),
    (Name: 'microsoft-cp1251'; CodePage: 1251; Description: 'ANSI - Cyrillic'),
    (Name: 'ISCII-DEVANAGARI'; CodePage: 57002; Description: 'ISCII - Devanagari')
  );

var
  dxCodePages: TStringList;

{$IFNDEF DELPHI12}
function StrAlloc(ASize: Cardinal): PWideChar;
begin
  ASize := ASize * SizeOf(WideChar);
  Inc(ASize, SizeOf(Cardinal));
  GetMem(Result, ASize);
  Cardinal(Pointer(Result)^) := ASize;
  Inc(Result, SizeOf(Cardinal) div 2);
end;

procedure StrDispose(S: PWideChar);
begin
  if S <> nil then
  begin
    Dec(S, SizeOf(Cardinal) div 2);
    FreeMem(S, Cardinal(Pointer(S)^));
  end;
end;

function StrCat(ADest: PWideChar; const ASource: PWideChar): PWideChar;
begin
  StrCopy(StrEnd(ADest), ASource);
  Result := ADest;
end;

function StrComp(const S1, S2: PWideChar): Integer;
var
  P1, P2: PWideChar;
  C1, C2: WideChar;
begin
  P1 := S1;
  P2 := S2;
  while True do
  begin
    C1 := P1^;
    C2 := P2^;
    if (C1 <> C2) or (C1 = #0) then
    begin
      Result := Ord(C1) - Ord(C2);
      Exit;
    end;
    Inc(P1);
    Inc(P2);
  end;
end;

function StrCopy(ADest: PWideChar; const ASource: PWideChar): PWideChar;
asm
  SUB   EDX, EAX
  TEST  EAX, 3
  PUSH  EAX
  JZ    @@1
  MOVZX ECX, WORD PTR[EAX+EDX]
  MOV   [EAX], CX
  TEST  ECX, ECX
  JZ    @@2
  ADD   EAX, 2
@@1:
  MOVZX ECX, WORD PTR[EAX+EDX]
  TEST  ECX, ECX
  JZ    @@3
  MOV   ECX, [EAX+EDX]
  MOV   [EAX], ECX
  ADD   EAX, 4
  CMP   ECX, $FFFF
  JA    @@1
@@2:
  POP   EAX
  RET
@@3:
  MOV   [EAX], CX
  POP   EAX
end;

function StrEnd(const Str: PWideChar): PWideChar; 
asm
  CMP WORD PTR [EAX], 0
  JE @@2
@@1:
  MOV CX, [EAX]
  ADD EAX, 2
  TEST CX, CX
  JNZ @@1
  SUB EAX, 2
@@2:
end;

function StrLComp(const S1, S2: PWideChar; AMaxLen: Cardinal): Integer;
var
  P1, P2: PWideChar;
  I: Cardinal;
  C1, C2: WideChar;
begin
  P1 := S1;
  P2 := S2;
  I := 0;
  while I < AMaxLen do
  begin
    C1 := P1^;
    C2 := P2^;
    if (C1 <> C2) or (C1 = #0) then
    begin
      Result := Ord(C1) - Ord(C2);
      Exit;
    end;
    Inc(P1);
    Inc(P2);
    Inc(I);
  end;
  Result := 0;
end;

function StrLCopy(ADest: PWideChar; const ASource: PWideChar; AMaxLen: Cardinal): PWideChar;
var
  L: Cardinal;
begin
  Result := ADest;
  L := StrLen(ASource);
  if L > AMaxLen then
    L := AMaxLen;
  Move(ASource^, ADest^, L * SizeOf(WideChar));
  ADest[L] := #0;
end;

function StrLen(const Str: PWideChar): Cardinal;
asm
  CMP WORD PTR [EAX], 0
  JE @@1
  MOV EDX, EAX
  NEG EDX
@@2:
  MOV CX, WORD PTR [EAX]
  ADD EAX, 2
  TEST CX, CX
  JNZ @@2
  LEA EAX, [EAX + EDX - 2]
  SHR EAX, 1
  RET
@@1:
  XOR EAX, EAX
end;

function StrMove(ADest: PWideChar; const ASource: PWideChar; ACount: Cardinal): PWideChar;
begin
  Result := ADest;
  Move(ASource^, ADest^, ACount * SizeOf(WideChar));
end;

function StrNew(const S: PWideChar): PWideChar;
var
  ASize: Cardinal;
begin
  if S = nil then
    Result := nil
  else
  begin
    ASize := StrLen(S) + 1;
    Result := StrMove(StrAlloc(ASize), S, ASize);
  end;
end;

function StrScan(const S: PWideChar; C: WideChar): PWideChar;
begin
  Result := S;
  while Result^ <> #0 do
  begin
    if Result^ = C then
      Exit;
    Inc(Result);
  end;
  if C <> #0 then
    Result := nil;
end;

function StrPos(const S1, S2: PWideChar): PWideChar;
asm
  PUSH    EDI
  PUSH    ESI
  PUSH    EBX
  OR      EAX,EAX
  JE      @@2
  OR      EDX,EDX
  JE      @@2
  MOV     EBX,EAX
  MOV     EDI,EDX
  XOR     AX,AX
  MOV     ECX,0FFFFFFFFH
  REPNE   SCASW
  NOT     ECX
  DEC     ECX
  JE      @@2
  MOV     ESI,ECX
  MOV     EDI,EBX
  MOV     ECX,0FFFFFFFFH
  REPNE   SCASW
  NOT     ECX
  SUB     ECX,ESI
  JBE     @@2
  MOV     EDI,EBX
  LEA     EBX,[ESI-1]
@@1:
  MOV     ESI,EDX
  LODSW
  REPNE   SCASW
  JNE     @@2
  MOV     EAX,ECX
  PUSH    EDI
  MOV     ECX,EBX
  REPE    CMPSW
  POP     EDI
  MOV     ECX,EAX
  JNE     @@1
  LEA     EAX,[EDI-2]
  JMP     @@3
@@2:
  XOR     EAX,EAX
@@3:
  POP     EBX
  POP     ESI
  POP     EDI
end;

{$ENDIF}

function StrEquals(const S1, S2: PWideChar): Boolean;
var
  P1, P2: PWideChar;
  C1, C2: WideChar;
begin
  P1 := S1;
  P2 := S2;
  while True do
  begin
    C1 := P1^;
    C2 := P2^;
    if (C1 <> C2) or (C1 = #0) then
    begin
      Result := C1 = C2;
      Exit;
    end;
    Inc(P1);
    Inc(P2);
  end;
end;

type
  TcxCPInfoEx = record
    MaxCharSize: UINT;
    DefaultChar: array [0..MAX_DEFAULTCHAR - 1] of BYTE;
    LeadByte: array [0..MAX_LEADBYTES - 1] of BYTE;
    UnicodeDefaultChar: WCHAR;
    CodePage: UINT;
    CodePageName: array [0..MAX_PATH - 1] of WCHAR;
  end;
  PcxCPInfoEx = ^TcxCPInfoEx;

function GetCPInfoEx(CodePage: Cardinal; dwFlags: DWORD; var AInfoEx: TcxCPInfoEx): BOOL; stdcall;
  external 'kernel32.dll' name 'GetCPInfoExW';

function dxCodePagesSort(AItem1, AItem2: TdxSpellCheckerCodePage): Integer;
begin
  Result := AItem1.Code - AItem2.Code;
end;

function CreateAlphabetFromAnsiString(ACodePage: Cardinal;
  const AnsiAlphabet: AnsiString; ACaseSensitive: Boolean): WideString;
var
  S: WideString;
  I: Integer;
begin
  if ACaseSensitive then
    S := dxAnsiStringToWideString(AnsiAlphabet, ACodePage)
  else
    S := WideUpperCase(dxAnsiStringToWideString(AnsiAlphabet, ACodePage));
  Result := '';
  for I := 1 to Length(S) do
    if (WideCharPos(S[I], Result) = 0) and dxWideIsAlpha(S[I]) then
      Result := Result + S[I];
end;

function CreateDefaultAlphabet(ACodePage: Cardinal; ACaseSensitive: Boolean = False): WideString;
begin
  Result := CreateAlphabetFromAnsiString(ACodePage, DefaultAnsiAlphabet, ACaseSensitive);
end;

function GetCodePageByName(AName: AnsiString): Cardinal;
var
  I: Integer;
begin
  Result := CP_ACP;
  for I := Low(TdxHunspellCodePages) to High(TdxHunspellCodePages) do
    if SysUtils.StrComp(PAnsiChar(TdxHunspellCodePages[I].Name), PAnsiChar(AName)) = 0 then
    begin
      Result := TdxHunspellCodePages[I].CodePage;
      Break;
    end;
end;

function GetCodePageByName(AName: PWideChar): Cardinal;
var
  I: Integer;
begin
  Result := CP_ACP;
  for I := Low(TdxHunspellCodePages) to High(TdxHunspellCodePages) do
    if StrComp(PWideChar(dxAnsiStringToWideString(TdxHunspellCodePages[I].Name)), AName) = 0 then
    begin
      Result := TdxHunspellCodePages[I].CodePage;
      Break;
    end;
end;

function GetWideCharCount(AChar: WideChar; const S: WideString): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 1 to Length(S) do
    if AChar = S[I] then
      Inc(Result);
end;

function IsSpecialAlpha(AChar: WideChar; ALangID: LCID): Boolean; {$IFDEF DELPFI9} inline; {$ENDIF}
begin
  Result := AChar = #$00DF;
  if Result then
    Result := WideLowCase(AChar, ALangID) = WideUpCase(AChar, ALangID);
end;

function GetWordCapitalizationType(S: PWideChar; ALength: Integer; ALangID: LCID): TdxCapitalizationType;
const
  WordBufferLength = 512;
var
  ABuffer: array[0..WordBufferLength - 1] of Word;
  ACharTypes: PWordArray;
  I, AlphaCount, AUpperCount: Integer;
begin
  Result := ctLower;
  if ALength = 0 then Exit;
  if ALength > WordBufferLength then
    GetMem(ACharTypes, ALength * SizeOf(Word))
  else
    ACharTypes := @ABuffer;
  if dxGetStringTypeW(CT_CTYPE1, S, ALength, ACharTypes^) then
  begin
    AlphaCount := 0;
    AUpperCount := 0;
    for I := 0 to ALength - 1 do
    begin
      if (ACharTypes[I] and C1_ALPHA > 0) and not IsSpecialAlpha((S + I)^, ALangID) then
      begin
        Inc(AlphaCount);
        if ACharTypes[I] and C1_UPPER > 0 then
        begin
          Inc(AUpperCount);
          if AlphaCount = 1 then
            Result := ctCapitalized;
        end;
      end;
    end;
    if AlphaCount > 0 then
    begin
      if AlphaCount = AUpperCount then
        Result := ctUpper
      else if AUpperCount = 0 then
        Result := ctLower
      else if Result = ctCapitalized then
      begin
        if AUpperCount > 1 then
          Result := ctMixedCapitalized;
      end
      else
        Result := ctMixed;
    end;
  end;
  if ALength > WordBufferLength then
    FreeMem(ACharTypes, ALength * SizeOf(Word));
end;

function GetWordCapitalizationType(const S: WideString): TdxCapitalizationType;
begin
  Result := GetWordCapitalizationType(PWideChar(S), Length(S), LOCALE_USER_DEFAULT);
end;

function IsUrl(const S: WideString): Boolean;
const
  Urls: array[0..8] of WideString = ('http://', 'https://', 'ftp://', 'www.', 'file://', '\\', 'gopher://', 'nntp://', 'news://');
var
  ALower: WideString;
  I: Integer;
begin
  Result := Length(S) > 2;
  if Result then
  begin
    ALower := WideLowerCase(S);
    for I := Low(Urls) to High(Urls) do
      if WideStartsWith(Urls[I], ALower) then
        Exit;
    Result := False;
  end;
end;

function LanguageToCodePage(ALanguage: Cardinal): Integer;
var
  ABuffer: array[0..6] of Char;
begin
  GetLocaleInfo(ALanguage, LOCALE_IDEFAULTANSICODEPAGE, ABuffer, 6);
  Result:= StrToIntDef(ABuffer, GetACP);
end;

function WideCapitalizeCase(const S: WideString): WideString;
begin
  Result := '';
  if Length(S) > 0 then
  begin
    Result := WideLowerCase(S);
    Result[1] := WideUpCase(S[1], LOCALE_USER_DEFAULT);
  end;
end;

function WideCharInSet(C: WideChar; const ACharSet: TdxAnsiCharSet): Boolean; {$IFDEF DELPHI9} inline;{$ENDIF}
begin
  Result := (C < #$0100) and (AnsiChar(C) in ACharSet);
end;

function WideIsAlphaNumeric(Ch: WideChar): Boolean;
begin
  Result := dxWideIsAlpha(Ch) or dxWideIsNumeric(Ch);
end;

function WideIsSpace(Ch: WideChar): Boolean;
begin
  Result := dxGetWideCharCType1(Ch) and C1_SPACE > 0;
end;

function WideIsUpCase(Ch: WideChar): Boolean;
begin
  Result := dxGetWideCharCType1(Ch) and C1_UPPER > 0;
end;

function WideIsLoCase(Ch: WideChar): Boolean;
begin
  Result := dxGetWideCharCType1(Ch) and C1_LOWER > 0;
end;

function WideLowCase(Ch: WideChar; ALangID: LCID): WideChar;
begin
  LCMapStringW(ALangID, LCMAP_LOWERCASE + LCMAP_LINGUISTIC_CASING, @Ch, 1, @Result, 1);
end;

function WideUpCase(Ch: WideChar; ALangID: LCID): WideChar;
begin
  LCMapStringW(ALangID, LCMAP_UPPERCASE + LCMAP_LINGUISTIC_CASING, @Ch, 1, @Result, 1);
end;

function WidePatternCase(const APattern, S: WideString): WideString;
begin
  case GetWordCapitalizationType(APattern) of
    ctCapitalized:
      Result := WideCapitalizeCase(S);
    ctUpper:
      Result := WideUpperCase(S);
  else
    Result := WideLowerCase(S);
  end;
end;

function WidePos(const ASubStr, S: WideString): Integer;
var
  I: Integer;
  APos: Integer;
  ALenS, ALenSubStr: Integer;
begin
  Result := 0;
  ALenS := Length(S);
  ALenSubStr := Length(ASubStr);
  if (ALenSubStr = 0) or (ALenS = 0) or (ALenS < ALenSubStr) then
    Exit;
  APos := 1;
  for I := 1 to ALenS do
  begin
    if S[I] = ASubStr[APos] then
      Inc(APos)
    else
      APos := 1;
    if APos = ALenSubStr + 1 then
    begin
      Result := I - APos + 2;
      Break;
    end;
  end;
end;

function WideStringContainsAlpha(const S: WideString): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 1 to Length(S) do
    if dxWideIsAlpha(S[I]) then
    begin
      Result := True;
      Break;
    end;
end;

function WideCharPos(Ch: WideChar; const S: WideString): Integer;
var
  I: Integer;
begin
  for I := 1 to Length(S) do
    if S[I] = Ch then
    begin
      Result := I;
      Exit;
    end;
  Result := 0;
end;

function WideStartsWith(const ASubStr, S: WideString): Boolean;
var
  I, ALen1, ALen2: Integer;
begin
  ALen1 := Length(ASubStr);
  ALen2 := Length(S);
  Result := (ALen1 > 0) and (ALen1 <= ALen2);
  if Result then
  begin
    for I := 1 to ALen1 do
      if ASubStr[I] <> S[I] then
      begin
        Result := False;
        Exit;
      end;
  end;
end;

function WideEndsWith(const ASubStr, S: WideString): Boolean;
var
  I, ALen1, ALen2: Integer;
begin
  ALen1 := Length(ASubStr);
  ALen2 := Length(S);
  Result := (ALen1 > 0) and (ALen1 <= ALen2);
  if Result then
  begin
    for I := 1 to ALen1 do
      if ASubStr[I] <> S[(ALen2 - ALen1) + I] then
      begin
        Result := False;
        Exit;
      end;
  end;
end;

function StreamToAnsiString(AStream: TStream; APos: Integer; ASize: Integer = 0): AnsiString;
const
  BOM: packed array[0..2] of AnsiChar = (#$EF, #$BB, #$BF);
begin
  Result := '';
  AStream.Position := APos;
  if ASize = 0 then
    ASize := AStream.Size - APos;
  if ASize > 0 then
  begin
    SetLength(Result, ASize);
    AStream.Read(Result[1], ASize);
    if (ASize >= 3) and CompareMem(@Result[1], @BOM, 3) then
      Delete(Result, 1, 3);
  end;
end;

function StreamToWideString(AStream: TStream; ACodePage: Cardinal;
  APos: Integer; ASize: Integer = 0): WideString;
begin
  Result := dxAnsiStringToWideString(StreamToAnsiString(AStream, APos, ASize), ACodePage);
end;

{ TdxSpellCheckerStrings }

constructor TdxSpellCheckerStrings.Create(ACodePage: Cardinal);
begin
  inherited Create;
  FCodePage := ACodePage;
  Capacity := 256 * 1024;
end;

function TdxSpellCheckerStrings.Add(
  const S: WideString): PWideChar;
begin
  if Length(S) = 0 then
    Result := nil
  else
    Result := AddRaw(@S[1], Length(S));
end;

function TdxSpellCheckerStrings.AddRaw(AData: Pointer;
  ALength: Integer): PWideChar;
var
  ASize: Integer;
begin
  ASize := (ALength + 1) * Sizeof(WideChar);
  Inc(ASize, SizeOf(Cardinal) * 2);
  Result := AllocMem(ASize);
  Cardinal(Pointer(Result)^) := ASize;
  Inc(Integer(Result), SizeOf(Cardinal));
  Cardinal(Pointer(Result)^) := ALength;
  Inc(Integer(Result), SizeOf(Cardinal));
  System.Move(AData^, Pointer(Result)^, ALength * Sizeof(WideChar));
  inherited Add(Pointer(Result));
end;

procedure TdxSpellCheckerStrings.Clear;
var
  ALine: PWideChar;
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    ALine := Items[I];
    if ALine <> nil then
    begin
      Dec(Integer(ALine), SizeOf(Cardinal) * 2);
      FreeMem(ALine, Cardinal(Pointer(ALine)^));
    end;
  end;
  inherited Clear;
end;

function TdxSpellCheckerStrings.ItemLength(P: PWideChar): Integer;
begin
  if P = nil then
    Result := 0
  else
  begin
    Dec(Integer(P), SizeOf(Cardinal));
    Result := Cardinal(Pointer(P)^);
  end;
end;

procedure TdxSpellCheckerStrings.LoadFromFile(const AFileName: TFileName);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxSpellCheckerStrings.LoadFromStream(AStream: TStream);
begin
  Text := StreamToWideString(AStream, CodePage, AStream.Position);
end;

procedure TdxSpellCheckerStrings.SaveToFile(const AFileName: TFileName);
var
  AStream: TFileStream;
begin
  AStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxSpellCheckerStrings.SaveToStream(AStream: TStream);
var
  S: AnsiString;
begin
  S := dxWideStringToAnsiString(Text, CodePage);
  if Length(S) > 0 then
    AStream.Write(S[1], Length(S));
end;

function TdxSpellCheckerStrings.GetItem(Index: Integer): PWideChar;
begin
  Result := PWideChar(inherited Items[Index]);
end;

function TdxSpellCheckerStrings.GetLength(Index: Integer): Integer;
begin
  Result := ItemLength(PWideChar(inherited Items[Index]));
end;

function TdxSpellCheckerStrings.GetText: WideString;
var
  I, ASize: Integer;
  ALine: PWideChar;
begin
  ASize := 0;
  for I := 0 to Count - 1 do
    Inc(ASize, ItemLength(Items[I]));
  Inc(ASize, Count * 2);
  SetLength(Result, ASize);
  ASize := 1;
  for I := 0 to Count - 1 do
  begin
    ALine := Items[I];
    System.Move(ALine^, Result[ASize], ItemLength(ALine) * SizeOf(WideChar));
    Inc(ASize, ItemLength(ALine));
    Result[ASize] := #13;
    Result[ASize + 1] := #10;
    Inc(ASize, 2);
  end;
end;

procedure TdxSpellCheckerStrings.SetText(const AValue: WideString);
var
  P, ALine: PWideChar;
begin
  Clear;
  if Length(AValue) = 0 then Exit;
  P := Pointer(AValue);
  while P^ <> #0 do
  begin
    ALine := P;
    while (P^ <> #0) and (P^ <> #10) and (P^ <> #13) do Inc(P);
    AddRaw(ALine, P - ALine);
    if P^ = #13 then Inc(P);
    if P^ = #10 then Inc(P);
  end;
end;

{ TdxSpellCheckerCodePage }

constructor TdxSpellCheckerCodePage.Create(ACode: Cardinal);
begin
  FCode := ACode;
end;

function TdxSpellCheckerCodePage.GetName: WideString;
begin
  Result := dxGetCodePageName(Code);
end;

{ TdxSpellCheckerCodePages }

var
  FTempCodePages: TdxSpellCheckerCodePages;

function EnumCodePagesCallback(ACodePage: PWideChar): Cardinal; stdcall;
begin
  Result := FTempCodePages.CallbackProc(ACodePage);
end;

constructor TdxSpellCheckerCodePages.Create(AOnlyInstalled: Boolean);
var
  AFlags: Cardinal;
begin
  inherited Create;
  if AOnlyInstalled then
    AFlags := CP_INSTALLED
  else
    AFlags := CP_SUPPORTED;
  FTempCodePages := Self;
  EnumSystemCodePagesW(@EnumCodePagesCallback, AFlags);
  Sort(@dxCodePagesSort);
end;

procedure TdxSpellCheckerCodePages.PopulateCodePages(AList: TStringList);
var
  I: Integer;
begin
  AList.Clear;
  for I := 0 to Count - 1 do
    AList.Add(Items[I].Name);
end;

function TdxSpellCheckerCodePages.CallbackProc(ACodePage: PWideChar): Cardinal; stdcall;
begin
  if Length(ACodePage) > 0 then
    Add(TdxSpellCheckerCodePage.Create(StrToInt(ACodePage)));
  Result := 1;
end;

function TdxSpellCheckerCodePages.GetCode(AIndex: Integer): Cardinal;
begin
  Result := Items[AIndex].Code;
end;

function TdxSpellCheckerCodePages.GetCodeByName(const AName: WideString): Cardinal;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    if WideCompareStr(AName, Items[I].Name) = 0 then
    begin
      Result := Items[I].Code;
      Break;
    end;
end;

function TdxSpellCheckerCodePages.GetItem(AIndex: Integer): TdxSpellCheckerCodePage;
begin
  Result := TdxSpellCheckerCodePage(inherited Items[AIndex]);
end;

function TdxSpellCheckerCodePages.GetName(AIndex: Integer): WideString;
begin
  Result := Items[AIndex].Name;
end;

function TdxSpellCheckerCodePages.GetNameByCode(ACode: Cardinal): WideString;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to Count - 1 do
    if Items[I].Code = ACode then
    begin
      Result := Items[I].Name;
      Break;
    end;
end;

function dxGetCodePageName(ACodePage: Cardinal): WideString;
var
  AInfo: TcxCPInfoEx;
begin
  FillChar(AInfo, SizeOf(AInfo), 0);
  GetCPInfoEx(ACodePage, 0, AInfo);
  Result := AInfo.CodePageName;
  if Length(Result) = 0 then
    Result := IntToStr(ACodePage);
end;

procedure dxPopulateCodePages(AList: TStringList; AOnlyInstalled: Boolean = True);

  function CallbackProc(ACodePage: PWideChar): Cardinal; stdcall;
  var
    AName: WideString;
  begin
    AName := dxGetCodePageName(StrToInt(ACodePage));
    if Length(AName) > 0 then
      dxCodePages.Add(AName)
    else
      dxCodePages.Add(ACodePage);
    Result := 1;
  end;

var
  AFlags: Cardinal;
begin
  dxCodePages.Clear;
  if AOnlyInstalled then
    AFlags := CP_INSTALLED
  else
    AFlags := CP_SUPPORTED;
  EnumSystemCodePagesW(@CallbackProc, AFlags);
  dxCodePages.Sort;
  AList.Clear;
  AList.AddStrings(dxCodePages);
end;

initialization
  dxCodePages := TStringList.Create;

finalization
  FreeAndNil(dxCodePages);

end.
