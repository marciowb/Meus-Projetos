program FlexCelImageExplorer;

uses
  Forms,
  Interfaces,
  UFlexCelImageExplorer in 'UFlexCelImageExplorer.pas' {FFlexCelImageExplorer};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFFlexCelImageExplorer, FFlexCelImageExplorer);
  Application.Run;
end.
