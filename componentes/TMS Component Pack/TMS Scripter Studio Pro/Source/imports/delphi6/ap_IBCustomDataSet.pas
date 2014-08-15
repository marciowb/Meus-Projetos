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
unit ap_IBCustomDataSet;

interface

uses
  SysUtils,
  Classes,
  Variants,
  Windows,
  IBExternals,
  IB,
  IBHeader,
  IBDatabase,
  IBSQL,
  Db,
  IBUtils,
  IBBlob,
  IBCustomDataSet,
  atScript;

{$WARNINGS OFF}

type
  TatIBCustomDataSetLibrary = class(TatScripterLibrary)
    procedure __TIBDataSetUpdateObjectCreate(AMachine: TatVirtualMachine);
    procedure __TIBDataSetUpdateObjectDestroy(AMachine: TatVirtualMachine);
    procedure __TIBStringFieldcreate(AMachine: TatVirtualMachine);
    procedure __TIBStringFieldCheckTypeSize(AMachine: TatVirtualMachine);
    procedure __TIBStringFieldGetAsString(AMachine: TatVirtualMachine);
    procedure __TIBStringFieldGetAsVariant(AMachine: TatVirtualMachine);
    procedure __TIBStringFieldGetValue(AMachine: TatVirtualMachine);
    procedure __TIBStringFieldSetAsString(AMachine: TatVirtualMachine);
    procedure __TIBBCDFieldCreate(AMachine: TatVirtualMachine);
    procedure __TIBDataLinkCreate(AMachine: TatVirtualMachine);
    procedure __TIBDataLinkDestroy(AMachine: TatVirtualMachine);
    procedure __TIBGeneratorFieldCreate(AMachine: TatVirtualMachine);
    procedure __TIBGeneratorFieldValueName(AMachine: TatVirtualMachine);
    procedure __TIBGeneratorFieldApply(AMachine: TatVirtualMachine);
    procedure __TIBGeneratorFieldAssign(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetCreate(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetDestroy(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetApplyUpdates(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetCachedUpdateStatus(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetCancelUpdates(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetFetchAll(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetLocateNext(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetRecordModified(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetRevertRecord(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetUndelete(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetPost(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetCurrent(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetSQLType(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetCreateBlobStream(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetGetCurrentRecord(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetLocate(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetLookup(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetUpdateStatus(AMachine: TatVirtualMachine);
    procedure __TIBCustomDataSetIsSequenced(AMachine: TatVirtualMachine);
    procedure __GetTIBCustomDataSetUpdateObject(AMachine: TatVirtualMachine);
    procedure __SetTIBCustomDataSetUpdateObject(AMachine: TatVirtualMachine);
    procedure __GetTIBCustomDataSetUpdatesPending(AMachine: TatVirtualMachine);
    procedure __GetTIBCustomDataSetUpdateRecordTypes(AMachine: TatVirtualMachine);
    procedure __SetTIBCustomDataSetUpdateRecordTypes(AMachine: TatVirtualMachine);
    procedure __GetTIBCustomDataSetRowsAffected(AMachine: TatVirtualMachine);
    procedure __GetTIBCustomDataSetPlan(AMachine: TatVirtualMachine);
    procedure __TIBDataSetPrepare(AMachine: TatVirtualMachine);
    procedure __TIBDataSetUnPrepare(AMachine: TatVirtualMachine);
    procedure __TIBDataSetBatchInput(AMachine: TatVirtualMachine);
    procedure __TIBDataSetBatchOutput(AMachine: TatVirtualMachine);
    procedure __TIBDataSetExecSQL(AMachine: TatVirtualMachine);
    procedure __TIBDataSetParamByName(AMachine: TatVirtualMachine);
    procedure __GetTIBDataSetPrepared(AMachine: TatVirtualMachine);
    procedure __TIBDSBlobStreamCreate(AMachine: TatVirtualMachine);
    procedure __TIBDSBlobStreamDestroy(AMachine: TatVirtualMachine);
    procedure __TIBDSBlobStreamRead(AMachine: TatVirtualMachine);
    procedure __TIBDSBlobStreamSeek(AMachine: TatVirtualMachine);
    procedure __TIBDSBlobStreamSetSize(AMachine: TatVirtualMachine);
    procedure __TIBDSBlobStreamWrite(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBDataSetUpdateObjectClass = class of TIBDataSetUpdateObject;
  TIBStringFieldClass = class of TIBStringField;
  TIBBCDFieldClass = class of TIBBCDField;
  TIBDataLinkClass = class of TIBDataLink;
  TIBGeneratorFieldClass = class of TIBGeneratorField;
  TIBCustomDataSetClass = class of TIBCustomDataSet;
  TIBDataSetClass = class of TIBDataSet;
  TIBDSBlobStreamClass = class of TIBDSBlobStream;

  TatIBCustomDataSetDispatcher = class(TatEventDispatcher)
  private
    procedure __TIBUpdateErrorEvent( DataSet: TDataSet;  E: EDatabaseError;  UpdateKind: TUpdateKind; var UpdateAction: TIBUpdateAction);
    procedure __TIBUpdateRecordEvent( DataSet: TDataSet;  UpdateKind: TUpdateKind; var UpdateAction: TIBUpdateAction);
  end;

  TFieldDataWrapper = class(TatRecordWrapper)
  private
    FfdDataType: Short;
    FfdDataScale: Short;
    FfdNullable: Boolean;
    FfdIsNull: Boolean;
    FfdDataSize: Short;
    FfdDataLength: Short;
    FfdDataOfs: Integer;
  public
    constructor Create(ARecord: TFieldData);
    function ObjToRec: TFieldData;
  published
    property fdDataType: Short read FfdDataType write FfdDataType;
    property fdDataScale: Short read FfdDataScale write FfdDataScale;
    property fdNullable: Boolean read FfdNullable write FfdNullable;
    property fdIsNull: Boolean read FfdIsNull write FfdIsNull;
    property fdDataSize: Short read FfdDataSize write FfdDataSize;
    property fdDataLength: Short read FfdDataLength write FfdDataLength;
    property fdDataOfs: Integer read FfdDataOfs write FfdDataOfs;
  end;
  
  TIBDBKeyWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TIBDBKey);
    function ObjToRec: TIBDBKey;
  published
  end;
  
  TRecordDataWrapper = class(TatRecordWrapper)
  private
    FrdBookmarkFlag: TBookmarkFlag;
    FrdFieldCount: Short;
    FrdRecordNumber: Long;
    FrdCachedUpdateStatus: TCachedUpdateStatus;
    FrdUpdateStatus: TUpdateStatus;
    FrdSavedOffset: DWORD;
  public
    constructor Create(ARecord: TRecordData);
    function ObjToRec: TRecordData;
  published
    property rdBookmarkFlag: TBookmarkFlag read FrdBookmarkFlag write FrdBookmarkFlag;
    property rdFieldCount: Short read FrdFieldCount write FrdFieldCount;
    property rdRecordNumber: Long read FrdRecordNumber write FrdRecordNumber;
    property rdCachedUpdateStatus: TCachedUpdateStatus read FrdCachedUpdateStatus write FrdCachedUpdateStatus;
    property rdUpdateStatus: TUpdateStatus read FrdUpdateStatus write FrdUpdateStatus;
    property rdSavedOffset: DWORD read FrdSavedOffset write FrdSavedOffset;
  end;
  

implementation

constructor TFieldDataWrapper.Create(ARecord: TFieldData);
begin
  inherited Create;
  FfdDataType := ARecord.fdDataType;
  FfdDataScale := ARecord.fdDataScale;
  FfdNullable := ARecord.fdNullable;
  FfdIsNull := ARecord.fdIsNull;
  FfdDataSize := ARecord.fdDataSize;
  FfdDataLength := ARecord.fdDataLength;
  FfdDataOfs := ARecord.fdDataOfs;
end;

function TFieldDataWrapper.ObjToRec: TFieldData;
begin
  result.fdDataType := FfdDataType;
  result.fdDataScale := FfdDataScale;
  result.fdNullable := FfdNullable;
  result.fdIsNull := FfdIsNull;
  result.fdDataSize := FfdDataSize;
  result.fdDataLength := FfdDataLength;
  result.fdDataOfs := FfdDataOfs;
end;

constructor TIBDBKeyWrapper.Create(ARecord: TIBDBKey);
begin
  inherited Create;
end;

function TIBDBKeyWrapper.ObjToRec: TIBDBKey;
begin
end;

constructor TRecordDataWrapper.Create(ARecord: TRecordData);
begin
  inherited Create;
  FrdBookmarkFlag := ARecord.rdBookmarkFlag;
  FrdFieldCount := ARecord.rdFieldCount;
  FrdRecordNumber := ARecord.rdRecordNumber;
  FrdCachedUpdateStatus := ARecord.rdCachedUpdateStatus;
  FrdUpdateStatus := ARecord.rdUpdateStatus;
  FrdSavedOffset := ARecord.rdSavedOffset;
end;

function TRecordDataWrapper.ObjToRec: TRecordData;
begin
  result.rdBookmarkFlag := FrdBookmarkFlag;
  result.rdFieldCount := FrdFieldCount;
  result.rdRecordNumber := FrdRecordNumber;
  result.rdCachedUpdateStatus := FrdCachedUpdateStatus;
  result.rdUpdateStatus := FrdUpdateStatus;
  result.rdSavedOffset := FrdSavedOffset;
end;



procedure TatIBCustomDataSetLibrary.__TIBDataSetUpdateObjectCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBDataSetUpdateObjectClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBDataSetUpdateObjectDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDataSetUpdateObject(CurrentObject).Destroy;
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBStringFieldcreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBStringFieldClass(CurrentClass.ClassRef).create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBStringFieldCheckTypeSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBStringFieldClass(CurrentClass.ClassRef).CheckTypeSize(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBStringFieldGetAsString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBStringField(CurrentObject).GetAsString;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBStringFieldGetAsVariant(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBStringField(CurrentObject).GetAsVariant;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBStringFieldGetValue(AMachine: TatVirtualMachine);
  var
  Param0: string;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := TIBStringField(CurrentObject).GetValue(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBStringFieldSetAsString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBStringField(CurrentObject).SetAsString(GetInputArg(0));
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBBCDFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBBCDFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBDataLinkCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBDataLinkClass(CurrentClass.ClassRef).Create(TIBCustomDataSet(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBDataLinkDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDataLink(CurrentObject).Destroy;
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBGeneratorFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBGeneratorFieldClass(CurrentClass.ClassRef).Create(TIBCustomDataSet(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBGeneratorFieldValueName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBGeneratorField(CurrentObject).ValueName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBGeneratorFieldApply(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBGeneratorField(CurrentObject).Apply;
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBGeneratorFieldAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBGeneratorField(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBCustomDataSetClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBCustomDataSet(CurrentObject).Destroy;
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetApplyUpdates(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBCustomDataSet(CurrentObject).ApplyUpdates;
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetCachedUpdateStatus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBCustomDataSet(CurrentObject).CachedUpdateStatus;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetCancelUpdates(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBCustomDataSet(CurrentObject).CancelUpdates;
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetFetchAll(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBCustomDataSet(CurrentObject).FetchAll;
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetLocateNext(AMachine: TatVirtualMachine);
  var
  Param2: TLocateOptions;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := TIBCustomDataSet(CurrentObject).LocateNext(GetInputArg(0),GetInputArg(1),Param2);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetRecordModified(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBCustomDataSet(CurrentObject).RecordModified(GetInputArg(0));
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetRevertRecord(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBCustomDataSet(CurrentObject).RevertRecord;
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetUndelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBCustomDataSet(CurrentObject).Undelete;
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetPost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBCustomDataSet(CurrentObject).Post;
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetCurrent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBCustomDataSet(CurrentObject).Current);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetSQLType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBCustomDataSet(CurrentObject).SQLType;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetCreateBlobStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBCustomDataSet(CurrentObject).CreateBlobStream(TField(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetGetCurrentRecord(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBCustomDataSet(CurrentObject).GetCurrentRecord(PChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetLocate(AMachine: TatVirtualMachine);
  var
  Param2: TLocateOptions;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := TIBCustomDataSet(CurrentObject).Locate(GetInputArg(0),GetInputArg(1),Param2);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetLookup(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBCustomDataSet(CurrentObject).Lookup(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetUpdateStatus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBCustomDataSet(CurrentObject).UpdateStatus;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBCustomDataSetIsSequenced(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBCustomDataSet(CurrentObject).IsSequenced;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__GetTIBCustomDataSetUpdateObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBCustomDataSet(CurrentObject).UpdateObject));
  end;
end;

procedure TatIBCustomDataSetLibrary.__SetTIBCustomDataSetUpdateObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBCustomDataSet(CurrentObject).UpdateObject:=TIBDataSetUpdateObject(Integer(GetInputArg(0)));
  end;
end;

procedure TatIBCustomDataSetLibrary.__GetTIBCustomDataSetUpdatesPending(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBCustomDataSet(CurrentObject).UpdatesPending);
  end;
end;

procedure TatIBCustomDataSetLibrary.__GetTIBCustomDataSetUpdateRecordTypes(AMachine: TatVirtualMachine);
var
PropValueSet: TIBUpdateRecordTypes;
begin
  with AMachine do
  begin
    PropValueSet := TIBCustomDataSet(CurrentObject).UpdateRecordTypes;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatIBCustomDataSetLibrary.__SetTIBCustomDataSetUpdateRecordTypes(AMachine: TatVirtualMachine);
  var
  TempVar: TIBUpdateRecordTypes;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TIBCustomDataSet(CurrentObject).UpdateRecordTypes:=TempVar;
  end;
end;

procedure TatIBCustomDataSetLibrary.__GetTIBCustomDataSetRowsAffected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBCustomDataSet(CurrentObject).RowsAffected));
  end;
end;

procedure TatIBCustomDataSetLibrary.__GetTIBCustomDataSetPlan(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBCustomDataSet(CurrentObject).Plan);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBDataSetPrepare(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDataSet(CurrentObject).Prepare;
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBDataSetUnPrepare(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDataSet(CurrentObject).UnPrepare;
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBDataSetBatchInput(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDataSet(CurrentObject).BatchInput(TIBBatchInput(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBDataSetBatchOutput(AMachine: TatVirtualMachine);
  var
  Param0: TIBBatchOutput;
begin
  with AMachine do
  begin
Param0 := TIBBatchOutput(Integer(GetInputArg(0)));
    TIBDataSet(CurrentObject).BatchOutput(Param0);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBDataSetExecSQL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDataSet(CurrentObject).ExecSQL;
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBDataSetParamByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBDataSet(CurrentObject).ParamByName(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__GetTIBDataSetPrepared(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBDataSet(CurrentObject).Prepared);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBDSBlobStreamCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBDSBlobStreamClass(CurrentClass.ClassRef).Create(TField(Integer(GetInputArg(0))),TIBBlobStream(Integer(GetInputArg(1))),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBDSBlobStreamDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDSBlobStream(CurrentObject).Destroy;
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBDSBlobStreamRead(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TIBDSBlobStream(CurrentObject).Read(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBDSBlobStreamSeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBDSBlobStream(CurrentObject).Seek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBDSBlobStreamSetSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDSBlobStream(CurrentObject).SetSize(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatIBCustomDataSetLibrary.__TIBDSBlobStreamWrite(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TIBDSBlobStream(CurrentObject).Write(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBCustomDataSetDispatcher.__TIBUpdateErrorEvent( DataSet: TDataSet;  E: EDatabaseError;  UpdateKind: TUpdateKind; var UpdateAction: TIBUpdateAction);
var
  UpdateKindTemp: variant;
  UpdateActionTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TIBUpdateErrorEvent(BeforeCall)(DataSet,E,UpdateKind,UpdateAction);
    UpdateKindTemp := UpdateKind;
    UpdateActionTemp := UpdateAction;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [DataSet,E,UpdateKindTemp,UpdateActionTemp]);
    UpdateAction := UpdateActionTemp;
    if AssignedMethod(AfterCall) then
      TIBUpdateErrorEvent(AfterCall)(DataSet,E,UpdateKind,UpdateAction);
  end;
end;

procedure TatIBCustomDataSetDispatcher.__TIBUpdateRecordEvent( DataSet: TDataSet;  UpdateKind: TUpdateKind; var UpdateAction: TIBUpdateAction);
var
  UpdateKindTemp: variant;
  UpdateActionTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TIBUpdateRecordEvent(BeforeCall)(DataSet,UpdateKind,UpdateAction);
    UpdateKindTemp := UpdateKind;
    UpdateActionTemp := UpdateAction;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [DataSet,UpdateKindTemp,UpdateActionTemp]);
    UpdateAction := UpdateActionTemp;
    if AssignedMethod(AfterCall) then
      TIBUpdateRecordEvent(AfterCall)(DataSet,UpdateKind,UpdateAction);
  end;
end;

procedure TatIBCustomDataSetLibrary.Init;
begin
  With Scripter.DefineClass(TIBDataSetUpdateObject) do
  begin
    DefineMethod('Create',1,tkClass,TIBDataSetUpdateObject,__TIBDataSetUpdateObjectCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBDataSetUpdateObjectDestroy,false,0);
  end;
  With Scripter.DefineClass(TIBStringField) do
  begin
    DefineMethod('create',1,tkClass,TIBStringField,__TIBStringFieldcreate,true,0);
    DefineMethod('CheckTypeSize',1,tkNone,nil,__TIBStringFieldCheckTypeSize,true,0);
    DefineMethod('GetAsString',0,tkVariant,nil,__TIBStringFieldGetAsString,false,0);
    DefineMethod('GetAsVariant',0,tkVariant,nil,__TIBStringFieldGetAsVariant,false,0);
    DefineMethod('GetValue',1,tkVariant,nil,__TIBStringFieldGetValue,false,0).SetVarArgs([0]);
    DefineMethod('SetAsString',1,tkNone,nil,__TIBStringFieldSetAsString,false,0);
  end;
  With Scripter.DefineClass(TIBBCDField) do
  begin
    DefineMethod('Create',1,tkClass,TIBBCDField,__TIBBCDFieldCreate,true,0);
  end;
  With Scripter.DefineClass(TIBDataLink) do
  begin
    DefineMethod('Create',1,tkClass,TIBDataLink,__TIBDataLinkCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBDataLinkDestroy,false,0);
  end;
  With Scripter.DefineClass(TIBGeneratorField) do
  begin
    DefineMethod('Create',1,tkClass,TIBGeneratorField,__TIBGeneratorFieldCreate,true,0);
    DefineMethod('ValueName',0,tkVariant,nil,__TIBGeneratorFieldValueName,false,0);
    DefineMethod('Apply',0,tkNone,nil,__TIBGeneratorFieldApply,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TIBGeneratorFieldAssign,false,0);
  end;
  With Scripter.DefineClass(TIBCustomDataSet) do
  begin
    DefineMethod('Create',1,tkClass,TIBCustomDataSet,__TIBCustomDataSetCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBCustomDataSetDestroy,false,0);
    DefineMethod('ApplyUpdates',0,tkNone,nil,__TIBCustomDataSetApplyUpdates,false,0);
    DefineMethod('CachedUpdateStatus',0,tkEnumeration,nil,__TIBCustomDataSetCachedUpdateStatus,false,0);
    DefineMethod('CancelUpdates',0,tkNone,nil,__TIBCustomDataSetCancelUpdates,false,0);
    DefineMethod('FetchAll',0,tkNone,nil,__TIBCustomDataSetFetchAll,false,0);
    DefineMethod('LocateNext',3,tkVariant,nil,__TIBCustomDataSetLocateNext,false,0);
    DefineMethod('RecordModified',1,tkNone,nil,__TIBCustomDataSetRecordModified,false,0);
    DefineMethod('RevertRecord',0,tkNone,nil,__TIBCustomDataSetRevertRecord,false,0);
    DefineMethod('Undelete',0,tkNone,nil,__TIBCustomDataSetUndelete,false,0);
    DefineMethod('Post',0,tkNone,nil,__TIBCustomDataSetPost,false,0);
    DefineMethod('Current',0,tkClass,TIBXSQLDA,__TIBCustomDataSetCurrent,false,0);
    DefineMethod('SQLType',0,tkEnumeration,nil,__TIBCustomDataSetSQLType,false,0);
    DefineMethod('CreateBlobStream',2,tkClass,TStream,__TIBCustomDataSetCreateBlobStream,false,0);
    DefineMethod('GetCurrentRecord',1,tkVariant,nil,__TIBCustomDataSetGetCurrentRecord,false,0);
    DefineMethod('Locate',3,tkVariant,nil,__TIBCustomDataSetLocate,false,0);
    DefineMethod('Lookup',3,tkVariant,nil,__TIBCustomDataSetLookup,false,0);
    DefineMethod('UpdateStatus',0,tkEnumeration,nil,__TIBCustomDataSetUpdateStatus,false,0);
    DefineMethod('IsSequenced',0,tkVariant,nil,__TIBCustomDataSetIsSequenced,false,0);
    DefineProp('UpdateObject',tkClass,__GetTIBCustomDataSetUpdateObject,__SetTIBCustomDataSetUpdateObject,TIBDataSetUpdateObject,false,0);
    DefineProp('UpdatesPending',tkVariant,__GetTIBCustomDataSetUpdatesPending,nil,nil,false,0);
    DefineProp('UpdateRecordTypes',tkInteger,__GetTIBCustomDataSetUpdateRecordTypes,__SetTIBCustomDataSetUpdateRecordTypes,nil,false,0);
    DefineProp('RowsAffected',tkInteger,__GetTIBCustomDataSetRowsAffected,nil,nil,false,0);
    DefineProp('Plan',tkVariant,__GetTIBCustomDataSetPlan,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TIBDataSet) do
  begin
    DefineMethod('Prepare',0,tkNone,nil,__TIBDataSetPrepare,false,0);
    DefineMethod('UnPrepare',0,tkNone,nil,__TIBDataSetUnPrepare,false,0);
    DefineMethod('BatchInput',1,tkNone,nil,__TIBDataSetBatchInput,false,0);
    DefineMethod('BatchOutput',1,tkNone,nil,__TIBDataSetBatchOutput,false,0).SetVarArgs([0]);
    DefineMethod('ExecSQL',0,tkNone,nil,__TIBDataSetExecSQL,false,0);
    DefineMethod('ParamByName',1,tkClass,TIBXSQLVAR,__TIBDataSetParamByName,false,0);
    DefineProp('Params',tkVariant,nil,nil,nil,false,0);
    DefineProp('Prepared',tkVariant,__GetTIBDataSetPrepared,nil,nil,false,0);
    DefineProp('StatementType',tkVariant,nil,nil,nil,false,0);
    DefineProp('SelectStmtHandle',tkVariant,nil,nil,nil,false,0);
    DefineProp('LiveMode',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TIBDSBlobStream) do
  begin
    DefineMethod('Create',3,tkClass,TIBDSBlobStream,__TIBDSBlobStreamCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBDSBlobStreamDestroy,false,0);
    DefineMethod('Read',2,tkInteger,nil,__TIBDSBlobStreamRead,false,0).SetVarArgs([0]);
    DefineMethod('Seek',2,tkInteger,nil,__TIBDSBlobStreamSeek,false,0);
    DefineMethod('SetSize',1,tkNone,nil,__TIBDSBlobStreamSetSize,false,0);
    DefineMethod('Write',2,tkInteger,nil,__TIBDSBlobStreamWrite,false,0);
  end;
  DefineEventAdapter(TypeInfo(TIBUpdateErrorEvent), TatIBCustomDataSetDispatcher, @TatIBCustomDataSetDispatcher.__TIBUpdateErrorEvent);
  DefineEventAdapter(TypeInfo(TIBUpdateRecordEvent), TatIBCustomDataSetDispatcher, @TatIBCustomDataSetDispatcher.__TIBUpdateRecordEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('cusUnmodified',cusUnmodified);
    AddConstant('cusModified',cusModified);
    AddConstant('cusInserted',cusInserted);
    AddConstant('cusDeleted',cusDeleted);
    AddConstant('cusUninserted',cusUninserted);
    AddConstant('gamOnNewRecord',gamOnNewRecord);
    AddConstant('gamOnPost',gamOnPost);
    AddConstant('gamOnServer',gamOnServer);
    AddConstant('uaFail',uaFail);
    AddConstant('uaAbort',uaAbort);
    AddConstant('uaSkip',uaSkip);
    AddConstant('uaRetry',uaRetry);
    AddConstant('uaApply',uaApply);
    AddConstant('uaApplied',uaApplied);
    AddConstant('lmInsert',lmInsert);
    AddConstant('lmModify',lmModify);
    AddConstant('lmDelete',lmDelete);
    AddConstant('lmRefresh',lmRefresh);
    AddConstant('BufferCacheSize',BufferCacheSize);
    AddConstant('UniCache',UniCache);
  end;
end;

class function TatIBCustomDataSetLibrary.LibraryName: string;
begin
  result := 'IBCustomDataSet';
end;

initialization
  RegisterScripterLibrary(TatIBCustomDataSetLibrary, True);

{$WARNINGS ON}

end.

