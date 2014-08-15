{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

{******************************************************************************}
{  Special thanks to
{
{     Nicola Farina
{         - Oracle mentoring
(         - testing and debugging
(         - contributed DOA linking logic
{         - optimized GetTableNames
{                                                                                                                                                     }
{     DOA Team
{         - help with GetDatabaseNames logic
{
{******************************************************************************}

unit daDOA;

interface

uses
  Windows,
  SysUtils,
  Classes,
  Forms,
  DB,

  ppTypes,
  ppClass,
  ppClasUt,
  ppComm,
  ppDBPipe,
  ppDB,

  daDB,
  daQueryDataView,
  daDataView,
  daPreviewDataDlg,

  Oracle,
  OracleData,
  OracleCI;



type

  {Direct Oracle Access (DOA) DataView Classes:

     1.  DOA TDataSet descendants
           - TDataSets that can be children of a DataView.
           - Override the HasParent method of TComponent to return True
           - Must be registerd with the Delphi IDE using the RegisterNoIcon procedure

       a. TdaChildDOAQuery        - TOracleDataSet descendant that can be a child of a DataView
       b. TdaChildDOATable        - TOracleDataSet descendant that can be a child of a DataView
       c. TdaChildDOAPackage      - TOraclePackage descendant that can be a child of a DataView

     3.  TdaDOASession
           - descendant of TppSession
           - implements GetDatabaseNames, GetTableNames, etc.

     4.  TdaDOADataSet
          - descendant of TppDataSet
          - implements GetFieldNames for SQL

     5.  TdaDOAQueryDataView
          - descendant of TppQueryDataView
          - uses the above classes to create the required
            Query -> DataSource -> Pipeline -> Report connection
          - uses the TdaSQL object built by the QueryWizard to assign
            SQL to the TDOAQuery etc.

      }

  { TdaChildDOAQuery }
  TdaChildDOAQuery = class(TOracleDataSet)
    public
      function HasParent: Boolean; override;
    end;  {class, TdaChildDOAQuery}

  { TdaChildDOATable }
  TdaChildDOATable = class(TOracleDataSet)
    public
      function HasParent: Boolean; override;
    end;  {class, TdaChildDOATable}

  { TdaChildDOAPackage }
  TdaChildDOAPackage = class(TOraclePackage)
    public
      function HasParent: Boolean; override;
    end;  {class, TdaChildDOAPackage}


  { TdaDOASession }
  TdaDOASession = class(TdaSession)
    private
      FFunctions: TStringList;

      procedure BuildFunctionList;

    protected
      function GetDefaultDatabase(const aDatabaseName: String): TComponent; override;
      function IsNamedDatabase(const aDatabaseName: String; aDatabase: TComponent): Boolean; override;

    public
      constructor Create(aComponent: TComponent); override;
      destructor Destroy; override;

      class function ClassDescription: String; override;
      class function DataSetClass: TdaDataSetClass; override;
      class function DatabaseClass: TComponentClass; override;
      class function GetDefaultDOAConnection: TOracleSession;
      class function LogonToDatabase(aDOAConnection: TOracleSession): Boolean;
      function ContainsSQLFunctionCall(const aString: String; aDatabaseType: TppDatabaseType): Boolean; override;

      procedure GetDatabaseNames(aList: TStrings); override;
      function  GetDatabaseType(const aDatabaseName: String): TppDatabaseType; override;
      procedure GetTableNames(const aDatabaseName: String; aList: TStrings); override;
      function  ValidDatabaseTypes: TppDatabaseTypes; override;

  end; {class, TdaDOASession}



  { TdaDOADataSet }
  TdaDOADataSet = class(TdaDataSet)
    private
      FQuery: TOracleDataSet;

      function GetQuery: TOracleDataSet;

    protected
      procedure BuildFieldList; override;
      function  GetActive: Boolean; override;
      procedure SetActive(Value: Boolean); override;
      procedure SetDatabase(aDatabase: TComponent); override;
      procedure SetDataName(const aDataName: String); override;

      property Query: TOracleDataSet read GetQuery;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function ClassDescription: String; override;

      procedure GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings); override;
      procedure GetFieldsForSQL(aList: TList; aSQL: TStrings); override;

  end; {class, TdaDOADataSet}


  { TdaDOAQueryDataView }
  TdaDOAQueryDataView = class(TdaQueryDataView)
    private
      FDataSource: TppChildDataSource;
      FQuery: TdaChildDOAQuery;

    protected
      procedure SQLChanged; override;
      procedure CreatePipelineLinksForParameterizedSQL(aDataPipeline: TppDataPipeline); override;
      procedure SQLToDataView; override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function PreviewFormClass: TFormClass; override;
      class function SessionClass: TClass; override;

      procedure Init; override;
      procedure ConnectPipelinesToData; override;

    published
      property DataSource: TppChildDataSource read FDataSource;

  end; {class, TdaDOAQueryDataView}


  {Delphi design time registration}
  procedure Register;


implementation

uses
  daSQL;

const
  cDefaultConnection = 'DefaultDOAConnection';

var
  FDOAConnection: TOracleSession;
  FDOALogon: TOracleLogon;

{******************************************************************************
 *
 ** R E G I S T E R
 *
{******************************************************************************}

procedure Register;
begin

  {DOA DataAccess Components}
  RegisterNoIcon([TdaChildDOAQuery, TdaChildDOATable, TdaChildDOAPackage]);

  {DOA DataViews}
  RegisterNoIcon([TdaDOAQueryDataView]);

end;

{******************************************************************************
 *
 ** C H I L D   D O A   D A T A   A C C E S S   C O M P O N E N T S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaChildDOAQuery.HasParent }

function TdaChildDOAQuery.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TdaChildDOATable.HasParent }

function TdaChildDOATable.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}


{------------------------------------------------------------------------------}
{ TdaChildDOAPackage.HasParent }

function TdaChildDOAPackage.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}


{******************************************************************************
 *
 ** D O A  S E S S I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDOASession.Create }

constructor TdaDOASession.Create(aComponent: TComponent);
begin

  inherited Create(aComponent);

  FFunctions := TStringList.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaDOASession.Destroy }

destructor TdaDOASession.Destroy;
begin

  FFunctions.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaDOASession.ContainsSQLFunctionCall }

function TdaDOASession.ContainsSQLFunctionCall(const aString: String; aDatabaseType: TppDatabaseType): Boolean;
var
  liIndex: Integer;
  liPosition: Integer;
  lsFunction: String;
begin

  if (FFunctions.Count = 0) then
    BuildFunctionList;

  liIndex := 0;
  liPosition := 0;
  lsFunction := UpperCase(aString);

  while (liIndex < FFunctions.Count) and (liPosition = 0) do
    begin
      liPosition := Pos(FFunctions[liIndex], lsFunction);

      Inc(liIndex);
    end;

  Result := (liPosition <> 0);

end; {procedure, ContainsSQLFunctionCall}

{------------------------------------------------------------------------------}
{ TdaDOASession.BuildFunctionList }

procedure TdaDOASession.BuildFunctionList;
begin

  {add standard SQL2 functions}
  FFunctions.Add('CAST(');
  FFunctions.Add('CHAR_LENGTH(');
  FFunctions.Add('CONVERT(');
  FFunctions.Add('CURRENT_DATE');
  FFunctions.Add('CURRENT_TIME');
  FFunctions.Add('CURRENT_TIMESTAMP');
  FFunctions.Add('EXTRACT(');
  FFunctions.Add('LOWER(');
  FFunctions.Add('POSITION(');
  FFunctions.Add('SUBSTRING(');
  FFunctions.Add('TRANSLATE(');
  FFunctions.Add('TRIM(');
  FFunctions.Add('UPPER(');

  {oracle functions}
  FFunctions.Add('SYSDATE');

end; {procedure, BuildFunctionList}

{------------------------------------------------------------------------------}
{ TdaDOASession.ClassDescription }

class function TdaDOASession.ClassDescription: String;
begin
  Result := 'DOASession';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaDOASession.DataSetClass }

class function TdaDOASession.DataSetClass: TdaDataSetClass;
begin
  Result := TdaDOADataSet;
end; {class function, DataSetClass}

{------------------------------------------------------------------------------}
{ TdaDOASession.DatabaseClass }

class function TdaDOASession.DatabaseClass: TComponentClass;
begin
  Result := TOracleSession;
end;

{------------------------------------------------------------------------------}
{ TdaDOASession.GetDefaultDOAConnection }

class function TdaDOASession.GetDefaultDOAConnection: TOracleSession;
begin

  {create the default Connection, if needed}
  if (FDOAConnection = nil) then
    begin
      {create default DOA Connection}
      FDOAConnection := TOracleSession.Create(nil);
      FDOAConnection.Name := cDefaultConnection;

      FDOALogon := TOracleLogon.Create(nil);
      FDOALogon.Session := FDOAConnection;

    end;

  Result := FDOAConnection;

end; {class function, GetDefaultDOAConnection}

{------------------------------------------------------------------------------}
{ TdaDOASession.LogonToDatabase }

class function TdaDOASession.LogonToDatabase(aDOAConnection: TOracleSession): Boolean;
begin

  if (aDOAConnection = nil) then
    Result := False

  else if aDOAConnection.Connected then
    Result := True

  else
    begin
      if (aDOAConnection = GetDefaultDOAConnection) then
        FDOALogon.Execute
      else
        aDOAConnection.Connected := True;

      Result := aDOAConnection.Connected;
    end;

end; {class function, LogonToDatabase}


{------------------------------------------------------------------------------}
{ TdaDOASession.GetDatabaseType }

function TdaDOASession.GetDatabaseType(const aDatabaseName: String): TppDatabaseType;
begin
  Result := dtOracle;
end; {procedure, GetDatabaseType}

{------------------------------------------------------------------------------}
{ TdaDOASession.GetTableNames }

procedure TdaDOASession.GetTableNames(const aDatabaseName: String; aList: TStrings);
var
  lsTableName: String;
  lConnection: TOracleSession;
  lQuery: TOracleDataSet;

begin
  aList.Clear;

  lConnection := TOracleSession(GetDatabaseForName(aDatabaseName));

  if not LogonToDatabase(lConnection) then Exit;

  {get list of table names from a table object}
  lQuery := TOracleDataSet.Create(nil);
  lQuery.Session := lConnection;

{ query originale
  lQuery.SQL.Text :=   'select owner, object_name ' +
                       'from all_objects ' +
                       'where object_type in (''TABLE'', ''VIEW'') ' +
                       'and owner not in (''SYS'', ''SYSTEM'')';
}
  // optimization - Nicola Farina
  lQuery.SQL.Text :=   'select user, object_name ' +
                       'from user_objects ' +
                       'where object_type in (''TABLE'', ''VIEW'') ';

  lQuery.ReadBuffer := 500;

  lQuery.Open;

  if lQuery.Active then
    begin

      lQuery.First;

      while not lQuery.EOF do
        begin
          // owner.tablename
          lsTableName := lQuery.Fields[0].AsString + '.' + lQuery.Fields[1].AsString;
          aList.Add(lsTableName);

          lQuery.Next;

        end;

    end;


  lQuery.Free;

end; {procedure, GetTableNames}


{------------------------------------------------------------------------------}
{ TdaDOASession.GetDatabaseNames }

procedure TdaDOASession.GetDatabaseNames(aList: TStrings);
var
  liIndex: Integer;
begin

  {call inherited to build list of available TOracleSession components}
  inherited GetDatabaseNames(aList);

  {call utility routine in OracleCI unit}
  BuildOracleAliasList;

  {assign the strings, do not use aList.Assign() because aList.Objects array will get cleared}
  for liIndex := 0 to OracleAliasList.Count - 1 do
   aList.Add(OracleAliasList[liIndex]);

end; {procedure, GetDatabaseNames}

{------------------------------------------------------------------------------}
{ TdaDOASession.GetDefaultDatabase }

function TdaDOASession.GetDefaultDatabase(const aDatabaseName: String): TComponent;
var
  lOracleSession: TOracleSession;
begin

  lOracleSession := GetDefaultDOAConnection;

  {set DatabaseName property, if needed}
  if (lOracleSession.LogonDatabase <> aDatabaseName) then
    begin
      if lOracleSession.Connected then
        lOracleSession.Connected := False;
      lOracleSession.LogonDatabase := aDatabaseName;

      {DOA does not auto logon, so force a logon dialog here}
      LogonToDatabase(lOracleSession);

    end;

  Result := lOracleSession;

end; {function, GetDefaultDatabase}

{------------------------------------------------------------------------------}
{ TdaDOASession.IsNamedDatabase }

function TdaDOASession.IsNamedDatabase(const aDatabaseName: String; aDatabase: TComponent): Boolean;
begin

   Result := (AnsiCompareStr(aDatabase.Name, aDatabaseName) = 0) or
             (AnsiCompareStr(TOracleSession(aDatabase).LogonDatabase, aDatabaseName) = 0);

end; {function, IsNamedDatabase}

{------------------------------------------------------------------------------}
{ TdaDOASession.ValidDatabaseTypes }

function TdaDOASession.ValidDatabaseTypes: TppDatabaseTypes;
begin
  Result := [dtOracle];

end; {function, ValidDatabaseTypes}


{******************************************************************************
 *
 ** D O A D A T A S E T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDOADataSet.Create }

constructor TdaDOADataSet.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FQuery := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaDOADataSet.Destroy }

destructor TdaDOADataSet.Destroy;
begin

  FQuery.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaDOADataSet.ClassDescription }

class function TdaDOADataSet.ClassDescription: String;
begin
  Result := 'DOADataSet';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaDOADataSet.GetActive }

function TdaDOADataSet.GetActive: Boolean;
begin
  Result := GetQuery.Active
end; {function, GetActive}

{------------------------------------------------------------------------------}
{ TdaDOADataSet.SetActive }

procedure TdaDOADataSet.SetActive(Value: Boolean);
begin
  GetQuery.Active := Value;
end; {procedure, SetActive}

{------------------------------------------------------------------------------}
{ TdaDOADataSet.GetQuery }

function TdaDOADataSet.GetQuery: TOracleDataSet;
begin

  {create DOA DataSet, if needed}
  if (FQuery = nil) then
    FQuery := TOracleDataSet.Create(Self);

  Result := FQuery;

end; {procedure, GetQuery}

{------------------------------------------------------------------------------}
{ TdaDOADataSet.SetDatabase }

procedure TdaDOADataSet.SetDatabase(aDatabase: TComponent);
begin

  inherited SetDatabase(aDatabase);

  {table cannot be active to set database property}
  if GetQuery.Active then
    FQuery.Active := False;

  {set ADOQuery.Connection}
  FQuery.Session := TOracleSession(aDatabase);

end; {procedure, SetDatabase}

{------------------------------------------------------------------------------}
{ TdaDOADataSet.SetDataName }

procedure TdaDOADataSet.SetDataName(const aDataName: String);
begin

  inherited SetDataName(aDataName);

  {dataset cannot be active to set data name}
  if GetQuery.Active then
    FQuery.Active := False;

  {construct an SQL statment that returns an empty result set,
   this is used to get the field information }
  FQuery.SQL.Text := 'SELECT * FROM ' + aDataName +
                     ' WHERE ''c'' <> ''c'' ';

end; {procedure, SetDataName}

{------------------------------------------------------------------------------}
{ TdaDOADataSet.BuildFieldList }

procedure TdaDOADataSet.BuildFieldList;
var
  liIndex: Integer;
  lQueryField: TField;
  lField: TppField;
begin

  inherited BuildFieldList;


  {set table to active}
  if not(GetQuery.Active) then
    FQuery.Active := True;

  {create TppField objects for each field in the table}
  for liIndex := 0 to FQuery.FieldCount - 1 do
    begin
      lQueryField := FQuery.Fields[liIndex];

      lField := TppField.Create(nil);

      lField.TableName := DataName;
      lField.FieldName := lQueryField.FieldName;
      lField.FieldAlias := lQueryField.DisplayLabel;
      lField.FieldLength := lQueryField.Size;
      lField.DataType := ppConvertFieldType(lQueryField.DataType);
      lField.DisplayWidth := lQueryField.DisplayWidth;


      AddField(lField);
    end;

end; {function, BuildFieldList}

{------------------------------------------------------------------------------}
{ TdaDOADataSet.GetFieldNamesForSQL }

procedure TdaDOADataSet.GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings);
var
  lQuery: TOracleDataSet;
begin
  aList.Clear;

  {create a temporary query}
  lQuery := TOracleDataSet.Create(Self);

  {set the database and SQL properties}
  lQuery.Session := TOracleSession(Database);
  lQuery.SQL := aSQL;

  {get the field names}
  lQuery.GetFieldNames(aList);

  lQuery.Free;

end; {procedure, GetFieldNamesForSQL}

{------------------------------------------------------------------------------}
{ TdaDOADataSet.GetFieldsForSQL }

procedure TdaDOADataSet.GetFieldsForSQL(aList: TList; aSQL: TStrings);
var
  lQuery: TOracleDataSet;
  lQueryField: TField;
  lField: TppField;
  liIndex: Integer;
begin
  aList.Clear;

  {create a temporary query}
  lQuery := TOracleDataSet.Create(Self);

  try
    {assign databae and SQL properties}
    lQuery.Session := TOracleSession(Database);
    lQuery.SQL := aSQL;

    {set query to active}
    lQuery.Active := True;

    {create a TppField object for each field in the query}
    for liIndex := 0 to lQuery.FieldCount - 1 do
      begin
        lQueryField := lQuery.Fields[liIndex];

        lField := TppField.Create(nil);

        lField.FieldName := lQueryField.FieldName;
        lField.FieldAlias := lQueryField.DisplayLabel;
        lField.FieldLength := lQueryField.Size;
        lField.DataType := ppConvertFieldType(lQueryField.DataType);
        lField.DisplayWidth := lQueryField.DisplayWidth;

        aList.Add(lField);
      end;

  finally
    lQuery.Free;

  end;

end; {procedure, GetFieldsForSQL}


{******************************************************************************
 *
 ** DOA  Q U E R Y   D A T A V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDOAQueryDataView.Create }

constructor TdaDOAQueryDataView.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  {notes: 1. must use ChildQuery, ChildDataSource, ChildPipeline etc.
          2. use Self as owner for Query, DataSource etc.
          3. do NOT assign a Name }

  FQuery := TdaChildDOAQuery.Create(Self);
  FQuery.ReadBuffer := 300; // nf

  FDataSource := TppChildDataSource.Create(Self);
  FDataSource.DataSet := FQuery;

end;

{------------------------------------------------------------------------------}
{ TdaDOAQueryDataView.Destroy }

destructor TdaDOAQueryDataView.Destroy;
begin
  FDataSource.Free;
  FQuery.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaDOAQueryDataView.PreviewFormClass }

class function TdaDOAQueryDataView.PreviewFormClass: TFormClass;
begin
  Result := TFormClass(GetClass('TdaPreviewDataDialog'));
end;

{------------------------------------------------------------------------------}
{ TdaDOAQueryDataView.SessionClass }

class function TdaDOAQueryDataView.SessionClass: TClass;
begin
  Result := TdaDOASession;
end;

{------------------------------------------------------------------------------}
{ TdaDOAQueryDataView.ConnectPipelinesToData }

procedure TdaDOAQueryDataView.ConnectPipelinesToData;
begin

  if DataPipelineCount = 0 then Exit;

  {need to reconnect here}
  TppDBPipeline(DataPipelines[0]).DataSource := FDataSource;

end; {procedure, ConnectPipelinesToData}

{------------------------------------------------------------------------------}
{ TdaDOAQueryDataView.Init }

procedure TdaDOAQueryDataView.Init;
var
  lDataPipeline: TppChildDBPipeline;

begin

  inherited Init;

  if DataPipelineCount > 0 then Exit;

  {note: DataView's owner must own the DataPipeline }
  lDataPipeline := TppChildDBPipeline(ppComponentCreate(Self, TppChildDBPipeline));
  lDataPipeline.DataSource := FDataSource;

  lDataPipeline.AutoCreateFields := False;

  {add DataPipeline to the dataview }
  lDataPipeline.DataView := Self;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TdaDOAQueryDataView.SQLChanged }

procedure TdaDOAQueryDataView.SQLChanged;
var
  lDatabase: TComponent;
begin

  if FQuery.Active then
    FQuery.Close;

  lDatabase := Session.GetDatabaseForName(SQL.DatabaseName);

  FQuery.Session := TOracleSession(lDatabase);
  FQuery.SQL := SQL.MagicSQLText;

end;

{------------------------------------------------------------------------------}
{ TdaDOAQueryDataView.SQLToDataView }

procedure TdaDOAQueryDataView.SQLToDataView;
begin

  // need to clear query linking props here, there will be configured as needed
  // when inherited is called (see CreatePipelineLinksForParameterizedSQL method below)
  FQuery.Master := nil;
  FQuery.MasterFields := '';
  FQuery.DeleteVariables;

  // call inherited last
  inherited;

end;

{------------------------------------------------------------------------------}
{ ppTypeToDoaType }

function ppTypeToDoaType(PpType : TppDataType) : integer;
begin

  Result := otInteger;

  if PpType in [dtInteger, dtSingle, dtDouble, dtExtended, dtCurrency, dtLongint, dtLargeInt] then
    Result := otInteger
  else if ppType in [dtString, dtChar] then
    Result := otString
  else if ppType = dtDate then
    Result := otDate;

end;

{------------------------------------------------------------------------------}
{ TdaDOAQueryDataView.CreatePipelineLinksForParameterizedSQL }

procedure TdaDOAQueryDataView.CreatePipelineLinksForParameterizedSQL(aDataPipeline: TppDataPipeline);
var
  lMasterSource: TDataSource;
  liIndex: Integer;
  lSQLLink: TdaSQLLink;
begin

  // DOA links query's differently than other DataSet descendants

  // set Query.Master to reference the master query
  if (aDataPipeline is TppDBPipeline) and (aDataPipeline.MasterDataPipeline is TppDBPipeline) then
    begin
      lMasterSource := TppDBPipeline(aDataPipeline.MasterDataPipeline).DataSource;

      if lMasterSource.DataSet is TOracleDataset then
        FQuery.Master := TOracleDataset(lMasterSource.DataSet);
    end;

  // add query masterfields and variables
  for liIndex := 0 to SQL.LinkCount - 1 do
    begin
      lSQLLink := SQL.Links[liIndex];

      if liIndex > 0 then
        FQuery.MasterFields := FQuery.MasterFields + ';';

      FQuery.MasterFields := FQuery.MasterFields + lSQLLink.MasterField.SQLFieldName;

      FQuery.DeclareVariable(lSQLLink.MasterField.SQLFieldName, ppTypeToDoaType(lSQLLink.MasterField.DataType));

    end;

end;

initialization

  {register the DOA descendant classes}
  RegisterClasses([TdaChildDOAQuery, TdaChildDOATable]);

  {register DADE descendant session, dataset, dataview}
  daRegisterSession(TdaDOASession);
  daRegisterDataSet(TdaDOADataSet);
  daRegisterDataView(TdaDOAQueryDataView);

  {initialize internal reference variables}
  FDOAConnection     := nil;
  FDOALogon          := nil;


finalization

  {free the default connection object}
  FDOAConnection.Free;
  FDOAConnection := nil;
  FDOALogon.Free;
  FDOALogon := nil;

  {unregister the DOA descendant classes}
  UnRegisterClasses([TdaChildDOAQuery, TdaChildDOATable]);

  {unregister DADE descendant the session, dataset, dataview}
  daUnRegisterSession(TdaDOASession);
  daUnRegisterDataSet(TdaDOADataSet);
  daUnRegisterDataView(TdaDOAQueryDataView);


end.

