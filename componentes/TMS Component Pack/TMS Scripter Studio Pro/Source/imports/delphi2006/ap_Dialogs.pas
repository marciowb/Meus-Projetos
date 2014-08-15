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
unit ap_Dialogs;

interface

uses
  Windows,
  Messages,
  SysUtils,
  CommDlg,
  Printers,
  Classes,
  Graphics,
  Controls,
  Forms,
  StdCtrls,
  Dialogs,
  Variants,
  ap_CommDlg,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatDialogsLibrary = class(TatScripterLibrary)
    procedure __TCommonDialogCreate(AMachine: TatVirtualMachine);
    procedure __TCommonDialogDestroy(AMachine: TatVirtualMachine);
    procedure __TCommonDialogExecute(AMachine: TatVirtualMachine);
    procedure __TCommonDialogDefaultHandler(AMachine: TatVirtualMachine);
    procedure __GetTCommonDialogHandle(AMachine: TatVirtualMachine);
    procedure __TOpenDialogCreate(AMachine: TatVirtualMachine);
    procedure __TOpenDialogDestroy(AMachine: TatVirtualMachine);
    procedure __TOpenDialogExecute(AMachine: TatVirtualMachine);
    procedure __GetTOpenDialogFileEditStyle(AMachine: TatVirtualMachine);
    procedure __SetTOpenDialogFileEditStyle(AMachine: TatVirtualMachine);
    procedure __GetTOpenDialogFiles(AMachine: TatVirtualMachine);
    procedure __GetTOpenDialogHistoryList(AMachine: TatVirtualMachine);
    procedure __SetTOpenDialogHistoryList(AMachine: TatVirtualMachine);
    procedure __TSaveDialogExecute(AMachine: TatVirtualMachine);
    procedure __TColorDialogCreate(AMachine: TatVirtualMachine);
    procedure __TColorDialogDestroy(AMachine: TatVirtualMachine);
    procedure __TColorDialogExecute(AMachine: TatVirtualMachine);
    procedure __TFontDialogCreate(AMachine: TatVirtualMachine);
    procedure __TFontDialogDestroy(AMachine: TatVirtualMachine);
    procedure __TFontDialogExecute(AMachine: TatVirtualMachine);
    procedure __TPrinterSetupDialogExecute(AMachine: TatVirtualMachine);
    procedure __TPrintDialogExecute(AMachine: TatVirtualMachine);
    procedure __TPageSetupDialogCreate(AMachine: TatVirtualMachine);
    procedure __TPageSetupDialogExecute(AMachine: TatVirtualMachine);
    procedure __TPageSetupDialogGetDefaults(AMachine: TatVirtualMachine);
    procedure __GetTPageSetupDialogPageSetupDlgRec(AMachine: TatVirtualMachine);
    procedure __TFindDialogCreate(AMachine: TatVirtualMachine);
    procedure __TFindDialogDestroy(AMachine: TatVirtualMachine);
    procedure __TFindDialogCloseDialog(AMachine: TatVirtualMachine);
    procedure __TFindDialogExecute(AMachine: TatVirtualMachine);
    procedure __GetTFindDialogLeft(AMachine: TatVirtualMachine);
    procedure __SetTFindDialogLeft(AMachine: TatVirtualMachine);
    procedure __GetTFindDialogPosition(AMachine: TatVirtualMachine);
    procedure __SetTFindDialogPosition(AMachine: TatVirtualMachine);
    procedure __GetTFindDialogTop(AMachine: TatVirtualMachine);
    procedure __SetTFindDialogTop(AMachine: TatVirtualMachine);
    procedure __TReplaceDialogCreate(AMachine: TatVirtualMachine);
    procedure __CreateMessageDialog(AMachine: TatVirtualMachine);
    procedure __MessageDlg(AMachine: TatVirtualMachine);
    procedure __MessageDlgPos(AMachine: TatVirtualMachine);
    procedure __MessageDlgPosHelp(AMachine: TatVirtualMachine);
    procedure __ShowMessage(AMachine: TatVirtualMachine);
    procedure __ShowMessagePos(AMachine: TatVirtualMachine);
    procedure __InputBox(AMachine: TatVirtualMachine);
    procedure __InputQuery(AMachine: TatVirtualMachine);
    procedure __PromptForFileName(AMachine: TatVirtualMachine);
    procedure __GetForceCurrentDirectory(AMachine: TatVirtualMachine);
    procedure __SetForceCurrentDirectory(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCommonDialogClass = class of TCommonDialog;
  TOpenDialogClass = class of TOpenDialog;
  TSaveDialogClass = class of TSaveDialog;
  TColorDialogClass = class of TColorDialog;
  TFontDialogClass = class of TFontDialog;
  TPrinterSetupDialogClass = class of TPrinterSetupDialog;
  TPrintDialogClass = class of TPrintDialog;
  TPageSetupDialogClass = class of TPageSetupDialog;
  TFindDialogClass = class of TFindDialog;
  TReplaceDialogClass = class of TReplaceDialog;

  TatDialogsDispatcher = class(TatEventDispatcher)
  private
    procedure __TFDApplyEvent( Sender: TObject;  Wnd: HWND);
    procedure __TPageSetupBeforePaintEvent( Sender: TObject; const PaperSize: SmallInt; const Orientation: TPrinterOrientation; const PageType: TPageType; var DoneDrawing: Boolean);
  end;


implementation



procedure TatDialogsLibrary.__TCommonDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCommonDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TCommonDialogDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCommonDialog(CurrentObject).Destroy;
  end;
end;

procedure TatDialogsLibrary.__TCommonDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCommonDialog(CurrentObject).Execute;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TCommonDialogDefaultHandler(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    TCommonDialog(CurrentObject).DefaultHandler(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatDialogsLibrary.__GetTCommonDialogHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCommonDialog(CurrentObject).Handle));
  end;
end;

procedure TatDialogsLibrary.__TOpenDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOpenDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TOpenDialogDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOpenDialog(CurrentObject).Destroy;
  end;
end;

procedure TatDialogsLibrary.__TOpenDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TOpenDialog(CurrentObject).Execute(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__GetTOpenDialogFileEditStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TOpenDialog(CurrentObject).FileEditStyle);
  end;
end;

procedure TatDialogsLibrary.__SetTOpenDialogFileEditStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOpenDialog(CurrentObject).FileEditStyle:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTOpenDialogFiles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TOpenDialog(CurrentObject).Files));
  end;
end;

procedure TatDialogsLibrary.__GetTOpenDialogHistoryList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TOpenDialog(CurrentObject).HistoryList));
  end;
end;

procedure TatDialogsLibrary.__SetTOpenDialogHistoryList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOpenDialog(CurrentObject).HistoryList:=TStrings(Integer(GetInputArg(0)));
  end;
end;

procedure TatDialogsLibrary.__TSaveDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TSaveDialog(CurrentObject).Execute(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TColorDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TColorDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TColorDialogDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TColorDialog(CurrentObject).Destroy;
  end;
end;

procedure TatDialogsLibrary.__TColorDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TColorDialog(CurrentObject).Execute(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TFontDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFontDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TFontDialogDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFontDialog(CurrentObject).Destroy;
  end;
end;

procedure TatDialogsLibrary.__TFontDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TFontDialog(CurrentObject).Execute(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TPrinterSetupDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TPrinterSetupDialog(CurrentObject).Execute(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TPrintDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TPrintDialog(CurrentObject).Execute(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TPageSetupDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPageSetupDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TPageSetupDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TPageSetupDialog(CurrentObject).Execute(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TPageSetupDialogGetDefaults(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TPageSetupDialog(CurrentObject).GetDefaults;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__GetTPageSetupDialogPageSetupDlgRec(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(tagPSDAWrapper.Create(TPageSetupDialog(CurrentObject).PageSetupDlgRec)));
  end;
end;

procedure TatDialogsLibrary.__TFindDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFindDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TFindDialogDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFindDialog(CurrentObject).Destroy;
  end;
end;

procedure TatDialogsLibrary.__TFindDialogCloseDialog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFindDialog(CurrentObject).CloseDialog;
  end;
end;

procedure TatDialogsLibrary.__TFindDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TFindDialog(CurrentObject).Execute(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__GetTFindDialogLeft(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFindDialog(CurrentObject).Left));
  end;
end;

procedure TatDialogsLibrary.__SetTFindDialogLeft(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFindDialog(CurrentObject).Left:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDialogsLibrary.__GetTFindDialogPosition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TPointWrapper.Create(TFindDialog(CurrentObject).Position)));
  end;
end;

procedure TatDialogsLibrary.__SetTFindDialogPosition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFindDialog(CurrentObject).Position:=TPointWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatDialogsLibrary.__GetTFindDialogTop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFindDialog(CurrentObject).Top));
  end;
end;

procedure TatDialogsLibrary.__SetTFindDialogTop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFindDialog(CurrentObject).Top:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDialogsLibrary.__TReplaceDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TReplaceDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsDispatcher.__TFDApplyEvent( Sender: TObject;  Wnd: HWND);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TFDApplyEvent(BeforeCall)(Sender,Wnd);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Wnd]);
    if AssignedMethod(AfterCall) then
      TFDApplyEvent(AfterCall)(Sender,Wnd);
  end;
end;

procedure TatDialogsDispatcher.__TPageSetupBeforePaintEvent( Sender: TObject; const PaperSize: SmallInt; const Orientation: TPrinterOrientation; const PageType: TPageType; var DoneDrawing: Boolean);
var
  OrientationTemp: variant;
  PageTypeTemp: variant;
  DoneDrawingTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TPageSetupBeforePaintEvent(BeforeCall)(Sender,PaperSize,Orientation,PageType,DoneDrawing);
    OrientationTemp := Orientation;
    PageTypeTemp := PageType;
    DoneDrawingTemp := DoneDrawing;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,PaperSize,OrientationTemp,PageTypeTemp,DoneDrawingTemp]);
    DoneDrawing := DoneDrawingTemp;
    if AssignedMethod(AfterCall) then
      TPageSetupBeforePaintEvent(AfterCall)(Sender,PaperSize,Orientation,PageType,DoneDrawing);
  end;
end;

procedure TatDialogsLibrary.__CreateMessageDialog(AMachine: TatVirtualMachine);
  var
  Param2: TMsgDlgButtons;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := Integer(Dialogs.CreateMessageDialog(GetInputArg(0),GetInputArg(1),Param2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__MessageDlg(AMachine: TatVirtualMachine);
  var
  Param2: TMsgDlgButtons;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := Integer(Dialogs.MessageDlg(GetInputArg(0),GetInputArg(1),Param2,VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__MessageDlgPos(AMachine: TatVirtualMachine);
  var
  Param2: TMsgDlgButtons;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := Integer(Dialogs.MessageDlgPos(GetInputArg(0),GetInputArg(1),Param2,VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__MessageDlgPosHelp(AMachine: TatVirtualMachine);
  var
  Param2: TMsgDlgButtons;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := Integer(Dialogs.MessageDlgPosHelp(GetInputArg(0),GetInputArg(1),Param2,VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),GetInputArg(6)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__ShowMessage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Dialogs.ShowMessage(GetInputArg(0));
  end;
end;

procedure TatDialogsLibrary.__ShowMessagePos(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Dialogs.ShowMessagePos(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatDialogsLibrary.__InputBox(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Dialogs.InputBox(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__InputQuery(AMachine: TatVirtualMachine);
  var
  Param2: string;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Dialogs.InputQuery(GetInputArg(0),GetInputArg(1),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatDialogsLibrary.__PromptForFileName(AMachine: TatVirtualMachine);
  var
  Param0: string;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
case InputArgCount of
1: AResult := Dialogs.PromptForFileName(Param0);
2: AResult := Dialogs.PromptForFileName(Param0,GetInputArg(1));
3: AResult := Dialogs.PromptForFileName(Param0,GetInputArg(1),GetInputArg(2));
4: AResult := Dialogs.PromptForFileName(Param0,GetInputArg(1),GetInputArg(2),GetInputArg(3));
5: AResult := Dialogs.PromptForFileName(Param0,GetInputArg(1),GetInputArg(2),GetInputArg(3),GetInputArg(4));
6: AResult := Dialogs.PromptForFileName(Param0,GetInputArg(1),GetInputArg(2),GetInputArg(3),GetInputArg(4),GetInputArg(5));
end;
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatDialogsLibrary.__GetForceCurrentDirectory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Dialogs.ForceCurrentDirectory);
  end;
end;

procedure TatDialogsLibrary.__SetForceCurrentDirectory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Dialogs.ForceCurrentDirectory:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.Init;
begin
  With Scripter.DefineClass(TCommonDialog) do
  begin
    DefineMethod('Create',1,tkClass,TCommonDialog,__TCommonDialogCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCommonDialogDestroy,false,0);
    DefineMethod('Execute',0,tkVariant,nil,__TCommonDialogExecute,false,0);
    DefineMethod('DefaultHandler',1,tkNone,nil,__TCommonDialogDefaultHandler,false,0).SetVarArgs([0]);
    DefineProp('Handle',tkInteger,__GetTCommonDialogHandle,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TOpenDialog) do
  begin
    DefineMethod('Create',1,tkClass,TOpenDialog,__TOpenDialogCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TOpenDialogDestroy,false,0);
    DefineMethod('Execute',1,tkVariant,nil,__TOpenDialogExecute,false,0);
    DefineProp('FileEditStyle',tkEnumeration,__GetTOpenDialogFileEditStyle,__SetTOpenDialogFileEditStyle,nil,false,0);
    DefineProp('Files',tkClass,__GetTOpenDialogFiles,nil,TStrings,false,0);
    DefineProp('HistoryList',tkClass,__GetTOpenDialogHistoryList,__SetTOpenDialogHistoryList,TStrings,false,0);
  end;
  With Scripter.DefineClass(TSaveDialog) do
  begin
    DefineMethod('Execute',1,tkVariant,nil,__TSaveDialogExecute,false,0);
  end;
  With Scripter.DefineClass(TColorDialog) do
  begin
    DefineMethod('Create',1,tkClass,TColorDialog,__TColorDialogCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TColorDialogDestroy,false,0);
    DefineMethod('Execute',1,tkVariant,nil,__TColorDialogExecute,false,0);
  end;
  With Scripter.DefineClass(TFontDialog) do
  begin
    DefineMethod('Create',1,tkClass,TFontDialog,__TFontDialogCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TFontDialogDestroy,false,0);
    DefineMethod('Execute',1,tkVariant,nil,__TFontDialogExecute,false,0);
  end;
  With Scripter.DefineClass(TPrinterSetupDialog) do
  begin
    DefineMethod('Execute',1,tkVariant,nil,__TPrinterSetupDialogExecute,false,0);
  end;
  With Scripter.DefineClass(TPrintDialog) do
  begin
    DefineMethod('Execute',1,tkVariant,nil,__TPrintDialogExecute,false,0);
  end;
  With Scripter.DefineClass(TPageSetupDialog) do
  begin
    DefineMethod('Create',1,tkClass,TPageSetupDialog,__TPageSetupDialogCreate,true,0);
    DefineMethod('Execute',1,tkVariant,nil,__TPageSetupDialogExecute,false,0);
    DefineMethod('GetDefaults',0,tkVariant,nil,__TPageSetupDialogGetDefaults,false,0);
    DefineProp('PageSetupDlgRec',tkVariant,__GetTPageSetupDialogPageSetupDlgRec,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TFindDialog) do
  begin
    DefineMethod('Create',1,tkClass,TFindDialog,__TFindDialogCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TFindDialogDestroy,false,0);
    DefineMethod('CloseDialog',0,tkNone,nil,__TFindDialogCloseDialog,false,0);
    DefineMethod('Execute',1,tkVariant,nil,__TFindDialogExecute,false,0);
    DefineProp('Left',tkInteger,__GetTFindDialogLeft,__SetTFindDialogLeft,nil,false,0);
    DefineProp('Position',tkVariant,__GetTFindDialogPosition,__SetTFindDialogPosition,nil,false,0);
    DefineProp('Top',tkInteger,__GetTFindDialogTop,__SetTFindDialogTop,nil,false,0);
  end;
  With Scripter.DefineClass(TReplaceDialog) do
  begin
    DefineMethod('Create',1,tkClass,TReplaceDialog,__TReplaceDialogCreate,true,0);
  end;
  DefineEventAdapter(TypeInfo(TFDApplyEvent), TatDialogsDispatcher, @TatDialogsDispatcher.__TFDApplyEvent);
  DefineEventAdapter(TypeInfo(TPageSetupBeforePaintEvent), TatDialogsDispatcher, @TatDialogsDispatcher.__TPageSetupBeforePaintEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('CreateMessageDialog',3,tkClass,TForm,__CreateMessageDialog,false,0);
    DefineMethod('MessageDlg',4,tkInteger,nil,__MessageDlg,false,0);
    DefineMethod('MessageDlgPos',6,tkInteger,nil,__MessageDlgPos,false,0);
    DefineMethod('MessageDlgPosHelp',7,tkInteger,nil,__MessageDlgPosHelp,false,0);
    DefineMethod('ShowMessage',1,tkNone,nil,__ShowMessage,false,0);
    DefineMethod('ShowMessagePos',3,tkNone,nil,__ShowMessagePos,false,0);
    DefineMethod('InputBox',3,tkVariant,nil,__InputBox,false,0);
    DefineMethod('InputQuery',3,tkVariant,nil,__InputQuery,false,0).SetVarArgs([2]);
    DefineMethod('PromptForFileName',6,tkVariant,nil,__PromptForFileName,false,5).SetVarArgs([0]);
    DefineProp('ForceCurrentDirectory',tkVariant,__GetForceCurrentDirectory,__SetForceCurrentDirectory,nil,false,0);
    AddConstant('ofReadOnly',ofReadOnly);
    AddConstant('ofOverwritePrompt',ofOverwritePrompt);
    AddConstant('ofHideReadOnly',ofHideReadOnly);
    AddConstant('ofNoChangeDir',ofNoChangeDir);
    AddConstant('ofShowHelp',ofShowHelp);
    AddConstant('ofNoValidate',ofNoValidate);
    AddConstant('ofAllowMultiSelect',ofAllowMultiSelect);
    AddConstant('ofExtensionDifferent',ofExtensionDifferent);
    AddConstant('ofPathMustExist',ofPathMustExist);
    AddConstant('ofFileMustExist',ofFileMustExist);
    AddConstant('ofCreatePrompt',ofCreatePrompt);
    AddConstant('ofShareAware',ofShareAware);
    AddConstant('ofNoReadOnlyReturn',ofNoReadOnlyReturn);
    AddConstant('ofNoTestFileCreate',ofNoTestFileCreate);
    AddConstant('ofNoNetworkButton',ofNoNetworkButton);
    AddConstant('ofNoLongNames',ofNoLongNames);
    AddConstant('ofOldStyleDialog',ofOldStyleDialog);
    AddConstant('ofNoDereferenceLinks',ofNoDereferenceLinks);
    AddConstant('ofEnableIncludeNotify',ofEnableIncludeNotify);
    AddConstant('ofEnableSizing',ofEnableSizing);
    AddConstant('ofDontAddToRecent',ofDontAddToRecent);
    AddConstant('ofForceShowHidden',ofForceShowHidden);
    AddConstant('ofExNoPlacesBar',ofExNoPlacesBar);
    AddConstant('fsEdit',fsEdit);
    AddConstant('fsComboBox',fsComboBox);
    AddConstant('cdFullOpen',cdFullOpen);
    AddConstant('cdPreventFullOpen',cdPreventFullOpen);
    AddConstant('cdShowHelp',cdShowHelp);
    AddConstant('cdSolidColor',cdSolidColor);
    AddConstant('cdAnyColor',cdAnyColor);
    AddConstant('fdAnsiOnly',fdAnsiOnly);
    AddConstant('fdTrueTypeOnly',fdTrueTypeOnly);
    AddConstant('fdEffects',fdEffects);
    AddConstant('fdFixedPitchOnly',fdFixedPitchOnly);
    AddConstant('fdForceFontExist',fdForceFontExist);
    AddConstant('fdNoFaceSel',fdNoFaceSel);
    AddConstant('fdNoOEMFonts',fdNoOEMFonts);
    AddConstant('fdNoSimulations',fdNoSimulations);
    AddConstant('fdNoSizeSel',fdNoSizeSel);
    AddConstant('fdNoStyleSel',fdNoStyleSel);
    AddConstant('fdNoVectorFonts',fdNoVectorFonts);
    AddConstant('fdShowHelp',fdShowHelp);
    AddConstant('fdWysiwyg',fdWysiwyg);
    AddConstant('fdLimitSize',fdLimitSize);
    AddConstant('fdScalableOnly',fdScalableOnly);
    AddConstant('fdApplyButton',fdApplyButton);
    AddConstant('fdScreen',fdScreen);
    AddConstant('fdPrinter',fdPrinter);
    AddConstant('fdBoth',fdBoth);
    AddConstant('prAllPages',prAllPages);
    AddConstant('prSelection',prSelection);
    AddConstant('prPageNums',prPageNums);
    AddConstant('poPrintToFile',poPrintToFile);
    AddConstant('poPageNums',poPageNums);
    AddConstant('poSelection',poSelection);
    AddConstant('poWarning',poWarning);
    AddConstant('poHelp',poHelp);
    AddConstant('poDisablePrintToFile',poDisablePrintToFile);
    AddConstant('psoDefaultMinMargins',psoDefaultMinMargins);
    AddConstant('psoDisableMargins',psoDisableMargins);
    AddConstant('psoDisableOrientation',psoDisableOrientation);
    AddConstant('psoDisablePagePainting',psoDisablePagePainting);
    AddConstant('psoDisablePaper',psoDisablePaper);
    AddConstant('psoDisablePrinter',psoDisablePrinter);
    AddConstant('psoMargins',psoMargins);
    AddConstant('psoMinMargins',psoMinMargins);
    AddConstant('psoShowHelp',psoShowHelp);
    AddConstant('psoWarning',psoWarning);
    AddConstant('psoNoNetworkButton',psoNoNetworkButton);
    AddConstant('pkDotMatrix',pkDotMatrix);
    AddConstant('pkHPPCL',pkHPPCL);
    AddConstant('ptEnvelope',ptEnvelope);
    AddConstant('ptPaper',ptPaper);
    AddConstant('pmDefault',pmDefault);
    AddConstant('pmMillimeters',pmMillimeters);
    AddConstant('pmInches',pmInches);
    AddConstant('frDown',frDown);
    AddConstant('frFindNext',frFindNext);
    AddConstant('frHideMatchCase',frHideMatchCase);
    AddConstant('frHideWholeWord',frHideWholeWord);
    AddConstant('frHideUpDown',frHideUpDown);
    AddConstant('frMatchCase',frMatchCase);
    AddConstant('frDisableMatchCase',frDisableMatchCase);
    AddConstant('frDisableUpDown',frDisableUpDown);
    AddConstant('frDisableWholeWord',frDisableWholeWord);
    AddConstant('frReplace',frReplace);
    AddConstant('frReplaceAll',frReplaceAll);
    AddConstant('frWholeWord',frWholeWord);
    AddConstant('frShowHelp',frShowHelp);
    AddConstant('mtWarning',mtWarning);
    AddConstant('mtError',mtError);
    AddConstant('mtInformation',mtInformation);
    AddConstant('mtConfirmation',mtConfirmation);
    AddConstant('mtCustom',mtCustom);
    AddConstant('mbYes',mbYes);
    AddConstant('mbNo',mbNo);
    AddConstant('mbOK',mbOK);
    AddConstant('mbCancel',mbCancel);
    AddConstant('mbAbort',mbAbort);
    AddConstant('mbRetry',mbRetry);
    AddConstant('mbIgnore',mbIgnore);
    AddConstant('mbAll',mbAll);
    AddConstant('mbNoToAll',mbNoToAll);
    AddConstant('mbYesToAll',mbYesToAll);
    AddConstant('mbHelp',mbHelp);
    AddConstant('MaxCustomColors',MaxCustomColors);
    AddConstant('mbYesNo',IntFromConstSet(mbYesNo));
    AddConstant('mbYesNoCancel',IntFromConstSet(mbYesNoCancel));
    AddConstant('mbYesAllNoAllCancel',IntFromConstSet(mbYesAllNoAllCancel));
    AddConstant('mbOKCancel',IntFromConstSet(mbOKCancel));
    AddConstant('mbAbortRetryIgnore',IntFromConstSet(mbAbortRetryIgnore));
    AddConstant('mbAbortIgnore',IntFromConstSet(mbAbortIgnore));
  end;
end;

class function TatDialogsLibrary.LibraryName: string;
begin
  result := 'Dialogs';
end;

initialization
  RegisterScripterLibrary(TatDialogsLibrary, True);

{$WARNINGS ON}

end.

