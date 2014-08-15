{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2007                   BBBBB   }

unit daElevateDB;
                                      
interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi10} WideStrings,{$ENDIF}
  Windows,
  Classes,
  SysUtils,
  Forms,
  DB,

  ppTypes,
  ppClass,
  ppClasUt,
  ppComm,
  ppDB,
  ppDBPipe,

  daDB,
  daDataView,
  daQueryDataView,
  daPreviewDataDlg,

  edbComps;

type

  {@TdaChildEDBQuery

    Used by a dataview to create a EDB query without a non-visual component
    appearing on the Delphi form or data module (see RegisterNoIcon call at
    bottom of this unit.)}

  TdaChildEDBQuery = class(TEDBQuery)
    public
      function HasParent: Boolean; override;

    end;  {class, TdaChildEDBQuery}

  {@TdaChildDBISMTable

    Used by a dataview to create a EDB table without a non-visual component
    appearing on the Delphi form or data module (see RegisterNoIcon call at
    bottom of this unit.)}

  TdaChildEDBTable = class(TEDBTable)
    public
      function HasParent: Boolean; override;

    end;  {class, TdaChildEDBTable}


  {@TdaEDBSession

    Used by DADE to collect metadata (Table Names, Field Names) directly from
    EDB.}

  TdaEDBSession = class(TdaSession)
    private

    protected
      function GetDefaultDatabase(const aDatabaseName: String): TComponent; override;
      function IsNamedDatabase(const aDatabaseName: String; aDatabase: TComponent): Boolean; override;

    public
      class function ClassDescription: String; override;
      class function DataSetClass: TdaDataSetClass; override;
      class function DatabaseClass: TComponentClass; override;
      class function GetDefaultEDBConnection: TEDBDatabase;

      function  DefaultSQLType(aDatabaseType: TppDatabaseType): TppSQLType; override;
      procedure GetDatabaseNames(aList: TStrings); override;
      function  GetDatabaseType(const aDatabaseName: String): TppDatabaseType; override;
      procedure GetTableNames(const aDatabaseName: String; aList: TStrings); override;
      function ValidDatabaseTypes: TppDatabaseTypes; override;
      function GetSearchCriteriaDateFormat(aDatabaseType: TppDatabaseType; const aDatabaseName: String): String;override;
      function GetSearchCriteriaTimeFormat(aDatabaseType: TppDatabaseType; const aDatabaseName: string): string; override;

  end; {class, TdaEDBSession}


  {@TdaEDBDataSet

    Used by DADE to submit SQL to EDB for validation purposes. When
    EditSQLAsText is True, also used to get the field names of the dataset.}

  TdaEDBDataSet = class(TdaDataSet)
    private
      FDataSet: TEDBTable;
      FDatabase: TEDBDatabase;

      function GetDataSet: TDataSet;

    protected
      procedure BuildFieldList; override;
      function  GetActive: Boolean; override;
      procedure SetActive(Value: Boolean); override;
      procedure SetDatabase(aDatabase: TComponent); override;
      procedure SetDataName(const aDataName: String); override;

      property DataSet: TDataSet read GetDataSet;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function ClassDescription: String; override;

      procedure GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings); override;
      procedure GetFieldsForSQL(aList: TList; aSQL: TStrings); override;

  end; {class, TdaEDBDataSet}


  {@TdaEDBQueryDataView

   The QueryDataView class is the heart of linkable dataviews in DADE. This
   class allows EDB to be used as the database when creating linkable
   dataviews.}

  TdaEDBQueryDataView = class(TdaQueryDataView)
    private
      FDataSource: TppChildDataSource;
      FQuery: TdaChildEDBQuery;

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

  end; {class, TdaEDBQueryDataView}


  {Delphi design-time registration}
  procedure Register;


implementation

uses
  Dialogs;

const
  cDefaultDatabase = 'DefaultEDBDatabase';

var
  FEDBDatabase: TEDBDatabase;


{******************************************************************************
 *
 ** C H I L D   E D B  D A T A   A C C E S S   C O M P O N E N T S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaChildEDBQuery.HasParent }

function TdaChildEDBQuery.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TdaChildEDBTable.HasParent }

function TdaChildEDBTable.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}


{******************************************************************************
 *
 ** E D B   S E S S I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaEDBSession.ClassDescription }

class function TdaEDBSession.ClassDescription: String;
begin
  Result := 'ElevateDBSession';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaEDBSession.DataSetClass }

class function TdaEDBSession.DataSetClass: TdaDataSetClass;
begin
  Result := TdaEDBDataSet;
end; {class function, DataSetClass}

{------------------------------------------------------------------------------}
{ TdaEDBSession.DatabaseClass }

class function TdaEDBSession.DatabaseClass: TComponentClass;
begin
  Result := TEDBDatabase;
end; {class function, DatabaseClass}

{------------------------------------------------------------------------------}
{ TdaEDBSession.GetDefaultEDBConnection }

class function TdaEDBSession.GetDefaultEDBConnection: TEDBDatabase;
begin

  {create the default EDB database, if needed}
  if (FEDBDatabase = nil) then
    begin
      {create default EDB database}
      FEDBDatabase := TEDBDatabase.Create(nil);
      FEDBDatabase.Name := cDefaultDatabase;
    end;

  Result := FEDBDatabase;

end; {function, GetDefaultEDBConnection}

{------------------------------------------------------------------------------}
{ TdaEDBSession.GetTableNames }

procedure TdaEDBSession.GetTableNames(const aDatabaseName: String; aList: TStrings);
var
  lDatabase: TEDBDatabase;
begin
  {get the database}
  lDatabase := TEDBDatabase(GetDatabaseForName(aDatabaseName));

  {connection must be active to get table names}
  if not lDatabase.Connected then
    lDatabase.Connected := True;

  if lDatabase.Connected then
    lDatabase.Session.GetTableNames(lDatabase.Database, aList);


end; {procedure, GetTableNames}

{------------------------------------------------------------------------------}
{ TdaEDBSession.GetDatabaseType }

function TdaEDBSession.GetDatabaseType(const aDatabaseName: String): TppDatabaseType;
begin
  Result := dtElevateDB;

end; 

{------------------------------------------------------------------------------}
{ TdaEDBSession.GetDatabaseNames }

procedure TdaEDBSession.GetDatabaseNames(aList: TStrings);
begin

  {call inherited to build list of available TEDBDatabase components}
  inherited GetDatabaseNames(aList);

  {could add hard-coded connection strings here, or could
   read from an .ini file }

end; {procedure, GetDatabaseNames}

{------------------------------------------------------------------------------}
{ TdaEDBSession.GetDefaultDatabase }

function TdaEDBSession.GetDefaultDatabase(const aDatabaseName: String): TComponent;
var
  lEDBDatabase: TEDBDatabase;
begin

  lEDBDatabase := GetDefaultEDBConnection;


  {set DatabaseName property, if needed}
  if (lEDBDatabase.DatabaseName <> aDatabaseName) then
    begin
      if lEDBDatabase.Connected then
        lEDBDatabase.Connected := False;

      lEDBDatabase.DatabaseName := aDatabaseName;
    end;


  Result := lEDBDatabase;

end; {function, GetDefaultDatabase}

{------------------------------------------------------------------------------}
{ TdaEDBSession.IsNamedDatabase }

function TdaEDBSession.IsNamedDatabase(const aDatabaseName: String; aDatabase: TComponent): Boolean;
begin

  Result := (AnsiCompareText(aDatabase.Name, aDatabaseName) = 0) or
            (AnsiCompareText(TEDBDatabase(aDatabase).DatabaseName, aDatabaseName) = 0);


end; {function, IsNamedDatabase}

{------------------------------------------------------------------------------}
{ TdaEDBSession.GetSearchCriteriaDateFormat }

function TdaEDBSession.GetSearchCriteriaDateFormat(aDatabaseType: TppDatabaseType; const aDatabaseName: String): String;
begin

  {return a format usable by FormatDate}
  Result := 'YYYY-MM-DD';

end; {function, GetSearchCriteriaDateFormat }

{------------------------------------------------------------------------------}
{ TdaEDBSession.ValidDatabaseTypes }
function TdaEDBSession.ValidDatabaseTypes: TppDatabaseTypes;
begin

  Result := [dtElevateDB];

end;

{------------------------------------------------------------------------------}
{ TdaEDBSession.DefaultSQLType }

function TdaEDBSession.DefaultSQLType(aDatabaseType: TppDatabaseType): TppSQLType;
begin
  Result := sqSQL2;
end; {function, DefaultSQLType}

{------------------------------------------------------------------------------}
function TdaEDBSession.GetSearchCriteriaTimeFormat(aDatabaseType: TppDatabaseType; const aDatabaseName: string): string;
begin
  {return a format usable by FormatDateTime}
  Result := 'HH:NN:SS.ZZZ';
end;


{******************************************************************************
 *
 ** E D B   D A T A S E T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaEDBDataSet.Create }

constructor TdaEDBDataSet.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FDataSet := nil;
  FDatabase := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaEDBDataSet.Destroy }

destructor TdaEDBDataSet.Destroy;
begin

  FDataSet.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaEDBDataSet.ClassDescription }

class function TdaEDBDataSet.ClassDescription: String;
begin
  Result := 'EDBDataSet';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaEDBDataSet.GetActive }

function TdaEDBDataSet.GetActive: Boolean;
begin
  Result := GetDataSet.Active;
end; {function, GetActive}

{------------------------------------------------------------------------------}
{ TdaEDBDataSet.SetActive }

procedure TdaEDBDataSet.SetActive(Value: Boolean);
begin
  GetDataSet.Active := Value;
end; {procedure, SetActive}

{------------------------------------------------------------------------------}
{ TdaEDBDataSet.GetDataSet }

function TdaEDBDataSet.GetDataSet: TDataSet;
begin

  if (FDataSet = nil) then
    FDataSet := TEDBTable.Create(Self);

  Result := FDataSet;

end; {procedure, GetDataSet}

{------------------------------------------------------------------------------}
{ TdaEDBDataSet.SetDatabase }

procedure TdaEDBDataSet.SetDatabase(aDatabase: TComponent);
begin

  inherited SetDatabase(aDatabase);

  {table cannot be active to set database property}
  if GetDataSet.Active then
    FDataSet.Active := False;

  FDatabase := TEDBDatabase(aDatabase);

  if (FDatabase <> nil) then
    begin
      FDataSet.DatabaseName := FDatabase.DatabaseName;
      FDataSet.SessionName  := FDatabase.SessionName;
    end;

end; {procedure, SetDatabase}

{------------------------------------------------------------------------------}
{ TdaEDBDataSet.SetDataName }

procedure TdaEDBDataSet.SetDataName(const aDataName: String);
const
  lcDoubleQuote = #34;
var
  lsTableName: String;
begin

  inherited SetDataName(aDataName);

  {dataset cannot be active to set table name property}
  if GetDataset.Active then
    FDataSet.Active := False;

  {strip off any double quotes which may be added by the DataDictionary Builder}
  lsTableName := StringReplace(aDataName, lcDoubleQuote, '', [rfReplaceAll]);
  
  FDataSet.TableName := lsTableName;

end; {procedure, SetDataName}

{------------------------------------------------------------------------------}
{ TdaEDBDataSet.BuildFieldList }

procedure TdaEDBDataSet.BuildFieldList;
var
  liIndex: Integer;
  lEDBField: TField;
  lField: TppField;
begin

  inherited BuildFieldList;

  {set dataset to active}
  if not(GetDataSet.Active) then
    try
      FDataSet.Active := True;
    except
      on E:Exception do
        Exit;
    end;

  {create TppField objects for each field in the table}
  for liIndex := 0 to FDataSet.FieldCount - 1 do
    begin
      lEDBField := FDataSet.Fields[liIndex];

      lField := TppField.Create(nil);

      lField.TableName := FDataSet.TableName;
      lField.FieldName := lEDBField.FieldName;
      lField.FieldAlias := lEDBField.DisplayLabel;
      lField.FieldLength := lEDBField.Size;
      lField.DataType := ppConvertFieldType(lEDBField.DataType);
      lField.DisplayWidth := lEDBField.DisplayWidth;


      AddField(lField);
    end;

end; {function, BuildFieldList}

{------------------------------------------------------------------------------}
{ TdaEDBDataSet.GetFieldNamesForSQL }

procedure TdaEDBDataSet.GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings);
var
  lQuery: TEDBQuery;
{$IFDEF Delphi10}
  lWideStrings: TWideStringList;
{$ENDIF}
begin

  if (FDatabase = nil) then
    raise EDataError.Create('TdaEDBDataSet.GetFieldNamesForSQL: Database property is nil');

  aList.Clear;

  {create a temporary EDB query}
  lQuery := TEDBQuery.Create(Self);

  {set the database and SQL properties}
  lQuery.DatabaseName := FDatabase.DatabaseName;
  lQuery.SessionName := FDatabase.SessionName;
  lQuery.SQL := aSQL;
  lQuery.ReadOnly := True;

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
{ TdaEDBDataSet.GetFieldsForSQL }

procedure TdaEDBDataSet.GetFieldsForSQL(aList: TList; aSQL: TStrings);
var
  lQuery: TEDBQuery;
  lEDBField: TField;
  lField: TppField;
  liIndex: Integer;

begin

  aList.Clear;

  {create a temporary EDB query}
  lQuery := TEDBQuery.Create(Self);

  try

    {assign database and SQL properties}
    lQuery.DatabaseName := FDatabase.DatabaseName;
    lQuery.SessionName := FDatabase.SessionName;
    lQuery.SQL := aSQL;
    lQuery.ReadOnly := true;
    lQuery.Active := True;

    {create a TppField object for each field in the query}
    for liIndex := 0 to lQuery.FieldCount - 1 do
      begin
        lEDBField := lQuery.Fields[liIndex];

        lField := TppField.Create(nil);

        lField.FieldName := lEDBField.FieldName;
        lField.FieldAlias := lEDBField.DisplayLabel;
        lField.FieldLength := lEDBField.Size;
        lField.DataType := ppConvertFieldType(lEDBField.DataType);
        lField.DisplayWidth := lEDBField.DisplayWidth;

        aList.Add(lField);
      end;

  finally
    lQuery.Free;

  end;

end; {procedure, GetFieldsForSQL}


{******************************************************************************
 *
 ** E D B   Q U E R Y   D A T A V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaEDBQueryDataView.Create }

constructor TdaEDBQueryDataView.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);
  {notes: 1. must use ChildQuery, ChildDataSource, ChildPipeline etc.
          2. use Self as owner for Query, DataSource etc.
          3. do NOT assign a Name }

  FQuery := TdaChildEDBQuery.Create(Self);

  FDataSource := TppChildDataSource.Create(Self);
  FDataSource.DataSet := FQuery;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaEDBQueryDataView.Destroy }

destructor TdaEDBQueryDataView.Destroy;
begin

  FDataSource.Free;
  FQuery.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaEDBQueryDataView.PreviewFormClass }

class function TdaEDBQueryDataView.PreviewFormClass: TFormClass;
begin
  Result := TFormClass(GetClass('TdaPreviewDataDialog'));
end; {class function, PreviewFormClass}

{------------------------------------------------------------------------------}
{ TdaEDBQueryDataView.SessionClass }

class function TdaEDBQueryDataView.SessionClass: TClass;
begin
  Result := TdaEDBSession;
end; {class function, SessionClass}

{------------------------------------------------------------------------------}
{ TdaEDBQueryDataView.ConnectPipelinesToData }

procedure TdaEDBQueryDataView.ConnectPipelinesToData;
begin

  if DataPipelineCount = 0 then Exit;

  {need to reconnect here}
  TppDBPipeline(DataPipelines[0]).DataSource := FDataSource;

end; {procedure, ConnectPipelinesToData}

{------------------------------------------------------------------------------}
{ TdaEDBQueryDataView.Init }

procedure TdaEDBQueryDataView.Init;
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
{ TdaEDBQueryDataView.SQLChanged }

procedure TdaEDBQueryDataView.SQLChanged;
var
  lDatabase: TComponent;
begin

  if FQuery.Active then
    FQuery.Close;

  lDatabase := Session.GetDatabaseForName(SQL.DatabaseName);

  if (lDatabase = nil) then
    raise EDataError('TdaEDBQueryDataView.SQLChanged: No EDBDatabase object found, ' + SQL.DatabaseName);

  FQuery.DatabaseName := TEDBDatabase(lDatabase).DatabaseName;
  FQuery.SessionName := TEDBDatabase(lDatabase).SessionName;
  
  FQuery.SQL := SQL.MagicSQLText;

end; {procedure, SQLChanged}


{******************************************************************************
 *
 ** R E G I S T E R
 *
{******************************************************************************}

procedure Register;
begin

  {EDB data access components}
  RegisterNoIcon([TdaChildEDBQuery, TdaChildEDBTable]);

  {EDB dataviews}
  RegisterNoIcon([TdaEDBQueryDataView]);

end;


initialization

  FEDBDatabase := nil;

  {register the EDB descendant classes}
  RegisterClasses([TdaChildEDBQuery, TdaChildEDBTable]);

  {register DADE descendant classes}
  daRegisterSession(TdaEDBSession);
  daRegisterDataSet(TdaEDBDataSet);
  daRegisterDataView(TdaEDBQueryDataView);

finalization

  FEDBDatabase.Free;
  FEDBDatabase := nil;

  {unregister the EDB descendant classes}
  UnRegisterClasses([TdaChildEDBQuery, TdaChildEDBTable]);

  {unregister DADE descendant the classes}
  daUnRegisterSession(TdaEDBSession);
  daUnRegisterDataSet(TdaEDBDataSet);
  daUnRegisterDataView(TdaEDBQueryDataView);
  
end.




