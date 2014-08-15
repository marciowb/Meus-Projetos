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
unit ap_IBDatabase;

interface

uses
  SysUtils,
  Classes,
  Windows,
  Messages,
  IBHeader,
  IBExternals,
  DB,
  IB,
  IBDatabase,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatIBDatabaseLibrary = class(TatScripterLibrary)
    procedure __TIBSchemaFreeNodes(AMachine: TatVirtualMachine);
    procedure __TIBSchemaHas_DEFAULT_VALUE(AMachine: TatVirtualMachine);
    procedure __TIBSchemaHas_COMPUTED_BLR(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseCreate(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseDestroy(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseCloseDataSets(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseCheckActive(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseCheckInactive(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseCreateDatabase(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseDropDatabase(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseForceClose(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseGetFieldNames(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseGetTableNames(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseIndexOfDBConst(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseTestConnected(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseCheckDatabaseName(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseCall(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseAddTransaction(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseFindTransaction(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseFindDefaultTransaction(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseRemoveTransaction(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseRemoveTransactions(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseHas_DEFAULT_VALUE(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseHas_COMPUTED_BLR(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseFlushSchema(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseIsReadOnly(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseDBParamByDPB(AMachine: TatVirtualMachine);
    procedure __SetTIBDatabaseDBParamByDPB(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseSQLObjectCount(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseSQLObjects(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseHandleIsShared(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseTransactionCount(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseTransactions(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInternalTransaction(AMachine: TatVirtualMachine);
    procedure __TIBTransactionCreate(AMachine: TatVirtualMachine);
    procedure __TIBTransactionDestroy(AMachine: TatVirtualMachine);
    procedure __TIBTransactionCall(AMachine: TatVirtualMachine);
    procedure __TIBTransactionCommit(AMachine: TatVirtualMachine);
    procedure __TIBTransactionCommitRetaining(AMachine: TatVirtualMachine);
    procedure __TIBTransactionRollback(AMachine: TatVirtualMachine);
    procedure __TIBTransactionRollbackRetaining(AMachine: TatVirtualMachine);
    procedure __TIBTransactionStartTransaction(AMachine: TatVirtualMachine);
    procedure __TIBTransactionCheckInTransaction(AMachine: TatVirtualMachine);
    procedure __TIBTransactionCheckNotInTransaction(AMachine: TatVirtualMachine);
    procedure __TIBTransactionCheckAutoStop(AMachine: TatVirtualMachine);
    procedure __TIBTransactionAddDatabase(AMachine: TatVirtualMachine);
    procedure __TIBTransactionFindDatabase(AMachine: TatVirtualMachine);
    procedure __TIBTransactionFindDefaultDatabase(AMachine: TatVirtualMachine);
    procedure __TIBTransactionRemoveDatabase(AMachine: TatVirtualMachine);
    procedure __TIBTransactionRemoveDatabases(AMachine: TatVirtualMachine);
    procedure __TIBTransactionCheckDatabasesInList(AMachine: TatVirtualMachine);
    procedure __GetTIBTransactionDatabaseCount(AMachine: TatVirtualMachine);
    procedure __GetTIBTransactionDatabases(AMachine: TatVirtualMachine);
    procedure __GetTIBTransactionSQLObjectCount(AMachine: TatVirtualMachine);
    procedure __GetTIBTransactionSQLObjects(AMachine: TatVirtualMachine);
    procedure __GetTIBTransactionHandleIsShared(AMachine: TatVirtualMachine);
    procedure __GetTIBTransactionInTransaction(AMachine: TatVirtualMachine);
    procedure __GetTIBTransactionTPB(AMachine: TatVirtualMachine);
    procedure __GetTIBTransactionTPBLength(AMachine: TatVirtualMachine);
    procedure __TIBBaseCreate(AMachine: TatVirtualMachine);
    procedure __TIBBaseDestroy(AMachine: TatVirtualMachine);
    procedure __TIBBaseCheckDatabase(AMachine: TatVirtualMachine);
    procedure __TIBBaseCheckTransaction(AMachine: TatVirtualMachine);
    procedure __GetTIBBaseDatabase(AMachine: TatVirtualMachine);
    procedure __SetTIBBaseDatabase(AMachine: TatVirtualMachine);
    procedure __GetTIBBaseOwner(AMachine: TatVirtualMachine);
    procedure __GetTIBBaseTransaction(AMachine: TatVirtualMachine);
    procedure __SetTIBBaseTransaction(AMachine: TatVirtualMachine);
    procedure __TIBTimerCreate(AMachine: TatVirtualMachine);
    procedure __TIBTimerDestroy(AMachine: TatVirtualMachine);
    procedure __GenerateDPB(AMachine: TatVirtualMachine);
    procedure __GenerateTPB(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBSchemaClass = class of TIBSchema;
  TIBDatabaseClass = class of TIBDatabase;
  TIBTransactionClass = class of TIBTransaction;
  TIBBaseClass = class of TIBBase;
  TIBTimerClass = class of TIBTimer;

  TatIBDatabaseDispatcher = class(TatEventDispatcher)
  private
    procedure __TIBDatabaseLoginEvent( Database: TIBDatabase;  LoginParams: TStrings);
  end;


implementation



procedure TatIBDatabaseLibrary.__TIBSchemaFreeNodes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSchema(CurrentObject).FreeNodes;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBSchemaHas_DEFAULT_VALUE(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBSchema(CurrentObject).Has_DEFAULT_VALUE(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseLibrary.__TIBSchemaHas_COMPUTED_BLR(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBSchema(CurrentObject).Has_COMPUTED_BLR(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBDatabaseClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDatabase(CurrentObject).Destroy;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseCloseDataSets(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDatabase(CurrentObject).CloseDataSets;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseCheckActive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDatabase(CurrentObject).CheckActive;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseCheckInactive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDatabase(CurrentObject).CheckInactive;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseCreateDatabase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDatabase(CurrentObject).CreateDatabase;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseDropDatabase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDatabase(CurrentObject).DropDatabase;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseForceClose(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDatabase(CurrentObject).ForceClose;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseGetFieldNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDatabase(CurrentObject).GetFieldNames(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseGetTableNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      1: TIBDatabase(CurrentObject).GetTableNames(TStrings(Integer(GetInputArg(0))));
      2: TIBDatabase(CurrentObject).GetTableNames(TStrings(Integer(GetInputArg(0))),GetInputArg(1));
    end;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseIndexOfDBConst(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBDatabase(CurrentObject).IndexOfDBConst(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseTestConnected(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBDatabase(CurrentObject).TestConnected;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseCheckDatabaseName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDatabase(CurrentObject).CheckDatabaseName;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseCall(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBDatabase(CurrentObject).Call(VarToInteger(GetInputArg(0)),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseAddTransaction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBDatabase(CurrentObject).AddTransaction(TIBTransaction(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseFindTransaction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBDatabase(CurrentObject).FindTransaction(TIBTransaction(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseFindDefaultTransaction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBDatabase(CurrentObject).FindDefaultTransaction);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseRemoveTransaction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDatabase(CurrentObject).RemoveTransaction(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseRemoveTransactions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDatabase(CurrentObject).RemoveTransactions;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseHas_DEFAULT_VALUE(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBDatabase(CurrentObject).Has_DEFAULT_VALUE(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseHas_COMPUTED_BLR(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBDatabase(CurrentObject).Has_COMPUTED_BLR(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseLibrary.__TIBDatabaseFlushSchema(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDatabase(CurrentObject).FlushSchema;
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBDatabaseIsReadOnly(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBDatabase(CurrentObject).IsReadOnly);
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBDatabaseDBParamByDPB(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBDatabase(CurrentObject).DBParamByDPB[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatIBDatabaseLibrary.__SetTIBDatabaseDBParamByDPB(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDatabase(CurrentObject).DBParamByDPB[VarToInteger(GetArrayIndex(0))]:=GetInputArg(0);
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBDatabaseSQLObjectCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabase(CurrentObject).SQLObjectCount));
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBDatabaseSQLObjects(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabase(CurrentObject).SQLObjects[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBDatabaseHandleIsShared(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBDatabase(CurrentObject).HandleIsShared);
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBDatabaseTransactionCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabase(CurrentObject).TransactionCount));
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBDatabaseTransactions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabase(CurrentObject).Transactions[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBDatabaseInternalTransaction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabase(CurrentObject).InternalTransaction));
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTransactionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBTransactionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTransactionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTransaction(CurrentObject).Destroy;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTransactionCall(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBTransaction(CurrentObject).Call(VarToInteger(GetInputArg(0)),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTransactionCommit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTransaction(CurrentObject).Commit;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTransactionCommitRetaining(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTransaction(CurrentObject).CommitRetaining;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTransactionRollback(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTransaction(CurrentObject).Rollback;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTransactionRollbackRetaining(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTransaction(CurrentObject).RollbackRetaining;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTransactionStartTransaction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTransaction(CurrentObject).StartTransaction;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTransactionCheckInTransaction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTransaction(CurrentObject).CheckInTransaction;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTransactionCheckNotInTransaction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTransaction(CurrentObject).CheckNotInTransaction;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTransactionCheckAutoStop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTransaction(CurrentObject).CheckAutoStop;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTransactionAddDatabase(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBTransaction(CurrentObject).AddDatabase(TIBDatabase(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTransactionFindDatabase(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBTransaction(CurrentObject).FindDatabase(TIBDatabase(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTransactionFindDefaultDatabase(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBTransaction(CurrentObject).FindDefaultDatabase);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTransactionRemoveDatabase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTransaction(CurrentObject).RemoveDatabase(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTransactionRemoveDatabases(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTransaction(CurrentObject).RemoveDatabases;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTransactionCheckDatabasesInList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTransaction(CurrentObject).CheckDatabasesInList;
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBTransactionDatabaseCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBTransaction(CurrentObject).DatabaseCount));
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBTransactionDatabases(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBTransaction(CurrentObject).Databases[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBTransactionSQLObjectCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBTransaction(CurrentObject).SQLObjectCount));
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBTransactionSQLObjects(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBTransaction(CurrentObject).SQLObjects[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBTransactionHandleIsShared(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBTransaction(CurrentObject).HandleIsShared);
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBTransactionInTransaction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBTransaction(CurrentObject).InTransaction);
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBTransactionTPB(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(string(TIBTransaction(CurrentObject).TPB));
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBTransactionTPBLength(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBTransaction(CurrentObject).TPBLength));
  end;
end;

procedure TatIBDatabaseLibrary.__TIBBaseCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBBaseClass(CurrentClass.ClassRef).Create(TObject(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseLibrary.__TIBBaseDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBase(CurrentObject).Destroy;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBBaseCheckDatabase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBase(CurrentObject).CheckDatabase;
  end;
end;

procedure TatIBDatabaseLibrary.__TIBBaseCheckTransaction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBase(CurrentObject).CheckTransaction;
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBBaseDatabase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBBase(CurrentObject).Database));
  end;
end;

procedure TatIBDatabaseLibrary.__SetTIBBaseDatabase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBase(CurrentObject).Database:=TIBDatabase(Integer(GetInputArg(0)));
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBBaseOwner(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBBase(CurrentObject).Owner));
  end;
end;

procedure TatIBDatabaseLibrary.__GetTIBBaseTransaction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBBase(CurrentObject).Transaction));
  end;
end;

procedure TatIBDatabaseLibrary.__SetTIBBaseTransaction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBase(CurrentObject).Transaction:=TIBTransaction(Integer(GetInputArg(0)));
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTimerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBTimerClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseLibrary.__TIBTimerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTimer(CurrentObject).Destroy;
  end;
end;

procedure TatIBDatabaseDispatcher.__TIBDatabaseLoginEvent( Database: TIBDatabase;  LoginParams: TStrings);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TIBDatabaseLoginEvent(BeforeCall)(Database,LoginParams);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Database,LoginParams]);
    if AssignedMethod(AfterCall) then
      TIBDatabaseLoginEvent(AfterCall)(Database,LoginParams);
  end;
end;

procedure TatIBDatabaseLibrary.__GenerateDPB(AMachine: TatVirtualMachine);
  var
  Param1: string;
  Param2: Short;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
Param2 := VarToInteger(GetInputArg(2));
    IBDatabase.GenerateDPB(TStrings(Integer(GetInputArg(0))),Param1,Param2);
    SetInputArg(1,Param1);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatIBDatabaseLibrary.__GenerateTPB(AMachine: TatVirtualMachine);
  var
  Param1: string;
  Param2: Short;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
Param2 := VarToInteger(GetInputArg(2));
    IBDatabase.GenerateTPB(TStrings(Integer(GetInputArg(0))),Param1,Param2);
    SetInputArg(1,Param1);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatIBDatabaseLibrary.Init;
begin
  With Scripter.DefineClass(TIBSchema) do
  begin
    DefineMethod('FreeNodes',0,tkNone,nil,__TIBSchemaFreeNodes,false,0);
    DefineMethod('Has_DEFAULT_VALUE',2,tkVariant,nil,__TIBSchemaHas_DEFAULT_VALUE,false,0);
    DefineMethod('Has_COMPUTED_BLR',2,tkVariant,nil,__TIBSchemaHas_COMPUTED_BLR,false,0);
  end;
  With Scripter.DefineClass(TIBDatabase) do
  begin
    DefineMethod('Create',1,tkClass,TIBDatabase,__TIBDatabaseCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBDatabaseDestroy,false,0);
    DefineMethod('CloseDataSets',0,tkNone,nil,__TIBDatabaseCloseDataSets,false,0);
    DefineMethod('CheckActive',0,tkNone,nil,__TIBDatabaseCheckActive,false,0);
    DefineMethod('CheckInactive',0,tkNone,nil,__TIBDatabaseCheckInactive,false,0);
    DefineMethod('CreateDatabase',0,tkNone,nil,__TIBDatabaseCreateDatabase,false,0);
    DefineMethod('DropDatabase',0,tkNone,nil,__TIBDatabaseDropDatabase,false,0);
    DefineMethod('ForceClose',0,tkNone,nil,__TIBDatabaseForceClose,false,0);
    DefineMethod('GetFieldNames',2,tkNone,nil,__TIBDatabaseGetFieldNames,false,0);
    DefineMethod('GetTableNames',2,tkNone,nil,__TIBDatabaseGetTableNames,false,1);
    DefineMethod('IndexOfDBConst',1,tkInteger,nil,__TIBDatabaseIndexOfDBConst,false,0);
    DefineMethod('TestConnected',0,tkVariant,nil,__TIBDatabaseTestConnected,false,0);
    DefineMethod('CheckDatabaseName',0,tkNone,nil,__TIBDatabaseCheckDatabaseName,false,0);
    DefineMethod('Call',2,tkInteger,nil,__TIBDatabaseCall,false,0);
    DefineMethod('AddTransaction',1,tkInteger,nil,__TIBDatabaseAddTransaction,false,0);
    DefineMethod('FindTransaction',1,tkInteger,nil,__TIBDatabaseFindTransaction,false,0);
    DefineMethod('FindDefaultTransaction',0,tkClass,TIBTransaction,__TIBDatabaseFindDefaultTransaction,false,0);
    DefineMethod('RemoveTransaction',1,tkNone,nil,__TIBDatabaseRemoveTransaction,false,0);
    DefineMethod('RemoveTransactions',0,tkNone,nil,__TIBDatabaseRemoveTransactions,false,0);
    DefineMethod('Has_DEFAULT_VALUE',2,tkVariant,nil,__TIBDatabaseHas_DEFAULT_VALUE,false,0);
    DefineMethod('Has_COMPUTED_BLR',2,tkVariant,nil,__TIBDatabaseHas_COMPUTED_BLR,false,0);
    DefineMethod('FlushSchema',0,tkNone,nil,__TIBDatabaseFlushSchema,false,0);
    DefineProp('IsReadOnly',tkVariant,__GetTIBDatabaseIsReadOnly,nil,nil,false,0);
    DefineProp('DBParamByDPB',tkVariant,__GetTIBDatabaseDBParamByDPB,__SetTIBDatabaseDBParamByDPB,nil,false,1);
    DefineProp('SQLObjectCount',tkInteger,__GetTIBDatabaseSQLObjectCount,nil,nil,false,0);
    DefineProp('SQLObjects',tkClass,__GetTIBDatabaseSQLObjects,nil,TIBBase,false,1);
    DefineProp('HandleIsShared',tkVariant,__GetTIBDatabaseHandleIsShared,nil,nil,false,0);
    DefineProp('TransactionCount',tkInteger,__GetTIBDatabaseTransactionCount,nil,nil,false,0);
    DefineProp('Transactions',tkClass,__GetTIBDatabaseTransactions,nil,TIBTransaction,false,1);
    DefineProp('InternalTransaction',tkClass,__GetTIBDatabaseInternalTransaction,nil,TIBTransaction,false,0);
  end;
  With Scripter.DefineClass(TIBTransaction) do
  begin
    DefineMethod('Create',1,tkClass,TIBTransaction,__TIBTransactionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBTransactionDestroy,false,0);
    DefineMethod('Call',2,tkInteger,nil,__TIBTransactionCall,false,0);
    DefineMethod('Commit',0,tkNone,nil,__TIBTransactionCommit,false,0);
    DefineMethod('CommitRetaining',0,tkNone,nil,__TIBTransactionCommitRetaining,false,0);
    DefineMethod('Rollback',0,tkNone,nil,__TIBTransactionRollback,false,0);
    DefineMethod('RollbackRetaining',0,tkNone,nil,__TIBTransactionRollbackRetaining,false,0);
    DefineMethod('StartTransaction',0,tkNone,nil,__TIBTransactionStartTransaction,false,0);
    DefineMethod('CheckInTransaction',0,tkNone,nil,__TIBTransactionCheckInTransaction,false,0);
    DefineMethod('CheckNotInTransaction',0,tkNone,nil,__TIBTransactionCheckNotInTransaction,false,0);
    DefineMethod('CheckAutoStop',0,tkNone,nil,__TIBTransactionCheckAutoStop,false,0);
    DefineMethod('AddDatabase',1,tkInteger,nil,__TIBTransactionAddDatabase,false,0);
    DefineMethod('FindDatabase',1,tkInteger,nil,__TIBTransactionFindDatabase,false,0);
    DefineMethod('FindDefaultDatabase',0,tkClass,TIBDatabase,__TIBTransactionFindDefaultDatabase,false,0);
    DefineMethod('RemoveDatabase',1,tkNone,nil,__TIBTransactionRemoveDatabase,false,0);
    DefineMethod('RemoveDatabases',0,tkNone,nil,__TIBTransactionRemoveDatabases,false,0);
    DefineMethod('CheckDatabasesInList',0,tkNone,nil,__TIBTransactionCheckDatabasesInList,false,0);
    DefineProp('DatabaseCount',tkInteger,__GetTIBTransactionDatabaseCount,nil,nil,false,0);
    DefineProp('Databases',tkClass,__GetTIBTransactionDatabases,nil,TIBDatabase,false,1);
    DefineProp('SQLObjectCount',tkInteger,__GetTIBTransactionSQLObjectCount,nil,nil,false,0);
    DefineProp('SQLObjects',tkClass,__GetTIBTransactionSQLObjects,nil,TIBBase,false,1);
    DefineProp('HandleIsShared',tkVariant,__GetTIBTransactionHandleIsShared,nil,nil,false,0);
    DefineProp('InTransaction',tkVariant,__GetTIBTransactionInTransaction,nil,nil,false,0);
    DefineProp('TPB',tkVariant,__GetTIBTransactionTPB,nil,nil,false,0);
    DefineProp('TPBLength',tkInteger,__GetTIBTransactionTPBLength,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TIBBase) do
  begin
    DefineMethod('Create',1,tkClass,TIBBase,__TIBBaseCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBBaseDestroy,false,0);
    DefineMethod('CheckDatabase',0,tkNone,nil,__TIBBaseCheckDatabase,false,0);
    DefineMethod('CheckTransaction',0,tkNone,nil,__TIBBaseCheckTransaction,false,0);
    DefineProp('Database',tkClass,__GetTIBBaseDatabase,__SetTIBBaseDatabase,TIBDatabase,false,0);
    DefineProp('Owner',tkClass,__GetTIBBaseOwner,nil,TObject,false,0);
    DefineProp('Transaction',tkClass,__GetTIBBaseTransaction,__SetTIBBaseTransaction,TIBTransaction,false,0);
  end;
  With Scripter.DefineClass(TIBTimer) do
  begin
    DefineMethod('Create',1,tkClass,TIBTimer,__TIBTimerCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBTimerDestroy,false,0);
  end;
  DefineEventAdapter(TypeInfo(TIBDatabaseLoginEvent), TatIBDatabaseDispatcher, @TatIBDatabaseDispatcher.__TIBDatabaseLoginEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('GenerateDPB',3,tkNone,nil,__GenerateDPB,false,0).SetVarArgs([1,2]);
    DefineMethod('GenerateTPB',3,tkNone,nil,__GenerateTPB,false,0).SetVarArgs([1,2]);
    AddConstant('TARollback',TARollback);
    AddConstant('TACommit',TACommit);
    AddConstant('TARollbackRetaining',TARollbackRetaining);
    AddConstant('TACommitRetaining',TACommitRetaining);
    AddConstant('saNone',saNone);
    AddConstant('saRollback',saRollback);
    AddConstant('saCommit',saCommit);
    AddConstant('saRollbackRetaining',saRollbackRetaining);
    AddConstant('saCommitRetaining',saCommitRetaining);
    AddConstant('DPBPrefix',DPBPrefix);
    AddConstant('TPBPrefix',TPBPrefix);
  end;
end;

class function TatIBDatabaseLibrary.LibraryName: string;
begin
  result := 'IBDatabase';
end;

initialization
  RegisterScripterLibrary(TatIBDatabaseLibrary, True);

{$WARNINGS ON}

end.

