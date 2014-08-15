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
unit ap_FlatSB;

interface

uses
  Windows,
  FlatSB,
  atScript;

{$WARNINGS OFF}

type
  TatFlatSBLibrary = class(TatScripterLibrary)
    procedure __InitializeFlatSB(AMachine: TatVirtualMachine);
    procedure __UninitializeFlatSB(AMachine: TatVirtualMachine);
    procedure __FlatSB_SetScrollProp(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatFlatSBLibrary.__InitializeFlatSB(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := FlatSB.InitializeFlatSB(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFlatSBLibrary.__UninitializeFlatSB(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    FlatSB.UninitializeFlatSB(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatFlatSBLibrary.__FlatSB_SetScrollProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := FlatSB.FlatSB_SetScrollProp(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),GetInputArg(3));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFlatSBLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('InitializeFlatSB',1,tkVariant,nil,__InitializeFlatSB,false,0);
    DefineMethod('UninitializeFlatSB',1,tkNone,nil,__UninitializeFlatSB,false,0);
    DefineMethod('FlatSB_SetScrollProp',4,tkVariant,nil,__FlatSB_SetScrollProp,false,0);
  end;
end;

class function TatFlatSBLibrary.LibraryName: string;
begin
  result := 'FlatSB';
end;

initialization
  RegisterScripterLibrary(TatFlatSBLibrary, True);

{$WARNINGS ON}

end.

