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
unit ap_CustomizeDlg;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ActnList,
  CheckLst,
  ComCtrls,
  Menus,
  ExtCtrls,
  ImgList,
  ActnMan,
  ActnCtrls,
  ActnMenus,
  Buttons,
  CustomizeDlg,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatCustomizeDlgLibrary = class(TatScripterLibrary)
    procedure __TCustomizeFrmCatListClick(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmActionsListStartDrag(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmActionsListDrawItem(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmFormClose(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmCloseBtnClick(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmCatListStartDrag(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmActionBarListClickCheck(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmActionsListMeasureItem(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmFormCreate(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmActionsListClick(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmMenuAnimationStylesChange(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmResetActnUpdate(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmResetActnExecute(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmResetUsageDataActnExecute(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmRecentlyUsedActnExecute(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmShowHintsActnExecute(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmShowHintsActnUpdate(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmShowShortCutsInTipsActnExecute(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmRecentlyUsedActnUpdate(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmActionBarListClick(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmActionsListData(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmLargeIconsActnExecute(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmListComboSelect(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmCaptionOptionsComboChange(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmFormResize(AMachine: TatVirtualMachine);
    procedure __TCustomizeFrmLargeIconsActnUpdate(AMachine: TatVirtualMachine);
    procedure __GetTCustomizeFrmActionManager(AMachine: TatVirtualMachine);
    procedure __SetTCustomizeFrmActionManager(AMachine: TatVirtualMachine);
    procedure __GetTCustomizeFrmActiveActionList(AMachine: TatVirtualMachine);
    procedure __SetTCustomizeFrmActiveActionList(AMachine: TatVirtualMachine);
    procedure __TCustomizeDlgShow(AMachine: TatVirtualMachine);
    procedure __GetTCustomizeDlgCustomizeForm(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCustomizeFrmClass = class of TCustomizeFrm;
  TCustomizeDlgClass = class of TCustomizeDlg;



implementation



procedure TatCustomizeDlgLibrary.__TCustomizeFrmCatListClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).CatListClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmActionsListStartDrag(AMachine: TatVirtualMachine);
  var
  Param1: TDragObject;
begin
  with AMachine do
  begin
Param1 := TDragObject(Integer(GetInputArg(1)));
    TCustomizeFrm(CurrentObject).ActionsListStartDrag(TObject(Integer(GetInputArg(0))),Param1);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmActionsListDrawItem(AMachine: TatVirtualMachine);
  var
  Param3: TOwnerDrawState;
begin
  with AMachine do
  begin
IntToSet(Param3, VarToInteger(GetInputArg(3)), SizeOf(Param3));
    TCustomizeFrm(CurrentObject).ActionsListDrawItem(TWinControl(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),TRectWrapper(integer(GetInputArg(2))).ObjToRec,Param3);
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmFormClose(AMachine: TatVirtualMachine);
  var
  Param1: TCloseAction;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    TCustomizeFrm(CurrentObject).FormClose(TObject(Integer(GetInputArg(0))),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmCloseBtnClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).CloseBtnClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmCatListStartDrag(AMachine: TatVirtualMachine);
  var
  Param1: TDragObject;
begin
  with AMachine do
  begin
Param1 := TDragObject(Integer(GetInputArg(1)));
    TCustomizeFrm(CurrentObject).CatListStartDrag(TObject(Integer(GetInputArg(0))),Param1);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmActionBarListClickCheck(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).ActionBarListClickCheck(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmActionsListMeasureItem(AMachine: TatVirtualMachine);
  var
  Param2: Integer;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
    TCustomizeFrm(CurrentObject).ActionsListMeasureItem(TWinControl(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),Param2);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmFormCreate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).FormCreate(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmActionsListClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).ActionsListClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmMenuAnimationStylesChange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).MenuAnimationStylesChange(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmResetActnUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).ResetActnUpdate(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmResetActnExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).ResetActnExecute(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmResetUsageDataActnExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).ResetUsageDataActnExecute(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmRecentlyUsedActnExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).RecentlyUsedActnExecute(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmShowHintsActnExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).ShowHintsActnExecute(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmShowHintsActnUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).ShowHintsActnUpdate(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmShowShortCutsInTipsActnExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).ShowShortCutsInTipsActnExecute(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmRecentlyUsedActnUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).RecentlyUsedActnUpdate(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmActionBarListClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).ActionBarListClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmActionsListData(AMachine: TatVirtualMachine);
  var
  Param2: string;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
    TCustomizeFrm(CurrentObject).ActionsListData(TWinControl(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),Param2);
    SetInputArg(2,Param2);
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmLargeIconsActnExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).LargeIconsActnExecute(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmListComboSelect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).ListComboSelect(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmCaptionOptionsComboChange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).CaptionOptionsComboChange(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmFormResize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).FormResize(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeFrmLargeIconsActnUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).LargeIconsActnUpdate(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCustomizeDlgLibrary.__GetTCustomizeFrmActionManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomizeFrm(CurrentObject).ActionManager));
  end;
end;

procedure TatCustomizeDlgLibrary.__SetTCustomizeFrmActionManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).ActionManager:=TCustomActionManager(Integer(GetInputArg(0)));
  end;
end;

procedure TatCustomizeDlgLibrary.__GetTCustomizeFrmActiveActionList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomizeFrm(CurrentObject).ActiveActionList));
  end;
end;

procedure TatCustomizeDlgLibrary.__SetTCustomizeFrmActiveActionList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeFrm(CurrentObject).ActiveActionList:=TCustomActionList(Integer(GetInputArg(0)));
  end;
end;

procedure TatCustomizeDlgLibrary.__TCustomizeDlgShow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeDlg(CurrentObject).Show;
  end;
end;

procedure TatCustomizeDlgLibrary.__GetTCustomizeDlgCustomizeForm(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomizeDlg(CurrentObject).CustomizeForm));
  end;
end;

procedure TatCustomizeDlgLibrary.Init;
begin
  With Scripter.DefineClass(TCustomizeFrm) do
  begin
    DefineMethod('CatListClick',1,tkNone,nil,__TCustomizeFrmCatListClick,false,0);
    DefineMethod('ActionsListStartDrag',2,tkNone,nil,__TCustomizeFrmActionsListStartDrag,false,0).SetVarArgs([1]);
    DefineMethod('ActionsListDrawItem',4,tkNone,nil,__TCustomizeFrmActionsListDrawItem,false,0);
    DefineMethod('FormClose',2,tkNone,nil,__TCustomizeFrmFormClose,false,0).SetVarArgs([1]);
    DefineMethod('CloseBtnClick',1,tkNone,nil,__TCustomizeFrmCloseBtnClick,false,0);
    DefineMethod('CatListStartDrag',2,tkNone,nil,__TCustomizeFrmCatListStartDrag,false,0).SetVarArgs([1]);
    DefineMethod('ActionBarListClickCheck',1,tkNone,nil,__TCustomizeFrmActionBarListClickCheck,false,0);
    DefineMethod('ActionsListMeasureItem',3,tkNone,nil,__TCustomizeFrmActionsListMeasureItem,false,0).SetVarArgs([2]);
    DefineMethod('FormCreate',1,tkNone,nil,__TCustomizeFrmFormCreate,false,0);
    DefineMethod('ActionsListClick',1,tkNone,nil,__TCustomizeFrmActionsListClick,false,0);
    DefineMethod('MenuAnimationStylesChange',1,tkNone,nil,__TCustomizeFrmMenuAnimationStylesChange,false,0);
    DefineMethod('ResetActnUpdate',1,tkNone,nil,__TCustomizeFrmResetActnUpdate,false,0);
    DefineMethod('ResetActnExecute',1,tkNone,nil,__TCustomizeFrmResetActnExecute,false,0);
    DefineMethod('ResetUsageDataActnExecute',1,tkNone,nil,__TCustomizeFrmResetUsageDataActnExecute,false,0);
    DefineMethod('RecentlyUsedActnExecute',1,tkNone,nil,__TCustomizeFrmRecentlyUsedActnExecute,false,0);
    DefineMethod('ShowHintsActnExecute',1,tkNone,nil,__TCustomizeFrmShowHintsActnExecute,false,0);
    DefineMethod('ShowHintsActnUpdate',1,tkNone,nil,__TCustomizeFrmShowHintsActnUpdate,false,0);
    DefineMethod('ShowShortCutsInTipsActnExecute',1,tkNone,nil,__TCustomizeFrmShowShortCutsInTipsActnExecute,false,0);
    DefineMethod('RecentlyUsedActnUpdate',1,tkNone,nil,__TCustomizeFrmRecentlyUsedActnUpdate,false,0);
    DefineMethod('ActionBarListClick',1,tkNone,nil,__TCustomizeFrmActionBarListClick,false,0);
    DefineMethod('ActionsListData',3,tkNone,nil,__TCustomizeFrmActionsListData,false,0).SetVarArgs([2]);
    DefineMethod('LargeIconsActnExecute',1,tkNone,nil,__TCustomizeFrmLargeIconsActnExecute,false,0);
    DefineMethod('ListComboSelect',1,tkNone,nil,__TCustomizeFrmListComboSelect,false,0);
    DefineMethod('CaptionOptionsComboChange',1,tkNone,nil,__TCustomizeFrmCaptionOptionsComboChange,false,0);
    DefineMethod('FormResize',1,tkNone,nil,__TCustomizeFrmFormResize,false,0);
    DefineMethod('LargeIconsActnUpdate',1,tkNone,nil,__TCustomizeFrmLargeIconsActnUpdate,false,0);
    DefineProp('ActionManager',tkClass,__GetTCustomizeFrmActionManager,__SetTCustomizeFrmActionManager,TCustomActionManager,false,0);
    DefineProp('ActiveActionList',tkClass,__GetTCustomizeFrmActiveActionList,__SetTCustomizeFrmActiveActionList,TCustomActionList,false,0);
  end;
  With Scripter.DefineClass(TCustomizeDlg) do
  begin
    DefineMethod('Show',0,tkNone,nil,__TCustomizeDlgShow,false,0);
    DefineProp('CustomizeForm',tkClass,__GetTCustomizeDlgCustomizeForm,nil,TCustomizeFrm,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatCustomizeDlgLibrary.LibraryName: string;
begin
  result := 'CustomizeDlg';
end;

initialization
  RegisterScripterLibrary(TatCustomizeDlgLibrary, True);

{$WARNINGS ON}

end.

