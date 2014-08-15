// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuflxnumberformat.pas' rev: 21.00

#ifndef TmsuflxnumberformatHPP
#define TmsuflxnumberformatHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuflxnumberformat
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::UnicodeString __fastcall XlsFormatValue [[deprecated("Use XlsFormatValue1904 instead.")]](const System::Variant &V, const System::UnicodeString Format, int &Color);
extern PACKAGE System::UnicodeString __fastcall XlsFormatValue1904(const System::Variant &V, const System::UnicodeString Format, const bool Dates1904, int &Color);
extern PACKAGE bool __fastcall HasXlsDateTime(const System::UnicodeString Format, /* out */ bool &HasDate, /* out */ bool &HasTime);

}	/* namespace Tmsuflxnumberformat */
using namespace Tmsuflxnumberformat;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuflxnumberformatHPP
