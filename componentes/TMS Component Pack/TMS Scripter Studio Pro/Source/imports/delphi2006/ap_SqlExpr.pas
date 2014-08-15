{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_SqlExpr;

interface

uses
  Windows,
  SysUtils,
  Variants,
  Classes,
  DB,
  DBCommon,
  DBCommonTypes,
  DBXpress,
  SqlTimSt,
  WideStrings,
  SqlExpr,
  ap_DBXpress,
  atScript;

{$WARNINGS OFF}

type
  TatSqlExprLibrary = class(TatScripterLibrary)
    procedure __TSQLBlobStreamCreate(AMachine: TatVirtualMachine);
    procedure __TSQLBlobStreamDestroy(AMachine: TatVirtualMachine);
    procedure __TSQLBlobStreamReadBlobData(AMachine: TatVirtualMachine);
    procedure __TISQLConnectionconnect(AMachine: TatVirtualMachine);
    procedure __TISQLConnectiondisconnect(AMachine: TatVirtualMachine);
    procedure __TISQLConnectiongetSQLCommand(AMachine: TatVirtualMachine);
    procedure __TISQLConnectiongetSQLMetaData(AMachine: TatVirtualMachine);
    procedure __TISQLConnectionSetOption(AMachine: TatVirtualMachine);
    procedure __TISQLConnectionSetStringOption(AMachine: TatVirtualMachine);
    procedure __TISQLConnectionGetStringOption(AMachine: TatVirtualMachine);
    procedure __TISQLConnectionbeginTransaction(AMachine: TatVirtualMachine);
    procedure __TISQLConnectioncommit(AMachine: TatVirtualMachine);
    procedure __TISQLConnectionrollback(AMachine: TatVirtualMachine);
    procedure __TISQLConnectiongetErrorMessage(AMachine: TatVirtualMachine);
    procedure __TISQLConnectiongetErrorMessageLen(AMachine: TatVirtualMachine);
    procedure __TISQLCommandDestroy(AMachine: TatVirtualMachine);
    procedure __TISQLCommandSetOption(AMachine: TatVirtualMachine);
    procedure __TISQLCommandSetStringOption(AMachine: TatVirtualMachine);
    procedure __TISQLCommandGetStringOption(AMachine: TatVirtualMachine);
    procedure __TISQLCommandprepare(AMachine: TatVirtualMachine);
    procedure __TISQLCommandexecute(AMachine: TatVirtualMachine);
    procedure __TISQLCommandexecuteImmediate(AMachine: TatVirtualMachine);
    procedure __TISQLCommandgetNextCursor(AMachine: TatVirtualMachine);
    procedure __TISQLCommandgetRowsAffected(AMachine: TatVirtualMachine);
    procedure __TISQLCommandclose(AMachine: TatVirtualMachine);
    procedure __TISQLCommandgetErrorMessage(AMachine: TatVirtualMachine);
    procedure __TISQLCommandgetErrorMessageLen(AMachine: TatVirtualMachine);
    procedure __TISQLCursorSetOption(AMachine: TatVirtualMachine);
    procedure __TISQLCursorSetStringOption(AMachine: TatVirtualMachine);
    procedure __TISQLCursorGetStringOption(AMachine: TatVirtualMachine);
    procedure __TISQLCursorgetCurObjectTypeName(AMachine: TatVirtualMachine);
    procedure __TISQLCursorgetErrorMessage(AMachine: TatVirtualMachine);
    procedure __TISQLCursorgetErrorMessageLen(AMachine: TatVirtualMachine);
    procedure __TISQLCursorgetColumnCount(AMachine: TatVirtualMachine);
    procedure __TISQLCursorgetColumnNameLength(AMachine: TatVirtualMachine);
    procedure __TISQLCursorgetColumnName(AMachine: TatVirtualMachine);
    procedure __TISQLCursorgetColumnType(AMachine: TatVirtualMachine);
    procedure __TISQLCursorgetColumnLength(AMachine: TatVirtualMachine);
    procedure __TISQLCursorgetColumnPrecision(AMachine: TatVirtualMachine);
    procedure __TISQLCursorgetColumnScale(AMachine: TatVirtualMachine);
    procedure __TISQLCursorisNullable(AMachine: TatVirtualMachine);
    procedure __TISQLCursorisAutoIncrement(AMachine: TatVirtualMachine);
    procedure __TISQLCursorisReadOnly(AMachine: TatVirtualMachine);
    procedure __TISQLCursorisSearchable(AMachine: TatVirtualMachine);
    procedure __TISQLCursorisBlobSizeExact(AMachine: TatVirtualMachine);
    procedure __TISQLCursornext(AMachine: TatVirtualMachine);
    procedure __TISQLCursorgetString(AMachine: TatVirtualMachine);
    procedure __TISQLCursorgetWideString(AMachine: TatVirtualMachine);
    procedure __TISQLCursorgetBlobSize(AMachine: TatVirtualMachine);
    procedure __TISQLMetaDataSetOption(AMachine: TatVirtualMachine);
    procedure __TISQLMetaDataSetStringOption(AMachine: TatVirtualMachine);
    procedure __TISQLMetaDataGetStringOption(AMachine: TatVirtualMachine);
    procedure __TISQLMetaDatagetObjectList(AMachine: TatVirtualMachine);
    procedure __TISQLMetaDatagetTables(AMachine: TatVirtualMachine);
    procedure __TISQLMetaDatagetProcedures(AMachine: TatVirtualMachine);
    procedure __TISQLMetaDatagetColumns(AMachine: TatVirtualMachine);
    procedure __TISQLMetaDatagetProcedureParams(AMachine: TatVirtualMachine);
    procedure __TISQLMetaDatagetIndices(AMachine: TatVirtualMachine);
    procedure __TISQLMetaDatagetErrorMessage(AMachine: TatVirtualMachine);
    procedure __TISQLMetaDatagetErrorMessageLen(AMachine: TatVirtualMachine);
    procedure __TSQLMonitorCreate(AMachine: TatVirtualMachine);
    procedure __TSQLMonitorDestroy(AMachine: TatVirtualMachine);
    procedure __TSQLMonitorLoadFromFile(AMachine: TatVirtualMachine);
    procedure __TSQLMonitorSaveToFile(AMachine: TatVirtualMachine);
    procedure __GetTSQLMonitorMaxTraceCount(AMachine: TatVirtualMachine);
    procedure __SetTSQLMonitorMaxTraceCount(AMachine: TatVirtualMachine);
    procedure __GetTSQLMonitorTraceCount(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionCreate(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionDestroy(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionCloneConnection(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionCloseDataSets(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionCommit(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionExecuteDirect(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionGetFieldNames(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionGetIndexNames(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionGetProcedureNames(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionGetPackageNames(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionGetSchemaNames(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionGetDefaultSchemaName(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionGetProcedureParams(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionGetTableNames(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionLoadParamsFromIniFile(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionRollback(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionStartTransaction(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionGetLoginUsername(AMachine: TatVirtualMachine);
    procedure __GetTSQLConnectionActiveStatements(AMachine: TatVirtualMachine);
    procedure __GetTSQLConnectionAutoClone(AMachine: TatVirtualMachine);
    procedure __SetTSQLConnectionAutoClone(AMachine: TatVirtualMachine);
    procedure __GetTSQLConnectionConnectionState(AMachine: TatVirtualMachine);
    procedure __SetTSQLConnectionConnectionState(AMachine: TatVirtualMachine);
    procedure __GetTSQLConnectionDataSets(AMachine: TatVirtualMachine);
    procedure __GetTSQLConnectionInTransaction(AMachine: TatVirtualMachine);
    procedure __GetTSQLConnectionLocaleCode(AMachine: TatVirtualMachine);
    procedure __SetTSQLConnectionLocaleCode(AMachine: TatVirtualMachine);
    procedure __GetTSQLConnectionMaxStmtsPerConn(AMachine: TatVirtualMachine);
    procedure __GetTSQLConnectionMetaData(AMachine: TatVirtualMachine);
    procedure __GetTSQLConnectionMultipleTransactionsSupported(AMachine: TatVirtualMachine);
    procedure __GetTSQLConnectionParamsLoaded(AMachine: TatVirtualMachine);
    procedure __SetTSQLConnectionParamsLoaded(AMachine: TatVirtualMachine);
    procedure __GetTSQLConnectionSQLConnection(AMachine: TatVirtualMachine);
    procedure __SetTSQLConnectionSQLConnection(AMachine: TatVirtualMachine);
    procedure __GetTSQLConnectionSQLHourGlass(AMachine: TatVirtualMachine);
    procedure __SetTSQLConnectionSQLHourGlass(AMachine: TatVirtualMachine);
    procedure __GetTSQLConnectionTransactionsSupported(AMachine: TatVirtualMachine);
    procedure __TSQLDataLinkCreate(AMachine: TatVirtualMachine);
    procedure __GetTFLDDesciFldNum(AMachine: TatVirtualMachine);
    procedure __SetTFLDDesciFldNum(AMachine: TatVirtualMachine);
    procedure __GetTFLDDescszName(AMachine: TatVirtualMachine);
    procedure __SetTFLDDescszName(AMachine: TatVirtualMachine);
    procedure __GetTFLDDesciFldType(AMachine: TatVirtualMachine);
    procedure __SetTFLDDesciFldType(AMachine: TatVirtualMachine);
    procedure __GetTFLDDesciSubType(AMachine: TatVirtualMachine);
    procedure __SetTFLDDesciSubType(AMachine: TatVirtualMachine);
    procedure __GetTFLDDesciUnits1(AMachine: TatVirtualMachine);
    procedure __SetTFLDDesciUnits1(AMachine: TatVirtualMachine);
    procedure __GetTFLDDesciUnits2(AMachine: TatVirtualMachine);
    procedure __SetTFLDDesciUnits2(AMachine: TatVirtualMachine);
    procedure __GetTFLDDesciOffset(AMachine: TatVirtualMachine);
    procedure __SetTFLDDesciOffset(AMachine: TatVirtualMachine);
    procedure __GetTFLDDesciLen(AMachine: TatVirtualMachine);
    procedure __SetTFLDDesciLen(AMachine: TatVirtualMachine);
    procedure __GetTFLDDesciNullOffset(AMachine: TatVirtualMachine);
    procedure __SetTFLDDesciNullOffset(AMachine: TatVirtualMachine);
    procedure __GetTFLDDescefldvVchk(AMachine: TatVirtualMachine);
    procedure __SetTFLDDescefldvVchk(AMachine: TatVirtualMachine);
    procedure __GetTFLDDescefldrRights(AMachine: TatVirtualMachine);
    procedure __SetTFLDDescefldrRights(AMachine: TatVirtualMachine);
    procedure __GetTFLDDescbCalcField(AMachine: TatVirtualMachine);
    procedure __SetTFLDDescbCalcField(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetCreate(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetCreateBlobStream(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetGetDetailLinkFields(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetGetKeyFieldNames(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetGetQuoteChar(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetParamByName(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetPrepareStatement(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetIsSequenced(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetLocate(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetLookup(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetSetSchemaInfo(AMachine: TatVirtualMachine);
    procedure __GetTCustomSQLDataSetCommandText(AMachine: TatVirtualMachine);
    procedure __SetTCustomSQLDataSetCommandText(AMachine: TatVirtualMachine);
    procedure __GetTCustomSQLDataSetIndexDefs(AMachine: TatVirtualMachine);
    procedure __SetTCustomSQLDataSetIndexDefs(AMachine: TatVirtualMachine);
    procedure __GetTCustomSQLDataSetPrepared(AMachine: TatVirtualMachine);
    procedure __SetTCustomSQLDataSetPrepared(AMachine: TatVirtualMachine);
    procedure __GetTCustomSQLDataSetDesignerData(AMachine: TatVirtualMachine);
    procedure __SetTCustomSQLDataSetDesignerData(AMachine: TatVirtualMachine);
    procedure __GetTCustomSQLDataSetRecordCount(AMachine: TatVirtualMachine);
    procedure __GetTCustomSQLDataSetSQLConnection(AMachine: TatVirtualMachine);
    procedure __SetTCustomSQLDataSetSQLConnection(AMachine: TatVirtualMachine);
    procedure __GetTCustomSQLDataSetTransactionLevel(AMachine: TatVirtualMachine);
    procedure __SetTCustomSQLDataSetTransactionLevel(AMachine: TatVirtualMachine);
    procedure __TSQLDataSetCreate(AMachine: TatVirtualMachine);
    procedure __TSQLDataSetExecSQL(AMachine: TatVirtualMachine);
    procedure __TSQLQueryCreate(AMachine: TatVirtualMachine);
    procedure __TSQLQueryDestroy(AMachine: TatVirtualMachine);
    procedure __TSQLQueryExecSQL(AMachine: TatVirtualMachine);
    procedure __TSQLQueryPrepareStatement(AMachine: TatVirtualMachine);
    procedure __GetTSQLQueryText(AMachine: TatVirtualMachine);
    procedure __TSQLStoredProcCreate(AMachine: TatVirtualMachine);
    procedure __TSQLStoredProcExecProc(AMachine: TatVirtualMachine);
    procedure __TSQLStoredProcNextRecordSet(AMachine: TatVirtualMachine);
    procedure __TSQLStoredProcPrepareStatement(AMachine: TatVirtualMachine);
    procedure __TSQLTableCreate(AMachine: TatVirtualMachine);
    procedure __TSQLTableDestroy(AMachine: TatVirtualMachine);
    procedure __TSQLTableDeleteRecords(AMachine: TatVirtualMachine);
    procedure __TSQLTableGetIndexNames(AMachine: TatVirtualMachine);
    procedure __TSQLTablePrepareStatement(AMachine: TatVirtualMachine);
    procedure __GetTSQLTableIndexFields(AMachine: TatVirtualMachine);
    procedure __SetTSQLTableIndexFields(AMachine: TatVirtualMachine);
    procedure __GetTSQLTableIndexFieldCount(AMachine: TatVirtualMachine);
    procedure __LoadParamListItems(AMachine: TatVirtualMachine);
    procedure __FreeProcParams(AMachine: TatVirtualMachine);
    procedure __GetConnectionNames(AMachine: TatVirtualMachine);
    procedure __GetDriverNames(AMachine: TatVirtualMachine);
    procedure __GetDriverRegistryFile(AMachine: TatVirtualMachine);
    procedure __GetConnectionRegistryFile(AMachine: TatVirtualMachine);
    procedure __GetDllHandle(AMachine: TatVirtualMachine);
    procedure __SetDllHandle(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TSQLBlobStreamClass = class of TSQLBlobStream;
  TISQLConnectionClass = class of TISQLConnection;
  TISQLCommandClass = class of TISQLCommand;
  TISQLCursorClass = class of TISQLCursor;
  TISQLMetaDataClass = class of TISQLMetaData;
  TSQLMonitorClass = class of TSQLMonitor;
  TSQLConnectionClass = class of TSQLConnection;
  TSQLDataLinkClass = class of TSQLDataLink;
  TFLDDescClass = class of TFLDDesc;
  TCustomSQLDataSetClass = class of TCustomSQLDataSet;
  TSQLDataSetClass = class of TSQLDataSet;
  TSQLQueryClass = class of TSQLQuery;
  TSQLStoredProcClass = class of TSQLStoredProc;
  TSQLTableClass = class of TSQLTable;

  TatSqlExprDispatcher = class(TatEventDispatcher)
  private
    procedure __TConnectChangeEvent( Sender: TObject;  Connecting: Boolean);
    procedure __TSQLConnectionLoginEvent( Database: TSQLConnection;  LoginParams: TWideStrings);
    procedure __TParseSqlEvent(var FieldNames: TWideStrings;  SQL: WideString; var TableName: WideString);
    procedure __TParseInsertSqlEvent(var FieldNames: TWideStrings;  SQL: WideString; var BindAllFields: Boolean; var TableName: WideString);
  end;

  SPParamDescWrapper = class(TatRecordWrapper)
  private
    FiParamNum: Word;
    FszName: WideString;
    FiArgType: TParamType;
    FiDataType: TFieldType;
    FiUnits1: SmallInt;
    FiUnits2: SmallInt;
    FiLen: LongWord;
  public
    constructor Create(ARecord: SPParamDesc);
    function ObjToRec: SPParamDesc;
  published
    property iParamNum: Word read FiParamNum write FiParamNum;
    property szName: WideString read FszName write FszName;
    property iArgType: TParamType read FiArgType write FiArgType;
    property iDataType: TFieldType read FiDataType write FiDataType;
    property iUnits1: SmallInt read FiUnits1 write FiUnits1;
    property iUnits2: SmallInt read FiUnits2 write FiUnits2;
    property iLen: LongWord read FiLen write FiLen;
  end;
  
  SQLTRACEDesc30Wrapper = class(TatRecordWrapper)
  private
    FeTraceCat: TRACECat;
    FClientData: Integer;
    FuTotalMsgLen: Word;
  public
    constructor Create(ARecord: SQLTRACEDesc30);
    function ObjToRec: SQLTRACEDesc30;
  published
    property eTraceCat: TRACECat read FeTraceCat write FeTraceCat;
    property ClientData: Integer read FClientData write FClientData;
    property uTotalMsgLen: Word read FuTotalMsgLen write FuTotalMsgLen;
  end;
  
  SQLTRACEDesc25Wrapper = class(TatRecordWrapper)
  private
    FeTraceCat: TRACECat;
    FClientData: Integer;
    FuTotalMsgLen: Word;
  public
    constructor Create(ARecord: SQLTRACEDesc25);
    function ObjToRec: SQLTRACEDesc25;
  published
    property eTraceCat: TRACECat read FeTraceCat write FeTraceCat;
    property ClientData: Integer read FClientData write FClientData;
    property uTotalMsgLen: Word read FuTotalMsgLen write FuTotalMsgLen;
  end;
  
  TSQLSchemaInfoWrapper = class(TatRecordWrapper)
  private
    FFType: TSchemaType;
    FObjectName: WideString;
    FPattern: WideString;
    FPackageName: WideString;
  public
    constructor Create(ARecord: TSQLSchemaInfo);
    function ObjToRec: TSQLSchemaInfo;
  published
    property FType: TSchemaType read FFType write FFType;
    property ObjectName: WideString read FObjectName write FObjectName;
    property Pattern: WideString read FPattern write FPattern;
    property PackageName: WideString read FPackageName write FPackageName;
  end;
  

implementation

constructor SPParamDescWrapper.Create(ARecord: SPParamDesc);
begin
  inherited Create;
  FiParamNum := ARecord.iParamNum;
  FszName := ARecord.szName;
  FiArgType := ARecord.iArgType;
  FiDataType := ARecord.iDataType;
  FiUnits1 := ARecord.iUnits1;
  FiUnits2 := ARecord.iUnits2;
  FiLen := ARecord.iLen;
end;

function SPParamDescWrapper.ObjToRec: SPParamDesc;
begin
  result.iParamNum := FiParamNum;
  result.szName := FszName;
  result.iArgType := FiArgType;
  result.iDataType := FiDataType;
  result.iUnits1 := FiUnits1;
  result.iUnits2 := FiUnits2;
  result.iLen := FiLen;
end;

constructor SQLTRACEDesc30Wrapper.Create(ARecord: SQLTRACEDesc30);
begin
  inherited Create;
  FeTraceCat := ARecord.eTraceCat;
  FClientData := ARecord.ClientData;
  FuTotalMsgLen := ARecord.uTotalMsgLen;
end;

function SQLTRACEDesc30Wrapper.ObjToRec: SQLTRACEDesc30;
begin
  result.eTraceCat := FeTraceCat;
  result.ClientData := FClientData;
  result.uTotalMsgLen := FuTotalMsgLen;
end;

constructor SQLTRACEDesc25Wrapper.Create(ARecord: SQLTRACEDesc25);
begin
  inherited Create;
  FeTraceCat := ARecord.eTraceCat;
  FClientData := ARecord.ClientData;
  FuTotalMsgLen := ARecord.uTotalMsgLen;
end;

function SQLTRACEDesc25Wrapper.ObjToRec: SQLTRACEDesc25;
begin
  result.eTraceCat := FeTraceCat;
  result.ClientData := FClientData;
  result.uTotalMsgLen := FuTotalMsgLen;
end;

constructor TSQLSchemaInfoWrapper.Create(ARecord: TSQLSchemaInfo);
begin
  inherited Create;
  FFType := ARecord.FType;
  FObjectName := ARecord.ObjectName;
  FPattern := ARecord.Pattern;
  FPackageName := ARecord.PackageName;
end;

function TSQLSchemaInfoWrapper.ObjToRec: TSQLSchemaInfo;
begin
  result.FType := FFType;
  result.ObjectName := FObjectName;
  result.Pattern := FPattern;
  result.PackageName := FPackageName;
end;



procedure TatSqlExprLibrary.__TSQLBlobStreamCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(TSQLBlobStreamClass(CurrentClass.ClassRef).Create(TBlobField(Integer(GetInputArg(0)))));
2: AResult := Integer(TSQLBlobStreamClass(CurrentClass.ClassRef).Create(TBlobField(Integer(GetInputArg(0))),GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TSQLBlobStreamDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLBlobStream(CurrentObject).Destroy;
  end;
end;

procedure TatSqlExprLibrary.__TSQLBlobStreamReadBlobData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLBlobStream(CurrentObject).ReadBlobData;
  end;
end;

procedure TatSqlExprLibrary.__TISQLConnectionconnect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLConnection(CurrentObject).connect);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLConnectiondisconnect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLConnection(CurrentObject).disconnect);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLConnectiongetSQLCommand(AMachine: TatVirtualMachine);
  var
  Param0: TISQLCommand;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := TISQLCommand(Integer(GetInputArg(0)));
AResult := Integer(TISQLConnection(CurrentObject).getSQLCommand(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatSqlExprLibrary.__TISQLConnectiongetSQLMetaData(AMachine: TatVirtualMachine);
  var
  Param0: TISQLMetaData;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := TISQLMetaData(Integer(GetInputArg(0)));
AResult := Integer(TISQLConnection(CurrentObject).getSQLMetaData(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatSqlExprLibrary.__TISQLConnectionSetOption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLConnection(CurrentObject).SetOption(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLConnectionSetStringOption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLConnection(CurrentObject).SetStringOption(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLConnectionGetStringOption(AMachine: TatVirtualMachine);
  var
  Param1: WideString;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(TISQLConnection(CurrentObject).GetStringOption(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSqlExprLibrary.__TISQLConnectionbeginTransaction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLConnection(CurrentObject).beginTransaction(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLConnectioncommit(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLConnection(CurrentObject).commit(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLConnectionrollback(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLConnection(CurrentObject).rollback(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLConnectiongetErrorMessage(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLConnection(CurrentObject).getErrorMessage(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLConnectiongetErrorMessageLen(AMachine: TatVirtualMachine);
  var
  Param0: SmallInt;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(TISQLConnection(CurrentObject).getErrorMessageLen(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatSqlExprLibrary.__TISQLCommandDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TISQLCommand(CurrentObject).Destroy;
  end;
end;

procedure TatSqlExprLibrary.__TISQLCommandSetOption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLCommand(CurrentObject).SetOption(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCommandSetStringOption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLCommand(CurrentObject).SetStringOption(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCommandGetStringOption(AMachine: TatVirtualMachine);
  var
  Param1: WideString;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(TISQLCommand(CurrentObject).GetStringOption(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCommandprepare(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLCommand(CurrentObject).prepare(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCommandexecute(AMachine: TatVirtualMachine);
  var
  Param0: TISQLCursor;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := TISQLCursor(Integer(GetInputArg(0)));
AResult := Integer(TISQLCommand(CurrentObject).execute(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatSqlExprLibrary.__TISQLCommandexecuteImmediate(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1: TISQLCursor;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := TISQLCursor(Integer(GetInputArg(1)));
AResult := Integer(TISQLCommand(CurrentObject).executeImmediate(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatSqlExprLibrary.__TISQLCommandgetNextCursor(AMachine: TatVirtualMachine);
  var
  Param0: TISQLCursor;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := TISQLCursor(Integer(GetInputArg(0)));
AResult := Integer(TISQLCommand(CurrentObject).getNextCursor(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatSqlExprLibrary.__TISQLCommandgetRowsAffected(AMachine: TatVirtualMachine);
  var
  Param0: LongWord;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(TISQLCommand(CurrentObject).getRowsAffected(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatSqlExprLibrary.__TISQLCommandclose(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLCommand(CurrentObject).close);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCommandgetErrorMessage(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLCommand(CurrentObject).getErrorMessage(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCommandgetErrorMessageLen(AMachine: TatVirtualMachine);
  var
  Param0: SmallInt;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(TISQLCommand(CurrentObject).getErrorMessageLen(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorSetOption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLCursor(CurrentObject).SetOption(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorSetStringOption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLCursor(CurrentObject).SetStringOption(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorGetStringOption(AMachine: TatVirtualMachine);
  var
  Param1: WideString;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(TISQLCursor(CurrentObject).GetStringOption(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorgetCurObjectTypeName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TISQLCursor(CurrentObject).getCurObjectTypeName(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorgetErrorMessage(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLCursor(CurrentObject).getErrorMessage(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorgetErrorMessageLen(AMachine: TatVirtualMachine);
  var
  Param0: SmallInt;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(TISQLCursor(CurrentObject).getErrorMessageLen(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorgetColumnCount(AMachine: TatVirtualMachine);
  var
  Param0: Word;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(TISQLCursor(CurrentObject).getColumnCount(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorgetColumnNameLength(AMachine: TatVirtualMachine);
  var
  Param1: Word;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(TISQLCursor(CurrentObject).getColumnNameLength(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorgetColumnName(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLCursor(CurrentObject).getColumnName(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorgetColumnType(AMachine: TatVirtualMachine);
  var
  Param1: Word;
  Param2: Word;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(TISQLCursor(CurrentObject).getColumnType(VarToInteger(GetInputArg(0)),Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorgetColumnLength(AMachine: TatVirtualMachine);
  var
  Param1: LongWord;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(TISQLCursor(CurrentObject).getColumnLength(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorgetColumnPrecision(AMachine: TatVirtualMachine);
  var
  Param1: SmallInt;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(TISQLCursor(CurrentObject).getColumnPrecision(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorgetColumnScale(AMachine: TatVirtualMachine);
  var
  Param1: SmallInt;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(TISQLCursor(CurrentObject).getColumnScale(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorisNullable(AMachine: TatVirtualMachine);
  var
  Param1: LongBool;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(TISQLCursor(CurrentObject).isNullable(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorisAutoIncrement(AMachine: TatVirtualMachine);
  var
  Param1: LongBool;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(TISQLCursor(CurrentObject).isAutoIncrement(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorisReadOnly(AMachine: TatVirtualMachine);
  var
  Param1: LongBool;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(TISQLCursor(CurrentObject).isReadOnly(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorisSearchable(AMachine: TatVirtualMachine);
  var
  Param1: LongBool;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(TISQLCursor(CurrentObject).isSearchable(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorisBlobSizeExact(AMachine: TatVirtualMachine);
  var
  Param1: LongBool;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(TISQLCursor(CurrentObject).isBlobSizeExact(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursornext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLCursor(CurrentObject).next);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorgetString(AMachine: TatVirtualMachine);
  var
  Param2: LongBool;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(TISQLCursor(CurrentObject).getString(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorgetWideString(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2: LongBool;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(TISQLCursor(CurrentObject).getWideString(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatSqlExprLibrary.__TISQLCursorgetBlobSize(AMachine: TatVirtualMachine);
  var
  Param1: LongWord;
  Param2: LongBool;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := GetInputArg(2);
AResult := Integer(TISQLCursor(CurrentObject).getBlobSize(VarToInteger(GetInputArg(0)),Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Param2);
  end;
end;

procedure TatSqlExprLibrary.__TISQLMetaDataSetOption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLMetaData(CurrentObject).SetOption(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLMetaDataSetStringOption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLMetaData(CurrentObject).SetStringOption(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLMetaDataGetStringOption(AMachine: TatVirtualMachine);
  var
  Param1: WideString;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(TISQLMetaData(CurrentObject).GetStringOption(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSqlExprLibrary.__TISQLMetaDatagetObjectList(AMachine: TatVirtualMachine);
  var
  Param1: TISQLCursor;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := TISQLCursor(Integer(GetInputArg(1)));
AResult := Integer(TISQLMetaData(CurrentObject).getObjectList(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatSqlExprLibrary.__TISQLMetaDatagetTables(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2: TISQLCursor;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := TISQLCursor(Integer(GetInputArg(2)));
AResult := Integer(TISQLMetaData(CurrentObject).getTables(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatSqlExprLibrary.__TISQLMetaDatagetProcedures(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2: TISQLCursor;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := TISQLCursor(Integer(GetInputArg(2)));
AResult := Integer(TISQLMetaData(CurrentObject).getProcedures(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatSqlExprLibrary.__TISQLMetaDatagetColumns(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param3: TISQLCursor;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := TISQLCursor(Integer(GetInputArg(3)));
AResult := Integer(TISQLMetaData(CurrentObject).getColumns(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatSqlExprLibrary.__TISQLMetaDatagetProcedureParams(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2: TISQLCursor;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := TISQLCursor(Integer(GetInputArg(2)));
AResult := Integer(TISQLMetaData(CurrentObject).getProcedureParams(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatSqlExprLibrary.__TISQLMetaDatagetIndices(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2: TISQLCursor;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := TISQLCursor(Integer(GetInputArg(2)));
AResult := Integer(TISQLMetaData(CurrentObject).getIndices(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatSqlExprLibrary.__TISQLMetaDatagetErrorMessage(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TISQLMetaData(CurrentObject).getErrorMessage(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TISQLMetaDatagetErrorMessageLen(AMachine: TatVirtualMachine);
  var
  Param0: SmallInt;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(TISQLMetaData(CurrentObject).getErrorMessageLen(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatSqlExprLibrary.__TSQLMonitorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSQLMonitorClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TSQLMonitorDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLMonitor(CurrentObject).Destroy;
  end;
end;

procedure TatSqlExprLibrary.__TSQLMonitorLoadFromFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLMonitor(CurrentObject).LoadFromFile(GetInputArg(0));
  end;
end;

procedure TatSqlExprLibrary.__TSQLMonitorSaveToFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLMonitor(CurrentObject).SaveToFile(GetInputArg(0));
  end;
end;

procedure TatSqlExprLibrary.__GetTSQLMonitorMaxTraceCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSQLMonitor(CurrentObject).MaxTraceCount));
  end;
end;

procedure TatSqlExprLibrary.__SetTSQLMonitorMaxTraceCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLMonitor(CurrentObject).MaxTraceCount:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSqlExprLibrary.__GetTSQLMonitorTraceCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSQLMonitor(CurrentObject).TraceCount));
  end;
end;

procedure TatSqlExprLibrary.__TSQLConnectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSQLConnectionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TSQLConnectionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLConnection(CurrentObject).Destroy;
  end;
end;

procedure TatSqlExprLibrary.__TSQLConnectionCloneConnection(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSQLConnection(CurrentObject).CloneConnection);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TSQLConnectionCloseDataSets(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLConnection(CurrentObject).CloseDataSets;
  end;
end;

procedure TatSqlExprLibrary.__TSQLConnectionCommit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLConnection(CurrentObject).Commit(TTransactionDescWrapper(integer(GetInputArg(0))).ObjToRec);
  end;
end;

procedure TatSqlExprLibrary.__TSQLConnectionExecuteDirect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSQLConnection(CurrentObject).ExecuteDirect(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TSQLConnectionGetFieldNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLConnection(CurrentObject).GetFieldNames(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatSqlExprLibrary.__TSQLConnectionGetIndexNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLConnection(CurrentObject).GetIndexNames(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatSqlExprLibrary.__TSQLConnectionGetProcedureNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLConnection(CurrentObject).GetProcedureNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatSqlExprLibrary.__TSQLConnectionGetPackageNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLConnection(CurrentObject).GetPackageNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatSqlExprLibrary.__TSQLConnectionGetSchemaNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLConnection(CurrentObject).GetSchemaNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatSqlExprLibrary.__TSQLConnectionGetDefaultSchemaName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TSQLConnection(CurrentObject).GetDefaultSchemaName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TSQLConnectionGetProcedureParams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLConnection(CurrentObject).GetProcedureParams(GetInputArg(0),TList(Integer(GetInputArg(1))));
  end;
end;

procedure TatSqlExprLibrary.__TSQLConnectionGetTableNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      1: TSQLConnection(CurrentObject).GetTableNames(TStrings(Integer(GetInputArg(0))));
      2: TSQLConnection(CurrentObject).GetTableNames(TStrings(Integer(GetInputArg(0))),GetInputArg(1));
    end;
  end;
end;

procedure TatSqlExprLibrary.__TSQLConnectionLoadParamsFromIniFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      0: TSQLConnection(CurrentObject).LoadParamsFromIniFile;
      1: TSQLConnection(CurrentObject).LoadParamsFromIniFile(GetInputArg(0));
    end;
  end;
end;

procedure TatSqlExprLibrary.__TSQLConnectionRollback(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLConnection(CurrentObject).Rollback(TTransactionDescWrapper(integer(GetInputArg(0))).ObjToRec);
  end;
end;

procedure TatSqlExprLibrary.__TSQLConnectionStartTransaction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLConnection(CurrentObject).StartTransaction(TTransactionDescWrapper(integer(GetInputArg(0))).ObjToRec);
  end;
end;

procedure TatSqlExprLibrary.__TSQLConnectionGetLoginUsername(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TSQLConnection(CurrentObject).GetLoginUsername;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__GetTSQLConnectionActiveStatements(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSQLConnection(CurrentObject).ActiveStatements));
  end;
end;

procedure TatSqlExprLibrary.__GetTSQLConnectionAutoClone(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TSQLConnection(CurrentObject).AutoClone);
  end;
end;

procedure TatSqlExprLibrary.__SetTSQLConnectionAutoClone(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLConnection(CurrentObject).AutoClone:=GetInputArg(0);
  end;
end;

procedure TatSqlExprLibrary.__GetTSQLConnectionConnectionState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TSQLConnection(CurrentObject).ConnectionState);
  end;
end;

procedure TatSqlExprLibrary.__SetTSQLConnectionConnectionState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLConnection(CurrentObject).ConnectionState:=GetInputArg(0);
  end;
end;

procedure TatSqlExprLibrary.__GetTSQLConnectionDataSets(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSQLConnection(CurrentObject).DataSets[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatSqlExprLibrary.__GetTSQLConnectionInTransaction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TSQLConnection(CurrentObject).InTransaction);
  end;
end;

procedure TatSqlExprLibrary.__GetTSQLConnectionLocaleCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSQLConnection(CurrentObject).LocaleCode));
  end;
end;

procedure TatSqlExprLibrary.__SetTSQLConnectionLocaleCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLConnection(CurrentObject).LocaleCode:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSqlExprLibrary.__GetTSQLConnectionMaxStmtsPerConn(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSQLConnection(CurrentObject).MaxStmtsPerConn));
  end;
end;

procedure TatSqlExprLibrary.__GetTSQLConnectionMetaData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSQLConnection(CurrentObject).MetaData));
  end;
end;

procedure TatSqlExprLibrary.__GetTSQLConnectionMultipleTransactionsSupported(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TSQLConnection(CurrentObject).MultipleTransactionsSupported);
  end;
end;

procedure TatSqlExprLibrary.__GetTSQLConnectionParamsLoaded(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TSQLConnection(CurrentObject).ParamsLoaded);
  end;
end;

procedure TatSqlExprLibrary.__SetTSQLConnectionParamsLoaded(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLConnection(CurrentObject).ParamsLoaded:=GetInputArg(0);
  end;
end;

procedure TatSqlExprLibrary.__GetTSQLConnectionSQLConnection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSQLConnection(CurrentObject).SQLConnection));
  end;
end;

procedure TatSqlExprLibrary.__SetTSQLConnectionSQLConnection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLConnection(CurrentObject).SQLConnection:=TISQLConnection(Integer(GetInputArg(0)));
  end;
end;

procedure TatSqlExprLibrary.__GetTSQLConnectionSQLHourGlass(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TSQLConnection(CurrentObject).SQLHourGlass);
  end;
end;

procedure TatSqlExprLibrary.__SetTSQLConnectionSQLHourGlass(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLConnection(CurrentObject).SQLHourGlass:=GetInputArg(0);
  end;
end;

procedure TatSqlExprLibrary.__GetTSQLConnectionTransactionsSupported(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TSQLConnection(CurrentObject).TransactionsSupported);
  end;
end;

procedure TatSqlExprLibrary.__TSQLDataLinkCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSQLDataLinkClass(CurrentClass.ClassRef).Create(TCustomSQLDataSet(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__GetTFLDDesciFldNum(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFLDDesc(CurrentObject).iFldNum));
  end;
end;

procedure TatSqlExprLibrary.__SetTFLDDesciFldNum(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFLDDesc(CurrentObject).iFldNum:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSqlExprLibrary.__GetTFLDDescszName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TFLDDesc(CurrentObject).szName);
  end;
end;

procedure TatSqlExprLibrary.__SetTFLDDescszName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFLDDesc(CurrentObject).szName:=GetInputArg(0);
  end;
end;

procedure TatSqlExprLibrary.__GetTFLDDesciFldType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFLDDesc(CurrentObject).iFldType));
  end;
end;

procedure TatSqlExprLibrary.__SetTFLDDesciFldType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFLDDesc(CurrentObject).iFldType:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSqlExprLibrary.__GetTFLDDesciSubType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFLDDesc(CurrentObject).iSubType));
  end;
end;

procedure TatSqlExprLibrary.__SetTFLDDesciSubType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFLDDesc(CurrentObject).iSubType:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSqlExprLibrary.__GetTFLDDesciUnits1(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFLDDesc(CurrentObject).iUnits1));
  end;
end;

procedure TatSqlExprLibrary.__SetTFLDDesciUnits1(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFLDDesc(CurrentObject).iUnits1:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSqlExprLibrary.__GetTFLDDesciUnits2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFLDDesc(CurrentObject).iUnits2));
  end;
end;

procedure TatSqlExprLibrary.__SetTFLDDesciUnits2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFLDDesc(CurrentObject).iUnits2:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSqlExprLibrary.__GetTFLDDesciOffset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFLDDesc(CurrentObject).iOffset));
  end;
end;

procedure TatSqlExprLibrary.__SetTFLDDesciOffset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFLDDesc(CurrentObject).iOffset:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSqlExprLibrary.__GetTFLDDesciLen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFLDDesc(CurrentObject).iLen));
  end;
end;

procedure TatSqlExprLibrary.__SetTFLDDesciLen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFLDDesc(CurrentObject).iLen:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSqlExprLibrary.__GetTFLDDesciNullOffset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFLDDesc(CurrentObject).iNullOffset));
  end;
end;

procedure TatSqlExprLibrary.__SetTFLDDesciNullOffset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFLDDesc(CurrentObject).iNullOffset:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSqlExprLibrary.__GetTFLDDescefldvVchk(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TFLDDesc(CurrentObject).efldvVchk);
  end;
end;

procedure TatSqlExprLibrary.__SetTFLDDescefldvVchk(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFLDDesc(CurrentObject).efldvVchk:=GetInputArg(0);
  end;
end;

procedure TatSqlExprLibrary.__GetTFLDDescefldrRights(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TFLDDesc(CurrentObject).efldrRights);
  end;
end;

procedure TatSqlExprLibrary.__SetTFLDDescefldrRights(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFLDDesc(CurrentObject).efldrRights:=GetInputArg(0);
  end;
end;

procedure TatSqlExprLibrary.__GetTFLDDescbCalcField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TFLDDesc(CurrentObject).bCalcField);
  end;
end;

procedure TatSqlExprLibrary.__SetTFLDDescbCalcField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFLDDesc(CurrentObject).bCalcField:=GetInputArg(0);
  end;
end;

procedure TatSqlExprLibrary.__TCustomSQLDataSetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomSQLDataSetClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TCustomSQLDataSetDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomSQLDataSet(CurrentObject).Destroy;
  end;
end;

procedure TatSqlExprLibrary.__TCustomSQLDataSetCreateBlobStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomSQLDataSet(CurrentObject).CreateBlobStream(TField(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TCustomSQLDataSetGetDetailLinkFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomSQLDataSet(CurrentObject).GetDetailLinkFields(TList(Integer(GetInputArg(0))),TList(Integer(GetInputArg(1))));
  end;
end;

procedure TatSqlExprLibrary.__TCustomSQLDataSetGetKeyFieldNames(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomSQLDataSet(CurrentObject).GetKeyFieldNames(TStrings(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TCustomSQLDataSetGetQuoteChar(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomSQLDataSet(CurrentObject).GetQuoteChar;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TCustomSQLDataSetParamByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomSQLDataSet(CurrentObject).ParamByName(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TCustomSQLDataSetPrepareStatement(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomSQLDataSet(CurrentObject).PrepareStatement;
  end;
end;

procedure TatSqlExprLibrary.__TCustomSQLDataSetIsSequenced(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomSQLDataSet(CurrentObject).IsSequenced;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TCustomSQLDataSetLocate(AMachine: TatVirtualMachine);
  var
  Param2: TLocateOptions;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := TCustomSQLDataSet(CurrentObject).Locate(GetInputArg(0),GetInputArg(1),Param2);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TCustomSQLDataSetLookup(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomSQLDataSet(CurrentObject).Lookup(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TCustomSQLDataSetSetSchemaInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      3: TCustomSQLDataSet(CurrentObject).SetSchemaInfo(GetInputArg(0),GetInputArg(1),GetInputArg(2));
      4: TCustomSQLDataSet(CurrentObject).SetSchemaInfo(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
    end;
  end;
end;

procedure TatSqlExprLibrary.__GetTCustomSQLDataSetCommandText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomSQLDataSet(CurrentObject).CommandText);
  end;
end;

procedure TatSqlExprLibrary.__SetTCustomSQLDataSetCommandText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomSQLDataSet(CurrentObject).CommandText:=GetInputArg(0);
  end;
end;

procedure TatSqlExprLibrary.__GetTCustomSQLDataSetIndexDefs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomSQLDataSet(CurrentObject).IndexDefs));
  end;
end;

procedure TatSqlExprLibrary.__SetTCustomSQLDataSetIndexDefs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomSQLDataSet(CurrentObject).IndexDefs:=TIndexDefs(Integer(GetInputArg(0)));
  end;
end;

procedure TatSqlExprLibrary.__GetTCustomSQLDataSetPrepared(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomSQLDataSet(CurrentObject).Prepared);
  end;
end;

procedure TatSqlExprLibrary.__SetTCustomSQLDataSetPrepared(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomSQLDataSet(CurrentObject).Prepared:=GetInputArg(0);
  end;
end;

procedure TatSqlExprLibrary.__GetTCustomSQLDataSetDesignerData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomSQLDataSet(CurrentObject).DesignerData);
  end;
end;

procedure TatSqlExprLibrary.__SetTCustomSQLDataSetDesignerData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomSQLDataSet(CurrentObject).DesignerData:=GetInputArg(0);
  end;
end;

procedure TatSqlExprLibrary.__GetTCustomSQLDataSetRecordCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomSQLDataSet(CurrentObject).RecordCount));
  end;
end;

procedure TatSqlExprLibrary.__GetTCustomSQLDataSetSQLConnection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomSQLDataSet(CurrentObject).SQLConnection));
  end;
end;

procedure TatSqlExprLibrary.__SetTCustomSQLDataSetSQLConnection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomSQLDataSet(CurrentObject).SQLConnection:=TSQLConnection(Integer(GetInputArg(0)));
  end;
end;

procedure TatSqlExprLibrary.__GetTCustomSQLDataSetTransactionLevel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomSQLDataSet(CurrentObject).TransactionLevel));
  end;
end;

procedure TatSqlExprLibrary.__SetTCustomSQLDataSetTransactionLevel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomSQLDataSet(CurrentObject).TransactionLevel:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSqlExprLibrary.__TSQLDataSetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSQLDataSetClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TSQLDataSetExecSQL(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := Integer(TSQLDataSet(CurrentObject).ExecSQL);
1: AResult := Integer(TSQLDataSet(CurrentObject).ExecSQL(GetInputArg(0)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TSQLQueryCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSQLQueryClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TSQLQueryDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLQuery(CurrentObject).Destroy;
  end;
end;

procedure TatSqlExprLibrary.__TSQLQueryExecSQL(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := Integer(TSQLQuery(CurrentObject).ExecSQL);
1: AResult := Integer(TSQLQuery(CurrentObject).ExecSQL(GetInputArg(0)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TSQLQueryPrepareStatement(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLQuery(CurrentObject).PrepareStatement;
  end;
end;

procedure TatSqlExprLibrary.__GetTSQLQueryText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TSQLQuery(CurrentObject).Text);
  end;
end;

procedure TatSqlExprLibrary.__TSQLStoredProcCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSQLStoredProcClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TSQLStoredProcExecProc(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSQLStoredProc(CurrentObject).ExecProc);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TSQLStoredProcNextRecordSet(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSQLStoredProc(CurrentObject).NextRecordSet);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TSQLStoredProcPrepareStatement(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLStoredProc(CurrentObject).PrepareStatement;
  end;
end;

procedure TatSqlExprLibrary.__TSQLTableCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSQLTableClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__TSQLTableDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLTable(CurrentObject).Destroy;
  end;
end;

procedure TatSqlExprLibrary.__TSQLTableDeleteRecords(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLTable(CurrentObject).DeleteRecords;
  end;
end;

procedure TatSqlExprLibrary.__TSQLTableGetIndexNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLTable(CurrentObject).GetIndexNames(TWideStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatSqlExprLibrary.__TSQLTablePrepareStatement(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLTable(CurrentObject).PrepareStatement;
  end;
end;

procedure TatSqlExprLibrary.__GetTSQLTableIndexFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSQLTable(CurrentObject).IndexFields[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatSqlExprLibrary.__SetTSQLTableIndexFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLTable(CurrentObject).IndexFields[VarToInteger(GetArrayIndex(0))]:=TField(Integer(GetInputArg(0)));
  end;
end;

procedure TatSqlExprLibrary.__GetTSQLTableIndexFieldCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSQLTable(CurrentObject).IndexFieldCount));
  end;
end;

procedure TatSqlExprDispatcher.__TConnectChangeEvent( Sender: TObject;  Connecting: Boolean);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TConnectChangeEvent(BeforeCall)(Sender,Connecting);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Connecting]);
    if AssignedMethod(AfterCall) then
      TConnectChangeEvent(AfterCall)(Sender,Connecting);
  end;
end;

procedure TatSqlExprDispatcher.__TSQLConnectionLoginEvent( Database: TSQLConnection;  LoginParams: TWideStrings);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TSQLConnectionLoginEvent(BeforeCall)(Database,LoginParams);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Database,LoginParams]);
    if AssignedMethod(AfterCall) then
      TSQLConnectionLoginEvent(AfterCall)(Database,LoginParams);
  end;
end;

procedure TatSqlExprDispatcher.__TParseSqlEvent(var FieldNames: TWideStrings;  SQL: WideString; var TableName: WideString);
var
  FieldNamesTemp: variant;
  TableNameTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TParseSqlEvent(BeforeCall)(FieldNames,SQL,TableName);
    FieldNamesTemp := Integer(FieldNames);
    TableNameTemp := TableName;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [FieldNamesTemp,SQL,TableNameTemp]);
    FieldNames := TWideStrings(Integer(FieldNamesTemp));
    TableName := TableNameTemp;
    if AssignedMethod(AfterCall) then
      TParseSqlEvent(AfterCall)(FieldNames,SQL,TableName);
  end;
end;

procedure TatSqlExprDispatcher.__TParseInsertSqlEvent(var FieldNames: TWideStrings;  SQL: WideString; var BindAllFields: Boolean; var TableName: WideString);
var
  FieldNamesTemp: variant;
  BindAllFieldsTemp: variant;
  TableNameTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TParseInsertSqlEvent(BeforeCall)(FieldNames,SQL,BindAllFields,TableName);
    FieldNamesTemp := Integer(FieldNames);
    BindAllFieldsTemp := BindAllFields;
    TableNameTemp := TableName;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [FieldNamesTemp,SQL,BindAllFieldsTemp,TableNameTemp]);
    FieldNames := TWideStrings(Integer(FieldNamesTemp));
    BindAllFields := BindAllFieldsTemp;
    TableName := TableNameTemp;
    if AssignedMethod(AfterCall) then
      TParseInsertSqlEvent(AfterCall)(FieldNames,SQL,BindAllFields,TableName);
  end;
end;

procedure TatSqlExprLibrary.__LoadParamListItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SqlExpr.LoadParamListItems(TParams(Integer(GetInputArg(0))),TList(Integer(GetInputArg(1))));
  end;
end;

procedure TatSqlExprLibrary.__FreeProcParams(AMachine: TatVirtualMachine);
  var
  Param0: TList;
begin
  with AMachine do
  begin
Param0 := TList(Integer(GetInputArg(0)));
    SqlExpr.FreeProcParams(Param0);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatSqlExprLibrary.__GetConnectionNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      1: SqlExpr.GetConnectionNames(TStrings(Integer(GetInputArg(0))));
      2: SqlExpr.GetConnectionNames(TStrings(Integer(GetInputArg(0))),GetInputArg(1));
      3: SqlExpr.GetConnectionNames(TStrings(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
    end;
  end;
end;

procedure TatSqlExprLibrary.__GetDriverNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      1: SqlExpr.GetDriverNames(TStrings(Integer(GetInputArg(0))));
      2: SqlExpr.GetDriverNames(TStrings(Integer(GetInputArg(0))),GetInputArg(1));
    end;
  end;
end;

procedure TatSqlExprLibrary.__GetDriverRegistryFile(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := SqlExpr.GetDriverRegistryFile;
1: AResult := SqlExpr.GetDriverRegistryFile(GetInputArg(0));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__GetConnectionRegistryFile(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := SqlExpr.GetConnectionRegistryFile;
1: AResult := SqlExpr.GetConnectionRegistryFile(GetInputArg(0));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlExprLibrary.__GetDllHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(SqlExpr.DllHandle));
  end;
end;

procedure TatSqlExprLibrary.__SetDllHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SqlExpr.DllHandle:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSqlExprLibrary.Init;
begin
  With Scripter.DefineClass(TSQLBlobStream) do
  begin
    DefineMethod('Create',2,tkClass,TSQLBlobStream,__TSQLBlobStreamCreate,true,1);
    DefineMethod('Destroy',0,tkNone,nil,__TSQLBlobStreamDestroy,false,0);
    DefineMethod('ReadBlobData',0,tkNone,nil,__TSQLBlobStreamReadBlobData,false,0);
  end;
  With Scripter.DefineClass(TISQLConnection) do
  begin
    DefineMethod('connect',0,tkInteger,nil,__TISQLConnectionconnect,false,0);
    DefineMethod('disconnect',0,tkInteger,nil,__TISQLConnectiondisconnect,false,0);
    DefineMethod('getSQLCommand',1,tkInteger,nil,__TISQLConnectiongetSQLCommand,false,0).SetVarArgs([0]);
    DefineMethod('getSQLMetaData',1,tkInteger,nil,__TISQLConnectiongetSQLMetaData,false,0).SetVarArgs([0]);
    DefineMethod('SetOption',2,tkInteger,nil,__TISQLConnectionSetOption,false,0);
    DefineMethod('SetStringOption',2,tkInteger,nil,__TISQLConnectionSetStringOption,false,0);
    DefineMethod('GetStringOption',2,tkInteger,nil,__TISQLConnectionGetStringOption,false,0).SetVarArgs([1]);
    DefineMethod('beginTransaction',1,tkInteger,nil,__TISQLConnectionbeginTransaction,false,0);
    DefineMethod('commit',1,tkInteger,nil,__TISQLConnectioncommit,false,0);
    DefineMethod('rollback',1,tkInteger,nil,__TISQLConnectionrollback,false,0);
    DefineMethod('getErrorMessage',1,tkInteger,nil,__TISQLConnectiongetErrorMessage,false,0);
    DefineMethod('getErrorMessageLen',1,tkInteger,nil,__TISQLConnectiongetErrorMessageLen,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(TISQLCommand) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TISQLCommandDestroy,false,0);
    DefineMethod('SetOption',2,tkInteger,nil,__TISQLCommandSetOption,false,0);
    DefineMethod('SetStringOption',2,tkInteger,nil,__TISQLCommandSetStringOption,false,0);
    DefineMethod('GetStringOption',2,tkInteger,nil,__TISQLCommandGetStringOption,false,0).SetVarArgs([1]);
    DefineMethod('prepare',2,tkInteger,nil,__TISQLCommandprepare,false,0);
    DefineMethod('execute',1,tkInteger,nil,__TISQLCommandexecute,false,0).SetVarArgs([0]);
    DefineMethod('executeImmediate',2,tkInteger,nil,__TISQLCommandexecuteImmediate,false,0).SetVarArgs([1]);
    DefineMethod('getNextCursor',1,tkInteger,nil,__TISQLCommandgetNextCursor,false,0).SetVarArgs([0]);
    DefineMethod('getRowsAffected',1,tkInteger,nil,__TISQLCommandgetRowsAffected,false,0).SetVarArgs([0]);
    DefineMethod('close',0,tkInteger,nil,__TISQLCommandclose,false,0);
    DefineMethod('getErrorMessage',1,tkInteger,nil,__TISQLCommandgetErrorMessage,false,0);
    DefineMethod('getErrorMessageLen',1,tkInteger,nil,__TISQLCommandgetErrorMessageLen,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(TISQLCursor) do
  begin
    DefineMethod('SetOption',2,tkInteger,nil,__TISQLCursorSetOption,false,0);
    DefineMethod('SetStringOption',2,tkInteger,nil,__TISQLCursorSetStringOption,false,0);
    DefineMethod('GetStringOption',2,tkInteger,nil,__TISQLCursorGetStringOption,false,0).SetVarArgs([1]);
    DefineMethod('getCurObjectTypeName',1,tkVariant,nil,__TISQLCursorgetCurObjectTypeName,false,0);
    DefineMethod('getErrorMessage',1,tkInteger,nil,__TISQLCursorgetErrorMessage,false,0);
    DefineMethod('getErrorMessageLen',1,tkInteger,nil,__TISQLCursorgetErrorMessageLen,false,0).SetVarArgs([0]);
    DefineMethod('getColumnCount',1,tkInteger,nil,__TISQLCursorgetColumnCount,false,0).SetVarArgs([0]);
    DefineMethod('getColumnNameLength',2,tkInteger,nil,__TISQLCursorgetColumnNameLength,false,0).SetVarArgs([1]);
    DefineMethod('getColumnName',2,tkInteger,nil,__TISQLCursorgetColumnName,false,0);
    DefineMethod('getColumnType',3,tkInteger,nil,__TISQLCursorgetColumnType,false,0).SetVarArgs([1,2]);
    DefineMethod('getColumnLength',2,tkInteger,nil,__TISQLCursorgetColumnLength,false,0).SetVarArgs([1]);
    DefineMethod('getColumnPrecision',2,tkInteger,nil,__TISQLCursorgetColumnPrecision,false,0).SetVarArgs([1]);
    DefineMethod('getColumnScale',2,tkInteger,nil,__TISQLCursorgetColumnScale,false,0).SetVarArgs([1]);
    DefineMethod('isNullable',2,tkInteger,nil,__TISQLCursorisNullable,false,0).SetVarArgs([1]);
    DefineMethod('isAutoIncrement',2,tkInteger,nil,__TISQLCursorisAutoIncrement,false,0).SetVarArgs([1]);
    DefineMethod('isReadOnly',2,tkInteger,nil,__TISQLCursorisReadOnly,false,0).SetVarArgs([1]);
    DefineMethod('isSearchable',2,tkInteger,nil,__TISQLCursorisSearchable,false,0).SetVarArgs([1]);
    DefineMethod('isBlobSizeExact',2,tkInteger,nil,__TISQLCursorisBlobSizeExact,false,0).SetVarArgs([1]);
    DefineMethod('next',0,tkInteger,nil,__TISQLCursornext,false,0);
    DefineMethod('getString',3,tkInteger,nil,__TISQLCursorgetString,false,0).SetVarArgs([2]);
    DefineMethod('getWideString',3,tkInteger,nil,__TISQLCursorgetWideString,false,0).SetVarArgs([2]);
    DefineMethod('getBlobSize',3,tkInteger,nil,__TISQLCursorgetBlobSize,false,0).SetVarArgs([1,2]);
  end;
  With Scripter.DefineClass(TISQLMetaData) do
  begin
    DefineMethod('SetOption',2,tkInteger,nil,__TISQLMetaDataSetOption,false,0);
    DefineMethod('SetStringOption',2,tkInteger,nil,__TISQLMetaDataSetStringOption,false,0);
    DefineMethod('GetStringOption',2,tkInteger,nil,__TISQLMetaDataGetStringOption,false,0).SetVarArgs([1]);
    DefineMethod('getObjectList',2,tkInteger,nil,__TISQLMetaDatagetObjectList,false,0).SetVarArgs([1]);
    DefineMethod('getTables',3,tkInteger,nil,__TISQLMetaDatagetTables,false,0).SetVarArgs([2]);
    DefineMethod('getProcedures',3,tkInteger,nil,__TISQLMetaDatagetProcedures,false,0).SetVarArgs([2]);
    DefineMethod('getColumns',4,tkInteger,nil,__TISQLMetaDatagetColumns,false,0).SetVarArgs([3]);
    DefineMethod('getProcedureParams',3,tkInteger,nil,__TISQLMetaDatagetProcedureParams,false,0).SetVarArgs([2]);
    DefineMethod('getIndices',3,tkInteger,nil,__TISQLMetaDatagetIndices,false,0).SetVarArgs([2]);
    DefineMethod('getErrorMessage',1,tkInteger,nil,__TISQLMetaDatagetErrorMessage,false,0);
    DefineMethod('getErrorMessageLen',1,tkInteger,nil,__TISQLMetaDatagetErrorMessageLen,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(TSQLMonitor) do
  begin
    DefineMethod('Create',1,tkClass,TSQLMonitor,__TSQLMonitorCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TSQLMonitorDestroy,false,0);
    DefineMethod('LoadFromFile',1,tkNone,nil,__TSQLMonitorLoadFromFile,false,0);
    DefineMethod('SaveToFile',1,tkNone,nil,__TSQLMonitorSaveToFile,false,0);
    DefineProp('MaxTraceCount',tkInteger,__GetTSQLMonitorMaxTraceCount,__SetTSQLMonitorMaxTraceCount,nil,false,0);
    DefineProp('TraceCount',tkInteger,__GetTSQLMonitorTraceCount,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TSQLConnection) do
  begin
    DefineMethod('Create',1,tkClass,TSQLConnection,__TSQLConnectionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TSQLConnectionDestroy,false,0);
    DefineMethod('CloneConnection',0,tkClass,TSQLConnection,__TSQLConnectionCloneConnection,false,0);
    DefineMethod('CloseDataSets',0,tkNone,nil,__TSQLConnectionCloseDataSets,false,0);
    DefineMethod('Commit',1,tkNone,nil,__TSQLConnectionCommit,false,0);
    DefineMethod('ExecuteDirect',1,tkInteger,nil,__TSQLConnectionExecuteDirect,false,0);
    DefineMethod('GetFieldNames',2,tkNone,nil,__TSQLConnectionGetFieldNames,false,0);
    DefineMethod('GetIndexNames',2,tkNone,nil,__TSQLConnectionGetIndexNames,false,0);
    DefineMethod('GetProcedureNames',1,tkNone,nil,__TSQLConnectionGetProcedureNames,false,0);
    DefineMethod('GetPackageNames',1,tkNone,nil,__TSQLConnectionGetPackageNames,false,0);
    DefineMethod('GetSchemaNames',1,tkNone,nil,__TSQLConnectionGetSchemaNames,false,0);
    DefineMethod('GetDefaultSchemaName',0,tkVariant,nil,__TSQLConnectionGetDefaultSchemaName,false,0);
    DefineMethod('GetProcedureParams',2,tkNone,nil,__TSQLConnectionGetProcedureParams,false,0);
    DefineMethod('GetTableNames',2,tkNone,nil,__TSQLConnectionGetTableNames,false,1);
    DefineMethod('LoadParamsFromIniFile',1,tkNone,nil,__TSQLConnectionLoadParamsFromIniFile,false,1);
    DefineMethod('Rollback',1,tkNone,nil,__TSQLConnectionRollback,false,0);
    DefineMethod('StartTransaction',1,tkNone,nil,__TSQLConnectionStartTransaction,false,0);
    DefineMethod('GetLoginUsername',0,tkVariant,nil,__TSQLConnectionGetLoginUsername,false,0);
    DefineProp('ActiveStatements',tkInteger,__GetTSQLConnectionActiveStatements,nil,nil,false,0);
    DefineProp('AutoClone',tkVariant,__GetTSQLConnectionAutoClone,__SetTSQLConnectionAutoClone,nil,false,0);
    DefineProp('ConnectionState',tkEnumeration,__GetTSQLConnectionConnectionState,__SetTSQLConnectionConnectionState,nil,false,0);
    DefineProp('DataSets',tkClass,__GetTSQLConnectionDataSets,nil,TCustomSQLDataSet,false,1);
    DefineProp('InTransaction',tkVariant,__GetTSQLConnectionInTransaction,nil,nil,false,0);
    DefineProp('LocaleCode',tkInteger,__GetTSQLConnectionLocaleCode,__SetTSQLConnectionLocaleCode,nil,false,0);
    DefineProp('MaxStmtsPerConn',tkInteger,__GetTSQLConnectionMaxStmtsPerConn,nil,nil,false,0);
    DefineProp('MetaData',tkClass,__GetTSQLConnectionMetaData,nil,TISQLMetaData,false,0);
    DefineProp('MultipleTransactionsSupported',tkVariant,__GetTSQLConnectionMultipleTransactionsSupported,nil,nil,false,0);
    DefineProp('ParamsLoaded',tkVariant,__GetTSQLConnectionParamsLoaded,__SetTSQLConnectionParamsLoaded,nil,false,0);
    DefineProp('SQLConnection',tkClass,__GetTSQLConnectionSQLConnection,__SetTSQLConnectionSQLConnection,TISQLConnection,false,0);
    DefineProp('SQLHourGlass',tkVariant,__GetTSQLConnectionSQLHourGlass,__SetTSQLConnectionSQLHourGlass,nil,false,0);
    DefineProp('TransactionsSupported',tkVariant,__GetTSQLConnectionTransactionsSupported,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TSQLDataLink) do
  begin
    DefineMethod('Create',1,tkClass,TSQLDataLink,__TSQLDataLinkCreate,true,0);
  end;
  With Scripter.DefineClass(TFLDDesc) do
  begin
    DefineProp('iFldNum',tkInteger,__GetTFLDDesciFldNum,__SetTFLDDesciFldNum,nil,false,0);
    DefineProp('szName',tkVariant,__GetTFLDDescszName,__SetTFLDDescszName,nil,false,0);
    DefineProp('iFldType',tkInteger,__GetTFLDDesciFldType,__SetTFLDDesciFldType,nil,false,0);
    DefineProp('iSubType',tkInteger,__GetTFLDDesciSubType,__SetTFLDDesciSubType,nil,false,0);
    DefineProp('iUnits1',tkInteger,__GetTFLDDesciUnits1,__SetTFLDDesciUnits1,nil,false,0);
    DefineProp('iUnits2',tkInteger,__GetTFLDDesciUnits2,__SetTFLDDesciUnits2,nil,false,0);
    DefineProp('iOffset',tkInteger,__GetTFLDDesciOffset,__SetTFLDDesciOffset,nil,false,0);
    DefineProp('iLen',tkInteger,__GetTFLDDesciLen,__SetTFLDDesciLen,nil,false,0);
    DefineProp('iNullOffset',tkInteger,__GetTFLDDesciNullOffset,__SetTFLDDesciNullOffset,nil,false,0);
    DefineProp('efldvVchk',tkEnumeration,__GetTFLDDescefldvVchk,__SetTFLDDescefldvVchk,nil,false,0);
    DefineProp('efldrRights',tkEnumeration,__GetTFLDDescefldrRights,__SetTFLDDescefldrRights,nil,false,0);
    DefineProp('bCalcField',tkVariant,__GetTFLDDescbCalcField,__SetTFLDDescbCalcField,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomSQLDataSet) do
  begin
    DefineMethod('Create',1,tkClass,TCustomSQLDataSet,__TCustomSQLDataSetCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomSQLDataSetDestroy,false,0);
    DefineMethod('CreateBlobStream',2,tkClass,TStream,__TCustomSQLDataSetCreateBlobStream,false,0);
    DefineMethod('GetDetailLinkFields',2,tkNone,nil,__TCustomSQLDataSetGetDetailLinkFields,false,0);
    DefineMethod('GetKeyFieldNames',1,tkInteger,nil,__TCustomSQLDataSetGetKeyFieldNames,false,0);
    DefineMethod('GetQuoteChar',0,tkVariant,nil,__TCustomSQLDataSetGetQuoteChar,false,0);
    DefineMethod('ParamByName',1,tkClass,TParam,__TCustomSQLDataSetParamByName,false,0);
    DefineMethod('PrepareStatement',0,tkNone,nil,__TCustomSQLDataSetPrepareStatement,false,0);
    DefineMethod('IsSequenced',0,tkVariant,nil,__TCustomSQLDataSetIsSequenced,false,0);
    DefineMethod('Locate',3,tkVariant,nil,__TCustomSQLDataSetLocate,false,0);
    DefineMethod('Lookup',3,tkVariant,nil,__TCustomSQLDataSetLookup,false,0);
    DefineMethod('SetSchemaInfo',4,tkNone,nil,__TCustomSQLDataSetSetSchemaInfo,false,1);
    DefineProp('CommandText',tkVariant,__GetTCustomSQLDataSetCommandText,__SetTCustomSQLDataSetCommandText,nil,false,0);
    DefineProp('IndexDefs',tkClass,__GetTCustomSQLDataSetIndexDefs,__SetTCustomSQLDataSetIndexDefs,TIndexDefs,false,0);
    DefineProp('Prepared',tkVariant,__GetTCustomSQLDataSetPrepared,__SetTCustomSQLDataSetPrepared,nil,false,0);
    DefineProp('DesignerData',tkVariant,__GetTCustomSQLDataSetDesignerData,__SetTCustomSQLDataSetDesignerData,nil,false,0);
    DefineProp('RecordCount',tkInteger,__GetTCustomSQLDataSetRecordCount,nil,nil,false,0);
    DefineProp('SQLConnection',tkClass,__GetTCustomSQLDataSetSQLConnection,__SetTCustomSQLDataSetSQLConnection,TSQLConnection,false,0);
    DefineProp('TransactionLevel',tkInteger,__GetTCustomSQLDataSetTransactionLevel,__SetTCustomSQLDataSetTransactionLevel,nil,false,0);
  end;
  With Scripter.DefineClass(TSQLDataSet) do
  begin
    DefineMethod('Create',1,tkClass,TSQLDataSet,__TSQLDataSetCreate,true,0);
    DefineMethod('ExecSQL',1,tkInteger,nil,__TSQLDataSetExecSQL,false,1);
  end;
  With Scripter.DefineClass(TSQLQuery) do
  begin
    DefineMethod('Create',1,tkClass,TSQLQuery,__TSQLQueryCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TSQLQueryDestroy,false,0);
    DefineMethod('ExecSQL',1,tkInteger,nil,__TSQLQueryExecSQL,false,1);
    DefineMethod('PrepareStatement',0,tkNone,nil,__TSQLQueryPrepareStatement,false,0);
    DefineProp('RowsAffected',tkVariant,nil,nil,nil,false,0);
    DefineProp('Text',tkVariant,__GetTSQLQueryText,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TSQLStoredProc) do
  begin
    DefineMethod('Create',1,tkClass,TSQLStoredProc,__TSQLStoredProcCreate,true,0);
    DefineMethod('ExecProc',0,tkInteger,nil,__TSQLStoredProcExecProc,false,0);
    DefineMethod('NextRecordSet',0,tkClass,TCustomSQLDataSet,__TSQLStoredProcNextRecordSet,false,0);
    DefineMethod('PrepareStatement',0,tkNone,nil,__TSQLStoredProcPrepareStatement,false,0);
  end;
  With Scripter.DefineClass(TSQLTable) do
  begin
    DefineMethod('Create',1,tkClass,TSQLTable,__TSQLTableCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TSQLTableDestroy,false,0);
    DefineMethod('DeleteRecords',0,tkNone,nil,__TSQLTableDeleteRecords,false,0);
    DefineMethod('GetIndexNames',1,tkNone,nil,__TSQLTableGetIndexNames,false,0);
    DefineMethod('PrepareStatement',0,tkNone,nil,__TSQLTablePrepareStatement,false,0);
    DefineProp('IndexFields',tkClass,__GetTSQLTableIndexFields,__SetTSQLTableIndexFields,TField,false,1);
    DefineProp('IndexFieldCount',tkInteger,__GetTSQLTableIndexFieldCount,nil,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TConnectChangeEvent), TatSqlExprDispatcher, @TatSqlExprDispatcher.__TConnectChangeEvent);
  DefineEventAdapter(TypeInfo(TSQLConnectionLoginEvent), TatSqlExprDispatcher, @TatSqlExprDispatcher.__TSQLConnectionLoginEvent);
  DefineEventAdapter(TypeInfo(TParseSqlEvent), TatSqlExprDispatcher, @TatSqlExprDispatcher.__TParseSqlEvent);
  DefineEventAdapter(TypeInfo(TParseInsertSqlEvent), TatSqlExprDispatcher, @TatSqlExprDispatcher.__TParseInsertSqlEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('LoadParamListItems',2,tkNone,nil,__LoadParamListItems,false,0);
    DefineMethod('FreeProcParams',1,tkNone,nil,__FreeProcParams,false,0).SetVarArgs([0]);
    DefineMethod('GetConnectionNames',3,tkNone,nil,__GetConnectionNames,false,2);
    DefineMethod('GetDriverNames',2,tkNone,nil,__GetDriverNames,false,1);
    DefineMethod('GetDriverRegistryFile',1,tkVariant,nil,__GetDriverRegistryFile,false,1);
    DefineMethod('GetConnectionRegistryFile',1,tkVariant,nil,__GetConnectionRegistryFile,false,1);
    DefineProp('DllHandle',tkInteger,__GetDllHandle,__SetDllHandle,nil,false,0);
    AddConstant('exceptConnection',exceptConnection);
    AddConstant('exceptCommand',exceptCommand);
    AddConstant('exceptCursor',exceptCursor);
    AddConstant('exceptMetaData',exceptMetaData);
    AddConstant('exceptUseLast',exceptUseLast);
    AddConstant('eUserMonitor',eUserMonitor);
    AddConstant('eUserDataSet',eUserDataSet);
    AddConstant('eConnect',eConnect);
    AddConstant('eReconnect',eReconnect);
    AddConstant('eDisconnect',eDisconnect);
    AddConstant('stNoSchema',stNoSchema);
    AddConstant('stTables',stTables);
    AddConstant('stSysTables',stSysTables);
    AddConstant('stProcedures',stProcedures);
    AddConstant('stColumns',stColumns);
    AddConstant('stProcedureParams',stProcedureParams);
    AddConstant('stIndexes',stIndexes);
    AddConstant('stPackages',stPackages);
    AddConstant('stUserNames',stUserNames);
    AddConstant('csStateClosed',csStateClosed);
    AddConstant('csStateOpen',csStateOpen);
    AddConstant('csStateConnecting',csStateConnecting);
    AddConstant('csStateExecuting',csStateExecuting);
    AddConstant('csStateFetching',csStateFetching);
    AddConstant('csStateDisconnecting',csStateDisconnecting);
    AddConstant('tsSynonym',tsSynonym);
    AddConstant('tsSysTable',tsSysTable);
    AddConstant('tsTable',tsTable);
    AddConstant('tsView',tsView);
    AddConstant('SSelect',SSelect);
    AddConstant('SSelectStar',SSelectStar);
    AddConstant('SSelectStarFrom',SSelectStarFrom);
    AddConstant('SSelectSpaces',SSelectSpaces);
    AddConstant('SWhere',SWhere);
    AddConstant('SAnd',SAnd);
    AddConstant('SOrderBy',SOrderBy);
    AddConstant('SParam',SParam);
    AddConstant('DefaultCursor',DefaultCursor);
    AddConstant('HourGlassCursor',HourGlassCursor);
    AddConstant('DefaultMaxBlobSize',DefaultMaxBlobSize);
    AddConstant('DefaultRowsetSize',DefaultRowsetSize);
    AddConstant('TErrorMessageSize',TErrorMessageSize);
  end;
end;

class function TatSqlExprLibrary.LibraryName: string;
begin
  result := 'SqlExpr';
end;

initialization
  RegisterScripterLibrary(TatSqlExprLibrary, True);

{$WARNINGS ON}

end.

