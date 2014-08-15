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
unit ap_IBEvents;

interface

uses
  SysUtils,
  Windows,
  Messages,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  DB,
  IBHeader,
  IBExternals,
  IB,
  IBDatabase,
  IBEvents,
  atScript;

{$WARNINGS OFF}

type
  TatIBEventsLibrary = class(TatScripterLibrary)
    procedure __TIBEventsCreate(AMachine: TatVirtualMachine);
    procedure __TIBEventsDestroy(AMachine: TatVirtualMachine);
    procedure __TIBEventsRegisterEvents(AMachine: TatVirtualMachine);
    procedure __TIBEventsUnRegisterEvents(AMachine: TatVirtualMachine);
    procedure __TIBEventsSetAutoRegister(AMachine: TatVirtualMachine);
    procedure __TIBEventsGetAutoRegister(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBEventsClass = class of TIBEvents;

  TatIBEventsDispatcher = class(TatEventDispatcher)
  private
    procedure __TEventAlert( Sender: TObject;  EventName: string;  EventCount: longint; var CancelAlerts: Boolean);
    procedure __TErrorEvent( Sender: TObject;  ErrorCode: integer);
  end;


implementation



procedure TatIBEventsLibrary.__TIBEventsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBEventsClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBEventsLibrary.__TIBEventsDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBEvents(CurrentObject).Destroy;
  end;
end;

procedure TatIBEventsLibrary.__TIBEventsRegisterEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBEvents(CurrentObject).RegisterEvents;
  end;
end;

procedure TatIBEventsLibrary.__TIBEventsUnRegisterEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBEvents(CurrentObject).UnRegisterEvents;
  end;
end;

procedure TatIBEventsLibrary.__TIBEventsSetAutoRegister(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBEvents(CurrentObject).SetAutoRegister(GetInputArg(0));
  end;
end;

procedure TatIBEventsLibrary.__TIBEventsGetAutoRegister(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBEvents(CurrentObject).GetAutoRegister;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBEventsDispatcher.__TEventAlert( Sender: TObject;  EventName: string;  EventCount: longint; var CancelAlerts: Boolean);
var
  CancelAlertsTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TEventAlert(BeforeCall)(Sender,EventName,EventCount,CancelAlerts);
    CancelAlertsTemp := CancelAlerts;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,EventName,EventCount,CancelAlertsTemp]);
    CancelAlerts := CancelAlertsTemp;
    if AssignedMethod(AfterCall) then
      TEventAlert(AfterCall)(Sender,EventName,EventCount,CancelAlerts);
  end;
end;

procedure TatIBEventsDispatcher.__TErrorEvent( Sender: TObject;  ErrorCode: integer);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TErrorEvent(BeforeCall)(Sender,ErrorCode);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ErrorCode]);
    if AssignedMethod(AfterCall) then
      TErrorEvent(AfterCall)(Sender,ErrorCode);
  end;
end;

procedure TatIBEventsLibrary.Init;
begin
  With Scripter.DefineClass(TIBEvents) do
  begin
    DefineMethod('Create',1,tkClass,TIBEvents,__TIBEventsCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBEventsDestroy,false,0);
    DefineMethod('RegisterEvents',0,tkNone,nil,__TIBEventsRegisterEvents,false,0);
    DefineMethod('UnRegisterEvents',0,tkNone,nil,__TIBEventsUnRegisterEvents,false,0);
    DefineMethod('SetAutoRegister',1,tkNone,nil,__TIBEventsSetAutoRegister,false,0);
    DefineMethod('GetAutoRegister',0,tkVariant,nil,__TIBEventsGetAutoRegister,false,0);
  end;
  DefineEventAdapter(TypeInfo(TEventAlert), TatIBEventsDispatcher, @TatIBEventsDispatcher.__TEventAlert);
  DefineEventAdapter(TypeInfo(TErrorEvent), TatIBEventsDispatcher, @TatIBEventsDispatcher.__TErrorEvent);
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatIBEventsLibrary.LibraryName: string;
begin
  result := 'IBEvents';
end;

initialization
  RegisterScripterLibrary(TatIBEventsLibrary, True);

{$WARNINGS ON}

end.

