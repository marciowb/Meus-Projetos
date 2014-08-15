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
unit ap_ABAccessibility;

interface

uses
  Windows,
  Classes,
  ActiveX,
  oleacc,
  ActnMan,
  ActnMenus,
  Controls,
  ABAccessibility,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatABAccessibilityLibrary = class(TatScripterLibrary)
    procedure __TActionBarAccessibilityCreate(AMachine: TatVirtualMachine);
    procedure __TActionMenuBarAccessibilityGet_accState(AMachine: TatVirtualMachine);
    procedure __TActionMenuBarAccessibilityGet_accRole(AMachine: TatVirtualMachine);
    procedure __TActionMenuBarAccessibilityGet_accDescription(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TActionBarAccessibilityClass = class of TActionBarAccessibility;
  TActionMenuBarAccessibilityClass = class of TActionMenuBarAccessibility;



implementation



procedure TatABAccessibilityLibrary.__TActionBarAccessibilityCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TActionBarAccessibilityClass(CurrentClass.ClassRef).Create(TActionClient(Integer(GetInputArg(0))),TActionClient(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatABAccessibilityLibrary.__TActionMenuBarAccessibilityGet_accState(AMachine: TatVirtualMachine);
  var
  Param0: OleVariant;
  Param1: OleVariant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
AResult := Integer(TActionMenuBarAccessibility(CurrentObject).Get_accState(Param0,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatABAccessibilityLibrary.__TActionMenuBarAccessibilityGet_accRole(AMachine: TatVirtualMachine);
  var
  Param0: OleVariant;
  Param1: OleVariant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
AResult := Integer(TActionMenuBarAccessibility(CurrentObject).Get_accRole(Param0,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatABAccessibilityLibrary.__TActionMenuBarAccessibilityGet_accDescription(AMachine: TatVirtualMachine);
  var
  Param0: OleVariant;
  Param1: WideString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
AResult := Integer(TActionMenuBarAccessibility(CurrentObject).Get_accDescription(Param0,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatABAccessibilityLibrary.Init;
begin
  With Scripter.DefineClass(TActionBarAccessibility) do
  begin
    DefineMethod('Create',2,tkClass,TActionBarAccessibility,__TActionBarAccessibilityCreate,true,0);
  end;
  With Scripter.DefineClass(TActionMenuBarAccessibility) do
  begin
    DefineMethod('Get_accState',2,tkInteger,nil,__TActionMenuBarAccessibilityGet_accState,false,0).SetVarArgs([0,1]);
    DefineMethod('Get_accRole',2,tkInteger,nil,__TActionMenuBarAccessibilityGet_accRole,false,0).SetVarArgs([0,1]);
    DefineMethod('Get_accDescription',2,tkInteger,nil,__TActionMenuBarAccessibilityGet_accDescription,false,0).SetVarArgs([0,1]);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatABAccessibilityLibrary.LibraryName: string;
begin
  result := 'ABAccessibility';
end;

initialization
  RegisterScripterLibrary(TatABAccessibilityLibrary, True);

{$WARNINGS ON}

end.

