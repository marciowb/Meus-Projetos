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
  Windows,
  Messages,
  SysUtils,
  Classes,
  SyncObjs,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatSyncObjsLibrary = class(TatScripterLibrary)
    procedure __TSynchroObjectAcquire(AMachine: TatVirtualMachine);
    procedure __TSynchroObjectRelease(AMachine: TatVirtualMachine);
    procedure __THandleObjectCreate(AMachine: TatVirtualMachine);
    procedure __THandleObjectDestroy(AMachine: TatVirtualMachine);
    procedure __THandleObjectWaitFor(AMachine: TatVirtualMachine);
    procedure __GetTHandleObjectLastError(AMachine: TatVirtualMachine);
    procedure __GetTHandleObjectHandle(AMachine: TatVirtualMachine);
    procedure __TEventCreate(AMachine: TatVirtualMachine);
    procedure __TEventSetEvent(AMachine: TatVirtualMachine);
    procedure __TEventResetEvent(AMachine: TatVirtualMachine);
    procedure __TMutexCreate(AMachine: TatVirtualMachine);
    procedure __TMutexAcquire(AMachine: TatVirtualMachine);
    procedure __TMutexRelease(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionCreate(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionDestroy(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionAcquire(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionRelease(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionTryEnter(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionEnter(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionLeave(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TSynchroObjectClass = class of TSynchroObject;
  THandleObjectClass = class of THandleObject;
  TEventClass = class of TEvent;
  TSimpleEventClass = class of TSimpleEvent;
  TMutexClass = class of TMutex;
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

procedure TatSyncObjsLibrary.__THandleObjectCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := Integer(THandleObjectClass(CurrentClass.ClassRef).Create);
1: AResult := Integer(THandleObjectClass(CurrentClass.ClassRef).Create(GetInputArg(0)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSyncObjsLibrary.__THandleObjectDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THandleObject(CurrentObject).Destroy;
  end;
end;

procedure TatSyncObjsLibrary.__THandleObjectWaitFor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := THandleObject(CurrentObject).WaitFor(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
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

procedure TatSyncObjsLibrary.__TEventCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := Integer(TEventClass(CurrentClass.ClassRef).Create);
1: AResult := Integer(TEventClass(CurrentClass.ClassRef).Create(GetInputArg(0)));
end;
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

procedure TatSyncObjsLibrary.__TMutexCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := Integer(TMutexClass(CurrentClass.ClassRef).Create);
1: AResult := Integer(TMutexClass(CurrentClass.ClassRef).Create(GetInputArg(0)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSyncObjsLibrary.__TMutexAcquire(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMutex(CurrentObject).Acquire;
  end;
end;

procedure TatSyncObjsLibrary.__TMutexRelease(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMutex(CurrentObject).Release;
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

procedure TatSyncObjsLibrary.__TCriticalSectionTryEnter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCriticalSection(CurrentObject).TryEnter;
    ReturnOutputArg(AResult);
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
    DefineMethod('Create',1,tkClass,THandleObject,__THandleObjectCreate,true,1);
    DefineMethod('Destroy',0,tkNone,nil,__THandleObjectDestroy,false,0);
    DefineMethod('WaitFor',1,tkEnumeration,nil,__THandleObjectWaitFor,false,0);
    DefineProp('LastError',tkInteger,__GetTHandleObjectLastError,nil,nil,false,0);
    DefineProp('Handle',tkInteger,__GetTHandleObjectHandle,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TEvent) do
  begin
    DefineMethod('Create',1,tkClass,TEvent,__TEventCreate,true,1);
    DefineMethod('SetEvent',0,tkNone,nil,__TEventSetEvent,false,0);
    DefineMethod('ResetEvent',0,tkNone,nil,__TEventResetEvent,false,0);
  end;
  With Scripter.DefineClass(TSimpleEvent) do
  begin
  end;
  With Scripter.DefineClass(TMutex) do
  begin
    DefineMethod('Create',1,tkClass,TMutex,__TMutexCreate,true,1);
    DefineMethod('Acquire',0,tkNone,nil,__TMutexAcquire,false,0);
    DefineMethod('Release',0,tkNone,nil,__TMutexRelease,false,0);
  end;
  With Scripter.DefineClass(TCriticalSection) do
  begin
    DefineMethod('Create',0,tkClass,TCriticalSection,__TCriticalSectionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCriticalSectionDestroy,false,0);
    DefineMethod('Acquire',0,tkNone,nil,__TCriticalSectionAcquire,false,0);
    DefineMethod('Release',0,tkNone,nil,__TCriticalSectionRelease,false,0);
    DefineMethod('TryEnter',0,tkVariant,nil,__TCriticalSectionTryEnter,false,0);
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

