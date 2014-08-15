program GettingStartedWithDatabaseReports;

uses
  Forms,
  Interfaces,
  UGettingStartedWithDatabaseReports in 'UGettingStartedWithDatabaseReports.pas' {FGettingStartedWithDatabaseReports};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFGettingStartedWithDatabaseReports, FGettingStartedWithDatabaseReports);
  Application.Run;
end.
