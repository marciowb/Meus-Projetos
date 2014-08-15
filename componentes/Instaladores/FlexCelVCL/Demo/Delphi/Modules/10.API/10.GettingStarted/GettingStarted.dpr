program GettingStarted;

uses
  Forms,
  UGettingStarted in 'UGettingStarted.pas' {FGettingStarted};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFGettingStarted, FGettingStarted);
  Application.Run;
end.
