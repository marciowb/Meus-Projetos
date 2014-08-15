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
unit ap_DBClientActnRes;

interface

uses
  SysUtils,
  Classes,
  ActnList,
  DBClientActns,
  DBActns,
  ImgList,
  Controls,
  DBClientActnRes,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatDBClientActnResLibrary = class(TatScripterLibrary)
    procedure __GetClientDatasetActions(AMachine: TatVirtualMachine);
    procedure __SetClientDatasetActions(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TClientDatasetActionsClass = class of TClientDatasetActions;



implementation



procedure TatDBClientActnResLibrary.__GetClientDatasetActions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(DBClientActnRes.ClientDatasetActions));
  end;
end;

procedure TatDBClientActnResLibrary.__SetClientDatasetActions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DBClientActnRes.ClientDatasetActions:=TClientDatasetActions(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBClientActnResLibrary.Init;
begin
  With Scripter.DefineClass(TClientDatasetActions) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('ClientDatasetActions',tkClass,__GetClientDatasetActions,__SetClientDatasetActions,TClientDatasetActions,false,0);
  end;
end;

class function TatDBClientActnResLibrary.LibraryName: string;
begin
  result := 'DBClientActnRes';
end;

initialization
  RegisterScripterLibrary(TatDBClientActnResLibrary, True);

{$WARNINGS ON}

end.

