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
unit ap_SimpleDS;

interface

uses
  SysUtils,
  Variants,
  Classes,
  DB,
  DBCommon,
  DBXpress,
  DBClient,
  Provider,
  SqlExpr,
  SqlTimSt,
  SQLConst,
  SimpleDS,
  atScript;

{$WARNINGS OFF}

type
  TatSimpleDSLibrary = class(TatScripterLibrary)
    procedure __TSimpleDataSetCreate(AMachine: TatVirtualMachine);
    procedure __TSimpleDataSetDestroy(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TInternalSQLDataSetClass = class of TInternalSQLDataSet;
  TSimpleDataSetClass = class of TSimpleDataSet;



implementation



procedure TatSimpleDSLibrary.__TSimpleDataSetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSimpleDataSetClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSimpleDSLibrary.__TSimpleDataSetDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSimpleDataSet(CurrentObject).Destroy;
  end;
end;

procedure TatSimpleDSLibrary.Init;
begin
  With Scripter.DefineClass(TInternalSQLDataSet) do
  begin
  end;
  With Scripter.DefineClass(TSimpleDataSet) do
  begin
    DefineMethod('Create',1,tkClass,TSimpleDataSet,__TSimpleDataSetCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TSimpleDataSetDestroy,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatSimpleDSLibrary.LibraryName: string;
begin
  result := 'SimpleDS';
end;

initialization
  RegisterScripterLibrary(TatSimpleDSLibrary, True);

{$WARNINGS ON}

end.

