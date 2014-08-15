program EndUser;

uses
  Forms,
  myEURpt in 'myEURpt.pas' {myEndUserSolution},
  myDynamicLoadingSubReport in 'myDynamicLoadingSubReport.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TmyEndUserSolution, myEndUserSolution);
  Application.MainForm.Visible := False;
  Application.ShowMainForm := False;

  Application.Run;
end.
