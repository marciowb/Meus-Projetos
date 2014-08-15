program DatabaseReports;

uses
  Forms,
  Interfaces,
  UDatabaseReports in 'UDatabaseReports.pas' {FDatabaseReports};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFDatabaseReports, FDatabaseReports);
  Application.Run;
end.
