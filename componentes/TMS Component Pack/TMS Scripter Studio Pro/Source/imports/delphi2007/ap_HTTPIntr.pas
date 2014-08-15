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
unit ap_HTTPIntr;

interface

uses
  Windows,
  Messages,
  Variants,
  SysUtils,
  Classes,
  HTTPApp,
  SConnect,
  HTTPIntr,
  atScript;

{$WARNINGS OFF}

type
  TatHTTPIntrLibrary = class(TatScripterLibrary)
    procedure __THTTPServerWebModuleCreate(AMachine: TatVirtualMachine);
    procedure __THTTPServerWebModuleDestroy(AMachine: TatVirtualMachine);
    procedure __TerminateExtension(AMachine: TatVirtualMachine);
    procedure __GetHTTPServer(AMachine: TatVirtualMachine);
    procedure __SetHTTPServer(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  THTTPServerClass = class of THTTPServer;



implementation



procedure TatHTTPIntrLibrary.__THTTPServerWebModuleCreate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THTTPServer(CurrentObject).WebModuleCreate(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatHTTPIntrLibrary.__THTTPServerWebModuleDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THTTPServer(CurrentObject).WebModuleDestroy(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatHTTPIntrLibrary.__TerminateExtension(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := HTTPIntr.TerminateExtension(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatHTTPIntrLibrary.__GetHTTPServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(HTTPIntr.HTTPServer));
  end;
end;

procedure TatHTTPIntrLibrary.__SetHTTPServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    HTTPIntr.HTTPServer:=THTTPServer(Integer(GetInputArg(0)));
  end;
end;

procedure TatHTTPIntrLibrary.Init;
begin
  With Scripter.DefineClass(THTTPServer) do
  begin
    DefineMethod('WebModuleCreate',1,tkNone,nil,__THTTPServerWebModuleCreate,false,0);
    DefineMethod('WebModuleDestroy',1,tkNone,nil,__THTTPServerWebModuleDestroy,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('TerminateExtension',1,tkVariant,nil,__TerminateExtension,false,0);
    DefineProp('HTTPServer',tkClass,__GetHTTPServer,__SetHTTPServer,THTTPServer,false,0);
    AddConstant('SNotFound',SNotFound);
  end;
end;

class function TatHTTPIntrLibrary.LibraryName: string;
begin
  result := 'HTTPIntr';
end;

initialization
  RegisterScripterLibrary(TatHTTPIntrLibrary, True);

{$WARNINGS ON}

end.

