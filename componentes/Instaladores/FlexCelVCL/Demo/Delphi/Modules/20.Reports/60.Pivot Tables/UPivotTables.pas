unit UPivotTables;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF FPC} LResources,{$ENDIF}
  Dialogs, UExcelAdapter, XLSAdapter, StdCtrls, UFlxFormats,
  ImgList, ActnList, ComCtrls, ToolWin, UCustomFlexCelReport, UFlexCelReport,
  UWaitCursor, ShellApi, DB, DBTables, dblookup, DBCtrls;

type
  TFPivotTables = class(TForm)
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
    Total: TQuery;
    TotalSaleDate: TDateTimeField;
    TotalCustNo: TFloatField;
    TotalCompany: TStringField;
    TotalAddr1: TStringField;
    TotalAddr2: TStringField;
    TotalCity: TStringField;
    TotalState: TStringField;
    TotalZip: TStringField;
    TotalCountry: TStringField;
    TotalPhone: TStringField;
    TotalFAX: TStringField;
    TotalTaxRate: TFloatField;
    TotalContact: TStringField;
    TotalLastInvoiceDate: TDateTimeField;
    TotalOrderNo: TFloatField;
    TotalCustNo_1: TFloatField;
    TotalShipDate: TDateTimeField;
    TotalEmpNo: TIntegerField;
    TotalShipToContact: TStringField;
    TotalShipToAddr1: TStringField;
    TotalShipToAddr2: TStringField;
    TotalShipToCity: TStringField;
    TotalShipToState: TStringField;
    TotalShipToZip: TStringField;
    TotalShipToCountry: TStringField;
    TotalShipToPhone: TStringField;
    TotalShipVIA: TStringField;
    TotalPO: TStringField;
    TotalTerms: TStringField;
    TotalPaymentMethod: TStringField;
    TotalItemsTotal: TCurrencyField;
    TotalTaxRate_1: TFloatField;
    TotalFreight: TCurrencyField;
    TotalAmountPaid: TCurrencyField;
    TotalOrderNo_1: TFloatField;
    TotalItemNo: TFloatField;
    TotalPartNo: TFloatField;
    TotalQty: TIntegerField;
    TotalDiscount: TFloatField;
    TotalPartNo_1: TFloatField;
    TotalVendorNo: TFloatField;
    TotalDescription: TStringField;
    TotalOnHand: TFloatField;
    TotalOnOrder: TFloatField;
    TotalCost: TCurrencyField;
    TotalListPrice: TCurrencyField;
    procedure ActionRunExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPivotTables: TFPivotTables;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

procedure TFPivotTables.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFPivotTables.ActionRunExecute(Sender: TObject);
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

{$IFDEF FPC}
initialization
{$I UPivotTables.lrs}
{$ENDIF}

end.
