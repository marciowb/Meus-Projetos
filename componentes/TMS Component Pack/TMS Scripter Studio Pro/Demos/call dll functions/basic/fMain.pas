unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AdvMemo, ComCtrls, StdCtrls, ExtCtrls, atScript,
  atBasic, AdvmBS, AdvmPS, ap_Windows; 

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    AdvMemo1: TAdvMemo;
    Panel1: TPanel;
    Button1: TButton;
    Memo1: TMemo;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Button2: TButton;
    AdvMemo2: TAdvMemo;
    Scripter: TatBasicScripter;
    AdvBasicMemoStyler1: TAdvBasicMemoStyler;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MyPrint(AMachine: TatVirtualMachine);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Scripter.SourceCode := AdvMemo1.Lines;
  Scripter.Compile;
  Scripter.Execute;                             
end;
                                    
procedure TForm1.FormCreate(Sender: TObject);
begin
  Scripter.AllowDLLCalls := true; 
  Scripter.SystemLibrary.DefineMethod('print', 1, tkNone, nil, MyPrint);                     
end;                                                                                         

procedure TForm1.MyPrint(AMachine: TatVirtualMachine);
begin
  Memo1.Lines.Add(AMachine.GetInputArgAsString(0));
end;           
               
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F9 then
    if PageControl1.ActivePage = TabSheet1 then
      Button1.Click
    else
      Button2.Click;
end;
               
procedure TForm1.Button2Click(Sender: TObject);
begin
  Scripter.SourceCode := AdvMemo2.Lines;
  Scripter.Compile;
  Scripter.Execute;
end;

end.

