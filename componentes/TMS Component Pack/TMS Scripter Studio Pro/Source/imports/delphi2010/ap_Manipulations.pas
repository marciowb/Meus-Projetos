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
unit ap_Manipulations;

interface

uses
  Windows,
  Manipulations,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatManipulationsLibrary = class(TatScripterLibrary)
    procedure __GetCLSID_IInertiaProcessor(AMachine: TatVirtualMachine);
    procedure __GetCLSID_IManipulationProcessor(AMachine: TatVirtualMachine);
    procedure __GetIID__IManipulationEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IInertiaProcessor(AMachine: TatVirtualMachine);
    procedure __GetIID_IManipulationProcessor(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatManipulationsLibrary.__GetCLSID_IInertiaProcessor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Manipulations.CLSID_IInertiaProcessor)));
  end;
end;

procedure TatManipulationsLibrary.__GetCLSID_IManipulationProcessor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Manipulations.CLSID_IManipulationProcessor)));
  end;
end;

procedure TatManipulationsLibrary.__GetIID__IManipulationEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Manipulations.IID__IManipulationEvents)));
  end;
end;

procedure TatManipulationsLibrary.__GetIID_IInertiaProcessor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Manipulations.IID_IInertiaProcessor)));
  end;
end;

procedure TatManipulationsLibrary.__GetIID_IManipulationProcessor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Manipulations.IID_IManipulationProcessor)));
  end;
end;

procedure TatManipulationsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('CLSID_IInertiaProcessor',tkVariant,__GetCLSID_IInertiaProcessor,nil,nil,false,0);
    DefineProp('CLSID_IManipulationProcessor',tkVariant,__GetCLSID_IManipulationProcessor,nil,nil,false,0);
    DefineProp('IID__IManipulationEvents',tkVariant,__GetIID__IManipulationEvents,nil,nil,false,0);
    DefineProp('IID_IInertiaProcessor',tkVariant,__GetIID_IInertiaProcessor,nil,nil,false,0);
    DefineProp('IID_IManipulationProcessor',tkVariant,__GetIID_IManipulationProcessor,nil,nil,false,0);
    AddConstant('SID__IManipulationEvents',SID__IManipulationEvents);
    AddConstant('SID_IInertiaProcessor',SID_IInertiaProcessor);
    AddConstant('SID_IManipulationProcessor',SID_IManipulationProcessor);
    AddConstant('MANIPULATION_NONE',MANIPULATION_NONE);
    AddConstant('MANIPULATION_TRANSLATE_X',MANIPULATION_TRANSLATE_X);
    AddConstant('MANIPULATION_TRANSLATE_Y',MANIPULATION_TRANSLATE_Y);
    AddConstant('MANIPULATION_SCALE',MANIPULATION_SCALE);
    AddConstant('MANIPULATION_ROTATE',MANIPULATION_ROTATE);
    AddConstant('MANIPULATION_ALL',MANIPULATION_ALL);
  end;
end;

class function TatManipulationsLibrary.LibraryName: string;
begin
  result := 'Manipulations';
end;

initialization
  RegisterScripterLibrary(TatManipulationsLibrary, True);

{$WARNINGS ON}

end.

