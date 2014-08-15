{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppChrtDP;

interface

{$I ppIfDefTee.pas}

uses
  Windows,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  ExtCtrls,

  TeeProcs,
  Chart,
  TeEngine,

  ppComm,
  ppClass,
  ppDevice,
  ppTypes,
  ppDB,
  ppChrt,
  ppDrwCmd,
  ppRTTI;

type

  TppDPTeeChartControl = class;
  TppSeriesDataRefList = class;

  {@TppDPTeeChartControl }
  TppDPTeeChartControl = class(TppTeeChartControl)
    private
      FAutoRefresh: Boolean;
      FDataPipeList: TList;
      FShowGlassCursor: Boolean;
      FRefreshingData: Boolean;
      FSeriesDataSourceNames: TStringList;

      procedure AddPointToSeries(aDataPipeline: TppDataPipeline; aSeries: TChartSeries; aX, aY: Double; aXLabel: String; aColor: TColor);
      function  GetFloatFieldValue(aDataPipeline: TppDataPipeline; const aFieldAlias: String): Double;
      procedure GetSeriesForDataPipeline(aDataPipeline: TppDataPipeline; aSeriesList: TChartSeriesList);
      procedure RecordToPoint(aDataPipeline: TppDataPipeline; aSeries: TChartSeries);
      procedure TraverseDataPipeline(aDataPipeline: TppDataPipeline; aSeriesList: TChartSeriesList);

    protected
      procedure ReadState(Reader: TReader); override;
      
    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Assign(Source: TPersistent); override;
      procedure ConvertDataReferences(aSeriesDataRefList: TppSeriesDataRefList);
      function  IsValidDataSource(aSeries: TChartSeries; aComponent: TComponent): Boolean; override;

      procedure FillSeriesSourceItems(aSeries: TChartSeries; Proc: TGetStrProc); override;
      procedure FillValueSourceItems(aValueList: TChartValueList; Proc: TGetStrProc); override;
      procedure RefreshData;
      procedure RefreshDataPipeline(aDataPipeline: TppDataPipeline);

      property DataPipeList: TList read FDataPipeList write FDataPipeList;

      property AutoRefresh: Boolean read FAutoRefresh write FAutoRefresh default True;

      property RefreshingData: Boolean read FRefreshingData;

    published
      property ShowGlassCursor: Boolean read FShowGlassCursor write FShowGlassCursor default True;

    end; {class, TppDPTeeChartControl}



  {@TppDPTeeChart

    This is a data pipeline based TeeChart component.  When you create a
    series, access the DataSource tab, and select either 'Dataset' or
    'Single Record' as the datasource type, then the TeeChart Editor will
    display the Name property of all data pipelines on the form or in data
    modules accessible by the form.  Data pipelines which have the Visible 
    property set to False, will not be displayed.  Once a data pipeline is
    selected, the fields within the data pipeline will be available for
    selection as Labels or X/Y values. For purposes of selecting a field,
    the Field Alias is displayed, not the Field Name.

    You can use this component to create charts based on any type of data 
    pipeline: DBPipeline, TextPipeline, JITPipeline.  With the JITPipeline
    you must run the application and preview at run-time, since the data is
    being supplied via event handlers.  This component is also very useful 
    for developers who wish to deploy a data-aware TeeChart as part of a
    ReportBuilder end-user reporting solution - as it will allow end-users 
    to select data pipelines created in the data workspace of the report
    designer.

    Note: This component is only compatible with TeeChart 4.01 or later. In
    order to use this component, you must purchase TeeChart 4.01 directly 
    from www.teemach.com.  If TeeChart 4.01 or later was installed on your
    system when you installed ReportBuilder, then this component was 
    installed automatically.  If you have just installed TeeChart 4.01 and
    want to install this component, either re-run the ReportBuilder 
    installation program or use the directions in the
    RBuilder\TeeChart\Tee44 directory (readme.doc) to install manually.}

  TppDPTeeChart = class(TppCustomTeeChart)
    private
      FDataPipeList: TList;
      FSeriesDataRefList: TppSeriesDataRefList;

      procedure UpdateDataPipeList;
      
    protected
      procedure CreateChart(var aChart: TCustomChart); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Edit; override;
      procedure GetDataPipelines(aDataPipelines: TList); override;

      procedure Loaded; override;

      procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

    published
      property Anchors;
      property Border;
      property Chart;
      property PrintMethod;
      property Visible;

      {these properties saved in 'fake' properties}
      property Height stored False;
      property Left stored False;
      property Top stored False;
      property Width stored False;
  end; {class, TppDPTeeChart}




  {TppSeriesDataRefList

   Used to manage Series.DataPipeline object references.}

  TppSeriesDataRefList = class(TStringList)
    private
      FChart: TppDPTeeChart;

    public
      constructor CreateForChart(aChart: TppDPTeeChart);

      procedure RefreshDataPipelineNameReferences;
      procedure ResolveDataPipelineObjectReferences;

      procedure AddSeries(aSeries: TChartSeries);

  end;

  { TraTppDPTeeChartRTTI }
  TraTppDPTeeChartRTTI = class(TraTppCustomTeeChartRTTI)
    public
      class function  RefClass: TClass; override;
  end; {class, TraTppTeeChartRTTI}

implementation

uses TeeConst, ppUtils;

{******************************************************************************
 *
 ** C U S T O M   D B   C H A R T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDPTeeChartControl.Create }

constructor TppDPTeeChartControl.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FAutoRefresh := True;
  FDataPipeList := nil;
  FShowGlassCursor := True;
  FRefreshingData := False;
  FSeriesDataSourceNames := TStringList.Create;


end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDPTeeChartControl.Destroy }

destructor TppDPTeeChartControl.Destroy;
begin

  FSeriesDataSourceNames.Free;
  FSeriesDataSourceNames := nil;
  
  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDPTeeChartControl.Assign }

procedure TppDPTeeChartControl.Assign(Source: TPersistent);
var
  lSource: TppDPTeeChartControl;
begin

  inherited Assign(Source);

  if not(Source is TppDPTeeChartControl) then Exit;

  lSource := TppDPTeeChartControl(Source);

  AutoRefresh := lSource.AutoRefresh;
  ShowGlassCursor := lSource.ShowGlassCursor;

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TppDPTeeChartControl.IsValidDataSource }

function TppDPTeeChartControl.IsValidDataSource(aSeries: TChartSeries; aComponent: TComponent):Boolean;
begin
  Result := ((ASeries <> AComponent) and
            ((aComponent is TChartSeries) and aSeries.IsValidSeriesSource(TChartSeries(aComponent))) or
             (aComponent is TppDataPipeline) and (TppDataPipeline(aComponent).Visible));

end; {procedure, IsValidDataSource}

{------------------------------------------------------------------------------}
{ TppDPTeeChartControl.FillSeriesSourceItems }

procedure TppDPTeeChartControl.FillSeriesSourceItems(aSeries: TChartSeries; Proc: TGetStrProc);
var
  liIndex: Integer;
  lDataPipeline: TppDataPipeline;
begin

  if (aSeries.DataSource = nil) or not(aSeries.DataSource is TppDataPipeline) then Exit;

  lDataPipeline := TppDataPipeline(aSeries.DataSource);

  for liIndex := 0 to lDataPipeline.FieldCount - 1 do
    Proc(lDataPipeline.Fields[liIndex].FieldAlias);

end; {procedure, FillSeriesSourceItems}

{------------------------------------------------------------------------------}
{ TppDPTeeChartControl.FillValueSourceItems }

procedure TppDPTeeChartControl.FillValueSourceItems(aValueList: TChartValueList; Proc: TGetStrProc);
var
  lSeries: TChartSeries;
begin

  lSeries := aValueList.Owner;

  if (lSeries.DataSource = nil) and (lSeries.DataSource is TppDataPipeline) then
    FillSeriesSourceItems(lSeries, Proc)
  else
    inherited FillValueSourceItems(aValueList, Proc);

end; {procedure, FillValueSourceItems}

{------------------------------------------------------------------------------}
{ TppDPTeeChartControl.RefreshData }

procedure TppDPTeeChartControl.RefreshData;
var
  liIndex: Integer;
  lDataPipeline: TppDataPipeline;
begin

  if FRefreshingData then Exit;

  if (FDataPipeList = nil) then Exit;

  for liIndex := 0 to FDataPipeList.Count - 1 do
    begin
      lDataPipeline := TppDataPipeline(FDataPipeList[liIndex]);

      RefreshDataPipeline(lDataPipeline)
    end;

end; {procedure, RefreshData}

{------------------------------------------------------------------------------}
{ TppDPTeeChartControl.GetFloatFieldValue }

function TppDPTeeChartControl.GetFloatFieldValue(aDataPipeline: TppDataPipeline; const aFieldAlias: String): Double;
var
  lField: TppField;
begin
  lField := aDataPipeline.GetFieldForAlias(aFieldAlias);


  if (lField = nil) or (aDataPipeline.GetFieldIsNull(lField.FieldName)) then
    Result := 0
  else
    Result := lField.Value;

end; {procedure, GetFloatFieldValue}


{$IFDEF Tee50}

{------------------------------------------------------------------------------}
{ TppDPTeeChartControl.AddPointToSeries }

procedure TppDPTeeChartControl.AddPointToSeries(aDataPipeline: TppDataPipeline; aSeries: TChartSeries; aX, aY: Double; aXLabel: String; aColor: TColor);
var
  liIndex: Integer;
  lValueList: TChartValueList;
  lValueLists: TChartValueLists;
begin

  lValueLists := aSeries.ValuesList;

  for liIndex := 2 to lValueLists.Count - 1 do
    begin
      lValueList := lValueLists[liIndex];

      if (lValueList.ValueSource <> '') then
        lValueList.TempValue := GetFloatFieldValue(aDataPipeline, lValueList.ValueSource)
      else
        lValueList.TempValue := 0;

    end;

    if aSeries.NotMandatoryValueList.ValueSource = '' then
      begin
        if aSeries.YMandatory then
          aSeries.AddY(aY, aXLabel, aColor)
        else
          aSeries.AddX(aX, aXLabel, aColor)
      end
    else
      aSeries.AddXY(aX, aY, aXLabel, aColor);

end; {procedure, AddPointToSeries}


{$ELSE}

{------------------------------------------------------------------------------}
{ TppDPTeeChartControl.AddPointToSeries }

procedure TppDPTeeChartControl.AddPointToSeries(aDataPipeline: TppDataPipeline; aSeries: TChartSeries; aX, aY: Double; aXLabel: String; aColor: TColor);
var
  liIndex: Integer;
  lValueList: TChartValueList;
begin

  for liIndex := 2 to aSeries.ValuesLists.Count - 1 do
    begin
      lValueList := aSeries.ValuesLists[liIndex];

      if (lValueList.ValueSource <> '') then
        lValueList.TempValue := GetFloatFieldValue(aDataPipeline, lValueList.ValueSource)
      else
        aSeries.ClearTempValue(lValueList);

    end;

  if aSeries.YMandatory then
    begin
      if (aSeries.XValues.ValueSource <> '') then
        liIndex := aSeries.AddXY(aX, aY, aXLabel, aColor)
      else
        liIndex := aSeries.AddY(aY, aXLabel, aColor);
    end
  else
    begin
      if (aSeries.YValues.ValueSource <> '') then
        liIndex := aSeries.AddXY(aX, aY, aXLabel, aColor)
      else
        liIndex := aSeries.AddX(aX, aXLabel, aColor);
    end;

  if (liIndex <> -1) then
    aSeries.AddValue(liIndex);

end; {procedure, AddPointToSeries}


{$ENDIF}


{------------------------------------------------------------------------------}
{ TppDPTeeChartControl.ConvertDataReferences }

procedure TppDPTeeChartControl.ConvertDataReferences(aSeriesDataRefList: TppSeriesDataRefList);
var
  liIndex: Integer;
  liRef: Integer;
  lSeries: TChartSeries;
begin
  for liIndex := 0 to SeriesCount-1 do
    begin
      lSeries := Series[liIndex];

      liRef := FSeriesDataSourceNames.IndexOfName(lSeries.Name);

      if liRef <> -1 then
        aSeriesDataRefList.Add(lSeries.Name + '=' + FSeriesDataSourceNames.Values[lSeries.Name])

    end;

  aSeriesDataRefList.ResolveDataPipelineObjectReferences;

end; {procedure, ConvertDataReferences}

{------------------------------------------------------------------------------}
{ TppDPTeeChartControl.RecordToPoint }

procedure TppDPTeeChartControl.RecordToPoint(aDataPipeline: TppDataPipeline; aSeries: TChartSeries);
var
  liIndex: Integer;
  liFieldCount: Integer;
  lsFieldAlias: String;
  lField: TppField;
  lsXLabel: String;
  lColor: TColor;
  ldX: Double;
  ldY: Double;
begin

  ldX := 0;
  ldY := 0;
  lColor := clTeeColor;
  lsXLabel := '';

  {get the x-label}
  if (aSeries.XLabelsSource <> '') then
    begin
      lsFieldAlias := aSeries.XLabelsSource;
      lField := aDataPipeline.GetFieldForAlias(lsFieldAlias);
      if lField <> nil then
        lsXLabel := aDataPipeline.GetFieldAsString(lField.FieldName);
    end;

  {get the color}
  if (aSeries.ColorSource = '') then
    begin
      lsFieldAlias := TeeExtractField(aSeries.MandatoryValueList.ValueSource, 1);

      lField := aDataPipeline.GetFieldForAlias(lsFieldAlias);

      if (lField <> nil) and (aDataPipeline.GetFieldIsNull(lField.FieldName)) then
        lColor := clNone
      else
        lColor := clTeeColor;
    end
  else
    begin
      lsFieldAlias := aSeries.ColorSource;

      lField := aDataPipeline.GetFieldForAlias(lsFieldAlias);

      if (lField <> nil) then
        lColor := aDataPipeline.GetFieldValue(lField.FieldName);
    end;

  liFieldCount := TeeNumFields(aSeries.MandatoryValueList.ValueSource);

  if (liFieldCount = 1) then
    begin
      lsFieldAlias := aSeries.MandatoryValueList.ValueSource;

      {if aSeries.XLabelsSource = '' then
          lsXLabel := lsFieldAlias;}

      if aSeries.YMandatory then
        begin
          ldX := GetFloatFieldValue(aDataPipeline, aSeries.XValues.ValueSource);
          ldY := GetFloatFieldValue(aDataPipeline, lsFieldAlias);
        end
      else
        begin
          ldX := GetFloatFieldValue(aDataPipeline, lsFieldAlias);
          ldY := GetFloatFieldValue(aDataPipeline, aSeries.YValues.ValueSource);
        end;

      AddPointToSeries(aDataPipeline, aSeries, ldX, ldY, lsXLabel, lColor);
    end

  else
    for liIndex := 1 to liFieldCount do
      begin
        lsFieldAlias := TeeExtractField(aSeries.MandatoryValueList.ValueSource, liIndex);

        {if aSeries.XLabelsSource = '' then
          lsXLabel := lsFieldAlias;}

        if aSeries.YMandatory then
          ldY := GetFloatFieldValue(aDataPipeline, lsFieldAlias)
        else
          ldX := GetFloatFieldValue(aDataPipeline, lsFieldAlias);

        AddPointToSeries(aDataPipeline, aSeries, ldX, ldY, lsXLabel, lColor);
      end;

end; {procedure, RecordToPoint}

{------------------------------------------------------------------------------}
{ TppDPTeeChartControl.TraverseDataPipeline }

procedure TppDPTeeChartControl.TraverseDataPipeline(aDataPipeline: TppDataPipeline; aSeriesList: TChartSeriesList);
var
  lBookmark: Integer;
  liIndex: Integer;
  lDPState: TppDataPipelineStates;
  liTraversalCount: Integer;
  liRecordNo: Integer;
begin

  lBookmark := 0;
  liTraversalCount := 0;
  liRecordNo := 0;

  try
    lDPState := aDataPipeline.State;
    liTraversalCount := aDataPipeline.TraversalCount;
    liRecordNo := aDataPipeline.RecordNo;
    lBookmark := aDataPipeline.GetBookMark;

    aDataPipeline.First;

    while not(aDataPipeline.EOF) do
      try

        for liIndex := 0 to aSeriesList.Count - 1 do
          RecordToPoint(aDataPipeline, aSeriesList[liIndex]);

        aDataPipeline.Next;
      except
        on EAbort do Break; { <-- exit while loop !!! }
      end; {try-except, next record}

  finally
    try
      aDataPipeline.GotoBookMark(lBookmark);
    finally
      aDataPipeline.FreeBookMark(lBookmark);
    end;

    aDataPipeline.State := lDPState;
    aDataPipeline.TraversalCount := liTraversalCount;
    aDataPipeline.RecordNo := liRecordNo;

  end; {try-finally, bookmark}

end; {procedure, TraverseDataPipeline}

{------------------------------------------------------------------------------}
{ TppDPTeeChartControl.GetSeriesForDataPipeline }

procedure TppDPTeeChartControl.GetSeriesForDataPipeline(aDataPipeline: TppDataPipeline; aSeriesList: TChartSeriesList);
var
  liIndex: Longint;
  lSeries: TChartSeries;
begin

  aSeriesList.Clear;

  for liIndex := 0 to SeriesCount - 1 do
    begin
      lSeries := Series[liIndex];

      if (lSeries.DataSource = aDataPipeline) and
         (lSeries.MandatoryValueList.ValueSource <> '') then
        aSeriesList.Add(lSeries);

    end;

end; {procedure, GetSeriesForDataPipeline}

{------------------------------------------------------------------------------}
{ TppDPTeeChartControl.ReadState }

procedure TppDPTeeChartControl.ReadState(Reader: TReader);
begin

  TppHReaderUtils.ExtractChildIdentValues(Reader, 'DataSource', FSeriesDataSourceNames);

  inherited ReadState(Reader);

end; {procedure, ReadState}

{------------------------------------------------------------------------------}
{ TppDPTeeChartControl.RefreshDataPipeline }

procedure TppDPTeeChartControl.RefreshDataPipeline(aDataPipeline: TppDataPipeline);
var
  lSaveCursor: TCursor;
  liIndex: Integer;
  lSeriesList: TChartSeriesList;
  lSeries: TChartSeries;
  lbTraverseAllData: Boolean;
begin

  if not(aDataPipeline.Active) then  Exit;

  if FRefreshingData then Exit;

  FRefreshingData := True;

  lSeriesList := TChartSeriesList.Create;
  lbTraverseAllData := True;

  try
    GetSeriesForDataPipeline(aDataPipeline, lSeriesList);

    if (lSeriesList.Count > 0) then
      begin
        lSaveCursor := Screen.Cursor;

        if FShowGlassCursor then
          Screen.Cursor := crHourGlass;

        try
          {clear series points}
          for liIndex := 0 to lSeriesList.Count - 1 do
            lSeriesList[liIndex].Clear;

          {convert data to series points}
          if (lbTraverseAllData) then
            TraverseDataPipeline(aDataPipeline, lSeriesList)

          else
            begin
              for liIndex := 0 to lSeriesList.Count - 1 do
                begin
{$IFDEF Tee50}
                  lSeries := lSeriesList[liIndex];
{$ELSE}
                  lSeries := lSeriesList.Series[liIndex];
{$ENDIF}

                  RecordToPoint(aDataPipeline, lSeries);
                end;
            end;

          {refresh any related series}
          for liIndex := 0 to lSeriesList.Count - 1 do
            TChartSeries(lSeriesList[liIndex]).RefreshSeries;

        finally
          if FShowGlassCursor then
            Screen.Cursor := lSaveCursor;
        end; {try-finally, process each record}

      end; {if, list series created}

  finally
    lSeriesList.Free;
    FRefreshingData := False;
  end; {try-finally, build list of series}

end; {procedure, RefreshDataPipeline}


{******************************************************************************
 *
 ** D P   T E E   C H A R T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDPTeeChart.Create }

constructor TppDPTeeChart.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FDataPipeList := TList.Create;
  FSeriesDataRefList := TppSeriesDataRefList.CreateForChart(Self);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDPTeeChart.Destroy }

destructor TppDPTeeChart.Destroy;
begin

  FDataPipeList.Free;
  FDataPipeList := nil;

  FSeriesDataRefList.Free;
  FSeriesDataRefList := nil;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDPTeeChart.Notify }

procedure TppDPTeeChart.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
var
  liIndex: Integer;
  lSeries: TChartSeries;
begin

  inherited Notify(aCommunicator, aOperation);

  case aOperation of

    ppopRemove:
      if not(csDestroying in ComponentState) and (aCommunicator is TppDataPipeline) then
        begin
          {delete pipeline from list}
          liIndex := FDataPipeList.IndexOf(aCommunicator);

          if (liIndex = -1) then Exit;

          FDataPipeList.Delete(liIndex);

          if (csDestroying in ComponentState) then Exit;

          {clear DataSource}
          for liIndex := 0 to Chart.SeriesCount - 1 do
            begin
              lSeries := Chart.Series[liIndex];

              if (lSeries.DataSource = aCommunicator) then
               lSeries.DataSource := nil;
            end;

          {repaint control}
          InvalidateDesignControl;

        end;

    ppopActiveChange:
      if (pppcDesigning in DesignState) and not(Printing) and not(csDestroying in ComponentState)
          and not TppDPTeeChartControl(Chart).FRefreshingData then

           {repaint control}
          InvalidateDesignControl;


   {the following code caused problems if 2 Charts were connected to the same
    datapipeline. This code is only used at design-time. The user can manually refresh
    the chart by selecting the refresh data menu command.}
   {ppopDataChange:

      if (pppcDesigning in DesignState) and not(Printing) and not(csDestroying in ComponentState)
          and not TppDPTeeChartControl(Chart).FRefreshingData then
        begin
          TppDPTeeChartControl(Chart).RefreshData;

          {repaint control}
     {     InvalidateDesignControl;

        end;}

  end;


end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppDPTeeChart.Loaded }

procedure TppDPTeeChart.Loaded;
begin


  UpdateDataPipeList;

  TppDPTeeChartControl(Chart).ConvertDataReferences(FSeriesDataRefList);

  inherited Loaded;

end; {procedure, Loaded}

{------------------------------------------------------------------------------}
{ TppDPTeeChart.PropertiesToDrawCommand }

procedure TppDPTeeChart.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
begin
  if (csDestroying in ComponentState) then Exit;

  UpdateDataPipeList;

  TppDPTeeChartControl(Chart).RefreshData;

  inherited  PropertiesToDrawCommand(aDrawCommand);


end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{ TppDPTeeChart.GetDataPipelines }

procedure TppDPTeeChart.GetDataPipelines(aDataPipelines: TList);
var
  liIndex: Integer;
  lDataPipeline: TppDataPipeline;
begin

  for liIndex := 0 to FDataPipeList.Count-1 do
    begin
      lDataPipeline := FDataPipeList[liIndex];
      if (aDataPipelines.IndexOf(DataPipeline) = -1) then
        aDataPipelines.Add(lDataPipeline);
    end;

end; {procedure, GetDataPipelines}


{$IFDEF Tee50}

{------------------------------------------------------------------------------}
{ TppDPTeeChart.UpdateDataPipeList }

procedure TppDPTeeChart.UpdateDataPipeList;
var
  liIndex: Longint;
  lSeries: TChartSeries;
  lDataPipeline: TppDataPipeline;
begin

  for liIndex := 0 to FDataPipeList.Count - 1 do
    TppDataPipeline(FDataPipeList[liIndex]).RemoveNotify(Self);

  FDataPipeList.Clear;

  if (Chart = nil) then Exit;

  for liIndex := 0 to Chart.SeriesCount - 1 do
    begin
      lSeries := Chart.Series[liIndex];

      if (lSeries.DataSource <> nil) and (lSeries.DataSource is TppDataPipeline) then
        begin
          lDataPipeline := TppDataPipeline(lSeries.DataSource);

          if (FDataPipeList.IndexOf(lDataPipeline) = -1) then
            begin
              lDataPipeline.AddNotify(Self);

              FDataPipeList.Add(lDataPipeline);
            end;
        end;

    end;

  TppDPTeeChartControl(Chart).DataPipeList := FDataPipeList;

end; {procedure, UpdateDataPipeList}

{$ELSE}

{------------------------------------------------------------------------------}
{ TppDPTeeChart.UpdateDataPipeList }

procedure TppDPTeeChart.UpdateDataPipeList;
var
  liIndex: Longint;
  lSeries: TChartSeries;
  lDataPipeline: TppDataPipeline;
  lGlobalPipeList: TppDataPipelineList;
begin

  for liIndex := 0 to FDataPipeList.Count - 1 do
    TppDataPipeline(FDataPipeList[liIndex]).RemoveNotify(Self);

  lGlobalPipeList := TppDataPipelineList.Create(GetReport);

  FDataPipeList.Clear;

  if (Chart = nil) then Exit;

  for liIndex := 0 to Chart.SeriesCount - 1 do
    begin
      lSeries := Chart.Series[liIndex];

      if (lSeries.DataSource <> nil) and (lSeries.DataSource is TppDataPipeline) then
        begin
          lDataPipeline := lGlobalPipeList.GetPipelineForComponentName(lSeries.DataSource.Name);

          if (FDataPipeList.IndexOf(lDataPipeline) = -1) then
            begin
              lDataPipeline.AddNotify(Self);

              FDataPipeList.Add(lDataPipeline);
            end;
        end;

    end;

    
  lGlobalPipeList.Free;

  TppDPTeeChartControl(Chart).DataPipeList := FDataPipeList;

end; {procedure, UpdateDataPipeList}

{$ENDIF}


{------------------------------------------------------------------------------}
{ TppDPTeeChart.CreateChart }

procedure TppDPTeeChart.CreateChart(var aChart: TCustomChart);
begin

  {create & configure tee chart control}

 {note: create with a nil owner and then insert into the Owner
         at the bottom of this procedure - this avoids D5 lockup}

  aChart := TppDPTeeChartControl.Create(nil);

  TppDPTeeChartControl(aChart).StreamingParent := Self;

  aChart.Name := GetValidName(aChart);

  aChart.Title.Text.Clear;
  aChart.Title.Text.Add('Chart');
  aChart.Foot.Font.Color := clRed;
  aChart.Foot.Font.Style :=[fsItalic];
  aChart.Color := clWhite;
  aChart.BevelOuter := bvNone;
  aChart.BufferedDisplay := False;

  InsertComponent(aChart);

end; {procedure, CreateChart}


{$IFDEF Tee50}

{------------------------------------------------------------------------------}
{ TppDPTeeChart.Edit }

procedure TppDPTeeChart.Edit;
begin

  TppTeeChartUIPlugIn.Edit(Self);

  UpdateDataPipeList;

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

  {repaint control}
  InvalidateDesignControl;

end; {procedure, Edit}

{$ELSE}

type

  {@TppChartData }
  TppChartData =  class
    private
      FChart: TppDPTeeChart;
      FDataModule: TDataModule;
      FPipelines: TList;
      FReport: TppCustomReport;

      procedure GetInvisiblePipelines;
      procedure CreateVisiblePipelines;
      procedure UpdatePipelineReferences;

    public
      constructor Create(aDPTeeChart: TppDPTeeChart);
      destructor Destroy; override;


  end; {class, TppChartData}


{------------------------------------------------------------------------------}
{ TppChartData.Create }

constructor TppChartData.Create(aDPTeeChart: TppDPTeeChart);
begin

  inherited Create;

  FChart := aDPTeeChart;
  FDataModule := TDataModule.Create(nil);
 { FDataModule := TDataModule.Create(aDPTeeChart.Owner);}


  FPipelines  := TList.Create;
  FReport := aDPTeeChart.GetReport.MainReport;

  GetInvisiblePipelines;

  CreateVisiblePipelines;

  UpdatePipelineReferences;

end;

{------------------------------------------------------------------------------}
{ TppChartData.Destroy }

destructor TppChartData.Destroy;
begin

  FDataModule.Free;
  FPipelines.Free;

  if FReport.FormDesigner <> nil then
    FReport.FormDesigner.Modified;


  inherited Destroy;

end;

{------------------------------------------------------------------------------}
{ TppChartData.GetInvisiblePipelines }

procedure TppChartData.GetInvisiblePipelines;
var
  lPipeList: TppDataPipelineList;
  liIndex: Integer;
  lPipeline: TppDataPipeline;

begin

  lPipeList := TppDataPipelineList.Create(FReport);

  try
    for liIndex := 0 to lPipeList.Count-1 do
      begin
        lPipeline := lPipeList.GetPipeline(liIndex);
        FPipelines.Add(lPipeline);
      end;

  finally
    lPipeList.Free;
  end

end;

{------------------------------------------------------------------------------}
{ TppChartData.CreateVisiblePipelines }

procedure TppChartData.CreateVisiblePipelines;
var
  liIndex: Integer;
  lPipeline: TppDataPipeline;
  lDummyPipe: TppDataPipeline;
  liField: Integer;
  lField: TppField;
  lCompClass: TComponentClass;
  lDummyField: TppField;
begin

  for liIndex := 0 to FPipelines.Count-1 do
    begin
      lPipeline := TppDataPipeline(FPipelines[liIndex]);

      lCompClass := TComponentClass(lPipeline.ClassType);

      lDummyPipe := TppDataPipeline(lCompClass.Create(FDataModule));
      lDummyPipe.Name := lPipeline.Name;

      {set AutoCreateFields to False for DBPipelines}
      ppSetOrdPropValue(lDummyPipe, 'AutoCreateFields', Ord(False));

      for liField := 0 to lPipeline.FieldCount-1 do
        begin
          lField := lPipeline.Fields[liField];

          lDummyField := TppField.Create(lDummyPipe);
          lDummyField.FieldName := lField.FieldName;
          lDummyField.FieldAlias := lField.FieldAlias;
          lDummyField.DataType := lField.DataType;
          lDummyField.FieldLength := lField.FieldLength;
          lDummyField.DataPipeline := lDummyPipe;

        end;

    end;

end;

{------------------------------------------------------------------------------}
{ TppChartData.UpdatePipelineReferences }

procedure TppChartData.UpdatePipelineReferences;
var
  liIndex: Integer;
  lSeries: TChartSeries;
  lPipeline: TppDataPipeline;
begin
  for liIndex := 0 to FChart.Chart.SeriesCount-1 do
    begin
      lSeries := FChart.Chart.Series[liIndex];

      {update Series to reference the dummy datapipeline in the Dataodule}
      if lSeries.DataSource is TppDataPipeline then
        begin
          lPipeline := TppDataPipeline(FDataModule.FindComponent(lSeries.DataSource.Name));

          if lPipeline <> nil then
            lSeries.DataSource := lPipeline;

        end;
    end;

end; {procedure, UpdatePipelineReferences}

{------------------------------------------------------------------------------}
{ TppDPTeeChart.Edit }

procedure TppDPTeeChart.Edit;
var
  lChartData: TppChartData;
begin

  lChartData := TppChartData.Create(Self);

  try
    TppTeeChartUIPlugIn.Edit(Self);
  finally

    {refresh the datapipeline name references}
    FSeriesDataRefList.RefreshDataPipelineNameReferences;

    {note: must do this after the statement above and before the statement below.}
    lChartData.Free;

    {resolve the data pipeline object references}
    FSeriesDataRefList.ResolveDataPipelineObjectReferences;

    {do this last}
    UpdateDataPipeList;

  end;

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

  {repaint control}
  InvalidateDesignControl;

end; {procedure, Edit}

{$ENDIF}

{******************************************************************************
 *
 ** S E R I E S   D A T A   R E F  L I S T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSeriesDataRefList.CreateForChart }

constructor TppSeriesDataRefList.CreateForChart(aChart: TppDPTeeChart);
begin

  inherited Create;

  FChart := aChart;

end; {constructor, CreateForChart}

{------------------------------------------------------------------------------}
{ TppSeriesDataRefList.AddSeries }

procedure TppSeriesDataRefList.AddSeries(aSeries: TChartSeries);
begin
  {create DataRef object and store to list}
  if (aSeries.DataSource is TppDataPipeline) then
    Add(aSeries.Name + '=' + aSeries.DataSource.Name);

end; {procedure, AddSeries}

{------------------------------------------------------------------------------}
{ TppSeriesDataRefList.RefreshDataPipelineNameReferences }

procedure TppSeriesDataRefList.RefreshDataPipelineNameReferences;
var
  liIndex: Integer;
begin

  Clear;

  {add series datasource reference names}
  for liIndex := 0 to FChart.Chart.SeriesCount-1 do
    AddSeries(FChart.Chart.Series[liIndex]);

end; {procedure, RefreshDataPipelineNameReferences}

{------------------------------------------------------------------------------}
{ TppSeriesDataRefList.ResolveDataPipelineObjectReferences }

procedure TppSeriesDataRefList.ResolveDataPipelineObjectReferences;
var
  liIndex: Integer;
  lDataPipelineList: TppDataPipelineList;
  lSeries: TChartSeries;
  lsPipelineName: String;
begin
  {get visible pipeline list}
  lDataPipelineList := TppDataPipelineList.Create(FChart.GetReport.MainReport);

  for liIndex := 0 to FChart.Chart.SeriesCount-1 do
    begin
      lSeries := FChart.Chart.Series[liIndex];

      lsPipelineName := Values[lSeries.Name];
      lSeries.DataSource := nil;
      lSeries.DataSource := lDataPipelineList.GetPipelineForComponentName(lsPipelineName);

    end;

  lDataPipelineList.Free;

end; {procedure, ResolveDataPipelineObjectReferences}

{ TraTppDPTeeChartRTTI }

class function TraTppDPTeeChartRTTI.RefClass: TClass;
begin
  Result := TppDPTeeChart;
end;


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}


initialization

  RegisterClasses([TppDPTeeChart, TppDPTeeChartControl]);

  ppRegisterComponent(TppDPTeeChart, 'Data Components', 6, 463, '', 0);

  raRegisterRTTI(TraTppDPTeeChartRTTI);

finalization

  ppUnRegisterComponent(TppDPTeeChart);

  raUnRegisterRTTI(TraTppDPTeeChartRTTI);

end.

