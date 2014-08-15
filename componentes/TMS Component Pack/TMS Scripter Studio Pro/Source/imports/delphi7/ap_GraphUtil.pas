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
unit ap_GraphUtil;

interface

uses
  Windows,
  Graphics,
  GraphUtil,
  Variants,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatGraphUtilLibrary = class(TatScripterLibrary)
    procedure __GetHighLightColor(AMachine: TatVirtualMachine);
    procedure __GetShadowColor(AMachine: TatVirtualMachine);
    procedure __DrawCheck(AMachine: TatVirtualMachine);
    procedure __DrawChevron(AMachine: TatVirtualMachine);
    procedure __DrawArrow(AMachine: TatVirtualMachine);
    procedure __ColorRGBToHLS(AMachine: TatVirtualMachine);
    procedure __ColorHLSToRGB(AMachine: TatVirtualMachine);
    procedure __ColorAdjustLuma(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatGraphUtilLibrary.__GetHighLightColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := GraphUtil.GetHighLightColor(GetInputArg(0));
2: AResult := GraphUtil.GetHighLightColor(GetInputArg(0),VarToInteger(GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGraphUtilLibrary.__GetShadowColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := GraphUtil.GetShadowColor(GetInputArg(0));
2: AResult := GraphUtil.GetShadowColor(GetInputArg(0),VarToInteger(GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGraphUtilLibrary.__DrawCheck(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      3: GraphUtil.DrawCheck(TCanvas(Integer(GetInputArg(0))),TPointWrapper(integer(GetInputArg(1))).ObjToRec,VarToInteger(GetInputArg(2)));
      4: GraphUtil.DrawCheck(TCanvas(Integer(GetInputArg(0))),TPointWrapper(integer(GetInputArg(1))).ObjToRec,VarToInteger(GetInputArg(2)),GetInputArg(3));
    end;
  end;
end;

procedure TatGraphUtilLibrary.__DrawChevron(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GraphUtil.DrawChevron(TCanvas(Integer(GetInputArg(0))),GetInputArg(1),TPointWrapper(integer(GetInputArg(2))).ObjToRec,VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatGraphUtilLibrary.__DrawArrow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    GraphUtil.DrawArrow(TCanvas(Integer(GetInputArg(0))),GetInputArg(1),TPointWrapper(integer(GetInputArg(2))).ObjToRec,VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatGraphUtilLibrary.__ColorRGBToHLS(AMachine: TatVirtualMachine);
  var
  Param1: Word;
  Param2: Word;
  Param3: Word;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
    GraphUtil.ColorRGBToHLS(VarToInteger(GetInputArg(0)),Param1,Param2,Param3);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatGraphUtilLibrary.__ColorHLSToRGB(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(GraphUtil.ColorHLSToRGB(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGraphUtilLibrary.__ColorAdjustLuma(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := GraphUtil.ColorAdjustLuma(GetInputArg(0),VarToInteger(GetInputArg(1)),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGraphUtilLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('GetHighLightColor',2,tkEnumeration,nil,__GetHighLightColor,false,1);
    DefineMethod('GetShadowColor',2,tkEnumeration,nil,__GetShadowColor,false,1);
    DefineMethod('DrawCheck',4,tkNone,nil,__DrawCheck,false,1);
    DefineMethod('DrawChevron',4,tkNone,nil,__DrawChevron,false,0);
    DefineMethod('DrawArrow',4,tkNone,nil,__DrawArrow,false,0);
    DefineMethod('ColorRGBToHLS',4,tkNone,nil,__ColorRGBToHLS,false,0).SetVarArgs([1,2,3]);
    DefineMethod('ColorHLSToRGB',3,tkInteger,nil,__ColorHLSToRGB,false,0);
    DefineMethod('ColorAdjustLuma',3,tkEnumeration,nil,__ColorAdjustLuma,false,0);
    AddConstant('sdLeft',sdLeft);
    AddConstant('sdRight',sdRight);
    AddConstant('sdUp',sdUp);
    AddConstant('sdDown',sdDown);
    AddConstant('atSolid',atSolid);
    AddConstant('atArrows',atArrows);
  end;
end;

class function TatGraphUtilLibrary.LibraryName: string;
begin
  result := 'GraphUtil';
end;

initialization
  RegisterScripterLibrary(TatGraphUtilLibrary, True);

{$WARNINGS ON}

end.

