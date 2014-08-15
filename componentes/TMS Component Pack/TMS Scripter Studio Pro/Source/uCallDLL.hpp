// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'uCallDLL.pas' rev: 22.00

#ifndef UcalldllHPP
#define UcalldllHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ucalldll
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TCallingConvention { ccStdCall, ccRegister, ccPascal, ccCDecl, ccSafeCall };
#pragma option pop

typedef System::DynamicArray<System::TVarRec> openarray;

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::Variant __fastcall CallDllFunction(System::UnicodeString AFile, System::UnicodeString AFunction, openarray AArgs, openarray AArgTypes, int AReturnType = 0x0, TCallingConvention ACalling = (TCallingConvention)(0x0));

}	/* namespace Ucalldll */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Ucalldll;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UcalldllHPP
