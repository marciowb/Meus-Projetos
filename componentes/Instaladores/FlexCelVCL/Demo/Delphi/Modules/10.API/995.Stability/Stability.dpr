program Stability;

uses
  Forms,
  UStability in 'UStability.pas' {FStability};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFStability, FStability);
  Application.Run;
end.
