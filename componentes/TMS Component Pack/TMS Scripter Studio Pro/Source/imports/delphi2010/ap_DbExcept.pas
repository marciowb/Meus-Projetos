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
unit ap_DbExcept;

interface

uses
  Windows,
  SysUtils,
  Classes,
  Graphics,
  Forms,
  Controls,
  Buttons,
  StdCtrls,
  ExtCtrls,
  DB,
  DBTables,
  DbExcept,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatDbExceptLibrary = class(TatScripterLibrary)
    procedure __TDbEngineErrorDlgFormShow(AMachine: TatVirtualMachine);
    procedure __TDbEngineErrorDlgBackClick(AMachine: TatVirtualMachine);
    procedure __TDbEngineErrorDlgNextClick(AMachine: TatVirtualMachine);
    procedure __TDbEngineErrorDlgFormCreate(AMachine: TatVirtualMachine);
    procedure __TDbEngineErrorDlgDetailsBtnClick(AMachine: TatVirtualMachine);
    procedure __TDbEngineErrorDlgFormDestroy(AMachine: TatVirtualMachine);
    procedure __TDbEngineErrorDlgHookExceptions(AMachine: TatVirtualMachine);
    procedure __TDbEngineErrorDlgShowException(AMachine: TatVirtualMachine);
    procedure __GetTDbEngineErrorDlgDbException(AMachine: TatVirtualMachine);
    procedure __SetTDbEngineErrorDlgDbException(AMachine: TatVirtualMachine);
    procedure __GetDbEngineErrorDlg(AMachine: TatVirtualMachine);
    procedure __SetDbEngineErrorDlg(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TDbEngineErrorDlgClass = class of TDbEngineErrorDlg;



implementation



procedure TatDbExceptLibrary.__TDbEngineErrorDlgFormShow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDbEngineErrorDlg(CurrentObject).FormShow(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDbExceptLibrary.__TDbEngineErrorDlgBackClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDbEngineErrorDlg(CurrentObject).BackClick(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDbExceptLibrary.__TDbEngineErrorDlgNextClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDbEngineErrorDlg(CurrentObject).NextClick(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDbExceptLibrary.__TDbEngineErrorDlgFormCreate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDbEngineErrorDlg(CurrentObject).FormCreate(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDbExceptLibrary.__TDbEngineErrorDlgDetailsBtnClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDbEngineErrorDlg(CurrentObject).DetailsBtnClick(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDbExceptLibrary.__TDbEngineErrorDlgFormDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDbEngineErrorDlg(CurrentObject).FormDestroy(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatDbExceptLibrary.__TDbEngineErrorDlgHookExceptions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDbEngineErrorDlg(CurrentObject).HookExceptions;
  end;
end;

procedure TatDbExceptLibrary.__TDbEngineErrorDlgShowException(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDbEngineErrorDlg(CurrentObject).ShowException(EDBEngineError(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDbExceptLibrary.__GetTDbEngineErrorDlgDbException(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDbEngineErrorDlg(CurrentObject).DbException));
  end;
end;

procedure TatDbExceptLibrary.__SetTDbEngineErrorDlgDbException(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDbEngineErrorDlg(CurrentObject).DbException:=EDBEngineError(Integer(GetInputArg(0)));
  end;
end;

procedure TatDbExceptLibrary.__GetDbEngineErrorDlg(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(DbExcept.DbEngineErrorDlg));
  end;
end;

procedure TatDbExceptLibrary.__SetDbEngineErrorDlg(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DbExcept.DbEngineErrorDlg:=TDbEngineErrorDlg(Integer(GetInputArg(0)));
  end;
end;

procedure TatDbExceptLibrary.Init;
begin
  With Scripter.DefineClass(TDbEngineErrorDlg) do
  begin
    DefineMethod('FormShow',1,tkNone,nil,__TDbEngineErrorDlgFormShow,false,0);
    DefineMethod('BackClick',1,tkNone,nil,__TDbEngineErrorDlgBackClick,false,0);
    DefineMethod('NextClick',1,tkNone,nil,__TDbEngineErrorDlgNextClick,false,0);
    DefineMethod('FormCreate',1,tkNone,nil,__TDbEngineErrorDlgFormCreate,false,0);
    DefineMethod('DetailsBtnClick',1,tkNone,nil,__TDbEngineErrorDlgDetailsBtnClick,false,0);
    DefineMethod('FormDestroy',1,tkNone,nil,__TDbEngineErrorDlgFormDestroy,false,0);
    DefineMethod('HookExceptions',0,tkNone,nil,__TDbEngineErrorDlgHookExceptions,false,0);
    DefineMethod('ShowException',1,tkEnumeration,nil,__TDbEngineErrorDlgShowException,false,0);
    DefineProp('DbException',tkClass,__GetTDbEngineErrorDlgDbException,__SetTDbEngineErrorDlgDbException,EDBEngineError,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('DbEngineErrorDlg',tkClass,__GetDbEngineErrorDlg,__SetDbEngineErrorDlg,TDbEngineErrorDlg,false,0);
  end;
end;

class function TatDbExceptLibrary.LibraryName: string;
begin
  result := 'DbExcept';
end;

initialization
  RegisterScripterLibrary(TatDbExceptLibrary, True);

{$WARNINGS ON}

end.

