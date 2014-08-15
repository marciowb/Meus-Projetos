program rbEUProj;

uses
  Forms,
  rbEndUsr in 'rbEndUsr.pas' {myEndUserSolution};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TmyEndUserSolution, myEndUserSolution);
  Application.Run;
end.
