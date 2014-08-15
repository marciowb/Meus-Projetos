// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gthtmleng.pas' rev: 21.00

#ifndef GthtmlengHPP
#define GthtmlengHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Gtexhtmleng.hpp>	// Pascal unit
#include <Gtcsthtmleng.hpp>	// Pascal unit
#include <Gtcstplneng.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gthtmleng
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtHTMLEngine;
class PASCALIMPLEMENTATION TgtHTMLEngine : public Gtexhtmleng::TgtExHTMLEngine
{
	typedef Gtexhtmleng::TgtExHTMLEngine inherited;
	
public:
	/* TgtExHTMLEngine.Create */ inline __fastcall virtual TgtHTMLEngine(Classes::TComponent* AOwner) : Gtexhtmleng::TgtExHTMLEngine(AOwner) { }
	/* TgtExHTMLEngine.Destroy */ inline __fastcall virtual ~TgtHTMLEngine(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gthtmleng */
using namespace Gthtmleng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GthtmlengHPP
