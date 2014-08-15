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
unit ap_DBClientActns;

interface

uses
  Classes,
  ActnList,
  DB,
  DBActns,
  DBClient,
  DBClientActns,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatDBClientActnsLibrary = class(TatScripterLibrary)
    procedure __GetTReconcileActionLinkApplyAction(AMachine: TatVirtualMachine);
    procedure __SetTReconcileActionLinkApplyAction(AMachine: TatVirtualMachine);
    procedure __TClientDataSetApplyCreate(AMachine: TatVirtualMachine);
    procedure __TClientDataSetApplyDestroy(AMachine: TatVirtualMachine);
    procedure __TClientDataSetApplyExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TClientDataSetApplyUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TClientDataSetRevertExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TClientDataSetRevertUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TClientDataSetUndoExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TClientDataSetUndoUpdateTarget(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TReconcileActionLinkClass = class of TReconcileActionLink;
  TClientDataSetApplyClass = class of TClientDataSetApply;
  TClientDataSetRevertClass = class of TClientDataSetRevert;
  TClientDataSetUndoClass = class of TClientDataSetUndo;



implementation



procedure TatDBClientActnsLibrary.__GetTReconcileActionLinkApplyAction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TReconcileActionLink(CurrentObject).ApplyAction));
  end;
end;

procedure TatDBClientActnsLibrary.__SetTReconcileActionLinkApplyAction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TReconcileActionLink(CurrentObject).ApplyAction:=TClientDataSetApply(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBClientActnsLibrary.__TClientDataSetApplyCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TClientDataSetApplyClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBClientActnsLibrary.__TClientDataSetApplyDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSetApply(CurrentObject).Destroy;
  end;
end;

procedure TatDBClientActnsLibrary.__TClientDataSetApplyExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSetApply(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBClientActnsLibrary.__TClientDataSetApplyUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSetApply(CurrentObject).UpdateTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBClientActnsLibrary.__TClientDataSetRevertExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSetRevert(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBClientActnsLibrary.__TClientDataSetRevertUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSetRevert(CurrentObject).UpdateTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBClientActnsLibrary.__TClientDataSetUndoExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSetUndo(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBClientActnsLibrary.__TClientDataSetUndoUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientDataSetUndo(CurrentObject).UpdateTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBClientActnsLibrary.Init;
begin
  With Scripter.DefineClass(TReconcileActionLink) do
  begin
    DefineProp('ApplyAction',tkClass,__GetTReconcileActionLinkApplyAction,__SetTReconcileActionLinkApplyAction,TClientDataSetApply,false,0);
  end;
  With Scripter.DefineClass(TClientDataSetApply) do
  begin
    DefineMethod('Create',1,tkClass,TClientDataSetApply,__TClientDataSetApplyCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TClientDataSetApplyDestroy,false,0);
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TClientDataSetApplyExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TClientDataSetApplyUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TClientDataSetRevert) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TClientDataSetRevertExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TClientDataSetRevertUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TClientDataSetUndo) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TClientDataSetUndoExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TClientDataSetUndoUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatDBClientActnsLibrary.LibraryName: string;
begin
  result := 'DBClientActns';
end;

initialization
  RegisterScripterLibrary(TatDBClientActnsLibrary, True);

{$WARNINGS ON}

end.

