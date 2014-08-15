program HyperLinks;

uses
  Forms,
  Interfaces,
  UHyperLinks in 'UHyperLinks.pas' {FHyperLinks},
  UHelp in 'UHelp.pas' {FHelp};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFHyperLinks, FHyperLinks);
  Application.Run;
end.
