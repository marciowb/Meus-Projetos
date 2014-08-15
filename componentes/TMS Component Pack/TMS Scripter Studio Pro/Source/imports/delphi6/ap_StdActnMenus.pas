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
  ActnMenus,
  StdActnMenus,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatStdActnMenusLibrary = class(TatScripterLibrary)
    procedure __TStandardMenuPopupCreate(AMachine: TatVirtualMachine);
    procedure __TStandardCustomizePopupCreate(AMachine: TatVirtualMachine);
    procedure __RegisterStandardMenus(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TStandardMenuItemClass = class of TStandardMenuItem;
  TStandardMenuButtonClass = class of TStandardMenuButton;
  TStandardMenuPopupClass = class of TStandardMenuPopup;
  TStandardAddRemoveItemClass = class of TStandardAddRemoveItem;
  TStandardCustomizePopupClass = class of TStandardCustomizePopup;



implementation



procedure TatStdActnMenusLibrary.__TStandardMenuPopupCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TStandardMenuPopupClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdActnMenusLibrary.__TStandardCustomizePopupCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TStandardCustomizePopupClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

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
  With Scripter.DefineClass(TStandardMenuPopup) do
  begin
    DefineMethod('Create',1,tkClass,TStandardMenuPopup,__TStandardMenuPopupCreate,true,0);
  end;
  With Scripter.DefineClass(TStandardAddRemoveItem) do
  begin
  end;
  With Scripter.DefineClass(TStandardCustomizePopup) do
  begin
    DefineMethod('Create',1,tkClass,TStandardCustomizePopup,__TStandardCustomizePopupCreate,true,0);
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

