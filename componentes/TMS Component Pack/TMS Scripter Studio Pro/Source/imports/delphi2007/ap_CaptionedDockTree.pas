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
unit ap_CaptionedDockTree;

interface

uses
  Windows,
  Controls,
  Graphics,
  Messages,
  SysUtils,
  CaptionedDockTree,
  Variants,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatCaptionedDockTreeLibrary = class(TatScripterLibrary)
    procedure __TDockCaptionDrawerDrawDockCaption(AMachine: TatVirtualMachine);
    procedure __TDockCaptionDrawerDockCaptionHitTest(AMachine: TatVirtualMachine);
    procedure __TDockCaptionDrawerCreate(AMachine: TatVirtualMachine);
    procedure __GetTDockCaptionDrawerDockCaptionPinButton(AMachine: TatVirtualMachine);
    procedure __SetTDockCaptionDrawerDockCaptionPinButton(AMachine: TatVirtualMachine);
    procedure __TCaptionedDockTreeCreate(AMachine: TatVirtualMachine);
    procedure __TCaptionedDockTreeDestroy(AMachine: TatVirtualMachine);
    procedure __TCaptionedDockTreeGetParentFormState(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TDockCaptionDrawerClass = class of TDockCaptionDrawer;
  TCaptionedDockTreeClass = class of TCaptionedDockTree;


  TParentFormStateWrapper = class(TatRecordWrapper)
  private
    FCaption: string;
    FStartColor: TColor;
    FEndColor: TColor;
    FFontColor: TColor;
    FFocused: Boolean;
    FIcon: TIcon;
  public
    constructor Create(ARecord: TParentFormState);
    function ObjToRec: TParentFormState;
  published
    property Caption: string read FCaption write FCaption;
    property StartColor: TColor read FStartColor write FStartColor;
    property EndColor: TColor read FEndColor write FEndColor;
    property FontColor: TColor read FFontColor write FFontColor;
    property Focused: Boolean read FFocused write FFocused;
    property Icon: TIcon read FIcon write FIcon;
  end;
  

implementation

constructor TParentFormStateWrapper.Create(ARecord: TParentFormState);
begin
  inherited Create;
  FCaption := ARecord.Caption;
  FStartColor := ARecord.StartColor;
  FEndColor := ARecord.EndColor;
  FFontColor := ARecord.FontColor;
  FFocused := ARecord.Focused;
  FIcon := ARecord.Icon;
end;

function TParentFormStateWrapper.ObjToRec: TParentFormState;
begin
  result.Caption := FCaption;
  result.StartColor := FStartColor;
  result.EndColor := FEndColor;
  result.FontColor := FFontColor;
  result.Focused := FFocused;
  result.Icon := FIcon;
end;



procedure TatCaptionedDockTreeLibrary.__TDockCaptionDrawerDrawDockCaption(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDockCaptionDrawer(CurrentObject).DrawDockCaption(TCanvas(Integer(GetInputArg(0))),TRectWrapper(integer(GetInputArg(1))).ObjToRec,TParentFormStateWrapper(integer(GetInputArg(2))).ObjToRec);
  end;
end;

procedure TatCaptionedDockTreeLibrary.__TDockCaptionDrawerDockCaptionHitTest(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDockCaptionDrawer(CurrentObject).DockCaptionHitTest(TRectWrapper(integer(GetInputArg(0))).ObjToRec,TPointWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCaptionedDockTreeLibrary.__TDockCaptionDrawerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDockCaptionDrawerClass(CurrentClass.ClassRef).Create(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCaptionedDockTreeLibrary.__GetTDockCaptionDrawerDockCaptionPinButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDockCaptionDrawer(CurrentObject).DockCaptionPinButton);
  end;
end;

procedure TatCaptionedDockTreeLibrary.__SetTDockCaptionDrawerDockCaptionPinButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDockCaptionDrawer(CurrentObject).DockCaptionPinButton:=GetInputArg(0);
  end;
end;

procedure TatCaptionedDockTreeLibrary.__TCaptionedDockTreeCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCaptionedDockTreeClass(CurrentClass.ClassRef).Create(TWinControl(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCaptionedDockTreeLibrary.__TCaptionedDockTreeDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCaptionedDockTree(CurrentObject).Destroy;
  end;
end;

procedure TatCaptionedDockTreeLibrary.__TCaptionedDockTreeGetParentFormState(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TParentFormStateWrapper.Create(TCaptionedDockTreeClass(CurrentClass.ClassRef).GetParentFormState(TControl(Integer(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCaptionedDockTreeLibrary.Init;
begin
  With Scripter.DefineClass(TDockCaptionDrawer) do
  begin
    DefineMethod('DrawDockCaption',3,tkNone,nil,__TDockCaptionDrawerDrawDockCaption,false,0);
    DefineMethod('DockCaptionHitTest',2,tkInteger,nil,__TDockCaptionDrawerDockCaptionHitTest,false,0);
    DefineMethod('Create',1,tkClass,TDockCaptionDrawer,__TDockCaptionDrawerCreate,true,0);
    DefineProp('DockCaptionPinButton',tkEnumeration,__GetTDockCaptionDrawerDockCaptionPinButton,__SetTDockCaptionDrawerDockCaptionPinButton,nil,false,0);
  end;
  With Scripter.DefineClass(TCaptionedDockTree) do
  begin
    DefineMethod('Create',1,tkClass,TCaptionedDockTree,__TCaptionedDockTreeCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCaptionedDockTreeDestroy,false,0);
    DefineMethod('GetParentFormState',1,tkVariant,nil,__TCaptionedDockTreeGetParentFormState,true,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('dcoHorizontal',dcoHorizontal);
    AddConstant('dcoVertical',dcoVertical);
    AddConstant('dcpbNone',dcpbNone);
    AddConstant('dcpbUp',dcpbUp);
    AddConstant('dcpbDown',dcpbDown);
    AddConstant('dchtNone',dchtNone);
    AddConstant('dchtCaption',dchtCaption);
    AddConstant('dchtClose',dchtClose);
    AddConstant('dchtPin',dchtPin);
    AddConstant('dchtCustom',dchtCustom);
  end;
end;

class function TatCaptionedDockTreeLibrary.LibraryName: string;
begin
  result := 'CaptionedDockTree';
end;

initialization
  RegisterScripterLibrary(TatCaptionedDockTreeLibrary, True);

{$WARNINGS ON}

end.

