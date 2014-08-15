{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppChDPEd;

interface

{$I ppIfDefTee.pas}

uses
  IEditCha, IEdiSeri, Chart;
  
procedure OnCreateEditDBChart(aForm: TFormTeeSeries; aChart: TCustomChart); far;

implementation

uses
  Classes, StdCtrls,
  Teengine, TeeConst, TeeProcs,
  ppDB, ppClass, ppTypes, ppChrtDP;

const
  dtNumerics = [dtInteger, dtLongint, dtLargeInt, dtSingle, dtDouble, dtExtended, dtCurrency, dtDate, dtTime, dtDateTime];

{------------------------------------------------------------------------------}
{ ppOnDBChartIsValidComponentSource }

function ppOnDBChartIsValidComponentSource(aComponent: TComponent; DataSourceStyle: TTeeDataSourceStyle): Boolean; far;
begin
  Result := (aComponent is TppDataPipeline) and TppDataPipeline(aComponent).Visible;
end; {procedure, ppOnDBChartIsValidComponentSource}

{------------------------------------------------------------------------------}
{ ppOnDBChartGetSourceStyle }

function ppOnDBChartGetSourceStyle(aSeries: TChartSeries): TTeeDataSourceStyle;
begin

  Result := dsStyle_NoData;

  if (aSeries.DataSource = nil) then Exit;

  Result := TTeeDataSourceStyle(aSeries.Tag);

end; {function, ppOnDBChartGetSourceStyle}

{------------------------------------------------------------------------------}
{ ppOnDBChartIsDateTimeSource }

procedure ppOnDBChartIsDateTimeSource(aComponent: TComponent; const ValueSource: String; var IsDateTime: Boolean); far;
var
  lField: TppField;
begin

  IsDateTime := False;

  if not(aComponent is TppDataPipeline) then Exit;

  lField := TppDataPipeline(aComponent).GetFieldForName(ValueSource);

  if (lField <> nil) and (lField.DataType in [dtDate, dtTime, dtDateTime]) then
    IsDateTime := True;

end; {procedure, ppOnDBChartIsDateTimeSource}

{------------------------------------------------------------------------------}
{ ppOnDBChartFillFields }

procedure ppOnDBChartFillFields(aForm: TFormTeeSeries); far;
var
  lComponent: TComponent;
  liIndex: Integer;
  liIndex2: Integer;
  lField: TppField;
  lDataPipeline: TppDataPipeline;
  lSourceCombo: TComboBox;
  lsDataPipeline: String;
  lsFieldAlias: String;
begin

  lComponent := aForm.GetSelectedSource;

  if (aForm.TheSeries = nil) or (lComponent = nil) or not(lComponent is TppDataPipeline) then Exit;

  {determine if the series is based on a datasource or a dataset}
  aForm.TheSeries.Tag := aForm.CBDataSourcestyle.ItemIndex;

  lDataPipeline := TppDataPipeline(lComponent);

  aForm.CBLabelsField.Items.Clear;
  aForm.LBAvailFields.Items.Clear;

  for liIndex := 0 to lDataPipeline.FieldCount - 1 do
    begin

      lField := lDataPipeline.Fields[liIndex];

      if (lField.DataType in dtNumerics) then
        begin
          aForm.CBLabelsField.Items.Add(lField.FieldAlias);
          aForm.LBAvailFields.Items.Add(lField.FieldAlias);

          for liIndex2 := 0 to aForm.TheSeries.ValuesLists.Count - 1 do
            begin
              lSourceCombo := aForm.GetSourceCombo(liIndex2);

              if (lSourceCombo <> nil) then
                lSourceCombo.Items.Add(lField.FieldAlias);
            end;
        end

      else if (lField.DataType = dtString) then
        begin
          aForm.CBLabelsField.Items.Add(lField.FieldAlias);
          aForm.LBAvailFields.Items.Add(lField.FieldAlias);
        end;

    end;


    {remove selected fields from available field list}
    lsDataPipeline := aForm.TheSeries.MandatoryValueList.ValueSource;

    aForm.LBSelFields.Clear;

    for liIndex := 1 to TeeNumFields(lsDataPipeline) do
      begin
        lsFieldAlias := TeeExtractField(lsDataPipeline, liIndex);

        aForm.LBSelFields.Items.Add(lsFieldAlias);

        liIndex2 := aForm.LBAvailFields.Items.IndexOf(lsFieldAlias);

        aForm.LBAvailFields.Items.Delete(liIndex2);
      end;

end; {procedure, ppOnDBChartFillFields}

{------------------------------------------------------------------------------}
{ OnCreateEditDBChart }

procedure OnCreateEditDBChart(aForm: TFormTeeSeries; aChart: TCustomChart); far;
var
  liIndex: Integer;
  lList: TStrings;
begin

  if (aChart is TppDPTeeChartControl) then
    begin
      lList := aForm.CBDataSourceStyle.Items;

      liIndex := lList.IndexOf(TeeMsg_DataSet);

      if (liIndex = -1) then
        lList.Add(TeeMsg_Dataset);

      liIndex := lList.IndexOf(TeeMsg_SingleRecord);

      if (liIndex = -1) then
        lList.Add(TeeMsg_SingleRecord);

      aForm.OnChartFillFields := ppOnDBChartFillFields;
      aForm.OnChartGetSourceStyle := ppOnDBChartGetSourceStyle;
      aForm.OnChartIsValidComponentSource := ppOnDBChartIsValidComponentSource;
      aForm.OnChartIsDateTimeSource := ppOnDBChartIsDateTimeSource;
      aForm.OnGetDesignerNames := nil;
    end

  else
    begin
      lList := aForm.CBDataSourceStyle.Items;

      liIndex := lList.IndexOf(TeeMsg_DataSet);

      if (liIndex <> -1) then
        lList.Delete(liIndex);

      liIndex := lList.IndexOf(TeeMsg_SingleRecord);

      if (liIndex <> -1) then
        lList.Delete(liIndex);

      aForm.OnChartFillFields := nil;
      aForm.OnChartGetSourceStyle := nil;
      aForm.OnChartIsValidComponentSource := nil;
      aForm.OnChartIsDateTimeSource := nil;
      aForm.OnGetDesignerNames := nil;
    end;

end; {procedure, OnCreateEditDBChart}


end.
