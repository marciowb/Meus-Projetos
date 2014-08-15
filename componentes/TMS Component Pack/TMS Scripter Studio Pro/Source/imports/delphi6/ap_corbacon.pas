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
unit ap_corbacon;

interface

uses
  Messages,
  Variants,
  Windows,
  SysUtils,
  CorbaObj,
  CorbaStd,
  Classes,
  Midas,
  DBClient,
  corbacon,
  atScript;

type
  TatcorbaconLibrary = class(TatScripterLibrary)
    procedure __TCorbaConnectionCreate(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCorbaConnectionClass = class of TCorbaConnection;

  TatcorbaconDispatcher = class(TatEventDispatcher)
  private
    procedure __TCancelEvent( Sender: TObject; var Cancel: Boolean; var DialogMessage: string);
  end;


implementation

{$WARNINGS OFF}



procedure TatcorbaconLibrary.__TCorbaConnectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCorbaConnectionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatcorbaconDispatcher.__TCancelEvent( Sender: TObject; var Cancel: Boolean; var DialogMessage: string);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TCancelEvent(BeforeCall)(Sender,Cancel,DialogMessage);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Cancel,DialogMessage]);
    if AssignedMethod(AfterCall) then
      TCancelEvent(AfterCall)(Sender,Cancel,DialogMessage);
  end;
end;

procedure TatcorbaconLibrary.Init;
begin
  With Scripter.DefineClass(TCorbaConnection) do
  begin
    DefineMethod('Create',1,tkClass,TCorbaConnection,__TCorbaConnectionCreate,true);
  end;
  DefineEventAdapter(TypeInfo(TCancelEvent), TatcorbaconDispatcher, @TatcorbaconDispatcher.__TCancelEvent);
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatcorbaconLibrary.LibraryName: string;
begin
  result := 'corbacon';
end;

initialization
  RegisterScripterLibrary(TatcorbaconLibrary, True);

{$WARNINGS ON}

end.
