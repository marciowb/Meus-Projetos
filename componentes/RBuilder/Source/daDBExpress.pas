{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit daDBExpress;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi10} WideStrings,{$ENDIF}
  {$IFDEF Delphi11}
  // nothing here
  {$ELSE} {$IFDEF Delphi7}
  DBXpress,
  {$ELSE}
  DBLocal, DBLocalS,
  {$ENDIF}
  {$ENDIF}

  Classes, SysUtils, Forms, ExtCtrls,  DB, Provider,
  ppClass, ppComm, ppDBPipe, ppDB, ppClasUt, ppTypes, ppUtils,
  ppDsIntf,
  daDB, daQueryDataView, daDataView, daPreviewDataDlg,
  DBClient, DBConnAdmin, SqlExpr;

type

  {dbExpress DataView Classes:

     1.  dbExpress TDataSet descendants
           - TDataSets that can be children of a DataView.
           - Override the HasParent method of TComponent to return True
           - Must be registerd with the Delphi IDE using the RegisterNoIcon procedure

       a. TdaChildSQLClientDataSet - TClientDataSet descendant that can be a child of a DataView

     2.  TdaSQLSession
           - descendant of TppSession
           - implements GetDatabaseNames, GetTableNames, etc.

     3.  TdaSQLDataSet
          - descendant of TppDataSet
          - implements GetFieldNames for SQL

     4.  TdaSQLueryDataView
          - descendant of TppQueryDataView
          - uses the above classes to create the required
            DataSet -> DataSource -> Pipeline -> Report connection
          - uses the TdaSQL object built by the QueryWizard to assign
            SQL to the TdaSQLDataSet etc.

      }

  { TdaChildSQLClientDataSet }

  TdaChildSQLClientDataSet = class(TClientDataSet)
    private
      FSQLDataSet: TSQLDataSet;
      FDataSetProvider: TDataSetProvider;
      FSQLConnection: TSQLConnection;

      procedure SetConnection(const Value: TSQLConnection);

    protected
      procedure SetActive(Value: Boolean); override;

    public
      constructor Create(aOwner: TComponent); override;
      function HasParent: Boolean; override;

      property SQLDataSet: TSQLDataSet read FSQLDataSet;
      property DataSetProvider: TDataSetProvider read FDataSetProvider;
      property Connection: TSQLConnection read FSQLConnection write SetConnection;

    end;  {class, TdaChildSQLClientDataSet}


  { TdaSQLSession }
  TdaSQLSession = class(TdaSession)
    private

    protected
      function GetDefaultDatabase(const aDatabaseName: String): TComponent; override;
      function IsNamedDatabase(const aDatabaseName: String; aDatabase: TComponent): Boolean; override;

    public
      class function ClassDescription: String; override;
      class function DataSetClass: TdaDataSetClass; override;
      class function DatabaseClass: TComponentClass; override;
      class function GetDefaultSQLConnection: TSQLConnection;

      procedure GetDatabaseNames(aList: TStrings); override;
      function  GetDatabaseType(const aDatabaseName: String): TppDatabaseType; override;
      procedure GetTableNames(const aDatabaseName: String; aList: TStrings); override;
      function  ValidDatabaseTypes: TppDatabaseTypes; override;

  end; {class, TdaSQLSession}



  { TdaSQLDataSet }
  TdaSQLDataSet = class(TdaDataSet)
    private
      FSQLConnection: TSQLConnection;

      FQuery: TdaChildSQLClientDataSet;

      function GetQuery: TClientDataSet;

    protected
      procedure BuildFieldList; override;
      function  GetActive: Boolean; override;
      procedure SetActive(Value: Boolean); override;
      procedure SetDatabase(aDatabase: TComponent); override;
      procedure SetDataName(const aDataName: String); override;

      property Query: TClientDataSet read GetQuery;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function ClassDescription: String; override;

      procedure GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings); override;
      procedure GetFieldsForSQL(aList: TList; aSQL: TStrings); override;

  end; {class, TdaSQLDataSet}


  { TdaSQLQueryDataView }
  TdaSQLQueryDataView = class(TdaQueryDataView)
    private
      FDataSource: TppChildDataSource;
      FQuery: TdaChildSQLClientDataSet;

    protected
      procedure SQLChanged; override;
      procedure SetActive(aValue: Boolean); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      {used to hook into DBPipeline so that ClientDataSet.ApplyUpdates can be called as needed}
      class procedure ClientDataUpdateHook(aDBPipeline: TppDBPipeline; aDataSet: TDataSet);

      class function PreviewFormClass: TFormClass; override;
      class function SessionClass: TClass; override;

      procedure Init; override;
      procedure ConnectPipelinesToData; override;

    published
      property DataSource: TppChildDataSource read FDataSource;

  end; {class, TdaSQLQueryDataView}



  {Delphi design time registration}
  procedure Register;


implementation

const
  cDefaultConnection = 'DefaultSQLConnection';

var
  FSQLConnection: TSQLConnection;


{******************************************************************************
 *
 ** R E G I S T E R
 *
{******************************************************************************}

procedure Register;
begin

  {SQL DataAccess Components}
  RegisterNoIcon([TdaChildSQLClientDataSet]);

  {SQL DataViews}
  RegisterNoIcon([TdaSQLQueryDataView]);

end;


{******************************************************************************
 *
 ** C H I L D   D B E X P R E S S   D A T A   A C C E S S   C O M P O N E N T S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaChildSQLClientDataSet.HasParent }

function TdaChildSQLClientDataSet.HasParent: Boolean;
begin
  Result := True;

end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TdaChildSQLClientDataSet.Create }

constructor TdaChildSQLClientDataSet.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FSQLDataSet := TSQLDataSet.Create(aOwner);
  FDataSetProvider := TDataSetProvider.Create(aOwner);

  FDataSetProvider.DataSet := FSQLDataSet;

  SetProvider(FDataSetProvider);

  FDataSetProvider.Options := FDataSetProvider.Options + [poRetainServerOrder];

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaChildSQLClientDataSet.SetActive }

procedure TdaChildSQLClientDataSet.SetActive(Value: Boolean);
begin
  FSQLDataSet.Active := Value;

  inherited;

  SetProvider(FDataSetProvider);

end; {procedure, SetActive}

{------------------------------------------------------------------------------}
{ TdaChildSQLClientDataSet.SetConnection }

procedure TdaChildSQLClientDataSet.SetConnection(const Value: TSQLConnection);
begin
  FSQLConnection := Value;

  FSQLDataSet.SQLConnection := Value;

end; {procedure, SetConnection}


{******************************************************************************
 *
 ** S Q L  S E S S I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSQLSession.ClassDescription }

class function TdaSQLSession.ClassDescription: String;
begin
  Result := 'dbExpressSession';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaSQLSession.DataSetClass }

class function TdaSQLSession.DataSetClass: TdaDataSetClass;
begin
  Result := TdaSQLDataSet;
end; {class function, DataSetClass}

{------------------------------------------------------------------------------}
{ TdaSQLSession.DatabaseClass }

class function TdaSQLSession.DatabaseClass: TComponentClass;
begin
  Result := TSQLConnection;
end;

{------------------------------------------------------------------------------}
{ TdaSQLSession.GetDefaultSQLConnection }

class function TdaSQLSession.GetDefaultSQLConnection: TSQLConnection;
begin

  {create the default dbExpress Connection, if needed}
  if (FSQLConnection = nil) then
    begin
      {create default SQL Connection}
      FSQLConnection := TSQLConnection.Create(nil);
      FSQLConnection.Name := cDefaultConnection;
      FSQLConnection.LoadParamsOnConnect := False;
    end;

  Result := FSQLConnection;

end; {function, daGetDefaultSQLConnection}

{------------------------------------------------------------------------------}
{ TdaSQLSession.GetTableNames }

procedure TdaSQLSession.GetTableNames(const aDatabaseName: String; aList: TStrings);
var
  lSQLConnection: TSQLConnection;

begin
  {get the database}
  lSQLConnection := TSQLConnection(GetDatabaseForName(aDatabaseName));

  {connection must be active to get table names}
  if not lSQLConnection.Connected then
    lSQLConnection.Connected := True;

  {get list of table names from a table object}
  if lSQLConnection.Connected then
{$IFDEF Delphi7}
    if GetDatabaseType(aDatabaseName) = dtMSSQLServer then
      lSQLConnection.GetTableNames(aList, 'dbo', False)
    else
{$ENDIF}
      lSQLConnection.GetTableNames(aList, False);

end; {procedure, GetTableNames}

{------------------------------------------------------------------------------}
{ TdaSQLSession.GetDatabaseNames }

procedure TdaSQLSession.GetDatabaseNames(aList: TStrings);
begin
  {call inherited to build list of available TSQLConnection components}
  inherited GetDatabaseNames(aList);

  {could add hard-coded connection strings here, or could
   read from an .ini file }
  if (aList.Count = 0) then
    GetConnectionAdmin.GetConnectionNames(aList, '');

end; {procedure, GetDatabaseNames}

{------------------------------------------------------------------------------}
{ TdaSQLSession.GetDefaultDatabase }

function TdaSQLSession.GetDefaultDatabase(const aDatabaseName: String): TComponent;
var
  lSQLConnection: TSQLConnection;
begin

  lSQLConnection := GetDefaultSQLConnection;

  {set DatabaseName property, if needed}
  if (lSQLConnection.ConnectionName <> aDatabaseName) then
    begin
      if lSQLConnection.Connected then
        lSQLConnection.Connected := False;
      lSQLConnection.ConnectionName := aDatabaseName;

    end;

  Result := lSQLConnection;

end; {function, GetDefaultDatabase}

{------------------------------------------------------------------------------}
{ TdaSQLSession.IsNamedDatabase }

function TdaSQLSession.IsNamedDatabase(const aDatabaseName: String; aDatabase: TComponent): Boolean;
begin

  if (AnsiCompareText(aDatabase.Name, aDatabaseName) = 0) or
     (AnsiCompareText(TSQLConnection(aDatabase).ConnectionName, aDatabaseName) = 0) then
     Result := True
  else
    Result := False;


end; {function, IsNamedDatabase}

{------------------------------------------------------------------------------}
{ TdaSQLSession.ValidDatabaseTypes }

function TdaSQLSession.ValidDatabaseTypes: TppDatabaseTypes;
begin

  {can add more here as needed}
  Result := [dtInterBase, dtMSSQLServer, dtMySQL, dtOracle, dtSybaseASA, dtSybaseASE, dtOther];

end; {procedure, ValidDatabaseTypes}

{------------------------------------------------------------------------------}
{ TdaSQLSession.GetDatabaseType }

function TdaSQLSession.GetDatabaseType(const aDatabaseName: String): TppDatabaseType;
var
  lSQLConnection: TSQLConnection;
  lsDriverName: String;
begin

  Result := dtInterbase;

  {get the database}
  lSQLConnection := TSQLConnection(GetDatabaseForName(aDatabaseName));

  if (lSQLConnection <> nil) then
    begin
      lsDriverName := lSQLConnection.DriverName;

      if ppEqual(lsDriverName, 'Interbase') then
        Result := dtInterbase
      else if ppEqual(lsDriverName, 'Firebird') then
        Result := dtFirebird
      else if ppEqual(lsDriverName, 'MSSQL') then
        Result := dtMSSQLServer
      else if ppEqual(lsDriverName, 'MYSQL') then
        Result := dtMySQL
      else if ppEqual(lsDriverName, 'Oracle') then
        begin
          Result := dtOracle;
          TppDBPipeline.SetStringTrim(True);
        end
      else if ppEqual(lsDriverName, 'ASA') then
        Result := dtSybaseASA
      else if ppEqual(lsDriverName, 'ASE') then
        Result := dtSybaseASE;

    end;

end; {function, GetDatabaseType}


{******************************************************************************
 *
 ** S Q L   D A T A S E T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSQLDataSet.Create }

constructor TdaSQLDataSet.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FQuery := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaSQLDataSet.Destroy }

destructor TdaSQLDataSet.Destroy;
begin

  FQuery.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaSQLDataSet.ClassDescription }

class function TdaSQLDataSet.ClassDescription: String;
begin
  Result := 'SQLDataSet';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaSQLDataSet.GetActive }

function TdaSQLDataSet.GetActive: Boolean;
begin
  Result := GetQuery.Active
end; {function, GetActive}

{------------------------------------------------------------------------------}
{ TdaSQLDataSet.SetActive }

procedure TdaSQLDataSet.SetActive(Value: Boolean);
begin
  GetQuery.Active := Value;
end; {procedure, SetActive}

{------------------------------------------------------------------------------}
{ TdaSQLDataSet.GetQuery }

function TdaSQLDataSet.GetQuery: TClientDataSet;
begin

  {create SQL dataset, if needed}
  if (FQuery = nil) then
    FQuery := TdaChildSQLClientDataSet.Create(Self);

  Result := FQuery;

end; {procedure, GetQuery}

{------------------------------------------------------------------------------}
{ TdaSQLDataSet.SetDatabase }

procedure TdaSQLDataSet.SetDatabase(aDatabase: TComponent);
begin

  inherited SetDatabase(aDatabase);

  {table cannot be active to set database property}
  if GetQuery.Active then
    FQuery.Active := False;

  FSQLConnection := TSQLConnection(aDatabase);

  FQuery.Connection := FSQLConnection;

end; {procedure, SetDatabase}

{------------------------------------------------------------------------------}
{ TdaSQLDataSet.SetDataName }

procedure TdaSQLDataSet.SetDataName(const aDataName: String);
var
  lsSQLText: String;
begin

  inherited SetDataName(aDataName);

  {dataset cannot be active to set data name}
  if GetQuery.Active then
    FQuery.Active := False;

  {construct an SQL statment that returns an empty result set,
   this is used to get the field information }

  lsSQLText := 'SELECT * FROM ' + aDataName + ' WHERE ''c'' <> ''c'' ';

  FQuery.SQLDataset.CommandText := lsSQLText;

end; {procedure, SetDataName}

{------------------------------------------------------------------------------}
{ TdaSQLDataSet.BuildFieldList }

procedure TdaSQLDataSet.BuildFieldList;
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
{ TdaSQLDataSet.GetFieldNamesForSQL }

procedure TdaSQLDataSet.GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings);
var
  lQuery: TdaChildSQLClientDataSet;
{$IFDEF Delphi10}
  lWideStrings: TWideStringList;
{$ENDIF}
begin

  aList.Clear;

  {create a temporary query}
  lQuery := TdaChildSQLClientDataSet.Create(Self);

  {set the database and SQL properties}

  lQuery.Connection := FSQLConnection;
  lQuery.SQLDataset.CommandText := aSQL.Text;

{$IFDEF Delphi10}
  lWideStrings := TWideStringList.Create;

  try
    lQuery.GetFieldNames(lWideStrings);

    aList.Assign(lWideStrings);
  finally
    lWideStrings.Free;
  end;

{$ELSE}
  {get the field names}
  lQuery.GetFieldNames(aList);
{$ENDIF}


  lQuery.Free;

end; {procedure, GetFieldNamesForSQL}

{------------------------------------------------------------------------------}
{ TdaSQLDataSet.GetFieldsForSQL }

procedure TdaSQLDataSet.GetFieldsForSQL(aList: TList; aSQL: TStrings);
var
  lQuery: TdaChildSQLClientDataSet;
  lQueryField: TField;
  lField: TppField;
  liIndex: Integer;
begin

  aList.Clear;

  {create a temporary query}
  lQuery := TdaChildSQLClientDataSet.Create(Self);

  try

    {assign databae and SQL properties}

    lQuery.Connection := FSQLConnection;
    lQuery.SQLDataset.CommandText := aSQL.Text;

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
 ** S Q L  Q U E R Y   D A T A V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSQLQueryDataView.Create }

constructor TdaSQLQueryDataView.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  {notes: 1. must use ChildQuery, ChildDataSource, ChildPipeline etc.
          2. use Self as owner for Query, DataSource etc.
          3. do NOT assign a Name }

  FQuery := TdaChildSQLClientDataSet.Create(Self);

  FDataSource := TppChildDataSource.Create(Self);
  FDataSource.DataSet := FQuery;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaSQLQueryDataView.Destroy }

destructor TdaSQLQueryDataView.Destroy;
begin

  FDataSource.Free;
  FQuery.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaSQLQueryDataView.SessionClass }

class function TdaSQLQueryDataView.SessionClass: TClass;
begin
  Result := TdaSQLSession;
end; {class function, SessionClass}

{------------------------------------------------------------------------------}
{ TdaSQLQueryDataView.PreviewFormClass }

class function TdaSQLQueryDataView.PreviewFormClass: TFormClass;
begin
  Result := TFormClass(GetClass('TdaPreviewDataDialog'));
end; {class function, PreviewFormClass}

{------------------------------------------------------------------------------}
{ TdaSQLQueryDataView.ConnectPipelinesToData }

procedure TdaSQLQueryDataView.ConnectPipelinesToData;
begin

  if DataPipelineCount = 0 then Exit;

  {need to reconnect here}
  TppDBPipeline(DataPipelines[0]).DataSource := FDataSource;

end; {procedure, ConnectPipelinesToData}

{------------------------------------------------------------------------------}
{ TdaSQLQueryDataView.Init }

procedure TdaSQLQueryDataView.Init;
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
{ TdaSQLQueryDataView.SQLChanged }

{------------------------------------------------------------------------------}
{ TdaSQLQueryDataView.SQLChanged }

procedure TdaSQLQueryDataView.SQLChanged;
var
  lDatabase: TComponent;
begin

  if FQuery.Active then
    FQuery.Close;

  lDatabase := Session.GetDatabaseForName(SQL.DatabaseName);

  if (lDatabase = nil) then
    raise EDataError.Create('TdaSQLQueryDataView.SQLChanged: No SQLConnection object found, ' + SQL.DatabaseName);

  FQuery.Connection := TSQLConnection(lDatabase);
  FQuery.SQLDataset.CommandText := SQL.MagicSQLText.Text;

end; {procedure, SQLChanged}

{------------------------------------------------------------------------------}
{ TdaSQLQueryDataView.ClientDataUpdateHook }

class procedure TdaSQLQueryDataView.ClientDataUpdateHook(aDBPipeline: TppDBPipeline; aDataSet: TDataSet);
begin                    
  if aDataSet is TCustomClientDataSet then
    TCustomClientDataSet(aDataSet).ApplyUpdates(-1);
end;

{------------------------------------------------------------------------------}
{ TdaSQLQueryDataView.SetActive }

procedure TdaSQLQueryDataView.SetActive(aValue: Boolean);
begin

  try
    inherited SetActive(aValue);
    
  except
    {when an exception occurs in TSQLClientDataset, need to
     free the existing dataset and create a new one.
      - this is necessary to work around bugs in dbExpress}
    FQuery.Free;
    FQuery := TdaChildSQLClientDataSet.Create(Self);
    FDataSource.DataSet := FQuery;

    raise;

  end;

end; {procedure, SetActive}

initialization

  {register the SQL descendant classes}
  RegisterClasses([TdaChildSQLClientDataSet]);

  {register DADE descendant session, dataset, dataview}
  daRegisterSession(TdaSQLSession);
  daRegisterDataSet(TdaSQLDataSet);
  daRegisterDataView(TdaSQLQueryDataView);

  TppDBPipeline.RegisterDataSetUpdateHook(TdaSQLQueryDataView.ClientDataUpdateHook);

  {initialize internal reference variables}
  FSQLConnection := nil;


finalization

  {free the default connection object}
  FSQLConnection.Free;
  FSQLConnection := nil;

  {unregister the SQL descendant classes}
  UnRegisterClasses([TdaChildSQLClientDataSet]);

  {unregister DADE descendant the session, dataset, dataview}
  daUnRegisterSession(TdaSQLSession);
  daUnRegisterDataSet(TdaSQLDataSet);
  daUnRegisterDataView(TdaSQLQueryDataView);

  TppDBPipeline.RegisterDataSetUpdateHook(nil);

end.
