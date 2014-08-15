{$FORM TForm2, fSnake.sfm}

uses
  System, Windows, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

var
  a,b,c,d,i,h:integer;   
  Finished: boolean;

procedure Form2Create(Sender: TObject);
begin
  KeyPreview := true;
  randomize;
  button5.Top:=trunc(Random*16)*8;
  button5.Left:=trunc(random*39)*8;
  button1.Top:=80;
  button1.Left:=152;
  button2.Top:=80;
  button3.top:=80;
  button4.Top:=80;
  button2.Left:=144;
  button3.Left:=136;
  button4.Left:=128;
  i:=4;
  a:=0;
  b:=0;
  c:=0;
  d:=0;
end;

procedure Form2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key=VK_UP  then //Up
  a:=1
  else a:=0;

if key=VK_LEFT then  //Left
c:=1
else c:=0;

if key=VK_DOWN then //Down
d:=1
else d:=0;

if key=VK_RIGHT then //Right
b:=1
else b:=0;

end;

procedure Start;
var
  f:integer;
  q:integer;
  bt:TButton;
  s:integer;
  AButton: TButton;
  AButton2: TButton;
  delay: integer;
  Dead: boolean;
begin
  Randomize;
  Dead := false;
  Finished := false;
  repeat
    Caption := 'Score = ' + inttostr((i-4)*10);

    AButton := FindComponent('Button'+inttostr(i+1));
    if (button1.Top=AButton.Top) and (button1.Left = AButton.left) then
    begin
      i:=i+1;
      bt:=TButton.Create(Self);
      bt.Parent:=Self;
      bt.Height:=9;
      bt.Width:=9;
      bt.Caption:='';
      bt.Top:=trunc(Random*26)*8;
      bt.Left:=trunc(random*39)*8;
      bt.Name:='Button'+inttostr(i+1);
      bt.TabStop:=False;
      bt.Caption:='';
    end;

    if (button1.top=button3.Top) and (button1.Left=button3.Left) and (a=1) then
    begin
      button1.top:=button2.Top;
      d:=1;
      a:=0;
    end;
    if (button1.top=button3.Top) and (button1.Left=button3.Left) and (d=1) then
    begin
      button1.top:=button2.Top;
      d:=0;
      a:=1;
    end;
    if (button1.top=button3.Top) and (button1.Left=button3.Left) and (b=1) then
    begin
      button1.left:=button2.left;
      c:=1;
      b:=0;
    end;
    if (button1.top=button3.Top) and (button1.Left=button3.Left) and (c=1) then
    begin
      button1.left:=button2.left;
      b:=1;
      c:=0;
    end;

    if a=1 then
    begin
      for q:=i downto 2  do
      begin
        AButton := FindComponent('Button'+inttostr(q));
        AButton2 := FindComponent('Button'+inttostr(q - 1));
       AButton.top:=AButton2.Top;
       AButton.Left:=AButton2.Left;
      end;
      button1.Top:=button1.Top-8;
    end;

    if b=1 then
    begin
      for q:=i downto 2  do
      begin
        AButton := FindComponent('Button'+inttostr(q));
        AButton2 := FindComponent('Button'+inttostr(q - 1));
        AButton.left:=AButton2.left;
        AButton.top:=AButton2.top;
      end;
      button1.left:=button1.left+8;
    end;

    if c=1 then
    begin
      for q:=i downto 2  do
      begin
        AButton := FindComponent('Button'+inttostr(q));
        AButton2 := FindComponent('Button'+inttostr(q - 1));
        AButton.left:=AButton2.left;
        AButton.top:=AButton2.top;
      end;
      button1.left:=button1.left-8;
    end;
    if d=1 then
    begin
      for q:=i downto 2  do
      begin
        AButton := FindComponent('Button'+inttostr(q));
        AButton2 := FindComponent('Button'+inttostr(q - 1));
        AButton.top:=AButton2.Top;
        AButton.Left:=AButton2.Left;
      end;
      button1.Top:=button1.Top+8;
    end;
    for f:=i downto 5 do
    begin
      AButton := FindComponent('Button'+IntToStr(f));
      if (button1.Top=AButton.Top) and (button1.left=AButton.Left) then
        Dead := true;
    end;
    if Dead or ((button1.top<0) or (button1.top>201) or(button1.left<0) or(button1.Left>305)) then
    begin
      Dead := false;
      button1.Top:=88;
      button1.Left:=152;
      a:=0;
      b:=0;
      c:=0;
      d:=0;
      showmessage('...You Lost...'#13'Score= '+inttostr((i-4)*10));

      for s:=(i+1) downto 6 do
      begin
        AButton := FindComponent('Button'+inttostr(s));
        AButton.Free;
      end;
      form2create(self);
    end;

    Application.ProcessMessages;

    {delay}
    for delay := 1 to (40 - StrToInt(Edit1.Text)) * 8000 do
      nothing;
  until Finished;
  Close;
end;

procedure BitBtn1Click(Sender: TObject);
begin
  Finished := true;
end;

procedure Form2Close(Sender: TObject; var Action: TCloseAction);
begin
  Finished := true;
end;

procedure SpeedButton1Click(Sender: TObject);
begin
  if Edit1.Text <> '40' then
    Edit1.Text := IntToStr(StrToInt(Edit1.Text) + 1);
end;

procedure SpeedButton2Click(Sender: TObject);
begin
  if Edit1.Text <> '1' then
    Edit1.Text := IntToStr(StrToInt(Edit1.Text) - 1);
end;

begin
end;
