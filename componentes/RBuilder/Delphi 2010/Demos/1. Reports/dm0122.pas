{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0122;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons,
  ppClass, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppPrnDev, dmUtil, ppProd, ppRelatv;

type
  Tfrm0122 = class(TdmCustomForm)
    ppReport1: TppReport;
    lbxPrinters: TListBox;
    btnPrint: TButton;
    Label2: TLabel;
    ppReport1ColumnHeaderBand1: TppColumnHeaderBand;
    ppReport1DetailBand1: TppDetailBand;
    ppReport1Shape1: TppShape;
    ppReport1ColumnFooterBand1: TppColumnFooterBand;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPrintClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    FDeviceList: TList;

  protected
    function GetReport: TppProducer; override;
    procedure Init; override;

  public
    { Public declarations }
  end;

var
  frm0122: Tfrm0122;

implementation

uses
  ppDevice;
  
{$R *.DFM}

{------------------------------------------------------------------------------}
{ Tfrm0122.GetReport }

function Tfrm0122.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

{------------------------------------------------------------------------------}
{ Tfrm0122.FormCreate }

procedure Tfrm0122.FormCreate(Sender: TObject);
var
  liIndex: Integer;
begin

  FDeviceList := TList.Create;

  {get printer list }
  lbxPrinters.Items := ppReport1.PrinterSetup.PrinterNames;
  liIndex := lbxPrinters.Items.IndexOf('Screen');
  if liIndex >= 0 then
    lbxPrinters.Items.Delete(liIndex);

end;  {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ Tfrm0122.Init}

procedure Tfrm0122.Init;
begin
  {initialize inherited properties for the demo form}
  AssignViewer := True;
  DisplayForm  := True;
end;

{------------------------------------------------------------------------------}
{ Tfrm0122.FormDestroy }

procedure Tfrm0122.FormDestroy(Sender: TObject);
begin
  FDeviceList.Free;
end;

{------------------------------------------------------------------------------}
{ Tfrm0122.FormActivate }

procedure Tfrm0122.FormActivate(Sender: TObject);
begin

  {print to custom viewer}
  ppReport1.PrintToDevices;
end;

{------------------------------------------------------------------------------}
{ Tfrm0122.FormClose }

procedure Tfrm0122.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end; {procedure, FormClose}


{------------------------------------------------------------------------------}
{ Tfrm0122.btnPrintClick }

procedure Tfrm0122.btnPrintClick(Sender: TObject);
var
  liPrinter: Integer;
  lPrinterDevice: TppPrinterDevice;

begin

  {check whether any items are selected }
  if lbxPrinters.SelCount <= 0 then Exit;


  {create a TppPrinterDevice for each printer selected}
  for liPrinter := 0 to lbxPrinters.Items.Count-1 do

    if lbxPrinters.Selected[liPrinter] then
      begin

        {create a printer device}
        lPrinterDevice := TppPrinterDevice.Create(Self);

        {add device to report's publisher}
        lPrinterDevice.Publisher := ppReport1.Publisher;

        {set the printer name for the device}
        lPrinterDevice.Printer.PrinterName  := lbxPrinters.Items[liPrinter];

        {add device object to the this form's internal device TList}
        FDeviceList.Add(lPrinterDevice);

      end;

  {print the report to the devices}
  ppReport1.PrintToDevices;

  {free each device in the list}
  for liPrinter := FDeviceList.Count-1 downto 0 do
    TObject(FDeviceList[liPrinter]).Free;

  {clear the device list}
  FDeviceList.Clear;

end; {procedure, btnPrintClick}



end.
