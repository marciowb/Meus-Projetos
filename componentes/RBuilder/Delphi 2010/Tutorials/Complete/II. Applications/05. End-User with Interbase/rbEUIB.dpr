program rbEUIB;

uses
  Forms,
  rbEndUIB in 'rbEndUIB.pas' {myEndUserSolution};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TmyEndUserSolution, myEndUserSolution);
  Application.Run;
end.
