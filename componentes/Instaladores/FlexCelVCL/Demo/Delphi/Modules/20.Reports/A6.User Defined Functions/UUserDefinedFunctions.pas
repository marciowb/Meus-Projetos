unit UUserDefinedFunctions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF FPC} LResources,{$ENDIF}
  Dialogs, UExcelAdapter, XLSAdapter, StdCtrls, UFlxFormats,
  ImgList, ActnList, ComCtrls, ToolWin, UCustomFlexCelReport, UFlexCelReport,
  UWaitCursor, ShellApi, DB, DBTables;

type
  TFUserDefinedFunctions = class(TForm)
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
    Orders: TQuery;
    Employee: TTable;
    DsEmployee: TDataSource;
    procedure ActionRunExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
  private
    function GetEmployeeHash: variant;
    { Private declarations }
  public
    { Public declarations }
  published
  //Field definitions to use on the template.
  property EmployeeHash: variant read GetEmployeeHash;

  //FUNCTIONS SHOULD ***ALWAYS*** be defined as either:
  // 1) function xxx(const Paramters: array of variant): variant
  // 2) function xxx: variant
  // Any other declaration will raise an Access Violation.
  function OrderHash(const Parameters: array of variant): variant;
  function Upper(const Parameters: array of variant): variant;
  end;

var
  FUserDefinedFunctions: TFUserDefinedFunctions;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

procedure TFUserDefinedFunctions.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFUserDefinedFunctions.ActionRunExecute(Sender: TObject);
var
  WaitCursor: IWaitCursor;
begin
  if not SaveDialog.Execute then exit;
  XLSAdapter1.AllowOverwritingFiles := true;
  Report.FileName:=SaveDialog.FileName;
  WaitCursor:=TWaitCursor.Create;
  Report.Run;

  if MessageDlg('Do you want to open the generated file?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    ShellExecute(0, 'open', PCHAR(SaveDialog.FileName), nil, nil, SW_SHOWNORMAL);
  end;

end;

function TFUserDefinedFunctions.GetEmployeeHash: variant;
var
  EmployeeName: string;
  i: integer;
  Total: integer;
begin
  //Here we can calculate a field using the values of the dataset.
  //We will calculate a non sense hash, but you could do whatever here.
  EmployeeName := Employee['LastName'];
  Total := 0;
  for i:= 1 to Length(EmployeeName) do inc(Total, Ord(EmployeeName[i]));
  Result := Total;
end;

function TFUserDefinedFunctions.OrderHash(
  const Parameters: array of variant): variant;
var
  Decimals: integer;
begin
  //Again, in this example this makes no sense.

  //Parse the parameters.
  if Length(Parameters) < 1 then Decimals:= 5 else Decimals:= Parameters[0];

  //Process the result.
  Result := IntToHex(Orders['OrderNo'], Decimals);
end;

function TFUserDefinedFunctions.Upper(
  const Parameters: array of variant): variant;
var
  Ds: TComponent;
begin
  if Length(Parameters) < 2 then Raise Exception.Create('Error, Upper needs 2 parameters');

  Ds:=FindComponent(Parameters[0]);
  if (Ds=nil) or not (Ds is TDataSet) then raise Exception.Create('Error, Dataset not found: ' + Parameters[0]);
  Result:= UpperCase((Ds as TDataSet)[Parameters[1]]);
end;

{$IFDEF FPC}
initialization
{$I UUserDefinedFunctions.lrs}
{$ENDIF}

end.
