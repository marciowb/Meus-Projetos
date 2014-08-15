{***************************************************************************}
{ Scripter Studio Components for Delphi & C++Builder                        }
{ version 4.7 (Std), 1.7 (Pro)                                              }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ For information about version history, check the section "What's New"     }
{ at Scripter Studio manual.                                                }                                                                         
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit atScriptDebugForm;

{$I ASCRIPT.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, AdvMemo, Advmps, StdCtrls, atScript, atPascal, ComCtrls,
  ToolWin, ImgList, ExtCtrls, Menus, ActnList, advmbs, atBasic,
  FormScript, fWatchViewer, fWatchProperties
  {$IFDEF DELPHI6_LVL}
  , Variants
  {$ENDIF}
  ;

const
  WM_DEBUGACTION = WM_USER + 1;

type
  TDebugAction = (daNone, daRun, daTraceInto, daStepOver, daReturn, daRunTo);

  TDebugForm = class(TForm)
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
    AdvPascalMemoStyler1: TAdvPascalMemoStyler;
    AdvBasicMemoStyler1: TAdvBasicMemoStyler;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    pmRoutines: TPopupMenu;
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
    procedure FormDestroy(Sender: TObject);
    procedure acAddWatchExecute(Sender: TObject);
    procedure acViewWatchExecute(Sender: TObject);
    procedure AdvMemo1HintForToken(Sender: TObject; X, Y: Integer;
      AValue: String; var AHint: String; var Show: Boolean);
    procedure AdvMemo1CursorChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AdvMemo1OverwriteToggle(Sender: TObject; var Allow: Boolean);
    procedure AdvMemo1GetAutoCompletionList(Sender: TObject;
      AToken: String; AList: TStringList);
  private
    FOldDebugHook: TNotifyEvent;
    FOldRunningChanged: TNotifyEvent;
    FOldPauseChanged: TNotifyEvent;
    FOnCompileError: TScriptErrorEvent;
    FRoutineToRun: string;

    FModified : boolean;
    FLastModifiedAnswer : TModalResult;
    FScripter: TatCustomScripter;
    fmWatchViewer: TfmWatchViewer;
    FShowErrors: boolean;
    FUpdateWatches: boolean;
    FDebugAction: TDebugAction;
    FPreviousScript: TatScript;
    FUpdatingMemo: integer;

    procedure CheckRunningMode;
    procedure PrepareScriptToRun;
    procedure ToggleBreakAt(line: integer);
    procedure SetBreakPoints;
    procedure SetScripter(AScripter: TatCustomScripter);
    procedure HookScripterEvents(AScripter: TatCustomScripter);
    procedure UnhookScripterEvents(AScripter: TatCustomScripter);
    procedure CheckHalted;
    procedure WMDebugAction(var Message: TMessage); message WM_DEBUGACTION;
    procedure UpdateMenuItems;
    procedure RoutinesMenuClick(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
    procedure DisplayLineAttr(inst:pSimplifiedCode);
    procedure ScriptDebug(Sender: TObject);
    procedure ScriptError(Sender: TObject;
      var msg: String; row, col: Integer; var ShowException: Boolean);
    procedure ShowExecutionPoint;
    procedure ActionControl;
    property RoutineToRun: string read FRoutineToRun write FRoutineToRun;
  published
    property Scripter: TatCustomScripter read FScripter write SetScripter;
    property ShowErrors: boolean read FShowErrors write FShowErrors;
  end;

var
  DebugForm: TDebugForm;

implementation

{$R *.dfm}

resourcestring
  SMainBlock = '(main block)';

function RemoveAccKey(const S: string): string;
begin
  {This function removes the '&' from menu caption. It's needed due a bug in TToolBar,
   which always includes an accelerator key is submenus, regardless the state of AutoHotKeys prop}
  result := S;
  while Pos('&', result) > 0 do
    Delete(result, Pos('&', result), 1);
end;

procedure TDebugForm.DisplayLineAttr(inst:pSimplifiedCode);
var line:integer;
begin
  { extract source line from instruction debuginfo }
  line := LineNumberFromInstruction(inst);

  AdvMemo1.BeginUpdate;
  if Assigned(inst) and (line>-1) and (line<AdvMemo1.Lines.Count) then
  begin
    { generated executable code }
    if InstructionIsExecutable(Scripter,inst) then
      AdvMemo1.Executable[line] := True;
  end;
  AdvMemo1.EndUpdate;  
end;

procedure TDebugForm.btRunClick(Sender: TObject);
begin
  FUpdateWatches := true;
  FDebugAction := daRun;
  CheckRunningMode;

  with Scripter do
  begin
    Paused := False;
    if not Running then
      ExecuteSubRoutine(FRoutineToRun);
    CheckHalted;
  end;
end;

procedure TDebugForm.btPauseClick(Sender: TObject);
begin
  FUpdateWatches := true;
  Scripter.Paused := True;
end;

procedure TDebugForm.btStepOverClick(Sender: TObject);
begin
  FUpdateWatches := true;
  FDebugAction := daStepOver;
  CheckRunningMode;

  with Scripter do
  begin
    Paused := True;
    if not Running then
    begin
      ExecuteSubRoutine(FRoutineToRun);
      CheckHalted;
    end
    else
       DebugStepOverLine;
  end;
end;

procedure TDebugForm.btTraceIntoClick(Sender: TObject);
begin
  FUpdateWatches := true;
  FDebugAction := daTraceInto;
  CheckRunningMode;

  with Scripter do
  begin
    Paused := True;
    if not Running then
    begin
      ExecuteSubRoutine(FRoutineToRun);
      CheckHalted;
    end
    else
       DebugTraceIntoLine;
  end;
end;

procedure TDebugForm.CheckHalted;
begin
  if FDebugAction <> daNone then
  begin
    PostMessage(Handle, WM_DEBUGACTION, Ord(FDebugAction), 0);
    FDebugAction := daNone;
  end;
end;

procedure TDebugForm.WMDebugAction(var Message: TMessage);
begin
  Case TDebugAction(Message.wParam) of
    daRun: btRunClick(nil);
    daTraceInto: btTraceIntoClick(nil);
    daStepOver: btStepOverClick(nil);
    daReturn: btReturnClick(nil);
    daRunTo: btRunToClick(nil);
  end;
end;

procedure TDebugForm.ShowExecutionPoint;
var
  curline : integer;
begin
  if FPreviousScript <> Scripter.CurrentScript then
  begin
    Inc(FUpdatingMemo);
    try
      FPreviousScript := Scripter.CurrentScript;
      AdvMemo1.Lines.Assign(Scripter.CurrentScript.SourceCode);
    finally
      Dec(FUpdatingMemo);
    end;
  end;

  curline := LineNumberFromInstruction( Scripter.NextInstruction );
  if curline <> AdvMemo1.ActiveLine then // just avoid memo flicking
  begin
    AdvMemo1.ActiveLine := curline;
    if fmWatchViewer.Visible then
      fmWatchViewer.Refresh;
  end;
  if FUpdateWatches then
  begin
    if fmWatchViewer.Visible then
      fmWatchViewer.Refresh;
    FUpdateWatches := false;
  end;
end;

procedure TDebugForm.btRunToClick(Sender: TObject);
begin
  FUpdateWatches := true;
  FDebugAction := daRunTo;
  CheckRunningMode;

  Scripter.DebugRunToLine( AdvMemo1.CurY + 1 );
  CheckHalted;
end;

procedure TDebugForm.btReturnClick(Sender: TObject);
begin
  FUpdateWatches := true;
  FDebugAction := daReturn;
  CheckRunningMode;

  Scripter.DebugRunUntilReturn;
  CheckHalted;
end;

procedure TDebugForm.btShowExecClick(Sender: TObject);
begin
  ShowExecutionPoint;
end;

procedure TDebugForm.btResetClick(Sender: TObject);
begin
  FUpdateWatches := true;
  Scripter.Halt;
  ShowExecutionPoint;
end;

procedure TDebugForm.ActionList1Update(Action: TBasicAction;var Handled: Boolean);
begin
  ActionControl;
end;

procedure TDebugForm.ActionControl;
begin
  with Scripter do
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
    acAddWatch.enabled := True;
    acViewWatch.enabled := True;
    acToggleBreak.enabled := True;
    acViewBreak.enabled := False;
  end;
end;

procedure TDebugForm.AdvMemo1GutterClick(Sender: TObject; LineNo: Integer);
begin
  if AdvMemo1.Executable[LineNo] then
    ToggleBreakAt(LineNo);
end;

procedure TDebugForm.btToggleBreakClick(Sender: TObject);
begin
  if AdvMemo1.Executable[AdvMemo1.CurY] then
    ToggleBreakAt(AdvMemo1.CurY);
end;

procedure TDebugForm.ToggleBreakAt(line:integer);
begin
   Scripter.DebugToggleBreakLine(line + 1);
   AdvMemo1.BreakPoint[line] := not AdvMemo1.BreakPoint[line];
end;

procedure TDebugForm.CheckRunningMode;
begin
   { is script source was modified then ask user to recompile and rerun }

   if FModified and (FLastModifiedAnswer<>mrNo) then
      if Scripter.Running then
      begin
        FLastModifiedAnswer := MessageDlg('Script source has been modified. Start again?',mtConfirmation,[mbYes,mbNo,mbCancel],0);
        case FLastModifiedAnswer of
          //mrYes : PrepareScriptToRun;
          mrYes :
            begin
              Scripter.Halt;
              Abort;
            end;
          mrCancel:
            begin
              FDebugAction := daNone;
              Abort;
            end;
        end;
      end
      else
        PrepareScriptToRun;
   FDebugAction := daNone;
end;

procedure TDebugForm.PrepareScriptToRun;
var inst : pSimplifiedCode;
    c : integer;
    MI : TMenuItem;
begin
  if not Assigned(Scripter) then Exit;

  with Scripter do
  begin
    if not Running then
    begin
      { reassign script source }
      SourceCode.Assign(AdvMemo1.Lines);

      { compile all source }
      Compile;

      { solve absolute addressing before to handle break points }
      SolveAbsoluteAddressing;

      { update script memo with compilation results }
      if not ExpandedDebugInfo then ExpandDebugInfo;
    end;

    { set all break points }
    SetBreakPoints;

    { clear memo debug styles }
    AdvMemo1.ActiveLine := -1;

    AdvMemo1.BeginUpdate;

    with AdvMemo1, Lines do
       for c := 0 to Count - 1 do
          AdvMemo1.Executable[c] := False;
    AdvMemo1.EndUpdate;

    inst := FirstInstruction;
    while inst <> nil do
    begin
      DisplayLineAttr(inst);
      inst := inst^.Next;
    end;

    FModified := false;

    pmRoutines.Items.Clear;
    MI := TMenuItem.Create(pmRoutines);
    MI.Caption := SMainBlock;
    MI.OnClick := RoutinesMenuClick;
    pmRoutines.Items.Add(MI);
    for c := 0 to Scripter.ScriptInfo.Routines.Count - 1 do
      if (Scripter.ScriptInfo.Routines[c].Name <> '___MAIN___') then
      begin
        MI := TMenuItem.Create(pmRoutines);
        MI.AutoHotKeys := maManual;
        MI.Caption := Scripter.ScriptInfo.Routines[c].Name;
        Mi.OnClick := RoutinesMenuClick;
        pmRoutines.Items.Add(MI);
      end;
    UpdateMenuItems;
  end;
end;

procedure TDebugForm.RoutinesMenuClick(Sender: TObject);
begin
  if Sender is TMenuItem then
  begin                                    
    if RemoveAccKey(TMenuItem(Sender).Caption) = SMainBlock then
      FRoutineToRun := ''
    else
      FRoutineToRun := RemoveAccKey(TMenuItem(Sender).Caption);
    UpdateMenuItems;                             
  end;
end;

procedure TDebugForm.UpdateMenuItems;
var
  c: integer;
  MI: TMenuItem;
begin
  if Scripter.Compiled then
  begin
    if not Assigned(Scripter.ScriptInfo.RoutineByName(FRoutineToRun)) then
      FRoutineToRun := '';
    for c := 0 to pmRoutines.Items.Count - 1 do
    begin
      MI := pmRoutines.Items[c];
      if ((FRoutineToRun = '') and (c = 0)) or
        (AnsiCompareText(RemoveAccKey(pmRoutines.Items[c].Caption), FRoutineToRun) = 0) then
      begin
        MI.Checked := true;
      end else
      begin
        MI.Checked := false;
      end;
    end;
  end;
end;

procedure TDebugForm.SetBreakPoints;
var c: integer;
begin
   { set break point based on memo break points }

   with AdvMemo1, Lines do
     for c:=0 to Count-1 do
       if BreakPoint[c] then
         if not Assigned(Scripter.DebugToggleBreakLine(c+1)) then
            BreakPoint[c] := false;
end;

procedure TDebugForm.FormCreate(Sender: TObject);
begin
  FRoutineToRun := '';
  FDebugAction := daNone;
  FUpdateWatches := false;
  HookScripterEvents(Scripter);
  PrepareScriptToRun;

  fmWatchViewer := TfmWatchViewer.Create(self);
  fmWatchViewer.Scripter := Scripter;
end;

procedure TDebugForm.ScriptDebug(Sender: TObject);
begin
  ShowExecutionPoint;
  ActionControl;
  Application.HandleMessage;
end;

procedure TDebugForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   { confirm script debugging termination on close }
   if Scripter.Running and
     (MessageDlg('Script debug session in progress. Terminate?',mtConfirmation,[mbYes,mbNo,mbCancel],0)<>mrYes) then
     Abort
   else
     Scripter.Halt;
   Action := caFree;
end;

procedure TDebugForm.AdvMemo1Change(Sender: TObject);
begin
  if FUpdatingMemo = 0 then
  begin
    FModified := true;
    FLastModifiedAnswer := mrNone;
  end;
end;

procedure TDebugForm.HookScripterEvents(AScripter: TatCustomScripter);
begin
   if ASsigned(AScripter) then with AScripter do
   begin
      { activate scripter on debug mode }
      FOldDebugHook:=OnDebugHook;
      FOldRunningChanged:=OnRunningChanged;
      FOldPauseChanged:=OnPauseChanged;
      FOnCompileError:=OnCompileError;

      //OnDebugHook := ScriptDebug;
      OnSingleDebugHook := ScriptDebug;
      OnRunningChanged := ScriptDebug;
      OnPauseChanged := ScriptDebug;
      OnCompileError := ScriptError;
   end;
end;

procedure TDebugForm.UnhookScripterEvents(AScripter: TatCustomScripter);
begin
   if Assigned(AScripter) then with AScripter do
   begin
      OnDebugHook := FOldDebugHook;
      OnRunningChanged := FOldRunningChanged;
      OnPauseChanged := FOldPauseChanged;
      OnCompileError := FOnCompileError;
   end;
end;

procedure TDebugForm.SetScripter(AScripter: TatCustomScripter);
var
  e,k: integer;
  slist: TStringList;
begin
  if Assigned(AScripter) then
  begin
    if Assigned(FScripter) then
       UnhookScripterEvents(FScripter);

    FScripter := AScripter;
    AdvMemo1.Lines.Assign(AScripter.SourceCode);

    if FScripter.CurrentScript is TatPascalScript then
      AdvMemo1.SyntaxStyles := AdvPascalMemoStyler1;

    if FScripter.CurrentScript is TatBasicScript then
      AdvMemo1.SyntaxStyles := AdvBasicMemoStyler1;

    HookScripterEvents(Scripter);

    slist := CreateCodeCompletionList(FScripter,'',0,e,k);
    try
      AdvMemo1.SyntaxStyles.AutoCompletion.Assign(slist);
    finally
      slist.free;
    end;

    fmWatchViewer.Scripter := Scripter;

    try
      PrepareScriptToRun;
    except
    end;

  end;
end;

procedure TDebugForm.ScriptError(Sender: TObject; var msg: String; row,
  col: Integer; var ShowException: Boolean);
begin
  if ShowErrors then
  begin
    MessageDlg(msg,mtError,[mbok],0);
    AdvMemo1.CurX := col;
    AdvMemo1.CurY := row - 1;
  end;  
end;

procedure TDebugForm.FormDestroy(Sender: TObject);
begin
   UnhookScripterEvents(Scripter);
   fmWatchViewer.Free;
end;

procedure TDebugForm.acAddWatchExecute(Sender: TObject);
begin
  fmWatchViewer.Show;
  fmWatchViewer.AddWatch;
end;

procedure TDebugForm.acViewWatchExecute(Sender: TObject);
begin
  fmWatchViewer.Show;
end;

procedure TDebugForm.AdvMemo1HintForToken(Sender: TObject; X, Y: Integer;
  AValue: String; var AHint: String; var Show: Boolean);
var
  v: variant;
  s: string;
  {$IFDEF DELPHI6_LVL}
  vt: TVarType;
  {$ELSE}
  vt: Integer;
  {$ENDIF}
begin
  Show := false;

  ShowErrors := False;
  try
    v := EvaluateWatch(Scripter,AValue);

    Show := v <> null;

    if v <> null then
    begin
      s := v;
      AHint := 'value = ' + s;
      vt := vartype(v);
      case vt of
      varInteger: AHint := AHint + ': integer';
      varDouble: AHint := AHint + ': double';
      varString: AHint := AHint + ': string';
      varByte: AHint := AHint + ': byte';
      {$IFDEF DELPHI6_LVL}
      varWord: AHint := AHint + ': word';
      {$ENDIF}
      varBoolean: AHint := AHint + ': boolean';
      varDate: AHint := AHint + ': TDateTime';
      varArray: AHint := AHint + ': array';
      end;
    end;
  except
  end;

  ShowErrors := True    
end;

procedure TDebugForm.AdvMemo1CursorChange(Sender: TObject);
begin
  StatusBar1.Panels[0].Text := IntToStr(AdvMemo1.CurX) + ':'+ IntToStr(AdvMemo1.CurY);
end;

procedure TDebugForm.Timer1Timer(Sender: TObject);
begin
  with statusbar1 do
  begin
    Panels[2].Text := TimeToStr(Now) + ' ' + DateToStr(Now);

    if getkeystate(vk_numlock) and $1=$1 then
      Panels[3].Text:='NUM'
    else
      Panels[3].Text:='';
    if getkeystate(vk_capital) and $1=$1 then
      Panels[4].Text:='CAP'
    else
      Panels[4].Text:='';
    if getkeystate(vk_scroll) and $1=$1 then
      Panels[5].Text:='SCRL'
     else
      Panels[5].Text:='';
  end;

end;

procedure TDebugForm.FormShow(Sender: TObject);
begin
  ShowErrors := true;
  StatusBar1.Panels[0].Text := IntToStr(AdvMemo1.CurX) + ':'+ IntToStr(AdvMemo1.CurY);
  if AdvMemo1.Overwrite then
    statusbar1.Panels[1].Text := 'Overwrite'
  else
    statusbar1.Panels[1].Text := 'Insert';
end;

procedure TDebugForm.AdvMemo1OverwriteToggle(Sender: TObject;
  var Allow: Boolean);
begin
  if not AdvMemo1.Overwrite then
    statusbar1.Panels[1].Text := 'Overwrite'
  else
    statusbar1.Panels[1].Text := 'Insert';
end;

procedure TDebugForm.AdvMemo1GetAutoCompletionList(Sender: TObject;
  AToken: String; AList: TStringList);
var
  e,l: integer;
  tp: integer;
  sl: tstringlist;
  s,r:string;
  no: TObject;

begin

  AdvMemo1.TextFromPos(AdvMemo1.CurX,AdvMemo1.CurY,tp);
  sl := CreateCodeCompletionList(Scripter,
    AdvMemo1.Lines.Text,tp + 1,e,l);

  for e := 1 to sl.Count do
  begin
    s := sl.Strings[e - 1];
    l := pos(' ',s);
    if l > 0 then
    begin
      r := copy(s,1,l - 1);
      delete(s,1,l);
    end
    else
      r := '';

    while pos('.',s) > 0 do
    begin
      delete(s,1,pos('.',s));
    end;

    case integer(sl.Objects[e - 1]) of
    0: sl.Strings[e - 1] := 'property ' + s;
    1,17: sl.Strings[e - 1] := 'procedure ' + s;
    2,18: sl.Strings[e - 1] := 'function ' + s;
    3,19: sl.Strings[e - 1] := 'event ' + s;
    16: sl.Strings[e - 1] := 'var ' + s
    else
      sl.Strings[e - 1] := s;
    end;
    // (ttNone, ttVar, ttProp, ttEvent, ttMethod, ttFunc, ttProc);
    case integer(sl.Objects[e - 1]) of
    0: no := TObject(ttProp);
    1: no := TObject(ttMethod);
    2: no := TObject(ttMethod);
    3: no := TObject(ttEvent);
    16: no := TObject(ttVar);
    17: no := TObject(ttProc);
    18: no := TObject(ttFunc);
    19: no := TObject(ttEvent)
    else
      no := TObject(ttNone);
    end;
    sl.Objects[e - 1] := no;
  end;
  AList.AddStrings(sl);
  sl.Free;

end;


end.
