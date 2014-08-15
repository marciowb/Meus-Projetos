program ReadingFiles;

uses
  Forms,
  UReadingFiles in 'UReadingFiles.pas' {FReadingFiles};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFReadingFiles, FReadingFiles);
  Application.Run;
end.
