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
unit ap_IBTable;

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
  IBTable,
  Variants,
  ap_IBCustomDataSet,
  atScript;

{$WARNINGS OFF}

type
  TatIBTableLibrary = class(TatScripterLibrary)
    procedure __TIBTableCreate(AMachine: TatVirtualMachine);
    procedure __TIBTableDestroy(AMachine: TatVirtualMachine);
    procedure __TIBTableAddIndex(AMachine: TatVirtualMachine);
    procedure __TIBTableCreateTable(AMachine: TatVirtualMachine);
    procedure __TIBTableDeleteIndex(AMachine: TatVirtualMachine);
    procedure __TIBTableDeleteTable(AMachine: TatVirtualMachine);
    procedure __TIBTableEmptyTable(AMachine: TatVirtualMachine);
    procedure __TIBTableGetDetailLinkFields(AMachine: TatVirtualMachine);
    procedure __TIBTableGetIndexNames(AMachine: TatVirtualMachine);
    procedure __TIBTableGotoCurrent(AMachine: TatVirtualMachine);
    procedure __TIBTableLocate(AMachine: TatVirtualMachine);
    procedure __GetTIBTableCurrentDBKey(AMachine: TatVirtualMachine);
    procedure __GetTIBTableExists(AMachine: TatVirtualMachine);
    procedure __GetTIBTableIndexFieldCount(AMachine: TatVirtualMachine);
    procedure __GetTIBTableIndexFields(AMachine: TatVirtualMachine);
    procedure __SetTIBTableIndexFields(AMachine: TatVirtualMachine);
    procedure __GetTIBTableTableNames(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBTableClass = class of TIBTable;



implementation



procedure TatIBTableLibrary.__TIBTableCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBTableClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBTableLibrary.__TIBTableDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTable(CurrentObject).Destroy;
  end;
end;

procedure TatIBTableLibrary.__TIBTableAddIndex(AMachine: TatVirtualMachine);
  var
  Param2: TIndexOptions;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
    Case InputArgCount of
      3: TIBTable(CurrentObject).AddIndex(GetInputArg(0),GetInputArg(1),Param2);
      4: TIBTable(CurrentObject).AddIndex(GetInputArg(0),GetInputArg(1),Param2,GetInputArg(3));
    end;
  end;
end;

procedure TatIBTableLibrary.__TIBTableCreateTable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTable(CurrentObject).CreateTable;
  end;
end;

procedure TatIBTableLibrary.__TIBTableDeleteIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTable(CurrentObject).DeleteIndex(GetInputArg(0));
  end;
end;

procedure TatIBTableLibrary.__TIBTableDeleteTable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTable(CurrentObject).DeleteTable;
  end;
end;

procedure TatIBTableLibrary.__TIBTableEmptyTable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTable(CurrentObject).EmptyTable;
  end;
end;

procedure TatIBTableLibrary.__TIBTableGetDetailLinkFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTable(CurrentObject).GetDetailLinkFields(TList(Integer(GetInputArg(0))),TList(Integer(GetInputArg(1))));
  end;
end;

procedure TatIBTableLibrary.__TIBTableGetIndexNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTable(CurrentObject).GetIndexNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBTableLibrary.__TIBTableGotoCurrent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTable(CurrentObject).GotoCurrent(TIBTable(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBTableLibrary.__TIBTableLocate(AMachine: TatVirtualMachine);
  var
  Param2: TLocateOptions;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := TIBTable(CurrentObject).Locate(GetInputArg(0),GetInputArg(1),Param2);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBTableLibrary.__GetTIBTableCurrentDBKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TIBDBKeyWrapper.Create(TIBTable(CurrentObject).CurrentDBKey)));
  end;
end;

procedure TatIBTableLibrary.__GetTIBTableExists(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBTable(CurrentObject).Exists);
  end;
end;

procedure TatIBTableLibrary.__GetTIBTableIndexFieldCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBTable(CurrentObject).IndexFieldCount));
  end;
end;

procedure TatIBTableLibrary.__GetTIBTableIndexFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBTable(CurrentObject).IndexFields[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatIBTableLibrary.__SetTIBTableIndexFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBTable(CurrentObject).IndexFields[VarToInteger(GetArrayIndex(0))]:=TField(Integer(GetInputArg(0)));
  end;
end;

procedure TatIBTableLibrary.__GetTIBTableTableNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBTable(CurrentObject).TableNames));
  end;
end;

procedure TatIBTableLibrary.Init;
begin
  With Scripter.DefineClass(TIBTable) do
  begin
    DefineMethod('Create',1,tkClass,TIBTable,__TIBTableCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBTableDestroy,false,0);
    DefineMethod('AddIndex',4,tkNone,nil,__TIBTableAddIndex,false,1);
    DefineMethod('CreateTable',0,tkNone,nil,__TIBTableCreateTable,false,0);
    DefineMethod('DeleteIndex',1,tkNone,nil,__TIBTableDeleteIndex,false,0);
    DefineMethod('DeleteTable',0,tkNone,nil,__TIBTableDeleteTable,false,0);
    DefineMethod('EmptyTable',0,tkNone,nil,__TIBTableEmptyTable,false,0);
    DefineMethod('GetDetailLinkFields',2,tkNone,nil,__TIBTableGetDetailLinkFields,false,0);
    DefineMethod('GetIndexNames',1,tkNone,nil,__TIBTableGetIndexNames,false,0);
    DefineMethod('GotoCurrent',1,tkNone,nil,__TIBTableGotoCurrent,false,0);
    DefineMethod('Locate',3,tkVariant,nil,__TIBTableLocate,false,0);
    DefineProp('LiveMode',tkVariant,nil,nil,nil,false,0);
    DefineProp('CurrentDBKey',tkVariant,__GetTIBTableCurrentDBKey,nil,nil,false,0);
    DefineProp('Exists',tkVariant,__GetTIBTableExists,nil,nil,false,0);
    DefineProp('IndexFieldCount',tkInteger,__GetTIBTableIndexFieldCount,nil,nil,false,0);
    DefineProp('IndexFields',tkClass,__GetTIBTableIndexFields,__SetTIBTableIndexFields,TField,false,1);
    DefineProp('TableNames',tkClass,__GetTIBTableTableNames,nil,TStrings,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('ttSystem',ttSystem);
    AddConstant('ttView',ttView);
  end;
end;

class function TatIBTableLibrary.LibraryName: string;
begin
  result := 'IBTable';
end;

initialization
  RegisterScripterLibrary(TatIBTableLibrary, True);

{$WARNINGS ON}

end.

