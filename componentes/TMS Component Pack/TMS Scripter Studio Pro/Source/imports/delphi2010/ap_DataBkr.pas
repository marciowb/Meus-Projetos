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
unit ap_DataBkr;

interface

uses
  Windows,
  Variants,
  ActiveX,
  Classes,
  Midas,
  Provider,
  SysUtils,
  DataBkr,
  atScript;

{$WARNINGS OFF}

type
  TatDataBkrLibrary = class(TatScripterLibrary)
    procedure __TProviderDataModuleCreate(AMachine: TatVirtualMachine);
    procedure __TProviderDataModuleDestroy(AMachine: TatVirtualMachine);
    procedure __TProviderDataModuleProviderNamesToVariant(AMachine: TatVirtualMachine);
    procedure __TProviderDataModuleRegisterProvider(AMachine: TatVirtualMachine);
    procedure __TProviderDataModuleUnRegisterProvider(AMachine: TatVirtualMachine);
    procedure __GetTProviderDataModuleProviders(AMachine: TatVirtualMachine);
    procedure __GetTProviderDataModuleProviderCount(AMachine: TatVirtualMachine);
    procedure __TRemoteDataModuleCreate(AMachine: TatVirtualMachine);
    procedure __TRemoteDataModuleDestroy(AMachine: TatVirtualMachine);
    procedure __TRemoteDataModuleLock(AMachine: TatVirtualMachine);
    procedure __TRemoteDataModuleUnlock(AMachine: TatVirtualMachine);
    procedure __TCRemoteDataModuleCreate(AMachine: TatVirtualMachine);
    procedure __TCRemoteDataModuleDestroy(AMachine: TatVirtualMachine);
    procedure __TCRemoteDataModuleRegisterProvider(AMachine: TatVirtualMachine);
    procedure __TCRemoteDataModuleUnRegisterProvider(AMachine: TatVirtualMachine);
    procedure __TCRemoteDataModuleLock(AMachine: TatVirtualMachine);
    procedure __TCRemoteDataModuleUnLock(AMachine: TatVirtualMachine);
    procedure __TCRemoteDataModuleCRDMGetProviderNames(AMachine: TatVirtualMachine);
    procedure __TCRemoteDataModuleGetProvider(AMachine: TatVirtualMachine);
    procedure __GetTCRemoteDataModuleProviders(AMachine: TatVirtualMachine);
    procedure __GetTCRemoteDataModuleProviderCount(AMachine: TatVirtualMachine);
    procedure __RegisterPooled(AMachine: TatVirtualMachine);
    procedure __UnregisterPooled(AMachine: TatVirtualMachine);
    procedure __EnableSocketTransport(AMachine: TatVirtualMachine);
    procedure __DisableSocketTransport(AMachine: TatVirtualMachine);
    procedure __EnableWebTransport(AMachine: TatVirtualMachine);
    procedure __DisableWebTransport(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TProviderDataModuleClass = class of TProviderDataModule;
  TRemoteDataModuleClass = class of TRemoteDataModule;
  TCRemoteDataModuleClass = class of TCRemoteDataModule;



implementation



procedure TatDataBkrLibrary.__TProviderDataModuleCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TProviderDataModuleClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDataBkrLibrary.__TProviderDataModuleDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TProviderDataModule(CurrentObject).Destroy;
  end;
end;

procedure TatDataBkrLibrary.__TProviderDataModuleProviderNamesToVariant(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TProviderDataModule(CurrentObject).ProviderNamesToVariant;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDataBkrLibrary.__TProviderDataModuleRegisterProvider(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TProviderDataModule(CurrentObject).RegisterProvider(TCustomProvider(Integer(GetInputArg(0))));
  end;
end;

procedure TatDataBkrLibrary.__TProviderDataModuleUnRegisterProvider(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TProviderDataModule(CurrentObject).UnRegisterProvider(TCustomProvider(Integer(GetInputArg(0))));
  end;
end;

procedure TatDataBkrLibrary.__GetTProviderDataModuleProviders(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TProviderDataModule(CurrentObject).Providers[GetArrayIndex(0)]));
  end;
end;

procedure TatDataBkrLibrary.__GetTProviderDataModuleProviderCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TProviderDataModule(CurrentObject).ProviderCount));
  end;
end;

procedure TatDataBkrLibrary.__TRemoteDataModuleCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRemoteDataModuleClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDataBkrLibrary.__TRemoteDataModuleDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRemoteDataModule(CurrentObject).Destroy;
  end;
end;

procedure TatDataBkrLibrary.__TRemoteDataModuleLock(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRemoteDataModule(CurrentObject).Lock;
  end;
end;

procedure TatDataBkrLibrary.__TRemoteDataModuleUnlock(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRemoteDataModule(CurrentObject).Unlock;
  end;
end;

procedure TatDataBkrLibrary.__TCRemoteDataModuleCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCRemoteDataModuleClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDataBkrLibrary.__TCRemoteDataModuleDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCRemoteDataModule(CurrentObject).Destroy;
  end;
end;

procedure TatDataBkrLibrary.__TCRemoteDataModuleRegisterProvider(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCRemoteDataModule(CurrentObject).RegisterProvider(TCustomProvider(Integer(GetInputArg(0))));
  end;
end;

procedure TatDataBkrLibrary.__TCRemoteDataModuleUnRegisterProvider(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCRemoteDataModule(CurrentObject).UnRegisterProvider(TCustomProvider(Integer(GetInputArg(0))));
  end;
end;

procedure TatDataBkrLibrary.__TCRemoteDataModuleLock(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCRemoteDataModule(CurrentObject).Lock;
  end;
end;

procedure TatDataBkrLibrary.__TCRemoteDataModuleUnLock(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCRemoteDataModule(CurrentObject).UnLock;
  end;
end;

procedure TatDataBkrLibrary.__TCRemoteDataModuleCRDMGetProviderNames(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCRemoteDataModule(CurrentObject).CRDMGetProviderNames;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDataBkrLibrary.__TCRemoteDataModuleGetProvider(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCRemoteDataModule(CurrentObject).GetProvider(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDataBkrLibrary.__GetTCRemoteDataModuleProviders(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCRemoteDataModule(CurrentObject).Providers[GetArrayIndex(0)]));
  end;
end;

procedure TatDataBkrLibrary.__GetTCRemoteDataModuleProviderCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCRemoteDataModule(CurrentObject).ProviderCount));
  end;
end;

procedure TatDataBkrLibrary.__RegisterPooled(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      3: DataBkr.RegisterPooled(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
      4: DataBkr.RegisterPooled(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),GetInputArg(3));
    end;
  end;
end;

procedure TatDataBkrLibrary.__UnregisterPooled(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DataBkr.UnregisterPooled(GetInputArg(0));
  end;
end;

procedure TatDataBkrLibrary.__EnableSocketTransport(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DataBkr.EnableSocketTransport(GetInputArg(0));
  end;
end;

procedure TatDataBkrLibrary.__DisableSocketTransport(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DataBkr.DisableSocketTransport(GetInputArg(0));
  end;
end;

procedure TatDataBkrLibrary.__EnableWebTransport(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DataBkr.EnableWebTransport(GetInputArg(0));
  end;
end;

procedure TatDataBkrLibrary.__DisableWebTransport(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DataBkr.DisableWebTransport(GetInputArg(0));
  end;
end;

procedure TatDataBkrLibrary.Init;
begin
  With Scripter.DefineClass(TProviderDataModule) do
  begin
    DefineMethod('Create',1,tkClass,TProviderDataModule,__TProviderDataModuleCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TProviderDataModuleDestroy,false,0);
    DefineMethod('ProviderNamesToVariant',0,tkVariant,nil,__TProviderDataModuleProviderNamesToVariant,false,0);
    DefineMethod('RegisterProvider',1,tkNone,nil,__TProviderDataModuleRegisterProvider,false,0);
    DefineMethod('UnRegisterProvider',1,tkNone,nil,__TProviderDataModuleUnRegisterProvider,false,0);
    DefineProp('Providers',tkClass,__GetTProviderDataModuleProviders,nil,TCustomProvider,false,1);
    DefineProp('ProviderCount',tkInteger,__GetTProviderDataModuleProviderCount,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRemoteDataModule) do
  begin
    DefineMethod('Create',1,tkClass,TRemoteDataModule,__TRemoteDataModuleCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TRemoteDataModuleDestroy,false,0);
    DefineMethod('Lock',0,tkNone,nil,__TRemoteDataModuleLock,false,0);
    DefineMethod('Unlock',0,tkNone,nil,__TRemoteDataModuleUnlock,false,0);
  end;
  With Scripter.DefineClass(TCRemoteDataModule) do
  begin
    DefineMethod('Create',1,tkClass,TCRemoteDataModule,__TCRemoteDataModuleCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCRemoteDataModuleDestroy,false,0);
    DefineMethod('RegisterProvider',1,tkNone,nil,__TCRemoteDataModuleRegisterProvider,false,0);
    DefineMethod('UnRegisterProvider',1,tkNone,nil,__TCRemoteDataModuleUnRegisterProvider,false,0);
    DefineMethod('Lock',0,tkNone,nil,__TCRemoteDataModuleLock,false,0);
    DefineMethod('UnLock',0,tkNone,nil,__TCRemoteDataModuleUnLock,false,0);
    DefineMethod('CRDMGetProviderNames',0,tkVariant,nil,__TCRemoteDataModuleCRDMGetProviderNames,false,0);
    DefineMethod('GetProvider',1,tkClass,TCustomProvider,__TCRemoteDataModuleGetProvider,false,0);
    DefineProp('Providers',tkClass,__GetTCRemoteDataModuleProviders,nil,TCustomProvider,false,1);
    DefineProp('ProviderCount',tkInteger,__GetTCRemoteDataModuleProviderCount,nil,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('RegisterPooled',4,tkNone,nil,__RegisterPooled,false,1);
    DefineMethod('UnregisterPooled',1,tkNone,nil,__UnregisterPooled,false,0);
    DefineMethod('EnableSocketTransport',1,tkNone,nil,__EnableSocketTransport,false,0);
    DefineMethod('DisableSocketTransport',1,tkNone,nil,__DisableSocketTransport,false,0);
    DefineMethod('EnableWebTransport',1,tkNone,nil,__EnableWebTransport,false,0);
    DefineMethod('DisableWebTransport',1,tkNone,nil,__DisableWebTransport,false,0);
  end;
end;

class function TatDataBkrLibrary.LibraryName: string;
begin
  result := 'DataBkr';
end;

initialization
  RegisterScripterLibrary(TatDataBkrLibrary, True);

{$WARNINGS ON}

end.

