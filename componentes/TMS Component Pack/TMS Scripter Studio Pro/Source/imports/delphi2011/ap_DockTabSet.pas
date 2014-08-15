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
unit ap_DockTabSet;

interface

uses
  Windows,
  SysUtils,
  Classes,
  Controls,
  Tabs,
  Messages,
  Types,
  ExtCtrls,
  Contnrs,
  CaptionedDockTree,
  Graphics,
  DockTabSet,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatDockTabSetLibrary = class(TatScripterLibrary)
    procedure __TTabDockPanelCreate(AMachine: TatVirtualMachine);
    procedure __TTabDockPanelDestroy(AMachine: TatVirtualMachine);
    procedure __TTabDockPanelUpdateDockCaptionPin(AMachine: TatVirtualMachine);
    procedure __GetTTabDockPanelAnimateSpeed(AMachine: TatVirtualMachine);
    procedure __SetTTabDockPanelAnimateSpeed(AMachine: TatVirtualMachine);
    procedure __TDockClientInfoCreate(AMachine: TatVirtualMachine);
    procedure __TDockClientInfoDestroy(AMachine: TatVirtualMachine);
    procedure __TDockClientInfoCreateTab(AMachine: TatVirtualMachine);
    procedure __GetTDockClientInfoDockClient(AMachine: TatVirtualMachine);
    procedure __GetTDockClientInfoDockTabSet(AMachine: TatVirtualMachine);
    procedure __GetTDockClientInfoImageIndex(AMachine: TatVirtualMachine);
    procedure __SetTDockClientInfoImageIndex(AMachine: TatVirtualMachine);
    procedure __GetTDockClientInfoListIndex(AMachine: TatVirtualMachine);
    procedure __GetTDockClientInfoParentPanel(AMachine: TatVirtualMachine);
    procedure __GetTDockClientInfoTabIndex(AMachine: TatVirtualMachine);
    procedure __SetTDockClientInfoTabIndex(AMachine: TatVirtualMachine);
    procedure __TDockTabSetCreate(AMachine: TatVirtualMachine);
    procedure __TDockTabSetDestroy(AMachine: TatVirtualMachine);
    procedure __TDockTabSetShowDockClient(AMachine: TatVirtualMachine);
    procedure __TDockTabSetIndexOfDockClient(AMachine: TatVirtualMachine);
    procedure __TDockTabSetHideCurrentDockClient(AMachine: TatVirtualMachine);
    procedure __TCaptionedTabDockTreeSetAlternateDockHost(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TTabDockPanelClass = class of TTabDockPanel;
  TDockClientInfoClass = class of TDockClientInfo;
  TDockTabSetClass = class of TDockTabSet;
  TCaptionedTabDockTreeClass = class of TCaptionedTabDockTree;
  ETabDockExceptionClass = class of ETabDockException;



implementation



procedure TatDockTabSetLibrary.__TTabDockPanelCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTabDockPanelClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0))),TDockClientInfo(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDockTabSetLibrary.__TTabDockPanelDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabDockPanel(CurrentObject).Destroy;
  end;
end;

procedure TatDockTabSetLibrary.__TTabDockPanelUpdateDockCaptionPin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabDockPanel(CurrentObject).UpdateDockCaptionPin;
  end;
end;

procedure TatDockTabSetLibrary.__GetTTabDockPanelAnimateSpeed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTabDockPanel(CurrentObject).AnimateSpeed));
  end;
end;

procedure TatDockTabSetLibrary.__SetTTabDockPanelAnimateSpeed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabDockPanel(CurrentObject).AnimateSpeed:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDockTabSetLibrary.__TDockClientInfoCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDockClientInfoClass(CurrentClass.ClassRef).Create(TDockTabSet(Integer(GetInputArg(0))),TWinControl(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDockTabSetLibrary.__TDockClientInfoDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDockClientInfo(CurrentObject).Destroy;
  end;
end;

procedure TatDockTabSetLibrary.__TDockClientInfoCreateTab(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      0: TDockClientInfo(CurrentObject).CreateTab;
      1: TDockClientInfo(CurrentObject).CreateTab(GetInputArg(0));
    end;
  end;
end;

procedure TatDockTabSetLibrary.__GetTDockClientInfoDockClient(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDockClientInfo(CurrentObject).DockClient));
  end;
end;

procedure TatDockTabSetLibrary.__GetTDockClientInfoDockTabSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDockClientInfo(CurrentObject).DockTabSet));
  end;
end;

procedure TatDockTabSetLibrary.__GetTDockClientInfoImageIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDockClientInfo(CurrentObject).ImageIndex));
  end;
end;

procedure TatDockTabSetLibrary.__SetTDockClientInfoImageIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDockClientInfo(CurrentObject).ImageIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDockTabSetLibrary.__GetTDockClientInfoListIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDockClientInfo(CurrentObject).ListIndex));
  end;
end;

procedure TatDockTabSetLibrary.__GetTDockClientInfoParentPanel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDockClientInfo(CurrentObject).ParentPanel));
  end;
end;

procedure TatDockTabSetLibrary.__GetTDockClientInfoTabIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDockClientInfo(CurrentObject).TabIndex));
  end;
end;

procedure TatDockTabSetLibrary.__SetTDockClientInfoTabIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDockClientInfo(CurrentObject).TabIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDockTabSetLibrary.__TDockTabSetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDockTabSetClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDockTabSetLibrary.__TDockTabSetDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDockTabSet(CurrentObject).Destroy;
  end;
end;

procedure TatDockTabSetLibrary.__TDockTabSetShowDockClient(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDockTabSet(CurrentObject).ShowDockClient(TControl(Integer(GetInputArg(0))));
  end;
end;

procedure TatDockTabSetLibrary.__TDockTabSetIndexOfDockClient(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDockTabSet(CurrentObject).IndexOfDockClient(TControl(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDockTabSetLibrary.__TDockTabSetHideCurrentDockClient(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      0: TDockTabSet(CurrentObject).HideCurrentDockClient;
      1: TDockTabSet(CurrentObject).HideCurrentDockClient(VarToInteger(GetInputArg(0)));
    end;
  end;
end;

procedure TatDockTabSetLibrary.__TCaptionedTabDockTreeSetAlternateDockHost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCaptionedTabDockTree(CurrentObject).SetAlternateDockHost(TWinControl(Integer(GetInputArg(0))));
  end;
end;

procedure TatDockTabSetLibrary.Init;
begin
  With Scripter.DefineClass(TTabDockPanel) do
  begin
    DefineMethod('Create',2,tkClass,TTabDockPanel,__TTabDockPanelCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TTabDockPanelDestroy,false,0);
    DefineMethod('UpdateDockCaptionPin',0,tkNone,nil,__TTabDockPanelUpdateDockCaptionPin,false,0);
    DefineProp('AnimateSpeed',tkInteger,__GetTTabDockPanelAnimateSpeed,__SetTTabDockPanelAnimateSpeed,nil,false,0);
  end;
  With Scripter.DefineClass(TDockClientInfo) do
  begin
    DefineMethod('Create',2,tkClass,TDockClientInfo,__TDockClientInfoCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDockClientInfoDestroy,false,0);
    DefineMethod('CreateTab',1,tkNone,nil,__TDockClientInfoCreateTab,false,1);
    DefineProp('DockClient',tkClass,__GetTDockClientInfoDockClient,nil,TWinControl,false,0);
    DefineProp('DockTabSet',tkClass,__GetTDockClientInfoDockTabSet,nil,TDockTabSet,false,0);
    DefineProp('ImageIndex',tkInteger,__GetTDockClientInfoImageIndex,__SetTDockClientInfoImageIndex,nil,false,0);
    DefineProp('ListIndex',tkInteger,__GetTDockClientInfoListIndex,nil,nil,false,0);
    DefineProp('ParentPanel',tkClass,__GetTDockClientInfoParentPanel,nil,TTabDockPanel,false,0);
    DefineProp('TabIndex',tkInteger,__GetTDockClientInfoTabIndex,__SetTDockClientInfoTabIndex,nil,false,0);
  end;
  With Scripter.DefineClass(TDockTabSet) do
  begin
    DefineMethod('Create',1,tkClass,TDockTabSet,__TDockTabSetCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDockTabSetDestroy,false,0);
    DefineMethod('ShowDockClient',1,tkNone,nil,__TDockTabSetShowDockClient,false,0);
    DefineMethod('IndexOfDockClient',1,tkInteger,nil,__TDockTabSetIndexOfDockClient,false,0);
    DefineMethod('HideCurrentDockClient',1,tkNone,nil,__TDockTabSetHideCurrentDockClient,false,1);
  end;
  With Scripter.DefineClass(TCaptionedTabDockTree) do
  begin
    DefineMethod('SetAlternateDockHost',1,tkNone,nil,__TCaptionedTabDockTreeSetAlternateDockHost,false,0);
  end;
  With Scripter.DefineClass(ETabDockException) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('WM_PINDOCKCLIENT',WM_PINDOCKCLIENT);
  end;
end;

class function TatDockTabSetLibrary.LibraryName: string;
begin
  result := 'DockTabSet';
end;

initialization
  RegisterScripterLibrary(TatDockTabSetLibrary, True);

{$WARNINGS ON}

end.

