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
unit ap_PlatformDefaultStyleActnCtrls;

interface

uses
  ActnMan,
  ActnMenus,
  ActnCtrls,
  PlatformDefaultStyleActnCtrls,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatPlatformDefaultStyleActnCtrlsLibrary = class(TatScripterLibrary)
    procedure __TPlatformDefaultStyleActionBarsGetStyleName(AMachine: TatVirtualMachine);
    procedure __GetPlatformDefaultStyle(AMachine: TatVirtualMachine);
    procedure __SetPlatformDefaultStyle(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TPlatformDefaultStyleActionBarsClass = class of TPlatformDefaultStyleActionBars;



implementation



procedure TatPlatformDefaultStyleActnCtrlsLibrary.__TPlatformDefaultStyleActionBarsGetStyleName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TPlatformDefaultStyleActionBars(CurrentObject).GetStyleName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPlatformDefaultStyleActnCtrlsLibrary.__GetPlatformDefaultStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(PlatformDefaultStyleActnCtrls.PlatformDefaultStyle));
  end;
end;

procedure TatPlatformDefaultStyleActnCtrlsLibrary.__SetPlatformDefaultStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    PlatformDefaultStyleActnCtrls.PlatformDefaultStyle:=TPlatformDefaultStyleActionBars(Integer(GetInputArg(0)));
  end;
end;

procedure TatPlatformDefaultStyleActnCtrlsLibrary.Init;
begin
  With Scripter.DefineClass(TPlatformDefaultStyleActionBars) do
  begin
    DefineMethod('GetStyleName',0,tkVariant,nil,__TPlatformDefaultStyleActionBarsGetStyleName,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('PlatformDefaultStyle',tkClass,__GetPlatformDefaultStyle,__SetPlatformDefaultStyle,TPlatformDefaultStyleActionBars,false,0);
  end;
end;

class function TatPlatformDefaultStyleActnCtrlsLibrary.LibraryName: string;
begin
  result := 'PlatformDefaultStyleActnCtrls';
end;

initialization
  RegisterScripterLibrary(TatPlatformDefaultStyleActnCtrlsLibrary, True);

{$WARNINGS ON}

end.

