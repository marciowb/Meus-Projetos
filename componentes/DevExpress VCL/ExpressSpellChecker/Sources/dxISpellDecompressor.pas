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

unit dxISpellDecompressor;

{$I cxVer.inc}

interface

uses
  Windows, Classes, SysUtils, cxClasses, dxSpellChecker, dxSpellCheckerUtils;

type
  TdxCustomAffixElement = class;
  TdxAffixCompressionDictionary = class;
  TdxOpenOfficeDictionary = class;

  TdxAffixElementState = (aesNone, aesPrefix, aesSuffix);

  { TdxCharValidator }

  TdxCharValidator = class
  private
    FAnyChar: Boolean;
    FChars: WideString;
    FValid: Boolean;
  public
    constructor Create(const AChars: WideString; AValid: Boolean);
    constructor CreateAnyChar;
    function IsValidChar(AChar: WideChar): Boolean;
  end;

  { TdxWordValidator }

  TdxRuleValidator = class(TcxObjectList)
  private
    function GetItem(Index: Integer): TdxCharValidator; {$IFDEF DELPHI9} inline; {$ENDIF}
  public
    procedure AddAnyCharValid;
    procedure AddCharInfo(const AChars: WideString; AValid: Boolean);
    function IsValid(const AWord: WideString; AFromStart: Boolean): Boolean;

    property Items[Index: Integer]: TdxCharValidator read GetItem; default;
  end;

  { TdxAffixRule }

  TdxAffixRule = class
  private
    FAffix: TdxCustomAffixElement;
    FAppendString: WideString;
    FForceValid: Boolean;
    FStripString: WideString;
    FValidator: TdxRuleValidator;
    function GetIsPrefix: Boolean; {$IFDEF DELPHI9} inline; {$ENDIF}
  protected
    function DoParse(const ARule: WideString): Boolean; virtual; abstract;
    function RemoveComments(const ARule: WideString): WideString; virtual; abstract;

    property Affix: TdxCustomAffixElement read FAffix;
    property AppendString: WideString read FAppendString write FAppendString;
    property ForceValid: Boolean read FForceValid write FForceValid;
    property IsPrefix: Boolean read GetIsPrefix;
    property StripString: WideString read FStripString write FStripString;
    property Validator: TdxRuleValidator read FValidator;
  public
    constructor Create(AAffix: TdxCustomAffixElement);
    destructor Destroy; override;
    function CanApply(const AWord: WideString): Boolean;
    function GetWordform(const AWord, ACheckStripWord: WideString): WideString;
    function Parse(const ARule: WideString): Boolean; virtual;
  end;

  { TdxAffixRuleList }

  TdxAffixRuleList = class(TcxObjectList)
  private
    function GetItem(Index: Integer): TdxAffixRule; {$IFDEF DELPHI9} inline; {$ENDIF}
  public
    procedure AddWordforms(const AWord: WideString;
      ADictionary: TdxSpellCheckerStrings; ALangID: Cardinal);

    property Items[Index: Integer]: TdxAffixRule read GetItem; default;
  end;

  { TdxCustomAffixElement }

  TdxCustomAffixElement = class
  private
    FCanCombine: Boolean;
    FKey: WideChar;
    FLangID: Cardinal;
    FRules: TdxAffixRuleList;
  protected
    function CreateRule: TdxAffixRule; virtual; abstract;
    function GetIsPrefix: Boolean; virtual; abstract;

    property CanCombine: Boolean read FCanCombine;
    property IsPrefix: Boolean read GetIsPrefix;
    property LangID: Cardinal read FLangID;
    property Rules: TdxAffixRuleList read FRules;
  public
    constructor Create(AKey: WideChar; ACanCombine: Boolean; ALangID: Cardinal); virtual;
    destructor Destroy; override;
    procedure AddRule(ARuleDefinition: WideString);
    procedure AddWordforms(const AWord: WideString; ADictionary: TdxSpellCheckerStrings); virtual;

    property Key: WideChar read FKey;
  end;

  { TdxAffixList }

  TdxAffixList = class(TcxObjectList)
  private
    function GetItem(Index: Integer): TdxCustomAffixElement; {$IFDEF DELPHI9} inline; {$ENDIF}
  public
    function FindForKey(AKey: WideChar; AIsPrefix: Boolean): TdxCustomAffixElement;

    property Items[Index: Integer]: TdxCustomAffixElement read GetItem; default;
  end;

  // ISpell support

  { TdxISpellAffixRule }

  TdxISpellAffixRule = class(TdxAffixRule)
  protected
    procedure BuildValidator(const S: WideString); virtual;
    function DoParse(const ARule: WideString): Boolean; override;
    procedure ParseNewWordform(const S: WideString); virtual;
    function RemoveComments(const ARule: WideString): WideString; override;
  end;

  { TdxISpellPrefix }

  TdxISpellPrefix = class(TdxCustomAffixElement)
  protected
    function CreateRule: TdxAffixRule; override;
    function GetIsPrefix: Boolean; override;
  end;

  { TdxISpellSuffix }

  TdxISpellSuffix = class(TdxISpellPrefix)
  protected
    function GetIsPrefix: Boolean; override;
  end;

  { TdxCustomAffixDecompressor }

  TdxCustomAffixDecompressor = class
  private
    FAffixes: TdxAffixList;
    FAlphabet: WideString;
    FCodePage: Cardinal;
    FDictionary: TdxAffixCompressionDictionary;
    FPrefixes: TList;
    FSuffixes: TList;
    FWordforms: TdxSpellCheckerStrings;
  protected
    procedure CreateWordforms(const AWordDefinition: WideString); virtual;
    procedure CreateWordFormsForKeys(const AWord, AKeys: WideString);
    procedure GetLanguageInfo(AStream: TStream; out ACodePage: Cardinal;
      out AAlphabet: WideString); virtual; abstract;
    procedure ExtractWordInfo(const AWordDefinition: WideString; out AWord, AKeys: WideString);
    procedure InitParsing; virtual;
    procedure Parse(AStrings: TdxSpellCheckerStrings); virtual;
    procedure ParseLine(S: WideString); virtual; abstract;
    function RemoveComments(const S: WideString): WideString; virtual;
    procedure Reset;

    property Prefixes: TList read FPrefixes;
    property Suffixes: TList read FSuffixes;
    property Wordforms: TdxSpellCheckerStrings read FWordforms;
  public
    constructor Create(ADictionary: TdxAffixCompressionDictionary); virtual;
    destructor Destroy; override;
    procedure LoadFromFile(const AFileName: TFileName); virtual;
    procedure LoadFromStream(AStream: TStream); virtual;
    procedure PopulateWordForms(const AWordDefinition: WideString;
      ADictionary: TdxSpellCheckerWordList); virtual;

    property Affixes: TdxAffixList read FAffixes;
    property Alphabet: WideString read FAlphabet;
    property CodePage: Cardinal read FCodePage;
    property Dictionary: TdxAffixCompressionDictionary read FDictionary;
  end;

  { TdxAffixCompressionDictionary }

  TdxAffixCompressionDictionary = class(TdxCustomSpellCheckerDictionary)
  private
    FDictionaryPath: TFileName;
    FGrammarPath: TFileName;
    procedure SetDictionaryPath(const AValue: TFileName);
    procedure SetGrammarPath(const AValue: TFileName);
  protected
    function CreateDecompressor: TdxCustomAffixDecompressor; virtual; abstract;
    function DoLoad: Boolean; override;
    function GetDisplayName: string; override;
    procedure LoadGrammar(ADecompressor: TdxCustomAffixDecompressor); virtual;
    procedure LoadWordBase(AWordBase: TdxSpellCheckerStrings); virtual;
    procedure UpdateByDecompressor(ADecompressor: TdxCustomAffixDecompressor); virtual;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property DictionaryPath: TFileName read FDictionaryPath write SetDictionaryPath;
    property GrammarPath: TFileName read FGrammarPath write SetGrammarPath;
  end;

  { TdxISpellDecompressor }

  TdxISpellDecompressor = class(TdxCustomAffixDecompressor)
  private
    FCurrentAffix: TdxCustomAffixElement;
    FCurrentState: TdxAffixElementState;
  protected
    function CreateAffix(AKey: WideChar; ACanCombine: Boolean; AState: TdxAffixElementState): TdxCustomAffixElement; virtual;
    procedure ExtractKeyInfo(const ADefinition: WideString; out AKey: WideChar; out ACanCombine: Boolean); virtual;
    procedure GetLanguageInfo(AStream: TStream; out ACodePage: Cardinal;
      out AAlphabet: WideString); override;
    procedure InitParsing; override;
    function IsUnsupportedKeyWord(const S: WideString): Boolean; virtual;
    procedure ParseLine(S: WideString); override;
  end;

  { TdxISpellDictionary }

  TdxISpellDictionary = class(TdxAffixCompressionDictionary)
  protected
    function CreateDecompressor: TdxCustomAffixDecompressor; override;
  published
    property Alphabet;
    property CheckCapitalization;
    property CodePage;
    property DictionaryPath;
    property Enabled;
    property GrammarPath;
    property Language;
    property OnLoaded;
    property OnLoading;
  end;

  // Hunspell support

  { TdxHunspellAffixRule }

  TdxHunspellAffixRule = class(TdxISpellAffixRule)
  protected
    procedure BuildValidator(const S: WideString); override;
    function DoParse(const ARule: WideString): Boolean; override;
  end;

  { TdxHunspellPrefix }

  TdxHunspellPrefix = class(TdxCustomAffixElement)
  protected
    function CreateRule: TdxAffixRule; override;
    function GetIsPrefix: Boolean; override;
  end;

  { TdxHunspellSuffix }

  TdxHunspellSuffix = class(TdxHunspellPrefix)
  protected
    function GetIsPrefix: Boolean; override;
  end;

  { TdxHunspellDecompressor }

  TdxHunspellDecompressor = class(TdxCustomAffixDecompressor)
  private
    FCurrentKey: WideChar;
    FCurrentKeyCanCombine: Boolean;
    FRepCount: Integer;
    function GetDictionary: TdxOpenOfficeDictionary;
  protected
    function CreateAffix(AKey: WideChar; ACanCombine: Boolean;
      AState: TdxAffixElementState): TdxCustomAffixElement; virtual;
    procedure GetLanguageInfo(AStream: TStream; out ACodePage: Cardinal;
      out AAlphabet: WideString); override;
    procedure InitParsing; override;
    procedure ParseLine(S: WideString); override;
    procedure ProcessAlphabet(S: WideString);
    procedure ProcessAffix(S: WideString; AState: TdxAffixElementState);
    procedure ProcessSubstitution(S: WideString);
  public
    property Dictionary: TdxOpenOfficeDictionary read GetDictionary;
  end;

  { TdxOpenOfficeSuggestionBuilder }

  TdxOpenOfficeSuggestionBuilder = class(TdxNearMissStrategy)
  private
    function GetDictionary: TdxOpenOfficeDictionary;
  protected
    procedure DoAddSuggestions; override;
    function FindPos(const ASubStr, AStr: WideString; var AStartPos: Integer): Boolean;
    procedure ProcessSubstitutions;
  public
    property Dictionary: TdxOpenOfficeDictionary read GetDictionary;
  end;

  { TdxOpenOfficeDictionary }

  TdxOpenOfficeDictionary = class(TdxAffixCompressionDictionary)
  private
    FSubstitutions: TdxSpellCheckerReplacementList;
  protected
    function CreateDecompressor: TdxCustomAffixDecompressor; override;
    function CreateSuggestionBuilder: TdxSpellCheckerSuggestionBuilder; override;
    procedure UpdateByDecompressor(ADecompressor: TdxCustomAffixDecompressor); override;

    property Substitutions: TdxSpellCheckerReplacementList read FSubstitutions;
  public
    constructor Create(ASpellChecker: TdxCustomSpellChecker); override;
    destructor Destroy; override;
  published
    property CheckCapitalization;
    property DictionaryPath;
    property Enabled;
    property GrammarPath;
    property Language;
    property OnLoaded;
    property OnLoading;
  end;

implementation

uses
{$IFDEF DELPHI12}
  AnsiStrings,
{$ENDIF}
  dxSpellCheckerStrs, dxCore;

type
  TdxHunspellCodePage = record
    Name: AnsiString;
    CodePage: Cardinal;
    Description: AnsiString;
  end;

const
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

function RemoveGrammarComments(const S: WideString): WideString; overload;
var
  APos: Integer;
begin
  APos := WideCharPos('#', S);
  if APos > 0 then
    Result := Trim(Copy(S, 1, APos - 1))
  else
    Result := Trim(S);
end;

function RemoveGrammarComments(const S: AnsiString): AnsiString; overload;
var
  APos: Integer;
begin
  APos := AnsiPos(AnsiChar('#'), S);
  if APos > 0 then
    Result := Trim(Copy(S, 1, APos - 1))
  else
    Result := Trim(S);
end;

function GetFirstWord(var S: AnsiString; ARemove: Boolean = False): AnsiString; overload;
var
  L, R: Integer;
begin
  L := 1;
  while (L <= Length(S)) and (S[L] in [#0..' ']) do Inc(L);
  R := L + 1;
  while (R <= Length(S)) and not (S[R] in [#0..' ']) do Inc(R);
  Result := Copy(S, L, R - L);
  if ARemove and (Length(Result) > 0) then
  begin
    while (R <= Length(S)) and (S[R] in [#0..' ']) do Inc(R);
    Delete(S, 1, R - 1);
  end;
end;

function GetFirstWord(var S: WideString; ARemove: Boolean = False): WideString; overload;
var
  L, R: Integer;
begin
  L := 1;
  while (L <= Length(S)) and WideIsSpace(S[L]) do Inc(L);
  R := L + 1;
  while (R <= Length(S)) and not WideIsSpace(S[R]) do Inc(R);
  Result := Copy(S, L, R - L);
  if ARemove and (Length(Result) > 0) then
  begin
    while (R <= Length(S)) and WideIsSpace(S[R]) do Inc(R);
    Delete(S, 1, R - 1);
  end;
end;

{ TdxCharValidator }

constructor TdxCharValidator.Create(const AChars: WideString; AValid: Boolean);
begin
  inherited Create;
  FAnyChar := False;
  FChars := AChars;
  FValid := AValid;
end;

constructor TdxCharValidator.CreateAnyChar;
begin
  inherited Create;
  FAnyChar := True;
end;

function TdxCharValidator.IsValidChar(AChar: WideChar): Boolean;
begin
  Result := FAnyChar or ((WideCharPos(AChar, FChars) < 1) xor FValid);
end;

{ TdxRuleValidator }

procedure TdxRuleValidator.AddAnyCharValid;
begin
  inherited Add(TdxCharValidator.CreateAnyChar);
end;

procedure TdxRuleValidator.AddCharInfo(const AChars: WideString;
  AValid: Boolean);
begin
  if Length(AChars) > 0 then
    inherited Add(TdxCharValidator.Create(AChars, AValid));
end;

function TdxRuleValidator.IsValid(const AWord: WideString;
  AFromStart: Boolean): Boolean;
var
  I, AStart, ALen: Integer;
begin
  Result := False;
  ALen := Length(AWord);
  if ALen < Count then Exit;
  if AFromStart then
    AStart := 1
  else
    AStart := ALen - Count + 1;
  for I := 0 to Count - 1 do
  begin
    if not Items[I].IsValidChar(AWord[AStart]) then
      Exit;
    Inc(AStart);
  end;
  Result := True;
end;

function TdxRuleValidator.GetItem(Index: Integer): TdxCharValidator;
begin
  Result := TdxCharValidator(List^[Index]);
end;

{ TdxAffixRule }

constructor TdxAffixRule.Create(AAffix: TdxCustomAffixElement);
begin
  inherited Create;
  FAffix := AAffix;
  FValidator := TdxRuleValidator.Create;
end;

destructor TdxAffixRule.Destroy;
begin
  FValidator.Free;
  inherited Destroy;
end;

function TdxAffixRule.CanApply(const AWord: WideString): Boolean;
begin
  Result := FForceValid or FValidator.IsValid(AWord, IsPrefix);
end;

function TdxAffixRule.GetWordform(const AWord, ACheckStripWord: WideString): WideString;
var
  ALen: Integer;
begin
  Result := AWord;
  ALen := Length(StripString);
  if ALen > 0 then
  begin
    if IsPrefix then
    begin
      if WideStartsWith(StripString, ACheckStripWord) then
        Delete(Result, 1, ALen);
    end
    else
    begin
      if WideEndsWith(StripString, ACheckStripWord) then
        Delete(Result, Length(Result) - ALen + 1, ALen);
    end;
  end;
  if Length(AppendString) > 0 then
  begin
    if IsPrefix then
      Result := AppendString + Result
    else
      Result := Result + AppendString;
  end;
end;

function TdxAffixRule.Parse(const ARule: WideString): Boolean;
begin
  Result := DoParse(RemoveComments(ARule));
end;

function TdxAffixRule.GetIsPrefix: Boolean;
begin
  Result := FAffix.IsPrefix;
end;

{ TdxAffixRuleList }

procedure TdxAffixRuleList.AddWordforms(const AWord: WideString;
  ADictionary: TdxSpellCheckerStrings; ALangID: Cardinal);
var
  I, ALen: Integer;
  ARule: TdxAffixRule;
  ALower: WideString;
begin
  ALen := Length(AWord);
  SetLength(ALower, ALen);
  LCMapStringW(ALangID, LCMAP_LOWERCASE, Pointer(AWord), ALen, Pointer(ALower), ALen);
  for I := 0 to Count - 1 do
  begin
    ARule := Items[I];
    if ARule.CanApply(ALower) then
      ADictionary.Add(ARule.GetWordform(AWord, ALower));
  end;
end;

function TdxAffixRuleList.GetItem(Index: Integer): TdxAffixRule;
begin
  Result := TdxAffixRule(List^[Index]);
end;

{ TdxCustomAffixElement }

constructor TdxCustomAffixElement.Create(AKey: WideChar; ACanCombine: Boolean;
  ALangID: Cardinal);
begin
  inherited Create;
  FCanCombine := ACanCombine;
  FKey := AKey;
  FLangID := ALangID;
  FRules := TdxAffixRuleList.Create;
end;

destructor TdxCustomAffixElement.Destroy;
begin
  FRules.Free;
  inherited Destroy;
end;

procedure TdxCustomAffixElement.AddRule(ARuleDefinition: WideString);
var
  ARule: TdxAffixRule;
begin
  ARule := CreateRule;
  LCMapStringW(LangID, LCMAP_LOWERCASE, @(ARuleDefinition[1]),
    Length(ARuleDefinition), @(ARuleDefinition[1]), Length(ARuleDefinition));
  if ARule.Parse(ARuleDefinition) then
    Rules.Add(ARule)
  else
    ARule.Free;
end;

procedure TdxCustomAffixElement.AddWordforms(const AWord: WideString;
  ADictionary: TdxSpellCheckerStrings);
begin
  Rules.AddWordforms(AWord, ADictionary, LangID);
end;

{ TdxAffixList }

function TdxAffixList.FindForKey(AKey: WideChar; AIsPrefix: Boolean): TdxCustomAffixElement;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I];
    if (Result.Key = AKey) and (Result.IsPrefix = AIsPrefix) then
      Exit;
  end;
  Result := nil;
end;

function TdxAffixList.GetItem(Index: Integer): TdxCustomAffixElement;
begin
  Result := TdxCustomAffixElement(List^[Index]);
end;

{ TdxISpellAffixRule }

procedure TdxISpellAffixRule.BuildValidator(const S: WideString);
var
  AChar: WideChar;
  AChars: WideString;
  I: Integer;
  AValid: Boolean;

  procedure AddValidatorRule;
  begin
    if AChars <> '' then
    begin
      Validator.AddCharInfo(AChars, AValid);
      AChars := '';
    end;
    AValid := True;
  end;

begin
  AValid := True;
  for I := 1 to Length(S) do
  begin
    AChar := S[I];
    case AChar of
      #$09, ' ', '[', ']': AddValidatorRule;
      '^': AValid := False;
    else
      AChars := AChars + AChar;
    end;
  end;
  AddValidatorRule;
end;

procedure TdxISpellAffixRule.ParseNewWordform(const S: WideString);
type
  TdxStateWordform = (swNone, swStrip, swAppend);
var
  I: Integer;
  AChar: WideChar;
  AState: TdxStateWordform;
begin
  AState := swNone;
  for I := 1 to Length(S) do
  begin
    AChar := S[I];
    case AChar of
      #$0000..' ': Continue;
      ',': AState := swNone;
      '-': AState := swStrip;
    else
      case AState of
        swStrip: StripString := StripString + AChar;
        swNone:
          begin
            AState := swAppend;
            AppendString := AppendString + AChar;
          end;
        else
          AppendString := AppendString + AChar;
      end;
    end;
  end;
end;

function TdxISpellAffixRule.RemoveComments(const ARule: WideString): WideString;
begin
  Result := RemoveGrammarComments(ARule);
end;

function TdxISpellAffixRule.DoParse(const ARule: WideString): Boolean;
var
  S: WideString;
  APos: Integer;
begin
  Result := False;
  APos := WideCharPos('>', ARule);
  if APos < 1 then Exit;
  S := Trim(Copy(ARule, 1, APos - 1));
  ForceValid := S = '.';
  if not ForceValid then
    BuildValidator(S);
  S := Trim(Copy(ARule, APos + 1, Length(ARule)));
  if Length(S) > 0 then
  begin
    ParseNewWordform(S);
    Result := (ForceValid or (Validator.Count > 0)) and
      ((Length(StripString) > 0) or (Length(AppendString) > 0))
  end;
end;

{ TdxISpellPrefix }

function TdxISpellPrefix.CreateRule: TdxAffixRule;
begin
  Result := TdxISpellAffixRule.Create(Self);
end;

function TdxISpellPrefix.GetIsPrefix: Boolean;
begin
  Result := True;
end;

{ TdxISpellSuffix }

function TdxISpellSuffix.GetIsPrefix: Boolean;
begin
  Result := False;
end;

{ TdxCustomAffixDecompressor }

constructor TdxCustomAffixDecompressor.Create(
  ADictionary: TdxAffixCompressionDictionary);
begin
  inherited Create;
  FDictionary := ADictionary;
  FCodePage := CP_ACP;
  FAffixes := TdxAffixList.Create;
  FPrefixes := TList.Create;
  FSuffixes := TList.Create;
  FWordforms := TdxSpellCheckerStrings.Create;
end;

destructor TdxCustomAffixDecompressor.Destroy;
begin
  FWordforms.Free;
  FPrefixes.Free;
  FSuffixes.Free;
  FAffixes.Free;
  inherited Destroy;
end;

procedure TdxCustomAffixDecompressor.CreateWordforms(
  const AWordDefinition: WideString);
var
  AWord, AKeys: WideString;
begin
  ExtractWordInfo(RemoveComments(AWordDefinition), AWord, AKeys);
  if AWord <> '' then
  begin
    Reset;
    Wordforms.Add(AWord);
    CreateWordFormsForKeys(AWord, AKeys);
  end;
end;

procedure TdxCustomAffixDecompressor.CreateWordFormsForKeys(const AWord,
  AKeys: WideString);
var
  AAffix: TdxCustomAffixElement;
  I, J, K, AStartIndex: Integer;
begin
  if AKeys = '' then Exit;
  for I := 1 to Length(AKeys) do
  begin
    for J := 0 to Affixes.Count - 1 do
    begin
      AAffix := Affixes[J];
      if AAffix.Key = AKeys[I] then
      begin
        if AAffix.IsPrefix then
          Prefixes.Add(AAffix)
        else
          Suffixes.Add(AAffix);
      end;
    end;
  end;
  for I := 0 to Prefixes.Count - 1 do
  begin
    AAffix := TdxCustomAffixElement(Prefixes[I]);
    AStartIndex := Wordforms.Count;
    AAffix.AddWordforms(AWord, Wordforms);
    if AAffix.CanCombine then
      for J := AStartIndex to Wordforms.Count - 1 do
        for K := 0 to Suffixes.Count - 1 do
        begin
          AAffix := TdxCustomAffixElement(Suffixes[K]);
          if AAffix.CanCombine then
            AAffix.AddWordforms(Wordforms[J], Wordforms);
        end;
  end;
  for I := 0 to Suffixes.Count - 1 do
    TdxCustomAffixElement(Suffixes[I]).AddWordforms(AWord, Wordforms);
end;

procedure TdxCustomAffixDecompressor.ExtractWordInfo(
  const AWordDefinition: WideString; out AWord, AKeys: WideString);
var
  APos: Integer;
begin
  AWord := '';
  AKeys := '';
  APos := WideCharPos('/', AWordDefinition);
  if APos > 0 then
  begin
    AWord := Copy(AWordDefinition, 1, APos - 1);
    AKeys := Copy(AWordDefinition, APos + 1, Length(AWordDefinition));
  end
  else
    AWord := AWordDefinition;
end;

procedure TdxCustomAffixDecompressor.InitParsing;
begin
end;

procedure TdxCustomAffixDecompressor.LoadFromFile(const AFileName: TFileName);
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

procedure TdxCustomAffixDecompressor.LoadFromStream(AStream: TStream);
var
  AStrings: TdxSpellCheckerStrings;
begin
  GetLanguageInfo(AStream, FCodePage, FAlphabet);
  Wordforms.CodePage := CodePage;
  AStrings := TdxSpellCheckerStrings.Create(CodePage);
  try
    AStream.Position := 0;
    AStrings.Capacity := 16384;
    AStrings.LoadFromStream(AStream);
    Parse(AStrings);
  finally
    AStrings.Free;
  end;
end;

procedure TdxCustomAffixDecompressor.Parse(AStrings: TdxSpellCheckerStrings);
var
  I: Integer;
  S: WideString;
begin
  for I := 0 to AStrings.Count - 1 do
  begin
    S := RemoveComments(AStrings[I]);
    if S <> '' then
      ParseLine(S);
  end;
end;

procedure TdxCustomAffixDecompressor.PopulateWordForms(
  const AWordDefinition: WideString; ADictionary: TdxSpellCheckerWordList);
var
  I: Integer;
begin
  CreateWordforms(AWordDefinition);
  for I := 0 to Wordforms.Count - 1 do
  begin
    if Dictionary.LoadingTerminated then
      Break;
    ADictionary.Add(Wordforms[I]);
  end;
end;


function TdxCustomAffixDecompressor.RemoveComments(
  const S: WideString): WideString;
begin
  Result := RemoveGrammarComments(S);
end;

procedure TdxCustomAffixDecompressor.Reset;
begin
  Prefixes.Clear;
  Suffixes.Clear;
  Wordforms.Clear;
end;

{ TdxAffixCompressionDictionary }

procedure TdxAffixCompressionDictionary.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TdxAffixCompressionDictionary then
  begin
    DictionaryPath := TdxAffixCompressionDictionary(Source).DictionaryPath;
    GrammarPath := TdxAffixCompressionDictionary(Source).GrammarPath;
  end;
end;

function TdxAffixCompressionDictionary.DoLoad: Boolean;
var
  ADecompressor: TdxCustomAffixDecompressor;
  AWordBase: TdxSpellCheckerStrings;
  I: Integer;
begin
  Result := True;
  ADecompressor := CreateDecompressor;
  try
    LoadGrammar(ADecompressor);
    AWordBase := TdxSpellCheckerStrings.Create(ADecompressor.CodePage);
    try
      LoadWordBase(AWordBase);
      for I := 0 to AWordBase.Count - 1 do
        if LoadingTerminated then
          Abort
        else
          ADecompressor.PopulateWordForms(AWordBase[I], Words);
    finally
      AWordBase.Free;
    end;
  finally
    ADecompressor.Free;
  end;
end;

function TdxAffixCompressionDictionary.GetDisplayName: string;
var
  AFileName: TFileName;
begin
  Result := inherited GetDisplayName;
  AFileName := SysUtils.ExtractFileName(DictionaryPath);
  if AFileName <> '' then
    Result := Format('%s (%s)', [Result, AFileName]);
end;

procedure TdxAffixCompressionDictionary.LoadGrammar(
  ADecompressor: TdxCustomAffixDecompressor);
begin
  ADecompressor.LoadFromFile(GrammarPath);
  if not LoadingTerminated then
    UpdateByDecompressor(ADecompressor);
end;

procedure TdxAffixCompressionDictionary.LoadWordBase(
  AWordBase: TdxSpellCheckerStrings);
begin
  AWordBase.LoadFromFile(DictionaryPath);
end;

procedure TdxAffixCompressionDictionary.UpdateByDecompressor(
  ADecompressor: TdxCustomAffixDecompressor);
begin
end;

procedure TdxAffixCompressionDictionary.SetDictionaryPath(
  const AValue: TFileName);
begin
  if FDictionaryPath <> AValue then
  begin
    Unload;
    FDictionaryPath := AValue;
  end;
end;

procedure TdxAffixCompressionDictionary.SetGrammarPath(const AValue: TFileName);
begin
  if FGrammarPath <> AValue then
  begin
    Unload;
    FGrammarPath := AValue;
  end;
end;

{ TdxISpellDecompressor }

function TdxISpellDecompressor.CreateAffix(AKey: WideChar; ACanCombine: Boolean;
  AState: TdxAffixElementState): TdxCustomAffixElement;
begin
  case AState of
    aesPrefix: Result := TdxISpellPrefix.Create(AKey, ACanCombine, Dictionary.Language);
    aesSuffix: Result := TdxISpellSuffix.Create(AKey, ACanCombine, Dictionary.Language);
  else
    Result := nil;
  end;
  if Result <> nil then
    Affixes.Add(Result);
end;

procedure TdxISpellDecompressor.ExtractKeyInfo(const ADefinition: WideString;
  out AKey: WideChar; out ACanCombine: Boolean);
var
  I: Integer;
begin
  ACanCombine := False;
  AKey := #$0000;
  for I := 1 to Length(ADefinition) do
    case ADefinition[I] of
      #$0000..' ': Continue;
      ':': Break;
      '*': ACanCombine := True;
    else
      AKey := ADefinition[I];
    end;
end;

procedure TdxISpellDecompressor.GetLanguageInfo(AStream: TStream;
  out ACodePage: Cardinal; out AAlphabet: WideString);
begin
  ACodePage := Dictionary.CodePage;
  if ACodePage = CP_ACP then
    ACodePage := GetACP;
  AAlphabet := CreateDefaultAlphabet(ACodePage);
end;

procedure TdxISpellDecompressor.InitParsing;
begin
  FCurrentState := aesNone;
  FCurrentAffix := nil;
end;

function TdxISpellDecompressor.IsUnsupportedKeyWord(const S: WideString): Boolean;
const
  UnsupportedKeyWords: array[0..6] of WideString = (
    'allaffixes', 'altstringtype', 'altstringchar', 'boundarychars',
    'defstringtype', 'stringchar', 'wordchars');
var
  I: Integer;
begin
  Result := False;
  for I := Low(UnsupportedKeyWords) to High(UnsupportedKeyWords) do
    if WideSameText(UnsupportedKeyWords[I], S) then
    begin
      Result := True;
      Break;
    end;
end;

procedure TdxISpellDecompressor.ParseLine(S: WideString);
var
  W: WideString;
  AAffix: TdxCustomAffixElement;
  AKey: WideChar;
  ACanCombine: Boolean;
begin
  W := GetFirstWord(S);
  if IsUnsupportedKeyWord(W) then
    InitParsing
  else if WideSameText('prefixes', W) then
  begin
    FCurrentState := aesPrefix;
    FCurrentAffix := nil;
  end
  else if WideSameText('suffixes', W) then
  begin
    FCurrentState := aesSuffix;
    FCurrentAffix := nil;
  end
  else if WideSameText('flag', W) then
  begin
    ExtractKeyInfo(Trim(Copy(S, 5, Length(S))), AKey, ACanCombine);
    AAffix := Affixes.FindForKey(AKey, FCurrentState = aesPrefix);
    if AAffix = nil then
      FCurrentAffix := CreateAffix(AKey, ACanCombine, FCurrentState)
    else
      FCurrentAffix := AAffix;
  end
  else if FCurrentAffix <> nil then
    FCurrentAffix.AddRule(S);
end;

{ TdxISpellDictionary }

function TdxISpellDictionary.CreateDecompressor: TdxCustomAffixDecompressor;
begin
  Result := TdxISpellDecompressor.Create(Self);
end;

{ TdxHunspellAffixRule }

procedure TdxHunspellAffixRule.BuildValidator(const S: WideString);
var
  AChar: WideChar;
  AChars: WideString;
  I: Integer;
  AValid, AInSet: Boolean;

  procedure AddValidatorRule;
  begin
    if AChars <> '' then
    begin
      Validator.AddCharInfo(AChars, AValid);
      AChars := '';
    end;
    AValid := True;
  end;

begin
  AValid := True;
  AInSet := False;
  for I := 1 to Length(S) do
  begin
    AChar := S[I];
    case AChar of
      '[':
         AInSet := True;
      ']':
         begin
           AInSet := False;
           AddValidatorRule;
         end;
      '^':
         AValid := False;
      '.':
         Validator.AddAnyCharValid;
    else
      if AInSet then
        AChars := AChars + AChar
      else
      begin
        AChars := AChar;
        AddValidatorRule;
      end;
    end;
  end;
end;

function TdxHunspellAffixRule.DoParse(const ARule: WideString): Boolean;
var
  W, S: WideString;
begin
  S := ARule;
  W := GetFirstWord(S, True);
  if W = '0' then
    StripString := ''
  else
    StripString := W;
  AppendString := GetFirstWord(S, True);
  S := GetFirstWord(S, True);
  ForceValid := S = '.';
  if not ForceValid then
    BuildValidator(S);
  Result := (ForceValid or (Validator.Count > 0)) and
    ((Length(StripString) > 0) or (Length(AppendString) > 0));
end;

{ TdxHunspellPrefix }

function TdxHunspellPrefix.CreateRule: TdxAffixRule;
begin
   Result := TdxHunspellAffixRule.Create(Self);
end;

function TdxHunspellPrefix.GetIsPrefix: Boolean;
begin
  Result := True;
end;

{ TdxHunspellSuffix }

function TdxHunspellSuffix.GetIsPrefix: Boolean;
begin
  Result := False;
end;

{ TdxHunspellDecompressor }

function TdxHunspellDecompressor.CreateAffix(AKey: WideChar;
  ACanCombine: Boolean; AState: TdxAffixElementState): TdxCustomAffixElement;
begin
  case AState of
    aesPrefix: Result := TdxHunspellPrefix.Create(AKey, ACanCombine, Dictionary.Language);
    aesSuffix: Result := TdxHunspellSuffix.Create(AKey, ACanCombine, Dictionary.Language);
  else
    Result := nil;
  end;
  if Result <> nil then
    Affixes.Add(Result);
end;

procedure TdxHunspellDecompressor.GetLanguageInfo(AStream: TStream;
  out ACodePage: Cardinal; out AAlphabet: WideString);
var
  S, AWord, AnsiAlphabet: AnsiString;
  L: TStrings;
  I, J: Integer;
begin
  AnsiAlphabet := '';
  ACodePage := CP_ACP;
  L := TStringList.Create;
  try
    L.LoadFromStream(AStream);
    for I := 0 to L.Count - 1 do
    begin
      if (ACodePage <> CP_ACP) and (AnsiAlphabet <> '') then Break;
      S := RemoveGrammarComments(dxStringToAnsiString(L[I]));
      if S = '' then Continue;
      AWord := GetFirstWord(S, True);
      if AnsiSameText(AWord, AnsiString('try')) then
        AnsiAlphabet := Trim(GetFirstWord(S))
      else if AnsiSameText(AWord, AnsiString('set')) then
      begin
        S := Trim(GetFirstWord(S));
        for J := Low(TdxHunspellCodePages) to High(TdxHunspellCodePages) do
          if AnsiSameText(TdxHunspellCodePages[J].Name, S) then
          begin
            ACodePage := TdxHunspellCodePages[J].CodePage;
            Break;
          end;
      end;
    end;
  finally
    L.Free;
  end;
  if ACodePage = CP_ACP then
    ACodePage := GetACP;
  if AnsiAlphabet <> '' then
    AAlphabet := CreateAlphabetFromAnsiString(ACodePage, AnsiAlphabet)
  else
    AAlphabet := CreateDefaultAlphabet(ACodePage);
end;

procedure TdxHunspellDecompressor.InitParsing;
begin
  FCurrentKey := #00;
  FRepCount := 0;
end;

procedure TdxHunspellDecompressor.ParseLine(S: WideString);
var
  W: WideString;
begin
  W := GetFirstWord(S, True);
  if WideSameText('PFX', W) then
    ProcessAffix(S, aesPrefix)
  else if WideSameText('SFX', W) then
    ProcessAffix(S, aesSuffix)
  else if WideSameText('REP', W) then
    ProcessSubstitution(S)
  else if WideSameText('TRY', W) then
    ProcessAlphabet(S);
end;

procedure TdxHunspellDecompressor.ProcessAlphabet(S: WideString);
begin
  Dictionary.Alphabet := S;
end;

procedure TdxHunspellDecompressor.ProcessAffix(S: WideString;
  AState: TdxAffixElementState);
var
  W: WideString;
  AAffix: TdxCustomAffixElement;
begin
  W := GetFirstWord(S, True);
  if Length(W) <> 1 then Exit;
  if W <> FCurrentKey then
  begin
    FCurrentKey := W[1];
    W := GetFirstWord(S, True);
    FCurrentKeyCanCombine := WideSameText(W, 'Y');
    W := GetFirstWord(S, True);
  end
  else
  begin
    AAffix := Affixes.FindForKey(FCurrentKey, AState = aesPrefix);
    if AAffix = nil then
      AAffix := CreateAffix(FCurrentKey, FCurrentKeyCanCombine, AState);
    AAffix.AddRule(S);
  end;
end;

procedure TdxHunspellDecompressor.ProcessSubstitution(S: WideString);
var
  W: WideString;
begin
  if FRepCount = 0 then
    FRepCount := StrToIntDef(GetFirstWord(S), 0)
  else
  begin
    S := WideLowerCase(S);
    W := GetFirstWord(S, True);
    Dictionary.Substitutions.Add(W, GetFirstWord(S));
    Dec(FRepCount);
  end;
end;

function TdxHunspellDecompressor.GetDictionary: TdxOpenOfficeDictionary;
begin
  Result := TdxOpenOfficeDictionary(inherited Dictionary);
end;

{ TdxOpenOfficeSuggestionBuilder }

procedure TdxOpenOfficeSuggestionBuilder.DoAddSuggestions;
begin
  ProcessSubstitutions;
  inherited DoAddSuggestions;
end;

function TdxOpenOfficeSuggestionBuilder.FindPos(const ASubStr, AStr: WideString;
  var AStartPos: Integer): Boolean;
var
  I, J, AMaxIndex, ASubStrLen, AStrLen: Integer;
begin
  Result := False;
  if AStartPos <= 0 then Exit;
  AStrLen := Length(AStr);
  if (AStrLen = 0) or (AStartPos > AStrLen) then Exit;
  ASubStrLen := Length(ASubStr);
  AMaxIndex := AStrLen - ASubStrLen + 1;
  if (ASubStrLen = 0) or (AStartPos > AMaxIndex) then Exit;
  repeat
    while (AStartPos <= AMaxIndex) and (ASubStr[1] <> AStr[AStartPos]) do
      Inc(AStartPos);
    if AStartPos > AMaxIndex then Exit;
    J := AStartPos + 1;
    Result := True;
    for I := 2 to ASubStrLen do
    begin
      if ASubStr[I] <> AStr[J] then
      begin
        Result := False;
        Inc(AStartPos);
        Break;
      end;
      Inc(J);
    end;
  until Result;
end;

procedure TdxOpenOfficeSuggestionBuilder.ProcessSubstitutions;
var
  ASubstitutions: TdxSpellCheckerReplacementList;
  ATestWord, T, R: WideString;
  I, APos: Integer;
begin
  ASubstitutions := Dictionary.Substitutions;
  for I := 0 to ASubstitutions.Count - 1 do
  begin
    APos := 1;
    R := ASubstitutions[I].Replacement;
    T := ASubstitutions[I].Text;
    while FindPos(T, Word, APos) do
    begin
      ATestWord := Word;
      Delete(ATestWord, APos, Length(T));
      Insert(R, ATestWord, APos);
      if Dictionary.HasWord(ATestWord) then
        Suggestions.Add(ATestWord, Dictionary, 1);
      Inc(APos);
    end;
  end;
end;

function TdxOpenOfficeSuggestionBuilder.GetDictionary: TdxOpenOfficeDictionary;
begin
  Result := TdxOpenOfficeDictionary(inherited Dictionary);
end;

{ TdxOpenOfficeDictionary }

constructor TdxOpenOfficeDictionary.Create(
  ASpellChecker: TdxCustomSpellChecker);
begin
  inherited Create(ASpellChecker);
  FSubstitutions := TdxSpellCheckerReplacementList.Create(True);
end;

destructor TdxOpenOfficeDictionary.Destroy;
begin
  FSubstitutions.Free;
  inherited Destroy;
end;

function TdxOpenOfficeDictionary.CreateDecompressor: TdxCustomAffixDecompressor;
begin
  Result := TdxHunspellDecompressor.Create(Self);
end;

function TdxOpenOfficeDictionary.CreateSuggestionBuilder: TdxSpellCheckerSuggestionBuilder;
begin
  Result := TdxOpenOfficeSuggestionBuilder.Create(Self);
end;

procedure TdxOpenOfficeDictionary.UpdateByDecompressor(
  ADecompressor: TdxCustomAffixDecompressor);
begin
  CodePage := ADecompressor.CodePage;
  Substitutions.SortByText;
end;

initialization
  GetRegisteredDictionaryTypes.Register(TdxISpellDictionary, cxGetResourceString(@sdxSpellCheckerISpellDictionary));
  GetRegisteredDictionaryTypes.Register(TdxOpenOfficeDictionary, cxGetResourceString(@sdxSpellCheckerOpenOfficeDictionary));

end.
