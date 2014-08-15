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
  Windows,
  ShlObj,
  SysUtils,
  Classes,
  ActnList,
  StdCtrls,
  Forms,
  Dialogs,
  StdActns,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatStdActnsLibrary = class(TatScripterLibrary)
    procedure __THintActionCreate(AMachine: TatVirtualMachine);
    procedure __TEditActionDestroy(AMachine: TatVirtualMachine);
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
    procedure __TWindowActionCreate(AMachine: TatVirtualMachine);
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
    procedure __THelpActionCreate(AMachine: TatVirtualMachine);
    procedure __THelpActionHandlesTarget(AMachine: TatVirtualMachine);
    procedure __THelpActionUpdateTarget(AMachine: TatVirtualMachine);
    procedure __THelpContentsExecuteTarget(AMachine: TatVirtualMachine);
    procedure __THelpTopicSearchExecuteTarget(AMachine: TatVirtualMachine);
    procedure __THelpOnHelpExecuteTarget(AMachine: TatVirtualMachine);
    procedure __THelpContextActionExecuteTarget(AMachine: TatVirtualMachine);
    procedure __THelpContextActionUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TCommonDialogActionCreate(AMachine: TatVirtualMachine);
    procedure __TCommonDialogActionDestroy(AMachine: TatVirtualMachine);
    procedure __TCommonDialogActionHandlesTarget(AMachine: TatVirtualMachine);
    procedure __TCommonDialogActionExecuteTarget(AMachine: TatVirtualMachine);
    procedure __GetTCommonDialogActionExecuteResult(AMachine: TatVirtualMachine);
    procedure __TFileOpenCreate(AMachine: TatVirtualMachine);
    procedure __TFileOpenExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TFileOpenWithExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TFileSaveAsCreate(AMachine: TatVirtualMachine);
    procedure __TFileExitHandlesTarget(AMachine: TatVirtualMachine);
    procedure __TFileExitExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TSearchActionCreate(AMachine: TatVirtualMachine);
    procedure __TSearchActionDestroy(AMachine: TatVirtualMachine);
    procedure __TSearchActionHandlesTarget(AMachine: TatVirtualMachine);
    procedure __TSearchActionSearch(AMachine: TatVirtualMachine);
    procedure __TSearchActionUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TSearchActionExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TSearchReplaceExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TSearchFindFirstCreate(AMachine: TatVirtualMachine);
    procedure __TSearchFindNextCreate(AMachine: TatVirtualMachine);
    procedure __TSearchFindNextHandlesTarget(AMachine: TatVirtualMachine);
    procedure __TSearchFindNextUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TSearchFindNextExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TBrowseForFolderExecuteTarget(AMachine: TatVirtualMachine);
    procedure __GetTBrowseForFolderFolder(AMachine: TatVirtualMachine);
    procedure __SetTBrowseForFolderFolder(AMachine: TatVirtualMachine);
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
  THelpContextActionClass = class of THelpContextAction;
  TCommonDialogActionClass = class of TCommonDialogAction;
  TFileActionClass = class of TFileAction;
  TFileOpenClass = class of TFileOpen;
  TFileOpenWithClass = class of TFileOpenWith;
  TFileSaveAsClass = class of TFileSaveAs;
  TFilePrintSetupClass = class of TFilePrintSetup;
  TFilePageSetupClass = class of TFilePageSetup;
  TFileExitClass = class of TFileExit;
  TSearchActionClass = class of TSearchAction;
  TSearchFindClass = class of TSearchFind;
  TSearchReplaceClass = class of TSearchReplace;
  TSearchFindFirstClass = class of TSearchFindFirst;
  TSearchFindNextClass = class of TSearchFindNext;
  TFontEditClass = class of TFontEdit;
  TColorSelectClass = class of TColorSelect;
  TPrintDlgClass = class of TPrintDlg;
  TBrowseForFolderClass = class of TBrowseForFolder;

  TatStdActnsDispatcher = class(TatEventDispatcher)
  private
    procedure __TBrowseForFolderCallbackEvent( Sender: TBrowseForFolder;  Wnd: HWND;  uMsg: UINT;  lParam: LPARAM;  lpData: LPARAM; var Result: Integer);
  end;


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

procedure TatStdActnsLibrary.__TEditActionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TEditAction(CurrentObject).Destroy;
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

procedure TatStdActnsLibrary.__TWindowActionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TWindowActionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
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
    TWindowAction(CurrentObject).Form:=TCustomForm(Integer(GetInputArg(0)));
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

procedure TatStdActnsLibrary.__THelpActionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(THelpActionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
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

procedure TatStdActnsLibrary.__THelpContextActionExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THelpContextAction(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__THelpContextActionUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THelpContextAction(CurrentObject).UpdateTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TCommonDialogActionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCommonDialogActionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdActnsLibrary.__TCommonDialogActionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCommonDialogAction(CurrentObject).Destroy;
  end;
end;

procedure TatStdActnsLibrary.__TCommonDialogActionHandlesTarget(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCommonDialogAction(CurrentObject).HandlesTarget(TObject(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdActnsLibrary.__TCommonDialogActionExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCommonDialogAction(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__GetTCommonDialogActionExecuteResult(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCommonDialogAction(CurrentObject).ExecuteResult);
  end;
end;

procedure TatStdActnsLibrary.__TFileOpenCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFileOpenClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdActnsLibrary.__TFileOpenExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFileOpen(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TFileOpenWithExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFileOpenWith(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TFileSaveAsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFileSaveAsClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdActnsLibrary.__TFileExitHandlesTarget(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TFileExit(CurrentObject).HandlesTarget(TObject(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdActnsLibrary.__TFileExitExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFileExit(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TSearchActionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSearchActionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdActnsLibrary.__TSearchActionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSearchAction(CurrentObject).Destroy;
  end;
end;

procedure TatStdActnsLibrary.__TSearchActionHandlesTarget(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TSearchAction(CurrentObject).HandlesTarget(TObject(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdActnsLibrary.__TSearchActionSearch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSearchAction(CurrentObject).Search(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TSearchActionUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSearchAction(CurrentObject).UpdateTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TSearchActionExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSearchAction(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TSearchReplaceExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSearchReplace(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TSearchFindFirstCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSearchFindFirstClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdActnsLibrary.__TSearchFindNextCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSearchFindNextClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdActnsLibrary.__TSearchFindNextHandlesTarget(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TSearchFindNext(CurrentObject).HandlesTarget(TObject(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdActnsLibrary.__TSearchFindNextUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSearchFindNext(CurrentObject).UpdateTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TSearchFindNextExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSearchFindNext(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__TBrowseForFolderExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBrowseForFolder(CurrentObject).ExecuteTarget(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdActnsLibrary.__GetTBrowseForFolderFolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TBrowseForFolder(CurrentObject).Folder);
  end;
end;

procedure TatStdActnsLibrary.__SetTBrowseForFolderFolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBrowseForFolder(CurrentObject).Folder:=GetInputArg(0);
  end;
end;

procedure TatStdActnsDispatcher.__TBrowseForFolderCallbackEvent( Sender: TBrowseForFolder;  Wnd: HWND;  uMsg: UINT;  lParam: LPARAM;  lpData: LPARAM; var Result: Integer);
var
  ResultTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TBrowseForFolderCallbackEvent(BeforeCall)(Sender,Wnd,uMsg,lParam,lpData,Result);
    ResultTemp := Integer(Result);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Wnd,uMsg,lParam,lpData,ResultTemp]);
    Result := VarToInteger(ResultTemp);
    if AssignedMethod(AfterCall) then
      TBrowseForFolderCallbackEvent(AfterCall)(Sender,Wnd,uMsg,lParam,lpData,Result);
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
    DefineMethod('Destroy',0,tkNone,nil,__TEditActionDestroy,false,0);
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
    DefineMethod('Create',1,tkClass,TWindowAction,__TWindowActionCreate,true,0);
    DefineMethod('HandlesTarget',1,tkVariant,nil,__TWindowActionHandlesTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TWindowActionUpdateTarget,false,0);
    DefineProp('Form',tkClass,__GetTWindowActionForm,__SetTWindowActionForm,TCustomForm,false,0);
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
    DefineMethod('Create',1,tkClass,THelpAction,__THelpActionCreate,true,0);
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
  With Scripter.DefineClass(THelpContextAction) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__THelpContextActionExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__THelpContextActionUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TCommonDialogAction) do
  begin
    DefineMethod('Create',1,tkClass,TCommonDialogAction,__TCommonDialogActionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCommonDialogActionDestroy,false,0);
    DefineMethod('HandlesTarget',1,tkVariant,nil,__TCommonDialogActionHandlesTarget,false,0);
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TCommonDialogActionExecuteTarget,false,0);
    DefineProp('ExecuteResult',tkVariant,__GetTCommonDialogActionExecuteResult,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TFileAction) do
  begin
  end;
  With Scripter.DefineClass(TFileOpen) do
  begin
    DefineMethod('Create',1,tkClass,TFileOpen,__TFileOpenCreate,true,0);
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TFileOpenExecuteTarget,false,0);
  end;
  With Scripter.DefineClass(TFileOpenWith) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TFileOpenWithExecuteTarget,false,0);
  end;
  With Scripter.DefineClass(TFileSaveAs) do
  begin
    DefineMethod('Create',1,tkClass,TFileSaveAs,__TFileSaveAsCreate,true,0);
  end;
  With Scripter.DefineClass(TFilePrintSetup) do
  begin
  end;
  With Scripter.DefineClass(TFilePageSetup) do
  begin
  end;
  With Scripter.DefineClass(TFileExit) do
  begin
    DefineMethod('HandlesTarget',1,tkVariant,nil,__TFileExitHandlesTarget,false,0);
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TFileExitExecuteTarget,false,0);
  end;
  With Scripter.DefineClass(TSearchAction) do
  begin
    DefineMethod('Create',1,tkClass,TSearchAction,__TSearchActionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TSearchActionDestroy,false,0);
    DefineMethod('HandlesTarget',1,tkVariant,nil,__TSearchActionHandlesTarget,false,0);
    DefineMethod('Search',1,tkNone,nil,__TSearchActionSearch,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TSearchActionUpdateTarget,false,0);
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TSearchActionExecuteTarget,false,0);
  end;
  With Scripter.DefineClass(TSearchFind) do
  begin
  end;
  With Scripter.DefineClass(TSearchReplace) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TSearchReplaceExecuteTarget,false,0);
  end;
  With Scripter.DefineClass(TSearchFindFirst) do
  begin
    DefineMethod('Create',1,tkClass,TSearchFindFirst,__TSearchFindFirstCreate,true,0);
  end;
  With Scripter.DefineClass(TSearchFindNext) do
  begin
    DefineMethod('Create',1,tkClass,TSearchFindNext,__TSearchFindNextCreate,true,0);
    DefineMethod('HandlesTarget',1,tkVariant,nil,__TSearchFindNextHandlesTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TSearchFindNextUpdateTarget,false,0);
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TSearchFindNextExecuteTarget,false,0);
  end;
  With Scripter.DefineClass(TFontEdit) do
  begin
  end;
  With Scripter.DefineClass(TColorSelect) do
  begin
  end;
  With Scripter.DefineClass(TPrintDlg) do
  begin
  end;
  With Scripter.DefineClass(TBrowseForFolder) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TBrowseForFolderExecuteTarget,false,0);
    DefineProp('Folder',tkVariant,__GetTBrowseForFolderFolder,__SetTBrowseForFolderFolder,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TBrowseForFolderCallbackEvent), TatStdActnsDispatcher, @TatStdActnsDispatcher.__TBrowseForFolderCallbackEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('bifBrowseForComputer',bifBrowseForComputer);
    AddConstant('bifBrowseForPrinter',bifBrowseForPrinter);
    AddConstant('bifBrowseIncludeFiles',bifBrowseIncludeFiles);
    AddConstant('bifBrowseIncludeURLS',bifBrowseIncludeURLS);
    AddConstant('bifDontGoBelowDomain',bifDontGoBelowDomain);
    AddConstant('bifEditBox',bifEditBox);
    AddConstant('bifNewDialogStyle',bifNewDialogStyle);
    AddConstant('bifNoNewFolderButton',bifNoNewFolderButton);
    AddConstant('bifNoTranslateTargets',bifNoTranslateTargets);
    AddConstant('bifReturnFSAncestors',bifReturnFSAncestors);
    AddConstant('bifReturnOnlyFSDirs',bifReturnOnlyFSDirs);
    AddConstant('bifShareable',bifShareable);
    AddConstant('bifStatusText',bifStatusText);
    AddConstant('bifUAHint',bifUAHint);
    AddConstant('bifUseNewUI',bifUseNewUI);
    AddConstant('bifValidate',bifValidate);
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

