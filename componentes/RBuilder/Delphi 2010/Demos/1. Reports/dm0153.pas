{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0153;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ExtCtrls,
  ppSubRpt, ppProd, ppViewr, ComCtrls, Tabnotbk, Mask, Buttons,
  ppDevice, ppTypes, ppUtils, ppDBPipe, ppVar, ppRelatv;

type
  Tfrm0153 = class(TdmCustomForm)
    tblCustomer: TTable;
    dsCustomer: TDataSource;
    plCustomer: TppBDEPipeline;
    ppOrderDetail: TppReport;
    tblOrder: TTable;
    dsOrder: TDataSource;
    plOrder: TppBDEPipeline;
    tblEmployee: TTable;
    dsEmployee: TDataSource;
    plEmployee: TppBDEPipeline;
    pnlPreviewBar: TPanel;
    spbPreviewPrint: TSpeedButton;
    spbPreviewWhole: TSpeedButton;
    spbPreviewFirst: TSpeedButton;
    spbPreviewPrior: TSpeedButton;
    spbPreviewNext: TSpeedButton;
    spbPreviewLast: TSpeedButton;
    spbPreviewWidth: TSpeedButton;
    spbPreview100Percent: TSpeedButton;
    mskPreviewPercentage: TMaskEdit;
    mskPreviewPage: TMaskEdit;
    Panel5: TPanel;
    spbPreviewClose: TSpeedButton;
    TabbedNotebook1: TTabbedNotebook;
    Panel7: TPanel;
    ppViewer1: TppViewer;
    pnlStatusBar: TPanel;
    ppOrderListHeaderBand1: TppHeaderBand;
    ppOrderListLabel1: TppLabel;
    ppOrderListLabel2: TppLabel;
    ppOrderListShape1: TppShape;
    ppOrderListLabel3: TppLabel;
    ppOrderListLabel4: TppLabel;
    ppOrderListDBText1: TppDBText;
    ppOrderListDBText2: TppDBText;
    ppOrderListDetailBand1: TppDetailBand;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppDetailBand1: TppDetailBand;
    ppOrderListDBText3: TppDBText;
    ppOrderListDBText6: TppDBText;
    ppOrderListDBText10: TppDBText;
    ppOrderListDBText4: TppDBText;
    ppOrderListDBText8: TppDBText;
    ppOrderListDBText5: TppDBText;
    ppOrderListDBText7: TppDBText;
    ppOrderListLine1: TppLine;
    ppOrderListLine2: TppLine;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
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
    ppGroupFooterBand1: TppGroupFooterBand;
    ppOrderListLine4: TppLine;
    ppOrderListLine3: TppLine;
    ppOrderListDBText9: TppDBText;
    ppOrderListLabel14: TppLabel;
    ppOrderListDBCalc1: TppDBCalc;
    ppOrderListFooterBand1: TppFooterBand;
    ppOrderListCalc1: TppSystemVariable;
    ppOrderListCalc2: TppSystemVariable;
    ppOrderListCalc3: TppSystemVariable;
    OrderHighlight: TppShape;
    ppLabelContinued: TppLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure TabbedNotebook1Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
    procedure ppOrderDetailDetailBand1BeforePrint(Sender: TObject);
    procedure ppViewer1PrintStateChange(Sender: TObject);
    procedure ppViewer1StatusChange(Sender: TObject);
    procedure ppViewer1PageChange(Sender: TObject);
    procedure spbPreviewCloseClick(Sender: TObject);
    procedure spbPreviewPrintClick(Sender: TObject);
    procedure spbPreviewWidthClick(Sender: TObject);
    procedure spbPreview100PercentClick(Sender: TObject);
    procedure spbPreviewWholeClick(Sender: TObject);
    procedure spbPreviewFirstClick(Sender: TObject);
    procedure spbPreviewPriorClick(Sender: TObject);
    procedure spbPreviewNextClick(Sender: TObject);
    procedure spbPreviewLastClick(Sender: TObject);
    procedure mskPreviewPageKeyPress(Sender: TObject; var Key: Char);
    procedure mskPreviewPercentageKeyPress(Sender: TObject; var Key: Char);
    procedure OrderHighlightDrawCommandClick(Sender,
      aDrawCommand: TObject);
    procedure OrderHighlightDrawCommandCreate(Sender,
      aDrawCommand: TObject);
    procedure Panel7Click(Sender: TObject);

  private
    FReports: TStringList;
    FClosingSpawnedReport: Boolean;
    FCreatingSpawnedReport: Boolean;
    FCurrentViewer: TppViewer;
    FCurrentReport: TppReport;

    procedure SelectReport(aIndex: Integer);
    procedure SetViewer(aViewer: TppViewer);
    procedure SpawnReport(aOrderNo: Integer);
    procedure ViewerToPreviewBar;

  protected
    function GetReport: TppProducer; override;
    procedure Init; override;

  public
    { Public declarations }
  end;

  { TmySpawnedReport }
  TmySpawnedReport = class(TppCommunicator)
    private
      FCalcItemTotal: TppVariable;
      FCalcOrderTotal: TppVariable;
      FItemQuery: TQuery;
      FItemDataSource: TDataSource;
      FItemPipeline: TppBDEPipeline;
      FPartTable: TTable;
      FPartDataSource: TDataSource;
      FPartPipeline: TppBDEPipeline;
      FReport: TppReport;
      FViewer: TppViewer;

      procedure RetrieveCalcs;

    public
      constructor CreateSpawn(aOwner: TComponent; aOrderNo: Longint; aParent: TWinControl);
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      property Report: TppReport read FReport;
      property Viewer: TppViewer read FViewer;

    published
      {publish these event handlers so they reconnect error-free}
      procedure ppCalcItemTotalCalc(Sender: TObject; var Value: Variant);
      procedure ppCalcOrderTotalCalc(Sender: TObject; var Value: Variant);

  end; {class, TmySpawnedReport}

var
  frm0153: Tfrm0153;

implementation

{$R *.DFM}

{******************************************************************************
 *
 ** F O R M   E V E N T S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ Tfrm0153.FormCreate }

procedure Tfrm0153.FormCreate(Sender: TObject);
begin
  FReports := TStringList.Create;
  FReports.AddObject('0', ppViewer1);

  FCurrentViewer := ppViewer1;
  FCurrentReport := ppOrderDetail;

  FClosingSpawnedReport := False;
  FCreatingSpawnedReport := False;
end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ Tfrm0153.Init }

procedure Tfrm0153.Init;
begin
  DisplayFormModal := True;
end; {procedure, Init}

{------------------------------------------------------------------------------}
{ Tfrm0153.FormCreate }

procedure Tfrm0153.FormActivate(Sender: TObject);
begin
  SelectReport(0);
end; {procedure, FormActivate}

{------------------------------------------------------------------------------}
{ Tfrm0153.FormDestroy }

procedure Tfrm0153.FormDestroy(Sender: TObject);
var
  liIndex: Integer;
begin
  for liIndex := 1 to FReports.Count - 1 do
    TmySpawnedReport(FReports.Objects[liIndex]).Free;

  FReports.Free;
end; {procedure, FormDestroy}

{------------------------------------------------------------------------------}
{ Tfrm0153.TabbedNotebook1Change }

procedure Tfrm0153.TabbedNotebook1Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
begin
  if FClosingSpawnedReport or FCreatingSpawnedReport then
    AllowChange := False
  else
    SelectReport(NewTab);
end; {procedure, TabbedNotebook1Change}

{------------------------------------------------------------------------------}
{ Tfrm0153.OrderHighlightDrawCommandClick }

procedure Tfrm0153.OrderHighlightDrawCommandClick(Sender, aDrawCommand: TObject);
begin
  SpawnReport(TppDrawCommand(aDrawCommand).Tag);
end; {procedure, DrawCommandClick}

{------------------------------------------------------------------------------}
{ Tfrm0153.OrderHighlightDrawCommandCreate }

procedure Tfrm0153.OrderHighlightDrawCommandCreate(Sender, aDrawCommand: TObject);
begin
  TppDrawCommand(aDrawCommand).Tag := tblOrder.FieldByName('OrderNo').AsInteger;
end;  {procedure, DrawCommandCreate}

{------------------------------------------------------------------------------}
{ Tfrm0153.SpawnReport }

procedure Tfrm0153.SpawnReport(aOrderNo: Integer);
var
  liIndex: Integer;
  lSpawnedReport: TmySpawnedReport;
  lsPageName: String;
  lParent: TWinControl;
begin
  TabbedNotebook1.Enabled := False;

  liIndex := FReports.IndexOf(IntToStr(aOrderNo));

  if (liIndex = -1) then
    begin
      FCreatingSpawnedReport := True;

      Cursor := crHourGlass;

      lsPageName := 'Order No: ' + IntToStr(aOrderNo);

      TabbedNotebook1.Pages.Add(lsPageName);

      lParent := TWinControl(TabbedNotebook1.Pages.Objects[TabbedNotebook1.Pages.Count - 1]);
      lSpawnedReport := TmySpawnedReport.CreateSpawn(Self, aOrderNo, lParent);

      FReports.AddObject(IntToStr(aOrderNo), lSpawnedReport);

      Cursor := crDefault;

      FCreatingSpawnedReport := False;

      liIndex := FReports.Count - 1;
    end;

  TabbedNotebook1.PageIndex := liIndex;

  TabbedNotebook1.Enabled := True;

end; {procedure, SpawnReport}

{------------------------------------------------------------------------------}
{ Tfrm0153.SelectReport }

procedure Tfrm0153.SelectReport(aIndex: Integer);
var
  lSpawnedReport: TmySpawnedReport;
begin

  if (aIndex = 0) then
    SetViewer(ppViewer1)

  else
    begin
      lSpawnedReport := TmySpawnedReport(FReports.Objects[aIndex]);
      SetViewer(lSpawnedReport.Viewer);
    end;

  if (FCurrentReport.Tag = 0) then
    begin
      FCurrentReport.Tag := 1;
      FCurrentReport.PrintToDevices;
    end
  else
    ViewerToPreviewBar;

end; {procedure, SelectReport}

{------------------------------------------------------------------------------}
{ Tfrm0153.SetViewer }

procedure Tfrm0153.SetViewer(aViewer: TppViewer);
begin
  {clear viewer event handlers}
  if (FCurrentViewer <> nil) then
    begin
      FCurrentViewer.OnPageChange := nil;
      FCurrentViewer.OnPrintStateChange := nil;
      FCurrentViewer.OnStatusChange := nil;
    end;

  FCurrentViewer := aViewer;
  FCurrentReport := TppReport(aViewer.Report);

  {assign viewer event handlers}
  if (FCurrentViewer <> nil) then
    begin
      FCurrentViewer.OnPageChange := ppViewer1PageChange;
      FCurrentViewer.OnPrintStateChange := ppViewer1PrintStateChange;
      FCurrentViewer.OnStatusChange := ppViewer1StatusChange;
    end;

end; {procedure, SetViewer}

{------------------------------------------------------------------------------}
{ Tfrm0153.GetReport}

function Tfrm0153.GetReport: TppProducer;
begin
  Result := ppOrderDetail;
end;

procedure Tfrm0153.Label7Click(Sender: TObject);
begin

end;

{------------------------------------------------------------------------------}
{ Tfrm0153.ppOrderDetailDetailBand1BeforePrint}

procedure Tfrm0153.ppOrderDetailDetailBand1BeforePrint(Sender: TObject);
begin
  ppLabelContinued.Visible := ppOrderDetail.DetailBand.OverFlow;
end;

{******************************************************************************
 *
 ** V I E W E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ Tfrm0153.ViewerToPreviewBar }

procedure Tfrm0153.ViewerToPreviewBar;
begin

  case FCurrentViewer.ZoomSetting of
    zsPageWidth:
      spbPreviewWidth.Down := True;

    zsWholePage:
      spbPreviewWhole.Down := True;

    zs100Percent:
      spbPreview100Percent.Down := True;
  end;

  mskPreviewPage.Text := IntToStr(FCurrentViewer.AbsolutePageNo);
  mskPreviewPercentage.Text := IntToStr(FCurrentViewer.CalculatedZoom);
  pnlStatusBar.Caption := FCurrentViewer.Status;

end; {procedure, ViewerToPreviewBar}

{------------------------------------------------------------------------------}
{ Tfrm0153.ppViewer1PrintStateChange }

procedure Tfrm0153.ppViewer1PrintStateChange(Sender: TObject);
var
  lPosition: TPoint;
begin

  if FCurrentViewer.Busy then
    begin
      mskPreviewPercentage.Enabled := False;
      mskPreviewPage.Enabled := False;

      pnlPreviewBar.Cursor := crHourGlass;

      FCurrentViewer.Cursor := crHourGlass;

      pnlStatusBar.Cursor := crHourGlass;

      spbPreviewClose.Cursor := crArrow;

      spbPreviewClose.Caption := ppLoadStr(ppMsgCancel);
    end
  else
    begin
      mskPreviewPercentage.Enabled := True;
      mskPreviewPage.Enabled := True;

      pnlPreviewBar.Cursor := crDefault;

      FCurrentViewer.Cursor := crDefault;

      pnlStatusBar.Cursor := crDefault;

      spbPreviewClose.Cursor := crDefault;

      spbPreviewClose.Caption := ppLoadStr(ppMsgClose);
    end;

  {this code will force the cursor to update}
  GetCursorPos(lPosition);
  SetCursorPos(lPosition.X, lPosition.Y);

end; {procedure, ppViewer1PrintStateChange}

{------------------------------------------------------------------------------}
{ Tfrm0153.ppViewer1StatusChange }

procedure Tfrm0153.ppViewer1StatusChange(Sender: TObject);
begin
  pnlStatusBar.Caption := FCurrentViewer.Status;
end; {procedure, ppViewer1StatusChange}

{------------------------------------------------------------------------------}
{ Tfrm0153.ppViewerPageChange }

procedure Tfrm0153.ppViewer1PageChange(Sender: TObject);
begin
  mskPreviewPage.Text := IntToStr(FCurrentViewer.AbsolutePageNo);
  mskPreviewPercentage.Text := IntToStr(FCurrentViewer.CalculatedZoom);
end; {procedure, ppViewerPageChange}

{------------------------------------------------------------------------------}
{ Tfrm0153.spbPreviewPrintClick }

procedure Tfrm0153.spbPreviewPrintClick(Sender: TObject);
begin
  FCurrentViewer.Print;
end; {procedure, spbPreviewPrintClick}

{------------------------------------------------------------------------------}
{ Tfrm0153.spbPreviewCancelClick }

procedure Tfrm0153.spbPreviewCloseClick(Sender: TObject);
var
  liIndex: Integer;
begin
  if (FCurrentReport <> nil) and FCurrentReport.Printing then
    ppViewer1.Cancel

  else if (TabbedNotebook1.PageIndex = 0) then
    Close

  else if (TabbedNotebook1.PageIndex > 0) then
    begin
      FCurrentReport := nil;
      FCurrentViewer := nil;

      liIndex := TabbedNotebook1.PageIndex;

      // delete spawned report object
      TmySpawnedReport(FReports.Objects[liIndex]).Free;

      // select prior page
      TabbedNotebook1.PageIndex := liIndex - 1;

      // delete page
      TabbedNotebook1.Pages.Delete(liIndex);

      FReports.Delete(liIndex);


    end;

end; {procedure, spbPreviewCancelClick}

{------------------------------------------------------------------------------}
{ Tfrm0153.spbPreviewFirstClick}

procedure Tfrm0153.spbPreviewFirstClick(Sender: TObject);
begin
  FCurrentViewer.FirstPage;
end; {procedure, spbCloseClick}

{------------------------------------------------------------------------------}
{ Tfrm0153.spbPreviewPriorClick}

procedure Tfrm0153.spbPreviewPriorClick(Sender: TObject);
begin
  FCurrentViewer.PriorPage;
end; {procedure, spbPreviewFirstClick}

{------------------------------------------------------------------------------}
{ Tfrm0153.spbPreviewNextClick}

procedure Tfrm0153.spbPreviewNextClick(Sender: TObject);
begin
  FCurrentViewer.NextPage;
end; {procedure, spbPreviewNextClick}

{------------------------------------------------------------------------------}
{ Tfrm0153.spbPreviewLastClick}

procedure Tfrm0153.spbPreviewLastClick(Sender: TObject);
begin
  FCurrentViewer.LastPage;
end; {procedure, spbPreviewLastClick}

{------------------------------------------------------------------------------}
{ Tfrm0153.mskPreviewPageKeyPress}

procedure Tfrm0153.mskPreviewPageKeyPress(Sender: TObject; var Key: Char);
var
  liPage: Longint;
begin

  if (Key = #13) then
    begin
      liPage := StrToInt(mskPreviewPage.Text);

      FCurrentViewer.GotoPage(liPage);
    end; {if, carriage return pressed}

end; {procedure, mskPreviewPageKeyPress}

{------------------------------------------------------------------------------}
{ Tfrm0153.spbPreviewZoomClick }

procedure Tfrm0153.spbPreviewWholeClick(Sender: TObject);
begin
  FCurrentViewer.ZoomSetting := zsWholePage;

  mskPreviewPercentage.Text := IntToStr(FCurrentViewer.CalculatedZoom);

  pnlPreviewBar.SetFocus;
end; {procedure, spbPreviewZoomClick}

{------------------------------------------------------------------------------}
{ Tfrm0153.spbPreviewWidthClick}

procedure Tfrm0153.spbPreviewWidthClick(Sender: TObject);
begin
  FCurrentViewer.ZoomSetting := zsPageWidth;

  mskPreviewPercentage.Text := IntToStr(FCurrentViewer.CalculatedZoom);

  pnlPreviewBar.SetFocus;
end; {procedure, spbPreviewWidthClick}

{------------------------------------------------------------------------------}
{ Tfrm0153.spbPreview100PercentClick}

procedure Tfrm0153.spbPreview100PercentClick(Sender: TObject);
begin
  FCurrentViewer.ZoomSetting := zs100Percent;

  mskPreviewPercentage.Text := IntToStr(FCurrentViewer.CalculatedZoom);

  pnlPreviewBar.SetFocus;
end; {procedure, spbPreview100PercentClick}

{------------------------------------------------------------------------------}
{ Tfrm0153.mskPreviewPercentageKeyPress}

procedure Tfrm0153.mskPreviewPercentageKeyPress(Sender: TObject; var Key: Char);
var
  liPercentage: Integer;
begin
  if (Key = #13) then
    begin
      liPercentage := StrToIntDef(mskPreviewPercentage.Text, 100);

      FCurrentViewer.ZoomPercentage := liPercentage;

      spbPreviewWhole.Down := False;
      spbPreviewWidth.Down := False;
      spbPreview100Percent.Down := False;

      mskPreviewPercentage.Text := IntToStr(FCurrentViewer.CalculatedZoom);
    end; {if, carriage return pressed}

end; {procedure, mskPreviewPercentageKeyPress}

procedure Tfrm0153.Panel7Click(Sender: TObject);
begin

end;

{******************************************************************************
 *
 ** S P A W N E D   R E P O R T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TmySpawnedReport.CreateSpawn }

constructor TmySpawnedReport.CreateSpawn(aOwner: TComponent;
                                         aOrderNo: Integer;
                                         aParent: TWinControl);
begin
  inherited Create(nil);

  {create the items query}
  FItemQuery := TQuery.Create(Self);
  FItemQuery.Name := 'qryItem';
  FItemQuery.DatabaseName := 'DBDemos';
  FItemQuery.SQL.Add('select * from items where orderno = :piOrderNo order by orderno');
  FItemQuery.Params[0].DataType := ftInteger;
  FItemQuery.Params[0].AsInteger := aOrderNo;
  FItemDataSource := TDataSource.Create(Self);
  FItemDataSource.Name := 'dsItem';
  FItemDataSource.DataSet := FItemQuery;
  FItemPipeline := TppBDEPipeline.Create(Self);
  FItemPipeline.Name := 'plItem';
  FItemPipeline.DataSource := FItemDataSource;

  {create the parts lookup table}
  FPartTable := TTable.Create(Self);
  FPartTable.DatabaseName := 'DBDemos';
  FPartTable.TableName := 'Parts';
  FPartTable.MasterSource := FItemDataSource;
  FPartTable.MasterFields := 'PartNo';
  FPartDataSource :=  TDataSource.Create(Self);
  FPartDataSource.Name := 'dsPart';
  FPartDataSource.DataSet := FPartTable;
  FPartPipeline := TppBDEPipeline.Create(Self);
  FPartPipeline.Name := 'plPart';
  FPartPipeline.DataSource := FPartDataSource;

  {create the report}
  FReport := TppReport.Create(Self);
  FReport.Template.FileName := ExtractFilePath(ParamStr(0)) + 'template\items.rtm';
  FReport.Template.LoadFromFile;

  FViewer := TppViewer.Create(Self);
  FViewer.Parent := aParent;
  FViewer.Align := alClient;
  FViewer.BevelOuter := bvNone;
  FViewer.ZoomSetting := zs100Percent;
  FViewer.Report := FReport;

  FCalcItemTotal := nil;
  FCalcOrderTotal := nil;

  RetrieveCalcs;

  {keep the report from running}
  FReport.Tag := 0;

end; {constructor, CreateSpawn}

{------------------------------------------------------------------------------}
{ TmySpawnedReport.Destroy }

destructor TmySpawnedReport.Destroy;
begin

  FItemQuery.Free;
  FItemDataSource.Free;
  FItemPipeline.Free;
  FPartTable.Free;
  FPartDataSource.Free;
  FPartPipeline.Free;
  FReport.Free;
  FViewer.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TmySpawnedReport.Notify }

procedure TmySpawnedReport.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin
  inherited Notify(aCommunicator, aOperation);

  {if (FViewer.ScreenDevice = aCommunicator) and (aOperation = ppopRemove) then
    FViewer := nil;}

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TmySpawnedReport.RetrieveCalcs}

procedure TmySpawnedReport.RetrieveCalcs;
var
  liIndex: Integer;
  lBand: TppBand;
begin

  liIndex := 0;
  lBand := FReport.GetBand(btDetail, 0);

  while (FCalcItemTotal = nil) and (liIndex < lBand.ObjectCount) do
    begin
      if (lBand.Objects[liIndex] is TppVariable) then
        FCalcItemTotal := TppVariable(lBand.Objects[liIndex])
      else
        Inc(liIndex);
    end;

  liIndex := 0;
  lBand := FReport.GetBand(btGroupFooter, 0);

  while (FCalcOrderTotal = nil) and (liIndex < lBand.ObjectCount) do
    begin
      if (lBand.Objects[liIndex] is TppVariable) then
        FCalcOrderTotal := TppVariable(lBand.Objects[liIndex])
      else
        Inc(liIndex);
    end;

end; {procedure, RetrieveCalcs}

{------------------------------------------------------------------------------}
{ TmySpawnedReport.ppCalcItemTotalCalc}

procedure TmySpawnedReport.ppCalcItemTotalCalc(Sender: TObject; var Value: Variant);
begin
  {event handler for TppCalc.OnCalc event of the child report's item total field,
    ItemTotal = Quantity * Price }
  FCalcItemTotal.AsFloat := FItemQuery.FieldByName('Qty').AsInteger * FPartTable.FieldByName('ListPrice').AsFloat;

end;

{------------------------------------------------------------------------------}
{ TmySpawnedReport.ppCalcOrderTotalCalc}

procedure TmySpawnedReport.ppCalcOrderTotalCalc(Sender: TObject; var Value: Variant);
begin
  {event handler for TppCalc.OnCalc event of the child report's order total field,
    OrderTotal = sum(ItemTotal) }
 FCalcOrderTotal.AsFloat := FCalcOrderTotal.AsFloat + FCalcItemTotal.AsFloat;
end;


end. 
