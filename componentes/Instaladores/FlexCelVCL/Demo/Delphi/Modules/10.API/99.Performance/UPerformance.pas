unit UPerformance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF FPC} LResources,{$ENDIF}
  Dialogs, UExcelAdapter, XLSAdapter, UFlexCelImport, ImgList, ActnList,
  ComCtrls, ToolWin, StdCtrls;

type
  TFPerformance = class(TForm)
    MainToolBar: TToolBar;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton1: TToolButton;
    MenuCommands: TActionList;
    ActionRun: TAction;
    ActionClose: TAction;
    ToolbarImages: TImageList;
    ToolbarImagesH: TImageList;
    ToolbarImagesD: TImageList;
    Memo1: TMemo;
    Label1: TLabel;
    edFolder: TEdit;
    Label2: TLabel;
    ProgressBar: TProgressBar;
    StatusBar: TStatusBar;
    Label3: TLabel;
    XLSAdapter1: TXLSAdapter;
    procedure ActionRunExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
  private
    procedure UpdateCounters;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPerformance: TFPerformance;

implementation
uses UReportThread;

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

const
  MaxThreads = 500;


procedure TFPerformance.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFPerformance.UpdateCounters;
begin
  StatusBar.Panels[1].Text := 'Started: ' + IntToStr(Report_RunningCount);
  StatusBar.Panels[2].Text := 'Finished: ' + IntToStr(Report_FinishedCount);
  StatusBar.Panels[3].Text := 'Errors: ' + IntToStr(Report_ErrorCount);
  ProgressBar.Position := Round(Report_FinishedCount * 100.0 / MaxThreads);
end;

procedure TFPerformance.ActionRunExecute(Sender: TObject);
var
  i: integer;
  PathToFolder: string;
begin
 ActionRun.Enabled := false;
 try
 ActionClose.Enabled := false;
 try
 edFolder.Enabled := false;
 try
   ClearCounters;
   StatusBar.Panels[0].Text := 'Running...';
   ProgressBar.Visible := true;
   UpdateCounters;

   //We use a dummy XlsAdapter here so when running this demo form MainDemo, it will set its "BasePathToOpen" property.
   //A normal app shouldn't need this.
   if XLSAdapter1.BasePathToOpen = '' then PathToFolder := ExtractFilePath(ParamStr(0))
   else PathToFolder := XLSAdapter1.BasePathToOpen;

    Application.ProcessMessages;
    for i := 0 to MaxThreads - 1 do
    begin
      TReport.Create(i, Trim(edFolder.Text), PathToFolder);
      if (i mod 10 = 0) then
      begin
        UpdateCounters;
        Application.ProcessMessages;
      end;
    end;

    while Report_FinishedCount < MaxThreads do
    begin
      UpdateCounters;
      Application.ProcessMessages;
      Sleep(500);
    end;

    StatusBar.Panels[0].Text := 'Finished!';
    UpdateCounters;
 finally
   edFolder.Enabled := true;
 end;
 finally
   ActionClose.Enabled := true;
 end;
 finally
   ActionRun.Enabled := true;
 end;
end;

{$IFDEF FPC}
initialization
{$I UPerformance.lrs}
{$ENDIF}

end.
