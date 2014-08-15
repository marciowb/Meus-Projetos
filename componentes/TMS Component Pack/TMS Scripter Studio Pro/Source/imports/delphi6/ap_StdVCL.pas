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
unit ap_StdVCL;

interface

uses
  StdVCL,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatStdVCLLibrary = class(TatScripterLibrary)
    procedure __GetLIBID_StdVCL(AMachine: TatVirtualMachine);
    procedure __GetIID_IProvider(AMachine: TatVirtualMachine);
    procedure __GetIID_IStrings(AMachine: TatVirtualMachine);
    procedure __GetIID_IDataBroker(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatStdVCLLibrary.__GetLIBID_StdVCL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StdVCL.LIBID_StdVCL)));
  end;
end;

procedure TatStdVCLLibrary.__GetIID_IProvider(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StdVCL.IID_IProvider)));
  end;
end;

procedure TatStdVCLLibrary.__GetIID_IStrings(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StdVCL.IID_IStrings)));
  end;
end;

procedure TatStdVCLLibrary.__GetIID_IDataBroker(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StdVCL.IID_IDataBroker)));
  end;
end;

procedure TatStdVCLLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('LIBID_StdVCL',tkVariant,__GetLIBID_StdVCL,nil,nil,false,0);
    DefineProp('IID_IProvider',tkVariant,__GetIID_IProvider,nil,nil,false,0);
    DefineProp('IID_IStrings',tkVariant,__GetIID_IStrings,nil,nil,false,0);
    DefineProp('IID_IDataBroker',tkVariant,__GetIID_IDataBroker,nil,nil,false,0);
  end;
end;

class function TatStdVCLLibrary.LibraryName: string;
begin
  result := 'StdVCL';
end;

initialization
  RegisterScripterLibrary(TatStdVCLLibrary, True);

{$WARNINGS ON}

end.

