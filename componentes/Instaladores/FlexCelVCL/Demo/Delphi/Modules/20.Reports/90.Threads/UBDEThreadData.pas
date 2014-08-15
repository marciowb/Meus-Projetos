unit UBDEThreadData;
//This Datamodule will read the data from teh BDE just once, so we can cache
//and not read it fro each thread. BDE doesn't work in multithreaded environments,
//but most other databases do.

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UExcelAdapter, XLSAdapter, UCustomFlexCelReport, UFlexcelReport, Db,
  DBTables, UFlxMemTable, UThreadData;

type
  TMemData = array of array of variant;

  TBDEThreadData = class(TDataModule)
    Items_BDE: TTable;
    Items_BDEItemNo: TFloatField;
    Items_BDEOrderNo: TFloatField;
    Items_BDEPartNo: TFloatField;
    Items_BDEDescription: TStringField;
    Items_BDESellPrice: TCurrencyField;
    Items_BDEQty: TIntegerField;
    Items_BDEDiscount: TFloatField;
    Items_BDEExtPrice: TCurrencyField;
    Items_BDEDiscountPc: TFloatField;
    Cust_BDE: TTable;
    Cust_BDECustNo: TFloatField;
    Cust_BDECompany: TStringField;
    Cust_BDEPhone: TStringField;
    Cust_BDELastInvoiceDate: TDateTimeField;
    Cust_BDEAddr1: TStringField;
    Cust_BDEAddr2: TStringField;
    Cust_BDECity: TStringField;
    Cust_BDEState: TStringField;
    Cust_BDEZip: TStringField;
    Cust_BDECountry: TStringField;
    Cust_BDEFAX: TStringField;
    Cust_BDETaxRate: TFloatField;
    Cust_BDEContact: TStringField;
    Cust_BDETotAddr1: TStringField;
    Cust_BDETotAddr2: TStringField;
    Orders_BDE: TTable;
    Orders_BDEOrderNo: TFloatField;
    Orders_BDECustNo: TFloatField;
    Orders_BDESaleDate: TDateTimeField;
    Orders_BDEShipDate: TDateTimeField;
    Orders_BDEItemsTotal: TCurrencyField;
    Orders_BDETaxRate: TFloatField;
    Orders_BDEFreight: TCurrencyField;
    Orders_BDEAmountPaid: TCurrencyField;
    Orders_BDEAmountDue: TCurrencyField;
    Orders_BDEEmpNo: TIntegerField;
    Orders_BDEShipToContact: TStringField;
    Orders_BDEShipToAddr1: TStringField;
    Orders_BDEShipToAddr2: TStringField;
    Orders_BDEShipToCity: TStringField;
    Orders_BDEShipToState: TStringField;
    Orders_BDEShipToZip: TStringField;
    Orders_BDEShipToCountry: TStringField;
    Orders_BDEShipToPhone: TStringField;
    Orders_BDESalesPerson: TStringField;
    Orders_BDEShipVIA: TStringField;
    Orders_BDEPO: TStringField;
    Orders_BDETerms: TStringField;
    Orders_BDEPaymentMethod: TStringField;
    Emps: TTable;
    EmpsEmpNo: TIntegerField;
    EmpsFullName: TStringField;
    EmpsLastName: TStringField;
    EmpsFirstName: TStringField;
    EmpsPhoneExt: TStringField;
    EmpsHireDate: TDateTimeField;
    EmpsSalary: TFloatField;
    Parts: TTable;
    PartsPartNo: TFloatField;
    PartsDescription: TStringField;
    PartsVendorNo: TFloatField;
    PartsOnHand: TFloatField;
    PartsOnOrder: TFloatField;
    PartsBackOrd: TBooleanField;
    PartsCost: TCurrencyField;
    PartsListPrice: TCurrencyField;
    Session1: TSession;
    procedure Items_BDECalcFields(DataSet: TDataSet);
  private
    procedure CopyOneTable(const Source: TTable; const TargetDb: TFlxMemTable; var Dest: TMemData);
    procedure FillOneMemTable(const Source: TMemData; const Dest: TFlxMemTable);
  public
    CustMem, OrdersMem, ItemsMem : TMemData;

    procedure LoadDataIntoMemory;
    procedure FillMemoryDataSets(const Dest: TThreadData);
  published
  end;

implementation

{$R *.DFM}

{ TThreadData }

procedure TBDEThreadData.LoadDataIntoMemory;
var
  i: integer;
  DummyModule: TThreadData;
begin
  if Length(CustMem) > 0 then exit; //data has been already loaded

  for i := 0 to ComponentCount - 1 do
    if (Components[i] is TTable) then (Components[i] as TTable).Open;

  DummyModule := TThreadData.Create(nil); //A dummy datamodule to get the TFlxMemTable definintions
  try
    CopyOneTable(Cust_BDE, DummyModule.Cust, CustMem);
    CopyOneTable(Orders_BDE, DummyModule.Orders, OrdersMem);
    CopyOneTable(Items_BDE, DummyModule.Items, ItemsMem);
  finally
    FreeAndNil(DummyModule);
  end;

  for i := 0 to ComponentCount - 1 do
    if (Components[i] is TTable) then (Components[i] as TTable).Close;

end;

procedure TBDEThreadData.CopyOneTable(const Source: TTable; const TargetDb: TFlxMemTable; var Dest: TMemData);
var
  i, k: Integer;
begin
  Source.Last;
  Source.First;
  SetLength(Dest, Source.RecordCount);
  k:= 0;
  while not Source.Eof do
  begin
    SetLength(Dest[k], TargetDb.FieldCount);
    for i := 0 to TargetDb.FieldCount - 1 do
    begin
      Dest[k][i] := Source.FieldByName(TargetDb.GetFields(i).DisplayName).Value;
    end;
    inc(k);
    Source.Next;
  end;
end;


procedure TBDEThreadData.FillMemoryDataSets(const Dest: TThreadData);
begin
  FillOneMemTable(CustMem, Dest.Cust);
  FillOneMemTable(OrdersMem, Dest.Orders);
  FillOneMemTable(ItemsMem, Dest.Items);
end;

procedure TBDEThreadData.FillOneMemTable(const Source: TMemData; const Dest: TFlxMemTable);
var
  i: Integer;
begin
  Dest.Clear;
  for i := 0 to Length(Source) - 1 do
  begin
    Dest.AddRecord(Source[i]);
  end;
end;



procedure TBDEThreadData.Items_BDECalcFields(DataSet: TDataSet);
begin
  Items_BDEExtPrice.Value := Items_BDEQty.Value *
    Items_BDESellPrice.Value * (100 - Items_BDEDiscount.Value) / 100;
  Items_BDEDiscountPc.Value:=Items_BDEDiscount.Value / 100;
end;

end.
