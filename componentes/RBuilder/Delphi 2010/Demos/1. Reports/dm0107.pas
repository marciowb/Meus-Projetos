{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0107;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd,
  ppDBPipe, ppFilDev, ExtCtrls, dmUtil, ppVar, ppRelatv;

type
  Tfrm0107 = class(TdmCustomForm)
    Button1: TButton;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Shape3: TShape;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Shape2: TShape;
    tblCustomer: TTable;
    dsCustomer: TDataSource;
    plCustomer: TppBDEPipeline;
    ppReport1: TppReport;
    ppOrderListHeaderBand1: TppHeaderBand;
    ppOrderListLabel1: TppLabel;
    ppOrderListLabel2: TppLabel;
    ppOrderListShape1: TppShape;
    ppOrderListLabel3: TppLabel;
    ppOrderListLabel4: TppLabel;
    ppOrderListDBText1: TppDBText;
    ppOrderListDBText2: TppDBText;
    ppOrderListDetailBand1: TppDetailBand;
    ppOrderListDBText3: TppDBText;
    ppOrderListDBText4: TppDBText;
    ppOrderListDBText5: TppDBText;
    ppOrderListDBText6: TppDBText;
    ppOrderListDBText7: TppDBText;
    ppOrderListDBText8: TppDBText;
    ppOrderListLine1: TppLine;
    ppOrderListLine2: TppLine;
    ppOrderListDBText10: TppDBText;
    ppOrderListFooterBand1: TppFooterBand;
    ppOrderListGroup1: TppGroup;
    ppOrderListGroupHeaderBand1: TppGroupHeaderBand;
    ppOrderListShape2: TppShape;
    ppOrderListLabel5: TppLabel;
    ppOrderListLabel6: TppLabel;
    ppOrderListShape3: TppShape;
    ppOrderListShape4: TppShape;
    ppOrderListLabel7: TppLabel;
    ppOrderListLabel8: TppLabel;
    ppOrderListLabel9: TppLabel;
    ppOrderListLabel10: TppLabel;
    ppOrderListShape5: TppShape;
    ppOrderListLabel11: TppLabel;
    ppOrderListLabel12: TppLabel;
    ppOrderListLabel13: TppLabel;
    ppOrderListLabel15: TppLabel;
    ppOrderListGroupFooterBand1: TppGroupFooterBand;
    ppOrderListLine4: TppLine;
    ppOrderListLine3: TppLine;
    ppOrderListLabel14: TppLabel;
    ppOrderListDBCalc1: TppDBCalc;
    tblOrder: TTable;
    dsOrder: TDataSource;
    plOrder: TppBDEPipeline;
    tblEmployee: TTable;
    dsEmployee: TDataSource;
    plEmployee: TppBDEPipeline;
    ppOrderListCalc2: TppSystemVariable;
    ppOrderListCalc3: TppSystemVariable;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ppReport1AfterPrint(Sender: TObject);
    procedure ppReport1BeforePrint(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
    procedure Init; override;
  public
    { Public declarations }
  end;

var
  frm0107: Tfrm0107;

implementation

{$R *.DFM}

procedure Tfrm0107.Init;
begin
  AssignViewer := True;
  DisplayForm := True;
end;

function Tfrm0107.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

procedure Tfrm0107.FormCreate(Sender: TObject);
begin
  ppReport1.TextFileName := ExtractFilePath(ParamStr(0)) + 'dm' + Copy(Name, 4, 4) + '.txt';
end;

procedure Tfrm0107.Button1Click(Sender: TObject);
begin
  Memo1.Lines.Clear;

  ppReport1.Print;
end;

procedure Tfrm0107.ppReport1AfterPrint(Sender: TObject);
begin

  if (ppReport1.FileDevice <> nil) then
    begin
      Label10.Caption := ppReport1.FileDevice.FileName;

      Memo1.Lines.LoadFromFile(ppReport1.FileDevice.FileName);
    end;

end;

procedure Tfrm0107.ppReport1BeforePrint(Sender: TObject);
var
  lDevice: TppReportTextFileDevice;
begin

  if (ppReport1.FileDevice <> nil) and (ppReport1.FileDevice is TppReportTextFileDevice)then
    begin
      lDevice := TppReportTextFileDevice(ppReport1.FileDevice);

      {120 characters per line, 66 lines per page}
      lDevice.CharacterGrid(120, 66);
    end;

end;


end.
