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
unit ap_ThemedActnCtrls;

interface

uses
  Windows,
  Messages,
  Classes,
  Controls,
  Graphics,
  Buttons,
  ToolWin,
  ActnMan,
  ActnMenus,
  ActnCtrls,
  ActnColorMaps,
  ShadowWnd,
  ThemedActnCtrls,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatThemedActnCtrlsLibrary = class(TatScripterLibrary)
    procedure __TThemedMenuItemCalcBounds(AMachine: TatVirtualMachine);
    procedure __TThemedMenuButtonCalcBounds(AMachine: TatVirtualMachine);
    procedure __TThemedPopupMenuCreate(AMachine: TatVirtualMachine);
    procedure __TThemedCustomizePopupCreate(AMachine: TatVirtualMachine);
    procedure __TThemedAddRemoveItemCalcBounds(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TThemedMenuItemClass = class of TThemedMenuItem;
  TThemedMenuButtonClass = class of TThemedMenuButton;
  TThemedPopupMenuClass = class of TThemedPopupMenu;
  TThemedExpandBtnClass = class of TThemedExpandBtn;
  TThemedButtonControlClass = class of TThemedButtonControl;
  TThemedDropDownButtonClass = class of TThemedDropDownButton;
  TThemedCustomizePopupClass = class of TThemedCustomizePopup;
  TThemedToolScrollBtnClass = class of TThemedToolScrollBtn;
  TThemedAddRemoveItemClass = class of TThemedAddRemoveItem;



implementation



procedure TatThemedActnCtrlsLibrary.__TThemedMenuItemCalcBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TThemedMenuItem(CurrentObject).CalcBounds;
  end;
end;

procedure TatThemedActnCtrlsLibrary.__TThemedMenuButtonCalcBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TThemedMenuButton(CurrentObject).CalcBounds;
  end;
end;

procedure TatThemedActnCtrlsLibrary.__TThemedPopupMenuCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TThemedPopupMenuClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatThemedActnCtrlsLibrary.__TThemedCustomizePopupCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TThemedCustomizePopupClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatThemedActnCtrlsLibrary.__TThemedAddRemoveItemCalcBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TThemedAddRemoveItem(CurrentObject).CalcBounds;
  end;
end;

procedure TatThemedActnCtrlsLibrary.Init;
begin
  With Scripter.DefineClass(TThemedMenuItem) do
  begin
    DefineMethod('CalcBounds',0,tkNone,nil,__TThemedMenuItemCalcBounds,false,0);
  end;
  With Scripter.DefineClass(TThemedMenuButton) do
  begin
    DefineMethod('CalcBounds',0,tkNone,nil,__TThemedMenuButtonCalcBounds,false,0);
  end;
  With Scripter.DefineClass(TThemedPopupMenu) do
  begin
    DefineMethod('Create',1,tkClass,TThemedPopupMenu,__TThemedPopupMenuCreate,true,0);
  end;
  With Scripter.DefineClass(TThemedExpandBtn) do
  begin
  end;
  With Scripter.DefineClass(TThemedButtonControl) do
  begin
  end;
  With Scripter.DefineClass(TThemedDropDownButton) do
  begin
  end;
  With Scripter.DefineClass(TThemedCustomizePopup) do
  begin
    DefineMethod('Create',1,tkClass,TThemedCustomizePopup,__TThemedCustomizePopupCreate,true,0);
  end;
  With Scripter.DefineClass(TThemedToolScrollBtn) do
  begin
  end;
  With Scripter.DefineClass(TThemedAddRemoveItem) do
  begin
    DefineMethod('CalcBounds',0,tkNone,nil,__TThemedAddRemoveItemCalcBounds,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatThemedActnCtrlsLibrary.LibraryName: string;
begin
  result := 'ThemedActnCtrls';
end;

initialization
  RegisterScripterLibrary(TatThemedActnCtrlsLibrary, True);

{$WARNINGS ON}

end.

