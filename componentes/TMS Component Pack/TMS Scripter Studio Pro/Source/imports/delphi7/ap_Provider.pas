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
unit ap_Provider;

interface

uses
  Windows,
  SysUtils,
  VarUtils,
  Variants,
  Classes,
  DBClient,
  DB,
  DSIntf,
  ActiveX,
  Midas,
  SqlTimSt,
  Provider,
  atScript;

{$WARNINGS OFF}

type
  TatProviderLibrary = class(TatScripterLibrary)
    procedure __EDSWriterCreate(AMachine: TatVirtualMachine);
    procedure __GetEDSWriterErrorCode(AMachine: TatVirtualMachine);
    procedure __TCustomPacketWriterCreate(AMachine: TatVirtualMachine);
    procedure __TCustomPacketWriterDestroy(AMachine: TatVirtualMachine);
    procedure __TDataPacketWriterDestroy(AMachine: TatVirtualMachine);
    procedure __TDataPacketWriterGetDataPacket(AMachine: TatVirtualMachine);
    procedure __GetTDataPacketWriterConstraints(AMachine: TatVirtualMachine);
    procedure __SetTDataPacketWriterConstraints(AMachine: TatVirtualMachine);
    procedure __GetTDataPacketWriterPacketOptions(AMachine: TatVirtualMachine);
    procedure __SetTDataPacketWriterPacketOptions(AMachine: TatVirtualMachine);
    procedure __GetTDataPacketWriterOptions(AMachine: TatVirtualMachine);
    procedure __SetTDataPacketWriterOptions(AMachine: TatVirtualMachine);
    procedure __TPacketDataSetCreate(AMachine: TatVirtualMachine);
    procedure __TPacketDataSetAssignCurValues(AMachine: TatVirtualMachine);
    procedure __TPacketDataSetCreateFromDelta(AMachine: TatVirtualMachine);
    procedure __TPacketDataSetHasCurValues(AMachine: TatVirtualMachine);
    procedure __TPacketDataSetHasMergeConflicts(AMachine: TatVirtualMachine);
    procedure __TPacketDataSetInitAltRecBuffers(AMachine: TatVirtualMachine);
    procedure __TPacketDataSetUpdateKind(AMachine: TatVirtualMachine);
    procedure __GetTPacketDataSetNewValuesModified(AMachine: TatVirtualMachine);
    procedure __GetTPacketDataSetStreamMetaData(AMachine: TatVirtualMachine);
    procedure __SetTPacketDataSetStreamMetaData(AMachine: TatVirtualMachine);
    procedure __GetTPacketDataSetUseCurValues(AMachine: TatVirtualMachine);
    procedure __SetTPacketDataSetUseCurValues(AMachine: TatVirtualMachine);
    procedure __TCustomProviderCreate(AMachine: TatVirtualMachine);
    procedure __TCustomProviderDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomProviderApplyUpdates(AMachine: TatVirtualMachine);
    procedure __TCustomProviderGetRecords(AMachine: TatVirtualMachine);
    procedure __TCustomProviderRowRequest(AMachine: TatVirtualMachine);
    procedure __TCustomProviderExecute(AMachine: TatVirtualMachine);
    procedure __TCustomProviderGetParams(AMachine: TatVirtualMachine);
    procedure __TCustomProviderDataRequest(AMachine: TatVirtualMachine);
    procedure __GetTCustomProviderData(AMachine: TatVirtualMachine);
    procedure __GetTCustomProviderExported(AMachine: TatVirtualMachine);
    procedure __SetTCustomProviderExported(AMachine: TatVirtualMachine);
    procedure __TBaseProviderCreate(AMachine: TatVirtualMachine);
    procedure __TBaseProviderDestroy(AMachine: TatVirtualMachine);
    procedure __GetTBaseProviderResolver(AMachine: TatVirtualMachine);
    procedure __GetTBaseProviderOptions(AMachine: TatVirtualMachine);
    procedure __SetTBaseProviderOptions(AMachine: TatVirtualMachine);
    procedure __GetTBaseProviderUpdateMode(AMachine: TatVirtualMachine);
    procedure __SetTBaseProviderUpdateMode(AMachine: TatVirtualMachine);
    procedure __TDataSetProviderCreate(AMachine: TatVirtualMachine);
    procedure __TDataSetProviderDestroy(AMachine: TatVirtualMachine);
    procedure __TUpdateTreeCreate(AMachine: TatVirtualMachine);
    procedure __TUpdateTreeDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomResolverCreate(AMachine: TatVirtualMachine);
    procedure __TCustomResolverDestroy(AMachine: TatVirtualMachine);
    procedure __TDataSetResolverCreate(AMachine: TatVirtualMachine);
    procedure __TSQLResolverCreate(AMachine: TatVirtualMachine);
    procedure __TSQLResolverDestroy(AMachine: TatVirtualMachine);
    procedure __TLocalAppServerCreate(AMachine: TatVirtualMachine);
    procedure __TLocalAppServerDestroy(AMachine: TatVirtualMachine);
    procedure __GetObjectProperty(AMachine: TatVirtualMachine);
    procedure __GetStringProperty(AMachine: TatVirtualMachine);
    procedure __VarArrayFromStrings(AMachine: TatVirtualMachine);
    procedure __GetInformixLob(AMachine: TatVirtualMachine);
    procedure __SetInformixLob(AMachine: TatVirtualMachine);
    procedure __GetResetOption(AMachine: TatVirtualMachine);
    procedure __GetMetaDataOption(AMachine: TatVirtualMachine);
    procedure __GetXMLOption(AMachine: TatVirtualMachine);
    procedure __GetXMLUTF8Option(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EDSWriterClass = class of EDSWriter;
  TCustomPacketWriterClass = class of TCustomPacketWriter;
  TDataPacketWriterClass = class of TDataPacketWriter;
  TPacketDataSetClass = class of TPacketDataSet;
  TCustomProviderClass = class of TCustomProvider;
  TBaseProviderClass = class of TBaseProvider;
  TDataSetProviderClass = class of TDataSetProvider;
  TProviderClass = class of TProvider;
  TUpdateTreeClass = class of TUpdateTree;
  TCustomResolverClass = class of TCustomResolver;
  TDataSetResolverClass = class of TDataSetResolver;
  TSQLResolverClass = class of TSQLResolver;
  TLocalAppServerClass = class of TLocalAppServer;

  TatProviderDispatcher = class(TatEventDispatcher)
  private
    function __TDataRequestEvent( Sender: TObject;  Input: OleVariant): OleVariant;
    procedure __TGetParamsEvent( DataSet: TDataSet;  Params: TList);
    procedure __TProviderDataEvent( Sender: TObject;  DataSet: TCustomClientDataSet);
    procedure __TBeforeUpdateRecordEvent( Sender: TObject;  SourceDS: TDataSet;  DeltaDS: TCustomClientDataSet;  UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure __TAfterUpdateRecordEvent( Sender: TObject;  SourceDS: TDataSet;  DeltaDS: TCustomClientDataSet;  UpdateKind: TUpdateKind);
    procedure __TResolverErrorEvent( Sender: TObject;  DataSet: TCustomClientDataSet;  E: EUpdateError;  UpdateKind: TUpdateKind; var Response: TResolverResponse);
    procedure __TGetTableNameEvent( Sender: TObject;  DataSet: TDataSet; var TableName: string);
    procedure __TGetDSProps( Sender: TObject;  DataSet: TDataSet; out Properties: OleVariant);
  end;

  TPutFieldInfoWrapper = class(TatRecordWrapper)
  private
    FFieldNo: Integer;
    FField: TField;
    FDataSet: TDataSet;
    FSize: Integer;
    FIsDetail: Boolean;
    FOpened: Boolean;
    FLocalFieldIndex: Integer;
  public
    constructor Create(ARecord: TPutFieldInfo);
    function ObjToRec: TPutFieldInfo;
  published
    property FieldNo: Integer read FFieldNo write FFieldNo;
    property Field: TField read FField write FField;
    property DataSet: TDataSet read FDataSet write FDataSet;
    property Size: Integer read FSize write FSize;
    property IsDetail: Boolean read FIsDetail write FIsDetail;
    property Opened: Boolean read FOpened write FOpened;
    property LocalFieldIndex: Integer read FLocalFieldIndex write FLocalFieldIndex;
  end;
  

implementation

constructor TPutFieldInfoWrapper.Create(ARecord: TPutFieldInfo);
begin
  inherited Create;
  FFieldNo := ARecord.FieldNo;
  FField := ARecord.Field;
  FDataSet := ARecord.DataSet;
  FSize := ARecord.Size;
  FIsDetail := ARecord.IsDetail;
  FOpened := ARecord.Opened;
  FLocalFieldIndex := ARecord.LocalFieldIndex;
end;

function TPutFieldInfoWrapper.ObjToRec: TPutFieldInfo;
begin
  result.FieldNo := FFieldNo;
  result.Field := FField;
  result.DataSet := FDataSet;
  result.Size := FSize;
  result.IsDetail := FIsDetail;
  result.Opened := FOpened;
  result.LocalFieldIndex := FLocalFieldIndex;
end;



procedure TatProviderLibrary.__EDSWriterCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(EDSWriterClass(CurrentClass.ClassRef).Create(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatProviderLibrary.__GetEDSWriterErrorCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(EDSWriter(CurrentObject).ErrorCode));
  end;
end;

procedure TatProviderLibrary.__TCustomPacketWriterCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomPacketWriterClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatProviderLibrary.__TCustomPacketWriterDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomPacketWriter(CurrentObject).Destroy;
  end;
end;

procedure TatProviderLibrary.__TDataPacketWriterDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataPacketWriter(CurrentObject).Destroy;
  end;
end;

procedure TatProviderLibrary.__TDataPacketWriterGetDataPacket(AMachine: TatVirtualMachine);
  var
  Param1: Integer;
  Param2: OleVariant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := GetInputArg(2);
    TDataPacketWriter(CurrentObject).GetDataPacket(TDataSet(Integer(GetInputArg(0))),Param1,Param2);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Param2);
  end;
end;

procedure TatProviderLibrary.__GetTDataPacketWriterConstraints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataPacketWriter(CurrentObject).Constraints);
  end;
end;

procedure TatProviderLibrary.__SetTDataPacketWriterConstraints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataPacketWriter(CurrentObject).Constraints:=GetInputArg(0);
  end;
end;

procedure TatProviderLibrary.__GetTDataPacketWriterPacketOptions(AMachine: TatVirtualMachine);
var
PropValueSet: TGetRecordOptions;
begin
  with AMachine do
  begin
    PropValueSet := TDataPacketWriter(CurrentObject).PacketOptions;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatProviderLibrary.__SetTDataPacketWriterPacketOptions(AMachine: TatVirtualMachine);
  var
  TempVar: TGetRecordOptions;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TDataPacketWriter(CurrentObject).PacketOptions:=TempVar;
  end;
end;

procedure TatProviderLibrary.__GetTDataPacketWriterOptions(AMachine: TatVirtualMachine);
var
PropValueSet: TProviderOptions;
begin
  with AMachine do
  begin
    PropValueSet := TDataPacketWriter(CurrentObject).Options;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatProviderLibrary.__SetTDataPacketWriterOptions(AMachine: TatVirtualMachine);
  var
  TempVar: TProviderOptions;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TDataPacketWriter(CurrentObject).Options:=TempVar;
  end;
end;

procedure TatProviderLibrary.__TPacketDataSetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPacketDataSetClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatProviderLibrary.__TPacketDataSetAssignCurValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPacketDataSet(CurrentObject).AssignCurValues(TDataSet(Integer(GetInputArg(0))));
  end;
end;

procedure TatProviderLibrary.__TPacketDataSetCreateFromDelta(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPacketDataSet(CurrentObject).CreateFromDelta(TPacketDataSet(Integer(GetInputArg(0))));
  end;
end;

procedure TatProviderLibrary.__TPacketDataSetHasCurValues(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TPacketDataSet(CurrentObject).HasCurValues;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatProviderLibrary.__TPacketDataSetHasMergeConflicts(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TPacketDataSet(CurrentObject).HasMergeConflicts;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatProviderLibrary.__TPacketDataSetInitAltRecBuffers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      0: TPacketDataSet(CurrentObject).InitAltRecBuffers;
      1: TPacketDataSet(CurrentObject).InitAltRecBuffers(GetInputArg(0));
    end;
  end;
end;

procedure TatProviderLibrary.__TPacketDataSetUpdateKind(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TPacketDataSet(CurrentObject).UpdateKind;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatProviderLibrary.__GetTPacketDataSetNewValuesModified(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TPacketDataSet(CurrentObject).NewValuesModified);
  end;
end;

procedure TatProviderLibrary.__GetTPacketDataSetStreamMetaData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TPacketDataSet(CurrentObject).StreamMetaData);
  end;
end;

procedure TatProviderLibrary.__SetTPacketDataSetStreamMetaData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPacketDataSet(CurrentObject).StreamMetaData:=GetInputArg(0);
  end;
end;

procedure TatProviderLibrary.__GetTPacketDataSetUseCurValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TPacketDataSet(CurrentObject).UseCurValues);
  end;
end;

procedure TatProviderLibrary.__SetTPacketDataSetUseCurValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPacketDataSet(CurrentObject).UseCurValues:=GetInputArg(0);
  end;
end;

procedure TatProviderLibrary.__TCustomProviderCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomProviderClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatProviderLibrary.__TCustomProviderDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomProvider(CurrentObject).Destroy;
  end;
end;

procedure TatProviderLibrary.__TCustomProviderApplyUpdates(AMachine: TatVirtualMachine);
  var
  Param2: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := TCustomProvider(CurrentObject).ApplyUpdates(GetInputArg(0),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatProviderLibrary.__TCustomProviderGetRecords(AMachine: TatVirtualMachine);
  var
  Param1: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := TCustomProvider(CurrentObject).GetRecords(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatProviderLibrary.__TCustomProviderRowRequest(AMachine: TatVirtualMachine);
  var
  Param2: OleVariant;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := TCustomProvider(CurrentObject).RowRequest(GetInputArg(0),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatProviderLibrary.__TCustomProviderExecute(AMachine: TatVirtualMachine);
  var
  Param1: OleVariant;
  Param2: OleVariant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
Param2 := GetInputArg(2);
    TCustomProvider(CurrentObject).Execute(GetInputArg(0),Param1,Param2);
    SetInputArg(1,Param1);
    SetInputArg(2,Param2);
  end;
end;

procedure TatProviderLibrary.__TCustomProviderGetParams(AMachine: TatVirtualMachine);
  var
  Param0: OleVariant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := TCustomProvider(CurrentObject).GetParams(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatProviderLibrary.__TCustomProviderDataRequest(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomProvider(CurrentObject).DataRequest(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatProviderLibrary.__GetTCustomProviderData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomProvider(CurrentObject).Data);
  end;
end;

procedure TatProviderLibrary.__GetTCustomProviderExported(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomProvider(CurrentObject).Exported);
  end;
end;

procedure TatProviderLibrary.__SetTCustomProviderExported(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomProvider(CurrentObject).Exported:=GetInputArg(0);
  end;
end;

procedure TatProviderLibrary.__TBaseProviderCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBaseProviderClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatProviderLibrary.__TBaseProviderDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBaseProvider(CurrentObject).Destroy;
  end;
end;

procedure TatProviderLibrary.__GetTBaseProviderResolver(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TBaseProvider(CurrentObject).Resolver));
  end;
end;

procedure TatProviderLibrary.__GetTBaseProviderOptions(AMachine: TatVirtualMachine);
var
PropValueSet: TProviderOptions;
begin
  with AMachine do
  begin
    PropValueSet := TBaseProvider(CurrentObject).Options;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatProviderLibrary.__SetTBaseProviderOptions(AMachine: TatVirtualMachine);
  var
  TempVar: TProviderOptions;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TBaseProvider(CurrentObject).Options:=TempVar;
  end;
end;

procedure TatProviderLibrary.__GetTBaseProviderUpdateMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TBaseProvider(CurrentObject).UpdateMode);
  end;
end;

procedure TatProviderLibrary.__SetTBaseProviderUpdateMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBaseProvider(CurrentObject).UpdateMode:=GetInputArg(0);
  end;
end;

procedure TatProviderLibrary.__TDataSetProviderCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDataSetProviderClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatProviderLibrary.__TDataSetProviderDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetProvider(CurrentObject).Destroy;
  end;
end;

procedure TatProviderLibrary.__TUpdateTreeCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TUpdateTreeClass(CurrentClass.ClassRef).Create(TUpdateTree(Integer(GetInputArg(0))),TCustomResolver(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatProviderLibrary.__TUpdateTreeDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TUpdateTree(CurrentObject).Destroy;
  end;
end;

procedure TatProviderLibrary.__TCustomResolverCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomResolverClass(CurrentClass.ClassRef).Create(TBaseProvider(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatProviderLibrary.__TCustomResolverDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomResolver(CurrentObject).Destroy;
  end;
end;

procedure TatProviderLibrary.__TDataSetResolverCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDataSetResolverClass(CurrentClass.ClassRef).Create(TDataSetProvider(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatProviderLibrary.__TSQLResolverCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSQLResolverClass(CurrentClass.ClassRef).Create(TDataSetProvider(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatProviderLibrary.__TSQLResolverDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLResolver(CurrentObject).Destroy;
  end;
end;

procedure TatProviderLibrary.__TLocalAppServerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TLocalAppServerClass(CurrentClass.ClassRef).Create(TCustomProvider(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatProviderLibrary.__TLocalAppServerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TLocalAppServer(CurrentObject).Destroy;
  end;
end;

function TatProviderDispatcher.__TDataRequestEvent( Sender: TObject;  Input: OleVariant): OleVariant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TDataRequestEvent(BeforeCall)(Sender,Input);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Input]);
    if AssignedMethod(AfterCall) then
      TDataRequestEvent(AfterCall)(Sender,Input);
  end;
end;

procedure TatProviderDispatcher.__TGetParamsEvent( DataSet: TDataSet;  Params: TList);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGetParamsEvent(BeforeCall)(DataSet,Params);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [DataSet,Params]);
    if AssignedMethod(AfterCall) then
      TGetParamsEvent(AfterCall)(DataSet,Params);
  end;
end;

procedure TatProviderDispatcher.__TProviderDataEvent( Sender: TObject;  DataSet: TCustomClientDataSet);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TProviderDataEvent(BeforeCall)(Sender,DataSet);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,DataSet]);
    if AssignedMethod(AfterCall) then
      TProviderDataEvent(AfterCall)(Sender,DataSet);
  end;
end;

procedure TatProviderDispatcher.__TBeforeUpdateRecordEvent( Sender: TObject;  SourceDS: TDataSet;  DeltaDS: TCustomClientDataSet;  UpdateKind: TUpdateKind; var Applied: Boolean);
var
  UpdateKindTemp: variant;
  AppliedTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TBeforeUpdateRecordEvent(BeforeCall)(Sender,SourceDS,DeltaDS,UpdateKind,Applied);
    UpdateKindTemp := UpdateKind;
    AppliedTemp := Applied;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,SourceDS,DeltaDS,UpdateKindTemp,AppliedTemp]);
    Applied := AppliedTemp;
    if AssignedMethod(AfterCall) then
      TBeforeUpdateRecordEvent(AfterCall)(Sender,SourceDS,DeltaDS,UpdateKind,Applied);
  end;
end;

procedure TatProviderDispatcher.__TAfterUpdateRecordEvent( Sender: TObject;  SourceDS: TDataSet;  DeltaDS: TCustomClientDataSet;  UpdateKind: TUpdateKind);
var
  UpdateKindTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TAfterUpdateRecordEvent(BeforeCall)(Sender,SourceDS,DeltaDS,UpdateKind);
    UpdateKindTemp := UpdateKind;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,SourceDS,DeltaDS,UpdateKindTemp]);
    if AssignedMethod(AfterCall) then
      TAfterUpdateRecordEvent(AfterCall)(Sender,SourceDS,DeltaDS,UpdateKind);
  end;
end;

procedure TatProviderDispatcher.__TResolverErrorEvent( Sender: TObject;  DataSet: TCustomClientDataSet;  E: EUpdateError;  UpdateKind: TUpdateKind; var Response: TResolverResponse);
var
  UpdateKindTemp: variant;
  ResponseTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TResolverErrorEvent(BeforeCall)(Sender,DataSet,E,UpdateKind,Response);
    UpdateKindTemp := UpdateKind;
    ResponseTemp := Response;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,DataSet,E,UpdateKindTemp,ResponseTemp]);
    Response := ResponseTemp;
    if AssignedMethod(AfterCall) then
      TResolverErrorEvent(AfterCall)(Sender,DataSet,E,UpdateKind,Response);
  end;
end;

procedure TatProviderDispatcher.__TGetTableNameEvent( Sender: TObject;  DataSet: TDataSet; var TableName: string);
var
  TableNameTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGetTableNameEvent(BeforeCall)(Sender,DataSet,TableName);
    TableNameTemp := TableName;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,DataSet,TableNameTemp]);
    TableName := TableNameTemp;
    if AssignedMethod(AfterCall) then
      TGetTableNameEvent(AfterCall)(Sender,DataSet,TableName);
  end;
end;

procedure TatProviderDispatcher.__TGetDSProps( Sender: TObject;  DataSet: TDataSet; out Properties: OleVariant);
var
  PropertiesTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGetDSProps(BeforeCall)(Sender,DataSet,Properties);
    PropertiesTemp := Properties;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,DataSet,PropertiesTemp]);
    Properties := PropertiesTemp;
    if AssignedMethod(AfterCall) then
      TGetDSProps(AfterCall)(Sender,DataSet,Properties);
  end;
end;

procedure TatProviderLibrary.__GetObjectProperty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Provider.GetObjectProperty(TPersistent(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatProviderLibrary.__GetStringProperty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Provider.GetStringProperty(TPersistent(Integer(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatProviderLibrary.__VarArrayFromStrings(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Provider.VarArrayFromStrings(TStrings(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatProviderLibrary.__GetInformixLob(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Provider.InformixLob);
  end;
end;

procedure TatProviderLibrary.__SetInformixLob(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Provider.InformixLob:=GetInputArg(0);
  end;
end;

procedure TatProviderLibrary.__GetResetOption(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(Provider.ResetOption));
  end;
end;

procedure TatProviderLibrary.__GetMetaDataOption(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(Provider.MetaDataOption));
  end;
end;

procedure TatProviderLibrary.__GetXMLOption(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(Provider.XMLOption));
  end;
end;

procedure TatProviderLibrary.__GetXMLUTF8Option(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(Provider.XMLUTF8Option));
  end;
end;

procedure TatProviderLibrary.Init;
begin
  With Scripter.DefineClass(EDSWriter) do
  begin
    DefineMethod('Create',2,tkClass,EDSWriter,__EDSWriterCreate,true,0);
    DefineProp('ErrorCode',tkInteger,__GetEDSWriterErrorCode,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomPacketWriter) do
  begin
    DefineMethod('Create',0,tkClass,TCustomPacketWriter,__TCustomPacketWriterCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomPacketWriterDestroy,false,0);
  end;
  With Scripter.DefineClass(TDataPacketWriter) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TDataPacketWriterDestroy,false,0);
    DefineMethod('GetDataPacket',3,tkNone,nil,__TDataPacketWriterGetDataPacket,false,0).SetVarArgs([1,2]);
    DefineProp('Constraints',tkVariant,__GetTDataPacketWriterConstraints,__SetTDataPacketWriterConstraints,nil,false,0);
    DefineProp('PacketOptions',tkInteger,__GetTDataPacketWriterPacketOptions,__SetTDataPacketWriterPacketOptions,nil,false,0);
    DefineProp('Options',tkInteger,__GetTDataPacketWriterOptions,__SetTDataPacketWriterOptions,nil,false,0);
  end;
  With Scripter.DefineClass(TPacketDataSet) do
  begin
    DefineMethod('Create',1,tkClass,TPacketDataSet,__TPacketDataSetCreate,true,0);
    DefineMethod('AssignCurValues',1,tkNone,nil,__TPacketDataSetAssignCurValues,false,0);
    DefineMethod('CreateFromDelta',1,tkNone,nil,__TPacketDataSetCreateFromDelta,false,0);
    DefineMethod('HasCurValues',0,tkVariant,nil,__TPacketDataSetHasCurValues,false,0);
    DefineMethod('HasMergeConflicts',0,tkVariant,nil,__TPacketDataSetHasMergeConflicts,false,0);
    DefineMethod('InitAltRecBuffers',1,tkNone,nil,__TPacketDataSetInitAltRecBuffers,false,1);
    DefineMethod('UpdateKind',0,tkEnumeration,nil,__TPacketDataSetUpdateKind,false,0);
    DefineProp('NewValuesModified',tkVariant,__GetTPacketDataSetNewValuesModified,nil,nil,false,0);
    DefineProp('StreamMetaData',tkVariant,__GetTPacketDataSetStreamMetaData,__SetTPacketDataSetStreamMetaData,nil,false,0);
    DefineProp('UseCurValues',tkVariant,__GetTPacketDataSetUseCurValues,__SetTPacketDataSetUseCurValues,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomProvider) do
  begin
    DefineMethod('Create',1,tkClass,TCustomProvider,__TCustomProviderCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomProviderDestroy,false,0);
    DefineMethod('ApplyUpdates',3,tkVariant,nil,__TCustomProviderApplyUpdates,false,0).SetVarArgs([2]);
    DefineMethod('GetRecords',3,tkVariant,nil,__TCustomProviderGetRecords,false,0).SetVarArgs([1]);
    DefineMethod('RowRequest',3,tkVariant,nil,__TCustomProviderRowRequest,false,0).SetVarArgs([2]);
    DefineMethod('Execute',3,tkNone,nil,__TCustomProviderExecute,false,0).SetVarArgs([1,2]);
    DefineMethod('GetParams',1,tkVariant,nil,__TCustomProviderGetParams,false,0).SetVarArgs([0]);
    DefineMethod('DataRequest',1,tkVariant,nil,__TCustomProviderDataRequest,false,0);
    DefineProp('Data',tkVariant,__GetTCustomProviderData,nil,nil,false,0);
    DefineProp('Exported',tkVariant,__GetTCustomProviderExported,__SetTCustomProviderExported,nil,false,0);
  end;
  With Scripter.DefineClass(TBaseProvider) do
  begin
    DefineMethod('Create',1,tkClass,TBaseProvider,__TBaseProviderCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TBaseProviderDestroy,false,0);
    DefineProp('Resolver',tkClass,__GetTBaseProviderResolver,nil,TCustomResolver,false,0);
    DefineProp('Options',tkInteger,__GetTBaseProviderOptions,__SetTBaseProviderOptions,nil,false,0);
    DefineProp('UpdateMode',tkEnumeration,__GetTBaseProviderUpdateMode,__SetTBaseProviderUpdateMode,nil,false,0);
    DefineProp('OnDataRequest',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TDataSetProvider) do
  begin
    DefineMethod('Create',1,tkClass,TDataSetProvider,__TDataSetProviderCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDataSetProviderDestroy,false,0);
  end;
  With Scripter.DefineClass(TProvider) do
  begin
  end;
  With Scripter.DefineClass(TUpdateTree) do
  begin
    DefineMethod('Create',2,tkClass,TUpdateTree,__TUpdateTreeCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TUpdateTreeDestroy,false,0);
  end;
  With Scripter.DefineClass(TCustomResolver) do
  begin
    DefineMethod('Create',1,tkClass,TCustomResolver,__TCustomResolverCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomResolverDestroy,false,0);
  end;
  With Scripter.DefineClass(TDataSetResolver) do
  begin
    DefineMethod('Create',1,tkClass,TDataSetResolver,__TDataSetResolverCreate,true,0);
  end;
  With Scripter.DefineClass(TSQLResolver) do
  begin
    DefineMethod('Create',1,tkClass,TSQLResolver,__TSQLResolverCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TSQLResolverDestroy,false,0);
  end;
  With Scripter.DefineClass(TLocalAppServer) do
  begin
    DefineMethod('Create',1,tkClass,TLocalAppServer,__TLocalAppServerCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TLocalAppServerDestroy,false,0);
  end;
  DefineEventAdapter(TypeInfo(TDataRequestEvent), TatProviderDispatcher, @TatProviderDispatcher.__TDataRequestEvent);
  DefineEventAdapter(TypeInfo(TGetParamsEvent), TatProviderDispatcher, @TatProviderDispatcher.__TGetParamsEvent);
  DefineEventAdapter(TypeInfo(TProviderDataEvent), TatProviderDispatcher, @TatProviderDispatcher.__TProviderDataEvent);
  DefineEventAdapter(TypeInfo(TBeforeUpdateRecordEvent), TatProviderDispatcher, @TatProviderDispatcher.__TBeforeUpdateRecordEvent);
  DefineEventAdapter(TypeInfo(TAfterUpdateRecordEvent), TatProviderDispatcher, @TatProviderDispatcher.__TAfterUpdateRecordEvent);
  DefineEventAdapter(TypeInfo(TResolverErrorEvent), TatProviderDispatcher, @TatProviderDispatcher.__TResolverErrorEvent);
  DefineEventAdapter(TypeInfo(TGetTableNameEvent), TatProviderDispatcher, @TatProviderDispatcher.__TGetTableNameEvent);
  DefineEventAdapter(TypeInfo(TGetDSProps), TatProviderDispatcher, @TatProviderDispatcher.__TGetDSProps);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('GetObjectProperty',2,tkClass,TObject,__GetObjectProperty,false,0);
    DefineMethod('GetStringProperty',2,tkVariant,nil,__GetStringProperty,false,0);
    DefineMethod('VarArrayFromStrings',1,tkVariant,nil,__VarArrayFromStrings,false,0);
    DefineProp('InformixLob',tkVariant,__GetInformixLob,__SetInformixLob,nil,false,0);
    DefineProp('ResetOption',tkInteger,__GetResetOption,nil,nil,false,0);
    DefineProp('MetaDataOption',tkInteger,__GetMetaDataOption,nil,nil,false,0);
    DefineProp('XMLOption',tkInteger,__GetXMLOption,nil,nil,false,0);
    DefineProp('XMLUTF8Option',tkInteger,__GetXMLUTF8Option,nil,nil,false,0);
    AddConstant('grMetaData',grMetaData);
    AddConstant('grReset',grReset);
    AddConstant('grXML',grXML);
    AddConstant('grXMLUTF8',grXMLUTF8);
    AddConstant('poFetchBlobsOnDemand',poFetchBlobsOnDemand);
    AddConstant('poFetchDetailsOnDemand',poFetchDetailsOnDemand);
    AddConstant('poIncFieldProps',poIncFieldProps);
    AddConstant('poCascadeDeletes',poCascadeDeletes);
    AddConstant('poCascadeUpdates',poCascadeUpdates);
    AddConstant('poReadOnly',poReadOnly);
    AddConstant('poAllowMultiRecordUpdates',poAllowMultiRecordUpdates);
    AddConstant('poDisableInserts',poDisableInserts);
    AddConstant('poDisableEdits',poDisableEdits);
    AddConstant('poDisableDeletes',poDisableDeletes);
    AddConstant('poNoReset',poNoReset);
    AddConstant('poAutoRefresh',poAutoRefresh);
    AddConstant('poPropogateChanges',poPropogateChanges);
    AddConstant('poAllowCommandText',poAllowCommandText);
    AddConstant('poRetainServerOrder',poRetainServerOrder);
    AddConstant('rrSkip',rrSkip);
    AddConstant('rrAbort',rrAbort);
    AddConstant('rrMerge',rrMerge);
    AddConstant('rrApply',rrApply);
    AddConstant('rrIgnore',rrIgnore);
  end;
end;

class function TatProviderLibrary.LibraryName: string;
begin
  result := 'Provider';
end;

initialization
  RegisterScripterLibrary(TatProviderLibrary, True);

{$WARNINGS ON}

end.

