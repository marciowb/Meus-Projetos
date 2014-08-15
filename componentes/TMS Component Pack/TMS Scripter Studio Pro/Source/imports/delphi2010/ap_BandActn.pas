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
unit ap_BandActn;

interface

uses
  Graphics,
  Classes,
  Messages,
  Controls,
  ActnList,
  ActnMan,
  Forms,
  CustomizeDlg,
  BandActn,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatBandActnLibrary = class(TatScripterLibrary)
    procedure __TCustomizeActionBarsCreate(AMachine: TatVirtualMachine);
    procedure __TCustomizeActionBarsExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TCustomizeActionBarsHandlesTarget(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCustomizeActionBarsClass = class of TCustomizeActionBars;



implementation



procedure TatBandActnLibrary.__TCustomizeActionBarsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomizeActionBarsClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBandActnLibrary.__TCustomizeActionBarsExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeActionBars(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatBandActnLibrary.__TCustomizeActionBarsHandlesTarget(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomizeActionBars(CurrentObject).HandlesTarget(TObject(integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBandActnLibrary.Init;
begin
  With Scripter.DefineClass(TCustomizeActionBars) do
  begin
    DefineMethod('Create',1,tkClass,TCustomizeActionBars,__TCustomizeActionBarsCreate,true,0);
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TCustomizeActionBarsExecuteTarget,false,0);
    DefineMethod('HandlesTarget',1,tkVariant,nil,__TCustomizeActionBarsHandlesTarget,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatBandActnLibrary.LibraryName: string;
begin
  result := 'BandActn';
end;

initialization
  RegisterScripterLibrary(TatBandActnLibrary, True);

{$WARNINGS ON}

end.

