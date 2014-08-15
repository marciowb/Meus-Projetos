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
unit ap_recerror;

interface

uses
  SysUtils,
  Windows,
  Variants,
  Messages,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  Grids,
  DB,
  DBClient,
  Provider,
  ExtCtrls,
  DBConsts,
  recerror,
  atScript;

{$WARNINGS OFF}

type
  TatrecerrorLibrary = class(TatScripterLibrary)
    procedure __TReconcileErrorFormFormCreate(AMachine: TatVirtualMachine);
    procedure __TReconcileErrorFormFormDestroy(AMachine: TatVirtualMachine);
    procedure __TReconcileErrorFormUpdateDataSetEditText(AMachine: TatVirtualMachine);
    procedure __TReconcileErrorFormDisplayFieldValues(AMachine: TatVirtualMachine);
    procedure __TReconcileErrorFormUpdateDataSelectCell(AMachine: TatVirtualMachine);
    procedure __TReconcileErrorFormCreateForm(AMachine: TatVirtualMachine);
    procedure __HandleReconcileError(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TReconcileErrorFormClass = class of TReconcileErrorForm;



implementation



procedure TatrecerrorLibrary.__TReconcileErrorFormFormCreate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TReconcileErrorForm(CurrentObject).FormCreate(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatrecerrorLibrary.__TReconcileErrorFormFormDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TReconcileErrorForm(CurrentObject).FormDestroy(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatrecerrorLibrary.__TReconcileErrorFormUpdateDataSetEditText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TReconcileErrorForm(CurrentObject).UpdateDataSetEditText(TObject(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),GetInputArg(3));
  end;
end;

procedure TatrecerrorLibrary.__TReconcileErrorFormDisplayFieldValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TReconcileErrorForm(CurrentObject).DisplayFieldValues(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatrecerrorLibrary.__TReconcileErrorFormUpdateDataSelectCell(AMachine: TatVirtualMachine);
  var
  Param3: Boolean;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
    TReconcileErrorForm(CurrentObject).UpdateDataSelectCell(TObject(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3);
    SetInputArg(3,Param3);
  end;
end;

procedure TatrecerrorLibrary.__TReconcileErrorFormCreateForm(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TReconcileErrorFormClass(CurrentClass.ClassRef).CreateForm(TDataSet(Integer(GetInputArg(0))),GetInputArg(1),EReconcileError(Integer(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatrecerrorLibrary.__HandleReconcileError(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := recerror.HandleReconcileError(TDataSet(Integer(GetInputArg(0))),GetInputArg(1),EReconcileError(Integer(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatrecerrorLibrary.Init;
begin
  With Scripter.DefineClass(TReconcileErrorForm) do
  begin
    DefineMethod('FormCreate',1,tkNone,nil,__TReconcileErrorFormFormCreate,false,0);
    DefineMethod('FormDestroy',1,tkNone,nil,__TReconcileErrorFormFormDestroy,false,0);
    DefineMethod('UpdateDataSetEditText',4,tkNone,nil,__TReconcileErrorFormUpdateDataSetEditText,false,0);
    DefineMethod('DisplayFieldValues',1,tkNone,nil,__TReconcileErrorFormDisplayFieldValues,false,0);
    DefineMethod('UpdateDataSelectCell',4,tkNone,nil,__TReconcileErrorFormUpdateDataSelectCell,false,0).SetVarArgs([3]);
    DefineMethod('CreateForm',3,tkClass,TReconcileErrorForm,__TReconcileErrorFormCreateForm,true,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('HandleReconcileError',3,tkEnumeration,nil,__HandleReconcileError,false,0);
  end;
end;

class function TatrecerrorLibrary.LibraryName: string;
begin
  result := 'recerror';
end;

initialization
  RegisterScripterLibrary(TatrecerrorLibrary, True);

{$WARNINGS ON}

end.

