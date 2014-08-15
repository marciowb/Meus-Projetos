program EndUser;

uses
  Forms,
  myEURpt in 'myEURpt.pas' {myEndUserSolution},
  daIBO in 'daIBO.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TmyEndUserSolution, myEndUserSolution);
  Application.Run;
end.
