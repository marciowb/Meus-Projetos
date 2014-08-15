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
unit ap_CorbaObj;

interface

uses
  Variants,
  SysUtils,
  OrbPas,
  ActiveX,
  CorbaObj,
  ap_System,
  atScript;

type
  TatCorbaObjLibrary = class(TatScripterLibrary)
    procedure __GetECorbaExceptionName(AMachine: TatVirtualMachine);
    procedure __ECorbaUserExceptionCreate(AMachine: TatVirtualMachine);
    procedure __ECorbaUserExceptionCopy(AMachine: TatVirtualMachine);
    procedure __ECorbaUserExceptionThrow(AMachine: TatVirtualMachine);
    procedure __GetECorbaUserExceptionProxy(AMachine: TatVirtualMachine);
    procedure __TCorbaSkeletonDestroy(AMachine: TatVirtualMachine);
    procedure __TCorbaStubCreate(AMachine: TatVirtualMachine);
    procedure __TCorbaStubDestroy(AMachine: TatVirtualMachine);
    procedure __TCorbaListManagerCreate(AMachine: TatVirtualMachine);
    procedure __TCorbaListManagerDestroy(AMachine: TatVirtualMachine);
    procedure __TCorbaInterfaceIDManagerRegisterInterface(AMachine: TatVirtualMachine);
    procedure __TCorbaInterfaceIDManagerSearchGUID(AMachine: TatVirtualMachine);
    procedure __TCorbaInterfaceIDManagerSearchID(AMachine: TatVirtualMachine);
    procedure __TCorbaInterfaceIDManagerFindGUID(AMachine: TatVirtualMachine);
    procedure __TCorbaInterfaceIDManagerFindID(AMachine: TatVirtualMachine);
    procedure __TCorbaFactoryCreate(AMachine: TatVirtualMachine);
    procedure __TCorbaFactoryDestroy(AMachine: TatVirtualMachine);
    procedure __GetTCorbaFactoryInterfaceName(AMachine: TatVirtualMachine);
    procedure __GetTCorbaFactoryInstanceName(AMachine: TatVirtualMachine);
    procedure __GetTCorbaFactoryRepositoryID(AMachine: TatVirtualMachine);
    procedure __GetTCorbaFactoryInstancing(AMachine: TatVirtualMachine);
    procedure __GetTCorbaFactoryThreadModel(AMachine: TatVirtualMachine);
    procedure __TCorbaFactoryManagerDestroy(AMachine: TatVirtualMachine);
    procedure __TCorbaFactoryManagerAddFactory(AMachine: TatVirtualMachine);
    procedure __TCorbaFactoryManagerRegisterFactories(AMachine: TatVirtualMachine);
    procedure __TCorbaFactoryManagerFind(AMachine: TatVirtualMachine);
    procedure __TBOAInitialize(AMachine: TatVirtualMachine);
    procedure __TBOAImplIsReady(AMachine: TatVirtualMachine);
    procedure __TORBShutdown(AMachine: TatVirtualMachine);
    procedure __TORBFindTypeCode(AMachine: TatVirtualMachine);
    procedure __TORBMakeAlias(AMachine: TatVirtualMachine);
    procedure __TORBMakeTypeCode(AMachine: TatVirtualMachine);
    procedure __TORBMakeSequenceTypeCode(AMachine: TatVirtualMachine);
    procedure __TORBMakeStructureTypeCode(AMachine: TatVirtualMachine);
    procedure __TORBMakeAliasTypeCode(AMachine: TatVirtualMachine);
    procedure __TORBMakeObjectRefTypeCode(AMachine: TatVirtualMachine);
    procedure __CorbaInitialize(AMachine: TatVirtualMachine);
    procedure __BOA(AMachine: TatVirtualMachine);
    procedure __ORB(AMachine: TatVirtualMachine);
    procedure __VariantArrayToSequence(AMachine: TatVirtualMachine);
    procedure __SequenceToVariantArray(AMachine: TatVirtualMachine);
    procedure __MarshalAny(AMachine: TatVirtualMachine);
    procedure __UnmarshalAny(AMachine: TatVirtualMachine);
    procedure __UnmarshalText(AMachine: TatVirtualMachine);
    procedure __UnmarshalWideText(AMachine: TatVirtualMachine);
    procedure __MarshalWordBool(AMachine: TatVirtualMachine);
    procedure __UnmarshalWordBool(AMachine: TatVirtualMachine);
    procedure __GetCorbaSkeletonManager(AMachine: TatVirtualMachine);
    procedure __SetCorbaSkeletonManager(AMachine: TatVirtualMachine);
    procedure __GetCorbaStubManager(AMachine: TatVirtualMachine);
    procedure __SetCorbaStubManager(AMachine: TatVirtualMachine);
    procedure __GetCorbaInterfaceIDManager(AMachine: TatVirtualMachine);
    procedure __SetCorbaInterfaceIDManager(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  ECorbaExceptionClass = class of ECorbaException;
  ECorbaDispatchClass = class of ECorbaDispatch;
  ECorbaUserExceptionClass = class of ECorbaUserException;
  TCorbaSkeletonClass = class of TCorbaSkeleton;
  TCorbaStubClass = class of TCorbaStub;
  TCorbaDispatchStubClass = class of TCorbaDispatchStub;
  TCorbaListManagerClass = class of TCorbaListManager;
  TCorbaInterfaceIDManagerClass = class of TCorbaInterfaceIDManager;
  TCorbaSkeletonManagerClass = class of TCorbaSkeletonManager;
  TCorbaStubManagerClass = class of TCorbaStubManager;
  TCorbaImplementationClass = class of TCorbaImplementation;
  TCorbaFactoryClass = class of TCorbaFactory;
  TCorbaObjectFactoryClass = class of TCorbaObjectFactory;
  TCorbaFactoryManagerClass = class of TCorbaFactoryManager;
  TBOAClass = class of TBOA;
  TORBClass = class of TORB;


  TInterfaceIDEntryDescWrapper = class(TatRecordWrapper)
  private
    FRepositoryID: string;
  public
    constructor Create(ARecord: TInterfaceIDEntryDesc);
    function ObjToRec: TInterfaceIDEntryDesc;
  published
    property RepositoryID: string read FRepositoryID write FRepositoryID;
  end;
  
  TSkeletonEntryDescWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TSkeletonEntryDesc);
    function ObjToRec: TSkeletonEntryDesc;
  published
  end;
  
  TStubEntryDescWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TStubEntryDesc);
    function ObjToRec: TStubEntryDesc;
  published
  end;
  

implementation

{$WARNINGS OFF}

constructor TInterfaceIDEntryDescWrapper.Create(ARecord: TInterfaceIDEntryDesc);
begin
  inherited Create;
  FRepositoryID := ARecord.RepositoryID;
end;

function TInterfaceIDEntryDescWrapper.ObjToRec: TInterfaceIDEntryDesc;
begin
  result.RepositoryID := FRepositoryID;
end;

constructor TSkeletonEntryDescWrapper.Create(ARecord: TSkeletonEntryDesc);
begin
  inherited Create;
end;

function TSkeletonEntryDescWrapper.ObjToRec: TSkeletonEntryDesc;
begin
end;

constructor TStubEntryDescWrapper.Create(ARecord: TStubEntryDesc);
begin
  inherited Create;
end;

function TStubEntryDescWrapper.ObjToRec: TStubEntryDesc;
begin
end;



procedure TatCorbaObjLibrary.__GetECorbaExceptionName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(ECorbaException(CurrentObject).Name);
  end;
end;

procedure TatCorbaObjLibrary.__ECorbaUserExceptionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ECorbaUserExceptionClass(CurrentClass.ClassRef).Create(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__ECorbaUserExceptionCopy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ECorbaUserException(CurrentObject).Copy(GetInputArg(0));
  end;
end;

procedure TatCorbaObjLibrary.__ECorbaUserExceptionThrow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ECorbaUserException(CurrentObject).Throw;
  end;
end;

procedure TatCorbaObjLibrary.__GetECorbaUserExceptionProxy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(ECorbaUserException(CurrentObject).Proxy);
  end;
end;

procedure TatCorbaObjLibrary.__TCorbaSkeletonDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCorbaSkeleton(CurrentObject).Destroy;
  end;
end;

procedure TatCorbaObjLibrary.__TCorbaStubCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCorbaStubClass(CurrentClass.ClassRef).Create(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__TCorbaStubDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCorbaStub(CurrentObject).Destroy;
  end;
end;

procedure TatCorbaObjLibrary.__TCorbaListManagerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCorbaListManagerClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__TCorbaListManagerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCorbaListManager(CurrentObject).Destroy;
  end;
end;

procedure TatCorbaObjLibrary.__TCorbaInterfaceIDManagerRegisterInterface(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCorbaInterfaceIDManager(CurrentObject).RegisterInterface(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,GetInputArg(1));
  end;
end;

procedure TatCorbaObjLibrary.__TCorbaInterfaceIDManagerSearchGUID(AMachine: TatVirtualMachine);
  var
  Param1: TGUID;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := TGUIDWrapper(integer(GetInputArg(1))).ObjToRec;
AResult := TCorbaInterfaceIDManager(CurrentObject).SearchGUID(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__TCorbaInterfaceIDManagerSearchID(AMachine: TatVirtualMachine);
  var
  Param1: string;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := TCorbaInterfaceIDManager(CurrentObject).SearchID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__TCorbaInterfaceIDManagerFindGUID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TGUIDWrapper.Create(TCorbaInterfaceIDManager(CurrentObject).FindGUID(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__TCorbaInterfaceIDManagerFindID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCorbaInterfaceIDManager(CurrentObject).FindID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__TCorbaFactoryCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCorbaFactoryClass(CurrentClass.ClassRef).Create(GetInputArg(0),GetInputArg(1),GetInputArg(2),TGUIDWrapper(integer(GetInputArg(3))).ObjToRec,GetInputArg(4),GetInputArg(5)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__TCorbaFactoryDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCorbaFactory(CurrentObject).Destroy;
  end;
end;

procedure TatCorbaObjLibrary.__GetTCorbaFactoryInterfaceName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCorbaFactory(CurrentObject).InterfaceName);
  end;
end;

procedure TatCorbaObjLibrary.__GetTCorbaFactoryInstanceName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCorbaFactory(CurrentObject).InstanceName);
  end;
end;

procedure TatCorbaObjLibrary.__GetTCorbaFactoryRepositoryID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCorbaFactory(CurrentObject).RepositoryID);
  end;
end;

procedure TatCorbaObjLibrary.__GetTCorbaFactoryInstancing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCorbaFactory(CurrentObject).Instancing);
  end;
end;

procedure TatCorbaObjLibrary.__GetTCorbaFactoryThreadModel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCorbaFactory(CurrentObject).ThreadModel);
  end;
end;

procedure TatCorbaObjLibrary.__TCorbaFactoryManagerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCorbaFactoryManager(CurrentObject).Destroy;
  end;
end;

procedure TatCorbaObjLibrary.__TCorbaFactoryManagerAddFactory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCorbaFactoryManager(CurrentObject).AddFactory(TCorbaFactory(Integer(GetInputArg(0))));
  end;
end;

procedure TatCorbaObjLibrary.__TCorbaFactoryManagerRegisterFactories(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCorbaFactoryManager(CurrentObject).RegisterFactories;
  end;
end;

procedure TatCorbaObjLibrary.__TCorbaFactoryManagerFind(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCorbaFactoryManager(CurrentObject).Find(GetInputArg(0),GetInputArg(1),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__TBOAInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBOAClass(CurrentClass.ClassRef).Initialize(GetInputArg(0));
  end;
end;

procedure TatCorbaObjLibrary.__TBOAImplIsReady(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBOA(CurrentObject).ImplIsReady;
  end;
end;

procedure TatCorbaObjLibrary.__TORBShutdown(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TORB(CurrentObject).Shutdown;
  end;
end;

procedure TatCorbaObjLibrary.__TORBFindTypeCode(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TORB(CurrentObject).FindTypeCode(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__TORBMakeAlias(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TORB(CurrentObject).MakeAlias(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__TORBMakeTypeCode(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TORB(CurrentObject).MakeTypeCode(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__TORBMakeSequenceTypeCode(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TORB(CurrentObject).MakeSequenceTypeCode(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__TORBMakeStructureTypeCode(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TORB(CurrentObject).MakeStructureTypeCode(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__TORBMakeAliasTypeCode(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TORB(CurrentObject).MakeAliasTypeCode(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__TORBMakeObjectRefTypeCode(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TORB(CurrentObject).MakeObjectRefTypeCode(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__CorbaInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    CorbaObj.CorbaInitialize;
  end;
end;

procedure TatCorbaObjLibrary.__BOA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(CorbaObj.BOA);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__ORB(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(CorbaObj.ORB);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__VariantArrayToSequence(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorbaObj.VariantArrayToSequence(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__SequenceToVariantArray(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorbaObj.SequenceToVariantArray(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__MarshalAny(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    CorbaObj.MarshalAny(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatCorbaObjLibrary.__UnmarshalAny(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorbaObj.UnmarshalAny(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__UnmarshalText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorbaObj.UnmarshalText(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__UnmarshalWideText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorbaObj.UnmarshalWideText(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__MarshalWordBool(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    CorbaObj.MarshalWordBool(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatCorbaObjLibrary.__UnmarshalWordBool(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorbaObj.UnmarshalWordBool(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaObjLibrary.__GetCorbaSkeletonManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(CorbaObj.CorbaSkeletonManager));
  end;
end;

procedure TatCorbaObjLibrary.__SetCorbaSkeletonManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    CorbaObj.CorbaSkeletonManager:=TCorbaSkeletonManager(Integer(GetInputArg(0)));
  end;
end;

procedure TatCorbaObjLibrary.__GetCorbaStubManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(CorbaObj.CorbaStubManager));
  end;
end;

procedure TatCorbaObjLibrary.__SetCorbaStubManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    CorbaObj.CorbaStubManager:=TCorbaStubManager(Integer(GetInputArg(0)));
  end;
end;

procedure TatCorbaObjLibrary.__GetCorbaInterfaceIDManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(CorbaObj.CorbaInterfaceIDManager));
  end;
end;

procedure TatCorbaObjLibrary.__SetCorbaInterfaceIDManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    CorbaObj.CorbaInterfaceIDManager:=TCorbaInterfaceIDManager(Integer(GetInputArg(0)));
  end;
end;

procedure TatCorbaObjLibrary.Init;
begin
  With Scripter.DefineClass(ECorbaException) do
  begin
    DefineProp('Name',tkVariant,__GetECorbaExceptionName,nil,nil,false,0);
  end;
  With Scripter.DefineClass(ECorbaDispatch) do
  begin
  end;
  With Scripter.DefineClass(ECorbaUserException) do
  begin
    DefineMethod('Create',1,tkClass,ECorbaUserException,__ECorbaUserExceptionCreate,true);
    DefineMethod('Copy',1,tkNone,nil,__ECorbaUserExceptionCopy,false);
    DefineMethod('Throw',0,tkNone,nil,__ECorbaUserExceptionThrow,false);
    DefineProp('Proxy',tkVariant,__GetECorbaUserExceptionProxy,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TCorbaSkeleton) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TCorbaSkeletonDestroy,false);
  end;
  With Scripter.DefineClass(TCorbaStub) do
  begin
    DefineMethod('Create',1,tkClass,TCorbaStub,__TCorbaStubCreate,true);
    DefineMethod('Destroy',0,tkNone,nil,__TCorbaStubDestroy,false);
  end;
  With Scripter.DefineClass(TCorbaDispatchStub) do
  begin
  end;
  With Scripter.DefineClass(TCorbaListManager) do
  begin
    DefineMethod('Create',0,tkClass,TCorbaListManager,__TCorbaListManagerCreate,true);
    DefineMethod('Destroy',0,tkNone,nil,__TCorbaListManagerDestroy,false);
  end;
  With Scripter.DefineClass(TCorbaInterfaceIDManager) do
  begin
    DefineMethod('RegisterInterface',2,tkNone,nil,__TCorbaInterfaceIDManagerRegisterInterface,false);
    DefineMethod('SearchGUID',2,tkVariant,nil,__TCorbaInterfaceIDManagerSearchGUID,false);
    DefineMethod('SearchID',2,tkVariant,nil,__TCorbaInterfaceIDManagerSearchID,false);
    DefineMethod('FindGUID',1,tkVariant,nil,__TCorbaInterfaceIDManagerFindGUID,false);
    DefineMethod('FindID',1,tkVariant,nil,__TCorbaInterfaceIDManagerFindID,false);
  end;
  With Scripter.DefineClass(TCorbaSkeletonManager) do
  begin
  end;
  With Scripter.DefineClass(TCorbaStubManager) do
  begin
  end;
  With Scripter.DefineClass(TCorbaImplementation) do
  begin
  end;
  With Scripter.DefineClass(TCorbaFactory) do
  begin
    DefineMethod('Create',6,tkClass,TCorbaFactory,__TCorbaFactoryCreate,true);
    DefineMethod('Destroy',0,tkNone,nil,__TCorbaFactoryDestroy,false);
    DefineProp('InterfaceName',tkVariant,__GetTCorbaFactoryInterfaceName,nil,nil,false,0);
    DefineProp('InstanceName',tkVariant,__GetTCorbaFactoryInstanceName,nil,nil,false,0);
    DefineProp('RepositoryID',tkVariant,__GetTCorbaFactoryRepositoryID,nil,nil,false,0);
    DefineProp('Instancing',tkEnumeration,__GetTCorbaFactoryInstancing,nil,nil,false,0);
    DefineProp('ThreadModel',tkEnumeration,__GetTCorbaFactoryThreadModel,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TCorbaObjectFactory) do
  begin
  end;
  With Scripter.DefineClass(TCorbaFactoryManager) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TCorbaFactoryManagerDestroy,false);
    DefineMethod('AddFactory',1,tkNone,nil,__TCorbaFactoryManagerAddFactory,false);
    DefineMethod('RegisterFactories',0,tkNone,nil,__TCorbaFactoryManagerRegisterFactories,false);
    DefineMethod('Find',3,tkClass,TCorbaFactory,__TCorbaFactoryManagerFind,false);
  end;
  With Scripter.DefineClass(TBOA) do
  begin
    DefineMethod('Initialize',1,tkNone,nil,__TBOAInitialize,true);
    DefineMethod('ImplIsReady',0,tkNone,nil,__TBOAImplIsReady,false);
  end;
  With Scripter.DefineClass(TORB) do
  begin
    DefineMethod('Shutdown',0,tkNone,nil,__TORBShutdown,false);
    DefineMethod('FindTypeCode',1,tkVariant,nil,__TORBFindTypeCode,false);
    DefineMethod('MakeAlias',4,tkVariant,nil,__TORBMakeAlias,false);
    DefineMethod('MakeTypeCode',1,tkVariant,nil,__TORBMakeTypeCode,false);
    DefineMethod('MakeSequenceTypeCode',2,tkVariant,nil,__TORBMakeSequenceTypeCode,false);
    DefineMethod('MakeStructureTypeCode',3,tkVariant,nil,__TORBMakeStructureTypeCode,false);
    DefineMethod('MakeAliasTypeCode',3,tkVariant,nil,__TORBMakeAliasTypeCode,false);
    DefineMethod('MakeObjectRefTypeCode',2,tkVariant,nil,__TORBMakeObjectRefTypeCode,false);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('CorbaInitialize',0,tkNone,nil,__CorbaInitialize,false);
    DefineMethod('BOA',0,tkClass,TBOA,__BOA,false);
    DefineMethod('ORB',0,tkClass,TORB,__ORB,false);
    DefineMethod('VariantArrayToSequence',2,tkVariant,nil,__VariantArrayToSequence,false);
    DefineMethod('SequenceToVariantArray',1,tkVariant,nil,__SequenceToVariantArray,false);
    DefineMethod('MarshalAny',2,tkNone,nil,__MarshalAny,false);
    DefineMethod('UnmarshalAny',1,tkVariant,nil,__UnmarshalAny,false);
    DefineMethod('UnmarshalText',1,tkVariant,nil,__UnmarshalText,false);
    DefineMethod('UnmarshalWideText',1,tkVariant,nil,__UnmarshalWideText,false);
    DefineMethod('MarshalWordBool',2,tkNone,nil,__MarshalWordBool,false);
    DefineMethod('UnmarshalWordBool',1,tkVariant,nil,__UnmarshalWordBool,false);
    DefineProp('CorbaSkeletonManager',tkClass,__GetCorbaSkeletonManager,__SetCorbaSkeletonManager,TCorbaSkeletonManager,false,0);
    DefineProp('CorbaStubManager',tkClass,__GetCorbaStubManager,__SetCorbaStubManager,TCorbaStubManager,false,0);
    DefineProp('CorbaInterfaceIDManager',tkClass,__GetCorbaInterfaceIDManager,__SetCorbaInterfaceIDManager,TCorbaInterfaceIDManager,false,0);
    AddConstant('tmMultiThreaded',tmMultiThreaded);
    AddConstant('tmSingleThread',tmSingleThread);
    AddConstant('iSingleInstance',iSingleInstance);
    AddConstant('iMultiInstance',iMultiInstance);
  end;
end;

class function TatCorbaObjLibrary.LibraryName: string;
begin
  result := 'CorbaObj';
end;

initialization
  RegisterScripterLibrary(TatCorbaObjLibrary, True);

{$WARNINGS ON}

end.
