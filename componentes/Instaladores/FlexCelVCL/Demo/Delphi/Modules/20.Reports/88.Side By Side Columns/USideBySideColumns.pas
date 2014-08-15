unit USideBySideColumns;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF FPC} LResources,{$ENDIF}
  Dialogs, UExcelAdapter, XLSAdapter, StdCtrls, UFlxFormats,
  ImgList, ActnList, ComCtrls, ToolWin, UCustomFlexCelReport, UFlexCelReport,
  UWaitCursor, ShellApi, DB, DBTables;

type
  TFSideBySideColumns = class(TForm)
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
    Cust: TTable;
    CustCustNo: TFloatField;
    CustCompany: TStringField;
    CustPhone: TStringField;
    CustLastInvoiceDate: TDateTimeField;
    CustAddr1: TStringField;
    CustAddr2: TStringField;
    CustCity: TStringField;
    CustState: TStringField;
    CustZip: TStringField;
    CustCountry: TStringField;
    CustFAX: TStringField;
    CustTaxRate: TFloatField;
    CustContact: TStringField;
    Vendors: TTable;
    VendorsVendorNo: TFloatField;
    VendorsVendorName: TStringField;
    VendorsAddress1: TStringField;
    VendorsAddress2: TStringField;
    VendorsCity: TStringField;
    VendorsState: TStringField;
    VendorsZip: TStringField;
    VendorsCountry: TStringField;
    VendorsPhone: TStringField;
    VendorsFAX: TStringField;
    VendorsPreferred: TBooleanField;
    procedure ActionRunExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSideBySideColumns: TFSideBySideColumns;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

procedure TFSideBySideColumns.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFSideBySideColumns.ActionRunExecute(Sender: TObject);
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
{$IFDEF FPC}
initialization
{$I USideBySideColumns.lrs}
{$ENDIF}

end.
