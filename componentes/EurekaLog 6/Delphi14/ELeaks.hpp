// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Eleaks.pas' rev: 21.00

#ifndef EleaksHPP
#define EleaksHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Eleaks
{
//-- type declarations -------------------------------------------------------
typedef unsigned TCallStackItem;

typedef StaticArray<unsigned, 35> TRawCallStack;

typedef StaticArray<unsigned, 35> TFramesCallStack;

//-- var, const, procedure ---------------------------------------------------
static const ShortInt RawCallStackLength = 0x23;
static const ShortInt FramesCallStackLength = 0x23;
extern PACKAGE void __fastcall (*OverrunProc)(void);
extern PACKAGE void __fastcall (*MultiFreeProc)(void);
extern PACKAGE void __fastcall (*FinalizationProc)(void);
extern PACKAGE void __fastcall (*ResetLeaks)(void);
extern PACKAGE void __fastcall (*ShowLeaks)(void);
extern PACKAGE void __fastcall (*AddLeak)(const System::AnsiString LeakType, unsigned LeakSize, unsigned LeakCount, unsigned *LeakCallStack);
extern PACKAGE void __fastcall CheckMemoryOverrun(void);
extern PACKAGE bool __fastcall IsAntiLeaksEnabled(void);

}	/* namespace Eleaks */
using namespace Eleaks;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EleaksHPP
