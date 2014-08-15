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
unit ap_BDEReg;

interface

uses
  LibHelp,
  Dialogs,
  dblookup,
  FileCtrl,
  SysUtils,
  Classes,
  DSDesign,
  Menus,
  DBTables,
  DB,
  DRIntf,
  DsnDbCst,
  DSAttrS,
  DSAttrA,
  DBReg,
  Dbxplor,
  bdeconst,
  GqeDelph,
  ColnEdit,
  TblDsgn,
  DesignIntf,
  DesignEditors,
  Dbedit,
  Ixedit,
  Updsqled,
  FldLinks,
  CNCOLEDT,
  DrTable,
  TreeIntf,
  DsnDb,
  BDEReg,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatBDERegLibrary = class(TatScripterLibrary)
    procedure __TTableFieldLinkPropertyEdit(AMachine: TatVirtualMachine);
    procedure __GetTTableFieldLinkPropertyIndexBased(AMachine: TatVirtualMachine);
    procedure __GetTTableFieldLinkPropertyIndexDefs(AMachine: TatVirtualMachine);
    procedure __GetTTableFieldLinkPropertyIndexFieldNames(AMachine: TatVirtualMachine);
    procedure __SetTTableFieldLinkPropertyIndexFieldNames(AMachine: TatVirtualMachine);
    procedure __GetTTableFieldLinkPropertyIndexName(AMachine: TatVirtualMachine);
    procedure __SetTTableFieldLinkPropertyIndexName(AMachine: TatVirtualMachine);
    procedure __GetTTableFieldLinkPropertyMasterFields(AMachine: TatVirtualMachine);
    procedure __SetTTableFieldLinkPropertyMasterFields(AMachine: TatVirtualMachine);
    procedure __TSessionSprigName(AMachine: TatVirtualMachine);
    procedure __TSessionSprigCaption(AMachine: TatVirtualMachine);
    procedure __TSessionSprigAnyProblems(AMachine: TatVirtualMachine);
    procedure __TDefaultSessionSprigUniqueName(AMachine: TatVirtualMachine);
    procedure __TDefaultSessionSprigCaption(AMachine: TatVirtualMachine);
    procedure __TImpliedSessionSprigUniqueName(AMachine: TatVirtualMachine);
    procedure __TImpliedSessionSprigCaption(AMachine: TatVirtualMachine);
    procedure __TDatabaseSprigName(AMachine: TatVirtualMachine);
    procedure __TDatabaseSprigCaption(AMachine: TatVirtualMachine);
    procedure __TDatabaseSprigAnyProblems(AMachine: TatVirtualMachine);
    procedure __TDatabaseSprigFigureParent(AMachine: TatVirtualMachine);
    procedure __TDatabaseSprigDragDropTo(AMachine: TatVirtualMachine);
    procedure __TDatabaseSprigDragOverTo(AMachine: TatVirtualMachine);
    procedure __TImpliedDatabaseSprigAnyProblems(AMachine: TatVirtualMachine);
    procedure __TImpliedDatabaseSprigUniqueName(AMachine: TatVirtualMachine);
    procedure __TImpliedDatabaseSprigCaption(AMachine: TatVirtualMachine);
    procedure __TImpliedDatabaseSprigFigureParent(AMachine: TatVirtualMachine);
    procedure __TImpliedDatabaseSprigDragDropTo(AMachine: TatVirtualMachine);
    procedure __TImpliedDatabaseSprigDragOverTo(AMachine: TatVirtualMachine);
    procedure __TBatchMoveSprigAnyProblems(AMachine: TatVirtualMachine);
    procedure __TBatchMoveSprigCaption(AMachine: TatVirtualMachine);
    procedure __TUpdateSQLSprigAnyProblems(AMachine: TatVirtualMachine);
    procedure __TBDEDataSetSprigGetDSDesignerClass(AMachine: TatVirtualMachine);
    procedure __TNestedTableSprigParentProperty(AMachine: TatVirtualMachine);
    procedure __TDBDataSetSprigAnyProblems(AMachine: TatVirtualMachine);
    procedure __TDBDataSetSprigFigureParent(AMachine: TatVirtualMachine);
    procedure __TDBDataSetSprigReparent(AMachine: TatVirtualMachine);
    procedure __TDBDataSetSprigDragDropTo(AMachine: TatVirtualMachine);
    procedure __TDBDataSetSprigDragOverTo(AMachine: TatVirtualMachine);
    procedure __TTableSprigAnyProblems(AMachine: TatVirtualMachine);
    procedure __TTableSprigCaption(AMachine: TatVirtualMachine);
    procedure __TQuerySprigAnyProblems(AMachine: TatVirtualMachine);
    procedure __TStoredProcSprigAnyProblems(AMachine: TatVirtualMachine);
    procedure __TStoredProcSprigCaption(AMachine: TatVirtualMachine);
    procedure __SprigBDESessionName(AMachine: TatVirtualMachine);
    procedure __SprigBDEImpliedDatabaseName(AMachine: TatVirtualMachine);
    procedure __SprigBDEImpliedSessionName(AMachine: TatVirtualMachine);
    procedure __Register(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TTableFieldLinkPropertyClass = class of TTableFieldLinkProperty;
  TSessionSprigClass = class of TSessionSprig;
  TDefaultSessionSprigClass = class of TDefaultSessionSprig;
  TImpliedSessionSprigClass = class of TImpliedSessionSprig;
  TDatabaseSprigClass = class of TDatabaseSprig;
  TImpliedDatabaseSprigClass = class of TImpliedDatabaseSprig;
  TBatchMoveSprigClass = class of TBatchMoveSprig;
  TUpdateSQLSprigClass = class of TUpdateSQLSprig;
  TBDEDataSetSprigClass = class of TBDEDataSetSprig;
  TNestedTableSprigClass = class of TNestedTableSprig;
  TDBDataSetSprigClass = class of TDBDataSetSprig;
  TTableSprigClass = class of TTableSprig;
  TQuerySprigClass = class of TQuerySprig;
  TStoredProcSprigClass = class of TStoredProcSprig;



implementation



procedure TatBDERegLibrary.__TTableFieldLinkPropertyEdit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTableFieldLinkProperty(CurrentObject).Edit;
  end;
end;

procedure TatBDERegLibrary.__GetTTableFieldLinkPropertyIndexBased(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTableFieldLinkProperty(CurrentObject).IndexBased);
  end;
end;

procedure TatBDERegLibrary.__GetTTableFieldLinkPropertyIndexDefs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTableFieldLinkProperty(CurrentObject).IndexDefs));
  end;
end;

procedure TatBDERegLibrary.__GetTTableFieldLinkPropertyIndexFieldNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTableFieldLinkProperty(CurrentObject).IndexFieldNames);
  end;
end;

procedure TatBDERegLibrary.__SetTTableFieldLinkPropertyIndexFieldNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTableFieldLinkProperty(CurrentObject).IndexFieldNames:=GetInputArg(0);
  end;
end;

procedure TatBDERegLibrary.__GetTTableFieldLinkPropertyIndexName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTableFieldLinkProperty(CurrentObject).IndexName);
  end;
end;

procedure TatBDERegLibrary.__SetTTableFieldLinkPropertyIndexName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTableFieldLinkProperty(CurrentObject).IndexName:=GetInputArg(0);
  end;
end;

procedure TatBDERegLibrary.__GetTTableFieldLinkPropertyMasterFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTableFieldLinkProperty(CurrentObject).MasterFields);
  end;
end;

procedure TatBDERegLibrary.__SetTTableFieldLinkPropertyMasterFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTableFieldLinkProperty(CurrentObject).MasterFields:=GetInputArg(0);
  end;
end;

procedure TatBDERegLibrary.__TSessionSprigName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TSessionSprig(CurrentObject).Name;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TSessionSprigCaption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TSessionSprig(CurrentObject).Caption;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TSessionSprigAnyProblems(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TSessionSprig(CurrentObject).AnyProblems;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TDefaultSessionSprigUniqueName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDefaultSessionSprig(CurrentObject).UniqueName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TDefaultSessionSprigCaption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDefaultSessionSprig(CurrentObject).Caption;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TImpliedSessionSprigUniqueName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TImpliedSessionSprig(CurrentObject).UniqueName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TImpliedSessionSprigCaption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TImpliedSessionSprig(CurrentObject).Caption;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TDatabaseSprigName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDatabaseSprig(CurrentObject).Name;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TDatabaseSprigCaption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDatabaseSprig(CurrentObject).Caption;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TDatabaseSprigAnyProblems(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDatabaseSprig(CurrentObject).AnyProblems;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TDatabaseSprigFigureParent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDatabaseSprig(CurrentObject).FigureParent;
  end;
end;

procedure TatBDERegLibrary.__TDatabaseSprigDragDropTo(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDatabaseSprig(CurrentObject).DragDropTo(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TDatabaseSprigDragOverTo(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDatabaseSprig(CurrentObject).DragOverTo(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TImpliedDatabaseSprigAnyProblems(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TImpliedDatabaseSprig(CurrentObject).AnyProblems;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TImpliedDatabaseSprigUniqueName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TImpliedDatabaseSprig(CurrentObject).UniqueName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TImpliedDatabaseSprigCaption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TImpliedDatabaseSprig(CurrentObject).Caption;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TImpliedDatabaseSprigFigureParent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TImpliedDatabaseSprig(CurrentObject).FigureParent;
  end;
end;

procedure TatBDERegLibrary.__TImpliedDatabaseSprigDragDropTo(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TImpliedDatabaseSprig(CurrentObject).DragDropTo(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TImpliedDatabaseSprigDragOverTo(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TImpliedDatabaseSprig(CurrentObject).DragOverTo(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TBatchMoveSprigAnyProblems(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TBatchMoveSprig(CurrentObject).AnyProblems;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TBatchMoveSprigCaption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TBatchMoveSprig(CurrentObject).Caption;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TUpdateSQLSprigAnyProblems(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TUpdateSQLSprig(CurrentObject).AnyProblems;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TBDEDataSetSprigGetDSDesignerClass(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TBDEDataSetSprig(CurrentObject).GetDSDesignerClass;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TNestedTableSprigParentProperty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TNestedTableSprigClass(CurrentClass.ClassRef).ParentProperty;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TDBDataSetSprigAnyProblems(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBDataSetSprig(CurrentObject).AnyProblems;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TDBDataSetSprigFigureParent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBDataSetSprig(CurrentObject).FigureParent;
  end;
end;

procedure TatBDERegLibrary.__TDBDataSetSprigReparent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBDataSetSprig(CurrentObject).Reparent;
  end;
end;

procedure TatBDERegLibrary.__TDBDataSetSprigDragDropTo(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBDataSetSprig(CurrentObject).DragDropTo(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TDBDataSetSprigDragOverTo(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBDataSetSprig(CurrentObject).DragOverTo(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TTableSprigAnyProblems(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TTableSprig(CurrentObject).AnyProblems;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TTableSprigCaption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TTableSprig(CurrentObject).Caption;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TQuerySprigAnyProblems(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TQuerySprig(CurrentObject).AnyProblems;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TStoredProcSprigAnyProblems(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TStoredProcSprig(CurrentObject).AnyProblems;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__TStoredProcSprigCaption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TStoredProcSprig(CurrentObject).Caption;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__SprigBDESessionName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := BDEReg.SprigBDESessionName(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__SprigBDEImpliedDatabaseName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := BDEReg.SprigBDEImpliedDatabaseName(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__SprigBDEImpliedSessionName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := BDEReg.SprigBDEImpliedSessionName(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDERegLibrary.__Register(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    BDEReg.Register;
  end;
end;

procedure TatBDERegLibrary.Init;
begin
  With Scripter.DefineClass(TTableFieldLinkProperty) do
  begin
    DefineMethod('Edit',0,tkNone,nil,__TTableFieldLinkPropertyEdit,false,0);
    DefineProp('IndexBased',tkVariant,__GetTTableFieldLinkPropertyIndexBased,nil,nil,false,0);
    DefineProp('IndexDefs',tkClass,__GetTTableFieldLinkPropertyIndexDefs,nil,TIndexDefs,false,0);
    DefineProp('IndexFieldNames',tkVariant,__GetTTableFieldLinkPropertyIndexFieldNames,__SetTTableFieldLinkPropertyIndexFieldNames,nil,false,0);
    DefineProp('IndexName',tkVariant,__GetTTableFieldLinkPropertyIndexName,__SetTTableFieldLinkPropertyIndexName,nil,false,0);
    DefineProp('MasterFields',tkVariant,__GetTTableFieldLinkPropertyMasterFields,__SetTTableFieldLinkPropertyMasterFields,nil,false,0);
  end;
  With Scripter.DefineClass(TSessionSprig) do
  begin
    DefineMethod('Name',0,tkVariant,nil,__TSessionSprigName,false,0);
    DefineMethod('Caption',0,tkVariant,nil,__TSessionSprigCaption,false,0);
    DefineMethod('AnyProblems',0,tkVariant,nil,__TSessionSprigAnyProblems,false,0);
  end;
  With Scripter.DefineClass(TDefaultSessionSprig) do
  begin
    DefineMethod('UniqueName',0,tkVariant,nil,__TDefaultSessionSprigUniqueName,false,0);
    DefineMethod('Caption',0,tkVariant,nil,__TDefaultSessionSprigCaption,false,0);
  end;
  With Scripter.DefineClass(TImpliedSessionSprig) do
  begin
    DefineMethod('UniqueName',0,tkVariant,nil,__TImpliedSessionSprigUniqueName,false,0);
    DefineMethod('Caption',0,tkVariant,nil,__TImpliedSessionSprigCaption,false,0);
  end;
  With Scripter.DefineClass(TDatabaseSprig) do
  begin
    DefineMethod('Name',0,tkVariant,nil,__TDatabaseSprigName,false,0);
    DefineMethod('Caption',0,tkVariant,nil,__TDatabaseSprigCaption,false,0);
    DefineMethod('AnyProblems',0,tkVariant,nil,__TDatabaseSprigAnyProblems,false,0);
    DefineMethod('FigureParent',0,tkNone,nil,__TDatabaseSprigFigureParent,false,0);
    DefineMethod('DragDropTo',1,tkVariant,nil,__TDatabaseSprigDragDropTo,false,0);
    DefineMethod('DragOverTo',1,tkVariant,nil,__TDatabaseSprigDragOverTo,false,0);
  end;
  With Scripter.DefineClass(TImpliedDatabaseSprig) do
  begin
    DefineMethod('AnyProblems',0,tkVariant,nil,__TImpliedDatabaseSprigAnyProblems,false,0);
    DefineMethod('UniqueName',0,tkVariant,nil,__TImpliedDatabaseSprigUniqueName,false,0);
    DefineMethod('Caption',0,tkVariant,nil,__TImpliedDatabaseSprigCaption,false,0);
    DefineMethod('FigureParent',0,tkNone,nil,__TImpliedDatabaseSprigFigureParent,false,0);
    DefineMethod('DragDropTo',1,tkVariant,nil,__TImpliedDatabaseSprigDragDropTo,false,0);
    DefineMethod('DragOverTo',1,tkVariant,nil,__TImpliedDatabaseSprigDragOverTo,false,0);
  end;
  With Scripter.DefineClass(TBatchMoveSprig) do
  begin
    DefineMethod('AnyProblems',0,tkVariant,nil,__TBatchMoveSprigAnyProblems,false,0);
    DefineMethod('Caption',0,tkVariant,nil,__TBatchMoveSprigCaption,false,0);
  end;
  With Scripter.DefineClass(TUpdateSQLSprig) do
  begin
    DefineMethod('AnyProblems',0,tkVariant,nil,__TUpdateSQLSprigAnyProblems,false,0);
  end;
  With Scripter.DefineClass(TBDEDataSetSprig) do
  begin
    DefineMethod('GetDSDesignerClass',0,tkVariant,nil,__TBDEDataSetSprigGetDSDesignerClass,false,0);
  end;
  With Scripter.DefineClass(TNestedTableSprig) do
  begin
    DefineMethod('ParentProperty',0,tkVariant,nil,__TNestedTableSprigParentProperty,true,0);
  end;
  With Scripter.DefineClass(TDBDataSetSprig) do
  begin
    DefineMethod('AnyProblems',0,tkVariant,nil,__TDBDataSetSprigAnyProblems,false,0);
    DefineMethod('FigureParent',0,tkNone,nil,__TDBDataSetSprigFigureParent,false,0);
    DefineMethod('Reparent',0,tkNone,nil,__TDBDataSetSprigReparent,false,0);
    DefineMethod('DragDropTo',1,tkVariant,nil,__TDBDataSetSprigDragDropTo,false,0);
    DefineMethod('DragOverTo',1,tkVariant,nil,__TDBDataSetSprigDragOverTo,false,0);
  end;
  With Scripter.DefineClass(TTableSprig) do
  begin
    DefineMethod('AnyProblems',0,tkVariant,nil,__TTableSprigAnyProblems,false,0);
    DefineMethod('Caption',0,tkVariant,nil,__TTableSprigCaption,false,0);
  end;
  With Scripter.DefineClass(TQuerySprig) do
  begin
    DefineMethod('AnyProblems',0,tkVariant,nil,__TQuerySprigAnyProblems,false,0);
  end;
  With Scripter.DefineClass(TStoredProcSprig) do
  begin
    DefineMethod('AnyProblems',0,tkVariant,nil,__TStoredProcSprigAnyProblems,false,0);
    DefineMethod('Caption',0,tkVariant,nil,__TStoredProcSprigCaption,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('SprigBDESessionName',1,tkVariant,nil,__SprigBDESessionName,false,0);
    DefineMethod('SprigBDEImpliedDatabaseName',1,tkVariant,nil,__SprigBDEImpliedDatabaseName,false,0);
    DefineMethod('SprigBDEImpliedSessionName',1,tkVariant,nil,__SprigBDEImpliedSessionName,false,0);
    DefineMethod('Register',0,tkNone,nil,__Register,false,0);
    AddConstant('cDefaultSessionSprigName',cDefaultSessionSprigName);
    AddConstant('cImpliedSessionSprigPrefix',cImpliedSessionSprigPrefix);
    AddConstant('cImpliedDatabaseSprigPrefix',cImpliedDatabaseSprigPrefix);
  end;
end;

class function TatBDERegLibrary.LibraryName: string;
begin
  result := 'BDEReg';
end;

initialization
  RegisterScripterLibrary(TatBDERegLibrary, True);

{$WARNINGS ON}

end.

