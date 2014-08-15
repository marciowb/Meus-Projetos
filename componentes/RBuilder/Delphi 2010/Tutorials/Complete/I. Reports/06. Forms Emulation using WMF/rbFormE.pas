{******************************************************************************}
{                                                                              }
{                   ReportBuilder Tutorials                                    }
{                                                                              }
{             Copyright (c) 1996, 2000 Digital Metaphors Corporation           }
{                                                                              }
{******************************************************************************}

unit rbFormE;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ppBands, ppCache, ppClass, ppDB, ppProd, ppReport, ppComm, ppRelatv,
  ppDBPipe, DBTables, ppCtrls, ppPrnabl, ppStrtch, ppMemo, StdCtrls;

type
  TfrmFormsEmulation = class(TForm)
    tblCustomer: TTable;
    dsCustomer: TDataSource;
    plCustomer: TppDBPipeline;
    rbFormEmul: TppReport;
    ppDetailBand1: TppDetailBand;
    tblCustomerCustNo: TFloatField;
    tblCustomerCompany: TStringField;
    tblCustomerAddr1: TStringField;
    tblCustomerAddr2: TStringField;
    tblCustomerCity: TStringField;
    tblCustomerState: TStringField;
    tblCustomerZip: TStringField;
    tblCustomerCountry: TStringField;
    tblCustomerPhone: TStringField;
    tblCustomerFAX: TStringField;
    tblCustomerTaxRate: TFloatField;
    tblCustomerContact: TStringField;
    tblCustomerLastInvoiceDate: TDateTimeField;
    tblCustomerWages: TCurrencyField;
    tblCustomerSSWages: TCurrencyField;
    tblCustomerFederalTaxWithheld: TCurrencyField;
    tblCustomerSSTaxWithheld: TCurrencyField;
    tblCustomerMedicareTaxWithheld: TCurrencyField;
    tblCustomerMedicareWages: TCurrencyField;
    ppImage1: TppImage;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppLabel1: TppLabel;
    ppMemo1: TppMemo;
    mmEmployeeAddress2: TppMemo;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppLabel2: TppLabel;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppDBText14: TppDBText;
    ppLabel3: TppLabel;
    ppMemo2: TppMemo;
    mmEmployeeAddress1: TppMemo;
    ppDBText15: TppDBText;
    ppDBText16: TppDBText;
    ppLabel4: TppLabel;
    btnPreview: TButton;
    procedure tblCustomerCalcFields(DataSet: TDataSet);
    procedure ppDetailBand1BeforeGenerate(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
  private
    procedure BuildEmployeeAddress(aStrings: TStrings);
  public
    { Public declarations }
  end;

var
  frmFormsEmulation: TfrmFormsEmulation;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TfrmFormsEmulation.tblCustomerCalcFields }

procedure TfrmFormsEmulation.tblCustomerCalcFields(DataSet: TDataSet);
begin
  tblCustomerWages.AsCurrency := 40000;
  tblCustomerSSWages.AsCurrency := 40000;
  tblCustomerMedicareWages.AsCurrency := 40000;

  tblCustomerFederalTaxWithheld.AsCurrency := 40000 * 0.2;
  tblCustomerSSTaxWithheld.AsCurrency := 40000 * 0.05;
  tblCustomerMedicareTaxWithheld.AsCurrency := 40000 * 0.01;

end;

{------------------------------------------------------------------------------}
{ TfrmFormsEmulation.ppDetailBand1BeforeGenerate }

procedure TfrmFormsEmulation.ppDetailBand1BeforeGenerate(Sender: TObject);
begin
  BuildEmployeeAddress(mmEmployeeAddress1.Lines);
  BuildEmployeeAddress(mmEmployeeAddress2.Lines);
end;

{------------------------------------------------------------------------------}
{ TfrmFormsEmulation.BuildEmployeeAddress }

procedure TfrmFormsEmulation.BuildEmployeeAddress(aStrings: TStrings);
var
  lsLine: String;
  lsState: String;
  lsZIP: String;

begin

   {clear memo}
   aStrings.Clear;

   {add contact}
   lsLine := tblCustomer.FieldByName('Contact').AsString;
   aStrings.Add(lsLine);

   {add address line1}
   lsLine := tblCustomer.FieldByName('Addr1').AsString;
   if lsLine <> '' then
    aStrings.Add(lsLine);

   {add address line2}
   lsLine := tblCustomer.FieldByName('Addr2').AsString;
   if lsLine <> '' then
    aStrings.Add(lsLine);

   {add city, state zip}
   lsLine := tblCustomer.FieldByName('City').AsString;

   lsState := tblCustomer.FieldByName('State').AsString;

   if lsState <> '' then
     lsLine := lsLine + ', ' + lsState;

   lsZIP := tblCustomer.FieldByName('ZIP').AsString;

    if lsZIP <> '' then
     lsLine := lsLine + ' ' + lsZIP;

   aStrings.Add(lsLine);

end;


{------------------------------------------------------------------------------}
{ TfrmFormsEmulation.btnPreviewClick }

procedure TfrmFormsEmulation.btnPreviewClick(Sender: TObject);
begin
  rbFormEmul.Print;
end;

end.
