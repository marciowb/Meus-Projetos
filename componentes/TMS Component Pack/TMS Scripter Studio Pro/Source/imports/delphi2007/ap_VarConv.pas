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
unit ap_VarConv;

interface

uses
  SysUtils,
  Variants,
  ConvUtils,
  VarConv,
  atScript;

{$WARNINGS OFF}

type
  TatVarConvLibrary = class(TatScripterLibrary)
    procedure __VarConvertCreate(AMachine: TatVirtualMachine);
    procedure __VarConvert(AMachine: TatVirtualMachine);
    procedure __VarIsConvert(AMachine: TatVirtualMachine);
    procedure __VarAsConvert(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatVarConvLibrary.__VarConvertCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarConv.VarConvertCreate(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarConvLibrary.__VarConvert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(VarConv.VarConvert);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarConvLibrary.__VarIsConvert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarConv.VarIsConvert(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarConvLibrary.__VarAsConvert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarConv.VarAsConvert(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarConvLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('VarConvertCreate',2,tkVariant,nil,__VarConvertCreate,false,0);
    DefineMethod('VarConvert',0,tkInteger,nil,__VarConvert,false,0);
    DefineMethod('VarIsConvert',1,tkVariant,nil,__VarIsConvert,false,0);
    DefineMethod('VarAsConvert',1,tkVariant,nil,__VarAsConvert,false,0);
  end;
end;

class function TatVarConvLibrary.LibraryName: string;
begin
  result := 'VarConv';
end;

initialization
  RegisterScripterLibrary(TatVarConvLibrary, True);

{$WARNINGS ON}

end.

