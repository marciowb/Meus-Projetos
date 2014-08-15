program ScriptIDE;

uses
  Forms,
  uScriptIDE in 'uScriptIDE.pas' {DebugForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDebugForm, DebugForm);
  Application.Run;
end.
