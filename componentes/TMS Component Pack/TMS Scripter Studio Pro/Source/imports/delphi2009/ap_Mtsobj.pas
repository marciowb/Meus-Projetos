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
unit ap_Mtsobj;

interface

uses
  Windows,
  ComObj,
  Mtx,
  Mtsobj,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatMtsobjLibrary = class(TatScripterLibrary)
    procedure __TMtsAutoObjectSetComplete(AMachine: TatVirtualMachine);
    procedure __TMtsAutoObjectSetAbort(AMachine: TatVirtualMachine);
    procedure __TMtsAutoObjectEnableCommit(AMachine: TatVirtualMachine);
    procedure __TMtsAutoObjectDisableCommit(AMachine: TatVirtualMachine);
    procedure __TMtsAutoObjectIsInTransaction(AMachine: TatVirtualMachine);
    procedure __TMtsAutoObjectIsSecurityEnabled(AMachine: TatVirtualMachine);
    procedure __TMtsAutoObjectIsCallerInRole(AMachine: TatVirtualMachine);
    procedure __GetTMtsAutoObjectPooled(AMachine: TatVirtualMachine);
    procedure __SetTMtsAutoObjectPooled(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TMtsAutoObjectClass = class of TMtsAutoObject;



implementation



procedure TatMtsobjLibrary.__TMtsAutoObjectSetComplete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMtsAutoObject(CurrentObject).SetComplete;
  end;
end;

procedure TatMtsobjLibrary.__TMtsAutoObjectSetAbort(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMtsAutoObject(CurrentObject).SetAbort;
  end;
end;

procedure TatMtsobjLibrary.__TMtsAutoObjectEnableCommit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMtsAutoObject(CurrentObject).EnableCommit;
  end;
end;

procedure TatMtsobjLibrary.__TMtsAutoObjectDisableCommit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMtsAutoObject(CurrentObject).DisableCommit;
  end;
end;

procedure TatMtsobjLibrary.__TMtsAutoObjectIsInTransaction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TMtsAutoObject(CurrentObject).IsInTransaction;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMtsobjLibrary.__TMtsAutoObjectIsSecurityEnabled(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TMtsAutoObject(CurrentObject).IsSecurityEnabled;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMtsobjLibrary.__TMtsAutoObjectIsCallerInRole(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TMtsAutoObject(CurrentObject).IsCallerInRole(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMtsobjLibrary.__GetTMtsAutoObjectPooled(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TMtsAutoObject(CurrentObject).Pooled);
  end;
end;

procedure TatMtsobjLibrary.__SetTMtsAutoObjectPooled(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMtsAutoObject(CurrentObject).Pooled:=GetInputArg(0);
  end;
end;

procedure TatMtsobjLibrary.Init;
begin
  With Scripter.DefineClass(TMtsAutoObject) do
  begin
    DefineMethod('SetComplete',0,tkNone,nil,__TMtsAutoObjectSetComplete,false,0);
    DefineMethod('SetAbort',0,tkNone,nil,__TMtsAutoObjectSetAbort,false,0);
    DefineMethod('EnableCommit',0,tkNone,nil,__TMtsAutoObjectEnableCommit,false,0);
    DefineMethod('DisableCommit',0,tkNone,nil,__TMtsAutoObjectDisableCommit,false,0);
    DefineMethod('IsInTransaction',0,tkVariant,nil,__TMtsAutoObjectIsInTransaction,false,0);
    DefineMethod('IsSecurityEnabled',0,tkVariant,nil,__TMtsAutoObjectIsSecurityEnabled,false,0);
    DefineMethod('IsCallerInRole',1,tkVariant,nil,__TMtsAutoObjectIsCallerInRole,false,0);
    DefineProp('Pooled',tkVariant,__GetTMtsAutoObjectPooled,__SetTMtsAutoObjectPooled,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatMtsobjLibrary.LibraryName: string;
begin
  result := 'Mtsobj';
end;

initialization
  RegisterScripterLibrary(TatMtsobjLibrary, True);

{$WARNINGS ON}

end.

