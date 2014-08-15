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
unit ap_DrTable;

interface

uses
  Windows,
  SysUtils,
  Classes,
  BDE,
  DB,
  DBTables,
  DrTable,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatDrTableLibrary = class(TatScripterLibrary)
    procedure __GetTQueryDescriptionQuery(AMachine: TatVirtualMachine);
    procedure __SetTQueryDescriptionQuery(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TDRListClass = class of TDRList;
  TDRDataSetClass = class of TDRDataSet;
  TDRObjectDescListClass = class of TDRObjectDescList;
  TDRObjectItemsClass = class of TDRObjectItems;
  TDRRelationshipDescListClass = class of TDRRelationshipDescList;
  TDRAttrDescListClass = class of TDRAttrDescList;
  TDRInstanceItemsClass = class of TDRInstanceItems;
  TDRObjectListClass = class of TDRObjectList;
  TDRRelationshipListClass = class of TDRRelationshipList;
  TQueryDescriptionClass = class of TQueryDescription;



implementation



procedure TatDrTableLibrary.__GetTQueryDescriptionQuery(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TQueryDescription(CurrentObject).Query));
  end;
end;

procedure TatDrTableLibrary.__SetTQueryDescriptionQuery(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TQueryDescription(CurrentObject).Query:=TQuery(Integer(GetInputArg(0)));
  end;
end;

procedure TatDrTableLibrary.Init;
begin
  With Scripter.DefineClass(TDRList) do
  begin
  end;
  With Scripter.DefineClass(TDRDataSet) do
  begin
  end;
  With Scripter.DefineClass(TDRObjectDescList) do
  begin
  end;
  With Scripter.DefineClass(TDRObjectItems) do
  begin
  end;
  With Scripter.DefineClass(TDRRelationshipDescList) do
  begin
  end;
  With Scripter.DefineClass(TDRAttrDescList) do
  begin
  end;
  With Scripter.DefineClass(TDRInstanceItems) do
  begin
  end;
  With Scripter.DefineClass(TDRObjectList) do
  begin
  end;
  With Scripter.DefineClass(TDRRelationshipList) do
  begin
  end;
  With Scripter.DefineClass(TQueryDescription) do
  begin
    DefineProp('Query',tkClass,__GetTQueryDescriptionQuery,__SetTQueryDescriptionQuery,TQuery,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatDrTableLibrary.LibraryName: string;
begin
  result := 'DrTable';
end;

initialization
  RegisterScripterLibrary(TatDrTableLibrary, True);

{$WARNINGS ON}

end.

