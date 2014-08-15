{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0123;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd,
  ppPrintr, ppForms, ppPrnDev, ppDBPipe, ppVar, ppRelatv, ppDevice;

type
  Tfrm0123 = class(TdmCustomForm)
    Label1: TLabel;
    Label2: TLabel;
    tblCustomer: TTable;
    dsCustomer: TDataSource;
    ppBDEPipeline1: TppBDEPipeline;
    ppCustomerList: TppReport;
    ppCustomerListHeader: TppHeaderBand;
    ppCustomerListLabel1: TppLabel;
    ppCustomerListLabel2: TppLabel;
    ppCustomerListLabel3: TppLabel;
    ppCustomerListLabel4: TppLabel;
    ppCustomerListLabel6: TppLabel;
    ppCustomerListLabel7: TppLabel;
    ppCustomerListLabel8: TppLabel;
    ppCustomerListLabel9: TppLabel;
    ppCustomerListLine1: TppLine;
    ppCustomerListDetail: TppDetailBand;
    ppCustomerListDBText2: TppDBText;
    ppCustomerListDBText8: TppDBText;
    ppCustomerListDBText3: TppDBText;
    ppCustomerListDBText4: TppDBText;
    ppCustomerListDBText5: TppDBText;
    ppCustomerListDBText6: TppDBText;
    ppCustomerListFooter: TppFooterBand;
    tblStock: TTable;
    dsStock: TDataSource;
    plStock: TppBDEPipeline;
    ppStockList: TppReport;
    ppStockListHeader: TppHeaderBand;
    ppStockListLine6: TppLine;
    ppStockListLabel31: TppLabel;
    ppStockListLabel32: TppLabel;
    ppStockListDetail: TppDetailBand;
    ppStockListLine5: TppLine;
    ppStockListLine1: TppLine;
    ppStockListDBText2: TppDBText;
    ppStockListDBText3: TppDBText;
    ppStockListDBText4: TppDBText;
    ppStockListLabel2: TppLabel;
    ppStockListLabel4: TppLabel;
    ppStockListDBText1: TppDBText;
    ppStockListLabel5: TppLabel;
    ppStockListDBText5: TppDBText;
    ppStockListLabel6: TppLabel;
    ppStockListDBText6: TppDBText;
    ppStockListDBText7: TppDBText;
    ppStockListLabel7: TppLabel;
    ppStockListLabel8: TppLabel;
    ppStockListDBText8: TppDBText;
    ppStockListLabel9: TppLabel;
    ppStockListLabel10: TppLabel;
    ppStockListDBText9: TppDBText;
    ppStockListDBText10: TppDBText;
    ppStockListLabel11: TppLabel;
    ppStockListDBText11: TppDBText;
    ppStockListLabel12: TppLabel;
    ppDBTextRcmndation: TppDBText;
    ppStockListLabel13: TppLabel;
    ppStockListDBText13: TppDBText;
    ppStockListLabel14: TppLabel;
    ppStockListDBText14: TppDBText;
    ppStockListLabel15: TppLabel;
    ppDBTextSymbol: TppDBText;
    ppStockListDBText16: TppDBText;
    ppStockListLabel17: TppLabel;
    ppStockListDBText17: TppDBText;
    ppStockListLabel18: TppLabel;
    ppStockListLabel3: TppLabel;
    ppStockListLine2: TppLine;
    ppStockListLabel16: TppLabel;
    ppStockListLine3: TppLine;
    ppStockListLabel19: TppLabel;
    ppStockListLine4: TppLine;
    ppStockListLabel20: TppLabel;
    ppStockListFooter: TppFooterBand;
    btnPrint: TButton;
    Label3: TLabel;
    ppCustomerListCalc1: TppSystemVariable;
    ppCustomerListCalc3: TppSystemVariable;
    ppStockListCalc1: TppSystemVariable;
    ppStockListCalc3: TppSystemVariable;
    procedure btnPrintClick(Sender: TObject);
  private
    function CreatePrintDialog(aReport: TppReport; aPrinter: TppPrinter): TppCustomPrintDialog;

  protected
    function GetReport: TppProducer; override;
    procedure Init; override;

  public
    { Public declarations }
  end;

var
  frm0123: Tfrm0123;

implementation

{$R *.DFM}


procedure Tfrm0123.Init;
begin
  DisplayFormModal := True;
end;

function Tfrm0123.GetReport: TppProducer;
begin
  Result := ppCustomerList;
end;

procedure Tfrm0123.btnPrintClick(Sender: TObject);
var
  lPrinterDevice: TppPrinterDevice;
  lPrintDialog: TppCustomPrintDialog;

begin
  {create printer device}
  lPrinterDevice := TppPrinterDevice.Create(Self);
  lPrinterDevice.Stackable := True;
  if lPrinterDevice.Printer <> nil then
    lPrinterDevice.Printer.PrinterSetup := ppCustomerList.PrinterSetup;

  {create print dialog}
  lPrintDialog := CreatePrintDialog(ppCustomerList, lPrinterDevice.Printer);
  lPrintDialog.Init;

  {display print dialog}
  if (lPrintDialog.ShowModal = mrOK) then
    begin
      lPrinterDevice.PageRequest := TppPageRequest(lPrintDialog.PageRequest);

      {assign printer device's printer to report - note: do not use assign here}
      ppCustomerList.PrinterSetup.PrinterName := lPrinterDevice.Printer.PrinterSetup.PrinterName;
      ppCustomerList.PrinterSetup.Copies := lPrinterDevice.Printer.PrinterSetup.Copies;
      ppStockList.PrinterSetup.PrinterName := lPrinterDevice.Printer.PrinterSetup.PrinterName;
      ppStockList.PrinterSetup.Copies := lPrinterDevice.Printer.PrinterSetup.Copies;

      {print first report}
      lPrinterDevice.StartPrintJob := True;
      lPrinterDevice.EndPrintJob := False;
      lPrinterDevice.Publisher := ppCustomerList.Publisher;
      ppCustomerList.PrintToDevices;

      {print last report}
      lPrinterDevice.StartPrintJob := False;
      lPrinterDevice.EndPrintJob := True;
      lPrinterDevice.Publisher := ppStockList.Publisher;
      ppStockList.PrintToDevices;


    end;

  {free print dialog}
  lPrintDialog.Free;

  {free device}
  lPrinterDevice.Free;

end;

{------------------------------------------------------------------------------}
{ Tfrm0123.CreatePrintDialog }

function Tfrm0123.CreatePrintDialog(aReport: TppReport; aPrinter: TppPrinter): TppCustomPrintDialog;
var
  lFormClass: TFormClass;
  lPrintDialog: TppCustomPrintDialog;
begin

  lFormClass   := ppGetFormClass(TppCustomPrintDialog);

  lPrintDialog := TppCustomPrintDialog(lFormClass.Create(Application));

  lPrintDialog.Report              := aReport;
  lPrintDialog.DeviceType          := aReport.DeviceType;
  lPrintDialog.Printer             := aPrinter;
  lPrintDialog.LanguageIndex       := aReport.LanguageIndex;
  lPrintDialog.AllowPrintToArchive := aReport.AllowPrintToArchive;
  lPrintDialog.AllowPrintToFile    := aReport.AllowPrintToFile;
  lPrintDialog.ArchiveFileName     := aReport.ArchiveFileName;
  lPrintDialog.TextFileName        := aReport.TextFileName;

  TppPageRequest(lPrintDialog.PageRequest).PageRequested := 1;

  if not(aReport.Icon.Empty) then
    lPrintDialog.Icon := aReport.Icon;

  Result := lPrintDialog;

end; {procedrue, CreatePrintDialog}



end.
