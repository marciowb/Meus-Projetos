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
unit ap_DBLocalI;

interface

uses
  Windows,
  SysUtils,
  Variants,
  Classes,
  Db,
  DBCommon,
  Midas,
  IBQuery,
  IBDatabase,
  IB,
  DBClient,
  DBLocal,
  Provider,
  DBLocalI,
  atScript;

{$WARNINGS OFF}

type
  TatDBLocalILibrary = class(TatScripterLibrary)
    procedure __TIBClientDataSetCreate(AMachine: TatVirtualMachine);
    procedure __TIBClientDataSetDestroy(AMachine: TatVirtualMachine);
    procedure __TIBClientDataSetCloneCursor(AMachine: TatVirtualMachine);
    procedure __TIBClientDataSetGetQuoteChar(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBCDSQueryClass = class of TIBCDSQuery;
  TIBClientDataSetClass = class of TIBClientDataSet;



implementation



procedure TatDBLocalILibrary.__TIBClientDataSetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBClientDataSetClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLocalILibrary.__TIBClientDataSetDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBClientDataSet(CurrentObject).Destroy;
  end;
end;

procedure TatDBLocalILibrary.__TIBClientDataSetCloneCursor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      2: TIBClientDataSet(CurrentObject).CloneCursor(TCustomClientDataSet(Integer(GetInputArg(0))),GetInputArg(1));
      3: TIBClientDataSet(CurrentObject).CloneCursor(TCustomClientDataSet(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
    end;
  end;
end;

procedure TatDBLocalILibrary.__TIBClientDataSetGetQuoteChar(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBClientDataSet(CurrentObject).GetQuoteChar;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLocalILibrary.Init;
begin
  With Scripter.DefineClass(TIBCDSQuery) do
  begin
  end;
  With Scripter.DefineClass(TIBClientDataSet) do
  begin
    DefineMethod('Create',1,tkClass,TIBClientDataSet,__TIBClientDataSetCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBClientDataSetDestroy,false,0);
    DefineMethod('CloneCursor',3,tkNone,nil,__TIBClientDataSetCloneCursor,false,1);
    DefineMethod('GetQuoteChar',0,tkVariant,nil,__TIBClientDataSetGetQuoteChar,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatDBLocalILibrary.LibraryName: string;
begin
  result := 'DBLocalI';
end;

initialization
  RegisterScripterLibrary(TatDBLocalILibrary, True);

{$WARNINGS ON}

end.

