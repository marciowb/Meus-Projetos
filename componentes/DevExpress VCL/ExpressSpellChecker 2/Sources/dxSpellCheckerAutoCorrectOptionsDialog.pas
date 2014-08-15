unit dxSpellCheckerAutoCorrectOptionsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxSpellCheckerBaseForm, dxSpellChecker, cxLookAndFeelPainters,
  cxControls, cxContainer, cxEdit, cxGroupBox, Menus, StdCtrls, cxButtons,
  cxCheckBox, cxLabel, cxTextEdit, ComCtrls, cxListView;

type
  { TdxCustomSpellCheckerAutoCorrectForm }

  TdxCustomSpellCheckerAutoCorrectForm = class(TfmSpellCheckerBaseForm)
  private
    FOptions: TdxSpellCheckerAutoCorrectOptions;
  protected
    procedure ApplyChanges; virtual;

    property Options: TdxSpellCheckerAutoCorrectOptions read FOptions;
  public
    constructor CreateEx(AOptions: TdxSpellCheckerAutoCorrectOptions); virtual;

    function ShowModal: Integer; override;
  end;
  TdxCustomSpellCheckerAutoCorrectFormClass = class of TdxCustomSpellCheckerAutoCorrectForm;

  { TfmSpellCheckerAutoCorrectExceptionsForm }

  TfmSpellCheckerAutoCorrectOptionsForm = class(TdxCustomSpellCheckerAutoCorrectForm)
    btnOk: TcxButton;
    btnCancel: TcxButton;
    gbCapitalize: TcxGroupBox;
    cbCorrectInitialCaps: TcxCheckBox;
    cbCorrectSentenceCaps: TcxCheckBox;
    cbCorrectCapsLock: TcxCheckBox;
    cbReplaceTextAsYouType: TcxCheckBox;
    btnExceptions: TcxButton;
    gbReplaceTextAsYouType: TcxGroupBox;
    lbReplace: TcxLabel;
    lbWith: TcxLabel;
    teReplace: TcxTextEdit;
    teWith: TcxTextEdit;
    lvReplacements: TcxListView;
    btnDelete: TcxButton;
    btnOperation: TcxButton;
    cbDisableCapsLock: TcxCheckBox;
    cbAutomaticallyUseSuggestions: TcxCheckBox;
    procedure btnExceptionsClick(Sender: TObject);
    procedure teReplacePropertiesChange(Sender: TObject);
    procedure lvReplacementsClick(Sender: TObject);
    procedure btnOperationClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    function IsAddOperation: Boolean;
    procedure PopulateReplaces;
    procedure SelectItem;
    procedure SynchronizeDialogWithOptions;
    procedure SynchronizeOptionsWithDialog;
    procedure UpdateButtonsState;
    procedure UpdateButtonsCaption;
  protected
    procedure ApplyChanges; override;
    procedure Initialize; virtual;
    procedure Localize; override;
  public
    constructor CreateEx(AOptions: TdxSpellCheckerAutoCorrectOptions); override;
  end;

implementation

uses
  cxClasses, dxSpellCheckerStrs, dxSpellCheckerUtils, dxSpellCheckerDialogs,
  DateUtils;

{$R *.dfm}

{ TdxCustomSpellCheckerAutoCorrectForm }

constructor TdxCustomSpellCheckerAutoCorrectForm.CreateEx(
  AOptions: TdxSpellCheckerAutoCorrectOptions);
begin
  inherited Create(Application);
  FOptions := AOptions;
  Localize;
end;

function TdxCustomSpellCheckerAutoCorrectForm.ShowModal: Integer;
begin
  Result := inherited ShowModal;
  if Result = mrOk then
    ApplyChanges;
end;

procedure TdxCustomSpellCheckerAutoCorrectForm.ApplyChanges;
begin
end;

{ TfmSpellCheckerAutoCorrectExceptionsForm }

constructor TfmSpellCheckerAutoCorrectOptionsForm.CreateEx(AOptions: TdxSpellCheckerAutoCorrectOptions);
begin
  inherited CreateEx(AOptions);
  Initialize;
end;

procedure TfmSpellCheckerAutoCorrectOptionsForm.ApplyChanges;
begin
  SynchronizeOptionsWithDialog;
end;

procedure TfmSpellCheckerAutoCorrectOptionsForm.Initialize;
begin
  SynchronizeDialogWithOptions;
  PopulateReplaces;
  UpdateButtonsState;
  UpdateButtonsCaption;
end;

procedure TfmSpellCheckerAutoCorrectOptionsForm.Localize;
begin
  Caption := cxGetResourceString(@sdxSpellCheckerAutoCorrectOptionsFormCaption);
  btnOk.Caption := cxGetResourceString(@sdxSpellCheckerOkButton);
  btnCancel.Caption := cxGetResourceString(@sdxSpellCheckerCancelButton);
  gbCapitalize.Caption := cxGetResourceString(@sdxSpellCheckerAutoCorrectCapitalize);
  cbCorrectSentenceCaps.Caption := cxGetResourceString(@sdxSpellCheckerAutoCorrectCorrectSentenceCaps);
  cbCorrectInitialCaps.Caption := cxGetResourceString(@sdxSpellCheckerAutoCorrectCorrectInitialCaps);
  cbCorrectCapsLock.Caption := cxGetResourceString(@sdxSpellCheckerAutoCorrectCorrectCapsLock);
  cbDisableCapsLock.Caption := cxGetResourceString(@sdxSpellCheckerAutoCorrectDisableCapsLock);
  cbAutomaticallyUseSuggestions.Caption := cxGetResourceString(@sdxSpellCheckerAutoCorrectAutomaticallyUseSuggestions);
  gbReplaceTextAsYouType.Caption := cxGetResourceString(@sdxSpellCheckerAutoCorrectReplaceTextAsYouType);
  cbReplaceTextAsYouType.Caption := cxGetResourceString(@sdxSpellCheckerActive);
  btnExceptions.Caption := cxGetResourceString(@sdxSpellCheckerExceptionsButton);
  lbReplace.Caption := cxGetResourceString(@sdxSpellCheckerAutoCorrectReplace);
  lbWith.Caption := cxGetResourceString(@sdxSpellCheckerAutoCorrectWith);
  btnOperation.Caption := cxGetResourceString(@sdxSpellCheckerAddButton);
  btnDelete.Caption := cxGetResourceString(@sdxSpellCheckerDeleteButton);
end;

function TfmSpellCheckerAutoCorrectOptionsForm.IsAddOperation: Boolean;
begin
  Result := Options.Replacements.FindReplacement(teReplace.Text) = nil;
end;

procedure TfmSpellCheckerAutoCorrectOptionsForm.PopulateReplaces;
var
  I: Integer;
begin
  lvReplacements.Items.BeginUpdate;
  try
    lvReplacements.Items.Clear;
    for I := 0 to Options.Replacements.Count - 1 do
      with lvReplacements.Items.Add do
      begin
        Caption := Options.Replacements[I].Text;
        SubItems.Add(Options.Replacements[I].Replacement);
      end;
  finally
    lvReplacements.Items.EndUpdate;
  end;
end;

procedure TfmSpellCheckerAutoCorrectOptionsForm.SelectItem;
var
  I: Integer;
begin
  for I := 0 to lvReplacements.Items.Count - 1 do
    if WideCompareText(teReplace.Text, lvReplacements.Items[I].Caption) = 0 then
      lvReplacements.ItemIndex := I;
end;

procedure TfmSpellCheckerAutoCorrectOptionsForm.SynchronizeDialogWithOptions;
begin
  with Options do
  begin
    cbCorrectSentenceCaps.Checked := CorrectSentenceCaps;
    cbCorrectCapsLock.Checked := CorrectCapsLock;
    cbCorrectInitialCaps.Checked := CorrectInitialCaps;
    cbDisableCapsLock.Checked := DisableCapsLock;
    cbReplaceTextAsYouType.Checked := ReplaceTextAsYouType;
    cbAutomaticallyUseSuggestions.Checked := AutomaticallyUseSuggestions;
  end;
end;

procedure TfmSpellCheckerAutoCorrectOptionsForm.SynchronizeOptionsWithDialog;
begin
  with Options do
  begin
    CorrectSentenceCaps := cbCorrectSentenceCaps.Checked;
    CorrectCapsLock := cbCorrectCapsLock.Checked;
    CorrectInitialCaps := cbCorrectInitialCaps.Checked;
    DisableCapsLock := cbDisableCapsLock.Checked;
    ReplaceTextAsYouType := cbReplaceTextAsYouType.Checked;
    AutomaticallyUseSuggestions := cbAutomaticallyUseSuggestions.Checked;
  end;
end;

procedure TfmSpellCheckerAutoCorrectOptionsForm.UpdateButtonsState;
var
  AItem: TdxSpellCheckerReplacement;
begin
  AItem := Options.Replacements.FindReplacement(teReplace.Text);
  btnDelete.Enabled := AItem <> nil;
  btnOperation.Enabled := (Length(teReplace.Text) > 0) and
    (not btnDelete.Enabled or (WideCompareStr(AItem.Replacement, teWith.Text) <> 0));
end;

procedure TfmSpellCheckerAutoCorrectOptionsForm.UpdateButtonsCaption;
begin
  if IsAddOperation then
    btnOperation.Caption := cxGetResourceString(@sdxSpellCheckerAddButton)
  else
    btnOperation.Caption := cxGetResourceString(@sdxSpellCheckerReplaceButton);
end;

procedure TfmSpellCheckerAutoCorrectOptionsForm.btnExceptionsClick(
  Sender: TObject);
begin
  dxShowAutoCorrectExceptionsDialog(Options.SpellChecker, gbCapitalize.LookAndFeel);
end;

procedure TfmSpellCheckerAutoCorrectOptionsForm.teReplacePropertiesChange(
  Sender: TObject);
begin
  SelectItem;
  UpdateButtonsState;
  UpdateButtonsCaption;
end;

procedure TfmSpellCheckerAutoCorrectOptionsForm.lvReplacementsClick(
  Sender: TObject);
var
  AItem: TListItem;
begin
  AItem := lvReplacements.ItemFocused;
  if AItem <> nil then
  begin
    teReplace.Text := AItem.Caption;
    if AItem.SubItems.Count > 0 then
      teWith.Text := AItem.SubItems[0];
    UpdateButtonsState;
    UpdateButtonsCaption;
  end;
end;

procedure TfmSpellCheckerAutoCorrectOptionsForm.btnOperationClick(
  Sender: TObject);
var
  AItem: TdxSpellCheckerReplacement;
begin
  AItem := Options.Replacements.FindReplacement(teReplace.Text);
  if AItem <> nil then
    AItem.ChangeReplacement(teWith.Text)
  else
    Options.Replacements.Add(teReplace.Text, teWith.Text);
  PopulateReplaces;
  UpdateButtonsState;
  UpdateButtonsCaption;
end;

procedure TfmSpellCheckerAutoCorrectOptionsForm.btnDeleteClick(
  Sender: TObject);
var
  AItem: TdxSpellCheckerReplacement;
begin
  AItem := Options.Replacements.FindReplacement(teReplace.Text);
  if AItem <> nil then
  begin
    Options.Replacements.Delete(Options.Replacements.IndexOf(AItem));
    AItem.Free;
  end;
  PopulateReplaces;
  UpdateButtonsState;
  UpdateButtonsCaption;
end;

end.
