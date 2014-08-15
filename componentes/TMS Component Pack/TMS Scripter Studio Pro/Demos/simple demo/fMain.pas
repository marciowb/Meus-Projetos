unit fMain;

{$I AScript.INC}

interface

uses
  Windows, Messages, SysUtils,
  {$IFDEF DELPHI6_LVL}
  Variants,
  {$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvMemo, AdvmPS, atScript, atPascal;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FMemo: TAdvMemo;
    FScripter: TatCustomScripter;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FMemo := TAdvMemo.Create(Self);
  FMemo.Top := Button1.Top * 2 + Button1.Height;
  FMemo.Left := 5;
  FMemo.Width := ClientWidth - 10;
  FMemo.Height := ClientHeight - FMemo.Top - 10;
  FMemo.Parent := Self;
  FMemo.Anchors := [akLeft, akTop, akRight, akBottom];
  FMemo.SyntaxStyles := TAdvPascalMemoStyler.Create(Self);
  FMemo.Lines.Text := 'ShowMessage(''Hello world!'');';

  FScripter := TatPascalScripter.Create(Self);

  ActiveControl := FMemo;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    FMemo.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FScripter.SourceCode := FMemo.Lines;
  FScripter.Execute;
end;

end.
