program AdvGridExport;

uses
  Forms,
  Interfaces,
  UAdvGridExport in 'UAdvGridExport.pas' {FAdvGridExport};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFAdvGridExport, FAdvGridExport);
  Application.Run;
end.
