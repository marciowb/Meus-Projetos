// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Eencrypt.pas' rev: 21.00

#ifndef EencryptHPP
#define EencryptHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Eencrypt
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall InitKey(const System::AnsiString Key);
extern PACKAGE void __fastcall Encrypt(const void *InData, void *Outdata, unsigned Size);
extern PACKAGE void __fastcall Decrypt(const void *InData, void *Outdata, unsigned Size);

}	/* namespace Eencrypt */
using namespace Eencrypt;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EencryptHPP
