// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atScript.pas' rev: 22.00

#ifndef AtscriptHPP
#define AtscriptHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <atParser.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Rtti.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atscript
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TInstruction { inPrepare, inPushInteger, inPushDouble, inPushString, inPushConst, inPushOutput, inPushClass, inDuplicate, inDuplicate2, inDrop2, inSwap2, inOperNE, inOperGE, inOperLE, inOperEqual, inOperGreater, inOperLess, inOperAdd, inOperConcat, inOperSub, inOperOr, inOperXor, inOperMul, inOperSlash, inOperDiv, inOperMod, inOperAnd, inOperShl, inOperShr, inOperExp, inOperIs, inOperNeg, inOperNot, inJumpIfFalse, inJumpIfTrue, inJump, inStoreVar, inStoreVarRef, inStoreIdxVar, inStoreIdxVarRef, inStoreVarInteger, inStoreVarRefInteger, inStoreVarDouble, inStoreVarRefDouble, inStoreVarString, inStoreVarRefString, inStoreVarConst, inStoreVarRefConst, inCopyVar, inCopyVarRef, inStoreInput, inPushVar, inPushIdxVar, inPushVarByRef, inVarTest, inVarTestInteger, 
	inVarTestDouble, inVarTestString, inVarTestVar, inStoreGlobalVar, inStoreGlobalIdxVar, inPushGlobalVar, inPushGlobalIdxVar, inPushGlobalVarByRef, inCall, inRet, inExecFun, inCallProc, inTryFinally, inTryExcept, inCallClassProc, inBreakPoint, inAbort, inArrayOf, inCastClass, inWithObject, inGlobalPrepare, inTestIfFalse, inTestIfTrue };
#pragma option pop

typedef int *PInteger;

typedef bool *PBoolean;

typedef void * *PPointer;

typedef System::WideChar * *PPChar;

typedef void __fastcall (__closure *TGenericProc)(void);

typedef void __fastcall (__closure *TBuiltInProc)(const System::Variant &Input, System::Variant &Output);

struct TSimplifiedCode;
typedef TSimplifiedCode *pSimplifiedCode;

struct DECLSPEC_DRECORD TSimplifiedCode
{
	
public:
	TInstruction OpCode;
	System::Byte vByte;
	short vSmallInt;
	int vInteger;
	int vInteger1;
	System::UnicodeString vString;
	int vDebugInfo;
	TSimplifiedCode *Next;
	TGenericProc Compute;
	System::UnicodeString vString2;
	int Dummy;
	#pragma pack(push,1)
	union
	{
		struct 
		{
			int vInteger2;
			int vInteger3;
			
		};
		struct 
		{
			TGenericProc vProc;
			
		};
		struct 
		{
			double vDouble;
			
		};
		
	};
	#pragma pack(pop)
};


typedef System::DynamicArray<int> intarray;

typedef void __fastcall (__closure *TSingleStepProc)(pSimplifiedCode p);

#pragma option push -b-
enum TStackType { stPendingOperators, stIdentifierList, stContext, stTempVariables };
#pragma option pop

struct TStackElement;
typedef TStackElement *pStackElement;

struct DECLSPEC_DRECORD TStackElement
{
	
public:
	TStackElement *Previous;
	System::Variant Element;
	int Index;
};


struct TAddress;
typedef TAddress *pAddress;

struct DECLSPEC_DRECORD TAddress
{
	
public:
	int Address;
	TSimplifiedCode *Code;
	TAddress *Next;
};


struct TLabelSpec;
typedef TLabelSpec *pLabelSpec;

struct DECLSPEC_DRECORD TLabelSpec
{
	
public:
	System::UnicodeString Name;
	int Address;
	TAddress *FirstRef;
	TAddress *LastRef;
	TLabelSpec *Next;
};


struct DECLSPEC_DRECORD TImplicitClassRef
{
	
public:
	int ClassIndex;
	int ElementIndex;
	bool ElementIsMethod;
	int ClassNameSize;
	int ElementNameSize;
};


struct DECLSPEC_DRECORD TUsedUnitRec
{
	
public:
	int UnitNameSize;
	bool IsDefault;
	bool IsScript;
	int DeclSourcePos;
};


struct DECLSPEC_DRECORD TCodeFileHeader
{
	
public:
	System::StaticArray<System::WideChar, 25> Signature;
	System::Byte Version;
	int ImplicitRefCount;
	int UsedUnitCount;
	int ScriptInfoSize;
	System::StaticArray<System::Byte, 28> Reserved;
};


struct DECLSPEC_DRECORD TInstructionDetails
{
	
public:
	System::Byte OpCode;
	System::Byte vByte;
	short vSmallInt;
	int vDebugInfo;
	int vInteger;
	int vInteger1;
	int vInteger2;
	int vInteger3;
};


struct DECLSPEC_DRECORD TInstructionDescriptor
{
	
public:
	int Size;
	int Size2;
	TInstructionDetails Details;
};


#pragma option push -b-
enum TDataOperation { doRead, doWrite, doExec, doAddr };
#pragma option pop

#pragma option push -b-
enum TClassReference { crNone, crGetter, crSetter, crMethod };
#pragma option pop

class DELPHICLASS EatScripterRuntime;
class PASCALIMPLEMENTATION EatScripterRuntime : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EatScripterRuntime(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EatScripterRuntime(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EatScripterRuntime(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EatScripterRuntime(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EatScripterRuntime(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EatScripterRuntime(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EatScripterRuntime(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EatScripterRuntime(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EatScripterRuntime(void) { }
	
};


class DELPHICLASS EatRuntimeError;
class PASCALIMPLEMENTATION EatRuntimeError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EatRuntimeError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EatRuntimeError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EatRuntimeError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EatRuntimeError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EatRuntimeError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EatRuntimeError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EatRuntimeError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EatRuntimeError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EatRuntimeError(void) { }
	
};


class DELPHICLASS EatCompileError;
class PASCALIMPLEMENTATION EatCompileError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EatCompileError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EatCompileError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EatCompileError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EatCompileError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EatCompileError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EatCompileError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EatCompileError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EatCompileError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EatCompileError(void) { }
	
};


class DELPHICLASS EatInternalError;
class PASCALIMPLEMENTATION EatInternalError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EatInternalError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EatInternalError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EatInternalError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EatInternalError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EatInternalError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EatInternalError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EatInternalError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EatInternalError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EatInternalError(void) { }
	
};


class DELPHICLASS EatScriptInfoError;
class PASCALIMPLEMENTATION EatScriptInfoError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EatScriptInfoError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EatScriptInfoError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EatScriptInfoError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EatScriptInfoError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EatScriptInfoError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EatScriptInfoError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EatScriptInfoError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EatScriptInfoError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EatScriptInfoError(void) { }
	
};


class DELPHICLASS EatDefinitionError;
class PASCALIMPLEMENTATION EatDefinitionError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EatDefinitionError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EatDefinitionError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EatDefinitionError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EatDefinitionError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EatDefinitionError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EatDefinitionError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EatDefinitionError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EatDefinitionError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EatDefinitionError(void) { }
	
};


class DELPHICLASS EatScripterFatal;
class PASCALIMPLEMENTATION EatScripterFatal : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EatScripterFatal(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EatScripterFatal(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EatScripterFatal(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EatScripterFatal(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EatScripterFatal(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EatScripterFatal(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EatScripterFatal(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EatScripterFatal(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EatScripterFatal(void) { }
	
};


class DELPHICLASS EatScripterDebug;
class PASCALIMPLEMENTATION EatScripterDebug : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EatScripterDebug(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EatScripterDebug(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EatScripterDebug(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EatScripterDebug(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EatScripterDebug(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EatScripterDebug(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EatScripterDebug(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EatScripterDebug(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EatScripterDebug(void) { }
	
};


typedef System::StaticArray<pSimplifiedCode, 1> TAddrVector;

typedef TAddrVector *pAddrVector;

#pragma option push -b-
enum CORE_CONST { coTrue, coFalse, coNull, coUnassigned, coNil };
#pragma option pop

#pragma option push -b-
enum TatCallingConvention { ccStdCall, ccRegister, ccPascal, ccCDecl, ccSafeCall };
#pragma option pop

typedef double *PReal;

typedef System::Comp *PComp;

typedef TMetaClass* TScriptFormClass;

typedef TMetaClass* TDispatcherClass;

#pragma option push -b-
enum TatEventPlacement { epReplaceCall, epTopCall, epBottomCall };
#pragma option pop

#pragma option push -b-
enum TEventSetMode { esReplaceEvent, esAddEventOnTop, esAddEventOnBottom };
#pragma option pop

#pragma option push -b-
enum TEventUnsetMode { euReplaceNil, euOriginalEvent, euClearEvent, euPreviousEvent };
#pragma option pop

class DELPHICLASS TatEventDispatcher;
typedef void __fastcall (__closure *TExecuteEventProc)(TatEventDispatcher* AEventDispatcher, bool &AExecute);

class DELPHICLASS TatCustomScripter;
typedef void __fastcall (__closure *TSettingEventProc)(System::TObject* Sender, System::TObject* AInstance, System::UnicodeString APropName, System::UnicodeString ARoutineName, TatCustomScripter* AScripter, TatEventPlacement APlacement, bool &AProcede);

typedef void __fastcall (__closure *TSetEventProc)(TatEventDispatcher* AEventDispatcher);

typedef void __fastcall (__closure *TUnsetEventProc)(TatEventDispatcher* AEventDispatcher, bool &AProcede);

class DELPHICLASS TatVirtualMachine;
typedef void __fastcall (__closure *TTranslateMethodGetterProc)(TatVirtualMachine* AMachine, System::TObject* AInstance, Typinfo::PPropInfo APropInfo, System::Variant &AValue);

typedef void __fastcall (__closure *TTranslateMethodSetterProc)(TatVirtualMachine* AMachine, System::TObject* AInstance, Typinfo::PPropInfo APropInfo, const System::Variant &AValue);

typedef TMetaClass* TScriptClass;

typedef TMetaClass* TMachineClass;

typedef TMetaClass* TatScripterLibraryClass;

#pragma option push -b-
enum TatArgumentModifier { moNone, moConst, moVar };
#pragma option pop

typedef System::Set<TatArgumentModifier, TatArgumentModifier::moNone, TatArgumentModifier::moVar>  TatArgumentModifiers;

typedef void __fastcall (__closure *TScriptErrorEvent)(System::TObject* Sender, System::UnicodeString &msg, int row, int col, bool &ShowException);

typedef void __fastcall (__closure *TBeforeExecuteEvent)(TatVirtualMachine* AMachine, System::UnicodeString ALabel);

typedef void __fastcall (__closure *TMachineProc)(TatVirtualMachine* AMachine);

#pragma option push -b-
enum TatTypeKind { tkNone, tkInteger, tkChar, tkEnumeration, tkFloat, tkString, tkSet, tkClass, tkMethod, tkWChar, tkLString, tkWString, tkVariant, tkArray, tkRecord, tkInterface, tkInt64, tkDynArray, tkUString };
#pragma option pop

#pragma option push -b-
enum TWatchStatus { wsNotEvaluated, wsEvaluated, wsCompileError, wsRuntimeError, wsProcessNotAvailable };
#pragma option pop

typedef System::Set<Typinfo::TMemberVisibility, Typinfo::TMemberVisibility::mvPrivate, Typinfo::TMemberVisibility::mvPublished>  TMemberVisibilitySet;

#pragma option push -b-
enum TRedefineOption { roNone, roInclude, roOverwrite };
#pragma option pop

class DELPHICLASS TScripterLibraryOptions;
class PASCALIMPLEMENTATION TScripterLibraryOptions : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FUseScriptFiles;
	System::UnicodeString FCompiledFileExt;
	System::UnicodeString FSourceFileExt;
	System::UnicodeString FFormFileExt;
	Classes::TStrings* FSearchPath;
	void __fastcall SetSearchPath(const Classes::TStrings* Value);
	
public:
	__fastcall TScripterLibraryOptions(void);
	__fastcall virtual ~TScripterLibraryOptions(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Classes::TStrings* SearchPath = {read=FSearchPath, write=SetSearchPath};
	__property System::UnicodeString SourceFileExt = {read=FSourceFileExt, write=FSourceFileExt};
	__property System::UnicodeString CompiledFileExt = {read=FCompiledFileExt, write=FCompiledFileExt};
	__property System::UnicodeString FormFileExt = {read=FFormFileExt, write=FFormFileExt};
	__property bool UseScriptFiles = {read=FUseScriptFiles, write=FUseScriptFiles, nodefault};
};


class DELPHICLASS TatClass;
struct DECLSPEC_DRECORD TElementContext
{
	
public:
	bool HasArgList;
	bool HasUpnode;
	bool HasSubNode;
	bool IsNewClause;
	TDataOperation Operation;
	int ArgCount;
	int IdxCount;
	bool RepeatChecking;
	System::UnicodeString ElementName;
	TatClass* CurrentClass;
};


typedef void __fastcall (__closure *TUnknownElementEvent)(System::TObject* Sender, TElementContext &Context);

class DELPHICLASS TatScripts;
class DELPHICLASS TatScript;
class DELPHICLASS TatObjects;
class DELPHICLASS TatClasses;
class DELPHICLASS TatObject;
class DELPHICLASS TatScripterEventBroker;
class DELPHICLASS TatScripterWatches;
class DELPHICLASS TatScriptBreakPoints;
class DELPHICLASS TatScriptInfo;
class DELPHICLASS TatScripterLibrary;
class DELPHICLASS TatProperty;
class DELPHICLASS TatMethod;
class PASCALIMPLEMENTATION TatCustomScripter : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	bool FDeferObjectResolution;
	TScriptClass FScriptClass;
	TMachineClass FMachineClass;
	Typinfo::TTypeKinds FTypeInfoFilter;
	TatScripts* FScripts;
	TatScript* FCurrentScript;
	TatObjects* FDefaultInstances;
	TatClasses* FClasses;
	Classes::TList* FLibInstances;
	TatObject* FInternalInstance;
	Classes::TMemoryStream* FPCode;
	bool FOptionExplicit;
	TScriptErrorEvent FOnCompileError;
	TScriptErrorEvent FOnRuntimeError;
	TBeforeExecuteEvent FOnBeforeExecute;
	TTranslateMethodGetterProc FOnTranslateMethodGetter;
	TTranslateMethodSetterProc FOnTranslateMethodSetter;
	bool FEventSupport;
	TEventSetMode FEventSetMode;
	TEventUnsetMode FEventUnsetMode;
	TatScripterEventBroker* FEventBroker;
	Classes::TList* FLoadedScripts;
	bool FShortBooleanEval;
	bool FSaveCompiledCode;
	TScripterLibraryOptions* FLibOptions;
	bool FAllowDLLCalls;
	TUnknownElementEvent FOnUnknownElement;
	Classes::TNotifyEvent FOnRunningChanged;
	Classes::TNotifyEvent FOnDebugHook;
	Classes::TNotifyEvent FOnSingleDebugHook;
	bool FLastRunning;
	Classes::TNotifyEvent FOnBreakpointStop;
	TatScripterWatches* FWatches;
	TScriptFormClass FScriptFormClass;
	bool FLoadFormEvents;
	void __fastcall ReadPCodeProp(Classes::TStream* Stream);
	void __fastcall WritePCodeProp(Classes::TStream* Stream);
	bool __fastcall PCodeEquals(Classes::TStream* pcode);
	TatScriptBreakPoints* __fastcall GetBreakPoints(void);
	bool __fastcall GetCompiled(void);
	System::TObject* __fastcall GetCurrentObject(void);
	TatClass* __fastcall GetCurrentClass(void);
	pSimplifiedCode __fastcall GetFirstInstruction(void);
	bool __fastcall GetHalted(void);
	System::UnicodeString __fastcall GetLastExceptionClassName(void);
	int __fastcall GetLastExceptionHelpContext(void);
	System::UnicodeString __fastcall GetLastExceptionMessage(void);
	pSimplifiedCode __fastcall GetNextInstruction(void);
	Classes::TNotifyEvent __fastcall GetOnExecHook(void);
	Classes::TNotifyEvent __fastcall GetOnPauseChanged(void);
	bool __fastcall GetPaused(void);
	bool __fastcall GetRunning(void);
	Classes::TStrings* __fastcall GetSourceCode(void);
	void __fastcall SetCompiled(const bool Value);
	void __fastcall SetOnExecHook(const Classes::TNotifyEvent Value);
	void __fastcall SetOnPauseChanged(const Classes::TNotifyEvent Value);
	void __fastcall SetPaused(const bool Value);
	void __fastcall SetRunning(const bool Value);
	void __fastcall SetSourceCode(const Classes::TStrings* Value);
	void __fastcall CreateLibraries(void);
	void __fastcall SetClasses(const TatClasses* Value);
	TatScriptInfo* __fastcall GetScriptInfo(void);
	void __fastcall SetEventSetMode(const TEventSetMode Value);
	void __fastcall SetEventSupport(const bool Value);
	void __fastcall SetEventUnsetMode(const TEventUnsetMode Value);
	void __fastcall TranslateMethodGetter(TatVirtualMachine* AMachine, System::TObject* AInstance, Typinfo::PPropInfo APropInfo, System::Variant &AValue);
	void __fastcall TranslateMethodSetter(TatVirtualMachine* AMachine, System::TObject* AInstance, Typinfo::PPropInfo APropInfo, const System::Variant &AValue);
	TExecuteEventProc __fastcall GetOnExecuteEvent(void);
	TSetEventProc __fastcall GetOnSetEvent(void);
	TSettingEventProc __fastcall GetOnSettingEvent(void);
	TUnsetEventProc __fastcall GetOnUnsettingEvent(void);
	void __fastcall SetOnExecuteEvent(const TExecuteEventProc Value);
	void __fastcall SetOnSetEvent(const TSetEventProc Value);
	void __fastcall SetOnSettingEvent(const TSettingEventProc Value);
	void __fastcall SetOnUnsettingEvent(const TUnsetEventProc Value);
	void __fastcall FreeLibInstances(void);
	void __fastcall InternalCompileError(System::UnicodeString msg, int debuginfo, TatScript* AScript)/* overload */;
	void __fastcall InternalCompileError(System::UnicodeString msg, int row, int col, TatScript* AScript)/* overload */;
	void __fastcall InternalRuntimeError(System::UnicodeString msg, TatScript* AScript);
	void __fastcall SetOnBeforeExecute(const TBeforeExecuteEvent Value);
	bool __fastcall GetSilentCompiled(void);
	void __fastcall SetSilentCompiled(const bool Value);
	bool __fastcall DoSaveCompiledCode(void);
	System::UnicodeString __fastcall FindFileInSearchPath(const System::UnicodeString CompName, const System::UnicodeString SrcName);
	System::UnicodeString __fastcall FindScriptFile(System::UnicodeString AName);
	bool __fastcall IsFileRegisteredAsLibrary(System::UnicodeString AFileName, TatScripterLibrary* &ALib);
	void __fastcall SetLibOptions(const TScripterLibraryOptions* Value);
	bool __fastcall GetCallExecHookEvent(void);
	void __fastcall SetCallExecHookEvent(const bool Value);
	System::UnicodeString __fastcall FindFormFile(System::UnicodeString AName);
	void __fastcall ScriptFormCreateProc(TatVirtualMachine* AMachine);
	void __fastcall ComponentCreateProc(TatVirtualMachine* AMachine);
	void __fastcall CheckRunningChanged(TatVirtualMachine* AMachine);
	bool __fastcall IsAnyRunning(void);
	TatScript* __fastcall GetCurrentDebugScript(void);
	void __fastcall SetScriptFormClass(const TScriptFormClass Value);
	System::TClass __fastcall ScrClassType(Rtti::TRttiType* AType);
	Rtti::TValue __fastcall ScrPrepareValue(Rtti::TRttiType* AType, const System::Variant &AValue);
	TatTypeKind __fastcall ScrTypeKind(Rtti::TRttiType* AType);
	void __fastcall GenericMethodMachineProc(TatVirtualMachine* AMachine);
	void __fastcall GenericPropGetterMachineProc(TatVirtualMachine* AMachine);
	void __fastcall GenericPropSetterMachineProc(TatVirtualMachine* AMachine);
	void __fastcall GenericFieldGetterMachineProc(TatVirtualMachine* AMachine);
	void __fastcall GenericFieldSetterMachineProc(TatVirtualMachine* AMachine);
	void __fastcall GenericRecordFieldGetterMachineProc(TatVirtualMachine* AMachine);
	void __fastcall GenericRecordFieldSetterMachineProc(TatVirtualMachine* AMachine);
	void __fastcall RecordCreateProc(TatVirtualMachine* AMachine);
	void __fastcall RecordFreeProc(TatVirtualMachine* AMachine);
	
protected:
	virtual void __fastcall DoCompileError(System::UnicodeString msg, int row, int col, bool &AShow, TatScript* AScript);
	virtual void __fastcall Loaded(void);
	void __fastcall DoUnknownElement(TElementContext &Context);
	void __fastcall BeforeExecute(TatVirtualMachine* AMachine, System::UnicodeString ALabel);
	virtual void __fastcall DefineInternalClasses(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall BeforeCompile(void);
	virtual void __fastcall BeforeLoadCode(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall DoRunningChanged(TatVirtualMachine* AMachine);
	virtual bool __fastcall DoDebugHook(TatVirtualMachine* AMachine);
	virtual void __fastcall SingleDebugHook(TatVirtualMachine* AMachine);
	virtual void __fastcall SourceCodeChanged(TatScript* AScript);
	virtual TScriptClass __fastcall DefaultScriptClass(void);
	virtual void __fastcall DoBreakpointStop(void);
	__property TScriptClass ScriptClass = {read=FScriptClass, write=FScriptClass};
	__property TMachineClass MachineClass = {read=FMachineClass, write=FMachineClass};
	__property TTranslateMethodGetterProc OnTranslateMethodGetter = {read=FOnTranslateMethodGetter, write=FOnTranslateMethodGetter};
	__property TTranslateMethodSetterProc OnTranslateMethodSetter = {read=FOnTranslateMethodSetter, write=FOnTranslateMethodSetter};
	__property bool EventSupport = {read=FEventSupport, write=SetEventSupport, default=1};
	__property TEventSetMode EventSetMode = {read=FEventSetMode, write=SetEventSetMode, default=0};
	__property TEventUnsetMode EventUnsetMode = {read=FEventUnsetMode, write=SetEventUnsetMode, default=0};
	__property TExecuteEventProc OnExecuteEvent = {read=GetOnExecuteEvent, write=SetOnExecuteEvent};
	__property TSettingEventProc OnSettingEvent = {read=GetOnSettingEvent, write=SetOnSettingEvent};
	__property TSetEventProc OnSetEvent = {read=GetOnSetEvent, write=SetOnSetEvent};
	__property TUnsetEventProc OnUnsettingEvent = {read=GetOnUnsettingEvent, write=SetOnUnsettingEvent};
	
public:
	__fastcall virtual TatCustomScripter(Classes::TComponent* AOwner);
	__fastcall virtual ~TatCustomScripter(void);
	virtual void __fastcall Clear(void);
	void __fastcall LoadCodeFromFile(System::UnicodeString AFileName);
	void __fastcall SaveCodeToFile(System::UnicodeString AFileName);
	void __fastcall LoadCodeFromStream(Classes::TStream* AStream);
	void __fastcall SaveCodeToStream(Classes::TStream* AStream);
	void __fastcall AddFunction(System::UnicodeString Name, TBuiltInProc Address);
	virtual void __fastcall Compile(void);
	void __fastcall SilentCompile(void);
	virtual System::Variant __fastcall Execute(void)/* overload */;
	virtual System::Variant __fastcall Execute(const System::Variant &input)/* overload */;
	System::Variant __fastcall ExecuteSubroutine(System::UnicodeString ALabel, const System::Variant &input)/* overload */;
	System::Variant __fastcall ExecuteSubroutine(System::UnicodeString ALabel)/* overload */;
	System::Variant __fastcall ExecuteSubroutine(System::UnicodeString ALabel, System::TVarRec *input, const int input_Size)/* overload */;
	System::Variant __fastcall GetArrayIndex(int ADim);
	int __fastcall InputArgCount(void);
	System::Variant __fastcall GetInputArg(int AIndex);
	System::UnicodeString __fastcall GetInputArgAsString(int AIndex);
	System::TClass __fastcall GetInputArgAsClass(int AIndex);
	System::WideString __fastcall GetInputArgAsWideString(int AIndex);
	int __fastcall GetInputArgAsInteger(int AIndex);
	bool __fastcall GetInputArgAsBoolean(int AIndex);
	double __fastcall GetInputArgAsFloat(int AIndex);
	System::TDateTime __fastcall GetInputArgAsDateTime(int AIndex);
	void __fastcall SetInputArg(int AIndex, const System::Variant &AValue);
	void __fastcall SetInputArgIfByRef(int AIndex, const System::Variant &AValue);
	void __fastcall ReturnOutputArg(const System::Variant &AValue);
	void __fastcall GetRowColFromSource(int APos, int &row, int &col);
	void __fastcall SolveAbsoluteAddressing(void);
	void __fastcall Halt(void);
	pSimplifiedCode __fastcall InstructionByLine(int ARow);
	pSimplifiedCode __fastcall EntryPoint(System::UnicodeString ALabel);
	void __fastcall DebugTraceInto(void);
	void __fastcall DebugStepOver(void);
	void __fastcall DebugTraceIntoLine(void);
	void __fastcall DebugStepOverLine(void);
	void __fastcall DebugRunUntilReturn(void);
	void __fastcall DebugRunToPoint(pSimplifiedCode AInstruction);
	void __fastcall DebugRunToLine(int ALine);
	bool __fastcall DebugToggleBreakPoint(pSimplifiedCode AInstruction);
	pSimplifiedCode __fastcall DebugToggleBreakLine(int ALine);
	int __fastcall DebugExecutionLine(void);
	bool __fastcall ExpandedDebugInfo(void);
	void __fastcall ExpandDebugInfo(bool RequiresCompilation = true);
	TatClass* __fastcall ClassByName(System::UnicodeString AName);
	TatClass* __fastcall AddClass(System::UnicodeString AName, System::UnicodeString AAncestorName);
	TatClass* __fastcall AddDelphiClass(System::TClass AClass);
	TatClass* __fastcall DefineClass(System::TClass AClass, System::UnicodeString AClassName = L"");
	TatClass* __fastcall DefineRecord(Typinfo::PTypeInfo ATypeInfo, System::UnicodeString ARecordName = L"");
	void __fastcall AddComponent(Classes::TComponent* AComp);
	void __fastcall AddComponents(Classes::TComponent* AComp);
	TatClass* __fastcall DefineFormClass(Forms::TCustomForm* AForm, System::UnicodeString AFormClassName = L"");
	void __fastcall AddForm(Forms::TCustomForm* AForm, System::UnicodeString AFormClassName = L"");
	void __fastcall AddDataModule(Classes::TDataModule* ADataModule, System::UnicodeString ADataModuleClassName = L"");
	void __fastcall AddObject(System::UnicodeString AName, System::TObject* AObject);
	void __fastcall AddConstant(System::UnicodeString AName, const System::Variant &AValue);
	void __fastcall AddVariable(System::UnicodeString AName, System::Variant &AVar)/* overload */;
	void __fastcall AddVariable(System::UnicodeString AName, System::Extended &AVar)/* overload */;
	void __fastcall AddVariable(System::UnicodeString AName, double &AVar)/* overload */;
	void __fastcall AddVariable(System::UnicodeString AName, System::UnicodeString &AVar)/* overload */;
	void __fastcall AddVariable(System::UnicodeString AName, System::WideString &AVar)/* overload */;
	void __fastcall AddVariable(System::UnicodeString AName, int &AVar)/* overload */;
	void __fastcall AddVariable(System::UnicodeString AName, bool &AVar)/* overload */;
	void __fastcall AddEnumeration(Typinfo::PTypeInfo ATypeInfo);
	TatProperty* __fastcall DefineProp(System::UnicodeString AName, TatTypeKind ADataType, TMachineProc AGetter, TMachineProc ASetter, System::TClass APropertyClass = 0x0, bool AIsClassProp = false, int AIndexCount = 0x0);
	TatMethod* __fastcall DefineMethod(System::UnicodeString AName, int AArgCount, TatTypeKind AResultDataType, System::TClass AResultClass, TMachineProc AProc, bool AIsClassMethod = false, int ADefArgCount = 0x0);
	TatClass* __fastcall UsesObject(System::TObject* AObject, System::UnicodeString AName = L"", System::UnicodeString AClassName = L"");
	void __fastcall AddLibraryInstance(TatScripterLibrary* ALibrary, System::UnicodeString AName, bool ADefault = true, bool AddMethod = true, System::UnicodeString LibName = L"");
	void __fastcall RemoveLibraryInstance(TatScripterLibrary* ALibrary, System::UnicodeString AName);
	TatScripterLibrary* __fastcall AddLibrary(TatScripterLibraryClass ALibraryClass, bool ADefault = true);
	TatScripterLibrary* __fastcall FindLibraryByClass(TatScripterLibraryClass ALibraryClass);
	TatScripterLibrary* __fastcall LoadLibrary(System::UnicodeString ALibraryName, bool ADefault = true, bool ASilent = false);
	void __fastcall LoadLibrary2(System::UnicodeString ALibraryName, bool ADefault = true);
	void __fastcall AssignInfo(TatCustomScripter* ASourceScripter);
	bool __fastcall InProcessExecute(System::UnicodeString AScriptStub);
	System::UnicodeString __fastcall BuildEventHandlerName(Classes::TComponent* Instance, System::UnicodeString PropName);
	int __fastcall DeclareEventHandler(System::UnicodeString AProcName);
	void __fastcall GetInfoFromRoutineName(System::UnicodeString &RName, TatVirtualMachine* &AMachine);
	void __fastcall DefineClassByRTTI(System::TClass AClass, System::UnicodeString AClassName = L"", TMemberVisibilitySet AVisibilityFilter = (TMemberVisibilitySet() << Typinfo::TMemberVisibility::mvPublic << Typinfo::TMemberVisibility::mvPublished ), bool ARecursive = false, TRedefineOption ARedefine = (TRedefineOption)(0x0));
	void __fastcall DefineRecordByRTTI(void * ATypeInfo);
	__property TatScripterEventBroker* EventBroker = {read=FEventBroker};
	__property TatObjects* DefaultInstances = {read=FDefaultInstances};
	__property TatClasses* Classes = {read=FClasses, write=SetClasses};
	TatClass* __fastcall SystemLibrary(void);
	__property Classes::TStrings* SourceCode = {read=GetSourceCode, write=SetSourceCode};
	__property System::UnicodeString LastExceptionMessage = {read=GetLastExceptionMessage};
	__property int LastExceptionHelpContext = {read=GetLastExceptionHelpContext, nodefault};
	__property System::UnicodeString LastExceptionClassName = {read=GetLastExceptionClassName};
	__property TatScriptInfo* ScriptInfo = {read=GetScriptInfo};
	__property System::TObject* CurrentObject = {read=GetCurrentObject};
	__property TatClass* CurrentClass = {read=GetCurrentClass};
	__property bool Compiled = {read=GetCompiled, write=SetCompiled, stored=DoSaveCompiledCode, nodefault};
	__property bool SaveCompiledCode = {read=FSaveCompiledCode, write=FSaveCompiledCode, nodefault};
	__property bool SilentCompiled = {read=GetSilentCompiled, write=SetSilentCompiled, nodefault};
	__property Classes::TMemoryStream* PCode = {read=FPCode, write=FPCode};
	__property TatScriptBreakPoints* BreakPoints = {read=GetBreakPoints};
	__property bool Halted = {read=GetHalted, nodefault};
	__property bool Running = {read=GetRunning, write=SetRunning, nodefault};
	__property bool Paused = {read=GetPaused, write=SetPaused, nodefault};
	__property bool CallExecHookEvent = {read=GetCallExecHookEvent, write=SetCallExecHookEvent, nodefault};
	__property pSimplifiedCode FirstInstruction = {read=GetFirstInstruction};
	__property Classes::TNotifyEvent OnDebugHook = {read=FOnDebugHook, write=FOnDebugHook};
	__property Classes::TNotifyEvent OnSingleDebugHook = {read=FOnSingleDebugHook, write=FOnSingleDebugHook};
	__property Classes::TNotifyEvent OnExecHook = {read=GetOnExecHook, write=SetOnExecHook};
	__property Classes::TNotifyEvent OnPauseChanged = {read=GetOnPauseChanged, write=SetOnPauseChanged};
	__property Classes::TNotifyEvent OnRunningChanged = {read=FOnRunningChanged, write=FOnRunningChanged};
	__property pSimplifiedCode NextInstruction = {read=GetNextInstruction};
	__property TatScript* CurrentScript = {read=FCurrentScript, write=FCurrentScript};
	__property TatScript* CurrentDebugScript = {read=GetCurrentDebugScript};
	__property TScriptFormClass ScriptFormClass = {read=FScriptFormClass, write=SetScriptFormClass};
	__property TatScripts* Scripts = {read=FScripts};
	__property bool OptionExplicit = {read=FOptionExplicit, write=FOptionExplicit, nodefault};
	__property TatScripterWatches* Watches = {read=FWatches};
	__property TScriptErrorEvent OnCompileError = {read=FOnCompileError, write=FOnCompileError};
	__property TScriptErrorEvent OnRuntimeError = {read=FOnRuntimeError, write=FOnRuntimeError};
	__property bool DeferObjectResolution = {read=FDeferObjectResolution, write=FDeferObjectResolution, nodefault};
	__property TBeforeExecuteEvent OnBeforeExecute = {read=FOnBeforeExecute, write=SetOnBeforeExecute};
	__property bool ShortBooleanEval = {read=FShortBooleanEval, write=FShortBooleanEval, nodefault};
	__property bool AllowDLLCalls = {read=FAllowDLLCalls, write=FAllowDLLCalls, nodefault};
	__property TScripterLibraryOptions* LibOptions = {read=FLibOptions, write=SetLibOptions};
	__property TUnknownElementEvent OnUnknownElement = {read=FOnUnknownElement, write=FOnUnknownElement};
	__property bool LoadFormEvents = {read=FLoadFormEvents, write=FLoadFormEvents, nodefault};
	__property Classes::TNotifyEvent OnBreakpointStop = {read=FOnBreakpointStop, write=FOnBreakpointStop};
};


class DELPHICLASS TatScripterWatch;
class PASCALIMPLEMENTATION TatScripterWatches : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TatScripterWatch* operator[](int i) { return Items[i]; }
	
private:
	HIDESBASE TatScripterWatch* __fastcall GetItem(int i);
	TatCustomScripter* __fastcall Scripter(void);
	
public:
	HIDESBASE TatScripterWatch* __fastcall Add(void);
	__property TatScripterWatch* Items[int i] = {read=GetItem/*, default*/};
	void __fastcall EvaluateAll(void);
public:
	/* TOwnedCollection.Create */ inline __fastcall TatScripterWatches(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatScripterWatches(void) { }
	
};


class PASCALIMPLEMENTATION TatScripterWatch : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FExpression;
	TatScript* FDebugScript;
	bool FEnabled;
	TWatchStatus FWatchStatus;
	System::Variant FLastResult;
	void __fastcall SetExpression(const System::UnicodeString Value);
	void __fastcall ScriptDestroyed(System::TObject* Sender);
	TatScripterWatches* __fastcall Watches(void);
	TatCustomScripter* __fastcall Scripter(void);
	void __fastcall Reset(void);
	void __fastcall InternalEvaluate(TatVirtualMachine* AMachine);
	
public:
	__fastcall virtual TatScripterWatch(Classes::TCollection* ACollection);
	__fastcall virtual ~TatScripterWatch(void);
	void __fastcall Evaluate(void);
	__property System::UnicodeString Expression = {read=FExpression, write=SetExpression};
	__property TWatchStatus WatchStatus = {read=FWatchStatus, nodefault};
	__property System::Variant LastResult = {read=FLastResult};
	__property bool Enabled = {read=FEnabled, write=FEnabled, nodefault};
};


class PASCALIMPLEMENTATION TatScripts : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TatScript* operator[](int i) { return Items[i]; }
	
private:
	TatCustomScripter* FScripter;
	HIDESBASE TatScript* __fastcall GetItem(int i);
	
public:
	__fastcall TatScripts(TatCustomScripter* AScripter);
	HIDESBASE TatScript* __fastcall Add(void);
	TatScript* __fastcall FindByUnitName(System::UnicodeString AUnitName);
	__property TatScript* Items[int i] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatScripts(void) { }
	
};


class DELPHICLASS TScriptForm;
class PASCALIMPLEMENTATION TScriptForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	TatScript* FRunScript;
	TatScript* FDesignScript;
	Classes::TStrings* FSaveProps;
	Classes::TStrings* FSaveEvents;
	System::UnicodeString FLastSearchedMethod;
	void __fastcall LoadFormResource(System::UnicodeString AFormRes, bool ALoadEvents);
	void __fastcall NewFormInstance(TatVirtualMachine* AMachine);
	void __fastcall RestoreSavedProps(void);
	void __fastcall SetSaveProps(const Classes::TStrings* Value);
	void __fastcall SetSaveEvents(const Classes::TStrings* Value);
	void __fastcall RestoreSavedEvents(void);
	void __fastcall ReaderFindMethod(Classes::TReader* Reader, const System::UnicodeString MethodName, void * &Address, bool &Error);
	void __fastcall ReaderError(Classes::TReader* Reader, const System::UnicodeString Message, bool &Handled);
	
protected:
	__property TatScript* RunScript = {read=FRunScript, write=FRunScript};
	
public:
	__fastcall virtual TScriptForm(Classes::TComponent* AOwner);
	__fastcall virtual TScriptForm(Classes::TComponent* AOwner, int Dummy);
	__fastcall virtual TScriptForm(Classes::TComponent* AOwner, TatVirtualMachine* AMachine);
	__fastcall virtual ~TScriptForm(void);
	DYNAMIC bool __fastcall IsShortCut(Messages::TWMKey &Message);
	__property TatScript* DesignScript = {read=FDesignScript, write=FDesignScript};
	
__published:
	__property Classes::TStrings* SaveProps = {read=FSaveProps, write=SetSaveProps};
	__property Classes::TStrings* SaveEvents = {read=FSaveEvents, write=SetSaveEvents};
	__property Visible = {stored=false, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TScriptForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TatScriptRefactor;
class DELPHICLASS TatRoutineInfo;
class PASCALIMPLEMENTATION TatScriptRefactor : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TatScript* FScript;
	bool FDirtySource;
	System::UnicodeString FUpcaseSource;
	Classes::TStrings* __fastcall GetSource(void);
	System::UnicodeString __fastcall GetUpcaseSource(void);
	
protected:
	__property Classes::TStrings* Source = {read=GetSource};
	__property System::UnicodeString UpcaseSource = {read=GetUpcaseSource};
	int __fastcall SourcePos(System::UnicodeString SubStr, int FromPos = 0x1);
	
public:
	__fastcall TatScriptRefactor(TatScript* AScript);
	void __fastcall BeginRefactor(void);
	void __fastcall EndRefactor(void);
	virtual void __fastcall UpdateFormHeader(System::UnicodeString AFormClass, System::UnicodeString AFileName);
	int __fastcall DeclareRoutine(System::UnicodeString ProcName)/* overload */;
	virtual int __fastcall DeclareRoutine(TatRoutineInfo* AInfo)/* overload */;
	virtual void __fastcall AddUsedUnit(System::UnicodeString AUnitName);
	__property TatScript* Script = {read=FScript};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TatScriptRefactor(void) { }
	
};


typedef TMetaClass* TRefactorClass;

class DELPHICLASS TatScriptBreak;
class DELPHICLASS TatScriptBreakPoint;
class PASCALIMPLEMENTATION TatScriptBreak : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FLine;
	Contnrs::TObjectList* FBreakList;
	bool FAutoDestroy;
	TatScript* __fastcall Script(void);
	void __fastcall SetLine(const int Value);
	void __fastcall UpdateBreakPoints(void);
	void __fastcall BreakpointDestroyed(TatScriptBreakPoint* ABreakPoint);
	void __fastcall RemoveBreakPoints(void);
	void __fastcall TemporaryBreakProc(void);
	
public:
	__fastcall virtual TatScriptBreak(Classes::TCollection* Collection);
	__fastcall virtual ~TatScriptBreak(void);
	__property int Line = {read=FLine, write=SetLine, nodefault};
	__property bool AutoDestroy = {read=FAutoDestroy, nodefault};
};


class DELPHICLASS TatScriptBreaks;
class PASCALIMPLEMENTATION TatScriptBreaks : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TatScriptBreak* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TatScriptBreak* __fastcall GetItem(int Index);
	TatScript* __fastcall Script(void);
	void __fastcall UpdateAll(void);
	
public:
	void __fastcall ToggleBreak(int ALine);
	TatScriptBreak* __fastcall FindByLine(int ALine);
	HIDESBASE TatScriptBreak* __fastcall Add(void);
	__property TatScriptBreak* Items[int Index] = {read=GetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TatScriptBreaks(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatScriptBreaks(void) { }
	
};


class DELPHICLASS TatVirtualMachines;
class DELPHICLASS TatUsedUnits;
class DELPHICLASS TatVariableInfo;
class PASCALIMPLEMENTATION TatScript : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TatCustomScripter* FScripter;
	Atparser::TatSyntaxParser* FParser;
	TatVirtualMachines* FVirtualMachines;
	TatVirtualMachine* FVirtualMachine;
	System::StaticArray<pStackElement, 4> FStack;
	int FCodeLine;
	TLabelSpec *FFirstLabelSpec;
	TLabelSpec *FLastLabelSpec;
	TatRoutineInfo* FCurrentRoutine;
	bool FIsDebugScript;
	TatRoutineInfo* FDebugScriptMainRoutine;
	Classes::TStrings* FSourceCode;
	TSimplifiedCode *FFirstInstruction;
	TSimplifiedCode *FLastInstruction;
	TatScriptInfo* FScriptInfo;
	bool FCompiled;
	bool FSilentCompiled;
	bool FSolvedAddressing;
	bool FExpandedDebugInfo;
	TatUsedUnits* FUsedUnits;
	int FCounterInit;
	Classes::TNotifyEvent FOnDestroy;
	bool FRollbackSourceCode;
	Classes::TList* FLibraries;
	bool FSilentCompilation;
	System::UnicodeString FFileName;
	System::UnicodeString FUnitName;
	bool FLoadedDLL;
	TatObjects* FDefInstances;
	TatObject* FIntInstance;
	TScriptForm* FScriptForm;
	TatScriptRefactor* FRefactor;
	TRefactorClass FRefactorClass;
	TScriptForm* FDesignScriptForm;
	System::UnicodeString FDesignFormResource;
	Classes::TStream* FCodeStream;
	TatScriptBreaks* FBreaks;
	TatScript* FOriginalScript;
	Contnrs::TObjectList* FDerivedScripts;
	bool FCompiling;
	TScriptForm* FOriginalForm;
	bool FClearingScript;
	int FRefactoring;
	void __fastcall InternalCompile(bool Silent);
	void __fastcall DisposeDLL(void);
	void __fastcall RemoveAttachedEvents(bool RemoveAll);
	System::UnicodeString __fastcall GetFormFileAsString(System::UnicodeString AFormFile);
	void __fastcall InternalSaveCodeToStream(Classes::TStream* AStream);
	void __fastcall SetCompiled(const bool Value);
	bool __fastcall CheckRegisteredAsLibrary(TatCustomScripter* AScripter, TatScripterLibrary* &ALib);
	void __fastcall SetOriginalScript(TatScript* AScript);
	void __fastcall UnregisterForm(void);
	void __fastcall DoBreakpointStop(void);
	TatClass* __fastcall _FindClass(int idx, System::UnicodeString AName);
	TatMethod* __fastcall _FindMethod(TatClass* AClass, int idx, System::UnicodeString AName);
	TatProperty* __fastcall _FindProperty(TatClass* AClass, int idx, System::UnicodeString AName);
	void __fastcall InternalLoadCodeFromStream(Classes::TStream* AStream, bool ARegisterForm);
	void __fastcall GetRowColFromInst(pSimplifiedCode Inst, int &Row, int &Col);
	
protected:
	void __fastcall DoUnknownElement(TElementContext &Context);
	void __fastcall CompileError(System::UnicodeString msg, int debuginfo)/* overload */;
	void __fastcall CompileError(System::UnicodeString msg, int row, int col)/* overload */;
	void __fastcall RuntimeError(System::UnicodeString msg);
	void __fastcall StackPush(TStackType StackType, const System::Variant &x);
	void __fastcall StackPushDelimitter(TStackType StackType);
	bool __fastcall EmptyStack(TStackType StackType);
	System::Variant __fastcall StackPop(TStackType StackType);
	System::Variant __fastcall StackView(TStackType StackType);
	int __fastcall StackIndex(TStackType StackType);
	bool __fastcall StackDelimitterFound(TStackType StackType);
	System::Variant __fastcall StackGetByIndex(TStackType st, int i);
	int __fastcall IndexOfStackTextValue(TStackType st, System::UnicodeString s);
	pStackElement __fastcall GetStack(TStackType st);
	void __fastcall ClearStacks(void);
	pLabelSpec __fastcall NewLabelSpec(System::UnicodeString Name);
	pLabelSpec __fastcall FindLabelSpec(System::UnicodeString name);
	int __fastcall RegisterReference(System::UnicodeString Name);
	void __fastcall SolveReference(pLabelSpec LabelSpec);
	void __fastcall DefineReferenceAddress(System::UnicodeString Name);
	void __fastcall ClearLabelSpecs(void);
	void __fastcall SolveUndefinedReferences(void);
	TatVariableInfo* __fastcall RegisterVariableReference(System::UnicodeString id);
	TatVariableInfo* __fastcall DeclareVariable(System::UnicodeString AName, int AArgIndex = 0xffffffff, TatArgumentModifier AModifier = (TatArgumentModifier)(0x0), bool AGlobal = false, int ASourcePos = 0xffffffff);
	pSimplifiedCode __fastcall AppendInstruction(TInstruction i)/* overload */;
	pSimplifiedCode __fastcall RemoveLastInstruction(void);
	void __fastcall AppendInstruction(pSimplifiedCode AInstruction)/* overload */;
	void __fastcall OptimizeStoreVar(TatVariableInfo* AVar, bool AIgnoreConstant = false);
	void __fastcall OptimizeVarTest(int ACaseVarIndex, System::UnicodeString ACaseVarName, System::UnicodeString AJumpLabel, bool ACondition);
	void __fastcall SetSourceCode(Classes::TStrings* value);
	System::UnicodeString __fastcall ErrorComplement(int APos);
	void __fastcall SourceCodeChange(System::TObject* Sender);
	void __fastcall DisposeCode(pSimplifiedCode &code);
	void __fastcall RelativeMethodRef(TatMethod* AMethod, pSimplifiedCode AInst);
	void __fastcall RelativeGetterRef(TatProperty* AProperty, pSimplifiedCode AInst);
	void __fastcall RelativeSetterRef(TatProperty* AProperty, pSimplifiedCode AInst);
	__property int CodeLine = {read=FCodeLine, write=FCodeLine, nodefault};
	__property pSimplifiedCode LastInstruction = {read=FLastInstruction, write=FLastInstruction};
	__property TatRoutineInfo* CurrentRoutine = {read=FCurrentRoutine, write=FCurrentRoutine};
	__property int CounterInit = {read=FCounterInit, write=FCounterInit, nodefault};
	__property TatRoutineInfo* DebugScriptMainRoutine = {read=FDebugScriptMainRoutine, write=FDebugScriptMainRoutine};
	__property bool IsDebugScript = {read=FIsDebugScript, write=FIsDebugScript, nodefault};
	__property TRefactorClass RefactorClass = {read=FRefactorClass, write=FRefactorClass};
	virtual System::UnicodeString __fastcall EncodeSingleAssign(System::UnicodeString AVarName, System::UnicodeString AExpression) = 0 ;
	virtual int __fastcall DeclareEventHandler(System::UnicodeString AProcName);
	TatScripterLibrary* __fastcall SelfRegisterAsLibrary(TatCustomScripter* AScripter, System::UnicodeString AName, System::TClass AClassRef, System::UnicodeString AClassName, bool ADefault, bool AddMethod)/* overload */;
	void __fastcall CompileForm(System::UnicodeString AFormClassName, System::UnicodeString AFormFile);
	void __fastcall RegisterForm(void);
	
public:
	__fastcall virtual TatScript(Classes::TCollection* ACollection);
	__fastcall virtual ~TatScript(void);
	virtual void __fastcall Clear(void);
	virtual void __fastcall Compile(void);
	void __fastcall SilentCompile(void);
	void __fastcall ExpandDebugInfo(bool RequiresCompilation = true);
	void __fastcall GetRowColFromSource(int APos, int &row, int &col);
	void __fastcall LoadCodeFromFile(System::UnicodeString AFileName);
	void __fastcall SaveCodeToFile(System::UnicodeString AFileName);
	virtual void __fastcall LoadCodeFromStream(Classes::TStream* AStream);
	virtual void __fastcall SaveCodeToStream(Classes::TStream* AStream);
	bool __fastcall IsRegisteredAsLibrary(TatCustomScripter* AScripter);
	TatScripterLibrary* __fastcall SelfRegisterAsLibrary(TatCustomScripter* AScripter, System::UnicodeString AName = L"")/* overload */;
	TatScripterLibrary* __fastcall SelfRegisterAsLibrary(System::UnicodeString AName = L"")/* overload */;
	void __fastcall SelfUnregisterAsLibrary(TatCustomScripter* AScripter, System::UnicodeString AName = L"")/* overload */;
	void __fastcall SelfUnregisterAsLibrary(System::UnicodeString AName = L"")/* overload */;
	TatScripterLibrary* __fastcall LoadLibrary(System::UnicodeString ALibraryName, bool ADefault = true);
	TatClass* __fastcall UsesObject(System::TObject* AObject, System::UnicodeString AName = L"", System::UnicodeString AClassName = L"");
	void __fastcall UnuseObject(System::UnicodeString AClassName);
	void __fastcall AddObject(System::UnicodeString AName, System::TObject* AObject);
	void __fastcall RemoveObject(System::UnicodeString AName);
	__property TatUsedUnits* UsedUnits = {read=FUsedUnits};
	__property TatVirtualMachine* VirtualMachine = {read=FVirtualMachine, write=FVirtualMachine};
	__property TatVirtualMachines* VirtualMachines = {read=FVirtualMachines};
	__property TatCustomScripter* Scripter = {read=FScripter};
	__property Classes::TStrings* SourceCode = {read=FSourceCode, write=SetSourceCode};
	__property TatScriptInfo* ScriptInfo = {read=FScriptInfo};
	__property bool Compiled = {read=FCompiled, write=SetCompiled, nodefault};
	__property bool SilentCompiled = {read=FSilentCompiled, write=FSilentCompiled, nodefault};
	__property pSimplifiedCode FirstInstruction = {read=FFirstInstruction};
	__property bool ExpandedDebugInfo = {read=FExpandedDebugInfo, nodefault};
	__property Atparser::TatSyntaxParser* Parser = {read=FParser};
	__property TatObjects* DefInstances = {read=FDefInstances};
	__property TatObject* IntInstance = {read=FIntInstance};
	__property TatScriptRefactor* Refactor = {read=FRefactor};
	__property TScriptForm* DesignScriptForm = {read=FDesignScriptForm, write=FDesignScriptForm};
	__property System::UnicodeString DesignFormResource = {read=FDesignFormResource, write=FDesignFormResource};
	__property System::UnicodeString UnitName = {read=FUnitName, write=FUnitName};
	__property TatScriptBreaks* Breaks = {read=FBreaks};
	__property Classes::TNotifyEvent OnDestroy = {read=FOnDestroy, write=FOnDestroy};
};


class PASCALIMPLEMENTATION TatVirtualMachines : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TatVirtualMachine* operator[](int i) { return Items[i]; }
	
private:
	TatVirtualMachine* __fastcall GetItems(int i);
	
public:
	HIDESBASE TatVirtualMachine* __fastcall Add(void);
	__property TatVirtualMachine* Items[int i] = {read=GetItems/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TatVirtualMachines(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatVirtualMachines(void) { }
	
};


class DELPHICLASS TatDebugWatches;
class PASCALIMPLEMENTATION TatVirtualMachine : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	typedef System::StaticArray<System::Variant, 3000> _TatVirtualMachine__1;
	
	
private:
	TatScript* FScript;
	TatCustomScripter* FScripter;
	Classes::TNotifyEvent FOnExecHook;
	Classes::TNotifyEvent FOnPauseChanged;
	Classes::TNotifyEvent FOnRunningChanged;
	System::TObject* FCurrentObject;
	TatClass* FCurrentClass;
	System::UnicodeString FCurrentRecordName;
	System::Variant FCurrentOleObject;
	_TatVirtualMachine__1 FProcStack;
	int FStackTop;
	int FStackBase;
	int FInputBase;
	int FOutputBase;
	int FInputOffset;
	int FOutputOffset;
	int FCurrentInputArgBase;
	int FCurrentArrayIndexBase;
	int FCurrentOutputArgIndex;
	TSimplifiedCode *FNextInstruction;
	TSimplifiedCode *FCurrentInstruction;
	System::UnicodeString FLastExceptionMessage;
	int FLastExceptionHelpContext;
	System::UnicodeString FLastExceptionClassName;
	TSimplifiedCode *FPrepareInstruction;
	TatScriptBreakPoints* FBreakPoints;
	bool FHalted;
	bool FRunning;
	bool FPaused;
	bool FCallExecHookEvent;
	System::StaticArray<TGenericProc, 79> FComputeProcs;
	TSimplifiedCode *FMainBegin;
	int FInitialStackTop;
	TatDebugWatches* FDebugWatches;
	TSimplifiedCode *FStopInstruction;
	int FHooking;
	Forms::TExceptionEvent FOldOnException;
	Sysutils::Exception* FExceptionRaised;
	bool FInitialized;
	int FInTryExcept;
	bool FFastSolving;
	bool FAutoPause;
	int FAutoPauseCurLine;
	int __fastcall ExecProcess(int ParamCount);
	void __fastcall _GlobalPrepare(void);
	void __fastcall _Prepare(void);
	void __fastcall _PushDouble(void);
	void __fastcall _PushVar(void);
	void __fastcall _PushIdxVar(void);
	void __fastcall _PushVarByRef(void);
	void __fastcall _PushString(void);
	void __fastcall _PushOutput(void);
	void __fastcall _PushConst(void);
	void __fastcall _Duplicate(void);
	void __fastcall _Duplicate2(void);
	void __fastcall _Drop2(void);
	void __fastcall _Swap2(void);
	void __fastcall _OperNE(void);
	void __fastcall _OperGE(void);
	void __fastcall _OperLE(void);
	void __fastcall _OperEqual(void);
	void __fastcall _OperGreater(void);
	void __fastcall _OperLess(void);
	void __fastcall _OperAdd(void);
	void __fastcall _OperConcat(void);
	void __fastcall _OperSub(void);
	void __fastcall _OperOr(void);
	void __fastcall _OperXor(void);
	void __fastcall _OperMul(void);
	void __fastcall _OperSlash(void);
	void __fastcall _OperDiv(void);
	void __fastcall _OperMod(void);
	void __fastcall _OperAnd(void);
	void __fastcall _OperShl(void);
	void __fastcall _OperShr(void);
	void __fastcall _OperExp(void);
	void __fastcall _OperNeg(void);
	void __fastcall _OperNot(void);
	void __fastcall _JumpIfFalse(void);
	void __fastcall _JumpIfTrue(void);
	void __fastcall _Jump(void);
	void __fastcall _StoreVar(void);
	void __fastcall _StoreIdxVar(void);
	void __fastcall _StoreVarInteger(void);
	void __fastcall _StoreVarDouble(void);
	void __fastcall _StoreVarString(void);
	void __fastcall _StoreVarConst(void);
	void __fastcall _CopyVar(void);
	void __fastcall _StoreVarRef(void);
	void __fastcall _StoreIdxVarRef(void);
	void __fastcall _StoreVarRefInteger(void);
	void __fastcall _StoreVarRefDouble(void);
	void __fastcall _StoreVarRefString(void);
	void __fastcall _StoreVarRefConst(void);
	void __fastcall _CopyVarRef(void);
	void __fastcall _Call(void);
	void __fastcall _Ret(void);
	void __fastcall _StoreInput(void);
	void __fastcall _ExecFun(void);
	void __fastcall _PushInteger(void);
	void __fastcall _TryFinally(void);
	void __fastcall _TryExcept(void);
	void __fastcall _CallProc(void);
	void __fastcall _CallClassProc(void);
	void __fastcall _BreakPoint(void);
	void __fastcall _VarTest(void);
	void __fastcall _VarTestInteger(void);
	void __fastcall _VarTestDouble(void);
	void __fastcall _VarTestString(void);
	void __fastcall _VarTestVar(void);
	void __fastcall _Abort(void);
	void __fastcall _ArrayOf(void);
	void __fastcall _CastClass(void);
	void __fastcall _OperIs(void);
	void __fastcall _PushClass(void);
	void __fastcall _WithObject(void);
	void __fastcall _StoreGlobalVar(void);
	void __fastcall _StoreGlobalIdxVar(void);
	void __fastcall _PushGlobalVar(void);
	void __fastcall _PushGlobalIdxVar(void);
	void __fastcall _PushGlobalVarByRef(void);
	void __fastcall _TestIfFalse(void);
	void __fastcall _TestIfTrue(void);
	void __fastcall UndefinedGetterProc(void);
	void __fastcall UndefinedSetterProc(void);
	void __fastcall UndefinedMethodProc(void);
	void __fastcall SetRunning(const bool Value);
	void __fastcall SetPaused(const bool Value);
	bool __fastcall HandleScriptRunException(Sysutils::Exception* ex);
	void __fastcall DoDebugHook(void);
	void __fastcall DoExecHook(void);
	System::UnicodeString __fastcall GetStackContentAsString(void);
	System::Variant __fastcall SetVarArrayElement(const System::Variant &v, int ADim);
	System::Variant __fastcall GetVarArrayElement(const System::Variant &v, int ADim);
	System::Variant __fastcall InternalExecuteSubroutine(pSimplifiedCode AInstruction, int AInputParamCount = 0x0);
	void __fastcall CompileDebugScript(TatScript* AScript);
	void __fastcall ExecuteDebugScript(TatScript* AScript);
	void __fastcall CheckHalted(void);
	void __fastcall AppException(System::TObject* Sender, Sysutils::Exception* E);
	void __fastcall InitializeScript(bool ADoBeforeExecute);
	void __fastcall RuntimeError(System::UnicodeString msg);
	System::TClass __fastcall TranslateClass(int AClassIndex);
	Classes::TNotifyEvent __fastcall GetOnDebugHook(void);
	void __fastcall SetOnDebugHook(const Classes::TNotifyEvent Value);
	
protected:
	virtual void __fastcall DoRunningChanged(void);
	
public:
	__fastcall virtual TatVirtualMachine(Classes::TCollection* ACollection);
	__fastcall virtual ~TatVirtualMachine(void);
	void __fastcall Clear(void);
	virtual void __fastcall SolveAbsoluteAddressing(void);
	void __fastcall InProcessExecute(System::UnicodeString AScriptStr);
	virtual System::Variant __fastcall Execute(const System::Variant &input)/* overload */;
	virtual System::Variant __fastcall Execute(void)/* overload */;
	System::Variant __fastcall ExecuteSubroutine(System::UnicodeString ALabel, const System::Variant &input)/* overload */;
	System::Variant __fastcall ExecuteSubroutine(System::UnicodeString ALabel)/* overload */;
	System::Variant __fastcall ExecuteSubroutine(System::UnicodeString ALabel, System::TVarRec *input, const int input_Size)/* overload */;
	System::Variant __fastcall ExecuteSubroutineEx(System::UnicodeString ALabel, System::TVarRec *input, const int input_Size);
	System::Variant __fastcall GetArrayIndex(int ADim);
	int __fastcall InputArgCount(void);
	System::Variant __fastcall GetInputArg(int AIndex);
	System::UnicodeString __fastcall GetInputArgAsString(int AIndex);
	System::TClass __fastcall GetInputArgAsClass(int AIndex);
	System::WideString __fastcall GetInputArgAsWidestring(int AIndex);
	int __fastcall GetInputArgAsInteger(int AIndex);
	bool __fastcall GetInputArgAsBoolean(int AIndex);
	double __fastcall GetInputArgAsFloat(int AIndex);
	System::TDateTime __fastcall GetInputArgAsDateTime(int AIndex);
	System::WideChar __fastcall GetInputArgAsChar(int AIndex);
	System::WideChar __fastcall GetInputArgAsWideChar(int AIndex);
	void __fastcall SetInputArg(int AIndex, const System::Variant &AValue);
	void __fastcall SetInputArgIfByRef(int AIndex, const System::Variant &AValue);
	void __fastcall SetInputArgValue(int AIndex, const Rtti::TValue &AValue);
	void __fastcall ReturnOutputArg(const System::Variant &AValue);
	void __fastcall ReturnOutputArgValue(const Rtti::TValue &AValue);
	void __fastcall Halt(void);
	pSimplifiedCode __fastcall InstructionByLine(int ARow);
	pSimplifiedCode __fastcall EntryPoint(System::UnicodeString ALabel);
	void __fastcall DebugTraceInto(void);
	void __fastcall DebugStepOver(void);
	void __fastcall DebugTraceIntoLine(void);
	void __fastcall DebugStepOverLine(void);
	void __fastcall DebugRunUntilReturn(void);
	void __fastcall DebugRunToPoint(pSimplifiedCode AInstruction);
	void __fastcall DebugRunToLine(int ALine);
	bool __fastcall DebugToggleBreakPoint(pSimplifiedCode AInstruction);
	pSimplifiedCode __fastcall DebugToggleBreakLine(int ALine);
	int __fastcall DebugExecutionLine(void);
	System::UnicodeString __fastcall CurrentPropertyName(void);
	System::UnicodeString __fastcall CurrentMethodName(void);
	__property TatScript* Script = {read=FScript};
	__property TatCustomScripter* Scripter = {read=FScripter};
	__property System::UnicodeString LastExceptionMessage = {read=FLastExceptionMessage};
	__property int LastExceptionHelpContext = {read=FLastExceptionHelpContext, nodefault};
	__property System::UnicodeString LastExceptionClassName = {read=FLastExceptionClassName};
	__property System::TObject* CurrentObject = {read=FCurrentObject};
	__property TatClass* CurrentClass = {read=FCurrentClass};
	__property TatScriptBreakPoints* BreakPoints = {read=FBreakPoints, write=FBreakPoints};
	__property bool Halted = {read=FHalted, nodefault};
	__property bool Running = {read=FRunning, write=SetRunning, nodefault};
	__property bool Paused = {read=FPaused, write=SetPaused, nodefault};
	__property bool CallExecHookEvent = {read=FCallExecHookEvent, write=FCallExecHookEvent, nodefault};
	__property Classes::TNotifyEvent OnDebugHook = {read=GetOnDebugHook, write=SetOnDebugHook};
	__property Classes::TNotifyEvent OnExecHook = {read=FOnExecHook, write=FOnExecHook};
	__property Classes::TNotifyEvent OnPauseChanged = {read=FOnPauseChanged, write=FOnPauseChanged};
	__property Classes::TNotifyEvent OnRunningChanged = {read=FOnRunningChanged, write=FOnRunningChanged};
	__property pSimplifiedCode CurrentInstruction = {read=FCurrentInstruction};
	__property pSimplifiedCode NextInstruction = {read=FNextInstruction, write=FNextInstruction};
	__property pSimplifiedCode PrepareInstruction = {read=FPrepareInstruction};
	__property TatDebugWatches* DebugWatches = {read=FDebugWatches};
};


class DELPHICLASS TatRoutinesInfo;
class DELPHICLASS TatVariablesInfo;
class PASCALIMPLEMENTATION TatScriptInfo : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TatRoutinesInfo* FRoutines;
	int FCodeSize;
	TatVariablesInfo* FGlobals;
	TatScript* FScript;
	TatRoutineInfo* FMainRoutine;
	System::UnicodeString FScriptClassName;
	System::UnicodeString FFormResource;
	bool FIsForm;
	System::UnicodeString FUnitName;
	void __fastcall UpdateRoutineInfoPointers(void);
	void __fastcall SetGlobals(const TatVariablesInfo* Value);
	void __fastcall SetRoutines(const TatRoutinesInfo* Value);
	System::UnicodeString __fastcall GetMainRoutineName(void);
	void __fastcall SetMainRoutineName(const System::UnicodeString Value);
	
public:
	__fastcall virtual TatScriptInfo(Classes::TComponent* AOwner);
	__fastcall virtual ~TatScriptInfo(void);
	void __fastcall Clear(void);
	TatRoutineInfo* __fastcall RoutineByName(System::UnicodeString AName);
	TatRoutineInfo* __fastcall DeclareRoutine(System::UnicodeString AName, pSimplifiedCode ADeclInst, bool AIsFunction);
	__property int CodeSize = {read=FCodeSize, nodefault};
	__property TatScript* Script = {read=FScript};
	__property TatRoutineInfo* MainRoutine = {read=FMainRoutine, write=FMainRoutine};
	
__published:
	__property TatRoutinesInfo* Routines = {read=FRoutines, write=SetRoutines};
	__property TatVariablesInfo* Globals = {read=FGlobals, write=SetGlobals};
	__property System::UnicodeString MainRoutineName = {read=GetMainRoutineName, write=SetMainRoutineName};
	__property System::UnicodeString ScriptClassName = {read=FScriptClassName, write=FScriptClassName};
	__property System::UnicodeString FormResource = {read=FFormResource, write=FFormResource};
	__property bool IsForm = {read=FIsForm, write=FIsForm, nodefault};
	__property System::UnicodeString UnitName = {read=FUnitName, write=FUnitName};
};


class PASCALIMPLEMENTATION TatRoutinesInfo : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TatRoutineInfo* operator[](int i) { return Items[i]; }
	
private:
	TatScriptInfo* FScriptInfo;
	HIDESBASE TatRoutineInfo* __fastcall GetItem(int i);
	
public:
	int __fastcall IndexOf(System::UnicodeString AName);
	void __fastcall GetNames(Classes::TStrings* AStrings);
	__property TatRoutineInfo* Items[int i] = {read=GetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TatRoutinesInfo(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatRoutinesInfo(void) { }
	
};


#pragma option push -b-
enum TatRoutineVisibility { rvPublic, rvPrivate };
#pragma option pop

class PASCALIMPLEMENTATION TatRoutineInfo : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TatVariablesInfo* FVariables;
	System::UnicodeString FName;
	TSimplifiedCode *FDeclarationInstruction;
	bool FIsFunction;
	int FArgCount;
	int FByRefArgMask;
	int FResultIndex;
	TatRoutineInfo* FPrototype;
	TatCallingConvention FCallingConvention;
	System::UnicodeString FExternalDll;
	System::UnicodeString FExternalName;
	System::UnicodeString FResultTypeDecl;
	TatClass* FResultClass;
	TatRoutineVisibility FVisibility;
	void __fastcall SetVariables(const TatVariablesInfo* Value);
	TatTypeKind __fastcall ResultTypeKind(void);
	TatClass* __fastcall ResultClass(void);
	System::TClass __fastcall ResultClassRef(void);
	void __fastcall DispatchDllCall(TatVirtualMachine* AMachine);
	System::UnicodeString __fastcall GetResultTypeDecl(void);
	void __fastcall SetResultTypeDecl(const System::UnicodeString Value);
	void __fastcall SetTypeFromString(System::UnicodeString ATypeStr);
	
public:
	__fastcall virtual TatRoutineInfo(Classes::TCollection* ACollection);
	__fastcall virtual ~TatRoutineInfo(void);
	virtual void __fastcall Assign(Classes::TPersistent* ASource);
	TatScriptInfo* __fastcall ScriptInfo(void);
	TatVariableInfo* __fastcall VariableByName(System::UnicodeString AName);
	int __fastcall LocalVarCount(void);
	TatVariableInfo* __fastcall DeclareVariable(System::UnicodeString AName, int ASourcePos, int AArgIndex = 0xffffffff, TatArgumentModifier AModifier = (TatArgumentModifier)(0x0));
	__property pSimplifiedCode DeclarationInstruction = {read=FDeclarationInstruction, write=FDeclarationInstruction};
	__property TatRoutineInfo* Prototype = {read=FPrototype, write=FPrototype};
	void __fastcall PrepareExternalClass(void);
	bool __fastcall Internal(void);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property TatVariablesInfo* Variables = {read=FVariables, write=SetVariables};
	__property bool IsFunction = {read=FIsFunction, write=FIsFunction, nodefault};
	__property int ArgCount = {read=FArgCount, write=FArgCount, nodefault};
	__property int ByRefArgMask = {read=FByRefArgMask, write=FByRefArgMask, nodefault};
	__property int ResultIndex = {read=FResultIndex, write=FResultIndex, nodefault};
	__property TatCallingConvention CallingConvention = {read=FCallingConvention, write=FCallingConvention, nodefault};
	__property System::UnicodeString ExternalDll = {read=FExternalDll, write=FExternalDll};
	__property System::UnicodeString ExternalName = {read=FExternalName, write=FExternalName};
	__property System::UnicodeString ResultTypeDecl = {read=GetResultTypeDecl, write=SetResultTypeDecl};
	__property TatRoutineVisibility Visibility = {read=FVisibility, write=FVisibility, nodefault};
};


class PASCALIMPLEMENTATION TatVariablesInfo : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TatVariableInfo* operator[](int i) { return Items[i]; }
	
private:
	HIDESBASE TatVariableInfo* __fastcall GetItem(int i);
	
public:
	HIDESBASE TatVariableInfo* __fastcall Add(void);
	int __fastcall IndexOf(System::UnicodeString AName);
	TatVariableInfo* __fastcall FindByName(System::UnicodeString AName);
	__property TatVariableInfo* Items[int i] = {read=GetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TatVariablesInfo(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatVariablesInfo(void) { }
	
};


#pragma option push -b-
enum TatVariableVisibility { vvPublic, vvPrivate };
#pragma option pop

class PASCALIMPLEMENTATION TatVariableInfo : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FVarName;
	int FDeclarationSourcePos;
	int FArgIndex;
	TatArgumentModifier FModifier;
	TatClass* FDeclaredClass;
	bool FGlobal;
	System::UnicodeString FTypeDecl;
	int FSystemType;
	TatVariableVisibility FVisibility;
	System::Variant __fastcall GetValue(void);
	void __fastcall SetValue(const System::Variant &AValue);
	TatScript* __fastcall Script(void);
	TatRoutineInfo* __fastcall Routine(void);
	System::UnicodeString __fastcall GetDeclaredClassName(void);
	void __fastcall SetDeclaredClassName(const System::UnicodeString Value);
	void __fastcall PullSystemType(void);
	
public:
	__fastcall virtual TatVariableInfo(Classes::TCollection* ACollection);
	virtual void __fastcall Assign(Classes::TPersistent* ASource);
	void __fastcall SetTypeFromString(System::UnicodeString ATypeStr);
	TatScriptInfo* __fastcall ScriptInfo(void);
	bool __fastcall Internal(void);
	int __fastcall VarIndex(void);
	bool __fastcall SameDeclaration(TatVariableInfo* AVariable);
	__property System::Variant Value = {read=GetValue, write=SetValue};
	__property TatClass* DeclaredClass = {read=FDeclaredClass, write=FDeclaredClass};
	
__published:
	__property System::UnicodeString VarName = {read=FVarName, write=FVarName};
	__property int DeclarationSourcePos = {read=FDeclarationSourcePos, write=FDeclarationSourcePos, nodefault};
	__property int ArgIndex = {read=FArgIndex, write=FArgIndex, nodefault};
	__property TatArgumentModifier Modifier = {read=FModifier, write=FModifier, nodefault};
	__property bool Global = {read=FGlobal, write=FGlobal, nodefault};
	__property System::UnicodeString DeclaredClassName = {read=GetDeclaredClassName, write=SetDeclaredClassName};
	__property System::UnicodeString TypeDecl = {read=FTypeDecl, write=FTypeDecl};
	__property int SystemType = {read=FSystemType, write=FSystemType, nodefault};
	__property TatVariableVisibility Visibility = {read=FVisibility, write=FVisibility, nodefault};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TatVariableInfo(void) { }
	
};


__interface IatInterfacedObject;
typedef System::DelphiInterface<IatInterfacedObject> _di_IatInterfacedObject;
__interface  INTERFACE_UUID("{44284F76-2152-4326-9CB7-DEC05852B5CA}") IatInterfacedObject  : public System::IInterface 
{
	
public:
	virtual System::TObject* __fastcall GetObjectReference(void) = 0 ;
};

class DELPHICLASS TatRecordWrapper;
class PASCALIMPLEMENTATION TatRecordWrapper : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
public:
	System::TObject* __fastcall GetObjectReference(void);
public:
	/* TObject.Create */ inline __fastcall TatRecordWrapper(void) : System::TInterfacedObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TatRecordWrapper(void) { }
	
private:
	void *__IatInterfacedObject;	/* IatInterfacedObject */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator _di_IatInterfacedObject()
	{
		_di_IatInterfacedObject intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IatInterfacedObject*(void) { return (IatInterfacedObject*)&__IatInterfacedObject; }
	#endif
	
};


class PASCALIMPLEMENTATION TatScriptBreakPoints : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TatScriptBreakPoint* operator[](int i) { return Items[i]; }
	
private:
	TatVirtualMachine* FMachine;
	HIDESBASE TatScriptBreakPoint* __fastcall GetItem(int i);
	
public:
	__fastcall TatScriptBreakPoints(TatVirtualMachine* AMachine);
	TatScriptBreakPoint* __fastcall InsertNormalBreak(pSimplifiedCode ATargetInst);
	TatScriptBreakPoint* __fastcall InsertTempBreak(pSimplifiedCode ATargetInst);
	bool __fastcall RemoveBreakPoint(pSimplifiedCode ATargetInst);
	TatScriptBreakPoint* __fastcall BreakPointByLine(int ALine);
	HIDESBASE TatScriptBreakPoint* __fastcall Add(void);
	__property TatScriptBreakPoint* Items[int i] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatScriptBreakPoints(void) { }
	
};


class PASCALIMPLEMENTATION TatScriptBreakPoint : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TSimplifiedCode FOriginalInst;
	TSimplifiedCode *FBreakInst;
	int FPassCount;
	bool FEnabled;
	bool FAutoDestroy;
	TatScriptBreak* FNotifyBreak;
	void __fastcall SetBreakInst(pSimplifiedCode ATargetInst);
	void __fastcall RemoveBreak(void);
	void __fastcall NormalBreakProc(void);
	void __fastcall TemporaryBreakProc(void);
	
public:
	__fastcall virtual TatScriptBreakPoint(Classes::TCollection* Collection);
	__fastcall virtual ~TatScriptBreakPoint(void);
	TatVirtualMachine* __fastcall Machine(void);
	__property TSimplifiedCode OriginalInst = {read=FOriginalInst, write=FOriginalInst};
	__property int PassCount = {read=FPassCount, write=FPassCount, nodefault};
	__property bool Enabled = {read=FEnabled, write=FEnabled, nodefault};
	__property bool AutoDestroy = {read=FAutoDestroy, write=FAutoDestroy, nodefault};
};


#pragma option push -b-
enum TLoopStatement { lsNone, lsFor, lsWhile, lsRepeat };
#pragma option pop

class PASCALIMPLEMENTATION TatClasses : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TatClass* operator[](int i) { return Items[i]; }
	
private:
	TatCustomScripter* FScripter;
	HIDESBASE TatClass* __fastcall GetItem(int i);
	int __fastcall GetImplicitCount(void);
	
protected:
	TatClass* __fastcall AddClassByRTTI(System::TClass AClass, System::UnicodeString AClassName = L"");
	TatClass* __fastcall AddClassByRTTIEx(System::TClass AClass, System::UnicodeString AClassName = L"", TMemberVisibilitySet AVisibilityFilter = (TMemberVisibilitySet() << Typinfo::TMemberVisibility::mvPublic << Typinfo::TMemberVisibility::mvPublished ), bool ARecursive = false, TRedefineOption ARedefine = (TRedefineOption)(0x0))/* overload */;
	TatClass* __fastcall AddRecord(Typinfo::PTypeInfo ATypeInfo, System::UnicodeString ARecordName = L"");
	TatClass* __fastcall AddDelphiClass(System::TClass AClass, System::UnicodeString AClassName = L"");
	TatClass* __fastcall CheckLoaded(System::TClass AClass, System::UnicodeString AClassName = L"");
	__property int ImplicitCount = {read=GetImplicitCount, nodefault};
	
public:
	__fastcall TatClasses(TatCustomScripter* AScripter);
	HIDESBASE TatClass* __fastcall Add(System::UnicodeString AName, System::UnicodeString AAncestorName);
	int __fastcall IndexOf(System::UnicodeString AName);
	TatClass* __fastcall ClassByName(System::UnicodeString AName);
	bool __fastcall TestCheckLoaded(System::TClass AClass, TatClass* &ACurrentClass, System::UnicodeString AClassName = L"");
	__property TatClass* Items[int i] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatClasses(void) { }
	
};


class DELPHICLASS TatProperties;
class DELPHICLASS TatMethods;
class PASCALIMPLEMENTATION TatClass : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	TatProperties* FProperties;
	TatMethods* FMethods;
	System::TClass FClassRef;
	Typinfo::TTypeInfo *FRecordRef;
	System::UnicodeString FAncestorName;
	TatClass* FAncestor;
	Classes::TList* FDescendants;
	TatProperty* FDefaultProperty;
	TatScript* FBaseScript;
	Classes::TCollectionItem* FImplicitElement;
	void __fastcall Inherits(System::UnicodeString AAncestorName);
	void __fastcall RemoveDescendant(TatClass* ADescendant);
	void __fastcall InsertDescendant(TatClass* ADescendant);
	void __fastcall NotifyDescendants(void);
	void __fastcall AncestorDestroyed(void);
	void __fastcall SetMethods(const TatMethods* Value);
	void __fastcall SetProperties(const TatProperties* Value);
	bool __fastcall GetIsImplicit(void);
	void __fastcall SetImplicitElement(const Classes::TCollectionItem* Value);
	
public:
	__fastcall virtual TatClass(Classes::TCollection* ACollection);
	__fastcall virtual ~TatClass(void);
	TatMethod* __fastcall SetProc(System::UnicodeString AName, void * ACode, int AArgCount, TatTypeKind AResultDataType, TGenericProc AProc, System::TClass AResultClass, bool AIsClassMethod = false, int ADefArgCount = 0x0);
	TatMethod* __fastcall AddProc(System::UnicodeString AName, void * ACode, int AArgCount, TatTypeKind AResultDataType, TGenericProc AProc, System::TClass AResultClass, bool AIsClassMethod = false, int ADefArgCount = 0x0);
	TatProperty* __fastcall PropertyByName(System::UnicodeString AName);
	TatProperty* __fastcall ClassPropertyByName(System::UnicodeString AName);
	TatMethod* __fastcall MethodByName(System::UnicodeString AName);
	TatMethod* __fastcall ClassMethodByName(System::UnicodeString AName);
	TatClass* __fastcall CastFromString(System::UnicodeString AClassName);
	void __fastcall RemoveProperty(System::UnicodeString AName);
	void __fastcall AddEnumeration(Typinfo::PTypeInfo ATypeInfo);
	void __fastcall AddObject(System::UnicodeString AName, System::TObject* AObject);
	void __fastcall AddConstant(System::UnicodeString AName, const System::Variant &AValue);
	void __fastcall AddVariable(System::UnicodeString AName, System::Variant &AVar)/* overload */;
	void __fastcall AddVariable(System::UnicodeString AName, System::Extended &AVar)/* overload */;
	void __fastcall AddVariable(System::UnicodeString AName, double &AVar)/* overload */;
	void __fastcall AddVariable(System::UnicodeString AName, System::UnicodeString &AVar)/* overload */;
	void __fastcall AddVariable(System::UnicodeString AName, System::WideString &AVar)/* overload */;
	void __fastcall AddVariable(System::UnicodeString AName, int &AVar)/* overload */;
	void __fastcall AddVariable(System::UnicodeString AName, bool &AVar)/* overload */;
	TatProperty* __fastcall AddProp(System::UnicodeString AName, TatTypeKind ADataType, TGenericProc AGetter, TGenericProc ASetter, System::TClass APropertyClass = 0x0, bool AIsClassProp = false, int AIndexCount = 0x0);
	TatProperty* __fastcall SetProp(System::UnicodeString AName, TatTypeKind ADataType, TGenericProc AGetter, TGenericProc ASetter, System::TClass APropertyClass = 0x0, bool AIsClassProp = false, int AIndexCount = 0x0);
	void __fastcall AddIntegerProp(System::UnicodeString AName, TGenericProc AGetter, TGenericProc ASetter, bool AIsClassProp = false);
	void __fastcall AddStringProp(System::UnicodeString AName, TGenericProc AGetter, TGenericProc ASetter, bool AIsClassProp = false);
	void __fastcall AddBooleanProp(System::UnicodeString AName, TGenericProc AGetter, TGenericProc ASetter, bool AIsClassProp = false);
	void __fastcall AddFloatProp(System::UnicodeString AName, TGenericProc AGetter, TGenericProc ASetter, bool AIsClassProp = false);
	void __fastcall AddVariantProp(System::UnicodeString AName, TGenericProc AGetter, TGenericProc ASetter, bool AIsClassProp = false);
	void __fastcall AddObjectProp(System::UnicodeString AName, TGenericProc AGetter, TGenericProc ASetter, System::TClass APropertyClass, bool AIsClassProp = false);
	void __fastcall AddDelphiObjectProp(System::UnicodeString AName, System::TObject* AObject);
	TatProperty* __fastcall DefineProp(System::UnicodeString AName, TatTypeKind ADataType, TMachineProc AGetter, TMachineProc ASetter, System::TClass APropertyClass = 0x0, bool AIsClassProp = false, int AIndexCount = 0x0);
	TatProperty* __fastcall DefineNewProp(System::UnicodeString AName, TatTypeKind ADataType, TMachineProc AGetter, TMachineProc ASetter, System::TClass APropertyClass = 0x0, bool AIsClassProp = false, int AIndexCount = 0x0);
	void __fastcall DefineIntegerProp(System::UnicodeString AName, TMachineProc AGetter, TMachineProc ASetter, bool AIsClassProp = false);
	void __fastcall DefineStringProp(System::UnicodeString AName, TMachineProc AGetter, TMachineProc ASetter, bool AIsClassProp = false);
	void __fastcall DefineBooleanProp(System::UnicodeString AName, TMachineProc AGetter, TMachineProc ASetter, bool AIsClassProp = false);
	void __fastcall DefineFloatProp(System::UnicodeString AName, TMachineProc AGetter, TMachineProc ASetter, bool AIsClassProp = false);
	void __fastcall DefineVariantProp(System::UnicodeString AName, TMachineProc AGetter, TMachineProc ASetter, bool AIsClassProp = false);
	void __fastcall DefineObjectProp(System::UnicodeString AName, TMachineProc AGetter, TMachineProc ASetter, System::TClass APropertyClass, bool AIsClassProp = false);
	TatMethod* __fastcall AddMethod(System::UnicodeString AName, int AArgCount, TatTypeKind AResultDataType, System::TClass AResultClass, TGenericProc AProc, bool AIsClassMethod = false, int ADefArgCount = 0x0);
	TatMethod* __fastcall DefineNewMethod(System::UnicodeString AName, int AArgCount, TatTypeKind AResultDataType, System::TClass AResultClass, TMachineProc AProc, bool AIsClassMethod = false, int ADefArgCount = 0x0);
	TatMethod* __fastcall DefineMethod(System::UnicodeString AName, int AArgCount, TatTypeKind AResultDataType, System::TClass AResultClass, TMachineProc AProc, bool AIsClassMethod = false, int ADefArgCount = 0x0);
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property TatProperties* Properties = {read=FProperties, write=SetProperties};
	__property TatMethods* Methods = {read=FMethods, write=SetMethods};
	__property System::UnicodeString AncestorName = {read=FAncestorName, write=FAncestorName};
	__property System::TClass ClassRef = {read=FClassRef, write=FClassRef};
	__property TatClass* Ancestor = {read=FAncestor, write=FAncestor};
	__property TatProperty* DefaultProperty = {read=FDefaultProperty, write=FDefaultProperty};
	__property Classes::TCollectionItem* ImplicitElement = {read=FImplicitElement, write=SetImplicitElement};
	__property bool IsImplicit = {read=GetIsImplicit, nodefault};
};


class PASCALIMPLEMENTATION TatProperties : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TatProperty* operator[](int i) { return Items[i]; }
	
private:
	TatClass* FClass;
	HIDESBASE TatProperty* __fastcall GetItem(int i);
	
public:
	__fastcall TatProperties(TatClass* AClass);
	__property TatProperty* Items[int i] = {read=GetItem/*, default*/};
	TatProperty* __fastcall AddByRTTI(Typinfo::PPropInfo APropInfo);
	int __fastcall IndexOf(System::UnicodeString AName);
	TatProperty* __fastcall PropertyByName(System::UnicodeString AName);
	TatProperty* __fastcall ClassPropertyByName(System::UnicodeString AName);
	__property TatClass* atClass = {read=FClass};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatProperties(void) { }
	
};


class PASCALIMPLEMENTATION TatProperty : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TatCustomScripter* FScripter;
	System::UnicodeString FName;
	TatTypeKind FDataType;
	TGenericProc FGetter;
	TGenericProc FSetter;
	System::TClass FPropertyClass;
	System::UnicodeString FPropertyClassName;
	Typinfo::TPropInfo *FPropInfo;
	System::Variant FValue;
	bool FIsClassProp;
	int FIndexCount;
	void __fastcall RTTIGetterProc(TatVirtualMachine* AMachine);
	void __fastcall RTTISetterProc(TatVirtualMachine* AMachine);
	void __fastcall GetFormComponentProc(TatVirtualMachine* AMachine);
	void __fastcall GetDelphiObjectPropProc(TatVirtualMachine* AMachine);
	void __fastcall GetVariantPropProc(TatVirtualMachine* AMachine);
	void __fastcall GetBoolVariablePropProc(TatVirtualMachine* AMachine);
	void __fastcall GetExtVariablePropProc(TatVirtualMachine* AMachine);
	void __fastcall GetDblVariablePropProc(TatVirtualMachine* AMachine);
	void __fastcall GetIntVariablePropProc(TatVirtualMachine* AMachine);
	void __fastcall GetStrVariablePropProc(TatVirtualMachine* AMachine);
	void __fastcall GetWStrVariablePropProc(TatVirtualMachine* AMachine);
	void __fastcall GetVarVariablePropProc(TatVirtualMachine* AMachine);
	void __fastcall SetBoolVariablePropProc(TatVirtualMachine* AMachine);
	void __fastcall SetExtVariablePropProc(TatVirtualMachine* AMachine);
	void __fastcall SetDblVariablePropProc(TatVirtualMachine* AMachine);
	void __fastcall SetIntVariablePropProc(TatVirtualMachine* AMachine);
	void __fastcall SetStrVariablePropProc(TatVirtualMachine* AMachine);
	void __fastcall SetWStrVariablePropProc(TatVirtualMachine* AMachine);
	void __fastcall SetVarVariablePropProc(TatVirtualMachine* AMachine);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TatProperty(Classes::TCollection* ACollection);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	bool __fastcall UpdateObjectInfo(TatClass* &ACurrentClass);
	TatClass* __fastcall atClass(void);
	__property TatCustomScripter* Scripter = {read=FScripter, write=FScripter};
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property TGenericProc Getter = {read=FGetter, write=FGetter};
	__property TGenericProc Setter = {read=FSetter, write=FSetter};
	__property TatTypeKind DataType = {read=FDataType, write=FDataType, nodefault};
	__property System::Variant Value = {read=FValue, write=FValue};
	__property bool IsClassProp = {read=FIsClassProp, write=FIsClassProp, nodefault};
	__property System::TClass PropertyClass = {read=FPropertyClass, write=FPropertyClass};
	__property Typinfo::PPropInfo PropInfo = {read=FPropInfo, write=FPropInfo};
	__property int IndexCount = {read=FIndexCount, write=FIndexCount, nodefault};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TatProperty(void) { }
	
};


class PASCALIMPLEMENTATION TatMethods : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TatMethod* operator[](int i) { return Items[i]; }
	
private:
	TatClass* FClass;
	HIDESBASE TatMethod* __fastcall GetItem(int i);
	
public:
	__fastcall TatMethods(TatClass* AClass);
	__property TatMethod* Items[int i] = {read=GetItem/*, default*/};
	int __fastcall IndexOf(System::UnicodeString AName);
	TatMethod* __fastcall MethodByName(System::UnicodeString AName);
	TatMethod* __fastcall ClassMethodByName(System::UnicodeString AName);
	__property TatClass* atClass = {read=FClass};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatMethods(void) { }
	
};


class DELPHICLASS TatDataDefs;
class PASCALIMPLEMENTATION TatMethod : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TatCustomScripter* FScripter;
	System::UnicodeString FName;
	TGenericProc FProc;
	TatTypeKind FResultDataType;
	int FArgCount;
	void *FCode;
	System::TClass FResultClass;
	TatDataDefs* FArgDefs;
	bool FIsClassMethod;
	int FByRefArgMask;
	int FDefArgCount;
	System::UnicodeString FResultClassName;
	void __fastcall SetArgDefs(const TatDataDefs* Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TatMethod(Classes::TCollection* ACollection);
	__fastcall virtual ~TatMethod(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	bool __fastcall UpdateObjectInfo(TatClass* &ACurrentClass);
	void __fastcall SetVarArgs(System::Byte *argi, const int argi_Size);
	bool __fastcall IsByRefArg(System::Byte n);
	TatClass* __fastcall atClass(void);
	__property TatCustomScripter* Scripter = {read=FScripter, write=FScripter};
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property TGenericProc Proc = {read=FProc, write=FProc};
	__property TatTypeKind ResultDataType = {read=FResultDataType, write=FResultDataType, nodefault};
	__property int ArgCount = {read=FArgCount, write=FArgCount, nodefault};
	__property int DefArgCount = {read=FDefArgCount, write=FDefArgCount, nodefault};
	__property TatDataDefs* ArgDefs = {read=FArgDefs, write=SetArgDefs};
	__property bool IsClassMethod = {read=FIsClassMethod, write=FIsClassMethod, nodefault};
	__property void * Code = {read=FCode, write=FCode};
	__property System::TClass ResultClass = {read=FResultClass, write=FResultClass};
	__property int ByRefArgMask = {read=FByRefArgMask, write=FByRefArgMask, nodefault};
};


class DELPHICLASS TatDataDef;
class PASCALIMPLEMENTATION TatDataDefs : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TatDataDef* operator[](int i) { return Items[i]; }
	
private:
	HIDESBASE TatDataDef* __fastcall GetItem(int i);
	
public:
	__fastcall TatDataDefs(TatClass* AClass);
	__property TatDataDef* Items[int i] = {read=GetItem/*, default*/};
	HIDESBASE TatDataDef* __fastcall Add(System::UnicodeString AName, TatTypeKind ADataType, TatArgumentModifier AModifier);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatDataDefs(void) { }
	
};


class PASCALIMPLEMENTATION TatDataDef : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	TatTypeKind FDataType;
	TatArgumentModifier FModifier;
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* ASource);
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property TatTypeKind DataType = {read=FDataType, write=FDataType, nodefault};
	__property TatArgumentModifier Modifier = {read=FModifier, write=FModifier, nodefault};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TatDataDef(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TatDataDef(void) { }
	
};


class PASCALIMPLEMENTATION TatObjects : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TatObject* operator[](int i) { return Items[i]; }
	
private:
	TatClasses* FClasses;
	HIDESBASE TatObject* __fastcall GetItem(int i);
	
public:
	__fastcall TatObjects(TatClasses* AClasses);
	HIDESBASE TatObject* __fastcall Add(System::TObject* AInstance, System::UnicodeString AName = L"", System::UnicodeString AClassName = L"");
	int __fastcall FindInstanceByMethodName(System::UnicodeString AMethodName, TatMethod* &AMethod);
	int __fastcall FindInstanceByPropertyName(System::UnicodeString APropertyName, TatProperty* &AProperty);
	TatObject* __fastcall FindInstanceByClassName(System::UnicodeString AClassName);
	int __fastcall IndexOf(System::UnicodeString AName);
	__property TatObject* Items[int i] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatObjects(void) { }
	
};


class PASCALIMPLEMENTATION TatObject : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	System::TObject* FInstance;
	TatClass* FatClass;
	void __fastcall SeTatClass(const TatClass* Value);
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* ASource);
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property System::TObject* Instance = {read=FInstance, write=FInstance};
	__property TatClass* atClass = {read=FatClass, write=SeTatClass};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TatObject(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TatObject(void) { }
	
};


class DELPHICLASS TatClassRefs;
class DELPHICLASS TatClassRef;
class PASCALIMPLEMENTATION TatClassRefs : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TatClassRef* operator[](int i) { return Items[i]; }
	
private:
	TatScript* FScript;
	HIDESBASE TatClassRef* __fastcall GetItem(int i);
	
public:
	__fastcall TatClassRefs(TatScript* AScript);
	HIDESBASE TatClassRef* __fastcall Add(int AClassIndex, int AElementIndex, bool AElementIsMethod, System::UnicodeString AClassName, System::UnicodeString AElementName);
	__property TatClassRef* Items[int i] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatClassRefs(void) { }
	
};


class PASCALIMPLEMENTATION TatClassRef : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FClassIndex;
	int FElementIndex;
	bool FElementIsMethod;
	System::UnicodeString FElementName;
	System::UnicodeString FClassName;
	
public:
	void __fastcall CheckLoaded(void);
	__property int ClassIndex = {read=FClassIndex, nodefault};
	__property int ElementIndex = {read=FElementIndex, nodefault};
	__property bool ElementIsMethod = {read=FElementIsMethod, nodefault};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TatClassRef(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TatClassRef(void) { }
	
};


class DELPHICLASS TatUsedUnit;
class PASCALIMPLEMENTATION TatUsedUnit : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool FIsDefault;
	System::UnicodeString FUnitName;
	bool FIsScript;
	int FDeclSourcePos;
	
public:
	__property System::UnicodeString UnitName = {read=FUnitName, write=FUnitName};
	__property bool IsDefault = {read=FIsDefault, write=FIsDefault, nodefault};
	__property bool IsScript = {read=FIsScript, write=FIsScript, nodefault};
	__property int DeclSourcePos = {read=FDeclSourcePos, write=FDeclSourcePos, nodefault};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TatUsedUnit(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TatUsedUnit(void) { }
	
};


class PASCALIMPLEMENTATION TatUsedUnits : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TatUsedUnit* operator[](int i) { return Items[i]; }
	
private:
	TatCustomScripter* FScripter;
	HIDESBASE TatUsedUnit* __fastcall GetItem(int i);
	
public:
	__fastcall TatUsedUnits(TatCustomScripter* AScripter);
	TatUsedUnit* __fastcall FindByName(System::UnicodeString AUnitName);
	HIDESBASE TatUsedUnit* __fastcall Add(void);
	__property TatUsedUnit* Items[int i] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatUsedUnits(void) { }
	
};


class PASCALIMPLEMENTATION TatScripterLibrary : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TatCustomScripter* FScripter;
	System::UnicodeString FDefaultInstanceName;
	void __fastcall SelfProc(TatVirtualMachine* AMachine);
	
protected:
	virtual void __fastcall Init(void) = 0 ;
	virtual void __fastcall Finalize(void);
	__property TatCustomScripter* Scripter = {read=FScripter};
	
public:
	__classmethod virtual System::UnicodeString __fastcall LibraryName();
	__fastcall virtual TatScripterLibrary(TatCustomScripter* AScripter);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatScripterLibrary(void) { }
	
};


class DELPHICLASS TatDLL;
class PASCALIMPLEMENTATION TatDLL : public TatScripterLibrary
{
	typedef TatScripterLibrary inherited;
	
private:
	TatScript* FScript;
	System::UnicodeString FFileName;
	TatClass* FatClass;
	
public:
	virtual void __fastcall Init(void);
	virtual void __fastcall Finalize(void);
	__classmethod virtual System::UnicodeString __fastcall LibraryName();
public:
	/* TatScripterLibrary.Create */ inline __fastcall virtual TatDLL(TatCustomScripter* AScripter) : TatScripterLibrary(AScripter) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatDLL(void) { }
	
};


class DELPHICLASS TatScriptBasedLibrary;
class PASCALIMPLEMENTATION TatScriptBasedLibrary : public TatScripterLibrary
{
	typedef TatScripterLibrary inherited;
	
private:
	TatScript* FInternalScript;
	System::UnicodeString FName;
	Classes::TList* FMethodList;
	Classes::TList* FPropList;
	System::TClass FRegClass;
	System::UnicodeString FRegClassName;
	TatClass* FNewClass;
	TatScript* __fastcall GetRunScript(TatVirtualMachine* AMachine);
	void __fastcall ExecSubRoutineProc(TatVirtualMachine* AMachine);
	void __fastcall GetScriptVarProc(TatVirtualMachine* AMachine);
	void __fastcall SetScriptVarProc(TatVirtualMachine* AMachine);
	
protected:
	virtual void __fastcall Init(void);
	virtual void __fastcall Finalize(void);
	
public:
	__fastcall virtual TatScriptBasedLibrary(TatCustomScripter* AScripter);
	__fastcall virtual ~TatScriptBasedLibrary(void);
};


class DELPHICLASS TatLibraryListItem;
class PASCALIMPLEMENTATION TatLibraryListItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TatScripterLibraryClass FLibraryClass;
	bool FExplicitLoad;
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property TatScripterLibraryClass LibraryClass = {read=FLibraryClass, write=FLibraryClass};
	__property bool ExplicitLoad = {read=FExplicitLoad, write=FExplicitLoad, nodefault};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TatLibraryListItem(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TatLibraryListItem(void) { }
	
};


class DELPHICLASS TatLibraryList;
class PASCALIMPLEMENTATION TatLibraryList : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TatLibraryListItem* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TatLibraryListItem* __fastcall GetItem(int Index);
	
public:
	HIDESBASE TatLibraryListItem* __fastcall Add(void);
	void __fastcall Remove(TatScripterLibraryClass ALibrary);
	TatLibraryListItem* __fastcall FindByLibraryName(System::UnicodeString ALibName);
	__property TatLibraryListItem* Items[int Index] = {read=GetItem/*, default*/};
public:
	/* TCollection.Create */ inline __fastcall TatLibraryList(Classes::TCollectionItemClass ItemClass) : Classes::TCollection(ItemClass) { }
	/* TCollection.Destroy */ inline __fastcall virtual ~TatLibraryList(void) { }
	
};


class DELPHICLASS TatEventDispatchers;
class DELPHICLASS TatEventAdapters;
class PASCALIMPLEMENTATION TatScripterEventBroker : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TatCustomScripter* FScripter;
	TatEventDispatchers* FDispatchers;
	TExecuteEventProc FOnExecuteEvent;
	TSettingEventProc FOnSettingEvent;
	TSetEventProc FOnSetEvent;
	TUnsetEventProc FOnUnsettingEvent;
	TatEventAdapters* FEventAdapters;
	TatEventDispatcher* __fastcall InternalSetEvent(System::TObject* AInstance, Typinfo::PPropInfo APropInfo, System::UnicodeString ARoutineName, TatCustomScripter* AScripter, TatEventPlacement APlacement, TatScript* AScript);
	bool __fastcall InternalUnsetEvent(System::TObject* AInstance, Typinfo::PPropInfo APropInfo, System::UnicodeString ARoutineName, TatCustomScripter* AScripter);
	bool __fastcall InternalUnsetEvents(System::TObject* AInstance, Typinfo::PPropInfo APropInfo);
	void __fastcall SetDispatchers(const TatEventDispatchers* Value);
	void __fastcall SetOnExecuteEvent(const TExecuteEventProc Value);
	void __fastcall SetOnSetEvent(const TSetEventProc Value);
	void __fastcall SetOnUnsettingEvent(const TUnsetEventProc Value);
	System::TMethod __fastcall GetOldMethod(const System::TMethod &m);
	bool __fastcall MethodIsDesiredDispatcher(const System::TMethod &m, System::UnicodeString ARoutineName, TatCustomScripter* AScripter);
	TatEventDispatcher* __fastcall GetDispatcherFromMethod(const System::TMethod &m);
	void __fastcall SetOnSettingEvent(const TSettingEventProc Value);
	System::TMethod __fastcall GetMethodPropEx(System::TObject* AInstance, Typinfo::PPropInfo APropInfo);
	void __fastcall SetMethodPropEx(System::TObject* AInstance, Typinfo::PPropInfo APropInfo, const System::TMethod &AMethod);
	
public:
	__fastcall virtual TatScripterEventBroker(Classes::TComponent* AOwner);
	__fastcall virtual ~TatScripterEventBroker(void);
	TatEventDispatcher* __fastcall SetEvent(System::TObject* AInstance, System::UnicodeString APropName, System::UnicodeString ARoutineName, TatCustomScripter* AScripter, TatEventPlacement APlacement, TatScript* AScript = (TatScript*)(0x0));
	bool __fastcall UnsetEvent(System::TObject* AInstance, System::UnicodeString APropName, System::UnicodeString ARoutineName = L"", TatCustomScripter* AScripter = (TatCustomScripter*)(0x0));
	bool __fastcall UnsetEvents(System::TObject* AInstance, System::UnicodeString APropName);
	System::UnicodeString __fastcall GetAssignedRoutineName(System::TObject* AInstance, System::UnicodeString APropName, TatCustomScripter* AScripter);
	void __fastcall UnsetAllEvents(void);
	__property TatEventAdapters* EventAdapters = {read=FEventAdapters, write=FEventAdapters};
	
__published:
	__property TatEventDispatchers* Dispatchers = {read=FDispatchers, write=SetDispatchers};
	__property TExecuteEventProc OnExecuteEvent = {read=FOnExecuteEvent, write=SetOnExecuteEvent};
	__property TSettingEventProc OnSettingEvent = {read=FOnSettingEvent, write=SetOnSettingEvent};
	__property TSetEventProc OnSetEvent = {read=FOnSetEvent, write=SetOnSetEvent};
	__property TUnsetEventProc OnUnsettingEvent = {read=FOnUnsettingEvent, write=SetOnUnsettingEvent};
};


class DELPHICLASS TatEventAdapter;
class PASCALIMPLEMENTATION TatEventAdapters : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TatEventAdapter* operator[](int i) { return Items[i]; }
	
private:
	HIDESBASE TatEventAdapter* __fastcall GetItem(int i);
	
public:
	HIDESBASE TatEventAdapter* __fastcall Add(void);
	__property TatEventAdapter* Items[int i] = {read=GetItem/*, default*/};
	TatEventAdapter* __fastcall FindAdapter(Typinfo::PTypeInfo ARttiInfo);
	TatEventAdapter* __fastcall AdapterByPropInfo(Typinfo::PPropInfo APropInfo);
	TatEventAdapter* __fastcall DefineEventAdapter(Typinfo::PTypeInfo ARttiInfo, TDispatcherClass ADispatcherClass, void * AMethodCode, bool ACheck);
public:
	/* TCollection.Create */ inline __fastcall TatEventAdapters(Classes::TCollectionItemClass ItemClass) : Classes::TCollection(ItemClass) { }
	/* TCollection.Destroy */ inline __fastcall virtual ~TatEventAdapters(void) { }
	
};


class PASCALIMPLEMENTATION TatEventAdapter : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Typinfo::TTypeInfo *FRttiInfo;
	void *FMethodCode;
	TDispatcherClass FDispatcherClass;
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* ASource);
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TatEventAdapter(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TatEventAdapter(void) { }
	
};


class PASCALIMPLEMENTATION TatEventDispatchers : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TatEventDispatcher* operator[](int i) { return Items[i]; }
	
private:
	HIDESBASE TatEventDispatcher* __fastcall GetItem(int i);
	
public:
	HIDESBASE TatEventDispatcher* __fastcall Add(void);
	__property TatEventDispatcher* Items[int i] = {read=GetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TatEventDispatchers(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatEventDispatchers(void) { }
	
};


class DELPHICLASS TatDispatcherRemoveNotificator;
class PASCALIMPLEMENTATION TatEventDispatcher : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::TMethod FBeforeCall;
	System::TMethod FAfterCall;
	System::TMethod FOldCall;
	TatCustomScripter* FScripter;
	System::UnicodeString FRoutineName;
	System::TMethod FCustomCall;
	TatEventAdapter* FAdapter;
	System::TObject* FInstance;
	Typinfo::TPropInfo *FPropInfo;
	TatDispatcherRemoveNotificator* FNotificator;
	bool FIsComponent;
	TatScript* FScript;
	void __fastcall SetScripter(const TatCustomScripter* Value);
	void __fastcall SetAfterCall(const System::TMethod &Value);
	void __fastcall SetBeforeCall(const System::TMethod &Value);
	void __fastcall SetOldCall(const System::TMethod &Value);
	void __fastcall SetAdapter(const TatEventAdapter* Value);
	void __fastcall SetInstance(const System::TObject* Value);
	void __fastcall SetPropInfo(const Typinfo::PPropInfo Value);
	
protected:
	bool __fastcall DoOnExecuteEvent(void);
	
public:
	__fastcall virtual TatEventDispatcher(Classes::TCollection* ACollection);
	__fastcall virtual ~TatEventDispatcher(void);
	void __fastcall Unset(void);
	TatScripterEventBroker* __fastcall EventBroker(void);
	__property TatCustomScripter* Scripter = {read=FScripter, write=SetScripter};
	__property TatScript* Script = {read=FScript, write=FScript};
	__property System::TMethod BeforeCall = {read=FBeforeCall, write=SetBeforeCall};
	__property System::TMethod AfterCall = {read=FAfterCall, write=SetAfterCall};
	__property System::TMethod OldCall = {read=FOldCall, write=SetOldCall};
	__property System::UnicodeString RoutineName = {read=FRoutineName, write=FRoutineName};
	__property TatEventAdapter* Adapter = {read=FAdapter, write=SetAdapter};
	__property System::TObject* Instance = {read=FInstance, write=SetInstance};
	__property Typinfo::PPropInfo PropInfo = {read=FPropInfo, write=SetPropInfo};
	__property System::TMethod CustomCall = {read=FCustomCall, write=FCustomCall};
};


class PASCALIMPLEMENTATION TatDispatcherRemoveNotificator : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TatEventDispatcher* FDispatcher;
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
public:
	/* TComponent.Create */ inline __fastcall virtual TatDispatcherRemoveNotificator(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TatDispatcherRemoveNotificator(void) { }
	
};


class DELPHICLASS TatDebugWatch;
class PASCALIMPLEMENTATION TatDebugWatches : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TatDebugWatch* operator[](int i) { return Items[i]; }
	
private:
	HIDESBASE TatDebugWatch* __fastcall GetItem(int i);
	
public:
	HIDESBASE TatDebugWatch* __fastcall Add(void);
	__property TatDebugWatch* Items[int i] = {read=GetItem/*, default*/};
	void __fastcall Reset(void);
	void __fastcall CompileAndEvaluateAll(void);
	void __fastcall EvaluateAll(void);
	void __fastcall Evaluate(TatDebugWatch* AWatch);
	void __fastcall CompileAndEvaluate(TatDebugWatch* AWatch);
public:
	/* TOwnedCollection.Create */ inline __fastcall TatDebugWatches(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatDebugWatches(void) { }
	
};


class PASCALIMPLEMENTATION TatDebugWatch : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FExpression;
	TatScript* FDebugScript;
	System::Variant FLastResult;
	TWatchStatus FWatchStatus;
	bool FAlwaysCompile;
	bool FEnabled;
	bool FResultChanged;
	void __fastcall SetLastResult(const System::Variant &Value);
	void __fastcall Reset(void);
	void __fastcall SetExpression(const System::UnicodeString Value);
	void __fastcall ScriptDestroyed(System::TObject* Sender);
	
public:
	__fastcall virtual TatDebugWatch(Classes::TCollection* ACollection);
	__fastcall virtual ~TatDebugWatch(void);
	void __fastcall CompileAndEvaluate(void);
	TatVirtualMachine* __fastcall Machine(void);
	void __fastcall Evaluate(void);
	void __fastcall FullEvaluate(void);
	__property System::UnicodeString Expression = {read=FExpression, write=SetExpression};
	__property TatScript* DebugScript = {read=FDebugScript, write=FDebugScript};
	__property TWatchStatus WatchStatus = {read=FWatchStatus, write=FWatchStatus, nodefault};
	__property System::Variant LastResult = {read=FLastResult, write=SetLastResult};
	__property bool ResultChanged = {read=FResultChanged, write=FResultChanged, nodefault};
	__property bool AlwaysCompile = {read=FAlwaysCompile, write=FAlwaysCompile, nodefault};
	__property bool Enabled = {read=FEnabled, write=FEnabled, nodefault};
};


class DELPHICLASS TGenericEventDispatcher;
class PASCALIMPLEMENTATION TGenericEventDispatcher : public TatEventDispatcher
{
	typedef TatEventDispatcher inherited;
	
public:
	void __fastcall RaiseEvent(void);
public:
	/* TatEventDispatcher.Create */ inline __fastcall virtual TGenericEventDispatcher(Classes::TCollection* ACollection) : TatEventDispatcher(ACollection) { }
	/* TatEventDispatcher.Destroy */ inline __fastcall virtual ~TGenericEventDispatcher(void) { }
	
};


class DELPHICLASS TGenericRecordWrapper;
class PASCALIMPLEMENTATION TGenericRecordWrapper : public TatRecordWrapper
{
	typedef TatRecordWrapper inherited;
	
private:
	Typinfo::TTypeInfo *FTypeInfo;
	Rtti::TRttiRecordType* FRecord;
	Rtti::TValue __fastcall GetFieldValue(System::UnicodeString AFieldName);
	void __fastcall SetFieldValue(System::UnicodeString AFieldName, const Rtti::TValue &AValue);
	
public:
	__fastcall TGenericRecordWrapper(Typinfo::PTypeInfo ATypeInfo);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TGenericRecordWrapper(void) { }
	
};


typedef System::StaticArray<System::Variant, 5> Atscript__85;

//-- var, const, procedure ---------------------------------------------------
static const System::Word StackSize = 0xbb8;
static const System::ShortInt CODEFILE_VERSION = 0x4;
static const System::ShortInt CURRENT_VERSION = 0x4;
#define DefaultTypeInfoFilter (System::Set<Typinfo::TTypeKind, Typinfo::TTypeKind::tkUnknown, Typinfo::TTypeKind::tkProcedure> () << Typinfo::TTypeKind::tkInteger << Typinfo::TTypeKind::tkChar << Typinfo::TTypeKind::tkEnumeration << Typinfo::TTypeKind::tkFloat << Typinfo::TTypeKind::tkString << Typinfo::TTypeKind::tkSet << Typinfo::TTypeKind::tkClass << Typinfo::TTypeKind::tkWChar << Typinfo::TTypeKind::tkLString << Typinfo::TTypeKind::tkWString << Typinfo::TTypeKind::tkVariant << Typinfo::TTypeKind::tkArray << Typinfo::TTypeKind::tkUString )
static const System::ShortInt vtLongint = 0x64;
static const System::Byte vtCardinal = 0xc8;
static const System::Word vtLongword = 0x12c;
static const System::Word vtSingle = 0x190;
static const System::Word vtByte = 0x1f6;
static const System::Word vtShortint = 0x25a;
static const System::Word vtWord = 0x2c5;
static const System::Word vtSmallint = 0x329;
static const System::Word vtDouble = 0x390;
static const System::Word vtReal = 0x3f4;
static const System::Word vtDateTime = 0x458;
static const System::Word vtComp = 0x4bc;
extern PACKAGE TatLibraryList* atLibraryList;
extern PACKAGE Atscript__85 CoreConst;
extern PACKAGE Classes::TNotifyEvent OnGlobalScripterCreate;
extern PACKAGE Classes::TNotifyEvent OnGlobalScripterLoaded;
extern PACKAGE System::Variant __fastcall MakeVarByRef(System::Variant &v);
extern PACKAGE System::TObject* __fastcall VarToObject(const System::Variant &v);
extern PACKAGE double __fastcall StrVal(System::UnicodeString s);
extern PACKAGE int __fastcall VarToInteger(const System::Variant &v);
extern PACKAGE int __fastcall VarToEnumInteger(const System::Variant &v, Typinfo::PTypeInfo PropType);
extern PACKAGE int __fastcall VarToSet(const System::Variant &v, Typinfo::PTypeInfo PropType);
extern PACKAGE double __fastcall VarToFloat(const System::Variant &v);
extern PACKAGE bool __fastcall VarToBoolean(const System::Variant &v);
extern PACKAGE System::UnicodeString __fastcall VarContent(const System::Variant &v);
extern PACKAGE bool __fastcall AssignedMethod(const System::TMethod &m);
extern PACKAGE int __fastcall LineNumberFromInstruction(pSimplifiedCode inst);
extern PACKAGE int __fastcall ColNumberFromInstruction(pSimplifiedCode inst);
extern PACKAGE bool __fastcall InstructionIsExecutable(TatCustomScripter* script, pSimplifiedCode inst);
extern PACKAGE void __fastcall IntToSet(void *ASet, int AInt, int ASize = 0x4);
extern PACKAGE int __fastcall IntFromSet(void *ASet, int ASize = 0x4);
extern PACKAGE int __fastcall IntFromConstSet(const void *ASet);
extern PACKAGE void __fastcall ScriptInfoError(System::UnicodeString msg);
extern PACKAGE void __fastcall RaiseRuntimeError(System::UnicodeString msg);
extern PACKAGE void __fastcall DefinitionError(System::UnicodeString msg);
extern PACKAGE void __fastcall InternalError(System::UnicodeString msg);
extern PACKAGE bool __fastcall ExtractExpression(System::UnicodeString s, int pos, int &i, int &len);
extern PACKAGE System::Variant __fastcall EvaluateWatch(TatCustomScripter* AScripter, System::UnicodeString AExpression);
extern PACKAGE Classes::TStringList* __fastcall CreateCodeCompletionList(TatCustomScripter* AScripter, System::UnicodeString AInputText, int AInputPos, int &AExprPos, int &AExprLen)/* overload */;
extern PACKAGE Classes::TStringList* __fastcall CreateCodeCompletionList(TatScript* AScript, System::UnicodeString AInputText, int AInputPos, int &AExprPos, int &AExprLen)/* overload */;
extern PACKAGE void __fastcall RegisterScripterLibrary(TatScripterLibraryClass ALibrary, bool AExplicitLoad = false);
extern PACKAGE void __fastcall UnregisterScripterLibrary(TatScripterLibraryClass ALibrary);
extern PACKAGE TatEventAdapter* __fastcall DefineEventAdapter(Typinfo::PTypeInfo ARttiInfo, TDispatcherClass ADispatcherClass, void * AMethodCode, bool ACheck = true);

}	/* namespace Atscript */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atscript;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtscriptHPP
