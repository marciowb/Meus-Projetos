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
unit ap_Dbexcept;

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
  Db,
  DBTables,
  Dbexcept,
  atScript;

{$WARNINGS OFF}

type
  TatDbexceptLibrary = class(TatScripterLibrary)
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



procedure TatDbexceptLibrary.__TDbEngineErrorDlgFormShow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDbEngineErrorDlg(CurrentObject).FormShow(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatDbexceptLibrary.__TDbEngineErrorDlgBackClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDbEngineErrorDlg(CurrentObject).BackClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatDbexceptLibrary.__TDbEngineErrorDlgNextClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDbEngineErrorDlg(CurrentObject).NextClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatDbexceptLibrary.__TDbEngineErrorDlgFormCreate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDbEngineErrorDlg(CurrentObject).FormCreate(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatDbexceptLibrary.__TDbEngineErrorDlgDetailsBtnClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDbEngineErrorDlg(CurrentObject).DetailsBtnClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatDbexceptLibrary.__TDbEngineErrorDlgFormDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDbEngineErrorDlg(CurrentObject).FormDestroy(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatDbexceptLibrary.__TDbEngineErrorDlgHookExceptions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDbEngineErrorDlg(CurrentObject).HookExceptions;
  end;
end;

procedure TatDbexceptLibrary.__TDbEngineErrorDlgShowException(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDbEngineErrorDlg(CurrentObject).ShowException(EDBEngineError(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDbexceptLibrary.__GetTDbEngineErrorDlgDbException(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDbEngineErrorDlg(CurrentObject).DbException));
  end;
end;

procedure TatDbexceptLibrary.__SetTDbEngineErrorDlgDbException(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDbEngineErrorDlg(CurrentObject).DbException:=EDBEngineError(Integer(GetInputArg(0)));
  end;
end;

procedure TatDbexceptLibrary.__GetDbEngineErrorDlg(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(Dbexcept.DbEngineErrorDlg));
  end;
end;

procedure TatDbexceptLibrary.__SetDbEngineErrorDlg(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Dbexcept.DbEngineErrorDlg:=TDbEngineErrorDlg(Integer(GetInputArg(0)));
  end;
end;

procedure TatDbexceptLibrary.Init;
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

class function TatDbexceptLibrary.LibraryName: string;
begin
  result := 'Dbexcept';
end;

initialization
  RegisterScripterLibrary(TatDbexceptLibrary, True);

{$WARNINGS ON}

end.

