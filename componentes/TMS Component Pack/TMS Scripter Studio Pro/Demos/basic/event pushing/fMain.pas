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
    Debugger: TatScriptDebugger;
    Script1: TMenuItem;
    Run1: TMenuItem;
    Debug1: TMenuItem;
    Eventsetmode1: TMenuItem;
    miBottom: TMenuItem;
    miTop: TMenuItem;
    miReplace: TMenuItem;
    ToolBar1: TToolBar;
    btClickMe: TToolButton;
    Scripter: TatBasicScripter;
    AdvBasicMemoStyler1: TAdvBasicMemoStyler;
    procedure Debug1Click(Sender: TObject);
    procedure Run1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btClickMeClick(Sender: TObject);
    procedure MenuItemClick(Sender: TObject);
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

procedure TForm1.Debug1Click(Sender: TObject);
begin
   Debugger.Execute;
end;

procedure TForm1.Run1Click(Sender: TObject);
begin
  if miBottom.Checked then
    Scripter.EventSetMode:=esAddEventOnBottom
  else
  if miTop.Checked then
    Scripter.EventSetMode:=esAddEventOnTop
  else
  if miReplace.Checked then
  begin
    Scripter.EventSetMode:=esReplaceEvent;
  end;

  {Remove all events set from previous scripts run}
  Scripter.EventBroker.UnsetAllEvents;
  Scripter.SourceCode:=Memo1.Lines;
  Scripter.Execute;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Scripter.AddComponents(Self);
  {Add TNotifyEvent support}
  Scripter.AddLibrary(TatClassesLibrary);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  ShowMessage('Before running script, choose event set mode from menu.');
end;

procedure TForm1.btClickMeClick(Sender: TObject);
begin
  ShowMessage('This is the original event handler in Delphi.');
end;

procedure TForm1.MenuItemClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked:=true;
end;


end.
