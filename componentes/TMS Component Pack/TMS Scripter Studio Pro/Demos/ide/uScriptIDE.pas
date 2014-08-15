unit uScriptIDE;

{$I ASCRIPT.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, AdvMemo, Advmps, StdCtrls, atScript, atPascal, ComCtrls,
  ToolWin, ImgList, ExtCtrls, Menus, ActnList, advmbs, atBasic,
  {$IFDEF DELPHI6_LVL}
  Variants,
  {$ENDIF}
  FormScript, fWatchViewer, fWatchProperties, uScriptLib, atMemoInterface,
  ScriptCtrls;

const
  WM_DEBUGACTION = WM_USER + 1;

  IDECAPTION = 'Scripter Studio IDE';

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
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    atPascalScripter1: TatPascalScripter;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    File1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    New1: TMenuItem;
    acFileNew: TAction;
    acFileOpen: TAction;
    acFileSave: TAction;
    acCopy: TAction;
    acCut: TAction;
    acPaste: TAction;
    Edit1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Help1: TMenuItem;
    About1: TMenuItem;
    acAbout: TAction;
    atMemoInterface1: TatMemoInterface;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    acUndo: TAction;
    acRedo: TAction;
    View1: TMenuItem;
    Console1: TMenuItem;
    Splitter1: TSplitter;
    Clearconsole1: TMenuItem;
    acSaveAs: TAction;
    Saveas1: TMenuItem;
    FindDialog: TAdvMemoFindDialog;
    ReplaceDialog: TAdvMemoFindReplaceDialog;
    acFind: TAction;
    acReplace: TAction;
    N5: TMenuItem;
    Find1: TMenuItem;
    Replace1: TMenuItem;
    Memo1: TMemo;
    Splitter2: TSplitter;
    acCodeExplorer: TAction;
    Codeexplorer1: TMenuItem;
    SourceExplorer1: TSourceExplorer;
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
    procedure acFileNewExecute(Sender: TObject);
    procedure acFileOpenExecute(Sender: TObject);
    procedure acFileSaveExecute(Sender: TObject);
    procedure acCopyExecute(Sender: TObject);
    procedure acCutExecute(Sender: TObject);
    procedure acPasteExecute(Sender: TObject);
    procedure acAboutExecute(Sender: TObject);
    procedure acUndoExecute(Sender: TObject);
    procedure acRedoExecute(Sender: TObject);
    procedure Console1Click(Sender: TObject);
    procedure Clearconsole1Click(Sender: TObject);
    procedure acSaveAsExecute(Sender: TObject);
    procedure acFindExecute(Sender: TObject);
    procedure acReplaceExecute(Sender: TObject);
    procedure acCodeExplorerExecute(Sender: TObject);
    procedure acCodeExplorerUpdate(Sender: TObject);

  private
    FOldDebugHook: TNotifyEvent;
    FOldRunningChanged: TNotifyEvent;
    FOldPauseChanged: TNotifyEvent;
    FOnCompileError: TScriptErrorEvent;

    FModified : boolean;
    FLastModifiedAnswer : TModalResult;
    fmWatchViewer: TfmWatchViewer;
    FShowErrors: boolean;
    FUpdateWatches: boolean;
    FDebugAction: TDebugAction;
    FFileName: string;
    procedure CheckRunningMode;
    procedure PrepareScriptToRun;
    procedure ToggleBreakAt(line: integer);
    procedure SetBreakPoints;
    procedure HookScripterEvents(AScripter: TatCustomScripter);
    procedure UnhookScripterEvents(AScripter: TatCustomScripter);
    procedure CheckHalted;
    procedure WMDebugAction(var Message: TMessage); message WM_DEBUGACTION;
    procedure OpenScriptFile(AFileName: string);
    procedure UpdateCaption;
    procedure RunningChanged(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
    procedure DisplayLineAttr(inst:pSimplifiedCode);
    procedure ScriptDebug(Sender: TObject);
    procedure ScriptError(Sender: TObject;
      var msg: String; row, col: Integer; var ShowException: Boolean);
    procedure ShowExecutionPoint;
    procedure ActionControl;
    procedure MyPrint(AMachine: TatVirtualMachine);
  published
    property ShowErrors: boolean read FShowErrors write FShowErrors;
  end;

var
  DebugForm: TDebugForm;

implementation

{$R *.dfm}

procedure TDebugForm.DisplayLineAttr(inst:pSimplifiedCode);
var line:integer;
begin
  { extract source line from instruction debuginfo }
  line := LineNumberFromInstruction(inst);

  if Assigned(inst) and (line>-1) and (line<AdvMemo1.Lines.Count) then
  begin
    { generated executable code }
    if InstructionIsExecutable(atPascalScripter1,inst) then
      AdvMemo1.Executable[line] := True;
  end;
end;

procedure TDebugForm.btRunClick(Sender: TObject);
begin

  FUpdateWatches := true;
  FDebugAction := daRun;
  CheckRunningMode;

  with atPascalScripter1 do
  begin
    Paused := False;
    Running := True;
    CheckHalted;
  end;
end;

procedure TDebugForm.btPauseClick(Sender: TObject);
begin
  FUpdateWatches := true;
  atPascalScripter1.Paused := True;
end;

procedure TDebugForm.btStepOverClick(Sender: TObject);
begin
  FUpdateWatches := true;
  FDebugAction := daStepOver;
  CheckRunningMode;
  with atPascalScripter1 do
  begin
    Paused := True;
    if not Running then
    begin
       Running := True;
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
  with atPascalScripter1 do
  begin
    Paused := True;
    if not Running then
    begin
       Running := True;
       CheckHalted;
    end
    else
       DebugTraceIntoLine;
  end;
end;

procedure TDebugForm.ShowExecutionPoint;
var
  curline : integer;
begin
  if not AdvMemo1.ActiveLineSettings.ShowActiveLine then
    AdvMemo1.ActiveLineSettings.ShowActiveLine := true;
  curline := LineNumberFromInstruction(atPascalScripter1.NextInstruction );
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
  atPascalScripter1.DebugRunToLine( AdvMemo1.CurY + 1 );
  CheckHalted;
end;

procedure TDebugForm.btReturnClick(Sender: TObject);
begin
  FUpdateWatches := true;
  FDebugAction := daReturn;
  CheckRunningMode;
  atPascalScripter1.DebugRunUntilReturn;
  CheckHalted;
end;

procedure TDebugForm.btShowExecClick(Sender: TObject);
begin
  ShowExecutionPoint;
end;

procedure TDebugForm.btResetClick(Sender: TObject);
begin
  FUpdateWatches := true;
  atPascalScripter1.Halt;
  ShowExecutionPoint;
  AdvMemo1.ActiveLineSettings.ShowActiveLine := false;
end;

procedure TDebugForm.ActionList1Update(Action: TBasicAction;var Handled: Boolean);
begin
  ActionControl;
end;

procedure TDebugForm.ActionControl;
begin
  with atPascalScripter1 do
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
   atPascalScripter1.DebugToggleBreakLine(line + 1);
   AdvMemo1.BreakPoint[line] := not AdvMemo1.BreakPoint[line];
end;

procedure TDebugForm.CheckRunningMode;
begin
   { is script source was modified then ask user to recompile and rerun }

   if FModified and (FLastModifiedAnswer<>mrNo) then
      if atPascalScripter1.Running then
      begin
        FLastModifiedAnswer := MessageDlg('Script source has been modified. Start again?',mtConfirmation,[mbYes,mbNo,mbCancel],0);
        case FLastModifiedAnswer of
          mrYes :
            begin
              atPascalScripter1.Halt;
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
begin
  if not Assigned(atPascalScripter1) then Exit;

  with atPascalScripter1 do
  begin
    SystemLibrary.DefineMethod('print',1,tkNone,nil,myprint);


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

procedure TDebugForm.SetBreakPoints;
var c: integer;
begin
   { set break point based on memo break points }

   with AdvMemo1, Lines do
     for c:=0 to Count-1 do
       if BreakPoint[c] then
         if not Assigned(atPascalScripter1.DebugToggleBreakLine(c+1)) then
            BreakPoint[c] := false;
end;

procedure TDebugForm.FormCreate(Sender: TObject);
begin
  ForceCurrentDirectory := true;

  FFileName := '';
  if ParamCount >= 1 then
    OpenScriptFile(ParamStr(1));

  FUpdateWatches := false;
  HookScripterEvents(atPascalScripter1);
  AddScripterLibraries(atPascalScripter1);
  PrepareScriptToRun;

  fmWatchViewer := TfmWatchViewer.Create(self);
  fmWatchViewer.Scripter := atPascalScripter1;
end;

procedure TDebugForm.ScriptDebug(Sender: TObject);
begin
  ShowExecutionPoint;
  ActionControl;
  Application.HandleMessage;
end;

procedure TDebugForm.RunningChanged(Sender: TObject);
begin
  ShowExecutionPoint;
  ActionControl;
end;

procedure TDebugForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   { confirm script debugging termination on close }
   if atPascalScripter1.Running and
     (MessageDlg('Script debug session in progress. Terminate?',mtConfirmation,[mbYes,mbNo,mbCancel],0)<>mrYes) then
     Abort                                                
   else
     atPascalScripter1.Halt;
end;

procedure TDebugForm.AdvMemo1Change(Sender: TObject);
begin
  FModified := true;
  FLastModifiedAnswer := mrNone;
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

      OnDebugHook := ScriptDebug;
      OnRunningChanged := RunningChanged;
      OnPauseChanged := RunningChanged;
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

procedure TDebugForm.ScriptError(Sender: TObject; var msg: String; row,
  col: Integer; var ShowException: Boolean);
begin
  if ShowErrors then
  begin
    MessageDlg(Format('Error at line %d: %s', [row, msg]), mtError, [mbok], 0);
    AdvMemo1.CurX := col;
    AdvMemo1.CurY := row - 1;
    ShowException := false;
  end;  
end;

procedure TDebugForm.FormDestroy(Sender: TObject);
begin
   UnhookScripterEvents(atPascalScripter1);
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
  ShowErrors := False;
  Show := atMemoInterface1.GetTokenHint(AValue,AHint);
  ShowErrors := True;

  Show := false;

  ShowErrors := False;
  try
    v := EvaluateWatch(atPascalScripter1,AValue);

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
      Panels[3].Text := 'NUM'
    else
      Panels[3].Text := '';
    if getkeystate(vk_capital) and $1=$1 then
      Panels[4].Text := 'CAP'
    else
      Panels[4].Text := '';
    if getkeystate(vk_scroll) and $1=$1 then
      Panels[5].Text := 'SCRL'
     else
      Panels[5].Text := '';
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
begin
  atmemointerface1.GetCompletion(AToken,AList);
end;

procedure TDebugForm.UpdateCaption;
begin
  Caption := Format('Script Studio IDE [%s]',[FFileName]);
end;

procedure TDebugForm.OpenScriptFile(AFileName: string);
begin
  if FileExists(AFileName) then
  begin
    advmemo1.Lines.LoadFromFile(AFileName);
    FFileName := AFileName;
    UpdateCaption;
  end;
end;

procedure TDebugForm.acFileNewExecute(Sender: TObject);
begin
  if MessageDlg('Discard current script and create a new blank script?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    AdvMemo1.Lines.Clear;
    FFileName := '';
  end;
  UpdateCaption;
end;

procedure TDebugForm.acFileOpenExecute(Sender: TObject);
begin
  if opendialog1.Execute then
    OpenScriptFile(opendialog1.FileName);
end;

procedure TDebugForm.acFileSaveExecute(Sender: TObject);
begin
  if FFileName = '' then
    if savedialog1.Execute then
      FFileName := savedialog1.FileName;
  if FFileName <> '' then
    advmemo1.Lines.SaveToFile(FFileName);
  UpdateCaption;
end;


procedure TDebugForm.acSaveAsExecute(Sender: TObject);
begin
  if savedialog1.Execute then
  begin
    FFileName := savedialog1.FileName;
    advmemo1.Lines.SaveToFile(FFileName);
    UpdateCaption;                                       
  end;
end;

procedure TDebugForm.acCopyExecute(Sender: TObject);
begin
  advmemo1.CopyToClipBoard;
end;

procedure TDebugForm.acCutExecute(Sender: TObject);
begin
  advmemo1.CutToClipBoard;
end;

procedure TDebugForm.acPasteExecute(Sender: TObject);
begin
  advmemo1.PasteFromClipBoard;
end;

procedure TDebugForm.acAboutExecute(Sender: TObject);
begin
  ShowMessage('Scripter Studio IDE'#13'© 2003-2007 tmssoftware.com');
end;

procedure TDebugForm.acUndoExecute(Sender: TObject);
begin
  advmemo1.Undo;
end;

procedure TDebugForm.acRedoExecute(Sender: TObject);
begin
  AdvMemo1.Redo;
end;

procedure TDebugForm.MyPrint(AMachine: TatVirtualMachine);
var
  s: string;
begin
  s := AMachine.GetInputArg(0);
  memo1.Lines.Add(s);
end;

procedure TDebugForm.Console1Click(Sender: TObject);
begin
  console1.Checked := not console1.Checked;
  memo1.Visible := console1.Checked;
  Splitter1.Visible := console1.Checked;
end;

procedure TDebugForm.Clearconsole1Click(Sender: TObject);
begin
  memo1.Lines.Clear;
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

procedure TDebugForm.acFindExecute(Sender: TObject);
begin
  FindDialog.Execute;
end;

procedure TDebugForm.acReplaceExecute(Sender: TObject);
begin
  ReplaceDialog.Execute;
end;

procedure TDebugForm.acCodeExplorerExecute(Sender: TObject);
begin
  SourceExplorer1.Visible := not SourceExplorer1.Visible;
  Splitter2.Visible := SourceExplorer1.Visible;
  Splitter2.Left := SourceExplorer1.Width;
end;

procedure TDebugForm.acCodeExplorerUpdate(Sender: TObject);
begin
  acCodeExplorer.Checked := SourceExplorer1.Visible;
end; 

end.
