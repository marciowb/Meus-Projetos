program rapTutorials;

uses
  Forms,
  raTutMain in 'raTutMain.pas' {frmRapTutorialsMain},
  raTutLevels in 'raTutLevels.pas' {frmRapTutorLevelDirectory},
  myUserInputForm in 'myUserInputForm.pas' {frmMyUserInput},
  myRapFuncs in 'myRapFuncs.pas',
  myRapFuncsForm in 'myRapFuncsForm.pas',
  myRapClass in 'myRapClass.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmRapTutorialsMain, frmRapTutorialsMain);
  Application.Run;
end.
