program DelphiFormEditing;

uses
  Forms,
  fMain in 'fMain.pas' {Form1},
  fDelphiForm in 'fDelphiForm.pas' {Form2},
  fInspector in 'fInspector.pas' {Form3},
  fPalette in 'fPalette.pas' {Form4};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
