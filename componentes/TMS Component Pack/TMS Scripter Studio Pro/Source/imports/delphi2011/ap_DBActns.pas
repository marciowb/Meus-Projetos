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
unit ap_DBActns;

interface

uses
  Classes,
  DB,
  ActnList,
  DBActns,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatDBActnsLibrary = class(TatScripterLibrary)
    procedure __TDataSetActionHandlesTarget(AMachine: TatVirtualMachine);
    procedure __GetTDataSetActionDataSource(AMachine: TatVirtualMachine);
    procedure __SetTDataSetActionDataSource(AMachine: TatVirtualMachine);
    procedure __TDataSetFirstExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetFirstUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetPriorExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetPriorUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetNextExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetNextUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetLastExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetLastUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetInsertExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetInsertUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetDeleteExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetDeleteUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetEditExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetEditUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetPostExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetPostUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetCancelExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetCancelUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetRefreshExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TDataSetRefreshUpdateTarget(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TDataSetActionClass = class of TDataSetAction;
  TDataSetFirstClass = class of TDataSetFirst;
  TDataSetPriorClass = class of TDataSetPrior;
  TDataSetNextClass = class of TDataSetNext;
  TDataSetLastClass = class of TDataSetLast;
  TDataSetInsertClass = class of TDataSetInsert;
  TDataSetDeleteClass = class of TDataSetDelete;
  TDataSetEditClass = class of TDataSetEdit;
  TDataSetPostClass = class of TDataSetPost;
  TDataSetCancelClass = class of TDataSetCancel;
  TDataSetRefreshClass = class of TDataSetRefresh;



implementation



procedure TatDBActnsLibrary.__TDataSetActionHandlesTarget(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataSetAction(CurrentObject).HandlesTarget(TObject(integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBActnsLibrary.__GetTDataSetActionDataSource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataSetAction(CurrentObject).DataSource));
  end;
end;

procedure TatDBActnsLibrary.__SetTDataSetActionDataSource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetAction(CurrentObject).DataSource:=TDataSource(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetFirstExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetFirst(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetFirstUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetFirst(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetPriorExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetPrior(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetPriorUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetPrior(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetNextExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetNext(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetNextUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetNext(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetLastExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetLast(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetLastUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetLast(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetInsertExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetInsert(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetInsertUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetInsert(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetDeleteExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetDelete(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetDeleteUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetDelete(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetEditExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetEdit(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetEditUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetEdit(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetPostExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetPost(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetPostUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetPost(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetCancelExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetCancel(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetCancelUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetCancel(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetRefreshExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetRefresh(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.__TDataSetRefreshUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetRefresh(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDBActnsLibrary.Init;
begin
  With Scripter.DefineClass(TDataSetAction) do
  begin
    DefineMethod('HandlesTarget',1,tkVariant,nil,__TDataSetActionHandlesTarget,false,0);
    DefineProp('DataSource',tkClass,__GetTDataSetActionDataSource,__SetTDataSetActionDataSource,TDataSource,false,0);
  end;
  With Scripter.DefineClass(TDataSetFirst) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TDataSetFirstExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TDataSetFirstUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TDataSetPrior) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TDataSetPriorExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TDataSetPriorUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TDataSetNext) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TDataSetNextExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TDataSetNextUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TDataSetLast) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TDataSetLastExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TDataSetLastUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TDataSetInsert) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TDataSetInsertExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TDataSetInsertUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TDataSetDelete) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TDataSetDeleteExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TDataSetDeleteUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TDataSetEdit) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TDataSetEditExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TDataSetEditUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TDataSetPost) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TDataSetPostExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TDataSetPostUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TDataSetCancel) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TDataSetCancelExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TDataSetCancelUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TDataSetRefresh) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TDataSetRefreshExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TDataSetRefreshUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatDBActnsLibrary.LibraryName: string;
begin
  result := 'DBActns';
end;

initialization
  RegisterScripterLibrary(TatDBActnsLibrary, True);

{$WARNINGS ON}

end.

