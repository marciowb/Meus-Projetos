// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ebase64.pas' rev: 21.00

#ifndef Ebase64HPP
#define Ebase64HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ebase64
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE unsigned __fastcall CalcEncodedSize(unsigned InSize);
extern PACKAGE unsigned __fastcall CalcDecodedSize(const void *InBuffer, unsigned InSize);
extern PACKAGE void __fastcall Base64Encode(const void *InBuffer, unsigned InSize, void *OutBuffer);
extern PACKAGE void __fastcall Base64Decode(const void *InBuffer, unsigned InSize, void *OutBuffer);
extern PACKAGE System::AnsiString __fastcall Base64EncodeString(const System::AnsiString InText);
extern PACKAGE System::AnsiString __fastcall Base64DecodeString(const System::AnsiString InText);
extern PACKAGE System::AnsiString __fastcall Base64EncodeToString(const void *InBuffer, unsigned InSize);

}	/* namespace Ebase64 */
using namespace Ebase64;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ebase64HPP
