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
unit ap_StdStyleActnCtrls;

interface

uses
  ActnMan,
  ActnMenus,
  ActnCtrls,
  StdStyleActnCtrls,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatStdStyleActnCtrlsLibrary = class(TatScripterLibrary)
    procedure __TStandardStyleActionBarsGetStyleName(AMachine: TatVirtualMachine);
    procedure __GetStandardStyle(AMachine: TatVirtualMachine);
    procedure __SetStandardStyle(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TStandardStyleActionBarsClass = class of TStandardStyleActionBars;



implementation



procedure TatStdStyleActnCtrlsLibrary.__TStandardStyleActionBarsGetStyleName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TStandardStyleActionBars(CurrentObject).GetStyleName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdStyleActnCtrlsLibrary.__GetStandardStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(StdStyleActnCtrls.StandardStyle));
  end;
end;

procedure TatStdStyleActnCtrlsLibrary.__SetStandardStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdStyleActnCtrls.StandardStyle:=TStandardStyleActionBars(Integer(GetInputArg(0)));
  end;
end;

procedure TatStdStyleActnCtrlsLibrary.Init;
begin
  With Scripter.DefineClass(TStandardStyleActionBars) do
  begin
    DefineMethod('GetStyleName',0,tkVariant,nil,__TStandardStyleActionBarsGetStyleName,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('StandardStyle',tkClass,__GetStandardStyle,__SetStandardStyle,TStandardStyleActionBars,false,0);
  end;
end;

class function TatStdStyleActnCtrlsLibrary.LibraryName: string;
begin
  result := 'StdStyleActnCtrls';
end;

initialization
  RegisterScripterLibrary(TatStdStyleActnCtrlsLibrary, True);

{$WARNINGS ON}

end.

