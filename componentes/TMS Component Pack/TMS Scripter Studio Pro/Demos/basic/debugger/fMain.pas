unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, AdvMemo, Advmps, StdCtrls, atScript, atPascal, ComCtrls,
  ToolWin, ImgList, ExtCtrls, Menus, ActnList, atBasic, advmbs;

type
  TForm1 = class(TForm)
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    btRun: TToolButton;
    btPause: TToolButton;
    ToolButton14: TToolButton;
    btShowExec: TToolButton;
    btReset: TToolButton;
    btStepOver: TToolButton;
    btTraceInto: TToolButton;
    btReturn: TToolButton;
    btRunTo: TToolButton;
    ToolButton15: TToolButton;
    btEvaluate: TToolButton;
    btToggleBreak: TToolButton;
    btViewBreak: TToolButton;
    btAddWatch: TToolButton;
    btViewWatch: TToolButton;
    Panel1: TPanel;
    AdvMemo1: TAdvMemo;
    ActionList1: TActionList;
    acRun: TAction;
    acStepOver: TAction;
    acTraceInto: TAction;
    acRunTo: TAction;
    acReturn: TAction;
    acShowExec: TAction;
    acPause: TAction;
    acReset: TAction;
    acEvaluate: TAction;
    acAddWatch: TAction;
    acViewWatch: TAction;
    acToggleBreak: TAction;
    acViewBreak: TAction;
    MainMenu1: TMainMenu;
    Run1: TMenuItem;
    Runscript1: TMenuItem;
    N2: TMenuItem;
    Stepover1: TMenuItem;
    Traceinto1: TMenuItem;
    Runtocursor1: TMenuItem;
    Rununtilreturn1: TMenuItem;
    Showexecutionpoint1: TMenuItem;
    Scriptpause1: TMenuItem;
    Scriptreser1: TMenuItem;
    N1: TMenuItem;
    Customexecute1: TMenuItem;
    Addwatch1: TMenuItem;
    Viewwatches1: TMenuItem;
    Addbreakpoint1: TMenuItem;
    Viewbreakpoints1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Run2: TMenuItem;
    N3: TMenuItem;
    Stepover2: TMenuItem;
    Traceinto2: TMenuItem;
    Runtocursor2: TMenuItem;
    Rununtilreturn2: TMenuItem;
    Showexecutionpoint2: TMenuItem;
    Pause1: TMenuItem;
    Scriptreset1: TMenuItem;
    N4: TMenuItem;
    Evaluatemodify1: TMenuItem;
    Addwatch2: TMenuItem;
    Viewwatches2: TMenuItem;
    Togglebreakpoint1: TMenuItem;
    Viewbreakpoints2: TMenuItem;
    atBasicScripter1: TatBasicScripter;
    AdvBasicMemoStyler1: TAdvBasicMemoStyler;
    procedure btRunClick(Sender: TObject);
    procedure btPauseClick(Sender: TObject);
    procedure btStepOverClick(Sender: TObject);
    procedure btTraceIntoClick(Sender: TObject);
    procedure btRunToClick(Sender: TObject);
    procedure btReturnClick(Sender: TObject);
    procedure AdvMemo1GutterClick(Sender: TObject; LineNo: Integer);
    procedure btToggleBreakClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure btShowExecClick(Sender: TObject);
    procedure btResetClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AdvMemo1Change(Sender: TObject);
  private
    FModified : boolean;
    FLastModifiedAnswer : TModalResult;

    procedure CheckRunningMode;
    procedure PrepareScriptToRun;
    procedure ToggleBreakAt(line: integer);
    procedure SetBreakPoints;
    { Private declarations }
  public
    { Public declarations }
    procedure DisplayLineAttr(inst:pSimplifiedCode);
    procedure ScriptDebug(Sender: TObject);
    procedure ShowExecutionPoint;
    procedure ActionControl;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.DisplayLineAttr(inst:pSimplifiedCode);
var line:integer;
begin
  { extract source line from instruction debuginfo }
  line := LineNumberFromInstruction(inst);

  if Assigned(inst) and (line>-1) and (line<AdvMemo1.Lines.Count) then
  begin
    { generated executable code }
    if InstructionIsExecutable(atBasicScripter1,inst) then
      AdvMemo1.Executable[line] := True;
  end;
end;

procedure TForm1.btRunClick(Sender: TObject);
begin
  CheckRunningMode;

  with AtBasicScripter1 do
  begin
    Paused := False;
    Running := True;
  end;
end;

procedure TForm1.btPauseClick(Sender: TObject);
begin
  AtBasicScripter1.Paused := True;
end;

procedure TForm1.btStepOverClick(Sender: TObject);
begin
  CheckRunningMode;

  with AtBasicScripter1 do
  begin
    Paused := True;
    if not Running then
       Running := True
    else
       DebugStepOverLine;
  end;
end;

procedure TForm1.btTraceIntoClick(Sender: TObject);
begin
  CheckRunningMode;

  with AtBasicScripter1 do
  begin
    Paused := True;
    if not Running then
       Running := True
    else
       DebugTraceIntoLine;
  end;
end;

procedure TForm1.ShowExecutionPoint;
var curline : integer;
begin
  curline := LineNumberFromInstruction( AtBasicScripter1.NextInstruction );
  if curline<>AdvMemo1.ActiveLine then // just avoid memo flicking
    AdvMemo1.ActiveLine := curline;
end;

procedure TForm1.btRunToClick(Sender: TObject);
begin
  CheckRunningMode;

  AtBasicScripter1.DebugRunToLine( AdvMemo1.CurY + 1 );
end;

procedure TForm1.btReturnClick(Sender: TObject);
begin
  CheckRunningMode;

  AtBasicScripter1.DebugRunUntilReturn;
end;

procedure TForm1.btShowExecClick(Sender: TObject);
begin
  ShowExecutionPoint;
end;

procedure TForm1.btResetClick(Sender: TObject);
begin
  AtBasicScripter1.Halt;
  ShowExecutionPoint;
end;

procedure TForm1.ActionList1Update(Action: TBasicAction;var Handled: Boolean);
begin
  ActionControl;
end;

procedure TForm1.ActionControl;
begin
  with AtBasicScripter1 do
  begin
    acRun.Enabled := not Running or Paused;
    acPause.Enabled := Running and not Paused;
    acStepOver.Enabled := not Running or Paused;
    acTraceInto.enabled := not Running or Paused;
    acRunTo.enabled := not Running or Paused;
    acReturn.enabled := Running and Paused;
    acShowExec.enabled := Running and Paused;
    acReset.enabled := Running;
    acEvaluate.enabled := Running and Paused;
    acAddWatch.enabled := False;
    acViewWatch.enabled := False;
    acToggleBreak.enabled := True;
    acViewBreak.enabled := False;
  end;
end;

procedure TForm1.AdvMemo1GutterClick(Sender: TObject; LineNo: Integer);
begin
  ToggleBreakAt(LineNo);
end;

procedure TForm1.btToggleBreakClick(Sender: TObject);
begin
   ToggleBreakAt(AdvMemo1.CurY);
end;

procedure TForm1.ToggleBreakAt(line:integer);
begin
   atBasicScripter1.DebugToggleBreakLine(line + 1);
   AdvMemo1.BreakPoint[line] := not AdvMemo1.BreakPoint[line];
end;

procedure TForm1.CheckRunningMode;
begin
   { is script source was modified then ask user to recompile and rerun }
   
   if FModified and (FLastModifiedAnswer<>mrNo) then
      if AtBasicScripter1.Running then
      begin
        FLastModifiedAnswer := MessageDlg('Script source has been modified. Start again?',mtConfirmation,[mbYes,mbNo,mbCancel],0);
        case FLastModifiedAnswer of
          mrYes : PrepareScriptToRun;
          mrCancel: Abort;
        end;
      end
      else
        PrepareScriptToRun;
end;

procedure TForm1.PrepareScriptToRun;
var inst : pSimplifiedCode;
    c : integer;
begin
  with AtBasicScripter1 do
  begin
    Halt;

    { reassign script source }
    SourceCode.Assign(AdvMemo1.Lines);

    { compile all source }
    Compile;

    { solve absolute addressing before to handle break points }
    SolveAbsoluteAddressing;

    { set all break points }
    SetBreakPoints;

    { clear memo debug styles }
    AdvMemo1.ActiveLine := -1;
    with AdvMemo1, Lines do
       for c:=0 to Count-1 do
          AdvMemo1.Executable[c] := False;

    { update script memo with compilation results }
    if not ExpandedDebugInfo then ExpandDebugInfo;
    inst := FirstInstruction;
    while inst <> nil do
    begin
      DisplayLineAttr(inst);
      inst := inst^.Next;
    end;

    FModified := false;
  end;
end;

procedure TForm1.SetBreakPoints;
var c: integer;
begin
   { set break point based on memo break points }
   with AdvMemo1, Lines do
     for c:=0 to Count-1 do
       if BreakPoint[c] then
         if not Assigned(atBasicScripter1.DebugToggleBreakLine(c+1)) then
           BreakPoint[c] := False;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  with AtBasicScripter1 do
  begin
    { activate scripter on debug mode }
    OnDebugHook := ScriptDebug;
    OnRunningChanged := ScriptDebug;
    OnPauseChanged := ScriptDebug;
  end;

  PrepareScriptToRun;
end;

procedure TForm1.ScriptDebug(Sender: TObject);
begin
  Application.ProcessMessages;
  ShowExecutionPoint;
  ActionControl;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   { confirm script debugging termination on close }
   if atBasicScripter1.Running and
     (MessageDlg('Script debug session in progress. Terminate?',mtConfirmation,[mbYes,mbNo,mbCancel],0)<>mrYes) then
     Abort
   else
     atBasicScripter1.Halt;
end;

procedure TForm1.AdvMemo1Change(Sender: TObject);
begin
  FModified := true;
  FLastModifiedAnswer := mrNone;
end;

end.
