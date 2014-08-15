unit UInMemoryDataSets;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF FPC} LResources,{$ENDIF}
  Dialogs, UExcelAdapter, XLSAdapter, StdCtrls, UFlxFormats,
  ImgList, ActnList, ComCtrls, ToolWin, UCustomFlexCelReport, UFlexCelReport,
  UWaitCursor, ShellApi, DB, DBTables, Grids, UFlxMemTable;

type
  TFInMemoryDatasets = class(TForm)
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
    GridMemory: TStringGrid;
    BirthSex: TFlxMemTable;
    Birthday: TFlxMemTable;
    VBirthday: TFlxMemTable;
    procedure ActionRunExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
    procedure VBirthdayGetData(Sender: TObject; const FieldName: WideString;
      const RecordPos: Integer; var Value: Variant);
    procedure VBirthdayVirtualRecordCount(Sender: TObject;
      var RecordCount: Integer);
    procedure FormCreate(Sender: TObject);
  private
    procedure FillMemTable(const aStg: TStringGrid);
    procedure InitializeGridWithRandomValues;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FInMemoryDatasets: TFInMemoryDatasets;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

procedure TFInMemoryDatasets.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFInMemoryDatasets.ActionRunExecute(Sender: TObject);
var
  WaitCursor: IWaitCursor;
begin
  if not SaveDialog.Execute then exit;
  XLSAdapter1.AllowOverwritingFiles := true;
  Report.FileName:=SaveDialog.FileName;
  WaitCursor:=TWaitCursor.Create;

  FillMemTable(GridMemory); //This will fill the datasets in normal mode (BirthSex and Birthday).
  // In virtual mode (VBirthday), we don't need to fill anything.
  Report.Run;

  if MessageDlg('Do you want to open the generated file?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    ShellExecute(0, 'open', PCHAR(SaveDialog.FileName), nil, nil, SW_SHOWNORMAL);
  end;

end;

procedure TFInMemoryDatasets.FillMemTable(const aStg: TStringGrid);
var
  R:Array Of Variant;
  i: integer;
begin
  Birthday.Clear;
  SetLength(R,4);
  for i:=1 to aStg.RowCount-1 do
    if aStg.Cells[1,i]<>'' then
    begin
      R[0]:=StrtoInt(aStg.Cells[0,i]);
      R[1]:=aStg.Cells[1,i];
      R[2]:=StrToDate(aStg.Cells[2,i]);
      R[3]:=aStg.Cells[3,i];
      Birthday.AddRecord(R);
    end;
  BirthSex.Clear;
  BirthSex.AddRecord(['M']);
  BirthSex.AddRecord(['F']);
end;



procedure TFInMemoryDatasets.FormCreate(Sender: TObject);
begin
  InitializeGridWithRandomValues;
end;

procedure TFInMemoryDatasets.VBirthdayGetData(Sender: TObject;
  const FieldName: WideString; const RecordPos: Integer; var Value: Variant);
begin
  if FieldName='Number' then Value:=StrToInt(GridMemory.Cells[0,RecordPos+1]) else
  if FieldName='Name' then Value:=GridMemory.Cells[1,RecordPos+1] else
  if FieldName='Birthday Date' then Value:=StrToDate(GridMemory.Cells[2,RecordPos+1]) else
  if FieldName='Sex' then Value:=GridMemory.Cells[3,RecordPos+1];
end;

procedure TFInMemoryDatasets.VBirthdayVirtualRecordCount(Sender: TObject;
  var RecordCount: Integer);
begin
  RecordCount:=GridMemory.RowCount-1;
end;

procedure TFInMemoryDatasets.InitializeGridWithRandomValues;
var
  i: integer;
begin
  GridMemory.RowCount:=500;
  GridMemory.Cells[0,0]:='Number';
  GridMemory.Cells[1,0]:='Name';
  GridMemory.Cells[2,0]:='Date';
  GridMemory.Cells[3,0]:='Sex';
  for i:=1 to GridMemory.RowCount-1 do
  begin
    GridMemory.Cells[ 0 , i]:= IntToStr(i);
    GridMemory.Cells[ 1 , i]:= 'Test'+IntToStr(i);
    GridMemory.Cells[ 2 , i]:= DateToStr(Now-random(365*50));
    if Random(2)=0 then GridMemory.Cells[ 3 , i]:= 'M' else GridMemory.Cells[ 3 , i]:= 'F';
  end;

  GridMemory.Cells[1,1]:='Adrian';
  GridMemory.Cells[2,1]:='8/9/1972';
  GridMemory.Cells[3,1]:='M';
  GridMemory.Cells[1,2]:='Agustina';
  GridMemory.Cells[2,2]:='2/3/2002';
  GridMemory.Cells[3,2]:='F';
  GridMemory.Cells[1,3]:='Zoe';
  GridMemory.Cells[2,3]:='1/7/1939';
  GridMemory.Cells[3,3]:='F';
  for i:=1 to GridMemory.RowCount-1 do GridMemory.Cells[ 0 , i]:= IntToStr(i);

end;


{$IFDEF FPC}
initialization
{$I UInMemoryDatasets.lrs}
{$ENDIF}

end.
