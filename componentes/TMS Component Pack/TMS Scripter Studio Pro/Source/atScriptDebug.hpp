// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atScriptDebug.pas' rev: 22.00

#ifndef AtscriptdebugHPP
#define AtscriptdebugHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <atScriptDebugForm.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit
#include <atPascal.hpp>	// Pascal unit
#include <atBasic.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atscriptdebug
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatScriptDebugger;
class PASCALIMPLEMENTATION TatScriptDebugger : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Atscript::TatCustomScripter* FScripter;
	bool FUpdateSourceCode;
	System::UnicodeString FRoutineName;
	bool FMemoReadOnly;
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	
public:
	__fastcall virtual TatScriptDebugger(Classes::TComponent* AOwner);
	void __fastcall Execute(void);
	
__published:
	__property Atscript::TatCustomScripter* Scripter = {read=FScripter, write=FScripter};
	__property System::UnicodeString RoutineName = {read=FRoutineName, write=FRoutineName};
	__property bool UpdateSourceCode = {read=FUpdateSourceCode, write=FUpdateSourceCode, nodefault};
	__property bool MemoReadOnly = {read=FMemoReadOnly, write=FMemoReadOnly, nodefault};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TatScriptDebugger(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Atscriptdebug */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atscriptdebug;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtscriptdebugHPP
