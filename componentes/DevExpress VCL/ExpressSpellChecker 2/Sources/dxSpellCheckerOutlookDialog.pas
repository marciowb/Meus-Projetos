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

unit dxSpellCheckerOutlookDialog;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, cxLookAndFeelPainters, StdCtrls, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMemo, dxSpellChecker, dxSpellCheckerBaseForm,
  cxListBox, cxGraphics, cxLookAndFeels;

type

  { TdxCustomSpellCheckerForm }

  TdxCustomSpellCheckerForm = class(TfmSpellCheckerBaseForm)
  private
    FSpellChecker: TdxCustomSpellChecker;
    function GetCheckMode: TdxSpellCheckerDialogCheckMode;
  protected
    procedure Activate; override;
    procedure Initialize; virtual;
    procedure Localize; override;
    procedure ShowSpellingOptionsDialog; virtual;
    
    property SpellChecker: TdxCustomSpellChecker read FSpellChecker;
    property CheckMode: TdxSpellCheckerDialogCheckMode read GetCheckMode;
  public
    constructor CreateEx(ASpellChecker: TdxCustomSpellChecker); virtual;
  end;
  TdxCustomSpellCheckerFormClass = class of TdxCustomSpellCheckerForm;

  { TfmSpellCheckerOutlookForm }

  TfmSpellCheckerOutlookForm = class(TdxCustomSpellCheckerForm)
    lbMisspelled: TLabel;
    teMisspelledWord: TcxTextEdit;
    teSuggestion: TcxTextEdit;
    lbxSuggestions: TcxListBox;
    btnIgnore: TcxButton;
    btnChange: TcxButton;
    btnAdd: TcxButton;
    btnIgnoreAll: TcxButton;
    btnChangeAll: TcxButton;
    btnSuggest: TcxButton;
    btnOptions: TcxButton;
    btnUndoLast: TcxButton;
    btnCancel: TcxButton;
    lbChangeTo: TLabel;
    lbSuggestions: TLabel;
    procedure lbxSuggestionsClick(Sender: TObject);
    procedure btnSuggestClick(Sender: TObject);
    procedure teSuggestionPropertiesChange(Sender: TObject);
    procedure btnIgnoreClick(Sender: TObject);
    procedure btnIgnoreAllClick(Sender: TObject);
    procedure btnChangeClick(Sender: TObject);
    procedure btnChangeAllClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnUndoLastClick(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
  private
    FHasSuggestions: Boolean;
    FMisspelledWord: WideString;
    FSuggestionLockChange: Boolean;
    procedure ValidateCaptions;
  protected
    procedure CheckNextMisspelledWord;
    procedure Initialize; override;
    function IsDeleteMisspelled: Boolean;
    procedure Localize; override;
    procedure SetMisspelledWord(const AValue: WideString); virtual;
    procedure SetSuggestions(ASuggestions: TdxSpellCheckerSuggestionList);
    procedure SetSuggestionText(const AText: WideString);
    procedure SetMisspelledInfo;

    property HasSuggestions: Boolean read FHasSuggestions;
    property MisspelledWord: WideString read FMisspelledWord write SetMisspelledWord;
  end;

implementation

{$R *.dfm}

uses
  cxClasses, dxSpellCheckerStrs, dxSpellCheckerDialogs, dxSpellCheckerRules;

{ TdxCustomSpellCheckerForm }

constructor TdxCustomSpellCheckerForm.CreateEx(
  ASpellChecker: TdxCustomSpellChecker);
begin
  inherited CreateEx;
  FSpellChecker := ASpellChecker;
  Localize;
end;

procedure TdxCustomSpellCheckerForm.Activate;
begin
  inherited Activate;
  Initialize;
end;

procedure TdxCustomSpellCheckerForm.Initialize;
begin
end;

procedure TdxCustomSpellCheckerForm.Localize;
begin
  Caption := cxGetResourceString(@sdxSpellCheckerSpellingFormCaption);
end;

procedure TdxCustomSpellCheckerForm.ShowSpellingOptionsDialog;
begin
  dxShowSpellingOptionsDialog(SpellChecker, SpellChecker.DialogLookAndFeel);
end;

function TdxCustomSpellCheckerForm.GetCheckMode: TdxSpellCheckerDialogCheckMode;
begin
  Result := TdxSpellCheckerDialogCheckMode(SpellChecker.CheckMode);
end;

{ TfmSpellCheckerOutlookForm }

procedure TfmSpellCheckerOutlookForm.btnAddClick(Sender: TObject);
begin
  SpellChecker.AddWordToUserDictionary(MisspelledWord);
  CheckNextMisspelledWord;
end;

procedure TfmSpellCheckerOutlookForm.btnChangeAllClick(Sender: TObject);
begin
  if IsDeleteMisspelled then
    CheckMode.DeleteAll
  else
  begin
    if not btnSuggest.Enabled and not FHasSuggestions then
      if (MessageDlg(cxGetResourceString(@sdxSpellCheckerConfirmUseUnknownWord),
        mtWarning, [mbYes, mbNo], 0) <> mrYes) then
      begin
        teSuggestion.SetFocus;
        Exit;
      end;
    CheckMode.ChangeAll(teSuggestion.Text);
  end;
  CheckNextMisspelledWord;
end;

procedure TfmSpellCheckerOutlookForm.btnChangeClick(Sender: TObject);
begin
  if IsDeleteMisspelled then
    CheckMode.Delete
  else
  begin
    if not btnSuggest.Enabled and not FHasSuggestions then
      if (MessageDlg(cxGetResourceString(@sdxSpellCheckerConfirmUseUnknownWord),
        mtWarning, [mbYes, mbNo], 0) <> mrYes) then
      begin
        teSuggestion.SetFocus;
        Exit;
      end;
    CheckMode.Change(teSuggestion.Text);
  end;
  CheckNextMisspelledWord;
end;

procedure TfmSpellCheckerOutlookForm.btnIgnoreAllClick(Sender: TObject);
begin
  CheckMode.IgnoreAll;
  CheckNextMisspelledWord;
end;

procedure TfmSpellCheckerOutlookForm.btnIgnoreClick(Sender: TObject);
begin
  CheckMode.Ignore;
  CheckNextMisspelledWord;
end;

procedure TfmSpellCheckerOutlookForm.btnSuggestClick(Sender: TObject);
begin
  SetSuggestions(CheckMode.GetSuggestions(teSuggestion.Text));
end;

procedure TfmSpellCheckerOutlookForm.btnUndoLastClick(Sender: TObject);
begin
  CheckMode.UndoLast;
  btnUndoLast.Enabled := CheckMode.CanUndo;
end;

procedure TfmSpellCheckerOutlookForm.btnOptionsClick(Sender: TObject);
begin
  ShowSpellingOptionsDialog;
  CheckNextMisspelledWord;
end;

procedure TfmSpellCheckerOutlookForm.CheckNextMisspelledWord;
begin
  if (CheckMode = nil) or not CheckMode.GetNextMisspelledWord then
    ModalResult := mrOk
  else
    SetMisspelledInfo;
end;

procedure TfmSpellCheckerOutlookForm.Initialize;
begin
  SetMisspelledInfo;
  btnAdd.Enabled := SpellChecker.HasEnabledUserDictionary and (Trim(teSuggestion.Text) <> '');
end;

function TfmSpellCheckerOutlookForm.IsDeleteMisspelled: Boolean;
begin
  Result := Length(teSuggestion.Text) = 0;
end;

procedure TfmSpellCheckerOutlookForm.lbxSuggestionsClick(Sender: TObject);
begin
  if lbxSuggestions.ItemIndex <> -1 then
  begin
    teSuggestion.Text := lbxSuggestions.Items[lbxSuggestions.ItemIndex];
    btnSuggest.Enabled := False;
  end;
end;

procedure TfmSpellCheckerOutlookForm.Localize;
begin
  inherited Localize;
  lbMisspelled.Caption := cxGetResourceString(@sdxSpellCheckerNotInDictionary);
  lbChangeTo.Caption := cxGetResourceString(@sdxSpellCheckerChangeTo);
  lbSuggestions.Caption := cxGetResourceString(@sdxSpellCheckerSuggestions);
  btnIgnore.Caption := cxGetResourceString(@sdxSpellCheckerIgnoreButton);
  btnIgnoreAll.Caption := cxGetResourceString(@sdxSpellCheckerIgnoreAllButton);
  btnChange.Caption := cxGetResourceString(@sdxSpellCheckerChangeButton);
  btnChangeAll.Caption := cxGetResourceString(@sdxSpellCheckerChangeAllButton);
  btnAdd.Caption := cxGetResourceString(@sdxSpellCheckerAddButton);
  btnSuggest.Caption := cxGetResourceString(@sdxSpellCheckerSuggestButton);
  btnOptions.Caption := cxGetResourceString(@sdxSpellCheckerOptionsButton);
  btnUndoLast.Caption := cxGetResourceString(@sdxSpellCheckerUndoLastButton);
  btnCancel.Caption := cxGetResourceString(@sdxSpellCheckerCancelButton);
end;

procedure TfmSpellCheckerOutlookForm.SetMisspelledWord(const AValue: WideString);
begin
  FMisspelledWord := AValue;
  teMisspelledWord.Text := AValue;
  SetSuggestionText(AValue);
  SetSuggestions(CheckMode.GetSuggestions(AValue))
end;

procedure TfmSpellCheckerOutlookForm.SetSuggestions(
  ASuggestions: TdxSpellCheckerSuggestionList);
begin
  FHasSuggestions := ASuggestions.Count > 0;
  lbxSuggestions.Items.BeginUpdate;
  lbxSuggestions.Items.Clear;
  try
    lbxSuggestions.Enabled := FHasSuggestions;
    if FHasSuggestions then
    begin
      ASuggestions.SaveToStrings(lbxSuggestions.Items);
      SetSuggestionText(lbxSuggestions.Items[0]);
      btnIgnore.Default := False;
      btnChange.Default := True;
    end
    else
    begin
      lbxSuggestions.Items.Add(cxGetResourceString(@sdxSpellCheckerNoSuggestions));
      btnChange.Default := False;
      btnIgnore.Default := True;
    end;
  finally
    lbxSuggestions.Items.EndUpdate;
    ASuggestions.Free;
  end;
  ValidateCaptions;
  teSuggestion.SetFocus;
  btnSuggest.Enabled := False;
end;

procedure TfmSpellCheckerOutlookForm.teSuggestionPropertiesChange(
  Sender: TObject);
begin
  if FSuggestionLockChange then Exit;
  btnSuggest.Enabled := True;
  btnAdd.Enabled := SpellChecker.HasEnabledUserDictionary and (Trim(teSuggestion.Text) <> '');
  ValidateCaptions;
end;

procedure TfmSpellCheckerOutlookForm.SetSuggestionText(const AText: WideString);
begin
  FSuggestionLockChange := True;
  teSuggestion.Text := AText;
  teSuggestion.SelectAll;
  FSuggestionLockChange := False;
end;

procedure TfmSpellCheckerOutlookForm.SetMisspelledInfo;
begin
  case CheckMode.LastCode of
    scMisspelled:
      begin
        lbMisspelled.Caption := cxGetResourceString(@sdxSpellCheckerNotInDictionary);
        SetMisspelledWord(CheckMode.MisspelledWord);
      end;
    scRepeatedWords:
      begin
        lbMisspelled.Caption := cxGetResourceString(@sdxSpellCheckerRepeatedWord);
        SetMisspelledWord(CheckMode.MisspelledWord);
        teSuggestion.Text := '';
      end;
  end;
  btnUndoLast.Enabled := CheckMode.CanUndo;
end;

procedure TfmSpellCheckerOutlookForm.ValidateCaptions;
begin
  if IsDeleteMisspelled then
  begin
    btnChange.Caption := cxGetResourceString(@sdxSpellCheckerDeleteButton);
    btnChangeAll.Caption := cxGetResourceString(@sdxSpellCheckerDeleteAllButton);
  end
  else
  begin
    btnChange.Caption := cxGetResourceString(@sdxSpellCheckerChangeButton);
    btnChangeAll.Caption := cxGetResourceString(@sdxSpellCheckerChangeAllButton);
  end;
end;

end.
