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
    procedure __AnsiDelete(AMachine: TatVirtualMachine);
    procedure __AnsiFromPWideChar(AMachine: TatVirtualMachine);
    procedure __AnsiFromWide(AMachine: TatVirtualMachine);
    procedure __AnsiInsert(AMachine: TatVirtualMachine);
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
    procedure __WideDelete(AMachine: TatVirtualMachine);
    procedure __WideFree(AMachine: TatVirtualMachine);
    procedure __WideFromAnsi(AMachine: TatVirtualMachine);
    procedure __WideFromPChar(AMachine: TatVirtualMachine);
    procedure __WideInsert(AMachine: TatVirtualMachine);
    procedure __WideSetLength(AMachine: TatVirtualMachine);
    procedure __WideAssign(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatStrHlprLibrary.__AnsiCat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := StrHlpr.AnsiCat(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStrHlprLibrary.__AnsiCopy(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := StrHlpr.AnsiCopy(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStrHlprLibrary.__AnsiPos(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(StrHlpr.AnsiPos(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStrHlprLibrary.__AnsiAppend(AMachine: TatVirtualMachine);
  var
  Param0: AnsiString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.AnsiAppend(Param0,GetInputArg(1));
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__AnsiDelete(AMachine: TatVirtualMachine);
  var
  Param0: AnsiString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.AnsiDelete(Param0,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__AnsiFromPWideChar(AMachine: TatVirtualMachine);
  var
  Param0: AnsiString;
  Param1Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.AnsiFromPWideChar(Param0,StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__AnsiFromWide(AMachine: TatVirtualMachine);
  var
  Param0: AnsiString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.AnsiFromWide(Param0,GetInputArg(1));
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__AnsiInsert(AMachine: TatVirtualMachine);
  var
  Param0: AnsiString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.AnsiInsert(Param0,GetInputArg(1),VarToInteger(GetInputArg(2)));
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__AnsiSetLength(AMachine: TatVirtualMachine);
  var
  Param0: AnsiString;
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
  Param0: AnsiString;
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
  Param0: AnsiString;
  Param1: AnsiString;
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
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.WideAppend(Param0,GetInputArg(1));
    SetInputArg(0,Param0);
  end;
end;

procedure TatStrHlprLibrary.__WideCat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := StrHlpr.WideCat(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStrHlprLibrary.__WideCopy(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := StrHlpr.WideCopy(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStrHlprLibrary.__WideEqual(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := StrHlpr.WideEqual(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStrHlprLibrary.__WideGreater(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := StrHlpr.WideGreater(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStrHlprLibrary.__WideLength(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(StrHlpr.WideLength(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStrHlprLibrary.__WideLess(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := StrHlpr.WideLess(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStrHlprLibrary.__WidePos(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(StrHlpr.WidePos(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
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

procedure TatStrHlprLibrary.__WideFromAnsi(AMachine: TatVirtualMachine);
  var
  Param0: WideString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.WideFromAnsi(Param0,GetInputArg(1));
    SetInputArg(0,Param0);
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

procedure TatStrHlprLibrary.__WideInsert(AMachine: TatVirtualMachine);
  var
  Param0: WideString;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    StrHlpr.WideInsert(Param0,GetInputArg(1),VarToInteger(GetInputArg(2)));
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

procedure TatStrHlprLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('AnsiCat',2,tkVariant,nil,__AnsiCat,false,0);
    DefineMethod('AnsiCopy',3,tkVariant,nil,__AnsiCopy,false,0);
    DefineMethod('AnsiPos',2,tkInteger,nil,__AnsiPos,false,0);
    DefineMethod('AnsiAppend',2,tkNone,nil,__AnsiAppend,false,0).SetVarArgs([0]);
    DefineMethod('AnsiDelete',3,tkNone,nil,__AnsiDelete,false,0).SetVarArgs([0]);
    DefineMethod('AnsiFromPWideChar',2,tkNone,nil,__AnsiFromPWideChar,false,0).SetVarArgs([0]);
    DefineMethod('AnsiFromWide',2,tkNone,nil,__AnsiFromWide,false,0).SetVarArgs([0]);
    DefineMethod('AnsiInsert',3,tkNone,nil,__AnsiInsert,false,0).SetVarArgs([0]);
    DefineMethod('AnsiSetLength',2,tkNone,nil,__AnsiSetLength,false,0).SetVarArgs([0]);
    DefineMethod('AnsiFree',1,tkNone,nil,__AnsiFree,false,0).SetVarArgs([0]);
    DefineMethod('AnsiAssign',2,tkNone,nil,__AnsiAssign,false,0).SetVarArgs([0,1]);
    DefineMethod('WideAppend',2,tkNone,nil,__WideAppend,false,0).SetVarArgs([0]);
    DefineMethod('WideCat',2,tkVariant,nil,__WideCat,false,0);
    DefineMethod('WideCopy',3,tkVariant,nil,__WideCopy,false,0);
    DefineMethod('WideEqual',2,tkVariant,nil,__WideEqual,false,0);
    DefineMethod('WideGreater',2,tkVariant,nil,__WideGreater,false,0);
    DefineMethod('WideLength',1,tkInteger,nil,__WideLength,false,0);
    DefineMethod('WideLess',2,tkVariant,nil,__WideLess,false,0);
    DefineMethod('WidePos',2,tkInteger,nil,__WidePos,false,0);
    DefineMethod('WideDelete',3,tkNone,nil,__WideDelete,false,0).SetVarArgs([0]);
    DefineMethod('WideFree',1,tkNone,nil,__WideFree,false,0).SetVarArgs([0]);
    DefineMethod('WideFromAnsi',2,tkNone,nil,__WideFromAnsi,false,0).SetVarArgs([0]);
    DefineMethod('WideFromPChar',2,tkNone,nil,__WideFromPChar,false,0).SetVarArgs([0]);
    DefineMethod('WideInsert',3,tkNone,nil,__WideInsert,false,0).SetVarArgs([0]);
    DefineMethod('WideSetLength',2,tkNone,nil,__WideSetLength,false,0).SetVarArgs([0]);
    DefineMethod('WideAssign',2,tkNone,nil,__WideAssign,false,0).SetVarArgs([0,1]);
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

