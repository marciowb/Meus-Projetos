// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlsbaselist.pas' rev: 11.00

#ifndef UxlsbaselistHPP
#define UxlsbaselistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlsbaselist
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TBaseList;
class PASCALIMPLEMENTATION TBaseList : public Contnrs::TObjectList 
{
	typedef Contnrs::TObjectList inherited;
	
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TBaseList(void)/* overload */ : Contnrs::TObjectList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TBaseList(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlsbaselist */
using namespace Uxlsbaselist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uxlsbaselist
