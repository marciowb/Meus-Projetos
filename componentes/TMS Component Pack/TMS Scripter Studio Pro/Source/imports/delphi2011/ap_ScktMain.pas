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
unit ap_ScktMain;

interface

uses
  SvcMgr,
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Menus,
  ShellAPI,
  ExtCtrls,
  StdCtrls,
  ComCtrls,
  ScktComp,
  Registry,
  ActnList,
  ScktMain,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatScktMainLibrary = class(TatScripterLibrary)
    procedure __TSocketFormFormCreate(AMachine: TatVirtualMachine);
    procedure __TSocketFormFormDestroy(AMachine: TatVirtualMachine);
    procedure __TSocketFormmiCloseClick(AMachine: TatVirtualMachine);
    procedure __TSocketFormmiPropertiesClick(AMachine: TatVirtualMachine);
    procedure __TSocketFormFormShow(AMachine: TatVirtualMachine);
    procedure __TSocketFormFormCloseQuery(AMachine: TatVirtualMachine);
    procedure __TSocketFormmiDisconnectClick(AMachine: TatVirtualMachine);
    procedure __TSocketFormmiExitClick(AMachine: TatVirtualMachine);
    procedure __TSocketFormApplyActionExecute(AMachine: TatVirtualMachine);
    procedure __TSocketFormApplyActionUpdate(AMachine: TatVirtualMachine);
    procedure __TSocketFormDisconnectActionUpdate(AMachine: TatVirtualMachine);
    procedure __TSocketFormShowHostActionExecute(AMachine: TatVirtualMachine);
    procedure __TSocketFormmiAddClick(AMachine: TatVirtualMachine);
    procedure __TSocketFormRemovePortActionUpdate(AMachine: TatVirtualMachine);
    procedure __TSocketFormRemovePortActionExecute(AMachine: TatVirtualMachine);
    procedure __TSocketFormUpDownClick(AMachine: TatVirtualMachine);
    procedure __TSocketFormPortListClick(AMachine: TatVirtualMachine);
    procedure __TSocketFormConnectionListCompare(AMachine: TatVirtualMachine);
    procedure __TSocketFormConnectionListColumnClick(AMachine: TatVirtualMachine);
    procedure __TSocketFormIntegerExit(AMachine: TatVirtualMachine);
    procedure __TSocketFormUpdateTimerTimer(AMachine: TatVirtualMachine);
    procedure __TSocketFormRegisteredActionExecute(AMachine: TatVirtualMachine);
    procedure __TSocketFormAllowXMLExecute(AMachine: TatVirtualMachine);
    procedure __TSocketFormInitialize(AMachine: TatVirtualMachine);
    procedure __GetTSocketFormSelectedSocket(AMachine: TatVirtualMachine);
    procedure __GetTSocketFormItemIndex(AMachine: TatVirtualMachine);
    procedure __SetTSocketFormItemIndex(AMachine: TatVirtualMachine);
    procedure __TSocketServiceCreateNew(AMachine: TatVirtualMachine);
    procedure __GetSocketForm(AMachine: TatVirtualMachine);
    procedure __SetSocketForm(AMachine: TatVirtualMachine);
    procedure __GetSocketService(AMachine: TatVirtualMachine);
    procedure __SetSocketService(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TSocketFormClass = class of TSocketForm;
  TSocketServiceClass = class of TSocketService;

  TatScktMainDispatcher = class(TatEventDispatcher)
  private
    procedure __TSocketProc( Item: TListItem;  Socket: TCustomWinSocket);
  end;


implementation



procedure TatScktMainLibrary.__TSocketFormFormCreate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).FormCreate(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormFormDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).FormDestroy(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormmiCloseClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).miCloseClick(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormmiPropertiesClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).miPropertiesClick(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormFormShow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).FormShow(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormFormCloseQuery(AMachine: TatVirtualMachine);
  var
  Param1: Boolean;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    TSocketForm(CurrentObject).FormCloseQuery(TObject(integer(GetInputArg(0))),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatScktMainLibrary.__TSocketFormmiDisconnectClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).miDisconnectClick(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormmiExitClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).miExitClick(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormApplyActionExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).ApplyActionExecute(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormApplyActionUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).ApplyActionUpdate(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormDisconnectActionUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).DisconnectActionUpdate(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormShowHostActionExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).ShowHostActionExecute(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormmiAddClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).miAddClick(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormRemovePortActionUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).RemovePortActionUpdate(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormRemovePortActionExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).RemovePortActionExecute(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormUpDownClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).UpDownClick(TObject(integer(GetInputArg(0))),GetInputArg(1));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormPortListClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).PortListClick(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormConnectionListCompare(AMachine: TatVirtualMachine);
  var
  Param4: Integer;
begin
  with AMachine do
  begin
Param4 := VarToInteger(GetInputArg(4));
    TSocketForm(CurrentObject).ConnectionListCompare(TObject(integer(GetInputArg(0))),TListItem(Integer(GetInputArg(1))),TListItem(Integer(GetInputArg(2))),VarToInteger(GetInputArg(3)),Param4);
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormConnectionListColumnClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).ConnectionListColumnClick(TObject(integer(GetInputArg(0))),TListColumn(Integer(GetInputArg(1))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormIntegerExit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).IntegerExit(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormUpdateTimerTimer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).UpdateTimerTimer(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormRegisteredActionExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).RegisteredActionExecute(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormAllowXMLExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).AllowXMLExecute(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatScktMainLibrary.__TSocketFormInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).Initialize(GetInputArg(0));
  end;
end;

procedure TatScktMainLibrary.__GetTSocketFormSelectedSocket(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSocketForm(CurrentObject).SelectedSocket));
  end;
end;

procedure TatScktMainLibrary.__GetTSocketFormItemIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSocketForm(CurrentObject).ItemIndex));
  end;
end;

procedure TatScktMainLibrary.__SetTSocketFormItemIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketForm(CurrentObject).ItemIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatScktMainLibrary.__TSocketServiceCreateNew(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(TSocketServiceClass(CurrentClass.ClassRef).CreateNew(TComponent(Integer(GetInputArg(0)))));
2: AResult := Integer(TSocketServiceClass(CurrentClass.ClassRef).CreateNew(TComponent(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1))));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktMainDispatcher.__TSocketProc( Item: TListItem;  Socket: TCustomWinSocket);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TSocketProc(BeforeCall)(Item,Socket);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Item,Socket]);
    if AssignedMethod(AfterCall) then
      TSocketProc(AfterCall)(Item,Socket);
  end;
end;

procedure TatScktMainLibrary.__GetSocketForm(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(ScktMain.SocketForm));
  end;
end;

procedure TatScktMainLibrary.__SetSocketForm(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ScktMain.SocketForm:=TSocketForm(Integer(GetInputArg(0)));
  end;
end;

procedure TatScktMainLibrary.__GetSocketService(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(ScktMain.SocketService));
  end;
end;

procedure TatScktMainLibrary.__SetSocketService(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ScktMain.SocketService:=TSocketService(Integer(GetInputArg(0)));
  end;
end;

procedure TatScktMainLibrary.Init;
begin
  With Scripter.DefineClass(TSocketForm) do
  begin
    DefineMethod('FormCreate',1,tkNone,nil,__TSocketFormFormCreate,false,0);
    DefineMethod('FormDestroy',1,tkNone,nil,__TSocketFormFormDestroy,false,0);
    DefineMethod('miCloseClick',1,tkNone,nil,__TSocketFormmiCloseClick,false,0);
    DefineMethod('miPropertiesClick',1,tkNone,nil,__TSocketFormmiPropertiesClick,false,0);
    DefineMethod('FormShow',1,tkNone,nil,__TSocketFormFormShow,false,0);
    DefineMethod('FormCloseQuery',2,tkNone,nil,__TSocketFormFormCloseQuery,false,0).SetVarArgs([1]);
    DefineMethod('miDisconnectClick',1,tkNone,nil,__TSocketFormmiDisconnectClick,false,0);
    DefineMethod('miExitClick',1,tkNone,nil,__TSocketFormmiExitClick,false,0);
    DefineMethod('ApplyActionExecute',1,tkNone,nil,__TSocketFormApplyActionExecute,false,0);
    DefineMethod('ApplyActionUpdate',1,tkNone,nil,__TSocketFormApplyActionUpdate,false,0);
    DefineMethod('DisconnectActionUpdate',1,tkNone,nil,__TSocketFormDisconnectActionUpdate,false,0);
    DefineMethod('ShowHostActionExecute',1,tkNone,nil,__TSocketFormShowHostActionExecute,false,0);
    DefineMethod('miAddClick',1,tkNone,nil,__TSocketFormmiAddClick,false,0);
    DefineMethod('RemovePortActionUpdate',1,tkNone,nil,__TSocketFormRemovePortActionUpdate,false,0);
    DefineMethod('RemovePortActionExecute',1,tkNone,nil,__TSocketFormRemovePortActionExecute,false,0);
    DefineMethod('UpDownClick',2,tkNone,nil,__TSocketFormUpDownClick,false,0);
    DefineMethod('PortListClick',1,tkNone,nil,__TSocketFormPortListClick,false,0);
    DefineMethod('ConnectionListCompare',5,tkNone,nil,__TSocketFormConnectionListCompare,false,0).SetVarArgs([4]);
    DefineMethod('ConnectionListColumnClick',2,tkNone,nil,__TSocketFormConnectionListColumnClick,false,0);
    DefineMethod('IntegerExit',1,tkNone,nil,__TSocketFormIntegerExit,false,0);
    DefineMethod('UpdateTimerTimer',1,tkNone,nil,__TSocketFormUpdateTimerTimer,false,0);
    DefineMethod('RegisteredActionExecute',1,tkNone,nil,__TSocketFormRegisteredActionExecute,false,0);
    DefineMethod('AllowXMLExecute',1,tkNone,nil,__TSocketFormAllowXMLExecute,false,0);
    DefineMethod('Initialize',1,tkNone,nil,__TSocketFormInitialize,false,0);
    DefineProp('SelectedSocket',tkClass,__GetTSocketFormSelectedSocket,nil,TServerSocket,false,0);
    DefineProp('ItemIndex',tkInteger,__GetTSocketFormItemIndex,__SetTSocketFormItemIndex,nil,false,0);
  end;
  With Scripter.DefineClass(TSocketService) do
  begin
    DefineMethod('CreateNew',2,tkClass,TSocketService,__TSocketServiceCreateNew,true,1);
  end;
  DefineEventAdapter(TypeInfo(TSocketProc), TatScktMainDispatcher, @TatScktMainDispatcher.__TSocketProc);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('SocketForm',tkClass,__GetSocketForm,__SetSocketForm,TSocketForm,false,0);
    DefineProp('SocketService',tkClass,__GetSocketService,__SetSocketService,TSocketService,false,0);
    AddConstant('WM_MIDASICON',WM_MIDASICON);
    AddConstant('UI_INITIALIZE',UI_INITIALIZE);
  end;
end;

class function TatScktMainLibrary.LibraryName: string;
begin
  result := 'ScktMain';
end;

initialization
  RegisterScripterLibrary(TatScktMainLibrary, True);

{$WARNINGS ON}

end.

