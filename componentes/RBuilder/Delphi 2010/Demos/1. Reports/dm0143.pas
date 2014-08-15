{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0143;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, dmEvents,
  ppDBPipe, ppVar, ppRelatv;

type
  Tfrm0143 = class(TdmCustomForm)
    tblCustomer: TTable;
    dsCustomer: TDataSource;
    ppBDEPipeline1: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
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
    ppCustomerListDetail: TppDetailBand;
    ppCustomerListDBText2: TppDBText;
    ppCustomerListDBText8: TppDBText;
    ppCustomerListDBText3: TppDBText;
    ppCustomerListDBText4: TppDBText;
    ppCustomerListDBText5: TppDBText;
    ppCustomerListDBText6: TppDBText;
    ppCustomerListFooter: TppFooterBand;
    ppCustomerListLine1: TppLine;
    ppCustomerListDBCalc1: TppDBCalc;
    ppCustomerListLabel5: TppLabel;
    ppCustomerListCalc1: TppSystemVariable;
    ppCustomerListCalc3: TppSystemVariable;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ppCustomerListStartPage(Sender: TObject);
    procedure ppCustomerListEndPage(Sender: TObject);
    procedure ppCustomerListAfterPrint(Sender: TObject);
    procedure ppCustomerListBeforePrint(Sender: TObject);
    procedure ppCustomerListCancel(Sender: TObject);
    procedure ppCustomerListCancelDialogClose(Sender: TObject);
    procedure ppCustomerListCancelDialogCreate(Sender: TObject);
    procedure ppCustomerListEndFirstPass(Sender: TObject);
    procedure ppCustomerListEndSecondPass(Sender: TObject);
    procedure ppCustomerListPreviewFormClose(Sender: TObject);
    procedure ppCustomerListPreviewFormCreate(Sender: TObject);
    procedure ppCustomerListPrintDialogClose(Sender: TObject);
    procedure ppCustomerListPrintDialogCreate(Sender: TObject);
    procedure ppCustomerListPrintingComplete(Sender: TObject);
    procedure ppCustomerListStartFirstPass(Sender: TObject);
    procedure ppCustomerListStartSecondPass(Sender: TObject);
  private
    FEventTracker: TfrmEvents;
    procedure AddEvent(const aDesc: String);
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0143: Tfrm0143;

implementation

{$R *.DFM}


function Tfrm0143.GetReport: TppProducer;
begin
  Result := ppCustomerList;
end;

procedure Tfrm0143.FormCreate(Sender: TObject);
begin
  FEventTracker := TfrmEvents.Create(Application);
  FEventTracker.Show;
end;

procedure Tfrm0143.FormDestroy(Sender: TObject);
begin
  FEventTracker.Free;
  FEventTracker := nil;
end;

procedure Tfrm0143.AddEvent(const aDesc: String);
begin
  if (FEventTracker <> nil) then
    FEventTracker.AddEvent(aDesc);
end;

procedure Tfrm0143.ppCustomerListStartPage(Sender: TObject);
begin
  AddEvent('Report.OnStartPage' + IntToStr(ppCustomerList.AbsolutePageNo));
end;

procedure Tfrm0143.ppCustomerListEndPage(Sender: TObject);
begin
  AddEvent('Report.OnEndPage' + IntToStr(ppCustomerList.AbsolutePageNo));
end;

procedure Tfrm0143.ppCustomerListAfterPrint(Sender: TObject);
begin
  AddEvent('Report.AfterPrint');
end;

procedure Tfrm0143.ppCustomerListBeforePrint(Sender: TObject);
begin
  AddEvent('Report.BeforePrint');
end;

procedure Tfrm0143.ppCustomerListCancel(Sender: TObject);
begin
  AddEvent('Report.OnCancel');
end;

procedure Tfrm0143.ppCustomerListCancelDialogClose(Sender: TObject);
begin
  AddEvent('Report.OnCancelDialogClose');
end;

procedure Tfrm0143.ppCustomerListCancelDialogCreate(Sender: TObject);
begin
  AddEvent('Report.OnCancelDialogCreate');
end;

procedure Tfrm0143.ppCustomerListEndFirstPass(Sender: TObject);
begin
  AddEvent('Report.OnEndFirstPass');
end;

procedure Tfrm0143.ppCustomerListEndSecondPass(Sender: TObject);
begin
  AddEvent('Report.OnEndSecondPass');
  AddEvent('------------------------------------------------');
end;

procedure Tfrm0143.ppCustomerListPreviewFormClose(Sender: TObject);
begin
  AddEvent('Report.OnPreviewFormClose');
end;

procedure Tfrm0143.ppCustomerListPreviewFormCreate(Sender: TObject);
begin
  AddEvent('Report.OnPreviewFormCreate');
end;

procedure Tfrm0143.ppCustomerListPrintDialogClose(Sender: TObject);
begin
  AddEvent('Report.OnPrintDialogClose');
end;

procedure Tfrm0143.ppCustomerListPrintDialogCreate(Sender: TObject);
begin
  AddEvent('Report.OnPrintDialogCreate');
end;

procedure Tfrm0143.ppCustomerListPrintingComplete(Sender: TObject);
begin
  AddEvent('Report.OnPrintingComplete');
end;

procedure Tfrm0143.ppCustomerListStartFirstPass(Sender: TObject);
begin
  AddEvent('------------------------------------------------');
  AddEvent('Report.OnStartFirstPass');
end;

procedure Tfrm0143.ppCustomerListStartSecondPass(Sender: TObject);
begin
  AddEvent('------------------------------------------------');
  AddEvent('Report.OnStartSecondPass');
end;





end.
