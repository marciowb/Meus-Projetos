program Demo;

uses
  Forms,
  ctLevels in 'ctLevels.pas' {ctLevelDirectory},
  ctMain in 'ctMain.pas' {crtMain},
  ct121 in 'ct121.pas' {frmCT121},
  ctRptFrm in 'ctRptFrm.pas',
  ct122 in 'ct122.pas' {frmCT122},
  ct123 in 'ct123.pas' {frmCT123},
  ct125 in 'ct125.pas' {frmCT125},
  ct124 in 'ct124.pas' {frmCT124},
  ct126 in 'ct126.pas' {frmCT126},
  ct127 in 'ct127.pas' {frmCT127};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TcrtMain, crtMain);
  Application.Run;
end.
