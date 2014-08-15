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
unit ap_AppEvnts;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Forms,
  ActnList,
  AppEvnts,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatAppEvntsLibrary = class(TatScripterLibrary)
    procedure __TCustomApplicationEventsCreate(AMachine: TatVirtualMachine);
    procedure __TCustomApplicationEventsActivate(AMachine: TatVirtualMachine);
    procedure __TCustomApplicationEventsCancelDispatch(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCustomApplicationEventsClass = class of TCustomApplicationEvents;
  TApplicationEventsClass = class of TApplicationEvents;



implementation



procedure TatAppEvntsLibrary.__TCustomApplicationEventsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomApplicationEventsClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAppEvntsLibrary.__TCustomApplicationEventsActivate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomApplicationEvents(CurrentObject).Activate;
  end;
end;

procedure TatAppEvntsLibrary.__TCustomApplicationEventsCancelDispatch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomApplicationEvents(CurrentObject).CancelDispatch;
  end;
end;

procedure TatAppEvntsLibrary.Init;
begin
  With Scripter.DefineClass(TCustomApplicationEvents) do
  begin
    DefineMethod('Create',1,tkClass,TCustomApplicationEvents,__TCustomApplicationEventsCreate,true,0);
    DefineMethod('Activate',0,tkNone,nil,__TCustomApplicationEventsActivate,false,0);
    DefineMethod('CancelDispatch',0,tkNone,nil,__TCustomApplicationEventsCancelDispatch,false,0);
  end;
  With Scripter.DefineClass(TApplicationEvents) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatAppEvntsLibrary.LibraryName: string;
begin
  result := 'AppEvnts';
end;

initialization
  RegisterScripterLibrary(TatAppEvntsLibrary, True);

{$WARNINGS ON}

end.

