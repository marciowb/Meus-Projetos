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
unit ap_ActnCtrls;

interface

uses
  Windows,
  Messages,
  Classes,
  Controls,
  Graphics,
  ToolWin,
  ActnMan,
  Buttons,
  StdCtrls,
  ComCtrls,
  Contnrs,
  GraphUtil,
  ExtCtrls,
  ActnCtrls,
  Variants,
  ap_Messages,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatActnCtrlsLibrary = class(TatScripterLibrary)
    procedure __TCustomButtonControlCreate(AMachine: TatVirtualMachine);
    procedure __TCustomButtonControlCalcBounds(AMachine: TatVirtualMachine);
    procedure __TCustomButtonControlClick(AMachine: TatVirtualMachine);
    procedure __TCustomButtonControlSetBounds(AMachine: TatVirtualMachine);
    procedure __GetTCustomButtonControlAllowAllUp(AMachine: TatVirtualMachine);
    procedure __SetTCustomButtonControlAllowAllUp(AMachine: TatVirtualMachine);
    procedure __GetTCustomButtonControlDown(AMachine: TatVirtualMachine);
    procedure __SetTCustomButtonControlDown(AMachine: TatVirtualMachine);
    procedure __GetTCustomButtonControlFlat(AMachine: TatVirtualMachine);
    procedure __SetTCustomButtonControlFlat(AMachine: TatVirtualMachine);
    procedure __GetTCustomButtonControlState(AMachine: TatVirtualMachine);
    procedure __SetTCustomButtonControlState(AMachine: TatVirtualMachine);
    procedure __GetTCustomButtonControlTrackButton(AMachine: TatVirtualMachine);
    procedure __SetTCustomButtonControlTrackButton(AMachine: TatVirtualMachine);
    procedure __TCustomUtilityButtonCreate(AMachine: TatVirtualMachine);
    procedure __TCustomUtilityButtonDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomUtilityButtonClick(AMachine: TatVirtualMachine);
    procedure __GetTCustomUtilityButtonAutoScroll(AMachine: TatVirtualMachine);
    procedure __SetTCustomUtilityButtonAutoScroll(AMachine: TatVirtualMachine);
    procedure __GetTCustomUtilityButtonArrowSize(AMachine: TatVirtualMachine);
    procedure __SetTCustomUtilityButtonArrowSize(AMachine: TatVirtualMachine);
    procedure __GetTCustomUtilityButtonArrowType(AMachine: TatVirtualMachine);
    procedure __SetTCustomUtilityButtonArrowType(AMachine: TatVirtualMachine);
    procedure __GetTCustomUtilityButtonDirection(AMachine: TatVirtualMachine);
    procedure __SetTCustomUtilityButtonDirection(AMachine: TatVirtualMachine);
    procedure __GetTCustomUtilityButtonRepeatRate(AMachine: TatVirtualMachine);
    procedure __SetTCustomUtilityButtonRepeatRate(AMachine: TatVirtualMachine);
    procedure __TCustomToolScrollBtnCreate(AMachine: TatVirtualMachine);
    procedure __TCustomToolScrollBtnCalcBounds(AMachine: TatVirtualMachine);
    procedure __TCustomDropDownButtonCalcBounds(AMachine: TatVirtualMachine);
    procedure __TCustomDropDownButtonClick(AMachine: TatVirtualMachine);
    procedure __TCustomDropDownButtonDropDownClick(AMachine: TatVirtualMachine);
    procedure __TCustomActionComboDesignWndProc(AMachine: TatVirtualMachine);
    procedure __TCustomActionComboDragDrop(AMachine: TatVirtualMachine);
    procedure __TCustomComboControlCreate(AMachine: TatVirtualMachine);
    procedure __TCustomComboControlDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomComboControlCalcBounds(AMachine: TatVirtualMachine);
    procedure __TCustomComboControlClick(AMachine: TatVirtualMachine);
    procedure __TCustomComboControlSetBounds(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboControlComboBox(AMachine: TatVirtualMachine);
    procedure __TCustomActionDockBarCreate(AMachine: TatVirtualMachine);
    procedure __TCustomActionDockBarCalcDockedWidth(AMachine: TatVirtualMachine);
    procedure __TCustomActionDockBarDock(AMachine: TatVirtualMachine);
    procedure __TCustomActionToolBarCreate(AMachine: TatVirtualMachine);
    procedure __TCustomActionToolBarDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomActionToolBarCalcDockedWidth(AMachine: TatVirtualMachine);
    procedure __TCustomActionToolBarCreateControl(AMachine: TatVirtualMachine);
    procedure __TCustomActionToolBarDoDropCategory(AMachine: TatVirtualMachine);
    procedure __TCustomActionToolBarDragDrop(AMachine: TatVirtualMachine);
    procedure __TCustomActionToolBarSetBounds(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionToolBarHiddenCount(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TMenuResizeActionControlClass = class of TMenuResizeActionControl;
  TCustomButtonControlClass = class of TCustomButtonControl;
  TCustomUtilityButtonClass = class of TCustomUtilityButton;
  TCustomToolScrollBtnClass = class of TCustomToolScrollBtn;
  TCustomDropDownButtonClass = class of TCustomDropDownButton;
  TCustomActionComboClass = class of TCustomActionCombo;
  TCustomComboControlClass = class of TCustomComboControl;
  TCustomActionDockBarClass = class of TCustomActionDockBar;
  TCustomActionToolBarClass = class of TCustomActionToolBar;
  TActionToolBarClass = class of TActionToolBar;



implementation



procedure TatActnCtrlsLibrary.__TCustomButtonControlCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomButtonControlClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomButtonControlCalcBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomButtonControl(CurrentObject).CalcBounds;
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomButtonControlClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomButtonControl(CurrentObject).Click;
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomButtonControlSetBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomButtonControl(CurrentObject).SetBounds(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatActnCtrlsLibrary.__GetTCustomButtonControlAllowAllUp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomButtonControl(CurrentObject).AllowAllUp);
  end;
end;

procedure TatActnCtrlsLibrary.__SetTCustomButtonControlAllowAllUp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomButtonControl(CurrentObject).AllowAllUp:=GetInputArg(0);
  end;
end;

procedure TatActnCtrlsLibrary.__GetTCustomButtonControlDown(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomButtonControl(CurrentObject).Down);
  end;
end;

procedure TatActnCtrlsLibrary.__SetTCustomButtonControlDown(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomButtonControl(CurrentObject).Down:=GetInputArg(0);
  end;
end;

procedure TatActnCtrlsLibrary.__GetTCustomButtonControlFlat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomButtonControl(CurrentObject).Flat);
  end;
end;

procedure TatActnCtrlsLibrary.__SetTCustomButtonControlFlat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomButtonControl(CurrentObject).Flat:=GetInputArg(0);
  end;
end;

procedure TatActnCtrlsLibrary.__GetTCustomButtonControlState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomButtonControl(CurrentObject).State);
  end;
end;

procedure TatActnCtrlsLibrary.__SetTCustomButtonControlState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomButtonControl(CurrentObject).State:=GetInputArg(0);
  end;
end;

procedure TatActnCtrlsLibrary.__GetTCustomButtonControlTrackButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomButtonControl(CurrentObject).TrackButton);
  end;
end;

procedure TatActnCtrlsLibrary.__SetTCustomButtonControlTrackButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomButtonControl(CurrentObject).TrackButton:=GetInputArg(0);
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomUtilityButtonCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomUtilityButtonClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomUtilityButtonDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomUtilityButton(CurrentObject).Destroy;
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomUtilityButtonClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomUtilityButton(CurrentObject).Click;
  end;
end;

procedure TatActnCtrlsLibrary.__GetTCustomUtilityButtonAutoScroll(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomUtilityButton(CurrentObject).AutoScroll);
  end;
end;

procedure TatActnCtrlsLibrary.__SetTCustomUtilityButtonAutoScroll(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomUtilityButton(CurrentObject).AutoScroll:=GetInputArg(0);
  end;
end;

procedure TatActnCtrlsLibrary.__GetTCustomUtilityButtonArrowSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomUtilityButton(CurrentObject).ArrowSize));
  end;
end;

procedure TatActnCtrlsLibrary.__SetTCustomUtilityButtonArrowSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomUtilityButton(CurrentObject).ArrowSize:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatActnCtrlsLibrary.__GetTCustomUtilityButtonArrowType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomUtilityButton(CurrentObject).ArrowType);
  end;
end;

procedure TatActnCtrlsLibrary.__SetTCustomUtilityButtonArrowType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomUtilityButton(CurrentObject).ArrowType:=GetInputArg(0);
  end;
end;

procedure TatActnCtrlsLibrary.__GetTCustomUtilityButtonDirection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomUtilityButton(CurrentObject).Direction);
  end;
end;

procedure TatActnCtrlsLibrary.__SetTCustomUtilityButtonDirection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomUtilityButton(CurrentObject).Direction:=GetInputArg(0);
  end;
end;

procedure TatActnCtrlsLibrary.__GetTCustomUtilityButtonRepeatRate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomUtilityButton(CurrentObject).RepeatRate));
  end;
end;

procedure TatActnCtrlsLibrary.__SetTCustomUtilityButtonRepeatRate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomUtilityButton(CurrentObject).RepeatRate:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomToolScrollBtnCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomToolScrollBtnClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomToolScrollBtnCalcBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomToolScrollBtn(CurrentObject).CalcBounds;
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomDropDownButtonCalcBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomDropDownButton(CurrentObject).CalcBounds;
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomDropDownButtonClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomDropDownButton(CurrentObject).Click;
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomDropDownButtonDropDownClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomDropDownButton(CurrentObject).DropDownClick;
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomActionComboDesignWndProc(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TMessage;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TMessageWrapper) then 
  Param0Rec := TMessageWrapper.Create(Param0);
Param0 := TMessageWrapper(Param0Rec).ObjToRec;
AResult := TCustomActionCombo(CurrentObject).DesignWndProc(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TMessageWrapper.Create(Param0)));
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomActionComboDragDrop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionCombo(CurrentObject).DragDrop(TObject(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomComboControlCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomComboControlClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomComboControlDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboControl(CurrentObject).Destroy;
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomComboControlCalcBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboControl(CurrentObject).CalcBounds;
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomComboControlClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboControl(CurrentObject).Click;
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomComboControlSetBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboControl(CurrentObject).SetBounds(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatActnCtrlsLibrary.__GetTCustomComboControlComboBox(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomComboControl(CurrentObject).ComboBox));
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomActionDockBarCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionDockBarClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomActionDockBarCalcDockedWidth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionDockBar(CurrentObject).CalcDockedWidth);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomActionDockBarDock(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionDockBar(CurrentObject).Dock(TWinControl(Integer(GetInputArg(0))),TRectWrapper(integer(GetInputArg(1))).ObjToRec);
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomActionToolBarCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionToolBarClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomActionToolBarDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionToolBar(CurrentObject).Destroy;
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomActionToolBarCalcDockedWidth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionToolBar(CurrentObject).CalcDockedWidth);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomActionToolBarCreateControl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionToolBar(CurrentObject).CreateControl(TActionClientItem(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomActionToolBarDoDropCategory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionToolBar(CurrentObject).DoDropCategory(TCategoryDragObject(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomActionToolBarDragDrop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionToolBar(CurrentObject).DragDrop(TObject(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatActnCtrlsLibrary.__TCustomActionToolBarSetBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionToolBar(CurrentObject).SetBounds(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatActnCtrlsLibrary.__GetTCustomActionToolBarHiddenCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionToolBar(CurrentObject).HiddenCount));
  end;
end;

procedure TatActnCtrlsLibrary.Init;
begin
  With Scripter.DefineClass(TMenuResizeActionControl) do
  begin
  end;
  With Scripter.DefineClass(TCustomButtonControl) do
  begin
    DefineMethod('Create',1,tkClass,TCustomButtonControl,__TCustomButtonControlCreate,true,0);
    DefineMethod('CalcBounds',0,tkNone,nil,__TCustomButtonControlCalcBounds,false,0);
    DefineMethod('Click',0,tkNone,nil,__TCustomButtonControlClick,false,0);
    DefineMethod('SetBounds',4,tkNone,nil,__TCustomButtonControlSetBounds,false,0);
    DefineProp('AllowAllUp',tkVariant,__GetTCustomButtonControlAllowAllUp,__SetTCustomButtonControlAllowAllUp,nil,false,0);
    DefineProp('Caption',tkVariant,nil,nil,nil,false,0);
    DefineProp('Down',tkVariant,__GetTCustomButtonControlDown,__SetTCustomButtonControlDown,nil,false,0);
    DefineProp('Flat',tkVariant,__GetTCustomButtonControlFlat,__SetTCustomButtonControlFlat,nil,false,0);
    DefineProp('ShowCaption',tkVariant,nil,nil,nil,false,0);
    DefineProp('ShowShortCut',tkVariant,nil,nil,nil,false,0);
    DefineProp('State',tkEnumeration,__GetTCustomButtonControlState,__SetTCustomButtonControlState,nil,false,0);
    DefineProp('TrackButton',tkEnumeration,__GetTCustomButtonControlTrackButton,__SetTCustomButtonControlTrackButton,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomUtilityButton) do
  begin
    DefineMethod('Create',1,tkClass,TCustomUtilityButton,__TCustomUtilityButtonCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomUtilityButtonDestroy,false,0);
    DefineMethod('Click',0,tkNone,nil,__TCustomUtilityButtonClick,false,0);
    DefineProp('AutoScroll',tkVariant,__GetTCustomUtilityButtonAutoScroll,__SetTCustomUtilityButtonAutoScroll,nil,false,0);
    DefineProp('ArrowSize',tkInteger,__GetTCustomUtilityButtonArrowSize,__SetTCustomUtilityButtonArrowSize,nil,false,0);
    DefineProp('ArrowType',tkEnumeration,__GetTCustomUtilityButtonArrowType,__SetTCustomUtilityButtonArrowType,nil,false,0);
    DefineProp('Color',tkVariant,nil,nil,nil,false,0);
    DefineProp('Direction',tkEnumeration,__GetTCustomUtilityButtonDirection,__SetTCustomUtilityButtonDirection,nil,false,0);
    DefineProp('RepeatRate',tkInteger,__GetTCustomUtilityButtonRepeatRate,__SetTCustomUtilityButtonRepeatRate,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomToolScrollBtn) do
  begin
    DefineMethod('Create',1,tkClass,TCustomToolScrollBtn,__TCustomToolScrollBtnCreate,true,0);
    DefineMethod('CalcBounds',0,tkNone,nil,__TCustomToolScrollBtnCalcBounds,false,0);
  end;
  With Scripter.DefineClass(TCustomDropDownButton) do
  begin
    DefineMethod('CalcBounds',0,tkNone,nil,__TCustomDropDownButtonCalcBounds,false,0);
    DefineMethod('Click',0,tkNone,nil,__TCustomDropDownButtonClick,false,0);
    DefineMethod('DropDownClick',0,tkNone,nil,__TCustomDropDownButtonDropDownClick,false,0);
  end;
  With Scripter.DefineClass(TCustomActionCombo) do
  begin
    DefineMethod('DesignWndProc',1,tkVariant,nil,__TCustomActionComboDesignWndProc,false,0).SetVarArgs([0]);
    DefineMethod('DragDrop',3,tkNone,nil,__TCustomActionComboDragDrop,false,0);
  end;
  With Scripter.DefineClass(TCustomComboControl) do
  begin
    DefineMethod('Create',1,tkClass,TCustomComboControl,__TCustomComboControlCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomComboControlDestroy,false,0);
    DefineMethod('CalcBounds',0,tkNone,nil,__TCustomComboControlCalcBounds,false,0);
    DefineMethod('Click',0,tkNone,nil,__TCustomComboControlClick,false,0);
    DefineMethod('SetBounds',4,tkNone,nil,__TCustomComboControlSetBounds,false,0);
    DefineProp('ComboBox',tkClass,__GetTCustomComboControlComboBox,nil,TCustomActionCombo,false,0);
  end;
  With Scripter.DefineClass(TCustomActionDockBar) do
  begin
    DefineMethod('Create',1,tkClass,TCustomActionDockBar,__TCustomActionDockBarCreate,true,0);
    DefineMethod('CalcDockedWidth',0,tkInteger,nil,__TCustomActionDockBarCalcDockedWidth,false,0);
    DefineMethod('Dock',2,tkNone,nil,__TCustomActionDockBarDock,false,0);
  end;
  With Scripter.DefineClass(TCustomActionToolBar) do
  begin
    DefineMethod('Create',1,tkClass,TCustomActionToolBar,__TCustomActionToolBarCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomActionToolBarDestroy,false,0);
    DefineMethod('CalcDockedWidth',0,tkInteger,nil,__TCustomActionToolBarCalcDockedWidth,false,0);
    DefineMethod('CreateControl',1,tkClass,TCustomActionControl,__TCustomActionToolBarCreateControl,false,0);
    DefineMethod('DoDropCategory',3,tkNone,nil,__TCustomActionToolBarDoDropCategory,false,0);
    DefineMethod('DragDrop',3,tkNone,nil,__TCustomActionToolBarDragDrop,false,0);
    DefineMethod('SetBounds',4,tkNone,nil,__TCustomActionToolBarSetBounds,false,0);
    DefineProp('HiddenCount',tkInteger,__GetTCustomActionToolBarHiddenCount,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TActionToolBar) do
  begin
    DefineProp('Canvas',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatActnCtrlsLibrary.LibraryName: string;
begin
  result := 'ActnCtrls';
end;

initialization
  RegisterScripterLibrary(TatActnCtrlsLibrary, True);

{$WARNINGS ON}

end.

