{$FORM TForm2, fHello.sfm}

uses
  Classes, Graphics, Controls, Forms, Dialogs, StdCtrls;

procedure Button1Click(Sender: TObject);
begin
  ShowMessage('Hello, ' + Edit1.Text);
end;

begin
end;
