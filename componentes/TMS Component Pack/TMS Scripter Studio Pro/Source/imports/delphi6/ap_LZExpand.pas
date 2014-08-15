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
unit ap_LZExpand;

interface

uses
  Windows,
  LZExpand,
  Variants,
  ap_Windows,
  atScript;

{$WARNINGS OFF}

type
  TatLZExpandLibrary = class(TatScripterLibrary)
    procedure __LZCopy(AMachine: TatVirtualMachine);
    procedure __LZInit(AMachine: TatVirtualMachine);
    procedure __GetExpandedName(AMachine: TatVirtualMachine);
    procedure __GetExpandedNameA(AMachine: TatVirtualMachine);
    procedure __GetExpandedNameW(AMachine: TatVirtualMachine);
    procedure __LZOpenFile(AMachine: TatVirtualMachine);
    procedure __LZOpenFileA(AMachine: TatVirtualMachine);
    procedure __LZOpenFileW(AMachine: TatVirtualMachine);
    procedure __LZSeek(AMachine: TatVirtualMachine);
    procedure __LZRead(AMachine: TatVirtualMachine);
    procedure __LZClose(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatLZExpandLibrary.__LZCopy(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(LZExpand.LZCopy(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatLZExpandLibrary.__LZInit(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(LZExpand.LZInit(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatLZExpandLibrary.__GetExpandedName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(LZExpand.GetExpandedName(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatLZExpandLibrary.__GetExpandedNameA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(LZExpand.GetExpandedNameA(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatLZExpandLibrary.__GetExpandedNameW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(LZExpand.GetExpandedNameW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatLZExpandLibrary.__LZOpenFile(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TOFStruct;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _OFSTRUCTWrapper) then 
  Param1Rec := _OFSTRUCTWrapper.Create(Param1);
Param1 := _OFSTRUCTWrapper(Param1Rec).ObjToRec;
AResult := Integer(LZExpand.LZOpenFile(PChar(VarToStr(GetInputArg(0))),Param1,VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_OFSTRUCTWrapper.Create(Param1)));
  end;
end;

procedure TatLZExpandLibrary.__LZOpenFileA(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TOFStruct;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _OFSTRUCTWrapper) then 
  Param1Rec := _OFSTRUCTWrapper.Create(Param1);
Param1 := _OFSTRUCTWrapper(Param1Rec).ObjToRec;
AResult := Integer(LZExpand.LZOpenFileA(PChar(VarToStr(GetInputArg(0))),Param1,VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_OFSTRUCTWrapper.Create(Param1)));
  end;
end;

procedure TatLZExpandLibrary.__LZOpenFileW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TOFStruct;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _OFSTRUCTWrapper) then 
  Param1Rec := _OFSTRUCTWrapper.Create(Param1);
Param1 := _OFSTRUCTWrapper(Param1Rec).ObjToRec;
AResult := Integer(LZExpand.LZOpenFileW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_OFSTRUCTWrapper.Create(Param1)));
  end;
end;

procedure TatLZExpandLibrary.__LZSeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(LZExpand.LZSeek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatLZExpandLibrary.__LZRead(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(LZExpand.LZRead(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatLZExpandLibrary.__LZClose(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    LZExpand.LZClose(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatLZExpandLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('LZCopy',2,tkInteger,nil,__LZCopy,false,0);
    DefineMethod('LZInit',1,tkInteger,nil,__LZInit,false,0);
    DefineMethod('GetExpandedName',2,tkInteger,nil,__GetExpandedName,false,0);
    DefineMethod('GetExpandedNameA',2,tkInteger,nil,__GetExpandedNameA,false,0);
    DefineMethod('GetExpandedNameW',2,tkInteger,nil,__GetExpandedNameW,false,0);
    DefineMethod('LZOpenFile',3,tkInteger,nil,__LZOpenFile,false,0).SetVarArgs([1]);
    DefineMethod('LZOpenFileA',3,tkInteger,nil,__LZOpenFileA,false,0).SetVarArgs([1]);
    DefineMethod('LZOpenFileW',3,tkInteger,nil,__LZOpenFileW,false,0).SetVarArgs([1]);
    DefineMethod('LZSeek',3,tkInteger,nil,__LZSeek,false,0);
    DefineMethod('LZRead',3,tkInteger,nil,__LZRead,false,0);
    DefineMethod('LZClose',1,tkNone,nil,__LZClose,false,0);
    AddConstant('LZERROR_BADINHANDLE',LZERROR_BADINHANDLE);
    AddConstant('LZERROR_BADOUTHANDLE',LZERROR_BADOUTHANDLE);
    AddConstant('LZERROR_READ',LZERROR_READ);
    AddConstant('LZERROR_WRITE',LZERROR_WRITE);
    AddConstant('LZERROR_GLOBALLOC',LZERROR_GLOBALLOC);
    AddConstant('LZERROR_GLOBLOCK',LZERROR_GLOBLOCK);
    AddConstant('LZERROR_BADVALUE',LZERROR_BADVALUE);
    AddConstant('LZERROR_UNKNOWNALG',LZERROR_UNKNOWNALG);
  end;
end;

class function TatLZExpandLibrary.LibraryName: string;
begin
  result := 'LZExpand';
end;

initialization
  RegisterScripterLibrary(TatLZExpandLibrary, True);

{$WARNINGS ON}

end.

