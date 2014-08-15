{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppCOrDlg;

interface

{$I ppIfDef.pas}

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  Buttons,
  ExtCtrls,
  
  ppForms,
  ppDesignerForms,
  ppTreeVw,
  ppTypes,
  ppPrnabl,
  ppClass,
  ppCtrls,
  ppBands,
  ppCache,
  ppComm,
  ppProd,
  ppReport,
  ppVar,
  ppUtils;

type

  TppGetVariableProc = procedure(aVariable: TppVariable) of object;


  TppCalcOrderDialog = class(TppCustomCalcOrderDialog)
    Panel1: TPanel;
    spbMoveUp: TSpeedButton;
    lblOrder: TLabel;
    spbMoveDown: TSpeedButton;
    btnOK: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure spbMoveUpClick(Sender: TObject);
    procedure spbMoveDownClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    FReport: TppCustomReport;
    FReportExplorer: TppCustomReportExplorer;
    FOrderState: TStringList;
    FBandTreeBuilder: TppReportBandTreeBuilder;
    FVariableListBuilder: TppVariableListBuilder;

    procedure ProcessVariables(aVariableProc: TppGetVariableProc);
    procedure SaveCalcOrderState(aVariable: TppVariable);
    procedure RestoreCalcOrderState(aVariable: TppVariable);

  protected
    procedure LanguageChanged; override;
    procedure ReportAssigned; override;

    function GetCurrentBand: TComponent; override;
    procedure SetCurrentBand(aBand: TComponent); override;

  public


  end;

var
  ppCalcOrderDialog: TppCalcOrderDialog;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TppCalcOrderDialog.FormCreate}

procedure TppCalcOrderDialog.FormCreate(Sender: TObject);
begin
  FReportExplorer := TppCustomReportExplorer.Create(Panel1, ppeoHorizontal);
  FReportExplorer.TreeView.ShowRoot := False;
  FReportExplorer.ListView.AllowDrag := True;
  FReportExplorer.ListView.ReadOnly := False;

  FBandTreeBuilder := TppReportBandTreeBuilder.Create(FReportExplorer.TreeView);
  FVariableListBuilder := TppVariableListBuilder.Create(FReportExplorer.ListView);

  FReportExplorer.TreePanel.Width := Panel1.Width div 2;
  FReportExplorer.ListView.Width  := Panel1.Width div 2;
  FReportExplorer.ListView.Columns[0].Width := FReportExplorer.ListView.Width-5;

  FOrderState := TStringList.Create;

end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TppCalcOrderDialog.FormDestroy}

procedure TppCalcOrderDialog.FormDestroy(Sender: TObject);
begin
  FBandTreeBuilder.Free;
  FVariableListBuilder.Free;

  FReportExplorer.Free;

  FOrderState.Free;
end; {procedure, FormDestroy}

{------------------------------------------------------------------------------}
{ TppCalcOrderDialog.ReportAssigned}

procedure TppCalcOrderDialog.ReportAssigned;
begin

  if not (Report is TppCustomReport) then Exit;

  FReport := TppCustomReport(Report);

  FReportExplorer.Report := FReport;

  {save current calc order state}
  ProcessVariables(SaveCalcOrderState);
  
end; {procedure, ReportAssigned}

{------------------------------------------------------------------------------}
{ TppCalcOrderDialog.SetCurrentBand}

procedure TppCalcOrderDialog.SetCurrentBand(aBand: TComponent);
begin
  FReportExplorer.TreeView.SelectComponent(aBand);

end; {procedure, SetCurrentBand}

{------------------------------------------------------------------------------}
{ TppCalcOrderDialog.GetCurrentBand}

function TppCalcOrderDialog.GetCurrentBand: TComponent;
begin
  Result := FReportExplorer.TreeView.SelectedComponent;

end; {function, GetCurrentBand}

{------------------------------------------------------------------------------}
{ TppCalcOrderDialog.spbMoveUpClick}

procedure TppCalcOrderDialog.spbMoveUpClick(Sender: TObject);
var
  lComponent: TComponent;
  lVariable: TppVariable;

begin
  lComponent := FReportExplorer.ListView.SelectedComponent;

  if not (lComponent is TppVariable) then Exit;

  lVariable := TppVariable(lComponent);

  if lVariable.CalcOrder <= 0 then Exit;

  lVariable.CalcOrder := lVariable.CalcOrder - 1;

  FReportExplorer.ListView.UpdateComponent(lVariable);

end; {procedure, spbMoveUpClick}

{------------------------------------------------------------------------------}
{ TppCalcOrderDialog.spbMoveDownClick}

procedure TppCalcOrderDialog.spbMoveDownClick(Sender: TObject);
var
  lComponent: TComponent;
  lVariable: TppVariable;

begin
  lComponent := FReportExplorer.ListView.SelectedComponent;

  if not (lComponent is TppVariable) then Exit;

  lVariable := TppVariable(lComponent);

  if lVariable.CalcOrder >= FReportExplorer.ListView.Items.Count-1 then Exit;

  lVariable.CalcOrder := lVariable.CalcOrder + 1;

  FReportExplorer.ListView.UpdateComponent(lVariable);

end; {procedure, spbMoveDownClick}

{------------------------------------------------------------------------------}
{ TppCalcOrderDialog.btnCancelClick}

procedure TppCalcOrderDialog.btnCancelClick(Sender: TObject);
begin
  {restore calc order state}
  ProcessVariables(RestoreCalcOrderState);
end;  {procedure, btnCancelClick}

{------------------------------------------------------------------------------}
{ TppCalcOrderDialog.SaveCalcOrderState}

procedure TppCalcOrderDialog.SaveCalcOrderState(aVariable: TppVariable);
begin
  FOrderState.AddObject(IntToStr(aVariable.CalcOrder), aVariable);
end; {procedure, SaveCalcOrderState}

{------------------------------------------------------------------------------}
{ TppCalcOrderDialog.RestoreCalcOrderState}

procedure TppCalcOrderDialog.RestoreCalcOrderState(aVariable: TppVariable);
var
  liIndex: Integer;
begin
  liIndex := FOrderState.IndexOfObject(aVariable);

  if liIndex >= 0 then
    aVariable.CalcOrder := StrToInt(FOrderState[liIndex]);

end; {procedure, RestoreCalcOrderState}

{------------------------------------------------------------------------------}
{ TppCalcOrderDialog.ProcessVariables}

procedure TppCalcOrderDialog.ProcessVariables(aVariableProc: TppGetVariableProc);
var
  liBand: Integer;
  liVariable: Integer;
  lBand: TppBand;
begin

  if FReport = nil then Exit;

  for liBand := 0 to (FReport.BandCount-1) do
    begin

      lBand := FReport.Bands[liBand];

      for liVariable := 0 to (lBand.VariableCount-1) do
        aVariableProc(TppVariable(lBand.Variables[liVariable]));

    end;

end; {procedure, ProcessVariables}

{------------------------------------------------------------------------------}
{ TppCalcOrderDialog.LanguageChanged}

procedure TppCalcOrderDialog.LanguageChanged;
begin

  Caption := ppLoadStr(656); {'Calc Order'}

  lblOrder.Caption := ppLoadStr(255); {'Order'}

  FReportExplorer.TreeCaption := ppLoadStr(657); {'Report Bands'}
  FReportExplorer.ListCaption := ppLoadStr(658); {'Variables'}

  btnOK.Caption := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

end; {procedure, LanguageChanged}


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomCalcOrderDialog, TppCalcOrderDialog);

finalization

  ppUnRegisterForm(TppCustomCalcOrderDialog);

end.
