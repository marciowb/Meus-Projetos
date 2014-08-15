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
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatContnrsLibrary = class(TatScripterLibrary)
    procedure __TObjectListCreate(AMachine: TatVirtualMachine);
    procedure __TObjectListAdd(AMachine: TatVirtualMachine);
    procedure __TObjectListExtract(AMachine: TatVirtualMachine);
    procedure __TObjectListExtractItem(AMachine: TatVirtualMachine);
    procedure __TObjectListRemove(AMachine: TatVirtualMachine);
    procedure __TObjectListRemoveItem(AMachine: TatVirtualMachine);
    procedure __TObjectListIndexOf(AMachine: TatVirtualMachine);
    procedure __TObjectListIndexOfItem(AMachine: TatVirtualMachine);
    procedure __TObjectListInsert(AMachine: TatVirtualMachine);
    procedure __TObjectListFirst(AMachine: TatVirtualMachine);
    procedure __TObjectListLast(AMachine: TatVirtualMachine);
    procedure __GetTObjectListOwnsObjects(AMachine: TatVirtualMachine);
    procedure __SetTObjectListOwnsObjects(AMachine: TatVirtualMachine);
    procedure __GetTObjectListItems(AMachine: TatVirtualMachine);
    procedure __SetTObjectListItems(AMachine: TatVirtualMachine);
    procedure __TComponentListDestroy(AMachine: TatVirtualMachine);
    procedure __TComponentListAdd(AMachine: TatVirtualMachine);
    procedure __TComponentListExtract(AMachine: TatVirtualMachine);
    procedure __TComponentListExtractItem(AMachine: TatVirtualMachine);
    procedure __TComponentListRemove(AMachine: TatVirtualMachine);
    procedure __TComponentListRemoveItem(AMachine: TatVirtualMachine);
    procedure __TComponentListIndexOf(AMachine: TatVirtualMachine);
    procedure __TComponentListIndexOfItem(AMachine: TatVirtualMachine);
    procedure __TComponentListFirst(AMachine: TatVirtualMachine);
    procedure __TComponentListLast(AMachine: TatVirtualMachine);
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
    procedure __TCustomBucketListDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomBucketListClear(AMachine: TatVirtualMachine);
    procedure __TCustomBucketListAssign(AMachine: TatVirtualMachine);
    procedure __TBucketListCreate(AMachine: TatVirtualMachine);
    procedure __TObjectBucketListAdd(AMachine: TatVirtualMachine);
    procedure __TObjectBucketListRemove(AMachine: TatVirtualMachine);
    procedure __GetTObjectBucketListData(AMachine: TatVirtualMachine);
    procedure __SetTObjectBucketListData(AMachine: TatVirtualMachine);
    procedure __TIntegerBucketListAdd(AMachine: TatVirtualMachine);
    procedure __TIntegerBucketListRemove(AMachine: TatVirtualMachine);
    procedure __GetTIntegerBucketListData(AMachine: TatVirtualMachine);
    procedure __SetTIntegerBucketListData(AMachine: TatVirtualMachine);
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
  TCustomBucketListClass = class of TCustomBucketList;
  TBucketListClass = class of TBucketList;
  TObjectBucketListClass = class of TObjectBucketList;
  TIntegerBucketListClass = class of TIntegerBucketList;


  TBucketItemWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TBucketItem);
    function ObjToRec: TBucketItem;
  published
  end;
  
  TBucketWrapper = class(TatRecordWrapper)
  private
    FCount: Integer;
  public
    constructor Create(ARecord: TBucket);
    function ObjToRec: TBucket;
  published
    property Count: Integer read FCount write FCount;
  end;
  

implementation

constructor TBucketItemWrapper.Create(ARecord: TBucketItem);
begin
  inherited Create;
end;

function TBucketItemWrapper.ObjToRec: TBucketItem;
begin
end;

constructor TBucketWrapper.Create(ARecord: TBucket);
begin
  inherited Create;
  FCount := ARecord.Count;
end;

function TBucketWrapper.ObjToRec: TBucket;
begin
  result.Count := FCount;
end;



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
AResult := Integer(TObjectList(CurrentObject).Add(TObject(integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectListExtract(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TObjectList(CurrentObject).Extract(TObject(integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectListExtractItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TObjectList(CurrentObject).ExtractItem(TObject(integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectListRemove(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TObjectList(CurrentObject).Remove(TObject(integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectListRemoveItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TObjectList(CurrentObject).RemoveItem(TObject(integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectListIndexOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TObjectList(CurrentObject).IndexOf(TObject(integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectListIndexOfItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TObjectList(CurrentObject).IndexOfItem(TObject(integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectListInsert(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TObjectList(CurrentObject).Insert(VarToInteger(GetInputArg(0)),TObject(integer(GetInputArg(1))));
  end;
end;

procedure TatContnrsLibrary.__TObjectListFirst(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TObjectList(CurrentObject).First);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectListLast(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TObjectList(CurrentObject).Last);
    ReturnOutputArg(AResult);
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
    ReturnOutputArg(integer(TObjectList(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatContnrsLibrary.__SetTObjectListItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TObjectList(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TObject(integer(GetInputArg(0)));
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

procedure TatContnrsLibrary.__TComponentListExtract(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComponentList(CurrentObject).Extract(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TComponentListExtractItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComponentList(CurrentObject).ExtractItem(TComponent(Integer(GetInputArg(0))),GetInputArg(1)));
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

procedure TatContnrsLibrary.__TComponentListRemoveItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComponentList(CurrentObject).RemoveItem(TComponent(Integer(GetInputArg(0))),GetInputArg(1)));
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

procedure TatContnrsLibrary.__TComponentListIndexOfItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComponentList(CurrentObject).IndexOfItem(TComponent(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TComponentListFirst(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComponentList(CurrentObject).First);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TComponentListLast(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComponentList(CurrentObject).Last);
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
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TObjectStack(CurrentObject).Push(TObject(integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectStackPop(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TObjectStack(CurrentObject).Pop);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectStackPeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TObjectStack(CurrentObject).Peek);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectQueuePush(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TObjectQueue(CurrentObject).Push(TObject(integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectQueuePop(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TObjectQueue(CurrentObject).Pop);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectQueuePeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TObjectQueue(CurrentObject).Peek);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TCustomBucketListDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomBucketList(CurrentObject).Destroy;
  end;
end;

procedure TatContnrsLibrary.__TCustomBucketListClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomBucketList(CurrentObject).Clear;
  end;
end;

procedure TatContnrsLibrary.__TCustomBucketListAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomBucketList(CurrentObject).Assign(TCustomBucketList(Integer(GetInputArg(0))));
  end;
end;

procedure TatContnrsLibrary.__TBucketListCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := Integer(TBucketListClass(CurrentClass.ClassRef).Create);
1: AResult := Integer(TBucketListClass(CurrentClass.ClassRef).Create(GetInputArg(0)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectBucketListAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TObjectBucketList(CurrentObject).Add(TObject(integer(GetInputArg(0))),TObject(integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TObjectBucketListRemove(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TObjectBucketList(CurrentObject).Remove(TObject(integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__GetTObjectBucketListData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TObjectBucketList(CurrentObject).Data[TObject(integer(GetArrayIndex(0)))]));
  end;
end;

procedure TatContnrsLibrary.__SetTObjectBucketListData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TObjectBucketList(CurrentObject).Data[TObject(integer(GetArrayIndex(0)))]:=TObject(integer(GetInputArg(0)));
  end;
end;

procedure TatContnrsLibrary.__TIntegerBucketListAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIntegerBucketList(CurrentObject).Add(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__TIntegerBucketListRemove(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIntegerBucketList(CurrentObject).Remove(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatContnrsLibrary.__GetTIntegerBucketListData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIntegerBucketList(CurrentObject).Data[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatContnrsLibrary.__SetTIntegerBucketListData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIntegerBucketList(CurrentObject).Data[VarToInteger(GetArrayIndex(0))]:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatContnrsLibrary.Init;
begin
  With Scripter.DefineClass(TObjectList) do
  begin
    DefineMethod('Create',0,tkClass,TObjectList,__TObjectListCreate,true,0);
    DefineMethod('Add',1,tkInteger,nil,__TObjectListAdd,false,0);
    DefineMethod('Extract',1,tkVariant,nil,__TObjectListExtract,false,0);
    DefineMethod('ExtractItem',2,tkVariant,nil,__TObjectListExtractItem,false,0);
    DefineMethod('Remove',1,tkInteger,nil,__TObjectListRemove,false,0);
    DefineMethod('RemoveItem',2,tkInteger,nil,__TObjectListRemoveItem,false,0);
    DefineMethod('IndexOf',1,tkInteger,nil,__TObjectListIndexOf,false,0);
    DefineMethod('IndexOfItem',2,tkInteger,nil,__TObjectListIndexOfItem,false,0);
    DefineMethod('Insert',2,tkNone,nil,__TObjectListInsert,false,0);
    DefineMethod('First',0,tkVariant,nil,__TObjectListFirst,false,0);
    DefineMethod('Last',0,tkVariant,nil,__TObjectListLast,false,0);
    DefineProp('OwnsObjects',tkVariant,__GetTObjectListOwnsObjects,__SetTObjectListOwnsObjects,nil,false,0);
    DefaultProperty := DefineProp('Items',tkVariant,__GetTObjectListItems,__SetTObjectListItems,nil,false,1);
  end;
  With Scripter.DefineClass(TComponentList) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TComponentListDestroy,false,0);
    DefineMethod('Add',1,tkInteger,nil,__TComponentListAdd,false,0);
    DefineMethod('Extract',1,tkClass,TComponent,__TComponentListExtract,false,0);
    DefineMethod('ExtractItem',2,tkClass,TComponent,__TComponentListExtractItem,false,0);
    DefineMethod('Remove',1,tkInteger,nil,__TComponentListRemove,false,0);
    DefineMethod('RemoveItem',2,tkInteger,nil,__TComponentListRemoveItem,false,0);
    DefineMethod('IndexOf',1,tkInteger,nil,__TComponentListIndexOf,false,0);
    DefineMethod('IndexOfItem',2,tkInteger,nil,__TComponentListIndexOfItem,false,0);
    DefineMethod('First',0,tkClass,TComponent,__TComponentListFirst,false,0);
    DefineMethod('Last',0,tkClass,TComponent,__TComponentListLast,false,0);
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
    DefineMethod('Push',1,tkVariant,nil,__TObjectStackPush,false,0);
    DefineMethod('Pop',0,tkVariant,nil,__TObjectStackPop,false,0);
    DefineMethod('Peek',0,tkVariant,nil,__TObjectStackPeek,false,0);
  end;
  With Scripter.DefineClass(TQueue) do
  begin
  end;
  With Scripter.DefineClass(TObjectQueue) do
  begin
    DefineMethod('Push',1,tkVariant,nil,__TObjectQueuePush,false,0);
    DefineMethod('Pop',0,tkVariant,nil,__TObjectQueuePop,false,0);
    DefineMethod('Peek',0,tkVariant,nil,__TObjectQueuePeek,false,0);
  end;
  With Scripter.DefineClass(TCustomBucketList) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TCustomBucketListDestroy,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TCustomBucketListClear,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TCustomBucketListAssign,false,0);
  end;
  With Scripter.DefineClass(TBucketList) do
  begin
    DefineMethod('Create',1,tkClass,TBucketList,__TBucketListCreate,true,1);
  end;
  With Scripter.DefineClass(TObjectBucketList) do
  begin
    DefineMethod('Add',2,tkVariant,nil,__TObjectBucketListAdd,false,0);
    DefineMethod('Remove',1,tkVariant,nil,__TObjectBucketListRemove,false,0);
    DefaultProperty := DefineProp('Data',tkVariant,__GetTObjectBucketListData,__SetTObjectBucketListData,nil,false,1);
  end;
  With Scripter.DefineClass(TIntegerBucketList) do
  begin
    DefineMethod('Add',2,tkInteger,nil,__TIntegerBucketListAdd,false,0);
    DefineMethod('Remove',1,tkInteger,nil,__TIntegerBucketListRemove,false,0);
    DefaultProperty := DefineProp('Data',tkInteger,__GetTIntegerBucketListData,__SetTIntegerBucketListData,nil,false,1);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('bl2',bl2);
    AddConstant('bl4',bl4);
    AddConstant('bl8',bl8);
    AddConstant('bl16',bl16);
    AddConstant('bl32',bl32);
    AddConstant('bl64',bl64);
    AddConstant('bl128',bl128);
    AddConstant('bl256',bl256);
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

