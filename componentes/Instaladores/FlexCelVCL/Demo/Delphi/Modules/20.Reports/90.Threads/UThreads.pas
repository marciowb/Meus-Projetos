unit UThreads;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UExcelAdapter, XLSAdapter, UCustomFlexCelReport, UFlexcelReport,
  ComCtrls, ToolWin, UFlxRepThread, ActnList, ImgList, UAbout, ExtCtrls, UBDEThreadData;

type
  TFThreads = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ActionList1: TActionList;
    ActionReport: TAction;
    ActionCancel: TAction;
    ActionClose: TAction;
    ToolButton4: TToolButton;
    ActionHelp: TAction;
    ToolButton5: TToolButton;
    LvReports: TListView;
    PanelCommand: TPanel;
    ToolbarImages: TImageList;
    ToolbarImagesH: TImageList;
    ToolbarImagesD: TImageList;
    XLSAdapter1: TXLSAdapter;
    procedure ActionCloseExecute(Sender: TObject);
    procedure ActionReportExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ActionHelpExecute(Sender: TObject);
    procedure ActionCancelUpdate(Sender: TObject);
    procedure ActionCancelExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    BDEThreadData: TBDEThreadData;
    RunningReports: integer;
    procedure RepTerminate(Sender: TObject);
    procedure UpdatePanel;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  end;

var
  FThreads: TFThreads;

implementation


{$R *.DFM}

procedure TFThreads.UpdatePanel;
begin
  PanelCommand.Caption := 'Running ' + IntToStr(RunningReports) + ' reports out of ' + IntToStr(LvReports.Items.Count);
end;

procedure TFThreads.RepTerminate(Sender: TObject);
var
  Th: TFlxRepThread;
  i: integer;
  Msg: string;
begin
  //Remove thread form list
  Th:= Sender as TFlxRepThread;
  for i:=0 to LvReports.Items.Count-1 do
    if LvReports.Items[i].Data= Th then
    begin
      if  Th.ErrMsg='' then Msg:='OK' else Msg:=Th.ErrMsg;
      LvReports.Items[i].SubItems.Text:='Terminated: '+Msg;
      LvReports.Items[i].Data:=nil;
    end;
  DeleteFile(Th.FileName);
  dec(RunningReports); //we are in the context of the main thread here, so there is no need to lock.
  UpdatePanel;
end;

procedure TFThreads.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFThreads.ActionReportExecute(Sender: TObject);
var
  Li: TListItem;
  WorkThread: TFlxRepThread;
begin
  BDEThreadData.LoadDataIntoMemory;
  Randomize;
  WorkThread:=TFlxRepThread.Create(BDEThreadData, XLSAdapter1.BasePathToOpen);  //We don't use XlsAdapter1 here, it is just that when running from maindemo, this will be set to the path where the files are.
  WorkThread.OnTerminate:=RepTerminate;

  inc(RunningReports); //we are in the context of the main thread here, so there is no need to lock.
  Li:=LvReports.Items.Add;
  Li.Caption:=WorkThread.FileName;
  Li.Data:=WorkThread;
  Li.SubItems.Add('RUNNING...') ;
  UpdatePanel;

{$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 21}{$DEFINE D2010UP}{$IFEND}{$ENDIF}
{$ifdef D2010UP}
  WorkThread.Start;  //resume was deprecated in 2010.
{$else}
  WorkThread.Resume;
{$endif}
end;

constructor TFThreads.Create(AOwner: TComponent);
begin
  inherited;
  BDEThreadData := TBDEThreadData.Create(self);
end;

procedure TFThreads.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  i: integer;
begin
  //Verify all threads have finished
  for i:=0 to LvReports.Items.Count-1 do
    if LvReports.Items[i].Data<>nil then
    begin
      TFlxRepThread(LvReports.Items[i].Data).Finish;
      TFlxRepThread(LvReports.Items[i].Data).WaitFor;
    end;
end;

procedure TFThreads.FormCreate(Sender: TObject);
begin
  {$if CompilerVersion >= 18}  //Delphi 2006 or newer, this is fixed there.
  PanelCommand.ParentBackground := false; //workarounds a bug in delphi.
  {$IFEND}
end;

procedure TFThreads.ActionHelpExecute(Sender: TObject);
var
  About: TAbout;
begin
  About := TAbout.Create(nil);
  try
    About.ShowModal;
  finally
    About.Free;
  end;
end;

procedure TFThreads.ActionCancelUpdate(Sender: TObject);
begin
  ActionCancel.Enabled:=(LvReports.Selected<>nil) and (LvReports.Selected.Data<>nil);
end;

procedure TFThreads.ActionCancelExecute(Sender: TObject);
begin
  if (LvReports.Selected<>nil) and
    (TFlxRepThread(LvReports.Selected.Data)<>nil) then
      TFlxRepThread(LvReports.Selected.Data).Finish;
end;

end.
