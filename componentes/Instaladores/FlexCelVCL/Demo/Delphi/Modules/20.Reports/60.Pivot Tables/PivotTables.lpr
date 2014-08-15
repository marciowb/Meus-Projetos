program PivotTables;

uses
  Forms,
  Interfaces,
  UPivotTables in 'UPivotTables.pas' {FPivotTables};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFPivotTables, FPivotTables);
  Application.Run;
end.
