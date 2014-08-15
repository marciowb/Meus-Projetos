{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0146;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, dmEvents,
  ppDBPipe, ppVar, ppRelatv;

type
  Tfrm0146 = class(TdmCustomForm)
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
    ppCustomerListDetail: TppDetailBand;
    ppCustomerListDBText2: TppDBText;
    ppCustomerListFooter: TppFooterBand;
    ppCustomerListDBCalc1: TppDBCalc;
    ppCustomerListLabel5: TppLabel;
    ppCustomerListColumnHeaderBand1: TppColumnHeaderBand;
    ppCustomerListColumnFooterBand1: TppColumnFooterBand;
    ppCustomerListLabel4: TppLabel;
    ppCustomerListLine1: TppLine;
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
    procedure ppCustomerListColumnHeaderBand1AfterPrint(Sender: TObject);
    procedure ppCustomerListColumnHeaderBand1BeforePrint(Sender: TObject);
    procedure ppCustomerListStartColumn(Sender: TObject);
    procedure ppCustomerListEndColumn(Sender: TObject);
    procedure ppCustomerListColumnFooterBand1AfterPrint(Sender: TObject);
    procedure ppCustomerListColumnFooterBand1BeforePrint(Sender: TObject);
  private
    FEventTracker: TfrmEvents;
    procedure AddEvent(const aDesc: String);
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0146: Tfrm0146;

implementation

{$R *.DFM}


function Tfrm0146.GetReport: TppProducer;
begin
  Result := ppCustomerList;
end;

procedure Tfrm0146.FormCreate(Sender: TObject);
begin
  FEventTracker := TfrmEvents.Create(Application);
  FEventTracker.Show;
end;

procedure Tfrm0146.FormDestroy(Sender: TObject);
begin
  FEventTracker.Free;
  FEventTracker := nil;
end;

procedure Tfrm0146.AddEvent(const aDesc: String);
begin
  if (FEventTracker <> nil) then
    FEventTracker.AddEvent(aDesc);
end;

procedure Tfrm0146.ppCustomerListStartPage(Sender: TObject);
begin
  AddEvent('Report.OnStartPage' + IntToStr(ppCustomerList.AbsolutePageNo));
end;

procedure Tfrm0146.ppCustomerListEndPage(Sender: TObject);
begin
  AddEvent('Report.OnEndPage' + IntToStr(ppCustomerList.AbsolutePageNo));
end;

procedure Tfrm0146.ppCustomerListAfterPrint(Sender: TObject);
begin
  AddEvent('Report.AfterPrint');
end;

procedure Tfrm0146.ppCustomerListBeforePrint(Sender: TObject);
begin
  AddEvent('Report.BeforePrint');
end;

procedure Tfrm0146.ppCustomerListCancel(Sender: TObject);
begin
  AddEvent('Report.OnCancel');
end;

procedure Tfrm0146.ppCustomerListCancelDialogClose(Sender: TObject);
begin
  AddEvent('Report.OnCancelDialogClose');
end;

procedure Tfrm0146.ppCustomerListCancelDialogCreate(Sender: TObject);
begin
  AddEvent('Report.OnCancelDialogCreate');
end;

procedure Tfrm0146.ppCustomerListEndFirstPass(Sender: TObject);
begin
  AddEvent('Report.OnEndFirstPass');
end;

procedure Tfrm0146.ppCustomerListEndSecondPass(Sender: TObject);
begin
  AddEvent('Report.OnEndSecondPass');
end;

procedure Tfrm0146.ppCustomerListPreviewFormClose(Sender: TObject);
begin
  AddEvent('Report.OnPreviewFormClose');
end;

procedure Tfrm0146.ppCustomerListPreviewFormCreate(Sender: TObject);
begin
  AddEvent('Report.OnPreviewFormCreate');
end;

procedure Tfrm0146.ppCustomerListPrintDialogClose(Sender: TObject);
begin
  AddEvent('Report.OnPrintDialogClose');
end;

procedure Tfrm0146.ppCustomerListPrintDialogCreate(Sender: TObject);
begin
  AddEvent('Report.OnPrintDialogCreate');
end;

procedure Tfrm0146.ppCustomerListPrintingComplete(Sender: TObject);
begin
  AddEvent('Report.OnPrintingComplete');
end;

procedure Tfrm0146.ppCustomerListStartFirstPass(Sender: TObject);
begin
  AddEvent('Report.OnStartFirstPass');
end;

procedure Tfrm0146.ppCustomerListStartSecondPass(Sender: TObject);
begin
  AddEvent('Report.OnStartSecondPass');
end;

procedure Tfrm0146.ppCustomerListColumnHeaderBand1AfterPrint(Sender: TObject);
begin
  AddEvent('ColumnHeaderband.AfterPrint: (Column ' + IntToStr(ppCustomerList.CurrentColumn) + ')');
end;

procedure Tfrm0146.ppCustomerListColumnHeaderBand1BeforePrint(Sender: TObject);
begin
  AddEvent('ColumnHeaderBand.BeforePrint: (Column ' + IntToStr(ppCustomerList.CurrentColumn) + ')');
end;

procedure Tfrm0146.ppCustomerListStartColumn(Sender: TObject);
begin
  AddEvent('------------------------------------------------');
  AddEvent('Report.OnStartColumn: (Column ' + IntToStr(ppCustomerList.CurrentColumn) + ')');
end;

procedure Tfrm0146.ppCustomerListEndColumn(Sender: TObject);
begin
  AddEvent('Report.OnEndColumn: (Column ' + IntToStr(ppCustomerList.CurrentColumn) + ')');

  if ppCustomerList.CurrentColumn = ppCustomerList.Columns then
    AddEvent('------------------------------------------------');
    
end;

procedure Tfrm0146.ppCustomerListColumnFooterBand1AfterPrint(
  Sender: TObject);
begin
  AddEvent('ColumnFooterBand.AfterPrint: (Column ' + IntToStr(ppCustomerList.CurrentColumn) + ')');
end;

procedure Tfrm0146.ppCustomerListColumnFooterBand1BeforePrint(
  Sender: TObject);
begin
  AddEvent('ColumnFooterBand.BeforePrint: (Column ' + IntToStr(ppCustomerList.CurrentColumn) + ')');
end;

end.
