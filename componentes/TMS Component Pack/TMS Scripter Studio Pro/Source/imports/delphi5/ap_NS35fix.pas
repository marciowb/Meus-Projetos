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
unit ap_NS35fix;

interface

uses
  Windows,
  NSAPI,
  NS35fix,
  atScript;

type
  TatNS35fixLibrary = class(TatScripterLibrary)
    procedure __system_version(AMachine: TatVirtualMachine);
    procedure __net_read(AMachine: TatVirtualMachine);
    procedure __net_write(AMachine: TatVirtualMachine);
    procedure __net_isalive(AMachine: TatVirtualMachine);
    procedure __shexp_casecmp(AMachine: TatVirtualMachine);
    procedure __util_env_str(AMachine: TatVirtualMachine);
    procedure __NSstr2String(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation

{$WARNINGS OFF}



procedure TatNS35fixLibrary.__system_version(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(NS35fix.system_version);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNS35fixLibrary.__net_read(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(NS35fix.net_read(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNS35fixLibrary.__net_write(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(NS35fix.net_write(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNS35fixLibrary.__net_isalive(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := NS35fix.net_isalive(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNS35fixLibrary.__shexp_casecmp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(NS35fix.shexp_casecmp(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNS35fixLibrary.__util_env_str(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(NS35fix.util_env_str(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNS35fixLibrary.__NSstr2String(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := NS35fix.NSstr2String(PChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNS35fixLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('system_version',0,tkVariant,nil,__system_version,false);
    DefineMethod('net_read',4,tkInteger,nil,__net_read,false);
    DefineMethod('net_write',3,tkInteger,nil,__net_write,false);
    DefineMethod('net_isalive',1,tkVariant,nil,__net_isalive,false);
    DefineMethod('shexp_casecmp',2,tkInteger,nil,__shexp_casecmp,false);
    DefineMethod('util_env_str',2,tkVariant,nil,__util_env_str,false);
    DefineMethod('NSstr2String',1,tkVariant,nil,__NSstr2String,false);
    AddConstant('nshttp',nshttp);
  end;
end;

class function TatNS35fixLibrary.LibraryName: string;
begin
  result := 'NS35fix';
end;

initialization
  RegisterScripterLibrary(TatNS35fixLibrary, True);

{$WARNINGS ON}

end.
