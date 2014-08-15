{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppChDPEdDlg;

interface

{$Include ppIfDefTee.pas}

uses
  {$IFNDEF Tee52} TeeEdiSeri, TeeDBEdit, {$ENDIF}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, TeEngine, ExtCtrls,
  TeeSourceEdit, Chart, ppDB, ppTypes;

const MaxValueSources = 16;

type

  TppDPChartEditor = class(TBaseSourceEditor)
    GroupFields: TScrollBox;
    LLabels: TLabel;
    CBLabelsField: TComboBox;
    procedure CBLabelsFieldChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BApplyClick(Sender: TObject);
    procedure CBSourcesChange(Sender: TObject);

  private
    LabelValues : array[0..MaxValueSources-1] of TLabel;
    CBDateTime  : array[0..MaxValueSources-1] of TCheckBox;

    procedure CBValuesChange(Sender: TObject);
    procedure SetFields;
    procedure SetTextItemIndex(Combo:TComboBox);

    procedure FillSourceDatasets(aComboBox: TComboBox);



  protected
    function GetSelectedDataPipeline: TppDataPipeline;
    function IsValid(aComponent: TComponent): Boolean; override;

  public
    CBValues: array[0..MaxValueSources-1] of TComboBox;
  end;

{$IFDEF Tee52}
  TppTeeSeriesDPSource=class(TTeeSeriesSource)
  public
    class Function Available(AChart:TCustomAxisPanel):Boolean; override;
    class function HasNew: Boolean; override;
    class Function Description:String; override;
    class Function Editor:TComponentClass; override;
    class Function HasSeries(ASeries:TChartSeries):Boolean; override;
  end;

{$ELSE}
  procedure OnCreateEditDBChart(aForm:TFormTeeSeries; aChart: TCustomChart);
{$ENDIF}


implementation

{$R *.DFM}

uses Teeconst, TeeProcs, ppClass, ppChrtDP, ppUtils;

const
  dtNumerics = [dtInteger, dtLongint, dtLargeInt, dtSingle, dtDouble, dtExtended, dtCurrency, dtDate, dtTime, dtDateTime];

{$IFNDEF Tee52}

{------------------------------------------------------------------------------}
{ OnDBChartGetSourceStyle }

function OnDBChartGetSourceStyle(aSeries:TChartSeries): TFormClass;
begin
  
  if (aSeries.DataSource <> nil) then
    Result := TppDPChartEditor
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{ OnCreateEditDBChart }

procedure OnCreateEditDBChart(aForm:TFormTeeSeries; aChart:TCustomChart);

  procedure AddDataStyle(const aStyle:String; aFormClass:TFormClass);
  var liStyle: Integer;
  begin
    with aForm.CBDataSourceStyle.Items do
      if IndexOf(AStyle) = -1 then
        begin
          liStyle := AddObject(AStyle,TObject(AFormClass));
          aForm.CBDataSourceStyle.ItemIndex := liStyle;
        end;

  end;

  procedure RemoveDataStyle(const aStyle: String);
  var liStyle: Integer;
  begin
    with aForm.CBDataSourceStyle.Items do
    begin
      liStyle := IndexOf(AStyle);
      if liStyle <> -1 then
        Delete(liStyle);
    end;
  end;

begin

  with aForm do
  if aChart is TppDPTeeChartControl then
  begin
    AddDataStyle(ppLoadStr(500), TppDPChartEditor);  {'Data Pipeline'}
    OnChartGetSourceStyle := OnDBChartGetSourceStyle;
    OnGetDesignerNames := nil;
  end
  else
  begin
    RemoveDataStyle(ppLoadStr(500)) {'Data Pipeline'};
    OnChartGetSourceStyle := nil;
    OnGetDesignerNames := nil;
  end;
end;

 
{$ENDIF}

{------------------------------------------------------------------------------}
{ TppDPChartEditor.GetSelectedDataPipeline }

function TppDPChartEditor.GetSelectedDataPipeline: TppDataPipeline;
begin
  if CBSources.ItemIndex = -1 then
    Result := nil
  else
    Result := TppDataPipeline(CBSources.Items.Objects[CBSources.ItemIndex]);

end;

{------------------------------------------------------------------------------}
{ TppDPChartEditor.IsValid }

function TppDPChartEditor.IsValid(aComponent: TComponent): Boolean;
begin
  Result:= (aComponent is TppDataPipeline) and TppDataPipeline(aComponent).Visible;
end;

{------------------------------------------------------------------------------}
{ TppDPChartEditor.CBLabelsFieldChange }

procedure TppDPChartEditor.CBLabelsFieldChange(Sender: TObject);
begin
  BApply.Enabled:=True;
end;

{------------------------------------------------------------------------------}
{ TppDPChartEditor.CBValuesChange }

procedure TppDPChartEditor.CBValuesChange(Sender: TObject);
var
  lField : TppField;
  lDataPipeline: TppDataPipeline;
  lComboBox: TComboBox;

begin
  lComboBox := TComboBox(Sender);

  if (lComboBox.ItemIndex <> -1) then
    begin
      lDataPipeline := GetSelectedDataPipeline;
      if lDataPipeline <> nil then
        begin
          lField := lDataPipeline.GetFieldForAlias(lComboBox.Items[lComboBox.ItemIndex]);
          CBDateTime[lComboBox.Tag].Checked := (lField <> nil) and (lField.DataType in [dtDate, dtTime, dtDateTime]);
        end;
    end;

  BApply.Enabled := True;

end;

{------------------------------------------------------------------------------}
{ TppDPChartEditor.SetTextItemIndex }

procedure TppDPChartEditor.SetTextItemIndex(Combo:TComboBox);
var tmp : Integer;
begin
  with Combo do
  begin
    tmp:=Items.IndexOf(Text);
    if tmp<>ItemIndex then ItemIndex:=tmp;
  end;
end;

{------------------------------------------------------------------------------}
{ TppDPChartEditor.FillSourceDatasets }

procedure TppDPChartEditor.FillSourceDatasets(aComboBox: TComboBox);
var
  lDataPipelines: TppDataPipelineList;
  lDPTeeChartControl: TppDPTeeChartControl;
  lReport: TppCustomReport;
  lComponent: TppComponent;

begin
  lDPTeeChartControl := TppDPTeeChartControl(TheSeries.ParentChart);
  lComponent := TppComponent(lDPTeeChartControl.StreamingParent);

  if lComponent.Band <> nil then
    lReport := lComponent.Band.Report
  else
    lReport := nil;

  {get datapipeline list}
  lDataPipelines := TppDataPipelineList.Create(lReport);
  try
    aComboBox.Items.Assign(lDataPipelines);

    aComboBox.ItemIndex := aComboBox.Items.IndexOfObject(TheSeries.DataSource);
  finally
    lDataPipelines.Free;
  end;

end;

{------------------------------------------------------------------------------}
{ TppDPChartEditor.FormShow }

procedure TppDPChartEditor.FormShow(Sender: TObject);
var t       : Integer;
    tmpName : String;
begin
  inherited;
  TheSeries:=TChartSeries(Tag);

  LLabel.Caption:= ppLoadStr(500) {'Data Pipeline'};
  FillSourceDatasets(CBSources);

  with TheSeries do
  for t:=0 to ValuesList.Count-1 do
  begin
    tmpName:=ValuesList[t].Name;
    CBValues[t]:=TComboBox.Create(Self);
    with CBValues[t] do
    begin
      Parent:=GroupFields;
      Left:=CBLabelsField.Left;
      Style:=csDropDown;
      HelpContext:=178;
      Width:=CBLabelsField.Width;
      Top:=2+CBLabelsField.Top+CBLabelsField.Height+((CBValues[t].Height+4)*t+1);
      OnChange:=CBValuesChange;
      Tag:=t;
      Visible:=tmpName<>'';
    end;
    LabelValues[t]:=TLabel.Create(Self);
    with LabelValues[t] do
    begin
      Alignment:=taRightJustify;
      Parent:=GroupFields;
      Top:=CBValues[t].Top+4;
      AutoSize:=False;
      Left:=LLabels.Left;
      Width:=LLabels.Width;
      Caption:=tmpName+':';
      Visible:=tmpName<>'';
    end;
    CBDateTime[t]:=TCheckBox.Create(Self);
    with CBDateTime[t] do
    begin
      Parent:=GroupFields;
      Left:=CBLabelsField.Left+CBLabelsField.Width+6;
      Top:=CBValues[t].Top;
      HelpContext:=178;
      Caption:=TeeMsg_DateTime;
      Width:=Canvas.TextWidth(Caption + 'www');
      Tag:=t;
      Visible:=tmpName<>'';
      OnClick:=CBLabelsFieldChange;
    end;
  end;
  SetFields;
end;



{------------------------------------------------------------------------------}
{ TppDPChartEditor.SetFields }

procedure TppDPChartEditor.SetFields;

  procedure FillFields;
  var liIndex: Integer;
      liValuesList: Integer;
      lDataPipeline: TppDataPipeline;
      lField: TppField;
  begin
    lDataPipeline := GetSelectedDataPipeline;

    for liIndex := 0 to lDataPipeline.FieldCount-1 do
      begin
        lField := lDataPipeline.Fields[liIndex];

        {add field to label list}
        CBLabelsField.Items.Add(lField.FieldAlias);

        {add numeric and datetime fields to value list}
        if (lField.DataType in dtNumerics) then
          for liValuesList := 0 to TheSeries.ValuesList.Count-1 do
            CBValues[liValuesList].Items.Add(lField.FieldAlias);

      end;

  end;

var liIndex: Integer;
begin
  CBLabelsField.Clear;
  CBLabelsField.Enabled := CBSources.ItemIndex <> -1;

  for liIndex :=0 to TheSeries.ValuesList.Count-1 do
    begin
      CBValues[liIndex].Clear;
      CBValues[liIndex].Enabled := CBLabelsField.Enabled;
    end;

  if CBSources.ItemIndex <> -1 then
    FillFields;

  with CBLabelsField do
    ItemIndex := Items.IndexOf(TheSeries.XLabelsSource);

  with TheSeries.ValuesList do
    for liIndex := 0 to Count-1 do
    begin
      with CBValues[liIndex] do ItemIndex := Items.IndexOf(ValueList[liIndex].ValueSource);
      CBDateTime[liIndex].Checked := ValueList[liIndex].DateTime;
    end;

end;


{------------------------------------------------------------------------------}
{ TppDPChartEditor.BApplyClick }

procedure TppDPChartEditor.BApplyClick(Sender: TObject);

  procedure CheckFieldIsBlank(const aFieldName:String);
  begin
    if aFieldName <> '' then
       raise ChartException.CreateFmt(TeeMsg_FieldNotFound,[AFieldName]);
  end;

  procedure CheckValidFields;
  var t : Integer;
  begin
    for t:=0 to TheSeries.ValuesList.Count-1 do
    with CBValues[t] do
    begin
      SetTextItemIndex(CBValues[t]);
      if ItemIndex=-1 then CheckFieldIsBlank(Text);
    end;
    SetTextItemIndex(CBLabelsField);
    with CBLabelsField do
    if ItemIndex=-1 then CheckFieldIsBlank(Text);
  end;

var t: Integer;
begin
  inherited;
  with TheSeries do
  begin
    DataSource := nil;
    try
      CheckValidFields;
      for t := 0 to ValuesList.Count-1 do
      with ValuesList[t] do
      begin
        ValueSource := CBValues[t].Text;
        DateTime := CBDateTime[t].Checked;
      end;
      XLabelsSource := CBLabelsField.Text;
    finally
      DataSource := GetSelectedDataPipeline;
    end;
  end;
  BApply.Enabled:=False;
end;

{------------------------------------------------------------------------------}
{ TppDPChartEditor.CBSourcesChange }

procedure TppDPChartEditor.CBSourcesChange(Sender: TObject);
begin
  inherited;
  SetFields;
end;

{$IFDEF Tee52}

{******************************************************************************
 *
 ** T E E  S E R I E S  D P  S O U R C E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppTeeSeriesDPSource.Available }

class function TppTeeSeriesDPSource.Available(aChart: TCustomAxisPanel): Boolean;
begin
  Result := (aChart is TppDPTeeChartControl);
end;

{------------------------------------------------------------------------------}
{ TppTeeSeriesDPSource.HasNew }

class function TppTeeSeriesDPSource.HasNew: Boolean;
begin
  Result := True;
end;

{------------------------------------------------------------------------------}
{ TppTeeSeriesDPSource.Description }

class function TppTeeSeriesDPSource.Description: String;
begin
  Result := ppLoadStr(500); {'Data Pipeline'}
end;

{------------------------------------------------------------------------------}
{ TppTeeSeriesDPSource.Editor }

class function TppTeeSeriesDPSource.Editor: TComponentClass;
begin
  Result := TppDPChartEditor;
end;

{------------------------------------------------------------------------------}
{ TppTeeSeriesDPSource.HasSeries }

class function TppTeeSeriesDPSource.HasSeries(aSeries: TChartSeries): Boolean;
begin
  Result:= (aSeries.DataSource is TppDataPipeline) and TppDataPipeline(ASeries.DataSource).Visible;
end;

initialization
  TeeSources.Add(TppTeeSeriesDPSource);

finalization
  TeeSources.Remove(TppTeeSeriesDPSource);

{$ENDIF}


end.
