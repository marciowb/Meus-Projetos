{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0033;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, ppDBPipe,
  ppRelatv;

type
  Tfrm0033 = class(TdmCustomForm)
    dsCustomer: TDataSource;
    plCustomer: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppReport1: TppReport;
    tblCustomer: TTable;
    ppReport1ColumnHeaderBand1: TppColumnHeaderBand;
    ppReport1DetailBand1: TppDetailBand;
    ppReport1ColumnFooterBand1: TppColumnFooterBand;
    ppMemoAddress: TppMemo;
    procedure ppReport1DetailBand1BeforePrint(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0033: Tfrm0033;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ Tfrm0033.FormCreate }

function Tfrm0033.GetReport: TppProducer;
begin
  Result := ppReport1;
end;


{------------------------------------------------------------------------------}
{ Tfrm0033.ppReport1DetailBand1BeforePrint }

procedure Tfrm0033.ppReport1DetailBand1BeforePrint(Sender: TObject);
var
  lsLine: String;
  lsState: String;
  lsZIP: String;

begin
   {clear memo}
   ppMemoAddress.Lines.Clear;

   {add contact}
   lsLine := tblCustomer.FieldByName('Contact').AsString;
   ppMemoAddress.Lines.Add(lsLine);

   {add company}
   lsLine := tblCustomer.FieldByName('Company').AsString;
   ppMemoAddress.Lines.Add(lsLine);

   {add address line1}
   lsLine := tblCustomer.FieldByName('Addr1').AsString;
   if lsLine <> '' then
    ppMemoAddress.Lines.Add(lsLine);

   {add address line2}
   lsLine := tblCustomer.FieldByName('Addr2').AsString;
   if lsLine <> '' then
    ppMemoAddress.Lines.Add(lsLine);

   {add city, state zip}
   lsLine := tblCustomer.FieldByName('City').AsString;

   lsState := tblCustomer.FieldByName('State').AsString;

   if lsState <> '' then
     lsLine := lsLine + ', ' + lsState;

   lsZIP := tblCustomer.FieldByName('ZIP').AsString;

    if lsZIP <> '' then
     lsLine := lsLine + ' ' + lsZIP;

   ppMemoAddress.Lines.Add(lsLine);

   {add country}
   lsLine := tblCustomer.FieldByName('Country').AsString;
   ppMemoAddress.Lines.Add(lsLine);


end;

end.
