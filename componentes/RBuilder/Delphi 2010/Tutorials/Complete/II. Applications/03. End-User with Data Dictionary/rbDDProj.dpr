program rbDDProj;

uses
  Forms,
  rbEUDD in 'rbEUDD.pas' {myEndUserSolution};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TmyEndUserSolution, myEndUserSolution);
  Application.Run;
end.
