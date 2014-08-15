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
unit ap_ComServ;

interface

uses
  Windows,
  Messages,
  ActiveX,
  SysUtils,
  ComObj,
  ComServ,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatComServLibrary = class(TatScripterLibrary)
    procedure __TComServerCreate(AMachine: TatVirtualMachine);
    procedure __TComServerDestroy(AMachine: TatVirtualMachine);
    procedure __TComServerInitialize(AMachine: TatVirtualMachine);
    procedure __TComServerLoadTypeLib(AMachine: TatVirtualMachine);
    procedure __TComServerSetServerName(AMachine: TatVirtualMachine);
    procedure __TComServerUpdateRegistry(AMachine: TatVirtualMachine);
    procedure __GetTComServerIsInprocServer(AMachine: TatVirtualMachine);
    procedure __SetTComServerIsInprocServer(AMachine: TatVirtualMachine);
    procedure __GetTComServerObjectCount(AMachine: TatVirtualMachine);
    procedure __GetTComServerFactoryCount(AMachine: TatVirtualMachine);
    procedure __GetTComServerStartMode(AMachine: TatVirtualMachine);
    procedure __GetTComServerUIInteractive(AMachine: TatVirtualMachine);
    procedure __SetTComServerUIInteractive(AMachine: TatVirtualMachine);
    procedure __GetComServer(AMachine: TatVirtualMachine);
    procedure __DllGetClassObject(AMachine: TatVirtualMachine);
    procedure __DllCanUnloadNow(AMachine: TatVirtualMachine);
    procedure __DllRegisterServer(AMachine: TatVirtualMachine);
    procedure __DllUnregisterServer(AMachine: TatVirtualMachine);
    procedure __DllInstall(AMachine: TatVirtualMachine);
    procedure __SetComServer(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TComServerClass = class of TComServer;

  TatComServDispatcher = class(TatEventDispatcher)
  private
    procedure __TLastReleaseEvent(var Shutdown: Boolean);
  end;


implementation



procedure TatComServLibrary.__TComServerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComServerClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComServLibrary.__TComServerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComServer(CurrentObject).Destroy;
  end;
end;

procedure TatComServLibrary.__TComServerInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComServer(CurrentObject).Initialize;
  end;
end;

procedure TatComServLibrary.__TComServerLoadTypeLib(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComServer(CurrentObject).LoadTypeLib;
  end;
end;

procedure TatComServLibrary.__TComServerSetServerName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComServer(CurrentObject).SetServerName(GetInputArg(0));
  end;
end;

procedure TatComServLibrary.__TComServerUpdateRegistry(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComServer(CurrentObject).UpdateRegistry(GetInputArg(0));
  end;
end;

procedure TatComServLibrary.__GetTComServerIsInprocServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComServer(CurrentObject).IsInprocServer);
  end;
end;

procedure TatComServLibrary.__SetTComServerIsInprocServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComServer(CurrentObject).IsInprocServer:=GetInputArg(0);
  end;
end;

procedure TatComServLibrary.__GetTComServerObjectCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TComServer(CurrentObject).ObjectCount));
  end;
end;

procedure TatComServLibrary.__GetTComServerFactoryCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TComServer(CurrentObject).FactoryCount));
  end;
end;

procedure TatComServLibrary.__GetTComServerStartMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComServer(CurrentObject).StartMode);
  end;
end;

procedure TatComServLibrary.__GetTComServerUIInteractive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComServer(CurrentObject).UIInteractive);
  end;
end;

procedure TatComServLibrary.__SetTComServerUIInteractive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComServer(CurrentObject).UIInteractive:=GetInputArg(0);
  end;
end;

procedure TatComServDispatcher.__TLastReleaseEvent(var Shutdown: Boolean);
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

procedure TatComServLibrary.__GetComServer(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ComServ.GetComServer);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComServLibrary.__DllGetClassObject(AMachine: TatVirtualMachine);
  var
  Param2: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := ComServ.DllGetClassObject(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatComServLibrary.__DllCanUnloadNow(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ComServ.DllCanUnloadNow;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComServLibrary.__DllRegisterServer(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ComServ.DllRegisterServer;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComServLibrary.__DllUnregisterServer(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ComServ.DllUnregisterServer;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComServLibrary.__DllInstall(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ComServ.DllInstall(GetInputArg(0),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComServLibrary.__SetComServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ComServ.ComServer:=TComServer(Integer(GetInputArg(0)));
  end;
end;

procedure TatComServLibrary.Init;
begin
  With Scripter.DefineClass(TComServer) do
  begin
    DefineMethod('Create',0,tkClass,TComServer,__TComServerCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TComServerDestroy,false,0);
    DefineMethod('Initialize',0,tkNone,nil,__TComServerInitialize,false,0);
    DefineMethod('LoadTypeLib',0,tkNone,nil,__TComServerLoadTypeLib,false,0);
    DefineMethod('SetServerName',1,tkNone,nil,__TComServerSetServerName,false,0);
    DefineMethod('UpdateRegistry',1,tkNone,nil,__TComServerUpdateRegistry,false,0);
    DefineProp('IsInprocServer',tkVariant,__GetTComServerIsInprocServer,__SetTComServerIsInprocServer,nil,false,0);
    DefineProp('ObjectCount',tkInteger,__GetTComServerObjectCount,nil,nil,false,0);
    DefineProp('FactoryCount',tkInteger,__GetTComServerFactoryCount,nil,nil,false,0);
    DefineProp('StartMode',tkEnumeration,__GetTComServerStartMode,nil,nil,false,0);
    DefineProp('UIInteractive',tkVariant,__GetTComServerUIInteractive,__SetTComServerUIInteractive,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TLastReleaseEvent), TatComServDispatcher, @TatComServDispatcher.__TLastReleaseEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('GetComServer',0,tkClass,TComServer,__GetComServer,false,0);
    DefineMethod('DllGetClassObject',3,tkVariant,nil,__DllGetClassObject,false,0).SetVarArgs([2]);
    DefineMethod('DllCanUnloadNow',0,tkVariant,nil,__DllCanUnloadNow,false,0);
    DefineMethod('DllRegisterServer',0,tkVariant,nil,__DllRegisterServer,false,0);
    DefineMethod('DllUnregisterServer',0,tkVariant,nil,__DllUnregisterServer,false,0);
    DefineMethod('DllInstall',2,tkVariant,nil,__DllInstall,false,0);
    DefineProp('ComServer',tkClass,__GetComServer,__SetComServer,TComServer,false,0);
    AddConstant('smStandalone',smStandalone);
    AddConstant('smAutomation',smAutomation);
    AddConstant('smRegServer',smRegServer);
    AddConstant('smUnregServer',smUnregServer);
  end;
end;

class function TatComServLibrary.LibraryName: string;
begin
  result := 'ComServ';
end;

initialization
  RegisterScripterLibrary(TatComServLibrary, True);

{$WARNINGS ON}

end.

