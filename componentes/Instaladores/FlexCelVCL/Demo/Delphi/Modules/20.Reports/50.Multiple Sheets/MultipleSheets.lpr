program MultipleSheets;

uses
  Forms,
  Interfaces,
  UMultipleSheets in 'UMultipleSheets.pas' {FMultipleSheets};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFMultipleSheets, FMultipleSheets);
  Application.Run;
end.
