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
unit ap_SysInit;

interface

uses
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatSysInitLibrary = class(TatScripterLibrary)
    procedure __VclInit(AMachine: TatVirtualMachine);
    procedure __VclExit(AMachine: TatVirtualMachine);
    procedure __GetModuleIsLib(AMachine: TatVirtualMachine);
    procedure __SetModuleIsLib(AMachine: TatVirtualMachine);
    procedure __GetModuleIsPackage(AMachine: TatVirtualMachine);
    procedure __SetModuleIsPackage(AMachine: TatVirtualMachine);
    procedure __GetModuleIsCpp(AMachine: TatVirtualMachine);
    procedure __SetModuleIsCpp(AMachine: TatVirtualMachine);
    procedure __GetTlsIndex(AMachine: TatVirtualMachine);
    procedure __SetTlsIndex(AMachine: TatVirtualMachine);
    procedure __GetTlsLast(AMachine: TatVirtualMachine);
    procedure __SetTlsLast(AMachine: TatVirtualMachine);
    procedure __GetHInstance(AMachine: TatVirtualMachine);
    procedure __SetHInstance(AMachine: TatVirtualMachine);
    procedure __GetDataMark(AMachine: TatVirtualMachine);
    procedure __SetDataMark(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatSysInitLibrary.__VclInit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysInit.VclInit(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)),GetInputArg(3));
  end;
end;

procedure TatSysInitLibrary.__VclExit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysInit.VclExit;
  end;
end;

procedure TatSysInitLibrary.__GetModuleIsLib(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysInit.ModuleIsLib);
  end;
end;

procedure TatSysInitLibrary.__SetModuleIsLib(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysInit.ModuleIsLib:=GetInputArg(0);
  end;
end;

procedure TatSysInitLibrary.__GetModuleIsPackage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysInit.ModuleIsPackage);
  end;
end;

procedure TatSysInitLibrary.__SetModuleIsPackage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysInit.ModuleIsPackage:=GetInputArg(0);
  end;
end;

procedure TatSysInitLibrary.__GetModuleIsCpp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysInit.ModuleIsCpp);
  end;
end;

procedure TatSysInitLibrary.__SetModuleIsCpp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysInit.ModuleIsCpp:=GetInputArg(0);
  end;
end;

procedure TatSysInitLibrary.__GetTlsIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(SysInit.TlsIndex));
  end;
end;

procedure TatSysInitLibrary.__SetTlsIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysInit.TlsIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSysInitLibrary.__GetTlsLast(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(SysInit.TlsLast));
  end;
end;

procedure TatSysInitLibrary.__SetTlsLast(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysInit.TlsLast:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSysInitLibrary.__GetHInstance(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(SysInit.HInstance));
  end;
end;

procedure TatSysInitLibrary.__SetHInstance(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysInit.HInstance:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSysInitLibrary.__GetDataMark(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(SysInit.DataMark));
  end;
end;

procedure TatSysInitLibrary.__SetDataMark(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysInit.DataMark:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSysInitLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('VclInit',4,tkNone,nil,__VclInit,false,0);
    DefineMethod('VclExit',0,tkNone,nil,__VclExit,false,0);
    DefineProp('ModuleIsLib',tkVariant,__GetModuleIsLib,__SetModuleIsLib,nil,false,0);
    DefineProp('ModuleIsPackage',tkVariant,__GetModuleIsPackage,__SetModuleIsPackage,nil,false,0);
    DefineProp('ModuleIsCpp',tkVariant,__GetModuleIsCpp,__SetModuleIsCpp,nil,false,0);
    DefineProp('TlsIndex',tkInteger,__GetTlsIndex,__SetTlsIndex,nil,false,0);
    DefineProp('TlsLast',tkInteger,__GetTlsLast,__SetTlsLast,nil,false,0);
    DefineProp('HInstance',tkInteger,__GetHInstance,__SetHInstance,nil,false,0);
    DefineProp('DataMark',tkInteger,__GetDataMark,__SetDataMark,nil,false,0);
  end;
end;

class function TatSysInitLibrary.LibraryName: string;
begin
  result := 'SysInit';
end;

initialization
  RegisterScripterLibrary(TatSysInitLibrary, True);

{$WARNINGS ON}

end.

