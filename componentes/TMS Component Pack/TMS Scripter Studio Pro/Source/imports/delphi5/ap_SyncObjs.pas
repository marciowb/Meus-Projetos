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
unit ap_SyncObjs;

interface

uses
  Sysutils,
  Windows,
  Messages,
  Classes,
  SyncObjs,
  atScript;

{$WARNINGS OFF}

type
  TatSyncObjsLibrary = class(TatScripterLibrary)
    procedure __TSynchroObjectAcquire(AMachine: TatVirtualMachine);
    procedure __TSynchroObjectRelease(AMachine: TatVirtualMachine);
    procedure __THandleObjectDestroy(AMachine: TatVirtualMachine);
    procedure __GetTHandleObjectLastError(AMachine: TatVirtualMachine);
    procedure __GetTHandleObjectHandle(AMachine: TatVirtualMachine);
    procedure __TEventWaitFor(AMachine: TatVirtualMachine);
    procedure __TEventSetEvent(AMachine: TatVirtualMachine);
    procedure __TEventResetEvent(AMachine: TatVirtualMachine);
    procedure __TSimpleEventCreate(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionCreate(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionDestroy(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionAcquire(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionRelease(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionEnter(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionLeave(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TSynchroObjectClass = class of TSynchroObject;
  THandleObjectClass = class of THandleObject;
  TEventClass = class of TEvent;
  TSimpleEventClass = class of TSimpleEvent;
  TCriticalSectionClass = class of TCriticalSection;



implementation



procedure TatSyncObjsLibrary.__TSynchroObjectAcquire(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSynchroObject(CurrentObject).Acquire;
  end;
end;

procedure TatSyncObjsLibrary.__TSynchroObjectRelease(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSynchroObject(CurrentObject).Release;
  end;
end;

procedure TatSyncObjsLibrary.__THandleObjectDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THandleObject(CurrentObject).Destroy;
  end;
end;

procedure TatSyncObjsLibrary.__GetTHandleObjectLastError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(THandleObject(CurrentObject).LastError));
  end;
end;

procedure TatSyncObjsLibrary.__GetTHandleObjectHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(THandleObject(CurrentObject).Handle));
  end;
end;

procedure TatSyncObjsLibrary.__TEventWaitFor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TEvent(CurrentObject).WaitFor(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSyncObjsLibrary.__TEventSetEvent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TEvent(CurrentObject).SetEvent;
  end;
end;

procedure TatSyncObjsLibrary.__TEventResetEvent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TEvent(CurrentObject).ResetEvent;
  end;
end;

procedure TatSyncObjsLibrary.__TSimpleEventCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSimpleEventClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSyncObjsLibrary.__TCriticalSectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCriticalSectionClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSyncObjsLibrary.__TCriticalSectionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCriticalSection(CurrentObject).Destroy;
  end;
end;

procedure TatSyncObjsLibrary.__TCriticalSectionAcquire(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCriticalSection(CurrentObject).Acquire;
  end;
end;

procedure TatSyncObjsLibrary.__TCriticalSectionRelease(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCriticalSection(CurrentObject).Release;
  end;
end;

procedure TatSyncObjsLibrary.__TCriticalSectionEnter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCriticalSection(CurrentObject).Enter;
  end;
end;

procedure TatSyncObjsLibrary.__TCriticalSectionLeave(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCriticalSection(CurrentObject).Leave;
  end;
end;

procedure TatSyncObjsLibrary.Init;
begin
  With Scripter.DefineClass(TSynchroObject) do
  begin
    DefineMethod('Acquire',0,tkNone,nil,__TSynchroObjectAcquire,false,0);
    DefineMethod('Release',0,tkNone,nil,__TSynchroObjectRelease,false,0);
  end;
  With Scripter.DefineClass(THandleObject) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__THandleObjectDestroy,false,0);
    DefineProp('LastError',tkInteger,__GetTHandleObjectLastError,nil,nil,false,0);
    DefineProp('Handle',tkInteger,__GetTHandleObjectHandle,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TEvent) do
  begin
    DefineMethod('WaitFor',1,tkEnumeration,nil,__TEventWaitFor,false,0);
    DefineMethod('SetEvent',0,tkNone,nil,__TEventSetEvent,false,0);
    DefineMethod('ResetEvent',0,tkNone,nil,__TEventResetEvent,false,0);
  end;
  With Scripter.DefineClass(TSimpleEvent) do
  begin
    DefineMethod('Create',0,tkClass,TSimpleEvent,__TSimpleEventCreate,true,0);
  end;
  With Scripter.DefineClass(TCriticalSection) do
  begin
    DefineMethod('Create',0,tkClass,TCriticalSection,__TCriticalSectionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCriticalSectionDestroy,false,0);
    DefineMethod('Acquire',0,tkNone,nil,__TCriticalSectionAcquire,false,0);
    DefineMethod('Release',0,tkNone,nil,__TCriticalSectionRelease,false,0);
    DefineMethod('Enter',0,tkNone,nil,__TCriticalSectionEnter,false,0);
    DefineMethod('Leave',0,tkNone,nil,__TCriticalSectionLeave,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('wrSignaled',wrSignaled);
    AddConstant('wrTimeout',wrTimeout);
    AddConstant('wrAbandoned',wrAbandoned);
    AddConstant('wrError',wrError);
  end;
end;

class function TatSyncObjsLibrary.LibraryName: string;
begin
  result := 'SyncObjs';
end;

initialization
  RegisterScripterLibrary(TatSyncObjsLibrary, True);

{$WARNINGS ON}

end.

