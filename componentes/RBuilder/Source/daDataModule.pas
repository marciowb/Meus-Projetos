{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daDataModule;

interface

{$I ppIfDef.pas}

uses
  SysUtils, Classes, Controls, Forms, Dialogs, Graphics, ExtCtrls,
  ppComm, ppClass, ppForms, ppTypes, ppRelatv, ppModule, ppReport,
  daDataView, ppDB, ppUtils;

type

  {@TdaDataModule
   Non-visual container for a report's DataViews. A DataModule is automatically
   created for a report when ReportBuilder's Data workspace is used to create
   DataViews. In the Data workdspace, a DataView appears as a tool window
   that executes a SQL statement. From an implementation perspective a DataView
   typically contains a DataPipeline and associated DataSource and DataSet.

   ReportBuilder's Visual Query Tools work with the DADE plug-ins to
   create descendants of TdaQueryDataView (i.e. TdaADOQueryDataView,
   TdaBDEQueryDataView, etc.)

   TdaDataModule can be used to programmatically access a report's DataViews.

   Use the class function GetInstanceForReport to access a report's TdaDataModule.
   Then use the DataViews[] and DataViewCount properties to iterate through the
   DataViews.

   Example:

   var
     lDataModule: TdaDataModule;
     lDataView: TdaCustomDataView;
     liIndex: Integer;
   begin

     lDataModule := TdaDataModule.GetInstanceForReport(myReport);

     for liIndex := 0 to lDataModule.Count-1 do
       lDataView := lDataModule.DataViews[liIndex];

   end;}

  {@TdaDataModule.DataViews
   Array of DataView objects associated with a report.

  {@TdaDataModule.DataViews
   Returns the number of items in the DataViews[] array.}
  TdaDataModule = class(TppReportModule)
    private
      FTimer: TTimer;

      function GetDataViewCount: Integer;
      function GetDataViewForIndex(aIndex: Integer): TdaCustomDataView;
      procedure FixupReportReferences;
      procedure ConvertTo6000(Sender: TObject);

    protected
      procedure Loaded; override;
      procedure SetReport(aReport: TppCustomReport); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function GetInstanceForReport(aReport: TppCustomReport): TdaDataModule;

      procedure AddChild(aChild: TppRelative); override;
      procedure InsertChild(aPosition: Integer; aChild: TppRelative); override;
      function  RemoveChild(aChild: TppRelative): Integer; override;

      function AutoSearchFieldsExist: Boolean;
      procedure Convert(aVersionNo: Integer); override;
      function IndexOfDataView(aDataView: TdaDataView): Integer;
      function IsValidDataPipelineUserName(aUserName: String): Boolean;
      function GetDataDictionary: TObject;
      procedure GetDataPipelines(aList: TList); override;
      procedure GetDetailDataViews(aMasterDataView: TdaDataView; aList: TList);
      procedure GetLinkableDataViews(aList: TList);
      procedure GetLinkableDataViewsForDataView(aList: TList; aDataView: TdaDataView);
      function FindDataViewByUserName(aUserName: String): TdaCustomDataView;
      procedure UpdateShowAutoSearchDialog;

      procedure Merge(aDataModule: TdaDataModule);
      procedure MergeWithReport(aReport: TppCustomReport);

      property DataViews[Index: Integer]: TdaCustomDataView read GetDataViewForIndex;
      property DataViewCount: Integer read GetDataViewCount;

    end; {class, TdaDataModule}


  function daGetDataModule(aReport: TppCustomReport): TdaDataModule;

implementation

uses
  ppRTTI;



{------------------------------------------------------------------------------}
{ daGetDataModule }

function daGetDataModule(aReport: TppCustomReport): TdaDataModule;
begin
  Result := TdaDataModule.GetInstanceForReport(aReport);

end; {class, daGetDataModule }

{******************************************************************************
 *
 ** D A T A   M O D U L E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDataModule.Create }

constructor TdaDataModule.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  Template.FileExtension := 'dtm';
  Template.FileFilter    := 'Report Data file (*.dtm)|*.dtm';

  FTimer := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaDataModule.Destroy }

destructor TdaDataModule.Destroy;
begin

  FTimer.Free;

  inherited Destroy;

end; {constructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaDataModule.GetInstanceForReport }

class function TdaDataModule.GetInstanceForReport(aReport: TppCustomReport): TdaDataModule;
begin

  if (aReport = nil) then
    Result := nil
  else
    Result := TdaDataModule(aReport.MainReport.GetModuleForClass(TdaDataModule));

end;

{------------------------------------------------------------------------------}
{ TdaDataModule.Loaded }

procedure TdaDataModule.Loaded;
var
  lMainReport: TppReport;
  liIndex: Integer;
begin

  {connect dataviews to report, do this prior to calling inherited}
  for liIndex := 0 to DataViewCount - 1 do
  begin
    DataViews[liIndex].Report := Report;

    if (DataViews[liIndex].Top < 0) then
      DataViews[liIndex].Top := 10;

    if (DataViews[liIndex].Left < 0) then
      DataViews[liIndex].Left := 10;
  end;

  inherited Loaded;

  if (Report = nil) then Exit;

  {if report is a child report, then merge this dataview with the main report}
  if Report.InheritsFrom(TppChildReport) then
    begin
      MergeWithReport(Report.MainReport);

      Free;
    end;

  {set main report to modified of False}
  lMainReport := TppReport(Report.MainReport);

  if (lMainReport <> nil) then
    lMainReport.Modified := False;


end; {procedure, Loaded}

{------------------------------------------------------------------------------}
{ TdaDataModule.Convert }

procedure TdaDataModule.Convert(aVersionNo: Integer);
var
  liIndex: Integer;
begin
  inherited Convert(aVersionNo);

  for liIndex := 0 to DataViewCount - 1 do
    DataViews[liIndex].Convert(aVersionNo);
  
  if (FTimer = nil) and (aVersionNo < 6000) {and (csDesigning in ComponentState)} then
    begin
      FTimer := TTimer.Create(nil);
      FTimer.Interval := 50; {5 hundreths of a second}
      FTimer.OnTimer  := ConvertTo6000;
      FTimer.Enabled  := True;
    end;

end; {procedure, Convert}

{------------------------------------------------------------------------------}
{ TdaDataModule.ConvertTo6000 }

procedure TdaDataModule.ConvertTo6000(Sender: TObject);
var
  liIndex: Integer;
  lDataView: TdaDataView;
  lsNamingPrefix: String;
begin

  FTimer.Free;
  FTimer := nil;

  for liIndex := 0 to DataViewCount - 1 do
    begin
      lDataView := DataViews[liIndex];

      {assign a dataview name, if none exists}
      if (lDataView.Name = '') then
        begin
          lsNamingPrefix :=  Copy(lDataView.ClassName,4,Length(lDataView.ClassName));

          lDataView.Name := ppGetUniqueName(Owner, lsNamingPrefix, lDataView);
        end;

      {convert the dataview}
      TdaCustomDataView(lDataView).ConvertTo6000;
    end;

  if Report <> nil then
    begin
      Report.Modified := True;

      {indicate to form designer that this component has been modified}
      if (Owner is TForm) and (TForm(Owner).Designer <> nil) then
        TForm(Owner).Designer.Modified;
    end;


end; {procedure, ConvertTo6000}

{------------------------------------------------------------------------------}
{ TdaDataModule.FixupReportReferences }

procedure TdaDataModule.FixupReportReferences;
var
  liIndex: Integer;
begin

  for liIndex := 0 to DataViewCount - 1 do
    DataViews[liIndex].FixupReportReferences;

end;

{------------------------------------------------------------------------------}
{ TdaDataModule.SetReport }

procedure TdaDataModule.SetReport(aReport: TppCustomReport);
var
  liIndex: Integer;

begin
  {update DataView report references
    - must do this prior to the merge code below}
  for liIndex := 0 to DataViewCount - 1 do
    DataViews[liIndex].Report := aReport;

  {if child report, then merge with main report's data module}
  if (aReport <> nil) and aReport.InheritsFrom(TppChildReport) then
    MergeWithReport(TppChildReport(aReport).MainReport)
  else
    inherited SetReport(aReport);

end; {procedure, SetReport}

{------------------------------------------------------------------------------}
{ TdaDataModule.GetDataDictionary }

function TdaDataModule.GetDataDictionary: TObject;
var
  lDesigner: TComponent;
  lComponent: TComponent;
  lDataDictionary: TComponent;
  liIndex: Integer;
  lDataSettings: TObject;
  lPropRec: TraPropRec;
  lbUseDataDictionary: Boolean;
begin

  lDataDictionary := nil;
  lbUseDataDictionary := False;

  {get data dictionary from designer}
  if (Owner <> nil) then
    begin
      {find a designer component in owner}
      lDesigner := nil;
      liIndex := 0;
  
      while (lDesigner = nil) and (liIndex < Owner.ComponentCount) do
        begin
          lComponent := Owner.Components[liIndex];

           if (lComponent.ClassName = 'TppDesigner') then
             lDesigner := lComponent
           else
             Inc(liIndex);
        end;

      if (lDesigner <> nil) then
        begin

          if TraRTTI.GetPropRec(lDesigner.ClassType, 'DataSettings', lPropRec) then
            begin
              TraRTTI.GetPropValue(lDesigner, 'DataSettings', lDataSettings);

              if TraRTTI.GetPropRec(lDataSettings.ClassType, 'UseDataDictionary', lPropRec) then
                TraRTTI.GetPropValue(lDataSettings, 'UseDataDictionary', lbUseDataDictionary);

              if lbUseDataDictionary then
                if TraRTTI.GetPropRec(lDataSettings.ClassType, 'DataDictionary', lPropRec) then
                  TraRTTI.GetPropValue(lDataSettings, 'DataDictionary', lDataDictionary);

            end;

          end;


    end;

  Result := lDataDictionary;

end; {procedure, GetDataDictionary}

{------------------------------------------------------------------------------}
{ TdaDataModule.AddChild }

procedure TdaDataModule.AddChild(aChild: TppRelative);
begin
  inherited AddChild(aChild);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (aChild.Name = '') then
    aChild.Name := GetValidName(aChild);

  UpdateShowAutoSearchDialog;

end; {procedure, AddChild}

{------------------------------------------------------------------------------}
{ TdaDataModule.InsertChild }

procedure TdaDataModule.InsertChild(aPosition: Integer; aChild: TppRelative);
begin
  inherited InsertChild(aPosition, aChild);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  UpdateShowAutoSearchDialog;

end; {procedure, InsertChild}

{------------------------------------------------------------------------------}
{ TdaDataModule.RemoveChild}

function TdaDataModule.RemoveChild(aChild: TppRelative): Integer;
begin
  Result := inherited RemoveChild(aChild);

  if csDestroying in ComponentState then Exit;

  UpdateShowAutoSearchDialog;

end; {function, RemoveChild}

{------------------------------------------------------------------------------}
{ TdaDataModule.UpdateShowAutoSearchDialog}

procedure TdaDataModule.UpdateShowAutoSearchDialog;
begin

  {update main report ShowAutoSearchDialog boolean}
  if not(csLoading in ComponentState) then
    if (Report <> nil) and (Report.MainReport <> nil) then
      TppReport(Report.MainReport).ShowAutoSearchDialog := AutoSearchFieldsExist;

end; {procedure, UpdateShowAutoSearchDialog}

{------------------------------------------------------------------------------}
{ TdaDataModule.AutoSearchFieldsExist }

function TdaDataModule.AutoSearchFieldsExist: Boolean;
var
  liIndex: Integer;

begin
  Result := False;

  liIndex := 0;

  {determines whether any DataViews have AutoSearchFields}
  while not Result and (liIndex < DataViewCount) do
    if DataViews[liIndex].AutoSearchFieldsExist then
      Result := True
    else
      Inc(liIndex);

end;  {function, AutoSearchFieldsExist}

{------------------------------------------------------------------------------}
{@TdaDataModule.GetDataPipelines
 Fills the aList object with the DataPipelines contained in the DataModule's
 DataViews.}

procedure TdaDataModule.GetDataPipelines(aList: TList);
var
  lDataView: TdaCustomDataView;
  liDataView: Integer;
  liPipeline: Integer;
begin
  for liDataView := 0 to GetDataViewCount-1 do
    begin
      lDataView := GetDataViewForIndex(liDataView);
      for liPipeline := 0 to lDataView.DataPipelineCount-1 do
        aList.Add(lDataView.DataPipelines[liPipeline]);
    end;

end; {procedure, GetDataPipelines}

{------------------------------------------------------------------------------}
{ TdaDataModule.GetDataViewCount }

function TdaDataModule.GetDataViewCount: Integer;
begin
  Result := ChildCount;

end; {function, GetDataViewCount}

{------------------------------------------------------------------------------}
{ TdaDataModule.GetDataViewForIndex }

function TdaDataModule.GetDataViewForIndex(aIndex: Integer): TdaCustomDataView;
begin
  Result := TdaCustomDataView(Children[aIndex]);

end; {function, GetDataViewForIndex}

{------------------------------------------------------------------------------}
{ TdaDataModule.GetDetailDataViews }

procedure TdaDataModule.GetDetailDataViews(aMasterDataView: TdaDataView; aList: TList);
var
  liIndex: Integer;
  lDataView: TdaDataView;
begin

  aList.Clear;

  for liIndex := 0 to DataViewCount - 1 do
    begin
      lDataView := DataViews[liIndex];

      if lDataView.MasterDataView = aMasterDataView then
        aList.Add(lDataView);
    end;

end; {procedure, GetDetailDataViews}

{------------------------------------------------------------------------------}
{ TdaDataModule.GetLinkableDataViewsForDataView }

procedure TdaDataModule.GetLinkableDataViewsForDataView(aList: TList; aDataView: TdaDataView);
var
  liIndex: Integer;
  lDataView: TdaDataView;
begin

  aList.Clear;

  for liIndex := 0 to DataViewCount - 1 do
    begin
      lDataView := DataViews[liIndex];

      if lDataView.IsLinkable and (lDataView <> aDataview) and
        not(lDataView.InMasterChain(aDataView)) and (lDataView.IsLinkableAsMaster) then
        aList.Add(lDataView);
    end;

end; {procedure, GetLinkableDataViewsForDataView}

{------------------------------------------------------------------------------}
{ TdaDataModule.GetLinkableDataViews }

procedure TdaDataModule.GetLinkableDataViews(aList: TList);
var
  liIndex: Integer;
  lDataView: TdaDataView;
begin

  aList.Clear;

  for liIndex := 0 to DataViewCount - 1 do
    begin
      lDataView := DataViews[liIndex];

      if lDataView.IsLinkable then
        aList.Add(lDataView);
    end;

end; {procedure, GetLinkableDataViews}

{------------------------------------------------------------------------------}
{ TdaDataModule.IndexOfDataView }

function TdaDataModule.IndexOfDataView(aDataView: TdaDataView): Integer;
begin
  Result := IndexOfChild(aDataView);
end; {function, IndexOfDataView}

{------------------------------------------------------------------------------}
{ TdaDataModule.Merge }

procedure TdaDataModule.Merge(aDataModule: TdaDataModule);
var
  liIndex: Integer;
  lDataView: TdaCustomDataView;
begin

  for liIndex := 0 to aDataModule.DataViewCount - 1  do
    begin
      lDataView := aDataModule.DataViews[0];

      {set width to 0 so that toolwindow positioned will be recalced}
      lDataView.Width  := 0;

      {set report reference, if there is none}
      if lDataView.Report = nil then
        lDataView.Report := Report;

      {assign self as new parent}
      lDataView.Parent := Self;


    end;

end; {procedure, Merge}

{------------------------------------------------------------------------------}
{ TdaDataModule.MergeWithReport }

procedure TdaDataModule.MergeWithReport(aReport: TppCustomReport);
var
  lDataModule: TdaDataModule;
begin

  if (aReport = nil) then Exit;

  FixupReportReferences;

  {get report's data module}
  lDataModule := daGetDataModule(aReport);

  {Re-assign this data module to the report (if no module exists),
   otherwise merge this module with the report's data module}
  if (lDataModule = nil) then
    SetReport(aReport)
  else
    lDataModule.Merge(Self);

end; {procedure, MergeWithReport}

{------------------------------------------------------------------------------}
{ TdaDataModule.FindDataViewByUserName }

function TdaDataModule.FindDataViewByUserName(aUserName: String): TdaCustomDataView;
var
  liIndex: Integer;
  lDataView: TdaCustomDataView;

begin

  Result  := nil;
  liIndex := 0;

  while (Result = nil) and (liIndex < GetDataViewCount) do
    begin
      lDataView := GetDataViewForIndex(liIndex);

      if (lDataView.UserName = aUserName) then
        Result := lDataView;

      Inc(liIndex);

    end;

end; {function, FindDataViewByUserName}

{------------------------------------------------------------------------------}
{ TdaDataModule.IsValidDataPipelineUserName }

function  TdaDataModule.IsValidDataPipelineUserName(aUserName: String): Boolean;
var
  liIndex: Integer;
  liPipeline: Integer;
  lDataView: TdaCustomDataView;
  lDataPipeline: TppDataPipeline;

begin

  Result := True;
  liIndex := 0;

  while Result and (liIndex < GetDataViewCount) do
    begin
      lDataView := GetDataViewForIndex(liIndex);

      liPipeline := 0;

      while Result and (liPipeline < lDataView.DataPipelineCount) do
        begin
          lDataPipeline := lDataView.DataPipelines[liPipeline];

          if (lDataPipeline.UserName = aUserName) then
            Result := False;

          Inc(liPipeline);

        end;


      Inc(liIndex);

    end;


end; {function, FindDataViewByUserName}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  RegisterClass(TdaDataModule);

finalization

  UnRegisterClass(TdaDataModule);
end.
