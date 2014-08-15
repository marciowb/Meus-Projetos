program ImagesAndMultipleSheets;

uses
  Forms,
  Interfaces,
  UImagesAndMultipleSheets in 'UImagesAndMultipleSheets.pas' {FImagesAndMultipleSheets};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFImagesAndMultipleSheets, FImagesAndMultipleSheets);
  Application.Run;
end.
