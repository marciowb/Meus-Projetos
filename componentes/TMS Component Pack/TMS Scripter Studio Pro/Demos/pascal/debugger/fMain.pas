unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, AdvMemo, Advmps, StdCtrls, atScript, atPascal, ComCtrls,
  ToolWin, ImgList, ExtCtrls, Menus, ActnList, atScripter, atScriptDebug;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    AdvMemo1: TAdvMemo;
    MainMenu1: TMainMenu;
    AdvPascalMemoStyler1: TAdvPascalMemoStyler;
    atScriptDebugger1: TatScriptDebugger;
    atScripter1: TatScripter;
    Panel2: TPanel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  atScripter1.SourceCode := AdvMemo1.Lines;
  atScriptDebugger1.Execute;
end;

end.
