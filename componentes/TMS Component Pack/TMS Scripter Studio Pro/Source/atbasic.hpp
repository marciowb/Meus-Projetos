// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atBasic.pas' rev: 22.00

#ifndef AtbasicHPP
#define AtbasicHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <atParser.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Character.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atbasic
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatBasicScripter;
class PASCALIMPLEMENTATION TatBasicScripter : public Atscript::TatCustomScripter
{
	typedef Atscript::TatCustomScripter inherited;
	
protected:
	virtual void __fastcall DefineInternalClasses(void);
	
public:
	__fastcall virtual TatBasicScripter(Classes::TComponent* AOwner);
	__fastcall virtual ~TatBasicScripter(void);
	
__published:
	__property SourceCode;
	__property Compiled;
	__property SaveCompiledCode;
	__property EventSupport = {default=1};
	__property EventSetMode = {default=0};
	__property EventUnsetMode = {default=0};
	__property OnDebugHook;
	__property OnExecHook;
	__property OnCompileError;
	__property OnRuntimeError;
	__property OnExecuteEvent;
	__property OnSettingEvent;
	__property OnSetEvent;
	__property OnUnsettingEvent;
	__property ShortBooleanEval;
	__property LibOptions;
	__property CallExecHookEvent;
	__property OnUnknownElement;
	__property OnBreakpointStop;
};


class DELPHICLASS TatBasicRefactor;
class PASCALIMPLEMENTATION TatBasicRefactor : public Atscript::TatScriptRefactor
{
	typedef Atscript::TatScriptRefactor inherited;
	
public:
	virtual void __fastcall AddUsedUnit(System::UnicodeString AUnitName);
	virtual void __fastcall UpdateFormHeader(System::UnicodeString AFormClass, System::UnicodeString AFileName);
	virtual int __fastcall DeclareRoutine(Atscript::TatRoutineInfo* AInfo)/* overload */;
public:
	/* TatScriptRefactor.Create */ inline __fastcall TatBasicRefactor(Atscript::TatScript* AScript) : Atscript::TatScriptRefactor(AScript) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TatBasicRefactor(void) { }
	
/* Hoisted overloads: */
	
public:
	inline int __fastcall  DeclareRoutine(System::UnicodeString ProcName){ return Atscript::TatScriptRefactor::DeclareRoutine(ProcName); }
	
};


class DELPHICLASS TatBasicScript;
class PASCALIMPLEMENTATION TatBasicScript : public Atscript::TatScript
{
	typedef Atscript::TatScript inherited;
	
private:
	int FForCount;
	int FCurrentFor;
	int FWhileCount;
	int FCurrentWhile;
	int FRepeatCount;
	int FCurrentRepeat;
	int FIfCount;
	int FCurrentIf;
	int FCaseCount;
	int FWithCount;
	int FCurrentWith;
	int FOperatorCount;
	int FCurrentOperator;
	int FCurrentCase;
	int FCaseVarIndex;
	int FCaseBranchLevel;
	Atscript::TLoopStatement FCurrentLoop;
	Atscript::TatClass* FCurrentClass;
	bool FIsClassReference;
	int FLastByRefArgMask;
	int FByRefArgMask;
	bool FThereIsAnySubrot;
	Contnrs::TObjectList* FPushVarListObjects;
	Classes::TList* FPushVarList;
	Classes::TList* FLastPushVarList;
	bool __fastcall AcceptNodeId(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeProgram(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterProgram(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterUses(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterImports(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeMain(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterMain(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeSubRoutine(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterSubRoutine(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterPushOutput(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeFor(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterFor(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterForControl(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterStep(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeIf(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterIf(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeThen(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterThen(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeElseIf(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterElseIf(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeElse(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeExpression(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterExpression(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterOperator(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterUnary(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterLabel(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterId(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterReal(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterHex(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterString(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterVector(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeArgList(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterArgList(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeCallCode(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeDataValCode(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeDataRefCode(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeNewCallCode(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeTry(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterTryStatements(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterTryUpshot(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterCase(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeCase(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterCaseExpr(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterCaseTest(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterCaseMatch(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeCaseMatch(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterCaseBranch(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeCaseBranch(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterInputArgs(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterVarDecl(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterLoopTestExpr(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterTestLoop(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterTestLoopExpr(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeLoopTest(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeLoopTestExpr(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeTestLoop(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeTestLoopExpr(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterExitLoop(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterExitRoutine(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterWhileEndExpr(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterWith(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterWithObj(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterExternal(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterConstDecl(Atparser::TNoTerminalNode* Node);
	void __fastcall AfterReturn(Atparser::TNoTerminalNode* Node);
	void __fastcall MakeDataElementCode(Atparser::TNoTerminalNode* Node, Atscript::TDataOperation operation);
	bool __fastcall SpecialKeyWord(System::UnicodeString AName, Atscript::TDataOperation operation);
	System::UnicodeString __fastcall ExtractQuotedString(const System::UnicodeString S);
	void __fastcall ExtractSourceRemark(Atparser::TatSyntaxParser* AParser, int AStartPos, int AFinalPos);
	void __fastcall AfterIndexing(Atparser::TNoTerminalNode* Node);
	void __fastcall BeforeIndexing(Atparser::TNoTerminalNode* Node);
	
protected:
	virtual System::UnicodeString __fastcall EncodeSingleAssign(System::UnicodeString AVarName, System::UnicodeString AExpression);
	
public:
	__fastcall virtual TatBasicScript(Classes::TCollection* ACollection);
	__fastcall virtual ~TatBasicScript(void);
	virtual void __fastcall Clear(void);
	TatBasicScripter* __fastcall BasicScripter(void);
};


#pragma option push -b-
enum atBASIC_NOTERMINALS { bnProgram, bnMain, bnUses, bnImports, bnSubroutine, bnFunction, bnSubVisibility, bnExternal, bnFileName, bnExternalName, bnCallingConvention, bnInputArgs, bnForward, bnByRef, bnByVal, bnArgType, bnVarDecl, bnConstDecl, bnVarList, bnGlobalDecl, bnGlobalVisibility, bnStatement, bnCall, bnCall_code, bnData_val, bnData_val_code, bnData_ref, bnData_ref_code, bnNew_call, bnNew_call_code, bnArg_list, bnIndexing, bnAssign, bnPush_output, bnFor, bnFor_control, bnStep, bnDo_loop, bnTest_loop, bnTest_loop_expr, bnLoop_test, bnLoop_test_expr, bnWhile, bnUntil, bnWhileEnd, bnWhileEnd_expr, bnIf, bnThen, bnThenSingle, bnElseIf, bnElse, bnElseSingle, bnExpression, bnOperator, bnUnary, bnLabel, bnId, bnReal, bnHex, bnFrac, bnExp, bnString, 
	bnVector, bnTry, bnFinally, bnExcept, bnTry_statements, bnTry_upshot, bnCase, bnCase_expr, bnCase_branch, bnCase_test, bnCase_match, bnExit, bnExit_sub, bnExit_function, bnExit_do, bnExit_for, bnReturn, bnWith, bnWith_obj };
#pragma option pop

//-- var, const, procedure ---------------------------------------------------

}	/* namespace Atbasic */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atbasic;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtbasicHPP
