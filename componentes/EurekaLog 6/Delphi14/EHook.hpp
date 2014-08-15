// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ehook.pas' rev: 21.00

#ifndef EhookHPP
#define EhookHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ehook
{
//-- type declarations -------------------------------------------------------
typedef unsigned THandle;

typedef void * *PPointer;

typedef System::ShortInt *PShortInt;

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void * __fastcall HookVirtualMethod(System::TClass AClass, int Index, void * Method);
extern PACKAGE bool __fastcall UnhookVirtualMethod(System::TClass AClass, int Index);
extern PACKAGE void __fastcall JumpToMem(void * Addr, void * Jump);
extern PACKAGE bool __fastcall GetAsmSize(void * Start, System::Byte &Size);
extern PACKAGE unsigned __fastcall GetFunctionSize(unsigned Addr, unsigned MaxSize);
extern PACKAGE void * __fastcall HookProcedureEx(void * ProcAddr, void * NewProc, System::AnsiString ProcName);
extern PACKAGE bool __fastcall UnhookProcedure(void * ProcAddr);
extern PACKAGE bool __fastcall TryHookDllProcedureEx(System::AnsiString *ImportModules, const int ImportModules_Size, System::AnsiString ExportModule, System::AnsiString ProcName, void * NewProc, void * &CallProc, bool CanFail);
extern PACKAGE void * __fastcall HookDllProcedureEx(System::AnsiString ImportModule, System::AnsiString ExportModule, System::AnsiString ProcName, void * NewProc);

}	/* namespace Ehook */
using namespace Ehook;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EhookHPP
