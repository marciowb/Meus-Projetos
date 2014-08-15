{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit daMetaData;

interface

{$I ppIfDef.pas}

uses
  Classes,

  ppUtils,
  ppTypes,
  ppCollectionBase,
  ppComm,
  ppDB,
  ppDsgnDB,
  
  daDB;

type

  TdaMetaData = class;
  TdaMetaCache = class;
  TdaMetaTable = class;
  TdaMetaField = class;
  TdaMetaTableCollection = class;


  { TdaMetaData

    All queries submitted to the database pass-thru this class, which maintains
    table, field and join information in memory.  When a data dictionary is being
    used, this class retrieves the data from the data dictionary tables.
    When a data dictionary is not being used, this class retrieves the data
    directly from the database.  Once field and table information is retrieved,
    it is stored in objects, so that subsequent requests for the same information
    can be quickly granted. }

  TdaMetaData = class(TppCommunicator)
    private
      FCache: TdaMetaCache;
      FDatabaseName: String;
      FSessionClassName: String;
      FDataDictionary: TppDataDictionary;
      FSession: TdaSession;

      function CreateMetaFieldFromDataSetField(aDataSetField: TppField): TdaMetaField;
      procedure GetFieldsFromDataSet(aMetaTable: TdaMetaTable; aFields: TList);
      procedure GetFieldNamesFromDataSet(aMetaTable: TdaMetaTable; aFields: TStrings);
      procedure GetFieldsFromDataDictionary(aMetaTable: TdaMetaTable; aFields: TList);
      function GetTable(aIndex: Integer): TdaMetaTable;
      function GetTableCount: Integer;
      procedure GetTablesFromSession(aTables: TdaMetaTableCollection);
      procedure GetTablesFromDataDictionary(aTables: TdaMetaTableCollection);
      procedure PopulateCacheTables;
      procedure PopulateCacheFields(aTable: TdaMetaTable; aSQLTableName: String);
      procedure SetDatabaseName(aDatabaseName: String);
      procedure SetDataDictionary(aDataDictionary: TppDataDictionary);
      procedure SetSession(aSession: TdaSession);
      procedure ValidateFieldNames(aMetaTable: TdaMetaTable; aFields: TList);
      procedure ValidateTableNames(aTables: TdaMetaTableCollection);

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      procedure Clear;
      procedure GetFields(aTableName, aSQLTableName: String; aFields: TList);
      function GetMaxFieldAliasLength(aRawTableName: String): Integer;
      function GetTableAlias(aRawTableName: String): String;
      procedure GetTables(aTables: TList);

      property DatabaseName: String read FDatabaseName write SetDatabaseName;
      property DataDictionary: TppDataDictionary read FDataDictionary write SetDataDictionary;
      property SessionClassName: String read FSessionClassName;
      property Session: TdaSession read FSession write SetSession;

      property Tables[Index: Integer]: TdaMetaTable read GetTable;
      property TableCount: Integer read GetTableCount;

  end; {class, TdaMetaData}


  { TdaMetaCache

    Holds references to all instantiated objects which make up the meta data
    information }

  TdaMetaCache = class
    private
      FTables: TdaMetaTableCollection;
      FPopulated: Boolean;
      FDataDictionary: TppDataDictionary;

      function GetTable(aIndex: Integer): TdaMetaTable;
      function GetTableCount: Integer;
      procedure SetDataDictionary(const Value: TppDataDictionary);

    public
      constructor Create;
      destructor Destroy; override;

      procedure Clear;
      function GetTableForName(aTableName: String): TdaMetaTable;
      function GetTableForRawTableName(aTableName: String): TdaMetaTable;
      procedure GetTables(aTables: TList);
      procedure SetTables(aTables: TdaMetaTableCollection);

      property DataDictionary: TppDataDictionary read FDataDictionary write SetDataDictionary;
      property Populated: Boolean read FPopulated;
      property Tables[Index: Integer]: TdaMetaTable read GetTable;
      property TableCount: Integer read GetTableCount;

  end; {class, TdaMetaCache}


  { TdaMetaTable

    Stores information for a given table }

  TdaMetaTable = class
    private
      FAlias: String;
      FFields: TList;
      FFileBased: Boolean;
      FMaxFieldAliasLength: Integer;
      FName: String;
      FOwnerName: String;
      FPopulated: Boolean;
      FSQLName: String;

      procedure FreeFields;
      function GetField(aIndex: Integer): TdaMetaField;
      function GetFieldCount: Integer;
      function GetRawTableName: String;

    public
      constructor Create;
      destructor Destroy; override;

      procedure GetFields(aFields: TList);
      procedure SetFields(aFields: TList);
      property Alias: String read FAlias write FAlias;
      property FileBased: Boolean read FFileBased write FFileBased;
      property MaxFieldAliasLength: Integer read FMaxFieldAliasLength write FMaxFieldAliasLength;
      property Name: String read FName write FName;
      property OwnerName: String read FOwnerName write FOwnerName;
      property RawTableName: String read GetRawTableName;
      property SQLName: String read FSQLName write FSQLName;
      property Populated: Boolean read FPopulated;

      property Fields[Index: Integer]: TdaMetaField read GetField;
      property FieldCount: Integer read GetFieldCount;

  end; {class, TdaMetaTable}


  {TdaMetaTableCollection}
  TdaMetaTableCollection = class(TppIndexedCollectionBase)
  private
    FUseTableOwnerName: Boolean;
    FRawTableNameIndex: TppHashTable;

    function GetRawTableNameIndex: TppHashTable;
    function GetItemByName(Name: String): TdaMetaTable;
    function GetItemByRawTableName(Name: String): TdaMetaTable;
    function GetItems(Index: Integer): TdaMetaTable;
    procedure SetUseTableOwnerName(const Value: Boolean);
    
  protected
    function GetKey(aObject: TObject): String; override;
    procedure RebuildIndex; override;
  public

    constructor Create; override;
    destructor Destroy; override;

    function Add(aItem: TdaMetaTable): Integer;
    procedure Delete(aIndex: Integer);
    property ItemByName[Name: String]: TdaMetaTable read GetItemByName;
    property ItemByRawTableName[Name: String]: TdaMetaTable read GetItemByRawTableName;
    property Items[Index: Integer]: TdaMetaTable read GetItems; default;
    property UseTableOwnerName: Boolean read FUseTableOwnerName write SetUseTableOwnerName;
  end;


  { TdaMetaField

    Stores information for a given field }

  TdaMetaField = class
    private
      FAlias: String;
      FAutoSearch: Boolean;
      FDataType: TppDataType;
      FDisplayFormat: String;
      FDisplayWidth: Integer;
      FName: String;
      FLength: Integer;
      FMandatory: Boolean;
      FSearchable: Boolean;
      FSelectable: Boolean;
      FSortable: Boolean;

    public
      constructor Create;
      destructor Destroy; override;

      property Alias: String read FAlias write FAlias;
      property AutoSearch: Boolean read FAutoSearch write FAutoSearch;
      property DataType: TppDataType read FDataType write FDataType;
      property DisplayFormat: String read FDisplayFormat write FDisplayFormat;
      property DisplayWidth: Integer read FDisplayWidth write FDisplayWidth;
      property Name: String read FName write FName;
      property Length: Integer read FLength write FLength;
      property Mandatory: Boolean read FMandatory write FMandatory;
      property Searchable: Boolean read FSearchable write FSearchable;
      property Selectable: Boolean read FSelectable write FSelectable;
      property Sortable: Boolean read FSortable write FSortable;

  end; {class, TdaMetaField}



implementation

uses
  SysUtils;

{*******************************************************************************
 *
 ** M E T A D A T A
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaMetaData.Create }

constructor TdaMetaData.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FCache := TdaMetaCache.Create;
  FDatabaseName := '';
  FDataDictionary := nil;
  FSessionClassName := '';
  FSession := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaMetaData.Destroy }

destructor TdaMetaData.Destroy;
begin

  FCache.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaMetaData.Notify }

procedure TdaMetaData.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation = ppopRemove) and (aCommunicator = FDataDictionary) then
    FDataDictionary := nil

  else if (aOperation = ppopRemove) and (aCommunicator = FSession) then
    FSession := nil;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TdaMetaData.Clear }

procedure TdaMetaData.Clear;
begin
  FCache.Clear;

end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TdaMetaData.SetDatabaseName }

procedure TdaMetaData.SetDatabaseName(aDatabaseName: String);
begin

  if (FDatabaseName = aDatabaseName) then Exit;

  FDatabaseName := aDatabaseName;
  FCache.Clear;

end; {procedure, SetDatabaseName}

{------------------------------------------------------------------------------}
{ TdaMetaData.SetDataDictionary }

procedure TdaMetaData.SetDataDictionary(aDataDictionary: TppDataDictionary);
begin

  if (FDataDictionary = aDataDictionary) then Exit;

  if (FDataDictionary <> nil) then
    FDataDictionary.RemoveNotify(Self);

  FDataDictionary := aDataDictionary;
  FCache.DataDictionary := aDataDictionary;
//  FCache.Clear;

  if (FDataDictionary <> nil) then
    FDataDictionary.AddNotify(Self);

end; {procedure, SetDataDictionary}

{------------------------------------------------------------------------------}
{ TdaMetaData.SetSession }

procedure TdaMetaData.SetSession(aSession: TdaSession);
begin

  if (FSession = aSession) then Exit;

  if (FSession <> nil) then
    FSession.RemoveNotify(Self);

  FSession := aSession;

  if (FSession <> nil) then
    begin
      FSession.AddNotify(Self);

      if (FSessionClassName <> FSession.ClassName) then
        begin
          FCache.Clear;
          FSessionClassName := FSession.ClassName;
        end;

    end;

end; {procedure, SetSession}

{------------------------------------------------------------------------------}
{ TdaMetaData.GetTable }

function TdaMetaData.GetTable(aIndex: Integer): TdaMetaTable;
begin
  if not(FCache.Populated) then
    PopulateCacheTables;

  Result := FCache.Tables[aIndex];
end; {function, GetTable}

{------------------------------------------------------------------------------}
{ TdaMetaData.GetTableCount }

function TdaMetaData.GetTableCount: Integer;
begin
  if not(FCache.Populated) then
    PopulateCacheTables();

  Result := FCache.TableCount;
end; {function, GetTableCount}

{------------------------------------------------------------------------------}
{ TdaMetaData.GetTables }

procedure TdaMetaData.GetTables(aTables: TList);
begin
  if not(FCache.Populated) then
    PopulateCacheTables();

  FCache.GetTables(aTables)

end; {procedure, GetTables}

{------------------------------------------------------------------------------}
{ TdaMetaData.GetMaxFieldAliasLength }

function TdaMetaData.GetMaxFieldAliasLength(aRawTableName: String): Integer;
begin

  Result := FSession.GetMaxFieldAliasLength(aRawTableName);

end; {function, GetMaxFieldAliasLength}

{------------------------------------------------------------------------------}
{ TdaMetaData.GetTableAlias }

function TdaMetaData.GetTableAlias(aRawTableName: String): String;
var
  lTable: TdaMetaTable;
begin

  if not(FCache.Populated) then
    PopulateCacheTables();

  lTable := FCache.GetTableForRawTableName(aRawTableName);

  if (lTable <> nil) then
    Result := lTable.Alias
  else
    Result := '';

end; {function, GetTableAlias}

{------------------------------------------------------------------------------}
{ TdaMetaData.GetTablesFromDataDictionary }

procedure TdaMetaData.GetTablesFromDataDictionary(aTables: TdaMetaTableCollection);
var
  lTableAliases: TStrings;
  lTableNames: TStrings;
  liIndex: Integer;
  lTable: TdaMetaTable;
  lsRawTableName: String;
  lsTableName: String;
  lsExtension: String;
  lbFileBased: Boolean;
begin

  aTables.Clear;

  aTables.BeginUpdate;

  lTableNames := TStringList.Create;
  lTableAliases := TStringList.Create;
  
  FDataDictionary.GetTableNames(lTableNames, lTableAliases);
  
  for liIndex := 0 to lTableNames.Count - 1 do
    begin
      lTable := TdaMetaTable.Create;

      lTable.Alias := lTableAliases[liIndex];

      lsRawTableName := lTableNames[liIndex];

      ppStripOffTableName(lsRawTableName, lsTableName, lsExtension, lbFileBased);

      if (lbFileBased) then
        lTable.Name := lsTableName + '.' + lsExtension
      else
        begin
          lTable.OwnerName := lsExtension;
          lTable.Name := lsTableName;
        end;

      lTable.FileBased := lbFileBased;
      lTable.MaxFieldAliasLength := FSession.GetMaxFieldAliasLength(lsRawTableName);

      aTables.Add(lTable);
    end;

  lTableAliases.Free;
  lTableNames.Free;

  aTables.EndUpdate;


end; {procedure, GetTablesFromDataDictionary}

{------------------------------------------------------------------------------}
{ TdaMetaData.GetTablesFromSession }

procedure TdaMetaData.GetTablesFromSession(aTables: TdaMetaTableCollection);
var
  lTableNames: TStrings;
  liIndex: Integer;
  lTable: TdaMetaTable;
  lsRawTableName: String;
  lsTableName: String;
  lsTableAlias: String;
  lsExtension: String;
  lbFileBased: Boolean;
begin

  aTables.Clear;
  aTables.BeginUpdate;

  lTableNames := TStringList.Create;

  FSession.GetTableNames(FDatabaseName, lTableNames);

  for liIndex := 0 to lTableNames.Count - 1 do
    begin
      lTable := TdaMetaTable.Create;

      lsRawTableName := lTableNames[liIndex];

      ppStripOffTableName(lsRawTableName, lsTableName, lsExtension, lbFileBased);

      lsTableAlias := lsTableName;

      if (lbFileBased) then
        lTable.Name := lsTableName + '.' + lsExtension
      else
        begin
          lTable.OwnerName := lsExtension;
          lTable.Name := lsTableName;
        end;

      lTable.Alias := lsTableAlias;
      lTable.FileBased := lbFileBased;
      lTable.MaxFieldAliasLength := FSession.GetMaxFieldAliasLength(lsRawTableName);

      aTables.Add(lTable);
    end;

  lTableNames.Free;
  aTables.EndUpdate;


end; {procedure, GetTablesFromSession}

{------------------------------------------------------------------------------}
{ TdaMetaData.ValidateTableNames }

procedure TdaMetaData.ValidateTableNames(aTables: TdaMetaTableCollection);
var
  lSessionTables: TdaMetaTableCollection;
  liIndex: Integer;
  lDataDictTable: TdaMetaTable;
  lSessionTable: TdaMetaTable;
begin

  lSessionTables := TdaMetaTableCollection.Create;

  GetTablesFromSession(lSessionTables);

  liIndex := 0;

  while (liIndex < aTables.Count) do
    begin
      lDataDictTable := aTables[liIndex];

      lSessionTable := lSessionTables.ItemByName[lDataDictTable.Name];

      if (lSessionTable = nil) then
        begin
          aTables.Delete(liIndex); // table instance will be freed automatically
        end

      else
        begin
          lDataDictTable.FileBased := lSessionTable.FileBased;
          lDataDictTable.OwnerName := lSessionTable.OwnerName;

          Inc(liIndex);
        end;

    end;

  // rebuild the table indexes
  aTables.RebuildIndex;

  lSessionTables.Free;

end; {procedure, ValidateTableNames}

{------------------------------------------------------------------------------}
{ TdaMetaData.GetFields }

procedure TdaMetaData.GetFields(aTableName, aSQLTableName: String; aFields: TList);
var
  lTable: TdaMetaTable;
begin

  if not(FCache.Populated) then
    PopulateCacheTables;

   if ((FDataDictionary <> nil) and (FDataDictionary.UseTableOwnerName)) then
     lTable := FCache.GetTableForName(aSQLTableName)
   else
     lTable := FCache.GetTableForName(aTableName);

  if (lTable = nil) then
    raise EDesignError.Create('TdaMetaCache.GetFields: unable to find table ' +  aTableName + ' in cache.');

  if not(lTable.Populated) then
    PopulateCacheFields(lTable, aSQLTableName);

  lTable.GetFields(aFields);

end; {procedure, GetFields}

{------------------------------------------------------------------------------}
{ TdaMetaData.PopulateCacheTables }

procedure TdaMetaData.PopulateCacheTables;
var
  lTables: TdaMetaTableCollection;
begin

  lTables := TdaMetaTableCollection.Create;

  if (FDataDictionary = nil) then
    GetTablesFromSession(lTables)

  else if (FDataDictionary <> nil) then
    begin
      GetTablesFromDataDictionary(lTables);

      if (FDataDictionary.ValidateTableNames) then
        ValidateTableNames(lTables);
        
    end;

  FCache.SetTables(lTables);

end; {procedure, PopulateCacheTables}

{------------------------------------------------------------------------------}
{ TdaMetaData.GetFieldsFromDataSet }

procedure TdaMetaData.GetFieldsFromDataSet(aMetaTable: TdaMetaTable; aFields: TList);
var
  lDataSet: TdaDataSet;
  lDataSetField: TppField;
  liIndex: Integer;
  lField: TdaMetaField;
begin

  aFields.Clear;

  lDataSet := FSession.CreateDataSet(Self, FDatabaseName);
  lDataSet.DataName := aMetaTable.SQLName;

  try
    lDataSet.Active := True;
  except
    raise EDataError.Create('TdaMetaData.GetFieldsFromDataSet: Unable to open dataset: ' + aMetaTable.SQLName);
  end;

  for liIndex := 0 to lDataSet.FieldCount - 1 do
    begin
      lDataSetField := lDataSet.Fields[liIndex];

      lField := CreateMetaFieldFromDataSetField(lDataSetField);

      aFields.Add(lField);
    end;

  lDataSet.Active := False;

  lDataSet.Free;

end; {procedure, GetFieldsFromDataSet}

{------------------------------------------------------------------------------}
{ TdaMetaData.GetFieldNamesFromDataSet }

procedure TdaMetaData.GetFieldNamesFromDataSet(aMetaTable: TdaMetaTable; aFields: TStrings);
var
  lFields: TList;
  liIndex: Integer;
  lField: TdaMetaField;
begin

  lFields := TList.Create;

  GetFieldsFromDataSet(aMetaTable, lFields);

  aFields.Clear;

  for liIndex := 0 to lFields.Count - 1 do
    begin
      lField := TdaMetaField(lFields[liIndex]);

      aFields.AddObject(lField.Name, lField);
    end;

  lFields.Free;

end; {procedure, GetFieldNamesFromDataSet}

{------------------------------------------------------------------------------}
{ TdaMetaData.GetFieldsFromDataDictionary }

procedure TdaMetaData.GetFieldsFromDataDictionary(aMetaTable: TdaMetaTable; aFields: TList);
var
  liIndex: Integer;
  lDataSetField: TppField;
  lField: TdaMetaField;
begin

  aFields.Clear;

  if (FDataDictionary.UseTableOwnerName) and not(aMetaTable.FileBased) then
    begin
      if (Length(aMetaTable.OwnerName) > 0) then
        FDataDictionary.TableName := aMetaTable.OwnerName + '.' + aMetaTable.Name
      else
        FDataDictionary.TableName := aMetaTable.Name;
    end

  else
    FDataDictionary.TableName := aMetaTable.Name;

  for liIndex := 0 to FDataDictionary.FieldCount - 1 do
    begin
      lDataSetField := FDataDictionary.Fields[liIndex];

      lField := CreateMetaFieldFromDataSetField(lDataSetField);

      aFields.Add(lField);
    end;

end; {procedure, GetFieldsFromDataDictionary}


{------------------------------------------------------------------------------}
{ TdaMetaData.CreateMetaFieldFromDataSetField }

function TdaMetaData.CreateMetaFieldFromDataSetField(aDataSetField: TppField): TdaMetaField;
begin

  Result := TdaMetaField.Create;

  Result.Alias := aDataSetField.FieldAlias;
  Result.AutoSearch := aDataSetField.AutoSearch;
  Result.DataType := aDataSetField.DataType;
  Result.DisplayFormat := aDataSetField.DisplayFormat;
  Result.DisplayWidth := aDataSetField.DisplayWidth;
  Result.Name := aDataSetField.FieldName;
  Result.Length := aDataSetField.FieldLength;
  Result.Mandatory := aDataSetField.Mandatory;
  Result.Selectable := aDataSetField.Selectable;
  Result.Searchable := aDataSetField.Searchable;
  Result.Sortable := aDataSetField.Sortable;

end; {function, CreateMetaFieldFromDataSetField}

{------------------------------------------------------------------------------}
{ TdaMetaData.PopulateCacheTables }

procedure TdaMetaData.PopulateCacheFields(aTable: TdaMetaTable; aSQLTableName: String);
var
  lFields: TList;
begin

  lFields := TList.Create;

  aTable.SQLName := aSQLTableName;

  if (FDataDictionary = nil) then
     GetFieldsFromDataSet(aTable, lFields)

  else if (FDataDictionary <> nil) then
    begin
      GetFieldsFromDataDictionary(aTable, lFields);

      if (FDataDictionary.ValidateFieldNames) then
        ValidateFieldNames(aTable, lFields);

    end;

  aTable.SetFields(lFields);

  lFields.Free;

end; {procedure, PopulateCacheTables}

{------------------------------------------------------------------------------}
{ TdaMetaData.ValidateFieldNames }

procedure TdaMetaData.ValidateFieldNames(aMetaTable: TdaMetaTable; aFields: TList);
var
  lDataSetFields: TStrings;
  liIndex: Integer;
  lDataDictField: TdaMetaField;
  liPosition: Integer;
  lDataSetField: TdaMetaField;
begin

  lDataSetFields := TStringList.Create;

  GetFieldNamesFromDataSet(aMetaTable, lDataSetFields);

  liIndex := 0;

  while (liIndex < lDataSetFields.Count) do
    begin
      if liIndex < aFields.Count then
        begin
          lDataDictField := TdaMetaField(aFields[liIndex]);
          liPosition := lDataSetFields.IndexOf(lDataDictField.Name);
        end
      else
        begin
          lDataDictField := nil;
          liPosition := -1;
        end;

      if (liPosition = -1) then
        begin
          if lDataDictField <> nil then
            aFields.Delete(liIndex);
          lDataDictField.Free;
        end

      else
        begin
          lDataSetField := TdaMetaField(lDataSetFields.Objects[liPosition]);

          lDataDictField.DisplayWidth := lDataSetField.Length;
          lDataDictField.Length := lDataSetField.Length;

        end;

      Inc(liIndex);

    end;

  lDataSetFields.Free;

end; {procedure, ValidateFieldNames}

{*******************************************************************************
 *
 ** M E T A   C A C H E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaMetaCache.Create }

constructor TdaMetaCache.Create;
begin

  inherited Create;

  FDataDictionary := nil;
  FTables := TdaMetaTableCollection.Create;
  FPopulated := False;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaMetaCache.Destroy }

destructor TdaMetaCache.Destroy;
begin

  FTables.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaMetaCache.Clear }

procedure TdaMetaCache.Clear;
begin

  FTables.Clear;

  FPopulated := False;

end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TdaMetaCache.GetTable }

function TdaMetaCache.GetTable(aIndex: Integer): TdaMetaTable;
begin
  Result := FTables[aIndex];
end; {function, GetTable}

{------------------------------------------------------------------------------}
{ TdaMetaCache.GetTableCount }

function TdaMetaCache.GetTableCount: Integer;
begin
  Result := FTables.Count
end; {function, GetTableCount}

{------------------------------------------------------------------------------}
{ TdaMetaCache.GetTables }

procedure TdaMetaCache.GetTables(aTables: TList);
var
  liIndex: Integer;
begin

  aTables.Clear;

  for liIndex := 0 to FTables.Count - 1 do
    aTables.Add(FTables[liIndex]);

end; {function, GetTables}

{------------------------------------------------------------------------------}
{ TdaMetaCache.SetTables }

procedure TdaMetaCache.SetTables(aTables: TdaMetaTableCollection);
begin

  FTables.Free;
  FTables := aTables;

  FPopulated := True;

end; {function, SetTables}

{------------------------------------------------------------------------------}
{ TdaMetaCache.GetTableForName }

function TdaMetaCache.GetTableForName(aTableName: String): TdaMetaTable;
begin

  FTables.UseTableOwnerName := (FDataDictionary <> nil) and (FDataDictionary.UseTableOwnerName);

  Result := FTables.ItemByName[aTableName];

end; {function, GetTableForName}

{------------------------------------------------------------------------------}
{ TdaMetaCache.GetTableForRawTableName }

function TdaMetaCache.GetTableForRawTableName(aTableName: String): TdaMetaTable;
begin

  Result := FTables.ItemByRawTableName[aTableName];

end; {function, GetTableForName}

{------------------------------------------------------------------------------}
{ TdaMetaCache.SetDataDictionary }

procedure TdaMetaCache.SetDataDictionary(const Value: TppDataDictionary);
begin

  if (FDataDictionary = Value) then Exit;
  
  FDataDictionary := Value;

  FTables.UseTableOwnerName := (FDataDictionary <> nil) and (FDataDictionary.UseTableOwnerName);

end;

{*******************************************************************************
 *
 ** M E T A   T A B L E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaMetaTable.Create }

constructor TdaMetaTable.Create;
begin

  inherited Create;

  FAlias := '';
  FFields := TList.Create;
  FFileBased := False;
  FMaxFieldAliasLength := -1;
  FName := '';
  FOwnerName := '';
  FPopulated := False;
  FSQLName := '';

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaMetaTable.Destroy }

destructor TdaMetaTable.Destroy;
begin

  FreeFields;

  FFields.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaMetaTable.FreeFields }

procedure TdaMetaTable.FreeFields;
var
  liIndex: Integer;
begin

  for liIndex := 0 to FFields.Count - 1 do
    TdaMetaField(FFields[liIndex]).Free;

end; {procedure, FreeFields}

{------------------------------------------------------------------------------}
{ TdaMetaTable.GetField }

function TdaMetaTable.GetField(aIndex: Integer): TdaMetaField;
begin
  Result := TdaMetaField(FFields[aIndex]);
end; {function, GetField}

{------------------------------------------------------------------------------}
{ TdaMetaTable.GetFieldCount }

function TdaMetaTable.GetFieldCount: Integer;
begin
  Result := FFields.Count
end; {function, GetFieldCount}

{------------------------------------------------------------------------------}
{ TdaMetaTable.GetFields }

procedure TdaMetaTable.GetFields(aFields: TList);
var
  liIndex: Integer;
begin

  aFields.Clear;

  for liIndex := 0 to FFields.Count - 1 do
    aFields.Add(FFields[liIndex]);

end; {function, GetFields}

{------------------------------------------------------------------------------}
{TdaMetaTable.GetRawTableName}

function TdaMetaTable.GetRawTableName: String;
begin
  if (Length(FOwnerName) > 0) then
    Result := FOwnerName + '.' + FName
  else
    Result := FName;
end; {function, GetRawTableName}

{------------------------------------------------------------------------------}
{ TdaMetaTable.SetFields }

procedure TdaMetaTable.SetFields(aFields: TList);
var
  liIndex: Integer;
begin

  FreeFields;

  for liIndex := 0 to aFields.Count - 1 do
    FFields.Add(aFields[liIndex]);

  FPopulated := True;

end; {function, SetFields}

{*******************************************************************************
 *
 ** M E T A   F I E L D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaMetaField.Create }

constructor TdaMetaField.Create;
begin

  inherited Create;

  FAlias := '';
  FAutoSearch := False;
  FDataType := dtNotKnown;
  FDisplayFormat := '';
  FDisplayWidth := 0;
  FName := '';
  FLength := 0;
  FMandatory := False;
  FSearchable := False;
  FSelectable := False;
  FSortable := False;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaMetaField.Destroy }

destructor TdaMetaField.Destroy;
begin

  inherited Destroy;

end; {destructor, Destroy}

{*******************************************************************************
 *
 ** M  E T A   T A B L E   C O L L E C T I O N   B A S E
 *
 *******************************************************************************}

constructor TdaMetaTableCollection.Create;
begin

  inherited;

  InnerList.OwnsObjects := True;

  FRawTableNameIndex := TppHashTable.Create();

end;

destructor TdaMetaTableCollection.Destroy;
begin

  FRawTableNameIndex.Free;
  FRawTableNameIndex := nil;

  inherited;

end;

function TdaMetaTableCollection.Add(aItem: TdaMetaTable): Integer;
begin
  Result := InternalAdd(aItem);

end;

procedure TdaMetaTableCollection.Delete(aIndex: Integer);
begin

  InternalRemove(Items[aIndex]);

end;

function TdaMetaTableCollection.GetRawTableNameIndex: TppHashTable;
begin
  if not(IndexValid) then
    RebuildIndex();
  Result := FRawTableNameIndex;
end;

function TdaMetaTableCollection.GetItemByName(Name: String): TdaMetaTable;
begin
  Result := TdaMetaTable(GetItemForKey(AnsiUpperCase(Name)));
end;

function TdaMetaTableCollection.GetItemByRawTableName(Name: String): TdaMetaTable;
var
  liIndex: Integer;
begin
  liIndex := GetRawTableNameIndex.ValueOf(AnsiUpperCase(Name));

  if (liIndex >= 0) then
    Result := TdaMetaTable(InnerList[liIndex])
  else // get the item by name
    Result := GetItemByName(Name);

end;

function TdaMetaTableCollection.GetItems(Index: Integer): TdaMetaTable;
begin
  Result := TdaMetaTable(InnerList[Index]);
end;

function TdaMetaTableCollection.GetKey(aObject: TObject): String;
begin

  if FUseTableOwnerName then
    Result :=  TdaMetaTable(aObject).OwnerName + '.' + TdaMetaTable(aObject).Name
  else
    Result := TdaMetaTable(aObject).Name;

  Result := AnsiUpperCase(Result);

end;

procedure TdaMetaTableCollection.RebuildIndex;
var
  liIndex: Integer;
  lTable: TdaMetaTable;
begin

  inherited;

  FRawTableNameIndex.Free;

  if (InnerList.Count = 0) then
    FRawTableNameIndex := TppHashTable.Create
  else
    FRawTableNameIndex := TppHashTable.Create(InnerList.Count);

  for liIndex := 0 to InnerList.Count - 1 do
    begin
      lTable := TdaMetaTable(InnerList[liIndex]);
      FRawTableNameIndex.Add(AnsiUpperCase(lTable.RawTableName), liIndex);
    end;
    
end;

procedure TdaMetaTableCollection.SetUseTableOwnerName(const Value: Boolean);
begin
  if (FUseTableOwnerName = Value) then Exit;

  FUseTableOwnerName := Value;
  RebuildIndex;
end;


end.


