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
unit ap_DBTables;

interface

uses
  Variants,
  Windows,
  SysUtils,
  Classes,
  DB,
  DBCommon,
  DBCommonTypes,
  BDE,
  SMINTF,
  DBTables,
  atScript;

{$WARNINGS OFF}

type
  TatDBTablesLibrary = class(TatScripterLibrary)
    procedure __EDBEngineErrorCreate(AMachine: TatVirtualMachine);
    procedure __EDBEngineErrorDestroy(AMachine: TatVirtualMachine);
    procedure __GetEDBEngineErrorErrorCount(AMachine: TatVirtualMachine);
    procedure __GetEDBEngineErrorErrors(AMachine: TatVirtualMachine);
    procedure __TDBErrorCreate(AMachine: TatVirtualMachine);
    procedure __GetTDBErrorCategory(AMachine: TatVirtualMachine);
    procedure __GetTDBErrorErrorCode(AMachine: TatVirtualMachine);
    procedure __GetTDBErrorSubCode(AMachine: TatVirtualMachine);
    procedure __GetTDBErrorMessage(AMachine: TatVirtualMachine);
    procedure __GetTDBErrorNativeError(AMachine: TatVirtualMachine);
    procedure __TBDECallbackDestroy(AMachine: TatVirtualMachine);
    procedure __TSessionListCreate(AMachine: TatVirtualMachine);
    procedure __TSessionListDestroy(AMachine: TatVirtualMachine);
    procedure __TSessionListFindSession(AMachine: TatVirtualMachine);
    procedure __TSessionListGetSessionNames(AMachine: TatVirtualMachine);
    procedure __TSessionListOpenSession(AMachine: TatVirtualMachine);
    procedure __GetTSessionListCurrentSession(AMachine: TatVirtualMachine);
    procedure __SetTSessionListCurrentSession(AMachine: TatVirtualMachine);
    procedure __GetTSessionListCount(AMachine: TatVirtualMachine);
    procedure __GetTSessionListSessions(AMachine: TatVirtualMachine);
    procedure __GetTSessionListList(AMachine: TatVirtualMachine);
    procedure __TSessionCreate(AMachine: TatVirtualMachine);
    procedure __TSessionDestroy(AMachine: TatVirtualMachine);
    procedure __TSessionAddAlias(AMachine: TatVirtualMachine);
    procedure __TSessionAddDriver(AMachine: TatVirtualMachine);
    procedure __TSessionAddStandardAlias(AMachine: TatVirtualMachine);
    procedure __TSessionAddPassword(AMachine: TatVirtualMachine);
    procedure __TSessionClose(AMachine: TatVirtualMachine);
    procedure __TSessionCloseDatabase(AMachine: TatVirtualMachine);
    procedure __TSessionDeleteAlias(AMachine: TatVirtualMachine);
    procedure __TSessionDeleteDriver(AMachine: TatVirtualMachine);
    procedure __TSessionDropConnections(AMachine: TatVirtualMachine);
    procedure __TSessionFindDatabase(AMachine: TatVirtualMachine);
    procedure __TSessionGetAliasNames(AMachine: TatVirtualMachine);
    procedure __TSessionGetAliasParams(AMachine: TatVirtualMachine);
    procedure __TSessionGetAliasDriverName(AMachine: TatVirtualMachine);
    procedure __TSessionGetConfigParams(AMachine: TatVirtualMachine);
    procedure __TSessionGetDatabaseNames(AMachine: TatVirtualMachine);
    procedure __TSessionGetDriverNames(AMachine: TatVirtualMachine);
    procedure __TSessionGetDriverParams(AMachine: TatVirtualMachine);
    procedure __TSessionGetFieldNames(AMachine: TatVirtualMachine);
    procedure __TSessionGetPassword(AMachine: TatVirtualMachine);
    procedure __TSessionGetTableNames(AMachine: TatVirtualMachine);
    procedure __TSessionGetStoredProcNames(AMachine: TatVirtualMachine);
    procedure __TSessionIsAlias(AMachine: TatVirtualMachine);
    procedure __TSessionModifyAlias(AMachine: TatVirtualMachine);
    procedure __TSessionModifyDriver(AMachine: TatVirtualMachine);
    procedure __TSessionOpen(AMachine: TatVirtualMachine);
    procedure __TSessionOpenDatabase(AMachine: TatVirtualMachine);
    procedure __TSessionRemoveAllPasswords(AMachine: TatVirtualMachine);
    procedure __TSessionRemovePassword(AMachine: TatVirtualMachine);
    procedure __TSessionSaveConfigFile(AMachine: TatVirtualMachine);
    procedure __GetTSessionConfigMode(AMachine: TatVirtualMachine);
    procedure __SetTSessionConfigMode(AMachine: TatVirtualMachine);
    procedure __GetTSessionDatabaseCount(AMachine: TatVirtualMachine);
    procedure __GetTSessionDatabases(AMachine: TatVirtualMachine);
    procedure __GetTSessionTraceFlags(AMachine: TatVirtualMachine);
    procedure __SetTSessionTraceFlags(AMachine: TatVirtualMachine);
    procedure __TParamListCreate(AMachine: TatVirtualMachine);
    procedure __TParamListDestroy(AMachine: TatVirtualMachine);
    procedure __GetTParamListBuffer(AMachine: TatVirtualMachine);
    procedure __GetTParamListFieldCount(AMachine: TatVirtualMachine);
    procedure __TDatabaseCreate(AMachine: TatVirtualMachine);
    procedure __TDatabaseDestroy(AMachine: TatVirtualMachine);
    procedure __TDatabaseCloseDataSets(AMachine: TatVirtualMachine);
    procedure __TDatabaseCommit(AMachine: TatVirtualMachine);
    procedure __TDatabaseFlushSchemaCache(AMachine: TatVirtualMachine);
    procedure __TDatabaseGetFieldNames(AMachine: TatVirtualMachine);
    procedure __TDatabaseGetTableNames(AMachine: TatVirtualMachine);
    procedure __TDatabaseRollback(AMachine: TatVirtualMachine);
    procedure __TDatabaseStartTransaction(AMachine: TatVirtualMachine);
    procedure __TDatabaseValidateName(AMachine: TatVirtualMachine);
    procedure __GetTDatabaseDataSets(AMachine: TatVirtualMachine);
    procedure __GetTDatabaseDirectory(AMachine: TatVirtualMachine);
    procedure __SetTDatabaseDirectory(AMachine: TatVirtualMachine);
    procedure __GetTDatabaseIsSQLBased(AMachine: TatVirtualMachine);
    procedure __GetTDatabaseInTransaction(AMachine: TatVirtualMachine);
    procedure __GetTDatabaseSession(AMachine: TatVirtualMachine);
    procedure __GetTDatabaseTemporary(AMachine: TatVirtualMachine);
    procedure __SetTDatabaseTemporary(AMachine: TatVirtualMachine);
    procedure __GetTDatabaseSessionAlias(AMachine: TatVirtualMachine);
    procedure __GetTDatabaseTraceFlags(AMachine: TatVirtualMachine);
    procedure __SetTDatabaseTraceFlags(AMachine: TatVirtualMachine);
    procedure __TDataSetUpdateObjectApply(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetCreate(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetDestroy(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetApplyUpdates(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetBookmarkValid(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetCancel(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetCancelUpdates(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetCompareBookmarks(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetCommitUpdates(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetConstraintsDisabled(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetCreateBlobStream(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetDisableConstraints(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetEnableConstraints(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetFetchAll(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetFlushBuffers(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetGetBlobFieldData(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetGetIndexInfo(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetLocate(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetLookup(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetIsSequenced(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetPost(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetRevertRecord(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetUpdateStatus(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetTranslate(AMachine: TatVirtualMachine);
    procedure __GetTBDEDataSetCacheBlobs(AMachine: TatVirtualMachine);
    procedure __SetTBDEDataSetCacheBlobs(AMachine: TatVirtualMachine);
    procedure __GetTBDEDataSetExpIndex(AMachine: TatVirtualMachine);
    procedure __GetTBDEDataSetKeySize(AMachine: TatVirtualMachine);
    procedure __GetTBDEDataSetUpdateObject(AMachine: TatVirtualMachine);
    procedure __SetTBDEDataSetUpdateObject(AMachine: TatVirtualMachine);
    procedure __GetTBDEDataSetUpdatesPending(AMachine: TatVirtualMachine);
    procedure __GetTBDEDataSetUpdateRecordTypes(AMachine: TatVirtualMachine);
    procedure __SetTBDEDataSetUpdateRecordTypes(AMachine: TatVirtualMachine);
    procedure __TNestedTableCreate(AMachine: TatVirtualMachine);
    procedure __TDBDataSetCreate(AMachine: TatVirtualMachine);
    procedure __TDBDataSetCheckOpen(AMachine: TatVirtualMachine);
    procedure __TDBDataSetCloseDatabase(AMachine: TatVirtualMachine);
    procedure __TDBDataSetOpenDatabase(AMachine: TatVirtualMachine);
    procedure __GetTDBDataSetDatabase(AMachine: TatVirtualMachine);
    procedure __GetTDBDataSetDBSession(AMachine: TatVirtualMachine);
    procedure __TIndexFilesCreate(AMachine: TatVirtualMachine);
    procedure __TIndexFilesAdd(AMachine: TatVirtualMachine);
    procedure __TIndexFilesClear(AMachine: TatVirtualMachine);
    procedure __TIndexFilesDelete(AMachine: TatVirtualMachine);
    procedure __TIndexFilesInsert(AMachine: TatVirtualMachine);
    procedure __TTableCreate(AMachine: TatVirtualMachine);
    procedure __TTableDestroy(AMachine: TatVirtualMachine);
    procedure __TTableBatchMove(AMachine: TatVirtualMachine);
    procedure __TTableAddIndex(AMachine: TatVirtualMachine);
    procedure __TTableApplyRange(AMachine: TatVirtualMachine);
    procedure __TTableCancelRange(AMachine: TatVirtualMachine);
    procedure __TTableCloseIndexFile(AMachine: TatVirtualMachine);
    procedure __TTableCreateTable(AMachine: TatVirtualMachine);
    procedure __TTableDeleteIndex(AMachine: TatVirtualMachine);
    procedure __TTableDeleteTable(AMachine: TatVirtualMachine);
    procedure __TTableEditKey(AMachine: TatVirtualMachine);
    procedure __TTableEditRangeEnd(AMachine: TatVirtualMachine);
    procedure __TTableEditRangeStart(AMachine: TatVirtualMachine);
    procedure __TTableEmptyTable(AMachine: TatVirtualMachine);
    procedure __TTableGetDetailLinkFields(AMachine: TatVirtualMachine);
    procedure __TTableGetIndexNames(AMachine: TatVirtualMachine);
    procedure __TTableGotoCurrent(AMachine: TatVirtualMachine);
    procedure __TTableGotoKey(AMachine: TatVirtualMachine);
    procedure __TTableGotoNearest(AMachine: TatVirtualMachine);
    procedure __TTableLockTable(AMachine: TatVirtualMachine);
    procedure __TTableOpenIndexFile(AMachine: TatVirtualMachine);
    procedure __TTableRenameTable(AMachine: TatVirtualMachine);
    procedure __TTableSetKey(AMachine: TatVirtualMachine);
    procedure __TTableSetRangeEnd(AMachine: TatVirtualMachine);
    procedure __TTableSetRangeStart(AMachine: TatVirtualMachine);
    procedure __TTableUnlockTable(AMachine: TatVirtualMachine);
    procedure __GetTTableExists(AMachine: TatVirtualMachine);
    procedure __GetTTableIndexFieldCount(AMachine: TatVirtualMachine);
    procedure __GetTTableIndexFields(AMachine: TatVirtualMachine);
    procedure __SetTTableIndexFields(AMachine: TatVirtualMachine);
    procedure __GetTTableKeyExclusive(AMachine: TatVirtualMachine);
    procedure __SetTTableKeyExclusive(AMachine: TatVirtualMachine);
    procedure __GetTTableKeyFieldCount(AMachine: TatVirtualMachine);
    procedure __SetTTableKeyFieldCount(AMachine: TatVirtualMachine);
    procedure __GetTTableTableLevel(AMachine: TatVirtualMachine);
    procedure __SetTTableTableLevel(AMachine: TatVirtualMachine);
    procedure __TBatchMoveCreate(AMachine: TatVirtualMachine);
    procedure __TBatchMoveDestroy(AMachine: TatVirtualMachine);
    procedure __TBatchMoveExecute(AMachine: TatVirtualMachine);
    procedure __GetTBatchMoveChangedCount(AMachine: TatVirtualMachine);
    procedure __GetTBatchMoveKeyViolCount(AMachine: TatVirtualMachine);
    procedure __GetTBatchMoveMovedCount(AMachine: TatVirtualMachine);
    procedure __GetTBatchMoveProblemCount(AMachine: TatVirtualMachine);
    procedure __TStoredProcCreate(AMachine: TatVirtualMachine);
    procedure __TStoredProcDestroy(AMachine: TatVirtualMachine);
    procedure __TStoredProcCopyParams(AMachine: TatVirtualMachine);
    procedure __TStoredProcDescriptionsAvailable(AMachine: TatVirtualMachine);
    procedure __TStoredProcExecProc(AMachine: TatVirtualMachine);
    procedure __TStoredProcParamByName(AMachine: TatVirtualMachine);
    procedure __TStoredProcPrepare(AMachine: TatVirtualMachine);
    procedure __TStoredProcGetResults(AMachine: TatVirtualMachine);
    procedure __TStoredProcUnPrepare(AMachine: TatVirtualMachine);
    procedure __GetTStoredProcParamCount(AMachine: TatVirtualMachine);
    procedure __GetTStoredProcPrepared(AMachine: TatVirtualMachine);
    procedure __SetTStoredProcPrepared(AMachine: TatVirtualMachine);
    procedure __TQueryCreate(AMachine: TatVirtualMachine);
    procedure __TQueryDestroy(AMachine: TatVirtualMachine);
    procedure __TQueryExecSQL(AMachine: TatVirtualMachine);
    procedure __TQueryGetDetailLinkFields(AMachine: TatVirtualMachine);
    procedure __TQueryParamByName(AMachine: TatVirtualMachine);
    procedure __TQueryPrepare(AMachine: TatVirtualMachine);
    procedure __TQueryUnPrepare(AMachine: TatVirtualMachine);
    procedure __GetTQueryPrepared(AMachine: TatVirtualMachine);
    procedure __SetTQueryPrepared(AMachine: TatVirtualMachine);
    procedure __GetTQueryParamCount(AMachine: TatVirtualMachine);
    procedure __GetTQueryLocal(AMachine: TatVirtualMachine);
    procedure __GetTQueryText(AMachine: TatVirtualMachine);
    procedure __GetTQueryRowsAffected(AMachine: TatVirtualMachine);
    procedure __GetTQuerySQLBinary(AMachine: TatVirtualMachine);
    procedure __SetTQuerySQLBinary(AMachine: TatVirtualMachine);
    procedure __TUpdateSQLCreate(AMachine: TatVirtualMachine);
    procedure __TUpdateSQLDestroy(AMachine: TatVirtualMachine);
    procedure __TUpdateSQLApply(AMachine: TatVirtualMachine);
    procedure __TUpdateSQLExecSQL(AMachine: TatVirtualMachine);
    procedure __TUpdateSQLSetParams(AMachine: TatVirtualMachine);
    procedure __GetTUpdateSQLDatabaseName(AMachine: TatVirtualMachine);
    procedure __SetTUpdateSQLDatabaseName(AMachine: TatVirtualMachine);
    procedure __GetTUpdateSQLQuery(AMachine: TatVirtualMachine);
    procedure __GetTUpdateSQLSQL(AMachine: TatVirtualMachine);
    procedure __SetTUpdateSQLSQL(AMachine: TatVirtualMachine);
    procedure __GetTUpdateSQLSessionName(AMachine: TatVirtualMachine);
    procedure __SetTUpdateSQLSessionName(AMachine: TatVirtualMachine);
    procedure __TBlobStreamCreate(AMachine: TatVirtualMachine);
    procedure __TBlobStreamDestroy(AMachine: TatVirtualMachine);
    procedure __TBlobStreamRead(AMachine: TatVirtualMachine);
    procedure __TBlobStreamWrite(AMachine: TatVirtualMachine);
    procedure __TBlobStreamSeek(AMachine: TatVirtualMachine);
    procedure __TBlobStreamTruncate(AMachine: TatVirtualMachine);
    procedure __DbiError(AMachine: TatVirtualMachine);
    procedure __Check(AMachine: TatVirtualMachine);
    procedure __GetSession(AMachine: TatVirtualMachine);
    procedure __SetSession(AMachine: TatVirtualMachine);
    procedure __GetSessions(AMachine: TatVirtualMachine);
    procedure __SetSessions(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EDBEngineErrorClass = class of EDBEngineError;
  ENoResultSetClass = class of ENoResultSet;
  TDBErrorClass = class of TDBError;
  TBDECallbackClass = class of TBDECallback;
  TSessionListClass = class of TSessionList;
  TSessionClass = class of TSession;
  TParamListClass = class of TParamList;
  TDatabaseClass = class of TDatabase;
  TDataSetUpdateObjectClass = class of TDataSetUpdateObject;
  TSQLUpdateObjectClass = class of TSQLUpdateObject;
  TBDEDataSetClass = class of TBDEDataSet;
  TNestedTableClass = class of TNestedTable;
  TDBDataSetClass = class of TDBDataSet;
  TIndexFilesClass = class of TIndexFiles;
  TTableClass = class of TTable;
  TBatchMoveClass = class of TBatchMove;
  TStoredProcClass = class of TStoredProc;
  TQueryClass = class of TQuery;
  TUpdateSQLClass = class of TUpdateSQL;
  TBlobStreamClass = class of TBlobStream;

  TatDBTablesDispatcher = class(TatEventDispatcher)
  private
    procedure __TPasswordEvent( Sender: TObject; var Continue: Boolean);
    procedure __TDatabaseNotifyEvent( DBEvent: TDatabaseEvent; const Param);
    procedure __TDatabaseLoginEvent( Database: TDatabase;  LoginParams: TStrings);
  end;

  TBDEKeyBufferWrapper = class(TatRecordWrapper)
  private
    FModified: Boolean;
    FExclusive: Boolean;
    FFieldCount: Integer;
  public
    constructor Create(ARecord: TBDEKeyBuffer);
    function ObjToRec: TBDEKeyBuffer;
  published
    property Modified: Boolean read FModified write FModified;
    property Exclusive: Boolean read FExclusive write FExclusive;
    property FieldCount: Integer read FFieldCount write FFieldCount;
  end;
  
  TBDERecInfoWrapper = class(TatRecordWrapper)
  private
    FRecordNumber: Longint;
    FUpdateStatus: TUpdateStatus;
    FBookmarkFlag: TBookmarkFlag;
  public
    constructor Create(ARecord: TBDERecInfo);
    function ObjToRec: TBDERecInfo;
  published
    property RecordNumber: Longint read FRecordNumber write FRecordNumber;
    property UpdateStatus: TUpdateStatus read FUpdateStatus write FUpdateStatus;
    property BookmarkFlag: TBookmarkFlag read FBookmarkFlag write FBookmarkFlag;
  end;
  
  TServerDescWrapper = class(TatRecordWrapper)
  private
    FBindType: TFieldType;
  public
    constructor Create(ARecord: TServerDesc);
    function ObjToRec: TServerDesc;
  published
    property BindType: TFieldType read FBindType write FBindType;
  end;
  

implementation

constructor TBDEKeyBufferWrapper.Create(ARecord: TBDEKeyBuffer);
begin
  inherited Create;
  FModified := ARecord.Modified;
  FExclusive := ARecord.Exclusive;
  FFieldCount := ARecord.FieldCount;
end;

function TBDEKeyBufferWrapper.ObjToRec: TBDEKeyBuffer;
begin
  result.Modified := FModified;
  result.Exclusive := FExclusive;
  result.FieldCount := FFieldCount;
end;

constructor TBDERecInfoWrapper.Create(ARecord: TBDERecInfo);
begin
  inherited Create;
  FRecordNumber := ARecord.RecordNumber;
  FUpdateStatus := ARecord.UpdateStatus;
  FBookmarkFlag := ARecord.BookmarkFlag;
end;

function TBDERecInfoWrapper.ObjToRec: TBDERecInfo;
begin
  result.RecordNumber := FRecordNumber;
  result.UpdateStatus := FUpdateStatus;
  result.BookmarkFlag := FBookmarkFlag;
end;

constructor TServerDescWrapper.Create(ARecord: TServerDesc);
begin
  inherited Create;
  FBindType := ARecord.BindType;
end;

function TServerDescWrapper.ObjToRec: TServerDesc;
begin
  result.BindType := FBindType;
end;



procedure TatDBTablesLibrary.__EDBEngineErrorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(EDBEngineErrorClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__EDBEngineErrorDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    EDBEngineError(CurrentObject).Destroy;
  end;
end;

procedure TatDBTablesLibrary.__GetEDBEngineErrorErrorCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(EDBEngineError(CurrentObject).ErrorCount));
  end;
end;

procedure TatDBTablesLibrary.__GetEDBEngineErrorErrors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(EDBEngineError(CurrentObject).Errors[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBTablesLibrary.__TDBErrorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBErrorClass(CurrentClass.ClassRef).Create(EDBEngineError(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__GetTDBErrorCategory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBError(CurrentObject).Category));
  end;
end;

procedure TatDBTablesLibrary.__GetTDBErrorErrorCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBError(CurrentObject).ErrorCode));
  end;
end;

procedure TatDBTablesLibrary.__GetTDBErrorSubCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBError(CurrentObject).SubCode));
  end;
end;

procedure TatDBTablesLibrary.__GetTDBErrorMessage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDBError(CurrentObject).Message);
  end;
end;

procedure TatDBTablesLibrary.__GetTDBErrorNativeError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBError(CurrentObject).NativeError));
  end;
end;

procedure TatDBTablesLibrary.__TBDECallbackDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBDECallback(CurrentObject).Destroy;
  end;
end;

procedure TatDBTablesLibrary.__TSessionListCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSessionListClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TSessionListDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSessionList(CurrentObject).Destroy;
  end;
end;

procedure TatDBTablesLibrary.__TSessionListFindSession(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSessionList(CurrentObject).FindSession(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TSessionListGetSessionNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSessionList(CurrentObject).GetSessionNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBTablesLibrary.__TSessionListOpenSession(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSessionList(CurrentObject).OpenSession(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__GetTSessionListCurrentSession(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSessionList(CurrentObject).CurrentSession));
  end;
end;

procedure TatDBTablesLibrary.__SetTSessionListCurrentSession(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSessionList(CurrentObject).CurrentSession:=TSession(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBTablesLibrary.__GetTSessionListCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSessionList(CurrentObject).Count));
  end;
end;

procedure TatDBTablesLibrary.__GetTSessionListSessions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSessionList(CurrentObject).Sessions[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBTablesLibrary.__GetTSessionListList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSessionList(CurrentObject).List[GetArrayIndex(0)]));
  end;
end;

procedure TatDBTablesLibrary.__TSessionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSessionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TSessionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).Destroy;
  end;
end;

procedure TatDBTablesLibrary.__TSessionAddAlias(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).AddAlias(GetInputArg(0),GetInputArg(1),TStrings(Integer(GetInputArg(2))));
  end;
end;

procedure TatDBTablesLibrary.__TSessionAddDriver(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).AddDriver(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatDBTablesLibrary.__TSessionAddStandardAlias(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).AddStandardAlias(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatDBTablesLibrary.__TSessionAddPassword(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).AddPassword(GetInputArg(0));
  end;
end;

procedure TatDBTablesLibrary.__TSessionClose(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).Close;
  end;
end;

procedure TatDBTablesLibrary.__TSessionCloseDatabase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).CloseDatabase(TDatabase(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBTablesLibrary.__TSessionDeleteAlias(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).DeleteAlias(GetInputArg(0));
  end;
end;

procedure TatDBTablesLibrary.__TSessionDeleteDriver(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).DeleteDriver(GetInputArg(0));
  end;
end;

procedure TatDBTablesLibrary.__TSessionDropConnections(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).DropConnections;
  end;
end;

procedure TatDBTablesLibrary.__TSessionFindDatabase(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSession(CurrentObject).FindDatabase(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TSessionGetAliasNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).GetAliasNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBTablesLibrary.__TSessionGetAliasParams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).GetAliasParams(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatDBTablesLibrary.__TSessionGetAliasDriverName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TSession(CurrentObject).GetAliasDriverName(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TSessionGetConfigParams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).GetConfigParams(GetInputArg(0),GetInputArg(1),TStrings(Integer(GetInputArg(2))));
  end;
end;

procedure TatDBTablesLibrary.__TSessionGetDatabaseNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).GetDatabaseNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBTablesLibrary.__TSessionGetDriverNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).GetDriverNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBTablesLibrary.__TSessionGetDriverParams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).GetDriverParams(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatDBTablesLibrary.__TSessionGetFieldNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).GetFieldNames(GetInputArg(0),GetInputArg(1),TStrings(Integer(GetInputArg(2))));
  end;
end;

procedure TatDBTablesLibrary.__TSessionGetPassword(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TSession(CurrentObject).GetPassword;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TSessionGetTableNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).GetTableNames(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3),TStrings(Integer(GetInputArg(4))));
  end;
end;

procedure TatDBTablesLibrary.__TSessionGetStoredProcNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).GetStoredProcNames(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatDBTablesLibrary.__TSessionIsAlias(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TSession(CurrentObject).IsAlias(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TSessionModifyAlias(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).ModifyAlias(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatDBTablesLibrary.__TSessionModifyDriver(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).ModifyDriver(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatDBTablesLibrary.__TSessionOpen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).Open;
  end;
end;

procedure TatDBTablesLibrary.__TSessionOpenDatabase(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSession(CurrentObject).OpenDatabase(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TSessionRemoveAllPasswords(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).RemoveAllPasswords;
  end;
end;

procedure TatDBTablesLibrary.__TSessionRemovePassword(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).RemovePassword(GetInputArg(0));
  end;
end;

procedure TatDBTablesLibrary.__TSessionSaveConfigFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSession(CurrentObject).SaveConfigFile;
  end;
end;

procedure TatDBTablesLibrary.__GetTSessionConfigMode(AMachine: TatVirtualMachine);
var
PropValueSet: TConfigMode;
begin
  with AMachine do
  begin
    PropValueSet := TSession(CurrentObject).ConfigMode;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatDBTablesLibrary.__SetTSessionConfigMode(AMachine: TatVirtualMachine);
  var
  TempVar: TConfigMode;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TSession(CurrentObject).ConfigMode:=TempVar;
  end;
end;

procedure TatDBTablesLibrary.__GetTSessionDatabaseCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSession(CurrentObject).DatabaseCount));
  end;
end;

procedure TatDBTablesLibrary.__GetTSessionDatabases(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSession(CurrentObject).Databases[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBTablesLibrary.__GetTSessionTraceFlags(AMachine: TatVirtualMachine);
var
PropValueSet: TTraceFlags;
begin
  with AMachine do
  begin
    PropValueSet := TSession(CurrentObject).TraceFlags;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatDBTablesLibrary.__SetTSessionTraceFlags(AMachine: TatVirtualMachine);
  var
  TempVar: TTraceFlags;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TSession(CurrentObject).TraceFlags:=TempVar;
  end;
end;

procedure TatDBTablesLibrary.__TParamListCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TParamListClass(CurrentClass.ClassRef).Create(TStrings(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TParamListDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParamList(CurrentObject).Destroy;
  end;
end;

procedure TatDBTablesLibrary.__GetTParamListBuffer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(string(TParamList(CurrentObject).Buffer));
  end;
end;

procedure TatDBTablesLibrary.__GetTParamListFieldCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TParamList(CurrentObject).FieldCount));
  end;
end;

procedure TatDBTablesLibrary.__TDatabaseCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDatabaseClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TDatabaseDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDatabase(CurrentObject).Destroy;
  end;
end;

procedure TatDBTablesLibrary.__TDatabaseCloseDataSets(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDatabase(CurrentObject).CloseDataSets;
  end;
end;

procedure TatDBTablesLibrary.__TDatabaseCommit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDatabase(CurrentObject).Commit;
  end;
end;

procedure TatDBTablesLibrary.__TDatabaseFlushSchemaCache(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDatabase(CurrentObject).FlushSchemaCache(GetInputArg(0));
  end;
end;

procedure TatDBTablesLibrary.__TDatabaseGetFieldNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDatabase(CurrentObject).GetFieldNames(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatDBTablesLibrary.__TDatabaseGetTableNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      1: TDatabase(CurrentObject).GetTableNames(TStrings(Integer(GetInputArg(0))));
      2: TDatabase(CurrentObject).GetTableNames(TStrings(Integer(GetInputArg(0))),GetInputArg(1));
    end;
  end;
end;

procedure TatDBTablesLibrary.__TDatabaseRollback(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDatabase(CurrentObject).Rollback;
  end;
end;

procedure TatDBTablesLibrary.__TDatabaseStartTransaction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDatabase(CurrentObject).StartTransaction;
  end;
end;

procedure TatDBTablesLibrary.__TDatabaseValidateName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDatabase(CurrentObject).ValidateName(GetInputArg(0));
  end;
end;

procedure TatDBTablesLibrary.__GetTDatabaseDataSets(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDatabase(CurrentObject).DataSets[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBTablesLibrary.__GetTDatabaseDirectory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDatabase(CurrentObject).Directory);
  end;
end;

procedure TatDBTablesLibrary.__SetTDatabaseDirectory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDatabase(CurrentObject).Directory:=GetInputArg(0);
  end;
end;

procedure TatDBTablesLibrary.__GetTDatabaseIsSQLBased(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDatabase(CurrentObject).IsSQLBased);
  end;
end;

procedure TatDBTablesLibrary.__GetTDatabaseInTransaction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDatabase(CurrentObject).InTransaction);
  end;
end;

procedure TatDBTablesLibrary.__GetTDatabaseSession(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDatabase(CurrentObject).Session));
  end;
end;

procedure TatDBTablesLibrary.__GetTDatabaseTemporary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDatabase(CurrentObject).Temporary);
  end;
end;

procedure TatDBTablesLibrary.__SetTDatabaseTemporary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDatabase(CurrentObject).Temporary:=GetInputArg(0);
  end;
end;

procedure TatDBTablesLibrary.__GetTDatabaseSessionAlias(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDatabase(CurrentObject).SessionAlias);
  end;
end;

procedure TatDBTablesLibrary.__GetTDatabaseTraceFlags(AMachine: TatVirtualMachine);
var
PropValueSet: TTraceFlags;
begin
  with AMachine do
  begin
    PropValueSet := TDatabase(CurrentObject).TraceFlags;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatDBTablesLibrary.__SetTDatabaseTraceFlags(AMachine: TatVirtualMachine);
  var
  TempVar: TTraceFlags;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TDatabase(CurrentObject).TraceFlags:=TempVar;
  end;
end;

procedure TatDBTablesLibrary.__TDataSetUpdateObjectApply(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetUpdateObject(CurrentObject).Apply(GetInputArg(0));
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBDEDataSetClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBDEDataSet(CurrentObject).Destroy;
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetApplyUpdates(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBDEDataSet(CurrentObject).ApplyUpdates;
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetBookmarkValid(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TBDEDataSet(CurrentObject).BookmarkValid(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetCancel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBDEDataSet(CurrentObject).Cancel;
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetCancelUpdates(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBDEDataSet(CurrentObject).CancelUpdates;
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetCompareBookmarks(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBDEDataSet(CurrentObject).CompareBookmarks(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetCommitUpdates(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBDEDataSet(CurrentObject).CommitUpdates;
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetConstraintsDisabled(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TBDEDataSet(CurrentObject).ConstraintsDisabled;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetCreateBlobStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBDEDataSet(CurrentObject).CreateBlobStream(TField(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetDisableConstraints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBDEDataSet(CurrentObject).DisableConstraints;
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetEnableConstraints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBDEDataSet(CurrentObject).EnableConstraints;
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetFetchAll(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBDEDataSet(CurrentObject).FetchAll;
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetFlushBuffers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBDEDataSet(CurrentObject).FlushBuffers;
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetGetBlobFieldData(AMachine: TatVirtualMachine);
  var
  Param1: TBlobByteData;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(TBDEDataSet(CurrentObject).GetBlobFieldData(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetGetIndexInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBDEDataSet(CurrentObject).GetIndexInfo;
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetLocate(AMachine: TatVirtualMachine);
  var
  Param2: TLocateOptions;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := TBDEDataSet(CurrentObject).Locate(GetInputArg(0),GetInputArg(1),Param2);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetLookup(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TBDEDataSet(CurrentObject).Lookup(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetIsSequenced(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TBDEDataSet(CurrentObject).IsSequenced;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetPost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBDEDataSet(CurrentObject).Post;
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetRevertRecord(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBDEDataSet(CurrentObject).RevertRecord;
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetUpdateStatus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TBDEDataSet(CurrentObject).UpdateStatus;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TBDEDataSetTranslate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBDEDataSet(CurrentObject).Translate(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__GetTBDEDataSetCacheBlobs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TBDEDataSet(CurrentObject).CacheBlobs);
  end;
end;

procedure TatDBTablesLibrary.__SetTBDEDataSetCacheBlobs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBDEDataSet(CurrentObject).CacheBlobs:=GetInputArg(0);
  end;
end;

procedure TatDBTablesLibrary.__GetTBDEDataSetExpIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TBDEDataSet(CurrentObject).ExpIndex);
  end;
end;

procedure TatDBTablesLibrary.__GetTBDEDataSetKeySize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TBDEDataSet(CurrentObject).KeySize));
  end;
end;

procedure TatDBTablesLibrary.__GetTBDEDataSetUpdateObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TBDEDataSet(CurrentObject).UpdateObject));
  end;
end;

procedure TatDBTablesLibrary.__SetTBDEDataSetUpdateObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBDEDataSet(CurrentObject).UpdateObject:=TDataSetUpdateObject(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBTablesLibrary.__GetTBDEDataSetUpdatesPending(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TBDEDataSet(CurrentObject).UpdatesPending);
  end;
end;

procedure TatDBTablesLibrary.__GetTBDEDataSetUpdateRecordTypes(AMachine: TatVirtualMachine);
var
PropValueSet: TUpdateRecordTypes;
begin
  with AMachine do
  begin
    PropValueSet := TBDEDataSet(CurrentObject).UpdateRecordTypes;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatDBTablesLibrary.__SetTBDEDataSetUpdateRecordTypes(AMachine: TatVirtualMachine);
  var
  TempVar: TUpdateRecordTypes;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TBDEDataSet(CurrentObject).UpdateRecordTypes:=TempVar;
  end;
end;

procedure TatDBTablesLibrary.__TNestedTableCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TNestedTableClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TDBDataSetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBDataSetClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TDBDataSetCheckOpen(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBDataSet(CurrentObject).CheckOpen(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TDBDataSetCloseDatabase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBDataSet(CurrentObject).CloseDatabase(TDatabase(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBTablesLibrary.__TDBDataSetOpenDatabase(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBDataSet(CurrentObject).OpenDatabase);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__GetTDBDataSetDatabase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBDataSet(CurrentObject).Database));
  end;
end;

procedure TatDBTablesLibrary.__GetTDBDataSetDBSession(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBDataSet(CurrentObject).DBSession));
  end;
end;

procedure TatDBTablesLibrary.__TIndexFilesCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIndexFilesClass(CurrentClass.ClassRef).Create(TTable(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TIndexFilesAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIndexFiles(CurrentObject).Add(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TIndexFilesClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIndexFiles(CurrentObject).Clear;
  end;
end;

procedure TatDBTablesLibrary.__TIndexFilesDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIndexFiles(CurrentObject).Delete(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatDBTablesLibrary.__TIndexFilesInsert(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIndexFiles(CurrentObject).Insert(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatDBTablesLibrary.__TTableCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTableClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TTableDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).Destroy;
  end;
end;

procedure TatDBTablesLibrary.__TTableBatchMove(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTable(CurrentObject).BatchMove(TBDEDataSet(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TTableAddIndex(AMachine: TatVirtualMachine);
  var
  Param2: TIndexOptions;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
    Case InputArgCount of
      3: TTable(CurrentObject).AddIndex(GetInputArg(0),GetInputArg(1),Param2);
      4: TTable(CurrentObject).AddIndex(GetInputArg(0),GetInputArg(1),Param2,GetInputArg(3));
    end;
  end;
end;

procedure TatDBTablesLibrary.__TTableApplyRange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).ApplyRange;
  end;
end;

procedure TatDBTablesLibrary.__TTableCancelRange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).CancelRange;
  end;
end;

procedure TatDBTablesLibrary.__TTableCloseIndexFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).CloseIndexFile(GetInputArg(0));
  end;
end;

procedure TatDBTablesLibrary.__TTableCreateTable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).CreateTable;
  end;
end;

procedure TatDBTablesLibrary.__TTableDeleteIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).DeleteIndex(GetInputArg(0));
  end;
end;

procedure TatDBTablesLibrary.__TTableDeleteTable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).DeleteTable;
  end;
end;

procedure TatDBTablesLibrary.__TTableEditKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).EditKey;
  end;
end;

procedure TatDBTablesLibrary.__TTableEditRangeEnd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).EditRangeEnd;
  end;
end;

procedure TatDBTablesLibrary.__TTableEditRangeStart(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).EditRangeStart;
  end;
end;

procedure TatDBTablesLibrary.__TTableEmptyTable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).EmptyTable;
  end;
end;

procedure TatDBTablesLibrary.__TTableGetDetailLinkFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).GetDetailLinkFields(TList(Integer(GetInputArg(0))),TList(Integer(GetInputArg(1))));
  end;
end;

procedure TatDBTablesLibrary.__TTableGetIndexNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).GetIndexNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBTablesLibrary.__TTableGotoCurrent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).GotoCurrent(TTable(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBTablesLibrary.__TTableGotoKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TTable(CurrentObject).GotoKey;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TTableGotoNearest(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).GotoNearest;
  end;
end;

procedure TatDBTablesLibrary.__TTableLockTable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).LockTable(GetInputArg(0));
  end;
end;

procedure TatDBTablesLibrary.__TTableOpenIndexFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).OpenIndexFile(GetInputArg(0));
  end;
end;

procedure TatDBTablesLibrary.__TTableRenameTable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).RenameTable(GetInputArg(0));
  end;
end;

procedure TatDBTablesLibrary.__TTableSetKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).SetKey;
  end;
end;

procedure TatDBTablesLibrary.__TTableSetRangeEnd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).SetRangeEnd;
  end;
end;

procedure TatDBTablesLibrary.__TTableSetRangeStart(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).SetRangeStart;
  end;
end;

procedure TatDBTablesLibrary.__TTableUnlockTable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).UnlockTable(GetInputArg(0));
  end;
end;

procedure TatDBTablesLibrary.__GetTTableExists(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTable(CurrentObject).Exists);
  end;
end;

procedure TatDBTablesLibrary.__GetTTableIndexFieldCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTable(CurrentObject).IndexFieldCount));
  end;
end;

procedure TatDBTablesLibrary.__GetTTableIndexFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTable(CurrentObject).IndexFields[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBTablesLibrary.__SetTTableIndexFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).IndexFields[VarToInteger(GetArrayIndex(0))]:=TField(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBTablesLibrary.__GetTTableKeyExclusive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTable(CurrentObject).KeyExclusive);
  end;
end;

procedure TatDBTablesLibrary.__SetTTableKeyExclusive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).KeyExclusive:=GetInputArg(0);
  end;
end;

procedure TatDBTablesLibrary.__GetTTableKeyFieldCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTable(CurrentObject).KeyFieldCount));
  end;
end;

procedure TatDBTablesLibrary.__SetTTableKeyFieldCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).KeyFieldCount:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBTablesLibrary.__GetTTableTableLevel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTable(CurrentObject).TableLevel));
  end;
end;

procedure TatDBTablesLibrary.__SetTTableTableLevel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTable(CurrentObject).TableLevel:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBTablesLibrary.__TBatchMoveCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBatchMoveClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TBatchMoveDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBatchMove(CurrentObject).Destroy;
  end;
end;

procedure TatDBTablesLibrary.__TBatchMoveExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBatchMove(CurrentObject).Execute;
  end;
end;

procedure TatDBTablesLibrary.__GetTBatchMoveChangedCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TBatchMove(CurrentObject).ChangedCount));
  end;
end;

procedure TatDBTablesLibrary.__GetTBatchMoveKeyViolCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TBatchMove(CurrentObject).KeyViolCount));
  end;
end;

procedure TatDBTablesLibrary.__GetTBatchMoveMovedCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TBatchMove(CurrentObject).MovedCount));
  end;
end;

procedure TatDBTablesLibrary.__GetTBatchMoveProblemCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TBatchMove(CurrentObject).ProblemCount));
  end;
end;

procedure TatDBTablesLibrary.__TStoredProcCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TStoredProcClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TStoredProcDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStoredProc(CurrentObject).Destroy;
  end;
end;

procedure TatDBTablesLibrary.__TStoredProcCopyParams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStoredProc(CurrentObject).CopyParams(TParams(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBTablesLibrary.__TStoredProcDescriptionsAvailable(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TStoredProc(CurrentObject).DescriptionsAvailable;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TStoredProcExecProc(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStoredProc(CurrentObject).ExecProc;
  end;
end;

procedure TatDBTablesLibrary.__TStoredProcParamByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TStoredProc(CurrentObject).ParamByName(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TStoredProcPrepare(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStoredProc(CurrentObject).Prepare;
  end;
end;

procedure TatDBTablesLibrary.__TStoredProcGetResults(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStoredProc(CurrentObject).GetResults;
  end;
end;

procedure TatDBTablesLibrary.__TStoredProcUnPrepare(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStoredProc(CurrentObject).UnPrepare;
  end;
end;

procedure TatDBTablesLibrary.__GetTStoredProcParamCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TStoredProc(CurrentObject).ParamCount));
  end;
end;

procedure TatDBTablesLibrary.__GetTStoredProcPrepared(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TStoredProc(CurrentObject).Prepared);
  end;
end;

procedure TatDBTablesLibrary.__SetTStoredProcPrepared(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStoredProc(CurrentObject).Prepared:=GetInputArg(0);
  end;
end;

procedure TatDBTablesLibrary.__TQueryCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TQueryClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TQueryDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TQuery(CurrentObject).Destroy;
  end;
end;

procedure TatDBTablesLibrary.__TQueryExecSQL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TQuery(CurrentObject).ExecSQL;
  end;
end;

procedure TatDBTablesLibrary.__TQueryGetDetailLinkFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TQuery(CurrentObject).GetDetailLinkFields(TList(Integer(GetInputArg(0))),TList(Integer(GetInputArg(1))));
  end;
end;

procedure TatDBTablesLibrary.__TQueryParamByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TQuery(CurrentObject).ParamByName(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TQueryPrepare(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TQuery(CurrentObject).Prepare;
  end;
end;

procedure TatDBTablesLibrary.__TQueryUnPrepare(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TQuery(CurrentObject).UnPrepare;
  end;
end;

procedure TatDBTablesLibrary.__GetTQueryPrepared(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TQuery(CurrentObject).Prepared);
  end;
end;

procedure TatDBTablesLibrary.__SetTQueryPrepared(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TQuery(CurrentObject).Prepared:=GetInputArg(0);
  end;
end;

procedure TatDBTablesLibrary.__GetTQueryParamCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TQuery(CurrentObject).ParamCount));
  end;
end;

procedure TatDBTablesLibrary.__GetTQueryLocal(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TQuery(CurrentObject).Local);
  end;
end;

procedure TatDBTablesLibrary.__GetTQueryText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TQuery(CurrentObject).Text);
  end;
end;

procedure TatDBTablesLibrary.__GetTQueryRowsAffected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TQuery(CurrentObject).RowsAffected));
  end;
end;

procedure TatDBTablesLibrary.__GetTQuerySQLBinary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(string(TQuery(CurrentObject).SQLBinary));
  end;
end;

procedure TatDBTablesLibrary.__SetTQuerySQLBinary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TQuery(CurrentObject).SQLBinary:=PAnsiChar(VarToStr(GetInputArg(0)));
  end;
end;

procedure TatDBTablesLibrary.__TUpdateSQLCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TUpdateSQLClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TUpdateSQLDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TUpdateSQL(CurrentObject).Destroy;
  end;
end;

procedure TatDBTablesLibrary.__TUpdateSQLApply(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TUpdateSQL(CurrentObject).Apply(GetInputArg(0));
  end;
end;

procedure TatDBTablesLibrary.__TUpdateSQLExecSQL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TUpdateSQL(CurrentObject).ExecSQL(GetInputArg(0));
  end;
end;

procedure TatDBTablesLibrary.__TUpdateSQLSetParams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TUpdateSQL(CurrentObject).SetParams(TDataSet(Integer(GetInputArg(0))),GetInputArg(1));
  end;
end;

procedure TatDBTablesLibrary.__GetTUpdateSQLDatabaseName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TUpdateSQL(CurrentObject).DatabaseName);
  end;
end;

procedure TatDBTablesLibrary.__SetTUpdateSQLDatabaseName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TUpdateSQL(CurrentObject).DatabaseName:=GetInputArg(0);
  end;
end;

procedure TatDBTablesLibrary.__GetTUpdateSQLQuery(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TUpdateSQL(CurrentObject).Query[GetArrayIndex(0)]));
  end;
end;

procedure TatDBTablesLibrary.__GetTUpdateSQLSQL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TUpdateSQL(CurrentObject).SQL[GetArrayIndex(0)]));
  end;
end;

procedure TatDBTablesLibrary.__SetTUpdateSQLSQL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TUpdateSQL(CurrentObject).SQL[GetArrayIndex(0)]:=TStrings(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBTablesLibrary.__GetTUpdateSQLSessionName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TUpdateSQL(CurrentObject).SessionName);
  end;
end;

procedure TatDBTablesLibrary.__SetTUpdateSQLSessionName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TUpdateSQL(CurrentObject).SessionName:=GetInputArg(0);
  end;
end;

procedure TatDBTablesLibrary.__TBlobStreamCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBlobStreamClass(CurrentClass.ClassRef).Create(TBlobField(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TBlobStreamDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBlobStream(CurrentObject).Destroy;
  end;
end;

procedure TatDBTablesLibrary.__TBlobStreamRead(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TBlobStream(CurrentObject).Read(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatDBTablesLibrary.__TBlobStreamWrite(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TBlobStream(CurrentObject).Write(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TBlobStreamSeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBlobStream(CurrentObject).Seek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBTablesLibrary.__TBlobStreamTruncate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBlobStream(CurrentObject).Truncate;
  end;
end;

procedure TatDBTablesDispatcher.__TPasswordEvent( Sender: TObject; var Continue: Boolean);
var
  ContinueTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TPasswordEvent(BeforeCall)(Sender,Continue);
    ContinueTemp := Continue;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ContinueTemp]);
    Continue := ContinueTemp;
    if AssignedMethod(AfterCall) then
      TPasswordEvent(AfterCall)(Sender,Continue);
  end;
end;

procedure TatDBTablesDispatcher.__TDatabaseNotifyEvent( DBEvent: TDatabaseEvent; const Param);
var
  DBEventTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TDatabaseNotifyEvent(BeforeCall)(DBEvent,Param);
    DBEventTemp := DBEvent;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [DBEventTemp,Variant(Param)]);
    if AssignedMethod(AfterCall) then
      TDatabaseNotifyEvent(AfterCall)(DBEvent,Param);
  end;
end;

procedure TatDBTablesDispatcher.__TDatabaseLoginEvent( Database: TDatabase;  LoginParams: TStrings);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TDatabaseLoginEvent(BeforeCall)(Database,LoginParams);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Database,LoginParams]);
    if AssignedMethod(AfterCall) then
      TDatabaseLoginEvent(AfterCall)(Database,LoginParams);
  end;
end;

procedure TatDBTablesLibrary.__DbiError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DBTables.DbiError(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatDBTablesLibrary.__Check(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DBTables.Check(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatDBTablesLibrary.__GetSession(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(DBTables.Session));
  end;
end;

procedure TatDBTablesLibrary.__SetSession(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DBTables.Session:=TSession(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBTablesLibrary.__GetSessions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(DBTables.Sessions));
  end;
end;

procedure TatDBTablesLibrary.__SetSessions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DBTables.Sessions:=TSessionList(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBTablesLibrary.Init;
begin
  With Scripter.DefineClass(EDBEngineError) do
  begin
    DefineMethod('Create',1,tkClass,EDBEngineError,__EDBEngineErrorCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__EDBEngineErrorDestroy,false,0);
    DefineProp('ErrorCount',tkInteger,__GetEDBEngineErrorErrorCount,nil,nil,false,0);
    DefineProp('Errors',tkClass,__GetEDBEngineErrorErrors,nil,TDBError,false,1);
  end;
  With Scripter.DefineClass(ENoResultSet) do
  begin
  end;
  With Scripter.DefineClass(TDBError) do
  begin
    DefineMethod('Create',4,tkClass,TDBError,__TDBErrorCreate,true,0);
    DefineProp('Category',tkInteger,__GetTDBErrorCategory,nil,nil,false,0);
    DefineProp('ErrorCode',tkInteger,__GetTDBErrorErrorCode,nil,nil,false,0);
    DefineProp('SubCode',tkInteger,__GetTDBErrorSubCode,nil,nil,false,0);
    DefineProp('Message',tkVariant,__GetTDBErrorMessage,nil,nil,false,0);
    DefineProp('NativeError',tkInteger,__GetTDBErrorNativeError,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TBDECallback) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TBDECallbackDestroy,false,0);
  end;
  With Scripter.DefineClass(TSessionList) do
  begin
    DefineMethod('Create',0,tkClass,TSessionList,__TSessionListCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TSessionListDestroy,false,0);
    DefineMethod('FindSession',1,tkClass,TSession,__TSessionListFindSession,false,0);
    DefineMethod('GetSessionNames',1,tkNone,nil,__TSessionListGetSessionNames,false,0);
    DefineMethod('OpenSession',1,tkClass,TSession,__TSessionListOpenSession,false,0);
    DefineProp('CurrentSession',tkClass,__GetTSessionListCurrentSession,__SetTSessionListCurrentSession,TSession,false,0);
    DefineProp('Count',tkInteger,__GetTSessionListCount,nil,nil,false,0);
    DefaultProperty := DefineProp('Sessions',tkClass,__GetTSessionListSessions,nil,TSession,false,1);
    DefineProp('List',tkClass,__GetTSessionListList,nil,TSession,false,1);
  end;
  With Scripter.DefineClass(TSession) do
  begin
    DefineMethod('Create',1,tkClass,TSession,__TSessionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TSessionDestroy,false,0);
    DefineMethod('AddAlias',3,tkNone,nil,__TSessionAddAlias,false,0);
    DefineMethod('AddDriver',2,tkNone,nil,__TSessionAddDriver,false,0);
    DefineMethod('AddStandardAlias',3,tkNone,nil,__TSessionAddStandardAlias,false,0);
    DefineMethod('AddPassword',1,tkNone,nil,__TSessionAddPassword,false,0);
    DefineMethod('Close',0,tkNone,nil,__TSessionClose,false,0);
    DefineMethod('CloseDatabase',1,tkNone,nil,__TSessionCloseDatabase,false,0);
    DefineMethod('DeleteAlias',1,tkNone,nil,__TSessionDeleteAlias,false,0);
    DefineMethod('DeleteDriver',1,tkNone,nil,__TSessionDeleteDriver,false,0);
    DefineMethod('DropConnections',0,tkNone,nil,__TSessionDropConnections,false,0);
    DefineMethod('FindDatabase',1,tkClass,TDatabase,__TSessionFindDatabase,false,0);
    DefineMethod('GetAliasNames',1,tkNone,nil,__TSessionGetAliasNames,false,0);
    DefineMethod('GetAliasParams',2,tkNone,nil,__TSessionGetAliasParams,false,0);
    DefineMethod('GetAliasDriverName',1,tkVariant,nil,__TSessionGetAliasDriverName,false,0);
    DefineMethod('GetConfigParams',3,tkNone,nil,__TSessionGetConfigParams,false,0);
    DefineMethod('GetDatabaseNames',1,tkNone,nil,__TSessionGetDatabaseNames,false,0);
    DefineMethod('GetDriverNames',1,tkNone,nil,__TSessionGetDriverNames,false,0);
    DefineMethod('GetDriverParams',2,tkNone,nil,__TSessionGetDriverParams,false,0);
    DefineMethod('GetFieldNames',3,tkNone,nil,__TSessionGetFieldNames,false,0);
    DefineMethod('GetPassword',0,tkVariant,nil,__TSessionGetPassword,false,0);
    DefineMethod('GetTableNames',5,tkNone,nil,__TSessionGetTableNames,false,0);
    DefineMethod('GetStoredProcNames',2,tkNone,nil,__TSessionGetStoredProcNames,false,0);
    DefineMethod('IsAlias',1,tkVariant,nil,__TSessionIsAlias,false,0);
    DefineMethod('ModifyAlias',2,tkNone,nil,__TSessionModifyAlias,false,0);
    DefineMethod('ModifyDriver',2,tkNone,nil,__TSessionModifyDriver,false,0);
    DefineMethod('Open',0,tkNone,nil,__TSessionOpen,false,0);
    DefineMethod('OpenDatabase',1,tkClass,TDatabase,__TSessionOpenDatabase,false,0);
    DefineMethod('RemoveAllPasswords',0,tkNone,nil,__TSessionRemoveAllPasswords,false,0);
    DefineMethod('RemovePassword',1,tkNone,nil,__TSessionRemovePassword,false,0);
    DefineMethod('SaveConfigFile',0,tkNone,nil,__TSessionSaveConfigFile,false,0);
    DefineProp('ConfigMode',tkInteger,__GetTSessionConfigMode,__SetTSessionConfigMode,nil,false,0);
    DefineProp('DatabaseCount',tkInteger,__GetTSessionDatabaseCount,nil,nil,false,0);
    DefineProp('Databases',tkClass,__GetTSessionDatabases,nil,TDatabase,false,1);
    DefineProp('TraceFlags',tkInteger,__GetTSessionTraceFlags,__SetTSessionTraceFlags,nil,false,0);
  end;
  With Scripter.DefineClass(TParamList) do
  begin
    DefineMethod('Create',1,tkClass,TParamList,__TParamListCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TParamListDestroy,false,0);
    DefineProp('Buffer',tkVariant,__GetTParamListBuffer,nil,nil,false,0);
    DefineProp('FieldCount',tkInteger,__GetTParamListFieldCount,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TDatabase) do
  begin
    DefineMethod('Create',1,tkClass,TDatabase,__TDatabaseCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDatabaseDestroy,false,0);
    DefineMethod('CloseDataSets',0,tkNone,nil,__TDatabaseCloseDataSets,false,0);
    DefineMethod('Commit',0,tkNone,nil,__TDatabaseCommit,false,0);
    DefineMethod('FlushSchemaCache',1,tkNone,nil,__TDatabaseFlushSchemaCache,false,0);
    DefineMethod('GetFieldNames',2,tkNone,nil,__TDatabaseGetFieldNames,false,0);
    DefineMethod('GetTableNames',2,tkNone,nil,__TDatabaseGetTableNames,false,1);
    DefineMethod('Rollback',0,tkNone,nil,__TDatabaseRollback,false,0);
    DefineMethod('StartTransaction',0,tkNone,nil,__TDatabaseStartTransaction,false,0);
    DefineMethod('ValidateName',1,tkNone,nil,__TDatabaseValidateName,false,0);
    DefineProp('DataSets',tkClass,__GetTDatabaseDataSets,nil,TDBDataSet,false,1);
    DefineProp('Directory',tkVariant,__GetTDatabaseDirectory,__SetTDatabaseDirectory,nil,false,0);
    DefineProp('IsSQLBased',tkVariant,__GetTDatabaseIsSQLBased,nil,nil,false,0);
    DefineProp('InTransaction',tkVariant,__GetTDatabaseInTransaction,nil,nil,false,0);
    DefineProp('Session',tkClass,__GetTDatabaseSession,nil,TSession,false,0);
    DefineProp('Temporary',tkVariant,__GetTDatabaseTemporary,__SetTDatabaseTemporary,nil,false,0);
    DefineProp('SessionAlias',tkVariant,__GetTDatabaseSessionAlias,nil,nil,false,0);
    DefineProp('TraceFlags',tkInteger,__GetTDatabaseTraceFlags,__SetTDatabaseTraceFlags,nil,false,0);
  end;
  With Scripter.DefineClass(TDataSetUpdateObject) do
  begin
    DefineMethod('Apply',1,tkNone,nil,__TDataSetUpdateObjectApply,false,0);
  end;
  With Scripter.DefineClass(TSQLUpdateObject) do
  begin
  end;
  With Scripter.DefineClass(TBDEDataSet) do
  begin
    DefineMethod('Create',1,tkClass,TBDEDataSet,__TBDEDataSetCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TBDEDataSetDestroy,false,0);
    DefineMethod('ApplyUpdates',0,tkNone,nil,__TBDEDataSetApplyUpdates,false,0);
    DefineMethod('BookmarkValid',1,tkVariant,nil,__TBDEDataSetBookmarkValid,false,0);
    DefineMethod('Cancel',0,tkNone,nil,__TBDEDataSetCancel,false,0);
    DefineMethod('CancelUpdates',0,tkNone,nil,__TBDEDataSetCancelUpdates,false,0);
    DefineMethod('CompareBookmarks',2,tkInteger,nil,__TBDEDataSetCompareBookmarks,false,0);
    DefineMethod('CommitUpdates',0,tkNone,nil,__TBDEDataSetCommitUpdates,false,0);
    DefineMethod('ConstraintsDisabled',0,tkVariant,nil,__TBDEDataSetConstraintsDisabled,false,0);
    DefineMethod('CreateBlobStream',2,tkClass,TStream,__TBDEDataSetCreateBlobStream,false,0);
    DefineMethod('DisableConstraints',0,tkNone,nil,__TBDEDataSetDisableConstraints,false,0);
    DefineMethod('EnableConstraints',0,tkNone,nil,__TBDEDataSetEnableConstraints,false,0);
    DefineMethod('FetchAll',0,tkNone,nil,__TBDEDataSetFetchAll,false,0);
    DefineMethod('FlushBuffers',0,tkNone,nil,__TBDEDataSetFlushBuffers,false,0);
    DefineMethod('GetBlobFieldData',2,tkInteger,nil,__TBDEDataSetGetBlobFieldData,false,0).SetVarArgs([1]);
    DefineMethod('GetIndexInfo',0,tkNone,nil,__TBDEDataSetGetIndexInfo,false,0);
    DefineMethod('Locate',3,tkVariant,nil,__TBDEDataSetLocate,false,0);
    DefineMethod('Lookup',3,tkVariant,nil,__TBDEDataSetLookup,false,0);
    DefineMethod('IsSequenced',0,tkVariant,nil,__TBDEDataSetIsSequenced,false,0);
    DefineMethod('Post',0,tkNone,nil,__TBDEDataSetPost,false,0);
    DefineMethod('RevertRecord',0,tkNone,nil,__TBDEDataSetRevertRecord,false,0);
    DefineMethod('UpdateStatus',0,tkEnumeration,nil,__TBDEDataSetUpdateStatus,false,0);
    DefineMethod('Translate',3,tkInteger,nil,__TBDEDataSetTranslate,false,0);
    DefineProp('CacheBlobs',tkVariant,__GetTBDEDataSetCacheBlobs,__SetTBDEDataSetCacheBlobs,nil,false,0);
    DefineProp('ExpIndex',tkVariant,__GetTBDEDataSetExpIndex,nil,nil,false,0);
    DefineProp('KeySize',tkInteger,__GetTBDEDataSetKeySize,nil,nil,false,0);
    DefineProp('UpdateObject',tkClass,__GetTBDEDataSetUpdateObject,__SetTBDEDataSetUpdateObject,TDataSetUpdateObject,false,0);
    DefineProp('UpdatesPending',tkVariant,__GetTBDEDataSetUpdatesPending,nil,nil,false,0);
    DefineProp('UpdateRecordTypes',tkInteger,__GetTBDEDataSetUpdateRecordTypes,__SetTBDEDataSetUpdateRecordTypes,nil,false,0);
  end;
  With Scripter.DefineClass(TNestedTable) do
  begin
    DefineMethod('Create',1,tkClass,TNestedTable,__TNestedTableCreate,true,0);
  end;
  With Scripter.DefineClass(TDBDataSet) do
  begin
    DefineMethod('Create',1,tkClass,TDBDataSet,__TDBDataSetCreate,true,0);
    DefineMethod('CheckOpen',1,tkVariant,nil,__TDBDataSetCheckOpen,false,0);
    DefineMethod('CloseDatabase',1,tkNone,nil,__TDBDataSetCloseDatabase,false,0);
    DefineMethod('OpenDatabase',0,tkClass,TDatabase,__TDBDataSetOpenDatabase,false,0);
    DefineProp('Database',tkClass,__GetTDBDataSetDatabase,nil,TDatabase,false,0);
    DefineProp('DBSession',tkClass,__GetTDBDataSetDBSession,nil,TSession,false,0);
  end;
  With Scripter.DefineClass(TIndexFiles) do
  begin
    DefineMethod('Create',1,tkClass,TIndexFiles,__TIndexFilesCreate,true,0);
    DefineMethod('Add',1,tkInteger,nil,__TIndexFilesAdd,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TIndexFilesClear,false,0);
    DefineMethod('Delete',1,tkNone,nil,__TIndexFilesDelete,false,0);
    DefineMethod('Insert',2,tkNone,nil,__TIndexFilesInsert,false,0);
  end;
  With Scripter.DefineClass(TTable) do
  begin
    DefineMethod('Create',1,tkClass,TTable,__TTableCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TTableDestroy,false,0);
    DefineMethod('BatchMove',2,tkInteger,nil,__TTableBatchMove,false,0);
    DefineMethod('AddIndex',4,tkNone,nil,__TTableAddIndex,false,1);
    DefineMethod('ApplyRange',0,tkNone,nil,__TTableApplyRange,false,0);
    DefineMethod('CancelRange',0,tkNone,nil,__TTableCancelRange,false,0);
    DefineMethod('CloseIndexFile',1,tkNone,nil,__TTableCloseIndexFile,false,0);
    DefineMethod('CreateTable',0,tkNone,nil,__TTableCreateTable,false,0);
    DefineMethod('DeleteIndex',1,tkNone,nil,__TTableDeleteIndex,false,0);
    DefineMethod('DeleteTable',0,tkNone,nil,__TTableDeleteTable,false,0);
    DefineMethod('EditKey',0,tkNone,nil,__TTableEditKey,false,0);
    DefineMethod('EditRangeEnd',0,tkNone,nil,__TTableEditRangeEnd,false,0);
    DefineMethod('EditRangeStart',0,tkNone,nil,__TTableEditRangeStart,false,0);
    DefineMethod('EmptyTable',0,tkNone,nil,__TTableEmptyTable,false,0);
    DefineMethod('GetDetailLinkFields',2,tkNone,nil,__TTableGetDetailLinkFields,false,0);
    DefineMethod('GetIndexNames',1,tkNone,nil,__TTableGetIndexNames,false,0);
    DefineMethod('GotoCurrent',1,tkNone,nil,__TTableGotoCurrent,false,0);
    DefineMethod('GotoKey',0,tkVariant,nil,__TTableGotoKey,false,0);
    DefineMethod('GotoNearest',0,tkNone,nil,__TTableGotoNearest,false,0);
    DefineMethod('LockTable',1,tkNone,nil,__TTableLockTable,false,0);
    DefineMethod('OpenIndexFile',1,tkNone,nil,__TTableOpenIndexFile,false,0);
    DefineMethod('RenameTable',1,tkNone,nil,__TTableRenameTable,false,0);
    DefineMethod('SetKey',0,tkNone,nil,__TTableSetKey,false,0);
    DefineMethod('SetRangeEnd',0,tkNone,nil,__TTableSetRangeEnd,false,0);
    DefineMethod('SetRangeStart',0,tkNone,nil,__TTableSetRangeStart,false,0);
    DefineMethod('UnlockTable',1,tkNone,nil,__TTableUnlockTable,false,0);
    DefineProp('Exists',tkVariant,__GetTTableExists,nil,nil,false,0);
    DefineProp('IndexFieldCount',tkInteger,__GetTTableIndexFieldCount,nil,nil,false,0);
    DefineProp('IndexFields',tkClass,__GetTTableIndexFields,__SetTTableIndexFields,TField,false,1);
    DefineProp('KeyExclusive',tkVariant,__GetTTableKeyExclusive,__SetTTableKeyExclusive,nil,false,0);
    DefineProp('KeyFieldCount',tkInteger,__GetTTableKeyFieldCount,__SetTTableKeyFieldCount,nil,false,0);
    DefineProp('TableLevel',tkInteger,__GetTTableTableLevel,__SetTTableTableLevel,nil,false,0);
  end;
  With Scripter.DefineClass(TBatchMove) do
  begin
    DefineMethod('Create',1,tkClass,TBatchMove,__TBatchMoveCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TBatchMoveDestroy,false,0);
    DefineMethod('Execute',0,tkNone,nil,__TBatchMoveExecute,false,0);
    DefineProp('ChangedCount',tkInteger,__GetTBatchMoveChangedCount,nil,nil,false,0);
    DefineProp('KeyViolCount',tkInteger,__GetTBatchMoveKeyViolCount,nil,nil,false,0);
    DefineProp('MovedCount',tkInteger,__GetTBatchMoveMovedCount,nil,nil,false,0);
    DefineProp('ProblemCount',tkInteger,__GetTBatchMoveProblemCount,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TStoredProc) do
  begin
    DefineMethod('Create',1,tkClass,TStoredProc,__TStoredProcCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TStoredProcDestroy,false,0);
    DefineMethod('CopyParams',1,tkNone,nil,__TStoredProcCopyParams,false,0);
    DefineMethod('DescriptionsAvailable',0,tkVariant,nil,__TStoredProcDescriptionsAvailable,false,0);
    DefineMethod('ExecProc',0,tkNone,nil,__TStoredProcExecProc,false,0);
    DefineMethod('ParamByName',1,tkClass,TParam,__TStoredProcParamByName,false,0);
    DefineMethod('Prepare',0,tkNone,nil,__TStoredProcPrepare,false,0);
    DefineMethod('GetResults',0,tkNone,nil,__TStoredProcGetResults,false,0);
    DefineMethod('UnPrepare',0,tkNone,nil,__TStoredProcUnPrepare,false,0);
    DefineProp('ParamCount',tkInteger,__GetTStoredProcParamCount,nil,nil,false,0);
    DefineProp('StmtHandle',tkVariant,nil,nil,nil,false,0);
    DefineProp('Prepared',tkVariant,__GetTStoredProcPrepared,__SetTStoredProcPrepared,nil,false,0);
  end;
  With Scripter.DefineClass(TQuery) do
  begin
    DefineMethod('Create',1,tkClass,TQuery,__TQueryCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TQueryDestroy,false,0);
    DefineMethod('ExecSQL',0,tkNone,nil,__TQueryExecSQL,false,0);
    DefineMethod('GetDetailLinkFields',2,tkNone,nil,__TQueryGetDetailLinkFields,false,0);
    DefineMethod('ParamByName',1,tkClass,TParam,__TQueryParamByName,false,0);
    DefineMethod('Prepare',0,tkNone,nil,__TQueryPrepare,false,0);
    DefineMethod('UnPrepare',0,tkNone,nil,__TQueryUnPrepare,false,0);
    DefineProp('Prepared',tkVariant,__GetTQueryPrepared,__SetTQueryPrepared,nil,false,0);
    DefineProp('ParamCount',tkInteger,__GetTQueryParamCount,nil,nil,false,0);
    DefineProp('Local',tkVariant,__GetTQueryLocal,nil,nil,false,0);
    DefineProp('StmtHandle',tkVariant,nil,nil,nil,false,0);
    DefineProp('Text',tkVariant,__GetTQueryText,nil,nil,false,0);
    DefineProp('RowsAffected',tkInteger,__GetTQueryRowsAffected,nil,nil,false,0);
    DefineProp('SQLBinary',tkVariant,__GetTQuerySQLBinary,__SetTQuerySQLBinary,nil,false,0);
  end;
  With Scripter.DefineClass(TUpdateSQL) do
  begin
    DefineMethod('Create',1,tkClass,TUpdateSQL,__TUpdateSQLCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TUpdateSQLDestroy,false,0);
    DefineMethod('Apply',1,tkNone,nil,__TUpdateSQLApply,false,0);
    DefineMethod('ExecSQL',1,tkNone,nil,__TUpdateSQLExecSQL,false,0);
    DefineMethod('SetParams',2,tkNone,nil,__TUpdateSQLSetParams,false,0);
    DefineProp('DatabaseName',tkVariant,__GetTUpdateSQLDatabaseName,__SetTUpdateSQLDatabaseName,nil,false,0);
    DefineProp('DataSet',tkVariant,nil,nil,nil,false,0);
    DefineProp('Query',tkClass,__GetTUpdateSQLQuery,nil,TQuery,false,1);
    DefineProp('SQL',tkClass,__GetTUpdateSQLSQL,__SetTUpdateSQLSQL,TStrings,false,1);
    DefineProp('SessionName',tkVariant,__GetTUpdateSQLSessionName,__SetTUpdateSQLSessionName,nil,false,0);
  end;
  With Scripter.DefineClass(TBlobStream) do
  begin
    DefineMethod('Create',2,tkClass,TBlobStream,__TBlobStreamCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TBlobStreamDestroy,false,0);
    DefineMethod('Read',2,tkInteger,nil,__TBlobStreamRead,false,0).SetVarArgs([0]);
    DefineMethod('Write',2,tkInteger,nil,__TBlobStreamWrite,false,0);
    DefineMethod('Seek',2,tkInteger,nil,__TBlobStreamSeek,false,0);
    DefineMethod('Truncate',0,tkNone,nil,__TBlobStreamTruncate,false,0);
  end;
  DefineEventAdapter(TypeInfo(TPasswordEvent), TatDBTablesDispatcher, @TatDBTablesDispatcher.__TPasswordEvent);
  DefineEventAdapter(TypeInfo(TDatabaseNotifyEvent), TatDBTablesDispatcher, @TatDBTablesDispatcher.__TDatabaseNotifyEvent);
  DefineEventAdapter(TypeInfo(TDatabaseLoginEvent), TatDBTablesDispatcher, @TatDBTablesDispatcher.__TDatabaseLoginEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('DbiError',1,tkNone,nil,__DbiError,false,0);
    DefineMethod('Check',1,tkNone,nil,__Check,false,0);
    DefineProp('Session',tkClass,__GetSession,__SetSession,TSession,false,0);
    DefineProp('Sessions',tkClass,__GetSessions,__SetSessions,TSessionList,false,0);
    AddConstant('cfmVirtual',cfmVirtual);
    AddConstant('cfmPersistent',cfmPersistent);
    AddConstant('cfmSession',cfmSession);
    AddConstant('dbOpen',dbOpen);
    AddConstant('dbClose',dbClose);
    AddConstant('dbAdd',dbAdd);
    AddConstant('dbRemove',dbRemove);
    AddConstant('dbAddAlias',dbAddAlias);
    AddConstant('dbDeleteAlias',dbDeleteAlias);
    AddConstant('dbAddDriver',dbAddDriver);
    AddConstant('dbDeleteDriver',dbDeleteDriver);
    AddConstant('tfQPrepare',tfQPrepare);
    AddConstant('tfQExecute',tfQExecute);
    AddConstant('tfError',tfError);
    AddConstant('tfStmt',tfStmt);
    AddConstant('tfConnect',tfConnect);
    AddConstant('tfTransact',tfTransact);
    AddConstant('tfBlob',tfBlob);
    AddConstant('tfMisc',tfMisc);
    AddConstant('tfVendor',tfVendor);
    AddConstant('tfDataIn',tfDataIn);
    AddConstant('tfDataOut',tfDataOut);
    AddConstant('tiDirtyRead',tiDirtyRead);
    AddConstant('tiReadCommitted',tiReadCommitted);
    AddConstant('tiRepeatableRead',tiRepeatableRead);
    AddConstant('rnDbase',rnDbase);
    AddConstant('rnParadox',rnParadox);
    AddConstant('rnNotSupported',rnNotSupported);
    AddConstant('batAppend',batAppend);
    AddConstant('batUpdate',batUpdate);
    AddConstant('batAppendUpdate',batAppendUpdate);
    AddConstant('batDelete',batDelete);
    AddConstant('batCopy',batCopy);
    AddConstant('ttDefault',ttDefault);
    AddConstant('ttParadox',ttParadox);
    AddConstant('ttDBase',ttDBase);
    AddConstant('ttFoxPro',ttFoxPro);
    AddConstant('ttASCII',ttASCII);
    AddConstant('ltReadLock',ltReadLock);
    AddConstant('ltWriteLock',ltWriteLock);
    AddConstant('pbByName',pbByName);
    AddConstant('pbByNumber',pbByNumber);
    AddConstant('smTraceBufSize',smTraceBufSize);
    AddConstant('dbfOpened',dbfOpened);
    AddConstant('dbfPrepared',dbfPrepared);
    AddConstant('dbfExecSQL',dbfExecSQL);
    AddConstant('dbfTable',dbfTable);
    AddConstant('dbfFieldList',dbfFieldList);
    AddConstant('dbfIndexList',dbfIndexList);
    AddConstant('dbfStoredProc',dbfStoredProc);
    AddConstant('dbfExecProc',dbfExecProc);
    AddConstant('dbfProcDesc',dbfProcDesc);
    AddConstant('dbfDatabase',dbfDatabase);
    AddConstant('dbfProvider',dbfProvider);
    AddConstant('cmVirtual',IntFromConstSet(cmVirtual));
    AddConstant('cmPersistent',IntFromConstSet(cmPersistent));
    AddConstant('cmSession',IntFromConstSet(cmSession));
    AddConstant('cmAll',IntFromConstSet(cmAll));
  end;
end;

class function TatDBTablesLibrary.LibraryName: string;
begin
  result := 'DBTables';
end;

initialization
  RegisterScripterLibrary(TatDBTablesLibrary, True);

{$WARNINGS ON}

end.

