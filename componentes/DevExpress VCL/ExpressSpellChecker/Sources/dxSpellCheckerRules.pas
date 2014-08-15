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

unit dxSpellCheckerRules;

{$I cxVer.inc}

interface

uses
  Types, Classes, cxClasses;

type

  TdxSpellCheckerSpellingCode = (scNoError, scMisspelled, scRepeatedWords);
  
  { TdxCustomSpellCheckerTextHelper }

  TdxCustomSpellCheckerTextHelper = class
  public
    function GetPrevWord: WideString; virtual; abstract;
    function WordExists(const AWord: WideString): Boolean; virtual; abstract;
  end;

  { TdxSpellCheckerRule }

  TdxSpellCheckerRule = class
  private
    FTextHelper: TdxCustomSpellCheckerTextHelper;
  protected
    function Explicit: Boolean; virtual;
    function GetErrorCode: TdxSpellCheckerSpellingCode; virtual;

    property TextHelper: TdxCustomSpellCheckerTextHelper read FTextHelper;
  public
    constructor Create(ATextHelper: TdxCustomSpellCheckerTextHelper);
    function CanApply(const AWord: WideString): Boolean; virtual; abstract;
  end;
  TdxSpellCheckerRuleClass = class of TdxSpellCheckerRule;

  { TdxSpellCheckerRules }

  TdxSpellCheckerRules = class(TcxObjectList)
  private
    FErrorCode: TdxSpellCheckerSpellingCode;
    function GetItem(Index: Integer): TdxSpellCheckerRule; {$IFDEF DELPHI9} inline; {$ENDIF}
  public
    procedure Add(ARule: TdxSpellCheckerRule);
    function FindNextRuleByClass(var AIndex: Integer; ARuleClass: TdxSpellCheckerRuleClass): TdxSpellCheckerRule;
    function FindRule(const AWord: WideString): TdxSpellCheckerRule;
    function IsValid(const AWord: WideString): Boolean;
    function IsValidExplicit(const AWord: WideString): Boolean;
    function IsValidImplicit(const AWord: WideString): Boolean;

    property ErrorCode: TdxSpellCheckerSpellingCode read FErrorCode;
    property Items[Index: Integer]: TdxSpellCheckerRule read GetItem; default;
  end;

  { TdxSpellCheckerIgnoreUrlRule }

  TdxSpellCheckerIgnoreUrlRule = class(TdxSpellCheckerRule)
  public
    function CanApply(const AWord: WideString): Boolean; override;
  end;

  { TdxSpellCheckerIgnoreEmailRule }

  TdxSpellCheckerIgnoreEmailRule = class(TdxSpellCheckerRule)
  public
    function CanApply(const AWord: WideString): Boolean; override;
  end;

  { TdxSpellCheckerIgnoreUpperCaseWordsRule }

  TdxSpellCheckerIgnoreUpperCaseWordsRule = class(TdxSpellCheckerRule)
  public
    function CanApply(const AWord: WideString): Boolean; override;
  end;

  { TdxSpellCheckerIgnoreMixedCaseWordsRule }

  TdxSpellCheckerIgnoreMixedCaseWordsRule = class(TdxSpellCheckerRule)
  public
    function CanApply(const AWord: WideString): Boolean; override;
  end;

  { TdxSpellCheckerIgnoreWordsWithNumbersRule }

  TdxSpellCheckerIgnoreWordsWithNumbersRule = class(TdxSpellCheckerRule)
  public
    function CanApply(const AWord: WideString): Boolean; override;
  end;

  { TdxSpellCheckerWordExistsRule }

  TdxSpellCheckerWordExistsRule = class(TdxSpellCheckerRule)
  public
    function CanApply(const AWord: WideString): Boolean; override;
  end;

  { TdxSpellCheckerRepeatedWordsRule }

  TdxSpellCheckerRepeatedWordsRule = class(TdxSpellCheckerRule)
  protected
    function Explicit: Boolean; override;
    function GetErrorCode: TdxSpellCheckerSpellingCode; override;
  public
    function CanApply(const AWord: WideString): Boolean; override;
  end;

implementation

uses
   SysUtils, dxSpellCheckerUtils, dxCore;

{ TdxSpellCheckerRule }

constructor TdxSpellCheckerRule.Create(ATextHelper: TdxCustomSpellCheckerTextHelper);
begin
  inherited Create;
  FTextHelper := ATextHelper;
end;

function TdxSpellCheckerRule.Explicit: Boolean;
begin
  Result := True;
end;

function TdxSpellCheckerRule.GetErrorCode: TdxSpellCheckerSpellingCode;
begin
  Result := scNoError;
end;

{ TdxSpellCheckerRules }

procedure TdxSpellCheckerRules.Add(ARule: TdxSpellCheckerRule);
begin
  inherited Add(ARule);
end;

function TdxSpellCheckerRules.FindNextRuleByClass(var AIndex: Integer; ARuleClass: TdxSpellCheckerRuleClass): TdxSpellCheckerRule;
var
  I: Integer;
begin
  Result := nil;
  for I := AIndex to Count - 1 do
    if Items[I] is ARuleClass then
    begin
      AIndex := I;
      Result := Items[AIndex];
      Break;
    end;
end;

function TdxSpellCheckerRules.FindRule(
  const AWord: WideString): TdxSpellCheckerRule;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].CanApply(AWord) then
    begin
      Result := Items[I];
      Break;
    end;
end;

function TdxSpellCheckerRules.IsValid(const AWord: WideString): Boolean;
begin
  Result := IsValidExplicit(AWord) and IsValidImplicit(AWord);
end;

function TdxSpellCheckerRules.IsValidExplicit(const AWord: WideString): Boolean;
var
  I: Integer;
begin
  Result := False;
  FErrorCode := scMisspelled;
  for I := 0 to Count - 1 do
    if Items[I].Explicit and Items[I].CanApply(AWord) then
    begin
      Result := True;
      FErrorCode := Items[I].GetErrorCode;
      Break;
    end;
end;

function TdxSpellCheckerRules.IsValidImplicit(const AWord: WideString): Boolean;
var
  I: Integer;
begin
  Result := True;
  FErrorCode := scNoError;
  for I := 0 to Count - 1 do
    if not Items[I].Explicit and not Items[I].CanApply(AWord) then
    begin
      Result := False;
      FErrorCode := Items[I].GetErrorCode;
      Break;
    end;
end;

function TdxSpellCheckerRules.GetItem(Index: Integer): TdxSpellCheckerRule;
begin
  Result := TdxSpellCheckerRule(inherited Items[Index]);
end;

{ TdxSpellCheckerIgnoreUrlRule }

function TdxSpellCheckerIgnoreUrlRule.CanApply(
  const AWord: WideString): Boolean;
begin
  Result := IsUrl(AWord);
end;

{ TdxSpellCheckerIgnoreEmailRule }

function TdxSpellCheckerIgnoreEmailRule.CanApply(
  const AWord: WideString): Boolean;
begin
  Result := WideCharPos('@', AWord) > 0;
end;

{ TdxSpellCheckerIgnoreUpperCaseWordsRule }

function TdxSpellCheckerIgnoreUpperCaseWordsRule.CanApply(
  const AWord: WideString): Boolean;
begin
  Result := GetWordCapitalizationType(AWord) = ctUpper;
end;

{ TdxSpellCheckerIgnoreMixedCaseWordsRule }

function TdxSpellCheckerIgnoreMixedCaseWordsRule.CanApply(
  const AWord: WideString): Boolean;
begin
  Result := GetWordCapitalizationType(AWord) = ctMixed;
end;

{ TdxSpellCheckerIgnoreWordsWithNumbersRule }

function TdxSpellCheckerIgnoreWordsWithNumbersRule.CanApply(
  const AWord: WideString): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 1 to Length(AWord) do
    if dxWideIsNumeric(AWord[I]) then
    begin
      Result := True;
      Break;
    end;
end;

{ TdxSpellCheckerWordExistsRule }

function TdxSpellCheckerWordExistsRule.CanApply(
  const AWord: WideString): Boolean;
begin
  Result := TextHelper.WordExists(AWord);
end;

{ TdxSpellCheckerRepeatedWordsRule }

function TdxSpellCheckerRepeatedWordsRule.CanApply(
  const AWord: WideString): Boolean;
begin
  Result := not WideSameText(TextHelper.GetPrevWord, AWord);
end;

function TdxSpellCheckerRepeatedWordsRule.Explicit: Boolean;
begin
  Result := False;
end;

function TdxSpellCheckerRepeatedWordsRule.GetErrorCode: TdxSpellCheckerSpellingCode;
begin
  Result := scRepeatedWords;
end;

end.
