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
unit ap_Midas;

interface

uses
  ActiveX,
  Midas,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatMidasLibrary = class(TatScripterLibrary)
    procedure __GetLIBID_Midas(AMachine: TatVirtualMachine);
    procedure __GetIID_IAppServer(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatMidasLibrary.__GetLIBID_Midas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Midas.LIBID_Midas)));
  end;
end;

procedure TatMidasLibrary.__GetIID_IAppServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Midas.IID_IAppServer)));
  end;
end;

procedure TatMidasLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('LIBID_Midas',tkVariant,__GetLIBID_Midas,nil,nil,false,0);
    DefineProp('IID_IAppServer',tkVariant,__GetIID_IAppServer,nil,nil,false,0);
  end;
end;

class function TatMidasLibrary.LibraryName: string;
begin
  result := 'Midas';
end;

initialization
  RegisterScripterLibrary(TatMidasLibrary, True);

{$WARNINGS ON}

end.

