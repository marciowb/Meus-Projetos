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
unit ap_StdActnMenus;

interface

uses
  Windows,
  Messages,
  Classes,
  Controls,
  Graphics,
  Buttons,
  ToolWin,
  ActnMenus,
  ActnMan,
  ActnCtrls,
  StdActnMenus,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatStdActnMenusLibrary = class(TatScripterLibrary)
    procedure __RegisterStandardMenus(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TStandardMenuItemClass = class of TStandardMenuItem;
  TStandardMenuButtonClass = class of TStandardMenuButton;
  TStandardToolScrollBtnClass = class of TStandardToolScrollBtn;
  TStandardMenuExpandBtnClass = class of TStandardMenuExpandBtn;
  TStandardMenuPopupClass = class of TStandardMenuPopup;
  TStandardAddRemoveItemClass = class of TStandardAddRemoveItem;
  TStandardCustomizePopupClass = class of TStandardCustomizePopup;
  TStandardButtonControlClass = class of TStandardButtonControl;
  TStandardDropDownButtonClass = class of TStandardDropDownButton;



implementation



procedure TatStdActnMenusLibrary.__RegisterStandardMenus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    StdActnMenus.RegisterStandardMenus;
  end;
end;

procedure TatStdActnMenusLibrary.Init;
begin
  With Scripter.DefineClass(TStandardMenuItem) do
  begin
  end;
  With Scripter.DefineClass(TStandardMenuButton) do
  begin
  end;
  With Scripter.DefineClass(TStandardToolScrollBtn) do
  begin
  end;
  With Scripter.DefineClass(TStandardMenuExpandBtn) do
  begin
  end;
  With Scripter.DefineClass(TStandardMenuPopup) do
  begin
  end;
  With Scripter.DefineClass(TStandardAddRemoveItem) do
  begin
  end;
  With Scripter.DefineClass(TStandardCustomizePopup) do
  begin
  end;
  With Scripter.DefineClass(TStandardButtonControl) do
  begin
  end;
  With Scripter.DefineClass(TStandardDropDownButton) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('RegisterStandardMenus',0,tkNone,nil,__RegisterStandardMenus,false,0);
  end;
end;

class function TatStdActnMenusLibrary.LibraryName: string;
begin
  result := 'StdActnMenus';
end;

initialization
  RegisterScripterLibrary(TatStdActnMenusLibrary, True);

{$WARNINGS ON}

end.

