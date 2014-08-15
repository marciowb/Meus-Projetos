program CopyAndPaste;

uses
  Forms,
  UCopyAndPaste in 'UCopyAndPaste.pas' {FCopyAndPaste};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFCopyAndPaste, FCopyAndPaste);
  Application.Run;
end.
