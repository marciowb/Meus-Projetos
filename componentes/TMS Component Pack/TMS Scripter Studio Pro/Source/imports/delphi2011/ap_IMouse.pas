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
unit ap_IMouse;

interface

uses
  Controls,
  ExtCtrls,
  Graphics,
  Classes,
  Messages,
  Forms,
  Windows,
  IMouse,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatIMouseLibrary = class(TatScripterLibrary)
    procedure __TPanningWindowCreate(AMachine: TatVirtualMachine);
    procedure __TPanningWindowDestroy(AMachine: TatVirtualMachine);
    procedure __TPanningWindowGetIsPanning(AMachine: TatVirtualMachine);
    procedure __TPanningWindowStartPanning(AMachine: TatVirtualMachine);
    procedure __TPanningWindowStopPanning(AMachine: TatVirtualMachine);
    procedure __GetTPanningWindowIsPanning(AMachine: TatVirtualMachine);
    procedure __GetTPanningWindowPanControl(AMachine: TatVirtualMachine);
    procedure __GetTPanningWindowPanInterval(AMachine: TatVirtualMachine);
    procedure __SetTPanningWindowPanInterval(AMachine: TatVirtualMachine);
    procedure __GetTPanningWindowPanOptions(AMachine: TatVirtualMachine);
    procedure __StartPan(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TPanningWindowClass = class of TPanningWindow;



implementation



procedure TatIMouseLibrary.__TPanningWindowCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPanningWindowClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIMouseLibrary.__TPanningWindowDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPanningWindow(CurrentObject).Destroy;
  end;
end;

procedure TatIMouseLibrary.__TPanningWindowGetIsPanning(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TPanningWindow(CurrentObject).GetIsPanning;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIMouseLibrary.__TPanningWindowStartPanning(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TPanningWindow(CurrentObject).StartPanning(GetInputArg(0),TControl(Integer(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIMouseLibrary.__TPanningWindowStopPanning(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPanningWindow(CurrentObject).StopPanning;
  end;
end;

procedure TatIMouseLibrary.__GetTPanningWindowIsPanning(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TPanningWindow(CurrentObject).IsPanning);
  end;
end;

procedure TatIMouseLibrary.__GetTPanningWindowPanControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPanningWindow(CurrentObject).PanControl));
  end;
end;

procedure TatIMouseLibrary.__GetTPanningWindowPanInterval(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPanningWindow(CurrentObject).PanInterval));
  end;
end;

procedure TatIMouseLibrary.__SetTPanningWindowPanInterval(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPanningWindow(CurrentObject).PanInterval:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatIMouseLibrary.__GetTPanningWindowPanOptions(AMachine: TatVirtualMachine);
var
PropValueSet: TPanOptions;
begin
  with AMachine do
  begin
    PropValueSet := TPanningWindow(CurrentObject).PanOptions;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatIMouseLibrary.__StartPan(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := IMouse.StartPan(GetInputArg(0),TControl(Integer(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIMouseLibrary.Init;
begin
  With Scripter.DefineClass(TPanningWindow) do
  begin
    DefineMethod('Create',1,tkClass,TPanningWindow,__TPanningWindowCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TPanningWindowDestroy,false,0);
    DefineMethod('GetIsPanning',0,tkVariant,nil,__TPanningWindowGetIsPanning,false,0);
    DefineMethod('StartPanning',2,tkVariant,nil,__TPanningWindowStartPanning,false,0);
    DefineMethod('StopPanning',0,tkNone,nil,__TPanningWindowStopPanning,false,0);
    DefineProp('IsPanning',tkVariant,__GetTPanningWindowIsPanning,nil,nil,false,0);
    DefineProp('PanControl',tkClass,__GetTPanningWindowPanControl,nil,TControl,false,0);
    DefineProp('PanInterval',tkInteger,__GetTPanningWindowPanInterval,__SetTPanningWindowPanInterval,nil,false,0);
    DefineProp('PanOptions',tkInteger,__GetTPanningWindowPanOptions,nil,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('StartPan',2,tkVariant,nil,__StartPan,false,0);
    AddConstant('pdUp',pdUp);
    AddConstant('pdDown',pdDown);
    AddConstant('pdLeft',pdLeft);
    AddConstant('pdRight',pdRight);
    AddConstant('poVertical',poVertical);
    AddConstant('poHorizontal',poHorizontal);
    AddConstant('crPanAll',crPanAll);
    AddConstant('crPanDown',crPanDown);
    AddConstant('crPanDownLeft',crPanDownLeft);
    AddConstant('crPanDownRight',crPanDownRight);
    AddConstant('crPanLeft',crPanLeft);
    AddConstant('crPanLeftRight',crPanLeftRight);
    AddConstant('crPanRight',crPanRight);
    AddConstant('crPanUp',crPanUp);
    AddConstant('crPanUpDown',crPanUpDown);
    AddConstant('crPanUpLeft',crPanUpLeft);
    AddConstant('crPanUpRight',crPanUpRight);
  end;
end;

class function TatIMouseLibrary.LibraryName: string;
begin
  result := 'IMouse';
end;

initialization
  RegisterScripterLibrary(TatIMouseLibrary, True);

{$WARNINGS ON}

end.

