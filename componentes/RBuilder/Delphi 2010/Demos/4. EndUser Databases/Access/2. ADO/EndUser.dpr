program EndUser;

uses
  Forms,
  myEURpt in 'myEURpt.pas' {myEndUserSolution},
  ppRptExp in '..\..\..\..\..\..\..\..\TeamCo\RB 10\Lib\ppRptExp.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TmyEndUserSolution, myEndUserSolution);
  Application.Run;
end.
