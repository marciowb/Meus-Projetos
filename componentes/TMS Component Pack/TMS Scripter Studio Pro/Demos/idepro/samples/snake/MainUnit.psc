uses
  Classes, Graphics, Controls, Forms, Dialogs, fSnake;

var
  MainForm: TForm2;
begin
  MainForm := TForm2.Create(Application);
  MainForm.Show;
  MainForm.Start;
  MainForm.Close;
  MainForm.Free;
end;
