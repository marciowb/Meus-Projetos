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
unit ap_StdActns;

interface

uses
  Classes,
  ActnList,
  StdCtrls,
  Forms,
  StdActns,
  atScript;

{$WARNINGS OFF}

type
  TatStdActnsLibrary = class(TatScripterLibrary)
    procedure __THintActionCreate(AMachine: TatVirtualMachine);
    procedure __TEditActionHandlesTarget(AMachine: TatVirtualMachine);
    procedure __TEditActionUpdateTarget(AMachine: TatVirtualMachine);
    procedure __GetTEditActionControl(AMachine: TatVirtualMachine);
    procedure __SetTEditActionControl(AMachine: TatVirtualMachine);
    procedure __TEditCutExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TEditCopyExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TEditPasteUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TEditPasteExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TEditSelectAllExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TEditSelectAllUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TEditUndoExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TEditUndoUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TEditDeleteExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TEditDeleteUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TWindowActionHandlesTarget(AMachine: TatVirtualMachine);
    procedure __TWindowActionUpdateTarget(AMachine: TatVirtualMachine);
    procedure __GetTWindowActionForm(AMachine: TatVirtualMachine);
    procedure __SetTWindowActionForm(AMachine: TatVirtualMachine);
    procedure __TWindowCloseExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TWindowCloseUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TWindowCascadeExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TWindowTileHorizontalExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TWindowTileVerticalExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TWindowMinimizeAllExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TWindowArrangeExecuteTarget(AMachine: TatVirtualMachine);
    procedure __THelpActionHandlesTarget(AMachine: TatVirtualMachine);
    procedure __THelpActionUpdateTarget(AMachine: TatVirtualMachine);
    procedure __THelpContentsExecuteTarget(AMachine: TatVirtualMachine);
    procedure __THelpTopicSearchExecuteTarget(AMachine: TatVirtualMachine);
    procedure __THelpOnHelpExecuteTarget(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  THintActionClass = class of THintAction;
  TEditActionClass = class of TEditAction;
  TEditCutClass = class of TEditCut;
  TEditCopyClass = class of TEditCopy;
  TEditPasteClass = class of TEditPaste;
  TEditSelectAllClass = class of TEditSelectAll;
  TEditUndoClass = class of TEditUndo;
  TEditDeleteClass = class of TEditDelete;
  TWindowActionClass = class of TWindowAction;
  TWindowCloseClass = class of TWindowClose;
  TWindowCascadeClass = class of TWindowCascade;
  TWindowTileHorizontalClass = class of TWindowTileHorizontal;
  TWindowTileVerticalClass = class of TWindowTileVertical;
  TWindowMinimizeAllClass = class of TWindowMinimizeAll;
  TWindowArrangeClass = class of TWindowArrange;
  THelpActionClass = class of THelpAction;
  THelpContentsClass = class of THelpContents;
  THelpTopicSearchClass = class of THelpTopicSearch;
  THelpOnHelpClass = class of THelpOnHelp;



implementation



procedure TatStdActnsLibrary.__THintActionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(THintActionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdActnsLibrary.__TEditActionHandlesTarget(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TEditAction(CurrentObject).HandlesTarget(TObject(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdActnsLibrary.__TEditActionUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TEditAction(CurrentObject).UpdateTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__GetTEditActionControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TEditAction(CurrentObject).Control));
  end;
end;

procedure TatStdActnsLibrary.__SetTEditActionControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TEditAction(CurrentObject).Control:=TCustomEdit(Integer(GetInputArg(0)));
  end;
end;

procedure TatStdActnsLibrary.__TEditCutExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TEditCut(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TEditCopyExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TEditCopy(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TEditPasteUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TEditPaste(CurrentObject).UpdateTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TEditPasteExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TEditPaste(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TEditSelectAllExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TEditSelectAll(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TEditSelectAllUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TEditSelectAll(CurrentObject).UpdateTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TEditUndoExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TEditUndo(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TEditUndoUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TEditUndo(CurrentObject).UpdateTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TEditDeleteExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TEditDelete(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TEditDeleteUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TEditDelete(CurrentObject).UpdateTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TWindowActionHandlesTarget(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TWindowAction(CurrentObject).HandlesTarget(TObject(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdActnsLibrary.__TWindowActionUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWindowAction(CurrentObject).UpdateTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__GetTWindowActionForm(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TWindowAction(CurrentObject).Form));
  end;
end;

procedure TatStdActnsLibrary.__SetTWindowActionForm(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWindowAction(CurrentObject).Form:=TForm(Integer(GetInputArg(0)));
  end;
end;

procedure TatStdActnsLibrary.__TWindowCloseExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWindowClose(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TWindowCloseUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWindowClose(CurrentObject).UpdateTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TWindowCascadeExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWindowCascade(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TWindowTileHorizontalExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWindowTileHorizontal(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TWindowTileVerticalExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWindowTileVertical(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TWindowMinimizeAllExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWindowMinimizeAll(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TWindowArrangeExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWindowArrange(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__THelpActionHandlesTarget(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := THelpAction(CurrentObject).HandlesTarget(TObject(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdActnsLibrary.__THelpActionUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THelpAction(CurrentObject).UpdateTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__THelpContentsExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THelpContents(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__THelpTopicSearchExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THelpTopicSearch(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__THelpOnHelpExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THelpOnHelp(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.Init;
begin
  With Scripter.DefineClass(THintAction) do
  begin
    DefineMethod('Create',1,tkClass,THintAction,__THintActionCreate,true,0);
  end;
  With Scripter.DefineClass(TEditAction) do
  begin
    DefineMethod('HandlesTarget',1,tkVariant,nil,__TEditActionHandlesTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TEditActionUpdateTarget,false,0);
    DefineProp('Control',tkClass,__GetTEditActionControl,__SetTEditActionControl,TCustomEdit,false,0);
  end;
  With Scripter.DefineClass(TEditCut) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TEditCutExecuteTarget,false,0);
  end;
  With Scripter.DefineClass(TEditCopy) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TEditCopyExecuteTarget,false,0);
  end;
  With Scripter.DefineClass(TEditPaste) do
  begin
    DefineMethod('UpdateTarget',1,tkNone,nil,__TEditPasteUpdateTarget,false,0);
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TEditPasteExecuteTarget,false,0);
  end;
  With Scripter.DefineClass(TEditSelectAll) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TEditSelectAllExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TEditSelectAllUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TEditUndo) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TEditUndoExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TEditUndoUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TEditDelete) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TEditDeleteExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TEditDeleteUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TWindowAction) do
  begin
    DefineMethod('HandlesTarget',1,tkVariant,nil,__TWindowActionHandlesTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TWindowActionUpdateTarget,false,0);
    DefineProp('Form',tkClass,__GetTWindowActionForm,__SetTWindowActionForm,TForm,false,0);
  end;
  With Scripter.DefineClass(TWindowClose) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TWindowCloseExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TWindowCloseUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TWindowCascade) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TWindowCascadeExecuteTarget,false,0);
  end;
  With Scripter.DefineClass(TWindowTileHorizontal) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TWindowTileHorizontalExecuteTarget,false,0);
  end;
  With Scripter.DefineClass(TWindowTileVertical) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TWindowTileVerticalExecuteTarget,false,0);
  end;
  With Scripter.DefineClass(TWindowMinimizeAll) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TWindowMinimizeAllExecuteTarget,false,0);
  end;
  With Scripter.DefineClass(TWindowArrange) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TWindowArrangeExecuteTarget,false,0);
  end;
  With Scripter.DefineClass(THelpAction) do
  begin
    DefineMethod('HandlesTarget',1,tkVariant,nil,__THelpActionHandlesTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__THelpActionUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(THelpContents) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__THelpContentsExecuteTarget,false,0);
  end;
  With Scripter.DefineClass(THelpTopicSearch) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__THelpTopicSearchExecuteTarget,false,0);
  end;
  With Scripter.DefineClass(THelpOnHelp) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__THelpOnHelpExecuteTarget,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatStdActnsLibrary.LibraryName: string;
begin
  result := 'StdActns';
end;

initialization
  RegisterScripterLibrary(TatStdActnsLibrary, True);

{$WARNINGS ON}

end.

