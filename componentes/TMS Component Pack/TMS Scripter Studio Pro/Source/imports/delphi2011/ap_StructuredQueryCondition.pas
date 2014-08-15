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
unit ap_StructuredQueryCondition;

interface

uses
  Windows,
  ActiveX,
  StructuredQueryCondition,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatStructuredQueryConditionLibrary = class(TatScripterLibrary)
    procedure __GetIID_IRichChunk(AMachine: TatVirtualMachine);
    procedure __GetIID_ICondition(AMachine: TatVirtualMachine);
    procedure __GetIID_ICondition2(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatStructuredQueryConditionLibrary.__GetIID_IRichChunk(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQueryCondition.IID_IRichChunk)));
  end;
end;

procedure TatStructuredQueryConditionLibrary.__GetIID_ICondition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQueryCondition.IID_ICondition)));
  end;
end;

procedure TatStructuredQueryConditionLibrary.__GetIID_ICondition2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(StructuredQueryCondition.IID_ICondition2)));
  end;
end;

procedure TatStructuredQueryConditionLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('IID_IRichChunk',tkVariant,__GetIID_IRichChunk,nil,nil,false,0);
    DefineProp('IID_ICondition',tkVariant,__GetIID_ICondition,nil,nil,false,0);
    DefineProp('IID_ICondition2',tkVariant,__GetIID_ICondition2,nil,nil,false,0);
    AddConstant('SID_IRichChunk',SID_IRichChunk);
    AddConstant('SID_ICondition',SID_ICondition);
    AddConstant('SID_ICondition2',SID_ICondition2);
    AddConstant('CT_AND_CONDITION',CT_AND_CONDITION);
    AddConstant('CT_OR_CONDITION',CT_OR_CONDITION);
    AddConstant('CT_NOT_CONDITION',CT_NOT_CONDITION);
    AddConstant('CT_LEAF_CONDITION',CT_LEAF_CONDITION);
    AddConstant('COP_IMPLICIT',COP_IMPLICIT);
    AddConstant('COP_EQUAL',COP_EQUAL);
    AddConstant('COP_NOTEQUAL',COP_NOTEQUAL);
    AddConstant('COP_LESSTHAN',COP_LESSTHAN);
    AddConstant('COP_GREATERTHAN',COP_GREATERTHAN);
    AddConstant('COP_LESSTHANOREQUAL',COP_LESSTHANOREQUAL);
    AddConstant('COP_GREATERTHANOREQUAL',COP_GREATERTHANOREQUAL);
    AddConstant('COP_VALUE_STARTSWITH',COP_VALUE_STARTSWITH);
    AddConstant('COP_VALUE_ENDSWITH',COP_VALUE_ENDSWITH);
    AddConstant('COP_VALUE_CONTAINS',COP_VALUE_CONTAINS);
    AddConstant('COP_VALUE_NOTCONTAINS',COP_VALUE_NOTCONTAINS);
    AddConstant('COP_DOSWILDCARDS',COP_DOSWILDCARDS);
    AddConstant('COP_WORD_EQUAL',COP_WORD_EQUAL);
    AddConstant('COP_WORD_STARTSWITH',COP_WORD_STARTSWITH);
    AddConstant('COP_APPLICATION_SPECIFIC',COP_APPLICATION_SPECIFIC);
  end;
end;

class function TatStructuredQueryConditionLibrary.LibraryName: string;
begin
  result := 'StructuredQueryCondition';
end;

initialization
  RegisterScripterLibrary(TatStructuredQueryConditionLibrary, True);

{$WARNINGS ON}

end.

