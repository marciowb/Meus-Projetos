{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit daDBBDE;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi10} WideStrings,{$ENDIF}
  Windows,
  Classes, SysUtils, Forms, ExtCtrls, DB, DBTables,
  ppComm, ppClass, ppDBPipe, ppDB, ppDBBDE, ppClasUt, ppUtils, ppTypes,
  daDB, daQueryDataView, daDataView, daPreviewDataDlg, daSQL,
  ppDsIntf;

type

  {BDE Dependent DataView Classes:

     1.  BDE TDataSet descendants
           - TDataSets that can be children of a DataView.
           - Override the HasParent method of TComponent to return True
           - Must be registerd with the Delphi IDE using the RegisterNoIcon procedure

       a. TdaChildBDEQuery - TQuery descendant that can be a child of a DataView
       b. TdaChildBDETable - TTable descendant that can be a child of a DataView
       c. TdaChildBDEStoredProc - TStoredProc descendant that can be a child of a DataView


     2.  TdaBDESession
           - descendant of TppSession
           - implements GetDatabaseNames, GetTableNames, etc.

     3.  TdaBDEDataSet
          - descendant of TppDataSet
          - implements GetFieldNames for SQL

     4.  TdaBDEQueryDataView
          - descendant of TppQueryDataView
          - uses the above classes to create the required
            Query -> DataSource -> Pipeline -> Report connection
          - uses the SQL built by the QueryWizard to assign
            SQL to the TQuery etc.

      }

  { TdaChildBDEQuery }
  TdaChildBDEQuery = class(TQuery)
    public
      function HasParent: Boolean; override;
  end;  {class, TdaChildBDEQuery}

  { TdaChildBDETable }
  TdaChildBDETable = class(TTable)
    public
      function HasParent: Boolean; override;
  end;  {class, TdaChildBDETable}

  { TdaChildBDEStoredProc }
  TdaChildBDEStoredProc = class(TStoredProc)
    public
      function HasParent: Boolean; override;
  end;  {class, TdaChildBDEStoredProc}


  { TdaBDESession }
  TdaBDESession = class(TdaSession)
    private
      function GetAliasDriverName(const aAlias: String): String;
      function IsInterBase(const aDriverName: String): Boolean;
      function IsMSAccess(const aDriverName: String): Boolean;
      function IsMSSQLServer(const aDriverName: String): Boolean;
      function IsOracle(const aDriverName: String): Boolean;
      function IsParadox(const aDriverName: String): Boolean;
      function IsSybaseASA(const aDriverName: String): Boolean;
      function IsSybaseASE(const aDriverName: String): Boolean;

    protected
      function GetDefaultDatabase(const aDatabaseName: String): TComponent; override;
      function IsNamedDatabase(const aDatabaseName: String; aDatabase: TComponent): Boolean; override;

    public
      class function ClassDescription: String; override;
      class function DataSetClass: TdaDataSetClass; override;
      class function DatabaseClass: TComponentClass; override;
      class function GetBDESessionForDatabase(aDatabase: TDatabase): TSession;
      class function GetDefaultBDEDatabase: TDatabase;

      procedure GetDatabaseNames(aList: TStrings); override;
      function  GetDatabaseType(const aDatabaseName: String): TppDatabaseType; override;
      function GetMaxFieldAliasLength(aTableName: String): Integer; override;
      procedure GetTableNames(const aDatabaseName: String; aList: TStrings); override;
      function  ValidDatabaseTypes: TppDatabaseTypes; override;

  end; {class, TdaBDESession}


  { TdaBDEDataSet }
  TdaBDEDataSet = class(TdaDataSet)
    private
      FDatabase: TDatabase;
      FQuery: TQuery;

      function GetQuery: TQuery;

    protected
      procedure BuildFieldList; override;
      function  GetActive: Boolean; override;
      procedure SetActive(Value: Boolean); override;
      procedure SetDatabase(aDatabase: TComponent); override;
      procedure SetDataName(const aDataName: String); override;

      property Query: TQuery read GetQuery;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function ClassDescription: String; override;

      procedure GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings); override;
      procedure GetFieldsForSQL(aList: TList; aSQL: TStrings); override;
  end; {class, TdaBDEDataSet}


  { TdaBDEQueryDataView }
  TdaBDEQueryDataView = class(TdaQueryDataView)
    private
      FDataSource: TppChildDataSource;
      FQuery: TdaChildBDEQuery;

    protected
      property Query: TdaChildBDEQuery read FQuery;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function SessionClass: TClass; override;

      procedure Init; override;
      procedure ConnectPipelinesToData; override;

      procedure SQLChanged; override;

    published
      property DataSource: TppChildDataSource read FDataSource;

  end; {class, TdaBDEQueryDataView}




  { TdaBDETemplateDataView }
  TdaBDETemplateDataView = class(TdaQueryDataView)
    private
      FDatabaseName: String;

    protected
      procedure SetDatabaseName(aDatabaseName: String); virtual;

    public
      {defines BDESession as the session class}
      class function SessionClass: TClass; override;
      class function DataDesignerClass: TClass; override;

      {returns True}
      class function IsTemplate: Boolean; override;

      {descendants should call these to create data access objects}
      function CreateQuery: TQuery; virtual;
      function CreateTable(aTableName: String): TTable; virtual;
      function CreateStoredProc(aStoredProcName: String): TStoredProc; virtual;
      function CreateDataSource: TDataSource; virtual;
      function CreateDataPipeline: TppBDEPipeline; virtual;
      function CreatePipelineField(aTableName, aFieldName, aFieldAlias: String;
                             aDataPipeline: TppDataPipeline; aSearchable, aSortable: Boolean): TppField; virtual;

      function GetBDEDatabase: TDatabase;
      function GetBDEDatabaseName: String;
      function GetBDESessionName: String;

      function IsLinkable: Boolean; override;


      property DatabaseName: String read FDatabaseName write SetDatabaseName;

    published

      property Report;

  end; {class, TdaBDETemplateDataView}


  { TdaBDEQueryTemplateDataView }
  TdaBDEQueryTemplateDataView = class(TdaBDETemplateDataView)
    private
      FQuery: TQuery;
      FDataSource: TDataSource;
      FDataPipeline: TppBDEPipeline;

      function DuplicateFieldNames: Boolean;
      procedure UpdateFieldNamesFromSQL;
      
    protected
      procedure SetDatabaseName(aDatabaseName: String); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure CreateDataPipelines; override;
      procedure CreatePipelineFields(aDataPipeline: TppDataPipeline); override;

      procedure ConnectPipelinesToData; override;
      procedure DefineDataSelection; override;

      procedure Init; override;

      function  AddSelectTable(aTableName: String): TdaTable;
      function  AddSelectField(aTable: TdaTable; aFieldName, aFieldAlias: String; aSearchable, aSortable: Boolean): TdaField;
      procedure DefineSelectedFields; virtual;
      procedure DefineCalculatedFields; virtual;
      procedure DefineSelectionCriteria; virtual;
      procedure DefineSortOrder; virtual;

      procedure BuildSQL;
      procedure SQLChanged; override;

    published
      property DataPipeline: TppBDEPipeline read FDataPipeline write FDataPipeline;
      property Query: TQuery read FQuery;
      property DataSource: TDataSource read FDataSource;

  end; {class, TdaBDEQueryTemplateDataView}

  procedure Register;

implementation

uses
  SyncObjs;

const
  cDefaultConnection = 'DefaultBDEDatabase';

var
  uBDEDatabase: TDatabase;

{******************************************************************************
 *
 ** C H I L D   B D E  D A T A   A C C E S S   C O M P O N E N T S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaChildBDEQuery.HasParent }

function TdaChildBDEQuery.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TdaChildBDETable.HasParent }

function TdaChildBDETable.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}


{------------------------------------------------------------------------------}
{ TdaChildBDEStoredProc.HasParent }

function TdaChildBDEStoredProc.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}


{******************************************************************************
 *
 ** B D E   S E S S I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaBDESession.ClassDescription }

class function TdaBDESession.ClassDescription: String;
begin
  Result := 'BDESession';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaBDESession.DataSetClass }

class function TdaBDESession.DataSetClass: TdaDataSetClass;
begin
  Result := TdaBDEDataSet;
end; {class function, DataSetClass}

{------------------------------------------------------------------------------}
{ TdaBDESession.DatabaseClass }

class function TdaBDESession.DatabaseClass: TComponentClass;
begin
  Result := TDatabase;
end; {class function, DatabaseClass}

{------------------------------------------------------------------------------}
{ TdaBDESession.GetBDESessionForDatabase }

class function TdaBDESession.GetBDESessionForDatabase(aDatabase: TDatabase): TSession;
begin

  {note: 1. Sessions is thread-safe

         2. Use Sessions.FindSession rather than reference TDatabase.Session because
         TDatabase.Session is unreliable when csLoading}
  if (aDatabase <> nil) then
    Result := Sessions.FindSession(aDatabase.SessionName)
  else
    Result := nil;

  if (Result = nil) then
    Result := Session;

  {cannot used the default Session object for multi-threaded applications}
  if not(ppInMainThread) then
    if (Result = Session) then
      raise EDataError.Create('TdaBDESession.GetBDESessionForDatabase: Cannot use the default Session for mult-threaded applications.')
    else if not(Result.AutoSessionName) then
      raise EDataError.Create('TdaBDESession.GetBDESessionForDatabase: Invalid Session, Session.AutoSessionName must be set to True.');


end; {class function, GetBDESessionForDatabase}

{------------------------------------------------------------------------------}
{ TdaBDESession.GetDefaultBDEDatabase }

class function TdaBDESession.GetDefaultBDEDatabase: TDatabase;
begin

  {create the default BDE Database, if needed}
  if (uBDEDatabase = nil) then
    begin
      {create default BDE Database}
      uBDEDatabase      := TDatabase.Create(nil);
      uBDEDatabase.Name := cDefaultConnection;

    end;

  Result := uBDEDatabase;

end; {class function, GetDefaultBDEDatabase}

{------------------------------------------------------------------------------}
{ TdaBDESession.GetTableNames }

procedure TdaBDESession.GetTableNames(const aDatabaseName: String; aList: TStrings);
var
  lSession: TSession;
  lDatabase: TDatabase;
begin

  if (aDatabaseName = '') then
    if not(ppInMainThread) then
      raise EDataError.Create('No DatabaseName specified.  A separate database connection is required for each thread.')
    else
      raise EDataError.Create('No DatabaseName specified.');

  lDatabase := TDatabase(GetDatabaseForName(aDatabaseName));

  if (lDatabase = nil) then
    raise EDataError.Create('No TDatabase object found for database name: ' + aDatabaseName);

  lSession := GetBDESessionForDatabase(lDatabase);

  if (lSession = nil) then
    raise EDataError.Create('No TSession object found for database name: ' + aDatabaseName);


  lSession.GetTableNames(lDatabase.DatabaseName, '*.*', True, False, aList);

end; {procedure, GetTableNames}

{------------------------------------------------------------------------------}
{ TdaBDESession.GetDatabaseNames }

procedure TdaBDESession.GetDatabaseNames(aList: TStrings);
var
  lList: TStringList;
begin

  {call inherited to build list of available TDatabase objects}
  inherited GetDatabaseNames(aList);

  lList := TStringList.Create;

  try

    {add BDE alias names to the list}
    Session.GetAliasNames(lList);

    aList.AddStrings(lList);

  finally
    lList.Free;

  end;

end; {procedure, GetDatabaseNames}

{------------------------------------------------------------------------------}
{ TdaBDESession.GetDefaultDatabase }

function TdaBDESession.GetDefaultDatabase(const aDatabaseName: String): TComponent;
var
  lBDEDatabase: TDatabase;
begin

  {the default session may have created a default database}
  Result := Session.FindDatabase(aDatabaseName);

  if (Result = nil) then
    begin

      lBDEDatabase := GetDefaultBDEDatabase;

      {set DatabaseName property, if needed}
      if (lBDEDatabase.DatabaseName <> aDatabaseName) then
        begin
          if lBDEDatabase.Connected then
            lBDEDatabase.Connected := False;

          lBDEDatabase.DatabaseName := aDatabaseName;

        end;

      Result := lBDEDatabase;

    end;

end; {function, GetDefaultDatabase}

{------------------------------------------------------------------------------}
{ TdaBDESession.IsNamedDatabase }

function TdaBDESession.IsNamedDatabase(const aDatabaseName: String; aDatabase: TComponent): Boolean;
var
  lDatabase: TDatabase;
begin

  lDatabase := TDatabase(aDatabase);

  Result := (AnsiCompareText(lDatabase.DatabaseName, aDatabaseName) = 0) or
            (AnsiCompareText(lDatabase.Name, aDatabaseName) = 0) or
            (AnsiCompareText(lDatabase.AliasName, aDatabaseName) = 0);

end; {function, IsNamedDatabase}

{------------------------------------------------------------------------------}
{ TdaBDESession.ValidDatabaseTypes }

function TdaBDESession.ValidDatabaseTypes: TppDatabaseTypes;
begin
  Result := [dtParadox, dtInterBase, dtMSAccess, dtMSSQLServer, dtSybaseASA, dtSybaseASE, dtOracle, dtOther];
end; {procedure, ValidDatabaseTypes}

{------------------------------------------------------------------------------}
{ TdaBDESession.GetDatabaseType }

function TdaBDESession.GetDatabaseType(const aDatabaseName: String): TppDatabaseType;
var
  lsDriverName: String;
begin

  lsDriverName := GetAliasDriverName(aDatabaseName);

  if IsParadox(lsDriverName) then
    Result := dtParadox

  else if IsInterBase(lsDriverName) then
    Result := dtInterBase

  else if IsMSAccess(lsDriverName) then
    Result := dtMSAccess

  else if IsMSSQLServer(lsDriverName) then
    Result := dtMSSQLServer

  else if IsSybaseASA(lsDriverName) then
    Result := dtSybaseASA

  else if IsSybaseASE(lsDriverName) then
    Result := dtSybaseASE

  else if IsOracle(lsDriverName) then
    Result := dtOracle

  else
    Result := dtOther;

end; {function, GetDatabaseType}

{------------------------------------------------------------------------------}
{ TdaBDESession.IsMSSQLServer }

function TdaBDESession.IsMSSQLServer(const aDriverName: String): Boolean;
var
  lsDriverName: String;
begin

  lsDriverName := Uppercase(aDriverName);

  Result := (Pos('SQL', lsDriverName) > 0);

  if (Result) then
    Result := (Pos('SERVER', lsDriverName) > 0);

end; {procedure, IsMSSQLServer}

{------------------------------------------------------------------------------}
{ TdaBDESession.IsSybaseASE }

function TdaBDESession.IsSybaseASE(const aDriverName: String): Boolean;
var
  lsDriverName: String;
begin

  lsDriverName := Uppercase(aDriverName);

  Result := (Pos('SYBASE', lsDriverName) > 0);

  if (Result) then
    Result := not(IsSybaseASA(aDriverName));

end; {procedure, IsSybaseASE}

{------------------------------------------------------------------------------}
{ TdaBDESession.IsSybaseASA}

function TdaBDESession.IsSybaseASA(const aDriverName: String): Boolean;
var
  lsDriverName: String;
begin

  lsDriverName := Uppercase(aDriverName);

  Result := (Pos('SQL', lsDriverName) > 0) or (Pos('ADAPTIVE', lsDriverName) > 0);

  if (Result) then
    Result := (Pos('ANYWHERE', lsDriverName) > 0);

end; {procedure, IsSybaseASA}

{------------------------------------------------------------------------------}
{ TdaBDESession.IsInterBase }

function TdaBDESession.IsInterBase(const aDriverName: String): Boolean;
var
  lsDriverName: String;
begin

  lsDriverName := Uppercase(aDriverName);

  Result := (Pos('INTRBASE', lsDriverName) > 0);

  if not(Result) then
    Result := (Pos('INTERBASE', lsDriverName) > 0);

end; {procedure, IsInterBase}

{------------------------------------------------------------------------------}
{ TdaBDESession.IsMSAccess }

function TdaBDESession.IsMSAccess(const aDriverName: String): Boolean;
var
  lsDriverName: String;
begin

  lsDriverName := Uppercase(aDriverName);

  Result := (Pos('ACCESS', lsDriverName) > 0);

end; {procedure, IsMSAccess}

{------------------------------------------------------------------------------}
{ TdaBDESession.IsParadox }

function TdaBDESession.IsParadox(const aDriverName: String): Boolean;
var
  lsDriverName: String;
begin

  lsDriverName := Uppercase(aDriverName);

  Result := (Pos('STANDARD', lsDriverName) > 0);

end; {procedure, IsParadox}

{------------------------------------------------------------------------------}
{ TdaBDESession.IsOracle }

function TdaBDESession.IsOracle(const aDriverName: String): Boolean;
var
  lsDriverName: String;
begin

  lsDriverName := Uppercase(aDriverName);

  Result := (Pos('ORACLE', lsDriverName) > 0);

end; {procedure, IsOracle}

{------------------------------------------------------------------------------}
{ TdaBDESession.GetAliasDriverName }

function TdaBDESession.GetAliasDriverName(const aAlias: String): String;
var
  lDatabase: TDatabase;
  lSession: TSession;
  
begin

  Result := '';
  
  {try to get driver name from the session}
  if (aAlias <> '') and Session.IsAlias(aAlias) then
    Result := Session.GetAliasDriverName(aAlias)
  else
    begin

      {try to get the TDatabase object}
      lDatabase := TDatabase(GetDatabaseForName(aAlias));
      lSession  := GetBDESessionForDatabase(lDatabase);

      {return the drivername using Database.AliasName or Database.DriverName as appropriate}
      if lDatabase <> nil then
        if (lDatabase.AliasName <> '' ) and lSession.IsAlias(lDatabase.AliasName) then
          Result := lSession.GetAliasDriverName(lDatabase.AliasName)
        else
          Result := lDatabase.DriverName;

    end;


end; {function, GetAliasDriverName}

{------------------------------------------------------------------------------}
{ TdaBDESession.GetMaxFieldAliasLength }

function TdaBDESession.GetMaxFieldAliasLength(aTableName: String): Integer;
var
  lsExtension: String;
begin

  lsExtension := Copy(aTableName, Length(aTableName) - 2, 3);

  if (CompareText(lsExtension, 'DBF') = 0) then
    Result := 10
  else
    Result := 25

end; {function, GetMaxFieldAliasLength}



{******************************************************************************
 *
 ** B D E   D A T A S E T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaBDEDataSet.Create }

constructor TdaBDEDataSet.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FQuery := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaBDEDataSet.Destroy }

destructor TdaBDEDataSet.Destroy;
begin

  FQuery.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaBDEDataSet.ClassDescription }

class function TdaBDEDataSet.ClassDescription: String;
begin
  Result := 'BDEDataSet';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaBDEDataSet.GetActive }

function TdaBDEDataSet.GetActive: Boolean;
begin
  Result := GetQuery.Active
end; {function, GetActive}

{------------------------------------------------------------------------------}
{ TdaBDEDataSet.SetActive }

procedure TdaBDEDataSet.SetActive(Value: Boolean);
begin
  GetQuery.Active := Value;
end; {procedure, SetActive}

{------------------------------------------------------------------------------}
{ TdaBDEDataSet.GetQuery }

function TdaBDEDataSet.GetQuery: TQuery;
begin

  if (FQuery = nil) then
    FQuery := TQuery.Create(Self);

  Result := FQuery;

end; {procedure, GetQuery}

{------------------------------------------------------------------------------}
{ TdaBDEDataSet.SetDatabase }

procedure TdaBDEDataSet.SetDatabase(aDatabase: TComponent);
begin

  inherited SetDatabase(aDatabase);

  {table cannot be active to set database property}
  if GetQuery.Active then
    FQuery.Active := False;

  {set database name and session name}
  FDatabase := TDatabase(aDatabase);

  if (FDatabase <> nil) then
    begin
      FQuery.DatabaseName := FDatabase.DatabaseName;
      FQuery.SessionName  := FDatabase.SessionName;
    end;

end; {procedure, SetDatabase}

{------------------------------------------------------------------------------}
{ TdaBDEDataSet.SetDataName }

procedure TdaBDEDataSet.SetDataName(const aDataName: String);
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
{ TdaBDEDataSet.BuildFieldList }

procedure TdaBDEDataSet.BuildFieldList;
var
  liIndex: Integer;
  lBDEField: TField;
  lField: TppField;
begin

  inherited BuildFieldList;

  if not(GetQuery.Active) then
    FQuery.Active := True;

  for liIndex := 0 to FQuery.FieldCount - 1 do
    begin
      lBDEField := FQuery.Fields[liIndex];

      lField := TppField.Create(nil);

      lField.TableName := DataName;
      lField.FieldName := lBDEField.FieldName;
      lField.FieldAlias := lBDEField.DisplayLabel;
      lField.FieldLength := lBDEField.Size;
      lField.DataType := ppConvertFieldType(lBDEField.DataType);
      lField.DisplayWidth := lBDEField.DisplayWidth;

      AddField(lField);
    end;

end; {function, BuildFieldList}

{------------------------------------------------------------------------------}
{ TdaBDEDataSet.GetFieldNamesForSQL }

procedure TdaBDEDataSet.GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings);
var
  lQuery: TQuery;
{$IFDEF Delphi10}
  lWideStrings: TWideStringList;
{$ENDIF}
begin

  if (FDatabase = nil) then
    raise EDataError.Create('TdaBDEDataSet.GetFieldNamesForSQL: Database property is nil');


  aList.Clear;

  lQuery := TQuery.Create(Self);

  try

    lQuery.DatabaseName := FDatabase.DatabaseName;
    lQuery.SessionName  := FDatabase.SessionName;
    lQuery.SQL := aSQL;

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

  finally
    lQuery.Free;
    
  end;

end; {procedure, GetFieldNamesForSQL}

{------------------------------------------------------------------------------}
{ TdaBDEDataSet.GetFieldsForSQL }

procedure TdaBDEDataSet.GetFieldsForSQL(aList: TList; aSQL: TStrings);
var
  lQuery: TQuery;
  lBDEField: TField;
  lField: TppField;
  liIndex: Integer;
begin

  if (FDatabase = nil) then
    raise EDataError.Create('TdaBDEDataSet.GetFieldsForSQL: Database property is nil');

  aList.Clear;

  lQuery := TQuery.Create(Self);

  try

    lQuery.DatabaseName := FDatabase.DatabaseName;
    lQuery.SessionName  := FDatabase.SessionName;

    lQuery.SQL := aSQL;

    lQuery.Active := True;

    for liIndex := 0 to lQuery.FieldCount - 1 do
      begin
        lBDEField := lQuery.Fields[liIndex];

        lField := TppField.Create(nil);

        lField.FieldName := lBDEField.FieldName;
        lField.FieldAlias := lBDEField.DisplayLabel;
        lField.FieldLength := lBDEField.Size;
        lField.DataType := ppConvertFieldType(lBDEField.DataType);
        lField.DisplayWidth := lBDEField.DisplayWidth;

        aList.Add(lField);
      end;

  finally
    lQuery.Free;
    
  end;

end; {procedure, GetFieldsForSQL}


{******************************************************************************
 *
 ** B D E  Q U E R Y   D A T A V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaBDEQueryDataView.Create }

constructor TdaBDEQueryDataView.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  {notes: 1. must use ChildQuery, ChildDataSource, ChildPipeline etc.
          2. use Self as owner for Query, DataSource etc.
          3. do NOT assign a Name }

  FQuery := TdaChildBDEQuery.Create(Self);

  FDataSource := TppChildDataSource.Create(Self);

  FDataSource.DataSet := FQuery;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaBDEQueryDataView.Destroy }

destructor TdaBDEQueryDataView.Destroy;
begin
  FDataSource.Free;
  FQuery.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaBDEQueryDataView.SessionClass }

class function TdaBDEQueryDataView.SessionClass: TClass;
begin
  Result := TdaBDESession;
end; {class function, SessionClass}

{------------------------------------------------------------------------------}
{ TdaBDEQueryDataView.ConnectPipelinesToData }

procedure TdaBDEQueryDataView.ConnectPipelinesToData;
begin

  if DataPipelineCount = 0 then Exit;

  {need to reconnect here}
  TppDBPipeline(DataPipelines[0]).DataSource := FDataSource;

end; {procedure, ConnectPipelinesToData}

{------------------------------------------------------------------------------}
{ TdaBDEQueryDataView.Init }

procedure TdaBDEQueryDataView.Init;
var
  lDataPipeline: TppChildBDEPipeline;

begin

  inherited Init;

  if DataPipelineCount > 0 then Exit;

  {note: DataView owns the DataPipeline }
  lDataPipeline := TppChildBDEPipeline.Create(Self);

  lDataPipeline.DataSource := FDataSource;
 
  lDataPipeline.AutoCreateFields := False;

  {add DataPipeline to the dataview }
  lDataPipeline.DataView := Self;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TdaBDEQueryDataView.SQLChanged }

procedure TdaBDEQueryDataView.SQLChanged;
var
  lDatabase: TComponent;
begin

  if FQuery.Active then
    FQuery.Close;

  lDatabase := Session.GetDatabaseForName(SQL.DatabaseName);

  if (lDatabase = nil) then
    raise EDataError.Create('TdaBDEQueryDataView.SQLChanged: No Database object found, ' + SQL.DatabaseName);

  FQuery.DatabaseName := TDatabase(lDatabase).DatabaseName;
  FQuery.SessionName  := TDatabase(lDatabase).SessionName;

  FQuery.SQL := SQL.MagicSQLText;

end; {procedure, SQLChanged}


{******************************************************************************
 *
 ** B D E  T E M P L A T E  D A T A V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaBDETemplateDataView.DataDesignerClass }

class function TdaBDETemplateDataView.DataDesignerClass: TClass;
begin
  Result := nil;
end; {class function, DataDesignerClass}

{------------------------------------------------------------------------------}
{ TdaBDETemplateDataView.IsTemplate }

class function TdaBDETemplateDataView.IsTemplate: Boolean;
begin
  Result := True;
end; {function, IsTemplate}

{------------------------------------------------------------------------------}
{ TdaBDETemplateDataView.IsLinkable }

function TdaBDETemplateDataView.IsLinkable: Boolean;
begin
  {BDETemplateDataView dataview is not linkable}
  Result := False;
end; {function, IsLinkable}

{------------------------------------------------------------------------------}
{ TdaBDETemplateDataView.SessionClass }

class function TdaBDETemplateDataView.SessionClass: TClass;
begin
  Result := TdaBDESession;
end; {class function, SessionClass}

{------------------------------------------------------------------------------}
{ TdaBDETemplateDataView.SetDatabaseName }

procedure TdaBDETemplateDataView.SetDatabaseName(aDatabaseName: String);
begin
  FDatabaseName := aDatabaseName;

end; {procedure, SetDatabaseName}

{------------------------------------------------------------------------------}
{ TdaBDETemplateDataView.GetBDEDatabase }

function TdaBDETemplateDataView.GetBDEDatabase: TDatabase;
begin

  Result := TDatabase(Session.GetDatabaseForName(FDatabaseName));

end;

{------------------------------------------------------------------------------}
{ TdaBDETemplateDataView.GetBDEDatabaseName }

function TdaBDETemplateDataView.GetBDEDatabaseName: String;
var
  lDatabase: TDatabase;
begin

  lDatabase := GetBDEDatabase;

  if (lDatabase <> nil) then
    Result := lDatabase.DatabaseName
  else
    Result := '';

end;

{------------------------------------------------------------------------------}
{ TdaBDETemplateDataView.GetBDESessionName}

function TdaBDETemplateDataView.GetBDESessionName: String;
var
  lDatabase: TDatabase;
  lSession: TSession;
begin

  lDatabase := GetBDEDatabase;

  if (lDatabase <> nil) then
    lSession := TdaBDESession.GetBDESessionForDatabase(lDatabase)
  else
    lSession := nil;

  if (lSession <> nil) then
    Result := lSession.SessionName;

end;

{------------------------------------------------------------------------------}
{ TdaBDETemplateDataView.CreateQuery }

function TdaBDETemplateDataView.CreateQuery: TQuery;
begin

  Result := TdaChildBDEQuery.Create(Self);
  Result.DatabaseName := GetBDEDatabaseName;
  Result.SessionName  := GetBDESessionName;

end; {procedure, CreateQuery}

{------------------------------------------------------------------------------}
{ TdaBDETemplateDataView.CreateTable }

function TdaBDETemplateDataView.CreateTable(aTableName: String): TTable;
begin

  Result := TdaChildBDETable.Create(Self);
  Result.DatabaseName := GetBDEDatabaseName;
  Result.SessionName  := GetBDESessionName;

  Result.TableName := aTableName;


end; {procedure, CreateTable}

{------------------------------------------------------------------------------}
{ TdaBDETemplateDataView.CreateStoredProc }

function TdaBDETemplateDataView.CreateStoredProc(aStoredProcName: String): TStoredProc;
begin
  Result := TdaChildBDEStoredProc.Create(Self);
  Result.DatabaseName := GetBDEDatabaseName;
  Result.SessionName  := GetBDESessionName;

  Result.StoredProcName := aStoredProcName;


end; {procedure, CreateStoredProc}

{------------------------------------------------------------------------------}
{ TdaBDETemplateDataView.CreateDataSource }

function TdaBDETemplateDataView.CreateDataSource: TDataSource;
begin
  Result := TppChildDataSource.Create(Self);

end; {procedure, CreateDataSource}

{------------------------------------------------------------------------------}
{ TdaBDETemplateDataView.CreateDataPipeline }

function TdaBDETemplateDataView.CreateDataPipeline: TppBDEPipeline;
begin

  {note: DataView's owner must own the DataPipeline }
  Result := TppChildBDEPipeline.Create(Self);//TppChildBDEPipeline(ppComponentCreate(Self, TppChildBDEPipeline));
  Result.Name := Result.GetValidName(Result);

  {add pipeline to the dataview's Pipelines[] array}
  Result.DataView := Self;

end; {procedure, CreateDataPipeline}

{------------------------------------------------------------------------------}
{ TdaBDETemplateDataView.CreatePipelineField }

function TdaBDETemplateDataView.CreatePipelineField(aTableName, aFieldName, aFieldAlias: String;
                             aDataPipeline: TppDataPipeline; aSearchable, aSortable: Boolean): TppField;
begin

  Result := TppField.Create(nil);

  {set field props}
  Result.TableName     := aTableName;
  Result.FieldName     := aFieldName;

  if (aFieldAlias <> '') then
    Result.FieldAlias    := aFieldAlias
  else
    Result.FieldAlias    := aFieldName;

  Result.DataType      := aDataPipeline.GetFieldDataType(aFieldName);
  Result.FieldLength   := aDataPipeline.GetFieldSize(aFieldName);
  Result.DisplayWidth  := aDataPipeline.GetFieldDisplayWidth(aFieldName);


  Result.Searchable    := aSearchable;
  Result.Sortable      := aSortable;

  {add field to the datapipeline's Fields[] array}
  Result.DataPipeline := aDataPipeline;

  {turn auto create fields off}
  if (aDataPipeline <> nil) and (aDataPipeline is TppDBPipeline) and
    TppDBPIpeline(aDataPipeline).AutoCreateFields then
    TppDBPIpeline(aDataPipeline).AutoCreateFields := False;


end; {procedure, CreatePipelineField}




{******************************************************************************
 *
 ** Query Template DataView
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaBDEQueryTemplateDataView.Create }

constructor TdaBDEQueryTemplateDataView.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  {call CreateQuery method defined in the ancestor }
  FQuery := CreateQuery;

  {call CreateDataSource method defined in the ancestor }
  FDataSource := CreateDataSource;
  FDataSource.DataSet := FQuery;

  FDataPipeline := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaBDEQueryTemplateDataView.Destroy }

destructor TdaBDEQueryTemplateDataView.Destroy;
begin

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaBDEQueryTemplateDataView.SetDatabaseName }

procedure TdaBDEQueryTemplateDataView.SetDatabaseName(aDatabaseName: String);
begin
  inherited SetDatabaseName(aDatabaseName);

  FQuery.DatabaseName := GetBDEDatabaseName;
  FQuery.SessionName  := GetBDESessionName;

  SQL.DatabaseName   := FQuery.DatabaseName;

end; {procedure, SetDatabaseName}

{------------------------------------------------------------------------------}
{ TdaBDEQueryTemplateDataView.Init }

procedure TdaBDEQueryTemplateDataView.Init;
var
  liIndex: Integer;
begin

  if (FDataPipeline <> nil) then Exit;

  DefineSelectedFields;
  DefineDataSelection;

  inherited Init;

  if (DataPipelineCount > 0) then Exit;

  CreateDataPipelines;
  ConnectPipelinesToData;

  for liIndex := 0 to DataPipelineCount-1 do
    CreatePipelineFields(DataPipelines[liIndex]);

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TdaBDEQueryTemplateDataView.CreateDataPipelines }

procedure TdaBDEQueryTemplateDataView.CreateDataPipelines;
begin

  {note: call CreateDataPipeline defined in ancestor }
  FDataPipeline := CreateDataPipeline;
  FDataPipeline.UserName := ppTextToIdentifier(ClassDescription);

  FDataPipeline.Name := FDataPipeline.UserName;

  {this gets displayed as the toolwindow caption}
  SQL.DataPipelineName := FDataPipeline.UserName;

  UserName := 'Query_' + FDataPipeline.Name;

end; {procedure, CreateDataPipelines}

{------------------------------------------------------------------------------}
{ TdaBDEQueryTemplateDataView.CreatePipelineFields }

procedure TdaBDEQueryTemplateDataView.CreatePipelineFields(aDataPipeline: TppDataPipeline);
var
  liIndex: Integer;
  lField: TdaField;
  lsFieldName: String;
begin

  if (FDataPipeline = aDataPipeline) then
    begin

      if DuplicateFieldNames then
        UpdateFieldNamesFromSQL;

      TppDBPipeline(aDataPipeline).AutoCreateFields := False;

      for liIndex := 0 to SQL.SelectFieldCount-1 do
        begin
          lField := SQL.SelectFields[liIndex];

          if (lField.SQLFieldName <> '') then
            lsFieldName := lField.SQLFieldName
          else
            lsFieldName := lField.FieldName;

          CreatePipelineField(lField.TableAlias, lsFieldName, lField.FieldAlias, aDataPipeline, lField.Searchable, lField.Sortable);
        end;

    end;

end; {procedure, CreatePipelineFields}

{------------------------------------------------------------------------------}
{ TdaBDEQueryTemplateDataView.DuplicateFieldNames }

function TdaBDEQueryTemplateDataView.DuplicateFieldNames: Boolean;
var
  lFieldNames: TStringList;
  liIndex: Integer;
  lsFieldName: String;
begin

  lFieldNames := TStringList.Create;
  lFieldNames.Sorted := True;

  Result := False;
  liIndex := 0;

  while not(Result) and (liIndex < SQL.SelectFieldCount) do
    begin
      lsFieldName := SQL.SelectFields[liIndex].FieldName;

      if (lFieldNames.IndexOf(lsFieldName) = -1) then
        begin
          lFieldNames.Add(lsFieldName);

          Inc(liIndex);
        end
      else
        Result := True;

    end;

  lFieldNames.Free;

end; {procedure, DuplicateFieldNames}

{------------------------------------------------------------------------------}
{ TdaBDEQueryTemplateDataView.UpdateFieldNamesFromSQL }

procedure TdaBDEQueryTemplateDataView.UpdateFieldNamesFromSQL;
begin

  {set these properties so call to Valid will not display a message}
  SQL.DataPipelineName := 'xxx';

  {call valid to set the SQLFieldName property of the selected fields}
  SQL.Valid;

end; {procedure, UpdateFieldNamesFromSQL}

{------------------------------------------------------------------------------}
{ TdaBDEQueryTemplateDataView.ConnectPipelinesToData }

procedure TdaBDEQueryTemplateDataView.ConnectPipelinesToData;
begin

  if (FDatapipeline = nil) then Exit;

  {connect datapipeline to datasource here}
  FDatapipeline.DataSource := FDataSource;

end; {procedure, ConnectPipelinesToData}

{------------------------------------------------------------------------------}
{ TdaBDEQueryTemplateDataView.DefineSelectedFields }

procedure TdaBDEQueryTemplateDataView.DefineSelectedFields;
begin

  SQL.Clear;

 {descendants add code here}

end; {procedure, DefineSelectedFields}

{------------------------------------------------------------------------------}
{ TdaBDEQueryTemplateDataView.DefineCalculatedFields }

procedure TdaBDEQueryTemplateDataView.DefineCalculatedFields;
begin

 {descendants add code here}

end; {procedure, DefineCalculatedFields}


{------------------------------------------------------------------------------}
{ TdaBDEQueryTemplateDataView.AddSelectTable }

function TdaBDEQueryTemplateDataView.AddSelectTable(aTableName: String): TdaTable;
begin
  Result := SQL.AddTable(aTableName);

end; {function, AddSelectTable}

{------------------------------------------------------------------------------}
{ TdaBDEQueryTemplateDataView.AddSelectField }

function TdaBDEQueryTemplateDataView.AddSelectField(aTable: TdaTable; aFieldName, aFieldAlias: String; aSearchable, aSortable: Boolean): TdaField;
begin


  Result := SQL.AddSelectField(aTable, aFieldName);

  if (aFieldAlias <> '')  then
    Result.FieldAlias := aFieldAlias;

  Result.Searchable := aSearchable;
  Result.Sortable   := aSortable;

end; {procedure, AddSelectField}


{------------------------------------------------------------------------------}
{ TdaBDEQueryTemplateDataView.DefineDataSelection }

procedure TdaBDEQueryTemplateDataView.DefineDataSelection;
begin

  SetActive(False);

  BuildSQL;

end; {procedure, DefineDataSelection}

{------------------------------------------------------------------------------}
{ TdaBDEQueryTemplateDataView.BuildSQL }

procedure TdaBDEQueryTemplateDataView.BuildSQL;
begin

  DefineSelectionCriteria;

  DefineSortOrder;

  FQuery.SQL := SQL.SQLText;

end; {procedure, BuildSQL}


{------------------------------------------------------------------------------}
{ TdaBDEQueryTemplateDataView.DefineSelectionCriteria }

procedure TdaBDEQueryTemplateDataView.DefineSelectionCriteria;
var
  liIndex: Integer;
  lField: TppField;
  lTable: TdaTable;

begin

  if (FDataPipeline = nil) then Exit;


  {add code for selection criteria}
  SQL.ClearCriteria;

  for liIndex := 0 to FDataPipeline.FieldCount-1 do
    if FDataPipeline.Fields[liIndex].Search then
      begin
        lField := FDataPipeline.Fields[liIndex];
        lTable := SQL.GetTableForSQLAlias(lField.TableName);

        SQL.AddCriteriaField(lTable, lField.FieldName, dacoLike, lField.SearchExpression);


      end;

end; {procedure, DefineSelectionCriteria}


{------------------------------------------------------------------------------}
{ TdaBDEQueryTemplateDataView.DefineSortOrder }

procedure TdaBDEQueryTemplateDataView.DefineSortOrder;

var
  liIndex: Integer;
  lField: TppField;
  ldaField: TdaField;
  lTable: TdaTable;
  lbAscending: Boolean;
  lFields: TStringList;
begin

  if (FDataPipeline = nil) then Exit;

  {add code for sort order}
  SQL.ClearOrderByFields;


  {get list of sort fields}
  lFields := TStringList.Create;

  for liIndex := 0 to FDataPipeline.FieldCount - 1 do
    begin
      lField := FDataPipeline.Fields[liIndex];

      if lField.Sort then
        lFields.AddObject(Format('%8d', [lField.SortOrder]), lField);
    end;

  lFields.Sort;

  for liIndex := 0 to lFields.Count - 1 do
    begin
      lField := TppField(lFields.Objects[liIndex]);

      lTable := SQL.GetTableForSQLAlias(lField.TableName);

      ldaField := SQL.CreateFieldForTable(lTable, lField.FieldName);

      lbAscending := (lField.SortType = soAscending);

      SQL.AddOrderByField(ldaField, lbAscending);

      ldaField.Free;
     end;

  lFields.Free;

end; {procedure, DefineSortOrder}

{------------------------------------------------------------------------------}
{ TdaBDEQueryTemplateDataView.SQLChanged }

procedure TdaBDEQueryTemplateDataView.SQLChanged;
begin

  if FQuery.Active then
    FQuery.Close;

  FQuery.DatabaseName := GetBDEDatabaseName;
  FQuery.SessionName  := GetBDESessionName;
  FQuery.SQL := SQL.SQLText;

end; {procedure, SQLChanged}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

procedure Register;
begin

  RegisterNoIcon([TdaChildBDEQuery, TdaChildBDETable, TdaChildBDEStoredProc]);

  RegisterNoIcon([TdaBDEQueryDataView]);


end; {procedure, Register}


initialization

  RegisterClasses([TdaChildBDEQuery, TdaChildBDETable, TdaChildBDEStoredProc]);

  daRegisterSession(TdaBDESession);
  daRegisterDataSet(TdaBDEDataSet);

  daRegisterDataView(TdaBDEQueryDataView);

  {initialize internal reference variables}
  uBDEDatabase := nil;



finalization

  {free the default connection object}
  uBDEDatabase.Free;
  uBDEDatabase := nil;

  UnRegisterClasses([TdaChildBDEQuery, TdaChildBDETable, TdaChildBDEStoredProc]);

  daUnRegisterSession(TdaBDESession);
  daUnRegisterDataSet(TdaBDEDataSet);

  daUnRegisterDataView(TdaBDEQueryDataView);

end.
