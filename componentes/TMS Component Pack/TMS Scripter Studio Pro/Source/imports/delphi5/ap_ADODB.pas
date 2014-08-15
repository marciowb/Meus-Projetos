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
unit ap_ADODB;

interface

uses
  Windows,
  ActiveX,
  SysUtils,
  Classes,
  Graphics,
  TypInfo,
  DB,
  OLEDB,
  ADOInt,
  ADODB,
  atScript;

{$WARNINGS OFF}

type
  TatADODBLibrary = class(TatScripterLibrary)
    procedure __TADOConnectionCreate(AMachine: TatVirtualMachine);
    procedure __TADOConnectionDestroy(AMachine: TatVirtualMachine);
    procedure __TADOConnectionBeginTrans(AMachine: TatVirtualMachine);
    procedure __TADOConnectionCancel(AMachine: TatVirtualMachine);
    procedure __TADOConnectionCommitTrans(AMachine: TatVirtualMachine);
    procedure __TADOConnectionGetProcedureNames(AMachine: TatVirtualMachine);
    procedure __TADOConnectionGetFieldNames(AMachine: TatVirtualMachine);
    procedure __TADOConnectionGetTableNames(AMachine: TatVirtualMachine);
    procedure __TADOConnectionOpenSchema(AMachine: TatVirtualMachine);
    procedure __TADOConnectionRollbackTrans(AMachine: TatVirtualMachine);
    procedure __GetTADOConnectionCommandCount(AMachine: TatVirtualMachine);
    procedure __GetTADOConnectionCommands(AMachine: TatVirtualMachine);
    procedure __GetTADOConnectionDataSets(AMachine: TatVirtualMachine);
    procedure __GetTADOConnectionInTransaction(AMachine: TatVirtualMachine);
    procedure __GetTADOConnectionState(AMachine: TatVirtualMachine);
    procedure __GetTADOConnectionVersion(AMachine: TatVirtualMachine);
    procedure __TRDSConnectionCreate(AMachine: TatVirtualMachine);
    procedure __TRDSConnectionDestroy(AMachine: TatVirtualMachine);
    procedure __GetTRDSConnectionAppServer(AMachine: TatVirtualMachine);
    procedure __TParameterAssign(AMachine: TatVirtualMachine);
    procedure __TParameterAppendChunk(AMachine: TatVirtualMachine);
    procedure __TParameterLoadFromFile(AMachine: TatVirtualMachine);
    procedure __TParameterLoadFromStream(AMachine: TatVirtualMachine);
    procedure __GetTParameterParameters(AMachine: TatVirtualMachine);
    procedure __TParametersAddParameter(AMachine: TatVirtualMachine);
    procedure __TParametersAssignValues(AMachine: TatVirtualMachine);
    procedure __TParametersCreateParameter(AMachine: TatVirtualMachine);
    procedure __TParametersFindParam(AMachine: TatVirtualMachine);
    procedure __TParametersGetParamList(AMachine: TatVirtualMachine);
    procedure __TParametersIsEqual(AMachine: TatVirtualMachine);
    procedure __TParametersParamByName(AMachine: TatVirtualMachine);
    procedure __TParametersParseSQL(AMachine: TatVirtualMachine);
    procedure __TParametersRefresh(AMachine: TatVirtualMachine);
    procedure __GetTParametersParamValues(AMachine: TatVirtualMachine);
    procedure __SetTParametersParamValues(AMachine: TatVirtualMachine);
    procedure __GetTParametersCommand(AMachine: TatVirtualMachine);
    procedure __GetTParametersItems(AMachine: TatVirtualMachine);
    procedure __SetTParametersItems(AMachine: TatVirtualMachine);
    procedure __TADOCommandCreate(AMachine: TatVirtualMachine);
    procedure __TADOCommandDestroy(AMachine: TatVirtualMachine);
    procedure __TADOCommandAssign(AMachine: TatVirtualMachine);
    procedure __TADOCommandCancel(AMachine: TatVirtualMachine);
    procedure __GetTADOCommandStates(AMachine: TatVirtualMachine);
    procedure __TCustomADODataSetCreate(AMachine: TatVirtualMachine);
    procedure __TCustomADODataSetDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomADODataSetCancelBatch(AMachine: TatVirtualMachine);
    procedure __TCustomADODataSetCancelUpdates(AMachine: TatVirtualMachine);
    procedure __TCustomADODataSetClone(AMachine: TatVirtualMachine);
    procedure __TCustomADODataSetCreateBlobStream(AMachine: TatVirtualMachine);
    procedure __TCustomADODataSetDeleteRecords(AMachine: TatVirtualMachine);
    procedure __TCustomADODataSetIsSequenced(AMachine: TatVirtualMachine);
    procedure __TCustomADODataSetLoadFromFile(AMachine: TatVirtualMachine);
    procedure __TCustomADODataSetLocate(AMachine: TatVirtualMachine);
    procedure __TCustomADODataSetLookup(AMachine: TatVirtualMachine);
    procedure __TCustomADODataSetRequery(AMachine: TatVirtualMachine);
    procedure __TCustomADODataSetSaveToFile(AMachine: TatVirtualMachine);
    procedure __TCustomADODataSetSeek(AMachine: TatVirtualMachine);
    procedure __TCustomADODataSetSupports(AMachine: TatVirtualMachine);
    procedure __TCustomADODataSetUpdateBatch(AMachine: TatVirtualMachine);
    procedure __TCustomADODataSetUpdateStatus(AMachine: TatVirtualMachine);
    procedure __GetTCustomADODataSetEnableBCD(AMachine: TatVirtualMachine);
    procedure __SetTCustomADODataSetEnableBCD(AMachine: TatVirtualMachine);
    procedure __GetTCustomADODataSetDesignerData(AMachine: TatVirtualMachine);
    procedure __SetTCustomADODataSetDesignerData(AMachine: TatVirtualMachine);
    procedure __GetTCustomADODataSetIndexName(AMachine: TatVirtualMachine);
    procedure __SetTCustomADODataSetIndexName(AMachine: TatVirtualMachine);
    procedure __GetTCustomADODataSetIndexFieldCount(AMachine: TatVirtualMachine);
    procedure __GetTCustomADODataSetIndexFields(AMachine: TatVirtualMachine);
    procedure __SetTCustomADODataSetIndexFields(AMachine: TatVirtualMachine);
    procedure __GetTCustomADODataSetFilterGroup(AMachine: TatVirtualMachine);
    procedure __SetTCustomADODataSetFilterGroup(AMachine: TatVirtualMachine);
    procedure __GetTCustomADODataSetRecordsetState(AMachine: TatVirtualMachine);
    procedure __GetTCustomADODataSetRecordStatus(AMachine: TatVirtualMachine);
    procedure __GetTCustomADODataSetSort(AMachine: TatVirtualMachine);
    procedure __SetTCustomADODataSetSort(AMachine: TatVirtualMachine);
    procedure __TADODataSetCreateDataSet(AMachine: TatVirtualMachine);
    procedure __TADODataSetGetIndexNames(AMachine: TatVirtualMachine);
    procedure __TADOTableCreate(AMachine: TatVirtualMachine);
    procedure __TADOTableGetIndexNames(AMachine: TatVirtualMachine);
    procedure __TADOQueryCreate(AMachine: TatVirtualMachine);
    procedure __TADOQueryDestroy(AMachine: TatVirtualMachine);
    procedure __TADOQueryExecSQL(AMachine: TatVirtualMachine);
    procedure __GetTADOQueryRowsAffected(AMachine: TatVirtualMachine);
    procedure __TADOStoredProcCreate(AMachine: TatVirtualMachine);
    procedure __TADOStoredProcExecProc(AMachine: TatVirtualMachine);
    procedure __TADOBlobStreamCreate(AMachine: TatVirtualMachine);
    procedure __TADOBlobStreamDestroy(AMachine: TatVirtualMachine);
    procedure __TADOBlobStreamWrite(AMachine: TatVirtualMachine);
    procedure __TADOBlobStreamTruncate(AMachine: TatVirtualMachine);
    procedure __CreateUDLFile(AMachine: TatVirtualMachine);
    procedure __DataLinkDir(AMachine: TatVirtualMachine);
    procedure __GetProviderNames(AMachine: TatVirtualMachine);
    procedure __PromptDataSource(AMachine: TatVirtualMachine);
    procedure __PromptDataLinkFile(AMachine: TatVirtualMachine);
    procedure __GetDataLinkFiles(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EADOErrorClass = class of EADOError;
  TADOConnectionClass = class of TADOConnection;
  TRDSConnectionClass = class of TRDSConnection;
  TParameterClass = class of TParameter;
  TParametersClass = class of TParameters;
  TADOCommandClass = class of TADOCommand;
  TCustomADODataSetClass = class of TCustomADODataSet;
  TADODataSetClass = class of TADODataSet;
  TADOTableClass = class of TADOTable;
  TADOQueryClass = class of TADOQuery;
  TADOStoredProcClass = class of TADOStoredProc;
  TADOBlobStreamClass = class of TADOBlobStream;

  TatADODBDispatcher = class(TatEventDispatcher)
  private
    procedure __TDisconnectEvent( Connection: TADOConnection; var EventStatus: TEventStatus);
    procedure __TWillConnectEvent( Connection: TADOConnection; var ConnectionString: WideString; var UserID: WideString; var Password: WideString; var ConnectOptions: TConnectOption; var EventStatus: TEventStatus);
    procedure __TWillChangeFieldEvent( DataSet: TCustomADODataSet; const FieldCount: Integer; const Fields: OleVariant; var EventStatus: TEventStatus);
    procedure __TWillChangeRecordEvent( DataSet: TCustomADODataSet; const Reason: TEventReason; const RecordCount: Integer; var EventStatus: TEventStatus);
    procedure __TEndOfRecordsetEvent( DataSet: TCustomADODataSet; var MoreData: WordBool; var EventStatus: TEventStatus);
    procedure __TFetchProgressEvent( DataSet: TCustomADODataSet;  Progress: Integer;  MaxProgress: Integer; var EventStatus: TEventStatus);
    procedure __TRecordsetReasonEvent( DataSet: TCustomADODataSet; const Reason: TEventReason; var EventStatus: TEventStatus);
  end;


implementation



procedure TatADODBLibrary.__TADOConnectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TADOConnectionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TADOConnectionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TADOConnection(CurrentObject).Destroy;
  end;
end;

procedure TatADODBLibrary.__TADOConnectionBeginTrans(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TADOConnection(CurrentObject).BeginTrans);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TADOConnectionCancel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TADOConnection(CurrentObject).Cancel;
  end;
end;

procedure TatADODBLibrary.__TADOConnectionCommitTrans(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TADOConnection(CurrentObject).CommitTrans;
  end;
end;

procedure TatADODBLibrary.__TADOConnectionGetProcedureNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TADOConnection(CurrentObject).GetProcedureNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatADODBLibrary.__TADOConnectionGetFieldNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TADOConnection(CurrentObject).GetFieldNames(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatADODBLibrary.__TADOConnectionGetTableNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      1: TADOConnection(CurrentObject).GetTableNames(TStrings(Integer(GetInputArg(0))));
      2: TADOConnection(CurrentObject).GetTableNames(TStrings(Integer(GetInputArg(0))),GetInputArg(1));
    end;
  end;
end;

procedure TatADODBLibrary.__TADOConnectionOpenSchema(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TADOConnection(CurrentObject).OpenSchema(GetInputArg(0),GetInputArg(1),GetInputArg(2),TADODataSet(Integer(GetInputArg(3))));
  end;
end;

procedure TatADODBLibrary.__TADOConnectionRollbackTrans(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TADOConnection(CurrentObject).RollbackTrans;
  end;
end;

procedure TatADODBLibrary.__GetTADOConnectionCommandCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TADOConnection(CurrentObject).CommandCount));
  end;
end;

procedure TatADODBLibrary.__GetTADOConnectionCommands(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TADOConnection(CurrentObject).Commands[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatADODBLibrary.__GetTADOConnectionDataSets(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TADOConnection(CurrentObject).DataSets[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatADODBLibrary.__GetTADOConnectionInTransaction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TADOConnection(CurrentObject).InTransaction);
  end;
end;

procedure TatADODBLibrary.__GetTADOConnectionState(AMachine: TatVirtualMachine);
var
PropValueSet: TObjectStates;
begin
  with AMachine do
  begin
    PropValueSet := TADOConnection(CurrentObject).State;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatADODBLibrary.__GetTADOConnectionVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TADOConnection(CurrentObject).Version);
  end;
end;

procedure TatADODBLibrary.__TRDSConnectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRDSConnectionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TRDSConnectionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRDSConnection(CurrentObject).Destroy;
  end;
end;

procedure TatADODBLibrary.__GetTRDSConnectionAppServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRDSConnection(CurrentObject).AppServer);
  end;
end;

procedure TatADODBLibrary.__TParameterAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParameter(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatADODBLibrary.__TParameterAppendChunk(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParameter(CurrentObject).AppendChunk(GetInputArg(0));
  end;
end;

procedure TatADODBLibrary.__TParameterLoadFromFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParameter(CurrentObject).LoadFromFile(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatADODBLibrary.__TParameterLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParameter(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))),GetInputArg(1));
  end;
end;

procedure TatADODBLibrary.__GetTParameterParameters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TParameter(CurrentObject).Parameters));
  end;
end;

procedure TatADODBLibrary.__TParametersAddParameter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TParameters(CurrentObject).AddParameter);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TParametersAssignValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParameters(CurrentObject).AssignValues(TParameters(Integer(GetInputArg(0))));
  end;
end;

procedure TatADODBLibrary.__TParametersCreateParameter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TParameters(CurrentObject).CreateParameter(GetInputArg(0),GetInputArg(1),GetInputArg(2),VarToInteger(GetInputArg(3)),GetInputArg(4)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TParametersFindParam(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TParameters(CurrentObject).FindParam(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TParametersGetParamList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParameters(CurrentObject).GetParamList(TList(Integer(GetInputArg(0))),GetInputArg(1));
  end;
end;

procedure TatADODBLibrary.__TParametersIsEqual(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TParameters(CurrentObject).IsEqual(TParameters(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TParametersParamByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TParameters(CurrentObject).ParamByName(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TParametersParseSQL(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TParameters(CurrentObject).ParseSQL(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TParametersRefresh(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TParameters(CurrentObject).Refresh;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__GetTParametersParamValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TParameters(CurrentObject).ParamValues[GetArrayIndex(0)]);
  end;
end;

procedure TatADODBLibrary.__SetTParametersParamValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParameters(CurrentObject).ParamValues[GetArrayIndex(0)]:=GetInputArg(0);
  end;
end;

procedure TatADODBLibrary.__GetTParametersCommand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TParameters(CurrentObject).Command));
  end;
end;

procedure TatADODBLibrary.__GetTParametersItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TParameters(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatADODBLibrary.__SetTParametersItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParameters(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TParameter(Integer(GetInputArg(0)));
  end;
end;

procedure TatADODBLibrary.__TADOCommandCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TADOCommandClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TADOCommandDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TADOCommand(CurrentObject).Destroy;
  end;
end;

procedure TatADODBLibrary.__TADOCommandAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TADOCommand(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatADODBLibrary.__TADOCommandCancel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TADOCommand(CurrentObject).Cancel;
  end;
end;

procedure TatADODBLibrary.__GetTADOCommandStates(AMachine: TatVirtualMachine);
var
PropValueSet: TObjectStates;
begin
  with AMachine do
  begin
    PropValueSet := TADOCommand(CurrentObject).States;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatADODBLibrary.__TCustomADODataSetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomADODataSetClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TCustomADODataSetDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomADODataSet(CurrentObject).Destroy;
  end;
end;

procedure TatADODBLibrary.__TCustomADODataSetCancelBatch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      0: TCustomADODataSet(CurrentObject).CancelBatch;
      1: TCustomADODataSet(CurrentObject).CancelBatch(GetInputArg(0));
    end;
  end;
end;

procedure TatADODBLibrary.__TCustomADODataSetCancelUpdates(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomADODataSet(CurrentObject).CancelUpdates;
  end;
end;

procedure TatADODBLibrary.__TCustomADODataSetClone(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      1: TCustomADODataSet(CurrentObject).Clone(TCustomADODataSet(Integer(GetInputArg(0))));
      2: TCustomADODataSet(CurrentObject).Clone(TCustomADODataSet(Integer(GetInputArg(0))),GetInputArg(1));
    end;
  end;
end;

procedure TatADODBLibrary.__TCustomADODataSetCreateBlobStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomADODataSet(CurrentObject).CreateBlobStream(TField(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TCustomADODataSetDeleteRecords(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      0: TCustomADODataSet(CurrentObject).DeleteRecords;
      1: TCustomADODataSet(CurrentObject).DeleteRecords(GetInputArg(0));
    end;
  end;
end;

procedure TatADODBLibrary.__TCustomADODataSetIsSequenced(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomADODataSet(CurrentObject).IsSequenced;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TCustomADODataSetLoadFromFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomADODataSet(CurrentObject).LoadFromFile(GetInputArg(0));
  end;
end;

procedure TatADODBLibrary.__TCustomADODataSetLocate(AMachine: TatVirtualMachine);
  var
  Param2: TLocateOptions;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := TCustomADODataSet(CurrentObject).Locate(GetInputArg(0),GetInputArg(1),Param2);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TCustomADODataSetLookup(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomADODataSet(CurrentObject).Lookup(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TCustomADODataSetRequery(AMachine: TatVirtualMachine);
  var
  Param0: TExecuteOptions;
begin
  with AMachine do
  begin
IntToSet(Param0, VarToInteger(GetInputArg(0)), SizeOf(Param0));
    Case InputArgCount of
      0: TCustomADODataSet(CurrentObject).Requery;
      1: TCustomADODataSet(CurrentObject).Requery(Param0);
    end;
  end;
end;

procedure TatADODBLibrary.__TCustomADODataSetSaveToFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      0: TCustomADODataSet(CurrentObject).SaveToFile;
      1: TCustomADODataSet(CurrentObject).SaveToFile(GetInputArg(0));
      2: TCustomADODataSet(CurrentObject).SaveToFile(GetInputArg(0),GetInputArg(1));
    end;
  end;
end;

procedure TatADODBLibrary.__TCustomADODataSetSeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := TCustomADODataSet(CurrentObject).Seek(GetInputArg(0));
2: AResult := TCustomADODataSet(CurrentObject).Seek(GetInputArg(0),GetInputArg(1));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TCustomADODataSetSupports(AMachine: TatVirtualMachine);
  var
  Param0: TCursorOptions;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param0, VarToInteger(GetInputArg(0)), SizeOf(Param0));
AResult := TCustomADODataSet(CurrentObject).Supports(Param0);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TCustomADODataSetUpdateBatch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      0: TCustomADODataSet(CurrentObject).UpdateBatch;
      1: TCustomADODataSet(CurrentObject).UpdateBatch(GetInputArg(0));
    end;
  end;
end;

procedure TatADODBLibrary.__TCustomADODataSetUpdateStatus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomADODataSet(CurrentObject).UpdateStatus;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__GetTCustomADODataSetEnableBCD(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomADODataSet(CurrentObject).EnableBCD);
  end;
end;

procedure TatADODBLibrary.__SetTCustomADODataSetEnableBCD(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomADODataSet(CurrentObject).EnableBCD:=GetInputArg(0);
  end;
end;

procedure TatADODBLibrary.__GetTCustomADODataSetDesignerData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomADODataSet(CurrentObject).DesignerData);
  end;
end;

procedure TatADODBLibrary.__SetTCustomADODataSetDesignerData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomADODataSet(CurrentObject).DesignerData:=GetInputArg(0);
  end;
end;

procedure TatADODBLibrary.__GetTCustomADODataSetIndexName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomADODataSet(CurrentObject).IndexName);
  end;
end;

procedure TatADODBLibrary.__SetTCustomADODataSetIndexName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomADODataSet(CurrentObject).IndexName:=GetInputArg(0);
  end;
end;

procedure TatADODBLibrary.__GetTCustomADODataSetIndexFieldCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomADODataSet(CurrentObject).IndexFieldCount));
  end;
end;

procedure TatADODBLibrary.__GetTCustomADODataSetIndexFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomADODataSet(CurrentObject).IndexFields[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatADODBLibrary.__SetTCustomADODataSetIndexFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomADODataSet(CurrentObject).IndexFields[VarToInteger(GetArrayIndex(0))]:=TField(Integer(GetInputArg(0)));
  end;
end;

procedure TatADODBLibrary.__GetTCustomADODataSetFilterGroup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomADODataSet(CurrentObject).FilterGroup);
  end;
end;

procedure TatADODBLibrary.__SetTCustomADODataSetFilterGroup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomADODataSet(CurrentObject).FilterGroup:=GetInputArg(0);
  end;
end;

procedure TatADODBLibrary.__GetTCustomADODataSetRecordsetState(AMachine: TatVirtualMachine);
var
PropValueSet: TObjectStates;
begin
  with AMachine do
  begin
    PropValueSet := TCustomADODataSet(CurrentObject).RecordsetState;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatADODBLibrary.__GetTCustomADODataSetRecordStatus(AMachine: TatVirtualMachine);
var
PropValueSet: TRecordStatusSet;
begin
  with AMachine do
  begin
    PropValueSet := TCustomADODataSet(CurrentObject).RecordStatus;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatADODBLibrary.__GetTCustomADODataSetSort(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomADODataSet(CurrentObject).Sort);
  end;
end;

procedure TatADODBLibrary.__SetTCustomADODataSetSort(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomADODataSet(CurrentObject).Sort:=GetInputArg(0);
  end;
end;

procedure TatADODBLibrary.__TADODataSetCreateDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TADODataSet(CurrentObject).CreateDataSet;
  end;
end;

procedure TatADODBLibrary.__TADODataSetGetIndexNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TADODataSet(CurrentObject).GetIndexNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatADODBLibrary.__TADOTableCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TADOTableClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TADOTableGetIndexNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TADOTable(CurrentObject).GetIndexNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatADODBLibrary.__TADOQueryCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TADOQueryClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TADOQueryDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TADOQuery(CurrentObject).Destroy;
  end;
end;

procedure TatADODBLibrary.__TADOQueryExecSQL(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TADOQuery(CurrentObject).ExecSQL);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__GetTADOQueryRowsAffected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TADOQuery(CurrentObject).RowsAffected));
  end;
end;

procedure TatADODBLibrary.__TADOStoredProcCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TADOStoredProcClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TADOStoredProcExecProc(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TADOStoredProc(CurrentObject).ExecProc;
  end;
end;

procedure TatADODBLibrary.__TADOBlobStreamCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TADOBlobStreamClass(CurrentClass.ClassRef).Create(TBlobField(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TADOBlobStreamDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TADOBlobStream(CurrentObject).Destroy;
  end;
end;

procedure TatADODBLibrary.__TADOBlobStreamWrite(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TADOBlobStream(CurrentObject).Write(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__TADOBlobStreamTruncate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TADOBlobStream(CurrentObject).Truncate;
  end;
end;

procedure TatADODBDispatcher.__TDisconnectEvent( Connection: TADOConnection; var EventStatus: TEventStatus);
var
  EventStatusTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TDisconnectEvent(BeforeCall)(Connection,EventStatus);
    EventStatusTemp := EventStatus;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Connection,EventStatusTemp]);
    EventStatus := EventStatusTemp;
    if AssignedMethod(AfterCall) then
      TDisconnectEvent(AfterCall)(Connection,EventStatus);
  end;
end;

procedure TatADODBDispatcher.__TWillConnectEvent( Connection: TADOConnection; var ConnectionString: WideString; var UserID: WideString; var Password: WideString; var ConnectOptions: TConnectOption; var EventStatus: TEventStatus);
var
  ConnectionStringTemp: variant;
  UserIDTemp: variant;
  PasswordTemp: variant;
  ConnectOptionsTemp: variant;
  EventStatusTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TWillConnectEvent(BeforeCall)(Connection,ConnectionString,UserID,Password,ConnectOptions,EventStatus);
    ConnectionStringTemp := ConnectionString;
    UserIDTemp := UserID;
    PasswordTemp := Password;
    ConnectOptionsTemp := ConnectOptions;
    EventStatusTemp := EventStatus;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Connection,ConnectionStringTemp,UserIDTemp,PasswordTemp,ConnectOptionsTemp,EventStatusTemp]);
    ConnectionString := ConnectionStringTemp;
    UserID := UserIDTemp;
    Password := PasswordTemp;
    ConnectOptions := ConnectOptionsTemp;
    EventStatus := EventStatusTemp;
    if AssignedMethod(AfterCall) then
      TWillConnectEvent(AfterCall)(Connection,ConnectionString,UserID,Password,ConnectOptions,EventStatus);
  end;
end;

procedure TatADODBDispatcher.__TWillChangeFieldEvent( DataSet: TCustomADODataSet; const FieldCount: Integer; const Fields: OleVariant; var EventStatus: TEventStatus);
var
  EventStatusTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TWillChangeFieldEvent(BeforeCall)(DataSet,FieldCount,Fields,EventStatus);
    EventStatusTemp := EventStatus;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [DataSet,FieldCount,Fields,EventStatusTemp]);
    EventStatus := EventStatusTemp;
    if AssignedMethod(AfterCall) then
      TWillChangeFieldEvent(AfterCall)(DataSet,FieldCount,Fields,EventStatus);
  end;
end;

procedure TatADODBDispatcher.__TWillChangeRecordEvent( DataSet: TCustomADODataSet; const Reason: TEventReason; const RecordCount: Integer; var EventStatus: TEventStatus);
var
  ReasonTemp: variant;
  EventStatusTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TWillChangeRecordEvent(BeforeCall)(DataSet,Reason,RecordCount,EventStatus);
    ReasonTemp := Reason;
    EventStatusTemp := EventStatus;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [DataSet,ReasonTemp,RecordCount,EventStatusTemp]);
    EventStatus := EventStatusTemp;
    if AssignedMethod(AfterCall) then
      TWillChangeRecordEvent(AfterCall)(DataSet,Reason,RecordCount,EventStatus);
  end;
end;

procedure TatADODBDispatcher.__TEndOfRecordsetEvent( DataSet: TCustomADODataSet; var MoreData: WordBool; var EventStatus: TEventStatus);
var
  MoreDataTemp: variant;
  EventStatusTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TEndOfRecordsetEvent(BeforeCall)(DataSet,MoreData,EventStatus);
    MoreDataTemp := MoreData;
    EventStatusTemp := EventStatus;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [DataSet,MoreDataTemp,EventStatusTemp]);
    MoreData := MoreDataTemp;
    EventStatus := EventStatusTemp;
    if AssignedMethod(AfterCall) then
      TEndOfRecordsetEvent(AfterCall)(DataSet,MoreData,EventStatus);
  end;
end;

procedure TatADODBDispatcher.__TFetchProgressEvent( DataSet: TCustomADODataSet;  Progress: Integer;  MaxProgress: Integer; var EventStatus: TEventStatus);
var
  EventStatusTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TFetchProgressEvent(BeforeCall)(DataSet,Progress,MaxProgress,EventStatus);
    EventStatusTemp := EventStatus;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [DataSet,Progress,MaxProgress,EventStatusTemp]);
    EventStatus := EventStatusTemp;
    if AssignedMethod(AfterCall) then
      TFetchProgressEvent(AfterCall)(DataSet,Progress,MaxProgress,EventStatus);
  end;
end;

procedure TatADODBDispatcher.__TRecordsetReasonEvent( DataSet: TCustomADODataSet; const Reason: TEventReason; var EventStatus: TEventStatus);
var
  ReasonTemp: variant;
  EventStatusTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TRecordsetReasonEvent(BeforeCall)(DataSet,Reason,EventStatus);
    ReasonTemp := Reason;
    EventStatusTemp := EventStatus;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [DataSet,ReasonTemp,EventStatusTemp]);
    EventStatus := EventStatusTemp;
    if AssignedMethod(AfterCall) then
      TRecordsetReasonEvent(AfterCall)(DataSet,Reason,EventStatus);
  end;
end;

procedure TatADODBLibrary.__CreateUDLFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ADODB.CreateUDLFile(GetInputArg(0),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatADODBLibrary.__DataLinkDir(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ADODB.DataLinkDir;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__GetProviderNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ADODB.GetProviderNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatADODBLibrary.__PromptDataSource(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ADODB.PromptDataSource(VarToInteger(GetInputArg(0)),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__PromptDataLinkFile(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ADODB.PromptDataLinkFile(VarToInteger(GetInputArg(0)),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.__GetDataLinkFiles(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(ADODB.GetDataLinkFiles(TStrings(Integer(GetInputArg(0)))));
2: AResult := Integer(ADODB.GetDataLinkFiles(TStrings(Integer(GetInputArg(0))),GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatADODBLibrary.Init;
begin
  With Scripter.DefineClass(EADOError) do
  begin
  end;
  With Scripter.DefineClass(TADOConnection) do
  begin
    DefineMethod('Create',1,tkClass,TADOConnection,__TADOConnectionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TADOConnectionDestroy,false,0);
    DefineMethod('BeginTrans',0,tkInteger,nil,__TADOConnectionBeginTrans,false,0);
    DefineMethod('Cancel',0,tkNone,nil,__TADOConnectionCancel,false,0);
    DefineMethod('CommitTrans',0,tkNone,nil,__TADOConnectionCommitTrans,false,0);
    DefineMethod('GetProcedureNames',1,tkNone,nil,__TADOConnectionGetProcedureNames,false,0);
    DefineMethod('GetFieldNames',2,tkNone,nil,__TADOConnectionGetFieldNames,false,0);
    DefineMethod('GetTableNames',2,tkNone,nil,__TADOConnectionGetTableNames,false,1);
    DefineMethod('OpenSchema',4,tkNone,nil,__TADOConnectionOpenSchema,false,0);
    DefineMethod('RollbackTrans',0,tkNone,nil,__TADOConnectionRollbackTrans,false,0);
    DefineProp('CommandCount',tkInteger,__GetTADOConnectionCommandCount,nil,nil,false,0);
    DefineProp('Commands',tkClass,__GetTADOConnectionCommands,nil,TADOCommand,false,1);
    DefineProp('DataSets',tkClass,__GetTADOConnectionDataSets,nil,TCustomADODataSet,false,1);
    DefineProp('InTransaction',tkVariant,__GetTADOConnectionInTransaction,nil,nil,false,0);
    DefineProp('State',tkInteger,__GetTADOConnectionState,nil,nil,false,0);
    DefineProp('Version',tkVariant,__GetTADOConnectionVersion,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRDSConnection) do
  begin
    DefineMethod('Create',1,tkClass,TRDSConnection,__TRDSConnectionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TRDSConnectionDestroy,false,0);
    DefineProp('AppServer',tkVariant,__GetTRDSConnectionAppServer,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TParameter) do
  begin
    DefineMethod('Assign',1,tkNone,nil,__TParameterAssign,false,0);
    DefineMethod('AppendChunk',1,tkNone,nil,__TParameterAppendChunk,false,0);
    DefineMethod('LoadFromFile',2,tkNone,nil,__TParameterLoadFromFile,false,0);
    DefineMethod('LoadFromStream',2,tkNone,nil,__TParameterLoadFromStream,false,0);
    DefineProp('Parameters',tkClass,__GetTParameterParameters,nil,TParameters,false,0);
  end;
  With Scripter.DefineClass(TParameters) do
  begin
    DefineMethod('AddParameter',0,tkClass,TParameter,__TParametersAddParameter,false,0);
    DefineMethod('AssignValues',1,tkNone,nil,__TParametersAssignValues,false,0);
    DefineMethod('CreateParameter',5,tkClass,TParameter,__TParametersCreateParameter,false,0);
    DefineMethod('FindParam',1,tkClass,TParameter,__TParametersFindParam,false,0);
    DefineMethod('GetParamList',2,tkNone,nil,__TParametersGetParamList,false,0);
    DefineMethod('IsEqual',1,tkVariant,nil,__TParametersIsEqual,false,0);
    DefineMethod('ParamByName',1,tkClass,TParameter,__TParametersParamByName,false,0);
    DefineMethod('ParseSQL',2,tkVariant,nil,__TParametersParseSQL,false,0);
    DefineMethod('Refresh',0,tkVariant,nil,__TParametersRefresh,false,0);
    DefineProp('ParamValues',tkVariant,__GetTParametersParamValues,__SetTParametersParamValues,nil,false,1);
    DefineProp('Command',tkClass,__GetTParametersCommand,nil,TADOCommand,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTParametersItems,__SetTParametersItems,TParameter,false,1);
  end;
  With Scripter.DefineClass(TADOCommand) do
  begin
    DefineMethod('Create',1,tkClass,TADOCommand,__TADOCommandCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TADOCommandDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TADOCommandAssign,false,0);
    DefineMethod('Cancel',0,tkNone,nil,__TADOCommandCancel,false,0);
    DefineProp('States',tkInteger,__GetTADOCommandStates,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomADODataSet) do
  begin
    DefineMethod('Create',1,tkClass,TCustomADODataSet,__TCustomADODataSetCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomADODataSetDestroy,false,0);
    DefineMethod('CancelBatch',1,tkNone,nil,__TCustomADODataSetCancelBatch,false,1);
    DefineMethod('CancelUpdates',0,tkNone,nil,__TCustomADODataSetCancelUpdates,false,0);
    DefineMethod('Clone',2,tkNone,nil,__TCustomADODataSetClone,false,1);
    DefineMethod('CreateBlobStream',2,tkClass,TStream,__TCustomADODataSetCreateBlobStream,false,0);
    DefineMethod('DeleteRecords',1,tkNone,nil,__TCustomADODataSetDeleteRecords,false,1);
    DefineMethod('IsSequenced',0,tkVariant,nil,__TCustomADODataSetIsSequenced,false,0);
    DefineMethod('LoadFromFile',1,tkNone,nil,__TCustomADODataSetLoadFromFile,false,0);
    DefineMethod('Locate',3,tkVariant,nil,__TCustomADODataSetLocate,false,0);
    DefineMethod('Lookup',3,tkVariant,nil,__TCustomADODataSetLookup,false,0);
    DefineMethod('Requery',1,tkNone,nil,__TCustomADODataSetRequery,false,1);
    DefineMethod('SaveToFile',2,tkNone,nil,__TCustomADODataSetSaveToFile,false,2);
    DefineMethod('Seek',2,tkVariant,nil,__TCustomADODataSetSeek,false,1);
    DefineMethod('Supports',1,tkVariant,nil,__TCustomADODataSetSupports,false,0);
    DefineMethod('UpdateBatch',1,tkNone,nil,__TCustomADODataSetUpdateBatch,false,1);
    DefineMethod('UpdateStatus',0,tkEnumeration,nil,__TCustomADODataSetUpdateStatus,false,0);
    DefineProp('EnableBCD',tkVariant,__GetTCustomADODataSetEnableBCD,__SetTCustomADODataSetEnableBCD,nil,false,0);
    DefineProp('DesignerData',tkVariant,__GetTCustomADODataSetDesignerData,__SetTCustomADODataSetDesignerData,nil,false,0);
    DefineProp('IndexName',tkVariant,__GetTCustomADODataSetIndexName,__SetTCustomADODataSetIndexName,nil,false,0);
    DefineProp('IndexFieldCount',tkInteger,__GetTCustomADODataSetIndexFieldCount,nil,nil,false,0);
    DefineProp('IndexFields',tkClass,__GetTCustomADODataSetIndexFields,__SetTCustomADODataSetIndexFields,TField,false,1);
    DefineProp('FilterGroup',tkEnumeration,__GetTCustomADODataSetFilterGroup,__SetTCustomADODataSetFilterGroup,nil,false,0);
    DefineProp('RecordsetState',tkInteger,__GetTCustomADODataSetRecordsetState,nil,nil,false,0);
    DefineProp('RecordStatus',tkInteger,__GetTCustomADODataSetRecordStatus,nil,nil,false,0);
    DefineProp('Sort',tkVariant,__GetTCustomADODataSetSort,__SetTCustomADODataSetSort,nil,false,0);
  end;
  With Scripter.DefineClass(TADODataSet) do
  begin
    DefineMethod('CreateDataSet',0,tkNone,nil,__TADODataSetCreateDataSet,false,0);
    DefineMethod('GetIndexNames',1,tkNone,nil,__TADODataSetGetIndexNames,false,0);
    DefineProp('IndexDefs',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TADOTable) do
  begin
    DefineMethod('Create',1,tkClass,TADOTable,__TADOTableCreate,true,0);
    DefineMethod('GetIndexNames',1,tkNone,nil,__TADOTableGetIndexNames,false,0);
    DefineProp('IndexDefs',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TADOQuery) do
  begin
    DefineMethod('Create',1,tkClass,TADOQuery,__TADOQueryCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TADOQueryDestroy,false,0);
    DefineMethod('ExecSQL',0,tkInteger,nil,__TADOQueryExecSQL,false,0);
    DefineProp('RowsAffected',tkInteger,__GetTADOQueryRowsAffected,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TADOStoredProc) do
  begin
    DefineMethod('Create',1,tkClass,TADOStoredProc,__TADOStoredProcCreate,true,0);
    DefineMethod('ExecProc',0,tkNone,nil,__TADOStoredProcExecProc,false,0);
  end;
  With Scripter.DefineClass(TADOBlobStream) do
  begin
    DefineMethod('Create',2,tkClass,TADOBlobStream,__TADOBlobStreamCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TADOBlobStreamDestroy,false,0);
    DefineMethod('Write',2,tkInteger,nil,__TADOBlobStreamWrite,false,0);
    DefineMethod('Truncate',0,tkNone,nil,__TADOBlobStreamTruncate,false,0);
  end;
  DefineEventAdapter(TypeInfo(TDisconnectEvent), TatADODBDispatcher, @TatADODBDispatcher.__TDisconnectEvent);
  DefineEventAdapter(TypeInfo(TWillConnectEvent), TatADODBDispatcher, @TatADODBDispatcher.__TWillConnectEvent);
  DefineEventAdapter(TypeInfo(TWillChangeFieldEvent), TatADODBDispatcher, @TatADODBDispatcher.__TWillChangeFieldEvent);
  DefineEventAdapter(TypeInfo(TWillChangeRecordEvent), TatADODBDispatcher, @TatADODBDispatcher.__TWillChangeRecordEvent);
  DefineEventAdapter(TypeInfo(TEndOfRecordsetEvent), TatADODBDispatcher, @TatADODBDispatcher.__TEndOfRecordsetEvent);
  DefineEventAdapter(TypeInfo(TFetchProgressEvent), TatADODBDispatcher, @TatADODBDispatcher.__TFetchProgressEvent);
  DefineEventAdapter(TypeInfo(TRecordsetReasonEvent), TatADODBDispatcher, @TatADODBDispatcher.__TRecordsetReasonEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('CreateUDLFile',3,tkNone,nil,__CreateUDLFile,false,0);
    DefineMethod('DataLinkDir',0,tkVariant,nil,__DataLinkDir,false,0);
    DefineMethod('GetProviderNames',1,tkNone,nil,__GetProviderNames,false,0);
    DefineMethod('PromptDataSource',2,tkVariant,nil,__PromptDataSource,false,0);
    DefineMethod('PromptDataLinkFile',2,tkVariant,nil,__PromptDataLinkFile,false,0);
    DefineMethod('GetDataLinkFiles',2,tkInteger,nil,__GetDataLinkFiles,false,1);
    AddConstant('cmUnknown',cmUnknown);
    AddConstant('cmRead',cmRead);
    AddConstant('cmWrite',cmWrite);
    AddConstant('cmReadWrite',cmReadWrite);
    AddConstant('cmShareDenyRead',cmShareDenyRead);
    AddConstant('cmShareDenyWrite',cmShareDenyWrite);
    AddConstant('cmShareExclusive',cmShareExclusive);
    AddConstant('cmShareDenyNone',cmShareDenyNone);
    AddConstant('coConnectUnspecified',coConnectUnspecified);
    AddConstant('coAsyncConnect',coAsyncConnect);
    AddConstant('clUseServer',clUseServer);
    AddConstant('clUseClient',clUseClient);
    AddConstant('ctUnspecified',ctUnspecified);
    AddConstant('ctOpenForwardOnly',ctOpenForwardOnly);
    AddConstant('ctKeyset',ctKeyset);
    AddConstant('ctDynamic',ctDynamic);
    AddConstant('ctStatic',ctStatic);
    AddConstant('esOK',esOK);
    AddConstant('esErrorsOccured',esErrorsOccured);
    AddConstant('esCantDeny',esCantDeny);
    AddConstant('esCancel',esCancel);
    AddConstant('esUnwantedEvent',esUnwantedEvent);
    AddConstant('eoAsyncExecute',eoAsyncExecute);
    AddConstant('eoAsyncFetch',eoAsyncFetch);
    AddConstant('eoAsyncFetchNonBlocking',eoAsyncFetchNonBlocking);
    AddConstant('eoExecuteNoRecords',eoExecuteNoRecords);
    AddConstant('ilUnspecified',ilUnspecified);
    AddConstant('ilChaos',ilChaos);
    AddConstant('ilReadUncommitted',ilReadUncommitted);
    AddConstant('ilBrowse',ilBrowse);
    AddConstant('ilCursorStability',ilCursorStability);
    AddConstant('ilReadCommitted',ilReadCommitted);
    AddConstant('ilRepeatableRead',ilRepeatableRead);
    AddConstant('ilSerializable',ilSerializable);
    AddConstant('ilIsolated',ilIsolated);
    AddConstant('ltUnspecified',ltUnspecified);
    AddConstant('ltReadOnly',ltReadOnly);
    AddConstant('ltPessimistic',ltPessimistic);
    AddConstant('ltOptimistic',ltOptimistic);
    AddConstant('ltBatchOptimistic',ltBatchOptimistic);
    AddConstant('stClosed',stClosed);
    AddConstant('stOpen',stOpen);
    AddConstant('stConnecting',stConnecting);
    AddConstant('stExecuting',stExecuting);
    AddConstant('stFetching',stFetching);
    AddConstant('siAsserts',siAsserts);
    AddConstant('siCatalogs',siCatalogs);
    AddConstant('siCharacterSets',siCharacterSets);
    AddConstant('siCollations',siCollations);
    AddConstant('siColumns',siColumns);
    AddConstant('siCheckConstraints',siCheckConstraints);
    AddConstant('siConstraintColumnUsage',siConstraintColumnUsage);
    AddConstant('siConstraintTableUsage',siConstraintTableUsage);
    AddConstant('siKeyColumnUsage',siKeyColumnUsage);
    AddConstant('siReferentialConstraints',siReferentialConstraints);
    AddConstant('siTableConstraints',siTableConstraints);
    AddConstant('siColumnsDomainUsage',siColumnsDomainUsage);
    AddConstant('siIndexes',siIndexes);
    AddConstant('siColumnPrivileges',siColumnPrivileges);
    AddConstant('siTablePrivileges',siTablePrivileges);
    AddConstant('siUsagePrivileges',siUsagePrivileges);
    AddConstant('siProcedures',siProcedures);
    AddConstant('siSchemata',siSchemata);
    AddConstant('siSQLLanguages',siSQLLanguages);
    AddConstant('siStatistics',siStatistics);
    AddConstant('siTables',siTables);
    AddConstant('siTranslations',siTranslations);
    AddConstant('siProviderTypes',siProviderTypes);
    AddConstant('siViews',siViews);
    AddConstant('siViewColumnUsage',siViewColumnUsage);
    AddConstant('siViewTableUsage',siViewTableUsage);
    AddConstant('siProcedureParameters',siProcedureParameters);
    AddConstant('siForeignKeys',siForeignKeys);
    AddConstant('siPrimaryKeys',siPrimaryKeys);
    AddConstant('siProcedureColumns',siProcedureColumns);
    AddConstant('siDBInfoKeywords',siDBInfoKeywords);
    AddConstant('siDBInfoLiterals',siDBInfoLiterals);
    AddConstant('siCubes',siCubes);
    AddConstant('siDimensions',siDimensions);
    AddConstant('siHierarchies',siHierarchies);
    AddConstant('siLevels',siLevels);
    AddConstant('siMeasures',siMeasures);
    AddConstant('siProperties',siProperties);
    AddConstant('siMembers',siMembers);
    AddConstant('siProviderSpecific',siProviderSpecific);
    AddConstant('xaCommitRetaining',xaCommitRetaining);
    AddConstant('xaAbortRetaining',xaAbortRetaining);
    AddConstant('cmdUnknown',cmdUnknown);
    AddConstant('cmdText',cmdText);
    AddConstant('cmdTable',cmdTable);
    AddConstant('cmdStoredProc',cmdStoredProc);
    AddConstant('cmdFile',cmdFile);
    AddConstant('cmdTableDirect',cmdTableDirect);
    AddConstant('paSigned',paSigned);
    AddConstant('paNullable',paNullable);
    AddConstant('paLong',paLong);
    AddConstant('pdUnknown',pdUnknown);
    AddConstant('pdInput',pdInput);
    AddConstant('pdOutput',pdOutput);
    AddConstant('pdInputOutput',pdInputOutput);
    AddConstant('pdReturnValue',pdReturnValue);
    AddConstant('coHoldRecords',coHoldRecords);
    AddConstant('coMovePrevious',coMovePrevious);
    AddConstant('coAddNew',coAddNew);
    AddConstant('coDelete',coDelete);
    AddConstant('coUpdate',coUpdate);
    AddConstant('coBookmark',coBookmark);
    AddConstant('coApproxPosition',coApproxPosition);
    AddConstant('coUpdateBatch',coUpdateBatch);
    AddConstant('coResync',coResync);
    AddConstant('coNotify',coNotify);
    AddConstant('coFind',coFind);
    AddConstant('coSeek',coSeek);
    AddConstant('coIndex',coIndex);
    AddConstant('erAddNew',erAddNew);
    AddConstant('erDelete',erDelete);
    AddConstant('erUpdate',erUpdate);
    AddConstant('erUndoUpdate',erUndoUpdate);
    AddConstant('erUndoAddNew',erUndoAddNew);
    AddConstant('erUndoDelete',erUndoDelete);
    AddConstant('erRequery',erRequery);
    AddConstant('erResynch',erResynch);
    AddConstant('erClose',erClose);
    AddConstant('erMove',erMove);
    AddConstant('erFirstChange',erFirstChange);
    AddConstant('erMoveFirst',erMoveFirst);
    AddConstant('erMoveNext',erMoveNext);
    AddConstant('erMovePrevious',erMovePrevious);
    AddConstant('erMoveLast',erMoveLast);
    AddConstant('fgUnassigned',fgUnassigned);
    AddConstant('fgNone',fgNone);
    AddConstant('fgPendingRecords',fgPendingRecords);
    AddConstant('fgAffectedRecords',fgAffectedRecords);
    AddConstant('fgFetchedRecords',fgFetchedRecords);
    AddConstant('fgPredicate',fgPredicate);
    AddConstant('fgConflictingRecords',fgConflictingRecords);
    AddConstant('moMarshalAll',moMarshalAll);
    AddConstant('moMarshalModifiedOnly',moMarshalModifiedOnly);
    AddConstant('rsOK',rsOK);
    AddConstant('rsNew',rsNew);
    AddConstant('rsModified',rsModified);
    AddConstant('rsDeleted',rsDeleted);
    AddConstant('rsUnmodified',rsUnmodified);
    AddConstant('rsInvalid',rsInvalid);
    AddConstant('rsMultipleChanges',rsMultipleChanges);
    AddConstant('rsPendingChanges',rsPendingChanges);
    AddConstant('rsCanceled',rsCanceled);
    AddConstant('rsCantRelease',rsCantRelease);
    AddConstant('rsConcurrencyViolation',rsConcurrencyViolation);
    AddConstant('rsIntegrityViolation',rsIntegrityViolation);
    AddConstant('rsMaxChangesExceeded',rsMaxChangesExceeded);
    AddConstant('rsObjectOpen',rsObjectOpen);
    AddConstant('rsOutOfMemory',rsOutOfMemory);
    AddConstant('rsPermissionDenied',rsPermissionDenied);
    AddConstant('rsSchemaViolation',rsSchemaViolation);
    AddConstant('rsDBDeleted',rsDBDeleted);
    AddConstant('arCurrent',arCurrent);
    AddConstant('arFiltered',arFiltered);
    AddConstant('arAll',arAll);
    AddConstant('arAllChapters',arAllChapters);
    AddConstant('pfADTG',pfADTG);
    AddConstant('pfXML',pfXML);
    AddConstant('soFirstEQ',soFirstEQ);
    AddConstant('soLastEQ',soLastEQ);
    AddConstant('soAfterEQ',soAfterEQ);
    AddConstant('soAfter',soAfter);
    AddConstant('soBeforeEQ',soBeforeEQ);
    AddConstant('soBefore',soBefore);
  end;
end;

class function TatADODBLibrary.LibraryName: string;
begin
  result := 'ADODB';
end;

initialization
  RegisterScripterLibrary(TatADODBLibrary, True);

{$WARNINGS ON}

end.

