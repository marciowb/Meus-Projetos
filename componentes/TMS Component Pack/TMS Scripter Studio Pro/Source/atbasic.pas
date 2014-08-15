{***************************************************************************}
{ Scripter Studio Components for Delphi & C++Builder                        }
{ version 4.7 (Std), 1.7 (Pro)                                              }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ For information about version history, check the section "What's New"     }
{ at Scripter Studio manual.                                                }                                                                         
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit atBasic;

{$I ASCRIPT.INC}

interface

uses
  TypInfo, Classes, atParser, atScript,
  contnrs,
  {$IFDEF DELPHI2009_LVL}
  Character,
  {$ENDIF}
  SysUtils;

type
  // Basic scripter section

  TatBasicScripter = class;

  /// Summary:
  ///   Scripter component that supports scripts with Basic syntax
  /// Description:
  ///   TatBasicScripter is a TatCustomScripter descendant that implements Basic syntax. With this component
  ///   you can create and execute scripts in Basic language.
  ///   This component is deprecated since new TatScripter component allows multiple languages in the same
  ///   component without the need to use different components for each script language.
  /// See Also:
  ///   TatScripter; TatPascalScripter; TatCustomScripter
  TatBasicScripter = class(TatCustomScripter)
  protected
    procedure DefineInternalClasses; override;
  public
    constructor Create( AOwner:TComponent ); override;
    destructor Destroy; override;
  published
    property SourceCode;
    property Compiled;
    property SaveCompiledCode;
    property EventSupport;
    property EventSetMode;
    property EventUnsetMode;
    property OnDebugHook;
    property OnExecHook;
    property OnCompileError;
    property OnRuntimeError;
    property OnExecuteEvent;
    property OnSettingEvent;
    property OnSetEvent;
    property OnUnsettingEvent;
    property ShortBooleanEval;
    property LibOptions;
    property CallExecHookEvent;
    property OnUnknownElement;
    property OnBreakpointStop;
  end;

  /// Description:
  ///   Created internally by TatBasicScripter for some refactoring operations in Basic syntax scripts.
  TatBasicRefactor = class(TatScriptRefactor)
  private
  public
    procedure AddUsedUnit(AUnitName: string); override;
    procedure UpdateFormHeader(AFormClass, AFileName: string); override;
    function DeclareRoutine(AInfo: TatRoutineInfo): integer; override;
  end;

  ///Summary:
  ///   TatScript object descendant that implements Basic syntax
  /// Description:
  ///   TatBasicScript is a script object that can execute Basic scripts. You will rarely need to create
  ///   this object directly, it is created automatically by the scripter component when needed.
  /// See Also:
  ///   TatPascalScript; TatScripter.AddScript
  TatBasicScript = class(TatScript)
  private
    // interno (variáveis usadas apenas durante a compilação)
    FForCount          : integer; // contador de estrturas FOR
    FCurrentFor        : integer; // estrutura FOR corrente
    FWhileCount        : integer; // contador de estrturas WHILE
    FCurrentWhile      : integer; // estrutura WHILE corrente
    FRepeatCount       : integer; // contador de estrturas REPEAT
    FCurrentRepeat     : integer; // estrutura REPEAT corrente
    FIfCount           : integer; // contador de estruturas IF
    FCurrentIf         : integer; // estrutura IF corrente
    FCaseCount         : integer; // contador de estruturas CASE
    FWithCount         : integer; // contador de estruturas WITH
    FCurrentWith       : integer; // estrutura WITH corrente
    FOperatorCount     : integer; // Counter of operators
    FCurrentOperator   : integer;
    FCurrentCase       : integer; // estrutura CASE corrente
    FCaseVarIndex      : integer; // índice da variável do case corrente
    FCaseBranchLevel   : integer; // indica nível de ramificação do CASE corrente
    FCurrentLoop       : TLoopStatement; // loop corrente
    FCurrentClass      : TatClass; // classe corrente
    FIsClassReference  : boolean; // indica se a classe corrente é uma referência de classe
    FLastByRefArgMask  : integer; // last "Arg_List" no-terminal by-reference argument bit mask
    FByRefArgMask      : integer; // current Arg_List no-terminal by-reference argument bit mask
    FThereIsAnySubrot  : boolean; // indica se existe alguma subrotina no script
    FPushVarListObjects: TObjectList; // list of pushvarlist, used to avoid memory leaks
    FPushVarList: TList; //A list of pinstruction which pushes the variable in the stack for a method/routine call. used when arg_list node is being scanned
    FLastPushVarList: TList; //A list of pinstruction which pushes the variable in the stack for a method/routine call. Uses after arg_list
    { validação de tokens }
    function AcceptNodeId( Node:TNoTerminalNode ):boolean;
    { geração de código }
    procedure BeforeProgram( Node:TNoTerminalNode );
    procedure AfterProgram( Node:TNoTerminalNode );
    procedure AfterUses(Node : TNoTerminalNode );
    procedure AfterImports(Node : TNoTerminalNode );
    procedure BeforeMain( Node:TNoTerminalNode );
    procedure AfterMain( Node:TNoTerminalNode );
    procedure BeforeSubRoutine( Node:TNoTerminalNode );
    procedure AfterSubRoutine( Node:TNoTerminalNode );
    procedure AfterPushOutput( Node:TNoTerminalNode );
    procedure BeforeFor( Node:TNoTerminalNode );
    procedure AfterFor( Node:TNoTerminalNode );
    procedure AfterForControl( Node:TNoTerminalNode );
    procedure AfterStep( Node:TNoTerminalNode );
    procedure BeforeIf( Node:TNoTerminalNode );
    procedure AfterIf( Node:TNoTerminalNode );
    procedure BeforeThen( Node:TNoTerminalNode );
    procedure AfterThen( Node:TNoTerminalNode );
    procedure BeforeElseIf( Node:TNoTerminalNode );
    procedure AfterElseIf( Node:TNoTerminalNode );
    procedure BeforeElse( Node:TNoTerminalNode );
    procedure BeforeExpression( Node:TNoTerminalNode );
    procedure AfterExpression( Node:TNoTerminalNode );
    procedure AfterOperator( Node:TNoTerminalNode );
    procedure AfterUnary( Node:TNoTerminalNode );
    procedure AfterLabel( Node:TNoTerminalNode );
    procedure AfterId( Node:TNoTerminalNode );
    procedure AfterReal( Node:TNoTerminalNode );
    procedure AfterHex( Node:TNoTerminalNode );
    procedure AfterString( Node:TNoTerminalNode );
    procedure AfterVector( Node:TNoTerminalNode );
    procedure BeforeArgList( Node:TNoTerminalNode );
    procedure AfterArgList( Node:TNoTerminalNode );
    procedure BeforeCallCode( Node:TNoTerminalNode );
    procedure BeforeDataValCode( Node:TNoTerminalNode );
    procedure BeforeDataRefCode( Node:TNoTerminalNode );
    procedure BeforeNewCallCode( Node: TNoTerminalNode );
    procedure BeforeTry( Node:TNoTerminalNode );
    procedure AfterTryStatements( Node:TNoTerminalNode );
    procedure AfterTryUpshot( Node:TNoTerminalNode );
    procedure AfterCase(Node: TNoTerminalNode);
    procedure BeforeCase(Node: TNoTerminalNode);
    procedure AfterCaseExpr(Node: TNoTerminalNode);
    procedure AfterCaseTest(Node: TNoTerminalNode);
    procedure AfterCaseMatch(Node: TNoTerminalNode);
    procedure BeforeCaseMatch(Node: TNoTerminalNode);
    procedure AfterCaseBranch(Node: TNoTerminalNode);
    procedure BeforeCaseBranch(Node: TNoTerminalNode);
    procedure AfterInputArgs(Node: TNoTerminalNode);
    procedure AfterVarDecl(Node: TNoTerminalNode);
    procedure AfterLoopTestExpr(Node: TNoTerminalNode);
    procedure AfterTestLoop(Node: TNoTerminalNode);
    procedure AfterTestLoopExpr(Node: TNoTerminalNode);
    procedure BeforeLoopTest(Node: TNoTerminalNode);
    procedure BeforeLoopTestExpr(Node: TNoTerminalNode);
    procedure BeforeTestLoop(Node: TNoTerminalNode);
    procedure BeforeTestLoopExpr(Node: TNoTerminalNode);
    procedure AfterExitLoop(Node: TNoTerminalNode);
    procedure AfterExitRoutine(Node: TNoTerminalNode);
    procedure AfterWhileEndExpr(Node: TNoTerminalNode);
    procedure AfterWith(Node: TNoTerminalNode);
    procedure AfterWithObj(Node: TNoTerminalNode);
    procedure AfterExternal(Node: TNoTerminalNode);
    procedure AfterConstDecl(Node: TNoTerminalNode);
    procedure AfterReturn(Node: TNoTerminalNode);
    { helper }
    procedure MakeDataElementCode( Node:TNoTerminalNode; operation:TDataOperation );
    function SpecialKeyWord(AName: string; operation: TDataOperation): boolean;
    function ExtractQuotedString(const S: string): string;
    procedure ExtractSourceRemark(AParser: TatSyntaxParser; AStartPos, AFinalPos: integer);
    procedure AfterIndexing(Node: TNoTerminalNode);
    procedure BeforeIndexing(Node: TNoTerminalNode);
  protected
    function EncodeSingleAssign(AVarName, AExpression: string): string; override;
  public
    constructor Create(ACollection:TCollection); override;
    destructor Destroy; override;
    procedure Clear; override;

    ///Summary:
    ///   Deprecated. Returns the TatBasicScripter component which owns this script.
    /// Description:
    ///   Don't use this function, use TatCustomScripter.Scripter property instead.
    function BasicScripter: TatBasicScripter;
  end;

type
   { No-terminal symbol index list }
   atBASIC_NOTERMINALS = (
      bnProgram,
      bnMain,
      bnUses,
      bnImports,
      bnSubroutine,
      bnFunction,
      bnSubVisibility,
      bnExternal,
      bnFileName,
      bnExternalName,
      bnCallingConvention,
      bnInputArgs,
      bnForward,
      bnByRef,
      bnByVal,
      bnArgType,
      bnVarDecl,
      bnConstDecl,
      bnVarList,
      bnGlobalDecl,
      bnGlobalVisibility,
      bnStatement,
      bnCall,
      bnCall_code,
      bnData_val,
      bnData_val_code,
      bnData_ref,
      bnData_ref_code,
      bnNew_call,
      bnNew_call_code,
      bnArg_list,
      bnIndexing,
      bnAssign,
      bnPush_output,
      bnFor,
      bnFor_control,
      bnStep,
      bnDo_loop,
      bnTest_loop,
      bnTest_loop_expr,
      bnLoop_test,
      bnLoop_test_expr,
      bnWhile,
      bnUntil,
      bnWhileEnd,
      bnWhileEnd_expr,
      bnIf,
      bnThen,
      bnThenSingle,
      bnElseIf,
      bnElse,
      bnElseSingle,
      bnExpression,
      bnOperator,
      bnUnary,
      bnLabel,
      bnId,
      bnReal,
      bnHex,
      bnFrac,
      bnExp,
      bnString,
      bnVector,
      bnTry,
      bnFinally,
      bnExcept,
      bnTry_statements,
      bnTry_upshot,
      bnCase,
      bnCase_expr,
      bnCase_branch,
      bnCase_test,
      bnCase_match,
      bnExit,
      bnExit_sub,
      bnExit_function,
      bnExit_do,
      bnExit_for,
      bnReturn,
      bnWith,
      bnWith_obj );

implementation

{************************************************************************}
{                                                                        }
{     BASIC scripting engine                                             }
{                                                                        }
{************************************************************************}

const
   { Basic Syntax Specification }
   atBASIC_GRAMMAR  = '<program>: [({<uses>|<imports>} )] [( {<globaldecl>|<constdecl>})] [( {<subroutine>|<function>})] <main> '#13#10+
                      '<main>:[( <statement>[ :])]'#13#10+
                      '<uses>R:uses <id>[( , <id>)][ ;]'#13#10+
                      '<imports>R:imports <id>[( , <id>)][ ;]'#13#10+
                      '<subroutine>:[<subvisibility>~ ]sub <label> {<external>|<inputargs>{ <forward>|[( <statement>[ :])] end sub}}'#13#10+
                      '<function>:[<subvisibility>~ ]function <label> {<external>[ as <argtype>]|<inputargs>[ as <argtype>]{ <forward>|[( <statement>[ :])] end function}}'#13#10+
                      '<subvisibility>:{public|private}'#13#10+
                      '<external>:lib <filename>[ alias <externalName>] [<callingConvention>] <inputargs>'#13#10+
                      '<filename>:$'#13#10+
                      '<externalName>:$'#13#10+
                      '<callingConvention>:{stdcall|safecall|cdecl|pascal|register}'#13#10+
                      '<inputargs>:["(" {<byref>|<byval>}[( , {<byref>|<byval>})] ")"]'#13#10+
                      '<forward>:forward'#13#10+
                      '<byref>:byref~ <id>[ as <argtype>]'#13#10+
                      '<byval>:[byval~] <id>[ as <argtype>]'#13#10+
                      '<argtype>:{@|_}[({@|#|_})]'#13#10+
                      '<vardecl>:dim~ <varlist>[( , <varlist>)]'#13#10+
                      '<constdecl>:const~ <id> "=" <expression>'#13#10+
                      '<varlist>:<id>[( , <id>)][ "as" <argtype>][ "=" <expression>]'#13#10+
                      '<globaldecl>:<globalvisibility>~ <varlist>[( , <varlist>)]'#13#10+
                      '<globalvisibility>:{public|private|dim}'#13#10+
                      '<statement>:{<constdecl>|<vardecl>|<if>|<for>|<do_loop>|<whileend>|<assign>|<try>|<call>|<case>|<exit>|<return>|<with>}'#13#10+
                      '<call>:<id><arg_list><indexing><call_code>[.<call>]'#13#10+
                      '<call_code>:'#13#10+
                      '<data_val>:<id><arg_list><indexing><data_val_code>[.<data_val>]'#13#10+
                      '<data_val_code>:'#13#10+
                      '<data_ref>:<id><arg_list><indexing><data_ref_code>[.<data_ref>]'#13#10+
                      '<data_ref_code>:'#13#10+
                      '<new_call>:"new"~ <id><arg_list><new_call_code>'#13#10+
                      '<new_call_code>:'#13#10+
                      '<arg_list>:[ "(" [<expression> [(, <expression> )]]")"]'#13#10+
                      '<indexing>:[( "[" <expression> [(, <expression> )]"]")]'#13#10+
                      '<assign>R:["set "] <data_ref> = <expression>'#13#10+
                      '<push_output>:'#13#10+
                      '<for>:<for_control>[ step <step>][( <statement>[ :])] next'#13#10+
                      '<for_control>:for <id> = <expression> to <expression>'#13#10+
                      '<step>:[{-|+}](#)[.(#)][e[{-|+}](#)]'#13#10+
                      '<do_loop>:do~ {<test_loop>|<loop_test>}'#13#10+
                      '<test_loop>:<test_loop_expr>[( <statement>[ :])] loop'#13#10+
                      '<test_loop_expr>:{<while>|<until>} <expression>'#13#10+
                      '<loop_test>:[( <statement>[ :])] loop <loop_test_expr>'#13#10+
                      '<loop_test_expr>:{<while>|<until>} <expression>'#13#10+
                      '<while>:while'#13#10+
                      '<until>:until'#13#10+
                      '<whileend>:while <whileend_expr>[( <statement>[ :])] end while'#13#10+
                      '<whileend_expr>:<expression>'#13#10+
                      '<if>:{if <expression> <then> [{<elseif>|<else>}] end if|if ^<expression> ^<then_single>[ ^<else_single>]}'#13#10+
                      '<then>:then \( <statement>[ :])'#13#10+
                      '<then_single>:then( ^<statement>[ ^":"])'#13#10+
                      '<elseif>:elseif <expression> <then> [{<elseif>|<else>}]'#13#10+
                      '<else>:else( <statement>[ :])'#13#10+
                      '<else_single>:else( ^<statement>[ ^":"])'#13#10+
                      '<expression>:{[<unary>]{<new_call>|<data_val>|"(" <expression> ")"}|<hex>|<real>|<string>|<vector>}[( <operator> {[<Unary>]{<new_call>|<data_val>|"(" <expression> ")"}|<hex>|<real>|<string>|<vector>})]'#13#10+
                      '<operator>:{"^"|*|/|and~|+|-|or~|"<>"|">="|"<="|"="|">"|"<"|"&"|div~|mod~|xor~|shl~|shr~|is~}'#13#10+
                      '<unary>:{not~ |-|+}'#13#10+
                      '<label>:<id>'#13#10+
                      '<id>:{@|_}[({@|#|_})]'#13#10+
                      '<real>:[{-|+}](#)[<frac>][<exp>]'#13#10+
                      '<hex>:"0x"({#|a|b|c|d|e|f})'#13#10+
                      '<frac>:.(#)'#13#10+
                      '<exp>:e[{-|+}](#)'#13#10+
                      '<string>:$'#13#10+
                      '<vector>:"[" [<expression> [(, <expression> )]]"]"'#13#10+
                      '<try>:try <try_statements> {<finally>|<except>} <try_upshot> end[ try][ :]'#13#10+
                      '<finally>:finally'#13#10+
                      '<except>:{catch|except}'#13#10+
                      '<try_statements>:[( <statement>[ :])]'#13#10+
                      '<try_upshot>:[( <statement>[ :])]'#13#10+
                      '<case>:select case <case_expr> <case_branch> end select'#13#10+
                      '<case_expr>:<expression>'#13#10+
                      '<case_branch>:[{case else( <statement>[ :])|case <case_test>[( , <case_test>)] <case_match>[ <case_branch>]}]'#13#10+
                      '<case_test>:<expression>'#13#10+
                      '<case_match>:[( <statement>[ :])]'#13#10+
                      '<exit>:exit {<exit_sub>|<exit_function>|<exit_do>|<exit_for>}'#13#10+
                      '<exit_sub>:sub'#13#10+
                      '<exit_function>:function'#13#10+
                      '<exit_do>:do'#13#10+
                      '<exit_for>:for'#13#10+
                      '<return>:return[ ^<expression>]'#13#10+
                      '<with>:with <with_obj>[( <statement>[ :])] end with'#13#10+
                      '<with_obj>:{<new_call>|<data_val>}';

const
   {------------------------------------------------------------------------------}
   { Constantes para tratamento de operadores no gerador de código                }
   {------------------------------------------------------------------------------}

   { Precedencia de operadores: "0" é o de maior prioridade }
   { 4 -> inOperNE, inOperGE, inOperLE, inOperEqual, inOperGreater, inOperLess }
   { 3 -> inOperAdd, inOperConcat, inOperSub, inOperOr, inOperXor }
   { 2 -> inOperMul, inOperSlash, inOperDiv, inOperMod, inOperAnd , inOperShl, inOperShr }
   { 1 -> inOperExp }
   { 0 -> inOperNeg, inOperNot }

   BasicOperatorLevel : array[inOperNE..inOperNot] of byte = (
     { inOperNE      } 4,
     { inOperGE      } 4,
     { inOperLE      } 4,
     { inOperEqual   } 4,
     { inOperGreater } 4,
     { inOperLess    } 4,
     { inOperAdd     } 3,
     { inOperConcat  } 3,
     { inOperSub     } 3,
     { inOperOr      } 3,
     { inOperXor     } 3,
     { inOperMul     } 2,
     { inOperSlash   } 2,
     { inOperDiv     } 2,
     { inOperMod     } 2,
     { inOperAnd     } 2,
     { inOperShl     } 2,
     { inOperShr     } 2,
     { inOperExp     } 1,
     { inOperIs      } 1,
     { inOperNeg     } 0,
     { inOperNot     } 0 );


   BasicOperatorId : array[inOperNE..inOperNot] of string = (
     { inOperNE      } '<>',
     { inOperGE      } '>=',
     { inOperLE      } '<=',
     { inOperEqual   } '=',
     { inOperGreater } '>',
     { inOperLess    } '<',
     { inOperAdd     } '+',
     { inOperConcat  } '&',
     { inOperSub     } '-',
     { inOperOr      } 'OR',
     { inOperXor     } 'XOR',
     { inOperMul     } '*',
     { inOperSlash   } '/',
     { inOperDiv     } 'DIV',
     { inOperMod     } 'MOD',
     { inOperAnd     } 'AND',
     { inOperShl     } 'SHL',
     { inOperShr     } 'SHR',
     { inOperExp     } '^',
     { inOperIs      } 'IS',
     { inOperNeg     } '',
     { inOperNot     } 'NOT' );

{TatBasicScripter}

procedure TatBasicScripter.DefineInternalClasses;
begin
  ScriptClass := TatBasicScript;
  MachineClass := TatVirtualMachine;
end;

constructor TatBasicScripter.Create( AOwner:TComponent );
begin
   { script classes customization }
   inherited Create(AOwner);
   LibOptions.CompiledFileExt := '.bcu';
   LibOptions.SourceFileExt := '.bsc';
   if Assigned(OnGlobalScripterCreate) then
     OnGlobalScripterCreate(Self);
end;

destructor TatBasicScripter.Destroy;
begin
   inherited;
end;

{ TatBasicScript }

constructor TatBasicScript.Create(ACollection: TCollection);
begin
   RefactorClass := TatBasicRefactor;
   inherited Create(ACollection);

   FPushVarListObjects := TObjectList.Create(true);
   { define os nós da árvore sintática }
   with Parser, NoTerminals do
   begin
      { Gramática da linguagem atBasic }
      Grammar.Text := atBASIC_GRAMMAR;

      { define as rotinas para a geraçao de código }
      Items[ ord(bnProgram)        ].AssignNodeScanningEvents( BeforeProgram,     AfterProgram );
      Items[ ord(bnMain)           ].AssignNodeScanningEvents( BeforeMain,        AfterMain );
      Items[ ord(bnUses)           ].AssignNodeScanningEvents( nil,               AfterUses );
      Items[ ord(bnImports)        ].AssignNodeScanningEvents( nil,               AfterImports );
      Items[ ord(bnSubRoutine)     ].AssignNodeScanningEvents( BeforeSubRoutine,  AfterSubRoutine );
      Items[ ord(bnFunction)       ].AssignNodeScanningEvents( BeforeSubRoutine,  AfterSubRoutine );
      Items[ ord(bnInputArgs)      ].AssignNodeScanningEvents( nil,               AfterInputArgs );
      Items[ ord(bnVarDecl)        ].AssignNodeScanningEvents( nil,               AfterVarDecl );
      Items[ ord(bnGlobalDecl)     ].AssignNodeScanningEvents( nil,               AfterVarDecl );
      Items[ ord(bnConstDecl)      ].AssignNodeScanningEvents( nil,               AfterConstDecl );
      Items[ ord(bnStatement)      ].AssignNodeScanningEvents( nil,               nil );
      Items[ ord(bnAssign)         ].AssignNodeScanningEvents( nil,               nil );
      Items[ ord(bnPush_Output)    ].AssignNodeScanningEvents( nil,               AfterPushOutput );
      Items[ ord(bnFor)            ].AssignNodeScanningEvents( BeforeFor,         AfterFor );
      Items[ ord(bnFor_Control)    ].AssignNodeScanningEvents( nil,               AfterForControl );
      Items[ ord(bnStep)           ].AssignNodeScanningEvents( nil,               AfterStep );
      Items[ ord(bnTest_loop)      ].AssignNodeScanningEvents( BeforeTestLoop,    AfterTestLoop );
      Items[ ord(bnTest_loop_expr) ].AssignNodeScanningEvents( BeforeTestLoopExpr,AfterTestLoopExpr );
      Items[ ord(bnLoop_test)      ].AssignNodeScanningEvents( BeforeLoopTest,    nil );
      Items[ ord(bnLoop_test_expr) ].AssignNodeScanningEvents( BeforeLoopTestExpr,AfterLoopTestExpr );
      Items[ ord(bnWhileEnd)       ].AssignNodeScanningEvents( BeforeTestLoop,    AfterTestLoop );
      Items[ ord(bnWhileEnd_expr)  ].AssignNodeScanningEvents( BeforeTestLoopExpr,AfterWhileEndExpr );
      Items[ ord(bnIf)             ].AssignNodeScanningEvents( BeforeIf,          AfterIf );
      Items[ ord(bnThen)           ].AssignNodeScanningEvents( BeforeThen,        AfterThen );
      Items[ ord(bnThenSingle)     ].AssignNodeScanningEvents( BeforeThen,        AfterThen );
      Items[ ord(bnElseIf)         ].AssignNodeScanningEvents( BeforeElseIf,      AfterElseIf );
      Items[ ord(bnElse)           ].AssignNodeScanningEvents( BeforeElse,        nil );
      Items[ ord(bnElseSingle)     ].AssignNodeScanningEvents( BeforeElse,        nil );
      Items[ ord(bnExpression)     ].AssignNodeScanningEvents( BeforeExpression,  AfterExpression );
      Items[ ord(bnOperator)       ].AssignNodeScanningEvents( nil,               AfterOperator );
      Items[ ord(bnUnary)          ].AssignNodeScanningEvents( nil,               AfterUnary );
      Items[ ord(bnLabel)          ].AssignNodeScanningEvents( nil,               AfterLabel );
      Items[ ord(bnId)             ].AssignNodeScanningEvents( nil,               AfterId );
      Items[ ord(bnReal)           ].AssignNodeScanningEvents( nil,               AfterReal );
      Items[ ord(bnHex)            ].AssignNodeScanningEvents( nil,               AfterHex );
      Items[ ord(bnString)         ].AssignNodeScanningEvents( nil,               AfterString );
      Items[ ord(bnVector)         ].AssignNodeScanningEvents( nil,               AfterVector );
      Items[ ord(bnCall_code)      ].AssignNodeScanningEvents( BeforeCallCode,    nil );
      Items[ ord(bnData_val_code)  ].AssignNodeScanningEvents( BeforeDataValCode, nil );
      Items[ ord(bnData_ref_code)  ].AssignNodeScanningEvents( BeforeDataRefCode, nil );
      Items[ ord(bnNew_call_code)  ].AssignNodeScanningEvents( BeforeNewCallCode, nil );
      Items[ ord(bnArg_list)       ].AssignNodeScanningEvents( BeforeArgList,     AfterArgList );
      Items[ ord(bnIndexing)       ].AssignNodeScanningEvents( BeforeIndexing,    AfterIndexing );
      Items[ ord(bnTry)            ].AssignNodeScanningEvents( BeforeTry,         nil);
      Items[ ord(bnTry_Statements) ].AssignNodeScanningEvents( nil,               AfterTryStatements );
      Items[ ord(bnTry_Upshot)     ].AssignNodeScanningEvents( nil,               AfterTryUpshot );
      Items[ ord(bnTry_Upshot)     ].AssignNodeScanningEvents( nil,               AfterTryUpshot );
      Items[ ord(bnCase)           ].AssignNodeScanningEvents( BeforeCase,        AfterCase );
      Items[ ord(bnCase_expr)      ].AssignNodeScanningEvents( nil,               AfterCaseExpr );
      Items[ ord(bnCase_branch)    ].AssignNodeScanningEvents( BeforeCaseBranch,  AfterCaseBranch );
      Items[ ord(bnCase_test)      ].AssignNodeScanningEvents( nil,               AfterCaseTest );
      Items[ ord(bnCase_match)     ].AssignNodeScanningEvents( BeforeCaseMatch,   AfterCaseMatch );
      Items[ ord(bnExit_sub)       ].AssignNodeScanningEvents( nil,               AfterExitRoutine );
      Items[ ord(bnExit_function)  ].AssignNodeScanningEvents( nil,               AfterExitRoutine );
      Items[ ord(bnExit_do)        ].AssignNodeScanningEvents( nil,               AfterExitLoop );
      Items[ ord(bnExit_for)       ].AssignNodeScanningEvents( nil,               AfterExitLoop );
      Items[ ord(bnReturn)         ].AssignNodeScanningEvents( nil,               AfterReturn );
      Items[ ord(bnWith)           ].AssignNodeScanningEvents( nil,               AfterWith );
      Items[ ord(bnWith_obj)       ].AssignNodeScanningEvents( nil,               AfterWithObj );
      Items[ ord(bnExternal)       ].AssignNodeScanningEvents( nil,               AfterExternal );

      { Parser token customization }
      Items[ ord(bnId) ].OnAcceptNode:=AcceptNodeId;

      { Parser special symbols }
      StringDelimitter := '"';
      Parser.Comments.Clear;
      Parser.Comments.Add('''',#13);
      Parser.Comments.Add('REM ',#13).PriorDelims := ' :'#13#10;
      Parser.Comments.Add('#', #13).PriorDelims := ' :'#13#10;

      {directive processing}
      Parser.OnExtractRemark := ExtractSourceRemark;
   end;
end;

destructor TatBasicScript.Destroy;
begin
  FPushVarListObjects.Free;
  inherited;
end;

procedure TatBasicScript.Clear;
begin
   inherited;
   { inicialização de variáveis para geração de código atBasic }
   FForCount         := CounterInit;
   FCurrentFor       := CounterInit;
   FWhileCount       := CounterInit;
   FCurrentWhile     := CounterInit;
   FRepeatCount      := CounterInit;
   FCurrentRepeat    := CounterInit;
   FIfCount          := CounterInit;
   FCurrentIf        := CounterInit;
   FCaseCount        := CounterInit;
   FCurrentCase      := CounterInit;
   FCaseBranchLevel  := CounterInit;
   FCaseVarIndex     := CounterInit;
   FWithCount        := CounterInit;
   FCurrentWith      := CounterInit;
   FOperatorCount    := CounterInit;
   FCurrentOperator  := CounterInit;
   FCurrentLoop      := lsNone;
   FThereIsAnySubrot := False;
end;

function TatBasicScript.AcceptNodeId( Node:TNoTerminalNode ):boolean;
var id:string;
begin
   { não aceita identificadores que forem palavras reservadas da liguagem }
   id:=LowerCase(Node.InputToken);
   result := (id<>'sub') and
             (id<>'uses') and
             (id<>'imports') and
             (id<>'function') and
             (id<>'end') and
             (id<>'if') and
             (id<>'then') and
             (id<>'else') and 
             (id<>'elseif') and 
             (id<>'do') and
             (id<>'loop') and
             (id<>'until') and
             (id<>'for') and
             (id<>'to') and
             (id<>'while') and
             (id<>'step') and
             (id<>'next') and
             (id<>'select') and
             (id<>'case') and
             (id<>'with') and
             (id<>'dim') and
             (id<>'const') and
             (id<>'public') and
             (id<>'private') and
             (id<>'not') and
             (id<>'and') and
             (id<>'or') and
             (id<>'xor') and
             (id<>'div') and
             (id<>'mod') and
             (id<>'shl') and
             (id<>'shr') and
             (id<>'exit') and
             (id<>'try') and
             (id<>'except') and
             (id<>'catch') and 
             (id<>'finally') and
             (id<>'return') and
             (id<>'as') and
             (id<>'forward');

   { se encontrou uma palavra reservada então ainda aceita-a se ela for
     um sufixo de um acesso pontuado (exemplo: x.end é uma construção válida quando
     x é um objeto OLE }
   { !!! este teste é muito sensível a gramática e para diminuir o esforço
     computacional simplifiquei bastante a comparação.
     um "id" pode ser nó nas seguintes possibilidades:
     <program>....<label>.<id>
     <program>....<for_control>.<id>
     <program>....<get>.<id>
     <program>....<for_control>.<id>
     <program>....<data_val>.<data_val>.<id>
     <program>....<data_ref>.<data_ref>.<id>
   }
   if not result and
      (Node.ParentNode.NoTerminalIndex = Node.ParentNode.ParentNode.NoTerminalIndex) then
      result := true;
end;

procedure TatBasicScript.ExtractSourceRemark(AParser: TatSyntaxParser; AStartPos, AFinalPos: integer);

  function GetDefineID(const ARemark: string): string;
  var
    p: integer;
  begin
    result := '';
    p := Pos(' ', ARemark);
    if p > 0 then
    begin
      result := Copy(ARemark, p + 1, MaxInt);
      {remove last character (#13)}
      result := Copy(result, 1, Length(result) - 1);
      result := Trim(result);
    end;
  end;

type
  TPascalDirectiveType = (pdtNone, pdtForm);
const
  {Be careful with trailing spaces in the items of this array - they must exist
   for directives that requires a parameter (IFDEF, DEFINE, etc.)}
  DirCount = 1;
  DirStrArray : array[0..DirCount - 1] of string =
    ('FORM');
  DirTypeArray : array[0..DirCount - 1] of TPascalDirectiveType =
    (pdtForm);
var
  Remark : string;
  c: integer;
  ADirectiveType: TPascalDirectiveType;
  DefineID: string;
  FormClass, FormFile: string;
begin
  ADirectiveType := pdtNone;
  with AParser do
  begin
     {Get comment (remark)}
     Remark := Copy(Input, AStartPos, AFinalPos - AStartPos + 1);

     {Check if comment is one of directives declared in DirectiveArray array}
     for c := 0 to DirCount - 1 do
       if Pos('#' + DirStrArray[c], Uppercase(Remark)) = 1 then
         ADirectiveType := DirTypeArray[c];

     DefineID := GetDefineID(Remark);

     {Process directives}
     Case ADirectiveType of
       pdtForm:
         begin
           FormClass := trim(Copy(DefineID, 1, Pos(',', DefineID) - 1));
           FormFile := trim(Copy(DefineID, Pos(',', DefineID) + 1, MaxInt));
           if (FormClass = '') or (FormFile = '') then
             CompileError('Invalid FORM directive syntax. Correct syntax is: "#FORM CLASSNAME, FILENAME"',
               Parser.ScanningInputPos);
           CompileForm(FormClass, FormFile);
         end;
     end;
  end;
end;

{-----------------------------------------------------------------------------}
{ geração de código                                                           }
{-----------------------------------------------------------------------------}
procedure TatBasicScript.BeforeProgram( Node:TNoTerminalNode );
begin
  { always creates a instruction to allocate space for global variables
    (see AfterProgram) }
  with AppendInstruction(inGlobalPrepare)^ do
  begin
    vDebugInfo := Node.InputInitialPos;
    vInteger := 0;
  end;
end;

procedure TatBasicScript.AfterProgram( Node:TNoTerminalNode );
begin
  { adjust the global variable counter on the first preparation instruction
    (see BeforeProgram) }
  FirstInstruction^.vInteger := ScriptInfo.Globals.Count;
end;

procedure TatBasicScript.BeforeMain( Node:TNoTerminalNode );
begin
  { simula um AfterId }
  StackPush( stIdentifierList, '___MAIN___' );
  { executa o AfterLabel( Node ) }
  Parser.NoTerminals[ord(bnLabel)].OnAfterNodeScan( Node );
  ScriptInfo.MainRoutine := CurrentRoutine;
  { se o main é uma função então declara uma variável Result automaticamente }
  if CurrentRoutine.IsFunction then
    { declara uma variável para receber o argumento de saída acessível pelo nome 'Main'}
    CurrentRoutine.ResultIndex := CurrentRoutine.DeclareVariable('Main', Parser.ScanningInputPos ).VarIndex;
end;

procedure TatBasicScript.AfterMain( Node:TNoTerminalNode );
begin
   AfterSubRoutine( Node );
end;

procedure TatBasicScript.AfterUses( Node:TNoTerminalNode );
var c: integer;
    AUnitName: string;
    ALib: TatScripterLibrary;
begin
  ALib := nil;
  for c:=0 to Node.Nodes.Count-1 do
  begin
    AUnitName := StackPop(stIdentifierList);
    try
      ALib := LoadLibrary( AUnitName, True );
    except
      on e: Exception do
        CompileError(e.Message, Parser.ScanningInputPos);
    end;
    with UsedUnits.Add do
    begin
      UnitName := AUnitName;
      IsDefault := True;
      IsScript := ALib is TatScriptBasedLibrary;
      DeclSourcePos := Node.Nodes[c].InputInitialPos;
    end;
  end;
end;

procedure TatBasicScript.AfterImports( Node:TNoTerminalNode );
var c: integer;
    AUnitName: string;
    ALib: TatScripterLibrary;
begin
  ALib := nil;
  for c:=0 to Node.Nodes.Count-1 do
  begin
    AUnitName := StackPop(stIdentifierList);
    try
      ALib := LoadLibrary(AUnitName, False);
    except
      on e: Exception do
        CompileError(e.Message, Parser.ScanningInputPos);
    end;
    with UsedUnits.Add do
    begin
      UnitName := AUnitName;
      IsDefault := False;
      IsScript := ALib is TatScriptBasedLibrary;
      DeclSourcePos := Node.Nodes[c].InputInitialPos;
    end;
  end;
end;

procedure TatBasicScript.BeforeSubRoutine( Node:TNoTerminalNode );
begin
  { se for a primeira subrotina do programa então gera, antes dela,
    um desvio para o bloco principal (que só será completamente
    resolvido quando encontrar o bloco principal }
  if not FThereIsAnySubrot then
  begin
    with AppendInstruction(inJump)^ do
    begin
      vInteger   := RegisterReference('___MAIN___');
      vDebugInfo := Parser.ScanningInputPos;
    end;
    FThereIsAnySubrot := True;
  end;
end;

procedure TatBasicScript.AfterSubRoutine( Node:TNoTerminalNode );
begin
  with CurrentRoutine do
    if Assigned(DeclarationInstruction) then
    begin
      { define o endereço de finalização da subrotina }
      DefineReferenceAddress( '@EndSub'+inttostr(Index) );
      { se a subrotina for uma Function, então retorna a variável
        "result" automaticamente }
      if IsFunction then
        with AppendInstruction(inPushVar)^ do
        begin
          vInteger   := ResultIndex;
          vString    := Name;
          vDebugInfo := Parser.ScanningInputPos;
        end;
      { corrige o total de variáveis do processo na instrução de preparação.
        a posição desta instrução foi salva na pilha de variáveis do processo }
      DeclarationInstruction^.vInteger:=LocalVarCount;
      { insere a instrução de retorno do processo }
      with AppendInstruction(inRet)^ do
      begin
         vDebugInfo := Parser.ScanningInputPos;
      end;
  end;
end;

procedure TatBasicScript.AfterId( Node:TNoTerminalNode );
begin
   { guarda o identificador numa lista empilhada: stIdentifierList }
   StackPush( stIdentifierList, Node.InputToken );
end;

procedure TatBasicScript.AfterLabel( Node:TNoTerminalNode );
var
  id: string;
  isFunction: boolean;
  prototyping: boolean;
  routine: TatRoutineInfo;
  functionNode: TNoTerminalNode;
  argTypeNodeIndex: integer;
  visibility: TatRoutineVisibility;
  visibilityNode: TNoTerminalNode;
begin
   { gramática:
       SUB / FUNCTION
         LABEL
         [ FORWARD ]
     ou
       MAIN }

   id := StackPop(stIdentifierList);
   prototyping :=
     (Node.NoTerminalIndex <> ord(bnMain)) and { <subroutine>: forward or external }
     (Node.ParentNode[Node.ParentNode.Nodes.Count-1].NoTerminalIndex in [ord(bnForward), ord(bnExternal)]);

   if not prototyping then
   begin
     { registra o endereço inicial do processo }
     DefineReferenceAddress(id);
     { insere a instrução que vai alocar espaço para variáveis locais do processo }
     with AppendInstruction(inPrepare)^ do
     begin
        vString    := id;
        vDebugInfo := Node.InputInitialPos;
     end;
   end;

   { obtain procedure visibility }
   visibilityNode := Node.ParentNode.Nodes.FindByNoTerminalName(Parser.NoTerminals[Ord(bnSubVisibility)].IdS);
   if (visibilityNode <> nil) and SameText('private', visibilityNode.InputToken) then
     visibility := rvPrivate
   else
     visibility := rvPublic;

   { verifica na estrutura sintática se este procedimento é uma função }
   isFunction :=
     (Node.ParentNode.NoTerminalIndex = ord(bnFunction)) or
     (Node.NoTerminalIndex = ord(bnMain));
   if (id='___MAIN___') and IsDebugScript then
   begin
     CurrentRoutine := DebugScriptMainRoutine;
     CurrentRoutine.DeclarationInstruction := LastInstruction;
     CurrentRoutine.IsFunction := False;
   end
   else
   begin
     routine := ScriptInfo.RoutineByName( id );

     if not Assigned( routine ) then
     begin
       if prototyping then
       begin
         { registra uma nova rotina no script corrente }
         CurrentRoutine := ScriptInfo.DeclareRoutine( id, nil, isFunction );

         { completa a declaração com informações que vêm do parser }
         functionNode := Node.ParentNode;
         argTypeNodeIndex := functionNode.Nodes.IndexOf(Ord(bnArgType));
         if IsFunction and (argTypeNodeIndex >= 0) then
           CurrentRoutine.ResultTypeDecl := functionNode.Nodes[argTypeNodeIndex].InputToken;
       end
       else
       begin
         { registra uma nova rotina no script corrente }
         CurrentRoutine := ScriptInfo.DeclareRoutine( id, LastInstruction, isFunction );
         functionNode := Node.ParentNode;
         argTypeNodeIndex := functionNode.Nodes.IndexOf(Ord(bnArgType));
         if IsFunction and (argTypeNodeIndex >= 0) then
           CurrentRoutine.ResultTypeDecl := functionNode.Nodes[argTypeNodeIndex].InputToken;
       end;
     end
     else
     begin
       if prototyping then
         CompileError( Format('Illegal redeclaration of routine ''%s''',[id]),Parser.ScanningInputPos )
       else
         if not Assigned(routine.DeclarationInstruction) then
         begin
           if routine.Visibility <> visibility then
             CompileError(Format('Cannot redeclare routine "%s" with a different visibility (public/private) than its prototype.',
               [id]), Parser.ScanningInputPos);

           { verifica se a prévia declaração corresponde a atual }
           // a ser implementado ...

           { modifica o nome da declaração anterior para que ela não seja
             encontrada como um rotina válida mas sim um protótipo de função }
           routine.Name := '#' + routine.Name;
           CurrentRoutine := ScriptInfo.DeclareRoutine( id, LastInstruction, isFunction );
           CurrentRoutine.Prototype := routine;
         end
         else
           CompileError( Format('Illegal reimplementation of routine ''%s''.'#13#10+'Use forward clause for prototyping',[id]),Parser.ScanningInputPos );
     end;
     if CurrentRoutine <> nil then
       CurrentRoutine.Visibility := visibility;

  end;
end;

procedure TatBasicScript.AfterInputArgs( Node:TNoTerminalNode );
var c, c1 : integer;
    ok : boolean;
    variable: TatVariableInfo;
    typeNode: TNoTerminalNode;
begin
  with CurrentRoutine do
  begin
    for c:=0 to Node.Nodes.Count-1 do
    begin
       { declara uma variável para receber o argumento de entrada }
       if Node[c].NoTerminalIndex=ord(bnByRef) then
          variable := DeclareVariable(Node[c][0].InputToken,Node[c][0].InputInitialPos,c,moVar)
       else
          variable := DeclareVariable(Node[c][0].InputToken,Node[c][0].InputInitialPos,c);

       { check to see if a type was explicited to argument }
       if Node[c].Nodes[Node[c].Nodes.Count-1].NoTerminalIndex = ord(bnArgType) then
       begin
         typeNode := Node[c].Nodes[Node[c].Nodes.Count-1];
         variable.TypeDecl := typeNode.InputToken;
         variable.SetTypeFromString(variable.TypeDecl);
       end;

       { remove a variável da pilha de identificadores encontrados }
       StackPop(stIdentifierList);
    end;

    { se a subrotina for uma function, então declara automaticamente
      uma variável "result" para receber o resultado da função }
    if IsFunction then
    begin
      { declara uma variável para receber o argumento de saída }
      variable := DeclareVariable(CurrentRoutine.Name,Parser.ScanningInputPos);
      ResultIndex := variable.VarIndex;
      variable.TypeDecl := ResultTypeDecl;
      variable.SetTypeFromString(variable.TypeDecl);
    end;

    { se a subrotina possui um protótipo então verifica se o protótipo corresponde
      a implentação real }
    if Assigned(Prototype) then
    begin
      ok := Variables.Count = Prototype.Variables.Count;
      c1 := Parser.ScanningInputPos; { source position for error message }
      if ok then
        for c:=0 to Variables.Count-1 do
          if not Variables[c].SameDeclaration( Prototype.Variables[c] ) then
          begin
            ok := False;
            c1 := Variables[c].DeclarationSourcePos;
            Break;
          end;
      if not ok then
        CompileError( Format('Implementation of routine ''%s'' differs from previous declaration',[Name]),c1 );
    end;
  end;
end;
(*
function soma( a, b )
   soma =  a + b
end function

caption = soma( 1, 2 )
*)
procedure TatBasicScript.AfterVarDecl( Node:TNoTerminalNode );
var c, d : integer;
    variable: TatVariableInfo;
    typeNode: TNoTerminalNode;
    exprNode: TNoTerminalNode;
    visNode: TNoTerminalNode;
    visibility: TatVariableVisibility;
begin
//                      '<vardecl>:dim~ <varlist>[( , <varlist>)]'#13#10+
//                      '<varlist>:<id>[( , <id>)][ "as" <argtype>][ "=" <expression>]'#13#10+

   visNode := Node.Nodes.FindByNoTerminalName(Parser.NoTerminals[Ord(bnGlobalVisibility)].IdS);
   if (visNode <> nil) and SameText(visNode.InputToken, 'private') then
     visibility := vvPrivate
   else
     visibility := vvPublic;

   { declaração de variáveis }
   for c := 0 to Node.Nodes.Count - 1 do
      if (Node[c].NoTerminalIndex = Ord(bnVarList)) then
      with Node[c] do
      begin
         { Node[c] é um <varlist> }

         { check to see if a type was explicited to variable }
         typeNode := Nodes.FindByNoTerminalName(Parser.NoTerminals[Ord(bnArgType)].IdS);
         exprNode := Nodes.FindByNoTerminalName(Parser.NoTerminals[Ord(bnExpression)].IdS);

         for d := 0 to Nodes.Count - 1 do
           if Nodes[d].NoTerminalIndex = ord(bnID) then
             begin
               { declare the variable. }
               variable := DeclareVariable( Nodes[d].InputToken, -1, moNone, not Assigned(CurrentRoutine), Nodes[d].InputInitialPos );
               variable.Visibility := visibility;

               {If expression node is present, then set the value of variable by creating an optimizestorevar instruction}
               if exprNode <> nil then
                 OptimizeStoreVar(variable);

               { se o tipo da variável foi especificado tenta obter informações desse tipo }
               if typeNode <> nil then
               begin
                  variable.SetTypeFromString( typeNode.InputToken );
                  variable.TypeDecl := typeNode.InputToken;
               end;
             end;

         { remove a variável da pilha de identificadores encontrados }
         StackPop( stIdentifierList );
      end;
end;

procedure TatBasicScript.AfterPushOutput( Node:TNoTerminalNode );
var c: integer;
begin
   { salva tantos resultados do <call> quantos forem as atribuições }
   for c:=0 to Node.OwnerNodes.Count-3 do
      with AppendInstruction(inPushOutput)^ do
      begin
         vInteger   := c;
         vDebugInfo := Parser.ScanningInputPos;
      end;
end;

procedure TatBasicScript.BeforeFor( Node:TNoTerminalNode );
begin
   { controle do nível de aninhamento do for }
   StackPush(stContext,FCurrentFor);
   inc(FForCount);
   FCurrentFor:=FForCount;
   { controle do statement de loop atual }
   StackPush(stContext,FCurrentLoop);
   FCurrentLoop:=lsFor;
end;

procedure TatBasicScript.AfterFor( Node:TNoTerminalNode );
var VarName  : string;
    VarIndex : integer;
    IsGlobal : boolean;
    tempinst : TInstruction;
    step     : double;
begin
   DefineReferenceAddress( '@ForStep'+inttostr(FCurrentFor) );
   step := StackPop(stContext);
   if Frac(step) = 0 then
      with AppendInstruction(inPushInteger)^ do
      begin
         vInteger   := round(step);
         vDebugInfo := Parser.ScanningInputPos;
      end
   else
      with AppendInstruction(inPushDouble)^ do
      begin
         vDouble    := step;
         vDebugInfo := Parser.ScanningInputPos;
      end;

   IsGlobal := StackPop(stContext);
   VarIndex := StackPop(stContext);
   VarName := StackPop(stContext);

   if IsGlobal then
     tempinst := inPushGlobalVar
   else
     tempinst := inPushVar;

   with AppendInstruction(tempinst)^ do
   begin
      vInteger   := VarIndex;
      vString    := VarName;
      vDebugInfo := Parser.ScanningInputPos;
   end;

   with AppendInstruction(inOperAdd)^ do
   begin
      vDebugInfo := Parser.ScanningInputPos;
   end;

   with AppendInstruction(inJump)^ do
   begin
      vInteger   := RegisterReference('@ForLoop'+inttostr(FCurrentFor));
      vDebugInfo := Parser.ScanningInputPos;
   end;

   DefineReferenceAddress( '@EndFor'+inttostr(FCurrentFor) );
   { controle do statement de loop atual }
   FCurrentLoop:=StackPop(stContext);
   { controle do nível de aninhamento do for }
   FCurrentFor:=StackPop(stContext);
end;

procedure TatBasicScript.AfterForControl( Node:TNoTerminalNode );
var
   variable_end   : TatVariableInfo;
   variable_count : TatVariableInfo;
   step           : double;
   er             : integer;
   tempinst       : TInstruction;
begin
   { gera uma variável para armazenar o final da contagem }
   variable_end := CurrentRoutine.DeclareVariable('#ForStop'+inttostr(FCurrentFor),Parser.ScanningInputPos);
   OptimizeStoreVar(variable_end);
   { início do ciclo de repetição do for }
   DefineReferenceAddress( '@ForLoop'+inttostr(FCurrentFor) );
   { gera instrução de escrita na variável do contador do for }
   variable_count:=RegisterVariableReference(StackPop(stIdentifierList));

   if variable_count.Global then
   begin
     tempinst := inStoreGlobalVar;
   end else
   begin
     if variable_count.Modifier=moVar then
       tempinst := inStoreVarRef
     else
       tempinst := inStoreVar;
   end;

   With AppendInstruction(tempinst)^ do
   begin
      vInteger   := variable_count.VarIndex;
      vString    := variable_count.VarName;
      vDebugInfo := Parser.ScanningInputPos;
   end;

   { salva informações da variável para usar no final do for }
   StackPush(stContext, variable_count.VarName);
   StackPush(stContext, variable_count.VarIndex);
   StackPush(stContext, variable_count.Global);

   { comparação para verificar se o fim da contagem foi atingido }
   if variable_count.Global then
     tempinst := inPushGlobalVar
   else
     tempinst := inPushVar;

   with AppendInstruction(tempinst)^ do
   begin
      vInteger   := variable_count.VarIndex;
      vString    := variable_count.VarName;
      vDebugInfo := Parser.ScanningInputPos;
   end;

   with AppendInstruction(inPushVar)^ do
   begin
      vInteger   := variable_end.VarIndex;
      vString    := variable_end.VarName;
      vDebugInfo := Parser.ScanningInputPos;
   end;

   { se possui cláusula step então obtém o passo do contador senão assume passo 1 }
   if (Node.OwnerNodes.Count>1) and (Node.OwnerNodes[1].NoTerminalIndex=ord(bnStep)) then
      val(Node.OwnerNodes[Node.OwnerNodes.IndexOf(ord(bnStep))].InputToken,step,er)
   else
   begin
      StackPush(stContext,1);
      step:=1;
   end;

   { diferenciação entre contagens ascendentes e descendentes }
   if (Node.OwnerNodes.Count>1) and (Node.OwnerNodes[1].NoTerminalIndex=ord(bnStep)) and (step<0) then
      with AppendInstruction(inOperGE)^ do
      begin
         vDebugInfo := Parser.ScanningInputPos; { for downto }
      end
   else
      with AppendInstruction(inOperLE)^ do
      begin
         vDebugInfo := Parser.ScanningInputPos; {for to }
      end;
   { desvio para o início do loop for }
   with AppendInstruction(inJumpIfFalse)^ do
   begin
      vInteger   := RegisterReference('@EndFor'+inttostr(FCurrentFor));
      vDebugInfo := Parser.ScanningInputPos;
   end;
end;

procedure TatBasicScript.AfterStep( Node:TNoTerminalNode );
var step : double;
    er   : integer;
begin
   val(Node.InputToken,step,er);
   StackPush(stContext,step);
end;

procedure TatBasicScript.BeforeTestLoop( Node:TNoTerminalNode );
begin
   { controle do nível de aninhamento do while }
   StackPush(stContext,FCurrentWhile);
   FCurrentWhile:=FWhileCount;
   inc(FWhileCount);
   { controle do statement de loop atual }
   StackPush(stContext,FCurrentLoop);
   FCurrentLoop:=lsWhile;
end;

procedure TatBasicScript.AfterTestLoop( Node:TNoTerminalNode );
begin
   with AppendInstruction(inJump)^ do
   begin
      vInteger   := RegisterReference('@WhileLoop'+inttostr(FCurrentWhile));
      vDebugInfo := Parser.ScanningInputPos;
   end;
   DefineReferenceAddress('@EndWhile'+inttostr(FCurrentWhile));
   { controle do statement de loop atual }
   FCurrentLoop:=StackPop(stContext);
   { controle do nível de aninhamento do while }
   FCurrentWhile:=StackPop(stContext);
end;

procedure TatBasicScript.BeforeTestLoopExpr( Node:TNoTerminalNode );
begin
   DefineReferenceAddress('@WhileLoop'+inttostr(FCurrentWhile));
end;

procedure TatBasicScript.AfterTestLoopExpr( Node:TNoTerminalNode );
begin
   { gera desvio correspondente a loop tipo WHILE ou UNTIL }
   if Node[0].NoTerminalIndex=ord(bnWhile) then
      with AppendInstruction(inJumpIfFalse)^ do
      begin
         vInteger   := RegisterReference('@EndWhile'+inttostr(FCurrentWhile));
         vDebugInfo := Parser.ScanningInputPos;
      end
   else
      with AppendInstruction(inJumpIfTrue)^ do
      begin
         vInteger   := RegisterReference('@EndWhile'+inttostr(FCurrentWhile));
         vDebugInfo := Parser.ScanningInputPos;
      end;
end;

procedure TatBasicScript.BeforeLoopTest( Node:TNoTerminalNode );
begin
   { controle do nível de aninhamento do repeat }
   StackPush(stContext,FCurrentRepeat);
   inc(FRepeatCount);
   FCurrentRepeat:=FRepeatCount;
   { controle do statement de loop atual }
   StackPush(stContext,FCurrentLoop);
   FCurrentLoop:=lsRepeat;
   DefineReferenceAddress('@RepeatLoop'+inttostr(FCurrentRepeat));
end;

procedure TatBasicScript.BeforeLoopTestExpr( Node:TNoTerminalNode );
begin
   { Define o endereço do bloco de teste do REPEAT }
   DefineReferenceAddress('@RepeatTest'+inttostr(FCurrentRepeat));
end;

procedure TatBasicScript.AfterLoopTestExpr( Node:TNoTerminalNode );
begin
   { gera desvio correspondente a loop tipo WHILE ou UNTIL }
   if Node[0].NoTerminalIndex=ord(bnWhile) then
      with AppendInstruction(inJumpIfTrue)^ do
      begin
         vInteger   := RegisterReference('@RepeatLoop'+inttostr(FCurrentRepeat));
         vDebugInfo := Parser.ScanningInputPos;
      end
   else
      with AppendInstruction(inJumpIfFalse)^ do
      begin
         vInteger   := RegisterReference('@RepeatLoop'+inttostr(FCurrentRepeat));
         vDebugInfo := Parser.ScanningInputPos;
      end;
   DefineReferenceAddress('@EndRepeat'+inttostr(FCurrentRepeat));
   { controle do statement de loop atual }
   FCurrentLoop:=StackPop(stContext);
   { controle do nível de aninhamento do repeat }
   FCurrentRepeat:=StackPop(stContext);
end;

procedure TatBasicScript.AfterWhileEndExpr( Node:TNoTerminalNode );
begin
   with AppendInstruction(inJumpIfFalse)^ do
   begin
      vInteger   := RegisterReference('@EndWhile'+inttostr(FCurrentWhile));
      vDebugInfo := Parser.ScanningInputPos;
   end;
end;

procedure TatBasicScript.BeforeIf( Node:TNoTerminalNode );
begin
   { controle do nível de aninhamento do if }
   StackPush(stContext,FCurrentIf);
   inc(FIfCount);
   FCurrentIf:=FIfCount;
end;

procedure TatBasicScript.AfterIf( Node:TNoTerminalNode );
begin
   DefineReferenceAddress( '@EndIf'+inttostr(FCurrentIf) );
   { controle do nível de aninhamento do if }
   FCurrentIf:=StackPop(stContext);
end;

procedure TatBasicScript.BeforeThen( Node:TNoTerminalNode );
begin
   { se o if tiver cláusula else desvia cond. para lá, senão desvia cond. para o fim do if }
   if Node.OwnerNodes.Count=2 then
      with AppendInstruction(inJumpIfFalse)^ do
      begin
         vInteger := RegisterReference('@EndIf'+inttostr(FCurrentIf));
         vDebugInfo := Parser.ScanningInputPos;
      end
   else
      with AppendInstruction(inJumpIfFalse)^ do
      begin
         vInteger := RegisterReference('@Else'+inttostr(FCurrentIf));
         vDebugInfo := Parser.ScanningInputPos;
      end;
end;

procedure TatBasicScript.AfterThen( Node:TNoTerminalNode );
begin
   { se o if tiver seção else, desvia-a }
   if Node.OwnerNodes.Count=3 then
      with AppendInstruction(inJump)^ do
      begin
         vInteger   := RegisterReference('@EndIf'+inttostr(FCurrentIf));
         vDebugInfo := Parser.ScanningInputPos;
      end;
end;

procedure TatBasicScript.BeforeElse( Node:TNoTerminalNode );
begin
   DefineReferenceAddress( '@Else'+inttostr(FCurrentIf) );
end;

procedure TatBasicScript.BeforeElseIf( Node:TNoTerminalNode );
begin
   { controle do nível de aninhamento do if }
   DefineReferenceAddress('@Else'+inttostr(FCurrentIf));
   StackPush(stContext,FCurrentIf);
   inc(FIfCount);
   FCurrentIf := FIfCount;
end;

procedure TatBasicScript.AfterElseIf( Node:TNoTerminalNode );
begin
   DefineReferenceAddress('@EndIf' + inttostr(FCurrentIf));
   { controle do nível de aninhamento do if }
   FCurrentIf := StackPop(stContext);
end;

procedure TatBasicScript.BeforeExpression( Node:TNoTerminalNode );
begin
   { insere delimitador de expressão na pilha de operadores pendentes }
   StackPushDelimitter(stPendingOperators);
end;

procedure TatBasicScript.AfterExpression( Node:TNoTerminalNode );
var
  opInStack: TInstruction;
  opNumber: integer;
begin
   { insert all pending operators }
   while not StackDelimitterFound(stPendingOperators) do
   begin
     opInStack := TInstruction(StackView(stPendingOperators) shr 20);
     opNumber := StackPop(stPendingOperators) and $FFFFF;
     with AppendInstruction(opInStack)^ do
       vDebugInfo := Parser.ScanningInputPos;
     if Scripter.ShortBooleanEval and (opInStack in [inOperAnd, inOperOr]) then
       DefineReferenceAddress('@Oper' + IntToStr(opNumber));
   end;

   { retira delimitador de expressão da pilha de operadores pendentes }
   StackPop(stPendingOperators);
end;

procedure TatBasicScript.AfterOperator( Node:TNoTerminalNode );
var
  i,op: TInstruction;
  id: string;
  opInStack: TInstruction;
  opNumber: integer;
begin
  { identifies the operator }
  op := low(TInstruction); // only to remove a delphi compiler warning
  id := UpperCase(TrimRight(Node.InputToken));
  for i := inOperNE to inOperNot do
     if id = BasicOperatorId[i] then
     begin
        op := i;
        break;
     end;
  inc(FOperatorCount);
  FCurrentOperator := FOperatorCount;

  { resolve operator precedence }
  while not StackDelimitterFound(stPendingOperators) and
     (BasicOperatorLevel[TInstruction(StackView(stPendingOperators) shr 20)] <= BasicOperatorLevel[op]) do
  begin
    opInStack := TInstruction(StackView(stPendingOperators) shr 20);
    opNumber := StackPop(stPendingOperators) and $FFFFF;
    with AppendInstruction(opInStack)^ do
      vDebugInfo := Parser.ScanningInputPos;
    if Scripter.ShortBooleanEval and (opInStack in [inOperAnd, inOperOr]) then
      DefineReferenceAddress('@Oper' + IntToStr(opNumber));
  end;

  {if short boolean evaluation, then test if boolean expression was satisfied}
  if Scripter.ShortBooleanEval then
    Case op of
      inOperAnd:
        with AppendInstruction(inTestIfFalse)^ do
        begin
          vInteger   := RegisterReference('@Oper' + inttostr(FCurrentOperator));
          vDebugInfo := Parser.ScanningInputPos;
        end;
      inOperOr:
        with AppendInstruction(inTestIfTrue)^ do
        begin
          vInteger   := RegisterReference('@Oper' + inttostr(FCurrentOperator));
          vDebugInfo := Parser.ScanningInputPos;
        end;
    end;

  { push the operator and its number in stack of pending operators}
  StackPush(stPendingOperators, (Ord(op) shl 20) or FCurrentOperator);
end;

procedure TatBasicScript.AfterUnary( Node:TNoTerminalNode );
begin
  inc(FOperatorCount);
  FCurrentOperator := FOperatorCount;

  if Node.InputToken='-' then
    { numeric complementation unary operator }
     StackPush(stPendingOperators, (Ord(inOperNeg) shl 20) or FCurrentOperator)
  else
     if Node.InputToken<>'+' then
       { boolean complementation unary operator }
       StackPush(stPendingOperators, (Ord(inOperNot) shl 20) or FCurrentOperator);
end;

function HexToInt(s:string):integer;
const digit_val : array[48..134] of shortint = (
       0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  0,  0,  0,  0,  0,  0,
       0, 10, 11, 12, 13, 14, 15,  0,  0,  0,  0,  0,  0,  0,  0,  0,
       0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
       0, 10, 11, 12, 13, 14, 15,  0,  0,  0,  0,  0,  0,  0,  0,  0,
       0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
       0, 10, 11, 12, 13, 14, 15);
var c: integer;
begin
  result := 0;
  for c := 2 to Length(s) do
    result := result shl 4 or digit_val[Ord(s[c])];
end;

procedure TatBasicScript.AfterHex( Node:TNoTerminalNode );
begin
  with AppendInstruction(inPushInteger)^ do
  begin
    vInteger   := HexToInt(Node.InputToken); {HexToInt é mais eficiente que StrToInt}
    vDebugInfo := Parser.ScanningInputPos;
  end;
end;

procedure TatBasicScript.AfterReal( Node:TNoTerminalNode );
var number : double;
    er     : integer;
begin
   {gera instrução de número inteiro se ele não possuir nem parte fracionária nem expoente}
   if Node.Nodes.Count>0 then
   begin
      val(Node.InputToken,number,er);
      with AppendInstruction(inPushDouble)^ do
      begin
         vDouble := number;
         vDebugInfo := Parser.ScanningInputPos;
      end;
   end
   else
      with AppendInstruction(inPushInteger)^ do
      begin
         vInteger   := StrToInt(Node.InputToken);
         vDebugInfo := Parser.ScanningInputPos;
      end;
end;

procedure TatBasicScript.AfterString( Node:TNoTerminalNode );

   function BuildString(const S: string): string;

      procedure AddChar(var Str, ch: string);
      begin
         try
            Str:=Str+chr(StrToInt(ch));
            ch:='';
         except
            Str:=Str+'.';
            ch:='';
         end;
      end;

   Var c: integer;
       IsLiteral: boolean;
       CurChar: string;
   begin
      c:=1;
      result:='';
      IsLiteral:=false;
      CurChar:='';
      while (c<=Length(S)) do
      begin
         if IsLiteral then
         begin
            if (S[c] = Parser.StringDelimitter) then
            begin
               {Check if there are two single quotes together}
               if (c<Length(S)) and (S[c+1] = Parser.StringDelimitter) then
               begin
                  result := result + Parser.StringDelimitter;
                  inc(c);
               end else
                  IsLiteral:=not IsLiteral;
            end else
               result := result + S[c];
         end else
         begin
            {$IFDEF DELPHI2009_LVL}
            if Character.IsDigit(S[c]) then
            {$ELSE}
            if S[c] in ['0'..'9'] then
            {$ENDIF}
               CurChar:=CurChar+S[c]
            else
            if CurChar>'' then
               AddChar(result,CurChar);

            if S[c] = Parser.StringDelimitter then
               IsLiteral:=not IsLiteral;
         end;
         inc(c);
      end;
      if CurChar>'' then
         AddChar(result,CurChar);
   end;

begin
   with AppendInstruction(inPushString)^ do
   begin
      vString    := BuildString(Node.InputToken);
      vDebugInfo := Parser.ScanningInputPos;
   end;
end;

procedure TatBasicScript.AfterVector(Node: TNoTerminalNode);
begin
   { gera uma instrução que transforma o vetor de elementos salvos na pilha em um array de variants }
   with AppendInstruction(inArrayOf)^ do
   begin
      vInteger   := Node.Nodes.Count;
      vDebugInfo := Parser.ScanningInputPos;
   end;
end;

procedure TatBasicScript.BeforeArgList( Node:TNoTerminalNode );
begin
   StackPush( stContext, integer(FPushVarList));
   FPushVarList := TList.Create;
   FPushVarListObjects.Add(FPushVarList);
   if Node.Nodes.Count>0 then
   begin
      { salva na pilha de contexto a situação atual do controle de objetos }
      StackPush( stContext, integer(FCurrentClass) );
      StackPush( stContext, integer(FIsClassReference) );
      { salva o contexto da máscara real de argumentos passados por referência }
      StackPush( stContext, FByRefArgMask );
      FByRefArgMask:=0; // ver MakeDataElementCode
   end;
end;

procedure TatBasicScript.AfterArgList( Node:TNoTerminalNode );
begin
   if Node.Nodes.Count>0 then
   begin
      FLastByRefArgMask:=FByRefArgMask; // for by-reference argument checking in compile time
      FByRefArgMask:=integer(StackPop(stContext));
      { restaura o controle de objetos anterior à chamada da função }
      FIsClassReference:=boolean(StackPop(stContext));
      FCurrentClass:=TatClass(integer(StackPop(stContext)));
   end;
   FLastPushVarList := FPushVarList;
   FPushVarList := TList(integer(StackPop(stContext)));
end;

procedure TatBasicScript.BeforeIndexing( Node:TNoTerminalNode );
begin
   if Node.Nodes.Count>0 then
   begin
      { salva na pilha de contexto a situação atual do controle de objetos }
      StackPush( stContext, integer(FCurrentClass) );
      StackPush( stContext, integer(FIsClassReference) );
      StackPush( stContext, integer(FLastPushVarList) );
   end;
end;

procedure TatBasicScript.AfterIndexing( Node:TNoTerminalNode );
begin
   if Node.Nodes.Count>0 then
   begin
      { restaura o controle de objetos anterior à chamada da função }
      FLastPushVarList := TList(integer(StackPop(stContext)));
      FIsClassReference:=boolean(StackPop(stContext));
      FCurrentClass:=TatClass(integer(StackPop(stContext)));
   end;
end;

procedure TatBasicScript.BeforeCallCode( Node:TNoTerminalNode );
begin
  MakeDataElementCode( Node,doExec );
end;

procedure TatBasicScript.BeforeDataValCode( Node:TNoTerminalNode );
begin
    MakeDataElementCode( Node, doRead );
end;

procedure TatBasicScript.BeforeDataRefCode( Node:TNoTerminalNode );
begin
    MakeDataElementCode( Node, doWrite );
end;

procedure TatBasicScript.BeforeNewCallCode( Node:TNoTerminalNode );
begin
    MakeDataElementCode( Node, doRead );
end;

procedure TatBasicScript.AfterWithObj( Node:TNoTerminalNode );
var variable: TatVariableInfo;
begin
  { exige que a expressão indicada resulte em um objeto de classe conhecida }
  if not Assigned(FCurrentClass) then
    CompileError( 'Object or variable required in "with" clause',Parser.ScanningInputPos )
  else
    if FCurrentClass = TatClass(1) then
      CompileError(
        'Undefined class in "with" clause. '#13#10+
        'Cast the expression to a known class or use a variable that was declared with a defined class',Parser.ScanningInputPos );
  { verifica se deve declarar uma nova variável local para
    armazenar temporariamente a expressão do with }
  Inc(FCurrentWith);
  if FWithCount < FCurrentWith then
  begin
    { aloca uma variável local para armazenar temporariamente a expressão with }
    variable := CurrentRoutine.DeclareVariable('#With'+IntToStr(FCurrentWith), Parser.ScanningInputPos );
    inc(FWithCount);
  end
  else
    { usa uma variável local previamente alocada para armazenar temporariamente a expressão with }
    variable := CurrentRoutine.VariableByName('#With'+IntToStr(FCurrentWith));
  { expressões de with são sempre armazenadas em variáveis temporárias
    com a classe conhecida até o momento
    (para permitir que o MakeDataElementCode possa resolver a
    referência a membros dessa classe automaticamente) }
  variable.DeclaredClass := FCurrentClass;
  { gera escrita em variável interna de nova expressão WITH }
  OptimizeStoreVar(variable);
  { empilha variável do with na pilha de contexto }
  StackPush( stTempVariables, integer(variable) );
end;

procedure TatBasicScript.AfterWith( Node:TNoTerminalNode );
begin
  { remove da pilha de contexto a variável temporária que foi declarada
    para uso dentro do with }
  StackPop( stTempVariables );
end;

function TatBasicScript.SpecialKeyWord(AName: string;operation:TDataOperation ):boolean;
begin
   case operation of
      doRead:
         if AName='NULL' then
         begin
            with AppendInstruction(inPushConst)^ do
            begin
               vByte      := ord(coNull);
               vString    := AName;
               vDebugInfo := Parser.ScanningInputPos;
            end;
            result:=true;
         end
         else
         if AName='FALSE' then
         begin
            with AppendInstruction(inPushConst)^ do
            begin
               vByte      := ord(coFalse);
               vString    := AName;
               vDebugInfo := Parser.ScanningInputPos;
            end;
            result:=true;
         end
         else
         if AName='TRUE' then
         begin
            with AppendInstruction(inPushConst)^ do
            begin
               vByte      := ord(coTrue);
               vString    := AName;
               vDebugInfo := Parser.ScanningInputPos;
            end;
            result:=true;
         end
         else
         if AName='EMPTY' then
         begin
            with AppendInstruction(inPushConst)^ do
            begin
               vByte      := ord(coUnassigned);
               vString    := AName;
               vDebugInfo := Parser.ScanningInputPos;
            end;
            result:=true;
         end
         else
         if AName='NOTHING' then
         begin
            with AppendInstruction(inPushConst)^ do
            begin
               vByte      := ord(coNil);
               vString    := AName;
               vDebugInfo := Parser.ScanningInputPos;
            end;
            result:=true;
         end
         else
            result:=false
      else
         result:=false;
   end;
end;

procedure TatBasicScript.AfterExitRoutine( Node:TNoTerminalNode );
begin
   if CurrentRoutine.IsFunction xor (Node.NoTerminalIndex=ord(bnExit_Function)) then
      { produz erro se EXIT SUB em Function ou EXIT FUNCTION em Sub }
      CompileError('Invalid EXIT',Parser.ScanningInputPos)
   else
      { insere um desvio para a finalização da subrotina corrente (sub ou function) }
      with AppendInstruction(inJump)^ do
      begin
         vInteger   := RegisterReference('@EndSub'+inttostr(CurrentRoutine.Index));
         vString    := 'EXIT';
         vDebugInfo := Parser.ScanningInputPos;
      end;
end;

procedure TatBasicScript.AfterExitLoop( Node:TNoTerminalNode );
begin
   case FCurrentLoop of
      lsFor:
         if Node.NoTerminalIndex=ord(bnExit_for) then
            with AppendInstruction(inJump)^ do
            begin
               vInteger   := RegisterReference('@EndFor'+inttostr(FCurrentFor));
               vDebugInfo := Parser.ScanningInputPos;
            end
         else
            CompileError('Invalid EXIT',Parser.ScanningInputPos);
      lsWhile:
         if Node.NoTerminalIndex=ord(bnExit_do) then
            with AppendInstruction(inJump)^ do
            begin
               vInteger   := RegisterReference('@EndWhile'+inttostr(FCurrentWhile));
               vDebugInfo := Parser.ScanningInputPos;
            end
         else
            CompileError('Invalid EXIT',Parser.ScanningInputPos);
      lsRepeat:
         if Node.NoTerminalIndex=ord(bnExit_do) then
            with AppendInstruction(inJump)^ do
            begin
               vInteger   := RegisterReference('@EndRepeat'+inttostr(FCurrentRepeat));
               vDebugInfo := Parser.ScanningInputPos;
            end
         else
            CompileError('Invalid EXIT',Parser.ScanningInputPos);
   else
      CompileError('Invalid EXIT',Parser.ScanningInputPos);
   end;
end;

procedure TatBasicScript.MakeDataElementCode( Node:TNoTerminalNode; operation:TDataOperation );
type
  TElementType = (etUnknown, etVariable, etProperty, etMethod, etRoutine, etFunction, etClass, etKeyword, etTypeCast);
var
  hasUpnode, hasSubnode, hasArglist, varIsByRef, hasDefaultProperty: boolean;
  ElementType: TElementType;
  ElementName: string;
  index, argCount, idxCount, def_property_index: integer;
  variable: TatVariableInfo;
  subroutine: TatRoutineInfo;
  method_obj: TatMethod;
  property_obj, def_property_obj: TatProperty;
  newinst, def_property_last_instruction: pSimplifiedCode;
  isNewClause: boolean;

   function KnownProperty:boolean;
   var st : pStackElement;
   begin
      { se o elemento não tiver argumentos então será um candidato à propriedade }
      if not hasArgList and not isNewClause then
         if not Assigned(FCurrentClass) then
            if not hasUpnode then
            begin
               { pesquisa a propriedade na pilha de contexto de cláusulas "with"
                 a pesquisa é feita do último objeto usado até o primeiro }
               st := GetStack(stTempVariables);
               while Assigned(st) do
               begin
                 variable := TatVariableInfo(integer(st^.Element));
                 if variable.DeclaredClass = TatClass(1) then
                   CompileError( '"With" clause is not supporting variables yet',Parser.ScanningInputPos );
                 { verifica se a propriedade é membro do objeto usado no with }
                 property_obj := variable.DeclaredClass.Properties.PropertyByName(ElementName);
                 result := Assigned(property_obj);
                 if result then
                 begin
                   { a propriedade pertence a um objeto do with
                     então gera instrução de carga do objeto a partir da
                     variável temporária da expressão usada no with }
                    with AppendInstruction(inWithObject)^ do
                    begin
                       vInteger   := variable.VarIndex;
                       vString    := variable.VarName;
                       vDebugInfo := Parser.ScanningInputPos;
                    end;
                    FCurrentClass := variable.DeclaredClass;
                    index := -1;
                    Exit;
                 end;
                 st := st^.Previous;
               end;
               { if it's not in the with clause, then look for the property in the list of default instances.
                 First the script default instances, then scripter default instances }
               index := DefInstances.FindInstanceByPropertyName(ElementName, property_obj);
               result := (index>-1);
               if result then
               begin
                 {Make index negative so that scripter knows its from Script.DefInstance (not Scripter.DefaultInstances)
                  We must add 2 in order to avoid 0 and -1 values, which are reserved}
                 index := -(index + 2);
               end else
               begin
                 index := Scripter.DefaultInstances.FindInstanceByPropertyName(ElementName,property_obj);
                 result := (index>-1);
               end;
            end
            else
               { acesso ilegal à propriedade }
               result := False
         else
            if integer(FCurrentClass)=1 then // undefined variable instance
            begin
               { a pesquisa da propriedade ou método sem argumentos deverá ocorrer em runtime }
               property_obj := nil;
               index := -1;
               result := True;
            end
            else
            begin
               if FIsClassReference then
                  { tenta encontrar a propriedade de classe na classe corrente }
                  property_obj := FCurrentClass.Properties.ClassPropertyByName(ElementName)
               else
                  { tenta encontrar a propriedade na classe corrente }
                  property_obj := FCurrentClass.Properties.PropertyByName(ElementName);
               index := -1;
               result := Assigned(property_obj);
            end
      else
         result:=false;
   end;

   function KnownClass:boolean;
   begin
      { se o elemento não tiver argumentos, possuir um outro elemento sufixado
        e não possuir um elemento prefixado, então será um candidato à uma classe.
        se for um nó atômico e estiver em modo de leitura, pode ser uma
        referência de classe }
      if not isNewClause and not hasUpNode and not hasArgList and (hasSubNode or (operation=doRead)) then
      begin
         { pesquisa a classe na coleção de classes conhecidas }
         index := Scripter.Classes.IndexOf(ElementName);
         result := (index > -1);
      end
      else
         { não é uma referência a membro de classe }
         result := False;
   end;

   function KnownMethod:boolean;
   var
     st : pStackElement;
     NewClauseClass: TatClass;
   begin
     if not Assigned(FCurrentClass) then
     begin
       if not hasUpnode then
       begin
         if not isNewClause then
         begin
           { Check if the method belongs to a object in a with statement, if any }
           st := GetStack(stTempVariables);
           while Assigned(st) do
           begin
             variable := TatVariableInfo(integer(st^.Element));

             { check if the method is member of the object declared in the with clause }
             method_obj := variable.DeclaredClass.Methods.MethodByName(ElementName);
             result := Assigned(method_obj);
             if result then
             begin
               { Generate an instruction to load the with object}
               with AppendInstruction(inWithObject)^ do
               begin
                 vInteger   := variable.VarIndex;
                 vString    := variable.VarName;
                 vDebugInfo := Parser.ScanningInputPos;
               end;
               FCurrentClass := variable.DeclaredClass;
               index := -1;
               Exit;
             end;
             st := st^.Previous;
           end;

           { if it's not in the with clause, then look for the property in the list of default instances.
             First the script default instances, then scripter default instances }
           index := DefInstances.FindInstanceByMethodName(ElementName, method_obj);
           result := (index>-1);
           if result then
           begin
             {Make index negative so that scripter knows its from Script.DefInstance (not Scripter.DefaultInstances)
              We must add 2 in order to avoid 0 and -1 values, which are reserved}
             index := -(index + 2);
           end
           else
           begin
             index := Scripter.DefaultInstances.FindInstanceByMethodName(ElementName,method_obj);
             result := (index > -1);
           end;
         end
         else
         begin
           {it's a new clause - format "new ClassName(Param1, Param2)". We must check if the class exist and if
            a Create class method exist in that class}
           result := false;
           NewClauseClass := Scripter.Classes.ClassByName(ElementName);
           if NewClauseClass <> nil then
           begin
             FIsClassReference := true;
             method_obj := NewClauseClass.Methods.ClassMethodByName('Create');
             index := -1;
             result := Assigned(method_obj);
             if result then
               ElementName := method_obj.Name;
           end;
         end;
       end
       else
         { acesso ilegal ao método }
         result:=false;
     end
     else
       if integer(FCurrentClass) = 1 then // undefined variable instance
       begin
         { a pesquisa do método deverá ocorrer em runtime }
         method_obj := nil;
         index := -1;
         result := true;
       end
       else
       begin
         if FIsClassReference then
           { tenta encontrar o método de classe na classe corrente }
           method_obj := FCurrentClass.Methods.ClassMethodByName(ElementName)
         else
           { tenta encontrar o método na classe corrente }
           method_obj:=FCurrentClass.Methods.MethodByName(ElementName);
         index := -1;
         result := Assigned(method_obj);
       end;
   end;

   function KnownVariable:boolean;
   begin
      { se não tiver argumentos e não possuir nós superiores então o elemento
        será um candidato à variável }
      if not isNewClause and not hasArgList and not hasUpnode then
      begin
         { verifica se o identificador é uma variável local ou global,
           retornando a estrutura correspondente em "variable" }
         if CurrentRoutine <> nil then
           variable := CurrentRoutine.VariableByName(ElementName);
         if not Assigned(variable) then
           variable := ScriptInfo.Globals.FindByName(ElementName);
         result := Assigned(variable);
      end
      else
         result:=false;
   end;

   function KnownDefaultProperty: boolean;
   var
     atClass: TatClass;
   begin
     // check default indexed properties
     if idxCount > 0 then
     begin
       atClass := nil;
       if Assigned(variable) then
         atClass := variable.DeclaredClass
       else if Assigned(property_obj) then
       begin
         if (property_obj.DataType = tkClass) and (property_obj.PropertyClass <> nil) then
           atClass := Scripter.ClassByName(property_obj.PropertyClass.ClassName);
       end
       else if Assigned(method_obj) then
       begin
         if (method_obj.ResultDataType = tkClass) and (method_obj.ResultClass <> nil) then
           atClass := Scripter.ClassByName(method_obj.ResultClass.ClassName);
       end;
       result := (atClass <> nil) and (atClass.DefaultProperty <> nil);
       if result then
       begin
         def_property_obj := atClass.DefaultProperty;
         def_property_last_instruction := RemoveLastInstruction;
         def_property_index := -1;
       end;
     end
     else
       result := False;
   end;
   
   function KnownTypeCast:boolean;
   begin
      { se o identificador não possuir um nó superior, tiver um único argumento e seu nome corresponder
        a um nome de classe conhecido então assume que é apenas uma coerção de classe }
      if not isNewClause and not hasUpNode and hasArgList and (argCount=1) then
      begin
         index := Scripter.Classes.IndexOf(ElementName);
         result := (index>-1);
      end
      else
         result := False;
   end;

   function KnownRoutine:boolean;
   begin
      { se o identificador não possuir um nó superior então
        assume que a rotina já é conhecida porque ela poderá ser definida
        posteriormente. Se não for definida até o final da compilação um
        erro será gerado }
      { no entanto se o identificador não possui arglist e está sofrendo
        atribuição então não considera-o como uma rotina, para deixá-lo ser
        uma variável }
      if not isNewClause and not( hasUpNode or (not hasArgList and (operation=doWrite) and not hasSubnode)) then
      begin
         subroutine := ScriptInfo.RoutineByName(ElementName);
         result := Assigned(subroutine);
      end
      else
         result := False;
   end;

   function KnownKeyWord:boolean;
   begin
      { testa se o elemento é uma palavra-chave da linguagem:
        NULL, TRUE, FALSE, NOTHING, EMPTY }
      result := not isNewClause and
                not hasArgList and
                not hasSubNode and
                not (operation=doWrite) and
                SpecialKeyWord(UpperCase(ElementName),operation);
   end;

   function CheckUnknownElement: boolean;
   var
     Context: TElementContext;
   begin
     Context.HasArgList := hasArgList;
     Context.HasUpnode := hasUpnode;
     Context.HasSubNode := hasSubNode;
     Context.Operation := Operation;
     Context.ArgCount := argCount;
     Context.IdxCount := idxCount;
     Context.RepeatChecking := false;
     Context.ElementName := ElementName;
     Context.IsNewClause := isNewClause;
     Context.CurrentClass := FCurrentClass;
     DoUnknownElement(Context);
     result := Context.RepeatChecking;
   end;

   procedure UpdateByRefPushVars;
   var
     c: integer;
     isbyref: boolean;
   begin
     {This routine iterates through the variables pushed by reference in the stack for a call to a routine or a method.
      For each variable, it checks if the variable is indeed declared as byref in the routine/method. If not, then
      we must change the opcode to push the variable as value, not as reference}
     for c := 0 to FLastPushVarList.Count - 1 do
     begin
       with pSimplifiedCode(FLastPushVarList[c])^ do
       begin
         isbyref := true;
         if (method_obj <> nil) then
           isbyref := method_obj.IsByRefArg(vInteger2)
         else
         if (subroutine <> nil) then
           {Instead of directly using Variables[vInteger2], we should check vInteger2 with ArgIndex
            (something like Variables.FindBYArgIndex(vinteger2). But this will work so far because until now,
            all variables passed as arguments are being added before the local variables. Check TatVariableInfo.VarIndex
            to see that other parts of code rely on that too}
           isbyref := (subroutine.Variables[vInteger2].Modifier = moVar)
         else
           CompileError(Format('Cannot retrieve routine/method information for argument ''%s'' ',[vString]), Parser.ScanningInputPos);

         {if the argument is not byref, then we must change the opcode of instruction. all other information are the same (vinteger, etc.)}
         if not isbyref then
         begin
           Case OpCode of
             inPushVarByRef: OpCode := inPushVar;
             inPushGlobalVarByRef: OpCode := inPushGlobalVar;
           end;
         end;

         {Clear the vInteger2 value, which was only used temporariliy}
         vInteger2 := 0; 
       end;
     end; 
   end;

  procedure GeneratePropertyCode(AProperty: TatProperty; AElementName: string; AIdxCount: integer; AHasSubnode: boolean; AIndex: integer);
  begin
     { decide se deve gerar instrução para escrita em propriedade de objeto }
     if not AHasSubnode and (operation = doWrite) then
     begin
        if Assigned(AProperty) then
           if Assigned(AProperty.Setter) then
              if AProperty.IndexCount = AIdxCount then
                 if FIsClassReference then
                 begin
                    { setter de propriedade de classe }
                    newinst := AppendInstruction(inCallClassProc);
                    with newinst^ do
                    begin
                       vInteger   := integer(AProperty.atClass.Index);
                       vByte      := 1;
                       RelativeSetterRef(AProperty, newinst); // AProperty.Setter
                       vString    := AElementName;
                       vInteger1  := AIdxCount;
                       vDebugInfo := Parser.ScanningInputPos;
                    end;
                 end
                 else
                 begin
                    newinst := AppendInstruction(inCallProc);
                    with newinst^ do
                    begin
                       vInteger   := AIndex;
                       vByte      := 255; // setter flag
                       RelativeSetterRef(AProperty, newinst); // AProperty.Setter
                       vString    := AElementName;
                       vInteger1  := AIdxCount;
                       vDebugInfo := Parser.ScanningInputPos;
                    end;
                 end
              else
                 CompileError(Format('Invalid array indexing for property ''%s''. Expected %d dimensions',[AElementName,AProperty.IndexCount]),Parser.ScanningInputPos)
           else
              CompileError(Format('Property ''%s'' cannot be written',[AElementName]),Parser.ScanningInputPos)
        else
        begin
           newinst := AppendInstruction(inCallProc);
           with newinst^ do
           begin
              vInteger   := AIndex;
              vByte      := 255; // setter flag
              RelativeSetterRef(nil, newinst); // UndefinedSetterProc
              vString    := AElementName;
              vInteger1  := AIdxCount;
              vDebugInfo := Parser.ScanningInputPos;
           end;
        end
     end
     else
        { decide se deve gerar instrução para leitura de propriedade de objeto }
        if (operation = doRead) or AHasSubNode or (integer(FCurrentClass)=1) then
           if Assigned(AProperty) then
           begin
              if Assigned(AProperty.Getter) then
                 if AProperty.IndexCount = AIdxCount then
                    if FIsClassReference then
                    begin
                       newinst := AppendInstruction(inCallClassProc);
                       with newinst^ do
                       begin
                          vInteger   := integer(AProperty.atClass.Index);
                          vByte      := 0;
                          RelativeGetterRef(AProperty, newinst); // AProperty.Getter
                          vString    := AElementName;
                          vInteger1  := AIdxCount;
                          vDebugInfo := Parser.ScanningInputPos;
                       end;
                    end
                    else
                    begin
                       newinst := AppendInstruction(inCallProc);
                       with newinst^ do
                       begin
                          vInteger   := AIndex;
                          vByte      := 0;
                          RelativeGetterRef(AProperty, newinst); // AProperty.Getter
                          vString    := AElementName;
                          vInteger1  := AIdxCount;
                          vDebugInfo := Parser.ScanningInputPos;
                       end;
                    end
                 else
                    CompileError(Format('Invalid array indexing for property ''%s''. Expected %d dimensions',[AElementName,AProperty.IndexCount]),Parser.ScanningInputPos)
              else
                 CompileError(Format('Property ''%s'' cannot be readed',[AElementName]),Parser.ScanningInputPos);
              { atualiza a informação de instância e classe corrente }
              if AProperty.UpdateObjectInfo(FCurrentClass) then
              begin
                { register the implicit class referencing }
                TatProperties(AProperty.Collection).atClass.ImplicitElement := AProperty;
              end;
           end
           else
              { se a operação for de execução então sinaliza em vByte esta situação }
              if not AHasSubNode and (operation = doExec) then
              begin
                 newinst := AppendInstruction(inCallProc);
                 with newinst^ do
                 begin
                    vInteger   := AIndex;
                    vByte      := 0;
                    vSmallInt  := 1; // indica que é uma chamada Call e não um getter ou setter
                    RelativeGetterRef(nil, newinst); // UndefinedGetterProc
                    vString    := AElementName;
                    vDebugInfo := Parser.ScanningInputPos;
                 end;
              end
              else
              begin
                 newinst := AppendInstruction(inCallProc);
                 with newinst^ do
                 begin
                    vInteger   := AIndex;
                    vByte      := 0;
                    RelativeGetterRef(nil, newinst); // UndefinedGetterProc
                    vString    := AElementName;
                    vInteger1  := AIdxCount;
                    vDebugInfo := Parser.ScanningInputPos;
                 end;
              end
        else
           CompileError(Format('Property ''%s'' cannot be called as a method',[AElementName]),Parser.ScanningInputPos);
     { decide se deve gerar instrução para carga de argumento de saída }
     if AHasSubnode or (operation = doRead) then
        with AppendInstruction(inPushOutput)^ do
        begin
           vDebugInfo := Parser.ScanningInputPos;
        end;
     { se já referenciou a propriedade de classe, desliga nova referência de classe }
     FIsClassReference:=false;
  end;


var
  RepeatChecking: boolean;
  Pass: integer;
begin
   // !!! O estado corrente da análise é dado pelas seguintes variáveis !!!
   // ElementName   : String com o nome do elemento de dados (propriedade,método,variável,etc)
   // ElementType   : indica o tipo do elemento corrente (etUnknown, etVariable, etProperty, etMethod, etRoutine, etFunction)
   // hasUpNode     : Indica que há um elemento de prefixando o elemento corrente
   // hasSubNode    : Indica que há pelo menos um outro elemento sufixando o elemento corrente
   // hasArgList    : Indica que há uma lista de argumentos no elemento corrente
   // isNewClause   : Indicates that the element is a new (instante) element in format new ClassName([param1, param2])
   // argCount      : Indica o número de argumentos referentes ao elemento corrente
   // operation     : (doRead,doWrite,doExec) informa se o elemento está participando de uma leitura, escrita ou chamada respectivamente
   // method_obj    : definições do método encontrado
   // property_obj  : definições da propriedade encontrada
   // index         : índice auxiliar para representar uma instância padrão, variável, função local, etc
   // FCurrentClass : Indica a classe do atBasic que foi indentificada (nil: indica que não não está em uma classe; 1: indica que a classe está indefinida }

   index := -1;
   { get the member name (prepared by AfterId) }
   ElementName := StackPop(stIdentifierList);
   { pull some state variables for this node }
   with Node do
   begin
      argCount   := OwnerNodes[1].Nodes.Count;
      idxCount   := OwnerNodes[2].Nodes.Count;
      hasArgList := (argcount > 0) or (Length(OwnerNodes[1].InputToken) > 0);
      hasUpnode  := ParentNode.ParentNode.NoTerminalIndex = ParentNode.NoTerminalIndex;
      hasSubnode := OwnerNodes.Count>Index+1;
      isNewClause := ParentNode.NoTerminalIndex = Ord(bnNew_call);
   end;
   { reset current object control }
   if not hasUpNode then
   begin
      FCurrentClass := nil;
      FIsClassReference := False;
   end;

   ElementType := etUnknown;
   RepeatChecking := false;
   Pass := 0;
   hasDefaultProperty := false;
   variable := nil;
   property_obj := nil;
   method_obj := nil;   
   
   repeat
     inc(pass);
     { element knowledgement - decision order is important }
     if KnownVariable then
     begin
       ElementType := etVariable;
       if KnownDefaultProperty then
         hasDefaultProperty := True;
     end
     else
        if KnownRoutine then
           ElementType := etRoutine
        else
           if KnownProperty then
           begin
              ElementType := etProperty;
              if KnownDefaultProperty then
                hasDefaultProperty := True;
           end
           else
              if KnownMethod then
              begin
                 ElementType := etMethod;
                 if KnownDefaultProperty then
                   hasDefaultProperty := True;
              end
              else
                 if KnownClass then
                    ElementType := etClass
                 else
                    if KnownTypeCast then
                       ElementType := etTypeCast
                    else
                       if KnownKeyword then
                         ElementType := etKeyword
                       else
                         {check unknown element, but only if it's the first iteration pass}
                         if (Pass = 1) and CheckUnknownElement then
                           RepeatChecking := true
                         else
                            { segunda chance de reconhecer uma variável:
                              se permite auto-declaração de variáveis e a sintaxe
                              denota uma escrita em variável local então declara
                              a variável neste momento }
                            if not Scripter.OptionExplicit and (operation=doWrite) and
                               not hasArgList and not hasUpnode and not hasSubNode  then
                            begin
                              { declaração automática de variável na sua primeira atribuição }
                              ElementType := etVariable;
                              variable := CurrentRoutine.DeclareVariable(ElementName, Node.InputInitialPos);
                            end
                            else
                            begin
                               ElementType := etUnknown;
                               { UNKNOW IDENTIFIER - ERROR GENERATION }
                               if hasUpnode then
                                  { decide se deve gerar erro de método ou membro desconhecido }
                                  if hasArglist  then
                                     if Assigned(FCurrentClass) then
                                        CompileError( Format('Unknown member method: ''%s''',[ElementName]),Parser.ScanningInputPos )
                                     else
                                        CompileError( Format('Object required to access member method: ''%s''',[ElementName]),Parser.ScanningInputPos )
                                  else
                                     if Assigned(FCurrentClass) then
                                        CompileError( Format('Unknown member identifier: ''%s''',[ElementName]),Parser.ScanningInputPos )
                                     else
                                        CompileError( Format('Object required to access member: ''%s''',[ElementName]),Parser.ScanningInputPos )
                               else
                                  { decide se deve gerar erro de variável não inicializada ou
                                    identificador, método ou subrotina desconhecidos }
                                  if isNewClause then
                                    CompileError( Format('Unknown class or create method not found in class: ''%s''', [ElementName]), Parser.ScanningInputPos )
                                  else
                                  if hasArglist then
                                    CompileError( Format('Unknown method or routine: ''%s''',[ElementName]),Parser.ScanningInputPos )
                                  else
                                    CompileError( Format('Unknown identifier or variable is not declared: ''%s''',[ElementName]),Parser.ScanningInputPos );
                            end;
   until not RepeatChecking or (Pass > 1);

   { C O D E   G E N E R A T I O N }
   case ElementType of

      etVariable: { V A R I Á V E L }
      begin
         { decide se deve gerar instrução de carga de variável local na pilha }
         if hasSubnode or (operation=doRead) then
         begin
            { Sintaticamente, testa se o DataVal é o único nó de uma expressão
              e se esta expressão foi encontrada em um Arg_List }
            varIsByRef := (operation=doRead) and not hasSubNode and (idxCount = 0) and
                          (Node.ParentNode.OwnerNodes.Count = 1) and
                          (Node.ParentNode.ParentNode.ParentNode.NoTerminalIndex = ord(bnArg_List));
            { se a variável estiver sendo usada como um argumento de chamada de função
              então passa esta variável por referência ao invés de passá-la por valor }
            if varIsByRef then
            begin
               FPushVarList.Add(AppendInstruction(inPushVarByRef));
               with pSimplifiedCode(FPushVarList.Last)^ do
               begin
                  if variable.Global then OpCode := inPushGlobalVarByRef;
                  vInteger   := variable.VarIndex;
                  vString    := ElementName;
                  vDebugInfo := Parser.ScanningInputPos;

                  {indicates the index of variable in the variable list. This is temporary and only used when
                   MakeDataElementCode reaches the routine or call, so we can check by this vInteger2 if the variable
                   should be indeed be passed as reference}
                  vInteger2 := Node.ParentNode.ParentNode.Index;
               end;

               { atualiza a máscara de argumentos reais passados por referência }
               FByRefArgMask := FByRefArgMask or (1 shl Node.ParentNode.ParentNode.Index);
            end
            else
               if (idxCount > 0) and not hasDefaultProperty then
                  with AppendInstruction(inPushIdxVar)^ do
                  begin
                     if variable.Global then OpCode := inPushGlobalIdxVar;
                     vInteger   := variable.VarIndex;
                     vByte      := idxCount;
                     vString    := ElementName;
                     vDebugInfo := Parser.ScanningInputPos;
                  end
               else
                  with AppendInstruction(inPushVar)^ do
                  begin
                     if variable.Global then OpCode := inPushGlobalVar;
                     vInteger   := variable.VarIndex;
                     vString    := ElementName;
                     vDebugInfo := Parser.ScanningInputPos;
                  end;
            { se a variável foi declarada como um objeto então reconhece a
              classe declarada, senão deixa a classe como indefinida para que
              uma possível referência da variável como objeto possa ser
              solucionada somente em tempo de execução }
            if Scripter.DeferObjectResolution or not Assigned(variable.DeclaredClass) then
              { assume que a variável não tem tipo definido, de modo que seu uso
                como objeto possa ser postergado para tempo de execução }
              FCurrentClass := TatClass(1)  { undefined variable instance }
            else
              FCurrentClass := variable.DeclaredClass;
         end
         else
            if (operation=doExec) and (not hasSubnode) then
               CompileError(Format('Variable ''%s'' cannot be called as a function or routine',[ElementName]),Parser.ScanningInputPos);
         { decide se deve gerar instrução para escrita em variável local }
         if not hasSubnode and (operation=doWrite) then
         begin
            if idxCount > 0 then
            begin
               if hasDefaultProperty then
                 with AppendInstruction(inPushVar)^ do
                 begin
                   if variable.Global then OpCode := inPushGlobalVar;
                   vInteger := variable.VarIndex;
                   vString := ElementName;
                   vDebugInfo := Parser.ScanningInputPos;
                 end
               else
                 with AppendInstruction(inStoreIdxVar)^ do
                 begin
                    if variable.Global then OpCode := inStoreGlobalIdxVar;
                    vInteger   := variable.VarIndex;
                    vByte      := idxCount;
                    vString    := ElementName;
                    vDebugInfo := Parser.ScanningInputPos;
                 end
            end
            else
               OptimizeStoreVar(variable);
         end;
      end;

      etRoutine: { S U B R O T I N A }
      begin
         { decide se deve gerar instrução de desvio à subrotina local }

         { gera a instrução de chamada à subrotina local }
         if (operation=doWrite) and not hasSubnode then
            CompileError(Format('Assign to routine ''%s'' is not allowed',[ElementName]),Parser.ScanningInputPos)
         else
            { testa se o número de argumentos esperados foi satisfeito }
            if subroutine.ArgCount=argcount then
               { testa se os parâmetros esperados por referência foram
                 realmente passados através de referências a variáveis locais }
               if (argcount=0) or (subroutine.ByRefArgMask=FLastByRefArgMask and subroutine.ByRefArgMask) then
               begin
                  UpdateByRefPushVars;
                  with AppendInstruction(inCall)^ do
                  begin
                     vInteger   := RegisterReference(ElementName);
                     vByte      := argcount;
                     vProc      := nil;
                     vString    := ElementName;
                     vDebugInfo := Parser.ScanningInputPos;
                  end;
               end
               else
               begin
                  { indica com erro o primeiro argumento esperado por
                    referência que não foi satisfeito }
                  index:=0;
                  FByRefArgMask:=subroutine.ByRefArgMask xor (FLastByRefArgMask and subroutine.ByRefArgMask);
                  while FByRefArgMask and 1=0 do
                  begin
                     FByRefArgMask:=FByRefArgMask shr 1;
                     inc(index);
                  end;
                  CompileError(Format('Subroutine ''%s'' expects variable reference',[ElementName]),Node.OwnerNodes[1].Nodes[index].InputInitialPos-1);
               end
            else
               if argcount<subroutine.ArgCount then
                  CompileError(Format('Not enough actual parameters for subroutine ''%s''. Expected %d parameters',[ElementName,subroutine.ArgCount]),Parser.ScanningInputPos)
               else
                  CompileError(Format('Too many parameters for subroutine ''%s''. Expected %d parameters',[ElementName,subroutine.ArgCount]),Parser.ScanningInputPos);
         if (idxCount>0) then
            CompileError('Call indexation as an array is not supported',Parser.ScanningInputPos);
         { decide se deve gerar instrução para carga de argumento de saída }
         if (hasSubnode or (operation=doRead)) then
            with AppendInstruction(inPushOutput)^ do
            begin
               vDebugInfo := Parser.ScanningInputPos;
            end;
      end;

      etMethod: { M E T H O D }
      begin
         { decide se deve gerar instrução de desvio à método de objeto }
         if Assigned(method_obj) then
            if (method_obj.ResultDataType=tkNone) and (hasSubNode or (operation=doRead)) then
               CompileError(Format('Method ''%s'' not result any value',[ElementName]),Parser.ScanningInputPos)
            else
               if (method_obj.ResultDataType<>tkClass) and hasSubnode then
                  CompileError(Format('Method ''%s'' not result an object',[ElementName]),Parser.ScanningInputPos)
               else
                  if Assigned(method_obj.Proc) then
                     if (operation=doWrite) and not (hasSubnode or hasDefaultProperty) then
                        CompileError(Format('Assign to method ''%s'' is not allowed',[ElementName]),Parser.ScanningInputPos)
                     else
                        if (argcount >= method_obj.ArgCount - method_obj.DefArgCount) and
                           (argcount <= method_obj.ArgCount) then
                        begin
                           { testa se os parâmetros esperados por referência foram
                             realmente passados através de referências a variáveis locais }
                           if (argcount=0) or (method_obj.ByRefArgMask=FLastByRefArgMask and method_obj.ByRefArgMask) then
                           begin
                              UpdateByRefPushVars;
                              if FIsClassReference then
                              begin
                                 { gera instrução de chamada ao método de classe }
                                 newinst := AppendInstruction(inCallClassProc);
                                 with newinst^ do
                                 begin
                                    vInteger   := integer(method_obj.atClass.Index);
                                    vByte      := argcount;
                                    vSmallInt  := 1; // indica que é uma chamada Call e não um getter ou setter
                                    RelativeMethodRef(method_obj, newinst); // method_obj.Proc
                                    vString    := ElementName;
                                    vDebugInfo := Parser.ScanningInputPos;
                                 end;
                              end
                              else
                              begin
                                 { gera instrução de chamada ao método }
                                 newinst := AppendInstruction(inCallProc);
                                 with newinst^ do
                                 begin
                                    vInteger   := index; // default instance index
                                    vByte      := argcount;
                                    vSmallInt  := 1; // indica que é uma chamada Call e não um getter ou setter
                                    RelativeMethodRef(method_obj, newinst); // method_obj.Proc
                                    vString    := ElementName;
                                    vDebugInfo := Parser.ScanningInputPos;
                                 end;
                              end;
                           end
                           else
                           begin
                              { indica com erro o primeiro argumento esperado por
                                referência que não foi satisfeito }
                              index:=0;
                              FByRefArgMask:=method_obj.ByRefArgMask xor (FLastByRefArgMask and method_obj.ByRefArgMask);
                              while FByRefArgMask and 1=0 do
                              begin
                                 FByRefArgMask:=FByRefArgMask shr 1;
                                 inc(index);
                              end;
                              CompileError(Format('Method ''%s'' expects variable reference',[ElementName]),Node.OwnerNodes[1].Nodes[index].InputInitialPos-1);
                           end;
                           { atualiza a informação de instância e classe corrente }
                           if method_obj.UpdateObjectInfo(FCurrentClass) then
                           begin
                             { register the implicit class referencing }
                             TatMethods(method_obj.Collection).atClass.ImplicitElement := method_obj;
                           end;
                        end
                        else
                           begin
                             if argcount < method_obj.ArgCount - method_obj.DefArgCount then
                             begin
                                if method_obj.DefArgCount = 0 then
                                  CompileError(Format('Not enough actual parameters for method ''%s''. Expected %d parameters', [ElementName,method_obj.ArgCount]),Parser.ScanningInputPos)
                                else
                                  CompileError(Format('Not enough actual parameters for method ''%s''. Expected %d to %d parameters', [ElementName,method_obj.ArgCount - method_obj.DefArgCount, method_obj.ArgCount]),Parser.ScanningInputPos)
                             end
                             else if argcount>method_obj.ArgCount then
                                CompileError(Format('Too many parameters for method ''%s''. Expected %d parameters',[ElementName,method_obj.ArgCount]),Parser.ScanningInputPos)
                           end
                  else
                     CompileError(Format('Method ''%s'' was not defined',[ElementName]),Parser.ScanningInputPos)
         else
            if (operation=doWrite) and not hasSubnode then
               CompileError(Format('Assign to method ''%s'' is not allowed',[ElementName]),Parser.ScanningInputPos)
            else
            begin
               newinst := AppendInstruction(inCallProc);
               with newinst^ do
               begin
                  vInteger   := index;
                  vByte      := argcount;
                  vSmallInt  := 1; // indica que é uma chamada Call e não um getter ou setter
                  RelativeMethodRef(nil, newinst); // UndefinedMethodProc
                  vString    := ElementName;
                  vDebugInfo := Parser.ScanningInputPos;
               end;
            end;
         if (idxCount > 0) and not hasDefaultProperty then
            CompileError('Method indexation as an array is not supported',Parser.ScanningInputPos);
         { decide se deve gerar instrução para carga de argumento de saída }
         if (hasSubnode or (operation=doRead) or hasDefaultProperty) then
            with AppendInstruction(inPushOutput)^ do
            begin
               vDebugInfo := Parser.ScanningInputPos;
            end;
         { se já referenciou o método de classe, desliga nova referência de classe }
         FIsClassReference := false;
      end;

      etProperty: { P R O P E R T Y }
        if hasDefaultProperty then
          GeneratePropertyCode(property_obj, ElementName, 0, True, index)
        else
          GeneratePropertyCode(property_obj, ElementName, idxCount, hasSubnode, index);

      etClass: { C L A S S   R E F E R E N C E }
      begin
         { se está usando a referência de classe apenas indica a refernência
           para o próximo que MakeDataElementCode possa pesquisar corretamente
           um método ou propriedade de classe }
         if hasSubNode then
         begin
            FCurrentClass := Scripter.Classes[index];
            FIsClassReference := True;
         end
         else
            { se está lendo a referência de classe então empilha esta referência }
            if (operation=doRead) then
               with AppendInstruction(inPushClass)^ do
               begin
                  vInteger   := index;
                  vString    := ElementName;
                  vDebugInfo := Parser.ScanningInputPos;
               end
            else
               CompileError(Format('Invalid use of class reference ''%s''',[ElementName]),Parser.ScanningInputPos);
      end;

      etTypeCast: { T Y P E   C A S T }
      begin
         { somente ajusta a classe corrente, para que o próximo
           MakeDataElementCode possa pesquisar corretamente um membro interno do objeto
           Nenhum processamento adicional é necessário neste nó }
         FCurrentClass := Scripter.Classes[index];
      end;
   end;

  FPushVarListObjects.Remove(FLastPushVarList);
  FLastPushVarList := nil;

  if hasDefaultProperty then
  begin
    AppendInstruction(def_property_last_instruction);
    GeneratePropertyCode(def_property_obj, def_property_obj.Name, idxCount, hasSubnode, def_property_index);
  end;
end;

procedure TatBasicScript.BeforeTry( Node:TNoTerminalNode );
begin
   { gera a instrução try..finally ou try..except }
   if (Node.Nodes[1].NoTerminalIndex=ord(bnExcept)) then
      with AppendInstruction(inTryExcept)^ do
      begin
         vDebugInfo := Parser.ScanningInputPos;
      end
   else
      with AppendInstruction(inTryFinally)^ do
      begin
         vDebugInfo := Parser.ScanningInputPos;
      end;
   { salva 2 vezes a instrução na pilha para completá-la no AfterTryStatements e no AfterTryUpshot }
   StackPush(stContext,integer(LastInstruction));
   StackPush(stContext,integer(LastInstruction));
end;

procedure TatBasicScript.AfterTryStatements( Node:TNoTerminalNode );
begin
   { registra na instrução TryFinally ou TryExcept o endereço final do bloco try }
   pSimplifiedCode(integer(StackPop(stContext)))^.vInteger:=CodeLine+1;
end;

procedure TatBasicScript.AfterTryUpshot( Node:TNoTerminalNode );
begin
   { registra na instrução TryFinally ou TryExcept o endereço final do bloco finally ou except }
   pSimplifiedCode(integer(StackPop(stContext)))^.vInteger2:=CodeLine+1;
end;

procedure TatBasicScript.BeforeCase( Node:TNoTerminalNode );
begin
   { controle do nível de aninhamento do CASE }
   StackPush(stContext,FCurrentCase);
   inc(FCaseCount);
   FCurrentCase:=FCaseCount;
   { Preserva o índice da variável de um possível CASE aninhado }
   StackPush(stContext,FCaseVarIndex);
end;

procedure TatBasicScript.AfterCase( Node:TNoTerminalNode );
begin
   DefineReferenceAddress( '@EndCase'+inttostr(FCurrentCase) );
   { Restaura o índice da variável de um possível CASE aninhado }
   FCaseVarIndex:=StackPop(stContext);
   { controle do nível de aninhamento do CASE }
   FCurrentCase:=StackPop(stContext);
end;

procedure TatBasicScript.AfterCaseExpr( Node:TNoTerminalNode );
var variable : TatVariableInfo;
begin
   { Preparação da variável do CASE }
   variable := CurrentRoutine.DeclareVariable('#Case'+inttostr(FCurrentCase),Parser.ScanningInputPos);
   FCaseVarIndex:=variable.VarIndex;
   OptimizeStoreVar(variable);
end;

procedure TatBasicScript.AfterCaseTest( Node:TNoTerminalNode );
begin
   { controla a malha de testes exclusivos e disjuntivos }
   if Node.ParentNode.Nodes[Node.Index+1].NoTerminalIndex=ord(bnCase_test) then
      { teste disjuntivo: gera desvio se a expressão do CASE for satisfeita }
      OptimizeVarTest(FCaseVarIndex,'#Case'+inttostr(FCurrentCase),'@Case'+inttostr(FCurrentCase)+'Match'+inttostr(FCaseBranchLevel),true )
   else
      { teste exclusivo: gera desvio se a expressão do CASE não for satisfeita }
      OptimizeVarTest(FCaseVarIndex,'#Case'+inttostr(FCurrentCase),'@Case'+inttostr(FCurrentCase)+'Branch'+inttostr(FCaseBranchLevel+1),false );
end;

procedure TatBasicScript.BeforeCaseBranch( Node:TNoTerminalNode );
begin
   { aumenta o nível de profundidade do teste dos CASES }
   inc(FCaseBranchLevel);
   { Define o endereço de início deste branch }
   DefineReferenceAddress( '@Case'+inttostr(FCurrentCase)+'Branch'+inttostr(FCaseBranchLevel) );
end;

procedure TatBasicScript.BeforeCaseMatch( Node:TNoTerminalNode );
begin
   { define o endereço do trecho executável do ramo do CASE corrente }
   DefineReferenceAddress( '@Case'+inttostr(FCurrentCase)+'Match'+inttostr(FCaseBranchLevel) );
end;

procedure TatBasicScript.AfterCaseMatch( Node:TNoTerminalNode );
begin
   { se tiver mais ramos então gera um desvio para o final do CASE }
   { teste se no final do nó superior (case_branch) tem outro case_branch }
   if Node.OwnerNodes[Node.OwnerNodes.Count-1].NoTerminalIndex=ord(bnCase_branch) then
      with AppendInstruction(inJump)^ do
      begin
         vInteger   := RegisterReference('@EndCase'+inttostr(FCurrentCase));
         vDebugInfo := Parser.ScanningInputPos;
      end;
end;

procedure TatBasicScript.AfterCaseBranch( Node:TNoTerminalNode );
begin
   { diminui o nível de profundidade do teste dos CASES }
   dec(FCaseBranchLevel);
end;

function TatBasicScript.BasicScripter: TatBasicScripter;
begin
  if Scripter is TatBasicScripter then
    result := TatBasicScripter(Scripter)
  else
    result := nil;
end;

function TatBasicScript.EncodeSingleAssign(AVarName, AExpression: string): string;
begin
  {Declare a dummy sub before the assignment in order to assure that
   the variable will be local (not global)}
  result := Format(
    'SUB ____Dummy____ END SUB'#13#10+
    'DIM %s' + #13#10 + '%s = %s', [AVarName, AVarName, AExpression]);
end;

procedure TatBasicScript.AfterExternal(Node: TNoTerminalNode);
var n: integer;
begin
  { external routine }
  with CurrentRoutine do
  begin
    // <external>:lib <filename> [alias "<id>"] [<callingConvention>]
    if Node[0].NoTerminalIndex = ord(bnFileName) then
    begin
      ExternalDll := ExtractQuotedString(Node[0].InputToken);
      { default values: externam name = name; calling convention = stdcall }
      ExternalName := Name;
      CallingConvention := ccStdCall;
      for n:=1 to Node.Nodes.Count-1 do
        case atBASIC_NOTERMINALS(Node[n].NoTerminalIndex) of
          bnExternalName:
            ExternalName := ExtractQuotedString(Node[n].InputToken);
          bnCallingConvention:
            CallingConvention := TatCallingConvention(GetEnumValue(TypeInfo(TatCallingConvention), 'cc'+Node[n].InputToken));
        end;
    end;
    { dispara a preparação da classe de ativação da implementação de chamadas externas }
    PrepareExternalClass;
    { muda o nome da rotina para evitar que seja tratada como uma rotina local }
    Name := '@' + Name;
  end;
end;

function TatBasicScript.ExtractQuotedString(const S: string): string;

   procedure AddChar(var Str, ch: string);
   begin
      try
         Str:=Str+chr(StrToInt(ch));
         ch:='';
      except
         Str:=Str+'.';
         ch:='';
      end;
   end;

var c: integer;
    IsLiteral: boolean;
    CurChar: string;
begin
   c:=1;
   result:='';
   IsLiteral:=false;
   CurChar:='';
   while (c<=Length(S)) do
   begin
      if IsLiteral then
      begin
         if (S[c] = Parser.StringDelimitter) then
         begin
            {Check if there are two single quotes together}
            if (c<Length(S)) and (S[c+1] = Parser.StringDelimitter) then
            begin
               result := result + Parser.StringDelimitter;
               inc(c);
            end else
               IsLiteral:=not IsLiteral;
         end else
            result := result + S[c];
      end else
      begin
         {$IFDEF DELPHI2009_LVL}
         if Character.IsDigit(S[c]) then
         {$ELSE}
         if S[c] in ['0'..'9'] then
         {$ENDIF}
            CurChar:=CurChar+S[c]
         else
         if CurChar>'' then
            AddChar(result,CurChar);

         if S[c] = Parser.StringDelimitter then
            IsLiteral:=not IsLiteral;
      end;
      inc(c);
   end;
   if CurChar>'' then
      AddChar(result,CurChar);
end;

procedure TatBasicScript.AfterConstDecl(Node: TNoTerminalNode);
begin
  OptimizeStoreVar(
    DeclareVariable(Node.Nodes[0].InputToken, -1, moConst, not Assigned(CurrentRoutine), Node.Nodes[0].InputInitialPos ), True );
end;

procedure TatBasicScript.AfterReturn(Node: TNoTerminalNode);
var
  exprNode: TNoTerminalNode;
  resultIdx: integer;
begin
  exprNode := Node.Nodes.FindByNoTerminalName(Parser.NoTerminals[Ord(bnExpression)].IdS);
  if not CurrentRoutine.IsFunction and (exprNode <> nil) then
    { produz erro se EXIT SUB em Function ou EXIT FUNCTION em Sub }
    CompileError('RETURN statement cannot return a value from SUB', Parser.ScanningInputPos)
  else
    {set result variable if expression is available}
    if exprNode <> nil then
    begin
      resultIdx := CurrentRoutine.ResultIndex + CurrentRoutine.ArgCount;
      if resultIdx < CurrentRoutine.Variables.Count then
        OptimizeStoreVar(CurrentRoutine.Variables[resultIdx]);
    end;

    {perform an exit of the routine}
    with AppendInstruction(inJump)^ do
    begin
       vInteger   := RegisterReference('@EndSub' + inttostr(CurrentRoutine.Index));
       vString    := 'EXIT';
       vDebugInfo := Parser.ScanningInputPos;
    end;
end;

{ TatBasicRefactor }

function ProcessUnitList(AScript: TatScript; AUnitList: string): string;
var
  Src, Dst: TStringList;
  c: Integer;
begin
  {Remove already used units, and also duplicated ones}
  Src := TStringList.Create;
  Dst := TStringList.Create;
  try
    Src.CommaText := AUnitList;

    for c := 0 to Src.Count - 1 do
      if (AScript.UsedUnits.FindByName(Src[c]) = nil) and (Dst.IndexOf(Src[c]) = -1) then
        Dst.Add(Src[c]);

    result := Dst.CommaText;
  finally
    Src.Free;
    Dst.Free;
  end;
end;

function GetUnitsInsertStr(AUnitList: string; StartCol: integer): string;
var
  SL: TStringList;
  c: integer;
  ACol: integer;
  ABreak: boolean;
  TextToAdd: string;
begin
  SL := TStringList.Create;
  try
    result := '';
    ACol := StartCol;
    SL.CommaText := AUnitList;
    for c := 0 to SL.Count - 1 do
    begin
      ABreak := (ACol + Length(SL[c])) > 60;
      if ABreak then
      begin
        TextToAdd := #13#10 + '  ' + SL[c];
        ACol := Length('  ' + SL[c]);
      end
      else
      begin
        TextToAdd := SL[c];
        ACol := ACol + Length(SL[c]);
      end;

      if result <> '' then
      begin
        result := result + ', ';
        ACol := ACol + 1;
      end;

      result := result + TextToAdd;
    end;
  finally
    SL.Free;
  end;
end; 

procedure TatBasicRefactor.AddUsedUnit(AUnitName: string);
var
  InsertPosition: integer;
  c: integer;
  S: string;
  ARow, ACol: integer;
begin
  BeginRefactor;
  try
    if Script <> nil then
    begin
      {ensure script is compiled}
      if not Script.SilentCompiled then
        Script.SilentCompile;
      if not Script.ExpandedDebugInfo then
        Script.ExpandDebugInfo(false);

      AUnitName := ProcessUnitList(Script, AUnitName);

      if AUnitName > '' then
      begin
        {Find the last unit position in source code}
        InsertPosition := 0;
        for c := 0 to Script.UsedUnits.Count - 1 do
          if (Script.UsedUnits[c].DeclSourcePos + Length(Script.UsedUnits[c].UnitName) > InsertPosition) then
            InsertPosition := Script.UsedUnits[c].DeclSourcePos + Length(Script.UsedUnits[c].UnitName);

        {if there is no unit added, then just add source code and adjust insertposition}
        if Script.UsedUnits.Count = 0 then
        begin
          {Find form directive to add the uses clause after it}
          InsertPosition := Pos('#FORM', UpcaseSource);

          if InsertPosition > 0 then
          begin
            {if there is a form directive, then go to the end of line}
            repeat
              Inc(InsertPosition);
            until (UpcaseSource[InsertPosition] = #13) or (InsertPosition > Length(UpcaseSource));

            {Put position after characters #13#10}
            InsertPosition := InsertPosition + 2;

            if InsertPosition > Length(UpcaseSource) then
              InsertPosition := Length(UpcaseSource);

            S := Script.SourceCode.Text;
            Insert(
              #13#10 +
              'uses'#13#10 +
              '  ' + GetUnitsInsertStr(AUnitName, 4) + #13#10, S, InsertPosition);
            Script.SourceCode.Text := S;

          end;
        end else
        begin
          GetRowColFromStrings(Script.SourceCode, InsertPosition, ARow, ACol);
          S := Script.SourceCode.Text;
          Insert(', ' + GetUnitsInsertStr(AUnitName, ACol), S, InsertPosition);
          Script.SourceCode.Text := S;
        end;
      end;
    end;
  finally
    EndRefactor;
  end;
end;

function TatBasicRefactor.DeclareRoutine(AInfo: TatRoutineInfo): integer;

  function BuildProcedureHeader: string;
  var
    c: integer;
    Args: string;
    AVar: TatVariableInfo;
    AType: string;
    AModifier: string;
  begin
    {Build parameters}
    Args := '';
    for c := 0 to AInfo.Variables.Count - 1 do
    begin
      AVar := AInfo.Variables[c];

      {Check if variable is a parameter}
      if AVar.ArgIndex > -1 then
      begin
        {Build modifier string}
        Case AVar.Modifier of
          moVar: AModifier := 'BYREF ';
        else
          AModifier := '';
        end;

        {Get parameter type}
        AType := AVar.TypeDecl;

        {add terminator if there are already existing args}
        if Args > '' then
          Args := Args + ', ';

        Args := Args + AModifier;

        {Add variable name}
        Args := Args + AVar.VarName;

        if AVar.TypeDecl > '' then
          Args := Args + ' AS ' + AVar.TypeDecl;
      end;
    end;
    if Args > '' then
      Args := Format('(%s)', [Args]);
    {Finishing building parameters}

    if not AInfo.IsFunction then   
    begin
      result := Format('SUB %s%s', [AInfo.Name, Args]);
    end else
    begin
      if AInfo.ResultTypeDecl > '' then
        AType := ' AS ' + AInfo.ResultTypeDecl
      else
        AType := '';
      result := Format('FUNCTION %s%s%s', [AInfo.Name, Args, AType]);
    end;
  end;

  function AddProcedureSource(ALine, ACol: integer): integer;
  var
    S: string;
    Prefix, Sufix: string;
  begin
    if ALine < 0 then
      ALine := 0;
    if ALine > Script.SourceCode.Count then
      ALine := Script.SourceCode.Count;

    if (ALine < Script.SourceCode.Count) and (ACol > 1) then
    begin
      S := Script.SourceCode[ALine];
      Sufix := Copy(S, ACol, MaxInt);
      Prefix := Copy(S, 1, ACol - 1);
      if Trim(Prefix) > '' then
      begin
        Script.SourceCode.Insert(ALine + 1, Sufix);
        Script.SourceCode[ALine] := Prefix;
        ALine := ALine + 1;
      end;
    end;

    {Insert a blank line before the procedure, if the last line is not empty}
    if (ALine > 0) and (Trim(Script.SourceCode[ALine - 1]) <> '') then
    begin
      Script.SourceCode.Insert(ALine, '');
      ALine := ALine + 1;
    end;

    Script.SourceCode.Insert(ALine, BuildProcedureHeader);
    Script.SourceCode.Insert(ALine + 1, '');
    if AInfo.IsFunction then
      Script.SourceCode.Insert(ALine + 2, 'END FUNCTION')
    else
      Script.SourceCode.Insert(ALine + 2, 'END SUB');
    Script.SourceCode.Insert(ALine + 3, '');
    result := ALine;
  end;

var
  DeclaredRoutine: TatRoutineInfo;
  Line, Col: integer;
begin
  BeginRefactor;
  try
    if Script <> nil then
    begin
      if not Script.SilentCompiled then
        Script.SilentCompile;
      if not Script.ExpandedDebugInfo then
        Script.ExpandDebugInfo(false);

      DeclaredRoutine := Script.ScriptInfo.RoutineByName(AInfo.Name);
      if DeclaredRoutine <> nil then
      begin
        result := LineNumberFromInstruction(DeclaredRoutine.DeclarationInstruction);
      end else
      begin
        Line := LineNumberFromInstruction(Script.ScriptInfo.MainRoutine.DeclarationInstruction);
        Col := ColNumberFromInstruction(Script.ScriptInfo.MainRoutine.DeclarationInstruction);
        result := AddProcedureSource(Line, Col);
      end;
      result := result + 1; {After SUB line}
    end else
      result := 0;
  finally
    EndRefactor;
  end;
end;

procedure TatBasicRefactor.UpdateFormHeader(AFormClass, AFileName: string);
var
  S: string;
  P, P2: integer;
  Directive: string;
begin
  BeginRefactor;
  try
    S := Source.Text;

    {Find the position for the directive}
    P := SourcePos('#FORM');
    if P <> 0 then
    begin
      P2 := P;

      {if the directive is found, then find the end of directive (close bracket char) and delete it}
      while (P2 <= Length(S)) and (S[P2] <> #13) do
        inc(P2);

      Delete(S, P, P2 - P + 1);
    end else
      {Add a line break if there is no directive, so it is added at the first line
       and a break is done after it}
      S := #13#10 + S;

    Directive := Format('#FORM %s, %s', [AFormClass, AFileName]);
    Insert(Directive, S, P);
    Source.Text := S;
  finally
    EndRefactor;
  end;
end;

end.

