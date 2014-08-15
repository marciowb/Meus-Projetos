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
unit ap_ShadowWnd;

interface

uses
  Windows,
  Messages,
  Classes,
  Controls,
  Forms,
  Graphics,
  ShadowWnd,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatShadowWndLibrary = class(TatScripterLibrary)
    procedure __TShadowWindowCreate(AMachine: TatVirtualMachine);
    procedure __TShadowWindowCreateShadow(AMachine: TatVirtualMachine);
    procedure __TShadowWindowDestroy(AMachine: TatVirtualMachine);
    procedure __TShadowWindowSetBounds(AMachine: TatVirtualMachine);
    procedure __GetTShadowWindowControl(AMachine: TatVirtualMachine);
    procedure __SetTShadowWindowControl(AMachine: TatVirtualMachine);
    procedure __GetTShadowWindowSide(AMachine: TatVirtualMachine);
    procedure __SetTShadowWindowSide(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TShadowWindowClass = class of TShadowWindow;



implementation



procedure TatShadowWndLibrary.__TShadowWindowCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TShadowWindowClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShadowWndLibrary.__TShadowWindowCreateShadow(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TShadowWindowClass(CurrentClass.ClassRef).CreateShadow(TComponent(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShadowWndLibrary.__TShadowWindowDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TShadowWindow(CurrentObject).Destroy;
  end;
end;

procedure TatShadowWndLibrary.__TShadowWindowSetBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TShadowWindow(CurrentObject).SetBounds(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatShadowWndLibrary.__GetTShadowWindowControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TShadowWindow(CurrentObject).Control));
  end;
end;

procedure TatShadowWndLibrary.__SetTShadowWindowControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TShadowWindow(CurrentObject).Control:=TControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatShadowWndLibrary.__GetTShadowWindowSide(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TShadowWindow(CurrentObject).Side);
  end;
end;

procedure TatShadowWndLibrary.__SetTShadowWindowSide(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TShadowWindow(CurrentObject).Side:=GetInputArg(0);
  end;
end;

procedure TatShadowWndLibrary.Init;
begin
  With Scripter.DefineClass(TShadowWindow) do
  begin
    DefineMethod('Create',1,tkClass,TShadowWindow,__TShadowWindowCreate,true,0);
    DefineMethod('CreateShadow',2,tkClass,TShadowWindow,__TShadowWindowCreateShadow,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TShadowWindowDestroy,false,0);
    DefineMethod('SetBounds',4,tkNone,nil,__TShadowWindowSetBounds,false,0);
    DefineProp('Control',tkClass,__GetTShadowWindowControl,__SetTShadowWindowControl,TControl,false,0);
    DefineProp('Side',tkEnumeration,__GetTShadowWindowSide,__SetTShadowWindowSide,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('csRight',csRight);
    AddConstant('csBottom',csBottom);
  end;
end;

class function TatShadowWndLibrary.LibraryName: string;
begin
  result := 'ShadowWnd';
end;

initialization
  RegisterScripterLibrary(TatShadowWndLibrary, True);

{$WARNINGS ON}

end.

