// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atScripter.pas' rev: 22.00

#ifndef AtscripterHPP
#define AtscripterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit
#include <atPascal.hpp>	// Pascal unit
#include <atBasic.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atscripter
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TScriptLanguage { slPascal, slBasic };
#pragma option pop

class DELPHICLASS TatScripter;
class PASCALIMPLEMENTATION TatScripter : public Atscript::TatCustomScripter
{
	typedef Atscript::TatCustomScripter inherited;
	
private:
	TScriptLanguage FDefaultLanguage;
	Atscript::TScriptClass __fastcall LanguageToClass(TScriptLanguage ALanguage);
	
protected:
	virtual void __fastcall DefineInternalClasses(void);
	virtual Atscript::TScriptClass __fastcall DefaultScriptClass(void);
	
public:
	__fastcall virtual TatScripter(Classes::TComponent* AOwner);
	__fastcall virtual ~TatScripter(void);
	Atscript::TatScript* __fastcall AddScript(TScriptLanguage ALanguage);
	
__published:
	__property TScriptLanguage DefaultLanguage = {read=FDefaultLanguage, write=FDefaultLanguage, nodefault};
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


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Atscripter */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atscripter;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtscripterHPP
