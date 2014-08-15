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
unit ap_MidasCon;

interface

uses
  Classes,
  MConnect,
  SConnect,
  MidasCon,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatMidasConLibrary = class(TatScripterLibrary)
    procedure __TMidasConnectionCreate(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TRemoteServerClass = class of TRemoteServer;
  TMidasConnectionClass = class of TMidasConnection;



implementation



procedure TatMidasConLibrary.__TMidasConnectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMidasConnectionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMidasConLibrary.Init;
begin
  With Scripter.DefineClass(TRemoteServer) do
  begin
  end;
  With Scripter.DefineClass(TMidasConnection) do
  begin
    DefineMethod('Create',1,tkClass,TMidasConnection,__TMidasConnectionCreate,true,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('ctDCOM',ctDCOM);
    AddConstant('ctSockets',ctSockets);
    AddConstant('ctOLEnterprise',ctOLEnterprise);
  end;
end;

class function TatMidasConLibrary.LibraryName: string;
begin
  result := 'MidasCon';
end;

initialization
  RegisterScripterLibrary(TatMidasConLibrary, True);

{$WARNINGS ON}

end.

