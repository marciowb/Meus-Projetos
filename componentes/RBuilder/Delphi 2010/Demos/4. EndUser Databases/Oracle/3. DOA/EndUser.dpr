program EndUser;

uses
  Forms,
  daDOA in 'daDOA.pas',
  myEURpt in 'myEURpt.pas' {myEndUserSolution};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TmyEndUserSolution, myEndUserSolution);
  Application.Run;
end.
