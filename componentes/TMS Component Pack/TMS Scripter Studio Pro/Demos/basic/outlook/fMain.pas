unit fMain;

interface

uses
  Windows, Messages, SysUtils,
  {$IFNDEF VER130}
  Variants,
  {$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, atScript, comobj, FormScript, ExtCtrls, atPascal,
  atBasic, AdvMemo, advmbs;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    PhoneSel: TRadioGroup;
    Label1: TLabel;
    ContactCount: TLabel;
    Label2: TLabel;
    AdvMemo1: TAdvMemo;
    atBasicFormScripter1: TatBasicFormScripter;
    AdvBasicMemoStyler1: TAdvBasicMemoStyler;
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

  with atBasicFormScripter1.AddDelphiClass(TStrings) do
  begin
    AddMethod('Add',1,tkNone,nil,StAdd);
    AddMethod('Clear',0,tkNone,nil,StClear);
  end;


  atBasicFormScripter1.sourcecode.Assign(advmemo1.lines);
  atBasicFormScripter1.Execute(null);
end;

procedure TForm1.StAdd;
begin
  TStrings(atBasicFormScripter1.CurrentObject).Add(atBasicFormScripter1.GetInputArgAsString(0));
end;

procedure TForm1.StClear;
begin
  TStrings(atBasicFormScripter1.CurrentObject).Clear;
end;

end.
