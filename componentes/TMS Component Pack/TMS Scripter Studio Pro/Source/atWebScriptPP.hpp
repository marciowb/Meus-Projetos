// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atWebScriptPP.pas' rev: 22.00

#ifndef AtwebscriptppHPP
#define AtwebscriptppHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <HTTPProd.hpp>	// Pascal unit
#include <atWebScripter.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit
#include <atPascal.hpp>	// Pascal unit
#include <atBasic.hpp>	// Pascal unit
#include <atHTMLParse.hpp>	// Pascal unit
#include <HTTPApp.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atwebscriptpp
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatPageProducer;
class PASCALIMPLEMENTATION TatPageProducer : public Httpprod::TCustomPageProducer
{
	typedef Httpprod::TCustomPageProducer inherited;
	
private:
	Atwebscripter::TatWebScripter* FWebScripter;
	Athtmlparse::TAfterPreCompileEvent __fastcall GetAfterPreCompile(void);
	Athtmlparse::TatLanguage __fastcall GetLanguage(void);
	Atscript::TScriptErrorEvent __fastcall GetOnCompileError(void);
	Classes::TNotifyEvent __fastcall GetOnDebugHook(void);
	Athtmlparse::TDirectiveEvent __fastcall GetOnDirective(void);
	Atscript::TExecuteEventProc __fastcall GetOnExecuteEvent(void);
	Atwebscripter::TScripterNotifyEvent __fastcall GetOnInitScripter(void);
	Atscript::TSetEventProc __fastcall GetOnSetEvent(void);
	Atscript::TSettingEventProc __fastcall GetOnSettingEvent(void);
	Atscript::TUnsetEventProc __fastcall GetOnUnsettingEvent(void);
	void __fastcall SetAfterPreCompile(const Athtmlparse::TAfterPreCompileEvent Value);
	void __fastcall SetLanguage(const Athtmlparse::TatLanguage Value);
	void __fastcall SetOnCompileError(const Atscript::TScriptErrorEvent Value);
	void __fastcall SetOnDebugHook(const Classes::TNotifyEvent Value);
	void __fastcall SetOnDirective(const Athtmlparse::TDirectiveEvent Value);
	void __fastcall SetOnExecuteEvent(const Atscript::TExecuteEventProc Value);
	void __fastcall SetOnInitScripter(const Atwebscripter::TScripterNotifyEvent Value);
	void __fastcall SetOnSetEvent(const Atscript::TSetEventProc Value);
	void __fastcall SetOnSettingEvent(const Atscript::TSettingEventProc Value);
	void __fastcall SetOnUnsettingEvent(const Atscript::TUnsetEventProc Value);
	Atwebscripter::TScripterNotifyEvent __fastcall GetAfterCompile(void);
	void __fastcall SetAfterCompile(const Atwebscripter::TScripterNotifyEvent Value);
	Atwebscripter::TScripterNotifyEvent __fastcall GetAfterExecute(void);
	Atwebscripter::TScripterNotifyEvent __fastcall GetBeforeExecute(void);
	void __fastcall SetAfterExecute(const Atwebscripter::TScripterNotifyEvent Value);
	void __fastcall SetBeforeExecute(const Atwebscripter::TScripterNotifyEvent Value);
	
public:
	__fastcall virtual TatPageProducer(Classes::TComponent* AOwner);
	__fastcall virtual ~TatPageProducer(void);
	virtual System::UnicodeString __fastcall ContentFromStream(Classes::TStream* Stream);
	__property Atwebscripter::TatWebScripter* WebScripter = {read=FWebScripter};
	
__published:
	__property HTMLDoc;
	__property HTMLFile;
	__property Athtmlparse::TatLanguage Language = {read=GetLanguage, write=SetLanguage, nodefault};
	__property Athtmlparse::TAfterPreCompileEvent AfterPreCompile = {read=GetAfterPreCompile, write=SetAfterPreCompile};
	__property Atwebscripter::TScripterNotifyEvent AfterCompile = {read=GetAfterCompile, write=SetAfterCompile};
	__property Atwebscripter::TScripterNotifyEvent AfterExecute = {read=GetAfterExecute, write=SetAfterExecute};
	__property Atwebscripter::TScripterNotifyEvent BeforeExecute = {read=GetBeforeExecute, write=SetBeforeExecute};
	__property Atscript::TScriptErrorEvent OnCompileError = {read=GetOnCompileError, write=SetOnCompileError};
	__property Classes::TNotifyEvent OnDebugHook = {read=GetOnDebugHook, write=SetOnDebugHook};
	__property Athtmlparse::TDirectiveEvent OnDirective = {read=GetOnDirective, write=SetOnDirective};
	__property Atscript::TExecuteEventProc OnExecuteEvent = {read=GetOnExecuteEvent, write=SetOnExecuteEvent};
	__property Atwebscripter::TScripterNotifyEvent OnInitScripter = {read=GetOnInitScripter, write=SetOnInitScripter};
	__property Atscript::TSetEventProc OnSetEvent = {read=GetOnSetEvent, write=SetOnSetEvent};
	__property Atscript::TSettingEventProc OnSettingEvent = {read=GetOnSettingEvent, write=SetOnSettingEvent};
	__property Atscript::TUnsetEventProc OnUnsettingEvent = {read=GetOnUnsettingEvent, write=SetOnUnsettingEvent};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Atwebscriptpp */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atwebscriptpp;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtwebscriptppHPP
