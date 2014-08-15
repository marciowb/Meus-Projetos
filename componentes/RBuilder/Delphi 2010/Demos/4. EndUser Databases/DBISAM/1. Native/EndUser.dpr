program EndUser;

uses
  Forms,
  myEURpt in 'myEURpt.pas' {myEndUserSolution},
  daDBISAM in 'daDBISAM.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TmyEndUserSolution, myEndUserSolution);
  Application.Run;
end.
