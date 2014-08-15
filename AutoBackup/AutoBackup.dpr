program AutoBackup;



uses
  Forms,
  uLibBackup in 'uLibBackup.pas',
  uPrincipal_AutoBackup in 'uPrincipal_AutoBackup.pas' {frmPrincipal_AutoBackup},
  Cad_Horario in 'Cad_Horario.pas' {frmCad_Horario},
  Cad_Locais in 'Cad_Locais.pas' {frmCad_locais};

{$R *.RES}
//{$R UAC.res}
begin
  Application.Initialize;
  Application.Title := 'Backup automático';
  Application.CreateForm(TfrmPrincipal_AutoBackup, frmPrincipal_AutoBackup);
  Application.Run;
end.
