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
unit ap_IBUpdateSQL;

interface

uses
  SysUtils,
  Classes,
  DB,
  IB,
  IBCustomDataSet,
  IBQuery,
  IBUpdateSQL,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatIBUpdateSQLLibrary = class(TatScripterLibrary)
    procedure __TIBUpdateSQLCreate(AMachine: TatVirtualMachine);
    procedure __TIBUpdateSQLDestroy(AMachine: TatVirtualMachine);
    procedure __TIBUpdateSQLApply(AMachine: TatVirtualMachine);
    procedure __TIBUpdateSQLExecSQL(AMachine: TatVirtualMachine);
    procedure __TIBUpdateSQLSetParams(AMachine: TatVirtualMachine);
    procedure __GetTIBUpdateSQLQuery(AMachine: TatVirtualMachine);
    procedure __GetTIBUpdateSQLSQL(AMachine: TatVirtualMachine);
    procedure __SetTIBUpdateSQLSQL(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBUpdateSQLClass = class of TIBUpdateSQL;



implementation



procedure TatIBUpdateSQLLibrary.__TIBUpdateSQLCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBUpdateSQLClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBUpdateSQLLibrary.__TIBUpdateSQLDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBUpdateSQL(CurrentObject).Destroy;
  end;
end;

procedure TatIBUpdateSQLLibrary.__TIBUpdateSQLApply(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBUpdateSQL(CurrentObject).Apply(GetInputArg(0));
  end;
end;

procedure TatIBUpdateSQLLibrary.__TIBUpdateSQLExecSQL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBUpdateSQL(CurrentObject).ExecSQL(GetInputArg(0));
  end;
end;

procedure TatIBUpdateSQLLibrary.__TIBUpdateSQLSetParams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBUpdateSQL(CurrentObject).SetParams(GetInputArg(0));
  end;
end;

procedure TatIBUpdateSQLLibrary.__GetTIBUpdateSQLQuery(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBUpdateSQL(CurrentObject).Query[GetArrayIndex(0)]));
  end;
end;

procedure TatIBUpdateSQLLibrary.__GetTIBUpdateSQLSQL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBUpdateSQL(CurrentObject).SQL[GetArrayIndex(0)]));
  end;
end;

procedure TatIBUpdateSQLLibrary.__SetTIBUpdateSQLSQL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBUpdateSQL(CurrentObject).SQL[GetArrayIndex(0)]:=TStrings(Integer(GetInputArg(0)));
  end;
end;

procedure TatIBUpdateSQLLibrary.Init;
begin
  With Scripter.DefineClass(TIBUpdateSQL) do
  begin
    DefineMethod('Create',1,tkClass,TIBUpdateSQL,__TIBUpdateSQLCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBUpdateSQLDestroy,false,0);
    DefineMethod('Apply',1,tkNone,nil,__TIBUpdateSQLApply,false,0);
    DefineMethod('ExecSQL',1,tkNone,nil,__TIBUpdateSQLExecSQL,false,0);
    DefineMethod('SetParams',1,tkNone,nil,__TIBUpdateSQLSetParams,false,0);
    DefineProp('DataSet',tkVariant,nil,nil,nil,false,0);
    DefineProp('Query',tkClass,__GetTIBUpdateSQLQuery,nil,TIBQuery,false,1);
    DefineProp('SQL',tkClass,__GetTIBUpdateSQLSQL,__SetTIBUpdateSQLSQL,TStrings,false,1);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatIBUpdateSQLLibrary.LibraryName: string;
begin
  result := 'IBUpdateSQL';
end;

initialization
  RegisterScripterLibrary(TatIBUpdateSQLLibrary, True);

{$WARNINGS ON}

end.

