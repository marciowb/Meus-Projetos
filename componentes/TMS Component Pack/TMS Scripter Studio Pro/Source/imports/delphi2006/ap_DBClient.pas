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
unit ap_DBClient;

interface

uses
  Windows,
  SysUtils,
  VarUtils,
  Variants,
  Classes,
  DB,
  DSIntf,
  DBCommon,
  DBCommonTypes,
  Midas,
  SqlTimSt,
  ActiveX,
  DBClient,
  atScript;

{$WARNINGS OFF}

type
  TatDBClientLibrary = class(TatScripterLibrary)
    procedure __EDBClientCreate(AMachine: TatVirtualMachine);
    procedure __GetEDBClientErrorCode(AMachine: TatVirtualMachine);
    procedure __EReconcileErrorCreate(AMachine: TatVirtualMachine);
    procedure __GetEReconcileErrorContext(AMachine: TatVirtualMachine);
    procedure __GetEReconcileErrorPreviousError(AMachine: TatVirtualMachine);
    procedure __TCustomRemoteServerCreate(AMachine: TatVirtualMachine);
    procedure __TCustomRemoteServerGetServerList(AMachine: TatVirtualMachine);
    procedure __GetTCustomRemoteServerAppServer(AMachine: TatVirtualMachine);
    procedure __TConnectionBrokerCreate(AMachine: TatVirtualMachine);
    procedure __TAggregateCreate(AMachine: TatVirtualMachine);
    procedure __TAggregateDestroy(AMachine: TatVirtualMachine);
    procedure __TAggregateAssign(AMachine: TatVirtualMachine);
    procedure __TAggregateGetDisplayName(AMachine: TatVirtualMachine);
    procedure __TAggregateValue(AMachine: TatVirtualMachine);
    procedure __GetTAggregateAggHandle(AMachine: TatVirtualMachine);
    procedure __SetTAggregateAggHandle(AMachine: TatVirtualMachine);
    procedure __GetTAggregateInUse(AMachine: TatVirtualMachine);
    procedure __SetTAggregateInUse(AMachine: TatVirtualMachine);
    procedure __GetTAggregateDataSet(AMachine: TatVirtualMachine);
    procedure __GetTAggregateDataSize(AMachine: TatVirtualMachine);
    procedure __GetTAggregateDataType(AMachine: TatVirtualMachine);
    procedure __TAggregatesCreate(AMachine: TatVirtualMachine);
    procedure __TAggregatesAdd(AMachine: TatVirtualMachine);
    procedure __TAggregatesClear(AMachine: TatVirtualMachine);
    procedure __TAggregatesFind(AMachine: TatVirtualMachine);
    procedure __TAggregatesIndexOf(AMachine: TatVirtualMachine);
    procedure __GetTAggregatesItems(AMachine: TatVirtualMachine);
    procedure __SetTAggregatesItems(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetCreate(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetAddIndex(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetAppendData(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetApplyRange(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetApplyUpdates(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetCancel(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetCancelRange(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetCancelUpdates(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetCreateBlobStream(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetCreateDataSet(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetCloneCursor(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetConstraintsDisabled(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetDataRequest(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetDeleteIndex(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetDisableConstraints(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetEnableConstraints(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetEditKey(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetEditRangeEnd(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetEditRangeStart(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetEmptyDataSet(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetExecute(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetFetchBlobs(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetFetchDetails(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetRefreshRecord(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetFetchParams(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetGetCurrentRecord(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetGetGroupState(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetGetIndexInfo(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetGetIndexNames(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetGetNextPacket(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetGetOptionalParam(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetGotoCurrent(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetGotoKey(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetGotoNearest(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetLocate(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetLookup(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetLoadFromFile(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetMergeChangeLog(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetPost(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetReconcile(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetRevertRecord(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetSaveToFile(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetSaveToStream(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetSetAltRecBuffers(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetSetKey(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetSetOptionalParam(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetSetProvider(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetSetRangeEnd(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetSetRangeStart(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetUndoLastChange(AMachine: TatVirtualMachine);
    procedure __TCustomClientDataSetUpdateStatus(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetProviderName(AMachine: TatVirtualMachine);
    procedure __SetTCustomClientDataSetProviderName(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetFileName(AMachine: TatVirtualMachine);
    procedure __SetTCustomClientDataSetFileName(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetConnectionBroker(AMachine: TatVirtualMachine);
    procedure __SetTCustomClientDataSetConnectionBroker(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetIndexFieldNames(AMachine: TatVirtualMachine);
    procedure __SetTCustomClientDataSetIndexFieldNames(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetMasterFields(AMachine: TatVirtualMachine);
    procedure __SetTCustomClientDataSetMasterFields(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetPacketRecords(AMachine: TatVirtualMachine);
    procedure __SetTCustomClientDataSetPacketRecords(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetRemoteServer(AMachine: TatVirtualMachine);
    procedure __SetTCustomClientDataSetRemoteServer(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetHasAppServer(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetActiveAggs(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetChangeCount(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetCloneSource(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetData(AMachine: TatVirtualMachine);
    procedure __SetTCustomClientDataSetData(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetXMLData(AMachine: TatVirtualMachine);
    procedure __SetTCustomClientDataSetXMLData(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetDataSize(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetDelta(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetGroupingLevel(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetIndexFieldCount(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetIndexFields(AMachine: TatVirtualMachine);
    procedure __SetTCustomClientDataSetIndexFields(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetKeyExclusive(AMachine: TatVirtualMachine);
    procedure __SetTCustomClientDataSetKeyExclusive(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetKeyFieldCount(AMachine: TatVirtualMachine);
    procedure __SetTCustomClientDataSetKeyFieldCount(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetKeySize(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetLogChanges(AMachine: TatVirtualMachine);
    procedure __SetTCustomClientDataSetLogChanges(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetSavePoint(AMachine: TatVirtualMachine);
    procedure __SetTCustomClientDataSetSavePoint(AMachine: TatVirtualMachine);
    procedure __GetTCustomClientDataSetStatusFilter(AMachine: TatVirtualMachine);
    procedure __SetTCustomClientDataSetStatusFilter(AMachine: TatVirtualMachine);
    procedure __TClientBlobStreamCreate(AMachine: TatVirtualMachine);
    procedure __TClientBlobStreamDestroy(AMachine: TatVirtualMachine);
    procedure __TClientBlobStreamWrite(AMachine: TatVirtualMachine);
    procedure __TClientBlobStreamTruncate(AMachine: TatVirtualMachine);
    procedure __PackageParams(AMachine: TatVirtualMachine);
    procedure __UnpackParams(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EDBClientClass = class of EDBClient;
  EReconcileErrorClass = class of EReconcileError;
  TCustomRemoteServerClass = class of TCustomRemoteServer;
  TConnectionBrokerClass = class of TConnectionBroker;
  TAggregateClass = class of TAggregate;
  TAggregatesClass = class of TAggregates;
  TCustomClientDataSetClass = class of TCustomClientDataSet;
  TClientDataSetClass = class of TClientDataSet;
  TClientBlobStreamClass = class of TClientBlobStream;

  TatDBClientDispatcher = class(TatEventDispatcher)
  private
    procedure __TGetUsernameEvent( Sender: TObject; var Username: string);
    procedure __TAggUpdateEvent( Agg: TAggregate);
    procedure __TReconcileErrorEvent( DataSet: TCustomClientDataSet;  E: EReconcileError;  UpdateKind: TUpdateKind; var Action: TReconcileAction);
    procedure __TRemoteEvent( Sender: TObject; var OwnerData: OleVariant);
  end;

  TRecInfoWrapper = class(TatRecordWrapper)
  private
    FRecordNumber: Longint;
    FBookmarkFlag: TBookmarkFlag;
    FAttribute: DSAttr;
  public
    constructor Create(ARecord: TRecInfo);
    function ObjToRec: TRecInfo;
  published
    property RecordNumber: Longint read FRecordNumber write FRecordNumber;
    property BookmarkFlag: TBookmarkFlag read FBookmarkFlag write FBookmarkFlag;
    property Attribute: DSAttr read FAttribute write FAttribute;
  end;
  
  TKeyBufferWrapper = class(TatRecordWrapper)
  private
    FModified: Boolean;
    FExclusive: Boolean;
    FFieldCount: Integer;
  public
    constructor Create(ARecord: TKeyBuffer);
    function ObjToRec: TKeyBuffer;
  published
    property Modified: Boolean read FModified write FModified;
    property Exclusive: Boolean read FExclusive write FExclusive;
    property FieldCount: Integer read FFieldCount write FFieldCount;
  end;
  
  TReconcileInfoWrapper = class(TatRecordWrapper)
  private
    FDataSet: TDataSet;
    FUpdateKind: TUpdateKind;
    FReconcileError: EReconcileError;
  public
    constructor Create(ARecord: TReconcileInfo);
    function ObjToRec: TReconcileInfo;
  published
    property DataSet: TDataSet read FDataSet write FDataSet;
    property UpdateKind: TUpdateKind read FUpdateKind write FUpdateKind;
    property ReconcileError: EReconcileError read FReconcileError write FReconcileError;
  end;
  

implementation

constructor TRecInfoWrapper.Create(ARecord: TRecInfo);
begin
  inherited Create;
  FRecordNumber := ARecord.RecordNumber;
  FBookmarkFlag := ARecord.BookmarkFlag;
  FAttribute := ARecord.Attribute;
end;

function TRecInfoWrapper.ObjToRec: TRecInfo;
begin
  result.RecordNumber := FRecordNumber;
  result.BookmarkFlag := FBookmarkFlag;
  result.Attribute := FAttribute;
end;

constructor TKeyBufferWrapper.Create(ARecord: TKeyBuffer);
begin
  inherited Create;
  FModified := ARecord.Modified;
  FExclusive := ARecord.Exclusive;
  FFieldCount := ARecord.FieldCount;
end;

function TKeyBufferWrapper.ObjToRec: TKeyBuffer;
begin
  result.Modified := FModified;
  result.Exclusive := FExclusive;
  result.FieldCount := FFieldCount;
end;

constructor TReconcileInfoWrapper.Create(ARecord: TReconcileInfo);
begin
  inherited Create;
  FDataSet := ARecord.DataSet;
  FUpdateKind := ARecord.UpdateKind;
  FReconcileError := ARecord.ReconcileError;
end;

function TReconcileInfoWrapper.ObjToRec: TReconcileInfo;
begin
  result.DataSet := FDataSet;
  result.UpdateKind := FUpdateKind;
  result.ReconcileError := FReconcileError;
end;



procedure TatDBClientLibrary.__EDBClientCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(EDBClientClass(CurrentClass.ClassRef).Create(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__GetEDBClientErrorCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(EDBClient(CurrentObject).ErrorCode));
  end;
end;

procedure TatDBClientLibrary.__EReconcileErrorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(EReconcileErrorClass(CurrentClass.ClassRef).Create(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__GetEReconcileErrorContext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(EReconcileError(CurrentObject).Context);
  end;
end;

procedure TatDBClientLibrary.__GetEReconcileErrorPreviousError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(EReconcileError(CurrentObject).PreviousError));
  end;
end;

procedure TatDBClientLibrary.__TCustomRemoteServerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomRemoteServerClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TCustomRemoteServerGetServerList(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomRemoteServer(CurrentObject).GetServerList;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__GetTCustomRemoteServerAppServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomRemoteServer(CurrentObject).AppServer);
  end;
end;

procedure TatDBClientLibrary.__TConnectionBrokerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TConnectionBrokerClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TAggregateCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAggregateClass(CurrentClass.ClassRef).Create(TAggregates(Integer(GetInputArg(0))),TCustomClientDataSet(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TAggregateDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAggregate(CurrentObject).Destroy;
  end;
end;

procedure TatDBClientLibrary.__TAggregateAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAggregate(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBClientLibrary.__TAggregateGetDisplayName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TAggregate(CurrentObject).GetDisplayName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TAggregateValue(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TAggregate(CurrentObject).Value;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__GetTAggregateAggHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAggregate(CurrentObject).AggHandle));
  end;
end;

procedure TatDBClientLibrary.__SetTAggregateAggHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAggregate(CurrentObject).AggHandle:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBClientLibrary.__GetTAggregateInUse(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TAggregate(CurrentObject).InUse);
  end;
end;

procedure TatDBClientLibrary.__SetTAggregateInUse(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAggregate(CurrentObject).InUse:=GetInputArg(0);
  end;
end;

procedure TatDBClientLibrary.__GetTAggregateDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAggregate(CurrentObject).DataSet));
  end;
end;

procedure TatDBClientLibrary.__GetTAggregateDataSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAggregate(CurrentObject).DataSize));
  end;
end;

procedure TatDBClientLibrary.__GetTAggregateDataType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TAggregate(CurrentObject).DataType);
  end;
end;

procedure TatDBClientLibrary.__TAggregatesCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAggregatesClass(CurrentClass.ClassRef).Create(TPersistent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TAggregatesAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAggregates(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TAggregatesClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAggregates(CurrentObject).Clear;
  end;
end;

procedure TatDBClientLibrary.__TAggregatesFind(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAggregates(CurrentObject).Find(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TAggregatesIndexOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAggregates(CurrentObject).IndexOf(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__GetTAggregatesItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAggregates(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBClientLibrary.__SetTAggregatesItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAggregates(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TAggregate(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomClientDataSetClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).Destroy;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetAddIndex(AMachine: TatVirtualMachine);
  var
  Param2: TIndexOptions;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
    Case InputArgCount of
      3: TCustomClientDataSet(CurrentObject).AddIndex(GetInputArg(0),GetInputArg(1),Param2);
      4: TCustomClientDataSet(CurrentObject).AddIndex(GetInputArg(0),GetInputArg(1),Param2,GetInputArg(3));
      5: TCustomClientDataSet(CurrentObject).AddIndex(GetInputArg(0),GetInputArg(1),Param2,GetInputArg(3),GetInputArg(4));
      6: TCustomClientDataSet(CurrentObject).AddIndex(GetInputArg(0),GetInputArg(1),Param2,GetInputArg(3),GetInputArg(4),VarToInteger(GetInputArg(5)));
    end;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetAppendData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).AppendData(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetApplyRange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).ApplyRange;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetApplyUpdates(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomClientDataSet(CurrentObject).ApplyUpdates(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetCancel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).Cancel;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetCancelRange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).CancelRange;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetCancelUpdates(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).CancelUpdates;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetCreateBlobStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomClientDataSet(CurrentObject).CreateBlobStream(TField(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetCreateDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).CreateDataSet;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetCloneCursor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      2: TCustomClientDataSet(CurrentObject).CloneCursor(TCustomClientDataSet(Integer(GetInputArg(0))),GetInputArg(1));
      3: TCustomClientDataSet(CurrentObject).CloneCursor(TCustomClientDataSet(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
    end;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetConstraintsDisabled(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomClientDataSet(CurrentObject).ConstraintsDisabled;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetDataRequest(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomClientDataSet(CurrentObject).DataRequest(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetDeleteIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).DeleteIndex(GetInputArg(0));
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetDisableConstraints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).DisableConstraints;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetEnableConstraints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).EnableConstraints;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetEditKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).EditKey;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetEditRangeEnd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).EditRangeEnd;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetEditRangeStart(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).EditRangeStart;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetEmptyDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).EmptyDataSet;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).Execute;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetFetchBlobs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).FetchBlobs;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetFetchDetails(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).FetchDetails;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetRefreshRecord(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).RefreshRecord;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetFetchParams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).FetchParams;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetGetCurrentRecord(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomClientDataSet(CurrentObject).GetCurrentRecord(PChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetGetGroupState(AMachine: TatVirtualMachine);
  var
  AResultSet: TGroupPosInds;
  AResult: variant;
begin
  with AMachine do
  begin
AResultSet := TCustomClientDataSet(CurrentObject).GetGroupState(VarToInteger(GetInputArg(0)));
AResult := IntFromSet(AResultSet, SizeOf(AResultSet));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetGetIndexInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).GetIndexInfo(GetInputArg(0));
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetGetIndexNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).GetIndexNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetGetNextPacket(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomClientDataSet(CurrentObject).GetNextPacket);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetGetOptionalParam(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomClientDataSet(CurrentObject).GetOptionalParam(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetGotoCurrent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).GotoCurrent(TCustomClientDataSet(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetGotoKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomClientDataSet(CurrentObject).GotoKey;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetGotoNearest(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).GotoNearest;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetLocate(AMachine: TatVirtualMachine);
  var
  Param2: TLocateOptions;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := TCustomClientDataSet(CurrentObject).Locate(GetInputArg(0),GetInputArg(1),Param2);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetLookup(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomClientDataSet(CurrentObject).Lookup(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetLoadFromFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      0: TCustomClientDataSet(CurrentObject).LoadFromFile;
      1: TCustomClientDataSet(CurrentObject).LoadFromFile(GetInputArg(0));
    end;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetMergeChangeLog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).MergeChangeLog;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetPost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).Post;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetReconcile(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomClientDataSet(CurrentObject).Reconcile(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetRevertRecord(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).RevertRecord;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetSaveToFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      0: TCustomClientDataSet(CurrentObject).SaveToFile;
      1: TCustomClientDataSet(CurrentObject).SaveToFile(GetInputArg(0));
      2: TCustomClientDataSet(CurrentObject).SaveToFile(GetInputArg(0),GetInputArg(1));
    end;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      1: TCustomClientDataSet(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
      2: TCustomClientDataSet(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))),GetInputArg(1));
    end;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetSetAltRecBuffers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).SetAltRecBuffers(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))));
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetSetKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).SetKey;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetSetOptionalParam(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      2: TCustomClientDataSet(CurrentObject).SetOptionalParam(GetInputArg(0),GetInputArg(1));
      3: TCustomClientDataSet(CurrentObject).SetOptionalParam(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    end;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetSetProvider(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).SetProvider(TComponent(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetSetRangeEnd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).SetRangeEnd;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetSetRangeStart(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).SetRangeStart;
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetUndoLastChange(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomClientDataSet(CurrentObject).UndoLastChange(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TCustomClientDataSetUpdateStatus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomClientDataSet(CurrentObject).UpdateStatus;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetProviderName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomClientDataSet(CurrentObject).ProviderName);
  end;
end;

procedure TatDBClientLibrary.__SetTCustomClientDataSetProviderName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).ProviderName:=GetInputArg(0);
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetFileName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomClientDataSet(CurrentObject).FileName);
  end;
end;

procedure TatDBClientLibrary.__SetTCustomClientDataSetFileName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).FileName:=GetInputArg(0);
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetConnectionBroker(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomClientDataSet(CurrentObject).ConnectionBroker));
  end;
end;

procedure TatDBClientLibrary.__SetTCustomClientDataSetConnectionBroker(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).ConnectionBroker:=TConnectionBroker(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetIndexFieldNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomClientDataSet(CurrentObject).IndexFieldNames);
  end;
end;

procedure TatDBClientLibrary.__SetTCustomClientDataSetIndexFieldNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).IndexFieldNames:=GetInputArg(0);
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetMasterFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomClientDataSet(CurrentObject).MasterFields);
  end;
end;

procedure TatDBClientLibrary.__SetTCustomClientDataSetMasterFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).MasterFields:=GetInputArg(0);
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetPacketRecords(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomClientDataSet(CurrentObject).PacketRecords));
  end;
end;

procedure TatDBClientLibrary.__SetTCustomClientDataSetPacketRecords(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).PacketRecords:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetRemoteServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomClientDataSet(CurrentObject).RemoteServer));
  end;
end;

procedure TatDBClientLibrary.__SetTCustomClientDataSetRemoteServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).RemoteServer:=TCustomRemoteServer(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetHasAppServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomClientDataSet(CurrentObject).HasAppServer);
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetActiveAggs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomClientDataSet(CurrentObject).ActiveAggs[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetChangeCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomClientDataSet(CurrentObject).ChangeCount));
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetCloneSource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomClientDataSet(CurrentObject).CloneSource));
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomClientDataSet(CurrentObject).Data);
  end;
end;

procedure TatDBClientLibrary.__SetTCustomClientDataSetData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).Data:=GetInputArg(0);
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetXMLData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomClientDataSet(CurrentObject).XMLData);
  end;
end;

procedure TatDBClientLibrary.__SetTCustomClientDataSetXMLData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).XMLData:=GetInputArg(0);
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetDataSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomClientDataSet(CurrentObject).DataSize));
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetDelta(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomClientDataSet(CurrentObject).Delta);
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetGroupingLevel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomClientDataSet(CurrentObject).GroupingLevel));
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetIndexFieldCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomClientDataSet(CurrentObject).IndexFieldCount));
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetIndexFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomClientDataSet(CurrentObject).IndexFields[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBClientLibrary.__SetTCustomClientDataSetIndexFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).IndexFields[VarToInteger(GetArrayIndex(0))]:=TField(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetKeyExclusive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomClientDataSet(CurrentObject).KeyExclusive);
  end;
end;

procedure TatDBClientLibrary.__SetTCustomClientDataSetKeyExclusive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).KeyExclusive:=GetInputArg(0);
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetKeyFieldCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomClientDataSet(CurrentObject).KeyFieldCount));
  end;
end;

procedure TatDBClientLibrary.__SetTCustomClientDataSetKeyFieldCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).KeyFieldCount:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetKeySize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomClientDataSet(CurrentObject).KeySize));
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetLogChanges(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomClientDataSet(CurrentObject).LogChanges);
  end;
end;

procedure TatDBClientLibrary.__SetTCustomClientDataSetLogChanges(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).LogChanges:=GetInputArg(0);
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetSavePoint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomClientDataSet(CurrentObject).SavePoint));
  end;
end;

procedure TatDBClientLibrary.__SetTCustomClientDataSetSavePoint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomClientDataSet(CurrentObject).SavePoint:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBClientLibrary.__GetTCustomClientDataSetStatusFilter(AMachine: TatVirtualMachine);
var
PropValueSet: TUpdateStatusSet;
begin
  with AMachine do
  begin
    PropValueSet := TCustomClientDataSet(CurrentObject).StatusFilter;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatDBClientLibrary.__SetTCustomClientDataSetStatusFilter(AMachine: TatVirtualMachine);
  var
  TempVar: TUpdateStatusSet;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TCustomClientDataSet(CurrentObject).StatusFilter:=TempVar;
  end;
end;

procedure TatDBClientLibrary.__TClientBlobStreamCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TClientBlobStreamClass(CurrentClass.ClassRef).Create(TBlobField(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TClientBlobStreamDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientBlobStream(CurrentObject).Destroy;
  end;
end;

procedure TatDBClientLibrary.__TClientBlobStreamWrite(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TClientBlobStream(CurrentObject).Write(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TClientBlobStreamTruncate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientBlobStream(CurrentObject).Truncate;
  end;
end;

procedure TatDBClientDispatcher.__TGetUsernameEvent( Sender: TObject; var Username: string);
var
  UsernameTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGetUsernameEvent(BeforeCall)(Sender,Username);
    UsernameTemp := Username;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,UsernameTemp]);
    Username := UsernameTemp;
    if AssignedMethod(AfterCall) then
      TGetUsernameEvent(AfterCall)(Sender,Username);
  end;
end;

procedure TatDBClientDispatcher.__TAggUpdateEvent( Agg: TAggregate);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TAggUpdateEvent(BeforeCall)(Agg);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Agg]);
    if AssignedMethod(AfterCall) then
      TAggUpdateEvent(AfterCall)(Agg);
  end;
end;

procedure TatDBClientDispatcher.__TReconcileErrorEvent( DataSet: TCustomClientDataSet;  E: EReconcileError;  UpdateKind: TUpdateKind; var Action: TReconcileAction);
var
  UpdateKindTemp: variant;
  ActionTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TReconcileErrorEvent(BeforeCall)(DataSet,E,UpdateKind,Action);
    UpdateKindTemp := UpdateKind;
    ActionTemp := Action;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [DataSet,E,UpdateKindTemp,ActionTemp]);
    Action := ActionTemp;
    if AssignedMethod(AfterCall) then
      TReconcileErrorEvent(AfterCall)(DataSet,E,UpdateKind,Action);
  end;
end;

procedure TatDBClientDispatcher.__TRemoteEvent( Sender: TObject; var OwnerData: OleVariant);
var
  OwnerDataTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TRemoteEvent(BeforeCall)(Sender,OwnerData);
    OwnerDataTemp := OwnerData;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,OwnerDataTemp]);
    OwnerData := OwnerDataTemp;
    if AssignedMethod(AfterCall) then
      TRemoteEvent(AfterCall)(Sender,OwnerData);
  end;
end;

procedure TatDBClientLibrary.__PackageParams(AMachine: TatVirtualMachine);
  var
  Param1: TParamTypes;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param1, VarToInteger(GetInputArg(1)), SizeOf(Param1));
case InputArgCount of
1: AResult := DBClient.PackageParams(TParams(Integer(GetInputArg(0))));
2: AResult := DBClient.PackageParams(TParams(Integer(GetInputArg(0))),Param1);
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__UnpackParams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DBClient.UnpackParams(GetInputArg(0),TParams(Integer(GetInputArg(1))));
  end;
end;

procedure TatDBClientLibrary.Init;
begin
  With Scripter.DefineClass(EDBClient) do
  begin
    DefineMethod('Create',2,tkClass,EDBClient,__EDBClientCreate,true,0);
    DefineProp('ErrorCode',tkInteger,__GetEDBClientErrorCode,nil,nil,false,0);
  end;
  With Scripter.DefineClass(EReconcileError) do
  begin
    DefineMethod('Create',4,tkClass,EReconcileError,__EReconcileErrorCreate,true,0);
    DefineProp('Context',tkVariant,__GetEReconcileErrorContext,nil,nil,false,0);
    DefineProp('PreviousError',tkInteger,__GetEReconcileErrorPreviousError,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomRemoteServer) do
  begin
    DefineMethod('Create',1,tkClass,TCustomRemoteServer,__TCustomRemoteServerCreate,true,0);
    DefineMethod('GetServerList',0,tkVariant,nil,__TCustomRemoteServerGetServerList,false,0);
    DefineProp('AppServer',tkVariant,__GetTCustomRemoteServerAppServer,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TConnectionBroker) do
  begin
    DefineMethod('Create',1,tkClass,TConnectionBroker,__TConnectionBrokerCreate,true,0);
  end;
  With Scripter.DefineClass(TAggregate) do
  begin
    DefineMethod('Create',2,tkClass,TAggregate,__TAggregateCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TAggregateDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TAggregateAssign,false,0);
    DefineMethod('GetDisplayName',0,tkVariant,nil,__TAggregateGetDisplayName,false,0);
    DefineMethod('Value',0,tkVariant,nil,__TAggregateValue,false,0);
    DefineProp('AggHandle',tkInteger,__GetTAggregateAggHandle,__SetTAggregateAggHandle,nil,false,0);
    DefineProp('InUse',tkVariant,__GetTAggregateInUse,__SetTAggregateInUse,nil,false,0);
    DefineProp('DataSet',tkClass,__GetTAggregateDataSet,nil,TCustomClientDataSet,false,0);
    DefineProp('DataSize',tkInteger,__GetTAggregateDataSize,nil,nil,false,0);
    DefineProp('DataType',tkEnumeration,__GetTAggregateDataType,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TAggregates) do
  begin
    DefineMethod('Create',1,tkClass,TAggregates,__TAggregatesCreate,true,0);
    DefineMethod('Add',0,tkClass,TAggregate,__TAggregatesAdd,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TAggregatesClear,false,0);
    DefineMethod('Find',1,tkClass,TAggregate,__TAggregatesFind,false,0);
    DefineMethod('IndexOf',1,tkInteger,nil,__TAggregatesIndexOf,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTAggregatesItems,__SetTAggregatesItems,TAggregate,false,1);
  end;
  With Scripter.DefineClass(TCustomClientDataSet) do
  begin
    DefineMethod('Create',1,tkClass,TCustomClientDataSet,__TCustomClientDataSetCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomClientDataSetDestroy,false,0);
    DefineMethod('AddIndex',6,tkNone,nil,__TCustomClientDataSetAddIndex,false,3);
    DefineMethod('AppendData',2,tkNone,nil,__TCustomClientDataSetAppendData,false,0);
    DefineMethod('ApplyRange',0,tkNone,nil,__TCustomClientDataSetApplyRange,false,0);
    DefineMethod('ApplyUpdates',1,tkInteger,nil,__TCustomClientDataSetApplyUpdates,false,0);
    DefineMethod('Cancel',0,tkNone,nil,__TCustomClientDataSetCancel,false,0);
    DefineMethod('CancelRange',0,tkNone,nil,__TCustomClientDataSetCancelRange,false,0);
    DefineMethod('CancelUpdates',0,tkNone,nil,__TCustomClientDataSetCancelUpdates,false,0);
    DefineMethod('CreateBlobStream',2,tkClass,TStream,__TCustomClientDataSetCreateBlobStream,false,0);
    DefineMethod('CreateDataSet',0,tkNone,nil,__TCustomClientDataSetCreateDataSet,false,0);
    DefineMethod('CloneCursor',3,tkNone,nil,__TCustomClientDataSetCloneCursor,false,1);
    DefineMethod('ConstraintsDisabled',0,tkVariant,nil,__TCustomClientDataSetConstraintsDisabled,false,0);
    DefineMethod('DataRequest',1,tkVariant,nil,__TCustomClientDataSetDataRequest,false,0);
    DefineMethod('DeleteIndex',1,tkNone,nil,__TCustomClientDataSetDeleteIndex,false,0);
    DefineMethod('DisableConstraints',0,tkNone,nil,__TCustomClientDataSetDisableConstraints,false,0);
    DefineMethod('EnableConstraints',0,tkNone,nil,__TCustomClientDataSetEnableConstraints,false,0);
    DefineMethod('EditKey',0,tkNone,nil,__TCustomClientDataSetEditKey,false,0);
    DefineMethod('EditRangeEnd',0,tkNone,nil,__TCustomClientDataSetEditRangeEnd,false,0);
    DefineMethod('EditRangeStart',0,tkNone,nil,__TCustomClientDataSetEditRangeStart,false,0);
    DefineMethod('EmptyDataSet',0,tkNone,nil,__TCustomClientDataSetEmptyDataSet,false,0);
    DefineMethod('Execute',0,tkNone,nil,__TCustomClientDataSetExecute,false,0);
    DefineMethod('FetchBlobs',0,tkNone,nil,__TCustomClientDataSetFetchBlobs,false,0);
    DefineMethod('FetchDetails',0,tkNone,nil,__TCustomClientDataSetFetchDetails,false,0);
    DefineMethod('RefreshRecord',0,tkNone,nil,__TCustomClientDataSetRefreshRecord,false,0);
    DefineMethod('FetchParams',0,tkNone,nil,__TCustomClientDataSetFetchParams,false,0);
    DefineMethod('GetCurrentRecord',1,tkVariant,nil,__TCustomClientDataSetGetCurrentRecord,false,0);
    DefineMethod('GetGroupState',1,tkInteger,nil,__TCustomClientDataSetGetGroupState,false,0);
    DefineMethod('GetIndexInfo',1,tkNone,nil,__TCustomClientDataSetGetIndexInfo,false,0);
    DefineMethod('GetIndexNames',1,tkNone,nil,__TCustomClientDataSetGetIndexNames,false,0);
    DefineMethod('GetNextPacket',0,tkInteger,nil,__TCustomClientDataSetGetNextPacket,false,0);
    DefineMethod('GetOptionalParam',1,tkVariant,nil,__TCustomClientDataSetGetOptionalParam,false,0);
    DefineMethod('GotoCurrent',1,tkNone,nil,__TCustomClientDataSetGotoCurrent,false,0);
    DefineMethod('GotoKey',0,tkVariant,nil,__TCustomClientDataSetGotoKey,false,0);
    DefineMethod('GotoNearest',0,tkNone,nil,__TCustomClientDataSetGotoNearest,false,0);
    DefineMethod('Locate',3,tkVariant,nil,__TCustomClientDataSetLocate,false,0);
    DefineMethod('Lookup',3,tkVariant,nil,__TCustomClientDataSetLookup,false,0);
    DefineMethod('LoadFromFile',1,tkNone,nil,__TCustomClientDataSetLoadFromFile,false,1);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TCustomClientDataSetLoadFromStream,false,0);
    DefineMethod('MergeChangeLog',0,tkNone,nil,__TCustomClientDataSetMergeChangeLog,false,0);
    DefineMethod('Post',0,tkNone,nil,__TCustomClientDataSetPost,false,0);
    DefineMethod('Reconcile',1,tkVariant,nil,__TCustomClientDataSetReconcile,false,0);
    DefineMethod('RevertRecord',0,tkNone,nil,__TCustomClientDataSetRevertRecord,false,0);
    DefineMethod('SaveToFile',2,tkNone,nil,__TCustomClientDataSetSaveToFile,false,2);
    DefineMethod('SaveToStream',2,tkNone,nil,__TCustomClientDataSetSaveToStream,false,1);
    DefineMethod('SetAltRecBuffers',3,tkNone,nil,__TCustomClientDataSetSetAltRecBuffers,false,0);
    DefineMethod('SetKey',0,tkNone,nil,__TCustomClientDataSetSetKey,false,0);
    DefineMethod('SetOptionalParam',3,tkNone,nil,__TCustomClientDataSetSetOptionalParam,false,1);
    DefineMethod('SetProvider',1,tkNone,nil,__TCustomClientDataSetSetProvider,false,0);
    DefineMethod('SetRangeEnd',0,tkNone,nil,__TCustomClientDataSetSetRangeEnd,false,0);
    DefineMethod('SetRangeStart',0,tkNone,nil,__TCustomClientDataSetSetRangeStart,false,0);
    DefineMethod('UndoLastChange',1,tkVariant,nil,__TCustomClientDataSetUndoLastChange,false,0);
    DefineMethod('UpdateStatus',0,tkEnumeration,nil,__TCustomClientDataSetUpdateStatus,false,0);
    DefineProp('Active',tkVariant,nil,nil,nil,false,0);
    DefineProp('DataSetField',tkVariant,nil,nil,nil,false,0);
    DefineProp('ProviderName',tkVariant,__GetTCustomClientDataSetProviderName,__SetTCustomClientDataSetProviderName,nil,false,0);
    DefineProp('FileName',tkVariant,__GetTCustomClientDataSetFileName,__SetTCustomClientDataSetFileName,nil,false,0);
    DefineProp('ConnectionBroker',tkClass,__GetTCustomClientDataSetConnectionBroker,__SetTCustomClientDataSetConnectionBroker,TConnectionBroker,false,0);
    DefineProp('IndexFieldNames',tkVariant,__GetTCustomClientDataSetIndexFieldNames,__SetTCustomClientDataSetIndexFieldNames,nil,false,0);
    DefineProp('MasterFields',tkVariant,__GetTCustomClientDataSetMasterFields,__SetTCustomClientDataSetMasterFields,nil,false,0);
    DefineProp('PacketRecords',tkInteger,__GetTCustomClientDataSetPacketRecords,__SetTCustomClientDataSetPacketRecords,nil,false,0);
    DefineProp('RemoteServer',tkClass,__GetTCustomClientDataSetRemoteServer,__SetTCustomClientDataSetRemoteServer,TCustomRemoteServer,false,0);
    DefineProp('HasAppServer',tkVariant,__GetTCustomClientDataSetHasAppServer,nil,nil,false,0);
    DefineProp('ActiveAggs',tkClass,__GetTCustomClientDataSetActiveAggs,nil,TList,false,1);
    DefineProp('ChangeCount',tkInteger,__GetTCustomClientDataSetChangeCount,nil,nil,false,0);
    DefineProp('CloneSource',tkClass,__GetTCustomClientDataSetCloneSource,nil,TCustomClientDataSet,false,0);
    DefineProp('Data',tkVariant,__GetTCustomClientDataSetData,__SetTCustomClientDataSetData,nil,false,0);
    DefineProp('XMLData',tkVariant,__GetTCustomClientDataSetXMLData,__SetTCustomClientDataSetXMLData,nil,false,0);
    DefineProp('DataSize',tkInteger,__GetTCustomClientDataSetDataSize,nil,nil,false,0);
    DefineProp('Delta',tkVariant,__GetTCustomClientDataSetDelta,nil,nil,false,0);
    DefineProp('GroupingLevel',tkInteger,__GetTCustomClientDataSetGroupingLevel,nil,nil,false,0);
    DefineProp('IndexFieldCount',tkInteger,__GetTCustomClientDataSetIndexFieldCount,nil,nil,false,0);
    DefineProp('IndexFields',tkClass,__GetTCustomClientDataSetIndexFields,__SetTCustomClientDataSetIndexFields,TField,false,1);
    DefineProp('KeyExclusive',tkVariant,__GetTCustomClientDataSetKeyExclusive,__SetTCustomClientDataSetKeyExclusive,nil,false,0);
    DefineProp('KeyFieldCount',tkInteger,__GetTCustomClientDataSetKeyFieldCount,__SetTCustomClientDataSetKeyFieldCount,nil,false,0);
    DefineProp('KeySize',tkInteger,__GetTCustomClientDataSetKeySize,nil,nil,false,0);
    DefineProp('LogChanges',tkVariant,__GetTCustomClientDataSetLogChanges,__SetTCustomClientDataSetLogChanges,nil,false,0);
    DefineProp('SavePoint',tkInteger,__GetTCustomClientDataSetSavePoint,__SetTCustomClientDataSetSavePoint,nil,false,0);
    DefineProp('StatusFilter',tkInteger,__GetTCustomClientDataSetStatusFilter,__SetTCustomClientDataSetStatusFilter,nil,false,0);
  end;
  With Scripter.DefineClass(TClientDataSet) do
  begin
  end;
  With Scripter.DefineClass(TClientBlobStream) do
  begin
    DefineMethod('Create',2,tkClass,TClientBlobStream,__TClientBlobStreamCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TClientBlobStreamDestroy,false,0);
    DefineMethod('Write',2,tkInteger,nil,__TClientBlobStreamWrite,false,0);
    DefineMethod('Truncate',0,tkNone,nil,__TClientBlobStreamTruncate,false,0);
  end;
  DefineEventAdapter(TypeInfo(TGetUsernameEvent), TatDBClientDispatcher, @TatDBClientDispatcher.__TGetUsernameEvent);
  DefineEventAdapter(TypeInfo(TAggUpdateEvent), TatDBClientDispatcher, @TatDBClientDispatcher.__TAggUpdateEvent);
  DefineEventAdapter(TypeInfo(TReconcileErrorEvent), TatDBClientDispatcher, @TatDBClientDispatcher.__TReconcileErrorEvent);
  DefineEventAdapter(TypeInfo(TRemoteEvent), TatDBClientDispatcher, @TatDBClientDispatcher.__TRemoteEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('PackageParams',2,tkVariant,nil,__PackageParams,false,1);
    DefineMethod('UnpackParams',2,tkNone,nil,__UnpackParams,false,0);
    AddConstant('dfBinary',dfBinary);
    AddConstant('dfXML',dfXML);
    AddConstant('dfXMLUTF8',dfXMLUTF8);
    AddConstant('raSkip',raSkip);
    AddConstant('raAbort',raAbort);
    AddConstant('raMerge',raMerge);
    AddConstant('raCorrect',raCorrect);
    AddConstant('raCancel',raCancel);
    AddConstant('raRefresh',raRefresh);
    AddConstant('doDisableInserts',doDisableInserts);
    AddConstant('doDisableDeletes',doDisableDeletes);
    AddConstant('doDisableEdits',doDisableEdits);
    AddConstant('doNoResetCall',doNoResetCall);
    AddConstant('foRecord',foRecord);
    AddConstant('foBlobs',foBlobs);
    AddConstant('foDetails',foDetails);
    AddConstant('AllParamTypes',IntFromConstSet(AllParamTypes));
    AddConstant('AllRecords',AllRecords);
  end;
end;

class function TatDBClientLibrary.LibraryName: string;
begin
  result := 'DBClient';
end;

initialization
  RegisterScripterLibrary(TatDBClientLibrary, True);

{$WARNINGS ON}

end.

