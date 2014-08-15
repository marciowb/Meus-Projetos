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
unit ap_IBFilterDialog;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Buttons,
  StdCtrls,
  ExtCtrls,
  ComCtrls,
  Db,
  IBCustomDataset,
  IBFilterDialog,
  atScript;

{$WARNINGS OFF}

type
  TatIBFilterDialogLibrary = class(TatScripterLibrary)
    procedure __TIBFieldInfoAssign(AMachine: TatVirtualMachine);
    procedure __TIBFieldInfoCreateSQL(AMachine: TatVirtualMachine);
    procedure __TIBFieldInfoSetVariables(AMachine: TatVirtualMachine);
    procedure __TIBVariableCreate(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterDialogRefreshClearButtons(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterDialogFormCreate(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterDialogFieldsListBoxClick(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterDialogFormDestroy(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterDialogpgeFieldsChanging(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterDialogbtnNewSearchClick(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterDialogbtnViewSummaryClick(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterDialogFormActivate(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterDialogbtnCancelClick(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterDialogbtnOkClick(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterDialogbtnClearFieldValueClick(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterDialogbtnClearStartingRangeClick(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterDialogbtnClearEndingRangeClick(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterDialogNewSQL(AMachine: TatVirtualMachine);
    procedure __GetTfrmIBFilterDialogFilterList(AMachine: TatVirtualMachine);
    procedure __GetTfrmIBFilterDialogFilterItem(AMachine: TatVirtualMachine);
    procedure __TIBFilterDialogCreate(AMachine: TatVirtualMachine);
    procedure __TIBFilterDialogDestroy(AMachine: TatVirtualMachine);
    procedure __TIBFilterDialogExecute(AMachine: TatVirtualMachine);
    procedure __TIBFilterDialogReBuildSQL(AMachine: TatVirtualMachine);
    procedure __GetTIBFilterDialogModifiedSQL(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBFieldInfoClass = class of TIBFieldInfo;
  TIBVariableClass = class of TIBVariable;
  TfrmIBFilterDialogClass = class of TfrmIBFilterDialog;
  TIBFilterDialogClass = class of TIBFilterDialog;



implementation



procedure TatIBFilterDialogLibrary.__TIBFieldInfoAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBFieldInfo(CurrentObject).Assign(TIBFieldInfo(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBFilterDialogLibrary.__TIBFieldInfoCreateSQL(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBFieldInfo(CurrentObject).CreateSQL;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBFilterDialogLibrary.__TIBFieldInfoSetVariables(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBFieldInfo(CurrentObject).SetVariables(TIBCustomDataSet(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBFilterDialogLibrary.__TIBVariableCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBVariableClass(CurrentClass.ClassRef).Create(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBFilterDialogLibrary.__TfrmIBFilterDialogRefreshClearButtons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterDialog(CurrentObject).RefreshClearButtons(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBFilterDialogLibrary.__TfrmIBFilterDialogFormCreate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterDialog(CurrentObject).FormCreate(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBFilterDialogLibrary.__TfrmIBFilterDialogFieldsListBoxClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterDialog(CurrentObject).FieldsListBoxClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBFilterDialogLibrary.__TfrmIBFilterDialogFormDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterDialog(CurrentObject).FormDestroy(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBFilterDialogLibrary.__TfrmIBFilterDialogpgeFieldsChanging(AMachine: TatVirtualMachine);
  var
  Param1: Boolean;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    TfrmIBFilterDialog(CurrentObject).pgeFieldsChanging(TObject(Integer(GetInputArg(0))),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatIBFilterDialogLibrary.__TfrmIBFilterDialogbtnNewSearchClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterDialog(CurrentObject).btnNewSearchClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBFilterDialogLibrary.__TfrmIBFilterDialogbtnViewSummaryClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterDialog(CurrentObject).btnViewSummaryClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBFilterDialogLibrary.__TfrmIBFilterDialogFormActivate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterDialog(CurrentObject).FormActivate(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBFilterDialogLibrary.__TfrmIBFilterDialogbtnCancelClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterDialog(CurrentObject).btnCancelClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBFilterDialogLibrary.__TfrmIBFilterDialogbtnOkClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterDialog(CurrentObject).btnOkClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBFilterDialogLibrary.__TfrmIBFilterDialogbtnClearFieldValueClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterDialog(CurrentObject).btnClearFieldValueClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBFilterDialogLibrary.__TfrmIBFilterDialogbtnClearStartingRangeClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterDialog(CurrentObject).btnClearStartingRangeClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBFilterDialogLibrary.__TfrmIBFilterDialogbtnClearEndingRangeClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterDialog(CurrentObject).btnClearEndingRangeClick(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBFilterDialogLibrary.__TfrmIBFilterDialogNewSQL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterDialog(CurrentObject).NewSQL;
  end;
end;

procedure TatIBFilterDialogLibrary.__GetTfrmIBFilterDialogFilterList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TfrmIBFilterDialog(CurrentObject).FilterList));
  end;
end;

procedure TatIBFilterDialogLibrary.__GetTfrmIBFilterDialogFilterItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TfrmIBFilterDialog(CurrentObject).FilterItem[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatIBFilterDialogLibrary.__TIBFilterDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBFilterDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBFilterDialogLibrary.__TIBFilterDialogDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBFilterDialog(CurrentObject).Destroy;
  end;
end;

procedure TatIBFilterDialogLibrary.__TIBFilterDialogExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBFilterDialog(CurrentObject).Execute;
  end;
end;

procedure TatIBFilterDialogLibrary.__TIBFilterDialogReBuildSQL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBFilterDialog(CurrentObject).ReBuildSQL;
  end;
end;

procedure TatIBFilterDialogLibrary.__GetTIBFilterDialogModifiedSQL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBFilterDialog(CurrentObject).ModifiedSQL));
  end;
end;

procedure TatIBFilterDialogLibrary.Init;
begin
  With Scripter.DefineClass(TIBFieldInfo) do
  begin
    DefineMethod('Assign',1,tkNone,nil,__TIBFieldInfoAssign,false,0);
    DefineMethod('CreateSQL',0,tkVariant,nil,__TIBFieldInfoCreateSQL,false,0);
    DefineMethod('SetVariables',1,tkNone,nil,__TIBFieldInfoSetVariables,false,0);
  end;
  With Scripter.DefineClass(TIBVariable) do
  begin
    DefineMethod('Create',2,tkClass,TIBVariable,__TIBVariableCreate,true,0);
  end;
  With Scripter.DefineClass(TfrmIBFilterDialog) do
  begin
    DefineMethod('RefreshClearButtons',1,tkNone,nil,__TfrmIBFilterDialogRefreshClearButtons,false,0);
    DefineMethod('FormCreate',1,tkNone,nil,__TfrmIBFilterDialogFormCreate,false,0);
    DefineMethod('FieldsListBoxClick',1,tkNone,nil,__TfrmIBFilterDialogFieldsListBoxClick,false,0);
    DefineMethod('FormDestroy',1,tkNone,nil,__TfrmIBFilterDialogFormDestroy,false,0);
    DefineMethod('pgeFieldsChanging',2,tkNone,nil,__TfrmIBFilterDialogpgeFieldsChanging,false,0).SetVarArgs([1]);
    DefineMethod('btnNewSearchClick',1,tkNone,nil,__TfrmIBFilterDialogbtnNewSearchClick,false,0);
    DefineMethod('btnViewSummaryClick',1,tkNone,nil,__TfrmIBFilterDialogbtnViewSummaryClick,false,0);
    DefineMethod('FormActivate',1,tkNone,nil,__TfrmIBFilterDialogFormActivate,false,0);
    DefineMethod('btnCancelClick',1,tkNone,nil,__TfrmIBFilterDialogbtnCancelClick,false,0);
    DefineMethod('btnOkClick',1,tkNone,nil,__TfrmIBFilterDialogbtnOkClick,false,0);
    DefineMethod('btnClearFieldValueClick',1,tkNone,nil,__TfrmIBFilterDialogbtnClearFieldValueClick,false,0);
    DefineMethod('btnClearStartingRangeClick',1,tkNone,nil,__TfrmIBFilterDialogbtnClearStartingRangeClick,false,0);
    DefineMethod('btnClearEndingRangeClick',1,tkNone,nil,__TfrmIBFilterDialogbtnClearEndingRangeClick,false,0);
    DefineMethod('NewSQL',0,tkNone,nil,__TfrmIBFilterDialogNewSQL,false,0);
    DefineProp('FilterList',tkClass,__GetTfrmIBFilterDialogFilterList,nil,TList,false,0);
    DefaultProperty := DefineProp('FilterItem',tkClass,__GetTfrmIBFilterDialogFilterItem,nil,TIBFieldInfo,false,1);
  end;
  With Scripter.DefineClass(TIBFilterDialog) do
  begin
    DefineMethod('Create',1,tkClass,TIBFilterDialog,__TIBFilterDialogCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBFilterDialogDestroy,false,0);
    DefineMethod('Execute',0,tkNone,nil,__TIBFilterDialogExecute,false,0);
    DefineMethod('ReBuildSQL',0,tkNone,nil,__TIBFilterDialogReBuildSQL,false,0);
    DefineProp('ModifiedSQL',tkClass,__GetTIBFilterDialogModifiedSQL,nil,TStrings,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('fdMatchExact',fdMatchExact);
    AddConstant('fdMatchStart',fdMatchStart);
    AddConstant('fdMatchEnd',fdMatchEnd);
    AddConstant('fdMatchAny',fdMatchAny);
    AddConstant('fdMatchRange',fdMatchRange);
    AddConstant('fdMatchNone',fdMatchNone);
    AddConstant('fdCaseSensitive',fdCaseSensitive);
    AddConstant('fdShowCaseSensitive',fdShowCaseSensitive);
    AddConstant('fdShowNonMatching',fdShowNonMatching);
  end;
end;

class function TatIBFilterDialogLibrary.LibraryName: string;
begin
  result := 'IBFilterDialog';
end;

initialization
  RegisterScripterLibrary(TatIBFilterDialogLibrary, True);

{$WARNINGS ON}

end.

