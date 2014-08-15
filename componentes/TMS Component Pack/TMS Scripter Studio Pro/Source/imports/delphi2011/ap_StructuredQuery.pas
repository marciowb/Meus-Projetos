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
unit ap_StructuredQuery;

interface

uses
  StructuredQueryCondition,
  Objectarray,
  ActiveX,
  Windows,
  StructuredQuery,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatStructuredQueryLibrary = class(TatScripterLibrary)
    procedure __GetIID_IQueryParser(AMachine: TatVirtualMachine);
    procedure __GetIID_IConditionFactory(AMachine: TatVirtualMachine);
    procedure __GetIID_IQuerySolution(AMachine: TatVirtualMachine);
    procedure __GetIID_IConditionFactory2(AMachine: TatVirtualMachine);
    procedure __GetIID_IConditionGenerator(AMachine: TatVirtualMachine);
    procedure __GetIID_IInterval(AMachine: TatVirtualMachine);
    procedure __GetIID_IMetaData(AMachine: TatVirtualMachine);
    procedure __GetIID_IEntity(AMachine: TatVirtualMachine);
    procedure __GetIID_IRelationship(AMachine: TatVirtualMachine);
    procedure __GetIID_INamedEntity(AMachine: TatVirtualMachine);
    procedure __GetIID_ISchemaProvider(AMachine: TatVirtualMachine);
    procedure __GetIID_ITokenCollection(AMachine: TatVirtualMachine);
    procedure __GetIID_INamedEntityCollector(AMachine: TatVirtualMachine);
    procedure __GetIID_ISchemaLocalizerSupport(AMachine: TatVirtualMachine);
    procedure __GetIID_IQueryParserManager(AMachine: TatVirtualMachine);
    procedure __GetCLSID_IQueryParser(AMachine: TatVirtualMachine);
    procedure __GetCLSID_INegationCondition(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ICompoundCondition(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ILeafCondition(AMachine: TatVirtualMachine);
    procedure __GetCLSID_IConditionFactory(AMachine: TatVirtualMachine);
    procedure __GetCLSID_IInterval(AMachine: TatVirtualMachine);
    procedure __GetCLSID_IQueryParserManager(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatStructuredQueryLibrary.__GetIID_IQueryParser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.IID_IQueryParser)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetIID_IConditionFactory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.IID_IConditionFactory)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetIID_IQuerySolution(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.IID_IQuerySolution)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetIID_IConditionFactory2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.IID_IConditionFactory2)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetIID_IConditionGenerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.IID_IConditionGenerator)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetIID_IInterval(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.IID_IInterval)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetIID_IMetaData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.IID_IMetaData)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetIID_IEntity(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.IID_IEntity)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetIID_IRelationship(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.IID_IRelationship)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetIID_INamedEntity(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.IID_INamedEntity)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetIID_ISchemaProvider(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.IID_ISchemaProvider)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetIID_ITokenCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.IID_ITokenCollection)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetIID_INamedEntityCollector(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.IID_INamedEntityCollector)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetIID_ISchemaLocalizerSupport(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.IID_ISchemaLocalizerSupport)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetIID_IQueryParserManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.IID_IQueryParserManager)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetCLSID_IQueryParser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.CLSID_IQueryParser)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetCLSID_INegationCondition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.CLSID_INegationCondition)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetCLSID_ICompoundCondition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.CLSID_ICompoundCondition)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetCLSID_ILeafCondition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.CLSID_ILeafCondition)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetCLSID_IConditionFactory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.CLSID_IConditionFactory)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetCLSID_IInterval(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.CLSID_IInterval)));
  end;
end;

procedure TatStructuredQueryLibrary.__GetCLSID_IQueryParserManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQuery.CLSID_IQueryParserManager)));
  end;
end;

procedure TatStructuredQueryLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('IID_IQueryParser',tkVariant,__GetIID_IQueryParser,nil,nil,false,0);
    DefineProp('IID_IConditionFactory',tkVariant,__GetIID_IConditionFactory,nil,nil,false,0);
    DefineProp('IID_IQuerySolution',tkVariant,__GetIID_IQuerySolution,nil,nil,false,0);
    DefineProp('IID_IConditionFactory2',tkVariant,__GetIID_IConditionFactory2,nil,nil,false,0);
    DefineProp('IID_IConditionGenerator',tkVariant,__GetIID_IConditionGenerator,nil,nil,false,0);
    DefineProp('IID_IInterval',tkVariant,__GetIID_IInterval,nil,nil,false,0);
    DefineProp('IID_IMetaData',tkVariant,__GetIID_IMetaData,nil,nil,false,0);
    DefineProp('IID_IEntity',tkVariant,__GetIID_IEntity,nil,nil,false,0);
    DefineProp('IID_IRelationship',tkVariant,__GetIID_IRelationship,nil,nil,false,0);
    DefineProp('IID_INamedEntity',tkVariant,__GetIID_INamedEntity,nil,nil,false,0);
    DefineProp('IID_ISchemaProvider',tkVariant,__GetIID_ISchemaProvider,nil,nil,false,0);
    DefineProp('IID_ITokenCollection',tkVariant,__GetIID_ITokenCollection,nil,nil,false,0);
    DefineProp('IID_INamedEntityCollector',tkVariant,__GetIID_INamedEntityCollector,nil,nil,false,0);
    DefineProp('IID_ISchemaLocalizerSupport',tkVariant,__GetIID_ISchemaLocalizerSupport,nil,nil,false,0);
    DefineProp('IID_IQueryParserManager',tkVariant,__GetIID_IQueryParserManager,nil,nil,false,0);
    DefineProp('CLSID_IQueryParser',tkVariant,__GetCLSID_IQueryParser,nil,nil,false,0);
    DefineProp('CLSID_INegationCondition',tkVariant,__GetCLSID_INegationCondition,nil,nil,false,0);
    DefineProp('CLSID_ICompoundCondition',tkVariant,__GetCLSID_ICompoundCondition,nil,nil,false,0);
    DefineProp('CLSID_ILeafCondition',tkVariant,__GetCLSID_ILeafCondition,nil,nil,false,0);
    DefineProp('CLSID_IConditionFactory',tkVariant,__GetCLSID_IConditionFactory,nil,nil,false,0);
    DefineProp('CLSID_IInterval',tkVariant,__GetCLSID_IInterval,nil,nil,false,0);
    DefineProp('CLSID_IQueryParserManager',tkVariant,__GetCLSID_IQueryParserManager,nil,nil,false,0);
    AddConstant('SID_IQueryParser',SID_IQueryParser);
    AddConstant('SID_IConditionFactory',SID_IConditionFactory);
    AddConstant('SID_IQuerySolution',SID_IQuerySolution);
    AddConstant('SID_IConditionFactory2',SID_IConditionFactory2);
    AddConstant('SID_IConditionGenerator',SID_IConditionGenerator);
    AddConstant('SID_IInterval',SID_IInterval);
    AddConstant('SID_IMetaData',SID_IMetaData);
    AddConstant('SID_IEntity',SID_IEntity);
    AddConstant('SID_IRelationship',SID_IRelationship);
    AddConstant('SID_INamedEntity',SID_INamedEntity);
    AddConstant('SID_ISchemaProvider',SID_ISchemaProvider);
    AddConstant('SID_ITokenCollection',SID_ITokenCollection);
    AddConstant('SID_INamedEntityCollector',SID_INamedEntityCollector);
    AddConstant('SID_ISchemaLocalizerSupport',SID_ISchemaLocalizerSupport);
    AddConstant('SID_IQueryParserManager',SID_IQueryParserManager);
    AddConstant('SQS_NO_SYNTAX',SQS_NO_SYNTAX);
    AddConstant('SQS_ADVANCED_QUERY_SYNTAX',SQS_ADVANCED_QUERY_SYNTAX);
    AddConstant('SQS_NATURAL_QUERY_SYNTAX',SQS_NATURAL_QUERY_SYNTAX);
    AddConstant('SQSO_SCHEMA',SQSO_SCHEMA);
    AddConstant('SQSO_LOCALE_WORD_BREAKING',SQSO_LOCALE_WORD_BREAKING);
    AddConstant('SQSO_WORD_BREAKER',SQSO_WORD_BREAKER);
    AddConstant('SQSO_NATURAL_SYNTAX',SQSO_NATURAL_SYNTAX);
    AddConstant('SQSO_AUTOMATIC_WILDCARD',SQSO_AUTOMATIC_WILDCARD);
    AddConstant('SQSO_TRACE_LEVEL',SQSO_TRACE_LEVEL);
    AddConstant('SQSO_LANGUAGE_KEYWORDS',SQSO_LANGUAGE_KEYWORDS);
    AddConstant('SQSO_SYNTAX',SQSO_SYNTAX);
    AddConstant('SQSO_TIME_ZONE',SQSO_TIME_ZONE);
    AddConstant('SQSO_IMPLICIT_CONNECTOR',SQSO_IMPLICIT_CONNECTOR);
    AddConstant('SQSO_CONNECTOR_CASE',SQSO_CONNECTOR_CASE);
    AddConstant('SQMO_VIRTUAL_PROPERTY',SQMO_VIRTUAL_PROPERTY);
    AddConstant('SQMO_DEFAULT_PROPERTY',SQMO_DEFAULT_PROPERTY);
    AddConstant('SQMO_GENERATOR_FOR_TYPE',SQMO_GENERATOR_FOR_TYPE);
    AddConstant('SQMO_MAP_PROPERTY',SQMO_MAP_PROPERTY);
    AddConstant('SQPE_NONE',SQPE_NONE);
    AddConstant('SQPE_EXTRA_OPENING_PARENTHESIS',SQPE_EXTRA_OPENING_PARENTHESIS);
    AddConstant('SQPE_EXTRA_CLOSING_PARENTHESIS',SQPE_EXTRA_CLOSING_PARENTHESIS);
    AddConstant('SQPE_IGNORED_MODIFIER',SQPE_IGNORED_MODIFIER);
    AddConstant('SQPE_IGNORED_CONNECTOR',SQPE_IGNORED_CONNECTOR);
    AddConstant('SQPE_IGNORED_KEYWORD',SQPE_IGNORED_KEYWORD);
    AddConstant('SQPE_UNHANDLED',SQPE_UNHANDLED);
    AddConstant('SQRO_DEFAULT',SQRO_DEFAULT);
    AddConstant('SQRO_DONT_RESOLVE_DATETIME',SQRO_DONT_RESOLVE_DATETIME);
    AddConstant('SQRO_ALWAYS_ONE_INTERVAL',SQRO_ALWAYS_ONE_INTERVAL);
    AddConstant('SQRO_DONT_SIMPLIFY_CONDITION_TREES',SQRO_DONT_SIMPLIFY_CONDITION_TREES);
    AddConstant('SQRO_DONT_MAP_RELATIONS',SQRO_DONT_MAP_RELATIONS);
    AddConstant('SQRO_DONT_RESOLVE_RANGES',SQRO_DONT_RESOLVE_RANGES);
    AddConstant('SQRO_DONT_REMOVE_UNRESTRICTED_KEYWORDS',SQRO_DONT_REMOVE_UNRESTRICTED_KEYWORDS);
    AddConstant('SQRO_DONT_SPLIT_WORDS',SQRO_DONT_SPLIT_WORDS);
    AddConstant('SQRO_IGNORE_PHRASE_ORDER',SQRO_IGNORE_PHRASE_ORDER);
    AddConstant('SQRO_ADD_VALUE_TYPE_FOR_PLAIN_VALUES',SQRO_ADD_VALUE_TYPE_FOR_PLAIN_VALUES);
    AddConstant('SQRO_ADD_ROBUST_ITEM_NAME',SQRO_ADD_ROBUST_ITEM_NAME);
    AddConstant('CASE_REQUIREMENT_ANY',CASE_REQUIREMENT_ANY);
    AddConstant('CASE_REQUIREMENT_UPPER_IF_AQS',CASE_REQUIREMENT_UPPER_IF_AQS);
    AddConstant('ILK_EXPLICIT_INCLUDED',ILK_EXPLICIT_INCLUDED);
    AddConstant('ILK_EXPLICIT_EXCLUDED',ILK_EXPLICIT_EXCLUDED);
    AddConstant('ILK_NEGATIVE_INFINITY',ILK_NEGATIVE_INFINITY);
    AddConstant('ILK_POSITIVE_INFINITY',ILK_POSITIVE_INFINITY);
    AddConstant('QPMO_SCHEMA_BINARY_NAME',QPMO_SCHEMA_BINARY_NAME);
    AddConstant('QPMO_PRELOCALIZED_SCHEMA_BINARY_PATH',QPMO_PRELOCALIZED_SCHEMA_BINARY_PATH);
    AddConstant('QPMO_UNLOCALIZED_SCHEMA_BINARY_PATH',QPMO_UNLOCALIZED_SCHEMA_BINARY_PATH);
    AddConstant('QPMO_LOCALIZED_SCHEMA_BINARY_PATH',QPMO_LOCALIZED_SCHEMA_BINARY_PATH);
    AddConstant('QPMO_APPEND_LCID_TO_LOCALIZED_PATH',QPMO_APPEND_LCID_TO_LOCALIZED_PATH);
    AddConstant('QPMO_LOCALIZER_SUPPORT',QPMO_LOCALIZER_SUPPORT);
    AddConstant('CONDITION_CREATION_DEFAULT',CONDITION_CREATION_DEFAULT);
    AddConstant('CONDITION_CREATION_NONE',CONDITION_CREATION_NONE);
    AddConstant('CONDITION_CREATION_SIMPLIFY',CONDITION_CREATION_SIMPLIFY);
    AddConstant('CONDITION_CREATION_VECTOR_AND',CONDITION_CREATION_VECTOR_AND);
    AddConstant('CONDITION_CREATION_VECTOR_OR',CONDITION_CREATION_VECTOR_OR);
    AddConstant('CONDITION_CREATION_VECTOR_LEAF',CONDITION_CREATION_VECTOR_LEAF);
    AddConstant('CONDITION_CREATION_USE_CONTENT_LOCALE',CONDITION_CREATION_USE_CONTENT_LOCALE);
    AddConstant('NEC_LOW',NEC_LOW);
    AddConstant('NEC_MEDIUM',NEC_MEDIUM);
    AddConstant('NEC_HIGH',NEC_HIGH);
  end;
end;

class function TatStructuredQueryLibrary.LibraryName: string;
begin
  result := 'StructuredQuery';
end;

initialization
  RegisterScripterLibrary(TatStructuredQueryLibrary, True);

{$WARNINGS ON}

end.

