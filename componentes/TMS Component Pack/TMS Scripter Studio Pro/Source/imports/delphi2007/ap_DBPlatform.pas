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
    procedure __TPlatformRecordBufferCreateRecordBuffer(AMachine: TatVirtualMachine);
    procedure __TPlatformRecordBufferFree(AMachine: TatVirtualMachine);
    procedure __TPlatformRecordBufferSetFMTBcd(AMachine: TatVirtualMachine);
    procedure __TPlatformRecordBufferGetFMTBcd(AMachine: TatVirtualMachine);
    procedure __TPlatformRecordBufferFillChar(AMachine: TatVirtualMachine);
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



procedure TatDBPlatformLibrary.__TPlatformRecordBufferCreateRecordBuffer(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(TPlatformRecordBufferClass(CurrentClass.ClassRef).CreateRecordBuffer(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBPlatformLibrary.__TPlatformRecordBufferFree(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPlatformRecordBufferClass(CurrentClass.ClassRef).Free(PChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatDBPlatformLibrary.__TPlatformRecordBufferSetFMTBcd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPlatformRecordBufferClass(CurrentClass.ClassRef).SetFMTBcd(PChar(VarToStr(GetInputArg(0))),TBcdWrapper(integer(GetInputArg(1))).ObjToRec);
  end;
end;

procedure TatDBPlatformLibrary.__TPlatformRecordBufferGetFMTBcd(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TBcd;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TBcdWrapper) then 
  Param1Rec := TBcdWrapper.Create(Param1);
Param1 := TBcdWrapper(Param1Rec).ObjToRec;
    TPlatformRecordBufferClass(CurrentClass.ClassRef).GetFMTBcd(PChar(VarToStr(GetInputArg(0))),Param1);
    SetInputArg(1,integer(TBcdWrapper.Create(Param1)));
  end;
end;

procedure TatDBPlatformLibrary.__TPlatformRecordBufferFillChar(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPlatformRecordBufferClass(CurrentClass.ClassRef).FillChar(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

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
    DefineMethod('CreateRecordBuffer',1,tkVariant,nil,__TPlatformRecordBufferCreateRecordBuffer,true,0);
    DefineMethod('Free',1,tkNone,nil,__TPlatformRecordBufferFree,true,0);
    DefineMethod('SetFMTBcd',2,tkNone,nil,__TPlatformRecordBufferSetFMTBcd,true,0);
    DefineMethod('GetFMTBcd',2,tkNone,nil,__TPlatformRecordBufferGetFMTBcd,true,0).SetVarArgs([1]);
    DefineMethod('FillChar',3,tkNone,nil,__TPlatformRecordBufferFillChar,true,0);
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

