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
  DBXpress,
  SqlTimSt,
  SqlExpr,
  ap_DBXpress,
  atScript;

{$WARNINGS OFF}

type
  TatSqlExprLibrary = class(TatScripterLibrary)
    procedure __TSQLBlobStreamCreate(AMachine: TatVirtualMachine);
    procedure __TSQLBlobStreamDestroy(AMachine: TatVirtualMachine);
    procedure __TSQLBlobStreamReadBlobData(AMachine: TatVirtualMachine);
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
    procedure __TSQLConnectionGetProcedureParams(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionGetTableNames(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionLoadParamsFromIniFile(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionRollback(AMachine: TatVirtualMachine);
    procedure __TSQLConnectionStartTransaction(AMachine: TatVirtualMachine);
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
    procedure __GetTSQLConnectionParamsLoaded(AMachine: TatVirtualMachine);
    procedure __SetTSQLConnectionParamsLoaded(AMachine: TatVirtualMachine);
    procedure __GetTSQLConnectionSQLHourGlass(AMachine: TatVirtualMachine);
    procedure __SetTSQLConnectionSQLHourGlass(AMachine: TatVirtualMachine);
    procedure __GetTSQLConnectionTransactionsSupported(AMachine: TatVirtualMachine);
    procedure __TSQLDataLinkCreate(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetCreate(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetCreateBlobStream(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetGetDetailLinkFields(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetGetKeyFieldNames(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetGetQuoteChar(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetParamByName(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetIsSequenced(AMachine: TatVirtualMachine);
    procedure __TCustomSQLDataSetSetSchemaInfo(AMachine: TatVirtualMachine);
    procedure __GetTCustomSQLDataSetIndexDefs(AMachine: TatVirtualMachine);
    procedure __SetTCustomSQLDataSetIndexDefs(AMachine: TatVirtualMachine);
    procedure __GetTCustomSQLDataSetPrepared(AMachine: TatVirtualMachine);
    procedure __SetTCustomSQLDataSetPrepared(AMachine: TatVirtualMachine);
    procedure __GetTCustomSQLDataSetDesignerData(AMachine: TatVirtualMachine);
    procedure __SetTCustomSQLDataSetDesignerData(AMachine: TatVirtualMachine);
    procedure __GetTCustomSQLDataSetRecordCount(AMachine: TatVirtualMachine);
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
  TSQLMonitorClass = class of TSQLMonitor;
  TSQLConnectionClass = class of TSQLConnection;
  TSQLDataLinkClass = class of TSQLDataLink;
  TCustomSQLDataSetClass = class of TCustomSQLDataSet;
  TSQLDataSetClass = class of TSQLDataSet;
  TSQLQueryClass = class of TSQLQuery;
  TSQLStoredProcClass = class of TSQLStoredProc;
  TSQLTableClass = class of TSQLTable;

  TatSqlExprDispatcher = class(TatEventDispatcher)
  private
    procedure __TLoginEvent( Sender: TObject;  Username: string;  Password: string);
    procedure __TConnectChangeEvent( Sender: TObject;  Connecting: Boolean);
    procedure __TSQLConnectionLoginEvent( Database: TSQLConnection;  LoginParams: TStrings);
  end;

  SQLTRACEDescWrapper = class(TatRecordWrapper)
  private
    FeTraceCat: TRACECat;
    FClientData: Integer;
    FuTotalMsgLen: Word;
  public
    constructor Create(ARecord: SQLTRACEDesc);
    function ObjToRec: SQLTRACEDesc;
  published
    property eTraceCat: TRACECat read FeTraceCat write FeTraceCat;
    property ClientData: Integer read FClientData write FClientData;
    property uTotalMsgLen: Word read FuTotalMsgLen write FuTotalMsgLen;
  end;
  
  TSQLSchemaInfoWrapper = class(TatRecordWrapper)
  private
    FFType: TSchemaType;
    FObjectName: string;
    FPattern: string;
  public
    constructor Create(ARecord: TSQLSchemaInfo);
    function ObjToRec: TSQLSchemaInfo;
  published
    property FType: TSchemaType read FFType write FFType;
    property ObjectName: string read FObjectName write FObjectName;
    property Pattern: string read FPattern write FPattern;
  end;
  

implementation

constructor SQLTRACEDescWrapper.Create(ARecord: SQLTRACEDesc);
begin
  inherited Create;
  FeTraceCat := ARecord.eTraceCat;
  FClientData := ARecord.ClientData;
  FuTotalMsgLen := ARecord.uTotalMsgLen;
end;

function SQLTRACEDescWrapper.ObjToRec: SQLTRACEDesc;
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
end;

function TSQLSchemaInfoWrapper.ObjToRec: TSQLSchemaInfo;
begin
  result.FType := FFType;
  result.ObjectName := FObjectName;
  result.Pattern := FPattern;
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

procedure TatSqlExprLibrary.__TCustomSQLDataSetSetSchemaInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomSQLDataSet(CurrentObject).SetSchemaInfo(GetInputArg(0),GetInputArg(1),GetInputArg(2));
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
    TSQLTable(CurrentObject).GetIndexNames(TStrings(Integer(GetInputArg(0))));
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

procedure TatSqlExprDispatcher.__TLoginEvent( Sender: TObject;  Username: string;  Password: string);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLoginEvent(BeforeCall)(Sender,Username,Password);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Username,Password]);
    if AssignedMethod(AfterCall) then
      TLoginEvent(AfterCall)(Sender,Username,Password);
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

procedure TatSqlExprDispatcher.__TSQLConnectionLoginEvent( Database: TSQLConnection;  LoginParams: TStrings);
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
    DefineMethod('GetProcedureParams',2,tkNone,nil,__TSQLConnectionGetProcedureParams,false,0);
    DefineMethod('GetTableNames',2,tkNone,nil,__TSQLConnectionGetTableNames,false,1);
    DefineMethod('LoadParamsFromIniFile',1,tkNone,nil,__TSQLConnectionLoadParamsFromIniFile,false,1);
    DefineMethod('Rollback',1,tkNone,nil,__TSQLConnectionRollback,false,0);
    DefineMethod('StartTransaction',1,tkNone,nil,__TSQLConnectionStartTransaction,false,0);
    DefineProp('ActiveStatements',tkInteger,__GetTSQLConnectionActiveStatements,nil,nil,false,0);
    DefineProp('AutoClone',tkVariant,__GetTSQLConnectionAutoClone,__SetTSQLConnectionAutoClone,nil,false,0);
    DefineProp('ConnectionState',tkEnumeration,__GetTSQLConnectionConnectionState,__SetTSQLConnectionConnectionState,nil,false,0);
    DefineProp('DataSets',tkClass,__GetTSQLConnectionDataSets,nil,TCustomSQLDataSet,false,1);
    DefineProp('InTransaction',tkVariant,__GetTSQLConnectionInTransaction,nil,nil,false,0);
    DefineProp('LocaleCode',tkInteger,__GetTSQLConnectionLocaleCode,__SetTSQLConnectionLocaleCode,nil,false,0);
    DefineProp('MaxStmtsPerConn',tkInteger,__GetTSQLConnectionMaxStmtsPerConn,nil,nil,false,0);
    DefineProp('ParamsLoaded',tkVariant,__GetTSQLConnectionParamsLoaded,__SetTSQLConnectionParamsLoaded,nil,false,0);
    DefineProp('SQLHourGlass',tkVariant,__GetTSQLConnectionSQLHourGlass,__SetTSQLConnectionSQLHourGlass,nil,false,0);
    DefineProp('TransactionsSupported',tkVariant,__GetTSQLConnectionTransactionsSupported,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TSQLDataLink) do
  begin
    DefineMethod('Create',1,tkClass,TSQLDataLink,__TSQLDataLinkCreate,true,0);
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
    DefineMethod('IsSequenced',0,tkVariant,nil,__TCustomSQLDataSetIsSequenced,false,0);
    DefineMethod('SetSchemaInfo',3,tkNone,nil,__TCustomSQLDataSetSetSchemaInfo,false,0);
    DefineProp('IndexDefs',tkClass,__GetTCustomSQLDataSetIndexDefs,__SetTCustomSQLDataSetIndexDefs,TIndexDefs,false,0);
    DefineProp('Prepared',tkVariant,__GetTCustomSQLDataSetPrepared,__SetTCustomSQLDataSetPrepared,nil,false,0);
    DefineProp('DesignerData',tkVariant,__GetTCustomSQLDataSetDesignerData,__SetTCustomSQLDataSetDesignerData,nil,false,0);
    DefineProp('RecordCount',tkInteger,__GetTCustomSQLDataSetRecordCount,nil,nil,false,0);
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
  DefineEventAdapter(TypeInfo(TLoginEvent), TatSqlExprDispatcher, @TatSqlExprDispatcher.__TLoginEvent);
  DefineEventAdapter(TypeInfo(TConnectChangeEvent), TatSqlExprDispatcher, @TatSqlExprDispatcher.__TConnectChangeEvent);
  DefineEventAdapter(TypeInfo(TSQLConnectionLoginEvent), TatSqlExprDispatcher, @TatSqlExprDispatcher.__TSQLConnectionLoginEvent);
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
    AddConstant('traceQPREPARE',traceQPREPARE);
    AddConstant('traceQEXECUTE',traceQEXECUTE);
    AddConstant('traceERROR',traceERROR);
    AddConstant('traceSTMT',traceSTMT);
    AddConstant('traceCONNECT',traceCONNECT);
    AddConstant('traceTRANSACT',traceTRANSACT);
    AddConstant('traceBLOB',traceBLOB);
    AddConstant('traceMISC',traceMISC);
    AddConstant('traceVENDOR',traceVENDOR);
    AddConstant('traceDATAIN',traceDATAIN);
    AddConstant('traceDATAOUT',traceDATAOUT);
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
    AddConstant('ctQuery',ctQuery);
    AddConstant('ctTable',ctTable);
    AddConstant('ctStoredProc',ctStoredProc);
    AddConstant('SSelect',SSelect);
    AddConstant('SSelectStar',SSelectStar);
    AddConstant('SSelectStarFrom',SSelectStarFrom);
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

