unit fMain;

interface

{$I ASCRIPT.INC}

uses
  Windows, Messages, SysUtils,
  {$IFDEF DELPHI6_LVL}Variants,{$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, atScript, FormScript, atPascal, AdvMemo, Advmps;

type
  TForm1 = class(TForm)
    Button1: TButton;
    log: TListBox;
    countrycombo: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
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
  // learns TatPascalScripter how to execute the Add & Clear methods for TStrings
  with atPascalFormScripter1.AddDelphiClass(TStrings) do
  begin
    AddMethod('Add',1,tkNone,nil,StAdd);
    AddMethod('Clear',0,tkNone,nil,StClear);
  end;
  atPascalFormScripter1.SourceCode.Assign(AdvMemo1.Lines);
  atPascalFormScripter1.Execute(null);
end;


// implementation of component method Add of TStrings
procedure TForm1.StAdd;
begin
  TStrings(atPascalFormScripter1.CurrentObject).Add(atPascalFormScripter1.GetInputArgAsString(0));
end;

// implementation of component method Clear of TStrings
procedure TForm1.StClear;
begin
  TStrings(atPascalFormScripter1.CurrentObject).Clear;
end;


end.
