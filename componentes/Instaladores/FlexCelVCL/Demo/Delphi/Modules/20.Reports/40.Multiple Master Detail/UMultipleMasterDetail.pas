unit UMultipleMasterDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF FPC} LResources,{$ENDIF}
  Dialogs, UExcelAdapter, XLSAdapter, StdCtrls, UFlxFormats,
  ImgList, ActnList, ComCtrls, ToolWin, UCustomFlexCelReport, UFlexCelReport,
  UWaitCursor, ShellApi, DB, DBTables, dblookup, DBCtrls;

type
  TFMultipleMasterDetail = class(TForm)
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
    Orders: TTable;
    OrdersOrderNo: TFloatField;
    OrdersCustNo: TFloatField;
    OrdersSaleDate: TDateTimeField;
    OrdersShipDate: TDateTimeField;
    OrdersItemsTotal: TCurrencyField;
    OrdersTaxRate: TFloatField;
    OrdersFreight: TCurrencyField;
    OrdersAmountPaid: TCurrencyField;
    OrdersEmpNo: TIntegerField;
    OrdersShipToContact: TStringField;
    OrdersShipToAddr1: TStringField;
    OrdersShipToAddr2: TStringField;
    OrdersShipToCity: TStringField;
    OrdersShipToState: TStringField;
    OrdersShipToZip: TStringField;
    OrdersShipToCountry: TStringField;
    OrdersShipToPhone: TStringField;
    OrdersSalesPerson: TStringField;
    OrdersShipVIA: TStringField;
    OrdersPO: TStringField;
    OrdersTerms: TStringField;
    OrdersPaymentMethod: TStringField;
    Items: TTable;
    ItemsItemNo: TFloatField;
    ItemsOrderNo: TFloatField;
    ItemsPartNo: TFloatField;
    ItemsDescription: TStringField;
    ItemsSellPrice: TCurrencyField;
    ItemsQty: TIntegerField;
    ItemsDiscount: TFloatField;
    ItemsExtPrice: TCurrencyField;
    ItemsDiscountPc: TFloatField;
    DsCust: TDataSource;
    DsOrders: TDataSource;
    Parts: TTable;
    PartsPartNo: TFloatField;
    PartsDescription: TStringField;
    PartsVendorNo: TFloatField;
    PartsOnHand: TFloatField;
    PartsOnOrder: TFloatField;
    PartsCost: TCurrencyField;
    PartsListPrice: TCurrencyField;
    Emps: TTable;
    EmpsEmpNo: TIntegerField;
    EmpsFullName: TStringField;
    EmpsLastName: TStringField;
    EmpsFirstName: TStringField;
    EmpsPhoneExt: TStringField;
    EmpsHireDate: TDateTimeField;
    EmpsSalary: TFloatField;
    procedure ActionRunExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
    procedure ItemsCalcFields(DataSet: TDataSet);
    procedure EmpsCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMultipleMasterDetail: TFMultipleMasterDetail;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

procedure TFMultipleMasterDetail.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFMultipleMasterDetail.ActionRunExecute(Sender: TObject);
var
  WaitCursor: IWaitCursor;
begin
  if not SaveDialog.Execute then exit;
  XLSAdapter1.AllowOverwritingFiles := true;
  Report.FileName:=SaveDialog.FileName;
  WaitCursor:=TWaitCursor.Create;
  Report.Values['current_date'] := Now;
  Report.Run;

  if MessageDlg('Do you want to open the generated file?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    ShellExecute(0, 'open', PCHAR(SaveDialog.FileName), nil, nil, SW_SHOWNORMAL);
  end;

end;
procedure TFMultipleMasterDetail.EmpsCalcFields(DataSet: TDataSet);
begin
  EmpsFullName.Value := EmpsLastName.Value + ' ' + EmpsFirstName.Value;
end;

procedure TFMultipleMasterDetail.ItemsCalcFields(DataSet: TDataSet);
begin
  ItemsExtPrice.Value := ItemsQty.Value *
    ItemsSellPrice.Value * (100 - ItemsDiscount.Value) / 100;
  ItemsDiscountPc.Value:=ItemsDiscount.Value / 100;
end;

{$IFDEF FPC}
initialization
{$I UMultipleMasterDetail.lrs}
{$ENDIF}

end.
