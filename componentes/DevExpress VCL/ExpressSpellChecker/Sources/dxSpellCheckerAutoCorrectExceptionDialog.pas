unit dxSpellCheckerAutoCorrectExceptionDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxSpellCheckerBaseForm, dxSpellChecker, cxLookAndFeelPainters,
  cxControls, cxContainer, cxEdit, cxGroupBox, Menus, StdCtrls, cxButtons,
  dxSpellCheckerAutoCorrectOptionsDialog;

type
  { TfmSpellCheckerAutoCorrectExceptionsForm }

  TfmSpellCheckerAutoCorrectExceptionsForm = class(TdxCustomSpellCheckerAutoCorrectForm)
    gbFirstLetter: TcxGroupBox;
    gbInitialCaps: TcxGroupBox;
    btnOk: TcxButton;
    btnClose: TcxButton;
  private
    FFirstLetterExceptionsFrame: TCustomFrame;
    FInitialCapsExceptionsFrame: TCustomFrame;
    function IsValidCandidate(const S: WideString; AMinLength: Integer = 1;
      const APossibleLastChar: WideChar = #0): Boolean;
  protected
    procedure ApplyChanges; override;
    procedure FirstLetterExceptionsExistHandler(var S: WideString; var AResult: Boolean);
    procedure FirstLetterExceptionsValidateHandler(var S: WideString; var AResult: Boolean);
    procedure InitialCapsExceptionsValidateHandler(var S: WideString; var AResult: Boolean);
    procedure Initialize; virtual;
    procedure Localize; override;
  public
    constructor CreateEx(AOptions: TdxSpellCheckerAutoCorrectOptions); override;
    destructor Destroy; override;
  end;

implementation

uses
  cxClasses, dxSpellCheckerStrs, dxSpellCheckerExceptionsFrame,
  dxSpellCheckerUtils, dxCore;

{$R *.dfm}

{ TfmSpellCheckerAutoCorrectExceptionsForm }

constructor TfmSpellCheckerAutoCorrectExceptionsForm.CreateEx(AOptions: TdxSpellCheckerAutoCorrectOptions);
begin
  inherited CreateEx(AOptions);
  Initialize;
end;

destructor TfmSpellCheckerAutoCorrectExceptionsForm.Destroy;
begin
  FreeAndNil(FFirstLetterExceptionsFrame);
  FreeAndNil(FInitialCapsExceptionsFrame);
  inherited Destroy;
end;

procedure TfmSpellCheckerAutoCorrectExceptionsForm.ApplyChanges;
begin
  Options.FirstLetterExceptions.AutoInclude := TfrmSpellCheckerExceptions(FFirstLetterExceptionsFrame).cbAutoInclude.Checked;
  Options.InitialCapsExceptions.AutoInclude := TfrmSpellCheckerExceptions(FInitialCapsExceptionsFrame).cbAutoInclude.Checked;
end;

procedure TfmSpellCheckerAutoCorrectExceptionsForm.FirstLetterExceptionsExistHandler(
  var S: WideString; var AResult: Boolean);
var
  ALen: Integer;
begin
  FirstLetterExceptionsValidateHandler(S, AResult);
  if AResult then
  begin
    ALen := Length(S); 
    if S[ALen] <> '.' then
      S := S + '.';
    AResult := Options.FirstLetterExceptions.Find(S) <> -1;
  end;
end;

procedure TfmSpellCheckerAutoCorrectExceptionsForm.FirstLetterExceptionsValidateHandler(
  var S: WideString; var AResult: Boolean);
begin
  AResult := IsValidCandidate(S, 1, '.');
end;

procedure TfmSpellCheckerAutoCorrectExceptionsForm.InitialCapsExceptionsValidateHandler(
  var S: WideString; var AResult: Boolean);
begin
  AResult := IsValidCandidate(S, 3);
end;

procedure TfmSpellCheckerAutoCorrectExceptionsForm.Initialize;
begin
  FFirstLetterExceptionsFrame := TfrmSpellCheckerExceptions.CreateEx(gbFirstLetter, Options.FirstLetterExceptions);
  FFirstLetterExceptionsFrame.Parent := gbFirstLetter;
  FFirstLetterExceptionsFrame.Align := alClient;
  TfrmSpellCheckerExceptions(FFirstLetterExceptionsFrame).OnCandidateExist := FirstLetterExceptionsExistHandler;
  TfrmSpellCheckerExceptions(FFirstLetterExceptionsFrame).OnCandidateValidate := FirstLetterExceptionsValidateHandler;

  FInitialCapsExceptionsFrame := TfrmSpellCheckerExceptions.CreateEx(gbInitialCaps, Options.InitialCapsExceptions);
  FInitialCapsExceptionsFrame.Parent := gbInitialCaps;
  FInitialCapsExceptionsFrame.Align := alClient;
  TfrmSpellCheckerExceptions(FInitialCapsExceptionsFrame).OnCandidateValidate := InitialCapsExceptionsValidateHandler;
end;

procedure TfmSpellCheckerAutoCorrectExceptionsForm.Localize;
begin
  Caption := cxGetResourceString(@sdxSpellCheckerAutoCorrectExceptionsFormCaption);
  btnOk.Caption := cxGetResourceString(@sdxSpellCheckerOkButton);
  btnClose.Caption := cxGetResourceString(@sdxSpellCheckerCloseButton);
  gbFirstLetter.Caption := cxGetResourceString(@sdxSpellCheckerFirstLetterExceptions);
  gbInitialCaps.Caption := cxGetResourceString(@sdxSpellCheckerInitialCapsExceptions);
end;

function TfmSpellCheckerAutoCorrectExceptionsForm.IsValidCandidate(const S: WideString; AMinLength: Integer = 1;
  const APossibleLastChar: WideChar = #0): Boolean;
var
  ALen, I: Integer;
begin
  Result := False;
  ALen := Length(S);
  if ALen >= AMinLength then
  begin
    Result := True;
    for I := 1 to ALen do
    begin
      Result := dxWideIsAlpha(S[I]);
      Result := Result or ((ALen > 1) and
        (I = ALen) and (APossibleLastChar <> #0) and (S[I] = APossibleLastChar));
      if not Result then
        Break;
    end;
  end;
end;

end.
