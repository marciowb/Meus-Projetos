// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FormScript.pas' rev: 22.00

#ifndef FormscriptHPP
#define FormscriptHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <atPascal.hpp>	// Pascal unit
#include <atBasic.hpp>	// Pascal unit
#include <ap_Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Formscript
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatPascalFormScripter;
class PASCALIMPLEMENTATION TatPascalFormScripter : public Atpascal::TatPascalScripter
{
	typedef Atpascal::TatPascalScripter inherited;
	
private:
	System::UnicodeString FScriptFile;
	Classes::TList* FAdded;
	
protected:
	void __fastcall GetControlCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall GetControls(Atscript::TatVirtualMachine* AMachine);
	void __fastcall Prepare(void);
	void __fastcall AddChildControls(Controls::TWinControl* Control);
	HIDESBASE void __fastcall AddComponents(Classes::TComponent* AOwner);
	void __fastcall SetBold(Atscript::TatVirtualMachine* AMachine);
	void __fastcall SetItalic(void);
	void __fastcall SetUnderline(void);
	
public:
	__fastcall virtual TatPascalFormScripter(Classes::TComponent* AOwner);
	__fastcall virtual ~TatPascalFormScripter(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall BeforeCompile(void);
	virtual void __fastcall BeforeLoadCode(void);
	void __fastcall RegisterConstants(void);
	
__published:
	__property System::UnicodeString ScriptFile = {read=FScriptFile, write=FScriptFile};
};


class DELPHICLASS TatBasicFormScripter;
class PASCALIMPLEMENTATION TatBasicFormScripter : public Atbasic::TatBasicScripter
{
	typedef Atbasic::TatBasicScripter inherited;
	
private:
	System::UnicodeString FScriptFile;
	Classes::TList* FAdded;
	
protected:
	void __fastcall GetControlCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall GetControls(Atscript::TatVirtualMachine* AMachine);
	void __fastcall Prepare(void);
	void __fastcall AddChildControls(Controls::TWinControl* Control);
	HIDESBASE void __fastcall AddComponents(Classes::TComponent* AOwner);
	void __fastcall SetBold(Atscript::TatVirtualMachine* AMachine);
	void __fastcall SetItalic(void);
	void __fastcall SetUnderline(void);
	
public:
	__fastcall virtual TatBasicFormScripter(Classes::TComponent* AOwner);
	__fastcall virtual ~TatBasicFormScripter(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall BeforeCompile(void);
	virtual void __fastcall BeforeLoadCode(void);
	void __fastcall RegisterConstants(void);
	
__published:
	__property System::UnicodeString ScriptFile = {read=FScriptFile, write=FScriptFile};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Formscript */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Formscript;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FormscriptHPP
