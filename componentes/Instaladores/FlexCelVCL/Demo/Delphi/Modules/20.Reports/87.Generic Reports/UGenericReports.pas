unit UGenericReports;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF FPC} LResources,{$ENDIF}
  Dialogs, UExcelAdapter, XLSAdapter, StdCtrls, UFlxFormats,
  ImgList, ActnList, ComCtrls, ToolWin, UCustomFlexCelReport, UFlexCelReport,
  UWaitCursor, ShellApi, DB, DBTables, Grids, DBGrids;

type
  TFGenericReports = class(TForm)
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
    Label1: TLabel;
    DBGrid1: TDBGrid;
    Label2: TLabel;
    edSQL: TMemo;
    Ds: TQuery;
    DataSource1: TDataSource;
    procedure ActionRunExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FGenericReports: TFGenericReports;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

procedure TFGenericReports.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

function SkipCR(const s: string): string;
var
  i:integer;
begin
  SetLength(Result, Length(s));
  for i:=1 to length(s) do if s[i]<#32 then Result[i]:=' ' else Result[i]:=s[i];
end;


procedure TFGenericReports.ActionRunExecute(Sender: TObject);
var
  WaitCursor: IWaitCursor;
begin
  WaitCursor:=TWaitCursor.Create;

  //Execute the SQL
  Ds.Close;
  Ds.SQL:=edSQL.Lines;
  Ds.Open;

  if not SaveDialog.Execute then exit;
  XLSAdapter1.AllowOverwritingFiles := true;
  Report.FileName:=SaveDialog.FileName;
  Report.Values['currentdate'] := Now;
  Report.Values['dsname'] := Ds.Database.DatabaseName;
  Report.Values['currentsql'] := SkipCR(Ds.SQL.Text);
  Report.Run;

  if MessageDlg('Do you want to open the generated file?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    ShellExecute(0, 'open', PCHAR(SaveDialog.FileName), nil, nil, SW_SHOWNORMAL);
  end;

end;

{$IFDEF FPC}
initialization
{$I UGenericReports.lrs}
{$ENDIF}

end.
