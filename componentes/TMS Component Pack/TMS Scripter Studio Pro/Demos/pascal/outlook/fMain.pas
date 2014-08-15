unit fMain;

interface

uses
  Windows, Messages, SysUtils,
  {$IFNDEF VER130}
  Variants,
  {$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, atScript, comobj, FormScript, ExtCtrls, atPascal,
  AdvMemo, Advmps;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    PhoneSel: TRadioGroup;
    Label1: TLabel;
    ContactCount: TLabel;
    Label2: TLabel;
    atPascalFormScripter1: TatPascalFormScripter;
    AdvMemo1: TAdvMemo;
    AdvPascalMemoStyler1: TAdvPascalMemoStyler;
    procedure Button1Click(Sender: TObject);
    procedure StAdd;
    procedure StClear;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin

  with atPascalFormScripter1.AddDelphiClass(TStrings) do
  begin
    AddMethod('Add',1,tkNone,nil,StAdd);
    AddMethod('Clear',0,tkNone,nil,StClear);
  end;


  atPascalFormscripter1.sourcecode.Assign(AdvMemo1.lines);
  atPascalFormscripter1.Execute(null);
end;

procedure TForm1.StAdd;
begin
  TStrings(atPascalFormScripter1.CurrentObject).Add(atPascalFormScripter1.GetInputArgAsString(0));
end;

procedure TForm1.StClear;
begin
  TStrings(atPascalFormScripter1.CurrentObject).Clear;
end;

end.
