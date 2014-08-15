program CaseStatement;

uses
  Forms,
  fMain in 'fMain.pas' {fmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Scripter demo';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
