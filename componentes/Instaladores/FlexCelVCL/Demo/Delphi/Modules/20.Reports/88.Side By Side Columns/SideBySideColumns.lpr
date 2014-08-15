program SideBySideColumns;

uses
  Forms,
  Interfaces,
  USideBySideColumns in 'USideBySideColumns.pas' {FSideBySideColumns};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFSideBySideColumns, FSideBySideColumns);
  Application.Run;
end.
