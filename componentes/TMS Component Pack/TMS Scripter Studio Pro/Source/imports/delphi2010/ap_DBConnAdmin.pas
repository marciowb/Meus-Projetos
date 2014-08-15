{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2009                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_DBConnAdmin;

interface

{$WARNINGS OFF}

uses
  Classes,
  IniFiles,
  DBConnAdmin,
  Variants,
  atScript;

type
  TatDBConnAdminLibrary = class(TatScripterLibrary)
    procedure __TConnectionAdminCreate(AMachine: TatVirtualMachine);
    procedure __TConnectionAdminDestroy(AMachine: TatVirtualMachine);
    procedure __GetTConnectionAdminConnectionConfig(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TConnectionAdminClass = class of TConnectionAdmin;



implementation

{$WARNINGS OFF}



procedure TatDBConnAdminLibrary.__TConnectionAdminCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TConnectionAdminClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBConnAdminLibrary.__TConnectionAdminDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TConnectionAdmin(CurrentObject).Destroy;
  end;
end;

procedure TatDBConnAdminLibrary.__GetTConnectionAdminConnectionConfig(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TConnectionAdmin(CurrentObject).ConnectionConfig));
  end;
end;

procedure TatDBConnAdminLibrary.Init;
begin
  With Scripter.DefineClass(TConnectionAdmin) do
  begin
    DefineMethod('Create',0,tkClass,TConnectionAdmin,__TConnectionAdminCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TConnectionAdminDestroy,false,0);
    DefineProp('ConnectionConfig',tkVariant,__GetTConnectionAdminConnectionConfig,nil,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatDBConnAdminLibrary.LibraryName: string;
begin
  result := 'DBConnAdmin';
end;

initialization
  RegisterScripterLibrary(TatDBConnAdminLibrary, True);

{$WARNINGS ON}

end.
