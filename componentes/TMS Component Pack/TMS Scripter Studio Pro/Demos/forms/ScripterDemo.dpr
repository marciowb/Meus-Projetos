program ScripterDemo;

uses
  Forms,
  fMain in 'fMain.pas' {Form1},
  pascalform in 'pascalform.pas' {fmPascalForm},
  basicform in 'basicform.pas' {fmBasicForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
