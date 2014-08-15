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
unit ap_MtsRdm;

interface

uses
  Windows,
  Classes,
  DataBkr,
  Mtx,
  Midas,
  MtsRdm,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatMtsRdmLibrary = class(TatScripterLibrary)
    procedure __TMtsDataModuleCreate(AMachine: TatVirtualMachine);
    procedure __TMtsDataModuleSetComplete(AMachine: TatVirtualMachine);
    procedure __TMtsDataModuleSetAbort(AMachine: TatVirtualMachine);
    procedure __TMtsDataModuleEnableCommit(AMachine: TatVirtualMachine);
    procedure __TMtsDataModuleDisableCommit(AMachine: TatVirtualMachine);
    procedure __TMtsDataModuleIsInTransaction(AMachine: TatVirtualMachine);
    procedure __TMtsDataModuleIsSecurityEnabled(AMachine: TatVirtualMachine);
    procedure __TMtsDataModuleIsCallerInRole(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TMtsDataModuleClass = class of TMtsDataModule;



implementation



procedure TatMtsRdmLibrary.__TMtsDataModuleCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMtsDataModuleClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMtsRdmLibrary.__TMtsDataModuleSetComplete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMtsDataModule(CurrentObject).SetComplete;
  end;
end;

procedure TatMtsRdmLibrary.__TMtsDataModuleSetAbort(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMtsDataModule(CurrentObject).SetAbort;
  end;
end;

procedure TatMtsRdmLibrary.__TMtsDataModuleEnableCommit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMtsDataModule(CurrentObject).EnableCommit;
  end;
end;

procedure TatMtsRdmLibrary.__TMtsDataModuleDisableCommit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMtsDataModule(CurrentObject).DisableCommit;
  end;
end;

procedure TatMtsRdmLibrary.__TMtsDataModuleIsInTransaction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TMtsDataModule(CurrentObject).IsInTransaction;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMtsRdmLibrary.__TMtsDataModuleIsSecurityEnabled(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TMtsDataModule(CurrentObject).IsSecurityEnabled;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMtsRdmLibrary.__TMtsDataModuleIsCallerInRole(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TMtsDataModule(CurrentObject).IsCallerInRole(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMtsRdmLibrary.Init;
begin
  With Scripter.DefineClass(TMtsDataModule) do
  begin
    DefineMethod('Create',1,tkClass,TMtsDataModule,__TMtsDataModuleCreate,true,0);
    DefineMethod('SetComplete',0,tkNone,nil,__TMtsDataModuleSetComplete,false,0);
    DefineMethod('SetAbort',0,tkNone,nil,__TMtsDataModuleSetAbort,false,0);
    DefineMethod('EnableCommit',0,tkNone,nil,__TMtsDataModuleEnableCommit,false,0);
    DefineMethod('DisableCommit',0,tkNone,nil,__TMtsDataModuleDisableCommit,false,0);
    DefineMethod('IsInTransaction',0,tkVariant,nil,__TMtsDataModuleIsInTransaction,false,0);
    DefineMethod('IsSecurityEnabled',0,tkVariant,nil,__TMtsDataModuleIsSecurityEnabled,false,0);
    DefineMethod('IsCallerInRole',1,tkVariant,nil,__TMtsDataModuleIsCallerInRole,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatMtsRdmLibrary.LibraryName: string;
begin
  result := 'MtsRdm';
end;

initialization
  RegisterScripterLibrary(TatMtsRdmLibrary, True);

{$WARNINGS ON}

end.

