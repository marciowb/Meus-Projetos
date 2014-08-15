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
unit ap_DBInpReq;

interface

uses
  Windows,
  Classes,
  SysUtils,
  Forms,
  Controls,
  StdCtrls,
  ExtCtrls,
  BDE,
  Dialogs,
  DBInpReq,
  atScript;

{$WARNINGS OFF}

type
  TatDBInpReqLibrary = class(TatScripterLibrary)
    procedure __TInputReqDialogInputOptionsClick(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TInputReqDialogClass = class of TInputReqDialog;



implementation



procedure TatDBInpReqLibrary.__TInputReqDialogInputOptionsClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TInputReqDialog(CurrentObject).InputOptionsClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBInpReqLibrary.Init;
begin
  With Scripter.DefineClass(TInputReqDialog) do
  begin
    DefineMethod('InputOptionsClick',1,tkNone,nil,__TInputReqDialogInputOptionsClick,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatDBInpReqLibrary.LibraryName: string;
begin
  result := 'DBInpReq';
end;

initialization
  RegisterScripterLibrary(TatDBInpReqLibrary, True);

{$WARNINGS ON}

end.

