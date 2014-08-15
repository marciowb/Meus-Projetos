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
unit ap_IBIntf;

interface

uses
  Windows,
  IBHeader,
  IBInstallHeader,
  IBExternals,
  IBIntf,
  atScript;

{$WARNINGS OFF}

type
  TatIBIntfLibrary = class(TatScripterLibrary)
    procedure __LoadIBLibrary(AMachine: TatVirtualMachine);
    procedure __FreeIBLibrary(AMachine: TatVirtualMachine);
    procedure __LoadIBInstallLibrary(AMachine: TatVirtualMachine);
    procedure __FreeIBInstallLibrary(AMachine: TatVirtualMachine);
    procedure __TryIBLoad(AMachine: TatVirtualMachine);
    procedure __CheckIBLoaded(AMachine: TatVirtualMachine);
    procedure __GetIBClientVersion(AMachine: TatVirtualMachine);
    procedure __CheckIBInstallLoaded(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatIBIntfLibrary.__LoadIBLibrary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IBIntf.LoadIBLibrary;
  end;
end;

procedure TatIBIntfLibrary.__FreeIBLibrary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IBIntf.FreeIBLibrary;
  end;
end;

procedure TatIBIntfLibrary.__LoadIBInstallLibrary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IBIntf.LoadIBInstallLibrary;
  end;
end;

procedure TatIBIntfLibrary.__FreeIBInstallLibrary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IBIntf.FreeIBInstallLibrary;
  end;
end;

procedure TatIBIntfLibrary.__TryIBLoad(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := IBIntf.TryIBLoad;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBIntfLibrary.__CheckIBLoaded(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IBIntf.CheckIBLoaded;
  end;
end;

procedure TatIBIntfLibrary.__GetIBClientVersion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IBIntf.GetIBClientVersion);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBIntfLibrary.__CheckIBInstallLoaded(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IBIntf.CheckIBInstallLoaded;
  end;
end;

procedure TatIBIntfLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('LoadIBLibrary',0,tkNone,nil,__LoadIBLibrary,false,0);
    DefineMethod('FreeIBLibrary',0,tkNone,nil,__FreeIBLibrary,false,0);
    DefineMethod('LoadIBInstallLibrary',0,tkNone,nil,__LoadIBInstallLibrary,false,0);
    DefineMethod('FreeIBInstallLibrary',0,tkNone,nil,__FreeIBInstallLibrary,false,0);
    DefineMethod('TryIBLoad',0,tkVariant,nil,__TryIBLoad,false,0);
    DefineMethod('CheckIBLoaded',0,tkNone,nil,__CheckIBLoaded,false,0);
    DefineMethod('GetIBClientVersion',0,tkInteger,nil,__GetIBClientVersion,false,0);
    DefineMethod('CheckIBInstallLoaded',0,tkNone,nil,__CheckIBInstallLoaded,false,0);
  end;
end;

class function TatIBIntfLibrary.LibraryName: string;
begin
  result := 'IBIntf';
end;

initialization
  RegisterScripterLibrary(TatIBIntfLibrary, True);

{$WARNINGS ON}

end.

