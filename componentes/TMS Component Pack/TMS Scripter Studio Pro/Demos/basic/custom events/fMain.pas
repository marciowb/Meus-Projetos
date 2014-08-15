unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, atScriptDebug, atScript, atPascal, AdvMemo, Advmps,
  {$IFNDEF VER130}
  Variants,
  {$ENDIF}
  advmbs, atBasic;

type
  TForm1 = class(TForm)
    Memo1: TAdvMemo;
    MainMenu1: TMainMenu;
    Debugger: TatScriptDebugger;
    Script1: TMenuItem;
    Run1: TMenuItem;
    Debug1: TMenuItem;
    AdvBasicMemoStyler1: TAdvBasicMemoStyler;
    Scripter: TatBasicScripter;
    procedure Debug1Click(Sender: TObject);
    procedure Run1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

type
  TatAdvMemoDispatcher = class(TatEventDispatcher)
  private
    procedure _TGutterClickEvent(Sender: TObject; LineNo: Integer);
  end;

procedure TatAdvMemoDispatcher._TGutterClickEvent(Sender: TObject; LineNo: Integer);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGutterClickEvent(BeforeCall)(Sender,LineNo);

    if Assigned(Scripter) and (RoutineName>'') then
      Scripter.ExecuteSubroutine(RoutineName,
         VarArrayOf( [integer(Sender),LineNo] ));

    if AssignedMethod(AfterCall) then
      TGutterClickEvent(AfterCall)(Sender,LineNo);
  end;
end;

procedure TForm1.Debug1Click(Sender: TObject);
begin
   Debugger.Execute;
end;

procedure TForm1.Run1Click(Sender: TObject);
begin
   DefineEventAdapter(TypeInfo(TGutterClickEvent),TatAdvMemoDispatcher,
      @TatAdvMemoDispatcher._TGutterClickEvent);

   Scripter.AddComponents(Self);
   Scripter.SourceCode := Memo1.Lines;
   Scripter.Execute;
end;
    
end.
