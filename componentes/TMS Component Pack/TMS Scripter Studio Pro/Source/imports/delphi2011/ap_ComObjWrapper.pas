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
unit ap_ComObjWrapper;

interface

uses
  Windows,
  SysUtils,
  Classes,
  ComObj,
  ActiveX,
  ComObjWrapper,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatComObjWrapperLibrary = class(TatScripterLibrary)
    procedure __TComComponentCreate(AMachine: TatVirtualMachine);
    procedure __TComComponentDestroy(AMachine: TatVirtualMachine);
    procedure __TComComponentCreateObject(AMachine: TatVirtualMachine);
    procedure __GetTComComponentDescription(AMachine: TatVirtualMachine);
    procedure __SetTComComponentDescription(AMachine: TatVirtualMachine);
    procedure __GetTComComponentGUID(AMachine: TatVirtualMachine);
    procedure __SetTComComponentGUID(AMachine: TatVirtualMachine);
    procedure __TWrappedComObjectDestroy(AMachine: TatVirtualMachine);
    procedure __TWrappedComObjectAfterConstruction(AMachine: TatVirtualMachine);
    procedure __TWrappedComObjectInitialize(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TComComponentClass = class of TComComponent;
  TWrappedComObjectClass = class of TWrappedComObject;

  TatComObjWrapperDispatcher = class(TatEventDispatcher)
  private
    procedure __TComObjectEvent( Sender: TComComponent; const ComObject: TWrappedComObject);
  end;


implementation



procedure TatComObjWrapperLibrary.__TComComponentCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComComponentClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjWrapperLibrary.__TComComponentDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComComponent(CurrentObject).Destroy;
  end;
end;

procedure TatComObjWrapperLibrary.__TComComponentCreateObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TComComponent(CurrentObject).CreateObject;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjWrapperLibrary.__GetTComComponentDescription(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComComponent(CurrentObject).Description);
  end;
end;

procedure TatComObjWrapperLibrary.__SetTComComponentDescription(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComComponent(CurrentObject).Description:=GetInputArg(0);
  end;
end;

procedure TatComObjWrapperLibrary.__GetTComComponentGUID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComComponent(CurrentObject).GUID);
  end;
end;

procedure TatComObjWrapperLibrary.__SetTComComponentGUID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComComponent(CurrentObject).GUID:=GetInputArg(0);
  end;
end;

procedure TatComObjWrapperLibrary.__TWrappedComObjectDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWrappedComObject(CurrentObject).Destroy;
  end;
end;

procedure TatComObjWrapperLibrary.__TWrappedComObjectAfterConstruction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWrappedComObject(CurrentObject).AfterConstruction;
  end;
end;

procedure TatComObjWrapperLibrary.__TWrappedComObjectInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWrappedComObject(CurrentObject).Initialize;
  end;
end;

procedure TatComObjWrapperDispatcher.__TComObjectEvent( Sender: TComComponent; const ComObject: TWrappedComObject);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TComObjectEvent(BeforeCall)(Sender,ComObject);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ComObject]);
    if AssignedMethod(AfterCall) then
      TComObjectEvent(AfterCall)(Sender,ComObject);
  end;
end;

procedure TatComObjWrapperLibrary.Init;
begin
  With Scripter.DefineClass(TComComponent) do
  begin
    DefineMethod('Create',1,tkClass,TComComponent,__TComComponentCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TComComponentDestroy,false,0);
    DefineMethod('CreateObject',0,tkVariant,nil,__TComComponentCreateObject,false,0);
    DefineProp('Description',tkVariant,__GetTComComponentDescription,__SetTComComponentDescription,nil,false,0);
    DefineProp('GUID',tkVariant,__GetTComComponentGUID,__SetTComComponentGUID,nil,false,0);
  end;
  With Scripter.DefineClass(TWrappedComObject) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TWrappedComObjectDestroy,false,0);
    DefineMethod('AfterConstruction',0,tkNone,nil,__TWrappedComObjectAfterConstruction,false,0);
    DefineMethod('Initialize',0,tkNone,nil,__TWrappedComObjectInitialize,false,0);
  end;
  DefineEventAdapter(TypeInfo(TComObjectEvent), TatComObjWrapperDispatcher, @TatComObjWrapperDispatcher.__TComObjectEvent);
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatComObjWrapperLibrary.LibraryName: string;
begin
  result := 'ComObjWrapper';
end;

initialization
  RegisterScripterLibrary(TatComObjWrapperLibrary, True);

{$WARNINGS ON}

end.

