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
unit ap_DBLocalB;

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
  DBLocal,
  Provider,
  DBTables,
  DBLocalB,
  atScript;

{$WARNINGS OFF}

type
  TatDBLocalBLibrary = class(TatScripterLibrary)
    procedure __TBDEClientDataSetCreate(AMachine: TatVirtualMachine);
    procedure __TBDEClientDataSetDestroy(AMachine: TatVirtualMachine);
    procedure __TBDEClientDataSetCloneCursor(AMachine: TatVirtualMachine);
    procedure __TBDEClientDataSetGetQuoteChar(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TBDEQueryClass = class of TBDEQuery;
  TBDEClientDataSetClass = class of TBDEClientDataSet;



implementation



procedure TatDBLocalBLibrary.__TBDEClientDataSetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBDEClientDataSetClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLocalBLibrary.__TBDEClientDataSetDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBDEClientDataSet(CurrentObject).Destroy;
  end;
end;

procedure TatDBLocalBLibrary.__TBDEClientDataSetCloneCursor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      2: TBDEClientDataSet(CurrentObject).CloneCursor(TCustomClientDataSet(Integer(GetInputArg(0))),GetInputArg(1));
      3: TBDEClientDataSet(CurrentObject).CloneCursor(TCustomClientDataSet(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
    end;
  end;
end;

procedure TatDBLocalBLibrary.__TBDEClientDataSetGetQuoteChar(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TBDEClientDataSet(CurrentObject).GetQuoteChar;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLocalBLibrary.Init;
begin
  With Scripter.DefineClass(TBDEQuery) do
  begin
  end;
  With Scripter.DefineClass(TBDEClientDataSet) do
  begin
    DefineMethod('Create',1,tkClass,TBDEClientDataSet,__TBDEClientDataSetCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TBDEClientDataSetDestroy,false,0);
    DefineMethod('CloneCursor',3,tkNone,nil,__TBDEClientDataSetCloneCursor,false,1);
    DefineMethod('GetQuoteChar',0,tkVariant,nil,__TBDEClientDataSetGetQuoteChar,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatDBLocalBLibrary.LibraryName: string;
begin
  result := 'DBLocalB';
end;

initialization
  RegisterScripterLibrary(TatDBLocalBLibrary, True);

{$WARNINGS ON}

end.

