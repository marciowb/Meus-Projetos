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
unit ap_CtlPanel;

interface

uses
  Windows,
  SysUtils,
  Classes,
  Graphics,
  Cpl,
  CtlPanel,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatCtlPanelLibrary = class(TatScripterLibrary)
    procedure __TAppletModuleCreate(AMachine: TatVirtualMachine);
    procedure __TAppletModuleDestroy(AMachine: TatVirtualMachine);
    procedure __GetTAppletModuleData(AMachine: TatVirtualMachine);
    procedure __SetTAppletModuleData(AMachine: TatVirtualMachine);
    procedure __TAppletApplicationCreate(AMachine: TatVirtualMachine);
    procedure __TAppletApplicationDestroy(AMachine: TatVirtualMachine);
    procedure __TAppletApplicationHandleException(AMachine: TatVirtualMachine);
    procedure __TAppletApplicationInitialize(AMachine: TatVirtualMachine);
    procedure __TAppletApplicationRun(AMachine: TatVirtualMachine);
    procedure __GetTAppletApplicationModules(AMachine: TatVirtualMachine);
    procedure __SetTAppletApplicationModules(AMachine: TatVirtualMachine);
    procedure __GetTAppletApplicationModuleCount(AMachine: TatVirtualMachine);
    procedure __SetTAppletApplicationModuleCount(AMachine: TatVirtualMachine);
    procedure __GetTAppletApplicationControlPanelHandle(AMachine: TatVirtualMachine);
    procedure __CPlApplet(AMachine: TatVirtualMachine);
    procedure __GetApplication(AMachine: TatVirtualMachine);
    procedure __SetApplication(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EAppletExceptionClass = class of EAppletException;
  TAppletModuleClass = class of TAppletModule;
  TAppletApplicationClass = class of TAppletApplication;

  TatCtlPanelDispatcher = class(TatEventDispatcher)
  private
    procedure __TInitEvent( Sender: TObject; var AppInitOK: Boolean);
    procedure __TCountEvent( Sender: TObject; var AppCount: Integer);
    procedure __TExitEvent( Sender: TObject);
    procedure __TSetupEvent( Sender: TObject);
    procedure __TActivateEvent( Sender: TObject;  Data: LongInt);
    procedure __TStopEvent( Sender: TObject;  Data: LongInt);
    procedure __TInquireEvent( Sender: TObject; var idIcon: Integer; var idName: Integer; var idInfo: Integer; var lData: Integer);
    procedure __TNewInquireEvent( Sender: TObject; var lData: Integer; var hIcon: HICON; var AppletName: string; var AppletInfo: string);
    procedure __TStartWParmsEvent( Sender: TObject;  Params: string);
    procedure __TOnAppletExceptionEvent( Sender: TObject;  E: Exception);
  end;


implementation



procedure TatCtlPanelLibrary.__TAppletModuleCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAppletModuleClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCtlPanelLibrary.__TAppletModuleDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAppletModule(CurrentObject).Destroy;
  end;
end;

procedure TatCtlPanelLibrary.__GetTAppletModuleData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAppletModule(CurrentObject).Data));
  end;
end;

procedure TatCtlPanelLibrary.__SetTAppletModuleData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAppletModule(CurrentObject).Data:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatCtlPanelLibrary.__TAppletApplicationCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAppletApplicationClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCtlPanelLibrary.__TAppletApplicationDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAppletApplication(CurrentObject).Destroy;
  end;
end;

procedure TatCtlPanelLibrary.__TAppletApplicationHandleException(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAppletApplication(CurrentObject).HandleException(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatCtlPanelLibrary.__TAppletApplicationInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAppletApplication(CurrentObject).Initialize;
  end;
end;

procedure TatCtlPanelLibrary.__TAppletApplicationRun(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAppletApplication(CurrentObject).Run;
  end;
end;

procedure TatCtlPanelLibrary.__GetTAppletApplicationModules(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAppletApplication(CurrentObject).Modules[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatCtlPanelLibrary.__SetTAppletApplicationModules(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAppletApplication(CurrentObject).Modules[VarToInteger(GetArrayIndex(0))]:=TAppletModule(Integer(GetInputArg(0)));
  end;
end;

procedure TatCtlPanelLibrary.__GetTAppletApplicationModuleCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAppletApplication(CurrentObject).ModuleCount));
  end;
end;

procedure TatCtlPanelLibrary.__SetTAppletApplicationModuleCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAppletApplication(CurrentObject).ModuleCount:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatCtlPanelLibrary.__GetTAppletApplicationControlPanelHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAppletApplication(CurrentObject).ControlPanelHandle));
  end;
end;

procedure TatCtlPanelDispatcher.__TInitEvent( Sender: TObject; var AppInitOK: Boolean);
var
  AppInitOKTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TInitEvent(BeforeCall)(Sender,AppInitOK);
    AppInitOKTemp := AppInitOK;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,AppInitOKTemp]);
    AppInitOK := AppInitOKTemp;
    if AssignedMethod(AfterCall) then
      TInitEvent(AfterCall)(Sender,AppInitOK);
  end;
end;

procedure TatCtlPanelDispatcher.__TCountEvent( Sender: TObject; var AppCount: Integer);
var
  AppCountTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TCountEvent(BeforeCall)(Sender,AppCount);
    AppCountTemp := Integer(AppCount);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,AppCountTemp]);
    AppCount := VarToInteger(AppCountTemp);
    if AssignedMethod(AfterCall) then
      TCountEvent(AfterCall)(Sender,AppCount);
  end;
end;

procedure TatCtlPanelDispatcher.__TExitEvent( Sender: TObject);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TExitEvent(BeforeCall)(Sender);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender]);
    if AssignedMethod(AfterCall) then
      TExitEvent(AfterCall)(Sender);
  end;
end;

procedure TatCtlPanelDispatcher.__TSetupEvent( Sender: TObject);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TSetupEvent(BeforeCall)(Sender);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender]);
    if AssignedMethod(AfterCall) then
      TSetupEvent(AfterCall)(Sender);
  end;
end;

procedure TatCtlPanelDispatcher.__TActivateEvent( Sender: TObject;  Data: LongInt);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TActivateEvent(BeforeCall)(Sender,Data);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Data]);
    if AssignedMethod(AfterCall) then
      TActivateEvent(AfterCall)(Sender,Data);
  end;
end;

procedure TatCtlPanelDispatcher.__TStopEvent( Sender: TObject;  Data: LongInt);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TStopEvent(BeforeCall)(Sender,Data);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Data]);
    if AssignedMethod(AfterCall) then
      TStopEvent(AfterCall)(Sender,Data);
  end;
end;

procedure TatCtlPanelDispatcher.__TInquireEvent( Sender: TObject; var idIcon: Integer; var idName: Integer; var idInfo: Integer; var lData: Integer);
var
  idIconTemp: variant;
  idNameTemp: variant;
  idInfoTemp: variant;
  lDataTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TInquireEvent(BeforeCall)(Sender,idIcon,idName,idInfo,lData);
    idIconTemp := Integer(idIcon);
    idNameTemp := Integer(idName);
    idInfoTemp := Integer(idInfo);
    lDataTemp := Integer(lData);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,idIconTemp,idNameTemp,idInfoTemp,lDataTemp]);
    idIcon := VarToInteger(idIconTemp);
    idName := VarToInteger(idNameTemp);
    idInfo := VarToInteger(idInfoTemp);
    lData := VarToInteger(lDataTemp);
    if AssignedMethod(AfterCall) then
      TInquireEvent(AfterCall)(Sender,idIcon,idName,idInfo,lData);
  end;
end;

procedure TatCtlPanelDispatcher.__TNewInquireEvent( Sender: TObject; var lData: Integer; var hIcon: HICON; var AppletName: string; var AppletInfo: string);
var
  lDataTemp: variant;
  hIconTemp: variant;
  AppletNameTemp: variant;
  AppletInfoTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TNewInquireEvent(BeforeCall)(Sender,lData,hIcon,AppletName,AppletInfo);
    lDataTemp := Integer(lData);
    hIconTemp := Integer(hIcon);
    AppletNameTemp := AppletName;
    AppletInfoTemp := AppletInfo;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,lDataTemp,hIconTemp,AppletNameTemp,AppletInfoTemp]);
    lData := VarToInteger(lDataTemp);
    hIcon := VarToInteger(hIconTemp);
    AppletName := AppletNameTemp;
    AppletInfo := AppletInfoTemp;
    if AssignedMethod(AfterCall) then
      TNewInquireEvent(AfterCall)(Sender,lData,hIcon,AppletName,AppletInfo);
  end;
end;

procedure TatCtlPanelDispatcher.__TStartWParmsEvent( Sender: TObject;  Params: string);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TStartWParmsEvent(BeforeCall)(Sender,Params);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Params]);
    if AssignedMethod(AfterCall) then
      TStartWParmsEvent(AfterCall)(Sender,Params);
  end;
end;

procedure TatCtlPanelDispatcher.__TOnAppletExceptionEvent( Sender: TObject;  E: Exception);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TOnAppletExceptionEvent(BeforeCall)(Sender,E);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,E]);
    if AssignedMethod(AfterCall) then
      TOnAppletExceptionEvent(AfterCall)(Sender,E);
  end;
end;

procedure TatCtlPanelLibrary.__CPlApplet(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(CtlPanel.CPlApplet(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCtlPanelLibrary.__GetApplication(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(CtlPanel.Application));
  end;
end;

procedure TatCtlPanelLibrary.__SetApplication(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    CtlPanel.Application:=TAppletApplication(Integer(GetInputArg(0)));
  end;
end;

procedure TatCtlPanelLibrary.Init;
begin
  With Scripter.DefineClass(EAppletException) do
  begin
  end;
  With Scripter.DefineClass(TAppletModule) do
  begin
    DefineMethod('Create',1,tkClass,TAppletModule,__TAppletModuleCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TAppletModuleDestroy,false,0);
    DefineProp('Data',tkInteger,__GetTAppletModuleData,__SetTAppletModuleData,nil,false,0);
  end;
  With Scripter.DefineClass(TAppletApplication) do
  begin
    DefineMethod('Create',1,tkClass,TAppletApplication,__TAppletApplicationCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TAppletApplicationDestroy,false,0);
    DefineMethod('HandleException',1,tkNone,nil,__TAppletApplicationHandleException,false,0);
    DefineMethod('Initialize',0,tkNone,nil,__TAppletApplicationInitialize,false,0);
    DefineMethod('Run',0,tkNone,nil,__TAppletApplicationRun,false,0);
    DefineProp('Modules',tkClass,__GetTAppletApplicationModules,__SetTAppletApplicationModules,TAppletModule,false,1);
    DefineProp('ModuleCount',tkInteger,__GetTAppletApplicationModuleCount,__SetTAppletApplicationModuleCount,nil,false,0);
    DefineProp('ControlPanelHandle',tkInteger,__GetTAppletApplicationControlPanelHandle,nil,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TInitEvent), TatCtlPanelDispatcher, @TatCtlPanelDispatcher.__TInitEvent);
  DefineEventAdapter(TypeInfo(TCountEvent), TatCtlPanelDispatcher, @TatCtlPanelDispatcher.__TCountEvent);
  DefineEventAdapter(TypeInfo(TExitEvent), TatCtlPanelDispatcher, @TatCtlPanelDispatcher.__TExitEvent);
  DefineEventAdapter(TypeInfo(TSetupEvent), TatCtlPanelDispatcher, @TatCtlPanelDispatcher.__TSetupEvent);
  DefineEventAdapter(TypeInfo(TActivateEvent), TatCtlPanelDispatcher, @TatCtlPanelDispatcher.__TActivateEvent);
  DefineEventAdapter(TypeInfo(TStopEvent), TatCtlPanelDispatcher, @TatCtlPanelDispatcher.__TStopEvent);
  DefineEventAdapter(TypeInfo(TInquireEvent), TatCtlPanelDispatcher, @TatCtlPanelDispatcher.__TInquireEvent);
  DefineEventAdapter(TypeInfo(TNewInquireEvent), TatCtlPanelDispatcher, @TatCtlPanelDispatcher.__TNewInquireEvent);
  DefineEventAdapter(TypeInfo(TStartWParmsEvent), TatCtlPanelDispatcher, @TatCtlPanelDispatcher.__TStartWParmsEvent);
  DefineEventAdapter(TypeInfo(TOnAppletExceptionEvent), TatCtlPanelDispatcher, @TatCtlPanelDispatcher.__TOnAppletExceptionEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('CPlApplet',4,tkInteger,nil,__CPlApplet,false,0);
    DefineProp('Application',tkClass,__GetApplication,__SetApplication,TAppletApplication,false,0);
  end;
end;

class function TatCtlPanelLibrary.LibraryName: string;
begin
  result := 'CtlPanel';
end;

initialization
  RegisterScripterLibrary(TatCtlPanelLibrary, True);

{$WARNINGS ON}

end.

