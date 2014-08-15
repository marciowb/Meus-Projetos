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
  ActiveX,
  Graphics,
  Classes,
  Controls,
  Forms,
  Db,
  DSIntf,
  DBCommon,
  Midas,
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
    procedure __TClientDataSetCreate(AMachine: TatVirtualMachine);
    procedure __TClientDataSetDestroy(AMachine: TatVirtualMachine);
    procedure __TClientDataSetAddIndex(AMachine: TatVirtualMachine);
    procedure __TClientDataSetAppendData(AMachine: TatVirtualMachine);
    procedure __TClientDataSetApplyRange(AMachine: TatVirtualMachine);
    procedure __TClientDataSetApplyUpdates(AMachine: TatVirtualMachine);
    procedure __TClientDataSetCancel(AMachine: TatVirtualMachine);
    procedure __TClientDataSetCancelRange(AMachine: TatVirtualMachine);
    procedure __TClientDataSetCancelUpdates(AMachine: TatVirtualMachine);
    procedure __TClientDataSetCreateBlobStream(AMachine: TatVirtualMachine);
    procedure __TClientDataSetCreateDataSet(AMachine: TatVirtualMachine);
    procedure __TClientDataSetCloneCursor(AMachine: TatVirtualMachine);
    procedure __TClientDataSetConstraintsDisabled(AMachine: TatVirtualMachine);
    procedure __TClientDataSetDataRequest(AMachine: TatVirtualMachine);
    procedure __TClientDataSetDeleteIndex(AMachine: TatVirtualMachine);
    procedure __TClientDataSetDisableConstraints(AMachine: TatVirtualMachine);
    procedure __TClientDataSetEnableConstraints(AMachine: TatVirtualMachine);
    procedure __TClientDataSetEditKey(AMachine: TatVirtualMachine);
    procedure __TClientDataSetEditRangeEnd(AMachine: TatVirtualMachine);
    procedure __TClientDataSetEditRangeStart(AMachine: TatVirtualMachine);
    procedure __TClientDataSetEmptyDataSet(AMachine: TatVirtualMachine);
    procedure __TClientDataSetExecute(AMachine: TatVirtualMachine);
    procedure __TClientDataSetFetchBlobs(AMachine: TatVirtualMachine);
    procedure __TClientDataSetFetchDetails(AMachine: TatVirtualMachine);
    procedure __TClientDataSetRefreshRecord(AMachine: TatVirtualMachine);
    procedure __TClientDataSetFetchParams(AMachine: TatVirtualMachine);
    procedure __TClientDataSetGetCurrentRecord(AMachine: TatVirtualMachine);
    procedure __TClientDataSetGetGroupState(AMachine: TatVirtualMachine);
    procedure __TClientDataSetGetIndexInfo(AMachine: TatVirtualMachine);
    procedure __TClientDataSetGetIndexNames(AMachine: TatVirtualMachine);
    procedure __TClientDataSetGetNextPacket(AMachine: TatVirtualMachine);
    procedure __TClientDataSetGetOptionalParam(AMachine: TatVirtualMachine);
    procedure __TClientDataSetGotoCurrent(AMachine: TatVirtualMachine);
    procedure __TClientDataSetGotoKey(AMachine: TatVirtualMachine);
    procedure __TClientDataSetGotoNearest(AMachine: TatVirtualMachine);
    procedure __TClientDataSetLocate(AMachine: TatVirtualMachine);
    procedure __TClientDataSetLookup(AMachine: TatVirtualMachine);
    procedure __TClientDataSetLoadFromFile(AMachine: TatVirtualMachine);
    procedure __TClientDataSetLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TClientDataSetMergeChangeLog(AMachine: TatVirtualMachine);
    procedure __TClientDataSetPost(AMachine: TatVirtualMachine);
    procedure __TClientDataSetReconcile(AMachine: TatVirtualMachine);
    procedure __TClientDataSetRevertRecord(AMachine: TatVirtualMachine);
    procedure __TClientDataSetSaveToFile(AMachine: TatVirtualMachine);
    procedure __TClientDataSetSaveToStream(AMachine: TatVirtualMachine);
    procedure __TClientDataSetSetAltRecBuffers(AMachine: TatVirtualMachine);
    procedure __TClientDataSetSetKey(AMachine: TatVirtualMachine);
    procedure __TClientDataSetSetOptionalParam(AMachine: TatVirtualMachine);
    procedure __TClientDataSetSetProvider(AMachine: TatVirtualMachine);
    procedure __TClientDataSetSetRangeEnd(AMachine: TatVirtualMachine);
    procedure __TClientDataSetSetRangeStart(AMachine: TatVirtualMachine);
    procedure __TClientDataSetUndoLastChange(AMachine: TatVirtualMachine);
    procedure __TClientDataSetUpdateStatus(AMachine: TatVirtualMachine);
    procedure __GetTClientDataSetHasAppServer(AMachine: TatVirtualMachine);
    procedure __GetTClientDataSetActiveAggs(AMachine: TatVirtualMachine);
    procedure __GetTClientDataSetChangeCount(AMachine: TatVirtualMachine);
    procedure __GetTClientDataSetCloneSource(AMachine: TatVirtualMachine);
    procedure __GetTClientDataSetData(AMachine: TatVirtualMachine);
    procedure __SetTClientDataSetData(AMachine: TatVirtualMachine);
    procedure __GetTClientDataSetDataSize(AMachine: TatVirtualMachine);
    procedure __GetTClientDataSetDelta(AMachine: TatVirtualMachine);
    procedure __GetTClientDataSetGroupingLevel(AMachine: TatVirtualMachine);
    procedure __GetTClientDataSetIndexFieldCount(AMachine: TatVirtualMachine);
    procedure __GetTClientDataSetIndexFields(AMachine: TatVirtualMachine);
    procedure __SetTClientDataSetIndexFields(AMachine: TatVirtualMachine);
    procedure __GetTClientDataSetKeyExclusive(AMachine: TatVirtualMachine);
    procedure __SetTClientDataSetKeyExclusive(AMachine: TatVirtualMachine);
    procedure __GetTClientDataSetKeyFieldCount(AMachine: TatVirtualMachine);
    procedure __SetTClientDataSetKeyFieldCount(AMachine: TatVirtualMachine);
    procedure __GetTClientDataSetKeySize(AMachine: TatVirtualMachine);
    procedure __GetTClientDataSetLogChanges(AMachine: TatVirtualMachine);
    procedure __SetTClientDataSetLogChanges(AMachine: TatVirtualMachine);
    procedure __GetTClientDataSetSavePoint(AMachine: TatVirtualMachine);
    procedure __SetTClientDataSetSavePoint(AMachine: TatVirtualMachine);
    procedure __GetTClientDataSetStatusFilter(AMachine: TatVirtualMachine);
    procedure __SetTClientDataSetStatusFilter(AMachine: TatVirtualMachine);
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
  TAggregateClass = class of TAggregate;
  TAggregatesClass = class of TAggregates;
  TClientDataSetClass = class of TClientDataSet;
  TClientBlobStreamClass = class of TClientBlobStream;

  TatDBClientDispatcher = class(TatEventDispatcher)
  private
    procedure __TAggUpdateEvent( Agg: TAggregate);
    procedure __TReconcileErrorEvent( DataSet: TClientDataSet;  E: EReconcileError;  UpdateKind: TUpdateKind; var Action: TReconcileAction);
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

procedure TatDBClientLibrary.__TAggregateCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAggregateClass(CurrentClass.ClassRef).Create(TAggregates(Integer(GetInputArg(0))),TClientDataSet(Integer(GetInputArg(1)))));
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

procedure TatDBClientLibrary.__TClientDataSetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TClientDataSetClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).Destroy;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetAddIndex(AMachine: TatVirtualMachine);
  var
  Param2: TIndexOptions;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
    Case InputArgCount of
      3: TClientDataSet(CurrentObject).AddIndex(GetInputArg(0),GetInputArg(1),Param2);
      4: TClientDataSet(CurrentObject).AddIndex(GetInputArg(0),GetInputArg(1),Param2,GetInputArg(3));
      5: TClientDataSet(CurrentObject).AddIndex(GetInputArg(0),GetInputArg(1),Param2,GetInputArg(3),GetInputArg(4));
      6: TClientDataSet(CurrentObject).AddIndex(GetInputArg(0),GetInputArg(1),Param2,GetInputArg(3),GetInputArg(4),VarToInteger(GetInputArg(5)));
    end;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetAppendData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).AppendData(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetApplyRange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).ApplyRange;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetApplyUpdates(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TClientDataSet(CurrentObject).ApplyUpdates(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetCancel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).Cancel;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetCancelRange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).CancelRange;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetCancelUpdates(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).CancelUpdates;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetCreateBlobStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TClientDataSet(CurrentObject).CreateBlobStream(TField(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetCreateDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).CreateDataSet;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetCloneCursor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      2: TClientDataSet(CurrentObject).CloneCursor(TClientDataSet(Integer(GetInputArg(0))),GetInputArg(1));
      3: TClientDataSet(CurrentObject).CloneCursor(TClientDataSet(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
    end;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetConstraintsDisabled(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TClientDataSet(CurrentObject).ConstraintsDisabled;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetDataRequest(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TClientDataSet(CurrentObject).DataRequest(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetDeleteIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).DeleteIndex(GetInputArg(0));
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetDisableConstraints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).DisableConstraints;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetEnableConstraints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).EnableConstraints;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetEditKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).EditKey;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetEditRangeEnd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).EditRangeEnd;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetEditRangeStart(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).EditRangeStart;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetEmptyDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).EmptyDataSet;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).Execute;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetFetchBlobs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).FetchBlobs;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetFetchDetails(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).FetchDetails;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetRefreshRecord(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).RefreshRecord;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetFetchParams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).FetchParams;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetGetCurrentRecord(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TClientDataSet(CurrentObject).GetCurrentRecord(PChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetGetGroupState(AMachine: TatVirtualMachine);
  var
  AResultSet: TGroupPosInds;
  AResult: variant;
begin
  with AMachine do
  begin
AResultSet := TClientDataSet(CurrentObject).GetGroupState(VarToInteger(GetInputArg(0)));
AResult := IntFromSet(AResultSet, SizeOf(AResultSet));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetGetIndexInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).GetIndexInfo(GetInputArg(0));
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetGetIndexNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).GetIndexNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetGetNextPacket(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TClientDataSet(CurrentObject).GetNextPacket);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetGetOptionalParam(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TClientDataSet(CurrentObject).GetOptionalParam(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetGotoCurrent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).GotoCurrent(TClientDataSet(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetGotoKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TClientDataSet(CurrentObject).GotoKey;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetGotoNearest(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).GotoNearest;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetLocate(AMachine: TatVirtualMachine);
  var
  Param2: TLocateOptions;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := TClientDataSet(CurrentObject).Locate(GetInputArg(0),GetInputArg(1),Param2);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetLookup(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TClientDataSet(CurrentObject).Lookup(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetLoadFromFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      0: TClientDataSet(CurrentObject).LoadFromFile;
      1: TClientDataSet(CurrentObject).LoadFromFile(GetInputArg(0));
    end;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetMergeChangeLog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).MergeChangeLog;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetPost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).Post;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetReconcile(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TClientDataSet(CurrentObject).Reconcile(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetRevertRecord(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).RevertRecord;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetSaveToFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      0: TClientDataSet(CurrentObject).SaveToFile;
      1: TClientDataSet(CurrentObject).SaveToFile(GetInputArg(0));
      2: TClientDataSet(CurrentObject).SaveToFile(GetInputArg(0),GetInputArg(1));
    end;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      1: TClientDataSet(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
      2: TClientDataSet(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))),GetInputArg(1));
    end;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetSetAltRecBuffers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).SetAltRecBuffers(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))));
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetSetKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).SetKey;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetSetOptionalParam(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      2: TClientDataSet(CurrentObject).SetOptionalParam(GetInputArg(0),GetInputArg(1));
      3: TClientDataSet(CurrentObject).SetOptionalParam(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    end;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetSetProvider(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).SetProvider(TComponent(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetSetRangeEnd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).SetRangeEnd;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetSetRangeStart(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).SetRangeStart;
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetUndoLastChange(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TClientDataSet(CurrentObject).UndoLastChange(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__TClientDataSetUpdateStatus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TClientDataSet(CurrentObject).UpdateStatus;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientLibrary.__GetTClientDataSetHasAppServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TClientDataSet(CurrentObject).HasAppServer);
  end;
end;

procedure TatDBClientLibrary.__GetTClientDataSetActiveAggs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TClientDataSet(CurrentObject).ActiveAggs[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBClientLibrary.__GetTClientDataSetChangeCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TClientDataSet(CurrentObject).ChangeCount));
  end;
end;

procedure TatDBClientLibrary.__GetTClientDataSetCloneSource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TClientDataSet(CurrentObject).CloneSource));
  end;
end;

procedure TatDBClientLibrary.__GetTClientDataSetData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TClientDataSet(CurrentObject).Data);
  end;
end;

procedure TatDBClientLibrary.__SetTClientDataSetData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).Data:=GetInputArg(0);
  end;
end;

procedure TatDBClientLibrary.__GetTClientDataSetDataSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TClientDataSet(CurrentObject).DataSize));
  end;
end;

procedure TatDBClientLibrary.__GetTClientDataSetDelta(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TClientDataSet(CurrentObject).Delta);
  end;
end;

procedure TatDBClientLibrary.__GetTClientDataSetGroupingLevel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TClientDataSet(CurrentObject).GroupingLevel));
  end;
end;

procedure TatDBClientLibrary.__GetTClientDataSetIndexFieldCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TClientDataSet(CurrentObject).IndexFieldCount));
  end;
end;

procedure TatDBClientLibrary.__GetTClientDataSetIndexFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TClientDataSet(CurrentObject).IndexFields[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBClientLibrary.__SetTClientDataSetIndexFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).IndexFields[VarToInteger(GetArrayIndex(0))]:=TField(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBClientLibrary.__GetTClientDataSetKeyExclusive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TClientDataSet(CurrentObject).KeyExclusive);
  end;
end;

procedure TatDBClientLibrary.__SetTClientDataSetKeyExclusive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).KeyExclusive:=GetInputArg(0);
  end;
end;

procedure TatDBClientLibrary.__GetTClientDataSetKeyFieldCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TClientDataSet(CurrentObject).KeyFieldCount));
  end;
end;

procedure TatDBClientLibrary.__SetTClientDataSetKeyFieldCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).KeyFieldCount:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBClientLibrary.__GetTClientDataSetKeySize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TClientDataSet(CurrentObject).KeySize));
  end;
end;

procedure TatDBClientLibrary.__GetTClientDataSetLogChanges(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TClientDataSet(CurrentObject).LogChanges);
  end;
end;

procedure TatDBClientLibrary.__SetTClientDataSetLogChanges(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).LogChanges:=GetInputArg(0);
  end;
end;

procedure TatDBClientLibrary.__GetTClientDataSetSavePoint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TClientDataSet(CurrentObject).SavePoint));
  end;
end;

procedure TatDBClientLibrary.__SetTClientDataSetSavePoint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSet(CurrentObject).SavePoint:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBClientLibrary.__GetTClientDataSetStatusFilter(AMachine: TatVirtualMachine);
var
PropValueSet: TUpdateStatusSet;
begin
  with AMachine do
  begin
    PropValueSet := TClientDataSet(CurrentObject).StatusFilter;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatDBClientLibrary.__SetTClientDataSetStatusFilter(AMachine: TatVirtualMachine);
  var
  TempVar: TUpdateStatusSet;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TClientDataSet(CurrentObject).StatusFilter:=TempVar;
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

procedure TatDBClientDispatcher.__TReconcileErrorEvent( DataSet: TClientDataSet;  E: EReconcileError;  UpdateKind: TUpdateKind; var Action: TReconcileAction);
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
    DefineProp('DataSet',tkClass,__GetTAggregateDataSet,nil,TClientDataSet,false,0);
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
  With Scripter.DefineClass(TClientDataSet) do
  begin
    DefineMethod('Create',1,tkClass,TClientDataSet,__TClientDataSetCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TClientDataSetDestroy,false,0);
    DefineMethod('AddIndex',6,tkNone,nil,__TClientDataSetAddIndex,false,3);
    DefineMethod('AppendData',2,tkNone,nil,__TClientDataSetAppendData,false,0);
    DefineMethod('ApplyRange',0,tkNone,nil,__TClientDataSetApplyRange,false,0);
    DefineMethod('ApplyUpdates',1,tkInteger,nil,__TClientDataSetApplyUpdates,false,0);
    DefineMethod('Cancel',0,tkNone,nil,__TClientDataSetCancel,false,0);
    DefineMethod('CancelRange',0,tkNone,nil,__TClientDataSetCancelRange,false,0);
    DefineMethod('CancelUpdates',0,tkNone,nil,__TClientDataSetCancelUpdates,false,0);
    DefineMethod('CreateBlobStream',2,tkClass,TStream,__TClientDataSetCreateBlobStream,false,0);
    DefineMethod('CreateDataSet',0,tkNone,nil,__TClientDataSetCreateDataSet,false,0);
    DefineMethod('CloneCursor',3,tkNone,nil,__TClientDataSetCloneCursor,false,1);
    DefineMethod('ConstraintsDisabled',0,tkVariant,nil,__TClientDataSetConstraintsDisabled,false,0);
    DefineMethod('DataRequest',1,tkVariant,nil,__TClientDataSetDataRequest,false,0);
    DefineMethod('DeleteIndex',1,tkNone,nil,__TClientDataSetDeleteIndex,false,0);
    DefineMethod('DisableConstraints',0,tkNone,nil,__TClientDataSetDisableConstraints,false,0);
    DefineMethod('EnableConstraints',0,tkNone,nil,__TClientDataSetEnableConstraints,false,0);
    DefineMethod('EditKey',0,tkNone,nil,__TClientDataSetEditKey,false,0);
    DefineMethod('EditRangeEnd',0,tkNone,nil,__TClientDataSetEditRangeEnd,false,0);
    DefineMethod('EditRangeStart',0,tkNone,nil,__TClientDataSetEditRangeStart,false,0);
    DefineMethod('EmptyDataSet',0,tkNone,nil,__TClientDataSetEmptyDataSet,false,0);
    DefineMethod('Execute',0,tkNone,nil,__TClientDataSetExecute,false,0);
    DefineMethod('FetchBlobs',0,tkNone,nil,__TClientDataSetFetchBlobs,false,0);
    DefineMethod('FetchDetails',0,tkNone,nil,__TClientDataSetFetchDetails,false,0);
    DefineMethod('RefreshRecord',0,tkNone,nil,__TClientDataSetRefreshRecord,false,0);
    DefineMethod('FetchParams',0,tkNone,nil,__TClientDataSetFetchParams,false,0);
    DefineMethod('GetCurrentRecord',1,tkVariant,nil,__TClientDataSetGetCurrentRecord,false,0);
    DefineMethod('GetGroupState',1,tkInteger,nil,__TClientDataSetGetGroupState,false,0);
    DefineMethod('GetIndexInfo',1,tkNone,nil,__TClientDataSetGetIndexInfo,false,0);
    DefineMethod('GetIndexNames',1,tkNone,nil,__TClientDataSetGetIndexNames,false,0);
    DefineMethod('GetNextPacket',0,tkInteger,nil,__TClientDataSetGetNextPacket,false,0);
    DefineMethod('GetOptionalParam',1,tkVariant,nil,__TClientDataSetGetOptionalParam,false,0);
    DefineMethod('GotoCurrent',1,tkNone,nil,__TClientDataSetGotoCurrent,false,0);
    DefineMethod('GotoKey',0,tkVariant,nil,__TClientDataSetGotoKey,false,0);
    DefineMethod('GotoNearest',0,tkNone,nil,__TClientDataSetGotoNearest,false,0);
    DefineMethod('Locate',3,tkVariant,nil,__TClientDataSetLocate,false,0);
    DefineMethod('Lookup',3,tkVariant,nil,__TClientDataSetLookup,false,0);
    DefineMethod('LoadFromFile',1,tkNone,nil,__TClientDataSetLoadFromFile,false,1);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TClientDataSetLoadFromStream,false,0);
    DefineMethod('MergeChangeLog',0,tkNone,nil,__TClientDataSetMergeChangeLog,false,0);
    DefineMethod('Post',0,tkNone,nil,__TClientDataSetPost,false,0);
    DefineMethod('Reconcile',1,tkVariant,nil,__TClientDataSetReconcile,false,0);
    DefineMethod('RevertRecord',0,tkNone,nil,__TClientDataSetRevertRecord,false,0);
    DefineMethod('SaveToFile',2,tkNone,nil,__TClientDataSetSaveToFile,false,2);
    DefineMethod('SaveToStream',2,tkNone,nil,__TClientDataSetSaveToStream,false,1);
    DefineMethod('SetAltRecBuffers',3,tkNone,nil,__TClientDataSetSetAltRecBuffers,false,0);
    DefineMethod('SetKey',0,tkNone,nil,__TClientDataSetSetKey,false,0);
    DefineMethod('SetOptionalParam',3,tkNone,nil,__TClientDataSetSetOptionalParam,false,1);
    DefineMethod('SetProvider',1,tkNone,nil,__TClientDataSetSetProvider,false,0);
    DefineMethod('SetRangeEnd',0,tkNone,nil,__TClientDataSetSetRangeEnd,false,0);
    DefineMethod('SetRangeStart',0,tkNone,nil,__TClientDataSetSetRangeStart,false,0);
    DefineMethod('UndoLastChange',1,tkVariant,nil,__TClientDataSetUndoLastChange,false,0);
    DefineMethod('UpdateStatus',0,tkEnumeration,nil,__TClientDataSetUpdateStatus,false,0);
    DefineProp('HasAppServer',tkVariant,__GetTClientDataSetHasAppServer,nil,nil,false,0);
    DefineProp('ActiveAggs',tkClass,__GetTClientDataSetActiveAggs,nil,TList,false,1);
    DefineProp('ChangeCount',tkInteger,__GetTClientDataSetChangeCount,nil,nil,false,0);
    DefineProp('CloneSource',tkClass,__GetTClientDataSetCloneSource,nil,TClientDataSet,false,0);
    DefineProp('Data',tkVariant,__GetTClientDataSetData,__SetTClientDataSetData,nil,false,0);
    DefineProp('DataSize',tkInteger,__GetTClientDataSetDataSize,nil,nil,false,0);
    DefineProp('Delta',tkVariant,__GetTClientDataSetDelta,nil,nil,false,0);
    DefineProp('GroupingLevel',tkInteger,__GetTClientDataSetGroupingLevel,nil,nil,false,0);
    DefineProp('IndexFieldCount',tkInteger,__GetTClientDataSetIndexFieldCount,nil,nil,false,0);
    DefineProp('IndexFields',tkClass,__GetTClientDataSetIndexFields,__SetTClientDataSetIndexFields,TField,false,1);
    DefineProp('KeyExclusive',tkVariant,__GetTClientDataSetKeyExclusive,__SetTClientDataSetKeyExclusive,nil,false,0);
    DefineProp('KeyFieldCount',tkInteger,__GetTClientDataSetKeyFieldCount,__SetTClientDataSetKeyFieldCount,nil,false,0);
    DefineProp('KeySize',tkInteger,__GetTClientDataSetKeySize,nil,nil,false,0);
    DefineProp('LogChanges',tkVariant,__GetTClientDataSetLogChanges,__SetTClientDataSetLogChanges,nil,false,0);
    DefineProp('SavePoint',tkInteger,__GetTClientDataSetSavePoint,__SetTClientDataSetSavePoint,nil,false,0);
    DefineProp('StatusFilter',tkInteger,__GetTClientDataSetStatusFilter,__SetTClientDataSetStatusFilter,nil,false,0);
  end;
  With Scripter.DefineClass(TClientBlobStream) do
  begin
    DefineMethod('Create',2,tkClass,TClientBlobStream,__TClientBlobStreamCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TClientBlobStreamDestroy,false,0);
    DefineMethod('Write',2,tkInteger,nil,__TClientBlobStreamWrite,false,0);
    DefineMethod('Truncate',0,tkNone,nil,__TClientBlobStreamTruncate,false,0);
  end;
  DefineEventAdapter(TypeInfo(TAggUpdateEvent), TatDBClientDispatcher, @TatDBClientDispatcher.__TAggUpdateEvent);
  DefineEventAdapter(TypeInfo(TReconcileErrorEvent), TatDBClientDispatcher, @TatDBClientDispatcher.__TReconcileErrorEvent);
  DefineEventAdapter(TypeInfo(TRemoteEvent), TatDBClientDispatcher, @TatDBClientDispatcher.__TRemoteEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('PackageParams',2,tkVariant,nil,__PackageParams,false,1);
    DefineMethod('UnpackParams',2,tkNone,nil,__UnpackParams,false,0);
    AddConstant('kiLookup',kiLookup);
    AddConstant('kiRangeStart',kiRangeStart);
    AddConstant('kiRangeEnd',kiRangeEnd);
    AddConstant('kiCurRangeStart',kiCurRangeStart);
    AddConstant('kiCurRangeEnd',kiCurRangeEnd);
    AddConstant('kiSave',kiSave);
    AddConstant('dfBinary',dfBinary);
    AddConstant('dfXML',dfXML);
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

