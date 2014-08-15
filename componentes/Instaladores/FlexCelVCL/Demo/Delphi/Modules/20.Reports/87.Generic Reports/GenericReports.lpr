program GenericReports;

uses
  Forms,
  Interfaces,
  UGenericReports in 'UGenericReports.pas' {FGenericReports};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFGenericReports, FGenericReports);
  Application.Run;
end.
