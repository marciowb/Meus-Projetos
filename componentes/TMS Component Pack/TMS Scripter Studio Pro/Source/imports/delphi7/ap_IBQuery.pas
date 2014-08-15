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
unit ap_IBQuery;

interface

uses
  Classes,
  DB,
  IBHeader,
  IB,
  IBDatabase,
  IBCustomDataSet,
  IBSQL,
  IBQuery,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatIBQueryLibrary = class(TatScripterLibrary)
    procedure __TIBQueryCreate(AMachine: TatVirtualMachine);
    procedure __TIBQueryDestroy(AMachine: TatVirtualMachine);
    procedure __TIBQueryBatchInput(AMachine: TatVirtualMachine);
    procedure __TIBQueryBatchOutput(AMachine: TatVirtualMachine);
    procedure __TIBQueryExecSQL(AMachine: TatVirtualMachine);
    procedure __TIBQueryGetDetailLinkFields(AMachine: TatVirtualMachine);
    procedure __TIBQueryParamByName(AMachine: TatVirtualMachine);
    procedure __TIBQueryPrepare(AMachine: TatVirtualMachine);
    procedure __TIBQueryUnPrepare(AMachine: TatVirtualMachine);
    procedure __GetTIBQueryPrepared(AMachine: TatVirtualMachine);
    procedure __SetTIBQueryPrepared(AMachine: TatVirtualMachine);
    procedure __GetTIBQueryParamCount(AMachine: TatVirtualMachine);
    procedure __GetTIBQueryText(AMachine: TatVirtualMachine);
    procedure __GetTIBQueryRowsAffected(AMachine: TatVirtualMachine);
    procedure __GetTIBQueryGenerateParamNames(AMachine: TatVirtualMachine);
    procedure __SetTIBQueryGenerateParamNames(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBQueryClass = class of TIBQuery;



implementation



procedure TatIBQueryLibrary.__TIBQueryCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBQueryClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBQueryLibrary.__TIBQueryDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBQuery(CurrentObject).Destroy;
  end;
end;

procedure TatIBQueryLibrary.__TIBQueryBatchInput(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBQuery(CurrentObject).BatchInput(TIBBatchInput(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBQueryLibrary.__TIBQueryBatchOutput(AMachine: TatVirtualMachine);
  var
  Param0: TIBBatchOutput;
begin
  with AMachine do
  begin
Param0 := TIBBatchOutput(Integer(GetInputArg(0)));
    TIBQuery(CurrentObject).BatchOutput(Param0);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatIBQueryLibrary.__TIBQueryExecSQL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBQuery(CurrentObject).ExecSQL;
  end;
end;

procedure TatIBQueryLibrary.__TIBQueryGetDetailLinkFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBQuery(CurrentObject).GetDetailLinkFields(TList(Integer(GetInputArg(0))),TList(Integer(GetInputArg(1))));
  end;
end;

procedure TatIBQueryLibrary.__TIBQueryParamByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBQuery(CurrentObject).ParamByName(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBQueryLibrary.__TIBQueryPrepare(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBQuery(CurrentObject).Prepare;
  end;
end;

procedure TatIBQueryLibrary.__TIBQueryUnPrepare(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBQuery(CurrentObject).UnPrepare;
  end;
end;

procedure TatIBQueryLibrary.__GetTIBQueryPrepared(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBQuery(CurrentObject).Prepared);
  end;
end;

procedure TatIBQueryLibrary.__SetTIBQueryPrepared(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBQuery(CurrentObject).Prepared:=GetInputArg(0);
  end;
end;

procedure TatIBQueryLibrary.__GetTIBQueryParamCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBQuery(CurrentObject).ParamCount));
  end;
end;

procedure TatIBQueryLibrary.__GetTIBQueryText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBQuery(CurrentObject).Text);
  end;
end;

procedure TatIBQueryLibrary.__GetTIBQueryRowsAffected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBQuery(CurrentObject).RowsAffected));
  end;
end;

procedure TatIBQueryLibrary.__GetTIBQueryGenerateParamNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBQuery(CurrentObject).GenerateParamNames);
  end;
end;

procedure TatIBQueryLibrary.__SetTIBQueryGenerateParamNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBQuery(CurrentObject).GenerateParamNames:=GetInputArg(0);
  end;
end;

procedure TatIBQueryLibrary.Init;
begin
  With Scripter.DefineClass(TIBQuery) do
  begin
    DefineMethod('Create',1,tkClass,TIBQuery,__TIBQueryCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBQueryDestroy,false,0);
    DefineMethod('BatchInput',1,tkNone,nil,__TIBQueryBatchInput,false,0);
    DefineMethod('BatchOutput',1,tkNone,nil,__TIBQueryBatchOutput,false,0).SetVarArgs([0]);
    DefineMethod('ExecSQL',0,tkNone,nil,__TIBQueryExecSQL,false,0);
    DefineMethod('GetDetailLinkFields',2,tkNone,nil,__TIBQueryGetDetailLinkFields,false,0);
    DefineMethod('ParamByName',1,tkClass,TParam,__TIBQueryParamByName,false,0);
    DefineMethod('Prepare',0,tkNone,nil,__TIBQueryPrepare,false,0);
    DefineMethod('UnPrepare',0,tkNone,nil,__TIBQueryUnPrepare,false,0);
    DefineProp('LiveMode',tkVariant,nil,nil,nil,false,0);
    DefineProp('Prepared',tkVariant,__GetTIBQueryPrepared,__SetTIBQueryPrepared,nil,false,0);
    DefineProp('ParamCount',tkInteger,__GetTIBQueryParamCount,nil,nil,false,0);
    DefineProp('StatementType',tkVariant,nil,nil,nil,false,0);
    DefineProp('Text',tkVariant,__GetTIBQueryText,nil,nil,false,0);
    DefineProp('RowsAffected',tkInteger,__GetTIBQueryRowsAffected,nil,nil,false,0);
    DefineProp('GenerateParamNames',tkVariant,__GetTIBQueryGenerateParamNames,__SetTIBQueryGenerateParamNames,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatIBQueryLibrary.LibraryName: string;
begin
  result := 'IBQuery';
end;

initialization
  RegisterScripterLibrary(TatIBQueryLibrary, True);

{$WARNINGS ON}

end.

