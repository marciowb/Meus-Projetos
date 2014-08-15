{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daADS;

interface

uses Windows, Classes, SysUtils, Forms, ExtCtrls, DB,IniFiles,
     ppComm, ppClass, ppDBPipe, ppDB, ppClasUt, ppTypes,
     ppFileUtils,
     daDB, daQueryDataView, daDataView, daPreviewDataDlg,
     AdsData, AdsTable, AdsCNNCT, AdsSET, AdsFunc;

type

  {ADS DataView Classes:

     1.  ADS TDataSet descendants
           - TDataSets that can be children of a DataView.
           - Override the HasParent method of TComponent to return True
           - Must be registerd with the Delphi IDE using the RegisterNoIcon procedure

       a. TdaChildADSQuery - TADSQuery descendant that can be a child of a DataView
       b. TdaChildADSTable - TADSTable descendant that can be a child of a DataView

     2.  TdaADSSession
           - descendant of TppSession
           - implements GetDatabaseNames, GetTableNames, etc.

     3.  TdaADSDataSet
          - descendant of TppDataSet
          - implements GetFieldNames for SQL

     4.  TdaADSQueryDataView
          - descendant of TppQueryDataView
          - uses the above classes to create the required
            Query -> DataSource -> Pipeline -> Report connection
          - uses the TdaSQL object built by the QueryWizard to assign
            SQL to the TADSQuery etc.

      }

  { TdaChildADSQuery }
  TdaChildADSQuery = class(TADSQuery)
    public
      function HasParent: Boolean; override;
    end;  {class, TdaChildADSQuery}

  { TdaChildADSTable }
  TdaChildADSTable = class(TADSTable)
    public
      function HasParent: Boolean; override;
    end;  {class, TdaChildADSTable}


  { TdaADSSession }
  TdaADSSession = class(TdaSession)
    private
      FReservedWords: TStringList;
      FFunctions: TStringList;

      procedure BuildReservedWordList;
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
      class function GetDefaultADSConnection: TADSConnection;

      function  ContainsSQLFunctionCall(const aString: String; aDatabaseType: TppDatabaseType): Boolean; override;
      function  DefaultSQLType(aDatabaseType: TppDatabaseType): TppSQLType; override;
      procedure GetDatabaseNames(aList: TStrings); override;
      function  GetDatabaseType(const aDatabaseName: String): TppDatabaseType; override;
      procedure GetTableNames(const aDatabaseName: String; aList: TStrings); override;
      function  IsSQLReservedWord(const aString: String; aDatabaseType: TppDatabaseType): Boolean; override;
      function  ValidDatabaseTypes: TppDatabaseTypes; override;

  end; {class, TdaADSSession}


  { TdaADSDataSet }
  TdaADSDataSet = class(TdaDataSet)
    private
      FTable: TADSTable;
      function GetTable: TADSTable;

    protected
      procedure BuildFieldList; override;
      function  GetActive: Boolean; override;
      procedure SetActive(Value: Boolean); override;
      procedure SetDatabase(aDatabase: TComponent); override;
      procedure SetDataName(const aDataName: String); override;
      property Table: TADSTable read GetTable;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;
      class function ClassDescription: String; override;
      procedure GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings); override;
      procedure GetFieldsForSQL(aList: TList; aSQL: TStrings); override;

  end; {class, TdaADSDataSet}


  { TdaADSQueryDataView }
  TdaADSQueryDataView = class(TdaQueryDataView)
    private
      FDataSource: TppChildDataSource;
      FQuery: TdaChildADSQuery;

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

  end; {class, TdaADSQueryDataView}


  { TdaADSIniFile }
  TdaADSIniFile = class
    protected
      class function FileName: String;
      class function DBSection: String;
    public
      class function ConvertPath(aPath: String): String;
      class procedure ReadAliasNames(aList: TStrings);
      class function ReadAliasInfo(const aAliasName: String; var aPath: string; var TType: TAdsTableTypes): Boolean;

    end;


  {Delphi design time registration}
  procedure Register;


implementation

uses
  adsdictionary;

const
  cDefaultConnection = 'DefaultADSConnection';

var
  FADSConnection: TADSConnection;

{******************************************************************************
 *
 ** ADS INI FILE
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaADSIniFile.ConvertPath }

class function TdaADSIniFile.ConvertPath(aPath: String): String;
var
  lChar: string[1];
begin

  Result := aPath;

  lChar := copy(aPath, Length(aPath), 1);

  if (lChar <> ':') and (lChar <> '\') then
    Result := Result + '\';

end; {function, daAddBackSlash}

{------------------------------------------------------------------------------}
{ TdaADSIniFile.FileName }

class function TdaADSIniFile.FileName: String;
var
  lBuffer: array[0..255] of char;
  lsFileName: String;
begin

  // try application directory
  lsFileName := TppFileUtils.GetApplicationFilePath +  'ads.ini';

  if FileExists(lsFileName) then
    Result := lsFileName
  else
    begin
      // use windows directory
      GetWindowsDirectory(lBuffer, SizeOf(lBuffer));

      Result := StrPas(lBuffer) + '\ads.ini';
    end;



end;

{------------------------------------------------------------------------------}
{ TdaADSIniFile.DBSection }

class function TdaADSIniFile.DBSection: String;
begin
  Result := 'Databases';

end;

{------------------------------------------------------------------------------}
{ TdaADSIniFile.ReadAliasNames }

class procedure TdaADSIniFile.ReadAliasNames(aList: TStrings);
var
  lIniFile: TIniFile;
  lAliasNames: TStringList;
begin

  {get AliasNames from ADS.ini file }
  lIniFile := TIniFile.Create(FileName);
  lAliasNames := TStringList.Create;

  try
    lIniFile.ReadSection(DBSection, lAliasNames);

    aList.AddStrings(lAliasNames);

  finally
    lAliasNames.Free;
    lIniFile.Free;

  end;

end;

{------------------------------------------------------------------------------}
{ TdaADSIniFile.ReadAliasInfo }

class function TdaADSIniFile.ReadAliasInfo(const aAliasName: String; var aPath: string; var TType: TAdsTableTypes): Boolean;
var
  lIniFile: TIniFile;
  lsAliasInfo: string;
  liIndex: Integer;
begin

  Result := False;

  lIniFile := TIniFile.Create(FileName);

  try

    {read database alias information from INI file}
    if (aAliasName <> '') then
      lsAliasInfo := lIniFile.ReadString(DBSection, aAliasName, '~')
    else
      lsAliasInfo := '~';

    if (lsAliasInfo <> '~') then
      begin
        liIndex := Pos(';', lsAliasInfo);

        if liIndex > 0 then
          begin

            {get path}
            aPath := Copy(lsAliasInfo, 1, liIndex-1);

            {get table type}
            if UpperCase(Copy(lsAliasInfo,liIndex+1, 1)) = 'A' then
              TType := ttAdsADT
            else if UpperCase(Copy(lsAliasInfo,liIndex+1, 1)) = 'C' then
              TType := ttAdsCDX
            else
              TType := ttAdsNTX;
          end;

        Result := True;

      end;

  finally
    lIniFile.Free;

  end;

end; {class function, ReadAliasInfo}


{******************************************************************************
 *
 ** R E G I S T E R
 *
{******************************************************************************}

procedure Register;
begin

  {ADS DataAccess Components}
  RegisterNoIcon([TdaChildADSQuery,TdaChildADSTable]);

  {ADS DataViews}
  RegisterNoIcon([TdaADSQueryDataView]);

end;


{******************************************************************************
 *
 ** C H I L D   A D S   D A T A    A C C E S S    C O M P O N  E N T S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaChildADSQuery.HasParent }

function TdaChildADSQuery.HasParent: Boolean;
begin
  Result := True;

end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TdaChildADSTable.HasParent }

function TdaChildADSTable.HasParent: Boolean;
begin
  Result := True;

end; {function, HasParent}


{******************************************************************************
 *
 ** A D S   S E S S I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaADSSession.ClassDescription }

constructor TdaADSSession.Create(aComponent: TComponent);
begin

  inherited Create(aComponent);

  FFunctions := TStringList.Create;
  FReservedWords := TStringList.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaADSSession.ClassDescription }

destructor TdaADSSession.Destroy;
begin

  FFunctions.Free;
  FReservedWords.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaADSSession.ClassDescription }

class function TdaADSSession.ClassDescription: String;
begin
  Result := 'ADSSession';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaADSSession.DataSetClass }

class function TdaADSSession.DataSetClass: TdaDataSetClass;
begin
  Result := TdaADSDataSet;
end; {class function, DataSetClass}

{------------------------------------------------------------------------------}
{ TdaADSSession.DatabaseClass }

class function TdaADSSession.DatabaseClass: TComponentClass;
begin
  Result := TADSConnection;
end; {class function, DatabaseClass}


{------------------------------------------------------------------------------}
{ TdaADSSession.GetDefaultADSConnection }

class function TdaADSSession.GetDefaultADSConnection: TADSConnection;
begin

  {create the default ADS Connection, if needed}
  if (FADSConnection = nil) then
    begin
      {create default ADS Connection}
      FADSConnection := TADSConnection.Create(nil);
      FADSConnection.Name := cDefaultConnection;

    end;

  Result := FADSConnection;

end; {class function, GetDefaultADSConnection}

{------------------------------------------------------------------------------}
{ TdaADSSession.GetTableNames }

procedure TdaADSSession.GetTableNames(const aDatabaseName: String; aList: TStrings);
var
  lAdsConnection: TAdsConnection;
  liIndex: Integer;
begin

  aList.Clear;

  lAdsConnection := TAdsConnection(GetDatabaseForName(aDatabaseName));

  if (lAdsConnection = nil) then
    raise EDataError.CreateFmt('No AdsConnection found for database name: %s', [aDataBaseName]);

  if not (lAdsConnection.IsConnected) then
    lAdsConnection.IsConnected := True;

  if (lAdsConnection.IsDictionaryConn) or (lAdsConnection.ConnectPath = '') then
    lAdsConnection.GetTableNames(aList, '')
  else
    begin
      {only specify the file extension when using a connection path and not
       using the ads data dictionary}
      lAdsConnection.GetTableNames(aList, '*.ADT');
      lAdsConnection.GetTableNames(aList, '*.DBF');
    end;

  {strip off file extensions}
  for liIndex := 0 to aList.Count - 1 do
    begin
      aList[liIndex] := StringReplace(aList[liIndex], '.ADT', '', [rfIgnoreCase]);
      aList[liIndex] := StringReplace(aList[liIndex], '.DBF', '', [rfIgnoreCase]);
   end;

end;

{------------------------------------------------------------------------------}
{ TdaADSSession.GetDatabaseNames }

procedure TdaADSSession.GetDatabaseNames(aList: TStrings);
begin

  {call inherited to build list of available TADSConnection components}
  inherited GetDatabaseNames(aList);

  {get AliasNames from ADS.ini file }
  TdaADSIniFile.ReadAliasNames(aList);

end; {procedure, GetDatabaseNames}

{------------------------------------------------------------------------------}
{ TdaADSSession.GetDefaultDatabase }

function TdaADSSession.GetDefaultDatabase(const aDatabaseName: String): TComponent;
var
  lADSConnection: TADSConnection;
begin

  lADSConnection := GetDefaultADSConnection;

  {set ConnectionString property, if needed}
  if (lADSConnection.AliasName <> aDatabaseName) then
    begin
      if lADSConnection.IsConnected then
        lADSConnection.IsConnected := False;
      lADSConnection.AliasName := aDatabaseName;

    end;

  Result := lADSConnection;

end; {function, GetDefaultDatabase}

{------------------------------------------------------------------------------}
{ TdaADSSession.IsNamedDatabase }

function TdaADSSession.IsNamedDatabase(const aDatabaseName: String; aDatabase: TComponent): Boolean;
begin

  Result := (AnsiCompareText(aDatabase.Name, aDatabaseName) = 0);

end; {function, IsNamedDatabase}

{------------------------------------------------------------------------------}
{ TdaADSSession.ValidDatabaseTypes }

function TdaADSSession.ValidDatabaseTypes: TppDatabaseTypes;
begin
  Result := [dtAdvantage];
end; {procedure, ValidDatabaseTypes}

{------------------------------------------------------------------------------}
{ TdaADSSession.GetDatabaseType }

function TdaADSSession.GetDatabaseType(const aDatabaseName: String): TppDatabaseType;
begin
  Result := dtAdvantage;
end; {procedure, GetDatabaseType}

{------------------------------------------------------------------------------}
{ TdaADSSession.DefaultSQLType }

function TdaADSSession.DefaultSQLType(aDatabaseType: TppDatabaseType): TppSQLType;
begin
  Result := sqSQL2;
end; {function, DefaultSQLType}

{------------------------------------------------------------------------------}
{ TdaADSSession.IsSQLReservedWord }

function TdaADSSession.IsSQLReservedWord(const aString: String; aDatabaseType: TppDatabaseType): Boolean;
begin

  if (FReservedWords.Count = 0) then
    BuildReservedWordList;

  Result := (FReservedWords.IndexOf(aString) <> -1);

end; {procedure, IsSQLReservedWord}

{------------------------------------------------------------------------------}
{ TdaADSSession.BuildReservedWordList }

procedure TdaADSSession.BuildReservedWordList;
begin
  FReservedWords.Add('ACTIVE');
  FReservedWords.Add('ADD');
  FReservedWords.Add('ALL');
  FReservedWords.Add('AFTER');
  FReservedWords.Add('ALTER');
  FReservedWords.Add('AND');
  FReservedWords.Add('ANY');
  FReservedWords.Add('AS');
  FReservedWords.Add('ASC');
  FReservedWords.Add('ASCENDING');
  FReservedWords.Add('AT');
  FReservedWords.Add('AUTO');
  FReservedWords.Add('AUTOINC');
  FReservedWords.Add('AVG');
  FReservedWords.Add('BASE_NAME');
  FReservedWords.Add('BEFORE');
  FReservedWords.Add('BEGIN');
  FReservedWords.Add('BETWEEN');
  FReservedWords.Add('BLOB');
  FReservedWords.Add('BOOLEAN');
  FReservedWords.Add('BOTH');
  FReservedWords.Add('BY');
  FReservedWords.Add('BYTES');
  FReservedWords.Add('CACHE');
  FReservedWords.Add('CAST');
  FReservedWords.Add('CHAR');
  FReservedWords.Add('CHARACTER');
  FReservedWords.Add('CHECK');
  FReservedWords.Add('CHECK_POINT_LENGTH');
  FReservedWords.Add('COLLATE');
  FReservedWords.Add('COLUMN');
  FReservedWords.Add('COMMIT');
  FReservedWords.Add('COMMITTED');
  FReservedWords.Add('COMPUTED');
  FReservedWords.Add('CONDITIONAL');
  FReservedWords.Add('CONSTRAINT');
  FReservedWords.Add('CONTAINING');
  FReservedWords.Add('COUNT');
  FReservedWords.Add('CREATE');
  FReservedWords.Add('CSTRING');
  FReservedWords.Add('CURRENT');
  FReservedWords.Add('CURSOR');
  FReservedWords.Add('DATABASE');
  FReservedWords.Add('DATE');
  FReservedWords.Add('DAY');
  FReservedWords.Add('DEBUG');
  FReservedWords.Add('DEC');
  FReservedWords.Add('DECIMAL');
  FReservedWords.Add('DECLARE');
  FReservedWords.Add('DEFAULT');
  FReservedWords.Add('DELETE');
  FReservedWords.Add('DESC');
  FReservedWords.Add('DESCENDING');
  FReservedWords.Add('DISTINCT');
  FReservedWords.Add('DO');
  FReservedWords.Add('DOMAIN');
  FReservedWords.Add('DOUBLE');
  FReservedWords.Add('DROP');
  FReservedWords.Add('ELSE');
  FReservedWords.Add('END');
  FReservedWords.Add('ENTRY_POINT');
  FReservedWords.Add('ESCAPE');
  FReservedWords.Add('EXCEPTION');
  FReservedWords.Add('EXECUTE');
  FReservedWords.Add('EXISTS');
  FReservedWords.Add('EXIT');
  FReservedWords.Add('EXTERNAL');
  FReservedWords.Add('EXTRACT');
  FReservedWords.Add('FILE');
  FReservedWords.Add('FILTER');
  FReservedWords.Add('FLOAT');
  FReservedWords.Add('FOR');
  FReservedWords.Add('FOREIGN');
  FReservedWords.Add('FROM');
  FReservedWords.Add('FULL');
  FReservedWords.Add('FUNCTION');
  FReservedWords.Add('GDSCODE');
  FReservedWords.Add('GENERATOR');
  FReservedWords.Add('GEN_ID');
  FReservedWords.Add('GRANT');
  FReservedWords.Add('GROUP');
  FReservedWords.Add('GROUP_COMMIT_WAIT_TIME');
  FReservedWords.Add('HAVING');
  FReservedWords.Add('HOUR');
  FReservedWords.Add('IF');
  FReservedWords.Add('IN');
  FReservedWords.Add('INT');
  FReservedWords.Add('INACTIVE');
  FReservedWords.Add('INDEX');
  FReservedWords.Add('INNER');
  FReservedWords.Add('INPUT_TYPE');
  FReservedWords.Add('INSERT');
  FReservedWords.Add('INTEGER');
  FReservedWords.Add('INTO');
  FReservedWords.Add('IS');
  FReservedWords.Add('ISOLATION');
  FReservedWords.Add('JOIN');
  FReservedWords.Add('KEY');
  FReservedWords.Add('LONG');
  FReservedWords.Add('LENGTH');
  FReservedWords.Add('LOGFILE');
  FReservedWords.Add('LOWER');
  FReservedWords.Add('LEADING');
  FReservedWords.Add('LEFT');
  FReservedWords.Add('LEVEL');
  FReservedWords.Add('LIKE');
  FReservedWords.Add('LOG_BUFFER_SIZE');
  FReservedWords.Add('MANUAL');
  FReservedWords.Add('MAX');
  FReservedWords.Add('MAXIMUM_SEGMENT');
  FReservedWords.Add('MERGE');
  FReservedWords.Add('MESSAGE');
  FReservedWords.Add('MIN');
  FReservedWords.Add('MINUTE');
  FReservedWords.Add('MODULE_NAME');
  FReservedWords.Add('MONEY');
  FReservedWords.Add('MONTH');
  FReservedWords.Add('NAMES');
  FReservedWords.Add('NATIONAL');
  FReservedWords.Add('NATURAL');
  FReservedWords.Add('NCHAR');
  FReservedWords.Add('NO');
  FReservedWords.Add('NOT');
  FReservedWords.Add('NULL');
  FReservedWords.Add('NUM_LOG_BUFFERS');
  FReservedWords.Add('NUMERIC');
  FReservedWords.Add('OF');
  FReservedWords.Add('ON');
  FReservedWords.Add('ONLY');
  FReservedWords.Add('OPTION');
  FReservedWords.Add('OR');
  FReservedWords.Add('ORDER');
  FReservedWords.Add('OUTER');
  FReservedWords.Add('OUTPUT_TYPE');
  FReservedWords.Add('OVERFLOW');
  FReservedWords.Add('PAGE_SIZE');
  FReservedWords.Add('PAGE');
  FReservedWords.Add('PAGES');
  FReservedWords.Add('PARAMETER');
  FReservedWords.Add('PASSWORD');
  FReservedWords.Add('PLAN');
  FReservedWords.Add('POSITION');
  FReservedWords.Add('POST_EVENT');
  FReservedWords.Add('PRECISION');
  FReservedWords.Add('PROCEDURE');
  FReservedWords.Add('PROTECTED');
  FReservedWords.Add('PRIMARY');
  FReservedWords.Add('PRIVILEGES');
  FReservedWords.Add('RAW_PARTITIONS');
  FReservedWords.Add('RDB$DB_KEY');
  FReservedWords.Add('READ');
  FReservedWords.Add('REAL');
  FReservedWords.Add('RECORD_VERSION');
  FReservedWords.Add('REFERENCES');
  FReservedWords.Add('RESERV');
  FReservedWords.Add('RESERVING');
  FReservedWords.Add('RETAIN');
  FReservedWords.Add('RETURNING_VALUES');
  FReservedWords.Add('RETURNS');
  FReservedWords.Add('REVOKE');
  FReservedWords.Add('RIGHT');
  FReservedWords.Add('ROLLBACK');
  FReservedWords.Add('SECOND');
  FReservedWords.Add('SEGMENT');
  FReservedWords.Add('SELECT');
  FReservedWords.Add('SET');
  FReservedWords.Add('SHARED');
  FReservedWords.Add('SHADOW');
  FReservedWords.Add('SCHEMA');
  FReservedWords.Add('SINGULAR');
  FReservedWords.Add('SIZE');
  FReservedWords.Add('SMALLINT');
  FReservedWords.Add('SNAPSHOT');
  FReservedWords.Add('SOME');
  FReservedWords.Add('SORT');
  FReservedWords.Add('SQLCODE');
  FReservedWords.Add('STABILITY');
  FReservedWords.Add('STARTING');
  FReservedWords.Add('STARTS');
  FReservedWords.Add('STATISTICS');
  FReservedWords.Add('SUB_TYPE');
  FReservedWords.Add('SUBSTRING');
  FReservedWords.Add('SUM');
  FReservedWords.Add('SUSPEND');
  FReservedWords.Add('TABLE');
  FReservedWords.Add('THEN');
  FReservedWords.Add('TIME');
  FReservedWords.Add('TIMESTAMP');
  FReservedWords.Add('TIMEZONE_HOUR');
  FReservedWords.Add('TIMEZONE_MINUTE');
  FReservedWords.Add('TO');
  FReservedWords.Add('TRAILING');
  FReservedWords.Add('TRANSACTION');
  FReservedWords.Add('TRIGGER');
  FReservedWords.Add('TRIM');
  FReservedWords.Add('UNCOMMITTED');
  FReservedWords.Add('UNION');
  FReservedWords.Add('UNIQUE');
  FReservedWords.Add('UPDATE');
  FReservedWords.Add('UPPER');
  FReservedWords.Add('USER');
  FReservedWords.Add('VALUE');
  FReservedWords.Add('VALUES');
  FReservedWords.Add('VARCHAR');
  FReservedWords.Add('VARIABLE');
  FReservedWords.Add('VARYING');
  FReservedWords.Add('VIEW');
  FReservedWords.Add('WAIT');
  FReservedWords.Add('WHEN');
  FReservedWords.Add('WHERE');
  FReservedWords.Add('WHILE');
  FReservedWords.Add('WITH');
  FReservedWords.Add('WORK');
  FReservedWords.Add('WRITE');
  FReservedWords.Add('YEAR');
end; {procedure, BuildReservedWordList}

{------------------------------------------------------------------------------}
{ TdaADSSession.ContainsSQLFunctionCall }

function TdaADSSession.ContainsSQLFunctionCall(const aString: String; aDatabaseType: TppDatabaseType): Boolean;
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
{ TdaADSSession.BuildFunctionList }

procedure TdaADSSession.BuildFunctionList;
begin
  {aggregate functions}
  FFunctions.Add('AVG(');
  FFunctions.Add('COUNT(');
  FFunctions.Add('COUNT(*)');
  FFunctions.Add('MAX(');
  FFunctions.Add('MIN(');
  FFunctions.Add('SUM(');

  {math functions}
  FFunctions.Add('ROUND(');
  FFunctions.Add('TRUNCATE(');
  {the others are not likely, but if you need them, add here}

  {string functions}
  FFunctions.Add('ASCII(');
  FFunctions.Add('BIT_LENGTH(');
  FFunctions.Add('CHAR(');
  FFunctions.Add('CHAR_LENGTH(');
  FFunctions.Add('CHARACTER_LENGTH(');
  FFunctions.Add('CONCAT(');
  FFunctions.Add('INSERT(');
  FFunctions.Add('LCASE(');
  FFunctions.Add('LEFT(');
  FFunctions.Add('LENGTH(');
  FFunctions.Add('LOCATE(');
  FFunctions.Add('LTRIM(');
  FFunctions.Add('OCTET_LENGTH(');
  FFunctions.Add('REPEAT(');
  FFunctions.Add('REPLACE(');
  FFunctions.Add('REPLACE(');
  FFunctions.Add('RIGHT(');
  FFunctions.Add('RTRIM(');
  FFunctions.Add('SPACE(');
  FFunctions.Add('SUBSTRING(');
  FFunctions.Add('UCASE(');
  FFunctions.Add('UPPER(');

  {date/time functions}
  FFunctions.Add('CURDATE()');
  FFunctions.Add('CURRENT_DATE(');
  FFunctions.Add('CURRENT_TIME(');
  FFunctions.Add('CURRENT_TIMESTAMP(');
  FFunctions.Add('CURTIME(');
  FFunctions.Add('DAYNAME(');
  FFunctions.Add('DAYOFMONTH(');
  FFunctions.Add('DAYOFWEEK(');
  FFunctions.Add('DAYOFYEAR(');
  FFunctions.Add('EXTRACT(');
  FFunctions.Add('HOUR(');
  FFunctions.Add('MINUTE(');
  FFunctions.Add('MONTH(');
  FFunctions.Add('MONTHNAME(');
  FFunctions.Add('NOW()');
  FFunctions.Add('QUARTER(');
  FFunctions.Add('SECOND(');
  FFunctions.Add('TIMESTAMPADD(');
  FFunctions.Add('TIMESTAMPDIFF(');
  FFunctions.Add('WEEK(');
  FFunctions.Add('YEAR(');

  {miscellaneous functions}
  FFunctions.Add('CONVERT(');
  FFunctions.Add('DATABASE(');
  FFunctions.Add('DIFFERENCE(');
  FFunctions.Add('SOUNDEX(');
  FFunctions.Add('IFNULL(');
  FFunctions.Add('USER(');

end; {procedure, BuildFunctionList}

{******************************************************************************
 *
 ** A D S   D A T A S E T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaADSDataSet.Create }

constructor TdaADSDataSet.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FTable := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaADSDataSet.Destroy }

destructor TdaADSDataSet.Destroy;
begin

  FTable.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaADSDataSet.ClassDescription }

class function TdaADSDataSet.ClassDescription: String;
begin
  Result := 'ADSDataSet';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaADSDataSet.GetActive }

function TdaADSDataSet.GetActive: Boolean;
begin
  Result := Table.Active
end; {function, GetActive}

{------------------------------------------------------------------------------}
{ TdaADSDataSet.SetActive }

procedure TdaADSDataSet.SetActive(Value: Boolean);
begin
  Table.Active := Value;
end; {procedure, SetActive}

{------------------------------------------------------------------------------}
{ TdaADSDataSet.GetTable }

function TdaADSDataSet.GetTable: TADSTable;
begin

  {create ADS table, if needed}
  if (FTable = nil) then
    FTable:= TADSTable.Create(Self);

  Result := FTable;

end; {procedure, GetTable}

{------------------------------------------------------------------------------}
{ TdaADSDataSet.SetDatabase }

procedure TdaADSDataSet.SetDatabase(aDatabase: TComponent);
begin

  inherited SetDatabase(aDatabase);

  {table cannot be active to set database property}
  if Table.Active then
    Table.Active:= False;

  {get ADS database for name}
  Table.AdsConnection := TAdsConnection(aDatabase);

end; {procedure, SetDatabase}


{------------------------------------------------------------------------------}
{ TdaADSDataSet.SetDataName }

procedure TdaADSDataSet.SetDataName(const aDataName: String);
const
  lcDoubleQuote = #34;
var
  lsTableName: String;
begin

  inherited SetDataName(aDataName);

  {table cannot be active to set table name property}
  if Table.Active then
    Table.Active := False;

  {strip off any double quotes which may be added by the DataDictionary Builder}
  lsTableName := StringReplace(aDataName, lcDoubleQuote, '', [rfReplaceAll]);

  Table.TableName := lsTableName;

end; {procedure, SetDataName}

{------------------------------------------------------------------------------}
{ TdaADSDataSet.BuildFieldList }

procedure TdaADSDataSet.BuildFieldList;
var
  liIndex: Integer;
  lADSField: TField;
  lField: TppField;
begin

  inherited BuildFieldList;

  {set table to active}
  Table.Active:= True;

  {create TppField objects for each field in the table}
  for liIndex := 0 to Table.FieldCount - 1 do
    begin
      lADSField := Table.Fields[liIndex];
      lField := TppField.Create(nil);

      lField.TableName := Table.TableName;
      lField.FieldName := lADSField.FieldName;
      lField.FieldAlias := lADSField.DisplayLabel;
      lField.FieldLength := lADSField.Size;
      lField.DataType := ppConvertFieldType(lADSField.DataType);
      lField.DisplayWidth := lADSField.DisplayWidth;

      AddField(lField);
    end;
end; {function, BuildFieldList}

{------------------------------------------------------------------------------}
{ TdaADSDataSet.GetFieldNamesForSQL }

procedure TdaADSDataSet.GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings);
var
  lQuery: TADSQuery;
begin

  aList.Clear;

  {create a temporary ADS query}
  lQuery := TADSQuery.Create(Self);

  try
    {set the database and SQL properties}
    lQuery.DatabaseName := TADSConnection(Database).Name;
    lQuery.SQL:= aSQL;
    {get the field names}
    lQuery.GetFieldNames(aList);
    
  finally
    lQuery.Free;
  end;

end; {procedure, GetFieldNamesForSQL}

{------------------------------------------------------------------------------}
{ TdaADSDataSet.GetFieldsForSQL }

procedure TdaADSDataSet.GetFieldsForSQL(aList: TList; aSQL: TStrings);
var
  lQuery: TADSQuery;
  lADSField: TField;
  lField: TppField;
  liIndex: Integer;
begin
  aList.Clear;

  {create a temporary ADS query}
  lQuery := TADSQuery.Create(Self);

  try
    {assign database and SQL properties}
    lQuery.DatabaseName:= TAdsConnection(Database).Name;
    lQuery.SQL:= aSQL;

    {set query to active}
    lQuery.Active := True;

    {create a TppField object for each field in the query}
    for liIndex := 0 to lQuery.FieldCount - 1 do
      begin

        lADSField := lQuery.Fields[liIndex];

        lField := TppField.Create(nil);

        lField.FieldName := lADSField.FieldName;
        lField.FieldAlias := lADSField.DisplayLabel;
        lField.FieldLength := lADSField.Size;
        lField.DataType := ppConvertFieldType(lADSField.DataType);
        lField.DisplayWidth := lADSField.DisplayWidth;

        aList.Add(lField);
      end;
  finally
    lQuery.Free;
  end;

end; {procedure, GetFieldsForSQL}

{******************************************************************************
 *
 ** A D S   Q U E R Y   D A T A V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaADSQueryDataView.Create }

constructor TdaADSQueryDataView.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  {notes: 1. must use ChildQuery, ChildDataSource, ChildPipeline etc.
          2. use Self as owner for Query, DataSource etc.
          3. do NOT assign a Name }
  FQuery := TdaChildADSQuery.Create(Self);
  FDataSource := TppChildDataSource.Create(Self);
  FDataSource.DataSet := FQuery;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaADSQueryDataView.Destroy }

destructor TdaADSQueryDataView.Destroy;
begin
  FDataSource.Free;
  FQuery.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaADSQueryDataView.SessionClass }

class function TdaADSQueryDataView.SessionClass: TClass;
begin
  Result := TdaADSSession;

end; {class function, SessionClass}

{------------------------------------------------------------------------------}
{ TdaADSQueryDataView.PreviewFormClass }

class function TdaADSQueryDataView.PreviewFormClass: TFormClass;
begin
  Result := TFormClass(GetClass('TdaPreviewDataDialog'));

end; {class function, PreviewFormClass}


{------------------------------------------------------------------------------}
{ TdaADSQueryDataView.ConnectPipelinesToData }

procedure TdaADSQueryDataView.ConnectPipelinesToData;
begin

  if DataPipelineCount = 0 then Exit;

  {need to reconnect here}
  TppDBPipeline(DataPipelines[0]).DataSource := FDataSource;

end; {procedure, ConnectPipelinesToData}

{------------------------------------------------------------------------------}
{ TdaADSQueryDataView.Init }

procedure TdaADSQueryDataView.Init;
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
{ TdaADSQueryDataView.SQLChanged }

procedure TdaADSQueryDataView.SQLChanged;
begin

  if FQuery.Active then
    FQuery.Close;

  FQuery.DatabaseName:= SQL.DatabaseName;
  FQuery.SQL:= SQL.MagicSQLText;

end; {procedure, SQLChanged}


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  {register the ADS descendant classes}
  RegisterClasses([TdaChildADSQuery,TdaChildADSTable]);
  
  {register DADE descendant session, dataset, dataview}
  daRegisterSession(TdaADSSession);
  daRegisterDataSet(TdaADSDataSet);
  daRegisterDataView(TdaADSQueryDataView);

  {initialize internal reference variables}
  FADSConnection := nil;


finalization

  {free the default connection object}
  FADSConnection.Free;
  FADSConnection := nil;

  {unregister the ADS descendant classes}
  UnRegisterClasses([TdaChildADSQuery,TdaChildADSTable]);
  
  {unregister DADE descendant the session, dataset, dataview}
  daUnRegisterSession(TdaADSSession);
  daUnRegisterDataSet(TdaADSDataSet);
  daUnRegisterDataView(TdaADSQueryDataView);

end.

