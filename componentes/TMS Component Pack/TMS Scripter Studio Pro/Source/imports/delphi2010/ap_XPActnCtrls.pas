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
unit ap_XPActnCtrls;

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
  XPActnCtrls,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatXPActnCtrlsLibrary = class(TatScripterLibrary)
    procedure __TXPStyleMenuItemCalcBounds(AMachine: TatVirtualMachine);
    procedure __TXPStylePopupMenuCreate(AMachine: TatVirtualMachine);
    procedure __TXPStylePopupMenuDestroy(AMachine: TatVirtualMachine);
    procedure __TXPStyleCustomizePopupCreate(AMachine: TatVirtualMachine);
    procedure __TXPStyleAddRemoveItemCalcBounds(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TXPStyleMenuItemClass = class of TXPStyleMenuItem;
  TXPStyleMenuButtonClass = class of TXPStyleMenuButton;
  TXPStylePopupMenuClass = class of TXPStylePopupMenu;
  TXPStyleExpandBtnClass = class of TXPStyleExpandBtn;
  TXPStyleButtonClass = class of TXPStyleButton;
  TXPStyleDropDownBtnClass = class of TXPStyleDropDownBtn;
  TXPStyleCustomizePopupClass = class of TXPStyleCustomizePopup;
  TXPStyleToolScrollBtnClass = class of TXPStyleToolScrollBtn;
  TXPStyleAddRemoveItemClass = class of TXPStyleAddRemoveItem;



implementation



procedure TatXPActnCtrlsLibrary.__TXPStyleMenuItemCalcBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TXPStyleMenuItem(CurrentObject).CalcBounds;
  end;
end;

procedure TatXPActnCtrlsLibrary.__TXPStylePopupMenuCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TXPStylePopupMenuClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatXPActnCtrlsLibrary.__TXPStylePopupMenuDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TXPStylePopupMenu(CurrentObject).Destroy;
  end;
end;

procedure TatXPActnCtrlsLibrary.__TXPStyleCustomizePopupCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TXPStyleCustomizePopupClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatXPActnCtrlsLibrary.__TXPStyleAddRemoveItemCalcBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TXPStyleAddRemoveItem(CurrentObject).CalcBounds;
  end;
end;

procedure TatXPActnCtrlsLibrary.Init;
begin
  With Scripter.DefineClass(TXPStyleMenuItem) do
  begin
    DefineMethod('CalcBounds',0,tkNone,nil,__TXPStyleMenuItemCalcBounds,false,0);
  end;
  With Scripter.DefineClass(TXPStyleMenuButton) do
  begin
  end;
  With Scripter.DefineClass(TXPStylePopupMenu) do
  begin
    DefineMethod('Create',1,tkClass,TXPStylePopupMenu,__TXPStylePopupMenuCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TXPStylePopupMenuDestroy,false,0);
  end;
  With Scripter.DefineClass(TXPStyleExpandBtn) do
  begin
  end;
  With Scripter.DefineClass(TXPStyleButton) do
  begin
  end;
  With Scripter.DefineClass(TXPStyleDropDownBtn) do
  begin
  end;
  With Scripter.DefineClass(TXPStyleCustomizePopup) do
  begin
    DefineMethod('Create',1,tkClass,TXPStyleCustomizePopup,__TXPStyleCustomizePopupCreate,true,0);
  end;
  With Scripter.DefineClass(TXPStyleToolScrollBtn) do
  begin
  end;
  With Scripter.DefineClass(TXPStyleAddRemoveItem) do
  begin
    DefineMethod('CalcBounds',0,tkNone,nil,__TXPStyleAddRemoveItemCalcBounds,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatXPActnCtrlsLibrary.LibraryName: string;
begin
  result := 'XPActnCtrls';
end;

initialization
  RegisterScripterLibrary(TatXPActnCtrlsLibrary, True);

{$WARNINGS ON}

end.

