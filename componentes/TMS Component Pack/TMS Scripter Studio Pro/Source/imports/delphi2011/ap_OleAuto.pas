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
unit ap_OleAuto;

interface

uses
  Windows,
  Ole2,
  OleCtl,
  SysUtils,
  {$WARNINGS OFF}
  OleAuto,
  {$WARNINGS ON}
  Variants,
  ap_Ole2,
  atScript;

{$WARNINGS OFF}

type
  TatOleAutoLibrary = class(TatScripterLibrary)
    procedure __TAutoDispatchCreate(AMachine: TatVirtualMachine);
    procedure __TAutoDispatchQueryInterface(AMachine: TatVirtualMachine);
    procedure __TAutoDispatchAddRef(AMachine: TatVirtualMachine);
    procedure __TAutoDispatchRelease(AMachine: TatVirtualMachine);
    procedure __TAutoDispatchGetTypeInfoCount(AMachine: TatVirtualMachine);
    procedure __TAutoDispatchGetTypeInfo(AMachine: TatVirtualMachine);
    procedure __TAutoDispatchGetAutoObject(AMachine: TatVirtualMachine);
    procedure __GetTAutoDispatchAutoObject(AMachine: TatVirtualMachine);
    procedure __TAutoObjectCreate(AMachine: TatVirtualMachine);
    procedure __TAutoObjectDestroy(AMachine: TatVirtualMachine);
    procedure __TAutoObjectAddRef(AMachine: TatVirtualMachine);
    procedure __TAutoObjectRelease(AMachine: TatVirtualMachine);
    procedure __GetTAutoObjectAutoDispatch(AMachine: TatVirtualMachine);
    procedure __GetTAutoObjectOleObject(AMachine: TatVirtualMachine);
    procedure __GetTAutoObjectRefCount(AMachine: TatVirtualMachine);
    procedure __TRegistryClassCreate(AMachine: TatVirtualMachine);
    procedure __TRegistryClassDestroy(AMachine: TatVirtualMachine);
    procedure __TRegistryClassUpdateRegistry(AMachine: TatVirtualMachine);
    procedure __TAutomationCreate(AMachine: TatVirtualMachine);
    procedure __TAutomationDestroy(AMachine: TatVirtualMachine);
    procedure __TAutomationRegisterClass(AMachine: TatVirtualMachine);
    procedure __TAutomationUpdateRegistry(AMachine: TatVirtualMachine);
    procedure __GetTAutomationAutoObjectCount(AMachine: TatVirtualMachine);
    procedure __GetTAutomationIsInprocServer(AMachine: TatVirtualMachine);
    procedure __SetTAutomationIsInprocServer(AMachine: TatVirtualMachine);
    procedure __GetTAutomationStartMode(AMachine: TatVirtualMachine);
    procedure __EOleSysErrorCreate(AMachine: TatVirtualMachine);
    procedure __GetEOleSysErrorErrorCode(AMachine: TatVirtualMachine);
    procedure __EOleExceptionCreate(AMachine: TatVirtualMachine);
    procedure __GetEOleExceptionErrorCode(AMachine: TatVirtualMachine);
    procedure __GetEOleExceptionHelpFile(AMachine: TatVirtualMachine);
    procedure __GetEOleExceptionSource(AMachine: TatVirtualMachine);
    procedure __CreateOleObject(AMachine: TatVirtualMachine);
    procedure __GetActiveOleObject(AMachine: TatVirtualMachine);
    procedure __DllGetClassObject(AMachine: TatVirtualMachine);
    procedure __DllCanUnloadNow(AMachine: TatVirtualMachine);
    procedure __DllRegisterServer(AMachine: TatVirtualMachine);
    procedure __DllUnregisterServer(AMachine: TatVirtualMachine);
    procedure __VarFromInterface(AMachine: TatVirtualMachine);
    procedure __VarToInterface(AMachine: TatVirtualMachine);
    procedure __VarToAutoObject(AMachine: TatVirtualMachine);
    procedure __DispInvokeError(AMachine: TatVirtualMachine);
    procedure __OleError(AMachine: TatVirtualMachine);
    procedure __OleCheck(AMachine: TatVirtualMachine);
    procedure __StringToClassID(AMachine: TatVirtualMachine);
    procedure __ClassIDToString(AMachine: TatVirtualMachine);
    procedure __ProgIDToClassID(AMachine: TatVirtualMachine);
    procedure __ClassIDToProgID(AMachine: TatVirtualMachine);
    procedure __GetAutomation(AMachine: TatVirtualMachine);
    procedure __SetAutomation(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TAutoDispatchClass = class of TAutoDispatch;
  TAutoObjectClass = class of TAutoObject;
  TRegistryClassClass = class of TRegistryClass;
  TAutomationClass = class of TAutomation;
  EOleErrorClass = class of EOleError;
  EOleSysErrorClass = class of EOleSysError;
  EOleExceptionClass = class of EOleException;

  TatOleAutoDispatcher = class(TatEventDispatcher)
  private
    procedure __TLastReleaseEvent(var Shutdown: Boolean);
  end;

  TAutoClassInfoWrapper = class(TatRecordWrapper)
  private
    FProgID: string;
    FClassID: string;
    FDescription: string;
    FInstancing: TAutoClassInstancing;
  public
    constructor Create(ARecord: TAutoClassInfo);
    function ObjToRec: TAutoClassInfo;
  published
    property ProgID: string read FProgID write FProgID;
    property ClassID: string read FClassID write FClassID;
    property Description: string read FDescription write FDescription;
    property Instancing: TAutoClassInstancing read FInstancing write FInstancing;
  end;
  

implementation

constructor TAutoClassInfoWrapper.Create(ARecord: TAutoClassInfo);
begin
  inherited Create;
  FProgID := ARecord.ProgID;
  FClassID := ARecord.ClassID;
  FDescription := ARecord.Description;
  FInstancing := ARecord.Instancing;
end;

function TAutoClassInfoWrapper.ObjToRec: TAutoClassInfo;
begin
  result.ProgID := FProgID;
  result.ClassID := FClassID;
  result.Description := FDescription;
  result.Instancing := FInstancing;
end;



procedure TatOleAutoLibrary.__TAutoDispatchCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAutoDispatchClass(CurrentClass.ClassRef).Create(TAutoObject(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__TAutoDispatchQueryInterface(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := TAutoDispatch(CurrentObject).QueryInterface(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOleAutoLibrary.__TAutoDispatchAddRef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAutoDispatch(CurrentObject).AddRef);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__TAutoDispatchRelease(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAutoDispatch(CurrentObject).Release);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__TAutoDispatchGetTypeInfoCount(AMachine: TatVirtualMachine);
  var
  Param0: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := TAutoDispatch(CurrentObject).GetTypeInfoCount(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleAutoLibrary.__TAutoDispatchGetTypeInfo(AMachine: TatVirtualMachine);
  var
  Param2: ITypeInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := ITypeInfo(Integer(GetInputArg(2)));
AResult := TAutoDispatch(CurrentObject).GetTypeInfo(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOleAutoLibrary.__TAutoDispatchGetAutoObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAutoDispatch(CurrentObject).GetAutoObject);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__GetTAutoDispatchAutoObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAutoDispatch(CurrentObject).AutoObject));
  end;
end;

procedure TatOleAutoLibrary.__TAutoObjectCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAutoObjectClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__TAutoObjectDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAutoObject(CurrentObject).Destroy;
  end;
end;

procedure TatOleAutoLibrary.__TAutoObjectAddRef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAutoObject(CurrentObject).AddRef);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__TAutoObjectRelease(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAutoObject(CurrentObject).Release);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__GetTAutoObjectAutoDispatch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAutoObject(CurrentObject).AutoDispatch));
  end;
end;

procedure TatOleAutoLibrary.__GetTAutoObjectOleObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TAutoObject(CurrentObject).OleObject);
  end;
end;

procedure TatOleAutoLibrary.__GetTAutoObjectRefCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAutoObject(CurrentObject).RefCount));
  end;
end;

procedure TatOleAutoLibrary.__TRegistryClassCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRegistryClassClass(CurrentClass.ClassRef).Create(TAutoClassInfoWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__TRegistryClassDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistryClass(CurrentObject).Destroy;
  end;
end;

procedure TatOleAutoLibrary.__TRegistryClassUpdateRegistry(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRegistryClass(CurrentObject).UpdateRegistry(GetInputArg(0));
  end;
end;

procedure TatOleAutoLibrary.__TAutomationCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAutomationClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__TAutomationDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAutomation(CurrentObject).Destroy;
  end;
end;

procedure TatOleAutoLibrary.__TAutomationRegisterClass(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAutomation(CurrentObject).RegisterClass(TAutoClassInfoWrapper(integer(GetInputArg(0))).ObjToRec);
  end;
end;

procedure TatOleAutoLibrary.__TAutomationUpdateRegistry(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAutomation(CurrentObject).UpdateRegistry(GetInputArg(0));
  end;
end;

procedure TatOleAutoLibrary.__GetTAutomationAutoObjectCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAutomation(CurrentObject).AutoObjectCount));
  end;
end;

procedure TatOleAutoLibrary.__GetTAutomationIsInprocServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TAutomation(CurrentObject).IsInprocServer);
  end;
end;

procedure TatOleAutoLibrary.__SetTAutomationIsInprocServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAutomation(CurrentObject).IsInprocServer:=GetInputArg(0);
  end;
end;

procedure TatOleAutoLibrary.__GetTAutomationStartMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TAutomation(CurrentObject).StartMode);
  end;
end;

procedure TatOleAutoLibrary.__EOleSysErrorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(EOleSysErrorClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__GetEOleSysErrorErrorCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(EOleSysError(CurrentObject).ErrorCode));
  end;
end;

procedure TatOleAutoLibrary.__EOleExceptionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(EOleExceptionClass(CurrentClass.ClassRef).Create(tagEXCEPINFOWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__GetEOleExceptionErrorCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(EOleException(CurrentObject).ErrorCode));
  end;
end;

procedure TatOleAutoLibrary.__GetEOleExceptionHelpFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(EOleException(CurrentObject).HelpFile);
  end;
end;

procedure TatOleAutoLibrary.__GetEOleExceptionSource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(EOleException(CurrentObject).Source);
  end;
end;

procedure TatOleAutoDispatcher.__TLastReleaseEvent(var Shutdown: Boolean);
var
  ShutdownTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLastReleaseEvent(BeforeCall)(Shutdown);
    ShutdownTemp := Shutdown;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [ShutdownTemp]);
    Shutdown := ShutdownTemp;
    if AssignedMethod(AfterCall) then
      TLastReleaseEvent(AfterCall)(Shutdown);
  end;
end;

procedure TatOleAutoLibrary.__CreateOleObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := OleAuto.CreateOleObject(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__GetActiveOleObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := OleAuto.GetActiveOleObject(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__DllGetClassObject(AMachine: TatVirtualMachine);
  var
  Param2: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := OleAuto.DllGetClassObject(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatOleAutoLibrary.__DllCanUnloadNow(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := OleAuto.DllCanUnloadNow;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__DllRegisterServer(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := OleAuto.DllRegisterServer;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__DllUnregisterServer(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := OleAuto.DllUnregisterServer;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__VarFromInterface(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := OleAuto.VarFromInterface(IUnknown(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__VarToInterface(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(OleAuto.VarToInterface(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__VarToAutoObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(OleAuto.VarToAutoObject(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__DispInvokeError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OleAuto.DispInvokeError(GetInputArg(0),tagEXCEPINFOWrapper(integer(GetInputArg(1))).ObjToRec);
  end;
end;

procedure TatOleAutoLibrary.__OleError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OleAuto.OleError(GetInputArg(0));
  end;
end;

procedure TatOleAutoLibrary.__OleCheck(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OleAuto.OleCheck(GetInputArg(0));
  end;
end;

procedure TatOleAutoLibrary.__StringToClassID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TGUIDWrapper.Create(OleAuto.StringToClassID(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__ClassIDToString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := OleAuto.ClassIDToString(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__ProgIDToClassID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TGUIDWrapper.Create(OleAuto.ProgIDToClassID(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__ClassIDToProgID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := OleAuto.ClassIDToProgID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleAutoLibrary.__GetAutomation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(OleAuto.Automation));
  end;
end;

procedure TatOleAutoLibrary.__SetAutomation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OleAuto.Automation:=TAutomation(Integer(GetInputArg(0)));
  end;
end;

procedure TatOleAutoLibrary.Init;
begin
  With Scripter.DefineClass(TAutoDispatch) do
  begin
    DefineMethod('Create',1,tkClass,TAutoDispatch,__TAutoDispatchCreate,true,0);
    DefineMethod('QueryInterface',2,tkVariant,nil,__TAutoDispatchQueryInterface,false,0).SetVarArgs([1]);
    DefineMethod('AddRef',0,tkInteger,nil,__TAutoDispatchAddRef,false,0);
    DefineMethod('Release',0,tkInteger,nil,__TAutoDispatchRelease,false,0);
    DefineMethod('GetTypeInfoCount',1,tkVariant,nil,__TAutoDispatchGetTypeInfoCount,false,0).SetVarArgs([0]);
    DefineMethod('GetTypeInfo',3,tkVariant,nil,__TAutoDispatchGetTypeInfo,false,0).SetVarArgs([2]);
    DefineMethod('GetAutoObject',0,tkClass,TAutoObject,__TAutoDispatchGetAutoObject,false,0);
    DefineProp('AutoObject',tkClass,__GetTAutoDispatchAutoObject,nil,TAutoObject,false,0);
  end;
  With Scripter.DefineClass(TAutoObject) do
  begin
    DefineMethod('Create',0,tkClass,TAutoObject,__TAutoObjectCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TAutoObjectDestroy,false,0);
    DefineMethod('AddRef',0,tkInteger,nil,__TAutoObjectAddRef,false,0);
    DefineMethod('Release',0,tkInteger,nil,__TAutoObjectRelease,false,0);
    DefineProp('AutoDispatch',tkClass,__GetTAutoObjectAutoDispatch,nil,TAutoDispatch,false,0);
    DefineProp('OleObject',tkVariant,__GetTAutoObjectOleObject,nil,nil,false,0);
    DefineProp('RefCount',tkInteger,__GetTAutoObjectRefCount,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRegistryClass) do
  begin
    DefineMethod('Create',1,tkClass,TRegistryClass,__TRegistryClassCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TRegistryClassDestroy,false,0);
    DefineMethod('UpdateRegistry',1,tkNone,nil,__TRegistryClassUpdateRegistry,false,0);
  end;
  With Scripter.DefineClass(TAutomation) do
  begin
    DefineMethod('Create',0,tkClass,TAutomation,__TAutomationCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TAutomationDestroy,false,0);
    DefineMethod('RegisterClass',1,tkNone,nil,__TAutomationRegisterClass,false,0);
    DefineMethod('UpdateRegistry',1,tkNone,nil,__TAutomationUpdateRegistry,false,0);
    DefineProp('AutoObjectCount',tkInteger,__GetTAutomationAutoObjectCount,nil,nil,false,0);
    DefineProp('IsInprocServer',tkVariant,__GetTAutomationIsInprocServer,__SetTAutomationIsInprocServer,nil,false,0);
    DefineProp('StartMode',tkEnumeration,__GetTAutomationStartMode,nil,nil,false,0);
  end;
  With Scripter.DefineClass(EOleError) do
  begin
  end;
  With Scripter.DefineClass(EOleSysError) do
  begin
    DefineMethod('Create',1,tkClass,EOleSysError,__EOleSysErrorCreate,true,0);
    DefineProp('ErrorCode',tkInteger,__GetEOleSysErrorErrorCode,nil,nil,false,0);
  end;
  With Scripter.DefineClass(EOleException) do
  begin
    DefineMethod('Create',1,tkClass,EOleException,__EOleExceptionCreate,true,0);
    DefineProp('ErrorCode',tkInteger,__GetEOleExceptionErrorCode,nil,nil,false,0);
    DefineProp('HelpFile',tkVariant,__GetEOleExceptionHelpFile,nil,nil,false,0);
    DefineProp('Source',tkVariant,__GetEOleExceptionSource,nil,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TLastReleaseEvent), TatOleAutoDispatcher, @TatOleAutoDispatcher.__TLastReleaseEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('CreateOleObject',1,tkVariant,nil,__CreateOleObject,false,0);
    DefineMethod('GetActiveOleObject',1,tkVariant,nil,__GetActiveOleObject,false,0);
    DefineMethod('DllGetClassObject',3,tkVariant,nil,__DllGetClassObject,false,0).SetVarArgs([2]);
    DefineMethod('DllCanUnloadNow',0,tkVariant,nil,__DllCanUnloadNow,false,0);
    DefineMethod('DllRegisterServer',0,tkVariant,nil,__DllRegisterServer,false,0);
    DefineMethod('DllUnregisterServer',0,tkVariant,nil,__DllUnregisterServer,false,0);
    DefineMethod('VarFromInterface',1,tkVariant,nil,__VarFromInterface,false,0);
    DefineMethod('VarToInterface',1,tkClass,IDispatch,__VarToInterface,false,0);
    DefineMethod('VarToAutoObject',1,tkClass,TAutoObject,__VarToAutoObject,false,0);
    DefineMethod('DispInvokeError',2,tkNone,nil,__DispInvokeError,false,0);
    DefineMethod('OleError',1,tkNone,nil,__OleError,false,0);
    DefineMethod('OleCheck',1,tkNone,nil,__OleCheck,false,0);
    DefineMethod('StringToClassID',1,tkVariant,nil,__StringToClassID,false,0);
    DefineMethod('ClassIDToString',1,tkVariant,nil,__ClassIDToString,false,0);
    DefineMethod('ProgIDToClassID',1,tkVariant,nil,__ProgIDToClassID,false,0);
    DefineMethod('ClassIDToProgID',1,tkVariant,nil,__ClassIDToProgID,false,0);
    DefineProp('Automation',tkClass,__GetAutomation,__SetAutomation,TAutomation,false,0);
    AddConstant('acInternal',acInternal);
    AddConstant('acSingleInstance',acSingleInstance);
    AddConstant('acMultiInstance',acMultiInstance);
    AddConstant('smStandalone',smStandalone);
    AddConstant('smAutomation',smAutomation);
    AddConstant('smRegServer',smRegServer);
    AddConstant('smUnregServer',smUnregServer);
    AddConstant('MaxDispArgs',MaxDispArgs);
  end;
end;

class function TatOleAutoLibrary.LibraryName: string;
begin
  result := 'OleAuto';
end;

initialization
  RegisterScripterLibrary(TatOleAutoLibrary, True);

{$WARNINGS ON}

end.

