program KeyGen;

uses
  Forms,
  uPrincipal in 'uPrincipal.pas' {Form1},
  HD in '..\HD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
