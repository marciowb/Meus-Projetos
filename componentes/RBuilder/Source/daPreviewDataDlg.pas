{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit daPreviewDataDlg;

interface

{$I ppIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Grids, DB, DBGrids, StdCtrls, DBCtrls, ExtCtrls, Buttons,
  ppTypes, ppClass, ppDB, ppUtils, ppForms,
  daForms, daDataView;

type

  { TdaPreviewDataDialog }

  TdaPreviewDataDialog = class(TdaCustomPreviewDataDialog)
    dbgData: TDBGrid;
    Panel1: TPanel;
    btnOK: TButton;
    edtRecordNo: TEdit;
    lblRecord: TLabel;
    lblRecordCount: TLabel;
    spbFirst: TSpeedButton;
    spbPrior: TSpeedButton;
    spbNext: TSpeedButton;
    spbLast: TSpeedButton;
    procedure spbFirstClick(Sender: TObject);
    procedure spbPriorClick(Sender: TObject);
    procedure spbNextClick(Sender: TObject);
    procedure spbLastClick(Sender: TObject);
    procedure edtRecordNoExit(Sender: TObject);

  private
    FRecordCount: Longint;
    FCurrentRecord: Longint;
    FDataSet: TDataSet;
    FDataView: TdaCustomDataView;

    procedure CreateColumns;
    procedure CreateMagicColumns;
    function GetDataSource: TDataSource;
    function GetDataSourceFromDataPipeline: TDataSource;
    procedure MoveBy(aIncrement: Longint);
    procedure SetDataSource(aDataSource: TDataSource);

  protected
    procedure LanguageChanged; override;
    procedure SetDataView(aDataView: TComponent); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    property DataSource: TDataSource read GetDataSource write SetDataSource;

  end; {class, TdaPreviewDataDialog}

var
  daPreviewDataDialog: TdaPreviewDataDialog;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TdaPreviewDataDialog.Create }

constructor TdaPreviewDataDialog.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaPreviewDataDialog.Destroy }

destructor TdaPreviewDataDialog.Destroy;
begin

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaPreviewDataDialog.SetDataView }

procedure TdaPreviewDataDialog.SetDataView(aDataView: TComponent);
begin

  inherited SetDataView(aDataView);

  FDataView := TdaCustomDataView(aDataView);

  if (DataView = nil) then Exit;

  FDataView.Active := True;

  SetDataSource(GetDataSourceFromDataPipeline);

  if (ShowMagicFields) then
    CreateMagicColumns;

  CreateColumns;

end; {procedure, SetDataView}

{------------------------------------------------------------------------------}
{ TdaPreviewDataDialog.GetDataSourceFromDataPipeline; }

function TdaPreviewDataDialog.GetDataSourceFromDataPipeline: TDataSource;
var
  lDataPipeline: TppDataPipeline;
begin

  Result := nil;

  if (FDataView.DataPipelineCount = 0) then Exit;

  lDataPipeline := FDataView.DataPipelines[0];

  if ppCheckPropInfo(lDataPipeline, 'DataSource') then
    Result := TDataSource(ppGetOrdPropValue(lDataPipeline, 'DataSource'));

end; {function, GetDataSourceFromDataPipeline}

{------------------------------------------------------------------------------}
{ TdaPreviewDataDialog.CreateColumns }

procedure TdaPreviewDataDialog.CreateColumns;
var
  lDataPipeline: TppDataPipeline;
  liIndex: Integer;
  lField: TppField;
  lColumn: TColumn;
begin

  if (FDataView.DataPipelineCount = 0) then Exit;

  lDataPipeline := FDataView.DataPipelines[0];

  for liIndex := 0 to lDataPipeline.FieldCount - 1 do
    begin
      lField := lDataPipeline.Fields[liIndex];

      lColumn := TColumn.Create(dbgData.Columns);
      lColumn.FieldName := lField.FieldName;
      lColumn.Title.Caption := lField.FieldAlias;

      lColumn.Title.Font.Color := FDataView.GetLinkColorForField(lField.FieldName);

      if (lColumn.Title.Font.Color <> 0) then
        lColumn.Title.Font.Style := [fsBold];
    end;

end; {procedure, CreateColumns}

{------------------------------------------------------------------------------}
{ TdaPreviewDataDialog.CreateMagicColumns }

procedure TdaPreviewDataDialog.CreateMagicColumns;
var
  liIndex: Integer;
  lField: TField;
  lColumn: TColumn;
  liMagicFieldCount: Integer;
begin

  if (FDataSet = nil) then Exit;

  liMagicFieldCount := FDataView.GetMagicFieldCount;

  for liIndex := 0 to liMagicFieldCount - 1 do
    begin
      lField := FDataSet.Fields[liIndex];

      lColumn := TColumn.Create(dbgData.Columns);
      lColumn.FieldName := lField.FieldName;
      lColumn.Title.Font.Style := [fsBold]
    end;

end; {procedure, CreateMagicColumns}

{------------------------------------------------------------------------------}
{ TdaPreviewDataDialog.LanguageChanged; }

procedure TdaPreviewDataDialog.LanguageChanged;
begin

  if FDataView <> nil then
    Caption := ppLoadStr(808) + ' - ' + FDataView.Description {Preview Data}
  else
    Caption := ppLoadStr(808); {Preview Data}

  btnOK.Caption := ppLoadStr(ppMsgOK); {OK}

  lblRecord.Caption := ppLoadStr(812); {Record}

end; {procedure, LanguageChanged}

{------------------------------------------------------------------------------}
{ TdaPreviewDataDialog.SetDataSource }

procedure TdaPreviewDataDialog.SetDataSource(aDataSource: TDataSource);
begin

  if (aDataSource <> nil) then
    FDataSet := aDataSource.DataSet
  else
    FDataSet := nil;

  if FDataSet <> nil then
    FRecordCount := FDataSet.RecordCount
  else
    FRecordCount := 0;

  if (FRecordCount = -1) then
    lblRecordCount.Caption := ''
  else
    lblRecordCount.Caption := ppLoadStr(800) + ' ' + IntToStr(FRecordCount); {of}

  FCurrentRecord := 0;

  MoveBy(1);

  dbgData.DataSource := aDataSource;

end; {procedure, SetDataSource}

{------------------------------------------------------------------------------}
{ TdaPreviewDataDialog.GetDataSource }

function TdaPreviewDataDialog.GetDataSource: TDataSource;
begin
  Result := dbgData.DataSource;
end; {procedure, GetDataSource}

{------------------------------------------------------------------------------}
{ TdaPreviewDataDialog.MoveBy }

procedure TdaPreviewDataDialog.MoveBy(aIncrement: Longint);
begin

  if (FDataSet = nil) then Exit;

  Inc(FCurrentRecord, aIncrement);

  if (FCurrentRecord <= 1) then
    begin
      FCurrentRecord := 1;
      FDataSet.First;
    end

  else if (FCurrentRecord >= FRecordCount) then
    begin
      FCurrentRecord := FRecordCount;
      FDataSet.Last;
    end

  else
    FDataSet.MoveBy(aIncrement);

  edtRecordNo.Text := IntToStr(FCurrentRecord);

end; {procedure, MoveBy}

{------------------------------------------------------------------------------}
{ TdaPreviewDataDialog.FirstClick }

procedure TdaPreviewDataDialog.spbFirstClick(Sender: TObject);
begin
  MoveBy((FRecordCount + 1) * -1);
end; {procedure, spbFirstClick}

{------------------------------------------------------------------------------}
{ TdaPreviewDataDialog.PriorClick }

procedure TdaPreviewDataDialog.spbPriorClick(Sender: TObject);
begin
  MoveBy(-1);
end; {procedure, spbPriorClick}

{------------------------------------------------------------------------------}
{ TdaPreviewDataDialog.NextClick }

procedure TdaPreviewDataDialog.spbNextClick(Sender: TObject);
begin
  MoveBy(1);
end; {procedure, spbNextClick}

{------------------------------------------------------------------------------}
{ TdaPreviewDataDialog.LastClick }

procedure TdaPreviewDataDialog.spbLastClick(Sender: TObject);
begin
  MoveBy(FRecordCount + 1);
end; {procedure, spbLastClick}

{------------------------------------------------------------------------------}
{ TdaPreviewDataDialog.RecordNoExit }

procedure TdaPreviewDataDialog.edtRecordNoExit(Sender: TObject);
var
  liNewRecord: Longint;
begin

  try
    liNewRecord := StrToInt(edtRecordNo.Text);
    MoveBy(liNewRecord - FCurrentRecord);
  except
    ShowMessage(ppLoadStr(332)); {message: Invalid Number.}

    edtRecordNo.Text := IntToStr(FCurrentRecord);
  end; {try, except}

end; {procedure, edtRecordNoExit}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TdaCustomPreviewDataDialog, TdaPreviewDataDialog);

finalization

  ppUnRegisterForm(TdaCustomPreviewDataDialog);

end.
