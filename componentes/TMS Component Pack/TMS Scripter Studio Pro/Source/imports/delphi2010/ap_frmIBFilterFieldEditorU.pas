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
unit ap_frmIBFilterFieldEditorU;

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
  StdCtrls,
  Buttons,
  DesignIntf,
  DesignEditors,
  IBCustomDataset,
  frmIBFilterFieldEditorU,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatfrmIBFilterFieldEditorULibrary = class(TatScripterLibrary)
    procedure __TIBFilterFieldEditorGetAttributes(AMachine: TatVirtualMachine);
    procedure __TIBFilterFieldEditorGetValue(AMachine: TatVirtualMachine);
    procedure __TIBFilterFieldEditorEdit(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterFieldEditorlstFieldListClick(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterFieldEditoredtAliasChange(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterFieldEditorbtnAddClick(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterFieldEditorbtnRemoveClick(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterFieldEditorCreate(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterFieldEditorDestroy(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterFieldEditorSetList(AMachine: TatVirtualMachine);
    procedure __TfrmIBFilterFieldEditorGetList(AMachine: TatVirtualMachine);
    procedure __GetTfrmIBFilterFieldEditorAliasList(AMachine: TatVirtualMachine);
    procedure __SetTfrmIBFilterFieldEditorAliasList(AMachine: TatVirtualMachine);
    procedure __GetTfrmIBFilterFieldEditorDataSet(AMachine: TatVirtualMachine);
    procedure __SetTfrmIBFilterFieldEditorDataSet(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBFilterFieldEditorClass = class of TIBFilterFieldEditor;
  TfrmIBFilterFieldEditorClass = class of TfrmIBFilterFieldEditor;



implementation



procedure TatfrmIBFilterFieldEditorULibrary.__TIBFilterFieldEditorGetAttributes(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBFilterFieldEditor(CurrentObject).GetAttributes;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatfrmIBFilterFieldEditorULibrary.__TIBFilterFieldEditorGetValue(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBFilterFieldEditor(CurrentObject).GetValue;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatfrmIBFilterFieldEditorULibrary.__TIBFilterFieldEditorEdit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBFilterFieldEditor(CurrentObject).Edit;
  end;
end;

procedure TatfrmIBFilterFieldEditorULibrary.__TfrmIBFilterFieldEditorlstFieldListClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterFieldEditor(CurrentObject).lstFieldListClick(GetInputArg(0));
  end;
end;

procedure TatfrmIBFilterFieldEditorULibrary.__TfrmIBFilterFieldEditoredtAliasChange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterFieldEditor(CurrentObject).edtAliasChange(GetInputArg(0));
  end;
end;

procedure TatfrmIBFilterFieldEditorULibrary.__TfrmIBFilterFieldEditorbtnAddClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterFieldEditor(CurrentObject).btnAddClick(GetInputArg(0));
  end;
end;

procedure TatfrmIBFilterFieldEditorULibrary.__TfrmIBFilterFieldEditorbtnRemoveClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterFieldEditor(CurrentObject).btnRemoveClick(GetInputArg(0));
  end;
end;

procedure TatfrmIBFilterFieldEditorULibrary.__TfrmIBFilterFieldEditorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TfrmIBFilterFieldEditorClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatfrmIBFilterFieldEditorULibrary.__TfrmIBFilterFieldEditorDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterFieldEditor(CurrentObject).Destroy;
  end;
end;

procedure TatfrmIBFilterFieldEditorULibrary.__TfrmIBFilterFieldEditorSetList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterFieldEditor(CurrentObject).SetList(TStringList(Integer(GetInputArg(0))));
  end;
end;

procedure TatfrmIBFilterFieldEditorULibrary.__TfrmIBFilterFieldEditorGetList(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TfrmIBFilterFieldEditor(CurrentObject).GetList);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatfrmIBFilterFieldEditorULibrary.__GetTfrmIBFilterFieldEditorAliasList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TfrmIBFilterFieldEditor(CurrentObject).AliasList));
  end;
end;

procedure TatfrmIBFilterFieldEditorULibrary.__SetTfrmIBFilterFieldEditorAliasList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterFieldEditor(CurrentObject).AliasList:=TStringList(Integer(GetInputArg(0)));
  end;
end;

procedure TatfrmIBFilterFieldEditorULibrary.__GetTfrmIBFilterFieldEditorDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TfrmIBFilterFieldEditor(CurrentObject).DataSet);
  end;
end;

procedure TatfrmIBFilterFieldEditorULibrary.__SetTfrmIBFilterFieldEditorDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBFilterFieldEditor(CurrentObject).DataSet:=GetInputArg(0);
  end;
end;

procedure TatfrmIBFilterFieldEditorULibrary.Init;
begin
  With Scripter.DefineClass(TIBFilterFieldEditor) do
  begin
    DefineMethod('GetAttributes',0,tkVariant,nil,__TIBFilterFieldEditorGetAttributes,false,0);
    DefineMethod('GetValue',0,tkVariant,nil,__TIBFilterFieldEditorGetValue,false,0);
    DefineMethod('Edit',0,tkNone,nil,__TIBFilterFieldEditorEdit,false,0);
  end;
  With Scripter.DefineClass(TfrmIBFilterFieldEditor) do
  begin
    DefineMethod('lstFieldListClick',1,tkNone,nil,__TfrmIBFilterFieldEditorlstFieldListClick,false,0);
    DefineMethod('edtAliasChange',1,tkNone,nil,__TfrmIBFilterFieldEditoredtAliasChange,false,0);
    DefineMethod('btnAddClick',1,tkNone,nil,__TfrmIBFilterFieldEditorbtnAddClick,false,0);
    DefineMethod('btnRemoveClick',1,tkNone,nil,__TfrmIBFilterFieldEditorbtnRemoveClick,false,0);
    DefineMethod('Create',1,tkClass,TfrmIBFilterFieldEditor,__TfrmIBFilterFieldEditorCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TfrmIBFilterFieldEditorDestroy,false,0);
    DefineMethod('SetList',1,tkNone,nil,__TfrmIBFilterFieldEditorSetList,false,0);
    DefineMethod('GetList',0,tkClass,TStringList,__TfrmIBFilterFieldEditorGetList,false,0);
    DefineProp('AliasList',tkClass,__GetTfrmIBFilterFieldEditorAliasList,__SetTfrmIBFilterFieldEditorAliasList,TStringList,false,0);
    DefineProp('DataSet',tkVariant,__GetTfrmIBFilterFieldEditorDataSet,__SetTfrmIBFilterFieldEditorDataSet,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatfrmIBFilterFieldEditorULibrary.LibraryName: string;
begin
  result := 'frmIBFilterFieldEditorU';
end;

initialization
  RegisterScripterLibrary(TatfrmIBFilterFieldEditorULibrary, True);

{$WARNINGS ON}

end.

