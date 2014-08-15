program rbEProj;

uses
  Forms,
  rbEndUsr in 'rbEndUsr.pas' {myEndUserSolution},
  rbExpFrm in 'rbExpFrm.pas' {rbReportExplorerForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TmyEndUserSolution, myEndUserSolution);
  Application.Run;
end.
