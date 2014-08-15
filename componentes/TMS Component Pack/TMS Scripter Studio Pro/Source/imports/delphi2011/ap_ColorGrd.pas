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
unit ap_ColorGrd;

interface

uses
  Windows,
  Messages,
  Classes,
  Graphics,
  Forms,
  Controls,
  ExtCtrls,
  ColorGrd,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatColorGrdLibrary = class(TatScripterLibrary)
    procedure __TColorGridCreate(AMachine: TatVirtualMachine);
    procedure __TColorGridColorToIndex(AMachine: TatVirtualMachine);
    procedure __GetTColorGridForegroundColor(AMachine: TatVirtualMachine);
    procedure __GetTColorGridBackgroundColor(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TColorGridClass = class of TColorGrid;



implementation



procedure TatColorGrdLibrary.__TColorGridCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TColorGridClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatColorGrdLibrary.__TColorGridColorToIndex(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TColorGrid(CurrentObject).ColorToIndex(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatColorGrdLibrary.__GetTColorGridForegroundColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TColorGrid(CurrentObject).ForegroundColor);
  end;
end;

procedure TatColorGrdLibrary.__GetTColorGridBackgroundColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TColorGrid(CurrentObject).BackgroundColor);
  end;
end;

procedure TatColorGrdLibrary.Init;
begin
  With Scripter.DefineClass(TColorGrid) do
  begin
    DefineMethod('Create',1,tkClass,TColorGrid,__TColorGridCreate,true,0);
    DefineMethod('ColorToIndex',1,tkInteger,nil,__TColorGridColorToIndex,false,0);
    DefineProp('ForegroundColor',tkEnumeration,__GetTColorGridForegroundColor,nil,nil,false,0);
    DefineProp('BackgroundColor',tkEnumeration,__GetTColorGridBackgroundColor,nil,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('go16x1',go16x1);
    AddConstant('go8x2',go8x2);
    AddConstant('go4x4',go4x4);
    AddConstant('go2x8',go2x8);
    AddConstant('go1x16',go1x16);
    AddConstant('NumPaletteEntries',NumPaletteEntries);
  end;
end;

class function TatColorGrdLibrary.LibraryName: string;
begin
  result := 'ColorGrd';
end;

initialization
  RegisterScripterLibrary(TatColorGrdLibrary, True);

{$WARNINGS ON}

end.

