program Charts;

uses
  Forms,
  Interfaces,
  UCharts in 'UCharts.pas' {FCharts};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFCharts, FCharts);
  Application.Run;
end.
