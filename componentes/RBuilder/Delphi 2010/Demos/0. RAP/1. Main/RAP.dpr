program RAP;

uses
  Forms,
  rpMain in 'rpMain.pas' {rapMain},
  rpLevels in 'rpLevels.pas' {rapLevelDirectory},
  myRapFuncs0033 in 'myRapFuncs0033.pas',
  myRapFuncs0032 in 'myRapFuncs0032.pas',
  myRapFuncs0031 in 'myRapFuncs0031.pas',
  myRapFuncs0034 in 'myRapFuncs0034.pas',
  myUserInputForm in 'myUserInputForm.pas' {frmMyUserInput},
  myRapFuncs0035 in 'myRapFuncs0035.pas',
  rap0041 in 'rap0041.pas' {rap0041Form},
  myRapFuncs0036 in 'myRapFuncs0036.pas',
  rap0042 in 'rap0042.pas' {rap0042Form};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TrapMain, rapMain);
  Application.Run;
end.
