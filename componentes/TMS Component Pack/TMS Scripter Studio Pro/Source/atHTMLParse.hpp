// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atHTMLParse.pas' rev: 22.00

#ifndef AthtmlparseHPP
#define AthtmlparseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Athtmlparse
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TatLanguage { alPascal, alBasic };
#pragma option pop

typedef void __fastcall (__closure *TAfterPreCompileEvent)(System::TObject* Sender, TatLanguage ALanguage, Classes::TStrings* PreCompiledCode);

typedef void __fastcall (__closure *TDirectiveEvent)(System::TObject* Sender, const System::UnicodeString ADirective, System::UnicodeString &AReplace);

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall ParseWebScript(Classes::TStream* AInStream, Classes::TStrings* AOutCode, TatLanguage &ALanguage, bool &AOptionExplicit, System::TObject* Sender = (System::TObject*)(0x0), TDirectiveEvent ADirProc = 0x0);

}	/* namespace Athtmlparse */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Athtmlparse;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AthtmlparseHPP
