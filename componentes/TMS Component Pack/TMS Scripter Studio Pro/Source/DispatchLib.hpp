// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'DispatchLib.pas' rev: 22.00

#ifndef DispatchlibHPP
#define DispatchlibHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <ActiveX.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <ComObj.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dispatchlib
{
//-- type declarations -------------------------------------------------------
typedef int DISPATCHKIND;

//-- var, const, procedure ---------------------------------------------------
static const System::ShortInt DISPATCH_METHOD = 0x1;
static const System::ShortInt DISPATCH_PROPERTYGET = 0x2;
static const System::ShortInt DISPATCH_PROPERTYPUT = 0x4;
static const System::ShortInt DISPATCH_PROPERTYPUTREF = 0x8;
extern PACKAGE System::OleVariant __fastcall DispatchInvoke(_di_IDispatch obj, System::UnicodeString DispatchName, int InvokeMethod, int ParamCount, System::OleVariant &ParamArray);
extern PACKAGE System::OleVariant __fastcall DispatchInvokeEx(_di_IDispatch obj, int DispatchId, int InvokeMethod, int ParamCount, System::OleVariant &ParamArray);

}	/* namespace Dispatchlib */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Dispatchlib;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DispatchlibHPP
