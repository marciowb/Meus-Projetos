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
unit ap_IBUtils;

interface

uses
  Windows,
  Classes,
  SysUtils,
  IBUtils,
  atScript;

{$WARNINGS OFF}

type
  TatIBUtilsLibrary = class(TatScripterLibrary)
    procedure __Max(AMachine: TatVirtualMachine);
    procedure __Min(AMachine: TatVirtualMachine);
    procedure __RandomString(AMachine: TatVirtualMachine);
    procedure __RandomInteger(AMachine: TatVirtualMachine);
    procedure __StripString(AMachine: TatVirtualMachine);
    procedure __FormatIdentifier(AMachine: TatVirtualMachine);
    procedure __FormatIdentifierValue(AMachine: TatVirtualMachine);
    procedure __ExtractIdentifier(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatIBUtilsLibrary.__Max(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IBUtils.Max(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBUtilsLibrary.__Min(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IBUtils.Min(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBUtilsLibrary.__RandomString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := IBUtils.RandomString(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBUtilsLibrary.__RandomInteger(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IBUtils.RandomInteger(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBUtilsLibrary.__StripString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := IBUtils.StripString(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBUtilsLibrary.__FormatIdentifier(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := IBUtils.FormatIdentifier(VarToInteger(GetInputArg(0)),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBUtilsLibrary.__FormatIdentifierValue(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := IBUtils.FormatIdentifierValue(VarToInteger(GetInputArg(0)),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBUtilsLibrary.__ExtractIdentifier(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := IBUtils.ExtractIdentifier(VarToInteger(GetInputArg(0)),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBUtilsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('Max',2,tkInteger,nil,__Max,false,0);
    DefineMethod('Min',2,tkInteger,nil,__Min,false,0);
    DefineMethod('RandomString',1,tkVariant,nil,__RandomString,false,0);
    DefineMethod('RandomInteger',2,tkInteger,nil,__RandomInteger,false,0);
    DefineMethod('StripString',2,tkVariant,nil,__StripString,false,0);
    DefineMethod('FormatIdentifier',2,tkVariant,nil,__FormatIdentifier,false,0);
    DefineMethod('FormatIdentifierValue',2,tkVariant,nil,__FormatIdentifierValue,false,0);
    DefineMethod('ExtractIdentifier',2,tkVariant,nil,__ExtractIdentifier,false,0);
    AddConstant('CRLF',CRLF);
    AddConstant('CR',CR);
    AddConstant('LF',LF);
    AddConstant('TAB',TAB);
    AddConstant('NULL_TERMINATOR',NULL_TERMINATOR);
  end;
end;

class function TatIBUtilsLibrary.LibraryName: string;
begin
  result := 'IBUtils';
end;

initialization
  RegisterScripterLibrary(TatIBUtilsLibrary, True);

{$WARNINGS ON}

end.

