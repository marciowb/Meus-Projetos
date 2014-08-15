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
unit ap_Mtx;

interface

uses
  Windows,
  Mtx,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatMtxLibrary = class(TatScripterLibrary)
    procedure __GetCLASS_TransactionContext(AMachine: TatVirtualMachine);
    procedure __GetCLASS_TransactionContextEx(AMachine: TatVirtualMachine);
    procedure __GetCLASS_SharedPropertyGroupManager(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatMtxLibrary.__GetCLASS_TransactionContext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Mtx.CLASS_TransactionContext)));
  end;
end;

procedure TatMtxLibrary.__GetCLASS_TransactionContextEx(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Mtx.CLASS_TransactionContextEx)));
  end;
end;

procedure TatMtxLibrary.__GetCLASS_SharedPropertyGroupManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Mtx.CLASS_SharedPropertyGroupManager)));
  end;
end;

procedure TatMtxLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('CLASS_TransactionContext',tkVariant,__GetCLASS_TransactionContext,nil,nil,false,0);
    DefineProp('CLASS_TransactionContextEx',tkVariant,__GetCLASS_TransactionContextEx,nil,nil,false,0);
    DefineProp('CLASS_SharedPropertyGroupManager',tkVariant,__GetCLASS_SharedPropertyGroupManager,nil,nil,false,0);
    AddConstant('mtsErrCtxAborted',mtsErrCtxAborted);
    AddConstant('mtsErrCtxAborting',mtsErrCtxAborting);
    AddConstant('mtsErrCtxNoContext',mtsErrCtxNoContext);
    AddConstant('mtsErrCtxNotRegistered',mtsErrCtxNotRegistered);
    AddConstant('mtsErrCtxActivityTimeout',mtsErrCtxActivityTimeout);
    AddConstant('mtsErrCtxOldReference',mtsErrCtxOldReference);
    AddConstant('mtsErrCtxRoleNotFound',mtsErrCtxRoleNotFound);
    AddConstant('mtsErrCtxNoSecurity',mtsErrCtxNoSecurity);
    AddConstant('mtsErrCtxWrongThread',mtsErrCtxWrongThread);
    AddConstant('mtsErrCtxTMNotAvailable',mtsErrCtxTMNotAvailable);
    AddConstant('LockSetGet',LockSetGet);
    AddConstant('LockMethod',LockMethod);
    AddConstant('Standard',Standard);
    AddConstant('Process',Process);
  end;
end;

class function TatMtxLibrary.LibraryName: string;
begin
  result := 'Mtx';
end;

initialization
  RegisterScripterLibrary(TatMtxLibrary, True);

{$WARNINGS ON}

end.

