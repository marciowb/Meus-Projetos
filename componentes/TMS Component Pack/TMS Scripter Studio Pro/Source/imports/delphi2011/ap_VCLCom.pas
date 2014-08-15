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
unit ap_VCLCom;

interface

uses
  ActiveX,
  ComObj,
  Classes,
  VCLCom,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatVCLComLibrary = class(TatScripterLibrary)
    procedure __TComponentFactoryCreateComObject(AMachine: TatVirtualMachine);
    procedure __TComponentFactoryUpdateRegistry(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TComponentFactoryClass = class of TComponentFactory;



implementation



procedure TatVCLComLibrary.__TComponentFactoryCreateComObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComponentFactory(CurrentObject).CreateComObject(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVCLComLibrary.__TComponentFactoryUpdateRegistry(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComponentFactory(CurrentObject).UpdateRegistry(GetInputArg(0));
  end;
end;

procedure TatVCLComLibrary.Init;
begin
  With Scripter.DefineClass(TComponentFactory) do
  begin
    DefineMethod('CreateComObject',1,tkClass,TComObject,__TComponentFactoryCreateComObject,false,0);
    DefineMethod('UpdateRegistry',1,tkNone,nil,__TComponentFactoryUpdateRegistry,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatVCLComLibrary.LibraryName: string;
begin
  result := 'VCLCom';
end;

initialization
  RegisterScripterLibrary(TatVCLComLibrary, True);

{$WARNINGS ON}

end.

