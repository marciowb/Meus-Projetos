{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit daQueryDataView;

interface

{$I ppIfDef.pas}

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Graphics,
  ppComm, ppClass, ppRelatv, ppDB, ppUtils, ppTypes, ppForms, ppReport, ppRTTI, ppDsgnDB,
  daDB, daDataView, daSQL, daForms, daDataModule, ppClasUt, ppASField,
  ppDBPipe,
  ppParameter;
  
type

  { TdaGenerateSQLEvent

    Used to establish communication between the dataview and the SQL object during
    the genaration of the SQL (i.e. BeforeGenerateSQL, AfterGenerateSQL }

  TdaGenerateSQLEvent = procedure(Sender: TObject; aSQL: TdaSQL) of object;

  {@TdaQueryDataView
   Abstract ancestor for query based DataViews that use the Query Wizard and
   Query Designer. TdaQueryDataView class manages a child TdaSQL object that
   is used by the QueryTools to build an object based description of a SQL
   statement.

   DADE Plug-ins descend from TdaQueryDataView and add functionality
   to manage specific data access component sets such as ADO, IBExpress,
   BDE, dbExpress, etc. An example of a descendant is TdaADOQueryDataView which
   manages a TADOQuery component.}

  {@TdaQueryDataView.SQL
    Provides access to the SQL object used to describe a SQL statement.}

  TdaQueryDataView = class (TdaCustomDataView)
    private
      FClearingMasterDataView: Boolean;
      FLinkedAutoSearchFields: TList;
      FMasterDataViewUserName: String;
      FOnAfterGenerateSQL: TdaGenerateSQLEvent;
      FOnBeforeGenerateSQL: TdaGenerateSQLEvent;
      FRemovingAutoSearchFields: Boolean;
      FSession: TdaSession;
      FSettingActive: Boolean;
      FSQL: TdaSQL;
      FQueryOutOfSync: Boolean;
      FSQLObjectModified: Boolean;

      procedure AddAutoSearchFields;
      procedure AutoSearchFieldChangeEvent(Sender: TObject);
      procedure ClearMasterDataView;
      function CreateAutoSearchFieldForCriteria(aCriteria: TdaCriteria): TppAutoSearchField;
      procedure CreateAutoSearchFields(aReport: TppReport);
      procedure CreateCriteriaForAutoSearchField(aAutoSearchField: TppAutoSearchField);
      procedure CreateField(aDataPipeline: TppDataPipeline; aField: TdaField);
      procedure CreateGroupAutoSearchFields(aReport: TppReport);
      procedure CreateLinkObject(aMasterDataView: TdaDataView; const aMasterFieldAlias, aDetailFieldAlias: String);
      function DisplayLinkDialog(aSQLObjects: TList): Boolean;
      procedure FixUpMasterDataView;
      procedure FixUpRename;
      procedure FreeAutoSearchFields(aReport: TppReport);
      function GetDataPipeline: TppDBPipeline;
      function GetMasterQueryDataView: TdaQueryDataView;
      procedure GetSQLObjectsInDataModule(aDataModule: TdaDataModule; var aList: TList);
      procedure GetSQLObjectsInChildOwner(aChildOwner: TComponent; var aList: TList);
      function GetValidSQLObjectName: String;
      procedure RemoveAutoSearchFields;
      procedure ReportCreateAutoSearchCriteriaEvent(aAutoSearchField: TObject);
      procedure ReportGetAutoSearchValuesEvent;
      procedure SetSQL(aSQL: TdaSQL);
      procedure SetSQLObjectDataDictionary;
      procedure SetSQLObjectName;
      procedure UpdateAutoSearchFields;
      procedure UpdateUserName;
      procedure ValidateLinks;

    protected
      procedure CreatePipelineLinksForParameterizedSQL(aDataPipeline: TppDataPipeline); virtual;
      procedure CreatePipelineLinksForMagicSQL(aDataPipeline: TppDataPipeline);  virtual;
      procedure CreatePipelineLinksForManualSQL(aDataPipeline: TppDataPipeline); virtual;

      function GetChildOwner: TComponent; override;
      procedure SaveComponents(Proc: TGetChildProc); override;
      procedure Loaded; override;

      function GetDescription: String; override;
      function GetLinkColor: TColor; override;
      function GetSQL: TdaSQL; virtual;
      procedure RefreshQuery; virtual;
      procedure ReportBeforePrintEvent; override;
      procedure SetActive(aValue: Boolean); override;
      procedure SetAutoSearchTabOrder(aValue: Integer); override;
      procedure SetLinkColor(aColor: TColor); override;
      procedure SetMasterDataView(aDataView: TdaDataView); override;
      procedure SetParent(aParent: TppRelative); override;
      procedure SetQueryOutOfSync(aValue: Boolean);
      procedure SetReport(aReport: TppCustomReport); override;
      procedure SetUserName(const aUserName: TComponentName); override;
      procedure SQLToDataView; virtual;
      procedure SQLChanged; virtual;
      procedure UpdateShowAutoSearchDialog;

      procedure DoAfterGenerateSQL(aSQL: TdaSQL); virtual;
      procedure DoBeforeGenerateSQL(aSQL: TdaSQL); virtual;
      procedure DoParamValueChanged(aParameter: TppParameter); virtual;
      property DataPipeline: TppDBPipeline read GetDataPipeline;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Convert(aVersionNo: Integer); override;
      procedure ConvertTo6000; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;

      class function DataDesignerClass: TClass; override;

      function AutoSearchFieldsExist: Boolean; override;
      function GetDataModule: TdaDataModule;
      function  GetValidName(aComponent: TComponent): String;  override;
      procedure Init; override;

      { streaming routines for saving SQL object }
      procedure AddChild(aChild: TppRelative); override;
      procedure InsertChild(aPosition: Integer; aChild: TppRelative); override;
      function RemoveChild(aChild: TppRelative): Integer; override;

      { allow for the use of TdaSQL descendants }
      class function SQLClass: TdaSQLClass; virtual;

      { DataView Linking }
      function CreateAutoLink(aLinkableDataViews: TList; aDataDictionary: TObject): Boolean; override;
      procedure CreateLink(aMasterDataView: TdaDataView; aMasterFieldAlias, aDetailFieldAlias: String); override;
      procedure DeleteLink(aIndex: Integer); override;
      function GetAutoLinks(aMasterDataView: TdaQueryDataView; aDataDictionary: TppDataDictionary): Boolean;
      function GetLinkColorForField(aFieldName: String): TColor; override;
      function GetLinkCount: Integer; override;
      function GetLinkDescription: String; override;
      procedure GetLinkFieldNames(aIndex: Integer; var aMasterSQLFieldName, aDetailSQLFieldName: String); override;
      function GetMagicFieldCount: Integer; override;
      procedure GetMagicSQL(aSQLText: TStrings); override;
      procedure GetMagicSQLObject(var aMagicSQL: TdaSQL);
      function InMasterChain(aDataView: TdaDataView): Boolean; override;
      function IsLinkable: Boolean; override;
      function IsLinkableAsMaster: Boolean; override;
      procedure Link(aLinkableDataViews: TList); override;
      procedure LinkChanged; override;
      procedure OutOfSync; override;
      procedure Sync; override;
      procedure UpdateEnabledOptions(aLinkableDataViews: TList); override;
      procedure UpdateEditOptions; overload;
      procedure UpdateLinkColors(aUpdateUpward: Boolean);
      procedure UpdatePipelineFieldName(const aOldSQLFieldName, aNewSQLFieldName: String);

      property MasterQueryDataView: TdaQueryDataView read GetMasterQueryDataView;
      property OnAfterGenerateSQL: TdaGenerateSQLEvent read FOnAfterGenerateSQL write FOnAfterGenerateSQL;
      property OnBeforeGenerateSQL: TdaGenerateSQLEvent read FOnBeforeGenerateSQL write FOnBeforeGenerateSQL;
      property Session: TdaSession read FSession;

    published
      property AutoSearchTabOrder;
      property Description stored False;
      property MasterDataViewUserName: String read FMasterDataViewUserName write FMasterDataViewUserName;
      property SQL: TdaSQL read GetSQL write SetSQL stored False;

  end; {class, TdaQueryDataView}



implementation

{*******************************************************************************
 *
 ** Q U E R Y   D A T A V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.Create }

constructor TdaQueryDataView.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  EventNotifies := EventNotifies + [ciReportGetAutoSearchValues,
                                    ciBeforeGenerateSQL,
                                    ciAfterGenerateSQL,
                                    ciReportCreateAutoSearchCriteria,
                                    ciSQLLinkChanged,
                                    ciSQLSelectFieldsChanged,
                                    ciSQLSearchCriteriaChanged,
                                    ciSQLOrderByFieldsChanged,
                                    ciSQLConvertedToText,
                                    ciSQLNameChanged,
                                    ciSQLObjectModified,
                                    ciSQLObjectEndUpdate,
                                    ciParamValueChange];


  EditOptions := EditOptions + [ppemLink];
  EnabledOptions := EnabledOptions + [ppemLink];

  FClearingMasterDataView := False;
  FLinkedAutoSearchFields := TList.Create;
  FMasterDataViewUserName := '';
  FOnAfterGenerateSQL := nil;
  FOnBeforeGenerateSQL := nil;
  FQueryOutOfSync := False;
  FRemovingAutoSearchFields := False;
  FSettingActive := False;

  {create session}
  FSession := TdaSessionClass(SessionClass).Create(Self);
  FSession.DataOwner := aOwner;

  {create sql object}
  FSQL := SQLClass.Create(Self);

  FSQL.AddEventNotify(Self);
  FSQL.Session := FSession;
  SetSQLObjectDataDictionary;

  FSQLObjectModified := False;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.Destroy }

destructor TdaQueryDataView.Destroy;
begin

  RemoveAutoSearchFields;

  if (MasterDataView <> nil) then
    ClearMasterDataView;

  FSQL.Free;
  FSession.Free;
  FLinkedAutoSearchFields.Free;

  inherited Destroy;
  
end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.Convert }

procedure TdaQueryDataView.Convert(aVersionNo: Integer);
var
  liIndex: Integer;
  lField: TdaField;
  lsOldFieldName: String;
  lDataPipeline: TppDataPipeline;
  liCalc: Integer;
  lsExpression: string;
begin

  FSQL.Convert(aVersionNo);

  if (aVersionNo < 5600) then
    SetSQLObjectName;

  if ((aVersionNo < 6030))  and (DataPipelineCount > 0) and not(FSQL.EditSQLasText) then
    begin
      {update aliasing for Order By Fields}
      for liIndex := 0 to FSQL.OrderByFieldCount - 1 do
        begin
          lField := FSQL.OrderByFields[liIndex];

          lField.SQLFieldName := lField.FieldName;

          if (lField.TableName <> '') and (lField.TableName[1] = '"') then
            lField.TableName := Copy(lField.TableName, 2, Length(lField.TableName) - 2);
        end;
    end;

  if ((aVersionNo < 6000))  and (DataPipelineCount > 0) and not(FSQL.EditSQLasText) then
    begin

      lDataPipeline := DataPipelines[0];

      {update aliasing for Select Fields}
      for liIndex := 0 to FSQL.SelectFieldCount - 1 do
        begin
          lField := FSQL.SelectFields[liIndex];

          lsOldFieldName := lField.SQLFieldName;

          lField.SQLFieldName := FSQL.GetMagicAlias(lField);

          if (lField.TableName <> '') and (lField.TableName[1] = '"') then
            lField.TableName := ppExtractQuotedStr(lField.TableName);

          if (Report <> nil) and (lsOldFieldName <> lField.SQLFieldName) then
            Report.ConvertDataFieldNames(lDataPipeline, lsOldFieldName, lField.SQLFieldName);

          // update any calc expression that contains a reference to the renamed field
          if (lsOldFieldName <> lField.SQLFieldName) then
            for liCalc := 0 to FSQL.CalcFieldCount-1 do
              begin
               lsExpression := FSQL.CalcFields[liCalc].Expression;

               if Pos(lsOldFieldName, lsExpression) > 0 then
                 SQL.CalcFields[liCalc].Expression := StringReplace(lsExpression, lsOldFieldName, lField.SQLFieldName, [rfReplaceAll]);

              end;

        end;

      {update aliasing for Calc Fields}
      for liIndex := 0 to FSQL.CalcFieldCount - 1 do
        begin
          lField := FSQL.CalcFields[liIndex];

          lsOldFieldName := lField.SQLFieldName;

          lField.SQLFieldName := FSQL.GetMagicAlias(lField);

          if (lField.TableName <> '') and (lField.TableName[1] = '"') then
            lField.TableName := ppExtractQuotedStr(lField.TableName);

          if (Report <> nil) and (lsOldFieldName <> lField.SQLFieldName) then
            Report.ConvertDataFieldNames(lDataPipeline, lsOldFieldName, lField.SQLFieldName);

          // update any calc expression that contains a reference to the renamed field
          if (lsOldFieldName <> lField.SQLFieldName) then
            for liCalc := 0 to FSQL.CalcFieldCount-1 do
              begin
                if (liCalc = liIndex) then Continue;

                lsExpression := FSQL.CalcFields[liCalc].Expression;

                if (Length(lsOldFieldName) > 1) and (Pos(lsOldFieldName, lsExpression) > 0) then
                  SQL.CalcFields[liCalc].Expression := StringReplace(lsExpression, lsOldFieldName, lField.SQLFieldName, [rfReplaceAll]);

              end;


        end;

      FSQL.Valid;

      FQueryOutOfSync := True;

      SQLChanged;

      SQLToDataView;
    end;

end; {procedure, Convert}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.ConvertTo6000 }

procedure TdaQueryDataView.ConvertTo6000;
var
  lDataModule: TdaDataModule;
begin

  inherited ConvertTo6000;

  lDataModule := GetDataModule;

  {this will remove any .pas file declarations that may be present}
  RemoveComponent(FSQL);

  if (lDataModule.Owner <> nil) then
    begin
      lDataModule.Owner.InsertComponent(FSQL);
      lDataModule.Owner.RemoveComponent(FSQL);
    end;

  InsertComponent(FSQL);

end; {procedure, ConvertTo6000}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.Notify }

procedure TdaQueryDataView.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  {remove corresponding criteria}
  if (aOperation = ppopRemove) and (aCommunicator is TppAutoSearchField) and (FLinkedAutoSearchFields.IndexOf(aCommunicator) <> -1) then
    begin
      if not(FRemovingAutoSearchFields) then
        TppAutoSearchField(aCommunicator).Criteria.Free;

      FLinkedAutoSearchFields.Remove(aCommunicator);
      FQueryOutOfSync := True;

    end

  {clear the master dataview reference and free the links}
  else if (aCommunicator is TdaQueryDataView) and (aCommunicator = MasterDataView) then
    begin

      case aOperation of
        ppopRemove: ClearMasterDataView;
        ppopUserNameChange: FMasterDataViewUserName := MasterDataView.UserName;
      end;

    end;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.EventNotify }

procedure TdaQueryDataView.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
var
  lField: Integer;
begin

  inherited EventNotify(aCommunicator, aEventID, aParams);

  if (aCommunicator = FSQL) then

    case aEventID of
      ciBeforeGenerateSQL:
        DoBeforeGenerateSQL(FSQL);

      ciAfterGenerateSQL:
        DoAfterGenerateSQL(FSQL);

    end

  else if (aCommunicator = Report) then

    case aEventID of
      ciReportGetAutoSearchValues:
        ReportGetAutoSearchValuesEvent;

      ciReportCreateAutoSearchCriteria:
        begin
          aParams.GetParamValue(0, lField);

          ReportCreateAutoSearchCriteriaEvent(TppAutoSearchField(lField));
        end;

    end

  else if (aCommunicator = MasterDataView) then

    case aEventID of

      ciSQLConvertedToText:
        ValidateLinks;

      ciSQLSelectFieldsChanged:
        ValidateLinks;

      ciSQLSearchCriteriaChanged, ciSQLOrderByFieldsChanged, ciSQLLinkChanged:
        ValidateLinks;

      ciSQLNameChanged:
        DoOnNameChange;

    end
  else if (aCommunicator is TppParameter) and (aEventID = ciParamValueChange) then
    DoParamValueChanged(TppParameter(aCommunicator));


end; {procedure, EventNotify}
{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetDataModule }

function TdaQueryDataView.GetDataModule: TdaDataModule;
begin
  if (Parent is TdaDataModule) then
    Result := TdaDataModule(Parent)
  else
    Result := nil;

end; {procedure, GetDataModule}


{------------------------------------------------------------------------------}
{ TdaQueryDataView.SetUserName }

procedure TdaQueryDataView.SetUserName(const aUserName: TComponentName);
begin

  if (csReading in ComponentState) or (csLoading in ComponentState) then
    inherited SetUserName(aUserName)
  else
    begin
      RemoveAutoSearchFields;

      inherited SetUserName(aUserName);

      AddAutoSearchFields;
    end;

  if (aUserName <> UserName) then
    begin
      FixUpRename;

      Modification;
    end;

end; {procedure, SetUserName}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.FixUpRename }

procedure TdaQueryDataView.FixUpRename;
var
  lsNewName: String;
begin

  if (FSQL <> nil) and (FSQL.DataPipelineName <> '') then
    begin
      lsNewName := Copy(UserName, Length('Query_')+ 1, Length(UserName));

      FSQL.DataPipelineName := lsNewName;
    end;

end; {procedure, FixUpRename}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.SetParent }

procedure TdaQueryDataView.SetParent(aParent: TppRelative);
var
  lbMerge: Boolean;
begin

  lbMerge := (Parent <> nil) and (aParent <> nil);

  inherited SetParent(aParent);

  if (csLoading in ComponentState) or (csDestroying in ComponentState) then Exit;

  {need the parent to be able to assign a SQL object name}
  if aParent <> nil then
    SetSQLObjectName;

  if (lbMerge) then
    begin
      // call to keep naming in sync
      FixUpRename;

      UpdateUserName;

    end;


end; {procedure, SetParent}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.SetSQLObjectName }

procedure TdaQueryDataView.SetSQLObjectName;
begin

  if (FSQL.Name = '') and not (csReading in ComponentState)  and not (csLoading in ComponentState) then
    FSQL.Name := GetValidSQLObjectName;

end; {procedure, SetSQLObjectName}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetValidName }

function TdaQueryDataView.GetValidName(aComponent: TComponent): String;
begin

  if aComponent is TdaSQL then
    Result := GetValidSQLObjectName
  else
    Result := inherited GetValidName(aComponent);

end; {function, GetValidName}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetValidSQLObjectName }

function TdaQueryDataView.GetValidSQLObjectName: String;
var
  lDataModule: TdaDataModule;
  lSQLObjects: TList;
begin

  Result := '';

  lDataModule := GetDataModule;

  {store currently used naming numbers to lNumberList}
  lSQLObjects := TList.Create;

  try
    {name space is either the DataModule or the DataModule's Owner}
    if GetChildOwner = Self then
      GetSQLObjectsInDataModule(lDataModule, lSQLObjects)

    else if (lDataModule <> nil) then
      GetSQLObjectsInChildOwner(lDataModule.Owner, lSQLObjects);

    Result := ppGetUniqueNameForComponents('daSQL', SQL, lSQLObjects);

  finally
    lSQLObjects.Free;
  end;

end; {function, GetValidSQLObjectName}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetSQLObjectsInDataModule }

procedure TdaQueryDataView.GetSQLObjectsInDataModule(aDataModule: TdaDataModule; var aList: TList);
var
  liIndex: Integer;
  lDataView: TdaDataView;
begin
  if (aDataModule = nil) then Exit;

  {build list of SQL objects used within the scope of the DataModule}
  for liIndex := 0 to aDataModule.DataViewCount-1 do
    begin
      lDataView := aDataModule.DataViews[liIndex];

      if (lDataView is TdaQueryDataView) and (lDataView <> Self) then
        aList.Add(TdaQueryDataView(lDataView).SQL);

    end;

end; {procedure, GetSQLObjectsInDataModule}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetSQLObjectsInChildOwner }

procedure TdaQueryDataView.GetSQLObjectsInChildOwner(aChildOwner: TComponent; var aList: TList);
var
  liIndex: Integer;
  lDataModule: TdaDataModule;
begin

  if aChildOwner = nil then Exit;

  {build list of SQL objects used within the scope of the Owner}
  for liIndex := 0 to aChildOwner.ComponentCount-1 do
    if aChildOwner.Components[liIndex] is TdaDataModule then
      begin
        lDataModule := TdaDataModule(aChildOwner.Components[liIndex]);

        GetSQLObjectsInDataModule(lDataModule, aList);
      end;

end; {procedure, GetSQLObjectsInChildOwner}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.SetReport }

procedure TdaQueryDataView.SetReport(aReport: TppCustomReport);
begin

  SetSQLObjectDataDictionary;

  if (csReading in ComponentState) or (csLoading in ComponentState) then
    begin
      inherited SetReport(aReport);
    end
  else
    begin
      RemoveAutoSearchFields;

      inherited SetReport(aReport);

      AddAutoSearchFields;
    end;

end; {procedure, SetReport}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetSQL  }

function TdaQueryDataView.GetSQL: TdaSQL;
begin
  Result := FSQL;

end;

{------------------------------------------------------------------------------}
{ TdaQueryDataView.SetSQL  }

procedure TdaQueryDataView.SetSQL(aSQL: TdaSQL);
var
  lbNameChanged: Boolean;
  lbSelectFieldsChanged: Boolean;
  lbSearchCriteriaChanged: Boolean;
  lbSortChanged: Boolean;
  lbConvertedToText: Boolean;
  lbMasterSQLChanged: Boolean;
begin

  if (csReading in ComponentState) or (csLoading in ComponentState) then
    begin
      FSQL.Assign(aSQL);

      FQueryOutOfSync := True;
    end

  else
    begin
      if FSQLObjectModified then
        FSQLObjectModified := False;


      {determine what changes were made}
      lbNameChanged := (DataPipelineCount > 0) and (aSQL.DataPipelineName <> DataPipelines[0].UserName);

      if (aSQL.EditSQLAsText) then
        begin
          lbConvertedToText := not(FSQL.EditSQLAsText) and (aSQL.EditSQLAsText);
          lbSelectFieldsChanged := FSQL.SelectFieldsChanged(aSQL);

          {assign the new sql object}
          FSQL.Assign(aSQL);

          if (FSQL.MasterSQL = nil) then
            SetMasterDataView(nil)
          else
            SetMasterDataView(FSQL.MasterSQL.DataView);

         {validate SQL links}
          ValidateLinks;

          {must do this after clearing the links}
          UpdateEditOptions();

          {free any previously created autosearch fields and create new ones}
          UpdateAutoSearchFields;


          {update the main report.ShowAutoSearchDialog boolean property - do this after
           the assign above}
          UpdateShowAutoSearchDialog;

          {if sql was converted to text, notify detail dataviews}
          if lbConvertedToText then
            SendEventNotify(Self, ciSQLConvertedToText, nil);

          {if select fields were changed, notify detail dataviews}
          if lbSelectFieldsChanged then
            SendEventNotify(Self, ciSQLSelectFieldsChanged, nil);

          {indicate that the SQL object is now out of sync with the Query object}
          FQueryOutOfSync := True;

          Modification;

          RefreshQuery;
        end
      else
        begin
          lbSelectFieldsChanged := FSQL.SelectFieldsChanged(aSQL);
          lbSearchCriteriaChanged := FSQL.SearchCriteriaChanged(aSQL);
          lbSortChanged := FSQL.OrderByFieldsChanged(aSQL);
          lbMasterSQLChanged := FSQL.MasterSQL <> aSQL.MasterSQL;

          {assign the new sql object}
          FSQL.Assign(aSQL);

          {update the main report.ShowAutoSearchDialog boolean property - do this after
           the assign above}
          UpdateShowAutoSearchDialog;

          {free any previously created autosearch fields and create new ones}
          UpdateAutoSearchFields;

          {if select fields were changed, notify detail dataviews}
          if lbSelectFieldsChanged then
            SendEventNotify(Self, ciSQLSelectFieldsChanged, nil);

          {if search criteria were changed, notify detail dataviews}
          if lbSearchCriteriaChanged then
            SendEventNotify(Self, ciSQLSearchCriteriaChanged, nil);

          {if sort changed, notify detail dataviews}
          if lbSortChanged then
            SendEventNotify(Self, ciSQLOrderByFieldsChanged, nil);

          {indicate that the SQL object is now out of sync with the Query object}
          FQueryOutOfSync := True;

          SetActive(False);

          Modification;

          if lbMasterSQLChanged then
            if (FSQL.MasterSQL = nil) then
              SetMasterDataView(nil)
            else
              SetMasterDataView(FSQL.MasterSQL.DataView);

          {if the selected fields were changed or master SQL changed, then validate the SQL links and refresh the query}
          if lbSelectFieldsChanged or lbMasterSQLChanged then
            begin
              ValidateLinks;

              RefreshQuery;
            end;

        end;

        if lbNameChanged then
          begin
            UpdateUserName;

            SendEventNotify(Self, ciSQLNameChanged, nil);
          end;

    end;

end; {procedure, SetSQL}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.SetQueryOutOfSync }

procedure TdaQueryDataView.SetQueryOutOfSync(aValue: Boolean);
begin

  {close any active datasets}
  if (Active) and (aValue) then
    SetActive(False);

  {indicate that the Query object is out of sync with the SQL object}
  FQueryOutOfSync := aValue;

  {notify detail dataviews that master query has changed}
  if FQueryOutOfSync then
    SendEventNotify(Self, ciSQLLinkChanged, nil);

  Modification;

end; {procedure, SetQueryOutOfSync}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.SetActive }

procedure TdaQueryDataView.SetActive(aValue: Boolean);
begin

  FSettingActive := True;

  {if Query object is out of sync with the SQL object, then refresh the query before making dataview active}
  if aValue and (FQueryOutOfSync) then
    RefreshQuery;

  // activate parmeterized SQL, the master data needs to be active
  if aValue and (FSQL.LinkCount > 0) and (FSQL.LinkType = ltParameterizedSQL) then
    if (MasterDataView <> nil) and not(MasterDataView.Active) then
      MasterDataView.Active := True;
  

  inherited SetActive(aValue);

  FSettingActive := False;

end; {procedure, SetActive}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.SQLClass }

class function TdaQueryDataView.SQLClass: TdaSQLClass;
begin
  Result := TdaSQL;
end; {function, SQLClass}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.DataDesignerClass }

class function TdaQueryDataView.DataDesignerClass: TClass;
begin
  Result := GetClass('TdaQueryDesigner');
end; {function, DataDesignerClass}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.Init }

procedure TdaQueryDataView.Init;
begin

  if (FSQL <> nil) then Exit;

  FSQL := SQLClass.Create(Self);
  SetSQLObjectName;

  {descendants should add code here to create a DataPipeline}

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.UpdateUserName }

procedure TdaQueryDataView.UpdateUserName;
var
  lDataPipeline: TppDataPipeline;
begin

  lDataPipeline := DataPipelines[0];

  {assign dataview user name}
  UserName := 'Query_' + ppTextToIdentifier(FSQL.DataPipelineName);

  lDataPipeline.UserName := FSQL.DataPipelineName;
  lDataPipeline.Name := lDataPipeline.UserName;

end; {procedure, UpdateUserName}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.RefreshQuery }

procedure TdaQueryDataView.RefreshQuery;
begin

  if not(FSettingActive) and (Active) then
    SetActive(False);

  {transfer SQL statement to TQuery object}
   SQLChanged;

  {transfer new info in SQL object to dataview}
  SQLToDataView;


  {refresh the dataview window with the new TppField objects}
  LinkChanged;

  FQueryOutOfSync := False;

end; {procedure, RefreshQuery}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.SQLChanged }

procedure TdaQueryDataView.SQLChanged;
begin

  {descendants can add code here update implementation specific objects.
   For example update a TQuery object with SQL and DatabaseName }

end; {procedure, SQLChanged}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.SQLToDataView }

procedure TdaQueryDataView.SQLToDataView;
var
  liIndex: Integer;
  lDataPipeline: TppDataPipeline;
  lSQL: TdaSQL;
  lMagicSQL: TdaSQL;
begin

  if (DataPipelineCount = 0) then
    raise EDataError.Create('TdaQueryDataView.SQLToDataView: No data pipeline to assign query to.')
  else
    lDataPipeline := DataPipelines[0];

  lSQL := GetSQL;

  {free the links and the fields}
  lDataPipeline.FreeFields;

  {only free links when MasterDataView is assigned, otherwise assume we have manual links}
  if (MasterDataView <> nil) then
    lDataPipeline.FreeLinks;

  {create the fields}
  for liIndex := 0 to lSQL.SelectFieldCount - 1 do
    CreateField(lDataPipeline, lSQL.SelectFields[liIndex]);

  if (lSQL.CalcFieldCount > 0) then
    begin
      lMagicSQL := lSQL.GetMagicSQLObject; // SQL rather than FSQL here

      if (lMagicSQL <> nil) then
        for liIndex := 0 to lMagicSQL.CalcFieldCount - 1 do
          CreateField(lDataPipeline, lMagicSQL.CalcFields[liIndex]);

    end;

  {configure linking}
  if (MasterDataView <> nil) then
    begin
      lDataPipeline.MasterDataPipeline := MasterDataView.DataPipelines[0];
      lDataPipeline.SkipWhenNoRecords := lSQL.SkipWhenNoRecords;

      case lSQL.LinkType of
        ltMagicSQL:
          CreatePipelineLinksForMagicSQL(lDataPipeline);
        ltParameterizedSQL:
          CreatePipelineLinksForParameterizedSQL(lDataPipeline);
        ltManualSQL:
          CreatePipelineLinksForManualSQL(lDataPipeline);

      end;

    end;


end; {procedure, SQLToDataView}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.CreateField }

procedure TdaQueryDataView.CreateField(aDataPipeline: TppDataPipeline; aField: TdaField);
var
  lField: TppField;
begin

  {create field from field map}
  lField := TppField.Create(aDataPipeline);
  lField.Name := lField.GetValidName(lField);

  lField.DataType      := aField.DataType;
  lField.DisplayFormat := aField.DisplayFormat;
  lField.DisplayWidth  := aField.DisplayWidth;
  lField.FieldAlias    := aField.Alias;
  lField.FieldLength   := aField.FieldLength;
  lField.FieldName     := aField.SQLFieldName;
  lField.IsDetail      := aField.IsDetail;
  lField.Linkable      := aField.Linkable;
  lField.TableName     := aField.TableSQLAlias;
  lField.Searchable    := aField.Searchable;
  lField.Selectable    := aField.Selectable;
  lField.Sortable      := aField.Sortable;

  lField.DataPipeline := aDataPipeline;

end; {procedure, CreateField}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.DoAfterGenerateSQL }

procedure TdaQueryDataView.DoAfterGenerateSQL(aSQL: TdaSQL);
begin
  if Assigned(FOnAfterGenerateSQL) then FOnAfterGenerateSQL(Self, aSQL);
end; {procedure, DoAfterGenerateSQL}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.DoBeforeGenerateSQL }

procedure TdaQueryDataView.DoBeforeGenerateSQL(aSQL: TdaSQL);
begin
  if Assigned(FOnBeforeGenerateSQL) then FOnBeforeGenerateSQL(Self, aSQL);
end; {procedure, DoBeforeGenerateSQL}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.ReportBeforePrintEvent }

procedure TdaQueryDataView.ReportBeforePrintEvent;
begin

  if FQueryOutOfSync then
    begin
      RefreshQuery;

      Report.Engine.Reset;
    end;

  inherited ReportBeforePrintEvent;

end; {procedure, ReportBeforePrintEvent}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.SaveComponents }

procedure TdaQueryDataView.SaveComponents(Proc: TGetChildProc);
begin

  inherited SaveComponents(Proc);

  if (FSQL <> nil) then
    Proc(FSQL);

end; {procedure, SaveComponents}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.AddChild }

procedure TdaQueryDataView.AddChild(aChild: TppRelative);
begin

  if (aChild is TdaSQL) then
    begin
      FSQL.Free;

      FSQL := TdaSQL(aChild);

      SetSQLObjectName;

      FSQL.AddEventNotify(Self);
    end
  else
    inherited AddChild(aChild);

end; {procedure, AddChild}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.InsertChild }

procedure TdaQueryDataView.InsertChild(aPosition: Integer; aChild: TppRelative);
begin

  if (aChild is TdaSQL) then
    begin
      FSQL.Free;

      FSQL := TdaSQL(aChild);
      
      SetSQLObjectName;

      FSQL.AddEventNotify(Self);
    end
  else
    inherited InsertChild(aPosition, aChild);

end; {procedure, InsertChild}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.RemoveChild }

function TdaQueryDataView.RemoveChild(aChild: TppRelative): Integer;
begin

  Result := -1;

  if (aChild is TdaSQL) then
    begin
      FSQL.RemoveEventNotify(Self);

      FSQL := nil
    end
  else
    Result := inherited RemoveChild(aChild);

end; {function, RemoveChild}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetChildOwner }

function TdaQueryDataView.GetChildOwner: TComponent;
begin
  Result := Self;
end; {function, GetChildOwner}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.Loaded }

procedure TdaQueryDataView.Loaded;
var
  lDataModule: TdaDataModule;
begin

  inherited Loaded;

  {reestablish connection with master dataview}
  FixUpMasterDataView;

  FSQL.FixUpLinkColors;

  UpdateEditOptions();

  FSQL.AddEventNotify(Self);
  FSQL.Session := FSession;

  {re-assign this here - due to timing issues:
   setting the DataOwner enables the descendant classes to
   initialize a list of connection objects, such as TDatabase or TADOConnection, etc.}
  FSession.DataOwner := Owner;

  FSQL.Modified := False;

  UpdateAutoSearchFields;

  UpdateShowAutoSearchDialog;

  if (Report <> nil) and not(Report.Converted) then
    Report.Modified := False;

  {the first time the dataview is made active, regen the SQL}
  FQueryOutOfSync := True;

 {check validity of the datapipelne username}
  if (DataPipelineCount = 1) and ((FSQL.DataPipelineName <> DataPipelines[0].UserName) or
                                  (DataPipelines[0].Name <> DataPipelines[0].UserName)) then
    begin
      {prior to renaming the pipeline, need to allow the report and its
      data aware components to resolve their pipeline references based upon
      pipline name that was saved to the stream.}
      lDataModule := GetDataModule;
      if (lDataModule <> nil) and (lDataModule.Report <> nil) then
        GetDataModule.Report.ResolvePipelineReferences;

      {attempt to set datapipeline to value of FSQL.DataPipeline}
      DataPipelines[0].UserName := FSQL.DataPipelineName;
      DataPipelines[0].Name := DataPipelines[0].UserName;

      {if above attempt failed, then set the FSQL.DataPipelineName to the DataPipeline's UserName value}
      if (DataPipelines[0].UserName <> FSQL.DataPipelineName) then
        begin
         FSQL.DataPipelineName := DataPipelines[0].UserName;
         UpdateUserName;
        end;

    end;

end; {procedure, Loaded}

{*******************************************************************************
 *
 **  A U T O S E A R C H
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.AutoSearchFieldsExist }

function TdaQueryDataView.AutoSearchFieldsExist: Boolean;
begin
  {DataView.AutoSearchFieldsExists is called by DataModule.AutoSearchFieldsExist to
    determine whether any dataviews in the data module have auto search fields}
  Result := FSQL.AutoSearchFieldsExist;
end; {procedure, AutoSearchFieldsExist}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.RemoveAutoSearchFields }

procedure TdaQueryDataView.RemoveAutoSearchFields;
var
  lMainReport: TppReport;
begin

  if (Report = nil) or (csDestroying in Report.ComponentState) then exit

  else
    begin

      lMainReport := TppReport(Report.MainReport);

      if (lMainReport <> nil) then
        begin
          FRemovingAutoSearchFields := True;

          try
            FreeAutoSearchFields(lMainReport);

          finally
            FRemovingAutoSearchFields := False;
          end;

        end;
    end;

end; {procedure, RemoveAutoSearchFields}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.FreeAutoSearchFields }

procedure TdaQueryDataView.FreeAutoSearchFields(aReport: TppReport);
var
  liIndex: Integer;
begin

  for liIndex := FLinkedAutoSearchFields.Count - 1 downto 0  do
    TObject(FLinkedAutoSearchFields[liIndex]).Free;

  FLinkedAutoSearchFields.Clear;

end; {procedure, FreeAutoSearchFields}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.AddAutoSearchFields }

procedure TdaQueryDataView.AddAutoSearchFields;
var
  lMainReport: TppReport;
begin

  if (Report <> nil) then
    begin
      lMainReport := TppReport(Report.MainReport);

      if (lMainReport <> nil) then
        begin
          CreateAutoSearchFields(lMainReport);
          CreateGroupAutoSearchFields(lMainReport);
        end;

    end;

end; {procedure, AddAutoSearchFields}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.AutoSearchFieldChangeEvent }

procedure TdaQueryDataView.AutoSearchFieldChangeEvent(Sender: TObject);
var
  lbReset: Boolean;
  lField: TppAutoSearchField;
  lCriteria: TdaCriteria;
  lFieldOperator: TdaCriteriaOperatorType;
begin
  lbReset := False;

  lField := TppAutoSearchField(Sender);
  lCriteria := TdaCriteria(lField.Criteria);

  if (lCriteria.Field.FieldName <> lField.FieldName) then
    begin
      CreateCriteriaForAutoSearchField(lField);

      lbReset := True;
    end

  else
    begin

      if (lCriteria.Value <> lField.SearchExpression) then
        begin
          lCriteria.Value := lField.SearchExpression;

          lbReset := True;
        end;
  
      lFieldOperator := TdaCriteriaOperatorType(lField.SearchOperator);
  
      if (lCriteria.Operator <> lFieldOperator) then
        begin
          lCriteria.Operator := lFieldOperator;

          lbReset := True;
        end;

      if (lCriteria.Field.ShowAllValues <> lField.ShowAllValues) then
        begin
          lCriteria.Field.ShowAllValues := lField.ShowAllValues;

          lbReset := True;
        end;
  
      if (lCriteria.Field.Mandatory <> lField.Mandatory) then
        begin
          lCriteria.Field.Mandatory := lField.Mandatory;

          lbReset := True;
        end;

      if (lCriteria.Field.AutoSearch <> lField.Enabled) then
        begin
          lCriteria.Field.AutoSearch := lField.Enabled;

          lField.Free;

          lbReset := True;
        end;

    end;

  if (lbReset) then
    begin
      FQueryOutOfSync := True;

      FSQL.Modification;

      Report.Reset;
    end

end; {procedure, AutoSearchFieldChangeEvent}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.CreateAutoSearchFields }

procedure TdaQueryDataView.CreateAutoSearchFields(aReport: TppReport);
var
  liIndex: Integer;
  lCriteria: TdaCriteria;
  lField: TppAutoSearchField;
  lLogicalPrefix: TppLogicalOperatorTypes;
begin

  lLogicalPrefix := [loAnd]; // default

  for liIndex := 0 to FSQL.CriteriaCount - 1 do
    begin
      lCriteria := FSQL.Criteria[liIndex];
      
      if lCriteria.CriteriaType = dacrOR then  // logical Or
        lLogicalPrefix := lLogicalPrefix + [loOr]

      else if lCriteria.CriteriaType = dacrNOT then // logical Not
        lLogicalPrefix := lLogicalPrefix + [loNot] - [loAnd]

      else if (lCriteria.Field <> nil) and not(lCriteria.Field.AutoSearch)  then
        lLogicalPrefix := [] // reset logical prefix, they were used for non-autosearch field

      else if (lCriteria.Field <> nil) and (lCriteria.Field.AutoSearch) and not(lCriteria.ContainsParameter) then
        begin

          // create autosearch field
          lField := CreateAutoSearchFieldForCriteria(lCriteria);
          lField.Parent := aReport;
          lField.LogicalPrefix := lLogicalPrefix;

          lLogicalPrefix := [loAnd]; // reset to default

        end;

    end;

end; {procedure, CreateAutoSearchFields}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.CreateCriteriaForAutoSearchField }

procedure TdaQueryDataView.CreateCriteriaForAutoSearchField(aAutoSearchField: TppAutoSearchField);
var
  lCriteria: TdaCriteria;
  lFields: TStrings;
  lField: TdaField;
  liIndex: Integer;
  lbMandatory: Boolean;
  lbShowAllValues: Boolean;
begin

  {get all available criteria fields}
  lFields := TStringList.Create;

  try
    if (SQL.AvailableCriteriaCount = 0) then
      SQL.Resync;
  
    SQL.AvailableCriteriaList(lFields);
  
    {set string list entries to field names}
    for liIndex := 0 to lFields.Count - 1 do
      begin
        lField := TdaField(lFields.Objects[liIndex]);

        if (lField is TdaCalculation) then
          lFields[liIndex] := TdaCalculation(lField).CalcFieldAlias
        else
          lFields[liIndex] := lField.FieldName
      end;

    {find corresponding field position}
    liIndex := lFields.IndexOf(aAutoSearchField.FieldName);

    if (liIndex <> -1) then
      begin
        lCriteria := SQL.SelectCriteria(liIndex);

        {link the autosearch field object to the criteria object}
        aAutoSearchField.DataView := Self;
        aAutoSearchField.Criteria := lCriteria;

        {assign the search expression and operator to the criteria}
        lCriteria.Value := aAutoSearchField.SearchExpression;
        lCriteria.Operator := TdaCriteriaOperatorType(aAutoSearchField.SearchOperator);

        {save these property values from the autosearch field object}
        lbMandatory := aAutoSearchField.Mandatory;
        lbShowAllValues := aAutoSearchField.ShowAllValues;

        {update the autosearch field with the official information from the SQL object}
        {SQL.daFieldToppField(lCriteria.Field, aAutoSearchField);}

        {restore the autosearch related property values provided by the autosearchs field object}
        lCriteria.Field.AutoSearch := True;
        lCriteria.Field.Mandatory := lbMandatory;
        lCriteria.Field.ShowAllValues := lbShowAllValues;

        {do this last, so that change won't fire during value transfer}
        aAutoSearchField.OnChange := AutoSearchFieldChangeEvent;
      end;
  finally
    lFields.Free;
  end;
  
end; {procedure, CreateCriteriaForAutoSearchField}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.SetSQLObjectDataDictionary }

procedure TdaQueryDataView.SetSQLObjectDataDictionary;
begin

  if (FSQL.DataDictionary = nil) and (Parent is TdaDataModule) then
    FSQL.DataDictionary := TppDataDictionary(TdaDataModule(Parent).GetDataDictionary);

end; {procedure, SetSQLObjectDataDictionary}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.ReportCreateAutoSearchCriteriaEvent }

procedure TdaQueryDataView.ReportCreateAutoSearchCriteriaEvent(aAutoSearchField: TObject);
var
  lppField: TppAutoSearchField;
begin

  SetSQLObjectDataDictionary;

  lppField := TppAutoSearchField(aAutoSearchField);

  if (CompareText(lppField.DataPipelineName, DataPipelines[0].UserName) <> 0) then Exit;

  CreateCriteriaForAutoSearchField(lppField);

  FLinkedAutoSearchFields.Add(lppField);

  lppField.AddNotify(Self);

  FQueryOutOfSync := True;

end; {procedure, ReportCreateAutoSearchCriteriaEvent}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.ReportGetAutoSearchValuesEvent }

procedure TdaQueryDataView.ReportGetAutoSearchValuesEvent;
var
  liIndex: Integer;
  lCriteria: TdaCriteria;
  lField: TppAutoSearchField;
  lbRefresh: Boolean;
begin

  if (Report = nil) then Exit;

  lbRefresh := False;

  for liIndex := 0 to FLinkedAutoSearchFields.Count - 1 do
    begin
      lField := FLinkedAutoSearchFields[liIndex];

      if (lField.DataView = Self) and (lField.Criteria <> nil) then
        begin
          lCriteria := TdaCriteria(lField.Criteria);

          lCriteria.Field.ShowAllValues := lField.ShowAllValues;
          lCriteria.Value := lField.SearchExpression;

          lbRefresh := True;
        end;

    end;

  if lbRefresh then
    begin
      FQueryOutOfSync := True;

      SendEventNotify(Self, ciSQLSearchCriteriaChanged, nil);
    end;

end; {procedure, ReportGetAutoSearchValuesEvent}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.SetAutoSearchTabOrder }

procedure TdaQueryDataView.SetAutoSearchTabOrder(aValue: Integer);
var
  lMainReport: TppReport;
begin

  inherited SetAutoSearchTabOrder(aValue);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (Report <> nil) then
    begin
      lMainReport := TppReport(Report.MainReport);

      if (lMainReport <> nil) then
        lMainReport.Modified := True;
    end;

end; {procedure, SetAutoSearchTabOrder}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.UpdateAutoSearchFields}

procedure TdaQueryDataView.UpdateAutoSearchFields;
begin

  RemoveAutoSearchFields;

  AddAutoSearchFields;

end; {procedure, UpdateAutoSearchFields}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.UpdateShowAutoSearchDialog}

procedure TdaQueryDataView.UpdateShowAutoSearchDialog;
begin
  if (GetDataModule <> nil) then
    GetDataModule.UpdateShowAutoSearchDialog;

end; {procedure, UpdateShowAutoSearchDialog}

{*******************************************************************************
 *
 **  D A T A V I E W   L I N K I N G
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.OutOfSync }

procedure TdaQueryDataView.OutOfSync;
begin

  { called when the data settings change, indicates to the dataview that the
    SQL must be regenerated }

  if Active then
    Active := False;

  FQueryOutOfSync := True;

end; {procedure, OutOfSync}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.Sync }

procedure TdaQueryDataView.Sync;
begin

  { called when the Design workspace is becoming active and the Data workspace
    is becoming inactive. Forces the dataview to update its data access objects
    (usually a TQuery) so that the Design workspace can access the data.}
                                   
  if FQueryOutOfSync then
    RefreshQuery;

end; {procedure, Sync}


{------------------------------------------------------------------------------}
{ TdaQueryDataView.DeleteLink }

procedure TdaQueryDataView.DeleteLink(aIndex: Integer);
var
  lLink: TdaSQLLink;
begin

  lLink := FSQL.Links[aIndex];

  FSQL.FreeLink(lLink);

  if (FSQL.LinkCount = 0) then
    SetMasterDataView(nil)
  else
    MasterDataView.LinkChanged;

  LinkChanged;

  if not(csDestroying in ComponentState) then
    DoOnDeleteLink;

end; {procedure, DeleteLink}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.SetMasterDataView }

procedure TdaQueryDataView.SetMasterDataView(aDataView: TdaDataView);
begin

  if (MasterDataView = aDataView) then Exit;
  

  {notify master dataview that linking has changed}
  if (MasterDataView <> nil) and (MasterDataView <> aDataView) then
    MasterDataView.LinkChanged;

  inherited SetMasterDataView(aDataView);

  {update master data pipeline property of detail data pipeline}
  if (csReading in ComponentState) or (csDestroying in ComponentState) then Exit;

  if MasterDataView <> nil then
    begin
      FMasterDataViewUserName := MasterDataView.UserName;

      FSQL.MasterSQL := MasterQueryDataView.SQL;
    end
  else
    begin
      FMasterDataViewUserName := '';

      FSQL.MasterSQL := nil;

      DataPipeline.MasterDataPipeline := nil;
      DataPipeline.MasterDataSource := nil;
      DataPipeline.FreeLinks;

    end;

  Modification;
  
end; {procedure, SetMasterDataView}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.ClearMasterDataView }

procedure TdaQueryDataView.ClearMasterDataView;
begin

  FClearingMasterDataView := True;

  try
    SetMasterDataView(nil);

    FSQL.ClearSQLLinks;

    LinkChanged;

  finally
    FClearingMasterDataView := False;
  end;

end; {procedure, ClearMasterDataView}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.ValidateLinks }

procedure TdaQueryDataView.ValidateLinks;
begin

  if (MasterDataView = nil) then Exit;

  {check to see if links are still valid, if links are invalid, the links will be freed and the MasterDataView will be set to nil}
  if not(FSQL.ValidateLinks) then
    begin
      if (FSQL.MasterSQL = nil) then
        SetMasterDataView(nil);
        
      DoOnDeleteLink;

    end;

  // always call this to force a refresh of the query
  LinkChanged;

end; {procedure, ValidateLinks}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetMagicFieldCount }

function TdaQueryDataView.GetMagicFieldCount: Integer;
begin
  Result := FSQL.GetMagicFieldCount;
end; {procedure, GetMagicFieldCount}


{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetMagicSQLObject }

procedure TdaQueryDataView.GetMagicSQLObject(var aMagicSQL: TdaSQL);
begin

  {Generate MagicSQL if necessary}
  Sync;

  aMagicSQL := FSQL.GetMagicSQLObject;

end; {procedure, GetMagicSQLObject}


{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetMagicSQL }

procedure TdaQueryDataView.GetMagicSQL(aSQLText: TStrings);
begin
  aSQLText.Assign(FSQL.MagicSQLText);
end; {procedure, GetMagicSQL}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetLinkColorForField }

function TdaQueryDataView.GetLinkColorForField(aFieldName: String): TColor;
var
  lField: TdaField;
begin

  Result := 0;

  if (csDestroying in ComponentState) then Exit;

  lField := FSQL.GetFieldForAlias(aFieldName);

  if (lField <> nil) then
    Result := lField.LinkColor;

end; {function, GetLinkColorForField}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetLinkColor }

function TdaQueryDataView.GetLinkColor: TColor;
begin
  Result := FSQL.LinkColor;
end; {function, GetLinkColor}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.SetLinkColor }

procedure TdaQueryDataView.SetLinkColor(aColor: TColor);
begin
  FSQL.LinkColor := aColor;
end; {function, SetLinkColor}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.IsLinkable }

function TdaQueryDataView.IsLinkable: Boolean;
begin

  Result := True;

end; {function, IsLinkable}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.IsLinkableAsMaster }

function TdaQueryDataView.IsLinkableAsMaster: Boolean;
begin

  Result := True;

end; {function, IsLinkableAsMaster}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.InMasterChain }

function TdaQueryDataView.InMasterChain(aDataView: TdaDataView): Boolean;
begin

  Result := (aDataView = MasterDataView);

  if not(Result) and (MasterDataview <> nil) then
    Result := MasterDataview.InMasterChain(aDataView);

end; {function, InMasterChain}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetMasterQueryDataView }

function TdaQueryDataView.GetMasterQueryDataView: TdaQueryDataView;
begin
  Result := TdaQueryDataView(MasterDataView);
end; {function, GetMasterQueryDataView}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.FixUpMasterDataView }

procedure TdaQueryDataView.FixUpMasterDataView;
var
  lDataModule: TdaDataModule;
  lMasterDataView: TdaDataView;
  liIndex: Integer;
  lsMasterDataViewName: String;
begin

  if (FMasterDataViewUserName = '') then Exit;

  lDataModule := GetDataModule;

  lMasterDataView := nil;
  liIndex := 0;

  {try to find the master dataview - it may have been renamed during loading}
  while (lMasterDataView = nil) and (liIndex < 9) do
    begin
      if liIndex = 0 then
        lsMasterDataViewName := FMasterDataViewUserName
      else
        lsMasterDataViewName := FMasterDataViewUserName + IntToStr(liIndex);

      lMasterDataView := lDataModule.FindDataViewByUserName(lsMasterDataViewName);

      Inc(liIndex);
    end;

  if (lMasterDataView <> nil) then
    SetMasterDataView(lMasterDataView)
  else
    raise EDataError.Create('TdaQueryDataView.FixUpMasterDataView: Could not find master dataview: ' + FMasterDataViewUserName);

end; {procedure, FixUpMasterDataView}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetDescription }

function TdaQueryDataView.GetDescription: String;
begin
  if (FSQL <> nil) then
    Result := FSQL.DataPipelineName
  else
    Result := inherited GetDescription;
end;  {procedure, GetDescription}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetLinkDescription }

function TdaQueryDataView.GetLinkDescription: String;
begin

  if (MasterQueryDataView <> nil) then
    Result := GetDescription + ' ' + ppLoadStr(847) + ' ' +  MasterQueryDataView.GetDescription {'Linked to'}

  else
    Result := GetDescription;

end; {function, GetLinkDescription}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.LinkChanged }

procedure TdaQueryDataView.LinkChanged;
begin

  if (csDestroying in ComponentState) then Exit;

  SetQueryOutOfSync(True);

  DoOnLinkChange;

end; {procedure, LinkChanged}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.Link }

procedure TdaQueryDataView.Link(aLinkableDataViews: TList);
var
  liIndex: Integer;
  lSQLList: TList;
begin

  if (aLinkableDataViews <> nil) then
    begin
      lSQLList := TList.Create;
      try

        for liIndex := 0 to aLinkableDataViews.Count - 1 do
          lSQLList.Add(TdaQueryDataView(aLinkableDataViews[liIndex]).SQL);

        if DisplayLinkDialog(lSQLList) then
          begin

           if (FSQL.MasterSQL = nil) then
             ClearMasterDataView
            else
             SetMasterDataView(TdaQueryDataView(FSQL.MasterSQL.DataView));

          end;

      finally
        lSQLList.Free;
      end;
    end;

end; {procedure, Link}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.DisplayLinkDialog  }

function TdaQueryDataView.DisplayLinkDialog(aSQLObjects: TList): Boolean;
var
  lFormClass: TFormClass;
  lLinkDialog: TdaCustomLinkDataViewDialog;
begin

  lFormClass := ppGetFormClass(TdaCustomLinkDataViewDialog);

  lLinkDialog := TdaCustomLinkDataViewDialog(lFormClass.Create(Self));
  lLinkDialog.SetDetailSQL(SQL);

  lLinkDialog.AddSQLObjects(aSQLObjects);

  try
    Result := lLinkDialog.Execute;

    if Result then
      LinkChanged;

  finally
    lLinkDialog.Free;
  end;

end; {function, DisplayLinkDialog}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetLinkCount }

function TdaQueryDataView.GetLinkCount: Integer;
begin
  Result := FSQL.LinkCount;
end; {function, GetLinkCount}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetLinkFieldNames }

procedure TdaQueryDataView.GetLinkFieldNames(aIndex: Integer; var aMasterSQLFieldName, aDetailSQLFieldName: String);
var
  lLink: TdaSQLLink;
begin

  lLink := FSQL.Links[aIndex];

  aMasterSQLFieldName := lLink.MasterField.SQLFieldName;
  aDetailSQLFieldName := lLink.DetailField.SQLFieldName;

end; {procedure, GetLinkFieldNames}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.CreateLinkObject }

procedure TdaQueryDataView.CreateLinkObject(aMasterDataView: TdaDataView; const aMasterFieldAlias, aDetailFieldAlias: String);
var
  lMasterField: TdaField;
  lDetailField: TdaField;
  lsOldMasterSQLFieldName: String;
  lsOldDetailSQLFieldName: String;
begin

  lMasterField := FSQL.MasterSQL.GetFieldForAlias(aMasterFieldAlias);
  lDetailField := FSQL.GetFieldForAlias(aDetailFieldAlias);

  lsOldMasterSQLFieldName := lMasterField.SQLFieldName;
  lsOldDetailSQLFieldName := lDetailField.SQLFieldName;

  FSQL.CreateLink(lMasterField, lDetailField);

  {if AutoLinking, aMasterDataView may be nil}
  if (aMasterDataView <> nil) then
    begin
      aMasterDataView.OutOfSync;
      TdaQueryDataView(aMasterDataView).UpdatePipelineFieldName(lsOldMasterSQLFieldName, lMasterField.SQLFieldName);
    end;
    
  UpdatePipelineFieldName(lsOldDetailSQLFieldName, lDetailField.SQLFieldName);

  if (aMasterDataView <> nil) then
    aMasterDataView.LinkChanged;

end; {procedure, CreateLinkObject}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.CreateLink }

procedure TdaQueryDataView.CreateLink(aMasterDataView: TdaDataView; aMasterFieldAlias, aDetailFieldAlias: String);
begin

  if (aMasterDataView = nil) or (aMasterFieldAlias = '') or (aDetailFieldAlias = '') or
     (aMasterDataView = Self) or (aMasterDataView.InMasterChain(Self)) then Exit;

  FSQL.ClearSQLLinks;

  SetMasterDataView(aMasterDataView);

  CreateLinkObject(aMasterDataView, aMasterFieldAlias, aDetailFieldAlias);

  LinkChanged;

end; {procedure, CreateLink}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.CreateAutoLink }

function TdaQueryDataView.CreateAutoLink(aLinkableDataViews: TList; aDataDictionary: TObject): Boolean;
var
  lDataDictionary: TppDataDictionary;
  lDataView: TdaQueryDataView;
  liIndex: Integer;
  lLinkedDataViews: TList;
begin

  Result := False;

  {called when the data view is first created, allows the data view to search
   for automatic link possibilities with other dataviews using the Data
   Dictionary }
  
  lDataDictionary := TppDataDictionary(aDataDictionary);
  
  if (lDataDictionary = nil) or not(lDataDictionary.AutoJoin) then Exit;

  lLinkedDataViews := TList.Create;

  for liIndex := 0 to aLinkableDataViews.Count - 1 do
    begin
      lDataView := TdaQueryDataView(aLinkableDataViews[liIndex]);

      {Don't involve dataviews with more than one table in AutoJoining}
      if (lDataView.SQL.SelectTableCount = 1) then
        begin
          {attempt to link to this dataview as a detail, if successful, add this dataview to the 'linked' list}
          if (MasterDataView = nil) and GetAutoLinks(lDataView, lDataDictionary) then
            lLinkedDataViews.Add(lDataView)

          {attempt to link to this dataview as a master, if successful, add this dataview to the 'linked' list }
          else if (lDataView.MasterDataView = nil) and lDataView.GetAutoLinks(Self, lDataDictionary) then
            lLinkedDataViews.Add(lDataView);

        end;

    end;

  {transfer the newly linked dataviews into the LinkableDataViews parameter}
  aLinkableDataViews.Clear;
  
  for liIndex := 0 to lLinkedDataViews.Count - 1 do
    begin
      if (liIndex = 0) then
        aLinkableDataViews.Add(Self);

      aLinkableDataViews.Add(lLinkedDataViews[liIndex]);
    end;

  Result := (lLinkedDataViews.Count <> 0);

  lLinkedDataViews.Free;

end; {function, CreateAutoLink}

function TdaQueryDataView.CreateAutoSearchFieldForCriteria(aCriteria: TdaCriteria): TppAutoSearchField;
var
  lSelectField: TdaField;
  lField: TppAutoSearchField;
begin

  // create autosearch field
  lField := TppAutoSearchField.Create(Self);

  // find corresponding select or calc field
  lSelectField := aCriteria.GetCorrespondingSelectField;


  if (lSelectField <> nil) then
    lField.FieldAlias := lSelectField.Alias // use corresponding select field alias
  else if (aCriteria.IsExpression) then
    lField.FieldAlias := aCriteria.Expression // use expression typed in by the user
  else
    lField.FieldAlias := aCriteria.Field.Alias;

  lField.DataPipelineName := GetDataPipelineForIndex(0).Name;
  lField.FieldName := aCriteria.Field.FieldName;
  lField.DataType := aCriteria.Field.DataType;
  lField.SearchOperator := TppSearchOperatorType(aCriteria.Operator);
  lField.SearchExpression := aCriteria.Value;
  lField.ShowAllValues := aCriteria.Field.ShowAllValues;
  lField.Mandatory := aCriteria.Field.Mandatory;
  lField.TableAlias := aCriteria.Field.TableAlias;
  lField.TableName := aCriteria.Field.TableName;

  // for AutoSearch, use dtDate when date but no time specified
  if (lField.DataType = dtDateTime) and (lField.SearchExpression <> '') then
    if Frac(lField.Value) = 0 then
      lField.DataType := dtDate;


  {save a pointer to the corresponding criteria and dataview}
  lField.Criteria := aCriteria;
  lField.DataView := Self;
  lField.OnChange := AutoSearchFieldChangeEvent;

  {establish a free notification relationship}
  FLinkedAutoSearchFields.Add(lField);
  lField.AddNotify(Self);

  Result := lField;

end;

procedure TdaQueryDataView.CreateGroupAutoSearchFields(aReport: TppReport);
var
  liIndex: Integer;
  lCriteria: TdaCriteria;
  lField: TppAutoSearchField;
  lLogicalPrefix: TppLogicalOperatorTypes;
begin

  lLogicalPrefix := [loAnd]; // default

  for liIndex := 0 to FSQL.GroupCriteriaCount - 1 do
    begin
      lCriteria := FSQL.GroupCriteria[liIndex];

      if lCriteria.CriteriaType = dacrOR then  // logical Or
        lLogicalPrefix := lLogicalPrefix + [loOr]

      else if lCriteria.CriteriaType = dacrNOT then // logical Not
        lLogicalPrefix := lLogicalPrefix + [loNot] - [loAnd]

      else if (lCriteria.Field <> nil) and not(lCriteria.Field.AutoSearch) then
        lLogicalPrefix := [] // reset logical prefix, they were used for non-autosearch field

      else if (lCriteria.Field <> nil) and (lCriteria.Field.AutoSearch) then
        begin

          // create autosearch field
          lField := CreateAutoSearchFieldForCriteria(lCriteria);
          lField.Parent := aReport;
          lField.LogicalPrefix := lLogicalPrefix;

          lLogicalPrefix := [loAnd]; // reset to default

        end;

    end;
end;

{------------------------------------------------------------------------------}
{ TdaQueryDataView.CreatePipelineLinksForParameterizedSQL }

procedure TdaQueryDataView.CreatePipelineLinksForParameterizedSQL(aDataPipeline: TppDataPipeline);
begin

  if (aDataPipeline = nil) then
    raise EDataError.Create('TdaQueryDataView.CreatePipelineLinksForParameterizedSQL: Could not create links, aDataPipeline is nil.');

  if (aDataPipeline.MasterDataPipeline = nil) then
    raise EDataError.Create('TdaQueryDataView.CreatePipelineLinksForParameterizedSQL: Could not create links, aMasterPipeline is nil.');

  // for parameterized linking - link detail to the master datasource
  if (aDataPipeline is TppDBPipeline) and (aDataPipeline.MasterDataPipeline is TppDBPipeline) then
    TppDBPipeline(aDataPipeline).MasterDataSource := TppDBPipeline(aDataPipeline.MasterDataPipeline).DataSource;

end;

{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetAutoLinks }

function TdaQueryDataView.GetAutoLinks(aMasterDataView: TdaQueryDataView; aDataDictionary: TppDataDictionary): Boolean;
var
  lMasterSQL: TdaSQL;
  liIndex: Integer;
  liIndex2: Integer;
  liIndex3: Integer;
  lsJoinType: String;
  lMasterFieldNames: TStrings;
  lDetailFieldNames: TStrings;
  lOperators: TStrings;
  lsMasterFieldName: String;
  lsDetailFieldName: String;
  lJoinType: TdaJoinType;
  lsMasterTableName: String;
  lsDetailTableName: String;
  lMasterField: TdaField;
  lDetailField: TdaField;
  lbAllFieldsFound: Boolean;
begin

  Result := False;

  lMasterSQL := aMasterDataView.SQL;

  lMasterFieldNames := TStringList.Create;
  lDetailFieldNames := TStringList.Create;
  lOperators := TStringList.Create;
  lsJoinType := '';

  liIndex := 0;

  while not(Result) and (liIndex < lMasterSQL.SelectTableCount) do
    begin
      lsMasterTableName := lMasterSQL.SelectTables[liIndex].RawTableName;

      liIndex2 := 0;

      while not(Result) and (liIndex2 < SQL.SelectTableCount) do
        begin
          lsDetailTableName := SQL.SelectTables[liIndex2].RawTableName;

          lMasterFieldNames.Clear;
          lDetailFieldNames.Clear;
          lOperators.Clear;
          lsJoinType := '';

          {if we have not found a master, try to make the current dataview our master}
          if aDataDictionary.GetLinkData(lsMasterTableName, lsDetailTableName, lsJoinType, lMasterFieldNames, lDetailFieldNames, lOperators) then
            begin
              {make sure all fields needed for linking are in the queries}
              liIndex3 := 0;
              lbAllFieldsFound := True;

              while (lbAllFieldsFound) and (liIndex3 < lMasterFieldNames.Count) do
                begin
                  lsMasterFieldName := lMasterFieldNames[liIndex3];
                  lsDetailFieldName := lDetailFieldNames[liIndex3];

                  lMasterField := aMasterDataView.SQL.GetFieldForFieldName(lsMasterFieldName);
                  lDetailField := SQL.GetFieldForFieldName(lsDetailFieldName);

                  if (lMasterField = nil) or (lDetailField = nil) then
                    lbAllFieldsFound := False
                  else
                    begin
                      lMasterFieldNames[liIndex3] := lMasterField.FieldAlias;
                      lDetailFieldNames[liIndex3] := lDetailField.FieldAlias;

                      Inc(liIndex3);
                    end;
                end;

              {link the dataviews}
              if (lbAllFieldsFound) then
                begin
                  Result := True;

                  lJoinType := TdaJoinType(ppGetEnumValue(TypeInfo(TdaJoinType), lsJoinType));

                  if (lJoinType = dajtInner) then
                    DataPipelines[0].SkipWhenNoRecords := True
                  else
                    DataPipelines[0].SkipWhenNoRecords := False;

                  FSQL.MasterSQL := lMasterSQL;
                  
                  for liIndex3 := 0 to lMasterFieldNames.Count - 1 do
                    begin
                      lsMasterFieldName := lMasterFieldNames[liIndex3];
                      lsDetailFieldName := lDetailFieldNames[liIndex3];

                      CreateLinkObject(MasterDataView, lsMasterFieldName, lsDetailFieldName);
                    end;
                end;

            end;

          Inc(liIndex2);

        end; {while, each detail table}

      Inc(liIndex);

    end; {while, each master table}

  lMasterFieldNames.Free;
  lDetailFieldNames.Free;
  lOperators.Free;

  {update master dataview, notify any children}
  if (Result) then
    begin
      SetMasterDataView(aMasterDataView);

      LinkChanged;
    end;

end; {function, GetAutoLinks}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.UpdateEditOptions }

procedure TdaQueryDataView.UpdateEditOptions;
begin

  if FSQL.EditSQLAsText then
    EnabledOptions := [ppemText, ppemPreview];

  if IsLinkable then
    EnabledOptions := EnabledOptions + [ppemLink]
  else
    EnabledOptions := EnabledOptions - [ppemLink];

end; {procedure, UpdateEditOptions}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.UpdateEnabledOptions }

procedure TdaQueryDataView.UpdateEnabledOptions(aLinkableDataViews: TList);
var
  lbLinkableDataViewsFound: Boolean;
  liIndex: Integer;
  lDataView: TdaQueryDataView;
begin

  lbLinkableDataViewsFound := False;
  liIndex := 0;

  while not(lbLinkableDataViewsFound) and (liIndex < aLinkableDataViews.Count) do
    begin
      lDataView := TdaQueryDataView(aLinkableDataViews[liIndex]);

      if (lDataView <> Self) and lDataView.IsLinkable and not(lDataView.InMasterChain(Self)) then
        lbLinkableDataViewsFound := True
      else
        Inc(liIndex);
    end;

  if (lbLinkableDataViewsFound) and IsLinkable then
    EnabledOptions := EnabledOptions + [ppemLink]
  else
    EnabledOptions := EnabledOptions - [ppemLink];

end; {procedure, UpdateEditOptions}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.UpdateLinkColors }

procedure TdaQueryDataView.UpdateLinkColors(aUpdateUpward: Boolean);
var
  lDataViews: TList;
  liIndex: Integer;
  lDataView: TdaDataView;
begin

  FSQL.FixupLinkColors;

  {Call Master's FixupLinkColors}
  if (aUpdateUpward) then
    begin
      if (MasterQueryDataView <> nil) then
        MasterQueryDataView.SQL.FixUpLinkColors;
    end

  {Call childrens' FixupLinkColors}
  else
    begin
      lDataViews := TList.Create;

      try
        GetDataModule.GetLinkableDataViews(lDataViews);

        for liIndex := 0 to lDataViews.Count - 1 do
          begin
            lDataView := TdaDataView(lDataViews[liIndex]);

            if (lDataView is TdaQueryDataView) and (TdaQueryDataView(lDataView).InMasterChain(Self)) then
              TdaQueryDataView(lDataView).SQL.FixupLinkColors;
          end;
      finally
        lDataViews.Free;
      end;
    end;

end; {procedure, UpdateLinkColors}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.UpdatePipelineFieldName }

procedure TdaQueryDataView.UpdatePipelineFieldName(const aOldSQLFieldName, aNewSQLFieldName: String);
var
  lDataPipeline: TppDataPipeline;
  liIndex: Integer;
  lbFound: Boolean;
begin

  lDataPipeline := DataPipelines[0];

  if (lDataPipeline <> nil) then
    begin
      lbFound := False;
      liIndex := 0;

      while not(lbFound) and (liIndex < lDataPipeline.FieldCount) do
        if (ppEqual(aOldSQLFieldName, lDataPipeline.Fields[liIndex].FieldName)) then
          begin
            lDataPipeline.Fields[liIndex].FieldName := aNewSQLFieldName;
            lbFound := True;
          end
        else
          Inc(liIndex);

    end;

end; {procedure, UpdatePipelineFieldName}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.CreatePipelineLinksForMagicSQL }

procedure TdaQueryDataView.CreatePipelineLinksForMagicSQL(aDataPipeline: TppDataPipeline);
var
  liIndex: Integer;
  lLink: TppMasterFieldLink;
  lsMasterFieldName: String;
  lsDetailFieldName: String;
  lbDetailAscending: Boolean;
  lSQL: TdaSQL;
begin

  if (aDataPipeline = nil) then
    raise EDataError.Create('TdaQueryDataView.CreatePipelineLinksForMagicSQL: Could not create links, no data pipeline found.');

  lSQL := GetSQL;

  // create a Pipeline for each SQL.MagicLinks
  for liIndex := 0 to lSQL.MagicLinkCount - 1 do
    begin
      lsMasterFieldName := '';
      lsDetailFieldName := '';
      lbDetailAscending := True;

      if lSQL.GetMagicLinkFieldNames(liIndex, lsMasterFieldName, lsDetailFieldName, lbDetailAscending) then
        begin
          lLink := TppMasterFieldLink.Create(Self);

          lLink.MasterFieldName := lsMasterFieldName;
          lLink.DetailFieldName := lsDetailFieldName;
          lLink.IsCaseSensitive := lSQL.IsCaseSensitive;
          lLink.CollationType   := lSQL.CollationType;
          lLink.GuidCollationType := lSQL.GuidCollationType;
          lLink.NullCollationType := lSQL.NullCollationType;

          if (lbDetailAscending) then
            lLink.DetailSortOrder := soAscending
          else
            lLink.DetailSortOrder := soDescending;

          lLink.Parent := aDataPipeline;
        end;
    end;

end; {procedure, CreatePipelineLinks}

{------------------------------------------------------------------------------}
{ TdaQueryDataView.CreatePipelineLinksForManualSQL }

procedure TdaQueryDataView.CreatePipelineLinksForManualSQL(aDataPipeline: TppDataPipeline);
var
  liIndex: Integer;
  lPipelineLink: TppMasterFieldLink;
  lSQL: TdaSQL;
  lSQLLink: TdaSQLLink;
begin

  if (aDataPipeline = nil) then
    raise EDataError.Create('TdaQueryDataView.CreatePipelineLinksForManualSQL: Could not create links, no data pipeline found.');

  lSQL := GetSQL;

  // create a pipeline link corresponding to each SQLLink
  for liIndex := 0 to lSQL.LinkCount - 1 do
    begin
      lSQLLink := lSQL.Links[liIndex];

      lPipelineLink := TppMasterFieldLink.Create(Self);

      lPipelineLink.MasterFieldName := lSQLLink.MasterField.SQLFieldName;
      lPipelineLink.DetailFieldName := lSQLLink.DetailField.SQLFieldName;
      lPipelineLink.IsCaseSensitive := lSQL.IsCaseSensitive;
      lPipelineLink.CollationType   := lSQL.CollationType;
      lPipelineLink.GuidCollationType := lSQL.GuidCollationType;
      lPipelineLink.NullCollationType := lSQL.NullCollationType;

    // TODO
//      if (lSQLLink.Ascending) then
//        lPipelineLink.DetailSortOrder := soAscending
//      else
//        lPipelineLink.DetailSortOrder := soDescending;

      lPipelineLink.Parent := aDataPipeline;
    end;

end; {procedure, CreatePipelineLinksForMagicSQL}

procedure TdaQueryDataView.DoParamValueChanged(aParameter: TppParameter);
var
  lParamNames: TStringList;
begin
  lParamNames := TStringList.Create;

  GetSQL.GetSQLParamNames(lParamNames);

  if ((lParamNames.IndexOf(aParameter.UserName) >= 0) or
      (lParamNames.IndexOf(aParameter.Name) >= 0)) then
      FQueryOutOfSync := True;

  lParamNames.Free;
  
end;

{------------------------------------------------------------------------------}
{ TdaQueryDataView.GetDataPipeline }

function TdaQueryDataView.GetDataPipeline: TppDBPipeline;
begin

  if (DataPipelineCount = 0) then
    raise EDataError.Create('TdaQueryDataView.GetDataPipeline: DataPipelineCount = 0.')
  else if not(DataPipelines[0] is TppDBPipeline) then
    raise EDataError.Create('TdaQueryDataView.GetDataPipeline: DataPipelines[0] must be of type TppDBPipeline.')
  else
    Result := TppDBPipeline(DataPipelines[0]);


end;






end.
