// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atWebScripter.pas' rev: 22.00

#ifndef AtwebscripterHPP
#define AtwebscripterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit
#include <atPascal.hpp>	// Pascal unit
#include <atBasic.hpp>	// Pascal unit
#include <atHTMLParse.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atwebscripter
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TScripterNotifyEvent)(System::TObject* Sender, Atscript::TatCustomScripter* AScripter);

class DELPHICLASS TatWebScripter;
class PASCALIMPLEMENTATION TatWebScripter : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Classes::TStringList* FWebScript;
	Classes::TStringList* FOutput;
	Athtmlparse::TatLanguage FLanguage;
	Atscript::TExecuteEventProc FOnExecuteEvent;
	Classes::TNotifyEvent FOnDebugHook;
	Athtmlparse::TDirectiveEvent FOnDirective;
	Atscript::TScriptErrorEvent FOnCompileError;
	Atscript::TSetEventProc FOnSetEvent;
	Atscript::TSettingEventProc FOnSettingEvent;
	Atscript::TUnsetEventProc FOnUnsettingEvent;
	Athtmlparse::TAfterPreCompileEvent FAfterPreCompile;
	TScripterNotifyEvent FOnInitScripter;
	TScripterNotifyEvent FBeforeExecute;
	TScripterNotifyEvent FAfterExecute;
	TScripterNotifyEvent FAfterCompile;
	void __fastcall atCompileError(System::TObject* Sender, System::UnicodeString &msg, int row, int col, bool &ShowException);
	void __fastcall atDebugHook(System::TObject* Sender);
	void __fastcall atExecuteEvent(Atscript::TatEventDispatcher* AEventDispatcher, bool &AExecute);
	void __fastcall atSetEvent(Atscript::TatEventDispatcher* AEventDispatcher);
	void __fastcall atSettingEvent(System::TObject* Sender, System::TObject* AInstance, System::UnicodeString APropName, System::UnicodeString ARoutineName, Atscript::TatCustomScripter* AScripter, Atscript::TatEventPlacement APlacement, bool &AProcede);
	void __fastcall atUnsettingEvent(Atscript::TatEventDispatcher* AEventDispatcher, bool &AProcede);
	Classes::TStrings* __fastcall GetWebScript(void);
	void __fastcall SetWebScript(const Classes::TStrings* Value);
	
protected:
	void __fastcall Script_Write(Atscript::TatVirtualMachine* AMachine);
	void __fastcall Script_WriteLn(Atscript::TatVirtualMachine* AMachine);
	
public:
	__fastcall virtual TatWebScripter(Classes::TComponent* AOwner);
	__fastcall virtual ~TatWebScripter(void);
	void __fastcall InitScripter(Atscript::TatCustomScripter* AScripter);
	void __fastcall Clear(void);
	System::UnicodeString __fastcall Content(void);
	System::UnicodeString __fastcall ContentFromString(const System::UnicodeString S);
	System::UnicodeString __fastcall ContentFromFile(const System::UnicodeString AFileName);
	System::UnicodeString __fastcall ContentFromStream(Classes::TStream* AStream);
	System::UnicodeString __fastcall ContentFromCompiledStream(Classes::TStream* AStream);
	System::UnicodeString __fastcall ContentFromCompiledFile(const System::UnicodeString AFileName);
	__property Classes::TStringList* Output = {read=FOutput};
	
__published:
	__property Athtmlparse::TatLanguage Language = {read=FLanguage, write=FLanguage, nodefault};
	__property Classes::TStrings* WebScript = {read=GetWebScript, write=SetWebScript};
	__property Athtmlparse::TAfterPreCompileEvent AfterPreCompile = {read=FAfterPreCompile, write=FAfterPreCompile};
	__property TScripterNotifyEvent AfterCompile = {read=FAfterCompile, write=FAfterCompile};
	__property TScripterNotifyEvent AfterExecute = {read=FAfterExecute, write=FAfterExecute};
	__property TScripterNotifyEvent BeforeExecute = {read=FBeforeExecute, write=FBeforeExecute};
	__property Atscript::TScriptErrorEvent OnCompileError = {read=FOnCompileError, write=FOnCompileError};
	__property Classes::TNotifyEvent OnDebugHook = {read=FOnDebugHook, write=FOnDebugHook};
	__property Athtmlparse::TDirectiveEvent OnDirective = {read=FOnDirective, write=FOnDirective};
	__property Atscript::TExecuteEventProc OnExecuteEvent = {read=FOnExecuteEvent, write=FOnExecuteEvent};
	__property TScripterNotifyEvent OnInitScripter = {read=FOnInitScripter, write=FOnInitScripter};
	__property Atscript::TSetEventProc OnSetEvent = {read=FOnSetEvent, write=FOnSetEvent};
	__property Atscript::TSettingEventProc OnSettingEvent = {read=FOnSettingEvent, write=FOnSettingEvent};
	__property Atscript::TUnsetEventProc OnUnsettingEvent = {read=FOnUnsettingEvent, write=FOnUnsettingEvent};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Atwebscripter */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atwebscripter;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtwebscripterHPP
