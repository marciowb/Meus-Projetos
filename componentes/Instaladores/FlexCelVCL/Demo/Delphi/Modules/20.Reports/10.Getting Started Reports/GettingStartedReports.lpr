program GettingStartedReports;

uses
  Forms,
  Interfaces,
  UGettingStartedReports in 'UGettingStartedReports.pas' {FGettingStartedReports};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFGettingStartedReports, FGettingStartedReports);
  Application.Run;
end.
