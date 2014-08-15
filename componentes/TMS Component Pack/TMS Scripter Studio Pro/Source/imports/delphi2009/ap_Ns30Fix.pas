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
unit ap_Ns30Fix;

interface

uses
  Windows,
  Nsapi,
  Ns30Fix,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatNs30FixLibrary = class(TatScripterLibrary)
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



procedure TatNs30FixLibrary.__system_version(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Ns30Fix.system_version);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNs30FixLibrary.__net_read(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ns30Fix.net_read(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNs30FixLibrary.__net_write(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ns30Fix.net_write(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNs30FixLibrary.__net_isalive(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Ns30Fix.net_isalive(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNs30FixLibrary.__shexp_casecmp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ns30Fix.shexp_casecmp(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNs30FixLibrary.__util_env_str(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Ns30Fix.util_env_str(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNs30FixLibrary.__NSstr2String(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Ns30Fix.NSstr2String(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNs30FixLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('system_version',0,tkVariant,nil,__system_version,false,0);
    DefineMethod('net_read',4,tkInteger,nil,__net_read,false,0);
    DefineMethod('net_write',3,tkInteger,nil,__net_write,false,0);
    DefineMethod('net_isalive',1,tkVariant,nil,__net_isalive,false,0);
    DefineMethod('shexp_casecmp',2,tkInteger,nil,__shexp_casecmp,false,0);
    DefineMethod('util_env_str',2,tkVariant,nil,__util_env_str,false,0);
    DefineMethod('NSstr2String',1,tkVariant,nil,__NSstr2String,false,0);
    AddConstant('nshttp',nshttp);
  end;
end;

class function TatNs30FixLibrary.LibraryName: string;
begin
  result := 'Ns30Fix';
end;

initialization
  RegisterScripterLibrary(TatNs30FixLibrary, True);

{$WARNINGS ON}

end.

