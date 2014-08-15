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
unit ap_ActnColorMaps;

interface

uses
  Windows,
  Classes,
  Graphics,
  ActnMan,
  ActnColorMaps,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatActnColorMapsLibrary = class(TatScripterLibrary)
    procedure __TStandardColorMapUpdateColors(AMachine: TatVirtualMachine);
    procedure __TXPColorMapUpdateColors(AMachine: TatVirtualMachine);
    procedure __TTwilightColorMapUpdateColors(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TStandardColorMapClass = class of TStandardColorMap;
  TXPColorMapClass = class of TXPColorMap;
  TTwilightColorMapClass = class of TTwilightColorMap;



implementation



procedure TatActnColorMapsLibrary.__TStandardColorMapUpdateColors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStandardColorMap(CurrentObject).UpdateColors;
  end;
end;

procedure TatActnColorMapsLibrary.__TXPColorMapUpdateColors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TXPColorMap(CurrentObject).UpdateColors;
  end;
end;

procedure TatActnColorMapsLibrary.__TTwilightColorMapUpdateColors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTwilightColorMap(CurrentObject).UpdateColors;
  end;
end;

procedure TatActnColorMapsLibrary.Init;
begin
  With Scripter.DefineClass(TStandardColorMap) do
  begin
    DefineMethod('UpdateColors',0,tkNone,nil,__TStandardColorMapUpdateColors,false,0);
  end;
  With Scripter.DefineClass(TXPColorMap) do
  begin
    DefineMethod('UpdateColors',0,tkNone,nil,__TXPColorMapUpdateColors,false,0);
  end;
  With Scripter.DefineClass(TTwilightColorMap) do
  begin
    DefineMethod('UpdateColors',0,tkNone,nil,__TTwilightColorMapUpdateColors,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('cXPFrameOuter',cXPFrameOuter);
    AddConstant('cXPBtnFrameColor',cXPBtnFrameColor);
    AddConstant('cXPSelectedColor',cXPSelectedColor);
  end;
end;

class function TatActnColorMapsLibrary.LibraryName: string;
begin
  result := 'ActnColorMaps';
end;

initialization
  RegisterScripterLibrary(TatActnColorMapsLibrary, True);

{$WARNINGS ON}

end.

