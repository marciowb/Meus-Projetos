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

unit dxSpellCheckerAutoCorrect;

{$I cxVer.inc}

interface

uses
  Types, Windows, SysUtils, Messages, Classes, Graphics, Controls, StdCtrls,
  dxMessages, cxClasses, cxControls, cxLookAndFeels, dxSpellChecker;

type
  TdxSpellCheckerAutoCorrectManager = class;

  { TdxSpellCheckerCorrectSentenceCapsRule }

  TdxSpellCheckerCorrectSentenceCapsRule = class(TdxSpellCheckerAutoCorrectCustomRule)
  private
    FPrevWord: WideString;
    FSentenceDelimiters: WideString;
  protected
    function GetActive: Boolean; override;
    procedure InitializeDelimiters; override;
    function IsSentenceDelimiter(ACh: WideChar): Boolean;
  public
    function IsCheckWord(const AText: WideString; var AStart, ALength: Integer;
      var AWord: WideString): Boolean; override;
    procedure Undo; override;

    property SentenceDelimiters: WideString read FSentenceDelimiters;
  end;

  { TdxSpellCheckerCorrectCapsLockRule }

  TdxSpellCheckerCorrectCapsLockRule = class(TdxSpellCheckerAutoCorrectCustomRule)
  protected
    function GetActive: Boolean; override;
    procedure InitializeDelimiters; override;
  public
    procedure AfterCorrect; override;
    function IsCheckWord(const AText: WideString; var AStart, ALength: Integer;
      var AWord: WideString): Boolean; override;
  end;

  { TdxSpellCheckerCorrectInitialCapsRule }

  TdxSpellCheckerCorrectInitialCapsRule = class(TdxSpellCheckerAutoCorrectCustomRule)
  private
    FWord: WideString;
  protected
    function GetActive: Boolean; override;
    procedure InitializeDelimiters; override;
  public
    function IsCheckWord(const AText: WideString; var AStart, ALength: Integer;
      var AWord: WideString): Boolean; override;
    procedure Undo; override;
  end;

  { TdxSpellCheckerCorrectReplaceTextAsYouTypeRule }

  TdxSpellCheckerCorrectReplaceTextAsYouTypeRule = class(TdxSpellCheckerAutoCorrectCustomRule)
  protected
    function GetActive: Boolean; override;
    procedure InitializeDelimiters; override;
  public
    function IsCheckWord(const AText: WideString; var AStart, ALength: Integer;
      var AWord: WideString): Boolean; override;
    function IsTerminating: Boolean; override;
  end;

  { TdxSpellCheckerAutoCorrectManager }

  TdxSpellCheckerAutoCorrectManager = class(TdxSpellCheckerCustomAutoCorrectManager)
  private
    FPrevWord: WideString;
    FRules: TcxObjectList;
    FLastApplyRule: TdxSpellCheckerAutoCorrectCustomRule;
  protected
    procedure ApplyChanges(AWordRange: TdxSpellCheckerAutoCorrectWordRange);
    procedure DoActiveChanged; override;
    procedure DoOptionsChanged; override;
    function GetAutoCorrectWordRange: TdxSpellCheckerAutoCorrectWordRange;
    procedure InitializeRules; virtual;
    function IsConsistentWithRule(ARule: TdxSpellCheckerAutoCorrectCustomRule; AKey: Char;
      var AWordRange: TdxSpellCheckerAutoCorrectWordRange): Boolean; virtual;
    procedure Undo; override;
  public
    constructor Create(ASpellChecker: TdxCustomSpellChecker); override;
    destructor Destroy; override;

    procedure KeyPress(AKey: Char); override;
  end;

implementation

uses
  dxSpellCheckerUtils, cxTextEdit;

const
  dxVK_UNDO = 26;
  
var
  dxSpellCheckerAutoCorrectWord: TdxSpellCheckerAutoCorrectWordRange;

{ TdxSpellCheckerCorrectSentenceCapsRule }

function TdxSpellCheckerCorrectSentenceCapsRule.IsCheckWord(const AText: WideString;
  var AStart, ALength: Integer; var AWord: WideString): Boolean;

  function IsFirstWordOfSentence: Boolean;
  var
    I: Integer;
  begin
    I := AStart;
    while (I > 0) and (AText[I] = ' ') do
      Dec(I);
    Result := (I = 0);
    if not Result then
    begin
      Result := IsSentenceDelimiter(AText[I]);
      if AText[I] = '.' then
      begin
        FPrevWord := '.';
        Dec(I);
        while (I > 0) and not WideIsSpace(AText[I]) do
        begin
          FPrevWord := AText[I] + FPrevWord;
          Dec(I);
        end;
        Result := Options.FirstLetterExceptions.Find(FPrevWord) = -1;
      end;
    end;
  end;

var
  I: Integer;
begin
  Result := (LastKey <> '.') or (Options.FirstLetterExceptions.Find(AWord + '.') = -1);
  FPrevWord := '';
  Result := Result and IsFirstWordOfSentence;
  if Result then
  begin
    for I := 1 to Length(AWord) do
    begin
      Result := WideIsLoCase(AWord[I]);
      if not Result then
        Break;
    end;
    if Result then
      AWord := WideCapitalizeCase(AWord);
  end;
end;

procedure TdxSpellCheckerCorrectSentenceCapsRule.Undo;
begin
  if Options.FirstLetterExceptions.AutoInclude then
    Options.FirstLetterExceptions.Add(FPrevWord);
end;

function TdxSpellCheckerCorrectSentenceCapsRule.GetActive: Boolean;
begin
  Result := Options.CorrectSentenceCaps;
end;

procedure TdxSpellCheckerCorrectSentenceCapsRule.InitializeDelimiters;
begin
  SetWordDelimiters(#9#13#32'.,<>=!?:;''"()[]{}+|-/\+0123456789');
  FSentenceDelimiters := #13#10'.';
end;

function TdxSpellCheckerCorrectSentenceCapsRule.IsSentenceDelimiter(ACh: WideChar): Boolean;
begin
  Result := WideCharPos(ACh, SentenceDelimiters) > 0;
end;

{ TdxSpellCheckerCorrectCapsLockRule }

procedure TdxSpellCheckerCorrectCapsLockRule.AfterCorrect;
begin
  if Options.DisableCapsLock and (GetKeyState(VK_CAPITAL) = 1) then
  begin
    keybd_event(VK_CAPITAL, 0, KEYEVENTF_EXTENDEDKEY, 0);
    keybd_event(VK_CAPITAL, 0, KEYEVENTF_KEYUP, 0);
  end;
end;

function TdxSpellCheckerCorrectCapsLockRule.IsCheckWord(const AText: WideString;
  var AStart, ALength: Integer; var AWord: WideString): Boolean;
var
  ALen, I: Integer;
begin
  ALen := Length(AWord);
  Result := Active and (ALen > 1) and (GetKeyState(VK_CAPITAL) = 1);
  if Result then
  begin
    for I := 1 to ALen do
    begin
      if I = 1 then
        Result := WideIsLoCase(AWord[I])
      else
        Result := WideIsUpCase(AWord[I]);
      if not Result then
        Break;
    end;
    if Result then
      AWord := WideCapitalizeCase(AWord);
  end;
end;

function TdxSpellCheckerCorrectCapsLockRule.GetActive: Boolean;
begin
  Result := Options.CorrectCapsLock;
end;

procedure TdxSpellCheckerCorrectCapsLockRule.InitializeDelimiters;
begin
  SetWordDelimiters(#9#13#32'.,<>=!?:;''"()[]{}+|-/\+0123456789');
end;

{ TdxSpellCheckerCorrectInitialCapsRule }

function TdxSpellCheckerCorrectInitialCapsRule.IsCheckWord(const AText: WideString;
  var AStart, ALength: Integer; var AWord: WideString): Boolean;
var
  I, ALen: Integer;
begin
  FWord := AWord;
  ALen := Length(AWord);
  Result := Active and (ALen > 2);
  if Result then
  begin
    for I := 1 to ALen do
    begin
      if I < 3 then
        Result := WideIsUpCase(AWord[I])
      else
        Result := WideIsLoCase(AWord[I]);
      if not Result then
        Break;
    end;
    Result := Result and (Options.InitialCapsExceptions.Find(AWord) = -1);
    if Result then
      AWord := WideCapitalizeCase(AWord);
  end;
end;

procedure TdxSpellCheckerCorrectInitialCapsRule.Undo;
begin
  if Options.InitialCapsExceptions.AutoInclude then
    Options.InitialCapsExceptions.Add(FWord);
end;

function TdxSpellCheckerCorrectInitialCapsRule.GetActive: Boolean;
begin
  Result := Options.CorrectInitialCaps;
end;

procedure TdxSpellCheckerCorrectInitialCapsRule.InitializeDelimiters;
begin
  SetWordDelimiters(#9#13#32'.,<>=!?:;''"()[]{}+|-/\+0123456789');
end;

{ TdxSpellCheckerCorrectReplaceTextAsYouTypeRule }

function TdxSpellCheckerCorrectReplaceTextAsYouTypeRule.IsCheckWord(const
  AText: WideString; var AStart, ALength: Integer; var AWord: WideString): Boolean;
var
  AReplacement: WideString;
begin
  Result := Options.GetReplacement(AWord, AReplacement);
  if Result then
  begin
    if GetWordCapitalizationType(AReplacement) in [ctCapitalized, ctUpper, ctLower] then
      AWord := WidePatternCase(AWord, AReplacement)
    else
      AWord := AReplacement;
  end
  else
    if not WideIsAlphaNumeric(LastKey) and Options.GetReplacement(AWord + LastKey, AReplacement) then
    begin
      AWord := WidePatternCase(AWord, AReplacement);
      ALength := ALength + Length(LastKey);
      Result := True;
    end;
end;

function TdxSpellCheckerCorrectReplaceTextAsYouTypeRule.IsTerminating: Boolean;
begin
  Result := False;
end;

function TdxSpellCheckerCorrectReplaceTextAsYouTypeRule.GetActive: Boolean;
begin
  Result := Options.ReplaceTextAsYouType;
end;

procedure TdxSpellCheckerCorrectReplaceTextAsYouTypeRule.InitializeDelimiters;
begin
  SetWordDelimiters(#9#13' .,<>=!?:;''"()[]{}+|-/\+');
end;

{ TdxSpellCheckerAutoCorrectManager }

constructor TdxSpellCheckerAutoCorrectManager.Create(ASpellChecker: TdxCustomSpellChecker);
begin
  inherited Create(ASpellChecker);
  FRules := TcxObjectList.Create;
  InitializeRules;
end;

destructor TdxSpellCheckerAutoCorrectManager.Destroy;
begin
  FreeAndNil(FRules);
  inherited;
end;

procedure TdxSpellCheckerAutoCorrectManager.KeyPress(AKey: Char);
var
  I: Integer;
  AWordRange: TdxSpellCheckerAutoCorrectWordRange;
  AApply, AConsistent: Boolean;
begin
  inherited KeyPress(AKey);
  if not Active or (Adapter = nil) then
    Exit;
  AWordRange := GetAutoCorrectWordRange;
  if Ord(AKey) <> dxVK_UNDO then
  begin
    FPrevWord := AWordRange.Replacement;
    FLastApplyRule := nil;
  end
  else
  begin
    Undo;
    Exit;
  end;
  AApply := False;
  for I := 0 to FRules.Count - 1 do
  begin
    AConsistent := IsConsistentWithRule(TdxSpellCheckerAutoCorrectCustomRule(FRules[I]), AKey, AWordRange);
    AApply := AApply or AConsistent;
    if AConsistent and TdxSpellCheckerAutoCorrectCustomRule(FRules[I]).IsTerminating then
      Break;
  end;
  if AApply then
    ApplyChanges(AWordRange);
end;

procedure TdxSpellCheckerAutoCorrectManager.ApplyChanges(AWordRange: TdxSpellCheckerAutoCorrectWordRange);
begin
  dxSpellCheckerAutoCorrectWord.Replacement := AWordRange.Replacement;
  dxSpellCheckerAutoCorrectWord.SelStart := AWordRange.SelStart;
  dxSpellCheckerAutoCorrectWord.SelLength := AWordRange.SelLength;
  dxSpellCheckerAutoCorrectWord.NewSelStart := AWordRange.NewSelStart;
  PostMessageW(Adapter.EditorHandle, DXM_SPELL_AUTOCORRECT, 0, Longint(@dxSpellCheckerAutoCorrectWord));
end;

procedure TdxSpellCheckerAutoCorrectManager.DoActiveChanged;
begin
  InitializeRules;
end;

procedure TdxSpellCheckerAutoCorrectManager.DoOptionsChanged;
begin
  InitializeRules;
end;

function TdxSpellCheckerAutoCorrectManager.GetAutoCorrectWordRange: TdxSpellCheckerAutoCorrectWordRange;
begin
  with Result do
  begin
    Replacement := '';
    SelStart := Adapter.SelStart - Ord((Adapter is TdxSpellCheckercxRichEditAdapter) and (LastKey = #13));
    SelLength := 0;
    while (SelStart > 0) and not WideIsSpace(Adapter.Text[SelStart]) do
    begin
      Replacement := Adapter.Text[SelStart] + Replacement;
      Dec(SelStart);
      Inc(SelLength);
    end;
  end;
end;

procedure TdxSpellCheckerAutoCorrectManager.InitializeRules;
begin
  FRules.Clear;
  FRules.Add(TdxSpellCheckerCorrectReplaceTextAsYouTypeRule.Create(Self));
  FRules.Add(TdxSpellCheckerCorrectCapsLockRule.Create(Self));
  FRules.Add(TdxSpellCheckerCorrectInitialCapsRule.Create(Self));
  FRules.Add(TdxSpellCheckerCorrectSentenceCapsRule.Create(Self));
  FLastApplyRule := nil;
  FPrevWord := '';
end;

function TdxSpellCheckerAutoCorrectManager.IsConsistentWithRule(ARule: TdxSpellCheckerAutoCorrectCustomRule;
  AKey: Char; var AWordRange: TdxSpellCheckerAutoCorrectWordRange): Boolean;

  function GetSelStartDelta: Integer;
  begin
    if LastKey = #13 then
      if Adapter is TdxSpellCheckercxRichEditAdapter then
        Result := -1
      else
        Result := 1
    else
      Result := 0;
  end;
  
var
  ASaveWordRange: TdxSpellCheckerAutoCorrectWordRange;
begin
  Result := (ARule <> nil) and ARule.Active and ARule.IsWordDelimiter(WideChar(AKey));
  if Result then
  begin
    ASaveWordRange.Replacement := AWordRange.Replacement;
    ASaveWordRange.SelStart := AWordRange.SelStart;
    ASaveWordRange.SelLength := AWordRange.SelLength;
    Result := (Length(AWordRange.Replacement) > 0) and
      ((AWordRange.SelStart = 0) or WideIsSpace(Adapter.Text[AWordRange.SelStart])) and
      ARule.IsCheckWord(Adapter.Text, AWordRange.SelStart, AWordRange.SelLength, AWordRange.Replacement);
    if Result then
    begin
      ARule.BeforeCorrect;
      AWordRange.NewSelStart := Adapter.SelStart -
        AWordRange.SelLength + Length(AWordRange.Replacement) + 1 + GetSelStartDelta;
      Result := DoAutoCorrect(ARule, AWordRange);
    end;
    if not Result then
    begin
      AWordRange.Replacement := ASaveWordRange.Replacement;
      AWordRange.SelStart := ASaveWordRange.SelStart;
      AWordRange.SelLength := ASaveWordRange.SelLength;
    end
    else
    begin
      ARule.AfterCorrect;
      FLastApplyRule := ARule;
    end;
  end;
end;

procedure TdxSpellCheckerAutoCorrectManager.Undo;
begin
  if (FLastApplyRule = nil) then
    Exit;
  FLastApplyRule.Undo;
  FLastApplyRule := nil;
end;

end.
