{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit CreateEndUserAutoSearchFields;

{$I ppIfDef.pas}

interface

uses
  Windows, Classes, Controls, SysUtils, Forms, StdCtrls, ExtCtrls, Dialogs, Graphics,
  DB, DBTables,

{$IFDEF Delphi7}
  {$IFNDEF Delphi11}
    XPMan,
  {$ENDIF}
{$ENDIF}

  ppComm, ppCache, ppClass, ppProd, ppReport, ppRptExp, ppBands,
  ppDBBDE, ppEndUsr, ppDBPipe, ppDB, ppPrnabl, ppStrtch, ppDsgnDB,
  ppRelatv, ppModule, ppViewr, ppForms, daDB, daDBBDE,
  ppTypes, ppFormWrapper;



type

  TForm1 = class(TForm)
    Shape11: TShape;
    Label6: TLabel;
    Shape12: TShape;
    euDatabase: TDatabase;
    Shape9: TShape;
    Label5: TLabel;
    Shape10: TShape;
    tblTable: TTable;
    dsTable: TDataSource;
    plTable: TppBDEPipeline;
    tblField: TTable;
    dsField: TDataSource;
    plField: TppBDEPipeline;
    Shape6: TShape;
    Label7: TLabel;
    Shape5: TShape;
    ppDesigner1: TppDesigner;
    Shape4: TShape;
    Label8: TLabel;
    Shape3: TShape;
    tblItem: TTable;
    dsItem: TDataSource;
    plItem: TppBDEPipeline;
    Shape13: TShape;
    Label3: TLabel;
    Shape14: TShape;
    Shape18: TShape;
    Label9: TLabel;
    Shape19: TShape;
    ppReport1: TppReport;
    Label1: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape15: TShape;
    Label2: TLabel;
    Shape16: TShape;
    tblFolder: TTable;
    dsFolder: TDataSource;
    plFolder: TppBDEPipeline;
    ppReportExplorer1: TppReportExplorer;
    Shape22: TShape;
    Label10: TLabel;
    Shape23: TShape;
    Shape24: TShape;
    Shape25: TShape;
    Shape26: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape17: TShape;
    Shape20: TShape;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppDataDictionary1: TppDataDictionary;
    Shape28: TShape;
    Label11: TLabel;
    btnSearchCriteriaB: TButton;
    btnSearchCriteriaA: TButton;
    Memo1: TMemo;
    ppTitleBand1: TppTitleBand;
    btnPreviewReport: TButton;
    btnClearSearchCriteria: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSearchCriteriaAClick(Sender: TObject);
    procedure btnSearchCriteriaBClick(Sender: TObject);
    procedure btnPreviewReportClick(Sender: TObject);
    procedure btnClearSearchCriteriaClick(Sender: TObject);
  private
    procedure CreateSearchCriteria;
    procedure RestoreReadMeMessage;

  public
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses
  ppASField;

procedure TForm1.FormCreate(Sender: TObject);
{$IFNDEF UseDesignPath}
var
  lsPathName: String;
{$ENDIF}
begin


{$IFNDEF UseDesignPath}
  euDatabase.Connected := False;

  lsPathName := ExtractFilePath(ParamStr(0));
  lsPathName := AnsiUpperCase(lsPathName);
  lsPathName := Copy(lsPathName,1, Pos('\DEMOS', lsPathName));
  lsPathName := lsPathName + 'DEMOS\DATA';

  euDatabase.Params.Values['PATH'] := ExtractShortPathName(lsPathName);
{$ENDIF}

  euDatabase.Connected := True;

  Height := 348;

  {load a report}
  ppReportExplorer1.LoadReport('All Data', 5);
end;

procedure TForm1.btnPreviewReportClick(Sender: TObject);
begin
  ppReport1.ShowAutoSearchDialog := False;
  ppReport1.DeviceType := dtScreen;
  ppReport1.Print;
end;

procedure TForm1.btnClearSearchCriteriaClick(Sender: TObject);
begin
  if (ppReport1.AutoSearchFieldCount = 0) then Exit;
  
  ppReport1.FreeAutoSearchFields;

  RestoreReadMeMessage;
end;

procedure TForm1.btnSearchCriteriaAClick(Sender: TObject);
var
  ldBeginDate: TDateTime;
  ldEndDate: TDateTime;
  lsDateExpression: String;
begin

  CreateSearchCriteria;

  {company}
  ppReport1.AutoSearchFields[0].SearchExpression := 'C';

  {sale date}
  {use EncodeDate to avoid international date formatting issues}
  ldBeginDate := EncodeDate(1993, 1, 1);
  ldEndDate   := EncodeDate(1995, 12, 31);
  lsDateExpression := DateToStr(ldBeginDate) + ',' + DateToStr(ldEndDate);

  ppReport1.AutoSearchFields[1].SearchExpression := lsDateExpression;

  {amount paid}
  ppReport1.AutoSearchFields[2].SearchOperator := soLessThan;
  ppReport1.AutoSearchFields[2].SearchExpression := '5000';

  ppReport1.GetAutoSearchDescriptionLines(Memo1.Lines);

end;

procedure TForm1.btnSearchCriteriaBClick(Sender: TObject);
var
  ldBeginDate: TDateTime;
  ldEndDate: TDateTime;
  lsDateExpression: String;
begin

  CreateSearchCriteria;

  {company}
  ppReport1.AutoSearchFields[0].SearchExpression := 'S';

  {sale date}
  {use EncodeDate to avoid international date formatting issues}
  ldBeginDate := EncodeDate(1990, 1, 1);
  ldEndDate   := EncodeDate(1995, 12, 31);
  lsDateExpression := DateToStr(ldBeginDate) + ',' + DateToStr(ldEndDate);

  ppReport1.AutoSearchFields[1].SearchExpression := lsDateExpression;

  {amount paid}
  ppReport1.AutoSearchFields[2].SearchOperator := soGreaterThan;
  ppReport1.AutoSearchFields[2].SearchExpression := '0';

  
  ppReport1.GetAutoSearchDescriptionLines(Memo1.Lines);
end;

procedure TForm1.CreateSearchCriteria;
var
  ldBeginDate: TDateTime;
  ldEndDate: TDateTime;
  lsDateExpression: String;
begin
  if (ppReport1.AutoSearchFieldCount > 0) then Exit;

  ldBeginDate := EncodeDate(1990, 1, 1);
  ldEndDate   := EncodeDate(1995, 12, 31);
  lsDateExpression := DateToStr(ldBeginDate) + ',' + DateToStr(ldEndDate);

  ppReport1.CreateAutoSearchCriteria('plOrders', 'Company', soLike, 'S', False);
  ppReport1.CreateAutoSearchCriteria('plOrders', 'SaleDate', soBetween, lsDateExpression, False);
  ppReport1.CreateAutoSearchCriteria('plOrders', 'AmountPaid', soGreaterThan, '0', False);
end;

procedure TForm1.RestoreReadMeMessage;
begin

  Memo1.Lines.BeginUpdate;

  Memo1.Lines.Clear;

  Memo1.Lines.Add('This demo shows the use of the CreateAutoSearchCriteria');
  Memo1.Lines.Add('method of the Report class.  This method creates an');
  Memo1.Lines.Add('autosearchfield and a corresponding criteria object in a');
  Memo1.Lines.Add('query-based dataview of the end-user solution.');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('Once the criteria is created in this manner, a link is');
  Memo1.Lines.Add('established between the autosearch field in the report,');
  Memo1.Lines.Add('and the criteria in the dataview, such that changes in the');
  Memo1.Lines.Add('SearchExpression and SearchOperator properties of the');
  Memo1.Lines.Add('autosearch field are automatically reflected in the');
  Memo1.Lines.Add('corresponding critieria object.  This makes it easy to');
  Memo1.Lines.Add('manipulate end-user search criteria from the autosearch');
  Memo1.Lines.Add('fields.');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('Note also that this demo does not display the autosearch');
  Memo1.Lines.Add('dialog.  By setting the ShowAutoSearchDialog property of');
  Memo1.Lines.Add('the report to false, we are able to create and update');
  Memo1.Lines.Add('search criteria in an end-user dataview, without allowing');
  Memo1.Lines.Add('the user to change the critieria.  This method is superior to');
  Memo1.Lines.Add('the extraction and manipulation of the SQL object inside');
  Memo1.Lines.Add('the dataview, which was required to achieve this level of');
  Memo1.Lines.Add('customization in previous versions of ReportBuilder.');

  Memo1.Lines.EndUpdate;

end;



end.
