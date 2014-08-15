// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Alxpvs.pas' rev: 21.00

#ifndef AlxpvsHPP
#define AlxpvsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Alxpvs
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE unsigned __stdcall (*OpenThemeData)(unsigned hwnd, System::WideChar * pszClassList);
extern PACKAGE unsigned __stdcall (*CloseThemeData)(unsigned hTheme);
extern PACKAGE unsigned __stdcall (*DrawThemeBackground)(unsigned hTheme, HDC hdc, int iPartId, int iStateId, const Types::PRect pRect, const Types::PRect pClipRect);
extern PACKAGE BOOL __stdcall (*IsThemeActive)(void);

}	/* namespace Alxpvs */
using namespace Alxpvs;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AlxpvsHPP
