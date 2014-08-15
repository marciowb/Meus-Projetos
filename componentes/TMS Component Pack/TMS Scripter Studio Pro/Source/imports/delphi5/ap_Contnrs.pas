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
unit ap_Contnrs;

interface

uses
  SysUtils,
  Classes,
  Contnrs,
  atScript;

{$WARNINGS OFF}

type
  TatContnrsLibrary = class(TatScripterLibrary)
    procedure __TObjectListCreate(AMachine: TatVirtualMachine);
    procedure __TObjectListAdd(AMachine: TatVirtualMachine);
    procedure __TObjectListRemove(AMachine: TatVirtualMachine);
    procedure __TObjectListIndexOf(AMachine: TatVirtualMachine);
    procedure __TObjectListInsert(AMachine: TatVirtualMachine);
    procedure __GetTObjectListOwnsObjects(AMachine: TatVirtualMachine);
    procedure __SetTObjectListOwnsObjects(AMachine: TatVirtualMachine);
    procedure __GetTObjectListItems(AMachine: TatVirtualMachine);
    procedure __SetTObjectListItems(AMachine: TatVirtualMachine);
    procedure __TComponentListDestroy(AMachine: TatVirtualMachine);
    procedure __TComponentListAdd(AMachine: TatVirtualMachine);
    procedure __TComponentListRemove(AMachine: TatVirtualMachine);
    procedure __TComponentListIndexOf(AMachine: TatVirtualMachine);
    procedure __TComponentListInsert(AMachine: TatVirtualMachine);
    procedure __GetTComponentListItems(AMachine: TatVirtualMachine);
    procedure __SetTComponentListItems(AMachine: TatVirtualMachine);
    procedure __TOrderedListCreate(AMachine: TatVirtualMachine);
    procedure __TOrderedListDestroy(AMachine: TatVirtualMachine);
    procedure __TOrderedListCount(AMachine: TatVirtualMachine);
    procedure __TOrderedListAtLeast(AMachine: TatVirtualMachine);
    procedure __TObjectStackPush(AMachine: TatVirtualMachine);
    procedure __TObjectStackPop(AMachine: TatVirtualMachine);
    procedure __TObjectStackPeek(AMachine: TatVirtualMachine);
    procedure __TObjectQueuePush(AMachine: TatVirtualMachine);
    procedure __TObjectQueuePop(AMachine: TatVirtualMachine);
    procedure __TObjectQueuePeek(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TObjectListClass = class of TObjectList;
  TComponentListClass = class of TComponentList;
  TClassListClass = class of TClassList;
  TOrderedListClass = class of TOrderedList;
  TStackClass = class of TStack;
  TObjectStackClass = class of TObjectStack;
  TQueueClass = class of TQueue;
  TObjectQueueClass = class of TObjectQueue;



implementation



procedure TatContnrsLibrary.__TObjectListCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TObjectListClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectListAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TObjectList(CurrentObject).Add(TObject(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectListRemove(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TObjectList(CurrentObject).Remove(TObject(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectListIndexOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TObjectList(CurrentObject).IndexOf(TObject(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectListInsert(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TObjectList(CurrentObject).Insert(VarToInteger(GetInputArg(0)),TObject(Integer(GetInputArg(1))));
  end;
end;

procedure TatContnrsLibrary.__GetTObjectListOwnsObjects(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TObjectList(CurrentObject).OwnsObjects);
  end;
end;

procedure TatContnrsLibrary.__SetTObjectListOwnsObjects(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TObjectList(CurrentObject).OwnsObjects:=GetInputArg(0);
  end;
end;

procedure TatContnrsLibrary.__GetTObjectListItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TObjectList(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatContnrsLibrary.__SetTObjectListItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TObjectList(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TObject(Integer(GetInputArg(0)));
  end;
end;

procedure TatContnrsLibrary.__TComponentListDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComponentList(CurrentObject).Destroy;
  end;
end;

procedure TatContnrsLibrary.__TComponentListAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComponentList(CurrentObject).Add(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TComponentListRemove(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComponentList(CurrentObject).Remove(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TComponentListIndexOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComponentList(CurrentObject).IndexOf(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TComponentListInsert(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComponentList(CurrentObject).Insert(VarToInteger(GetInputArg(0)),TComponent(Integer(GetInputArg(1))));
  end;
end;

procedure TatContnrsLibrary.__GetTComponentListItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TComponentList(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatContnrsLibrary.__SetTComponentListItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComponentList(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TComponent(Integer(GetInputArg(0)));
  end;
end;

procedure TatContnrsLibrary.__TOrderedListCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOrderedListClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TOrderedListDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOrderedList(CurrentObject).Destroy;
  end;
end;

procedure TatContnrsLibrary.__TOrderedListCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOrderedList(CurrentObject).Count);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TOrderedListAtLeast(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TOrderedList(CurrentObject).AtLeast(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectStackPush(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TObjectStack(CurrentObject).Push(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatContnrsLibrary.__TObjectStackPop(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TObjectStack(CurrentObject).Pop);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectStackPeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TObjectStack(CurrentObject).Peek);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectQueuePush(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TObjectQueue(CurrentObject).Push(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatContnrsLibrary.__TObjectQueuePop(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TObjectQueue(CurrentObject).Pop);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectQueuePeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TObjectQueue(CurrentObject).Peek);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.Init;
begin
  With Scripter.DefineClass(TObjectList) do
  begin
    DefineMethod('Create',0,tkClass,TObjectList,__TObjectListCreate,true,0);
    DefineMethod('Add',1,tkInteger,nil,__TObjectListAdd,false,0);
    DefineMethod('Remove',1,tkInteger,nil,__TObjectListRemove,false,0);
    DefineMethod('IndexOf',1,tkInteger,nil,__TObjectListIndexOf,false,0);
    DefineMethod('Insert',2,tkNone,nil,__TObjectListInsert,false,0);
    DefineProp('OwnsObjects',tkVariant,__GetTObjectListOwnsObjects,__SetTObjectListOwnsObjects,nil,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTObjectListItems,__SetTObjectListItems,TObject,false,1);
  end;
  With Scripter.DefineClass(TComponentList) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TComponentListDestroy,false,0);
    DefineMethod('Add',1,tkInteger,nil,__TComponentListAdd,false,0);
    DefineMethod('Remove',1,tkInteger,nil,__TComponentListRemove,false,0);
    DefineMethod('IndexOf',1,tkInteger,nil,__TComponentListIndexOf,false,0);
    DefineMethod('Insert',2,tkNone,nil,__TComponentListInsert,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTComponentListItems,__SetTComponentListItems,TComponent,false,1);
  end;
  With Scripter.DefineClass(TClassList) do
  begin
  end;
  With Scripter.DefineClass(TOrderedList) do
  begin
    DefineMethod('Create',0,tkClass,TOrderedList,__TOrderedListCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TOrderedListDestroy,false,0);
    DefineMethod('Count',0,tkInteger,nil,__TOrderedListCount,false,0);
    DefineMethod('AtLeast',1,tkVariant,nil,__TOrderedListAtLeast,false,0);
  end;
  With Scripter.DefineClass(TStack) do
  begin
  end;
  With Scripter.DefineClass(TObjectStack) do
  begin
    DefineMethod('Push',1,tkNone,nil,__TObjectStackPush,false,0);
    DefineMethod('Pop',0,tkClass,TObject,__TObjectStackPop,false,0);
    DefineMethod('Peek',0,tkClass,TObject,__TObjectStackPeek,false,0);
  end;
  With Scripter.DefineClass(TQueue) do
  begin
  end;
  With Scripter.DefineClass(TObjectQueue) do
  begin
    DefineMethod('Push',1,tkNone,nil,__TObjectQueuePush,false,0);
    DefineMethod('Pop',0,tkClass,TObject,__TObjectQueuePop,false,0);
    DefineMethod('Peek',0,tkClass,TObject,__TObjectQueuePeek,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatContnrsLibrary.LibraryName: string;
begin
  result := 'Contnrs';
end;

initialization
  RegisterScripterLibrary(TatContnrsLibrary, True);

{$WARNINGS ON}

end.

