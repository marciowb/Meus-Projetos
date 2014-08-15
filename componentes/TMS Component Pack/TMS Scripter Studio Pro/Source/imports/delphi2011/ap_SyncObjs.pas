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
  TimeSpan,
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
    procedure __TSynchroObjectWaitFor(AMachine: TatVirtualMachine);
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
    procedure __TSemaphoreCreate(AMachine: TatVirtualMachine);
    procedure __TSemaphoreAcquire(AMachine: TatVirtualMachine);
    procedure __TSemaphoreRelease(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionCreate(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionDestroy(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionAcquire(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionRelease(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionTryEnter(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionEnter(AMachine: TatVirtualMachine);
    procedure __TCriticalSectionLeave(AMachine: TatVirtualMachine);
    procedure __TConditionVariableMutexCreate(AMachine: TatVirtualMachine);
    procedure __TConditionVariableMutexDestroy(AMachine: TatVirtualMachine);
    procedure __TConditionVariableMutexAcquire(AMachine: TatVirtualMachine);
    procedure __TConditionVariableMutexRelease(AMachine: TatVirtualMachine);
    procedure __TConditionVariableMutexReleaseAll(AMachine: TatVirtualMachine);
    procedure __TConditionVariableMutexWaitFor(AMachine: TatVirtualMachine);
    procedure __TConditionVariableCSAcquire(AMachine: TatVirtualMachine);
    procedure __TConditionVariableCSRelease(AMachine: TatVirtualMachine);
    procedure __TConditionVariableCSReleaseAll(AMachine: TatVirtualMachine);
    procedure __TConditionVariableCSWaitFor(AMachine: TatVirtualMachine);
    procedure __TLightweightEventCreate(AMachine: TatVirtualMachine);
    procedure __TLightweightEventDestroy(AMachine: TatVirtualMachine);
    procedure __TLightweightEventResetEvent(AMachine: TatVirtualMachine);
    procedure __TLightweightEventSetEvent(AMachine: TatVirtualMachine);
    procedure __TLightweightEventWaitFor(AMachine: TatVirtualMachine);
    procedure __GetTLightweightEventBlockedCount(AMachine: TatVirtualMachine);
    procedure __GetTLightweightEventIsSet(AMachine: TatVirtualMachine);
    procedure __GetTLightweightEventSpinCount(AMachine: TatVirtualMachine);
    procedure __TLightweightSemaphoreCreate(AMachine: TatVirtualMachine);
    procedure __TLightweightSemaphoreDestroy(AMachine: TatVirtualMachine);
    procedure __TLightweightSemaphoreRelease(AMachine: TatVirtualMachine);
    procedure __TLightweightSemaphoreWaitFor(AMachine: TatVirtualMachine);
    procedure __GetTLightweightSemaphoreBlockedCount(AMachine: TatVirtualMachine);
    procedure __GetTLightweightSemaphoreCurrentCount(AMachine: TatVirtualMachine);
    procedure __TCountdownEventCreate(AMachine: TatVirtualMachine);
    procedure __TCountdownEventDestroy(AMachine: TatVirtualMachine);
    procedure __TCountdownEventSignal(AMachine: TatVirtualMachine);
    procedure __TCountdownEventAddCount(AMachine: TatVirtualMachine);
    procedure __TCountdownEventReset(AMachine: TatVirtualMachine);
    procedure __TCountdownEventTryAddCount(AMachine: TatVirtualMachine);
    procedure __TCountdownEventWaitFor(AMachine: TatVirtualMachine);
    procedure __GetTCountdownEventCurrentCount(AMachine: TatVirtualMachine);
    procedure __GetTCountdownEventInitialCount(AMachine: TatVirtualMachine);
    procedure __GetTCountdownEventIsSet(AMachine: TatVirtualMachine);
    procedure __TInterlockedIncrement(AMachine: TatVirtualMachine);
    procedure __TInterlockedDecrement(AMachine: TatVirtualMachine);
    procedure __TInterlockedAdd(AMachine: TatVirtualMachine);
    procedure __TInterlockedBitTestAndSet(AMachine: TatVirtualMachine);
    procedure __TInterlockedBitTestAndClear(AMachine: TatVirtualMachine);
    procedure __TInterlockedExchange(AMachine: TatVirtualMachine);
    procedure __TInterlockedCompareExchange(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  ESyncObjectExceptionClass = class of ESyncObjectException;
  TSynchroObjectClass = class of TSynchroObject;
  THandleObjectClass = class of THandleObject;
  TEventClass = class of TEvent;
  TSimpleEventClass = class of TSimpleEvent;
  TMutexClass = class of TMutex;
  TSemaphoreClass = class of TSemaphore;
  TCriticalSectionClass = class of TCriticalSection;
  TConditionVariableMutexClass = class of TConditionVariableMutex;
  TConditionVariableCSClass = class of TConditionVariableCS;
  ELockRecursionExceptionClass = class of ELockRecursionException;
  ELockExceptionClass = class of ELockException;
  TLightweightEventClass = class of TLightweightEvent;
  TLightweightSemaphoreClass = class of TLightweightSemaphore;
  TCountdownEventClass = class of TCountdownEvent;
  TInterlockedClass = class of TInterlocked;



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

procedure TatSyncObjsLibrary.__TSynchroObjectWaitFor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := TSynchroObject(CurrentObject).WaitFor;
1: AResult := TSynchroObject(CurrentObject).WaitFor(VarToInteger(GetInputArg(0)));
end;
    ReturnOutputArg(AResult);
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
    ReturnOutputArg(THandleObject(CurrentObject).Handle);
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

procedure TatSyncObjsLibrary.__TSemaphoreCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := Integer(TSemaphoreClass(CurrentClass.ClassRef).Create);
1: AResult := Integer(TSemaphoreClass(CurrentClass.ClassRef).Create(GetInputArg(0)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSyncObjsLibrary.__TSemaphoreAcquire(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSemaphore(CurrentObject).Acquire;
  end;
end;

procedure TatSyncObjsLibrary.__TSemaphoreRelease(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSemaphore(CurrentObject).Release;
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

procedure TatSyncObjsLibrary.__TConditionVariableMutexCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TConditionVariableMutexClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSyncObjsLibrary.__TConditionVariableMutexDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TConditionVariableMutex(CurrentObject).Destroy;
  end;
end;

procedure TatSyncObjsLibrary.__TConditionVariableMutexAcquire(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TConditionVariableMutex(CurrentObject).Acquire;
  end;
end;

procedure TatSyncObjsLibrary.__TConditionVariableMutexRelease(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TConditionVariableMutex(CurrentObject).Release;
  end;
end;

procedure TatSyncObjsLibrary.__TConditionVariableMutexReleaseAll(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TConditionVariableMutex(CurrentObject).ReleaseAll;
  end;
end;

procedure TatSyncObjsLibrary.__TConditionVariableMutexWaitFor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := TConditionVariableMutex(CurrentObject).WaitFor(TMutex(Integer(GetInputArg(0))));
2: AResult := TConditionVariableMutex(CurrentObject).WaitFor(TMutex(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSyncObjsLibrary.__TConditionVariableCSAcquire(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TConditionVariableCS(CurrentObject).Acquire;
  end;
end;

procedure TatSyncObjsLibrary.__TConditionVariableCSRelease(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TConditionVariableCS(CurrentObject).Release;
  end;
end;

procedure TatSyncObjsLibrary.__TConditionVariableCSReleaseAll(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TConditionVariableCS(CurrentObject).ReleaseAll;
  end;
end;

procedure TatSyncObjsLibrary.__TConditionVariableCSWaitFor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := TConditionVariableCS(CurrentObject).WaitFor(TCriticalSection(Integer(GetInputArg(0))));
2: AResult := TConditionVariableCS(CurrentObject).WaitFor(TCriticalSection(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSyncObjsLibrary.__TLightweightEventCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TLightweightEventClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSyncObjsLibrary.__TLightweightEventDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TLightweightEvent(CurrentObject).Destroy;
  end;
end;

procedure TatSyncObjsLibrary.__TLightweightEventResetEvent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TLightweightEvent(CurrentObject).ResetEvent;
  end;
end;

procedure TatSyncObjsLibrary.__TLightweightEventSetEvent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TLightweightEvent(CurrentObject).SetEvent;
  end;
end;

procedure TatSyncObjsLibrary.__TLightweightEventWaitFor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := TLightweightEvent(CurrentObject).WaitFor;
1: AResult := TLightweightEvent(CurrentObject).WaitFor(VarToInteger(GetInputArg(0)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSyncObjsLibrary.__GetTLightweightEventBlockedCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TLightweightEvent(CurrentObject).BlockedCount));
  end;
end;

procedure TatSyncObjsLibrary.__GetTLightweightEventIsSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TLightweightEvent(CurrentObject).IsSet);
  end;
end;

procedure TatSyncObjsLibrary.__GetTLightweightEventSpinCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TLightweightEvent(CurrentObject).SpinCount));
  end;
end;

procedure TatSyncObjsLibrary.__TLightweightSemaphoreCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(TLightweightSemaphoreClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0))));
2: AResult := Integer(TLightweightSemaphoreClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSyncObjsLibrary.__TLightweightSemaphoreDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TLightweightSemaphore(CurrentObject).Destroy;
  end;
end;

procedure TatSyncObjsLibrary.__TLightweightSemaphoreRelease(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := Integer(TLightweightSemaphore(CurrentObject).Release);
1: AResult := Integer(TLightweightSemaphore(CurrentObject).Release(VarToInteger(GetInputArg(0))));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSyncObjsLibrary.__TLightweightSemaphoreWaitFor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := TLightweightSemaphore(CurrentObject).WaitFor;
1: AResult := TLightweightSemaphore(CurrentObject).WaitFor(VarToInteger(GetInputArg(0)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSyncObjsLibrary.__GetTLightweightSemaphoreBlockedCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TLightweightSemaphore(CurrentObject).BlockedCount));
  end;
end;

procedure TatSyncObjsLibrary.__GetTLightweightSemaphoreCurrentCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TLightweightSemaphore(CurrentObject).CurrentCount));
  end;
end;

procedure TatSyncObjsLibrary.__TCountdownEventCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCountdownEventClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSyncObjsLibrary.__TCountdownEventDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCountdownEvent(CurrentObject).Destroy;
  end;
end;

procedure TatSyncObjsLibrary.__TCountdownEventSignal(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := TCountdownEvent(CurrentObject).Signal;
1: AResult := TCountdownEvent(CurrentObject).Signal(VarToInteger(GetInputArg(0)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSyncObjsLibrary.__TCountdownEventAddCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      0: TCountdownEvent(CurrentObject).AddCount;
      1: TCountdownEvent(CurrentObject).AddCount(VarToInteger(GetInputArg(0)));
    end;
  end;
end;

procedure TatSyncObjsLibrary.__TCountdownEventReset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCountdownEvent(CurrentObject).Reset;
  end;
end;

procedure TatSyncObjsLibrary.__TCountdownEventTryAddCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := TCountdownEvent(CurrentObject).TryAddCount;
1: AResult := TCountdownEvent(CurrentObject).TryAddCount(VarToInteger(GetInputArg(0)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSyncObjsLibrary.__TCountdownEventWaitFor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := TCountdownEvent(CurrentObject).WaitFor;
1: AResult := TCountdownEvent(CurrentObject).WaitFor(VarToInteger(GetInputArg(0)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSyncObjsLibrary.__GetTCountdownEventCurrentCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCountdownEvent(CurrentObject).CurrentCount));
  end;
end;

procedure TatSyncObjsLibrary.__GetTCountdownEventInitialCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCountdownEvent(CurrentObject).InitialCount));
  end;
end;

procedure TatSyncObjsLibrary.__GetTCountdownEventIsSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCountdownEvent(CurrentObject).IsSet);
  end;
end;

procedure TatSyncObjsLibrary.__TInterlockedIncrement(AMachine: TatVirtualMachine);
  var
  Param0: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(TInterlockedClass(CurrentClass.ClassRef).Increment(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatSyncObjsLibrary.__TInterlockedDecrement(AMachine: TatVirtualMachine);
  var
  Param0: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(TInterlockedClass(CurrentClass.ClassRef).Decrement(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatSyncObjsLibrary.__TInterlockedAdd(AMachine: TatVirtualMachine);
  var
  Param0: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(TInterlockedClass(CurrentClass.ClassRef).Add(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatSyncObjsLibrary.__TInterlockedBitTestAndSet(AMachine: TatVirtualMachine);
  var
  Param0: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := TInterlockedClass(CurrentClass.ClassRef).BitTestAndSet(Param0,GetInputArg(1));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatSyncObjsLibrary.__TInterlockedBitTestAndClear(AMachine: TatVirtualMachine);
  var
  Param0: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := TInterlockedClass(CurrentClass.ClassRef).BitTestAndClear(Param0,GetInputArg(1));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatSyncObjsLibrary.__TInterlockedExchange(AMachine: TatVirtualMachine);
  var
  Param0: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(TInterlockedClass(CurrentClass.ClassRef).Exchange(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatSyncObjsLibrary.__TInterlockedCompareExchange(AMachine: TatVirtualMachine);
  var
  Param0: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(TInterlockedClass(CurrentClass.ClassRef).CompareExchange(Param0,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatSyncObjsLibrary.Init;
begin
  With Scripter.DefineClass(ESyncObjectException) do
  begin
  end;
  With Scripter.DefineClass(TSynchroObject) do
  begin
    DefineMethod('Acquire',0,tkNone,nil,__TSynchroObjectAcquire,false,0);
    DefineMethod('Release',0,tkNone,nil,__TSynchroObjectRelease,false,0);
    DefineMethod('WaitFor',1,tkEnumeration,nil,__TSynchroObjectWaitFor,false,1);
  end;
  With Scripter.DefineClass(THandleObject) do
  begin
    DefineMethod('Create',1,tkClass,THandleObject,__THandleObjectCreate,true,1);
    DefineMethod('Destroy',0,tkNone,nil,__THandleObjectDestroy,false,0);
    DefineMethod('WaitFor',1,tkEnumeration,nil,__THandleObjectWaitFor,false,0);
    DefineProp('LastError',tkInteger,__GetTHandleObjectLastError,nil,nil,false,0);
    DefineProp('Handle',tkVariant,__GetTHandleObjectHandle,nil,nil,false,0);
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
  With Scripter.DefineClass(TSemaphore) do
  begin
    DefineMethod('Create',1,tkClass,TSemaphore,__TSemaphoreCreate,true,1);
    DefineMethod('Acquire',0,tkNone,nil,__TSemaphoreAcquire,false,0);
    DefineMethod('Release',0,tkNone,nil,__TSemaphoreRelease,false,0);
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
  With Scripter.DefineClass(TConditionVariableMutex) do
  begin
    DefineMethod('Create',0,tkClass,TConditionVariableMutex,__TConditionVariableMutexCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TConditionVariableMutexDestroy,false,0);
    DefineMethod('Acquire',0,tkNone,nil,__TConditionVariableMutexAcquire,false,0);
    DefineMethod('Release',0,tkNone,nil,__TConditionVariableMutexRelease,false,0);
    DefineMethod('ReleaseAll',0,tkNone,nil,__TConditionVariableMutexReleaseAll,false,0);
    DefineMethod('WaitFor',2,tkEnumeration,nil,__TConditionVariableMutexWaitFor,false,1);
  end;
  With Scripter.DefineClass(TConditionVariableCS) do
  begin
    DefineMethod('Acquire',0,tkNone,nil,__TConditionVariableCSAcquire,false,0);
    DefineMethod('Release',0,tkNone,nil,__TConditionVariableCSRelease,false,0);
    DefineMethod('ReleaseAll',0,tkNone,nil,__TConditionVariableCSReleaseAll,false,0);
    DefineMethod('WaitFor',2,tkEnumeration,nil,__TConditionVariableCSWaitFor,false,1);
  end;
  With Scripter.DefineClass(ELockRecursionException) do
  begin
  end;
  With Scripter.DefineClass(ELockException) do
  begin
  end;
  With Scripter.DefineClass(TLightweightEvent) do
  begin
    DefineMethod('Create',0,tkClass,TLightweightEvent,__TLightweightEventCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TLightweightEventDestroy,false,0);
    DefineMethod('ResetEvent',0,tkNone,nil,__TLightweightEventResetEvent,false,0);
    DefineMethod('SetEvent',0,tkNone,nil,__TLightweightEventSetEvent,false,0);
    DefineMethod('WaitFor',1,tkEnumeration,nil,__TLightweightEventWaitFor,false,1);
    DefineProp('BlockedCount',tkInteger,__GetTLightweightEventBlockedCount,nil,nil,false,0);
    DefineProp('IsSet',tkVariant,__GetTLightweightEventIsSet,nil,nil,false,0);
    DefineProp('SpinCount',tkInteger,__GetTLightweightEventSpinCount,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TLightweightSemaphore) do
  begin
    DefineMethod('Create',2,tkClass,TLightweightSemaphore,__TLightweightSemaphoreCreate,true,1);
    DefineMethod('Destroy',0,tkNone,nil,__TLightweightSemaphoreDestroy,false,0);
    DefineMethod('Release',1,tkInteger,nil,__TLightweightSemaphoreRelease,false,1);
    DefineMethod('WaitFor',1,tkEnumeration,nil,__TLightweightSemaphoreWaitFor,false,1);
    DefineProp('BlockedCount',tkInteger,__GetTLightweightSemaphoreBlockedCount,nil,nil,false,0);
    DefineProp('CurrentCount',tkInteger,__GetTLightweightSemaphoreCurrentCount,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TCountdownEvent) do
  begin
    DefineMethod('Create',1,tkClass,TCountdownEvent,__TCountdownEventCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCountdownEventDestroy,false,0);
    DefineMethod('Signal',1,tkVariant,nil,__TCountdownEventSignal,false,1);
    DefineMethod('AddCount',1,tkNone,nil,__TCountdownEventAddCount,false,1);
    DefineMethod('Reset',0,tkNone,nil,__TCountdownEventReset,false,0);
    DefineMethod('TryAddCount',1,tkVariant,nil,__TCountdownEventTryAddCount,false,1);
    DefineMethod('WaitFor',1,tkEnumeration,nil,__TCountdownEventWaitFor,false,1);
    DefineProp('CurrentCount',tkInteger,__GetTCountdownEventCurrentCount,nil,nil,false,0);
    DefineProp('InitialCount',tkInteger,__GetTCountdownEventInitialCount,nil,nil,false,0);
    DefineProp('IsSet',tkVariant,__GetTCountdownEventIsSet,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TInterlocked) do
  begin
    DefineMethod('Increment',1,tkInteger,nil,__TInterlockedIncrement,true,0).SetVarArgs([0]);
    DefineMethod('Decrement',1,tkInteger,nil,__TInterlockedDecrement,true,0).SetVarArgs([0]);
    DefineMethod('Add',2,tkInteger,nil,__TInterlockedAdd,true,0).SetVarArgs([0]);
    DefineMethod('BitTestAndSet',2,tkVariant,nil,__TInterlockedBitTestAndSet,true,0).SetVarArgs([0]);
    DefineMethod('BitTestAndClear',2,tkVariant,nil,__TInterlockedBitTestAndClear,true,0).SetVarArgs([0]);
    DefineMethod('Exchange',2,tkInteger,nil,__TInterlockedExchange,true,0).SetVarArgs([0]);
    DefineMethod('CompareExchange',3,tkInteger,nil,__TInterlockedCompareExchange,true,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('wrSignaled',wrSignaled);
    AddConstant('wrTimeout',wrTimeout);
    AddConstant('wrAbandoned',wrAbandoned);
    AddConstant('wrError',wrError);
    AddConstant('wrIOCompletion',wrIOCompletion);
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

