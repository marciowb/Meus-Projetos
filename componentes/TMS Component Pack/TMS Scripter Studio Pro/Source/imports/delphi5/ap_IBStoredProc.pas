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
unit ap_IBStoredProc;

interface

uses
  SysUtils,
  Classes,
  DB,
  IB,
  IBDatabase,
  IBCustomDataSet,
  IBHeader,
  IBSQL,
  IBUtils,
  IBStoredProc,
  atScript;

{$WARNINGS OFF}

type
  TatIBStoredProcLibrary = class(TatScripterLibrary)
    procedure __TIBStoredProcCreate(AMachine: TatVirtualMachine);
    procedure __TIBStoredProcDestroy(AMachine: TatVirtualMachine);
    procedure __TIBStoredProcCopyParams(AMachine: TatVirtualMachine);
    procedure __TIBStoredProcExecProc(AMachine: TatVirtualMachine);
    procedure __TIBStoredProcParamByName(AMachine: TatVirtualMachine);
    procedure __TIBStoredProcPrepare(AMachine: TatVirtualMachine);
    procedure __TIBStoredProcUnPrepare(AMachine: TatVirtualMachine);
    procedure __GetTIBStoredProcParamCount(AMachine: TatVirtualMachine);
    procedure __GetTIBStoredProcPrepared(AMachine: TatVirtualMachine);
    procedure __SetTIBStoredProcPrepared(AMachine: TatVirtualMachine);
    procedure __GetTIBStoredProcStoredProcedureNames(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBStoredProcClass = class of TIBStoredProc;



implementation



procedure TatIBStoredProcLibrary.__TIBStoredProcCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBStoredProcClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBStoredProcLibrary.__TIBStoredProcDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBStoredProc(CurrentObject).Destroy;
  end;
end;

procedure TatIBStoredProcLibrary.__TIBStoredProcCopyParams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBStoredProc(CurrentObject).CopyParams(TParams(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBStoredProcLibrary.__TIBStoredProcExecProc(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBStoredProc(CurrentObject).ExecProc;
  end;
end;

procedure TatIBStoredProcLibrary.__TIBStoredProcParamByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBStoredProc(CurrentObject).ParamByName(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBStoredProcLibrary.__TIBStoredProcPrepare(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBStoredProc(CurrentObject).Prepare;
  end;
end;

procedure TatIBStoredProcLibrary.__TIBStoredProcUnPrepare(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBStoredProc(CurrentObject).UnPrepare;
  end;
end;

procedure TatIBStoredProcLibrary.__GetTIBStoredProcParamCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBStoredProc(CurrentObject).ParamCount));
  end;
end;

procedure TatIBStoredProcLibrary.__GetTIBStoredProcPrepared(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBStoredProc(CurrentObject).Prepared);
  end;
end;

procedure TatIBStoredProcLibrary.__SetTIBStoredProcPrepared(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBStoredProc(CurrentObject).Prepared:=GetInputArg(0);
  end;
end;

procedure TatIBStoredProcLibrary.__GetTIBStoredProcStoredProcedureNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBStoredProc(CurrentObject).StoredProcedureNames));
  end;
end;

procedure TatIBStoredProcLibrary.Init;
begin
  With Scripter.DefineClass(TIBStoredProc) do
  begin
    DefineMethod('Create',1,tkClass,TIBStoredProc,__TIBStoredProcCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBStoredProcDestroy,false,0);
    DefineMethod('CopyParams',1,tkNone,nil,__TIBStoredProcCopyParams,false,0);
    DefineMethod('ExecProc',0,tkNone,nil,__TIBStoredProcExecProc,false,0);
    DefineMethod('ParamByName',1,tkClass,TParam,__TIBStoredProcParamByName,false,0);
    DefineMethod('Prepare',0,tkNone,nil,__TIBStoredProcPrepare,false,0);
    DefineMethod('UnPrepare',0,tkNone,nil,__TIBStoredProcUnPrepare,false,0);
    DefineProp('ParamCount',tkInteger,__GetTIBStoredProcParamCount,nil,nil,false,0);
    DefineProp('Prepared',tkVariant,__GetTIBStoredProcPrepared,__SetTIBStoredProcPrepared,nil,false,0);
    DefineProp('StoredProcedureNames',tkClass,__GetTIBStoredProcStoredProcedureNames,nil,TStrings,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatIBStoredProcLibrary.LibraryName: string;
begin
  result := 'IBStoredProc';
end;

initialization
  RegisterScripterLibrary(TatIBStoredProcLibrary, True);

{$WARNINGS ON}

end.

