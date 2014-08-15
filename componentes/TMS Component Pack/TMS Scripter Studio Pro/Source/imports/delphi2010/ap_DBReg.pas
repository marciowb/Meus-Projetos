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
unit ap_DBReg;

interface

uses
  SysUtils,
  Classes,
  DesignIntf,
  DesignEditors,
  DSDesign,
  WideStrings,
  DBReg,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatDBRegLibrary = class(TatScripterLibrary)
    procedure __TDBStringPropertyGetAttributes(AMachine: TatVirtualMachine);
    procedure __TDBStringPropertyGetValueList(AMachine: TatVirtualMachine);
    procedure __TDBWideStringPropertyGetAttributes(AMachine: TatVirtualMachine);
    procedure __TDBWideStringPropertyGetValueList(AMachine: TatVirtualMachine);
    procedure __TDBWideStringPropertyGetValues(AMachine: TatVirtualMachine);
    procedure __TDataFieldPropertyGetDataSourcePropName(AMachine: TatVirtualMachine);
    procedure __TDataFieldPropertyGetValueList(AMachine: TatVirtualMachine);
    procedure __TDataFieldAggPropertyGetDataSourcePropName(AMachine: TatVirtualMachine);
    procedure __TDataFieldAggPropertyGetValueList(AMachine: TatVirtualMachine);
    procedure __TDataSetEditorExecuteVerb(AMachine: TatVirtualMachine);
    procedure __TDataSetEditorGetVerb(AMachine: TatVirtualMachine);
    procedure __TDataSetEditorGetVerbCount(AMachine: TatVirtualMachine);
    procedure __TIndexFieldNamesPropertyGetValueList(AMachine: TatVirtualMachine);
    procedure __TIndexNamePropertyGetValueList(AMachine: TatVirtualMachine);
    procedure __TListFieldPropertyGetDataSourcePropName(AMachine: TatVirtualMachine);
    procedure __Register(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TDBStringPropertyClass = class of TDBStringProperty;
  TDBWideStringPropertyClass = class of TDBWideStringProperty;
  TDataFieldPropertyClass = class of TDataFieldProperty;
  TDataFieldAggPropertyClass = class of TDataFieldAggProperty;
  TDataSetEditorClass = class of TDataSetEditor;
  TIndexFieldNamesPropertyClass = class of TIndexFieldNamesProperty;
  TIndexNamePropertyClass = class of TIndexNameProperty;
  TListFieldPropertyClass = class of TListFieldProperty;



implementation



procedure TatDBRegLibrary.__TDBStringPropertyGetAttributes(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBStringProperty(CurrentObject).GetAttributes;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBRegLibrary.__TDBStringPropertyGetValueList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBStringProperty(CurrentObject).GetValueList(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBRegLibrary.__TDBWideStringPropertyGetAttributes(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBWideStringProperty(CurrentObject).GetAttributes;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBRegLibrary.__TDBWideStringPropertyGetValueList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBWideStringProperty(CurrentObject).GetValueList(TWideStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBRegLibrary.__TDBWideStringPropertyGetValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBWideStringProperty(CurrentObject).GetValues(GetInputArg(0));
  end;
end;

procedure TatDBRegLibrary.__TDataFieldPropertyGetDataSourcePropName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataFieldProperty(CurrentObject).GetDataSourcePropName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBRegLibrary.__TDataFieldPropertyGetValueList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataFieldProperty(CurrentObject).GetValueList(TWideStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBRegLibrary.__TDataFieldAggPropertyGetDataSourcePropName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataFieldAggProperty(CurrentObject).GetDataSourcePropName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBRegLibrary.__TDataFieldAggPropertyGetValueList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataFieldAggProperty(CurrentObject).GetValueList(TWideStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBRegLibrary.__TDataSetEditorExecuteVerb(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetEditor(CurrentObject).ExecuteVerb(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatDBRegLibrary.__TDataSetEditorGetVerb(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataSetEditor(CurrentObject).GetVerb(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBRegLibrary.__TDataSetEditorGetVerbCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDataSetEditor(CurrentObject).GetVerbCount);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBRegLibrary.__TIndexFieldNamesPropertyGetValueList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIndexFieldNamesProperty(CurrentObject).GetValueList(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBRegLibrary.__TIndexNamePropertyGetValueList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIndexNameProperty(CurrentObject).GetValueList(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBRegLibrary.__TListFieldPropertyGetDataSourcePropName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TListFieldProperty(CurrentObject).GetDataSourcePropName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBRegLibrary.__Register(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DBReg.Register;
  end;
end;

procedure TatDBRegLibrary.Init;
begin
  With Scripter.DefineClass(TDBStringProperty) do
  begin
    DefineMethod('GetAttributes',0,tkVariant,nil,__TDBStringPropertyGetAttributes,false,0);
    DefineMethod('GetValueList',1,tkNone,nil,__TDBStringPropertyGetValueList,false,0);
  end;
  With Scripter.DefineClass(TDBWideStringProperty) do
  begin
    DefineMethod('GetAttributes',0,tkVariant,nil,__TDBWideStringPropertyGetAttributes,false,0);
    DefineMethod('GetValueList',1,tkNone,nil,__TDBWideStringPropertyGetValueList,false,0);
    DefineMethod('GetValues',1,tkNone,nil,__TDBWideStringPropertyGetValues,false,0);
  end;
  With Scripter.DefineClass(TDataFieldProperty) do
  begin
    DefineMethod('GetDataSourcePropName',0,tkVariant,nil,__TDataFieldPropertyGetDataSourcePropName,false,0);
    DefineMethod('GetValueList',1,tkNone,nil,__TDataFieldPropertyGetValueList,false,0);
  end;
  With Scripter.DefineClass(TDataFieldAggProperty) do
  begin
    DefineMethod('GetDataSourcePropName',0,tkVariant,nil,__TDataFieldAggPropertyGetDataSourcePropName,false,0);
    DefineMethod('GetValueList',1,tkNone,nil,__TDataFieldAggPropertyGetValueList,false,0);
  end;
  With Scripter.DefineClass(TDataSetEditor) do
  begin
    DefineMethod('ExecuteVerb',1,tkNone,nil,__TDataSetEditorExecuteVerb,false,0);
    DefineMethod('GetVerb',1,tkVariant,nil,__TDataSetEditorGetVerb,false,0);
    DefineMethod('GetVerbCount',0,tkInteger,nil,__TDataSetEditorGetVerbCount,false,0);
  end;
  With Scripter.DefineClass(TIndexFieldNamesProperty) do
  begin
    DefineMethod('GetValueList',1,tkNone,nil,__TIndexFieldNamesPropertyGetValueList,false,0);
  end;
  With Scripter.DefineClass(TIndexNameProperty) do
  begin
    DefineMethod('GetValueList',1,tkNone,nil,__TIndexNamePropertyGetValueList,false,0);
  end;
  With Scripter.DefineClass(TListFieldProperty) do
  begin
    DefineMethod('GetDataSourcePropName',0,tkVariant,nil,__TListFieldPropertyGetDataSourcePropName,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('Register',0,tkNone,nil,__Register,false,0);
  end;
end;

class function TatDBRegLibrary.LibraryName: string;
begin
  result := 'DBReg';
end;

initialization
  RegisterScripterLibrary(TatDBRegLibrary, True);

{$WARNINGS ON}

end.

