// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ehash.pas' rev: 21.00

#ifndef EhashHPP
#define EhashHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ehash
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE unsigned __fastcall GetCRC32(void * Buf, unsigned Size);
extern PACKAGE System::Word __fastcall GetCRC16(const System::AnsiString Src);
extern PACKAGE void __fastcall GetMD5(void *Digest, const void *Buffer, unsigned Size);

}	/* namespace Ehash */
using namespace Ehash;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EhashHPP
