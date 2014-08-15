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
unit ap_ToolWin;

interface

uses
  Windows,
  Messages,
  Classes,
  Controls,
  Forms,
  ToolWin,
  atScript;

{$WARNINGS OFF}

type
  TatToolWinLibrary = class(TatScripterLibrary)
    procedure __TToolWindowCreate(AMachine: TatVirtualMachine);
    procedure __GetTToolWindowEdgeBorders(AMachine: TatVirtualMachine);
    procedure __SetTToolWindowEdgeBorders(AMachine: TatVirtualMachine);
    procedure __GetTToolWindowEdgeInner(AMachine: TatVirtualMachine);
    procedure __SetTToolWindowEdgeInner(AMachine: TatVirtualMachine);
    procedure __GetTToolWindowEdgeOuter(AMachine: TatVirtualMachine);
    procedure __SetTToolWindowEdgeOuter(AMachine: TatVirtualMachine);
    procedure __TToolDockObjectCreate(AMachine: TatVirtualMachine);
    procedure __TToolDockFormCreate(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TToolWindowClass = class of TToolWindow;
  TToolDockObjectClass = class of TToolDockObject;
  TToolDockFormClass = class of TToolDockForm;



implementation



procedure TatToolWinLibrary.__TToolWindowCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TToolWindowClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatToolWinLibrary.__GetTToolWindowEdgeBorders(AMachine: TatVirtualMachine);
var
PropValueSet: TEdgeBorders;
begin
  with AMachine do
  begin
    PropValueSet := TToolWindow(CurrentObject).EdgeBorders;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatToolWinLibrary.__SetTToolWindowEdgeBorders(AMachine: TatVirtualMachine);
  var
  TempVar: TEdgeBorders;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TToolWindow(CurrentObject).EdgeBorders:=TempVar;
  end;
end;

procedure TatToolWinLibrary.__GetTToolWindowEdgeInner(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TToolWindow(CurrentObject).EdgeInner);
  end;
end;

procedure TatToolWinLibrary.__SetTToolWindowEdgeInner(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TToolWindow(CurrentObject).EdgeInner:=GetInputArg(0);
  end;
end;

procedure TatToolWinLibrary.__GetTToolWindowEdgeOuter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TToolWindow(CurrentObject).EdgeOuter);
  end;
end;

procedure TatToolWinLibrary.__SetTToolWindowEdgeOuter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TToolWindow(CurrentObject).EdgeOuter:=GetInputArg(0);
  end;
end;

procedure TatToolWinLibrary.__TToolDockObjectCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TToolDockObjectClass(CurrentClass.ClassRef).Create(TControl(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatToolWinLibrary.__TToolDockFormCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TToolDockFormClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatToolWinLibrary.Init;
begin
  With Scripter.DefineClass(TToolWindow) do
  begin
    DefineMethod('Create',1,tkClass,TToolWindow,__TToolWindowCreate,true,0);
    DefineProp('EdgeBorders',tkInteger,__GetTToolWindowEdgeBorders,__SetTToolWindowEdgeBorders,nil,false,0);
    DefineProp('EdgeInner',tkEnumeration,__GetTToolWindowEdgeInner,__SetTToolWindowEdgeInner,nil,false,0);
    DefineProp('EdgeOuter',tkEnumeration,__GetTToolWindowEdgeOuter,__SetTToolWindowEdgeOuter,nil,false,0);
  end;
  With Scripter.DefineClass(TToolDockObject) do
  begin
    DefineMethod('Create',1,tkClass,TToolDockObject,__TToolDockObjectCreate,true,0);
  end;
  With Scripter.DefineClass(TToolDockForm) do
  begin
    DefineMethod('Create',1,tkClass,TToolDockForm,__TToolDockFormCreate,true,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('ebLeft',ebLeft);
    AddConstant('ebTop',ebTop);
    AddConstant('ebRight',ebRight);
    AddConstant('ebBottom',ebBottom);
    AddConstant('esNone',esNone);
    AddConstant('esRaised',esRaised);
    AddConstant('esLowered',esLowered);
    AddConstant('soNone',soNone);
    AddConstant('soHorizontal',soHorizontal);
    AddConstant('soVertical',soVertical);
  end;
end;

class function TatToolWinLibrary.LibraryName: string;
begin
  result := 'ToolWin';
end;

initialization
  RegisterScripterLibrary(TatToolWinLibrary, True);

{$WARNINGS ON}

end.

