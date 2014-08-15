program EndUser;

uses
  Forms,
  myEURpt in 'myEURpt.pas' {myEndUserSolution},
  daElevateDB in 'daElevateDB.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TmyEndUserSolution, myEndUserSolution);
  Application.Run;
end.
