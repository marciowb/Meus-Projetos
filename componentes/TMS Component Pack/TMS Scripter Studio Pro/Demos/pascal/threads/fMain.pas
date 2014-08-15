unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Math, SyncObjs,
  {$IFNDEF VER130}
  Variants,
  {$ENDIF}
  atScript, atPascal,
  AdvMemo, Advmps;


type
  TForm1 = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    btStopThread: TButton;
    btRunThread: TButton;
    AdvMemo1: TAdvMemo;
    AdvPascalMemoStyler1: TAdvPascalMemoStyler;
    procedure FormCreate(Sender: TObject);
    procedure btRunThreadClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btStopThreadClick(Sender: TObject);
  private
    { Private declarations }
    FThreads: TThreadList;
  public
    { Public declarations }
  end;

  TScriptExecutorThread = class(TThread)
  private
    FCanvas: TCanvas;
    FCanvasWidth: integer;
    FCanvasHeight: integer;
    FX: integer;
    FY: integer;
    FRadius: integer;
    FColor: integer;
    FScripter: TatCustomScripter;
    FScript: string;
    FErrorMessage: string;
    procedure PrepareEllipse(x, y, color, radius: integer);
    procedure InternalPlotEllipse;
    procedure InitScripter;
    procedure PlotEllipseProc(AMachine: TatVirtualMachine);
    procedure HandleThreadException;
  protected
    {Scripter wrapper methods}
    procedure GetTerminatedProc(AMachine: TatVirtualMachine);
    procedure GetCanvasWidthProc(AMachine: TatVirtualMachine);
    procedure GetCanvasHeightProc(AMachine: TatVirtualMachine);
    procedure PrepareEllipseProc(AMachine: TatVirtualMachine);
    procedure SinProc(AMachine: TatVirtualMachine);
    procedure CosProc(AMachine: TatVirtualMachine);
    procedure SleepProc(AMachine: TatVirtualMachine);
  public
    constructor Create;
    procedure Execute; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FThreads := TThreadList.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FThreads.Free;
end;

procedure TForm1.btRunThreadClick(Sender: TObject);
var
  AThread: TScriptExecutorThread;
begin
  AThread := TScriptExecutorThread.Create;
  With FThreads.LockList do
  try
    Add(AThread);
  finally
    FThreads.UnlockList;
  end;
  AThread.FCanvas := PaintBox1.Canvas;
  AThread.FScript := AdvMemo1.Lines.Text;
  AThread.FCanvasWidth := PaintBox1.Width;
  AThread.FCanvasHeight := PaintBox1.Height;
  AThread.Resume;
end;

procedure TForm1.btStopThreadClick(Sender: TObject);
begin
  With FThreads.LockList do
  try
    if Count > 0 then
    begin
      TThread(Last).Terminate;
      Delete(Count - 1);
    end;
  finally
    FThreads.UnlockList;
  end;
end;

{ TScriptExecutorThread }

constructor TScriptExecutorThread.Create;
begin
  FreeOnTerminate := True;
  inherited Create(True);
end;

procedure TScriptExecutorThread.HandleThreadException;
begin
  ShowMessage(FErrorMessage);
end;

procedure TScriptExecutorThread.InitScripter;
begin
  With FScripter do
  begin
    AddConstant('PI', PI);
    DefineProp('Terminated', tkInteger, GetTerminatedProc, nil);
    DefineProp('CanvasWidth', tkInteger, GetCanvasWidthProc, nil);
    DefineProp('CanvasHeight', tkInteger, GetCanvasHeightProc, nil);
    DefineMethod('PlotEllipse', 0, tkNone, nil, PlotEllipseProc);
    DefineMethod('PrepareEllipse', 4, tkNone, nil, PrepareEllipseProc);
    DefineMethod('Sin', 1, tkFloat, nil, SinProc);
    DefineMethod('Cos', 1, tkFloat, nil, CosProc);
    DefineMethod('Sleep', 1, tkNone, nil, SleepProc);
    SourceCode.Text := FScript;
    Compile;
  end;
end;

procedure TScriptExecutorThread.Execute;
begin
  FScripter := TatPascalScripter.Create(nil);
  try
    try
      InitScripter;
      FScripter.Execute;
    except
      On E: Exception do
      begin
        FErrorMessage := E.Message;
        Synchronize(HandleThreadException);
      end;
    end;
  finally
    FScripter.Free;
  end;
end;

procedure TScriptExecutorThread.PrepareEllipse(x, y, color, radius: integer);
begin
  FX := x;
  FY := y;
  FColor := Color;
  FRadius := Radius;
end;

procedure TScriptExecutorThread.InternalPlotEllipse;
begin
  FCanvas.Pen.Color := FColor;
  FCanvas.Brush.Color := FColor;
  FCanvas.Ellipse(FX - FRadius, FY - FRadius, FX + FRadius, FY + FRadius);
end;

procedure TScriptExecutorThread.CosProc(AMachine: TatVirtualMachine);
begin
  With AMachine do
    ReturnOutputArg(Cos(GetInputArgAsFloat(0)));
end;

procedure TScriptExecutorThread.GetTerminatedProc(
  AMachine: TatVirtualMachine);
begin
  With AMachine do
    ReturnOutputArg(Terminated);
end;

procedure TScriptExecutorThread.PrepareEllipseProc(
  AMachine: TatVirtualMachine);
begin
  With AMachine do
    PrepareEllipse(GetInputArgAsInteger(0), GetInputArgAsInteger(1),
      GetInputArgAsInteger(2), GetInputArgAsInteger(3));
end;

procedure TScriptExecutorThread.SinProc(AMachine: TatVirtualMachine);
begin
  With AMachine do
    ReturnOutputArg(Sin(GetInputArgAsFloat(0)));
end;

procedure TScriptExecutorThread.SleepProc(AMachine: TatVirtualMachine);
begin
  With AMachine do
    Sleep(GetInputArgAsInteger(0));
end;

procedure TScriptExecutorThread.GetCanvasHeightProc(
  AMachine: TatVirtualMachine);
begin
  With AMachine do
    ReturnOutputArg(FCanvasHeight);
end;

procedure TScriptExecutorThread.GetCanvasWidthProc(
  AMachine: TatVirtualMachine);
begin
  With AMachine do
    ReturnOutputArg(FCanvasWidth);
end;

procedure TScriptExecutorThread.PlotEllipseProc(
  AMachine: TatVirtualMachine);
begin
  Synchronize(InternalPlotEllipse);
end;

end.
