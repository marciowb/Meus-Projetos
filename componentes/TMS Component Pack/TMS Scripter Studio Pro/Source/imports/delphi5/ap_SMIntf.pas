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
unit ap_SMIntf;

interface

uses
  SMIntf,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatSMIntfLibrary = class(TatScripterLibrary)
    procedure __GetClass_SMClient(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatSMIntfLibrary.__GetClass_SMClient(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(SMIntf.Class_SMClient)));
  end;
end;

procedure TatSMIntfLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('Class_SMClient',tkVariant,__GetClass_SMClient,nil,nil,false,0);
  end;
end;

class function TatSMIntfLibrary.LibraryName: string;
begin
  result := 'SMIntf';
end;

initialization
  RegisterScripterLibrary(TatSMIntfLibrary, True);

{$WARNINGS ON}

end.

