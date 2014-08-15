{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit daADO;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi10} WideStrings,{$ENDIF}
  Windows, Classes, SysUtils, Forms, ExtCtrls,  DB,
  ppClass, ppComm, ppDBPipe, ppDB, ppClasUt, ppTypes,
  daDB, daQueryDataView, daDataView, daPreviewDataDlg,
  ADODB,
  ppDsIntf;

type

  {ADO DataView Classes:

     1.  ADO TDataSet descendants
           - TDataSets that can be children of a DataView.
           - Override the HasParent method of TComponent to return True
           - Must be registerd with the Delphi IDE using the RegisterNoIcon procedure

       a. TdaChildADOQuery - TADOQuery descendant that can be a child of a DataView
       b. TdaChildADOTable - TADOTable descendant that can be a child of a DataView
       c. TdaChildADOStoredProc - TADOStoredProc descendant that can be a child of a DataView

     3.  TdaADOSession
           - descendant of TppSession
           - implements GetDatabaseNames, GetTableNames, etc.

     4.  TdaADODataSet
          - descendant of TppDataSet
          - implements GetFieldNames for SQL

     5.  TdaADOQueryDataView
          - descendant of TppQueryDataView
          - uses the above classes to create the required
            Query -> DataSource -> Pipeline -> Report connection
          - uses the TdaSQL object built by the QueryWizard to assign
            SQL to the TADOQuery etc.

      }

  { TdaChildADOQuery }
  TdaChildADOQuery = class(TADOQuery)
    protected
      procedure SetConnection(const Value: TADOConnection); override;

    public
      function HasParent: Boolean; override;
    end;  {class, TdaChildADOQuery}

  { TdaChildADOTable }
  TdaChildADOTable = class(TADOTable)
    protected
      procedure SetConnection(const Value: TADOConnection); override;

    public
      function HasParent: Boolean; override;
    end;  {class, TdaChildADOTable}

  { TdaChildADOStoredProc }
  TdaChildADOStoredProc = class(TADOStoredProc)
    protected
      procedure SetConnection(const Value: TADOConnection); override;

    public
      function HasParent: Boolean; override;
    end;  {class, TdaChildADOStoredProc}


  { TdaADOSession }
  TdaADOSession = class(TdaSession)
    private

    protected
      function GetDefaultDatabase(const aDatabaseName: String): TComponent; override;
      procedure GetTableNamesForConnection(const aConnection: TADOConnection; aList: TStrings); virtual;
      function IsNamedDatabase(const aDatabaseName: String; aDatabase: TComponent): Boolean; override;

    public
      class function ClassDescription: String; override;
      class function DataSetClass: TdaDataSetClass; override;
      class function DatabaseClass: TComponentClass; override;
      class function GetDefaultADOConnection: TADOConnection;

      procedure GetDatabaseNames(aList: TStrings); override;
      function  GetDatabaseType(const aDatabaseName: String): TppDatabaseType; override;
      procedure GetTableNames(const aDatabaseName: String; aList: TStrings); override;
      function  ValidDatabaseTypes: TppDatabaseTypes; override;

  end; {class, TdaADOSession}



  { TdaADODataSet }
  TdaADODataSet = class(TdaDataSet)
    private
      FQuery: TADOQuery;
      FADOConnection: TADOConnection;

      function GetQuery: TADOQuery;

    protected
      procedure BuildFieldList; override;
      function  GetActive: Boolean; override;
      procedure SetActive(Value: Boolean); override;
      procedure SetDatabase(aDatabase: TComponent); override;
      procedure SetDataName(const aDataName: String); override;

      property Query: TADOQuery read GetQuery;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function ClassDescription: String; override;

      procedure GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings); override;
      procedure GetFieldsForSQL(aList: TList; aSQL: TStrings); override;

  end; {class, TdaADODataSet}


  { TdaADOQueryDataView }
  TdaADOQueryDataView = class(TdaQueryDataView)
    private
      FDataSource: TppChildDataSource;
      FQuery: TdaChildADOQuery;

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
      property DataSource: TppChildDataSource read FDataSource;

  end; {class, TdaADOQueryDataView}

  { TdaADOTemplateDataView }
  TdaADOTemplateDataView = class(TdaQueryDataView)
    private
      FADOConnection: TADOConnection;

    protected
      procedure SetADOConnection(const Value: TADOConnection); virtual;

    public
      {defines ADOSession as the session class}
      class function SessionClass: TClass; override;
      class function DataDesignerClass: TClass; override;

      {returns True}
      class function IsTemplate: Boolean; override;

      {descendants should call these to create data access objects}
      function CreateQuery: TADOQuery; virtual;
      function CreateTable: TADOTable; virtual;
      function CreateStoredProc: TADOStoredProc; virtual;
      function CreateDataSource: TDataSource; virtual;
      function CreateDataPipeline: TppDBPipeline; virtual;
      function GetADOConnection: TADOConnection; virtual;

      function IsLinkable: Boolean; override;
      
      property ADOConnection: TADOConnection read FADOConnection write SetADOConnection;

    published
      property Report;

  end; {class, TdaADOTemplateDataView}

  { TdaADOStoredProcTemplateDataView }
  TdaADOStoredProcTemplateDataView = class(TdaADOTemplateDataView)
    private
      FDataPipeline: TppDBPipeline;
      FDataSource: TDataSource;
      FStoredProc: TADOStoredProc;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure ConnectPipelinesToData; override;
      procedure CreateDataPipelines; override;
      procedure CreatePipelineFields(aDataPipeline: TppDataPipeline); override;
      procedure Init; override;
    published
      property DataPipeline: TppDBPipeline read FDataPipeline write FDataPipeline;
      property DataSource: TDataSource read FDataSource;
      property StoredProc: TADOStoredProc read FStoredProc;

  end; {class, TdaADOStoredProcTemplateDataView}


  {Delphi design time registration}
  procedure Register;


implementation

uses
  Variants,
  ppUtils;

const
  cDefaultConnection = 'DefaultADOConnection';

var
  uADOConnection: TADOConnection;


{******************************************************************************
 *
 ** R E G I S T E R
 *
{******************************************************************************}

procedure Register;
begin

  {ADO DataAccess Components}
  RegisterNoIcon([TdaChildADOQuery, TdaChildADOTable, TdaChildADOStoredProc]);

  {ADO DataViews}
  RegisterNoIcon([TdaADOQueryDataView]);

end;


{******************************************************************************
 *
 ** C H I L D   A D O  D A T A   A C C E S S   C O M P O N  E N T S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaChildADOQuery.HasParent }

function TdaChildADOQuery.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TdaChildADOQuery.SetConnection }

procedure TdaChildADOQuery.SetConnection(const Value: TADOConnection);
begin

  inherited SetConnection(Value);

  if Value <> nil then
    CommandTimeOut := Value.CommandTimeOut;

end; {procedure, SetConnection}

{------------------------------------------------------------------------------}
{ TdaChildADOTable.HasParent }

function TdaChildADOTable.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TdaChildADOTable.SetConnection }

procedure TdaChildADOTable.SetConnection(const Value: TADOConnection);
begin

  inherited SetConnection(Value);

  if Value <> nil then
    CommandTimeOut := Value.CommandTimeOut;

end; {procedure, SetConnection}

{------------------------------------------------------------------------------}
{ TdaChildADOStoredProc.HasParent }

function TdaChildADOStoredProc.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TdaChildADOStoredProc.SetConnection }

procedure TdaChildADOStoredProc.SetConnection(const Value: TADOConnection);
begin

  inherited SetConnection(Value);

  if Value <> nil then
    CommandTimeOut := Value.CommandTimeOut;

end; {procedure, SetConnection}


{******************************************************************************
 *
 ** A D O  S E S S I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaADOSession.ClassDescription }

class function TdaADOSession.ClassDescription: String;
begin
  Result := 'ADOSession';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaADOSession.DataSetClass }

class function TdaADOSession.DataSetClass: TdaDataSetClass;
begin
  Result := TdaADODataSet;
end; {class function, DataSetClass}

{------------------------------------------------------------------------------}
{ TdaADOSession.DatabaseClass }

class function TdaADOSession.DatabaseClass: TComponentClass;
begin
  Result := TADOConnection;
end;

{------------------------------------------------------------------------------}
{ TdaADOSession.GetDefaultADOConnection }

class function TdaADOSession.GetDefaultADOConnection: TADOConnection;
begin

  {create the default ADO Connection, if needed}
  if (uADOConnection = nil) then
    begin
      {create default ADO Connection}
      uADOConnection := TADOConnection.Create(nil);
      uADOConnection.Name := cDefaultConnection;

    end;

  Result := uADOConnection;

end; {function, GetDefaultADOConnection}

{------------------------------------------------------------------------------}
{ TdaADOSession.GetTableNames }

procedure TdaADOSession.GetTableNames(const aDatabaseName: String; aList: TStrings);
var
  lConnection: TADOConnection;
begin

  {get the connection}
  lConnection := TADOConnection(GetDatabaseForName(aDatabaseName));

  {connection must be active to get table names}
  if not lConnection.Connected then
    lConnection.Connected := True;

  // no longer used
//  lConnection.GetTableNamesForConnection(aList, False);

  // custom version to get items in the format of table_schema.table_name
  GetTableNamesForConnection(lConnection, aList);

end; 

{------------------------------------------------------------------------------}
{ TdaADOSession.GetTableNamesForConnection }

procedure TdaADOSession.GetTableNamesForConnection(const aConnection: TADOConnection; aList: TStrings);
var
  lTypeField,
  lNameField: TField;
  lSchemaField: TField;
  lsTableType: String;
  lDataSet: TADODataSet;
begin


  // custom version to get items in the format of table_schema.table_name
  lDataSet := TADODataSet.Create(nil);

  try
    aConnection.OpenSchema(siTables, EmptyParam, EmptyParam, lDataSet);

    lTypeField := lDataSet.FieldByName('TABLE_TYPE'); { do not localize }
    lNameField := lDataSet.FieldByName('TABLE_NAME'); { do not localize }
    lSchemaField := lDataSet.FieldByName('TABLE_SCHEMA'); { do not localize }

    aList.BeginUpdate;

    try
      aList.Clear;

      while not lDataSet.EOF do
      begin

        lsTableType := lTypeField.AsString;

        // add item: table_schema.table_name
        if (lsTableType = 'TABLE') or (lsTableType = 'VIEW') then { do not localize }
          aList.Add(lSchemaField.AsString + '.' + lNameField.AsString);

        lDataSet.Next;

      end;

    finally
      aList.EndUpdate;

    end;

  finally
    lDataSet.Free;
  end;


end;


{------------------------------------------------------------------------------}
{ TdaADOSession.GetDatabaseNames }

procedure TdaADOSession.GetDatabaseNames(aList: TStrings);
begin

  {call inherited to build list of available TADOConnection components}
  inherited GetDatabaseNames(aList);

  {could add hard-coded connection strings here, or could
   read from an .ini file }

end; {procedure, GetDatabaseNames}

{------------------------------------------------------------------------------}
{ TdaADOSession.GetDefaultDatabase }

function TdaADOSession.GetDefaultDatabase(const aDatabaseName: String): TComponent;
var
  lADOConnection: TADOConnection;
begin

  lADOConnection := GetDefaultADOConnection;

  {set ConnectionString property, if needed}
  if (lADOConnection.ConnectionString <> aDatabaseName) then
    begin
      if lADOConnection.Connected then
        lADOConnection.Connected := False;
      lADOConnection.ConnectionString := aDatabaseName;

    end;

  Result := lADOConnection;

end; {function, GetDefaultDatabase}

{------------------------------------------------------------------------------}
{ TdaADOSession.IsNamedDatabase }

function TdaADOSession.IsNamedDatabase(const aDatabaseName: String; aDatabase: TComponent): Boolean;
begin

  Result := (AnsiCompareText(aDatabase.Name, aDatabaseName) = 0) or
            (AnsiCompareText(TADOConnection(aDatabase).ConnectionString, aDatabaseName) = 0);

end; {function, IsNamedDatabase}


{------------------------------------------------------------------------------}
{ TdaADOSession.ValidDatabaseTypes }

function TdaADOSession.ValidDatabaseTypes: TppDatabaseTypes;
begin
  {although Sybase and Oracle ran into trouble during testing of ADO, perhaps future ADO drivers will work}
  Result := [dtMSAccess, dtMSSQLServer, dtSybaseASA, dtSybaseASE, dtOracle, dtPostgreSQL, dtOther];
end; {procedure, ValidDatabaseTypes}

{------------------------------------------------------------------------------}
{ TdaADOSession.GetDatabaseType }

function TdaADOSession.GetDatabaseType(const aDatabaseName: String): TppDatabaseType;
begin
  {we're guessing here until we can figure out how to convert an ADO string to a database type}
  Result := dtMSAccess;
end; {function, GetDatabaseType}



{******************************************************************************
 *
 ** A D O   D A T A S E T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaADODataSet.Create }

constructor TdaADODataSet.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FQuery := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaADODataSet.Destroy }

destructor TdaADODataSet.Destroy;
begin

  FQuery.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaADODataSet.ClassDescription }

class function TdaADODataSet.ClassDescription: String;
begin
  Result := 'ADODataSet';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaADODataSet.GetActive }

function TdaADODataSet.GetActive: Boolean;
begin
  Result := GetQuery.Active
end; {function, GetActive}

{------------------------------------------------------------------------------}
{ TdaADODataSet.SetActive }

procedure TdaADODataSet.SetActive(Value: Boolean);
begin
  GetQuery.Active := Value;
end; {procedure, SetActive}

{------------------------------------------------------------------------------}
{ TdaADODataSet.GetQuery }

function TdaADODataSet.GetQuery: TADOQuery;
begin

  {create ADO table, if needed}
  if (FQuery = nil) then
    FQuery := TdaChildADOQuery.Create(Self);

  Result := FQuery;

end; {procedure, GetQuery}

{------------------------------------------------------------------------------}
{ TdaADODataSet.SetDatabase }

procedure TdaADODataSet.SetDatabase(aDatabase: TComponent);
begin

  inherited SetDatabase(aDatabase);

  {table cannot be active to set database property}
  if GetQuery.Active then
    FQuery.Active := False;

  FADOConnection := TADOConnection(aDatabase);

  {set ADOQuery.Connection}
  FQuery.Connection := FADOConnection;

end; {procedure, SetDatabase}

{------------------------------------------------------------------------------}
{ TdaADODataSet.SetDataName }

procedure TdaADODataSet.SetDataName(const aDataName: String);
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
{ TdaADODataSet.BuildFieldList }

procedure TdaADODataSet.BuildFieldList;
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
{ TdaADODataSet.GetFieldNamesForSQL }

procedure TdaADODataSet.GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings);
var
  lQuery: TADOQuery;
{$IFDEF Delphi10}
  lWideStrings: TWideStringList;
{$ENDIF}
begin
  aList.Clear;

  {create a temporary ADO query}
  lQuery := TADOQuery.Create(Self);

  {set the database and SQL properties}
  lQuery.Connection := FADOConnection;
  lQuery.SQL.Assign(aSQL); // assign TStrings to TWideStrings

  {get the field names}
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
{ TdaADODataSet.GetFieldsForSQL }

procedure TdaADODataSet.GetFieldsForSQL(aList: TList; aSQL: TStrings);
var
  lQuery: TADOQuery;
  lQueryField: TField;
  lField: TppField;
  liIndex: Integer;
begin
  aList.Clear;

  {create a temporary ADO query}
  lQuery := TADOQuery.Create(Self);

  try

    {assign databae and SQL properties}
    lQuery.Connection := FADOConnection;
    lQuery.SQL.Assign(aSQL); // assign TStrings to TWideStrings

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
 ** A D O  Q U E R Y   D A T A V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaADOQueryDataView.Create }

constructor TdaADOQueryDataView.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  {notes: 1. must use ChildQuery, ChildDataSource, ChildPipeline etc.
          2. use Self as owner for Query, DataSource etc.
          3. do NOT assign a Name }

  FQuery := TdaChildADOQuery.Create(Self);

  FDataSource := TppChildDataSource.Create(Self);
  FDataSource.DataSet := FQuery;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaADOQueryDataView.Destroy }

destructor TdaADOQueryDataView.Destroy;
begin

  FDataSource.Free;
  FQuery.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaADOQueryDataView.SessionClass }

class function TdaADOQueryDataView.SessionClass: TClass;
begin
  Result := TdaADOSession;
end; {class function, SessionClass}

{------------------------------------------------------------------------------}
{ TdaADOQueryDataView.PreviewFormClass }

class function TdaADOQueryDataView.PreviewFormClass: TFormClass;
begin
  Result := TFormClass(GetClass('TdaPreviewDataDialog'));
end; {class function, PreviewFormClass}

{------------------------------------------------------------------------------}
{ TdaADOQueryDataView.ConnectPipelinesToData }

procedure TdaADOQueryDataView.ConnectPipelinesToData;
begin

  if DataPipelineCount = 0 then Exit;

  {need to reconnect here}
  TppDBPipeline(DataPipelines[0]).DataSource := FDataSource;

end; {procedure, ConnectPipelinesToData}

{------------------------------------------------------------------------------}
{ TdaADOQueryDataView.Init }

procedure TdaADOQueryDataView.Init;
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
{ TdaADOQueryDataView.SQLChanged }

procedure TdaADOQueryDataView.SQLChanged;
var
  lDatabase: TComponent;
begin

  if FQuery.Active then
    FQuery.Close;

  lDatabase := Session.GetDatabaseForName(SQL.DatabaseName);

  if (lDatabase = nil) then
    raise EDataError.Create('TdaADOQueryDataView.SQLChanged: No ADOConnection object found, ' + SQL.DatabaseName);

  FQuery.Connection := TADOConnection(lDatabase);
  FQuery.SQL.Assign(SQL.MagicSQLText); // assign TStrings to TWideStrings

end; {procedure, SQLChanged}

{******************************************************************************
 *
 ** A D O  T E M P L A T E   D A T A V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaADOTemplateDataView.CreateDataPipeline }

function TdaADOTemplateDataView.CreateDataPipeline: TppDBPipeline;
begin
  {note: DataView's owner must own the DataPipeline }
  Result := TppChildDBPipeline.Create(Self);
  Result.Name := Result.GetValidName(Result);

  {add pipeline to the dataview's Pipelines[] array}
  Result.DataView := Self;

end; {procedure, CreateDataPipeline}

{------------------------------------------------------------------------------}
{ TdaADOTemplateDataView.CreateDataSource }

function TdaADOTemplateDataView.CreateDataSource: TDataSource;
begin
  Result := TppChildDataSource.Create(Self);

end; {procedure, CreateDataSource}

{------------------------------------------------------------------------------}
{ TdaADOTemplateDataView.CreateQuery }

function TdaADOTemplateDataView.CreateQuery: TADOQuery;
begin
  Result := TdaChildADOQuery.Create(Self);
  Result.Connection := GetADOConnection;

end; {procedure, CreateQuery}

{------------------------------------------------------------------------------}
{ TdaADOTemplateDataView.CreateStoredProc }

function TdaADOTemplateDataView.CreateStoredProc: TADOStoredProc;
begin
  Result := TdaChildADOStoredProc.Create(Self);
  Result.Connection := GetADOConnection;

end; {procedure, CreateStoredProc}

{------------------------------------------------------------------------------}
{ TdaADOTemplateDataView.CreateTable }

function TdaADOTemplateDataView.CreateTable: TADOTable;
begin
  Result := TdaChildADOTable.Create(Self);
  Result.Connection := GetADOConnection;

end; {procedure, CreateTable}

{------------------------------------------------------------------------------}
{ TdaADOTemplateDataView.DataDesignerClass }

class function TdaADOTemplateDataView.DataDesignerClass: TClass;
begin
  {Should be overriden in a descendent class}
  Result := nil;

end; {class function, DataDesignerClass}

{------------------------------------------------------------------------------}
{ TdaADOTemplateDataView.GetADOConnection }

function TdaADOTemplateDataView.GetADOConnection: TADOConnection;
begin
  {Should be overriden in a descendent class}
  Result := nil;

end;

{------------------------------------------------------------------------------}
{ TdaADOTemplateDataView.IsLinkable }

function TdaADOTemplateDataView.IsLinkable: Boolean;
begin
  {ADOTemplateDataView dataview is not linkable}
  Result := False;
  
end; {function, IsLinkable}

{------------------------------------------------------------------------------}
{ TdaADOTemplateDataView.IsTemplate }

class function TdaADOTemplateDataView.IsTemplate: Boolean;
begin
  Result := True;

end; {function, IsTemplate}

{------------------------------------------------------------------------------}
{ TdaADOTemplateDataView.SessionClass }

class function TdaADOTemplateDataView.SessionClass: TClass;
begin
  Result := TdaADOSession;

end; {class function, SessionClass}

procedure TdaADOTemplateDataView.SetADOConnection(const Value: TADOConnection);
begin
  FADOConnection := Value;

end;

{******************************************************************************
 *
 ** Stored Procedure Template DataView
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaADOStoredProcTemplateDataView.Create }

constructor TdaADOStoredProcTemplateDataView.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  {call CreateStoredProc method defined in the ancestor }
  FStoredProc := CreateStoredProc;

  {call CreateDataSource method defined in the ancestor }
  FDataSource := CreateDataSource;
  FDataSource.DataSet := FStoredProc;

  FDataPipeline := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaADOStoredProcTemplateDataView.Destroy }

destructor TdaADOStoredProcTemplateDataView.Destroy;
begin

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaADOStoredProcTemplateDataView.ConnectPipelinesToData }

procedure TdaADOStoredProcTemplateDataView.ConnectPipelinesToData;
begin
  if (FDatapipeline = nil) then Exit;

  {connect datapipeline to datasource here}
  FDatapipeline.DataSource := FDataSource;

end; {procedure, ConnectPipelinesToData}

{------------------------------------------------------------------------------}
{ TdaADOStoredProcTemplateDataView.CreateDataPipelines }

procedure TdaADOStoredProcTemplateDataView.CreateDataPipelines;
begin
  if FDataPipeline <> nil then  Exit;

  {note: call CreateDataPipeline defined in ancestor }
  FDataPipeline := CreateDataPipeline;
  FDataPipeline.UserName := ppTextToIdentifier(ClassDescription);
  FDataPipeline.Name := FDataPipeline.UserName;

  {this gets displayed as the toolwindow caption}
  SQL.DataPipelineName := FDataPipeline.UserName;

  UserName := 'StoredProc_' + FDataPipeline.Name;

end; {procedure, CreateDataPipelines}

{------------------------------------------------------------------------------}
{ TdaADOStoredProcTemplateDataView.CreatePipelineFields }

procedure TdaADOStoredProcTemplateDataView.CreatePipelineFields(aDataPipeline: TppDataPipeline);
begin
  if (FDataPipeline = aDataPipeline) then
    TppDBPipeline(aDataPipeline).AutoCreateFields := True;

end; {procedure, CreatePipelineFields}

{------------------------------------------------------------------------------}
{ TdaADOStoredProcTemplateDataView.Init }

procedure TdaADOStoredProcTemplateDataView.Init;
var
  liIndex: Integer;
begin

  inherited Init;

  if (DataPipelineCount > 0) then Exit;

  CreateDataPipelines;
  ConnectPipelinesToData;

  for liIndex := 0 to DataPipelineCount-1 do
    CreatePipelineFields(DataPipelines[liIndex]);

end; {procedure, Init}


initialization

  {register the ADO descendant classes}
  RegisterClasses([TdaChildADOQuery, TdaChildADOTable, TdaChildADOStoredProc]);

  {register DADE descendant session, dataset, dataview}
  daRegisterSession(TdaADOSession);
  daRegisterDataSet(TdaADODataSet);
  daRegisterDataView(TdaADOQueryDataView);

  {initialize internal reference variables}
  uADOConnection := nil;


finalization

  {free the default connection object}
  uADOConnection.Free;
  uADOConnection := nil;

  {unregister the ADO descendant classes}
  UnRegisterClasses([TdaChildADOQuery, TdaChildADOTable, TdaChildADOStoredProc]);

  {unregister DADE descendant the session, dataset, dataview}
  daUnRegisterSession(TdaADOSession);
  daUnRegisterDataSet(TdaADODataSet);
  daUnRegisterDataView(TdaADOQueryDataView);


end.
