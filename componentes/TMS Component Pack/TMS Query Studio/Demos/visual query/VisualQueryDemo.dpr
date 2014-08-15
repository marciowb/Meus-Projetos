program VisualQueryDemo;

uses
  Forms,
  fMain in 'fMain.pas' {Form1};

{$R *.RES}

{$IFDEF VER160}
[STAThread]
{$ENDIF}
begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
