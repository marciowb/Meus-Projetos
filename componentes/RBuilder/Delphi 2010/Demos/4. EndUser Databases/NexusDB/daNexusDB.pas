unit daNexusDB;

interface

{$I nxDefine.inc}
{$I ppIfDef.pas}

uses
  Classes,
  SysUtils,
  Forms,
  ExtCtrls,
  DB,
  ppClass,
  ppComm,
  ppDBPipe,
  ppDB,
  ppClasUt,
  ppTypes,
  daDB,
  daQueryDataView,
  daDataView,
  daPreviewDataDlg,
  nxSqlBase,
  nxllComponent,
  nxdb,
  nxdbDatabaseMapper;

type
  TdaChildNxQuery = class(TnxQuery)
  public
    function HasParent: Boolean; override;
  end;

  TdaChildNxTable = class(TnxTable)
  public
    function HasParent: Boolean; override;
  end;

  TdanxSession = class(TdaSession)
  protected
    function IsNamedDatabase(const aDatabaseName: string; aDatabase: TComponent): Boolean; override;
  public
    class function ClassDescription: string; override;
    class function DataSetClass: TdaDataSetClass; override;
    class function DatabaseClass: TComponentClass; override;

    function DefaultSQLType(aDatabaseType: TppDatabaseType): TppSQLType; override;
    procedure GetDatabaseNames(aList: TStrings); override;
    function GetDatabaseForName(const aName: String): TComponent; override;
    function GetDatabaseType(const aDatabaseName: string): TppDatabaseType; override;
    procedure GetTableNames(const aDatabaseName: string; aList: TStrings); override;
    function IsSQLReservedWord(const aString: String; aDatabaseType: TppDatabaseType): Boolean; override;
    function ContainsSQLFunctionCall(const aString: string; aDatabaseType: TppDatabaseType): Boolean; override;
    function ValidDatabaseTypes: TppDatabaseTypes; override;

    function GetSearchCriteriaDateFormat(aDatabaseType: TppDatabaseType; const aDatabaseName: string): string; override;
    function GetSearchCriteriaTimeFormat(aDatabaseType: TppDatabaseType; const aDatabaseName: string): string; override;
  end;

  TdanxDataSet = class(TdaDataSet)
  protected {private}
    dsQuery: TnxQuery;
    dsDatabase: TnxDatabase;

    function dsGetQuery: TnxQuery;
  protected
    procedure BuildFieldList; override;
    function GetActive: Boolean; override;
    procedure SetActive(Value: Boolean); override;
    procedure SetDatabase(aDatabase: TComponent); override;
    procedure SetDataName(const aDataName: string); override;

    property Query: TnxQuery
      read dsGetQuery;
  public
    destructor Destroy; override;

    class function ClassDescription: string; override;

    procedure GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings); override;
    procedure GetFieldsForSQL(aList: TList; aSQL: TStrings); override;
  end;

  TdanxQueryDataView = class(TdaQueryDataView)
  protected {private}
    qdvDataSource: TppChildDataSource;
    qdvQuery: TdaChildNxQuery;

  protected
    procedure SQLChanged; override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    class function PreviewFormClass: TFormClass; override;
    class function SessionClass: TClass; override;

    procedure Init; override;
    procedure ConnectPipelinesToData; override;

  published
    property DataSource: TppChildDataSource read qdvDataSource;
  end;

  procedure Register;

implementation

uses
  {$IFDEF DCC6OrLater}
  RTLConsts,
  {$ELSE}
  Consts,
  {$ENDIF}
  nxllBde;

var
  // Add functions here that you do not ReportBuilder to Format.
  // Some are already handled by ReportBuilder in daSQLReservedWords.pas
  NexusDBFunctions : array[0..3] of string = (
    'CURRENT_USER',
    'LOCALTIME',
    'LOCALTIMESTAMP',
    'SESSION_USER');


{===Register===================================================================}
procedure Register;
begin
  {NexusDB DataAccess Components}
  RegisterNoIcon([TdaChildNxQuery, TdaChildNxTable]);

  {NexusDB DataViews}
  RegisterNoIcon([TdanxQueryDataView]);
end;
{==============================================================================}



{===TdaChildNxQuery============================================================}
function TdaChildNxQuery.HasParent: Boolean;
begin
  Result := True;
end;
{==============================================================================}



{===TdaChildNxTable============================================================}
function TdaChildNxTable.HasParent: Boolean;
begin
  Result := True;
end;
{==============================================================================}



{===TdanxSession===============================================================}
class function TdanxSession.ClassDescription: string;
begin
  Result := 'NexusDBSession';
end;
{------------------------------------------------------------------------------}
class function TdanxSession.DataSetClass: TdaDataSetClass;
begin
  Result := TdanxDataSet;
end;
{------------------------------------------------------------------------------}
class function TdanxSession.DatabaseClass: TComponentClass;
begin
  Result := TnxDatabase;
end;
{------------------------------------------------------------------------------}
function TdanxSession.DefaultSQLType(aDatabaseType: TppDatabaseType): TppSQLType;
begin
  Result := sqSQL1;
end;
{------------------------------------------------------------------------------}
function TdanxSession.GetDatabaseForName(const aName: String): TComponent;
var
  i: Integer;
begin
  Result := nil;

  if Assigned(DataOwner) then
    for i := 0 to Pred(DataOwner.ComponentCount) do
      if DataOwner.Components[i] is TnxDatabaseMapper then begin
        Result := TnxDatabaseMapper(DataOwner.Components[i]).
          GetDatabaseForName(aName);
        break;
      end;

  if not Assigned(Result) then
    raise EDataError.Create('TdanxSession.GetDatabaseForName: No ' +
      DatabaseClass.ClassName + ' object found for specified name, ' + aName + '.');
end;
{------------------------------------------------------------------------------}
procedure TdanxSession.GetDatabaseNames(aList: TStrings);
var
  i : Integer;
begin
  aList.BeginUpdate;
  try
    aList.Clear;
    if Assigned(DataOwner) then
      for i := 0 to Pred(DataOwner.ComponentCount) do
        if DataOwner.Components[i] is TnxDatabaseMapper then begin
          TnxDatabaseMapper(DataOwner.Components[i]).
            GetDatabaseNames(aList);
          break;
        end;
  finally
    aList.EndUpdate;
  end;
end;
{------------------------------------------------------------------------------}
function TdanxSession.GetDatabaseType(const aDatabaseName: string): TppDatabaseType;
begin
  Result := dtNexusDB;
end;
{------------------------------------------------------------------------------}
function TdanxSession.GetSearchCriteriaDateFormat(aDatabaseType: TppDatabaseType; const aDatabaseName: string): string;
begin
  {return a format usable by FormatDate}
  Result := 'YYYY-MM-DD';
end;
{------------------------------------------------------------------------------}
function TdanxSession.GetSearchCriteriaTimeFormat(aDatabaseType: TppDatabaseType; const aDatabaseName: string): string;
begin
  {return a format usable by FormatDateTime}
  Result := 'HH:NN:SS.ZZZ';
end;
{------------------------------------------------------------------------------}
procedure TdanxSession.GetTableNames(const aDatabaseName: string; aList: TStrings);
var
  lDatabase: TnxDatabase;
{$IFDEF NEXUS2}
  lQuery: TnxQuery;
 {$ENDIF}
begin

  {get the database}
  lDatabase := TnxDatabase(GetDatabaseForName(aDatabaseName));

  {Database must be active to get table names}
  lDatabase.Connected := True;

  {get list of table names from a table object}
  if lDatabase.Connected then
    lDatabase.GetTableNames(aList);

 {$IFDEF NEXUS2}
  {get list of view names from a query object}
  if (lDatabase.Connected) and not(lDatabase.ReadOnly) then
    begin
      {create a temporary NexusDB query}
      lQuery := TnxQuery.Create(nil);

      try
        {assign databae and SQL properties}
        lQuery.Database := lDatabase;
        lQuery.SQL.Text := 'select VIEW_NAME from #views';

        {set query to active}
        lQuery.Active := True;
        lQuery.First;

        {append the view name to the list of tables}
        while not(lQuery.EOF) do
         begin
            aList.Add(lQuery.Fields[0].AsString);
            lQuery.Next;
         end;

      finally
        lQuery.Free;
      end;

    end;
{$ENDIF}


end;
{------------------------------------------------------------------------------}
function TdanxSession.IsSQLReservedWord(const aString: String; aDatabaseType: TppDatabaseType): Boolean;
begin
  result:=IsReservedName(aString);
end;
{------------------------------------------------------------------------------}
function TdanxSession.IsNamedDatabase(const aDatabaseName: string; aDatabase: TComponent): Boolean;
begin
  Result := False;
  { This function is only called from TdaSession.GetDatabaseForName.
    As we are not calling inherited in our implementation of GetDatabaseForName
    we don't need to implement it. }
end;
{------------------------------------------------------------------------------}
function TdanxSession.ValidDatabaseTypes: TppDatabaseTypes;
begin
  Result := [dtNexusDB];
end;
{==============================================================================}



{===TdanxDataSet===============================================================}
procedure TdanxDataSet.BuildFieldList;
var
  liIndex                     : Integer;
  lField                      : TppField;
begin
  inherited;

  {set table to active}
  Active := True;

  {create TppField objects for each field in the table}
  for liIndex := 0 to Pred(dsQuery.FieldCount) do
    with dsQuery.Fields[liIndex] do begin
      lField := TppField.Create(nil);

      lField.TableName := DataName;
      lField.FieldName := FieldName;
      lField.FieldAlias := DisplayLabel;
      lField.FieldLength := Size;
      lField.DataType := ppConvertFieldType(DataType);
      lField.DisplayWidth := DisplayWidth;

      AddField(lField);
    end;
end;
{------------------------------------------------------------------------------}
destructor TdanxDataSet.Destroy;
begin
  FreeAndNil(dsQuery);
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
class function TdanxDataSet.ClassDescription: string;
begin
  Result := 'NexusDBDataSet';
end;
{------------------------------------------------------------------------------}
function TdanxDataSet.dsGetQuery: TnxQuery;
begin
  {create NexusDB table, if needed}
  if not Assigned(dsQuery) then begin
    dsQuery := TdaChildNxQuery.Create(Self);
    dsQuery.Database := dsDatabase;
  end;

  Result := dsQuery;
end;
{------------------------------------------------------------------------------}
function TdanxDataSet.GetActive: Boolean;
begin
  Result := Assigned(dsQuery) and dsQuery.Active;
end;
{------------------------------------------------------------------------------}
procedure TdanxDataSet.GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings);
var
  lQuery                      : TnxQuery;
begin
  aList.Clear;

  {create a temporary NexusDB query}
  lQuery := TnxQuery.Create(Self);
  try
    {set the database and SQL properties}
    lQuery.Database := dsDatabase;
    lQuery.SQL := aSQL;

    {get the field names}
    lQuery.GetFieldNames(aList);
  finally
    lQuery.Free;
  end;
end;
{------------------------------------------------------------------------------}
procedure TdanxDataSet.GetFieldsForSQL(aList: TList; aSQL: TStrings);
var
  lQuery                      : TnxQuery;
  lField                      : TppField;
  liIndex                     : Integer;
begin
  aList.Clear;

  {create a temporary NexusDB query}
  lQuery := TnxQuery.Create(Self);
  try
    {assign databae and SQL properties}
    lQuery.Database := dsDatabase;
    lQuery.SQL := aSQL;

    {set query to active}
    lQuery.Active := True;

    {create a TppField object for each field in the query}
    for liIndex := 0 to Pred(lQuery.FieldCount) do
      with lQuery.Fields[liIndex] do begin
        lField := TppField.Create(nil);
        try
          lField.FieldName := FieldName;
          lField.FieldAlias := DisplayLabel;
          lField.FieldLength := Size;
          lField.DataType := ppConvertFieldType(DataType);
          lField.DisplayWidth := DisplayWidth;

          aList.Add(lField);
        except
          FreeAndNil(lField);
          raise;
        end;
      end;
  finally
    lQuery.Free;
  end;
end;
{------------------------------------------------------------------------------}
procedure TdanxDataSet.SetActive(Value: Boolean);
begin
  if Value <> Active then
    Query.Active := Value;
end;
{------------------------------------------------------------------------------}
procedure TdanxDataSet.SetDatabase(aDatabase: TComponent);
begin
  inherited SetDatabase(aDatabase);

  {table cannot be active to set database property}
  Active := False;

  dsDatabase := TnxDatabase(aDatabase);

  {set NexusDBQuery.Connection}
  if Assigned(dsQuery) then
    dsQuery.Database := dsDatabase;
end;
{------------------------------------------------------------------------------}
procedure TdanxDataSet.SetDataName(const aDataName: string);
begin
  inherited SetDataName(aDataName);

  {dataset cannot be active to set data name}
  if Query.Active then
    dsQuery.Active := False;

  {construct an SQL statment that returns an empty result set,
   this is used to get the field information }
  dsQuery.SQL.Text := 'SELECT * FROM ' + aDataName +
    ' WHERE ''c'' <> ''c'' ';
end;
{==============================================================================}



{===TdanxQueryDataView=========================================================}
procedure TdanxQueryDataView.ConnectPipelinesToData;
begin
  if DataPipelineCount = 0 then Exit;

  {need to reconnect here}
  TppDBPipeline(DataPipelines[0]).DataSource := qdvDataSource;
end;
{------------------------------------------------------------------------------}
constructor TdanxQueryDataView.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  {notes: 1. must use ChildQuery, ChildDataSource, ChildPipeline etc.
          2. use Self as owner for Query, DataSource etc.
          3. do NOT assign a Name }

  qdvQuery := TdaChildNxQuery.Create(Self);

  qdvDataSource := TppChildDataSource.Create(Self);
  qdvDataSource.DataSet := qdvQuery;
end;
{------------------------------------------------------------------------------}
destructor TdanxQueryDataView.Destroy;
begin
  FreeAndNil(qdvDataSource);
  FreeAndNil(qdvQuery);

  inherited Destroy;
end;
{------------------------------------------------------------------------------}
class function TdanxQueryDataView.SessionClass: TClass;
begin
  Result := TdanxSession;
end;
{------------------------------------------------------------------------------}
class function TdanxQueryDataView.PreviewFormClass: TFormClass;
begin
  Result := TFormClass(GetClass('TdaPreviewDataDialog'));
end;
{------------------------------------------------------------------------------}
procedure TdanxQueryDataView.Init;
var
  lDataPipeline               : TppChildDBPipeline;
begin
  inherited;

  if DataPipelineCount > 0 then
    Exit;

  {note: DataView's owner must own the DataPipeline }
  lDataPipeline := TppChildDBPipeline(ppComponentCreate(Self, TppChildDBPipeline));
  lDataPipeline.DataSource := qdvDataSource;

  lDataPipeline.AutoCreateFields := False;

  {add DataPipeline to the dataview }
  lDataPipeline.DataView := Self;
end;
{------------------------------------------------------------------------------}
procedure TdanxQueryDataView.SQLChanged;
var
  lDatabase                   : TComponent;
begin
  if qdvQuery.Active then
    qdvQuery.Close;

  lDatabase := Session.GetDatabaseForName(SQL.DatabaseName);

  if (lDatabase = nil) then
    raise EDataError('TdanxQueryDataView.SQLChanged: No NexusDBConnection object found, ' + SQL.DatabaseName);

  qdvQuery.Database := TnxDatabase(lDatabase);
  qdvQuery.SQL := SQL.MagicSQLText;
end;
{==============================================================================}

function TdanxSession.ContainsSQLFunctionCall(const aString: string; aDatabaseType: TppDatabaseType): Boolean;
var
  i: Integer;
  lString: string;
begin
  Result := inherited ContainsSQLFunctionCall(aString, aDatabaseType);
  if not Result then begin
    lString := UpperCase(aString);
    for i := Low(NexusDBFunctions) to High(NexusDBFunctions) do begin
      if NexusDBFunctions[i] = lString then
        begin
          Result := True;
          Exit;
        end;
    end;
  end;
end;

initialization
  {register the NexusDB descendant classes}
  RegisterClasses([TdaChildNxQuery, TdaChildNxTable]);

  {register DADE descendant session, dataset, dataview}
  daRegisterSession(TdanxSession);
  daRegisterDataSet(TdanxDataSet);
  daRegisterDataView(TdanxQueryDataView);

finalization
  {unregister the NexusDB descendant classes}
  UnRegisterClasses([TdaChildNxQuery, TdaChildNxTable]);

  {unregister DADE descendant the session, dataset, dataview}
  daUnRegisterSession(TdanxSession);
  daUnRegisterDataSet(TdanxDataSet);
  daUnRegisterDataView(TdanxQueryDataView);

end.




