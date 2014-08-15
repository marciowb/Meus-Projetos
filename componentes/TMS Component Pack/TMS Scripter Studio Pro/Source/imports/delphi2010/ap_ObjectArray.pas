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
unit ap_ObjectArray;

interface

uses
  Windows,
  ActiveX,
  ObjectArray,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatObjectArrayLibrary = class(TatScripterLibrary)
    procedure __GetIID_IObjectArray(AMachine: TatVirtualMachine);
    procedure __GetIID_IObjectCollection(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatObjectArrayLibrary.__GetIID_IObjectArray(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ObjectArray.IID_IObjectArray)));
  end;
end;

procedure TatObjectArrayLibrary.__GetIID_IObjectCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ObjectArray.IID_IObjectCollection)));
  end;
end;

procedure TatObjectArrayLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('IID_IObjectArray',tkVariant,__GetIID_IObjectArray,nil,nil,false,0);
    DefineProp('IID_IObjectCollection',tkVariant,__GetIID_IObjectCollection,nil,nil,false,0);
    AddConstant('SID_IObjectArray',SID_IObjectArray);
    AddConstant('SID_IObjectCollection',SID_IObjectCollection);
  end;
end;

class function TatObjectArrayLibrary.LibraryName: string;
begin
  result := 'ObjectArray';
end;

initialization
  RegisterScripterLibrary(TatObjectArrayLibrary, True);

{$WARNINGS ON}

end.

