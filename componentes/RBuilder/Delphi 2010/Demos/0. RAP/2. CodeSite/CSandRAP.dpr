program CSandRAP;

uses
  Forms,
  rpMain in 'rpMain.pas' {rapMain},
  rpLevels in 'rpLevels.pas' {rapLevelDirectory},
  raCSFuncs in 'raCSFuncs.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TrapMain, rapMain);
  Application.Run;
end.
