program EndUser;

uses
  Forms,
  myEURpt in 'myEURpt.pas' {myEndUserSolution},
  dvDesign in 'dvDesign.pas' {dvDesignDataDialog},
  myDataVw in 'myDatavw.pas',
  myQueryDatavw in 'myQueryDatavw.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TmyEndUserSolution, myEndUserSolution);
  Application.Run;
end.
