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
unit ap_Outline;

interface

uses
  Windows,
  Messages,
  Forms,
  Classes,
  Graphics,
  Menus,
  StdCtrls,
  Grids,
  Controls,
  SysUtils,
  {$WARNINGS OFF}
  Outline,
  {$WARNINGS ON}
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatOutlineLibrary = class(TatScripterLibrary)
    procedure __TOutlineNodeCreate(AMachine: TatVirtualMachine);
    procedure __TOutlineNodeDestroy(AMachine: TatVirtualMachine);
    procedure __TOutlineNodeChangeLevelBy(AMachine: TatVirtualMachine);
    procedure __TOutlineNodeCollapse(AMachine: TatVirtualMachine);
    procedure __TOutlineNodeExpand(AMachine: TatVirtualMachine);
    procedure __TOutlineNodeFullExpand(AMachine: TatVirtualMachine);
    procedure __TOutlineNodeGetDisplayWidth(AMachine: TatVirtualMachine);
    procedure __TOutlineNodegetFirstChild(AMachine: TatVirtualMachine);
    procedure __TOutlineNodeGetLastChild(AMachine: TatVirtualMachine);
    procedure __TOutlineNodeGetNextChild(AMachine: TatVirtualMachine);
    procedure __TOutlineNodeGetPrevChild(AMachine: TatVirtualMachine);
    procedure __TOutlineNodeMoveTo(AMachine: TatVirtualMachine);
    procedure __GetTOutlineNodeParent(AMachine: TatVirtualMachine);
    procedure __GetTOutlineNodeExpanded(AMachine: TatVirtualMachine);
    procedure __SetTOutlineNodeExpanded(AMachine: TatVirtualMachine);
    procedure __GetTOutlineNodeText(AMachine: TatVirtualMachine);
    procedure __SetTOutlineNodeText(AMachine: TatVirtualMachine);
    procedure __GetTOutlineNodeIndex(AMachine: TatVirtualMachine);
    procedure __GetTOutlineNodeLevel(AMachine: TatVirtualMachine);
    procedure __SetTOutlineNodeLevel(AMachine: TatVirtualMachine);
    procedure __GetTOutlineNodeHasItems(AMachine: TatVirtualMachine);
    procedure __GetTOutlineNodeIsVisible(AMachine: TatVirtualMachine);
    procedure __GetTOutlineNodeTopItem(AMachine: TatVirtualMachine);
    procedure __GetTOutlineNodeFullPath(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineCreate(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineAdd(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineAddChild(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineInsert(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineDelete(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineGetItem(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineGetNodeDisplayWidth(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineGetTextItem(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineGetVisibleNode(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineFullExpand(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineFullCollapse(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineLoadFromFile(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineSaveToFile(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineSaveToStream(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineBeginUpdate(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineEndUpdate(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineSetUpdateState(AMachine: TatVirtualMachine);
    procedure __TCustomOutlineClear(AMachine: TatVirtualMachine);
    procedure __GetTCustomOutlineItemCount(AMachine: TatVirtualMachine);
    procedure __GetTCustomOutlineItems(AMachine: TatVirtualMachine);
    procedure __GetTCustomOutlineSelectedItem(AMachine: TatVirtualMachine);
    procedure __SetTCustomOutlineSelectedItem(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  OutlineErrorClass = class of OutlineError;
  EOutlineErrorClass = class of EOutlineError;
  TOutlineNodeClass = class of TOutlineNode;
  TCustomOutlineClass = class of TCustomOutline;
  TOutlineClass = class of TOutline;

  TatOutlineDispatcher = class(TatEventDispatcher)
  private
    procedure __EOutlineChange( Sender: TObject;  Index: LongInt);
  end;


implementation



procedure TatOutlineLibrary.__TOutlineNodeCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOutlineNodeClass(CurrentClass.ClassRef).Create(TCustomOutline(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOutlineLibrary.__TOutlineNodeDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOutlineNode(CurrentObject).Destroy;
  end;
end;

procedure TatOutlineLibrary.__TOutlineNodeChangeLevelBy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOutlineNode(CurrentObject).ChangeLevelBy(GetInputArg(0));
  end;
end;

procedure TatOutlineLibrary.__TOutlineNodeCollapse(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOutlineNode(CurrentObject).Collapse;
  end;
end;

procedure TatOutlineLibrary.__TOutlineNodeExpand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOutlineNode(CurrentObject).Expand;
  end;
end;

procedure TatOutlineLibrary.__TOutlineNodeFullExpand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOutlineNode(CurrentObject).FullExpand;
  end;
end;

procedure TatOutlineLibrary.__TOutlineNodeGetDisplayWidth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOutlineNode(CurrentObject).GetDisplayWidth);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOutlineLibrary.__TOutlineNodegetFirstChild(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOutlineNode(CurrentObject).getFirstChild);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOutlineLibrary.__TOutlineNodeGetLastChild(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOutlineNode(CurrentObject).GetLastChild);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOutlineLibrary.__TOutlineNodeGetNextChild(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOutlineNode(CurrentObject).GetNextChild(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOutlineLibrary.__TOutlineNodeGetPrevChild(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOutlineNode(CurrentObject).GetPrevChild(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOutlineLibrary.__TOutlineNodeMoveTo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOutlineNode(CurrentObject).MoveTo(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatOutlineLibrary.__GetTOutlineNodeParent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TOutlineNode(CurrentObject).Parent));
  end;
end;

procedure TatOutlineLibrary.__GetTOutlineNodeExpanded(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TOutlineNode(CurrentObject).Expanded);
  end;
end;

procedure TatOutlineLibrary.__SetTOutlineNodeExpanded(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOutlineNode(CurrentObject).Expanded:=GetInputArg(0);
  end;
end;

procedure TatOutlineLibrary.__GetTOutlineNodeText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TOutlineNode(CurrentObject).Text);
  end;
end;

procedure TatOutlineLibrary.__SetTOutlineNodeText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOutlineNode(CurrentObject).Text:=GetInputArg(0);
  end;
end;

procedure TatOutlineLibrary.__GetTOutlineNodeIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TOutlineNode(CurrentObject).Index));
  end;
end;

procedure TatOutlineLibrary.__GetTOutlineNodeLevel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TOutlineNode(CurrentObject).Level));
  end;
end;

procedure TatOutlineLibrary.__SetTOutlineNodeLevel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOutlineNode(CurrentObject).Level:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatOutlineLibrary.__GetTOutlineNodeHasItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TOutlineNode(CurrentObject).HasItems);
  end;
end;

procedure TatOutlineLibrary.__GetTOutlineNodeIsVisible(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TOutlineNode(CurrentObject).IsVisible);
  end;
end;

procedure TatOutlineLibrary.__GetTOutlineNodeTopItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TOutlineNode(CurrentObject).TopItem));
  end;
end;

procedure TatOutlineLibrary.__GetTOutlineNodeFullPath(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TOutlineNode(CurrentObject).FullPath);
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomOutlineClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomOutline(CurrentObject).Destroy;
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomOutline(CurrentObject).Add(VarToInteger(GetInputArg(0)),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineAddChild(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomOutline(CurrentObject).AddChild(VarToInteger(GetInputArg(0)),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineInsert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomOutline(CurrentObject).Insert(VarToInteger(GetInputArg(0)),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomOutline(CurrentObject).Delete(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineGetItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomOutline(CurrentObject).GetItem(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineGetNodeDisplayWidth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomOutline(CurrentObject).GetNodeDisplayWidth(TOutlineNode(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineGetTextItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomOutline(CurrentObject).GetTextItem(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineGetVisibleNode(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomOutline(CurrentObject).GetVisibleNode(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineFullExpand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomOutline(CurrentObject).FullExpand;
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineFullCollapse(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomOutline(CurrentObject).FullCollapse;
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineLoadFromFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomOutline(CurrentObject).LoadFromFile(GetInputArg(0));
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomOutline(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineSaveToFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomOutline(CurrentObject).SaveToFile(GetInputArg(0));
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomOutline(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineBeginUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomOutline(CurrentObject).BeginUpdate;
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineEndUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomOutline(CurrentObject).EndUpdate;
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineSetUpdateState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomOutline(CurrentObject).SetUpdateState(GetInputArg(0));
  end;
end;

procedure TatOutlineLibrary.__TCustomOutlineClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomOutline(CurrentObject).Clear;
  end;
end;

procedure TatOutlineLibrary.__GetTCustomOutlineItemCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomOutline(CurrentObject).ItemCount));
  end;
end;

procedure TatOutlineLibrary.__GetTCustomOutlineItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomOutline(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatOutlineLibrary.__GetTCustomOutlineSelectedItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomOutline(CurrentObject).SelectedItem));
  end;
end;

procedure TatOutlineLibrary.__SetTCustomOutlineSelectedItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomOutline(CurrentObject).SelectedItem:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatOutlineDispatcher.__EOutlineChange( Sender: TObject;  Index: LongInt);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      EOutlineChange(BeforeCall)(Sender,Index);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Index]);
    if AssignedMethod(AfterCall) then
      EOutlineChange(AfterCall)(Sender,Index);
  end;
end;

procedure TatOutlineLibrary.Init;
begin
  With Scripter.DefineClass(OutlineError) do
  begin
  end;
  With Scripter.DefineClass(EOutlineError) do
  begin
  end;
  With Scripter.DefineClass(TOutlineNode) do
  begin
    DefineMethod('Create',1,tkClass,TOutlineNode,__TOutlineNodeCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TOutlineNodeDestroy,false,0);
    DefineMethod('ChangeLevelBy',1,tkNone,nil,__TOutlineNodeChangeLevelBy,false,0);
    DefineMethod('Collapse',0,tkNone,nil,__TOutlineNodeCollapse,false,0);
    DefineMethod('Expand',0,tkNone,nil,__TOutlineNodeExpand,false,0);
    DefineMethod('FullExpand',0,tkNone,nil,__TOutlineNodeFullExpand,false,0);
    DefineMethod('GetDisplayWidth',0,tkInteger,nil,__TOutlineNodeGetDisplayWidth,false,0);
    DefineMethod('getFirstChild',0,tkInteger,nil,__TOutlineNodegetFirstChild,false,0);
    DefineMethod('GetLastChild',0,tkInteger,nil,__TOutlineNodeGetLastChild,false,0);
    DefineMethod('GetNextChild',1,tkInteger,nil,__TOutlineNodeGetNextChild,false,0);
    DefineMethod('GetPrevChild',1,tkInteger,nil,__TOutlineNodeGetPrevChild,false,0);
    DefineMethod('MoveTo',2,tkNone,nil,__TOutlineNodeMoveTo,false,0);
    DefineProp('Parent',tkClass,__GetTOutlineNodeParent,nil,TOutlineNode,false,0);
    DefineProp('Expanded',tkVariant,__GetTOutlineNodeExpanded,__SetTOutlineNodeExpanded,nil,false,0);
    DefineProp('Text',tkVariant,__GetTOutlineNodeText,__SetTOutlineNodeText,nil,false,0);
    DefineProp('Index',tkInteger,__GetTOutlineNodeIndex,nil,nil,false,0);
    DefineProp('Level',tkInteger,__GetTOutlineNodeLevel,__SetTOutlineNodeLevel,nil,false,0);
    DefineProp('HasItems',tkVariant,__GetTOutlineNodeHasItems,nil,nil,false,0);
    DefineProp('IsVisible',tkVariant,__GetTOutlineNodeIsVisible,nil,nil,false,0);
    DefineProp('TopItem',tkInteger,__GetTOutlineNodeTopItem,nil,nil,false,0);
    DefineProp('FullPath',tkVariant,__GetTOutlineNodeFullPath,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomOutline) do
  begin
    DefineMethod('Create',1,tkClass,TCustomOutline,__TCustomOutlineCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomOutlineDestroy,false,0);
    DefineMethod('Add',2,tkInteger,nil,__TCustomOutlineAdd,false,0);
    DefineMethod('AddChild',2,tkInteger,nil,__TCustomOutlineAddChild,false,0);
    DefineMethod('Insert',2,tkInteger,nil,__TCustomOutlineInsert,false,0);
    DefineMethod('Delete',1,tkNone,nil,__TCustomOutlineDelete,false,0);
    DefineMethod('GetItem',2,tkInteger,nil,__TCustomOutlineGetItem,false,0);
    DefineMethod('GetNodeDisplayWidth',1,tkInteger,nil,__TCustomOutlineGetNodeDisplayWidth,false,0);
    DefineMethod('GetTextItem',1,tkInteger,nil,__TCustomOutlineGetTextItem,false,0);
    DefineMethod('GetVisibleNode',1,tkClass,TOutlineNode,__TCustomOutlineGetVisibleNode,false,0);
    DefineMethod('FullExpand',0,tkNone,nil,__TCustomOutlineFullExpand,false,0);
    DefineMethod('FullCollapse',0,tkNone,nil,__TCustomOutlineFullCollapse,false,0);
    DefineMethod('LoadFromFile',1,tkNone,nil,__TCustomOutlineLoadFromFile,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TCustomOutlineLoadFromStream,false,0);
    DefineMethod('SaveToFile',1,tkNone,nil,__TCustomOutlineSaveToFile,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TCustomOutlineSaveToStream,false,0);
    DefineMethod('BeginUpdate',0,tkNone,nil,__TCustomOutlineBeginUpdate,false,0);
    DefineMethod('EndUpdate',0,tkNone,nil,__TCustomOutlineEndUpdate,false,0);
    DefineMethod('SetUpdateState',1,tkNone,nil,__TCustomOutlineSetUpdateState,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TCustomOutlineClear,false,0);
    DefineProp('ItemCount',tkInteger,__GetTCustomOutlineItemCount,nil,nil,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTCustomOutlineItems,nil,TOutlineNode,false,1);
    DefineProp('SelectedItem',tkInteger,__GetTCustomOutlineSelectedItem,__SetTCustomOutlineSelectedItem,nil,false,0);
    DefineProp('Row',tkVariant,nil,nil,nil,false,0);
    DefineProp('Canvas',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TOutline) do
  begin
  end;
  DefineEventAdapter(TypeInfo(EOutlineChange), TatOutlineDispatcher, @TatOutlineDispatcher.__EOutlineChange);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('ocLess',ocLess);
    AddConstant('ocSame',ocSame);
    AddConstant('ocGreater',ocGreater);
    AddConstant('ocInvalid',ocInvalid);
    AddConstant('oaAdd',oaAdd);
    AddConstant('oaAddChild',oaAddChild);
    AddConstant('oaInsert',oaInsert);
    AddConstant('osText',osText);
    AddConstant('osPlusMinusText',osPlusMinusText);
    AddConstant('osPictureText',osPictureText);
    AddConstant('osPlusMinusPictureText',osPlusMinusPictureText);
    AddConstant('osTreeText',osTreeText);
    AddConstant('osTreePictureText',osTreePictureText);
    AddConstant('obPlus',obPlus);
    AddConstant('obMinus',obMinus);
    AddConstant('obOpen',obOpen);
    AddConstant('obClose',obClose);
    AddConstant('obLeaf',obLeaf);
    AddConstant('otStandard',otStandard);
    AddConstant('otOwnerDraw',otOwnerDraw);
    AddConstant('ooDrawTreeRoot',ooDrawTreeRoot);
    AddConstant('ooDrawFocusRect',ooDrawFocusRect);
    AddConstant('ooStretchBitmaps',ooStretchBitmaps);
  end;
end;

class function TatOutlineLibrary.LibraryName: string;
begin
  result := 'Outline';
end;

initialization
  RegisterScripterLibrary(TatOutlineLibrary, True);

{$WARNINGS ON}

end.

