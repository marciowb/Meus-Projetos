program XlsViewer;

uses
  Forms,
  UXlsViewer in 'UXlsViewer.pas' {FXlsViewer},
  UFormatDialog in 'UFormatDialog.pas' {FormatDialog},
  UPreview in 'UPreview.pas' {FPreview};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.Title := 'FlexCel Viewer';
  Application.CreateForm(TFXlsViewer, FXlsViewer);
  Application.Run;
end.
