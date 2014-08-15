library CustomLib;

uses
  ShareMem,
  SysUtils,
  Classes,
  Graphics,
  Forms;

function CreateCustomForm(ACaption: AnsiString; AColor: TColor): TForm; stdcall;
begin
  result := TForm.Create(nil);
  with result do
  begin
    Caption := ACaption;
    Color := AColor;
    Width := random(Screen.Width div 2) + 50;
    Height := random(Screen.Height div 2) + 50;
    Position := poScreenCenter;
  end;
end;

function DecodeToday(var AYear, AMonth, ADay: word): boolean; stdcall;
begin
  DecodeDate(Date, AYear, AMonth, ADay);
  result := IsLeapYear(AYear);
end;

procedure FormGetBounds(AForm: TForm; var ALeft, ATop, AWidth, AHeight: integer); cdecl;
begin
  with AForm do
  begin
    ALeft := Left;
    ATop := Top;
    AWidth := Width;
    AHeight := Height;
  end;
end;

function One: integer;
begin
  result := 1;
end;

procedure ShowForm(AForm: TForm);
begin
  AForm.ShowModal;
end;

function TimesSquareRoot(x, y: double): double;
begin
  result := sqrt(x * y);
end; 

exports
  CreateCustomForm,
  DecodeToday,
  FormGetBounds,
  One,
  ShowForm,
  TimesSquareRoot;

begin
end.
 