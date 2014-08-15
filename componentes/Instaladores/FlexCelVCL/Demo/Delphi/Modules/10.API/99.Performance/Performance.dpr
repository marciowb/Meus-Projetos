program Performance;

uses
  Forms,
  UPerformance in 'UPerformance.pas' {FPerformance},
  UReportThread in 'UReportThread.pas';

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFPerformance, FPerformance);
  Application.Run; 
end.
