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
unit ap_ActnRes;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ImgList,
  StdActns,
  ActnList,
  ExtActns,
  ActnRes,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatActnResLibrary = class(TatScripterLibrary)
    procedure __GetStandardActions(AMachine: TatVirtualMachine);
    procedure __SetStandardActions(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TStandardActionsClass = class of TStandardActions;



implementation



procedure TatActnResLibrary.__GetStandardActions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(ActnRes.StandardActions));
  end;
end;

procedure TatActnResLibrary.__SetStandardActions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ActnRes.StandardActions:=TStandardActions(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnResLibrary.Init;
begin
  With Scripter.DefineClass(TStandardActions) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('StandardActions',tkClass,__GetStandardActions,__SetStandardActions,TStandardActions,false,0);
  end;
end;

class function TatActnResLibrary.LibraryName: string;
begin
  result := 'ActnRes';
end;

initialization
  RegisterScripterLibrary(TatActnResLibrary, True);

{$WARNINGS ON}

end.

