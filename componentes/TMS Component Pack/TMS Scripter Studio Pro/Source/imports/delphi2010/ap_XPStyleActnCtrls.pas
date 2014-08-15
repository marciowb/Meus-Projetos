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
unit ap_XPStyleActnCtrls;

interface

uses
  ActnMan,
  ActnMenus,
  ActnCtrls,
  XPStyleActnCtrls,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatXPStyleActnCtrlsLibrary = class(TatScripterLibrary)
    procedure __TXPStyleActionBarsGetStyleName(AMachine: TatVirtualMachine);
    procedure __GetXPStyle(AMachine: TatVirtualMachine);
    procedure __SetXPStyle(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TXPStyleActionBarsClass = class of TXPStyleActionBars;



implementation



procedure TatXPStyleActnCtrlsLibrary.__TXPStyleActionBarsGetStyleName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TXPStyleActionBars(CurrentObject).GetStyleName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatXPStyleActnCtrlsLibrary.__GetXPStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(XPStyleActnCtrls.XPStyle));
  end;
end;

procedure TatXPStyleActnCtrlsLibrary.__SetXPStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    XPStyleActnCtrls.XPStyle:=TXPStyleActionBars(Integer(GetInputArg(0)));
  end;
end;

procedure TatXPStyleActnCtrlsLibrary.Init;
begin
  With Scripter.DefineClass(TXPStyleActionBars) do
  begin
    DefineMethod('GetStyleName',0,tkVariant,nil,__TXPStyleActionBarsGetStyleName,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('XPStyle',tkClass,__GetXPStyle,__SetXPStyle,TXPStyleActionBars,false,0);
  end;
end;

class function TatXPStyleActnCtrlsLibrary.LibraryName: string;
begin
  result := 'XPStyleActnCtrls';
end;

initialization
  RegisterScripterLibrary(TatXPStyleActnCtrlsLibrary, True);

{$WARNINGS ON}

end.

