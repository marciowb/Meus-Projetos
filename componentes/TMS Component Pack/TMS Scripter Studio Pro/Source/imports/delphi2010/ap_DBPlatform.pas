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
unit ap_DBPlatform;

interface

uses
  SysUtils,
  FMTBcd,
  DB,
  DBPlatform,
  Variants,
  ap_FMTBcd,
  atScript;

{$WARNINGS OFF}

type
  TatDBPlatformLibrary = class(TatScripterLibrary)
    procedure __TPlatformFieldAsWideString(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TPlatformBytesClass = class of TPlatformBytes;
  TPlatformRecordBufferClass = class of TPlatformRecordBuffer;
  TPlatformValueBufferClass = class of TPlatformValueBuffer;
  TPlatformPSResultClass = class of TPlatformPSResult;
  TPlatformFieldClass = class of TPlatformField;



implementation



procedure TatDBPlatformLibrary.__TPlatformFieldAsWideString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TPlatformFieldClass(CurrentClass.ClassRef).AsWideString(TField(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBPlatformLibrary.Init;
begin
  With Scripter.DefineClass(TPlatformBytes) do
  begin
  end;
  With Scripter.DefineClass(TPlatformRecordBuffer) do
  begin
  end;
  With Scripter.DefineClass(TPlatformValueBuffer) do
  begin
  end;
  With Scripter.DefineClass(TPlatformPSResult) do
  begin
  end;
  With Scripter.DefineClass(TPlatformField) do
  begin
    DefineMethod('AsWideString',1,tkVariant,nil,__TPlatformFieldAsWideString,true,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatDBPlatformLibrary.LibraryName: string;
begin
  result := 'DBPlatform';
end;

initialization
  RegisterScripterLibrary(TatDBPlatformLibrary, True);

{$WARNINGS ON}

end.

