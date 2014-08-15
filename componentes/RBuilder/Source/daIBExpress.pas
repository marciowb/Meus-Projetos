{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit daIBExpress;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi10} WideStrings,{$ENDIF}
  Windows, Classes, SysUtils, Forms, ExtCtrls,  DB, Contnrs,
  ppClass, ppComm, ppDBPipe, ppDB, ppClasUt, ppTypes,
  daDB, daQueryDataView, daDataView, daPreviewDataDlg,
  ppDsIntf,
  IBDatabase, IBStoredProc, IBQuery, IBCustomDataSet, IBTable; 



type

  {Interbase Express (IBX) DataView Classes:

     1.  IB TDataSet descendants
           - TDataSets that can be children of a DataView.
           - Override the HasParent method of TComponent to return True
           - Must be registerd with the Delphi IDE using the RegisterNoIcon procedure

       a. TdaChildIBXQuery - TIBQuery descendant that can be a child of a DataView
       b. TdaChildIBXTable - TIBTable descendant that can be a child of a DataView
       c. TdaChildIBXStoredProc - TIBStoredProc descendant that can be a child of a DataView

     2.  TdaIBXSession
           - descendant of TppSession
           - implements GetDatabaseNames, GetTableNames, etc.

     3.  TdaIBXDataSet
          - descendant of TppDataSet
          - implements GetFieldNames for SQL

     4.  TdaIBXQueryDataView
          - descendant of TppQueryDataView
          - uses the above classes to create the required
            Query -> DataSource -> Pipeline -> Report connection
          - uses the TdaSQL object built by the QueryWizard to assign
            SQL to the TIBQuery etc.

      }

  { TdaChildIBXQuery }
  TdaChildIBXQuery = class(TIBQuery)
    public
      function HasParent: Boolean; override;
    end;  {class, TdaChildIBXQuery}

  { TdaChildIBXTable }
  TdaChildIBXTable = class(TIBTable)
    public
      function HasParent: Boolean; override;
    end;  {class, TdaChildIBXTable}

  { TdaChildIBXStoredProc }
  TdaChildIBXStoredProc = class(TIBStoredProc)
    public
      function HasParent: Boolean; override;
    end;  {class, TdaChildIBXStoredProc}


  { TdaIBXSession }
  TdaIBXSession = class(TdaSession)
    private

    protected
      function GetDefaultDatabase(const aDatabaseName: String): TComponent; override;
      function IsNamedDatabase(const aDatabaseName: String; aDatabase: TComponent): Boolean; override;

    public
      constructor Create(aComponent: TComponent); override;

      class function ClassDescription: String; override;
      class function DataSetClass: TdaDataSetClass; override;
      class function DatabaseClass: TComponentClass; override;
      class function GetDefaultIBXDatabase: TIBDatabase;

      procedure GetDatabaseNames(aList: TStrings); override;
      function  GetDatabaseType(const aDatabaseName: String): TppDatabaseType; override;
      procedure GetTableNames(const aDatabaseName: String; aList: TStrings); override;
      function  ValidDatabaseTypes: TppDatabaseTypes; override;

  end; {class, TdaIBXSession}



  { TdaIBXDataSet }
  TdaIBXDataSet = class(TdaDataSet)
    private
      FQuery: TIBQuery;

      function GetQuery: TIBQuery;

    protected
      procedure BuildFieldList; override;
      function  GetActive: Boolean; override;
      procedure SetActive(Value: Boolean); override;
      procedure SetDatabase(aDatabase: TComponent); override;
      procedure SetDataName(const aDataName: String); override;

      property Query: TIBQuery read GetQuery;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function ClassDescription: String; override;

      procedure GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings); override;
      procedure GetFieldsForSQL(aList: TList; aSQL: TStrings); override;

  end; {class, TdaIBXDataSet}


  { TdaIBXQueryDataView }
  TdaIBXQueryDataView = class(TdaQueryDataView)
    private
      FDataSource: TppChildDataSource;
      FQuery: TdaChildIBXQuery;

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

  end; {class, TdaIBXQueryDataView}


  {Delphi design time registration}
  procedure Register;


implementation

const
  cDefaultDatabase = 'DefaultIBXDatabase';

var
  uIBDatabase: TIBDatabase;
  uIBTransaction: TIBTransaction;


{******************************************************************************
 *
 ** R E G I S T E R
 *
{******************************************************************************}

procedure Register;
begin

  {IBX DataAccess Components}
  RegisterNoIcon([TdaChildIBXQuery, TdaChildIBXTable, TdaChildIBXStoredProc]);

  {IBX DataViews}
  RegisterNoIcon([TdaIBXQueryDataView]);

end;


{******************************************************************************
 *
 ** C H I L D   I B  D A T A   A C C E S S   C O M P O N  E N T S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaChildIBXQuery.HasParent }

function TdaChildIBXQuery.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TdaChildIBXTable.HasParent }

function TdaChildIBXTable.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}


{------------------------------------------------------------------------------}
{ TdaChildIBXStoredProc.HasParent }

function TdaChildIBXStoredProc.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}


{******************************************************************************
 *
 ** I B   S E S S I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaIBXSession.Create }

constructor TdaIBXSession.Create(aComponent: TComponent);
begin

  inherited Create(aComponent);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaIBXSession.ClassDescription }

class function TdaIBXSession.ClassDescription: String;
begin
  Result := 'IBXSession';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaIBXSession.DataSetClass }

class function TdaIBXSession.DataSetClass: TdaDataSetClass;
begin
  Result := TdaIBXDataSet;
end; {class function, DataSetClass}

{------------------------------------------------------------------------------}
{ TdaIBXSession.DatabaseClass }

class function TdaIBXSession.DatabaseClass: TComponentClass;
begin
  Result := TIBDatabase;
end;


{------------------------------------------------------------------------------}
{ TdaIBXSession.GetDefaultIBXDatabase }

class function TdaIBXSession.GetDefaultIBXDatabase: TIBDatabase;
begin

  {create the default IB database, if needed}
  if (uIBDatabase = nil) then
    begin
      {create default IB database}
      uIBDatabase := TIBDatabase.Create(nil);
      uIBDatabase.Name := cDefaultDatabase;

      {create a default transaction for the IBDatabase}
      uIBTransaction := TIBTransaction.Create(nil);

      uIBDatabase.DefaultTransaction := uIBTransaction;

    end;

  Result := uIBDatabase;
  
end; {function, daGetDefaultIBXDatabase}


{------------------------------------------------------------------------------}
{ TdaIBXSession.GetTableNames }

procedure TdaIBXSession.GetTableNames(const aDatabaseName: String; aList: TStrings);
var
  lDatabase: TIBDatabase;
  lTable: TIBTable;

begin
  {get the database}
  lDatabase := TIBDatabase(GetDatabaseForName(aDatabaseName));

  lTable := TIBTable.Create(nil);
  lTable.Database := lDatabase;

  {include views in the list of available tables}
  lTable.TableTypes := [ttView];

  {connection must be active to get table names}
  if not lDatabase.Connected then
    lDatabase.Connected := True;

  {get list of table names from a table object}
  if lDatabase.Connected then
    aList.Assign(lTable.TableNames);

  lTable.Free;

end; {procedure, GetTableNames}

{------------------------------------------------------------------------------}
{ TdaIBXSession.GetDatabaseNames }

procedure TdaIBXSession.GetDatabaseNames(aList: TStrings);
begin

  {call inherited to build list of avaailable TIBDatabase components}
  inherited GetDatabaseNames(aList);

  {could add hard-coded connection strings here, or could
   read from an .ini file }

end; {procedure, GetDatabaseNames}

{------------------------------------------------------------------------------}
{ TdaIBXSession.GetDefaultDatabase }

function TdaIBXSession.GetDefaultDatabase(const aDatabaseName: String): TComponent;
var
  lIBDatabase: TIBDatabase;
begin

  lIBDatabase := GetDefaultIBXDatabase;

  {set DatabaseName property, if needed}
  if (lIBDatabase.DatabaseName <> aDatabaseName) then
    begin

      if lIBDatabase.Connected then
        lIBDatabase.Connected := False;

      lIBDatabase.DatabaseName := aDatabaseName;

    end;

  Result := lIBDatabase;

end; {function, GetDefaultDatabase}

{------------------------------------------------------------------------------}
{ TdaIBXSession.IsNamedDatabase }

function TdaIBXSession.IsNamedDatabase(const aDatabaseName: String; aDatabase: TComponent): Boolean;
begin

  Result := (AnsiCompareText(aDatabase.Name, aDatabaseName) = 0) or
            (AnsiCompareText(TIBDatabase(aDatabase).DatabaseName, aDatabaseName) = 0);

end; {function, IsNamedDatabase}

{------------------------------------------------------------------------------}
{ TdaIBXSession.ValidDatabaseTypes }

function TdaIBXSession.ValidDatabaseTypes: TppDatabaseTypes;
begin
  Result := [dtInterBase];
end; {procedure, ValidDatabaseTypes}

{------------------------------------------------------------------------------}
{ TdaIBXSession.GetDatabaseType }

function TdaIBXSession.GetDatabaseType(const aDatabaseName: String): TppDatabaseType;
begin
  Result := dtInterBase;
end; {function, GetDatabaseType}


{******************************************************************************
 *
 ** I B  D A T A S E T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaIBXDataSet.Create }

constructor TdaIBXDataSet.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FQuery := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaIBXDataSet.Destroy }

destructor TdaIBXDataSet.Destroy;
begin

  FQuery.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaIBXDataSet.ClassDescription }

class function TdaIBXDataSet.ClassDescription: String;
begin
  Result := 'IBXDataSet';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaIBXDataSet.GetActive }

function TdaIBXDataSet.GetActive: Boolean;
begin
  Result := GetQuery.Active
end; {function, GetActive}

{------------------------------------------------------------------------------}
{ TdaIBXDataSet.SetActive }

procedure TdaIBXDataSet.SetActive(Value: Boolean);
begin
  GetQuery.Active := Value;
end; {procedure, SetActive}

{------------------------------------------------------------------------------}
{ TdaIBXDataSet.GetQuery }

function TdaIBXDataSet.GetQuery: TIBQuery;
begin

  {create IB table, if needed}
  if (FQuery = nil) then
    FQuery := TIBQuery.Create(Self);

  Result := FQuery;

end; {procedure, GetQuery}

{------------------------------------------------------------------------------}
{ TdaIBXDataSet.SetDatabase }

procedure TdaIBXDataSet.SetDatabase(aDatabase: TComponent);
begin

  inherited SetDatabase(aDatabase);

  {table cannot be active to set database property}
  if GetQuery.Active then
    FQuery.Active := False;

  {set IBQuery.Database}
  FQuery.Database := TIBDatabase(aDatabase);

end; {procedure, SetDatabase}

{------------------------------------------------------------------------------}
{ TdaIBXDataSet.SetDataName }

procedure TdaIBXDataSet.SetDataName(const aDataName: String);
begin

  inherited SetDataName(aDataName);

  {dataset cannot be active to set data name}
  if GetQuery.Active then
    FQuery.Active := False;

  {construct an SQL statment that returns an empty result set,
   this is used to get the field information }
  FQuery.SQL.Text := 'SELECT * FROM ' + aDataName +
                     ' WHERE ''c'' <> ''c'' ';

  {optional optimization for Interbase}
// FQuery.SQL.Text := 'SELECT * FROM '  + aDataName + ' ROWS 0';

  {optional optimization for Firebird}
// FQuery.SQL.Text := 'SELECT FIRST 0 * FROM ' + aDataName;

end; {procedure, SetDataName}

{------------------------------------------------------------------------------}
{ TdaIBXDataSet.BuildFieldList }

procedure TdaIBXDataSet.BuildFieldList;
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
{ TdaIBXDataSet.GetFieldNamesForSQL }

procedure TdaIBXDataSet.GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings);
var
  lQuery: TIBQuery;
{$IFDEF Delphi10}
  lWideStrings: TWideStringList;
{$ENDIF}
begin
  aList.Clear;

  {create a temporary IB query}
  lQuery := TIBQuery.Create(Self);

  {set the database and SQL properties}
  lQuery.Database := TIBDatabase(Database);
  lQuery.SQL := aSQL;

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
{ TdaIBXDataSet.GetFieldsForSQL }

procedure TdaIBXDataSet.GetFieldsForSQL(aList: TList; aSQL: TStrings);
var
  lQuery: TIBQuery;
  lQueryField: TField;
  lField: TppField;
  liIndex: Integer;
begin
  aList.Clear;

  {create a temporary IB query}
  lQuery := TIBQuery.Create(Self);

  try

    {assign databae and SQL properties}
    lQuery.Database := TIBDatabase(Database);
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
 ** I B  Q U E R Y   D A T A V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaIBXQueryDataView.Create }

constructor TdaIBXQueryDataView.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  {notes: 1. must use ChildQuery, ChildDataSource, ChildPipeline etc.
          2. use Self as owner for Query, DataSource etc.
          3. do NOT assign a Name }

  FQuery := TdaChildIBXQuery.Create(Self);

  FDataSource := TppChildDataSource.Create(Self);
  FDataSource.DataSet := FQuery;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaIBXQueryDataView.Destroy }

destructor TdaIBXQueryDataView.Destroy;
begin
  FDataSource.Free;
  FQuery.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaIBXQueryDataView.SessionClass }

class function TdaIBXQueryDataView.SessionClass: TClass;
begin
  Result := TdaIBXSession;
end; {class function, SessionClass}

{------------------------------------------------------------------------------}
{ TdaIBXQueryDataView.PreviewFormClass }

class function TdaIBXQueryDataView.PreviewFormClass: TFormClass;
begin
  Result := TFormClass(GetClass('TdaPreviewDataDialog'));
end; {class function, PreviewFormClass}


{------------------------------------------------------------------------------}
{ TdaIBXQueryDataView.ConnectPipelinesToData }

procedure TdaIBXQueryDataView.ConnectPipelinesToData;
begin

  if DataPipelineCount = 0 then Exit;

  {need to reconnect here}
  TppDBPipeline(DataPipelines[0]).DataSource := FDataSource;


end; {procedure, ConnectPipelinesToData}

{------------------------------------------------------------------------------}
{ TdaIBXQueryDataView.Init }

procedure TdaIBXQueryDataView.Init;
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
{ TdaIBXQueryDataView.SQLChanged }

procedure TdaIBXQueryDataView.SQLChanged;
var
  lDatabase: TComponent;
begin

  if FQuery.Active then
    FQuery.Close;

  lDatabase := Session.GetDatabaseForName(SQL.DatabaseName);

  if (lDatabase = nil) then
    raise EDataError.Create('TdaIBXQueryDataView.SQLChanged: No IBDatabase object found, ' + SQL.DatabaseName);

  FQuery.Database := TIBDatabase(lDatabase);
  FQuery.SQL := SQL.MagicSQLText;

end; {procedure, SQLChanged}

{******************************************************************************
 *
 ** P R O C E D U R E S   A N D   F U N C T I O N S
 *
{******************************************************************************}

initialization

  {register the IB descendant classes}
  RegisterClasses([TdaChildIBXQuery, TdaChildIBXTable, TdaChildIBXStoredProc]);

  {register DADE descendant session, dataset, dataview}
  daRegisterSession(TdaIBXSession);
  daRegisterDataSet(TdaIBXDataSet);
  daRegisterDataView(TdaIBXQueryDataView);

  {initialize internal reference variables}
  uIBDatabase := nil;
  uIBTransaction := nil;


finalization

  {free the default database object}
  uIBDatabase.Free;
  uIBDatabase := nil;
  uIBTransaction.Free;
  uIBTransaction := nil;

  {unregister the IB descendant classes}
  UnRegisterClasses([TdaChildIBXQuery, TdaChildIBXTable, TdaChildIBXStoredProc]);

  {unregister DADE descendant the session, dataset, dataview}
  daUnRegisterSession(TdaIBXSession);
  daUnRegisterDataSet(TdaIBXDataSet);
  daUnRegisterDataView(TdaIBXQueryDataView);


end.
