program Kriptografia;

uses
  Forms,
  uPrinipal in 'uPrinipal.pas' {frmPrincipal},
  Comandos in '..\Global\Comandos.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
