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
unit ap_TConnect;

interface

uses
  Variants,
  SysUtils,
  Classes,
  Midas,
  DB,
  DBClient,
  Windows,
  ActiveX,
  ComObj,
  Provider,
  TConnect,
  atScript;

{$WARNINGS OFF}

type
  TatTConnectLibrary = class(TatScripterLibrary)
    procedure __TLocalConnectionCreate(AMachine: TatVirtualMachine);
    procedure __TLocalConnectionDestroy(AMachine: TatVirtualMachine);
    procedure __GetTLocalConnectionProviders(AMachine: TatVirtualMachine);
    procedure __GetTLocalConnectionProviderCount(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TLocalConnectionClass = class of TLocalConnection;



implementation



procedure TatTConnectLibrary.__TLocalConnectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TLocalConnectionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTConnectLibrary.__TLocalConnectionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TLocalConnection(CurrentObject).Destroy;
  end;
end;

procedure TatTConnectLibrary.__GetTLocalConnectionProviders(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TLocalConnection(CurrentObject).Providers[GetArrayIndex(0)]));
  end;
end;

procedure TatTConnectLibrary.__GetTLocalConnectionProviderCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TLocalConnection(CurrentObject).ProviderCount));
  end;
end;

procedure TatTConnectLibrary.Init;
begin
  With Scripter.DefineClass(TLocalConnection) do
  begin
    DefineMethod('Create',1,tkClass,TLocalConnection,__TLocalConnectionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TLocalConnectionDestroy,false,0);
    DefineProp('Providers',tkClass,__GetTLocalConnectionProviders,nil,TCustomProvider,false,1);
    DefineProp('ProviderCount',tkInteger,__GetTLocalConnectionProviderCount,nil,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatTConnectLibrary.LibraryName: string;
begin
  result := 'TConnect';
end;

initialization
  RegisterScripterLibrary(TatTConnectLibrary, True);

{$WARNINGS ON}

end.

