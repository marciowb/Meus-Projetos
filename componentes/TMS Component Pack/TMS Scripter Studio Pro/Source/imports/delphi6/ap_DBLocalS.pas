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
unit ap_DBLocalS;

interface

uses
  Windows,
  SysUtils,
  Variants,
  Classes,
  Db,
  DBCommon,
  Midas,
  SqlTimSt,
  DBClient,
  DBLocal,
  Provider,
  SqlExpr,
  DBLocalS,
  atScript;

{$WARNINGS OFF}

type
  TatDBLocalSLibrary = class(TatScripterLibrary)
    procedure __TSQLClientDataSetCreate(AMachine: TatVirtualMachine);
    procedure __TSQLClientDataSetDestroy(AMachine: TatVirtualMachine);
    procedure __TSQLClientDataSetCloneCursor(AMachine: TatVirtualMachine);
    procedure __TSQLClientDataSetGetQuoteChar(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TSQLClientDataSetClass = class of TSQLClientDataSet;



implementation



procedure TatDBLocalSLibrary.__TSQLClientDataSetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSQLClientDataSetClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLocalSLibrary.__TSQLClientDataSetDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLClientDataSet(CurrentObject).Destroy;
  end;
end;

procedure TatDBLocalSLibrary.__TSQLClientDataSetCloneCursor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      2: TSQLClientDataSet(CurrentObject).CloneCursor(TCustomClientDataSet(Integer(GetInputArg(0))),GetInputArg(1));
      3: TSQLClientDataSet(CurrentObject).CloneCursor(TCustomClientDataSet(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
    end;
  end;
end;

procedure TatDBLocalSLibrary.__TSQLClientDataSetGetQuoteChar(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TSQLClientDataSet(CurrentObject).GetQuoteChar;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLocalSLibrary.Init;
begin
  With Scripter.DefineClass(TSQLClientDataSet) do
  begin
    DefineMethod('Create',1,tkClass,TSQLClientDataSet,__TSQLClientDataSetCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TSQLClientDataSetDestroy,false,0);
    DefineMethod('CloneCursor',3,tkNone,nil,__TSQLClientDataSetCloneCursor,false,1);
    DefineMethod('GetQuoteChar',0,tkVariant,nil,__TSQLClientDataSetGetQuoteChar,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatDBLocalSLibrary.LibraryName: string;
begin
  result := 'DBLocalS';
end;

initialization
  RegisterScripterLibrary(TatDBLocalSLibrary, True);

{$WARNINGS ON}

end.

