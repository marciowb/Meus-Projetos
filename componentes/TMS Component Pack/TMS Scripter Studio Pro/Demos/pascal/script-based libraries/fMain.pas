unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AdvMemo, ComCtrls, StdCtrls, ExtCtrls, atScript, atPascal,
  atBasic, AdvmBS, AdvmPS;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    AdvMemo2: TAdvMemo;
    AdvMemo1: TAdvMemo;
    Panel1: TPanel;
    Button1: TButton;
    Scripter: TatPascalScripter;
    Panel2: TPanel;
    Button2: TButton;
    TabSheet3: TTabSheet;
    Panel3: TPanel;
    Button3: TButton;
    AdvMemo3: TAdvMemo;
    BasicScripter: TatBasicScripter;
    AdvPascalMemoStyler1: TAdvPascalMemoStyler;
    AdvBasicMemoStyler1: TAdvBasicMemoStyler;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
  With Scripter.Scripts.Add do
  begin
    SourceCode := AdvMemo1.Lines;
    SelfRegisterAsLibrary('Versions');
    SelfRegisterAsLibrary(BasicScripter, 'Versions');
  end;
  Button1.Enabled := false;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  With Scripter.Scripts.Add do
  begin
    SourceCode := AdvMemo2.Lines;
    Compile;
    VirtualMachine.Execute;
    Free;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  With BasicScripter.Scripts.Add do
  begin
    SourceCode := AdvMemo3.Lines;
    Compile;
    VirtualMachine.Execute;
    Free;
  end;
end;

end.
