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
unit ap_ExtActns;

interface

uses
  SysUtils,
  Windows,
  Classes,
  Controls,
  ComCtrls,
  Graphics,
  Registry,
  ActnList,
  StdActns,
  StdCtrls,
  ShellAPI,
  Dialogs,
  ExtDlgs,
  ImgList,
  ExtActns,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatExtActnsLibrary = class(TatScripterLibrary)
    procedure __TCustomFileRunCreate(AMachine: TatVirtualMachine);
    procedure __TCustomFileRunExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TCustomFileRunHandlesTarget(AMachine: TatVirtualMachine);
    procedure __TCustomFileRunSetupBrowseDialog(AMachine: TatVirtualMachine);
    procedure __TCustomFileRunUpdateTarget(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileRunHInst(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileRunBrowse(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileRunBrowse(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileRunBrowseDlg(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileRunBrowseDlg(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileRunDirectory(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileRunDirectory(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileRunFileName(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileRunFileName(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileRunOperation(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileRunOperation(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileRunParentControl(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileRunParentControl(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileRunParameters(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileRunParameters(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileRunShowCmd(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileRunShowCmd(AMachine: TatVirtualMachine);
    procedure __TRichEditActionCreate(AMachine: TatVirtualMachine);
    procedure __TRichEditActionHandlesTarget(AMachine: TatVirtualMachine);
    procedure __TRichEditBoldExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TRichEditBoldUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TRichEditItalicExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TRichEditItalicUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TRichEditUnderlineExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TRichEditUnderlineUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TRichEditStrikeOutExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TRichEditStrikeOutUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TRichEditBulletsExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TRichEditBulletsUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TRichEditAlignLeftExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TRichEditAlignLeftUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TRichEditAlignRightExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TRichEditAlignRightUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TRichEditAlignCenterExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TRichEditAlignCenterUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TTabActionCreate(AMachine: TatVirtualMachine);
    procedure __TTabActionHandlesTarget(AMachine: TatVirtualMachine);
    procedure __TTabActionUpdateTarget(AMachine: TatVirtualMachine);
    procedure __GetTTabActionSkipHiddenTabs(AMachine: TatVirtualMachine);
    procedure __SetTTabActionSkipHiddenTabs(AMachine: TatVirtualMachine);
    procedure __GetTTabActionTabControl(AMachine: TatVirtualMachine);
    procedure __SetTTabActionTabControl(AMachine: TatVirtualMachine);
    procedure __GetTTabActionWrap(AMachine: TatVirtualMachine);
    procedure __SetTTabActionWrap(AMachine: TatVirtualMachine);
    procedure __TPreviousTabExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TPreviousTabUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TNextTabExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TNextTabUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TSendMailDestroy(AMachine: TatVirtualMachine);
    procedure __TSendMailExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TSendMailHandlesTarget(AMachine: TatVirtualMachine);
    procedure __TSendMailUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TListControlActionCreate(AMachine: TatVirtualMachine);
    procedure __TListControlActionHandlesTarget(AMachine: TatVirtualMachine);
    procedure __GetTListControlActionListControl(AMachine: TatVirtualMachine);
    procedure __SetTListControlActionListControl(AMachine: TatVirtualMachine);
    procedure __TListControlSelectAllExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TListControlSelectAllUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TListControlClearSelectionExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TListControlClearSelectionUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TListControlDeleteSelectionExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TListControlDeleteSelectionUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TListControlCopySelectionExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TListControlCopySelectionHandlesTarget(AMachine: TatVirtualMachine);
    procedure __TListControlCopySelectionUpdateTarget(AMachine: TatVirtualMachine);
    procedure __TListControlMoveSelectionExecuteTarget(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCustomFileRunClass = class of TCustomFileRun;
  TFileRunClass = class of TFileRun;
  TRichEditActionClass = class of TRichEditAction;
  TRichEditBoldClass = class of TRichEditBold;
  TRichEditItalicClass = class of TRichEditItalic;
  TRichEditUnderlineClass = class of TRichEditUnderline;
  TRichEditStrikeOutClass = class of TRichEditStrikeOut;
  TRichEditBulletsClass = class of TRichEditBullets;
  TRichEditAlignLeftClass = class of TRichEditAlignLeft;
  TRichEditAlignRightClass = class of TRichEditAlignRight;
  TRichEditAlignCenterClass = class of TRichEditAlignCenter;
  TTabActionClass = class of TTabAction;
  TPreviousTabClass = class of TPreviousTab;
  TNextTabClass = class of TNextTab;
  TOpenPictureClass = class of TOpenPicture;
  TSavePictureClass = class of TSavePicture;
  TSendMailClass = class of TSendMail;
  TListControlActionClass = class of TListControlAction;
  TListControlSelectAllClass = class of TListControlSelectAll;
  TListControlClearSelectionClass = class of TListControlClearSelection;
  TListControlDeleteSelectionClass = class of TListControlDeleteSelection;
  TListControlCopySelectionClass = class of TListControlCopySelection;
  TListControlMoveSelectionClass = class of TListControlMoveSelection;

  TatExtActnsDispatcher = class(TatEventDispatcher)
  private
    procedure __TValidateTabEvent( Sender: TTabAction;  TabControl: TCustomTabControl; var Enabled: Boolean);
  end;


implementation



procedure TatExtActnsLibrary.__TCustomFileRunCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomFileRunClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtActnsLibrary.__TCustomFileRunExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileRun(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TCustomFileRunHandlesTarget(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomFileRun(CurrentObject).HandlesTarget(TObject(integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtActnsLibrary.__TCustomFileRunSetupBrowseDialog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileRun(CurrentObject).SetupBrowseDialog;
  end;
end;

procedure TatExtActnsLibrary.__TCustomFileRunUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileRun(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__GetTCustomFileRunHInst(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomFileRun(CurrentObject).HInst);
  end;
end;

procedure TatExtActnsLibrary.__GetTCustomFileRunBrowse(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomFileRun(CurrentObject).Browse);
  end;
end;

procedure TatExtActnsLibrary.__SetTCustomFileRunBrowse(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileRun(CurrentObject).Browse:=GetInputArg(0);
  end;
end;

procedure TatExtActnsLibrary.__GetTCustomFileRunBrowseDlg(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomFileRun(CurrentObject).BrowseDlg));
  end;
end;

procedure TatExtActnsLibrary.__SetTCustomFileRunBrowseDlg(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileRun(CurrentObject).BrowseDlg:=TOpenDialog(Integer(GetInputArg(0)));
  end;
end;

procedure TatExtActnsLibrary.__GetTCustomFileRunDirectory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomFileRun(CurrentObject).Directory);
  end;
end;

procedure TatExtActnsLibrary.__SetTCustomFileRunDirectory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileRun(CurrentObject).Directory:=GetInputArg(0);
  end;
end;

procedure TatExtActnsLibrary.__GetTCustomFileRunFileName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomFileRun(CurrentObject).FileName);
  end;
end;

procedure TatExtActnsLibrary.__SetTCustomFileRunFileName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileRun(CurrentObject).FileName:=GetInputArg(0);
  end;
end;

procedure TatExtActnsLibrary.__GetTCustomFileRunOperation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomFileRun(CurrentObject).Operation);
  end;
end;

procedure TatExtActnsLibrary.__SetTCustomFileRunOperation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileRun(CurrentObject).Operation:=GetInputArg(0);
  end;
end;

procedure TatExtActnsLibrary.__GetTCustomFileRunParentControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomFileRun(CurrentObject).ParentControl));
  end;
end;

procedure TatExtActnsLibrary.__SetTCustomFileRunParentControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileRun(CurrentObject).ParentControl:=TWinControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatExtActnsLibrary.__GetTCustomFileRunParameters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomFileRun(CurrentObject).Parameters);
  end;
end;

procedure TatExtActnsLibrary.__SetTCustomFileRunParameters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileRun(CurrentObject).Parameters:=GetInputArg(0);
  end;
end;

procedure TatExtActnsLibrary.__GetTCustomFileRunShowCmd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomFileRun(CurrentObject).ShowCmd);
  end;
end;

procedure TatExtActnsLibrary.__SetTCustomFileRunShowCmd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileRun(CurrentObject).ShowCmd:=GetInputArg(0);
  end;
end;

procedure TatExtActnsLibrary.__TRichEditActionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRichEditActionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtActnsLibrary.__TRichEditActionHandlesTarget(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRichEditAction(CurrentObject).HandlesTarget(TObject(integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtActnsLibrary.__TRichEditBoldExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRichEditBold(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TRichEditBoldUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRichEditBold(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TRichEditItalicExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRichEditItalic(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TRichEditItalicUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRichEditItalic(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TRichEditUnderlineExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRichEditUnderline(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TRichEditUnderlineUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRichEditUnderline(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TRichEditStrikeOutExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRichEditStrikeOut(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TRichEditStrikeOutUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRichEditStrikeOut(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TRichEditBulletsExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRichEditBullets(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TRichEditBulletsUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRichEditBullets(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TRichEditAlignLeftExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRichEditAlignLeft(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TRichEditAlignLeftUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRichEditAlignLeft(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TRichEditAlignRightExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRichEditAlignRight(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TRichEditAlignRightUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRichEditAlignRight(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TRichEditAlignCenterExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRichEditAlignCenter(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TRichEditAlignCenterUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRichEditAlignCenter(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TTabActionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTabActionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtActnsLibrary.__TTabActionHandlesTarget(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TTabAction(CurrentObject).HandlesTarget(TObject(integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtActnsLibrary.__TTabActionUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabAction(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__GetTTabActionSkipHiddenTabs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTabAction(CurrentObject).SkipHiddenTabs);
  end;
end;

procedure TatExtActnsLibrary.__SetTTabActionSkipHiddenTabs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabAction(CurrentObject).SkipHiddenTabs:=GetInputArg(0);
  end;
end;

procedure TatExtActnsLibrary.__GetTTabActionTabControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTabAction(CurrentObject).TabControl));
  end;
end;

procedure TatExtActnsLibrary.__SetTTabActionTabControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabAction(CurrentObject).TabControl:=TCustomTabControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatExtActnsLibrary.__GetTTabActionWrap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTabAction(CurrentObject).Wrap);
  end;
end;

procedure TatExtActnsLibrary.__SetTTabActionWrap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabAction(CurrentObject).Wrap:=GetInputArg(0);
  end;
end;

procedure TatExtActnsLibrary.__TPreviousTabExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPreviousTab(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TPreviousTabUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPreviousTab(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TNextTabExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TNextTab(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TNextTabUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TNextTab(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TSendMailDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSendMail(CurrentObject).Destroy;
  end;
end;

procedure TatExtActnsLibrary.__TSendMailExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSendMail(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TSendMailHandlesTarget(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TSendMail(CurrentObject).HandlesTarget(TObject(integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtActnsLibrary.__TSendMailUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSendMail(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TListControlActionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListControlActionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtActnsLibrary.__TListControlActionHandlesTarget(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TListControlAction(CurrentObject).HandlesTarget(TObject(integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtActnsLibrary.__GetTListControlActionListControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListControlAction(CurrentObject).ListControl));
  end;
end;

procedure TatExtActnsLibrary.__SetTListControlActionListControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListControlAction(CurrentObject).ListControl:=TCustomListControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatExtActnsLibrary.__TListControlSelectAllExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListControlSelectAll(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TListControlSelectAllUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListControlSelectAll(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TListControlClearSelectionExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListControlClearSelection(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TListControlClearSelectionUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListControlClearSelection(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TListControlDeleteSelectionExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListControlDeleteSelection(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TListControlDeleteSelectionUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListControlDeleteSelection(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TListControlCopySelectionExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListControlCopySelection(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TListControlCopySelectionHandlesTarget(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TListControlCopySelection(CurrentObject).HandlesTarget(TObject(integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtActnsLibrary.__TListControlCopySelectionUpdateTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListControlCopySelection(CurrentObject).UpdateTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsLibrary.__TListControlMoveSelectionExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListControlMoveSelection(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatExtActnsDispatcher.__TValidateTabEvent( Sender: TTabAction;  TabControl: TCustomTabControl; var Enabled: Boolean);
var
  EnabledTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TValidateTabEvent(BeforeCall)(Sender,TabControl,Enabled);
    EnabledTemp := Enabled;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,TabControl,EnabledTemp]);
    Enabled := EnabledTemp;
    if AssignedMethod(AfterCall) then
      TValidateTabEvent(AfterCall)(Sender,TabControl,Enabled);
  end;
end;

procedure TatExtActnsLibrary.Init;
begin
  With Scripter.DefineClass(TCustomFileRun) do
  begin
    DefineMethod('Create',1,tkClass,TCustomFileRun,__TCustomFileRunCreate,true,0);
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TCustomFileRunExecuteTarget,false,0);
    DefineMethod('HandlesTarget',1,tkVariant,nil,__TCustomFileRunHandlesTarget,false,0);
    DefineMethod('SetupBrowseDialog',0,tkNone,nil,__TCustomFileRunSetupBrowseDialog,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TCustomFileRunUpdateTarget,false,0);
    DefineProp('HInst',tkVariant,__GetTCustomFileRunHInst,nil,nil,false,0);
    DefineProp('Browse',tkVariant,__GetTCustomFileRunBrowse,__SetTCustomFileRunBrowse,nil,false,0);
    DefineProp('BrowseDlg',tkClass,__GetTCustomFileRunBrowseDlg,__SetTCustomFileRunBrowseDlg,TOpenDialog,false,0);
    DefineProp('Directory',tkVariant,__GetTCustomFileRunDirectory,__SetTCustomFileRunDirectory,nil,false,0);
    DefineProp('FileName',tkVariant,__GetTCustomFileRunFileName,__SetTCustomFileRunFileName,nil,false,0);
    DefineProp('Operation',tkVariant,__GetTCustomFileRunOperation,__SetTCustomFileRunOperation,nil,false,0);
    DefineProp('ParentControl',tkClass,__GetTCustomFileRunParentControl,__SetTCustomFileRunParentControl,TWinControl,false,0);
    DefineProp('Parameters',tkVariant,__GetTCustomFileRunParameters,__SetTCustomFileRunParameters,nil,false,0);
    DefineProp('ShowCmd',tkEnumeration,__GetTCustomFileRunShowCmd,__SetTCustomFileRunShowCmd,nil,false,0);
  end;
  With Scripter.DefineClass(TFileRun) do
  begin
  end;
  With Scripter.DefineClass(TRichEditAction) do
  begin
    DefineMethod('Create',1,tkClass,TRichEditAction,__TRichEditActionCreate,true,0);
    DefineMethod('HandlesTarget',1,tkVariant,nil,__TRichEditActionHandlesTarget,false,0);
  end;
  With Scripter.DefineClass(TRichEditBold) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TRichEditBoldExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TRichEditBoldUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TRichEditItalic) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TRichEditItalicExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TRichEditItalicUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TRichEditUnderline) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TRichEditUnderlineExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TRichEditUnderlineUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TRichEditStrikeOut) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TRichEditStrikeOutExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TRichEditStrikeOutUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TRichEditBullets) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TRichEditBulletsExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TRichEditBulletsUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TRichEditAlignLeft) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TRichEditAlignLeftExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TRichEditAlignLeftUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TRichEditAlignRight) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TRichEditAlignRightExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TRichEditAlignRightUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TRichEditAlignCenter) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TRichEditAlignCenterExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TRichEditAlignCenterUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TTabAction) do
  begin
    DefineMethod('Create',1,tkClass,TTabAction,__TTabActionCreate,true,0);
    DefineMethod('HandlesTarget',1,tkVariant,nil,__TTabActionHandlesTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TTabActionUpdateTarget,false,0);
    DefineProp('SkipHiddenTabs',tkVariant,__GetTTabActionSkipHiddenTabs,__SetTTabActionSkipHiddenTabs,nil,false,0);
    DefineProp('TabControl',tkClass,__GetTTabActionTabControl,__SetTTabActionTabControl,TCustomTabControl,false,0);
    DefineProp('Wrap',tkVariant,__GetTTabActionWrap,__SetTTabActionWrap,nil,false,0);
  end;
  With Scripter.DefineClass(TPreviousTab) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TPreviousTabExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TPreviousTabUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TNextTab) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TNextTabExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TNextTabUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TOpenPicture) do
  begin
  end;
  With Scripter.DefineClass(TSavePicture) do
  begin
  end;
  With Scripter.DefineClass(TSendMail) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TSendMailDestroy,false,0);
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TSendMailExecuteTarget,false,0);
    DefineMethod('HandlesTarget',1,tkVariant,nil,__TSendMailHandlesTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TSendMailUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TListControlAction) do
  begin
    DefineMethod('Create',1,tkClass,TListControlAction,__TListControlActionCreate,true,0);
    DefineMethod('HandlesTarget',1,tkVariant,nil,__TListControlActionHandlesTarget,false,0);
    DefineProp('ListControl',tkClass,__GetTListControlActionListControl,__SetTListControlActionListControl,TCustomListControl,false,0);
  end;
  With Scripter.DefineClass(TListControlSelectAll) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TListControlSelectAllExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TListControlSelectAllUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TListControlClearSelection) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TListControlClearSelectionExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TListControlClearSelectionUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TListControlDeleteSelection) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TListControlDeleteSelectionExecuteTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TListControlDeleteSelectionUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TListControlCopySelection) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TListControlCopySelectionExecuteTarget,false,0);
    DefineMethod('HandlesTarget',1,tkVariant,nil,__TListControlCopySelectionHandlesTarget,false,0);
    DefineMethod('UpdateTarget',1,tkNone,nil,__TListControlCopySelectionUpdateTarget,false,0);
  end;
  With Scripter.DefineClass(TListControlMoveSelection) do
  begin
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TListControlMoveSelectionExecuteTarget,false,0);
  end;
  DefineEventAdapter(TypeInfo(TValidateTabEvent), TatExtActnsDispatcher, @TatExtActnsDispatcher.__TValidateTabEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('scHide',scHide);
    AddConstant('scMaximize',scMaximize);
    AddConstant('scMinimize',scMinimize);
    AddConstant('scRestore',scRestore);
    AddConstant('scShow',scShow);
    AddConstant('scShowDefault',scShowDefault);
    AddConstant('scShowMaximized',scShowMaximized);
    AddConstant('scShowMinimized',scShowMinimized);
    AddConstant('scShowMinNoActive',scShowMinNoActive);
    AddConstant('scShowNA',scShowNA);
    AddConstant('scShowNoActivate',scShowNoActivate);
    AddConstant('scShowNormal',scShowNormal);
  end;
end;

class function TatExtActnsLibrary.LibraryName: string;
begin
  result := 'ExtActns';
end;

initialization
  RegisterScripterLibrary(TatExtActnsLibrary, True);

{$WARNINGS ON}

end.

