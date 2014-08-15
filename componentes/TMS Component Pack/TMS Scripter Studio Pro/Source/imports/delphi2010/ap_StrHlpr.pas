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
unit ap_StrHlpr;

interface

uses
  StrHlpr,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatStrHlprLibrary = class(TatScripterLibrary)
    procedure __AnsiCat(AMachine: TatVirtualMachine);
    procedure __AnsiCopy(AMachine: TatVirtualMachine);
    procedure __AnsiPos(AMachine: TatVirtualMachine);
    procedure __AnsiAppend(AMachine: TatVirtualMachine);
    procedure __AnsiFromWide(AMachine: TatVirtualMachine);
    procedure __AnsiFromUnicode(AMachine: TatVirtualMachine);
    procedure __AnsiInsert(AMachine: TatVirtualMachine);
    procedure __AnsiEqual(AMachine: TatVirtualMachine);
    procedure __AnsiFromPChar(AMachine: TatVirtualMachine);
    procedure __AnsiFromPWideChar(AMachine: TatVirtualMachine);
    procedure __AnsiDelete(AMachine: TatVirtualMachine);
    procedure __AnsiSetLength(AMachine: TatVirtualMachine);
    procedure __AnsiFree(AMachine: TatVirtualMachine);
    procedure __AnsiAssign(AMachine: TatVirtualMachine);
    procedure __WideAppend(AMachine: TatVirtualMachine);
    procedure __WideCat(AMachine: TatVirtualMachine);
    procedure __WideCopy(AMachine: TatVirtualMachine);
    procedure __WideEqual(AMachine: TatVirtualMachine);
    procedure __WideGreater(AMachine: TatVirtualMachine);
    procedure __WideLength(AMachine: TatVirtualMachine);
    procedure __WideLess(AMachine: TatVirtualMachine);
    procedure __WidePos(AMachine: TatVirtualMachine);
    procedure __WideFromAnsi(AMachine: TatVirtualMachine);
    procedure __WideFromUnicode(AMachine: TatVirtualMachine);
    procedure __WideInsert(AMachine: TatVirtualMachine);
    procedure __WideFromPChar(AMachine: TatVirtualMachine);
    procedure __WideDelete(AMachine: TatVirtualMachine);
    procedure __WideSetLength(AMachine: TatVirtualMachine);
    procedure __WideFree(AMachine: TatVirtualMachine);
    procedure __WideAssign(AMachine: TatVirtualMachine);
    procedure __UnicodeCat(AMachine: TatVirtualMachine);
    procedure __UnicodeCopy(AMachine: TatVirtualMachine);
    procedure __UnicodePos(AMachine: TatVirtualMachine);
    procedure __UnicodeAppend(AMachine: TatVirtualMachine);
    procedure __UnicodeDelete(AMachine: TatVirtualMachine);
    procedure __UnicodeFromAnsi(AMachine: TatVirtualMachine);
    procedure __UnicodeFromWide(AMachine: TatVirtualMachine);
    procedure __UnicodeInsert(AMachine: TatVirtualMachine);
    procedure __UnicodeEqual(AMachine: TatVirtualMachine);
    procedure __UnicodeGreater(AMachine: TatVirtualMachine);
    procedure __UnicodeLess(AMachine: TatVirtualMachine);
    procedure __UnicodeFromPWideChar(AMachine: TatVirtualMachine);
    procedure __UnicodeFromPChar(AMachine: TatVirtualMachine);
    procedure __UnicodeSetLength(AMachine: TatVirtualMachine);
    procedure __UnicodeFree(AMachine: TatVirtualMachine);
    procedure __UnicodeAssign(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatStrHlprLibrary.__AnsiCat(AMachine: TatVirtualMachine);
  var
  Param0: RawByteString;
  Param1: RawByteString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
AResult := StrHlpr.AnsiCat(Param0,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__AnsiCopy(AMachine: TatVirtualMachine);
  var
  Param0: RawByteString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := StrHlpr.AnsiCopy(Param0,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__AnsiPos(AMachine: TatVirtualMachine);
  var
  Param0: RawByteString;
  Param1: RawByteString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
AResult := Integer(StrHlpr.AnsiPos(Param0,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__AnsiAppend(AMachine: TatVirtualMachine);
  var
  Param0: RawByteString;
  Param1: RawByteString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
    StrHlpr.AnsiAppend(Param0,Param1);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__AnsiFromWide(AMachine: TatVirtualMachine);
  var
  Param0: RawByteString;
  Param1: WideString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
    StrHlpr.AnsiFromWide(Param0,Param1);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__AnsiFromUnicode(AMachine: TatVirtualMachine);
  var
  Param0: RawByteString;
  Param1: UnicodeString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
    StrHlpr.AnsiFromUnicode(Param0,Param1);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__AnsiInsert(AMachine: TatVirtualMachine);
  var
  Param0: RawByteString;
  Param1: RawByteString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
    StrHlpr.AnsiInsert(Param0,Param1,VarToInteger(GetInputArg(2)));
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__AnsiEqual(AMachine: TatVirtualMachine);
  var
  Param0: RawByteString;
  Param1: RawByteString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
AResult := StrHlpr.AnsiEqual(Param0,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__AnsiFromPChar(AMachine: TatVirtualMachine);
  var
  Param0: RawByteString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.AnsiFromPChar(Param0,PChar(VarToStr(GetInputArg(1))));
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__AnsiFromPWideChar(AMachine: TatVirtualMachine);
  var
  Param0: RawByteString;
  Param1Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.AnsiFromPWideChar(Param0,StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__AnsiDelete(AMachine: TatVirtualMachine);
  var
  Param0: RawByteString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.AnsiDelete(Param0,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__AnsiSetLength(AMachine: TatVirtualMachine);
  var
  Param0: RawByteString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.AnsiSetLength(Param0,VarToInteger(GetInputArg(1)));
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__AnsiFree(AMachine: TatVirtualMachine);
  var
  Param0: RawByteString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.AnsiFree(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__AnsiAssign(AMachine: TatVirtualMachine);
  var
  Param0: RawByteString;
  Param1: RawByteString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
    StrHlpr.AnsiAssign(Param0,Param1);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__WideAppend(AMachine: TatVirtualMachine);
  var
  Param0: WideString;
  Param1: WideString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
    StrHlpr.WideAppend(Param0,Param1);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__WideCat(AMachine: TatVirtualMachine);
  var
  Param0: WideString;
  Param1: WideString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
AResult := StrHlpr.WideCat(Param0,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__WideCopy(AMachine: TatVirtualMachine);
  var
  Param0: WideString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := StrHlpr.WideCopy(Param0,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__WideEqual(AMachine: TatVirtualMachine);
  var
  Param0: WideString;
  Param1: WideString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
AResult := StrHlpr.WideEqual(Param0,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__WideGreater(AMachine: TatVirtualMachine);
  var
  Param0: WideString;
  Param1: WideString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
AResult := StrHlpr.WideGreater(Param0,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__WideLength(AMachine: TatVirtualMachine);
  var
  Param0: WideString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(StrHlpr.WideLength(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__WideLess(AMachine: TatVirtualMachine);
  var
  Param0: WideString;
  Param1: WideString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
AResult := StrHlpr.WideLess(Param0,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__WidePos(AMachine: TatVirtualMachine);
  var
  Param0: WideString;
  Param1: WideString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
AResult := Integer(StrHlpr.WidePos(Param0,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__WideFromAnsi(AMachine: TatVirtualMachine);
  var
  Param0: WideString;
  Param1: RawByteString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
    StrHlpr.WideFromAnsi(Param0,Param1);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__WideFromUnicode(AMachine: TatVirtualMachine);
  var
  Param0: WideString;
  Param1: UnicodeString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
    StrHlpr.WideFromUnicode(Param0,Param1);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__WideInsert(AMachine: TatVirtualMachine);
  var
  Param0: WideString;
  Param1: WideString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
    StrHlpr.WideInsert(Param0,Param1,VarToInteger(GetInputArg(2)));
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__WideFromPChar(AMachine: TatVirtualMachine);
  var
  Param0: WideString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.WideFromPChar(Param0,PChar(VarToStr(GetInputArg(1))));
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__WideDelete(AMachine: TatVirtualMachine);
  var
  Param0: WideString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.WideDelete(Param0,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__WideSetLength(AMachine: TatVirtualMachine);
  var
  Param0: WideString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.WideSetLength(Param0,VarToInteger(GetInputArg(1)));
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__WideFree(AMachine: TatVirtualMachine);
  var
  Param0: WideString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.WideFree(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__WideAssign(AMachine: TatVirtualMachine);
  var
  Param0: WideString;
  Param1: WideString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
    StrHlpr.WideAssign(Param0,Param1);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__UnicodeCat(AMachine: TatVirtualMachine);
  var
  Param0: UnicodeString;
  Param1: UnicodeString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
AResult := StrHlpr.UnicodeCat(Param0,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__UnicodeCopy(AMachine: TatVirtualMachine);
  var
  Param0: UnicodeString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := StrHlpr.UnicodeCopy(Param0,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__UnicodePos(AMachine: TatVirtualMachine);
  var
  Param0: UnicodeString;
  Param1: UnicodeString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
AResult := Integer(StrHlpr.UnicodePos(Param0,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__UnicodeAppend(AMachine: TatVirtualMachine);
  var
  Param0: UnicodeString;
  Param1: UnicodeString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
    StrHlpr.UnicodeAppend(Param0,Param1);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__UnicodeDelete(AMachine: TatVirtualMachine);
  var
  Param0: UnicodeString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.UnicodeDelete(Param0,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__UnicodeFromAnsi(AMachine: TatVirtualMachine);
  var
  Param0: UnicodeString;
  Param1: RawByteString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
    StrHlpr.UnicodeFromAnsi(Param0,Param1);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__UnicodeFromWide(AMachine: TatVirtualMachine);
  var
  Param0: UnicodeString;
  Param1: WideString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
    StrHlpr.UnicodeFromWide(Param0,Param1);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__UnicodeInsert(AMachine: TatVirtualMachine);
  var
  Param0: UnicodeString;
  Param1: UnicodeString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
    StrHlpr.UnicodeInsert(Param0,Param1,VarToInteger(GetInputArg(2)));
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__UnicodeEqual(AMachine: TatVirtualMachine);
  var
  Param0: UnicodeString;
  Param1: UnicodeString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
AResult := StrHlpr.UnicodeEqual(Param0,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__UnicodeGreater(AMachine: TatVirtualMachine);
  var
  Param0: UnicodeString;
  Param1: UnicodeString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
AResult := StrHlpr.UnicodeGreater(Param0,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__UnicodeLess(AMachine: TatVirtualMachine);
  var
  Param0: UnicodeString;
  Param1: UnicodeString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
AResult := StrHlpr.UnicodeLess(Param0,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.__UnicodeFromPWideChar(AMachine: TatVirtualMachine);
  var
  Param0: UnicodeString;
  Param1Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.UnicodeFromPWideChar(Param0,StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__UnicodeFromPChar(AMachine: TatVirtualMachine);
  var
  Param0: UnicodeString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.UnicodeFromPChar(Param0,PChar(VarToStr(GetInputArg(1))));
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__UnicodeSetLength(AMachine: TatVirtualMachine);
  var
  Param0: UnicodeString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.UnicodeSetLength(Param0,VarToInteger(GetInputArg(1)));
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__UnicodeFree(AMachine: TatVirtualMachine);
  var
  Param0: UnicodeString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.UnicodeFree(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__UnicodeAssign(AMachine: TatVirtualMachine);
  var
  Param0: UnicodeString;
  Param1: UnicodeString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
    StrHlpr.UnicodeAssign(Param0,Param1);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatStrHlprLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('AnsiCat',2,tkVariant,nil,__AnsiCat,false,0).SetVarArgs([0,1]);
    DefineMethod('AnsiCopy',3,tkVariant,nil,__AnsiCopy,false,0).SetVarArgs([0]);
    DefineMethod('AnsiPos',2,tkInteger,nil,__AnsiPos,false,0).SetVarArgs([0,1]);
    DefineMethod('AnsiAppend',2,tkNone,nil,__AnsiAppend,false,0).SetVarArgs([0,1]);
    DefineMethod('AnsiFromWide',2,tkNone,nil,__AnsiFromWide,false,0).SetVarArgs([0,1]);
    DefineMethod('AnsiFromUnicode',2,tkNone,nil,__AnsiFromUnicode,false,0).SetVarArgs([0,1]);
    DefineMethod('AnsiInsert',3,tkNone,nil,__AnsiInsert,false,0).SetVarArgs([0,1]);
    DefineMethod('AnsiEqual',2,tkVariant,nil,__AnsiEqual,false,0).SetVarArgs([0,1]);
    DefineMethod('AnsiFromPChar',2,tkNone,nil,__AnsiFromPChar,false,0).SetVarArgs([0]);
    DefineMethod('AnsiFromPWideChar',2,tkNone,nil,__AnsiFromPWideChar,false,0).SetVarArgs([0]);
    DefineMethod('AnsiDelete',3,tkNone,nil,__AnsiDelete,false,0).SetVarArgs([0]);
    DefineMethod('AnsiSetLength',2,tkNone,nil,__AnsiSetLength,false,0).SetVarArgs([0]);
    DefineMethod('AnsiFree',1,tkNone,nil,__AnsiFree,false,0).SetVarArgs([0]);
    DefineMethod('AnsiAssign',2,tkNone,nil,__AnsiAssign,false,0).SetVarArgs([0,1]);
    DefineMethod('WideAppend',2,tkNone,nil,__WideAppend,false,0).SetVarArgs([0,1]);
    DefineMethod('WideCat',2,tkVariant,nil,__WideCat,false,0).SetVarArgs([0,1]);
    DefineMethod('WideCopy',3,tkVariant,nil,__WideCopy,false,0).SetVarArgs([0]);
    DefineMethod('WideEqual',2,tkVariant,nil,__WideEqual,false,0).SetVarArgs([0,1]);
    DefineMethod('WideGreater',2,tkVariant,nil,__WideGreater,false,0).SetVarArgs([0,1]);
    DefineMethod('WideLength',1,tkInteger,nil,__WideLength,false,0).SetVarArgs([0]);
    DefineMethod('WideLess',2,tkVariant,nil,__WideLess,false,0).SetVarArgs([0,1]);
    DefineMethod('WidePos',2,tkInteger,nil,__WidePos,false,0).SetVarArgs([0,1]);
    DefineMethod('WideFromAnsi',2,tkNone,nil,__WideFromAnsi,false,0).SetVarArgs([0,1]);
    DefineMethod('WideFromUnicode',2,tkNone,nil,__WideFromUnicode,false,0).SetVarArgs([0,1]);
    DefineMethod('WideInsert',3,tkNone,nil,__WideInsert,false,0).SetVarArgs([0,1]);
    DefineMethod('WideFromPChar',2,tkNone,nil,__WideFromPChar,false,0).SetVarArgs([0]);
    DefineMethod('WideDelete',3,tkNone,nil,__WideDelete,false,0).SetVarArgs([0]);
    DefineMethod('WideSetLength',2,tkNone,nil,__WideSetLength,false,0).SetVarArgs([0]);
    DefineMethod('WideFree',1,tkNone,nil,__WideFree,false,0).SetVarArgs([0]);
    DefineMethod('WideAssign',2,tkNone,nil,__WideAssign,false,0).SetVarArgs([0,1]);
    DefineMethod('UnicodeCat',2,tkVariant,nil,__UnicodeCat,false,0).SetVarArgs([0,1]);
    DefineMethod('UnicodeCopy',3,tkVariant,nil,__UnicodeCopy,false,0).SetVarArgs([0]);
    DefineMethod('UnicodePos',2,tkInteger,nil,__UnicodePos,false,0).SetVarArgs([0,1]);
    DefineMethod('UnicodeAppend',2,tkNone,nil,__UnicodeAppend,false,0).SetVarArgs([0,1]);
    DefineMethod('UnicodeDelete',3,tkNone,nil,__UnicodeDelete,false,0).SetVarArgs([0]);
    DefineMethod('UnicodeFromAnsi',2,tkNone,nil,__UnicodeFromAnsi,false,0).SetVarArgs([0,1]);
    DefineMethod('UnicodeFromWide',2,tkNone,nil,__UnicodeFromWide,false,0).SetVarArgs([0,1]);
    DefineMethod('UnicodeInsert',3,tkNone,nil,__UnicodeInsert,false,0).SetVarArgs([0,1]);
    DefineMethod('UnicodeEqual',2,tkVariant,nil,__UnicodeEqual,false,0).SetVarArgs([0,1]);
    DefineMethod('UnicodeGreater',2,tkVariant,nil,__UnicodeGreater,false,0).SetVarArgs([0,1]);
    DefineMethod('UnicodeLess',2,tkVariant,nil,__UnicodeLess,false,0).SetVarArgs([0,1]);
    DefineMethod('UnicodeFromPWideChar',2,tkNone,nil,__UnicodeFromPWideChar,false,0).SetVarArgs([0]);
    DefineMethod('UnicodeFromPChar',2,tkNone,nil,__UnicodeFromPChar,false,0).SetVarArgs([0]);
    DefineMethod('UnicodeSetLength',2,tkNone,nil,__UnicodeSetLength,false,0).SetVarArgs([0]);
    DefineMethod('UnicodeFree',1,tkNone,nil,__UnicodeFree,false,0).SetVarArgs([0]);
    DefineMethod('UnicodeAssign',2,tkNone,nil,__UnicodeAssign,false,0).SetVarArgs([0,1]);
  end;
end;

class function TatStrHlprLibrary.LibraryName: string;
begin
  result := 'StrHlpr';
end;

initialization
  RegisterScripterLibrary(TatStrHlprLibrary, True);

{$WARNINGS ON}

end.

