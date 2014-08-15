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
unit ap_DBLocal;

interface

uses
  Windows,
  SysUtils,
  Variants,
  Classes,
  DB,
  DBCommon,
  Midas,
  SqlTimSt,
  DBClient,
  Provider,
  DBLocal,
  atScript;

{$WARNINGS OFF}

type
  TatDBLocalLibrary = class(TatScripterLibrary)
    procedure __TCustomCachedDataSetCreate(AMachine: TatVirtualMachine);
    procedure __TCustomCachedDataSetDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomCachedDataSetLoadFromFile(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCustomCachedDataSetClass = class of TCustomCachedDataSet;



implementation



procedure TatDBLocalLibrary.__TCustomCachedDataSetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomCachedDataSetClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLocalLibrary.__TCustomCachedDataSetDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomCachedDataSet(CurrentObject).Destroy;
  end;
end;

procedure TatDBLocalLibrary.__TCustomCachedDataSetLoadFromFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      0: TCustomCachedDataSet(CurrentObject).LoadFromFile;
      1: TCustomCachedDataSet(CurrentObject).LoadFromFile(GetInputArg(0));
    end;
  end;
end;

procedure TatDBLocalLibrary.Init;
begin
  With Scripter.DefineClass(TCustomCachedDataSet) do
  begin
    DefineMethod('Create',1,tkClass,TCustomCachedDataSet,__TCustomCachedDataSetCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomCachedDataSetDestroy,false,0);
    DefineMethod('LoadFromFile',1,tkNone,nil,__TCustomCachedDataSetLoadFromFile,false,1);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('typeDBX',typeDBX);
    AddConstant('typeBDE',typeBDE);
    AddConstant('typeADO',typeADO);
    AddConstant('typeIBX',typeIBX);
  end;
end;

class function TatDBLocalLibrary.LibraryName: string;
begin
  result := 'DBLocal';
end;

initialization
  RegisterScripterLibrary(TatDBLocalLibrary, True);

{$WARNINGS ON}

end.

