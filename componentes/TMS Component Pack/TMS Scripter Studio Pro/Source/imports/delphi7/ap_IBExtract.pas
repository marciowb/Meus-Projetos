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
unit ap_IBExtract;

interface

uses
  SysUtils,
  Classes,
  IBDatabase,
  IBDatabaseInfo,
  IBSQL,
  IBUtils,
  IBHeader,
  IB,
  IBIntf,
  IBExternals,
  IBExtract,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatIBExtractLibrary = class(TatScripterLibrary)
    procedure __TIBExtractCreate(AMachine: TatVirtualMachine);
    procedure __TIBExtractDestroy(AMachine: TatVirtualMachine);
    procedure __TIBExtractGetArrayField(AMachine: TatVirtualMachine);
    procedure __TIBExtractGetFieldType(AMachine: TatVirtualMachine);
    procedure __TIBExtractGetCharacterSets(AMachine: TatVirtualMachine);
    procedure __TIBExtractNotification(AMachine: TatVirtualMachine);
    procedure __TIBExtractExtractObject(AMachine: TatVirtualMachine);
    procedure __GetTIBExtractDatabaseInfo(AMachine: TatVirtualMachine);
    procedure __GetTIBExtractItems(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBExtractClass = class of TIBExtract;


  TSQLTypeWrapper = class(TatRecordWrapper)
  private
    FSqlType: Integer;
    FTypeName: String;
  public
    constructor Create(ARecord: TSQLType);
    function ObjToRec: TSQLType;
  published
    property SqlType: Integer read FSqlType write FSqlType;
    property TypeName: String read FTypeName write FTypeName;
  end;
  
  TPrivTypesWrapper = class(TatRecordWrapper)
  private
    FPrivFlag: Integer;
    FPrivString: String;
  public
    constructor Create(ARecord: TPrivTypes);
    function ObjToRec: TPrivTypes;
  published
    property PrivFlag: Integer read FPrivFlag write FPrivFlag;
    property PrivString: String read FPrivString write FPrivString;
  end;
  

implementation

constructor TSQLTypeWrapper.Create(ARecord: TSQLType);
begin
  inherited Create;
  FSqlType := ARecord.SqlType;
  FTypeName := ARecord.TypeName;
end;

function TSQLTypeWrapper.ObjToRec: TSQLType;
begin
  result.SqlType := FSqlType;
  result.TypeName := FTypeName;
end;

constructor TPrivTypesWrapper.Create(ARecord: TPrivTypes);
begin
  inherited Create;
  FPrivFlag := ARecord.PrivFlag;
  FPrivString := ARecord.PrivString;
end;

function TPrivTypesWrapper.ObjToRec: TPrivTypes;
begin
  result.PrivFlag := FPrivFlag;
  result.PrivString := FPrivString;
end;



procedure TatIBExtractLibrary.__TIBExtractCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBExtractClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBExtractLibrary.__TIBExtractDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBExtract(CurrentObject).Destroy;
  end;
end;

procedure TatIBExtractLibrary.__TIBExtractGetArrayField(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBExtract(CurrentObject).GetArrayField(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBExtractLibrary.__TIBExtractGetFieldType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBExtract(CurrentObject).GetFieldType(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBExtractLibrary.__TIBExtractGetCharacterSets(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBExtract(CurrentObject).GetCharacterSets(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBExtractLibrary.__TIBExtractNotification(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBExtract(CurrentObject).Notification(TComponent(Integer(GetInputArg(0))),GetInputArg(1));
  end;
end;

procedure TatIBExtractLibrary.__TIBExtractExtractObject(AMachine: TatVirtualMachine);
  var
  Param2: TExtractTypes;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
    Case InputArgCount of
      1: TIBExtract(CurrentObject).ExtractObject(GetInputArg(0));
      2: TIBExtract(CurrentObject).ExtractObject(GetInputArg(0),GetInputArg(1));
      3: TIBExtract(CurrentObject).ExtractObject(GetInputArg(0),GetInputArg(1),Param2);
    end;
  end;
end;

procedure TatIBExtractLibrary.__GetTIBExtractDatabaseInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBExtract(CurrentObject).DatabaseInfo));
  end;
end;

procedure TatIBExtractLibrary.__GetTIBExtractItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBExtract(CurrentObject).Items));
  end;
end;

procedure TatIBExtractLibrary.Init;
begin
  With Scripter.DefineClass(TIBExtract) do
  begin
    DefineMethod('Create',1,tkClass,TIBExtract,__TIBExtractCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBExtractDestroy,false,0);
    DefineMethod('GetArrayField',1,tkVariant,nil,__TIBExtractGetArrayField,false,0);
    DefineMethod('GetFieldType',6,tkVariant,nil,__TIBExtractGetFieldType,false,0);
    DefineMethod('GetCharacterSets',3,tkVariant,nil,__TIBExtractGetCharacterSets,false,0);
    DefineMethod('Notification',2,tkNone,nil,__TIBExtractNotification,false,0);
    DefineMethod('ExtractObject',3,tkNone,nil,__TIBExtractExtractObject,false,2);
    DefineProp('DatabaseInfo',tkClass,__GetTIBExtractDatabaseInfo,nil,TIBDatabaseInfo,false,0);
    DefineProp('Items',tkClass,__GetTIBExtractItems,nil,TStrings,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('eoDatabase',eoDatabase);
    AddConstant('eoDomain',eoDomain);
    AddConstant('eoTable',eoTable);
    AddConstant('eoView',eoView);
    AddConstant('eoProcedure',eoProcedure);
    AddConstant('eoFunction',eoFunction);
    AddConstant('eoGenerator',eoGenerator);
    AddConstant('eoException',eoException);
    AddConstant('eoBLOBFilter',eoBLOBFilter);
    AddConstant('eoRole',eoRole);
    AddConstant('eoTrigger',eoTrigger);
    AddConstant('eoForeign',eoForeign);
    AddConstant('eoIndexes',eoIndexes);
    AddConstant('eoChecks',eoChecks);
    AddConstant('eoData',eoData);
    AddConstant('etDomain',etDomain);
    AddConstant('etTable',etTable);
    AddConstant('etRole',etRole);
    AddConstant('etTrigger',etTrigger);
    AddConstant('etForeign',etForeign);
    AddConstant('etIndex',etIndex);
    AddConstant('etData',etData);
    AddConstant('etGrant',etGrant);
    AddConstant('etCheck',etCheck);
    AddConstant('etAlterProc',etAlterProc);
    AddConstant('priv_UNKNOWN',priv_UNKNOWN);
    AddConstant('priv_SELECT',priv_SELECT);
    AddConstant('priv_INSERT',priv_INSERT);
    AddConstant('priv_UPDATE',priv_UPDATE);
    AddConstant('priv_DELETE',priv_DELETE);
    AddConstant('priv_EXECUTE',priv_EXECUTE);
    AddConstant('priv_REFERENCES',priv_REFERENCES);
    AddConstant('ODS_VERSION6',ODS_VERSION6);
    AddConstant('ODS_VERSION7',ODS_VERSION7);
    AddConstant('ODS_VERSION8',ODS_VERSION8);
    AddConstant('ODS_VERSION9',ODS_VERSION9);
    AddConstant('ODS_VERSION10',ODS_VERSION10);
    AddConstant('FILE_shadow',FILE_shadow);
    AddConstant('FILE_inactive',FILE_inactive);
    AddConstant('FILE_manual',FILE_manual);
    AddConstant('FILE_cache',FILE_cache);
    AddConstant('FILE_conditional',FILE_conditional);
    AddConstant('LOG_serial',LOG_serial);
    AddConstant('LOG_default',LOG_default);
    AddConstant('LOG_raw',LOG_raw);
    AddConstant('LOG_overflow',LOG_overflow);
    AddConstant('MAX_INTSUBTYPES',MAX_INTSUBTYPES);
    AddConstant('MAXSUBTYPES',MAXSUBTYPES);
    AddConstant('obj_relation',obj_relation);
    AddConstant('obj_view',obj_view);
    AddConstant('obj_trigger',obj_trigger);
    AddConstant('obj_computed',obj_computed);
    AddConstant('obj_validation',obj_validation);
    AddConstant('obj_procedure',obj_procedure);
    AddConstant('obj_expression_index',obj_expression_index);
    AddConstant('obj_exception',obj_exception);
    AddConstant('obj_user',obj_user);
    AddConstant('obj_field',obj_field);
    AddConstant('obj_index',obj_index);
    AddConstant('obj_count',obj_count);
    AddConstant('obj_user_group',obj_user_group);
    AddConstant('obj_sql_role',obj_sql_role);
  end;
end;

class function TatIBExtractLibrary.LibraryName: string;
begin
  result := 'IBExtract';
end;

initialization
  RegisterScripterLibrary(TatIBExtractLibrary, True);

{$WARNINGS ON}

end.

