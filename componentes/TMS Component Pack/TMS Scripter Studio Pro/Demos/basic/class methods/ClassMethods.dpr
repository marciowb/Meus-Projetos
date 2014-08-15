program ClassMethods;

uses
  Forms,
  fMain in 'fMain.pas' {fmMain},
  fAuxForm in 'fAuxForm.pas' {MyForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Scripter demo';
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TMyForm, MyForm);
  Application.Run;
end.
