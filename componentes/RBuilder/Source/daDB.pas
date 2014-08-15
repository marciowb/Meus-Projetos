{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daDB;

interface

{$I ppIfDef.pas}

uses
  Windows,
  Classes, SysUtils, Forms, TypInfo,
  ppComm, ppClass, ppDB, ppTypes, ppUtils, ppDsIntf,
  daSQLReservedWords;

type

  TdaDataSet = class;

  TdaSessionClass = class of TdaSession;
  TdaDataSetClass = class of TdaDataSet;

  { TdaSession }
  TdaSession = class(TppCommunicator)
    private
      FDataOwner: TComponent;

    protected
      function GetDefaultDatabase(const aDatabaseName: String): TComponent; virtual;
      function IsNamedDatabase(const aDatabaseName: String; aDatabase: TComponent): Boolean; virtual;
      procedure SetDataOwner(aDataOwner: TComponent); virtual;

    public
      constructor Create(aComponent: TComponent); override;
      
      class function ClassDescription: String; virtual; {abstract - keyword removed to support CBuilder}
      class function DataSetClass: TdaDataSetClass; virtual; {abstract - keyword removed to support CBuilder}
      class function DatabaseClass: TComponentClass; virtual;

      function CreateDataSet(aOwner: TComponent; const aDatabaseName: String): TdaDataSet;
      function  ContainsSQLFunctionCall(const aString: String; aDatabaseType: TppDatabaseType): Boolean; virtual;
      function  DefaultCollationType(aDatabaseType: TppDatabaseType): TppCollationType; virtual;
      function  DefaultGuidCollationType(aDatabaseType: TppDatabaseType): TppGuidCollationType; virtual;
      function DefaultNullCollationType(aDatabaseType: TppDatabaseType): TppNullCollationType; virtual;
      function  DefaultIsCaseSensitive(aDatabaseType: TppDatabaseType): Boolean; virtual;
      function  DefaultSQLType(aDatabaseType: TppDatabaseType): TppSQLType; virtual;
      function GetDatabaseForName(const aName: String): TComponent; virtual;
      procedure GetDatabaseNames(aList: TStrings); virtual;
      function  GetDatabaseType(const aDatabaseName: String): TppDatabaseType; virtual; abstract;
      function GetMaxFieldAliasLength(aTableName: String): Integer; virtual;
      procedure GetTableNames(const aDatabaseName: String; aList: TStrings); virtual; abstract;
      function  IsSQLReservedWord(const aString: String; aDatabaseType: TppDatabaseType): Boolean; virtual;
      function  ValidDatabaseTypes: TppDatabaseTypes; virtual; abstract;

      function  GetSearchCriteriaDateFormat(aDatabaseType: TppDatabaseType; const aDatabaseName: String): String; virtual;
      function  GetSearchCriteriaTimeFormat(aDatabaseType: TppDatabaseType; const aDatabaseName: String): String; virtual;

      property DataOwner: TComponent read FDataOwner write SetDataOwner;

  end; {class, TdaSession}


  { TdaDataSet }
  TdaDataSet = class(TppCommunicator)
    private
      FDatabaseName: String;
      FDatabase: TComponent;
      FDataName: String;
      FFields: TList;

      procedure FreeFields;
      function  GetFieldCount: Integer;
      function  GetFieldForIndex(aIndex: Integer): TppField;

    protected
      function  AddField(aField: TppField): Integer;
      procedure BuildFieldList; virtual;
      function  GetActive: Boolean; virtual; abstract;
      procedure SetActive(Value: Boolean); virtual; abstract;
      procedure SetDatabase(aDatabase: TComponent); virtual;
      procedure SetDataName(const aDataName: String); virtual;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function ClassDescription: String; virtual; {abstract - keyword removed to support CBuilder}

      procedure Close;
      function  FieldForFieldName(const aFieldName: String): TppField;
      procedure GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings); virtual; abstract;
      procedure GetFieldsForSQL(aList: TList; aSQL: TStrings); virtual; abstract;
      procedure Open;

      property Active: Boolean read GetActive write SetActive;
      property Database: TComponent read FDatabase write SetDatabase;
      property DataName: String read FDataName write SetDataName;
      property FieldCount: Integer read GetFieldCount;
      property Fields[Index: Integer]: TppField read GetFieldForIndex;

  end; {class, TdaDataSet}

  { TdaConnectionList }
  TdaConnectionList = class(TStringList)
    private
      FFormDesigner: TppFormDesigner;
      FSessionClass: TdaSessionClass;
      FDataOwner: TComponent;

      procedure AddConnection(aConnection: TComponent);

      procedure BuildList;

      procedure BuildListDesignTime(aDesigner: TppFormDesigner);
      procedure BuildListRunTime(aOwner: TComponent);
      procedure BuildListFromOwner(aOwner: TComponent);

      function GetConnectionClass: TComponentClass;
      procedure GetDataItemsCallback(const S: string);
      function GetFormDesigner: TppFormDesigner;

    public
      constructor Create(aDataOwner: TComponent; aSessionClass: TdaSessionClass); virtual;

      destructor Destroy; override;

  end; {class, TdaConnectionList}


  procedure daRegisterSession(aSessionClass: TdaSessionClass);
  procedure daUnRegisterSession(aSessionClass: TdaSessionClass);
  procedure daGetSessionClasses(aList: TStrings);
  function  daGetSessionClass(aClassDescription: String): TdaSessionClass;

  procedure daRegisterDataSet(aDataSetClass: TdaDataSetClass);
  procedure daUnRegisterDataSet(aDataSetClass: TdaDataSetClass);
  procedure daGetDataSetClasses(aList: TStrings);
  function  daGetDataSetClass(aClassDescription: String): TdaDataSetClass;

  procedure daGetDatabaseNames(aSessionClass: TdaSessionClass; aList: TStrings; aOwner: TComponent);

  procedure daGetDatabaseObjectsFromOwner(aSessionClass: TdaSessionClass; aList: TStrings; aOwner: TComponent);


implementation

uses
  SyncObjs;

var
  uSessionClassList: TStringList = nil;
  uDataSetClassList: TStringList = nil;
  uLock: TCriticalSection;


{******************************************************************************
 *
 ** S E S S I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSession.Create }

constructor TdaSession.Create(aComponent: TComponent);
begin

  inherited Create(aComponent);

  FDataOwner := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaSession.ClassDescription }

class function TdaSession.ClassDescription: String;
begin
  {return default class description - descendants should override this}
  Result := ClassName;

end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaSession.DataSetClass }
class function TdaSession.DataSetClass: TdaDataSetClass;
begin
  {descendants must override to return dataset class}
  Result := nil;
end; {class function, DataSetClass}


{------------------------------------------------------------------------------}
{ TdaSession.DatabaseClass }

class function TdaSession.DatabaseClass: TComponentClass;
begin
  {descendants can override this with TDatabase, TIBDatabase, etc.}
  Result := nil;
end; {class function, DatabaseClass}

{------------------------------------------------------------------------------}
{ TdaSession.DatabaseClass }

function TdaSession.CreateDataSet(aOwner: TComponent; const aDatabaseName: String): TdaDataSet;
begin
  Result := DataSetClass.Create(aOwner);
  Result.Database := GetDatabaseForName(aDatabaseName);

end; {function, CreateDataSet}


{------------------------------------------------------------------------------}
{ TdaSession.SetDataOwner }

procedure TdaSession.SetDataOwner(aDataOwner: TComponent);
begin
  FDataOwner := aDataOwner;
end; {procedure, SetDataOwner}

{------------------------------------------------------------------------------}
{ TdaSession.DefaultCollationType }

function  TdaSession.DefaultCollationType(aDatabaseType: TppDatabaseType): TppCollationType;
begin

  case aDatabaseType of
    dtAdvantage:   Result := ctASCII;
    dtParadox:     Result := ctASCII;
    dtInterBase:   Result := ctASCII;
    dtFirebird:    Result := ctASCII;
    dtMSAccess:    Result := ctANSI;
    dtMSSQLServer: Result := ctANSI;
    dtSybaseASA:   Result := ctANSI;
    dtSybaseASE:   Result := ctANSI;
    dtOracle:      Result := ctANSI;
    else
      Result := ctANSI;
  end;

end; {procedure, DefaultCollationType}

{------------------------------------------------------------------------------}
{ TdaSession.DefaultGuidCollationType }

function  TdaSession.DefaultGuidCollationType(aDatabaseType: TppDatabaseType): TppGuidCollationType;
begin

  case aDatabaseType of
    dtMSSQLServer: Result := gcMSSQLServer;
    dtMSAccess: Result := gcMSAccess;
  else
    Result := gcString;
  end;

end; {procedure, DefaultCollationType}

{------------------------------------------------------------------------------}
{ TdaSession.DefaultIsCaseSensitive }

function TdaSession.DefaultIsCaseSensitive(aDatabaseType: TppDatabaseType): Boolean;
begin

  case aDatabaseType of
    dtAdvantage:   Result := False;
    dtParadox:     Result := True;
    dtInterBase:   Result := False;
    dtFirebird:    Result := False;
    dtMSAccess:    Result := False;
    dtMSSQLServer: Result := False;
    dtSybaseASA:   Result := False;
    dtSybaseASE:   Result := False;
    dtOracle:      Result := False;
    else
      Result := False;
  end;

end; {procedure, DefaultIsCaseSensitive}

{------------------------------------------------------------------------------}
{ TdaSession.DefaultSQLType }

function TdaSession.DefaultSQLType(aDatabaseType: TppDatabaseType): TppSQLType;
begin

  case aDatabaseType of
    dtParadox:     Result := sqBDELocal;
    dtInterBase:   Result := sqSQL2;
    dtFirebird:    Result := sqSQL2;
    dtMSAccess:    Result := sqSQL2;
    dtMSSQLServer: Result := sqSQL2;
    dtSybaseASA:   Result := sqSQL2;
    dtSybaseASE:   Result := sqSQL1;
    dtOracle:      Result := sqSQL1;
    else
      Result := sqSQL1;
  end;

end; {function, DefaultSQLType}

{------------------------------------------------------------------------------}
{ TdaSession.GetSearchCriteriaDateFormat }

function TdaSession.GetSearchCriteriaDateFormat(aDatabaseType: TppDatabaseType; const aDatabaseName: String): String;
begin

  {return a format usable by FormatDate}
  case aDatabaseType of

    dtMSAccess:
      Result := 'YYYY-MM-DD';

    dtMSSQLServer, dtMySQL:
      Result := 'YYYY-MM-DD';

    dtSybaseASA, dtSybaseASE, dtOracle:
      Result := 'YYYY/MM/DD';

    dtAdvantage:
      Result := 'YYYY-MM-DD';

    else
      Result := 'MM/DD/YYYY';

  end;

end; {function, GetSearchCriteriaDateFormat}

{------------------------------------------------------------------------------}
{ TdaSession.GetSearchCriteriaTimeFormat }

function TdaSession.GetSearchCriteriaTimeFormat(aDatabaseType: TppDatabaseType; const aDatabaseName: String): String;
begin
  {return a format usable by FormatDateTime}
  case aDatabaseType of

    dtMSAccess:
      Result := 'HH::MM::SS';

    else
      Result := 'HH:MM:SS';
  end;
  
end; {function, GetSearchCriteriaTimeFormat}

{------------------------------------------------------------------------------}
{ TdaSession.IsSQLReservedWord }

function TdaSession.IsSQLReservedWord(const aString: String; aDatabaseType: TppDatabaseType): Boolean;
begin
  Result := daIsSQLReservedWord(aString, aDatabaseType)
end; {function, IsSQLReservedWord}

{------------------------------------------------------------------------------}
{ TdaSession.ContainsSQLFunctionCall }

function TdaSession.ContainsSQLFunctionCall(const aString: String; aDatabaseType: TppDatabaseType): Boolean;
begin
  Result := daContainsSQLFunctionCall(aString, aDatabaseType)
end; {function, ContainsSQLFunctionCall}

{------------------------------------------------------------------------------}
{ TdaSession.DefaultNullCollationType }

function TdaSession.DefaultNullCollationType(aDatabaseType: TppDatabaseType): TppNullCollationType;
begin

  if (aDatabaseType = dtOracle) then
    Result := ncNullsLast
  else
    Result := ncNullsFirst;

end; {procedure, DefaultCollationType}

{------------------------------------------------------------------------------}
{ TdaSession.GetDatabaseForName }

function TdaSession.GetDatabaseForName(const aName: String): TComponent;
var
  lList: TStringList;
  liIndex: Integer;
  lDatabase: TComponent;
  lsError: String;
begin

  Result := nil;

  lList := TStringList.Create;

  try
    {build list of available database connection objects}
    GetDatabaseNames(lList);

    liIndex := 0;

    {find the named connection object}
    while (Result = nil) and (liIndex < lList.Count) do
      begin
        lDatabase := TComponent(lList.Objects[liIndex]);

        if (lDatabase <> nil) and IsNamedDatabase(aName, lDatabase) then
          Result := lDatabase
        else
          Inc(liIndex);
      end;

  finally
    lList.Free;

  end;

  if (Result = nil) and (aName <> '') then
    if not(ppInMainThread) then
      begin
        lsError := 'TdaSession.GetDatabaseForName: No ' +  DatabaseClass.ClassName + ' object found for specified name, ' + aName + '.' + #13#10;
        lsError := lsError + ' A separate database connection is required for each thread.';
        raise EDataError.Create(lsError);
      end
    else
      Result := GetDefaultDatabase(aName);

end;

{------------------------------------------------------------------------------}
{ TdaSession.GetDefaultDatabase }

function TdaSession.GetDefaultDatabase(const aDatabaseName: String): TComponent;
begin
  {descendants can override}
  Result := nil;

end;

{------------------------------------------------------------------------------}
{ TdaSession.GetDatabaseNames }

procedure TdaSession.GetDatabaseNames(aList: TStrings);
begin

  daGetDatabaseObjectsFromOwner(TdaSessionClass(Self.ClassType), aList, DataOwner);

end; {procedure, GetDatabaseNames}

{------------------------------------------------------------------------------}
{ TdaSession.GetMaxFieldAliasLength }

function TdaSession.GetMaxFieldAliasLength(aTableName: String): Integer;
begin
  Result := 25;
end;

{------------------------------------------------------------------------------}
{ TdaSession.IsNamedDatabase }

function TdaSession.IsNamedDatabase(const aDatabaseName: String; aDatabase: TComponent): Boolean;
begin
  Result := (AnsiCompareText(aDatabase.Name, aDatabaseName) = 0);

end;


{******************************************************************************
 *
 ** D A T A S E T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDataSet.Create }

constructor TdaDataSet.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FDataName := '';
  FDatabaseName := '';
  FFields := TList.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaDataSet.Destroy }

destructor TdaDataSet.Destroy;
begin

  FreeFields;

  FFields.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaDataSet.FreeFields }

procedure TdaDataSet.FreeFields;
var
  liField: Integer;

begin

  {free fields}
  for liField := (FFields.Count-1) downto 0 do
    TObject(FFields[liField]).Free;

  FFields.Clear;

end; {procedure, FreeFields}

{------------------------------------------------------------------------------}
{ TdaDataSet.ClassDescription }

class function TdaDataSet.ClassDescription: String;
begin
  {descendants should override to return a class description}
  Result := ClassName;

end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaDataSet.SetDatabase }

procedure TdaDataSet.SetDatabase(aDatabase: TComponent);
begin
  FDatabase := aDatabase;
end;

{------------------------------------------------------------------------------}
{ TdaDataSet.SetDataName }

procedure TdaDataSet.SetDataName(const aDataName: String);
begin
  FDataName := aDataName;
end; {procedure, SetDataName}

{------------------------------------------------------------------------------}
{ TdaDataSet.Open }

procedure TdaDataSet.Open;
begin
  SetActive(True);
end; {procedure, Open}

{------------------------------------------------------------------------------}
{ TdaDataSet.Close }

procedure TdaDataSet.Close;
begin
  SetActive(False);
end; {procedure, Close}

{------------------------------------------------------------------------------}
{ TdaDataSet.GetFieldCount }

function TdaDataSet.GetFieldCount: Integer;
begin

  if (FFields.Count = 0) then
    BuildFieldList;

  Result := FFields.Count;

end; {function, GetFieldCount}

{------------------------------------------------------------------------------}
{ TdaDataSet.GetFieldForIndex }

function TdaDataSet.GetFieldForIndex(aIndex: Integer): TppField;
begin
  
  if (FFields.Count = 0) then
    BuildFieldList;

  Result := TppField(FFields[aIndex]);

end; {function, GetFieldForIndex}

{------------------------------------------------------------------------------}
{ TdaDataSet.AddField }

function TdaDataSet.AddField(aField: TppField): Integer;
begin
  if aField.Name = '' then
    aField.Name := GetValidName(aField);
  Result := FFields.Add(aField);
end; {function, AddField}

{------------------------------------------------------------------------------}
{ TdaDataSet.BuildFieldList }

procedure TdaDataSet.BuildFieldList;
begin
  FreeFields;
end; {function, BuildFieldList}

{------------------------------------------------------------------------------}
{ TdaDataSet.FieldForFieldName }

function TdaDataSet.FieldForFieldName(const aFieldName: String): TppField;
var
  lbFound: Boolean;
  liIndex: Integer;
  lField: TppField;
begin

  liIndex := 0;
  lbFound := False;
  lField := nil;

  while (liIndex < FFields.Count) and not(lbFound) do
    begin
      lField := TppField(FFields[liIndex]);

      if (CompareText(lField.FieldName, aFieldName) = 0) then
        lbFound := True
      else
        Inc(liIndex);
    end;

  if lbFound then
    Result := lField
  else
    Result := nil;

end; {function, FieldForFieldName}


{******************************************************************************
*
*  C O N N E C T I O N  L I S T
*
******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaConnectionList.Create }

constructor TdaConnectionList.Create(aDataOwner: TComponent; aSessionClass: TdaSessionClass);
begin

  inherited  Create;

  FSessionClass := aSessionClass;
  FDataOwner := aDataOwner;

  BuildList;

end;  {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaConnectionList.Destroy }

destructor TdaConnectionList.Destroy;
begin

  inherited Destroy;

end; {constructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaConnectionList.AddConnection }

procedure TdaConnectionList.AddConnection(aConnection: TComponent);
begin

  {do not allow duplicates}
  if (IndexOfObject(aConnection) <> -1) then Exit;

  {only add to list, if pipeline's Visible property set to true}
  AddObject(aConnection.Name, aConnection);

end; {procedure, AddConnection}

{------------------------------------------------------------------------------}
{ TdaConnectionList.BuildList }

procedure TdaConnectionList.BuildList;
begin

  FFormDesigner := GetFormDesigner;

  if (FFormDesigner = nil) then
    BuildListRunTime(FDataOwner)
  else
    BuildListDesignTime(FFormDesigner);

end; {procedure, BuildList}

{------------------------------------------------------------------------------}
{ TdaConnectionList.GetFormDesigner }

function TdaConnectionList.GetFormDesigner: TppFormDesigner;
var
  liIndex: Integer;
  lComponent: TComponent;
  lReport: TppCustomReport;
begin

  liIndex := 0;
  Result := nil;

  while (Result = nil) and (liIndex < FDataOwner.ComponentCount) do
    begin
      lComponent := FDataOwner.Components[liIndex];

      if (lComponent is TppCustomReport) then
        lReport := TppCustomReport(lComponent)
      else
        lReport := nil;

      if (lReport <> nil) then
        Result := lReport.FormDesigner;

      Inc(liIndex);

    end;

end; {function, GetFormDesigner}

{------------------------------------------------------------------------------}
{ TdaConnectionList.BuildListDesignTime }

procedure TdaConnectionList.BuildListDesignTime(aDesigner: TppFormDesigner);
var
  lConnectionClass: TComponentClass;
begin

  lConnectionClass := GetConnectionClass;

  aDesigner.GetComponentNames(GetTypeData(lConnectionClass.ClassInfo), GetDataItemsCallback);

end; {procedure, BuildListDesignTime}

{------------------------------------------------------------------------------}
{ TdaConnectionList.GetDataItemsCallback }

procedure TdaConnectionList.GetDataItemsCallback(const S: string);
begin
  AddConnection(FFormDesigner.GetComponent(S));

end; {procedure, GetDataItemsCallback}

{------------------------------------------------------------------------------}
{ TdaConnectionList.BuildListRunTime }

procedure TdaConnectionList.BuildListRunTime(aOwner: TComponent);
var
  liIndex: Integer;
begin

  if (aOwner <> nil) then
    BuildListFromOwner(aOwner);

  if not(ppInMainThread) then
    {do nothing, if this is a multi-threaded app then we really don't want it pulling
     in other datamodules, because those are usually associated with individual
     threads in a multi-threaded app. }

  else
    begin

      for liIndex := 0 to Screen.DataModuleCount - 1 do
        if (aOwner <> Screen.DataModules[liIndex]) then
          BuildListFromOwner(Screen.DataModules[liIndex]);

      for liIndex := 0 to Screen.FormCount - 1 do
        if (aOwner <> Screen.Forms[liIndex]) then
          BuildListFromOwner(Screen.Forms[liIndex]);

    end;



end; {procedure, BuildListRunTime}

{------------------------------------------------------------------------------}
{ TdaConnectionList.BuildListFromOwner }

procedure TdaConnectionList.BuildListFromOwner(aOwner: TComponent);
var
  liIndex: Integer;

begin

  for liIndex := 0 to aOwner.ComponentCount-1 do
    if (aOwner.Components[liIndex] is GetConnectionClass) then
      AddConnection(aOwner.Components[liIndex]);

end; {procedure, BuildListFromOwner}

{------------------------------------------------------------------------------}
{ TdaConnectionList.GetConnectionClass }

function TdaConnectionList.GetConnectionClass: TComponentClass;
begin
  if (FSessionClass <> nil) then
    Result := FSessionClass.DatabaseClass
  else
    Result := nil;

end; {function, GetConnectionClass}

{******************************************************************************
 *
 ** S E S S I O N   R E G I S T E R   P R O C E D U R E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ daGetSessionClassList }

function daGetSessionClassList: TStrings;
begin

  uLock.Acquire;

  try

    if (uSessionClassList = nil) then
      uSessionClassList := TStringList.Create;

    Result := uSessionClassList;

  finally
    uLock.Release;

  end;

end; {function, daGetSessionClassList}

{------------------------------------------------------------------------------}
{ daGetSessionClasses }

procedure daGetSessionClasses(aList: TStrings);
begin

  uLock.Acquire;

  try

    aList.Assign(daGetSessionClassList);
  finally
    uLock.Release;

  end;

end; {procedure, GetSessionClasses}


{------------------------------------------------------------------------------}
{ daGetSessionClass }

function daGetSessionClass(aClassDescription: String): TdaSessionClass;
var
  liIndex: Integer;
  lClassList: TStrings;
begin

  uLock.Acquire;

  try

    lClassList := daGetSessionClassList;

    liIndex := lClassList.IndexOf(aClassDescription);

    if liIndex >= 0 then
      Result := TdaSessionClass(lClassList.Objects[liIndex])
    else
      Result := nil;
      
  finally
    uLock.Release;

  end;


end; {procedure, daGetSessionClass}

{------------------------------------------------------------------------------}
{ daRegisterSession }

procedure daRegisterSession(aSessionClass: TdaSessionClass);
var
  lClassList: TStrings;
  liIndex: Integer;
begin

  uLock.Acquire;

  try

    if (aSessionClass = nil) then Exit;

    lClassList := daGetSessionClassList;

    liIndex :=  lClassList.IndexOf(aSessionClass.ClassDescription);

    if (liIndex = -1) then
      begin
        RegisterClass(aSessionClass);

        lClassList.AddObject(aSessionClass.ClassDescription, TObject(aSessionClass));
      end;

  finally
    uLock.Release;
  end;

end; {procedure, daRegisterSession}

{------------------------------------------------------------------------------}
{ daUnRegisterSession }

procedure daUnRegisterSession(aSessionClass: TdaSessionClass);
var
  lClassList: TStrings;
  liIndex: Integer;
begin

  uLock.Acquire;

  try

    if (aSessionClass = nil) then Exit;

    if (uSessionClassList = nil) then Exit;

    lClassList := daGetSessionClassList;

    liIndex := lClassList.IndexOf(aSessionClass.ClassDescription);

    if (liIndex >= 0) then
      begin
        UnRegisterClass(aSessionClass);

        lClassList.Delete(liIndex);

      end;

  finally
    uLock.Release;
  end;

end; {procedure, daUnRegisterSession}

{******************************************************************************
 *
 ** D A T A S E T   R E G I S T E R   P R O C E D U R E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ daGetDataSetClassList }

function daGetDataSetClassList: TStrings;
begin

  uLock.Acquire;

  try

    if (uDataSetClassList = nil) then
      uDataSetClassList := TStringList.Create;

    Result := uDataSetClassList;

  finally
    uLock.Release;
  end;

end; {function, daGetDataSetClassList}

{------------------------------------------------------------------------------}
{ daGetDataSetClasses }

procedure daGetDataSetClasses(aList: TStrings);
begin

  uLock.Acquire;

  try
    aList.Assign(daGetDataSetClassList);

  finally
    uLock.Release;
  end;

end; {procedure, GetDataSetClasses}

{------------------------------------------------------------------------------}
{ daGetDataSetClass }

function daGetDataSetClass(aClassDescription: String): TdaDataSetClass;
var
  liIndex: Integer;
  lClassList: TStrings;
begin

  uLock.Acquire;

  try

    lClassList := daGetDataSetClassList;

    liIndex := lClassList.IndexOf(aClassDescription);

    if liIndex >= 0 then
      Result := TdaDataSetClass(lClassList.Objects[liIndex])
    else
      Result := nil;

  finally
    uLock.Release;
  end;

end; {procedure, daGetSessionClass}

{------------------------------------------------------------------------------}
{ daRegisterDataSet }

procedure daRegisterDataSet(aDataSetClass: TdaDataSetClass);
var
  lClassList: TStrings;
  liIndex: Integer;
begin

  uLock.Acquire;

  try

    if (aDataSetClass = nil) then Exit;

    if (uDataSetClassList = nil) then Exit;

    lClassList := daGetDataSetClassList;

    liIndex :=  lClassList.IndexOf(aDataSetClass.ClassDescription);

    if (liIndex = -1) then
      begin
        RegisterClass(aDataSetClass);

        lClassList.AddObject(aDataSetClass.ClassDescription, TObject(aDataSetClass));
      end;

  finally
    uLock.Release;

  end;

end; {procedure, daRegisterDataSet}

{------------------------------------------------------------------------------}
{ daUnRegisterDataSet }

procedure daUnRegisterDataSet(aDataSetClass: TdaDataSetClass);
var
  lClassList: TStrings;
  liIndex: Integer;
begin

  uLock.Acquire;

  try

    if (aDataSetClass = nil) then Exit;

    lClassList := daGetDataSetClassList;

    liIndex := lClassList.IndexOf(aDataSetClass.ClassDescription);

    if (liIndex >= 0) then
      begin
        UnRegisterClass(aDataSetClass);

        lClassList.Delete(liIndex);

      end;
      
  finally
    uLock.Release;

  end;

end; {procedure, daUnRegisterDataSet}

{------------------------------------------------------------------------------}
{ daGetDatabaseNames }

procedure daGetDatabaseNames(aSessionClass: TdaSessionClass; aList: TStrings; aOwner: TComponent);
var
  lSession: TdaSession;
begin

  uLock.Acquire;

  try

    aList.Clear;

    if (aSessionClass = nil) then Exit;

    lSession := aSessionClass.Create(nil);
    lSession.DataOwner := aOwner;
    lSession.GetDatabaseNames(aList);

    lSession.Free;
    
  finally
    uLock.Release;

  end;

end; {procedure, daGetDatabaseNames}

{------------------------------------------------------------------------------}
{ daGetObjectsInComponent }

procedure daGetObjectsInComponent(aObjectClass: TClass; aList: TStrings; aComponent: TComponent);
var
  liIndex: Integer;
  lComponent: TComponent;
begin

  uLock.Acquire;

  try

    {add database objects residing in owner}
    for liIndex := 0 to aComponent.ComponentCount-1 do
      if aComponent.Components[liIndex] is aObjectClass then
        begin
          lComponent := aComponent.Components[liIndex];
          aList.AddObject(lComponent.Name, lComponent);
        end;

  finally
    uLock.Release;

  end;

end; {procedure, daGetObjectsInComponent}

{$IFDEF Delphi6}

{------------------------------------------------------------------------------}
{ daGetDatabaseObjectsFromOwner }

procedure daGetDatabaseObjectsFromOwner(aSessionClass: TdaSessionClass; aList: TStrings; aOwner: TComponent);
var
  liIndex: Integer;
  lConnectionList: TdaConnectionList;
  lComponent: TComponent;
begin

  if (aOwner = nil) then Exit;


  uLock.Acquire;

  try

    lConnectionList := TdaConnectionList.Create(aOwner, aSessionClass);

    try

      for liIndex := 0 to lConnectionList.Count-1 do
        begin
          lComponent := TComponent(lConnectionList.Objects[liIndex]);
          if (aList.IndexOfObject(lComponent) = -1) then
            aList.AddObject(lComponent.Name, lComponent);
        end;

    finally
      lConnectionList.Free;

    end

  finally
    uLock.Release;

  end;


end; {procedure, daGetDatabaseObjectsFromOwner}

{$ELSE}

{------------------------------------------------------------------------------}
{ daGetDatabaseObjectsFromOwner }

procedure daGetDatabaseObjectsFromOwner(aSessionClass: TdaSessionClass; aList: TStrings; aOwner: TComponent);
var
  liIndex: Integer;
begin

  if (aOwner = nil) then Exit;


  uLock.Acquire;

  try
      {if this is a multi-threaded app then we really don't want it pulling
       in other datamodules, because those are usually associated with individual
       threads in a multi-threaded app. }
    if not(ppInMainThread) then
      daGetObjectsInComponent(aSessionClass.DatabaseClass, aList, aOwner)

    else
      begin

        for liIndex := 0 to Screen.FormCount-1 do
          daGetObjectsInComponent(aSessionClass.DatabaseClass, aList, Screen.Forms[liIndex]);

        {add database objects residing in data modules }
        for liIndex := 0 to Screen.DataModuleCount-1 do
          daGetObjectsInComponent(aSessionClass.DatabaseClass, aList, Screen.DataModules[liIndex]);

      end;

  finally
    uLock.Release;

  end;

end; {procedure, daGetDatabaseObjectsFromOwner}


{$ENDIF}


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization
  uLock := TCriticalSection.Create;


finalization

  uSessionClassList.Free;
  uSessionClassList := nil;

  uDataSetClassList.Free;
  uDataSetClassList := nil;

  uLock.Free;
  uLock := nil;

end.
