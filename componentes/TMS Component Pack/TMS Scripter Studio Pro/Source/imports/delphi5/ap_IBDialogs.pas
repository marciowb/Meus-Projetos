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
unit ap_IBDialogs;

interface

uses
  SysUtils,
  Windows,
  Messages,
  Classes,
  Graphics,
  Controls,
  Forms,
  StdCtrls,
  ExtCtrls,
  DBLogDlg,
  IBDialogs,
  atScript;

{$WARNINGS OFF}

type
  TatIBDialogsLibrary = class(TatScripterLibrary)
    procedure __ServerLoginDialog(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatIBDialogsLibrary.__ServerLoginDialog(AMachine: TatVirtualMachine);
  var
  Param1: string;
  Param2: string;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
Param2 := GetInputArg(2);
AResult := IBDialogs.ServerLoginDialog(GetInputArg(0),Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
    SetInputArg(2,Param2);
  end;
end;

procedure TatIBDialogsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('ServerLoginDialog',3,tkVariant,nil,__ServerLoginDialog,false,0).SetVarArgs([1,2]);
  end;
end;

class function TatIBDialogsLibrary.LibraryName: string;
begin
  result := 'IBDialogs';
end;

initialization
  RegisterScripterLibrary(TatIBDialogsLibrary, True);

{$WARNINGS ON}

end.

