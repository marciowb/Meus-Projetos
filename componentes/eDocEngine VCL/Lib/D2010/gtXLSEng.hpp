// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtxlseng.pas' rev: 21.00

#ifndef GtxlsengHPP
#define GtxlsengHPP

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
#include <Gtexxlseng.hpp>	// Pascal unit
#include <Gtcstxlseng.hpp>	// Pascal unit
#include <Gtcstspdeng.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtxlseng
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtExcelEngine;
class PASCALIMPLEMENTATION TgtExcelEngine : public Gtexxlseng::TgtExExcelEngine
{
	typedef Gtexxlseng::TgtExExcelEngine inherited;
	
public:
	/* TgtCustomExcelEngine.Create */ inline __fastcall virtual TgtExcelEngine(Classes::TComponent* AOwner) : Gtexxlseng::TgtExExcelEngine(AOwner) { }
	/* TgtCustomExcelEngine.Destroy */ inline __fastcall virtual ~TgtExcelEngine(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtxlseng */
using namespace Gtxlseng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtxlsengHPP
