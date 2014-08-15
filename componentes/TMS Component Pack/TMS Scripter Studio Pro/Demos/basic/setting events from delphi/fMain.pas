unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, atScriptDebug, atScript, atPascal, AdvMemo, Advmps, ComCtrls,
  ToolWin, advmbs, atBasic;

type
  TForm1 = class(TForm)
    Memo1: TAdvMemo;
    MainMenu1: TMainMenu;
    Script1: TMenuItem;
    miSetEvents: TMenuItem;
    miUnsetEvents: TMenuItem;
    ToolBar1: TToolBar;
    btFirst: TToolButton;
    btSecond: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    btThird: TToolButton;
    ToolButton4: TToolButton;
    Scripter: TatBasicScripter;
    AdvBasicMemoStyler1: TAdvBasicMemoStyler;
    procedure btFirstClick(Sender: TObject);
    procedure btSecondClick(Sender: TObject);
    procedure btThirdClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miSetEventsClick(Sender: TObject);
    procedure miUnsetEventsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses ap_Classes;

{$R *.DFM}

procedure TForm1.btFirstClick(Sender: TObject);
begin
  ShowMessage('First button click handled by DELPHI');
end;

procedure TForm1.btSecondClick(Sender: TObject);
begin
  ShowMessage('Second button click handled by DELPHI');
end;

procedure TForm1.btThirdClick(Sender: TObject);
begin
  ShowMessage('Third button click handled by DELPHI');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  {Add support for TNotifyEvent type}
  Scripter.AddLibrary(TatClassesLibrary);
  Scripter.SourceCode:=Memo1.Lines;
  Scripter.Compile;
end;

procedure TForm1.miSetEventsClick(Sender: TObject);
begin
  Scripter.EventBroker.SetEvent(btFirst, 'OnClick','btFirstClick' ,Scripter,epReplaceCall);
  Scripter.EventBroker.SetEvent(btSecond,'OnClick','btSecondClick',Scripter,epBottomCall);
  Scripter.EventBroker.SetEvent(btThird, 'OnClick','btThirdClick' ,Scripter,epTopCall);
end;

procedure TForm1.miUnsetEventsClick(Sender: TObject);
begin
  Scripter.EventBroker.UnSetEvent(btFirst, 'OnClick');
  Scripter.EventBroker.UnSetEvent(btSecond,'OnClick');
  Scripter.EventBroker.UnSetEvent(btThird, 'OnClick');
end;

end.
