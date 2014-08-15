program ImagesAndComments;

uses
  Forms,
  UImagesAndComments in 'UImagesAndComments.pas' {FImagesAndComments};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFImagesAndComments, FImagesAndComments);
  Application.Run;
end.
