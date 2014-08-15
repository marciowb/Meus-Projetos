unit UGettingStartedReports;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF FPC} LResources,{$ENDIF}
  Dialogs, UExcelAdapter, XLSAdapter, StdCtrls, UFlxFormats,
  ImgList, ActnList, ComCtrls, ToolWin, UCustomFlexCelReport, UFlexCelReport,
  UWaitCursor, ShellApi;

type
  TFGettingStartedReports = class(TForm)
    XLSAdapter1: TXLSAdapter;
    MainToolBar: TToolBar;
    ToolButton2: TToolButton;
    MenuCommands: TActionList;
    ActionRun: TAction;
    ToolbarImages: TImageList;
    ToolbarImagesH: TImageList;
    ToolbarImagesD: TImageList;
    ToolButton1: TToolButton;
    ActionClose: TAction;
    ToolButton3: TToolButton;
    Report: TFlexCelReport;
    SaveDialog: TSaveDialog;
    procedure ActionRunExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FGettingStartedReports: TFGettingStartedReports;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

procedure TFGettingStartedReports.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFGettingStartedReports.ActionRunExecute(Sender: TObject);
var
  WaitCursor: IWaitCursor;
begin
  if not SaveDialog.Execute then exit;
  XLSAdapter1.AllowOverwritingFiles := true;
  Report.FileName:=SaveDialog.FileName;
  WaitCursor:=TWaitCursor.Create;

  Report.Values['Current_Date'] := now;  //notice we enter a real date here, not a string.
  Report.Values['ReportCaption'] := 'Hello from FlexCel!';
  Report.Run;

  if MessageDlg('Do you want to open the generated file?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    ShellExecute(0, 'open', PCHAR(SaveDialog.FileName), nil, nil, SW_SHOWNORMAL);
  end;

end;
{$IFDEF FPC}
initialization
{$I UGettingStartedReports.lrs}
{$ENDIF}

end.
