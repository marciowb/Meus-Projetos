unit dxSpellCheckerExceptionsFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxEdit, cxTextEdit, cxControls, cxContainer, cxListBox, Menus,
  cxLookAndFeelPainters, StdCtrls, cxButtons, dxSpellChecker, cxCheckBox;

type

  TfrmSpellCheckerCandidateEvent = procedure(var S: WideString; var AResult: Boolean) of object;

  TfrmSpellCheckerExceptions = class(TFrame)
    lbxList: TcxListBox;
    teCandidate: TcxTextEdit;
    btnAdd: TcxButton;
    btnDelete: TcxButton;
    cbAutoInclude: TcxCheckBox;
    procedure teCandidatePropertiesEditValueChanged(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure lbxListClick(Sender: TObject);
    procedure teCandidateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FExceptions: TdxSpellCheckerAutoCorrectExceptions;
    FOnCandidateExist: TfrmSpellCheckerCandidateEvent;
    FOnCandidateValidate: TfrmSpellCheckerCandidateEvent;
    function DoCandidateExist(var S: WideString): Boolean;
    function DoCandidateValidate(var S: WideString): Boolean;
    function GetCandidateIndex: Integer;
    procedure Initialize;
    procedure Localize;
    procedure PopulateList;
    procedure SelectItem;
    procedure UpdateButtonsState;
  public
    constructor CreateEx(AOwner: TComponent; AExceptions: TdxSpellCheckerAutoCorrectExceptions); virtual;

    property Exceptions: TdxSpellCheckerAutoCorrectExceptions read FExceptions;
    property OnCandidateExist: TfrmSpellCheckerCandidateEvent read FOnCandidateExist write FOnCandidateExist;
    property OnCandidateValidate: TfrmSpellCheckerCandidateEvent read FOnCandidateValidate write FOnCandidateValidate;
  end;

implementation

uses
  dxSpellCheckerUtils, dxSpellCheckerStrs, cxClasses, StrUtils;

{$R *.dfm}

{ TfrmSpellCheckerExceptions }

constructor TfrmSpellCheckerExceptions.CreateEx(AOwner: TComponent; AExceptions: TdxSpellCheckerAutoCorrectExceptions);
begin
  inherited Create(AOwner);
  FExceptions := AExceptions;
  Initialize;
  Localize;
end;

function TfrmSpellCheckerExceptions.DoCandidateExist(var S: WideString): Boolean;
begin
  Result := GetCandidateIndex <> -1;
  if not Result and Assigned(FOnCandidateExist) then
    FOnCandidateExist(S, Result);
end;

function TfrmSpellCheckerExceptions.DoCandidateValidate(var S: WideString): Boolean;
begin
  Result := True;
  if Assigned(FOnCandidateValidate) then
    FOnCandidateValidate(S, Result);
end;

function TfrmSpellCheckerExceptions.GetCandidateIndex: Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to lbxList.Items.Count - 1 do
    if WideCompareText(teCandidate.Text, lbxList.Items[I]) = 0 then
    begin
      Result := I;
      Break;
    end;
end;

procedure TfrmSpellCheckerExceptions.Initialize;
begin
  PopulateList;
  teCandidate.Text := '';
  UpdateButtonsState;
  cbAutoInclude.Checked := FExceptions.AutoInclude;
end;

procedure TfrmSpellCheckerExceptions.Localize;
begin
  btnAdd.Caption := cxGetResourceString(@sdxSpellCheckerAddButton);
  btnDelete.Caption := cxGetResourceString(@sdxSpellCheckerDeleteButton);
  cbAutoInclude.Caption := cxGetResourceString(@sdxSpellCheckerAutoInclude);
end;

procedure TfrmSpellCheckerExceptions.PopulateList;

  procedure Sort;
  var
    S: WideString;
    I, J: Integer;
  begin
    for I := 0 to lbxList.Count - 1 do
      for J := 0 to lbxList.Count - 2 - I do
        if WideCompareStr(lbxList.Items[J], lbxList.Items[J + 1]) > 0 then
        begin
          S := lbxList.Items[J];
          lbxList.Items[J] := lbxList.Items[J + 1];
          lbxList.Items[J + 1] := S;
        end;
  end;

begin
  lbxList.Items.BeginUpdate;
  try
    lbxList.Items.Clear;
    Exceptions.PopulateExceptions(lbxList.Items);
    Sort;
  finally
    lbxList.Items.EndUpdate;
  end;
  SelectItem;
end;

procedure TfrmSpellCheckerExceptions.SelectItem;
var
  AIndex: Integer;
begin
  AIndex := GetCandidateIndex;
  if AIndex <> -1 then
    lbxList.ItemIndex := AIndex
  else
    lbxList.ItemIndex := -1;
end;

procedure TfrmSpellCheckerExceptions.UpdateButtonsState;
var
  AAddButtonEnabled, ADeleteButtonEnabled: Boolean;
  ACandidateExist: Boolean;
  S: WideString;
begin
  S := teCandidate.Text;
  AAddButtonEnabled := (Length(teCandidate.Text) > 0) and DoCandidateValidate(S);
  ADeleteButtonEnabled := AAddButtonEnabled;
  ACandidateExist := DoCandidateExist(S);
  AAddButtonEnabled := AAddButtonEnabled and not ACandidateExist;
  ADeleteButtonEnabled := ADeleteButtonEnabled and ACandidateExist;
  btnAdd.Enabled := AAddButtonEnabled;
  btnDelete.Enabled := ADeleteButtonEnabled;
end;

procedure TfrmSpellCheckerExceptions.teCandidatePropertiesEditValueChanged(
  Sender: TObject);
begin
  UpdateButtonsState;
  SelectItem;
end;

procedure TfrmSpellCheckerExceptions.btnAddClick(Sender: TObject);
begin
  Exceptions.Add(teCandidate.Text);
  PopulateList;
  UpdateButtonsState;
end;

procedure TfrmSpellCheckerExceptions.btnDeleteClick(Sender: TObject);
var
  S: WideString;
begin
  S := teCandidate.Text;
  if DoCandidateExist(S) then
  begin
    Exceptions.Delete(S);
    PopulateList;
    UpdateButtonsState;
  end;
end;

procedure TfrmSpellCheckerExceptions.lbxListClick(Sender: TObject);
begin
  if lbxList.ItemIndex >= 0 then
    teCandidate.Text := lbxList.Items[lbxList.ItemIndex];
  UpdateButtonsState;
end;

procedure TfrmSpellCheckerExceptions.teCandidateKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    if btnAdd.Enabled then
      btnAddClick(nil)
    else
      if btnDelete.Enabled then
        btnDeleteClick(nil);
  end;
end;

end.
