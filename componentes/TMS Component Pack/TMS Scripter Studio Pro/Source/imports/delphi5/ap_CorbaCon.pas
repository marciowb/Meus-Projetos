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
unit ap_CorbaCon;

interface

uses
  Messages,
  Windows,
  SysUtils,
  CorbaObj,
  CorbaStd,
  Classes,
  Midas,
  DBClient,
  CorbaCon,
  atScript;

{$WARNINGS OFF}

type
  TatCorbaConLibrary = class(TatScripterLibrary)
    procedure __TCorbaConnectionCreate(AMachine: TatVirtualMachine);
    procedure __GetTCorbaConnectionAppServer(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCorbaConnectionClass = class of TCorbaConnection;

  TatCorbaConDispatcher = class(TatEventDispatcher)
  private
    procedure __TCancelEvent( Sender: TObject; var Cancel: Boolean; var DialogMessage: string);
  end;


implementation



procedure TatCorbaConLibrary.__TCorbaConnectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCorbaConnectionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaConLibrary.__GetTCorbaConnectionAppServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCorbaConnection(CurrentObject).AppServer);
  end;
end;

procedure TatCorbaConDispatcher.__TCancelEvent( Sender: TObject; var Cancel: Boolean; var DialogMessage: string);
var
  CancelTemp: variant;
  DialogMessageTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TCancelEvent(BeforeCall)(Sender,Cancel,DialogMessage);
    CancelTemp := Cancel;
    DialogMessageTemp := DialogMessage;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,CancelTemp,DialogMessageTemp]);
    Cancel := CancelTemp;
    DialogMessage := DialogMessageTemp;
    if AssignedMethod(AfterCall) then
      TCancelEvent(AfterCall)(Sender,Cancel,DialogMessage);
  end;
end;

procedure TatCorbaConLibrary.Init;
begin
  With Scripter.DefineClass(TCorbaConnection) do
  begin
    DefineMethod('Create',1,tkClass,TCorbaConnection,__TCorbaConnectionCreate,true,0);
    DefineProp('AppServer',tkVariant,__GetTCorbaConnectionAppServer,nil,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TCancelEvent), TatCorbaConDispatcher, @TatCorbaConDispatcher.__TCancelEvent);
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatCorbaConLibrary.LibraryName: string;
begin
  result := 'CorbaCon';
end;

initialization
  RegisterScripterLibrary(TatCorbaConLibrary, True);

{$WARNINGS ON}

end.

