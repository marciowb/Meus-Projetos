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
unit ap_ActnPopup;

interface

uses
  Classes,
  Controls,
  Menus,
  ActnMenus,
  XPActnCtrls,
  ActnMan,
  ActnList,
  ActnPopup,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatActnPopupLibrary = class(TatScripterLibrary)
    procedure __TCustomActionPopupMenuExLoadMenu(AMachine: TatVirtualMachine);
    procedure __TPopupActionBarCreate(AMachine: TatVirtualMachine);
    procedure __TPopupActionBarPopup(AMachine: TatVirtualMachine);
    procedure __GetTPopupActionBarMenuActive(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCustomActionPopupMenuExClass = class of TCustomActionPopupMenuEx;
  TPopupActionBarClass = class of TPopupActionBar;



implementation



procedure TatActnPopupLibrary.__TCustomActionPopupMenuExLoadMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionPopupMenuEx(CurrentObject).LoadMenu(TActionClients(Integer(GetInputArg(0))),TMenuItem(Integer(GetInputArg(1))));
  end;
end;

procedure TatActnPopupLibrary.__TPopupActionBarCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPopupActionBarClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnPopupLibrary.__TPopupActionBarPopup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPopupActionBar(CurrentObject).Popup(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatActnPopupLibrary.__GetTPopupActionBarMenuActive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TPopupActionBar(CurrentObject).MenuActive);
  end;
end;

procedure TatActnPopupLibrary.Init;
begin
  With Scripter.DefineClass(TCustomActionPopupMenuEx) do
  begin
    DefineMethod('LoadMenu',2,tkNone,nil,__TCustomActionPopupMenuExLoadMenu,false,0);
  end;
  With Scripter.DefineClass(TPopupActionBar) do
  begin
    DefineMethod('Create',1,tkClass,TPopupActionBar,__TPopupActionBarCreate,true,0);
    DefineMethod('Popup',2,tkNone,nil,__TPopupActionBarPopup,false,0);
    DefineProp('MenuActive',tkVariant,__GetTPopupActionBarMenuActive,nil,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatActnPopupLibrary.LibraryName: string;
begin
  result := 'ActnPopup';
end;

initialization
  RegisterScripterLibrary(TatActnPopupLibrary, True);

{$WARNINGS ON}

end.

