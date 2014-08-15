// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advcodelistlib.pas' rev: 21.00

#ifndef AdvcodelistlibHPP
#define AdvcodelistlibHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Advmemo.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advcodelistlib
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall ExtractURL(System::UnicodeString s, Classes::TStringList* &urls);
extern PACKAGE void __fastcall DrawCustomLine(Graphics::TCanvas* ACanvas, System::UnicodeString Caption, Advmemo::TStyle &style, Advmemo::TDrawMode DM, const Types::TRect &PR, Advmemo::TAdvCustomMemoStyler* InternalStyles, System::UnicodeString Delimiters, System::UnicodeString NoStart, System::UnicodeString NoHex, System::UnicodeString tmpNo);

}	/* namespace Advcodelistlib */
using namespace Advcodelistlib;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvcodelistlibHPP
