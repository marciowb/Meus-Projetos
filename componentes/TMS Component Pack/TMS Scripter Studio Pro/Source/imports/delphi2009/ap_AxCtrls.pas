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
unit ap_AxCtrls;

interface

uses
  Variants,
  Windows,
  Messages,
  ActiveX,
  SysUtils,
  ComObj,
  Classes,
  Graphics,
  Controls,
  Forms,
  ExtCtrls,
  StdVCL,
  AxCtrls,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatAxCtrlsLibrary = class(TatScripterLibrary)
    procedure __TOleStreamRead(AMachine: TatVirtualMachine);
    procedure __TOleStreamWrite(AMachine: TatVirtualMachine);
    procedure __TOleStreamSeek(AMachine: TatVirtualMachine);
    procedure __TConnectionPointDestroy(AMachine: TatVirtualMachine);
    procedure __GetTConnectionPointSinkList(AMachine: TatVirtualMachine);
    procedure __TConnectionPointsDestroy(AMachine: TatVirtualMachine);
    procedure __TActiveXControlDestroy(AMachine: TatVirtualMachine);
    procedure __TActiveXControlInitialize(AMachine: TatVirtualMachine);
    procedure __TActiveXControlObjQueryInterface(AMachine: TatVirtualMachine);
    procedure __GetTActiveXControlControl(AMachine: TatVirtualMachine);
    procedure __TActiveXControlFactoryDestroy(AMachine: TatVirtualMachine);
    procedure __TActiveXControlFactoryAddVerb(AMachine: TatVirtualMachine);
    procedure __TActiveXControlFactoryUpdateRegistry(AMachine: TatVirtualMachine);
    procedure __GetTActiveXControlFactoryMiscStatus(AMachine: TatVirtualMachine);
    procedure __GetTActiveXControlFactoryToolboxBitmapID(AMachine: TatVirtualMachine);
    procedure __TActiveFormControlFreeOnRelease(AMachine: TatVirtualMachine);
    procedure __TActiveFormControlInitializeControl(AMachine: TatVirtualMachine);
    procedure __TActiveFormControlObjQueryInterface(AMachine: TatVirtualMachine);
    procedure __GetTActiveFormActiveFormControl(AMachine: TatVirtualMachine);
    procedure __TPropertyPageCreate(AMachine: TatVirtualMachine);
    procedure __TPropertyPageDestroy(AMachine: TatVirtualMachine);
    procedure __TPropertyPageModified(AMachine: TatVirtualMachine);
    procedure __TPropertyPageUpdateObject(AMachine: TatVirtualMachine);
    procedure __TPropertyPageUpdatePropertyPage(AMachine: TatVirtualMachine);
    procedure __TPropertyPageEnumCtlProps(AMachine: TatVirtualMachine);
    procedure __GetTPropertyPageOleObject(AMachine: TatVirtualMachine);
    procedure __GetTPropertyPageOleObjects(AMachine: TatVirtualMachine);
    procedure __SetTPropertyPageOleObjects(AMachine: TatVirtualMachine);
    procedure __TPropertyPageImplInitPropertyPage(AMachine: TatVirtualMachine);
    procedure __GetTPropertyPageImplPropertyPage(AMachine: TatVirtualMachine);
    procedure __SetTPropertyPageImplPropertyPage(AMachine: TatVirtualMachine);
    procedure __TActiveXPropertyPageDestroy(AMachine: TatVirtualMachine);
    procedure __TActiveXPropertyPageInitialize(AMachine: TatVirtualMachine);
    procedure __GetTActiveXPropertyPagePropertyPageImpl(AMachine: TatVirtualMachine);
    procedure __TCustomAdapterCreate(AMachine: TatVirtualMachine);
    procedure __TCustomAdapterDestroy(AMachine: TatVirtualMachine);
    procedure __TAdapterNotifierCreate(AMachine: TatVirtualMachine);
    procedure __TFontAdapterCreate(AMachine: TatVirtualMachine);
    procedure __TPictureAdapterCreate(AMachine: TatVirtualMachine);
    procedure __TOleGraphicAssign(AMachine: TatVirtualMachine);
    procedure __TOleGraphicLoadFromFile(AMachine: TatVirtualMachine);
    procedure __TOleGraphicLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TOleGraphicSaveToStream(AMachine: TatVirtualMachine);
    procedure __TOleGraphicLoadFromClipboardFormat(AMachine: TatVirtualMachine);
    procedure __TOleGraphicSaveToClipboardFormat(AMachine: TatVirtualMachine);
    procedure __GetTOleGraphicMMHeight(AMachine: TatVirtualMachine);
    procedure __GetTOleGraphicMMWidth(AMachine: TatVirtualMachine);
    procedure __TStringsAdapterCreate(AMachine: TatVirtualMachine);
    procedure __TReflectorWindowCreate(AMachine: TatVirtualMachine);
    procedure __ParkingWindow(AMachine: TatVirtualMachine);
    procedure __GetClass_DColorPropPage(AMachine: TatVirtualMachine);
    procedure __GetClass_DFontPropPage(AMachine: TatVirtualMachine);
    procedure __GetClass_DPicturePropPage(AMachine: TatVirtualMachine);
    procedure __GetClass_DStringPropPage(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TOleStreamClass = class of TOleStream;
  TConnectionPointClass = class of TConnectionPoint;
  TConnectionPointsClass = class of TConnectionPoints;
  TActiveXControlClass = class of TActiveXControl;
  TActiveXControlFactoryClass = class of TActiveXControlFactory;
  TActiveFormControlClass = class of TActiveFormControl;
  TActiveFormClass = class of TActiveForm;
  TActiveFormFactoryClass = class of TActiveFormFactory;
  TPropertyPageClass = class of TPropertyPage;
  TPropertyPageImplClass = class of TPropertyPageImpl;
  TActiveXPropertyPageClass = class of TActiveXPropertyPage;
  TActiveXPropertyPageFactoryClass = class of TActiveXPropertyPageFactory;
  TCustomAdapterClass = class of TCustomAdapter;
  TAdapterNotifierClass = class of TAdapterNotifier;
  TFontAdapterClass = class of TFontAdapter;
  TPictureAdapterClass = class of TPictureAdapter;
  TOleGraphicClass = class of TOleGraphic;
  TStringsAdapterClass = class of TStringsAdapter;
  TReflectorWindowClass = class of TReflectorWindow;



implementation



procedure TatAxCtrlsLibrary.__TOleStreamRead(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TOleStream(CurrentObject).Read(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatAxCtrlsLibrary.__TOleStreamWrite(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TOleStream(CurrentObject).Write(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAxCtrlsLibrary.__TOleStreamSeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOleStream(CurrentObject).Seek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAxCtrlsLibrary.__TConnectionPointDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TConnectionPoint(CurrentObject).Destroy;
  end;
end;

procedure TatAxCtrlsLibrary.__GetTConnectionPointSinkList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TConnectionPoint(CurrentObject).SinkList));
  end;
end;

procedure TatAxCtrlsLibrary.__TConnectionPointsDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TConnectionPoints(CurrentObject).Destroy;
  end;
end;

procedure TatAxCtrlsLibrary.__TActiveXControlDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActiveXControl(CurrentObject).Destroy;
  end;
end;

procedure TatAxCtrlsLibrary.__TActiveXControlInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActiveXControl(CurrentObject).Initialize;
  end;
end;

procedure TatAxCtrlsLibrary.__TActiveXControlObjQueryInterface(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(TActiveXControl(CurrentObject).ObjQueryInterface(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatAxCtrlsLibrary.__GetTActiveXControlControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActiveXControl(CurrentObject).Control));
  end;
end;

procedure TatAxCtrlsLibrary.__TActiveXControlFactoryDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActiveXControlFactory(CurrentObject).Destroy;
  end;
end;

procedure TatAxCtrlsLibrary.__TActiveXControlFactoryAddVerb(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActiveXControlFactory(CurrentObject).AddVerb(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatAxCtrlsLibrary.__TActiveXControlFactoryUpdateRegistry(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActiveXControlFactory(CurrentObject).UpdateRegistry(GetInputArg(0));
  end;
end;

procedure TatAxCtrlsLibrary.__GetTActiveXControlFactoryMiscStatus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActiveXControlFactory(CurrentObject).MiscStatus));
  end;
end;

procedure TatAxCtrlsLibrary.__GetTActiveXControlFactoryToolboxBitmapID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActiveXControlFactory(CurrentObject).ToolboxBitmapID));
  end;
end;

procedure TatAxCtrlsLibrary.__TActiveFormControlFreeOnRelease(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActiveFormControl(CurrentObject).FreeOnRelease;
  end;
end;

procedure TatAxCtrlsLibrary.__TActiveFormControlInitializeControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActiveFormControl(CurrentObject).InitializeControl;
  end;
end;

procedure TatAxCtrlsLibrary.__TActiveFormControlObjQueryInterface(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(TActiveFormControl(CurrentObject).ObjQueryInterface(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatAxCtrlsLibrary.__GetTActiveFormActiveFormControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActiveForm(CurrentObject).ActiveFormControl));
  end;
end;

procedure TatAxCtrlsLibrary.__TPropertyPageCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPropertyPageClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAxCtrlsLibrary.__TPropertyPageDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPropertyPage(CurrentObject).Destroy;
  end;
end;

procedure TatAxCtrlsLibrary.__TPropertyPageModified(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPropertyPage(CurrentObject).Modified;
  end;
end;

procedure TatAxCtrlsLibrary.__TPropertyPageUpdateObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPropertyPage(CurrentObject).UpdateObject;
  end;
end;

procedure TatAxCtrlsLibrary.__TPropertyPageUpdatePropertyPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPropertyPage(CurrentObject).UpdatePropertyPage;
  end;
end;

procedure TatAxCtrlsLibrary.__TPropertyPageEnumCtlProps(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPropertyPage(CurrentObject).EnumCtlProps(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,TStrings(Integer(GetInputArg(1))));
  end;
end;

procedure TatAxCtrlsLibrary.__GetTPropertyPageOleObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TPropertyPage(CurrentObject).OleObject);
  end;
end;

procedure TatAxCtrlsLibrary.__GetTPropertyPageOleObjects(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPropertyPage(CurrentObject).OleObjects));
  end;
end;

procedure TatAxCtrlsLibrary.__SetTPropertyPageOleObjects(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPropertyPage(CurrentObject).OleObjects:=TInterfaceList(Integer(GetInputArg(0)));
  end;
end;

procedure TatAxCtrlsLibrary.__TPropertyPageImplInitPropertyPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPropertyPageImpl(CurrentObject).InitPropertyPage;
  end;
end;

procedure TatAxCtrlsLibrary.__GetTPropertyPageImplPropertyPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPropertyPageImpl(CurrentObject).PropertyPage));
  end;
end;

procedure TatAxCtrlsLibrary.__SetTPropertyPageImplPropertyPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPropertyPageImpl(CurrentObject).PropertyPage:=TPropertyPage(Integer(GetInputArg(0)));
  end;
end;

procedure TatAxCtrlsLibrary.__TActiveXPropertyPageDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActiveXPropertyPage(CurrentObject).Destroy;
  end;
end;

procedure TatAxCtrlsLibrary.__TActiveXPropertyPageInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActiveXPropertyPage(CurrentObject).Initialize;
  end;
end;

procedure TatAxCtrlsLibrary.__GetTActiveXPropertyPagePropertyPageImpl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActiveXPropertyPage(CurrentObject).PropertyPageImpl));
  end;
end;

procedure TatAxCtrlsLibrary.__TCustomAdapterCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomAdapterClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAxCtrlsLibrary.__TCustomAdapterDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomAdapter(CurrentObject).Destroy;
  end;
end;

procedure TatAxCtrlsLibrary.__TAdapterNotifierCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAdapterNotifierClass(CurrentClass.ClassRef).Create(TCustomAdapter(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAxCtrlsLibrary.__TFontAdapterCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFontAdapterClass(CurrentClass.ClassRef).Create(TFont(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAxCtrlsLibrary.__TPictureAdapterCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPictureAdapterClass(CurrentClass.ClassRef).Create(TPicture(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAxCtrlsLibrary.__TOleGraphicAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleGraphic(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatAxCtrlsLibrary.__TOleGraphicLoadFromFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleGraphic(CurrentObject).LoadFromFile(GetInputArg(0));
  end;
end;

procedure TatAxCtrlsLibrary.__TOleGraphicLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleGraphic(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatAxCtrlsLibrary.__TOleGraphicSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleGraphic(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatAxCtrlsLibrary.__TOleGraphicLoadFromClipboardFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleGraphic(CurrentObject).LoadFromClipboardFormat(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatAxCtrlsLibrary.__TOleGraphicSaveToClipboardFormat(AMachine: TatVirtualMachine);
  var
  Param0: Word;
  Param1: THandle;
  Param2: HPALETTE;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
    TOleGraphic(CurrentObject).SaveToClipboardFormat(Param0,Param1,Param2);
    SetInputArg(0,Integer(Param0));
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatAxCtrlsLibrary.__GetTOleGraphicMMHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TOleGraphic(CurrentObject).MMHeight));
  end;
end;

procedure TatAxCtrlsLibrary.__GetTOleGraphicMMWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TOleGraphic(CurrentObject).MMWidth));
  end;
end;

procedure TatAxCtrlsLibrary.__TStringsAdapterCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TStringsAdapterClass(CurrentClass.ClassRef).Create(TStrings(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAxCtrlsLibrary.__TReflectorWindowCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TReflectorWindowClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0)),TControl(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAxCtrlsLibrary.__ParkingWindow(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(AxCtrls.ParkingWindow);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAxCtrlsLibrary.__GetClass_DColorPropPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(AxCtrls.Class_DColorPropPage)));
  end;
end;

procedure TatAxCtrlsLibrary.__GetClass_DFontPropPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(AxCtrls.Class_DFontPropPage)));
  end;
end;

procedure TatAxCtrlsLibrary.__GetClass_DPicturePropPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(AxCtrls.Class_DPicturePropPage)));
  end;
end;

procedure TatAxCtrlsLibrary.__GetClass_DStringPropPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(AxCtrls.Class_DStringPropPage)));
  end;
end;

procedure TatAxCtrlsLibrary.Init;
begin
  With Scripter.DefineClass(TOleStream) do
  begin
    DefineMethod('Read',2,tkInteger,nil,__TOleStreamRead,false,0).SetVarArgs([0]);
    DefineMethod('Write',2,tkInteger,nil,__TOleStreamWrite,false,0);
    DefineMethod('Seek',2,tkInteger,nil,__TOleStreamSeek,false,0);
  end;
  With Scripter.DefineClass(TConnectionPoint) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TConnectionPointDestroy,false,0);
    DefineProp('SinkList',tkClass,__GetTConnectionPointSinkList,nil,TList,false,0);
  end;
  With Scripter.DefineClass(TConnectionPoints) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TConnectionPointsDestroy,false,0);
  end;
  With Scripter.DefineClass(TActiveXControl) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TActiveXControlDestroy,false,0);
    DefineMethod('Initialize',0,tkNone,nil,__TActiveXControlInitialize,false,0);
    DefineMethod('ObjQueryInterface',2,tkInteger,nil,__TActiveXControlObjQueryInterface,false,0).SetVarArgs([1]);
    DefineProp('Control',tkClass,__GetTActiveXControlControl,nil,TWinControl,false,0);
  end;
  With Scripter.DefineClass(TActiveXControlFactory) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TActiveXControlFactoryDestroy,false,0);
    DefineMethod('AddVerb',2,tkNone,nil,__TActiveXControlFactoryAddVerb,false,0);
    DefineMethod('UpdateRegistry',1,tkNone,nil,__TActiveXControlFactoryUpdateRegistry,false,0);
    DefineProp('MiscStatus',tkInteger,__GetTActiveXControlFactoryMiscStatus,nil,nil,false,0);
    DefineProp('ToolboxBitmapID',tkInteger,__GetTActiveXControlFactoryToolboxBitmapID,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TActiveFormControl) do
  begin
    DefineMethod('FreeOnRelease',0,tkNone,nil,__TActiveFormControlFreeOnRelease,false,0);
    DefineMethod('InitializeControl',0,tkNone,nil,__TActiveFormControlInitializeControl,false,0);
    DefineMethod('ObjQueryInterface',2,tkInteger,nil,__TActiveFormControlObjQueryInterface,false,0).SetVarArgs([1]);
  end;
  With Scripter.DefineClass(TActiveForm) do
  begin
    DefineProp('ActiveFormControl',tkClass,__GetTActiveFormActiveFormControl,nil,TActiveFormControl,false,0);
  end;
  With Scripter.DefineClass(TActiveFormFactory) do
  begin
  end;
  With Scripter.DefineClass(TPropertyPage) do
  begin
    DefineMethod('Create',1,tkClass,TPropertyPage,__TPropertyPageCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TPropertyPageDestroy,false,0);
    DefineMethod('Modified',0,tkNone,nil,__TPropertyPageModified,false,0);
    DefineMethod('UpdateObject',0,tkNone,nil,__TPropertyPageUpdateObject,false,0);
    DefineMethod('UpdatePropertyPage',0,tkNone,nil,__TPropertyPageUpdatePropertyPage,false,0);
    DefineMethod('EnumCtlProps',2,tkNone,nil,__TPropertyPageEnumCtlProps,false,0);
    DefineProp('OleObject',tkVariant,__GetTPropertyPageOleObject,nil,nil,false,0);
    DefineProp('OleObjects',tkClass,__GetTPropertyPageOleObjects,__SetTPropertyPageOleObjects,TInterfaceList,false,0);
  end;
  With Scripter.DefineClass(TPropertyPageImpl) do
  begin
    DefineMethod('InitPropertyPage',0,tkNone,nil,__TPropertyPageImplInitPropertyPage,false,0);
    DefineProp('PropertyPage',tkClass,__GetTPropertyPageImplPropertyPage,__SetTPropertyPageImplPropertyPage,TPropertyPage,false,0);
  end;
  With Scripter.DefineClass(TActiveXPropertyPage) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TActiveXPropertyPageDestroy,false,0);
    DefineMethod('Initialize',0,tkNone,nil,__TActiveXPropertyPageInitialize,false,0);
    DefineProp('PropertyPageImpl',tkClass,__GetTActiveXPropertyPagePropertyPageImpl,nil,TPropertyPageImpl,false,0);
  end;
  With Scripter.DefineClass(TActiveXPropertyPageFactory) do
  begin
  end;
  With Scripter.DefineClass(TCustomAdapter) do
  begin
    DefineMethod('Create',0,tkClass,TCustomAdapter,__TCustomAdapterCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomAdapterDestroy,false,0);
  end;
  With Scripter.DefineClass(TAdapterNotifier) do
  begin
    DefineMethod('Create',1,tkClass,TAdapterNotifier,__TAdapterNotifierCreate,true,0);
  end;
  With Scripter.DefineClass(TFontAdapter) do
  begin
    DefineMethod('Create',1,tkClass,TFontAdapter,__TFontAdapterCreate,true,0);
  end;
  With Scripter.DefineClass(TPictureAdapter) do
  begin
    DefineMethod('Create',1,tkClass,TPictureAdapter,__TPictureAdapterCreate,true,0);
  end;
  With Scripter.DefineClass(TOleGraphic) do
  begin
    DefineMethod('Assign',1,tkNone,nil,__TOleGraphicAssign,false,0);
    DefineMethod('LoadFromFile',1,tkNone,nil,__TOleGraphicLoadFromFile,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TOleGraphicLoadFromStream,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TOleGraphicSaveToStream,false,0);
    DefineMethod('LoadFromClipboardFormat',3,tkNone,nil,__TOleGraphicLoadFromClipboardFormat,false,0);
    DefineMethod('SaveToClipboardFormat',3,tkNone,nil,__TOleGraphicSaveToClipboardFormat,false,0).SetVarArgs([0,1,2]);
    DefineProp('MMHeight',tkInteger,__GetTOleGraphicMMHeight,nil,nil,false,0);
    DefineProp('MMWidth',tkInteger,__GetTOleGraphicMMWidth,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TStringsAdapter) do
  begin
    DefineMethod('Create',1,tkClass,TStringsAdapter,__TStringsAdapterCreate,true,0);
  end;
  With Scripter.DefineClass(TReflectorWindow) do
  begin
    DefineMethod('Create',2,tkClass,TReflectorWindow,__TReflectorWindowCreate,true,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('ParkingWindow',0,tkInteger,nil,__ParkingWindow,false,0);
    DefineProp('Class_DColorPropPage',tkVariant,__GetClass_DColorPropPage,nil,nil,false,0);
    DefineProp('Class_DFontPropPage',tkVariant,__GetClass_DFontPropPage,nil,nil,false,0);
    DefineProp('Class_DPicturePropPage',tkVariant,__GetClass_DPicturePropPage,nil,nil,false,0);
    DefineProp('Class_DStringPropPage',tkVariant,__GetClass_DStringPropPage,nil,nil,false,0);
    AddConstant('ckSingle',ckSingle);
    AddConstant('ckMulti',ckMulti);
  end;
end;

class function TatAxCtrlsLibrary.LibraryName: string;
begin
  result := 'AxCtrls';
end;

initialization
  RegisterScripterLibrary(TatAxCtrlsLibrary, True);

{$WARNINGS ON}

end.

