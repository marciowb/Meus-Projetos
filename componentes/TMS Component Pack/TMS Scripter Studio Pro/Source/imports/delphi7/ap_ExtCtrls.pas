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
unit ap_ExtCtrls;

interface

uses
  Messages,
  Windows,
  SysUtils,
  Classes,
  Controls,
  Forms,
  Menus,
  Graphics,
  StdCtrls,
  ExtCtrls,
  Variants,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatExtCtrlsLibrary = class(TatScripterLibrary)
    procedure __TShapeCreate(AMachine: TatVirtualMachine);
    procedure __TShapeDestroy(AMachine: TatVirtualMachine);
    procedure __TPaintBoxCreate(AMachine: TatVirtualMachine);
    procedure __TImageCreate(AMachine: TatVirtualMachine);
    procedure __TImageDestroy(AMachine: TatVirtualMachine);
    procedure __GetTImageCanvas(AMachine: TatVirtualMachine);
    procedure __TBevelCreate(AMachine: TatVirtualMachine);
    procedure __TTimerCreate(AMachine: TatVirtualMachine);
    procedure __TTimerDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomPanelCreate(AMachine: TatVirtualMachine);
    procedure __TCustomPanelGetControlsAlignment(AMachine: TatVirtualMachine);
    procedure __TPageCreate(AMachine: TatVirtualMachine);
    procedure __TNotebookCreate(AMachine: TatVirtualMachine);
    procedure __TNotebookDestroy(AMachine: TatVirtualMachine);
    procedure __THeaderCreate(AMachine: TatVirtualMachine);
    procedure __THeaderDestroy(AMachine: TatVirtualMachine);
    procedure __GetTHeaderSectionWidth(AMachine: TatVirtualMachine);
    procedure __SetTHeaderSectionWidth(AMachine: TatVirtualMachine);
    procedure __TCustomRadioGroupCreate(AMachine: TatVirtualMachine);
    procedure __TCustomRadioGroupDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomRadioGroupFlipChildren(AMachine: TatVirtualMachine);
    procedure __GetTCustomRadioGroupButtons(AMachine: TatVirtualMachine);
    procedure __TSplitterCreate(AMachine: TatVirtualMachine);
    procedure __TSplitterDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomControlBarCreate(AMachine: TatVirtualMachine);
    procedure __TCustomControlBarDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomControlBarFlipChildren(AMachine: TatVirtualMachine);
    procedure __TCustomControlBarStickControls(AMachine: TatVirtualMachine);
    procedure __GetTCustomControlBarPicture(AMachine: TatVirtualMachine);
    procedure __SetTCustomControlBarPicture(AMachine: TatVirtualMachine);
    procedure __TBoundLabelCreate(AMachine: TatVirtualMachine);
    procedure __TCustomLabeledEditCreate(AMachine: TatVirtualMachine);
    procedure __TCustomLabeledEditSetBounds(AMachine: TatVirtualMachine);
    procedure __TCustomLabeledEditSetupInternalLabel(AMachine: TatVirtualMachine);
    procedure __GetTCustomLabeledEditEditLabel(AMachine: TatVirtualMachine);
    procedure __GetTCustomLabeledEditLabelPosition(AMachine: TatVirtualMachine);
    procedure __SetTCustomLabeledEditLabelPosition(AMachine: TatVirtualMachine);
    procedure __GetTCustomLabeledEditLabelSpacing(AMachine: TatVirtualMachine);
    procedure __SetTCustomLabeledEditLabelSpacing(AMachine: TatVirtualMachine);
    procedure __TCustomColorBoxCreate(AMachine: TatVirtualMachine);
    procedure __GetTCustomColorBoxStyle(AMachine: TatVirtualMachine);
    procedure __SetTCustomColorBoxStyle(AMachine: TatVirtualMachine);
    procedure __GetTCustomColorBoxColors(AMachine: TatVirtualMachine);
    procedure __GetTCustomColorBoxColorNames(AMachine: TatVirtualMachine);
    procedure __GetTCustomColorBoxSelected(AMachine: TatVirtualMachine);
    procedure __SetTCustomColorBoxSelected(AMachine: TatVirtualMachine);
    procedure __GetTCustomColorBoxDefaultColorColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomColorBoxDefaultColorColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomColorBoxNoneColorColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomColorBoxNoneColorColor(AMachine: TatVirtualMachine);
    procedure __Frame3D(AMachine: TatVirtualMachine);
    procedure __NotebookHandlesNeeded(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TShapeClass = class of TShape;
  TPaintBoxClass = class of TPaintBox;
  TImageClass = class of TImage;
  TBevelClass = class of TBevel;
  TTimerClass = class of TTimer;
  TCustomPanelClass = class of TCustomPanel;
  TPanelClass = class of TPanel;
  TPageClass = class of TPage;
  TNotebookClass = class of TNotebook;
  THeaderClass = class of THeader;
  TCustomRadioGroupClass = class of TCustomRadioGroup;
  TRadioGroupClass = class of TRadioGroup;
  TSplitterClass = class of TSplitter;
  TCustomControlBarClass = class of TCustomControlBar;
  TControlBarClass = class of TControlBar;
  TBoundLabelClass = class of TBoundLabel;
  TCustomLabeledEditClass = class of TCustomLabeledEdit;
  TLabeledEditClass = class of TLabeledEdit;
  TCustomColorBoxClass = class of TCustomColorBox;
  TColorBoxClass = class of TColorBox;

  TatExtCtrlsDispatcher = class(TatEventDispatcher)
  private
    procedure __TSectionEvent( Sender: TObject;  ASection: Integer;  AWidth: Integer);
    procedure __TCanResizeEvent( Sender: TObject; var NewSize: Integer; var Accept: Boolean);
    procedure __TBandDragEvent( Sender: TObject;  Control: TControl; var Drag: Boolean);
  end;


implementation



procedure TatExtCtrlsLibrary.__TShapeCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TShapeClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TShapeDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TShape(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__TPaintBoxCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPaintBoxClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TImageCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TImageClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TImageDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TImage(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__GetTImageCanvas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TImage(CurrentObject).Canvas));
  end;
end;

procedure TatExtCtrlsLibrary.__TBevelCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBevelClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TTimerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTimerClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TTimerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTimer(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomPanelCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomPanelClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomPanelGetControlsAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomPanel(CurrentObject).GetControlsAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TPageCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPageClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TNotebookCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TNotebookClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TNotebookDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TNotebook(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__THeaderCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(THeaderClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__THeaderDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THeader(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__GetTHeaderSectionWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(THeader(CurrentObject).SectionWidth[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTHeaderSectionWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THeader(CurrentObject).SectionWidth[VarToInteger(GetArrayIndex(0))]:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomRadioGroupCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomRadioGroupClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomRadioGroupDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomRadioGroup(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomRadioGroupFlipChildren(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomRadioGroup(CurrentObject).FlipChildren(GetInputArg(0));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomRadioGroupButtons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomRadioGroup(CurrentObject).Buttons[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatExtCtrlsLibrary.__TSplitterCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSplitterClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TSplitterDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSplitter(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomControlBarCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomControlBarClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomControlBarDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomControlBar(CurrentObject).Destroy;
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomControlBarFlipChildren(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomControlBar(CurrentObject).FlipChildren(GetInputArg(0));
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomControlBarStickControls(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomControlBar(CurrentObject).StickControls;
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomControlBarPicture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomControlBar(CurrentObject).Picture));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomControlBarPicture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomControlBar(CurrentObject).Picture:=TPicture(Integer(GetInputArg(0)));
  end;
end;

procedure TatExtCtrlsLibrary.__TBoundLabelCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBoundLabelClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomLabeledEditCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomLabeledEditClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomLabeledEditSetBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomLabeledEdit(CurrentObject).SetBounds(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomLabeledEditSetupInternalLabel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomLabeledEdit(CurrentObject).SetupInternalLabel;
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomLabeledEditEditLabel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomLabeledEdit(CurrentObject).EditLabel));
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomLabeledEditLabelPosition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomLabeledEdit(CurrentObject).LabelPosition);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomLabeledEditLabelPosition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomLabeledEdit(CurrentObject).LabelPosition:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomLabeledEditLabelSpacing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomLabeledEdit(CurrentObject).LabelSpacing));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomLabeledEditLabelSpacing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomLabeledEdit(CurrentObject).LabelSpacing:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatExtCtrlsLibrary.__TCustomColorBoxCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomColorBoxClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomColorBoxStyle(AMachine: TatVirtualMachine);
var
PropValueSet: TColorBoxStyle;
begin
  with AMachine do
  begin
    PropValueSet := TCustomColorBox(CurrentObject).Style;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomColorBoxStyle(AMachine: TatVirtualMachine);
  var
  TempVar: TColorBoxStyle;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TCustomColorBox(CurrentObject).Style:=TempVar;
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomColorBoxColors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomColorBox(CurrentObject).Colors[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomColorBoxColorNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomColorBox(CurrentObject).ColorNames[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomColorBoxSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomColorBox(CurrentObject).Selected);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomColorBoxSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomColorBox(CurrentObject).Selected:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomColorBoxDefaultColorColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomColorBox(CurrentObject).DefaultColorColor);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomColorBoxDefaultColorColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomColorBox(CurrentObject).DefaultColorColor:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsLibrary.__GetTCustomColorBoxNoneColorColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomColorBox(CurrentObject).NoneColorColor);
  end;
end;

procedure TatExtCtrlsLibrary.__SetTCustomColorBoxNoneColorColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomColorBox(CurrentObject).NoneColorColor:=GetInputArg(0);
  end;
end;

procedure TatExtCtrlsDispatcher.__TSectionEvent( Sender: TObject;  ASection: Integer;  AWidth: Integer);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TSectionEvent(BeforeCall)(Sender,ASection,AWidth);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ASection,AWidth]);
    if AssignedMethod(AfterCall) then
      TSectionEvent(AfterCall)(Sender,ASection,AWidth);
  end;
end;

procedure TatExtCtrlsDispatcher.__TCanResizeEvent( Sender: TObject; var NewSize: Integer; var Accept: Boolean);
var
  NewSizeTemp: variant;
  AcceptTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TCanResizeEvent(BeforeCall)(Sender,NewSize,Accept);
    NewSizeTemp := Integer(NewSize);
    AcceptTemp := Accept;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,NewSizeTemp,AcceptTemp]);
    NewSize := VarToInteger(NewSizeTemp);
    Accept := AcceptTemp;
    if AssignedMethod(AfterCall) then
      TCanResizeEvent(AfterCall)(Sender,NewSize,Accept);
  end;
end;

procedure TatExtCtrlsDispatcher.__TBandDragEvent( Sender: TObject;  Control: TControl; var Drag: Boolean);
var
  DragTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TBandDragEvent(BeforeCall)(Sender,Control,Drag);
    DragTemp := Drag;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Control,DragTemp]);
    Drag := DragTemp;
    if AssignedMethod(AfterCall) then
      TBandDragEvent(AfterCall)(Sender,Control,Drag);
  end;
end;

procedure TatExtCtrlsLibrary.__Frame3D(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TRect;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TRectWrapper) then 
  Param1Rec := TRectWrapper.Create(Param1);
Param1 := TRectWrapper(Param1Rec).ObjToRec;
    ExtCtrls.Frame3D(TCanvas(Integer(GetInputArg(0))),Param1,GetInputArg(2),GetInputArg(3),VarToInteger(GetInputArg(4)));
    SetInputArg(1,integer(TRectWrapper.Create(Param1)));
  end;
end;

procedure TatExtCtrlsLibrary.__NotebookHandlesNeeded(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ExtCtrls.NotebookHandlesNeeded(TNotebook(Integer(GetInputArg(0))));
  end;
end;

procedure TatExtCtrlsLibrary.Init;
begin
  With Scripter.DefineClass(TShape) do
  begin
    DefineMethod('Create',1,tkClass,TShape,__TShapeCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TShapeDestroy,false,0);
  end;
  With Scripter.DefineClass(TPaintBox) do
  begin
    DefineMethod('Create',1,tkClass,TPaintBox,__TPaintBoxCreate,true,0);
    DefineProp('Canvas',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TImage) do
  begin
    DefineMethod('Create',1,tkClass,TImage,__TImageCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TImageDestroy,false,0);
    DefineProp('Canvas',tkClass,__GetTImageCanvas,nil,TCanvas,false,0);
  end;
  With Scripter.DefineClass(TBevel) do
  begin
    DefineMethod('Create',1,tkClass,TBevel,__TBevelCreate,true,0);
  end;
  With Scripter.DefineClass(TTimer) do
  begin
    DefineMethod('Create',1,tkClass,TTimer,__TTimerCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TTimerDestroy,false,0);
  end;
  With Scripter.DefineClass(TCustomPanel) do
  begin
    DefineMethod('Create',1,tkClass,TCustomPanel,__TCustomPanelCreate,true,0);
    DefineMethod('GetControlsAlignment',0,tkEnumeration,nil,__TCustomPanelGetControlsAlignment,false,0);
    DefineProp('ParentBackground',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TPanel) do
  begin
    DefineProp('DockManager',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TPage) do
  begin
    DefineMethod('Create',1,tkClass,TPage,__TPageCreate,true,0);
  end;
  With Scripter.DefineClass(TNotebook) do
  begin
    DefineMethod('Create',1,tkClass,TNotebook,__TNotebookCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TNotebookDestroy,false,0);
  end;
  With Scripter.DefineClass(THeader) do
  begin
    DefineMethod('Create',1,tkClass,THeader,__THeaderCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__THeaderDestroy,false,0);
    DefineProp('SectionWidth',tkInteger,__GetTHeaderSectionWidth,__SetTHeaderSectionWidth,nil,false,1);
  end;
  With Scripter.DefineClass(TCustomRadioGroup) do
  begin
    DefineMethod('Create',1,tkClass,TCustomRadioGroup,__TCustomRadioGroupCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomRadioGroupDestroy,false,0);
    DefineMethod('FlipChildren',1,tkNone,nil,__TCustomRadioGroupFlipChildren,false,0);
    DefineProp('Buttons',tkClass,__GetTCustomRadioGroupButtons,nil,TRadioButton,false,1);
  end;
  With Scripter.DefineClass(TRadioGroup) do
  begin
  end;
  With Scripter.DefineClass(TSplitter) do
  begin
    DefineMethod('Create',1,tkClass,TSplitter,__TSplitterCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TSplitterDestroy,false,0);
    DefineProp('Canvas',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomControlBar) do
  begin
    DefineMethod('Create',1,tkClass,TCustomControlBar,__TCustomControlBarCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomControlBarDestroy,false,0);
    DefineMethod('FlipChildren',1,tkNone,nil,__TCustomControlBarFlipChildren,false,0);
    DefineMethod('StickControls',0,tkNone,nil,__TCustomControlBarStickControls,false,0);
    DefineProp('Picture',tkClass,__GetTCustomControlBarPicture,__SetTCustomControlBarPicture,TPicture,false,0);
  end;
  With Scripter.DefineClass(TControlBar) do
  begin
    DefineProp('Canvas',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TBoundLabel) do
  begin
    DefineMethod('Create',1,tkClass,TBoundLabel,__TBoundLabelCreate,true,0);
  end;
  With Scripter.DefineClass(TCustomLabeledEdit) do
  begin
    DefineMethod('Create',1,tkClass,TCustomLabeledEdit,__TCustomLabeledEditCreate,true,0);
    DefineMethod('SetBounds',4,tkNone,nil,__TCustomLabeledEditSetBounds,false,0);
    DefineMethod('SetupInternalLabel',0,tkNone,nil,__TCustomLabeledEditSetupInternalLabel,false,0);
    DefineProp('EditLabel',tkClass,__GetTCustomLabeledEditEditLabel,nil,TBoundLabel,false,0);
    DefineProp('LabelPosition',tkEnumeration,__GetTCustomLabeledEditLabelPosition,__SetTCustomLabeledEditLabelPosition,nil,false,0);
    DefineProp('LabelSpacing',tkInteger,__GetTCustomLabeledEditLabelSpacing,__SetTCustomLabeledEditLabelSpacing,nil,false,0);
  end;
  With Scripter.DefineClass(TLabeledEdit) do
  begin
  end;
  With Scripter.DefineClass(TCustomColorBox) do
  begin
    DefineMethod('Create',1,tkClass,TCustomColorBox,__TCustomColorBoxCreate,true,0);
    DefineProp('Style',tkInteger,__GetTCustomColorBoxStyle,__SetTCustomColorBoxStyle,nil,false,0);
    DefineProp('Colors',tkEnumeration,__GetTCustomColorBoxColors,nil,nil,false,1);
    DefineProp('ColorNames',tkVariant,__GetTCustomColorBoxColorNames,nil,nil,false,1);
    DefineProp('Selected',tkEnumeration,__GetTCustomColorBoxSelected,__SetTCustomColorBoxSelected,nil,false,0);
    DefineProp('DefaultColorColor',tkEnumeration,__GetTCustomColorBoxDefaultColorColor,__SetTCustomColorBoxDefaultColorColor,nil,false,0);
    DefineProp('NoneColorColor',tkEnumeration,__GetTCustomColorBoxNoneColorColor,__SetTCustomColorBoxNoneColorColor,nil,false,0);
  end;
  With Scripter.DefineClass(TColorBox) do
  begin
  end;
  DefineEventAdapter(TypeInfo(TSectionEvent), TatExtCtrlsDispatcher, @TatExtCtrlsDispatcher.__TSectionEvent);
  DefineEventAdapter(TypeInfo(TCanResizeEvent), TatExtCtrlsDispatcher, @TatExtCtrlsDispatcher.__TCanResizeEvent);
  DefineEventAdapter(TypeInfo(TBandDragEvent), TatExtCtrlsDispatcher, @TatExtCtrlsDispatcher.__TBandDragEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('Frame3D',5,tkNone,nil,__Frame3D,false,0).SetVarArgs([1]);
    DefineMethod('NotebookHandlesNeeded',1,tkNone,nil,__NotebookHandlesNeeded,false,0);
    AddConstant('stRectangle',stRectangle);
    AddConstant('stSquare',stSquare);
    AddConstant('stRoundRect',stRoundRect);
    AddConstant('stRoundSquare',stRoundSquare);
    AddConstant('stEllipse',stEllipse);
    AddConstant('stCircle',stCircle);
    AddConstant('bsLowered',bsLowered);
    AddConstant('bsRaised',bsRaised);
    AddConstant('bsBox',bsBox);
    AddConstant('bsFrame',bsFrame);
    AddConstant('bsTopLine',bsTopLine);
    AddConstant('bsBottomLine',bsBottomLine);
    AddConstant('bsLeftLine',bsLeftLine);
    AddConstant('bsRightLine',bsRightLine);
    AddConstant('bsSpacer',bsSpacer);
    AddConstant('rsNone',rsNone);
    AddConstant('rsLine',rsLine);
    AddConstant('rsUpdate',rsUpdate);
    AddConstant('rsPattern',rsPattern);
    AddConstant('bpoGrabber',bpoGrabber);
    AddConstant('bpoFrame',bpoFrame);
    AddConstant('lpAbove',lpAbove);
    AddConstant('lpBelow',lpBelow);
    AddConstant('lpLeft',lpLeft);
    AddConstant('lpRight',lpRight);
    AddConstant('cbStandardColors',cbStandardColors);
    AddConstant('cbExtendedColors',cbExtendedColors);
    AddConstant('cbSystemColors',cbSystemColors);
    AddConstant('cbIncludeNone',cbIncludeNone);
    AddConstant('cbIncludeDefault',cbIncludeDefault);
    AddConstant('cbCustomColor',cbCustomColor);
    AddConstant('cbPrettyNames',cbPrettyNames);
    AddConstant('NoColorSelected',NoColorSelected);
  end;
end;

class function TatExtCtrlsLibrary.LibraryName: string;
begin
  result := 'ExtCtrls';
end;

initialization
  RegisterScripterLibrary(TatExtCtrlsLibrary, True);

{$WARNINGS ON}

end.

