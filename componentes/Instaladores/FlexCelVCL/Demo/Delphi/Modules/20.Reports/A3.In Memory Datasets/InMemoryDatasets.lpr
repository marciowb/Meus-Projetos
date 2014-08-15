program InMemoryDatasets;

uses
  Forms,
  Interfaces,
  UInMemoryDataSets in 'UInMemoryDataSets.pas' {FInMemoryDatasets};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFInMemoryDatasets, FInMemoryDatasets);
  Application.Run;
end.
