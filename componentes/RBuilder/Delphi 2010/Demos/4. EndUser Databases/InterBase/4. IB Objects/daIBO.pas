{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit daIBO;

interface

uses Classes, SysUtils, Forms, ExtCtrls,  DB,  Contnrs,
     ppClass, ppComm, ppDBPipe, ppDB, ppClasUt, ppTypes,
     daDB, daQueryDataView, daDataView, daPreviewDataDlg,
     IB_Components, IB_StoredProc, IBODataset;

type

  { TdaChildIBOQuery }
  TdaChildIBOQuery = class(TIBOQuery)
    public
      function HasParent: Boolean; override;
    end;  {class, TdaChildIBOQuery}


  { TdaChildIBOTable }
  TdaChildIBOTable = class(TIBOTable)
    public
      function HasParent: Boolean; override;
    end;  {class, TdaChildIBOTable}


  { TdaIBOSession }
  TdaIBOSession = class(TdaSession)
    private
      procedure AddDatabase(aDatabase: TComponent);

    protected

      procedure SetDataOwner(aDataOwner: TComponent); override;

    public

      class function ClassDescription: String; override;
      class function DataSetClass: TdaDataSetClass; override;
      class function DatabaseClass: TComponentClass; override;

      procedure GetDatabaseNames(aList: TStrings); override;
      function  GetDatabaseType(const aDatabaseName: String): TppDatabaseType; override;
      procedure GetTableNames(const aDatabaseName: String; aList: TStrings); override;
      function  ValidDatabaseTypes: TppDatabaseTypes; override;

  end; {class, TdaIBOSession}



  { TdaIBODataSet }
  TdaIBODataSet = class(TdaDataSet)
    private
      FQuery: TIBOQuery;

      function GetQuery: TIBOQuery;

    protected
      procedure BuildFieldList; override;
      function  GetActive: Boolean; override;
      procedure SetActive(Value: Boolean); override;
      procedure SetDatabase(aDatabase: TComponent); override;
      procedure SetDataName(const aDataName: String); override;

      property Query: TIBOQuery read GetQuery;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function ClassDescription: String; override;

      procedure GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings); override;
      procedure GetFieldsForSQL(aList: TList; aSQL: TStrings); override;

  end; {class, TdaIBODataSet}


  { TdaIBOQueryDataView }
  TdaIBOQueryDataView = class(TdaQueryDataView)
    private
      FDataSource: TppChildDataSource;
      FQuery: TdaChildIBOQuery;

    protected
      {procedure UpdateQueryObject; }

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

  end; {class, TdaIBOQueryDataView}

  {utility routines}
  procedure daGetIBODatabaseNames(aList: TStrings);
  function daGetIBODatabaseForName(aDatabaseName: String): TIB_Connection;

  function daGetIBODatabaseList: TppComponentList;

  {Delphi design time registration}
  procedure Register;


implementation

const
  cDefaultDatabase = 'DefaultIBODatabase';

var
  FIBODatabase: TIBODatabase;
  FIBODatabaseList: TppComponentList;



{******************************************************************************
 *
 ** R E G I S T E R
 *
{******************************************************************************}

procedure Register;
begin

  {IBO DataAccess Components}
  RegisterNoIcon([TdaChildIBOQuery, TdaChildIBOTable]);

  {IBO DataViews}
  RegisterNoIcon([TdaIBOQueryDataView]);

end;

{******************************************************************************
 *
 ** C H I L D   B D E  D A T A   A C C E S S   C O M P O N E N T S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaChildIBOQuery.HasParent }

function TdaChildIBOQuery.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TdaChildIBOTable.HasParent }

function TdaChildIBOTable.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{******************************************************************************
 *
 ** I B O   S E S S I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaIBOSession.ClassDescription }

class function TdaIBOSession.ClassDescription: String;
begin
  Result := 'IBOSession';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaIBOSession.DataSetClass }

class function TdaIBOSession.DataSetClass: TdaDataSetClass;
begin
  Result := TdaIBODataSet;
end; {class function, DataSetClass}

{------------------------------------------------------------------------------}
{ TdaIBOSession.DatabaseClass }

class function TdaIBOSession.DatabaseClass: TComponentClass;
begin
  Result := TIB_Connection;
end;

{------------------------------------------------------------------------------}
{ TdaIBOSession.GetTableNames }

procedure TdaIBOSession.GetTableNames(const aDatabaseName: String; aList: TStrings);
var
  lDatabase: TIB_Connection;

begin
  {get the database}
  lDatabase := daGetIBODatabaseForName(aDatabaseName);

  {connection must be active to get table names}
  if not lDatabase.Connected then
    lDatabase.Connected := True;

  if lDatabase.Connected then
    alist.Assign(lDatabase.SchemaCache.TableNames);

end; {procedure, GetTableNames}

{------------------------------------------------------------------------------}
{ TdaIBOSession.AddDatabase }

procedure TdaIBOSession.AddDatabase(aDatabase: TComponent);
begin

  if daGetIBODatabaseList.IndexOf(aDatabase) < 0 then
    FIBODatabaseList.Add(aDatabase);

end; {procedure, AddDatabase}

{------------------------------------------------------------------------------}
{ TdaIBOSession.GetDatabaseNames }

procedure TdaIBOSession.GetDatabaseNames(aList: TStrings);
var
  liIndex: Integer;

begin
  {call utility routine to get list of database names}
  daGetIBODatabaseNames(aList);

  daGetDatabaseObjectsFromOwner(TdaSessionClass(Self.ClassType), aList, DataOwner);

  for liIndex := 0 to aList.Count-1 do
    if aList.Objects[liIndex] <> nil then
      AddDatabase(TComponent(aList.Objects[liIndex]));

end; {procedure, GetDatabaseNames}

{------------------------------------------------------------------------------}
{ TdaIBOSession.SetDataOwner }

procedure TdaIBOSession.SetDataOwner(aDataOwner: TComponent);
var
  lList: TStringList;
begin

  inherited SetDataOwner(aDataOwner);

  lList := TStringList.Create;

  GetDatabaseNames(lList);

  lList.Free;

end; {procedure, SetDataOwner}

{------------------------------------------------------------------------------}
{ TdaIBOSession.ValidDatabaseTypes }

function TdaIBOSession.ValidDatabaseTypes: TppDatabaseTypes;
begin
  Result := [dtInterBase];
end; {procedure, ValidDatabaseTypes}

{------------------------------------------------------------------------------}
{ TdaIBOSession.GetDatabaseType }

function TdaIBOSession.GetDatabaseType(const aDatabaseName: String): TppDatabaseType;
begin
  Result := dtInterBase;
end; {function, GetDatabaseType}

{******************************************************************************
 *
 ** I B O   D A T A S E T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.Create }

constructor TdaIBODataSet.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FQuery := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.Destroy }

destructor TdaIBODataSet.Destroy;
begin

  FQuery.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.ClassDescription }

class function TdaIBODataSet.ClassDescription: String;
begin
  Result := 'IBODataSet';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.GetActive }

function TdaIBODataSet.GetActive: Boolean;
begin
  Result := GetQuery.Active;
end; {function, GetActive}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.SetActive }

procedure TdaIBODataSet.SetActive(Value: Boolean);
begin
  GetQuery.Active := Value;
end; {procedure, SetActive}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.GetQuery }

function TdaIBODataSet.GetQuery: TIBOQuery;
begin

  {create IB table, if needed}
  if (FQuery = nil) then
    FQuery := TIBOQuery.Create(Self);

  Result := FQuery;

end; {procedure, GetQuery}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.SetDatabase }

procedure TdaIBODataSet.SetDatabase(aDatabase: TComponent);
begin

  inherited SetDatabase(aDatabase);

  {table cannot be active to set database property}
  if GetQuery.Active then
    FQuery.Active := False;

  FQuery.IB_Connection := TIBODatabase(aDatabase);

  {get IB database for name}
  if (FQuery.IB_Connection <> nil) then
    begin
      FQuery.DatabaseName := FQuery.IB_Connection.DatabaseName;
    end;

end; {procedure, SetDatabaseName}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.SetDataName }

procedure TdaIBODataSet.SetDataName(const aDataName: String);
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
{ TdaIBODataSet.BuildFieldList }

procedure TdaIBODataSet.BuildFieldList;
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
{ TdaIBODataSet.GetFieldNamesForSQL }

procedure TdaIBODataSet.GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings);
var
  lQuery: TIBOQuery;
begin
  aList.Clear;

  {create a temporary IBO query}
  lQuery := TIBOQuery.Create(Self);

  {set the database and SQL properties}
  lQuery.IB_Connection := FQuery.IB_Connection;
  lQuery.SQL := aSQL;

  {get the field names}
  lQuery.GetFieldNames(aList);

  lQuery.Free;

end; {procedure, GetFieldNamesForSQL}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.GetFieldsForSQL }

procedure TdaIBODataSet.GetFieldsForSQL(aList: TList; aSQL: TStrings);
var
  lQuery: TIBOQuery;
  lQueryField: TField;
  lField: TppField;
  liIndex: Integer;
begin
  aList.Clear;

  {create a temporary IBO query}
  lQuery := TIBOQuery.Create(Self);

  try

    {assign databae and SQL properties}
    lQuery.IB_Connection := FQuery.IB_Connection;
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
 ** B D E  Q U E R Y   D A T A V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaIBOQueryDataView.Create }

constructor TdaIBOQueryDataView.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  {notes: 1. must use ChildQuery, ChildDataSource, ChildPipeline etc.
          2. use Self as owner for Query, DataSource etc.
          3. do NOT assign a Name }

  FQuery := TdaChildIBOQuery.Create(Self);

  FDataSource := TppChildDataSource.Create(Self);
  FDataSource.DataSet := FQuery;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaIBOQueryDataView.Destroy }

destructor TdaIBOQueryDataView.Destroy;
begin
  FDataSource.Free;
  FQuery.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaIBOQueryDataView.SessionClass }

class function TdaIBOQueryDataView.SessionClass: TClass;
begin
  Result := TdaIBOSession;
end; {class function, SessionClass}

{------------------------------------------------------------------------------}
{ TdaIBOQueryDataView.PreviewFormClass }

class function TdaIBOQueryDataView.PreviewFormClass: TFormClass;
begin
  Result := TFormClass(GetClass('TdaPreviewDataDialog'));
end; {class function, PreviewFormClass}

{------------------------------------------------------------------------------}
{ TdaIBOQueryDataView.ConnectPipelinesToData }

procedure TdaIBOQueryDataView.ConnectPipelinesToData;
begin

  if DataPipelineCount = 0 then Exit;

  {need to reconnect here}
  TppDBPipeline(DataPipelines[0]).DataSource := FDataSource;


end; {procedure, ConnectPipelinesToData}

{------------------------------------------------------------------------------}
{ TdaIBOQueryDataView.Init }

procedure TdaIBOQueryDataView.Init;
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
{ TdaIBOQueryDataView.SQLChanged }

procedure TdaIBOQueryDataView.SQLChanged;
begin

  if FQuery.Active then
    FQuery.Close;

  FQuery.IB_Connection := daGetIBODatabaseForName(SQL.DatabaseName);
  FQuery.SQL := SQL.MagicSQLText;

end; {procedure, SQLChanged}

{******************************************************************************
 *
 ** P R O C E D U R E S   A N D   F U N C T I O N S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ daGetDefaultIBODatabase }

function daGetDefaultIBODatabase: TIBODatabase;
begin

  {create the default IBO database, if needed}
  if (FIBODatabase = nil) then
    begin
      {create default IBO database}
      FIBODatabase := TIBODatabase.Create(nil);
      FIBODatabase.Name := cDefaultDatabase;
    end;

  Result := FIBODatabase

end; {function, daGetDefaultIBODatabase}

{------------------------------------------------------------------------------}
{ daGetIBODatabaseNames }

procedure daGetIBODatabaseNames(aList: TStrings);
begin

  {could add hard-coded connection strings here, or could
   read from an .ini file }

end; {procedure, daGetIBODatabaseNames}

{------------------------------------------------------------------------------}
{ daGetIBODatabaseForName }

function daGetIBODatabaseForName(aDatabaseName: String): TIB_Connection;
var
  liIndex: Integer;

begin
  Result := nil;

  liIndex := 0;

 {check for a database object with this name}
  while (Result = nil) and (liIndex < daGetIBODatabaseList.Count) do
    begin
      if (AnsiCompareStr(FIBODatabaseList[liIndex].Name, aDatabaseName) = 0) or
         (AnsiCompareStr(TIBODatabase(FIBODatabaseList[liIndex]).DatabaseName, aDatabaseName) = 0) then
        Result :=  TIBODatabase(FIBODatabaseList[liIndex]);
      Inc(liIndex);
    end;

  if (Result <> nil) then Exit;


  {use the default database object}
  Result := daGetDefaultIBODatabase;

  {set DatabaseName property, if needed}
  if (Result.DatabaseName <> aDatabaseName) then
    begin

      if Result.Connected then
        Result.Connected := False;
        
      Result.DatabaseName := aDatabaseName;

    end;

end; {function, daGetIBODatabaseForName}

{------------------------------------------------------------------------------}
{ daGetIBODatabaseList }

function daGetIBODatabaseList: TppComponentList;
begin
  if (FIBODatabaseList = nil) then
    FIBODatabaseList := TppComponentList.Create(nil);

  Result := FIBODatabaseList;

end; {function, daGetIBODatabaseList}


initialization

  {register the IBO descendant classes}
  RegisterClasses([TdaChildIBOQuery, TdaChildIBOTable]);

  {register DADE descendant session, dataset, dataview}
  daRegisterSession(TdaIBOSession);
  daRegisterDataSet(TdaIBODataSet);
  daRegisterDataView(TdaIBOQueryDataView);

  {initialize internal reference variables}
  FIBODatabase := nil;
  FIBODatabaseList := nil;


finalization

  {free the default database object}
  FIBODatabase.Free;
  FIBODatabaseList.Free;
  
  {unregister the IBO descendant classes}
  UnRegisterClasses([TdaChildIBOQuery, TdaChildIBOTable]);

  {unregister DADE descendant the session, dataset, dataview}
  daUnRegisterSession(TdaIBOSession);
  daUnRegisterDataSet(TdaIBODataSet);
  daUnRegisterDataView(TdaIBOQueryDataView);


end.
